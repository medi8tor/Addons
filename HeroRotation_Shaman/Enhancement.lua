local v0, v1 = ...;
local v2 = HeroDBC.DBC;
local v3 = HeroLib;
local v4 = HeroCache;
local v5 = v3.Unit;
local v6 = v5.Player;
local v7 = v5.Target;
local v8 = v3.Spell;
local v9 = v3.MultiSpell;
local v10 = v3.Item;
local v11 = HeroRotation();
local v12 = v11.Cast;
local v13 = v11.AoEON;
local v14 = v11.CDsON;
local v15 = v11.Commons().Everyone.num;
local v16 = v11.Commons().Everyone.bool;
local v17 = GetSpellBonusDamage;
local v18 = GetWeaponEnchantInfo;
local v19 = math.max;
local v20 = math.min;
local v21 = string.match;
local v22 = GetTime;
local v23 = C_Timer.After;
local v24;
local v25 = v8.Shaman.Enhancement;
local v26 = v10.Shaman.Enhancement;
local v27;
local v28 = {v26.AlgetharPuzzleBox:ID(),v26.BeacontotheBeyond:ID(),v26.ElementiumPocketAnvil:ID(),v26.ManicGrieftorch:ID()};
local v29 = v11.GUISettingsGet();
local v30 = v11.Commons().Everyone;
local v31 = v11.Commons().Shaman;
local v32 = {General=v29.General,Commons=v29.APL.Shaman.Commons,Enhancement=v29.APL.Shaman.Enhancement,Enhancement_Defensives=v29.APL.Shaman.Enhancement.Defensives,Enhancement_TTD=v29.APL.Shaman.Enhancement_TTD,Enhancement_CDUSE=v29.APL.Shaman.Enhancement_CDUSE};
local v33, v34;
local v35, v36;
local v37, v38;
local v39, v40;
local v41, v42;
local v43, v44;
local v45, v46;
local v47, v48;
local v49, v50;
local v51, v52;
local v53 = 619 - (555 + 64);
local v54 = (v25.RagingMaelstrom:IsAvailable() and (941 - (857 + 74))) or (573 - (367 + 201));
local v55 = 935 - (214 + 713);
local v56 = 2 + 4;
local v57 = 1 + 1;
local v58 = 1877 - (282 + 595);
local v59, v60, v61;
local v62, v63, v64;
local v65 = (v25.LavaBurst:IsAvailable() and (1639 - (1523 + 114))) or (1 + 0);
local v66 = v25.LightningBolt;
local v67 = 15839 - 4728;
local v68 = 12176 - (68 + 997);
local v69 = v31.MoltenWeaponStacks + v31.IcyEdgeStacks + v31.CracklingSurgeStacks;
local v70 = v8(441583 - (226 + 1044));
local v71;
local v72 = 0 - 0;
local function v73()
	local v104, v105 = v6:GetTrinketData(v28);
	if ((v72 < (122 - (32 + 85))) and ((v104.ID == (0 + 0)) or (v105.ID == (0 + 0)) or ((v104.SpellID > (957 - (892 + 65))) and not v104.Usable) or ((v105.SpellID > (0 - 0)) and not v105.Usable))) then
		v72 = v72 + (1 - 0);
		v23(8 - 3, function()
			v73();
		end);
		return;
	end
	v33 = v104.Object;
	v34 = v105.Object;
	v35 = v104.Spell;
	v37 = v104.Range;
	v39 = v104.CastTime;
	v36 = v105.Spell;
	v38 = v105.Range;
	v40 = v105.CastTime;
	v41 = v104.Cooldown;
	v42 = v105.Cooldown;
	v43 = v104.Blacklisted;
	v44 = v105.Blacklisted;
	v45 = (v104.ID == v26.AlgetharPuzzleBox:ID()) or (v104.ID == v26.ManicGrieftorch:ID()) or (v104.ID == v26.ElementiumPocketAnvil:ID()) or (v104.ID == v26.BeacontotheBeyond:ID());
	v46 = (v105.ID == v26.AlgetharPuzzleBox:ID()) or (v105.ID == v26.ManicGrieftorch:ID()) or (v105.ID == v26.ElementiumPocketAnvil:ID()) or (v105.ID == v26.BeacontotheBeyond:ID());
end
v73();
v3:RegisterForEvent(function()
	v65 = (v25.LavaBurst:IsAvailable() and (352 - (87 + 263))) or (181 - (67 + 113));
end, "SPELLS_CHANGED", "LEARNED_SPELL_IN_TAB");
v3:RegisterForEvent(function()
	v72 = 0 + 0;
	v73();
end, "PLAYER_EQUIPMENT_CHANGED");
v3:RegisterForEvent(function()
	v66 = v25.LightningBolt;
	v67 = 27279 - 16168;
	v68 = 8172 + 2939;
end, "PLAYER_REGEN_ENABLED");
v3:RegisterForCombatEvent(function()
	v69 = v31.MoltenWeaponStacks + v31.IcyEdgeStacks + v31.CracklingSurgeStacks;
end, "SPELL_AURA_APPLIED");
local function v74(v119)
	local v120 = v6:GetEnemiesInRange(v119);
	local v121 = 3 - 2;
	for v135, v136 in pairs(v120) do
		if ((v136:GUID() ~= v7:GUID()) and (v136:AffectingCombat() or v136:IsDummy())) then
			v121 = v121 + (953 - (802 + 150));
		end
	end
	return v121;
end
local function v75(v122)
	for v137 = 2 - 1, 10 - 4, 1 + 0 do
		local v138, v139 = v6:GetTotemInfo(v137);
		if (v122:Name() == v139) then
			return true;
		end
	end
end
local function v76()
	if (not v25.AlphaWolf:IsAvailable() or v6:BuffDown(v25.FeralSpiritBuff)) then
		return 997 - (915 + 82);
	end
	local v123 = v20(v25.CrashLightning:TimeSinceLastCast(), v25.ChainLightning:TimeSinceLastCast());
	if ((v123 > (22 - 14)) or (v123 > v25.FeralSpirit:TimeSinceLastCast())) then
		return 0 + 0;
	end
	return (9 - 1) - v123;
end
v25.LightningBolt:RegisterDamageFormula(function()
	return v17(1191 - (1069 + 118)) * (2.311 - 1) * ((1 - 0) + (v6:MasteryPct() / (18 + 82))) * ((v25.AmplificationCore:IsAvailable() and v75(v25.SurgingTotem) and (1.03 - 0)) or (1 + 0));
end);
v25.ChainLightning:RegisterDamageFormula(function()
	local v124 = (v25.CrashingStorms:IsAvailable() and (796 - (368 + 423))) or (9 - 6);
	return v17(22 - (10 + 8)) * (0.73025 - 0) * ((443 - (416 + 26)) + (v6:MasteryPct() / (319 - 219))) * ((v25.CrashingStorms:IsAvailable() and (1.4 + 0)) or (1 - 0)) * ((v25.AmplificationCore:IsAvailable() and v75(v25.SurgingTotem) and (439.03 - (145 + 293))) or (431 - (44 + 386))) * v20(v63, v124);
end);
local function v77(v125)
	return v125:DebuffRemains(v25.LightningRodDebuff);
end
local function v78(v126)
	return v126:DebuffRemains(v25.FlameShockDebuff);
end
local function v79(v127)
	return v6:BuffDown(v25.PrimordialWaveBuff);
end
local function v80(v128)
	return v128:DebuffRemains(v25.LashingFlamesDebuff);
end
local function v81(v129)
	return v129:DebuffRefreshable(v25.FlameShockDebuff);
end
local function v82(v130)
	return v130:NPCID() == (206046 - (998 + 488));
end
local function v83(v131)
	return v131:CastSpellID() == (129875 + 278930);
end
local function v84()
	if (v29.General.AutoTab and v6:AffectingCombat()) then
		v11.TopPanelAlternative:ChangeIcon(1 + 0, 775 - (201 + 571));
		return "Auto tab to target";
	end
end
local function v85()
	return v26.ManicGrieftorch:IsEquipped() and (v26.ManicGrieftorch:CooldownUp() or (v26.ManicGrieftorch:CooldownRemains() <= v6:GCDRemains()));
end
local v86;
local function v87(v132)
	return (v86 and v32.Enhancement_TTD.IgnoreWhenBoss) or v30.Buggedmobs[v7:NPCID()] or (v30.ISSolo() and v32.Enhancement_TTD.IgnoreWhenSolo) or (v132 == (1138 - (116 + 1022))) or ((v68 >= v132) and (v68 < (32377 - 24600)));
end
local function v88(v133)
	return (v133 ~= "Not Used") and ((((v133 == "with Cooldowns") or ((v133 == "small CDs") and v32.Enhancement_CDUSE.smallcdswithCooldowns) or (v133 == "with Cooldowns or AoE") or (v133 == "on Enemycount or Cooldowns") or (v133 == "on Boss or with Cooldowns")) and v14()) or (v133 == "always") or (((v133 == "on Boss only") or (v133 == "on Boss or on Enemycount") or (v133 == "on Boss or with Cooldowns")) and (v86 or v7:IsDummy())) or ((v133 == "with Bloodlust only") and v6:BloodlustUp()) or ((v133 == "small CDs") and Smallcds) or (((v133 == "on AOE") or (v133 == "with Cooldowns or AoE")) and (v63 >= (2 + 0))) or (((v133 == "on Enemycount or Cooldowns") or (v133 == "on Enemycount") or (v133 == "on Boss or on Enemycount")) and (v63 >= v32.Enhancement_CDUSE.Enemycount)));
end
local v89 = nil;
local function v90()
	if v6:IsMoving() then
		if not v89 then
			v89 = v22();
		end
		return v22() - v89;
	else
		if v89 then
			v89 = nil;
		end
		return 0 - 0;
	end
end
local function v91()
	if (v25.AstralShift:IsCastable() and v6:AffectingCombat() and (v6:HealthPercentage() <= v32.Enhancement.Defensives.AstralShiftHP)) then
		if v12(v25.AstralShift) then
			return "AstralShift";
		end
	end
	if (v25.HealingStreamTotem:IsCastable() and v6:AffectingCombat() and (v6:HealthPercentage() <= v32.Enhancement.Defensives.HealingStreamTotemHP)) then
		if v12(v25.HealingStreamTotem) then
			return "HealingStreamTotem";
		end
	end
	if (v25.StoneBulkwarkTotem:IsCastable() and v6:AffectingCombat() and (v6:HealthPercentage() <= v32.Enhancement.Defensives.StoneBulkwarkTotemHP)) then
		if v12(v25.StoneBulkwarkTotem) then
			return "StoneBulkwarkTotem";
		end
	end
	if (v25.HealingSurge:IsReady() and (v53 >= (17 - 12)) and (v6:HealthPercentage() <= v32.Enhancement.Defensives.InstantHealingSurgeHP)) then
		if v12(v25.HealingSurge) then
			return "HealingSurge";
		end
	end
	if (v25.HealingSurge:IsReady() and not v6:IsMoving() and (v6:HealthPercentage() <= v32.Enhancement.Defensives.HealingSurgeHP)) then
		if v12(v25.HealingSurge) then
			return "HealingSurge";
		end
	end
	if (v25.AncestralGuidance:IsCastable() and v6:AffectingCombat() and (v32.Enhancement.Defensives.AncestralGuidanceCount ~= (859 - (814 + 45))) and (not v32.Enhancement.Defensives.AncestralGuidanceHP ~= (0 - 0)) and v30.AoELogicWithCount(v32.Enhancement.Defensives.AncestralGuidanceHP, v32.Enhancement.Defensives.AncestralGuidanceCount, nil, v27)) then
		if v12(v25.AncestralGuidance) then
			return "AncestralGuidance";
		end
	end
	if (v25.EarthElemental:IsCastable() and v6:AffectingCombat() and (v6:HealthPercentage() <= v32.Enhancement.Defensives.EarthElemental) and IsEarthElemental) then
		if v12(v25.EarthElemental) then
			return "EarthElemental";
		end
	end
end
local function v92()
	if (v25.PrimordialWave:IsReady() and TargetInMeleeRange and IsPrimordialWave) then
		if v12(v25.PrimordialWave) then
			return "primordial_wave precombat 4";
		end
	end
	if (v25.FeralSpirit:IsCastable() and IsFeralSpirit and TargetInMeleeRange) then
		if v12(v25.FeralSpirit, true) then
			return "feral_spirit precombat 6";
		end
	end
	if (v25.FlameShock:IsReady() and v7:IsSpellInRange(v25.FlameShock)) then
		if v12(v25.FlameShock) then
			return "flame_shock precombat 8";
		end
	end
