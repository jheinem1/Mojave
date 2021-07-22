interface factionData {
    uniformTop?: number;
    uniformBottom?: number;
    shortName?: string;
    color?: BrickColor;
}

export const hardCodedFactionData = new Map<number, factionData>([
    // ncr
    [2800507, {
        uniformTop: 7108288630,
        uniformBottom: 7108289590,
        shortName: "NCR"
    }],
    // children of atom
    [8445132, {
        uniformTop: 6994913416,
        uniformBottom: 6994917017
    }],
    // legion
    [11560910, {
        uniformTop: 4858065274,
        uniformBottom: 4858068618
    }],
    // kings
    [11203944, {
        uniformTop: 7070067198,
        uniformBottom: 6984524578
    }],
    // powder gangers
    [11496015, {
        uniformTop: 1048868771,
        uniformBottom: 1048808474
    }],
    // desert rangers
    [11563786, {
        uniformTop: 7129368797,
        uniformBottom: 7129370236
    }]
]);