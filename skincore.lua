-- ============================================================
--  SKIN CHANGER
--  FemboyTap Style UI
--  For Aimware V6
-- ============================================================

-- ============================================================
--  DATA
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
}

local Skins = {
    ["None"] = 0,
    ["Autotronic"] = 10048,
    ["Black Laminate"] = 408,
    ["Blue Steel"] = 34,
    ["Boreal Forest"] = 43,
    ["Bright Water"] = 836,
    ["Case Hardened"] = 39,
    ["Crimson Web"] = 400,
    ["Damascus Steel"] = 409,
    ["Doppler"] = 411,
    ["Fade"] = 38,
    ["Marble Fade"] = 413,
    ["Tiger Tooth"] = 412,
    ["Gamma Doppler"] = 414,
    ["Lore"] = 10056,
}

-- ============================================================
--  STATE
-- ============================================================

local state = {
    selectedWeapon = "Karambit",
    selectedSkin = "Fade",
    wear = 0.000,
    seed = 0,
}

-- ============================================================
--  FUNCTIONS
-- ============================================================

local function ApplySkin(weapon, skin)
    local wid = Weapons[weapon]
    local sid = Skins[skin]
    if wid and sid then
        executeCommand(string.format("skins %d %d %d %.3f %d", wid, sid, sid, state.wear, state.seed))
        print("[SkinChanger] Applied " .. skin .. " to " .. weapon)
    end
end

local function RemoveSkin()
    executeCommand("skins 0")
    print("[SkinChanger] Removed all skins")
end

local function ResetAll()
    executeCommand("skins 0")
    state.wear = 0.000
    state.seed = 0
    print("[SkinChanger] Reset all")
end

-- ============================================================
--  GUI - FEMBOYTAP STYLE
-- ============================================================

-- Main Window
local Window = gui.Window("skin_changer_window", "Skin Changer", 10, 10, 500, 420)

-- ============================================================
--  WEAPONS SECTION
-- ============================================================
local WeaponGroup = gui.Groupbox(Window, "Weapons", 10, 10, 230, 280)
local WeaponList = gui.Listbox(WeaponGroup, "", 10, 20, 210, 240)

local weaponNames = {}
for name, id in pairs(Weapons) do
    table.insert(weaponNames, name)
end
table.sort(weaponNames)
WeaponList:SetItems(weaponNames)
WeaponList:SetValue(1)

-- ============================================================
--  SKINS SECTION
-- ============================================================
local SkinGroup = gui.Groupbox(Window, "Skins", 250, 10, 230, 280)
local SkinList = gui.Listbox(SkinGroup, "", 10, 20, 210, 240)

local skinNames = {}
for name, id in pairs(Skins) do
    table.insert(skinNames, name)
end
table.sort(skinNames)
SkinList:SetValue(1) -- None
SkinList:SetItems(skinNames)

-- ============================================================
--  SETTINGS SECTION
-- ============================================================
local SettingsGroup = gui.Groupbox(Window, "Settings", 10, 300, 470, 70)

-- Wear
local WearText = gui.Text(SettingsGroup, "Wear / Float:", 10, 20, 80, 20)
local WearSlider = gui.Slider(SettingsGroup, "", 95, 20, 150, 20)
WearSlider:SetMinMax(0, 100)
WearSlider:SetValue(0)

local WearValue = gui.Text(SettingsGroup, "0.000", 250, 20, 50, 20)

-- Seed
local SeedText = gui.Text(SettingsGroup, "Seed:", 310, 20, 40, 20)
local SeedSlider = gui.Slider(SettingsGroup, "", 355, 20, 100, 20)
SeedSlider:SetMinMax(0, 999)
SeedSlider:SetValue(0)

local SeedValue = gui.Text(SettingsGroup, "0", 460, 20, 30, 20)

-- ============================================================
--  ACTIONS SECTION
-- ============================================================
local ActionsGroup = gui.Groupbox(Window, "Actions", 10, 380, 470, 35)

local ApplyButton = gui.Button(ActionsGroup, "Apply", function()
    local weaponIndex = WeaponList:GetValue()
    local skinIndex = SkinList:GetValue()
    state.selectedWeapon = weaponNames[weaponIndex]
    state.selectedSkin = skinNames[skinIndex]
    state.wear = WearSlider:GetValue() / 100
    state.seed = SeedSlider:GetValue()
    ApplySkin(state.selectedWeapon, state.selectedSkin)
end)

local RemoveButton = gui.Button(ActionsGroup, "Remove", function()
    RemoveSkin()
end)

local ResetButton = gui.Button(ActionsGroup, "Reset All", function()
    ResetAll()
    WearSlider:SetValue(0)
    SeedSlider:SetValue(0)
end)

-- ============================================================
--  UPDATE WEAR/SEED DISPLAY
-- ============================================================
WearSlider:SetCallback(function()
    local val = WearSlider:GetValue()
    WearValue:SetText(string.format("%.3f", val / 100))
end)

SeedSlider:SetCallback(function()
    local val = SeedSlider:GetValue()
    SeedValue:SetText(tostring(val))
end)

-- ============================================================
--  AUTO-APPLY ON SELECT
-- ============================================================
WeaponList:SetCallback(function()
    local weaponIndex = WeaponList:GetValue()
    local skinIndex = SkinList:GetValue()
    state.selectedWeapon = weaponNames[weaponIndex]
    state.selectedSkin = skinNames[skinIndex]
    state.wear = WearSlider:GetValue() / 100
    state.seed = SeedSlider:GetValue()
    ApplySkin(state.selectedWeapon, state.selectedSkin)
end)

SkinList:SetCallback(function()
    local weaponIndex = WeaponList:GetValue()
    local skinIndex = SkinList:GetValue()
    state.selectedWeapon = weaponNames[weaponIndex]
    state.selectedSkin = skinNames[skinIndex]
    state.wear = WearSlider:GetValue() / 100
    state.seed = SeedSlider:GetValue()
    ApplySkin(state.selectedWeapon, state.selectedSkin)
end)

-- ============================================================
--  INIT
-- ============================================================
Window:SetOpenKey(gui.GetValue("adv.menukey"))

-- Auto-apply default
ApplySkin("Karambit", "Fade")

print("")
print("========================================")
print("  SKIN CHANGER LOADED")
print("========================================")
print("  Open Aimware menu -> Lua tab")
print("  Find 'Skin Changer' window")
print("========================================")