end
local function v93()
	if (v25.FlameShock:IsReady() and v7:IsSpellInRange(v25.FlameShock) and (v7:DebuffDown(v25.FlameShockDebuff))) then
		if v12(v25.FlameShock) then
			return "flame_shock single_open 2";
		end
	end
	if (v25.VoltaicBlazeAbility:IsReady() and v7:IsSpellInRange(v25.VoltaicBlazeAbility) and (v25.FlameShockDebuff:AuraActiveCount() < (1 + 2)) and v6:BuffDown(v25.AscendanceBuff)) then
		if v12(v25.VoltaicBlazeAbility) then
			return "voltaic_blaze single_open 4";
		end
	end
	if (v25.PrimordialWave:IsReady() and TargetInMeleeRange and IsPrimordialWave and (v53 >= (2 + 2)) and v7:DebuffUp(v25.FlameShockDebuff) and (v25.FlameShockDebuff:AuraActiveCount() == v20(v63, 891 - (261 + 624)))) then
		if v12(v25.PrimordialWave) then
			return "primordial_wave single_open 6";
		end
	end
	if v6:BuffUp(v25.LegacyoftheFrostWitchBuff) then
		if (v25.FeralSpirit:IsCastable() and IsFeralSpirit and TargetInMeleeRange) then
			if v12(v25.FeralSpirit, true) then
				return "feral_spirit single_open 8";
			end
		end
		if (v25.DoomWinds:IsReady() and IsDoomWinds and v7:IsInMeleeRange(8 - 3)) then
			if v12(v25.DoomWinds, true) then
				return "doom_winds single_open 10";
			end
		end
		if (IsAscendance and TargetInMeleeRange and v25.Ascendance:IsCastable()) then
			if v12(v25.Ascendance, true) then
				return "ascendance single_open 12";
			end
		end
	end
	if (v25.PrimordialStormAbility:IsCastable() and TargetInMeleeRange and (v53 >= (1089 - (1020 + 60))) and (v6:BuffUp(v25.LegacyoftheFrostWitchBuff) or not v25.LegacyoftheFrostWitch:IsAvailable())) then
		if v12(v25.PrimordialWave) then
			return "primordial_storm single_open 14";
		end
	end
	if (v25.Windstrike:IsCastable() and v7:IsInRange(1453 - (630 + 793))) then
		if v12(v25.Windstrike) then
			return "windstrike single_open 16";
		end
	end
	if (v53 >= (16 - 11)) then
		if (v25.ElementalBlast:IsReady() and UseSpender and v7:IsSpellInRange(v25.ElementalBlast)) then
			if v12(v25.ElementalBlast) then
				return "elemental_blast single_open 18";
			end
		end
		if (v25.TempestAbility:IsReady() and UseSpender and v87(v32.Enhancement_TTD.TempestTTD) and v7:IsInRange(189 - 149)) then
			if v12(v25.TempestAbility) then
				return "tempest single_open 20";
			end
		end
		if (v25.LightningBolt:IsCastable() and UseSpender and v7:IsSpellInRange(v25.LightningBolt)) then
			if v12(v25.LightningBolt) then
				return "lightning_bolt single_open 22";
			end
		end
	end
	if (v25.Stormstrike:IsReady() and v7:IsSpellInRange(v25.Stormstrike)) then
		if v12(v25.Stormstrike) then
			return "stormstrike single_open 24";
		end
	end
	if (v25.CrashLightning:IsReady() and v7:IsInMeleeRange(4 + 4) and (v6:HasTier("TWW2", 13 - 9))) then
		if v12(v25.CrashLightning, true) then
			return "crash_lightning single_open 26";
		end
	end
	if (v25.VoltaicBlazeAbility:IsReady() and v7:IsSpellInRange(v25.VoltaicBlazeAbility)) then
		if v12(v25.VoltaicBlazeAbility) then
			return "voltaic_blaze single_open 28";
		end
	end
	if (v25.LavaLash:IsCastable() and v7:IsSpellInRange(v25.LavaLash) and v25.ElementalAssault:IsAvailable() and v25.MoltenAssault:IsAvailable() and v7:DebuffUp(v25.FlameShockDebuff)) then
		if v12(v25.LavaLash) then
			return "lava_lash single_open 30";
		end
	end
	if (v25.IceStrike:IsReady() and v7:IsSpellInRange(v25.IceStrike)) then
		if v12(v25.IceStrike) then
			return "ice_strike single_open 32";
		end
	end
end
local function v94()
	if ((v3.CombatTime() < (1762 - (760 + 987))) and v6:AffectingCombat()) then
		local v140 = v93();
		if v140 then
			return v140;
		end
		if v11.CastAnnotated(v25.Pool, false, "WAIT") then
			return "Wait for SingleOpen()";
		end
	end
	if (v25.PrimordialStormAbility:IsCastable() and TargetInMeleeRange and ((v53 >= (1923 - (1789 + 124))) or ((v6:BuffRemains(v25.PrimordialStormBuff) <= (770 - (745 + 21))) and (v53 >= (2 + 3))))) then
		if v12(v25.PrimordialWave) then
			return "primordial_storm single 2";
		end
	end
	if (v25.FlameShock:IsReady() and v7:IsSpellInRange(v25.FlameShock) and v7:DebuffDown(v25.FlameShockDebuff) and (v25.AshenCatalyst:IsAvailable() or v25.PrimordialWave:IsAvailable() or v25.LashingFlames:IsAvailable())) then
		if v12(v25.FlameShock) then
			return "flame_shock single 4";
		end
	end
	if (v25.FeralSpirit:IsCastable() and IsFeralSpirit and TargetInMeleeRange and ((v25.DoomWinds:CooldownRemains() > (82 - 52)) or (v25.DoomWinds:CooldownRemains() < (27 - 20)))) then
		if v12(v25.FeralSpirit, true) then
			return "feral_spirit single 6";
		end
	end
	if (v25.Windstrike:IsCastable() and v7:IsInRange(1 + 29) and v25.ThorimsInvocation:IsAvailable() and (v53 > (0 + 0)) and (v66 == v25.LightningBolt)) then
		if v12(v25.Windstrike) then
			return "windstrike single 8";
		end
	end
	if (v25.DoomWinds:IsReady() and IsDoomWinds and v7:IsInMeleeRange(1060 - (87 + 968)) and v6:BuffUp(v25.LegacyoftheFrostWitchBuff) and ((v25.FeralSpirit:CooldownRemains() > (132 - 102)) or (v25.FeralSpirit:CooldownRemains() < (2 + 0)))) then
		if v12(v25.DoomWinds, true) then
			return "doom_winds single 10";
		end
	end
	if (v25.PrimordialWave:IsReady() and TargetInMeleeRange and IsPrimordialWave and (v7:DebuffDown(v25.FlameShockDebuff))) then
		if v12(v25.PrimordialWave) then
			return "primordial_wave single 12";
		end
	end
	if (IsAscendance and TargetInMeleeRange and v25.Ascendance:IsCastable() and (v7:DebuffUp(v25.FlameShockDebuff) or not v25.PrimordialWave:IsAvailable() or not v25.AshenCatalyst:IsAvailable())) then
		if v12(v25.Ascendance, true) then
			return "ascendance single 14";
		end
	end
	if (v25.ElementalBlast:IsReady() and UseSpender and v7:IsSpellInRange(v25.ElementalBlast) and ((not v25.OverflowingMaelstrom:IsAvailable() and (v53 >= (11 - 6))) or (v53 >= (1422 - (447 + 966)))) and (v25.ElementalBlast:ChargesFractional() >= (2.8 - 1))) then
		if v12(v25.ElementalBlast) then
			return "elemental_blast single 16";
		end
	end
	if (v25.TempestAbility:IsReady() and UseSpender and v87(v32.Enhancement_TTD.TempestTTD) and v7:IsInRange(1857 - (1703 + 114)) and (v6:BuffStack(v25.TempestBuff) == v57) and ((v31.TempestMaelstrom > (731 - (376 + 325))) or (v6:BuffStack(v25.AwakeningStormsBuff) == (4 - 1))) and (v53 >= (27 - 18))) then
		if v12(v25.TempestAbility) then
			return "tempest single 18";
		end
	end
	if (v25.LightningBolt:IsCastable() and UseSpender and v7:IsSpellInRange(v25.LightningBolt) and (v53 >= (3 + 6)) and v6:BuffDown(v25.PrimordialStormBuff) and (v6:BuffStack(v25.ArcDischargeBuff) > (2 - 1))) then
		if v12(v25.LightningBolt) then
			return "lightning_bolt single 20";
		end
	end
	if (v25.ElementalBlast:IsReady() and UseSpender and v7:IsSpellInRange(v25.ElementalBlast) and ((not v25.OverflowingMaelstrom:IsAvailable() and (v53 >= (19 - (9 + 5)))) or (v53 >= (385 - (85 + 291))))) then
		if v12(v25.ElementalBlast) then
			return "elemental_blast single 22";
		end
	end
	if (v25.TempestAbility:IsReady() and UseSpender and v87(v32.Enhancement_TTD.TempestTTD) and v7:IsInRange(1305 - (243 + 1022)) and (v53 >= (33 - 24))) then
		if v12(v25.TempestAbility) then
			return "tempest single 24";
		end
	end
	if (v25.LightningBolt:IsCastable() and UseSpender and v7:IsSpellInRange(v25.LightningBolt) and (v53 >= (8 + 1))) then
		if v12(v25.LightningBolt) then
			return "lightning_bolt single 26";
		end
	end
	if (v25.LavaLash:IsCastable() and v7:IsSpellInRange(v25.LavaLash) and ((v6:BuffUp(v25.HotHandBuff) and (v6:BuffStack(v25.AshenCatalystBuff) == v55)) or ((v7:DebuffRemains(v25.FlameShockDebuff) <= (1182 - (1123 + 57))) and not v25.VoltaicBlaze:IsAvailable()) or (v25.LashingFlames:IsAvailable() and (v7:DebuffDown(v25.LashingFlamesDebuff))))) then
		if v12(v25.LavaLash) then
			return "lava_lash single 28";
		end
	end
	if (v25.CrashLightning:IsReady() and v7:IsInMeleeRange(7 + 1) and ((v6:BuffUp(v25.DoomWindsBuff) and (v6:BuffStack(v25.ElectrostaticWagerBuff) > (255 - (163 + 91)))) or (v6:BuffStack(v25.ElectrostaticWagerBuff) > (1938 - (1869 + 61))))) then
		if v12(v25.CrashLightning, true) then
			return "crash_lightning single 30";
		end
	end
	if (v25.Stormstrike:IsReady() and v7:IsSpellInRange(v25.Stormstrike) and (v6:BuffUp(v25.DoomWindsBuff) or v6:BuffUp(v25.StormblastBuff))) then
		if v12(v25.Stormstrike) then
			return "stormstrike single 32";
		end
	end
	if (v25.CrashLightning:IsReady() and v7:IsInMeleeRange(3 + 5) and v25.UnrelentingStorms:IsAvailable() and v25.AlphaWolf:IsAvailable() and (v76() == (0 - 0))) then
		if v12(v25.CrashLightning, true) then
			return "crash_lightning single 34";
		end
	end
	if (v25.LavaLash:IsCastable() and v7:IsSpellInRange(v25.LavaLash) and (v6:BuffUp(v25.HotHandBuff))) then
		if v12(v25.LavaLash) then
			return "lava_lash single 36";
		end
	end
	if (v25.CrashLightning:IsReady() and v7:IsInMeleeRange(12 - 4) and (v6:HasTier("TWW2", 1 + 3))) then
		if v12(v25.CrashLightning, true) then
			return "crash_lightning single 38";
		end
	end
	if (v25.VoltaicBlazeAbility:IsReady() and v7:IsSpellInRange(v25.VoltaicBlazeAbility)) then
		if v12(v25.VoltaicBlazeAbility) then
			return "voltaic_blaze single 40";
		end
	end
	if (v25.Stormstrike:IsReady() and v7:IsSpellInRange(v25.Stormstrike)) then
		if v12(v25.Stormstrike) then
			return "stormstrike single 42";
		end
	end
	if (v25.LavaLash:IsCastable() and v7:IsSpellInRange(v25.LavaLash) and v25.ElementalAssault:IsAvailable() and v25.MoltenAssault:IsAvailable() and v7:DebuffUp(v25.FlameShockDebuff)) then
		if v12(v25.LavaLash) then
			return "lava_lash single 44";
		end
	end
	if (v25.IceStrike:IsReady() and v7:IsSpellInRange(v25.IceStrike)) then
		if v12(v25.IceStrike) then
			return "ice_strike single 46";
		end
	end
	if (v25.LightningBolt:IsCastable() and UseSpender and v7:IsSpellInRange(v25.LightningBolt) and (v53 >= (6 - 1)) and v6:BuffDown(v25.PrimordialStormBuff)) then
		if v12(v25.LightningBolt) then
			return "lightning_bolt single 48";
		end
	end
	if (v25.FrostShock:IsReady() and v7:IsSpellInRange(v25.FrostShock) and (v6:BuffUp(v25.HailstormBuff))) then
		if v12(v25.FrostShock) then
			return "frost_shock single 50";
		end
	end
	if (v25.FlameShock:IsReady() and v7:IsSpellInRange(v25.FlameShock) and (v7:DebuffDown(v25.FlameShockDebuff))) then
		if v12(v25.FlameShock) then
			return "flame_shock single 52";
		end
	end
	if (v25.Sundering:IsReady() and v7:IsInMeleeRange(11 + 0) and IsSundering) then
		if v12(v25.Sundering, true) then
			return "sundering single 54";
		end
	end
	if (v25.CrashLightning:IsReady() and v7:IsInMeleeRange(1482 - (1329 + 145))) then
		if v12(v25.CrashLightning, true) then
			return "crash_lightning single 56";
		end
	end
	if (v25.FrostShock:IsReady() and v7:IsSpellInRange(v25.FrostShock)) then
		if v12(v25.FrostShock) then
			return "frost_shock single 58";
		end
	end
	if (v25.FireNova:IsReady() and IsFireNova and (v7:DebuffUp(v25.FlameShockDebuff))) then
		if v12(v25.FireNova) then
			return "fire_nova single 60";
		end
	end
	if (v25.EarthElemental:IsCastable() and TargetInMeleeRange and IsEarthElemental) then
		if v12(v25.EarthElemental, true) then
			return "earth_elemental single 62";
		end
	end
	if (v25.FlameShock:IsReady() and v7:IsSpellInRange(v25.FlameShock)) then
		if v12(v25.FlameShock) then
			return "flame_shock single 64";
		end
	end
