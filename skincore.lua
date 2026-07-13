-- ============================================================
--  MY CS2 SKIN CHANGER
--  Compatible with Aimware
-- ============================================================

print("========================================")
print("  LOADING SKIN CHANGER...")
print("========================================")

-- ============================================================
--  WEAPONS
-- ============================================================
local weapons = {
    -- Knives
    ["Bayonet"]       = 42,
    ["Classic Knife"] = 500,
    ["Flip Knife"]    = 505,
    ["Gut Knife"]     = 506,
    ["Karambit"]      = 507,
    ["M9 Bayonet"]    = 508,
    ["Huntsman"]      = 509,
    ["Falchion"]      = 512,
    ["Bowie Knife"]   = 514,
    ["Butterfly"]     = 515,
    ["Shadow Daggers"]= 516,
    ["Paracord"]      = 517,
    ["Survival Knife"]= 518,
    ["Ursus"]         = 519,
    ["Navaja"]        = 520,
    ["Nomad"]         = 521,
    -- Pistols
    ["Glock-18"]      = 4,
    ["USP-S"]         = 61,
    ["P2000"]         = 32,
    ["Desert Eagle"]  = 1,
    ["R8 Revolver"]   = 64,
    ["AK-47"]         = 7,
    ["M4A1-S"]        = 60,
    ["M4A4"]          = 16,
    ["AWP"]           = 9,
    ["SSG 08"]        = 40,
    ["MP9"]           = 34,
    ["MP7"]           = 33,
    ["P90"]           = 19,
    ["MAC-10"]        = 47,
}

-- ============================================================
--  SKINS
-- ============================================================
local skins = {
    ["None"]          = 0,
    ["Dragon Lore"]   = 10061,
    ["Howl"]          = 10048,
    ["Medusa"]        = 10057,
    ["Fire Serpent"]  = 10058,
    ["Asiimov"]       = 310,
    ["Redline"]       = 400,
    ["Bloodsport"]    = 10052,
    ["Neo-Noir"]      = 10053,
    ["Printstream"]   = 10064,
    ["Doppler P1"]    = 411,
    ["Doppler P2"]    = 411,
    ["Doppler P3"]    = 411,
    ["Doppler P4"]    = 411,
    ["Ruby"]          = 411,
    ["Sapphire"]      = 411,
    ["Black Pearl"]   = 411,
    ["Marble Fade"]   = 413,
    ["Fade"]          = 38,
    ["Tiger Tooth"]   = 412,
    ["Gamma Doppler"] = 414,
    ["Lore"]          = 10056,
    ["Autotronic"]    = 10048,
    ["Black Laminate"]= 408,
    ["Blue Steel"]    = 34,
    ["Case Hardened"] = 39,
    ["Crimson Web"]   = 400,
    ["Damascus Steel"]= 409,
}

-- ============================================================
--  STATE
-- ============================================================
local state = {
    wear = 0.00,
    seed = 0,
    currentWeapon = nil,
    currentSkin = "None"
}

-- ============================================================
--  COMMANDS
-- ============================================================
function Apply(weaponName, skinName)
    local weaponId = weapons[weaponName]
    local skinId = skins[skinName]
    
    if not weaponId then
        print("[Error] Weapon not found: " .. weaponName)
        print("Available: Karambit, Butterfly, AK-47, AWP, etc.")
        return
    end
    
    if not skinId then
        print("[Error] Skin not found: " .. skinName)
        print("Available: Fade, Doppler P1, Dragon Lore, etc.")
        return
    end
    
    local cmd = string.format("skins %d %d %d %.3f %d", 
        weaponId, skinId, skinId, state.wear, state.seed)
    
    if executeCommand then
        executeCommand(cmd)
        state.currentWeapon = weaponName
        state.currentSkin = skinName
        print("[OK] Applied " .. skinName .. " to " .. weaponName)
    else
        print("[Error] Cannot execute command")
    end
end

function Remove()
    if state.currentWeapon then
        local weaponId = weapons[state.currentWeapon]
        if weaponId and executeCommand then
            executeCommand(string.format("skins %d 0", weaponId))
            print("[OK] Removed skin from " .. state.currentWeapon)
            state.currentWeapon = nil
            state.currentSkin = "None"
        end
    else
        print("[Info] No skin active")
    end
end

function Reset()
    if executeCommand then
        executeCommand("skins 0")
        state.currentWeapon = nil
        state.currentSkin = "None"
        state.wear = 0.00
        state.seed = 0
        print("[OK] All skins reset")
    end
end

function SetWear(value)
    state.wear = tonumber(value) or 0.00
    print("[OK] Wear set to " .. state.wear)
end

