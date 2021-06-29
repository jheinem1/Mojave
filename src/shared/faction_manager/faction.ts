import { Players } from "@rbxts/services";
import { ClientFactionInfo, RoleInfo } from "./faction_data_interfaces";
import { assignColor, generateShortName } from "./utility_functions";

/**
 * Stores information on factions and provides speedy alternatives to existing player/groupservice methods
 */
class Role {
    constructor(public name: string, public id: number, public faction: Faction) { }
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
        groupInfo.Roles.map(roleInfo => new Role(roleInfo.Name, roleInfo.Rank, this)).forEach(role => this.roles.set(role.id, role));
        // seems stupid but roblox-ts has an issue (https://github.com/roblox-ts/roblox-ts/issues/1467) 
        this.color = assignColor(tostring(string.match(groupInfo.Description, `Color:%s*["']([%w ]*)["'` + "]")[0]));
        this.shortName = generateShortName(tostring(string.match(groupInfo.Description, `ShortName:%s*["']([%a ]*)["'` + "]")[0] ?? this.name));
        this.uniformTop = tonumber(string.match(groupInfo.Description, `UniformTop:%s*["']([%d]*)["'` + "]")[0]);
        this.uniformBottom = tonumber(string.match(groupInfo.Description, `UniformBottom:%s*["']([%d]*)["'` + "]")[0]);
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

class ClientRole {
    name: string
    id: number
    faction: ClientFaction
    constructor(roleInfo: RoleInfo, faction: ClientFaction) {
        this.name = roleInfo.name;
        this.id = roleInfo.id;
        this.faction = faction;
    }
    hasRole() {
        return this.faction.clientRole === this;
    }
}

export class ClientFaction {
    groupId: number;
    roles: ClientRole[];
    color: BrickColor;
    shortName: string;
    clientRole?: ClientRole;
    uniformTop?: number;
    uniformBottom?: number;
    constructor(factionInfo: ClientFactionInfo) {
        this.groupId = factionInfo.groupId;
        this.roles = factionInfo.roles.map(roleInfo => new ClientRole(roleInfo, this));
        this.color = factionInfo.color;
        this.shortName = factionInfo.shortName;
        this.clientRole = this.roles.find(role => factionInfo.clientRole === role.id);
        this.uniformTop = factionInfo.uniformTop'
        this.uniformBottom = factionInfo.uniformBottom;
    }
    getRole() {
        return this.clientRole;
    }
}