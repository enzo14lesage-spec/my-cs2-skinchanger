-- ============================================================
--  SKIN CHANGER - Fixed Layout
--  For Aimware V6
-- ============================================================

-- Weapons
local Weapons = {
    ["Karambit"] = 507,
    ["Butterfly"] = 515,
    ["M9 Bayonet"] = 508,
    ["Bayonet"] = 42,
    ["Flip Knife"] = 505,
    ["Gut Knife"] = 506,
    ["Huntsman"] = 509,
    ["Falchion"] = 512,
    ["Bowie Knife"] = 514,
    ["Shadow Daggers"] = 516,
    ["AK-47"] = 7,
    ["M4A4"] = 16,
    ["M4A1-S"] = 60,
    ["AWP"] = 9,
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
}

-- Current selections
local selectedWeapon = "Karambit"
local selectedSkin = "Fade"
local currentWear = 0.00
local currentSeed = 0

-- Apply function
local function ApplySkin(weapon, skin)
    local wid = Weapons[weapon]
    local sid = Skins[skin]
    if wid and sid then
        executeCommand(string.format("skins %d %d %d %.3f %d", wid, sid, sid, currentWear, currentSeed))
        print("[SkinChanger] Applied " .. skin .. " to " .. weapon)
    end
end

local function RemoveSkin()
    executeCommand("skins 0")
    print("[SkinChanger] Removed all skins")
end

-- ============================================================
--  GUI
-- ============================================================

-- Main Window - Smaller and cleaner
local Window = gui.Window("skin_changer_window", "Skin Changer", 10, 10, 420, 280)

-- Weapon List
local WeaponGroup = gui.Groupbox(Window, "Weapon", 10, 10, 190, 180)
local WeaponList = gui.Listbox(WeaponGroup, "Select Weapon", 10, 20, 170, 130)

local weaponNames = {}
for name, id in pairs(Weapons) do
    table.insert(weaponNames, name)
end
table.sort(weaponNames)
WeaponList:SetItems(weaponNames)
WeaponList:SetValue(1)

-- Skin List
local SkinGroup = gui.Groupbox(Window, "Skin", 210, 10, 190, 180)
local SkinList = gui.Listbox(SkinGroup, "Select Skin", 10, 20, 170, 130)

local skinNames = {}
for name, id in pairs(Skins) do
    table.insert(skinNames, name)
end
table.sort(skinNames)
SkinList:SetItems(skinNames)
SkinList:SetValue(2)

-- Wear Slider
local WearGroup = gui.Groupbox(Window, "Wear", 10, 200, 190, 70)
local WearSlider = gui.Slider(WearGroup, "Float", 0, 100, 0)

-- Seed Slider
local SeedGroup = gui.Groupbox(Window, "Seed", 210, 200, 190, 70)
local SeedSlider = gui.Slider(SeedGroup, "Seed", 0, 999, 0)

-- Buttons - Below everything
local ButtonGroup = gui.Groupbox(Window, "", 10, 275, 390, 35)
local ApplyButton = gui.Button(ButtonGroup, "Apply", function()
    local weaponIndex = WeaponList:GetValue()
    local skinIndex = SkinList:GetValue()
    selectedWeapon = weaponNames[weaponIndex]
    selectedSkin = skinNames[skinIndex]
    currentWear = WearSlider:GetValue() / 100
    currentSeed = SeedSlider:GetValue()
    ApplySkin(selectedWeapon, selectedSkin)
end)

local RemoveButton = gui.Button(ButtonGroup, "Remove All", function()
    RemoveSkin()
end)

-- Auto-apply on load
ApplySkin("Karambit", "Fade")

Window:SetOpenKey(gui.GetValue("adv.menukey"))

print("[SkinChanger] Loaded!")
