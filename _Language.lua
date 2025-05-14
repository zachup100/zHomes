_Language = {
    --// General Messages
    ["zhomes.prefix"] = "&8[&azHomes&8]&r ",
    ["zhomes.too_many_arguments"] = "&7Too many arguments! (expected: {0}, found: {1})",
    ["zhomes.on_cooldown"] = "You must wait {0} second(s) before you can run that command!",

    --// Command Messages
    ["zhomes.teleport.command"] = "home",
    ["zhomes.teleport.description"] = "- &aTeleport to your home",
    ["zhomes.teleport.success"] = "&aYou were teleported to '&e{0}&a'!",
    ["zhomes.teleport.no_home"] = "&7You don't have a home set named '&e{0}&7'",
    ["zhomes.teleport.usage"] = "&4Usage: &c/home <home>",

    ["zhomes.sethome.command"] = "sethome",
    ["zhomes.sethome.success"] = "&aYou set your home '&e{0}&a' to your current location!",
    ["zhomes.sethome.description"] = "- &aSet your current location as your home",
    ["zhomes.sethome.invalid_name"] = "&cThat is not a valid home name!",
    ["zhomes.sethome.maxed"] = "&cYou cannot have more than &4{0} &chomes set!",
    ["zhomes.sethome.usage"] = "&4Usage: &c/sethome <home>",

    ["zhomes.delhome.command"] = "delhome",
    ["zhomes.delhome.success"] = "&cYou deleted a home named '&e{0}&c'!",
    ["zhomes.delhome.description"] = "- &aDelete a previously set home",
    ["zhomes.delhome.missing"] = "&7You do not have a home named '&e{0}&7' set!",
    ["zhomes.delhome.usage"] = "&4Usage: &c/delhome <home>",

    ["zhomes.homes.command"] = "homes",
    ["zhomes.homes.list"] = "&eHomes &7({0})&f: {1}",
    ["zhomes.homes.description"] = "- &aView all of your homes that you have set",
    ["zhomes.homes.format"] = "&a{0}&7, ",
    --// For the homes format, it needs at least two dummy characters at the end.
    --// My code will remove the last two characters in the format so the last comma doesn't appear.
    --// Also, give this format a try! It turns it from a horizontal list to a vertical one!
    --// Vertical List: "\n&a - {0}  "
}