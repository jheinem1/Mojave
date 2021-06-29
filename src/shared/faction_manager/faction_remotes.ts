import Net from "@rbxts/net"
import { ClientInfo } from "./faction_data_interfaces";

const FactionRemotes = Net.Definitions.Create({
    GetClientInfo: Net.Definitions.ServerFunction<() => ClientInfo>(),
});
export default FactionRemotes;