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
	local v90, v91 = v6:GetTrinketData(v22);
	if ((v63 < (932 - (214 + 713))) and ((v90.ID == (0 + 0)) or (v91.ID == (0 + 0)) or (v90.Level == (877 - (282 + 595))) or (v91.Level == (1637 - (1523 + 114))) or ((v90.SpellID > (0 + 0)) and not v90.Usable) or ((v91.SpellID > (0 - 0)) and not v91.Usable))) then
		v63 = v63 + (1066 - (68 + 997));
		v19(1275 - (226 + 1044), function()
			v64();
		end);
		return;
	end
	v42 = v90.Object;
	v43 = v91.Object;
	v44 = v90.ID;
	v45 = v91.ID;
	v46 = v90.Level;
	v47 = v91.Level;
	v48 = v90.Spell;
	v50 = v90.Range;
	v52 = v90.CastTime;
	v49 = v91.Spell;
	v51 = v91.Range;
	v53 = v91.CastTime;
	v54 = v90.Cooldown;
	v55 = v91.Cooldown;
	v56 = v90.Excluded;
	v57 = v91.Excluded;
	v58 = v42:HasUseBuff();
	v59 = v43:HasUseBuff();
	v60 = 0.5 - 0;
	local v108 = ((v54 > (117 - (32 + 85))) and v54) or (1 + 0);
	if (v58 and (((v54 % (27 + 93)) == (957 - (892 + 65))) or (((286 - 166) % v108) == (0 - 0)))) then
		v60 = 1 - 0;
	end
	v61 = 350.5 - (87 + 263);
	local v109 = ((v55 > (180 - (67 + 113))) and v55) or (1 + 0);
	if (v59 and (((v55 % (294 - 174)) == (0 + 0)) or (((476 - 356) % v109) == (952 - (802 + 150))))) then
		v61 = 2 - 1;
	end
	v62 = 1 - 0;
	local v110 = ((v42:BuffDuration() > (0 + 0)) and v42:BuffDuration()) or (998 - (915 + 82));
	local v111 = ((v43:BuffDuration() > (0 - 0)) and v43:BuffDuration()) or (1 + 0);
	if ((not v58 and v59) or (v59 and (((v55 / v111) * v61) > ((v54 / v110) * v60)))) then
		v62 = 2 - 0;
	end
end
v64();
local function v65()
	local v112 = (1192 - (1069 + 118)) - v20.TemplarStrike:TimeSinceLastCast();
	if (v20.TemplarSlash:TimeSinceLastCast() < v20.TemplarStrike:TimeSinceLastCast()) then
		v112 = 0 - 0;
	end
	return ((v112 > (0 - 0)) and v112) or (0 + 0);
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
	local v113 = v6:GCDRemains();
	local v114 = v18(v20.CrusaderStrike:CooldownRemains(), v20.BladeofJustice:CooldownRemains(), v20.Judgment:CooldownRemains(), (v20.HammerofWrath:IsUsable() and v20.HammerofWrath:CooldownRemains()) or (5 + 5), v20.WakeofAshes:CooldownRemains());
	if (v113 > v114) then
		return v113;
	end
	return v114;
end
local function v69()
	for v146, v147 in pairs(v5.Party) do
		if (v147:Role() == "HEALER") then
			v37 = v147;
		end
		if (v147:Role() == "TANK") then
			v36 = v147;
		end
	end
end
local function v70(v115)
	local v116 = UnitGUID("targettarget");
	if (v115 ~= nil) then
		for v164, v165 in pairs(v115) do
			if ((v165:GUID() == v116) and ((v7:CastSpellID() == (567612 - 246824)) or (v7:CastSpellID() == (324168 - (145 + 293))))) then
				if (v165 ~= nil) then
					return v165;
				end
			end
		end
	end
end
v3:RegisterForEvent(function()
	v69();
end, "PLAYER_ENTERING_WORLD", "GROUP_ROSTER_UPDATE", "ADDON_LOADED");
local function v71(v117)
	local v118 = 430 - (44 + 386);
	for v148, v149 in pairs(v5.Party) do
		if v23.unitHasDebuffFromList(v23.DebuffList[v117], v149) then
			v118 = v118 + (1487 - (998 + 488));
		end
	end
	return v118;
end
local function v72(v119, v120)
	local v121 = v23.DebuffList[v120];
	local v122 = 0 + 0;
	for v150, v151 in pairs(v5.Party) do
		if ((v151 ~= "player") and v23.unitHasDebuffFromList(v121, v151)) then
			v122 = v122 + 1 + 0;
			v151:Cast(v119);
			return "dispel";
		end
		if ((v122 == (772 - (201 + 571))) and v23.unitHasDebuffFromList(v121, v6)) then
			v5(v26.RetHealing.UnboundFreedomUnit):Cast(v119);
			return "on selected unit";
		end
	end
