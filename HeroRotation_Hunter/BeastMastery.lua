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
local v12 = v3.Action;
local v13 = HeroRotation();
local v14 = v13.AoEON;
local v15 = v13.CDsON;
local v16 = v13.Cast;
local v17 = v13.CastSuggested;
local v18 = v13.Commons().Everyone.num;
local v19 = v13.Commons().Everyone.bool;
local v20 = C_Timer.After;
local v21 = math.max;
local v22 = v13.Commons().Everyone;
local v23 = v13.Commons().Hunter;
local v24 = v13.GUISettingsGet();
local v25 = {General=v24.General,Commons=v24.APL.Hunter.Commons,Pet=v24.APL.Hunter.BMPet,Defensives=v24.APL.Hunter.Defensives,BeastMastery=v24.APL.Hunter.BeastMastery,TTD=v24.APL.Hunter.BeastMastery_TTD};
local v26 = v10.Hunter.BeastMastery;
local v27 = {v26.SummonPet,v26.SummonPet2,v26.SummonPet3,v26.SummonPet4,v26.SummonPet5};
local v28 = v11.Hunter.BeastMastery;
local v29 = {v28.BeacontotheBeyond:ID(),v28.ManicGrieftorch:ID()};
local v30 = v6:GetEquipment();
local v31 = (v30[940 - (214 + 713)] and v11(v30[4 + 9])) or v11(0 + 0);
local v32 = (v30[891 - (282 + 595)] and v11(v30[1651 - (1523 + 114)])) or v11(0 + 0);
local v33;
local v34;
local v35 = 15839 - 4728;
local v36 = 12176 - (68 + 997);
local v37 = false;
local v38 = false;
local v39 = 1270 - (226 + 1044);
local v31, v32;
local v40, v41;
local v42, v43;
local v44, v45;
local v46, v47;
local v48, v49;
local v50, v51;
local v52;
local v53, v54, v55;
local v56, v57;
local v58;
local v59;
local v60, v61;
local v62;
local v63;
local v64;
local v65 = (v26.BlackArrow:IsLearned() and v26.BlackArrow) or v26.KillShot;
local v66 = (v26.BlackArrow:IsLearned() and v26.KillShotBM) or v26.KillShot;
local v67 = 0 - 0;
local function v68()
	local v100, v101 = v6:GetTrinketData(v29);
	if ((v67 < (122 - (32 + 85))) and ((v100.ID == (0 + 0)) or (v101.ID == (0 + 0)) or ((v100.SpellID > (957 - (892 + 65))) and not v100.Usable) or ((v101.SpellID > (0 - 0)) and not v101.Usable))) then
		v67 = v67 + (1 - 0);
		v20(8 - 3, function()
			v68();
		end);
		return;
	end
	v31 = v100.Object;
	v32 = v101.Object;
	v42 = v100.Spell;
	v44 = v100.Range;
	v40 = v100.CastTime;
	v43 = v101.Spell;
	v45 = v101.Range;
	v41 = v101.CastTime;
	v46 = v100.Cooldown;
	v47 = v101.Cooldown;
	v48 = v100.Excluded;
	v49 = v101.Excluded;
	v50 = (v46 == (350 - (87 + 263))) or (v31:HasUseBuff() and (not v32:HasUseBuff() or ((not v100.ID == v28.MirrorofFracturedTomorrows:ID()) and ((v101.ID == v28.MirrorofFracturedTomorrows:ID()) or (v47 < v46) or (v41 < v40) or ((v41 == v40) and (v47 == v46)))))) or (not v31:HasUseBuff() and not v32:HasUseBuff() and ((v47 < v46) or (v41 < v40) or ((v41 == v40) and (v47 == v46))));
	v51 = not v50;
end
v68();
v3:RegisterForEvent(function()
	v35 = 11291 - (67 + 113);
	v36 = 8148 + 2963;
end, "PLAYER_REGEN_ENABLED");
v3:RegisterForEvent(function()
	v67 = 0 - 0;
	v68();
end, "PLAYER_EQUIPMENT_CHANGED");
local function v69(v114)
	return (v114 ~= "Not Used") and (((v114 == "With Cooldowns") and v13.CDsON()) or ((v114 == "With Small or Cooldowns") and (SmallCDToggle or v13.CDsON())) or ((v114 == "With Small CDs") and SmallCDToggle) or ((v114 == "On Mobcount") and (v55 >= v25.BeastMastery.Mobcount)) or ((v114 == "On Mobcount or Cooldowns") and ((v55 >= v25.BeastMastery.Mobcount) or v15())) or (v114 == "Always") or ((v114 == "On Bosses") and (v63 or v7:IsDummy())) or ((v114 == "Mobcount or Boss") and (v63 or (v55 >= v25.BeastMastery.Mobcount))) or ((v114 == "With Bloodlust only") and v6:BloodlustUp()));
end
local function v70(v115, v116, v117)
	if ((v63 and ((v25.TTD.IgnoreTTD and v6:IsInDungeonArea()) or v6:IsInRaidArea())) or v22.ISSolo() or (v117 == (0 + 0)) or ((v36 >= v117) and (v36 < (30909 - 23132)))) then
		v13.Cast(v115, v116);
		return "TTD cast " .. v115:Name();
	end
end
local function v71(v118)
	return (v63 and ((v25.TTD.IgnoreTTD and v6:IsInDungeonArea()) or v6:IsInRaidArea())) or v22.ISSolo() or (v118 == (952 - (802 + 150))) or v22.Buggedmobs[v7:NPCID()] or ((v36 >= v118) and (v36 < (20938 - 13161)));
