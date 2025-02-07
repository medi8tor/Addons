local v0, v1 = ...;
local v2 = HeroDBC.DBC;
local v3 = HeroLib;
local v4 = HeroCache;
local v5 = v3.Unit;
local v6 = v5.Player;
local v7 = v5.Target;
local v8 = v5.MouseOver;
local v9 = v5.Boss;
local v10 = v5.Pet;
local v11 = v3.Spell;
local v12 = v3.Item;
local v13 = HeroRotation();
local v14 = v13.Cast;
local v15 = v13.CDsON;
local v16 = v13.AoEON;
local v17 = v13.Commons().Everyone.num;
local v18 = v13.Commons().Everyone.bool;
local v19 = C_Timer.After;
local v20 = math.max;
local v21 = table.insert;
local v22 = GetTime;
local v23 = v13.Commons().DeathKnight;
local v24 = v11.DeathKnight.Unholy;
local v25 = v12.DeathKnight.Unholy;
local v26 = {SmallCDToggle=false,TabToggle=false,InterruptToggle=false,DnDSetting=false,DarkTransformationSetting=false,RacialsSetting=false,Trinket1Setting=false,Trinket2Setting=false,PotionSetting=false,ApocalypseSetting=false,UnholyAssaultSetting=false,AbominationLimbSetting=false,EmpowerRuneWeaponSetting=false,UnholyBlightSetting=false,SummonGargoyleSetting=false,RaiseAbominationSetting=false,ArmyOfTheDeadSetting=false};
local v27 = {v25.AlgetharPuzzleBox:ID(),v25.Fyralath:ID(),v25.IrideusFragment:ID(),v25.VialofAnimatedBlood:ID(),v25.ManicGrieftorch:ID(),v25.TreacherousTransmitter:ID()};
local v28 = v6:GetEquipment();
local v29 = (v28[581 - (367 + 201)] and v12(v28[940 - (214 + 713)])) or v12(0 + 0);
local v30 = (v28[3 + 11] and v12(v28[891 - (282 + 595)])) or v12(1637 - (1523 + 114));
local v31;
local v32;
local v33 = v13.GUISettingsGet();
local v34 = v13.Commons().Everyone;
local v35 = {General=v33.General,Commons=v33.APL.DeathKnight.Commons,Defensives=v33.APL.DeathKnight.Unholy.Defensives,Unholy=v33.APL.DeathKnight.Unholy,TTD=v33.APL.DeathKnight.Unholy_TTD};
local v36;
local v37;
local v38;
local v39;
local v40;
local v41;
local v29, v30;
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
local v62, v63;
local v64, v65;
local v66, v67;
local v68, v69;
local v70 = ((v24.VampiricStrikeAction:IsLearned()) and v24.VampiricStrikeAction) or ((v24.ClawingShadows:IsAvailable()) and v24.ClawingShadows) or v24.ScourgeStrike;
local v71 = ((v24.ClawingShadows:IsAvailable()) and v24.ClawingShadows) or v24.ScourgeStrike;
local v72 = ((v24.Defile:IsAvailable()) and v24.Defile) or v24.DeathAndDecay;
local v73, v74, v75;
local v76, v77, v78;
local v79, v80;
local v81;
local v82 = 9986 + 1125;
local v83 = 15839 - 4728;
local v84 = v13.Commons().DeathKnight.GhoulTable;
local function v85(v145)
	return (v145 ~= "Not Used") and (((v145 == "With Cooldowns") and v13.CDsON()) or ((v145 == "With Small or Cooldowns") and (v26[1066 - (68 + 997)] or v13.CDsON())) or ((v145 == "With Small CDs") and v26[1271 - (226 + 1044)]) or ((v145 == "On Mobcount") and (v78 >= v35.Unholy.Mobcount)) or ((v145 == "On Mobcount or Cooldowns") and ((v78 >= v35.Unholy.Mobcount) or v15())) or (v145 == "Always") or ((v145 == "On Bosses") and IsBossfight) or ((v145 == "Mobcount or Boss") and (IsBossfight or (v78 >= v35.Unholy.Mobcount))));
end
local function v86(v146, v147, v148)
	if (IsBossfight or v34.ISSolo() or (v148 == (0 - 0)) or ((v83 >= v148) and (v83 < (7894 - (32 + 85))))) then
		v13.Cast(v146, v147);
		return "TTD cast " .. v146:Name();
	end
end
local function v87(v149)
	if (v149 == nil) then
		print("nil value");
		return true;
	end
	return IsBossfight or v34.ISSolo() or (v149 == (0 + 0)) or v34.Buggedmobs[v7:NPCID()] or ((v83 >= v149) and (v83 < (1725 + 6052)));
end
local v88 = {{v24.Asphyxiate,"Cast Asphyxiate (Interrupt)",function()
	return true;
end}};
local function v89()
	return v25.ManicGrieftorch:IsEquipped() and (v25.ManicGrieftorch:CooldownUp() or (v25.ManicGrieftorch:CooldownRemains() <= v6:GCDRemains()));
end
local function v90()
	return v25.AlgetharPuzzleBox:IsEquipped() and (v25.AlgetharPuzzleBox:CooldownUp() or (v25.AlgetharPuzzleBox:CooldownRemains() <= v6:GCDRemains()));
end
local v91 = 350 - (87 + 263);
local function v92()
	local v150, v151 = v6:GetTrinketData(v27);
	if ((v91 < (185 - (67 + 113))) and ((v150.ID == (0 + 0)) or (v151.ID == (0 - 0)) or (v150.Level == (0 + 0)) or (v151.Level == (0 - 0)) or ((v150.SpellID > (952 - (802 + 150))) and not v150.Usable) or ((v151.SpellID > (0 - 0)) and not v151.Usable))) then
		v91 = v91 + (1 - 0);
		v19(4 + 1, function()
			v92();
		end);
		return;
	end
	v29 = v150.Object;
	v30 = v151.Object;
	v42 = v150.ID;
	v43 = v151.ID;
	VarTrinket1Level = v150.Level;
	VarTrinket2Level = v151.Level;
	v44 = v150.Spell;
	v46 = v150.Range;
	v48 = v150.CastTime;
	v45 = v151.Spell;
	v47 = v151.Range;
	v49 = v151.CastTime;
	v50 = v150.Cooldown;
	v51 = v151.Cooldown;
	v52 = v150.Blacklisted;
	v53 = v151.Blacklisted;
	v54 = v29:HasUseBuff() or (v42 == v25.TreacherousTransmitter:ID());
	v55 = v30:HasUseBuff() or (v43 == v25.TreacherousTransmitter:ID());
	v56 = ((v42 == v25.TreacherousTransmitter:ID()) and (1012 - (915 + 82))) or v29:BuffDuration();
	v57 = ((v43 == v25.TreacherousTransmitter:ID()) and (42 - 27)) or v30:BuffDuration();
	v58 = 0.5 + 0;
	if ((v54 and ((v24.Apocalypse:IsAvailable() and ((v50 % (39 - 9)) == (1187 - (1069 + 118)))) or (v24.DarkTransformation:IsAvailable() and ((v50 % (101 - 56)) == (0 - 0))))) or (v42 == v25.TreacherousTransmitter:ID())) then
		v58 = 1 + 0;
	end
	v59 = 0.5 - 0;
	if ((v55 and ((v24.Apocalypse:IsAvailable() and ((v51 % (30 + 0)) == (791 - (368 + 423)))) or (v24.DarkTransformation:IsAvailable() and ((v51 % (141 - 96)) == (18 - (10 + 8)))))) or (v43 == v25.TreacherousTransmitter:ID())) then
		v59 = 3 - 2;
	end
	v60 = 443 - (416 + 26);
	local v168 = ((v56 > (0 - 0)) and v56) or (1 + 0);
	local v169 = ((v57 > (0 - 0)) and v57) or (439 - (145 + 293));
	if ((not v54 and v55 and (v30:HasCooldown() or not v29:HasCooldown())) or (v55 and (((v51 / v169) * v59) > ((v50 / v168) * v58 * ((431 - (44 + 386)) + ((VarTrinket1Level - VarTrinket2Level) / (1586 - (998 + 488)))))))) then
		v60 = 1 + 1;
	end
	v61 = 1 + 0;
	if (not v54 and not v55 and (VarTrinket2Level >= VarTrinket1Level)) then
		v61 = 774 - (201 + 571);
	end
end
v92();
local v93 = false;
local v88 = {{v24.Asphyxiate,"Cast Asphyxiate (Interrupt)",function()
	return true;
end}};
local function v94()
	if (v33.General.AutoTab and v6:AffectingCombat()) then
		v13.TopPanelAlternative:ChangeIcon(3 - 2, 862 - (814 + 45));
		return "Auto tab to target";
	end
end
v3:RegisterForEvent(function()
	v82 = 27376 - 16265;
	v83 = 599 + 10512;
end, "PLAYER_REGEN_ENABLED");
v3:RegisterForEvent(function()
	v72 = ((v24.Defile:IsAvailable()) and v24.Defile) or v24.DeathAndDecay;
	v91 = 0 + 0;
	v92();
end, "PLAYER_EQUIPMENT_CHANGED", "SPELLS_CHANGED", "LEARNED_SPELL_IN_TAB");
local function v95()
	return (v6:HealthPercentage() < v35.Unholy.Defensives.UseDeathStrikeHP) or ((v6:HealthPercentage() < v35.Unholy.Defensives.UseDarkSuccorHP) and v6:BuffUp(v24.DeathStrikeBuff));
end
local function v96(v170)
	local v171 = 885 - (261 + 624);
	for v217, v218 in pairs(v170) do
		if v218:DebuffDown(v24.VirulentPlagueDebuff) then
			v171 = v171 + (1 - 0);
		end
	end
	return v171;