end
local v73 = {(940744 - 714781),(730802 - 530620),(197213 - (814 + 45)),(12151 + 213333),(197261 - (261 + 624)),(261821 - (1020 + 60)),(1445808 - 1019148),(162460 + 250045),(257561 - (760 + 987)),(256200 - (745 + 21)),(726847 - 462697),(3366 + 408334),(413013 - (87 + 968)),(240023 + 24533),(203146 - (447 + 966)),(269724 - (1703 + 114)),(426989 - 166438),(73561 + 183846),(426673 - (9 + 5)),((622525 - (243 + 1022)) - (1504175 - 1108878))};
local v74 = v23.converArrayToList({(211977 - (1123 + 57)),(209001 - (163 + 91)),(57888 + 149319)});
local function v75(v123, v124)
	local v125 = nil;
	if (v124 == nil) then
		for v166, v167 in pairs(v123) do
			if ((v167:Role() ~= "TANK") and ((v26.RetHealing.BoPDebuff and (v23.unitHasDebuffFromList(v23.DebuffList['Bleed'], v167) or v23.unitHasDebuffFromList(v73, v167))) or (v167:HealthPercentageWeighted() <= v26.RetHealing.BoPHP)) and v167:DebuffDown(v20.ForbearanceDebuff)) then
				v125 = v167;
			end
		end
	end
	if (v124 == true) then
		if (((v26.RetHealing.BoPDebuff and (v23.unitHasDebuffFromList(v23.DebuffList['Bleed'], v6) or v23.unitHasDebuffFromList(v73, v6))) or (v6:HealthPercentageWeighted() <= v26.RetHealing.BoPHP)) and v6:DebuffDown(v20.ForbearanceDebuff)) then
			v125 = v6;
		end
	end
	return v125;
end
function PreventWithFreedomIfTargetOfTargetIsPlayer(v126)
	local v127 = UnitGUID("player");
	local v128 = "target";
	if UnitExists(v128) then
		local v158 = "targettarget";
		if (UnitExists(v158) and (UnitGUID(v158) == v127)) then
			if ((v7:CastSpellID() == v126) and UnitIsPlayer(v128)) then
				return true;
			end
		end
	end
	return false;
end
local function v76()
	if (v25.General.AutoTab and v6:AffectingCombat()) then
		v12.TopPanelAlternative:ChangeIcon(3 - 2, 4 - 1);
		return "Auto tab to target";
	end
end
function EnemiesWithIDInCCRange(v129)
	local v130 = v6:GetEnemiesInRange(2 + 8);
	local v131 = 0 - 0;
	for v152, v153 in pairs(v130) do
		if (v153:NPCID() == v129) then
			v131 = v131 + 1 + 0;
		end
	end
	return v131;
end
local function v77(v132)
	return (v132 ~= "Not Used") and (((v132 == "With Cooldowns") and v12.CDsON()) or ((v132 == "With Small or Cooldowns") and (SmallCDToggle or v12.CDsON())) or ((v132 == "With Small CDs") and SmallCDToggle) or ((v132 == "On Mobcount") and (v40 >= v26.RetCooldowns.Mobcount)) or ((v132 == "On Mobcount or Cooldowns") and ((v40 >= v26.RetCooldowns.Mobcount) or v14())) or (v132 == "Always") or ((v132 == "On Bosses") and (v34 or v7:IsDummy())) or ((v132 == "Mobcount or Boss") and (v34 or v7:IsDummy() or (v40 >= v26.RetCooldowns.Mobcount))) or ((v132 == "With Bloodlust only") and v6:BloodlustUp()));
end
local function v78(v133)
	local v134 = v26.RetHealing.IntercessionUnit;
	if (v134 == "All") then
		for v168, v169 in pairs(v133) do
			if v169:IsDeadOrGhost() then
				return v169;
			end
		end
		return nil;
	end
	local v135 = {None={},Tank={"TANK"},Healer={"HEALER"},["Tank and Healer"]={"TANK","HEALER"},DD={"DAMAGER"}};
	local v136 = v135[v134] or {};
	for v154, v155 in pairs(v133) do
		local v156 = v155:Role();
		local v157 = v155:IsDeadOrGhost();
		for v159, v160 in ipairs(v136) do
			if ((v156 == v160) and v157) then
				return v155;
			end
		end
	end
	return nil;
end
local function v79(v137, v138, v139)
	if (v34 or v23.ISSolo() or (v139 == (438 - (262 + 176))) or ((v28 >= v139) and (v28 < (9498 - (345 + 1376))))) then
		v12.Cast(v137, v138);
		return "TTD cast " .. v137:Name();
	end
end
local function v80(v140)
	return v34 or v23.ISSolo() or (v140 == (688 - (198 + 490))) or v23.Buggedmobs[v7:NPCID()] or ((v28 >= v140) and (v28 < (34358 - 26581)));
