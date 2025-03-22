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
local v24 = {v23.AberrantSpellforge:ID(),v23.ImperfectAscendancySerum:ID(),v23.NeuralSynapseEnhancer:ID(),v23.SoullettingRuby:ID(),v23.SpymastersWeb:ID(),v23.TreacherousTransmitter:ID(),v23.BestinSlotsCaster:ID()};
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
local v42 = (v22.OrbitalStrike:IsAvailable() and (1047 - (214 + 713))) or (46 + 134);
local v43 = (v22.AstralInfluence:IsAvailable() and (8 + 37)) or (917 - (282 + 595));
local v44, v45;
local v46 = 12748 - (1523 + 114);
local v47 = 9986 + 1125;
local v48;
local v49, v50;
local v51, v52;
local v53, v54;
local v55, v56;
local v57, v58;
local v59, v60;
local v61, v62;
local v63, v64;
local v65, v66;
local v67;
local v68 = 0 - 0;
local function v69()
	local v95, v96 = v6:GetTrinketData(v24);
	if ((v68 < (1070 - (68 + 997))) and ((v95.ID == (1270 - (226 + 1044))) or (v96.ID == (0 - 0)) or (v95.Level == (117 - (32 + 85))) or (v96.Level == (0 + 0)) or ((v95.SpellID > (0 + 0)) and not v95.Usable) or ((v96.SpellID > (957 - (892 + 65))) and not v96.Usable))) then
		v68 = v68 + (2 - 1);
		v21(9 - 4, function()
			v69();
		end);
		return;
	end
	v49 = v95.Object;
	v50 = v96.Object;
	v51 = v95.ID;
	v52 = v96.ID;
	v53 = v95.Level;
	v54 = v96.Level;
	v55 = v95.Spell;
	v57 = v95.Range;
	v61 = v95.CastTime;
	v56 = v96.Spell;
	v58 = v96.Range;
	v62 = v96.CastTime;
	v63 = v95.Cooldown;
	v64 = v96.Cooldown;
	v65 = v95.Blacklisted;
	v66 = v96.Blacklisted;
	v59 = (v51 == v23.SpymastersWeb:ID()) or (v51 == v23.ImperfectAscendancySerum) or (v51 == v23.TreacherousTransmitter) or (v51 == v23.AberrantSpellforge);
	v60 = (v52 == v23.SpymastersWeb:ID()) or (v52 == v23.ImperfectAscendancySerum) or (v52 == v23.TreacherousTransmitter) or (v51 == v23.AberrantSpellforge);
	local v113 = v17(v49:HasUseBuff() and (v51 ~= v23.OvinaxsMercurialEgg:ID()));
	local v114 = v17(v50:HasUseBuff() and (v52 ~= v23.OvinaxsMercurialEgg:ID())) * (3 - 1);
	v67 = (350 - (87 + 263)) + v113 + v114;
end
v69();
v3:RegisterForEvent(function()
	v69();
end, "PLAYER_EQUIPMENT_CHANGED");
v3:RegisterForEvent(function()
	v46 = 11291 - (67 + 113);
	v47 = 8148 + 2963;
end, "PLAYER_REGEN_ENABLED");
v3:RegisterForEvent(function()
	v41 = (v22.IncarnationTalent:IsAvailable() and v22.Incarnation) or v22.CelestialAlignment;
	v42 = (v22.OrbitalStrike:IsAvailable() and (294 - 174)) or (v22.WhirlingStars:IsAvailable() and (59 + 21)) or (715 - 535);
	ConvokeCD = (v22.ElunesGuidance:IsAvailable() and (1012 - (802 + 150))) or (323 - 203);
	v43 = (v22.AstralInfluence:IsAvailable() and (81 - 36)) or (30 + 10);
end, "SPELLS_CHANGED", "LEARNED_SPELL_IN_TAB");
local function v70(v115)
	local v116 = 997 - (915 + 82);
	if (v115 == v22.Wrath) then
		v116 = 22 - 14;
		if v22.WildSurges:IsAvailable() then
			v116 = v116 + 2 + 0;
		end
		if (v22.SouloftheForest:IsAvailable() and v6:BuffUp(v22.EclipseSolar)) then
			v116 = v116 * (1.6 - 0);
		end
	elseif (v115 == v22.Starfire) then
		v116 = 1197 - (1069 + 118);
		if v22.WildSurges:IsAvailable() then
			v116 = v116 + (4 - 2);
		end
		if v6:BuffUp(v22.WarriorofEluneBuff) then
			v116 = v116 * (1.4 - 0);
		end
		if (v22.SouloftheForest:IsAvailable() and v6:BuffUp(v22.EclipseLunar)) then
			local v142 = 1 + 0 + ((0.2 - 0) * v45);
			if (v142 > (1.6 + 0)) then
				v142 = 792.6 - (368 + 423);
			end
			v116 = v116 * v142;
		end
	elseif (v115 == v22.Moonfire) then
		v116 = 18 - 12;
		if v22.MoonGuardian:IsAvailable() then
			v116 = v116 + (20 - (10 + 8));
		end
	elseif (v115 == v22.Sunfire) then
		v116 = 22 - 16;
	elseif (v115 == v22.NewMoon) then
		v116 = 452 - (416 + 26);
	elseif (v115 == v22.HalfMoon) then
		v116 = 63 - 43;
	elseif (v115 == v22.FullMoon) then
		v116 = 18 + 22;
	elseif (v115 == v22.ForceofNature) then
		v116 = 35 - 15;
	end
	return v116;
