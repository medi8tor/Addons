local v0, v1 = ...;
local v2 = HeroDBC.DBC;
local v3 = HeroLib;
local v4 = HeroCache;
local v5 = v3.Unit;
local v6 = v5.Player;
local v7 = v5.Target;
local v8 = v5.MouseOver;
local v9 = v5.Pet;
local v10 = v3.Spell;
local v11 = v3.MultiSpell;
local v12 = v3.Item;
local v13 = HeroRotation();
local v14 = v13.Cast;
local v15 = v13.CastLeft;
local v16 = v13.CDsON;
local v17 = v13.AoEON;
local v18 = v13.Commons().Mage;
local v19 = v13.Commons().Everyone.num;
local v20 = v13.Commons().Everyone.bool;
local v21 = math.max;
local v22 = v10.Mage.Frost;
local v23 = v12.Mage.Frost;
local function v24()
	return v13.ToggleIconFrame:GetToggle(5 - 3);
end
local v25 = {v23.ImperfectAscendancySerum:ID(),v23.SpymastersWeb:ID(),v23.BelorrelostheSuncaller:ID(),v23.Dreambinder:ID(),v23.KahetiShadowweaversEmblem:ID()};
local v26 = v13.Commons().Everyone;
local v27 = v13.GUISettingsGet();
local v28 = {General=v27.General,Commons=v27.APL.Mage.Commons,Frost=v27.APL.Mage.Frost,Defense=v27.APL.Mage.Defense.Defensive};
local v29, v30;
local v31;
local v32, v33 = 568 - (367 + 201), 927 - (214 + 713);
local v34 = 0 + 0;
local v35 = 0 + 0;
local v36 = 957 - (282 + 595);
local v37 = 12748 - (1523 + 114);
local v38 = 9986 + 1125;
local v39;
local v40;
local v41 = (v22.FrostfireBolt:IsAvailable() and v22.FrostfireBolt) or v22.Frostbolt;
v3:RegisterForEvent(function()
	v22.Frostbolt:RegisterInFlightEffect(325885 - 97288);
	v22.Frostbolt:RegisterInFlight();
	v22.FrostfireBolt:RegisterInFlight();
	v22.FrozenOrb:RegisterInFlightEffect(85786 - (68 + 997));
	v22.FrozenOrb:RegisterInFlight();
	v22.Flurry:RegisterInFlightEffect(229624 - (226 + 1044));
	v22.Flurry:RegisterInFlight();
	v22.GlacialSpike:RegisterInFlightEffect(995416 - 766816);
	v22.GlacialSpike:RegisterInFlight();
	v22.IceLance:RegisterInFlightEffect(228715 - (32 + 85));
	v22.IceLance:RegisterInFlight();
	v22.Splinterstorm:RegisterInFlight();
	v41 = (v22.FrostfireBolt:IsAvailable() and v22.FrostfireBolt) or v22.Frostbolt;
end, "SPELLS_CHANGED", "LEARNED_SPELL_IN_TAB");
v22.Frostbolt:RegisterInFlightEffect(224028 + 4569);
v22.Frostbolt:RegisterInFlight();
v22.FrostfireBolt:RegisterInFlight();
v22.FrozenOrb:RegisterInFlightEffect(18788 + 65933);
v22.FrozenOrb:RegisterInFlight();
v22.Flurry:RegisterInFlightEffect(229311 - (892 + 65));
v22.Flurry:RegisterInFlight();
v22.GlacialSpike:RegisterInFlightEffect(545332 - 316732);
v22.GlacialSpike:RegisterInFlight();
v22.IceLance:RegisterInFlightEffect(422548 - 193950);
v22.IceLance:RegisterInFlight();
v22.Splinterstorm:RegisterInFlight();
v3:RegisterForEvent(function()
	v37 = 20397 - 9286;
	v38 = 11461 - (87 + 263);
	v34 = 180 - (67 + 113);
end, "PLAYER_REGEN_ENABLED");
local function v42(v63)
	if (v63 == nil) then
		v63 = v7;
	end
	return not v63:IsInBossList() or (v63:Level() < (61 + 22));
end
local v43;
local v44, v45;
local function v46()
	if ((v24() or v16()) and v18.TTDCondition(v28.Frost.TimeToDie.FrozenOrb, v43, v38)) then
		if (not v6:IsMoving() and not v6:IsCameraBusy()) then
			return v14(v22.FrozenOrb);
		else
			v15(v22.FrozenOrb);
		end
	end
end
local function v47(v64, v65)
	if (v22.IceFloes:IsCastable() and (v22.IceFloes:TimeSinceLastCast() > (2 - 1)) and ((v6:IsMoving() and (v22.IceFloes:Charges() > (1 + 0))) or v65) and v6:BuffDown(v22.IceFloes)) then
		v14(v22.IceFloes, true);
		return "ice_floes";
	elseif (not v6:IsMoving() or v6:BuffUp(v22.IceFloes)) then
		v14(v64);
		return v64:Name();
	end
end
local function v48()
	return v21(v6:BuffRemains(v22.FingersofFrostBuff), v7:DebuffRemains(v22.WintersChillDebuff), v7:DebuffRemains(v22.Frostbite), v7:DebuffRemains(v22.Freeze), v7:DebuffRemains(v22.FrostNova));
end
local function v49(v66)
	if (v22.WintersChillDebuff:AuraActiveCount() == (0 - 0)) then
		return 952 - (802 + 150);
	end
	local v67 = 0 - 0;
	for v72, v73 in pairs(v66) do
		v67 = v67 + v73:DebuffStack(v22.WintersChillDebuff);
	end
	return v67;