end
local function v81()
	if (v33:IsReady() and (v30 >= (9 - 5)) and v7:IsSpellInRange(v33)) then
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
local function v82()
	if (v26.Commons.Enabled.Potions and PotionSetting and ((AvengingWrathSetting and v6:BuffUp(v20.AvengingWrathBuff)) or (CrusadeSetting and v6:BuffUp(v20.CrusadeBuff)) or (ExecutionSentenceSetting and v7:DebuffUp(v20.ExecutionSentenceDebuff)) or (v27 < (1236 - (696 + 510))))) then
		local v161 = v23.PotionSelected();
		if (v161 and v161:IsReady()) then
			v12.CastMacro(5 - 2, nil, nil, v161);
			return "Cast Potion";
		end
	end
	if (RacialsSetting and v20.LightsJudgment:IsCastable() and v7:IsInRange(1302 - (1091 + 171))) then
		if v15(v20.LightsJudgment) then
			return "lights_judgment cooldowns 4";
		end
	end
	if (RacialsSetting and v20.Fireblood:IsCastable() and (v6:BuffUp(v20.AvengingWrathBuff) or (v6:BuffUp(v20.CrusadeBuff) and (v6:BuffStack(v20.CrusadeBuff) == (2 + 8))))) then
		if v15(v20.Fireblood, false) then
			return "fireblood cooldowns 6";
		end
	end
	if (((Trinket1Setting and (v42:ID() == v21.AlgetharPuzzleBox:ID())) or (Trinket2Setting and (v43:ID() == v21.AlgetharPuzzleBox:ID()))) and v80(v26.RetTTD.TrinketsTTD) and v26.Commons.Enabled.Trinkets and v67() and ((not v20.Crusade:IsAvailable() and (v20.AvengingWrath:CooldownRemains() < (15 - 10))) or ((v20.Crusade:CooldownRemains() < (16 - 11)) and v20.Crusade:IsAvailable())) and (((v30 >= (378 - (123 + 251))) and (v3.CombatTime() < (24 - 19))) or ((v30 >= (701 - (208 + 490))) and (v3.CombatTime() > (1 + 4)))) and v7:IsInRange(3 + 2)) then
		if v15(v21.AlgetharPuzzleBox, nil) then
			return "algethar_puzzle_box cooldowns 8";
		end
	end
	if (((Trinket1Setting and (v42:ID() == v21.ElementiumPocketAnvil:ID())) or (Trinket2Setting and (v43:ID() == v21.ElementiumPocketAnvil:ID()))) and v26.Commons.Enabled.Trinkets and v21.ElementiumPocketAnvil:IsEquippedAndReady() and v7:IsInRange(841 - (660 + 176))) then
		if v15(v21.ElementiumPocketAnvil, nil) then
			return "Elementium Pocket Anvil cooldowns 8";
		end
	end
	if (((Trinket1Setting and (v42:ID() == v21.BranchOfTheTormentedAncient:ID())) or (Trinket2Setting and (v43:ID() == v21.BranchOfTheTormentedAncient:ID()))) and v80(v26.RetTTD.TrinketsTTD) and v26.Commons.Enabled.Trinkets and v21.BranchOfTheTormentedAncient:IsEquippedAndReady() and v7:IsInRange(1 + 4)) then
		if v15(v21.BranchOfTheTormentedAncient) then
			return "BranchOfTheTormentedAncient cooldowns 8";
		end
	end
	if v26.Commons.Enabled.Trinkets then
		if (v42:IsReady() and Trinket1Setting and not v56 and ((((((v20.Crusade:IsLearned() and not CrusadeSetting) or (v20.AvengingWrath:IsLearned() and not AvengingWrathSetting) or (v6:BuffUp(v20.AvengingWrathBuff) and (v20.AvengingWrath:CooldownRemains() > (242 - (14 + 188)))) or (v6:BuffUp(v20.CrusadeBuff) and (v6:BuffStack(v20.CrusadeBuff) == (685 - (534 + 141))))) and not v20.RadiantGlory:IsAvailable()) or (v20.RadiantGlory:IsAvailable() and ((not v20.ExecutionSentence:IsAvailable() and v20.WakeofAshes:CooldownUp()) or v7:DebuffUp(v20.ExecutionSentenceDebuff)))) and (not v43:HasCooldown() or v43:CooldownDown() or (v62 == (1 + 0)))) or (v42:BuffDuration() >= v28))) then
			if v15(v42) then
				return "use_item for trinket1 (" .. v42:Name() .. ") cooldowns 8";
			end
		end
		if (v43:IsReady() and Trinket2Setting and not v57 and ((((((v20.Crusade:IsLearned() and not CrusadeSetting) or (v20.AvengingWrath:IsLearned() and not AvengingWrathSetting) or (v6:BuffUp(v20.AvengingWrathBuff) and (v20.AvengingWrath:CooldownRemains() > (36 + 4))) or (v6:BuffUp(v20.CrusadeBuff) and (v6:BuffStack(v20.CrusadeBuff) == (1 + 0)))) and not v20.RadiantGlory:IsAvailable()) or (v20.RadiantGlory:IsAvailable() and ((not v20.ExecutionSentence:IsAvailable() and v20.WakeofAshes:CooldownUp()) or v7:DebuffUp(v20.ExecutionSentenceDebuff)))) and (not v42:HasCooldown() or v42:CooldownDown() or (v62 == (3 - 1)))) or (v43:BuffDuration() >= v28))) then
			if v15(v43) then
				return "use_item for trinket2 (" .. v43:Name() .. ") cooldowns 8";
			end
		end
		if (v42:IsReady() and Trinket1Setting and not v56 and not v58 and (v43:CooldownDown() or not v59 or (v20.Crusade:IsLearned() and not CrusadeSetting) or (v20.AvengingWrath:IsLearned() and not AvengingWrathSetting) or (v6:BuffDown(v20.CrusadeBuff) and (v20.Crusade:CooldownRemains() > (31 - 11))) or (v6:BuffDown(v20.AvengingWrathBuff) and (v20.AvengingWrath:CooldownRemains() > (56 - 36))))) then
			if v15(v42) then
				return "use_item for trinket1 (" .. v42:Name() .. ") cooldowns 10";
			end
		end
		if (v43:IsReady() and Trinket2Setting and not v57 and not v59 and (v42:CooldownDown() or not v58 or (v20.Crusade:IsLearned() and not CrusadeSetting) or (v20.AvengingWrath:IsLearned() and not AvengingWrathSetting) or (v6:BuffDown(v20.CrusadeBuff) and (v20.Crusade:CooldownRemains() > (11 + 9))) or (v6:BuffDown(v20.AvengingWrathBuff) and (v20.AvengingWrath:CooldownRemains() > (13 + 7))))) then
			if v15(v43) then
				return "use_item for trinket2 (" .. v43:Name() .. ") cooldowns 12";
			end
		end
		if (v21.BestinSlotsMelee:IsEquippedAndReady() and (((v26.Retribution.DisableCrusadeAWCDCheck or (v6:BuffUp(v20.AvengingWrathBuff) and (v20.AvengingWrath:CooldownRemains() > (436 - (115 + 281)))) or (v6:BuffUp(v20.CrusadeBuff) and (v6:BuffStack(v20.CrusadeBuff) == (23 - 13)))) and not v20.RadiantGlory:IsAvailable()) or (v20.RadiantGlory:IsAvailable() and ((not v20.ExecutionSentence:IsAvailable() and v20.WakeofAshes:CooldownUp()) or v7:DebuffUp(v20.ExecutionSentenceDebuff))))) then
			v12.CastMacro(1 + 0, nil, nil, v21.BestinSlotsMelee);
			return "Weapon cast";
		end
		if ((((v42:ID() == v21.ConcoctionKissofDeath:ID()) and Trinket1Setting) or ((v43:ID() == v21.ConcoctionKissofDeath:ID()) and Trinket2Setting)) and v21.ConcoctionKissofDeath:IsEquippedAndReady() and (v6:BuffUp(v20.AvengingWrathBuff) or (v6:BuffStack(v20.CrusadeBuff) == (24 - 14)))) then
			if v15(v21.ConcoctionKissofDeath, true) then
				return "ConcoctionKissofDeath";
			end
		end
	end
	if v26.Commons.Enabled.Items then
		if (v21.ShadowedRazingAnnihilator:IsEquippedAndReady() and WeaponSetting and v7:IsInRange(18 - 13) and (v42:CooldownDown() or not v42:HasUseBuff()) and (v43:CooldownDown() or not v43:HasUseBuff())) then
			v12.CastMacro(868 - (550 + 317), nil, nil, v21.ShadowedRazingAnnihilator);
			return "shadowed_razing_annihilator cooldowns 10";
		end
		if (v21.Fyralath:IsEquippedAndReady() and v14() and WeaponSetting and v7:IsInRange(7 - 2) and (v20.MarkofFyralathDebuff:AuraActiveCount() > (0 - 0)) and v6:BuffDown(v20.AvengingWrathBuff) and v6:BuffDown(v20.CrusadeBuff)) then
			v12.CastMacro(2 - 1, nil, nil, v21.Fyralath);
			return "Fyralath cast";
		end
	end
	if (v20.ExecutionSentence:IsCastable() and v7:IsInRange(315 - (134 + 151)) and ExecutionSentenceSetting and ((v7:TimeToDie() > (1680 - (970 + 695))) or v23.Buggedmobs[v7:NPCID()]) and (((UnitClassification("target") ~= "normal") and (UnitClassification("target") ~= "trivial") and (UnitClassification("target") ~= "minus")) or not v6:IsInDungeonArea() or v74[v7:NPCID()]) and ((v6:BuffDown(v20.CrusadeBuff) and (v20.Crusade:CooldownRemains() > (28 - 13))) or (v6:BuffStack(v20.CrusadeBuff) == (2000 - (582 + 1408))) or (not v20.Crusade:IsAvailable() and (v20.AvengingWrath:CooldownRemains() < (0.75 - 0))) or (v20.AvengingWrath:CooldownRemains() > (18 - 3)) or v20.RadiantGlory:IsAvailable() or (v20.Crusade:IsLearned() and not CrusadeSetting) or (v20.AvengingWrath:IsLearned() and not AvengingWrathSetting)) and (((v30 >= (15 - 11)) and (v3.CombatTime() < (1829 - (1195 + 629)))) or ((v30 >= (3 - 0)) and (v3.CombatTime() > (246 - (187 + 54)))) or (((v30 >= (782 - (162 + 618))) or (v3.CombatTime() > (4 + 1))) and (v20.DivineAuxiliary:IsAvailable() or v20.RadiantGlory:IsAvailable()))) and ((v20.DivineHammer:CooldownRemains() > (4 + 1)) or v6:BuffUp(v20.DivineHammerBuff) or not v20.DivineHammer:IsAvailable() or not DivineHammerSetting) and (((v7:TimeToDie() > (16 - 8)) and not v20.ExecutionersWill:IsAvailable()) or (v7:TimeToDie() > (19 - 7))) and (v20.WakeofAshes:CooldownRemains() < v6:GCD())) then
		if v15(v20.ExecutionSentence) then
			return "execution_sentence cooldowns 14";
		end
	end
	if (v20.AvengingWrath:IsCastable() and v7:IsInRange(1 + 4) and AvengingWrathSetting and (((v30 >= (1640 - (1373 + 263))) and (v3.CombatTime() < (1005 - (451 + 549)))) or ((v30 >= (1 + 2)) and (v3.CombatTime() > (7 - 2))) or ((v30 >= (2 - 0)) and v20.DivineAuxiliary:IsAvailable() and (v20.ExecutionSentence:CooldownUp() or v20.FinalReckoning:CooldownUp()))) and ((v40 <= (1385 - (746 + 638))) or (v7:TimeToDie() > (4 + 6)))) then
		if v15(v20.AvengingWrath, false) then
			return "avenging_wrath cooldowns 16";
		end
	end
	if (v20.Crusade:IsCastable() and v7:IsInRange(7 - 2) and CrusadeSetting and (((v30 >= (346 - (218 + 123))) and (v3.CombatTime() < (1586 - (1535 + 46)))) or ((v30 >= (3 + 0)) and (v3.CombatTime() >= (1 + 4))))) then
		if v15(v20.Crusade, false) then
			return "crusade cooldowns 18";
		end
	end
	if (v20.FinalReckoning:IsCastable() and v7:IsInMeleeRange(565 - (306 + 254)) and FinalReckoningSetting and (((v30 >= (1 + 3)) and (v3.CombatTime() < (15 - 7))) or ((v30 >= (1470 - (899 + 568))) and (v3.CombatTime() >= (6 + 2))) or ((v30 >= (4 - 2)) and (v20.DivineAuxiliary:IsAvailable() or v20.RadiantGlory:IsAvailable()))) and (not AvengingWrathSetting or (v20.AvengingWrath:CooldownRemains() > (613 - (268 + 335))) or (v20.Crusade:CooldownDown() and (v6:BuffDown(v20.CrusadeBuff) or (v6:BuffStack(v20.CrusadeBuff) >= (300 - (60 + 230))))) or (v20.RadiantGlory:IsAvailable() and (v6:BuffUp(v20.AvengingWrathBuff) or (v20.Crusade:IsAvailable() and (v20.WakeofAshes:CooldownRemains() < v6:GCD())))))) then
		if v12.CastTarget(v20.FinalReckoning, v12.TName().PLAYER) then
			return "final_reckoning cooldowns 20";
		end
	end