end
local function v95()
	if (v25.FlameShock:IsReady() and v7:IsSpellInRange(v25.FlameShock) and (v7:DebuffDown(v25.FlameShockDebuff))) then
		if v12(v25.FlameShock) then
			return "flame_shock single_totemic_open 2";
		end
	end
	if (v25.LavaLash:IsCastable() and v7:IsSpellInRange(v25.LavaLash) and not v75(v25.SurgingTotem) and v25.LashingFlames:IsAvailable() and v7:DebuffDown(v25.LashingFlamesDebuff)) then
		if v12(v25.LavaLash) then
			return "lava_lash single_totemic_open 4";
		end
	end
	if (v25.SurgingTotem:IsReady() and IsSurgingTotem and TargetInMeleeRange) then
		if v11.CastTarget(v25.SurgingTotem, v11.TName().PLAYER) then
			return "surging_totem single_totemic 6";
		end
	end
	if (v25.PrimordialWave:IsReady() and TargetInMeleeRange and IsPrimordialWave) then
		if v12(v25.PrimordialWave) then
			return "primordial_wave single_totemic_open 8";
		end
	end
	if v6:BuffUp(v25.LegacyoftheFrostWitchBuff) then
		if (v25.FeralSpirit:IsCastable() and IsFeralSpirit and TargetInMeleeRange) then
			if v12(v25.FeralSpirit, true) then
				return "feral_spirit single_totemic_open 10";
			end
		end
		if (v25.DoomWinds:IsReady() and IsDoomWinds and v7:IsInMeleeRange(976 - (140 + 831))) then
			if v12(v25.DoomWinds, true) then
				return "doom_winds single_totemic_open 12";
			end
		end
		if (v25.PrimordialStormAbility:IsCastable() and TargetInMeleeRange and (v53 >= (1860 - (1409 + 441)))) then
			if v12(v25.PrimordialWave) then
				return "primordial_storm single_totemic_open 14";
			end
		end
	end
	if (v25.LavaLash:IsCastable() and v7:IsSpellInRange(v25.LavaLash) and (v6:BuffUp(v25.HotHandBuff))) then
		if v12(v25.LavaLash) then
			return "lava_lash single_totemic_open 16";
		end
	end
	if v6:BuffUp(v25.LegacyoftheFrostWitchBuff) then
		if (v25.Stormstrike:IsReady() and v7:IsSpellInRange(v25.Stormstrike) and (v6:BuffUp(v25.DoomWindsBuff))) then
			if v12(v25.Stormstrike) then
				return "stormstrike single_totemic_open 18";
			end
		end
		if (v25.Sundering:IsReady() and v7:IsInMeleeRange(729 - (15 + 703)) and IsSundering) then
			if v12(v25.Sundering, true) then
				return "sundering single_totemic_open 20";
			end
		end
	end
	if (v53 == (5 + 5)) then
		if (v25.ElementalBlast:IsReady() and UseSpender and v7:IsSpellInRange(v25.ElementalBlast)) then
			if v12(v25.ElementalBlast) then
				return "elemental_blast single_totemic_open 22";
			end
		end
		if (v25.LightningBolt:IsCastable() and UseSpender and v7:IsSpellInRange(v25.LightningBolt)) then
			if v12(v25.LightningBolt) then
				return "lightning_bolt single_totemic_open 24";
			end
		end
	end
	if (v25.Stormstrike:IsReady() and v7:IsSpellInRange(v25.Stormstrike)) then
		if v12(v25.Stormstrike) then
			return "stormstrike single_totemic_open 26";
		end
	end
	if (v25.LavaLash:IsCastable() and v7:IsSpellInRange(v25.LavaLash)) then
		if v12(v25.LavaLash) then
			return "lava_lash single_totemic_open 28";
		end
	end
end
local function v96()
	if ((v3.CombatTime() < (458 - (262 + 176))) and v6:AffectingCombat()) then
		local v141 = v95();
		if v141 then
			return v141;
		end
		if v11.CastAnnotated(v25.Pool, false, "WAIT") then
			return "Wait for SingleTotemicOpen()";
		end
	end
	if (v25.SurgingTotem:IsReady() and IsSurgingTotem and TargetInMeleeRange) then
		if v11.CastTarget(v25.SurgingTotem, v11.TName().PLAYER) then
			return "surging_totem single_totemic 2";
		end
	end
	if (IsAscendance and TargetInMeleeRange and v25.Ascendance:IsCastable() and (v66 == v25.LightningBolt) and (v75(v25.SurgingTotem, true) > (1725 - (345 + 1376))) and ((v6:BuffStack(v25.TotemicReboundBuff) >= (691 - (198 + 490))) or (v53 > (0 - 0)))) then
		if v12(v25.Ascendance, true) then
			return "ascendance single_totemic 4";
		end
	end
	if (v25.FlameShock:IsReady() and v7:IsSpellInRange(v25.FlameShock) and v7:DebuffDown(v25.FlameShockDebuff) and (v25.AshenCatalyst:IsAvailable() or v25.PrimordialWave:IsAvailable())) then
		if v12(v25.FlameShock) then
			return "flame_shock single_totemic 6";
		end
	end
	if (v25.LavaLash:IsCastable() and v7:IsSpellInRange(v25.LavaLash) and (v6:BuffUp(v25.HotHandBuff))) then
		if v12(v25.LavaLash) then
			return "lava_lash single_totemic 8";
		end
	end
	if (v25.FeralSpirit:IsCastable() and IsFeralSpirit and TargetInMeleeRange and ((v25.DoomWinds:CooldownRemains() > (54 - 31)) or (v25.DoomWinds:CooldownRemains() < (1213 - (696 + 510)))) and ((v25.PrimordialWave:CooldownRemains() < (41 - 21)) or v6:BuffUp(v25.PrimordialStormBuff) or not v25.PrimordialStorm:IsAvailable())) then
		if v12(v25.FeralSpirit, true) then
			return "feral_spirit single_totemic 10";
		end
	end
	if (v25.PrimordialWave:IsReady() and TargetInMeleeRange and IsPrimordialWave and (v7:DebuffUp(v25.FlameShockDebuff))) then
		if v12(v25.PrimordialWave) then
			return "primordial_wave single_totemic 12";
		end
	end
	if (v25.DoomWinds:IsReady() and IsDoomWinds and v7:IsInMeleeRange(1267 - (1091 + 171)) and (v6:BuffUp(v25.LegacyoftheFrostWitchBuff))) then
		if v12(v25.DoomWinds, true) then
			return "doom_winds single_totemic 14";
		end
	end
	if (v25.PrimordialStormAbility:IsCastable() and TargetInMeleeRange and (v53 >= (2 + 8)) and (v6:BuffUp(v25.LegacyoftheFrostWitchBuff) or not v25.LegacyoftheFrostWitch:IsAvailable()) and ((v25.DoomWinds:CooldownRemains() >= (47 - 32)) or v6:BuffUp(v25.DoomWindsBuff))) then
		if v12(v25.PrimordialWave) then
			return "primordial_storm single_totemic 16";
		end
	end
	if (v25.Sundering:IsReady() and v7:IsInMeleeRange(36 - 25) and IsSundering and v6:BuffUp(v25.AscendanceBuff) and v75(v25.SurgingTotem) and v25.Earthsurge:IsAvailable() and v6:BuffUp(v25.LegacyoftheFrostWitchBuff) and (v6:BuffStack(v25.TotemicReboundBuff) >= (379 - (123 + 251))) and (v6:BuffStack(v25.EarthenWeaponBuff) >= (9 - 7))) then
		if v12(v25.Sundering, true) then
			return "sundering single_totemic 18";
		end
	end
	if (v25.Windstrike:IsCastable() and v7:IsInRange(728 - (208 + 490)) and v25.ThorimsInvocation:IsAvailable() and (v53 > (0 + 0)) and (v66 == v25.LightningBolt)) then
		if v12(v25.Windstrike) then
			return "windstrike single_totemic 20";
		end
	end
	if (v25.Sundering:IsReady() and v7:IsInMeleeRange(5 + 6) and IsSundering and v6:BuffUp(v25.LegacyoftheFrostWitchBuff) and (((v25.Ascendance:CooldownRemains() >= (846 - (660 + 176))) and v25.Ascendance:IsAvailable()) or not v25.Ascendance:IsAvailable()) and v75(v25.SurgingTotem) and (v6:BuffStack(v25.TotemicReboundBuff) >= (1 + 2)) and v6:BuffDown(v25.AscendanceBuff)) then
		if v12(v25.Sundering, true) then
			return "sundering single_totemic 22";
		end
	end
	if (v25.CrashLightning:IsReady() and v7:IsInMeleeRange(210 - (14 + 188)) and v25.UnrelentingStorms:IsAvailable() and v25.AlphaWolf:IsAvailable() and (v76() == (675 - (534 + 141)))) then
		if v12(v25.CrashLightning, true) then
			return "crash_lightning single_totemic 24";
		end
	end
	if (v25.LavaBurst:IsReady() and v7:IsSpellInRange(v25.LavaBurst) and not v25.ThorimsInvocation:IsAvailable() and (v53 >= (5 + 5)) and v6:BuffDown(v25.WhirlingAirBuff)) then
		if v12(v25.LavaBurst) then
			return "lava_burst single_totemic 28";
		end
	end
	if (v25.ElementalBlast:IsReady() and UseSpender and v7:IsSpellInRange(v25.ElementalBlast) and (v53 >= (9 + 1)) and (v6:BuffDown(v25.PrimordialStormBuff) or (v6:BuffRemains(v25.PrimordialStormBuff) > (4 + 0)))) then
		if v12(v25.ElementalBlast) then
			return "elemental_blast single_totemic 30";
		end
	end
	if (v25.Stormstrike:IsReady() and v7:IsSpellInRange(v25.Stormstrike) and v6:BuffUp(v25.DoomWindsBuff) and v6:BuffUp(v25.LegacyoftheFrostWitchBuff)) then
		if v12(v25.Stormstrike) then
			return "stormstrike single_totemic 32";
		end
	end
	if (v25.LightningBolt:IsCastable() and UseSpender and v7:IsSpellInRange(v25.LightningBolt) and (v53 >= (21 - 11)) and (v6:BuffDown(v25.PrimordialStormBuff) or (v6:BuffRemains(v25.PrimordialStormBuff) > (5 - 1)))) then
		if v12(v25.LightningBolt) then
			return "lightning_bolt single_totemic 34";
		end
	end
	if (v25.CrashLightning:IsReady() and v7:IsInMeleeRange(22 - 14) and (v6:BuffStack(v25.ElectrostaticWagerBuff) > (3 + 1))) then
		if v12(v25.CrashLightning, true) then
			return "crash_lightning single_totemic 36";
		end
	end
	if (v25.Stormstrike:IsReady() and v7:IsSpellInRange(v25.Stormstrike) and (v6:BuffUp(v25.DoomWindsBuff) or (v6:BuffStack(v25.StormblastBuff) > (1 + 0)))) then
		if v12(v25.Stormstrike) then
			return "stormstrike single_totemic 38";
		end
	end
	if (v25.LavaLash:IsReady() and v7:IsSpellInRange(v25.LavaLash) and (v6:BuffUp(v25.WhirlingFireBuff) or (v6:BuffStack(v25.AshenCatalystBuff) >= (404 - (115 + 281))))) then
		if v12(v25.LavaLash) then
			return "lava_lash single_totemic 40";
		end
	end
	if (v25.Windstrike:IsCastable() and v7:IsInRange(69 - 39)) then
		if v12(v25.Windstrike) then
			return "windstrike single_totemic 42";
		end
	end
	if (v25.Stormstrike:IsReady() and v7:IsSpellInRange(v25.Stormstrike)) then
		if v12(v25.Stormstrike) then
			return "stormstrike single_totemic 44";
		end
	end
	if (v25.LavaLash:IsReady() and v7:IsSpellInRange(v25.LavaLash) and (v25.MoltenAssault:IsAvailable())) then
		if v12(v25.LavaLash) then
			return "lava_lash single_totemic 46";
		end
	end
	if (v25.CrashLightning:IsReady() and v7:IsInMeleeRange(7 + 1) and (v6:HasTier("TWW2", 9 - 5))) then
		if v12(v25.CrashLightning, true) then
			return "crash_lightning single_totemic 48";
		end
	end
	if (v25.VoltaicBlazeAbility:IsReady() and v7:IsSpellInRange(v25.VoltaicBlazeAbility)) then
		if v12(v25.VoltaicBlazeAbility) then
			return "voltaic_blaze single_totemic 50";
		end
	end
	if (v25.CrashLightning:IsReady() and v7:IsInMeleeRange(29 - 21) and (v25.UnrelentingStorms:IsAvailable())) then
		if v12(v25.CrashLightning, true) then
			return "crash_lightning single_totemic 52";
		end
	end
	if (v25.IceStrike:IsReady() and v7:IsSpellInRange(v25.IceStrike) and (v6:BuffDown(v25.IceStrikeBuff))) then
		if v12(v25.IceStrike) then
			return "ice_strike single_totemic 54";
		end
	end
	if (v25.CrashLightning:IsReady() and v7:IsInMeleeRange(875 - (550 + 317))) then
		if v12(v25.CrashLightning, true) then
			return "crash_lightning single_totemic 56";
		end
	end
	if (v25.FrostShock:IsReady() and v7:IsSpellInRange(v25.FrostShock)) then
		if v12(v25.FrostShock) then
			return "frost_shock single_totemic 58";
		end
	end
	if (v25.FireNova:IsReady() and IsFireNova and (v7:DebuffUp(v25.FlameShockDebuff))) then
		if v12(v25.FireNova) then
			return "fire_nova single_totemic 60";
		end
	end
	if (v25.EarthElemental:IsCastable() and TargetInMeleeRange and IsEarthElemental) then
		if v12(v25.EarthElemental, true) then
			return "earth_elemental single_totemic 62";
		end
	end
	if (v25.FlameShock:IsReady() and v7:IsSpellInRange(v25.FlameShock) and not v25.VoltaicBlaze:IsAvailable()) then
		if v12(v25.FlameShock) then
			return "flame_shock single_totemic 64";
		end
	end
