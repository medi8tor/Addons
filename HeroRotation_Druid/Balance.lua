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
local v12 = v5.MouseOver;
local v13 = HeroRotation();
local v14 = v13.AoEON;
local v15 = v13.CDsON;
local v16 = v13.Cast;
local v17 = v13.Commons().Everyone.num;
local v18 = v13.Commons().Everyone.bool;
local v19;
local v20 = math.max;
local v21 = C_Timer.After;
local v22 = v9.Druid.Balance;
local v23 = v11.Druid.Balance;
local v24 = {v23.SpymastersWeb:ID()};
local v25 = v13.Commons().Everyone;
local v26 = v13.Commons().Druid;
local v27 = v13.GUISettingsGet();
local v28 = {General=v27.General,Commons=v27.APL.Druid.Commons,Balance=v27.APL.Druid.Balance,Balance_Defensives=v27.APL.Druid.Balance.Defensives,Balance_TTD=v27.APL.Druid.Balance_TTD,Balance_CDUSE=v27.APL.Druid.Balance_CDUSE};
local v29;
local v30;
local v31;
local v32;
local v33, v34;
local v35, v36;
local v37;
local v38;
local v39;
local v40 = (v22.IncarnationTalent:IsAvailable() and v22.Incarnation) or v22.CelestialAlignment;
local v41 = (v22.OrbitalStrike:IsAvailable() and (343 - 223)) or (347 - 167) or (v22.WhirlingStars:IsAvailable() and (206 - 126)) or (799 - (555 + 64));
local v42 = (v22.ElunesGuidance:IsAvailable() and (991 - (857 + 74))) or (688 - (367 + 201));
local v43 = false;
local v44 = (v22.AstralInfluence:IsAvailable() and (972 - (214 + 713))) or (11 + 29);
local v45, v46;
local v47 = 1748 + 9363;
local v48 = 11988 - (282 + 595);
local v49;
local v50, v51;
local v52, v53;
local v54, v55;
local v56, v57;
local v58, v59;
local v60, v61;
local v62, v63;
local v64, v65;
local v66, v67;
local v68;
local v69 = 1637 - (1523 + 114);
local function v70()
	return v6:BuffUp(v22.MoonkinForm) or v6:BuffUp(v22.MoonkinForm2) or v6:BuffUp(v22.MoonkinForm1);
end
local function v71()
	local v97, v98 = v6:GetTrinketData(v24);
	if ((v69 < (5 + 0)) and ((v97.ID == (0 - 0)) or (v98.ID == (1065 - (68 + 997))) or (v97.Level == (1270 - (226 + 1044))) or (v98.Level == (0 - 0)) or ((v97.SpellID > (117 - (32 + 85))) and not v97.Usable) or ((v98.SpellID > (0 + 0)) and not v98.Usable))) then
		v69 = v69 + 1 + 0;
		v21(962 - (892 + 65), function()
			v71();
		end);
		return;
	end
	v50 = v97.Object;
	v51 = v98.Object;
	v52 = v97.ID;
	v53 = v98.ID;
	v54 = v97.Level;
	v55 = v98.Level;
	v56 = v97.Spell;
	v58 = v97.Range;
	v62 = v97.CastTime;
	v57 = v98.Spell;
	v59 = v98.Range;
	v63 = v98.CastTime;
	v64 = v97.Cooldown;
	v65 = v98.Cooldown;
	v66 = v97.Blacklisted;
	v67 = v98.Blacklisted;
	v60 = (v52 == v23.SpymastersWeb:ID()) or (v52 == v23.ImperfectAscendancySerum) or (v52 == v23.TreacherousTransmitter) or (v52 == v23.AberrantSpellforge);
	v61 = (v53 == v23.SpymastersWeb:ID()) or (v53 == v23.ImperfectAscendancySerum) or (v53 == v23.TreacherousTransmitter) or (v52 == v23.AberrantSpellforge);
	local v115 = v17(v50:HasUseBuff() and (v52 ~= v23.OvinaxsMercurialEgg:ID()));
	local v116 = v17(v51:HasUseBuff() and (v53 ~= v23.OvinaxsMercurialEgg:ID())) * (4 - 2);
	v68 = (0 - 0) + v115 + v116;
end
v71();
v3:RegisterForEvent(function()
	v71();
end, "PLAYER_EQUIPMENT_CHANGED");
v3:RegisterForEvent(function()
	v47 = 20397 - 9286;
	v48 = 11461 - (87 + 263);
end, "PLAYER_REGEN_ENABLED");
v3:RegisterForEvent(function()
	v40 = (v22.IncarnationTalent:IsAvailable() and v22.Incarnation) or v22.CelestialAlignment;
	v41 = (v22.OrbitalStrike:IsAvailable() and (300 - (67 + 113))) or (v22.WhirlingStars:IsAvailable() and (59 + 21)) or (441 - 261);
	v42 = (v22.ElunesGuidance:IsAvailable() and (45 + 15)) or (476 - 356);
	v44 = 992 - (802 + 150);
end, "SPELLS_CHANGED", "LEARNED_SPELL_IN_TAB");
local function v72(v117)
	local v118 = 0 - 0;
	if (v117 == v22.Wrath) then
		v118 = 14 - 6;
		if v22.WildSurges:IsAvailable() then
			v118 = v118 + 2 + 0;
		end
		if (v22.SouloftheForest:IsAvailable() and v6:BuffUp(v22.EclipseSolar)) then
			v118 = v118 * (998.6 - (915 + 82));
		end
	elseif (v117 == v22.Starfire) then
		v118 = 28 - 18;
		if v22.WildSurges:IsAvailable() then
			v118 = v118 + 2 + 0;
		end
		if v6:BuffUp(v22.WarriorofEluneBuff) then
			v118 = v118 * (1.4 - 0);
		end
		if (v22.SouloftheForest:IsAvailable() and v6:BuffUp(v22.EclipseLunar)) then
			local v144 = (1188 - (1069 + 118)) + ((0.2 - 0) * v46);
			if (v144 > (1.6 - 0)) then
				v144 = 1.6 + 0;
			end
			v118 = v118 * v144;
		end
	elseif (v117 == v22.Moonfire) then
		v118 = 10 - 4;
		if v22.MoonGuardian:IsAvailable() then
			v118 = v118 + 2 + 0;
		end
	elseif (v117 == v22.Sunfire) then
		v118 = 797 - (368 + 423);
	elseif (v117 == v22.NewMoon) then
		v118 = 31 - 21;
	elseif (v117 == v22.HalfMoon) then
		v118 = 38 - (10 + 8);
	elseif (v117 == v22.FullMoon) then
		v118 = 153 - 113;
	elseif (v117 == v22.ForceofNature) then
		v118 = 462 - (416 + 26);
	end
	return v118;
