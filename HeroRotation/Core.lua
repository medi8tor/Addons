local v0, v1 = ...;
local v2 = HeroLib;
local v3, v4 = HeroCache, v2.Utils;
local v5 = v2.Unit;
local v6 = v5.Player;
local v7 = v5.Target;
local v8 = v2.Spell;
local v9 = v2.Item;
local v10 = math.min;
local v11 = print;
local v12 = select;
local v13 = string.lower;
local v14 = strsplit;
local v15 = tostring;
local v16 = GetTime;
local v17 = C_Item.GetItemInfo;
local v18 = C_AddOns.GetAddOnMetadata;
local v19 = C_Spell.GetSpellTexture;
local v20 = C_AddOns.IsAddOnLoaded;
local v21 = v1.CDsON();
HeroRotation = v1.CDsON;
v21.Print = function(...)
	v11("[|cFFFF6600Hero Rotation|r]", ...);
end;
v21.APLs = {};
v21.APLInits = {};
v21.PreAPLs = {};
v21.SetAPL = function(v71, v72, v73, v74)
	v21.APLs[v71] = v72;
	v21.APLInits[v71] = v73;
	v21.PreAPLs[v71] = v74;
end;
v21.GetTexture = function(v78)
	local v79 = v78.SpellID;
	if v79 then
		local v152 = v3.Persistent.Texture.Spell;
		if not v152[v79] then
			if (v79 >= (3126213 - 2126313)) then
				v152[v79] = "Interface\\Addons\\HeroRotation\\Textures\\" .. v15(v79);
			elseif v78.TextureSpellID then
				v152[v79] = v19(v78.TextureSpellID);
			else
				v152[v79] = v19(v79);
			end
		end
		return v152[v79];
	end
	local v80 = v78.ItemID;
	if v80 then
		local v153 = v3.Persistent.Texture.Item;
		if not v153[v80] then
			local v172, v172, v172, v172, v172, v172, v172, v172, v172, v173 = v17(v80);
			v153[v80] = v173;
		end
		return v153[v80];
	end
end;
local v29 = v8(175441 - 114137);
local v30, v31, v32;
local function v33(v81, v82, v83)
	local v84, v85;
	local v86 = v16();
	if (v6:IsCasting() or v6:IsChanneling()) then
		v84 = v6:CastStart();
		v85 = v6:CastDuration();
	else
		_, v84, _, v85 = v29:CooldownInfo();
	end
	if (v30 ~= v81) then
		v30 = v81;
		v31 = v86;
		v32 = 0 - 0;
	end
	if v82 then
		local v154;
		if v83 then
			v154 = v83;
		else
			local v175 = v81:CostInfo(nil, "type");
			if v175 then
				v154 = v6.TimeToXResourceMap[v175](v81:Cost());
			end
		end
		if (v154 and (v154 > (0 - 0))) then
			if (v154 > ((v84 + v85) - v86)) then
				local v183 = (v86 - v31) + v154;
				if (((v32 == (619 - (555 + 64))) and (v183 > (931.25 - (857 + 74)))) or (v32 > v183) or ((v183 - v32) > (568.5 - (367 + 201)))) then
					v32 = v183;
				end
				v84 = v31;
				v85 = v32;
			end
		end
	end
	if ((v84 + v85) < v86) then
		v84 = 927 - (214 + 713);
		v85 = 0 + 0;
		v30 = nil;
	end
	v21.MainIconFrame:SetCooldown(v84, v85);
end
local v34 = 0 + 0;
local function v35(v87)
	if v20("SpellFlashCore") then
		local v155 = v87.SpellID;
		local v156 = v87.ItemID;
		local v157 = 877.5 - (282 + 595);
		if (v155 and ((v16() - v34) > v157)) then
			SpellFlashCore.FlashAction(v155);
			v34 = v16();
		elseif (v156 and ((v16() - v34) > v157)) then
			SpellFlashCore.FlashItem(v156);
			v34 = v16();
		end
	end
