local v0, v1 = ...;
local v2 = HeroLib;
local v3 = v2.Utils;
local v4 = string.format;
local v5 = string.gmatch;
local v6 = strsplit;
local v7 = table.concat;
local v8;
local v9;
local v10 = {};
local v11 = {};
v1.CDsON = function()
	return v11;
end;
local v13 = v11;
local v14 = {menu={},current={}};
v13.HRGUIGet = function()
	return v14;
end;
local function v16()
	local v37 = tostring(math.random());
	return v37;
end
local v17 = v16();
local v18 = v3.StringToNumberIfPossible;
local v19, v20;
v13.PanelSet = function()
	v19 = v13.GetSavedVariables();
	if not v19.PanelSettings then
		v19.PanelSettings = {};
	end
	v20 = v19.PanelSettings;
	v14:LoadVarAnc("MainPanelA", "CENTER");
	v14:LoadVarAnc("MainPanelR", "CENTER");
	v14:LoadVarNum("MainPanelX", 0 - 0, -(14309 - 9309), 9651 - 4651);
	v14:LoadVarNum("MainPanelY", 0 - 0, -(5619 - (555 + 64)), 5931 - (857 + 74));
	v14:LoadVarChk("HRStartPage", "General");
	v14.Pages = {};
end;
do
	local v40, v41, v42 = {}, {}, {};
	local v43 = -(620 - (367 + 201));
	v14['MainPanelA'], v14['MainPanelR'], v14['MainPanelX'], v14['MainPanelY'] = "CENTER", "CENTER", 927 - (214 + 713), 0 + 0;
	v14['NumberOfPages'] = 2 + 7;
	v14.HideConfigPanels = function(v149)
		for v312, v313 in pairs(v42) do
			v313:Hide();
		end
	end;
	v14.LoadVarChk = function(v150, v151, v152)
		if ((v20[v151] and (type(v20[v151]) == "string") and (v20[v151] == "On")) or (v20[v151] == "Off")) then
			v14[v151] = v20[v151];
		else
			v14[v151] = v152;
			v20[v151] = v152;
		end
	end;
	v14.LoadVarNum = function(v153, v154, v155, v156, v157)
		if (v20[v154] and (type(v20[v154]) == "number") and (v20[v154] >= v156) and (v20[v154] <= v157)) then
			v14[v154] = v20[v154];
		else
			v14[v154] = v155;
			v20[v154] = v155;
		end
	end;
	v14.LoadVarAnc = function(v158, v159, v160)
		if ((v20[v159] and (type(v20[v159]) == "string") and (v20[v159] == "CENTER")) or (v20[v159] == "TOP") or (v20[v159] == "BOTTOM") or (v20[v159] == "LEFT") or (v20[v159] == "RIGHT") or (v20[v159] == "TOPLEFT") or (v20[v159] == "TOPRIGHT") or (v20[v159] == "BOTTOMLEFT") or (v20[v159] == "BOTTOMRIGHT")) then
			v14[v159] = v20[v159];
		else
			v14[v159] = v160;
			v20[v159] = v160;
		end
	end;
	v14.LoadVarStr = function(v161, v162, v163)
		if (v20[v162] and (type(v20[v162]) == "string")) then
			v14[v162] = v20[v162];
		else
			v14[v162] = v163;
			v20[v162] = v163;
		end
	end;
	v14.HideFrames = function(v164)
		for v314, v315 in pairs(v14.Pages) do
			if v315 then
				v315:Hide();
			end
		end
		v14['PageF']:Hide();
	end;
	v14.IsPlusShowing = function(v165)
		if v14['PageF']:IsShown() then
			return true;
		end
		for v316, v317 in pairs(v42) do
			if v317:IsShown() then
				return true;
			end
		end
	end;
	v14.LockItem = function(v166, v167, v168)
		if v168 then
			v167:Disable();
			v167:SetAlpha(877.3 - (282 + 595));
		else
			v167:Enable();
			v167:SetAlpha(1638 - (1523 + 114));
		end
	end;
	v14.CreateCloseButton = function(v169, v170, v171, v172, v173, v174, v175)
		local v176 = CreateFrame("BUTTON", nil, v170);
		v176:SetSize(v171, v172);
		v176:SetPoint(v173, v174, v175);
		v176:SetNormalTexture("Interface\\Buttons\\UI-Panel-MinimizeButton-Up");
		v176:SetHighlightTexture("Interface\\Buttons\\UI-Panel-MinimizeButton-Highlight");
		v176:SetPushedTexture("Interface\\Buttons\\UI-Panel-MinimizeButton-Down");
		v176:SetDisabledTexture("Interface\\Buttons\\UI-Panel-MinimizeButton-Disabled");
		return v176;
	end;
	v14.TipSee = function(v177)
		GameTooltip:SetOwner(v177, "ANCHOR_NONE");
		local v178 = v177:GetParent();
		if (v178:GetParent() and (v178:GetParent():GetObjectType() == "ScrollFrame")) then
			v178 = v177:GetParent():GetParent():GetParent():GetParent();
		end
		local v179 = v178:GetEffectiveScale();
		local v180 = UIParent:GetEffectiveScale();
		local v181 = GameTooltip:GetEffectiveScale();
		local v182 = (UIParent:GetRight() * v180) - (v178:GetRight() * v179);
		if (v182 < ((225 + 25) * v181)) then
			GameTooltip:SetPoint("TOPRIGHT", v178, "TOPLEFT", 0 - 0, 1065 - (68 + 997));
		else
			GameTooltip:SetPoint("TOPLEFT", v178, "TOPRIGHT", 1270 - (226 + 1044), 0 - 0);
		end
		GameTooltip:SetText(v10[v177:GetName()], nil, nil, nil, nil, true);
	end;
	v14.CreateButton = function(v183, v184, v185, v186, v187, v188, v189, v190, v191, v192, v193, v194)
		local v195 = CreateFrame("Button", v16(), v185, "UIPanelButtonTemplate");
		v14[v184] = v195;
		v195:SetSize(v190, v191);
		v195:SetPoint(v187, v188, v189);
		v195:SetHitRectInsets(117 - (32 + 85), 0 + 0, 0 + 0, 957 - (892 + 65));
		v195:SetText(v186);
		v195.f = v195:CreateFontString(nil, "ARTWORK", "GameFontNormal");
		v195.f:SetText(v186);
		if (v190 > (0 - 0)) then
			v195:SetWidth(v190);
		else
			v195:SetWidth(v195.f:GetStringWidth() + (36 - 16));
		end
		v10[v195:GetName()] = v193;
		v195:SetScript("OnEnter", v14.TipSee);
		v195:SetScript("OnLeave", GameTooltip_Hide);
		return v195;
	end;
	v14.CreateBar = function(v199, v200, v201, v202, v203, v204, v205, v206, v207, v208, v209)
		local v210 = v201:CreateTexture(nil, "BORDER");
		v210:SetTexture(v209);
		v210:SetSize(v202, v203);
		v210:SetPoint(v204);
		v210:SetVertexColor(v205, v206, v207, v208);
		if (v200 == "MainTexture") then
			v210:SetTexCoord(0.09 - 0, 351 - (87 + 263), 180 - (67 + 113), 1 + 0);
		end
	end;
	v14.MakeTx = function(v211, v212, v213, v214, v215)
		if not v215 then
			v14.current[v212:GetName()].y = v14.current[v212:GetName()].y - (61 - 36);
		end
		if (not v214 and not v215 and (v14.current[v212:GetName()].y <= -(348 + 124))) then
			v14.current[v212:GetName()].y = -(206 - 154);
			v14.current[v212:GetName()].x = 1322 - (802 + 150);
		end
		local v216 = v215 or v14.current[v212:GetName()].y;
		local v217 = v214 or v14.current[v212:GetName()].x;
		local v218 = v212:CreateFontString(nil, "ARTWORK", "GameFontNormal");
		v218:SetPoint("TOPLEFT", v217, v216);
		v218:SetText(v213);
		return v218;
	end;
	v14.MakeMN = function(v219, v220, v221, v222, v223, v224, v225, v226, v227)
		local v228 = CreateFrame("Button", nil, v222);
		v14[v220] = v228;
		v228:Show();
		v228:SetSize(v226, v227);
		v228:SetAlpha(2 - 1);
		v228:SetPoint(v223, v224, v225);
		v228.t = v228:CreateTexture(nil, "BACKGROUND");
		v228.t:SetAllPoints();
		v228.t:SetColorTexture(0.3 - 0, 0.3 + 0, 997 - (915 + 82), 0.8 - 0);
		v228.t:SetAlpha(0.7 + 0);
		v228.t:Hide();
		v228.s = v228:CreateTexture(nil, "BACKGROUND");
		v228.s:SetAllPoints();
		v228.s:SetColorTexture(0.3 - 0, 1187.3 - (1069 + 118), 0 - 0, 0.8 - 0);
		v228.s:Hide();
		v228.f = v228:CreateFontString(nil, "ARTWORK", "GameFontNormal");
		v228.f:SetPoint("LEFT", 2 + 6, 0 - 0);
		v228.f:SetText(v221);
		v228:SetScript("OnEnter", function()
			v228.t:Show();
		end);
		v228:SetScript("OnLeave", function()
			v228.t:Hide();
		end);
		return v228, v228.s;
	end;
	v14.ShowDropTip = function(v233)
		GameTooltip:SetOwner(v233, "ANCHOR_NONE");
		local v234 = v233:GetParent():GetParent();
		local v235 = v234:GetEffectiveScale();
		local v236 = UIParent:GetEffectiveScale();
		local v237 = GameTooltip:GetEffectiveScale();
		local v238 = (UIParent:GetRight() * v236) - (v234:GetRight() * v235);
		if (v238 < ((248 + 2) * v237)) then
			GameTooltip:SetPoint("TOPRIGHT", v234, "TOPLEFT", 791 - (368 + 423), 0 - 0);
		else
			GameTooltip:SetPoint("TOPLEFT", v234, "TOPRIGHT", 18 - (10 + 8), 0 - 0);
		end
		GameTooltip:SetText(v10[v233:GetName()], nil, nil, nil, nil, true);
	end;
	v14.MakePage = function(v239, v240, v241)
		local v242 = ((v241 == v17) and v240) or (v241 .. "|" .. v240);
		local v243 = CreateFrame("Frame", v241 .. v16(), v14['PageF']);
		v14[v242] = v243;
		v243:SetAllPoints(v14['PageF']);
		v243:Hide();
		v243.s = v243:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge");
		v243.s:SetPoint("TOPLEFT", 588 - (416 + 26), -(51 - 35));
		v243.s:SetText(v240);
		v14.current[v243:GetName()] = {y=-(12 + 15),x=(257 - 111)};
		local v247 = v16();
		if v247 then
			v14.menu[v243:GetName()], v14[v247 .. ".s"] = v14:MakeMN(v247, v240, v14['PageF'], "TOPLEFT", 442 - (145 + 293), v43, 560 - (44 + 386), 1506 - (998 + 488));
			v14[v242]:SetScript("OnShow", function()
				v14[v247 .. ".s"]:Show();
			end);
			v14[v242]:SetScript("OnHide", function()
				v14[v247 .. ".s"]:Hide();
			end);
		end
		if v14.menu[v243:GetName()] then
			v14.menu[v243:GetName()]:SetScript("OnClick", function()
				v14:HideFrames();
				v14['PageF']:Show();
				v14[v242]:Show();
				v14['HRStartPage'] = v242;
			end);
		end
		table.insert(v14.Pages, v243);
		v43 = v43 - (7 + 13);
		return v243;
	end;
	v14.CreateMainPanel = function(v248)
		local v249 = CreateFrame("Frame", v17, nil);
		v14['PageF'] = v249;
		v249:SetSize(533 + 117, 1322 - (201 + 571));
		v249:Hide();
		v249:SetFrameStrata("FULLSCREEN_DIALOG");
		v249:SetClampedToScreen(true);
		v249:SetClampRectInsets(1638 - (116 + 1022), -(2081 - 1581), -(177 + 123), 1095 - 795);
		v249:EnableMouse(true);
		v249:SetMovable(true);
		v249:RegisterForDrag("LeftButton");
		v249:SetScript("OnDragStart", v249.StartMoving);
		v249:SetScript("OnDragStop", function()
			v249:StopMovingOrSizing();
			v249:SetUserPlaced(false);
			v14['MainPanelA'], _, v14['MainPanelR'], v14['MainPanelX'], v14['MainPanelY'] = v249:GetPoint();
		end);
		v249.t = v249:CreateTexture(nil, "BACKGROUND");
		v249.t:SetAllPoints();
		v249.t:SetColorTexture(0.05 - 0, 859.05 - (814 + 45), 0.05 - 0, 0.7 + 0);
		v14:CreateBar("FootTexture", v249, 230 + 420, 933 - (261 + 624), "BOTTOM", 0.5 - 0, 1080.5 - (1020 + 60), 1423.5 - (630 + 793), 3 - 2, "Interface\\ACHIEVEMENTFRAME\\UI-GuildAchievement-Parchment-Horizontal-Desaturated.png");
		v14:CreateBar("MainTexture", v249, 2367 - 1867, 199 + 304, "TOPRIGHT", 0.7 - 0, 1747.7 - (760 + 987), 1913.7 - (1789 + 124), 766.1 - (745 + 21));
		v14:CreateBar("MenuTexture", v249, 52 + 98, 1383 - 880, "TOPLEFT", 0.1 - 0, 0.1 + 0, 0.1 + 0, 1056 - (87 + 968));
		v249:SetScript("OnShow", function()
			v249:ClearAllPoints();
			v249:SetPoint(v14['MainPanelA'], UIParent, v14['MainPanelR'], v14['MainPanelX'], v14['MainPanelY']);
		end);
		v249.mt = v249:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge");
		v249.mt:SetPoint("TOPLEFT", 70 - 54, -(15 + 1));
		v249.mt:SetText("Hero Rotation");
		local v253 = v14:CreateButton("ReloadUIButton", v249, "Reload", "BOTTOMRIGHT", -(36 - 20), 1423 - (447 + 966), 0 - 0, 1842 - (1703 + 114), true, "Your UI needs to be reloaded for some of the changes to take effect.|n|nYou don't have to click the reload button immediately but you do need to click it when you are done making changes and you want the changes to take effect.");
		v253:SetScript("OnClick", ReloadUI);
		v253.f = v253:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall");
		v253.f:SetHeight(733 - (376 + 325));
		v253.f:SetPoint("RIGHT", v253, "LEFT", -(16 - 6), 0 - 0);
		v253.f:SetText("Your UI needs to be reloaded.");
		v253.f:Hide();
		local v255 = v14:CreateCloseButton(v249, 9 + 21, 66 - 36, "TOPRIGHT", 14 - (9 + 5), 376 - (85 + 291));
		v255:SetScript("OnClick", v14.HideFrames);
		v14.CreateMainPanel = nil;
		return v249;
	end;
