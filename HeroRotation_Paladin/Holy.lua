local v0, v1 = ...;
local v2 = HeroDBC.DBC;
local v3 = HeroLib;
local v4 = HeroCache;
local v5 = v3.Unit;
local v6 = v5.Player;
local v7 = v5.Target;
local v8, v9 = v5.Focus, v5.MouseOver;
local v10 = v5.Pet;
local v11 = v3.Spell;
local v12 = v3.Item;
local v13 = HeroRotation();
local v14 = v13.AoEON;
local v15 = v13.CDsON;
local v16 = v13.Cast;
local v17 = v13.CastTarget;
local v18 = v13.Commons().Everyone;
local v19 = v13.Commons().Everyone.num;
local v20 = v13.Commons().Everyone.bool;
local v21 = math.floor;
local v22 = GetTotemInfo;
local v23 = GetTime;
local v24 = v11.Paladin.Holy;
local v25 = v12.Paladin.Holy;
local function v26(v120)
	return v120:NPCID() == (639562 - 435002);
end
local function v27(v121)
	return v121:NPCID() == (586025 - 381252);
end
local function v28(v122)
	return (v122:NPCID() == (394654 - 190205)) or (v122:NPCID() == (536968 - 328509)) or (v122:NPCID() == (209080 - (555 + 64))) or (v122:NPCID() == (208731 - (857 + 74))) or (v122:NPCID() == (195214 - (367 + 201))) or (v122:NPCID() == (213517 - (214 + 713)));
end
local function v29()
	return v28(v7) and not v6:CanAttack(v7);
end
local v30 = {v25.ScreamingBlackDragonScale:ID(),v25.BroodkeepersPromise:ID()};
local v31 = v18.converArrayToList({(50344 - (1523 + 114)),(69556 - 20764),(199859 - (226 + 1044)),(187944 - (32 + 85)),(22695 + 79647),(146318 - 84982),(668087 - 304171),(186445 - (67 + 113)),(111557 - 66119),(464414 - 347565),(330573 - 207790),(89005 + 33273),(1817 - 1175),(654 - 156),(15744 - 8804),(5773 + 27433),(47205 + 380),(98126 - 66902),(416489 - 308218),(334531 - 229758),(191834 - 83418),(118468 - (44 + 386)),(108729 + 233516),(364688 - (201 + 571))});
local v32, v33;
local v34;
local v35, v36;
local v37 = v13.GUISettingsGet();
local v38 = {General=v37.General,Commons=v37.APL.Paladin.Commons,Holy=v37.APL.Paladin.Holy,AoE=((not v6:IsInRaid() and v37.APL.Paladin.HolyAoE) or v37.APL.Paladin.HolyRaidAoE),AoE2=((not v6:IsInRaid() and v37.APL.Paladin.HolyAoE2) or v37.APL.Paladin.HolyRaidAoE2),Healing=((not v6:IsInRaid() and v37.APL.Paladin.HolyHealing) or v37.APL.Paladin.HolyRaidHealing),SpecialHealing=((not v6:IsInRaid() and v37.APL.Paladin.HolySpecialHealing) or v37.APL.Paladin.HolyRaidSpecialHealing),Cooldowns=v37.APL.Paladin.HolyCooldowns,TyrSettings=v37.APL.Paladin.HolyTyrs,DaySettings=v37.APL.Paladin.HolyDaybreak,Blessings=v37.APL.Paladin.HolyBlessings};
local function v39()
	for v177 = 1139 - (116 + 1022), 16 - 12 do
		local v178, v179, v180, v181 = v22(v177);
		if (v179 == v24.Consecration:Name()) then
			return (v21(((v180 + v181) - v23()) + 0.5 + 0)) or (0 - 0);
		end
	end
	return 0 - 0;
end
local function v40(v123)
	local v124 = v123:Name();
	for v182 = 860 - (814 + 45), 9 - 5 do
		local v183, v184, v185, v186 = v22(v182);
		if (v184 and v124 and strfind(v124, v184, 1 + 0, true)) then
			local v207 = math.floor(((v185 + v186) - v23()) + 0.5 + 0);
			if (v207 > (885 - (261 + 624))) then
				return v207;
			end
		end
	end
	return 0 - 0;
end
local v41 = v18.converArrayToList({(262164 - (630 + 793)),(2029042 - 1600500)});
local function v42(v125, v126, v127)
	return (v126 < v127) or v18.unitHasDebuffFromList(v41, v125);
end
local v43 = v18.converArrayToList({(1509681 - 1071208),(440792 - (1789 + 124)),(154389 + 294458),(1009365 - 752039),(214112 + 58599),(1934059 - 1494694),(992102 - 553225),(1235288 - 784066),(436947 - (376 + 325)),(1355309 - 914841),(715606 - 390697),(320990 - (85 + 291)),(1037527 - 764865),(271770 - (1123 + 57)),(269520 - (163 + 91)),(125563 + 323881),(673507 - 235012)});
local v44 = v18.converArrayToList({(605311 - 164843),(448191 - (1329 + 145)),(443066 - (1409 + 441)),(202624 + 234909),(441062 - (345 + 1376)),(1992950 - 1541848),(433323 - (696 + 510)),(435514 - (1091 + 171)),(1343793 - 916967),(449262 - (123 + 251)),(434791 - (208 + 490)),(203458 + 253293),(54298 + 397641),(452546 - (534 + 141)),(399782 + 52183),(966903 - 506811),(918363 - 590966),(204128 + 116468),(1057041 - 602602),(1035663 - 607128),(426841 - (550 + 317)),(602820 - 173941),(465297 - (134 + 151)),(810769 - 385890),(1524486 - 1084909),(1671243 - 1227749),(559844 - 136520),(428109 - (162 + 618)),(215231 + 107918),(540786 - 219117),(324250 - (1373 + 263)),(101587 + 220234),(542443 - 219687),(126127 + 209014),(333826 - (218 + 123)),(331498 + 2135),(322314 - (306 + 254)),(909014 - 445832),(300823 + 156841),(450698 - (268 + 335)),(450649 - (426 + 146)),(450900 - (282 + 1174)),(1277563 - 834056),(452246 - (706 + 318)),(428005 - (945 + 326)),(386765 + 47890),(403994 + 35798),(427857 - (461 + 625)),(22299 + 407128)});
local v45;
local function v46(v128)
	if v6:IsInRaid() then
		return false;
	end
	for v187, v188 in ipairs(v128) do
		if (v43[v188:CastSpellID()] or v43[v188:ChannelSpellID()]) then
			return true;
		end
	end
	return false;
