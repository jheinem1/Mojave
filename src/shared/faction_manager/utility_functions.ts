// const usedColors = new Array<number>();

import { getColor } from "./brick_colors";

/** returns a random color */
export function assignColor(color?: string): BrickColor {
    return getColor(color);
}

/** extracts the first letter of every word in a string */
export function generateShortName(name: string): string {
    const words = name.split(" ");
    const shortName = words.map(word => word.match("%a")[0] ?? "").join("");
    return shortName;
}

/** removes any non-alphanumeric characters from a string */
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