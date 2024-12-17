local v0, v1 = ...;
local v2 = v1.CDsON();
local v3 = HeroLib;
local v4 = HeroCache;
local v5 = v3.Unit;
local v6 = v5.Player;
local v7 = v5.Target;
local v8 = v3.Spell;
local v9 = v3.Item;
local v10 = v2.GUISettingsGet();
local v11 = pairs;
local v12 = string.lower;
local v13 = tostring;
local v14 = math.floor;
v2.MainIconFrame = CreateFrame("Frame", "HeroRotation_MainIconFrame", UIParent);
v2.MainIconPartOverlayFrame = CreateFrame("Frame", "HeroRotation_MainIconPartOverlayFrame", UIParent);
v2.MainIconFrame.Part = {};
v2.MainIconFrame.CooldownFrame = CreateFrame("Cooldown", "HeroRotation_MainIconCooldownFrame", v2.MainIconFrame, "AR_CooldownFrameTemplate");
v2.SmallIconFrame = CreateFrame("Frame", "HeroRotation_SmallIconFrame", UIParent);
v2.LeftIconFrame = CreateFrame("Frame", "HeroRotation_LeftIconFrame", UIParent);
v2.NameplateIconFrame = CreateFrame("Frame", "HeroRotation_NameplateIconFrame", UIParent);
v2.NameplateSuggestedIconFrame = CreateFrame("Frame", "HeroRotation_NameplateSuggestedIconFrame", UIParent);
v2.SuggestedIconFrame = CreateFrame("Frame", "HeroRotation_SuggestedIconFrame", UIParent);
v2.RightSuggestedIconFrame = CreateFrame("Frame", "HeroRotation_RightSuggestedIconFrame", UIParent);
v2.ToggleIconFrame = CreateFrame("Frame", "HeroRotation_ToggleIconFrame", UIParent);
v2.TopPanelAlternative = {};
local v27 = {};
local v28 = {};
v2.TName = function()
	return v28;
end;
local v30 = 0 - 0;
v3:RegisterForEvent(function(v93)
	if (GetTime() > v30) then
		local v332 = GetSpecialization();
		if (v332 ~= nil) then
			v332 = GetSpecializationInfo(v332);
			if (v332 ~= nil) then
				v2.TopPanelAlternative:ChangeIcon(v332, 5 - 3);
				v30 = GetTime() + (5 - 2);
			end
		end
	end
end, "PLAYER_SPECIALIZATION_CHANGED", "PLAYER_ENTERING_WORLD");
v2.PixelPerfectFrame = function(v94, v95)
	local v96 = "MoLibPixelPerfect";
	local v97 = UIParent;
	if v95 then
		v96 = v96 .. "Screen";
		v97 = nil;
	end
	v96 = v96 .. "Frame";
	return v94:pixelPerfectFrame(v96, v97);
end;
v2.pixelPerfectFrame = function(v98, v99, v100)
	if (v99 and _G[v99]) then
		return _G[v99];
	end
	local v101 = CreateFrame("Frame", v99, v100);
	v101:SetPoint("BOTTOMLEFT", 0 - 0, 619 - (555 + 64));
	v98:PixelPerfectScale(v101);
	v101:Show();
	v101:SetScript("OnEvent", v98.OnPPEvent);
	v101:RegisterEvent("DISPLAY_SIZE_CHANGED");
	if ((v100 ~= nil) and (v100 ~= WorldFrame)) then
		v101:RegisterEvent("UI_SCALE_CHANGED");
	end
	return v101;
end;
v2.PixelPerfectScale = function(v102, v103)
	local v104, v105 = GetPhysicalScreenSize();
	local v106 = v103:GetParent();
	if not v106 then
		v103:SetScale(932 - (857 + 74));
		v103:SetAllPoints();
		v106 = v103;
	else
		v103:SetSize(v104, v105);
	end
	local v107 = v106:GetWidth() / v104;
	local v108 = v106:GetHeight() / v105;
	v103:SetScale(v107);
end;
local v34 = v2.GetTexture(v8(1000468 - (367 + 201)));
v2.ResetIcons = function()
	v2.MainIconFrame:Hide();
	if v10.General.BlackBorderIcon then
		v2.MainIconFrame.Backdrop:Hide();
	end
	v2.MainIconPartOverlayFrame:Hide();
	v2.MainIconFrame:HideParts();
	v2.SmallIconFrame:HideIcons();
	v2.CastOffGCDOffset = 928 - (214 + 713);
	v2.Nameplate.HideIcons();
	v2.CastLeftOffset = 1 + 0;
	v2.SuggestedIconFrame:HideIcon();
	if v10.General.BlackBorderIcon then
		v2.SuggestedIconFrame.Backdrop:Hide();
	end
	v2.CastSuggestedOffset = 1 + 0;
	v2.RightSuggestedIconFrame:HideIcon();
	if v10.General.BlackBorderIcon then
		v2.RightSuggestedIconFrame.Backdrop:Hide();
	end
	v2.CastRightSuggestedOffset = 878 - (282 + 595);
	if v10.General.HideToggleIcons then
		v2.ToggleIconFrame:Hide();
	end
	if not v10.General.HideToggleIcons then
		v2.ToggleIconFrame:SetAlpha(v10.General.SetAlpha);
	end
end;
v2.CreateBackdrop = function(v113, v114, v115)
	if (v114.Backdrop or not v10.General.BlackBorderIcon) then
		return;
	end
	local v116 = CreateFrame("Frame", nil, v114, BackdropTemplateMixin and "BackdropTemplate");
	v114.Backdrop = v116;
	v116:ClearAllPoints();
	v116:SetPoint("TOPLEFT", v114, "TOPLEFT", -(1638 - (1523 + 114)), 1 + 0);
	v116:SetPoint("BOTTOMRIGHT", v114, "BOTTOMRIGHT", 1 - 0, -(1066 - (68 + 997)));
	v116:SetBackdrop({bgFile="Interface\\ChatFrame\\ChatFrameBackground",edgeFile="Interface\\ChatFrame\\ChatFrameBackground",tile=false,tileSize=(1270 - (226 + 1044)),edgeSize=(4 - 3),insets={left=(117 - (32 + 85)),right=(0 + 0),top=(0 + 0),bottom=(957 - (892 + 65))}});
	v116:SetBackdropBorderColor(0 - 0, 0 - 0, 0 - 0);
	v116:SetBackdropColor(350 - (87 + 263), 180 - (67 + 113), 0 + 0, 2 - 1);
	if not v115 then
		v115 = v2.MainFrame:GetFrameStrata();
	end
	v116:SetFrameStrata(v115);
	if ((v114:GetFrameLevel() - (2 + 0)) >= (0 - 0)) then
		v116:SetFrameLevel(v114:GetFrameLevel() - (954 - (802 + 150)));
	else
		v116:SetFrameLevel(0 - 0);
	end
