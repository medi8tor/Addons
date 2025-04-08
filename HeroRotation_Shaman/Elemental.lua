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
local v14 = v13.Cast;
local v15 = v13.CastLeftNameplate;
local v16 = v13.AoEON;
local v17 = v13.CDsON;
local v18 = v13.Commons().Everyone.num;
local v19 = v13.Commons().Everyone.bool;
local v20 = GetTime;
local v21 = math.min;
local v22 = C_Timer.After;
local v23 = GetWeaponEnchantInfo;

local v24;
local v25 = v9.Shaman.Elemental;
local v26 = v11.Shaman.Elemental;
local v27 = v13.GUISettingsGet();
local v28 = {};
local v29 = v13.Commons().Everyone;
local v30 = v13.Commons().Shaman;
local v31 = {General=v27.General,Commons=v27.APL.Shaman.Commons,Elemental=v27.APL.Shaman.Elemental,Elemental_Defensives=v27.APL.Shaman.Elemental.Defensives,Elemental_TTD=v27.APL.Shaman.Elemental_TTD,Elemental_CDUSE=v27.APL.Shaman.Elemental_CDUSE};
local v32, v33;
local v34, v35;
local v36, v37;
local v38, v39;
local v40, v41;
local v42, v43;
local v44, v45;
local v46;
local v47 = (312 - 212) + ((143 - 93) * v18(v25.SwellingMaelstrom:IsAvailable())) + ((47 - 22) * v18(v25.PrimordialCapacity:IsAvailable()));
local v48 = 28620 - 17509;
local v49 = 11730 - (555 + 64);
local v50, v51;
local v52, v53;
local v54 = v9(441244 - (857 + 74));
local v55;
v30.ClusterTargets = 568 - (367 + 201);
local v57 = 927 - (214 + 713);
local function v58()
	local v86, v87 = v6:GetTrinketData(v28);
	if ((v57 < (2 + 3)) and ((v86.ID == (0 + 0)) or (v87.ID == (877 - (282 + 595))) or ((v86.SpellID > (1637 - (1523 + 114))) and not v86.Usable) or ((v87.SpellID > (0 + 0)) and not v87.Usable))) then
		v57 = v57 + (1 - 0);
		v22(1070 - (68 + 997), function()
			v58();
		end);
		return;
	end
	v32 = v86.Object;
	v33 = v87.Object;
	v34 = v86.Spell;
	v36 = v86.Range;
	v38 = v86.CastTime;
	v35 = v87.Spell;
	v37 = v87.Range;
	v39 = v87.CastTime;
	v40 = v86.Cooldown;
	v41 = v87.Cooldown;
	v42 = v86.Blacklisted;
	v43 = v87.Blacklisted;
	v44 = v86.ID == v26.SpymastersWeb:ID();
	v45 = v87.ID == v26.SpymastersWeb:ID();
end
v58();
v3:RegisterForEvent(function()
	v57 = 1270 - (226 + 1044);
	v58();
end, "PLAYER_EQUIPMENT_CHANGED");
v3:RegisterForEvent(function()
	v47 = (435 - 335) + ((167 - (32 + 85)) * v18(v25.SwellingMaelstrom:IsAvailable())) + ((25 + 0) * v18(v25.PrimordialCapacity:IsAvailable()));
	v25.PrimordialWave:RegisterInFlightEffect(72550 + 254612);
	v25.PrimordialWave:RegisterInFlight();
	v25.LavaBurst:RegisterInFlight();
end, "LEARNED_SPELL_IN_TAB");
v25.PrimordialWave:RegisterInFlightEffect(328119 - (892 + 65));
v25.PrimordialWave:RegisterInFlight();
v25.LavaBurst:RegisterInFlight();
local function v59()
	return (119 - 69) - (v20() - v30.LastRollingThunderTick);
end
local function v60(v100)
	local v101, v102;
	for v119, v120 in pairs(v100) do
		local v121 = v120:DebuffRemains(v25.FlameShockDebuff);
		if (not v101 or (v121 < v101)) then
			v101 = v121;
			v102 = v120;
		end
	end
	return v101, v102;
end
local function v61(v103)
	return v103:DebuffRemains(v25.FlameShockDebuff);
end
local function v62(v104)
	return v104:DebuffRemains(v25.LightningRodDebuff);
end
local function v63(v105)
	return (v105:DebuffDown(v25.LightningRodDebuff) and v25.LightningRod:IsAvailable()) or (v46 > (v47 - (55 - 25)));
end
local function v64(v106)
	return ((v106:DebuffRemains(v25.FlameShockDebuff) < (3 - 1)) or (v25.FlameShockDebuff:AuraActiveCount() == (350 - (87 + 263)))) and ((v106:DebuffRemains(v25.FlameShockDebuff) < v25.PrimordialWave:CooldownRemains()) or not v25.PrimordialWave:IsAvailable()) and ((v106:DebuffRemains(v25.FlameShockDebuff) < v25.LiquidMagmaTotem:CooldownRemains()) or not v25.LiquidMagmaTotem:IsAvailable());
end
local function v65(v107)
	return v107:DebuffRemains(v25.FlameShockDebuff) < (186 - (67 + 113));
end
local function v66(v108)
	return (v46 > (v47 - (11 + 4))) or (v108:DebuffRemains(v25.LightningRodDebuff) < v6:GCD()) or (v48 < (12 - 7));
end
local function v67(v109)
	return v109:DebuffRefreshable(v25.FlameShockDebuff);
end
local function v68(v110)
	return v110:DebuffUp(v25.FlameShockDebuff);
end
local function v69(v111)
	return v111:DebuffRemains(v25.FlameShockDebuff) > (2 + 0);
end
local function v70(v112)
	return v112:NPCID() == (813021 - 608461);
end
local function v71(v113)
	return v113:CastSpellID() == (409757 - (802 + 150));
end
local function v72()
	return (v12:Exists() or not v31.Elemental.CursorCheck) and not v6:IsCameraBusy();
end
local function v73()
	if v29.TargetIsValid() then
		local v122 = v8:MinDistance() or (13 - 8);
		local v123 = v8:MaxDistance() or (72 - 32);
		v122 = math.max(v122 - (6 + 2), 1002 - (915 + 82));
		v123 = math.min(v123 + (22 - 14), 24 + 16);
		local v124 = v6:GetEnemiesInRange(v122);
		local v125 = v6:GetEnemiesInRange(v123);
		local v126 = #v125;
		if ((v123 - v122) > (20 - 4)) then
			v126 = v126 - #v124;
		end
		v126 = math.max(v126, 1188 - (1069 + 118));
		return v126;
	else
		return #(v6:GetEnemiesInRange(90 - 50));
	end
end
local v74;
local v75;
local function v76(v114)
	return (v75 and v31.Elemental_TTD.IgnoreWhenBoss) or v29.Buggedmobs[v8:NPCID()] or (v29.ISSolo() and v31.Elemental_TTD.IgnoreWhenSolo) or (v114 == (0 - 0)) or ((v49 >= v114) and (v49 < (1353 + 6424)));
