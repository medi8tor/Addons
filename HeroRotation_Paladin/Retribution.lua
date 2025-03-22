local v0, v1 = ...;
local v2 = HeroDBC.DBC;
local v3 = HeroLib;
local v4 = HeroCache;
local v5 = v3.Unit;
local v6 = v5.Player;
local v7 = v5.Target;
local v8 = v5.MouseOver;
local v9 = v5.Pet;
local v10 = v3.Spell;
local v11 = v3.Item;
local v12 = HeroRotation();
local v13 = v12.AoEON;
local v14 = v12.CDsON;
local v15 = v12.Cast;
local v16 = v12.Commons().Everyone.num;
local v17 = v12.Commons().Everyone.bool;
local v18 = math.min;
local v19 = C_Timer.After;
local v20 = v10.Paladin.Retribution;
local v21 = v11.Paladin.Retribution;
local v22 = {v21.AlgetharPuzzleBox:ID(),v21.ShadowedRazingAnnihilator:ID()};
local v23 = v12.Commons().Everyone;
local v24 = v12.Commons().Paladin;
local v25 = v12.GUISettingsGet();
local v26 = {General=v25.General,Commons=v25.APL.Paladin.Commons,Retribution=v25.APL.Paladin.Retribution,RetCooldowns=v25.APL.Paladin.RetCooldowns,RetTTD=v25.APL.Paladin.RetTTD,RetHealing=v25.APL.Paladin.RetHealing};
local v27 = 21447 - 10336;
local v28 = 28620 - 17509;
local v29;
local v30 = 619 - (555 + 64);
local v31 = 931 - (857 + 74);
local v32;
local v33 = ((v20.FinalVerdict:IsLearned()) and v20.FinalVerdict) or v20.TemplarsVerdict;
local v34;
local v35;
local v36, v37;
local v38;
local v39, v40;
local v41 = (v20.EternalFlame:IsAvailable() and v20.EternalFlame) or v20.WordofGlory;
local v42, v43;
local v44, v45;
local v46, v47;
local v48, v49;
local v50, v51;
local v52, v53;
local v54, v55;
local v56, v57;
local v58, v59;
local v60, v61;
local v62;
local v63 = 568 - (367 + 201);
local function v64()
	local v89, v90 = v6:GetTrinketData(v22);
	if ((v63 < (932 - (214 + 713))) and ((v89.ID == (0 + 0)) or (v90.ID == (0 + 0)) or (v89.Level == (877 - (282 + 595))) or (v90.Level == (1637 - (1523 + 114))) or ((v89.SpellID > (0 + 0)) and not v89.Usable) or ((v90.SpellID > (0 - 0)) and not v90.Usable))) then
		v63 = v63 + (1066 - (68 + 997));
		v19(1275 - (226 + 1044), function()
			v64();
		end);
		return;
	end
	v42 = v89.Object;
	v43 = v90.Object;
	v44 = v89.ID;
	v45 = v90.ID;
	v46 = v89.Level;
	v47 = v90.Level;
	v48 = v89.Spell;
	v50 = v89.Range;
	v52 = v89.CastTime;
	v49 = v90.Spell;
	v51 = v90.Range;
	v53 = v90.CastTime;
	v54 = v89.Cooldown;
	v55 = v90.Cooldown;
	v56 = v89.Excluded;
	v57 = v90.Excluded;
	v58 = v42:HasUseBuff();
	v59 = v43:HasUseBuff();
	v60 = 0.5 - 0;
	local v107 = ((v54 > (117 - (32 + 85))) and v54) or (1 + 0);
	if (v58 and (((v54 % (27 + 93)) == (957 - (892 + 65))) or (((286 - 166) % v107) == (0 - 0)))) then
		v60 = 1 - 0;
	end
	v61 = 350.5 - (87 + 263);
	local v108 = ((v55 > (180 - (67 + 113))) and v55) or (1 + 0);
	if (v59 and (((v55 % (294 - 174)) == (0 + 0)) or (((476 - 356) % v108) == (952 - (802 + 150))))) then
		v61 = 2 - 1;
	end
	v62 = 1 - 0;
	local v109 = ((v42:BuffDuration() > (0 + 0)) and v42:BuffDuration()) or (998 - (915 + 82));
	local v110 = ((v43:BuffDuration() > (0 - 0)) and v43:BuffDuration()) or (1 + 0);
	if ((not v58 and v59) or (v59 and (((v55 / v110) * v61) > ((v54 / v109) * v60)))) then
		v62 = 2 - 0;
	end
end
v64();
local function v65()
	local v111 = (1192 - (1069 + 118)) - v20.TemplarStrike:TimeSinceLastCast();
	if (v20.TemplarSlash:TimeSinceLastCast() < v20.TemplarStrike:TimeSinceLastCast()) then
		v111 = 0 - 0;
	end
	return ((v111 > (0 - 0)) and v111) or (0 + 0);
end
v3:RegisterForEvent(function()
	Equip = v6:GetEquipment();
	v42 = (Equip[22 - 9] and v11(Equip[13 + 0])) or v11(791 - (368 + 423));
	v43 = (Equip[43 - 29] and v11(Equip[32 - (10 + 8)])) or v11(0 - 0);
end, "PLAYER_EQUIPMENT_CHANGED");
v3:RegisterForEvent(function()
	v27 = 11553 - (416 + 26);
	v28 = 35476 - 24365;
end, "PLAYER_REGEN_ENABLED");
v3:RegisterForEvent(function()
	v33 = ((v20.FinalVerdict:IsLearned()) and v20.FinalVerdict) or v20.TemplarsVerdict;
end, "SPELLS_CHANGED", "LEARNED_SPELL_IN_TAB");
local function v66()
	return v21.ManicGrieftorch:IsEquipped() and (v21.ManicGrieftorch:CooldownUp() or (v21.ManicGrieftorch:CooldownRemains() <= v6:GCDRemains()));