end
function IsNpcNearPlayer()
	local v172 = v6:GetEnemiesInRange(1120 - (1020 + 60));
	for v219, v220 in pairs(v172) do
		if ((v220:NPCID() == (41780 - (630 + 793))) or (v220:CastSpellID() == (1518166 - 1070153))) then
			print("npc found: do not use abo limb");
			return true;
		end
	end
	return false;
end
local function v97(v173)
	local v174 = {};
	for v221 in pairs(v173) do
		if not v5:IsInBossList(v173[v221]['UnitNPCID']) then
			v21(v174, v173[v221]);
		end
	end
	return v3.FightRemains(v174);
end
local function v98(v175)
	return v175:DebuffStack(v24.FesteringWoundDebuff);
end
local function v99(v176)
	return v176:DebuffRemains(v24.TrollbaneSlowDebuff);
end
local function v100(v177)
	return v177:DebuffStack(v24.FesteringWoundDebuff) < (9 - 7);
end
local function v101(v178)
	return v178:DebuffStack(v24.FesteringWoundDebuff) <= (1 + 1);
end
local function v102(v179)
	return not v24.VileContagion:IsAvailable();
end
local function v103(v180)
	return (v24.VileContagion:CooldownRemains() < (17 - 12)) or ((v24.FesteringWoundDebuff:AuraActiveCount() == v78) and (v180:DebuffStack(v24.FesteringWoundDebuff) <= (1751 - (760 + 987))));
end
local function v104(v181)
	return ((v24.Apocalypse:CooldownRemains() < v6:GCD()) and v181:DebuffDown(v24.FesteringWoundDebuff)) or (v24.FesteringWoundDebuff:AuraActiveCount() < v78);
end
local function v105(v182)
	return (not v39 and (v182:DebuffStack(v24.FesteringWoundDebuff) < (1917 - (1789 + 124)))) or v6:BuffUp(v24.FesteringScytheBuff);
end
local function v106(v183)
	return (v24.Apocalypse:CooldownRemains() < v38) and (v183:DebuffStack(v24.FesteringWoundDebuff) < (770 - (745 + 21)));
end
local function v107(v184)
	return v37 and (((v184:DebuffStack(v24.FesteringWoundDebuff) >= (1 + 1)) and (v24.VileContagion:CooldownRemains() < (7 - 4))) or not v24.VileContagion:IsAvailable());
end
local function v108(v185)
	return v37 and (((v185:DebuffStack(v24.FesteringWoundDebuff) >= (7 - 5)) and (v24.VileContagion:CooldownRemains() < (1 + 5))) or not v24.VileContagion:IsAvailable());
end
local function v109(v186)
	return ((v186:DebuffStack(v24.FesteringWoundDebuff) >= (4 + 0)) and (v83 > (1059 - (87 + 968))) and ((v72:CooldownRemains() < (13 - 10)) or (v6:BuffUp(v24.DeathAndDecayBuff) and (v186:DebuffStack(v24.FesteringWoundDebuff) >= (4 + 0))))) or (v37 and (v186:DebuffStack(v24.FesteringWoundDebuff) == (13 - 7)));
end
local function v110(v187)
	return ((v187:DebuffStack(v24.FesteringWoundDebuff) == (1419 - (447 + 966))) and (v6:DnDTicking() or (v72:CooldownRemains() < (8 - 5)))) or (v6:BuffUp(v24.DeathAndDecayBuff) and (v187:DebuffStack(v24.FesteringWoundDebuff) >= (1821 - (1703 + 114)))) or ((v72:CooldownRemains() < (704 - (376 + 325))) and (v187:DebuffStack(v24.FesteringWoundDebuff) >= (5 - 1)));
end
local function v111(v188)
	return v188:DebuffStack(v24.FesteringWoundDebuff) >= (2 - 1);
end
local function v112(v189)
	return v189:DebuffUp(v24.TrollbaneSlowDebuff) and (v189:DebuffRemains(v24.TrollbaneSlowDebuff) < v6:GCD());
end
local function v113(v190)
	return ((v190:DebuffStack(v24.FesteringWoundDebuff) >= (1 + 0)) and (v24.Apocalypse:CooldownRemains() > v6:GCD())) or (v24.VampiricStrikeAction:IsLearned() and v190:DebuffUp(v24.VirulentPlagueDebuff));
end
local function v114(v191)
	return (v191:DebuffStack(v24.FesteringWoundDebuff) >= (2 - 1)) or v24.VampiricStrikeAction:IsLearned();
end
local function v115(v192)
	return v192:DebuffUp(v24.TrollbaneSlowDebuff);
end
local function v116(v193)
	return v193:DebuffUp(v24.TrollbaneSlowDebuff) and (v193:DebuffRemains(v24.TrollbaneSlowDebuff) < v6:GCD());
end
local function v117(v194)
	return (v194:TimeToDie() > v194:DebuffRemains(v24.VirulentPlagueDebuff)) and (v194:DebuffTicksRemain(v24.VirulentPlagueDebuff) < (19 - (9 + 5))) and (v194:DebuffRefreshable(v24.VirulentPlagueDebuff) or (v24.Superstrain:IsAvailable() and (v194:DebuffRefreshable(v24.FrostFeverDebuff) or v194:DebuffRefreshable(v24.BloodPlagueDebuff)))) and (not v26[390 - (85 + 291)] or not v24.UnholyBlight:IsAvailable() or v24.Plaguebringer:IsAvailable()) and (not v26[1281 - (243 + 1022)] or not v24.RaiseAbomination:IsAvailable() or (v24.RaiseAbomination:IsAvailable() and (v24.RaiseAbomination:CooldownRemains() > (v194:DebuffTicksRemain(v24.VirulentPlagueDebuff) * (11 - 8)))));
end
local function v118(v195)
	return (v195:TimeToDie() > v195:DebuffRemains(v24.VirulentPlagueDebuff)) and (v195:DebuffTicksRemain(v24.VirulentPlagueDebuff) < (5 + 0)) and (v195:DebuffRefreshable(v24.VirulentPlagueDebuff) or (v24.Morbidity:IsAvailable() and v6:BuffUp(v24.InflictionofSorrowBuff) and v24.Superstrain:IsAvailable() and v195:DebuffRefreshable(v24.FrostFeverDebuff) and v195:DebuffRefreshable(v24.BloodPlagueDebuff))) and (not v26[1194 - (1123 + 57)] or not v24.UnholyBlight:IsAvailable() or (v24.UnholyBlight:IsAvailable() and (v24.DarkTransformation:CooldownDown() or not v26[5 + 0]))) and (not v26[270 - (163 + 91)] or not v24.RaiseAbomination:IsAvailable() or (v24.RaiseAbomination:IsAvailable() and v24.RaiseAbomination:CooldownDown()));
end
local function v119(v196)
	return (v196:DebuffRefreshable(v24.VirulentPlagueDebuff) or (v24.Morbidity:IsAvailable() and v6:BuffDown(v24.GiftoftheSanlaynBuff) and v24.Superstrain:IsAvailable() and v7:DebuffRefreshable(v24.FrostFeverDebuff) and v7:DebuffRefreshable(v24.BloodPlagueDebuff))) and (not v24.UnholyBlight:IsAvailable() or (v24.UnholyBlight:IsAvailable() and (v24.DarkTransformation:CooldownRemains() > ((1945 - (1869 + 61)) / (((1 + 1) * v17(v24.Superstrain:IsAvailable())) + ((6 - 4) * v17(v24.EbonFever:IsAvailable())) + ((2 - 0) * v17(v24.Plaguebringer:IsAvailable()))))))) and (not v24.RaiseAbomination:IsAvailable() or not v26[3 + 13] or (v24.RaiseAbomination:IsAvailable() and (v24.RaiseAbomination:CooldownRemains() > ((20 - 5) / (((2 + 0) * v17(v24.Superstrain:IsAvailable())) + ((1476 - (1329 + 145)) * v17(v24.EbonFever:IsAvailable())) + ((973 - (140 + 831)) * v17(v24.Plaguebringer:IsAvailable())))))));
end
local function v120(v197)
	return (v197:TimeToDie() > v197:DebuffRemains(v24.VirulentPlagueDebuff)) and v197:DebuffRefreshable(v24.VirulentPlagueDebuff);
end
local function v121(v198)
	return v198:DebuffUp(v24.TrollbaneSlowDebuff);
end
local function v122()
	if (v24.ArmyoftheDead:IsReady() and v7:IsInMeleeRange(1855 - (1409 + 441)) and v26[735 - (15 + 703)] and v26[8 + 9] and not v25.Fyralath:IsEquipped()) then
		if v14(v24.ArmyoftheDead) then
			return "army_of_the_dead precombat 4";
		end
	end
	if (v24.Outbreak:IsReady() and v7:IsSpellInRange(v24.Outbreak) and v120(v7)) then
		if v14(v24.Outbreak) then
			return "outbreak precombat 6";
		end
	end
	if (v74:IsReady() and v7:IsInMeleeRange(v75) and v7:IsInMeleeRange(v75)) then
		if v14(v24.FesteringStrike) then
			return "festering_strike precombat 8";
		end
	end
