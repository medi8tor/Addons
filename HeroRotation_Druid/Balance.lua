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
local v42 = (v22.OrbitalStrike:IsAvailable() and (343 - 223)) or (347 - 167);
local v43 = (v22.AstralInfluence:IsAvailable() and (115 - 70)) or (659 - (555 + 64));
local v44 = false;
local v45, v46;
local v47 = 12042 - (857 + 74);
local v48 = 11679 - (367 + 201);
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
local v69 = 927 - (214 + 713);
local function v70()
	local v95, v96 = v6:GetTrinketData(v24);
	if ((v69 < (2 + 3)) and ((v95.ID == (0 + 0)) or (v96.ID == (877 - (282 + 595))) or (v95.Level == (1637 - (1523 + 114))) or (v96.Level == (0 + 0)) or ((v95.SpellID > (0 - 0)) and not v95.Usable) or ((v96.SpellID > (1065 - (68 + 997))) and not v96.Usable))) then
		v69 = v69 + (1271 - (226 + 1044));
		v21(21 - 16, function()
			v70();
		end);
		return;
	end
	v50 = v95.Object;
	v51 = v96.Object;
	v52 = v95.ID;
	v53 = v96.ID;
	v54 = v95.Level;
	v55 = v96.Level;
	v56 = v95.Spell;
	v58 = v95.Range;
	v62 = v95.CastTime;
	v57 = v96.Spell;
	v59 = v96.Range;
	v63 = v96.CastTime;
	v64 = v95.Cooldown;
	v65 = v96.Cooldown;
	v66 = v95.Blacklisted;
	v67 = v96.Blacklisted;
	v60 = (v52 == v23.SpymastersWeb:ID()) or (v52 == v23.ImperfectAscendancySerum) or (v52 == v23.TreacherousTransmitter) or (v52 == v23.AberrantSpellforge);
	v61 = (v53 == v23.SpymastersWeb:ID()) or (v53 == v23.ImperfectAscendancySerum) or (v53 == v23.TreacherousTransmitter) or (v52 == v23.AberrantSpellforge);
	local v113 = v17(v50:HasUseBuff() and (v52 ~= v23.OvinaxsMercurialEgg:ID()));
	local v114 = v17(v51:HasUseBuff() and (v53 ~= v23.OvinaxsMercurialEgg:ID())) * (119 - (32 + 85));
	v68 = 0 + 0 + v113 + v114;
end
v70();
v3:RegisterForEvent(function()
	v70();
end, "PLAYER_EQUIPMENT_CHANGED");
v3:RegisterForEvent(function()
	v47 = 2464 + 8647;
	v48 = 12068 - (892 + 65);
end, "PLAYER_REGEN_ENABLED");
v3:RegisterForEvent(function()
	v41 = (v22.IncarnationTalent:IsAvailable() and v22.Incarnation) or v22.CelestialAlignment;
	v42 = (v22.OrbitalStrike:IsAvailable() and (286 - 166)) or (332 - 152);
	v43 = (v22.AstralInfluence:IsAvailable() and (82 - 37)) or (390 - (87 + 263));
end, "SPELLS_CHANGED", "LEARNED_SPELL_IN_TAB");
local function v71(v115)
	local v116 = 180 - (67 + 113);
	if (v115 == v22.Wrath) then
		v116 = 6 + 2;
		if v22.WildSurges:IsAvailable() then
			v116 = v116 + (4 - 2);
		end
		if (v22.SouloftheForest:IsAvailable() and v6:BuffUp(v22.EclipseSolar)) then
			v116 = v116 * (1.6 + 0);
		end
	elseif (v115 == v22.Starfire) then
		v116 = 39 - 29;
		if v22.WildSurges:IsAvailable() then
			v116 = v116 + (954 - (802 + 150));
		end
		if v6:BuffUp(v22.WarriorofEluneBuff) then
			v116 = v116 * (2.4 - 1);
		end
		if (v22.SouloftheForest:IsAvailable() and v6:BuffUp(v22.EclipseLunar)) then
			local v140 = (1 - 0) + ((0.2 + 0) * v46);
			if (v140 > (998.6 - (915 + 82))) then
				v140 = 2.6 - 1;
			end
			v116 = v116 * v140;
		end
	elseif (v115 == v22.Moonfire) then
		v116 = 4 + 2;
		if v22.MoonGuardian:IsAvailable() then
			v116 = v116 + (2 - 0);
		end
	elseif (v115 == v22.Sunfire) then
		v116 = 1193 - (1069 + 118);
	elseif (v115 == v22.NewMoon) then
		v116 = 22 - 12;
	elseif (v115 == v22.HalfMoon) then
		v116 = 43 - 23;
	elseif (v115 == v22.FullMoon) then
		v116 = 7 + 33;
	end
	return v116;
