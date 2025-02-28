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
local v42;
local v43, v44;
local v45, v46;
local v47, v48;
local v49, v50;
local v51 = ((v24.VampiricStrikeAction:IsLearned()) and v24.VampiricStrikeAction) or ((v24.ClawingShadows:IsAvailable()) and v24.ClawingShadows) or v24.ScourgeStrike;
local v52 = ((v24.ClawingShadows:IsAvailable()) and v24.ClawingShadows) or v24.ScourgeStrike;
local v53 = ((v24.Defile:IsAvailable()) and v24.Defile) or v24.DeathAndDecay;
local v54, v55, v56;
local v57, v58, v59;
local v60, v61;
local v62;
local v63 = 9986 + 1125;
local v64 = 15839 - 4728;
local v65 = v13.Commons().DeathKnight.GhoulTable;
local v29, v30;
local v66, v67;
local v68, v69;
local v70, v71;
local v72, v73;
local v74, v75;
local v76, v77;
local v78, v79;
local v80, v81;
local v82, v83;
local v84, v85;
local function v86(v146)
	return (v146 ~= "Not Used") and (((v146 == "With Cooldowns") and v13.CDsON()) or ((v146 == "With Small or Cooldowns") and (v26[1066 - (68 + 997)] or v13.CDsON())) or ((v146 == "With Small CDs") and v26[1271 - (226 + 1044)]) or ((v146 == "On Mobcount") and (v59 >= v35.Unholy.Mobcount)) or ((v146 == "On Mobcount or Cooldowns") and ((v59 >= v35.Unholy.Mobcount) or v15())) or (v146 == "Always") or ((v146 == "On Bosses") and IsBossfight) or ((v146 == "Mobcount or Boss") and (IsBossfight or (v59 >= v35.Unholy.Mobcount))));
end
local function v87(v147, v148, v149)
	if (IsBossfight or v34.ISSolo() or (v149 == (0 - 0)) or ((v64 >= v149) and (v64 < (7894 - (32 + 85))))) then
		v13.Cast(v147, v148);
		return "TTD cast " .. v147:Name();
	end
end
local function v88(v150)
	if (v150 == nil) then
		print("nil value");
		return true;
	end
	return IsBossfight or v34.ISSolo() or (v150 == (0 + 0)) or v34.Buggedmobs[v7:NPCID()] or ((v64 >= v150) and (v64 < (1725 + 6052)));
end
local v89 = {{v24.Asphyxiate,"Cast Asphyxiate (Interrupt)",function()
	return true;
end}};
local function v90()
	return v25.ManicGrieftorch:IsEquipped() and (v25.ManicGrieftorch:CooldownUp() or (v25.ManicGrieftorch:CooldownRemains() <= v6:GCDRemains()));
end
local function v91()
	return v25.AlgetharPuzzleBox:IsEquipped() and (v25.AlgetharPuzzleBox:CooldownUp() or (v25.AlgetharPuzzleBox:CooldownRemains() <= v6:GCDRemains()));
end
local v92 = 350 - (87 + 263);
local function v93()
	local v151, v152 = v6:GetTrinketData(v27);
	if ((v92 < (185 - (67 + 113))) and ((v151.ID == (0 + 0)) or (v152.ID == (0 - 0)) or (v151.Level == (0 + 0)) or (v152.Level == (0 - 0)) or ((v151.SpellID > (952 - (802 + 150))) and not v151.Usable) or ((v152.SpellID > (0 - 0)) and not v152.Usable))) then
		v92 = v92 + (1 - 0);
		v19(4 + 1, function()
			v93();
		end);
		return;
	end
	v29 = v151.Object;
	v30 = v152.Object;
	v66 = v151.ID;
	v67 = v152.ID;
	VarTrinket1Level = v151.Level;
	VarTrinket2Level = v152.Level;
	v68 = v151.Spell;
	v70 = v151.Range;
	v72 = v151.CastTime;
	v69 = v152.Spell;
	v71 = v152.Range;
	v73 = v152.CastTime;
	v74 = v151.Cooldown;
	v75 = v152.Cooldown;
	v76 = v151.Blacklisted;
	v77 = v152.Blacklisted;
	v78 = v29:HasUseBuff() or (v66 == v25.TreacherousTransmitter:ID());
	v79 = v30:HasUseBuff() or (v67 == v25.TreacherousTransmitter:ID());
	v80 = ((v66 == v25.TreacherousTransmitter:ID()) and (1012 - (915 + 82))) or v29:BuffDuration();
	v81 = ((v67 == v25.TreacherousTransmitter:ID()) and (42 - 27)) or v30:BuffDuration();
	v82 = 0.5 + 0;
	if ((v78 and ((v24.Apocalypse:IsAvailable() and ((v74 % (39 - 9)) == (1187 - (1069 + 118)))) or (v24.DarkTransformation:IsAvailable() and ((v74 % (101 - 56)) == (0 - 0))))) or (v66 == v25.TreacherousTransmitter:ID())) then
		v82 = 1 + 0;
	end
	v83 = 0.5 - 0;
	if ((v79 and ((v24.Apocalypse:IsAvailable() and ((v75 % (30 + 0)) == (791 - (368 + 423)))) or (v24.DarkTransformation:IsAvailable() and ((v75 % (141 - 96)) == (18 - (10 + 8)))))) or (v67 == v25.TreacherousTransmitter:ID())) then
		v83 = 3 - 2;
	end
	v84 = 443 - (416 + 26);
	local v169 = ((v80 > (0 - 0)) and v80) or (1 + 0);
	local v170 = ((v81 > (0 - 0)) and v81) or (439 - (145 + 293));
	if ((not v78 and v79 and (v30:HasCooldown() or not v29:HasCooldown())) or (v79 and (((v75 / v170) * v83) > ((v74 / v169) * v82 * ((431 - (44 + 386)) + ((VarTrinket1Level - VarTrinket2Level) / (1586 - (998 + 488)))))))) then
		v84 = 1 + 1;
	end
	v85 = 1 + 0;
	if (not v78 and not v79 and (VarTrinket2Level >= VarTrinket1Level)) then
		v85 = 774 - (201 + 571);
	end
end
v93();
local v94 = false;
local v89 = {{v24.Asphyxiate,"Cast Asphyxiate (Interrupt)",function()
	return true;
end}};
local function v95()
	if (v33.General.AutoTab and v6:AffectingCombat()) then
		v13.TopPanelAlternative:ChangeIcon(3 - 2, 862 - (814 + 45));
		return "Auto tab to target";
	end
end
v3:RegisterForEvent(function()
	v63 = 27376 - 16265;
	v64 = 599 + 10512;
end, "PLAYER_REGEN_ENABLED");
v3:RegisterForEvent(function()
	v53 = ((v24.Defile:IsAvailable()) and v24.Defile) or v24.DeathAndDecay;
	v92 = 0 + 0;
	v93();
end, "PLAYER_EQUIPMENT_CHANGED", "SPELLS_CHANGED", "LEARNED_SPELL_IN_TAB");
local function v96()
	return (v6:HealthPercentage() < v35.Unholy.Defensives.UseDeathStrikeHP) or ((v6:HealthPercentage() < v35.Unholy.Defensives.UseDarkSuccorHP) and v6:BuffUp(v24.DeathStrikeBuff));
end
local function v97(v171)
	local v172 = 885 - (261 + 624);
	for v218, v219 in pairs(v171) do
		if v219:DebuffDown(v24.VirulentPlagueDebuff) then
			v172 = v172 + (1 - 0);
		end
	end
	return v172;
end
function IsNpcNearPlayer()
	local v173 = v6:GetEnemiesInRange(1120 - (1020 + 60));
	for v220, v221 in pairs(v173) do
		if ((v221:NPCID() == (41780 - (630 + 793))) or (v221:CastSpellID() == (1518166 - 1070153))) then
			print("npc found: do not use abo limb");
			return true;
		end
	end
	return false;
end
local function v98(v174)
	local v175 = {};
	for v222 in pairs(v174) do
		if not v5:IsInBossList(v174[v222]['UnitNPCID']) then
			v21(v175, v174[v222]);
		end
	end
	return v3.FightRemains(v175);
end
local function v99(v176)
	return v176:DebuffStack(v24.FesteringWoundDebuff);
end
local function v100(v177)
	return v177:DebuffRemains(v24.TrollbaneSlowDebuff);
end
local function v101(v178)
	return v178:DebuffStack(v24.FesteringWoundDebuff) < (9 - 7);
end
local function v102(v179)
	return v179:DebuffStack(v24.FesteringWoundDebuff) <= (1 + 1);
end
local function v103(v180)
	return not v24.VileContagion:IsAvailable();
end
local function v104(v181)
	return (v24.VileContagion:CooldownRemains() < (17 - 12)) or ((v24.FesteringWoundDebuff:AuraActiveCount() == v59) and (v181:DebuffStack(v24.FesteringWoundDebuff) <= (1751 - (760 + 987))));
end
local function v105(v182)
	return ((v24.Apocalypse:CooldownRemains() < v6:GCD()) and v182:DebuffDown(v24.FesteringWoundDebuff)) or (v24.FesteringWoundDebuff:AuraActiveCount() < v59);
end
local function v106(v183)
	return (not v39 and (v183:DebuffStack(v24.FesteringWoundDebuff) < (1917 - (1789 + 124)))) or v6:BuffUp(v24.FesteringScytheBuff);
end
local function v107(v184)
	return (v24.Apocalypse:CooldownRemains() < v38) and (v184:DebuffStack(v24.FesteringWoundDebuff) < (770 - (745 + 21)));
