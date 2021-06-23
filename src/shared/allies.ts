import { GroupService, ServerScriptService } from "@rbxts/services";
import { t } from "@rbxts/t";

class Allies {
    private static allies: GroupInfo[];

    static refresh() {
        const newAllies = new Array<GroupInfo>();
        const allyPages = GroupService.GetAlliesAsync(4978642);
        while (true) {
            allyPages.GetCurrentPage().forEach((group) => {
                group.Name = this.cleanGroupName(group.Name);
                newAllies.push(group);
            });
            if (allyPages.IsFinished) {
                this.allies = newAllies;
                return;
            } else
                allyPages.AdvanceToNextPageAsync();
        }
    }

    static cleanGroupName(name: string) {
        const outArray = new Array<string>();
        let i = 1;
        let char = name.sub(i, i);
        while (char !== "") {
            if (char === " " || char.match("%a")[0])
                outArray.push(char);
            i++;
            char = name.sub(i, i);
        }
        const outStr = outArray.join("");
        return outStr.match("^%s*(%a+[%a%s]*%a+)%s*$")[0] as string | undefined ?? outStr.match("^%s*(%a+)%s*$")[0] as string | undefined ?? "Invalid Group Name!";
    }

    static getAllies() {
        if (!this.allies)
            Allies.refresh();
        return this.allies;
    }
}

const refreshEvent = ServerScriptService.FindFirstChild("Server")?.FindFirstChild("onjoin")?.FindFirstChild("reloadteams");
if (t.instanceOf("BindableEvent")(refreshEvent))
    refreshEvent.Event.Connect(() => Allies.refresh());

export default Allies;