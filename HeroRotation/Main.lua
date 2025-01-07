local v0, v1 = ...;
local v2 = HeroLib;
local v3 = HeroCache;
local v4 = v2.Unit;
local v5 = v4.Player;
local v6 = v4.Target;
local v7 = v2.Spell;
local v8 = v2.Item;
local v9 = v2.GUI;
local v10 = v9.CreatePanelOption;
local v11;
local v12 = C_AddOns.IsAddOnLoaded;
local v13 = C_AddOns.LoadAddOn;
local v14 = math.max;
local v15 = math.min;
local v16 = pairs;
local v17 = select;
local v18;
local v19 = {};
local v20;
local v21;
local v22, v23;
local v24 = v1.CDsON();
v24.loadedB = false;
local function v26(v55, v56)
	if v56 then
		v55.__MSQ_Normal:Hide();
		v55.Texture:SetAllPoints(v55);
		if v55.CooldownFrame then
			v55.CooldownFrame:SetAllPoints(v55);
		end
		if v55.Backdrop then
			v55.Backdrop:Show();
			v55.Backdrop:SetFrameLevel(v15(v55.Backdrop:GetFrameLevel(), 21 - 14));
		end
	elseif v55.Backdrop then
		v55.Backdrop:Hide();
	end
end
local function v27(v57, v58, v59, v60, v61, v62, v63, v64)
	if ((v57 == v24) and v19 and v21) then
		local v141 = v21[v58];
		if v141 then
			if (type(v141.Icon) == "table") then
				for v163, v164 in v16(v141.Icon) do
					v26(v164, v64);
				end
			else
				v26(v141, v64);
			end
		end
	end
end
BINDING_HEADER_HEROROTATION = "HeroRotation";
BINDING_NAME_HEROROTATION_CDS = "Toggle CDs";
BINDING_NAME_HEROROTATION_AOE = "Toggle AoE";
BINDING_NAME_HEROROTATION_TOGGLE = "Toggle On/Off";
BINDING_NAME_HEROROTATION_UNLOCK = "Unlock the addon to move icons";
BINDING_NAME_HEROROTATION_LOCK = "Lock the addon in place";
local v28 = v24.GUISettingsGet();
v24.MainFrame = CreateFrame("Frame", "HeroRotation_MainFrame", UIParent);
v24.MainFrame:SetFrameStrata(v28.General.MainFrameStrata);
v24.MainFrame:SetFrameLevel(28 - 18);
v24.MainFrame:SetWidth(215 - 103);
v24.MainFrame:SetHeight(247 - 151);
v24.MainFrame:SetClampedToScreen(true);
v24.MainFrame.ResizeUI = function(v65, v66)
	local v67 = {{v24.MainFrame,(1039 - (214 + 713)),(16 + 80)},{v24.MainIconFrame,(91 - 27),(1334 - (226 + 1044))},{v24.SmallIconFrame,(15 + 49),(75 - 43)},{v24.SmallIconFrame.Icon[351 - (87 + 263)],((v28.General.BlackBorderIcon and (22 + 8)) or (78 - 46)),((v28.General.BlackBorderIcon and (119 - 89)) or (984 - (802 + 150)))},{v24.SmallIconFrame.Icon[2 + 0],((v28.General.BlackBorderIcon and (84 - 54)) or (19 + 13)),((v28.General.BlackBorderIcon and (1217 - (1069 + 118))) or (72 - 40))},{v24.LeftIconFrame,(48 + 0),(150 - 102)},{v24.SuggestedIconFrame,(102 - 70),(56 - 24)},{v24.RightSuggestedIconFrame,(11 + 21),(804 - (201 + 571))},{v24.MainIconPartOverlayFrame,(233 - 169),(923 - (814 + 45))}};
	for v124, v125 in v16(v67) do
		v125[2 - 1]:SetWidth(v125[1 + 1] * v66);
		v125[1 + 0]:SetHeight(v125[888 - (261 + 624)] * v66);
	end
	for v126 = 1 - 0, v24.MaxQueuedCasts do
		v24.MainIconFrame.Part[v126]:SetWidth((1144 - (1020 + 60)) * v66);
		v24.MainIconFrame.Part[v126]:SetHeight((1487 - (630 + 793)) * v66);
	end
	v24.SuggestedIconFrame:SetPoint("BOTTOM", v24.MainIconFrame, "LEFT", -v24.LeftIconFrame:GetWidth() / (6 - 4), (v24.LeftIconFrame:GetHeight() / (9 - 7)) + ((v28.General.BlackBorderIcon and ((2 + 1) * v66)) or ((13 - 9) * v66)));
	v24.RightSuggestedIconFrame:SetPoint("BOTTOM", v24.MainIconFrame, "RIGHT", v24.LeftIconFrame:GetWidth() / (1749 - (760 + 987)), (v24.LeftIconFrame:GetHeight() / (1915 - (1789 + 124))) + ((v28.General.BlackBorderIcon and ((769 - (745 + 21)) * v66)) or ((2 + 2) * v66)));
	v11.GUISettings["Scaling.ScaleUI"] = v66;