end
local function v108(v185)
	return v37 and (((v185:DebuffStack(v24.FesteringWoundDebuff) >= (1 + 1)) and (v24.VileContagion:CooldownRemains() < (7 - 4))) or not v24.VileContagion:IsAvailable());
end
local function v109(v186)
	return v37 and (((v186:DebuffStack(v24.FesteringWoundDebuff) >= (7 - 5)) and (v24.VileContagion:CooldownRemains() < (1 + 5))) or not v24.VileContagion:IsAvailable());
end
local function v110(v187)
	return ((v187:DebuffStack(v24.FesteringWoundDebuff) >= (4 + 0)) and (v64 > (1059 - (87 + 968))) and ((v53:CooldownRemains() < (13 - 10)) or (v6:BuffUp(v24.DeathAndDecayBuff) and (v187:DebuffStack(v24.FesteringWoundDebuff) >= (4 + 0))))) or (v37 and (v187:DebuffStack(v24.FesteringWoundDebuff) == (13 - 7)));
end
local function v111(v188)
	return ((v188:DebuffStack(v24.FesteringWoundDebuff) == (1419 - (447 + 966))) and (v6:DnDTicking() or (v53:CooldownRemains() < (8 - 5)))) or (v6:BuffUp(v24.DeathAndDecayBuff) and (v188:DebuffStack(v24.FesteringWoundDebuff) >= (1821 - (1703 + 114)))) or ((v53:CooldownRemains() < (704 - (376 + 325))) and (v188:DebuffStack(v24.FesteringWoundDebuff) >= (5 - 1)));
end
local function v112(v189)
	return v189:DebuffStack(v24.FesteringWoundDebuff) >= (2 - 1);
end
local function v113(v190)
	return v190:DebuffUp(v24.TrollbaneSlowDebuff) and (v190:DebuffRemains(v24.TrollbaneSlowDebuff) < v6:GCD());
end
local function v114(v191)
	return ((v191:DebuffStack(v24.FesteringWoundDebuff) >= (1 + 0)) and (v24.Apocalypse:CooldownRemains() > v6:GCD())) or (v24.VampiricStrikeAction:IsLearned() and v191:DebuffUp(v24.VirulentPlagueDebuff));
end
local function v115(v192)
	return (v192:DebuffStack(v24.FesteringWoundDebuff) >= (2 - 1)) or v24.VampiricStrikeAction:IsLearned();
end
local function v116(v193)
	return v193:DebuffUp(v24.TrollbaneSlowDebuff);
end
local function v117(v194)
	return v194:DebuffUp(v24.TrollbaneSlowDebuff) and (v194:DebuffRemains(v24.TrollbaneSlowDebuff) < v6:GCD());
end
local function v118(v195)
	return (v195:TimeToDie() > v195:DebuffRemains(v24.VirulentPlagueDebuff)) and (v195:DebuffTicksRemain(v24.VirulentPlagueDebuff) < (19 - (9 + 5))) and (v195:DebuffRefreshable(v24.VirulentPlagueDebuff) or (v24.Superstrain:IsAvailable() and (v195:DebuffRefreshable(v24.FrostFeverDebuff) or v195:DebuffRefreshable(v24.BloodPlagueDebuff)))) and (not v26[390 - (85 + 291)] or not v24.UnholyBlight:IsAvailable() or v24.Plaguebringer:IsAvailable()) and (not v26[1281 - (243 + 1022)] or not v24.RaiseAbomination:IsAvailable() or (v24.RaiseAbomination:IsAvailable() and (v24.RaiseAbomination:CooldownRemains() > (v195:DebuffTicksRemain(v24.VirulentPlagueDebuff) * (11 - 8)))));
end
local function v119(v196)
	return (v196:TimeToDie() > v196:DebuffRemains(v24.VirulentPlagueDebuff)) and (v196:DebuffTicksRemain(v24.VirulentPlagueDebuff) < (5 + 0)) and (v196:DebuffRefreshable(v24.VirulentPlagueDebuff) or (v24.Morbidity:IsAvailable() and v6:BuffUp(v24.InflictionofSorrowBuff) and v24.Superstrain:IsAvailable() and v196:DebuffRefreshable(v24.FrostFeverDebuff) and v196:DebuffRefreshable(v24.BloodPlagueDebuff))) and (not v26[1194 - (1123 + 57)] or not v24.UnholyBlight:IsAvailable() or (v24.UnholyBlight:IsAvailable() and (v24.DarkTransformation:CooldownDown() or not v26[5 + 0]))) and (not v26[270 - (163 + 91)] or not v24.RaiseAbomination:IsAvailable() or (v24.RaiseAbomination:IsAvailable() and v24.RaiseAbomination:CooldownDown()));
end
local function v120(v197)
	return (v197:DebuffRefreshable(v24.VirulentPlagueDebuff) or (v24.Morbidity:IsAvailable() and v6:BuffDown(v24.GiftoftheSanlaynBuff) and v24.Superstrain:IsAvailable() and v7:DebuffRefreshable(v24.FrostFeverDebuff) and v7:DebuffRefreshable(v24.BloodPlagueDebuff))) and (not v24.UnholyBlight:IsAvailable() or (v24.UnholyBlight:IsAvailable() and (v24.DarkTransformation:CooldownRemains() > ((1945 - (1869 + 61)) / (((1 + 1) * v17(v24.Superstrain:IsAvailable())) + ((6 - 4) * v17(v24.EbonFever:IsAvailable())) + ((2 - 0) * v17(v24.Plaguebringer:IsAvailable()))))))) and (not v24.RaiseAbomination:IsAvailable() or not v26[3 + 13] or (v24.RaiseAbomination:IsAvailable() and (v24.RaiseAbomination:CooldownRemains() > ((20 - 5) / (((2 + 0) * v17(v24.Superstrain:IsAvailable())) + ((1476 - (1329 + 145)) * v17(v24.EbonFever:IsAvailable())) + ((973 - (140 + 831)) * v17(v24.Plaguebringer:IsAvailable())))))));
end
local function v121(v198)
	return (v198:TimeToDie() > v198:DebuffRemains(v24.VirulentPlagueDebuff)) and v198:DebuffRefreshable(v24.VirulentPlagueDebuff);
end
local function v122(v199)
	return v199:DebuffUp(v24.TrollbaneSlowDebuff);
end
local function v123()
	if (v24.ArmyoftheDead:IsReady() and v7:IsInMeleeRange(1855 - (1409 + 441)) and v26[735 - (15 + 703)] and v26[8 + 9] and not v25.Fyralath:IsEquipped()) then
		if v14(v24.ArmyoftheDead) then
			return "army_of_the_dead precombat 4";
		end
	end
	if (v24.Outbreak:IsReady() and v7:IsSpellInRange(v24.Outbreak) and v121(v7)) then
		if v14(v24.Outbreak) then
			return "outbreak precombat 6";
		end
	end
	if (v55:IsReady() and v7:IsInMeleeRange(v56) and v7:IsInMeleeRange(v56)) then
		if v14(v24.FesteringStrike) then
			return "festering_strike precombat 8";
		end
	end
end
local function v124()
	if (v55:IsReady() and v7:IsInMeleeRange(v56)) then
		if v14(v55) then
			return "festering_scythe aoe 2";
		end
	end
	if (v51:IsReady() and v7:IsInRange(WoundSpenderRange) and (v54 >= (439 - (262 + 176))) and v112(v7) and v6:BuffUp(v24.DeathAndDecayBuff) and v24.BurstingSores:IsAvailable() and (v24.Apocalypse:CooldownRemains() > v38)) then
		if v34.CastCycle(v51, v57, v122, WoundSpenderRange) then
			return "wound_spender aoe 4";
		end
	end
	if (v24.DeathCoil:IsReady() and not v40 and (v58 < v42)) then
		if v14(v24.DeathCoil, true, nil, not v7:IsInRange(1761 - (345 + 1376))) then
			return "death_coil aoe 6";
		end
	end
	if (v24.Epidemic:IsReady() and v7:IsInRange(728 - (198 + 490)) and not v40) then
		if v14(v24.Epidemic) then
			return "epidemic aoe 6";
		end
	end
	if (v51:IsReady() and v7:IsInRange(WoundSpenderRange) and v122(v7) and (v54 >= (4 - 3)) and v113(v7)) then
		if v14(v52) then
			return "wound_spender aoe 8";
		end
	end
	if (v55:IsReady() and v7:IsInMeleeRange(v56) and ((v24.Apocalypse:CooldownRemains() < v38) or v6:BuffUp(v24.FesteringScytheBuff))) then
		if v14(v55) then
			return "festering_strike aoe 10";
		end
	end
	if (v55:IsReady() and v101(v7) and v7:IsInMeleeRange(v56)) then
		if v14(v55) then
			return "festering_strike aoe 12";
		end
	end
	if (v51:IsReady() and v7:IsInRange(WoundSpenderRange) and (v54 >= (2 - 1)) and v114(v7)) then
		if v14(v52) then
			return "wound_spender aoe 14";
		end
	end
