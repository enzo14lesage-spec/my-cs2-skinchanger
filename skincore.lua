-- ============================================================
--  MY CS2 SKIN CHANGER
--  For Aimware CS2 V6
--  Version: 1.0.0
-- ============================================================

print("========================================")
print("  MY CS2 SKIN CHANGER v1.0.0")
print("  Loading...")
print("========================================")

-- ============================================================
--  WEAPONS DATABASE
-- ============================================================
local Weapons = {
    -- Knives
    ["Bayonet"] = 42,
    ["Classic Knife"] = 500,
    ["Flip Knife"] = 505,
    ["Gut Knife"] = 506,
    ["Karambit"] = 507,
    ["M9 Bayonet"] = 508,
    ["Huntsman"] = 509,
    ["Falchion"] = 512,
    ["Bowie Knife"] = 514,
    ["Butterfly"] = 515,
    ["Shadow Daggers"] = 516,
    ["Paracord Knife"] = 517,
    ["Survival Knife"] = 518,
    ["Ursus Knife"] = 519,
    ["Navaja Knife"] = 520,
    ["Nomad Knife"] = 521,
    
    -- Pistols
    ["Glock-18"] = 4,
    ["USP-S"] = 61,
    ["P2000"] = 32,
    ["Desert Eagle"] = 1,
    ["R8 Revolver"] = 64,
    ["P250"] = 36,
    ["CZ75-Auto"] = 63,
    ["Dual Berettas"] = 2,
    ["Tec-9"] = 30,
    ["Five-SeveN"] = 3,
    
    -- Rifles
    ["AK-47"] = 7,
    ["M4A1-S"] = 60,
    ["M4A4"] = 16,
    ["AWP"] = 9,
    ["SSG 08"] = 40,
    ["SCAR-20"] = 38,
    ["G3SG1"] = 11,
    ["FAMAS"] = 10,
    ["Galil AR"] = 13,
    ["SG 553"] = 39,
    ["AUG"] = 8,
    
    -- SMGs
    ["MP9"] = 34,
    ["MP7"] = 33,
    ["P90"] = 19,
    ["MAC-10"] = 47,
    ["MP5-SD"] = 23,
    ["UMP-45"] = 24,
    ["PP-Bizon"] = 26,
    
    -- Shotguns
    ["Nova"] = 35,
    ["XM1014"] = 25,
    ["MAG-7"] = 27,
    ["Sawed-Off"] = 29,
    
    -- Heavy
    ["M249"] = 14,
    ["Negev"] = 28,
}

-- ============================================================
--  SKINS DATABASE
-- ============================================================
local Skins = {
    ["None"] = 0,
    ["Dragon Lore"] = 10061,
    ["Howl"] = 10048,
    ["Medusa"] = 10057,
    ["Fire Serpent"] = 10058,
    ["Asiimov"] = 310,
    ["Redline"] = 400,
    ["Bloodsport"] = 10052,
    ["Neo-Noir"] = 10053,
    ["Printstream"] = 10064,
    ["Doppler Phase 1"] = 411,
    ["Doppler Phase 2"] = 411,
    ["Doppler Phase 3"] = 411,
    ["Doppler Phase 4"] = 411,
    ["Doppler Ruby"] = 411,
    ["Doppler Sapphire"] = 411,
    ["Doppler Black Pearl"] = 411,
    ["Marble Fade"] = 413,
    ["Fade"] = 38,
    ["Tiger Tooth"] = 412,
    ["Gamma Doppler"] = 414,
    ["Lore"] = 10056,
    ["Autotronic"] = 10048,
    ["Black Laminate"] = 408,
    ["Blue Steel"] = 34,
    ["Boreal Forest"] = 43,
    ["Bright Water"] = 836,
    ["Case Hardened"] = 39,
    ["Crimson Web"] = 400,
    ["Damascus Steel"] = 409,
}

-- ============================================================
--  STATE
-- ============================================================
local State = {
    wear = 0.00,
    seed = 0,
    currentWeapon = nil,
    currentSkin = "None"
}

-- ============================================================
--  CORE FUNCTIONS
-- ============================================================

function Execute(cmd)
    if type(executeCommand) == "function" then
        executeCommand(cmd)
        return true
    else
        print("[Error] Cannot execute: " .. cmd)
        return false
    end
end

-- ============================================================
--  SKIN FUNCTIONS
-- ============================================================

function Apply(weaponName, skinName)
    local weaponId = Weapons[weaponName]
    local skinId = Skins[skinName]
    
    if not weaponId then
        print("[Error] Weapon not found: " .. weaponName)
        print("[Info] Available: Karambit, Butterfly, AK-47, AWP, etc.")
        return false
    end
    
    if not skinId then
        print("[Error] Skin not found: " .. skinName)
        print("[Info] Available: Fade, Doppler Phase 1, Dragon Lore, etc.")
        return false
    end
    
    local cmd = string.format("skins %d %d %d %.3f %d", 
        weaponId, skinId, skinId, State.wear, State.seed)
    
    if Execute(cmd) then
        State.currentWeapon = weaponName
        State.currentSkin = skinName
        print("[✓] Applied " .. skinName .. " to " .. weaponName)
        return true
    end
    return false