end
local function v97()
	if (v25.FlameShock:IsReady() and v7:IsSpellInRange(v25.FlameShock) and (v7:DebuffDown(v25.FlameShockDebuff))) then
		if v12(v25.FlameShock) then
			return "flame_shock aoe_open 2";
		end
	end
	if (v25.CrashLightning:IsReady() and v7:IsInMeleeRange(11 - 3) and (((v6:BuffStack(v25.ElectrostaticWagerBuff) > (11 - 2)) and v6:BuffUp(v25.DoomWindsBuff)) or v6:BuffDown(v25.CrashLightningBuff))) then
		if v12(v25.CrashLightning, true) then
			return "crash_lightning aoe_open 4";
		end
	end
	if (v25.VoltaicBlazeAbility:IsReady() and v7:IsSpellInRange(v25.VoltaicBlazeAbility) and (v25.FlameShockDebuff:AuraActiveCount() < (8 - 5))) then
		if v12(v25.VoltaicBlazeAbility) then
			return "voltaic_blaze aoe_open 6";
		end
	end
	if (v25.LavaLash:IsReady() and v7:IsSpellInRange(v25.LavaLash) and v25.MoltenAssault:IsAvailable() and (v25.PrimordialWave:IsAvailable() or v25.FireNova:IsAvailable()) and (v25.FlameShockDebuff:AuraActiveCount() > (285 - (134 + 151))) and (v25.FlameShockDebuff:AuraActiveCount() < v63) and (v25.FlameShockDebuff:AuraActiveCount() < (1668 - (970 + 695)))) then
		if v12(v25.LavaLash) then
			return "lava_lash aoe_open 8";
		end
	end
	if (v25.PrimordialWave:IsReady() and TargetInMeleeRange and IsPrimordialWave and (v53 >= (7 - 3)) and v7:DebuffUp(v25.FlameShockDebuff) and (v25.FlameShockDebuff:AuraActiveCount() == v20(v63, 1996 - (582 + 1408)))) then
		if v12(v25.PrimordialWave) then
			return "primordial_wave aoe_open 10";
		end
	end
	if (v53 >= (30 - 21)) then
		if (v25.FeralSpirit:IsCastable() and IsFeralSpirit and TargetInMeleeRange) then
			if v12(v25.FeralSpirit, true) then
				return "feral_spirit aoe_open 12";
			end
		end
		if (v25.DoomWinds:IsCastable() and IsDoomWinds and v7:IsInMeleeRange(6 - 1)) then
			if v12(v25.DoomWinds, true) then
				return "doom_winds aoe_open 14";
			end
		end
	end
	if (IsAscendance and TargetInMeleeRange and v25.Ascendance:IsCastable() and ((v25.FlameShockDebuff:AuraActiveCount() > (0 - 0)) or not v25.MoltenAssault:IsAvailable()) and (v66 == v25.ChainLightning) and (v6:BuffUp(v25.LegacyoftheFrostWitchBuff) or not v25.LegacyoftheFrostWitch:IsAvailable()) and v6:BuffDown(v25.DoomWindsBuff)) then
		if v12(v25.Ascendance, true) then
			return "ascendance aoe_open 16";
		end
	end
	if (v25.PrimordialStormAbility:IsCastable() and TargetInMeleeRange and (v53 >= (1833 - (1195 + 629))) and (v6:BuffUp(v25.LegacyoftheFrostWitchBuff) or not v25.LegacyoftheFrostWitch:IsAvailable())) then
		if v12(v25.PrimordialWave) then
			return "primordial_storm aoe_open 18";
		end
	end
	if (v25.TempestAbility:IsReady() and UseSpender and v87(v32.Enhancement_TTD.TempestTTD) and v7:IsInRange(52 - 12) and (v53 >= (250 - (187 + 54))) and v6:BuffDown(v25.ArcDischargeBuff)) then
		if v12(v25.TempestAbility) then
			return "tempest aoe_open 20 (forced MT)";
		end
	end
	if (v25.CrashLightning:IsReady() and v7:IsInMeleeRange(788 - (162 + 618)) and (v6:BuffStack(v25.ElectrostaticWagerBuff) > (3 + 1))) then
		if v12(v25.CrashLightning, true) then
			return "crash_lightning aoe_open 22";
		end
	end
	if (v25.Windstrike:IsCastable() and v7:IsInRange(20 + 10) and v25.ThorimsInvocation:IsAvailable() and (v66 == v25.ChainLightning)) then
		if v12(v25.Windstrike) then
			return "windstrike aoe_open 24";
		end
	end
	if (v25.ChainLightning:IsReady() and UseSpender and v7:IsSpellInRange(v25.ChainLightning) and (v6:BuffDown(v25.PrimordialStormBuff) or not v25.LegacyoftheFrostWitch:IsAvailable()) and (((v53 >= (10 - 5)) and v6:BuffUp(v25.DoomWindsBuff)) or (v53 >= (14 - 5)))) then
		if v12(v25.ChainLightning) then
			return "chain_lightning aoe_open 26";
		end
	end
	if (v25.Stormstrike:IsReady() and v7:IsSpellInRange(v25.Stormstrike) and (v6:BuffStack(v25.ConvergingStormsBuff) == (1 + 5)) and (v6:BuffStack(v25.StormblastBuff) > (1637 - (1373 + 263)))) then
		if v12(v25.Stormstrike) then
			return "stormstrike aoe_open 28";
		end
	end
	if (v25.CrashLightning:IsReady() and v7:IsInMeleeRange(1008 - (451 + 549))) then
		if v12(v25.CrashLightning, true) then
			return "crash_lightning aoe_open 30";
		end
	end
	if (v25.VoltaicBlazeAbility:IsReady() and v7:IsSpellInRange(v25.VoltaicBlazeAbility)) then
		if v12(v25.VoltaicBlazeAbility) then
			return "voltaic_blaze aoe_open 32";
		end
	end
	if (v25.Stormstrike:IsReady() and v7:IsSpellInRange(v25.Stormstrike)) then
		if v12(v25.Stormstrike) then
			return "stormstrike aoe_open 34";
		end
	end
end
local function v98()
	if (v25.FeralSpirit:IsCastable() and IsFeralSpirit and TargetInMeleeRange and (v25.ElementalSpirits:IsAvailable() or v25.AlphaWolf:IsAvailable())) then
		if v12(v25.FeralSpirit, true) then
			return "feral_spirit aoe 2";
		end
	end
	if ((v3.CombatTime() < (5 + 10)) and v6:AffectingCombat()) then
		local v142 = v97();
		if v142 then
			return v142;
		end
		if v11.CastAnnotated(v25.Pool, false, "WAIT") then
			return "Wait for AoeOpen()";
		end
	end
	if (v25.FlameShock:IsReady() and v7:IsSpellInRange(v25.FlameShock) and v25.MoltenAssault:IsAvailable() and v7:DebuffDown(v25.FlameShockDebuff)) then
		if v12(v25.FlameShock) then
			return "flame_shock aoe 4";
		end
	end
	if (IsAscendance and TargetInMeleeRange and v25.Ascendance:IsCastable() and ((v25.FlameShockDebuff:AuraActiveCount() > (0 - 0)) or not v25.MoltenAssault:IsAvailable()) and (v66 == v25.ChainLightning)) then
		if v12(v25.Ascendance, true) then
			return "ascendance aoe 6";
		end
	end
	if (v25.TempestAbility:IsReady() and UseSpender and v87(v32.Enhancement_TTD.TempestTTD) and v7:IsInRange(67 - 27) and ((v6:BuffDown(v25.ArcDischargeBuff) and (((v53 == v54) and not v25.RagingMaelstrom:IsAvailable()) or (v53 >= (1393 - (746 + 638))))) or ((v53 >= (2 + 3)) and (v31.TempestMaelstrom > (45 - 15))))) then
		if v12(v25.TempestAbility) then
			return "tempest aoe 8 (forced MT)";
		end
	end
	if (v25.FeralSpirit:IsCastable() and IsFeralSpirit and TargetInMeleeRange and ((v25.DoomWinds:CooldownRemains() > (371 - (218 + 123))) or (v25.DoomWinds:CooldownRemains() < (1588 - (1535 + 46))))) then
		if v12(v25.FeralSpirit, true) then
			return "feral_spirit aoe 10";
		end
	end
	if (v25.DoomWinds:IsCastable() and IsDoomWinds and v7:IsInMeleeRange(5 + 0)) then
		if v12(v25.DoomWinds, true) then
			return "doom_winds aoe 12";
		end
	end
	if (v25.PrimordialWave:IsReady() and TargetInMeleeRange and IsPrimordialWave and (v25.FlameShockDebuff:AuraActiveCount() == v20(v63, 1 + 5))) then
		if v12(v25.PrimordialWave) then
			return "primordial_wave aoe 14";
		end
	end
	if (v25.PrimordialStormAbility:IsCastable() and TargetInMeleeRange and (v53 >= (570 - (306 + 254))) and (v6:BuffUp(v25.DoomWindsBuff) or (v25.DoomWinds:CooldownRemains() > (1 + 14)) or (v6:BuffRemains(v25.PrimordialStormBuff) < (5 - 2)))) then
		if v12(v25.PrimordialWave) then
			return "primordial_storm aoe 16";
		end
	end
	if (v25.CrashLightning:IsReady() and v7:IsInMeleeRange(1475 - (899 + 568)) and ((v25.ConvergingStorms:IsAvailable() and (v6:BuffStack(v25.ElectrostaticWagerBuff) > (4 + 2))) or v6:BuffDown(v25.CrashLightningBuff))) then
		if v12(v25.CrashLightning, true) then
			return "crash_lightning aoe 18";
		end
	end
	if (v25.Windstrike:IsCastable() and v7:IsInRange(72 - 42) and v25.ThorimsInvocation:IsAvailable() and (v53 > (603 - (268 + 335))) and (v66 == v25.ChainLightning)) then
		if v12(v25.Windstrike) then
			return "windstrike aoe 20";
		end
	end
	if (v25.CrashLightning:IsReady() and v7:IsInMeleeRange(298 - (60 + 230)) and v25.ConvergingStorms:IsAvailable() and v25.AlphaWolf:IsAvailable()) then
		if v12(v25.CrashLightning, true) then
			return "crash_lightning aoe 22";
		end
	end
	if (v25.Stormstrike:IsReady() and v7:IsSpellInRange(v25.Stormstrike) and (v6:BuffStack(v25.ConvergingStormsBuff) == (578 - (426 + 146))) and v6:BuffUp(v25.StormblastBuff) and v6:BuffUp(v25.LegacyoftheFrostWitchBuff) and (v53 <= (1 + 7))) then
		if v12(v25.Stormstrike) then
			return "stormstrike aoe 24";
		end
	end
	if (v25.CrashLightning:IsReady() and v7:IsInMeleeRange(1464 - (282 + 1174)) and (v53 <= (819 - (569 + 242)))) then
		if v12(v25.CrashLightning, true) then
			return "crash_lightning aoe 26";
		end
	end
	if (v25.VoltaicBlazeAbility:IsReady() and v7:IsSpellInRange(v25.VoltaicBlazeAbility) and (v53 <= (22 - 14))) then
		if v12(v25.VoltaicBlazeAbility) then
			return "voltaic_blaze aoe 28";
		end
	end
	if (v25.ChainLightning:IsReady() and UseSpender and v7:IsSpellInRange(v25.ChainLightning) and (v53 >= (1 + 4)) and v6:BuffDown(v25.PrimordialStormBuff) and ((v25.CrashLightning:CooldownRemains() >= (1025 - (706 + 318))) or not v25.AlphaWolf:IsAvailable())) then
		if v12(v25.ChainLightning) then
			return "chain_lightning aoe 30";
		end
	end
	if (v25.FireNova:IsReady() and IsFireNova and ((v25.FlameShockDebuff:AuraActiveCount() == (1257 - (721 + 530))) or ((v25.FlameShockDebuff:AuraActiveCount() >= (1275 - (945 + 326))) and (v25.FlameShockDebuff:AuraActiveCount() >= v63)))) then
		if v12(v25.FireNova) then
			return "fire_nova aoe 32";
		end
	end
	if (v25.Stormstrike:IsReady() and v7:IsSpellInRange(v25.Stormstrike) and v25.Stormblast:IsAvailable() and v25.Stormflurry:IsAvailable()) then
		if v12(v25.Stormstrike) then
			return "stormstrike aoe 34";
		end
	end
	if (v25.VoltaicBlazeAbility:IsReady() and v7:IsSpellInRange(v25.VoltaicBlazeAbility)) then
		if v12(v25.VoltaicBlazeAbility) then
			return "voltaic_blaze aoe 36";
		end
	end
	if (v25.LavaLash:IsReady() and v7:IsSpellInRange(v25.LavaLash) and (v25.LashingFlames:IsAvailable() or (v25.MoltenAssault:IsAvailable() and (v25.FlameShockDebuff:AuraActiveCount() > (0 - 0))))) then
		if v12(v25.LavaLash) then
			return "lava_lash aoe 38";
		end
	end
	if (v25.IceStrike:IsReady() and v7:IsSpellInRange(v25.IceStrike) and v25.Hailstorm:IsAvailable() and v6:BuffDown(v25.IceStrikeBuff)) then
		if v12(v25.IceStrike) then
			return "ice_strike aoe 40";
		end
	end
	if (v25.FrostShock:IsReady() and v7:IsSpellInRange(v25.FrostShock) and v25.Hailstorm:IsAvailable() and v6:BuffUp(v25.HailstormBuff)) then
		if v12(v25.FrostShock) then
			return "frost_shock aoe 42";
		end
	end
	if (v25.Sundering:IsReady() and v7:IsInMeleeRange(10 + 1) and IsSundering) then
		if v12(v25.Sundering, true) then
			return "sundering aoe 44";
		end
	end
	if (v25.FlameShock:IsReady() and v7:IsSpellInRange(v25.FlameShock) and (v25.FireNova:IsAvailable() or v25.PrimordialWave:IsAvailable()) and (v25.FlameShockDebuff:AuraActiveCount() < v63) and (v25.FlameShockDebuff:AuraActiveCount() < (706 - (271 + 429)))) then
		if v30.CastCycle(v25.FlameShock, v62, v81, not v7:IsSpellInRange(v25.FlameShock)) then
			return "flame_shock aoe 46";
		end
	end
	if (v25.FireNova:IsReady() and IsFireNova and (v25.FlameShockDebuff:AuraActiveCount() >= (3 + 0))) then
		if v12(v25.FireNova) then
			return "fire_nova aoe 48";
		end
	end
	if (v25.Stormstrike:IsReady() and v7:IsSpellInRange(v25.Stormstrike) and v6:BuffUp(v25.CrashLightningBuff) and (v25.DeeplyRootedElements:IsAvailable() or (v6:BuffStack(v25.ConvergingStormsBuff) == v56))) then
		if v12(v25.Stormstrike) then
			return "stormstrike aoe 50";
		end
	end
	if (v25.CrashLightning:IsReady() and v7:IsInMeleeRange(1508 - (1408 + 92)) and v25.CrashingStorms:IsAvailable() and v6:BuffUp(v25.CLCrashLightningBuff)) then
		if v12(v25.CrashLightning, true) then
			return "crash_lightning aoe 52";
		end
	end
	if v25.Windstrike:IsReady() then
		if v12(v25.Windstrike) then
			return "windstrike aoe 54";
		end
	end
	if (v25.Stormstrike:IsReady() and v7:IsSpellInRange(v25.Stormstrike)) then
		if v12(v25.Stormstrike) then
			return "stormstrike aoe 56";
		end
	end
	if (v25.IceStrike:IsReady() and v7:IsSpellInRange(v25.IceStrike)) then
		if v12(v25.IceStrike) then
			return "ice_strike aoe 58";
		end
	end
	if (v25.LavaLash:IsReady() and v7:IsSpellInRange(v25.LavaLash)) then
		if v12(v25.LavaLash) then
			return "lava_lash aoe 60";
		end
	end
	if (v25.CrashLightning:IsReady() and v7:IsInMeleeRange(1094 - (461 + 625))) then
		if v12(v25.CrashLightning, true) then
			return "crash_lightning aoe 62";
		end
	end
	if (v25.FireNova:IsReady() and IsFireNova and (v25.FlameShockDebuff:AuraActiveCount() >= (1290 - (993 + 295)))) then
		if v12(v25.FireNova) then
			return "fire_nova aoe 64";
		end
	end
	if (v25.ChainLightning:IsReady() and UseSpender and v7:IsSpellInRange(v25.ChainLightning) and (v53 >= (1 + 4)) and v6:BuffDown(v25.PrimordialStormBuff)) then
		if v12(v25.ChainLightning) then
			return "chain_lightning aoe 66";
		end
	end
	if (v25.FlameShock:IsReady() and v7:IsSpellInRange(v25.FlameShock) and (v7:DebuffDown(v25.FlameShockDebuff))) then
		if v12(v25.FlameShock) then
			return "flame_shock aoe 68";
		end
	end
	if (v25.FrostShock:IsReady() and v7:IsSpellInRange(v25.FrostShock) and not v25.Hailstorm:IsAvailable()) then
		if v12(v25.FrostShock) then
			return "frost_shock aoe 70";
		end
	end