end
local function v67()
	return v21.AlgetharPuzzleBox:IsEquipped() and (v21.AlgetharPuzzleBox:CooldownUp() or (v21.AlgetharPuzzleBox:CooldownRemains() <= v6:GCDRemains()));
end
local function v68()
	local v112 = v6:GCDRemains();
	local v113 = v18(v20.CrusaderStrike:CooldownRemains(), v20.BladeofJustice:CooldownRemains(), v20.Judgment:CooldownRemains(), (v20.HammerofWrath:IsUsable() and v20.HammerofWrath:CooldownRemains()) or (5 + 5), v20.WakeofAshes:CooldownRemains());
	if (v112 > v113) then
		return v112;
	end
	return v113;
end
local function v69()
	for v145, v146 in pairs(v5.Party) do
		if (v146:Role() == "HEALER") then
			v37 = v146;
		end
		if (v146:Role() == "TANK") then
			v36 = v146;
		end
	end
end
local function v70(v114)
	local v115 = UnitGUID("targettarget");
	if (v114 ~= nil) then
		for v163, v164 in pairs(v114) do
			if ((v164:GUID() == v115) and ((v7:CastSpellID() == (567612 - 246824)) or (v7:CastSpellID() == (324168 - (145 + 293))))) then
				if (v164 ~= nil) then
					return v164;
				end
			end
		end
	end
end
v3:RegisterForEvent(function()
	v69();
end, "PLAYER_ENTERING_WORLD", "GROUP_ROSTER_UPDATE", "ADDON_LOADED");
local function v71(v116)
	local v117 = 430 - (44 + 386);
	for v147, v148 in pairs(v5.Party) do
		if v23.unitHasDebuffFromList(v23.DebuffList[v116], v148) then
			v117 = v117 + (1487 - (998 + 488));
		end
	end
	return v117;
end
local function v72(v118, v119)
	local v120 = v23.DebuffList[v119];
	local v121 = 0 + 0;
	for v149, v150 in pairs(v5.Party) do
		if ((v150 ~= "player") and v23.unitHasDebuffFromList(v120, v150)) then
			v121 = v121 + 1 + 0;
			v150:Cast(v118);
			return "dispel";
		end
		if ((v121 == (772 - (201 + 571))) and v23.unitHasDebuffFromList(v120, v6)) then
			v5(v26.RetHealing.UnboundFreedomUnit):Cast(v118);
			return "on selected unit";
		end
	end
end
local v73 = {(940744 - 714781),(730802 - 530620),(197213 - (814 + 45)),(12151 + 213333),(197261 - (261 + 624)),(261821 - (1020 + 60)),(1445808 - 1019148),(162460 + 250045),(257561 - (760 + 987)),(256200 - (745 + 21)),(726847 - 462697),(3366 + 408334),(413013 - (87 + 968)),(240023 + 24533),(203146 - (447 + 966)),(269724 - (1703 + 114)),(426989 - 166438),(73561 + 183846),(426673 - (9 + 5)),((622525 - (243 + 1022)) - (1504175 - 1108878))};
local function v74(v122, v123)
	local v124 = nil;
	if (v123 == nil) then
		for v165, v166 in pairs(v122) do
			if ((v166:Role() ~= "TANK") and ((v26.RetHealing.BoPDebuff and (v23.unitHasDebuffFromList(v23.DebuffList['Bleed'], v166) or v23.unitHasDebuffFromList(v73, v166))) or (v166:HealthPercentageWeighted() <= v26.RetHealing.BoPHP)) and v166:DebuffDown(v20.ForbearanceDebuff)) then
				v124 = v166;
			end
		end
	end
	if (v123 == true) then
		if (((v26.RetHealing.BoPDebuff and (v23.unitHasDebuffFromList(v23.DebuffList['Bleed'], v6) or v23.unitHasDebuffFromList(v73, v6))) or (v6:HealthPercentageWeighted() <= v26.RetHealing.BoPHP)) and v6:DebuffDown(v20.ForbearanceDebuff)) then
			v124 = v6;
		end
	end
	return v124;
end
function PreventWithFreedomIfTargetOfTargetIsPlayer(v125)
	local v126 = UnitGUID("player");
	local v127 = "target";
	if UnitExists(v127) then
		local v157 = "targettarget";
		if (UnitExists(v157) and (UnitGUID(v157) == v126)) then
			if ((v7:CastSpellID() == v125) and UnitIsPlayer(v127)) then
				return true;
			end
		end
	end
	return false;
end
local function v75()
	if (v25.General.AutoTab and v6:AffectingCombat()) then
		v12.TopPanelAlternative:ChangeIcon(1 + 0, 1183 - (1123 + 57));
		return "Auto tab to target";
	end
end
function EnemiesWithIDInCCRange(v128)
	local v129 = v6:GetEnemiesInRange(9 + 1);
	local v130 = 254 - (163 + 91);
	for v151, v152 in pairs(v129) do
		if (v152:NPCID() == v128) then
			v130 = v130 + (1931 - (1869 + 61));
		end
	end
	return v130;
end
local function v76(v131)
	return (v131 ~= "Not Used") and (((v131 == "With Cooldowns") and v12.CDsON()) or ((v131 == "With Small or Cooldowns") and (SmallCDToggle or v12.CDsON())) or ((v131 == "With Small CDs") and SmallCDToggle) or ((v131 == "On Mobcount") and (v40 >= v26.RetCooldowns.Mobcount)) or ((v131 == "On Mobcount or Cooldowns") and ((v40 >= v26.RetCooldowns.Mobcount) or v14())) or (v131 == "Always") or ((v131 == "On Bosses") and (v34 or v7:IsDummy())) or ((v131 == "Mobcount or Boss") and (v34 or v7:IsDummy() or (v40 >= v26.RetCooldowns.Mobcount))));
