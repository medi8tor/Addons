local v0, v1 = ...;
local v2 = HeroDBC.DBC;
local v3 = HeroLib;
local v4 = HeroCache;
local v5 = v3.Unit;
local v6 = v5.Player;
local v7 = v5.Target;
local v8 = v5.Pet;
local v9 = v3.Spell;
local v10 = v3.MultiSpell;
local v11 = v3.Item;
local v12 = HeroRotation();
local v13 = v12.AoEON;
local v14 = v12.CDsON;
local v15 = v12.Cast;
local v16 = v12.Commons().Everyone.num;
local v17 = v12.Commons().Everyone.bool;
local v18 = v12.Commons().Everyone;
local v19 = UnitHealthMax;
local v20 = GetTime;
local v21 = GetSpellBonusDamage;
local v22 = v9.Monk.Brewmaster;
local v23 = v11.Monk.Brewmaster;
local v24, v25;
local v26 = {v23.ManicGrieftorch:ID(),v23.FyrakkTainedRageHeart:ID()};
local function v27(v61)
	return v25 or v18.ISSolo() or (v61 == (0 - 0)) or ((v24 >= v61) and (v24 < (20032 - 12255)));
end
local function v28(v62, v63, v64)
	if (v25 or v18.ISSolo() or (v64 == (619 - (555 + 64))) or ((v24 >= v64) and (v24 < (8708 - (857 + 74))))) then
		v12.Cast(v62, v63);
		return "TTD cast " .. v62:Name();
	end
end
local v29;
local v30;
local v31;
local v32 = GetInventoryItemLink("player", 584 - (367 + 201)) or "";
local v33 = IsEquippedItemType("Two-Hand");
local v34 = v6:GetEquipment();
local v35 = (v34[940 - (214 + 713)] and v11(v34[4 + 9])) or v11(0 + 0);
local v36 = (v34[891 - (282 + 595)] and v11(v34[1651 - (1523 + 114)])) or v11(0 + 0);
v3:RegisterForEvent(function()
	v32 = GetInventoryItemLink("player", 22 - 6) or "";
	v33 = IsEquippedItemType("Two-Hand");
	v34 = v6:GetEquipment();
	v35 = (v34[1078 - (68 + 997)] and v11(v34[1283 - (226 + 1044)])) or v11(0 - 0);
	v36 = (v34[131 - (32 + 85)] and v11(v34[14 + 0])) or v11(0 + 0);
end, "PLAYER_EQUIPMENT_CHANGED");
local v37 = {{v22.LegSweep,"Cast Leg Sweep (Stun)",function()
	return true;
end},{v22.Paralysis,"Cast Paralysis (Stun)",function()
	return true;
end}};
local function v38()
	return v23.ManicGrieftorch:IsEquipped() and (v23.ManicGrieftorch:CooldownUp() or (v23.ManicGrieftorch:CooldownRemains() <= v6:GCDRemains()));
end
local v18 = v12.Commons().Everyone;
local v39 = v12.Commons().Monk;
local v40 = v12.GUISettingsGet();
local v41 = {General=v40.General,Commons=v40.APL.Monk.Commons,Brewmaster=v40.APL.Monk.Brewmaster,TTD=v40.APL.Monk.Brewmaster.TTD};
local function v42()
	return v18.TargetIsValid() and (v7:AffectingCombat() or not v41.Brewmaster.OnlyAttackEnnemyInCombat or (not v41.Brewmaster.OnlyAttackEnnemyInCombatSolo and v18.ISSolo()));
end
local v43, v44, v45, v46, v47, v48, v49;
local function v50()
	local v65 = v6:Stagger() or (0 + 0);
	if (v65 == (0 - 0)) then
		return false;
	end
	if ((v22.PurifyingBrew:ChargesFractional() >= (953.8 - (802 + 150))) and (v6:DebuffUp(v22.HeavyStagger) or v6:DebuffUp(v22.ModerateStagger) or v6:DebuffUp(v22.LightStagger))) then
		return true;
	end
	return false;
