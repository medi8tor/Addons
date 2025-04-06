--- ============================ HEADER ============================
--- ======= LOCALIZE =======
-- Addon
local addonName, addonTable = ...
-- HeroLib
local HL = HeroLib
-- HeroRotation
local HR = HeroRotation()
-- File Locals
local GUI = HL.GUI
local CreateChildPanel = GUI.CreateChildPanel
local CreatePanelOption = GUI.CreatePanelOption
local CreateARPanelOption = HR.HRGUIGet().CreateARPanelOption
local CreateARPanelOptions = HR.HRGUIGet().CreateARPanelOptions
local GUISettings = HR.GUISettingsGet()
--- ============================ CONTENT ============================
-- Default settings
GUISettings.APL.Rogue = {
    Commons = {
        UseSoloVanish = false, -- don't vanish while solo
        Enabled = {
            Potions = true,
            Trinket1 = true,
            Trinket2 = true,
            Items = true,
            Shiv = true,
            Racials = true,
            IgnoreTtdOnBoss = true,
        },
        OnlyAttackEnnemyInCombat = true,
        OnlyAttackEnnemyInCombatSolo = false
    },
    Defense = {
        CrimsonVialHP = 30,
        EvasionHP = 30,
        FeintHP = 30,
        FeintDanger = true,
        CloakofShadowsHP = 30

    },
    Assassination = {
        EnvenomDMGOffset = 3,
        MutilateDMGOffset = 3,
        AlwaysSuggestGarrote = false,   -- Suggest Garrote even when Vanish is up
        UsePriorityRotation = "Toggle", -- Only for Assassination / Subtlety
        PotionType = {
            Selected = "Power"
        },
        PotionRank = {
            Selected = "Any"
        },
        TimeToDie = {
            Cooldowns = 15,
        }
    },
    Assassination_Interrupt = {
        Interrupt = {
            -- Interrupt
            AutoInterrupt = true,
            AutoStun = true,
            -- Interrupting everything when solo
            InterruptEverythingSolo = true,
            -- Interrupting everything when raid
            InterruptEverythingRaid = true,
            -- Interrupting list only when dungeon
            InterruptInDungeon = "Whitelist",
            InterruptInDungeonUseStunAsInterrupt = true,
            InterruptPercent = 60,
            InterruptPercentChannel = 60
        },
        UseBlind = true,
        UseCheapShop = true,
        UseKidneyShot = true
    },
    Outlaw = {
        -- Roll the Bones Logic, accepts "SimC", "1+ Buff" and every "RtBName".
        -- "SimC", "1+ Buff", "Broadside", "Buried Treasure", "Grand Melee", "Skull and Crossbones", "Ruthless Precision", "True Bearing"
        RolltheBonesLogic = "SimC",
        AutoTabGS = false,
        PotionType = {
            Selected = "Power"
        },
        PotionRank = {
            Selected = "Any"
        },
        AutoStealth = "near Target",
    },
    Outlaw_Interrupt = {
        Interrupt = {
            -- Interrupt
            AutoInterrupt = true,
            AutoStun = true,
            -- Interrupting everything when solo
            InterruptEverythingSolo = true,
            -- Interrupting everything when raid
            InterruptEverythingRaid = true,
            -- Interrupting list only when dungeon
            InterruptInDungeon = "Whitelist",
            InterruptInDungeonUseStunAsInterrupt = true,
            InterruptPercent = 60,
            InterruptPercentChannel = 60
        },
        UseBlind = true,
        --UseCheapShot = true,
        UseKidneyShot = true
    },
    Outlaw_TTD = {
        RacialsTTD = 20,  
        PotionsTTD = 20,
        TrinketsTTD = 20,
        VanishTTD = 20,
        AdrenalineRushTTD = 20,
        KeepItRollingTTD = 20,
        GhostlyStrikeTTD = 20,
        ThistleTeaTTD = 20, 
        KillingSpreeTTD = 20,
        BladeRushTTD = 20,
    },
    Outlaw_CDUSE = {
        Enemycount = 5,
        Racials = "with Cooldowns",
        Potions = "with Cooldowns",
        Trinket1 = "with Cooldowns",
        Trinket2 = "with Cooldowns",
        Vanish = "with Cooldowns",  
        AdrenalineRush = "with Cooldowns",
        GhostlyStrike = "with Cooldowns",
        KeepItRolling = "with Cooldowns",
        ThistleTea = "with Cooldowns",  
        KillingSpree = "with Cooldowns",
        BladeRush = "with Cooldowns",

    },  
    Subtlety = {
        EviscerateDMGOffset = 3,                       -- Used to compute the rupture threshold
        ShDEcoCharge = 1.75,                           -- Shadow Dance Eco Mode (Min Fractional Charges before using it while CDs are disabled)
        BurnShadowDance = "On Bosses not in Dungeons", -- Burn Shadow Dance charges when the target is about to die
        UsePriorityRotation = "Toggle",                -- Only for Assassination / Subtlety
        PotionType = {
            Selected = "Power"
        },
        PotionRank = {
            Selected = "Any"
        },

        StealthMacro = {
            Vanish = true,
            Shadowmeld = true,
            ShadowDance = true
        },
        TimeToDie = {
            Cooldowns = 15,
        }
    },
    Subtlety_Interrupt = {
        Interrupt = {
            -- Interrupt
            AutoInterrupt = true,
            AutoStun = true,
            -- Interrupting everything when solo
            InterruptEverythingSolo = true,
            -- Interrupting everything when raid
            InterruptEverythingRaid = true,
            -- Interrupting list only when dungeon
            InterruptInDungeon = "Whitelist",
            InterruptInDungeonUseStunAsInterrupt = true,
            InterruptPercent = 60,
            InterruptPercentChannel = 60
        },
        UseBlind = true,
        UseCheapShop = true,
        UseKidneyShot = true
    }

}