end
local function v71(v117)
	return v117:DebuffRefreshable(v22.MoonfireDebuff) and ((v117:TimeToDie() - v117:DebuffRemains(v22.MoonfireDebuff)) > (444 - (145 + 293))) and (not v22.TreantsoftheMoon:IsAvailable() or ((v45 - v22.MoonfireDebuff:AuraActiveCount()) > (436 - (44 + 386))) or ((v22.ForceofNature:CooldownRemains() > (1489 - (998 + 488))) and v6:BuffDown(v22.HarmonyoftheGroveBuff)));
end
local function v72(v118)
	return (v118:DebuffRemains(v22.MoonfireDebuff) < (1 + 2)) and (not v22.TreantsoftheMoon:IsAvailable() or ((v22.ForceofNature:CooldownRemains() > (3 + 0)) and v6:BuffDown(v22.HarmonyoftheGroveBuff)));
end
local function v73(v119)
	return v119:DebuffRefreshable(v22.MoonfireDebuff) and (not v22.TreantsoftheMoon:IsAvailable() or ((v22.ForceofNature:CooldownRemains() > (775 - (201 + 571))) and v6:BuffDown(v22.HarmonyoftheGroveBuff)));
end
local function v74(v120)
	return v120:DebuffRefreshable(v22.StellarFlareDebuff) and ((v120:TimeToDie() - v120:DebuffRemains(v22.StellarFlareDebuff)) > ((1145 - (116 + 1022)) + v45));
end
local function v75(v121)
	return v121:DebuffRefreshable(v22.StellarFlareDebuff) and ((v121:TimeToDie() - v121:DebuffRemains(v22.StellarFlareDebuff)) > ((29 - 22) + v45));
end
local function v76(v122)
	return v122:DebuffRefreshable(v22.SunfireDebuff) and ((v122:TimeToDie() - v122:DebuffRemains(v22.SunfireDebuff)) > ((4 + 2) - (v45 / (7 - 5))));
end
local function v77(v123)
	return (v123:DebuffRemains(v22.SunfireDebuff) < (10 - 7)) or v123:DebuffRefreshable(v22.SunfireDebuff);
end
local function v78(v124)
	return v124:DebuffRefreshable(v22.SunfireDebuff);
end
local function v79(v125)
	return v125:NPCID() == (205419 - (814 + 45));
end
local function v80(v126)
	return v126:CastSpellID() == (1007281 - 598476);
end
local function v81()
	return (v12:Exists() or not v28.Balance.CursorCheck) and not v6:IsCameraBusy();
end
local function v82()
	if v25.TargetIsValid() then
		local v137 = 3 + 37;
		local v138 = v6:GetEnemiesInRange(v137);
		local v139 = 0 + 0;
		for v140, v141 in ipairs(v138) do
			if v141:AffectingCombat() then
				v139 = v139 + (886 - (261 + 624));
			end
		end
		v139 = math.max(v139, 1 - 0);
		return v139;
	else
		return #(v6:GetEnemiesInRange(1120 - (1020 + 60)));
	end
end
local function v83()
	return v6:ChannelSpellID() == (392951 - (630 + 793));
end
local function v84(v127, v128)
	return (v127:gsub("{(.-)}", v128));
end
local v85;
local function v86(v129)
	return (v129 ~= "Not Used") and ((((v129 == "with Cooldowns") or ((v129 == "small CDs") and v28.Balance_CDUSE.smallcdswithCooldowns) or (v129 == "with Cooldowns or AoE") or (v129 == "on Enemycount or Cooldowns") or (v129 == "on Boss or with Cooldowns")) and v15()) or (v129 == "always") or (((v129 == "on Boss only") or (v129 == "on Boss or on Enemycount") or (v129 == "on Boss or with Cooldowns")) and (v85 or v8:IsDummy())) or ((v129 == "with Bloodlust only") and v6:BloodlustUp()) or ((v129 == "small CDs") and Smallcds) or (((v129 == "on AOE") or (v129 == "with Cooldowns or AoE")) and (v45 >= (6 - 4))) or (((v129 == "on Enemycount or Cooldowns") or (v129 == "on Enemycount") or (v129 == "on Boss or on Enemycount")) and (v45 >= v28.Balance_CDUSE.Enemycount)));
end
local function v87(v130)
	return (v85 and v28.Balance_TTD.IgnoreWhenBoss) or v25.Buggedmobs[v8:NPCID()] or (v25.ISSolo() and v28.Balance_TTD.IgnoreWhenSolo) or (v130 == (0 - 0)) or ((v47 >= v130) and (v47 < (3063 + 4714)));