end
local function v47(v129)
	if v6:IsInRaid() then
		return false;
	end
	for v189, v190 in ipairs(v129) do
		if (v44[v190:CastSpellID()] or v44[v190:ChannelSpellID()]) then
			return true;
		end
	end
	return false;
end
local v48 = v18.converArrayToList({(73707 + 119823),(5726 + 13848),(361481 - (406 + 123)),(45206 + 145113),(4450 + 8022),(28966 - 16924),(367250 - (106 + 1794)),(3476 + 10274),(308840 - 194790),(114635 - (57 + 527)),(205283 - (17 + 86)),(591396 - 326209),(265439 - (122 + 44)),(105773 - 73889),(33538 + 198357),(107639 - (30 + 35)),(2976 - (1043 + 214)),(48780 - (323 + 889)),(49608 - (361 + 219)),(34403 + 117876),(201148 - (18 + 964)),(112448 + 81775),(384260 - (20 + 830)),(102686 - (116 + 10)),(391152 - (542 + 196)),(31232 + 75719),(36913 + 65630),(961644 - 586557)});
local v49 = v18.converArrayToList({(226368 - (118 + 287)),(201303 - (118 + 1003)),(196731 - (142 + 235)),(49063 + 176421),(371338 - 174962),(258650 + 2091),(181369 + 245291),(894267 - 481762),(572778 - 316964),(1234425 - 978991),(92773 + 171377),(299148 + 112552),(968618 - 556660),(265287 - (476 + 255)),(116697 + 85036),(507684 - 239777),(37109 + 223442),(257743 - (144 + 192)),(320521 + 106138),(160011 + 216623),(386761 - (1183 + 397))});
local v50 = {[2 - 1]=true,[3 + 0]=true,[3 + 1]=true,[1981 - (1913 + 62)]=true,[6 + 2]=true,[23 - 14]=true,[1943 - (565 + 1368)]=true};
local v51 = {[3 - 2]=true,[1663 - (1477 + 184)]=true,[5 - 1]=true,[5 + 0]=true,[862 - (564 + 292)]=true,[11 - 4]=true,[23 - 15]=true,[315 - (244 + 60)]=true,[10 + 2]=true};
local function v52(v130, v131)
	return v131[v130] or false;
end
local function v53(v132)
	local v133 = nil;
	local v134 = v38.Blessings;
	if v134.ManualBlessings then
		v133 = (v6:IsInRaid() and v5(v134.BlessingofAutumnRaid)) or v5(v134.BlessingofAutumnParty);
		if (v133 and not v133:IsDeadOrGhost()) then
			return v133;
		end
	end
	for v191, v192 in pairs(v132) do
		if ((v192:Role() == "DAMAGER") and v52(v192:ClassID(), v50)) then
			if v18.unitHasBuffFromList(v48, v192) then
				return v192;
			end
			v133 = v192;
			break;
		end
	end
	return v133 or v6;
end
local function v54(v135)
	local v136 = nil;
	local v137 = v38.Blessings;
	if v137.SummerOnSelf then
		return v6;
	end
	if v137.ManualBlessings then
		v136 = (v6:IsInRaid() and v5(v137.BlessingOfSummerRaid)) or v5(v137.BlessingOfSummerParty);
		if (v136 and not v136:IsDeadOrGhost()) then
			return v136;
		end
	end
	for v193, v194 in pairs(v135) do
		if ((v194:Role() == "DAMAGER") and v52(v194:ClassID(), v51)) then
			if v18.unitHasBuffFromList(v48, v194) then
				return v194;
			end
			if not v136 then
				v136 = v194;
				break;
			end
		end
	end
	return v136 or v6;
end
local function v55(v138)
	local v139 = nil;
	local v140 = v38.Cooldowns;
	if v140.ManualSacredWeapon then
		v139 = (v6:IsInRaid() and v5(v140.SacredWeaponRaidUnit)) or v5(v140.SacredWeaponPartyUnit);
		if (v139 and not v139:IsDeadOrGhost()) then
			return v139;
		end
	end
	for v195, v196 in pairs(v138) do
		if (v196:Role() == "DAMAGER") then
			if v18.unitHasBuffFromList(v48, v196) then
				return v196;
			end
			if not v139 then
				v139 = v196;
				break;
			end
		end
	end
	return v139 or v6;
end
local function v56()
	local v141 = nil;
	local v142 = v38.Blessings;
	if v142.ManualBlessings then
		if v6:IsInRaid() then
			v141 = v5(v142.BlessingOFSpringRaid);
		else
			v141 = v5(v142.BlessingOFSpringParty);
		end
		if (v141 and not v141:IsDeadOrGhost() and v141:IsSpellInRange(v24.HolyShock)) then
			return v141;
		end
	end
	return v141 or v6;
end
local function v57()
	local v143 = nil;
	local v144 = v38.Blessings;
	if v144.ManualBlessings then
		v143 = (v6:IsInRaid() and v5(v144.BlessingOfWinterRaid)) or v5(v144.BlessingOfWinterParty);
		if (v143 and not v143:IsDeadOrGhost() and (v143:Role() == "HEALER") and v143:IsSpellInRange(v24.HolyShock)) then
			return v143;
		end
	end
	return v143 or v6;
end
local function v58(v145)
	for v197, v198 in pairs(v145) do
		local v199 = v11(323157 - (41 + 435));
		if ((v198:Role() ~= "TANK") and v198:DebuffDown(v24.ForbearanceDebuff) and v198:DebuffDown(v199)) then
			local v208 = v198:HealthPercentageWeighted();
			if ((not v6:IsInRaid() and v38.SpecialHealing.UseBoP and (v18.unitHasDebuffFromList(v18.DebuffList['Bleed'], v198) or v18.unitHasDebuffFromList(v49, v198))) or (v208 <= v38.SpecialHealing.BoPHP)) then
				return v198;
			end
		end
	end
	return nil;
end
local function v59(v146)
	if (v38.SpecialHealing.BoSHP == (1001 - (938 + 63))) then
		return nil;
	end
	local v147 = nil;
	local v148 = 77 + 23;
	local v149 = false;
	local v150 = false;
	for v200, v201 in pairs(v146) do
		if (v6 ~= v201) then
			local v209 = v201:HealthPercentage();
			local v210 = v38.SpecialHealing.BoSHP;
			if v18.unitHasBuffFromList(v31, v201) then
				v210 = 1140 - (936 + 189);
				break;
			end
			if (not v149 and not v6:IsInRaid()) then
				v150 = v47(v45) or v46(v45);
				v149 = true;
			end
			if ((v209 <= v210) or v150) then
				if (v209 < v148) then
					v148 = v209;
					v147 = v201;
					if (v209 <= (5 + 10)) then
						return v147;
					end
				end
			end
		end
	end
	return v147;