end;
local function v37()
	if (GetCVar("Contrast") ~= "50") then
		SetCVar("Contrast", 90 - 40);
		print("Contrast should be 50");
	end
	if (GetCVar("Brightness") ~= "50") then
		SetCVar("Brightness", 37 + 13);
		print("Brightness should be 50");
	end
	if (GetCVar("Gamma") ~= "1.000000") then
		SetCVar("Gamma", "1.000000");
		print("Gamma should be 1");
	end
	if (GetCVar("colorblindsimulator") ~= "0") then
		SetCVar("colorblindsimulator", 997 - (915 + 82));
	end
	if (GetCVar("doNotFlashLowHealthWarning") ~= "1") then
		SetCVar("doNotFlashLowHealthWarning", 2 - 1);
	end
	if (GetCVar("screenshotQuality") ~= "10") then
		SetCVar("screenshotQuality", 6 + 4);
	end
	if (GetCVar("nameplateShowAll") == "0") then
	end
	if (GetCVar("nameplateShowEnemies") ~= "1") then
		SetCVar("nameplateShowEnemies", 1 - 0);
		print("Enemy nameplates should be enabled");
	end
	if (GetCVar("SpellQueueWindow") ~= "250") then
		SetCVar("SpellQueueWindow", 1437 - (1069 + 118));
	end
	if (GetCVar("synchronizeMacros") ~= "1") then
		SetCVar("synchronizeMacros", 0 - 0);
	end
	if (GetCVar("synchronizeConfig ") ~= "1") then
		SetCVar("synchronizeConfig ", 0 - 0);
	end
end
v2.UpdateMacro = function(v118, v119, v120)
	local v121 = select(1 + 1, UnitClass("player"));
	local v122 = GetSpecialization();
end;
v27.Init = function(v123)
	v27.MOUSEOVER = 1 - 0;
	v27.FOCUS = 2 + 0;
	v27.PLAYER = 794 - (368 + 423);
	v27.PARTYPLAYER = 314 - 214;
	for v290 = 19 - (10 + 8), 15 - 11 do
		v27["PARTY" .. v290] = (452 - (416 + 26)) + v290;
	end
	for v292 = 3 - 2, 18 + 22 do
		v27["RAID" .. v292] = (176 - 76) + v292;
	end
end;
v28.Init = function(v128)
	v28.MOUSEOVER = "MOUSEOVER";
	v28.FOCUS = "FOCUS";
	v28.PLAYER = "PLAYER";
	v28.PARTYPLAYER = "PARTYPLAYER";
	for v294 = 439 - (145 + 293), 434 - (44 + 386) do
		v28["PARTY" .. v294] = "PARTY" .. v294;
	end
	for v296 = 1487 - (998 + 488), 13 + 27 do
		v28["RAID" .. v296] = "RAID" .. v296;
	end
end;
v2.Ascended = v2.Ascended or {};
v2.Ascended.SpellID = 0 + 0;
v2.Ascended.TargetOffset = 772 - (201 + 571);
v2.Ascended.SpecID = 1138 - (116 + 1022);
v2.Ascended.AutoTab = 0 - 0;
v2.Ascended.four = 0 + 0;
v2.Ascended.five = 0 - 0;
v2.Ascended.six = 0 - 0;
v2.Ascended.seven = 859 - (814 + 45);
v2.MainIconFrame.Init = function(v133)
	v37();
	v27:Init();
	v28:Init();
	v2.TopPanelAlternative.topIcons = v2:PixelPerfectFrame("TopIcons");
	v2.TopPanelAlternative.topIcons:SetFrameStrata("HIGH");
	v2.TopPanelAlternative.Icons = {};
	local v136 = 2 - 1;
	v2.DelayTimer = 0 + 0;
	local v138 = GetSpecialization();
	if (v138 ~= nil) then
		v138 = GetSpecializationInfo(v138);
		if (v138 ~= nil) then
			v2.TopPanelAlternative:ChangeIcon(v138, 1 + 1);
			v30 = GetTime() + (888 - (261 + 624));
		end
	end
	v133:SetFrameStrata(v2.MainFrame:GetFrameStrata());
	v133:SetFrameLevel(v2.MainFrame:GetFrameLevel() - (1 - 0));
	v133:SetWidth(1144 - (1020 + 60));
	v133:SetHeight(1487 - (630 + 793));
	v133:SetPoint("BOTTOMRIGHT", v2.MainFrame, "BOTTOMRIGHT", 0 - 0, 0 - 0);
	v133.Texture = v133:CreateTexture(nil, "ARTWORK");
	v133.Texture:SetAllPoints(v133);
	v133.CooldownFrame:SetAllPoints(v133);
	v2.MainIconPartOverlayFrame:SetFrameStrata(v133:GetFrameStrata());
	v2.MainIconPartOverlayFrame:SetFrameLevel(v133:GetFrameLevel() + 1 + 0);
	v2.MainIconPartOverlayFrame:SetWidth(220 - 156);
	v2.MainIconPartOverlayFrame:SetHeight(1811 - (760 + 987));
	v2.MainIconPartOverlayFrame:SetPoint("Left", v133, "Left", 1913 - (1789 + 124), 766 - (745 + 21));
	v2.MainIconPartOverlayFrame.Texture = v2.MainIconPartOverlayFrame:CreateTexture(nil, "ARTWORK");
	v2.MainIconPartOverlayFrame.Texture:SetAllPoints(v2.MainIconPartOverlayFrame);
	local v141 = v133:CreateFontString(nil, "OVERLAY", "GameFontHighlight");
	v133.Keybind = v141;
	v141:SetFont("Fonts\\FRIZQT__.TTF", 5 + 9, "OUTLINE");
	v141:SetAllPoints(true);
	v141:SetJustifyH("RIGHT");
	v141:SetJustifyV("TOP");
	v141:SetPoint("TOPRIGHT");
	v141:SetTextColor(0.8 - 0, 0.8 - 0, 0.8 + 0, 1 + 0);
	v141:SetText("");
	local v143 = v133:CreateFontString(nil, "OVERLAY", "GameFontHighlight");
	v133.Target = v143;
	v143:SetFont("Fonts\\FRIZQT__.TTF", 1065 - (87 + 968), "OUTLINE");
	v143:SetAllPoints(true);
	v143:SetJustifyH("Center");
	v143:SetJustifyV("MIDDLE");
	v143:SetPoint("TOPRIGHT");
	v143:SetTextColor(0.8 - 0, 0.8 + 0, 0.8 - 0, 1414 - (447 + 966));
	v143:SetText("");
	local v145 = v133:CreateFontString(nil, "OVERLAY", "GameFontNormal");
	v133.Text = v145;
	v145:SetAllPoints(true);
	v145:SetJustifyH("CENTER");
	v145:SetJustifyV("MIDDLE");
	v145:SetPoint("CENTER");
	v145:SetTextColor(2 - 1, 1818 - (1703 + 114), 702 - (376 + 325), 1 - 0);
	v145:SetText("");
	if v10.General.BlackBorderIcon then
		v133.Texture:SetTexCoord(0.08 - 0, 0.92 + 0, 0.08 - 0, 14.92 - (9 + 5));
		v2:CreateBackdrop(v133);
	end
	v133:InitParts();
	v133:Show();
