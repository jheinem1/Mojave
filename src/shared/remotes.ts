import Net from "@rbxts/net";

const Remotes = Net.Definitions.Create({
    InSafezone: Net.Definitions.BidirectionalEvent<[inSafezone: boolean]>(),
    GetAccessory: Net.Definitions.ClientToServerEvent<[id: number]>()
});
export default Remotes;