end
local function v60()
	if (v24.DevotionAura:IsReady() and not v6:IsMounted() and v6:BuffDown(v24.DevotionAuraBuff, true)) then
		v16(v24.DevotionAura);
		return "Devo Aura Cast";
	end
	if (v24.CrusaderAura:IsReady() and v6:IsMounted() and v6:BuffDown(v24.CrusaderAura, true)) then
		v16(v24.CrusaderAura);
		return "Crusader Aura Cast";
	end
end
local function v61(v151, v152, v153, v154, v155)
	local v156, v157, v158 = v6:GetUseableItems(v30, 1626 - (1565 + 48));
	if (v156 and v18.AoELogic(v151, v152, v155)) then
		if v16(v156) then
			return "trinket1 trinkets 2";
		end
	end
	local v159, v157, v160 = v6:GetUseableItems(v30, 9 + 5);
	if (v159 and v18.AoELogic(v153, v154, v155)) then
		if v16(v159) then
			return "trinket2 trinkets 4";
		end
	end
end
local function v62(v161, v162)
	local v163 = nil;
	local v164 = math.huge;
	for v202, v203 in pairs(v161) do
		if v203:BuffUp(v162, nil, true) then
			local v211 = v203:HealthPercentageWeighted();
			if (v211 < v164) then
				v164 = v211;
				v163 = v203;
			end
		end
	end
	if v163 then
		return v163;
	else
		return nil;
	end
end
local function v63(v165)
	local v166 = v6;
	local v167 = v166:HealthPercentageWeighted() + v166:IncomingHeals();
	local v168 = nil;
	local v169 = math.huge;
	for v204, v205 in pairs(v165) do
		local v206 = v205:HealthPercentageWeighted() + v205:IncomingHeals();
		if (v205:Role() == "TANK") then
			if (not (v205:ClassID() == (1144 - (782 + 356))) and (v205:HealthPercentage() >= (332 - (176 + 91)))) then
				v206 = v206 * (2.9 - 1);
			elseif (v205:PowerPercentage() > (29 - 9)) then
				v206 = v206 * (1093.2 - (975 + 117));
			end
		end
		if (v206 < v167) then
			v167 = v206;
			v166 = v205;
		end
		if (v205:Role() == "TANK") then
			if ((v168 == nil) or (v206 < v169)) then
				v169 = v206;
				v168 = v205;
			end
		end
	end
	return v166, v168;
end
local function v64(v170)
	local v171 = UnitGUID("targettarget");
	if (v170 ~= nil) then
		for v212, v213 in pairs(v170) do
			if ((v213:GUID() == v171) and ((v7:CastSpellID() == (322663 - (157 + 1718))) or (v7:CastSpellID() == (262725 + 61005)))) then
				if (v213 ~= nil) then
					return v213;
				end
			end
		end
	end
end
local v65 = nil;
local v66 = nil;
local v67 = nil;
local v68, v69, v70, v71, v72, v73, v74, v75, v76, v77, v78, v79;
local v80, v81, v82, v83, v84, v85, v86, v87, v88, v89, v90, v91, v92, v93, v94, v95, v96, v97, v98;
local v99;
local v100, v101, v102, v103, v104, v105, v106, v107;
local v108, v109, v110, v111, v112, v113, v114;
local function v115()
	if (v24.DivineProtection:IsCastable() and (v38.Holy.DivineProtectionHP > (0 - 0)) and ((v6:HealthPercentageWeighted() <= v38.Holy.DivineProtectionHP) or (not v6:IsInRaid() and (v47(v45) or v46(v45)))) and v6:BuffDown(v24.DivineShield)) then
		v13.Cast(v24.DivineProtection);
		return "Divine Protection HP:" .. v6:HealthPercentageWeighted();
	end
	if (v24.DivineShield:IsCastable() and (v38.Holy.BubbleHP > (0 - 0)) and (v6:HealthPercentage() <= v38.Holy.BubbleHP) and v6:BuffDown(v24.ForbearanceDebuff) and (v6:BuffDown(v24.DivineProtection) or (v6:HealthPercentage() < (1028 - (697 + 321))))) then
		v13.Cast(v24.DivineShield);
		return "Divine Shield HP:" .. v6:HealthPercentage();
	end
