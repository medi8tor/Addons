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
local v21 = v13.Commons().Everyone;
local v22 = v13.Commons().Hunter;
local v23 = v13.GUISettingsGet();
local v24 = {General=v23.General,Commons=v23.APL.Hunter.Commons,Pet=v23.APL.Hunter.BMPet,Defensives=v23.APL.Hunter.Defensives,BeastMastery=v23.APL.Hunter.BeastMastery,TTD=v23.APL.Hunter.BeastMastery_TTD};
local v25 = v10.Hunter.BeastMastery;
local v26 = {v25.SummonPet,v25.SummonPet2,v25.SummonPet3,v25.SummonPet4,v25.SummonPet5};
local v27 = v11.Hunter.BeastMastery;
local v28 = {v27.BeacontotheBeyond:ID(),v27.ManicGrieftorch:ID()};
local v29 = v6:GetEquipment();
local v30 = (v29[940 - (214 + 713)] and v11(v29[4 + 9])) or v11(0 + 0);
local v31 = (v29[891 - (282 + 595)] and v11(v29[1651 - (1523 + 114)])) or v11(0 + 0);
local v32;
local v33;
local v34 = 15839 - 4728;
local v35 = 12176 - (68 + 997);
local v36 = false;
local v37 = false;
local v38 = 1270 - (226 + 1044);
local v30, v31;
local v39, v40;
local v41, v42;
local v43, v44;
local v45, v46;
local v47, v48;
local v49, v50;
local v51, v52, v53;
local v54, v55;
local v56;
local v57;
local v58, v59;
local v60;
local v61;
local v62;
local v63 = 0 - 0;
local function v64()
	local v94, v95 = v6:GetTrinketData(v28);
	if ((v63 < (122 - (32 + 85))) and ((v94.ID == (0 + 0)) or (v95.ID == (0 + 0)) or ((v94.SpellID > (957 - (892 + 65))) and not v94.Usable) or ((v95.SpellID > (0 - 0)) and not v95.Usable))) then
		v63 = v63 + (1 - 0);
		v20(8 - 3, function()
			v64();
		end);
		return;
	end
	v30 = v94.Object;
	v31 = v95.Object;
	v41 = v94.Spell;
	v43 = v94.Range;
	v39 = v94.CastTime;
	v42 = v95.Spell;
	v44 = v95.Range;
	v40 = v95.CastTime;
	v45 = v94.Cooldown;
	v46 = v95.Cooldown;
	v47 = v94.Blacklisted;
	v48 = v95.Blacklisted;
	v49 = (v45 == (350 - (87 + 263))) or (v30:HasUseBuff() and (not v31:HasUseBuff() or ((not v94.ID == v27.MirrorofFracturedTomorrows:ID()) and ((v95.ID == v27.MirrorofFracturedTomorrows:ID()) or (v46 < v45) or (v40 < v39) or ((v40 == v39) and (v46 == v45)))))) or (not v30:HasUseBuff() and not v31:HasUseBuff() and ((v46 < v45) or (v40 < v39) or ((v40 == v39) and (v46 == v45))));
	v50 = not v49;
end
v64();
v3:RegisterForEvent(function()
	v34 = 11291 - (67 + 113);
	v35 = 8148 + 2963;
end, "PLAYER_REGEN_ENABLED");
v3:RegisterForEvent(function()
	v63 = 0 - 0;
	v64();
end, "PLAYER_EQUIPMENT_CHANGED");
local function v65(v108)
	return (v108 ~= "Not Used") and (((v108 == "With Cooldowns") and v13.CDsON()) or ((v108 == "With Small or Cooldowns") and (SmallCDToggle or v13.CDsON())) or ((v108 == "With Small CDs") and SmallCDToggle) or ((v108 == "On Mobcount") and (v53 >= v24.BeastMastery.Mobcount)) or ((v108 == "On Mobcount or Cooldowns") and ((v53 >= v24.BeastMastery.Mobcount) or v15())) or (v108 == "Always") or ((v108 == "On Bosses") and (v61 or v7:IsDummy())) or ((v108 == "Mobcount or Boss") and (v61 or (v53 >= v24.BeastMastery.Mobcount))) or ((v108 == "With Bloodlust only") and v6:BloodlustUp()));
end
local function v66(v109, v110, v111)
	if ((v61 and ((v24.TTD.IgnoreTTD and v6:IsInDungeonArea()) or v6:IsInRaidArea())) or v21.ISSolo() or (v111 == (0 + 0)) or ((v35 >= v111) and (v35 < (30909 - 23132)))) then
		v13.Cast(v109, v110);
		return "TTD cast " .. v109:Name();
	end
end
local function v67(v112)
	return (v61 and ((v24.TTD.IgnoreTTD and v6:IsInDungeonArea()) or v6:IsInRaidArea())) or v21.ISSolo() or (v112 == (952 - (802 + 150))) or v21.Buggedmobs[v7:NPCID()] or ((v35 >= v112) and (v35 < (20938 - 13161)));
end
local v68 = {{v25.Intimidation,"Cast Intimidation (Interrupt)",function()
	return true;
end}};
local function v69(v113)
	return (v113:HealthPercentage() > (0 + 0)) and (v113:HealthPercentage() <= (26 - 6)) and (v6:Focus() >= (1197 - (1069 + 118))) and v8:IsSpellInRange(v25.KillShot);
