import Net from "@rbxts/net";
import { GroupService, Players, RunService } from "@rbxts/services";
import { t } from "@rbxts/t";
import { ClientFaction, Faction, Role } from "./faction";
import { ClientFactionInfo, ClientInfo, RoleInfo } from "./faction_data_interfaces";
import FactionRemotes from "./faction_remotes";
import { cleanGroupName } from "./utility_functions";

const clientInfo = RunService.IsServer() ? new Map<Player, ClientInfo>() : undefined;
let cachingConnections: Array<RBXScriptConnection>;
let factions: Map<number, Faction>;
const groupId = 4978642;

/**
 * Cannot be called from the client.
 * Gets a list of allied factions.
 */
export function getFactions(update?: boolean) {
    if (RunService.IsClient() || !clientInfo)
        throw "Cannot be called from the client";
    if (update || !factions) {
        const newAllies = new Array<GroupInfo>();
        const allyPages = GroupService.GetAlliesAsync(4978642);
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
 * **ONLY ACCESSIBLE FROM THE SERVER**
 */
export function startCaching() {
    if (RunService.IsClient() || !clientInfo)
        throw "Cannot be called from the client";
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
                faction: faction.groupId
            }))
            clientInfo.get(player)?.factions.push({
                name: faction.name,
                shortName: faction.shortName,
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

export function quitCaching() {
    if (cachingConnections)
        cachingConnections.forEach(connection => connection.Disconnect());
}

let clientFactionInfo: ClientFaction[] | undefined;

export async function getClientFactionInfo(update?: boolean) {
    if (update || !clientFactionInfo) {
        const clientData = FactionRemotes.Client.WaitFor("GetClientInfo").andThen(remote => remote.CallServerAsync());
        clientFactionInfo = (await clientData).factions.map(factionInfo => new ClientFaction(factionInfo));
    }
    return clientFactionInfo
}