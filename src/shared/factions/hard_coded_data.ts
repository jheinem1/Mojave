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
    }],
    [8445132, {
        uniformTop: 6994913416,
        uniformBottom: 6994917017
    }],
    [4858065274, {
        uniformTop: 4858065295,
        uniformBottom: 4858068618
    }],
    [11203944, {
        uniformTop: 7070067198,
        uniformBottom: 6984524578
    }]
]);