end
local function v99()
	if (v25.SurgingTotem:IsReady() and IsSurgingTotem and TargetInMeleeRange) then
		if v11.CastTarget(v25.SurgingTotem, v11.TName().PLAYER) then
			return "surging_totem aoe_totemic_open 2";
		end
	end
	if (v25.FlameShock:IsReady() and v7:IsSpellInRange(v25.FlameShock) and (v7:DebuffDown(v25.FlameShockDebuff))) then
		if v12(v25.FlameShock) then
			return "flame_shock aoe_totemic_open 4";
		end
	end
	if (v25.FireNova:IsReady() and IsFireNova and v25.SwirlingMaelstrom:IsAvailable() and (v25.FlameShockDebuff:AuraActiveCount() == v20(v63, 1177 - (418 + 753)))) then
		if v12(v25.FireNova) then
			return "fire_nova aoe_totemic_open 6";
		end
	end
	if (v25.PrimordialWave:IsReady() and TargetInMeleeRange and IsPrimordialWave and (v25.FlameShockDebuff:AuraActiveCount() == v20(v63, 3 + 3))) then
		if v12(v25.PrimordialWave) then
			return "primordial_wave aoe_totemic_open 8";
		end
	end
	if (v25.FeralSpirit:IsCastable() and IsFeralSpirit and TargetInMeleeRange and (v53 >= (1 + 7))) then
		if v12(v25.FeralSpirit, true) then
			return "feral_spirit aoe_totemic_open 10";
		end
	end
	if (v25.CrashLightning:IsReady() and v7:IsInMeleeRange(3 + 5) and (((v6:BuffStack(v25.ElectrostaticWagerBuff) > (3 + 6)) and v6:BuffUp(v25.DoomWindsBuff)) or v6:BuffDown(v25.CrashLightningBuff))) then
		if v12(v25.CrashLightning, true) then
			return "crash_lightning aoe_totemic_open 12";
		end
	end
	if (v25.DoomWinds:IsCastable() and IsDoomWinds and v7:IsInMeleeRange(534 - (406 + 123)) and (v53 >= (1777 - (1749 + 20)))) then
		if v12(v25.DoomWinds, true) then
			return "doom_winds aoe_totemic_open 14";
		end
	end
	if (v25.PrimordialStormAbility:IsCastable() and TargetInMeleeRange and (v53 >= (3 + 7)) and v6:BuffUp(v25.LegacyoftheFrostWitchBuff)) then
		if v12(v25.PrimordialWave) then
			return "primordial_storm aoe_totemic_open 16";
		end
	end
	if (v25.LavaLash:IsCastable() and v7:IsSpellInRange(v25.LavaLash) and (v6:BuffUp(v25.HotHandBuff) or (v6:BuffUp(v25.LegacyoftheFrostWitchBuff) and v6:BuffUp(v25.WhirlingFireBuff)))) then
		if v12(v25.LavaLash) then
			return "lava_lash aoe_totemic_open 18";
		end
	end
	if (v25.Sundering:IsReady() and v7:IsInMeleeRange(1333 - (1249 + 73)) and IsSundering and (v6:BuffUp(v25.LegacyoftheFrostWitchBuff))) then
		if v12(v25.Sundering, true) then
			return "sundering aoe_totemic_open 20";
		end
	end
	if (v53 >= (4 + 6)) then
		if (v25.ElementalBlast:IsReady() and UseSpender and v7:IsSpellInRange(v25.ElementalBlast)) then
			if v12(v25.ElementalBlast) then
				return "elemental_blast aoe_totemic_open 22";
			end
		end
		if (v25.ChainLightning:IsReady() and UseSpender and v7:IsSpellInRange(v25.ChainLightning)) then
			if v12(v25.ChainLightning) then
				return "chain_lightning aoe_totemic_open 24";
			end
		end
	end
	if (v25.FrostShock:IsReady() and v7:IsSpellInRange(v25.FrostShock) and v25.Hailstorm:IsAvailable() and v6:BuffUp(v25.HailstormBuff) and v31.SearingTotemActive) then
		if v12(v25.FrostShock) then
			return "frost_shock aoe_totemic_open 26";
		end
	end
	if (v25.FireNova:IsReady() and IsFireNova and v31.SearingTotemActive and (v25.FlameShockDebuff:AuraActiveCount() == v20(v63, 1151 - (466 + 679)))) then
		if v12(v25.FireNova) then
			return "fire_nova aoe_totemic_open 28";
		end
	end
	if (v25.IceStrike:IsReady() and v7:IsSpellInRange(v25.IceStrike)) then
		if v12(v25.IceStrike) then
			return "ice_strike aoe_totemic_open 30";
		end
	end
	if (v25.Stormstrike:IsReady() and v7:IsSpellInRange(v25.Stormstrike) and (v53 < (24 - 14)) and v6:BuffDown(v25.LegacyoftheFrostWitchBuff)) then
		if v12(v25.Stormstrike) then
			return "stormstrike aoe_totemic_open 32";
		end
	end
	if (v25.LavaLash:IsCastable() and v7:IsSpellInRange(v25.LavaLash)) then
		if v12(v25.LavaLash) then
			return "lava_lash aoe_totemic_open 34";
		end
	end
