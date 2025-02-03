local v0, v1 = ...;
local v2 = HeroDBC.DBC;
local v3 = HeroLib;
local v4 = HeroCache;
local v5 = v3.Unit;
local v6 = v5.Player;
local v7 = v5.Pet;
local v8 = v5.Target;
local v9 = v3.Spell;
local v10 = v3.MultiSpell;
local v11 = v3.Item;
local v12 = HeroRotation();
local v13 = v12.AoEON;
local v14 = v12.CDsON;
local v15 = v12.Cast;
local v16 = v12.CastPooling;
local v17 = v5.MouseOver;
local v18 = v12.Commons().Everyone.num;
local v19 = v12.Commons().Everyone.bool;
local v20 = math.floor;
local v21 = C_Timer.After;
local v22;
local v23 = v12.Commons().Everyone;
local v24 = v12.GUISettingsGet();
local v25 = {General=v24.General,Commons=v24.APL.Druid.Commons,Feral=v24.APL.Druid.Feral,Feral_Defensives=v24.APL.Druid.Feral.Defensives,Feral_TTD=v24.APL.Druid.Feral_TTD,Feral_CDUSE=v24.APL.Druid.Feral_CDUSE};
local v26 = v9.Druid.Feral;
local v27 = v11.Druid.Feral;
local v28 = {v27.ImperfectAscendancySerum:ID()};
local v29, v30;
local v31, v32;
local v33, v34;
local v35, v36;
local v37, v38;
local v39, v40;
local v41, v42;
local v43, v44;
local v45, v46;
local v47, v48;
local v49;
local v50;
local v51, v52, v53;
local v54, v55, v56;
local v57, v58, v59;
local v60, v61;
local v62 = (v26.Incarnation:IsAvailable() and v26.Incarnation) or v26.Berserk;
local v63, v64;
local v65 = 31797 - 20686;
local v66 = 21447 - 10336;
local v67, v68;
local v69, v70, v71;
local v72 = 0 - 0;
local function v73()
	local v119, v120 = v6:GetTrinketData(v28);
	if ((v72 < (624 - (555 + 64))) and ((v119.ID == (931 - (857 + 74))) or (v120.ID == (568 - (367 + 201))) or ((v119.SpellID > (927 - (214 + 713))) and not v119.Usable) or ((v120.SpellID > (0 + 0)) and not v120.Usable))) then
		v72 = v72 + 1 + 0;
		v21(882 - (282 + 595), function()
			v73();
		end);
		return;
	end
	v29 = v119.Object;
	v30 = v120.Object;
	v31 = v29:ID();
	v32 = v30:ID();
	v33 = v119.Spell;
	v35 = v119.Range;
	v37 = v119.CastTime;
	v34 = v120.Spell;
	v36 = v120.Range;
	v38 = v120.CastTime;
	v39 = v119.Cooldown;
	v40 = v120.Cooldown;
	v41 = v119.Blacklisted;
	v42 = v120.Blacklisted;
	v43 = v29:HasUseBuff() and (v31 ~= v27.ImperfectAscendancySerum:ID()) and (v31 ~= v27.OvinaxsMercurialEgg:ID()) and (v31 ~= v27.ConcoctionKissofDeath:ID());
	v44 = v30:HasUseBuff() and (v32 ~= v27.ImperfectAscendancySerum:ID()) and (v32 ~= v27.OvinaxsMercurialEgg:ID()) and (v32 ~= v27.ConcoctionKissofDeath:ID());
	v45 = ((v29:BuffDuration() > (1637 - (1523 + 114))) and v29:BuffDuration()) or (1 + 0);
	v46 = ((v30:BuffDuration() > (0 - 0)) and v30:BuffDuration()) or (1066 - (68 + 997));
	v47 = 1270.5 - (226 + 1044);
	if ((v26.ConvoketheSpirits:IsAvailable() and not v26.AshamanesGuidance:IsAvailable() and v43 and (((v39 % (522 - 402)) == (117 - (32 + 85))) or (((118 + 2) % v39) == (0 + 0)))) or (not (v26.ConvoketheSpirits:IsAvailable() and not v26.AshamanesGuidance:IsAvailable()) and v43 and (((v39 % (1137 - (892 + 65))) == (0 - 0)) or (((332 - 152) % v39) == (0 - 0)) or ((v39 % (470 - (87 + 263))) == (180 - (67 + 113))) or (((88 + 32) % v39) == (0 - 0))))) then
		v47 = 1 + 0;
	end
	v48 = 0.5 - 0;
	if ((v26.ConvoketheSpirits:IsAvailable() and not v26.AshamanesGuidance:IsAvailable() and v44 and (((v40 % (1072 - (802 + 150))) == (0 - 0)) or (((217 - 97) % v40) == (0 + 0)))) or (not (v26.ConvoketheSpirits:IsAvailable() and not v26.AshamanesGuidance:IsAvailable()) and v44 and (((v40 % (1177 - (915 + 82))) == (0 - 0)) or (((105 + 75) % v40) == (0 - 0)) or ((v40 % (1307 - (1069 + 118))) == (0 - 0)) or (((262 - 142) % v40) == (0 + 0))))) then
		v48 = 1 - 0;
	end
	v49 = 1 + 0;
	if ((not v43 and v44) or (v44 and (((v40 / v46) * v48) > ((v39 / v45) * v47)))) then
		v49 = 793 - (368 + 423);
	end
end
v73();
local v74 = {{v26.MightyBash,"Cast Mighty Bash (Interrupt)",function()
	return true;
end}};
v3:RegisterForEvent(function()
	v62 = (v26.Incarnation:IsAvailable() and v26.Incarnation) or v26.Berserk;
end, "SPELLS_CHANGED", "LEARNED_SPELL_IN_TAB");
v3:RegisterForEvent(function()
	v72 = 0 - 0;
	v73();
end, "PLAYER_EQUIPMENT_CHANGED");
v3:RegisterForEvent(function()
	v65 = 4769 + 6342;
	v66 = 19659 - 8548;
end, "PLAYER_REGEN_ENABLED");
v3:RegisterForEvent(function()
	v26.AdaptiveSwarm:RegisterInFlightEffect(392327 - (145 + 293));
	v26.AdaptiveSwarm:RegisterInFlight();
end, "LEARNED_SPELL_IN_TAB");
v26.AdaptiveSwarm:RegisterInFlightEffect(392319 - (44 + 386));
v26.AdaptiveSwarm:RegisterInFlight();
local function v75()
	return (v6:StealthUp(true, true) and (1487.6 - (998 + 488))) or (1 + 0);