end
local function v73(v119)
	return v119:DebuffRefreshable(v22.MoonfireDebuff) and ((v119:TimeToDie() - v119:DebuffRemains(v22.MoonfireDebuff)) > (19 - 13)) and (not v22.TreantsoftheMoon:IsAvailable() or ((v46 - v22.MoonfireDebuff:AuraActiveCount()) > (3 + 3)) or ((v22.ForceofNature:CooldownRemains() > (4 - 1)) and v6:BuffDown(v22.HarmonyoftheGroveBuff)));
end
local function v74(v120)
	return (v120:DebuffRemains(v22.MoonfireDebuff) < (441 - (145 + 293))) and (not v22.TreantsoftheMoon:IsAvailable() or ((v22.ForceofNature:CooldownRemains() > (433 - (44 + 386))) and v6:BuffDown(v22.HarmonyoftheGroveBuff)));
end
local function v75(v121)
	return v121:DebuffRefreshable(v22.MoonfireDebuff) and (not v22.TreantsoftheMoon:IsAvailable() or ((v22.ForceofNature:CooldownRemains() > (1489 - (998 + 488))) and v6:BuffDown(v22.HarmonyoftheGroveBuff)));
end
local function v76(v122)
	return v122:DebuffRefreshable(v22.StellarFlareDebuff) and ((v122:TimeToDie() - v122:DebuffRemains(v22.StellarFlareDebuff)) > (3 + 4 + v46));
end
local function v77(v123)
	return v123:DebuffRefreshable(v22.StellarFlareDebuff) and ((v123:TimeToDie() - v123:DebuffRemains(v22.StellarFlareDebuff)) > (6 + 1 + v46));
end
local function v78(v124)
	return v124:DebuffRefreshable(v22.SunfireDebuff) and ((v124:TimeToDie() - v124:DebuffRemains(v22.SunfireDebuff)) > ((778 - (201 + 571)) - (v46 / (1140 - (116 + 1022)))));
end
local function v79(v125)
	return (v125:DebuffRemains(v22.SunfireDebuff) < (12 - 9)) or v125:DebuffRefreshable(v22.SunfireDebuff);
end
local function v80(v126)
	return v126:DebuffRefreshable(v22.SunfireDebuff);
end
local function v81(v127)
	return v127:NPCID() == (120072 + 84488);
end
local function v82(v128)
	return v128:CastSpellID() == (1492420 - 1083615);
end
local function v83()
	return (v12:Exists() or not v28.Balance.CursorCheck) and not v6:IsCameraBusy();
end
local function v84()
	if v25.TargetIsValid() then
		local v139 = 142 - 102;
		local v140 = v6:GetEnemiesInRange(v139);
		local v141 = 859 - (814 + 45);
		for v142, v143 in ipairs(v140) do
			if v143:AffectingCombat() then
				v141 = v141 + (2 - 1);
			end
		end
		v141 = math.max(v141, 1 + 0);
		return v141;
	else
		return #(v6:GetEnemiesInRange(15 + 25));
	end
end
local function v85()
	return v6:ChannelSpellID() == (392413 - (261 + 624));
end
local function v86(v129, v130)
	return (v129:gsub("{(.-)}", v130));
end
local v87;
local function v88(v131)
	return (v131 ~= "Not Used") and ((((v131 == "with Cooldowns") or ((v131 == "small CDs") and v28.Balance_CDUSE.smallcdswithCooldowns) or (v131 == "with Cooldowns or AoE") or (v131 == "on Enemycount or Cooldowns") or (v131 == "on Boss or with Cooldowns")) and v15()) or (v131 == "always") or (((v131 == "on Boss only") or (v131 == "on Boss or on Enemycount") or (v131 == "on Boss or with Cooldowns")) and (v87 or v8:IsDummy())) or ((v131 == "with Bloodlust only") and v6:BloodlustUp()) or ((v131 == "small CDs") and Smallcds) or (((v131 == "on AOE") or (v131 == "with Cooldowns or AoE")) and (v46 >= (3 - 1))) or (((v131 == "on Enemycount or Cooldowns") or (v131 == "on Enemycount") or (v131 == "on Boss or on Enemycount")) and (v46 >= v28.Balance_CDUSE.Enemycount)));
end
local function v89(v132)
	return (v87 and v28.Balance_TTD.IgnoreWhenBoss) or v25.Buggedmobs[v8:NPCID()] or (v25.ISSolo() and v28.Balance_TTD.IgnoreWhenSolo) or (v132 == (1080 - (1020 + 60))) or ((v48 >= v132) and (v48 < (9200 - (630 + 793))));
end
local function v90()
	if (v22.Regrowth:IsCastable() and not v6:IsMoving() and (v6:HealthPercentage() <= v28.Balance.Defensives.RegrowthHP)) then
		if v16(v22.Regrowth) then
			return "regrowth";
		end
	end
	if (v22.Regrowth:IsCastable() and (v6:HealthPercentage() <= v28.Balance.Defensives.RegrowthBloomingHP) and v6:BuffUp(v22.BloomingInfusionBuff)) then
		if v16(v22.Regrowth) then
			return "regrowth";
		end
	end
	if (v22.Renewal:IsCastable() and v6:AffectingCombat() and (v6:HealthPercentage() <= v28.Balance.Defensives.RenewalHP)) then
		if v16(v22.Renewal) then
			return "renewal";
		end
	end
	if (v22.Barkskin:IsCastable() and v6:AffectingCombat() and (v6:HealthPercentage() <= v28.Balance.Defensives.BarkskinHP)) then
		if v16(v22.Barkskin) then
			return "barkskin";
		end
	end
	if (v22.NaturesVigil:IsCastable() and v6:AffectingCombat() and (v28.Balance.Defensives.NaturesVigilCount ~= (0 - 0)) and (v28.Balance.Defensives.NaturesVigilHP ~= (0 - 0)) and v25.AoELogicWithCount(v28.Balance.Defensives.NaturesVigilHP, v28.Balance.Defensives.NaturesVigilCount, nil, v49)) then
		if v16(v22.NaturesVigil) then
			return "NaturesVigil";
		end
	end
	if (v22.Swiftmend:IsCastable() and v6:AffectingCombat() and (v6:HealthPercentage() <= v28.Balance.Defensives.SwiftmendHP)) then
		if v16(v22.Swiftmend) then
			return "Swiftmend";
		end
	end
	if (v22.SurvivalInstincts:IsCastable() and v6:AffectingCombat() and (v6:HealthPercentage() <= v28.Balance.Defensives.SurvivalInstinctsHP)) then
		if v16(v22.SurvivalInstincts) then
			return "SurvivalInstincts";
		end
	end
	if (v22.FrenziedRegeneration:IsCastable() and v6:BuffUp(v22.BearForm) and (v6:HealthPercentage() <= v28.Balance.Defensives.FrenziedRegenerationHP)) then
		if v16(v22.FrenziedRegeneration) then
			return "FrenziedRegeneration";
		end
	end
	if (v22.Ironfur:IsCastable() and v6:BuffUp(v22.BearForm) and v6:BuffDown(v22.Ironfur) and (v6:Rage() >= (16 + 24)) and (v6:HealthPercentage() <= v28.Balance.Defensives.IronfurHP)) then
		if v16(v22.Ironfur) then
			return "Ironfur";
		end
	end
	if (v22.BearForm:IsCastable() and v6:AffectingCombat() and v6:BuffUp(v22.MoonkinForm) and (v6:HealthPercentage() <= v28.Balance.Defensives.BearFormHP)) then
		if v16(v22.BearForm) then
			return "BearForm";
		end
	end
	if (v22.MoonkinForm:IsCastable() and not v70() and v6:BuffUp(v22.BearForm) and (v6:HealthPercentage() > v28.Balance.Defensives.MoonkinFormHP) and (v28.Balance.Defensives.MoonkinFormHP > (0 - 0))) then
		if v16(v22.MoonkinForm) then
			return "MoonkinForm";
		end
	end