end
local function v50(v68)
	return (v68:DebuffStack(v22.WintersChillDebuff));
end
local function v51(v69)
	return v69:DebuffDown(v22.WintersChillDebuff);
end
local function v52(v70)
	return v70:DebuffStack(v22.WintersChillDebuff) == (3 - 1);
end
local function v53()
	if (((v30 >= (6 + 1)) and not v6:HasTier(1027 - (915 + 82), 5 - 3)) or ((v30 >= (3 + 1)) and v22.IceCaller:IsAvailable() and not v6:IsCasting(v22.Blizzard))) then
		if v18.GroundSpellCondition() then
			if v47(v22.Blizzard) then
				return "blizzard aoe 6";
			end
		else
			v15(v22.Blizzard);
		end
	end
	if (v41:IsCastable() and (not v6:IsMoving() or v6:BuffUp(v22.FrostfireEmpowermentBuff)) and not v6:IsCasting(v41) and not v6:IsCasting(v22.Blizzard) and v18.TTDCastTimeCondition(v41, v43, v38)) then
		if v47(v41) then
			return "frostbolt precombat 4";
		end
	end
end
local function v54()
	if (v28.Commons.Enabled.Trinkets and v18.TTDCondition(v28.Frost.TimeToDie.Trinkets, v43, v38)) then
		if (v23.ImperfectAscendancySerum:IsEquippedAndReady() and ((v6:BuffRemains(v22.IcyVeinsBuff) > (24 - 5)) or (v37 < (1212 - (1069 + 118))))) then
			if v14(v23.ImperfectAscendancySerum) then
				return "imperfect_ascendancy_serum cd 2";
			end
		end
		if (v23.SpymastersWeb:IsEquippedAndReady() and (((v6:BuffRemains(v22.IcyVeinsBuff) > (42 - 23)) and (v37 < (218 - 118))) or (v37 < (5 + 20)))) then
			if v14(v23.SpymastersWeb) then
				return "spymasters_web cd 4";
			end
		end
		if (v23.KahetiShadowweaversEmblem:IsEquippedAndReady() and (v6:BuffStack(v22.KahetiShadowweaversEmblemBuff) >= (8 - 3))) then
			if v14(v23.KahetiShadowweaversEmblem) then
				return "Kaheti_Shadowweavers_Emblem items";
			end
		end
	end
	if (v28.Commons.Enabled.Potions and (v6:BuffUp(v22.IcyVeinsBuff) or (v38 < (60 + 0)))) then
		local v74 = v26.PotionSelected();
		if (v74 and v74:IsReady()) then
			if v13.CastMacro(794 - (368 + 423), nil, nil, v74) then
				return "potion cd 6";
			end
		end
	end
	if v18.TTDCondition(v28.Frost.TimeToDie.Trinkets, v43, v38) then
		if (v28.Commons.Enabled.Items and v23.Dreambinder:IsEquippedAndReady() and ((v23.NymuesUnravelingSpindle:IsEquipped() and v6:PrevGCDP(3 - 2, v23.NymuesUnravelingSpindle)) or (v38 > (20 - (10 + 8))))) then
			if v14(v23.Dreambinder) then
				return "dreambinder_loom_of_the_great_cycle cd 8";
			end
		end
		if (v28.Commons.Enabled.Trinkets and v23.BelorrelostheSuncaller:IsEquippedAndReady() and (v3.CombatTime() > (19 - 14)) and not v6:PrevGCDP(443 - (416 + 26), v22.Flurry) and v7:IsInRange(31 - 21)) then
			if v14(v23.BelorrelostheSuncaller) then
				return "belorrelos_the_suncaller cd 10";
			end
		end
	end
	if (v22.IcyVeins:IsCastable() and v18.TTDCondition(v28.Frost.TimeToDie.IcyVeins, v43, v38)) then
		if v14(v22.IcyVeins) then
			return "icy_veins cd 12";
		end
	end
	if (v28.Commons.Enabled.Trinkets and v18.TTDCondition(v28.Frost.TimeToDie.Trinkets, v43, v38)) then
		local v75, v76, v77 = v6:GetUseableItems(v25);
		if v75 then
			if (((v76 == (6 + 7)) or (v76 == (24 - 10))) and v28.Commons.Enabled.Trinkets) then
				if v14(v75) then
					return "Generic trinket for " .. v75:Name() .. " cd 14";
				end
			end
		end
	end
	if v22.BloodFury:IsCastable() then
		if v14(v22.BloodFury) then
			return "blood_fury cd 16";
		end
	end
	if v22.Berserking:IsCastable() then
		if v14(v22.Berserking) then
			return "berserking cd 18";
		end
	end
	if (v22.LightsJudgment:IsCastable() and v7:IsSpellInRange(v22.LightsJudgment)) then
		if v14(v22.LightsJudgment) then
			return "lights_judgment cd 20";
		end
	end
	if v22.Fireblood:IsCastable() then
		if v14(v22.Fireblood) then
			return "fireblood cd 22";
		end
	end
	if v22.AncestralCall:IsCastable() then
		if v14(v22.AncestralCall) then
			return "ancestral_call cd 24";
		end
	end