end
local function v125()
	if (v24.FesteringScytheAction:IsReady() and v7:IsInMeleeRange(1220 - (696 + 510))) then
		if v14(v24.FesteringScytheAction) then
			return "festering_scythe aoe_burst 2";
		end
	end
	if (v24.DeathCoil:IsReady() and not v24.VampiricStrikeAction:IsLearned() and (v58 < v42) and (not v24.BurstingSores:IsAvailable() or (v24.BurstingSores:IsAvailable() and (v24.FesteringWoundDebuff:AuraActiveCount() < v58) and (v24.FesteringWoundDebuff:AuraActiveCount() < (v58 * (0.4 - 0))) and v6:BuffUp(v24.SuddenDoomBuff)) or (v6:BuffUp(v24.SuddenDoomBuff) and ((v24.DoomedBidding:IsAvailable() and v24.MenacingMagus:IsAvailable()) or v24.RottenTouch:IsAvailable() or (v7:DebuffRemains(v24.DeathRotDebuff) < v6:GCD()))))) then
		if v14(v24.DeathCoil, true, nil, not v7:IsInRange(1302 - (1091 + 171))) then
			return "death_coil aoe_burst 4";
		end
	end
	if (v24.Epidemic:IsReady() and v7:IsInRange(7 + 33) and not v24.VampiricStrikeAction:IsLearned() and (not v24.BurstingSores:IsAvailable() or (v24.BurstingSores:IsAvailable() and (((v24.FesteringWoundDebuff:AuraActiveCount() < v59) and (v24.FesteringWoundDebuff:AuraActiveCount() < (v59 * (0.4 - 0))) and v6:BuffUp(v24.SuddenDoomBuff)) or not v94)) or (v6:BuffUp(v24.SuddenDoomBuff) and (v6:BuffUp(v24.AFeastofSoulsBuff) or (v7:DebuffRemains(v24.DeathRotDebuff) < v6:GCD()) or (v7:DebuffStack(v24.DeathRotDebuff) < (33 - 23)))))) then
		if v14(v24.Epidemic) then
			return "epidemic aoe_burst 4";
		end
	end
	if (v51:IsReady() and v116(v7) and v7:IsInRange(WoundSpenderRange)) then
		if v34.CastCycle(v51, v57, v122, WoundSpenderRange) then
			return "wound_spender aoe_burst 6";
		end
	end
	if (v51:IsReady() and v7:IsInRange(WoundSpenderRange) and (v54 >= (375 - (123 + 251))) and v115(v7)) then
		if v14(v52) then
			return "wound_spender aoe_burst 8";
		end
	end
	if (v24.Epidemic:IsReady() and v7:IsInRange(198 - 158)) then
		if v14(v24.Epidemic) then
			return "epidemic aoe_burst 10";
		end
	end
	if (v55:IsReady() and v7:IsInMeleeRange(v56) and v102(v7)) then
		if v14(v55) then
			return "festering_strike aoe_burst 12";
		end
	end
	if (v51:IsReady() and v7:IsInRange(WoundSpenderRange) and (v54 >= (699 - (208 + 490)))) then
		if v14(v52) then
			return "wound_spender aoe_burst 14";
		end
	end
end
local function v126()
	if (v24.FesteringScytheAction:IsReady() and v7:IsInMeleeRange(2 + 12)) then
		if v14(v24.FesteringScytheAction) then
			return "festering_scythe aoe_setup 2";
		end
	end
	if (v53:IsReady() and v26[2 + 2] and ((v58 >= (837 - (660 + 176))) or v7:IsInRange(1 + 7)) and (v35.Commons.DnDMoving or not v6:IsMoving()) and not v6:DnDTicking() and ((not v24.BurstingSores:IsAvailable() and not v24.VileContagion:IsAvailable()) or (v24.FesteringWoundDebuff:AuraActiveCount() == v59) or (v24.FesteringWoundDebuff:AuraActiveCount() >= (210 - (14 + 188))) or (v6:BuffUp(v24.DeathAndDecayBuff) and v24.Defile:IsAvailable()))) then
		if v13.CastTarget(v24.DeathAndDecay, v13.TName().PLAYER) then
			return "any_dnd aoe_setup 4";
		end
	end
	if (v51:IsReady() and v7:IsInRange(WoundSpenderRange)) then
		if v34.CastCycle(v51, v57, v122, WoundSpenderRange) then
			return "wound_spender aoe_setup 6";
		end
	end
	if (v55:IsReady() and v7:IsInMeleeRange(v56)) then
		if v34.CastTargetIf(v55, v57, "max", v99, v103, v56) then
			return "festering_strike aoe_setup 8";
		end
	end
	if (v55:IsReady() and v7:IsInMeleeRange(v56)) then
		if v34.CastTargetIf(v55, v57, "max", v99, v104, v56) then
			return "festering_strike aoe_setup 10";
		end
	end
	if (v24.DeathCoil:IsReady() and not v40 and v6:BuffUp(v24.SuddenDoomBuff) and (v58 < v42)) then
		if v14(v24.DeathCoil, true, nil, not v7:IsInRange(715 - (534 + 141))) then
			return "death_coil aoe_setup 12";
		end
	end
	if (v24.Epidemic:IsReady() and v7:IsInRange(17 + 23) and not v40 and v6:BuffUp(v24.SuddenDoomBuff)) then
		if v14(v24.Epidemic) then
			return "epidemic aoe_setup 12";
		end
	end
	if (v55:IsReady() and v7:IsInMeleeRange(v56)) then
		if v34.CastTargetIf(v55, v57, "min", v99, v105, v56) then
			return "festering_strike aoe_setup 14";
		end
	end
	if (v24.DeathCoil:IsReady() and not v40 and (v58 < v42)) then
		if v14(v24.DeathCoil, true, nil, not v7:IsInRange(36 + 4)) then
			return "death_coil aoe_setup 18";
		end
	end
	if (v24.Epidemic:IsReady() and v7:IsInRange(39 + 1) and not v40) then
		if v14(v24.Epidemic) then
			return "epidemic aoe_setup 16";
		end
	end
end
local function v127()
	if (v24.DarkTransformation:IsCastable() and v7:IsInMeleeRange(10 - 5) and v26[7 - 2] and ((v36 and ((v24.Apocalypse:CooldownRemains() < (22 - 14)) or not v24.Apocalypse:IsAvailable() or (v59 >= (1 + 0)))) or (v63 < (13 + 7)))) then
		if v14(v24.DarkTransformation) then
			return "dark_transformation cds 2";
		end
	end
	if (v24.UnholyAssault:IsCastable() and v7:IsInMeleeRange(401 - (115 + 281)) and v26[25 - 14] and v36 and ((v24.Apocalypse:CooldownRemains() < (v6:GCD() * (2 + 0))) or not v24.Apocalypse:IsAvailable() or ((v59 >= (4 - 2)) and v10:BuffUp(v24.DarkTransformation)))) then
		if v14(v24.UnholyAssault) then
			return "unholy_assault cds 4";
		end
	end
	if (v24.Apocalypse:IsReady() and v7:IsInMeleeRange(18 - 13) and v26[877 - (550 + 317)] and (v36 or (v63 < (28 - 8)))) then
		if v14(v24.Apocalypse) then
			return "apocalypse cds 10";
		end
	end
	if (v24.Outbreak:IsReady() and v7:IsSpellInRange(v24.Outbreak)) then
		if v34.CastCycle(v24.Outbreak, v60, v118, 56 - 16) then
			return "outbreak cds 8";
		end
	end
	if (v24.AbominationLimb:IsCastable() and v7:IsInRange(55 - 35) and v26[297 - (134 + 151)] and ((v36 and v6:BuffDown(v24.SuddenDoomBuff) and ((v6:BuffUp(v24.FestermightBuff) and (v6:BuffStack(v24.FestermightBuff) > (1673 - (970 + 695)))) or not v24.Festermight:IsAvailable()) and ((v46 < (9 - 4)) or not v24.Apocalypse:IsAvailable()) and (v54 <= (1992 - (582 + 1408)))) or (v63 < (41 - 29)))) then
		if v14(v24.AbominationLimb) then
			return "abomination_limb cds 12";
		end
	end
end
local function v128()
	if (v24.VileContagion:IsReady() and v110(v7) and v7:IsSpellInRange(v24.VileContagion)) then
		if v14(v24.VileContagion) then
			return "vile_contagion cds_aoe 2";
		end
	end
	if (v24.UnholyAssault:IsCastable() and v7:IsInMeleeRange(6 - 1) and v26[41 - 30] and v108(v7)) then
		if v14(v24.UnholyAssault) then
			return "unholy_assault cds_aoe 4";
		end
	end
	if (v24.DarkTransformation:IsCastable() and v7:IsInMeleeRange(1829 - (1195 + 629)) and v26[6 - 1] and v37 and ((v24.VileContagion:CooldownRemains() > (246 - (187 + 54))) or not v24.VileContagion:IsAvailable() or v6:DnDTicking() or (v53:CooldownRemains() < (783 - (162 + 618))))) then
		if v14(v24.DarkTransformation) then
			return "dark_transformation cds_aoe 6";
		end
	end
	if (v24.Outbreak:IsReady() and v7:IsSpellInRange(v24.Outbreak) and (v7:DebuffTicksRemain(v24.VirulentPlagueDebuff) < (4 + 1)) and v7:DebuffRefreshable(v24.VirulentPlagueDebuff) and (not v24.UnholyBlight:IsAvailable() or (v24.UnholyBlight:IsAvailable() and v24.DarkTransformation:CooldownDown())) and (not v24.RaiseAbomination:IsAvailable() or (v24.RaiseAbomination:IsAvailable() and v24.RaiseAbomination:CooldownDown()))) then
		if v14(v24.Outbreak) then
			return "outbreak cds_aoe 8";
		end
	end
	if (v24.Apocalypse:IsReady() and v7:IsInMeleeRange(4 + 1) and v26[21 - 11] and v37 and (v6:Rune() <= (4 - 1))) then
		if v14(v24.Apocalypse) then
			return "apocalypse cds_aoe 10";
		end
	end
	if (v24.AbominationLimb:IsCastable() and v7:IsInRange(2 + 18) and v26[1648 - (1373 + 263)] and v37) then
		if v14(v24.AbominationLimb) then
			return "abomination_limb cds_aoe 12";
		end
	end
