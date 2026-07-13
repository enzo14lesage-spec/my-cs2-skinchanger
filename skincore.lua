-- Skin Changer
-- Auto applies skins

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

local Skins = {
    Fade = 38,
    Doppler = 411,
    ["Dragon Lore"] = 10061,
    Redline = 400,
    Asiimov = 310,
}

function Apply(weapon, skin)
    local wid = Weapons[weapon]
    local sid = Skins[skin]
    if wid and sid then
        executeCommand(string.format("skins %d %d %d 0.00 0", wid, sid, sid))
        print("[✓] " .. skin .. " on " .. weapon)
    end
end

function Remove()
    executeCommand("skins 0")
    print("[✓] Removed")
end

-- Auto apply
Apply("Karambit", "Fade")
Apply("AK-47", "Redline")

print("Ready!")