end
local v51, v52;
local function v53()
	if (v22.RushingJadeWind:IsCastable() and (v6:BuffRemains(v22.RushingJadeWind) < (2.5 - 1))) then
		if v15(v22.RushingJadeWind) then
			return "rushing_jade_wind rotation_pta 28";
		end
	end
	if (v22.KegSmash:IsCastable() and v48) then
		if v15(v22.KegSmash) then
			return "keg_smash precombat 6";
		end
	end
	if (v22.ChiBurst:IsCastable() and v49) then
		if v15(v22.ChiBurst) then
			return "chi_burst precombat 2";
		end
	end
	if (v22.ChiWave:IsCastable() and v49) then
		if v15(v22.ChiWave) then
			return "chi_wave precombat 4";
		end
	end
end
local function v54()
	local v66 = v6:IncomingSpell(v18.TankBustersList2);
	if (v66 and v12.DebugON()) then
		print("Tank Burster: " .. v66);
	end
	if (v22.PurifyingBrew:IsCastable() and (v22.PurifyingBrew:TimeSinceLastCast() > (1 - 0)) and v50() and not v66 and v6:BuffDown(v22.BlackoutComboBuff)) then
		if v15(v22.PurifyingBrew, true) then
			return "Purifying Brew (Capping Charges)";
		end
	end
	if (v22.PurifyingBrew:IsCastable() and (v22.PurifyingBrew:TimeSinceLastCast() > (1 + 0)) and (((v6:StaggerPercentage() > (1047 - (915 + 82))) and v6:BuffDown(v22.BlackoutComboBuff)) or (v6:StaggerPercentage() > (198 - 128)))) then
		if v15(v22.PurifyingBrew, true) then
			return "Purifying Brew";
		end
	end
	if (v22.Vivify:IsReady() and (v6:HealthPercentage() <= v41.Brewmaster.VivVivHP) and v6:BuffUp(v22.VivaciousVivification)) then
		v15(v22.Vivify);
		return "Vivify With Buff on Self";
	end
	if (v22.CelestialBrew:IsCastable() and v6:BuffDown(v22.BlackoutComboBuff) and v6:BuffDown(v22.CelestialBrew) and (v66 or (v6:HealthPercentageWeighted() <= (21 + 14)) or (v6:StaggerPercentage() > (92 - 22)))) then
		if v15(v22.CelestialBrew) then
			return "Celestial Brew";
		end
	end
	if (v14() and v22.BlackOxBrew:IsCastable() and ((not v22.CelestialBrew:IsCastable() and v6:BuffDown(v22.CelestialBrew)) or (v22.PurifyingBrew:ChargesFractional() < (1187.8 - (1069 + 118)))) and (v66 or (v6:HealthPercentageWeighted() <= (79 - 44)) or (v6:StaggerPercentage() > (153 - 83)))) then
		if v15(v22.BlackOxBrew, true) then
			return "black_ox_brew reset brew";
		end
	end
	if (v22.ExpelHarm:IsReady() and (v6:HealthPercentage() <= v41.Brewmaster.ExpelHarmHP)) then
		local v71 = ((v22.StrengthofSpirit:IsAvailable()) and (1 + 0 + (((1 - 0) - (v6:HealthPercentage() / (100 + 0))) * (891 - (368 + 423))))) or (3 - 2);
		local v72 = v6:AttackPowerDamageMod() * (21 - (10 + 8));
		local v73 = (v21(15 - 11) * (443.2 - (416 + 26)) * v71) + (v22.ExpelHarm:Count() * v72);
		local v74 = v6:MaxHealth() - v6:Health();
		if ((v74 > (v73 * (0.9 - 0))) or (v6:HealthPercentage() <= (v41.Brewmaster.ExpelHarmHP / (1 + 1)))) then
			if v15(v22.ExpelHarm) then
				return "Expel Harm (defensives)";
			end
		end
	end
	if (v22.DampenHarm:IsCastable() and v6:BuffDown(v22.FortifyingBrewBuff) and (v6:HealthPercentageWeighted() <= (35 - 15))) then
		if v15(v22.DampenHarm) then
			return "Dampen Harm";
		end
	end
	if (v22.FortifyingBrew:IsCastable() and v6:BuffDown(v22.DampenHarmBuff) and (v6:HealthPercentageWeighted() <= (458 - (145 + 293)))) then
		if v15(v22.FortifyingBrew) then
			return "Fortifying Brew";
		end
	end