end
local function v123()
	if (v74:IsReady() and v7:IsInMeleeRange(v75)) then
		if v14(v74) then
			return "festering_scythe aoe 2";
		end
	end
	if (v70:IsReady() and v7:IsInRange(WoundSpenderRange) and (v73 >= (439 - (262 + 176))) and v111(v7) and v6:BuffUp(v24.DeathAndDecayBuff) and v24.BurstingSores:IsAvailable() and (v24.Apocalypse:CooldownRemains() > v38)) then
		if v34.CastCycle(v70, v76, v121, WoundSpenderRange) then
			return "wound_spender aoe 4";
		end
	end
	if (v24.Epidemic:IsReady() and v7:IsInRange(1761 - (345 + 1376)) and not v40) then
		if v14(v24.Epidemic) then
			return "epidemic aoe 6";
		end
	end
	if (v70:IsReady() and v7:IsInRange(WoundSpenderRange) and v121(v7) and (v73 >= (689 - (198 + 490))) and v112(v7)) then
		if v14(v71) then
			return "wound_spender aoe 8";
		end
	end
	if (v74:IsReady() and v7:IsInMeleeRange(v75) and ((v24.Apocalypse:CooldownRemains() < v38) or v6:BuffUp(v24.FesteringScytheBuff))) then
		if v14(v74) then
			return "festering_strike aoe 10";
		end
	end
	if (v74:IsReady() and v100(v7) and v7:IsInMeleeRange(v75)) then
		if v14(v74) then
			return "festering_strike aoe 12";
		end
	end
	if (v70:IsReady() and v7:IsInRange(WoundSpenderRange) and (v73 >= (4 - 3)) and v113(v7)) then
		if v14(v71) then
			return "wound_spender aoe 14";
		end
	end
end
local function v124()
	if (v24.FesteringScytheAction:IsReady() and v7:IsInMeleeRange(33 - 19)) then
		if v14(v24.FesteringScytheAction) then
			return "festering_scythe aoe_burst 2";
		end
	end
	if (v24.Epidemic:IsReady() and v7:IsInRange(1246 - (696 + 510)) and not v24.VampiricStrikeAction:IsLearned() and (not v24.BurstingSores:IsAvailable() or (v24.BurstingSores:IsAvailable() and (((v24.FesteringWoundDebuff:AuraActiveCount() < v78) and (v24.FesteringWoundDebuff:AuraActiveCount() < (v78 * (0.4 - 0))) and v6:BuffUp(v24.SuddenDoomBuff)) or not v93)) or (v6:BuffUp(v24.SuddenDoomBuff) and (v6:BuffUp(v24.AFeastofSoulsBuff) or (v7:DebuffRemains(v24.DeathRotDebuff) < v6:GCD()) or (v7:DebuffStack(v24.DeathRotDebuff) < (1272 - (1091 + 171))))))) then
		if v14(v24.Epidemic) then
			return "epidemic aoe_burst 4";
		end
	end
	if (v70:IsReady() and v115(v7) and v7:IsInRange(WoundSpenderRange)) then
		if v34.CastCycle(v70, v76, v121, WoundSpenderRange) then
			return "wound_spender aoe_burst 6";
		end
	end
	if (v70:IsReady() and v7:IsInRange(WoundSpenderRange) and (v73 >= (1 + 0)) and v114(v7)) then
		if v14(v71) then
			return "wound_spender aoe_burst 8";
		end
	end
	if (v24.Epidemic:IsReady() and v7:IsInRange(125 - 85)) then
		if v14(v24.Epidemic) then
			return "epidemic aoe_burst 10";
		end
	end
	if (v74:IsReady() and v7:IsInMeleeRange(v75) and v101(v7)) then
		if v14(v74) then
			return "festering_strike aoe_burst 12";
		end
	end
	if (v70:IsReady() and v7:IsInRange(WoundSpenderRange) and (v73 >= (3 - 2))) then
		if v14(v71) then
			return "wound_spender aoe_burst 14";
		end
	end
end
local function v125()
	if (v24.FesteringScytheAction:IsReady() and v7:IsInMeleeRange(388 - (123 + 251))) then
		if v14(v24.FesteringScytheAction) then
			return "festering_scythe aoe_setup 2";
		end
	end
	if (v72:IsReady() and v26[19 - 15] and ((v77 >= (699 - (208 + 490))) or v7:IsInRange(1 + 7)) and (v35.Commons.DnDMoving or not v6:IsMoving()) and not v6:DnDTicking() and ((not v24.BurstingSores:IsAvailable() and not v24.VileContagion:IsAvailable()) or (v24.FesteringWoundDebuff:AuraActiveCount() == v78) or (v24.FesteringWoundDebuff:AuraActiveCount() >= (4 + 4)) or (v6:BuffUp(v24.DeathAndDecayBuff) and v24.Defile:IsAvailable()))) then
		if v13.CastTarget(v24.DeathAndDecay, v13.TName().PLAYER) then
			return "any_dnd aoe_setup 4";
		end
	end
	if (v70:IsReady() and v7:IsInRange(WoundSpenderRange)) then
		if v34.CastCycle(v70, v76, v121, WoundSpenderRange) then
			return "wound_spender aoe_setup 6";
		end
	end
	if (v74:IsReady() and v7:IsInMeleeRange(v75)) then
		if v34.CastTargetIf(v74, v76, "max", v98, v102, v75) then
			return "festering_strike aoe_setup 8";
		end
	end
	if (v74:IsReady() and v7:IsInMeleeRange(v75)) then
		if v34.CastTargetIf(v74, v76, "max", v98, v103, v75) then
			return "festering_strike aoe_setup 10";
		end
	end
	if (v24.Epidemic:IsReady() and v7:IsInRange(876 - (660 + 176)) and not v40 and v6:BuffUp(v24.SuddenDoomBuff)) then
		if v14(v24.Epidemic) then
			return "epidemic aoe_setup 12";
		end
	end
	if (v74:IsReady() and v7:IsInMeleeRange(v75)) then
		if v34.CastTargetIf(v74, v76, "min", v98, v104, v75) then
			return "festering_strike aoe_setup 14";
		end
	end
	if (v24.Epidemic:IsReady() and v7:IsInRange(5 + 35) and not v40) then
		if v14(v24.Epidemic) then
			return "epidemic aoe_setup 16";
		end
	end
end
local function v126()
	if (v24.DarkTransformation:IsCastable() and v7:IsInMeleeRange(207 - (14 + 188)) and v26[680 - (534 + 141)] and ((v36 and ((v24.Apocalypse:CooldownRemains() < (4 + 4)) or not v24.Apocalypse:IsAvailable() or (v78 >= (1 + 0)))) or (v82 < (20 + 0)))) then
		if v14(v24.DarkTransformation) then
			return "dark_transformation cds 2";
		end
	end
	if (v24.UnholyAssault:IsCastable() and v7:IsInMeleeRange(10 - 5) and v26[17 - 6] and v36 and ((v24.Apocalypse:CooldownRemains() < (v6:GCD() * (5 - 3))) or not v24.Apocalypse:IsAvailable() or ((v78 >= (2 + 0)) and v10:BuffUp(v24.DarkTransformation)))) then
		if v14(v24.UnholyAssault) then
			return "unholy_assault cds 4";
		end
	end
	if (v24.Apocalypse:IsReady() and v7:IsInMeleeRange(4 + 1) and v26[406 - (115 + 281)] and v36) then
		if v14(v24.Apocalypse) then
			return "apocalypse cds 10";
		end
	end
	if (v24.Outbreak:IsReady() and v7:IsSpellInRange(v24.Outbreak)) then
		if v34.CastCycle(v24.Outbreak, v79, v117, 93 - 53) then
			return "outbreak cds 8";
		end
	end
	if (v24.AbominationLimb:IsCastable() and v7:IsInRange(17 + 3) and v26[28 - 16] and ((v36 and v6:BuffDown(v24.SuddenDoomBuff) and ((v6:BuffUp(v24.FestermightBuff) and (v6:BuffStack(v24.FestermightBuff) > (29 - 21))) or not v24.Festermight:IsAvailable()) and ((v65 < (872 - (550 + 317))) or not v24.Apocalypse:IsAvailable()) and (v73 <= (2 - 0))) or (v82 < (16 - 4)))) then
		if v14(v24.AbominationLimb) then
			return "abomination_limb cds 12";
		end
	end
end
local function v127()
	if (v24.VileContagion:IsReady() and v109(v7) and v7:IsSpellInRange(v24.VileContagion)) then
		if v14(v24.VileContagion) then
			return "vile_contagion cds_aoe 2";
		end
	end
	if (v24.UnholyAssault:IsCastable() and v7:IsInMeleeRange(13 - 8) and v26[296 - (134 + 151)] and v107(v7)) then
		if v14(v24.UnholyAssault) then
			return "unholy_assault cds_aoe 4";
		end
	end
	if (v24.DarkTransformation:IsCastable() and v7:IsInMeleeRange(1670 - (970 + 695)) and v26[9 - 4] and v37 and ((v24.VileContagion:CooldownRemains() > (1995 - (582 + 1408))) or not v24.VileContagion:IsAvailable() or v6:DnDTicking() or (v72:CooldownRemains() < (10 - 7)))) then
		if v14(v24.DarkTransformation) then
			return "dark_transformation cds_aoe 6";
		end
	end
	if (v24.Outbreak:IsReady() and v7:IsSpellInRange(v24.Outbreak) and (v7:DebuffTicksRemain(v24.VirulentPlagueDebuff) < (6 - 1)) and v7:DebuffRefreshable(v24.VirulentPlagueDebuff) and (not v24.UnholyBlight:IsAvailable() or (v24.UnholyBlight:IsAvailable() and v24.DarkTransformation:CooldownDown())) and (not v24.RaiseAbomination:IsAvailable() or (v24.RaiseAbomination:IsAvailable() and v24.RaiseAbomination:CooldownDown()))) then
		if v14(v24.Outbreak) then
			return "outbreak cds_aoe 8";
		end
	end
	if (v24.Apocalypse:IsReady() and v7:IsInMeleeRange(18 - 13) and v26[1834 - (1195 + 629)] and v37 and (v6:Rune() <= (3 - 0))) then
		if v14(v24.Apocalypse) then
			return "apocalypse cds_aoe 10";
		end
	end
	if (v24.AbominationLimb:IsCastable() and v7:IsInRange(261 - (187 + 54)) and v26[792 - (162 + 618)] and v37) then
		if v14(v24.AbominationLimb) then
			return "abomination_limb cds_aoe 12";
		end
	end
