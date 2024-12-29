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
local function v26(v118)
	return v118:NPCID() == (639562 - 435002);
end
local function v27(v119)
	return v119:NPCID() == (586025 - 381252);
end
local function v28(v120)
	return (v120:NPCID() == (394654 - 190205)) or (v120:NPCID() == (536968 - 328509)) or (v120:NPCID() == (209080 - (555 + 64))) or (v120:NPCID() == (208731 - (857 + 74))) or (v120:NPCID() == (195214 - (367 + 201))) or (v120:NPCID() == (213517 - (214 + 713)));
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
	for v174 = 1139 - (116 + 1022), 16 - 12 do
		local v175, v176, v177, v178 = v22(v174);
		if (v176 == v24.Consecration:Name()) then
			return (v21(((v177 + v178) - v23()) + 0.5 + 0)) or (0 - 0);
		end
	end
	return 0 - 0;
end
local function v40(v121)
	local v122 = v121:Name();
	for v179 = 860 - (814 + 45), 9 - 5 do
		local v180, v181, v182, v183 = v22(v179);
		if (v181 and v122 and strfind(v122, v181, 1 + 0, true)) then
			local v203 = math.floor(((v182 + v183) - v23()) + 0.5 + 0);
			if (v203 > (885 - (261 + 624))) then
				return v203;
			end
		end
	end
	return 0 - 0;
end
local v41 = v18.converArrayToList({(262164 - (630 + 793)),(2029042 - 1600500),(1553584 - 1102360)});
local function v42(v123, v124, v125)
	return (v124 < v125) or v18.unitHasDebuffFromList(v41, v123);
end
local v43 = v18.converArrayToList({(440386 - (1789 + 124)),(150960 + 287919),(1760609 - 1311762),(202033 + 55293),(1200458 - 927747),(993206 - 553841),(1201492 - 762615),(451923 - (376 + 325)),(1342318 - 906072),(970123 - 529655),(325285 - (85 + 291)),(1219993 - 899379),(273842 - (1123 + 57)),(270844 - (163 + 91)),(75226 + 194040),(690324 - 240880),(602600 - 164105)});
local v44 = v18.converArrayToList({(441942 - (1329 + 145)),(448567 - (1409 + 441)),(204330 + 236886),(439254 - (345 + 1376)),(1940991 - 1501650),(452308 - (696 + 510)),(433379 - (1091 + 171)),(1367172 - 932920),(427200 - (123 + 251)),(449586 - (208 + 490)),(193365 + 240728),(54876 + 401875),(452614 - (534 + 141)),(399699 + 52172),(949824 - 497859),(1290578 - 830486),(208459 + 118938),(745717 - 425121),(1098267 - 643828),(429402 - (550 + 317)),(598737 - 172763),(429164 - (134 + 151)),(887352 - 422340),(1473513 - 1048634),(1656483 - 1216906),(586519 - 143025),(424104 - (162 + 618)),(284619 + 142710),(543274 - 220125),(323305 - (1373 + 263)),(101837 + 220777),(540871 - 219050),(121466 + 201290),(335482 - (218 + 123)),(331351 + 2134),(334193 - (306 + 254)),(631455 - 309701),(304450 + 158732),(458267 - (268 + 335)),(450667 - (426 + 146)),(451533 - (282 + 1174)),(1294665 - 845221),(444531 - (706 + 318)),(452493 - (945 + 326)),(379716 + 47018),(399276 + 35379),(440878 - (461 + 625)),(22161 + 404610),(163549 + 265878)});
local v45;
local function v46(v126)
	if v6:IsInRaid() then
		return false;
	end
	for v184, v185 in ipairs(v126) do
		if (v43[v185:CastSpellID()] or v43[v185:ChannelSpellID()]) then
			return true;
		end
	end
	return false;
end
local function v47(v127)
	if v6:IsInRaid() then
		return false;
	end
	for v186, v187 in ipairs(v127) do
		if (v44[v187:CastSpellID()] or v44[v187:ChannelSpellID()]) then
			return true;
		end
	end
	return false;
