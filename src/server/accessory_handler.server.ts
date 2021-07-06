import { CollectionService, Debris, InsertService, MarketplaceService, Players, ReplicatedStorage } from "@rbxts/services";
import Remotes from "shared/remotes";

const remote = Remotes.Server.Create("GetAccessory");

remote.Connect((player, id) => {
    try {
        const productInfo = MarketplaceService.GetProductInfo(id, Enum.InfoType.Asset);
        switch (productInfo.AssetTypeId) {
            case (Enum.AssetType.HairAccessory.Value):
            case (Enum.AssetType.FaceAccessory.Value):
            case (Enum.AssetType.NeckAccessory.Value):
            case (Enum.AssetType.ShoulderAccessory.Value):
            case (Enum.AssetType.FrontAccessory.Value):
            case (Enum.AssetType.BackAccessory.Value):
            case (Enum.AssetType.WaistAccessory.Value):
            case (Enum.AssetType.EarAccessory.Value): {
                const asset = InsertService.LoadAsset(id);
                asset.Parent = player;
                Debris.AddItem(asset);
            }
        }
    } catch {
        warn(`Failed to load asset '${id}' for ${player}'`)
        return undefined;
    }
});