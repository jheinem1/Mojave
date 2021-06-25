import { Workspace, ReplicatedStorage, Lighting } from "@rbxts/services";
import { t } from "@rbxts/t";
import { ClientRegions } from "shared/regions";

const lightingRegions = Workspace.FindFirstChild("LightRegions") ?? ReplicatedStorage.FindFirstChild("LightRegions");
assert(lightingRegions, "A folder in the workspace/Replicated name 'LightRegions' is required");
const lightingRegionsParts = lightingRegions.GetChildren();
assert(t.array(t.instanceIsA("BasePart"))(lightingRegionsParts), "Children of 'LightRegions' must be BaseParts");
const regions = new ClientRegions(lightingRegionsParts);

regions.enteredRegion.Connect((_, part) => {
    print(`entered region ${tostring(part)}`)
    const effects = part?.FindFirstChild("Effects")?.GetChildren();
    const properties = part?.FindFirstChild("Properties")?.GetChildren();
    if (effects) {
        Lighting.ClearAllChildren();
        print(effects)
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
                    print("bad")
                }
            }
        });
    }
});