end
local function v77(v132)
	local v133 = v26.RetHealing.IntercessionUnit;
	if (v133 == "All") then
		for v167, v168 in pairs(v132) do
			if v168:IsDeadOrGhost() then
				return v168;
			end
		end
		return nil;
	end
	local v134 = {None={},Tank={"TANK"},Healer={"HEALER"},["Tank and Healer"]={"TANK","HEALER"},DD={"DAMAGER"}};
	local v135 = v134[v133] or {};
	for v153, v154 in pairs(v132) do
		local v155 = v154:Role();
		local v156 = v154:IsDeadOrGhost();
		for v158, v159 in ipairs(v135) do
			if ((v155 == v159) and v156) then
				return v154;
			end
		end
	end
	return nil;
end
local function v78(v136, v137, v138)
	if (v34 or v23.ISSolo() or (v138 == (0 + 0)) or ((v28 >= v138) and (v28 < (9251 - (1329 + 145))))) then
		v12.Cast(v136, v137);
		return "TTD cast " .. v136:Name();
	end
end
local function v79(v139)
	return v34 or v23.ISSolo() or (v139 == (971 - (140 + 831))) or v23.Buggedmobs[v7:NPCID()] or ((v28 >= v139) and (v28 < (9627 - (1409 + 441))));
end
local function v80()
	if (v33:IsReady() and (v30 >= (722 - (15 + 703))) and v7:IsSpellInRange(v33)) then
		if v15(v33) then
			return "either verdict precombat 2";
		end
	end
	if (v20.BladeofJustice:IsCastable() and v7:IsSpellInRange(v20.BladeofJustice)) then
		if v15(v20.BladeofJustice) then
			return "blade_of_justice precombat 4";
		end
	end
	if (v20.Judgment:IsCastable() and v7:IsSpellInRange(v20.Judgment)) then
		if v15(v20.Judgment, nil, nil, not v7:IsSpellInRange(v20.Judgment)) then
			return "judgment precombat 6";
		end
	end
	if (v20.HammerofWrath:IsReady() and v7:IsSpellInRange(v20.HammerofWrath)) then
		if v15(v20.HammerofWrath, true) then
			return "hammer_of_wrath precombat 8";
		end
	end
	if (v20.CrusaderStrike:IsCastable() and v7:IsSpellInRange(v20.CrusaderStrike)) then
		if v15(v20.CrusaderStrike) then
			return "crusader_strike 10";
		end
	end
