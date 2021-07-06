import Net from "@rbxts/net";

const Remotes = Net.Definitions.Create({
    InSafezone: Net.Definitions.BidirectionalEvent<[inSafezone: boolean]>(),
    GetAccessory: Net.Definitions.ServerFunction<(id: number) => Accessory | undefined>()
});
export default Remotes;