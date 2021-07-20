interface factionData {
    uniformTop?: number;
    uniformBottom?: number;
    shortName?: string;
    color?: BrickColor;
}

export const hardCodedFactionData = new Map<number, factionData>([
    [2800507, {
        uniformTop: 3102602189,
        uniformBottom: 3102618682,
        shortName: "NCR"
    }]
]);