end
local function v83()
	v32 = ((v40 >= (574 - (426 + 146))) or v6:BuffUp(v20.EmpyreanPowerBuff) or (not v20.FinalVerdict:IsLearned() and v20.TempestoftheLightbringer:IsAvailable())) and v6:BuffDown(v20.EmpyreanLegacyBuff) and not (v6:BuffUp(v20.DivineArbiterBuff) and (v6:BuffStack(v20.DivineArbiterBuff) > (3 + 21)));
	if (v20.HammerofLight:IsReady() and v7:IsInRange(1470 - (282 + 1174)) and (v20.HammerofLight:IsReady() or not v20.DivineHammer:IsAvailable() or not DivineHammerSetting or v24.DivineHammerActive or (v20.DivineHammer:CooldownRemains() > (821 - (569 + 242))))) then
		if v15(v20.WakeofAshes, true) then
			return "hammer_of_light finishers 2";
		end
	end
	if (v20.DivineHammer:IsReady() and DivineHammerSetting and v7:IsInRange(22 - 14) and not v24.DivineHammerActive) then
		if v15(v20.DivineHammer) then
			return "divine_hammer finishers 4";
		end
	end
	if (v20.DivineStorm:IsReady() and v32 and not v20.HammerofLight:IsReady() and (v20.DivineHammer:CooldownDown() or v24.DivineHammerActive or not v20.DivineHammer:IsAvailable() or not DivineHammerSetting) and (not CrusadeSetting or v20.Crusade:IsAvailable() or (v20.Crusade:CooldownRemains() > (v31 * (1 + 2))) or (v6:BuffUp(v20.CrusadeBuff) and (v6:BuffStack(v20.CrusadeBuff) < (1034 - (706 + 318)))) or v20.RadiantGlory:IsAvailable())) then
		if v15(v20.DivineStorm) then
			return "divine_storm finishers 6";
		end
	end
	if (v20.JusticarsVengeance:IsReady() and v7:IsInRange(1259 - (721 + 530)) and (not v20.Crusade:IsAvailable() or (not AvengingWrathSetting and not CrusadeSetting) or (v20.Crusade:CooldownRemains() > (v31 * (1274 - (945 + 326)))) or (v6:BuffUp(v20.CrusadeBuff) and (v6:BuffStack(v20.CrusadeBuff) < (24 - 14))) or v20.RadiantGlory:IsAvailable()) and not v20.HammerofLight:IsReady() and (v20.DivineHammer:CooldownDown() or v24.DivineHammerActive or not v20.DivineHammer:IsAvailable() or not DivineHammerSetting)) then
		if v15(v20.JusticarsVengeance) then
			return "justicars_vengeance finishers 8";
		end
	end
	if (v33:IsReady() and v7:IsSpellInRange(v33) and (not v20.Crusade:IsAvailable() or (not AvengingWrathSetting and not CrusadeSetting) or (v20.Crusade:CooldownRemains() > (v31 * (3 + 0))) or (v6:BuffUp(v20.CrusadeBuff) and (v6:BuffStack(v20.CrusadeBuff) < (710 - (271 + 429)))) or v20.RadiantGlory:IsAvailable()) and not v20.HammerofLight:IsReady() and (v20.DivineHammer:CooldownDown() or not v20.DivineHammer:IsAvailable() or not DivineHammerSetting)) then
		if v15(v33) then
			return "either verdict finishers 6";
		end
	end
