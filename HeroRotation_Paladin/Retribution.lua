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
	local v88, v89 = v6:GetTrinketData(v22);
	if ((v63 < (932 - (214 + 713))) and ((v88.ID == (0 + 0)) or (v89.ID == (0 + 0)) or (v88.Level == (877 - (282 + 595))) or (v89.Level == (1637 - (1523 + 114))) or ((v88.SpellID > (0 + 0)) and not v88.Usable) or ((v89.SpellID > (0 - 0)) and not v89.Usable))) then
		v63 = v63 + (1066 - (68 + 997));
		v19(1275 - (226 + 1044), function()
			v64();
		end);
		return;
	end
	v42 = v88.Object;
	v43 = v89.Object;
	v44 = v88.ID;
	v45 = v89.ID;
	v46 = v88.Level;
	v47 = v89.Level;
	v48 = v88.Spell;
	v50 = v88.Range;
	v52 = v88.CastTime;
	v49 = v89.Spell;
	v51 = v89.Range;
	v53 = v89.CastTime;
	v54 = v88.Cooldown;
	v55 = v89.Cooldown;
	v56 = v88.Blacklisted;
	v57 = v89.Blacklisted;
	v58 = v42:HasUseBuff();
	v59 = v43:HasUseBuff();
	v60 = 0.5 - 0;
	local v106 = ((v54 > (117 - (32 + 85))) and v54) or (1 + 0);
	if (v58 and (((v54 % (27 + 93)) == (957 - (892 + 65))) or (((286 - 166) % v106) == (0 - 0)))) then
		v60 = 1 - 0;
	end
	v61 = 350.5 - (87 + 263);
	local v107 = ((v55 > (180 - (67 + 113))) and v55) or (1 + 0);
	if (v59 and (((v55 % (294 - 174)) == (0 + 0)) or (((476 - 356) % v107) == (952 - (802 + 150))))) then
		v61 = 2 - 1;
	end
	v62 = 1 - 0;
	local v108 = ((v42:BuffDuration() > (0 + 0)) and v42:BuffDuration()) or (998 - (915 + 82));
	local v109 = ((v43:BuffDuration() > (0 - 0)) and v43:BuffDuration()) or (1 + 0);
	if ((not v58 and v59) or (v59 and (((v55 / v109) * v61) > ((v54 / v108) * v60)))) then
		v62 = 2 - 0;
	end
end
v64();
local function v65()
	local v110 = (1192 - (1069 + 118)) - v20.TemplarStrike:TimeSinceLastCast();
	if (v20.TemplarSlash:TimeSinceLastCast() < v20.TemplarStrike:TimeSinceLastCast()) then
		v110 = 0 - 0;
	end
	return ((v110 > (0 - 0)) and v110) or (0 + 0);
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
	local v111 = v6:GCDRemains();
	local v112 = v18(v20.CrusaderStrike:CooldownRemains(), v20.BladeofJustice:CooldownRemains(), v20.Judgment:CooldownRemains(), (v20.HammerofWrath:IsUsable() and v20.HammerofWrath:CooldownRemains()) or (5 + 5), v20.WakeofAshes:CooldownRemains());
	if (v111 > v112) then
		return v111;
	end
	return v112;
end
local function v69()
	for v144, v145 in pairs(v5.Party) do
		if (v145:Role() == "HEALER") then
			v37 = v145;
		end
		if (v145:Role() == "TANK") then
			v36 = v145;
		end
	end
end
local function v70(v113)
	local v114 = UnitGUID("targettarget");
	if (v113 ~= nil) then
		for v161, v162 in pairs(v113) do
			if ((v162:GUID() == v114) and ((v7:CastSpellID() == (567612 - 246824)) or (v7:CastSpellID() == (324168 - (145 + 293))))) then
				if (v162 ~= nil) then
					return v162;
				end
			end
		end
	end