end;
v2.TopPanelAlternative.ChangeIcon = function(v147, v148, v149)
	if ((v148 < (376 - (85 + 291))) or (v148 > (((1520 - (243 + 1022)) ^ (11 - 8)) - (1 + 0)))) then
		print("Input out of range");
		return;
	end
	if (v149 == (1180 - (1123 + 57))) then
		v2.Ascended.SpellID = v148;
	elseif (v149 == (1 + 0)) then
		v2.Ascended.TargetOffset = v148;
	elseif (v149 == (256 - (163 + 91))) then
		v2.Ascended.SpecID = v148;
	elseif (v149 == (1933 - (1869 + 61))) then
		v2.Ascended.AutoTab = v148;
	elseif (v149 == (2 + 2)) then
		v2.Ascended.four = v148;
	elseif (v149 == (17 - 12)) then
		v2.Ascended.five = v148;
	elseif (v149 == (8 - 2)) then
		v2.Ascended.six = v148;
	elseif (v149 == (1 + 6)) then
		v2.Ascended.seven = v148;
	end
	if (v2.Ascended.AutoTab ~= (0 - 0)) then
	end
	if (v2.Ascended.TargetOffset ~= (0 + 0)) then
	end
end;
v2.MainIconFrame.ChangeIcon = function(v150, v151, v152, v153, v154, v155)
	v150.ID = v155;
	v150.Texture:SetTexture(v151);
	if ((v153 == false) and (not v153 == nil)) then
		v150.Texture:SetVertexColor(1474.5 - (1329 + 145), 971.5 - (140 + 831), 1851 - (1409 + 441));
	elseif v154 then
		v150.Texture:SetVertexColor(719 - (15 + 703), 0.5 + 0, 438.5 - (262 + 176));
		if not v2.Instant then
			v2.TopPanelAlternative:ChangeIcon(1721 - (345 + 1376), 688 - (198 + 490));
		end
	else
		if not v2.Instant then
			if (GetTime() > v2.DelayTimer) then
				v2.TopPanelAlternative:ChangeIcon(v155, 0 - 0);
			else
				v2.TopPanelAlternative:ChangeIcon(0 - 0, 1206 - (696 + 510));
			end
		end
		v150.Texture:SetVertexColor(1 - 0, 1263 - (1091 + 171), 1 + 0);
	end
	v150.Texture:SetAllPoints(v150);
	if v152 then
		v150.Keybind:SetText(v152);
		v150.Keybind:SetScale(v10.Scaling.ScaleHotkey);
	else
		v150.Keybind:SetText("");
	end
	v150.Text:SetText("");
	if (v10.General.BlackBorderIcon and not v150.Backdrop:IsVisible()) then
		v150.Backdrop:Show();
	end
	v150:SetAlpha(v10.General.SetAlpha);
	if not v150:IsVisible() then
		v150:Show();
	end
end;
v2.MainIconFrame.OverlayText = function(v157, v158, v159)
	local v160 = v157.Text:GetFont();
	if v159 then
		v157.Text:SetFont(v160, v159);
	else
		v157.Text:SetFont(v160, 37 - 25);
	end
	v157.Text:SetText(v158);
end;
v2.MainIconFrame.SetCooldown = function(v161, v162, v163)
	if ((v162 == (0 - 0)) or (v163 == (374 - (123 + 251)))) then
		v161.CooldownFrame:SetCooldown(0 - 0, 698 - (208 + 490));
		v161.CooldownFrame:Hide();
		v2.DelayTimer = 0 + 0;
		return;
	end
	v2.DelayTimer = (v162 + v163) - (0.3 + 0);
	v161.CooldownFrame:SetCooldown(v162, v163);
end;
v2.MainIconFrame.InitParts = function(v165)
	v2.MainIconPartOverlayFrame:Show();
	for v298 = 837 - (660 + 176), v2.MaxQueuedCasts do
		local v299 = CreateFrame("Frame", "HeroRotation_MainIconPartFrame" .. v13(v298), UIParent);
		v165.Part[v298] = v299;
		v299:SetFrameStrata(v165:GetFrameStrata());
		v299:SetFrameLevel(v165:GetFrameLevel() + 1 + 0);
		v299:SetWidth(266 - (14 + 188));
		v299:SetHeight(739 - (534 + 141));
		v299:SetPoint("Left", v165, "Left", 0 + 0, 0 + 0);
		v299.Texture = v299:CreateTexture(nil, "BACKGROUND");
		v299.Keybind = v165:CreateFontString(nil, "OVERLAY", "GameFontHighlight");
		v299.Keybind:SetFont("Fonts\\FRIZQT__.TTF", 13 + 0, "OUTLINE");
		v299.Keybind:SetAllPoints(true);
		v299.Keybind:SetJustifyH("RIGHT");
		v299.Keybind:SetJustifyV("TOP");
		v299.Keybind:SetPoint("TOPRIGHT");
		v299.Keybind:SetTextColor(0.8 - 0, 0.8 - 0, 0.8 - 0, 1 + 0);
		v299.Keybind:SetText("");
		if v10.General.BlackBorderIcon then
			v299.Texture:SetTexCoord(0.08 + 0, 396.92 - (115 + 281), 0.08 - 0, 0.92 + 0);
			v2:CreateBackdrop(v299);
		end
		v299:Show();
	end