end
local function v81()
	if (v26.Commons.Enabled.Potions and PotionSetting and ((AvengingWrathSetting and v6:BuffUp(v20.AvengingWrathBuff)) or (CrusadeSetting and v6:BuffUp(v20.CrusadeBuff)) or (ExecutionSentenceSetting and v7:DebuffUp(v20.ExecutionSentenceDebuff)) or (v27 < (14 + 16)))) then
		local v160 = v23.PotionSelected();
		if (v160 and v160:IsReady()) then
			v12.CastMacro(441 - (262 + 176), nil, nil, v160);
			return "Cast Potion";
		end
	end
	if (RacialsSetting and v20.LightsJudgment:IsCastable()) then
		if v15(v20.LightsJudgment, false, nil, not v7:IsInRange(1761 - (345 + 1376))) then
			return "lights_judgment cooldowns 4";
		end
	end
	if (RacialsSetting and v20.Fireblood:IsCastable() and (v6:BuffUp(v20.AvengingWrathBuff) or (v6:BuffUp(v20.CrusadeBuff) and (v6:BuffStack(v20.CrusadeBuff) == (698 - (198 + 490)))))) then
		if v15(v20.Fireblood, false) then
			return "fireblood cooldowns 6";
		end
	end
	if (v20.Fireblood:IsCastable() and v20.Fireblood:IsCastable() and (v6:BuffUp(v20.AvengingWrathBuff) or (v6:BuffUp(v20.CrusadeBuff) and (v6:BuffStack(v20.CrusadeBuff) == (44 - 34))) or v7:DebuffUp(v20.ExecutionSentenceDebuff))) then
		if v15(v20.Fireblood, false) then
			return "fireblood cooldowns 6";
		end
	end
	if v26.Commons.Enabled.Trinkets then
		if (v42:IsReady() and Trinket1Setting and not v56 and ((((((v20.Crusade:IsLearned() and not CrusadeSetting) or (v20.AvengingWrath:IsLearned() and not AvengingWrathSetting) or (v6:BuffUp(v20.AvengingWrathBuff) and (v20.AvengingWrath:CooldownRemains() > (95 - 55))) or (v6:BuffUp(v20.CrusadeBuff) and (v6:BuffStack(v20.CrusadeBuff) == (1216 - (696 + 510))))) and not v20.RadiantGlory:IsAvailable()) or (v20.RadiantGlory:IsAvailable() and ((not v20.ExecutionSentence:IsAvailable() and v20.WakeofAshes:CooldownUp()) or v7:DebuffUp(v20.ExecutionSentenceDebuff)))) and (not v43:HasCooldown() or v43:CooldownDown() or (v62 == (1 - 0)))) or (v42:BuffDuration() >= v28))) then
			if v15(v42) then
				return "use_item for trinket1 (" .. v42:Name() .. ") cooldowns 8";
			end
		end
		if (v43:IsReady() and Trinket2Setting and not v57 and ((((((v20.Crusade:IsLearned() and not CrusadeSetting) or (v20.AvengingWrath:IsLearned() and not AvengingWrathSetting) or (v6:BuffUp(v20.AvengingWrathBuff) and (v20.AvengingWrath:CooldownRemains() > (1302 - (1091 + 171)))) or (v6:BuffUp(v20.CrusadeBuff) and (v6:BuffStack(v20.CrusadeBuff) == (1 + 0)))) and not v20.RadiantGlory:IsAvailable()) or (v20.RadiantGlory:IsAvailable() and ((not v20.ExecutionSentence:IsAvailable() and v20.WakeofAshes:CooldownUp()) or v7:DebuffUp(v20.ExecutionSentenceDebuff)))) and (not v42:HasCooldown() or v42:CooldownDown() or (v62 == (6 - 4)))) or (v43:BuffDuration() >= v28))) then
			if v15(v43) then
				return "use_item for trinket2 (" .. v43:Name() .. ") cooldowns 8";
			end
		end
		if (v42:IsReady() and Trinket1Setting and not v56 and not v58 and (v43:CooldownDown() or not v59 or (v20.Crusade:IsLearned() and not CrusadeSetting) or (v20.AvengingWrath:IsLearned() and not AvengingWrathSetting) or (v6:BuffDown(v20.CrusadeBuff) and (v20.Crusade:CooldownRemains() > (66 - 46))) or (v6:BuffDown(v20.AvengingWrathBuff) and (v20.AvengingWrath:CooldownRemains() > (394 - (123 + 251)))))) then
			if v15(v42) then
				return "use_item for trinket1 (" .. v42:Name() .. ") cooldowns 10";
			end
		end
		if (v43:IsReady() and Trinket2Setting and not v57 and not v59 and (v42:CooldownDown() or not v58 or (v20.Crusade:IsLearned() and not CrusadeSetting) or (v20.AvengingWrath:IsLearned() and not AvengingWrathSetting) or (v6:BuffDown(v20.CrusadeBuff) and (v20.Crusade:CooldownRemains() > (99 - 79))) or (v6:BuffDown(v20.AvengingWrathBuff) and (v20.AvengingWrath:CooldownRemains() > (718 - (208 + 490)))))) then
			if v15(v43) then
				return "use_item for trinket2 (" .. v43:Name() .. ") cooldowns 12";
			end
		end
	end
	if v26.Commons.Enabled.Items then
		if (v21.BestinSlotsMelee:IsEquippedAndReady() and WeaponSetting and v7:IsInRange(1 + 4) and ((((v6:BuffUp(v20.AvengingWrathBuff) and (v20.AvengingWrath:CooldownRemains() > (18 + 22))) or (v6:BuffUp(v20.CrusadeBuff) and (v6:BuffStack(v20.CrusadeBuff) == (846 - (660 + 176))))) and not v20.RadiantGlory:IsAvailable()) or (v20.RadiantGlory:IsAvailable() and ((not v20.ExecutionSentence:IsAvailable() and v20.WakeofAshes:CooldownUp()) or v7:DebuffUp(v20.ExecutionSentenceDebuff))))) then
			v12.CastMacro(1 + 0, nil, nil, v21.BestinSlotsMelee);
			return "BestinSlotsMelee  cooldowns 10";
		end
		if (v21.Fyralath:IsEquippedAndReady() and v14() and WeaponSetting and v7:IsInRange(207 - (14 + 188)) and (v20.MarkofFyralathDebuff:AuraActiveCount() > (675 - (534 + 141))) and v6:BuffDown(v20.AvengingWrathBuff) and v6:BuffDown(v20.CrusadeBuff)) then
			v12.CastMacro(1 + 0, nil, nil, v21.Fyralath);
			return "Fyralath cast";
		end
	end
	if (v20.ShieldofVengeance:IsCastable() and (v28 > (14 + 1)) and (not v20.ExecutionSentence:IsAvailable() or v7:DebuffDown(v20.ExecutionSentence))) then
		if v15(v20.ShieldofVengeance, false) then
			return "shield_of_vengeance cooldowns 12";
		end
	end
	if (v20.ExecutionSentence:IsCastable() and v7:IsInRange(29 + 1) and ExecutionSentenceSetting and (v7:TimeToDie() > (16 - 8)) and ((v6:BuffDown(v20.CrusadeBuff) and (v20.Crusade:CooldownRemains() > (23 - 8))) or (v6:BuffStack(v20.CrusadeBuff) == (28 - 18)) or (not v20.Crusade:IsAvailable() and (v20.AvengingWrath:CooldownRemains() < (0.75 + 0))) or (v20.AvengingWrath:CooldownRemains() > (10 + 5)) or v20.RadiantGlory:IsAvailable() or (v20.Crusade:IsLearned() and not CrusadeSetting) or (v20.AvengingWrath:IsLearned() and not AvengingWrathSetting)) and (((v30 >= (400 - (115 + 281))) and (v3.CombatTime() < (11 - 6))) or ((v30 >= (3 + 0)) and (v3.CombatTime() > (12 - 7))) or ((v30 >= (7 - 5)) and (v20.DivineAuxiliary:IsAvailable() or v20.RadiantGlory:IsAvailable()))) and (((v7:TimeToDie() > (875 - (550 + 317))) and not v20.ExecutionersWill:IsAvailable()) or (v7:TimeToDie() > (16 - 4))) and (v20.WakeofAshes:CooldownRemains() < v6:GCD())) then
		if v15(v20.ExecutionSentence) then
			return "execution_sentence cooldowns 14";
		end
	end
	if (v20.AvengingWrath:IsCastable() and v7:IsInRange(7 - 2) and AvengingWrathSetting and (((v30 >= (11 - 7)) and (v3.CombatTime() < (290 - (134 + 151)))) or ((v30 >= (1668 - (970 + 695))) and (v3.CombatTime() > (9 - 4))) or ((v30 >= (1992 - (582 + 1408))) and v20.DivineAuxiliary:IsAvailable() and (v20.ExecutionSentence:CooldownUp() or v20.FinalReckoning:CooldownUp()))) and ((v40 <= (3 - 2)) or (v7:TimeToDie() > (12 - 2)))) then
		if v15(v20.AvengingWrath, false) then
			return "avenging_wrath cooldowns 16";
		end
	end
	if (v20.Crusade:IsCastable() and v7:IsInRange(18 - 13) and CrusadeSetting and (((v30 >= (1829 - (1195 + 629))) and (v3.CombatTime() < (6 - 1))) or ((v30 >= (244 - (187 + 54))) and (v3.CombatTime() >= (785 - (162 + 618)))))) then
		if v15(v20.Crusade, false) then
			return "crusade cooldowns 18";
		end
	end
	if (v20.FinalReckoning:IsCastable() and v7:IsInMeleeRange(4 + 1) and FinalReckoningSetting and (((v30 >= (3 + 1)) and (v3.CombatTime() < (16 - 8))) or ((v30 >= (4 - 1)) and (v3.CombatTime() >= (1 + 7))) or ((v30 >= (1638 - (1373 + 263))) and (v20.DivineAuxiliary:IsAvailable() or v20.RadiantGlory:IsAvailable()))) and (not AvengingWrathSetting or (v20.AvengingWrath:CooldownRemains() > (1010 - (451 + 549))) or (v20.Crusade:CooldownDown() and (v6:BuffDown(v20.CrusadeBuff) or (v6:BuffStack(v20.CrusadeBuff) >= (4 + 6)))) or (v20.RadiantGlory:IsAvailable() and (v6:BuffUp(v20.AvengingWrathBuff) or (v20.Crusade:IsAvailable() and (v20.WakeofAshes:CooldownRemains() < v6:GCD())))))) then
		if v12.CastTarget(v20.FinalReckoning, v12.TName().PLAYER) then
			return "final_reckoning cooldowns 20";
		end
	end