end
local function v55()
	if (v38() and v6:AffectingCombat() and v14() and v7:IsInRange(470 - (44 + 386)) and v27(v41.TTD.Trinket)) then
		if v15(v23.ManicGrieftorch) then
			return "manic_grieftorch";
		end
	end
	local v67, v68, v69 = v6:GetUseableItems(v26);
	if (v67 and v7:IsInRange(v69) and v27(v41.TTD.Trinket)) then
		local v75 = (v68 == (1499 - (998 + 488))) or (v68 == (5 + 9));
		if (v75 and v41.Commons.Enabled.Trinkets) then
			if v15(v67) then
				return "Generic use_items for " .. v67:Name();
			end
		end
	end
	if (v41.Commons.Enabled.Items and v23.Djaruun:IsEquippedAndReady() and v47 and v14()) then
		v12.CastMacro(1 + 0, nil, nil, v23.Djaruun);
		return "Djaruun";
	end
end
local function v56()
	if v22.BloodFury:IsCastable() then
		if v15(v22.BloodFury, true) then
			return "blood_fury race_actions 2";
		end
	end
	if v22.Berserking:IsCastable() then
		if v15(v22.Berserking, true) then
			return "berserking race_actions 4";
		end
	end
	if v22.LightsJudgment:IsCastable() then
		if v15(v22.LightsJudgment, true) then
			return "lights_judgment race_actions 6";
		end
	end
	if v22.Fireblood:IsCastable() then
		if v15(v22.Fireblood, true) then
			return "fireblood race_actions 8";
		end
	end
	if v22.AncestralCall:IsCastable() then
		if v15(v22.AncestralCall, true) then
			return "ancestral_call race_actions 10";
		end
	end