end
local function v88()
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
	if (v22.NaturesVigil:IsCastable() and v6:AffectingCombat() and (v28.Balance.Defensives.NaturesVigilCount ~= (0 - 0)) and (v28.Balance.Defensives.NaturesVigilHP ~= (1747 - (760 + 987))) and v25.AoELogicWithCount(v28.Balance.Defensives.NaturesVigilHP, v28.Balance.Defensives.NaturesVigilCount, nil, v48)) then
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
	if (v22.Ironfur:IsCastable() and v6:BuffUp(v22.BearForm) and v6:BuffDown(v22.Ironfur) and (v6:Rage() >= (1953 - (1789 + 124))) and (v6:HealthPercentage() <= v28.Balance.Defensives.IronfurHP)) then
		if v16(v22.Ironfur) then
			return "Ironfur";
		end
	end
	if (v22.BearForm:IsCastable() and v6:AffectingCombat() and v6:BuffUp(v22.MoonkinForm) and (v6:HealthPercentage() <= v28.Balance.Defensives.BearFormHP)) then
		if v16(v22.BearForm) then
			return "BearForm";
		end
	end
	if (v22.MoonkinForm:IsCastable() and v6:BuffUp(v22.BearForm) and (v6:HealthPercentage() > v28.Balance.Defensives.MoonkinFormHP) and (v28.Balance.Defensives.MoonkinFormHP > (766 - (745 + 21)))) then
		if v16(v22.MoonkinForm) then
			return "MoonkinForm";
		end
	end
end
local function v89()
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
	if (v22.Wrath:IsCastable() and not v6:IsMoving() and ((v6:IsCasting(v22.Wrath) and (v22.Wrath:Count() == (1 + 1))) or (v6:PrevGCD(2 - 1, v22.Wrath) and (v22.Wrath:Count() == (3 - 2))))) then
		if v16(v22.Wrath) then
			return "wrath precombat 4";
		end
	end
	if (v22.Starfire:IsCastable() and (not v6:IsMoving() or v6:BuffUp(v22.WarriorofEluneBuff)) and not v22.StellarFlare:IsAvailable() and (v6:HeroTreeID() == (1 + 23))) then
		if v16(v22.Starfire) then
			return "starfire precombat 6";
		end
	end
end
local function v90()
	if (v15() and v22.Berserking:IsCastable() and v32) then
		if v16(v22.Berserking, true) then
			return "berserking pre_cd 4";
		end
	end
	if (v28.Commons.Enabled.Items and v23.BestinSlotsCaster:IsEquippedAndReady() and (((v6:HeroTreeID() == (19 + 4)) and v6:BuffUp(v22.HarmonyoftheGroveBuff)) or ((v6:HeroTreeID() == (1079 - (87 + 968))) and ((CaInc:FullRechargeTime() > (88 - 68)) or v39)))) then
		v13.CastMacro(1 + 0, nil, nil, v23.BestinSlotsCaster);
		return "use_items trinket2 (" .. v50:Name() .. ") pre_cd 10";
	end