end
function GetTankUnit(v114)
	local v115 = nil;
	for v131, v132 in pairs(v114) do
		if (v132:Role() == "TANK") then
			v115 = v132;
			break;
		end
	end
	return v115;
end
local function v70()
	return v27.ManicGrieftorch:IsEquipped() and (v27.ManicGrieftorch:CooldownUp() or (v27.ManicGrieftorch:CooldownRemains() <= v6:GCDRemains()));
end
local function v71()
	return v27.AlgetharPuzzleBox:IsEquipped() and (v27.AlgetharPuzzleBox:CooldownUp() or (v27.AlgetharPuzzleBox:CooldownRemains() <= v6:GCDRemains()));
end
local function v72(v116)
	return v6:BuffUp(v25.HuntersPreyBuff) or ((v6:Focus() >= (22 - 12)) and (v116:HealthPercentage() <= (43 - 23)) and (v116:HealthPercentage() > (0 + 0)));
end
local function v73(v117)
	return (v117:DebuffRemains(v25.BarbedShotDebuff));
end
local function v74(v118)
	return (v118:DebuffStack(v25.LatentPoisonDebuff));
end
local function v75(v119)
	return (v119:DebuffRemains(v25.SerpentStingDebuff));
end
local function v76(v120)
	return (v120:TimeToDie() > (8 - 3)) and (v120:TimeToDie() < (7715 + 62)) and ((v9:BuffUp(v25.FrenzyPetBuff) and (v9:BuffRemains(v25.FrenzyPetBuff) <= (v33 + (791.25 - (368 + 423))))) or ((v9:BuffStack(v25.FrenzyPetBuff) < (9 - 6)) and ((v25.BestialWrath:CooldownUp() and (v9:BuffDown(v25.FrenzyPetBuff) or v25.ScentofBlood:IsAvailable())) or (v25.CalloftheWild:IsAvailable() and v25.CalloftheWild:CooldownUp()))));
end
local function v77(v121)
	return (v121:TimeToDie() > (23 - (10 + 8))) and (v121:TimeToDie() < (29916 - 22139)) and ((v9:BuffUp(v25.FrenzyPetBuff) and (v9:BuffRemains(v25.FrenzyPetBuff) <= (v33 + (442.25 - (416 + 26))))) or (v25.ScentofBlood:IsAvailable() and (v25.BestialWrath:CooldownRemains() < ((38 - 26) + v33))) or ((v9:BuffStack(v25.FrenzyPetBuff) < (2 + 1)) and (v25.BestialWrath:CooldownUp() or v25.CalloftheWild:CooldownUp())) or ((v25.BarbedShot:FullRechargeTime() < v33) and v25.BestialWrath:CooldownDown()));
end
local function v78(v122)
	return (v122:TimeToDie() > (8 - 3)) and (v122:TimeToDie() < (8215 - (145 + 293))) and (v122:DebuffStack(v25.LatentPoisonDebuff) > (439 - (44 + 386))) and (v6:BuffUp(v25.CalloftheWildBuff) or (v35 < (1495 - (998 + 488))) or (v25.WildCall:IsAvailable() and (v25.BarbedShot:ChargesFractional() > (1.2 + 0))) or v25.Savagery:IsAvailable());
end
local function v79(v123)
	return (v123:TimeToDie() > (5 + 0)) and (v123:TimeToDie() < (8549 - (201 + 571))) and (v123:TimeToDie() > (1143 - (116 + 1022))) and (v123:TimeToDie() < (32377 - 24600)) and (v6:BuffUp(v25.CalloftheWildBuff) or (v35 < (6 + 3)) or (v25.WildCall:IsAvailable() and (v25.BarbedShot:ChargesFractional() > (3.2 - 2))) or v25.Savagery:IsAvailable());
end
local function v80(v124)
	return v124:DebuffRefreshable(v25.SerpentStingDebuff) and (v124:TimeToDie() > v25.SerpentStingDebuff:BaseDuration());
end
local function v81(v125)
	return (v9:BuffUp(v25.FrenzyPetBuff) and (v9:BuffRemains(v25.FrenzyPetBuff) <= (v33 + (0.25 - 0)))) or (v25.ScentofBlood:IsAvailable() and (v9:BuffStack(v25.FrenzyPetBuff) < (862 - (814 + 45))) and (v25.BestialWrath:CooldownUp() or v25.CalloftheWild:CooldownUp()));
end
local function v82(v126)
	return (v25.WildCall:IsAvailable() and (v25.BarbedShot:ChargesFractional() > (2.4 - 1))) or v6:BuffUp(v25.CalloftheWildBuff) or ((v25.BarbedShot:FullRechargeTime() < v33) and v25.BestialWrath:CooldownDown()) or (v25.ScentofBlood:IsAvailable() and (v25.BestialWrath:CooldownRemains() < (1 + 11 + v33))) or v25.Savagery:IsAvailable() or (v35 < (4 + 5));
end
local function v83(v127)
	return v127:DebuffRefreshable(v25.SerpentStingDebuff) and (v7:TimeToDie() > v25.SerpentStingDebuff:BaseDuration());