end
local function v91()
	if (v22.MoonkinForm:IsCastable() and not v70() and v6:BuffDown(v22.TravelFormBuff) and v6:BuffDown(v22.BearForm) and v6:BuffDown(v22.CatForm) and (not v22.LycarasMeditation:IsAvailable() or not v22.FluidForm:IsAvailable())) then
		if v16(v22.MoonkinForm) then
			return "moonkin_form precombat";
		end
	end
	if (v22.Wrath:IsCastable() and not v6:IsMoving() and not v6:IsCasting(v22.Wrath)) then
		if v16(v22.Wrath) then
			return "wrath precombat 2";
		end
	end
	if (v22.Wrath:IsCastable() and not v6:IsMoving() and ((v6:IsCasting(v22.Wrath) and (v22.Wrath:Count() == (1749 - (760 + 987)))) or (v6:PrevGCD(1914 - (1789 + 124), v22.Wrath) and (v22.Wrath:Count() == (767 - (745 + 21)))))) then
		if v16(v22.Wrath) then
			return "wrath precombat 4";
		end
	end
	if (v22.Starfire:IsCastable() and (not v6:IsMoving() or v6:BuffUp(v22.WarriorofEluneBuff)) and not v22.StellarFlare:IsAvailable() and (v6:HeroTreeID() == (9 + 15))) then
		if v16(v22.Starfire) then
			return "starfire precombat 6";
		end
	end
	if (v22.StellarFlare:IsCastable() and v8:IsSpellInRange(v22.StellarFlare)) then
		if v16(v22.StellarFlare) then
			return "stellar_flare precombat 10";
		end
	end
end
local function v92()
	if (v15() and v22.Berserking:IsCastable() and v31) then
		if v16(v22.Berserking, true) then
			return "berserking pre_cd 4";
		end
	end
	if v28.Commons.Enabled.Trinkets then
		if (v50 and v50:IsReady() and not VarTrinket1Ex and not v6:IsItemBlacklisted(v50) and ((v68 == (2 - 1)) or (v68 == (11 - 8))) and v31) then
			if v16(v50) then
				return "use_items trinket1 (" .. v50:Name() .. ") pre_cd 8";
			end
		end
		if (v51 and v51:IsReady() and not VarTrinket2Ex and not v6:IsItemBlacklisted(v51) and (v68 == (1 + 1)) and v31) then
			if v16(v51) then
				return "use_items trinket2 (" .. v51:Name() .. ") pre_cd 10";
			end
		end
	end
	if (v28.Commons.Enabled.Items and v23.BestinSlotsCaster:IsEquippedAndReady() and (((v6:HeroTreeID() == (19 + 4)) and v6:BuffUp(v22.HarmonyoftheGroveBuff)) or ((v6:HeroTreeID() == (1079 - (87 + 968))) and ((CaInc:FullRechargeTime() > (88 - 68)) or v38)))) then
		if v16(v23.BestinSlotsCaster, nil, true) then
			return "bestinslots pre_cd 12";
		end
	end