end
local function v129()
	if (v24.DarkTransformation:IsCastable() and v7:IsInMeleeRange(1005 - (451 + 549)) and v26[2 + 3] and ((v37 and v6:BuffUp(v24.DeathAndDecayBuff)) or (v59 <= (4 - 1)))) then
		if v14(v24.DarkTransformation) then
			return "dark_transformation cds_aoe_san 2";
		end
	end
	if (v24.VileContagion:IsReady() and v7:IsSpellInRange(v24.VileContagion) and v110(v7)) then
		if v14(v24.VileContagion) then
			return "vile_contagion cds_aoe_san 4";
		end
	end
	if (v24.UnholyAssault:IsCastable() and v7:IsInMeleeRange(8 - 3) and v26[1395 - (746 + 638)] and v109(v7) and v37) then
		if v14(v24.UnholyAssault) then
			return "unholy_assault cds_aoe_san 6";
		end
	end
	if (v24.Outbreak:IsReady() and v7:IsSpellInRange(v24.Outbreak) and (v7:DebuffTicksRemain(v24.VirulentPlagueDebuff) < (2 + 3)) and (v7:DebuffRefreshable(v24.VirulentPlagueDebuff) or (v24.Morbidity:IsAvailable() and v6:BuffDown(v24.GiftoftheSanlaynBuff) and v24.Superstrain:IsAvailable() and v7:DebuffRefreshable(v24.FrostFeverDebuff) and v7:DebuffRefreshable(v24.BloodPlagueDebuff))) and (not v24.UnholyBlight:IsAvailable() or (v24.UnholyBlight:IsAvailable() and v24.DarkTransformation:CooldownDown())) and (not v24.RaiseAbomination:IsAvailable() or (v24.RaiseAbomination:IsAvailable() and v24.RaiseAbomination:CooldownDown()))) then
		if v14(v24.Outbreak) then
			return "outbreak cds_aoe_san 8";
		end
	end
	if (v24.Apocalypse:IsReady() and v7:IsInMeleeRange(7 - 2) and v26[351 - (218 + 123)] and v37 and (v6:Rune() <= (1584 - (1535 + 46)))) then
		if v14(v24.Apocalypse) then
			return "apocalypse cds_aoe_san 10";
		end
	end
	if (v24.AbominationLimb:IsCastable() and v7:IsInRange(20 + 0) and v26[2 + 10] and v37) then
		if v14(v24.AbominationLimb) then
			return "abomination_limb cds_aoe_san 12";
		end
	end
end
local function v130()
	if (v24.DarkTransformation:IsCastable() and v7:IsInMeleeRange(565 - (306 + 254)) and v26[1 + 4] and (v59 >= (1 - 0)) and v36 and ((v24.Apocalypse:IsAvailable() and v45) or not v24.Apocalypse:IsAvailable())) then
		if v14(v24.DarkTransformation) then
			return "dark_transformation cds_san 2";
		end
	end
	if (v24.UnholyAssault:IsCastable() and v7:IsInMeleeRange(1472 - (899 + 568)) and v26[8 + 3] and v36 and v10:BuffUp(v24.DarkTransformation) and (v10:BuffRemains(v24.DarkTransformation) < (28 - 16))) then
		if v14(v24.UnholyAssault) then
			return "unholy_assault cds_san 4";
		end
	end
	if (v24.Apocalypse:IsReady() and v7:IsInMeleeRange(608 - (268 + 335)) and v26[300 - (60 + 230)] and ((v36 and (v54 >= (575 - (426 + 146)))) or (v63 < (3 + 17)))) then
		if v14(v24.Apocalypse) then
			return "apocalypse cds_san 6";
		end
	end
	if (v24.Outbreak:IsReady() and v7:IsSpellInRange(v24.Outbreak)) then
		if v34.CastCycle(v24.Outbreak, v60, v119, 1496 - (282 + 1174)) then
			return "outbreak cds_san 8";
		end
	end
	if (v24.AbominationLimb:IsCastable() and v7:IsInRange(831 - (569 + 242)) and v26[34 - 22] and (((v59 >= (1 + 0)) and v36 and v6:BuffDown(v24.GiftoftheSanlaynBuff) and v10:BuffDown(v24.DarkTransformation) and v6:BuffDown(v24.SuddenDoomBuff) and v6:BuffUp(v24.FestermightBuff) and (v54 <= (1026 - (706 + 318)))) or (v6:BuffDown(v24.GiftoftheSanlaynBuff) and (v63 < (1263 - (721 + 530)))))) then
		if v14(v24.AbominationLimb) then
			return "abomination_limb cds_san 10";
		end
	end
end
local function v131()
	if v35.Commons.Enabled.Potions then
		local v223 = v34.PotionSelected();
		if (v223 and v26[1280 - (945 + 326)]) then
			if (v223:IsReady() and (((v59 >= (2 - 1)) and (not v24.SummonGargoyle:IsAvailable() or (v24.SummonGargoyle:CooldownRemains() > (54 + 6))) and ((v10:BuffUp(v24.DarkTransformation) and ((730 - (271 + 429)) >= v10:BuffRemains(v24.DarkTransformation))) or (v47 and (v48 <= (28 + 2))) or (v45 and (v46 <= (1530 - (1408 + 92)))) or (v43 and (v44 <= (1116 - (461 + 625)))))) or (v63 <= (1318 - (993 + 295))))) then
				if v13.CastMacro(1 + 2, nil, nil, v223) then
					return "potion high_prio_actions 2";
				end
			end
		end
	end
	if (v24.ArmyoftheDead:IsReady() and v7:IsInMeleeRange(1176 - (418 + 753)) and v26[7 + 10] and (((v36 or v37) and ((v24.CommanderoftheDead:IsAvailable() and (v24.DarkTransformation:CooldownRemains() < (1 + 4))) or (not v24.CommanderoftheDead:IsAvailable() and (v59 >= (1 + 0))))) or (v63 < (9 + 26)))) then
		if v14(v24.ArmyoftheDead) then
			return "army_of_the_dead cds_shared 4";
		end
	end
	if (v24.RaiseAbomination:IsCastable() and v7:IsInMeleeRange(534 - (406 + 123)) and v26[1785 - (1749 + 20)] and (v36 or v37 or (v63 < (8 + 22)))) then
		if v14(v24.RaiseAbomination) then
			return "raise_abomination cds_shared 6";
		end
	end
	if (v24.SummonGargoyle:IsReady() and v7:IsInMeleeRange(1327 - (1249 + 73)) and v26[6 + 9] and (v36 or v37) and (v6:BuffUp(v24.CommanderoftheDeadBuff) or (not v24.CommanderoftheDead:IsAvailable() and (v59 >= (1146 - (466 + 679)))))) then
		if v14(v24.SummonGargoyle) then
			return "summon_gargoyle cds_shared 8";
		end
	end
end
local function v132()
	if (v53:IsReady() and v26[9 - 5] and ((v58 >= (2 - 1)) or v7:IsInRange(1908 - (106 + 1794))) and (v35.Commons.DnDMoving or not v6:IsMoving()) and not v6:DnDTicking()) then
		if v13.CastTarget(v24.DeathAndDecay, v13.TName().PLAYER) then
			return "any_dnd cleave 2";
		end
	end
	if (v24.DeathCoil:IsReady() and v7:IsSpellInRange(v24.DeathCoil) and not v40 and v24.ImprovedDeathCoil:IsAvailable()) then
		if v14(v24.DeathCoil) then
			return "death_coil cleave 4";
		end
	end
	if (v55:IsReady() and v7:IsInMeleeRange(v56) and v106(v7)) then
		if v14(v55) then
			return "festering_strike cleave 8";
		end
	end
	if (v55:IsReady() and v7:IsInMeleeRange(v56) and v107(v7)) then
		if v14(v55) then
			return "festering_strike cleave 10";
		end
	end
	if (v51:IsReady() and v7:IsInRange(WoundSpenderRange) and (v54 >= (1 + 0)) and v39) then
		if v14(v52) then
			return "wound_spender cleave 12";
		end
	end