--[[ General = HR.GUISettings.General,
Commons = HR.GUISettings.APL.Rogue.Commons,
Outlaw = GUISettings.APL.Rogue.Outlaw,
Outlaw_TTD = GUISettings.APL.Rogue.Outlaw_TTD,
Outlaw_CDUSE = GUISettings.APL.Rogue.Outlaw_CDUSE,
Interrupt = GUISettings.APL.Rogue.Outlaw_Interrupt.Interrupt ]]


GUISettings.APL.Rogue.Commons.Enabled["Shiv Auto Target"] = true
GUISettings.APL.Rogue.Commons.Enabled["Tricks of Trade Focus"] = true
HR.HRGUIGet().LoadSettingsRecursively(GUISettings)
local DPSCooldownList =  {"Not Used" ,"with Cooldowns","small CDs" ,"with Cooldowns or AoE","on Enemycount or Cooldowns","on Boss or with Cooldowns","always" ,"on Boss only" ,"on Boss or on Enemycount" ,"on Boss or with Cooldowns","with Bloodlust only","small CDs" ,"with Cooldowns or AoE","on Enemycount or Cooldowns","on Enemycount","on Boss or on Enemycount"}
-- Child Panels
local ARPanel = HR.HRGUIGet().Panel
local CP_Rogue = CreateChildPanel(ARPanel, "Rogue")
local CP_Defense = CreateChildPanel(ARPanel, "Defense")
local CP_Assassination = CreateChildPanel(ARPanel, "Assassination")
local CP_Outlaw = CreateChildPanel(ARPanel, "Outlaw")
local CP_Outlaw_TTD = CreateChildPanel(ARPanel, "Outlaw_TTD")
local CP_Outlaw_CDUSE = CreateChildPanel(ARPanel, "Outlaw_CDUSE")

local CP_Subtlety = CreateChildPanel(ARPanel, "Subtlety")

local CP_Outlaw_Interrupt = CreateChildPanel(CP_Outlaw, "Interrupt")
CreateARPanelOptions(CP_Outlaw_Interrupt, "APL.Rogue.Outlaw_Interrupt")
CreatePanelOption("CheckButton", CP_Outlaw_Interrupt, "APL.Rogue.Outlaw_Interrupt.UseBlind", "Use Blind",
    "Use Blind for stun and or interrupt.")
--[[ CreatePanelOption("CheckButton", CP_Outlaw_Interrupt, "APL.Rogue.Outlaw_Interrupt.UseCheapShop", "Use Cheap Shot",
    "Use Cheap Shot for stun and or interrupt.") ]]
CreatePanelOption("CheckButton", CP_Outlaw_Interrupt, "APL.Rogue.Outlaw_Interrupt.UseKidneyShot", "Use Kidney Shot",
    "Use Kidney Shot for stun and or interrupt.")