end
local function v55()
	if (v22.IceNova:IsCastable() and v7:IsSpellInRange(v22.IceNova)) then
		if v14(v22.IceNova) then
			return "ice_nova movement 4";
		end
	end
	if (v22.ConeofCold:IsReady() and not v22.ColdestSnap:IsAvailable() and (v30 >= (440 - (145 + 293))) and not v7:IsInRange(440 - (44 + 386))) then
		if v14(v22.ConeofCold) then
			return "cone_of_cold movement 6";
		end
	end
	if (v22.ArcaneExplosion:IsReady() and v7:IsInRange(1496 - (998 + 488)) and (v6:ManaPercentage() > (10 + 20)) and (v29 >= (2 + 0))) then
		if v14(v22.ArcaneExplosion) then
			return "arcane_explosion movement 6";
		end
	end
	if v22.FireBlast:IsReady() then
		if v14(v22.FireBlast) then
			return "fire_blast movement 8";
		end
	end
	if v22.IceLance:IsReady() then
		if v14(v22.IceLance) then
			return "ice_lance movement 10";
		end
	end
end
local function v56()
	if (v22.ConeofCold:IsCastable() and (v33 >= (775 - (201 + 571))) and v7:IsInRange(1150 - (116 + 1022)) and v22.ColdestSnap:IsAvailable() and (v6:PrevGCDP(4 - 3, v22.CometStorm) or (v6:PrevGCDP(1 + 0, v22.FrozenOrb) and not v22.CometStorm:IsAvailable()) or ((v22.CometStorm:CooldownRemains() > (36 - 26)) and (v22.FrozenOrb:CooldownRemains() > (35 - 25))))) then
		if v14(v22.ConeofCold, nil, nil) then
			return "cone_of_cold aoe 2";
		end
	end
	if (v22.FrozenOrb:IsCastable() and (not v6:PrevGCDP(860 - (814 + 45), v22.ConeofCold) or not v22.IsothermicCore:IsAvailable()) and (not v6:PrevGCDP(2 - 1, v22.GlacialSpike) or not v42())) then
		if v46() then
			return "frozen_orb aoe 4";
		end
	end
	if (v22.Blizzard:IsCastable() and (not v6:PrevGCDP(1 + 0, v22.GlacialSpike) or not v42()) and v18.TTDCastTimeCondition(v22.Blizzard, v43, v38)) then
		if v18.GroundSpellCondition() then
			if v47(v22.Blizzard) then
				return "blizzard aoe 6";
			end
		else
			v15(v22.Blizzard);
		end
	end
	if (v41:IsCastable() and (not v6:IsMoving() or v6:BuffUp(v22.FrostfireEmpowermentBuff)) and v18.TTDCastTimeCondition(v41, v43, v38) and v6:BuffUp(v22.IcyVeinsBuff) and ((v6:BuffStack(v22.DeathsChillBuff) < (4 + 5)) or ((v6:BuffStack(v22.DeathsChillBuff) == (894 - (261 + 624))) and not v41:InFlight())) and (v6:BuffRemains(v22.IcyVeinsBuff) > (13 - 5)) and v22.DeathsChillBuff:IsAvailable()) then
		if v47(v41) then
			return "frostbolt aoe deaths_chill";
		end
	end
	if (v22.CometStorm:IsCastable() and v18.TTDCondition(v28.Frost.TimeToDie.CometStorm, v43, v38) and (v24() or v16()) and not v6:PrevGCDP(1081 - (1020 + 60), v22.GlacialSpike) and (not v22.ColdestSnap:IsAvailable() or (v22.ConeofCold:CooldownUp() and (v22.FrozenOrb:CooldownRemains() > (1448 - (630 + 793)))) or ((v22.ConeofCold:CooldownRemains() > (33 - 23)) and v22.FrostfireBolt:IsAvailable()) or ((v22.ConeofCold:CooldownRemains() > (94 - 74)) and not v22.FrostfireBolt:IsAvailable()))) then
		if v14(v22.CometStorm) then
			return "comet_storm aoe 10";
		end
	end
	if (v9:IsActive() and v22.Freeze:IsReady() and v42() and (v48() == (0 + 0)) and v7:IsSpellInRange(v22.Freeze) and (not v22.GlacialSpike:IsAvailable() or v6:PrevGCDP(3 - 2, v22.GlacialSpike))) then
		if v14(v22.Freeze, nil, nil) then
			return "freeze aoe 10";
		end
	end
	if (v22.IceNova:IsCastable() and v42() and not v6:PrevOffGCDP(1748 - (760 + 987), v22.Freeze) and v7:IsSpellInRange(v22.IceNova) and (v6:PrevGCDP(1914 - (1789 + 124), v22.GlacialSpike))) then
		if v14(v22.IceNova, nil, nil) then
			return "ice_nova aoe 12";
		end
	end
	if (v22.FrostNova:IsCastable() and v7:IsInRange(778 - (745 + 21)) and v42() and not v6:PrevOffGCDP(1 + 0, v22.Freeze) and v6:PrevGCDP(2 - 1, v22.GlacialSpike) and (v34 == (0 - 0))) then
		if v14(v22.FrostNova, nil, nil) then
			return "frost_nova aoe 14";
		end
	end
	if (v22.ShiftingPower:IsCastable() and (v24() or v16()) and (v22.IcyVeins:CooldownRemains() > (1 + 9)) and (v22.CometStorm:CooldownRemains() > (8 + 2)) and v7:IsInRange(1070 - (87 + 968)) and (not v22.CometStorm:IsAvailable() or (v22.CometStorm:CooldownRemains() > (44 - 34)))) then
		if v47(v22.ShiftingPower, true) then
			return "shifting_power aoe 18";
		end
	end
	if (v41:IsCastable() and (not v6:IsMoving() or v6:BuffUp(v22.FrostfireEmpowermentBuff)) and v18.TTDCastTimeCondition(v41, v43, v38) and v6:BuffUp(v22.FrostfireEmpowermentBuff) and v6:BuffDown(v22.ExcessFrostBuff) and v6:BuffDown(v22.ExcessFireBuff)) then
		if v14(v41) then
			return "frostbolt aoe 20";
		end
	end
	if (v22.Flurry:IsCastable() and v18.TTDCastTimeCondition(v22.Flurry, v43, v38) and (v34 == (0 + 0)) and ((v6:BuffUp(v22.BrainFreezeBuff) and not v22.ExcessFrost:IsAvailable()) or v6:BuffUp(v22.ExcessFrostBuff))) then
		if v14(v22.Flurry) then
			return "flurry aoe 22";
		end
	end
	if (v22.IceLance:IsReady() and (v6:BuffUp(v22.FingersofFrostBuff) or (v48() > v22.IceLance:TravelTime()) or v20(v34))) then
		if v14(v22.IceLance) then
			return "ice_lance aoe 24";
		end
	end
	if (v22.Flurry:IsCastable() and (v34 == (0 - 0))) then
		if v14(v22.Flurry) then
			return "flurry aoe 26";
		end
	end
	if (v22.IceNova:IsCastable() and v7:IsSpellInRange(v22.IceNova) and (v29 >= (1417 - (447 + 966))) and (not v22.GlacialSpike:IsAvailable() or not v42()) and not v22.FrostfireBolt:IsAvailable()) then
		if v14(v22.IceNova) then
			return "ice_nova aoe 28";
		end
	end
	if (v22.ConeofCold:IsReady() and v7:IsInRange(27 - 17) and not v22.ColdestSnap:IsAvailable() and (v30 >= (1824 - (1703 + 114)))) then
		if v14(v22.ConeofCold) then
			return "cone_of_cold aoe 30";
		end
	end
	if (v41:IsCastable() and (not v6:IsMoving() or v6:BuffUp(v22.FrostfireEmpowermentBuff)) and v18.TTDCastTimeCondition(v41, v43, v38)) then
		if v47(v41) then
			return "frostbolt aoe 36";
		end
	end
	if v6:IsMoving() then
		local v78 = v55();
		if v78 then
			return v78;
		end
	end
