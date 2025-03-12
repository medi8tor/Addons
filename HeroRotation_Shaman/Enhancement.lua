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
	local v100, v101 = v6:GetTrinketData(v28);
	if ((v72 < (122 - (32 + 85))) and ((v100.ID == (0 + 0)) or (v101.ID == (0 + 0)) or ((v100.SpellID > (957 - (892 + 65))) and not v100.Usable) or ((v101.SpellID > (0 - 0)) and not v101.Usable))) then
		v72 = v72 + (1 - 0);
		v23(8 - 3, function()
			v73();
		end);
		return;
	end
	v33 = v100.Object;
	v34 = v101.Object;
	v35 = v100.Spell;
	v37 = v100.Range;
	v39 = v100.CastTime;
	v36 = v101.Spell;
	v38 = v101.Range;
	v40 = v101.CastTime;
	v41 = v100.Cooldown;
	v42 = v101.Cooldown;
	v43 = v100.Blacklisted;
	v44 = v101.Blacklisted;
	v45 = (v100.ID == v26.AlgetharPuzzleBox:ID()) or (v100.ID == v26.ManicGrieftorch:ID()) or (v100.ID == v26.ElementiumPocketAnvil:ID()) or (v100.ID == v26.BeacontotheBeyond:ID());
	v46 = (v101.ID == v26.AlgetharPuzzleBox:ID()) or (v101.ID == v26.ManicGrieftorch:ID()) or (v101.ID == v26.ElementiumPocketAnvil:ID()) or (v101.ID == v26.BeacontotheBeyond:ID());
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
local function v74(v115)
	local v116 = v6:GetEnemiesInRange(v115);
	local v117 = 3 - 2;
	for v131, v132 in pairs(v116) do
		if ((v132:GUID() ~= v7:GUID()) and (v132:AffectingCombat() or v132:IsDummy())) then
			v117 = v117 + (953 - (802 + 150));
		end
	end
	return v117;
end
local function v75(v118)
	for v133 = 2 - 1, 10 - 4, 1 + 0 do
		local v134, v135 = v6:GetTotemInfo(v133);
		if (v118:Name() == v135) then
			return true;
		end
	end
end
local function v76()
	if (not v25.AlphaWolf:IsAvailable() or v6:BuffDown(v25.FeralSpiritBuff)) then
		return 997 - (915 + 82);
	end
	local v119 = v20(v25.CrashLightning:TimeSinceLastCast(), v25.ChainLightning:TimeSinceLastCast());
	if ((v119 > (22 - 14)) or (v119 > v25.FeralSpirit:TimeSinceLastCast())) then
		return 0 + 0;
	end
	return (9 - 1) - v119;
end
v25.LightningBolt:RegisterDamageFormula(function()
	return v17(1191 - (1069 + 118)) * (2.311 - 1) * ((1 - 0) + (v6:MasteryPct() / (18 + 82))) * ((v25.AmplificationCore:IsAvailable() and v75(v25.SurgingTotem) and (1.03 - 0)) or (1 + 0));
end);
v25.ChainLightning:RegisterDamageFormula(function()
	local v120 = (v25.CrashingStorms:IsAvailable() and (796 - (368 + 423))) or (9 - 6);
	return v17(22 - (10 + 8)) * (0.73025 - 0) * ((443 - (416 + 26)) + (v6:MasteryPct() / (319 - 219))) * ((v25.CrashingStorms:IsAvailable() and (1.4 + 0)) or (1 - 0)) * ((v25.AmplificationCore:IsAvailable() and v75(v25.SurgingTotem) and (439.03 - (145 + 293))) or (431 - (44 + 386))) * v20(v63, v120);
end);
local function v77(v121)
	return v121:DebuffRemains(v25.LightningRodDebuff);
end
local function v78(v122)
	return v122:DebuffRemains(v25.FlameShockDebuff);
end
local function v79(v123)
	return v6:BuffDown(v25.PrimordialWaveBuff);
end
local function v80(v124)
	return v124:DebuffRemains(v25.LashingFlamesDebuff);
end
local function v81(v125)
	return v125:DebuffRefreshable(v25.FlameShockDebuff);
end
local function v82(v126)
	return v126:NPCID() == (206046 - (998 + 488));
end
local function v83(v127)
	return v127:CastSpellID() == (129875 + 278930);
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
local function v87(v128)
	return (v86 and v32.Enhancement_TTD.IgnoreWhenBoss) or v30.Buggedmobs[v7:NPCID()] or (v30.ISSolo() and v32.Enhancement_TTD.IgnoreWhenSolo) or (v128 == (1138 - (116 + 1022))) or ((v68 >= v128) and (v68 < (32377 - 24600)));