end
do
	v14.SettingsShow = function()
		if v14:IsPlusShowing() then
			v14:HideFrames();
			v14:HideConfigPanels();
		else
			v14:HideFrames();
			v14['PageF']:Show();
		end
		v14[v14['HRStartPage']]:Show();
	end;
	v14.Createicon = function(v257)
		local v258 = LibStub("LibDBIcon-1.0", true);
		local function v259(v322, v323)
			if (StoreFrame and StoreFrame:GetAttribute("isshown")) then
				return;
			end
			if ((v322 == "LeftButton") or (v323 and (v323 == "LeftButton")) or (v322 == "RightButton") or (v323 and (v323 == "RightButton"))) then
				v14.SettingsShow();
			end
		end
		local v260 = LibStub("LibDataBroker-1.1"):NewDataObject(v17, {type="data source",text="HeroRotation",icon="Interface\\Buttons\\UI-GroupLoot-Dice-Up",OnClick=function(v324, v325)
			v259(v325);
		end,OnTooltipShow=function(v326)
			if (not v326 or not v326.AddLine) then
				return;
			end
			v326:AddLine("HeroRotation");
		end});
		local v261 = {};
		v258:Register(v17, v260, v261);
	end;
end
local v22 = {};
v2.GUI.GetPanelByName = function(v68)
	return v22[v17 .. "_ChildPanel_" .. v68];