end
local function v84(v128)
	return (v128:DebuffRemains(v25.SerpentStingDebuff) < v6:GCD()) and (v128:TimeToDie() > (895 - (261 + 624)));
end
local function v85(v129)
	return v129:DebuffRefreshable(v25.SerpentStingDebuff);
end
function CombatCheck()
	return v21.TargetIsValid() and (v7:AffectingCombat() or ((v24.Commons.AttackOutOfCombat == "Solo") and v21.ISSolo()) or (v24.Commons.AttackOutOfCombat == "Always"));
end
local function v86()
	return v6:BuffUp(v25.HowlBearBuff) or v6:BuffUp(v25.HowlBoarBuff) or v6:BuffUp(v25.HowlWyvernBuff);
end
local function v87()
	if (v25.BarbedShot:IsCastable() and v7:IsInRange(71 - 31) and v7:IsSpellInRange(v25.BarbedShot) and (v25.BarbedShot:Charges() >= (1082 - (1020 + 60)))) then
		if v16(v25.BarbedShot) then
			return "barbed_shot precombat 8";
		end
	end
	if (v25.KillShot:IsCastable() and v7:IsSpellInRange(v25.KillShot)) then
		if v21.CastCycle(v25.KillShot, v51, v72, 1463 - (630 + 793), false, false, KillShotTab) then
			return "kill_shot precombat 10";
		end
	end
	if (v25.KillCommand:IsReady() and v7:IsSpellInRange(v25.KillCommand) and v7:IsSpellInRange(v25.KillCommand) and v62 and v56) then
		if v16(v25.KillCommand) then
			return "kill_command precombat 12";
		end
	end
	if (v53 > (3 - 2)) then
		if (v25.MultiShot:IsReady() and v7:IsInRange(189 - 149) and v7:IsSpellInRange(v25.MultiShot)) then
			if v16(v25.MultiShot) then
				return "multishot precombat 14";
			end
		end
	elseif (v25.CobraShot:IsReady() and v7:IsInRange(16 + 24) and v7:IsSpellInRange(v25.CobraShot)) then
		if v16(v25.CobraShot) then
			return "cobra_shot precombat 16";
		end
	end
end
local function v88()
	if (v25.Berserking:IsCastable() and RacialsSetting and v67(v24.TTD.RacialsTTD) and (v6:BuffUp(v25.CalloftheWildBuff) or (not v25.CalloftheWild:IsAvailable() and v6:BuffUp(v25.BestialWrathBuff)) or (v34 < (44 - 31))) and v7:IsInRange(1787 - (760 + 987))) then
		if v16(v25.Berserking) then
			return "Berserking";
		end
	end
	if (v25.BloodFury:IsCastable() and RacialsSetting and v67(v24.TTD.RacialsTTD) and (v6:BuffUp(v25.CalloftheWildBuff) or (not v25.CalloftheWild:IsAvailable() and v6:BuffUp(v25.BestialWrathBuff)) or (v34 < (1929 - (1789 + 124)))) and v7:IsInRange(806 - (745 + 21))) then
		if v16(v25.BloodFury) then
			return "BloodFury";
		end
	end
	if (v25.AncestralCall:IsCastable() and RacialsSetting and v67(v24.TTD.RacialsTTD) and (v6:BuffUp(v25.CalloftheWildBuff) or (not v25.CalloftheWild:IsAvailable() and v6:BuffUp(v25.BestialWrathBuff)) or (v34 < (6 + 10))) and v7:IsInRange(110 - 70)) then
		if v16(v25.AncestralCall) then
			return "AncestralCall";
		end
	end
	if (v25.Fireblood:IsCastable() and RacialsSetting and v67(v24.TTD.RacialsTTD) and (v6:BuffUp(v25.CalloftheWildBuff) or (not v25.CalloftheWild:IsAvailable() and v6:BuffUp(v25.BestialWrathBuff)) or (v34 < (35 - 26))) and v7:IsInRange(1 + 39)) then
		if v16(v25.Fireblood) then
			return "Fireblood";
		end
	end
	if (v24.Commons.Enabled.Potions and PotionSetting and (v6:BuffUp(v25.CalloftheWildBuff) or (not v25.CalloftheWild:IsAvailable() and v6:BuffUp(v25.BestialWrathBuff)) or (v34 < (25 + 6))) and v7:IsInRange(1095 - (87 + 968))) then
		local v133 = v21.PotionSelected();
		if (v133 and v133:IsReady()) then
			v13.CastMacro(13 - 10, nil, nil, v133);
			return "Cast Potion";
		end
	end
