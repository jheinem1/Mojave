import { Players, GroupService } from "@rbxts/services";
import { ClientFactionInfo, ClientInfo, RoleInfo } from "shared/factions/faction_data_interfaces";
import FactionRemotes from "shared/factions/faction_remotes";
import { assignColor, generateShortName, groupId, cleanGroupName } from "shared/factions/utility_functions";

const clientInfo = new Map<Player, ClientInfo>();
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
    /** Stores all players in the game that are a member of a certain faction */
    name: string;
    groupId: number;
    players = new Map<Player, Role>();
    roles = new Map<number, Role>();
    color: BrickColor;
    shortName: string;
    uniformTop?: number;
    uniformBottom?: number;
    constructor(public groupInfo: GroupInfo) {
        this.name = groupInfo.Name;
        this.groupId = groupInfo.Id;
        groupInfo.Roles.map(roleInfo => new Role(roleInfo, this)).forEach(role => this.roles.set(role.id, role));
        this.color = assignColor(tostring(string.match(groupInfo.Description, `Color:%s*["']([%w ]*)["']`)[0]));
        this.shortName = generateShortName(tostring(string.match(groupInfo.Description, `ShortName:%s*["']([%a ]*)["']`)[0] ?? this.name));
        this.uniformTop = tonumber(string.match(groupInfo.Description, `UniformTop:%s*["']([%d]*)["'` + "]")[0]);
        this.uniformBottom = tonumber(string.match(groupInfo.Description, `UniformBottom:%s*["']([%d]*)["']`)[0]);
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
        return this.players.has(player);
    }
    /**
     * Gets the `Role` object corresponding to the player's role in the faction. Returns undefined/nil if player is not in faction.
     */
    getRole(player: Player) {
        return this.players.get(player);
    }
}

/** Gets a list of allied factions */
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
        newAllies.forEach((group) => factions.set(group.Id, new Faction(group)));
    }
    return factions;
}

/**
 * Used for caching player group information on the server.
 * Generally only for internal use.
 */
export function startCaching() {
    quitCaching();
    cachingConnections = new Array<RBXScriptConnection>();
    const factionRemote = FactionRemotes.Server.Create("GetClientInfo");
    const factions = getFactions(true);
    cachingConnections.push(Players.PlayerAdded.Connect(player => factions.forEach(faction => {
        const role = faction.roles.get(player.GetRankInGroup(faction.groupId));
        if (role)
            faction.players.set(player, role);
    })));
    const onPlayer = (player: Player) => factions.forEach(faction => {
        const rank = player.GetRankInGroup(faction.groupId);
        const role = faction.roles.get(rank);
        if (role) {
            faction.players.set(player, role);
            if (!clientInfo.get(player))
                clientInfo.set(player, { factions: new Array<ClientFactionInfo>() });
            const roles = new Array<RoleInfo>();
            faction.roles.forEach(role => roles.push({
                name: role.name,
                id: role.id,
            }))
            clientInfo.get(player)?.factions.push({
                name: faction.name,
                groupId: faction.groupId,
                roles: roles,
                color: faction.color,
                clientRole: rank
            });
        }
    });
    Players.PlayerAdded.Connect(onPlayer);
    Players.GetPlayers().forEach(onPlayer);
    factionRemote.SetCallback(player => clientInfo.get(player) ?? error(`Client info for player ${player} does not exist`));
}

/**
 * Stops caching player information.
 * Generally for internal use.
 */
export function quitCaching() {
    if (cachingConnections)
        cachingConnections.forEach(connection => connection.Disconnect());
}