end
v26.Rake:RegisterPMultiplier(v26.RakeDebuff, v75);
local function v76()
	local v133 = 1 + 0;
	v133 = (v6:BuffUp(v26.BloodtalonsBuff) and (v133 * (773.25 - (201 + 571)))) or v133;
	v133 = (v26.DreadfulBleeding:IsAvailable() and (v133 * (1139.2 - (116 + 1022)))) or v133;
	v133 = (v6:HasTier("TWW1", 16 - 12) and (v133 * (1.08 + 0))) or v133;
	v133 = (v26.LionsStrength:IsAvailable() and (v133 * (3.15 - 2))) or v133;
	v133 = (v6:BuffUp(v26.TigersFury) and (v133 * (3.15 - 2))) or v133;
	return v133;
end
v26.Rip:RegisterPMultiplier(v26.RipDebuff, v76);
local v77 = {v26.Rake,v26.LIMoonfire,v26.ThrashCat,v26.BrutalSlash,v26.Swipe,v26.Shred,v26.FeralFrenzy};
local function v78(v134, v135)
	for v177, v178 in pairs(v134) do
		if v178:DebuffRefreshable(v135) then
			return true;
		end
	end
	return false;
end
local function v79(v136)
	if not v26.Bloodtalons:IsAvailable() then
		return false;
	end
	return v136:TimeSinceLastCast() < math.min(1428 - (630 + 793), v26.BloodtalonsBuff:TimeSinceLastAppliedOnPlayer());
end
local function v80(v137)
	return not v79(v137);
end
local function v81()
	local v138 = 0 - 0;
	for v179 = 4 - 3, #v77 do
		if v79(v77[v179]) then
			v138 = v138 + 1 + 0;
		end
	end
	return v138;
end
local function v82(v139, v140)
	if not v140 then
		v140 = v8;
	end
	local v141 = 0 - 0;
	local v142 = 1747 - (760 + 987);
	local v143 = 1913 - (1789 + 124);
	if (v139 == v26.RipDebuff) then
		v141 = (770 - (745 + 21)) + (v60 * (2 + 2));
		v142 = 85.2 - 54;
		v143 = v139:TickTime();
	else
		v141 = v139:BaseDuration();
		v142 = v139:MaxDuration();
		v143 = v139:TickTime();
	end
	local v144 = v140:DebuffTicksRemain(v139);
	local v145 = v140:DebuffRemains(v139);
	local v146 = v141 + v145;
	if (v146 > v142) then
		v146 = v142;
	end
	local v147 = v146 / v143;
	if not v144 then
		v144 = 0 - 0;
	end
	local v148 = v147 - v144;
	return v148;
end
local function v83(v149)
	if not v149 then
		return 0 + 0;
	end
	local v150 = 0 + 0;
	local v151 = nil;
	for v180, v181 in pairs(v149) do
		local v182 = v181:TimeToDie();
		if (v182 > v150) then
			v150 = v182;
			v151 = v181;
		end
	end
	return v150, v151;
end
local function v84(v152)
	return ((1056 - (87 + 968)) + v152:DebuffStack(v26.AdaptiveSwarmDebuff)) * v18(v152:DebuffStack(v26.AdaptiveSwarmDebuff) < (13 - 10)) * v152:TimeToDie();
end
local function v85(v153)
	return v153:DebuffRemains(v26.BloodseekerVinesDebuff);
end
local function v86(v154)
	return v82(v26.LIMoonfireDebuff, v154);
end
local function v87(v155)
	return v82(v26.RakeDebuff, v155);
end
local function v88(v156)
	return v18(v156:DebuffRefreshable(v26.RakeDebuff)) + v18(v6:PMultiplier(v26.Rake) > v156:PMultiplier(v26.Rake));
end
local function v89(v157)
	return v157:TimeToDie();
end
local function v90(v158)
	return (v158:DebuffStack(v26.AdaptiveSwarmDebuff) < (3 + 0)) and v158:DebuffUp(v26.RipDebuff);
end
local function v91(v159)
	return not (v53 or v79(v26.Swipe)) and ((v26.BrutalSlash:FullRechargeTime() < (8 - 4)) or (v159:TimeToDie() < (1417 - (447 + 966))) or (v66 < (10 - 6)));
end
local function v92(v160)
	return v160:DebuffRefreshable(v26.LIMoonfireDebuff);
end
local function v93(v161)
	return ((v161:DebuffRemains(v26.RipDebuff) < (1823.5 - (1703 + 114))) and v6:BuffDown(v62)) or v161:DebuffRefreshable(v26.RipDebuff) or (not v26.RampantFerocity:IsAvailable() and (((v70 > (702 - (376 + 325))) and v161:DebuffDown(v26.BloodseekerVinesDebuff) and v6:BuffDown(v26.RavageBuffFeral)) or (v70 > ((9 - 3) + v18(v26.Ravage:IsAvailable())))));
end
local function v94(v162)
	return v162:DebuffRefreshable(v26.RakeDebuff);
end
local function v95(v163)
	return (v163:DebuffStack(v26.AdaptiveSwarmDebuff) < (8 - 5)) and (v163:DebuffDown(v26.AdaptiveSwarmDebuff) or (v163:DebuffRemains(v26.AdaptiveSwarmDebuff) < (1 + 1))) and (v163:DebuffUp(v26.RipDebuff) or (v6:HeroTreeID() == (46 - 25)));
end
local function v96(v164)
	return v164:DebuffRefreshable(v26.LIMoonfireDebuff);
end
local function v97(v165)
	return v165:DebuffDown(v26.RakeDebuff);
end
local function v98(v166)
	return v166:DebuffRefreshable(v26.RakeDebuff);
end
local function v99(v167)
	return v167:PMultiplier(v26.Rake) < (15.6 - (9 + 5));
end
local function v100(v168)
	return v168:DebuffRefreshable(v26.RipDebuff);
end
local function v101(v169)
	return v169:DebuffRefreshable(v26.RipDebuff) and (v6:BuffUp(v26.TigersFury) or (v169:DebuffRemains(v26.RipDebuff) < v26.TigersFury:CooldownRemains()) or not IsTigersFury) and ((v169:DebuffRemains(v26.RipDebuff) < v66) or ((v169:DebuffRemains(v26.RipDebuff) < (380 - (85 + 291))) and v6:BuffUp(v26.RavageBuffFeral)));
end
local v102;
local function v103(v170)
	return (v102 and v25.Feral_TTD.IgnoreWhenBoss) or v23.Buggedmobs[v8:NPCID()] or (v23.ISSolo() and v25.Feral_TTD.IgnoreWhenSolo) or (v170 == (1265 - (243 + 1022))) or ((v66 >= v170) and (v66 < (29592 - 21815)));