end
local function v57()
	if (v22.Flurry:IsCastable() and (v34 == (701 - (376 + 325))) and (v6:PrevGCDP(1 - 0, v22.Frostbolt) or v6:PrevGCDP(2 - 1, v22.GlacialSpike))) then
		if v26.CastTargetIf(v22.Flurry, v32, "min", v50, v51, 12 + 28) then
			return "flurry ss_cleave 2";
		end
	end
	if (v22.IceLance:IsReady() and (v6:BuffUp(v22.IcyVeinsBuff))) then
		if v26.CastTargetIf(v22.IceLance, v32, "max", v50, v52, 88 - 48) then
			return "ice_lance ss_cleave 4";
		end
	end
	if (v22.RayofFrost:IsCastable() and v18.TTDCastTimeCondition(v22.RayofFrost, v43, v38) and v6:BuffDown(v22.IcyVeinsBuff) and v6:BuffDown(v22.FreezingWindsBuff) and (v34 == (15 - (9 + 5)))) then
		if v47(v22.RayofFrost) then
			return "ray_of_frost ss_cleave 6";
		end
	end
	if v22.FrozenOrb:IsCastable() then
		if v46() then
			return "frozen_orb ss_cleave 8";
		end
	end
	if (v22.ShiftingPower:IsCastable() and (v24() or v16()) and v7:IsInRange(394 - (85 + 291)) and (v22.IcyVeins:CooldownRemains() > (1275 - (243 + 1022)))) then
		if v47(v22.ShiftingPower, true) then
			return "shifting_power ss_cleave 10";
		end
	end
	if (v22.IceLance:IsReady() and ((v34 > (0 - 0)) or v6:BuffUp(v22.FingersofFrostBuff))) then
		if v26.CastTargetIf(v22.IceLance, v32, "max", v50, nil, 33 + 7) then
			return "ice_lance ss_cleave 12";
		end
	end
	if (v22.CometStorm:IsCastable() and v18.TTDCondition(v28.Frost.TimeToDie.CometStorm, v43, v38) and (v24() or v16()) and (v6:PrevGCDP(1181 - (1123 + 57), v22.Flurry) or v6:PrevGCDP(1 + 0, v22.ConeofCold))) then
		if v14(v22.CometStorm) then
			return "comet_storm ss_cleave 14";
		end
	end
	if (v22.GlacialSpike:IsReady() and (v35 == (259 - (163 + 91))) and v18.TTDCastTimeCondition(v22.GlacialSpike, v43, v38)) then
		if v47(v22.GlacialSpike, true) then
			return "glacial_spike ss_cleave 16";
		end
	end
	if (v22.Flurry:IsCastable() and (v6:BuffUp(v22.IcyVeinsBuff))) then
		if v26.CastTargetIf(v22.Flurry, v32, "min", v50, nil, 1970 - (1869 + 61)) then
			return "flurry ss_cleave 18";
		end
	end
	if (v41:IsCastable() and (not v6:IsMoving() or v6:BuffUp(v22.FrostfireEmpowermentBuff)) and v18.TTDCastTimeCondition(v41, v43, v38)) then
		if v14(v41) then
			return "frostbolt ss_cleave 20";
		end
	end
	if v6:IsMoving() then
		local v79 = v55();
		if v79 then
			return v79;
		end
	end