end
local v36 = v21.GUISettingsGet();
v21.CastOffGCDOffset = 1638 - (1523 + 114);
v21.Cast = function(v88, v89, v90, v91, v92)
	local v93 = v21.GetTexture(v88);
	local v94 = not v36.General.HideKeyBinds and v2.Action.TextureHotKey(v93);
	v35(v88);
	local v95 = v6:GetEquipment();
	local v96, v97 = v95[12 + 1], v95[19 - 5];
	local v98 = v88:ID();
	if (v96 and (v98 == v96)) then
		v98 = 1078 - (68 + 997);
	elseif (v97 and (v98 == v97)) then
		v98 = 1284 - (226 + 1044);
	end
	if (v89 or (v90 == "Cooldown")) then
		if ((v21.CastOffGCDOffset == (4 - 3)) or ((v21.CastOffGCDOffset == (119 - (32 + 85))) and (v21.SmallIconFrame:GetIcon(1 + 0) ~= v93))) then
			v21.SmallIconFrame:ChangeIcon(v21.CastOffGCDOffset, v93, v94, v91, v98);
			v21.CastOffGCDOffset = v21.CastOffGCDOffset + 1 + 0;
			v88.LastDisplayTime = v16();
		end
	elseif (v90 == "Suggested") then
		v21.CastSuggested(v88, v91);
	elseif (v90 == "SuggestedRight") then
		v21.CastRightSuggested(v88, v91);
	end
	local v99 = ((v88.SpellID == (1000867 - (892 + 65))) or v88:IsUsable()) and (not v90 == "Pooling");
	local v100 = v90 == "Pooling";
	v33(v88, v100, v92);
	v21.MainIconFrame:ChangeIcon(v93, v94, v99, v91, v98);
	v88.LastDisplayTime = v16();
	return true;
end;
v21.CastMacro = function(v102, v103, v104, v105)
	if v103 then
		if ((v21.CastOffGCDOffset == (2 - 1)) or ((v21.CastOffGCDOffset == (3 - 1)) and (v21.SmallIconFrame:GetIcon(1 - 0) ~= (134750 - (87 + 263))))) then
			v21.SmallIconFrame:ChangeIcon(v21.CastOffGCDOffset, 134580 - (67 + 113), nil, v104, v102);
			v21.CastOffGCDOffset = v21.CastOffGCDOffset + 1 + 0;
			Object.LastDisplayTime = v16();
		end
	end
	local v106 = (v105 and v21.GetTexture(v105)) or (329974 - 195574);
	v21.MainIconFrame:ChangeIcon(v106, "Macro" .. v102, true, v104, v102);
	return true;
end;
v21.CastAnnotated = function(v107, v108, v109, v110, v111)
	local v112 = v21.Cast(v107, v108, nil, v110);
	if not v108 then
		v21.MainIconFrame:OverlayText(v109, v111);
	end
	return v112;
end;
v21.CastPooling = function(v113, v114, v115)
	return v21.Cast(v113, false, "Pooling", v115, v114);
