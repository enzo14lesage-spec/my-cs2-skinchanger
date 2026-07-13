-- ============================================================
--  SKIN CHANGER WITH GUI
--  For Aimware V6
-- ============================================================

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
    ["Desert Eagle"] = 1,
    ["USP-S"] = 61,
    ["Glock-18"] = 4,
}

-- Skins
local Skins = {
    ["None"] = 0,
    ["Fade"] = 38,
    ["Doppler"] = 411,
    ["Dragon Lore"] = 10061,
    ["Redline"] = 400,
    ["Asiimov"] = 310,
    ["Printstream"] = 10064,
    ["Howl"] = 10048,
    ["Fire Serpent"] = 10058,
}

-- State
local State = {
    selectedWeapon = "Karambit",
    selectedSkin = "Fade",
    wear = 0.00,
    seed = 0,
}

-- Apply function
function ApplySkin(weapon, skin)
    local wid = Weapons[weapon]
    local sid = Skins[skin]
    if wid and sid then
        executeCommand(string.format("skins %d %d %d %.3f %d", wid, sid, sid, State.wear, State.seed))
        print("[SkinChanger] Applied " .. skin .. " to " .. weapon)
    else
        print("[SkinChanger] Weapon or skin not found")
    end
end

function RemoveSkin()
    executeCommand("skins 0")
    print("[SkinChanger] Removed all skins")
end

-- Auto-apply current selection
function ApplyCurrent()
    ApplySkin(State.selectedWeapon, State.selectedSkin)
end

-- ============================================================
--  GUI WINDOW
-- ============================================================

-- Main window
local Window = gui.Window("skin_changer_window", "Skin Changer", 10, 10, 400, 350)

-- Weapon selection
local WeaponGroup = gui.Groupbox(Window, "Weapon", 10, 10, 180, 200)
local WeaponList = gui.Listbox(WeaponGroup, "Select Weapon", 10, 20, 160, 150)

-- Add weapons to list
local weaponNames = {}
for name, id in pairs(Weapons) do
    table.insert(weaponNames, name)
end
table.sort(weaponNames)
WeaponList:SetItems(weaponNames)
WeaponList:SetValue(1) -- Select first item

-- Skin selection
local SkinGroup = gui.Groupbox(Window, "Skin", 200, 10, 180, 200)
local SkinList = gui.Listbox(SkinGroup, "Select Skin", 10, 20, 160, 150)

-- Add skins to list
local skinNames = {}
for name, id in pairs(Skins) do
    table.insert(skinNames, name)
end
table.sort(skinNames)
SkinList:SetItems(skinNames)
SkinList:SetValue(2) -- Select "Fade"

-- Wear slider
local WearGroup = gui.Groupbox(Window, "Wear / Float", 10, 220, 180, 80)
local WearSlider = gui.Slider(WearGroup, "Wear", 0, 100, 0)

-- Seed slider
local SeedGroup = gui.Groupbox(Window, "Seed", 200, 220, 180, 80)
local SeedSlider = gui.Slider(SeedGroup, "Seed", 0, 999, 0)

-- Apply button
local ButtonGroup = gui.Groupbox(Window, "Actions", 10, 310, 370, 30)
local ApplyButton = gui.Button(ButtonGroup, "Apply Skin", function()
    local weaponIndex = WeaponList:GetValue()
    local skinIndex = SkinList:GetValue()
    State.selectedWeapon = weaponNames[weaponIndex]
    State.selectedSkin = skinNames[skinIndex]
    State.wear = WearSlider:GetValue() / 100
    State.seed = SeedSlider:GetValue()
    ApplyCurrent()
end)

-- Remove button
local RemoveButton = gui.Button(ButtonGroup, "Remove All", function()
    RemoveSkin()
end)

-- Auto-apply on selection change
WeaponList:SetCallback(function()
    -- Auto-apply when weapon changes
end)

SkinList:SetCallback(function()
    -- Auto-apply when skin changes
end)

-- ============================================================
--  AUTO-APPLY ON LOAD
-- ============================================================

-- Apply default skin on load
ApplySkin("Karambit", "Fade")

print("")
print("========================================")
print("  SKIN CHANGER LOADED!")
print("========================================")
print("  Open Aimware menu and go to Lua tab")
print("  Find 'Skin Changer' window")
print("========================================")

-- Set window to open with menu key
Window:SetOpenKey(gui.GetValue("adv.menukey"))
