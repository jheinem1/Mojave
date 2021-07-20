import { Teams } from "@rbxts/services";
import { getFactions } from "server/factions/faction";

const teams = new Map<number, Team>();

export function generateTeams() {
    Teams.ClearAllChildren();
    teams.clear();

    const wastelanders = new Instance("Team");
    wastelanders.Name = "Wastelanders";
    wastelanders.TeamColor = BrickColor.Gray();
    const wastelandersId = new Instance("NumberValue");
    wastelandersId.Name = "ID";
    wastelandersId.Value = -1;
    wastelandersId.Parent = wastelanders
    wastelanders.Parent = Teams;
    teams.set(-1, wastelanders);

    getFactions().forEach(faction => {
        const team = new Instance("Team");
        team.Name = faction.name;
        team.TeamColor = faction.color;
        const teamId = new Instance("NumberValue");
        teamId.Name = "ID"
        teamId.Value = faction.groupId;
        teamId.Parent = team;
        team.Parent = Teams;
        teams.set(faction.groupId, team);
        faction.team = team;
    });
    return teams;
}

export function getTeams(update?: boolean) {
    if (update || !teams.get(-1))
        return generateTeams();
    return teams;
}