end
local function v104(v171)
	return (v171 ~= "Not Used") and ((((v171 == "with Cooldowns") or ((v171 == "small CDs") and v25.Feral_CDUSE.smallcdswithCooldowns) or (v171 == "with Cooldowns or AoE") or (v171 == "on Enemycount or Cooldowns") or (v171 == "on Boss or with Cooldowns")) and v14()) or (v171 == "always") or (((v171 == "on Boss only") or (v171 == "on Boss or on Enemycount") or (v171 == "on Boss or with Cooldowns")) and (v102 or v8:IsDummy())) or ((v171 == "with Bloodlust only") and v6:BloodlustUp()) or ((v171 == "small CDs") and Smallcds) or (((v171 == "on AOE") or (v171 == "with Cooldowns or AoE")) and (v70 >= (2 + 0))) or (((v171 == "on Enemycount or Cooldowns") or (v171 == "on Enemycount") or (v171 == "on Boss or on Enemycount")) and (v70 >= v25.Feral_CDUSE.Enemycount)));
end
local function v105()
	return v27.ManicGrieftorch:IsEquipped() and (v27.ManicGrieftorch:CooldownUp() or (v27.ManicGrieftorch:CooldownRemains() <= v6:GCDRemains()));
end
local function v106()
	return v27.AlgetharPuzzleBox:IsEquipped() and (v27.AlgetharPuzzleBox:CooldownUp() or (v27.AlgetharPuzzleBox:CooldownRemains() <= v6:GCDRemains()));
end
local function v107(v172)
	return v172:NPCID() == (205740 - (1123 + 57));
end
local function v108(v173)
	return v173:CastSpellID() == (332622 + 76183);
end
local function v109()
	return v6:ChannelSpellID() == (391782 - (163 + 91));
end
local function v110()
	if (v26.Regrowth:IsReady() and v6:BuffUp(v26.PredatorySwiftnessBuff) and (v6:HealthPercentage() <= v25.Feral.Defensives.RegrowthHP) and not v6:PrevGCDP(1931 - (1869 + 61), v26.Regrowth)) then
		if v15(v26.Regrowth) then
			return "regrowth";
		end
	end
	if (v26.Renewal:IsCastable() and v6:AffectingCombat() and (v6:HealthPercentage() <= v25.Feral.Defensives.RenewalHP)) then
		if v15(v26.Renewal) then
			return "renewal";
		end
	end
	if (v26.Barkskin:IsCastable() and v6:AffectingCombat() and (v6:HealthPercentage() <= v25.Feral.Defensives.BarkskinHP)) then
		if v15(v26.Barkskin) then
			return "barkskin";
		end
	end
	if (v26.NaturesVigil:IsCastable() and v6:AffectingCombat() and not v109() and v63 and (v25.Feral.Defensives.NaturesVigilCount ~= (0 + 0)) and (not v25.Feral.Defensives.NaturesVigilHP ~= (0 - 0)) and v23.AoELogicWithCount(v25.Feral.Defensives.NaturesVigilHP, v25.Feral.Defensives.NaturesVigilCount, nil, UnitsIn40Yards)) then
		if v15(v26.NaturesVigil) then
			return "NaturesVigil";
		end
	end
	if (v26.Swiftmend:IsCastable() and v6:AffectingCombat() and (v6:HealthPercentage() <= v25.Feral.Defensives.SwiftmendHP)) then
		if v15(v26.Swiftmend) then
			return "Swiftmend";
		end
	end
	if (v26.SurvivalInstincts:IsCastable() and v6:AffectingCombat() and (v6:HealthPercentage() <= v25.Feral.Defensives.SurvivalInstinctsHP)) then
		if v15(v26.SurvivalInstincts) then
			return "SurvivalInstincts";
		end
	end
	if (v26.FrenziedRegeneration:IsCastable() and (v6:BuffUp(v26.BearForm) or (v26.EmpoweredShapeshifting:IsAvailable() and (v6:Energy() >= (61 - 21)))) and (v6:HealthPercentage() <= v25.Feral.Defensives.FrenziedRegenerationHP)) then
		if v15(v26.FrenziedRegeneration) then
			return "FrenziedRegeneration";
		end
	end
	if (v26.Ironfur:IsCastable() and v6:BuffUp(v26.BearForm) and v6:BuffDown(v26.Ironfur) and (v6:Rage() >= (6 + 34)) and (v6:HealthPercentage() <= v25.Feral.Defensives.IronfurHP)) then
		if v15(v26.Ironfur) then
			return "Ironfur";
		end
	end
	if (v26.BearForm:IsCastable() and v6:AffectingCombat() and v6:BuffUp(v26.CatForm) and (v6:HealthPercentage() <= v25.Feral.Defensives.BearFormHP)) then
		if v15(v26.BearForm) then
			return "BearForm";
		end
	end
	if (v26.CatForm:IsCastable() and v6:BuffUp(v26.BearForm) and (v6:HealthPercentage() > v25.Feral.Defensives.CatFormHP) and (v25.Feral.Defensives.CatFormHP > (0 - 0))) then
		if v15(v26.CatForm) then
			return "CatForm";
		end
	end
end
local function v111()
	if (v26.CatForm:IsCastable() and v6:BuffDown(v26.TravelFormBuff) and v6:BuffDown(v26.BearForm)) then
		if v15(v26.CatForm) then
			return "cat_form precombat 2";
		end
	end
	if (v26.Prowl:IsReady() and ProwlToggle and v6:BuffDown(v26.BearForm) and (v71 > (1 + 0))) then
		if v15(v26.Prowlcast, true) then
			return "prowl precombat 4";
		end
	end
	if (v26.Rake:IsReady() and v63) then
		if v15(v26.Rake) then
			return "rake precombat 8";
		end
	end