end
local function v84()
	if (((v30 == (5 + 0)) or ((v30 == (1504 - (1408 + 92))) and v6:BuffUp(v20.DivineResonanceBuff)) or v6:BuffUp(v20.TWW_S2_4pcBuff)) and v20.WakeofAshes:CooldownDown()) then
		local v162 = v83();
		if v162 then
			return v162;
		end
	end
	if (v20.HammerofLight:IsReady() and v7:IsInRange(1100 - (461 + 625))) then
		if v15(v20.WakeofAshes, true) then
			return "HammerofLight generator 1";
		end
	end
	if (v20.TemplarSlash:IsReady() and v7:IsInMeleeRange(1293 - (993 + 295)) and (v20.TemplarStrike:TimeSinceLastCast() > ((1 + 4) - (v6:GCD() * (1173 - (418 + 753)))))) then
		if v15(v20.TemplarSlash) then
			return "templar_slash generators 2";
		end
	end
	if (v20.BladeofJustice:IsCastable() and v7:IsSpellInRange(v20.BladeofJustice) and ((v7:DebuffDown(v20.ExpurgationDebuff) and v20.HolyFlames:IsAvailable() and v20.DivineToll:CooldownDown()) or not DivineTollSetting)) then
		if v15(v20.BladeofJustice) then
			return "blade_of_justice generators 4";
		end
	end
	if (v20.WakeofAshes:IsCastable() and WakeofAshesSetting and v7:IsInRange(6 + 8) and (not v20.LightsGuidance:IsAvailable() or ((v30 >= (1 + 1)) and v20.LightsGuidance:IsAvailable())) and ((v20.AvengingWrath:CooldownRemains() > (2 + 4)) or not AvengingWrathSetting or (v20.Crusade:IsAvailable() and ((v20.Crusade:CooldownRemains() > (2 + 4)) or not CrusadeSetting)) or v20.RadiantGlory:IsAvailable()) and ((v20.FinalReckoning:CooldownRemains() > (533 - (406 + 123))) or (v20.FinalReckoning:IsLearned() and not FinalReckoningSetting) or (v20.ExecutionSentence:CooldownRemains() > (1773 - (1749 + 20))) or (v20.ExecutionSentence:IsLearned() and not ExecutionSentenceSetting) or (v27 < (2 + 6)))) then
		if v15(v20.WakeofAshes) then
			return "wake_of_ashes generators 2";
		end
	end
	if (v20.DivineToll:IsCastable() and DivineTollSetting and v7:IsInRange(1352 - (1249 + 73)) and (((v30 <= (1 + 1)) and ((v20.AvengingWrath:IsAvailable() and (v20.AvengingWrath:CooldownRemains() > (1160 - (466 + 679)))) or not AvengingWrathSetting)) or (v20.Crusade:IsAvailable() and (v20.Crusade:CooldownRemains() > (35 - 20))) or not CrusadeSetting or v20.RadiantGlory:IsAvailable() or (v27 < (22 - 14)))) then
		if v15(v20.DivineToll) then
			return "divine_toll generators 6";
		end
	end
	local v141 = v83();
	if v141 then
		return v141;
	end
	if (v20.TemplarSlash:IsReady() and v7:IsInMeleeRange(1905 - (106 + 1794)) and (v20.TemplarStrike:TimeSinceLastCast() > ((2 + 3) - v6:GCD())) and (v40 >= (1 + 1))) then
		if v15(v20.TemplarSlash) then
			return "templar_slash generators 8";
		end
	end
	if (v20.BladeofJustice:IsCastable() and v7:IsSpellInRange(v20.BladeofJustice) and (v40 >= (5 - 3)) and v20.BladeofVengeance:IsAvailable()) then
		if v15(v20.BladeofJustice) then
			return "blade_of_justice generators 10";
		end
	end
	if (v20.HammerofWrath:IsReady() and v7:IsSpellInRange(v20.HammerofWrath) and ((v40 < (5 - 3)) or not v20.BlessedChampion:IsAvailable()) and v6:BuffUp(v20.BlessingofAnsheRetBuff)) then
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
	if (v20.HammerofWrath:IsReady() and v7:IsSpellInRange(v20.HammerofWrath) and ((v40 < (116 - (4 + 110))) or not v20.BlessedChampion:IsAvailable())) then
		if v15(v20.HammerofWrath, true) then
			return "hammer_of_wrath generators 18";
		end
	end
	if (v20.TemplarSlash:IsReady() and v7:IsInMeleeRange(589 - (57 + 527))) then
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
	if (v20.ArcaneTorrent:IsCastable() and v7:IsInRange(1435 - (41 + 1386))) then
		if v15(v20.ArcaneTorrent) then
			return "arcane_torrent generators 28";
		end
	end
