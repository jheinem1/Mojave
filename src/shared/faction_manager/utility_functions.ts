import { t } from "@rbxts/t";

// const usedColors = new Array<number>();
// const isBrickColor = t.union(t.valueOf())

//** NOT IMPLEMENTED */
export function assignColor(color: string): BrickColor {
    return new BrickColor(1);
}

/** NOT IMPLEMENTED */
export function generateShortName(name: string): string {
    return name;
}

export function cleanGroupName(name: string) {
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