end
local function v128()
	if (v24.DarkTransformation:IsCastable() and v7:IsInMeleeRange(4 + 1) and v26[4 + 1] and v37 and v6:BuffUp(v24.DeathAndDecayBuff)) then
		if v14(v24.DarkTransformation) then
			return "dark_transformation cds_aoe_san 2";
		end
	end
	if (v24.VileContagion:IsReady() and v7:IsSpellInRange(v24.VileContagion) and v109(v7)) then
		if v14(v24.VileContagion) then
			return "vile_contagion cds_aoe_san 4";
		end
	end
	if (v24.UnholyAssault:IsCastable() and v7:IsInMeleeRange(10 - 5) and v26[18 - 7] and v108(v7) and v37) then
		if v14(v24.UnholyAssault) then
			return "unholy_assault cds_aoe_san 6";
		end
	end
	if (v24.Outbreak:IsReady() and v7:IsSpellInRange(v24.Outbreak) and (v7:DebuffTicksRemain(v24.VirulentPlagueDebuff) < (1 + 4)) and (v7:DebuffRefreshable(v24.VirulentPlagueDebuff) or (v24.Morbidity:IsAvailable() and v6:BuffDown(v24.GiftoftheSanlaynBuff) and v24.Superstrain:IsAvailable() and v7:DebuffRefreshable(v24.FrostFeverDebuff) and v7:DebuffRefreshable(v24.BloodPlagueDebuff))) and (not v24.UnholyBlight:IsAvailable() or (v24.UnholyBlight:IsAvailable() and v24.DarkTransformation:CooldownDown())) and (not v24.RaiseAbomination:IsAvailable() or (v24.RaiseAbomination:IsAvailable() and v24.RaiseAbomination:CooldownDown()))) then
		if v14(v24.Outbreak) then
			return "outbreak cds_aoe_san 8";
		end
	end
	if (v24.Apocalypse:IsReady() and v7:IsInMeleeRange(1641 - (1373 + 263)) and v26[1010 - (451 + 549)] and v37 and (v6:Rune() <= (1 + 2))) then
		if v14(v24.Apocalypse) then
			return "apocalypse cds_aoe_san 10";
		end
	end
	if (v24.AbominationLimb:IsCastable() and v7:IsInRange(31 - 11) and v26[19 - 7] and v37) then
		if v14(v24.AbominationLimb) then
			return "abomination_limb cds_aoe_san 12";
		end
	end
end
local function v129()
	if (v24.DarkTransformation:IsCastable() and v7:IsInMeleeRange(1389 - (746 + 638)) and v26[2 + 3] and (v78 >= (1 - 0)) and v36 and ((v24.Apocalypse:IsAvailable() and v64) or not v24.Apocalypse:IsAvailable())) then
		if v14(v24.DarkTransformation) then
			return "dark_transformation cds_san 2";
		end
	end
	if (v24.UnholyAssault:IsCastable() and v7:IsInMeleeRange(346 - (218 + 123)) and v26[1592 - (1535 + 46)] and v36 and v10:BuffUp(v24.DarkTransformation) and (v10:BuffRemains(v24.DarkTransformation) < (12 + 0))) then
		if v14(v24.UnholyAssault) then
			return "unholy_assault cds_san 4";
		end
	end
	if (v24.Apocalypse:IsReady() and v7:IsInMeleeRange(1 + 4) and v26[570 - (306 + 254)] and v36 and (v73 >= (1 + 2))) then
		if v14(v24.Apocalypse) then
			return "apocalypse cds_san 6";
		end
	end
	if (v24.Outbreak:IsReady() and v7:IsSpellInRange(v24.Outbreak)) then
		if v34.CastCycle(v24.Outbreak, v79, v118, 78 - 38) then
			return "outbreak cds_san 8";
		end
	end
	if (v24.AbominationLimb:IsCastable() and v7:IsInRange(1487 - (899 + 568)) and v26[8 + 4] and (v78 >= (0 - 0)) and v36 and v10:BuffDown(v24.DarkTransformation) and v6:BuffDown(v24.SuddenDoomBuff) and v6:BuffUp(v24.FestermightBuff) and (v73 <= (605 - (268 + 335)))) then
		if v14(v24.AbominationLimb) then
			return "abomination_limb cds_san 10";
		end
	end
end
local function v130()
	if v35.Commons.Enabled.Potions then
		local v222 = v34.PotionSelected();
		if (v222 and v26[299 - (60 + 230)]) then
			if (v222:IsReady() and (((v78 >= (573 - (426 + 146))) and (not v24.SummonGargoyle:IsAvailable() or (v24.SummonGargoyle:CooldownRemains() > (8 + 52))) and ((v10:BuffUp(v24.DarkTransformation) and ((1486 - (282 + 1174)) >= v10:BuffRemains(v24.DarkTransformation))) or (v66 and (v67 <= (841 - (569 + 242)))) or (v64 and (v65 <= (86 - 56))) or (v62 and (v63 <= (2 + 28))))) or (v82 <= (1054 - (706 + 318))))) then
				if v13.CastMacro(1254 - (721 + 530), nil, nil, v222) then
					return "potion high_prio_actions 2";
				end
			end
		end
	end
	if (v24.ArmyoftheDead:IsReady() and v7:IsInMeleeRange(1276 - (945 + 326)) and v26[41 - 24] and (((v36 or v37) and ((v24.CommanderoftheDead:IsAvailable() and (v24.DarkTransformation:CooldownRemains() < (5 + 0))) or (not v24.CommanderoftheDead:IsAvailable() and (v78 >= (701 - (271 + 429)))))) or (v82 < (33 + 2)))) then
		if v14(v24.ArmyoftheDead) then
			return "army_of_the_dead cds_shared 4";
		end
	end
	if (v24.RaiseAbomination:IsCastable() and v7:IsInMeleeRange(1505 - (1408 + 92)) and v26[1102 - (461 + 625)] and (v36 or v37 or (v82 < (1318 - (993 + 295))))) then
		if v14(v24.RaiseAbomination) then
			return "raise_abomination cds_shared 6";
		end
	end
	if (v24.SummonGargoyle:IsReady() and v7:IsInMeleeRange(1 + 4) and v26[1186 - (418 + 753)] and (v36 or v37) and (v6:BuffUp(v24.CommanderoftheDeadBuff) or (not v24.CommanderoftheDead:IsAvailable() and (v78 >= (1 + 0))))) then
		if v14(v24.SummonGargoyle) then
			return "summon_gargoyle cds_shared 8";
		end
	end
end
local function v131()
	if (v72:IsReady() and v26[1 + 3] and ((v77 >= (1 + 0)) or v7:IsInRange(3 + 5)) and (v35.Commons.DnDMoving or not v6:IsMoving()) and not v6:DnDTicking()) then
		if v13.CastTarget(v24.DeathAndDecay, v13.TName().PLAYER) then
			return "any_dnd cleave 2";
		end
	end
	if (v24.DeathCoil:IsReady() and v7:IsSpellInRange(v24.DeathCoil) and not v40 and v24.ImprovedDeathCoil:IsAvailable()) then
		if v14(v24.DeathCoil) then
			return "death_coil cleave 4";
		end
	end
	if (v24.Epidemic:IsReady() and v7:IsInRange(569 - (406 + 123)) and not v40 and not v24.ImprovedDeathCoil:IsAvailable()) then
		if v14(v24.Epidemic) then
			return "epidemic cleave 6";
		end
	end
	if (v74:IsReady() and v7:IsInMeleeRange(v75) and v105(v7)) then
		if v14(v74) then
			return "festering_strike cleave 8";
		end
	end
	if (v74:IsReady() and v7:IsInMeleeRange(v75) and v106(v7)) then
		if v14(v74) then
			return "festering_strike cleave 10";
		end
	end
	if (v70:IsReady() and v7:IsInRange(WoundSpenderRange) and (v73 >= (1770 - (1749 + 20))) and v39) then
		if v14(v71) then
			return "wound_spender cleave 12";
		end
	end