end
local function v57()
	if (v14() and v22.InvokeNiuzaoTheBlackOx:IsCastable()) then
		if v28(v22.InvokeNiuzaoTheBlackOx, true, v41.TTD.Niuzao) then
			return "invoke_niuzao_the_black_ox rotation_pta 2";
		end
	end
	if (v22.RisingSunKick:IsCastable() and v47 and ((v6:BuffStack(v22.PresstheAdvantageBuff) < ((779 - (201 + 571)) + v16(v33))) or ((v6:BuffStack(v22.PresstheAdvantageBuff) > (1147 - (116 + 1022))) and (v30 <= (12 - 9)) and (v6:BuffUp(v22.BlackoutComboBuff) or not v22.BlackoutCombo:IsAvailable())))) then
		if v15(v22.RisingSunKick) then
			return "rising_sun_kick rotation_pta 4";
		end
	end
	if (v22.KegSmash:IsReady() and v48 and (v6:BuffStack(v22.PresstheAdvantageBuff) > (6 + 3)) and (v30 > (10 - 7))) then
		if v15(v22.KegSmash) then
			return "keg_smash rotation_pta 6";
		end
	end
	if (v22.SpinningCraneKick:IsReady() and (v30 > (17 - 12)) and v6:BuffUp(v22.ExplodingKeg) and v6:BuffUp(v22.CharredPassionsBuff)) then
		if v15(v22.SpinningCraneKick) then
			return "spinning_crane_kick rotation_pta 8";
		end
	end
	if (v22.BlackoutKick:IsCastable() and v47) then
		if v15(v22.BlackoutKick) then
			return "blackout_kick rotation_pta 10";
		end
	end
	if (v14() and v22.BlackOxBrew:IsCastable() and ((v6:Energy() + v6:EnergyRegen()) <= (899 - (814 + 45)))) then
		if v15(v22.BlackOxBrew) then
			return "black_ox_brew rotation_pta 14";
		end
	end
	if (v22.BreathofFire:IsCastable() and v47 and v7:DebuffUp(v22.KegSmash) and (v6:BuffRemains(v22.CharredPassionsBuff) < v22.BlackoutKick:CooldownRemains()) and (v6:BuffUp(v22.BlackoutComboBuff) or not v22.BlackoutCombo:IsAvailable())) then
		if v15(v22.BreathofFire) then
			return "breath_of_fire rotation_pta 16";
		end
	end
	if (v14() and v22.SummonWhiteTigerStatue:IsCastable() and not v6:IsMoving() and v47) then
		if v28(v22.SummonWhiteTigerStatue, false, v41.TTD.WhiterTigerStatue) then
			return "summon_white_tiger_statue rotation_pta 18";
		end
	end
	if (v14() and v22.BonedustBrew:IsCastable() and not v6:IsMoving() and v47) then
		if v28(v22.BonedustBrew, false, v41.TTD.Bonedust) then
			return "bonedust_brew rotation_pta 20";
		end
	end
	if (v14() and v22.ExplodingKeg:IsCastable() and not v6:IsMoving() and v47 and v13 and (v6:BuffUp(v22.BonedustBrewBuff) or (v22.BonedustBrew:CooldownRemains() >= (49 - 29)) or not v22.BonedustBrew:IsAvailable())) then
		if v28(v22.ExplodingKeg, false, v41.TTD.ExplodingKeg) then
			return "exploding_keg rotation_pta 22";
		end
	end
	if (v22.BreathofFire:IsCastable() and v47 and v7:DebuffUp(v22.KegSmash) and (v6:BuffUp(v22.BlackoutComboBuff) or not v22.BlackoutCombo:IsAvailable())) then
		if v15(v22.BreathofFire) then
			return "breath_of_fire rotation_pta 24";
		end
	end
	if (v22.KegSmash:IsReady() and v48 and (v6:BuffStack(v22.PresstheAdvantageBuff) < (1 + 9))) then
		if v15(v22.KegSmash) then
			return "keg_smash rotation_pta 26";
		end
	end
	if (v22.RushingJadeWind:IsCastable() and (v6:BuffRemains(v22.RushingJadeWind) < (1.5 + 0))) then
		if v15(v22.RushingJadeWind) then
			return "rushing_jade_wind rotation_pta 28";
		end
	end
	if (v22.SpinningCraneKick:IsReady() and ((v30 > (887 - (261 + 624))) or (((1.1 - 0) > (((v20() - v6:PrevGCDTime()) * ((1081 - (1020 + 60)) + v6:SpellHaste())) - v16(v33))) and v47))) then
		if v15(v22.SpinningCraneKick) then
			return "spinning_crane_kick rotation_pta 30";
		end
	end
	if (v22.ChiWave:IsCastable() and v49) then
		if v15(v22.ChiWave) then
			return "chi_wave rotation_pta 34";
		end
	end
	if (v22.ChiBurst:IsCastable() and v49) then
		if v15(v22.ChiBurst) then
			return "chi_burst rotation_pta 36";
		end
	end
