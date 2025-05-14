Cooldown = {}

--// Create a new cooldown timer for a player
function Cooldown.Set(UUID, Identifier, Seconds)
    _debug_out(("Created a cooldown timer for '%s' (%s) lasting '%s' seconds."):format(UUID, Identifier, Seconds))
    if PluginSettings["cooldown_mode"] == "global" then Identifier = "global" end
    if not Cooldown[UUID] then Cooldown[UUID] = {} end
    Cooldown[UUID][Identifier] = os.time() + Seconds
    Cooldown[UUID]["_last_active"] = os.time()
    return true
end

--// Check if a specific cooldown is currently active for a player
function Cooldown.IsActive(UUID, Identifier)
    if PluginSettings["cooldown_mode"] == "global" then Identifier = "global" end
    if not Cooldown[UUID] then return false end
    if not Cooldown[UUID][Identifier] then return false end
    if Cooldown[UUID][Identifier] > os.time() then
        return true, (Cooldown[UUID][Identifier] - os.time())
    end
    Cooldown.Remove(UUID, Identifier)
    return false
end

--// Removes a specific cooldown for a player
function Cooldown.Remove(UUID, Identifier)
    _debug_out(("Removing a cooldown timer for '%s' (%s)"):format(UUID, Identifier))
    if PluginSettings["cooldown_mode"] == "global" then Identifier = "global" end
    if not Cooldown[UUID] then return true end
    if not Cooldown[UUID][Identifier] then return true end
    Cooldown[UUID][Identifier] = nil
    return true
end

--// Removes all current active cooldowns for a player (currently unused right now)
--// Thought about using it for when the player leaves the game, but that makes it
--// so they can avoid cooldowns all-together.
function Cooldown.RemoveAll(UUID)
    _debug_out(("Removing all cooldown timer for '%s'"):format(UUID))
    if not Cooldown[UUID] then return true end
    Cooldown[UUID] = nil
    return true
end

--// Method of cleaning out the cooldown table in hopes to not overload on memory.
local function check_cooldown_table()
    _debug_out("Checking cooldown table for inactive player cooldowns")
    for UUID, Data in pairs(Cooldown) do
        if type(Data) == "table" then
            local LastActive = Data._last_active
            if (os.time() - LastActive) > 30 then
                Cooldown.RemoveAll(UUID)
                _debug_out(("Removed cooldown data for '%s'"):format(UUID))
            end
        end
    end
end

PluginManager:AddHook(PluginManager.HOOK_PLAYER_JOINED, check_cooldown_table)