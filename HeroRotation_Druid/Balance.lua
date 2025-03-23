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
local v33;
local v34, v35;
local v36, v37;
local v38;
local v39;
local v40;
local v41 = (v22.IncarnationTalent:IsAvailable() and v22.Incarnation) or v22.CelestialAlignment;
local v42 = (v22.OrbitalStrike:IsAvailable() and (343 - 223)) or (v22.WhirlingStars:IsAvailable() and (154 - 74)) or (463 - 283);
local v43 = (v22.AstralInfluence:IsAvailable() and (664 - (555 + 64))) or (971 - (857 + 74));
local v44 = (v22.ElunesGuidance:IsAvailable() and (628 - (367 + 201))) or (1047 - (214 + 713));
local v45, v46;
local v47 = 2782 + 8329;
local v48 = 1748 + 9363;
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
local v69 = 877 - (282 + 595);
local function v70()
	local v97, v98 = v6:GetTrinketData(v24);
	if ((v69 < (1642 - (1523 + 114))) and ((v97.ID == (0 + 0)) or (v98.ID == (0 - 0)) or (v97.Level == (1065 - (68 + 997))) or (v98.Level == (1270 - (226 + 1044))) or ((v97.SpellID > (0 - 0)) and not v97.Usable) or ((v98.SpellID > (117 - (32 + 85))) and not v98.Usable))) then
		v69 = v69 + 1 + 0;
		v21(2 + 3, function()
			v70();
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
	local v116 = v17(v51:HasUseBuff() and (v53 ~= v23.OvinaxsMercurialEgg:ID())) * (959 - (892 + 65));
	v68 = (0 - 0) + v115 + v116;
end
v70();
v3:RegisterForEvent(function()
	v70();
end, "PLAYER_EQUIPMENT_CHANGED");
v3:RegisterForEvent(function()
	v47 = 20537 - 9426;
	v48 = 20397 - 9286;
end, "PLAYER_REGEN_ENABLED");
v3:RegisterForEvent(function()
	v41 = (v22.IncarnationTalent:IsAvailable() and v22.Incarnation) or v22.CelestialAlignment;
	v42 = (v22.OrbitalStrike:IsAvailable() and (470 - (87 + 263))) or (v22.WhirlingStars:IsAvailable() and (260 - (67 + 113))) or (132 + 48);
	v44 = (v22.ElunesGuidance:IsAvailable() and (147 - 87)) or (89 + 31);
	v43 = (v22.AstralInfluence:IsAvailable() and (178 - 133)) or (992 - (802 + 150));
end, "SPELLS_CHANGED", "LEARNED_SPELL_IN_TAB");
local function v71(v117)
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
			local v145 = (1188 - (1069 + 118)) + ((0.2 - 0) * v46);
			if (v145 > (1.6 - 0)) then
				v145 = 1.6 + 0;
			end
			v118 = v118 * v145;
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
local function v72(v119)
	return v119:DebuffRefreshable(v22.MoonfireDebuff) and ((v119:TimeToDie() - v119:DebuffRemains(v22.MoonfireDebuff)) > (19 - 13)) and (not v22.TreantsoftheMoon:IsAvailable() or ((v46 - v22.MoonfireDebuff:AuraActiveCount()) > (3 + 3)) or ((v22.ForceofNature:CooldownRemains() > (4 - 1)) and v6:BuffDown(v22.HarmonyoftheGroveBuff)));
end
local function v73(v120)
	return (v120:DebuffRemains(v22.MoonfireDebuff) < (441 - (145 + 293))) and (not v22.TreantsoftheMoon:IsAvailable() or ((v22.ForceofNature:CooldownRemains() > (433 - (44 + 386))) and v6:BuffDown(v22.HarmonyoftheGroveBuff)));
end
local function v74(v121)
	return v121:DebuffRefreshable(v22.MoonfireDebuff) and (not v22.TreantsoftheMoon:IsAvailable() or ((v22.ForceofNature:CooldownRemains() > (1489 - (998 + 488))) and v6:BuffDown(v22.HarmonyoftheGroveBuff)));
end
local function v75(v122)
	return v122:DebuffRefreshable(v22.StellarFlareDebuff) and ((v122:TimeToDie() - v122:DebuffRemains(v22.StellarFlareDebuff)) > (3 + 4 + v46));
end
local function v76(v123)
	return v123:DebuffRefreshable(v22.StellarFlareDebuff) and ((v123:TimeToDie() - v123:DebuffRemains(v22.StellarFlareDebuff)) > (6 + 1 + v46));
end
local function v77(v124)
	return v124:DebuffRefreshable(v22.SunfireDebuff) and ((v124:TimeToDie() - v124:DebuffRemains(v22.SunfireDebuff)) > ((778 - (201 + 571)) - (v46 / (1140 - (116 + 1022)))));
end
local function v78(v125)
	return (v125:DebuffRemains(v22.SunfireDebuff) < (12 - 9)) or v125:DebuffRefreshable(v22.SunfireDebuff);
end
local function v79(v126)
	return v126:DebuffRefreshable(v22.SunfireDebuff);
end
local function v80(v127)
	return v127:NPCID() == (120072 + 84488);
end
local function v81(v128)
	return v128:CastSpellID() == (1492420 - 1083615);
end
local function v82()
	return (v12:Exists() or not v28.Balance.CursorCheck) and not v6:IsCameraBusy();
end
local function v83()
	if v25.TargetIsValid() then
		local v140 = 142 - 102;
		local v141 = v6:GetEnemiesInRange(v140);
		local v142 = 859 - (814 + 45);
		for v143, v144 in ipairs(v141) do
			if v144:AffectingCombat() then
				v142 = v142 + (2 - 1);
			end
		end
		v142 = math.max(v142, 1 + 0);
		return v142;
	else
		return #(v6:GetEnemiesInRange(15 + 25));
	end
end
local function v84()
	return v6:ChannelSpellID() == (392413 - (261 + 624));
end
local function v85(v129, v130)
	return (v129:gsub("{(.-)}", v130));
end
local v86;
local function v87(v131)
	return (v131 ~= "Not Used") and ((((v131 == "with Cooldowns") or ((v131 == "small CDs") and v28.Balance_CDUSE.smallcdswithCooldowns) or (v131 == "with Cooldowns or AoE") or (v131 == "on Enemycount or Cooldowns") or (v131 == "on Boss or with Cooldowns")) and v15()) or (v131 == "always") or (((v131 == "on Boss only") or (v131 == "on Boss or on Enemycount") or (v131 == "on Boss or with Cooldowns")) and (v86 or v8:IsDummy())) or ((v131 == "with Bloodlust only") and v6:BloodlustUp()) or ((v131 == "small CDs") and Smallcds) or (((v131 == "on AOE") or (v131 == "with Cooldowns or AoE")) and (v46 >= (3 - 1))) or (((v131 == "on Enemycount or Cooldowns") or (v131 == "on Enemycount") or (v131 == "on Boss or on Enemycount")) and (v46 >= v28.Balance_CDUSE.Enemycount)));
end
local function v88(v132)
	return (v86 and v28.Balance_TTD.IgnoreWhenBoss) or v25.Buggedmobs[v8:NPCID()] or (v25.ISSolo() and v28.Balance_TTD.IgnoreWhenSolo) or (v132 == (1080 - (1020 + 60))) or ((v48 >= v132) and (v48 < (9200 - (630 + 793))));
end
local function v89()
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
	if (v22.MoonkinForm:IsCastable() and v6:BuffUp(v22.BearForm) and (v6:HealthPercentage() > v28.Balance.Defensives.MoonkinFormHP) and (v28.Balance.Defensives.MoonkinFormHP > (0 - 0))) then
		if v16(v22.MoonkinForm) then
			return "MoonkinForm";
		end
	end
end
local function v90()
	if (v22.MoonkinForm:IsCastable() and v6:BuffDown(v22.TravelFormBuff) and v6:BuffDown(v22.BearForm) and v6:BuffDown(v22.CatForm)) then
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
end
local function v91()
	if (v15() and v22.Berserking:IsCastable() and v32) then
		if v16(v22.Berserking, true) then
			return "berserking pre_cd 4";
		end
	end
	if (v28.Commons.Enabled.Items and v23.BestinSlotsCaster:IsEquippedAndReady() and (((v6:HeroTreeID() == (62 - 39)) and v6:BuffUp(v22.HarmonyoftheGroveBuff)) or ((v6:HeroTreeID() == (93 - 69)) and v39))) then
		v13.CastMacro(1 + 0, nil, nil, v23.BestinSlotsCaster);
		return "use_items trinket2 (" .. v51:Name() .. ") pre_cd 10";
	end
end
local function v92()
	if (v22.WarriorofElune:IsCastable() and IsWarriorofElune and (v22.LunarCalling:IsAvailable() or (not v22.LunarCalling:IsAvailable() and (v35 <= (6 + 1))))) then
		if v16(v22.WarriorofElune, true) then
			return "warrior_of_elune st 2";
		end
	end
	if (v22.Wrath:IsCastable() and v43 and v36 and v34 and (v35 < v22.Wrath:CastTime()) and not v32) then
		if v16(v22.Wrath) then
			return "wrath st 4";
		end
	end
	if (v22.Starfire:IsCastable() and v43 and not v36 and v34 and (v35 < v22.Starfire:CastTime()) and not v32) then
		if v16(v22.Starfire) then
			return "starfire st 6";
		end
	end
	if v22.Sunfire:IsCastable() then
		if v25.CastCycle(v22.Sunfire, v45, v78, v43) then
			return "sunfire st 2";
		end
	end
	if (v22.Moonfire:IsCastable() and (not v22.ForceofNature:IsAvailable() or (v22.ForceofNature:CooldownRemains() > (1060 - (87 + 968))) or not IsForceofNature or not v22.TreantsoftheMoon:IsAvailable())) then
		if v25.CastCycle(v22.Moonfire, v45, v73, v43) then
			return "moonfire st 4";
		end
	end
	local v133 = v91();
	if v133 then
		return v133;
	end
	if (v15() and v32) then
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
	if (v22.Wrath:IsCastable() and v43 and v36 and (not v34 or (v35 < v22.Wrath:CastTime()))) then
		if v16(v22.Wrath) then
			return "wrath st 16";
		end
	end
	if (v22.Starfire:IsCastable() and v43 and not v36 and (not v34 or (v35 < v22.Starfire:CastTime()))) then
		if v16(v22.Starfire, nil, nil, RangeformagicSpells) then
			return "starfire st 18";
		end
	end
	if (v22.Starsurge:IsReady() and v43 and v32 and (v6:AstralPowerDeficit() > (v29 + v71(v22.ForceofNature)))) then
		if v16(v22.Starsurge) then
			return "starsurge st 20";
		end
	end
	if (v22.ForceofNature:IsCastable() and IsForceofNature and (((v41:CooldownRemains() < v6:GCD()) and (not v22.ConvoketheSpirits:IsAvailable() or (v22.ConvoketheSpirits:CooldownRemains() < (v6:GCD() * (13 - 10))) or (v22.ConvoketheSpirits:CooldownRemains() > v41:FullRechargeTime()) or (v48 < (v22.ConvoketheSpirits:CooldownRemains() + 3 + 0)))) or (((v41:FullRechargeTime() + (11 - 6) + ((1428 - (447 + 966)) * v17(v22.ControloftheDream:IsAvailable()))) > (164 - 104)) and (not v22.ConvoketheSpirits:IsAvailable() or ((v22.ConvoketheSpirits:CooldownRemains() + (1827 - (1703 + 114)) + ((716 - (376 + 325)) * v17(v22.ControloftheDream:IsAvailable()))) > (98 - 38)) or (v48 < (v22.ConvoketheSpirits:CooldownRemains() + v44 + (15 - 10)))) and ((v48 > (19 + 46)) or (v48 < (v41:CooldownRemains() + (15 - 8))))) or (v22.WhirlingStars:IsAvailable() and v22.ConvoketheSpirits:IsAvailable() and (v22.ConvoketheSpirits:CooldownRemains() > (64 - (9 + 5))) and (v48 > (v22.ConvoketheSpirits:CooldownRemains() + (382 - (85 + 291))))))) then
		if v16(v22.ForceofNature, true) then
			return "force_of_nature st 22";
		end
	end
	if (v22.FuryofElune:IsCastable() and IsFuryofElune and (((1270 - (243 + 1022)) + v29) < v6:AstralPowerDeficit())) then
		if v16(v22.FuryofElune, true) then
			return "fury_of_elune st 12";
		end
	end
	if (v22.Starfall:IsReady() and (v6:BuffUp(v22.StarweaversWarp))) then
		if v16(v22.Starfall, true, nil, RangeformagicSpells) then
			return "starfall st 26";
		end
	end
	if (v22.Starsurge:IsReady() and UseSpender and v22.Starlord:IsAvailable() and (v6:BuffStack(v22.StarlordBuff) < (11 - 8))) then
		if v16(v22.Starsurge) then
			return "starsurge st 14";
		end
	end
	if v22.Sunfire:IsCastable() then
		if v25.CastCycle(v22.Sunfire, v45, v79, v43) then
			return "sunfire st 30";
		end
	end
	if v22.Moonfire:IsCastable() then
		if v25.CastCycle(v22.Moonfire, v45, v74, v43) then
			return "moonfire st 32";
		end
	end
	if v22.StellarFlare:IsCastable() then
		if v25.CastCycle(v22.StellarFlare, v45, v76, v43) then
			return "stellar_flare st 34";
		end
	end
	if (v22.Starsurge:IsReady() and UseSpender and (v22.ConvoketheSpirits:CooldownRemains() < (v6:GCD() * (2 + 0))) and v38) then
		if v16(v22.Starsurge) then
			return "starsurge st 22";
		end
	end
	if (v22.ConvoketheSpirits:IsCastable() and IsConvoketheSpirits and v38) then
		if v16(v22.ConvoketheSpirits) then
			return "convoke_the_spirits st 24";
		end
	end
	if (v22.Starsurge:IsReady() and UseSpender and (((v6:BuffRemains(v22.StarlordBuff) > (1184 - (1123 + 57))) and (v37 >= (3 + 0))) or (v47 < (258 - (163 + 91))))) then
		if v16(v22.Starsurge) then
			return "starsurge st 26";
		end
	end
	if (v22.NewMoon:IsCastable() and not v6:IsMoving() and ((v6:AstralPowerDeficit() > (v29 + v71(v22.NewMoon))) or (v47 < (1950 - (1869 + 61))) or (v41:CooldownRemains() > (5 + 10)))) then
		if v16(v22.NewMoon) then
			return "new_moon st 28";
		end
	end
	if (v22.HalfMoon:IsCastable() and not v6:IsMoving() and (((v6:AstralPowerDeficit() > (v29 + v71(v22.HalfMoon))) and ((v6:BuffRemains(v22.EclipseLunar) > v22.HalfMoon:ExecuteTime()) or (v6:BuffRemains(v22.EclipseSolar) > v22.HalfMoon:ExecuteTime()))) or (v47 < (70 - 50)) or (v41:CooldownRemains() > (23 - 8)))) then
		if v16(v22.HalfMoon) then
			return "half_moon st 30";
		end
	end
	if (v22.FullMoon:IsCastable() and not v6:IsMoving() and (((v6:AstralPowerDeficit() > (v29 + v71(v22.FullMoon))) and ((v6:BuffRemains(v22.EclipseLunar) > v22.FullMoon:ExecuteTime()) or (v6:BuffRemains(v22.EclipseSolar) > v22.FullMoon:ExecuteTime()))) or (v47 < (3 + 17)) or (v41:CooldownRemains() > (20 - 5)))) then
		if v16(v22.FullMoon) then
			return "full_moon st 32";
		end
	end
	if (v22.Starsurge:IsReady() and UseSpender and (v6:BuffUp(v22.StarweaversWeft) or v6:BuffUp(v22.TouchtheCosmosStarsurge))) then
		if v16(v22.Starsurge) then
			return "starsurge st 34";
		end
	end
	if (v22.Starsurge:IsReady() and UseSpender and (v6:AstralPowerDeficit() < (v29 + v71(v22.Wrath) + ((v71(v22.Starfire) + v29) * (v17(v6:BuffRemains(v22.EclipseSolar) < (v6:GCD() * (3 + 0)))))))) then
		if v16(v22.Starsurge) then
			return "starsurge st 38";
		end
	end
	if (v22.ForceofNature:IsCastable() and IsForceofNature and (v6:HeroTreeID() ~= (1497 - (1329 + 145)))) then
		if v16(v22.ForceofNature, true) then
			return "force_of_nature st 40";
		end
	end
	if (v22.WildMushroom:IsCastable() and IsWildMushroom and not v6:PrevGCD(972 - (140 + 831), v22.WildMushroom) and (v8:DebuffRemains(v22.FungalGrowthDebuff) < (1852 - (1409 + 441)))) then
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
		if (v22.Sunfire:IsCastable() and (v46 > (719 - (15 + 703)))) then
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
local function v93()
	local v134 = v6:IsInDungeonArea();
	if (v22.Wrath:IsCastable() and v43 and v36 and v34 and (v35 < v22.Wrath:CastTime())) then
		if v16(v22.Wrath) then
			return "wrath aoe 2";
		end
	end
	if (v22.Starfire:IsCastable() and v43 and not v36 and v34 and (v35 < v22.Starfire:CastTime())) then
		if v16(v22.Starfire) then
			return "starfire aoe 4";
		end
	end
	if (v22.Starfall:IsReady() and v43 and (v6:AstralPowerDeficit() <= (v29 + 3 + 3))) then
		if v16(v22.Starfall, true) then
			return "starfall aoe 6";
		end
	end
	if (v22.Moonfire:IsCastable() and v134) then
		if v25.CastCycle(v22.Moonfire, v45, v72, v43) then
			return "moonfire aoe 2";
		end
	end
	if v22.Sunfire:IsCastable() then
		if v25.CastCycle(v22.Sunfire, v45, v77, v43) then
			return "sunfire aoe 4";
		end
	end
	if (v22.Moonfire:IsCastable() and not v134) then
		if v25.CastCycle(v22.Moonfire, v45, v72, v43) then
			return "moonfire aoe 6";
		end
	end
	if (v22.Wrath:IsCastable() and v43 and v36 and (not v34 or (v35 < v22.Wrath:CastTime()))) then
		if v16(v22.Wrath) then
			return "wrath aoe 14";
		end
	end
	if (v22.Starfire:IsCastable() and v43 and not v36 and (not v34 or (v35 < v22.Starfire:CastTime()))) then
		if v16(v22.Starfire) then
			return "starfire aoe 16";
		end
	end
	if (v22.StellarFlare:IsCastable() and (v46 < ((((449 - (262 + 176)) - v22.UmbralIntensity:TalentRank()) - ((1723 - (345 + 1376)) * v17(v22.AstralSmolder:IsAvailable()))) - v17(v22.LunarCalling:IsAvailable())))) then
		if v25.CastCycle(v22.StellarFlare, v45, v75, v43) then
			return "stellar_flare aoe 8";
		end
	end
	if (v22.ForceofNature:IsCastable() and (((v41:CooldownRemains() < v6:GCD()) and (not v34 or (v35 > (694 - (198 + 490))))) or ((v35 >= (13 - 10)) and (v41:CooldownRemains() > ((23 - 13) + ((1221 - (696 + 510)) * v17(v22.ControloftheDream:IsAvailable())))) and ((v48 > (136 - 71)) or (v41:CooldownRemains() > v48))))) then
		if v16(v22.ForceofNature, true) then
			return "force_of_nature aoe 10";
		end
	end
	if (v22.FuryofElune:IsCastable() and IsFuryofElune and v34) then
		if v16(v22.FuryofElune, true) then
			return "fury_of_elune aoe 12";
		end
	end
	local v135 = v91();
	if v135 then
		return v135;
	end
	if (v15() and v32) then
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
	if (v22.WarriorofElune:IsCastable() and IsWarriorofElune and ((not v22.LunarCalling:IsAvailable() and (v6:BuffRemains(v22.EclipseSolar) < (1269 - (1091 + 171)))) or v22.LunarCalling:IsAvailable())) then
		if v16(v22.WarriorofElune, true) then
			return "warrior_of_elune aoe 18";
		end
	end
	if (v22.Starfire:IsCastable() and (not v6:IsMoving() or v6:BuffUp(v22.WarriorofEluneBuff)) and not v22.LunarCalling:IsAvailable() and (v46 == (1 + 0)) and ((v6:BuffUp(v22.EclipseSolar) and (v6:BuffRemains(v22.EclipseSolar) < v22.Starfire:CastTime())) or not v34)) then
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
	if (v22.ConvoketheSpirits:IsCastable() and IsConvoketheSpirits and ((v6:BuffDown(v22.DreamstateBuff) and v6:BuffDown(v22.UmbralEmbraceBuff) and (v46 < (21 - 14))) or (v46 == (3 - 2))) and ((v47 < (379 - (123 + 251))) or ((v39 or (v41:CooldownRemains() > (198 - 158))) and ((v6:HeroTreeID() ~= (732 - (208 + 490))) or v6:BuffUp(v22.HarmonyoftheGroveBuff) or (v22.ForceofNature:CooldownRemains() > (2 + 13)))))) then
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
	if (v22.WildMushroom:IsCastable() and IsWildMushroom) then
		if v16(v22.WildMushroom, true) then
			return "wild_mushroom aoe 36";
		end
	end
	if (v22.ForceofNature:IsCastable() and IsForceofNature and (v6:HeroTreeID() ~= (11 + 12))) then
		if v16(v22.ForceofNature, true) then
			return "force_of_nature aoe 48";
		end
	end
	if (v22.Starfire:IsCastable() and (not v6:IsMoving() or v6:BuffUp(v22.WarriorofEluneBuff)) and (v22.LunarCalling:IsAvailable() or (v6:BuffUp(v22.EclipseLunar) and (v46 > (837 - (660 + 176)))))) then
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
local function v94()
	if Baerform then
		if (v22.BearForm:IsCastable() and not v6:BuffUp(v22.BearForm)) then
			if v16(v22.BearForm) then
				return "Bear Form";
			end
		end
		if v6:BuffUp(v22.BearForm) then
			if (v22.ThrashBear:IsCastable() and v8:IsInRange(1 + 4) and v8:DebuffRefreshable(v22.ThrashBearDebuff)) then
				if v16(v22.Thrashcast) then
					return "thrash bear";
				end
			end
			if (v22.Mangle:IsCastable() and v8:IsInRange(207 - (14 + 188)) and (v8:DebuffUp(v22.ThrashBearDebuff) or not v22.ThrashBear:IsAvailable())) then
				if v16(v22.Mangle) then
					return "Mangle bear";
				end
			end
			if (v22.Swipe:IsCastable() and v8:IsInRange(680 - (534 + 141))) then
				if v16(v22.Swipecast) then
					return "Swipe bear";
				end
			end
			if (v22.ThrashBear:IsCastable() and v8:IsInRange(3 + 2)) then
				if v16(v22.Thrashcast) then
					return "thrash bear";
				end
			end
		end
	end
end
local function v95()
	if v25.ShouldStopCastUpdate() then
		v13.CastMacro(6 + 0, true);
		return "Stop Cast For Silence";
	end
	local v136 = v25.HealthPotions();
	if v136 then
		return v136;
	end
	InterruptToggle = v13.ToggleIconFrame:GetToggle(1 + 0);
	DispelToggle = v13.ToggleIconFrame:GetToggle(3 - 1);
	Smallcds = v13.ToggleIconFrame:GetToggle(4 - 1);
	UseSpender = v13.ToggleIconFrame:GetToggle(11 - 7);
	Baerform = v13.ToggleIconFrame:GetToggle(3 + 2);
	local v137 = not v6:AffectingCombat() or not v8:AffectingCombat() or v8:IsDummy();
	Enemies40Yard = v6:GetEnemiesInRange(26 + 14);
	EnemiesRangeOOCCount = v83() or #Enemies40Yard;
	v49 = v25.UnitsinRange(v22.Regrowth);
	v45 = v8:GetEnemiesInSplashRange(406 - (115 + 281));
	if v14() then
		v46 = (v137 and #Enemies40Yard) or EnemiesRangeOOCCount;
	else
		v46 = 2 - 1;
	end
	IsRacials = v88(v28.Balance_TTD.RacialsTTD) and v87(v28.Balance_CDUSE.Racials);
	IsPotions = v88(v28.Balance_TTD.PotionsTTD) and (v28.Balance_CDUSE.Potionswhensolo or (not v28.Balance_CDUSE.Potionswhensolo and not v25.ISSolo())) and v87(v28.Balance_CDUSE.Potions);
	IsTrinket1 = v88(v28.Balance_TTD.TrinketsTTD) and v87(v28.Balance_CDUSE.Trinket1);
	IsTrinket2 = v88(v28.Balance_TTD.TrinketsTTD) and v87(v28.Balance_CDUSE.Trinket2);
	IsIncarnation = (not v22.OrbitalStrike:IsAvailable() or v82()) and v88(v28.Balance_TTD.IncarnationTTD) and v87(v28.Balance_CDUSE.Incarnation);
	IsWarriorofElune = v88(v28.Balance_TTD.WarriorofEluneTTD) and v87(v28.Balance_CDUSE.WarriorofElune);
	IsForceofNature = v82() and v88(v28.Balance_TTD.ForceofNatureTTD) and v87(v28.Balance_CDUSE.ForceofNature);
	IsWildMushroom = v88(v28.Balance_TTD.WildMushroomTTD) and v87(v28.Balance_CDUSE.WildMushroom);
	IsFuryofElune = v88(v28.Balance_TTD.FuryofEluneTTD) and v87(v28.Balance_CDUSE.FuryofElune);
	IsConvoketheSpirits = v88(v28.Balance_TTD.ConvoketheSpiritsTTD) and v87(v28.Balance_CDUSE.ConvoketheSpirits);
	if (v25.TargetIsValid() or (v6:AffectingCombat() and v8 and v8:AffectingCombat())) then
		TargetinRange = v8:IsSpellInRange(v22.Wrath);
		v47 = v3.BossFightRemains();
		v86 = true;
		v48 = v47;
		if (v48 == (9200 + 1911)) then
			v86 = false;
			v48 = v3.FightRemains(v45, false);
		end
		v39 = (v22.IncarnationTalent:IsAvailable() and (v6:BuffUp(v22.IncarnationBuff1) or v6:BuffUp(v22.IncarnationBuff2))) or v6:BuffUp(v22.CABuff1) or v6:BuffUp(v22.CABuff2);
		v40 = 0 - 0;
		if v39 then
			v40 = (v22.IncarnationTalent:IsAvailable() and v20(v6:BuffRemains(v22.IncarnationBuff1), v6:BuffRemains(v22.IncarnationBuff2))) or v20(v6:BuffRemains(v22.CABuff1), v6:BuffRemains(v22.CABuff2));
		end
	end
	if (v22.MarkoftheWild:IsCastable() and not v6:DebuffUp(v22.Corruption) and ((v25.GroupBuffMissing(v22.MarkoftheWildBuff) and (v28.Commons.MarkoftheWild == "check whole group") and (v6:IsInRaidArea() or v6:IsInDungeonArea()) and (v6:InstanceDifficulty() ~= (751 - 546))) or (v6:BuffDown(v22.MarkoftheWildBuff, true) and ((v28.Commons.MarkoftheWild == "only check us") or (v28.Commons.MarkoftheWild == "check whole group"))))) then
		if v13.CastTarget(v22.MarkoftheWild, v13.TName().PLAYER) then
			return "mark_of_the_wild precombat";
		end
	end
	if (v22.MoonkinForm:IsCastable() and v6:BuffDown(v22.TravelFormBuff) and v6:BuffDown(v22.BearForm) and v6:BuffDown(v22.CatForm) and v28.Balance.ShowMoonkinFormOOC) then
		if v16(v22.MoonkinForm) then
			return "moonkin_form ooc";
		end
	end
	if not v6:IsMoving() then
		v136 = not v6:IsCasting(v22.Hibernate) and v25.IncorpCycle(v22.Hibernate, 902 - (550 + 317), false, false);
		if v136 then
			return v136;
		end
	end
	if DispelToggle then
		v136 = v6:AffectingCombat() and v25.SootheCycle(v22.Soothe, 65 - 20, false, v28.Balance.TabForSoothe);
		if v136 then
			return v136;
		end
		if (v22.RemoveCorruption:IsCastable() and v6:IsInDungeonArea() and v6:IsInParty()) then
			v136 = v25.DispelCycle(v22.RemoveCorruption, "Poison", nil, v49);
			if v136 then
				return v136;
			end
			v136 = v25.DispelCycle(v22.RemoveCorruption, "Curse", nil, v49);
			if v136 then
				return v136;
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
	v136 = v89();
	if v136 then
		return v136;
	end
	if (v25.TargetIsValid() and v6:BuffDown(v22.TravelFormBuff)) then
		if (not v28.Balance.AttackonlyinCombat or (v28.Balance.AttackonlyinCombat and v8:AffectingCombat())) then
			if not v80(v5.Target) then
				if TargetinRange then
					if not v6:AffectingCombat() then
						local v146 = v6:BuffDown(v22.BearForm) and v90();
						if v146 then
							return v146;
						end
					end
					if (InterruptToggle and not v84()) then
						v136 = v25.InterruptCycle(v22.SolarBeam, 56 - 16, true, nil, false);
						if v136 then
							return v136;
						end
						v136 = v25.InterruptCycle(v22.MightyBash, 22 - 14, false, nil, true);
						if v136 then
							return v136;
						end
					end
					v29 = ((291 - (134 + 151)) / v6:SpellHaste()) + v17(v22.NaturesBalance:IsAvailable()) + (v17(v22.OrbitBreaker:IsAvailable()) * v17(v22.MoonfireDebuff:AuraActiveCount() > (1665 - (970 + 695))) * v17(v26.OrbitBreakerStacks > ((50 - 23) - ((1992 - (582 + 1408)) * v17(v6:BuffUp(v22.SolsticeBuff))))) * (82 - 58));
					v30 = v20(v41:CooldownRemains(), v22.ForceofNature:CooldownRemains());
					v31 = v47 < (v42 + v30);
					v32 = ((v47 < (((18 - 3) + ((18 - 13) * v17(v22.Incarnation:IsAvailable()))) * ((1825 - (1195 + 629)) - (v17(v22.WhirlingStars:IsAvailable()) * (0.2 - 0))))) or ((v8:TimeToDie() > (251 - (187 + 54))) and ((v6:HeroTreeID() ~= (803 - (162 + 618))) or v6:BuffUp(v22.HarmonyoftheGroveBuff)) and (not v22.WhirlingStars:IsAvailable() or not v22.ConvoketheSpirits:IsAvailable() or (v22.ConvoketheSpirits:CooldownRemains() < (v6:GCD() * (2 + 0))) or (v47 < (v22.ConvoketheSpirits:CooldownRemains() + 2 + 1)) or (v22.ConvoketheSpirits:CooldownRemains() > v41:FullRechargeTime())))) and v41:CooldownUp() and not v39;
					v38 = (v47 < (10 - 5)) or ((v39 or (v41:CooldownRemains() > (67 - 27))) and ((v6:HeroTreeID() ~= (2 + 21)) or v6:BuffUp(v22.HarmonyoftheGroveBuff) or (v22.ForceofNature:CooldownRemains() > (1651 - (1373 + 263)))));
					v34 = v6:BuffUp(v22.EclipseLunar) or v6:BuffUp(v22.EclipseSolar);
					v35 = v20(v6:BuffRemains(v22.EclipseLunar), v6:BuffRemains(v22.EclipseSolar));
					v36 = v22.LunarCalling:IsAvailable() or (v46 > ((1002 - (451 + 549)) - v17((v22.UmbralIntensity:TalentRank() + v17(v22.SouloftheForest:IsAvailable())) > (1 + 0))));
					v37 = v6:BuffStack(v22.BOATArcaneBuff) + v6:BuffStack(v22.BOATNatureBuff);
					v33 = (not v22.CelestialAlignment:IsAvailable() and not v22.Incarnation:IsAvailable()) or not v15();
					if v28.Commons.Enabled.Trinkets then
						if (v23.AberrantSpellforge:IsEquippedAndReady() and (((v50:ID() == v23.AberrantSpellforge:ID()) and IsTrinket1) or ((v51:ID() == v23.AberrantSpellforge:ID()) and IsTrinket2))) then
							if v16(v23.AberrantSpellforge, true) then
								return "aberrant_spellforge main 2";
							end
						end
						if (v23.SpymastersWeb:IsEquippedAndReady() and (((v50:ID() == v23.SpymastersWeb:ID()) and IsTrinket1) or ((v51:ID() == v23.SpymastersWeb:ID()) and IsTrinket2)) and ((v32 and ((v6:BuffStack(v22.SpymastersReportBuff) > (44 - 15)) or (v47 < v42))) or (v47 < (33 - 13)))) then
							if v16(v23.SpymastersWeb, true) then
								return "spymasters_web main 4";
							end
						end
						if (v23.ImperfectAscendancySerum:IsEquippedAndReady() and (((v50:ID() == v23.ImperfectAscendancySerum:ID()) and IsTrinket1) or ((v51:ID() == v23.ImperfectAscendancySerum:ID()) and IsTrinket2)) and (v8:DebuffRemains(v22.SunfireDebuff) > (1388 - (746 + 638))) and ((v8:DebuffRemains(v22.MoonfireDebuff) > (2 + 2)) or (v22.TreantsoftheMoon:IsAvailable() and ((v22.ForceofNature:CooldownRemains() < (4 - 1)) or v6:BuffUp(v22.HarmonyoftheGroveBuff)) and (v30 < (342 - (218 + 123)))) or (v47 < (1601 - (1535 + 46))) or ((v47 < v30) and (v6:BuffUp(v22.HarmonyoftheGroveBuff) or v22.ConvoketheSpirits:CooldownUp()))) and (v6:BuffStack(v22.SpymastersReportBuff) <= (29 + 0))) then
							if v16(v23.ImperfectAscendancySerum, true) then
								return "imperfect_ascendancy_serum main 6";
							end
						end
						if (v23.TreacherousTransmitter:IsEquippedAndReady() and (((v50:ID() == v23.TreacherousTransmitter:ID()) and IsTrinket1) or ((v51:ID() == v23.TreacherousTransmitter:ID()) and IsTrinket2)) and ((v30 < (1 + 2)) or (v47 < (580 - (306 + 254))) or ((v47 < v30) and (v6:BuffUp(v22.HarmonyoftheGroveBuff) or v22.ConvoketheSpirits:CooldownUp()))) and (v6:BuffStack(v22.SpymastersReportBuff) <= (2 + 27))) then
							if v16(v23.TreacherousTransmitter, true) then
								return "treacherous_transmitter main 8";
							end
						end
					end
					VarGenericTrinketCondition = v33 or ((v47 < v30) and (v6:BuffUp(v22.HarmonyoftheGroveBuff) or v22.ConvoketheSpirits:CooldownUp())) or ((((v6:BuffStack(v22.SpymastersReportBuff) + (v30 / (11 - 5))) > (1496 - (899 + 568))) or (v47 < (v42 + v30))) and (v30 > (14 + 6))) or (v68 == (0 - 0));
					if v28.Commons.Enabled.Trinkets then
						if (v50:IsReady() and v8:IsInRange(v58) and IsTrinket1 and not v60 and not v66 and (((v68 ~= (604 - (268 + 335))) and (v51:CooldownRemains() > (310 - (60 + 230)))) or (((v68 == (573 - (426 + 146))) or (v68 == (1 + 2))) and v32) or (v47 < ((1476 - (282 + 1174)) + ((831 - (569 + 242)) * v17(v51:CooldownRemains() < (72 - 47))))) or VarGenericTrinketCondition)) then
							if v16(v50, true) then
								return "use_items trinket1 (" .. v50:Name() .. ") main 10";
							end
						end
						if (v51:IsReady() and v8:IsInRange(v59) and IsTrinket2 and not v61 and not v67 and (((v68 ~= (1 + 1)) and (v50:CooldownRemains() > (1044 - (706 + 318)))) or ((v68 == (1253 - (721 + 530))) and v32) or (v47 < ((1291 - (945 + 326)) + ((49 - 29) * v17(v50:CooldownRemains() < (23 + 2))))) or VarGenericTrinketCondition)) then
							if v16(v51, true) then
								return "use_items trinket2 (" .. v51:Name() .. ") main 12";
							end
						end
					end
					if (v28.Commons.Enabled.Potions and (v39 or (v47 <= (730 - (271 + 429))))) then
						local v147 = v25.PotionSelected();
						if (v147 and v147:IsReady() and IsPotions) then
							v13.CastMacro(3 + 0, nil, nil, v147);
							return "potion main 14";
						end
					end
					if v6:BuffUp(v22.BearForm) then
						if (v22.ThrashBear:IsCastable() and v8:IsInRange(1505 - (1408 + 92)) and v8:DebuffRefreshable(v22.ThrashBearDebuff)) then
							if v16(v22.Thrashcast) then
								return "thrash bear";
							end
						end
						if (v22.Mangle:IsCastable() and v8:IsInRange(1091 - (461 + 625)) and (v8:DebuffUp(v22.ThrashBearDebuff) or not v22.ThrashBear:IsAvailable())) then
							if v16(v22.Mangle) then
								return "Mangle bear";
							end
						end
						if (v22.Swipe:IsCastable() and v8:IsInRange(1293 - (993 + 295))) then
							if v16(v22.Swipecast) then
								return "Swipe bear";
							end
						end
						if (v22.ThrashBear:IsCastable() and v8:IsInRange(1 + 4)) then
							if v16(v22.Thrashcast) then
								return "thrash bear";
							end
						end
					end
					if Baerform then
						local v148 = v94();
						if v148 then
							return v148;
						end
					else
						if (v22.Berserking:IsCastable() and IsRacials and (v32 or v33 or (v47 < (1186 - (418 + 753))))) then
							if v16(v22.Berserking, true) then
								return "berserking main 16";
							end
						end
						v34 = v6:BuffUp(v22.EclipseLunar) or v6:BuffUp(v22.EclipseSolar);
						v35 = v20(v6:BuffRemains(v22.EclipseLunar), v6:BuffRemains(v22.EclipseSolar));
						v36 = v22.LunarCalling:IsAvailable() or (v46 > ((1 + 1) - v17((v22.UmbralIntensity:TalentRank() + v17(v22.SouloftheForest:IsAvailable())) > (1 + 0))));
						v37 = v6:BuffStack(v22.BOATArcaneBuff) + v6:BuffStack(v22.BOATNatureBuff);
						if (v22.WarriorofElune:IsCastable() and IsWarriorofElune and (v22.LunarCalling:IsAvailable() or ((v35 >= (3 + 4)) and (v41:CooldownRemains() > (6 + 14))))) then
							if v16(v22.WarriorofElune, true) then
								return "warrior_of_elune main 18";
							end
						end
						if (v22.Wrath:IsCastable() and not v6:IsMoving() and v36 and (not v34 or (v35 < v22.Wrath:CastTime()))) then
							if v16(v22.Wrath) then
								return "wrath main 20";
							end
						end
						if (v22.Starfire:IsCastable() and (not v6:IsMoving() or v6:BuffUp(v22.WarriorofEluneBuff)) and not v36 and (not v34 or (v35 < v22.Starfire:CastTime()))) then
							if v16(v22.Starfire) then
								return "starfire main 22";
							end
						end
						if (v14() and (v46 > (530 - (406 + 123))) and v22.Starfall:IsAvailable()) then
							local v150 = v93();
							if v150 then
								return v150;
							end
						end
						local v149 = v92();
						if v149 then
							return v149;
						end
						if v13.CastAnnotated(v22.Pool, false, "WAIT") then
							return "Pool Resources";
						end
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
	local v138 = {Starlordvalue=v22.StarlordBuff:Name()};
	local v139 = "/cancelaura {Starlordvalue}";
	v13:UpdateMacro("macro1", v85(v139, v138));
	v13:UpdateMacro("macro2", "/use 16");
	v13:UpdateMacro("macro6", "/stopcasting");
	v13.ToggleIconFrame:AddButtonCustom("I", 1770 - (1749 + 20), "Interrupt", "interrupt");
	v13.ToggleIconFrame:AddButtonCustom("D", 1 + 1, "Dispel", "dispel");
	v13.ToggleIconFrame:AddButtonCustom("S", 1325 - (1249 + 73), "smallCDs", "smallcds");
	v13.ToggleIconFrame:AddButtonCustom("P", 2 + 2, "UseSpender", "usespender");
	v13.ToggleIconFrame:AddButtonCustom("B", 1150 - (466 + 679), "BaerForm", "bearform");
	v13.Print("Balance Druid rotation has been updated for patch 11.0.2. Last Update 07.10.2024");
end
v13.SetAPL(245 - 143, v95, v96);
