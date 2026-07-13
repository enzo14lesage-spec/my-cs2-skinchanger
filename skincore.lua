-- ============================================================
--  🎯 MY CS2 SKIN CHANGER CORE
--  Version: 1.0.0
--  Features: Skin Changer | Custom Models | Vote Revealer
-- ============================================================

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

local skinChanger = {
    -- ============================================================
    --  WEAPONS DATABASE
    -- ============================================================
    weapons = {
        -- Knives
        ["Bayonet"]       = { id = 42, type = "knife", model = "models/weapons/v_knife_bayonet.mdl" },
        ["Classic Knife"] = { id = 500, type = "knife", model = "models/weapons/v_knife_classic.mdl" },
        ["Flip Knife"]    = { id = 505, type = "knife", model = "models/weapons/v_knife_flip.mdl" },
        ["Gut Knife"]     = { id = 506, type = "knife", model = "models/weapons/v_knife_gut.mdl" },
        ["Karambit"]      = { id = 507, type = "knife", model = "models/weapons/v_knife_karambit.mdl" },
        ["M9 Bayonet"]    = { id = 508, type = "knife", model = "models/weapons/v_knife_m9_bayonet.mdl" },
        ["Huntsman"]      = { id = 509, type = "knife", model = "models/weapons/v_knife_huntsman.mdl" },
        ["Falchion"]      = { id = 512, type = "knife", model = "models/weapons/v_knife_falchion.mdl" },
        ["Bowie Knife"]   = { id = 514, type = "knife", model = "models/weapons/v_knife_bowie.mdl" },
        ["Butterfly"]     = { id = 515, type = "knife", model = "models/weapons/v_knife_butterfly.mdl" },
        ["Shadow Daggers"]= { id = 516, type = "knife", model = "models/weapons/v_knife_shadow_daggers.mdl" },
        ["Paracord"]      = { id = 517, type = "knife", model = "models/weapons/v_knife_paracord.mdl" },
        ["Survival Knife"]= { id = 518, type = "knife", model = "models/weapons/v_knife_survival.mdl" },
        ["Ursus"]         = { id = 519, type = "knife", model = "models/weapons/v_knife_ursus.mdl" },
        ["Navaja"]        = { id = 520, type = "knife", model = "models/weapons/v_knife_navaja.mdl" },
        ["Nomad"]         = { id = 521, type = "knife", model = "models/weapons/v_knife_nomad.mdl" },
        
        -- Pistols
        ["Glock-18"]      = { id = 4, type = "pistol" },
        ["USP-S"]         = { id = 61, type = "pistol" },
        ["P2000"]         = { id = 32, type = "pistol" },
        ["Desert Eagle"]  = { id = 1, type = "pistol" },
        ["R8 Revolver"]   = { id = 64, type = "pistol" },
        ["P250"]          = { id = 36, type = "pistol" },
        ["CZ75-Auto"]     = { id = 63, type = "pistol" },
        ["Dual Berettas"] = { id = 2, type = "pistol" },
        ["Tec-9"]         = { id = 30, type = "pistol" },
        ["Five-SeveN"]    = { id = 3, type = "pistol" },
        
        -- Rifles
        ["AK-47"]         = { id = 7, type = "rifle" },
        ["M4A1-S"]        = { id = 60, type = "rifle" },
        ["M4A4"]          = { id = 16, type = "rifle" },
        ["AWP"]           = { id = 9, type = "sniper" },
        ["SSG 08"]        = { id = 40, type = "sniper" },
        ["SCAR-20"]       = { id = 38, type = "sniper" },
        ["G3SG1"]         = { id = 11, type = "sniper" },
        ["FAMAS"]         = { id = 10, type = "rifle" },
        ["Galil AR"]      = { id = 13, type = "rifle" },
        ["SG 553"]        = { id = 39, type = "rifle" },
        ["AUG"]           = { id = 8, type = "rifle" },
        
        -- SMGs
        ["MP9"]           = { id = 34, type = "smg" },
        ["MP7"]           = { id = 33, type = "smg" },
        ["P90"]           = { id = 19, type = "smg" },
        ["MAC-10"]        = { id = 47, type = "smg" },
        ["MP5-SD"]        = { id = 23, type = "smg" },
        ["UMP-45"]        = { id = 24, type = "smg" },
        ["PP-Bizon"]      = { id = 26, type = "smg" },
        
        -- Shotguns
        ["Nova"]          = { id = 35, type = "shotgun" },
        ["XM1014"]        = { id = 25, type = "shotgun" },
        ["MAG-7"]         = { id = 27, type = "shotgun" },
        ["Sawed-Off"]     = { id = 29, type = "shotgun" },
        
        -- Heavy
        ["M249"]          = { id = 14, type = "heavy" },
        ["Negev"]         = { id = 28, type = "heavy" }
    },
    
    -- ============================================================
    --  SKINS DATABASE
    -- ============================================================
    skins = {
        ["None"]                = { paint = 0, wear = 0.00 },
        ["Dragon Lore"]         = { paint = 10061, wear = 0.05 },
        ["Howl"]                = { paint = 10048, wear = 0.08 },
        ["Medusa"]              = { paint = 10057, wear = 0.06 },
        ["Fire Serpent"]        = { paint = 10058, wear = 0.07 },
        ["Asiimov"]             = { paint = 310, wear = 0.10 },
        ["Redline"]             = { paint = 400, wear = 0.12 },
        ["Bloodsport"]          = { paint = 10052, wear = 0.05 },
        ["Neo-Noir"]            = { paint = 10053, wear = 0.05 },
        ["Printstream"]         = { paint = 10064, wear = 0.00 },
        ["Doppler Phase 1"]     = { paint = 411, wear = 0.00 },
        ["Doppler Phase 2"]     = { paint = 411, wear = 0.00 },
        ["Doppler Phase 3"]     = { paint = 411, wear = 0.00 },
        ["Doppler Phase 4"]     = { paint = 411, wear = 0.00 },
        ["Doppler Ruby"]        = { paint = 411, wear = 0.00 },
        ["Doppler Sapphire"]    = { paint = 411, wear = 0.00 },
        ["Doppler Black Pearl"] = { paint = 411, wear = 0.00 },
        ["Marble Fade"]         = { paint = 413, wear = 0.00 },
        ["Fade"]                = { paint = 38, wear = 0.00 },
        ["Tiger Tooth"]         = { paint = 412, wear = 0.00 },
        ["Gamma Doppler"]       = { paint = 414, wear = 0.00 },
        ["Lore"]                = { paint = 10056, wear = 0.05 },
        ["Autotronic"]          = { paint = 10048, wear = 0.05 },
        ["Black Laminate"]      = { paint = 408, wear = 0.08 },
        ["Blue Steel"]          = { paint = 34, wear = 0.10 },
        ["Boreal Forest"]       = { paint = 43, wear = 0.15 },
        ["Bright Water"]        = { paint = 836, wear = 0.05 },
        ["Case Hardened"]       = { paint = 39, wear = 0.12 },
        ["Crimson Web"]         = { paint = 400, wear = 0.10 },
        ["Damascus Steel"]      = { paint = 409, wear = 0.05 }
    },
    
    -- ============================================================
    --  CUSTOM MODELS (CS2 agents/models folder)
    -- ============================================================
    customModels = {
        -- Default agents
        ["Phoenix Connexion"] = {
            type = "player", faction = "T",
            path = "agents/models/tm_phoenix.vmdl_c",
            desc = "Phoenix Connexion"
        },
        ["Elite Crew"] = {
            type = "player", faction = "T",
            path = "agents/models/tm_leet_variantb.vmdl_c",
            desc = "Elite Crew"
        },
        ["Balkan"] = {
            type = "player", faction = "T",
            path = "agents/models/tm_balkan_variantA.vmdl_c",
            desc = "Balkan"
        },
        ["Pirate"] = {
            type = "player", faction = "T",
            path = "agents/models/tm_pirate.vmdl_c",
            desc = "Pirate"
        },
        ["Anarchist"] = {
            type = "player", faction = "T",
            path = "agents/models/tm_anarchist.vmdl_c",
            desc = "Anarchist"
        },
        ["Professional"] = {
            type = "player", faction = "T",
            path = "agents/models/tm_professional.vmdl_c",
            desc = "Professional"
        },
        ["SAS"] = {
            type = "player", faction = "CT",
            path = "agents/models/ctm_sas.vmdl_c",
            desc = "SAS"
        },
        ["GIGN"] = {
            type = "player", faction = "CT",
            path = "agents/models/ctm_gign.vmdl_c",
            desc = "GIGN"
        },
        ["GSG-9"] = {
            type = "player", faction = "CT",
            path = "agents/models/ctm_gsg9.vmdl_c",
            desc = "GSG-9"
        },
        ["FBI"] = {
            type = "player", faction = "CT",
            path = "agents/models/ctm_fbi.vmdl_c",
            desc = "FBI"
        },
        ["SWAT"] = {
            type = "player", faction = "CT",
            path = "agents/models/ctm_swat.vmdl_c",
            desc = "SWAT"
        },
        ["ST6"] = {
            type = "player", faction = "CT",
            path = "agents/models/ctm_st6.vmdl_c",
            desc = "ST6"
        },
        
        -- Your custom models (place in agents/models/)
        ["My Custom T"] = {
            type = "player", faction = "T",
            path = "agents/models/my_custom_t.vmdl_c",
            desc = "My custom Terrorist"
        },
        ["My Custom CT"] = {
            type = "player", faction = "CT",
            path = "agents/models/my_custom_ct.vmdl_c",
            desc = "My custom Counter-Terrorist"
        },
        
        -- Custom weapons (place in models/weapons/custom/)
        ["Custom Karambit"] = {
            type = "weapon", weapon = "Karambit",
            path = "models/weapons/custom/v_knife_karambit_custom.mdl",
            desc = "Custom Karambit"
        },
        ["Custom Butterfly"] = {
            type = "weapon", weapon = "Butterfly",
            path = "models/weapons/custom/v_knife_butterfly_custom.mdl",
            desc = "Custom Butterfly"
        },
        ["Custom AK"] = {
            type = "weapon", weapon = "AK-47",
            path = "models/weapons/custom/v_rif_ak47_custom.mdl",
            desc = "Custom AK-47"
        },
        ["Custom AWP"] = {
            type = "weapon", weapon = "AWP",
            path = "models/weapons/custom/v_sni_awp_custom.mdl",
            desc = "Custom AWP"
        }
    },
    
    -- ============================================================
    --  STATE
    -- ============================================================
    state = {
        selectedWeapon = nil,
        selectedSkin = "None",
        wear = 0.000,
        seed = 0,
        isActive = false,
        skinHistory = {},
        currentCustomModel = nil,
        currentModelType = nil,
        voteRevealerActive = false
    },
    
    -- ============================================================
    --  CS2 GAME DIRECTORIES
    -- ============================================================
    gameDir = {
        agents  = "agents/models/",
        weapons = "models/weapons/",
        materials = "materials/"
    },
    
    -- ============================================================
    --  PRESETS
    -- ============================================================
    presets = {
        ["🌿 Green"] = {
            ["AK-47"] = "Gamma Doppler",
            ["Desert Eagle"] = "Emerald",
            ["Karambit"] = "Gamma Doppler"
        },
        ["🔴 Red"] = {
            ["AK-47"] = "Redline",
            ["AWP"] = "Dragon Lore",
            ["Butterfly"] = "Ruby"
        },
        ["🔵 Blue"] = {
            ["M4A1-S"] = "Printstream",
            ["USP-S"] = "Blueprint",
            ["Bayonet"] = "Sapphire"
        },
        ["✨ Gold"] = {
            ["AK-47"] = "Gold",
            ["Desert Eagle"] = "Gold",
            ["Karambit"] = "Fade"
        }
    }
}