end
local function v91()
	if (v22.WarriorofElune:IsCastable() and IsWarriorofElune and (v22.LunarCalling:IsAvailable() or (not v22.LunarCalling:IsAvailable() and (v35 <= (15 - 8))))) then
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
		if v25.CastCycle(v22.Sunfire, v44, v77, v43) then
			return "sunfire st 2";
		end
	end
	if (v22.Moonfire:IsCastable() and (not v22.ForceofNature:IsAvailable() or (v22.ForceofNature:CooldownRemains() > (1418 - (447 + 966))) or not IsForceofNature or not v22.TreantsoftheMoon:IsAvailable())) then
		if v25.CastCycle(v22.Moonfire, v44, v72, v43) then
			return "moonfire st 4";
		end
	end
	local v131 = v90();
	if v131 then
		return v131;
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
	if (v22.Starsurge:IsReady() and v43 and v32 and (v6:AstralPowerDeficit() > (v29 + v70(v22.ForceofNature)))) then
		if v16(v22.Starsurge) then
			return "starsurge st 20";
		end
	end
	if (v22.ForceofNature:IsCastable() and IsForceofNature and (((v41:CooldownRemains() < v6:GCD()) and (not v22.ConvoketheSpirits:IsAvailable() or (v22.ConvoketheSpirits:CooldownRemains() < (v6:GCD() * (8 - 5))) or (v22.ConvoketheSpirits:CooldownRemains() > v41:FullRechargeTime()) or (v47 < (v22.ConvoketheSpirits:CooldownRemains() + (1820 - (1703 + 114)))))) or (((v41:FullRechargeTime() + (706 - (376 + 325)) + ((24 - 9) * v17(v22.ControloftheDream:IsAvailable()))) > (184 - 124)) and (not v22.ConvoketheSpirits:IsAvailable() or ((v22.ConvoketheSpirits:CooldownRemains() + 3 + 7 + ((32 - 17) * v17(v22.ControloftheDream:IsAvailable()))) > (74 - (9 + 5))) or (v47 < (v22.ConvoketheSpirits:CooldownRemains() + ConvokeCD + (381 - (85 + 291))))) and ((v47 > (1330 - (243 + 1022))) or (v47 < (v41:CooldownRemains() + (26 - 19))))) or (v22.WhirlingStars:IsAvailable() and v22.ConvoketheSpirits:IsAvailable() and (v22.ConvoketheSpirits:CooldownRemains() > (42 + 8)) and (v47 > (v22.ConvoketheSpirits:CooldownRemains() + (1186 - (1123 + 57))))))) then
		if v16(v22.ForceofNature, true) then
			return "force_of_nature st 22";
		end
	end
	if (v22.FuryofElune:IsCastable() and IsFuryofElune and ((5 + 0 + v29) < v6:AstralPowerDeficit())) then
		if v16(v22.FuryofElune, true) then
			return "fury_of_elune st 12";
		end
	end
	if (v22.Starfall:IsReady() and (v6:BuffUp(v22.StarweaversWarp))) then
		if v16(v22.Starfall, true, nil, RangeformagicSpells) then
			return "starfall st 26";
		end
	end
	if (v22.Starsurge:IsReady() and UseSpender and v22.Starlord:IsAvailable() and (v6:BuffStack(v22.StarlordBuff) < (257 - (163 + 91)))) then
		if v16(v22.Starsurge) then
			return "starsurge st 14";
		end
	end
	if v22.Sunfire:IsCastable() then
		if v25.CastCycle(v22.Sunfire, v44, v78, v43) then
			return "sunfire st 30";
		end
	end
	if v22.Moonfire:IsCastable() then
		if v25.CastCycle(v22.Moonfire, v44, v73, v43) then
			return "moonfire st 32";
		end
	end
	if v22.StellarFlare:IsCastable() then
		if v25.CastCycle(v22.StellarFlare, v44, v75, v43) then
			return "stellar_flare st 34";
		end
	end
	if (v22.Starsurge:IsReady() and UseSpender and (v22.ConvoketheSpirits:CooldownRemains() < (v6:GCD() * (1932 - (1869 + 61)))) and v38) then
		if v16(v22.Starsurge) then
			return "starsurge st 22";
		end
	end
	if (v22.ConvoketheSpirits:IsCastable() and IsConvoketheSpirits and v38) then
		if v16(v22.ConvoketheSpirits) then
			return "convoke_the_spirits st 24";
		end
	end
	if (v22.Starsurge:IsReady() and UseSpender and (((v6:BuffRemains(v22.StarlordBuff) > (2 + 2)) and (v37 >= (10 - 7))) or (v46 < (5 - 1)))) then
		if v16(v22.Starsurge) then
			return "starsurge st 26";
		end
	end
	if (v22.NewMoon:IsCastable() and not v6:IsMoving() and ((v6:AstralPowerDeficit() > (v29 + v70(v22.NewMoon))) or (v46 < (3 + 17)) or (v41:CooldownRemains() > (20 - 5)))) then
		if v16(v22.NewMoon) then
			return "new_moon st 28";
		end
	end
	if (v22.HalfMoon:IsCastable() and not v6:IsMoving() and (((v6:AstralPowerDeficit() > (v29 + v70(v22.HalfMoon))) and ((v6:BuffRemains(v22.EclipseLunar) > v22.HalfMoon:ExecuteTime()) or (v6:BuffRemains(v22.EclipseSolar) > v22.HalfMoon:ExecuteTime()))) or (v46 < (19 + 1)) or (v41:CooldownRemains() > (1489 - (1329 + 145))))) then
		if v16(v22.HalfMoon) then
			return "half_moon st 30";
		end
	end
	if (v22.FullMoon:IsCastable() and not v6:IsMoving() and (((v6:AstralPowerDeficit() > (v29 + v70(v22.FullMoon))) and ((v6:BuffRemains(v22.EclipseLunar) > v22.FullMoon:ExecuteTime()) or (v6:BuffRemains(v22.EclipseSolar) > v22.FullMoon:ExecuteTime()))) or (v46 < (991 - (140 + 831))) or (v41:CooldownRemains() > (1865 - (1409 + 441))))) then
		if v16(v22.FullMoon) then
			return "full_moon st 32";
		end
	end
	if (v22.Starsurge:IsReady() and UseSpender and (v6:BuffUp(v22.StarweaversWeft) or v6:BuffUp(v22.TouchtheCosmosStarsurge))) then
		if v16(v22.Starsurge) then
			return "starsurge st 34";
		end
	end
	if (v22.Starsurge:IsReady() and UseSpender and (v6:AstralPowerDeficit() < (v29 + v70(v22.Wrath) + ((v70(v22.Starfire) + v29) * (v17(v6:BuffRemains(v22.EclipseSolar) < (v6:GCD() * (721 - (15 + 703))))))))) then
		if v16(v22.Starsurge) then
			return "starsurge st 38";
		end
	end
	if (v22.ForceofNature:IsCastable() and IsForceofNature and (v6:HeroTreeID() ~= (11 + 12))) then
		if v16(v22.ForceofNature, true) then
			return "force_of_nature st 40";
		end
	end
	if (v22.WildMushroom:IsCastable() and IsWildMushroom and not v6:PrevGCD(439 - (262 + 176), v22.WildMushroom) and (v8:DebuffRemains(v22.FungalGrowthDebuff) < (1723 - (345 + 1376)))) then
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
		if (v22.Sunfire:IsCastable() and (v45 > (689 - (198 + 490)))) then
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
local function v92()
	local v132 = v6:IsInDungeonArea();
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
	if (v22.Starfall:IsReady() and v43 and (v6:AstralPowerDeficit() <= (v29 + (26 - 20)))) then
		if v16(v22.Starfall, true) then
			return "starfall aoe 6";
		end
	end
	if (v22.Moonfire:IsCastable() and v132) then
		if v25.CastCycle(v22.Moonfire, v44, v71, v43) then
			return "moonfire aoe 2";
		end
	end
	if v22.Sunfire:IsCastable() then
		if v25.CastCycle(v22.Sunfire, v44, v76, v43) then
			return "sunfire aoe 4";
		end
	end
	if (v22.Moonfire:IsCastable() and not v132) then
		if v25.CastCycle(v22.Moonfire, v44, v71, v43) then
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
	if (v22.StellarFlare:IsCastable() and (v45 < ((((26 - 15) - v22.UmbralIntensity:TalentRank()) - ((1208 - (696 + 510)) * v17(v22.AstralSmolder:IsAvailable()))) - v17(v22.LunarCalling:IsAvailable())))) then
		if v25.CastCycle(v22.StellarFlare, v44, v74, v43) then
			return "stellar_flare aoe 8";
		end
	end
	if (v22.ForceofNature:IsCastable() and (((v41:CooldownRemains() < v6:GCD()) and (not v34 or (v35 > (12 - 6)))) or ((v35 >= (1265 - (1091 + 171))) and (v41:CooldownRemains() > (2 + 8 + ((47 - 32) * v17(v22.ControloftheDream:IsAvailable())))) and ((v47 > (215 - 150)) or (v41:CooldownRemains() > v47))))) then
		if v16(v22.ForceofNature, true) then
			return "force_of_nature aoe 10";
		end
	end
	if (v22.FuryofElune:IsCastable() and IsFuryofElune and v34) then
		if v16(v22.FuryofElune, true) then
			return "fury_of_elune aoe 12";
		end
	end
	local v133 = v90();
	if v133 then
		return v133;
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
	if (v22.WarriorofElune:IsCastable() and IsWarriorofElune and ((not v22.LunarCalling:IsAvailable() and (v6:BuffRemains(v22.EclipseSolar) < (381 - (123 + 251)))) or v22.LunarCalling:IsAvailable())) then
		if v16(v22.WarriorofElune, true) then
			return "warrior_of_elune aoe 18";
		end
	end
	if (v22.Starfire:IsCastable() and (not v6:IsMoving() or v6:BuffUp(v22.WarriorofEluneBuff)) and not v22.LunarCalling:IsAvailable() and (v45 == (4 - 3)) and ((v6:BuffUp(v22.EclipseSolar) and (v6:BuffRemains(v22.EclipseSolar) < v22.Starfire:CastTime())) or not v34)) then
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
	if (v22.ConvoketheSpirits:IsCastable() and IsConvoketheSpirits and ((v6:BuffDown(v22.DreamstateBuff) and v6:BuffDown(v22.UmbralEmbraceBuff) and (v45 < (705 - (208 + 490)))) or (v45 == (1 + 0))) and ((v46 < (3 + 2)) or ((v39 or (v41:CooldownRemains() > (876 - (660 + 176)))) and ((v6:HeroTreeID() ~= (5 + 29)) or v6:BuffUp(v22.HarmonyoftheGroveBuff) or (v22.ForceofNature:CooldownRemains() > (217 - (14 + 188))))))) then
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
	if (v22.ForceofNature:IsCastable() and IsForceofNature and (v6:HeroTreeID() ~= (698 - (534 + 141)))) then
		if v16(v22.ForceofNature, true) then
			return "force_of_nature aoe 48";
		end
	end
	if (v22.Starfire:IsCastable() and (not v6:IsMoving() or v6:BuffUp(v22.WarriorofEluneBuff)) and (v22.LunarCalling:IsAvailable() or (v6:BuffUp(v22.EclipseLunar) and (v45 > (1 + 0))))) then
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
local function v93()
	v25.HealthPotions();
	if v25.ShouldStopCastUpdate() then
		v13.CastMacro(6 + 0, true);
		return "Stop Cast For Silence";
	end
	InterruptToggle = v13.ToggleIconFrame:GetToggle(1 + 0);
	DispelToggle = v13.ToggleIconFrame:GetToggle(3 - 1);
	Smallcds = v13.ToggleIconFrame:GetToggle(4 - 1);
	UseSpender = v13.ToggleIconFrame:GetToggle(11 - 7);
	local v134 = not v6:AffectingCombat() or not v8:AffectingCombat() or v8:IsDummy();
	Enemies40Yard = v6:GetEnemiesInRange(22 + 18);
	EnemiesRangeOOCCount = v82() or #Enemies40Yard;
	v48 = v25.UnitsinRange(v22.Regrowth);
	v44 = v8:GetEnemiesInSplashRange(7 + 3);
	if v14() then
		v45 = (v134 and #Enemies40Yard) or EnemiesRangeOOCCount;
	else
		v45 = 397 - (115 + 281);
	end
	IsRacials = v87(v28.Balance_TTD.RacialsTTD) and v86(v28.Balance_CDUSE.Racials);
	IsPotions = v87(v28.Balance_TTD.PotionsTTD) and (v28.Balance_CDUSE.Potionswhensolo or (not v28.Balance_CDUSE.Potionswhensolo and not v25.ISSolo())) and v86(v28.Balance_CDUSE.Potions);
	IsTrinket1 = v87(v28.Balance_TTD.TrinketsTTD) and v86(v28.Balance_CDUSE.Trinket1);
	IsTrinket2 = v87(v28.Balance_TTD.TrinketsTTD) and v86(v28.Balance_CDUSE.Trinket2);
	IsIncarnation = (not v22.OrbitalStrike:IsAvailable() or v81()) and v87(v28.Balance_TTD.IncarnationTTD) and v86(v28.Balance_CDUSE.Incarnation);
	IsWarriorofElune = v87(v28.Balance_TTD.WarriorofEluneTTD) and v86(v28.Balance_CDUSE.WarriorofElune);
	IsForceofNature = v81() and v87(v28.Balance_TTD.ForceofNatureTTD) and v86(v28.Balance_CDUSE.ForceofNature);
	IsWildMushroom = v87(v28.Balance_TTD.WildMushroomTTD) and v86(v28.Balance_CDUSE.WildMushroom);
	IsFuryofElune = v87(v28.Balance_TTD.FuryofEluneTTD) and v86(v28.Balance_CDUSE.FuryofElune);
	IsConvoketheSpirits = v87(v28.Balance_TTD.ConvoketheSpiritsTTD) and v86(v28.Balance_CDUSE.ConvoketheSpirits);
	if (v25.TargetIsValid() or (v6:AffectingCombat() and v8 and v8:AffectingCombat())) then
		TargetinRange = v8:IsSpellInRange(v22.Wrath);
		v46 = v3.BossFightRemains();
		v85 = true;
		v47 = v46;
		if (v47 == (25844 - 14733)) then
			v85 = false;
			v47 = v3.FightRemains(v44, false);
		end
		v39 = (v22.IncarnationTalent:IsAvailable() and (v6:BuffUp(v22.IncarnationBuff1) or v6:BuffUp(v22.IncarnationBuff2))) or v6:BuffUp(v22.CABuff1) or v6:BuffUp(v22.CABuff2);
		v40 = 0 + 0;
		if v39 then
			v40 = (v22.IncarnationTalent:IsAvailable() and v20(v6:BuffRemains(v22.IncarnationBuff1), v6:BuffRemains(v22.IncarnationBuff2))) or v20(v6:BuffRemains(v22.CABuff1), v6:BuffRemains(v22.CABuff2));
		end
	end
	if (v22.MarkoftheWild:IsCastable() and not v6:DebuffUp(v22.Corruption) and ((v25.GroupBuffMissing(v22.MarkoftheWildBuff) and (v28.Commons.MarkoftheWild == "check whole group") and (v6:IsInRaidArea() or v6:IsInDungeonArea()) and (v6:InstanceDifficulty() ~= (495 - 290))) or (v6:BuffDown(v22.MarkoftheWildBuff, true) and ((v28.Commons.MarkoftheWild == "only check us") or (v28.Commons.MarkoftheWild == "check whole group"))))) then
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
		v19 = not v6:IsCasting(v22.Hibernate) and v25.IncorpCycle(v22.Hibernate, 128 - 93, false, false);
		if v19 then
			return v19;
		end
	end
	if DispelToggle then
		v19 = v6:AffectingCombat() and v25.SootheCycle(v22.Soothe, 912 - (550 + 317), false, v28.Balance.TabForSoothe);
		if v19 then
			return v19;
		end
		if (v22.RemoveCorruption:IsCastable() and v6:IsInDungeonArea() and v6:IsInParty()) then
			v19 = v25.DispelCycle(v22.RemoveCorruption, "Poison", nil, v48);
			if v19 then
				return v19;
			end
			v19 = v25.DispelCycle(v22.RemoveCorruption, "Curse", nil, v48);
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
	v19 = v88();
	if v19 then
		return v19;
	end
	if (v25.TargetIsValid() and v6:BuffDown(v22.TravelFormBuff)) then
		if (not v28.Balance.AttackonlyinCombat or (v28.Balance.AttackonlyinCombat and v8:AffectingCombat())) then
			if not v79(v5.Target) then
				if TargetinRange then
					if not v6:AffectingCombat() then
						local v144 = v6:BuffDown(v22.BearForm) and v89();
						if v144 then
							return v144;
						end
					end
					if (InterruptToggle and not v83()) then
						v19 = v25.InterruptCycle(v22.SolarBeam, 57 - 17, true, nil, false);
						if v19 then
							return v19;
						end
						v19 = v25.InterruptCycle(v22.MightyBash, 10 - 2, false, nil, true);
						if v19 then
							return v19;
						end
					end
					v29 = ((16 - 10) / v6:SpellHaste()) + v17(v22.NaturesBalance:IsAvailable()) + (v17(v22.OrbitBreaker:IsAvailable()) * v17(v22.MoonfireDebuff:AuraActiveCount() > (285 - (134 + 151))) * v17(v26.OrbitBreakerStacks > ((1692 - (970 + 695)) - ((3 - 1) * v17(v6:BuffUp(v22.SolsticeBuff))))) * (2014 - (582 + 1408)));
					v30 = v20(v41:CooldownRemains(), v22.ForceofNature:CooldownRemains());
					v31 = v46 < (v42 + v30);
					v32 = ((v46 < (((52 - 37) + ((6 - 1) * v17(v22.Incarnation:IsAvailable()))) * ((3 - 2) - (v17(v22.WhirlingStars:IsAvailable()) * (1824.2 - (1195 + 629)))))) or ((v8:TimeToDie() > (13 - 3)) and ((v6:HeroTreeID() ~= (264 - (187 + 54))) or v6:BuffUp(v22.HarmonyoftheGroveBuff)) and (not v22.WhirlingStars:IsAvailable() or not v22.ConvoketheSpirits:IsAvailable() or (v22.ConvoketheSpirits:CooldownRemains() < (v6:GCD() * (782 - (162 + 618)))) or (v46 < (v22.ConvoketheSpirits:CooldownRemains() + 3 + 0)) or (v22.ConvoketheSpirits:CooldownRemains() > v41:FullRechargeTime())))) and v41:CooldownUp() and not v39;
					v38 = (v46 < (4 + 1)) or ((v39 or (v41:CooldownRemains() > (85 - 45))) and ((v6:HeroTreeID() ~= (38 - 15)) or v6:BuffUp(v22.HarmonyoftheGroveBuff) or (v22.ForceofNature:CooldownRemains() > (2 + 13))));
					v34 = v6:BuffUp(v22.EclipseLunar) or v6:BuffUp(v22.EclipseSolar);
					v35 = v20(v6:BuffRemains(v22.EclipseLunar), v6:BuffRemains(v22.EclipseSolar));
					v36 = v22.LunarCalling:IsAvailable() or (v45 > ((1638 - (1373 + 263)) - v17((v22.UmbralIntensity:TalentRank() + v17(v22.SouloftheForest:IsAvailable())) > (1001 - (451 + 549)))));
					v37 = v6:BuffStack(v22.BOATArcaneBuff) + v6:BuffStack(v22.BOATNatureBuff);
					v33 = (not v22.CelestialAlignment:IsAvailable() and not v22.Incarnation:IsAvailable()) or not v15();
					if v28.Commons.Enabled.Trinkets then
						if (v23.AberrantSpellforge:IsEquippedAndReady() and (((v49:ID() == v23.AberrantSpellforge:ID()) and IsTrinket1) or ((v50:ID() == v23.AberrantSpellforge:ID()) and IsTrinket2))) then
							if v16(v23.AberrantSpellforge, true) then
								return "aberrant_spellforge main 2";
							end
						end
						if (v23.SpymastersWeb:IsEquippedAndReady() and (((v49:ID() == v23.SpymastersWeb:ID()) and IsTrinket1) or ((v50:ID() == v23.SpymastersWeb:ID()) and IsTrinket2)) and ((v32 and ((v6:BuffStack(v22.SpymastersReportBuff) > (10 + 19)) or (v46 < v42))) or (v46 < (31 - 11)))) then
							if v16(v23.SpymastersWeb, true) then
								return "spymasters_web main 4";
							end
						end
						if (v23.ImperfectAscendancySerum:IsEquippedAndReady() and (((v49:ID() == v23.ImperfectAscendancySerum:ID()) and IsTrinket1) or ((v50:ID() == v23.ImperfectAscendancySerum:ID()) and IsTrinket2)) and (v8:DebuffRemains(v22.SunfireDebuff) > (6 - 2)) and ((v8:DebuffRemains(v22.MoonfireDebuff) > (1388 - (746 + 638))) or (v22.TreantsoftheMoon:IsAvailable() and ((v22.ForceofNature:CooldownRemains() < (2 + 1)) or v6:BuffUp(v22.HarmonyoftheGroveBuff)) and (v30 < (1 - 0))) or (v46 < (361 - (218 + 123))) or ((v46 < v30) and (v6:BuffUp(v22.HarmonyoftheGroveBuff) or v22.ConvoketheSpirits:CooldownUp()))) and (v6:BuffStack(v22.SpymastersReportBuff) <= (1610 - (1535 + 46)))) then
							if v16(v23.ImperfectAscendancySerum, true) then
								return "imperfect_ascendancy_serum main 6";
							end
						end
						if (v23.TreacherousTransmitter:IsEquippedAndReady() and (((v49:ID() == v23.TreacherousTransmitter:ID()) and IsTrinket1) or ((v50:ID() == v23.TreacherousTransmitter:ID()) and IsTrinket2)) and ((v30 < (3 + 0)) or (v46 < (3 + 17)) or ((v46 < v30) and (v6:BuffUp(v22.HarmonyoftheGroveBuff) or v22.ConvoketheSpirits:CooldownUp()))) and (v6:BuffStack(v22.SpymastersReportBuff) <= (589 - (306 + 254)))) then
							if v16(v23.TreacherousTransmitter, true) then
								return "treacherous_transmitter main 8";
							end
						end
					end
					VarGenericTrinketCondition = v33 or ((v46 < v30) and (v6:BuffUp(v22.HarmonyoftheGroveBuff) or v22.ConvoketheSpirits:CooldownUp())) or ((((v6:BuffStack(v22.SpymastersReportBuff) + (v30 / (1 + 5))) > (56 - 27)) or (v46 < (v42 + v30))) and (v30 > (1487 - (899 + 568)))) or (v67 == (0 + 0));
					if v28.Commons.Enabled.Trinkets then
						if (v49:IsReady() and v8:IsInRange(v57) and IsTrinket1 and not v59 and not v65 and (((v67 ~= (2 - 1)) and (v50:CooldownRemains() > (623 - (268 + 335)))) or (((v67 == (291 - (60 + 230))) or (v67 == (575 - (426 + 146)))) and v32) or (v46 < (3 + 17 + ((1476 - (282 + 1174)) * v17(v50:CooldownRemains() < (836 - (569 + 242)))))) or VarGenericTrinketCondition)) then
							if v16(v49, true) then
								return "use_items trinket1 (" .. v49:Name() .. ") main 10";
							end
						end
						if (v50:IsReady() and v8:IsInRange(v58) and IsTrinket2 and not v60 and not v66 and (((v67 ~= (5 - 3)) and (v49:CooldownRemains() > (2 + 18))) or ((v67 == (1026 - (706 + 318))) and v32) or (v46 < ((1271 - (721 + 530)) + ((1291 - (945 + 326)) * v17(v49:CooldownRemains() < (62 - 37))))) or VarGenericTrinketCondition)) then
							if v16(v50, true) then
								return "use_items trinket2 (" .. v50:Name() .. ") main 12";
							end
						end
					end
					if (v28.Commons.Enabled.Potions and (v39 or (v46 <= (27 + 3)))) then
						local v145 = v25.PotionSelected();
						if (v145 and v145:IsReady() and IsPotions) then
							v13.CastMacro(703 - (271 + 429), nil, nil, v145);
							return "potion main 14";
						end
					end
					if v6:BuffUp(v22.BearForm) then
						if (v22.ThrashBear:IsCastable() and v8:IsInRange(5 + 0) and v8:DebuffRefreshable(v22.ThrashBearDebuff)) then
							if v16(v22.Thrashcast) then
								return "thrash bear";
							end
						end
						if (v22.Mangle:IsCastable() and v8:IsInRange(1505 - (1408 + 92)) and (v8:DebuffUp(v22.ThrashBearDebuff) or not v22.ThrashBear:IsAvailable())) then
							if v16(v22.Mangle) then
								return "Mangle bear";
							end
						end
						if (v22.Swipe:IsCastable() and v8:IsInRange(1091 - (461 + 625))) then
							if v16(v22.Swipecast) then
								return "Swipe bear";
							end
						end
						if (v22.ThrashBear:IsCastable() and v8:IsInRange(1293 - (993 + 295))) then
							if v16(v22.Thrashcast) then
								return "thrash bear";
							end
						end
					end
					if (v22.Berserking:IsCastable() and IsRacials and (v32 or v33 or (v46 < (1 + 14)))) then
						if v16(v22.Berserking, true) then
							return "berserking main 16";
						end
					end
					v34 = v6:BuffUp(v22.EclipseLunar) or v6:BuffUp(v22.EclipseSolar);
					v35 = v20(v6:BuffRemains(v22.EclipseLunar), v6:BuffRemains(v22.EclipseSolar));
					v36 = v22.LunarCalling:IsAvailable() or (v45 > ((1173 - (418 + 753)) - v17((v22.UmbralIntensity:TalentRank() + v17(v22.SouloftheForest:IsAvailable())) > (1 + 0))));
					v37 = v6:BuffStack(v22.BOATArcaneBuff) + v6:BuffStack(v22.BOATNatureBuff);
					if (v22.WarriorofElune:IsCastable() and IsWarriorofElune and (v22.LunarCalling:IsAvailable() or ((v35 >= (1 + 6)) and (v41:CooldownRemains() > (6 + 14))))) then
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
					if (v14() and (v45 > (1 + 0)) and v22.Starfall:IsAvailable()) then
						local v146 = v92();
						if v146 then
							return v146;
						end
					end
					local v143 = v91();
					if v143 then
						return v143;
					end
					if v13.CastAnnotated(v22.Pool, false, "WAIT") then
						return "Pool Resources";
					end
				end
			end
		end
	end
end
local function v94()
	v13.ResetToggle();
	v22.MoonfireDebuff:RegisterAuraTracking();
	v28.Balance.Display();
	local v135 = {Starlordvalue=v22.StarlordBuff:Name()};
	local v136 = "/cancelaura {Starlordvalue}";
	v13:UpdateMacro("macro1", v84(v136, v135));
	v13:UpdateMacro("macro2", "/use 16");
	v13:UpdateMacro("macro6", "/stopcasting");
	v13.ToggleIconFrame:AddButtonCustom("I", 530 - (406 + 123), "Interrupt", "interrupt");
	v13.ToggleIconFrame:AddButtonCustom("D", 1771 - (1749 + 20), "Dispel", "dispel");
	v13.ToggleIconFrame:AddButtonCustom("S", 1 + 2, "smallCDs", "smallcds");
	v13.ToggleIconFrame:AddButtonCustom("P", 1326 - (1249 + 73), "UseSpender", "usespender");
	v13.Print("Balance Druid rotation has been updated for patch 11.0.2. Last Update 07.10.2024");
end
v13.SetAPL(37 + 65, v93, v94);