end
local function v85()
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
local function v86()
	local v142 = v23.UnitsinRange(v20.FlashofLight);
	local v143 = v23.GetLowestHealthUnit(v142);
	local v144 = v143:HealthPercentage();
	if not v143:DebuffUp(v20.ForbearanceDebuff) then
		if (v20.LayonHands:IsReady() and (v144 <= v26.RetHealing.LoHPartyHP)) then
			v143:Cast(v20.LayonHands);
			return "Lay on Hands Party";
		end
	end
	if v20.BlessingofProtection:IsReady() then
		BoPTarget = v75(v142);
		PlayerIsBoPTarget = v75(v142, true);
		if ((BoPTarget ~= nil) and not v26.RetHealing.BoPPlayerOnly and not BoPTarget:DebuffUp(v20.ForbearanceDebuff)) then
			BoPTarget:Cast(v20.BlessingofProtection);
			return "Blessing of Protection Party";
		end
		if ((PlayerIsBoPTarget ~= nil) and not v6:DebuffUp(v20.ForbearanceDebuff)) then
			v6:Cast(v20.BlessingofProtection);
			return "Blessing of Protection Player";
		end
	end
	if (v41:IsReady() and (v144 <= v26.RetHealing.WordofGloryPartyHP)) then
		v143:Cast(v41);
		return "Word of Glory Party";
	end
	if (v20.FlashofLight:IsReady() and (not v6:IsMoving() or v20.LightsCelerity:IsAvailable()) and (v144 <= v26.RetHealing.FlashofLightPartyHP)) then
		v143:Cast(v20.FlashofLight);
		return "Flash of Light Party";
	end
	if (v20.BlessingofSacrifice:IsReady() and (v144 <= v26.RetHealing.BlessingOfSacrificeHP) and (v6:HealthPercentage() > (193 - (17 + 86))) and v6:BuffDown(v20.BlessingofProtection)) then
		v143:Cast(v20.BlessingofSacrifice);
		return "BlessingofSacrifice Party";
	end
