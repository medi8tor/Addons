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
	local v97, v98 = v6:GetTrinketData(v28);
	if ((v72 < (122 - (32 + 85))) and ((v97.ID == (0 + 0)) or (v98.ID == (0 + 0)) or ((v97.SpellID > (957 - (892 + 65))) and not v97.Usable) or ((v98.SpellID > (0 - 0)) and not v98.Usable))) then
		v72 = v72 + (1 - 0);
		v23(8 - 3, function()
			v73();
		end);
		return;
	end
	v33 = v97.Object;
	v34 = v98.Object;
	v35 = v97.Spell;
	v37 = v97.Range;
	v39 = v97.CastTime;
	v36 = v98.Spell;
	v38 = v98.Range;
	v40 = v98.CastTime;
	v41 = v97.Cooldown;
	v42 = v98.Cooldown;
	v43 = v97.Blacklisted;
	v44 = v98.Blacklisted;
	v45 = (v97.ID == v26.AlgetharPuzzleBox:ID()) or (v97.ID == v26.ManicGrieftorch:ID()) or (v97.ID == v26.ElementiumPocketAnvil:ID()) or (v97.ID == v26.BeacontotheBeyond:ID());
	v46 = (v98.ID == v26.AlgetharPuzzleBox:ID()) or (v98.ID == v26.ManicGrieftorch:ID()) or (v98.ID == v26.ElementiumPocketAnvil:ID()) or (v98.ID == v26.BeacontotheBeyond:ID());
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
local function v74(v112)
	local v113 = v6:GetEnemiesInRange(v112);
	local v114 = 3 - 2;
	for v128, v129 in pairs(v113) do
		if ((v129:GUID() ~= v7:GUID()) and (v129:AffectingCombat() or v129:IsDummy())) then
			v114 = v114 + (953 - (802 + 150));
		end
	end
	return v114;
end
local function v75(v115)
	for v130 = 2 - 1, 10 - 4, 1 + 0 do
		local v131, v132 = v6:GetTotemInfo(v130);
		if (v115:Name() == v132) then
			return true;
		end
	end
end
local function v76()
	if (not v25.AlphaWolf:IsAvailable() or v6:BuffDown(v25.FeralSpiritBuff)) then
		return 997 - (915 + 82);
	end
	local v116 = v20(v25.CrashLightning:TimeSinceLastCast(), v25.ChainLightning:TimeSinceLastCast());
	if ((v116 > (22 - 14)) or (v116 > v25.FeralSpirit:TimeSinceLastCast())) then
		return 0 + 0;
	end
	return (9 - 1) - v116;
end
v25.LightningBolt:RegisterDamageFormula(function()
	return v17(1191 - (1069 + 118)) * (2.311 - 1) * ((1 - 0) + (v6:MasteryPct() / (18 + 82))) * ((v25.AmplificationCore:IsAvailable() and v75(v25.SurgingTotem) and (1.03 - 0)) or (1 + 0));
end);
v25.ChainLightning:RegisterDamageFormula(function()
	local v117 = (v25.CrashingStorms:IsAvailable() and (796 - (368 + 423))) or (9 - 6);
	return v17(22 - (10 + 8)) * (0.73025 - 0) * ((443 - (416 + 26)) + (v6:MasteryPct() / (319 - 219))) * ((v25.CrashingStorms:IsAvailable() and (1.4 + 0)) or (1 - 0)) * ((v25.AmplificationCore:IsAvailable() and v75(v25.SurgingTotem) and (439.03 - (145 + 293))) or (431 - (44 + 386))) * v20(v63, v117);
end);
local function v77(v118)
	return v118:DebuffRemains(v25.LightningRodDebuff);
end
local function v78(v119)
	return v119:DebuffRemains(v25.FlameShockDebuff);
end
local function v79(v120)
	return v6:BuffDown(v25.PrimordialWaveBuff);
end
local function v80(v121)
	return v121:DebuffRefreshable(v25.LashingFlamesDebuff) and v121:DebuffUp(v25.FlameShockDebuff);
end
local function v81(v122)
	return v122:DebuffRefreshable(v25.FlameShockDebuff);
end
local function v82(v123)
	return v123:NPCID() == (206046 - (998 + 488));
end
local function v83(v124)
	return v124:CastSpellID() == (129875 + 278930);
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
local function v87(v125)
	return (v86 and v32.Enhancement_TTD.IgnoreWhenBoss) or v30.Buggedmobs[v7:NPCID()] or (v30.ISSolo() and v32.Enhancement_TTD.IgnoreWhenSolo) or (v125 == (1138 - (116 + 1022))) or ((v68 >= v125) and (v68 < (32377 - 24600)));
