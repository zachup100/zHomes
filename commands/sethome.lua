function _player_sethome(Split, Player)
    if #Split == 1 then
        Player:SendMessage(("%s%s"):format(
            _Language["zhomes.prefix"],
            (_Language["zhomes.sethome.usage"])
        ))
        return true
    elseif #Split > 2 then
        Player:SendMessage(("%s%s\n&r%s"):format(
            _Language["zhomes.prefix"], 
            (_Language["zhomes.too_many_arguments"]):gsub("{0}", "1"):gsub("{1}", #Split-1),
            (_Language["zhomes.sethome.usage"])
        ))
        return true
    end

    local UUID = Player:GetUUID()

    if not Player:HasPermission(PluginPermissions["no_cooldown"]) then
        local ActiveCooldown, TimeLeft = Cooldown.IsActive(UUID, "sethome")
        if ActiveCooldown then
            Player:SendMessage(("%s%s"):format(
                _Language["zhomes.prefix"], 
                (_Language["zhomes.on_cooldown"]):gsub("{0}", TimeLeft)
            ))
            return true
        end

        Cooldown.Set(UUID, "sethome", PluginSettings["cooldown_time"])
    end

    local Homes = HomeManager.GetHomes(UUID)
    local HomeName = string.match(Split[2], PluginSettings["home_regex"])

    if #Homes >= PluginSettings["max_homes"] and not Player:HasPermission(PluginPermissions["bypass"]) and not HomeManager.HomeExists(UUID, HomeName) then
        _debug_out(("Player '%s' attempted to make a new home but is at %s"):format(Player:GetName(), #Homes))
        Player:SendMessage(("%s%s"):format(
            _Language["zhomes.prefix"], 
            (_Language["zhomes.sethome.maxed"]):gsub("{0}", PluginSettings["max_homes"])
        ))
        return true
    end
    local World, Position, Pitch, Yaw = Player:GetWorld():GetName(), Player:GetPosition(), Player:GetPitch(), Player:GetHeadYaw()

    if type(HomeName) ~= "string" then
        _debug_out(("Player '%s' attempted to make a new home with an invalid name! '%s'"):format(Player:GetName(), Split[2]))
        Player:SendMessage(("%s%s"):format(
            _Language["zhomes.prefix"], 
            _Language["zhomes.sethome.invalid_name"]
        ))
        return true
    end

    local Success = HomeManager.SaveHome(UUID, HomeName, World, Position, Pitch, Yaw)

    if Success then
        Player:SendMessage(("%s%s"):format(
            _Language["zhomes.prefix"], 
            (_Language["zhomes.sethome.success"]):gsub("{0}", HomeName)
        ))
    end
    return true
end