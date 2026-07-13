-- My CS2 Skin Changer Loader
-- Compatible with Aimware

local function log(msg)
    print("[Loader] " .. msg)
end

log("Loading skin changer...")

-- Download the main script
local url = "https://raw.githubusercontent.com/enzo14lesage-spec/my-cs2-skinchanger/main/skincore.lua"
local src = http.Get(url .. "?t=" .. os.time())

if not src or #src < 100 then
    log("ERROR: Failed to download skincore.lua")
    log("Check: " .. url)
    return
end

log("Downloaded " .. #src .. " bytes")

-- Compile and run
local func, err = loadstring(src)
if not func then
    log("Compile error: " .. tostring(err))
    return
end

log("Compiled successfully!")

-- Run the script with proper environment
local env = {
    print = print,
    http = http,
    file = file,
    executeCommand = executeCommand,
    RegisterEvent = RegisterEvent or function() end,
    _G = _G
}
setfenv(func, env)

local ok, err = pcall(func)
if not ok then
    log("Runtime error: " .. tostring(err))
    return
end

log("Skin changer loaded!")
log("Type: Help() for commands")