end
local function v132()
	if (v24.ArcaneTorrent:IsCastable() and v7:IsInRange(2 + 6) and v26[1328 - (1249 + 73)] and (v6:RunicPower() < (8 + 12)) and (v6:Rune() < (1147 - (466 + 679)))) then
		if v14(v24.ArcaneTorrent) then
			return "arcane_torrent racials 2";
		end
	end
	if (v24.BloodFury:IsCastable() and v7:IsInRange(11 - 6) and v26[17 - 11] and ((((v24.BloodFury:BaseDuration() + (1903 - (106 + 1794))) >= v69) and v68) or ((not v24.SummonGargoyle:IsAvailable() or (v24.SummonGargoyle:CooldownRemains() > (19 + 41))) and ((v66 and (v67 <= (v24.BloodFury:BaseDuration() + 1 + 2))) or (v64 and (v65 <= (v24.BloodFury:BaseDuration() + (8 - 5)))) or ((v78 >= (5 - 3)) and v6:DnDTicking()))) or (v82 <= (v24.BloodFury:BaseDuration() + (117 - (4 + 110)))))) then
		if v14(v24.BloodFury) then
			return "blood_fury racials 4";
		end
	end
	if (v24.Berserking:IsCastable() and v7:IsInRange(589 - (57 + 527)) and v26[1433 - (41 + 1386)] and ((((v24.Berserking:BaseDuration() + (106 - (17 + 86))) >= v69) and v68) or ((not v24.SummonGargoyle:IsAvailable() or (v24.SummonGargoyle:CooldownRemains() > (41 + 19))) and ((v66 and (v67 <= (v24.Berserking:BaseDuration() + (6 - 3)))) or (v64 and (v65 <= (v24.Berserking:BaseDuration() + (8 - 5)))) or ((v78 >= (168 - (122 + 44))) and v6:DnDTicking()))) or (v82 <= (v24.Berserking:BaseDuration() + (5 - 2))))) then
		if v14(v24.Berserking) then
			return "berserking racials 6";
		end
	end
	if (v24.LightsJudgment:IsCastable() and v7:IsInRange(16 - 11) and v26[5 + 1] and v6:BuffUp(v24.UnholyStrengthBuff) and (not v24.Festermight:IsAvailable() or (v6:BuffRemains(v24.FestermightBuff) < v7:TimeToDie()) or (v6:BuffRemains(v24.UnholyStrengthBuff) < v7:TimeToDie()))) then
		if v14(v24.LightsJudgment) then
			return "lights_judgment racials 8";
		end
	end
	if (v24.AncestralCall:IsCastable() and v7:IsInRange(1 + 4) and v26[11 - 5] and ((((83 - (30 + 35)) >= v69) and v68) or ((not v24.SummonGargoyle:IsAvailable() or (v24.SummonGargoyle:CooldownRemains() > (42 + 18))) and ((v66 and (v67 <= (1275 - (1043 + 214)))) or (v64 and (v65 <= (67 - 49))) or ((v78 >= (1214 - (323 + 889))) and v6:DnDTicking()))) or (v82 <= (48 - 30)))) then
		if v14(v24.AncestralCall) then
			return "ancestral_call racials 10";
		end
	end
	if (v24.ArcanePulse:IsCastable() and v7:IsInRange(588 - (361 + 219)) and v26[326 - (53 + 267)] and ((v78 >= (1 + 1)) or ((v6:Rune() <= (414 - (15 + 398))) and (v6:RunicPowerDeficit() >= (1042 - (18 + 964)))))) then
		if v14(v24.ArcanePulse) then
			return "arcane_pulse racials 12";
		end
	end
	if (v24.Fireblood:IsCastable() and v7:IsInRange(18 - 13) and v26[4 + 2] and ((((v24.Fireblood:BaseDuration() + 2 + 1) >= v69) and v68) or ((not v24.SummonGargoyle:IsAvailable() or (v24.SummonGargoyle:CooldownRemains() > (910 - (20 + 830)))) and ((v66 and (v67 <= (v24.Fireblood:BaseDuration() + 3 + 0))) or (v64 and (v65 <= (v24.Fireblood:BaseDuration() + (129 - (116 + 10))))) or ((v78 >= (1 + 1)) and v6:DnDTicking()))) or (v82 <= (v24.Fireblood:BaseDuration() + (741 - (542 + 196)))))) then
		if v14(v24.Fireblood) then
			return "fireblood racials 14";
		end
	end
	if (v24.BagofTricks:IsCastable() and v7:IsInRange(10 - 5) and v26[2 + 4] and (v78 <= (1 + 0)) and (v6:BuffUp(v24.UnholyStrengthBuff) or (v82 < (2 + 3)))) then
		if v14(v24.BagofTricks) then
			return "bag_of_tricks racials 16";
		end
	end
end
local function v133()
	if (v24.AntiMagicShell:IsCastable() and v35.Commons.UseAMSAMZOffensively and (v35.Unholy.AMSAbsorbPercent > (0 - 0)) and (v6:RunicPower() < (102 - 62))) then
		if v14(v24.AntiMagicShell) then
			return "antimagic_shell san_fishing 2";
		end
	end
	if (v72:IsReady() and v26[1555 - (1126 + 425)] and ((v77 >= (406 - (118 + 287))) or v7:IsInRange(31 - 23)) and (v35.Commons.DnDMoving or not v6:IsMoving()) and v6:BuffDown(v24.DeathAndDecayBuff) and not v24.VampiricStrikeAction:IsLearned()) then
		if v13.CastTarget(v24.DeathAndDecay, v13.TName().PLAYER) then
			return "any_dnd san_fishing 4";
		end
	end
	if (v24.DeathCoil:IsReady() and v7:IsSpellInRange(v24.DeathCoil) and v6:BuffUp(v24.SuddenDoomBuff) and v24.DoomedBidding:IsAvailable()) then
		if v14(v24.DeathCoil) then
			return "death_coil san_fishing 6";
		end
	end
	if (v24.SoulReaper:IsReady() and v7:IsInMeleeRange(1126 - (118 + 1003)) and ((v7:HealthPercentage() <= (102 - 67)) or (v7:TimeToX(412 - (142 + 235)) <= (22 - 17))) and (v7:TimeToDie() > (2 + 3))) then
		if v14(v24.SoulReaper) then
			return "soul_reaper san_fishing 8";
		end
	end
	if (v24.DeathCoil:IsReady() and v7:IsSpellInRange(v24.DeathCoil) and not v24.VampiricStrikeAction:IsLearned()) then
		if v14(v24.DeathCoil) then
			return "death_coil san_fishing 10";
		end
	end
	if (v70:IsReady() and v7:IsInRange(WoundSpenderRange) and (v73 >= (978 - (553 + 424))) and (((v73 >= ((5 - 2) - v17(v62))) and (v24.Apocalypse:CooldownRemains() > v38)) or v24.VampiricStrikeAction:IsLearned())) then
		if v14(v71) then
			return "wound_spender san_fishing 12";
		end
	end
	if (v74:IsReady() and v7:IsInMeleeRange(v75) and (v73 < ((3 + 0) - v17(v62)))) then
		if v14(v74) then
			return "festering_strike san_fishing 14";
		end
	end
end
local function v134()
	if (v72:IsReady() and v26[4 + 0] and ((v77 >= (1 + 0)) or v7:IsInRange(4 + 4)) and (v35.Commons.DnDMoving or not v6:IsMoving()) and v6:BuffDown(v24.DeathAndDecayBuff) and v24.UnholyGround:IsAvailable() and (v24.DarkTransformation:CooldownRemains() < (3 + 2))) then
		if v13.CastTarget(v24.DeathAndDecay, v13.TName().PLAYER) then
			return "any_dnd san_st 1";
		end
	end
	if (v24.DeathCoil:IsReady() and v7:IsSpellInRange(v24.DeathCoil) and ((v6:BuffUp(v24.SuddenDoomBuff) and v6:BuffUp(v24.GiftoftheSanlaynBuff) and (v24.DoomedBidding:IsAvailable() or v24.RottenTouch:IsAvailable())) or ((v6:Rune() < (4 - 2)) and v6:BuffDown(v24.RunicCorruptionBuff)))) then
		if v14(v24.DeathCoil) then
			return "death_coil san_st 2";
		end
	end
	if (v70:IsReady() and v7:IsInRange(WoundSpenderRange) and (v73 >= (2 - 1)) and (((v6:BuffRemains(v24.EssenceoftheBloodQueenBuff) < (6 - 3)) and v24.VampiricStrikeAction:IsLearned()) or (v24.GiftoftheSanlayn:IsAvailable() and v10:BuffUp(v24.DarkTransformation) and (v10:BuffRemains(v24.DarkTransformation) < v6:GCD())))) then
		if v14(v71) then
			return "wound_spender san_st 4";
		end
	end
	if (v24.SoulReaper:IsReady() and v7:IsInMeleeRange(2 + 3) and ((v7:HealthPercentage() <= (169 - 134)) or (v7:TimeToX(788 - (239 + 514)) <= (2 + 3))) and (v7:TimeToDie() > (1334 - (797 + 532))) and v6:BuffDown(v24.GiftoftheSanlaynBuff)) then
		if v14(v24.SoulReaper) then
			return "soul_reaper san_st 6";
		end
	end
	if (v74:IsReady() and v7:IsInMeleeRange(v75) and (((v73 < (3 + 1)) and (v24.Apocalypse:CooldownRemains() < v38)) or (((v24.GiftoftheSanlayn:IsAvailable() and v6:BuffDown(v24.GiftoftheSanlaynBuff)) or not v24.GiftoftheSanlayn:IsAvailable()) and (v6:BuffUp(v24.FesteringScytheBuff) or (v73 <= ((1 + 0) - v17(v62))))))) then
		if v14(v74) then
			return "festering_strike san_st 8";
		end
	end
	if (v70:IsReady() and v7:IsInRange(WoundSpenderRange) and (v73 >= (2 - 1)) and (((v73 >= ((1205 - (373 + 829)) - v17(v62))) and (v24.Apocalypse:CooldownRemains() > v38)) or (v24.VampiricStrikeAction:IsLearned() and (v24.Apocalypse:CooldownRemains() > v38)))) then
		if v14(v71) then
			return "wound_spender san_st 10";
		end
	end
	if (v24.DeathCoil:IsReady() and v7:IsSpellInRange(v24.DeathCoil) and ((not v40 and (v7:DebuffRemains(v24.DeathRotDebuff) < v6:GCD())) or (v6:BuffUp(v24.SuddenDoomBuff) and (v73 >= (732 - (476 + 255)))) or (v6:Rune() < (1132 - (369 + 761))))) then
		if v14(v24.DeathCoil) then
			return "death_coil san_st 12";
		end
	end
	if (v70:IsReady() and v7:IsInRange(WoundSpenderRange) and (v73 >= (1 + 0)) and (v73 > (6 - 2))) then
		if v14(v71) then
			return "wound_spender san_st 14";
		end
	end
	if (v24.DeathCoil:IsReady() and v7:IsSpellInRange(v24.DeathCoil) and not v40) then
		if v14(v24.DeathCoil) then
			return "death_coil san_st 16";
		end
	end
end
local function v135()
	if (v35.Commons.Enabled.Items and v25.Fyralath:IsReady() and v7:DebuffUp(v24.MarkofFyralathDebuff) and ((v78 < (9 - 4)) or (v78 > (259 - (64 + 174))) or (v82 < (1 + 3))) and (v62 or v66 or (not v24.RaiseAbomination:IsAvailable() and not v24.ArmyoftheDead:IsAvailable()) or (v3.CombatTime() > (22 - 7)))) then
		v13.CastMacro(337 - (144 + 192), nil, nil, v25.Fyralath);
		return "fyralath_the_dreamrender san_trinkets 2";
	end