end
local v72 = {{v26.Intimidation,"Cast Intimidation (Interrupt)",function()
	return true;
end}};
local function v73(v119)
	return (v119:HealthPercentage() > (0 + 0)) and (v119:HealthPercentage() <= (26 - 6)) and (v6:Focus() >= (1197 - (1069 + 118))) and v119:IsSpellInRange(v26.BlackArrow);
end
function GetTankUnit(v120)
	local v121 = nil;
	for v140, v141 in pairs(v120) do
		if (v141:Role() == "TANK") then
			v121 = v141;
			break;
		end
	end
	return v121;
end
local function v74()
	return v6:BuffUp(v26.HowlBearBuff) or v6:BuffUp(v26.HowlBoarBuff) or v6:BuffUp(v26.HowlWyvernBuff);
end
local function v75()
	return v28.ManicGrieftorch:IsEquipped() and (v28.ManicGrieftorch:CooldownUp() or (v28.ManicGrieftorch:CooldownRemains() <= v6:GCDRemains()));
end
local function v76()
	return v28.AlgetharPuzzleBox:IsEquipped() and (v28.AlgetharPuzzleBox:CooldownUp() or (v28.AlgetharPuzzleBox:CooldownRemains() <= v6:GCDRemains()));
end
local function v77(v122)
	return v6:BuffUp(v26.HuntersPreyBuff) or ((v6:Focus() >= (22 - 12)) and (v122:HealthPercentage() <= (43 - 23)) and (v122:HealthPercentage() > (0 + 0))) or (v26.BlackArrow:IsLearned() and (v122:HealthPercentage() >= (142 - 62))) or v7:IsDummy();
end
local function v78(v123)
	return v123:DebuffRefreshable(v26.SerpentStingDebuff);
end
local function v79(v124)
	return (v124:DebuffRemains(v26.BarbedShotDebuff));
end
local function v80(v125)
	return (v125:DebuffStack(v26.LatentPoisonDebuff));
end
local function v81(v126)
	return (v126:DebuffRemains(v26.SerpentStingDebuff));
end
local function v82(v127)
	return (v127:TimeToDie() > (5 + 0)) and (v127:TimeToDie() < (8568 - (368 + 423))) and ((v9:BuffUp(v26.FrenzyPetBuff) and (v9:BuffRemains(v26.FrenzyPetBuff) <= (v34 + (0.25 - 0)))) or ((v9:BuffStack(v26.FrenzyPetBuff) < (21 - (10 + 8))) and ((v26.BestialWrath:CooldownUp() and (v9:BuffDown(v26.FrenzyPetBuff) or v26.ScentofBlood:IsAvailable())) or (v26.CalloftheWild:IsAvailable() and v26.CalloftheWild:CooldownUp()))));
end
local function v83(v128)
	return (v128:TimeToDie() > (19 - 14)) and (v128:TimeToDie() < (8219 - (416 + 26))) and ((v9:BuffUp(v26.FrenzyPetBuff) and (v9:BuffRemains(v26.FrenzyPetBuff) <= (v34 + (0.25 - 0)))) or (v26.ScentofBlood:IsAvailable() and (v26.BestialWrath:CooldownRemains() < (6 + 6 + v34))) or ((v9:BuffStack(v26.FrenzyPetBuff) < (4 - 1)) and (v26.BestialWrath:CooldownUp() or v26.CalloftheWild:CooldownUp())) or ((v26.BarbedShot:FullRechargeTime() < v34) and v26.BestialWrath:CooldownDown()));
end
local function v84(v129)
	return (v129:TimeToDie() > (443 - (145 + 293))) and (v129:TimeToDie() < (8207 - (44 + 386))) and (v129:DebuffStack(v26.LatentPoisonDebuff) > (1495 - (998 + 488))) and (v6:BuffUp(v26.CalloftheWildBuff) or (v36 < (3 + 6)) or (v26.WildCall:IsAvailable() and (v26.BarbedShot:ChargesFractional() > (1.2 + 0))) or v26.Savagery:IsAvailable());
end
local function v85(v130)
	return (v130:TimeToDie() > (777 - (201 + 571))) and (v130:TimeToDie() < (8915 - (116 + 1022))) and (v130:TimeToDie() > (20 - 15)) and (v130:TimeToDie() < (4565 + 3212)) and (v6:BuffUp(v26.CalloftheWildBuff) or (v36 < (32 - 23)) or (v26.WildCall:IsAvailable() and (v26.BarbedShot:ChargesFractional() > (3.2 - 2))) or v26.Savagery:IsAvailable());
end
local function v86(v131)
	return (v18((v131:HealthPercentage() < (894 - (814 + 45))) or not v26.KillerInstinct:IsAvailable()) * (4 - 2)) + v18(v131:DebuffRefreshable(v26.AMurderofCrows));
end
local function v87(v132)
	return v132:DebuffRefreshable(v26.SerpentStingDebuff) and (v132:TimeToDie() > v26.SerpentStingDebuff:BaseDuration());
end
local function v88(v133)
	return (v9:BuffUp(v26.FrenzyPetBuff) and (v9:BuffRemains(v26.FrenzyPetBuff) <= (v34 + 0.25 + 0))) or (v26.ScentofBlood:IsAvailable() and (v9:BuffStack(v26.FrenzyPetBuff) < (2 + 1)) and (v26.BestialWrath:CooldownUp() or v26.CalloftheWild:CooldownUp()));
end
local function v89(v134)
	return (v26.WildCall:IsAvailable() and (v26.BarbedShot:ChargesFractional() > (886.4 - (261 + 624)))) or v6:BuffUp(v26.CalloftheWildBuff) or ((v26.BarbedShot:FullRechargeTime() < v34) and v26.BestialWrath:CooldownDown()) or (v26.ScentofBlood:IsAvailable() and (v26.BestialWrath:CooldownRemains() < ((21 - 9) + v34))) or v26.BarbedScales:IsAvailable() or v26.Savagery:IsAvailable() or (v36 < (1089 - (1020 + 60)));