end
local function v133()
	if (v24.ArcaneTorrent:IsCastable() and v7:IsInRange(3 + 5) and v26[17 - 11] and (v6:RunicPower() < (54 - 34)) and (v6:Rune() < (116 - (4 + 110)))) then
		if v14(v24.ArcaneTorrent) then
			return "arcane_torrent racials 2";
		end
	end
	if (v24.BloodFury:IsCastable() and v7:IsInRange(589 - (57 + 527)) and v26[1433 - (41 + 1386)] and ((((v24.BloodFury:BaseDuration() + (106 - (17 + 86))) >= v50) and v49) or ((not v24.SummonGargoyle:IsAvailable() or (v24.SummonGargoyle:CooldownRemains() > (41 + 19))) and ((v47 and (v48 <= (v24.BloodFury:BaseDuration() + (6 - 3)))) or (v45 and (v46 <= (v24.BloodFury:BaseDuration() + (8 - 5)))) or ((v59 >= (168 - (122 + 44))) and v6:DnDTicking()))) or (v63 <= (v24.BloodFury:BaseDuration() + (5 - 2))))) then
		if v14(v24.BloodFury) then
			return "blood_fury racials 4";
		end
	end
	if (v24.Berserking:IsCastable() and v7:IsInRange(16 - 11) and v26[5 + 1] and ((((v24.Berserking:BaseDuration() + 1 + 2) >= v50) and v49) or ((not v24.SummonGargoyle:IsAvailable() or (v24.SummonGargoyle:CooldownRemains() > (121 - 61))) and ((v47 and (v48 <= (v24.Berserking:BaseDuration() + (68 - (30 + 35))))) or (v45 and (v46 <= (v24.Berserking:BaseDuration() + 3 + 0))) or ((v59 >= (1259 - (1043 + 214))) and v6:DnDTicking()))) or (v63 <= (v24.Berserking:BaseDuration() + (11 - 8))))) then
		if v14(v24.Berserking) then
			return "berserking racials 6";
		end
	end
	if (v24.LightsJudgment:IsCastable() and v7:IsInRange(1217 - (323 + 889)) and v26[15 - 9] and v6:BuffUp(v24.UnholyStrengthBuff) and (not v24.Festermight:IsAvailable() or (v6:BuffRemains(v24.FestermightBuff) < v7:TimeToDie()) or (v6:BuffRemains(v24.UnholyStrengthBuff) < v7:TimeToDie()))) then
		if v14(v24.LightsJudgment) then
			return "lights_judgment racials 8";
		end
	end
	if (v24.AncestralCall:IsCastable() and v7:IsInRange(585 - (361 + 219)) and v26[326 - (53 + 267)] and ((((5 + 13) >= v50) and v49) or ((not v24.SummonGargoyle:IsAvailable() or (v24.SummonGargoyle:CooldownRemains() > (473 - (15 + 398)))) and ((v47 and (v48 <= (1000 - (18 + 964)))) or (v45 and (v46 <= (67 - 49))) or ((v59 >= (2 + 0)) and v6:DnDTicking()))) or (v63 <= (12 + 6)))) then
		if v14(v24.AncestralCall) then
			return "ancestral_call racials 10";
		end
	end
	if (v24.ArcanePulse:IsCastable() and v7:IsInRange(858 - (20 + 830)) and v26[5 + 1] and ((v59 >= (128 - (116 + 10))) or ((v6:Rune() <= (1 + 0)) and (v6:RunicPowerDeficit() >= (798 - (542 + 196)))))) then
		if v14(v24.ArcanePulse) then
			return "arcane_pulse racials 12";
		end
	end
	if (v24.Fireblood:IsCastable() and v7:IsInRange(10 - 5) and v26[2 + 4] and ((((v24.Fireblood:BaseDuration() + 2 + 1) >= v50) and v49) or ((not v24.SummonGargoyle:IsAvailable() or (v24.SummonGargoyle:CooldownRemains() > (22 + 38))) and ((v47 and (v48 <= (v24.Fireblood:BaseDuration() + (7 - 4)))) or (v45 and (v46 <= (v24.Fireblood:BaseDuration() + (7 - 4)))) or ((v59 >= (1553 - (1126 + 425))) and v6:DnDTicking()))) or (v63 <= (v24.Fireblood:BaseDuration() + (408 - (118 + 287)))))) then
		if v14(v24.Fireblood) then
			return "fireblood racials 14";
		end
	end
	if (v24.BagofTricks:IsCastable() and v7:IsInRange(19 - 14) and v26[1127 - (118 + 1003)] and (v59 <= (2 - 1)) and (v6:BuffUp(v24.UnholyStrengthBuff) or (v63 < (382 - (142 + 235))))) then
		if v14(v24.BagofTricks) then
			return "bag_of_tricks racials 16";
		end
	end
end
local function v134()
	if (v24.AntiMagicShell:IsCastable() and v35.Commons.UseAMSAMZOffensively and (v35.Unholy.AMSAbsorbPercent > (0 - 0)) and (v6:RunicPower() < (9 + 31))) then
		if v14(v24.AntiMagicShell) then
			return "antimagic_shell san_fishing 2";
		end
	end
	if (v53:IsReady() and v26[981 - (553 + 424)] and ((v58 >= (1 - 0)) or v7:IsInRange(8 + 0)) and (v35.Commons.DnDMoving or not v6:IsMoving()) and v6:BuffDown(v24.DeathAndDecayBuff) and not v24.VampiricStrikeAction:IsLearned()) then
		if v13.CastTarget(v24.DeathAndDecay, v13.TName().PLAYER) then
			return "any_dnd san_fishing 4";
		end
	end
	if (v24.DeathCoil:IsReady() and v7:IsSpellInRange(v24.DeathCoil) and v6:BuffUp(v24.SuddenDoomBuff) and v24.DoomedBidding:IsAvailable()) then
		if v14(v24.DeathCoil) then
			return "death_coil san_fishing 6";
		end
	end
	if (v24.SoulReaper:IsReady() and v7:IsInMeleeRange(5 + 0) and ((v7:HealthPercentage() <= (21 + 14)) or (v7:TimeToX(15 + 20) <= (3 + 2))) and (v7:TimeToDie() > (10 - 5))) then
		if v14(v24.SoulReaper) then
			return "soul_reaper san_fishing 8";
		end
	end
	if (v24.DeathCoil:IsReady() and v7:IsSpellInRange(v24.DeathCoil) and not v24.VampiricStrikeAction:IsLearned()) then
		if v14(v24.DeathCoil) then
			return "death_coil san_fishing 10";
		end
	end
	if (v51:IsReady() and v7:IsInRange(WoundSpenderRange) and (v54 >= (2 - 1)) and (((v54 >= ((6 - 3) - v17(v43))) and (v24.Apocalypse:CooldownRemains() > v38)) or v24.VampiricStrikeAction:IsLearned())) then
		if v14(v52) then
			return "wound_spender san_fishing 12";
		end
	end
	if (v55:IsReady() and v7:IsInMeleeRange(v56) and (v54 < ((1 + 2) - v17(v43)))) then
		if v14(v55) then
			return "festering_strike san_fishing 14";
		end
	end
end
local function v135()
	if (v53:IsReady() and v26[19 - 15] and ((v58 >= (754 - (239 + 514))) or v7:IsInRange(3 + 5)) and (v35.Commons.DnDMoving or not v6:IsMoving()) and v6:BuffDown(v24.DeathAndDecayBuff) and v24.UnholyGround:IsAvailable() and (v24.DarkTransformation:CooldownRemains() < (1334 - (797 + 532)))) then
		if v13.CastTarget(v24.DeathAndDecay, v13.TName().PLAYER) then
			return "any_dnd san_st 1";
		end
	end
	if (v24.DeathCoil:IsReady() and v7:IsSpellInRange(v24.DeathCoil) and ((v6:BuffUp(v24.SuddenDoomBuff) and v6:BuffUp(v24.GiftoftheSanlaynBuff) and (v24.DoomedBidding:IsAvailable() or v24.RottenTouch:IsAvailable())) or ((v6:Rune() < (2 + 0)) and v6:BuffDown(v24.RunicCorruptionBuff)))) then
		if v14(v24.DeathCoil) then
			return "death_coil san_st 2";
		end
	end
	if (v51:IsReady() and v7:IsSpellInRange(v24.DeathCoil) and ((v6:BuffUp(v24.GiftoftheSanlaynBuff) and v24.VampiricStrikeAction:IsLearned()) or (v24.GiftoftheSanlayn:IsAvailable() and v10:BuffUp(v24.DarkTransformation) and (v10:BuffRemains(v24.DarkTransformation) < v6:GCD())))) then
		if v14(v52) then
			return "wound_spender san_st 4";
		end
	end
	if (v24.SoulReaper:IsReady() and v7:IsInMeleeRange(2 + 3) and ((v7:HealthPercentage() <= (81 - 46)) or (v7:TimeToX(1237 - (373 + 829)) <= (736 - (476 + 255)))) and (v7:TimeToDie() > (1135 - (369 + 761))) and v6:BuffDown(v24.GiftoftheSanlaynBuff)) then
		if v14(v24.SoulReaper) then
			return "soul_reaper san_st 6";
		end
	end
	if (v51:IsReady() and v24.VampiricStrikeAction:IsLearned() and (v54 >= (1 + 0))) then
		if v14(v51, nil, nil, not v7:IsSpellInRange(v51)) then
			return "wound_spender san_st 7";
		end
	end
	if (v55:IsReady() and v7:IsInMeleeRange(v56) and (((v54 < (6 - 2)) and (v24.Apocalypse:CooldownRemains() < v38)) or (((v24.GiftoftheSanlayn:IsAvailable() and v6:BuffDown(v24.GiftoftheSanlaynBuff)) or not v24.GiftoftheSanlayn:IsAvailable()) and (v6:BuffUp(v24.FesteringScytheBuff) or (v54 <= ((1 - 0) - v17(v43))))))) then
		if v14(v55) then
			return "festering_strike san_st 8";
		end
	end
	if (v51:IsReady() and (not v24.Apocalypse:IsAvailable() or (v24.Apocalypse:CooldownRemains() > v38)) and ((v54 >= ((241 - (64 + 174)) - v17(v43))) or v24.VampiricStrikeAction:IsLearned())) then
		if v14(v52) then
			return "wound_spender san_st 10";
		end
	end
	if (v24.DeathCoil:IsReady() and v7:IsSpellInRange(v24.DeathCoil) and ((not v40 and (v7:DebuffRemains(v24.DeathRotDebuff) < v6:GCD())) or (v6:BuffUp(v24.SuddenDoomBuff) and (v54 >= (1 + 0))) or (v6:Rune() < (2 - 0)))) then
		if v14(v24.DeathCoil) then
			return "death_coil san_st 12";
		end
	end
	if (v51:IsReady() and v7:IsInRange(WoundSpenderRange) and (v54 >= (337 - (144 + 192))) and (v54 > (220 - (42 + 174)))) then
		if v14(v52) then
			return "wound_spender san_st 14";
		end
	end
	if (v24.DeathCoil:IsReady() and v7:IsSpellInRange(v24.DeathCoil) and not v40) then
		if v14(v24.DeathCoil) then
			return "death_coil san_st 16";
		end
	end
