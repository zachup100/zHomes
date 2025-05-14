function _reload_plugin(Split, Player)
    PluginManager:Get():ReloadPlugin("zHomes")
    Player:SendMessage(("%s%s"):format(
        _Language["zhomes.prefix"],
        (_Language["zhomes.reloaded"]):gsub("{0}", PluginVersion)
    ))
    return true
end