end
local function v90(v135)
	return v135:DebuffRefreshable(v26.SerpentStingDebuff) and (v7:TimeToDie() > v26.SerpentStingDebuff:BaseDuration());
end
local function v91(v136)
	return (v136:DebuffRemains(v26.SerpentStingDebuff) < v6:GCD()) and (v136:TimeToDie() > (1433 - (630 + 793)));
end
local function v92(v137)
	return v137:DebuffRefreshable(v26.SerpentStingDebuff);
end
function CombatCheck()
	return v22.TargetIsValid() and (v7:AffectingCombat() or ((v25.Commons.AttackOutOfCombat == "Solo") and v22.ISSolo()) or (v25.Commons.AttackOutOfCombat == "Always"));
end
local function v93()
	if (v26.BestialWrath:IsCastable() and BestialWrathSetting and v7:IsInRange(135 - 95)) then
		if v16(v26.BestialWrath) then
			return "bestial_wrath precombat 4";
		end
	end
	if (v26.BarbedShot:IsCastable() and v7:IsInRange(189 - 149) and v7:IsSpellInRange(v26.BarbedShot) and (v26.BarbedShot:Charges() >= (1 + 1))) then
		if v16(v26.BarbedShot) then
			return "barbed_shot precombat 8";
		end
	end
	if (v65:IsReady() and v7:IsSpellInRange(v26.KillShot)) then
		if v22.CastCycle(v66, v53, v77, 137 - 97, false, false, false) then
			return "kill_shot precombat 10";
		end
	end
	if (v26.KillCommand:IsReady() and v7:IsSpellInRange(v26.KillCommand) and v64 and v58) then
		if v16(v26.KillCommand) then
			return "kill_command precombat 12";
		end
	end
	if (v55 > (1748 - (760 + 987))) then
		if (v26.MultiShot:IsReady() and v7:IsInRange(1953 - (1789 + 124)) and v7:IsSpellInRange(v26.MultiShot)) then
			if v16(v26.MultiShot) then
				return "multishot precombat 14";
			end
		end
	elseif (v26.CobraShot:IsReady() and v7:IsInRange(806 - (745 + 21)) and v7:IsSpellInRange(v26.CobraShot)) then
		if v16(v26.CobraShot) then
			return "cobra_shot precombat 16";
		end
	end
end
local function v94()
	if (v26.Berserking:IsCastable() and RacialsSetting and v71(v25.TTD.RacialsTTD) and (v6:BuffUp(v26.CalloftheWildBuff) or (v26.Bloodshed:IsAvailable() and v6:PrevGCD(1 + 0, v26.Bloodshed)) or (not v26.CalloftheWild:IsAvailable() and v6:BuffUp(v26.BestialWrathBuff)) or (v35 < (35 - 22))) and v7:IsInRange(156 - 116)) then
		if v16(v26.Berserking) then
			return "Berserking";
		end
	end
	if (v26.BloodFury:IsCastable() and RacialsSetting and v71(v25.TTD.RacialsTTD) and (v6:BuffUp(v26.CalloftheWildBuff) or (v26.Bloodshed:IsAvailable() and v6:PrevGCD(1 + 0, v26.Bloodshed)) or (not v26.CalloftheWild:IsAvailable() and v6:BuffUp(v26.BestialWrathBuff)) or (v35 < (13 + 3))) and v7:IsInRange(1095 - (87 + 968))) then
		if v16(v26.BloodFury) then
			return "BloodFury";
		end
	end
	if (v26.AncestralCall:IsCastable() and RacialsSetting and v71(v25.TTD.RacialsTTD) and (v6:BuffUp(v26.CalloftheWildBuff) or (v26.Bloodshed:IsAvailable() and v6:PrevGCD(4 - 3, v26.Bloodshed)) or (not v26.CalloftheWild:IsAvailable() and v6:BuffUp(v26.BestialWrathBuff)) or (v35 < (15 + 1))) and v7:IsInRange(90 - 50)) then
		if v16(v26.AncestralCall) then
			return "AncestralCall";
		end
	end
	if (v26.Fireblood:IsCastable() and RacialsSetting and v71(v25.TTD.RacialsTTD) and (v6:BuffUp(v26.CalloftheWildBuff) or (v26.Bloodshed:IsAvailable() and v6:PrevGCD(1414 - (447 + 966), v26.Bloodshed)) or (not v26.CalloftheWild:IsAvailable() and v6:BuffUp(v26.BestialWrathBuff)) or (v35 < (24 - 15))) and v7:IsInRange(1857 - (1703 + 114))) then
		if v16(v26.Fireblood) then
			return "Fireblood";
		end
	end
	if (v25.Commons.Enabled.Potions and PotionSetting and (v6:BuffUp(v26.CalloftheWildBuff) or (v26.Bloodshed:IsAvailable() and v6:PrevGCD(702 - (376 + 325), v26.Bloodshed)) or (not v26.CalloftheWild:IsAvailable() and v6:BuffUp(v26.BestialWrathBuff)) or (v35 < (50 - 19))) and v7:IsInRange(123 - 83)) then
		local v142 = v22.PotionSelected();
		if (v142 and v142:IsReady()) then
			v13.CastMacro(1 + 2, nil, nil, v142);
			return "Cast Potion";
		end
	end