end
local function v136()
	if (v35.Commons.Enabled.Items and v25.Fyralath:IsReady() and v7:DebuffUp(v24.MarkofFyralathDebuff) and ((v59 < (4 + 1)) or (v59 > (18 + 3)) or (v63 < (2 + 2))) and (v43 or v47 or (not v24.RaiseAbomination:IsAvailable() and not v24.ArmyoftheDead:IsAvailable()) or (v3.CombatTime() > (1519 - (363 + 1141))))) then
		v13.CastMacro(1581 - (1183 + 397), nil, nil, v25.Fyralath);
		return "fyralath_the_dreamrender san_trinkets 2";
	end
end
if v35.Commons.Enabled.Trinkets then
	if (v25.TreacherousTransmitter:IsEquippedAndReady() and (((v66 == v25.TreacherousTransmitter:ID()) and v26[21 - 14]) or ((v67 == v25.TreacherousTransmitter:ID()) and v26[6 + 2].Trinket2Setting)) and v7:IsInMeleeRange(4 + 1) and (v37 or v36) and (v24.DarkTransformation:CooldownRemains() < (1978 - (1913 + 62)))) then
		if v14(v25.TreacherousTransmitter, nil) then
			return "treacherous_transmitter san_trinkets 2";
		end
	end
	if (v29:IsReady() and v26[5 + 2] and not v76 and ((v78 and v10:BuffUp(v24.DarkTransformation) and (v10:BuffRemains(v24.DarkTransformation) < (v80 * (0.73 - 0))) and ((v84 == (1934 - (565 + 1368))) or v30:CooldownDown() or not v30:HasCooldown())) or (v80 >= v63))) then
		if v14(v29, true) then
			return "Generic use_item for " .. v29:Name() .. " san_trinkets 4";
		end
	end
	if (v30:IsReady() and v26[30 - 22] and not v77 and ((v79 and v10:BuffUp(v24.DarkTransformation) and (v10:BuffRemains(v24.DarkTransformation) < (v81 * (1661.73 - (1477 + 184)))) and ((v84 == (2 - 0)) or v29:CooldownDown() or not v29:HasCooldown())) or (v81 >= v63))) then
		if v14(v30, true) then
			return "Generic use_item for " .. v30:Name() .. " san_trinkets 6";
		end
	end
	if (v29:IsReady() and v26[7 + 0] and not v76 and ((not v78 and (((v72 > (856 - (564 + 292))) and v6:BuffDown(v24.GiftoftheSanlaynBuff)) or (v72 == (0 - 0))) and ((v85 == (2 - 1)) or v30:CooldownDown() or not v30:HasCooldown() or (not v24.SummonGargoyle:IsAvailable() and not v24.ArmyoftheDead:IsAvailable() and not v24.RaiseAbomination:IsAvailable()) or (not v24.SummonGargoyle:IsAvailable() and v24.ArmyoftheDead:IsAvailable() and ((not v24.RaiseAbomination:IsAvailable() and (v24.ArmyoftheDead:CooldownRemains() > (324 - (244 + 60)))) or (v24.RaiseAbomination:IsAvailable() and (v24.RaiseAbomination:CooldownRemains() > (16 + 4))))) or (not v24.SummonGargoyle:IsAvailable() and not v24.ArmyoftheDead:IsAvailable() and not v24.RaiseAbomination:IsAvailable() and (v24.DarkTransformation:CooldownRemains() > (496 - (41 + 435)))) or (v24.SummonGargoyle:IsAvailable() and (v24.SummonGargoyle:CooldownRemains() > (1021 - (938 + 63))) and not v49))) or (v63 < (12 + 3)))) then
		if v14(v29, true) then
			return "Generic use_item for " .. v29:Name() .. " san_trinkets 8";
		end
	end
	if (v30:IsReady() and v26[1133 - (936 + 189)] and not v77 and ((not v79 and (((v73 > (0 + 0)) and v6:BuffDown(v24.GiftoftheSanlaynBuff)) or (v73 == (1613 - (1565 + 48)))) and ((v85 == (2 + 0)) or v29:CooldownDown() or not v29:HasCooldown() or (not v24.SummonGargoyle:IsAvailable() and not v24.ArmyoftheDead:IsAvailable() and not v24.RaiseAbomination:IsAvailable()) or (not v24.SummonGargoyle:IsAvailable() and v24.ArmyoftheDead:IsAvailable() and ((not v24.RaiseAbomination:IsAvailable() and (v24.ArmyoftheDead:CooldownRemains() > (1158 - (782 + 356)))) or (v24.RaiseAbomination:IsAvailable() and (v24.RaiseAbomination:CooldownRemains() > (287 - (176 + 91)))))) or (not SummonGargoyle:IsAvailable() and not v24.ArmyoftheDead:IsAvailable() and not v24.RaiseAbomination:IsAvailable() and (v24.DarkTransformation:CooldownRemains() > (52 - 32))) or (v24.SummonGargoyle:IsAvailable() and (v24.SummonGargoyle:CooldownRemains() > (29 - 9)) and not v49))) or (v63 < (1107 - (975 + 117))))) then
		if v14(v30, true) then
			return "Generic use_item for " .. v30:Name() .. " san_trinkets 10";
		end
	end
	if (v35.Commons.Enabled.Items and WeaponSetting) then
		local v226, v227, v228 = v6:GetUseableItems(v27, nil, true);
		if (v226 and v7:IsInMeleeRange(1880 - (157 + 1718)) and (not v78 or v29:CooldownDown()) and (not v79 or v30:CooldownDown())) then
			v13.CastMacro(1 + 0, nil, nil);
			return v226:Name() .. " san_trinkets 12";
		end
	end
end
local function v137()
	if (v24.SoulReaper:IsReady() and v7:IsInMeleeRange(17 - 12) and ((v7:HealthPercentage() <= (119 - 84)) or (v7:TimeToX(1053 - (697 + 321)) <= (13 - 8))) and (v7:TimeToDie() > (10 - 5))) then
		if v14(v24.SoulReaper) then
			return "soul_reaper st 2";
		end
	end
	if (v51:IsReady() and v7:IsInMeleeRange(v56) and (v7:DebuffUp(v24.TrollbaneSlowDebuff))) then
		if v14(v51) then
			return "wound_spender st 4";
		end
	end
	print(tostring(v53:IsReady() and v26[8 - 4] and ((v58 >= (1 + 0)) or v7:IsInRange(14 - 6)) and (v35.Commons.DnDMoving or not v6:IsMoving()) and v24.UnholyGround:IsAvailable() and v6:BuffDown(v24.DeathAndDecayBuff) and (v45 or v43 or v49)));
	if (v53:IsReady() and v26[10 - 6] and ((v58 >= (1228 - (322 + 905))) or v7:IsInRange(619 - (602 + 9))) and (v35.Commons.DnDMoving or not v6:IsMoving()) and v24.UnholyGround:IsAvailable() and v6:BuffDown(v24.DeathAndDecayBuff) and (v45 or v43 or v49)) then
		if v13.CastTarget(v24.DeathAndDecay, v13.TName().PLAYER) then
			return "any_dnd st 6";
		end
	end
	if (v24.DeathCoil:IsReady() and v7:IsSpellInRange(v24.DeathCoil) and ((not v40 and v41) or (v63 < (1199 - (449 + 740))))) then
		if v14(v24.DeathCoil) then
			return "death_coil st 8";
		end
	end
	if (v55:IsReady() and v7:IsInMeleeRange(v56) and (v54 < (876 - (826 + 46))) and (not v39 or v6:BuffUp(v24.FesteringScytheBuff))) then
		if v14(v55) then
			return "festering_strike st 10";
		end
	end
	if (v51:IsReady() and v7:IsInRange(WoundSpenderRange) and (v54 >= (948 - (245 + 702))) and v39) then
		if v14(v52) then
			return "wound_spender st 12";
		end
	end
	if (v24.DeathCoil:IsReady() and v7:IsSpellInRange(v24.DeathCoil) and not v40) then
		if v14(v24.DeathCoil) then
			return "death_coil st 14";
		end
	end
	if (v51:IsReady() and v7:IsInRange(WoundSpenderRange) and (v54 >= (3 - 2)) and not v39 and (v54 >= (2 + 2))) then
		if v14(v52) then
			return "wound_spender st 16";
		end
	end