end
if v35.Commons.Enabled.Trinkets then
	if (v25.TreacherousTransmitter:IsEquippedAndReady() and (((v42 == v25.TreacherousTransmitter:ID()) and v26[223 - (42 + 174)]) or ((v43 == v25.TreacherousTransmitter:ID()) and v26[7 + 1].Trinket2Setting)) and v7:IsInMeleeRange(5 + 0) and (v37 or v36) and (v24.DarkTransformation:CooldownRemains() < (2 + 1))) then
		if v14(v25.TreacherousTransmitter, nil) then
			return "treacherous_transmitter san_trinkets 2";
		end
	end
	if (v29:IsReady() and v26[1511 - (363 + 1141)] and not v52 and ((v54 and v10:BuffUp(v24.DarkTransformation) and (v10:BuffRemains(v24.DarkTransformation) < (v56 * (1580.73 - (1183 + 397)))) and ((v60 == (2 - 1)) or v30:CooldownDown() or not v30:HasCooldown())) or (v56 >= v82))) then
		if v14(v29, true) then
			return "Generic use_item for " .. v29:Name() .. " san_trinkets 4";
		end
	end
	if (v30:IsReady() and v26[6 + 2] and not v53 and ((v55 and v10:BuffUp(v24.DarkTransformation) and (v10:BuffRemains(v24.DarkTransformation) < (v57 * (0.73 + 0))) and ((v60 == (1977 - (1913 + 62))) or v29:CooldownDown() or not v29:HasCooldown())) or (v57 >= v82))) then
		if v14(v30, true) then
			return "Generic use_item for " .. v30:Name() .. " san_trinkets 6";
		end
	end
	if (v29:IsReady() and v26[5 + 2] and not v52 and ((not v54 and (((v48 > (0 - 0)) and v6:BuffDown(v24.GiftoftheSanlaynBuff)) or (v48 == (1933 - (565 + 1368)))) and ((v61 == (3 - 2)) or v30:CooldownDown() or not v30:HasCooldown() or (not v24.SummonGargoyle:IsAvailable() and not v24.ArmyoftheDead:IsAvailable() and not v24.RaiseAbomination:IsAvailable()) or (not v24.SummonGargoyle:IsAvailable() and v24.ArmyoftheDead:IsAvailable() and ((not v24.RaiseAbomination:IsAvailable() and (v24.ArmyoftheDead:CooldownRemains() > (1681 - (1477 + 184)))) or (v24.RaiseAbomination:IsAvailable() and (v24.RaiseAbomination:CooldownRemains() > (27 - 7))))) or (not v24.SummonGargoyle:IsAvailable() and not v24.ArmyoftheDead:IsAvailable() and not v24.RaiseAbomination:IsAvailable() and (v24.DarkTransformation:CooldownRemains() > (19 + 1))) or (v24.SummonGargoyle:IsAvailable() and (v24.SummonGargoyle:CooldownRemains() > (876 - (564 + 292))) and not v68))) or (v82 < (25 - 10)))) then
		if v14(v29, true) then
			return "Generic use_item for " .. v29:Name() .. " san_trinkets 8";
		end
	end
	if (v30:IsReady() and v26[23 - 15] and not v53 and ((not v55 and (((v49 > (304 - (244 + 60))) and v6:BuffDown(v24.GiftoftheSanlaynBuff)) or (v49 == (0 + 0))) and ((v61 == (478 - (41 + 435))) or v29:CooldownDown() or not v29:HasCooldown() or (not v24.SummonGargoyle:IsAvailable() and not v24.ArmyoftheDead:IsAvailable() and not v24.RaiseAbomination:IsAvailable()) or (not v24.SummonGargoyle:IsAvailable() and v24.ArmyoftheDead:IsAvailable() and ((not v24.RaiseAbomination:IsAvailable() and (v24.ArmyoftheDead:CooldownRemains() > (1021 - (938 + 63)))) or (v24.RaiseAbomination:IsAvailable() and (v24.RaiseAbomination:CooldownRemains() > (16 + 4))))) or (not SummonGargoyle:IsAvailable() and not v24.ArmyoftheDead:IsAvailable() and not v24.RaiseAbomination:IsAvailable() and (v24.DarkTransformation:CooldownRemains() > (1145 - (936 + 189)))) or (v24.SummonGargoyle:IsAvailable() and (v24.SummonGargoyle:CooldownRemains() > (7 + 13)) and not v68))) or (v82 < (1628 - (1565 + 48))))) then
		if v14(v30, true) then
			return "Generic use_item for " .. v30:Name() .. " san_trinkets 10";
		end
	end
	if (v35.Commons.Enabled.Items and WeaponSetting) then
		local v225, v226, v227 = v6:GetUseableItems(v27, nil, true);
		if (v225 and v7:IsInMeleeRange(4 + 1) and (not v54 or v29:CooldownDown()) and (not v55 or v30:CooldownDown())) then
			v13.CastMacro(1139 - (782 + 356), nil, nil);
			return v225:Name() .. " san_trinkets 12";
		end
	end
end
local function v136()
	if (v24.SoulReaper:IsReady() and v7:IsInMeleeRange(272 - (176 + 91)) and ((v7:HealthPercentage() <= (91 - 56)) or (v7:TimeToX(51 - 16) <= (1097 - (975 + 117)))) and (v7:TimeToDie() > (1880 - (157 + 1718)))) then
		if v14(v24.SoulReaper) then
			return "soul_reaper st 2";
		end
	end
	if (v70:IsReady() and v7:IsInMeleeRange(v75) and (v7:DebuffUp(v24.TrollbaneSlowDebuff))) then
		if v14(v70) then
			return "wound_spender st 4";
		end
	end
	if (v72:IsReady() and v26[4 + 0] and ((v77 >= (3 - 2)) or v7:IsInRange(27 - 19)) and (v35.Commons.DnDMoving or not v6:IsMoving()) and v24.UnholyGround:IsAvailable() and v6:BuffDown(v24.DeathAndDecayBuff) and (v64 or v62 or v68)) then
		if v13.CastTarget(v24.DeathAndDecay, v13.TName().PLAYER) then
			return "any_dnd st 6";
		end
	end
	if (v24.DeathCoil:IsReady() and v7:IsSpellInRange(v24.DeathCoil) and ((not v40 and v41) or (v82 < (1028 - (697 + 321))))) then
		if v14(v24.DeathCoil) then
			return "death_coil st 8";
		end
	end
	if (v74:IsReady() and v7:IsInMeleeRange(v75) and (v73 < (10 - 6)) and (not v39 or v6:BuffUp(v24.FesteringScytheBuff))) then
		if v14(v74) then
			return "festering_strike st 10";
		end
	end
	if (v70:IsReady() and v7:IsInRange(WoundSpenderRange) and (v73 >= (1 - 0)) and v39) then
		if v14(v71) then
			return "wound_spender st 12";
		end
	end
	if (v24.DeathCoil:IsReady() and v7:IsSpellInRange(v24.DeathCoil) and not v40) then
		if v14(v24.DeathCoil) then
			return "death_coil st 14";
		end
	end
	if (v70:IsReady() and v7:IsInRange(WoundSpenderRange) and (v73 >= (2 - 1)) and not v39 and (v73 >= (2 + 2))) then
		if v14(v71) then
			return "wound_spender st 16";
		end
	end
