import Net from "@rbxts/net";

const Remotes = Net.Definitions.Create({
    InSafezone: Net.Definitions.BidirectionalEvent<[inSafezone: boolean]>()
});
export default Remotes;