end
local function v58()
	if (v22.BlackoutKick:IsCastable() and v47) then
		if v15(v22.BlackoutKick) then
			return "blackout_kick rotation_boc 2";
		end
	end
	local v70 = (v22.PurifyingBrew:TimeSinceLastCast() < (1429 - (630 + 793))) and (v39.LastNiuzaoStomp < v22.PurifyingBrew.LastCastTime);
	if (v14() and v22.WeaponsofOrder:IsCastable() and v70 and v22.ImprovedInvokeNiuzao:IsAvailable()) then
		if v15(v22.WeaponsofOrder) then
			return "weapons_of_order rotation_boc 6";
		end
	end
	if (v14() and v22.InvokeNiuzaoTheBlackOx:IsCastable() and v6:BuffDown(v22.InvokeNiuzaoTheBlackOx) and v70 and (v6:BuffRemains(v22.WeaponsofOrderBuff) < (47 - 33)) and v22.ImprovedInvokeNiuzao:IsAvailable()) then
		if v28(v22.InvokeNiuzaoTheBlackOx, true, v41.TTD.Niuzao) then
			return "invoke_niuzao_the_black_ox rotation_boc 8";
		end
	end
	if (v14() and v22.InvokeNiuzaoTheBlackOx:IsCastable() and (v7:DebuffStack(v22.WeaponsofOrderDebuff) > (14 - 11)) and not v22.ImprovedInvokeNiuzao:IsAvailable()) then
		if v28(v22.InvokeNiuzaoTheBlackOx, true, v41.TTD.Niuzao) then
			return "invoke_niuzao_the_black_ox rotation_boc 10";
		end
	end
	if (v14() and v22.InvokeNiuzaoTheBlackOx:IsCastable() and not v22.WeaponsofOrder:IsAvailable()) then
		if v28(v22.InvokeNiuzaoTheBlackOx, true, v41.TTD.Niuzao) then
			return "invoke_niuzao_the_black_ox rotation_boc 12";
		end
	end
	if (v14() and v22.WeaponsofOrder:IsCastable() and not v22.ImprovedInvokeNiuzao:IsAvailable()) then
		if v15(v22.WeaponsofOrder) then
			return "weapons_of_order rotation_boc 14";
		end
	end
	if (v22.KegSmash:IsReady() and v48 and (v22.WeaponsofOrder:TimeSinceLastCast() < (1 + 1))) then
		if v15(v22.KegSmash) then
			return "keg_smash rotation_boc 16";
		end
	end
	if (v22.KegSmash:IsReady() and v48 and (v6:BuffRemains(v22.WeaponsofOrderBuff) < (v6:GCD() * (6 - 4))) and v6:BuffUp(v22.WeaponsofOrderBuff) and not v22.ImprovedInvokeNiuzao:IsAvailable()) then
		if v15(v22.KegSmash) then
			return "keg_smash rotation_boc 18";
		end
	end
	if (v22.KegSmash:IsReady() and v48 and (v6:BuffRemains(v22.WeaponsofOrderBuff) < (v6:GCD() * (1749 - (760 + 987)))) and v22.ImprovedInvokeNiuzao:IsAvailable()) then
		if v15(v22.KegSmash) then
			return "keg_smash rotation_boc 20";
		end
	end
	if (v22.RisingSunKick:IsCastable() and v47) then
		if v15(v22.RisingSunKick) then
			return "rising_sun_kick rotation_boc 24";
		end
	end
	if (v14() and v22.BlackOxBrew:IsCastable() and ((v6:Energy() + v6:EnergyRegen()) <= (1953 - (1789 + 124)))) then
		if v15(v22.BlackOxBrew) then
			return "black_ox_brew rotation_boc 26";
		end
	end
	if (v22.TigerPalm:IsReady() and v47 and v6:BuffUp(v22.BlackoutComboBuff) and (v30 == (767 - (745 + 21)))) then
		if v15(v22.TigerPalm) then
			return "tiger_palm rotation_boc 28";
		end
	end
	if (v22.BreathofFire:IsCastable() and v47 and v7:DebuffUp(v22.KegSmash) and (v6:BuffRemains(v22.CharredPassionsBuff) < v22.BlackoutKick:CooldownRemains())) then
		if v15(v22.BreathofFire) then
			return "breath_of_fire rotation_boc 30";
		end
	end
	if (v22.KegSmash:IsReady() and v48 and v6:BuffUp(v22.WeaponsofOrderBuff) and (v6:BuffStack(v22.WeaponsofOrderBuff) <= (2 + 1))) then
		if v15(v22.KegSmash) then
			return "keg_smash rotation_boc 32";
		end
	end
	if (v14() and v22.SummonWhiteTigerStatue:IsCastable() and not v6:IsMoving() and v47 and ((v7:DebuffStack(v22.WeaponsofOrderDebuff) > (7 - 4)) or not v22.WeaponsofOrder:IsAvailable() or (v30 > (7 - 5)))) then
		if v28(v22.SummonWhiteTigerStatue, false, v41.TTD.WhiterTigerStatue) then
			return "summon_white_tiger_statue rotation_boc 34";
		end
	end
	if (v14() and v22.BonedustBrew:IsCastable() and not v6:IsMoving() and v47 and (((v44 < (1 + 9)) and (v7:DebuffStack(v22.WeaponsofOrderDebuff) > (3 + 0))) or ((v44 > (1065 - (87 + 968))) and v22.WeaponsofOrder:IsAvailable()) or not v22.WeaponsofOrder:IsAvailable())) then
		if v28(v22.BonedustBrew, false, v41.TTD.Bonedust) then
			return "bonedust_brew rotation_boc 36";
		end
	end
	if (v14() and v22.ExplodingKeg:IsCastable() and not v6:IsMoving() and v47 and v13 and (v6:BuffUp(v22.BonedustBrewBuff) or (v22.BonedustBrew:CooldownRemains() >= (88 - 68)) or not v22.BonedustBrew:IsAvailable())) then
		if v28(v22.ExplodingKeg, false, v41.TTD.ExplodingKeg) then
			return "exploding_keg rotation_boc 38";
		end
	end
	if (v22.KegSmash:IsReady() and v48) then
		if v15(v22.KegSmash) then
			return "keg_smash rotation_boc 40";
		end
	end
	if (v22.RushingJadeWind:IsCastable() and (v6:BuffRemains(v22.RushingJadeWind) < (1.5 + 0))) then
		if v15(v22.RushingJadeWind) then
			return "rushing_jade_wind rotation_boc 42";
		end
	end
	if (v22.BreathofFire:IsCastable() and v47) then
		if v15(v22.BreathofFire) then
			return "breath_of_fire rotation_boc 44";
		end
	end
	if (v22.TigerPalm:IsReady() and v47 and (v30 == (2 - 1)) and not v22.BlackoutCombo:IsAvailable()) then
		if v15(v22.TigerPalm) then
			return "tiger_palm rotation_boc 46";
		end
	end
	if (v22.SpinningCraneKick:IsReady() and (v30 > (1414 - (447 + 966)))) then
		if v15(v22.SpinningCraneKick) then
			return "spinning_crane_kick rotation_boc 48";
		end
	end
	if (v22.ChiWave:IsCastable() and v49) then
		if v15(v22.ChiWave) then
			return "chi_wave rotation_boc 52";
		end
	end
	if (v22.ChiBurst:IsCastable() and v49) then
		if v15(v22.ChiBurst) then
			return "chi_burst rotation_boc 54";
		end
	end
