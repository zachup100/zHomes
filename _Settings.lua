PluginSettings = {
    ["max_homes"] = 3, -- (Default: 1)
    --// How many homes are allowed per player!

    ["debugger"] = false, -- (Default: false)
    --// Useful to see how the plugin operates and view more specific output/errors
    --// when the plugin is running.

    ["home_regex"] = "^[a-zA-Z0-9_]+$", -- (Default: ^[a-zA-Z0-9_]+$)
    --// Here you can define a regex to see if a home name is valid.
    --// If you're an english speaking person, or hosting a server with english speakers,
    --// this will do fine outside the box.
    --// Otherwise you may have to modify this a bit to allow more characters.
    --// Here is an example of this current regex in action:
    --// https://regex101.com/r/i9DZN9/1

    ["invulnerable"] = 40, -- (Default: 40)
    --// How long in ticks should the player not take any damage while teleporting.
    --// 20 ticks = 1 second

    ["cooldown_time"] = 3, -- (Default: 3)
    --// How long does a player have to wait to run a command again

    ["cooldown_mode"] = "per_command", -- (Default: per_command)
    --// ACCEPTED VALUES: ( global | per_command )
    --// If set to global, all zHomes commands will have the same cooldown time.
    --// If set to per_command, zHomes commands will have their own cooldown time.

}

PluginPermissions = {
    ["sethome"] = "zhomes.sethome",
    --// Access to /sethome <home>

    ["delhome"] = "zhomes.delhome",
    --// Access to /delhome <home>

    ["listhomes"] = "zhomes.list",
    --// Access to /homes

    ["teleport"] = "zhomes.home",
    --// Access to /home <home>

    ["bypass"] = "zhomes.bypass",
    --// Allows the player to have more than the max home count (max_homes)

    ["no_cooldown"] = "zhomes.cooldown"
    --// Allows the player to bypass the cooldown for any command
}