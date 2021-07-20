import { Players } from "@rbxts/services";
import { Handler } from "shared/handler";

/**
 * Kicks players who are less then 7 days old
 */
export class AgeHandler extends Handler {
    name = "Age";
    run() {
        Players.PlayerAdded.Connect(player => {
            if (player.AccountAge < 7)
                player.Kick("Your account must be at least a week old in order to play!");
        });
    }
}