export interface ClientFactionInfo {
    name: string;
    groupId: number;
    roles: RoleInfo[];
    color: BrickColor;
    shortName: string;
    uniformTop?: number;
    uniformBottom?: number;
    clientRole: number;
}

export interface RoleInfo {
    name: string;
    id: number;
    faction: number;
}

export interface ClientInfo {
    factions: ClientFactionInfo[];
}