-- ============================================================
--  LOGGING
-- ============================================================
function skinChanger:log(msg, type)
    local prefix = type == "error" and colors.red .. "[✘]" or
                   type == "success" and colors.green .. "[✓]" or
                   type == "warning" and colors.yellow .. "[⚠]" or
                   type == "info" and colors.cyan .. "[i]" or
                   colors.blue .. "[•]"
    print(string.format("%s %s%s", prefix, colors.white, msg))
end

-- ============================================================
--  EXECUTE COMMAND
-- ============================================================
function skinChanger:execute(cmd)
    if type(executeCommand) == "function" then
        executeCommand(cmd)
    else
        self:log("Cannot execute: " .. cmd, "warning")
    end
end

-- ============================================================
--  SKIN CHANGER
-- ============================================================
function skinChanger:applySkin(weaponName, skinName)
    local weapon = self.weapons[weaponName]
    local skin = self.skins[skinName]
    
    if not weapon then
        self:log("Weapon not found: " .. weaponName, "error")
        return false
    end
    if not skin then
        self:log("Skin not found: " .. skinName, "error")
        return false
    end
    
    self:execute(string.format(
        "skins %d %d %d %.3f %d",
        weapon.id, skin.paint, skin.paint or 0,
        self.state.wear, self.state.seed
    ))
    
    self.state.selectedWeapon = weaponName
    self.state.selectedSkin = skinName
    self.state.isActive = true
    
    self:log(string.format("Applied %s to %s (Wear: %.3f)",
        skinName, weaponName, self.state.wear), "success")
    return true