end
local function v88(v129)
	return (v129 ~= "Not Used") and ((((v129 == "with Cooldowns") or ((v129 == "small CDs") and v32.Enhancement_CDUSE.smallcdswithCooldowns) or (v129 == "with Cooldowns or AoE") or (v129 == "on Enemycount or Cooldowns") or (v129 == "on Boss or with Cooldowns")) and v14()) or (v129 == "always") or (((v129 == "on Boss only") or (v129 == "on Boss or on Enemycount") or (v129 == "on Boss or with Cooldowns")) and (v86 or v7:IsDummy())) or ((v129 == "with Bloodlust only") and v6:BloodlustUp()) or ((v129 == "small CDs") and Smallcds) or (((v129 == "on AOE") or (v129 == "with Cooldowns or AoE")) and (v63 >= (2 + 0))) or (((v129 == "on Enemycount or Cooldowns") or (v129 == "on Enemycount") or (v129 == "on Boss or on Enemycount")) and (v63 >= v32.Enhancement_CDUSE.Enemycount)));
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
	if (v25.PrimordialWave:IsReady() and v7:IsSpellInRange(v25.PrimordialWave) and IsPrimordialWave) then
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
	if (v25.FeralSpirit:IsCastable() and (v25.ElementalSpirits:IsAvailable()) and IsFeralSpirit and TargetInMeleeRange) then
		if v12(v25.FeralSpirit, true) then
			return "feral_spirit single 2";
		end
	end
	if (v25.Windstrike:IsCastable() and v25.ThorimsInvocation:IsAvailable() and (v53 > (0 + 0)) and (v66 == v25.LightningBolt) and not v25.ElementalSpirits:IsAvailable()) then
		if v12(v25.Windstrike) then
			return "windstrike single 2";
		end
	end
	if (v25.PrimordialWave:IsReady() and v7:IsSpellInRange(v25.PrimordialWave) and IsPrimordialWave and v7:DebuffDown(v25.FlameShockDebuff) and v25.MoltenAssault:IsAvailable()) then
		if v12(v25.PrimordialWave) then
			return "primordial_wave single 4";
		end
	end
	if (v25.LavaLash:IsCastable() and v7:IsSpellInRange(v25.LavaLash) and v25.LashingFlames:IsAvailable() and v7:DebuffDown(v25.LashingFlamesDebuff)) then
		if v12(v25.LavaLash) then
			return "lava_lash single 8";
		end
	end
	if (v25.Stormstrike:IsReady() and v7:IsSpellInRange(v25.Stormstrike) and (v53 < (1 + 1)) and v25.Ascendance:CooldownUp()) then
		if v12(v25.Stormstrike) then
			return "stormstrike single 10";
		end
	end
	if (v25.FeralSpirit:IsCastable() and TargetInMeleeRange and IsFeralSpirit) then
		if v12(v25.FeralSpirit, true) then
			return "feral_spirit single 6";
		end
	end
	if (IsAscendance and TargetInMeleeRange and v25.Ascendance:IsCastable() and v7:DebuffUp(v25.FlameShockDebuff) and (v66 == v25.LightningBolt) and (v63 == (886 - (261 + 624))) and (v53 >= (3 - 1))) then
		if v12(v25.Ascendance) then
			return "ascendance single 14";
		end
	end
	if (v25.TempestAbility:IsReady() and UseSpender and v87(v32.Enhancement_TTD.TempestTTD) and v7:IsInRange(1120 - (1020 + 60)) and ((v53 == v54) or ((v6:BuffStack(v25.TempestBuff) == v57) and ((v31.TempestMaelstrom > (1453 - (630 + 793))) or (v6:BuffStack(v25.AwakeningStormsBuff) == (6 - 4))) and (v53 >= (23 - 18))))) then
		if v12(v25.LightningBolt) then
			return "tempest single 10";
		end
	end
	if (v25.ElementalBlast:IsReady() and UseSpender and v7:IsSpellInRange(v25.ElementalBlast) and (v53 == v54) and v25.ElementalSpirits:IsAvailable() and (v31.FeralSpiritCount >= (3 + 3)) and ((v25.ElementalBlast:ChargesFractional() >= (3.8 - 2)) or v6:BuffUp(v25.AscendanceBuff))) then
		if v12(v25.ElementalBlast) then
			return "elemental_blast single 12";
		end
	end
	if (v25.Windstrike:IsCastable() and v7:IsInRange(1777 - (760 + 987)) and v25.ThorimsInvocation:IsAvailable() and (v53 > (1913 - (1789 + 124))) and (v66 == v25.LightningBolt) and (v25.Windstrike:Charges() == v25.Windstrike:MaxCharges())) then
		if v12(v25.Windstrike) then
			return "windstrike single 20";
		end
	end
	if (v25.DoomWinds:IsReady() and IsDoomWinds and v7:IsInMeleeRange(771 - (745 + 21)) and v25.ElementalSpirits:IsAvailable() and v25.Ascendance:IsAvailable() and (v53 >= (1 + 1))) then
		if v12(v25.DoomWinds, true) then
			return "doom_winds single 14";
		end
	end
	if (v25.Windstrike:IsCastable() and v7:IsInRange(82 - 52) and v25.ThorimsInvocation:IsAvailable() and (v53 > (0 - 0)) and (v66 == v25.LightningBolt)) then
		if v12(v25.Windstrike) then
			return "windstrike single 16";
		end
	end
	if (v25.FlameShock:IsReady() and v7:IsSpellInRange(v25.FlameShock) and v7:DebuffDown(v25.FlameShockDebuff) and not v25.AshenCatalyst:IsAvailable()) then
		if v12(v25.FlameShock) then
			return "flame_shock single 20";
		end
	end
	if (v25.LightningBolt:IsCastable() and UseSpender and v7:IsSpellInRange(v25.LightningBolt) and UseSpender and v7:IsSpellInRange(v25.LightningBolt) and (v53 >= v54) and v6:BuffUp(v25.PrimordialWaveBuff)) then
		if v12(v25.LightningBolt) then
			return "lightning_bolt single 21";
		end
	end
	if (v25.TempestAbility:IsReady() and UseSpender and v87(v32.Enhancement_TTD.TempestTTD) and ((not v25.OverflowingMaelstrom:IsAvailable() and (v53 >= (1 + 4))) or (v53 >= ((8 + 2) - ((1057 - (87 + 968)) * v15(v25.ElementalSpirits:IsAvailable())))))) then
		if v12(v25.LightningBolt) then
			return "tempest single 22";
		end
	end
	if (v25.PrimordialWave:IsReady() and IsPrimordialWave and v7:IsSpellInRange(v25.PrimordialWave) and not v25.DeeplyRootedElements:IsAvailable()) then
		if v12(v25.PrimordialWave) then
			return "primordial_wave single 24";
		end
	end
	if (v25.ElementalBlast:IsReady() and UseSpender and v7:IsSpellInRange(v25.ElementalBlast) and (v53 >= (35 - 27)) and (v31.FeralSpiritCount >= (4 + 0)) and (v6:BuffUp(v25.AscendanceBuff) or (v25.ElementalBlast:ChargesFractional() >= (2.8 - 1)))) then
		if v12(v25.ElementalBlast) then
			return "elemental_blast single 24";
		end
	end
	if (v25.LightningBolt:IsCastable() and UseSpender and v7:IsSpellInRange(v25.LightningBolt) and UseSpender and v7:IsSpellInRange(v25.LightningBolt) and (v53 >= ((1421 - (447 + 966)) + ((5 - 3) * v15(v25.LegacyoftheFrostWitch:IsAvailable()))))) then
		if v12(v25.LightningBolt) then
			return "lightning_bolt single 26";
		end
	end
	if (v25.LightningBolt:IsCastable() and UseSpender and v7:IsSpellInRange(v25.LightningBolt) and UseSpender and v7:IsSpellInRange(v25.LightningBolt) and (v53 >= (1822 - (1703 + 114))) and not v25.LegacyoftheFrostWitch:IsAvailable() and (v25.DeeplyRootedElements:IsAvailable() or not v25.OverflowingMaelstrom:IsAvailable() or not v25.WitchDoctorsAncestry:IsAvailable())) then
		if v12(v25.LightningBolt) then
			return "lightning_bolt single 28";
		end
	end
	if (v25.VoltaicBlazeAbility:IsReady() and v7:IsSpellInRange(v25.VoltaicBlazeAbility) and v25.ElementalSpirits:IsAvailable() and not v25.WitchDoctorsAncestry:IsAvailable()) then
		if v12(v25.VoltaicBlazeAbility) then
			return "voltaic_blaze single 32";
		end
	end
	if (v25.LightningBolt:IsCastable() and UseSpender and v7:IsSpellInRange(v25.LightningBolt) and UseSpender and v7:IsSpellInRange(v25.LightningBolt) and v6:BuffUp(v25.ArcDischargeBuff) and v25.DeeplyRootedElements:IsAvailable()) then
		if v12(v25.LightningBolt) then
			return "lightning_bolt single 34";
		end
	end
	if (v25.LavaLash:IsCastable() and v7:IsSpellInRange(v25.LavaLash) and (v6:BuffUp(v25.HotHandBuff) or (v6:BuffStack(v25.AshenCatalystBuff) == v55))) then
		if v12(v25.LavaLash) then
			return "lava_lash single 36";
		end
	end
	if (v25.Stormstrike:IsReady() and v7:IsSpellInRange(v25.Stormstrike) and (v6:BuffUp(v25.DoomWindsBuff) or (v25.Stormblast:IsAvailable() and v6:BuffUp(v25.StormsurgeBuff) and (v25.Stormstrike:Charges() == v25.Stormstrike:MaxCharges())))) then
		if v12(v25.Stormstrike) then
			return "stormstrike single 30";
		end
	end
	if (v25.LavaLash:IsCastable() and v7:IsSpellInRange(v25.LavaLash) and v25.LashingFlames:IsAvailable() and v6:BuffDown(v25.DoomWindsBuff)) then
		if v12(v25.LavaLash) then
			return "lava_lash single 31";
		end
	end
	if (v25.VoltaicBlazeAbility:IsReady() and v7:IsSpellInRange(v25.VoltaicBlazeAbility) and v25.ElementalSpirits:IsAvailable() and v6:BuffDown(v25.DoomWindsBuff)) then
		if v12(v25.VoltaicBlazeAbility) then
			return "voltaic_blaze single 42";
		end
	end
	if (v25.CrashLightning:IsReady() and v7:IsInMeleeRange(709 - (376 + 325)) and v25.UnrelentingStorms:IsAvailable() and v25.ElementalSpirits:IsAvailable() and not v25.DeeplyRootedElements:IsAvailable()) then
		if v12(v25.CrashLightning, true) then
			return "crash_lightning single 44";
		end
	end
	if (v25.IceStrike:IsReady() and IsIceStrike and v7:IsSpellInRange(v25.IceStrike) and v25.ElementalAssault:IsAvailable() and v25.SwirlingMaelstrom:IsAvailable() and v25.WitchDoctorsAncestry:IsAvailable()) then
		if v12(v25.IceStrike) then
			return "ice_strike single 46";
		end
	end
	if (v25.Stormstrike:IsReady() and v7:IsSpellInRange(v25.Stormstrike)) then
		if v12(v25.Stormstrike, nil, nil, not v7:IsSpellInRange(v25.Stormstrike)) then
			return "stormstrike single 48";
		end
	end
	if (v25.LightningBolt:IsCastable() and UseSpender and v7:IsSpellInRange(v25.LightningBolt) and v7:IsSpellInRange(v25.LightningBolt) and UseSpender and (v53 >= (8 - 3)) and v25.Ascendance:IsAvailable() and not v25.LegacyoftheFrostWitch:IsAvailable()) then
		if v12(v25.LightningBolt) then
			return "lightning_bolt single 50";
		end
	end
	if (v25.CrashLightning:IsReady() and v7:IsInMeleeRange(24 - 16) and (v25.UnrelentingStorms:IsAvailable())) then
		if v12(v25.CrashLightning, true) then
			return "crash_lightning single 52";
		end
	end
	if (v25.VoltaicBlazeAbility:IsReady() and v7:IsSpellInRange(v25.VoltaicBlazeAbility)) then
		if v12(v25.VoltaicBlazeAbility) then
			return "voltaic_blaze single 54";
		end
	end
	if (v25.Sundering:IsReady() and v7:IsInMeleeRange(4 + 7) and IsSundering and not v25.ElementalSpirits:IsAvailable()) then
		if v12(v25.Sundering, true) then
			return "sundering single 56";
		end
	end
	if (v25.FrostShock:IsCastable() and v7:IsSpellInRange(v25.FrostShock) and v6:BuffUp(v25.HailstormBuff) and v6:BuffUp(v25.IceStrikeBuff) and v25.SwirlingMaelstrom:IsAvailable() and v25.Ascendance:IsAvailable()) then
		if v12(v25.FrostShock) then
			return "frost_shock single 52";
		end
	end
	if (v25.ElementalBlast:IsReady() and UseSpender and v7:IsSpellInRange(v25.ElementalBlast) and (v53 >= (10 - 5)) and (v31.FeralSpiritCount >= (18 - (9 + 5))) and v25.DeeplyRootedElements:IsAvailable() and ((v25.ElementalBlast:ChargesFractional() >= (377.8 - (85 + 291))) or ((v31.MoltenWeaponStacks + v31.IcyEdgeStacks) >= (1269 - (243 + 1022)))) and not v25.FlowingSpirits:IsAvailable()) then
		if v12(v25.ElementalBlast) then
			return "elemental_blast single 54";
		end
	end
	if (v25.CrashLightning:IsReady() and v7:IsInMeleeRange(30 - 22) and v25.AlphaWolf:IsAvailable() and v6:BuffUp(v25.FeralSpiritBuff) and (v76() == (0 + 0))) then
		if v12(v25.CrashLightning, true) then
			return "crash_lightning single 58";
		end
	end
	if (v25.FlameShock:IsReady() and v7:IsSpellInRange(v25.FlameShock) and v7:DebuffDown(v25.FlameShockDebuff) and not v25.Tempest:IsAvailable()) then
		if v12(v25.FlameShock) then
			return "flame_shock single 60";
		end
	end
	if (v25.DoomWinds:IsReady() and v7:IsInMeleeRange(1185 - (1123 + 57)) and IsDoomWinds and (v25.ElementalSpirits:IsAvailable())) then
		if v12(v25.DoomWinds, true) then
			return "doom_winds single 68";
		end
	end
	if (v25.LavaLash:IsCastable() and v7:IsSpellInRange(v25.LavaLash) and v25.ElementalAssault:IsAvailable() and v25.Tempest:IsAvailable() and v25.MoltenAssault:IsAvailable() and v25.DeeplyRootedElements:IsAvailable() and v7:DebuffUp(v25.FlameShockDebuff)) then
		if v12(v25.LavaLash) then
			return "lava_lash single 70";
		end
	end
	if (v25.IceStrike:IsReady() and v7:IsSpellInRange(v25.IceStrike) and IsIceStrike and v25.ElementalAssault:IsAvailable() and v25.SwirlingMaelstrom:IsAvailable()) then
		if v12(v25.IceStrike) then
			return "ice_strike single 72";
		end
	end
	if (v25.LightningBolt:IsCastable() and UseSpender and v7:IsSpellInRange(v25.LightningBolt) and UseSpender and v7:IsSpellInRange(v25.LightningBolt) and (v6:BuffUp(v25.ArcDischargeBuff))) then
		if v12(v25.LightningBolt) then
			return "lightning_bolt single 72";
		end
	end
	if (v25.LavaLash:IsCastable() and v7:IsSpellInRange(v25.LavaLash) and v25.ElementalAssault:IsAvailable() and v25.Tempest:IsAvailable() and v25.MoltenAssault:IsAvailable() and v7:DebuffUp(v25.FlameShockDebuff)) then
		if v12(v25.LavaLash) then
			return "lava_lash single 73";
		end
	end
	if (v25.FrostShock:IsCastable() and v7:IsSpellInRange(v25.FrostShock) and v6:BuffUp(v25.HailstormBuff) and v6:BuffUp(v25.IceStrikeBuff) and v25.SwirlingMaelstrom:IsAvailable() and v25.Tempest:IsAvailable()) then
		if v12(v25.FrostShock) then
			return "frost_shock single 74";
		end
	end
	if (v25.FlameShock:IsReady() and v7:IsSpellInRange(v25.FlameShock) and (v7:DebuffDown(v25.FlameShockDebuff))) then
		if v12(v25.FlameShock) then
			return "flame_shock single 76";
		end
	end
	if (v25.LavaLash:IsCastable() and v7:IsSpellInRange(v25.LavaLash) and (v25.LashingFlames:IsAvailable())) then
		if v12(v25.LavaLash) then
			return "lava_lash single 78";
		end
	end
	if (v25.IceStrike:IsReady() and v7:IsSpellInRange(v25.IceStrike) and IsIceStrike and (v6:BuffDown(v25.IceStrikeBuff))) then
		if v12(v25.IceStrike) then
			return "ice_strike single 80";
		end
	end
	if (v25.FrostShock:IsReady() and v7:IsSpellInRange(v25.FrostShock) and (v6:BuffUp(v25.HailstormBuff))) then
		if v12(v25.FrostShock) then
			return "frost_shock single 82";
		end
	end
	if (v25.CrashLightning:IsReady() and v7:IsInMeleeRange(7 + 1) and (v25.ConvergingStorms:IsAvailable())) then
		if v12(v25.CrashLightning, true) then
			return "crash_lightning single 84";
		end
	end
	if (v25.LavaLash:IsReady() and v7:IsSpellInRange(v25.LavaLash)) then
		if v12(v25.LavaLash) then
			return "lava_lash single 86";
		end
	end
	if (v25.IceStrike:IsReady() and v7:IsSpellInRange(v25.IceStrike) and IsIceStrike) then
		if v12(v25.IceStrike) then
			return "ice_strike single 88";
		end
	end
	if (v25.Windstrike:IsCastable() and v7:IsInRange(284 - (163 + 91))) then
		if v12(v25.Windstrike) then
			return "windstrike single 90";
		end
	end
	if (v25.Stormstrike:IsReady() and v7:IsSpellInRange(v25.Stormstrike)) then
		if v12(v25.Stormstrike) then
			return "stormstrike single 92";
		end
	end
	if (v25.Sundering:IsReady() and v7:IsInMeleeRange(1941 - (1869 + 61)) and IsSundering) then
		if v12(v25.Sundering, true) then
			return "sundering single 94";
		end
	end
	if (v25.FrostShock:IsReady() and v7:IsSpellInRange(v25.FrostShock)) then
		if v12(v25.FrostShock) then
			return "frost_shock single 100";
		end
	end
	if (v25.CrashLightning:IsReady() and v7:IsInMeleeRange(3 + 5)) then
		if v12(v25.CrashLightning, true) then
			return "crash_lightning single 102";
		end
	end
	if (v25.FireNova:IsReady() and IsFireNova and (v7:DebuffUp(v25.FlameShockDebuff))) then
		if v12(v25.FireNova) then
			return "fire_nova single 104";
		end
	end
	if (v25.EarthElemental:IsCastable() and TargetInMeleeRange and IsEarthElemental) then
		if v12(v25.EarthElemental, true) then
			return "earth_elemental single 106";
		end
	end
	if (v25.FlameShock:IsReady() and v7:IsSpellInRange(v25.FlameShock)) then
		if v12(v25.FlameShock) then
			return "flame_shock single 108";
		end
	end