end
local function v88(v126)
	return (v126 ~= "Not Used") and ((((v126 == "with Cooldowns") or ((v126 == "small CDs") and v32.Enhancement_CDUSE.smallcdswithCooldowns) or (v126 == "with Cooldowns or AoE") or (v126 == "on Enemycount or Cooldowns") or (v126 == "on Boss or with Cooldowns")) and v14()) or (v126 == "always") or (((v126 == "on Boss only") or (v126 == "on Boss or on Enemycount") or (v126 == "on Boss or with Cooldowns")) and (v86 or v7:IsDummy())) or ((v126 == "with Bloodlust only") and v6:BloodlustUp()) or ((v126 == "small CDs") and Smallcds) or (((v126 == "on AOE") or (v126 == "with Cooldowns or AoE")) and (v63 >= (2 + 0))) or (((v126 == "on Enemycount or Cooldowns") or (v126 == "on Enemycount") or (v126 == "on Boss or on Enemycount")) and (v63 >= v32.Enhancement_CDUSE.Enemycount)));
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
	if (v25.Windstrike:IsCastable() and v7:IsInRange(2 + 28) and v25.ThorimsInvocation:IsAvailable() and (v53 > (0 + 0)) and (v66 == v25.LightningBolt) and not v25.ElementalSpirits:IsAvailable()) then
		if v12(v25.Windstrike) then
			return "windstrike single 2";
		end
	end
	if (v25.PrimordialWave:IsReady() and v7:IsSpellInRange(v25.PrimordialWave) and IsPrimordialWave and v7:DebuffDown(v25.FlameShockDebuff) and v25.MoltenAssault:IsAvailable()) then
		if v12(v25.PrimordialWave) then
			return "primordial_wave single 4";
		end
	end
	if (v25.FeralSpirit:IsCastable() and TargetInMeleeRange and IsFeralSpirit) then
		if v12(v25.FeralSpirit, true) then
			return "feral_spirit single 6";
		end
	end
	if (v25.TempestAbility:IsReady() and UseSpender and v87(v32.Enhancement_TTD.TempestTTD) and v7:IsInRange(925 - (261 + 624)) and ((v53 == v54) or ((v6:BuffStack(v25.TempestBuff) == v57) and ((v31.TempestMaelstrom > (53 - 23)) or (v6:BuffStack(v25.AwakeningStormsBuff) == (1082 - (1020 + 60)))) and (v53 >= (1428 - (630 + 793)))))) then
		if v12(v25.LightningBolt) then
			return "tempest single 10";
		end
	end
	if (v25.ElementalBlast:IsReady() and UseSpender and v7:IsSpellInRange(v25.ElementalBlast) and (v53 == v54) and v25.ElementalSpirits:IsAvailable() and (v69 >= (19 - 13)) and ((v25.ElementalBlast:ChargesFractional() >= (4.8 - 3)) or v6:BuffUp(v25.AscendanceBuff))) then
		if v12(v25.ElementalBlast) then
			return "elemental_blast single 12";
		end
	end
	if (v25.DoomWinds:IsCastable() and v7:IsInMeleeRange(2 + 3) and IsDoomWinds and not v25.ElementalSpirits:IsAvailable()) then
		if v12(v25.DoomWinds, true) then
			return "doom_winds single 14";
		end
	end
	if (v25.Windstrike:IsCastable() and v7:IsInRange(103 - 73) and v25.ThorimsInvocation:IsAvailable() and (v53 > (1747 - (760 + 987))) and (v66 == v25.LightningBolt)) then
		if v12(v25.Windstrike) then
			return "windstrike single 16";
		end
	end
	if (v25.Sundering:IsReady() and v7:IsInMeleeRange(1924 - (1789 + 124)) and IsSundering and v6:BuffUp(v25.AscendanceBuff) and v75(v25.SurgingTotem) and v25.Earthsurge:IsAvailable()) then
		if v12(v25.Sundering, true) then
			return "sundering single 18";
		end
	end
	if (v25.FlameShock:IsReady() and v7:IsSpellInRange(v25.FlameShock) and v7:DebuffDown(v25.FlameShockDebuff) and v25.LashingFlames:IsAvailable()) then
		if v12(v25.FlameShock) then
			return "flame_shock single 20";
		end
	end
	if (v25.LightningBolt:IsCastable() and UseSpender and v7:IsSpellInRange(v25.LightningBolt) and (v53 >= v54) and v6:BuffUp(v25.PrimordialWaveBuff) and v25.Tempest:IsAvailable()) then
		if v12(v25.LightningBolt) then
			return "lightning_bolt single 21";
		end
	end
	if (v25.TempestAbility:IsReady() and UseSpender and v87(v32.Enhancement_TTD.TempestTTD) and v7:IsInRange(806 - (745 + 21)) and (v53 >= (3 + 4))) then
		if v12(v25.LightningBolt) then
			return "tempest single 22";
		end
	end
	if (v25.ElementalBlast:IsReady() and UseSpender and v7:IsSpellInRange(v25.ElementalBlast) and (((v53 >= (13 - 8)) and v25.ElementalSpirits:IsAvailable() and (v69 >= (15 - 11)) and not v25.Tempest:IsAvailable()) or ((v53 >= (1 + 6)) and (v69 >= (4 + 1)) and (v6:BuffUp(v25.IcyEdgeBuff) or v6:BuffUp(v25.MoltenWeaponBuff)) and (v25.FeralSpirit:CooldownRemains() >= (1058 - (87 + 968)))) or ((v53 >= (30 - 23)) and (v69 >= (1 + 0)) and ((v31.IcyEdgeStacks + v31.MoltenWeaponStacks) >= (2 - 1)) and (v25.ElementalBlast:ChargesFractional() >= (1414.8 - (447 + 966))) and (v25.FeralSpirit:CooldownRemains() >= (8 - 5))))) then
		if v12(v25.ElementalBlast) then
			return "elemental_blast single 24";
		end
	end
	if (v25.LightningBolt:IsCastable() and UseSpender and v7:IsSpellInRange(v25.LightningBolt) and (v53 >= (1822 - (1703 + 114))) and v25.Tempest:IsAvailable() and (v53 >= (v54 - (v15(v25.ElementalSpirits:IsAvailable()) * (v15(v25.Supercharge:IsAvailable()) + v15(v25.StaticAccumulation:IsAvailable()))))) and v6:BuffDown(v25.PrimordialWaveBuff)) then
		if v12(v25.LightningBolt) then
			return "lightning_bolt single 26";
		end
	end
	if (v25.LightningBolt:IsCastable() and UseSpender and v7:IsSpellInRange(v25.LightningBolt) and (v53 >= (706 - (376 + 325))) and v6:BuffUp(v25.AscendanceBuff) and (v66 == v25.ChainLightning) and (v6:BuffRemains(v25.AscendanceBuff) > (v25.Windstrike:CooldownRemains() + v6:GCD())) and v6:BuffDown(v25.PrimordialWaveBuff)) then
		if v12(v25.LightningBolt) then
			return "lightning_bolt single 28";
		end
	end
	if (v25.Stormstrike:IsReady() and v7:IsSpellInRange(v25.Stormstrike) and not v25.ElementalSpirits:IsAvailable() and (v6:BuffUp(v25.DoomWindsBuff) or v25.DeeplyRootedElements:IsAvailable() or (v25.Stormblast:IsAvailable() and v6:BuffUp(v25.StormbringerBuff)))) then
		if v12(v25.Stormstrike) then
			return "stormstrike single 30";
		end
	end
	if (v25.LavaLash:IsCastable() and v7:IsSpellInRange(v25.LavaLash) and v6:BuffUp(v25.HotHandBuff) and not v25.Tempest:IsAvailable()) then
		if v12(v25.LavaLash) then
			return "lava_lash single 31";
		end
	end
	if (v25.ElementalBlast:IsReady() and UseSpender and v7:IsSpellInRange(v25.ElementalBlast) and (v53 >= (8 - 3)) and (v25.ElementalBlast:Charges() == v25.ElementalBlast:MaxCharges()) and not v25.Tempest:IsAvailable()) then
		if v12(v25.ElementalBlast) then
			return "elemental_blast single 32";
		end
	end
	if (v25.LightningBolt:IsCastable() and UseSpender and v7:IsSpellInRange(v25.LightningBolt) and (v53 >= (24 - 16)) and v6:BuffUp(v25.PrimordialWaveBuff) and (v6:BuffDown(v25.SplinteredElementsBuff) or (v68 <= (4 + 8)))) then
		if v12(v25.LightningBolt) then
			return "lightning_bolt single 34";
		end
	end
	if (v25.ElementalBlast:IsReady() and UseSpender and v7:IsSpellInRange(v25.ElementalBlast) and (v53 >= (17 - 9)) and ((v69 >= (16 - (9 + 5))) or not v25.ElementalSpirits:IsAvailable()) and not v25.Tempest:IsAvailable()) then
		if v12(v25.ElementalBlast) then
			return "elemental_blast single 36";
		end
	end
	if (v25.LavaBurst:IsReady() and v7:IsSpellInRange(v25.LavaBurst) and not v25.ThorimsInvocation:IsAvailable() and (v53 >= (381 - (85 + 291)))) then
		if v12(v25.LavaBurst) then
			return "lava_burst single 38";
		end
	end
	if (v25.PrimordialWave:IsReady() and v7:IsSpellInRange(v25.PrimordialWave) and IsPrimordialWave) then
		if v12(v25.PrimordialWave) then
			return "primordial_wave single 40";
		end
	end
	if (v25.ElementalBlast:IsReady() and UseSpender and v7:IsSpellInRange(v25.ElementalBlast) and (v53 >= (1270 - (243 + 1022))) and (v69 >= (14 - 10)) and v25.Ascendance:IsAvailable() and ((v25.ElementalBlast:ChargesFractional() >= (1.8 + 0)) or ((v31.IcyEdgeStacks + v31.MoltenWeaponStacks) >= (1184 - (1123 + 57))))) then
		if v12(v25.ElementalBlast) then
			return "elemental_blast single 42";
		end
	end
	if (v25.LightningBolt:IsCastable() and UseSpender and v7:IsSpellInRange(v25.LightningBolt) and ((v53 >= (7 + 1)) or (v25.StaticAccumulation:IsAvailable() and (v53 >= (259 - (163 + 91))))) and v6:BuffDown(v25.PrimordialWaveBuff) and v25.Ascendance:IsAvailable() and v25.Tempest:IsAvailable()) then
		if v12(v25.LightningBolt) then
			return "lightning_bolt single 44";
		end
	end
	if (v25.DoomWinds:IsCastable() and v7:IsInMeleeRange(1935 - (1869 + 61)) and IsDoomWinds and v25.ElementalSpirits:IsAvailable() and v25.Ascendance:IsAvailable() and v25.Tempest:IsAvailable()) then
		if v12(v25.DoomWinds, true) then
			return "doom_winds single 46";
		end
	end
	if (v25.LavaLash:IsCastable() and v7:IsSpellInRange(v25.LavaLash) and v25.Tempest:IsAvailable() and (v6:BuffUp(v25.HotHandBuff) or (v25.MoltenAssault:IsAvailable() and v25.ElementalSpirits:IsAvailable() and not v25.DeeplyRootedElements:IsAvailable() and (v7:DebuffRemains(v25.FlameShockDebuff) <= (1 + 2))))) then
		if v12(v25.LavaLash) then
			return "lava_lash single 48";
		end
	end
	if (v25.Stormstrike:IsReady() and v7:IsSpellInRange(v25.Stormstrike) and v25.ElementalSpirits:IsAvailable() and (v6:BuffUp(v25.DoomWindsBuff) or v25.DeeplyRootedElements:IsAvailable() or v25.Ascendance:IsAvailable() or (v25.Stormblast:IsAvailable() and v6:BuffUp(v25.StormbringerBuff)))) then
		if v12(v25.Stormstrike) then
			return "stormstrike single 50";
		end
	end
	if (v25.FrostShock:IsCastable() and v7:IsSpellInRange(v25.FrostShock) and v6:BuffUp(v25.HailstormBuff) and v6:BuffUp(v25.IceStrikeBuff) and v25.SwirlingMaelstrom:IsAvailable() and v25.Tempest:IsAvailable() and v25.Ascendance:IsAvailable()) then
		if v12(v25.FrostShock) then
			return "frost_shock single 52";
		end
	end
	if (v25.ElementalBlast:IsReady() and UseSpender and v7:IsSpellInRange(v25.ElementalBlast) and (v53 >= (17 - 12)) and (v69 >= (5 - 1)) and v25.DeeplyRootedElements:IsAvailable() and ((v25.ElementalBlast:ChargesFractional() >= (1.8 + 0)) or ((v31.IcyEdgeStacks + v31.MoltenWeaponStacks) >= (5 - 1)))) then
		if v12(v25.ElementalBlast) then
			return "elemental_blast single 54";
		end
	end
	if (v25.LightningBolt:IsCastable() and UseSpender and v7:IsSpellInRange(v25.LightningBolt) and ((v53 >= (8 + 0)) or (v25.StaticAccumulation:IsAvailable() and (v53 >= (1479 - (1329 + 145))))) and v6:BuffDown(v25.PrimordialWaveBuff)) then
		if v12(v25.LightningBolt) then
			return "lightning_bolt single 56";
		end
	end
	if (v25.CrashLightning:IsReady() and v7:IsInMeleeRange(979 - (140 + 831)) and v25.AlphaWolf:IsAvailable() and v6:BuffUp(v25.FeralSpiritBuff) and (v76() == (1850 - (1409 + 441)))) then
		if v12(v25.CrashLightning, true) then
			return "crash_lightning single 58";
		end
	end
	if (v25.FlameShock:IsReady() and v7:IsSpellInRange(v25.FlameShock) and v7:DebuffDown(v25.FlameShockDebuff) and not v25.Tempest:IsAvailable()) then
		if v12(v25.FlameShock) then
			return "flame_shock single 60";
		end
	end
	if ((v25.TotemicRebound:IsAvailable() and (v20(v25.Stormstrike:TimeSinceLastCast(), v25.Windstrike:TimeSinceLastCast()) >= (721.5 - (15 + 703)))) or (v25.AwakeningStorms:IsAvailable() and (v20(v25.Stormstrike:TimeSinceLastCast(), v25.Windstrike:TimeSinceLastCast(), v25.LightningBolt:TimeSinceLastCast(), v25.TempestAbility:TimeSinceLastCast(), v25.ChainLightning:TimeSinceLastCast()) >= (2.5 + 1)))) then
		if (v25.Windstrike:IsCastable() and v7:IsInRange(468 - (262 + 176))) then
			if v12(v25.Windstrike) then
				return "windstrike single 62";
			end
		end
		if (v25.Stormstrike:IsReady() and v7:IsSpellInRange(v25.Stormstrike)) then
			if v12(v25.Stormstrike) then
				return "stormstrike single 64";
			end
		end
	end
	if (v25.LavaLash:IsCastable() and v7:IsSpellInRange(v25.LavaLash) and v25.LivelyTotems:IsAvailable() and (v25.LavaLash:TimeSinceLastCast() >= (1724.5 - (345 + 1376)))) then
		if v12(v25.LavaLash) then
			return "lava_lash single 66";
		end
	end
	if (v25.DoomWinds:IsReady() and v7:IsInMeleeRange(693 - (198 + 490)) and IsDoomWinds and (v25.ElementalSpirits:IsAvailable())) then
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
	if (v25.CrashLightning:IsReady() and v7:IsInMeleeRange(35 - 27) and (v25.ConvergingStorms:IsAvailable())) then
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
	if (v25.Windstrike:IsCastable() and v7:IsInRange(71 - 41)) then
		if v12(v25.Windstrike) then
			return "windstrike single 90";
		end
	end
	if (v25.Stormstrike:IsReady() and v7:IsSpellInRange(v25.Stormstrike)) then
		if v12(v25.Stormstrike) then
			return "stormstrike single 92";
		end
	end
	if (v25.Sundering:IsReady() and v7:IsInMeleeRange(1217 - (696 + 510)) and IsSundering) then
		if v12(v25.Sundering, true) then
			return "sundering single 94";
		end
	end
	if (v25.TempestAbility:IsReady() and UseSpender and v87(v32.Enhancement_TTD.TempestTTD) and v7:IsInRange(83 - 43) and (v53 >= (1267 - (1091 + 171)))) then
		if v12(v25.LightningBolt) then
			return "tempest single 96";
		end
	end
	if (v25.LightningBolt:IsCastable() and UseSpender and v7:IsSpellInRange(v25.LightningBolt) and v25.Hailstorm:IsAvailable() and (v53 >= (1 + 4)) and v6:BuffDown(v25.PrimordialWaveBuff)) then
		if v12(v25.LightningBolt) then
			return "lightning_bolt single 98";
		end
	end
	if (v25.FrostShock:IsReady() and v7:IsSpellInRange(v25.FrostShock)) then
		if v12(v25.FrostShock) then
			return "frost_shock single 100";
		end
	end
	if (v25.CrashLightning:IsReady() and v7:IsInMeleeRange(25 - 17)) then
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
	if (v25.LightningBolt:IsCastable() and UseSpender and v7:IsSpellInRange(v25.LightningBolt) and (v53 >= (16 - 11)) and v6:BuffDown(v25.PrimordialWaveBuff)) then
		if v12(v25.LightningBolt) then
			return "lightning_bolt single 110";
		end
	end
