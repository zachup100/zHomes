HomeManager = {}

local function UpdateFile(PlayerUUID, Data)
    local FileNameFormat = ("%s/%s.json"):format(HomesDir, PlayerUUID)
    _debug_out(("Updating file %s"):format(FileNameFormat))
    local Success, File = pcall(io.open, FileNameFormat, "w")
    if not Success then
        _debug_out(("[HM:UF:1] Unknown error occured: %s"):format(tostring(File)))
        return
    end
    File:write(json.encode(Data))
    File:close()
    return true
end

local function ReadFile(PlayerUUID)
    local FileNameFormat = ("%s/%s.json"):format(HomesDir, PlayerUUID)
    _debug_out(("Reading file %s"):format(FileNameFormat))
    local Success, File = pcall(io.open, FileNameFormat, "rb")
    if not Success then
        _debug_out(("[HM:RF:1] Unknown error occured: %s"):format(tostring(File)))
        return
    end
    if not File then
        _debug_out(("Could not find '%s', creating a new one..."):format(FileNameFormat))
        Success, File = pcall(io.open, FileNameFormat, "w")
        if not Success then
            _debug_out(("[HM:RF:2] Unknown error occured: %s"):format(tostring(File)))
            return
        end
        File:write("[]")
        File:close()
        Success, File = pcall(io.open, FileNameFormat, "rb")
        if not Success then
            _debug_out(("[HM:RF:3] Unknown error occured: %s"):format(tostring(File)))
            return
        end
        _debug_out(("Successfully created file '%s'"):format(FileNameFormat))
    end
    local Data = json.decode(File:read("*all"))
    File:close()
    return Data
end

function  HomeManager.SaveHome(PlayerUUID, HomeName, World, Position, Pitch, Yaw)
    _debug_out(("Attempting to SaveHome '%s' for UUID (%s)"):format(HomeName, PlayerUUID))
    local Homes = ReadFile(PlayerUUID)
    Homes[HomeName] = {
        World = World,
        Position = {x=Position.x, y=Position.y, z=Position.z, pitch=Pitch, yaw=Yaw}
    }

    UpdateFile(PlayerUUID, Homes)
    return true
end

function HomeManager.RemoveHome(PlayerUUID, HomeName)
    _debug_out(("Attempting to RemoveHome '%s' for UUID (%s)"):format(HomeName, PlayerUUID))
    local Homes = ReadFile(PlayerUUID)
    Homes[HomeName] = nil
    UpdateFile(PlayerUUID, Homes)
    return true
end

function HomeManager.GetHomes(PlayerUUID)
    _debug_out(("Attempting to GetHomes for UUID (%s)"):format(PlayerUUID))
    local Homes = ReadFile(PlayerUUID)
    local List = {}
    for Home in pairs(Homes) do table.insert(List, Home) end
    return List
end

function HomeManager.HomeExists(PlayerUUID, HomeName)
    _debug_out(("Validating home '%s' for UUID (%s)"):format(HomeName, PlayerUUID))
    local Homes = ReadFile(PlayerUUID)
    return type(Homes[HomeName]) == "table"
end

function HomeManager.Teleport(Player, HomeName)
    _debug_out(("Teleporting '%s' to home '%s'"):format(Player:GetName(), HomeName))
    local Homes = ReadFile(Player:GetUUID())
    local Location = Homes[HomeName]
    local CurrentWorld = Player:GetWorld()
    local World = cRoot:Get():GetWorld(Location.World)
    if not World then
        _debug_out(("World no longer exists (%s)"):format(Location.World))
        return
    end
    Player:SetInvulnerableTicks(PluginSettings["invulnerable"])
    if CurrentWorld ~= World then
        _debug_out(("Player '%s' was not in the same world, calling MoveToWorld()"):format(Player:GetName(), HomeName))
        Player:MoveToWorld(World, Vector3d(Location.Position.x, Location.Position.y, Location.Position.z))
    else
        _debug_out(("Player '%s' is in the same world, calling TeleportToCoords()"):format(Player:GetName(), HomeName))
        Player:TeleportToCoords(Location.Position.x, Location.Position.y, Location.Position.z)
    end
    Player:SetPitch(Location.Position.pitch)
    Player:SetYaw(Location.Position.yaw)
    _debug_out(("Teleport processed for '%s'"):format(Player:GetName()))
end