end
local function v137()
	if (v35.Commons.Enabled.Items and WeaponSetting and v25.Fyralath:IsReady() and v7:DebuffUp(v24.MarkofFyralathDebuff) and ((v78 < (9 - 4)) or (v78 > (56 - 35)) or (v82 < (1231 - (322 + 905)))) and (v62 or v66 or (not v24.RaiseAbomination:IsAvailable() and not v24.ArmyoftheDead:IsAvailable()) or (v3.CombatTime() > (626 - (602 + 9))))) then
		v13.CastMacro(1190 - (449 + 740), nil, nil, v25.Fyralath);
		return "weapon cast";
	end
	if v35.Commons.Enabled.Trinkets then
		if (v25.TreacherousTransmitter:IsEquippedAndReady() and (((v42 == v25.TreacherousTransmitter:ID()) and v26[879 - (826 + 46)]) or ((v43 == v25.TreacherousTransmitter:ID()) and v26[955 - (245 + 702)])) and v7:IsInMeleeRange(15 - 10) and (v37 or v36) and (v24.DarkTransformation:CooldownRemains() < (1 + 2))) then
			if v14(v25.TreacherousTransmitter, nil) then
				return "treacherous_transmitter san_trinkets 2";
			end
		end
		if (v29:IsReady() and v26[1905 - (260 + 1638)] and ((v54 and ((not v24.SummonGargoyle:IsAvailable() and (((not v24.ArmyoftheDead:IsAvailable() or (v24.ArmyoftheDead:IsAvailable() and (v24.ArmyoftheDead:CooldownRemains() > (v50 * (440.51 - (382 + 58))))) or v35.Commons.DisableAotD or (v24.RaiseAbomination:IsAvailable() and (v24.RaiseAbomination:CooldownRemains() > (v50 * (0.51 - 0))))) and ((((17 + 3) > v56) and v64 and (v65 <= (v56 * (1.2 - 0)))) or (((59 - 39) <= v56) and (v24.Apocalypse:CooldownRemains() < v6:GCD()) and v10:BuffUp(v24.DarkTransformation)) or ((not v24.Apocalypse:IsAvailable() or (v78 >= (1207 - (902 + 303)))) and v10:BuffUp(v24.DarkTransformation)))) or (v66 and (v67 < (v56 * (1.2 - 0)))) or (v62 and (v63 < (v56 * (2.2 - 1)))))) or (v24.SummonGargoyle:IsAvailable() and v68 and (v69 < (v56 * (1.2 + 0)))) or (v24.SummonGargoyle:CooldownRemains() > (1770 - (1121 + 569)))) and ((v60 == (215 - (22 + 192))) or Trinekt2:CooldownDown() or not v30:HasCooldown())) or (v56 >= v82))) then
			if v14(v29, true) then
				return "Generic use_item for " .. v29:Name() .. " trinkets 4";
			end
		end
		if (v30:IsReady() and v26[691 - (483 + 200)] and ((v55 and ((not v24.SummonGargoyle:IsAvailable() and (((not v24.ArmyoftheDead:IsAvailable() or (v24.ArmyoftheDead:IsAvailable() and (v24.ArmyoftheDead:CooldownRemains() > (v51 * (1463.51 - (1404 + 59))))) or v35.Commons.DisableAotD or (v24.RaiseAbomination:IsAvailable() and (v24.RaiseAbomination:CooldownRemains() > (v51 * (0.51 - 0))))) and ((((26 - 6) > v57) and v64 and (v65 <= (v57 * (766.2 - (468 + 297))))) or (((582 - (334 + 228)) <= v57) and (v24.Apocalypse:CooldownRemains() < v6:GCD()) and v10:BuffUp(v24.DarkTransformation)) or ((not v24.Apocalypse:IsAvailable() or (v78 >= (6 - 4))) and v10:BuffUp(v24.DarkTransformation)))) or (v66 and (v67 < (v57 * (2.2 - 1)))) or (v62 and (v63 < (v57 * (1.2 - 0)))))) or (v24.SummonGargoyle:IsAvailable() and v68 and (v69 < (v57 * (1.2 + 0)))) or (v24.SummonGargoyle:CooldownRemains() > (316 - (141 + 95)))) and ((v60 == (2 + 0)) or v29:CooldownDown() or not v29:HasCooldown())) or (v57 >= v82))) then
			if v14(v30, true) then
				return "Generic use_item for " .. v30:Name() .. " trinkets 6";
			end
		end
		if (v29:IsReady() and v26[17 - 10] and ((not v54 and ((v61 == (2 - 1)) or v30:CooldownDown() or not v30:HasCooldown() or (not v24.SummonGargoyle:IsAvailable() and not v24.ArmyoftheDead:IsAvailable() and not v24.RaiseAbomination:IsAvailable()) or (not v24.SummonGargoyle:IsAvailable() and v24.ArmyoftheDead:IsAvailable() and ((not v24.RaiseAbomination:IsAvailable() and (v24.ArmyoftheDead:CooldownRemains() > (5 + 15))) or (v24.RaiseAbomination:IsAvailable() and (v24.RaiseAbomination:CooldownRemains() > (54 - 34))))) or (not v24.SummonGargoyle:IsAvailable() and not v24.ArmyoftheDead:IsAvailable() and not v24.RaiseAbomination:IsAvailable() and (v24.DarkTransformation:CooldownRemains() > (15 + 5))) or (v24.SummonGargoyle:IsAvailable() and (v24.SummonGargoyle:CooldownRemains() > (11 + 9)) and not v68))) or (v82 < (21 - 6)))) then
			if v14(v29, true) then
				return "Generic use_item for " .. v29:Name() .. " trinkets 8";
			end
		end
		if (v30:IsReady() and v26[5 + 3] and ((not v55 and ((v61 == (165 - (92 + 71))) or v29:CooldownDown() or not v29:HasCooldown() or (not v24.SummonGargoyle:IsAvailable() and not v24.ArmyoftheDead:IsAvailable() and not v24.RaiseAbomination:IsAvailable()) or (not v24.SummonGargoyle:IsAvailable() and v24.ArmyoftheDead:IsAvailable() and ((not v24.RaiseAbomination:IsAvailable() and (v24.ArmyoftheDead:CooldownRemains() > (10 + 10))) or (v24.RaiseAbomination:IsAvailable() and (v24.RaiseAbomination:CooldownRemains() > (33 - 13))))) or (not v24.SummonGargoyle:IsAvailable() and not v24.ArmyoftheDead:IsAvailable() and not v24.RaiseAbomination:IsAvailable() and (v24.DarkTransformation:CooldownRemains() > (785 - (574 + 191)))) or (v24.SummonGargoyle:IsAvailable() and (v24.SummonGargoyle:CooldownRemains() > (17 + 3)) and not v68))) or (v82 < (37 - 22)))) then
			if v14(v30, true) then
				return "Generic use_item for " .. v30:Name() .. " trinkets 10";
			end
		end
	end
end
local function v138()
	v36 = (v78 <= (1 + 0)) or not v16();
	v37 = (v78 >= (851 - (254 + 595))) and (v83 > (132 - (55 + 71)));
	v38 = ((v24.Apocalypse:CooldownRemains() < (6 - 1)) and (v73 < (1791 - (573 + 1217))) and (v24.UnholyAssault:CooldownRemains() > (13 - 8)) and (1 + 2)) or (0 - 0);
	v39 = (((v24.Apocalypse:CooldownRemains() > v38) or not v24.Apocalypse:IsAvailable()) and (((v73 >= (940 - (714 + 225))) and (v24.UnholyAssault:CooldownRemains() < (58 - 38)) and v24.UnholyAssault:IsAvailable() and v36) or (v7:DebuffUp(v24.RottenTouchDebuff) and (v73 >= (1 - 0))) or (v73 >= ((1 + 3) - v17(v62))))) or ((v82 < (6 - 1)) and (v73 >= (807 - (118 + 688))));
	v40 = v24.VileContagion:IsAvailable() and (v24.VileContagion:CooldownRemains() < (53 - (25 + 23))) and (v6:RunicPower() < (6 + 24));
	v41 = (not v24.RottenTouch:IsAvailable() or (v24.RottenTouch:IsAvailable() and v7:DebuffDown(v24.RottenTouchDebuff)) or (v6:RunicPowerDeficit() < (1906 - (927 + 959)))) and ((v24.ImprovedDeathCoil:IsAvailable() and ((v78 == (6 - 4)) or v24.CoilofDevastation:IsAvailable())) or (v6:Rune() < (735 - (16 + 716))) or v68 or v6:BuffUp(v24.SuddenDoomBuff) or (not v39 and (v73 >= (7 - 3))));
end
local function v139()
	v26[98 - (11 + 86)] = v13.ToggleIconFrame:GetToggle(2 - 1);
	v26[287 - (175 + 110)] = v13.ToggleIconFrame:GetToggle(4 - 2);
	v26[14 - 11] = v13.ToggleIconFrame:GetToggle(1799 - (503 + 1293));
	v26[11 - 7] = v13.ToggleIconFrame:GetToggle(3 + 1) and (v35.Commons.DnDMoving or not v6:IsMoving()) and v87(1069 - (810 + 251));
end
local function v140()
	v76 = v6:GetEnemiesInMeleeRange(6 + 2);
	v79 = v7:GetEnemiesInSplashRange(4 + 6);
	if v16() then
		v77 = #v76;
		v80 = v7:GetEnemiesInSplashRangeCount(10 + 0);
	else
		v77 = 534 - (43 + 490);
		v80 = 734 - (711 + 22);
	end
	v78 = v20(v77, v80);
end
local function v141()
	v81 = v96(v79);
end
local function v142()
	v62 = v84:AbomActive();
	v63 = v84:AbomRemains();
	v64 = v24.Apocalypse:TimeSinceLastCast() <= (58 - 43);
	v65 = (v64 and ((874 - (240 + 619)) - v24.Apocalypse:TimeSinceLastCast())) or (0 + 0);
	v66 = v24.ArmyoftheDead:TimeSinceLastCast() <= (47 - 17);
	v67 = (v66 and ((2 + 28) - v24.ArmyoftheDead:TimeSinceLastCast())) or (1744 - (1344 + 400));
	v68 = v84:GargActive();
	v69 = v84:GargRemains();
	v73 = v7:DebuffStack(v24.FesteringWoundDebuff);
	if v24.FesteringScytheAction:IsLearned() then
		v74 = v24.FesteringScytheAction;
		v75 = 419 - (255 + 150);
	else
		v74 = v24.FesteringStrike;
		v75 = 4 + 1;
	end