end
local function v77(v115)
	return (v115 ~= "Not Used") and ((((v115 == "with Cooldowns") or ((v115 == "small CDs") and v31.Elemental_CDUSE.smallcdswithCooldowns) or (v115 == "with Cooldowns or AoE") or (v115 == "on Enemycount or Cooldowns") or (v115 == "on Boss or with Cooldowns")) and v17()) or (v115 == "always") or (((v115 == "on Boss only") or (v115 == "on Boss or on Enemycount") or (v115 == "on Boss or with Cooldowns")) and (v75 or v8:IsDummy())) or ((v115 == "with Bloodlust only") and v6:BloodlustUp()) or ((v115 == "small CDs") and Smallcds) or (((v115 == "on AOE") or (v115 == "with Cooldowns or AoE")) and (v30.ClusterTargets >= (3 - 1))) or (((v115 == "on Enemycount or Cooldowns") or (v115 == "on Enemycount") or (v115 == "on Boss or on Enemycount")) and (v30.ClusterTargets >= v31.Elemental_CDUSE.Enemycount)));
end
local v78 = nil;
local function v79()
	if v6:IsMoving() then
		if not v78 then
			v78 = v20();
		end
		return v20() - v78;
	else
		if v78 then
			v78 = nil;
		end
		return 0 + 0;
	end
end
local function v80()
	if (v25.AstralShift:IsCastable() and v6:AffectingCombat() and (v6:HealthPercentage() <= v31.Elemental.Defensives.AstralShiftHP)) then
		if v14(v25.AstralShift) then
			return "AstralShift";
		end
	end
	if (v25.HealingStreamTotem:IsCastable() and v6:AffectingCombat() and (v6:HealthPercentage() <= v31.Elemental.Defensives.HealingStreamTotemHP)) then
		if v14(v25.HealingStreamTotem) then
			return "HealingStreamTotem";
		end
	end
	if (v25.StoneBulkwarkTotem:IsCastable() and v6:AffectingCombat() and (v6:HealthPercentage() <= v31.Elemental.Defensives.StoneBulkwarkTotemHP)) then
		if v14(v25.StoneBulkwarkTotem) then
			return "StoneBulkwarkTotem";
		end
	end
	if (v25.HealingSurge:IsReady() and (v6:BuffUp(v25.SpiritwalkersGraceBuff) or not v6:IsMoving()) and (v6:HealthPercentage() <= v31.Elemental.Defensives.HealingSurgeHP)) then
		if v14(v25.HealingSurge) then
			return "HealingSurge";
		end
	end
	if (v25.EarthElemental:IsCastable() and v6:AffectingCombat() and (v6:HealthPercentage() <= v31.Elemental.Defensives.EarthElemental) and IsEarthElemental) then
		if v14(v25.EarthElemental) then
			return "EarthElemental";
		end
	end
	if (v25.AncestralGuidance:IsCastable() and v6:AffectingCombat() and (v31.Elemental.Defensives.AncestralGuidanceCount ~= (791 - (368 + 423))) and (not v31.Elemental.Defensives.AncestralGuidanceHP ~= (0 - 0)) and v29.AoELogicWithCount(v31.Elemental.Defensives.AncestralGuidanceHP, v31.Elemental.Defensives.AncestralGuidanceCount, nil, v74)) then
		if v14(v25.AncestralGuidance) then
			return "AncestralGuidance";
		end
	end
end
local function v81()
	if (v25.Stormkeeper:IsViable() and IsStormkeeper) then
		if v14(v25.Stormkeeper, true) then
			return "stormkeeper precombat 2";
		end
	end
	if (v25.StormElemental:IsReady() and IsStormElemental and not v30.StormElemental.GreaterActive) then
		if v14(v25.StormElemental, true) then
			return "storm_elemental precombat 6";
		end
	end
	if (v25.Stormkeeper:IsViable() and IsStormkeeper and not v6:StormkeeperUp()) then
		if v14(v25.Stormkeeper, true) then
			return "stormkeeper precombat 8";
		end
	end
	if (v25.PrimordialWave:IsViable() and IsPrimordialWave) then
		if v14(v25.PrimordialWave) then
			return "primordial_wave precombat 10";
		end
	end
	if (v25.AncestralSwiftness:IsReady() and v6:BuffDown(v25.AncestralSwiftness)) then
		if v14(v25.AncestralSwiftness, true) then
			return "ancestral_swiftness precombat 12";
		end
	end
	if v25.LavaBurst:IsViable() then
		if v14(v25.LavaBurst) then
			return "lavaburst precombat 12";
		end
	end