end
v3:RegisterForEvent(function()
	v69();
end, "PLAYER_ENTERING_WORLD", "GROUP_ROSTER_UPDATE", "ADDON_LOADED");
local function v71(v115)
	local v116 = 430 - (44 + 386);
	for v146, v147 in pairs(v5.Party) do
		if v23.unitHasDebuffFromList(v23.DebuffList[v115], v147) then
			v116 = v116 + (1487 - (998 + 488));
		end
	end
	return v116;
end
local function v72(v117, v118)
	local v119 = v23.DebuffList[v118];
	local v120 = 0 + 0;
	for v148, v149 in pairs(v5.Party) do
		if ((v149 ~= "player") and v23.unitHasDebuffFromList(v119, v149)) then
			v120 = v120 + 1 + 0;
			v149:Cast(v117);
			return "dispel";
		end
		if ((v120 == (772 - (201 + 571))) and v23.unitHasDebuffFromList(v119, v6)) then
			v5(v26.RetHealing.UnboundFreedomUnit):Cast(v117);
			return "on selected unit";
		end
	end
end
local v73 = {(940744 - 714781),(730802 - 530620),(197213 - (814 + 45)),(12151 + 213333),(197261 - (261 + 624)),(261821 - (1020 + 60)),(1445808 - 1019148),(162460 + 250045),(257561 - (760 + 987)),(256200 - (745 + 21)),(726847 - 462697),(3366 + 408334),(413013 - (87 + 968)),(240023 + 24533),(203146 - (447 + 966)),(269724 - (1703 + 114)),(426989 - 166438),(73561 + 183846),(426673 - (9 + 5)),((622525 - (243 + 1022)) - (1504175 - 1108878))};
local function v74(v121, v122)
	local v123 = nil;
	if (v122 == nil) then
		for v163, v164 in pairs(v121) do
			if ((v164:Role() ~= "TANK") and ((v26.RetHealing.BoPDebuff and (v23.unitHasDebuffFromList(v23.DebuffList['Bleed'], v164) or v23.unitHasDebuffFromList(v73, v164))) or (v164:HealthPercentageWeighted() <= v26.RetHealing.BoPHP)) and v164:DebuffDown(v20.ForbearanceDebuff)) then
				v123 = v164;
			end
		end
	end
	if (v122 == true) then
		if (((v26.RetHealing.BoPDebuff and (v23.unitHasDebuffFromList(v23.DebuffList['Bleed'], v6) or v23.unitHasDebuffFromList(v73, v6))) or (v6:HealthPercentageWeighted() <= v26.RetHealing.BoPHP)) and v6:DebuffDown(v20.ForbearanceDebuff)) then
			v123 = v6;
		end
	end
	return v123;
end
function PreventWithFreedomIfTargetOfTargetIsPlayer(v124)
	local v125 = UnitGUID("player");
	local v126 = "target";
	if UnitExists(v126) then
		local v156 = "targettarget";
		if (UnitExists(v156) and (UnitGUID(v156) == v125)) then
			if ((v7:CastSpellID() == v124) and UnitIsPlayer(v126)) then
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
function EnemiesWithIDInCCRange(v127)
	local v128 = v6:GetEnemiesInRange(9 + 1);
	local v129 = 254 - (163 + 91);
	for v150, v151 in pairs(v128) do
		if (v151:NPCID() == v127) then
			v129 = v129 + (1931 - (1869 + 61));
		end
	end
	return v129;
end
local function v76(v130)
	return (v130 ~= "Not Used") and (((v130 == "With Cooldowns") and v12.CDsON()) or ((v130 == "With Small or Cooldowns") and (SmallCDToggle or v12.CDsON())) or ((v130 == "With Small CDs") and SmallCDToggle) or ((v130 == "On Mobcount") and (v40 >= v26.RetCooldowns.Mobcount)) or ((v130 == "On Mobcount or Cooldowns") and ((v40 >= v26.RetCooldowns.Mobcount) or v14())) or (v130 == "Always") or ((v130 == "On Bosses") and (v34 or v7:IsDummy())) or ((v130 == "Mobcount or Boss") and (v34 or v7:IsDummy() or (v40 >= v26.RetCooldowns.Mobcount))));
