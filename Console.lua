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