end
local function v72(v117)
	return v117:DebuffRefreshable(v22.MoonfireDebuff) and ((v117:TimeToDie() - v8:DebuffRemains(v22.MoonfireDebuff)) > (10 - 4)) and (v6:AstralPowerDeficit() > (v29 + v22.Moonfire:EnergizeAmount()));
end
local function v73(v118)
	return (v118:DebuffRemains(v22.MoonfireDebuff) < (3 + 0)) and (not v22.TreantsoftheMoon:IsAvailable() or ((v22.ForceofNature:CooldownRemains() > (794 - (368 + 423))) and v6:BuffDown(v22.HarmonyoftheGroveBuff)));
end
local function v74(v119)
	return v119:DebuffRefreshable(v22.MoonfireDebuff) and (not v22.TreantsoftheMoon:IsAvailable() or ((v22.ForceofNature:CooldownRemains() > (9 - 6)) and v6:BuffDown(v22.HarmonyoftheGroveBuff)));
end
local function v75(v120)
	return v120:DebuffRefreshable(v22.StellarFlareDebuff) and ((v120:TimeToDie() - v120:DebuffRemains(v22.StellarFlareDebuff)) > ((25 - (10 + 8)) + v46));
end
local function v76(v121)
	return v121:DebuffRefreshable(v22.StellarFlareDebuff) and ((v121:TimeToDie() - v121:DebuffRemains(v22.StellarFlareDebuff)) > ((26 - 19) + v46));
end
local function v77(v122)
	return v122:DebuffRefreshable(v22.SunfireDebuff) and ((v122:TimeToDie() - v8:DebuffRemains(v22.SunfireDebuff)) > ((448 - (416 + 26)) - (v46 / (6 - 4)))) and (v6:AstralPowerDeficit() > (v29 + v22.Sunfire:EnergizeAmount()));
end
local function v78(v123)
	return v123:DebuffRemains(v22.SunfireDebuff) < (2 + 1);
end
local function v79(v124)
	return v124:DebuffRefreshable(v22.SunfireDebuff);
end
local function v80(v125)
	return v125:NPCID() == (361955 - 157395);
end
local function v81(v126)
	return v126:CastSpellID() == (409243 - (145 + 293));
end
local function v82()
	return (v12:Exists() or not v28.Balance.CursorCheck) and not v6:IsCameraBusy();
end
local function v83()
	if v25.TargetIsValid() then
		local v135 = 470 - (44 + 386);
		local v136 = v6:GetEnemiesInRange(v135);
		local v137 = 1486 - (998 + 488);
		for v138, v139 in ipairs(v136) do
			if v139:AffectingCombat() then
				v137 = v137 + 1 + 0;
			end
		end
		v137 = math.max(v137, 1 + 0);
		return v137;
	else
		return #(v6:GetEnemiesInRange(812 - (201 + 571)));
	end
end
local function v84()
	return v6:ChannelSpellID() == (392666 - (116 + 1022));
end
local function v85(v127, v128)
	return (v127:gsub("{(.-)}", v128));
end
local v86;
local function v87(v129)
	return (v129 ~= "Not Used") and ((((v129 == "with Cooldowns") or ((v129 == "small CDs") and v28.Balance_CDUSE.smallcdswithCooldowns) or (v129 == "with Cooldowns or AoE") or (v129 == "on Enemycount or Cooldowns") or (v129 == "on Boss or with Cooldowns")) and v15()) or (v129 == "always") or (((v129 == "on Boss only") or (v129 == "on Boss or on Enemycount") or (v129 == "on Boss or with Cooldowns")) and (v86 or v8:IsDummy())) or ((v129 == "with Bloodlust only") and v6:BloodlustUp()) or ((v129 == "small CDs") and Smallcds) or (((v129 == "on AOE") or (v129 == "with Cooldowns or AoE")) and (v46 >= (8 - 6))) or (((v129 == "on Enemycount or Cooldowns") or (v129 == "on Enemycount") or (v129 == "on Boss or on Enemycount")) and (v46 >= v28.Balance_CDUSE.Enemycount)));