end
local function v112()
	v50 = v53;
	if (v26.Prowl:IsReady() and ProwlToggle and v63 and not v23.ISSolo() and not v6:StealthUp(false, true) and (v6:Energy() >= (1509 - (1329 + 145))) and v6:BuffDown(v26.SuddenAmbushBuff) and ((v8:DebuffRefreshable(v26.RakeDebuff) or (v8:PMultiplier(v26.Rake) < (972.4 - (140 + 831)))) * v18(not (v53 and v79(v26.Rake)))) and v6:BuffUp(v26.TigersFury)) then
		if v15(v26.Prowlcast) then
			return "prowl builder 1";
		end
	end
	if (v26.Shadowmeld:IsCastable() and IsRacials and v63 and not v23.ISSolo() and not v6:StealthUp(false, true) and (v6:Energy() >= (1885 - (1409 + 441))) and v6:BuffDown(v26.SuddenAmbushBuff) and (v8:DebuffRefreshable(v26.RakeDebuff) or (v8:PMultiplier(v26.Rake) < (719.4 - (15 + 703)))) and not (v53 and v79(v26.Rake)) and v6:BuffUp(v26.TigersFury)) then
		if v15(v26.Shadowmeld, true) then
			return "shadowmeld builder 2";
		end
	end
	if (v26.Rake:IsReady() and v63 and ((v8:DebuffRefreshable(v26.RakeDebuff) and (v6:PMultiplier(v26.Rake) >= v8:PMultiplier(v26.Rake))) or (v8:DebuffRemains(v26.RakeDebuff) < (2.5 + 1)) or (v6:BuffUp(v26.SuddenAmbushBuff) and (v6:PMultiplier(v26.Rake) > v8:PMultiplier(v26.Rake)))) and not (v53 and v79(v26.Rake))) then
		if v15(v26.Rake) then
			return "rake builder 4";
		end
	end
	if (v26.BrutalSlash:IsReady() and v64 and (v26.BrutalSlash:FullRechargeTime() < (442 - (262 + 176))) and not (v53 and v79(v26.Swipe))) then
		if v15(v26.BrutalSlash) then
			return "brutal_slash builder 6";
		end
	end
	if (v26.LIMoonfire:IsReady() and v8:IsInRange(1761 - (345 + 1376)) and (v8:DebuffRefreshable(v26.LIMoonfireDebuff))) then
		if v15(v26.LIMoonfire) then
			return "moonfire_cat builder 8";
		end
	end
	if (v26.ThrashCat:IsCastable() and v64 and v8:DebuffRefreshable(v26.ThrashCatDebuff) and not v26.ThrashingClaws:IsAvailable()) then
		if v15(v26.Thrashcast) then
			return "thrash builder 10";
		end
	end
	if (v26.Shred:IsReady() and v63 and v6:BuffUp(v26.Clearcasting) and not (v53 and v79(v26.Shred))) then
		if v15(v26.Shred) then
			return "shred builder 12";
		end
	end
	if (v26.BrutalSlash:IsReady() and v64 and not (v53 and v79(v26.Swipe))) then
		if v15(v26.BrutalSlash) then
			return "brutal_slash builder 14";
		end
	end
	if (v26.Swipe:IsReady() and v64 and v26.WildSlashes:IsAvailable() and not (v53 and v79(v26.Swipe))) then
		if v15(v26.Swipecast) then
			return "swipe builder 16";
		end
	end
	if (v26.LIMoonfire:IsReady() and v8:IsInRange(728 - (198 + 490)) and not (v53 and v79(v26.LIMoonfire)) and not (v59 and v6:BuffDown(v26.TigersFury))) then
		if v15(v26.LIMoonfire) then
			return "moonfire_cat builder 17";
		end
	end
	if (v26.Shred:IsReady() and v63 and not (v53 and v79(v26.Shred))) then
		if v15(v26.Shred) then
			return "shred builder 18";
		end
	end
	if (v26.Swipe:IsReady() and v64 and v53 and v80(v26.Swipe)) then
		if v15(v26.Swipecast) then
			return "swipe builder 20";
		end
	end
	if (v26.Rake:IsReady() and v63 and v53 and v80(v26.Rake) and (v6:PMultiplier(v26.Rake) >= v8:PMultiplier(v26.Rake))) then
		if v15(v26.Rake) then
			return "rake builder 22";
		end
	end
	if (v26.LIMoonfire:IsReady() and v8:IsInRange(176 - 136) and v53 and v80(v26.LIMoonfire)) then
		if v15(v26.LIMoonfire) then
			return "moonfire_cat builder 24";
		end
	end
	if (v26.ThrashCat:IsCastable() and v64 and v53 and v80(v26.ThrashCat)) then
		if v15(v26.Thrashcast) then
			return "thrash builder 26";
		end
	end
end
local function v113()
	if (v26.PrimalWrath:IsReady() and v64 and (v70 > (2 - 1)) and v13() and (((v8:DebuffRemains(v26.RipDebuff) < (1212.5 - (696 + 510))) and v6:BuffDown(v62)) or v8:DebuffRefreshable(v26.RipDebuff) or (not v26.RampantFerocity:IsAvailable() and (((v70 > (1 - 0)) and v8:DebuffDown(v26.BloodseekerVinesDebuff) and v6:BuffDown(v26.RavageBuffFeral)) or (v70 > ((1268 - (1091 + 171)) + v18(v26.Ravage:IsAvailable()))))) or (v8:PMultiplier(v26.Rip) < v6:PMultiplier(v26.Rip)))) then
		if v15(v26.PrimalWrath) then
			return "primal_wrath finisher 2";
		end
	end
	if (v26.Rip:IsReady() and (not v26.PrimalWrath:IsAvailable() or (v68 == (1 + 0))) and (v6:BuffUp(v26.BloodtalonsBuff) or not v26.Bloodtalons:IsAvailable())) then
		if v23.CastCycle(v26.Rip, v67, v101, 25 - 17, nil, nil, v25.Feral.AutoTabDot) then
			return "rip finisher 4";
		end
	end
	if (BiteFinisher:IsReady() and v63 and (v6:BuffDown(v62))) then
		if v16(BiteFinisher, v6:EnergyTimeToX(165 - 115)) then
			return "ferocious_bite finisher 6";
		end
	end
	if (BiteFinisher:IsReady() and (v6:HeroTreeID() == (396 - (123 + 251)))) then
		if v23.CastTargetIf(BiteFinisher, v67, "max", v85, nil, 24 - 19, nil, nil, false) then
			return "ferocious_bite finisher 8";
		end
	end
	if (BiteFinisher:IsReady() and v63 and (v6:HeroTreeID() ~= (720 - (208 + 490)))) then
		if v15(BiteFinisher) then
			return "ferocious_bite finisher (non-WS) 10";
		end
	end