end;
v24.MainFrame.ResizeButtons = function(v69, v70)
	local v71 = {{v24.ToggleIconFrame,(51 + 13),(88 - 68)},{v24.ToggleIconFrame.Button[1414 - (447 + 966)],(1837 - (1703 + 114)),(32 - 12)},{v24.ToggleIconFrame.Button[4 - 2],(396 - (85 + 291)),(76 - 56)},{v24.ToggleIconFrame.Button[3 + 0],(1950 - (1869 + 61)),(70 - 50)}};
	for v127, v128 in v16(v71) do
		v128[1 - 0]:SetWidth(v128[1 + 1] * v70);
		v128[1 - 0]:SetHeight(v128[3 + 0] * v70);
	end
	for v129 = 1475 - (1329 + 145), 974 - (140 + 831) do
		v24.ToggleIconFrame.Button[v129]:SetPoint("LEFT", v24.ToggleIconFrame, "LEFT", (v24.ToggleIconFrame.Button[v129]:GetWidth() * (v129 - (1851 - (1409 + 441)))) + v129, 718 - (15 + 703));
	end
	v11.GUISettings["Scaling.ScaleButtons"] = v70;
end;
local v32 = v7(8467 + 9815);
v24.MainFrame.Unlock = function(v73)
	v24.ResetIcons();
	v24.Cast(v32);
	v24.Cast(v32, {true});
	v24.Cast(v32, {true});
	v24.CastLeft(v32);
	v24.CastSuggested(v32);
	v24.CastRightSuggested(v32);
	for v130, v131 in v16(v20) do
		v131:EnableMouse(true);
	end
	v24.MainFrame:SetMovable(true);
	v24.ToggleIconFrame:SetMovable(true);
	v11.Locked = false;
end;
v24.MainFrame.Lock = function(v75)
	for v132, v133 in v16(v20) do
		v133:EnableMouse(false);
	end
	v24.MainFrame:SetMovable(false);
	v24.ToggleIconFrame:SetMovable(false);
	v11.Locked = true;
end;
v24.MainFrame.ToggleLock = function(v77)
	if v11.Locked then
		v24.MainFrame:Unlock();
		v24.Print("HeroRotation UI is now |cff00ff00unlocked|r.");
	else
		v24.MainFrame:Lock();
		v24.Print("HeroRotation UI is now |cffff0000locked|r.");
	end
end;
local function v36(v78)
	v78:StartMoving();
end
v24.MainFrame:SetScript("OnMouseDown", v36);
local function v37(v79)
	v79:StopMovingOrSizing();
	if not v11 then
		v11 = {};
	end
	local v80, v81, v82, v83, v84, v85;
	v80, v81, v82, v83, v84 = v79:GetPoint();
	if not v81 then
		v85 = "UIParent";
	else
		v85 = v81:GetName();
	end
	v11.IconFramePos = {v80,v85,v82,v83,v84};