end
local function v58()
	if (v22.CometStorm:IsCastable() and v18.TTDCondition(v28.Frost.TimeToDie.CometStorm, v43, v38) and (v24() or v16()) and v18.TTDCondition(v28.Frost.TimeToDie.CometStorm, v43, v38) and (v24() or v16()) and (v6:PrevGCDP(1 + 0, v22.Flurry) or v6:PrevGCDP(3 - 2, v22.ConeofCold))) then
		if v14(v22.CometStorm, nil, nil) then
			return "comet_storm cleave 2";
		end
	end
	if (v22.Flurry:IsCastable() and not v22.Flurry:InFlight() and (v22.Flurry:TimeSinceLastCast() > (1 - 0)) and ((v6:PrevGCDP(1 + 0, v41) and (v35 >= (3 - 0))) or v6:PrevGCDP(1 + 0, v22.GlacialSpike) or ((v35 >= (1477 - (1329 + 145))) and (v35 < (976 - (140 + 831))) and (v22.Flurry:ChargesFractional() == (1852 - (1409 + 441))))) and v18.TTDCastTimeCondition(v22.Flurry, v43, v38)) then
		if v14(v22.Flurry) then
			return "flurry cleave 4";
		end
	end
	if (v22.IceLance:IsReady() and v22.GlacialSpike:IsAvailable() and (v22.WintersChillDebuff:AuraActiveCount() == (718 - (15 + 703))) and (v35 == (2 + 2)) and v6:BuffUp(v22.FingersofFrostBuff)) then
		if v14(v22.IceLance, nil, nil) then
			return "ice_lance cleave 6";
		end
	end
	if (v22.RayofFrost:IsCastable() and (v34 == (439 - (262 + 176))) and v18.TTDCastTimeCondition(v22.RayofFrost, v43, v38)) then
		if v47(v22.RayofFrost, true) then
			return "ray_of_frost cleave 8";
		end
	end
	if (v22.GlacialSpike:IsReady() and (w == (1726 - (345 + 1376))) and (v22.Flurry:CooldownUp() or (v34 > (688 - (198 + 490)))) and v18.TTDCastTimeCondition(v22.GlacialSpike, v43, v38)) then
		if v47(v22.GlacialSpike, true) then
			return "glacial_spike cleave 10";
		end
	end
	if (v22.FrozenOrb:IsCastable() and (v6:BuffStackP(v22.FingersofFrostBuff) < (8 - 6)) and (not v22.RayofFrost:IsAvailable() or v22.RayofFrost:CooldownDown())) then
		if v46() then
			return "frozen_orb cleave 12";
		end
	end
	if (v22.ConeofCold:IsCastable() and (v33 >= (6 - 3)) and v7:IsInRange(1218 - (696 + 510)) and v22.ColdestSnap:IsAvailable() and (v22.CometStorm:CooldownRemains() > (20 - 10)) and (v22.FrozenOrb:CooldownRemains() > (1272 - (1091 + 171))) and (v34 == (0 + 0)) and (v30 >= (9 - 6))) then
		if v14(v22.ConeofCold, nil, nil) then
			return "cone_of_cold cleave 14";
		end
	end
	if (v22.ShiftingPower:IsCastable() and (v24() or v16()) and (v22.IcyVeins:CooldownRemains() > (33 - 23)) and (((v22.FrozenOrb:CooldownRemains() > (384 - (123 + 251))) and (not v22.CometStorm:IsAvailable() or (v22.CometStorm:CooldownRemains() > (49 - 39))) and (not v22.RayofFrost:IsAvailable() or (v22.RayofFrost:CooldownRemains() > (708 - (208 + 490))))) or (v22.IcyVeins:CooldownRemains() < (2 + 18)))) then
		if v47(v22.ShiftingPower, true) then
			return "shifting_power cleave 16";
		end
	end
	if (v22.GlacialSpike:IsReady() and (v35 == (3 + 2)) and v18.TTDCastTimeCondition(v22.GlacialSpike, v43, v38)) then
		if v47(v22.GlacialSpike, true) then
			return "glacial_spike cleave 18";
		end
	end
	if (v22.IceLance:IsReady() and ((v6:BuffUpP(v22.FingersofFrostBuff) and not v6:PrevGCDP(837 - (660 + 176), v22.GlacialSpike)) or (v34 > (0 + 0)))) then
		if v26.CastTargetIf(v22.IceLance, v32, "max", v50, nil, 242 - (14 + 188)) then
			return "ice_lance cleave 20";
		end
	end
	if (v22.IceNova:IsCastable() and (v30 >= (679 - (534 + 141))) and v7:IsSpellInRange(v22.IceNova)) then
		if v14(v22.IceNova) then
			return "ice_nova cleave 22";
		end
	end
	if (v41:IsCastable() and (not v6:IsMoving() or v6:BuffUp(v22.FrostfireEmpowermentBuff)) and v18.TTDCastTimeCondition(v41, v43, v38)) then
		if v14(v41) then
			return "frostbolt cleave 24";
		end
	end
	if v6:IsMoving() then
		local v80 = v55();
		if v80 then
			return v80;
		end
	end