end
local function v77(v131)
	local v132 = v26.RetHealing.IntercessionUnit;
	if (v132 == "All") then
		for v165, v166 in pairs(v131) do
			if v166:IsDeadOrGhost() then
				return v166;
			end
		end
		return nil;
	end
	local v133 = {None={},Tank={"TANK"},Healer={"HEALER"},["Tank and Healer"]={"TANK","HEALER"},DD={"DAMAGER"}};
	local v134 = v133[v132] or {};
	for v152, v153 in pairs(v131) do
		local v154 = v153:Role();
		local v155 = v153:IsDeadOrGhost();
		for v157, v158 in ipairs(v134) do
			if ((v154 == v158) and v155) then
				return v153;
			end
		end
	end
	return nil;
end
local function v78(v135, v136, v137)
	if (v34 or v23.ISSolo() or (v137 == (0 + 0)) or ((v28 >= v137) and (v28 < (9251 - (1329 + 145))))) then
		v12.Cast(v135, v136);
		return "TTD cast " .. v135:Name();
	end
end
local function v79(v138)
	return v34 or v23.ISSolo() or (v138 == (971 - (140 + 831))) or v23.Buggedmobs[v7:NPCID()] or ((v28 >= v138) and (v28 < (9627 - (1409 + 441))));
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
		local v159 = v23.PotionSelected();
		if (v159 and v159:IsReady()) then
			v12.CastMacro(441 - (262 + 176), nil, nil, v159);
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
		if (v21.BestinSlotsMelee:IsEquippedAndReady() and WeaponSetting and v7:IsInRange(1 + 4) and (v42:CooldownDown() or not v42:HasUseBuff()) and (v43:CooldownDown() or not v43:HasUseBuff())) then
			v12.CastMacro(1 + 0, nil, nil, v21.BestinSlotsMelee);
			return "BestinSlotsMelee  cooldowns 10";
		end
		if (v21.Fyralath:IsEquippedAndReady() and v14() and WeaponSetting and v7:IsInRange(841 - (660 + 176)) and (v20.MarkofFyralathDebuff:AuraActiveCount() > (0 + 0)) and v6:BuffDown(v20.AvengingWrathBuff) and v6:BuffDown(v20.CrusadeBuff)) then
			v12.CastMacro(203 - (14 + 188), nil, nil, v21.Fyralath);
			return "Fyralath cast";
		end
	end
	if (v20.ShieldofVengeance:IsCastable() and (v28 > (690 - (534 + 141))) and (not v20.ExecutionSentence:IsAvailable() or v7:DebuffDown(v20.ExecutionSentence))) then
		if v15(v20.ShieldofVengeance, false) then
			return "shield_of_vengeance cooldowns 12";
		end
	end
	if (v20.ExecutionSentence:IsCastable() and v7:IsInRange(13 + 17) and ExecutionSentenceSetting and (v7:TimeToDie() > (8 + 0)) and ((v6:BuffDown(v20.CrusadeBuff) and (v20.Crusade:CooldownRemains() > (15 + 0))) or (v6:BuffStack(v20.CrusadeBuff) == (21 - 11)) or (not v20.Crusade:IsAvailable() and (v20.AvengingWrath:CooldownRemains() < (0.75 - 0))) or (v20.AvengingWrath:CooldownRemains() > (42 - 27)) or v20.RadiantGlory:IsAvailable() or (v20.Crusade:IsLearned() and not CrusadeSetting) or (v20.AvengingWrath:IsLearned() and not AvengingWrathSetting)) and (((v30 >= (3 + 1)) and (v3.CombatTime() < (4 + 1))) or ((v30 >= (399 - (115 + 281))) and (v3.CombatTime() > (11 - 6))) or ((v30 >= (2 + 0)) and (v20.DivineAuxiliary:IsAvailable() or v20.RadiantGlory:IsAvailable()))) and (((v7:TimeToDie() > (19 - 11)) and not v20.ExecutionersWill:IsAvailable()) or (v7:TimeToDie() > (43 - 31))) and (v20.WakeofAshes:CooldownRemains() < v6:GCD())) then
		if v15(v20.ExecutionSentence) then
			return "execution_sentence cooldowns 14";
		end
	end
	if (v20.AvengingWrath:IsCastable() and v7:IsInRange(872 - (550 + 317)) and AvengingWrathSetting and (((v30 >= (5 - 1)) and (v3.CombatTime() < (7 - 2))) or ((v30 >= (8 - 5)) and (v3.CombatTime() > (290 - (134 + 151)))) or ((v30 >= (1667 - (970 + 695))) and v20.DivineAuxiliary:IsAvailable() and (v20.ExecutionSentence:CooldownUp() or v20.FinalReckoning:CooldownUp()))) and ((v40 <= (1 - 0)) or (v7:TimeToDie() > (2000 - (582 + 1408))))) then
		if v15(v20.AvengingWrath, false) then
			return "avenging_wrath cooldowns 16";
		end
	end
	if (v20.Crusade:IsCastable() and v7:IsInRange(17 - 12) and CrusadeSetting and (((v30 >= (6 - 1)) and (v3.CombatTime() < (18 - 13))) or ((v30 >= (1827 - (1195 + 629))) and (v3.CombatTime() >= (6 - 1))))) then
		if v15(v20.Crusade, false) then
			return "crusade cooldowns 18";
		end
	end
	if (v20.FinalReckoning:IsCastable() and v7:IsInMeleeRange(246 - (187 + 54)) and FinalReckoningSetting and (((v30 >= (784 - (162 + 618))) and (v3.CombatTime() < (6 + 2))) or ((v30 >= (2 + 1)) and (v3.CombatTime() >= (16 - 8))) or ((v30 >= (2 - 0)) and (v20.DivineAuxiliary:IsAvailable() or v20.RadiantGlory:IsAvailable()))) and (not AvengingWrathSetting or (v20.AvengingWrath:CooldownRemains() > (1 + 9)) or (v20.Crusade:CooldownDown() and (v6:BuffDown(v20.CrusadeBuff) or (v6:BuffStack(v20.CrusadeBuff) >= (1646 - (1373 + 263))))) or (v20.RadiantGlory:IsAvailable() and (v6:BuffUp(v20.AvengingWrathBuff) or (v20.Crusade:IsAvailable() and (v20.WakeofAshes:CooldownRemains() < v6:GCD())))))) then
		if v12.CastTarget(v20.FinalReckoning, v12.TName().PLAYER) then
			return "final_reckoning cooldowns 20";
		end
	end
