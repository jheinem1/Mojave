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
            allyPages.GetCurrentPage().forEach((group) => Allies.allies.push(group));
            if (allyPages.IsFinished)
                return Allies.allies;
            else
                allyPages.AdvanceToNextPageAsync();
        }
    }
}
Allies.refresh();
export default Allies;