local v0, v1 = ...;
local v2 = HeroLib;
local v3 = v1.CDsON();
local v4 = v2.GUI;
local v5 = v4.CreatePanel;
local v6 = v4.CreateChildPanel;
local v7 = v4.CreatePanelOption;
local v8 = {General={MainFrameStrata="BACKGROUND",NamePlateIconAnchor="Clickable Area",ShowWhileMounted=false,BlackBorderIcon=false,HideKeyBinds=false,SoloMode=false,HideToggleIcons=false,SetAlpha=(2 - 1),AutoTab=false,AutoTargetFocusTarget=false,HealthstoneLifePercent=(57 - 37),HealingPotionLifePercent=(38 - 18)},Scaling={ScaleUI=(2 - 1),ScaleButtons=(620 - (555 + 64)),ScaleHotkey=(932 - (857 + 74)),ScaleNameplateIcon=(569 - (367 + 201))},APL={},Interrupt={Interrupt={AutoInterrupt=true,AutoStun=true,InterruptEverythingSolo=true,InterruptEverythingRaid=true,InterruptInDungeon="Whitelist",InterruptInDungeonUseStunAsInterrupt=true,InterruptPercent=(987 - (214 + 713)),InterruptPercentChannel=(16 + 44)}}};
v3.GUISettingsGet = function()
	return v8;
end;
local v4 = v3.HRGUIGet();
v4.CorePanelSettingsInit = function()
	local v11 = v5(v4, "HeroRotation", "PanelFrame", v3.GUISettingsGet, v3.GetSavedVariables().GUISettings);
	local function v12()
		local v17 = tonumber(GetCVar("UIScale")) or (1 + 0);
		v11:SetScale(v17);
	end
	local v13 = CreateFrame("Frame");
	v13:SetScript("OnEvent", function(v18, v19, ...)
		C_Timer.After(877.1 - (282 + 595), v12);
	end);
	v13:RegisterEvent("UI_SCALE_CHANGED");
	local v14 = v6(v11, "General");
	local v15 = v6(v11, "Scaling");
	local v16 = v6(v11, "Interrupt");
	v4.CreateARPanelOptions(v16, "Interrupt");
	v7("Dropdown", v14, "General.MainFrameStrata", {"HIGH","MEDIUM","LOW","BACKGROUND"}, "Main Frame Strata", "Choose the frame strata to use for icons.", {ReloadRequired=true});
	v7("Dropdown", v14, "General.NamePlateIconAnchor", {"Clickable Area","Life Bar","Disable"}, "Nameplate Icon Anchor", "Choose the frame to anchor the Nameplate icon to (or disable it).", {ReloadRequired=true});
	v7("CheckButton", v14, "General.ShowWhileMounted", "Show While Mounted", "Enable if you want the HeroRotation icon to show while mounted.");
	v7("CheckButton", v14, "General.BlackBorderIcon", "Black Border Icon", "Enable if you want clean black borders icons.", {ReloadRequired=true});
	v7("CheckButton", v14, "General.HideKeyBinds", "Hide Keybinds", "Enable if you want to hide the keybind on the icons.");
	v7("CheckButton", v14, "General.SoloMode", "Solo Mode", "Enable if you want to try to maximize survivability at the cost of dps.");
	v7("CheckButton", v14, "General.HideToggleIcons", "Hide toggle icons", "Enable if you want to hide the toggle buttons on the icon frame.", {ReloadRequired=true});
	v7("CheckButton", v14, "General.AutoTab", "Auto Target in combat", "Auto target when you are in combat and have no target.");
	v7("CheckButton", v14, "General.AutoTargetFocusTarget", "Auto Assist Focus", "Auto target your focus target when you are in combat and have no target.");
	v7("Slider", v14, "General.HealthstoneLifePercent", {(0 + 0),(238 - 138),(1 - 0)}, "Healthstone Health Percentage", "Minimum Health Percentage to use Healthstone");
	v7("Slider", v14, "General.HealingPotionLifePercent", {(180 - (67 + 113)),(245 - 145),(3 - 2)}, "Healing Potion Health Percentage", "Minimum Health Percentage to use Healing Potion");
	v3.HRGUIGet():Createicon();
	v12();
end;