end

function skinChanger:removeSkin()
    if not self.state.selectedWeapon then
        self:log("No skin active", "warning")
        return false
    end
    local weapon = self.weapons[self.state.selectedWeapon]
    self:execute(string.format("skins %d 0", weapon.id))
    self.state.isActive = false
    self:log("Skin removed from " .. self.state.selectedWeapon, "success")
    return true
end

function skinChanger:resetSkins()
    self:execute("skins 0")
    self.state.selectedWeapon = nil
    self.state.selectedSkin = "None"
    self.state.isActive = false
    self.state.wear = 0.000
    self.state.seed = 0
    self:log("All skins reset", "success")
    return true
end

-- ============================================================
--  CUSTOM MODEL CHANGER (CS2 agents/models support)
-- ============================================================
function skinChanger:applyCustomModel(modelName)
    local model = self.customModels[modelName]
    if not model then
        self:log("Model not found: " .. modelName, "error")
        self:log("Type: ListModels() to see available models", "info")
        return false
    end
    
    if model.type == "player" then
        -- CS2 player model
        self:execute("sv_cheats 1")
        self:execute(string.format("playermodel %s", model.path))
        self:execute(string.format("cl_teamid_model %s", model.path))
        self:execute("sv_force_teamid_model 1")
        self:execute(string.format("sv_force_teamid_model_path %s", model.path))
        
        self.state.currentCustomModel = model.path
        self.state.currentModelType = "player"
        
        self:log(string.format("✅ Applied player model: %s (%s)",
            model.desc or modelName, model.faction or "Unknown"), "success")
        self:log(string.format("📂 Path: %s", model.path), "info")
        
    elseif model.type == "weapon" then
        self:execute("sv_cheats 1")
        self:execute(string.format("viewmodel_model %s", model.path))
        
        self.state.currentCustomModel = model.path
        self.state.currentModelType = "weapon"
        
        self:log(string.format("✅ Applied weapon model: %s",
            model.desc or modelName), "success")
        self:log(string.format("📂 Path: %s", model.path), "info")
        
    else
        self:log("Unknown model type", "error")
        return false
    end
    
    return true