end
local function v95()
	if (v26.BestialWrath:IsCastable() and BestialWrathSetting and v7:IsInRange(88 - 48)) then
		if v16(v26.BestialWrath) then
			return "bestial_wrath cleave 2";
		end
	end
	if (v26.DireBeast:IsCastable() and v7:IsInRange(54 - (9 + 5)) and v26.HuntmastersCall:IsAvailable() and (v6:BuffStack(v26.HuntmastersCallBuff) == (378 - (85 + 291)))) then
		if v16(v26.DireBeast) then
			return "dire_beast cleave 4";
		end
	end
	if (v26.BlackArrow:IsReady() and v7:IsInRange(1305 - (243 + 1022)) and v9:BuffUp(v26.BeastCleavePetBuff) and v6:BuffUp(v26.WitheringFireBuff)) then
		if v16(v66) then
			return "black_arrow cleave 6";
		end
	end
	if (v26.BarbedShot:IsCastable() and v7:IsInRange(152 - 112) and ((v26.BarbedShot:FullRechargeTime() < v6:GCD()) or (v26.BarbedShot:ChargesFractional() >= v26.KillCommand:ChargesFractional()) or (v26.CalloftheWild:IsAvailable() and v26.CalloftheWild:CooldownUp()) or (v74() and (v26.BarbedShot:FullRechargeTime() < (7 + 1))))) then
		if v22.CastTargetIf(v26.BarbedShot, v53, "min", v79, nil, 1220 - (1123 + 57), false, false, false, RecommendBarbedShot) then
			return "barbed_shot cleave 8";
		end
	end
	if (v26.MultiShot:IsReady() and v7:IsInRange(33 + 7) and v9:BuffDown(v26.BeastCleavePetBuff) and (not v26.BloodyFrenzy:IsAvailable() or v26.CalloftheWild:CooldownDown() or (v26.CalloftheWild:IsLearned() and not CallOfTheWildSetting))) then
		if v16(v26.MultiShot) then
			return "multishot cleave 10";
		end
	end
	if (v26.BlackArrow:IsReady() and v7:IsInRange(294 - (163 + 91)) and v9:BuffUp(v26.BeastCleavePetBuff)) then
		if v22.CastCycle(v66, v53, v77, 1970 - (1869 + 61), false, false, false) then
			return "black_arrow cleave 12";
		end
	end
	if (v26.CalloftheWild:IsCastable() and CallOfTheWildSetting) then
		if v16(v26.CalloftheWild) then
			return "call_of_the_wild cleave 14";
		end
	end
	if (v26.Bloodshed:IsCastable() and BloodshedSetting and v7:IsInRange(12 + 28)) then
		if v16(v26.Bloodshed) then
			return "bloodshed cleave 16";
		end
	end
	if v26.DireBeast:IsCastable() and 
	v7:IsInRange(140 - 100) and 
	(v26.ShadowHounds:IsAvailable() or v26.DireCleave:IsAvailable()) then
		if v16(v26.DireBeast) then
			return "dire_beast cleave 18";
		end
	end
	if (v26.ExplosiveShot:IsReady() and v26.ThunderingHooves:IsAvailable() and v7:IsInRange(61 - 21)) then
		if v16(v26.ExplosiveShot) then
			return "explosive_shot cleave 20";
		end
	end
	if (v26.KillCommand:IsReady() and v7:IsInRange(7 + 43)) then
		if v22.CastTargetIf(v26.KillCommand, v52, "max", v86, nil, (62 - 16) + 4 + 0, false, false, false, true) then
			return "kill_command cleave 22";
		end
	end
	if (v26.LightsJudgment:IsCastable() and v7:IsInRange(1479 - (1329 + 145)) and RacialsSetting and (v6:BuffDown(v26.BestialWrathBuff) or (v7:TimeToDie() < (976 - (140 + 831))))) then
		if v16(v26.LightsJudgment) then
			return "lights_judgment cleave 24";
		end
	end
	if (v26.CobraShot:IsReady() and v7:IsInRange(1890 - (1409 + 441)) and ((v6:FocusTimeToMax() < (v34 * (720 - (15 + 703)))) or (v6:BuffStack(v26.HogstriderBuff) > (2 + 1)))) then
		if v16(v26.CobraShot) then
			return "cobra_shot cleave 30";
		end
	end
	if (v26.DireBeast:IsCastable() and v7:IsInRange(478 - (262 + 176))) then
		if v16(v26.DireBeast) then
			return "dire_beast cleave 26";
		end
	end
	if (v26.ExplosiveShot:IsReady() and v7:IsInRange(1761 - (345 + 1376))) then
		if v16(v26.ExplosiveShot) then
			return "explosive_shot cleave 28";
		end
	end
	if (v26.BagofTricks:IsCastable() and RacialsSetting and v7:IsInRange(728 - (198 + 490)) and (v6:BuffDown(v26.BestialWrathBuff) or (v35 < (22 - 17)))) then
		if v16(v26.BagofTricks) then
			return "bag_of_tricks cleave 30";
		end
	end
	if (v26.ArcaneTorrent:IsCastable() and v7:IsInRange(18 - 10) and RacialsSetting and ((v6:Focus() + v6:FocusRegen() + (1236 - (696 + 510))) < v6:FocusMax())) then
		if v16(v26.ArcaneTorrentCast) then
			return "arcane_torrent cleave 32";
		end
	end
