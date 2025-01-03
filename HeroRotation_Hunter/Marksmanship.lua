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
local v11 = v3.MultiSpell;
local v12 = v3.Item;
local v13 = v3.Action;
local v14 = HeroRotation();
local v15 = v14.Cast;
local v16 = v14.CDsON;
local v17 = v14.AoEON;
local v18 = v14.Commons().Everyone.num;
local v19 = v14.Commons().Everyone.bool;
local v20 = GetTime;
local v21 = v14.Commons().Everyone;
local v22 = v14.Commons().Hunter;
local v23 = C_Timer.After;
local v24 = v10.Hunter.Marksmanship;
local v25 = v12.Hunter.Marksmanship;
local v26 = {v24.SummonPet,v24.SummonPet2,v24.SummonPet3,v24.SummonPet4,v24.SummonPet5};
local v27 = {v25.ManicGrieftorch:ID(),v25.MadQueensMandate:ID()};
local v28 = {LastCast=(927 - (214 + 713)),Count=(0 + 0)};
local v29 = 1748 + 9363;
local v30 = 11988 - (282 + 595);
local v31 = false;
local v32 = false;
local v33 = 1637 - (1523 + 114);
local v34, v35;
local v36, v37;
local v38, v39;
local v40, v41;
local v42, v43;
local v44, v45;
local v46, v47;
local v48;
local v49;
local v50;
local v51;
local v52;
local v53;
local v54, v55;
local v56;
local v57 = v14.GUISettingsGet();
local v58 = {General=v57.General,Commons=v57.APL.Hunter.Commons,Pet=v57.APL.Hunter.MMPet,Defensives=v57.APL.Hunter.Defensives,Marksmanship=v57.APL.Hunter.Marksmanship,TTD=v57.APL.Hunter.Marksmanship_TTD};
local v59 = (v7:HealthPercentage() > (63 + 7)) and v24.CarefulAim:IsAvailable();
local v60 = false;
local v61;
local v62 = {{v24.Intimidation,"Cast Intimidation (Interrupt)",function()
	return true;
end}};
local function v63()
	return v25.ManicGrieftorch:IsEquipped() and (v25.ManicGrieftorch:CooldownUp() or (v25.ManicGrieftorch:CooldownRemains() <= v6:GCDRemains()));
end
local function v64()
	return v25.AlgetharPuzzleBox:IsEquipped() and (v25.AlgetharPuzzleBox:CooldownUp() or (v25.AlgetharPuzzleBox:CooldownRemains() <= v6:GCDRemains()));
end
local function v65(v87)
	return (v87 ~= "Not Used") and (((v87 == "With Cooldowns") and v14.CDsON()) or ((v87 == "With Small or Cooldowns") and (SmallCDToggle or v14.CDsON())) or ((v87 == "With Small CDs") and SmallCDToggle) or ((v87 == "On Mobcount") and (v50 >= v58.Marksmanship.Mobcount)) or ((v87 == "On Mobcount or Cooldowns") and ((v50 >= v58.Marksmanship.Mobcount) or v16())) or (v87 == "Always") or ((v87 == "Mobcount or Boss") and (v56 or (v50 >= v58.Marksmanship.Mobcount))) or ((v87 == "With Bloodlust only") and v6:BloodlustUp()));
end
local function v66(v88, v89, v90)
	if (v56 or v21.ISSolo() or (v90 == (117 - (32 + 85))) or ((v30 >= v90) and (v30 < (7622 + 155)))) then
		v14.Cast(v88, v89);
		return "TTD cast " .. v88:Name();
	end
end
local v67 = 0 + 0;
local v68 = 957 - (892 + 65);
local function v69()
	if ((v24.RapidFire:TimeSinceLastCast() > (0 - 0)) and (v24.RapidFire:TimeSinceLastCast() < (1 - 0))) then
		if (v67 == (0 - 0)) then
			v67 = v20() + (365 - (87 + 263));
		end
	end
	if ((v67 > (180 - (67 + 113))) and (v20() >= v67)) then
		v67 = 0 + 0;
	end
	return math.max(0 - 0, v67 - v20());
end
local function v70()
	return (v8:Exists() or not v58.Marksmanship.CursorCheck) and not v6:IsCameraBusy();