end
local function v82()
	v32 = ((v40 >= (2 - 0)) or v6:BuffUp(v20.EmpyreanPowerBuff) or (not v20.FinalVerdict:IsAvailable() and v20.TempestoftheLightbringer:IsAvailable())) and v6:BuffDown(v20.EmpyreanLegacyBuff) and not (v6:BuffUp(v20.DivineArbiterBuff) and (v6:BuffStack(v20.DivineArbiterBuff) > (39 - 15)));
	if (v20.HammerofLight:IsReady() and v7:IsInRange(1396 - (746 + 638)) and (v20.HammerofLight:IsReady() or not v20.DivineHammer:IsAvailable() or v24.DivineHammerActive or (v20.DivineHammer:CooldownRemains() > (4 + 6)))) then
		if v15(v20.HammerofLight, true) then
			return "hammer_of_light finishers 2";
		end
	end
	if (v20.DivineHammer:IsReady() and not v24.DivineHammerActive and v7:IsInRange(11 - 3)) then
		if v15(v20.DivineHammer) then
			return "divine_hammer finishers 4";
		end
	end
	if (v20.DivineStorm:IsReady() and v32 and not v20.HammerofLight:IsReady() and (v20.DivineHammer:CooldownDown() or v24.DivineHammerActive or not v20.DivineHammer:IsAvailable()) and (not CrusadeSetting or not v20.Crusade:IsAvailable() or (v20.Crusade:CooldownRemains() > (v31 * (344 - (218 + 123)))) or (v6:BuffUp(v20.CrusadeBuff) and (v6:BuffStack(v20.CrusadeBuff) < (1591 - (1535 + 46)))) or v20.RadiantGlory:IsAvailable())) then
		if v15(v20.DivineStorm) then
			return "divine_storm finishers 6";
		end
	end
	if (v20.JusticarsVengeance:IsReady() and v7:IsInRange(8 + 0) and (not v20.Crusade:IsAvailable() or (not AvengingWrathSetting and not CrusadeSetting) or (v20.Crusade:CooldownRemains() > (v31 * (1 + 2))) or (v6:BuffUp(v20.CrusadeBuff) and (v6:BuffStack(v20.CrusadeBuff) < (570 - (306 + 254)))) or v20.RadiantGlory:IsAvailable()) and not v20.HammerofLight:IsReady() and (not v6:BuffUp(v20.DivineHammerBuff) or v24.DivineHammerActive or not v20.DivineHammer:IsAvailable())) then
		if v15(v20.JusticarsVengeance) then
			return "justicars_vengeance finishers 8";
		end
	end
	if (v33:IsReady() and v7:IsSpellInRange(v33) and (not CrusadeSetting or not v20.Crusade:IsAvailable() or (not AvengingWrathSetting and not CrusadeSetting) or (v20.Crusade:CooldownRemains() > (v31 * (1 + 2))) or (v6:BuffUp(v20.CrusadeBuff) and (v6:BuffStack(v20.CrusadeBuff) < (19 - 9))) or v20.RadiantGlory:IsAvailable()) and not v20.HammerofLight:IsReady() and (not v6:BuffUp(v20.DivineHammerBuff) or not v20.DivineHammer:IsAvailable())) then
		if v15(v33) then
			return "either verdict finishers 6";
		end
	end