end
local function v88(v130)
	return (v86 and v28.Balance_TTD.IgnoreWhenBoss) or v25.Buggedmobs[v8:NPCID()] or (v25.ISSolo() and v28.Balance_TTD.IgnoreWhenSolo) or (v130 == (0 + 0)) or ((v48 >= v130) and (v48 < (28391 - 20614)));
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
	if (v22.NaturesVigil:IsCastable() and v6:AffectingCombat() and (v28.Balance.Defensives.NaturesVigilCount ~= (0 - 0)) and (v28.Balance.Defensives.NaturesVigilHP ~= (859 - (814 + 45))) and v25.AoELogicWithCount(v28.Balance.Defensives.NaturesVigilHP, v28.Balance.Defensives.NaturesVigilCount, nil, v49)) then
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
	if (v22.Ironfur:IsCastable() and v6:BuffUp(v22.BearForm) and v6:BuffDown(v22.Ironfur) and (v6:Rage() >= (98 - 58)) and (v6:HealthPercentage() <= v28.Balance.Defensives.IronfurHP)) then
		if v16(v22.Ironfur) then
			return "Ironfur";
		end
	end
	if (v22.BearForm:IsCastable() and v6:AffectingCombat() and v6:BuffUp(v22.MoonkinForm) and (v6:HealthPercentage() <= v28.Balance.Defensives.BearFormHP)) then
		if v16(v22.BearForm) then
			return "BearForm";
		end
	end
	if (v22.MoonkinForm:IsCastable() and v6:BuffUp(v22.BearForm) and (v6:HealthPercentage() > v28.Balance.Defensives.MoonkinFormHP) and (v28.Balance.Defensives.MoonkinFormHP > (0 + 0))) then
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
	if (v22.Wrath:IsCastable() and not v6:IsMoving() and ((v6:IsCasting(v22.Wrath) and (v22.Wrath:Count() == (1 + 1))) or (v6:PrevGCD(886 - (261 + 624), v22.Wrath) and (v22.Wrath:Count() == (1 - 0))))) then
		if v16(v22.Wrath) then
			return "wrath precombat 4";
		end
	end
	if (v22.Starfire:IsCastable() and (not v6:IsMoving() or v6:BuffUp(v22.WarriorofEluneBuff)) and not v22.StellarFlare:IsAvailable() and (v6:HeroTreeID() == (1104 - (1020 + 60)))) then
		if v16(v22.Starfire) then
			return "starfire precombat 6";
		end
	end
	if (v22.StellarFlare:IsCastable() and not v6:IsMoving()) then
		if v16(v22.StellarFlare) then
			return "stellar_flare precombat 8";
		end
	end