end
local function v89()
	if (v25.BestialWrath:IsCastable() and BestialWrathSetting and v7:IsInRange(37 + 3)) then
		if v16(v25.BestialWrath) then
			return "bestial_wrath cleave 2";
		end
	end
	if (v25.BarbedShot:IsCastable() and v7:IsInRange(90 - 50) and ((v25.BarbedShot:FullRechargeTime() < v6:GCD()) or (v25.BarbedShot:ChargesFractional() >= v25.KillCommand:ChargesFractional()) or (v25.CalloftheWild:IsAvailable() and v25.CalloftheWild:CooldownUp()) or (v86() and (v25.BarbedShot:FullRechargeTime() < (1421 - (447 + 966)))))) then
		if v21.CastTargetIf(v25.BarbedShot, v51, "min", v73, v76, 109 - 69, false, false, MultidotBarbedShot, RecommendBarbedShot) then
			return "barbed_shot cleave 2";
		end
	end
	if (v25.MultiShot:IsReady() and v7:IsInRange(1857 - (1703 + 114)) and (v9:BuffRemains(v25.BeastCleavePetBuff) < ((701.25 - (376 + 325)) + v33)) and (not v25.BloodyFrenzy:IsAvailable() or v25.CalloftheWild:CooldownDown() or (v25.CalloftheWild:IsLearned() and not CallOfTheWildSetting))) then
		if v16(v25.MultiShot) then
			return "multishot cleave 6";
		end
	end
	if (v25.BlackArrow:IsReady() and v7:IsSpellInRange(v25.BlackArrow) and (v9:BuffUp(v25.BeastCleavePetBuff))) then
		if v16(v25.BlackArrow) then
			return "black_arrow cleave 8";
		end
	end
	if (v25.CalloftheWild:IsCastable() and CallOfTheWildSetting) then
		if v16(v25.CalloftheWild) then
			return "call_of_the_wild cleave 10";
		end
	end
	if (v25.Bloodshed:IsCastable() and BloodshedSetting and v7:IsInRange(65 - 25)) then
		if v16(v25.Bloodshed) then
			return "bloodshed cleave 14";
		end
	end
	if (v25.DireBeast:IsCastable() and v7:IsInRange(123 - 83) and (v25.ShadowHounds:IsAvailable() or v25.DireCleave:IsAvailable())) then
		if v16(v25.DireBeast) then
			return "dire_beast cleave 8";
		end
	end
	if (v25.ExplosiveShot:IsReady() and (v25.ThunderingHooves:IsAvailable()) and (v7:TimeToDie() > (1 + 2)) and v7:IsInRange(88 - 48)) then
		if v16(v25.ExplosiveShot) then
			return "explosive_shot cleave 24";
		end
	end
	if (v25.KillCommand:IsReady() and v7:IsInRange(64 - (9 + 5))) then
		if v16(v25.KillCommand) then
			return "kill_command cleave 16";
		end
	end
	if (v25.LightsJudgment:IsCastable() and v7:IsInRange(381 - (85 + 291)) and RacialsSetting and (v6:BuffDown(v25.BestialWrathBuff) or (v7:TimeToDie() < (1270 - (243 + 1022))))) then
		if v16(v25.LightsJudgment) then
			return "lights_judgment cleave 26";
		end
	end
	if (v25.CobraShot:IsReady() and v7:IsInRange(152 - 112) and v6:BuffUp(v25.BestialWrathBuff) and v25.KillerCobra:IsAvailable()) then
		if v16(v25.CobraShot) then
			return "cobra_shot cleave 20";
		end
	end
	if (v25.DireBeast:IsCastable() and v7:IsInRange(33 + 7)) then
		if v16(v25.DireBeast) then
			return "dire_beast cleave 8";
		end
	end
	if (v25.ExplosiveShot:IsReady() and v7:IsSpellInRange(v25.ExplosiveShot)) then
		if v16(v25.ExplosiveShot) then
			return "explosive_shot cleave 26";
		end
	end
	if (v25.BagofTricks:IsCastable() and RacialsSetting and v7:IsInRange(1220 - (1123 + 57)) and (v6:BuffDown(v25.BestialWrathBuff) or (v34 < (5 + 0)))) then
		if v16(v25.BagofTricks) then
			return "bag_of_tricks cleave 32";
		end
	end
	if (v25.ArcaneTorrent:IsCastable() and v7:IsInRange(262 - (163 + 91)) and RacialsSetting and ((v6:Focus() + v6:FocusRegen() + (1960 - (1869 + 61))) < v6:FocusMax())) then
		if v16(v25.ArcaneTorrentCast) then
			return "arcane_torrent cleave 34";
		end
	end