end
local function v114()
	v50 = v53;
	if (v26.ThrashCat:IsReady() and v64 and v8:DebuffRefreshable(v26.ThrashCatDebuff) and not v26.ThrashingClaws:IsAvailable() and not (v53 and v79(v26.ThrashCat))) then
		if v15(v26.Thrashcast) then
			return "thrash aoe_builder 2";
		end
	end
	if (v26.BrutalSlash:IsReady() and v64 and ((v26.BrutalSlash:FullRechargeTime() < (1 + 3)) or (v66 < (2 + 2)) or (v6:BuffUp(v62) and (v70 >= ((839 - (660 + 176)) - v18(v6:HeroTreeID() == (3 + 18)))))) and not (v53 and v79(v26.Swipe) and (v6:BuffDown(v62) or (v70 < ((205 - (14 + 188)) - v18(v6:HeroTreeID() == (696 - (534 + 141)))))))) then
		if v15(v26.BrutalSlash) then
			return "brutal_slash aoe_builder 4";
		end
	end
	if (v26.Swipe:IsReady() and v64 and ((v66 < (2 + 2)) or (v26.WildSlashes:IsAvailable() and (v70 > (4 + 0)) and not (v53 and v79(v26.Swipe))))) then
		if v15(v26.Swipecast) then
			return "swipe aoe_builder 6";
		end
	end
	if (v26.Prowl:IsReady() and ProwlToggle and not v23:ISSolo() and v63 and not v6:StealthUp(false, true) and not (v53 and v79(v26.Rake)) and v26.Rake:IsReady() and v6:BuffDown(v26.SuddenAmbushBuff) and not VarCCCapped and (v78(v67, v26.RakeDebuff) or (v8:PMultiplier(v26.Rake) < (1.4 + 0)))) then
		if v15(v26.Prowlcast) then
			return "prowl aoe_builder 8";
		end
	end
	if (v26.Shadowmeld:IsReady() and not v23:ISSolo() and IsRacials and v63 and not v6:StealthUp(false, true) and not (v53 and v79(v26.Rake)) and v26.Rake:IsReady() and v6:BuffDown(v26.SuddenAmbushBuff) and v6:BuffDown(v26.Prowl) and not VarCCCapped and (v78(v67, v26.RakeDebuff) or (v8:PMultiplier(v26.Rake) < (1.4 - 0)))) then
		if v15(v26.Shadowmeld, true) then
			return "shadowmeld aoe_builder 10";
		end
	end
	if (v26.Rake:IsReady() and v26.DoubleClawedRake:IsAvailable() and not (v53 and v79(v26.Rake)) and not VarCCCapped) then
		if v23.CastCycle(v26.Rake, v67, v98, 7 - 2, nil, nil, v25.Feral.AutoTabDot) then
			return "rake aoe_builder 12";
		end
	end
	if (v26.Swipe:IsReady() and v64 and v26.WildSlashes:IsAvailable() and (v70 > (8 - 5)) and not (v53 and v79(v26.Swipe))) then
		if v15(v26.Swipecast) then
			return "swipe aoe_builder 14";
		end
	end
	if (v26.LIMoonfire:IsReady() and not (v53 and v79(v26.LIMoonfireDebuff)) and not VarCCCapped) then
		if v23.CastCycle(v26.LIMoonfire, v69, v96, 22 + 18) then
			return "moonfire_cat aoe_builder 16";
		end
	end
	if (v26.Rake:IsReady() and v26.DoubleClawedRake:IsAvailable() and not (v53 and v79(v26.Rake)) and not VarCCCapped) then
		if v23.CastCycle(v26.Rake, v67, v98, 4 + 1, nil, nil, v25.Feral.AutoTabDot) then
			return "rake aoe_builder 18";
		end
	end
	if (v26.BrutalSlash:IsReady() and v64 and not (v53 and v79(v26.Swipe))) then
		if v15(v26.BrutalSlash) then
			return "brutal_slash aoe_builder 20";
		end
	end
	if (v26.Swipe:IsReady() and v64 and not (v53 and v79(v26.Swipe))) then
		if v15(v26.Swipecast) then
			return "swipe aoe_builder 22";
		end
	end
	if (v26.Shred:IsReady() and v63 and v6:BuffDown(v26.SuddenAmbushBuff) and not (v53 and v79(v26.Shred))) then
		if v15(v26.Shred) then
			return "shred aoe_builder 24";
		end
	end
	if (v26.ThrashCat:IsReady() and v64 and not v26.ThrashingClaws:IsAvailable() and not (v53 and v79(v26.ThrashCat))) then
		if v15(v26.Thrashcast) then
			return "thrash aoe_builder 26";
		end
	end
	if (v26.Rake:IsReady() and v26.DoubleClawedRake:IsAvailable() and v6:BuffUp(v26.SuddenAmbushBuff) and v53 and v80(v26.Rake)) then
		if v23.CastTargetIf(v26.Rake, v69, "max", v87, nil, 401 - (115 + 281), nil, nil, v25.Feral.AutoTabDot) then
			return "rake aoe_builder 28";
		end
	end
	if (v26.LIMoonfire:IsReady() and v53 and v80(v26.LIMoonfire)) then
		if v23.CastTargetIf(v26.LIMoonfire, v69, "max", v86, nil, 93 - 53) then
			return "moonfire_cat aoe_builder 30";
		end
	end
	if (v26.Rake:IsReady() and v6:BuffUp(v26.SuddenAmbushBuff) and v53 and v80(v26.Rake)) then
		if v23.CastTargetIf(v26.Rake, v69, "max", v87, nil, 5 + 0, nil, nil, v25.Feral.AutoTabDot) then
			return "rake aoe_builder 32";
		end
	end
	if (v26.Shred:IsReady() and v63 and v53 and v80(v26.Shred)) then
		if v15(v26.Shred) then
			return "shred aoe_builder 34";
		end
	end
	if (v26.Rake:IsReady() and v53 and v80(v26.Rake)) then
		if v23.CastCycle(v26.Rake, v67, v99, 12 - 7) then
			return "rake aoe_builder 36";
		end
	end
	if (v26.ThrashCat:IsReady() and v64 and v53 and v80(v26.Shred)) then
		if v15(v26.Thrashcast) then
			return "thrash aoe_builder 38";
		end
	end
