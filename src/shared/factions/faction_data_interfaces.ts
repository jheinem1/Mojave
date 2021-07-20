export interface ClientFactionInfo {
    name: string;
    shortName?: string;
    groupId: number;
    roles: RoleInfo[];
    color: BrickColor;
    uniformTop?: number;
    uniformBottom?: number;
    clientRole: number;
}

export interface RoleInfo {
    name: string;
    id: number;
}

export interface Factions {
    factions: ClientFactionInfo[];
}