end
local v48 = v18.converArrayToList({(56605 + 136925),(20103 - (406 + 123)),(85736 + 275216),(67900 + 122419),(30000 - 17528),(13942 - (106 + 1794)),(92353 + 272997),(37234 - 23484),(114634 - (57 + 527)),(114154 - (17 + 86)),(457574 - 252394),(265353 - (122 + 44)),(880035 - 614762),(4612 + 27272),(231960 - (30 + 35)),(108831 - (1043 + 214)),(2931 - (323 + 889)),(48148 - (361 + 219)),(11077 + 37951),(153261 - (18 + 964)),(115889 + 84277),(195073 - (20 + 830)),(383536 - (116 + 10)),(103298 - (542 + 196)),(114008 + 276406),(38499 + 68452),(262898 - 160355),(375492 - (118 + 287))});
local v49 = v18.converArrayToList({(227084 - (118 + 1003)),(200559 - (142 + 235)),(42725 + 153629),(426380 - 200896),(194802 + 1574),(110839 + 149902),(924953 - 498293),(923616 - 511111),(1236261 - 980447),(89712 + 165722),(191936 + 72214),(968011 - 556311),(412689 - (476 + 255)),(153039 + 111517),(382284 - 180551),(38157 + 229750),(260887 - (144 + 192)),(193373 + 64034),(181263 + 245396),(378214 - (1183 + 397)),(282356 + 102825)});
local v50 = {[1 + 0]=true,[1978 - (1913 + 62)]=true,[3 + 1]=true,[15 - 9]=true,[1941 - (565 + 1368)]=true,[33 - 24]=true,[1671 - (1477 + 184)]=true};
local v51 = {[1 - 0]=true,[2 + 0]=true,[860 - (564 + 292)]=true,[8 - 3]=true,[17 - 11]=true,[311 - (244 + 60)]=true,[7 + 1]=true,[487 - (41 + 435)]=true,[1013 - (938 + 63)]=true};
local function v52(v128, v129)
	return v129[v128] or false;
end
local function v53(v130)
	local v131 = nil;
	local v132 = v38.Blessings;
	if v132.ManualBlessings then
		v131 = (v6:IsInRaid() and v5(v132.BlessingofAutumnRaid)) or v5(v132.BlessingofAutumnParty);
		if (v131 and not v131:IsDeadOrGhost()) then
			return v131;
		end
	end
	for v188, v189 in pairs(v130) do
		if ((v189:Role() == "DAMAGER") and v52(v189:ClassID(), v50)) then
			if v18.unitHasBuffFromList(v48, v189) then
				return v189;
			end
			v131 = v189;
			break;
		end
	end
	return v131 or v6;
end
local function v54(v133)
	local v134 = nil;
	local v135 = v38.Blessings;
	if v135.SummerOnSelf then
		return v6;
	end
	if v135.ManualBlessings then
		v134 = (v6:IsInRaid() and v5(v135.BlessingOfSummerRaid)) or v5(v135.BlessingOfSummerParty);
		if (v134 and not v134:IsDeadOrGhost()) then
			return v134;
		end
	end
	for v190, v191 in pairs(v133) do
		if ((v191:Role() == "DAMAGER") and v52(v191:ClassID(), v51)) then
			if v18.unitHasBuffFromList(v48, v191) then
				return v191;
			end
			if not v134 then
				v134 = v191;
				break;
			end
		end
	end
	return v134 or v6;
end
local function v55(v136)
	local v137 = nil;
	local v138 = v38.Cooldowns;
	if v138.ManualSacredWeapon then
		v137 = (v6:IsInRaid() and v5(v138.SacredWeaponRaidUnit)) or v5(v138.SacredWeaponPartyUnit);
		if (v137 and not v137:IsDeadOrGhost()) then
			return v137;
		end
	end
	for v192, v193 in pairs(v136) do
		if (v193:Role() == "DAMAGER") then
			if v18.unitHasBuffFromList(v48, v193) then
				return v193;
			end
			if not v137 then
				v137 = v193;
				break;
			end
		end
	end
	return v137 or v6;
end
local function v56()
	local v139 = nil;
	local v140 = v38.Blessings;
	if v140.ManualBlessings then
		if v6:IsInRaid() then
			v139 = v5(v140.BlessingOFSpringRaid);
		else
			v139 = v5(v140.BlessingOFSpringParty);
		end
		if (v139 and not v139:IsDeadOrGhost() and v139:IsSpellInRange(v24.HolyShock)) then
			return v139;
		end
	end
	return v139 or v6;
end
local function v57()
	local v141 = nil;
	local v142 = v38.Blessings;
	if v142.ManualBlessings then
		v141 = (v6:IsInRaid() and v5(v142.BlessingOfWinterRaid)) or v5(v142.BlessingOfWinterParty);
		if (v141 and not v141:IsDeadOrGhost() and (v141:Role() == "HEALER") and v141:IsSpellInRange(v24.HolyShock)) then
			return v141;
		end
	end
	return v141 or v6;
end
local function v58(v143)
	for v194, v195 in pairs(v143) do
		if ((v195:Role() ~= "TANK") and v195:DebuffDown(v24.ForbearanceDebuff)) then
			local v204 = v195:HealthPercentageWeighted();
			if ((not v6:IsInRaid() and v38.SpecialHealing.UseBoP and (v18.unitHasDebuffFromList(v18.DebuffList['Bleed'], v195) or v18.unitHasDebuffFromList(v49, v195))) or (v204 <= v38.SpecialHealing.BoPHP)) then
				return v195;
			end
		end
	end
	return nil;