end

function skinChanger:resetCustomModel()
    self:execute("playermodel 0")
    self:execute("cl_teamid_model 0")
    self:execute("viewmodel_model 0")
    self:execute("sv_force_teamid_model 0")
    self:execute("sv_cheats 0")
    self.state.currentCustomModel = nil
    self.state.currentModelType = nil
    self:log("Reset to default model", "success")
    return true
end

function skinChanger:listCustomModels()
    print("")
    print(colors.cyan .. "╔═══════════════════════════════════════════════════╗")
    print(colors.cyan .. "║" .. colors.white .. "  🎨 CUSTOM MODELS" .. colors.cyan .. "                                      ║")
    print(colors.cyan .. "╚═══════════════════════════════════════════════════╝")
    print("")
    
    print(colors.yellow .. "  ─── PLAYER MODELS (Agents) ───" .. colors.white)
    for name, model in pairs(self.customModels) do
        if model.type == "player" then
            print(string.format("    %s• %s" .. colors.white .. " [%s]" .. colors.white .. " - %s",
                colors.green, name, model.faction or "?", model.desc or "No description"))
        end
    end
    
    print("")
    print(colors.yellow .. "  ─── WEAPON MODELS ───" .. colors.white)
    for name, model in pairs(self.customModels) do
        if model.type == "weapon" then
            print(string.format("    %s• %s" .. colors.white .. " [%s]" .. colors.white .. " - %s",
                colors.purple, name, model.weapon or "?", model.desc or "No description"))
        end
    end
    
    print("")
    print(colors.cyan .. "  📂 Place models in:" .. colors.white)
    print("    agents/models/     - Player models (.vmdl_c)")
    print("    models/weapons/    - Weapon models (.mdl)")
    print("")
    print(colors.yellow .. "  💡 Use: CustomModel('Name') to apply" .. colors.white)
    print(colors.cyan .. "╔═══════════════════════════════════════════════════╗")
    print(colors.cyan .. "║" .. colors.white .. "  📚 Type: AddModel('Name', 'type', 'path', 'desc')" .. colors.cyan .. "  ║")
    print(colors.cyan .. "╚═══════════════════════════════════════════════════╝")
    print("")