end
local function v93()
	if (v22.WarriorofElune:IsCastable() and IsWarriorofElune and (v22.LunarCalling:IsAvailable() or (not v22.LunarCalling:IsAvailable() and (v34 <= (7 + 0))))) then
		if v16(v22.WarriorofElune, true) then
			return "warrior_of_elune st 2";
		end
	end
	if (v22.Wrath:IsCastable() and v44 and v35 and v33 and (v34 < v22.Wrath:CastTime()) and not v31) then
		if v16(v22.Wrath) then
			return "wrath st 4";
		end
	end
	if (v22.Starfire:IsCastable() and v44 and v44 and not v35 and v33 and (v34 < v22.Starfire:CastTime()) and not v31) then
		if v16(v22.Starfire) then
			return "starfire st 6";
		end
	end
	if (v22.Sunfire:IsCastable() and (((v6:HeroTreeID() == (51 - 28)) and v22.ForceofNature:CooldownUp()) or ((v6:HeroTreeID() == (1437 - (447 + 966))) and v31))) then
		if v25.CastCycle(v22.Sunfire, v45, v79, v44) then
			return "sunfire st 2";
		end
	end
	if (v22.Moonfire:IsCastable() and (not v22.ForceofNature:IsAvailable() or (v22.ForceofNature:CooldownRemains() > (13 - 8)) or not IsForceofNature or not v22.TreantsoftheMoon:IsAvailable())) then
		if v25.CastCycle(v22.Moonfire, v45, v74, v44) then
			return "moonfire st 4";
		end
	end
	local v133 = v92();
	if v133 then
		return v133;
	end
	if (v15() and v31) then
		if (v22.CelestialAlignment:IsCastable() and IsIncarnation) then
			if v16(v22.CelestialAlignmentcast, true) then
				return "celestial_alignment st 6";
			end
		end
		if (v22.Incarnation:IsCastable() and IsIncarnation) then
			if v16(v22.Incarnationcast, true) then
				return "celestial_alignment st 8";
			end
		end
	end
	if (v22.Wrath:IsCastable() and v44 and v35 and (not v33 or (v34 < v22.Wrath:CastTime()))) then
		if v16(v22.Wrath) then
			return "wrath st 16";
		end
	end
	if (v22.Starfire:IsCastable() and v44 and not v35 and (not v33 or (v34 < v22.Starfire:CastTime()))) then
		if v16(v22.Starfire, nil, nil, RangeformagicSpells) then
			return "starfire st 18";
		end
	end
	if (v22.Starsurge:IsReady() and v44 and v31 and (v6:AstralPowerDeficit() > (v29 + v72(v22.ForceofNature)))) then
		if v16(v22.Starsurge) then
			return "starsurge st 20";
		end
	end
	if (v22.ForceofNature:IsCastable() and IsForceofNature and (((v40:CooldownRemains() < v6:GCD()) and (not v22.ConvoketheSpirits:IsAvailable() or (v22.ConvoketheSpirits:CooldownRemains() < (v6:GCD() * (1820 - (1703 + 114)))) or (v22.ConvoketheSpirits:CooldownRemains() > v40:FullRechargeTime()) or (v48 < (v22.ConvoketheSpirits:CooldownRemains() + (704 - (376 + 325)))))) or (((v40:FullRechargeTime() + (8 - 3) + ((45 - 30) * v17(v22.ControloftheDream:IsAvailable()))) > (18 + 42)) and (not v22.ConvoketheSpirits:IsAvailable() or ((v22.ConvoketheSpirits:CooldownRemains() + (22 - 12) + ((29 - (9 + 5)) * v17(v22.ControloftheDream:IsAvailable()))) > (436 - (85 + 291))) or (v48 < (v22.ConvoketheSpirits:CooldownRemains() + v42 + (1270 - (243 + 1022))))) and ((v48 > (247 - 182)) or (v48 < (v40:CooldownRemains() + 6 + 1)))) or (v22.WhirlingStars:IsAvailable() and v22.ConvoketheSpirits:IsAvailable() and (v22.ConvoketheSpirits:CooldownRemains() > (1230 - (1123 + 57))) and (v48 > (v22.ConvoketheSpirits:CooldownRemains() + 5 + 1))))) then
		if v16(v22.ForceofNature, true) then
			return "force_of_nature st 22";
		end
	end
	if (v22.FuryofElune:IsCastable() and IsFuryofElune and (((259 - (163 + 91)) + v29) < v6:AstralPowerDeficit())) then
		if v16(v22.FuryofElune, true) then
			return "fury_of_elune st 12";
		end
	end
	if (v22.Starfall:IsReady() and (v6:BuffUp(v22.StarweaversWarp))) then
		if v16(v22.Starfall, true, nil, RangeformagicSpells) then
			return "starfall st 26";
		end
	end
	if (v22.Starsurge:IsReady() and UseSpender and v22.Starlord:IsAvailable() and (v6:BuffStack(v22.StarlordBuff) < (1933 - (1869 + 61)))) then
		if v16(v22.Starsurge) then
			return "starsurge st 14";
		end
	end
	if v22.Sunfire:IsCastable() then
		if v25.CastCycle(v22.Sunfire, v45, v80, v44) then
			return "sunfire st 30";
		end
	end
	if v22.Moonfire:IsCastable() then
		if v25.CastCycle(v22.Moonfire, v45, v75, v44) then
			return "moonfire st 32";
		end
	end
	if v22.StellarFlare:IsCastable() then
		if v25.CastCycle(v22.StellarFlare, v45, v77, v44) then
			return "stellar_flare st 34";
		end
	end
	if (v22.Starsurge:IsReady() and UseSpender and (v22.ConvoketheSpirits:CooldownRemains() < (v6:GCD() * (1 + 1))) and v37) then
		if v16(v22.Starsurge) then
			return "starsurge st 22";
		end
	end
	if (v22.ConvoketheSpirits:IsCastable() and IsConvoketheSpirits and v37) then
		if v16(v22.ConvoketheSpirits) then
			return "convoke_the_spirits st 24";
		end
	end
	if (v22.Starsurge:IsReady() and UseSpender and (((v6:BuffRemains(v22.StarlordBuff) > (14 - 10)) and (v36 >= (4 - 1))) or (v47 < (1 + 3)))) then
		if v16(v22.Starsurge) then
			return "starsurge st 26";
		end
	end
	if (v22.NewMoon:IsCastable() and not v6:IsMoving() and ((v6:AstralPowerDeficit() > (v29 + v72(v22.NewMoon))) or (v47 < (27 - 7)) or (v40:CooldownRemains() > (15 + 0)))) then
		if v16(v22.NewMoon) then
			return "new_moon st 28";
		end
	end
	if (v22.HalfMoon:IsCastable() and not v6:IsMoving() and (((v6:AstralPowerDeficit() > (v29 + v72(v22.HalfMoon))) and ((v6:BuffRemains(v22.EclipseLunar) > v22.HalfMoon:ExecuteTime()) or (v6:BuffRemains(v22.EclipseSolar) > v22.HalfMoon:ExecuteTime()))) or (v47 < (1494 - (1329 + 145))) or (v40:CooldownRemains() > (986 - (140 + 831))))) then
		if v16(v22.HalfMoon) then
			return "half_moon st 30";
		end
	end
	if (v22.FullMoon:IsCastable() and not v6:IsMoving() and (((v6:AstralPowerDeficit() > (v29 + v72(v22.FullMoon))) and ((v6:BuffRemains(v22.EclipseLunar) > v22.FullMoon:ExecuteTime()) or (v6:BuffRemains(v22.EclipseSolar) > v22.FullMoon:ExecuteTime()))) or (v47 < (1870 - (1409 + 441))) or (v40:CooldownRemains() > (733 - (15 + 703))))) then
		if v16(v22.FullMoon) then
			return "full_moon st 32";
		end
	end
	if (v22.Starsurge:IsReady() and UseSpender and (v6:BuffUp(v22.StarweaversWeft) or v6:BuffUp(v22.TouchtheCosmosStarsurge))) then
		if v16(v22.Starsurge) then
			return "starsurge st 34";
		end
	end
	if (v22.Starsurge:IsReady() and UseSpender and (v6:AstralPowerDeficit() < (v29 + v72(v22.Wrath) + ((v72(v22.Starfire) + v29) * (v17(v6:BuffRemains(v22.EclipseSolar) < (v6:GCD() * (2 + 1)))))))) then
		if v16(v22.Starsurge) then
			return "starsurge st 38";
		end
	end
	if (v22.ForceofNature:IsCastable() and IsForceofNature and (v6:HeroTreeID() ~= (461 - (262 + 176)))) then
		if v16(v22.ForceofNature, true) then
			return "force_of_nature st 40";
		end
	end
	if (v22.WildMushroom:IsCastable() and IsWildMushroom and not v6:PrevGCD(1722 - (345 + 1376), v22.WildMushroom) and (v8:DebuffRemains(v22.FungalGrowthDebuff) < (690 - (198 + 490)))) then
		if v16(v22.WildMushroom, true) then
			return "wild_mushroom st 54";
		end
	end
	if (v22.Starfire:IsCastable() and (not v6:IsMoving() or v6:BuffUp(v22.WarriorofEluneBuff)) and (v22.LunarCalling:IsAvailable())) then
		if v16(v22.Starfire) then
			return "starfire st 42";
		end
	end
	if (v22.Wrath:IsCastable() and not v6:IsMoving()) then
		if v16(v22.Wrath) then
			return "wrath st 44";
		end
	end
	if (v6:IsMoving() and v28.Balance.SpamDot) then
		if (v22.Sunfire:IsCastable() and (v46 > (4 - 3))) then
			if v16(v22.Sunfire) then
				return "sunfire moving";
			end
		end
		if v22.Moonfire:IsCastable() then
			if v16(v22.Moonfire) then
				return "moonfire moving";
			end
		end
	end