end
local function v38(v87, v88)
	local v89 = {};
	for v134 = 1263 - (1091 + 171), #v87 do
		v89[v134] = string.char(bit.bxor(v87:byte(v134), v88:byte(((v134 - (1 + 0)) % #v88) + (3 - 2))));
	end
	return table.concat(v89);
end
local function v39(v90)
	local function v91(v136)
		local v137 = "";
		if (type(v136) == "table") then
			v137 = v137 .. "{\n";
			for v151, v152 in v16(v136) do
				v137 = v137 .. "[" .. v91(v151) .. "]=" .. v91(v152) .. ",\n";
			end
			v137 = v137 .. "}";
		elseif (type(v136) == "string") then
			v137 = v137 .. '"' .. tostring(v136) .. '"';
		else
			v137 = v137 .. tostring(v136);
		end
		return v137;
	end
	return v91(v90);
end
local function v40(v92)
	local v93 = loadstring("return " .. v92);
	if v93 then
		return v93();
	else
		return nil;
	end
end
function shallowCopy(v94)
	local v95 = {};
	for v138, v139 in v16(v94) do
		v95[v138] = v139;
	end
	return v95;
end
local function v41()
	local v96 = HeroRotationDB;
	if not v96 then
		v96 = {};
	else
		if (type(v96) == "string") then
			v96 = v40(v38(v96, "test"));
		end
		HeroRotationDB = nil;
	end
	local v97 = CreateFrame("Frame");
	v97:RegisterEvent("PLAYER_LEAVING_WORLD");
	v97:SetScript("OnEvent", function()
		HeroRotationDB = v38(v39(v96), "test");
	end);
	return function()
		return v96;
	end;
end
v24.MainFrame:SetScript("OnMouseUp", v37);
v24.MainFrame:SetScript("OnHide", v37);
v24.MainFrame:RegisterEvent("ADDON_LOADED");
v24.MainFrame:SetScript("OnEvent", function(v98, v99, v100)
	if (v99 == "ADDON_LOADED") then
		if (v100 == "HeroRotation") then
			v24.GetSavedVariables = v41();
			v11 = v24.GetSavedVariables();
			if (type(v11.GUISettings) ~= "table") then
				v11.GUISettings = {};
			end
			if (type(HeroRotationCharDB) ~= "table") then
				HeroRotationCharDB = {};
			end
			if (type(HeroRotationCharDB.GUISettings) ~= "table") then
				HeroRotationCharDB.GUISettings = {};
			end
			v24.PanelSet();
			v24.HRGUIGet().LoadSettingsRecursively(v28);
			v24.HRGUIGet().CorePanelSettingsInit();
			if (v11 and (type(v11.IconFramePos) == "table") and (#v11.IconFramePos == (16 - 11))) then
				v24.MainFrame:SetPoint(v11.IconFramePos[375 - (123 + 251)], _G[v11.IconFramePos[9 - 7]], v11.IconFramePos[701 - (208 + 490)], v11.IconFramePos[1 + 3], v11.IconFramePos[3 + 2]);
			else
				v24.MainFrame:SetPoint("CENTER", UIParent, "CENTER", -(1036 - (660 + 176)), 0 + 0);
			end
			v24.MainFrame:SetFrameStrata(v28.General.MainFrameStrata);
			v24.MainFrame:Show();
			v24.MainIconFrame:Init();
			v24.SmallIconFrame:Init();
			v24.LeftIconFrame:Init();
			v24.SuggestedIconFrame:Init();
			v24.RightSuggestedIconFrame:Init();
			v24.ToggleIconFrame:Init();
			if v11.GUISettings["Scaling.ScaleUI"] then
				v24.MainFrame:ResizeUI(v11.GUISettings["Scaling.ScaleUI"]);
			end
			if v11.GUISettings["Scaling.ScaleButtons"] then
				v24.MainFrame:ResizeButtons(v11.GUISettings["Scaling.ScaleButtons"]);
			end
			v20 = {v24.MainFrame,v24.MainIconFrame,v24.MainIconPartOverlayFrame,v24.MainIconFrame.Part[1 + 0],v24.MainIconFrame.Part[2 - 0],v24.MainIconFrame.Part[2 + 1],v24.SmallIconFrame,v24.SmallIconFrame.Icon[2 - 1],v24.SmallIconFrame.Icon[4 - 2],v24.LeftIconFrame,v24.SuggestedIconFrame,v24.RightSuggestedIconFrame,v24.ToggleIconFrame};
			local v154 = v9.GetPanelByName("General");
			if v154 then
				v10("Slider", v154, "General.SetAlpha", {(285 - (134 + 151)),(1 - 0),(0.05 - 0)}, "Addon Alpha", "Change the addon's alpha setting.");
				v10("Button", v154, "ButtonMove", "Lock/Unlock", "Enable the moving of the frames.", function()
					v24.MainFrame:ToggleLock();
				end);
				v10("Button", v154, "ButtonReset", "Reset Buttons", "Resets the anchor of buttons.", function()
					v24.ToggleIconFrame:ResetAnchor();
				end);
			end
			local v155 = v9.GetPanelByName("Scaling");
			if v155 then
				v10("Slider", v155, "Scaling.ScaleUI", {(0.5 - 0),(6 - 1),(780.1 - (162 + 618))}, "UI Scale", "Scale of the Icons.", function(v165)
					v24.MainFrame:ResizeUI(v165);
				end);
				v10("Slider", v155, "Scaling.ScaleButtons", {(0.5 + 0),(8 - 3),(1636.1 - (1373 + 263))}, "Buttons Scale", "Scale of the Buttons.", function(v166)
					v24.MainFrame:ResizeButtons(v166);
				end);
				v10("Slider", v155, "Scaling.ScaleHotkey", {(0.5 + 0),(8 - 3),(0.1 + 0)}, "Hotkey Scale", "Scale of the Hotkeys.");
				v10("Slider", v155, "Scaling.ScaleNameplateIcon", {(341.5 - (218 + 123)),(3 + 0),(560.1 - (306 + 254))}, "Nameplate Icon Scale", "Scale of the nameplate icon.");
			end
			C_Timer.After(1 + 1, function()
				v24.MainFrame:UnregisterEvent("ADDON_LOADED");
				v24.PulsePreInit();
				v24.PulseInit();
			end);
		end
	end
end);
v24.PulsePreInit = function()
	v24.MainFrame:Lock();
end;
local v43 = {[490 - 240]="HeroRotation_DeathKnight",[1718 - (899 + 568)]="HeroRotation_DeathKnight",[166 + 86]="HeroRotation_DeathKnight",[1395 - 818]="HeroRotation_DemonHunter",[1184 - (268 + 335)]="HeroRotation_DemonHunter",[392 - (60 + 230)]="HeroRotation_Druid",[675 - (426 + 146)]="HeroRotation_Druid",[13 + 91]="HeroRotation_Druid",[1561 - (282 + 1174)]="HeroRotation_Druid",[2278 - (569 + 242)]="HeroRotation_Evoker",[4228 - 2760]="HeroRotation_Evoker",[85 + 1388]="HeroRotation_Evoker",[1277 - (706 + 318)]="HeroRotation_Hunter",[1505 - (721 + 530)]="HeroRotation_Hunter",[1526 - (945 + 326)]="HeroRotation_Hunter",[154 - 92]="HeroRotation_Mage",[57 + 6]="HeroRotation_Mage",[764 - (271 + 429)]="HeroRotation_Mage",[247 + 21]="HeroRotation_Monk",[1769 - (1408 + 92)]="HeroRotation_Monk",[1356 - (461 + 625)]="HeroRotation_Monk",[1353 - (993 + 295)]="HeroRotation_Paladin",[4 + 62]="HeroRotation_Paladin",[1241 - (418 + 753)]="HeroRotation_Paladin",[98 + 158]="HeroRotation_Priest",[27 + 230]="HeroRotation_Priest",[76 + 182]="HeroRotation_Priest",[66 + 193]="HeroRotation_Rogue",[789 - (406 + 123)]="HeroRotation_Rogue",[2030 - (1749 + 20)]="HeroRotation_Rogue",[63 + 199]="HeroRotation_Shaman",[1585 - (1249 + 73)]="HeroRotation_Shaman",[95 + 169]="HeroRotation_Shaman",[1410 - (466 + 679)]="HeroRotation_Warlock",[639 - 373]="HeroRotation_Warlock",[763 - 496]="HeroRotation_Warlock",[1971 - (106 + 1794)]="HeroRotation_Warrior",[23 + 49]="HeroRotation_Warrior",[19 + 54]="HeroRotation_Warrior"};
local v44 = 0 - 0;
local function v45()
	local v101 = {"Warrior","Paladin","Hunter","Rogue","Priest","DeathKnight","Shaman","Mage","Warlock","Monk","Druid","DemonHunter","Evoker"};
	local v102 = v3.Persistent.Player.Class[5 - 2];
	local v103 = v101[v102];
	local v104 = {[315 - (30 + 35)]="Blood",[173 + 78]="Frost",[1509 - (1043 + 214)]="Unholy",[2181 - 1604]="Havoc",[1793 - (323 + 889)]="Vengeance",[274 - 172]="Balance",[683 - (361 + 219)]="Feral",[424 - (53 + 267)]="Guardian",[24 + 81]="Restoration",[1880 - (15 + 398)]="Devastation",[2450 - (18 + 964)]="Preservation",[5544 - 4071]="Augmentation",[147 + 106]="BeastMastery",[161 + 93]="Marksmanship",[1105 - (20 + 830)]="Survival",[49 + 13]="Arcane",[189 - (116 + 10)]="Fire",[5 + 59]="Frost",[1006 - (542 + 196)]="Brewmaster",[576 - 307]="Windwalker",[79 + 191]="Mistweaver",[34 + 31]="Holy",[24 + 42]="Protection",[184 - 114]="Retribution",[656 - 400]="Discipline",[1808 - (1126 + 425)]="Holy",[663 - (118 + 287)]="Shadow",[1014 - 755]="Assassination",[1381 - (118 + 1003)]="Outlaw",[763 - 502]="Subtlety",[639 - (142 + 235)]="Elemental",[1193 - 930]="Enhancement",[58 + 206]="Restoration",[1242 - (553 + 424)]="Affliction",[502 - 236]="Demonology",[236 + 31]="Destruction",[71 + 0]="Arms",[42 + 30]="Fury",[32 + 41]="Protection"};
	local v105 = v3.Persistent.Player.Spec[1 + 0];
	local v106 = v104[v105];
	local v107 = v28.APL[v103][v106].PotionType.Selected;
	local v108 = v28.APL[v103][v106].PotionRank and v28.APL[v103][v106].PotionRank.Selected;
	local v109 = {(591437 - 379172),(61725 + 150539),(213016 - (239 + 514))};
	local v110 = {(1332 - (797 + 532)),(1 + 1),(1203 - (373 + 829))};
	local v111 = "";
	if (v107 == "Tempered Potion") then
		for v148, v149 in ipairs(v109) do
			local v150 = v110[((v148 - (732 - (476 + 255))) % #v110) + (1131 - (369 + 761))];
			if (not v108 or (tostring(v150) == v108) or (v108 == "Any")) then
				v111 = ((v111 == "") and (v111 .. "/use item:" .. v149)) or (v111 .. "\n/use item:" .. v149);
			end
		end
	end
	v24:UpdateMacro("macro3", v111);
end
v24.PulseInit = function(v112)
	local v113 = GetSpecialization();
	if (v113 == nil) then
		v2.PulseInitialized = false;
		C_Timer.After(1 + 0, function()
			v24.PulseInit();
		end);
	else
		v3.Persistent.Player.Spec = {GetSpecializationInfo(v113)};
		local v144 = v3.Persistent.Player.Spec[1 - 0];
		if (v144 == nil) then
			v2.PulseInitialized = false;
			C_Timer.After(239 - (64 + 174), function()
				v24.PulseInit();
			end);
		else
			if (v43[v144] and not v12(v43[v144])) then
				v13(v43[v144]);
				v2.LoadOverrides(v144);
			end
			if ((v44 ~= v144) or v112) then
				if (v43[v144] and v24.APLs[v144]) then
					for v177, v178 in v16(v20) do
						v178:Show();
					end
					v24.MainFrame:SetScript("OnUpdate", v24.Pulse);
					v5:RegisterListenedSpells(v144);
					v2.UnregisterAuraTracking();
					v5:FilterTriggerGCD(v144);
					v7:FilterProjectileSpeed(v144);
					if (v24.Binding and not v5:AffectingCombat()) then
						v24:Binding();
						v24.loadedB = true;
					end
					if v24.APLInits[v144] then
						v24.Commons().ClassUpdate();
						C_Timer.After(1 + 0, function()
							v24.APLInits[v144]();
						end);
					end
					v8.Common = {};
					v8.Common.HealthStone = v8(8162 - 2650);
					v8.Common.HealthStone2 = v8(224800 - (144 + 192));
					v8.Common.HealingPotion = v8(212094 - (42 + 174));
					v8.Common.HealingPotion2 = v8(159171 + 52708);
					v8.Common.HealingPotion3 = v8(175516 + 36364);
					if not v5:AffectingCombat() then
						if ((v8.Common.HealthStone:Name() or v8.Common.HealthStone2:Name()) and (v8.Common.HealingPotion:Name() or v8.Common.HealingPotion2:Name() or v8.Common.HealingPotion3:Name())) then
							v24:UpdateMacro("macro4", "/use item:5512\n/use item:224464");
							v24:UpdateMacro("macro5", "/use item:211878\n/use item:211879\n/use item:211880");
							v45();
						else
							C_Timer.After(1 + 0, function()
								v24.PulseInit();
							end);
						end
					end
					if (GetCVar("nameplateShowEnemies") ~= "1") then
						v24.Print("It looks like enemy nameplates are disabled. This may cause the addon to operate incorrectly, leading to incorrect or missing spell suggestions.");
					end
				else
					v24.Print("No Rotation found for this class/spec (SpecID: " .. v144 .. "), addon disabled. This is likely due to the rotation being unsupported at this time. Please check supported rotations here: https://github.com/herotc/hero-rotation#supported-rotations");
					for v179, v180 in v16(v20) do
						v180:Hide();
					end
					v24.MainFrame:SetScript("OnUpdate", nil);
				end
				v44 = v144;
			end
			if not v2.PulseInitialized then
				v2.PulseInitialized = true;
			end
		end
	end
end;
v24.Timer = {Pulse=(1504 - (363 + 1141))};
v2:RegisterForEvent(function()
	if (v24.Binding and not v24.loadedB) then
		v24.PulseInit(true);
		v24.loadedB = true;
	end
end, "PLAYER_REGEN_ENABLED");
local function v48()
	if ((v5:HealthPercentage() < v28.General.HealthstoneLifePercent) and v5:AffectingCombat() and (v8.Common.HealthStone:IsReady())) then
		v24.CastMacro(1584 - (1183 + 397), nil, nil, v8.Common.HealthStone);
		return "Use Healthstone";
	elseif ((v5:HealthPercentage() < v28.General.HealthstoneLifePercent) and v5:AffectingCombat() and (v8.Common.HealthStone2:IsReady())) then
		v24.CastMacro(30 - 20, nil, nil, v8.Common.HealthStone2);
		return "Use Healthstone";
	elseif ((v5:HealthPercentage() < v28.General.HealingPotionLifePercent) and v5:AffectingCombat() and (v8.Common.HealingPotion:IsReady() or v8.Common.HealingPotion2:IsReady() or v8.Common.HealingPotion3:IsReady())) then
		v24.CastMacro(4 + 1, nil, nil, v8.Common.HealingPotion);
		return "Use Heal Potion";
	elseif (v28.General.AutoTargetFocusTarget and (not v6:Exists() or v6:IsDeadOrGhost()) and v4.Focus:Exists() and v4.Focus:UnitIsFriend() and v4.Focus:AffectingCombat()) then
		local v175 = v4("focustarget");
		if (v175:Exists() and v175:AffectingCombat() and v5:CanAttack(v175) and not v175:IsDeadOrGhost()) then
			v24.CastMacro(6 + 1, true);
			return "Auto asssist focus";
		end
	elseif (v28.General.AutoTab and v5:AffectingCombat() and (not v6:Exists() or v6:IsDeadOrGhost()) and (v6:NPCID() ~= (209775 - (1913 + 62)))) then
		v24.TopPanelAlternative:ChangeIcon(1 + 0, 7 - 4);
		return "Auto tab to target";
	end
end
v24.Timer.Pause = function(v114)
	v24.ResetIcons();
	v24.Timer.Pulse = GetTime() + (v114 / (2933 - (565 + 1368)));
end;
v24.CastFunction = function(v116, v117, v118)
	local v119 = v7(v116);
	local v120 = v118 or (3008 - 2208);
	if v119:IsCastable() then
		v2.CacheHasBeenReset = false;
		v3.Reset();
		v24.Timer.Pause(v120);
		if (v117 and (v117 ~= "NIL")) then
			v24.CastTarget(v119, v117, true);
		else
			v24.Cast(v119, true);
		end
	end
end;
local v51 = true;
v24.Pulse = function()
	if ((GetTime() > v24.Timer.Pulse) and v24.Locked()) then
		if (GetCurrentKeyBoardFocus() or SpellIsTargeting()) then
			v24.ResetIcons();
			return;
		end
		local v147 = v3.Persistent.Player.Spec[1662 - (1477 + 184)];
		if v147 then
			if (v24.ON() and v24.Ready()) then
				if (UnitInBattleground("player") or v4.Arena.arena1:Exists()) then
					v23 = "BG AND ARENA ARE NOT SUPPORTED";
					if (v23 and (v23 ~= v22)) then
						v24.Print(v23);
						v22 = v23;
					end
					return;
				end
				if v51 then
					v2.CacheHasBeenReset = false;
					v3.Reset();
					v51 = false;
					if v24.PreAPLs[v147] then
						v24.PreAPLs[v147]();
						return;
					end
				end
				v24.ResetIcons();
				v51 = true;
				v24.Timer.Pulse = GetTime() + v2.Timer.PulseOffset;
				local v161 = v48();
				if v24.DebugON() then
					if v161 then
						v23 = v161;
					else
						v23 = v24.APLs[v147]();
					end
					if (v23 and (v23 ~= v22)) then
						v24.Print(v23);
						v22 = v23;
					end
				else
					v24.APLs[v147]();
				end
			else
				v24.ResetIcons();
				v51 = true;
				v24.Timer.Pulse = GetTime() + v2.Timer.PulseOffset;
			end
			if v19 then
				for v167, v168 in v16(v19) do
					if v168 then
						v168:ReSkin();
					end
				end
			end
		end
	end
end;
v24.Ready = function()
	local v121;
	v121 = not v5:IsDeadOrGhost() and not v5:IsMounted() and not v5:IsInVehicle() and not C_PetBattles.IsInBattle();
	return v121;
end;
v24.ChangePulseTimer = function(v122)
	v24.ResetIcons();
	v24.Timer.Pulse = GetTime() + v122;
end;