end
local function v100()
	if (v25.SurgingTotem:IsReady() and IsSurgingTotem and TargetInMeleeRange) then
		if v11.CastTarget(v25.SurgingTotem, v11.TName().PLAYER) then
			return "surging_totem aoe_totemic 2";
		end
	end
	if ((v25.DoomWinds:CooldownUp() or v25.Sundering:CooldownUp() or v6:BuffDown(v25.HotHandBuff)) and (v3.CombatTime() < (42 - 27)) and v6:AffectingCombat()) then
		local v143 = v99();
		if v143 then
			return v143;
		end
		if v11.CastAnnotated(v25.Pool, false, "WAIT") then
			return "Wait for AoeTotemicOpen()";
		end
	end
	if (IsAscendance and TargetInMeleeRange and v25.Ascendance:IsCastable() and (v66 == v25.ChainLightning)) then
		if v12(v25.Ascendance, true) then
			return "ascendance aoe_totemic 4";
		end
	end
	if (v25.FlameShock:IsReady() and v7:IsSpellInRange(v25.FlameShock) and v7:DebuffDown(v25.FlameShockDebuff) and (v25.AshenCatalyst:IsAvailable() or v25.PrimordialWave:IsAvailable())) then
		if v12(v25.FlameShock) then
			return "flame_shock aoe_totemic 6";
		end
	end
	if (v25.CrashLightning:IsReady() and v7:IsInMeleeRange(1908 - (106 + 1794)) and v25.CrashingStorms:IsAvailable() and (v63 >= ((5 + 10) - ((2 + 3) * v15(v25.UnrulyWinds:IsAvailable()))))) then
		if v12(v25.CrashLightning, true) then
			return "crash_lightning aoe_totemic 8";
		end
	end
	if (v25.FeralSpirit:IsCastable() and IsFeralSpirit and TargetInMeleeRange and ((v25.DoomWinds:CooldownRemains() > (88 - 58)) or (v25.DoomWinds:CooldownRemains() < (18 - 11))) and ((v25.PrimordialWave:CooldownRemains() < (116 - (4 + 110))) or v6:BuffUp(v25.PrimordialStormBuff) or not v25.PrimordialStorm:IsAvailable())) then
		if v12(v25.FeralSpirit, true) then
			return "feral_spirit aoe_totemic 10";
		end
	end
	if (v25.DoomWinds:IsCastable() and IsDoomWinds and v7:IsInMeleeRange(589 - (57 + 527)) and not v25.ElementalSpirits:IsAvailable()) then
		if v12(v25.DoomWinds, true) then
			return "doom_winds aoe_totemic 12";
		end
	end
	if (v25.PrimordialStormAbility:IsCastable() and TargetInMeleeRange and (v53 >= (1437 - (41 + 1386))) and (v25.DoomWinds:CooldownRemains() > (106 - (17 + 86)))) then
		if v12(v25.PrimordialWave) then
			return "primordial_storm aoe_totemic 14";
		end
	end
	if (v25.PrimordialWave:IsReady() and TargetInMeleeRange and IsPrimordialWave and (v25.FlameShockDebuff:AuraActiveCount() == v20(v63, 5 + 1))) then
		if v12(v25.PrimordialWave) then
			return "primordial_wave aoe_totemic 16";
		end
	end
	if (v25.Windstrike:IsCastable() and v7:IsInRange(66 - 36)) then
		if v12(v25.Windstrike) then
			return "windstrike aoe_totemic 18";
		end
	end
	if (v25.ElementalBlast:IsReady() and UseSpender and v7:IsSpellInRange(v25.ElementalBlast) and (not v25.ElementalSpirits:IsAvailable() or (v25.ElementalSpirits:IsAvailable() and ((v25.ElementalBlast:Charges() == v25.ElementalBlast:MaxCharges()) or (v31.FeralSpiritCount >= (5 - 3))))) and (v53 == v54) and (not v25.CrashingStorms:IsAvailable() or (v63 <= (169 - (122 + 44))))) then
		if v12(v25.ElementalBlast) then
			return "elemental_blast aoe_totemic 20";
		end
	end
	if (v25.LavaLash:IsCastable() and v7:IsSpellInRange(v25.LavaLash) and (v6:BuffUp(v25.HotHandBuff))) then
		if v12(v25.LavaLash) then
			return "lava_lash aoe_totemic 22 ";
		end
	end
	if (v25.CrashLightning:IsReady() and v7:IsInMeleeRange(13 - 5) and (v6:BuffStack(v25.ElectrostaticWagerBuff) > (26 - 18))) then
		if v12(v25.CrashLightning, true) then
			return "crash_lightning aoe_totemic 24";
		end
	end
	if (v25.Sundering:IsReady() and v7:IsInMeleeRange(9 + 2) and IsSundering and (v6:BuffUp(v25.DoomWindsBuff) or (v25.Earthsurge:IsAvailable() and (v6:BuffUp(v25.LegacyoftheFrostWitchBuff) or not v25.LegacyoftheFrostWitch:IsAvailable()) and v75(v25.SurgingTotem)))) then
		if v12(v25.Sundering, true) then
			return "sundering aoe_totemic 26";
		end
	end
	if (v25.ChainLightning:IsReady() and UseSpender and v7:IsSpellInRange(v25.ChainLightning) and (v53 >= (2 + 8)) and (v6:BuffStack(v25.ElectrostaticWagerBuff) > (7 - 3)) and v6:BuffDown(v25.CLCrashLightningBuff) and v6:BuffUp(v25.DoomWindsBuff)) then
		if v12(v25.ChainLightning) then
			return "chain_lightning aoe_totemic 28";
		end
	end
	if (v25.ElementalBlast:IsReady() and UseSpender and v7:IsSpellInRange(v25.ElementalBlast) and (v53 >= (75 - (30 + 35)))) then
		if v12(v25.ElementalBlast) then
			return "elemental_blast aoe_totemic 30";
		end
	end
	if (v25.ChainLightning:IsReady() and UseSpender and v7:IsSpellInRange(v25.ChainLightning) and (v53 >= (7 + 3)) and v6:BuffDown(v25.PrimordialStormBuff)) then
		if v12(v25.ChainLightning) then
			return "chain_lightning aoe_totemic 32";
		end
	end
	if (v25.CrashLightning:IsReady() and v7:IsInMeleeRange(1265 - (1043 + 214)) and (v6:BuffUp(v25.DoomWindsBuff) or v6:BuffDown(v25.CrashLightningBuff) or (v25.AlphaWolf:IsAvailable() and v6:BuffUp(v25.FeralSpiritBuff) and (v76() == (0 - 0))))) then
		if v12(v25.CrashLightning, true) then
			return "crash_lightning aoe_totemic 34";
		end
	end
	if (v25.VoltaicBlazeAbility:IsReady() and v7:IsSpellInRange(v25.VoltaicBlazeAbility)) then
		if v12(v25.VoltaicBlazeAbility) then
			return "voltaic_blaze aoe_totemic 36";
		end
	end
	if (v25.FireNova:IsReady() and IsFireNova and (v25.FlameShockDebuff:AuraActiveCount() == v20(v63, 1218 - (323 + 889))) and v31.SearingTotemActive) then
		if v12(v25.FireNova) then
			return "fire_nova aoe_totemic 38";
		end
	end
	if (v25.LavaLash:IsReady() and v7:IsSpellInRange(v25.LavaLash) and v25.MoltenAssault:IsAvailable() and v7:DebuffUp(v25.FlameShockDebuff)) then
		if v12(v25.LavaLash) then
			return "lava_lash aoe_totemic 40";
		end
	end
	if (v25.FrostShock:IsReady() and v7:IsSpellInRange(v25.FrostShock) and v25.Hailstorm:IsAvailable() and v6:BuffUp(v25.HailstormBuff) and v31.SearingTotemActive) then
		if v12(v25.FrostShock) then
			return "frost_shock aoe_totemic 42";
		end
	end
	if (v25.CrashLightning:IsReady() and v7:IsInMeleeRange(21 - 13) and (v25.CrashingStorms:IsAvailable())) then
		if v12(v25.CrashLightning, true) then
			return "crash_lightning aoe_totemic 44";
		end
	end
	if (v25.FireNova:IsReady() and IsFireNova and (v25.FlameShockDebuff:AuraActiveCount() == v20(v63, 586 - (361 + 219)))) then
		if v12(v25.FireNova) then
			return "fire_nova aoe_totemic 46";
		end
	end
	if (v25.FrostShock:IsReady() and v7:IsSpellInRange(v25.FrostShock) and v25.Hailstorm:IsAvailable() and v6:BuffUp(v25.HailstormBuff)) then
		if v12(v25.FrostShock) then
			return "frost_shock aoe_totemic 48";
		end
	end
	if (v25.CrashLightning:IsReady() and v7:IsInMeleeRange(328 - (53 + 267))) then
		if v12(v25.CrashLightning, true) then
			return "crash_lightning aoe_totemic 50";
		end
	end
	if (v25.IceStrike:IsReady() and v7:IsSpellInRange(v25.IceStrike) and v25.Hailstorm:IsAvailable() and v6:BuffDown(v25.IceStrikeBuff)) then
		if v12(v25.IceStrike) then
			return "ice_strike aoe_totemic 52";
		end
	end
	if ((v53 >= (2 + 3)) and v6:BuffDown(v25.PrimordialStormBuff)) then
		if (v25.ElementalBlast:IsReady() and UseSpender and v7:IsSpellInRange(v25.ElementalBlast)) then
			if v12(v25.ElementalBlast) then
				return "elemental_blast aoe_totemic 54";
			end
		end
		if (v25.ChainLightning:IsReady() and UseSpender and v7:IsSpellInRange(v25.ChainLightning)) then
			if v12(v25.ChainLightning) then
				return "chain_lightning aoe_totemic 56";
			end
		end
	end
	if (v25.Stormstrike:IsReady() and v7:IsSpellInRange(v25.Stormstrike)) then
		if v12(v25.Stormstrike) then
			return "stormstrike aoe_totemic 58";
		end
	end
	if (v25.Sundering:IsReady() and v7:IsInMeleeRange(424 - (15 + 398)) and IsSundering and (v6:BuffUp(v25.DoomWindsBuff) or (v25.Earthsurge:IsAvailable() and (v6:BuffUp(v25.LegacyoftheFrostWitchBuff) or not v25.LegacyoftheFrostWitch:IsAvailable()) and v75(v25.SurgingTotem)))) then
		if v12(v25.Sundering, true) then
			return "sundering aoe_totemic 60";
		end
	end
	if (v25.FireNova:IsReady() and IsFireNova and ((v25.FlameShockDebuff:AuraActiveCount() == (988 - (18 + 964))) or ((v25.FlameShockDebuff:AuraActiveCount() >= (14 - 10)) and (v25.FlameShockDebuff:AuraActiveCount() >= v63)))) then
		if v12(v25.FireNova) then
			return "fire_nova aoe_totemic 62";
		end
	end
	if (v25.VoltaicBlazeAbility:IsReady() and v7:IsSpellInRange(v25.VoltaicBlazeAbility)) then
		if v12(v25.VoltaicBlazeAbility) then
			return "voltaic_blaze aoe_totemic 64";
		end
	end
	if (v25.IceStrike:IsReady() and v7:IsSpellInRange(v25.IceStrike) and v25.Hailstorm:IsAvailable() and v6:BuffDown(v25.IceStrikeBuff)) then
		if v12(v25.IceStrike) then
			return "ice_strike aoe_totemic 66";
		end
	end
	if (v25.FrostShock:IsReady() and v7:IsSpellInRange(v25.FrostShock) and v25.Hailstorm:IsAvailable() and v6:BuffUp(v25.HailstormBuff)) then
		if v12(v25.FrostShock) then
			return "frost_shock aoe_totemic 68";
		end
	end
	if (v25.Sundering:IsReady() and v7:IsInMeleeRange(7 + 4) and IsSundering and (v6:BuffUp(v25.LegacyoftheFrostWitchBuff) or not v25.LegacyoftheFrostWitch:IsAvailable()) and v75(v25.SurgingTotem)) then
		if v12(v25.Sundering, true) then
			return "sundering aoe_totemic 70";
		end
	end
	if (v25.FlameShock:IsReady() and v7:IsSpellInRange(v25.FlameShock) and v25.MoltenAssault:IsAvailable() and v7:DebuffDown(v25.FlameShockDebuff)) then
		if v12(v25.FlameShock) then
			return "flame_shock aoe_totemic 72";
		end
	end
	if (v25.FireNova:IsReady() and IsFireNova and (v25.FlameShockDebuff:AuraActiveCount() >= (2 + 1))) then
		if v12(v25.FireNova) then
			return "fire_nova aoe_totemic 74";
		end
	end
	if (v25.IceStrike:IsReady() and v7:IsSpellInRange(v25.IceStrike)) then
		if v12(v25.IceStrike) then
			return "ice_strike aoe_totemic 76";
		end
	end
	if (v25.LavaLash:IsReady() and v7:IsSpellInRange(v25.LavaLash)) then
		if v12(v25.LavaLash) then
			return "lava_lash aoe_totemic 78";
		end
	end
	if (v25.CrashLightning:IsReady() and v7:IsInMeleeRange(858 - (20 + 830))) then
		if v12(v25.CrashLightning, true) then
			return "crash_lightning aoe_totemic 80";
		end
	end
	if (v25.FlameShock:IsReady() and v7:IsSpellInRange(v25.FlameShock) and (v7:DebuffDown(v25.FlameShockDebuff))) then
		if v12(v25.FlameShock) then
			return "flame_shock aoe_totemic 82";
		end
	end
