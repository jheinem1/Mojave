import { Players, RunService } from "@rbxts/services";

if (!RunService.IsStudio())
    Players.PlayerAdded.Connect(player => {
        if (player.AccountAge < 7)
            player.Kick("Your account must be at least a week old in order to play!");
    });