end;
local v56, v57;
v2.MainIconFrame.SetupParts = function(v166, v167, v168)
	v56 = #v167;
	v57 = v2.MainIconPartOverlayFrame.Texture:GetWidth() / v56;
	local v169, v170, v171, v172, v173, v174, v175, v176 = v2.MainIconPartOverlayFrame.Texture:GetTexCoord();
	for v303 = 2 - 1, v56 do
		local v304 = v166.Part[v303];
		v304:SetWidth(v57);
		v304:SetHeight(v57 * v56);
		v304:ClearAllPoints();
		local v305, v306 = v2.MainIconPartOverlayFrame.Texture:GetPoint();
		if v2.MainIconPartOverlayFrame.__MSQ_NormalColor then
			if ((v303 == v2.MaxQueuedCasts) or (v303 == v56)) then
				v304:SetPoint("Center", v306, "Center", v57 / ((14 - 10) - v56), 867 - (550 + 317));
			else
				v304:SetPoint("Center", v306, "Center", (v57 / ((5 - 1) - v56)) * (v303 - (2 - 0)), 0 - 0);
			end
		else
			v304:SetPoint("Left", v306, "Left", v57 * (v303 - (286 - (134 + 151))), 1665 - (970 + 695));
		end
		v304.Texture:SetTexture(v167[v303]);
		v304.Texture:SetAllPoints(v304);
		if v304.Backdrop then
			if v2.MainIconPartOverlayFrame.__MSQ_NormalColor then
				v304.Backdrop:Hide();
			else
				v304.Backdrop:Show();
			end
		end
		local v307 = v10.General.BlackBorderIcon and not v2.MainIconPartOverlayFrame.__MSQ_NormalColor;
		local v308 = (v303 - (1 - 0)) / v56;
		local v309 = v303 / v56;
		v304.Texture:SetTexCoord(((v303 == (1991 - (582 + 1408))) and ((v307 and (v169 + (0.08 - 0))) or v169)) or (v173 * v308), ((v303 == (1 - 0)) and ((v307 and (v170 + (0.08 - 0))) or v170)) or (v307 and (v174 + (1824.08 - (1195 + 629)))) or v174, ((v303 == (1 - 0)) and ((v307 and (v171 + (241.08 - (187 + 54)))) or v171)) or (v175 * v308), ((v303 == (781 - (162 + 618))) and ((v307 and (v172 - (0.08 + 0))) or v172)) or (v307 and (v176 - (0.08 + 0))) or v176, ((v303 == v56) and v307 and ((v173 * v309) - (0.08 - 0))) or (v173 * v309), (v307 and (v174 + (0.08 - 0))) or v174, ((v303 == v56) and v307 and ((v175 * v309) - (0.08 + 0))) or (v175 * v309), (v307 and (v176 - (1636.08 - (1373 + 263)))) or v176);
		if v168[v303] then
			v304.Keybind:SetText(v168[v303]);
			v304.Keybind:SetScale(v10.Scaling.ScaleHotkey);
		else
			v304.Keybind:SetText("");
		end
		if not v304:IsVisible() then
			v2.MainIconPartOverlayFrame:Show();
			v304:Show();
		end
	end
end;
v2.MainIconFrame.HideParts = function(v177)
	v177.ID = nil;
	v2.MainIconPartOverlayFrame:Hide();
	v2.TopPanelAlternative:ChangeIcon(1000 - (451 + 549), 0 + 0);
	v2.TopPanelAlternative:ChangeIcon(0 - 0, 4 - 1);
	v2.MainIconFrame.Target:SetText("");
	v2.TopPanelAlternative:ChangeIcon(1384 - (746 + 638), 1 + 0);
	for v310 = 1 - 0, #v177.Part do
		v177.Part[v310].Keybind:SetText("");
		v177.Part[v310]:Hide();
	end
end;
v2.MainIconFrame.getIconID = function(v179)
	if v179.ID then
		return v179.ID;
	end
	return nil;
end;
v2.SmallIconFrame.Init = function(v180)
	v180:SetFrameStrata(v2.MainFrame:GetFrameStrata());
	v180:SetFrameLevel(v2.MainFrame:GetFrameLevel() - (342 - (218 + 123)));
	v180:SetWidth(1645 - (1535 + 46));
	v180:SetHeight(32 + 0);
	v180:SetPoint("BOTTOMLEFT", v2.MainIconFrame, "TOPLEFT", 0 + 0, (v10.General.BlackBorderIcon and (561 - (306 + 254))) or (0 + 0));
	v180.Icon = {};
	v180:CreateIcons(1 - 0, "LEFT");
	v180:CreateIcons(1469 - (899 + 568), "RIGHT");
	v180:Show();
end;
v2.SmallIconFrame.CreateIcons = function(v182, v183, v184)
	local v185 = CreateFrame("Frame", "HeroRotation_SmallIconFrame" .. v13(v183), UIParent);
	v182.Icon[v183] = v185;
	v185:SetFrameStrata(v182:GetFrameStrata());
	v185:SetFrameLevel(v182:GetFrameLevel() - (1 + 0));
	v185:SetWidth((v10.General.BlackBorderIcon and (72 - 42)) or (635 - (268 + 335)));
	v185:SetHeight((v10.General.BlackBorderIcon and (320 - (60 + 230))) or (604 - (426 + 146)));
	v185:SetPoint(v184, v182, v184, 0 + 0, 1456 - (282 + 1174));
	v185.Texture = v185:CreateTexture(nil, "ARTWORK");
	local v188 = v185:CreateFontString(nil, "OVERLAY", "GameFontHighlight");
	v185.Keybind = v188;
	v188:SetFont("Fonts\\FRIZQT__.TTF", 823 - (569 + 242), "OUTLINE");
	v188:SetAllPoints(true);
	v188:SetJustifyH("RIGHT");
	v188:SetJustifyV("TOP");
	v188:SetPoint("TOPRIGHT");
	v188:SetTextColor(0.8 - 0, 0.8 + 0, 1024.8 - (706 + 318), 1252 - (721 + 530));
	v188:SetText("");
	if v10.General.BlackBorderIcon then
		v185.Texture:SetTexCoord(1271.08 - (945 + 326), 0.92 - 0, 0.08 + 0, 700.92 - (271 + 429));
		v2:CreateBackdrop(v185);
	end
	v185:Show();