end

function skinChanger:addCustomModel(name, modelType, path, description, weapon)
    local model = {
        type = modelType,
        path = path,
        desc = description or "Custom model"
    }
    if modelType == "player" then
        model.faction = "T"
    elseif modelType == "weapon" then
        model.weapon = weapon or "Karambit"
    end
    self.customModels[name] = model
    self:log("Added model: " .. name, "success")
    return true
end

-- ============================================================
--  VOTE REVEALER
-- ============================================================
function skinChanger:revealVotes()
    if self.state.voteRevealerActive then
        self:execute("sv_vote_issue_show_votes 0")
        self:execute("sv_vote_issue_show_votes_all 0")
        self.state.voteRevealerActive = false
        self:log("Vote revealer deactivated", "warning")
        return
    end
    
    self:execute("sv_vote_issue_show_votes 1")
    self:execute("sv_vote_issue_show_votes_all 1")
    self.state.voteRevealerActive = true
    
    if type(RegisterEvent) == "function" then
        RegisterEvent("vote_started", function(e)
            print(colors.cyan .. "[Vote] " .. colors.white .. "⚡ Vote started by: " .. colors.yellow .. (e.player or "Unknown"))
        end)
        RegisterEvent("vote_cast", function(e)
            print(colors.cyan .. "[Vote] " .. colors.white .. "🗳️ " .. colors.yellow .. (e.player or "Unknown") .. colors.white .. " voted: " .. colors.green .. (e.choice or "Unknown"))
        end)
    end
    
    self:log("Vote revealer active", "success")
    return true
end