end
local function v71()
	if v21.TargetIsValid() then
		local v109 = v7:MinDistance();
		v109 = (v109 and ((v109 - (6 + 2)) > (19 - 14)) and (v109 - (960 - (802 + 150)))) or (13 - 8);
		local v110 = v7:MaxDistance();
		v110 = (v110 and ((v110 + (14 - 6)) > (4 + 1)) and (v110 + (1005 - (915 + 82)))) or (14 - 9);
		local v111 = v6:GetEnemiesInRange(v109);
		local v112 = v6:GetEnemiesInRange(v110);
		local v113 = (((v110 - v109) > (5 + 3)) and (#v112 - #v111)) or #v112;
		return ((v113 > (0 - 0)) and v113) or (1187 - (1069 + 118));
	end
end
local function v72(v91)
	return v56 or v21.ISSolo() or (v91 == (0 - 0)) or v21.Buggedmobs[v7:NPCID()] or ((v30 >= v91) and (v30 < (17011 - 9234)));
end
local v73 = 0 + 0;
local function v74()
	local v92, v93 = v6:GetTrinketData(v27);
	if ((v73 < (8 - 3)) and ((v92.ID == (0 + 0)) or (v93.ID == (791 - (368 + 423))) or ((v92.SpellID > (0 - 0)) and not v92.Usable) or ((v93.SpellID > (18 - (10 + 8))) and not v93.Usable))) then
		v23(19 - 14, function()
			v74();
		end);
		return;
	end
	v34 = v92.Object;
	v35 = v93.Object;
	v38 = v92.Spell;
	v40 = v92.Range;
	v36 = v92.CastTime;
	v39 = v93.Spell;
	v41 = v93.Range;
	v37 = v93.CastTime;
	v42 = v92.Cooldown;
	v43 = v93.Cooldown;
	v44 = v92.Blacklisted;
	v45 = v93.Blacklisted;
	v46 = (v42 == (442 - (416 + 26))) or (v34:HasUseBuff() and (not v35:HasUseBuff() or ((not v92.ID == v25.MirrorofFracturedTomorrows:ID()) and ((v93.ID == v25.MirrorofFracturedTomorrows:ID()) or (v43 < v42) or (v37 < v36) or ((v37 == v36) and (v43 == v42)))))) or (not v34:HasUseBuff() and not v35:HasUseBuff() and ((v43 < v42) or (v37 < v36) or ((v37 == v36) and (v43 == v42))));
	v47 = not v46;
end
v74();
v3:RegisterForEvent(function()
	v73 = 0 - 0;
	v74();
end, "PLAYER_EQUIPMENT_CHANGED");
v3:RegisterForEvent(function()
	v28 = {LastCast=(0 + 0),Count=(0 - 0)};
	v29 = 11549 - (145 + 293);
	v30 = 11541 - (44 + 386);
end, "PLAYER_REGEN_ENABLED");
v3:RegisterForEvent(function()
	v24.SerpentSting:RegisterInFlight();
	v24.SteadyShot:RegisterInFlight();
	v24.AimedShot:RegisterInFlight();
end, "LEARNED_SPELL_IN_TAB");
v24.SerpentSting:RegisterInFlight();
v24.SteadyShot:RegisterInFlight();
v24.AimedShot:RegisterInFlight();
local function v75()
	return (((v8:HealthPercentage() > (1486 - (998 + 488))) and (v8:HealthPercentage() <= (7 + 13))) or v6:BuffUp(v24.Deathblow)) and ((v6:Focus() >= (9 + 1)) or v6:BuffUp(v24.Deathblow)) and v8:IsSpellInRange(v24.KillShot);
end
local function v76(v106)
	return (((v106:HealthPercentage() > (772 - (201 + 571))) and (v106:HealthPercentage() <= (1158 - (116 + 1022)))) or v6:BuffUp(v24.Deathblow)) and ((v6:Focus() >= (41 - 31)) or v6:BuffUp(v24.Deathblow));
end
local function v77()
	return (v6:BuffUp(v24.TrickShotsBuff) and not v6:IsCasting(v24.AimedShot) and not v6:IsChanneling(v24.RapidFire)) or v6:BuffUp(v24.VolleyBuff);
end
local function v78(v107)
	return (v107:DebuffRemains(v24.SerpentStingDebuff));
end
local function v79(v108)
	return v108:DebuffRemains(v24.SerpentStingDebuff) + (v18(v24.SerpentSting:InFlight()) * (59 + 40));
end
function CombatCheck()
	return v21.TargetIsValid() and (v7:AffectingCombat() or ((v58.Commons.AttackOutOfCombat == "Solo") and v21.ISSolo()) or (v58.Commons.AttackOutOfCombat == "Always"));
end
local function v80()
	if (v24.Salvo:IsCastable() and SalvoSetting and v51) then
		if v15(v24.Salvo, false) then
			return "salvo precombat 3";
		end
	end
	if (v58.Commons.Enabled.Trinkets and v64() and (((v34:ID() == v25.AlgetharPuzzleBox:ID()) and Trinket1Setting) or ((v35:ID() == v25.AlgetharPuzzleBox:ID()) and Trinket2Setting))) then
		if v15(v25.AlgetharPuzzleBox) then
			return "algethar_puzzle_box precombat 4";
		end
	end
end
local function v81()
	if (v24.Berserking:IsReady() and RacialsSetting and (v6:BuffUp(v24.TrueshotBuff) or (v30 < (47 - 34)))) then
		if v15(v24.Berserking, true) then
			return "Berserking";
		end
	end
	if (v24.BloodFury:IsReady() and RacialsSetting and (v6:BuffUp(v24.TrueshotBuff) or (v24.Trueshot:CooldownRemains() > (106 - 76)) or (v30 < (875 - (814 + 45))))) then
		if v15(v24.BloodFury, true) then
			return "BloodFury";
		end
	end
	if (v24.AncestralCall:IsReady() and RacialsSetting and (v6:BuffUp(v24.TrueshotBuff) or (v24.Trueshot:CooldownRemains() > (73 - 43)) or (v30 < (1 + 15)))) then
		if v15(v24.AncestralCall, true) then
			return "AncestralCall";
		end
	end
	if (v24.Fireblood:IsReady() and RacialsSetting and (v6:BuffUp(v24.TrueshotBuff) or (v24.Trueshot:CooldownRemains() > (11 + 19)) or (v30 < (894 - (261 + 624))))) then
		if v15(v24.Fireblood, true) then
			return "Fireblood";
		end
	end
	if (v24.LightsJudgment:IsReady() and RacialsSetting and (v6:BuffDown(v24.TrueshotBuff))) then
		if v15(v24.LightsJudgment, true) then
			return "LightsJudgment";
		end
	end
	if (v58.Commons.Enabled.Potions and PotionSetting and ((v6:BuffUp(v24.TrueshotBuff) and (v6:BloodlustUp() or (v7:HealthPercentage() < (35 - 15)))) or (v30 < (1106 - (1020 + 60))))) then
		local v114 = v21.PotionSelected();
		if (v114 and v114:IsReady()) then
			v14.CastMacro(1426 - (630 + 793), nil, nil, v114);
			return "Cast Potion";
		end
	end
	if (v24.Salvo:IsCastable() and SalvoSetting and v51 and ((v50 > (6 - 4)) or (v24.Volley:CooldownRemains() < (47 - 37)))) then
		if v15(v24.Salvo, false) then
			return "salvo cds 14";
		end
	end
end
local function v82()
	if (v24.SteadyShot:IsCastable() and v51 and v24.SteadyFocus:IsAvailable() and (v22.SteadyFocus.Count == (1 + 0)) and (v6:BuffRemains(v24.SteadyFocusBuff) < (27 - 19))) then
		if v15(v24.SteadyShot) then
			return "steady_shot st 2";
		end
	end
	if (v24.KillShot:IsReady() and v51 and (v6:BuffUp(v24.RazorFragmentsBuff))) then
		if v15(v24.KillShot) then
			return "kill_shot st 4";
		end
	end
	if (v24.BlackArrow:IsReady() and v51) then
		if v15(v24.BlackArrow) then
			return "black_arrow st 6";
		end
	end
	if (v24.ExplosiveShot:IsReady() and (v7:TimeToDie() > (1750 - (760 + 987))) and v51 and (v50 > (1914 - (1789 + 124)))) then
		if v15(v24.ExplosiveShot) then
			return "explosive_shot st 8";
		end
	end
	if (v24.Volley:IsCastable() and VolleySetting) then
		if v15(v24.Volley) then
			return "volley st 10";
		end
	end
	if (v24.RapidFire:IsCastable() and RapidFireSetting and (v7:TimeToDie() > v24.RapidFire:ExecuteTime()) and v51 and ((v24.LunarStorm:IsAvailable() and ((v68 == (766 - (745 + 21))) or (v68 > (2 + 3)) or v24.WailingArrow:IsCastable())) or not v24.LunarStorm:IsAvailable())) then
		if v15(v24.RapidFire) then
			return "rapid_fire st 12 timer:" .. v68;
		end
	end
	if (v24.Trueshot:IsReady() and TrueshotSetting and v51 and v60) then
		if v15(v24.Trueshot) then
			return "trueshot st 14";
		end
	end
	if (v24.MultiShot:IsReady() and v51 and v6:BuffUp(v24.SalvoBuff) and not v24.Volley:IsAvailable()) then
		if v15(v24.MultiShot) then
			return "multishot st 16 - Salvo";
		end
	end
	if (v24.WailingArrow:IsReady() and v51) then
		if v15(v24.WailingArrow) then
			return "wailing_arrow st 18";
		end
	end
	if (v24.AimedShot:IsReady() and v51 and (v6:BuffDown(v24.PreciseShotsBuff) or ((v6:BuffUp(v24.TrueshotBuff) or (v24.AimedShot:FullRechargeTime() < (v6:GCD() + v24.AimedShot:CastTime()))) and ((v50 < (5 - 3)) or not v24.ChimaeraShot:IsAvailable())) or ((v6:BuffRemains(v24.TrickShotsBuff) > v24.AimedShot:ExecuteTime()) and (v50 > (3 - 2))))) then
		if v15(v24.AimedShot) then
			return "aimed_shot st 20";
		end
	end
	if (v24.SteadyShot:IsCastable() and v51 and v24.SteadyFocus:IsAvailable() and v6:BuffDown(v24.SteadyFocusBuff) and v6:BuffDown(v24.TrueshotBuff)) then
		if v15(v24.SteadyShot) then
			return "steady_shot st 22";
		end
	end
	if (v24.KillShot:IsReady() and v51) then
		if v15(v24.KillShot) then
			return "kill_shot st 28";
		end
	end
	if (v24.ChimaeraShot:IsReady() and v51 and (v6:BuffUp(v24.PreciseShotsBuff))) then
		if v15(v24.ChimaeraShot) then
			return "chimaera_shot st 24";
		end
	end
	if (v24.MultiShot:IsReady() and v51 and v6:BuffUp(v24.PreciseShotsBuff) and (v50 > (1 + 0)) and (v24.SymphonicArsenal:IsAvailable() or v24.SmallGameHunter:IsAvailable())) then
		if v15(v24.MultiShot) then
			return "multishot st 25 - " .. v50;
		end
	end
	if (v24.ArcaneShot:IsReady() and v51 and (v6:BuffUp(v24.PreciseShotsBuff))) then
		if v15(v24.ArcaneShot) then
			return "arcane_shot st 26";
		end
	end
	if (v24.Barrage:IsReady() and BarrageSetting and v51 and (v24.RapidFireBarrage:IsAvailable())) then
		if v15(v24.Barrage) then
			return "barrage st 30";
		end
	end
	if (v24.ExplosiveShot:IsReady() and (v7:TimeToDie() > (3 + 0)) and v51) then
		if v15(v24.ExplosiveShot) then
			return "explosive_shot st 32";
		end
	end
	if (v24.ChimaeraShot:IsReady() and v51 and (v6:FocusP() > (v24.ChimaeraShot:Cost() + v24.AimedShot:Cost()))) then
		if v15(v24.ChimaeraShot) then
			return "chimaera_shot st 33";
		end
	end
	if (v24.MultiShot:IsReady() and v51 and (v6:FocusP() > (v24.MultiShot:Cost() + v24.AimedShot:Cost())) and (v50 > (1056 - (87 + 968))) and (v24.SymphonicArsenal:IsAvailable() or v24.SmallGameHunter:IsAvailable())) then
		if v15(v24.MultiShot) then
			return "multishot st 34 - " .. v50;
		end
	end
	if (v24.ArcaneShot:IsReady() and v51 and (v6:FocusP() > (v24.ArcaneShot:Cost() + v24.AimedShot:Cost()))) then
		if v15(v24.ArcaneShot) then
			return "arcane_shot st 35";
		end
	end
	if (v24.BagofTricks:IsReady() and RacialsSetting and v7:IsSpellInRange(v24.BagofTricks)) then
		if v15(v24.BagofTricks) then
			return "bag_of_tricks st 36";
		end
	end
	if (v24.SteadyShot:IsCastable() and v51) then
		if v15(v24.SteadyShot) then
			return "steady_shot st 38";
		end
	end
end
local function v83()
	if (v24.SteadyShot:IsCastable() and v51 and v24.SteadyFocus:IsAvailable() and (v22.SteadyFocus.Count == (4 - 3)) and (v6:BuffRemains(v24.SteadyFocusBuff) < (8 + 0))) then
		if v15(v24.SteadyShot) then
			return "steady_shot trickshots 2";
		end
	end
	if (v24.ExplosiveShot:IsReady() and (v7:TimeToDie() > (6 - 3)) and v51) then
		if v15(v24.ExplosiveShot) then
			return "explosive_shot trickshots 4";
		end
	end
	if (v24.Volley:IsCastable() and v51 and VolleySetting) then
		if v15(v24.Volley) then
			return "volley trickshots 6";
		end
	end
	if (v24.Barrage:IsReady() and BarrageSetting and v51 and v24.RapidFireBarrage:IsAvailable() and (v6:BuffRemains(v24.TrickShotsBuff) >= v24.Barrage:ExecuteTime())) then
		if v15(v24.Barrage) then
			return "barrage trickshots 8";
		end
	end
	if (v24.RapidFire:IsCastable() and RapidFireSetting and (v7:TimeToDie() > v24.RapidFire:ExecuteTime()) and v51 and (v6:BuffRemains(v24.TrickShotsBuff) >= v24.RapidFire:ExecuteTime())) then
		if v15(v24.RapidFire) then
			return "rapid_fire trickshots 10";
		end
	end
	if (v24.KillShot:IsReady() and v51 and (v6:BuffUp(v24.RazorFragmentsBuff))) then
		if v21.CastCycle(v24.KillShot, v48, v76, 1453 - (447 + 966)) then
			return "kill_shot trickshots 12";
		end
	end
	if (v24.BlackArrow:IsReady() and v51) then
		if v15(v24.BlackArrow) then
			return "black_arrow trickshots 14";
		end
	end
	if (v24.WailingArrow:IsReady() and v51 and v6:BuffDown(v24.PreciseShotsBuff)) then
		if v15(v24.WailingArrow) then
			return "wailing_arrow trickshots 16";
		end
	end
	if (v24.Trueshot:IsReady() and TrueshotSetting and v51 and v16() and v60) then
		if v15(v24.Trueshot) then
			return "trueshot trickshots 18";
		end
	end
	if (v24.AimedShot:IsReady() and v51 and (v6:BuffRemains(v24.TrickShotsBuff) >= v24.AimedShot:ExecuteTime()) and v6:BuffDown(v24.PreciseShotsBuff)) then
		if v15(v24.AimedShot) then
			return "aimed_shot trickshots 20";
		end
	end
	if (v24.MultiShot:IsReady() and v51 and (v6:BuffDown(v24.TrickShotsBuff) or v6:BuffUp(v24.PreciseShotsBuff) or (v6:FocusP() > (v24.MultiShot:Cost() + v24.AimedShot:Cost())))) then
		if v15(v24.MultiShot) then
			return "multishot trickshots 22";
		end
	end
	if (v24.BagofTricks:IsReady() and RacialsSetting and v7:IsSpellInRange(v24.BagofTricks) and (v6:BuffDown(v24.Trueshot))) then
		if v15(v24.BagofTricks) then
			return "bag_of_tricks trickshots 24";
		end
	end
	if (v24.SteadyShot:IsCastable() and v51) then
		if v15(v24.SteadyShot) then
			return "steady_shot trickshots 26";
		end
	end
end
local function v84()
	if v58.Commons.Enabled.Trinkets then
		v32 = v60;
		v31 = v6:BuffUp(v24.TrueshotBuff);
		v33 = v24.Trueshot:CooldownRemains();
		if (v63() and v6:AffectingCombat() and (((v34:ID() == v25.ManicGrieftorch:ID()) and Trinket1Setting) or ((v35:ID() == v25.ManicGrieftorch:ID()) and Trinket2Setting)) and v7:IsInRange(109 - 69)) then
			if v15(v25.ManicGrieftorch) then
				return "manic_grieftorch";
			end
		end
		if (v25.MadQueensMandate:IsEquippedAndReady() and v51 and (((v34:ID() == v25.MadQueensMandate:ID()) and Trinket1Setting) or ((v35:ID() == v25.MadQueensMandate:ID()) and Trinket2Setting)) and ((v29 > (1937 - (1703 + 114))) or (v29 < (711 - (376 + 325))) or (not v56 and (v30 < (8 - 3))))) then
			if v15(v25.MadQueensMandate) then
				return "mad_queens_mandate";
			end
		end
		if (v34:IsReady() and not v44 and ((v34:HasUseBuff() and ((v32 and (v46 or v35:CooldownDown())) or (not v32 and ((v46 and (((v33 > (v42 / (8 - 5))) and (v30 > (v42 + 6 + 14))) or (v35:HasUseBuff() and (v35:CooldownRemains() > (v33 - (32 - 17))) and ((v35:CooldownRemains() - (19 - (9 + 5))) < v33) and ((v33 + (421 - (85 + 291))) > v30)))) or (v47 and ((v35:CooldownDown() and ((((v35:CooldownRemains() - (1270 - (243 + 1022))) < v33) and (v33 >= (76 - 56))) or (((v35:CooldownRemains() - (5 + 0)) >= v33) and ((v33 > (v42 / (1183 - (1123 + 57)))) or ((v42 < v30) and ((v33 + v42) > v30)))))) or (v35:CooldownUp() and (v33 > (17 + 3)) and (v33 < (v43 / (257 - (163 + 91))))))))))) or (not v34:HasUseBuff() and ((v38:CastTime() == (1930 - (1869 + 61))) or not v31) and ((not v35:HasUseBuff() and (v46 or v35:CooldownDown())) or (v35:HasUseBuff() and ((v33 > (6 + 14)) or (v35:CooldownRemains() > (70 - 50)))))) or ((v30 < (38 - 13)) and (v46 or v35:CooldownDown())))) then
			if v15(v34) then
				return "Trinket1 (" .. v34:Name() .. ") Trinkets 1";
			end
		end
		if (v35:IsReady() and not v45 and ((v35:HasUseBuff() and ((v32 and (v47 or v34:CooldownDown())) or (not v32 and ((v47 and (((v33 > (v43 / (1 + 2))) and (v30 > (v43 + (27 - 7)))) or (v34:HasUseBuff() and (v34:CooldownRemains() > (v33 - (15 + 0))) and ((v34:CooldownRemains() - (1479 - (1329 + 145))) < v33) and ((v33 + (1016 - (140 + 831))) > v30)))) or (v46 and ((v34:CooldownDown() and ((((v34:CooldownRemains() - (1855 - (1409 + 441))) < v33) and (v33 >= (738 - (15 + 703)))) or (((v34:CooldownRemains() - (3 + 2)) >= v33) and ((v33 > (v43 / (441 - (262 + 176)))) or ((v43 < v30) and ((v33 + v43) > v30)))))) or (v34:CooldownUp() and (v33 > (1741 - (345 + 1376))) and (v33 < (v42 / (691 - (198 + 490))))))))))) or (not v35:HasUseBuff() and ((v39:CastTime() == (0 - 0)) or not v31) and ((not v34:HasUseBuff() and (v47 or v34:CooldownDown())) or (v34:HasUseBuff() and ((v33 > (47 - 27)) or (v34:CooldownRemains() > (1226 - (696 + 510))))))) or ((v30 < (52 - 27)) and (v47 or v34:CooldownDown())))) then
			if v15(v35) then
				return "Trinket2 (" .. v35:Name() .. ") Trinkets 2";
			end
		end
	end
end
local function v85()
	if v6:IsChanneling(v25.ManicGrieftorch.ItemUseSpell) then
		return "Dont cut Torch";
	end
	SmallCDToggle = v14.ToggleIconFrame:GetToggle(1263 - (1091 + 171));
	TabToggle = v14.ToggleIconFrame:GetToggle(1 + 1);
	InterruptToggle = v14.ToggleIconFrame:GetToggle(9 - 6);
	v51 = (v24.AimedShot:IsAvailable() and v7:IsSpellInRange(v24.AimedShot)) or v7:IsInRange(132 - 92);
	v48 = v6:GetEnemiesInRange(v24.AimedShot.MaximumRange);
	v49 = v7:GetEnemiesInSplashRange(384 - (123 + 251));
	v54 = (v13.FindBySpellID(v24.BloodBolt:ID()) and v24.BloodBolt) or (v13.FindBySpellID(v24.Bite:ID()) and v24.Bite) or (v13.FindBySpellID(v24.Claw:ID()) and v24.Claw) or (v13.FindBySpellID(v24.Smack:ID()) and v24.Smack) or nil;
	v55 = (v13.FindBySpellID(v24.Growl:ID()) and v24.Growl) or nil;
	PetInRange = (v55 and PetInRange) or true;
	if v17() then
		v52 = v71();
		v53 = v7:GetEnemiesInSplashRangeCount(49 - 39);
		v50 = v52 or (v54 and (v9:HealthPercentage() > (698 - (208 + 490))) and #v6:GetEnemiesInSpellActionRange(v54)) or v53;
		PetEnemiesMixed = (v54 and v6:GetEnemiesInSpellActionRange(v54)) or v7:GetEnemiesInSplashRange(1 + 7);
		PetEnemiesMixedCount = (v54 and #PetEnemiesMixed) or v7:GetEnemiesInSplashRangeCount(4 + 4);
	else
		v50 = 837 - (660 + 176);
		PetEnemiesMixed = v7 or {};
		PetEnemiesMixedCount = 0 + 0;
	end
	RacialsSetting = v65(v58.Marksmanship.RacialsSetting) and v72(v58.TTD.RacialsTTD);
	Trinket1Setting = v65(v58.Marksmanship.Trinket1Setting);
	Trinket2Setting = v65(v58.Marksmanship.Trinket2Setting);
	PotionSetting = v65(v58.Marksmanship.PotionSetting) and not v21.ISSolo();
	TrueshotSetting = v65(v58.Marksmanship.TrueshotSetting) and v72(v58.TTD.TrueshotTTD);
	VolleySetting = v65(v58.Marksmanship.VolleySetting) and v70();
	SalvoSetting = v65(v58.Marksmanship.SalvoSetting);
	RapidFireSetting = v65(v58.Marksmanship.RapidFireSetting);
	v68 = v69();
	if (v21.TargetIsValid() or v6:AffectingCombat()) then
		v29 = v3.BossFightRemains();
		v56 = true;
		v30 = v29;
		if (v30 == (11313 - (14 + 188))) then
			v56 = false;
			v30 = v3.FightRemains(v49, false);
		end
		v22.SteadyFocus.Count = 675 - (534 + 141);
		v22.SteadyFocus.LastCast = 0 + 0;
	end
	if (v6:DebuffUp(v24.FreezeTagFixation) and v24.FreezingTrap:IsCastable()) then
		if v15(v24.FreezingTrap) then
			return "Freezing Trap on Fixate";
		end
	end
	if not (v6:IsMounted() or v6:IsInVehicle()) then
		if (v24.SummonPet:IsCastable() and not IsFalling() and (v58.Pet.SummonPetSlot > (0 + 0)) and ((v58.Pet.SoloPet and v21.ISSolo()) or not v24.LoneWolf:IsAvailable()) and ((v58.Pet.WhenSummonPet == "Always") or ((v58.Pet.WhenSummonPet == "In combat") and v6:AffectingCombat()) or ((v58.Pet.WhenSummonPet == "Out of combat") and not v6:AffectingCombat()))) then
			if v15(v26[v58.Pet.SummonPetSlot], false) then
				return "Summon Pet";
			end
		end
		if (v24.RevivePet:IsCastable() and not v6:IsMoving()) then
			if v15(v24.RevivePet, false) then
				return "Revive Pet";
			end
		end
		if v24.MendPet:IsCastable() then
			if v15(v24.MendPet, false) then
				return "Mend Pet High Priority";
			end
		end
	end
	if (v24.HuntersMark:IsCastable() and v7:DebuffDown(v24.HuntersMark, true) and v21.TargetIsValid() and not (v58.Commons.HuntersMark == "Not Used") and (((v58.Commons.HuntersMark == "On Bosses") and (v56 or v7:IsBoss())) or (v58.Commons.HuntersMark == "Always")) and v7:IsInRange(58 + 2) and (v24.HuntersMark:TimeSinceLastCast() > (10 - 5)) and (v7:HealthPercentage() > (127 - 47))) then
		if v15(v24.HuntersMark) then
			return "Hunters Mark";
		end
	end
	if v6:AffectingCombat() then
		if (v24.Exhilaration:IsCastable() and (v6:HealthPercentage() <= v58.Defensives.ExhilarationHP)) then
			if v15(v24.Exhilaration, false) then
				return "Exhilaration";
			end
		end
		if (v24.SurvivalOfTheFittest:IsCastable() and (v6:HealthPercentage() <= v58.Defensives.SurvivalOfTheFittestHP)) then
			if v15(v24.SurvivalOfTheFittest, false) then
				return "Survival of the Fittest";
			end
		end
		if (v24.AspectOfTheTurtle:IsCastable() and (v6:HealthPercentage() <= v58.Defensives.AspectOfTheTurtleHP)) then
			if v15(v24.AspectOfTheTurtle, false) then
				return "Survival of the Fittest";
			end
		end
		if ((v58.Defensives.FeignDeathOnSpell and v6:IncomingSpell(FeignDeathList)) or (v6:HealthPercentage() <= v58.Defensives.FeignDeathHP)) then
			if v24.FeignDeath:IsCastable() then
				if v15(v24.FeignDeath, false) then
					return "Feign Death";
				end
			end
			if v14.CastAnnotated(v24.PoolFocus, false, "Wait in Feign Death") then
				return "Wait in Feign Death";
			end
		end
		if (v24.FortitudeOfTheBear:IsCastable() and (v6:HealthPercentage() <= v58.Defensives.FortitudeOfTheBearHP)) then
			if v15(v24.FortitudeOfTheBear, false) then
				return "Fortitude of the Bear";
			end
		end
	end
	if CombatCheck() then
		if not v6:AffectingCombat() then
			v61 = v80();
			if v61 then
				return v61;
			end
		end
		if (((v58.Commons.UseMisdirection == "Always") or ((v58.Commons.UseMisdirection == "On Combat Start") and (v3.CombatTime() < (14 - 9))) or ((v58.Commons.UseMisdirection == "Solo") and v21.ISSolo()) or ((v58.Commons.UseMisdirection == "On AoE") and v17() and (v50 > (2 + 0)) and v51)) and v21.TargetIsValid() and v24.Misdirection:IsCastable() and v5.Focus:Exists() and v5.Focus:UnitIsFriend() and not v5.Focus:IsDeadOrGhost() and v5.Focus:IsSpellInRange(v24.Misdirection) and v6:BuffDown(v24.Misdirection) and ((v5.Focus:Role() == "TANK") or (UnitIsUnit("focus", "pet") and v21.ISSolo()))) then
			v14.CastTarget(v24.Misdirection, v14.TName().FOCUS);
			return "Misdirection";
		end
		if InterruptToggle then
			if v58.Commons.ImplosiveTrap then
				v61 = v21.InterruptCycle(v24.ImplosiveTrap, 4 + 1, false, nil, true, true);
				if v61 then
					if v14.CastTarget(v24.ImplosiveTrap, v14.TName().PLAYER) then
						return "HighExplosiveTrap Player";
					end
				end
			end
			if v58.Commons.HighExplosiveTrap then
				v61 = v21.InterruptCycle(v24.HighExplosiveTrap, 401 - (115 + 281), false, nil, true, true);
				if v61 then
					if v24.BindingShot:IsCastable() then
						if v14.CastTarget(v24.BindingShot, v14.TName().PLAYER) then
							return "Binding Shot Player";
						end
						if v14.CastTarget(v24.HighExplosiveTrap, v14.TName().PLAYER) then
							return "HighExplosiveTrap Player";
						end
					end
				end
			end
			if v58.Commons.BurstingShot then
				v61 = v21.InterruptCycle(v24.BurstingShot, 11 - 6, false, nil, true, true);
				if v61 then
					return v61;
				end
			end
			v61 = v21.InterruptCycle(v24.ScatterShot, 34 + 6, false, nil, true);
			if v61 then
				return v61;
			end
			v61 = v21.InterruptCycle(v24.CounterShot, 96 - 56, true, nil, false);
			if v61 then
				return v61;
			end
			v61 = v21.InterruptCycle(v24.Intimidation, 146 - 106, false, nil, true);
			if v61 then
				return v61;
			end
		end
		v61 = v21.PurgeCycle(v24.TranquilizingShot, 907 - (550 + 317), false, v58.Commons.TabForTranquilizingShot);
		if v61 then
			return v61;
		end
		v61 = v21.SootheCycle(v24.TranquilizingShot, 57 - 17, false, v58.Commons.TabForTranquilizingShot);
		if v61 then
			return v61;
		end
		v60 = v24.Trueshot:CooldownUp() and v6:BuffDown(v24.TrueshotBuff);
		if v51 then
			v61 = v81();
			if v61 then
				return v61;
			end
		end
		if v58.Commons.Enabled.Trinkets then
			v61 = v84();
			if v61 then
				return v61;
			end
		end
		if ((v50 < (3 - 0)) or (not v24.TrickShots:IsAvailable() and v51)) then
			v61 = v82();
			if v61 then
				return v61;
			end
		end
		if ((v50 > (5 - 3)) and v51) then
			v61 = v83();
			if v61 then
				return v61;
			end
		end
		if v14.CastAnnotated(v24.PoolFocus, false, "WAIT") then
			return "Pooling Focus";
		end
	end
end
local function v86()
	v58.Marksmanship.Display();
	v14.Print("Marksmanship Hunter rotation has been updated for patch 11.0.2.");
end
v14.SetAPL(539 - (134 + 151), v85, v86);