end
local function v138()
	if (v35.Commons.Enabled.Items and WeaponSetting and v25.Fyralath:IsReady() and v7:DebuffUp(v24.MarkofFyralathDebuff) and ((v59 < (1903 - (260 + 1638))) or (v59 > (461 - (382 + 58))) or (v63 < (12 - 8))) and (v43 or v47 or (not v24.RaiseAbomination:IsAvailable() and not v24.ArmyoftheDead:IsAvailable()) or (v3.CombatTime() > (13 + 2)))) then
		v13.CastMacro(1 - 0, nil, nil, v25.Fyralath);
		return "weapon cast";
	end
	if v35.Commons.Enabled.Trinkets then
		if (v25.TreacherousTransmitter:IsEquippedAndReady() and (((v66 == v25.TreacherousTransmitter:ID()) and v26[20 - 13]) or ((v67 == v25.TreacherousTransmitter:ID()) and v26[1213 - (902 + 303)])) and v7:IsInMeleeRange(10 - 5) and (v37 or v36) and (v24.DarkTransformation:CooldownRemains() < (6 - 3))) then
			if v14(v25.TreacherousTransmitter, nil) then
				return "treacherous_transmitter san_trinkets 2";
			end
		end
		if (v29:IsReady() and v26[1 + 6] and ((v78 and ((not v24.SummonGargoyle:IsAvailable() and (((not v24.ArmyoftheDead:IsAvailable() or (v24.ArmyoftheDead:IsAvailable() and (v24.ArmyoftheDead:CooldownRemains() > (v74 * (1690.51 - (1121 + 569))))) or v35.Commons.DisableAotD or (v24.RaiseAbomination:IsAvailable() and (v24.RaiseAbomination:CooldownRemains() > (v74 * (214.51 - (22 + 192)))))) and ((((703 - (483 + 200)) > v80) and v45 and (v46 <= (v80 * (1464.2 - (1404 + 59))))) or (((54 - 34) <= v80) and (v24.Apocalypse:CooldownRemains() < v6:GCD()) and v10:BuffUp(v24.DarkTransformation)) or ((not v24.Apocalypse:IsAvailable() or (v59 >= (2 - 0))) and v10:BuffUp(v24.DarkTransformation)))) or (v47 and (v48 < (v80 * (766.2 - (468 + 297))))) or (v43 and (v44 < (v80 * (563.2 - (334 + 228))))))) or (v24.SummonGargoyle:IsAvailable() and v49 and (v50 < (v80 * (3.2 - 2)))) or (v24.SummonGargoyle:CooldownRemains() > (185 - 105))) and ((v84 == (1 - 0)) or Trinekt2:CooldownDown() or not v30:HasCooldown())) or (v80 >= v63))) then
			if v14(v29, true) then
				return "Generic use_item for " .. v29:Name() .. " trinkets 4";
			end
		end
		if (v30:IsReady() and v26[3 + 5] and ((v79 and ((not v24.SummonGargoyle:IsAvailable() and (((not v24.ArmyoftheDead:IsAvailable() or (v24.ArmyoftheDead:IsAvailable() and (v24.ArmyoftheDead:CooldownRemains() > (v75 * (236.51 - (141 + 95))))) or v35.Commons.DisableAotD or (v24.RaiseAbomination:IsAvailable() and (v24.RaiseAbomination:CooldownRemains() > (v75 * (0.51 + 0))))) and ((((51 - 31) > v81) and v45 and (v46 <= (v81 * (2.2 - 1)))) or (((5 + 15) <= v81) and (v24.Apocalypse:CooldownRemains() < v6:GCD()) and v10:BuffUp(v24.DarkTransformation)) or ((not v24.Apocalypse:IsAvailable() or (v59 >= (5 - 3))) and v10:BuffUp(v24.DarkTransformation)))) or (v47 and (v48 < (v81 * (1.2 + 0)))) or (v43 and (v44 < (v81 * (1.2 + 0)))))) or (v24.SummonGargoyle:IsAvailable() and v49 and (v50 < (v81 * (1.2 - 0)))) or (v24.SummonGargoyle:CooldownRemains() > (48 + 32))) and ((v84 == (165 - (92 + 71))) or v29:CooldownDown() or not v29:HasCooldown())) or (v81 >= v63))) then
			if v14(v30, true) then
				return "Generic use_item for " .. v30:Name() .. " trinkets 6";
			end
		end
		if (v29:IsReady() and v26[4 + 3] and ((not v78 and ((v85 == (1 - 0)) or v30:CooldownDown() or not v30:HasCooldown() or (not v24.SummonGargoyle:IsAvailable() and not v24.ArmyoftheDead:IsAvailable() and not v24.RaiseAbomination:IsAvailable()) or (not v24.SummonGargoyle:IsAvailable() and v24.ArmyoftheDead:IsAvailable() and ((not v24.RaiseAbomination:IsAvailable() and (v24.ArmyoftheDead:CooldownRemains() > (785 - (574 + 191)))) or (v24.RaiseAbomination:IsAvailable() and (v24.RaiseAbomination:CooldownRemains() > (17 + 3))))) or (not v24.SummonGargoyle:IsAvailable() and not v24.ArmyoftheDead:IsAvailable() and not v24.RaiseAbomination:IsAvailable() and (v24.DarkTransformation:CooldownRemains() > (50 - 30))) or (v24.SummonGargoyle:IsAvailable() and (v24.SummonGargoyle:CooldownRemains() > (11 + 9)) and not v49))) or (v63 < (864 - (254 + 595))))) then
			if v14(v29, true) then
				return "Generic use_item for " .. v29:Name() .. " trinkets 8";
			end
		end
		if (v30:IsReady() and v26[134 - (55 + 71)] and ((not v79 and ((v85 == (2 - 0)) or v29:CooldownDown() or not v29:HasCooldown() or (not v24.SummonGargoyle:IsAvailable() and not v24.ArmyoftheDead:IsAvailable() and not v24.RaiseAbomination:IsAvailable()) or (not v24.SummonGargoyle:IsAvailable() and v24.ArmyoftheDead:IsAvailable() and ((not v24.RaiseAbomination:IsAvailable() and (v24.ArmyoftheDead:CooldownRemains() > (1810 - (573 + 1217)))) or (v24.RaiseAbomination:IsAvailable() and (v24.RaiseAbomination:CooldownRemains() > (55 - 35))))) or (not v24.SummonGargoyle:IsAvailable() and not v24.ArmyoftheDead:IsAvailable() and not v24.RaiseAbomination:IsAvailable() and (v24.DarkTransformation:CooldownRemains() > (2 + 18))) or (v24.SummonGargoyle:IsAvailable() and (v24.SummonGargoyle:CooldownRemains() > (32 - 12)) and not v49))) or (v63 < (954 - (714 + 225))))) then
			if v14(v30, true) then
				return "Generic use_item for " .. v30:Name() .. " trinkets 10";
			end
		end
	end
end
local function v139()
	v36 = (v59 == (2 - 1)) or not v16();
	v37 = (v59 >= (2 - 0)) and (v64 > (1 + 5));
	v38 = ((v24.Apocalypse:CooldownRemains() < (6 - 1)) and (v54 < (807 - (118 + 688))) and (v24.UnholyAssault:CooldownRemains() > (53 - (25 + 23))) and (1 + 2)) or (1886 - (927 + 959));
	v39 = (((v24.Apocalypse:CooldownRemains() > v38) or not v24.Apocalypse:IsAvailable()) and (((v54 >= (3 - 2)) and (v24.UnholyAssault:CooldownRemains() < (752 - (16 + 716))) and v24.UnholyAssault:IsAvailable() and v36) or (v7:DebuffUp(v24.RottenTouchDebuff) and (v54 >= (1 - 0))) or (v54 >= ((101 - (11 + 86)) - v17(v43))))) or ((v63 < (12 - 7)) and (v54 >= (286 - (175 + 110))));
	v40 = v24.VileContagion:IsAvailable() and (v24.VileContagion:CooldownRemains() < (12 - 7)) and (v6:RunicPower() < (147 - 117));
	v41 = (not v24.RottenTouch:IsAvailable() or (v24.RottenTouch:IsAvailable() and v7:DebuffDown(v24.RottenTouchDebuff)) or (v6:RunicPowerDeficit() < (1816 - (503 + 1293)))) and ((v24.ImprovedDeathCoil:IsAvailable() and ((v59 == (5 - 3)) or v24.CoilofDevastation:IsAvailable())) or (v6:Rune() < (3 + 0)) or v49 or v6:BuffUp(v24.SuddenDoomBuff) or (not v39 and (v54 >= (1065 - (810 + 251)))));
	v42 = 3 + 0 + v17(v24.ImprovedDeathCoil:IsAvailable()) + v17(v24.FrenziedBloodthirst:IsAvailable() and (v6:BuffStack(v24.EssenceoftheBloodQueenBuff) > (2 + 3))) + v17(v24.HungeringThirst:IsAvailable() and v24.HarbingerofDoom:IsAvailable() and v6:BuffUp(v24.SuddenDoomBuff));
end
local function v140()
	v26[1 + 0] = v13.ToggleIconFrame:GetToggle(534 - (43 + 490));
	v26[735 - (711 + 22)] = v13.ToggleIconFrame:GetToggle(7 - 5);
	v26[862 - (240 + 619)] = v13.ToggleIconFrame:GetToggle(1 + 2);
	v26[5 - 1] = v13.ToggleIconFrame:GetToggle(1 + 3) and (v35.Commons.DnDMoving or not v6:IsMoving()) and v88(1752 - (1344 + 400));
end
local function v141()
	v57 = v6:GetEnemiesInMeleeRange(413 - (255 + 150));
	v60 = v7:GetEnemiesInSplashRange(8 + 2);
	if v16() then
		v58 = #v57;
		v61 = v7:GetEnemiesInSplashRangeCount(6 + 4);
	else
		v58 = 4 - 3;
		v61 = 3 - 2;
	end
	v59 = v20(v58, v61);
end
local function v142()
	v62 = v97(v60);
end
local function v143()
	v43 = v65:AbomActive();
	v44 = v65:AbomRemains();
	v45 = v24.Apocalypse:TimeSinceLastCast() <= (1754 - (404 + 1335));
	v46 = (v45 and ((421 - (183 + 223)) - v24.Apocalypse:TimeSinceLastCast())) or (0 - 0);
	v47 = v24.ArmyoftheDead:TimeSinceLastCast() <= (20 + 10);
	v48 = (v47 and ((11 + 19) - v24.ArmyoftheDead:TimeSinceLastCast())) or (337 - (10 + 327));
	v49 = v65:GargActive();
	v50 = v65:GargRemains();
	v54 = v7:DebuffStack(v24.FesteringWoundDebuff);
	if v24.FesteringScytheAction:IsLearned() then
		v55 = v24.FesteringScytheAction;
		v56 = 10 + 4;
	else
		v55 = v24.FesteringStrike;
		v56 = 343 - (118 + 220);
	end