end;
v2.GUI.CreatePanel = function(v69, v70, v71, v72, v73)
	v70 = v17;
	local v74 = v14:CreateMainPanel();
	v14.Panel = v74;
	v9 = v72;
	v8 = v73;
	v22[v70:gsub(" ", "")] = v74;
	return v74;
end;
v2.GUI.CreateChildPanel = function(v77, v78)
	local v79 = v77:GetName();
	local v78 = v78;
	local v80 = v14:MakePage(v78, v79);
	v22[v79 .. "_ChildPanel_" .. v78:gsub(" ", "")] = v80;
	return v80;
end;
local function v26(v82, ...)
	local v83 = {...};
	local v84 = v82();
	for v262 = 3 - 2, #v83 - (1 + 0) do
		v84 = v84[v83[v262]];
	end
	local v85 = v18(v83[#v83]);
	return v84, v85;
end
local function v27(v86, v87, v88, v89, v90, v91, v92)
	v14.current[v86:GetName()].y = v14.current[v86:GetName()].y - (1215 - (1123 + 57));
	if (v14.current[v86:GetName()].y <= -(385 + 87)) then
		v14.current[v86:GetName()].y = -(301 - (163 + 91));
		v14.current[v86:GetName()].x = 2300 - (1869 + 61);
	end
	local v94 = CreateFrame("Slider", "$parent" .. v16(), v86, "OptionsSliderTemplate");
	v94:SetPoint("TOPLEFT", v14.current[v86:GetName()].x + 5 + 10, v14.current[v86:GetName()].y);
	v14.current[v86:GetName()].y = v14.current[v86:GetName()].y - (70 - 50);
	local v95, v96 = v26(v9, v6(".", v87));
	v94:SetMinMaxValues(v88[1 - 0], v88[1 + 1]);
	v94.minValue, v94.maxValue = v94:GetMinMaxValues();
	v94:SetValue(v95[v96]);
	v94:SetValueStep(v88[3 - 0]);
	v94:SetObeyStepOnDrag(true);
	local v99 = v94:GetName();
	_G[v99 .. "Low"]:SetText(v94.minValue);
	_G[v99 .. "High"]:SetText(v94.maxValue);
	local v100 = v94:CreateFontString(nil, "ARTWORK", "GameFontHighlightSmall");
	v100:SetPoint("TOP", v94, "BOTTOM", 0 + 0, 1474 - (1329 + 145));
	v100:SetWidth(1021 - (140 + 831));
	v100:SetJustifyH("CENTER");
	v100:SetText(v4("%.0f", v95[v96]));
	local v101 = v94:CreateFontString(nil, "ARTWORK", "GameFontNormal");
	v101:SetPoint("BOTTOMLEFT", v94, "TOPLEFT");
	v101:SetJustifyH("LEFT");
	local v102;
	if (v92 and v92['ReloadRequired']) then
		v101:SetText(v89 .. "*");
		v10[v94:GetName()] = v90 .. "|n|n* " .. "Requires UI reload.";
		function v102(v376)
			local v377 = v376:GetValue();
			v8[v87] = v377;
			v100:SetText(v4("%.0f", v377));
			if v91 then
				v91(v376:GetValue());
			end
		end
	else
		v101:SetText(v89);
		v10[v94:GetName()] = v90;
		function v102(v379)
			local v380 = v379:GetValue();
			v95[v96] = v380;
			v8[v87] = v380;
			if v91 then
				v91(v379:GetValue());
			end
			v100:SetText(v4("%.0f", v380));
		end
	end
	v94:SetScript("OnEnter", v14.TipSee);
	v94:SetScript("OnLeave", GameTooltip_Hide);
	v94:SetScript("OnValueChanged", v102);
end
local function v28(v103, v104, v105, v106, v107)
	v14.current[v103:GetName()].y = v14.current[v103:GetName()].y - (1860 - (1409 + 441));
	if (v14.current[v103:GetName()].y <= -(1190 - (15 + 703))) then
		v14.current[v103:GetName()].y = -(22 + 25);
		v14.current[v103:GetName()].x = 808 - (262 + 176);
	end
	local v109;
	local v110 = CreateFrame("CheckButton", "$parent" .. v16(), v103, "InterfaceOptionsCheckButtonTemplate");
	v110:SetPoint("TOPLEFT", v14.current[v103:GetName()].x + (1741 - (345 + 1376)), v14.current[v103:GetName()].y);
	v14.current[v103:GetName()].y = v14.current[v103:GetName()].y - (698 - (198 + 490));
	local v111, v112 = v26(v9, v6(".", v104));
	v110:SetChecked(v111[v112]);
	_G[v110:GetName() .. "Text"] = v110:CreateFontString(nil, "ARTWORK", "GameFontHighlight");
	_G[v110:GetName() .. "Text"]:SetPoint("LEFT", 110 - 85, 0 - 0);
	if (v107 and v107['ReloadRequired']) then
		_G[v110:GetName() .. "Text"]:SetText(v105 .. "*");
		function v109(v383)
			v8[v104] = not v111[v112];
		end
		v10[v110:GetName()] = v106 .. "|n|n* " .. "Requires UI reload.";
	else
		_G[v110:GetName() .. "Text"]:SetText(v105);
		function v109(v385)
			local v386 = not v111[v112];
			v111[v112] = v386;
			v8[v104] = v386;
		end
		v10[v110:GetName()] = v106;
	end
	v110:SetScript("OnEnter", v14.TipSee);
	v110:SetScript("OnLeave", GameTooltip_Hide);
	v110:SetScript("onClick", v109);
end
local function v29(v113, v114, v115, v116, v117, v118)
	v14.current[v113:GetName()].y = v14.current[v113:GetName()].y - (1241 - (696 + 510));
	if (v14.current[v113:GetName()].y <= -(989 - 517)) then
		v14.current[v113:GetName()].y = -(1354 - (1091 + 171));
		v14.current[v113:GetName()].x = 60 + 310;
	end
	local v120 = CreateFrame("Frame", "$parent" .. v16(), v113, "UIDropDownMenuTemplate");
	v120:SetPoint("TOPLEFT", v14.current[v113:GetName()].x, v14.current[v113:GetName()].y);
	v14.current[v113:GetName()].y = v14.current[v113:GetName()].y - (47 - 32);
	local v121, v122 = v26(v9, v6(".", v114));
	local v123;
	local v124 = v120:CreateFontString(v16(), "ARTWORK", "GameFontNormal");
	if (v118 and v118['ReloadRequired']) then
		v124:SetText(v116 .. "*");
		v10[v124:GetName()] = v117 .. "|n|n* " .. "Requires UI reload.";
		function v123(v389)
			UIDropDownMenu_SetSelectedID(v120, v389:GetID());
			v8[v114] = UIDropDownMenu_GetText(v120);
		end
	else
		v124:SetText(v116);
		v10[v124:GetName()] = v117;
		function v123(v391)
			UIDropDownMenu_SetSelectedID(v120, v391:GetID());
			local v392 = UIDropDownMenu_GetText(v120);
			v121[v122] = v392;
			v8[v114] = v392;
		end
	end
	local function v125(v264, v265)
		local v266 = UIDropDownMenu_CreateInfo();
		for v339, v340 in pairs(v115) do
			v266 = UIDropDownMenu_CreateInfo();
			v266.text = v340;
			v266.value = v340;
			v266.func = v123;
			UIDropDownMenu_AddButton(v266, v265);
		end
	end
	UIDropDownMenu_Initialize(v120, v125);
	UIDropDownMenu_SetSelectedValue(v120, v121[v122]);
	UIDropDownMenu_JustifyText(v120, "LEFT");
	v124:SetPoint("BOTTOMLEFT", v120, "TOPLEFT", 66 - 46, 379 - (123 + 251));
	v124:SetJustifyH("LEFT");
	v124:SetScript("OnEnter", v14.ShowDropTip);
	v124:SetScript("OnLeave", GameTooltip_Hide);
	v10[v120:GetName()] = v117;
	v120:SetScript("OnEnter", v14.ShowDropTip);
	v120:SetScript("OnLeave", GameTooltip_Hide);
end
local function v30(v127, v128, v129, v130, v131, v132, v133, v134)
	v14.current[v127:GetName()].y = v14.current[v127:GetName()].y - (49 - 39);
	if (v14.current[v127:GetName()].y <= -(1170 - (208 + 490))) then
		v14.current[v127:GetName()].y = -(4 + 43);
		v14.current[v127:GetName()].x = 165 + 205;
	end
	local v136 = CreateFrame("Button", "$parent" .. v16(), v127, "UIPanelButtonTemplate");
	v136:SetPoint("TOPLEFT", v14.current[v127:GetName()].x + (856 - (660 + 176)), v14.current[v127:GetName()].y);
	v14.current[v127:GetName()].y = v14.current[v127:GetName()].y - (2 + 8);
	if v132 then
		v136:SetWidth(v132);
	else
		v136:SetWidth(352 - (14 + 188));
	end
	if v133 then
		v136:SetHeight(v133);
	else
		v136:SetHeight(695 - (534 + 141));
	end
	if (v134 and v134['ReloadRequired']) then
		_G[v136:GetName() .. "Text"]:SetText(v129 .. "*");
		v10[v136:GetName()] = v130 .. "|n|n* " .. "Requires UI reload.";
	else
		_G[v136:GetName() .. "Text"]:SetText(v129);
		v10[v136:GetName()] = v130;
	end
	v136:SetScript("OnEnter", v14.TipSee);
	v136:SetScript("OnLeave", GameTooltip_Hide);
	v136:SetScript("onClick", v131);
end
local v31 = {Dropdown=v29,CheckButton=v28,Slider=v27,Button=v30};
v2.GUI.CreatePanelOption = function(v137, ...)
	v31[v137](...);
end;
v14['HiddenMenu'] = {};
v2.GUI.HidePanel = function(v138)
	if v138 then
		local v348 = -(21 + 31);
		table.insert(v14['HiddenMenu'], v138:GetName());
		v14.menu[v138:GetName()]:Hide();
		for v395, v396 in pairs(v14.Pages) do
			if v396 then
				local v405 = false;
				for v415, v416 in pairs(v14['HiddenMenu']) do
					if (v416 == v396:GetName()) then
						v405 = true;
					end
				end
				if not v405 then
					v14.menu[v396:GetName()]:SetPoint("TOPLEFT", 15 + 1, v348);
					v348 = v348 - (20 + 0);
				end
			end
		end
	end
end;
v2.GUI.ShowPanel = function(v139)
	if v139 then
		local v349 = -(108 - 56);
		for v397, v398 in ipairs(v14['HiddenMenu']) do
			if (v398 == v139:GetName()) then
				table.remove(v14['HiddenMenu'], v397);
			end
		end
		v14.menu[v139:GetName()]:Show();
		for v399, v400 in pairs(v14.Pages) do
			if v400 then
				local v406 = false;
				for v417, v418 in pairs(v14['HiddenMenu']) do
					if (v418 == v400:GetName()) then
						v406 = true;
					end
				end
				if not v406 then
					v14.menu[v400:GetName()]:SetPoint("TOPLEFT", 25 - 9, v349);
					v349 = v349 - (56 - 36);
				end
			end
		end
	end
end;
local v31 = v2.GUI.CreatePanelOption;
v14.LoadSettingsRecursively = function(v140, v141)
	local v141 = v141 or "";
	for v267, v268 in pairs(v140) do
		local v269;
		if (v141 ~= "") then
			v269 = v141 .. "." .. v267;
		else
			v269 = v267;
		end
		if (type(v268) == "table") then
			v14.LoadSettingsRecursively(v268, v269);
		else
			local v401 = v18(v267);
			local v402 = v19.GUISettings[v269];
			if (v402 ~= nil) then
				v140[v401] = v402;
			else
				v19.GUISettings[v269] = v268;
			end
		end
	end
end;
do
	local function v142(v270)
		return v4("Show GCD as Off GCD: %s", v270);
	end
	local function v143(v271)
		return v4("Enable if you want to put %s shown as Off GCD (top icons) instead of Main (Middle icon).", v271);
	end
	local function v144(v272)
		return v4("Show Off GCD as Off GCD: %s", v272);
	end
	local function v145(v273)
		return v4("Enable if you want to put %s shown as Off GCD (top icons) instead of Main (Middle icon).", v273);
	end
	local v146 = {Enabled=function(v274, v275, v276)
		v31("CheckButton", v274, v275, "Use: " .. v276, "Enable if you want to use " .. v276 .. ".");
	end,TimeToDie=function(v277, v278, v279)
		v31("Slider", v277, v278, {(0 + 0),(139 - 79),(2 - 1)}, v279 .. " Time To Die", "Time to Die remaining to use " .. v279);
	end,Defensive=function(v280, v281, v282)
		v31("Slider", v280, v281, {(867 - (550 + 317)),(140 - 40),(286 - (134 + 151))}, v282 .. " Health Percent Usage", "Health Percent to use defensive spell " .. v282);
	end,Cooldown=function(v283, v284, v285)
		v31("Dropdown", v283, v284, {"With Cooldowns","Always","Never"}, "Usage: " .. v285, "Cooldowns Usage for " .. v285 .. ".");
	end,DisplayStyle=function(v286, v287, v288)
		v31("Dropdown", v286, v287, {"Main Icon","Suggested","SuggestedRight","Cooldown"}, "Display Style: " .. v288, "Define which icon display style to use for " .. v288 .. ".");
	end,PotionType=function(v289, v290, v291)
		v31("Dropdown", v289, v290, {"Tempered Potion"}, "Potion Type: ", "Define which potion type to track.", {ReloadRequired=true});
	end,PotionRank=function(v292, v293, v294)
		v31("Dropdown", v292, v293, {"1","2","3","Any"}, "Potion Rank: ", "Define which potion rank to use.", {ReloadRequired=true});
	end,Interrupt=function(v295, v296, v297)
		if (v297 == "Auto Interrupt") then
			v31("CheckButton", v295, v296, v297, "Interrupt spells with interrupt spell.");
		elseif (v297 == "Auto Stun") then
			v31("CheckButton", v295, v296, v297, "Interrupt spells with stuns");
		elseif (v297 == "Auto Target Interrupt") then
			v31("CheckButton", v295, v296, v297, "Auto target for interrupt");
		elseif (v297 == "Auto Target Stun") then
			v31("CheckButton", v295, v296, v297, "Auto target for stun");
		elseif (v297 == "Interrupt Everything Raid") then
			v31("CheckButton", v295, v296, v297, "Interrupt everything while in raid.");
		elseif (v297 == "Interrupt Everything Solo") then
			v31("CheckButton", v295, v296, v297, "Interrupt everything while solo.");
		elseif (v297 == "Interrupt In Dungeon") then
			v31("Dropdown", v295, v296, {"None","Everything","Whitelist"}, v297, "Interrupt setting in dungeon.");
		elseif (v297 == "Interrupt In Dungeon Use Stun As Interrupt") then
			v31("CheckButton", v295, v296, v297, "Use stun as interrupt in dungeon");
		elseif (v297 == "Interrupt Percent") then
			v31("Slider", v295, v296, {(1000 - (451 + 549)),(155 - 55),(1385 - (746 + 638))}, v297, "Percentage of cast at which casts must be interrupted.");
		elseif (v297 == "Interrupt Percent Channel") then
			v31("Slider", v295, v296, {(0 - 0),(1681 - (1535 + 46)),(1 + 0)}, v297, "Percentage of cast at which channel casts must be interrupted.");
		end
	end,GCDasOffGCD=function(v298, v299, v300)
		v31("CheckButton", v298, v299, v142(v300), v143(v300));
	end,OffGCDasOffGCD=function(v301, v302, v303)
		v31("CheckButton", v301, v302, v144(v303), v145(v303));
	end};
	v14.CreateARPanelOption = function(v304, v305, v306, ...)
		v146[v304](v305, v306, ...);
	end;
	v14.CreateARPanelOptions = function(v307, v308)
		local v309 = {v6(".", v308)};
		local v310 = v13.GUISettingsGet();
		for v350 = 1 + 0, #v309 do
			v310 = v310[v309[v350]];
		end
		for v352, v353 in pairs(v146) do
			SettingsType = v310[v352];
			if SettingsType then
				local v404 = {};
				for v409, v410 in pairs(SettingsType) do
					table.insert(v404, v409);
				end
				table.sort(v404);
				for v411, v412 in ipairs(v404) do
					local v413 = "";
					for v419 in v5(v412, "[A-Z][a-z0-9]+") do
						if (v413 == "") then
							v413 = v419;
						else
							v413 = v413 .. " " .. v419;
						end
					end
					local v414 = v7({v308,v352,v412}, ".");
					v14.CreateARPanelOption(v352, v307, v414, v413);
				end
			end
		end
	end;
end
