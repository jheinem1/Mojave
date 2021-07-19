import { ClientFactionInfo, RoleInfo } from "shared/factions/faction_data_interfaces";
import FactionRemotes from "shared/factions/faction_remotes";
import { generateShortName } from "shared/factions/utility_functions";

/**
 * Stores information about a role in a client's faction
 */
class ClientRole {
    name: string
    id: number
    faction: ClientFaction
    constructor(roleInfo: RoleInfo, faction: ClientFaction) {
        this.name = roleInfo.name;
        this.id = roleInfo.id;
        this.faction = faction;
    }
    /**
     * Checks if a client has the given role (ClientRoles are assosciated with a faction)
     */
    hasRole() {
        return this.faction.clientRole === this;
    }
}

/**
 * Stores information on a faction and the client's role in a faction
 */
export class ClientFaction {
    name: string;
    shortName: string;
    groupId: number;
    roles: ClientRole[];
    color: BrickColor;
    clientRole?: ClientRole;
    uniformTop?: number;
    uniformBottom?: number;
    constructor(factionInfo: ClientFactionInfo) {
        this.name = factionInfo.name;
        this.shortName = generateShortName(factionInfo.name);
        this.groupId = factionInfo.groupId;
        this.roles = factionInfo.roles.map(roleInfo => new ClientRole(roleInfo, this));
        this.color = factionInfo.color;
        this.clientRole = this.roles.find(role => factionInfo.clientRole === role.id);
        this.uniformTop = factionInfo.uniformTop
        this.uniformBottom = factionInfo.uniformBottom;
    }
    /**
     * Gets the `ClientRole` of the client in the faction
     */
    getRole() {
        return this.clientRole;
    }
}

let clientFactionInfo: ClientFaction[] | undefined;

/**
 * Gets a list of the factions a client is in asynchronously
 * @param update whether or not the client's faction list should be updated (otherwise it returns a cached version)
 * @returns a list of the client's factions
 */
export async function getClientFactionInfo(update?: boolean) {
    if (update || !clientFactionInfo) {
        const clientData = FactionRemotes.Client.WaitFor("GetClientInfo").andThen(remote => remote.CallServerAsync());
        clientFactionInfo = (await clientData).factions.map(factionInfo => new ClientFaction(factionInfo));
    }
    return clientFactionInfo
}