end
local function v143()
	if v6:IsChanneling(v25.ManicGrieftorch.ItemUseSpell) then
		return "Dont cut Torch";
	end
	v139();
	v140();
	v141();
	v78 = v20(v77, v80);
	v142();
	v70 = (v24.VampiricStrikeAction:IsLearned() and v24.VampiricStrikeAction) or ((v24.ClawingShadows:IsAvailable()) and v24.ClawingShadows) or v24.ScourgeStrike;
	v26[3 + 2] = v85(v35.Unholy.DarkTransformationSetting) and v87(v35.TTD.DarkTransformationTTD) and v7:IsInMeleeRange(21 - 16);
	v26[19 - 13] = v85(v35.Unholy.RacialsSetting) and v87(v35.TTD.RacialsTTD) and v7:IsInMeleeRange(1744 - (404 + 1335));
	v26[413 - (183 + 223)] = v85(v35.Unholy.Trinket1Setting) and v87(v35.TTD.TrinketsTTD);
	v26[9 - 1] = v85(v35.Unholy.Trinket2Setting) and v87(v35.TTD.TrinketsTTD);
	v26[6 + 3] = v85(v35.Unholy.PotionSetting) and not v34.ISSolo();
	v26[4 + 6] = v85(v35.Unholy.ApocalypseSetting) and v87(v35.TTD.ApocalypseTTD) and v7:IsInMeleeRange(342 - (10 + 327));
	v26[8 + 3] = v85(v35.Unholy.UnholyAssaultSetting) and v87(v35.TTD.UnholyAssaultTTD) and v7:IsInMeleeRange(343 - (118 + 220));
	v26[4 + 8] = v85(v35.Unholy.AbominationLimbSetting) and not IsNpcNearPlayer() and v87(v35.TTD.AbominationLimbTTD) and v7:IsInMeleeRange(464 - (108 + 341));
	v26[6 + 7] = v85(v35.Unholy.EmpowerRuneWeaponSetting) and v87(v35.TTD.EmpowerRuneWeaponTTD) and v7:IsInMeleeRange(21 - 16);
	v26[1507 - (711 + 782)] = v85(v35.Unholy.UnholyBlightSetting) and v87(v35.TTD.UnholyBlightTTD);
	v26[28 - 13] = v85(v35.Unholy.SummonGargoyleSetting) and v87(v35.TTD.SummonGargoyleTTD);
	v26[485 - (270 + 199)] = v85(v35.Unholy.RaiseAbominationSetting) and v87(v35.TTD.SummonGargoyleTTD);
	v26[6 + 11] = v85(v35.Unholy.ArmyOfTheDeadSetting) and v87(1859 - (580 + 1239));
	v26[53 - 35] = v85(v35.Unholy.Weapon);
	if (v34.TargetIsValid() or v6:AffectingCombat()) then
		v82 = v3.BossFightRemains();
		IsBossfight = true;
		v83 = v82;
		if (v83 == (10624 + 487)) then
			IsBossfight = false;
			v83 = v3.FightRemains(v76, false);
		end
		v70 = ((v24.VampiricStrikeAction:IsLearned()) and v24.VampiricStrikeAction) or ((v24.ClawingShadows:IsAvailable()) and v24.ClawingShadows) or v24.ScourgeStrike;
		v72 = ((v24.Defile:IsAvailable()) and v24.Defile) or v24.DeathAndDecay;
		WoundSpenderRange = ((v24.ClawingShadows:IsAvailable() or v24.VampiricStrikeAction:IsAvailable()) and (2 + 28)) or (3 + 2);
	end
	if v24.RaiseDead:IsCastable() then
		if v14(v24.RaiseDead) then
			return "raise_dead precombat 2";
		end
	end
	if (v24.RaiseAlly:IsReady() and v35.Commons.RaiseAlly) then
		if (v8:UnitIsFriend() and v8:UnitIsPlayer() and v8:Exists() and v8:IsDeadOrGhost()) then
			v13.CastTarget(v24.RaiseAlly, v13.TName().MOUSEOVER);
			return "Raise Ally on Mouseover";
		end
		if (v7:UnitIsFriend() and v7:UnitIsPlayer() and v7:Exists() and v7:IsDeadOrGhost()) then
			v13.Cast(v24.RaiseAlly);
			return "Raise Ally on Target";
		end
	end
	if (v34.TargetIsValid() and (v7:AffectingCombat() or v35.Unholy.AttackOutOfCombat)) then
		if not v6:AffectingCombat() then
			local v228 = v122();
			if v228 then
				return v228;
			end
		end
		if (v24.DeathStrike:IsReady() and v95()) then
			if v14(v24.DeathStrike) then
				return "death_strike low hp or proc";
			end
		end
		if v6:AffectingCombat() then
			if (v24.IceboundFortitude:IsCastable() and (v6:HealthPercentage() <= v35.Unholy.Defensives.IceboundFortitudeHP)) then
				if v14(v24.IceboundFortitude, false) then
					return "icebound_fortitude defensives";
				end
			end
			if (v24.AntiMagicShell:IsCastable() and (v6:HealthPercentage() <= v35.Unholy.Defensives.AntiMagicShellHP)) then
				if v14(v24.AntiMagicShell, false) then
					return "AntiMagicShell defensives";
				end
			end
			if (v24.AntiMagicZone:IsCastable() and (v6:HealthPercentage() <= v35.Unholy.Defensives.AntiMagicZoneHP)) then
				if v14(v24.AntiMagicZone, false) then
					return "AntiMagicZone defensives";
				end
			end
			if (v24.Lichborne:IsCastable() and (v6:HealthPercentage() <= v35.Unholy.Defensives.LichborneHP)) then
				if v14(v24.Lichborne, false) then
					return "Lichborne defensives";
				end
			end
		end
		if v26[7 - 4] then
			v31 = v34.InterruptCycle(v24.MindFreeze, 10 + 5, true, nil, false);
			if v31 then
				return v31;
			end
			if v35.Commons.BlindingSleet then
				v31 = v34.InterruptCycle(v24.BlindingSleet, 1179 - (645 + 522), true, nil, true, true);
				if v31 then
					return v31;
				end
			end
			v31 = v34.InterruptCycle(v24.Asphyxiate, 1810 - (1010 + 780), true, nil, true);
			if v31 then
				return v31;
			end
		end
		if not v7:IsInRange(10 + 0) then
			if (v24.Outbreak:IsReady() and v7:IsSpellInRange(v24.Outbreak) and v120(v7)) then
				if v14(v24.Outbreak) then
					return "outbreak out_of_range";
				end
			end
			if (v24.Epidemic:IsReady() and v7:IsInRange(190 - 150) and v16() and (v24.VirulentPlagueDebuff:AuraActiveCount() > (2 - 1)) and not v40) then
				if v14(v24.Epidemic, false, nil, not v7:IsInRange(1876 - (1045 + 791))) then
					return "epidemic out_of_range";
				end
			end
			if (v24.DeathCoil:IsReady() and v7:IsSpellInRange(v24.DeathCoil) and (v24.VirulentPlagueDebuff:AuraActiveCount() < (4 - 2)) and not v40) then
				if v14(v24.DeathCoil) then
					return "death_coil out_of_range";
				end
			end
		end
		v138();
		if v24.VampiricStrike:IsAvailable() then
			local v229 = v135();
			if v229 then
				return v229;
			end
		end
		if ((v35.Commons.Enabled.Trinkets or v35.Commons.Enabled.Items) and not v24.VampiricStrike:IsAvailable()) then
			local v230 = v137();
			if v230 then
				return v230;
			end
		end
		if true then
			local v231 = v132();
			if v231 then
				return v231;
			end
		end
		if true then
			local v232 = v130();
			if v232 then
				return v232;
			end
		end
		if (v16() and v24.VampiricStrike:IsAvailable() and (v78 >= (2 - 0))) then
			local v233 = v128();
			if v233 then
				return v233;
			end
		end
		if (v16() and not v24.VampiricStrike:IsAvailable() and (v78 >= (507 - (351 + 154)))) then
			local v234 = v127();
			if v234 then
				return v234;
			end
		end
		if (v24.VampiricStrike:IsAvailable() and ((v78 <= (1575 - (1281 + 293))) or not v16())) then
			local v235 = v129();
			if v235 then
				return v235;
			end
		end
		if (not v24.VampiricStrike:IsAvailable() and ((v78 <= (267 - (28 + 238))) or not v16())) then
			local v236 = v126();
			if v236 then
				return v236;
			end
		end
		if (v16() and (v78 == (4 - 2))) then
			local v237 = v131();
			if v237 then
				return v237;
			end
		end
		if (v16() and (v78 >= (1562 - (1381 + 178))) and not v6:DnDTicking() and (v72:CooldownRemains() < (10 + 0))) then
			local v238 = v125();
			if v238 then
				return v238;
			end
		end
		if (v16() and (v78 >= (3 + 0)) and v6:BuffUp(v24.DeathAndDecayBuff)) then
			local v239 = v124();
			if v239 then
				return v239;
			end
		end
		if (v16() and (v78 >= (2 + 1)) and v6:BuffDown(v24.DeathAndDecayBuff)) then
			local v240 = v123();
			if v240 then
				return v240;
			end
		end
		if (((v78 <= (3 - 2)) or not v16()) and v24.GiftoftheSanlayn:IsAvailable() and v24.DarkTransformation:CooldownDown() and v6:BuffDown(v24.GiftoftheSanlaynBuff) and (v6:BuffRemains(v24.EssenceoftheBloodQueenBuff) < (v24.DarkTransformation:CooldownRemains() + 2 + 0))) then
			local v241 = v133();
			if v241 then
				return v241;
			end
			if v13.CastAnnotated(v24.Pool, false, "WAIT") then
				return "Pool for SanFishing()";
			end
		end
		if (((v78 <= (471 - (381 + 89))) or not v16()) and v24.VampiricStrike:IsAvailable()) then
			local v242 = v134();
			if v242 then
				return v242;
			end
		end
		if (((v78 <= (1 + 0)) or not v16()) and not v24.VampiricStrike:IsAvailable()) then
			local v243 = v136();
			if v243 then
				return v243;
			end
		end
		if (v74:IsReady() and v7:IsInMeleeRange(v75) and (v6:Rune() >= (5 + 1))) then
			if v14(v74) then
				return "festering_strike anti cap";
			end
		end
		if (v70:IsReady() and v7:IsInRange(WoundSpenderRange) and not v7:IsInMeleeRange(13 - 5) and (v73 >= (1157 - (1074 + 82)))) then
			if v14(v71) then
				return "Wound Spender OOR";
			end
		end
		if v13.CastAnnotated(v24.Pool, false, "WAIT") then
			return "pool_resources";
		end
		v31 = (v77 > (0 - 0)) and not v7:IsInRange(1792 - (214 + 1570)) and v94();
	end
end
local function v144()
	v24.VirulentPlagueDebuff:RegisterAuraTracking();
	v24.FesteringWoundDebuff:RegisterAuraTracking();
	v24.MarkofFyralathDebuff:RegisterAuraTracking();
	v35.Unholy.Display();
	v13:UpdateMacro("macro1", "/use 16");
	v13:UpdateMacro("macro2", "/target [@mouseover]");
	v13.Print("Unholy DK rotation has been updated for patch 11.0.2.");
end
v13.SetAPL(1707 - (990 + 465), v143, v144);
