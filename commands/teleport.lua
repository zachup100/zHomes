function _player_home_teleport(Split, Player)
    if #Split == 1 then
        Player:SendMessage(("%s%s"):format(
            _Language["zhomes.prefix"],
            (_Language["zhomes.teleport.usage"])
        ))
        return true
    elseif #Split > 2 then
        Player:SendMessage(("%s%s\n&r%s"):format(
            _Language["zhomes.prefix"], 
            (_Language["zhomes.too_many_arguments"]):gsub("{0}", "1"):gsub("{1}", #Split-1),
            (_Language["zhomes.teleport.usage"])
        ))
        return true
    end
    
    local UUID = Player:GetUUID()

    if not Player:HasPermission(PluginPermissions["no_cooldown"]) then
        local ActiveCooldown, TimeLeft = Cooldown.IsActive(UUID, "teleport")
        if ActiveCooldown then
            Player:SendMessage(("%s%s"):format(
                _Language["zhomes.prefix"], 
                (_Language["zhomes.on_cooldown"]):gsub("{0}", TimeLeft)
            ))
            return true
        end

        Cooldown.Set(UUID, "teleport", PluginSettings["cooldown_time"])
    end
    local HomeName = Split[2]
    if HomeManager.HomeExists(UUID, HomeName) then
        HomeManager.Teleport(Player, HomeName)
        Player:SendMessage(("%s%s"):format(
            _Language["zhomes.prefix"],
            (_Language["zhomes.teleport.success"]):gsub("{0}", HomeName)
        ))
    else
        Player:SendMessage(("%s%s"):format(
            _Language["zhomes.prefix"],
            _Language["zhomes.teleport.no_home"]:gsub("{0}", HomeName)
        ))
    end
    return true
end