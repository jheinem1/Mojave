const usedColors = new Map<number, boolean>();

export function assignColor(color?: string): BrickColor {
    throw "Function not implemented";
}

export function generateShortName(existingShortName?: string): string {
    throw "Function not implemented";
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