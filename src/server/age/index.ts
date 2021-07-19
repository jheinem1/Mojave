import { Players } from "@rbxts/services";
import { Handler } from "shared/handler";

export class AgeHandler extends Handler {
    run() {
        Players.PlayerAdded.Connect(player => {
            if (player.AccountAge < 7)
                player.Kick("Your account must be at least a week old in order to play!");
        });
    }
}