local CP_Assassination_Interrupt = CreateChildPanel(CP_Assassination, "Interrupt")
CreateARPanelOptions(CP_Assassination_Interrupt, "APL.Rogue.Assassination_Interrupt")
CreatePanelOption("CheckButton", CP_Assassination_Interrupt, "APL.Rogue.Assassination_Interrupt.UseBlind", "Use Blind",
    "Use Blind for stun and or interrupt.")
CreatePanelOption("CheckButton", CP_Assassination_Interrupt, "APL.Rogue.Assassination_Interrupt.UseCheapShop",
    "Use Cheap Shot", "Use Cheap Shot for stun and or interrupt.")
CreatePanelOption("CheckButton", CP_Assassination_Interrupt, "APL.Rogue.Assassination_Interrupt.UseKidneyShot",
    "Use Kidney Shot", "Use Kidney Shot for stun and or interrupt.")

local CP_Subtlety_Interrupt = CreateChildPanel(CP_Subtlety, "Interrupt")
CreateARPanelOptions(CP_Subtlety_Interrupt, "APL.Rogue.Subtlety_Interrupt")
CreatePanelOption("CheckButton", CP_Subtlety_Interrupt, "APL.Rogue.Subtlety_Interrupt.UseBlind", "Use Blind",
    "Use Blind for stun and or interrupt.")
CreatePanelOption("CheckButton", CP_Subtlety_Interrupt, "APL.Rogue.Subtlety_Interrupt.UseCheapShop", "Use Cheap Shot",
    "Use Cheap Shot for stun and or interrupt.")
CreatePanelOption("CheckButton", CP_Subtlety_Interrupt, "APL.Rogue.Subtlety_Interrupt.UseKidneyShot", "Use Kidney Shot",
    "Use Kidney Shot for stun and or interrupt.")

-- Controls
-- Rogue

CreatePanelOption("CheckButton", CP_Rogue, "APL.Rogue.Commons.UseSoloVanish", "Use Vanish while Solo",
    "Suggest Vanish while Solo.\nDisable to save prevent mobs resetting.")
CreatePanelOption("CheckButton", CP_Rogue, "APL.Rogue.Commons.OnlyAttackEnnemyInCombat", "Only attack in combat",
    "Only attack enemy in combat.")
CreatePanelOption("CheckButton", CP_Rogue, "APL.Rogue.Commons.OnlyAttackEnnemyInCombatSolo",
    "Only attack in combat Solo", "Only attack enemy in combat when solo.")

CreateARPanelOptions(CP_Rogue, "APL.Rogue.Commons")
-- Defense
CreatePanelOption("Slider", CP_Defense, "APL.Rogue.Defense.CrimsonVialHP", { 0, 100, 1 }, "Crimson Vial HP",
    "Set the Crimson Vial HP threshold.")
CreatePanelOption("Slider", CP_Defense, "APL.Rogue.Defense.EvasionHP", { 0, 100, 1 }, "Evasion HP",
    "Set the Evasion HP threshold.")
CreatePanelOption("Slider", CP_Defense, "APL.Rogue.Defense.FeintHP", { 0, 100, 1 }, "Feint HP",
    "Set the Feint HP threshold.")
CreatePanelOption("CheckButton", CP_Defense, "APL.Rogue.Defense.FeintDanger",
    "Use Feint on danger", "Use feint on dangerous spell.")
CreatePanelOption("Slider", CP_Defense, "APL.Rogue.Defense.CloakofShadowsHP", { 0, 100, 1 }, "Cloak of Shadows HP",
    "Set the Cloak of Shadows HP threshold.")

CreateARPanelOptions(CP_Defense, "APL.Rogue.Defense")

-- Assassination
CreatePanelOption("Slider", CP_Assassination, "APL.Rogue.Assassination.EnvenomDMGOffset", { 1, 5, 0.25 },
    "Envenom DMG Offset", "Set the Envenom DMG Offset.")
CreatePanelOption("Slider", CP_Assassination, "APL.Rogue.Assassination.MutilateDMGOffset", { 1, 5, 0.25 },
    "Mutilate DMG Offset", "Set the Mutilate DMG Offset.")
