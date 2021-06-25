import { Workspace, ReplicatedStorage, Lighting } from "@rbxts/services";
import { t } from "@rbxts/t";
import { ClientRegions } from "shared/regions";

const lightingRegions = ReplicatedStorage.WaitForChild("LightRegions", 5);
assert(lightingRegions, "A folder in the workspace/Replicated named 'LightRegions' is required");
const lightingRegionsParts = lightingRegions.GetChildren();
assert(t.array(t.instanceIsA("BasePart"))(lightingRegionsParts), "Children of 'LightRegions' must be BaseParts");
const regions = new ClientRegions(lightingRegionsParts);

regions.enteredRegion.Connect((_, part) => {
    const effects = part?.FindFirstChild("Effects")?.GetChildren();
    const properties = part?.FindFirstChild("Properties")?.GetChildren();
    if (effects) {
        Lighting.ClearAllChildren();
        effects.forEach(v => v.Clone().Parent = Lighting);
    }
    if (properties) {
        properties.forEach(prop => {
            if (t.instanceIsA("ValueBase")(prop)) {
                try {
                    //@ts-ignore
                    Lighting[prop.Name] = prop.Value;
                } catch {
                    prop.Destroy();
                }
            }
        });
    }
});