end
local function v96()
	if (v26.DireBeast:IsCastable() and v7:IsInRange(83 - 43) and (v26.HuntmastersCall:IsAvailable())) then
		if v16(v26.DireBeast) then
			return "dire_beast st 2";
		end
	end
	if (v26.BestialWrath:IsCastable() and BestialWrathSetting and v7:IsInRange(1302 - (1091 + 171))) then
		if v16(v26.BestialWrath) then
			return "bestial_wrath st 4 ";
		end
	end
	if (v26.BlackArrow:IsReady() and v7:IsInRange(7 + 33) and (v6:BuffUp(v26.WitheringFireBuff))) then
		if v16(v26.BlackArrow) then
			return "black_arrow st 6";
		end
	end
	if (v26.BarbedShot:IsCastable() and v7:IsInRange(125 - 85) and ((v26.BarbedShot:FullRechargeTime() < v6:GCD()) or (v26.BarbedShot:ChargesFractional() >= v26.KillCommand:ChargesFractional()) or (v26.CalloftheWild:IsAvailable() and v26.CalloftheWild:CooldownUp()) or (v74() and (v26.BarbedShot:FullRechargeTime() < (26 - 18))))) then
		if v22.CastTargetIf(v26.BarbedShot, v53, "min", v79, nil, 414 - (123 + 251), false, false, false, RecommendBarbedShot) then
			return "barbed_shot st 8";
		end
	end
	if (v26.KillCommand:IsReady() and v7:IsSpellInRange(v26.KillCommand) and (v26.KillCommand:ChargesFractional() >= v26.BarbedShot:ChargesFractional())) then
		if v16(v26.KillCommand) then
			return "kill_command st 10";
		end
	end
	if (v26.CalloftheWild:IsCastable() and v7:IsInRange(198 - 158) and CallOfTheWildSetting) then
		if v16(v26.CalloftheWild) then
			return "call_of_the_wild st 12";
		end
	end
	if (v26.Bloodshed:IsCastable() and BloodshedSetting and v7:IsInRange(738 - (208 + 490))) then
		if v16(v26.Bloodshed) then
			return "bloodshed st 14";
		end
	end
	if (v26.KillCommand:IsReady() and v7:IsSpellInRange(v26.KillCommand)) then
		if v16(v26.KillCommand) then
			return "kill_command st 16";
		end
	end
	if (v26.BlackArrow:IsReady() and v56) then
		if v22.CastCycle(v66, v53, v77, 4 + 36, false, false, false) then
			return "black_arrow st 18";
		end
	end
	if (v26.ExplosiveShot:IsReady() and v7:IsInRange(18 + 22)) then
		if v16(v26.ExplosiveShot) then
			return "explosive_shot st 20";
		end
	end
	if ((v26.LightsJudgment:IsCastable() and v7:IsInRange(841 - (660 + 176)) and RacialsSetting and v6:BuffDown(v26.BestialWrathBuff)) or (v7:TimeToDie() < (1 + 4))) then
		if v16(v26.LightsJudgment) then
			return "lights_judgment st 22";
		end
	end
	if (v26.CobraShot:IsReady() and v7:IsInRange(242 - (14 + 188))) then
		if v16(v26.CobraShot) then
			return "cobra_shot st 24";
		end
	end
	if (v26.DireBeast:IsCastable() and v7:IsInRange(715 - (534 + 141))) then
		if v16(v26.DireBeast) then
			return "dire_beast st 26";
		end
	end
	if (v26.BagofTricks:IsCastable() and RacialsSetting and v7:IsInRange(17 + 23) and (v6:BuffDown(v26.BestialWrathBuff) or (v35 < (5 + 0)))) then
		if v16(v26.BagofTricks) then
			return "bag_of_tricks st 28";
		end
	end
	if (v26.ArcanePulse:IsCastable() and RacialsSetting and v7:IsInRange(8 + 0) and (v6:BuffDown(v26.BestialWrathBuff) or (v35 < (10 - 5)))) then
		if v16(v26.ArcanePulse) then
			return "arcane_pulse st 30";
		end
	end
	if (v26.ArcaneTorrent:IsCastable() and RacialsSetting and ((v6:Focus() + v6:FocusRegen() + (23 - 8)) < v6:FocusMax())) then
		if v16(v26.ArcaneTorrentCast) then
			return "arcane_torrent st 32";
		end
	end
