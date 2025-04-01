local obf_stringchar = string.char;
local obf_stringbyte = string.byte;
local obf_stringsub = string.sub;
local obf_bitlib = bit32 or bit;
local obf_XOR = obf_bitlib.bxor;
local obf_tableconcat = table.concat;
local obf_tableinsert = table.insert;
local function LUAOBFUSACTOR_DECRYPT_STR_0(LUAOBFUSACTOR_STR, LUAOBFUSACTOR_KEY)
	local result = {};
	for i = 1, #LUAOBFUSACTOR_STR do
		obf_tableinsert(result, obf_stringchar(obf_XOR(obf_stringbyte(obf_stringsub(LUAOBFUSACTOR_STR, i, i + 1)), obf_stringbyte(obf_stringsub(LUAOBFUSACTOR_KEY, 1 + (i % #LUAOBFUSACTOR_KEY), 1 + (i % #LUAOBFUSACTOR_KEY) + 1))) % 256));
	end
	return obf_tableconcat(result);
end
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
	return v120:NPCID() == (169452 + 35108);
end
local function v27(v121)
	return v121:NPCID() == (86997 + 117776);
end
local function v28(v122)
	return (v122:NPCID() == (205953 - (363 + 1141))) or (v122:NPCID() == (210039 - (1183 + 397))) or (v122:NPCID() == (634627 - 426166)) or (v122:NPCID() == (152327 + 55473)) or (v122:NPCID() == (145490 + 49156)) or (v122:NPCID() == (214565 - (1913 + 62)));
end
local function v29()
	return v28(v7) and not v6:CanAttack(v7);
end
local v30 = {v25.ScreamingBlackDragonScale:ID(),v25.BroodkeepersPromise:ID()};
local v31 = v18.converArrayToList({(183174 - 134467),(66482 - 17690),(199445 - (564 + 292)),(566142 - 378315),(78692 + 23650),(62337 - (938 + 63)),(365041 - (936 + 189)),(187878 - (1565 + 48)),(46576 - (782 + 356)),(304429 - 187580),(123875 - (975 + 117)),(99236 + 23042),(2194 - 1552),(1356 - 858),(15999 - 9059),(62216 - 29010),(48812 - (322 + 905)),(32413 - (449 + 740)),(109218 - (245 + 702)),(33682 + 71091),(108856 - (382 + 58)),(98085 + 19953),(1017359 - 675114),(799028 - 435112)});
local v32, v33;
local v34;
local v35, v36;
local v37 = v13.GUISettingsGet();
local v38 = {[LUAOBFUSACTOR_DECRYPT_STR_0("\246\198\213\32\244\186\203", "\126\177\163\187\69\134\219\167")]=v37.General,[LUAOBFUSACTOR_DECRYPT_STR_0("\0\194\39\200\243\45\222", "\156\67\173\74\165")]=v37.APL.Paladin.Commons,[LUAOBFUSACTOR_DECRYPT_STR_0("\28\184\69\15", "\38\84\215\41\118\220\70")]=v37.APL.Paladin.Holy,[LUAOBFUSACTOR_DECRYPT_STR_0("\113\25\7", "\158\48\118\66\114")]=((not v6:IsInRaid() and v37.APL.Paladin.HolyAoE) or v37.APL.Paladin.HolyRaidAoE),[LUAOBFUSACTOR_DECRYPT_STR_0("\138\43\53\100", "\155\203\68\112\86\19\197")]=((not v6:IsInRaid() and v37.APL.Paladin.HolyAoE2) or v37.APL.Paladin.HolyRaidAoE2),[LUAOBFUSACTOR_DECRYPT_STR_0("\110\216\55\240\73\118\226", "\152\38\189\86\156\32\24\133")]=((not v6:IsInRaid() and v37.APL.Paladin.HolyHealing) or v37.APL.Paladin.HolyRaidHealing),[LUAOBFUSACTOR_DECRYPT_STR_0("\207\71\162\69\245\86\171\110\249\86\171\79\242\80", "\38\156\55\199")]=((not v6:IsInRaid() and v37.APL.Paladin.HolySpecialHealing) or v37.APL.Paladin.HolyRaidSpecialHealing),[LUAOBFUSACTOR_DECRYPT_STR_0("\139\114\115\36\23\123\237\77\187", "\35\200\29\28\72\115\20\154")]=v37.APL.Paladin.HolyCooldowns,[LUAOBFUSACTOR_DECRYPT_STR_0("\45\166\195\236\136\56\32\16\177\214\204", "\84\121\223\177\191\237\76")]=v37.APL.Paladin.HolyTyrs,[LUAOBFUSACTOR_DECRYPT_STR_0("\159\87\208\147\63\68\36\200\181\81\218", "\161\219\54\169\192\90\48\80")]=v37.APL.Paladin.HolyDaybreak,[LUAOBFUSACTOR_DECRYPT_STR_0("\107\78\5\54\90\75\14\34\90", "\69\41\34\96")]=v37.APL.Paladin.HolyBlessings};
local function v39()
	for v177 = 2 - 1, 1 + 3 do
		local v178, v179, v180, v181 = v22(v177);
		if (v179 == v24.Consecration:Name()) then
			return (v21(((v180 + v181) - v23()) + (1690.5 - (1121 + 569)))) or (214 - (22 + 192));
		end
	end
	return 683 - (483 + 200);
end
local function v40(v123)
	local v124 = v123:Name();
	for v182 = 1464 - (1404 + 59), 10 - 6 do
		local v183, v184, v185, v186 = v22(v182);
		if (v184 and v124 and strfind(v124, v184, 1 - 0, true)) then
			local v207 = math.floor(((v185 + v186) - v23()) + (765.5 - (468 + 297)));
			if (v207 > (562 - (334 + 228))) then
				return v207;
			end
		end
	end
	return 0 - 0;
end
local v41 = v18.converArrayToList({(472890 - 212149),(428778 - (141 + 95))});
local function v42(v125, v126, v127)
	return (v126 < v127) or v18.unitHasDebuffFromList(v41, v125);
end
local v43 = v18.converArrayToList({(1128632 - 690159),(102802 + 336077),(315536 + 133311),(362377 - 105051),(272874 - (92 + 71)),(738703 - 299338),(362014 + 76863),(230479 + 220743),(436372 - (55 + 71)),(442258 - (573 + 1217)),(24722 + 300187),(321553 - (714 + 225)),(380134 - 107472),(391800 - 121210),(269314 - (25 + 23)),(451330 - (927 + 959)),(439227 - (16 + 716))});
local v44 = v18.converArrayToList({(440565 - (11 + 86)),(447002 - (175 + 110)),(2176187 - 1734971),(1221943 - 784410),(440402 - (810 + 251)),(138445 + 312657),(432650 - (43 + 490)),(1679776 - 1245524),(102999 + 323827),(29708 + 419180),(434498 - (255 + 150)),(244533 + 212218),(1459727 - 1007788),(452277 - (183 + 223)),(299466 + 152499),(460429 - (10 + 327)),(327735 - (118 + 220)),(321045 - (108 + 341)),(1921280 - 1466841),(821515 - 392980),(138096 + 287878),(1274965 - 846086),(16705 + 448307),(1109346 - 684467),(440744 - (645 + 522)),(443275 + 219),(1240532 - 817208),(1081691 - 654362),(323654 - (351 + 154)),(321935 - (28 + 238)),(324173 - (1381 + 178)),(259498 + 62323),(1112675 - 789919),(335611 - (381 + 89)),(225532 + 107953),(334789 - (1074 + 82)),(323538 - (214 + 1570)),(190943 + 272239),(445055 + 12609),(451821 - (1668 + 58)),(1173416 - 723339),(1563911 - 1114467),(83021 + 360486),(1521956 - 1070734),(428203 - (1269 + 200)),(435470 - (98 + 717)),(758435 - 318643),(63026 + 363745),(70536 + 358891)});
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
local v48 = v18.converArrayToList({(538388 - 344858),(7002 + 12572),(297735 + 63217),(88858 + 101461),(60556 - 48084),(4173 + 7869),(328401 + 36949),(14076 - (192 + 134)),(63469 + 50581),(105419 + 8632),(205731 - (83 + 468)),(1237944 - 972757),(734471 - 469198),(30775 + 1109),(84675 + 147220),(18922 + 88652),(3630 - (340 + 1571)),(49340 - (1733 + 39)),(50062 - (125 + 909)),(68309 + 83970),(194148 + 6018),(194459 - (46 + 190)),(108138 + 275272),(103286 - (228 + 498)),(215689 + 174725),(278638 - 171687),(103067 - (303 + 221)),(312564 + 62523)});
local v49 = v18.converArrayToList({(931239 - 705276),(499545 - 299363),(688290 - 491936),(363471 - 137987),(197624 - (111 + 1137)),(776030 - 515289),(427183 - (423 + 100)),(1142167 - 729662),(256585 - (326 + 445)),(569061 - 313627),(264861 - (530 + 181)),(411732 - (19 + 13)),(960002 - 548044),(68708 + 195848),(418363 - 216630),(546613 - 278706),(498257 - 237706),(606383 - 348976),(87047 + 339612),(87034 + 289600),(240706 + 144475)});
local v50 = {[1097 - (709 + 387)]=true,[1861 - (673 + 1185)]=true,[11 - 7]=true,[19 - 13]=true,[12 - 4]=true,[7 + 2]=true,[8 + 2]=true};
local v51 = {[1 - 0]=true,[1 + 1]=true,[7 - 3]=true,[9 - 4]=true,[1886 - (446 + 1434)]=true,[1290 - (1040 + 243)]=true,[23 - 15]=true,[1858 - (559 + 1288)]=true,[1943 - (609 + 1322)]=true};
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
		if ((v192:Role() == LUAOBFUSACTOR_DECRYPT_STR_0("\152\226\250\43\37\14\142", "\75\220\163\183\106\98")) and v52(v192:ClassID(), v50)) then
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
		if ((v194:Role() == LUAOBFUSACTOR_DECRYPT_STR_0("\38\155\166\22\254\39\136", "\185\98\218\235\87")) and v52(v194:ClassID(), v51)) then
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
		if (v196:Role() == LUAOBFUSACTOR_DECRYPT_STR_0("\239\29\10\199\249\143\249", "\202\171\92\71\134\190")) then
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
		if (v143 and not v143:IsDeadOrGhost() and (v143:Role() == LUAOBFUSACTOR_DECRYPT_STR_0("\1\228\13\164\12\243", "\232\73\161\76")) and v143:IsSpellInRange(v24.HolyShock)) then
			return v143;
		end
	end
	return v143 or v6;
end
local function v58(v145)
	for v197, v198 in pairs(v145) do
		local v199 = v11(323135 - (13 + 441));
		if ((v198:Role() ~= LUAOBFUSACTOR_DECRYPT_STR_0("\143\248\108\118", "\126\219\185\34\61")) and v198:DebuffDown(v24.ForbearanceDebuff) and v198:DebuffDown(v199)) then
			local v208 = v198:HealthPercentageWeighted();
			if ((not v6:IsInRaid() and v38.SpecialHealing.UseBoP and (v18.unitHasDebuffFromList(v18.DebuffList[LUAOBFUSACTOR_DECRYPT_STR_0("\46\194\91\119\122", "\135\108\174\62\18\30\23\147")], v198) or v18.unitHasDebuffFromList(v49, v198))) or (v208 <= v38.SpecialHealing.BoPHP)) then
				return v198;
			end
		end
	end
	return nil;
end
local function v59(v146)
	if (v38.SpecialHealing.BoSHP == (0 - 0)) then
		return nil;
	end
	local v147 = nil;
	local v148 = 261 - 161;
	local v149 = false;
	local v150 = false;
	for v200, v201 in pairs(v146) do
		if (v6 ~= v201) then
			local v209 = v201:HealthPercentage();
			local v210 = v38.SpecialHealing.BoSHP;
			if v18.unitHasBuffFromList(v31, v201) then
				v210 = 74 - 59;
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
					if (v209 <= (1 + 14)) then
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
		return LUAOBFUSACTOR_DECRYPT_STR_0("\146\236\60\196\88\143\38\213\183\169\9\202\11\186", "\167\214\137\74\171\120\206\83");
	end
	if (v24.CrusaderAura:IsReady() and v6:IsMounted() and v6:BuffDown(v24.CrusaderAura, true)) then
		v16(v24.CrusaderAura);
		return LUAOBFUSACTOR_DECRYPT_STR_0("\168\226\39\78\249\163\142\226\114\124\237\181\138\176\17\92\235\179", "\199\235\144\82\61\152");
	end
end
local function v61(v151, v152, v153, v154, v155)
	local v156, v157, v158 = v6:GetUseableItems(v30, 47 - 34);
	if (v156 and v18.AoELogic(v151, v152, v155)) then
		if v16(v156) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\19\4\176\37\12\19\173\122\71\2\171\34\9\29\188\63\20\86\235", "\75\103\118\217");
		end
	end
	local v159, v157, v160 = v6:GetUseableItems(v30, 5 + 9);
	if (v159 and v18.AoELogic(v153, v154, v155)) then
		if v16(v159) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\211\70\121\26\178\27\211\6\48\0\171\23\201\95\117\0\170\94\147", "\126\167\52\16\116\217");
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
		if (v205:Role() == LUAOBFUSACTOR_DECRYPT_STR_0("\252\15\14\171", "\156\168\78\64\224\212\121")) then
			if (not (v205:ClassID() == (3 + 3)) and (v205:HealthPercentage() >= (192 - 127))) then
				v206 = v206 * (1.9 + 0);
			elseif (v205:PowerPercentage() > (36 - 16)) then
				v206 = v206 * (1.2 + 0);
			end
		end
		if (v206 < v167) then
			v167 = v206;
			v166 = v205;
		end
		if (v205:Role() == LUAOBFUSACTOR_DECRYPT_STR_0("\51\207\139\229", "\174\103\142\197")) then
			if ((v168 == nil) or (v206 < v169)) then
				v169 = v206;
				v168 = v205;
			end
		end
	end
	return v166, v168;
end
local function v64(v170)
	local v171 = UnitGUID(LUAOBFUSACTOR_DECRYPT_STR_0("\66\41\77\63\32\74\236\87\58\88\61\49", "\152\54\72\63\88\69\62"));
	if (v170 ~= nil) then
		for v212, v213 in pairs(v170) do
			if ((v213:GUID() == v171) and ((v7:CastSpellID() == (178417 + 142371)) or (v7:CastSpellID() == (232603 + 91127)))) then
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
	if (v24.DivineProtection:IsCastable() and (v38.Holy.DivineProtectionHP > (0 + 0)) and ((v6:HealthPercentageWeighted() <= v38.Holy.DivineProtectionHP) or (not v6:IsInRaid() and (v47(v45) or v46(v45)))) and v6:BuffDown(v24.DivineShield)) then
		v13.Cast(v24.DivineProtection);
		return LUAOBFUSACTOR_DECRYPT_STR_0("\240\205\248\85\218\193\174\108\198\203\250\89\215\208\231\83\218\132\198\108\142", "\60\180\164\142") .. v6:HealthPercentageWeighted();
	end
	if (v24.DivineShield:IsCastable() and (v38.Holy.BubbleHP > (0 + 0)) and (v6:HealthPercentage() <= v38.Holy.BubbleHP) and v6:BuffDown(v24.ForbearanceDebuff) and (v6:BuffDown(v24.DivineProtection) or (v6:HealthPercentage() < (443 - (153 + 280))))) then
		v13.Cast(v24.DivineShield);
		return LUAOBFUSACTOR_DECRYPT_STR_0("\124\87\19\32\41\232\82\107\86\12\44\43\233\82\112\110\95", "\114\56\62\101\73\71\141") .. v6:HealthPercentage();
	end
end
local function v116()
	v38.AoE = (not v6:IsInRaid() and v37.APL.Paladin.HolyAoE) or v37.APL.Paladin.HolyRaidAoE;
	v38.AoE2 = (not v6:IsInRaid() and v37.APL.Paladin.HolyAoE2) or v37.APL.Paladin.HolyRaidAoE2;
	v38.Healing = (not v6:IsInRaid() and v37.APL.Paladin.HolyHealing) or v37.APL.Paladin.HolyRaidHealing;
	v38.SpecialHealing = (not v6:IsInRaid() and v37.APL.Paladin.HolySpecialHealing) or v37.APL.Paladin.HolyRaidSpecialHealing;
	v89 = v13.ToggleIconFrame:GetToggle(2 - 1);
	v90 = v13.ToggleIconFrame:GetToggle(3 + 0);
	v107 = v13.ToggleIconFrame:GetToggle(2 + 3);
	v110 = v13.ToggleIconFrame:GetToggle(4 + 2);
	v36 = v18.UnitsinRange(v24.HolyShock);
	v33 = #(v6:GetEnemiesInMeleeRange(5 + 0));
	v77 = v13.ToggleIconFrame:GetToggle(2 + 0);
	v32 = v6:GetEnemiesInMeleeRange(11 - 3);
	v99 = v7:IsInMeleeRange(4 + 1);
	v45 = v6:GetEnemiesInMeleeRange(707 - (89 + 578));
	v112 = v64(v36);
	if v14() then
		v34 = ((#v32 > (0 + 0)) and #v32) or (1 - 0);
	else
		v34 = 1050 - (572 + 477);
	end
	v68, v69 = v18.GetLowestHealthUnit(v36);
	if v69 then
		v71 = v69:HealthPercentage();
		v98 = math.min(v71 + v69:IncomingHeals(), 14 + 86);
	else
		v71 = 61 + 39;
		v98 = 12 + 88;
	end
	if v68 then
		v70 = v68:HealthPercentageWeighted();
		v96 = v68:HealthPercentage();
		v111 = math.min(v70 + v68:IncomingHeals(), 186 - (84 + 2));
		v97 = math.min(v96 + v68:IncomingHeals(), 164 - 64);
	else
		v70 = 73 + 27;
		v96 = 942 - (497 + 345);
		v111 = 3 + 97;
		v97 = 17 + 83;
	end
	v72 = v62(v36, v24.TyrsDeliveranceBuff);
	v74 = (v6:BuffUp(v24.SealofClarity) and (1335 - (605 + 728))) or (3 + 0);
	v75 = v6:BuffUp(v24.DivinePurposeBuff) or (v6:HolyPower() >= v74) or v6:BuffUp(v24.ShiningRighteousness);
	v76 = v6:BuffUp(v24.DivinePurposeBuff) and (v6:BuffRemains(v24.DivinePurposeBuff) < (3 - 1));
	v108 = (v24.EternalFlame:IsAvailable() and v24.EternalFlame) or v24.WoG;
	v79 = v18.BuffCount(v36, v24.BoV);
	v80 = v13.ToggleIconFrame:GetToggle(1 + 3);
	v106 = (v24.BarrierofFaith:IsAvailable() and ((v6:BuffUp(v24.BlessingofDawn) and (v6:BuffStack(v24.BlessingofDawn) >= (7 - 5))) or v6:BuffDown(v24.Infusion) or not v24.HolyShock:IsReady())) or not v24.BarrierofFaith:IsAvailable();
	v113 = (v6:BuffUp(v24.AvengingCrusader) and not v24.CrusaderStrike:IsReady() and not v24.HolyShock:IsReady() and not v24.HammerofWrath:IsReady() and not v75 and not v24.Judgment:IsReady()) or v6:BuffDown(v24.AvengingCrusader);
	v114 = (v24.CrusadersMight:IsAvailable() and ((v24.HolyShock:FullRechargeTime() >= (2 + 0)) or (v24.Judgment:CooldownRemains() >= (5 - 3)))) or not v24.CrusadersMight:IsAvailable();
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
		return LUAOBFUSACTOR_DECRYPT_STR_0("\156\236\205\203\248\200\206\214\185\169\248\197\171\253", "\164\216\137\187");
	end
	if ((v70 >= (34 + 11)) and v27(v7) and (v24.Cleanse:CooldownDown() or not v24.ImprovedCleanse:IsAvailable()) and v7:IsInRange(529 - (457 + 32))) then
		if v24.HolyShock:IsReady() then
			v16(v24.HolyShock);
			return;
		end
		if (v75 and v108:IsReady()) then
			v16(v108);
			return;
		end
	end
	if ((v70 >= (15 + 20)) and v29() and (v7:HealthPercentage() > (1402 - (832 + 570))) and (v7:HealthPercentage() < (95 + 5))) then
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
			return LUAOBFUSACTOR_DECRYPT_STR_0("\251\232\37\183\180\253\14\193\245\56\189\168\190\4\220\166\5\179\180\249\14\198", "\107\178\134\81\210\198\158");
		end
		if (v9:UnitIsFriend() and v9:IsAPlayer() and v9:Exists() and v9:IsDeadOrGhost()) then
			v13.CastTarget(v24.Intercession, v13.TName().MOUSEOVER);
			return LUAOBFUSACTOR_DECRYPT_STR_0("\17\0\150\195\184\59\11\145\213\163\55\0\194\201\164\120\35\141\211\185\61\1\148\195\184", "\202\88\110\226\166");
		end
	end
	if (v107 and (v6:IsInParty() or v6:IsInRaid())) then
		if (v70 <= (8 + 22)) then
			v13.CastMacro(6 - 4, true);
		end
	end
	if not v107 then
		if (v24.LoH:IsReady() and v6:AffectingCombat()) then
			if (v65 == nil) then
				v65 = v68;
			end
			if ((v65:HealthPercentage() > v38.SpecialHealing.LoHHP) and (v65:HealthPercentage() > (0 + 0))) then
				v65 = nil;
			end
			if (v65 ~= nil) then
				if (v65:DebuffDown(v24.ForbearanceDebuff) and (v65:HealthPercentage() <= v38.SpecialHealing.LoHHP) and (v65:HealthPercentage() > (796 - (588 + 208)))) then
					v65:Cast(v24.LoH);
					return LUAOBFUSACTOR_DECRYPT_STR_0("\239\0\170", "\170\163\111\226\151");
				end
			end
		end
		if ((v6:HealthPercentage() >= (80 - 50)) and v6:AffectingCombat()) then
			if v24.BlessingofSacrifice:IsReady() then
				if ((v104 ~= nil) and (not v104 == v68) and (v104 ~= v6)) then
					v104:Cast(v24.BlessingofSacrifice);
					return LUAOBFUSACTOR_DECRYPT_STR_0("\51\60\183\43\93\62\39\22\112\189\62\14\4\40\18\112\255\120\98\56\46\24\51", "\73\113\80\210\88\46\87");
				end
				if ((v104 == v68) and (v104 ~= v6)) then
					if (v104:HealthPercentageWeighted() <= v38.SpecialHealing.BoSHP) then
						v104:Cast(v24.BlessingofSacrifice);
						return LUAOBFUSACTOR_DECRYPT_STR_0("\163\32\200\1\244\136\34\202\82\232\135\108\254\19\228", "\135\225\76\173\114");
					end
				end
			end
		end
		if v24.BlessingofProtection:IsReady() then
			if (v105 ~= nil) then
				v105:Cast(v24.BlessingofProtection);
				return LUAOBFUSACTOR_DECRYPT_STR_0("\56\226\136\240\143\188\180\14\232\188\240\187\180\179\18\173\148\191\171\180\164", "\199\122\141\216\208\204\221");
			end
		end
		if (v24.BoV:IsReady() and v6:AffectingCombat() and (v18.AoELogicWithCountUnweighted(v38.AoE.BoVHP, v38.AoE.BoVCount, v38.Cooldowns.BoVUsage, v36) or ((v38.Cooldowns.BoVUsage == LUAOBFUSACTOR_DECRYPT_STR_0("\154\212\4\248\56\218\162\218\25\243", "\150\205\189\112\144\24")) and (v47(v45) or v46(v45))))) then
			v68:Cast(v24.BoV);
			return LUAOBFUSACTOR_DECRYPT_STR_0("\7\139\137\12\39\137\2\4\32\128\255\124\1\154\81\35\32\144\171\69\10\143\2", "\112\69\228\223\44\100\232\113");
		end
		if (v6:BuffUp(v24.AwakeningMaxBuff) and v18.TargetIsValid() and v7:AffectingCombat() and v6:AffectingCombat() and v6:IsInRange(1830 - (884 + 916)) and v24.Judgment:IsReady()) then
			if not v24.BoV:IsAvailable() then
				if v18.AoELogicWithCount(v38.SpecialHealing.AwakeningHP, v38.SpecialHealing.AwakeningCount, LUAOBFUSACTOR_DECRYPT_STR_0("\227\22\19\219\246\80\137\211\22\4", "\230\180\127\103\179\214\28"), v36) then
					v13.Cast(v24.Judgment);
					return LUAOBFUSACTOR_DECRYPT_STR_0("\166\16\91\65\225\76\229\130\17\31\64\235\83\160\173\18\94\77\225\79\233\130\2\31\118\246\78\227\204\72\31\110\237\70\232\137\23\31\118\246\72\239\158\12\75\95\164\86\233\152\13\31\100\235\119\160\173\6\75\79\242\68\160\131\23\31\115\234\85\225\128\0\81\82\225\69", "\128\236\101\63\38\132\33");
				end
			end
		end
		if v6:IsInRaid() then
			if (v6:BuffUp(v24.AwakeningMaxBuff) and v18.TargetIsValid() and v7:AffectingCombat() and v6:AffectingCombat() and v6:IsInRange(62 - 32) and v24.Judgment:IsReady()) then
				if not v24.BoV:IsAvailable() then
					if v18.AoELogicWithCount(v38.HolySpecialHealing.AwakeningHP, v38.HolySpecialHealing.AwakeningCount, LUAOBFUSACTOR_DECRYPT_STR_0("\155\160\5\76\246\199\192\171\160\18", "\175\204\201\113\36\214\139"), v36) then
						v13.Cast(v24.Judgment);
						return LUAOBFUSACTOR_DECRYPT_STR_0("\109\217\49\219\1\74\201\59\200\68\65\195\39\156\37\80\205\62\217\10\78\194\50\156\52\85\195\54\156\73\7\228\60\219\12\66\222\117\236\22\78\195\39\213\16\94\140\34\213\16\79\140\23\211\50\7\237\54\200\13\81\201\117\211\22\7\249\59\200\5\75\201\59\200\1\67", "\100\39\172\85\188");
					end
				end
			end
		end
		if v6:AffectingCombat() then
			if (v24.AvengingWrath:IsReady() and v18.AoELogicWithCountUnweighted(v38.AoE.AWHP, v38.AoE.AWCount, v38.Cooldowns.AWUsage, v36)) then
				v13.Cast(v24.AvengingWrath, false);
				return LUAOBFUSACTOR_DECRYPT_STR_0("\140\110\188\142\52\164\118\190\192\4\191\121\173\136\115\142\121\170\148\54\169\56\137\133\33\237\75\188\148\39\164\118\190\147", "\83\205\24\217\224");
			end
			if (v24.AvengingCrusader:IsReady() and v18.AoELogicWithCountUnweighted(v38.AoE.ACHP, v38.AoE.ACCount, v38.Cooldowns.ACUsage, v36)) then
				v16(v24.AvengingCrusader, false);
				return LUAOBFUSACTOR_DECRYPT_STR_0("\199\211\200\51\225\204\195\58\166\230\223\40\245\196\201\56\244\133\238\60\245\209\200\57\166\245\200\47\166\246\200\41\242\204\195\58\245", "\93\134\165\173");
			end
			if (v24.AuraMastery:IsReady() and v6:BuffDown(v24.AvengingWrathBuff) and v6:BuffDown(v24.AvengingCrusader) and (v18.GetAverageGroupHealthPercent(v36) <= (9 + 6)) and v18.AoELogicWithCountUnweighted(v38.AoE.AMHP, v38.AoE.AMCount, v38.Cooldowns.AMUsage, v36)) then
				v16(v24.AuraMastery, false);
				return LUAOBFUSACTOR_DECRYPT_STR_0("\159\231\211\195\122\227\179\109\170\247\211\219\122\237\179\109\170\247\197\130\10\203\160\62\141\247\213\214\51\192\181\109", "\30\222\146\161\162\90\174\210");
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
				if (v24.BoL:IsReady() and not v92 and v69:BuffDown(v24.BoL) and v69:BuffDown(v24.BoF) and (v18.BuffCount(v36, v24.BoL) < (654 - (232 + 421)))) then
					v69:Cast(v24.BoL);
					if v6:IsInRaid() then
						v92 = true;
					end
					return LUAOBFUSACTOR_DECRYPT_STR_0("\199\65\92\74\202\64\48\38\234\89\117\25\241\14\68\11\235\69", "\106\133\46\16");
				end
			end
			if (v24.BoF:IsReady() and not v91 and v6:BuffDown(v24.BoF) and v6:BuffDown(v24.BoL) and (v18.BuffCount(v36, v24.BoF) < (1890 - (1569 + 320)))) then
				v6:Cast(v24.BoF);
				if v6:IsInRaid() then
					v91 = true;
				end
				return LUAOBFUSACTOR_DECRYPT_STR_0("\122\47\85\188\117\78\24\16\127\253\67\69\74", "\32\56\64\19\156\58");
			end
		end
		if v6:AffectingCombat() then
			if (v109 ~= nil) then
				if v24.SacredWeapon:IsReady() then
					v109:Cast(v24.SacredWeapon);
					return LUAOBFUSACTOR_DECRYPT_STR_0("\105\201\230\68\95\246\192\109\205\228\70\85\252", "\224\58\168\133\54\58\146");
				end
			end
			if v24.HolyBulwark:IsReady() then
				if v38.Healing.HBTank then
					if (v69 ~= nil) then
						if (v71 <= v38.Healing.HBHP) then
							v69:Cast(v24.HolyBulwark);
							return LUAOBFUSACTOR_DECRYPT_STR_0("\113\89\71\228\53\164\146\7\78\87\89\246", "\107\57\54\43\157\21\230\231");
						end
					end
				end
				if ((v38.Healing.HBTank and (v70 <= (7 + 18)) and (v70 <= v38.Healing.HBHP)) or (not v38.Healing.HBTank and (v70 <= v38.Healing.HBHP))) then
					v68:Cast(v24.HolyBulwark);
					return LUAOBFUSACTOR_DECRYPT_STR_0("\243\132\29\236\249\254\218\215\156\16\231\178", "\175\187\235\113\149\217\188");
				end
			end
		end
		if ((v24.BoV:CooldownRemains() >= (2.5 + 6)) or (v79 > (3 - 2)) or not v24.BoV:IsAvailable()) then
			if (v68 ~= nil) then
				if (v24.DivineToll:IsReady() and v18.AoELogicWithCountUnweighted(v38.AoE.DivineTollHP, v38.AoE.DivineTollCount, v38.Cooldowns.DTUsage, v36)) then
					v68:Cast(v24.DivineToll);
					return LUAOBFUSACTOR_DECRYPT_STR_0("\24\166\151\69\237\124\56\8\160\141\64\163\111\113\61\239\178\73\247\109\113\50\168\146\12\236\107\56\53\161\193\124\226\107\108\37", "\24\92\207\225\44\131\25");
				end
			end
		end
		if v6:BuffUp(v24.AvengingCrusader) then
			if (v79 >= (606 - (316 + 289))) then
				if (v108:IsReady() and v75 and ((v70 <= v38.Healing.WoGHP) or v76)) then
					v68:Cast(v108);
					return LUAOBFUSACTOR_DECRYPT_STR_0("\124\220\159\12\20\115\11\241\183\122\91\72\69\218\172\12\63\104\89\218\182\75\91\92\104", "\29\43\179\216\44\123");
				end
			end
			if (v24.Judgment:IsReady() and v7:IsInRange(78 - 48) and (v70 <= v38.SpecialHealing.JudgementInAC) and v18.TargetIsValid()) then
				v16(v24.Judgment);
				return LUAOBFUSACTOR_DECRYPT_STR_0("\151\204\36\75\184\212\37\66\169\153\4\89\175\208\46\75\253\248\3", "\44\221\185\64");
			end
			if v6:IsInRaid() then
				if (v24.Judgment:IsReady() and v7:IsInRange(2 + 28) and (v70 <= v38.HolyRaidSpecialHealing.JudgementInAC) and v18.TargetIsValid()) then
					v16(v24.Judgment);
					return LUAOBFUSACTOR_DECRYPT_STR_0("\43\242\76\88\118\12\226\70\75\51\37\242\90\86\125\6\167\105\124", "\19\97\135\40\63");
				end
			end
			if (v24.CrusaderStrike:IsReady() and v99 and (v70 <= (1543 - (666 + 787))) and v18.TargetIsValid()) then
				v16(v24.CrusaderStrike);
				return LUAOBFUSACTOR_DECRYPT_STR_0("\141\78\38\40\46\53\171\78\115\8\59\35\167\87\54\123\11\36\188\85\61\60\111\16\141", "\81\206\60\83\91\79");
			end
			if ((v108:IsReady() and v75 and ((v6:HolyPower()) >= (430 - (360 + 65))) and (v70 <= v38.Healing.WoGHP)) or v76) then
				v68:Cast(v108);
				return LUAOBFUSACTOR_DECRYPT_STR_0("\121\164\247\50\11\214\95\173\64\172\144\83\12", "\196\46\203\176\18\79\163\45");
			end
			if (v80 and v24.LoD:IsReady() and v75 and v6:BuffDown(v24.EmpyreanLegacy) and (v18.AoELogicWithCount(v38.AoE.LoDHP, v38.AoE.LoDCount, LUAOBFUSACTOR_DECRYPT_STR_0("\143\43\106\22\100\215\224\191\43\125", "\143\216\66\30\126\68\155"), v36) or v76)) then
				v16(v24.LoD);
				return LUAOBFUSACTOR_DECRYPT_STR_0("\134\199\41\139\225\182\197\232\164\207\77\234\198", "\129\202\168\109\171\165\195\183");
			end
			if (v24.HolyShock:IsReady() and (v70 <= v38.Healing.HolyShockHP)) then
				v68:Cast(v24.HolyShock);
				return LUAOBFUSACTOR_DECRYPT_STR_0("\10\87\59\193\158\39\238\45\91\60\152\250\1\244\43\86\48\152\255\55", "\134\66\56\87\184\190\116");
			end
			if (v24.HammerofWrath:IsReady() and v7:IsInRange(29 + 1)) then
				v16(v24.HammerofWrath);
				return LUAOBFUSACTOR_DECRYPT_STR_0("\124\25\8\182\20\238\51\117\51\55\73\140\11\234\53\61\124\21\28\169\16\229\38\117\29\18", "\85\92\81\105\219\121\139\65");
			end
		end
		if ((v24.BoV:CooldownRemains() >= (262.5 - (79 + 175))) or (v79 > (1 - 0)) or not v24.BoV:IsAvailable()) then
			if ((v24.DivineToll:IsAvailable() and (v24.DivineToll:CooldownRemains() < (41 + 11)) and v24.DivineResonanceTalent:IsAvailable()) or not v24.DivineResonanceTalent:IsAvailable()) then
				if (((v6:BuffUp(v24.AwakeningBuff) and (v6:BuffStack(v24.AwakeningBuff) < (42 - 28))) or v6:BuffDown(v24.AwakeningBuff)) and v6:BuffDown(v24.AvengingWrathBuff) and v6:BuffDown(v24.AvengingCrusader)) then
					if (v24.HolyPrism:IsReady() and (v70 > (86 - 41)) and v7:IsInRange(939 - (503 + 396)) and v6:AffectingCombat() and v6:AffectingCombat() and v18.TargetIsValid() and v18.AoELogicWithCount(v38.AoE2.HPHP, v38.AoE2.HPCount, v38.Cooldowns.HPUsage, v36)) then
						v16(v24.HolyPrism);
						return LUAOBFUSACTOR_DECRYPT_STR_0("\213\188\92\92\60\239\239\186\67\72\60\208\243\243\100\68\110\216\248\167\16\85\121\205\189\128\85\81\104\214\243\180\67", "\191\157\211\48\37\28");
					end
					if (v24.HolyPrism:IsReady() and (v70 <= (226 - (92 + 89))) and v18.AoELogicWithCount(v38.AoE2.HPHP, v38.AoE2.HPCount, v38.Cooldowns.HPUsage, v36)) then
						v68:Cast(v24.HolyPrism);
						return LUAOBFUSACTOR_DECRYPT_STR_0("\247\16\248\5\122\239\13\253\15\55\159\16\250\92\22\208\8\241\8\122\234\17\253\8\122\207\26\230\92\9\218\11\224\21\52\216\12", "\90\191\127\148\124");
					end
				end
			end
		end
		if (v24.HandofDivintiy:IsReady() and not v6:IsMoving() and v38.TyrSettings.BeforeTyrs and v18.AoELogicWithCount(v38.AoE.TyrsHP, v38.AoE.TyrsCount, LUAOBFUSACTOR_DECRYPT_STR_0("\79\142\58\31\56\171\33\16\113\132", "\119\24\231\78"), v36) and ((not v6:IsInRaid() and v6:IsInParty() and (v70 >= (116 - 56))) or v6:IsInRaid())) then
			v16(v24.HandofDivintiy);
			return LUAOBFUSACTOR_DECRYPT_STR_0("\170\44\171\78\156\79\23\194\9\172\92\213\78\24\150\52\229\72\217\70\30\144\40\229\126\197\82\2", "\113\226\77\197\42\188\32");
		end
		if (v24.TyrsDeliverance:IsReady() and (v18.AoELogicWithCount(v38.AoE.TyrsHP, v38.AoE.TyrsCount, LUAOBFUSACTOR_DECRYPT_STR_0("\13\31\224\189\122\58\251\178\51\21", "\213\90\118\148"), v36) or (v6:BuffUp(v24.HandofDivintiy) and (v38.AoE.TyrsHP > (0 + 0)))) and not v6:IsMoving()) then
			v16(v24.TyrsDeliverance);
			return "Tyr's based on Settings and/or Hand of Divinity Buff";
		end
		if (v24.HandofDivintiy:IsReady() and not v6:IsMoving() and (v70 <= v38.SpecialHealing.HandofDivinityHP) and (v70 >= (27 + 18)) and not v6:IsMoving()) then
			v16(v24.HandofDivintiy);
			return LUAOBFUSACTOR_DECRYPT_STR_0("\115\47\186\82\13\84\40\244\114\68\77\39\186\95\89\66\110\154\89\95\86\47\184", "\45\59\78\212\54");
		end
		if (v6:BuffUp(v24.DivineFavorBuff) and v24.FoL:IsReady() and not v6:PrevGCD(3 - 2, v24.FoL) and not v6:IsCasting() and (((v111 <= v38.SpecialHealing.FoLBoth) and v6:BuffUp(v24.Infusion)) or (v111 <= v38.SpecialHealing.FoLDFHP)) and not v6:IsMoving()) then
			v68:Cast(v24.FoL);
			return LUAOBFUSACTOR_DECRYPT_STR_0("\54\89\175\203\128\33\191\176\52\95\149\130\136\43\237\214\17\64\140\153", "\144\112\54\227\235\230\78\205");
		end
		if (v6:BuffUp(v24.DivineFavorBuff) and v24.HolyLight:IsReady() and not v6:PrevGCD(1 + 0, v24.HolyLight) and not v6:IsCasting() and (((v111 <= v38.SpecialHealing.HLBoth) and v6:BuffUp(v24.Infusion)) or (v111 <= v38.SpecialHealing.HLDFHP)) and not v6:IsMoving()) then
			v68:Cast(v24.HolyLight);
			return LUAOBFUSACTOR_DECRYPT_STR_0("\155\39\3\229\144\119\186\47\7\232\144\93\188\58\79\216\217\77\186\38\10\188\246\90\165\39\29", "\59\211\72\111\156\176");
		end
		if (v69 ~= nil) then
			if (not v24.HolyShock:IsReady() and (not v6:IsInRaid() or (v6:IsInRaid() and (v6:HolyPower() > (8 - 4))))) then
				if (v24.FoL:IsReady() and not v6:IsMoving() and v6:BuffUp(v24.Infusion) and (v98 <= v38.Healing.FoLIHP)) then
					v69:Cast(v24.FoL);
					return LUAOBFUSACTOR_DECRYPT_STR_0("\104\136\207\109\103\137\229\56\93\142\236\35\14\183\241\36\65\149\234\57\87\199\174\109\122\134\237\38", "\77\46\231\131");
				end
			end
			if (v108:IsReady() and v75 and (v71 <= v38.Healing.WoGTankHP)) then
				v69:Cast(v108);
				return LUAOBFUSACTOR_DECRYPT_STR_0("\141\91\145\0\181\90\246\116\187\90\189", "\32\218\52\214");
			end
		end
		if (v69 ~= nil) then
			if (v24.BarrierofFaith:IsReady() and v69:BuffDown(v24.BarrierofFaith)) then
				v69:Cast(v24.BarrierofFaith);
				return LUAOBFUSACTOR_DECRYPT_STR_0("\108\22\35\186\248\181\87\26\65\17\113\142\240\185\81\82", "\58\46\119\81\200\145\208\37");
			end
		end
		if (not v75 or not v24.HolyShock:IsReady()) then
			if (v24.FoL:IsReady() and v6:BuffDown(v24.HandofDivintiyBuff) and v6:BuffDown(v24.TyrsDeliverancePlayerBuff) and not v6:IsMoving() and ((v111 <= v38.Healing.FoLHP) or (v6:BuffUp(v24.Infusion) and (v111 <= v38.Healing.FoLIHP)))) then
				v68:Cast(v24.FoL);
				return LUAOBFUSACTOR_DECRYPT_STR_0("\13\131\28\236\140\176\51\57\139\53\162\170\164\118\36\158\112\133\167\187\35\56\133\63\162\233\141\36\34\131\34\165\189\164\118\102\204\5\162\160\169\118\7\131\39\169\186\169", "\86\75\236\80\204\201\221");
			end
		end
		if ((v111 >= (57 + 8)) and v6:AffectingCombat() and v24.BlessingofSummer:IsAvailable()) then
			if (v24.BlessingofAutumn:IsReady() and (v103 ~= nil)) then
				v103:Cast(v24.BlessingofAutumn);
				return LUAOBFUSACTOR_DECRYPT_STR_0("\80\77\114\150\237\130\124\70\55\138\248\203\83\84\99\136\235\133\50\98\118\150\234", "\235\18\33\23\229\158");
			end
			if (v24.BlessingofSpring:IsReady() and (v102 ~= nil)) then
				v102:Cast(v24.BlessingofSpring);
				return LUAOBFUSACTOR_DECRYPT_STR_0("\114\182\196\168\67\179\207\188\16\181\199\251\99\170\211\178\94\189\129\152\81\169\213", "\219\48\218\161");
			end
			if (v24.BlessingofWinter:IsReady() and (v101 ~= nil)) then
				v101:Cast(v24.BlessingofWinter);
				return LUAOBFUSACTOR_DECRYPT_STR_0("\198\125\121\90\200\70\238\227\49\115\79\155\120\233\234\101\121\91", "\128\132\17\28\41\187\47");
			end
			if (v24.BlessingofSummer:IsReady() and (v100 ~= nil)) then
				v100:Cast(v24.BlessingofSummer);
				return LUAOBFUSACTOR_DECRYPT_STR_0("\35\62\3\41\78\8\60\1\122\82\7\114\53\47\80\12\55\20", "\61\97\82\102\90");
			end
		end
		if (v6:BuffUp(v24.TyrsDeliverancePlayerBuff) and v24.BoundlessSalvation:IsAvailable()) then
			if (v72 ~= nil) then
				if (v24.HolyLight:IsReady() and v6:BuffUp(v24.HandofDivintiy) and ((v72:HealthPercentage() <= v38.TyrSettings.TyrHLHP) or (v6:BuffRemains(v24.HandofDivintiy) <= (3 + 3)))) then
					v72:Cast(v24.HolyLight);
					return "Holy Light on Tyr's Target";
				end
				if (v24.HolyShock:IsReady() and (((v6:HolyPower() < (15 - 10)) and v6:BuffDown(v24.RisingSunlight)) or ((v6:HolyPower() < (1 + 2)) and v6:BuffUp(v24.RisingSunlight)))) then
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
			if (v24.HolyLight:IsReady() and v6:BuffUp(v24.HandofDivintiy) and ((v70 <= v38.SpecialHealing.HandofDivinityHP) or (v6:BuffRemains(v24.HandofDivintiy) <= (8 - 2)))) then
				v68:Cast(v24.HolyLight);
				return LUAOBFUSACTOR_DECRYPT_STR_0("\132\33\167\82\135\123\23\14\164\58\235\92\206\67\22\73\132\33\143", "\105\204\78\203\43\167\55\126");
			end
		end
		if v24.VenerationTalent:IsAvailable() then
			if ((v24.EternalFlame:IsAvailable() and not v75) or not v24.EternalFlame:IsAvailable()) then
				if (v24.HammerofWrath:IsReady() and v7:IsInRange(1274 - (485 + 759)) and v18.TargetIsValid()) then
					v13.Cast(v24.HammerofWrath);
					return LUAOBFUSACTOR_DECRYPT_STR_0("\141\171\46\19\22\22\135\94\163\234\20\12\18\16\207\17\147\175\45\27\1\5\211\88\170\164", "\49\197\202\67\126\115\100\167");
				end
			end
		end
		if (v79 >= (2 - 1)) then
			if ((not v6:IsInRaid() or v6:BuffUp(v24.EmpyreanLegacy)) and v108:IsReady() and v75 and ((v70 <= v38.Healing.WoGHP) or v18.AoELogicWithCount(v38.AoE.LoDHP, v38.AoE.LoDCount, LUAOBFUSACTOR_DECRYPT_STR_0("\0\82\203\33\192\122\81\48\82\220", "\62\87\59\191\73\224\54"), v36) or v76)) then
				v68:Cast(v108);
				return LUAOBFUSACTOR_DECRYPT_STR_0("\208\13\221\137\227\23\232\192\233\5\186\235\232\52", "\169\135\98\154");
			end
			if (v6:IsInRaid() and v80 and v24.LoD:IsReady() and v75 and v6:BuffDown(v24.EmpyreanLegacy) and (v18.AoELogicWithCount(v38.AoE.LoDHP, v38.AoE.LoDCount, LUAOBFUSACTOR_DECRYPT_STR_0("\252\126\48\92\189\31\199\204\126\39", "\168\171\23\68\52\157\83"), v36) or v76)) then
				v16(v24.LoD);
				return LUAOBFUSACTOR_DECRYPT_STR_0("\216\126\209\237\44\35\199\198\112\252\169\101\9\146\230\120\251\170\101\15\136\194", "\231\148\17\149\205\69\77");
			end
		end
		if (v80 and v108:IsReady() and v75 and v106 and ((v70 <= v38.Healing.WoGOverHP) or v76)) then
			v68:Cast(v108);
			return LUAOBFUSACTOR_DECRYPT_STR_0("\183\168\224\187\120\233\133\181\135\215\88\219", "\159\224\199\167\155\55");
		end
		if (v79 < (1190 - (442 + 747))) then
			if (v80 and v106 and v24.LoD:IsReady() and v75 and v6:BuffDown(v24.EmpyreanLegacy) and (v18.AoELogicWithCount(v38.AoE.LoDHP, v38.AoE.LoDCount, LUAOBFUSACTOR_DECRYPT_STR_0("\192\250\40\218\183\223\51\213\254\240", "\178\151\147\92"), v36) or v76)) then
				v16(v24.LoD);
				return LUAOBFUSACTOR_DECRYPT_STR_0("\160\242\104", "\26\236\157\44\82\114\44");
			end
		end
		if (v108:IsReady() and v106 and v75 and ((v70 <= v38.Healing.WoGHP) or v76)) then
			v68:Cast(v108);
			return LUAOBFUSACTOR_DECRYPT_STR_0("\29\33\242", "\59\74\78\181");
		end
		if (v24.FoL:IsReady() and not v6:IsMoving() and v6:BuffUp(v24.Infusion) and (v111 <= v38.Healing.FoLIHP)) then
			v68:Cast(v24.FoL);
			return LUAOBFUSACTOR_DECRYPT_STR_0("\3\222\118\26\149\42\195\26\115\189\35\196\73\83\188\43", "\211\69\177\58\58");
		end
		if v24.HolyShock:IsReady() then
			v83 = v42(v68, v96, v38.Healing.HolyShockHP);
			v84 = v42(v68, v96, v38.Healing.HolyShock2HP);
			v85 = v83 and v6:BuffDown(v24.RisingSunlight);
			v86 = v84 and (v24.HolyShock:Charges() == (1137 - (832 + 303))) and v6:BuffDown(v24.RisingSunlight);
			v87 = (v70 <= v38.Healing.HolyShockRHP) and v6:BuffUp(v24.RisingSunlight);
			v88 = ((v6:HolyPower() < (951 - (88 + 858))) and v6:BuffDown(v24.RisingSunlight)) or ((v6:HolyPower() < (2 + 2)) and v6:BuffUp(v24.RisingSunlight)) or v38.Holy.Overcap;
			if ((v85 or v86 or v87) and v88) then
				v68:Cast(v24.HolyShock);
				return LUAOBFUSACTOR_DECRYPT_STR_0("\159\234\117\236\169\248\191\234\122\254\169\232\182\246\109", "\171\215\133\25\149\137");
			end
		end
		if (v18.TargetIsValid() and v7:AffectingCombat()) then
			if (v24.HammerofWrath:IsReady() and v7:IsInRange(25 + 5)) then
				v13.Cast(v24.HammerofWrath);
				return LUAOBFUSACTOR_DECRYPT_STR_0("\201\201\63\247\234\34\188\77\231\136\5\232\238\36\244", "\34\129\168\82\154\143\80\156");
			end
			if (v24.Judgment:IsReady() and v7:IsInRange(2 + 28) and ((v70 <= (879 - (766 + 23))) or v6:BuffUp(v24.AwakeningMaxBuff))) then
				v13.Cast(v24.Judgment);
				return LUAOBFUSACTOR_DECRYPT_STR_0("\175\167\55\12\77\67\140\139\166", "\233\229\210\83\107\40\46");
			end
			if (v24.CrusaderStrike:IsReady() and ((v6:HolyPower() < (24 - 19)) or v38.Holy.Overcap) and v99) then
				v13.Cast(v24.CrusaderStrike);
				return LUAOBFUSACTOR_DECRYPT_STR_0("\226\80\39\197\4\197\71\32\150\54\213\80\59\221\0", "\101\161\34\82\182");
			end
		end
		if (v24.FoL:IsReady() and v113 and not v6:IsMoving() and ((v70 <= v38.Healing.FoLHP) or (v6:BuffUp(v24.Infusion) and (v111 <= v38.Healing.FoLIHP)))) then
			v68:Cast(v24.FoL);
			return LUAOBFUSACTOR_DECRYPT_STR_0("\206\2\117\190\253\237\144\110\193\3\95\235\200\235\141\32\168\2\75\190\245\237\144\35\233\1", "\78\136\109\57\158\187\130\226");
		end
		if (v24.HolyLight:IsReady() and v113 and (not v6:IsMoving() or v6:BuffUp(v24.HandofDivintiy)) and ((v111 <= v38.Healing.HLHP) or (v6:BuffUp(v24.Infusion) and (v111 <= v38.Healing.HLIHP)))) then
			v68:Cast(v24.HolyLight);
			return LUAOBFUSACTOR_DECRYPT_STR_0("\22\48\245\232\126\19\240\246\54\43\185\215\49\45\185\216\48\57\236\226\55\48\247\177\49\45\185\223\49\45\244\240\50", "\145\94\95\153");
		end
	end
	if (v18.TargetIsValid() and ((v70 >= (61 - 16)) or v107) and not v26(v7) and (v7:AffectingCombat() or (v38.Holy.AttackOOC and v89))) then
		if (v24.Consecration:IsReady() and v7:IsInRange(20 - 12) and not v6:IsMoving() and (v40(v24.Consecration) <= (0 - 0))) then
			v16(v24.Consecration);
			return LUAOBFUSACTOR_DECRYPT_STR_0("\254\194\26\198\75\180\239\204\0\220\65\185\189\221\6\220\65\165\244\217\13\149\28\231", "\215\157\173\116\181\46");
		end
		if (v24.ShieldoftheRighteous:IsUsable() and v99 and (v6:HolyPower() >= (1076 - (1036 + 37))) and ((v6:BuffUp(v24.AvengingWrathBuff) and (v111 >= (39 + 16))) or v110 or v107)) then
			v13.Cast(v24.ShieldoftheRighteous);
			return LUAOBFUSACTOR_DECRYPT_STR_0("\38\188\130\247\214\49\139\132\244\229\33\188\142\205\200\60\179\131\230\223\58\161\152\178\202\39\189\132\224\211\33\173\203\160", "\186\85\212\235\146");
		end
		if (v24.HammerofWrath:IsReady() and v7:IsInRange(58 - 28) and ((v6:HolyPower() < (4 + 1)) or v38.Holy.Overcap or v107)) then
			v16(v24.HammerofWrath);
			return LUAOBFUSACTOR_DECRYPT_STR_0("\202\128\27\243\60\252\103\205\135\41\233\43\239\76\202\193\6\236\48\225\74\203\149\15\190\109", "\56\162\225\118\158\89\142");
		end
		if (v24.DivineToll:IsReady() and v107 and v38.Holy.UseDTDPS and v7:IsInRange(1520 - (641 + 839))) then
			v16(v24.DivineToll);
			return LUAOBFUSACTOR_DECRYPT_STR_0("\120\12\214\166\44\221\28\49\207\163\46\152\90\10\210\239\6\232\111\69\239\161\46\193", "\184\60\101\160\207\66");
		end
		if (v24.HammerofWrath:IsReady() and v7:IsInRange(943 - (910 + 3)) and ((v6:HolyPower() < (12 - 7)) or v38.Holy.Overcap or v107)) then
			v16(v24.HammerofWrath);
			return LUAOBFUSACTOR_DECRYPT_STR_0("\57\131\113\177\52\144\67\179\55\189\107\174\48\150\116\252\33\144\117\179\35\139\104\165\113\211\40", "\220\81\226\28");
		end
		if (v24.Judgment:IsReady() and v7:IsInRange(1714 - (1466 + 218)) and ((v6:HolyPower() < (3 + 2)) or v38.Holy.Overcap or v107)) then
			v16(v24.Judgment);
			return LUAOBFUSACTOR_DECRYPT_STR_0("\25\192\134\252\231\194\29\193\194\235\248\206\28\199\139\239\243\135\66\131", "\167\115\181\226\155\138");
		end
		if (v24.HolyShock:IsReady() and v7:IsInRange(1188 - (556 + 592)) and ((v38.Holy.UseHolyShockDPS and ((v6:HolyPower() < (2 + 3)) or v38.Holy.Overcap)) or v107)) then
			v16(v24.HolyShock);
			return LUAOBFUSACTOR_DECRYPT_STR_0("\234\45\235\69\68\98\206\237\33\236\28\107\99\207\237\48\238\72\98\49\148\176", "\166\130\66\135\60\27\17");
		end
		if (v24.CrusaderStrike:IsReady() and v99 and ((v6:HolyPower() < (813 - (329 + 479))) or v38.Holy.Overcap or v107)) then
			v16(v24.CrusaderStrike);
			return LUAOBFUSACTOR_DECRYPT_STR_0("\71\88\219\102\49\64\79\220\74\35\80\88\199\126\53\4\90\220\124\63\86\67\218\108\112\22\30", "\80\36\42\174\21");
		end
		if (v24.HolyPrism:IsReady() and ((v34 >= (856 - (174 + 680))) or v107)) then
			v6:Cast(v24.HolyPrism);
			return LUAOBFUSACTOR_DECRYPT_STR_0("\70\31\59\99\113\0\37\115\93\29\119\117\64\80\36\127\66\22\119\106\92\25\56\104\71\4\46\58\28\70", "\26\46\112\87");
		end
	end
end
local function v118()
	if (not v6:IsInRaid() and v18.ShouldStopCastUpdate()) then
		v13.CastMacro(20 - 14, true);
		return LUAOBFUSACTOR_DECRYPT_STR_0("\138\55\164\100\255\156\68\167\173\99\141\123\173\255\118\189\181\38\165\119\186", "\212\217\67\203\20\223\223\37");
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
			v176 = v18.InterruptCycle(v24.Rebuke, 10 - 5, true, nil, false, false);
			if v176 then
				return v176;
			end
			if (v24.Rebuke:CooldownDown() or not v24.Rebuke:IsAvailable()) then
				if (v24.BlindingLight:IsReady() and v38.Holy.UseBL) then
					v176 = v18.InterruptCycle(v24.BlindingLight, 8 + 2, false, nil, true, true);
					if v176 then
						return v176;
					end
				end
				if v24.HammerofJustice:IsReady() then
					v176 = v18.InterruptCycle(v24.HammerofJustice, 749 - (396 + 343), false, nil, true);
					if v176 then
						return v176;
					end
				end
			end
		end
		if (v24.BlessingofFreedom:IsReady() and v38.Holy.UseFreedom) then
			if (v112 ~= nil) then
				if v112:Cast(v24.BlessingofFreedom) then
					return LUAOBFUSACTOR_DECRYPT_STR_0("\152\129\173\193\169\132\166\213\250\130\174\146\156\159\173\215\190\130\165\146\156\159\167\200\191\131\232\240\179\131\172\193", "\178\218\237\200");
				end
			end
		end
		if (v24.BlessingofFreedom:IsReady() and v38.Holy.UseFreedom) then
			v176 = v18.DispelCycle(v24.BlessingofFreedom, LUAOBFUSACTOR_DECRYPT_STR_0("\132\186\233\196\146\188\245\192\179\185", "\176\214\213\134"), nil, v36);
			if v176 then
				return v176;
			end
			v176 = v18.DispelCycle(v24.BlessingofFreedom, LUAOBFUSACTOR_DECRYPT_STR_0("\199\163\183\198\173\100\86\251\185", "\57\148\205\214\180\200\54"), nil, v36);
			if v176 then
				return v176;
			end
			v176 = v18.DispelCycle(v24.BlessingofFreedom, LUAOBFUSACTOR_DECRYPT_STR_0("\52\239\48\49\114\29\240\17\61\101\2\248\57", "\22\114\157\85\84"), nil, v36);
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
					v176 = v18.DispelCycle(v24.Cleanse, LUAOBFUSACTOR_DECRYPT_STR_0("\233\202\20\205\94", "\200\164\171\115\164\61\150"), nil, v36);
					if v176 then
						return v176;
					end
					if v24.ImprovedCleanse:IsAvailable() then
						v176 = v18.DispelCycle(v24.Cleanse, LUAOBFUSACTOR_DECRYPT_STR_0("\142\251\10\86\140\176", "\227\222\148\99\37"), nil, v36);
						if v176 then
							return v176;
						end
						v176 = v18.DispelCycle(v24.Cleanse, LUAOBFUSACTOR_DECRYPT_STR_0("\23\91\65\243\248\32\87", "\153\83\50\50\150"), nil, v36);
						if v176 then
							return v176;
						end
					end
				end
			end
			if (v6:IsInRaid() and v24.Cleanse:IsReady()) then
				v176 = v18.DispelCycle(v24.Cleanse, LUAOBFUSACTOR_DECRYPT_STR_0("\111\119\122\24", "\45\61\22\19\124\19\203"), nil, v36);
				if v176 then
					return v176;
				end
				if v24.ImprovedCleanse:IsAvailable() then
					v176 = v18.DispelCycle(v24.Cleanse, LUAOBFUSACTOR_DECRYPT_STR_0("\243\19\4\241", "\217\161\114\109\149\98\16"), nil, v36);
					if v176 then
						return v176;
					end
				end
			end
		end
		if (v6:IsInRaid() and v24.BlessingofFreedom:IsReady()) then
			if (v6:DebuffUp(v11(37559 + 386936), true) or v6:DebuffUp(v11(425974 - (29 + 1448)), true)) then
				v6:Cast(v24.BlessingofFreedom);
				return;
			end
		end
		if (v24.Repentance:IsReady() and not v6:IsInRaid() and v6:AffectingCombat()) then
			v176 = v18.IncorpCycle(v24.Repentance, 1419 - (135 + 1254), false, false);
			if v176 then
				return v176;
			end
		end
		if (v24.TurnEvil:IsReady() and not v6:IsInRaid() and (not v24.Repentance:IsAvailable() or v24.Repentance:CooldownDown())) then
			v176 = v18.IncorpCycle(v24.TurnEvil, 150 - 110, false, false);
			if v176 then
				return v176;
			end
		end
		if (v38.Holy.AutoTabMelee and (v33 > (0 - 0)) and not v99 and v6:CanAttack(v7)) then
			v13.TopPanelAlternative:ChangeIcon(1 + 0, 1530 - (389 + 1138));
			return LUAOBFUSACTOR_DECRYPT_STR_0("\51\53\44\115\252\96\19\34\120\104\179\52\31\37\52\121\185", "\20\114\64\88\28\220");
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
	v13:UpdateMacro(LUAOBFUSACTOR_DECRYPT_STR_0("\60\0\209\166\247\129", "\221\81\97\178\212\152\176"), LUAOBFUSACTOR_DECRYPT_STR_0("\130\242\14\254\90\156\177", "\122\173\135\125\155"));
	v13:UpdateMacro(LUAOBFUSACTOR_DECRYPT_STR_0("\137\192\3\171\48\99", "\168\228\161\96\217\95\81"), LUAOBFUSACTOR_DECRYPT_STR_0("\148\217\60\28\43\71\200\222\32\80\54", "\55\187\177\78\60\79"));
	v13:UpdateMacro(LUAOBFUSACTOR_DECRYPT_STR_0("\32\207\92\249\73\153", "\224\77\174\63\139\38\175"), LUAOBFUSACTOR_DECRYPT_STR_0("\203\82\76\33\148\66\89\61\144\72\86\41", "\78\228\33\56"));
	v13.ToggleIconFrame:AddButtonCustom("O", 575 - (102 + 472), LUAOBFUSACTOR_DECRYPT_STR_0("\225\81\145", "\229\174\30\210\99"), LUAOBFUSACTOR_DECRYPT_STR_0("\20\226\133", "\89\123\141\230\49\141\93"));
	v13.ToggleIconFrame:AddButtonCustom("D", 2 + 0, LUAOBFUSACTOR_DECRYPT_STR_0("\215\120\229\28\21\70", "\42\147\17\150\108\112"), LUAOBFUSACTOR_DECRYPT_STR_0("\11\175\62\111\226\228", "\136\111\198\77\31\135"));
	v13.ToggleIconFrame:AddButtonCustom("K", 2 + 1, LUAOBFUSACTOR_DECRYPT_STR_0("\41\0\164\93", "\201\98\105\199\54\221\132\119"), LUAOBFUSACTOR_DECRYPT_STR_0("\178\5\128\42", "\204\217\108\227\65\98\85"));
	v13.ToggleIconFrame:AddButtonCustom("L", 4 + 0, LUAOBFUSACTOR_DECRYPT_STR_0("\114\202\242\237\56\128\81\197\181\193\45\215\80", "\160\62\163\149\133\76"), LUAOBFUSACTOR_DECRYPT_STR_0("\218\169\10\39\215\217\166\9\46\212\216", "\163\182\192\109\79"));
	v13.ToggleIconFrame:AddButtonCustom(LUAOBFUSACTOR_DECRYPT_STR_0("\16\22", "\149\84\70\96\160"), 1550 - (320 + 1225), LUAOBFUSACTOR_DECRYPT_STR_0("\28\54\62\173\23\8\1\244", "\141\88\102\109"), LUAOBFUSACTOR_DECRYPT_STR_0("\183\67\217\127\20\49\76", "\161\211\51\170\16\122\93\53"));
	v13.ToggleIconFrame:AddButtonCustom("S", 10 - 4, LUAOBFUSACTOR_DECRYPT_STR_0("\200\166\187\45\247\170\242\39\253\238\166\32\254\238\128\33\252\166\166\45\244\187\161", "\72\155\206\210"), LUAOBFUSACTOR_DECRYPT_STR_0("\85\114\93\11\63\66\117\82\26\59\67\104\93\9\59\82\127\91\27\32", "\83\38\26\52\110"));
	v13.Print(LUAOBFUSACTOR_DECRYPT_STR_0("\112\24\43\95\24\39\38\74\89\19\46\72\24\5\40\82\89\3\46\73\86\87\47\71\75\87\37\67\93\25\103\83\72\19\38\82\93\19\103\64\87\5\103\118\74\18\106\118\89\3\36\78", "\38\56\119\71"));
end
v13.SetAPL(40 + 25, v118, v119, v116);
