-- ============================================================
--  MY CS2 SKIN CHANGER LOADER
--  Version: 1.0.0
--  Made by: enzo14lesage-spec
--  Repository: https://github.com/enzo14lesage-spec/my-cs2-skinchanger
-- ============================================================

local loader = {
    name        = "MyCS2SkinChanger",
    version     = "1.0.0",
    author      = "enzo14lesage-spec",
    repository  = "https://raw.githubusercontent.com/enzo14lesage-spec/my-cs2-skinchanger/main/",
    cachePath   = ".\\my_skinchanger_cache\\",
    
    config = {
        autoUpdate  = true,
        useCache    = true,
        debugMode   = false
    }
}

-- ============================================================
--  LOGGING SYSTEM
-- ============================================================
function loader:log(msg, type)
    local prefix = ""
    if type == "error" then
        prefix = "[ERROR] "
    elseif type == "success" then
        prefix = "[OK] "
    elseif type == "warning" then
        prefix = "[WARN] "
    elseif type == "info" then
        prefix = "[INFO] "
    else
        prefix = "[loader] "
    end
    print(prefix .. msg)
end

function loader:header()
    print("")
    print("========================================")
    print("  MY CS2 SKIN CHANGER LOADER v" .. self.version)
    print("  Author: " .. self.author)
    print("========================================")
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
    local src = nil
    pcall(function()
        src = http.Get(url .. "?nocache=" .. os.time())
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
        local cached = nil
        pcall(function()
            local f = file.Open(cacheFile, "r")
            if f then
                cached = f:Read()
                f:Close()
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
            self:log("Update available: " .. remoteVersion .. " (current: " .. self.version .. ")", "info")
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
    
    self:log("Skin changer loaded successfully!", "success")
    self:log("Type: Help() for commands", "info")
    self:log("Type: SC:showMenu() for menu", "info")
    
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
print("  Loader ready! Type: LoadMySkinChanger()")
print("")
print("========================================")