end
local function v94()
	if (v25.SurgingTotem:IsReady() and IsSurgingTotem and TargetInMeleeRange) then
		if v12(v25.SurgingTotem) then
			return "surging_totem single_totemic 2";
		end
	end
	if (IsAscendance and TargetInMeleeRange and v25.Ascendance:IsCastable() and (v66 == v25.LightningBolt) and (v75(v25.SurgingTotem, true) > (14 - 10)) and ((v6:BuffStack(v25.TotemicReboundBuff) >= (4 - 1)) or (v53 > (0 + 0)))) then
		if v12(v25.Ascendance, true) then
			return "ascendance single_totemic 4";
		end
	end
	if (v25.DoomWinds:IsReady() and IsDoomWinds and v7:IsInMeleeRange(6 - 1) and not v25.ElementalSpirits:IsAvailable() and v6:BuffUp(v25.LegacyoftheFrostWitchBuff)) then
		if v12(v25.DoomWinds, true) then
			return "doom_winds single_totemic 6";
		end
	end
	if (v25.Sundering:IsReady() and v7:IsInMeleeRange(11 + 0) and IsSundering and v6:BuffUp(v25.AscendanceBuff) and v75(v25.SurgingTotem) and v25.Earthsurge:IsAvailable() and v6:BuffUp(v25.LegacyoftheFrostWitchBuff) and (v6:BuffStack(v25.TotemicReboundBuff) >= (1479 - (1329 + 145))) and (v6:BuffStack(v25.EarthenWeaponBuff) >= (973 - (140 + 831)))) then
		if v12(v25.Sundering, true) then
			return "sundering single_totemic 8";
		end
	end
	if (v25.CrashLightning:IsReady() and v7:IsInMeleeRange(1858 - (1409 + 441)) and v25.UnrelentingStorms:IsAvailable() and v25.AlphaWolf:IsAvailable() and (v76() == (718 - (15 + 703))) and (v6:BuffStack(v25.EarthenWeaponBuff) >= (4 + 4))) then
		if v12(v25.CrashLightning, true) then
			return "crash_lightning single_totemic 10";
		end
	end
	if (v25.Windstrike:IsCastable() and v7:IsInRange(468 - (262 + 176)) and v25.ThorimsInvocation:IsAvailable() and (v53 > (1721 - (345 + 1376))) and (v66 == v25.LightningBolt) and not v25.ElementalSpirits:IsAvailable()) then
		if v12(v25.Windstrike) then
			return "windstrike single_totemic 12";
		end
	end
	if (v25.Sundering:IsReady() and IsSundering and v7:IsInMeleeRange(699 - (198 + 490)) and v6:BuffUp(v25.LegacyoftheFrostWitchBuff) and (v25.Ascendance:CooldownRemains() >= (44 - 34)) and v75(v25.SurgingTotem) and (v6:BuffStack(v25.TotemicReboundBuff) >= (6 - 3)) and v6:BuffDown(v25.AscendanceBuff)) then
		if v12(v25.Sundering, true) then
			return "sundering single_totemic 14";
		end
	end
	if (v25.PrimordialWave:IsReady() and v7:IsSpellInRange(v25.PrimordialWave) and IsPrimordialWave and v7:DebuffDown(v25.FlameShockDebuff) and v25.MoltenAssault:IsAvailable()) then
		if v12(v25.PrimordialWave) then
			return "primordial_wave single_totemic 16";
		end
	end
	if (v25.FeralSpirit:IsCastable() and IsFeralSpirit and TargetInMeleeRange) then
		if v12(v25.FeralSpirit, true) then
			return "feral_spirit single_totemic 18";
		end
	end
	if (v25.ElementalBlast:IsReady() and UseSpender and v7:IsSpellInRange(v25.ElementalBlast) and (v53 == v54) and v25.ElementalSpirits:IsAvailable() and (v31.FeralSpiritCount >= (1212 - (696 + 510))) and ((v25.ElementalBlast:ChargesFractional() >= (1.8 - 0)) or v6:BuffUp(v25.AscendanceBuff))) then
		if v12(v25.ElementalBlast) then
			return "elemental_blast single_totemic 20";
		end
	end
	if (v25.VoltaicBlazeAbility:IsReady() and v7:IsSpellInRange(v25.VoltaicBlazeAbility) and (v6:BuffUp(v25.WhirlingEarthBuff))) then
		if v12(v25.VoltaicBlazeAbility) then
			return "voltaic_blaze single_totemic 22";
		end
	end
	if (v25.CrashLightning:IsReady() and UseSpender and v7:IsInMeleeRange(1270 - (1091 + 171)) and v25.UnrelentingStorms:IsAvailable() and v25.AlphaWolf:IsAvailable() and (v76() == (0 + 0))) then
		if v12(v25.CrashLightning, true) then
			return "crash_lightning single_totemic 24";
		end
	end
	if (v25.FlameShock:IsReady() and v7:IsSpellInRange(v25.FlameShock) and v7:DebuffDown(v25.FlameShockDebuff) and v25.LashingFlames:IsAvailable()) then
		if v12(v25.FlameShock) then
			return "flame_shock single_totemic 26";
		end
	end
	if (v25.LavaLash:IsReady() and v7:IsSpellInRange(v25.LavaLash) and v6:BuffUp(v25.HotHandBuff) and not v25.LegacyoftheFrostWitch:IsAvailable()) then
		if v12(v25.LavaLash) then
			return "lava_lash single_totemic 28";
		end
	end
	if (v25.ElementalBlast:IsReady() and UseSpender and v7:IsSpellInRange(v25.ElementalBlast) and (v53 >= (15 - 10)) and (v25.ElementalBlast:Charges() == v25.ElementalBlast:MaxCharges())) then
		if v12(v25.ElementalBlast) then
			return "elemental_blast single_totemic 30";
		end
	end
	if (v25.LightningBolt:IsCastable() and UseSpender and v7:IsSpellInRange(v25.LightningBolt) and (v53 >= (26 - 18)) and v6:BuffUp(v25.PrimordialWaveBuff) and (v6:BuffDown(v25.SplinteredElementsBuff) or (v68 <= (386 - (123 + 251))))) then
		if v12(v25.LightningBolt) then
			return "lightning_bolt single_totemic 32";
		end
	end
	if (v25.ElementalBlast:IsReady() and UseSpender and v7:IsSpellInRange(v25.ElementalBlast) and (v53 >= (39 - 31)) and ((v31.FeralSpiritCount >= (700 - (208 + 490))) or not v25.ElementalSpirits:IsAvailable())) then
		if v12(v25.ElementalBlast) then
			return "elemental_blast single_totemic 34";
		end
	end
	if (v25.LavaBurst:IsReady() and v7:IsSpellInRange(v25.LavaBurst) and not v25.ThorimsInvocation:IsAvailable() and (v53 >= (1 + 4))) then
		if v12(v25.LavaBurst) then
			return "lava_burst single_totemic 36";
		end
	end
	if (v25.PrimordialWave:IsReady() and IsPrimordialWave and v7:IsSpellInRange(v25.PrimordialWave)) then
		if v12(v25.PrimordialWave) then
			return "primordial_wave single_totemic 38";
		end
	end
	if (v25.ElementalBlast:IsReady() and UseSpender and v7:IsSpellInRange(v25.ElementalBlast) and (v53 >= (3 + 2)) and ((v25.ElementalBlast:ChargesFractional() >= (837.8 - (660 + 176))) or ((v31.MoltenWeaponStacks + v31.IcyEdgeStacks) >= (1 + 3))) and v25.Ascendance:IsAvailable() and ((v31.FeralSpiritCount >= (206 - (14 + 188))) or not v25.ElementalSpirits:IsAvailable())) then
		if v12(v25.ElementalBlast) then
			return "elemental_blast single_totemic 40";
		end
	end
	if (v25.ElementalBlast:IsReady() and UseSpender and v7:IsSpellInRange(v25.ElementalBlast) and v25.Ascendance:IsAvailable() and ((v53 >= (685 - (534 + 141))) or ((v53 >= (3 + 2)) and v6:BuffUp(v25.WhirlingAirBuff) and not v25.LegacyoftheFrostWitch:IsAvailable()))) then
		if v12(v25.ElementalBlast) then
			return "elemental_blast single_totemic 42";
		end
	end
	if (v25.LightningBolt:IsCastable() and UseSpender and v7:IsSpellInRange(v25.LightningBolt) and v25.Ascendance:IsAvailable() and ((v53 >= (9 + 1)) or ((v53 >= (5 + 0)) and v6:BuffUp(v25.WhirlingAirBuff) and not v25.LegacyoftheFrostWitch:IsAvailable()))) then
		if v12(v25.LightningBolt) then
			return "lightning_bolt single_totemic 44";
		end
	end
	if (v25.LavaLash:IsReady() and v7:IsSpellInRange(v25.LavaLash) and v6:BuffUp(v25.HotHandBuff) and v25.MoltenAssault:IsAvailable() and v6:BuffUp(v25.LivelyTotemsBuff)) then
		if v12(v25.LavaLash) then
			return "lava_lash single_totemic 46";
		end
	end
	if (v25.Windstrike:IsCastable() and v7:IsInRange(63 - 33)) then
		if v12(v25.Windstrike) then
			return "windstrike single_totemic 48";
		end
	end
	if (v25.Stormstrike:IsReady() and v7:IsSpellInRange(v25.Stormstrike)) then
		if v12(v25.Stormstrike) then
			return "stormstrike single_totemic 50";
		end
	end
	if (v25.LavaLash:IsReady() and v7:IsSpellInRange(v25.LavaLash) and (v25.MoltenAssault:IsAvailable())) then
		if v12(v25.LavaLash) then
			return "lava_lash single_totemic 52";
		end
	end
	if (v25.CrashLightning:IsReady() and v7:IsInMeleeRange(12 - 4) and (v25.UnrelentingStorms:IsAvailable())) then
		if v12(v25.CrashLightning, true) then
			return "crash_lightning single_totemic 54";
		end
	end
	if (v25.LightningBolt:IsCastable() and UseSpender and v7:IsSpellInRange(v25.LightningBolt) and (v53 >= (14 - 9)) and v25.Ascendance:IsAvailable()) then
		if v12(v25.LightningBolt) then
			return "lightning_bolt single_totemic 56";
		end
	end
	if (v25.IceStrike:IsReady() and v7:IsSpellInRange(v25.IceStrike) and (v6:BuffDown(v25.IceStrikeBuff))) then
		if v12(v25.IceStrike) then
			return "ice_strike single_totemic 58";
		end
	end
	if (v25.FrostShock:IsReady() and v7:IsSpellInRange(v25.FrostShock) and v6:BuffUp(v25.HailstormBuff) and v6:BuffUp(v25.LivelyTotemsBuff)) then
		if v12(v25.FrostShock) then
			return "frost_shock single_totemic 60";
		end
	end
	if (v25.LavaLash:IsReady() and v7:IsSpellInRange(v25.LavaLash)) then
		if v12(v25.LavaLash) then
			return "lava_lash single_totemic 62";
		end
	end
	if (v25.ElementalBlast:IsReady() and UseSpender and v7:IsSpellInRange(v25.ElementalBlast) and (v53 >= (3 + 2)) and (v31.FeralSpiritCount >= (3 + 1)) and v25.DeeplyRootedElements:IsAvailable() and ((v25.ElementalBlast:ChargesFractional() >= (397.8 - (115 + 281))) or ((v31.IcyEdgeStacks + v31.MoltenWeaponStacks) >= (9 - 5)))) then
		if v12(v25.ElementalBlast) then
			return "elemental_blast single_totemic 64";
		end
	end
	if (v25.DoomWinds:IsReady() and IsDoomWinds and v7:IsInMeleeRange(5 + 0) and (v25.ElementalSpirits:IsAvailable())) then
		if v12(v25.DoomWinds, true) then
			return "doom_winds single_totemic 66";
		end
	end
	if (v25.FlameShock:IsReady() and v7:IsSpellInRange(v25.FlameShock) and v7:DebuffDown(v25.FlameShockDebuff) and not v25.VoltaicBlaze:IsAvailable()) then
		if v12(v25.FlameShock) then
			return "flame_shock single_totemic 68";
		end
	end
	if (v25.FrostShock:IsReady() and v7:IsSpellInRange(v25.FrostShock) and (v6:BuffUp(v25.HailstormBuff))) then
		if v12(v25.FrostShock) then
			return "frost_shock single_totemic 70";
		end
	end
	if (v25.CrashLightning:IsReady() and v7:IsInMeleeRange(19 - 11) and (v25.ConvergingStorms:IsAvailable())) then
		if v12(v25.CrashLightning, true) then
			return "crash_lightning single_totemic 72";
		end
	end
	if (v25.FrostShock:IsReady() and v7:IsSpellInRange(v25.FrostShock)) then
		if v12(v25.FrostShock) then
			return "frost_shock single_totemic 74";
		end
	end
	if (v25.CrashLightning:IsReady() and v7:IsInMeleeRange(29 - 21)) then
		if v12(v25.CrashLightning, true) then
			return "crash_lightning single_totemic 76";
		end
	end
	if (v25.FireNova:IsReady() and IsFireNova and (v7:DebuffUp(v25.FlameShockDebuff))) then
		if v12(v25.FireNova) then
			return "fire_nova single_totemic 78";
		end
	end
	if (v25.EarthElemental:IsCastable() and TargetInMeleeRange and IsEarthElemental) then
		if v12(v25.EarthElemental, true) then
			return "earth_elemental single_totemic 80";
		end
	end
	if (v25.FlameShock:IsReady() and v7:IsSpellInRange(v25.FlameShock) and not v25.VoltaicBlaze:IsAvailable()) then
		if v12(v25.FlameShock) then
			return "flame_shock single_totemic 82";
		end
	end