CreatePanelOption("Dropdown", CP_Assassination, "APL.Rogue.Assassination.UsePriorityRotation",
    { "Toggle", "On Bosses" }, "Use Priority Rotation",
    "Select when to show rotation for maximum priority damage (at the cost of overall AoE damage.)\nAuto will function as Never except on specific encounters where AoE is not recommended.")
CreatePanelOption("CheckButton", CP_Assassination, "APL.Rogue.Assassination.AlwaysSuggestGarrote",
    "Always Suggest Garrote",
    "Don't prevent Garrote suggestions when using Subterfuge and Vanish is ready. These should ideally be synced, but can be useful if holding Vanish for specific fights.")
CreateARPanelOptions(CP_Assassination, "APL.Rogue.Assassination")
-- Outlaw


CreatePanelOption("Dropdown", CP_Outlaw, "APL.Rogue.Outlaw.RolltheBonesLogic",
    { "SimC", "1+ Buff", "Broadside", "Buried Treasure", "Grand Melee", "Skull and Crossbones", "Ruthless Precision",
        "True Bearing" }, "Roll the Bones Logic",
    "Define the Roll the Bones logic to follow.\n(SimC highly recommended!)")

CreatePanelOption("CheckButton", CP_Outlaw, "APL.Rogue.Outlaw.AutoTabGS",
    "Auto Target GS", "Auto Target Ghost Strike target.")
CreatePanelOption("Dropdown", CP_Outlaw, "APL.Rogue.Outlaw.AutoStealth",
    { "near Target", "Always" ,"never" }, "Auto Stealth",
    "Select when to use Auto Stealth.\nAuto Stealth will be used when you are not in combat and the target is in range.")
CreateARPanelOptions(CP_Outlaw, "APL.Rogue.Outlaw")

--cooldowns
--[[ Outlaw_TTD = GUISettings.APL.Rogue.Outlaw_TTD,
Outlaw_CDUSE = GUISettings.APL.Rogue.Outlaw_CDUSE, ]]
CreatePanelOption("Slider", CP_Outlaw_CDUSE, "APL.Rogue.Outlaw_CDUSE.Enemycount", { 0, 60, 1 }, "Mobcount",
  "Mobcount")

CreatePanelOption("Dropdown", CP_Outlaw_CDUSE, "APL.Rogue.Outlaw_CDUSE.Racials", DPSCooldownList,
  "Racials Usage", "Select how to use Racials.")

CreatePanelOption("Dropdown", CP_Outlaw_CDUSE, "APL.Rogue.Outlaw_CDUSE.Trinket1", DPSCooldownList,
  "Trinket 1 Usage", "Select how to use Trinket 1.")

CreatePanelOption("Dropdown", CP_Outlaw_CDUSE, "APL.Rogue.Outlaw_CDUSE.Trinket2", DPSCooldownList,
  "Trinket 2 Usage", "Select how to use Trinket 2.")

CreatePanelOption("Dropdown", CP_Outlaw_CDUSE, "APL.Rogue.Outlaw_CDUSE.Potions", DPSCooldownList,
  "Potion Usage", "Select how to use Potion.")

  CreatePanelOption("Dropdown", CP_Outlaw_CDUSE, "APL.Rogue.Outlaw_CDUSE.Vanish", DPSCooldownList,
  "Vanish", "Select how to use Vanish.")

  CreatePanelOption("Dropdown", CP_Outlaw_CDUSE, "APL.Rogue.Outlaw_CDUSE.AdrenalineRush", DPSCooldownList,
  "AdrenalineRush", "Select how to use AdrenalineRush.")

  CreatePanelOption("Dropdown", CP_Outlaw_CDUSE, "APL.Rogue.Outlaw_CDUSE.KeepItRolling", DPSCooldownList,
  "KeepItRolling", "Select how to use KeepItRolling.")
  
  CreatePanelOption("Dropdown", CP_Outlaw_CDUSE, "APL.Rogue.Outlaw_CDUSE.GhostlyStrike", DPSCooldownList,
  "GhostlyStrike", "Select how to use GhostlyStrike.")
  
  CreatePanelOption("Dropdown", CP_Outlaw_CDUSE, "APL.Rogue.Outlaw_CDUSE.ThistleTea", DPSCooldownList,
  "ThistleTea", "Select how to use ThistleTea.")
  
  CreatePanelOption("Dropdown", CP_Outlaw_CDUSE, "APL.Rogue.Outlaw_CDUSE.KillingSpree", DPSCooldownList,
  "KillingSpree", "Select how to use KillingSpree.")
  
  CreatePanelOption("Dropdown", CP_Outlaw_CDUSE, "APL.Rogue.Outlaw_CDUSE.BladeRush", DPSCooldownList,
  "BladeRush", "Select how to use BladeRush.")
  