end
local function v83()
	if (((v30 == (1472 - (899 + 568))) or ((v30 == (3 + 1)) and v6:BuffUp(v20.DivineResonanceBuff)) or v6:BuffUp(v20.TWW_S2_4pcBuff)) and v20.WakeofAshes:CooldownDown()) then
		local v161 = v82();
		if v161 then
			return v161;
		end
	end
	if (v20.TemplarSlash:IsReady() and v7:IsInMeleeRange(12 - 7) and (v65() < (v6:GCD() * (605 - (268 + 335))))) then
		if v15(v20.TemplarSlash) then
			return "templar_slash generators 2";
		end
	end
	if (v20.BladeofJustice:IsCastable() and v7:IsSpellInRange(v20.BladeofJustice) and v7:DebuffDown(v20.ExpurgationDebuff) and v20.HolyFlames:IsAvailable() and v20.DivineToll:CooldownDown()) then
		if v15(v20.BladeofJustice) then
			return "blade_of_justice generators 4";
		end
	end
	if (v20.WakeofAshes:IsCastable() and WakeofAshesSetting and v7:IsInRange(304 - (60 + 230)) and (not v20.LightsGuidance:IsAvailable() or ((v30 >= (574 - (426 + 146))) and v20.LightsGuidance:IsAvailable())) and ((v20.AvengingWrath:CooldownRemains() > (1 + 5)) or not AvengingWrathSetting or (v20.Crusade:IsAvailable() and ((v20.Crusade:CooldownRemains() > (1462 - (282 + 1174))) or not CrusadeSetting)) or v20.RadiantGlory:IsAvailable()) and ((v20.FinalReckoning:CooldownRemains() > (815 - (569 + 242))) or (v20.FinalReckoning:IsLearned() and not FinalReckoningSetting) or (v20.ExecutionSentence:CooldownRemains() > (11 - 7)) or (v20.ExecutionSentence:IsLearned() and not ExecutionSentenceSetting) or (v27 < (1 + 7)))) then
		if v15(v20.WakeofAshes) then
			return "wake_of_ashes generators 2";
		end
	end
	if (v20.DivineToll:IsCastable() and DivineTollSetting and v7:IsInRange(1054 - (706 + 318)) and (v30 <= (1253 - (721 + 530))) and ((v20.AvengingWrath:CooldownRemains() > (1286 - (945 + 326))) or (v20.Crusade:CooldownRemains() > (37 - 22)) or v20.RadiantGlory:IsAvailable() or (v27 < (8 + 0)) or not AvengingWrathSetting)) then
		if v15(v20.DivineToll) then
			return "divine_toll generators 6";
		end
	end
	local v140 = v82();
	if v140 then
		return v140;
	end
	if (v20.TemplarSlash:IsReady() and v7:IsInMeleeRange(705 - (271 + 429)) and (v65() < v6:GCD()) and (v40 >= (2 + 0))) then
		if v15(v20.TemplarSlash) then
			return "templar_slash generators 8";
		end
	end
	if (v20.BladeofJustice:IsCastable() and v7:IsSpellInRange(v20.BladeofJustice) and (v40 >= (1502 - (1408 + 92))) and v20.BladeofVengeance:IsAvailable()) then
		if v15(v20.BladeofJustice) then
			return "blade_of_justice generators 10";
		end
	end
	if (v20.HammerofWrath:IsReady() and v7:IsSpellInRange(v20.HammerofWrath) and ((v40 < (1088 - (461 + 625))) or not v20.BlessedChampion:IsAvailable()) and v6:BuffUp(v20.BlessingofAnsheRetBuff)) then
		if v15(v20.HammerofWrath, true) then
			return "hammer_of_wrath generators 12";
		end
	end
	if (v20.TemplarStrike:IsReady() and v7:IsSpellInRange(v20.TemplarStrike)) then
		if v15(v20.TemplarStrike) then
			return "templar_strike generators 14";
		end
	end
	if (v20.Judgment:IsReady() and v7:IsSpellInRange(v20.Judgment)) then
		if v15(v20.Judgment, nil, nil, not v7:IsSpellInRange(v20.Judgment)) then
			return "judgment generators 18";
		end
	end
	if (v20.BladeofJustice:IsCastable() and v7:IsSpellInRange(v20.BladeofJustice)) then
		if v15(v20.BladeofJustice) then
			return "blade_of_justice generators 16";
		end
	end
	if (v20.HammerofWrath:IsReady() and v7:IsSpellInRange(v20.HammerofWrath) and ((v40 < (1290 - (993 + 295))) or not v20.BlessedChampion:IsAvailable())) then
		if v15(v20.HammerofWrath, true) then
			return "hammer_of_wrath generators 18";
		end
	end
	if (v20.TemplarSlash:IsReady() and v7:IsInMeleeRange(1 + 4)) then
		if v15(v20.TemplarSlash) then
			return "templar_slash generators 20";
		end
	end
	if (v20.CrusaderStrike:IsCastable() and v7:IsSpellInRange(v20.CrusaderStrike)) then
		if v15(v20.CrusaderStrike) then
			return "crusader_strike generators 26";
		end
	end
	if (v20.HammerofWrath:IsReady() and v7:IsSpellInRange(v20.HammerofWrath)) then
		if v15(v20.HammerofWrath, true) then
			return "hammer_of_wrath generators 28";
		end
	end
	if (v20.ArcaneTorrent:IsCastable() and v7:IsInRange(1179 - (418 + 753))) then
		if v15(v20.ArcaneTorrent) then
			return "arcane_torrent generators 28";
		end
	end
end
local function v84()
	if ((v6:HealthPercentage() <= v26.RetHealing.LoHHP) and v20.LayonHands:IsCastable() and not v6:DebuffUp(v20.ForbearanceDebuff)) then
		if v15(v20.LayonHands, true) then
			return "lay_on_hands defensive";
		end
	end
	if ((v6:HealthPercentage() <= v26.RetHealing.BubbleHP) and v20.DivineShield:IsCastable() and not v6:DebuffUp(v20.ForbearanceDebuff)) then
		if v15(v20.DivineShield, true) then
			return "Divine Shield defensive";
		end
	end
	if ((v6:HealthPercentage() <= v26.RetHealing.WordofGloryPlayerHP) and v41:IsReady()) then
		if v15(v41, true) then
			return "Word of Glory defensive";
		end
	end
	if ((v6:HealthPercentage() <= v26.RetHealing.FlashofLightPlayerHP) and (not v6:IsMoving() or v20.LightsCelerity:IsAvailable()) and v20.FlashofLight:IsReady()) then
		if v15(v20.FlashofLight, true) then
			return "Flash of Light defensive";
		end
	end
	if ((v6:HealthPercentage() <= v26.RetHealing.ShieldofVengeanceHP) and v20.ShieldofVengeance:IsCastable()) then
		if v15(v20.ShieldofVengeance, true) then
			return "shield of vengeance defensive";
		end
	end
	if ((v6:HealthPercentage() <= v26.RetHealing.DivineProtectionHP) and v20.DivineProtection:IsCastable()) then
		if v15(v20.DivineProtectionCast, true) then
			return "Divine Protection defensive";
		end
	end