end
local function v95()
	if (v25.FeralSpirit:IsCastable() and TargetInMeleeRange and IsFeralSpirit and (v25.ElementalSpirits:IsAvailable() or v25.AlphaWolf:IsAvailable())) then
		if v12(v25.FeralSpirit, true) then
			return "feral_spirit aoe 2";
		end
	end
	if (IsAscendance and TargetInMeleeRange and v25.Ascendance:IsCastable() and (v25.FlameShockDebuff:AuraActiveCount() > (867 - (550 + 317))) and (v66 == v25.ChainLightning)) then
		if v12(v25.Ascendance, true) then
			return "ascendance aoe 4";
		end
	end
	if (v25.TempestAbility:IsReady() and v7:IsSpellInRange(v25.TempestAbility) and v87(v32.Enhancement_TTD.TempestTTD) and v7:IsInRange(57 - 17) and ((v6:BuffDown(v25.ArcDischargeBuff) and (((v53 == v54) and not v25.RagingMaelstrom:IsAvailable()) or (v53 >= (10 - 2)))) or ((v53 >= (13 - 8)) and ((v31.TempestMaelstrom > (315 - (134 + 151))) or (v6:BuffStack(v25.AwakeningStormsBuff) == (1667 - (970 + 695))))))) then
		if v12(v25.TempestAbility) then
			return "tempest aoe 6 (forced MT)";
		end
	end
	if (v25.Windstrike:IsCastable() and v7:IsInRange(57 - 27) and v25.ThorimsInvocation:IsAvailable() and (v53 > (1990 - (582 + 1408))) and (v66 == v25.ChainLightning)) then
		if v12(v25.Windstrike) then
			return "windstrike aoe 4";
		end
	end
	if (v25.CrashLightning:IsReady() and v7:IsInMeleeRange(27 - 19) and v25.CrashingStorms:IsAvailable() and ((v25.UnrulyWinds:IsAvailable() and (v63 >= (12 - 2))) or (v63 >= (56 - 41)))) then
		if v12(v25.CrashLightning, true) then
			return "crash_lightning aoe 6";
		end
	end
	if (v25.LightningBolt:IsCastable() and UseSpender and v7:IsSpellInRange(v25.LightningBolt) and (not v25.Tempest:IsAvailable() or ((v31.TempestMaelstrom <= (1834 - (1195 + 629))) and (v6:BuffStack(v25.AwakeningStormsBuff) <= (1 - 0)))) and ((v25.FlameShockDebuff:AuraActiveCount() == v63) or (v25.FlameShockDebuff:AuraActiveCount() >= (247 - (187 + 54)))) and v6:BuffUp(v25.PrimordialWaveBuff) and (v53 == v54) and (v6:BuffDown(v25.SplinteredElementsBuff) or (v67 <= (792 - (162 + 618))))) then
		if v12(v25.LightningBolt) then
			return "lightning_bolt aoe 8";
		end
	end
	if (v25.VoltaicBlazeAbility:IsReady() and v7:IsSpellInRange(v25.VoltaicBlazeAbility) and v7:IsSpellInRange(v25.VoltaicBlazeAbility) and v7:IsSpellInRange(v25.VoltaicBlazeAbility) and v7:IsSpellInRange(v25.VoltaicBlazeAbility) and (v53 <= (6 + 2))) then
		if v12(v25.VoltaicBlazeAbility) then
			return "voltaic_blaze aoe 14";
		end
	end
	if (v25.LavaLash:IsReady() and v7:IsSpellInRange(v25.LavaLash) and v25.MoltenAssault:IsAvailable() and (v25.PrimordialWave:IsAvailable() or v25.FireNova:IsAvailable()) and v7:DebuffUp(v25.FlameShockDebuff) and (v25.FlameShockDebuff:AuraActiveCount() < v63) and (v25.FlameShockDebuff:AuraActiveCount() < (4 + 2))) then
		if v12(v25.LavaLash) then
			return "lava_lash aoe 10";
		end
	end
	if (v25.PrimordialWave:IsReady() and IsPrimordialWave and (v6:BuffDown(v25.PrimordialWaveBuff))) then
		if v30.CastTargetIf(v25.PrimordialWave, v62, "min", v78, v79, 85 - 45) then
			return "primordial_wave aoe 12";
		end
	end
	if (v25.ChainLightning:IsReady() and UseSpender and v7:IsSpellInRange(v25.ChainLightning) and v6:BuffUp(v25.ArcDischargeBuff) and (v53 >= (8 - 3))) then
		if v30.CastTargetIf(v25.ChainLightning, v62, "min", v77, nil, not v7:IsSpellInRange(v25.ChainLightning)) then
			return "chain_lightning aoe 20";
		end
	end
	if (v25.ElementalBlast:IsReady() and UseSpender and v7:IsSpellInRange(v25.ElementalBlast) and (not v25.ElementalSpirits:IsAvailable() or (v25.ElementalSpirits:IsAvailable() and ((v25.ElementalBlast:Charges() == v65) or (v31.FeralSpiritCount >= (1 + 1))))) and (v53 == v54) and (not v25.CrashingStorms:IsAvailable() or (v63 <= (1639 - (1373 + 263))))) then
		if v30.CastTargetIf(v25.ElementalBlast, v62, "min", v77, not v7:IsSpellInRange(v25.ElementalBlast)) then
			return "elemental_blast aoe 22";
		end
	end
	if (v25.ChainLightning:IsReady() and UseSpender and v7:IsSpellInRange(v25.ChainLightning) and (((v53 == v54) and not v25.RagingMaelstrom:IsAvailable()) or (v53 >= (1007 - (451 + 549))))) then
		if v12(v25.ChainLightning) then
			return "chain_lightning aoe 24";
		end
	end
	if (v25.FeralSpirit:IsCastable() and TargetInMeleeRange and IsFeralSpirit) then
		if v12(v25.FeralSpirit, true) then
			return "feral_spirit aoe 26";
		end
	end
	if (v25.DoomWinds:IsCastable() and v7:IsInMeleeRange(2 + 3) and IsDoomWinds and (v66 == v25.ChainLightning) and (v6:BuffUp(v25.LegacyoftheFrostWitchBuff) or not v25.LegacyoftheFrostWitch:IsAvailable())) then
		if v12(v25.DoomWinds, true) then
			return "doom_winds aoe 28";
		end
	end
	if (v25.CrashLightning:IsReady() and v7:IsInMeleeRange(11 - 3) and ((v6:BuffUp(v25.DoomWindsBuff) and (v63 >= (6 - 2))) or v6:BuffDown(v25.CrashLightningBuff) or (v25.AlphaWolf:IsAvailable() and v6:BuffUp(v25.FeralSpiritBuff) and (v76() == (1384 - (746 + 638)))))) then
		if v12(v25.CrashLightning, true) then
			return "crash_lightning aoe 30";
		end
	end
	if (v25.Sundering:IsReady() and v7:IsInMeleeRange(5 + 6) and IsSundering and (v6:BuffUp(v25.DoomWindsBuff) or v25.Earthsurge:IsAvailable())) then
		if v12(v25.Sundering, true) then
			return "sundering aoe 32";
		end
	end
	if (v25.FireNova:IsReady() and IsFireNova and ((v25.FlameShockDebuff:AuraActiveCount() == (8 - 2)) or ((v25.FlameShockDebuff:AuraActiveCount() >= (345 - (218 + 123))) and (v25.FlameShockDebuff:AuraActiveCount() >= v63)))) then
		if v12(v25.FireNova) then
			return "fire_nova aoe 34";
		end
	end
	if (v25.Stormstrike:IsReady() and v7:IsSpellInRange(v25.Stormstrike) and v25.Stormblast:IsAvailable() and v25.Stormflurry:IsAvailable()) then
		if v12(v25.Stormstrike) then
			return "stormstrike aoe 36";
		end
	end
	if (v25.VoltaicBlazeAbility:IsReady() and v7:IsSpellInRange(v25.VoltaicBlazeAbility) and v7:IsSpellInRange(v25.VoltaicBlazeAbility) and v7:IsSpellInRange(v25.VoltaicBlazeAbility)) then
		if v12(v25.VoltaicBlazeAbility) then
			return "voltaic_blaze aoe 38";
		end
	end
	if (v25.LavaLash:IsReady() and v7:IsSpellInRange(v25.LavaLash) and (v25.LashingFlames:IsAvailable())) then
		if v30.CastTargetIf(v25.LavaLash, v62, "min", v80, nil, not v7:IsSpellInRange(v25.LavaLash)) then
			return "lava_lash aoe 40";
		end
	end
	if (v25.LavaLash:IsReady() and v7:IsSpellInRange(v25.LavaLash) and v25.MoltenAssault:IsAvailable() and v7:DebuffUp(v25.FlameShockDebuff)) then
		if v12(v25.LavaLash, nil, nil, not v7:IsSpellInRange(v25.LavaLash)) then
			return "lava_lash aoe 42";
		end
	end
	if (v25.IceStrike:IsReady() and v7:IsSpellInRange(v25.IceStrike) and IsIceStrike and v25.Hailstorm:IsAvailable() and v6:BuffDown(v25.IceStrikeBuff)) then
		if v12(v25.IceStrike, nil, nil, not v7:IsSpellInRange(v25.IceStrike)) then
			return "ice_strike aoe 44";
		end
	end
	if (v25.FrostShock:IsReady() and v7:IsSpellInRange(v25.FrostShock) and v25.Hailstorm:IsAvailable() and v6:BuffUp(v25.HailstormBuff)) then
		if v12(v25.FrostShock) then
			return "frost_shock aoe 46";
		end
	end
	if (v25.Sundering:IsReady() and v7:IsInMeleeRange(1592 - (1535 + 46)) and IsSundering) then
		if v12(v25.Sundering, true) then
			return "sundering aoe 48";
		end
	end
	if (v25.FlameShock:IsReady() and v7:IsSpellInRange(v25.FlameShock) and v25.MoltenAssault:IsAvailable() and v7:DebuffDown(v25.FlameShockDebuff)) then
		if v12(v25.FlameShock) then
			return "flame_shock aoe 50";
		end
	end
	if (v25.FlameShock:IsReady() and v7:IsSpellInRange(v25.FlameShock) and (v25.FireNova:IsAvailable() or v25.PrimordialWave:IsAvailable()) and (v25.FlameShockDebuff:AuraActiveCount() < v63) and (v25.FlameShockDebuff:AuraActiveCount() < (6 + 0))) then
		if v30.CastCycle(v25.FlameShock, v62, v81, not v7:IsSpellInRange(v25.FlameShock)) then
			return "flame_shock aoe 52";
		end
	end
	if (v25.FireNova:IsReady() and IsFireNova and (v25.FlameShockDebuff:AuraActiveCount() >= (1 + 2))) then
		if v12(v25.FireNova) then
			return "fire_nova aoe 54";
		end
	end
	if (v25.Stormstrike:IsReady() and v7:IsSpellInRange(v25.Stormstrike) and v7:IsSpellInRange(v25.Stormstrike) and v6:BuffUp(v25.CrashLightningBuff) and (v25.DeeplyRootedElements:IsAvailable() or (v6:BuffStack(v25.ConvergingStormsBuff) == v56))) then
		if v12(v25.Stormstrike) then
			return "stormstrike aoe 56";
		end
	end
	if (v25.CrashLightning:IsReady() and v7:IsInMeleeRange(568 - (306 + 254)) and v25.CrashingStorms:IsAvailable() and v6:BuffUp(v25.CLCrashLightningBuff) and (v63 >= (1 + 3))) then
		if v12(v25.CrashLightning, true) then
			return "crash_lightning aoe 58";
		end
	end
	if (v25.Windstrike:IsReady() and v7:IsInRange(58 - 28)) then
		if v12(v25.Windstrike) then
			return "windstrike aoe 60";
		end
	end
	if (v25.Stormstrike:IsReady() and v7:IsSpellInRange(v25.Stormstrike) and v7:IsSpellInRange(v25.Stormstrike)) then
		if v12(v25.Stormstrike) then
			return "stormstrike aoe 62";
		end
	end
	if (v25.IceStrike:IsReady() and IsIceStrike and v7:IsSpellInRange(v25.IceStrike)) then
		if v12(v25.IceStrike, nil, nil, not v7:IsSpellInRange(v25.IceStrike)) then
			return "ice_strike aoe 64";
		end
	end
	if (v25.LavaLash:IsReady() and v7:IsSpellInRange(v25.LavaLash)) then
		if v12(v25.LavaLash, nil, nil, not v7:IsSpellInRange(v25.LavaLash)) then
			return "lava_lash aoe 66";
		end
	end
	if (v25.CrashLightning:IsReady() and v7:IsInMeleeRange(1475 - (899 + 568))) then
		if v12(v25.CrashLightning, true) then
			return "crash_lightning aoe 68";
		end
	end
	if (v25.FireNova:IsReady() and IsFireNova and (v25.FlameShockDebuff:AuraActiveCount() >= (2 + 0))) then
		if v12(v25.FireNova) then
			return "fire_nova aoe 70";
		end
	end
	if (v25.ElementalBlast:IsReady() and UseSpender and v7:IsSpellInRange(v25.ElementalBlast) and (not v25.ElementalSpirits:IsAvailable() or (v25.ElementalSpirits:IsAvailable() and ((v25.ElementalBlast:Charges() == v65) or (v31.FeralSpiritCount >= (4 - 2))))) and (v53 >= (608 - (268 + 335))) and (not v25.CrashingStorms:IsAvailable() or (v63 <= (293 - (60 + 230))))) then
		if v30.CastTargetIf(v25.ElementalBlast, v62, "min", v77, nil, not v7:IsSpellInRange(v25.ElementalBlast)) then
			return "elemental_blast aoe 72";
		end
	end
	if (v25.ChainLightning:IsReady() and UseSpender and v7:IsSpellInRange(v25.ChainLightning) and (v53 >= (577 - (426 + 146)))) then
		if v12(v25.ChainLightning) then
			return "chain_lightning aoe 14";
		end
		if v30.CastTargetIf(v25.ChainLightning, v62, "min", v77, not v7:IsSpellInRange(v25.ChainLightning)) then
			return "chain_lightning aoe 74";
		end
	end
	if (v25.FlameShock:IsReady() and v7:IsSpellInRange(v25.FlameShock) and (v7:DebuffDown(v25.FlameShockDebuff))) then
		if v12(v25.FlameShock) then
			return "flame_shock aoe 76";
		end
	end
	if (v25.FrostShock:IsReady() and v7:IsSpellInRange(v25.FrostShock) and not v25.Hailstorm:IsAvailable()) then
		if v12(v25.FrostShock) then
			return "frost_shock aoe 78";
		end
	end