end
local function v82()
	if (v25.FireElemental:IsReady() and IsFireElemental and not v30.FireElemental.GreaterActive) then
		if v14(v25.FireElemental, true) then
			return "fire_elemental aoe 2";
		end
	end
	if (v25.StormElemental:IsReady() and IsStormElemental and not v30.StormElemental.GreaterActive) then
		if v14(v25.StormElemental, true) then
			return "storm_elemental aoe 4";
		end
	end
	if (v25.Stormkeeper:IsViable() and IsStormkeeper and not v6:StormkeeperUp()) then
		if v14(v25.Stormkeeper, true) then
			return "stormkeeper aoe 6";
		end
	end
	if (v25.TotemicRecall:IsCastable() and (v25.LiquidMagmaTotem:CooldownRemains() > (33 - (10 + 8))) and ((v25.FlameShockDebuff:AuraActiveCount() < (v21(v30.ClusterTargets, 22 - 16) - (444 - (416 + 26)))) or v25.FireElemental:IsAvailable())) then
		if v14(v25.TotemicRecall, true) then
			return "totemic_recall aoe 8";
		end
	end
	if (v25.LiquidMagmaTotem:IsReady() and IsLiquidMagmaTotem) then
		if v14(v25.LiquidMagmaTotem, true) then
			return "liquid_magma_totem aoe 10";
		end
	end
	if (v25.PrimordialWave:IsViable() and IsPrimordialWave and (v6:BuffUp(v25.SurgeofPowerBuff) or not v25.SurgeofPower:IsAvailable() or (v46 < ((191 - 131) - ((3 + 2) * v18(v25.EyeoftheStorm:IsAvailable())))))) then
		if v29.CastTargetIf(v25.PrimordialWave, v53, "min", v61, nil, 70 - 30) then
			return "primordial_wave aoe 12";
		end
	end
	if (v25.AncestralSwiftness:IsReady() and v6:BuffDown(v25.AncestralSwiftness)) then
		if v14(v25.AncestralSwiftness, true) then
			return "ancestral_swiftness aoe 14";
		end
	end
	if v25.FlameShock:IsCastable() then
		local v127, v128 = v60(v53);
		if v128:DebuffRefreshable(v25.FlameShockDebuff) then
			if (v6:BuffUp(v25.SurgeofPowerBuff) and v25.LightningRod:IsAvailable() and (v127 < (v128:TimeToDie() - (454 - (145 + 293)))) and (v25.FlameShockDebuff:AuraActiveCount() < v21(v30.ClusterTargets, 436 - (44 + 386))) and not v25.LiquidMagmaTotem:IsAvailable()) then
				if (v8:GUID() == v128:GUID()) then
					if v14(v25.FlameShock) then
						return "flame_shock aoe main-target 16";
					end
				else
					if ((v12:GUID() == v128:GUID()) and v12:IsSpellInRange(v25.FlameShock)) then
						if v13.CastTarget(v25.FlameShock, v13.TName().MOUSEOVER) then
							return "FlameShock mouseover";
						end
					end
					if v15(v128, v25.FlameShock) then
						return "flame_shock aoe off-target 16";
					end
				end
			end
			if (v6:BuffUp(v25.PrimordialWaveBuff) and v6:StormkeeperUp() and (v46 < (((1546 - (998 + 488)) - ((2 + 3) * v18(v25.EyeoftheStorm:IsAvailable()))) - ((7 + 1 + ((774 - (201 + 571)) * v18(v25.FlowofPower:IsAvailable()))) * v25.FlameShockDebuff:AuraActiveCount()))) and (v30.ClusterTargets >= (1144 - (116 + 1022))) and (v25.FlameShockDebuff:AuraActiveCount() < (24 - 18))) then
				if (v8:GUID() == v128:GUID()) then
					if v14(v25.FlameShock) then
						return "flame_shock aoe main-target 18";
					end
				else
					if ((v12:GUID() == v128:GUID()) and v12:IsSpellInRange(v25.FlameShock)) then
						if v13.CastTarget(v25.FlameShock, v13.TName().MOUSEOVER) then
							return "FlameShock mouseover";
						end
					end
					if v15(v128, v25.FlameShock) then
						return "flame_shock aoe off-target 18";
					end
				end
			end
			if (v25.FireElemental:IsAvailable() and (v6:BuffUp(v25.SurgeofPowerBuff) or not v25.SurgeofPower:IsAvailable()) and (v128:DebuffRemains(v25.FlameShockDebuff) < (v128:TimeToDie() - (3 + 2))) and ((v25.FlameShockDebuff:AuraActiveCount() < (21 - 15)) or (v128:DebuffRemains(v25.FlameShockDebuff) > (0 - 0)))) then
				if (v8:GUID() == v128:GUID()) then
					if v14(v25.FlameShock) then
						return "flame_shock aoe main-target 20";
					end
				else
					if ((v12:GUID() == v128:GUID()) and v12:IsSpellInRange(v25.FlameShock)) then
						if v13.CastTarget(v25.FlameShock, v13.TName().MOUSEOVER) then
							return "FlameShock mouseover";
						end
					end
					if v15(v128, v25.FlameShock) then
						return "flame_shock aoe off-target 20";
					end
				end
			end
		end
	end
	if (v25.TempestAbility:IsReady() and UseTempest and v76(v31.Elemental_TTD.TempestTTD) and (v6:BuffUp(v25.SpiritwalkersGraceBuff) or not v6:IsMoving()) and not v6:IsCasting(v25.TempestAbility) and (v6:BuffDown(v25.ArcDischargeBuff))) then
		if v14(v25.LightningBolt) then
			return "TempestAbility aoe 22";
		end
	end
	if (v25.Ascendance:IsCastable() and IsAscendance) then
		if v14(v25.Ascendance, true) then
			return "ascendance aoe 32";
		end
	end
	if (v25.LavaBeam:IsViable() and (v30.ClusterTargets >= (865 - (814 + 45))) and v6:BuffUp(v25.SurgeofPowerBuff) and (v6:BuffRemains(v25.AscendanceBuff) > v25.LavaBeam:CastTime())) then
		if v14(v25.LavaBeam) then
			return "lava_beam aoe 34";
		end
	end
	if (v25.ChainLightning:IsViable() and (v30.ClusterTargets >= (14 - 8)) and v6:BuffUp(v25.SurgeofPowerBuff)) then
		if v14(v25.ChainLightning) then
			return "chain_lightning aoe 36";
		end
	end
	if (v25.LavaBurst:IsViable() and v6:BuffUp(v25.PrimordialWaveBuff) and v6:StormkeeperUp() and (v46 < ((4 + 56) - ((2 + 3) * v18(v25.EyeoftheStorm:IsAvailable())))) and (v30.ClusterTargets >= (891 - (261 + 624))) and v25.SurgeofPower:IsAvailable()) then
		if v29.CastCycle(v25.LavaBurst, v53, v69, 71 - 31) then
			return "lava_burst aoe 38";
		end
	end
	if (v25.LavaBurst:IsViable() and v6:BuffUp(v25.PrimordialWaveBuff) and ((v6:BuffRemains(v25.PrimordialWaveBuff) < (1084 - (1020 + 60))) or v6:BuffUp(v25.LavaSurgeBuff))) then
		if v29.CastCycle(v25.LavaBurst, v53, v69, 1463 - (630 + 793)) then
			return "lava_burst aoe 40";
		end
	end
	if (v25.LavaBurst:IsViable() and v6:BuffUp(v25.LavaSurgeBuff) and not v6:MotEUp() and v25.MasteroftheElements:IsAvailable() and v25.FireElemental:IsAvailable()) then
		if v29.CastCycle(v25.LavaBurst, v53, v68, 135 - 95) then
			return "lava_burst aoe 42";
		end
	end
	if (v25.Earthquake:IsReady() and UseSpender and v8:IsInRange(189 - 149) and Cursorcheck and (v25.PrimordialWave:CooldownRemains() < v6:GCD()) and v25.SurgeofPower:IsAvailable() and (v6:BuffUp(v25.EchoesofGreatSunderingBuff) or not v25.EchoesofGreatSundering:IsAvailable())) then
		if v14(v25.Earthquakecast) then
			return "earthquake aoe 44";
		end
	end
	if (v25.Earthquake:IsReady() and UseSpender and v8:IsInRange(16 + 24) and Cursorcheck and (((v25.LightningRodDebuff:AuraActiveCount() == (0 - 0)) and v25.LightningRod:IsAvailable()) or (v46 > (v47 - (1777 - (760 + 987))))) and (v6:BuffUp(v25.EchoesofGreatSunderingBuff) or not v25.EchoesofGreatSundering:IsAvailable())) then
		if v14(v25.Earthquakecast) then
			return "earthquake aoe 46";
		end
	end
	if (v25.Earthquake:IsReady() and UseSpender and v8:IsInRange(1953 - (1789 + 124)) and Cursorcheck and v6:StormkeeperUp() and (v30.ClusterTargets >= (772 - (745 + 21))) and v25.SurgeofPower:IsAvailable() and (v6:BuffUp(v25.EchoesofGreatSunderingBuff) or not v25.EchoesofGreatSundering:IsAvailable())) then
		if v14(v25.Earthquakecast) then
			return "earthquake aoe 48";
		end
	end
	if (v25.Earthquake:IsReady() and UseSpender and v8:IsInRange(14 + 26) and Cursorcheck and (v6:MotEUp() or (v30.ClusterTargets >= (13 - 8))) and (v6:BuffUp(v25.FusionofElementsNature) or (v6:BuffRemains(v25.AscendanceBuff) > (35 - 26)) or v6:BuffDown(v25.AscendanceBuff)) and (v6:BuffUp(v25.EchoesofGreatSunderingBuff) or not v25.EchoesofGreatSundering:IsAvailable()) and v25.FireElemental:IsAvailable()) then
		if v14(v25.Earthquakecast) then
			return "earthquake aoe 50";
		end
	end
	if (v25.ElementalBlast:IsViable() and UseSpender and v25.EchoesofGreatSundering:IsAvailable() and v6:BuffDown(v25.EchoesofGreatSunderingBuff) and ((v25.LightningRodDebuff:AuraActiveCount() == (0 + 0)) or (v46 > (v47 - (24 + 6))))) then
		if v14(v25.ElementalBlast) then
			return "elemental_blast aoe 52";
		end
	end
	if (v25.EarthShock:IsReady() and UseSpender and v25.EchoesofGreatSundering:IsAvailable() and v6:BuffDown(v25.EchoesofGreatSunderingBuff) and ((v25.LightningRodDebuff:AuraActiveCount() == (1055 - (87 + 968))) or (v46 > (v47 - (132 - 102))))) then
		if v14(v25.EarthShock) then
			return "earth_shock aoe 54";
		end
	end
	if (v25.Icefury:IsViable() and v25.FusionofElements:IsAvailable() and not (v6:BuffUp(v25.FusionofElementsNature) or v6:BuffUp(v25.FusionofElementsFire))) then
		if v14(v25.Icefury) then
			return "icefury aoe 56";
		end
	end
	if (v25.LavaBurst:IsViable() and v25.MasteroftheElements:IsAvailable() and not v6:MotEUp() and v6:BuffDown(v25.AscendanceBuff) and v25.FireElemental:IsAvailable()) then
		if v29.CastCycle(v25.LavaBurst, v53, v69, 37 + 3) then
			return "lava_burst aoe 58";
		end
	end
	if (v25.LavaBeam:IsViable() and v6:StormkeeperUp() and (v6:BuffUp(v25.SurgeofPowerBuff) or (v30.ClusterTargets < (13 - 7)))) then
		if v14(v25.LavaBeam) then
			return "lava_beam aoe 60";
		end
	end
	if (v25.ChainLightning:IsViable() and v6:StormkeeperUp() and (v6:BuffUp(v25.SurgeofPowerBuff) or (v30.ClusterTargets < (1419 - (447 + 966))))) then
		if v14(v25.ChainLightning) then
			return "chain_lightning aoe 62";
		end
	end
	if (v25.LavaBeam:IsViable() and v6:PotMUp() and (v6:BuffRemains(v25.AscendanceBuff) > v25.LavaBeam:CastTime()) and not v6:StormkeeperUp()) then
		if v14(v25.LavaBeam) then
			return "lava_beam aoe 64";
		end
	end
	if (v25.ChainLightning:IsViable() and v6:PotMUp() and not v6:StormkeeperUp()) then
		if v14(v25.ChainLightning) then
			return "chain_lightning aoe 66";
		end
	end
	if (v25.LavaBeam:IsViable() and ((v6:MotEUp() and (v30.ClusterTargets >= (10 - 6))) or (v30.ClusterTargets >= (1822 - (1703 + 114)))) and (v6:BuffRemains(v25.AscendanceBuff) > v25.LavaBeam:CastTime()) and not v6:StormkeeperUp()) then
		if v14(v25.LavaBeam) then
			return "lava_beam aoe 68";
		end
	end
	if (v25.LavaBurst:IsViable() and (v25.DeeplyRootedElements:IsAvailable())) then
		if v29.CastCycle(v25.LavaBurst, v53, v69, 741 - (376 + 325)) then
			return "lava_burst aoe 70";
		end
	end
	if (v25.LavaBeam:IsViable() and (v6:BuffRemains(v25.AscendanceBuff) > v25.LavaBeam:CastTime())) then
		if v14(v25.LavaBeam) then
			return "lava_beam aoe 72";
		end
	end
	if v25.ChainLightning:IsViable() then
		if v14(v25.ChainLightning) then
			return "chain_lightning aoe 74";
		end
	end
	if (v25.FlameShock:IsCastable() and v6:IsMoving()) then
		if v29.CastCycle(v25.FlameShock, v53, v67, 65 - 25) then
			return "flame_shock moving aoe 76";
		end
	end
	if (v25.FrostShock:IsCastable() and v6:IsMoving()) then
		if v14(v25.FrostShock) then
			return "frost_shock moving aoe 78";
		end
	end