function SetSeed(value)
    state.seed = tonumber(value) or 0
    print("[OK] Seed set to " .. state.seed)
end

function Help()
    print("")
    print("========================================")
    print("  SKIN CHANGER COMMANDS")
    print("========================================")
    print("")
    print("  Apply('Weapon', 'Skin')  - Apply skin")
    print("  Remove()                 - Remove skin")
    print("  Reset()                  - Reset all")
    print("  SetWear(0.05)            - Set wear")
    print("  SetSeed(0)               - Set seed")
    print("  ListWeapons()            - List weapons")
    print("  ListSkins()              - List skins")
    print("  Help()                   - This menu")
    print("")
    print("  Examples:")
    print("    Apply('Karambit', 'Fade')")
    print("    Apply('AK-47', 'Redline')")
    print("    Apply('AWP', 'Dragon Lore')")
    print("========================================")
end

function ListWeapons()
    print("")
    print("=== WEAPONS ===")
    local count = 0
    for name, id in pairs(weapons) do
        print("  " .. name)
        count = count + 1
    end
    print("Total: " .. count)
end

function ListSkins()
    print("")
    print("=== SKINS ===")
    for name, id in pairs(skins) do
        print("  " .. name)
    end
end

-- ============================================================
--  VOTE REVEALER
-- ============================================================
local voteActive = false

function Votes()
    if executeCommand then
        if voteActive then
            executeCommand("sv_vote_issue_show_votes 0")
            executeCommand("sv_vote_issue_show_votes_all 0")
            voteActive = false
            print("[VoteRevealer] OFF")
        else
            executeCommand("sv_vote_issue_show_votes 1")
            executeCommand("sv_vote_issue_show_votes_all 1")
            voteActive = true
            print("[VoteRevealer] ON")
        end
    end
end

-- ============================================================
--  PRESETS
-- ============================================================
function Preset(name)
    local presets = {
        ["Red"] = {
            ["AK-47"] = "Redline",
            ["AWP"] = "Dragon Lore",
            ["Karambit"] = "Ruby"
        },
        ["Blue"] = {
            ["M4A1-S"] = "Printstream",
            ["USP-S"] = "Blueprint",
            ["Butterfly"] = "Sapphire"
        },
        ["Green"] = {
            ["AK-47"] = "Gamma Doppler",
            ["Desert Eagle"] = "Emerald",
            ["Karambit"] = "Gamma Doppler"
        },
        ["Gold"] = {
            ["AK-47"] = "Gold",
            ["Desert Eagle"] = "Gold",
            ["Butterfly"] = "Fade"
        }
    }
    
    local preset = presets[name]
    if not preset then
        print("[Error] Preset not found: " .. name)
        print("Available: Red, Blue, Green, Gold")
        return
    end
    
    print("[Preset] Applying " .. name)
    for weapon, skin in pairs(preset) do
        Apply(weapon, skin)
    end
end

-- ============================================================
--  MENU
-- ============================================================
function Menu()
    print("")
    print("========================================")
    print("  SKIN CHANGER MENU")
    print("========================================")
    print("")
    print("  [1] Apply Skin")
    print("  [2] Remove Skin")
    print("  [3] Reset All")
    print("  [4] Toggle Vote Revealer - " .. (voteActive and "ON" or "OFF"))
    print("  [5] Apply Preset")
    print("  [6] Help")
    print("")
    print("  Status:")
    print("    Weapon: " .. (state.currentWeapon or "None"))
    print("    Skin: " .. (state.currentSkin or "None"))
    print("    Wear: " .. state.wear)
    print("========================================")
end

-- ============================================================
--  EXPOSE GLOBALS
-- ============================================================
_G.Apply = Apply
_G.Remove = Remove
_G.Reset = Reset
_G.SetWear = SetWear
_G.SetSeed = SetSeed
_G.Help = Help
_G.ListWeapons = ListWeapons
_G.ListSkins = ListSkins
_G.Votes = Votes
_G.Preset = Preset
_G.Menu = Menu

-- ============================================================
--  STARTUP
-- ============================================================
print("")
print("========================================")
print("  SKIN CHANGER READY!")
print("========================================")
print("")
print("  Commands:")
print("    Apply('Karambit', 'Fade')")
print("    Apply('AK-47', 'Redline')")
print("    Apply('AWP', 'Dragon Lore')")
print("    Remove()")
print("    Reset()")
print("    Help()")
print("    Menu()")
print("")
print("  Examples:")
print("    Apply('Karambit', 'Fade')")
print("    Apply('M9 Bayonet', 'Doppler P2')")
print("    Preset('Red')")
print("    Votes()")
print("========================================")

return true