end
local function v97()
	v38 = (v26.CalloftheWild:IsAvailable() and v6:PrevGCD(2 - 1, v26.CalloftheWild)) or (v26.Bloodshed:IsAvailable() and v6:PrevGCD(1 + 0, v26.Bloodshed)) or (not v26.CalloftheWild:IsAvailable() and not v26.Bloodshed:IsAvailable() and (v6:BuffUp(v26.BestialWrathBuff) or (v26.BestialWrath:CooldownRemains() < (4 + 1))));
	v37 = (v26.CalloftheWild:IsAvailable() and v6:BuffUp(v26.CalloftheWildBuff)) or (v26.Bloodshed:IsAvailable() and v6:PrevGCD(397 - (115 + 281), v26.Bloodshed)) or (not v26.CalloftheWild:IsAvailable() and not v26.Bloodshed:IsAvailable() and v6:BuffUp(v26.BestialWrathBuff));
	v39 = (not v26.CalloftheWild:IsAvailable() and not v26.Bloodshed:IsAvailable() and v26.BestialWrath:CooldownRemains()) or v26.CalloftheWild:CooldownRemains() or v26.Bloodshed:CooldownRemains();
	if (((Trinket1Setting and (v31:ID() == v28.BeacontotheBeyond:ID())) or (Trinket2Setting and (v32:ID() == v28.BeacontotheBeyond:ID()))) and v71(v25.TTD.TrinketsTTD) and not v6:IsMoving() and v28.BeacontotheBeyond:IsEquippedAndReady()) then
		if v16(v28.BeacontotheBeyond) then
			return "BeacontotheBeyond cooldowns 8";
		end
	end
	if (v75() and v6:AffectingCombat() and (((v31:ID() == v28.ManicGrieftorch:ID()) and Trinket1Setting) or ((v32:ID() == v28.ManicGrieftorch:ID()) and Trinket2Setting)) and v7:IsInRange(93 - 53)) then
		if v16(v28.ManicGrieftorch) then
			return "manic_grieftorch";
		end
	end
	if (v28.SignetofthePriory:IsReady() and v6:AffectingCombat() and (v6:BuffUp(v26.CalloftheWildBuff) or not v26.CalloftheWild:IsAvailable()) and (((v31:ID() == v28.SignetofthePriory:ID()) and Trinket1Setting) or ((v32:ID() == v28.SignetofthePriory:ID()) and Trinket2Setting)) and v7:IsInRange(34 + 6)) then
		if v16(v28.SignetofthePriory) then
			return "SignetofthePriory";
		end
	end
	if (v31:IsReady() and v71(v25.TTD.TrinketsTTD) and Trinket1Setting and not v48 and ((v31:HasUseBuff() and ((v38 and (v50 or v32:CooldownDown())) or (not v38 and ((v50 and (((v39 > (v46 / (7 - 4))) and (v36 > (v46 + (73 - 53)))) or (v32:HasUseBuff() and (v32:CooldownRemains() > (v39 - (882 - (550 + 317)))) and ((v32:CooldownRemains() - (7 - 2)) < v39) and ((v39 + (63 - 18)) > v36)))) or (v51 and ((v32:CooldownDown() and ((((v32:CooldownRemains() - (13 - 8)) < v39) and (v39 >= (305 - (134 + 151)))) or (((v32:CooldownRemains() - (1670 - (970 + 695))) >= v39) and ((v39 > (v46 / (5 - 2))) or ((v46 < v36) and ((v39 + v46) > v36)))))) or (v32:CooldownUp() and (v39 > (2010 - (582 + 1408))) and (v39 < (v47 / (10 - 7)))))))))) or (not v31:HasUseBuff() and ((v40 == (0 - 0)) or not v37) and ((not v32:HasUseBuff() and (v50 or v32:CooldownDown())) or (v32:HasUseBuff() and ((not v37 and (v39 > (75 - 55))) or (v32:CooldownRemains() > (1844 - (1195 + 629))))))) or ((v36 < (32 - 7)) and (v50 or v32:CooldownDown())))) then
		if v16(v31) then
			return "use_item for " .. v31:Name() .. " trinkets 2";
		end
	end
	if (v32:IsReady() and v71(v25.TTD.TrinketsTTD) and Trinket2Setting and not v49 and ((v32:HasUseBuff() and ((v38 and (v51 or v31:CooldownDown())) or (not v38 and ((v51 and (((v39 > (v47 / (244 - (187 + 54)))) and (v36 > (v47 + (800 - (162 + 618))))) or (v31:HasUseBuff() and (v31:CooldownRemains() > (v39 - (11 + 4))) and ((v31:CooldownRemains() - (4 + 1)) < v39) and ((v39 + (95 - 50)) > v36)))) or (v50 and ((v31:CooldownDown() and ((((v31:CooldownRemains() - (8 - 3)) < v39) and (v39 >= (2 + 18))) or (((v31:CooldownRemains() - (1641 - (1373 + 263))) >= v39) and ((v39 > (v47 / (1003 - (451 + 549)))) or ((v47 < v36) and ((v39 + v47) > v36)))))) or (v31:CooldownUp() and (v39 > (7 + 13)) and (v39 < (v46 / (4 - 1)))))))))) or (not v32:HasUseBuff() and ((v41 == (0 - 0)) or not v37) and ((not v31:HasUseBuff() and (v51 or v31:CooldownDown())) or (v31:HasUseBuff() and ((not v37 and (v39 > (1404 - (746 + 638)))) or (v31:CooldownRemains() > (8 + 12)))))) or ((v36 < (37 - 12)) and (v51 or v31:CooldownDown())))) then
		if v16(v32) then
			return "use_item for " .. v32:Name() .. " trinkets 4";
		end
	end
	if (v28.MadQueensMandate:IsEquippedAndReady() and v7:IsInRange(381 - (218 + 123)) and (((v31:ID() == v28.MadQueensMandate:ID()) and Trinket1Setting and ((v32:CooldownRemains() > (1581 - (1535 + 46))) or not v32:HasUseBuff())) or ((v32:ID() == v28.MadQueensMandate:ID()) and Trinket2Setting and ((v31:CooldownRemains() > (0 + 0)) or not v31:HasUseBuff()))) and ((v35 > (18 + 102)) or (v35 < (570 - (306 + 254))) or (not v63 and (v36 < (1 + 4))))) then
		if v16(v28.MadQueensMandate) then
			return "mad_queens_mandate";
		end
	end