CreateARPanelOptions(CP_Outlaw_CDUSE, "APL.Rogue.Outlaw_CDUSE")


--TTD

CreatePanelOption("Slider", CP_Outlaw_TTD, "APL.Rogue.Outlaw_TTD.RacialsTTD", { 0, 60, 1 }, "Racials TTD",
  "TTD to use Racials on Dungeon Mobs")
  CreatePanelOption("Slider", CP_Outlaw_TTD, "APL.Rogue.Outlaw_TTD.PotionsTTD", { 0, 60, 1 }, "PotionsTTD",
  "TTD to use Potions on Dungeon Mobs")
  CreatePanelOption("Slider", CP_Outlaw_TTD, "APL.Rogue.Outlaw_TTD.TrinketsTTD", { 0, 60, 1 }, "Trinkets TTD",
  "TTD to use Trinkets on Dungeon Mobs")
  CreatePanelOption("Slider", CP_Outlaw_TTD, "APL.Rogue.Outlaw_TTD.VanishTTD", { 0, 60, 1 }, "Vanish TTD",
  "TTD to use Vanish on Dungeon Mobs")
  CreatePanelOption("Slider", CP_Outlaw_TTD, "APL.Rogue.Outlaw_TTD.AdrenalineRushTTD", { 0, 60, 1 }, "Adrenaline Rush TTD",
  "TTD to use Adrenaline Rush on Dungeon Mobs")
  CreatePanelOption("Slider", CP_Outlaw_TTD, "APL.Rogue.Outlaw_TTD.KeepItRollingTTD", { 0, 60, 1 }, "Keep It Rolling TTD",
  "TTD to use Keep It Rolling on Dungeon Mobs")
  CreatePanelOption("Slider", CP_Outlaw_TTD, "APL.Rogue.Outlaw_TTD.GhostlyStrikeTTD", { 0, 60, 1 }, "Ghostly Strike TTD",
  "TTD to use Ghostly Rolling on Dungeon Mobs")
  CreatePanelOption("Slider", CP_Outlaw_TTD, "APL.Rogue.Outlaw_TTD.ThistleTeaTTD", { 0, 60, 1 }, "Thistle Tea TTD",
  "TTD to use Thistle Tea on Dungeon Mobs")
  CreatePanelOption("Slider", CP_Outlaw_TTD, "APL.Rogue.Outlaw_TTD.KillingSpreeTTD", { 0, 60, 1 }, "Killing Spree TTD",
  "TTD to use Killing Spree on Dungeon Mobs")
  CreatePanelOption("Slider", CP_Outlaw_TTD, "APL.Rogue.Outlaw_TTD.BladeRushTTD", { 0, 60, 1 }, "Blade Rush TTD",
  "TTD to use Blade Rush on Dungeon Mobs")

CreateARPanelOptions(CP_Outlaw_TTD, "APL.Rogue.Outlaw_TTD")
--[[ General = HR.GUISettings.General,
Commons = HR.GUISettings.APL.Rogue.Commons,
Outlaw = GUISettings.APL.Rogue.Outlaw,
Outlaw_TTD = GUISettings.APL.Rogue.Outlaw_TTD,
Outlaw_CDUSE = GUISettings.APL.Rogue.Outlaw_CDUSE,
Interrupt = GUISettings.APL.Rogue.Outlaw_Interrupt.Interrupt ]]

-- Subtlety
CreatePanelOption("Slider", CP_Subtlety, "APL.Rogue.Subtlety.EviscerateDMGOffset", { 1, 5, 0.25 },
    "Eviscerate Damage Offset", "Set the Eviscerate Damage Offset, used to compute the rupture threshold.")
CreatePanelOption("Slider", CP_Subtlety, "APL.Rogue.Subtlety.ShDEcoCharge", { 1, 2, 0.1 }, "ShD Eco Charge",
    "Set the Shadow Dance Eco Charge threshold.")