end
local function v94()
	local v134 = v6:IsInDungeonArea();
	if (v22.Wrath:IsCastable() and v44 and v35 and v33 and (v34 < v22.Wrath:CastTime())) then
		if v16(v22.Wrath) then
			return "wrath aoe 2";
		end
	end
	if (v22.Starfire:IsCastable() and v44 and not v35 and v33 and (v34 < v22.Starfire:CastTime())) then
		if v16(v22.Starfire) then
			return "starfire aoe 4";
		end
	end
	if (v22.Starfall:IsReady() and v44 and (v6:AstralPowerDeficit() <= (v29 + (14 - 8)))) then
		if v16(v22.Starfall, true) then
			return "starfall aoe 6";
		end
	end
	if (v22.Moonfire:IsCastable() and v134) then
		if v25.CastCycle(v22.Moonfire, v45, v73, v44) then
			return "moonfire aoe 2";
		end
	end
	if v22.Sunfire:IsCastable() then
		if v25.CastCycle(v22.Sunfire, v45, v78, v44) then
			return "sunfire aoe 4";
		end
	end
	if (v22.Moonfire:IsCastable() and not v134) then
		if v25.CastCycle(v22.Moonfire, v45, v73, v44) then
			return "moonfire aoe 6";
		end
	end
	if (v22.Wrath:IsCastable() and v44 and v35 and (not v33 or (v34 < v22.Wrath:CastTime()))) then
		if v16(v22.Wrath) then
			return "wrath aoe 14";
		end
	end
	if (v22.Starfire:IsCastable() and v44 and not v35 and (not v33 or (v34 < v22.Starfire:CastTime()))) then
		if v16(v22.Starfire) then
			return "starfire aoe 16";
		end
	end
	if (v22.StellarFlare:IsCastable() and (v46 < ((((1217 - (696 + 510)) - v22.UmbralIntensity:TalentRank()) - ((3 - 1) * v17(v22.AstralSmolder:IsAvailable()))) - v17(v22.LunarCalling:IsAvailable())))) then
		if v25.CastCycle(v22.StellarFlare, v45, v76, v44) then
			return "stellar_flare aoe 8";
		end
	end
	if (v22.ForceofNature:IsCastable() and IsForceofNature and (((v40:CooldownRemains() < v6:GCD()) and (not v33 or (v34 > (1268 - (1091 + 171))))) or ((v34 >= (1 + 2)) and (v40:CooldownRemains() > ((31 - 21) + ((49 - 34) * v17(v22.ControloftheDream:IsAvailable())))) and ((v48 > (439 - (123 + 251))) or (v40:CooldownRemains() > v48))))) then
		if v16(v22.ForceofNature, true) then
			return "force_of_nature aoe 10";
		end
	end
	if (v22.FuryofElune:IsCastable() and IsFuryofElune and v33) then
		if v16(v22.FuryofElune, true) then
			return "fury_of_elune aoe 12";
		end
	end
	local v135 = v92();
	if v135 then
		return v135;
	end
	if (v15() and v31) then
		if (v22.CelestialAlignment:IsCastable() and IsIncarnation) then
			if v16(v22.CelestialAlignmentcast, true) then
				return "celestial_alignment aoe 14";
			end
		end
		if (v22.Incarnation:IsCastable() and IsIncarnation) then
			if v16(v22.Incarnationcast, true) then
				return "celestial_alignment aoe 16";
			end
		end
	end
	if (v22.WarriorofElune:IsCastable() and IsWarriorofElune and ((not v22.LunarCalling:IsAvailable() and (v6:BuffRemains(v22.EclipseSolar) < (34 - 27))) or v22.LunarCalling:IsAvailable())) then
		if v16(v22.WarriorofElune, true) then
			return "warrior_of_elune aoe 18";
		end
	end
	if (v22.Starfire:IsCastable() and (not v6:IsMoving() or v6:BuffUp(v22.WarriorofEluneBuff)) and not v22.LunarCalling:IsAvailable() and (v46 == (699 - (208 + 490))) and ((v6:BuffUp(v22.EclipseSolar) and (v6:BuffRemains(v22.EclipseSolar) < v22.Starfire:CastTime())) or not v33)) then
		if v16(v22.Starfire) then
			return "starfire aoe 20";
		end
	end
	if (v22.Starfall:IsReady() and UseSpender and (v6:BuffUp(v22.StarweaversWarp) or v6:BuffUp(v22.TouchtheCosmosStarfall))) then
		if v16(v22.Starfall) then
			return "starfall aoe 22";
		end
	end
	if (v22.Starsurge:IsReady() and UseSpender and (v6:BuffUp(v22.StarweaversWeft) or v6:BuffUp(v22.TouchtheCosmosStarsurge))) then
		if v16(v22.Starsurge) then
			return "starsurge aoe 24";
		end
	end
	if (v22.Starfall:IsReady() and UseSpender) then
		if v16(v22.Starfall) then
			return "starfall aoe 26";
		end
	end
	if (v22.ConvoketheSpirits:IsCastable() and IsConvoketheSpirits and ((v6:BuffDown(v22.DreamstateBuff) and v6:BuffDown(v22.UmbralEmbraceBuff) and (v46 < (1 + 6))) or (v46 == (1 + 0))) and ((v47 < (841 - (660 + 176))) or ((v38 or (v40:CooldownRemains() > (5 + 35))) and ((v6:HeroTreeID() ~= (236 - (14 + 188))) or v6:BuffUp(v22.HarmonyoftheGroveBuff) or (v22.ForceofNature:CooldownRemains() > (690 - (534 + 141))))))) then
		if v16(v22.ConvoketheSpirits) then
			return "convoke_the_spirits aoe 28";
		end
	end
	if v22.NewMoon:IsCastable() then
		if v16(v22.NewMoon) then
			return "new_moon aoe 30";
		end
	end
	if v22.HalfMoon:IsCastable() then
		if v16(v22.HalfMoon) then
			return "half_moon aoe 32";
		end
	end
	if v22.FullMoon:IsCastable() then
		if v16(v22.FullMoon) then
			return "full_moon aoe 34";
		end
	end
	if (v22.WildMushroom:IsCastable() and IsWildMushroom and not v6:PrevGCD(1 + 0, v22.WildMushroom) and v8:DebuffDown(v22.FungalGrowthDebuff)) then
		if v16(v22.WildMushroom, true) then
			return "wild_mushroom aoe 36";
		end
	end
	if (v22.ForceofNature:IsCastable() and IsForceofNature and (v6:HeroTreeID() ~= (21 + 2))) then
		if v16(v22.ForceofNature, true) then
			return "force_of_nature aoe 48";
		end
	end
	if (v22.Starfire:IsCastable() and (not v6:IsMoving() or v6:BuffUp(v22.WarriorofEluneBuff)) and (v22.LunarCalling:IsAvailable() or (v6:BuffUp(v22.EclipseLunar) and (v46 > (1 + 0))))) then
		if v16(v22.Starfire) then
			return "starfire aoe 38";
		end
	end
	if (v22.Wrath:IsCastable() and not v6:IsMoving()) then
		if v16(v22.Wrath) then
			return "wrath aoe 40";
		end
	end
	if (v6:IsMoving() and v28.Balance.SpamDot) then
		if v22.Sunfire:IsCastable() then
			if v16(v22.Sunfire) then
				return "sunfire moving";
			end
		end
	end
