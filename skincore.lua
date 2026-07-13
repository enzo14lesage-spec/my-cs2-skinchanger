-- ============================================================
--  MY CS2 SKIN CHANGER
--  Auto-Apply on Load
-- ============================================================

print("========================================")
print("  MY SKIN CHANGER LOADED")
print("========================================")

-- Weapons
local Weapons = {
    Karambit = 507,
    Butterfly = 515,
    ["M9 Bayonet"] = 508,
    Bayonet = 42,
    ["AK-47"] = 7,
    M4A4 = 16,
    ["M4A1-S"] = 60,
    AWP = 9,
}

-- Skins
local Skins = {
    Fade = 38,
    Doppler = 411,
    ["Dragon Lore"] = 10061,
    Redline = 400,
    Asiimov = 310,
    Printstream = 10064,
}

-- Auto-apply function
local function AutoApply()
    -- Edit these to change what skin you want
    -- Format: Apply("Weapon", "Skin")
    
    Apply("Karambit", "Fade")
    Apply("AK-47", "Redline")
    Apply("AWP", "Dragon Lore")
    Apply("M9 Bayonet", "Doppler")
    
    print("[✓] Auto-applied skins!")
end

function Apply(weapon, skin)
    local wid = Weapons[weapon]
    local sid = Skins[skin]
    if wid and sid then
        executeCommand(string.format("skins %d %d %d 0.00 0", wid, sid, sid))
        print("[✓] Applied " .. skin .. " to " .. weapon)
    end
end

function Remove()
    executeCommand("skins 0")
    print("[✓] Removed all skins")
end

-- Run auto-apply immediately
AutoApply()

print("")
print("========================================")