CreatePanelOption("Dropdown", CP_Subtlety, "APL.Rogue.Subtlety.UsePriorityRotation",
    { "Toggle", "On Bosses" }, "Use Priority Rotation",
    "Select when to show rotation for maximum priority damage (at the cost of overall AoE damage.)\nAuto will function as Never except on specific encounters where AoE is not recommended.")
CreatePanelOption("Dropdown", CP_Subtlety, "APL.Rogue.Subtlety.BurnShadowDance",
    { "Always", "On Bosses", "On Bosses not in Dungeons" }, "Burn Shadow Dance before Death",
    "Use remaining Shadow Dance charges when the target is about to die.")
CreatePanelOption("CheckButton", CP_Subtlety, "APL.Rogue.Subtlety.StealthMacro.Vanish", "Stealth Combo - Vanish",
    "Allow suggesting Vanish stealth ability combos (recommended)")
CreatePanelOption("CheckButton", CP_Subtlety, "APL.Rogue.Subtlety.StealthMacro.Shadowmeld",
    "Stealth Combo - Shadowmeld", "Allow suggesting Shadowmeld stealth ability combos (recommended)")
CreatePanelOption("CheckButton", CP_Subtlety, "APL.Rogue.Subtlety.StealthMacro.ShadowDance",
    "Stealth Combo - Shadow Dance", "Allow suggesting Shadow Dance stealth ability combos (recommended)")
CreateARPanelOptions(CP_Subtlety, "APL.Rogue.Subtlety")

local CP_Interrupt = GUI.GetPanelByName("Interrupt")
function GUISettings.APL.Rogue.AddCommonToggle()
    HR.ResetToggle()
    HR.ToggleIconFrame:AddButtonCustom("S", 1, "Stealth", "stealth");
    HR.ToggleIconFrame:AddButtonCustom("I", 3, "Interrupt", "interrupt");
end

function GUISettings.APL.Rogue.Outlaw.Display()
    HL.GUI.HidePanel(CP_Subtlety)
    HL.GUI.HidePanel(CP_Assassination)
    HL.GUI.ShowPanel(CP_Outlaw)

    HL.GUI.ShowPanel(CP_Outlaw_Interrupt)
    HL.GUI.ShowPanel(CP_Outlaw_TTD)
    HL.GUI.ShowPanel(CP_Outlaw_CDUSE)
    HL.GUI.HidePanel(CP_Assassination_Interrupt)
    HL.GUI.HidePanel(CP_Subtlety_Interrupt)
    HL.GUI.HidePanel(CP_Interrupt)

end

function GUISettings.APL.Rogue.Assassination.Display()
    GUISettings.APL.Rogue.AddCommonToggle()
    HR.ToggleIconFrame:AddButtonCustom("P", 2, "Priority", "priority")
    HR.ToggleIconFrame:AddButtonCustom("S", 4, "Small CDs", "smallcds")
    HL.GUI.HidePanel(CP_Subtlety)
    HL.GUI.ShowPanel(CP_Assassination)
    HL.GUI.HidePanel(CP_Outlaw)

    HL.GUI.HidePanel(CP_Outlaw_Interrupt)
    HL.GUI.HidePanel(CP_Outlaw_TTD)
    HL.GUI.HidePanel(CP_Outlaw_CDUSE)
    HL.GUI.ShowPanel(CP_Assassination_Interrupt)
    HL.GUI.HidePanel(CP_Subtlety_Interrupt)
    HL.GUI.HidePanel(CP_Interrupt)
end

function GUISettings.APL.Rogue.Subtlety.Display()
    GUISettings.APL.Rogue.AddCommonToggle()
    HR.ToggleIconFrame:AddButtonCustom("P", 2, "Priority", "priority")
    HR.ToggleIconFrame:AddButtonCustom("S", 4, "Small CDs", "smallcds")
    HL.GUI.ShowPanel(CP_Subtlety)
    HL.GUI.HidePanel(CP_Assassination)
    HL.GUI.HidePanel(CP_Outlaw)

    HL.GUI.HidePanel(CP_Outlaw_Interrupt)
    HL.GUI.HidePanel(CP_Outlaw_TTD)
    HL.GUI.HidePanel(CP_Outlaw_CDUSE)
    HL.GUI.HidePanel(CP_Assassination_Interrupt)
    HL.GUI.ShowPanel(CP_Subtlety_Interrupt)
    HL.GUI.HidePanel(CP_Interrupt)
end