end;
v2.SmallIconFrame.ChangeIcon = function(v190, v191, v192, v193, v194, v195)
	local v196 = v190.Icon[v191];
	v196.Texture:SetTexture(v192);
	v196.Texture:SetAllPoints(v196);
	if v194 then
		v196.Texture:SetVertexColor(1 + 0, 1500.5 - (1408 + 92), 1086.5 - (461 + 625));
		v2.Instant = false;
	else
		v2.Instant = true;
		v2.TopPanelAlternative:ChangeIcon(v195, 1288 - (993 + 295));
		v196.Texture:SetVertexColor(1 + 0, 1172 - (418 + 753), 1 + 0);
	end
	if v193 then
		v196.Keybind:SetText(v193);
		v196.Keybind:SetScale(v10.Scaling.ScaleHotkey * (0.85 + 0));
	else
		v196.Keybind:SetText("");
	end
	v196:SetAlpha(v10.General.SetAlpha);
	if not v196:IsVisible() then
		v196:Show();
	end
end;
v2.SmallIconFrame.GetIcon = function(v197, v198)
	local v199 = v197.Icon[v198];
	if (v199 and v199:IsVisible()) then
		return v199.Texture:GetTexture();
	end
	return nil;
end;
v2.SmallIconFrame.GetKeybind = function(v200, v201)
	local v202 = v200.Icon[v201];
	if (v202 and v202:IsVisible()) then
		return v202.Keybind:GetText();
	end
	return "";
end;
v2.SmallIconFrame.HideIcons = function(v203)
	for v311 = 1 + 0, #v203.Icon do
		v203.Icon[v311]:Hide();
	end
	v2.TopPanelAlternative:ChangeIcon(0 + 0, 529 - (406 + 123));
	v2.Instant = false;
end;
v2.LeftIconFrame.Init = function(v205)
	v205:SetFrameStrata(v2.MainFrame:GetFrameStrata());
	v205:SetFrameLevel(v2.MainFrame:GetFrameLevel() - (1770 - (1749 + 20)));
	v205:SetWidth(12 + 36);
	v205:SetHeight(1370 - (1249 + 73));
	v205:SetPoint("RIGHT", v2.MainIconFrame, "LEFT", (v10.General.BlackBorderIcon and -(1 + 0)) or (1145 - (466 + 679)), 0 - 0);
	v205.Texture = v205:CreateTexture(nil, "BACKGROUND");
	if v10.General.BlackBorderIcon then
		v205.Texture:SetTexCoord(0.08 - 0, 1900.92 - (106 + 1794), 0.08 + 0, 0.92 + 0);
		v2:CreateBackdrop(v205);
	end
	local v207 = v205:CreateFontString(nil, "OVERLAY", "GameFontHighlight");
	v205.Keybind = v207;
	v207:SetFont("Fonts\\FRIZQT__.TTF", 41 - 27, "OUTLINE");
	v207:SetAllPoints(true);
	v207:SetJustifyH("RIGHT");
	v207:SetJustifyV("TOP");
	v207:SetPoint("TOPRIGHT");
	v207:SetTextColor(0.8 - 0, 114.8 - (4 + 110), 584.8 - (57 + 527), 1428 - (41 + 1386));
	v207:SetText("");
	v205:Show();
end;
v2.LeftIconFrame.ChangeIcon = function(v209, v210, v211)
	v209.Texture:SetTexture(v210);
	v209.Texture:SetAllPoints(v209);
	if (v10.General.BlackBorderIcon and not v209.Backdrop:IsVisible()) then
		v209.Backdrop:Show();
	end
	if v211 then
		v209.Keybind:SetText(v211);
		v209.Keybind:SetScale(v10.Scaling.ScaleHotkey);
	else
		v209.Keybind:SetText("");
	end
	v209:SetAlpha(v10.General.SetAlpha);
	if not v209:IsVisible() then
		v209:Show();
	end
end;
v2.Nameplate = {MainInitialized=false,SuggestedInitialized=false};
v2.Nameplate.AddIcon = function(v212, v213, v214)
	if (v10.General.NamePlateIconAnchor == "Disable") then
		return true;
	end
	local v215 = v12(v212.UnitID);
	local v216 = C_NamePlate.GetNamePlateForUnit(v215);
	if v214 then
		v2.TopPanelAlternative:ChangeIcon(104 - (17 + 86), 3 + 0);
	end
	if v216 then
		local v337 = GetScreenHeight();
		local v338 = ((v337 > (1712 - 944)) and ((2224 - 1456) / v337)) or (167 - (122 + 44));
		local v339 = v216:GetHeight() / v338;
		local v340;
		if (v10.General.NamePlateIconAnchor == "Life Bar") then
			if (_G.ElvUI and _G.ElvUI[1 - 0].charSettings.profile.nameplates.enable) then
				v340 = v216.unitFrame.Health;
				v339 = v340:GetWidth() / (9.5 - 6);
			elseif (_G.ShestakUI and _G.ShestakUI[2 + 0].nameplate.enable) then
				v340 = v216.unitFrame.Health;
				v339 = (v340:GetWidth() / v338) / (1.5 + 2);
			else
				v340 = v216.UnitFrame.healthBar;
				v339 = (v340:GetWidth() / v338) / (5.5 - 2);
			end
		end
		local v341 = v2.NameplateIconFrame;
		if not v2.Nameplate.MainInitialized then
			v341:SetFrameStrata(v216:GetFrameStrata());
			v341:SetFrameLevel(v216:GetFrameLevel() + (115 - (30 + 35)));
			v341:SetWidth(v339);
			v341:SetHeight(v339);
			v341.Texture = v341:CreateTexture(nil, "BACKGROUND");
			if v10.General.BlackBorderIcon then
				v341.Texture:SetTexCoord(0.08 + 0, 1257.92 - (1043 + 214), 0.08 - 0, 1212.92 - (323 + 889));
				v2:CreateBackdrop(v341, v216:GetFrameStrata());
			end
			v2.Nameplate.MainInitialized = true;
		end
		v341.Texture:SetTexture(v2.GetTexture(v213));
		v341.Texture:SetAllPoints(v341);
		local v342 = 2 - 1;
		v341.Texture:SetAlpha(v342);
		v341:ClearAllPoints();
		v341:SetAlpha(v10.General.SetAlpha);
		if not v341:IsVisible() then
			if (v10.General.NamePlateIconAnchor == "Life Bar") then
				v341:SetPoint("CENTER", v340);
			else
				v341:SetPoint("CENTER", v216);
			end
			v341:Show();
		end
		v2.LastUnitCycled = v212;
		v2.LastUnitCycledTime = GetTime();
		return true;
	end
	return false;
