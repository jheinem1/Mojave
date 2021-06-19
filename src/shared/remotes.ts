import Net from "@rbxts/net";

const Remotes = Net.Definitions.Create({
    InSafezone: Net.Definitions.ServerToClientEvent<[inSafezone: boolean]>()
});
export default Remotes;