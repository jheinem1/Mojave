import Net from "@rbxts/net"
import { ClientFactionInfo } from "./faction_data_interfaces";

const FactionRemotes = Net.Definitions.Create({
    GetFactions: Net.Definitions.ServerFunction<() => ClientFactionInfo[]>(),
});
export default FactionRemotes;