end
local function v116()
	v38.AoE = (not v6:IsInRaid() and v37.APL.Paladin.HolyAoE) or v37.APL.Paladin.HolyRaidAoE;
	v38.AoE2 = (not v6:IsInRaid() and v37.APL.Paladin.HolyAoE2) or v37.APL.Paladin.HolyRaidAoE2;
	v38.Healing = (not v6:IsInRaid() and v37.APL.Paladin.HolyHealing) or v37.APL.Paladin.HolyRaidHealing;
	v38.SpecialHealing = (not v6:IsInRaid() and v37.APL.Paladin.HolySpecialHealing) or v37.APL.Paladin.HolyRaidSpecialHealing;
	v89 = v13.ToggleIconFrame:GetToggle(2 - 1);
	v90 = v13.ToggleIconFrame:GetToggle(5 - 2);
	v107 = v13.ToggleIconFrame:GetToggle(11 - 6);
	v110 = v13.ToggleIconFrame:GetToggle(3 + 3);
	v36 = v18.UnitsinRange(v24.HolyShock);
	v33 = #(v6:GetEnemiesInMeleeRange(9 - 4));
	v77 = v13.ToggleIconFrame:GetToggle(5 - 3);
	v32 = v6:GetEnemiesInMeleeRange(1235 - (322 + 905));
	v99 = v7:IsInMeleeRange(616 - (602 + 9));
	v45 = v6:GetEnemiesInMeleeRange(1229 - (449 + 740));
	v112 = v64(v36);
	if v14() then
		v34 = ((#v32 > (872 - (826 + 46))) and #v32) or (948 - (245 + 702));
	else
		v34 = 3 - 2;
	end
	v68, v69 = v18.GetLowestHealthUnit(v36);
	if v69 then
		v71 = v69:HealthPercentage();
		v98 = math.min(v71 + v69:IncomingHeals(), 33 + 67);
	else
		v71 = 1998 - (260 + 1638);
		v98 = 540 - (382 + 58);
	end
	if v68 then
		v70 = v68:HealthPercentageWeighted();
		v96 = v68:HealthPercentage();
		v111 = math.min(v70 + v68:IncomingHeals(), 320 - 220);
		v97 = math.min(v96 + v68:IncomingHeals(), 84 + 16);
	else
		v70 = 206 - 106;
		v96 = 297 - 197;
		v111 = 1305 - (902 + 303);
		v97 = 219 - 119;
	end
	v72 = v62(v36, v24.TyrsDeliveranceBuff);
	v74 = (v6:BuffUp(v24.SealofClarity) and (4 - 2)) or (1 + 2);
	v75 = v6:BuffUp(v24.DivinePurposeBuff) or (v6:HolyPower() >= v74) or v6:BuffUp(v24.ShiningRighteousness);
	v76 = v6:BuffUp(v24.DivinePurposeBuff) and (v6:BuffRemains(v24.DivinePurposeBuff) < (1692 - (1121 + 569)));
	v108 = (v24.EternalFlame:IsAvailable() and v24.EternalFlame) or v24.WoG;
	v79 = v18.BuffCount(v36, v24.BoV);
	v80 = v13.ToggleIconFrame:GetToggle(218 - (22 + 192));
	v106 = (v24.BarrierofFaith:IsAvailable() and ((v6:BuffUp(v24.BlessingofDawn) and (v6:BuffStack(v24.BlessingofDawn) >= (685 - (483 + 200)))) or v6:BuffDown(v24.Infusion) or not v24.HolyShock:IsReady())) or not v24.BarrierofFaith:IsAvailable();
	v113 = (v6:BuffUp(v24.AvengingCrusader) and not v24.CrusaderStrike:IsReady() and not v24.HolyShock:IsReady() and not v24.HammerofWrath:IsReady() and not v75 and not v24.Judgment:IsReady()) or v6:BuffDown(v24.AvengingCrusader);
	v114 = (v24.CrusadersMight:IsAvailable() and ((v24.HolyShock:FullRechargeTime() >= (1465 - (1404 + 59))) or (v24.Judgment:CooldownRemains() >= (5 - 3)))) or not v24.CrusadersMight:IsAvailable();
	if v24.BlessingofSummer:IsAvailable() then
		if v24.BlessingofAutumn:IsReady() then
			v103 = v53(v36);
		end
		if v24.BlessingofSpring:IsReady() then
			v102 = v56();
		end
		if v24.BlessingofSummer:IsReady() then
			v100 = v54(v36);
		end
		if v24.BlessingofWinter:IsReady() then
			v101 = v57();
		end
	end
	if v24.SacredWeapon:IsReady() then
		v109 = v55(v36);
	end
	if v24.BlessingofSacrifice:IsReady() then
		v104 = (not v6:IsInRaid() and v38.SpecialHealing.UseBoS and v59(v36)) or v68;
	end
	if v24.BlessingofProtection:IsReady() then
		v105 = v58(v36);
	end
end
local function v117()
	if (v24.DevotionAura:IsReady() and not v6:IsMounted() and v6:BuffDown(v24.DevotionAuraBuff, true)) then
		v16(v24.DevotionAura);
		return "Devo Aura Cast";
	end
	if ((v70 >= (60 - 15)) and v27(v7) and (v24.Cleanse:CooldownDown() or not v24.ImprovedCleanse:IsAvailable()) and v7:IsInRange(805 - (468 + 297))) then
		if v24.HolyShock:IsReady() then
			v16(v24.HolyShock);
			return;
		end
		if (v75 and v108:IsReady()) then
			v16(v108);
			return;
		end
	end
	if ((v70 >= (597 - (334 + 228))) and v29() and (v7:HealthPercentage() > (0 - 0)) and (v7:HealthPercentage() < (231 - 131))) then
		if v24.HolyShock:IsReady() then
			v16(v24.HolyShock);
			return;
		end
		if (v75 and v108:IsReady()) then
			v16(v108);
			return;
		end
	end
	if v24.Intercession:IsReady() then
		if (v7:UnitIsFriend() and v7:IsAPlayer() and v7:Exists() and v7:IsDeadOrGhost()) then
			v13.Cast(v24.Intercession);
			return "Intercession on Target";
		end
		if (v9:UnitIsFriend() and v9:IsAPlayer() and v9:Exists() and v9:IsDeadOrGhost()) then
			v13.CastTarget(v24.Intercession, v13.TName().MOUSEOVER);
			return "Intercession on Mouseover";
		end
	end
	if (v107 and (v6:IsInParty() or v6:IsInRaid())) then
		if (v70 <= (54 - 24)) then
			v13.CastMacro(1 + 1, true);
		end
	end
	if not v107 then
		if (v24.LoH:IsReady() and v6:AffectingCombat()) then
			if (v65 == nil) then
				v65 = v68;
			end
			if ((v65:HealthPercentage() > v38.SpecialHealing.LoHHP) and (v65:HealthPercentage() > (236 - (141 + 95)))) then
				v65 = nil;
			end
			if (v65 ~= nil) then
				if (v65:DebuffDown(v24.ForbearanceDebuff) and (v65:HealthPercentage() <= v38.SpecialHealing.LoHHP) and (v65:HealthPercentage() > (0 + 0))) then
					v65:Cast(v24.LoH);
					return "LoH";
				end
			end
		end
		if ((v6:HealthPercentage() >= (77 - 47)) and v6:AffectingCombat()) then
			if v24.BlessingofSacrifice:IsReady() then
				if ((v104 ~= nil) and (not v104 == v68) and (v104 ~= v6)) then
					v104:Cast(v24.BlessingofSacrifice);
					return "Blessing of Sac - Logic";
				end
				if ((v104 == v68) and (v104 ~= v6)) then
					if (v104:HealthPercentageWeighted() <= v38.SpecialHealing.BoSHP) then
						v104:Cast(v24.BlessingofSacrifice);
						return "Blessing of Sac";
					end
				end
			end
		end
		if v24.BlessingofProtection:IsReady() then
			if (v105 ~= nil) then
				v105:Cast(v24.BlessingofProtection);
				return "BoP Casted with Logic";
			end
		end
		if (v24.BoV:IsReady() and v6:AffectingCombat() and (v18.AoELogicWithCountUnweighted(v38.AoE.BoVHP, v38.AoE.BoVCount, v38.Cooldowns.BoVUsage, v36) or ((v38.Cooldowns.BoVUsage == "With Logic") and (v47(v45) or v46(v45))))) then
			v68:Cast(v24.BoV);
			return "BoV Casted Per Settings";
		end
		if (v6:BuffUp(v24.AwakeningMaxBuff) and v18.TargetIsValid() and v7:AffectingCombat() and v6:AffectingCombat() and v6:IsInRange(72 - 42) and v24.Judgment:IsReady()) then
			if not v24.BoV:IsAvailable() then
				if v18.AoELogicWithCount(v38.SpecialHealing.AwakeningHP, v38.SpecialHealing.AwakeningCount, "With Logic", v36) then
					v13.Cast(v24.Judgment);
					return "Judgement for Awakening Proc - Higher Priority with BoV Active or Untalented";
				end
			end
		end
		if v6:AffectingCombat() then
			if (v24.AvengingWrath:IsReady() and v18.AoELogicWithCountUnweighted(v38.AoE.AWHP, v38.AoE.AWCount, v38.Cooldowns.AWUsage, v36)) then
				v13.Cast(v24.AvengingWrath, false);
				return "Avenging Wrath Casted Per Settings";
			end
			if (v24.AvengingCrusader:IsReady() and v18.AoELogicWithCountUnweighted(v38.AoE.ACHP, v38.AoE.ACCount, v38.Cooldowns.ACUsage, v36)) then
				v16(v24.AvengingCrusader, false);
				return "Avenging Crusader Casted Per Settings";
			end
			if (v24.AuraMastery:IsReady() and v6:BuffDown(v24.AvengingWrathBuff) and v6:BuffDown(v24.AvengingCrusader) and (v18.GetAverageGroupHealthPercent(v36) <= (4 + 11)) and v18.AoELogicWithCountUnweighted(v38.AoE.AMHP, v38.AoE.AMCount, v38.Cooldowns.AMUsage, v36)) then
				v16(v24.AuraMastery, false);
				return "Aura Mastery Casted Per Settings";
			end
		end
		v91 = false;
		if (v91 and v6:IsInRaid() and not v6:AffectingCombat()) then
			v91 = false;
		end
		v92 = false;
		if (v92 and v6:IsInRaid() and not v6:AffectingCombat()) then
			v92 = false;
		end
		if not v38.Holy.ManualBeacon then
			if (v69 ~= nil) then
				if (v24.BoL:IsReady() and not v92 and v69:BuffDown(v24.BoL) and v69:BuffDown(v24.BoF) and (v18.BuffCount(v36, v24.BoL) < (2 - 1))) then
					v69:Cast(v24.BoL);
					if v6:IsInRaid() then
						v92 = true;
					end
					return "BoL On Lowest Tank";
				end
			end
			if (v24.BoF:IsReady() and not v91 and v6:BuffDown(v24.BoF) and v6:BuffDown(v24.BoL) and (v18.BuffCount(v36, v24.BoF) < (1 + 0))) then
				v6:Cast(v24.BoF);
				if v6:IsInRaid() then
					v91 = true;
				end
				return "BoF On Player";
			end
		end
		if v6:AffectingCombat() then
			if (v109 ~= nil) then
				if v24.SacredWeapon:IsReady() then
					v109:Cast(v24.SacredWeapon);
					return "Sacred Weapon";
				end
			end
			if v24.HolyBulwark:IsReady() then
				if v38.Healing.HBTank then
					if (v69 ~= nil) then
						if (v71 <= v38.Healing.HBHP) then
							v69:Cast(v24.HolyBulwark);
							return "Holy Bulwark";
						end
					end
				end
				if ((v38.Healing.HBTank and (v70 <= (14 + 11)) and (v70 <= v38.Healing.HBHP)) or (not v38.Healing.HBTank and (v70 <= v38.Healing.HBHP))) then
					v68:Cast(v24.HolyBulwark);
					return "Holy Bulwark";
				end
			end
		end
		if ((v24.BoV:CooldownRemains() >= (11.5 - 3)) or (v79 > (1 + 0)) or not v24.BoV:IsAvailable()) then
			if (v68 ~= nil) then
				if (v24.DivineToll:IsReady() and v18.AoELogicWithCountUnweighted(v38.AoE.DivineTollHP, v38.AoE.DivineTollCount, v38.Cooldowns.DTUsage, v36)) then
					v68:Cast(v24.DivineToll);
					return "Divine Toll via Settings or in Party";
				end
			end
		end
		if v6:BuffUp(v24.AvengingCrusader) then
			if (v79 >= (164 - (92 + 71))) then
				if (v108:IsReady() and v75 and ((v70 <= v38.Healing.WoGHP) or v76)) then
					v68:Cast(v108);
					return "WoG on BoV Unit During AC";
				end
			end
			if (v24.Judgment:IsReady() and v7:IsInRange(15 + 15) and (v70 <= v38.SpecialHealing.JudgementInAC) and v18.TargetIsValid()) then
				v16(v24.Judgment);
				return "Judgement During AC";
			end
			if (v24.CrusaderStrike:IsReady() and v99 and (v70 <= (151 - 61)) and v18.TargetIsValid()) then
				v16(v24.CrusaderStrike);
				return "Crusader Strike During AC";
			end
			if ((v108:IsReady() and v75 and ((v6:HolyPower()) >= (770 - (574 + 191))) and (v70 <= v38.Healing.WoGHP)) or v76) then
				v68:Cast(v108);
				return "WoG During AC";
			end
			if (v80 and v24.LoD:IsReady() and v75 and v6:BuffDown(v24.EmpyreanLegacy) and (v18.AoELogicWithCount(v38.AoE.LoDHP, v38.AoE.LoDCount, "With Logic", v36) or v76)) then
				v16(v24.LoD);
				return "LoD During Ac";
			end
			if (v24.HolyShock:IsReady() and (v70 <= v38.Healing.HolyShockHP)) then
				v68:Cast(v24.HolyShock);
				return "Holy Shock During AC";
			end
			if (v24.HammerofWrath.IsReady() and v7:IsInRange(25 + 5) and v18.TargetIsValid()) then
				v16(v24.HammerofWrath);
				return " Hammer of Wrath During AC";
			end
		end
		if ((v24.BoV:CooldownRemains() >= (19.5 - 11)) or (v79 > (1 + 0)) or not v24.BoV:IsAvailable()) then
			if ((v24.DivineToll:IsAvailable() and (v24.DivineToll:CooldownRemains() < (901 - (254 + 595))) and v24.DivineResonanceTalent:IsAvailable()) or not v24.DivineResonanceTalent:IsAvailable()) then
				if (((v6:BuffUp(v24.AwakeningBuff) and (v6:BuffStack(v24.AwakeningBuff) < (140 - (55 + 71)))) or v6:BuffDown(v24.AwakeningBuff)) and v6:BuffDown(v24.AvengingWrathBuff) and v6:BuffDown(v24.AvengingCrusader)) then
					if (v24.HolyPrism:IsReady() and (v70 > (58 - 13)) and v7:IsInRange(1830 - (573 + 1217)) and v6:AffectingCombat() and v6:AffectingCombat() and v18.TargetIsValid() and v18.AoELogicWithCount(v38.AoE2.HPHP, v38.AoE2.HPCount, v38.Cooldowns.HPUsage, v36)) then
						v16(v24.HolyPrism);
						return "Holy Prism on Target per Settings";
					end
					if (v24.HolyPrism:IsReady() and (v70 <= (124 - 79)) and v18.AoELogicWithCount(v38.AoE2.HPHP, v38.AoE2.HPCount, v38.Cooldowns.HPUsage, v36)) then
						v68:Cast(v24.HolyPrism);
						return "Holy Prism on Lowet Unit per Settings";
					end
				end
			end
		end
		if (v24.HandofDivintiy:IsReady() and not v6:IsMoving() and v38.TyrSettings.BeforeTyrs and v18.AoELogicWithCount(v38.AoE.TyrsHP, v38.AoE.TyrsCount, "With Logic", v36) and ((not v6:IsInRaid() and v6:IsInParty() and (v70 >= (5 + 55))) or v6:IsInRaid())) then
			v16(v24.HandofDivintiy);
			return "Hand of Divinity before Tyrs";
		end
		if (v24.TyrsDeliverance:IsReady() and (v18.AoELogicWithCount(v38.AoE.TyrsHP, v38.AoE.TyrsCount, "With Logic", v36) or (v6:BuffUp(v24.HandofDivintiy) and (v38.AoE.TyrsHP > (0 - 0)))) and not v6:IsMoving()) then
			v16(v24.TyrsDeliverance);
			return "Tyr's based on Settings and/or Hand of Divinity Buff";
		end
		if (v24.HandofDivintiy:IsReady() and not v6:IsMoving() and (v70 <= v38.SpecialHealing.HandofDivinityHP) and (v70 >= (984 - (714 + 225))) and not v6:IsMoving()) then
			v16(v24.HandofDivintiy);
			return "Hand of Divinity Normal";
		end
		if (v6:BuffUp(v24.DivineFavorBuff) and v24.FoL:IsReady() and not v6:PrevGCD(2 - 1, v24.FoL) and not v6:IsCasting() and (((v111 <= v38.SpecialHealing.FoLBoth) and v6:BuffUp(v24.Infusion)) or (v111 <= v38.SpecialHealing.FoLDFHP)) and not v6:IsMoving()) then
			v68:Cast(v24.FoL);
			return "FoL for Divine Favor";
		end
		if (v6:BuffUp(v24.DivineFavorBuff) and v24.HolyLight:IsReady() and not v6:PrevGCD(1 - 0, v24.HolyLight) and not v6:IsCasting() and (((v111 <= v38.SpecialHealing.HLBoth) and v6:BuffUp(v24.Infusion)) or (v111 <= v38.SpecialHealing.HLDFHP)) and not v6:IsMoving()) then
			v68:Cast(v24.HolyLight);
			return "Holy Light for Divine Favor";
		end
		if (v69 ~= nil) then
			if (not v24.HolyShock:IsReady() and (not v6:IsInRaid() or (v6:IsInRaid() and (v6:HolyPower() > (1 + 3))))) then
				if (v24.FoL:IsReady() and not v6:IsMoving() and v6:BuffUp(v24.Infusion) and (v98 <= v38.Healing.FoLIHP)) then
					v69:Cast(v24.FoL);
					return "FoL Infusion Priority - Tank";
				end
			end
			if (v108:IsReady() and v75 and (v71 <= v38.Healing.WoGTankHP)) then
				v69:Cast(v108);
				return "WoG on Tank";
			end
		end
		if (v69 ~= nil) then
			if (v24.BarrierofFaith:IsReady() and v69:BuffDown(v24.BarrierofFaith)) then
				v69:Cast(v24.BarrierofFaith);
				return "Barrier of Faith";
			end
		end
		if (not v75 or not v24.HolyShock:IsReady()) then
			if (v24.FoL:IsReady() and v6:BuffDown(v24.HandofDivintiyBuff) and v6:BuffDown(v24.TyrsDeliverancePlayerBuff) and not v6:IsMoving() and ((v111 <= v38.Healing.FoLHP) or (v6:BuffUp(v24.Infusion) and (v111 <= v38.Healing.FoLIHP)))) then
				v68:Cast(v24.FoL);
				return "FoL Emergency or Infusion Priority - Unit Lowest";
			end
		end
		if ((v111 >= (93 - 28)) and v6:AffectingCombat() and v24.BlessingofSummer:IsAvailable()) then
			if (v24.BlessingofAutumn:IsReady() and (v103 ~= nil)) then
				v103:Cast(v24.BlessingofAutumn);
				return "Blessing of Autmun Cast";
			end
			if (v24.BlessingofSpring:IsReady() and (v102 ~= nil)) then
				v102:Cast(v24.BlessingofSpring);
				return "Blessing of Spring Cast";
			end
			if (v24.BlessingofWinter:IsReady() and (v101 ~= nil)) then
				v101:Cast(v24.BlessingofWinter);
				return "Blessing of Winter";
			end
			if (v24.BlessingofSummer:IsReady() and (v100 ~= nil)) then
				v100:Cast(v24.BlessingofSummer);
				return "Blessing of Summer";
			end
		end
		if (v6:BuffUp(v24.TyrsDeliverancePlayerBuff) and v24.BoundlessSalvation:IsAvailable()) then
			if (v72 ~= nil) then
				if (v24.HolyLight:IsReady() and v6:BuffUp(v24.HandofDivintiy) and ((v72:HealthPercentage() <= v38.TyrSettings.TyrHLHP) or (v6:BuffRemains(v24.HandofDivintiy) <= (812 - (118 + 688))))) then
					v72:Cast(v24.HolyLight);
					return "Holy Light on Tyr's Target";
				end
				if (v24.HolyShock:IsReady() and (((v6:HolyPower() < (53 - (25 + 23))) and v6:BuffDown(v24.RisingSunlight)) or ((v6:HolyPower() < (1 + 2)) and v6:BuffUp(v24.RisingSunlight)))) then
					v72:Cast(v24.HolyShock);
					return "Holy Shock on Tyr's Target";
				end
				if (v24.FoL:IsReady() and (v72:HealthPercentage() <= v38.TyrSettings.TyrFoLHP) and not v6:IsMoving()) then
					v72:Cast(v24.FoL);
					return "Flash of Light on Tyr's Target";
				end
			end
		end
		if (v6:BuffDown(v24.TyrsDeliverancePlayerBuff) or not v24.BoundlessSalvation:IsAvailable()) then
			if (v24.HolyLight:IsReady() and v6:BuffUp(v24.HandofDivintiy) and ((v70 <= v38.SpecialHealing.HandofDivinityHP) or (v6:BuffRemains(v24.HandofDivintiy) <= (1892 - (927 + 959))))) then
				v68:Cast(v24.HolyLight);
				return "Holy Light with HoD";
			end
		end
		if v24.VenerationTalent:IsAvailable() then
			if ((v24.EternalFlame:IsAvailable() and not v75) or not v24.EternalFlame:IsAvailable()) then
				if (v24.HammerofWrath:IsReady() and v7:IsInRange(101 - 71) and v18.TargetIsValid()) then
					v13.Cast(v24.HammerofWrath);
					return "Hammer of Wrath Veneration";
				end
			end
		end
		if (v79 >= (733 - (16 + 716))) then
			if ((not v6:IsInRaid() or v6:BuffUp(v24.EmpyreanLegacy)) and v108:IsReady() and v75 and ((v70 <= v38.Healing.WoGHP) or v18.AoELogicWithCount(v38.AoE.LoDHP, v38.AoE.LoDCount, "With Logic", v36) or v76)) then
				v68:Cast(v108);
				return "WoG during BoV";
			end
			if (v6:IsInRaid() and v80 and v24.LoD:IsReady() and v75 and v6:BuffDown(v24.EmpyreanLegacy) and (v18.AoELogicWithCount(v38.AoE.LoDHP, v38.AoE.LoDCount, "With Logic", v36) or v76)) then
				v16(v24.LoD);
				return "LoD in Raid During BoV";
			end
		end
		if (v80 and v108:IsReady() and v75 and v106 and ((v70 <= v38.Healing.WoGOverHP) or v76)) then
			v68:Cast(v108);
			return "WoG Over LoD";
		end
		if (v79 < (1 - 0)) then
			if (v80 and v106 and v24.LoD:IsReady() and v75 and v6:BuffDown(v24.EmpyreanLegacy) and (v18.AoELogicWithCount(v38.AoE.LoDHP, v38.AoE.LoDCount, "With Logic", v36) or v76)) then
				v16(v24.LoD);
				return "LoD";
			end
		end
		if (v108:IsReady() and v106 and v75 and ((v70 <= v38.Healing.WoGHP) or v76)) then
			v68:Cast(v108);
			return "WoG";
		end
		if (v24.FoL:IsReady() and not v6:IsMoving() and v6:BuffUp(v24.Infusion) and (v111 <= v38.Healing.FoLIHP)) then
			v68:Cast(v24.FoL);
			return "FoL For Infusion";
		end
		if v24.HolyShock:IsReady() then
			v83 = v42(v68, v96, v38.Healing.HolyShockHP);
			v84 = v42(v68, v96, v38.Healing.HolyShock2HP);
			v85 = v83 and v6:BuffDown(v24.RisingSunlight);
			v86 = v84 and (v24.HolyShock:Charges() == (99 - (11 + 86))) and v6:BuffDown(v24.RisingSunlight);
			v87 = (v70 <= v38.Healing.HolyShockRHP) and v6:BuffUp(v24.RisingSunlight);
			v88 = ((v6:HolyPower() < (12 - 7)) and v6:BuffDown(v24.RisingSunlight)) or ((v6:HolyPower() < (289 - (175 + 110))) and v6:BuffUp(v24.RisingSunlight)) or v38.Holy.Overcap;
			if ((v85 or v86 or v87) and v88) then
				v68:Cast(v24.HolyShock);
				return "Holy Shock Cast";
			end
		end
		if (v18.TargetIsValid() and v7:AffectingCombat()) then
			if (v24.HammerofWrath:IsReady() and v7:IsInRange(75 - 45)) then
				v13.Cast(v24.HammerofWrath);
				return "Hammer of Wrath";
			end
			if (v24.Judgment:IsReady() and v7:IsInRange(147 - 117) and ((v70 <= (1886 - (503 + 1293))) or v6:BuffUp(v24.AwakeningMaxBuff))) then
				v13.Cast(v24.Judgment);
				return "Judgement";
			end
			if (v24.CrusaderStrike:IsReady() and ((v6:HolyPower() < (13 - 8)) or v38.Holy.Overcap) and v99) then
				v13.Cast(v24.CrusaderStrike);
				return "Crusader Strike";
			end
		end
		if (v24.FoL:IsReady() and v113 and not v6:IsMoving() and ((v70 <= v38.Healing.FoLHP) or (v6:BuffUp(v24.Infusion) and (v111 <= v38.Healing.FoLIHP)))) then
			v68:Cast(v24.FoL);
			return "FoL For Infusion or Normal";
		end
		if (v24.HolyLight:IsReady() and v113 and (not v6:IsMoving() or v6:BuffUp(v24.HandofDivintiy)) and ((v111 <= v38.Healing.HLHP) or (v6:BuffUp(v24.Infusion) and (v111 <= v38.Healing.HLIHP)))) then
			v68:Cast(v24.HolyLight);
			return "Holy Light For Infusion or Normal";
		end
	end
	if (v18.TargetIsValid() and ((v70 >= (33 + 12)) or v107) and not v26(v7) and (v7:AffectingCombat() or (v38.Holy.AttackOOC and v89))) then
		if (v24.Consecration:IsReady() and v7:IsInRange(1069 - (810 + 251)) and not v6:IsMoving() and (v40(v24.Consecration) <= (0 + 0))) then
			v16(v24.Consecration);
			return "consecration priority 20";
		end
		if (v24.ShieldoftheRighteous:IsUsable() and v99 and (v6:HolyPower() >= (1 + 2)) and ((v6:BuffUp(v24.AvengingWrathBuff) and (v111 >= (50 + 5))) or v110 or v107)) then
			v13.Cast(v24.ShieldoftheRighteous);
			return "shield_of_the_righteous priority 2";
		end
		if (v24.HammerofWrath:IsReady() and v7:IsInRange(563 - (43 + 490)) and ((v6:HolyPower() < (738 - (711 + 22))) or v38.Holy.Overcap or v107)) then
			v16(v24.HammerofWrath);
			return "hammer_of_wrath priority 4";
		end
		if (v24.DivineToll:IsReady() and v107 and v38.Holy.UseDTDPS and v7:IsInRange(154 - 114)) then
			v16(v24.DivineToll);
			return "Divine Toll for DPS Only";
		end
		if (v24.HammerofWrath:IsReady() and v7:IsInRange(889 - (240 + 619)) and ((v6:HolyPower() < (2 + 3)) or v38.Holy.Overcap or v107)) then
			v16(v24.HammerofWrath);
			return "hammer_of_wrath priority 14";
		end
		if (v24.Judgment:IsReady() and v7:IsInRange(47 - 17) and ((v6:HolyPower() < (1 + 4)) or v38.Holy.Overcap or v107)) then
			v16(v24.Judgment);
			return "judgment priority 16";
		end
		if (v24.HolyShock:IsReady() and v7:IsInRange(1784 - (1344 + 400)) and ((v38.Holy.UseHolyShockDPS and ((v6:HolyPower() < (410 - (255 + 150))) or v38.Holy.Overcap)) or v107)) then
			v16(v24.HolyShock);
			return "holy_shock priority 22";
		end
		if (v24.CrusaderStrike:IsReady() and v99 and ((v6:HolyPower() < (4 + 1)) or v38.Holy.Overcap or v107)) then
			v16(v24.CrusaderStrike);
			return "crusader_strike priority 24";
		end
		if (v24.HolyPrism:IsReady() and ((v34 >= (2 + 0)) or v107)) then
			v6:Cast(v24.HolyPrism);
			return "holy_prism on self priority 26";
		end
	end
end
local function v118()
	if (not v6:IsInRaid() and v18.ShouldStopCastUpdate()) then
		v13.CastMacro(25 - 19, true);
		return "Stop Cast For Silence";
	end
	local v176 = v18.HealthPotions();
	if v176 then
		return v176;
	end
	if not v6:AffectingCombat() then
		v176 = v60();
		if v176 then
			return v176;
		end
	end
	if (not v6:IsMounted() and not v6:IsChanneling() and (v18.TargetIsValid() or v6:AffectingCombat() or v89)) then
		if v90 then
			v176 = v18.InterruptCycle(v24.Rebuke, 16 - 11, true, nil, false, false);
			if v176 then
				return v176;
			end
			if (v24.Rebuke:CooldownDown() or not v24.Rebuke:IsAvailable()) then
				if (v24.BlindingLight:IsReady() and v38.Holy.UseBL) then
					v176 = v18.InterruptCycle(v24.BlindingLight, 1749 - (404 + 1335), false, nil, true, true);
					if v176 then
						return v176;
					end
				end
				if v24.HammerofJustice:IsReady() then
					v176 = v18.InterruptCycle(v24.HammerofJustice, 416 - (183 + 223), false, nil, true);
					if v176 then
						return v176;
					end
				end
			end
		end
		if (v24.BlessingofFreedom:IsReady() and v38.Holy.UseFreedom) then
			if (v112 ~= nil) then
				if v112:Cast(v24.BlessingofFreedom) then
					return "Blessing of Freedom Frozen Binds";
				end
			end
		end
		if (v24.BlessingofFreedom:IsReady() and v38.Holy.UseFreedom) then
			v176 = v18.DispelCycle(v24.BlessingofFreedom, "RootDispel", nil, v36);
			if v176 then
				return v176;
			end
			v176 = v18.DispelCycle(v24.BlessingofFreedom, "SnareRoot", nil, v36);
			if v176 then
				return v176;
			end
			v176 = v18.DispelCycle(v24.BlessingofFreedom, "FreedomDispel", nil, v36);
			if v176 then
				return v176;
			end
		end
		if v77 then
			if not v6:IsInRaid() then
				if v24.Cleanse:IsReady() then
					if v24.ImprovedCleanse:IsAvailable() then
						v176 = v18.AfflictedLogic(v24.Cleanse);
						if v176 then
							return v176;
						end
					end
					v176 = v18.DispelCycle(v24.Cleanse, "Magic", nil, v36);
					if v176 then
						return v176;
					end
					if v24.ImprovedCleanse:IsAvailable() then
						v176 = v18.DispelCycle(v24.Cleanse, "Poison", nil, v36);
						if v176 then
							return v176;
						end
						v176 = v18.DispelCycle(v24.Cleanse, "Disease", nil, v36);
						if v176 then
							return v176;
						end
					end
				end
			end
			if (v6:IsInRaid() and v24.Cleanse:IsReady()) then
				v176 = v18.DispelCycle(v24.Cleanse, "Raid", nil, v36);
				if v176 then
					return v176;
				end
				if v24.ImprovedCleanse:IsAvailable() then
					v176 = v18.DispelCycle(v24.Cleanse, "Raid", nil, v36);
					if v176 then
						return v176;
					end
				end
			end
		end
		if (v6:IsInRaid() and v24.BlessingofFreedom:IsReady()) then
			if (v6:DebuffUp(v11(516552 - 92057), true) or v6:DebuffUp(v11(281267 + 143230), true)) then
				v6:Cast(v24.BlessingofFreedom);
				return;
			end
		end
		if (v24.Repentance:IsReady() and not v6:IsInRaid() and v6:AffectingCombat()) then
			v176 = v18.IncorpCycle(v24.Repentance, 11 + 19, false, false);
			if v176 then
				return v176;
			end
		end
		if (v24.TurnEvil:IsReady() and not v6:IsInRaid() and (not v24.Repentance:IsAvailable() or v24.Repentance:CooldownDown())) then
			v176 = v18.IncorpCycle(v24.TurnEvil, 377 - (10 + 327), false, false);
			if v176 then
				return v176;
			end
		end
		if (v38.Holy.AutoTabMelee and (v33 > (0 + 0)) and not v99 and v6:CanAttack(v7)) then
			v13.TopPanelAlternative:ChangeIcon(339 - (118 + 220), 1 + 2);
			return "Auto tab to melee";
		end
		v176 = v115();
		if v176 then
			return v176;
		end
		v176 = v6:AffectingCombat() and v61(v38.Cooldowns.Trinket1HP, v38.Cooldowns.Trinket1Use, v38.Cooldowns.Trinket2HP, v38.Cooldowns.Trinket2Use, v36);
		if v176 then
			return v176;
		end
		v176 = v117();
		if v176 then
			return v176;
		end
		if v176 then
			return v176;
		end
	end
end
local function v119()
	v13.ResetToggle();
	v38.Holy.Display();
	v13:UpdateMacro("macro1", "/use 16");
	v13:UpdateMacro("macro2", "/hr dpsonly");
	v13:UpdateMacro("macro6", "/stopcasting");
	v13.ToggleIconFrame:AddButtonCustom("O", 450 - (108 + 341), "OOC", "ooc");
	v13.ToggleIconFrame:AddButtonCustom("D", 1 + 1, "Dispel", "dispel");
	v13.ToggleIconFrame:AddButtonCustom("K", 12 - 9, "Kick", "kick");
	v13.ToggleIconFrame:AddButtonCustom("L", 1497 - (711 + 782), "Light of Dawn", "lightofdawn");
	v13.ToggleIconFrame:AddButtonCustom("DP", 9 - 4, "DPS Only", "dpsonly");
	v13.ToggleIconFrame:AddButtonCustom("S", 475 - (270 + 199), "Shield of the Righteous", "shieldoftherighteous");
	v13.Print("Holy Paladin rotation has been updated for Pre-Patch");
end
v13.SetAPL(22 + 43, v118, v119, v116);