end
local function v83()
	if (v25.FireElemental:IsCastable() and IsFireElemental and not v30.FireElemental.GreaterActive) then
		if v14(v25.FireElemental, true) then
			return "fire_elemental single_target 2";
		end
	end
	if (v25.StormElemental:IsCastable() and IsStormElemental and not v30.StormElemental.GreaterActive) then
		if v14(v25.StormElemental, true) then
			return "storm_elemental single_target 4";
		end
	end
	if (v25.Stormkeeper:IsViable() and IsStormkeeper and v6:BuffDown(v25.AscendanceBuff) and not v6:StormkeeperUp()) then
		if v14(v25.Stormkeeper, true) then
			return "stormkeeper single_target 6";
		end
	end
	if (v25.TotemicRecall:IsCastable() and (v25.LiquidMagmaTotem:CooldownRemains() > (45 - 30)) and (v30.ClusterTargets > (1 + 0)) and v25.FireElemental:IsAvailable()) then
		if v14(v25.TotemicRecall, true) then
			return "totemic_recall single_target 8";
		end
	end
	if (v25.LiquidMagmaTotem:IsCastable() and v8:IsInRange(88 - 48) and IsLiquidMagmaTotem and v6:BuffDown(v25.AscendanceBuff) and (v25.FireElemental:IsAvailable() or (v30.ClusterTargets > (15 - (9 + 5))))) then
		if v14(v25.LiquidMagmaTotem, true) then
			return "liquid_magma_totem single_target 10";
		end
	end
	if (v25.PrimordialWave:IsViable() and IsPrimordialWave and ((v30.ClusterTargets == (377 - (85 + 291))) or v6:BuffUp(v25.SurgeofPowerBuff) or not v25.SurgeofPower:IsAvailable() or (v46 < ((1325 - (243 + 1022)) - ((19 - 14) * v18(v25.EyeoftheStorm:IsAvailable())))) or v25.LiquidMagmaTotem:IsAvailable())) then
		if v29.CastTargetIf(v25.PrimordialWave, v53, "min", v61, nil, 33 + 7) then
			return "primordial_wave single_target 12";
		end
	end
	if (v25.AncestralSwiftness:IsReady() and v6:BuffDown(v25.AncestralSwiftness) and (v6:BuffDown(v25.PrimordialWaveBuff) or not v6:StormkeeperUp() or not v25.ElementalBlast:IsAvailable())) then
		if v14(v25.AncestralSwiftness, true) then
			return "ancestral_swiftness single_target 14";
		end
	end
	if (v25.FlameShock:IsCastable() and (v30.ClusterTargets == (1181 - (1123 + 57))) and ((v8:DebuffRemains(v25.FlameShockDebuff) < (2 + 0)) or (v25.FlameShockDebuff:AuraActiveCount() == (254 - (163 + 91)))) and ((v8:DebuffRemains(v25.FlameShockDebuff) < v25.PrimordialWave:CooldownRemains()) or not v25.PrimordialWave:IsAvailable()) and ((v8:DebuffRemains(v25.FlameShockDebuff) < v25.LiquidMagmaTotem:CooldownRemains()) or not v25.LiquidMagmaTotem:IsAvailable()) and v6:BuffDown(v25.SurgeofPowerBuff) and v25.FireElemental:IsAvailable()) then
		if v14(v25.FlameShock) then
			return "flame_shock single_target 16";
		end
	end
	if (v25.FlameShock:IsCastable() and (v25.FlameShockDebuff:AuraActiveCount() < v30.ClusterTargets) and (v30.ClusterTargets > (1931 - (1869 + 61))) and (v25.DeeplyRootedElements:IsAvailable() or v25.Ascendance:IsAvailable() or v25.PrimordialWave:IsAvailable() or v25.SearingFlames:IsAvailable() or v25.MagmaChamber:IsAvailable()) and ((v6:BuffDown(v25.SurgeofPowerBuff) and v6:StormkeeperUp()) or not v25.SurgeofPower:IsAvailable() or (v25.Ascendance:CooldownUp() and v25.Ascendance:IsAvailable())) and not v25.LiquidMagmaTotem:IsAvailable()) then
		if v29.CastTargetIf(v25.FlameShock, v53, "min", v61, nil, 12 + 28) then
			return "flame_shock single_target 18";
		end
	end
	if (v25.FlameShock:IsCastable() and (v30.ClusterTargets > (3 - 2)) and (v25.DeeplyRootedElements:IsAvailable() or v25.Ascendance:IsAvailable() or v25.PrimordialWave:IsAvailable() or v25.SearingFlames:IsAvailable() or v25.MagmaChamber:IsAvailable()) and ((v6:BuffUp(v25.SurgeofPowerBuff) and not v6:StormkeeperUp()) or not v25.SurgeofPower:IsAvailable()) and v25.FireElemental:IsAvailable()) then
		if v29.CastTargetIf(v25.FlameShock, v53, "min", v61, v65, 61 - 21) then
			return "flame_shock single_target 20";
		end
	end
	if (v25.TempestAbility:IsReady() and UseTempest and v76(v31.Elemental_TTD.TempestTTD) and (v6:BuffUp(v25.SpiritwalkersGraceBuff) or not v6:IsMoving()) and not v6:IsCasting(v25.TempestAbility)) then
		if v14(v25.LightningBolt) then
			return "tempest single_target 22";
		end
	end
	if (v25.LightningBolt:IsViable() and v6:StormkeeperUp() and v6:BuffUp(v25.SurgeofPowerBuff)) then
		if v14(v25.LightningBolt) then
			return "lightning_bolt single_target 24";
		end
	end
	if (v25.LavaBurst:IsViable() and v6:StormkeeperUp() and not v6:MotEUp() and not v25.SurgeofPower:IsAvailable() and v25.MasteroftheElements:IsAvailable()) then
		if v29.CastCycle(v25.LavaBurst, v53, v69, 6 + 34) then
			return "lava_burst single_target 26";
		end
	end
	if (v25.LightningBolt:IsViable() and v6:StormkeeperUp() and not v25.SurgeofPower:IsAvailable() and (v6:MotEUp() or not v25.MasteroftheElements:IsAvailable())) then
		if v14(v25.LightningBolt) then
			return "lightning_bolt single_target 28";
		end
	end
	if (v25.LightningBolt:IsViable() and v6:BuffUp(v25.SurgeofPowerBuff) and v6:BuffDown(v25.AscendanceBuff) and v25.EchoChamber:IsAvailable()) then
		if v14(v25.LightningBolt) then
			return "lightning_bolt single_target 30";
		end
	end
	if (v25.Ascendance:IsCastable() and IsAscendance and (v25.LavaBurst:ChargesFractional() < (1 - 0))) then
		if v14(v25.Ascendance, true) then
			return "ascendance single_target 32";
		end
	end
	if (v25.LavaBurst:IsViable() and v6:BuffUp(v25.LavaSurgeBuff) and v25.FireElemental:IsAvailable()) then
		if v29.CastCycle(v25.LavaBurst, v53, v68, 38 + 2) then
			return "lava_burst single_target 34";
		end
	end
	if (v25.LavaBurst:IsViable() and (v6:BuffUp(v25.PrimordialWaveBuff))) then
		if v29.CastCycle(v25.LavaBurst, v53, v69, 1514 - (1329 + 145)) then
			return "lava_burst single_target 36";
		end
	end
	if (v25.Earthquake:IsReady() and UseSpender and v8:IsInRange(1011 - (140 + 831)) and Cursorcheck and v6:MotEUp() and (v6:BuffUp(v25.EchoesofGreatSunderingBuff) or ((v30.ClusterTargets > (1851 - (1409 + 441))) and not v25.EchoesofGreatSundering:IsAvailable() and not v25.ElementalBlast:IsAvailable())) and (v6:BuffUp(v25.FusionofElementsNature) or (v46 > (v47 - (733 - (15 + 703)))) or (v6:BuffRemains(v25.AscendanceBuff) > (5 + 4)) or v6:BuffDown(v25.AscendanceBuff)) and v25.FireElemental:IsAvailable()) then
		if v14(v25.Earthquakecast) then
			return "earthquake single_target 38";
		end
	end
	if (v25.ElementalBlast:IsViable() and UseSpender and v6:MotEUp() and (v6:BuffUp(v25.FusionofElementsNature) or v6:BuffUp(v25.FusionofElementsFire) or (v46 > (v47 - (453 - (262 + 176)))) or (v6:BuffRemains(v25.AscendanceBuff) > (1727 - (345 + 1376))) or v6:BuffDown(v25.AscendanceBuff)) and v25.FireElemental:IsAvailable()) then
		if v14(v25.ElementalBlast) then
			return "elemental_blast single_target 40";
		end
	end
	if (v25.EarthShock:IsReady() and UseSpender and v6:MotEUp() and (v6:BuffUp(v25.FusionofElementsNature) or (v46 > (v47 - (703 - (198 + 490)))) or (v6:BuffRemains(v25.AscendanceBuff) > (39 - 30)) or v6:BuffDown(v25.AscendanceBuff)) and v25.FireElemental:IsAvailable()) then
		if v14(v25.EarthShock) then
			return "earth_shock single_target 42";
		end
	end
	if (v25.Earthquake:IsReady() and UseSpender and v8:IsInRange(95 - 55) and Cursorcheck and (v6:BuffUp(v25.EchoesofGreatSunderingBuff) or ((v30.ClusterTargets > (1207 - (696 + 510))) and not v25.EchoesofGreatSundering:IsAvailable() and not v25.ElementalBlast:IsAvailable())) and (v6:StormkeeperUp() or ((v25.PrimordialWave:CooldownRemains() < v6:GCD()) and v25.SurgeofPower:IsAvailable() and not v25.LiquidMagmaTotem:IsAvailable())) and v25.StormElemental:IsAvailable()) then
		if v14(v25.Earthquakecast) then
			return "earthquake single_target 44";
		end
	end
	if (v25.ElementalBlast:IsViable() and UseSpender and v6:StormkeeperUp() and v25.StormElemental:IsAvailable()) then
		if v14(v25.ElementalBlast) then
			return "elemental_blast single_target 46";
		end
	end
	if (v25.EarthShock:IsReady() and UseSpender and (((v6:MotEUp() or (v25.LightningRodDebuff:AuraActiveCount() == (0 - 0))) and (v25.Stormkeeper:CooldownRemains() > (1272 - (1091 + 171))) and ((v59() > (1 + 4)) or not v25.RollingThunder:IsAvailable())) or v6:StormkeeperUp()) and v25.StormElemental:IsAvailable() and (v30.ClusterTargets == (3 - 2))) then
		if v14(v25.EarthShock) then
			return "earth_shock single_target 48";
		end
	end
	if (v25.EarthShock:IsReady() and UseSpender and (((v25.PrimordialWave:CooldownRemains() < v6:GCD()) and v25.SurgeofPower:IsAvailable() and not v25.LiquidMagmaTotem:IsAvailable()) or v6:StormkeeperUp()) and v25.StormElemental:IsAvailable() and (v30.ClusterTargets > (3 - 2)) and v25.EchoesofGreatSundering:IsAvailable() and v6:BuffDown(v25.EchoesofGreatSunderingBuff)) then
		if v14(v25.EarthShock) then
			return "earth_shock single_target 49";
		end
	end
	if (v25.Icefury:IsViable() and not (v6:BuffUp(v25.FusionofElementsNature) or v6:BuffUp(v25.FusionofElementsFire)) and (v6:BuffStack(v25.IcefuryBuff) == (376 - (123 + 251))) and (v25.FusionofElements:IsAvailable() or v6:BuffDown(v25.AscendanceBuff))) then
		if v14(v25.Icefury) then
			return "icefury single_target 50";
		end
	end
	if (v25.LavaBurst:IsViable() and (v6:BuffUp(v25.AscendanceBuff))) then
		if v29.CastCycle(v25.LavaBurst, v53, v69, 198 - 158) then
			return "lava_burst single_target 52";
		end
	end
	if (v25.LavaBurst:IsViable() and v25.MasteroftheElements:IsAvailable() and not v6:MotEUp() and v25.FireElemental:IsAvailable()) then
		if v29.CastCycle(v25.LavaBurst, v53, v69, 738 - (208 + 490)) then
			return "lava_burst single_target 54";
		end
	end
	if (v25.LavaBurst:IsViable() and v6:StormkeeperUp() and v25.ElementalReverb:IsAvailable() and v25.EarthShock:IsAvailable() and (v3.CombatTime() < (1 + 9))) then
		if v29.CastCycle(v25.LavaBurst, v53, v69, 18 + 22) then
			return "lava_burst single_target 56";
		end
	end
	if (v25.Earthquake:IsReady() and UseSpender and Cursorcheck and (v6:BuffUp(v25.EchoesofGreatSunderingBuff) or ((v30.ClusterTargets > (837 - (660 + 176))) and not v25.EchoesofGreatSundering:IsAvailable() and not v25.ElementalBlast:IsAvailable())) and ((v46 > (v47 - (5 + 30))) or (v48 < (207 - (14 + 188))))) then
		if v14(v25.Earthquakecast) then
			return "earthquake single_target 58";
		end
	end
	if (v25.ElementalBlast:IsViable() and UseSpender and ((v46 > (v47 - (690 - (534 + 141)))) or (v48 < (3 + 2)))) then
		if v14(v25.ElementalBlast) then
			return "elemental_blast single_target 60";
		end
	end
	if (v25.EarthShock:IsReady() and UseSpender and ((v46 > (v47 - (14 + 1))) or (v48 < (5 + 0)))) then
		if v14(v25.EarthShock) then
			return "earth_shock single_target 62";
		end
	end
	if (v25.LightningBolt:IsViable() and (v6:BuffUp(v25.SurgeofPowerBuff))) then
		if v14(v25.LightningBolt) then
			return "lightning_bolt single_target 64";
		end
	end
	if (v25.Icefury:IsViable() and not (v6:BuffUp(v25.FusionofElementsNature) or v6:BuffUp(v25.FusionofElementsFire))) then
		if v14(v25.Icefury) then
			return "icefury single_target 66";
		end
	end
	if (v25.FrostShock:IsCastable() and v6:IcefuryUp() and ((v30.ClusterTargets == (1 - 0)) or (v6:StormkeeperUp() and v25.SurgeofPower:IsAvailable()))) then
		if v14(v25.FrostShock) then
			return "frost_shock single_target 68";
		end
	end
	if (v25.ChainLightning:IsViable() and v6:PotMUp() and (v30.ClusterTargets > (1 - 0)) and not v6:StormkeeperUp()) then
		if v14(v25.ChainLightning) then
			return "chain_lightning single_target 70";
		end
	end
	if (v25.LightningBolt:IsViable() and v6:PotMUp() and not v6:StormkeeperUp()) then
		if v14(v25.LightningBolt) then
			return "lightning_bolt single_target 72";
		end
	end
	if (v25.LavaBurst:IsViable() and (v25.DeeplyRootedElements:IsAvailable())) then
		if v29.CastCycle(v25.LavaBurst, v53, v69, 112 - 72) then
			return "lava_burst single_target 74";
		end
	end
	if (v25.ChainLightning:IsViable() and (v30.ClusterTargets > (1 + 0)) and not v6:StormkeeperUp()) then
		if v14(v25.ChainLightning) then
			return "chain_lightning single_target 76";
		end
	end
	if v25.LightningBolt:IsViable() then
		if v14(v25.LightningBolt) then
			return "lightning_bolt single_target 78";
		end
	end
	if (v25.FlameShock:IsCastable() and (v6:IsMoving())) then
		if v29.CastCycle(v25.FlameShock, v53, v67, 26 + 14) then
			return "flame_shock single_target 80";
		end
	end
	if v25.FlameShock:IsCastable() then
		if v14(v25.FlameShock) then
			return "flame_shock single_target 82";
		end
	end
	if v25.FrostShock:IsCastable() then
		if v14(v25.FrostShock) then
			return "frost_shock single_target 84";
		end
	end
