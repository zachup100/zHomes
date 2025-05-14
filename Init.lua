PluginManager = cPluginManager
RootDir =  "Plugins/zHomes"
HomesDir =  ("%s/homes"):format(RootDir)
PluginVersion = "1.0"

function Initialize(Plugin)
    _debug_out("Init.lua file was called")
    _debug_out("RootDir Path:", RootDir)
    _debug_out("HomesDir Path:", HomesDir)
    local _Modules =  ("%s/modules"):format(RootDir)
    local _Commands =  ("%s/commands"):format(RootDir)
    _debug_out("_Modules Path:", _Modules)
    _debug_out("_Commands Path:", _Commands)

    --// Basic plugin registration
    Plugin:SetName("zHomes") --// Plugin Name
    Plugin:SetVersion(1.0) --// API Version
    _output((" | Starting %s (version: %s)..."):format(Plugin:GetName(), PluginVersion))
    _output(" | Made with 💗. (Author: zachup100)")
    _debug_out("API Version:", Plugin:GetVersion())

    --// Load Modules
    _LoadLuaFile(("%s/json.lua"):format(_Modules), true)
    _LoadLuaFile(("%s/HomeManager.lua"):format(_Modules), true)
    _LoadLuaFile(("%s/CooldownManager.lua"):format(_Modules), true)
    _output("Loaded Modules")

    --// Load and Bind Commands
    _LoadLuaFile(("%s/teleport.lua"):format(_Commands), false)
    _LoadLuaFile(("%s/sethome.lua"):format(_Commands), false)
    _LoadLuaFile(("%s/delhome.lua"):format(_Commands), false)
    _LoadLuaFile(("%s/homes.lua"):format(_Commands), false)

    --// Register and bind commands
    PluginManager.BindCommand(
        ("/%s"):format(_Language["zhomes.sethome.command"]),
        PluginPermissions["sethome"],
        _player_sethome,
        _Language["zhomes.sethome.description"]
    )

    PluginManager.BindCommand(
        ("/%s"):format(_Language["zhomes.homes.command"]),
        PluginPermissions["listhomes"],
        _player_homes,
        _Language["zhomes.homes.description"]
    )

    PluginManager.BindCommand(
        ("/%s"):format(_Language["zhomes.delhome.command"]),
        PluginPermissions["delhome"],
        _player_delhome,
        _Language["zhomes.delhome.description"]
    )

    PluginManager.BindCommand(
        ("/%s"):format(_Language["zhomes.teleport.command"]),
        PluginPermissions["teleport"],
        _player_home_teleport,
        _Language["zhomes.teleport.description"]
    )

    _output("Commands Registered")
    _output("Plugin has started!")
    return true
end

--//
--// PLEASE DO NOT EDIT ANYTHING UNDER HERE UNLESS YOU KNOW WHAT YOU ARE DOING
--// Comments are left for myself, and as well so others can understand and learn!
--//

--// A safe-way of calling/loading a Lua File that isn't present in the root directory.
--// Cuberite only seems to load .lua files if they're in the root directory
function _LoadLuaFile(file, disableOnFail)
    local Success, Result = pcall(dofile, file)
    if not Success then
        _debug_out(("An error occured while loading file '%s', returned: %s"):format(file, tostring(Result)))
        if disableOnFail then error(("Failed to load file '%s', disabling plugin!"):format(file)) end
        return false
    end
    return true
end

--// Allows more than one argument when displaying console messages through LOG()
function _output(...) LOG(_console_format({...})) end
function _warn(...) LOGINFO("[WARN] " .. _console_format({...})) end
function _error(...) LOGWARN("[ERROR] " .. _console_format({...})) end
function _debug_out(...)
    if PluginSettings["debugger"] then
        LOG("[DEBUG] " .. _console_format({...}))
    end
end

--// Unpackages table inputs into strings that is readable to the console
function _console_format(input)
    local out = ""
    for _, obj in pairs(input) do out = out .. tostring(obj) .. " " end 
    return out
end