end
local function v59(v144)
	if (v38.SpecialHealing.BoSHP == (0 + 0)) then
		return nil;
	end
	local v145 = nil;
	local v146 = 1225 - (936 + 189);
	local v147 = false;
	local v148 = false;
	for v196, v197 in pairs(v144) do
		if (v6 ~= v197) then
			local v205 = v197:HealthPercentage();
			local v206 = v38.SpecialHealing.BoSHP;
			if v18.unitHasBuffFromList(v31, v197) then
				v206 = 5 + 10;
				break;
			end
			if (not v147 and not v6:IsInRaid()) then
				v148 = v47(v45) or v46(v45);
				v147 = true;
			end
			if ((v205 <= v206) or v148) then
				if (v205 < v146) then
					v146 = v205;
					v145 = v197;
					if (v205 <= (1628 - (1565 + 48))) then
						return v145;
					end
				end
			end
		end
	end
	return v145;
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
local function v61(v149, v150, v151, v152, v153)
	local v154, v155, v156 = v6:GetUseableItems(v30, 9 + 4);
	if (v154 and v18.AoELogic(v149, v150, v153)) then
		if v16(v154) then
			return "trinket1 trinkets 2";
		end
	end
	local v157, v155, v158 = v6:GetUseableItems(v30, 1152 - (782 + 356));
	if (v157 and v18.AoELogic(v151, v152, v153)) then
		if v16(v157) then
			return "trinket2 trinkets 4";
		end
	end
end
local function v62(v159, v160)
	local v161 = nil;
	local v162 = math.huge;
	for v198, v199 in pairs(v159) do
		if v199:BuffUp(v160, nil, true) then
			local v207 = v199:HealthPercentageWeighted();
			if (v207 < v162) then
				v162 = v207;
				v161 = v199;
			end
		end
	end
	if v161 then
		return v161;
	else
		return nil;
	end
end
local function v63(v163)
	local v164 = v6;
	local v165 = v164:HealthPercentageWeighted() + v164:IncomingHeals();
	local v166 = nil;
	local v167 = math.huge;
	for v200, v201 in pairs(v163) do
		local v202 = v201:HealthPercentageWeighted() + v201:IncomingHeals();
		if (v201:Role() == "TANK") then
			if (not (v201:ClassID() == (273 - (176 + 91))) and (v201:HealthPercentage() >= (169 - 104))) then
				v202 = v202 * (1.9 - 0);
			elseif (v201:PowerPercentage() > (1112 - (975 + 117))) then
				v202 = v202 * (1876.2 - (157 + 1718));
			end
		end
		if (v202 < v165) then
			v165 = v202;
			v164 = v201;
		end
		if (v201:Role() == "TANK") then
			if ((v166 == nil) or (v202 < v167)) then
				v167 = v202;
				v166 = v201;
			end
		end
	end
	return v164, v166;
end
local function v64(v168)
	local v169 = UnitGUID("targettarget");
	if (v168 ~= nil) then
		for v208, v209 in pairs(v168) do
			if ((v209:GUID() == v169) and ((v7:CastSpellID() == (260337 + 60451)) or (v7:CastSpellID() == (1149216 - 825486)))) then
				if (v209 ~= nil) then
					return v209;
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
local v108, v109, v110, v111, v112;
local function v113()
	if (v24.DivineProtection:IsCastable() and (v38.Holy.DivineProtectionHP > (0 - 0)) and ((v6:HealthPercentageWeighted() <= v38.Holy.DivineProtectionHP) or (not v6:IsInRaid() and (v47(v45) or v46(v45)))) and v6:BuffDown(v24.DivineShield)) then
		v13.Cast(v24.DivineProtection);
		return "Divine Protection HP:" .. v6:HealthPercentageWeighted();
	end
	if (v24.DivineShield:IsCastable() and (v38.Holy.BubbleHP > (1018 - (697 + 321))) and (v6:HealthPercentage() <= v38.Holy.BubbleHP) and v6:BuffDown(v24.ForbearanceDebuff) and (v6:BuffDown(v24.DivineProtection) or (v6:HealthPercentage() < (27 - 17)))) then
		v13.Cast(v24.DivineShield);
		return "Divine Shield HP:" .. v6:HealthPercentage();
	end