end
local function v59()
	if v6:IsChanneling(v23.ManicGrieftorch.ItemUseSpell) then
		return "Dont cut Torch";
	end
	v51 = v12.ToggleIconFrame:GetToggle(2 - 1);
	v52 = v12.ToggleIconFrame:GetToggle(1819 - (1703 + 114));
	v29 = v6:GetEnemiesInMeleeRange(706 - (376 + 325));
	v46 = v6:GetEnemiesInRange(65 - 25);
	v30 = #v29;
	v45 = v18.UnitsinRange(v22.Vivify);
	v47 = v7:IsInMeleeRange(15 - 10);
	v48 = v7:IsInRange(6 + 12);
	v49 = v7:IsInRange(88 - 48);
	if (v51 and not v6:IsInRaid() and v22.Detox:IsReady()) then
		v43 = v18.AfflictedLogic(v22.Detox);
		if v43 then
			return v43;
		end
	end
	if (v51 and not v6:IsInRaid() and v22.Detox:IsReady()) then
		v43 = v18.DispelCycle(v22.Detox, "Disease", nil, v45);
		if v43 then
			return v43;
		end
		v43 = v18.DispelCycle(v22.Detox, "Poison", nil, v45);
		if v43 then
			return v43;
		end
	end
	if (v18.TargetIsValid() or v6:AffectingCombat()) then
		v24 = v3.BossFightRemains();
		v25 = true;
		if (v24 == (11125 - (9 + 5))) then
			v25 = false;
			v24 = v3.FightRemains(v46, false);
		end
		v31 = v6:IsTankingAoE(384 - (85 + 291)) or v6:IsTanking(v7);
		v44 = v3.CombatTime();
	end
	if (v18.TargetIsValid() and not v6:AffectingCombat()) then
		v43 = v53();
		if v43 then
			return v43;
		end
	end
	if v42() then
		if (v41.Brewmaster.Enabled.TouchofDeath and v22.TouchofDeath:IsReady() and v18.TargetIsValid() and v47 and ((v7:Health() < v6:Health()) or (v22.ImpTouchofDeath:IsAvailable() and (v7:HealthPercentageWeighted() < (1280 - (243 + 1022)))))) then
			v15(v22.TouchofDeath);
			return;
		end
		if v52 then
			if v22.SpearHandStrike:IsReady() then
				v43 = v18.InterruptCycle(v22.SpearHandStrike, 19 - 14, true, nil, false);
				if v43 then
					return v43;
				end
			end
			if v22.LegSweep:IsReady() then
				v43 = v18.InterruptCycle(v22.LegSweep, 7 + 1, false, nil, true, true);
				if v43 then
					return v43;
				end
			end
			if v41.Brewmaster.LegSweepInt then
				if (v22.SpearHandStrike:CooldownDown() and v22.LegSweep:IsReady()) then
					v43 = v18.InterruptCycle(v22.LegSweep, 1188 - (1123 + 57), false, nil, false, true);
					if v43 then
						return v43;
					end
				end
			end
			if v41.Brewmaster.ParaInt then
				if v22.Paralysis:IsReady() then
					v43 = v18.InterruptCycle(v22.Paralysis, 17 + 3, false, nil, true);
					if v43 then
						return v43;
					end
					if v22.SpearHandStrike:CooldownDown() then
						v43 = v18.InterruptCycle(v22.Paralysis, 274 - (163 + 91), false, nil, false);
						if v43 then
							return v43;
						end
					end
				end
			end
		end
		if v22.Paralysis:IsReady() then
			v43 = v18.IncorpCycle(v22.Paralysis, 1950 - (1869 + 61), false, v41.Brewmaster.AutoTabforInc);
			if v43 then
				return v43;
			end
		end
		if v31 then
			v43 = v54();
			if v43 then
				return v43;
			end
		end
		if (v41.Commons.Enabled.Trinkets and v23.FyrakkTainedRageHeart:IsEquippedAndReady() and v14() and v13()) then
			if ((v30 >= (2 + 2)) and v27(v41.TTD.Trinket)) then
				if v15(v23.FyrakkTainedRageHeart, true) then
					return "FyrakkTainedRageHeart offense";
				end
			end
		end
		if (v22.TigersLust:IsReady() and (v6:DebuffElapsed(v22.EntangledDebuff) > (6 - 4))) then
			v15(v22.TigersLust);
			return "Cast Tiger's Lust";
		end
		if (v41.Commons.Enabled.Potions and (not v41.Brewmaster.PotionWithLust or v6:BloodlustUp())) then
			local v76 = v18.PotionSelected();
			if (v76 and v76:IsReady()) then
				if v12.CastMacro(4 - 1, nil, nil, v76) then
					return "potion main 2";
				end
			end
		end
		if (v22.RushingJadeWind:IsCastable() and v6:BuffDown(v22.RushingJadeWind) and v6:BuffUp(v22.ShuffleBuff) and (v3.CombatTime() < (2 + 8))) then
			if v15(v22.RushingJadeWind) then
				return "rushing_jade_wind rotation down";
			end
		end
		if (v22.KegSmash:IsReady() and v48 and v6:BuffDown(v22.ShuffleBuff)) then
			if v15(v22.KegSmash) then
				return "keg_smash rotation down";
			end
		end
		if (v22.BlackoutKick:IsReady() and v47 and v6:BuffDown(v22.ShuffleBuff)) then
			if v15(v22.BlackoutKick) then
				return "BlackoutKick rotation down";
			end
		end
		if (v14() and (v41.Commons.Enabled.Items or v41.Commons.Enabled.Trinkets)) then
			v43 = v55();
			if v43 then
				return v43;
			end
		end
		if v14() then
			v43 = v56();
			if v43 then
				return v43;
			end
		end
		if v22.PresstheAdvantage:IsAvailable() then
			v43 = v57();
			if v43 then
				return v43;
			end
		end
		if not v22.PresstheAdvantage:IsAvailable() then
			v43 = v58();
			if v43 then
				return v43;
			end
		end
		if (v22.BagofTricks:IsCastable() and v49) then
			if v15(v22.BagofTricks, true) then
				return "bag_of_tricks race_actions 12";
			end
		end
	end
end
local function v60()
	v12.Print("Brewmaster Monk rotation has been updated for patch 10.2.5.");
	v12.ResetToggle();
	v41.Brewmaster.Display();
	v12:UpdateMacro("macro1", "/use 16");
	v12.ToggleIconFrame:AddButtonCustom("D", 1 - 0, "Dispel", "dispel");
	v12.ToggleIconFrame:AddButtonCustom("K", 2 + 0, "Kick", "kick");
end
v12.SetAPL(1742 - (1329 + 145), v59, v60);