end
local function v90()
	if (v25.DireBeast:IsCastable() and v7:IsInRange(12 + 28) and (v25.HuntmastersCall:IsAvailable())) then
		if v16(v25.DireBeast) then
			return "dire_beast st 1";
		end
	end
	if (v15() and v25.BestialWrath:IsCastable() and BestialWrathSetting) then
		if v16(v25.BestialWrath) then
			return "bestial_wrath st 4";
		end
	end
	if (v25.BarbedShot:IsCastable() and v7:IsInRange(140 - 100) and ((v25.BarbedShot:FullRechargeTime() < v6:GCD()) or (v25.BarbedShot:ChargesFractional() >= v25.KillCommand:ChargesFractional()) or (v25.CalloftheWild:IsAvailable() and v25.CalloftheWild:CooldownUp()) or (v86() and (v25.BarbedShot:FullRechargeTime() < (12 - 4))))) then
		if v21.CastTargetIf(v25.BarbedShot, v51, "min", v73, nil, 6 + 34, false, false, MultidotBarbedShot, RecommendBarbedShot) then
			return "barbed_shot st 2";
		end
	end
	if (v25.BarbedShot:IsCastable() and v7:IsInRange(54 - 14) and ((v25.BarbedShot:FullRechargeTime() < v6:GCD()) or (v25.BarbedShot:ChargesFractional() >= v25.KillCommand:ChargesFractional()) or (v25.CalloftheWild:IsAvailable() and v25.CalloftheWild:CooldownUp()) or (v86() and (v25.BarbedShot:FullRechargeTime() < (8 + 0))))) then
		if v16(v25.BarbedShot) then
			return "barbed_shot st mt_backup 4";
		end
	end
	if (v25.KillCommand:IsReady() and v7:IsSpellInRange(v25.KillCommand) and (v25.KillCommand:ChargesFractional() >= v25.BarbedShot:ChargesFractional())) then
		if v16(v25.KillCommand) then
			return "kill_command st 8";
		end
	end
	if (v25.CalloftheWild:IsCastable() and v7:IsInRange(1514 - (1329 + 145)) and CallOfTheWildSetting) then
		if v16(v25.CalloftheWild) then
			return "call_of_the_wild st 14";
		end
	end
	if (v25.Bloodshed:IsCastable() and BloodshedSetting and v7:IsInRange(1011 - (140 + 831))) then
		if v16(v25.Bloodshed) then
			return "bloodshed st 16";
		end
	end
	if (v25.BlackArrow:IsReady() and v7:IsSpellInRange(v25.BlackArrow)) then
		if v16(v25.BlackArrow) then
			return "black_arrow st 16";
		end
	end
	if (v25.ExplosiveShot:IsReady() and (v7:TimeToDie() > (1853 - (1409 + 441))) and v7:IsInRange(758 - (15 + 703)) and (v25.ThunderingHooves:IsAvailable())) then
		if v16(v25.ExplosiveShot) then
			return "explosive_shot st 32";
		end
	end
	if (RacialsSetting and v25.LightsJudgment:IsCastable() and (v6:BuffDown(v25.BestialWrathBuff) or (v7:TimeToDie() < (3 + 2))) and v7:IsInRange(443 - (262 + 176))) then
		if v16(v25.LightsJudgment) then
			return "lights_judgment st 20";
		end
	end
	if (v25.CobraShot:IsReady() and v7:IsInRange(1761 - (345 + 1376))) then
		if v16(v25.CobraShot) then
			return "cobra_shot st 28";
		end
	end
	if (v25.DireBeast:IsCastable() and v7:IsSpellInRange(v25.DireBeast)) then
		if v16(v25.DireBeast) then
			return "dire_beast st 24";
		end
	end
	if (v25.BagofTricks:IsCastable() and RacialsSetting and v7:IsInRange(728 - (198 + 490)) and (v6:BuffDown(v25.BestialWrathBuff) or (v34 < (22 - 17)))) then
		if v16(v25.BagofTricks) then
			return "bag_of_tricks st 40";
		end
	end
	if (v25.ArcanePulse:IsCastable() and RacialsSetting and v7:IsInRange(18 - 10) and (v6:BuffDown(v25.BestialWrathBuff) or (v34 < (1211 - (696 + 510))))) then
		if v16(v25.ArcanePulse) then
			return "arcane_pulse st 42";
		end
	end
	if (v25.ArcaneTorrent:IsCastable() and RacialsSetting and ((v6:Focus() + v6:FocusRegen() + (31 - 16)) < v6:FocusMax())) then
		if v16(v25.ArcaneTorrentCast) then
			return "arcane_torrent st 44";
		end
	end