end
local function v101()
	if (v25.FeralSpirit:IsCastable() and IsFeralSpirit and TargetInMeleeRange and (v25.ElementalSpirits:IsAvailable())) then
		if v12(v25.FeralSpirit, true) then
			return "feral_spirit funnel 2";
		end
	end
	if (v25.SurgingTotem:IsReady() and IsSurgingTotem and TargetInMeleeRange) then
		if v11.CastTarget(v25.SurgingTotem, v11.TName().PLAYER) then
			return "surging_totem funnel 4";
		end
	end
	if (IsAscendance and TargetInMeleeRange and v25.Ascendance:IsCastable()) then
		if v12(v25.Ascendance, true) then
			return "ascendance funnel 6";
		end
	end
	if (v25.Windstrike:IsCastable() and v7:IsInRange(24 + 6) and ((v25.ThorimsInvocation:IsAvailable() and (v53 > (126 - (116 + 10)))) or (v6:BuffStack(v25.ConvergingStormsBuff) == v56))) then
		if v12(v25.Windstrike) then
			return "windstrike funnel 8";
		end
	end
	if (v25.TempestAbility:IsReady() and UseSpender and v87(v32.Enhancement_TTD.TempestTTD) and v7:IsInRange(3 + 37) and ((v53 == v54) or ((v53 >= (743 - (542 + 196))) and ((v31.TempestMaelstrom > (64 - 34)) or (v6:BuffStack(v25.AwakeningStormsBuff) == (1 + 1)))))) then
		if v12(v25.TempestAbility) then
			return "tempest funnel 10";
		end
	end
	if (v25.LightningBolt:IsCastable() and UseSpender and v7:IsSpellInRange(v25.LightningBolt) and ((v25.FlameShockDebuff:AuraActiveCount() >= v63) or (v25.FlameShockDebuff:AuraActiveCount() >= (4 + 2))) and v6:BuffUp(v25.PrimordialWaveBuff) and (v53 == v54) and (v6:BuffDown(v25.SplinteredElementsBuff) or (v68 <= (5 + 7)))) then
		if v12(v25.LightningBolt) then
			return "lightning_bolt funnel 12";
		end
	end
	if (v25.ElementalBlast:IsReady() and UseSpender and v7:IsSpellInRange(v25.ElementalBlast) and (v53 >= (12 - 7)) and v25.ElementalSpirits:IsAvailable() and (v31.FeralSpiritCount >= (9 - 5))) then
		if v12(v25.ElementalBlast) then
			return "elemental_blast funnel 14";
		end
	end
	if (v25.LightningBolt:IsCastable() and UseSpender and v7:IsSpellInRange(v25.LightningBolt) and v25.Supercharge:IsAvailable() and (v53 == v54) and (v60 > v61)) then
		if v12(v25.LightningBolt) then
			return "lightning_bolt funnel 16";
		end
	end
	if (v25.ChainLightning:IsCastable() and ((v25.Supercharge:IsAvailable() and (v53 == v54)) or (v6:BuffUp(v25.ArcDischargeBuff) and (v53 >= (1556 - (1126 + 425)))))) then
		if v12(v25.ChainLightning) then
			return "chain_lightning funnel 18";
		end
	end
	if (v25.LavaLash:IsReady() and v7:IsSpellInRange(v25.LavaLash) and ((v25.MoltenAssault:IsAvailable() and v7:DebuffUp(v25.FlameShockDebuff) and (v25.FlameShockDebuff:AuraActiveCount() < v63) and (v25.FlameShockDebuff:AuraActiveCount() < (411 - (118 + 287)))) or (v25.AshenCatalyst:IsAvailable() and (v6:BuffStack(v25.AshenCatalystBuff) == v55)))) then
		if v12(v25.LavaLash) then
			return "lava_lash funnel 20";
		end
	end
	if (v25.PrimordialWave:IsReady() and TargetInMeleeRange and IsPrimordialWave and (v6:BuffDown(v25.PrimordialWaveBuff))) then
		if v12(v25.PrimordialWave) then
			return "primordial_wave funnel 22";
		end
	end
	if (v25.ElementalBlast:IsReady() and UseSpender and v7:IsSpellInRange(v25.ElementalBlast) and (not v25.ElementalSpirits:IsAvailable() or (v25.ElementalSpirits:IsAvailable() and ((v25.ElementalBlast:Charges() == v25.ElementalBlast:MaxCharges()) or v6:BuffUp(v25.FeralSpiritBuff)))) and (v53 == v54)) then
		if v12(v25.ElementalBlast) then
			return "elemental_blast funnel 24";
		end
	end
	if (v25.FeralSpirit:IsCastable() and IsFeralSpirit and TargetInMeleeRange) then
		if v12(v25.FeralSpirit, true) then
			return "feral_spirit funnel 26";
		end
	end
	if (v25.DoomWinds:IsCastable() and IsDoomWinds and v7:IsInMeleeRange(19 - 14)) then
		if v12(v25.DoomWinds, true) then
			return "doom_winds funnel 28";
		end
	end
	if (v25.Stormstrike:IsReady() and v7:IsSpellInRange(v25.Stormstrike) and (v6:BuffStack(v25.ConvergingStormsBuff) == v56)) then
		if v12(v25.Stormstrike) then
			return "stormstrike funnel 30";
		end
	end
	if (v25.LavaBurst:IsReady() and v7:IsSpellInRange(v25.LavaBurst) and (v31.MoltenWeaponStacks > v31.CracklingSurgeStacks) and (v53 == v54)) then
		if v12(v25.LavaBurst) then
			return "lava_burst funnel 32";
		end
	end
	if (v25.LightningBolt:IsCastable() and UseSpender and v7:IsSpellInRange(v25.LightningBolt) and (v53 == v54) and (v60 > v61)) then
		if v12(v25.LightningBolt) then
			return "lightning_bolt funnel 34";
		end
	end
	if (v25.ChainLightning:IsCastable() and (v53 == v54)) then
		if v12(v25.ChainLightning) then
			return "chain_lightning funnel 36";
		end
	end
	if (v25.CrashLightning:IsReady() and v7:IsInMeleeRange(1129 - (118 + 1003)) and (v6:BuffUp(v25.DoomWindsBuff) or v6:BuffDown(v25.CrashLightningBuff) or (v25.AlphaWolf:IsAvailable() and v6:BuffUp(v25.FeralSpiritBuff) and (v76() == (0 - 0))) or (v25.ConvergingStorms:IsAvailable() and (v6:BuffStack(v25.ConvergingStormsBuff) < v56)))) then
		if v12(v25.CrashLightning, true) then
			return "crash_lightning funnel 38";
		end
	end
	if (v25.Sundering:IsReady() and v7:IsInMeleeRange(388 - (142 + 235)) and IsSundering and (v6:BuffUp(v25.DoomWindsBuff) or v25.Earthsurge:IsAvailable())) then
		if v12(v25.Sundering, true) then
			return "sundering funnel 40";
		end
	end
	if (v25.FireNova:IsReady() and IsFireNova and ((v25.FlameShockDebuff:AuraActiveCount() >= (27 - 21)) or ((v25.FlameShockDebuff:AuraActiveCount() >= (1 + 3)) and (v25.FlameShockDebuff:AuraActiveCount() >= v63)))) then
		if v12(v25.FireNova) then
			return "fire_nova funnel 42";
		end
	end
	if (v25.IceStrike:IsReady() and v7:IsSpellInRange(v25.IceStrike) and v25.Hailstorm:IsAvailable() and v6:BuffDown(v25.IceStrikeBuff)) then
		if v12(v25.IceStrike) then
			return "ice_strike funnel 44";
		end
	end
	if (v25.FrostShock:IsReady() and v7:IsSpellInRange(v25.FrostShock) and v25.Hailstorm:IsAvailable() and v6:BuffUp(v25.HailstormBuff)) then
		if v12(v25.FrostShock) then
			return "frost_shock funnel 46";
		end
	end
	if (v25.Sundering:IsReady() and v7:IsInMeleeRange(988 - (553 + 424)) and IsSundering) then
		if v12(v25.Sundering, true) then
			return "sundering funnel 48";
		end
	end
	if (v25.FlameShock:IsReady() and v7:IsSpellInRange(v25.FlameShock) and v25.MoltenAssault:IsAvailable() and v7:DebuffDown(v25.FlameShockDebuff)) then
		if v12(v25.FlameShock) then
			return "flame_shock funnel 50";
		end
	end
	if (v25.FlameShock:IsReady() and v7:IsSpellInRange(v25.FlameShock) and (v25.FireNova:IsAvailable() or v25.PrimordialWave:IsAvailable()) and (v25.FlameShockDebuff:AuraActiveCount() < v63) and (v25.FlameShockDebuff:AuraActiveCount() < (10 - 4))) then
		if v12(v25.FlameShock) then
			return "flame_shock funnel 52";
		end
	end
	if (v25.FireNova:IsReady() and IsFireNova and (v25.FlameShockDebuff:AuraActiveCount() >= (3 + 0))) then
		if v12(v25.FireNova) then
			return "fire_nova funnel 54";
		end
	end
	if (v25.Stormstrike:IsReady() and v7:IsSpellInRange(v25.Stormstrike) and v6:BuffUp(v25.CrashLightningBuff) and v25.DeeplyRootedElements:IsAvailable()) then
		if v12(v25.Stormstrike) then
			return "stormstrike funnel 56";
		end
	end
	if (v25.CrashLightning:IsReady() and v7:IsInMeleeRange(8 + 0) and v25.CrashingStorms:IsAvailable() and v6:BuffUp(v25.CLCrashLightningBuff) and (v63 >= (3 + 1))) then
		if v12(v25.CrashLightning, true) then
			return "crash_lightning funnel 58";
		end
	end
	if (v25.Windstrike:IsCastable() and v7:IsInRange(13 + 17)) then
		if v12(v25.Windstrike) then
			return "windstrike funnel 60";
		end
	end
	if (v25.Stormstrike:IsReady() and v7:IsSpellInRange(v25.Stormstrike)) then
		if v12(v25.Stormstrike) then
			return "stormstrike funnel 62";
		end
	end
	if (v25.IceStrike:IsReady() and v7:IsSpellInRange(v25.IceStrike)) then
		if v12(v25.IceStrike) then
			return "ice_strike funnel 64";
		end
	end
	if (v25.LavaLash:IsReady() and v7:IsSpellInRange(v25.LavaLash)) then
		if v12(v25.LavaLash) then
			return "lava_lash funnel 66";
		end
	end
	if (v25.CrashLightning:IsReady() and v7:IsInMeleeRange(5 + 3)) then
		if v12(v25.CrashLightning, true) then
			return "crash_lightning funnel 68";
		end
	end
	if (v25.FireNova:IsReady() and IsFireNova and (v25.FlameShockDebuff:AuraActiveCount() >= (4 - 2))) then
		if v12(v25.FireNova) then
			return "fire_nova funnel 70";
		end
	end
	if (v25.ElementalBlast:IsReady() and UseSpender and v7:IsSpellInRange(v25.ElementalBlast) and (not v25.ElementalSpirits:IsAvailable() or (v25.ElementalSpirits:IsAvailable() and ((v25.ElementalBlast:Charges() == v25.ElementalBlast:MaxCharges()) or v6:BuffUp(v25.FeralSpiritBuff)))) and (v53 >= (13 - 8))) then
		if v12(v25.ElementalBlast) then
			return "elemental_blast funnel 72";
		end
	end
	if (v25.LavaBurst:IsReady() and v7:IsSpellInRange(v25.LavaBurst) and (v31.MoltenWeaponStacks > v31.CracklingSurgeStacks) and (v53 >= (11 - 6))) then
		if v12(v25.LavaBurst) then
			return "lava_burst funnel 74";
		end
	end
	if (v25.LightningBolt:IsCastable() and UseSpender and v7:IsSpellInRange(v25.LightningBolt) and (v53 >= (2 + 3)) and (v60 > v61)) then
		if v12(v25.LightningBolt) then
			return "lightning_bolt funnel 76";
		end
	end
	if (v25.ChainLightning:IsReady() and UseSpender and v7:IsSpellInRange(v25.ChainLightning) and (v53 >= (24 - 19))) then
		if v12(v25.ChainLightning) then
			return "chain_lightning funnel 78";
		end
	end
	if (v25.FlameShock:IsReady() and v7:IsSpellInRange(v25.FlameShock) and (v7:DebuffDown(v25.FlameShockDebuff))) then
		if v12(v25.FlameShock) then
			return "flame_shock funnel 80";
		end
	end
	if (v25.FrostShock:IsReady() and v7:IsSpellInRange(v25.FrostShock) and not v25.Hailstorm:IsAvailable()) then
		if v12(v25.FrostShock) then
			return "frost_shock funnel 82";
		end
	end