end
local function v59()
	if (v22.Flurry:IsCastable() and v18.TTDCastTimeCondition(v22.Flurry, v43, v38) and (v34 == (0 + 0)) and v7:DebuffDown(v22.WintersChillDebuff) and (v6:PrevGCDP(1 + 0, v22.Frostbolt) or v6:PrevGCDP(1 + 0, v22.GlacialSpike))) then
		if v14(v22.Flurry) then
			return "flurry ss_st 2";
		end
	end
	if (v22.IceLance:IsReady() and v6:BuffUp(v22.IcyVeinsBuff) and ((v7:DebuffStack(v22.WintersChillDebuff) == (3 - 1)) or ((v7:DebuffStack(v22.WintersChillDebuff) == (1 - 0)) and v22.Splinterstorm:InFlight()))) then
		if v14(v22.IceLance) then
			return "ice_lance ss_st 4";
		end
	end
	if (v22.RayofFrost:IsCastable() and v6:BuffDown(v22.IcyVeinsBuff) and v6:BuffDown(v22.FreezingWindsBuff) and (v34 == (2 - 1))) then
		if v47(v22.RayofFrost, true) then
			return "ray_of_frost ss_st 6";
		end
	end
	if v22.FrozenOrb:IsCastable() then
		if v46() then
			return "frozen_orb ss_st 8";
		end
	end
	if (v22.ShiftingPower:IsCastable() and (v24() or v16()) and (v22.IcyVeins:CooldownRemains() > (6 + 4))) then
		if v47(v22.ShiftingPower, true) then
			return "shifting_power ss_st 10";
		end
	end
	if (v22.IceLance:IsReady() and (v34 > (0 + 0))) then
		if v14(v22.IceLance) then
			return "ice_lance ss_st 12";
		end
	end
	if (v22.CometStorm:IsCastable() and v18.TTDCondition(v28.Frost.TimeToDie.CometStorm, v43, v38) and (v24() or v16()) and (v6:PrevGCDP(397 - (115 + 281), v22.Flurry) or v6:PrevGCDP(2 - 1, v22.ConeofCold))) then
		if v14(v22.CometStorm) then
			return "comet_storm ss_st 14";
		end
	end
	if (v22.GlacialSpike:IsReady() and (v35 == (5 + 0)) and v18.TTDCastTimeCondition(v22.GlacialSpike, v43, v38)) then
		if v47(v22.GlacialSpike, true) then
			return "glacial_spike ss_st 16";
		end
	end
	if (v22.Flurry:IsCastable() and (v6:BuffUp(v22.IcyVeinsBuff)) and v18.TTDCastTimeCondition(v22.Flurry, v43, v38)) then
		if v14(v22.Flurry) then
			return "flurry ss_st 18";
		end
	end
	if (v41:IsCastable() and (not v6:IsMoving() or v6:BuffUp(v22.FrostfireEmpowermentBuff)) and v18.TTDCastTimeCondition(v41, v43, v38)) then
		if v47(v41) then
			return "frostbolt ss_st 20";
		end
	end
	if v6:IsMoving() then
		v40 = v55();
		if v40 then
			return v40;
		end
	end
end
local function v60()
	if (v22.CometStorm:IsCastable() and v18.TTDCondition(v28.Frost.TimeToDie.CometStorm, v43, v38) and (v24() or v16()) and (v6:PrevGCDP(2 - 1, v22.Flurry) or v6:PrevGCDP(3 - 2, v22.ConeofCold))) then
		if v14(v22.CometStorm, nil, nil) then
			return "comet_storm single 2";
		end
	end
	if (v22.Flurry:IsCastable() and v18.TTDCastTimeCondition(v22.Flurry, v43, v38) and (((v34 == (867 - (550 + 317))) and v7:DebuffDown(v22.WintersChillDebuff) and ((v6:PrevGCDP(1 - 0, v41) and (v35 >= (3 - 0))) or (v6:PrevGCDP(2 - 1, v41) and v6:BuffUp(v22.BrainFreezeBuff)) or v6:PrevGCDP(286 - (134 + 151), v22.GlacialSpike) or (v22.GlacialSpike:IsAvailable() and (v35 == (1669 - (970 + 695))) and v6:BuffDown(v22.FingersofFrostBuff)))) or (v6:BuffUp(v22.ExcessFrostBuff) and v6:BuffUp(v22.FrostfireEmpowermentBuff)))) then
		if v14(v22.Flurry) then
			return "flurry single 4";
		end
	end
	if (v22.IceLance:IsReady() and v22.GlacialSpike:IsAvailable() and (v34 == (0 - 0)) and (v35 == (1994 - (582 + 1408))) and v6:BuffUp(v22.FingersofFrostBuff)) then
		if v14(v22.IceLance) then
			return "ice_lance single 6";
		end
	end
	if (v22.RayofFrost:IsCastable() and ((v34 == (3 - 2)) or ((v34 == (2 - 0)) and v6:PrevOffGCDP(3 - 2, v22.GlacialSpike)))) then
		if v47(v22.RayofFrost, true) then
			return "ray_of_frost single 8";
		end
	end
	if (v22.GlacialSpike:IsReady() and (v35 == (1829 - (1195 + 629))) and ((v22.Flurry:Charges() >= (1 - 0)) or (v34 > (241 - (187 + 54)))) and v18.TTDCastTimeCondition(v22.GlacialSpike, v43, v38)) then
		if v47(v22.GlacialSpike, true) then
			return "glacial_spike single 10";
		end
	end
	if (v22.FrozenOrb:IsCastable() and (v6:BuffStackP(v22.FingersofFrostBuff) < (782 - (162 + 618))) and (not v22.RayofFrost:IsAvailable() or v22.RayofFrost:CooldownDown())) then
		if v46() then
			return "frozen_orb single 12";
		end
	end
	if (v22.ConeofCold:IsCastable() and v7:IsInRange(9 + 3) and (v33 >= (2 + 1)) and v22.ColdestSnap:IsAvailable() and (v22.CometStorm:CooldownRemains() > (21 - 11)) and (v22.FrozenOrb:CooldownRemains() > (16 - 6)) and (v34 == (0 + 0)) and (v29 >= (1639 - (1373 + 263)))) then
		if v14(v22.ConeofCold, nil, nil) then
			return "cone_of_cold single 14";
		end
	end
	if (v17() and v22.Blizzard:IsCastable() and v18.TTDCastTimeCondition(v22.Blizzard, v43, v38) and (v29 >= (1002 - (451 + 549))) and v22.IceCaller:IsAvailable() and v22.FreezingRain:IsAvailable() and ((not v22.SplinteringCold:IsAvailable() and not v22.RayofFrost:IsAvailable()) or v6:BuffUp(v22.FreezingRainBuff) or (v29 >= (1 + 2)))) then
		if v18.GroundSpellCondition() then
			if v47(v22.Blizzard) then
				return "blizzard single 16";
			end
		else
			v15(v22.Blizzard);
		end
	end
	if (v22.ShiftingPower:IsCastable() and (v24() or v16()) and (v43 or v17() or v7:IsDummy()) and (v6:BuffDown(v22.IcyVeinsBuff) or not v22.DeathsChill:IsAvailable()) and (v22.IcyVeins:CooldownRemains() > (15 - 5)) and (((v22.FrozenOrb:CooldownRemains() > (16 - 6)) and (not v22.CometStorm:IsAvailable() or (v22.CometStorm:CooldownRemains() > (1394 - (746 + 638))))) or (v22.IcyVeins:CooldownRemains() < (8 + 12)))) then
		if v47(v22.ShiftingPower, true) then
			return "shifting_power single 18";
		end
	end
	if (v22.GlacialSpike:IsCastable() and (v35 == (7 - 2)) and v18.TTDCastTimeCondition(v22.GlacialSpike, v43, v38)) then
		if v47(v22.GlacialSpike, true) then
			return "glacial_spike single 20";
		end
	end
	if (v22.IceLance:IsReady() and ((v6:BuffUp(v22.FingersofFrostBuff) and not v6:PrevGCDP(342 - (218 + 123), v22.GlacialSpike)) or ((v34 > (1581 - (1535 + 46))) and (not v22.RayofFrost:IsAvailable() or not v22.RayofFrost:IsCastable() or (v34 == (2 + 0)))))) then
		if v14(v22.IceLance, nil, nil) then
			return "ice_lance single 22";
		end
	end
	if (v17() and v22.IceNova:IsCastable() and v7:IsSpellInRange(v22.IceNova) and (v30 >= (1 + 3))) then
		if v14(v22.IceNova, nil, nil) then
			return "ice_nova single 24";
		end
	end
	if (v41:IsCastable() and (not v6:IsMoving() or v6:BuffUp(v22.FrostfireEmpowermentBuff)) and v18.TTDCastTimeCondition(v41, v43, v38)) then
		if v47(v41) then
			return "frostbolt single 26";
		end
	end
	if v6:IsMoving() then
		v40 = v55();
		if v40 then
			return v40;
		end
	end