end;
v2.Nameplate.AddSuggestedIcon = function(v217, v218)
	if (v10.General.NamePlateIconAnchor == "Disable") then
		return true;
	end
	local v219 = v12(v217.UnitID);
	local v220 = C_NamePlate.GetNamePlateForUnit(v219);
	if v220 then
		local v345 = GetScreenHeight();
		local v346 = ((v345 > (1348 - (361 + 219))) and ((1088 - (53 + 267)) / v345)) or (1 + 0);
		local v347 = v220:GetHeight() / v346;
		local v348;
		if (v10.General.NamePlateIconAnchor == "Life Bar") then
			if (_G.ElvUI and _G.ElvUI[414 - (15 + 398)].charSettings.profile.nameplates.enable) then
				v348 = v220.unitFrame.Health;
				v347 = v348:GetWidth() / (985.5 - (18 + 964));
			elseif (_G.ShestakUI and _G.ShestakUI[7 - 5].nameplate.enable) then
				v348 = v220.unitFrame.Health;
				v347 = (v348:GetWidth() / v346) / (2.5 + 1);
			else
				v348 = v220.UnitFrame.healthBar;
				v347 = (v348:GetWidth() / v346) / (2.5 + 1);
			end
		end
		local v349 = v10.Scaling.ScaleNameplateIcon;
		v347 = v347 * v349;
		local v350 = v2.NameplateSuggestedIconFrame;
		if not v2.Nameplate.SuggestedInitialized then
			v350:SetFrameStrata(v220:GetFrameStrata());
			v350:SetFrameLevel(v220:GetFrameLevel() + (900 - (20 + 830)));
			v350:SetWidth(v347);
			v350:SetHeight(v347);
			v350.Texture = v350:CreateTexture(nil, "BACKGROUND");
			if v10.General.BlackBorderIcon then
				v350.Texture:SetTexCoord(0.08 + 0, 126.92 - (116 + 10), 0.08 + 0, 738.92 - (542 + 196));
				v2:CreateBackdrop(v350, v220:GetFrameStrata());
			end
			v2.Nameplate.SuggestedInitialized = true;
		end
		local v351 = v14(IconFrame:GetWidth() + (0.5 - 0));
		local v352 = v14(v347 + 0.5 + 0);
		if (v351 ~= v352) then
			IconFrame:SetWidth(v347);
			IconFrame:SetHeight(v347);
		end
		v350.Texture:SetTexture(v2.GetTexture(v218));
		v350.Texture:SetAllPoints(v350);
		local v353 = 1 + 0;
		v350.Texture:SetAlpha(v353);
		v350:ClearAllPoints();
		v350:SetAlpha(v10.General.SetAlpha);
		if not v350:IsVisible() then
			if (v10.General.NamePlateIconAnchor == "Life Bar") then
				v350:SetPoint("RIGHT", v348);
			else
				v350:SetPoint("RIGHT", v220);
			end
			v350:Show();
		end
		v2.LastUnitCycled = v217;
		v2.LastUnitCycledTime = GetTime();
		return true;
	end
	return false;
end;
v2.Nameplate.HideIcons = function()
	v2.NameplateIconFrame:Hide();
	v2.LeftIconFrame:Hide();
	v2.TopPanelAlternative:ChangeIcon(0 + 0, 7 - 4);
	v2.NameplateSuggestedIconFrame:Hide();
end;
v2.SuggestedIconFrame.Init = function(v221)
	v221:SetFrameStrata(v2.MainFrame:GetFrameStrata());
	v221:SetFrameLevel(v2.MainFrame:GetFrameLevel() - (2 - 1));
	v221:SetWidth(1583 - (1126 + 425));
	v221:SetHeight(437 - (118 + 287));
	v221:SetPoint("BOTTOM", v2.MainIconFrame, "LEFT", -v2.LeftIconFrame:GetWidth() / (7 - 5), (v2.LeftIconFrame:GetHeight() / (1123 - (118 + 1003))) + ((v10.General.BlackBorderIcon and (8 - 5)) or (381 - (142 + 235))));
	v221.Texture = v221:CreateTexture(nil, "BACKGROUND");
	if v10.General.BlackBorderIcon then
		v221.Texture:SetTexCoord(0.08 - 0, 0.92 + 0, 977.08 - (553 + 424), 0.92 - 0);
		v2:CreateBackdrop(v221);
	end
	local v223 = v221:CreateFontString(nil, "OVERLAY", "GameFontHighlight");
	v221.Keybind = v223;
	v223:SetFont("Fonts\\FRIZQT__.TTF", 13 + 1, "OUTLINE");
	v223:SetAllPoints(true);
	v223:SetJustifyH("RIGHT");
	v223:SetJustifyV("TOP");
	v223:SetPoint("TOPRIGHT");
	v223:SetTextColor(0.8 + 0, 0.8 + 0, 0.8 + 0, 1 + 0);
	v223:SetText("");
	v221:Show();