end;
local v42, v43, v44, v45;
v21.MaxQueuedCasts = 3 + 0;
local function v47(...)
	v42 = {...};
	v43 = v10(#v42, v21.MaxQueuedCasts);
	v44 = {};
	v45 = {};
	for v146 = 953 - (802 + 150), v43 do
		v44[v146] = v21.GetTexture(v42[v146]);
		v42[v146].LastDisplayTime = v16();
		v45[v146] = not v36.General.HideKeyBinds and v2.Action.TextureHotKey(v44[v146]);
	end
	v35(v42[2 - 1]);
	v21.MainIconFrame:ChangeIcon(v44[1 - 0], v45[1 + 0], v42[998 - (915 + 82)]:IsUsable(), false, v42[2 - 1]:ID());
	v21.MainIconFrame:SetupParts(v44, v45);
end
v21.CastQueue = function(...)
	v47(...);
	v33();
	return "Should Return";
end;
v21.CastQueuePooling = function(v116, ...)
	v47(...);
	if v116 then
		v33(v42[1 + 0], true, v116);
	else
		local v158, v159 = nil, 0 - 0;
		for v171 = 1188 - (1069 + 118), #v42 do
			if (v42[v171]:Cost() > v159) then
				v159 = v42[v171]:Cost();
				v158 = v42[v171];
			end
		end
		v33(v158, true);
	end
	return "Should Return";
end;
v21.CastLeftOffset = 2 - 1;
v21.CastLeftCommon = function(v117)
	local v118 = v21.GetTexture(v117);
	local v119 = not v36.General.HideKeyBinds and v2.Action.TextureHotKey(v118);
	v35(v117);
	v21.LeftIconFrame:ChangeIcon(v118, v119);
	v21.CastLeftOffset = v21.CastLeftOffset + (1 - 0);
	v117.LastDisplayTime = v16();
end;
v21.CastLeft = function(v122)
	if (v21.CastLeftOffset == (1 + 0)) then
		v21.CastLeftCommon(v122);
	end
	return false;
end;
v21.CastLeftNameplate = function(v123, v124, v125)
	if ((v21.CastLeftOffset == (1 - 0)) and v21.Nameplate.AddIcon(v123, v124, v125)) then
		v21.CastLeftCommon(v124);
	end
	return false;
end;
v21.CastMainNameplate = function(v126, v127, v128)
	if v21.Nameplate.AddIcon(v126, v127, v128) then
		return v21.Cast(v127);
	end
	return false;
end;
v21.CastMainNameplateSuggested = function(v129, v130)
	if v21.Nameplate.AddSuggestedIcon(v129, v130) then
		return v21.CastRightSuggested(v130);
	end
	return false;
end;
v21.CastSuggestedOffset = 1 + 0;
v21.CastSuggested = function(v131, v132)
	if (v21.CastSuggestedOffset == (792 - (368 + 423))) then
		local v160 = v21.GetTexture(v131);
		local v161 = not v36.General.HideKeyBinds and v2.Action.TextureHotKey(v160);
		v35(v131);
		v21.SuggestedIconFrame:ChangeIcon(v160, v161, v132, v131:ID());
		v21.CastSuggestedOffset = v21.CastSuggestedOffset + (3 - 2);
		v131.LastDisplayTime = v16();
	end
	return false;
end;
v21.CastRightSuggestedOffset = 19 - (10 + 8);
v21.CastRightSuggested = function(v133, v134)
	if (v21.CastRightSuggestedOffset == (3 - 2)) then
		local v164 = v21.GetTexture(v133);
		local v165 = not v36.General.HideKeyBinds and v2.Action.TextureHotKey(v164);
		v35(v133);
		v21.RightSuggestedIconFrame:ChangeIcon(v164, v165, v134, v133:ID());
		v21.CastRightSuggestedOffset = v21.CastRightSuggestedOffset + (443 - (416 + 26));
		v133.LastDisplayTime = v16();
	end
	return false;
end;
v21.CmdHandler = function(v135)
	local v136, v137, v138, v139 = v14(" ", v13(v135));
	if (v136 == "cds") then
		HeroRotationCharDB.Toggles[3 - 2] = not HeroRotationCharDB.Toggles[1 + 0];
		v21.ToggleIconFrame:UpdateButtonText(1 - 0);
		v21.Print("CDs are now " .. ((HeroRotationCharDB.Toggles[439 - (145 + 293)] and "|cff00ff00enabled|r.") or "|cffff0000disabled|r."));
	elseif (v136 == "aoe") then
		HeroRotationCharDB.Toggles[432 - (44 + 386)] = not HeroRotationCharDB.Toggles[1488 - (998 + 488)];
		v21.ToggleIconFrame:UpdateButtonText(1 + 1);
		v21.Print("AoE is now " .. ((HeroRotationCharDB.Toggles[2 + 0] and "|cff00ff00enabled|r.") or "|cffff0000disabled|r."));
	elseif (v136 == "toggle") then
		HeroRotationCharDB.Toggles[775 - (201 + 571)] = not HeroRotationCharDB.Toggles[1141 - (116 + 1022)];
		v21.ToggleIconFrame:UpdateButtonText(12 - 9);
		v21.Print("HeroRotation is now " .. ((HeroRotationCharDB.Toggles[2 + 1] and "|cff00ff00enabled|r.") or "|cffff0000disabled|r."));
	elseif (v136 == "on") then
		HeroRotationCharDB.Toggles[10 - 7] = true;
		v21.ToggleIconFrame:UpdateButtonText(10 - 7);
		v21.Print("HeroRotation is now " .. ((HeroRotationCharDB.Toggles[862 - (814 + 45)] and "|cff00ff00enabled|r.") or "|cffff0000disabled|r."));
	elseif (v136 == "off") then
		HeroRotationCharDB.Toggles[7 - 4] = false;
		v21.ToggleIconFrame:UpdateButtonText(1 + 2);
		v21.Print("HeroRotation is now " .. ((HeroRotationCharDB.Toggles[2 + 1] and "|cff00ff00enabled|r.") or "|cffff0000disabled|r."));
	elseif ((v136 == "pause") and v137) then
		v21.Timer.Pause(tonumber(v137));
	elseif (v136 == "settings") then
		v21.HRGUIGet().SettingsShow();
	elseif (v136 == "unlock") then
		v21.MainFrame:Unlock();
		v21.Print("HeroRotation UI is now |cff00ff00unlocked|r.");
	elseif (v136 == "lock") then
		v21.MainFrame:Lock();
		v21.Print("HeroRotation UI is now |cffff0000locked|r.");
	elseif (v136 == "cast") then
		if v137 then
			if v139 then
				v139 = tonumber(v139);
			end
			if v138 then
				v138 = ((string.lower(v138) == "player2") and "PLAYER") or string.upper(v138);
			end
			v21.CastFunction(tonumber(v137), v138, v139);
		end
	elseif (v136 == "scale") then
		if (v137 and v138) then
			v138 = tonumber(v138);
			if (v138 and (type(v138) == "number") and (v138 > (885 - (261 + 624))) and (v138 <= (17 - 7))) then
				if (v137 == "ui") then
					v21.MainFrame:ResizeUI(v138);
				elseif (v137 == "buttons") then
					v21.MainFrame:ResizeButtons(v138);
				elseif (v137 == "all") then
					v21.MainFrame:ResizeUI(v138);
					v21.MainFrame:ResizeButtons(v138);
				else
					v21.Print("Invalid |cff88ff88[Type]|r for Scale.");
					v21.Print("Should be |cff8888ff/hr scale|r |cff88ff88[Type]|r |cffff8888[Size]|r.");
					v21.Print("Type accepted are |cff88ff88ui|r, |cff88ff88buttons|r, |cff88ff88all|r.");
				end
			else
				v21.Print("Invalid |cffff8888[Size]|r for Scale.");
				v21.Print("Should be |cff8888ff/hr scale|r |cff88ff88[Type]|r |cffff8888[Size]|r.");
				v21.Print("Size accepted are |cffff8888number > 0 and <= 10|r.");
			end
		else
			v21.Print("Invalid arguments for Scale.");
			v21.Print("Should be |cff8888ff/hr scale|r |cff88ff88[Type]|r |cffff8888[Size]|r.");
			v21.Print("Type accepted are |cff88ff88ui|r, |cff88ff88buttons|r, |cff88ff88all|r.");
			v21.Print("Size accepted are |cffff8888number > 0 and <= 10|r.");
		end
	elseif (v136 == "resetbuttons") then
		v21.ToggleIconFrame:ResetAnchor();
	elseif (v136 == "debug") then
		HeroRotationCharDB.Toggles[1084 - (1020 + 60)] = not HeroRotationCharDB.Toggles[1427 - (630 + 793)];
		v21.Print("Debug Output is now " .. (((HeroRotationCharDB.Toggles[13 - 9] == true) and "|cff00ff00enabled|r.") or "|cffff0000disabled|r."));
	elseif (v136 == "flash") then
		HeroRotationCharDB.Toggles[23 - 18] = not HeroRotationCharDB.Toggles[2 + 3];
		v21.Print("Icon Flashing is now " .. (((HeroRotationCharDB.Toggles[17 - 12] == true) and "|cff00ff00enabled|r.") or "|cffff0000disabled|r."));
	elseif (v136 == "help") then
		v21.Print("|cffffff00--[Toggles]--|r");
		v21.Print("  On/Off: |cff8888ff/hr toggle|r");
		v21.Print("  CDs: |cff8888ff/hr cds|r");
		v21.Print("  AoE: |cff8888ff/hr aoe|r");
		v21.Print("  Debug: |cff8888ff/hr debug|r");
		v21.Print("  Flash: |cff8888ff/hr flash|r");
		v21.Print("|cffffff00--[User Interface]--|r");
		v21.Print("  UI Lock: |cff8888ff/hr lock|r");
		v21.Print("  UI Unlock: |cff8888ff/hr unlock|r");
		v21.Print("  UI Scale: |cff8888ff/hr scale|r |cff88ff88[Type]|r |cffff8888[Size]|r");
		v21.Print("    [Type]: |cff88ff88ui|r, |cff88ff88buttons|r, |cff88ff88all|r");
		v21.Print("    [Size]: |cffff8888number > 0 and <= 10|r");
		v21.Print("  Button Anchor Reset : |cff8888ff/hr resetbuttons|r");
	elseif not v21.CmdHandlerCust(v136) then
		v21.Print("Invalid arguments.");
		v21.Print("Type |cff8888ff/hr help|r for more infos.");
	end
end;
v21.CmdHandlerPar = {};
v21.CmdHandlerName = {};
v21.CmdHandlerCust = function(v140)
	if v21.CmdHandlerPar[v140] then
		local v169 = v21.CmdHandlerPar[v140];
		HeroRotationCharDB.Toggles[v169 + (1749 - (760 + 987))] = not HeroRotationCharDB.Toggles[v169 + (1915 - (1789 + 124))];
		v21.ToggleIconFrame:UpdateButtonText(v169, 768 - (745 + 21));
		v21.Print(v21.CmdHandlerName[v140] .. " are now " .. ((HeroRotationCharDB.Toggles[v169 + 1 + 1] and "|cff00ff00enabled|r.") or "|cffff0000disabled|r."));
		return true;
	end
end;
SLASH_HEROROTATION1 = "/hr";
SLASH_HEROROTATION2 = "/ar";
SlashCmdList['HEROROTATION'] = v21.CmdHandler;
v21.ResetToggle = function()
	v21.CmdHandlerPar = {};
	v21.CmdHandlerName = {};
	local v143 = {v21.ToggleIconFrame:GetChildren()};
	for v150, v151 in ipairs(v143) do
		if (v150 > (11 - 8)) then
			v151:Hide();
		end
	end
end;
v21.CDsON = function()
	return HeroRotationCharDB.Toggles[1 + 0];
end;
v21.DebugON = function()
	return HeroRotationCharDB.Toggles[4 + 0];
end;
v21.FlashON = function()
	return HeroRotationCharDB.Toggles[1060 - (87 + 968)];
end;
do
	local v144 = {[531098 - 410447]=true};
	v21.AoEON = function()
		if not v6:AffectingCombat() then
			if (GetCVar("nameplateShowAll") ~= "1") then
				SetCVar("nameplateShowAll", 1 + 0);
			end
			if (GetCVar("nameplateShowEnemies") ~= "1") then
				SetCVar("nameplateShowEnemies", 2 - 1);
				v11("Enemy nameplates should be enabled");
			end
		end
		return HeroRotationCharDB.Toggles[1415 - (447 + 966)] and not v144[v7:NPCID()];
	end;
end
v21.ON = function()
	return HeroRotationCharDB.Toggles[8 - 5];
end;
v21.Locked = function()
	return v21.GetSavedVariables().Locked;
end;