end
local function v144()
	v34.HealthPotions();
	if v6:IsChanneling(v25.ManicGrieftorch.ItemUseSpell) then
		return "Dont cut Torch";
	end
	v140();
	v141();
	v142();
	v59 = v20(v58, v61);
	v143();
	v51 = (v24.VampiricStrikeAction:IsLearned() and v24.VampiricStrikeAction) or ((v24.ClawingShadows:IsAvailable()) and v24.ClawingShadows) or v24.ScourgeStrike;
	v26[2 + 3] = v86(v35.Unholy.DarkTransformationSetting) and v88(v35.TTD.DarkTransformationTTD) and v7:IsInMeleeRange(454 - (108 + 341));
	v26[3 + 3] = v86(v35.Unholy.RacialsSetting) and v88(v35.TTD.RacialsTTD) and v7:IsInMeleeRange(21 - 16);
	v26[1500 - (711 + 782)] = v86(v35.Unholy.Trinket1Setting) and v88(v35.TTD.TrinketsTTD);
	v26[15 - 7] = v86(v35.Unholy.Trinket2Setting) and v88(v35.TTD.TrinketsTTD);
	v26[478 - (270 + 199)] = v86(v35.Unholy.PotionSetting) and not v34.ISSolo();
	v26[4 + 6] = v86(v35.Unholy.ApocalypseSetting) and v88(v35.TTD.ApocalypseTTD) and v7:IsInMeleeRange(1824 - (580 + 1239));
	v26[32 - 21] = v86(v35.Unholy.UnholyAssaultSetting) and v88(v35.TTD.UnholyAssaultTTD) and v7:IsInMeleeRange(5 + 0);
	v26[1 + 11] = v86(v35.Unholy.AbominationLimbSetting) and not IsNpcNearPlayer() and v88(v35.TTD.AbominationLimbTTD) and v7:IsInMeleeRange(7 + 8);
	v26[33 - 20] = v86(v35.Unholy.EmpowerRuneWeaponSetting) and v88(v35.TTD.EmpowerRuneWeaponTTD) and v7:IsInMeleeRange(4 + 1);
	v26[1181 - (645 + 522)] = v86(v35.Unholy.UnholyBlightSetting) and v88(v35.TTD.UnholyBlightTTD);
	v26[1805 - (1010 + 780)] = v86(v35.Unholy.SummonGargoyleSetting) and v88(v35.TTD.SummonGargoyleTTD);
	v26[16 + 0] = v86(v35.Unholy.RaiseAbominationSetting) and v88(v35.TTD.SummonGargoyleTTD);
	v26[80 - 63] = v86(v35.Unholy.ArmyOfTheDeadSetting) and v88(117 - 77);
	v26[1854 - (1045 + 791)] = v86(v35.Unholy.Weapon);
	if (v34.TargetIsValid() or v6:AffectingCombat()) then
		v63 = v3.BossFightRemains();
		IsBossfight = true;
		v64 = v63;
		if (v64 == (28124 - 17013)) then
			IsBossfight = false;
			v64 = v3.FightRemains(v57, false);
		end
		v51 = ((v24.VampiricStrikeAction:IsLearned()) and v24.VampiricStrikeAction) or ((v24.ClawingShadows:IsAvailable()) and v24.ClawingShadows) or v24.ScourgeStrike;
		v53 = ((v24.Defile:IsAvailable()) and v24.Defile) or v24.DeathAndDecay;
		WoundSpenderRange = ((v24.ClawingShadows:IsAvailable() or v24.VampiricStrikeAction:IsAvailable()) and (45 - 15)) or (510 - (351 + 154));
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
			local v229 = v123();
			if v229 then
				return v229;
			end
		end
		if (v24.DeathStrike:IsReady() and v96()) then
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
		if v26[1577 - (1281 + 293)] then
			v31 = v34.InterruptCycle(v24.MindFreeze, 281 - (28 + 238), true, nil, false);
			if v31 then
				return v31;
			end
			if v35.Commons.BlindingSleet then
				v31 = v34.InterruptCycle(v24.BlindingSleet, 26 - 14, true, nil, true, true);
				if v31 then
					return v31;
				end
			end
			v31 = v34.InterruptCycle(v24.Asphyxiate, 1579 - (1381 + 178), true, nil, true);
			if v31 then
				return v31;
			end
		end
		if not v7:IsInRange(10 + 0) then
			if (v24.Outbreak:IsReady() and v7:IsSpellInRange(v24.Outbreak) and v121(v7)) then
				if v14(v24.Outbreak) then
					return "outbreak out_of_range";
				end
			end
			if (v24.Epidemic:IsReady() and v7:IsInRange(33 + 7) and v16() and (v24.VirulentPlagueDebuff:AuraActiveCount() > (1 + 0)) and not v40) then
				if v14(v24.Epidemic, false, nil, not v7:IsInRange(137 - 97)) then
					return "epidemic out_of_range";
				end
			end
			if (v24.DeathCoil:IsReady() and v7:IsSpellInRange(v24.DeathCoil) and (v24.VirulentPlagueDebuff:AuraActiveCount() < (2 + 0)) and not v40) then
				if v14(v24.DeathCoil) then
					return "death_coil out_of_range";
				end
			end
		end
		v139();
		if v24.VampiricStrike:IsAvailable() then
			local v230 = v136();
			if v230 then
				return v230;
			end
		end
		if ((v35.Commons.Enabled.Trinkets or v35.Commons.Enabled.Items) and not v24.VampiricStrike:IsAvailable()) then
			local v231 = v138();
			if v231 then
				return v231;
			end
		end
		if true then
			local v232 = v133();
			if v232 then
				return v232;
			end
		end
		if true then
			local v233 = v131();
			if v233 then
				return v233;
			end
		end
		if (v16() and v24.VampiricStrike:IsAvailable() and (v59 >= (472 - (381 + 89)))) then
			local v234 = v129();
			if v234 then
				return v234;
			end
		end
		if (v16() and not v24.VampiricStrike:IsAvailable() and (v59 >= (2 + 0))) then
			local v235 = v128();
			if v235 then
				return v235;
			end
		end
		if (v24.VampiricStrike:IsAvailable() and ((v59 <= (1 + 0)) or not v16())) then
			local v236 = v130();
			if v236 then
				return v236;
			end
		end
		if (not v24.VampiricStrike:IsAvailable() and ((v59 <= (1 - 0)) or not v16())) then
			local v237 = v127();
			if v237 then
				return v237;
			end
		end
		if (v16() and (v59 == (1158 - (1074 + 82)))) then
			local v238 = v132();
			if v238 then
				return v238;
			end
		end
		if (v16() and (v59 >= (6 - 3)) and not v6:DnDTicking() and (v53:CooldownRemains() < (1794 - (214 + 1570)))) then
			local v239 = v126();
			if v239 then
				return v239;
			end
		end
		if (v16() and (v59 >= (1458 - (990 + 465))) and v6:BuffUp(v24.DeathAndDecayBuff)) then
			local v240 = v125();
			if v240 then
				return v240;
			end
		end
		if (v16() and (v59 >= (2 + 1)) and v6:BuffDown(v24.DeathAndDecayBuff)) then
			local v241 = v124();
			if v241 then
				return v241;
			end
		end
		if (((v59 <= (1 + 0)) or not v16()) and v24.GiftoftheSanlayn:IsAvailable() and v24.DarkTransformation:CooldownDown() and v6:BuffDown(v24.GiftoftheSanlaynBuff) and (v6:BuffRemains(v24.EssenceoftheBloodQueenBuff) < (v24.DarkTransformation:CooldownRemains() + 2 + 0))) then
			local v242 = v134();
			if v242 then
				return v242;
			end
			if v13.CastAnnotated(v24.Pool, false, "WAIT") then
				return "Pool for SanFishing()";
			end
		end
		if (((v59 <= (3 - 2)) or not v16()) and v24.VampiricStrike:IsAvailable()) then
			local v243 = v135();
			if v243 then
				return v243;
			end
		end
		if (((v59 <= (1727 - (1668 + 58))) or not v16()) and not v24.VampiricStrike:IsAvailable()) then
			local v244 = v137();
			if v244 then
				return v244;
			end
		end
		if (v55:IsReady() and v7:IsInMeleeRange(v56) and (v6:Rune() >= (632 - (512 + 114)))) then
			if v14(v55) then
				return "festering_strike anti cap";
			end
		end
		if (v51:IsReady() and v7:IsInRange(WoundSpenderRange) and not v7:IsInMeleeRange(20 - 12) and (v54 >= (1 - 0))) then
			if v14(v52) then
				return "Wound Spender OOR";
			end
		end
		if v13.CastAnnotated(v24.Pool, false, "WAIT") then
			return "pool_resources";
		end
		v31 = (v58 > (0 - 0)) and not v7:IsInRange(4 + 4) and v95();
	end
end
local function v145()
	v24.VirulentPlagueDebuff:RegisterAuraTracking();
	v24.FesteringWoundDebuff:RegisterAuraTracking();
	v24.MarkofFyralathDebuff:RegisterAuraTracking();
	v35.Unholy.Display();
	v13:UpdateMacro("macro1", "/use 16");
	v13:UpdateMacro("macro2", "/target [@mouseover]");
	v34.PostInitialMessage(48 + 204);
end
v13.SetAPL(220 + 32, v144, v145);