-- ============================================================
--  PRESETS
-- ============================================================
function skinChanger:applyPreset(name)
    local preset = self.presets[name]
    if not preset then
        self:log("Preset not found: " .. name, "error")
        self:log("Available: Green, Red, Blue, Gold", "info")
        return false
    end
    self:log("Applying preset: " .. name, "info")
    for weapon, skin in pairs(preset) do
        self:applySkin(weapon, skin)
    end
    return true
end

-- ============================================================
--  RESET ALL
-- ============================================================
function skinChanger:resetAll()
    self:resetSkins()
    self:resetCustomModel()
    if self.state.voteRevealerActive then
        self:revealVotes()
    end
    self:log("All features reset", "success")
    return true
end

-- ============================================================
--  HELP
-- ============================================================
function skinChanger:help()
    print("")
    print(colors.cyan .. "╔═══════════════════════════════════════════════════╗")
    print(colors.cyan .. "║" .. colors.white .. "  📚 COMMANDS" .. colors.cyan .. "                                              ║")
    print(colors.cyan .. "╚═══════════════════════════════════════════════════╝")
    print("")
    print(colors.yellow .. "  ─── SKIN CHANGER ───" .. colors.white)
    print("    Apply('Weapon', 'Skin')      - Apply a skin")
    print("    Remove()                     - Remove current skin")
    print("    Reset()                      - Reset everything")
    print("")
    print(colors.yellow .. "  ─── CUSTOM MODELS ───" .. colors.white)
    print("    CustomModel('Name')          - Apply custom model")
    print("    ListModels()                 - List all models")
    print("    ResetModel()                 - Reset to default")
    print("    AddModel('Name', 'type', 'path', 'desc', 'weapon') - Add model")
    print("")
    print(colors.yellow .. "  ─── VOTE REVEALER ───" .. colors.white)
    print("    Votes()                      - Toggle vote revealer")
    print("")
    print(colors.yellow .. "  ─── PRESETS ───" .. colors.white)
    print("    Preset('Green')              - Apply preset")
    print("    Presets: Green, Red, Blue, Gold")
    print("")
    print(colors.yellow .. "  ─── MISC ───" .. colors.white)
    print("    SC:showMenu()                - Show menu")
    print("    Help()                       - Show this help")
    print("")
    print(colors.cyan .. "╔═══════════════════════════════════════════════════╗")
    print(colors.cyan .. "║" .. colors.green .. "  ✅ Ready to use!" .. colors.cyan .. "                                           ║")
    print(colors.cyan .. "╚═══════════════════════════════════════════════════╝")
    print("")
end

-- ============================================================
--  MENU
-- ============================================================
function skinChanger:showMenu()
    print("")
    print(colors.cyan .. "╔═══════════════════════════════════════════════════╗")
    print(colors.cyan .. "║" .. colors.white .. "  🎯 MY CS2 SKIN CHANGER" .. colors.cyan .. "                                    ║")
    print(colors.cyan .. "╚═══════════════════════════════════════════════════╝")
    print("")
    print(colors.yellow .. "  ─── SKIN CHANGER ───" .. colors.white)
    print("    [1] Apply Skin")
    print("    [2] Remove Skin")
    print("    [3] Reset Skins")
    print("")
    print(colors.yellow .. "  ─── CUSTOM MODELS ───" .. colors.white)
    print("    [4] Apply Custom Model")
    print("    [5] List Models")
    print("    [6] Reset Model")
    print("")
    print(colors.yellow .. "  ─── VOTE REVEALER ───" .. colors.white)
    print("    [7] Toggle Vote Revealer - " .. (self.state.voteRevealerActive and colors.green .. "ON" or colors.red .. "OFF"))
    print("")
    print(colors.yellow .. "  ─── PRESETS ───" .. colors.white)
    print("    [8] Apply Preset")
    print("    [9] Help")
    print("    [0] Reset All")
    print("")
    print(colors.yellow .. "  ─── STATUS ───" .. colors.white)
    print("    Skin: " .. (self.state.selectedWeapon or "None") .. " → " .. (self.state.selectedSkin or "None"))
    print("    Model: " .. (self.state.currentCustomModel or "Default"))
    print("    Vote Revealer: " .. (self.state.voteRevealerActive and colors.green .. "ACTIVE" or colors.red .. "INACTIVE"))
    print("    Wear: " .. self.state.wear .. " | Seed: " .. self.state.seed)
    print("")
    print(colors.cyan .. "╔═══════════════════════════════════════════════════╗")
    print(colors.cyan .. "║" .. colors.green .. "  💡 Type: Help() for all commands" .. colors.cyan .. "                   ║")
    print(colors.cyan .. "╚═══════════════════════════════════════════════════╝")
    print("")