end
local function v91()
	v37 = (v25.CalloftheWild:IsAvailable() and v6:PrevGCD(1263 - (1091 + 171), v25.CalloftheWild)) or (v25.Bloodshed:IsAvailable() and v6:PrevGCD(1 + 0, v25.Bloodshed)) or (not v25.CalloftheWild:IsAvailable() and not v25.Bloodshed:IsAvailable() and (v6:BuffUp(v25.BestialWrathBuff) or (v25.BestialWrath:CooldownRemains() < (15 - 10))));
	v36 = (v25.CalloftheWild:IsAvailable() and v6:BuffUp(v25.CalloftheWildBuff)) or (v25.Bloodshed:IsAvailable() and v6:PrevGCD(3 - 2, v25.Bloodshed)) or (not v25.CalloftheWild:IsAvailable() and not v25.Bloodshed:IsAvailable() and v6:BuffUp(v25.BestialWrathBuff));
	v38 = (not v25.CalloftheWild:IsAvailable() and not v25.Bloodshed:IsAvailable() and v25.BestialWrath:CooldownRemains()) or v25.CalloftheWild:CooldownRemains() or v25.Bloodshed:CooldownRemains();
	if (((Trinket1Setting and (v30:ID() == v27.BeacontotheBeyond:ID())) or (Trinket2Setting and (v31:ID() == v27.BeacontotheBeyond:ID()))) and v67(v24.TTD.TrinketsTTD) and not v6:IsMoving() and v27.BeacontotheBeyond:IsEquippedAndReady()) then
		if v16(v27.BeacontotheBeyond) then
			return "BeacontotheBeyond cooldowns 8";
		end
	end
	if (v70() and v6:AffectingCombat() and (((v30:ID() == v27.ManicGrieftorch:ID()) and Trinket1Setting) or ((v31:ID() == v27.ManicGrieftorch:ID()) and Trinket2Setting)) and v7:IsInRange(414 - (123 + 251))) then
		if v16(v27.ManicGrieftorch) then
			return "manic_grieftorch";
		end
	end
	if (v30:IsReady() and v67(v24.TTD.TrinketsTTD) and Trinket1Setting and not v47 and ((v30:HasUseBuff() and ((v37 and (v49 or v31:CooldownDown())) or (not v37 and ((v49 and (((v38 > (v45 / (14 - 11))) and (v35 > (v45 + (718 - (208 + 490))))) or (v31:HasUseBuff() and (v31:CooldownRemains() > (v38 - (2 + 13))) and ((v31:CooldownRemains() - (3 + 2)) < v38) and ((v38 + (881 - (660 + 176))) > v35)))) or (v50 and ((v31:CooldownDown() and ((((v31:CooldownRemains() - (1 + 4)) < v38) and (v38 >= (222 - (14 + 188)))) or (((v31:CooldownRemains() - (680 - (534 + 141))) >= v38) and ((v38 > (v45 / (2 + 1))) or ((v45 < v35) and ((v38 + v45) > v35)))))) or (v31:CooldownUp() and (v38 > (18 + 2)) and (v38 < (v46 / (3 + 0)))))))))) or (not v30:HasUseBuff() and ((v39 == (0 - 0)) or not v36) and ((not v31:HasUseBuff() and (v49 or v31:CooldownDown())) or (v31:HasUseBuff() and ((not v36 and (v38 > (31 - 11))) or (v31:CooldownRemains() > (56 - 36)))))) or ((v35 < (14 + 11)) and (v49 or v31:CooldownDown())))) then
		if v16(v30) then
			return "use_item for " .. v30:Name() .. " trinkets 2";
		end
	end
	if (v31:IsReady() and v67(v24.TTD.TrinketsTTD) and Trinket2Setting and not v48 and ((v31:HasUseBuff() and ((v37 and (v50 or v30:CooldownDown())) or (not v37 and ((v50 and (((v38 > (v46 / (2 + 1))) and (v35 > (v46 + (416 - (115 + 281))))) or (v30:HasUseBuff() and (v30:CooldownRemains() > (v38 - (34 - 19))) and ((v30:CooldownRemains() - (5 + 0)) < v38) and ((v38 + (108 - 63)) > v35)))) or (v49 and ((v30:CooldownDown() and ((((v30:CooldownRemains() - (18 - 13)) < v38) and (v38 >= (887 - (550 + 317)))) or (((v30:CooldownRemains() - (7 - 2)) >= v38) and ((v38 > (v46 / (3 - 0))) or ((v46 < v35) and ((v38 + v46) > v35)))))) or (v30:CooldownUp() and (v38 > (55 - 35)) and (v38 < (v45 / (288 - (134 + 151))))))))))) or (not v31:HasUseBuff() and ((v40 == (1665 - (970 + 695))) or not v36) and ((not v30:HasUseBuff() and (v50 or v30:CooldownDown())) or (v30:HasUseBuff() and ((not v36 and (v38 > (38 - 18))) or (v30:CooldownRemains() > (2010 - (582 + 1408))))))) or ((v35 < (86 - 61)) and (v50 or v30:CooldownDown())))) then
		if v16(v31) then
			return "use_item for " .. v31:Name() .. " trinkets 4";
		end
	end
	if (v30:IsReady() and v67(v24.TTD.TrinketsTTD) and Trinket1Setting and not v47 and v36) then
		if v16(v30) then
			return "use_item for " .. v30:Name() .. " trinkets 2";
		end
	end
	if (v31:IsReady() and v67(v24.TTD.TrinketsTTD) and Trinket2Setting and not v48 and v36) then
		if v16(v31) then
			return "use_item for " .. v31:Name() .. " trinkets 4";
		end
	end