end
local function v95()
	v25.HealthPotions();
	if v25.ShouldStopCastUpdate() then
		v13.CastMacro(12 - 6, true);
		return "Stop Cast For Silence";
	end
	InterruptToggle = v13.ToggleIconFrame:GetToggle(1 - 0);
	DispelToggle = v13.ToggleIconFrame:GetToggle(5 - 3);
	Smallcds = v13.ToggleIconFrame:GetToggle(2 + 1);
	UseSpender = v13.ToggleIconFrame:GetToggle(3 + 1);
	local v136 = not v6:AffectingCombat() or not v8:AffectingCombat() or v8:IsDummy();
	Enemies40Yard = v6:GetEnemiesInRange(436 - (115 + 281));
	EnemiesRangeOOCCount = v84() or #Enemies40Yard;
	v49 = v25.UnitsinRange(v22.Regrowth);
	v45 = v8:GetEnemiesInSplashRange(23 - 13);
	if v14() then
		v46 = (v136 and #Enemies40Yard) or EnemiesRangeOOCCount;
	else
		v46 = 1 + 0;
	end
	IsRacials = v89(v28.Balance_TTD.RacialsTTD) and v88(v28.Balance_CDUSE.Racials);
	IsPotions = v89(v28.Balance_TTD.PotionsTTD) and (v28.Balance_CDUSE.Potionswhensolo or (not v28.Balance_CDUSE.Potionswhensolo and not v25.ISSolo())) and v88(v28.Balance_CDUSE.Potions);
	IsTrinket1 = v89(v28.Balance_TTD.TrinketsTTD) and v88(v28.Balance_CDUSE.Trinket1);
	IsTrinket2 = v89(v28.Balance_TTD.TrinketsTTD) and v88(v28.Balance_CDUSE.Trinket2);
	IsIncarnation = (not v22.OrbitalStrike:IsAvailable() or v83()) and v89(v28.Balance_TTD.IncarnationTTD) and v88(v28.Balance_CDUSE.Incarnation);
	IsWarriorofElune = v89(v28.Balance_TTD.WarriorofEluneTTD) and v88(v28.Balance_CDUSE.WarriorofElune);
	IsForceofNature = v83() and v89(v28.Balance_TTD.ForceofNatureTTD) and v88(v28.Balance_CDUSE.ForceofNature);
	IsWildMushroom = v89(v28.Balance_TTD.WildMushroomTTD) and v88(v28.Balance_CDUSE.WildMushroom);
	IsFuryofElune = v89(v28.Balance_TTD.FuryofEluneTTD) and v88(v28.Balance_CDUSE.FuryofElune);
	IsConvoketheSpirits = v89(v28.Balance_TTD.ConvoketheSpiritsTTD) and v88(v28.Balance_CDUSE.ConvoketheSpirits);
	if (v25.TargetIsValid() or v6:AffectingCombat()) then
		TargetinRange = v8:IsSpellInRange(v22.Wrath);
		v47 = v3.BossFightRemains();
		v87 = true;
		v48 = v47;
		if (v48 == (26852 - 15741)) then
			v87 = false;
			v48 = v3.FightRemains(v45, false);
		end
		v38 = (v22.IncarnationTalent:IsAvailable() and (v6:BuffUp(v22.IncarnationBuff1) or v6:BuffUp(v22.IncarnationBuff2))) or v6:BuffUp(v22.CABuff1) or v6:BuffUp(v22.CABuff2);
		v39 = 0 - 0;
		if v38 then
			v39 = (v22.IncarnationTalent:IsAvailable() and v20(v6:BuffRemains(v22.IncarnationBuff1), v6:BuffRemains(v22.IncarnationBuff2))) or v20(v6:BuffRemains(v22.CABuff1), v6:BuffRemains(v22.CABuff2));
		end
	end
	if (v22.MarkoftheWild:IsCastable() and not v6:DebuffUp(v22.Corruption) and ((v25.GroupBuffMissing(v22.MarkoftheWildBuff) and (v28.Commons.MarkoftheWild == "check whole group") and (v6:IsInRaidArea() or v6:IsInDungeonArea()) and (v6:InstanceDifficulty() ~= (1072 - (550 + 317)))) or (v6:BuffDown(v22.MarkoftheWildBuff, true) and ((v28.Commons.MarkoftheWild == "only check us") or (v28.Commons.MarkoftheWild == "check whole group"))))) then
		if v13.CastTarget(v22.MarkoftheWild, v13.TName().PLAYER) then
			return "mark_of_the_wild precombat";
		end
	end
	if (v22.MoonkinForm:IsCastable() and not v70() and v6:BuffDown(v22.TravelFormBuff) and v6:BuffDown(v22.BearForm) and v6:BuffDown(v22.CatForm) and v28.Balance.ShowMoonkinFormOOC) then
		if v16(v22.MoonkinForm) then
			return "moonkin_form ooc";
		end
	end
	if not v6:IsMoving() then
		v19 = not v6:IsCasting(v22.Hibernate) and v25.IncorpCycle(v22.Hibernate, 50 - 15, false, false);
		if v19 then
			return v19;
		end
	end
	if DispelToggle then
		v19 = v6:AffectingCombat() and v25.SootheCycle(v22.Soothe, 63 - 18, false, v28.Balance.TabForSoothe);
		if v19 then
			return v19;
		end
		if (v22.RemoveCorruption:IsCastable() and v6:IsInDungeonArea() and v6:IsInParty()) then
			v19 = v25.DispelCycle(v22.RemoveCorruption, "Poison", nil, v49);
			if v19 then
				return v19;
			end
			v19 = v25.DispelCycle(v22.RemoveCorruption, "Curse", nil, v49);
			if v19 then
				return v19;
			end
		end
	end
	if (v22.Rebirth:IsReady() and not v6:IsCasting(v22.Rebirth) and v6:AffectingCombat() and not v6:IsMoving()) then
		if (v8:UnitIsFriend() and v8:UnitIsPlayer() and v8:Exists() and v8:IsDeadOrGhost()) then
			v13.Cast(v22.Rebirth);
			return "Rebirth on Target";
		end
		if (v12:UnitIsFriend() and v12:UnitIsPlayer() and v12:Exists() and v12:IsDeadOrGhost()) then
			v13.CastTarget(v22.Rebirth, v13.TName().MOUSEOVER);
			return "Rebirth on Mouseover";
		end
	end
	v19 = v90();
	if v19 then
		return v19;
	end
	if (v25.TargetIsValid() and v6:BuffDown(v22.TravelFormBuff)) then
		if (not v28.Balance.AttackonlyinCombat or (v28.Balance.AttackonlyinCombat and v8:AffectingCombat())) then
			if not v81(v5.Target) then
				if TargetinRange then
					if not v6:AffectingCombat() then
						local v146 = v91();
						if v146 then
							return v146;
						end
					end
					if (InterruptToggle and not v85()) then
						v19 = v25.InterruptCycle(v22.SolarBeam, 111 - 71, true, nil, false);
						if v19 then
							return v19;
						end
						v19 = v25.InterruptCycle(v22.MightyBash, 293 - (134 + 151), false, nil, true);
						if v19 then
							return v19;
						end
					end
					v29 = ((1671 - (970 + 695)) / v6:SpellHaste()) + v17(v22.NaturesBalance:IsAvailable()) + (v17(v22.OrbitBreaker:IsAvailable()) * v17(v22.MoonfireDebuff:AuraActiveCount() > (0 - 0)) * v17(v26.OrbitBreakerStacks > ((2017 - (582 + 1408)) - ((6 - 4) * v17(v6:BuffUp(v22.SolsticeBuff))))) * (29 - 5));
					v30 = v20(v40:CooldownRemains(), v22.ForceofNature:CooldownRemains());
					v31 = ((v47 < (((56 - 41) + ((1829 - (1195 + 629)) * v17(v22.Incarnation:IsAvailable()))) * ((1 - 0) - (v17(v22.WhirlingStars:IsAvailable()) * (241.2 - (187 + 54)))))) or ((v8:TimeToDie() > (790 - (162 + 618))) and ((v6:HeroTreeID() ~= (17 + 6)) or v6:BuffUp(v22.HarmonyoftheGroveBuff)) and (not v22.WhirlingStars:IsAvailable() or not v22.ConvoketheSpirits:IsAvailable() or (v22.ConvoketheSpirits:CooldownRemains() < (v6:GCD() * (2 + 0))) or (v47 < (v22.ConvoketheSpirits:CooldownRemains() + (6 - 3))) or (v22.ConvoketheSpirits:CooldownRemains() > v40:FullRechargeTime())))) and v40:CooldownUp() and not v38;
					v37 = (v47 < (8 - 3)) or ((v38 or (v40:CooldownRemains() > (4 + 36))) and ((v6:HeroTreeID() ~= (1659 - (1373 + 263))) or v6:BuffUp(v22.HarmonyoftheGroveBuff) or (v22.ForceofNature:CooldownRemains() > (1015 - (451 + 549)))));
					v33 = v6:BuffUp(v22.EclipseLunar) or v6:BuffUp(v22.EclipseSolar);
					v34 = v20(v6:BuffRemains(v22.EclipseLunar), v6:BuffRemains(v22.EclipseSolar));
					v35 = v22.LunarCalling:IsAvailable() or (v46 > ((1 + 1) - v17((v22.UmbralIntensity:TalentRank() + v17(v22.SouloftheForest:IsAvailable())) > (1 - 0))));
					v36 = v6:BuffStack(v22.BOATArcaneBuff) + v6:BuffStack(v22.BOATNatureBuff);
					v32 = (not v22.CelestialAlignment:IsAvailable() and not v22.Incarnation:IsAvailable()) or not v15();
					if v28.Commons.Enabled.Trinkets then
						if (v23.AberrantSpellforge:IsEquippedAndReady() and (((v50:ID() == v23.AberrantSpellforge:ID()) and IsTrinket1) or ((v51:ID() == v23.AberrantSpellforge:ID()) and IsTrinket2))) then
							if v16(v23.AberrantSpellforge, true) then
								return "aberrant_spellforge main 2";
							end
						end
						if (v23.SpymastersWeb:IsEquippedAndReady() and (((v50:ID() == v23.SpymastersWeb:ID()) and IsTrinket1) or ((v51:ID() == v23.SpymastersWeb:ID()) and IsTrinket2)) and ((v31 and ((v6:BuffStack(v22.SpymastersReportBuff) > (48 - 19)) or (v47 < v41))) or (v47 < (1404 - (746 + 638))))) then
							if v16(v23.SpymastersWeb, true) then
								return "spymasters_web main 4";
							end
						end
						if (v23.ImperfectAscendancySerum:IsEquippedAndReady() and (((v50:ID() == v23.ImperfectAscendancySerum:ID()) and IsTrinket1) or ((v51:ID() == v23.ImperfectAscendancySerum:ID()) and IsTrinket2)) and (v8:DebuffRemains(v22.SunfireDebuff) > (2 + 2)) and ((v8:DebuffRemains(v22.MoonfireDebuff) > (5 - 1)) or (v22.TreantsoftheMoon:IsAvailable() and ((v22.ForceofNature:CooldownRemains() < (344 - (218 + 123))) or v6:BuffUp(v22.HarmonyoftheGroveBuff)) and (v30 < (1582 - (1535 + 46)))) or (v47 < (20 + 0)) or ((v47 < v30) and (v6:BuffUp(v22.HarmonyoftheGroveBuff) or v22.ConvoketheSpirits:CooldownUp()))) and (v6:BuffStack(v22.SpymastersReportBuff) <= (5 + 24))) then
							if v16(v23.ImperfectAscendancySerum, true) then
								return "imperfect_ascendancy_serum main 6";
							end
						end
						if (v23.TreacherousTransmitter:IsEquippedAndReady() and (((v50:ID() == v23.TreacherousTransmitter:ID()) and IsTrinket1) or ((v51:ID() == v23.TreacherousTransmitter:ID()) and IsTrinket2)) and ((v30 < (563 - (306 + 254))) or (v47 < (2 + 18)) or ((v47 < v30) and (v6:BuffUp(v22.HarmonyoftheGroveBuff) or v22.ConvoketheSpirits:CooldownUp()))) and (v6:BuffStack(v22.SpymastersReportBuff) <= (56 - 27))) then
							if v16(v23.TreacherousTransmitter, true) then
								return "treacherous_transmitter main 8";
							end
						end
					end
					VarGenericTrinketCondition = v32 or ((v47 < v30) and (v6:BuffUp(v22.HarmonyoftheGroveBuff) or v22.ConvoketheSpirits:CooldownUp())) or ((((v6:BuffStack(v22.SpymastersReportBuff) + (v30 / (1473 - (899 + 568)))) > (20 + 9)) or (v47 < (v41 + v30))) and (v30 > (48 - 28))) or (v68 == (603 - (268 + 335)));
					if v28.Commons.Enabled.Trinkets then
						if (v50:IsReady() and v8:IsInRange(v58) and IsTrinket1 and not v60 and not v66 and (((v68 ~= (291 - (60 + 230))) and (v51:CooldownRemains() > (592 - (426 + 146)))) or (((v68 == (1 + 0)) or (v68 == (1459 - (282 + 1174)))) and v31) or (v47 < ((831 - (569 + 242)) + ((57 - 37) * v17(v51:CooldownRemains() < (2 + 23))))) or VarGenericTrinketCondition)) then
							if v16(v50, true) then
								return "use_items trinket1 (" .. v50:Name() .. ") main 10";
							end
						end
						if (v51:IsReady() and v8:IsInRange(v59) and IsTrinket2 and not v61 and not v67 and (((v68 ~= (1026 - (706 + 318))) and (v50:CooldownRemains() > (1271 - (721 + 530)))) or ((v68 == (1273 - (945 + 326))) and v31) or (v47 < ((49 - 29) + ((18 + 2) * v17(v50:CooldownRemains() < (725 - (271 + 429)))))) or VarGenericTrinketCondition)) then
							if v16(v51, true) then
								return "use_items trinket2 (" .. v51:Name() .. ") main 12";
							end
						end
					end
					if (v28.Commons.Enabled.Potions and (v38 or (v47 <= (28 + 2)))) then
						local v147 = v25.PotionSelected();
						if (v147 and v147:IsReady() and IsPotions) then
							v13.CastMacro(1503 - (1408 + 92), nil, nil, v147);
							return "potion main 14";
						end
					end
					if v6:BuffUp(v22.BearForm) then
						if (v22.ThrashBear:IsCastable() and v8:IsInRange(1091 - (461 + 625)) and v8:DebuffRefreshable(v22.ThrashBearDebuff)) then
							if v16(v22.Thrashcast) then
								return "thrash bear";
							end
						end
						if (v22.Mangle:IsCastable() and v8:IsInRange(1293 - (993 + 295)) and (v8:DebuffUp(v22.ThrashBearDebuff) or not v22.ThrashBear:IsAvailable())) then
							if v16(v22.Mangle) then
								return "Mangle bear";
							end
						end
						if (v22.Swipe:IsCastable() and v8:IsInRange(1 + 4)) then
							if v16(v22.Swipecast) then
								return "Swipe bear";
							end
						end
						if (v22.ThrashBear:IsCastable() and v8:IsInRange(1176 - (418 + 753))) then
							if v16(v22.Thrashcast) then
								return "thrash bear";
							end
						end
					end
					if (v22.Berserking:IsCastable() and IsRacials and (v31 or v32 or (v47 < (6 + 9)))) then
						if v16(v22.Berserking, true) then
							return "berserking main 16";
						end
					end
					v33 = v6:BuffUp(v22.EclipseLunar) or v6:BuffUp(v22.EclipseSolar);
					v34 = v20(v6:BuffRemains(v22.EclipseLunar), v6:BuffRemains(v22.EclipseSolar));
					v35 = v22.LunarCalling:IsAvailable() or (v46 > ((1 + 1) - v17((v22.UmbralIntensity:TalentRank() + v17(v22.SouloftheForest:IsAvailable())) > (1 + 0))));
					v36 = v6:BuffStack(v22.BOATArcaneBuff) + v6:BuffStack(v22.BOATNatureBuff);
					if (v22.WarriorofElune:IsCastable() and IsWarriorofElune and (v22.LunarCalling:IsAvailable() or ((v34 >= (2 + 5)) and (v40:CooldownRemains() > (549 - (406 + 123)))))) then
						if v16(v22.WarriorofElune, true) then
							return "warrior_of_elune main 18";
						end
					end
					if (v22.Wrath:IsCastable() and not v6:IsMoving() and v35 and (not v33 or (v34 < v22.Wrath:CastTime()))) then
						if v16(v22.Wrath) then
							return "wrath main 20";
						end
					end
					if (v22.Starfire:IsCastable() and (not v6:IsMoving() or v6:BuffUp(v22.WarriorofEluneBuff)) and not v35 and (not v33 or (v34 < v22.Starfire:CastTime()))) then
						if v16(v22.Starfire) then
							return "starfire main 22";
						end
					end
					if (v14() and (v46 > (1770 - (1749 + 20)))) then
						local v148 = v94();
						if v148 then
							return v148;
						end
					end
					local v145 = v93();
					if v145 then
						return v145;
					end
					if v13.CastAnnotated(v22.Pool, false, "WAIT") then
						return "Pool Resources";
					end
				end
			end
		end
	end
end
local function v96()
	v13.ResetToggle();
	v22.MoonfireDebuff:RegisterAuraTracking();
	v28.Balance.Display();
	local v137 = {Starlordvalue=v22.StarlordBuff:Name()};
	local v138 = "/cancelaura {Starlordvalue}";
	v13:UpdateMacro("macro1", v86(v138, v137));
	v13:UpdateMacro("macro2", "/use 16");
	v13:UpdateMacro("macro6", "/stopcasting");
	v13.ToggleIconFrame:AddButtonCustom("I", 1 + 0, "Interrupt", "interrupt");
	v13.ToggleIconFrame:AddButtonCustom("D", 1324 - (1249 + 73), "Dispel", "dispel");
	v13.ToggleIconFrame:AddButtonCustom("S", 2 + 1, "smallCDs", "smallcds");
	v13.ToggleIconFrame:AddButtonCustom("P", 1149 - (466 + 679), "UseSpender", "usespender");
	v25.PostInitialMessage(245 - 143);
end
v13.SetAPL(291 - 189, v95, v96);