end
local function v85()
	local v141 = v23.UnitsinRange(v20.FlashofLight);
	local v142 = v23.GetLowestHealthUnit(v141);
	local v143 = v142:HealthPercentage();
	if not v142:DebuffUp(v20.ForbearanceDebuff) then
		if (v20.LayonHands:IsReady() and (v143 <= v26.RetHealing.LoHPartyHP)) then
			v142:Cast(v20.LayonHands);
			return "Lay on Hands Party";
		end
	end
	if v20.BlessingofProtection:IsReady() then
		BoPTarget = v74(v141);
		PlayerIsBoPTarget = v74(v141, true);
		if ((BoPTarget ~= nil) and not v26.RetHealing.BoPPlayerOnly) then
			BoPTarget:Cast(v20.BlessingofProtection);
			return "Blessing of Protection Party";
		end
		if (PlayerIsBoPTarget ~= nil) then
			v6:Cast(v20.BlessingofProtection);
			return "Blessing of Protection Player";
		end
	end
	if (v41:IsReady() and (v143 <= v26.RetHealing.WordofGloryPartyHP)) then
		v142:Cast(v41);
		return "Word of Glory Party";
	end
	if (v20.FlashofLight:IsReady() and (not v6:IsMoving() or v20.LightsCelerity:IsAvailable()) and (v143 <= v26.RetHealing.FlashofLightPartyHP)) then
		v142:Cast(v20.FlashofLight);
		return "Flash of Light Party";
	end
	if (v20.BlessingofSacrifice:IsReady() and (v143 <= v26.RetHealing.BlessingOfSacrificeHP) and (v6:HealthPercentage() > (35 + 55)) and v6:BuffDown(v20.BlessingofProtection)) then
		v142:Cast(v20.BlessingofSacrifice);
		return "BlessingofSacrifice Party";
	end
end
local function v86()
	if v6:AffectingCombat() then
		if (v20.Intercession:IsReady() and not v6:IsMoving()) then
			if (v8:UnitIsFriend() and v8:UnitIsPlayer() and v8:Exists() and v8:IsDeadOrGhost()) then
				v12.CastTarget(v20.Intercession, v12.TName().MOUSEOVER);
				return "Intercession on Mouseover";
			end
			if (v26.RetHealing.IntercessionTarget and v7:UnitIsFriend() and v7:Exists() and v7:IsDeadOrGhost()) then
				v12.Cast(v20.Intercession);
				return "Intercession on Target";
			end
		end
	end