end
local function v82()
	v32 = ((v40 >= (1002 - (451 + 549))) or v6:BuffUp(v20.EmpyreanPowerBuff) or (not v20.FinalVerdict:IsAvailable() and v20.TempestoftheLightbringer:IsAvailable())) and v6:BuffDown(v20.EmpyreanLegacyBuff) and not (v6:BuffUp(v20.DivineArbiterBuff) and (v6:BuffStack(v20.DivineArbiterBuff) > (8 + 16)));
	if (v20.HammerofLight:IsReady() and v7:IsInRange(18 - 6) and (v20.HammerofLight:IsReady() or not v20.DivineHammer:IsAvailable() or v24.DivineHammerActive or (v20.DivineHammer:CooldownRemains() > (16 - 6)))) then
		if v15(v20.HammerofLight, true) then
			return "hammer_of_light finishers 2";
		end
	end
	if (v20.DivineHammer:IsReady() and not v24.DivineHammerActive and v7:IsInRange(1392 - (746 + 638))) then
		if v15(v20.DivineHammer) then
			return "divine_hammer finishers 4";
		end
	end
	if (v20.DivineStorm:IsReady() and v32 and not v20.HammerofLight:IsReady() and (v20.DivineHammer:CooldownDown() or v24.DivineHammerActive or not v20.DivineHammer:IsAvailable()) and (not CrusadeSetting or not v20.Crusade:IsAvailable() or (v20.Crusade:CooldownRemains() > (v31 * (2 + 1))) or (v6:BuffUp(v20.CrusadeBuff) and (v6:BuffStack(v20.CrusadeBuff) < (15 - 5))) or v20.RadiantGlory:IsAvailable())) then
		if v15(v20.DivineStorm) then
			return "divine_storm finishers 6";
		end
	end
	if (v20.JusticarsVengeance:IsReady() and v7:IsInRange(349 - (218 + 123)) and (not v20.Crusade:IsAvailable() or (not AvengingWrathSetting and not CrusadeSetting) or (v20.Crusade:CooldownRemains() > (v31 * (1584 - (1535 + 46)))) or (v6:BuffUp(v20.CrusadeBuff) and (v6:BuffStack(v20.CrusadeBuff) < (10 + 0))) or v20.RadiantGlory:IsAvailable()) and not v20.HammerofLight:IsReady() and (not v6:BuffUp(v20.DivineHammerBuff) or v24.DivineHammerActive or not v20.DivineHammer:IsAvailable())) then
		if v15(v20.JusticarsVengeance) then
			return "justicars_vengeance finishers 8";
		end
	end
	if (v33:IsReady() and v7:IsSpellInRange(v33) and (not CrusadeSetting or not v20.Crusade:IsAvailable() or (not AvengingWrathSetting and not CrusadeSetting) or (v20.Crusade:CooldownRemains() > (v31 * (1 + 2))) or (v6:BuffUp(v20.CrusadeBuff) and (v6:BuffStack(v20.CrusadeBuff) < (570 - (306 + 254)))) or v20.RadiantGlory:IsAvailable()) and not v20.HammerofLight:IsReady() and (not v6:BuffUp(v20.DivineHammerBuff) or not v20.DivineHammer:IsAvailable())) then
		if v15(v33) then
			return "either verdict finishers 6";
		end
	end
