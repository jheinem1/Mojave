import { ClientFactionInfo, RoleInfo } from "shared/factions/faction_data_interfaces";
import FactionRemotes from "shared/factions/faction_remotes";
import { generateShortName } from "shared/factions/utility_functions";

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
    getRole() {
        return this.clientRole;
    }
}

let clientFactionInfo: ClientFaction[] | undefined;

export async function getClientFactionInfo(update?: boolean) {
    if (update || !clientFactionInfo) {
        const clientData = FactionRemotes.Client.WaitFor("GetClientInfo").andThen(remote => remote.CallServerAsync());
        clientFactionInfo = (await clientData).factions.map(factionInfo => new ClientFaction(factionInfo));
    }
    return clientFactionInfo
}