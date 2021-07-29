import { Players, GroupService, RunService } from "@rbxts/services";
import { t } from "@rbxts/t";
import { ClientFactionInfo, RoleInfo } from "shared/factions/faction_data_interfaces";
import FactionRemotes from "shared/factions/faction_remotes";
import { hardCodedFactionData } from "shared/factions/hard_coded_data";
import { generateShortName, groupId, cleanGroupName } from "shared/factions/utility_functions";

const clientInfo = new Array<ClientFactionInfo>();
const clientSpecificInfo = new Map<Player, ClientFactionInfo[]>();
let cachingConnections: Array<RBXScriptConnection>;
let factions: Map<number, Faction>;

/**
 * Stores information on factions and provides speedy alternatives to existing player/groupservice methods
 */
export class Role {
    name: string;
    id: number;
    constructor(roleInfo: GroupInfo["Roles"][0], public faction: Faction) {
        this.name = roleInfo.Name;
        this.id = roleInfo.Rank;
    }
    hasRole(player: Player) {
        return this.faction.getRole(player) === this;
    }
}

/**
 * Stores information on factions and provides speedy alternatives to existing player/groupservice methods
 */
export class Faction {
    name: string;
    groupId: number;
    emblem: string;
    players = new Map<Player, Role>();
    roles = new Map<number, Role>();
    shortName: string;
    uniformTop?: number;
    uniformBottom?: number;
    team?: Team;
    constructor(public groupInfo: GroupInfo, public color: BrickColor) {
        this.name = groupInfo.Name;
        this.groupId = groupInfo.Id;
        this.emblem = groupInfo.EmblemUrl;
        groupInfo.Roles.map(roleInfo => new Role(roleInfo, this)).forEach(role => this.roles.set(role.id, role));
        this.shortName = hardCodedFactionData.get(this.groupId)?.shortName ?? generateShortName(tostring(string.match(groupInfo.Description, `ShortName:%s*["']([%a]*)["']`)[0] ?? this.name));
        this.uniformTop = tonumber(string.match(groupInfo.Description, `UniformTop:%s*["']([^"']*)["']`)[0]) ?? hardCodedFactionData.get(this.groupId)?.uniformTop;
        this.uniformBottom = tonumber(string.match(groupInfo.Description, `UniformBottom:%s*["']([^"']*)["']`)[0]) ?? hardCodedFactionData.get(this.groupId)?.uniformBottom;
        Players.PlayerAdded.Connect(player => this.onPlayer(player));
        Players.GetPlayers().forEach(player => this.onPlayer(player));
    }
    /** Runs whenever a player joins or for every player in the game when the faction is initialized */
    private onPlayer(player: Player) {
        const rank = this.getRoleUncached(player);
        if (rank)
            this.players.set(player, rank);
    }
    /**
     * Primarily for internal use, slower version of `getRole` that still returns a role object.
     * Please don't use this method.
     */
    getRoleUncached(player: Player) {
        return this.roles.get(player.GetRankInGroup(this.groupId));
    }
    /** Checks if a player is a member of a faction. */
    isInFaction(player: Player) {
        return RunService.IsStudio() ? true : this.players.has(player);
    }
    /**
     * Gets the `Role` object corresponding to the player's role in the faction. Returns undefined/nil if player is not in faction.
     */
    getRole(player: Player) {
        return RunService.IsStudio() ? next(this.roles) : this.players.get(player);
    }
}

/** Gets a list of allied factions
 *  Also updates client factions
 */
export function getFactions(update?: boolean) {
    if (update || !factions) {
        const newAllies = new Array<GroupInfo>();
        const allyPages = GroupService.GetAlliesAsync(groupId);
        while (true) {
            allyPages.GetCurrentPage().forEach((group) => {
                group.Name = cleanGroupName(group.Name);
                newAllies.push(group);
            });
            if (allyPages.IsFinished)
                break;
            else
                allyPages.AdvanceToNextPageAsync();
        }
        factions = new Map<number, Faction>();
        const usedColors = new Map<number, boolean>([[194, true]]);
        const getColor = () => {
            for (let i = 1; i <= 1032; i++) {
                const color = new BrickColor(i);
                if (!usedColors.get(color.Number)) {
                    usedColors.set(color.Number, true);
                    return color;
                }
            }
            throw "Out of colors!";
        }
        newAllies.filter(group => {
            const color = hardCodedFactionData.get(group.Id)?.color
            if (color) {
                factions.set(group.Id, new Faction(group, color));
                return false;
            }
            return true;
        })
            .filter(group => {
                const colorNameOrId = string.match(group.Description, `Color:%s*["'“]([%w ]*)["'“]`)[0];
                const color = t.string(colorNameOrId) && tonumber(colorNameOrId) ? new BrickColor(tonumber(colorNameOrId) as number) : new BrickColor(t.string(colorNameOrId) ? colorNameOrId as "Medium stone grey" : "Medium stone grey");
                if (!usedColors.get(color.Number)) {
                    factions.set(group.Id, new Faction(group, color));
                    usedColors.set(hardCodedFactionData.get(group.Id)?.color?.Number ?? color.Number, true);
                    return false;
                }
                return true;
            })
            .forEach(group => factions.set(group.Id, new Faction(group, getColor())));
        getClientInfo(undefined, true);
    }
    return factions;
}

function getClientInfo(player?: Player, update?: boolean) {
    if (update || !clientInfo) {
        clientInfo.clear();
        factions.forEach(faction => {
            const roles = new Array<RoleInfo>();
            faction.roles.forEach(role => roles.push({
                name: role.name,
                id: role.id,
            }));
            clientInfo.push({
                name: faction.name,
                shortName: faction.shortName === generateShortName(faction.name) ? undefined : faction.shortName,
                groupId: faction.groupId,
                roles: roles,
                color: faction.color,
                clientRole: -1,
                uniformTop: faction.uniformTop,
                uniformBottom: faction.uniformBottom
            });
        });
    }
    const existingInfo = player ? clientSpecificInfo.get(player) : undefined;
    if (player && existingInfo && !update)
        return existingInfo;
    else if (player) {
        const info = clientInfo.map(clientFaction => {
            clientFaction.clientRole = player.GetRankInGroup(clientFaction.groupId);
            return clientFaction;
        });
        clientSpecificInfo.set(player, info);
        return info;
    }
    return clientInfo;
}

/**
 * Used for caching player group information on the server.
 * Generally only for internal use.
 */
export function startCaching() {
    quitCaching();
    cachingConnections = new Array<RBXScriptConnection>();
    const factionRemote = FactionRemotes.Server.Create("GetFactions");
    const factions = getFactions(true);
    cachingConnections.push(Players.PlayerAdded.Connect(player => factions.forEach(faction => {
        const role = faction.roles.get(player.GetRankInGroup(faction.groupId));
        if (role)
            faction.players.set(player, role);
    })));
    factionRemote.SetCallback(player => getClientInfo(player));
}

/**
 * Stops caching player information.
 * Generally for internal use.
 */
export function quitCaching() {
    if (cachingConnections)
        cachingConnections.forEach(connection => connection.Disconnect());
}