end
local function v94()
	if (v25.TempestAbility:IsReady() and UseSpender and v87(v32.Enhancement_TTD.TempestTTD) and v7:IsInRange(414 - (123 + 251)) and ((v53 == v54) or ((v53 >= (24 - 19)) and ((v31.TempestMaelstrom > (728 - (208 + 490))) or (v6:BuffStack(v25.AwakeningStormsBuff) == (1 + 1)))))) then
		if v12(v25.LightningBolt) then
			return "tempest aoe 2";
		end
	end
	if (v25.Windstrike:IsCastable() and v7:IsInRange(14 + 16) and v25.ThorimsInvocation:IsAvailable() and (v53 > (836 - (660 + 176))) and (v66 == v25.ChainLightning)) then
		if v12(v25.Windstrike) then
			return "windstrike aoe 4";
		end
	end
	if (v25.CrashLightning:IsReady() and v7:IsInMeleeRange(1 + 7) and v25.CrashingStorms:IsAvailable() and ((v25.UnrulyWinds:IsAvailable() and (v63 >= (212 - (14 + 188)))) or (v63 >= (690 - (534 + 141))))) then
		if v12(v25.CrashLightning, true) then
			return "crash_lightning aoe 6";
		end
	end
	if (v25.LightningBolt:IsCastable() and UseSpender and v7:IsSpellInRange(v25.LightningBolt) and (not v25.Tempest:IsAvailable() or ((v31.TempestMaelstrom <= (5 + 5)) and (v6:BuffStack(v25.AwakeningStormsBuff) <= (1 + 0)))) and ((v25.FlameShockDebuff:AuraActiveCount() == v63) or (v25.FlameShockDebuff:AuraActiveCount() >= (6 + 0))) and v6:BuffUp(v25.PrimordialWaveBuff) and (v53 == v54) and (v6:BuffDown(v25.SplinteredElementsBuff) or (v67 <= (24 - 12)))) then
		if v12(v25.LightningBolt) then
			return "lightning_bolt aoe 8";
		end
	end
	if (v25.LavaLash:IsReady() and v7:IsSpellInRange(v25.LavaLash) and v25.MoltenAssault:IsAvailable() and (v25.PrimordialWave:IsAvailable() or v25.FireNova:IsAvailable()) and v7:DebuffUp(v25.FlameShockDebuff) and (v25.FlameShockDebuff:AuraActiveCount() < v63) and (v25.FlameShockDebuff:AuraActiveCount() < (9 - 3))) then
		if v12(v25.LavaLash) then
			return "lava_lash aoe 10";
		end
	end
	if (v25.PrimordialWave:IsReady() and IsPrimordialWave and (v6:BuffDown(v25.PrimordialWaveBuff))) then
		if v30.CastTargetIf(v25.PrimordialWave, v62, "min", v78, v79, 112 - 72) then
			return "primordial_wave aoe 12";
		end
	end
	if (v25.ChainLightning:IsReady() and UseSpender and v7:IsSpellInRange(v25.ChainLightning) and v6:BuffUp(v25.ArcDischargeBuff) and (v53 >= (3 + 2))) then
		if v12(v25.ChainLightning) then
			return "chain_lightning aoe 14";
		end
	end
	if (v25.ElementalBlast:IsReady() and UseSpender and v7:IsSpellInRange(v25.ElementalBlast) and (not v25.ElementalSpirits:IsAvailable() or (v25.ElementalSpirits:IsAvailable() and ((v25.ElementalBlast:Charges() == v65) or (v69 >= (2 + 0))))) and (v53 == v54) and (not v25.CrashingStorms:IsAvailable() or (v63 <= (399 - (115 + 281))))) then
		if v12(v25.ElementalBlast) then
			return "elemental_blast aoe 16";
		end
	end
	if (v25.ChainLightning:IsReady() and UseSpender and v7:IsSpellInRange(v25.ChainLightning) and (v53 == v54)) then
		if v12(v25.ChainLightning) then
			return "chain_lightning aoe 18";
		end
	end
	if (v25.FeralSpirit:IsCastable() and TargetInMeleeRange and IsFeralSpirit) then
		if v12(v25.FeralSpirit, true) then
			return "feral_spirit aoe 20";
		end
	end
	if (v25.DoomWinds:IsCastable() and v7:IsInMeleeRange(11 - 6) and IsDoomWinds) then
		if v12(v25.DoomWinds, true) then
			return "doom_winds aoe 22";
		end
	end
	if (v25.CrashLightning:IsReady() and v7:IsInMeleeRange(7 + 1) and (v6:BuffUp(v25.DoomWindsBuff) or v6:BuffDown(v25.CrashLightningBuff) or (v25.AlphaWolf:IsAvailable() and v6:BuffUp(v25.FeralSpiritBuff) and (v76() == (0 - 0))))) then
		if v12(v25.CrashLightning, true) then
			return "crash_lightning aoe 24";
		end
	end
	if (v25.Sundering:IsReady() and v7:IsInMeleeRange(40 - 29) and IsSundering and (v6:BuffUp(v25.DoomWindsBuff) or v25.Earthsurge:IsAvailable())) then
		if v12(v25.Sundering, true) then
			return "sundering aoe 26";
		end
	end
	if (v25.FireNova:IsReady() and IsFireNova and ((v25.FlameShockDebuff:AuraActiveCount() == (873 - (550 + 317))) or ((v25.FlameShockDebuff:AuraActiveCount() >= (5 - 1)) and (v25.FlameShockDebuff:AuraActiveCount() >= v63)))) then
		if v12(v25.FireNova) then
			return "fire_nova aoe 28";
		end
	end
	if (v25.LavaLash:IsReady() and (v25.LashingFlames:IsAvailable())) then
		if v30.CastCycle(v25.LavaLash, v62, v80, 7 - 2, nil, nil, v32.Enhancement.AutoTabDot, false) then
			return "lava_lash aoe 30";
		end
	end
	if (v25.LavaLash:IsReady() and v7:IsSpellInRange(v25.LavaLash) and v25.MoltenAssault:IsAvailable() and v7:DebuffUp(v25.FlameShockDebuff)) then
		if v12(v25.LavaLash) then
			return "lava_lash aoe 32";
		end
	end
	if (v25.IceStrike:IsReady() and v7:IsSpellInRange(v25.IceStrike) and IsIceStrike and v25.Hailstorm:IsAvailable() and v6:BuffDown(v25.IceStrikeBuff)) then
		if v12(v25.IceStrike) then
			return "ice_strike aoe 34";
		end
	end
	if (v25.FrostShock:IsReady() and v7:IsSpellInRange(v25.FrostShock) and v25.Hailstorm:IsAvailable() and v6:BuffUp(v25.HailstormBuff)) then
		if v12(v25.FrostShock) then
			return "frost_shock aoe 36";
		end
	end
	if (v25.Sundering:IsReady() and v7:IsInMeleeRange(30 - 19) and IsSundering) then
		if v12(v25.Sundering, true) then
			return "sundering aoe 38";
		end
	end
	if (v25.FlameShock:IsReady() and v7:IsSpellInRange(v25.FlameShock) and v25.MoltenAssault:IsAvailable() and v7:DebuffDown(v25.FlameShockDebuff)) then
		if v12(v25.FlameShock) then
			return "flame_shock aoe 40";
		end
	end
	if (v25.FlameShock:IsReady() and (v25.FireNova:IsAvailable() or v25.PrimordialWave:IsAvailable()) and (v25.FlameShockDebuff:AuraActiveCount() < v63) and (v25.FlameShockDebuff:AuraActiveCount() < (291 - (134 + 151)))) then
		if v30.CastCycle(v25.FlameShock, v62, v81, 1705 - (970 + 695)) then
			return "flame_shock aoe 42";
		end
	end
	if (v25.FireNova:IsReady() and IsFireNova and (v25.FlameShockDebuff:AuraActiveCount() >= (5 - 2))) then
		if v12(v25.FireNova) then
			return "fire_nova aoe 44";
		end
	end
	if (v25.Stormstrike:IsReady() and v7:IsSpellInRange(v25.Stormstrike) and v6:BuffUp(v25.CrashLightningBuff) and (v25.DeeplyRootedElements:IsAvailable() or (v6:BuffStack(v25.ConvergingStormsBuff) == v56))) then
		if v12(v25.Stormstrike) then
			return "stormstrike aoe 46";
		end
	end
	if (v25.CrashLightning:IsReady() and v7:IsInMeleeRange(1998 - (582 + 1408)) and v25.CrashingStorms:IsAvailable() and v6:BuffUp(v25.CLCrashLightningBuff) and (v63 >= (13 - 9))) then
		if v12(v25.CrashLightning, true) then
			return "crash_lightning aoe 48";
		end
	end
	if (v25.Windstrike:IsReady() and v7:IsInRange(37 - 7)) then
		if v12(v25.Windstrike) then
			return "windstrike aoe 50";
		end
	end
	if (v25.Stormstrike:IsReady() and v7:IsSpellInRange(v25.Stormstrike)) then
		if v12(v25.Stormstrike) then
			return "stormstrike aoe 52";
		end
	end
	if (v25.IceStrike:IsReady() and v7:IsSpellInRange(v25.IceStrike) and IsIceStrike) then
		if v12(v25.IceStrike) then
			return "ice_strike aoe 54";
		end
	end
	if (v25.LavaLash:IsReady() and v7:DebuffUp(v25.FlameShockDebuff) and v7:IsSpellInRange(v25.LavaLash)) then
		if v12(v25.LavaLash) then
			return "lava_lash aoe 56";
		end
	end
	if (v25.CrashLightning:IsReady() and v7:IsInMeleeRange(30 - 22)) then
		if v12(v25.CrashLightning, true) then
			return "crash_lightning aoe 58";
		end
	end
	if (v25.FireNova:IsReady() and IsFireNova and (v25.FlameShockDebuff:AuraActiveCount() >= (1826 - (1195 + 629)))) then
		if v12(v25.FireNova) then
			return "fire_nova aoe 60";
		end
	end
	if (v25.ElementalBlast:IsReady() and UseSpender and v7:IsSpellInRange(v25.ElementalBlast) and (not v25.ElementalSpirits:IsAvailable() or (v25.ElementalSpirits:IsAvailable() and ((v25.ElementalBlast:Charges() == v65) or (v69 >= (2 - 0))))) and (v53 >= (246 - (187 + 54))) and (not v25.CrashingStorms:IsAvailable() or (v63 <= (783 - (162 + 618))))) then
		if v12(v25.ElementalBlast) then
			return "elemental_blast aoe 62";
		end
	end
	if (v25.ChainLightning:IsReady() and UseSpender and v7:IsSpellInRange(v25.ChainLightning) and (v53 >= (4 + 1))) then
		if v12(v25.ChainLightning) then
			return "chain_lightning aoe 64";
		end
	end
	if (v25.FlameShock:IsReady() and v7:IsSpellInRange(v25.FlameShock) and (v7:DebuffDown(v25.FlameShockDebuff))) then
		if v12(v25.FlameShock) then
			return "flame_shock aoe 66";
		end
	end
	if (v25.FrostShock:IsReady() and v7:IsSpellInRange(v25.FrostShock) and not v25.Hailstorm:IsAvailable()) then
		if v12(v25.FrostShock) then
			return "frost_shock aoe 68";
		end
	end