end
local function v91()
	if v22.Sunfire:IsCastable() then
		if v25.CastCycle(v22.Sunfire, v45, v78, v43) then
			return "sunfire st 2";
		end
	end
	if (v22.Moonfire:IsCastable() and (not v22.ForceofNature:IsAvailable() or (v22.ForceofNature:CooldownRemains() > (1428 - (630 + 793))) or not IsForceofNature or not v22.TreantsoftheMoon:IsAvailable())) then
		if v25.CastCycle(v22.Moonfire, v45, v73, v43) then
			return "moonfire st 4";
		end
	end
	if v32 then
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
	if (v22.ForceofNature:IsCastable() and IsForceofNature and (((v41:CooldownRemains() < v6:GCD()) and (not v22.NaturesGrace:IsAvailable() or not v34 or (v35 > (19 - 13)))) or ((v35 >= (14 - 11)) and (v41:CooldownRemains() > (4 + 6 + ((51 - 36) * v17(v22.ControloftheDream:IsAvailable())))) and ((v47 > (v41:CooldownRemains() + (1752 - (760 + 987)))) or (v41:CooldownRemains() > v47))))) then
		if v16(v22.ForceofNature, true) then
			return "force_of_nature st 10";
		end
	end
	if (v22.FuryofElune:IsCastable() and IsFuryofElune and (((1918 - (1789 + 124)) + v29) < v6:AstralPowerDeficit())) then
		if v16(v22.FuryofElune, true) then
			return "fury_of_elune st 12";
		end
	end
	if (v22.Starsurge:IsReady() and UseSpender and v22.Starlord:IsAvailable() and (v6:BuffStack(v22.StarlordBuff) < (769 - (745 + 21)))) then
		if v16(v22.Starsurge) then
			return "starsurge st 14";
		end
	end
	if v22.Sunfire:IsCastable() then
		if v25.CastCycle(v22.Sunfire, v45, v79, v43) then
			return "sunfire st 16";
		end
	end
	if v22.Moonfire:IsCastable() then
		if v25.CastCycle(v22.Moonfire, v45, v74, v43) then
			return "moonfire st 18";
		end
	end
	if v22.StellarFlare:IsCastable() then
		if v25.CastCycle(v22.StellarFlare, v45, v76, v43) then
			return "stellar_flare st 20";
		end
	end
	v38 = (v47 < (2 + 3)) or ((v39 or (v41:CooldownRemains() > (110 - 70))) and ((v6:HeroTreeID() ~= (90 - 67)) or v6:BuffUp(v22.HarmonyoftheGroveBuff) or (v22.ForceofNature:CooldownRemains() > (1 + 14))));
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
	if (v22.Starsurge:IsReady() and UseSpender and (((v6:BuffRemains(v22.StarlordBuff) > (1059 - (87 + 968))) and (v37 >= (13 - 10))) or (v47 < (4 + 0)))) then
		if v16(v22.Starsurge) then
			return "starsurge st 26";
		end
	end
	if (v22.NewMoon:IsCastable() and not v6:IsMoving() and ((v6:AstralPowerDeficit() > (v29 + v71(v22.NewMoon))) or (v47 < (45 - 25)) or (v41:CooldownRemains() > (1428 - (447 + 966))))) then
		if v16(v22.NewMoon) then
			return "new_moon st 28";
		end
	end
	if (v22.HalfMoon:IsCastable() and not v6:IsMoving() and (((v6:AstralPowerDeficit() > (v29 + v71(v22.HalfMoon))) and ((v6:BuffRemains(v22.EclipseLunar) > v22.HalfMoon:ExecuteTime()) or (v6:BuffRemains(v22.EclipseSolar) > v22.HalfMoon:ExecuteTime()))) or (v47 < (54 - 34)) or (v41:CooldownRemains() > (1832 - (1703 + 114))))) then
		if v16(v22.HalfMoon) then
			return "half_moon st 30";
		end
	end
	if (v22.FullMoon:IsCastable() and not v6:IsMoving() and (((v6:AstralPowerDeficit() > (v29 + v71(v22.FullMoon))) and ((v6:BuffRemains(v22.EclipseLunar) > v22.FullMoon:ExecuteTime()) or (v6:BuffRemains(v22.EclipseSolar) > v22.FullMoon:ExecuteTime()))) or (v47 < (721 - (376 + 325))) or (v41:CooldownRemains() > (24 - 9)))) then
		if v16(v22.FullMoon) then
			return "full_moon st 32";
		end
	end
	if (v22.Starsurge:IsReady() and UseSpender and (v6:BuffUp(v22.StarweaversWeft) or v6:BuffUp(v22.TouchtheCosmosStarsurge))) then
		if v16(v22.Starsurge) then
			return "starsurge st 34";
		end
	end
	if (v22.Starfall:IsReady() and UseSpender and (v6:BuffUp(v22.StarweaversWarp) or v6:BuffUp(v22.TouchtheCosmosStarfall))) then
		if v16(v22.Starfall) then
			return "starfall st 36";
		end
	end
	if (v22.Starsurge:IsReady() and UseSpender and (v6:AstralPowerDeficit() < (v29 + v71(v22.Wrath) + ((v71(v22.Starfire) + v29) * (v17(v6:BuffRemains(v22.EclipseSolar) < (v6:GCD() * (8 - 5)))))))) then
		if v16(v22.Starsurge) then
			return "starsurge st 38";
		end
	end
	if (v22.ForceofNature:IsCastable() and IsForceofNature and (v6:HeroTreeID() ~= (7 + 16))) then
		if v16(v22.ForceofNature, true) then
			return "force_of_nature st 40";
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
		if (v22.Sunfire:IsCastable() and (v46 > (2 - 1))) then
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
	local v131 = v6:IsInDungeonArea();
	if (v22.Moonfire:IsCastable() and v131 and (not v22.ForceofNature:IsAvailable() or (v22.ForceofNature:CooldownRemains() > (19 - (9 + 5))) or not IsForceofNature or not v22.TreantsoftheMoon:IsAvailable())) then
		if v25.CastCycle(v22.Moonfire, v45, v72, v43) then
			return "moonfire aoe 2";
		end
	end
	if v22.Sunfire:IsCastable() then
		if v25.CastCycle(v22.Sunfire, v45, v77, v43) then
			return "sunfire aoe 4";
		end
	end
	if (v22.Moonfire:IsCastable() and not v131 and (not v22.ForceofNature:IsAvailable() or (v22.ForceofNature:CooldownRemains() > (381 - (85 + 291))) or not IsForceofNature or not v22.TreantsoftheMoon:IsAvailable())) then
		if v25.CastCycle(v22.Moonfire, v45, v72, v43) then
			return "moonfire aoe 6";
		end
	end
	if (v22.StellarFlare:IsCastable() and (v46 < ((((1276 - (243 + 1022)) - v22.UmbralIntensity:TalentRank()) - ((7 - 5) * v17(v22.AstralSmolder:IsAvailable()))) - v17(v22.LunarCalling:IsAvailable())))) then
		if v25.CastCycle(v22.StellarFlare, v45, v75, v43) then
			return "stellar_flare aoe 8";
		end
	end
	if (v22.ForceofNature:IsCastable() and IsForceofNature and ((v22.PoweroftheDream:IsAvailable() and v22.EarlySpring:IsAvailable() and v22.OrbitalStrike:IsAvailable()) or (v35 >= (3 + 0)))) then
		if v16(v22.ForceofNature, true) then
			return "force_of_nature aoe 10";
		end
	end
	if (v22.FuryofElune:IsCastable() and IsFuryofElune and v34) then
		if v16(v22.FuryofElune, true) then
			return "fury_of_elune aoe 12";
		end
	end
	if v32 then
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
	if (v22.WarriorofElune:IsCastable() and IsWarriorofElune and ((not v22.LunarCalling:IsAvailable() and (v6:BuffRemains(v22.EclipseSolar) < (1187 - (1123 + 57)))) or v22.LunarCalling:IsAvailable())) then
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
	if (v22.ConvoketheSpirits:IsCastable() and IsConvoketheSpirits and ((v6:BuffDown(v22.DreamstateBuff) and v6:BuffDown(v22.UmbralEmbraceBuff) and (v46 < (261 - (163 + 91)))) or (v46 == (1931 - (1869 + 61)))) and ((v47 < (2 + 3)) or ((v39 or (v41:CooldownRemains() > (140 - 100))) and ((v6:HeroTreeID() ~= (51 - 17)) or v6:BuffUp(v22.HarmonyoftheGroveBuff) or (v22.ForceofNature:CooldownRemains() > (3 + 12)))))) then
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
	if (v22.Starfire:IsCastable() and (not v6:IsMoving() or v6:BuffUp(v22.WarriorofEluneBuff)) and (v22.LunarCalling:IsAvailable() or (v6:BuffUp(v22.EclipseLunar) and (v46 > (1 - 0))))) then
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
	if v25.ShouldStopCastUpdate() then
		v13.CastMacro(6 + 0, true);
		return "Stop Cast For Silence";
	end
	InterruptToggle = v13.ToggleIconFrame:GetToggle(1475 - (1329 + 145));
	DispelToggle = v13.ToggleIconFrame:GetToggle(973 - (140 + 831));
	Smallcds = v13.ToggleIconFrame:GetToggle(1853 - (1409 + 441));
	UseSpender = v13.ToggleIconFrame:GetToggle(722 - (15 + 703));
	local v132 = not v6:AffectingCombat() or not v8:AffectingCombat() or v8:IsDummy();
	Enemies40Yard = v6:GetEnemiesInRange(19 + 21);
	EnemiesRangeOOCCount = v83() or #Enemies40Yard;
	v49 = v25.UnitsinRange(v22.Regrowth);
	v45 = v8:GetEnemiesInSplashRange(448 - (262 + 176));
	if v14() then
		v46 = (v132 and #Enemies40Yard) or EnemiesRangeOOCCount;
	else
		v46 = 1722 - (345 + 1376);
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
	if (v25.TargetIsValid() or v6:AffectingCombat()) then
		TargetinRange = v8:IsSpellInRange(v22.Wrath);
		v47 = v3.BossFightRemains();
		v86 = true;
		v48 = v47;
		if (v48 == (11799 - (198 + 490))) then
			v86 = false;
			v48 = v3.FightRemains(v45, false);
		end
		v39 = v6:BuffUp(v22.CABuff) or v6:BuffUp(v22.IncarnationBuff);
		v40 = 0 - 0;
		if v39 then
			v40 = (v22.IncarnationTalent:IsAvailable() and v6:BuffRemains(v22.IncarnationBuff)) or v6:BuffRemains(v22.CABuff);
		end
	end
	if (v22.MarkoftheWild:IsCastable() and not v6:DebuffUp(v22.Corruption) and ((v25.GroupBuffMissing(v22.MarkoftheWildBuff) and (v28.Commons.MarkoftheWild == "check whole group") and (v6:IsInRaidArea() or v6:IsInDungeonArea()) and (v6:InstanceDifficulty() ~= (491 - 286))) or (v6:BuffDown(v22.MarkoftheWildBuff, true) and ((v28.Commons.MarkoftheWild == "only check us") or (v28.Commons.MarkoftheWild == "check whole group"))))) then
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
		v19 = not v6:IsCasting(v22.Hibernate) and v25.IncorpCycle(v22.Hibernate, 1241 - (696 + 510), false, false);
		if v19 then
			return v19;
		end
	end
	if DispelToggle then
		v19 = v6:AffectingCombat() and v25.SootheCycle(v22.Soothe, 94 - 49, false, v28.Balance.TabForSoothe);
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
	v19 = v89();
	if v19 then
		return v19;
	end
	if (v25.TargetIsValid() and v6:BuffDown(v22.TravelFormBuff)) then
		if (not v28.Balance.AttackonlyinCombat or (v28.Balance.AttackonlyinCombat and v8:AffectingCombat())) then
			if not v80(v5.Target) then
				if TargetinRange then
					if not v6:AffectingCombat() then
						local v142 = v6:BuffDown(v22.BearForm) and v90();
						if v142 then
							return v142;
						end
					end
					if (InterruptToggle and not v84()) then
						v19 = v25.InterruptCycle(v22.SolarBeam, 1302 - (1091 + 171), true, nil, false);
						if v19 then
							return v19;
						end
						v19 = v25.InterruptCycle(v22.MightyBash, 2 + 6, false, nil, true);
						if v19 then
							return v19;
						end
					end
					v29 = ((18 - 12) / v6:SpellHaste()) + v17(v22.NaturesBalance:IsAvailable()) + (v17(v22.OrbitBreaker:IsAvailable()) * v17(v22.MoonfireDebuff:AuraActiveCount() > (0 - 0)) * v17(v26.OrbitBreakerStacks > ((401 - (123 + 251)) - ((9 - 7) * v17(v6:BuffUp(v22.SolsticeBuff))))) * (722 - (208 + 490)));
					v30 = v20(v41:CooldownRemains(), v22.ForceofNature:CooldownRemains());
					v31 = v47 < (v42 + v30);
					v32 = ((v47 < ((2 + 13 + ((3 + 2) * v17(v22.Incarnation:IsAvailable()))) * ((837 - (660 + 176)) + (v17(v22.GreaterAlignment:IsAvailable()) * (0.4 + 0))))) or (v6:HeroTreeID() ~= (225 - (14 + 188))) or v6:BuffUp(v22.HarmonyoftheGroveBuff) or (v22.ForceofNature:CooldownRemains() > (700 - (534 + 141)))) and v41:CooldownUp() and v8:DebuffUp(v22.SunfireDebuff) and (v8:DebuffUp(v22.MoonfireDebuff) or (v22.TreantsoftheMoon:IsAvailable() and ((v22.ForceofNature:CooldownRemains() < (2 + 1)) or v6:BuffUp(v22.HarmonyoftheGroveBuff))));
					if v28.Commons.Enabled.Trinkets then
						if (v23.AberrantSpellforge:IsEquippedAndReady() and (((v50:ID() == v23.AberrantSpellforge:ID()) and IsTrinket1) or ((v51:ID() == v23.AberrantSpellforge:ID()) and IsTrinket2))) then
							if v16(v23.AberrantSpellforge, true) then
								return "aberrant_spellforge main 2";
							end
						end
						if (v23.SpymastersWeb:IsEquippedAndReady() and (((v50:ID() == v23.SpymastersWeb:ID()) and IsTrinket1) or ((v51:ID() == v23.SpymastersWeb:ID()) and IsTrinket2)) and ((v32 and ((v6:BuffStack(v22.SpymastersReportBuff) > (26 + 3)) or (v47 < v42))) or (v47 < (20 + 0)))) then
							if v16(v23.SpymastersWeb, true) then
								return "spymasters_web main 4";
							end
						end
						if (v23.ImperfectAscendancySerum:IsEquippedAndReady() and (((v50:ID() == v23.ImperfectAscendancySerum:ID()) and IsTrinket1) or ((v51:ID() == v23.ImperfectAscendancySerum:ID()) and IsTrinket2)) and (v8:DebuffRemains(v22.SunfireDebuff) > (8 - 4)) and ((v8:DebuffRemains(v22.MoonfireDebuff) > (5 - 1)) or (v22.TreantsoftheMoon:IsAvailable() and ((v22.ForceofNature:CooldownRemains() < (8 - 5)) or v6:BuffUp(v22.HarmonyoftheGroveBuff)) and (v30 < (1 + 0))) or (v47 < (13 + 7)) or ((v47 < v30) and (v6:BuffUp(v22.HarmonyoftheGroveBuff) or v22.ConvoketheSpirits:CooldownUp()))) and (v6:BuffStack(v22.SpymastersReportBuff) <= (425 - (115 + 281)))) then
							if v16(v23.ImperfectAscendancySerum, true) then
								return "imperfect_ascendancy_serum main 6";
							end
						end
						if (v23.TreacherousTransmitter:IsEquippedAndReady() and (((v50:ID() == v23.TreacherousTransmitter:ID()) and IsTrinket1) or ((v51:ID() == v23.TreacherousTransmitter:ID()) and IsTrinket2)) and ((v30 < (6 - 3)) or (v47 < (17 + 3)) or ((v47 < v30) and (v6:BuffUp(v22.HarmonyoftheGroveBuff) or v22.ConvoketheSpirits:CooldownUp()))) and (v6:BuffStack(v22.SpymastersReportBuff) <= (69 - 40))) then
							if v16(v23.TreacherousTransmitter, true) then
								return "treacherous_transmitter main 8";
							end
						end
					end
					VarGenericTrinketCondition = v33 or ((v47 < v30) and (v6:BuffUp(v22.HarmonyoftheGroveBuff) or v22.ConvoketheSpirits:CooldownUp())) or ((((v6:BuffStack(v22.SpymastersReportBuff) + (v30 / (21 - 15))) > (896 - (550 + 317))) or (v47 < (v42 + v30))) and (v30 > (28 - 8))) or (v68 == (0 - 0));
					if v28.Commons.Enabled.Trinkets then
						if (v50:IsReady() and v8:IsInRange(v58) and IsTrinket1 and not v60 and not v66 and (((v68 ~= (2 - 1)) and (v51:CooldownRemains() > (305 - (134 + 151)))) or (((v68 == (1666 - (970 + 695))) or (v68 == (5 - 2))) and v32) or (v47 < ((2010 - (582 + 1408)) + ((69 - 49) * v17(v51:CooldownRemains() < (31 - 6))))) or VarGenericTrinketCondition)) then
							if v16(v50, true) then
								return "use_items trinket1 (" .. v50:Name() .. ") main 10";
							end
						end
						if (v51:IsReady() and v8:IsInRange(v59) and IsTrinket2 and not v61 and not v67 and (((v68 ~= (7 - 5)) and (v50:CooldownRemains() > (1844 - (1195 + 629)))) or ((v68 == (2 - 0)) and v32) or (v47 < ((261 - (187 + 54)) + ((800 - (162 + 618)) * v17(v50:CooldownRemains() < (18 + 7))))) or VarGenericTrinketCondition)) then
							if v16(v51, true) then
								return "use_items trinket2 (" .. v51:Name() .. ") main 12";
							end
						end
					end
					if (v28.Commons.Enabled.Potions and (v39 or (v47 <= (20 + 10)))) then
						local v143 = v25.PotionSelected();
						if (v143 and v143:IsReady() and IsPotions) then
							v13.CastMacro(6 - 3, nil, nil, v143);
							return "potion main 14";
						end
					end
					if v6:BuffUp(v22.BearForm) then
						if (v22.ThrashBear:IsCastable() and v8:IsInRange(8 - 3) and v8:DebuffRefreshable(v22.ThrashBearDebuff)) then
							if v16(v22.Thrashcast) then
								return "thrash bear";
							end
						end
						if (v22.Mangle:IsCastable() and v8:IsInRange(1 + 4) and (v8:DebuffUp(v22.ThrashBearDebuff) or not v22.ThrashBear:IsAvailable())) then
							if v16(v22.Mangle) then
								return "Mangle bear";
							end
						end
						if (v22.Swipe:IsCastable() and v8:IsInRange(1641 - (1373 + 263))) then
							if v16(v22.Swipecast) then
								return "Swipe bear";
							end
						end
						if (v22.ThrashBear:IsCastable() and v8:IsInRange(1005 - (451 + 549))) then
							if v16(v22.Thrashcast) then
								return "thrash bear";
							end
						end
					end
					if (v22.Berserking:IsCastable() and IsRacials and (v32 or v33 or (v47 < (5 + 10)))) then
						if v16(v22.Berserking, true) then
							return "berserking main 16";
						end
					end
					v34 = v6:BuffUp(v22.EclipseLunar) or v6:BuffUp(v22.EclipseSolar);
					v35 = v20(v6:BuffRemains(v22.EclipseLunar), v6:BuffRemains(v22.EclipseSolar));
					v36 = v22.LunarCalling:IsAvailable() or (v46 > ((2 - 0) - v17((v22.UmbralIntensity:TalentRank() + v17(v22.SouloftheForest:IsAvailable())) > (1 - 0))));
					v37 = v6:BuffStack(v22.BOATArcaneBuff) + v6:BuffStack(v22.BOATNatureBuff);
					if (v22.WarriorofElune:IsCastable() and IsWarriorofElune and (v22.LunarCalling:IsAvailable() or ((v35 >= (1391 - (746 + 638))) and (v41:CooldownRemains() > (8 + 12))))) then
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
					if (v14() and (v46 > (1 - 0)) and v22.Starfall:IsAvailable()) then
						local v144 = v92();
						if v144 then
							return v144;
						end
					end
					local v141 = v91();
					if v141 then
						return v141;
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
	local v133 = {Starlordvalue=v22.StarlordBuff:Name()};
	local v134 = "/cancelaura {Starlordvalue}";
	v13:UpdateMacro("macro1", v85(v134, v133));
	v13:UpdateMacro("macro2", "/use 16");
	v13:UpdateMacro("macro6", "/stopcasting");
	v13.ToggleIconFrame:AddButtonCustom("I", 342 - (218 + 123), "Interrupt", "interrupt");
	v13.ToggleIconFrame:AddButtonCustom("D", 1583 - (1535 + 46), "Dispel", "dispel");
	v13.ToggleIconFrame:AddButtonCustom("S", 3 + 0, "smallCDs", "smallcds");
	v13.ToggleIconFrame:AddButtonCustom("P", 1 + 3, "UseSpender", "usespender");
	v13.Print("Balance Druid rotation has been updated for patch 11.0.2. Last Update 07.10.2024");
end
v13.SetAPL(662 - (306 + 254), v93, v94);