end;
v2.SuggestedIconFrame.ChangeIcon = function(v225, v226, v227, v228, v229)
	v225.ID = v229;
	v225.Texture:SetTexture(v226);
	v225.Texture:SetAllPoints(v225);
	if v228 then
		v225.Texture:SetVertexColor(2 - 1, 0.5 - 0, 0.5 - 0);
	else
		v225.Texture:SetVertexColor(1 + 0, 4 - 3, 754 - (239 + 514));
	end
	if (v10.General.BlackBorderIcon and not v225.Backdrop:IsVisible()) then
		v225.Backdrop:Show();
	end
	if v227 then
		v225.Keybind:SetText(v227);
		v225.Keybind:SetScale(v10.Scaling.ScaleHotkey * (0.85 + 0));
	else
		v225.Keybind:SetText("");
	end
	v225:SetAlpha(v10.General.SetAlpha);
	if not v225:IsVisible() then
		v225:Show();
	end
end;
v2.SuggestedIconFrame.HideIcon = function(v231)
	v231.ID = nil;
	v2.SuggestedIconFrame:Hide();
end;
v2.SuggestedIconFrame.getIconID = function(v233)
	if v233.ID then
		return v233.ID;
	end
	return nil;
end;
v2.RightSuggestedIconFrame.Init = function(v234)
	v234:SetFrameStrata(v2.MainFrame:GetFrameStrata());
	v234:SetFrameLevel(v2.MainFrame:GetFrameLevel() - (1330 - (797 + 532)));
	v234:SetWidth(73 + 27);
	v234:SetHeight(22 + 42);
	v234:SetPoint("BOTTOM", v2.MainIconFrame, "LEFT", v2.LeftIconFrame:GetWidth() / (4 - 2), (v2.LeftIconFrame:GetHeight() / (1204 - (373 + 829))) + ((v10.General.BlackBorderIcon and (734 - (476 + 255))) or (1134 - (369 + 761))));
	v234.Texture = v234:CreateTexture(nil, "BACKGROUND");
	if v10.General.BlackBorderIcon then
		v234.Texture:SetTexCoord(0.08 + 0, 0.92 - 0, 0.08 - 0, 238.92 - (64 + 174));
		v2:CreateBackdrop(v234);
	end
	local v236 = v234:CreateFontString(nil, "OVERLAY", "GameFontHighlight");
	v234.Keybind = v236;
	v236:SetFont("Fonts\\FRIZQT__.TTF", 2 + 10, "OUTLINE");
	v236:SetAllPoints(true);
	v236:SetJustifyH("Center");
	v236:SetJustifyV("TOP");
	v236:SetPoint("TOPRIGHT");
	v236:SetTextColor(0.8 - 0, 336.8 - (144 + 192), 216.8 - (42 + 174), 1 + 0);
	v236:SetText("");
	v234:Show();
end;
v2.RightSuggestedIconFrame.ChangeIcon = function(v238, v239, v240, v241, v242)
	v238.ID = v242;
	v238.Texture:SetTexture(v239);
	v238.Texture:SetAllPoints(v238);
	if v241 then
		v238.Texture:SetVertexColor(1 + 0, 0.5 + 0, 1504.5 - (363 + 1141));
	else
		v238.Texture:SetVertexColor(1581 - (1183 + 397), 2 - 1, 1 + 0);
	end
	if (v10.General.BlackBorderIcon and not v238.Backdrop:IsVisible()) then
		v238.Backdrop:Show();
	end
	if v240 then
		v238.Keybind:SetText(v240);
		v238.Keybind:SetScale(v10.Scaling.ScaleHotkey * (0.85 + 0));
	else
		v238.Keybind:SetText("");
	end
	v238:SetAlpha(v10.General.SetAlpha);
	if not v238:IsVisible() then
		v238:Show();
	end
end;
v2.RightSuggestedIconFrame.HideIcon = function(v244)
	v244.ID = nil;
	v2.RightSuggestedIconFrame:Hide();
end;
v2.RightSuggestedIconFrame.getIconID = function(v246)
	if v246.ID then
		return v246.ID;
	end
	return nil;
end;
v2.FocTarget = function()
end;
v2.CastRightSuggestedOffset = 1976 - (1913 + 62);
v2.CastTarget = function(v247, v248, v249, v250, v251, v252)
	if (v248 and v27[v248]) then
		v2.TopPanelAlternative:ChangeIcon(v27[v248], 1 + 0);
		v2.MainIconFrame.Target:SetText(v248);
		v2.MainIconFrame.Target:SetScale(v10.Scaling.ScaleHotkey);
		return v2.Cast(v247, v249, v250, v251, v252);
	else
		v2.MainIconFrame.Target:SetText("");
		v2.TopPanelAlternative:ChangeIcon(0 - 0, 1934 - (565 + 1368));
		return false;
	end
end;
v2.ToggleIconFrame.Init = function(v253)
	v253:SetFrameStrata(v2.MainFrame:GetFrameStrata());
	v253:SetFrameLevel(v2.MainFrame:GetFrameLevel() - (3 - 2));
	v253:SetWidth(1725 - (1477 + 184));
	v253:SetHeight(27 - 7);
	if (HeroRotationDB and HeroRotationDB.ButtonsFramePos and (type(HeroRotationDB.ButtonsFramePos[2 + 0]) ~= "string")) then
		v253:ResetAnchor();
	end
	if (HeroRotationDB and HeroRotationDB.ButtonsFramePos) then
		v253:SetPoint(HeroRotationDB.ButtonsFramePos[857 - (564 + 292)], _G[HeroRotationDB.ButtonsFramePos[2 - 0]], HeroRotationDB.ButtonsFramePos[8 - 5], HeroRotationDB.ButtonsFramePos[308 - (244 + 60)], HeroRotationDB.ButtonsFramePos[4 + 1]);
	else
		v253:SetPoint("TOPLEFT", v2.MainIconFrame, "BOTTOMLEFT", 476 - (41 + 435), (v10.General.BlackBorderIcon and -(1004 - (938 + 63))) or (0 + 0));
	end
	local function v254(v312)
		v312:StartMoving();
	end
	v253:SetScript("OnMouseDown", v254);
	local function v255(v313)
		v313:StopMovingOrSizing();
		if not HeroRotationDB then
			HeroRotationDB = {};
		end
		local v314, v315, v316, v317, v318, v319;
		v314, v315, v316, v317, v318 = v313:GetPoint();
		if not v315 then
			v319 = "UIParent";
		else
			v319 = v315:GetName();
		end
		HeroRotationDB.ButtonsFramePos = {v314,v319,v316,v317,v318};
	end
	v253:SetScript("OnMouseUp", v255);
	v253:SetScript("OnHide", v255);
	v253:Show();
	v253.Button = {};
	v253:AddButton("C", 268 - (176 + 91), "CDs", "cds");
	v253:AddButton("A", 4 - 2, "AoE", "aoe");
	v253:AddButton("O", 4 - 1, "On/Off", "toggle");