end
local function v87()
	v23.HealthPotions();
	if v6:IsChanneling(v21.ManicGrieftorch.ItemUseSpell) then
		return "Dont cut Torch";
	end
	if (v6:IsInParty() or v6:IsInRaid()) then
		local v162 = v86();
		if v162 then
			return v162;
		end
	end
	SmallCDToggle = v12.ToggleIconFrame:GetToggle(1 + 0);
	TabToggle = v26.Retribution.TabToggle and v12.ToggleIconFrame:GetToggle(1 + 1);
	InterruptToggle = v12.ToggleIconFrame:GetToggle(1 + 2);
	DispelToggle = v12.ToggleIconFrame:GetToggle(533 - (406 + 123));
	v38 = v23.UnitsinRange(v20.FlashofLight);
	UnitForFreezingBinds = v70(v38);
	v41 = (v20.EternalFlame:IsAvailable() and v20.EternalFlame) or v20.WordofGlory;
	v39 = v6:GetEnemiesInRange(1777 - (1749 + 20));
	if v13() then
		v40 = #v39;
	else
		v40 = 1 + 0;
	end
	RacialsSetting = v76(v26.RetCooldowns.RacialsSetting) and v79(v26.RetTTD.RacialsTTD);
	Trinket1Setting = v76(v26.RetCooldowns.Trinket1Setting) and v79(v26.RetTTD.TrinketsTTD);
	Trinket2Setting = v76(v26.RetCooldowns.Trinket2Setting) and v79(v26.RetTTD.TrinketsTTD);
	PotionSetting = v76(v26.RetCooldowns.PotionSetting) and not v23.ISSolo();
	DivineTollSetting = v76(v26.RetCooldowns.DivineTollSetting) and v79(v26.RetTTD.DivineTollTTD);
	AvengingWrathSetting = v76(v26.RetCooldowns.AvengingWrathSetting) and v79(v26.RetTTD.AvengingWrathTTD);
	ExecutionSentenceSetting = v76(v26.RetCooldowns.ExecutionSentenceSetting) and v79(v26.RetTTD.ExecutionSentenceTTD);
	FinalReckoningSetting = v76(v26.RetCooldowns.FinalReckoningSetting) and v79(v26.RetTTD.FinalReckoningTTD);
	CrusadeSetting = v76(v26.RetCooldowns.CrusadeSetting) and v79(v26.RetTTD.CrusadeTTD);
	WakeofAshesSetting = v76(v26.RetCooldowns.WakeofAshesSetting) and v79(v26.RetTTD.WakeofAshesTTD);
	WeaponSetting = v76(v26.RetCooldowns.WeaponSetting) and v79(1337 - (1249 + 73));
	AuraSelected = v26.Retribution.AuraSelect;
	if (v23.TargetIsValid() or v6:AffectingCombat()) then
		v29 = v68();
		v27 = v3.BossFightRemains();
		v34 = true;
		v28 = v27;
		if (v28 == (3965 + 7146)) then
			v34 = false;
			v28 = v3.FightRemains(v39, false);
		end
		v31 = v6:GCD();
		v30 = v6:HolyPower();
	end
	if (v20.DevotionAura:IsReady() and (AuraSelected == "Devotion Aura") and v6:BuffDown(v20.DevotionAura, true)) then
		v15(v20.DevotionAura);
		return "Devotion Aura";
	end
	if (v20.CrusaderAura:IsReady() and (AuraSelected == "Crusader Aura") and v6:BuffDown(v20.CrusaderAura, true)) then
		v15(v20.CrusaderAura);
		return "Crusader Aura";
	end
	if (v20.ConcentrationAura:IsReady() and (AuraSelected == "Concentration Aura") and v6:BuffDown(v20.ConcentrationAura, true)) then
		v15(v20.ConcentrationAura);
		return "Concentration Aura";
	end
	if v6:AffectingCombat() then
		v35 = v84();
		if v35 then
			return v35;
		end
	end
	if (v6:IsInParty() and not v6:IsInRaid()) then
		v35 = v85();
		if v35 then
			return v35;
		end
		if (v20.CleanseToxins:IsReady() and v26.Retribution.UseCleanse and DispelToggle) then
			v35 = v23.DispelCycle(v20.CleanseToxins, "Poison");
			if v35 then
				return v35;
			end
			v35 = v23.DispelCycle(v20.CleanseToxins, "Disease");
			if v35 then
				return v35;
			end
			v35 = v23.AfflictedLogic(v20.CleanseToxins);
			if v35 then
				return v35;
			end
		end
		if v20.BlessingofFreedom:IsReady() then
			if (v6:IsInParty() and not v6:IsInRaid() and v26.Retribution.UseBoF) then
				if UnitForFreezingBinds then
					if UnitForFreezingBinds:Cast(v20.BlessingofFreedom) then
						return "Blessing of Freedom Frozen Binds";
					end
				end
				if v20.UnboundFreedom:IsAvailable() then
					if (v23.unitHasDebuffFromList(v23.DebuffList['Entangled'], v5(v26.RetHealing.UnboundFreedomUnit)) or v23.unitHasDebuffFromList(v23.DebuffList['Entangled'], v6)) then
						v5(v26.RetHealing.UnboundFreedomUnit):Cast(v20.BlessingofFreedom);
						return "BoF on " .. v26.RetHealing.UnboundFreedomUnit;
					end
					v35 = v72(v20.BlessingofFreedom, "RootDispel");
					if v35 then
						return v35;
					end
					v35 = v72(v20.BlessingofFreedom, "SnareRoot");
					if v35 then
						return v35;
					end
					v35 = v72(v20.BlessingofFreedom, "FreedomDispel");
					if v35 then
						return v35;
					end
				else
					if (v6:DebuffElapsed(v20.EntangledDebuff) > (1147 - (466 + 679))) then
						if v6:Cast(v20.BlessingofFreedom) then
							return "Blessing of Freedom entangling";
						end
					end
					v35 = v23.DispelCycle(v20.BlessingofFreedom, "RootDispel", nil, v38);
					if v35 then
						return v35;
					end
					v35 = v23.DispelCycle(v20.BlessingofFreedom, "SnareRoot", nil, v38);
					if v35 then
						return v35;
					end
					v35 = v23.DispelCycle(v20.BlessingofFreedom, "FreedomDispel", nil, v38);
					if v35 then
						return v35;
					end
				end
			end
			if (v23.unitHasDebuffFromList(v23.DebuffList['RootDispel'], v6) or v23.unitHasDebuffFromList(v23.DebuffList['SnareRoot'], v6) or v23.unitHasDebuffFromList(v23.DebuffList['FreedomDispel'], v6)) then
				v6:Cast(v20.BlessingofFreedom);
				return "BoF on Player";
			end
			if ((v6:DebuffUp(v10(1021109 - 596614), true) or v6:DebuffUp(v10(1214140 - 789643), true)) and v6:IsInRaid()) then
				v6:Cast(v20.BlessingofFreedom);
				return;
			end
		end
	end
	if v23.TargetIsValid() then
		if (not v6:AffectingCombat() and v26.Retribution.AttackOutOfCombat) then
			v35 = v80();
			if v35 then
				return v35;
			end
		end
		if InterruptToggle then
			v35 = v23.InterruptCycle(v20.Rebuke, 1905 - (106 + 1794), true, nil, false);
			if v35 then
				return v35;
			end
			v35 = not v6:IsMoving() and v23.InterruptCycle(v20.HammerofJustice, 4 + 6, false, nil, true);
			if v35 then
				return v35;
			end
			v35 = not v6:IsMoving() and not v26.Retribution.XalatathsBargain and v23.InterruptCycle(v20.BlindingLight, 3 + 7, false, nil, true, true);
			if v35 then
				return v35;
			end
			if (v26.Retribution.XalatathsBargain and (EnemiesWithIDInCCRange(676973 - 447677) >= (10 - 6)) and v20.BlindingLight:IsCastable()) then
				if v15(v20.BlindingLight) then
					return "BlindingLight on XalatathsBargain";
				end
			end
		end
		if (v7:AffectingCombat() or v26.Retribution.AttackOutOfCombat) then
			local v169 = v81();
			if v169 then
				return v169;
			end
			local v169 = v83();
			if v169 then
				return v169;
			end
		end
	end
	v35 = (v40 > (114 - (4 + 110))) and not v7:IsInRange(592 - (57 + 527)) and v75();
	if v35 then
		return v35;
	end
end
local function v88()
	v26.Retribution.Display();
	v12.ResetToggle();
	v12.ToggleIconFrame:AddButtonCustom("S", 1428 - (41 + 1386), "Small CDs", "smallcds");
	v12.ToggleIconFrame:AddButtonCustom("T", 105 - (17 + 86), "Tab", "tab");
	v12.ToggleIconFrame:AddButtonCustom("I", 3 + 0, "Interrupt", "interrupt");
	v12.ToggleIconFrame:AddButtonCustom("D", 8 - 4, "Dispel", "dispel");
	v20.MarkofFyralathDebuff:RegisterAuraTracking();
	v23.PostInitialMessage(202 - 132);
end
v12.SetAPL(236 - (122 + 44), v87, v88);