end
local function v98()
	local v138 = v22.HealthPotions();
	if v138 then
		return v138;
	end
	if v6:IsChanneling(v28.ManicGrieftorch.ItemUseSpell) then
		return "Dont cut Torch";
	end
	SmallCDToggle = v13.ToggleIconFrame:GetToggle(1 - 0);
	InterruptToggle = v13.ToggleIconFrame:GetToggle(1469 - (899 + 568));
	if v26.Stomp:IsAvailable() then
		v3.SplashEnemies.ChangeFriendTargetsTracking("Mine Only");
	else
		v3.SplashEnemies.ChangeFriendTargetsTracking("All");
	end
	v60 = (v12.FindBySpellID(v26.BloodBolt:ID()) and v26.BloodBolt) or (v12.FindBySpellID(v26.Bite:ID()) and v26.Bite) or (v12.FindBySpellID(v26.Claw:ID()) and v26.Claw) or (v12.FindBySpellID(v26.Smack:ID()) and v26.Smack) or nil;
	v61 = (v12.FindBySpellID(v26.Growl:ID()) and v26.Growl) or nil;
	v64 = (v61 and v64) or true;
	if v14() then
		v62 = v6:GetEnemiesInRange(6 + 2);
		v53 = v6:GetEnemiesInRange(96 - 56);
		v52 = v6:GetEnemiesInRange(653 - (268 + 335));
		v54 = (v60 and v6:GetEnemiesInSpellActionRange(v60)) or v7:GetEnemiesInSplashRange(298 - (60 + 230));
		v55 = (v60 and #v54) or v7:GetEnemiesInSplashRangeCount(580 - (426 + 146));
	else
		v62 = {};
		v53 = {};
		v52 = {};
		v54 = v7 or {};
		v55 = 0 + 0;
	end
	RacialsSetting = v69(v25.BeastMastery.RacialsSetting);
	Trinket1Setting = v69(v25.BeastMastery.Trinket1Setting);
	Trinket2Setting = v69(v25.BeastMastery.Trinket2Setting);
	PotionSetting = v69(v25.BeastMastery.PotionSetting) and not v22.ISSolo() and v71(1476 - (282 + 1174));
	BloodshedSetting = v69(v25.BeastMastery.BloodshedSetting) and v71(v25.TTD.BloodshedTTD);
	CallOfTheWildSetting = v69(v25.BeastMastery.CallOfTheWildSetting) and v71(v25.TTD.CallOfTheWildTTD);
	BestialWrathSetting = v69(v25.BeastMastery.BestialWrathSetting) and v71(v25.TTD.BestialWrathTTD);
	StampedeSetting = v69(v25.BeastMastery.StampedeSetting) and v71(831 - (569 + 242));
	BarrageSetting = v69(v25.BeastMastery.BarrageSetting) and v71(57 - 37);
	RecommendBarbedShot = v25.BeastMastery.RecommendBarbedShot;
	v65 = (v26.BlackArrow:IsLearned() and v26.BlackArrow) or v26.KillShot;
	v66 = (v26.BlackArrow:IsLearned() and v26.KillShotBM) or v26.KillShot;
	v56 = v7:IsInRange(3 + 37);
	v57 = v7:IsInRange(1054 - (706 + 318));
	v58 = (v61 and v7:IsSpellInActionRange(v61)) or v7:IsInRange(1281 - (721 + 530));
	v34 = v6:GCD() + (1271.15 - (945 + 326));
	if (v25.Commons.UseMisdirection and v22.TargetIsValid() and v26.Misdirection:IsCastable()) then
		MisdirectionUnitsInRange = v22.UnitsinRange(v26.Misdirection);
		MisdirectionRankUnit = GetTankUnit(MisdirectionUnitsInRange);
	end
	if (v22.TargetIsValid() or v6:AffectingCombat()) then
		v35 = v3.BossFightRemains();
		v63 = true;
		v36 = v35;
		if (v36 == (27758 - 16647)) then
			v63 = false;
			v36 = v3.FightRemains(v62, false);
		end
	end
	if (v26.FeignDeath:IsCastable() and v6:DebuffUp(v10(391799 + 48514))) then
		if v16(v26.FeignDeath, false) then
			return "Feign Death affix";
		end
	end
	if v6:AffectingCombat() then
		if (v26.Exhilaration:IsCastable() and (v6:HealthPercentage() <= v25.Defensives.ExhilarationHP)) then
			if v16(v26.Exhilaration, false) then
				return "Exhilaration";
			end
		end
		if (v26.SurvivalOfTheFittest:IsCastable() and v6:BuffDown(v26.SurvivalOfTheFittest) and (v6:HealthPercentage() <= v25.Defensives.SurvivalOfTheFittestHP)) then
			if v16(v26.SurvivalOfTheFittest, false) then
				return "Survival of the Fittest";
			end
		end
		if (v26.AspectOfTheTurtle:IsCastable() and (v6:HealthPercentage() <= v25.Defensives.AspectOfTheTurtleHP)) then
			if v16(v26.AspectOfTheTurtle, false) then
				return "Aspect of the Turtle";
			end
		end
		if ((v25.Defensives.FeignDeathOnSpell and v6:IncomingSpell(FeignDeathList)) or (v6:HealthPercentage() <= v25.Defensives.FeignDeathHP)) then
			if v26.FeignDeath:IsCastable() then
				if v16(v26.FeignDeath, false) then
					return "Feign Death";
				end
			end
			if v13.CastAnnotated(v26.PoolFocus, false, "Wait in Feign Death") then
				return "Wait in Feign Death";
			end
		end
		if (v26.FortitudeOfTheBear:IsCastable() and (v6:HealthPercentage() <= v25.Defensives.FortitudeOfTheBearHP)) then
			if v16(v26.FortitudeOfTheBear, false) then
				return "Fortitude of the Bear";
			end
		end
		if (v26.SpiritMend:IsCastable() and (v6:HealthPercentage() <= v25.Pet.SpiritMend)) then
			if v16(v26.SpiritMend, true) then
				return "Spirit Mend";
			end
		end
	end
	if (v6:DebuffUp(v26.FreezeTagFixation) and v26.FreezingTrap:IsCastable()) then
		if v16(v26.FreezingTrap) then
			return "Freezing Trap on Fixate";
		end
	end
	if not (v6:IsMounted() or v6:IsInVehicle()) then
		if (v26.RevivePet:IsCastable() and not v6:IsMoving()) then
			if v16(v26.RevivePet, false) then
				return "Revive Pet Status:" .. v23.Pet.Status;
			end
		end
		if (v26.SummonPet:IsCastable() and not IsFalling() and (v25.Pet.SummonPetSlot > (700 - (271 + 429))) and ((v25.Pet.WhenSummonPet == "Always") or ((v25.Pet.WhenSummonPet == "In combat") and v6:AffectingCombat()) or ((v25.Pet.WhenSummonPet == "Out of combat") and not v6:AffectingCombat()))) then
			if v16(v27[v25.Pet.SummonPetSlot], false) then
				return "Summon Pet Status:" .. v23.Pet.Status;
			end
		end
		if v26.MendPet:IsCastable() then
			if v16(v26.MendPet, false) then
				return "Mend Pet High Priority";
			end
		end
	end
	if (v26.HuntersMark:IsCastable() and v7:DebuffDown(v26.HuntersMark, true) and v22.TargetIsValid() and not (v25.Commons.HuntersMark == "Not Used") and (((v25.Commons.HuntersMark == "On Bosses") and (v63 or v7:IsBoss())) or (v25.Commons.HuntersMark == "Always")) and v7:IsInRange(56 + 4) and (v26.HuntersMark:TimeSinceLastCast() > (1505 - (1408 + 92))) and (v7:HealthPercentage() > (1166 - (461 + 625)))) then
		if v16(v26.HuntersMark) then
			return "Hunters Mark";
		end
	end
	if CombatCheck() then
		if not v6:AffectingCombat() then
			v138 = v93();
			if v138 then
				return v138;
			end
		end
		if (((v25.Commons.UseMisdirection == "Always") or ((v25.Commons.UseMisdirection == "On Combat Start") and (v3.CombatTime() < (1293 - (993 + 295)))) or ((v25.Commons.UseMisdirection == "Solo") and v22.ISSolo()) or ((v25.Commons.UseMisdirection == "On AoE") and v14() and ((v55 > (1 + 1)) or (v26.BeastCleave:IsAvailable() and (v55 > (1172 - (418 + 753))))))) and v22.TargetIsValid() and v26.Misdirection:IsCastable() and v5.Focus:Exists() and v5.Focus:UnitIsFriend() and not v5.Focus:IsDeadOrGhost() and v5.Focus:IsSpellInRange(v26.Misdirection) and v6:BuffDown(v26.Misdirection) and ((v5.Focus:Role() == "TANK") or (UnitIsUnit("focus", "pet") and v22.ISSolo()))) then
			v13.CastTarget(v26.Misdirection, v13.TName().FOCUS);
			return "Misdirection";
		end
		if InterruptToggle then
			if v25.Commons.ImplosiveTrap then
				v138 = v22.InterruptCycle(v26.ImplosiveTrap, 2 + 3, false, nil, true, true);
				if v138 then
					if v13.CastTarget(v26.ImplosiveTrap, v13.TName().PLAYER) then
						return "HighExplosiveTrap Player";
					end
				end
			end
			if v25.Commons.HighExplosiveTrap then
				v138 = v22.InterruptCycle(v26.HighExplosiveTrap, 1 + 4, false, nil, true, true);
				if v138 then
					if v26.BindingShot:IsCastable() then
						if v13.CastTarget(v26.BindingShot, v13.TName().PLAYER) then
							return "Binding Shot Player";
						end
						if v13.CastTarget(v26.HighExplosiveTrap, v13.TName().PLAYER) then
							return "HighExplosiveTrap Player";
						end
					end
				end
			end
			if v25.Commons.BurstingShot then
				v138 = v22.InterruptCycle(v26.BurstingShot, 2 + 3, false, nil, true, true);
				if v138 then
					return v138;
				end
			end
			v138 = v22.InterruptCycle(v26.ScatterShot, 11 + 29, false, nil, true);
			if v138 then
				return v138;
			end
			v138 = v22.InterruptCycle(v26.CounterShot, 569 - (406 + 123), true, nil, false);
			if v138 then
				return v138;
			end
			v138 = v22.InterruptCycle(v26.Intimidation, 1809 - (1749 + 20), false, nil, true);
			if v138 then
				return v138;
			end
		end
		v138 = v22.PurgeCycle(v26.TranquilizingShot, 10 + 30, false, v25.Commons.TabForTranquilizingShot);
		if v138 then
			return v138;
		end
		v138 = v22.SootheCycle(v26.TranquilizingShot, 1362 - (1249 + 73), false, v25.Commons.TabForTranquilizingShot);
		if v138 then
			return v138;
		end
		v138 = v94();
		if v138 then
			return v138;
		end
		if v25.Commons.Enabled.Trinkets then
			v138 = v97();
			if v138 then
				return v138;
			end
		end
		if ((v55 < (1 + 1)) or (not v26.BeastCleave:IsAvailable() and (v55 < (1148 - (466 + 679))))) then
			v138 = v96();
			if v138 then
				return v138;
			end
		end
		if ((v55 > (4 - 2)) or (v26.BeastCleave:IsAvailable() and (v55 > (2 - 1)))) then
			v138 = v95();
			if v138 then
				return v138;
			end
		end
	end
	if (not (v6:IsMounted() or v6:IsInVehicle()) and v26.MendPet:IsCastable()) then
		if v16(v26.MendPet) then
			return "Mend Pet Low Priority (w/ Target)";
		end
	end
	if (not (v6:IsMounted() or v6:IsInVehicle()) and v26.MendPet:IsCastable()) then
		if v16(v26.MendPet) then
			return "Mend Pet Low Priority (w/o Target)";
		end
	end
end
local function v99()
	v25.BeastMastery.Display();
	if v60 then
		v13.Print("Pet ability found");
	else
		v13.Print("Please add a Pet ability to your action bar");
	end
	v13.Print("Beast Mastery can use pet abilities to better determine AoE. Make sure you have Growl and Blood Bolt / Bite / Claw / Smack on your player action bars.");
	v22.PostInitialMessage(2153 - (106 + 1794));
end
v13.SetAPL(81 + 172, v98, v99);