end
local function v84()
	if v29.ShouldStopCastUpdate() then
		v13.CastMacro(402 - (115 + 281), true);
		return "Stop Cast For Silence";
	end
	InterruptToggle = v13.ToggleIconFrame:GetToggle(2 - 1);
	DispelToggle = v13.ToggleIconFrame:GetToggle(2 + 0);
	Smallcds = v13.ToggleIconFrame:GetToggle(7 - 4);
	UseSpender = v13.ToggleIconFrame:GetToggle(14 - 10);
	UseTempest = v13.ToggleIconFrame:GetToggle(872 - (550 + 317));
	v79();
	local v116 = not v6:AffectingCombat() or not v8:AffectingCombat() or v8:IsDummy();
	v52 = v6:GetEnemiesInRange(57 - 17);
	EnemiesRangeOOCCount = v73() or #v52;
	v74 = v29.UnitsinRange(v25.HealingSurge);
	v53 = v8:GetEnemiesInSplashRange(14 - 4);
	if v16() then
		v30.ClusterTargets = EnemiesRangeOOCCount;
	else
		v30.ClusterTargets = 2 - 1;
	end
	if (v31.Elemental.ForceAOE and v16()) then
		v30.ClusterTargets = 384 - (134 + 151);
	end
	if (v25.PoisonCleansingTotem:IsAvailable() and v25.PoisonCleansingTotem:IsReady()) then
		v55 = v29.DebuffCount(v74, v54);
	else
		v55 = 1665 - (970 + 695);
	end
	Cursorcheck = (v72() and v25.Earthquake1:IsAvailable()) or v25.Earthquake2:IsAvailable();
	IsRacials = v76(v31.Elemental_TTD.RacialsTTD) and v77(v31.Elemental_CDUSE.Racials);
	IsPotions = v76(v31.Elemental_TTD.PotionsTTD) and (v31.Elemental_CDUSE.Potionswhensolo or (not v31.Elemental_CDUSE.Potionswhensolo and not v29.ISSolo())) and v77(v31.Elemental_CDUSE.Potions);
	IsTrinket1 = v76(v31.Elemental_TTD.TrinketsTTD) and v77(v31.Elemental_CDUSE.Trinket1);
	IsTrinket2 = v76(v31.Elemental_TTD.TrinketsTTD) and v77(v31.Elemental_CDUSE.Trinket2);
	IsAscendance = v76(v31.Elemental_TTD.AscendanceTTD) and v77(v31.Elemental_CDUSE.Ascendance);
	IsNaturesSwiftness = v77(v31.Elemental_CDUSE.NaturesSwiftness);
	IsEarthElemental = v77(v31.Elemental_CDUSE.EarthElemental);
	IsFireElemental = v76(v31.Elemental_TTD.FireElementalTTD) and v77(v31.Elemental_CDUSE.FireElemental);
	IsStormElemental = v76(v31.Elemental_TTD.FireElementalTTD) and v77(v31.Elemental_CDUSE.StormElemental);
	IsStormkeeper = v76(v31.Elemental_TTD.StormkeeperTTD) and v77(v31.Elemental_CDUSE.Stormkeeper);
	IsLiquidMagmaTotem = v72() and v76(v31.Elemental_TTD.LiquidMagmaTotemTTD) and v77(v31.Elemental_CDUSE.LiquidMagmaTotem);
	IsPrimordialWave = v76(v31.Elemental_TTD.PrimordialWaveTTD) and v77(v31.Elemental_CDUSE.PrimordialWave);
	if (v29.TargetIsValid() or v6:AffectingCombat()) then
		TargetinRange = v8:IsInRange(76 - 36);
		TargetinkickRange = v8:IsSpellInRange(v25.WindShear);
		v48 = v3.BossFightRemains();
		v75 = true;
		v49 = v48;
		if (v49 == (13101 - (582 + 1408))) then
			v75 = false;
			v49 = v3.FightRemains(v53, false);
		end
		v46 = v6:MaelstromP();
	end
	if ((v31.Commons.AutoWolf == "always") or ((v31.Commons.AutoWolf == "Only in Combat") and v6:AffectingCombat()) or ((v31.Commons.AutoWolf == "Only out of combat") and not v6:AffectingCombat())) then
		if (v6:IsMoving() and not v6:IsMounted() and v6:BuffDown(v25.GhostWolf) and not v6:AffectingCombat()) then
			v14(v25.GhostWolf);
			return "Ghost Wolf";
		end
		if (v6:IsMoving() and not v6:IsMounted() and v6:BuffDown(v25.GhostWolf) and v6:AffectingCombat() and (v79() > (3 - 2)) and (not v8:IsInRange(50 - 10) or not v29.TargetIsValid())) then
			v14(v25.GhostWolf);
			return "Ghost Wolf";
		end
	end
	v50, v51 = v23();
	if (v25.ImprovedFlametongueWeapon:IsAvailable() and (not v50 or (v51 < (2261014 - 1661014))) and v25.FlametongueWeapon:IsCastable()) then
		if v14(v25.FlametongueWeapon) then
			return "flametongue_weapon enchant";
		end
	end
	local v117 = select(1832 - (1195 + 629), v23());
	if (v25.ThunderstrikeWard:IsReady() and (not v117 or (v117 ~= (10033 - 2446)))) then
		if v14(v25.ThunderstrikeWard) then
			return "thunderstrike_ward";
		end
	end
	if (v25.SkyFury:IsReady() and (v6:Level() >= (257 - (187 + 54))) and not v6:DebuffUp(v25.Corruption) and ((v29.GroupBuffMissing(v25.SkyFuryBuff) and (v31.Commons.SkyFury == "check whole group") and (v6:IsInRaidArea() or v6:IsInDungeonArea())) or (v6:BuffDown(v25.SkyFuryBuff, true) and ((v31.Commons.SkyFury == "only check us") or (v31.Commons.SkyFury == "check whole group")))) and not v6:IsMounted()) then
		if v13.CastTarget(v25.SkyFury, v13.TName().PLAYER) then
			return "SkyFury";
		end
	end
	v24 = v29.IncorpCycle(v25.Hex, 810 - (162 + 618), false, false);
	if v24 then
		return v24;
	end
	if DispelToggle then
		v24 = v29.PurgeCycle(v25.Purge, 29 + 11, false, v31.Commons.TabForPurge);
		if v24 then
			return v24;
		end
		if (v25.CleanseSpirit:IsCastable() and v6:IsInDungeonArea() and v6:IsInParty()) then
			v24 = v29.DispelCycle(v25.CleanseSpirit, "Curse", nil, v74);
			if v24 then
				return v24;
			end
		end
		if (v25.PoisonCleansingTotem:IsAvailable() and v25.PoisonCleansingTotem:IsReady()) then
			if v29.DispelCycle(v25.PoisonCleansingTotem, "Poison", nil, v74) then
				return v13.CastTarget(v25.PoisonCleansingTotem);
			end
			if ((v55 > (1 + 0)) or (v25.CleanseSpirit:CooldownDown() and (v55 > (0 - 0)))) then
				return v13.CastTarget(v25.PoisonCleansingTotem);
			end
		end
	end
	local v118 = ((v25.ElementalOrbit:IsAvailable()) and v25.EarthShieldSelfBuff) or v25.EarthShieldOtherBuff;
	if (((v31.Elemental.Defensives.Earthshieldooc and not v6:AffectingCombat()) or not v31.Elemental.Defensives.Earthshieldooc) and (v25.ElementalOrbit:IsAvailable() or v31.Elemental.PreferEarthShield) and v25.EarthShield:IsReady() and (v6:BuffDown(v118) or (not v6:AffectingCombat() and (v6:BuffStack(v118) < (8 - 3))))) then
		if v13.CastTarget(v25.EarthShield, v13.TName().PLAYER) then
			return "EarthShield";
		end
	elseif (((v31.Elemental.Defensives.Earthshieldooc and not v6:AffectingCombat()) or not v31.Elemental.Defensives.Earthshieldooc) and (v25.ElementalOrbit:IsAvailable() or not v31.Elemental.PreferEarthShield or not v25.EarthShield:IsAvailable()) and v25.LightningShield:IsReady() and v6:BuffDown(v25.LightningShield)) then
		if v14(v25.LightningShield) then
			return "Lightning Shield Refresh";
		end
	end
	v24 = v80();
	if v24 then
		return v24;
	end
	if v29.TargetIsValid() then
		if (not v31.Elemental.AttackonlyinCombat or (v31.Elemental.AttackonlyinCombat and v8:AffectingCombat())) then
			if not v70(v5.Target) then
				if InterruptToggle then
					v24 = v29.InterruptCycle(v25.WindShear, 3 + 27, true, nil, false);
					if v24 then
						return v24;
					end
				end
				if TargetinRange then
					if not v6:AffectingCombat() then
						v24 = v81();
						if v24 then
							return v24;
						end
					end
					if (v25.BloodFury:IsCastable() and IsRacials and (not v25.Ascendance:IsAvailable() or v6:BuffUp(v25.AscendanceBuff) or (v25.Ascendance:CooldownRemains() > (1686 - (1373 + 263))))) then
						if v14(v25.BloodFury, true) then
							return "blood_fury main 2";
						end
					end
					if (v25.Berserking:IsCastable() and IsRacials and (not v25.Ascendance:IsAvailable() or v6:BuffUp(v25.AscendanceBuff))) then
						if v14(v25.Berserking, true) then
							return "berserking main 4";
						end
					end
					if (v25.Fireblood:IsCastable() and IsRacials and (not v25.Ascendance:IsAvailable() or v6:BuffUp(v25.AscendanceBuff) or (v25.Ascendance:CooldownRemains() > (1050 - (451 + 549))))) then
						if v14(v25.Fireblood, true) then
							return "fireblood main 6";
						end
					end
					if (v25.AncestralCall:IsCastable() and IsRacials and (not v25.Ascendance:IsAvailable() or v6:BuffUp(v25.AscendanceBuff) or (v25.Ascendance:CooldownRemains() > (16 + 34)))) then
						if v14(v25.AncestralCall, true) then
							return "ancestral_call main 8";
						end
					end
					if v31.Commons.Enabled.Trinkets then
						if (v32:IsReady() and v8:IsInRange(v36) and IsTrinket1 and not v42 and (not v44 or (((v48 < (70 - 25)) or ((v3.CombatTime() < v49) and (v6:BuffStack(v25.SpymastersWebBuff) == (67 - 27)))) and (v25.Stormkeeper:CooldownRemains() < (1389 - (746 + 638)))) or (v48 < (9 + 13)))) then
							if v14(v32, true) then
								return "use_item trinket1 (" .. v32:Name() .. ") main 10";
							end
						end
						if (v33:IsReady() and v8:IsInRange(v37) and IsTrinket2 and not v43 and (not v45 or (((v48 < (68 - 23)) or ((v3.CombatTime() < v49) and (v6:BuffStack(v25.SpymastersWebBuff) == (381 - (218 + 123))))) and (v25.Stormkeeper:CooldownRemains() < (1586 - (1535 + 46)))) or (v48 < (22 + 0)))) then
							if v14(v33, true) then
								return "use_item trinket2 (" .. v33:Name() .. ") main 12";
							end
						end
					end
					if v31.Commons.Enabled.Items then
						local v132, v133, v134 = v6:GetUseableItems(v28, 3 + 13);
						if (v132 and v8:IsInRange(v134)) then
							v13.CastMacro(561 - (306 + 254), true, nil, v132);
							return "weapon cast";
						end
					end
					if (v25.NaturesSwiftness:IsCastable() and v6:BuffDown(v25.NaturesSwiftness) and IsNaturesSwiftness) then
						if v14(v25.NaturesSwiftness, true) then
							return "natures_swiftness main 12";
						end
					end
					if (v25.AncestralSwiftness:IsReady() and v6:BuffDown(v25.AncestralSwiftness)) then
						if v14(v25.AncestralSwiftness, true) then
							return "ancestral_swiftness main 14";
						end
					end
					if v31.Commons.Enabled.Potions then
						local v135 = v29.PotionSelected();
						if (v135 and v135:IsReady() and IsPotions) then
							v13.CastMacro(1 + 2, nil, nil, v135);
							return "Cast Potion";
						end
					end
					if (v16() and (v30.ClusterTargets > (3 - 1))) then
						v24 = v82();
						if v24 then
							return v24;
						end
						if v13.CastAnnotated(v25.Pool, false, "POOL") then
							return "Pool for Aoe()";
						end
					end
					v24 = v83();
					if v24 then
						return v24;
					end
					if v13.CastAnnotated(v25.Pool, false, "POOL") then
						return "Pool for SingleTarget()";
					end
				end
			end
		end
	end
end
local function v85()
	v13.ResetToggle();
	v31.Elemental.Display();
	v25.FlameShockDebuff:RegisterAuraTracking();
	v25.LightningRodDebuff:RegisterAuraTracking();
	v13:UpdateMacro("macro1", "/use 16");
	v13:UpdateMacro("macro6", "/stopcasting");
	v13.ToggleIconFrame:AddButtonCustom("I", 1468 - (899 + 568), "Interrupt", "interrupt");
	v13.ToggleIconFrame:AddButtonCustom("D", 2 + 0, "Dispel", "dispel");
	v13.ToggleIconFrame:AddButtonCustom("S", 7 - 4, "smallCDs", "smallcds");
	v13.ToggleIconFrame:AddButtonCustom("P", 607 - (268 + 335), "UseSpender", "usespender");
	v13.ToggleIconFrame:AddButtonCustom("T", 295 - (60 + 230), "UseTempest", "usetempest");
	v13.Print("Elemental Shaman rotation has been updated for patch 11.0.2. Last Update 10.10.2024");
end
v13.SetAPL(834 - (426 + 146), v84, v85);