end
local function v115()
	if v25.Commons.Enabled.Trinkets then
		if (v27.ImperfectAscendancySerum:IsEquippedAndReady() and (((v29:ID() == v27.ImperfectAscendancySerum:ID()) and IsTrinket1) or ((v30:ID() == v27.ImperfectAscendancySerum:ID()) and IsTrinket2)) and (v62:CooldownRemains() <= (3 - 2))) then
			if v15(v27.ImperfectAscendancySerum, true) then
				return "imperfect_ascendancy_serum cooldown 2";
			end
		end
		if (v29:IsReady() and v63 and IsTrinket1 and not v41 and (v29:HasUseBuff() or (v31 == v27.TwinFangInstruments:ID()) or (v31 == v27.SikransEndlessArsenal:ID())) and ((v30:CooldownRemains() > (887 - (550 + 317))) or not v44 or (v30:CooldownDown() and (v26.TigersFury:CooldownRemains() > (28 - 8))))) then
			if v15(v29, true) then
				return "Generic use_item for " .. v29:Name() .. " cooldown 20";
			end
		end
		if (v29:IsReady() and v63 and IsTrinket1 and not v41 and (v31 ~= v27.OvinaxsMercurialEgg:ID()) and not v43 and ((v30:CooldownRemains() > (28 - 8)) or not v44 or (v30:CooldownDown() and (v26.TigersFury:CooldownRemains() > (55 - 35))))) then
			if v15(v29, true) then
				return "Generic use_item for " .. v29:Name() .. " cooldown 21";
			end
		end
		if (v30:IsReady() and v63 and IsTrinket2 and not v42 and (v32 ~= v27.OvinaxsMercurialEgg:ID()) and not v44 and ((v29:CooldownRemains() > (305 - (134 + 151))) or not v43 or (v29:CooldownDown() and (v26.TigersFury:CooldownRemains() > (1685 - (970 + 695)))))) then
			if v15(v30, true) then
				return "Generic use_item for " .. v30:Name() .. " cooldown 22";
			end
		end
		if (v30:IsReady() and v63 and IsTrinket2 and not v42 and (v30:HasUseBuff() or (v32 == v27.TwinFangInstruments:ID()) or (v32 == v27.SikransEndlessArsenal:ID())) and ((v29:CooldownRemains() > (38 - 18)) or not v43 or (v29:CooldownDown() and (v26.TigersFury:CooldownRemains() > (2010 - (582 + 1408)))))) then
			if v15(v30, true) then
				return "Generic use_item for " .. v30:Name() .. " cooldown 23";
			end
		end
	end
	if (v26.Incarnation:IsReady() and IsIncarnation and v63) then
		if v15(v26.Incarnation, true) then
			return "incarnation cooldown 4";
		end
	end
	if (v26.Berserk:IsReady() and IsIncarnation and v63 and v6:BuffUp(v26.TigersFury) and ((v8:TimeToDie() > (41 - 29)) or (v8:TimeToDie() == v66))) then
		if v15(v26.Berserk, true) then
			return "berserk cooldown 6";
		end
	end
	if (v26.Berserking:IsCastable() and v63 and IsRacials and (v6:BuffUp(v62))) then
		if v15(v26.Berserking, true) then
			return "berserking cooldown 8";
		end
	end
	if (v25.Commons.Enabled.Potions and IsPotions and (v6:BuffUp(v62) or (v66 < (39 - 7)) or (not v55 and v54 and (v26.ConvoketheSpirits:CooldownRemains() < (37 - 27))))) then
		local v183 = v23.PotionSelected();
		if (v183 and v183:IsReady()) then
			v12.CastMacro(1827 - (1195 + 629), nil, nil, v183);
			return "Cast Potion";
		end
	end
	if v25.Commons.Enabled.Items then
		local v184, v185, v186 = v6:GetUseableItems(v28, 20 - 4);
		if (v184 and v184:IsReady() and v8:IsInRange(v186) and IsDjaruun) then
			v12.CastMacro(242 - (187 + 54), nil, nil, v184);
			return "Generic use_item for " .. v184:Name() .. " cooldown 12";
		end
	end
	if v25.Commons.Enabled.Trinkets then
		if (v29:IsReady() and v63 and IsTrinket1 and not v41 and ((v43 and (v6:BuffUp(v62) or (v6:BuffUp(v26.TigersFury) and (v26.TigersFury:CooldownRemains() > (800 - (162 + 618))) and ((v26.ConvoketheSpirits:CooldownRemains() < (3 + 1)) or (v26.ConvoketheSpirits:CooldownRemains() > (30 + 15)) or (v44 and ((v26.ConvoketheSpirits:CooldownRemains() - v30:CooldownRemains()) > (0 - 0))) or (not v26.ConvoketheSpirits:IsAvailable() and ((v62:CooldownRemains() > (67 - 27)) or ((v62:CooldownRemains() - v30:CooldownRemains()) > (0 + 0))))))) and (not v30:HasCooldown() or v30:CooldownDown() or (v49 == (1637 - (1373 + 263))))) or (v45 >= v66))) then
			if v15(v29, true) then
				return "Generic use_item for " .. v29:Name() .. " cooldown 16";
			end
		end
		if (v30:IsReady() and v63 and IsTrinket2 and not v42 and ((v44 and (v6:BuffUp(v62) or (v6:BuffUp(v26.TigersFury) and (v26.TigersFury:CooldownRemains() > (1020 - (451 + 549))) and ((v26.ConvoketheSpirits:CooldownRemains() < (2 + 2)) or (v26.ConvoketheSpirits:CooldownRemains() > (70 - 25)) or (v43 and ((v26.ConvoketheSpirits:CooldownRemains() - v29:CooldownRemains()) > (0 - 0))) or (not v26.ConvoketheSpirits:IsAvailable() and ((v62:CooldownRemains() > (1424 - (746 + 638))) or ((v62:CooldownRemains() - v29:CooldownRemains()) > (0 + 0))))))) and (not v29:HasCooldown() or v29:CooldownDown() or (v49 == (2 - 0)))) or (v46 >= v66))) then
			if v15(v30, true) then
				return "Generic use_item for " .. v30:Name() .. " cooldown 18";
			end
		end
	end
	if (v26.FeralFrenzy:IsReady() and v63 and IsFeralFrenzy and ((v60 <= (342 - (218 + 123))) or (v6:BuffUp(v62) and (v60 <= (1583 - (1535 + 46)))))) then
		if v15(v26.FeralFrenzy, true) then
			return "feral_frenzy cooldown 24";
		end
	end
	if (v26.ConvoketheSpirits:IsCastable() and v63 and IsConvoketheSpirits and ((v65 < (5 + 0)) or (((v62:CooldownRemains() > (7 + 38)) or v6:BuffUp(v62) or not v26.BerserkHeartoftheLion:IsAvailable()) and v6:BuffUp(v26.TigersFury) and ((v60 <= (564 - (306 + 254))) or (v6:BuffUp(v62) and (v60 <= (1 + 2)))) and ((v8:TimeToDie() > ((9 - 4) - v18(v26.AshamanesGuidance:IsAvailable()))) or (v8:TimeToDie() == v66))))) then
		if v15(v26.ConvoketheSpirits) then
			return "convoke_the_spirits cooldown 26";
		end
	end
end
local function v116()
	v51 = v6:Energy() + ((1507 - (899 + 568)) * v6:BuffStack(v26.Clearcasting)) + ((2 + 1) * v6:EnergyRegen()) + ((120 - 70) * v18(v26.TigersFury:CooldownRemains() < (606.5 - (268 + 335))));
	v52 = (((405 - (60 + 230)) - v51) - ((595 - (426 + 146)) * v18(v6:BuffUp(v26.Incarnation)))) / v6:EnergyRegen();
	v53 = v26.Bloodtalons:IsAvailable() and (v6:BuffStack(v26.BloodtalonsBuff) <= (1 + 0));
	VarCCCapped = v6:BuffStack(v26.Clearcasting) == ((1457 - (282 + 1174)) + v18(v26.MomentofClarity:IsAvailable()));
	v54 = ((v26.ConvoketheSpirits:CooldownRemains() + (931 - (569 + 242))) > v66) and (v26.ConvoketheSpirits:CooldownRemains() < v66);
	v55 = ((v62:CooldownRemains() + (532 - 347)) > v66) and (v62:CooldownRemains() < v66);
	local v174 = nil;
	local v175 = 0 + 0;
	if v25.Commons.Enabled.Potions then
		v174 = v23.PotionSelected();
		if v174 then
			v175 = v174:CooldownRemains();
		end
	end
	v56 = false;
	if v174 then
		v56 = ((v175 + (1339 - (706 + 318))) > v66) and ((v175 + (1266 - (721 + 530))) < v66);
	end
	v59 = v6:PrevGCD(1272 - (945 + 326), v26.LIMoonfire) and v6:BuffUp(v26.TigersFury);
