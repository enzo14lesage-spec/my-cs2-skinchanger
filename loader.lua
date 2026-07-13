-- ============================================================
--  🎯 MY CS2 SKIN CHANGER LOADER
--  Version: 1.0.0
--  Made by: [Your Name]
--  Features: Skin Changer | Custom Models | Vote Revealer
-- ============================================================

local loader = {
    name        = "MyCS2SkinChanger",
    version     = "1.0.0",
    author      = "YourName",
    repository  = "https://raw.githubusercontent.com/enzo14lesage-spec/my-cs2-skinchanger/main/",
    cachePath   = ".\\my_skinchanger_cache\\",
    
    config = {
        autoUpdate  = true,
        useCache    = true,
        debugMode   = false
    }
}

-- ============================================================
--  COLOR CODES
-- ============================================================
local colors = {
    reset   = "\x01",
    red     = "\x02",
    green   = "\x03",
    yellow  = "\x04",
    blue    = "\x05",
    purple  = "\x06",
    cyan    = "\x07",
    white   = "\x08"
}

-- ============================================================
--  LOGGING SYSTEM
-- ============================================================
function loader:log(msg, type)
    local prefix = ""
    local color = colors.white
    
    if type == "error" then
        prefix = colors.red .. "[✘]"
        color = colors.red
    elseif type == "success" then
        prefix = colors.green .. "[✓]"
        color = colors.green
    elseif type == "warning" then
        prefix = colors.yellow .. "[⚠]"
        color = colors.yellow
    elseif type == "info" then
        prefix = colors.cyan .. "[i]"
        color = colors.cyan
    elseif type == "debug" then
        prefix = colors.purple .. "[D]"
        color = colors.purple
    else
        prefix = colors.blue .. "[•]"
        color = colors.blue
    end
    
    print(string.format("%s %s %s%s", prefix, colors.white, color, msg))
end

function loader:header()
    print("")
    print(colors.cyan .. "╔═══════════════════════════════════════════════════╗")
    print(colors.cyan .. "║" .. colors.white .. "  🎯 " .. self.name .. " v" .. self.version .. colors.cyan .. "                    ║")
    print(colors.cyan .. "║" .. colors.white .. "  👤 " .. self.author .. colors.cyan .. "                                          ║")
    print(colors.cyan .. "╚═══════════════════════════════════════════════════╝")
    print("")
end

-- ============================================================
--  CACHE SYSTEM
-- ============================================================
function loader:createCacheDir()
    local success, err = pcall(function()
        local cmd = string.format('!mkdir "%s"', self.cachePath)
        executeCommand(cmd)
    end)
    
    if not success then
        self:log("Could not create cache directory: " .. tostring(err), "warning")
    end
    return success
end

-- ============================================================
--  FETCH SYSTEM (GitHub)
-- ============================================================
function loader:fetchFile(filename)
    local url = self.repository .. filename
    local cacheFile = self.cachePath .. filename
    
    -- Try to fetch from server
    local src, err = pcall(function()
        return http.Get(url .. "?nocache=" .. os.time())
    end)
    
    if src and type(src) == "string" and #src > 500 then
        if self.config.useCache then
            pcall(function()
                local f = file.Open(cacheFile, "w")
                if f then
                    f:Write(src)
                    f:Close()
                    self:log("Cached: " .. filename, "debug")
                end
            end)
        end
        self:log("Loaded from server: " .. filename, "success")
        return src, "server"
    end
    
    -- Fallback to cache
    if self.config.useCache then
        local cached, err = pcall(function()
            local f = file.Open(cacheFile, "r")
            if f then
                local data = f:Read()
                f:Close()
                return data
            end
        end)
        
        if cached and type(cached) == "string" and #cached > 500 then
            self:log("Loaded from cache: " .. filename, "success")
            return cached, "cache"
        end
    end
    
    self:log("Failed to load: " .. filename, "error")
    return nil, nil
end

-- ============================================================
--  UPDATE CHECKER
-- ============================================================
function loader:checkUpdate()
    if not self.config.autoUpdate then
        return false
    end
    
    local versionFile, err = self:fetchFile("version.txt")
    if versionFile then
        local remoteVersion = versionFile:match("%d+%.%d+%.%d+")
        if remoteVersion and remoteVersion ~= self.version then
            self:log("Update available: " .. remoteVersion .. " (current: " .. self.version .. ")", "success")
            return true
        end
    end
    return false
end

-- ============================================================
--  MAIN LOAD FUNCTION
-- ============================================================
function loader:load()
    self:header()
    self:log("Starting loader v" .. self.version, "info")
    self:log("Author: " .. self.author, "info")
    
    -- Create cache directory
    self:createCacheDir()
    
    -- Check for updates
    if self:checkUpdate() then
        self:log("Updating to latest version...", "info")
    end
    
    -- Load main script
    local mainSrc, source = self:fetchFile("skincore.lua")
    if not mainSrc then
        self:log("FATAL: Cannot load skincore.lua", "error")
        return false
    end
    
    -- Compile script
    local chunk, err = loadstring(mainSrc, "=skincore.lua")
    if not chunk then
        self:log("Compile error: " .. tostring(err), "error")
        return false
    end
    
    -- Set up environment
    local env = {
        print = print,
        executeCommand = executeCommand,
        http = http,
        file = file,
        _G = _G,
        LOADER_INFO = {
            name = self.name,
            version = self.version,
            author = self.author,
            cachePath = self.cachePath
        }
    }
    setfenv(chunk, env)
    
    -- Run the script
    local success, err = pcall(chunk)
    if not success then
        self:log("Runtime error: " .. tostring(err), "error")
        return false
    end
    
    self:log("✅ " .. self.name .. " loaded successfully!", "success")
    self:log("🎮 Open menu with: SC:showMenu()", "info")
    self:log("📚 Type: Help() for commands", "info")
    
    return true
end

-- ============================================================
--  COMMANDS
-- ============================================================
function LoadMySkinChanger()
    loader:load()
end

function ReloadMySkinChanger()
    loader:log("Reloading...", "info")
    loader:load()
end

-- ============================================================
--  AUTO-LOAD (Uncomment to auto-load)
-- ============================================================
-- loader:load()

-- ============================================================
--  BANNER
-- ============================================================
loader:header()
print(colors.green .. "  ✅ Loader ready! Type: LoadMySkinChanger()")
print(colors.yellow .. "  ⚠️  Use only in private matches!")
print(colors.cyan .. "  📚 Commands will be available after loading.")
print("")
print(colors.white .. "  ───────────────────────────────────────────")
print(colors.white .. "  " .. colors.cyan .. "📂" .. colors.white .. "  GitHub: " .. colors.blue .. loader.repository)
print(colors.white .. "  " .. colors.green .. "📦" .. colors.white .. "  Version: " .. colors.yellow .. loader.version)
print(colors.white .. "  " .. colors.purple .. "👤" .. colors.white .. "  Author: " .. colors.cyan .. loader.author)
print("")
print(colors.cyan .. "╔═══════════════════════════════════════════════════╗")
print(colors.cyan .. "║" .. colors.yellow .. "  💡 Type: LoadMySkinChanger() to start" .. colors.cyan .. "        ║")
print(colors.cyan .. "╚═══════════════════════════════════════════════════╝")
print("")
