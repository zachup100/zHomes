function _player_homes(_, Player)
    local UUID = Player:GetUUID()

    if not Player:HasPermission(PluginPermissions["no_cooldown"]) then
        local ActiveCooldown, TimeLeft = Cooldown.IsActive(UUID, "homes")
        if ActiveCooldown then
            Player:SendMessage(("%s%s"):format(
                _Language["zhomes.prefix"], 
                (_Language["zhomes.on_cooldown"]):gsub("{0}", TimeLeft)
            ))
            return true
        end
        
        Cooldown.Set(UUID, "homes", PluginSettings["cooldown_time"])
    end

    local Homes = HomeManager.GetHomes(Player:GetUUID())
    local Formatted = ""

    for _, Home in pairs(Homes) do
        Formatted = Formatted .. (_Language["zhomes.homes.format"]):gsub("{0}", Home)
    end

    Formatted = string.sub(Formatted, 1, string.len(Formatted)-2)
    
    local List = (_Language["zhomes.homes.list"]):gsub("{0}", #Homes):gsub("{1}", Formatted)
    Player:SendMessage(List)
    return true
end