end
local function v61()
	if v26.ShouldStopCastUpdate() then
		v13.CastMacro(566 - (306 + 254), true);
		return "Stop Cast For Silence";
	end
	if v18.IncorporealBeing() then
		if v18.AutoTarget() then
			return "Tab Away from Incorp";
		end
		return "Ignore Target Incorp";
	end
	local v71 = not v6:AffectingCombat() or not v7:AffectingCombat() or v7:IsDummy();
	v44 = v6:GetEnemiesInRange(3 + 37);
	v32 = v7:GetEnemiesInSplashRange(30 - 14);
	v45 = v18.RangeOOCCount() or #v44;
	v33 = #(v6:GetEnemiesInRange(1479 - (899 + 568)));
	v38 = v3.BossFightRemains();
	v32 = v7:GetEnemiesInSplashRange(11 + 5);
	v43 = true;
	if (v38 == (26887 - 15776)) then
		v43 = false;
		v38 = v3.FightRemains(v44, false);
	end
	if v17() then
		v29 = (v71 and v45) or v7:GetEnemiesInSplashRangeCount(611 - (268 + 335));
		v30 = (v71 and v45) or #v32;
	else
		v29 = 291 - (60 + 230);
		v30 = 573 - (426 + 146);
	end
	if (v26.TargetIsValid() or v6:AffectingCombat()) then
		if (v17() and (v30 > (1 + 0))) then
			v34 = v49(v32);
		else
			v34 = v7:DebuffStack(v22.WintersChillDebuff);
		end
		v35 = v6:BuffStackP(v22.IciclesBuff);
		v39 = v6:GCD() + (1456.25 - (282 + 1174));
	end
	if (not v6:AffectingCombat() and not v7:AffectingCombat()) then
		if (v22.ArcaneIntellect:IsCastable() and v28.Commons.AutoBuff and ((v26.GroupBuffMissing(v22.ArcaneIntellect) and (v6:IsInRaidArea() or v6:IsInDungeonArea()) and (v6:InstanceDifficulty() ~= (1016 - (569 + 242)))) or v6:BuffDown(v22.ArcaneIntellect, true))) then
			if v13.CastTarget(v22.ArcaneIntellect, "PLAYER") then
				return "arcane_intellect precombat 2";
			end
		end
		if (v22.IceBarrier:IsCastable() and (v6:BuffRemains(v22.IceBarrier) < (17 - 11))) then
			v13.Cast(v22.IceBarrier);
			return "Ice Barrier precombat";
		end
	end
	if (v18.CombatCheck() or v41:InFlight()) then
		if (not v6:AffectingCombat() and v13.ToggleIconFrame:GetToggle(1 + 0) and not v6:IsCasting()) then
			if not v7:IsSpellInRange(v41) then
				return "NOT IN RANGE";
			end
			v40 = v53();
			if v40 then
				return v40;
			end
		end
		if (v22.IceFloes:IsCastable() and v6:BuffUp(v22.IceFloes) and (v6:BuffStack(v22.IceFloes) < (1026 - (706 + 318))) and v6:IsMoving() and v6:IsCasting() and (v6:CastRemains() < (1251.5 - (721 + 530)))) then
			if v14(v22.IceFloes, true) then
				return "ice_floes movement 2";
			end
		end
		if (v22.EnergizedBarrier:IsAvailable() and (v6:DebuffElapsed(v22.EntangledDebuff) > (1272 - (945 + 326)))) then
			if v22.MassBarrier:IsReady() then
				v14(v22.MassBarrier);
				return "Cast MassBarrier Entangled";
			end
			if v22.IceBarrier:IsReady() then
				v14(v22.IceBarrier);
				return "Cast IceBarrier Entangled";
			end
		end
		if (v22.MassBarrier:IsCastable() and not v6:BuffUp(v22.IceCold) and (v6:HealthPercentage() < v28.Defense.MassBarrier)) then
			v13.Cast(v22.MassBarrier);
			return "Mass Barrier Defensive";
		end
		if (v22.IceBarrier:IsCastable() and not v6:BuffUp(v22.IceCold) and (v6:HealthPercentage() < v28.Defense.Barrier)) then
			v13.Cast(v22.IceBarrier);
			return "Ice Barrier Defensive";
		end
		if (v22.IceCold:IsCastable() and (v6:HealthPercentage() < v28.Defense.IceCold)) then
			v13.Cast(v22.IceBlock);
			return "Ice Cold Defensive";
		end
		if (v22.MirrorImage:IsCastable() and not v6:BuffUp(v22.IceCold) and (v6:HealthPercentage() < v28.Defense.MirrorImage)) then
			v13.Cast(v22.MirrorImage);
			return "Mass Barrier Defensive";
		end
		if v13.ToggleIconFrame:GetToggle(7 - 4) then
			v40 = not v6:IsCasting() and not v6:IsChanneling() and v26.InterruptCycle(v22.Counterspell, 36 + 4, true, nil, false);
			if v40 then
				return v40;
			end
			v40 = not v6:IsCasting() and not v6:IsChanneling() and v26.InterruptCycle(v22.DragonsBreath, 710 - (271 + 429), true, nil, true, true);
			if v40 then
				return v40;
			end
		end
		v40 = not v6:IsCasting(v22.Polymorph) and v26.IncorpCycle(v22.Polymorph, 28 + 2, true, nil, false);
		if v40 then
			return v40;
		end
		if v13.ToggleIconFrame:GetToggle(1504 - (1408 + 92)) then
			v40 = not v6:IsChanneling() and v22.SpellSteal:IsAvailable() and v18.StealCycle(v22.SpellSteal, 1126 - (461 + 625), false, v28.AutoTargetSpellSteal);
			if v40 then
				return v40;
			end
			v40 = not v6:IsCasting() and not v6:IsChanneling() and v22.RemoveCurse:IsAvailable() and v22.RemoveCurse:IsReady() and v26.DispelCycle(v22.RemoveCurse, "Curse");
			if v40 then
				return v40;
			end
			v40 = not v6:IsCasting() and not v6:IsChanneling() and v22.RemoveCurse:IsAvailable() and v22.RemoveCurse:IsReady() and v26.AfflictedLogic(v22.RemoveCurse);
			if v40 then
				return v40;
			end
		end
		if not v7:IsSpellInRange(v41) then
			return "NOT IN RANGE";
		end
		if v16() then
			v40 = v54();
			if v40 then
				return v40;
			end
		end
		if (v17() and (((v30 >= (1295 - (993 + 295))) and not v6:HasTier(2 + 28, 1173 - (418 + 753))) or ((v30 >= (2 + 2)) and v22.IceCaller:IsAvailable()))) then
			v40 = v56();
			if v40 then
				return v40;
			else
				v14(v22.Pool);
			end
		end
		if (v17() and (v30 >= (1 + 1)) and (v30 <= (1 + 2)) and v22.Splinterstorm:IsAvailable()) then
			local v82 = v57();
			if v82 then
				return v82;
			end
			if v13.CastAnnotated(v22.Pool, false, "WAIT") then
				return "pool for SSCleave()";
			end
		end
		if (v17() and (v30 >= (1 + 1)) and (v30 <= (532 - (406 + 123)))) then
			local v83 = v58();
			if v83 then
				return v83;
			end
			if v13.CastAnnotated(v22.Pool, false, "WAIT") then
				return "pool for Cleave()";
			end
		end
		if v22.Splinterstorm:IsAvailable() then
			local v84 = v59();
			if v84 then
				return v84;
			end
			if v13.CastAnnotated(v22.Pool, false, "WAIT") then
				return "pool for SSST()";
			end
		end
		local v81 = v60();
		if v81 then
			return v81;
		end
		if v13.CastAnnotated(v22.Pool, false, "WAIT") then
			return "pool for ST()";
		end
	end
end
local function v62()
	v22.WintersChillDebuff:RegisterAuraTracking();
	v28.Frost.Display();
	v13.Print("Frost Mage rotation has been updated for patch 11.0.2.");
	v13:UpdateMacro("macro1", "/use 16");
	v13:UpdateMacro("macro6", "/stopcasting");
	v13.ToggleIconFrame:AddButtonCustom("S", 1771 - (1749 + 20), "SmallCDs", "smallcds");
end
v13.SetAPL(16 + 48, v61, v62);
