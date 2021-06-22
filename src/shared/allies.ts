import { GroupService } from "@rbxts/services";

// interface Group {
//     Name: string;
//     Id: number;
//     Owner: User;
//     EmblemUrl: string;
//     Description: string;
//     Roles: Role[];
// }

// interface Role {
//     Name: string;
//     Rank: number;
// }

// interface User {
//     Name: string;
//     Id: number;
// }

class Allies {
    static allies: GroupInfo[];

    static refresh() {
        Allies.allies = new Array<GroupInfo>();
        const allyPages = GroupService.GetAlliesAsync(4978642);
        while (true) {
            allyPages.GetCurrentPage().forEach((group) => {
                group.Name = this.cleanGroupName(group.Name);
                Allies.allies.push(group);
            });
            if (allyPages.IsFinished)
                return Allies.allies;
            else
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
        print(outStr)
        return outStr.match("^%s*(%a+[%a%s]*%a+)%s*$")[0] as string | undefined ?? outStr.match("^%s*(%a+)%s*$")[0] as string | undefined ?? "Invalid Group Name!";
    }
}
Allies.refresh();
export default Allies;