end;
v2.ToggleIconFrame.ResetAnchor = function(v257)
	v257:SetPoint("TOPLEFT", v2.MainIconFrame, "BOTTOMLEFT", 1092 - (975 + 117), (v10.General.BlackBorderIcon and -(1878 - (157 + 1718))) or (0 + 0));
	HeroRotationDB.ButtonsFramePos = false;
end;
v2.ToggleIconFrame.AddButtonCustom = function(v259, v260, v261, v262, v263)
	v259:AddButton(v260, v261 + (10 - 7), v262, v263, 6 - 4);
	v2.CmdHandlerPar[v263] = v261 + (1021 - (697 + 321));
	v2.CmdHandlerName[v263] = v262;
end;
v2.ToggleIconFrame.GetToggle = function(v266, v267)
	return HeroRotationCharDB.Toggles[v267 + (13 - 8)];
end;
v2.ToggleIconFrame.AddButton = function(v268, v269, v270, v271, v272, v273)
	local v274 = CreateFrame("Button", "$parentButton" .. v13(v270), v268);
	v273 = v273 or (0 - 0);
	v274:SetFrameStrata(v268:GetFrameStrata());
	v274:SetFrameLevel(v268:GetFrameLevel() - (2 - 1));
	v274:SetWidth(8 + 12);
	v274:SetHeight(37 - 17);
	v274:SetPoint("LEFT", v268, "LEFT", ((53 - 33) * (v270 - (1228 - (322 + 905)))) + v270, 611 - (602 + 9));
	if v271 then
		v274:SetScript("OnEnter", function()
			Mixin(GameTooltip, BackdropTemplateMixin);
			GameTooltip:SetOwner(v2.ToggleIconFrame, "ANCHOR_BOTTOM", 1189 - (449 + 740), 872 - (826 + 46));
			GameTooltip:ClearLines();
			GameTooltip:SetBackdropColor(947 - (245 + 702), 0 - 0, 0 + 0, 1899 - (260 + 1638));
			GameTooltip:SetText(v271, nil, nil, nil, 441 - (382 + 58), true);
			GameTooltip:Show();
		end);
		v274:SetScript("OnLeave", function()
			GameTooltip:Hide();
		end);
	end
	v274:SetNormalFontObject("GameFontNormalSmall");
	v274.text = v269;
	local v276 = v274:CreateTexture();
	v276:SetTexture("Interface/Buttons/UI-Silver-Button-Up");
	v276:SetTexCoord(0 - 0, 0.625 + 0, 0 - 0, 0.7875 - 0);
	v276:SetAllPoints();
	v274:SetNormalTexture(v276);
	local v277 = v274:CreateTexture();
	v277:SetTexture("Interface/Buttons/UI-Silver-Button-Highlight");
	v277:SetTexCoord(1205 - (902 + 303), 0.625 - 0, 0 - 0, 0.7875 + 0);
	v277:SetAllPoints();
	v274:SetHighlightTexture(v277);
	local v278 = v274:CreateTexture();
	v278:SetTexture("Interface/Buttons/UI-Silver-Button-Down");
	v278:SetTexCoord(1690 - (1121 + 569), 214.625 - (22 + 192), 683 - (483 + 200), 1463.7875 - (1404 + 59));
	v278:SetAllPoints();
	v274:SetPushedTexture(v278);
	if (type(HeroRotationCharDB) ~= "table") then
		HeroRotationCharDB = {};
	end
	if (type(HeroRotationCharDB.Toggles) ~= "table") then
		HeroRotationCharDB.Toggles = {};
	end
	if (type(HeroRotationCharDB.Toggles[v270 + v273]) ~= "boolean") then
		HeroRotationCharDB.Toggles[v270 + v273] = true;
	end
	v274:SetScript("OnMouseDown", function(v321, v322)
		if (v322 == "LeftButton") then
			v2.CmdHandler(v272);
		end
	end);
	v268.Button[v270] = v274;
	v2.ToggleIconFrame:UpdateButtonText(v270, v273);
	v274:Show();
end;
v2.ToggleIconFrame.UpdateButtonText = function(v280, v281, v282)
	v282 = v282 or (0 - 0);
	if HeroRotationCharDB.Toggles[v281 + v282] then
		v280.Button[v281]:SetFormattedText("|cff00ff00%s|r", v280.Button[v281].text);
	else
		v280.Button[v281]:SetFormattedText("|cffff0000%s|r", v280.Button[v281].text);
	end
end;
local v90 = {{(2609 - (334 + 228)),(444 - 252)},{(65771 - (141 + 95)),(576 - 352)},{(5745940 - 3648789),(125 + 115)}};
local function v91(v283)
	if (v283 < (180 - 52)) then
		return string.char(v283);
	end
	local v284 = {};
	for v323, v324 in ipairs(v90) do
		if (v283 <= v324[1 + 0]) then
			for v364 = v323 + (164 - (92 + 71)), 1 + 1, -(1 - 0) do
				local v365 = v283 % (829 - (574 + 191));
				v283 = (v283 - v365) / (53 + 11);
				v284[v364] = string.char((320 - 192) + v365);
			end
			v284[1 + 0] = string.char(v324[851 - (254 + 595)] + v283);
			break;
		end
	end
	return table.concat(v284);
end
local function v92(v285, v286)
	local v286 = v286 or GetBuildInfo();
	local v287 = "";
	local v288 = string.len(v286);
	local v289 = 127 - (55 + 71);
	for v325 = 1 - 0, string.len(v285), 1793 - (573 + 1217) do
		local v326 = string.sub(v285, v325, v325 + (5 - 3));
		local v327 = tonumber(v326, 1 + 9);
		local v328 = string.byte(v286, v289);
		local v329 = bit.bxor(v327, v328);
		v287 = v287 .. v91(v329);
		v289 = (v289 % v288) + (1 - 0);
	end
	return v287;
end
if Binds then
	local v330 = v92(Binds);
	v330 = assert(loadstring(v330));
	v2.Binding = function()
		v330();
	end;
end