end
local function v117()
	if v6:IsChanneling(v27.ManicGrieftorch.ItemUseSpell) then
		return "Dont cut Torch";
	end
	InterruptToggle = v12.ToggleIconFrame:GetToggle(2 - 1);
	DispelToggle = v12.ToggleIconFrame:GetToggle(2 + 0);
	Smallcds = v12.ToggleIconFrame:GetToggle(703 - (271 + 429));
	ProwlToggle = v12.ToggleIconFrame:GetToggle(4 + 0);
	UnitsIn40Yards = v23.UnitsinRange(v26.Regrowth);
	v67 = v6:GetEnemiesInMeleeRange(1505 - (1408 + 92));
	v69 = v6:GetEnemiesInMeleeRange(1094 - (461 + 625));
	Enemies20y = v6:GetEnemiesInMeleeRange(1308 - (993 + 295));
	if v13() then
		v68 = #v67;
		v70 = #v69;
		v71 = #Enemies20y;
	else
		v68 = 1 + 0;
		v70 = 1172 - (418 + 753);
		v71 = 1 + 0;
	end
	local v176 = v106() and (((v29:ID() == v27.AlgetharPuzzleBox:ID()) and IsTrinket1) or ((v30:ID() == v27.AlgetharPuzzleBox:ID()) and IsTrinket2));
	IsRacials = v103(v25.Feral_TTD.RacialsTTD) and v104(v25.Feral_CDUSE.Racials);
	IsPotions = v103(v25.Feral_TTD.PotionsTTD) and (v25.Feral_CDUSE.Potionswhensolo or (not v25.Feral_CDUSE.Potionswhensolo and not v23.ISSolo())) and v104(v25.Feral_CDUSE.Potions);
	IsTrinket1 = v103(v25.Feral_TTD.TrinketsTTD) and v104(v25.Feral_CDUSE.Trinket1);
	IsTrinket2 = v103(v25.Feral_TTD.TrinketsTTD) and v104(v25.Feral_CDUSE.Trinket2);
	IsIncarnation = not v176 and v103(v25.Feral_TTD.IncarnationTTD) and v104(v25.Feral_CDUSE.Incarnation);
	IsFeralFrenzy = v103(v25.Feral_TTD.FeralFrenzyTTD) and v104(v25.Feral_CDUSE.FeralFrenzy);
	IsAdaptiveSwarm = v104(v25.Feral_CDUSE.AdaptiveSwarm);
	IsConvoketheSpirits = not v176 and v103(v25.Feral_TTD.ConvoketheSpiritsTTD) and v104(v25.Feral_CDUSE.ConvoketheSpirits);
	IsTigersFury = v103(v25.Feral_TTD.TigersFuryTTD) and v104(v25.Feral_CDUSE.TigersFury);
	IsDjaruun = v104(v25.Feral_CDUSE.Djaruun);
	if (v23.TargetIsValid() or v6:AffectingCombat()) then
		v65 = v3.BossFightRemains();
		v102 = true;
		v66 = v65;
		if (v66 == (1146 + 9965)) then
			v102 = false;
			v66 = v3.FightRemains(v69, false);
		end
		v60 = v6:ComboPoints();
		v61 = v6:ComboPointsDeficit();
		v63 = v8:IsInRange(2 + 3);
		v64 = v8:IsInRange(3 + 5);
		if (v6:HeroTreeID() == (550 - (406 + 123))) then
			BiteFinisher = (v26.RavageAbilityCat:IsLearned() and v26.RavageAbilityCat) or v26.FerociousBite;
		else
			BiteFinisher = v26.FerociousBite;
		end
	end
	if (v26.MarkoftheWild:IsCastable() and not (v6:StealthUp(false, true)) and not v6:DebuffUp(v26.Corruption) and ((v23.GroupBuffMissing(v26.MarkoftheWildBuff) and (v25.Commons.MarkoftheWild == "check whole group") and (v6:IsInRaidArea() or v6:IsInDungeonArea()) and (v6:InstanceDifficulty() ~= (1974 - (1749 + 20)))) or (v6:BuffDown(v26.MarkoftheWildBuff, true) and ((v25.Commons.MarkoftheWild == "only check us") or (v25.Commons.MarkoftheWild == "check whole group"))))) then
		if v12.CastTarget(v26.MarkoftheWild, v12.TName().PLAYER) then
			return "mark_of_the_wild precombat";
		end
	end
	if (v26.CatForm:IsCastable() and v6:BuffDown(v26.TravelFormBuff) and v6:BuffDown(v26.BearForm) and v25.Feral.ShowCatFormOOC) then
		if v15(v26.CatForm) then
			return "cat_form ooc";
		end
	end
	if not v6:IsMoving() then
		v22 = not v6:IsCasting(v26.Hibernate) and v23.IncorpCycle(v26.Hibernate, 8 + 25, false, false);
		if v22 then
			return v22;
		end
	end
	if DispelToggle then
		v22 = v6:AffectingCombat() and v23.SootheCycle(v26.Soothe, 1367 - (1249 + 73), false, v25.Feral.TabForSoothe);
		if v22 then
			return v22;
		end
		if (v26.RemoveCorruption:IsCastable() and v6:IsInDungeonArea() and v6:IsInParty()) then
			v22 = v23.DispelCycle(v26.RemoveCorruption, "Poison", nil, UnitsIn40Yards);
			if v22 then
				return v22;
			end
			v22 = v23.DispelCycle(v26.RemoveCorruption, "Curse", nil, UnitsIn40Yards);
			if v22 then
				return v22;
			end
		end
	end
	if (v26.Rebirth:IsReady() and not v6:IsCasting(v26.Rebirth) and v6:AffectingCombat() and not v6:IsMoving()) then
		if (v8:UnitIsFriend() and v8:UnitIsPlayer() and v8:Exists() and v8:IsDeadOrGhost()) then
			v12.Cast(v26.Rebirth);
			return "Rebirth on Target";
		end
		if (v17:UnitIsFriend() and v17:UnitIsPlayer() and v17:Exists() and v17:IsDeadOrGhost()) then
			v12.CastTarget(v26.Rebirth, v12.TName().MOUSEOVER);
			return "Rebirth on Mouseover";
		end
	end
	if (v26.Prowl:IsReady() and ProwlToggle and (v6:BuffDown(v62) or not v6:AffectingCombat()) and v6:BuffUp(v26.CatForm) and (v71 > (1 + 0))) then
		if v15(v26.Prowlcast, true) then
			return "prowl main 2";
		end
	end
	v22 = v110();
	if v22 then
		return v22;
	end
	if (v23.TargetIsValid() and v6:BuffDown(v26.TravelFormBuff)) then
		if (not v25.Feral.AttackonlyinCombat or (v25.Feral.AttackonlyinCombat and v8:AffectingCombat())) then
			if not v107(v5.Target) then
				if not v6:AffectingCombat() then
					v22 = v111();
					if v22 then
						return v22;
					end
				end
				if (InterruptToggle and not v109()) then
					v22 = v23.InterruptCycle(v26.SkullBash, 1158 - (466 + 679), true, nil, false);
					if v22 then
						return v22;
					end
					v22 = v23.InterruptCycle(v26.MightyBash, 19 - 11, false, nil, true);
					if v22 then
						return v22;
					end
					v22 = (v60 > (0 - 0)) and v23.InterruptCycle(v26.Maim, 1909 - (106 + 1794), false, nil, true);
					if v22 then
						return v22;
					end
				end
				if (v26.CatForm:IsCastable() and v6:BuffDown(v26.TravelFormBuff) and v6:BuffDown(v26.BearForm)) then
					if v15(v26.CatForm) then
						return "cat_form main 4";
					end
				end
				v116();
				if v6:BuffUp(v26.BearForm) then
					if (v26.ThrashBear:IsCastable() and v64 and v8:DebuffRefreshable(v26.ThrashBearDebuff)) then
						if v15(v26.Thrashcast) then
							return "thrash bear";
						end
					end
					if (v26.Mangle:IsCastable() and v63 and v8:DebuffUp(v26.ThrashBearDebuff)) then
						if v15(v26.Mangle) then
							return "Mangle bear";
						end
					end
					if (v26.BrutalSlash:IsCastable() and v64) then
						if v15(v26.BrutalSlash) then
							return "Brutal Slash bear";
						end
					end
					if (v26.Swipe:IsCastable() and v64) then
						if v15(v26.Swipecast) then
							return "Swipe bear";
						end
					end
					if (v26.ThrashBear:IsCastable() and v64) then
						if v15(v26.Thrashcast) then
							return "thrash bear";
						end
					end
				end
				if v6:BuffUp(v26.CatForm) then
					if (v26.Rake:IsReady() and (v6:StealthUp(false, true))) then
						if v23.CastCycle(v26.Rake, v67, v88, 2 + 3, nil, nil, v25.Feral.AutoTabDot) then
							return "rake main 8";
						end
					end
					if not (v6:StealthUp(false, true)) then
						if (v26.TigersFury:IsCastable() and IsTigersFury and ((v6:EnergyDeficit() > (9 + 26)) or (v60 == (14 - 9)) or ((v60 >= (7 - 4)) and v8:DebuffRefreshable(v26.RipDebuff) and v6:BuffUp(v26.BloodtalonsBuff))) and ((v65 <= (129 - (4 + 110))) or ((v62:CooldownRemains() > (604 - (57 + 527))) and (v8:TimeToDie() > (1432 - (41 + 1386)))) or (v62:CooldownUp() and (v8:TimeToDie() > (115 - (17 + 86)))) or (v8:TimeToDie() == v66))) then
							if v15(v26.TigersFury, true) then
								return "tigers_fury main 6";
							end
						end
						if (v26.AdaptiveSwarm:IsReady() and IsAdaptiveSwarm and not v26.AdaptiveSwarm:InFlight() and ((v70 == (1 + 0)) or not v26.UnbridledSwarm:IsAvailable())) then
							if v23.CastCycle(v26.AdaptiveSwarm, v69, v95, 89 - 49) then
								return "adaptive_swarm main 14";
							end
						end
						if (v26.AdaptiveSwarm:IsReady() and IsAdaptiveSwarm and v6:BuffUp(v26.CatForm) and v26.UnbridledSwarm:IsAvailable() and (v70 > (2 - 1))) then
							if v23.CastTargetIf(v26.AdaptiveSwarm, v69, "max", v84, v90, 206 - (122 + 44)) then
								return "adaptive_swarm main 16";
							end
						end
						if (BiteFinisher:IsReady() and v63 and v6:BuffUp(v26.ApexPredatorsCravingBuff) and not (v53 and (v81() == (2 - 0)))) then
							if v15(BiteFinisher) then
								return "ferocious_bite main 18";
							end
						end
						if v8:DebuffUp(v26.RipDebuff) then
							local v188 = v115();
							if v188 then
								return v188;
							end
						end
						if (v26.Rip:IsReady() and v63 and (v68 == (3 - 2)) and (v6:HeroTreeID() == (18 + 4)) and not (v26.RagingFury:IsAvailable() and v26.Veinripper:IsAvailable()) and (v6:BuffUp(v26.BloodtalonsBuff) or not v26.Bloodtalons:IsAvailable()) and (((v8:DebuffRemains(v26.RipDebuff) < (1 + 4)) and (v6:BuffRemains(v26.TigersFury) > (20 - 10)) and (v60 >= (68 - (30 + 35)))) or ((((v6:BuffRemains(v26.TigersFury) < (3 + 0)) and (v60 == (1262 - (1043 + 214)))) or (v6:BuffRemains(v26.TigersFury) <= (3 - 2))) and v6:BuffUp(v26.TigersFury) and (v60 >= (1215 - (323 + 889))) and (v8:DebuffRemains(v26.RipDebuff) < v26.TigersFury:CooldownRemains())))) then
							if v15(v26.Rip) then
								return "rip main 20";
							end
						end
						if (v60 == (13 - 8)) then
							local v189 = v113();
							if v189 then
								return v189;
							end
						end
						if (((v70 < (582 - (361 + 219))) or not v13) and (v60 < (325 - (53 + 267))) and ((v52 <= (0 + 0)) or not v53 or v50)) then
							local v190 = v112();
							if v190 then
								return v190;
							end
						end
						if ((v70 >= (415 - (15 + 398))) and (v60 < (987 - (18 + 964))) and ((v52 <= (0 - 0)) or not v53 or v50)) then
							local v191 = v114();
							if v191 then
								return v191;
							end
						end
					end
				end
				if true then
					if v12.CastAnnotated(v26.Pool, false, "WAIT") then
						return "Pool Energy";
					end
				end
			end
		end
	end
end
local function v118()
	v12.ResetToggle();
	v25.Feral.Display();
	v26.RipDebuff:RegisterAuraTracking();
	v12:UpdateMacro("macro1", "/use 16");
	v12.ToggleIconFrame:AddButtonCustom("I", 1 + 0, "Interrupt", "interrupt");
	v12.ToggleIconFrame:AddButtonCustom("D", 2 + 0, "Dispel", "dispel");
	v12.ToggleIconFrame:AddButtonCustom("S", 853 - (20 + 830), "smallCDs", "smallcds");
	v12.ToggleIconFrame:AddButtonCustom("P", 4 + 0, "Prowl", "prowl");
	v12.Print("Feral Druid rotation has been updated for patch 11.0.2. Last Update 07.10.2024");
end
v12.SetAPL(229 - (116 + 10), v117, v118);