end
local function v87()
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
local function v88()
	v35 = v23.HealthPotions();
	if v35 then
		return v35;
	end
	if v6:IsChanneling(v21.ManicGrieftorch.ItemUseSpell) then
		return "Dont cut Torch";
	end
	if (v6:IsInParty() or v6:IsInRaid()) then
		local v163 = v87();
		if v163 then
			return v163;
		end
	end
	SmallCDToggle = v12.ToggleIconFrame:GetToggle(1 + 0);
	InterruptToggle = v12.ToggleIconFrame:GetToggle(3 - 1);
	DispelToggle = v12.ToggleIconFrame:GetToggle(8 - 5);
	v38 = v23.UnitsinRange(v20.FlashofLight);
	UnitForFreezingBinds = v70(v38);
	v41 = (v20.EternalFlame:IsAvailable() and v20.EternalFlame) or v20.WordofGlory;
	v39 = v6:GetEnemiesInRange(174 - (122 + 44));
	if v13() then
		v40 = #v39;
	else
		v40 = 1 - 0;
	end
	RacialsSetting = v77(v26.RetCooldowns.RacialsSetting) and v80(v26.RetTTD.RacialsTTD);
	Trinket1Setting = v77(v26.RetCooldowns.Trinket1Setting) and v80(v26.RetTTD.TrinketsTTD);
	Trinket2Setting = v77(v26.RetCooldowns.Trinket2Setting) and v80(v26.RetTTD.TrinketsTTD);
	PotionSetting = v77(v26.RetCooldowns.PotionSetting) and not v23.ISSolo();
	DivineTollSetting = v77(v26.RetCooldowns.DivineTollSetting) and v80(v26.RetTTD.DivineTollTTD);
	AvengingWrathSetting = v77(v26.RetCooldowns.AvengingWrathSetting) and v80(v26.RetTTD.AvengingWrathTTD);
	ExecutionSentenceSetting = v77(v26.RetCooldowns.ExecutionSentenceSetting) and v80(v26.RetTTD.ExecutionSentenceTTD);
	FinalReckoningSetting = v77(v26.RetCooldowns.FinalReckoningSetting) and v80(v26.RetTTD.FinalReckoningTTD);
	CrusadeSetting = v77(v26.RetCooldowns.CrusadeSetting) and v80(v26.RetTTD.CrusadeTTD);
	WakeofAshesSetting = v77(v26.RetCooldowns.WakeofAshesSetting) and v80(v26.RetTTD.WakeofAshesTTD);
	DivineHammerSetting = v77(v26.RetCooldowns.DivineHammerSetting) and v80(v26.RetTTD.DivineHammerTTD);
	WeaponSetting = v77(v26.RetCooldowns.WeaponSetting) and v80(49 - 34);
	AuraSelected = v26.Retribution.AuraSelect;
	if (v23.TargetIsValid() or v6:AffectingCombat()) then
		v29 = v68();
		v27 = v3.BossFightRemains();
		v34 = true;
		v28 = v27;
		if (v28 == (9039 + 2072)) then
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
		v35 = v85();
		if v35 then
			return v35;
		end
	end
	if (v6:IsInParty() and not v6:IsInRaid()) then
		v35 = v86();
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
					if (v6:DebuffElapsed(v20.EntangledDebuff) > (1 + 1)) then
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
			if ((v6:DebuffUp(v10(859966 - 435471), true) or v6:DebuffUp(v10(424562 - (30 + 35)), true)) and v6:IsInRaid()) then
				v6:Cast(v20.BlessingofFreedom);
				return;
			end
		end
	end
	if v20.BlessingofProtection:IsReady() then
		BoPTarget = v75(v38);
		PlayerIsBoPTarget = v75(v38, true);
		if ((BoPTarget ~= nil) and not v26.RetHealing.BoPPlayerOnly) then
			BoPTarget:Cast(v20.BlessingofProtection);
			return "Blessing of Protection Party  ";
		end
		if (PlayerIsBoPTarget == nil) then
		else
			v6:Cast(v20.BlessingofProtection);
			return "Blessing of Protection Player";
		end
	end
	if v23.TargetIsValid() then
		if (not v6:AffectingCombat() and v26.Retribution.AttackOutOfCombat) then
			v35 = v81();
			if v35 then
				return v35;
			end
		end
		if InterruptToggle then
			v35 = v23.InterruptCycle(v20.Rebuke, 4 + 1, true, nil, false);
			if v35 then
				return v35;
			end
			v35 = not v6:IsMoving() and v23.InterruptCycle(v20.HammerofJustice, 1267 - (1043 + 214), false, nil, true);
			if v35 then
				return v35;
			end
			v35 = not v6:IsMoving() and not v26.Retribution.XalatathsBargain and v23.InterruptCycle(v20.BlindingLight, 37 - 27, false, nil, true, true);
			if v35 then
				return v35;
			end
			if (v26.Retribution.XalatathsBargain and (EnemiesWithIDInCCRange(230508 - (323 + 889)) >= (10 - 6)) and v20.BlindingLight:IsCastable()) then
				if v15(v20.BlindingLight) then
					return "BlindingLight on XalatathsBargain";
				end
			end
		end
		if (v7:AffectingCombat() or v26.Retribution.AttackOutOfCombat) then
			local v170 = v82();
			if v170 then
				return v170;
			end
			local v170 = v84();
			if v170 then
				return v170;
			end
		end
	end
	v35 = (v40 > (580 - (361 + 219))) and not v7:IsInRange(328 - (53 + 267)) and v76();
	if v35 then
		return v35;
	end
end
local function v89()
	v26.Retribution.Display();
	v12.ResetToggle();
	v12.ToggleIconFrame:AddButtonCustom("S", 1 + 0, "Small CDs", "smallcds");
	v12.ToggleIconFrame:AddButtonCustom("I", 415 - (15 + 398), "Interrupt", "interrupt");
	v12.ToggleIconFrame:AddButtonCustom("D", 985 - (18 + 964), "Dispel", "dispel");
	v20.MarkofFyralathDebuff:RegisterAuraTracking();
	v23.PostInitialMessage(263 - 193);
end
v12.SetAPL(41 + 29, v88, v89);