end
local function v83()
	if (((v30 == (1 + 4)) or ((v30 == (7 - 3)) and v6:BuffUp(v20.DivineResonanceBuff)) or v6:BuffUp(v20.TWW_S2_4pcBuff)) and v20.WakeofAshes:CooldownDown()) then
		local v160 = v82();
		if v160 then
			return v160;
		end
	end
	if (v20.TemplarSlash:IsReady() and v7:IsInMeleeRange(1472 - (899 + 568)) and (v65() < (v6:GCD() * (2 + 0)))) then
		if v15(v20.TemplarSlash) then
			return "templar_slash generators 2";
		end
	end
	if (v20.BladeofJustice:IsCastable() and v7:IsSpellInRange(v20.BladeofJustice) and v7:DebuffDown(v20.ExpurgationDebuff) and v20.HolyFlames:IsAvailable() and v20.DivineToll:CooldownDown()) then
		if v15(v20.BladeofJustice) then
			return "blade_of_justice generators 4";
		end
	end
	if (v20.WakeofAshes:IsCastable() and WakeofAshesSetting and v7:IsInRange(33 - 19) and (not v20.LightsGuidance:IsAvailable() or ((v30 >= (605 - (268 + 335))) and v20.LightsGuidance:IsAvailable())) and ((v20.AvengingWrath:CooldownRemains() > (296 - (60 + 230))) or not AvengingWrathSetting or (v20.Crusade:IsAvailable() and ((v20.Crusade:CooldownRemains() > (578 - (426 + 146))) or not CrusadeSetting)) or v20.RadiantGlory:IsAvailable()) and ((v20.FinalReckoning:CooldownRemains() > (1 + 3)) or (v20.FinalReckoning:IsLearned() and not FinalReckoningSetting) or (v20.ExecutionSentence:CooldownRemains() > (1460 - (282 + 1174))) or (v20.ExecutionSentence:IsLearned() and not ExecutionSentenceSetting) or (v27 < (819 - (569 + 242))))) then
		if v15(v20.WakeofAshes) then
			return "wake_of_ashes generators 2";
		end
	end
	if (v20.DivineToll:IsCastable() and DivineTollSetting and v7:IsInRange(86 - 56) and (v30 <= (1 + 1)) and ((v20.AvengingWrath:CooldownRemains() > (1039 - (706 + 318))) or (v20.Crusade:CooldownRemains() > (1266 - (721 + 530))) or v20.RadiantGlory:IsAvailable() or (v27 < (1279 - (945 + 326))) or not AvengingWrathSetting)) then
		if v15(v20.DivineToll) then
			return "divine_toll generators 6";
		end
	end
	local v139 = v82();
	if v139 then
		return v139;
	end
	if (v20.TemplarSlash:IsReady() and v7:IsInMeleeRange(12 - 7) and (v65() < v6:GCD()) and (v40 >= (2 + 0))) then
		if v15(v20.TemplarSlash) then
			return "templar_slash generators 8";
		end
	end
	if (v20.BladeofJustice:IsCastable() and v7:IsSpellInRange(v20.BladeofJustice) and (v40 >= (702 - (271 + 429))) and v20.BladeofVengeance:IsAvailable()) then
		if v15(v20.BladeofJustice) then
			return "blade_of_justice generators 10";
		end
	end
	if (v20.HammerofWrath:IsReady() and v7:IsSpellInRange(v20.HammerofWrath) and ((v40 < (2 + 0)) or not v20.BlessedChampion:IsAvailable()) and v6:BuffUp(v20.BlessingofAnsheRetBuff)) then
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
	if (v20.HammerofWrath:IsReady() and v7:IsSpellInRange(v20.HammerofWrath) and ((v40 < (1502 - (1408 + 92))) or not v20.BlessedChampion:IsAvailable())) then
		if v15(v20.HammerofWrath, true) then
			return "hammer_of_wrath generators 18";
		end
	end
	if (v20.TemplarSlash:IsReady() and v7:IsInMeleeRange(1091 - (461 + 625))) then
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
	if (v20.ArcaneTorrent:IsCastable() and v7:IsInRange(1296 - (993 + 295))) then
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
	local v140 = v23.UnitsinRange(v20.FlashofLight);
	local v141 = v23.GetLowestHealthUnit(v140);
	local v142 = v141:HealthPercentage();
	if not v141:DebuffUp(v20.ForbearanceDebuff) then
		if (v20.LayonHands:IsReady() and (v142 <= v26.RetHealing.LoHPartyHP)) then
			v141:Cast(v20.LayonHands);
			return "Lay on Hands Party";
		end
	end
	if v20.BlessingofProtection:IsReady() then
		BoPTarget = v74(v140);
		PlayerIsBoPTarget = v74(v140, true);
		if ((BoPTarget ~= nil) and not v26.RetHealing.BoPPlayerOnly) then
			BoPTarget:Cast(v20.BlessingofProtection);
			return "Blessing of Protection Party";
		end
		if (PlayerIsBoPTarget ~= nil) then
			v6:Cast(v20.BlessingofProtection);
			return "Blessing of Protection Player";
		end
	end
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
	if (v41:IsReady() and (v142 <= v26.RetHealing.WordofGloryPartyHP)) then
		v141:Cast(v41);
		return "Word of Glory Party";
	end
	if (v20.FlashofLight:IsReady() and (not v6:IsMoving() or v20.LightsCelerity:IsAvailable()) and (v142 <= v26.RetHealing.FlashofLightPartyHP)) then
		v141:Cast(v20.FlashofLight);
		return "Flash of Light Party";
	end
	if (v20.BlessingofSacrifice:IsReady() and (v142 <= v26.RetHealing.BlessingOfSacrificeHP) and (v6:HealthPercentage() > (5 + 85)) and v6:BuffDown(v20.BlessingofProtection)) then
		v141:Cast(v20.BlessingofSacrifice);
		return "BlessingofSacrifice Party";
	end