end
local function v92()
	if v6:IsChanneling(v27.ManicGrieftorch.ItemUseSpell) then
		return "Dont cut Torch";
	end
	SmallCDToggle = v13.ToggleIconFrame:GetToggle(1 - 0);
	TabToggle = v13.ToggleIconFrame:GetToggle(7 - 5);
	InterruptToggle = v13.ToggleIconFrame:GetToggle(1827 - (1195 + 629));
	if v25.Stomp:IsAvailable() then
		v3.SplashEnemies.ChangeFriendTargetsTracking("Mine Only");
	else
		v3.SplashEnemies.ChangeFriendTargetsTracking("All");
	end
	v58 = (v12.FindBySpellID(v25.BloodBolt:ID()) and v25.BloodBolt) or (v25.Bite:IsPetKnown() and v12.FindBySpellID(v25.Bite:ID()) and v25.Bite) or (v25.Claw:IsPetKnown() and v12.FindBySpellID(v25.Claw:ID()) and v25.Claw) or (v25.Smack:IsPetKnown() and v12.FindBySpellID(v25.Smack:ID()) and v25.Smack) or nil;
	v59 = (v25.Growl:IsPetKnown() and v12.FindBySpellID(v25.Growl:ID()) and v25.Growl) or nil;
	v62 = (v59 and v62) or true;
	if v14() then
		v60 = v6:GetEnemiesInRange(10 - 2);
		v51 = v6:GetEnemiesInRange(281 - (187 + 54));
		v52 = (v58 and v6:GetEnemiesInSpellActionRange(v58)) or v7:GetEnemiesInSplashRange(788 - (162 + 618));
		v53 = (v58 and #v52) or v7:GetEnemiesInSplashRangeCount(6 + 2);
	else
		v60 = {};
		v51 = {};
		v52 = v7 or {};
		v53 = 0 + 0;
	end
	RacialsSetting = v65(v24.BeastMastery.RacialsSetting);
	Trinket1Setting = v65(v24.BeastMastery.Trinket1Setting);
	Trinket2Setting = v65(v24.BeastMastery.Trinket2Setting);
	PotionSetting = v65(v24.BeastMastery.PotionSetting) and not v21.ISSolo() and v67(42 - 22);
	BloodshedSetting = v65(v24.BeastMastery.BloodshedSetting) and v67(v24.TTD.BloodshedTTD);
	CallOfTheWildSetting = v65(v24.BeastMastery.CallOfTheWildSetting) and v67(v24.TTD.CallOfTheWildTTD);
	BestialWrathSetting = v65(v24.BeastMastery.BestialWrathSetting) and v67(v24.TTD.BestialWrathTTD);
	StampedeSetting = v65(v24.BeastMastery.StampedeSetting) and v67(33 - 13);
	BarrageSetting = v65(v24.BeastMastery.BarrageSetting) and v67(2 + 18);
	MultidotBarbedShot = v24.BeastMastery.BarbedShot and TabToggle;
	RecommendBarbedShot = v24.BeastMastery.RecommendBarbedShot;
	KillShotTab = v24.Commons.KillShot and TabToggle;
	MultidotSerpentSting = v24.Commons.SerpentSting and TabToggle;
	v54 = v7:IsInRange(1676 - (1373 + 263));
	v55 = v7:IsInRange(1030 - (451 + 549));
	v56 = (v59 and v7:IsSpellInActionRange(v59)) or v7:IsInRange(10 + 20);
	v33 = v6:GCD() + (0.15 - 0);
	if (v24.Commons.UseMisdirection and v21.TargetIsValid() and v25.Misdirection:IsCastable()) then
		MisdirectionUnitsInRange = v21.UnitsinRange(v25.Misdirection);
		MisdirectionRankUnit = GetTankUnit(MisdirectionUnitsInRange);
	end
	if (v21.TargetIsValid() or v6:AffectingCombat()) then
		v34 = v3.BossFightRemains();
		v61 = true;
		v35 = v34;
		if (v35 == (18673 - 7562)) then
			v61 = false;
			v35 = v3.FightRemains(v60, false);
		end
	end
	if v6:AffectingCombat() then
		if (v25.Exhilaration:IsCastable() and (v6:HealthPercentage() <= v24.Defensives.ExhilarationHP)) then
			if v16(v25.Exhilaration, false) then
				return "Exhilaration";
			end
		end
		if (v25.SurvivalOfTheFittest:IsCastable() and v6:BuffDown(v25.SurvivalOfTheFittest) and (v6:HealthPercentage() <= v24.Defensives.SurvivalOfTheFittestHP)) then
			if v16(v25.SurvivalOfTheFittest, false) then
				return "Survival of the Fittest";
			end
		end
		if (v25.AspectOfTheTurtle:IsCastable() and (v6:HealthPercentage() <= v24.Defensives.AspectOfTheTurtleHP)) then
			if v16(v25.AspectOfTheTurtle, false) then
				return "Aspect of the Turtle";
			end
		end
		if ((v24.Defensives.FeignDeathOnSpell and v6:IncomingSpell(FeignDeathList)) or (v6:HealthPercentage() <= v24.Defensives.FeignDeathHP)) then
			if v25.FeignDeath:IsCastable() then
				if v16(v25.FeignDeath, false) then
					return "Feign Death";
				end
			end
			if v13.CastAnnotated(v25.PoolFocus, false, "Wait in Feign Death") then
				return "Wait in Feign Death";
			end
		end
		if (v25.FortitudeOfTheBear:IsCastable() and (v6:HealthPercentage() <= v24.Defensives.FortitudeOfTheBearHP)) then
			if v16(v25.FortitudeOfTheBear, false) then
				return "Fortitude of the Bear";
			end
		end
		if (v25.SpiritMend:IsCastable() and (v6:HealthPercentage() <= v24.Pet.SpiritMend)) then
			if v16(v25.SpiritMend, true) then
				return "Spirit Mend";
			end
		end
	end
	if (v6:DebuffUp(v25.FreezeTagFixation) and v25.FreezingTrap:IsCastable()) then
		if v16(v25.FreezingTrap) then
			return "Freezing Trap on Fixate";
		end
	end
	if not (v6:IsMounted() or v6:IsInVehicle()) then
		if (v25.SummonPet:IsCastable() and not IsFalling() and (v24.Pet.SummonPetSlot > (1384 - (746 + 638))) and ((v24.Pet.WhenSummonPet == "Always") or ((v24.Pet.WhenSummonPet == "In combat") and v6:AffectingCombat()) or ((v24.Pet.WhenSummonPet == "Out of combat") and not v6:AffectingCombat()))) then
			if v16(v26[v24.Pet.SummonPetSlot], false) then
				return "Summon Pet";
			end
		end
		if (v25.RevivePet:IsCastable() and not v6:IsMoving()) then
			if v16(v25.RevivePet, false) then
				return "Revive Pet";
			end
		end
		if v25.MendPet:IsCastable() then
			if v16(v25.MendPet, false) then
				return "Mend Pet High Priority";
			end
		end
	end
	if (v25.HuntersMark:IsCastable() and v7:DebuffDown(v25.HuntersMark, true) and v21.TargetIsValid() and not (v24.Commons.HuntersMark == "Not Used") and (((v24.Commons.HuntersMark == "On Bosses") and (v61 or v7:IsBoss())) or (v24.Commons.HuntersMark == "Always")) and v7:IsInRange(23 + 37) and (v25.HuntersMark:TimeSinceLastCast() > (7 - 2)) and (v7:HealthPercentage() > (421 - (218 + 123)))) then
		if v16(v25.HuntersMark) then
			return "Hunters Mark";
		end
	end
	if CombatCheck() then
		if not v6:AffectingCombat() then
			v57 = v87();
			if v57 then
				return v57;
			end
		end
		if (((v24.Commons.UseMisdirection == "Always") or ((v24.Commons.UseMisdirection == "On Combat Start") and (v3.CombatTime() < (1586 - (1535 + 46)))) or ((v24.Commons.UseMisdirection == "Solo") and v21.ISSolo()) or ((v24.Commons.UseMisdirection == "On AoE") and v14() and ((v53 > (2 + 0)) or (v25.BeastCleave:IsAvailable() and (v53 > (1 + 0)))))) and v21.TargetIsValid() and v25.Misdirection:IsCastable() and v5.Focus:Exists() and v5.Focus:UnitIsFriend() and not v5.Focus:IsDeadOrGhost() and v5.Focus:IsSpellInRange(v25.Misdirection) and v6:BuffDown(v25.Misdirection) and ((v5.Focus:Role() == "TANK") or (UnitIsUnit("focus", "pet") and v21.ISSolo()))) then
			v13.CastTarget(v25.Misdirection, v13.TName().FOCUS);
			return "Misdirection";
		end
		if InterruptToggle then
			if v24.Commons.ImplosiveTrap then
				v57 = v21.InterruptCycle(v25.ImplosiveTrap, 565 - (306 + 254), false, nil, true, true);
				if v57 then
					if v13.CastTarget(v25.ImplosiveTrap, v13.TName().PLAYER) then
						return "HighExplosiveTrap Player";
					end
				end
			end
			if v24.Commons.HighExplosiveTrap then
				v57 = v21.InterruptCycle(v25.HighExplosiveTrap, 1 + 4, false, nil, true, true);
				if v57 then
					if v25.BindingShot:IsCastable() then
						if v13.CastTarget(v25.BindingShot, v13.TName().PLAYER) then
							return "Binding Shot Player";
						end
						if v13.CastTarget(v25.HighExplosiveTrap, v13.TName().PLAYER) then
							return "HighExplosiveTrap Player";
						end
					end
				end
			end
			if v24.Commons.BurstingShot then
				v57 = v21.InterruptCycle(v25.BurstingShot, 9 - 4, false, nil, true, true);
				if v57 then
					return v57;
				end
			end
			v57 = v21.InterruptCycle(v25.ScatterShot, 1507 - (899 + 568), false, nil, true);
			if v57 then
				return v57;
			end
			v57 = v21.InterruptCycle(v25.CounterShot, 27 + 13, true, nil, false);
			if v57 then
				return v57;
			end
			v57 = v21.InterruptCycle(v25.Intimidation, 96 - 56, false, nil, true);
			if v57 then
				return v57;
			end
		end
		v57 = v21.PurgeCycle(v25.TranquilizingShot, 643 - (268 + 335), false, v24.Commons.TabForTranquilizingShot);
		if v57 then
			return v57;
		end
		v57 = v21.SootheCycle(v25.TranquilizingShot, 330 - (60 + 230), false, v24.Commons.TabForTranquilizingShot);
		if v57 then
			return v57;
		end
		v57 = v88();
		if v57 then
			return v57;
		end
		if v24.Commons.Enabled.Trinkets then
			v57 = v91();
			if v57 then
				return v57;
			end
		end
		if ((v53 < (574 - (426 + 146))) or (not v25.BeastCleave:IsAvailable() and (v53 < (1 + 2)))) then
			v57 = v90();
			if v57 then
				return v57;
			end
		end
		if ((v53 > (1458 - (282 + 1174))) or (v25.BeastCleave:IsAvailable() and (v53 > (812 - (569 + 242))))) then
			v57 = v89();
			if v57 then
				return v57;
			end
		end
	end
	if (not (v6:IsMounted() or v6:IsInVehicle()) and v25.MendPet:IsCastable()) then
		if v16(v25.MendPet) then
			return "Mend Pet Low Priority (w/ Target)";
		end
	end
	if (not (v6:IsMounted() or v6:IsInVehicle()) and v25.MendPet:IsCastable()) then
		if v16(v25.MendPet) then
			return "Mend Pet Low Priority (w/o Target)";
		end
	end
end
local function v93()
	v24.BeastMastery.Display();
	v13.Print("Beast Mastery can use pet abilities to better determine AoE. Make sure you have Growl and Blood Bolt / Bite / Claw / Smack on your player action bars.");
	v21.PostInitialMessage(728 - 475);
end
v13.SetAPL(15 + 238, v92, v93);