end
local function v96()
	if (v25.SurgingTotem:IsReady() and IsSurgingTotem and TargetInMeleeRange) then
		if v12(v25.SurgingTotem) then
			return "surging_totem aoe_totemic 2";
		end
	end
	if (IsAscendance and TargetInMeleeRange and v25.Ascendance:IsCastable() and (v66 == v25.ChainLightning)) then
		if v12(v25.Ascendance, true) then
			return "ascendance aoe_totemic 4";
		end
	end
	if (v25.Sundering:IsReady() and v7:IsInMeleeRange(2 + 9) and IsSundering and v6:BuffUp(v25.AscendanceBuff) and v75(v25.SurgingTotem) and v25.Earthsurge:IsAvailable() and (v6:BuffUp(v25.LegacyoftheFrostWitchBuff) or not v25.LegacyoftheFrostWitch:IsAvailable())) then
		if v12(v25.Sundering, true) then
			return "sundering aoe_totemic 6";
		end
	end
	if (v25.CrashLightning:IsReady() and v7:IsInMeleeRange(1464 - (282 + 1174)) and v25.CrashingStorms:IsAvailable() and (v63 >= ((826 - (569 + 242)) - ((14 - 9) * v15(v25.UnrulyWinds:IsAvailable()))))) then
		if v12(v25.CrashLightning, true) then
			return "crash_lightning aoe_totemic 8";
		end
	end
	if (v25.LightningBolt:IsCastable() and UseSpender and v7:IsSpellInRange(v25.LightningBolt) and ((v25.FlameShockDebuff:AuraActiveCount() == v63) or (v25.FlameShockDebuff:AuraActiveCount() >= (1 + 5))) and v6:BuffUp(v25.PrimordialWaveBuff) and (v53 == v54) and (v6:BuffDown(v25.SplinteredElementsBuff) or (v68 <= (1036 - (706 + 318))))) then
		if v12(v25.LightningBolt) then
			return "lightning_bolt aoe_totemic 10";
		end
	end
	if (v25.DoomWinds:IsCastable() and v7:IsInMeleeRange(1256 - (721 + 530)) and IsDoomWinds and not v25.ElementalSpirits:IsAvailable() and (v6:BuffUp(v25.LegacyoftheFrostWitchBuff) or not v25.LegacyoftheFrostWitch:IsAvailable())) then
		if v12(v25.DoomWinds, true) then
			return "doom_winds aoe_totemic 12";
		end
	end
	if (v25.LavaLash:IsReady() and v7:IsSpellInRange(v25.LavaLash) and v25.MoltenAssault:IsAvailable() and (v25.PrimordialWave:IsAvailable() or v25.FireNova:IsAvailable()) and v7:DebuffUp(v25.FlameShockDebuff) and (v25.FlameShockDebuff:AuraActiveCount() < v63) and (v25.FlameShockDebuff:AuraActiveCount() < (1277 - (945 + 326)))) then
		if v12(v25.LavaLash) then
			return "lava_lash aoe_totemic 14";
		end
	end
	if (v25.PrimordialWave:IsReady() and (v6:BuffDown(v25.PrimordialWaveBuff))) then
		if v30.CastTargetIf(v25.PrimordialWave, v62, "min", v78, v79, nil, not v7:IsSpellInRange(v25.PrimordialWave), v32.CommonsDS.DisplayStyle.PrimordialWave) then
			return "primordial_wave aoe_totemic 16";
		end
	end
	if (v25.ElementalBlast:IsReady() and UseSpender and v7:IsSpellInRange(v25.ElementalBlast) and (not v25.ElementalSpirits:IsAvailable() or (v25.ElementalSpirits:IsAvailable() and ((v25.ElementalBlast:Charges() == v25.ElementalBlast:MaxCharges()) or (v31.FeralSpiritCount >= (4 - 2))))) and (v53 == v54) and (not v25.CrashingStorms:IsAvailable() or (v63 <= (3 + 0)))) then
		if v12(v25.ElementalBlast) then
			return "elemental_blast aoe_totemic 18";
		end
	end
	if (v25.ChainLightning:IsReady() and (v53 >= (710 - (271 + 429)))) then
		if v12(v25.ChainLightning) then
			return "chain_lightning aoe_totemic 20";
		end
	end
	if (v25.FeralSpirit:IsCastable() and TargetInMeleeRange and IsFeralSpirit) then
		if v12(v25.FeralSpirit, true) then
			return "feral_spirit aoe_totemic 22";
		end
	end
	if (v25.DoomWinds:IsCastable() and v7:IsInMeleeRange(5 + 0) and IsDoomWinds and (v6:BuffUp(v25.LegacyoftheFrostWitchBuff) or not v25.LegacyoftheFrostWitch:IsAvailable())) then
		if v12(v25.DoomWinds, true) then
			return "doom_winds aoe_totemic 24";
		end
	end
	if (v25.CrashLightning:IsReady() and v7:IsInMeleeRange(1508 - (1408 + 92)) and (v6:BuffUp(v25.DoomWindsBuff) or v6:BuffDown(v25.CrashLightningBuff) or (v25.AlphaWolf:IsAvailable() and v6:BuffUp(v25.FeralSpiritBuff) and (v76() == (1086 - (461 + 625)))))) then
		if v12(v25.CrashLightning, true) then
			return "crash_lightning aoe_totemic 26";
		end
	end
	if (v25.Sundering:IsReady() and v7:IsInMeleeRange(1299 - (993 + 295)) and IsSundering and (v6:BuffUp(v25.DoomWindsBuff) or (v25.Earthsurge:IsAvailable() and (v6:BuffUp(v25.LegacyoftheFrostWitchBuff) or not v25.LegacyoftheFrostWitch:IsAvailable()) and v75(v25.SurgingTotem)))) then
		if v12(v25.Sundering, true) then
			return "sundering aoe_totemic 28";
		end
	end
	if (v25.FireNova:IsReady() and IsFireNova and ((v25.FlameShockDebuff:AuraActiveCount() == (1 + 5)) or ((v25.FlameShockDebuff:AuraActiveCount() >= (1175 - (418 + 753))) and (v25.FlameShockDebuff:AuraActiveCount() >= v63)))) then
		if v12(v25.FireNova) then
			return "fire_nova aoe_totemic 30";
		end
	end
	if v25.VoltaicBlazeAbility:IsReady() then
		if v12(v25.VoltaicBlazeAbility, nil, nil, not v7:IsSpellInRange(v25.VoltaicBlazeAbility)) then
			return "voltaic_blaze aoe_totemic 32";
		end
	end
	if (v25.LavaLash:IsReady() and v7:IsSpellInRange(v25.LavaLash) and (v25.LashingFlames:IsAvailable())) then
		if v30.CastTargetIf(v25.LavaLash, v62, "min", v80, nil, not v7:IsSpellInRange(v25.LavaLash)) then
			return "lava_lash aoe_totemic 34";
		end
	end
	if (v25.LavaLash:IsReady() and v7:IsSpellInRange(v25.LavaLash) and v25.MoltenAssault:IsAvailable() and v7:DebuffUp(v25.FlameShockDebuff)) then
		if v12(v25.LavaLash) then
			return "lava_lash aoe_totemic 36";
		end
	end
	if (v25.IceStrike:IsReady() and v7:IsSpellInRange(v25.IceStrike) and IsIceStrike and v25.Hailstorm:IsAvailable() and v6:BuffDown(v25.IceStrikeBuff)) then
		if v12(v25.IceStrike) then
			return "ice_strike aoe_totemic 38";
		end
	end
	if (v25.FrostShock:IsReady() and v7:IsSpellInRange(v25.FrostShock) and v25.Hailstorm:IsAvailable() and v6:BuffUp(v25.HailstormBuff)) then
		if v12(v25.FrostShock) then
			return "frost_shock aoe_totemic 40";
		end
	end
	if (v25.Sundering:IsReady() and v7:IsInMeleeRange(5 + 6) and IsSundering and (v6:BuffUp(v25.LegacyoftheFrostWitchBuff) or not v25.LegacyoftheFrostWitch:IsAvailable()) and v75(v25.SurgingTotem)) then
		if v12(v25.Sundering, true) then
			return "sundering aoe_totemic 42";
		end
	end
	if (v25.FlameShock:IsReady() and v7:IsSpellInRange(v25.FlameShock) and v25.MoltenAssault:IsAvailable() and v7:DebuffDown(v25.FlameShockDebuff)) then
		if v12(v25.FlameShock) then
			return "flame_shock aoe_totemic 44";
		end
	end
	if (v25.FlameShock:IsReady() and v7:IsSpellInRange(v25.FlameShock) and (v25.FireNova:IsAvailable() or v25.PrimordialWave:IsAvailable()) and (v25.FlameShockDebuff:AuraActiveCount() < v63) and (v25.FlameShockDebuff:AuraActiveCount() < (1 + 5))) then
		if v30.CastCycle(v25.FlameShock, v62, v81, not v7:IsSpellInRange(v25.FlameShock)) then
			return "flame_shock aoe_totemic 46";
		end
	end
	if (v25.FireNova:IsReady() and IsFireNova and (v25.FlameShockDebuff:AuraActiveCount() >= (1 + 2))) then
		if v12(v25.FireNova) then
			return "fire_nova aoe_totemic 48";
		end
	end
	if (v25.Stormstrike:IsReady() and v7:IsSpellInRange(v25.Stormstrike) and v6:BuffUp(v25.CrashLightningBuff) and (v25.DeeplyRootedElements:IsAvailable() or (v6:BuffStack(v25.ConvergingStormsBuff) == v56))) then
		if v12(v25.Stormstrike) then
			return "stormstrike aoe_totemic 50";
		end
	end
	if (v25.CrashLightning:IsReady() and v7:IsInMeleeRange(3 + 5) and v25.CrashingStorms:IsAvailable() and v6:BuffUp(v25.CLCrashLightningBuff) and (v63 >= (533 - (406 + 123)))) then
		if v12(v25.CrashLightning, true) then
			return "crash_lightning aoe_totemic 52";
		end
	end
	if (v25.Windstrike:IsCastable() and v7:IsInRange(1799 - (1749 + 20))) then
		if v12(v25.Windstrike) then
			return "windstrike aoe_totemic 54";
		end
	end
	if (v25.Stormstrike:IsReady() and v7:IsSpellInRange(v25.Stormstrike)) then
		if v12(v25.Stormstrike) then
			return "stormstrike aoe_totemic 56";
		end
	end
	if (v25.IceStrike:IsReady() and v7:IsSpellInRange(v25.IceStrike) and IsIceStrike) then
		if v12(v25.IceStrike) then
			return "ice_strike aoe_totemic 58";
		end
	end
	if (v25.LavaLash:IsReady() and v7:IsSpellInRange(v25.LavaLash)) then
		if v12(v25.LavaLash) then
			return "lava_lash aoe_totemic 60";
		end
	end
	if (v25.CrashLightning:IsReady() and v7:IsInMeleeRange(2 + 6)) then
		if v12(v25.CrashLightning, true) then
			return "crash_lightning aoe_totemic 62";
		end
	end
	if (v25.FireNova:IsReady() and IsFireNova and (v25.FlameShockDebuff:AuraActiveCount() >= (1324 - (1249 + 73)))) then
		if v12(v25.FireNova) then
			return "fire_nova aoe_totemic 64";
		end
	end
	if (v25.ElementalBlast:IsReady() and UseSpender and v7:IsSpellInRange(v25.ElementalBlast) and (not v25.ElementalSpirits:IsAvailable() or (v25.ElementalSpirits:IsAvailable() and ((v25.ElementalBlast:Charges() == v65) or (v31.FeralSpiritCount >= (1 + 1))))) and (v53 >= (1150 - (466 + 679))) and (not v25.CrashingStorms:IsAvailable() or (v63 <= (6 - 3)))) then
		if v30.CastTargetIf(v25.ElementalBlast, v62, "min", v77, nil, not v7:IsSpellInRange(v25.ElementalBlast)) then
			return "elemental_blast aoe_totemic 66";
		end
	end
	if (v25.ChainLightning:IsReady() and v7:IsSpellInRange(v25.ChainLightning) and (v53 >= (14 - 9))) then
		if v12(v25.ChainLightning) then
			return "chain_lightning aoe_totemic 68";
		end
	end
	if (v25.FlameShock:IsReady() and v7:IsSpellInRange(v25.FlameShock) and (v7:DebuffDown(v25.FlameShockDebuff))) then
		if v12(v25.FlameShock) then
			return "flame_shock aoe_totemic 70";
		end
	end