end

-- ============================================================
--  GLOBAL COMMANDS
-- ============================================================
_G.SC = skinChanger
_G.skinchanger = skinChanger

function Apply(weapon, skin)
    skinChanger:applySkin(weapon, skin)
end

function Remove()
    skinChanger:removeSkin()
end

function Reset()
    skinChanger:resetAll()
end

function ResetSkins()
    skinChanger:resetSkins()
end

function CustomModel(name)
    skinChanger:applyCustomModel(name)
end

function ListModels()
    skinChanger:listCustomModels()
end

function ResetModel()
    skinChanger:resetCustomModel()
end

function AddModel(name, type, path, desc, weapon)
    skinChanger:addCustomModel(name, type, path, desc, weapon)
end

function Votes()
    skinChanger:revealVotes()
end

function Preset(name)
    skinChanger:applyPreset(name)
end

function Help()
    skinChanger:help()
end

-- ============================================================
--  INITIALIZATION
-- ============================================================
if LOADER_INFO then
    print(string.format("%s[SkinChanger] %sLoaded by: %s v%s",
        colors.cyan, colors.white, LOADER_INFO.name, LOADER_INFO.version))
end

-- Auto-restore on round start
if type(RegisterEvent) == "function" then
    RegisterEvent("round_start", function()
        if skinChanger.state.selectedWeapon and skinChanger.state.selectedSkin ~= "None" then
            skinChanger:applySkin(skinChanger.state.selectedWeapon, skinChanger.state.selectedSkin)
        end
        if skinChanger.state.currentCustomModel then
            -- Re-apply custom model
        end
    end)
end

-- ============================================================
--  BANNER
-- ============================================================
print("")
print(colors.cyan .. "╔═══════════════════════════════════════════════════╗")
print(colors.cyan .. "║" .. colors.white .. "  🎯 SKIN CHANGER READY" .. colors.cyan .. "                                       ║")
print(colors.cyan .. "║" .. colors.white .. "  📂 CS2 Compatible | Custom Models | Vote Revealer" .. colors.cyan .. "   ║")
print(colors.cyan .. "╚═══════════════════════════════════════════════════╝")
print("")
print(colors.yellow .. "  📚 Commands:" .. colors.white)
print("    " .. colors.green .. "Apply('Weapon', 'Skin')" .. colors.white .. "  - Apply a skin")
print("    " .. colors.green .. "CustomModel('Name')" .. colors.white .. "     - Apply custom model")
print("    " .. colors.green .. "ListModels()" .. colors.white .. "            - List all models")
print("    " .. colors.green .. "Votes()" .. colors.white .. "                - Toggle vote revealer")
print("    " .. colors.green .. "Preset('Green')" .. colors.white .. "        - Apply preset")
print("    " .. colors.green .. "Help()" .. colors.white .. "                - Show all commands")
print("")
print(colors.cyan .. "╔═══════════════════════════════════════════════════╗")
print(colors.cyan .. "║" .. colors.green .. "  ✅ Loaded successfully!" .. colors.cyan .. "                                        ║")
print(colors.cyan .. "╚═══════════════════════════════════════════════════╝")
print("")

-- Return the skin changer
return skinChanger