end

function Remove()
    if State.currentWeapon then
        local weaponId = Weapons[State.currentWeapon]
        if weaponId then
            Execute(string.format("skins %d 0", weaponId))
            print("[✓] Removed skin from " .. State.currentWeapon)
            State.currentWeapon = nil
            State.currentSkin = "None"
            return true
        end
    else
        print("[Info] No skin active")
    end
    return false
end

function Reset()
    Execute("skins 0")
    State.currentWeapon = nil
    State.currentSkin = "None"
    State.wear = 0.00
    State.seed = 0
    print("[✓] All skins reset")
    return true
end

function SetWear(value)
    local val = tonumber(value)
    if val and val >= 0 and val <= 1 then
        State.wear = val
        print("[✓] Wear set to " .. State.wear)
    else
        print("[Error] Wear must be between 0.00 and 1.00")
    end
end

function SetSeed(value)
    local val = tonumber(value)
    if val and val >= 0 and val <= 999 then
        State.seed = val
        print("[✓] Seed set to " .. State.seed)
    else
        print("[Error] Seed must be between 0 and 999")
    end
end

-- ============================================================
--  VOTE REVEALER
-- ============================================================
local VoteActive = false

function Votes()
    if VoteActive then
        Execute("sv_vote_issue_show_votes 0")
        Execute("sv_vote_issue_show_votes_all 0")
        VoteActive = false
        print("[VoteRevealer] OFF")
    else
        Execute("sv_vote_issue_show_votes 1")
        Execute("sv_vote_issue_show_votes_all 1")
        VoteActive = true
        print("[VoteRevealer] ON")
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
            ["Karambit"] = "Doppler Ruby"
        },
        ["Blue"] = {
            ["M4A1-S"] = "Printstream",
            ["USP-S"] = "Printstream",
            ["Butterfly"] = "Doppler Sapphire"
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
        },
        ["All Knives"] = {
            ["Karambit"] = "Fade",
            ["Butterfly"] = "Fade",
            ["M9 Bayonet"] = "Fade",
            ["Bayonet"] = "Fade"
        }
    }
    
    local preset = presets[name]
    if not preset then
        print("[Error] Preset not found: " .. name)
        print("[Info] Available: Red, Blue, Green, Gold, All Knives")
        return false
    end
    
    print("[Preset] Applying " .. name)
    for weapon, skin in pairs(preset) do
        Apply(weapon, skin)
    end
    return true
end

-- ============================================================
--  LIST FUNCTIONS
-- ============================================================
function ListWeapons()
    print("")
    print("=== WEAPONS ===")
    local list = {}
    for name, id in pairs(Weapons) do
        table.insert(list, name)
    end
    table.sort(list)
    for i, name in ipairs(list) do
        print("  " .. name)
    end
    print("Total: " .. #list)
end

function ListSkins()
    print("")
    print("=== SKINS ===")
    local list = {}
    for name, id in pairs(Skins) do
        table.insert(list, name)
    end
    table.sort(list)
    for i, name in ipairs(list) do
        print("  " .. name)
    end
    print("Total: " .. #list)
end

-- ============================================================
--  HELP
-- ============================================================
function Help()
    print("")
    print("========================================")
    print("  MY CS2 SKIN CHANGER v1.0.0")
    print("========================================")
    print("")
    print("  COMMANDS:")
    print("")
    print("  Apply('Weapon', 'Skin')  - Apply a skin")
    print("  Remove()                 - Remove current skin")
    print("  Reset()                  - Reset all skins")
    print("  SetWear(0.05)            - Set wear value (0-1)")
    print("  SetSeed(0)               - Set seed value (0-999)")
    print("  Votes()                  - Toggle vote revealer")
    print("  Preset('Name')           - Apply a preset")
    print("  ListWeapons()            - List all weapons")
    print("  ListSkins()              - List all skins")
    print("  Help()                   - Show this help")
    print("")
    print("  EXAMPLES:")
    print("  Apply('Karambit', 'Fade')")
    print("  Apply('AK-47', 'Redline')")
    print("  Apply('AWP', 'Dragon Lore')")
    print("  Preset('Red')")
    print("  Votes()")
    print("")
    print("========================================")
end

-- ============================================================
--  AUTO-START
-- ============================================================

-- Expose globals
_G.Apply = Apply
_G.Remove = Remove
_G.Reset = Reset
_G.SetWear = SetWear
_G.SetSeed = SetSeed
_G.Votes = Votes
_G.Preset = Preset
_G.ListWeapons = ListWeapons
_G.ListSkins = ListSkins
_G.Help = Help

-- Show startup banner
print("")
print("========================================")
print("  ✓ SKIN CHANGER READY!")
print("========================================")
print("")
print("  Quick Commands:")
print("  Apply('Karambit', 'Fade')")
print("  Apply('AK-47', 'Redline')")
print("  Preset('Red')")
print("  Votes()")
print("  Help()")
print("")
print("========================================")

-- Auto-apply if needed (uncomment if you want)
-- Apply('Karambit', 'Fade')

return true
