import { Players, RunService } from "@rbxts/services";

/**
 * Used for managing spawn cooldowns on the client & server.
 */
export default class SpawnCooldownManager {
    static spawnCooldownSecs = 60;
    static lastSpawnAtPoint = new Map<Player, Map<string, number> | undefined>();
    /**
     * Determines whether or not the player can spawn at a point.
     * Accounts for some delay on the client.
     */
    static canSpawn(player: Player, pointName: string) {
        if (RunService.IsClient())
            return this.getCooldownSecsRemaining(player, pointName) < 0;
        return this.getCooldownSecsRemaining(player, pointName) <= 0;
    }
    /**
     * Gets the (int) seconds remaining for a player to be able to spawn.
     * Returns -1 by default if player has not spawned before
     */
    static getCooldownSecsRemaining(player: Player, pointName: string) {
        const lastSpawnTime = this.lastSpawnAtPoint.get(player)?.get(pointName);
        return lastSpawnTime ? this.spawnCooldownSecs - (os.time() - lastSpawnTime) : -1;
    }
    /**
     * Logs a player spawning at point `pointName`.
     */
    static logSpawn(player: Player, pointName: string) {
        const lastSpawnAtPoint = this.lastSpawnAtPoint;
        let spawnLogs = lastSpawnAtPoint.get(player)
        if (spawnLogs)
            spawnLogs.set(pointName, os.time());
        else {
            spawnLogs = new Map<string, number>([[pointName, os.time()]]);
            lastSpawnAtPoint.set(player, spawnLogs);
            Players.PlayerRemoving.Connect(p => {
                if (p === player)
                    lastSpawnAtPoint.set(player, undefined);
            });
        }
    }
}