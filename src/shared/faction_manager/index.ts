import Net from "@rbxts/net";
import { Players, RunService } from "@rbxts/services";
import { t } from "@rbxts/t";
import { ClientFaction, Faction } from "./faction";
import FactionRemotes from "./faction_remotes";

export class FactionManager {

}

interface clientInformation {

}

/**
 * Cannot be called from the client.
 * Gets a list of allied factions.
 */
export function getFactions() {
    if (RunService.IsClient())
        throw "Cannot be called from the client";
}

/**
 * Used for caching player group information on the server.
 * **ONLY ACCESSIBLE FROM THE SERVER**
 */
export function startCaching() {
    if (RunService.IsClient())
        throw "Cannot be called from the client";
    const factions = new Map<number, Faction>();
}

let clientFactionInfo: ClientFaction[] | undefined;

export function getClientFactionInfo(update?: boolean) {
    if (update || !clientFactionInfo) {
        const clientData = FactionRemotes.Client.Get("GetClientInfo").CallServer();
        clientFactionInfo = clientData.factions.map(factionInfo => new ClientFaction(factionInfo));
    }
    return clientFactionInfo
}