end
local function v95()
	if v6:IsChanneling(v26.ManicGrieftorch.ItemUseSpell) then
		return "Dont cut Torch";
	end
	InterruptToggle = v11.ToggleIconFrame:GetToggle(1 + 0);
	DispelToggle = v11.ToggleIconFrame:GetToggle(3 - 1);
	Smallcds = v11.ToggleIconFrame:GetToggle(4 - 1);
	UseSpender = v11.ToggleIconFrame:GetToggle(1 + 3);
	v90();
	v27 = v30.UnitsinRange(v25.HealingSurge);
	v62 = v6:GetEnemiesInMeleeRange(1646 - (1373 + 263));
	if v13() then
		v63 = #v62;
		v64 = v74(1040 - (451 + 549));
	else
		v63 = 1 + 0;
		v64 = 1 - 0;
	end
	if (v25.PoisonCleansingTotem:IsAvailable() and v25.PoisonCleansingTotem:IsReady()) then
		v71 = v30.DebuffCount(v27, v70);
	else
		v71 = 0 - 0;
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
	TargetInMeleeRange = v7:IsInRange(1389 - (746 + 638));
	v47, v49, _, _, v48, v50 = v18();
	if ((not v47 or (v49 < (225803 + 374197))) and v25.WindfuryWeapon:IsCastable()) then
		if v12(v25.WindfuryWeapon) then
			return "windfury_weapon enchant";
		end
	end
	if ((not v48 or (v50 < (910970 - 310970))) and v25.FlametongueWeapon:IsCastable()) then
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
		if (v68 == (11452 - (218 + 123))) then
			v86 = false;
			v68 = v3.FightRemains(v62, false);
		end
		v53 = v6:BuffStack(v25.MaelstromWeaponBuff);
		v58 = v20((v25.FeralSpirit:CooldownRemains() / ((1585 - (1535 + 46)) * v15(v25.WitchDoctorsAncestry:IsAvailable()))) + ((994 + 6) * v15(not v25.FeralSpirit:IsAvailable())), v25.DoomWinds:CooldownRemains() + ((145 + 855) * v15(not v25.DoomWinds:IsAvailable())), v25.Ascendance:CooldownRemains() + ((1560 - (306 + 254)) * v15(not v25.Ascendance:IsAvailable())));
		v59 = (1 + 0 + (v15(v7:DebuffUp(v25.ChaosBrandDebuff)) * (0.05 - 0))) * ((1468 - (899 + 568)) + (v15(v7:DebuffUp(v25.HuntersMarkDebuff) and (v7:HealthPercentage() >= (53 + 27))) * (0.05 - 0)));
		local v133 = (604.75 - (268 + 335)) * v25.LightningBolt:Damage();
		local v134 = (290.2 - (60 + 230)) * v25.LightningBolt:Damage() * ((v7:DebuffUp(v25.LightningRodDebuff) and (573.75 - (426 + 146))) or (1 + 0));
		v60 = v25.LightningBolt:Damage() * ((1457 - (282 + 1174)) + (v15(v7:DebuffUp(v25.LightningRodDebuff)) * v59 * ((812 - (569 + 242)) + (v15(v6:BuffUp(v25.PrimordialWaveBuff)) * v25.FlameShockDebuff:AuraActiveCount() * v133)) * v134));
		v61 = v25.ChainLightning:Damage() * ((2 - 1) + (v15(v7:DebuffUp(v25.LightningRodDebuff)) * v59 * v20(v63, 1 + 2 + ((1026 - (706 + 318)) * v15(v25.CrashingStorms:IsAvailable()))) * v134));
	end
	if v6:AffectingCombat() then
		if v6:PrevGCD(1252 - (721 + 530), v25.ChainLightning) then
			v66 = v25.ChainLightning;
		elseif v6:PrevGCD(1272 - (945 + 326), v25.LightningBolt) then
			v66 = v25.LightningBolt;
		end
	end
	if ((v32.Commons.AutoWolf == "always") or ((v32.Commons.AutoWolf == "Only in Combat") and v6:AffectingCombat()) or ((v32.Commons.AutoWolf == "Only out of combat") and not v6:AffectingCombat())) then
		if (v6:IsMoving() and not v6:IsMounted() and v6:BuffDown(v25.GhostWolf) and not v6:AffectingCombat()) then
			v12(v25.GhostWolf);
			return "Ghost Wolf";
		end
		if (v6:IsMoving() and not v6:IsMounted() and v6:BuffDown(v25.GhostWolf) and v6:AffectingCombat() and (v90() > (2 - 1)) and (not v7:IsInMeleeRange(8 + 0) or not v30.TargetIsValid())) then
			v12(v25.GhostWolf);
			return "Ghost Wolf";
		end
	end
	v24 = v30.IncorpCycle(v25.Hex, 730 - (271 + 429), false, false);
	if v24 then
		return v24;
	end
	if DispelToggle then
		v24 = v30.PurgeCycle(v25.Purge, 37 + 3, false, v32.Commons.TabForPurge);
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
			if ((v71 > (1501 - (1408 + 92))) or (v25.CleanseSpirit:CooldownDown() and (v71 > (1086 - (461 + 625))))) then
				return v11.CastTarget(v25.PoisonCleansingTotem);
			end
		end
	end
	local v127 = ((v25.ElementalOrbit:IsAvailable()) and v25.EarthShieldSelfBuff) or v25.EarthShieldOtherBuff;
	if (((v32.Enhancement.Defensives.Earthshieldooc and not v6:AffectingCombat()) or not v32.Enhancement.Defensives.Earthshieldooc) and (v25.ElementalOrbit:IsAvailable() or v32.Enhancement.PreferEarthShield) and v25.EarthShield:IsReady() and (v6:BuffDown(v127) or (not v6:AffectingCombat() and (v6:BuffStack(v127) < (1293 - (993 + 295)))))) then
		if v11.CastTarget(v25.EarthShield, v11.TName().PLAYER) then
			return "EarthShield";
		end
	elseif (((v32.Enhancement.Defensives.Earthshieldooc and not v6:AffectingCombat()) or not v32.Enhancement.Defensives.Earthshieldooc) and (v25.ElementalOrbit:IsAvailable() or not v32.Enhancement.PreferEarthShield or not v25.EarthShield:IsAvailable()) and v25.LightningShield:IsReady() and v6:BuffDown(v25.LightningShield)) then
		if v12(v25.LightningShield) then
			return "lightning_shield main 3";
		end
	end
	if (v25.SkyFury:IsReady() and (v6:Level() >= (1 + 15)) and not v6:DebuffUp(v25.Corruption) and ((v30.GroupBuffMissing(v25.SkyFuryBuff) and (v32.Commons.SkyFury == "check whole group") and (v6:IsInRaidArea() or v6:IsInDungeonArea())) or (v6:BuffDown(v25.SkyFuryBuff, true) and ((v32.Commons.SkyFury == "only check us") or (v32.Commons.SkyFury == "check whole group")))) and not v6:IsMounted()) then
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
					v24 = v30.InterruptCycle(v25.WindShear, 1201 - (418 + 753), true, nil, false);
					v24 = v30.InterruptCycle(v25.Thunderstorm, 4 + 6, false, nil, true, true);
				end
				v24 = (v63 > (0 + 0)) and not v7:IsInRange(2 + 3) and v84();
				if v24 then
					return v24;
				end
				if (v32.Commons.Enabled.Potions and (v6:BuffUp(v25.AscendanceBuff) or v6:BuffUp(v25.FeralSpiritBuff) or ((v68 % (76 + 224)) <= (559 - (406 + 123))) or (not v25.Ascendance:IsAvailable() and not v25.FeralSpirit:IsAvailable() and not v25.DoomWinds:IsAvailable()))) then
					local v137 = v30.PotionSelected();
					if (v137 and v137:IsReady() and IsPotions) then
						v11.CastMacro(1772 - (1749 + 20), nil, nil, v137);
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
				if (v25.BloodFury:IsCastable() and IsRacials and TargetInMeleeRange and (v6:BuffUp(v25.AscendanceBuff) or v6:BuffUp(v25.FeralSpiritBuff) or v6:BuffUp(v25.DoomWindsBuff) or ((v68 % (29 + 91)) <= (1337 - (1249 + 73))) or (v58 >= (43 + 77)) or (not v25.Ascendance:IsAvailable() and not v25.FeralSpirit:IsAvailable() and not v25.DoomWinds:IsAvailable()))) then
					if v12(v25.BloodFury, true) then
						return "blood_fury racial";
					end
				end
				if (v25.Berserking:IsCastable() and IsRacials and TargetInMeleeRange and (v6:BuffUp(v25.AscendanceBuff) or v6:BuffUp(v25.FeralSpiritBuff) or v6:BuffUp(v25.DoomWindsBuff) or ((v68 % (1325 - (466 + 679))) <= (28 - 16)) or (v58 >= (514 - 334)) or (not v25.Ascendance:IsAvailable() and not v25.FeralSpirit:IsAvailable() and not v25.DoomWinds:IsAvailable()))) then
					if v12(v25.Berserking, true) then
						return "berserking racial";
					end
				end
				if (v25.Fireblood:IsCastable() and IsRacials and TargetInMeleeRange and (v6:BuffUp(v25.AscendanceBuff) or v6:BuffUp(v25.FeralSpiritBuff) or v6:BuffUp(v25.DoomWindsBuff) or ((v68 % (2020 - (106 + 1794))) <= (3 + 5)) or (v58 >= (31 + 89)) or (not v25.Ascendance:IsAvailable() and not v25.FeralSpirit:IsAvailable() and not v25.DoomWinds:IsAvailable()))) then
					if v12(v25.Fireblood, true) then
						return "fireblood racial";
					end
				end
				if (v25.AncestralCall:IsCastable() and IsRacials and TargetInMeleeRange and (v6:BuffUp(v25.AscendanceBuff) or v6:BuffUp(v25.FeralSpiritBuff) or v6:BuffUp(v25.DoomWindsBuff) or ((v68 % (354 - 234)) <= (40 - 25)) or (v58 >= (234 - (4 + 110))) or (not v25.Ascendance:IsAvailable() and not v25.FeralSpirit:IsAvailable() and not v25.DoomWinds:IsAvailable()))) then
					if v12(v25.AncestralCall, true) then
						return "ancestral_call racial";
					end
				end
				if (v25.PrimordialWave:IsReady() and IsPrimordialWave and v7:IsSpellInRange(v25.PrimordialWave) and (v6:HasTier(615 - (57 + 527), 1429 - (41 + 1386)))) then
					if v12(v25.PrimordialWave) then
						return "primordial_wave main 22";
					end
				end
				if (v25.FeralSpirit:IsCastable() and TargetInMeleeRange and IsFeralSpirit and (v25.ElementalSpirits:IsAvailable() or (v25.AlphaWolf:IsAvailable() and (v63 > (104 - (17 + 86)))))) then
					if v12(v25.FeralSpirit, true) then
						return "feral_spirit main 24";
					end
				end
				if (v25.SurgingTotem:IsReady() and IsSurgingTotem and TargetInMeleeRange) then
					if v11.CastTarget(v25.SurgingTotem, v11.TName().PLAYER) then
						return "surging_totem main 26";
					end
				end
				if (v25.Ascendance:IsCastable() and IsAscendance and TargetInMeleeRange and v7:DebuffUp(v25.FlameShockDebuff) and (((v66 == v25.LightningBolt) and (v63 == (1 + 0))) or ((v66 == v25.ChainLightning) and (v63 > (1 - 0))))) then
					if v12(v25.Ascendance) then
						return "ascendance main 28";
					end
				end
				if (v13() and (v63 > (2 - 1))) then
					v24 = v94();
					if v24 then
						return v24;
					end
				end
				if (not v13() or (v63 < (168 - (122 + 44)))) then
					v24 = v93();
					if v24 then
						return v24;
					end
				end
				if v11.CastAnnotated(v25.Pool, false, "WAIT") then
					return "Wait/Pool Resources";
				end
			end
		end
	end
end
local function v96()
	v11.ResetToggle();
	v32.Enhancement.Display();
	v25.FlameShockDebuff:RegisterAuraTracking();
	v11.ToggleIconFrame:AddButtonCustom("I", 1 - 0, "Interrupt", "interrupt");
	v11.ToggleIconFrame:AddButtonCustom("D", 6 - 4, "Dispel", "dispel");
	v11.ToggleIconFrame:AddButtonCustom("S", 3 + 0, "smallCDs", "smallcds");
	v11.ToggleIconFrame:AddButtonCustom("P", 1 + 3, "UseSpender", "usespender");
	v11.Print("Enhancement Shaman rotation has been updated for patch 11.0.2. Last Update 10.10.2024");
end
v11.SetAPL(532 - 269, v95, v96);