end
local function v97()
	if (v25.FeralSpirit:IsCastable() and TargetInMeleeRange and IsFeralSpirit and (v25.ElementalSpirits:IsAvailable())) then
		if v12(v25.FeralSpirit, true) then
			return "feral_spirit funnel 2";
		end
	end
	if (v25.SurgingTotem:IsReady() and IsSurgingTotem and TargetInMeleeRange) then
		if v12(v25.SurgingTotem) then
			return "surging_totem funnel 4";
		end
	end
	if (IsAscendance and TargetInMeleeRange and v25.Ascendance:IsCastable()) then
		if v12(v25.Ascendance, true) then
			return "ascendance funnel 6";
		end
	end
	if (v25.Windstrike:IsCastable() and v7:IsInRange(1930 - (106 + 1794)) and ((v25.ThorimsInvocation:IsAvailable() and (v53 > (0 + 0))) or (v6:BuffStack(v25.ConvergingStormsBuff) == v56))) then
		if v12(v25.Windstrike) then
			return "windstrike funnel 8";
		end
	end
	if (v25.TempestAbility:IsReady() and UseSpender and v87(v32.Enhancement_TTD.TempestTTD) and ((v53 == v54) or ((v53 >= (2 + 3)) and ((v31.TempestMaelstrom > (88 - 58)) or (v6:BuffStack(v25.AwakeningStormsBuff) == (5 - 3)))))) then
		if v12(v25.TempestAbility) then
			return "tempest funnel 10";
		end
	end
	if (v25.LightningBolt:IsCastable() and UseSpender and v7:IsSpellInRange(v25.LightningBolt) and ((v25.FlameShockDebuff:AuraActiveCount() >= v63) or (v25.FlameShockDebuff:AuraActiveCount() >= (120 - (4 + 110)))) and v6:BuffUp(v25.PrimordialWaveBuff) and (v53 == v54) and (v6:BuffDown(v25.SplinteredElementsBuff) or (v68 <= (596 - (57 + 527))))) then
		if v12(v25.LightningBolt) then
			return "lightning_bolt funnel 12";
		end
	end
	if (v25.ElementalBlast:IsReady() and UseSpender and v7:IsSpellInRange(v25.ElementalBlast) and (v53 >= (1432 - (41 + 1386))) and v25.ElementalSpirits:IsAvailable() and (v31.FeralSpiritCount >= (107 - (17 + 86)))) then
		if v12(v25.ElementalBlast) then
			return "elemental_blast funnel 14";
		end
	end
	if (v25.LightningBolt:IsCastable() and UseSpender and v7:IsSpellInRange(v25.LightningBolt) and v25.Supercharge:IsAvailable() and (v53 == v54) and (v60 > v61)) then
		if v12(v25.LightningBolt) then
			return "lightning_bolt funnel 16";
		end
	end
	if (v25.ChainLightning:IsCastable() and UseSpender and v7:IsSpellInRange(v25.ChainLightning) and ((v25.Supercharge:IsAvailable() and (v53 == v54)) or (v6:BuffUp(v25.ArcDischargeBuff) and (v53 >= (4 + 1))))) then
		if v12(v25.ChainLightning) then
			return "chain_lightning funnel 18";
		end
	end
	if (v25.LavaLash:IsReady() and v7:IsSpellInRange(v25.LavaLash) and ((v25.MoltenAssault:IsAvailable() and v7:DebuffUp(v25.FlameShockDebuff) and (v25.FlameShockDebuff:AuraActiveCount() < v63) and (v25.FlameShockDebuff:AuraActiveCount() < (13 - 7))) or (v25.AshenCatalyst:IsAvailable() and (v6:BuffStack(v25.AshenCatalystBuff) == v55)))) then
		if v12(v25.LavaLash) then
			return "lava_lash funnel 20";
		end
	end
	if (v25.PrimordialWave:IsReady() and (v6:BuffDown(v25.PrimordialWaveBuff))) then
		if v30.CastTargetIf(v25.PrimordialWave, v62, "min", v78, nil, not v7:IsSpellInRange(v25.PrimordialWave), nil, v32.CommonsDS.DisplayStyle.PrimordialWave) then
			return "primordial_wave funnel 22";
		end
	end
	if (v25.ElementalBlast:IsReady() and UseSpender and v7:IsSpellInRange(v25.ElementalBlast) and (not v25.ElementalSpirits:IsAvailable() or (v25.ElementalSpirits:IsAvailable() and ((v25.ElementalBlast:Charges() == v25.ElementalBlast:MaxCharges()) or v6:BuffUp(v25.FeralSpiritBuff)))) and (v53 == v54)) then
		if v12(v25.ElementalBlast) then
			return "elemental_blast funnel 24";
		end
	end
	if (v25.FeralSpirit:IsCastable() and TargetInMeleeRange and IsFeralSpirit) then
		if v12(v25.FeralSpirit, true) then
			return "feral_spirit funnel 26";
		end
	end
	if (v25.DoomWinds:IsCastable() and v7:IsInMeleeRange(14 - 9) and IsDoomWinds) then
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
	if (v25.ChainLightning:IsCastable() and UseSpender and v7:IsSpellInRange(v25.ChainLightning) and (v53 == v54)) then
		if v12(v25.ChainLightning) then
			return "chain_lightning funnel 36";
		end
	end
	if (v25.CrashLightning:IsReady() and v7:IsInMeleeRange(174 - (122 + 44)) and (v6:BuffUp(v25.DoomWindsBuff) or v6:BuffDown(v25.CrashLightningBuff) or (v25.AlphaWolf:IsAvailable() and v6:BuffUp(v25.FeralSpiritBuff) and (v76() == (0 - 0))) or (v25.ConvergingStorms:IsAvailable() and (v6:BuffStack(v25.ConvergingStormsBuff) < v56)))) then
		if v12(v25.CrashLightning, true) then
			return "crash_lightning funnel 38";
		end
	end
	if (v25.Sundering:IsReady() and v7:IsInMeleeRange(36 - 25) and IsSundering and (v6:BuffUp(v25.DoomWindsBuff) or v25.Earthsurge:IsAvailable())) then
		if v12(v25.Sundering, true) then
			return "sundering funnel 40";
		end
	end
	if (v25.FireNova:IsReady() and IsFireNova and ((v25.FlameShockDebuff:AuraActiveCount() >= (5 + 1)) or ((v25.FlameShockDebuff:AuraActiveCount() >= (1 + 3)) and (v25.FlameShockDebuff:AuraActiveCount() >= v63)))) then
		if v12(v25.FireNova) then
			return "fire_nova funnel 42";
		end
	end
	if (v25.IceStrike:IsReady() and v7:IsSpellInRange(v25.IceStrike) and IsIceStrike and v25.Hailstorm:IsAvailable() and v6:BuffDown(v25.IceStrikeBuff)) then
		if v12(v25.IceStrike) then
			return "ice_strike funnel 44";
		end
	end
	if (v25.FrostShock:IsReady() and v7:IsSpellInRange(v25.FrostShock) and v25.Hailstorm:IsAvailable() and v6:BuffUp(v25.HailstormBuff)) then
		if v12(v25.FrostShock) then
			return "frost_shock funnel 46";
		end
	end
	if (v25.Sundering:IsReady() and v7:IsInMeleeRange(21 - 10) and IsSundering) then
		if v12(v25.Sundering, true) then
			return "sundering funnel 48";
		end
	end
	if (v25.FlameShock:IsReady() and v7:IsSpellInRange(v25.FlameShock) and v25.MoltenAssault:IsAvailable() and v7:DebuffDown(v25.FlameShockDebuff)) then
		if v12(v25.FlameShock) then
			return "flame_shock funnel 50";
		end
	end
	if (v25.FlameShock:IsReady() and v7:IsSpellInRange(v25.FlameShock) and (v25.FireNova:IsAvailable() or v25.PrimordialWave:IsAvailable()) and (v25.FlameShockDebuff:AuraActiveCount() < v63) and (v25.FlameShockDebuff:AuraActiveCount() < (71 - (30 + 35)))) then
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
	if (v25.CrashLightning:IsReady() and v7:IsInMeleeRange(1265 - (1043 + 214)) and v25.CrashingStorms:IsAvailable() and v6:BuffUp(v25.CLCrashLightningBuff) and (v63 >= (15 - 11))) then
		if v12(v25.CrashLightning, true) then
			return "crash_lightning funnel 58";
		end
	end
	if (v25.Windstrike:IsCastable() and v7:IsInRange(1242 - (323 + 889))) then
		if v12(v25.Windstrike) then
			return "windstrike funnel 60";
		end
	end
	if (v25.Stormstrike:IsReady() and v7:IsSpellInRange(v25.Stormstrike)) then
		if v12(v25.Stormstrike) then
			return "stormstrike funnel 62";
		end
	end
	if (v25.IceStrike:IsReady() and v7:IsSpellInRange(v25.IceStrike) and IsIceStrike) then
		if v12(v25.IceStrike) then
			return "ice_strike funnel 64";
		end
	end
	if (v25.LavaLash:IsReady() and v7:IsSpellInRange(v25.LavaLash)) then
		if v12(v25.LavaLash) then
			return "lava_lash funnel 66";
		end
	end
	if (v25.CrashLightning:IsReady() and v7:IsInMeleeRange(21 - 13)) then
		if v12(v25.CrashLightning, true) then
			return "crash_lightning funnel 68";
		end
	end
	if (v25.FireNova:IsReady() and IsFireNova and (v25.FlameShockDebuff:AuraActiveCount() >= (582 - (361 + 219)))) then
		if v12(v25.FireNova) then
			return "fire_nova funnel 70";
		end
	end
	if (v25.ElementalBlast:IsReady() and UseSpender and v7:IsSpellInRange(v25.ElementalBlast) and (not v25.ElementalSpirits:IsAvailable() or (v25.ElementalSpirits:IsAvailable() and ((v25.ElementalBlast:Charges() == v25.ElementalBlast:MaxCharges()) or v6:BuffUp(v25.FeralSpiritBuff)))) and (v53 >= (325 - (53 + 267)))) then
		if v12(v25.ElementalBlast) then
			return "elemental_blast funnel 72";
		end
	end
	if (v25.LavaBurst:IsReady() and v7:IsSpellInRange(v25.LavaBurst) and (v31.MoltenWeaponStacks > v31.CracklingSurgeStacks) and (v53 >= (2 + 3))) then
		if v12(v25.LavaBurst) then
			return "lava_burst funnel 74";
		end
	end
	if (v25.LightningBolt:IsCastable() and UseSpender and v7:IsSpellInRange(v25.LightningBolt) and (v53 >= (418 - (15 + 398))) and (v60 > v61)) then
		if v12(v25.LightningBolt) then
			return "lightning_bolt funnel 76";
		end
	end
	if (v25.ChainLightning:IsReady() and (v53 >= (987 - (18 + 964)))) then
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
local function v98()
	v30.HealthPotions();
	if v6:IsChanneling(v26.ManicGrieftorch.ItemUseSpell) then
		return "Dont cut Torch";
	end
	InterruptToggle = v11.ToggleIconFrame:GetToggle(3 - 2);
	DispelToggle = v11.ToggleIconFrame:GetToggle(2 + 0);
	Smallcds = v11.ToggleIconFrame:GetToggle(2 + 1);
	UseSpender = v11.ToggleIconFrame:GetToggle(854 - (20 + 830));
	FunnelToggle = v11.ToggleIconFrame:GetToggle(4 + 1);
	v90();
	v27 = v30.UnitsinRange(v25.HealingSurge);
	v62 = v6:GetEnemiesInMeleeRange(136 - (116 + 10));
	if v13() then
		v63 = #v62;
		v64 = v74(3 + 37);
	else
		v63 = 739 - (542 + 196);
		v64 = 1 - 0;
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
	TargetInMeleeRange = v7:IsInRange(3 + 2);
	v47, v49, _, _, v48, v50 = v18();
	if ((not v47 or (v49 < (215980 + 384020))) and v25.WindfuryWeapon:IsCastable()) then
		if v12(v25.WindfuryWeapon) then
			return "windfury_weapon enchant";
		end
	end
	if ((not v48 or (v50 < (1581054 - 981054))) and v25.FlametongueWeapon:IsCastable()) then
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
		if (v68 == (28486 - 17375)) then
			v86 = false;
			v68 = v3.FightRemains(v62, false);
		end
		v53 = v6:BuffStack(v25.MaelstromWeaponBuff);
		v58 = v20((v25.FeralSpirit:CooldownRemains() / ((1555 - (1126 + 425)) * v15(v25.WitchDoctorsAncestry:IsAvailable()))) + ((1405 - (118 + 287)) * v15(not v25.FeralSpirit:IsAvailable())), v25.DoomWinds:CooldownRemains() + ((3919 - 2919) * v15(not v25.DoomWinds:IsAvailable())), v25.Ascendance:CooldownRemains() + ((2121 - (118 + 1003)) * v15(not v25.Ascendance:IsAvailable())));
		v59 = ((2 - 1) + (v15(v7:DebuffUp(v25.ChaosBrandDebuff)) * (377.05 - (142 + 235)))) * ((4 - 3) + (v15(v7:DebuffUp(v25.HuntersMarkDebuff) and (v7:HealthPercentage() >= (18 + 62))) * (977.05 - (553 + 424))));
		local v136 = (1.75 - 0) * v25.LightningBolt:Damage();
		local v137 = (0.2 + 0) * v25.LightningBolt:Damage() * ((v7:DebuffUp(v25.LightningRodDebuff) and (1.75 + 0)) or (1 + 0));
		v60 = v25.LightningBolt:Damage() * (1 + 0 + (v15(v7:DebuffUp(v25.LightningRodDebuff)) * v59 * (1 + 0 + (v15(v6:BuffUp(v25.PrimordialWaveBuff)) * v25.FlameShockDebuff:AuraActiveCount() * v136)) * v137));
		v61 = v25.ChainLightning:Damage() * ((2 - 1) + (v15(v7:DebuffUp(v25.LightningRodDebuff)) * v59 * v20(v63, (7 - 4) + ((4 - 2) * v15(v25.CrashingStorms:IsAvailable()))) * v137));
	end
	if v6:AffectingCombat() then
		if v6:PrevGCD(1 + 0, v25.ChainLightning) then
			v66 = v25.ChainLightning;
		elseif v6:PrevGCD(4 - 3, v25.LightningBolt) then
			v66 = v25.LightningBolt;
		end
	end
	if ((v32.Commons.AutoWolf == "always") or ((v32.Commons.AutoWolf == "Only in Combat") and v6:AffectingCombat()) or ((v32.Commons.AutoWolf == "Only out of combat") and not v6:AffectingCombat())) then
		if (v6:IsMoving() and not v6:IsMounted() and v6:BuffDown(v25.GhostWolf) and not v6:AffectingCombat()) then
			v12(v25.GhostWolf);
			return "Ghost Wolf";
		end
		if (v6:IsMoving() and not v6:IsMounted() and v6:BuffDown(v25.GhostWolf) and v6:AffectingCombat() and (v90() > (754 - (239 + 514))) and (not v7:IsInMeleeRange(3 + 5) or not v30.TargetIsValid())) then
			v12(v25.GhostWolf);
			return "Ghost Wolf";
		end
	end
	v24 = v30.IncorpCycle(v25.Hex, 1359 - (797 + 532), false, false);
	if v24 then
		return v24;
	end
	if DispelToggle then
		v24 = v30.PurgeCycle(v25.Purge, 30 + 10, false, v32.Commons.TabForPurge);
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
			if ((v71 > (1 + 0)) or (v25.CleanseSpirit:CooldownDown() and (v71 > (0 - 0)))) then
				return v11.CastTarget(v25.PoisonCleansingTotem);
			end
		end
	end
	local v130 = ((v25.ElementalOrbit:IsAvailable()) and v25.EarthShieldSelfBuff) or v25.EarthShieldOtherBuff;
	if (((v32.Enhancement.Defensives.Earthshieldooc and not v6:AffectingCombat()) or not v32.Enhancement.Defensives.Earthshieldooc) and (v25.ElementalOrbit:IsAvailable() or v32.Enhancement.PreferEarthShield) and v25.EarthShield:IsReady() and (v6:BuffDown(v130) or (not v6:AffectingCombat() and (v6:BuffStack(v130) < (1207 - (373 + 829)))))) then
		if v11.CastTarget(v25.EarthShield, v11.TName().PLAYER) then
			return "EarthShield";
		end
	elseif (((v32.Enhancement.Defensives.Earthshieldooc and not v6:AffectingCombat()) or not v32.Enhancement.Defensives.Earthshieldooc) and (v25.ElementalOrbit:IsAvailable() or not v32.Enhancement.PreferEarthShield or not v25.EarthShield:IsAvailable()) and v25.LightningShield:IsReady() and v6:BuffDown(v25.LightningShield)) then
		if v12(v25.LightningShield) then
			return "lightning_shield main 3";
		end
	end
	if (v25.SkyFury:IsReady() and (v6:Level() >= (747 - (476 + 255))) and not v6:DebuffUp(v25.Corruption) and ((v30.GroupBuffMissing(v25.SkyFuryBuff) and (v32.Commons.SkyFury == "check whole group") and (v6:IsInRaidArea() or v6:IsInDungeonArea())) or (v6:BuffDown(v25.SkyFuryBuff, true) and ((v32.Commons.SkyFury == "only check us") or (v32.Commons.SkyFury == "check whole group")))) and not v6:IsMounted()) then
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
					v24 = v30.InterruptCycle(v25.WindShear, 1160 - (369 + 761), true, nil, false);
					v24 = v30.InterruptCycle(v25.Thunderstorm, 6 + 4, false, nil, true, true);
				end
				v24 = (v63 > (0 - 0)) and not v7:IsInRange(9 - 4) and v84();
				if v24 then
					return v24;
				end
				if (v32.Commons.Enabled.Potions and (v6:BuffUp(v25.AscendanceBuff) or v6:BuffUp(v25.FeralSpiritBuff) or ((v68 % (538 - (64 + 174))) <= (5 + 25)) or (not v25.Ascendance:IsAvailable() and not v25.FeralSpirit:IsAvailable() and not v25.DoomWinds:IsAvailable()))) then
					local v140 = v30.PotionSelected();
					if (v140 and v140:IsReady() and IsPotions) then
						v11.CastMacro(3 - 0, nil, nil, v140);
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
				if (v25.BloodFury:IsCastable() and IsRacials and TargetInMeleeRange and (v6:BuffUp(v25.AscendanceBuff) or v6:BuffUp(v25.FeralSpiritBuff) or v6:BuffUp(v25.DoomWindsBuff) or ((v68 % (456 - (144 + 192))) <= (231 - (42 + 174))) or (v58 >= (91 + 29)) or (not v25.Ascendance:IsAvailable() and not v25.FeralSpirit:IsAvailable() and not v25.DoomWinds:IsAvailable()))) then
					if v12(v25.BloodFury, true) then
						return "blood_fury racial";
					end
				end
				if (v25.Berserking:IsCastable() and IsRacials and TargetInMeleeRange and (v6:BuffUp(v25.AscendanceBuff) or v6:BuffUp(v25.FeralSpiritBuff) or v6:BuffUp(v25.DoomWindsBuff) or ((v68 % (150 + 30)) <= (6 + 6)) or (v58 >= (1684 - (363 + 1141))) or (not v25.Ascendance:IsAvailable() and not v25.FeralSpirit:IsAvailable() and not v25.DoomWinds:IsAvailable()))) then
					if v12(v25.Berserking, true) then
						return "berserking racial";
					end
				end
				if (v25.Fireblood:IsCastable() and IsRacials and TargetInMeleeRange and (v6:BuffUp(v25.AscendanceBuff) or v6:BuffUp(v25.FeralSpiritBuff) or v6:BuffUp(v25.DoomWindsBuff) or ((v68 % (1700 - (1183 + 397))) <= (24 - 16)) or (v58 >= (88 + 32)) or (not v25.Ascendance:IsAvailable() and not v25.FeralSpirit:IsAvailable() and not v25.DoomWinds:IsAvailable()))) then
					if v12(v25.Fireblood, true) then
						return "fireblood racial";
					end
				end
				if (v25.AncestralCall:IsCastable() and IsRacials and TargetInMeleeRange and (v6:BuffUp(v25.AscendanceBuff) or v6:BuffUp(v25.FeralSpiritBuff) or v6:BuffUp(v25.DoomWindsBuff) or ((v68 % (90 + 30)) <= (1990 - (1913 + 62))) or (v58 >= (76 + 44)) or (not v25.Ascendance:IsAvailable() and not v25.FeralSpirit:IsAvailable() and not v25.DoomWinds:IsAvailable()))) then
					if v12(v25.AncestralCall, true) then
						return "ancestral_call racial";
					end
				end
				if (v25.PrimordialWave:IsReady() and IsPrimordialWave and v7:IsSpellInRange(v25.PrimordialWave) and (v6:HasTier(81 - 50, 1935 - (565 + 1368)))) then
					if v12(v25.PrimordialWave) then
						return "primordial_wave main 22";
					end
				end
				if (v25.FeralSpirit:IsCastable() and TargetInMeleeRange and IsFeralSpirit and (v25.ElementalSpirits:IsAvailable() or (v25.AlphaWolf:IsAvailable() and (v63 > (3 - 2))))) then
					if v12(v25.FeralSpirit, true) then
						return "feral_spirit main 24";
					end
				end
				if (v25.SurgingTotem:IsReady() and IsSurgingTotem and TargetInMeleeRange) then
					if v11.CastTarget(v25.SurgingTotem, v11.TName().PLAYER) then
						return "surging_totem main 26";
					end
				end
				if (v25.Ascendance:IsCastable() and IsAscendance and TargetInMeleeRange and v7:DebuffUp(v25.FlameShockDebuff) and (((v66 == v25.LightningBolt) and (v63 == (1662 - (1477 + 184)))) or ((v66 == v25.ChainLightning) and (v63 > (1 - 0))))) then
					if v12(v25.Ascendance) then
						return "ascendance main 28";
					end
				end
				if ((v63 < (2 + 0)) and not v25.SurgingTotem:IsAvailable()) then
					local v141 = v93();
					if v141 then
						return v141;
					end
				end
				if ((v63 < (858 - (564 + 292))) and v25.SurgingTotem:IsAvailable()) then
					local v142 = v94();
					if v142 then
						return v142;
					end
				end
				if (v13() and (v63 > (1 - 0))) then
					if not FunnelToggle then
						if not v25.SurgingTotem:IsAvailable() then
							local v144 = v95();
							if v144 then
								return v144;
							end
						else
							local v145 = v96();
							if v145 then
								return v145;
							end
						end
					else
						local v143 = v97();
						if v143 then
							return v143;
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
local function v99()
	v11.ResetToggle();
	v32.Enhancement.Display();
	v25.FlameShockDebuff:RegisterAuraTracking();
	v11.ToggleIconFrame:AddButtonCustom("I", 2 - 1, "Interrupt", "interrupt");
	v11.ToggleIconFrame:AddButtonCustom("D", 306 - (244 + 60), "Dispel", "dispel");
	v11.ToggleIconFrame:AddButtonCustom("S", 3 + 0, "smallCDs", "smallcds");
	v11.ToggleIconFrame:AddButtonCustom("P", 480 - (41 + 435), "UseSpender", "usespender");
	v11.ToggleIconFrame:AddButtonCustom("F", 1006 - (938 + 63), "Funnel", "funnel");
	v30.PostInitialMessage(203 + 60);
end
v11.SetAPL(1388 - (936 + 189), v98, v99);