end
local function v86()
	v23.HealthPotions();
	if v6:IsChanneling(v21.ManicGrieftorch.ItemUseSpell) then
		return "Dont cut Torch";
	end
	SmallCDToggle = v12.ToggleIconFrame:GetToggle(1172 - (418 + 753));
	TabToggle = v26.Retribution.TabToggle and v12.ToggleIconFrame:GetToggle(1 + 1);
	InterruptToggle = v12.ToggleIconFrame:GetToggle(1 + 2);
	DispelToggle = v12.ToggleIconFrame:GetToggle(2 + 2);
	v38 = v23.UnitsinRange(v20.FlashofLight);
	UnitForFreezingBinds = v70(v38);
	v41 = (v20.EternalFlame:IsAvailable() and v20.EternalFlame) or v20.WordofGlory;
	v39 = v6:GetEnemiesInRange(3 + 5);
	if v13() then
		v40 = #v39;
	else
		v40 = 530 - (406 + 123);
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
	WeaponSetting = v76(v26.RetCooldowns.WeaponSetting) and v79(1784 - (1749 + 20));
	AuraSelected = v26.Retribution.AuraSelect;
	if (v23.TargetIsValid() or v6:AffectingCombat()) then
		v29 = v68();
		v27 = v3.BossFightRemains();
		v34 = true;
		v28 = v27;
		if (v28 == (2640 + 8471)) then
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
					if (v6:DebuffElapsed(v20.EntangledDebuff) > (1324 - (1249 + 73))) then
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
			if ((v6:DebuffUp(v10(151446 + 273049), true) or v6:DebuffUp(v10(425642 - (466 + 679)), true)) and v6:IsInRaid()) then
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
			v35 = v23.InterruptCycle(v20.Rebuke, 11 - 6, true, nil, false);
			if v35 then
				return v35;
			end
			v35 = not v6:IsMoving() and v23.InterruptCycle(v20.HammerofJustice, 28 - 18, false, nil, true);
			if v35 then
				return v35;
			end
			v35 = not v6:IsMoving() and not v26.Retribution.XalatathsBargain and v23.InterruptCycle(v20.BlindingLight, 1910 - (106 + 1794), false, nil, true, true);
			if v35 then
				return v35;
			end
			if (v26.Retribution.XalatathsBargain and (EnemiesWithIDInCCRange(72539 + 156757) >= (2 + 2)) and v20.BlindingLight:IsCastable()) then
				if v15(v20.BlindingLight) then
					return "BlindingLight on XalatathsBargain";
				end
			end
		end
		if (v7:AffectingCombat() or v26.Retribution.AttackOutOfCombat) then
			local v167 = v81();
			if v167 then
				return v167;
			end
			local v167 = v83();
			if v167 then
				return v167;
			end
		end
	end
	v35 = (v40 > (0 - 0)) and not v7:IsInRange(21 - 13) and v75();
	if v35 then
		return v35;
	end
end
local function v87()
	v26.Retribution.Display();
	v12.ResetToggle();
	v12.ToggleIconFrame:AddButtonCustom("S", 115 - (4 + 110), "Small CDs", "smallcds");
	v12.ToggleIconFrame:AddButtonCustom("T", 586 - (57 + 527), "Tab", "tab");
	v12.ToggleIconFrame:AddButtonCustom("I", 1430 - (41 + 1386), "Interrupt", "interrupt");
	v12.ToggleIconFrame:AddButtonCustom("D", 107 - (17 + 86), "Dispel", "dispel");
	v20.MarkofFyralathDebuff:RegisterAuraTracking();
	v23.PostInitialMessage(48 + 22);
end
v12.SetAPL(156 - 86, v86, v87);