end
local function v102()
	v30.HealthPotions();
	if v6:IsChanneling(v26.ManicGrieftorch.ItemUseSpell) then
		return "Dont cut Torch";
	end
	InterruptToggle = v11.ToggleIconFrame:GetToggle(754 - (239 + 514));
	DispelToggle = v11.ToggleIconFrame:GetToggle(1 + 1);
	Smallcds = v11.ToggleIconFrame:GetToggle(1332 - (797 + 532));
	UseSpender = v11.ToggleIconFrame:GetToggle(3 + 1);
	FunnelToggle = v11.ToggleIconFrame:GetToggle(2 + 3);
	v90();
	v27 = v30.UnitsinRange(v25.HealingSurge);
	v62 = v6:GetEnemiesInMeleeRange(23 - 13);
	if v13() then
		v63 = #v62;
		v64 = v74(1242 - (373 + 829));
	else
		v63 = 732 - (476 + 255);
		v64 = 1131 - (369 + 761);
	end
	if (v25.PoisonCleansingTotem:IsAvailable() and v25.PoisonCleansingTotem:IsReady()) then
		v71 = v30.DebuffCount(v27, v70);
	else
		v71 = 0 + 0;
	end
	IsRacials = v87(v32.Enhancement_TTD.RacialsTTD) and v88(v32.Enhancement_CDUSE.Racials);
	IsPotions = v87(v32.Enhancement_TTD.PotionsTTD) and (v32.Enhancement_CDUSE.Potionswhensolo or (not v32.Enhancement_CDUSE.Potionswhensolo and not v30.ISSolo())) and v88(v32.Enhancement_CDUSE.Potions);
	IsTrinket1 = v87(v32.Enhancement_TTD.TrinketsTTD) and v88(v32.Enhancement_CDUSE.Trinket1);
	IsTrinket2 = v87(v32.Enhancement_TTD.TrinketsTTD) and v88(v32.Enhancement_CDUSE.Trinket2);
	IsAscendance = v87(v32.Enhancement_TTD.AscendanceTTD) and v88(v32.Enhancement_CDUSE.Ascendance);
	IsFireNova = v88(v32.Enhancement_CDUSE.FireNova);
	IsEarthElemental = v88(v32.Enhancement_CDUSE.EarthElemental);
	IsDoomWinds = v87(v32.Enhancement_TTD.DoomWindsTTD) and v88(v32.Enhancement_CDUSE.DoomWinds);
	IsFeralSpirit = v87(v32.Enhancement_TTD.FeralSpiritTTD) and v88(v32.Enhancement_CDUSE.FeralSpirit);
	IsSundering = v87(v32.Enhancement_TTD.SunderingTTD) and v88(v32.Enhancement_CDUSE.Sundering);
	IsIceStrike = v88(v32.Enhancement_CDUSE.IceStrike);
	IsPrimordialWave = v87(v32.Enhancement_TTD.PrimordialWaveTTD) and v88(v32.Enhancement_CDUSE.PrimordialWave);
	IsSurgingTotem = v87(v32.Enhancement_TTD.SurgingTotemTTD) and v88(v32.Enhancement_CDUSE.SurgingTotem);
	TargetInMeleeRange = v7:IsInRange(9 - 4);
	v47, v49, _, _, v48, v50 = v18();
	if ((not v47 or (v49 < (1137002 - 537002))) and v25.WindfuryWeapon:IsCastable()) then
		if v12(v25.WindfuryWeapon) then
			return "windfury_weapon enchant";
		end
	end
	if ((not v48 or (v50 < (600238 - (64 + 174)))) and v25.FlametongueWeapon:IsCastable()) then
		if v12(v25.FlametongueWeapon) then
			return "flametongue_weapon enchant";
		end
	end
	if (v25.SpiritWalk:IsCastable() and v6:DebuffUp(v25.EntangledDebuff)) then
		if v12(v25.SpiritWalk) then
			return "SpiritWalk for entangling";
		end
	end
	if (v30.TargetIsValid() or v6:AffectingCombat()) then
		v67 = v3.BossFightRemains();
		v86 = true;
		v68 = v67;
		if (v68 == (1583 + 9528)) then
			v86 = false;
			v68 = v3.FightRemains(v62, false);
		end
		v53 = v6:BuffStack(v25.MaelstromWeaponBuff);
		v58 = v20((v25.FeralSpirit:CooldownRemains() / ((5 - 1) * v15(v25.WitchDoctorsAncestry:IsAvailable()))) + ((1336 - (144 + 192)) * v15(not v25.FeralSpirit:IsAvailable())), v25.DoomWinds:CooldownRemains() + ((1216 - (42 + 174)) * v15(not v25.DoomWinds:IsAvailable())), v25.Ascendance:CooldownRemains() + ((752 + 248) * v15(not v25.Ascendance:IsAvailable())));
		v59 = (1 + 0 + (v15(v7:DebuffUp(v25.ChaosBrandDebuff)) * (0.05 + 0))) * ((1505 - (363 + 1141)) + (v15(v7:DebuffUp(v25.HuntersMarkDebuff) and (v7:HealthPercentage() >= (1660 - (1183 + 397)))) * (0.05 - 0)));
		local v144 = (1.75 + 0) * v25.LightningBolt:Damage();
		local v145 = (0.2 + 0) * v25.LightningBolt:Damage() * ((v7:DebuffUp(v25.LightningRodDebuff) and (1976.75 - (1913 + 62))) or (1 + 0));
		v60 = v25.LightningBolt:Damage() * ((2 - 1) + (v15(v7:DebuffUp(v25.LightningRodDebuff)) * v59 * ((1934 - (565 + 1368)) + (v15(v6:BuffUp(v25.PrimordialWaveBuff)) * v25.FlameShockDebuff:AuraActiveCount() * v144)) * v145));
		v61 = v25.ChainLightning:Damage() * ((3 - 2) + (v15(v7:DebuffUp(v25.LightningRodDebuff)) * v59 * v20(v63, (1664 - (1477 + 184)) + ((2 - 0) * v15(v25.CrashingStorms:IsAvailable()))) * v145));
	end
	if v6:AffectingCombat() then
		if v6:PrevGCD(1 + 0, v25.ChainLightning) then
			v66 = v25.ChainLightning;
		elseif v6:PrevGCD(857 - (564 + 292), v25.LightningBolt) then
			v66 = v25.LightningBolt;
		end
	end
	if ((v32.Commons.AutoWolf == "always") or ((v32.Commons.AutoWolf == "Only in Combat") and v6:AffectingCombat()) or ((v32.Commons.AutoWolf == "Only out of combat") and not v6:AffectingCombat())) then
		if (v6:IsMoving() and not v6:IsMounted() and v6:BuffDown(v25.GhostWolf) and not v6:AffectingCombat()) then
			v12(v25.GhostWolf);
			return "Ghost Wolf";
		end
		if (v6:IsMoving() and not v6:IsMounted() and v6:BuffDown(v25.GhostWolf) and v6:AffectingCombat() and (v90() > (1 - 0)) and (not v7:IsInMeleeRange(23 - 15) or not v30.TargetIsValid())) then
			v12(v25.GhostWolf);
			return "Ghost Wolf";
		end
	end
	v24 = v30.IncorpCycle(v25.Hex, 334 - (244 + 60), false, false);
	if v24 then
		return v24;
	end
	if DispelToggle then
		v24 = v30.PurgeCycle(v25.Purge, 31 + 9, false, v32.Commons.TabForPurge);
		if v24 then
			return v24;
		end
		if (v25.CleanseSpirit:IsCastable() and v6:IsInDungeonArea() and v6:IsInParty()) then
			v24 = v30.DispelCycle(v25.CleanseSpirit, "Curse", nil, v27);
			if v24 then
				return v24;
			end
		end
		if (v25.PoisonCleansingTotem:IsAvailable() and v25.PoisonCleansingTotem:IsReady()) then
			if v30.DispelCycle(v25.PoisonCleansingTotem, "Poison", nil, v27) then
				return v11.CastTarget(v25.PoisonCleansingTotem);
			end
			if ((v71 > (477 - (41 + 435))) or (v25.CleanseSpirit:CooldownDown() and (v71 > (1001 - (938 + 63))))) then
				return v11.CastTarget(v25.PoisonCleansingTotem);
			end
		end
	end
	local v134 = ((v25.ElementalOrbit:IsAvailable()) and v25.EarthShieldSelfBuff) or v25.EarthShieldOtherBuff;
	if (((v32.Enhancement.Defensives.Earthshieldooc and not v6:AffectingCombat()) or not v32.Enhancement.Defensives.Earthshieldooc) and (v25.ElementalOrbit:IsAvailable() or v32.Enhancement.PreferEarthShield) and v25.EarthShield:IsReady() and (v6:BuffDown(v134) or (not v6:AffectingCombat() and (v6:BuffStack(v134) < (4 + 1))))) then
		if v11.CastTarget(v25.EarthShield, v11.TName().PLAYER) then
			return "EarthShield";
		end
	elseif (((v32.Enhancement.Defensives.Earthshieldooc and not v6:AffectingCombat()) or not v32.Enhancement.Defensives.Earthshieldooc) and (v25.ElementalOrbit:IsAvailable() or not v32.Enhancement.PreferEarthShield or not v25.EarthShield:IsAvailable()) and v25.LightningShield:IsReady() and v6:BuffDown(v25.LightningShield)) then
		if v12(v25.LightningShield) then
			return "lightning_shield main 3";
		end
	end
	if (v25.SkyFury:IsReady() and (v6:Level() >= (1141 - (936 + 189))) and not v6:DebuffUp(v25.Corruption) and ((v30.GroupBuffMissing(v25.SkyFuryBuff) and (v32.Commons.SkyFury == "check whole group") and (v6:IsInRaidArea() or v6:IsInDungeonArea())) or (v6:BuffDown(v25.SkyFuryBuff, true) and ((v32.Commons.SkyFury == "only check us") or (v32.Commons.SkyFury == "check whole group")))) and not v6:IsMounted()) then
		if v11.CastTarget(v25.SkyFury, v11.TName().PLAYER) then
			return "SkyFury";
		end
	end
	v24 = v91();
	if v24 then
		return v24;
	end
	if v30.TargetIsValid() then
		if (not v32.Enhancement.AttackonlyinCombat or (v32.Enhancement.AttackonlyinCombat and v7:AffectingCombat())) then
			if not v82(v5.Target) then
				if not v6:AffectingCombat() then
					v24 = v92();
					if v24 then
						return v24;
					end
				end
				if InterruptToggle then
					v24 = v30.InterruptCycle(v25.WindShear, 10 + 20, true, nil, false);
					v24 = v30.InterruptCycle(v25.Thunderstorm, 1623 - (1565 + 48), false, nil, true, true);
				end
				v24 = (v63 > (0 + 0)) and not v7:IsInRange(1143 - (782 + 356)) and v84();
				if v24 then
					return v24;
				end
				if (v32.Commons.Enabled.Potions and (v6:BuffUp(v25.AscendanceBuff) or v6:BuffUp(v25.FeralSpiritBuff) or ((v68 % (567 - (176 + 91))) <= (78 - 48)) or (not v25.Ascendance:IsAvailable() and not v25.FeralSpirit:IsAvailable() and not v25.DoomWinds:IsAvailable()))) then
					local v148 = v30.PotionSelected();
					if (v148 and v148:IsReady() and IsPotions) then
						v11.CastMacro(4 - 1, nil, nil, v148);
						return "Cast Potion";
					end
				end
				if v24 then
					return v24;
				end
				if v32.Commons.Enabled.Trinkets then
					if (v33:IsReady() and TargetInMeleeRange and IsTrinket1 and not v43 and not v45 and v33:HasUseBuff() and (v6:BuffUp(v25.AscendanceBuff) or v6:BuffUp(v25.FeralSpiritBuff) or v6:BuffUp(v25.DoomWindsBuff) or ((v68 % v41) <= v33:BuffDuration()) or (v58 >= v41) or (not v25.Ascendance:IsAvailable() and not v25.FeralSpirit:IsAvailable() and not v25.DoomWinds:IsAvailable()))) then
						if v12(v33, true) then
							return "trinket1 main 8";
						end
					end
					if (v34:IsReady() and TargetInMeleeRange and IsTrinket2 and not v44 and not v46 and v34:HasUseBuff() and (v6:BuffUp(v25.AscendanceBuff) or v6:BuffUp(v25.FeralSpiritBuff) or v6:BuffUp(v25.DoomWindsBuff) or ((v68 % v42) <= v34:BuffDuration()) or (v58 >= v42) or (not v25.Ascendance:IsAvailable() and not v25.FeralSpirit:IsAvailable() and not v25.DoomWinds:IsAvailable()))) then
						if v12(v34, true) then
							return "trinket2 main 10";
						end
					end
					if (v33:IsReady() and TargetInMeleeRange and IsTrinket1 and not v43 and not v45 and not v33:HasUseBuff()) then
						if v12(v33, true) then
							return "trinket1 main 16";
						end
					end
					if (v34:IsReady() and TargetInMeleeRange and IsTrinket2 and not v44 and not v46 and not v34:HasUseBuff()) then
						if v12(v34, true) then
							return "trinket2 main 18";
						end
					end
				end
				if (v25.BloodFury:IsCastable() and IsRacials and TargetInMeleeRange and (v6:BuffUp(v25.AscendanceBuff) or v6:BuffUp(v25.FeralSpiritBuff) or v6:BuffUp(v25.DoomWindsBuff) or ((v68 % (1212 - (975 + 117))) <= (1890 - (157 + 1718))) or (v58 >= (98 + 22)) or (not v25.Ascendance:IsAvailable() and not v25.FeralSpirit:IsAvailable() and not v25.DoomWinds:IsAvailable()))) then
					if v12(v25.BloodFury, true) then
						return "blood_fury racial";
					end
				end
				if (v25.Berserking:IsCastable() and IsRacials and TargetInMeleeRange and (v6:BuffUp(v25.AscendanceBuff) or v6:BuffUp(v25.FeralSpiritBuff) or v6:BuffUp(v25.DoomWindsBuff) or ((v68 % (638 - 458)) <= (40 - 28)) or (v58 >= (1198 - (697 + 321))) or (not v25.Ascendance:IsAvailable() and not v25.FeralSpirit:IsAvailable() and not v25.DoomWinds:IsAvailable()))) then
					if v12(v25.Berserking, true) then
						return "berserking racial";
					end
				end
				if (v25.Fireblood:IsCastable() and IsRacials and TargetInMeleeRange and (v6:BuffUp(v25.AscendanceBuff) or v6:BuffUp(v25.FeralSpiritBuff) or v6:BuffUp(v25.DoomWindsBuff) or ((v68 % (326 - 206)) <= (16 - 8)) or (v58 >= (276 - 156)) or (not v25.Ascendance:IsAvailable() and not v25.FeralSpirit:IsAvailable() and not v25.DoomWinds:IsAvailable()))) then
					if v12(v25.Fireblood, true) then
						return "fireblood racial";
					end
				end
				if (v25.AncestralCall:IsCastable() and IsRacials and TargetInMeleeRange and (v6:BuffUp(v25.AscendanceBuff) or v6:BuffUp(v25.FeralSpiritBuff) or v6:BuffUp(v25.DoomWindsBuff) or ((v68 % (47 + 73)) <= (28 - 13)) or (v58 >= (321 - 201)) or (not v25.Ascendance:IsAvailable() and not v25.FeralSpirit:IsAvailable() and not v25.DoomWinds:IsAvailable()))) then
					if v12(v25.AncestralCall, true) then
						return "ancestral_call racial";
					end
				end
				if ((v63 < (1229 - (322 + 905))) and not v25.SurgingTotem:IsAvailable()) then
					local v149 = v94();
					if v149 then
						return v149;
					end
				end
				if ((v63 < (613 - (602 + 9))) and v25.SurgingTotem:IsAvailable()) then
					local v150 = v96();
					if v150 then
						return v150;
					end
				end
				if (v13() and (v63 > (1190 - (449 + 740)))) then
					if not FunnelToggle then
						if not v25.SurgingTotem:IsAvailable() then
							local v152 = v98();
							if v152 then
								return v152;
							end
						else
							local v153 = v100();
							if v153 then
								return v153;
							end
						end
					else
						local v151 = v101();
						if v151 then
							return v151;
						end
					end
				end
				if v11.CastAnnotated(v25.Pool, false, "WAIT") then
					return "Wait/Pool Resources";
				end
			end
		end
	end
end
local function v103()
	v11.ResetToggle();
	v32.Enhancement.Display();
	v25.FlameShockDebuff:RegisterAuraTracking();
	v11.ToggleIconFrame:AddButtonCustom("I", 873 - (826 + 46), "Interrupt", "interrupt");
	v11.ToggleIconFrame:AddButtonCustom("D", 949 - (245 + 702), "Dispel", "dispel");
	v11.ToggleIconFrame:AddButtonCustom("S", 9 - 6, "smallCDs", "smallcds");
	v11.ToggleIconFrame:AddButtonCustom("P", 2 + 2, "UseSpender", "usespender");
	v11.ToggleIconFrame:AddButtonCustom("F", 1903 - (260 + 1638), "Funnel", "funnel");
	v30.PostInitialMessage(703 - (382 + 58));
end
v11.SetAPL(843 - 580, v102, v103);
