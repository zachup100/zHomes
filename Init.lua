PluginManager = cPluginManager
RootDir =  "Plugins/zHomes"
HomesDir =  ("%s/homes"):format(RootDir)
PluginVersion = "1.0"
PluginSource = "https://github.com/zachup100/zHomes"

function Initialize(Plugin)
    _debug_out("Init.lua file was called")
    _debug_out("RootDir Path:", RootDir)
    _debug_out("HomesDir Path:", HomesDir)

    if not cFile:IsFolder(HomesDir) then
        cFile:CreateFolder(HomesDir)
    end

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

    if not cFile:IsFolder(_Modules) then
        _output("It seems that the Modules directory is missing! Please make sure you download the latest version from the Github!")
        _output("Github:", PluginSource)
        error("Missing Modules directory")
    end

    if not cFile:IsFolder(_Commands) then
        _output("It seems that the Commands directory is missing! Please make sure you download the latest version from the Github!")
        _output("Github:", PluginSource)
        error("Missing Commands directory")
    end

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
    _LoadLuaFile(("%s/reload.lua"):format(_Commands), false)

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

    PluginManager.BindCommand(
        "/homereload",
        PluginPermissions["reload"],
        _reload_plugin,
        " - Reloads the zHomes plugin from in-game"
    )

    _output("Commands Registered")
    _output("Plugin has started!")
    return true
end

function OnDisable()
    _warn("zHomes has been disabled!")
end