end
local function v114()
	v38.AoE = (not v6:IsInRaid() and v37.APL.Paladin.HolyAoE) or v37.APL.Paladin.HolyRaidAoE;
	v38.AoE2 = (not v6:IsInRaid() and v37.APL.Paladin.HolyAoE2) or v37.APL.Paladin.HolyRaidAoE2;
	v38.Healing = (not v6:IsInRaid() and v37.APL.Paladin.HolyHealing) or v37.APL.Paladin.HolyRaidHealing;
	v38.SpecialHealing = (not v6:IsInRaid() and v37.APL.Paladin.HolySpecialHealing) or v37.APL.Paladin.HolyRaidSpecialHealing;
	v89 = v13.ToggleIconFrame:GetToggle(1 - 0);
	v90 = v13.ToggleIconFrame:GetToggle(6 - 3);
	v107 = v13.ToggleIconFrame:GetToggle(2 + 3);
	v110 = v13.ToggleIconFrame:GetToggle(11 - 5);
	v36 = v18.UnitsinRange(v24.HolyShock);
	v33 = #(v6:GetEnemiesInMeleeRange(13 - 8));
	v77 = v13.ToggleIconFrame:GetToggle(1229 - (322 + 905));
	v32 = v6:GetEnemiesInMeleeRange(619 - (602 + 9));
	v99 = v7:IsInMeleeRange(1194 - (449 + 740));
	v45 = v6:GetEnemiesInMeleeRange(912 - (826 + 46));
	v112 = v64(v36);
	if v14() then
		v34 = ((#v32 > (947 - (245 + 702))) and #v32) or (3 - 2);
	else
		v34 = 1 + 0;
	end
	v68, v69 = v18.GetLowestHealthUnit(v36);
	if v69 then
		v71 = v69:HealthPercentage();
		v98 = math.min(v71 + v69:IncomingHeals(), 1998 - (260 + 1638));
	else
		v71 = 540 - (382 + 58);
		v98 = 320 - 220;
	end
	if v68 then
		v70 = v68:HealthPercentageWeighted();
		v96 = v68:HealthPercentage();
		v111 = math.min(v70 + v68:IncomingHeals(), 84 + 16);
		v97 = math.min(v96 + v68:IncomingHeals(), 206 - 106);
	else
		v70 = 297 - 197;
		v96 = 1305 - (902 + 303);
		v111 = 219 - 119;
		v97 = 240 - 140;
	end
	v72 = v62(v36, v24.TyrsDeliveranceBuff);
	v74 = (v6:BuffUp(v24.SealofClarity) and (1 + 1)) or (1693 - (1121 + 569));
	v75 = v6:BuffUp(v24.DivinePurposeBuff) or (v6:HolyPower() >= v74) or v6:BuffUp(v24.ShiningRighteousness);
	v76 = v6:BuffUp(v24.DivinePurposeBuff) and (v6:BuffRemains(v24.DivinePurposeBuff) < (216 - (22 + 192)));
	v108 = (v24.EternalFlame:IsAvailable() and v24.EternalFlame) or v24.WoG;
	v79 = v18.BuffCount(v36, v24.BoV);
	v80 = v13.ToggleIconFrame:GetToggle(687 - (483 + 200));
	v106 = (v24.BarrierofFaith:IsAvailable() and ((v6:BuffUp(v24.BlessingofDawn) and (v6:BuffStack(v24.BlessingofDawn) >= (1465 - (1404 + 59)))) or v6:BuffDown(v24.Infusion) or not v24.HolyShock:IsReady())) or not v24.BarrierofFaith:IsAvailable();
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
local function v115()
	if (v24.DevotionAura:IsReady() and not v6:IsMounted() and v6:BuffDown(v24.DevotionAuraBuff, true)) then
		v16(v24.DevotionAura);
		return "Devo Aura Cast";
	end
	if ((v70 >= (123 - 78)) and v27(v7) and (v24.Cleanse:CooldownDown() or not v24.ImprovedCleanse:IsAvailable()) and v7:IsInRange(53 - 13)) then
		if v24.HolyShock:IsReady() then
			v16(v24.HolyShock);
			return;
		end
		if (v75 and v108:IsReady()) then
			v16(v108);
			return;
		end
	end
	if ((v70 >= (800 - (468 + 297))) and v29() and (v7:HealthPercentage() > (562 - (334 + 228))) and (v7:HealthPercentage() < (337 - 237))) then
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
		if (v70 <= (69 - 39)) then
			v13.CastMacro(2 - 0, true);
		end
	end
	if not v107 then
		if (v24.LoH:IsReady() and v6:AffectingCombat()) then
			if (v65 == nil) then
				v65 = v68;
			end
			if ((v65:HealthPercentage() > v38.SpecialHealing.LoHHP) and (v65:HealthPercentage() > (0 + 0))) then
				v65 = nil;
				v66 = nil;
				v67 = nil;
			end
			if (v65 ~= nil) then
				if (v65:DebuffDown(v24.ForbearanceDebuff) and (v65:HealthPercentage() <= v38.SpecialHealing.LoHHP) and (v65:HealthPercentage() > (236 - (141 + 95)))) then
					if (v66 == nil) then
						v66 = v23();
						v67 = math.random(148 + 2, 2059 - 1259) / (2403 - 1403);
					elseif (v23() >= (v66 + v67)) then
						if (v65:HealthPercentage() <= v38.SpecialHealing.LoHHP) then
							v65:Cast(v24.LoH);
						end
						v66 = nil;
						return "LoH";
					end
				end
			end
		end
		if ((v6:HealthPercentage() >= (8 + 22)) and v6:AffectingCombat()) then
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
		if v6:AffectingCombat() then
			if (v24.AvengingWrath:IsReady() and v18.AoELogicWithCountUnweighted(v38.AoE.AWHP, v38.AoE.AWCount, v38.Cooldowns.AWUsage, v36)) then
				v13.Cast(v24.AvengingWrath, false);
				return "Avenging Wrath Casted Per Settings";
			end
			if (v24.AvengingCrusader:IsReady() and v18.AoELogicWithCountUnweighted(v38.AoE.ACHP, v38.AoE.ACCount, v38.Cooldowns.ACUsage, v36)) then
				v16(v24.AvengingCrusader, false);
				return "Avenging Crusader Casted Per Settings";
			end
			if (v24.AuraMastery:IsReady() and v18.AoELogicWithCountUnweighted(v38.AoE.AMHP, v38.AoE.AMCount, v38.Cooldowns.AMUsage, v36)) then
				v16(v24.AuraMastery, false);
				return "Aura Mastery Casted Per Settings";
			end
		end
		if ((v24.BoV:CooldownRemains() >= (21.5 - 13)) or (v79 > (1 + 0)) or not v24.BoV:IsAvailable()) then
			if (v24.HolyPrism:IsReady() and (v70 > (24 + 21)) and v7:IsInRange(56 - 16) and v6:AffectingCombat() and v7:AffectingCombat() and v18.TargetIsValid() and v18.AoELogicWithCount(v38.AoE2.HPHP, v38.AoE2.HPCount, v38.Cooldowns.HPUsage, v36)) then
				v16(v24.HolyPrism);
				return "Holy Prism on Target per Settings";
			end
			if (v24.HolyPrism:IsReady() and (v70 <= (27 + 18)) and v18.AoELogicWithCount(v38.AoE2.HPHP, v38.AoE2.HPCount, v38.Cooldowns.HPUsage, v36)) then
				v68:Cast(v24.HolyPrism);
				return "Holy Prism on Lowet Unit per Settings";
			end
		end
		if (v24.BoV:IsReady() and v6:AffectingCombat() and (v18.AoELogicWithCountUnweighted(v38.AoE.BoVHP, v38.AoE.BoVCount, v38.Cooldowns.BoVUsage, v36) or ((v38.Cooldowns.BoVUsage == "With Logic") and (v47(v45) or v46(v45))))) then
			v68:Cast(v24.BoV);
			return "BoV Casted Per Settings";
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
				if (v24.BoL:IsReady() and not v92 and v69:BuffDown(v24.BoL) and v69:BuffDown(v24.BoF) and (v18.BuffCount(v36, v24.BoL) < (164 - (92 + 71)))) then
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
				if ((v38.Healing.HBTank and (v70 <= (42 - 17)) and (v70 <= v38.Healing.HBHP)) or (not v38.Healing.HBTank and (v70 <= v38.Healing.HBHP))) then
					v68:Cast(v24.HolyBulwark);
					return "Holy Bulwark";
				end
			end
		end
		if (v24.HandofDivintiy:IsReady() and not v6:IsMoving() and v38.TyrSettings.BeforeTyrs and v18.AoELogicWithCount(v38.AoE.TyrsHP, v38.AoE.TyrsCount, "With Logic", v36) and ((not v6:IsInRaid() and v6:IsInParty() and (v70 >= (825 - (574 + 191)))) or v6:IsInRaid())) then
			v16(v24.HandofDivintiy);
			return "Hand of Divinity before Tyrs";
		end
		if (v24.TyrsDeliverance:IsReady() and (v18.AoELogicWithCount(v38.AoE.TyrsHP, v38.AoE.TyrsCount, "With Logic", v36) or (v6:BuffUp(v24.HandofDivintiy) and (v38.AoE.TyrsHP > (0 + 0)))) and not v6:IsMoving()) then
			v16(v24.TyrsDeliverance);
			return "Tyr's based on Settings and/or Hand of Divinity Buff";
		end
		if (v24.HandofDivintiy:IsReady() and not v6:IsMoving() and (v70 <= v38.SpecialHealing.HandofDivinityHP) and (v70 >= (112 - 67)) and not v6:IsMoving()) then
			v16(v24.HandofDivintiy);
			return "Hand of Divinity Normal";
		end
		if ((v24.BoV:CooldownRemains() >= (5.5 + 3)) or (v79 > (850 - (254 + 595))) or not v24.BoV:IsAvailable()) then
			if (v68 ~= nil) then
				if (v24.DivineToll:IsReady() and v18.AoELogicWithCountUnweighted(v38.AoE.DivineTollHP, v38.AoE.DivineTollCount, v38.Cooldowns.DTUsage, v36)) then
					v68:Cast(v24.DivineToll);
					return "Divine Toll via Settings or in Party";
				end
			end
		end
		if (v6:BuffUp(v24.DivineFavorBuff) and v24.FoL:IsReady() and not v6:PrevGCD(127 - (55 + 71), v24.FoL) and not v6:IsCasting() and (((v111 <= v38.SpecialHealing.FoLBoth) and v6:BuffUp(v24.Infusion)) or (v111 <= v38.SpecialHealing.FoLDFHP)) and not v6:IsMoving()) then
			v68:Cast(v24.FoL);
			return "FoL for Divine Favor";
		end
		if (v6:BuffUp(v24.DivineFavorBuff) and v24.HolyLight:IsReady() and not v6:PrevGCD(1 - 0, v24.HolyLight) and not v6:IsCasting() and (((v111 <= v38.SpecialHealing.HLBoth) and v6:BuffUp(v24.Infusion)) or (v111 <= v38.SpecialHealing.HLDFHP)) and not v6:IsMoving()) then
			v68:Cast(v24.HolyLight);
			return "Holy Light for Divine Favor";
		end
		if (v69 ~= nil) then
			if (not v24.HolyShock:IsReady() and (not v6:IsInRaid() or (v6:IsInRaid() and (v6:HolyPower() > (1794 - (573 + 1217)))))) then
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
		if ((v111 >= (180 - 115)) and v6:AffectingCombat() and v24.BlessingofSummer:IsAvailable()) then
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
				if (v24.HolyLight:IsReady() and v6:BuffUp(v24.HandofDivintiy) and ((v72:HealthPercentage() <= v38.TyrSettings.TyrHLHP) or (v6:BuffRemains(v24.HandofDivintiy) <= (1 + 5)))) then
					v72:Cast(v24.HolyLight);
					return "Holy Light on Tyr's Target";
				end
				if (v24.HolyShock:IsReady() and (((v6:HolyPower() < (8 - 3)) and v6:BuffDown(v24.RisingSunlight)) or ((v6:HolyPower() < (942 - (714 + 225))) and v6:BuffUp(v24.RisingSunlight)))) then
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
			if (v24.HolyLight:IsReady() and v6:BuffUp(v24.HandofDivintiy) and ((v70 <= v38.SpecialHealing.HandofDivinityHP) or (v6:BuffRemains(v24.HandofDivintiy) <= (17 - 11)))) then
				v68:Cast(v24.HolyLight);
				return "Holy Light with HoD";
			end
		end
		if v6:BuffUp(v24.AvengingCrusader) then
			if (v79 >= (1 - 0)) then
				if (v108:IsReady() and v75 and ((v70 <= v38.Healing.WoGHP) or v76)) then
					v68:Cast(v108);
					return "WoG on BoV Unit During AC";
				end
			end
			if (v24.Judgment:IsReady() and v7:IsInRange(4 + 26) and (v70 <= (130 - 40)) and v18.TargetIsValid()) then
				v16(v24.Judgment);
				return "Judgement During AC";
			end
			if (v80 and v24.LoD:IsReady() and v75 and v6:BuffDown(v24.EmpyreanLegacy) and (v18.AoELogicWithCount(v38.AoE.LoDHP, v38.AoE.LoDCount, "With Logic", v36) or v76)) then
				v16(v24.LoD);
				return "LoD During Ac";
			end
			if (v24.CrusaderStrike:IsReady() and v99 and (v70 <= (896 - (118 + 688))) and v18.TargetIsValid()) then
				v16(v24.CrusaderStrike);
				return "Crusader Strike During AC";
			end
			if (v24.HolyShock:IsReady() and (v70 <= v38.Healing.HolyShockHP)) then
				v68:Cast(v24.HolyShock);
				return "Holy Shock During AC";
			end
			if (v24.HammerofWrath:IsReady() and v7:IsInRange(78 - (25 + 23)) and v18.TargetIsValid()) then
				v16(v24.HammerofWrath);
				return "Hammer of Wrath During AC";
			end
		end
		if v24.VenerationTalent:IsAvailable() then
			if (((v24.EternalFlame:IsAvailable() and not v75) or not v24.EternalFlame:IsAvailable()) and v24.HammerofWrath:IsReady() and v7:IsInRange(6 + 24) and v18.TargetIsValid()) then
				v13.Cast(v24.HammerofWrath);
				return "Hammer of Wrath Veneration";
			end
		end
		if (v18.TargetIsValid() and v7:AffectingCombat() and v24.Judgment:IsReady() and v7:IsInRange(1916 - (927 + 959)) and ((v70 <= (303 - 213)) or (v6:BuffUp(v24.AwakeningMaxBuff) and v18.AoELogicWithCount(807 - (16 + 716), 5 - 2, "With Logic", v36)) or (v6:BuffUp(v24.AwakeningMaxBuff) and (v6:BuffRemains(v24.AwakeningMaxBuff) < (100 - (11 + 86)))))) then
			v13.Cast(v24.Judgment);
			return "Judgement with Awakening Max Buff Priority";
		end
		if (v79 >= (2 - 1)) then
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
		if (v79 < (286 - (175 + 110))) then
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
			v86 = v84 and (v24.HolyShock:Charges() == (4 - 2)) and v6:BuffDown(v24.RisingSunlight);
			v87 = (v70 <= v38.Healing.HolyShockRHP) and v6:BuffUp(v24.RisingSunlight);
			v88 = ((v6:HolyPower() < (24 - 19)) and v6:BuffDown(v24.RisingSunlight)) or ((v6:HolyPower() < (1800 - (503 + 1293))) and v6:BuffUp(v24.RisingSunlight)) or v38.Holy.Overcap;
			if ((v85 or v86 or v87) and v88) then
				v68:Cast(v24.HolyShock);
				return "Holy Shock Cast";
			end
		end
		if (v18.TargetIsValid() and v7:AffectingCombat()) then
			if (v24.HammerofWrath:IsReady() and v7:IsInRange(83 - 53)) then
				v13.Cast(v24.HammerofWrath);
				return "Hammer of Wrath";
			end
			if (v24.Judgment:IsReady() and v7:IsInRange(22 + 8) and ((v70 <= (1151 - (810 + 251))) or v6:BuffUp(v24.AwakeningMaxBuff))) then
				v13.Cast(v24.Judgment);
				return "Judgement";
			end
			if (v24.CrusaderStrike:IsReady() and ((v6:HolyPower() < (4 + 1)) or v38.Holy.Overcap) and v99) then
				v13.Cast(v24.CrusaderStrike);
				return "Crusader Strike";
			end
		end
		if (v24.FoL:IsReady() and not v6:IsMoving() and ((v70 <= v38.Healing.FoLHP) or (v6:BuffUp(v24.Infusion) and (v111 <= v38.Healing.FoLIHP)))) then
			v68:Cast(v24.FoL);
			return "FoL For Infusion or Normal";
		end
		if (v24.HolyLight:IsReady() and (not v6:IsMoving() or v6:BuffUp(v24.HandofDivintiy)) and ((v111 <= v38.Healing.HLHP) or (v6:BuffUp(v24.Infusion) and (v111 <= v38.Healing.HLIHP)))) then
			v68:Cast(v24.HolyLight);
			return "Holy Light For Infusion or Normal";
		end
	end
	if (v18.TargetIsValid() and ((v70 >= (14 + 31)) or v107) and not v26(v7) and (v7:AffectingCombat() or (v38.Holy.AttackOOC and v89))) then
		if (v24.Consecration:IsReady() and v7:IsInRange(8 + 0) and not v6:IsMoving() and (v40(v24.Consecration) <= (533 - (43 + 490)))) then
			v16(v24.Consecration);
			return "consecration priority 20";
		end
		if (v24.ShieldoftheRighteous:IsUsable() and v99 and (v6:HolyPower() >= (736 - (711 + 22))) and ((v6:BuffUp(v24.AvengingWrathBuff) and (v111 >= (212 - 157))) or v110 or v107)) then
			v13.Cast(v24.ShieldoftheRighteous);
			return "shield_of_the_righteous priority 2";
		end
		if (v24.HammerofWrath:IsReady() and v7:IsInRange(889 - (240 + 619)) and ((v6:HolyPower() < (2 + 3)) or v38.Holy.Overcap or v107)) then
			v16(v24.HammerofWrath);
			return "hammer_of_wrath priority 4";
		end
		if (v24.DivineToll:IsReady() and v107 and v38.Holy.UseDTDPS and v7:IsInRange(63 - 23)) then
			v16(v24.DivineToll);
			return "Divine Toll for DPS Only";
		end
		if (v24.HammerofWrath:IsReady() and v7:IsInRange(2 + 28) and ((v6:HolyPower() < (1749 - (1344 + 400))) or v38.Holy.Overcap or v107)) then
			v16(v24.HammerofWrath);
			return "hammer_of_wrath priority 14";
		end
		if (v24.Judgment:IsReady() and v7:IsInRange(435 - (255 + 150)) and ((v6:HolyPower() < (4 + 1)) or v38.Holy.Overcap or v107)) then
			v16(v24.Judgment);
			return "judgment priority 16";
		end
		if (v24.HolyShock:IsReady() and v7:IsInRange(22 + 18) and ((v38.Holy.UseHolyShockDPS and ((v6:HolyPower() < (21 - 16)) or v38.Holy.Overcap)) or v107)) then
			v16(v24.HolyShock);
			return "holy_shock priority 22";
		end
		if (v24.CrusaderStrike:IsReady() and v99 and ((v6:HolyPower() < (16 - 11)) or v38.Holy.Overcap or v107)) then
			v16(v24.CrusaderStrike);
			return "crusader_strike priority 24";
		end
		if (v24.HolyPrism:IsReady() and ((v34 >= (1741 - (404 + 1335))) or v107)) then
			v6:Cast(v24.HolyPrism);
			return "holy_prism on self priority 26";
		end
	end
end
local function v116()
	if (not v6:IsInRaid() and v18.ShouldStopCastUpdate()) then
		v13.CastMacro(412 - (183 + 223), true);
		return "Stop Cast For Silence";
	end
	if not v6:AffectingCombat() then
		v35 = v60();
		if v35 then
			return v35;
		end
	end
	if (not v6:IsMounted() and (v18.TargetIsValid() or v6:AffectingCombat() or v89)) then
		if v90 then
			v35 = v18.InterruptCycle(v24.Rebuke, 6 - 1, true, nil, false, false);
			if v35 then
				return v35;
			end
			if (v24.Rebuke:CooldownDown() or not v24.Rebuke:IsAvailable()) then
				if (v24.BlindingLight:IsReady() and v38.Holy.UseBL) then
					v35 = v18.InterruptCycle(v24.BlindingLight, 7 + 3, false, nil, true, true);
					if v35 then
						return v35;
					end
				end
				if v24.HammerofJustice:IsReady() then
					v35 = v18.InterruptCycle(v24.HammerofJustice, 4 + 6, false, nil, true);
					if v35 then
						return v35;
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
			v35 = v18.DispelCycle(v24.BlessingofFreedom, "RootDispel", nil, v36);
			if v35 then
				return v35;
			end
			v35 = v18.DispelCycle(v24.BlessingofFreedom, "SnareRoot", nil, v36);
			if v35 then
				return v35;
			end
			v35 = v18.DispelCycle(v24.BlessingofFreedom, "FreedomDispel", nil, v36);
			if v35 then
				return v35;
			end
		end
		if v77 then
			if not v6:IsInRaid() then
				if v24.Cleanse:IsReady() then
					if v24.ImprovedCleanse:IsAvailable() then
						v35 = v18.AfflictedLogic(v24.Cleanse);
						if v35 then
							return v35;
						end
					end
					v35 = v18.DispelCycle(v24.Cleanse, "Magic", nil, v36);
					if v35 then
						return v35;
					end
					if v24.ImprovedCleanse:IsAvailable() then
						v35 = v18.DispelCycle(v24.Cleanse, "Poison", nil, v36);
						if v35 then
							return v35;
						end
						v35 = v18.DispelCycle(v24.Cleanse, "Disease", nil, v36);
						if v35 then
							return v35;
						end
					end
				end
			end
			if (v6:IsInRaid() and v24.Cleanse:IsReady()) then
				v35 = v18.DispelCycle(v24.Cleanse, "Raid", nil, v36);
				if v35 then
					return v35;
				end
			end
		end
		if (v6:IsInRaid() and v24.BlessingofFreedom:IsReady()) then
			if (v6:DebuffUp(v11(424832 - (10 + 327)), true) or v6:DebuffUp(v11(295616 + 128881), true)) then
				v6:Cast(v24.BlessingofFreedom);
				return;
			end
		end
		if (v24.Repentance:IsReady() and not v6:IsInRaid() and v6:AffectingCombat()) then
			v35 = v18.IncorpCycle(v24.Repentance, 368 - (118 + 220), false, false);
			if v35 then
				return v35;
			end
		end
		if (v24.TurnEvil:IsReady() and not v6:IsInRaid() and (not v24.Repentance:IsAvailable() or v24.Repentance:CooldownDown())) then
			v35 = v18.IncorpCycle(v24.TurnEvil, 14 + 26, false, false);
			if v35 then
				return v35;
			end
		end
		if (v38.Holy.AutoTabMelee and (v33 > (449 - (108 + 341))) and not v99 and v6:CanAttack(v7)) then
			v13.TopPanelAlternative:ChangeIcon(1 + 0, 12 - 9);
			return "Auto tab to melee";
		end
		v35 = v113();
		if v35 then
			return v35;
		end
		v35 = v6:AffectingCombat() and v61(v38.Cooldowns.Trinket1HP, v38.Cooldowns.Trinket1Use, v38.Cooldowns.Trinket2HP, v38.Cooldowns.Trinket2Use, v36);
		if v35 then
			return v35;
		end
		if (v18.TargetIsValid() or v6:AffectingCombat()) then
			v35 = v115();
		end
		if v35 then
			return v35;
		end
	end
end
local function v117()
	v13.ResetToggle();
	v38.Holy.Display();
	v13:UpdateMacro("macro1", "/use 16");
	v13:UpdateMacro("macro2", "/hr dpsonly");
	v13:UpdateMacro("macro6", "/stopcasting");
	v13.ToggleIconFrame:AddButtonCustom("O", 1494 - (711 + 782), "OOC", "ooc");
	v13.ToggleIconFrame:AddButtonCustom("D", 3 - 1, "Dispel", "dispel");
	v13.ToggleIconFrame:AddButtonCustom("K", 472 - (270 + 199), "Kick", "kick");
	v13.ToggleIconFrame:AddButtonCustom("L", 2 + 2, "Light of Dawn", "lightofdawn");
	v13.ToggleIconFrame:AddButtonCustom("DP", 1824 - (580 + 1239), "DPS Only", "dpsonly");
	v13.ToggleIconFrame:AddButtonCustom("S", 17 - 11, "Shield of the Righteous", "shieldoftherighteous");
	v13.Print("Holy Paladin rotation has been updated for Pre-Patch");
end
v13.SetAPL(63 + 2, v116, v117, v114);
