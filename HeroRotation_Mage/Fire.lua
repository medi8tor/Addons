local v0, v1 = ...;
local v2 = HeroLib;
local v3 = v2.Unit;
local v4 = v3.Player;
local v5 = v3.Target;
local v6 = v2.Spell;
local v7 = v2.Item;
local v8 = HeroRotation();
local v9 = v8.Cast;
local v10 = v8.CastLeft;
local v11 = v8.CDsON;
local v12 = v8.AoEON;
local v13 = v8.Commons().Everyone.num;
local v14 = math.max;
local v15 = C_Timer.After;
local v16 = v8.Commons().Mage;
local v17 = v6.Mage.Fire;
local v18 = v7.Mage.Fire;
local v19 = {v18.ForgedGladiatorsBadge:ID(),v18.CrimsonGladiatorsBadge:ID(),v18.DraconicGladiatorsBadge:ID(),v18.ObsidianGladiatorsBadge:ID(),v18.VerdantGladiatorsBadge:ID(),v18.ImperfectAscendancySerum:ID(),v18.SpymastersWeb:ID(),v18.TreacherousTransmitter:ID(),v18.KahetiShadowweaversEmblem:ID()};
local v20 = v8.GUISettingsGet();
local v21 = v8.Commons().Everyone;
local v22 = {General=v20.General,Commons=v20.APL.Mage.Commons,Fire=v20.APL.Mage.Fire,Defense=v20.APL.Mage.Defense.Defensive};
local v23 = false;
local v24 = ((v17.Kindling:IsAvailable()) and (0.4 + 0)) or (878 - (282 + 595));
local v25 = 1647 - (1523 + 114);
local v26 = 2 + 0;
local v27 = false;
local v28 = 0 - 0;
local v29 = 1065 - (68 + 997);
local v30 = 1270 - (226 + 1044);
local v31 = 0 - 0;
local v32 = 157 - (32 + 85);
local v33 = 0 + 0;
local v34 = 1 + 0;
local v35 = 957 - (892 + 65);
local v36 = 14 - 8;
local v37 = 36 - 16;
local v38 = false;
local v39 = false;
local v40, v41 = false, false;
local v42, v43 = 0 - 0, 350 - (87 + 263);
local v44 = false;
local v45 = 180 - (67 + 113);
local v46;
local v47;
local v48;
local v49, v50 = false, false;
local v51 = 3 + 0;
local v52, v53, v54;
local v55, v56;
local v57, v58, v59;
local v60;
local v61 = 27279 - 16168;
local v62 = 8172 + 2939;
local v63;
local v64 = (v17.FrostfireBolt:IsAvailable() and v17.FrostfireBolt) or v17.Fireball;
local function v65()
	return v8.ToggleIconFrame:GetToggle(7 - 5) and v16.TTDCondition(v22.Fire.TimeToDie.SKB, IsBossfight, v62);
end
local v66, v67;
local v68;
local v69;
local v70 = 952 - (802 + 150);
local function v71()
	local v94, v95 = v4:GetTrinketData(v19);
	if ((v70 < (13 - 8)) and ((v94.ID == (0 - 0)) or (v95.ID == (0 + 0)) or ((v94.SpellID > (997 - (915 + 82))) and not v94.Usable) or ((v95.SpellID > (0 - 0)) and not v95.Usable))) then
		v70 = v70 + 1 + 0;
		v15(6 - 1, function()
			v71();
		end);
		return;
	end
	v66 = v94.Object;
	v67 = v95.Object;
	v68 = v18.ForgedGladiatorsBadge:IsEquipped() or v18.TreacherousTransmitter:IsEquipped() or v18.CrimsonGladiatorsBadge:IsEquipped() or v18.DraconicGladiatorsBadge:IsEquipped() or v18.ObsidianGladiatorsBadge:IsEquipped() or v18.VerdantGladiatorsBadge:IsEquipped() or v18.MoonlitPrism:IsEquipped() or v18.IrideusFragment:IsEquipped() or v18.SpoilsofNeltharus:IsEquipped() or v18.TimebreachingTalon:IsEquipped() or v18.HornofValor:IsEquipped();
	v69 = 1199 - (1069 + 118);
end
v71();
local function v72()
	v27 = v17.SunKingsBlessing:IsAvailable();
	v28 = ((8 - 4) * v13(v17.Quickflame:IsAvailable() or v17.FlamePatch:IsAvailable())) + ((2184 - 1185) * v13(not v17.FlamePatch:IsAvailable() and not v17.Quickflame:IsAvailable()));
	v29 = 174 + 825;
	VarCombustionFlamestrike = ((6 - 2) * v13(v17.Quickflame:IsAvailable() or v17.FlamePatch:IsAvailable())) + ((992 + 7) * v13(not v17.FlamePatch:IsAvailable() and not v17.Quickflame:IsAvailable()));
	v30 = ((794 - (368 + 423)) * v13(v17.Quickflame:IsAvailable() or v17.FlamePatch:IsAvailable())) + ((3139 - 2140) * v13(not v17.FlamePatch:IsAvailable() and not v17.Quickflame:IsAvailable()));
	v31 = 1017 - (10 + 8);
	v32 = 153 - 113;
	v33 = 1441 - (416 + 26);
	v34 = 3 - 2;
	v35 = 0 + 0;
	v36 = 9 - 3;
	v37 = (v68 and (458 - (145 + 293))) or v37;
end
v72();
v2:RegisterForEvent(function()
	v71();
end, "PLAYER_EQUIPMENT_CHANGED");
v2:RegisterForEvent(function()
	v17.Pyroblast:RegisterInFlight();
	v17.Fireball:RegisterInFlight();
	v17.FrostfireBolt:RegisterInFlight();
	v17.Meteor:RegisterInFlightEffect(351570 - (44 + 386));
	v17.Meteor:RegisterInFlight();
	v17.IceFloes:RegisterInFlight();
	v17.PhoenixFlames:RegisterInFlightEffect(259028 - (998 + 488));
	v17.PhoenixFlames:RegisterInFlight();
	v17.Pyroblast:RegisterInFlight(v17.CombustionBuff);
	v17.Fireball:RegisterInFlight(v17.CombustionBuff);
	v17.FrostfireBolt:RegisterInFlight(v17.CombustionBuff);
	v64 = (v17.FrostfireBolt:IsAvailable() and v17.FrostfireBolt) or v17.Fireball;
end, "SPELLS_CHANGED", "LEARNED_SPELL_IN_TAB");
v17.Pyroblast:RegisterInFlight();
v17.Fireball:RegisterInFlight();
v17.FrostfireBolt:RegisterInFlight();
v17.Meteor:RegisterInFlightEffect(111555 + 239585);
v17.Meteor:RegisterInFlight();
v17.IceFloes:RegisterInFlight();
v17.PhoenixFlames:RegisterInFlightEffect(210881 + 46661);
v17.PhoenixFlames:RegisterInFlight();
v17.Pyroblast:RegisterInFlight(v17.CombustionBuff);
v17.Fireball:RegisterInFlight(v17.CombustionBuff);
v17.FrostfireBolt:RegisterInFlight(v17.CombustionBuff);
v2:RegisterForEvent(function()
	v61 = 11883 - (201 + 571);
	v62 = 12249 - (116 + 1022);
end, "PLAYER_REGEN_ENABLED");
local function v73()
	if not v17.Scorch:IsAvailable() then
		return false;
	end
	if v4:BuffUp(v17.HeatShimmerBuff) then
		return true;
	end
	return v5:HealthPercentage() <= ((124 - 94) + ((3 + 2) * v13(v17.SunfuryExecution:IsAvailable())));
end
local function v74()
	return v17.Firestarter:IsAvailable() and (v5:HealthPercentage() > (328 - 238));
end
local function v75()
	return (v17.Firestarter:IsAvailable() and (((v5:HealthPercentage() > (319 - 229)) and v5:TimeToX(949 - (814 + 45))) or (0 - 0))) or (0 + 0);
end
local function v76()
	return v17.ImprovedScorch:IsAvailable() and (v5:HealthPercentage() < (11 + 19));
end
local function v77()
	return (v51 * v17.ShiftingPower:BaseDuration()) / v17.ShiftingPower:BaseTickTime();
end
local function v78()
	local v98 = (v74() and (v13(v17.Pyroblast:InFlight()) + v13(v64:InFlight()))) or (885 - (261 + 624));
	v98 = v98 + v13(v17.PhoenixFlames:InFlight() or v4:PrevGCDP(1 - 0, v17.PhoenixFlames));
	return v50 or v4:BuffUp(v17.HyperthermiaBuff) or (v49 and ((v76() and v4:IsCasting(v17.Scorch)) or (v74() and (v4:IsCasting(v64) or (v98 > (1080 - (1020 + 60)))))));
end
local function v79(v99)
	local v100 = 1423 - (630 + 793);
	for v119, v120 in pairs(v99) do
		if v120:DebuffUp(v17.IgniteDebuff) then
			v100 = v100 + (3 - 2);
		end
	end
	return v100;
end
local function v80()
	local v101 = 0 - 0;
	if (v17.Fireball:InFlight() or v17.Pyroblast:InFlight() or v17.PhoenixFlames:InFlight()) then
		v101 = v101 + 1 + 0;
	end
	return v101;
end
local function v81(v102, v103)
	if (v17.IceFloes:IsCastable() and (v17.IceFloes:TimeSinceLastCast() > (3 - 2)) and ((v4:IsMoving() and (v17.IceFloes:Charges() > (1748 - (760 + 987)))) or v103) and v4:BuffDown(v17.IceFloes)) then
		v9(v17.IceFloes, true);
		return "ice_floes";
	elseif (not v4:IsMoving() or v4:BuffUp(v17.IceFloes)) then
		v9(v102);
		return v102:Name();
	end
end
local function v82()
	if (v21.TargetIsValid() and not v4:AffectingCombat() and not v5:AffectingCombat()) then
		if v18.TreacherousTransmitter:IsEquippedAndReady() then
			if v9(v18.TreacherousTransmitter) then
				return "treacherous_transmitter precombat 4";
			end
		end
		if (v17.MirrorImage:IsCastable() and v22.Fire.MirrorImagesBeforePull) then
			if v9(v17.MirrorImage) then
				return "mirror_image precombat";
			end
		end
		if (v17.Flamestrike:IsReady() and v12() and v16.GroundSpellCondition() and not (v4:IsCasting(v17.Pyroblast) or v4:IsCasting(v17.Flamestrike)) and (v52 >= v28)) then
			if v9(v17.Flamestrike, true) then
				return "Flamestrike precombat";
			end
		end
		if (v17.Pyroblast:IsReady() and not (v4:IsCasting(v17.Pyroblast) or v4:IsCasting(v17.Flamestrike)) and (v52 < v30)) then
			if v9(v17.Pyroblast) then
				return "pyroblast precombat";
			end
		end
		if v17.PhoenixFlames:IsCastable() then
			if v9(v17.PhoenixFlames) then
				return "phoenix_flames precombat 10";
			end
		end
		if v64:IsReady() then
			if v9(v64) then
				return "fireball precombat 12";
			end
		end
	end
end
local function v83()
	if (v17.Meteor:IsReady() and v16.GroundSpellCondition() and (v46 or ((v25 - v4:BuffStack(v17.SunKingsBlessingBuff)) > (1917 - (1789 + 124))) or (v45 <= (766 - (745 + 21))) or (v48 > v17.Meteor:TravelTime()) or (not v17.SunKingsBlessing:IsAvailable() and ((16 + 29) < v45) and (v61 < v45)))) then
		if v9(v17.Meteor) then
			return "meteor active_talents 2";
		end
	end
	if (v17.DragonsBreath:IsReady() and v17.AlexstraszasFury:IsAvailable() and v47 and not v50 and (v4:BuffUp(v17.FeeltheBurnBuff) or (v2.CombatTime() > (40 - 25))) and not v76()) then
		if v5:IsInRange(31 - 23) then
			if v9(v17.DragonsBreath) then
				return "dragons_breath active_talents 6";
			end
		end
	end
end
local function v84()
	if (v22.Commons.Enabled.Potions and v11()) then
		local v121 = v21.PotionSelected();
		if (v121 and v121:IsReady()) then
			if v8.CastMacro(1 + 2, nil, nil, v121) then
				return "potion combustion_cooldowns";
			end
		end
	end
	if v17.BloodFury:IsCastable() then
		if v9(v17.BloodFury, true) then
			return "blood_fury combustion_cooldowns 4";
		end
	end
	if (v17.Berserking:IsCastable() and v46) then
		if v9(v17.Berserking, true) then
			return "berserking combustion_cooldowns 6";
		end
	end
	if v17.Fireblood:IsCastable() then
		if v9(v17.Fireblood, true) then
			return "fireblood combustion_cooldowns 8";
		end
	end
	if v17.AncestralCall:IsCastable() then
		if v9(v17.AncestralCall, true) then
			return "ancestral_call combustion_cooldowns 10";
		end
	end
	if (v22.Commons.Enabled.Trinkets and v11() and v16.TTDCondition(v22.Fire.TimeToDie.Trinkets, IsBossfight, v62)) then
		if v18.ForgedGladiatorsBadge:IsEquippedAndReady() then
			if v9(v18.ForgedGladiatorsBadge, true) then
				return "gladiators_badge (forged) combustion_cooldowns 12";
			end
		end
		if v18.CrimsonGladiatorsBadge:IsEquippedAndReady() then
			if v9(v18.CrimsonGladiatorsBadge, true) then
				return "gladiators_badge (crimson) combustion_cooldowns 14";
			end
		end
		if v18.DraconicGladiatorsBadge:IsEquippedAndReady() then
			if v9(v18.DraconicGladiatorsBadge, true) then
				return "gladiators_badge (draconic) combustion_cooldowns 16";
			end
		end
		if v18.ObsidianGladiatorsBadge:IsEquippedAndReady() then
			if v9(v18.ObsidianGladiatorsBadge, true) then
				return "gladiators_badge (obsidian) combustion_cooldowns 18";
			end
		end
		if v18.VerdantGladiatorsBadge:IsEquippedAndReady() then
			if v9(v18.VerdantGladiatorsBadge, true) then
				return "gladiators_badge (verdant) combustion_cooldowns 20";
			end
		end
		if (v18.KahetiShadowweaversEmblem:IsEquippedAndReady() and (v4:BuffStack(v17.KahetiShadowweaversEmblemBuff) >= (4 + 1))) then
			if v9(v18.KahetiShadowweaversEmblem) then
				return "Kaheti_Shadowweavers_Emblem items";
			end
		end
	end
end
local function v85()
	if ((v48 > v36) or (v61 < (1075 - (87 + 968)))) then
		local v122 = v84();
		if v122 then
			return v122;
		end
	end
	local v104 = v83();
	if v104 then
		return v104;
	end
	v44 = (v17.Combustion:CooldownRemains() < (44 - 34)) and v46;
	if (v17.Combustion:IsReady() and (v80() == (0 + 0)) and v47 and (v45 <= (0 - 0)) and ((v4:IsCasting(v17.Scorch) and (v17.Scorch:ExecuteRemains() < v34)) or (v4:IsCasting(v64) and (v64:ExecuteRemains() < v34)) or (v4:IsCasting(v17.Pyroblast) and (v17.Pyroblast:ExecuteRemains() < v34)) or (v4:IsCasting(v17.Flamestrike) and (v17.Flamestrike:ExecuteRemains() < v34)) or (not v17.IsothermicCore:IsAvailable() and v17.Meteor:InFlight() and (v17.Meteor:InFlightRemains() < v34)) or (v17.IsothermicCore:IsAvailable() and v17.Meteor:InFlight()))) then
		if v9(v17.Combustion, true) then
			return "combustion combustion_phase 2";
		end
	end
	if (v17.FireBlast:IsReady() and not v78() and (not v44 or v17.SunKingsBlessing:IsAvailable()) and not v40 and (not v76() or v4:IsCasting(v17.Scorch) or (v5:DebuffRemains(v17.ImprovedScorchDebuff) > ((1417 - (447 + 966)) * v4:GCD()))) and (v4:BuffDown(v17.FuryoftheSunKingBuff) or v4:IsCasting(v17.Pyroblast)) and v46 and not v50 and ((v80() + (v13(v49) * v13(v4:GCDRemains() > (0 - 0)))) < (1819 - (1703 + 114)))) then
		if v9(v17.FireBlast, true) then
			return "fire_blast combustion_phase 4";
		end
	end
	if (v17.FireBlast:IsReady() and not v78() and v44 and not v40 and (v17.FireBlast:ChargesFractional() > (703.5 - (376 + 325))) and (not v76() or v4:IsCasting(v17.Scorch) or (v5:DebuffRemains(v17.ImprovedScorchDebuff) > ((5 - 1) * v4:GCD()))) and (v4:BuffDown(v17.FuryoftheSunKingBuff) or v4:IsCasting(v17.Pyroblast)) and v46 and not v50 and ((v80() + (v13(v49) * v13(v4:GCDRemains() > (0 - 0)))) < (1 + 1))) then
		if v9(v17.FireBlast, true) then
			return "fire_blast combustion_phase 6";
		end
	end
	if (v12() and v16.GroundSpellCondition() and v65() and v16.TTDCastTimeCondition(v17.Flamestrike, IsBossfight, v62) and v17.Flamestrike:IsReady() and not v4:IsCasting(v17.Flamestrike) and v47 and v4:BuffUp(v17.FuryoftheSunKingBuff) and (v4:BuffRemains(v17.FuryoftheSunKingBuff) > v17.Flamestrike:CastTime()) and (v17.Combustion:CooldownRemains() < v17.Flamestrike:CastTime()) and (v52 >= v30)) then
		if v81(v17.Flamestrike) then
			return "flamestrike combustion_phase 8";
		end
	end
	if (v17.Pyroblast:IsReady() and v65() and v16.TTDCastTimeCondition(v17.Pyroblast, IsBossfight, v62) and not v4:IsCasting(v17.Pyroblast) and v47 and v4:BuffUp(v17.FuryoftheSunKingBuff) and (v4:BuffRemains(v17.FuryoftheSunKingBuff) > v17.Pyroblast:CastTime()) and v4:BuffUp(v17.FlameAccelerantBuff)) then
		if v81(v17.Pyroblast, true) then
			return "pyroblast combustion_phase 10";
		end
	end
	if (v17.Meteor:IsReady() and v16.GroundSpellCondition() and v17.IsothermicCore:IsAvailable() and v47 and (v17.Combustion:CooldownRemains() < v17.Meteor:CastTime())) then
		if v9(v17.Meteor) then
			return "meteor combustion_phase 12";
		end
	end
	if (v64:IsReady() and v47 and (v48 < v64:CastTime()) and (v54 < (4 - 2)) and not v76() and not (v17.SunKingsBlessing:IsAvailable() and v17.FlameAccelerant:IsAvailable())) then
		if v81(v64) then
			return "fireball combustion_phase 14";
		end
	end
	if (v17.Scorch:IsReady() and v47 and (v17.Combustion:CooldownRemains() < v17.Scorch:CastTime())) then
		if v9(v17.Scorch) then
			return "scorch combustion_phase 16";
		end
	end
	if (v64:IsReady() and v47 and v4:BuffUp(v17.FrostfireEmpowermentBuff)) then
		if v81(v64) then
			return "fireball combustion_phase 17";
		end
	end
	v44 = (v17.Combustion:CooldownRemains() < (24 - (9 + 5))) and v46;
	if (v17.PhoenixFlames:IsCastable() and v17.SpellfireSpheres:IsAvailable() and v17.PhoenixReborn:IsAvailable() and v49 and not v50 and v4:BuffUp(v17.FlamesFuryBuff)) then
		if v9(v17.PhoenixFlames) then
			return "phoenix_flames combustion_phase 18";
		end
	end
	if (v12() and v16.GroundSpellCondition() and v17.Flamestrike:IsReady() and ((v50 and (v52 >= VarCombustionFlamestrike)) or (v4:BuffUp(v17.HyperthermiaBuff) and (v52 >= (VarCombustionFlamestrike - v13(v17.Hyperthermia:IsAvailable())))))) then
		if v9(v17.Flamestrike, true) then
			return "flamestrike combustion_phase 19";
		end
	end
	if (v17.Pyroblast:IsReady() and (v4:BuffUp(v17.HyperthermiaBuff))) then
		if v9(v17.Pyroblast, true) then
			return "pyroblast combustion_phase 20";
		end
	end
	if (v17.Pyroblast:IsReady() and v50 and v46) then
		if v9(v17.Pyroblast, true) then
			return "pyroblast combustion_phase 22";
		end
	end
	if (v17.Pyroblast:IsReady() and v4:PrevGCDP(377 - (85 + 291), v17.Scorch) and v49 and (v52 < VarCombustionFlamestrike) and v46) then
		if v9(v17.Pyroblast, true) then
			return "pyroblast combustion_phase 24";
		end
	end
	if (v12() and v65() and v16.TTDCastTimeCondition(v17.Flamestrike, IsBossfight, v62) and v17.Flamestrike:IsReady() and v16.GroundSpellCondition() and not v4:IsCasting(v17.Flamestrike) and v4:BuffUp(v17.FuryoftheSunKingBuff) and (v4:BuffRemains(v17.FuryoftheSunKingBuff) > v17.Flamestrike:CastTime()) and (v52 >= v30)) then
		if v81(v17.Flamestrike, true) then
			return "flamestrike combustion_phase 26";
		end
	end
	if (v17.Pyroblast:IsReady() and not v4:IsCasting(v17.Pyroblast) and v65() and v16.TTDCastTimeCondition(v17.Pyroblast, IsBossfight, v62) and v4:BuffUp(v17.FuryoftheSunKingBuff) and (v4:BuffRemains(v17.FuryoftheSunKingBuff) > v17.Pyroblast:CastTime())) then
		if v81(v17.Pyroblast, true) then
			return "pyroblast combustion_phase 28";
		end
	end
	if (v64:IsReady() and v4:BuffUp(v17.FrostfireEmpowermentBuff) and not v50 and v4:BuffDown(v17.ExcessFrostBuff)) then
		if v81(v64) then
			return "fireball combustion_phase 30";
		end
	end
	if (v17.PhoenixFlames:IsCastable() and v17.PhoenixReborn:IsAvailable() and ((v13(v49) + v80()) < (1267 - (243 + 1022))) and v4:BuffUp(v17.FlamesFuryBuff)) then
		if v9(v17.PhoenixFlames) then
			return "phoenix_flames combustion_phase 32";
		end
	end
	if (v17.Scorch:IsReady() and v76() and (v5:DebuffRemains(v17.ImprovedScorchDebuff) < ((14 - 10) * v63)) and (v54 < VarCombustionFlamestrike)) then
		if v9(v17.Scorch) then
			return "scorch combustion_phase 34";
		end
	end
	if (v17.Scorch:IsReady() and v4:BuffUp(v17.HeatShimmerBuff) and (v17.Scald:IsAvailable() or v17.ImprovedScorch:IsAvailable()) and (v54 < VarCombustionFlamestrike)) then
		if v9(v17.Scorch) then
			return "scorch combustion_phase 36";
		end
	end
	if (v17.PhoenixFlames:IsCastable() and ((not v17.CalloftheSunKing:IsAvailable() and (v17.PhoenixFlames:TravelTime() < v48)) or (v17.CalloftheSunKing:IsAvailable() and (v48 < (4 + 0))) or (v4:BuffStack(v17.SunKingsBlessingBuff) < (1188 - (1123 + 57)))) and ((v13(v49) + v80()) < (2 + 0))) then
		if v9(v17.PhoenixFlames) then
			return "phoenix_flames combustion_phase 38";
		end
	end
	if (v64:IsReady() and v4:BuffUp(v17.FrostfireEmpowermentBuff) and not v50) then
		if v81(v64) then
			return "fireball combustion_phase 40";
		end
	end
	if (v17.Scorch:IsReady() and (v48 > v17.Scorch:CastTime()) and (v17.Scorch:CastTime() >= v4:GCD())) then
		if v9(v17.Scorch) then
			return "scorch combustion_phase 42";
		end
	end
	if v64:IsReady() then
		if v81(v64) then
			return "fireball combustion_phase 44";
		end
	end
end
local function v86()
	v42 = v17.Combustion:CooldownRemains() * v24;
	v43 = ((v64:CastTime() * v13(v52 < VarCombustionFlamestrike)) + (v17.Flamestrike:CastTime() * v13(v52 >= VarCombustionFlamestrike))) - v34;
	v45 = v42;
	if (v17.Firestarter:IsAvailable() and not v27) then
		v45 = v14(v75(), v45);
	end
	if (v17.SunKingsBlessing:IsAvailable() and v74() and (v4:BuffDown(v17.FuryoftheSunKingBuff) or not v65())) then
		v45 = v14((v25 - v4:BuffStack(v17.SunKingsBlessingBuff)) * (257 - (163 + 91)) * v63, v45);
	end
	if (v18.ForgedGladiatorsBadge:IsEquipped() and ((v18.ForgedGladiatorsBadge:CooldownRemains() - (1950 - (1869 + 61))) < v45)) then
		v45 = v14(v18.ForgedGladiatorsBadge:CooldownRemains(), v45);
	end
	if (v18.CrimsonGladiatorsBadge:IsEquipped() and ((v18.CrimsonGladiatorsBadge:CooldownRemains() - (6 + 14)) < v45)) then
		v45 = v14(v18.CrimsonGladiatorsBadge:CooldownRemains(), v45);
	end
	if (v18.DraconicGladiatorsBadge:IsEquipped() and ((v18.DraconicGladiatorsBadge:CooldownRemains() - (70 - 50)) < v45)) then
		v45 = v14(v18.DraconicGladiatorsBadge:CooldownRemains(), v45);
	end
	if (v18.ObsidianGladiatorsBadge:IsEquipped() and ((v18.ObsidianGladiatorsBadge:CooldownRemains() - (30 - 10)) < v45)) then
		v45 = v14(v18.ObsidianGladiatorsBadge:CooldownRemains(), v45);
	end
	if (v18.VerdantGladiatorsBadge:IsEquipped() and ((v18.VerdantGladiatorsBadge:CooldownRemains() - (3 + 17)) < v45)) then
		v45 = v14(v18.VerdantGladiatorsBadge:CooldownRemains(), v45);
	end
	v45 = v14(v48, v45);
	if (((v42 + ((164 - 44) * ((1 + 0) - (((1474.4 - (1329 + 145)) + ((971.2 - (140 + 831)) * v13(v17.Firestarter:IsAvailable()))) * v13(v17.Kindling:IsAvailable()))))) <= v45) or (v45 > (v62 - (1870 - (1409 + 441))))) then
		v45 = v42;
	end
	if v23 then
		v45 = 1717 - (15 + 703);
	end
end
local function v87()
	if (v17.FireBlast:IsReady() and not v78() and not v40 and not v50 and ((v13(v49) + v80()) == (1 + 0)) and (v17.ShiftingPower:CooldownUp() or (v17.FireBlast:Charges() > (439 - (262 + 176))) or (v4:BuffRemains(v17.FeeltheBurnBuff) < ((1723 - (345 + 1376)) * v63)))) then
		if v9(v17.FireBlast, true) then
			return "fire_blast firestarter_fire_blasts 2";
		end
	end
	if (v17.FireBlast:IsReady() and not v78() and not v40 and ((v13(v49) + v80()) == (689 - (198 + 490))) and ((v17.FeeltheBurn:IsAvailable() and (v4:BuffRemains(v17.FeeltheBurnBuff) < v4:GCDRemains())) or v17.ShiftingPower:CooldownUp())) then
		if v10(v17.FireBlast, true) then
			return "fire_blast firestarter_fire_blasts 4";
		end
	end
end
local function v88()
	if (v12() and v16.GroundSpellCondition() and v17.Flamestrike:IsReady() and (v52 >= v28) and (v50 or v4:BuffUp(v17.HyperthermiaBuff))) then
		if v9(v17.Flamestrike, true) then
			return "flamestrike standard_rotation 2";
		end
	end
	if (v64:IsReady() and v50 and v4:BuffDown(v17.FrostfireEmpowermentBuff) and v4:BuffDown(v17.HyperthermiaBuff) and v17.ShiftingPower:CooldownDown() and (v17.PhoenixFlames:Charges() < (4 - 3)) and not v73() and not v4:PrevGCDP(2 - 1, v64)) then
		if v81(v64) then
			return "fireball standard_rotation 4";
		end
	end
	if (v17.Pyroblast:IsReady() and v78()) then
		if v9(v17.Pyroblast, true) then
			return "pyroblast standard_rotation 6";
		end
	end
	if (v17.FireBlast:IsReady() and not v78() and not v74() and (not v40 or v17.SpontaneousCombustion:IsAvailable()) and (v4:BuffDown(v17.FuryoftheSunKingBuff) or not v65()) and (((v4:IsCasting(v64) or v4:IsCasting(v17.Pyroblast)) and v49) or (v73() and (not v76() or (v5:DebuffStack(v17.ImprovedScorchDebuff) == v26) or (v17.FireBlast:FullRechargeTime() < (1209 - (696 + 510)))) and ((v49 and not v4:IsCasting(v17.Scorch)) or (not v50 and not v49 and v4:IsCasting(v17.Scorch) and (v80() == (0 - 0))))))) then
		if v9(v17.FireBlast, true) then
			return "fire_blast standard_rotation 8";
		end
	end
	if (v17.FireBlast:IsReady() and not v78() and ((not v74() and (not v40 or v17.SpontaneousCombustion:IsAvailable()) and (v4:BuffDown(v17.FuryoftheSunKingBuff) or not v65()) and v49 and (v80() < (1263 - (1091 + 171))) and (v4:PrevGCDP(1 + 0, v17.PhoenixFlames) or v4:PrevGCDP(3 - 2, v17.Scorch))) or (((v4:BloodlustUp() and (v17.FireBlast:ChargesFractional() > (3.5 - 2))) or (v17.FireBlast:ChargesFractional() > (376.5 - (123 + 251))) or (v4:BuffRemains(v17.FeeltheBurnBuff) < (0.5 - 0)) or (((v17.FireBlast:FullRechargeTime() * (699 - (208 + 490))) - ((0.5 + 0) * v13(v17.ShiftingPower:CooldownUp()))) < (3 + 3))) and v49))) then
		if v10(v17.FireBlast, true) then
			return "fire_blast standard_rotation 10";
		end
	end
	if (v12() and v65() and v16.TTDCastTimeCondition(v17.Flamestrike, IsBossfight, v62) and v16.GroundSpellCondition() and v17.Flamestrike:IsReady() and not v4:IsCasting(v17.Flamestrike) and (v52 >= v30) and v4:BuffUp(v17.FuryoftheSunKingBuff)) then
		if v81(v17.Flamestrike, true) then
			return "flamestrike standard_rotation 12";
		end
	end
	if (v17.Scorch:IsReady() and v76() and (v5:DebuffRemains(v17.ImprovedScorchDebuff) < (v17.Pyroblast:CastTime() + ((841 - (660 + 176)) * v63))) and v65() and v4:BuffUp(v17.FuryoftheSunKingBuff) and not v4:IsCasting(v17.Scorch)) then
		if v9(v17.Scorch) then
			return "scorch standard_rotation 14";
		end
	end
	if (v17.Pyroblast:IsReady() and v65() and v16.TTDCastTimeCondition(v17.Pyroblast, IsBossfight, v62) and not v4:IsCasting(v17.Pyroblast) and (v4:BuffUp(v17.FuryoftheSunKingBuff))) then
		if v81(v17.Pyroblast, true) then
			return "pyroblast standard_rotation 16";
		end
	end
	if (v17.Pyroblast:IsReady() and v4:PrevGCDP(1 + 0, v17.Scorch) and v50 and v73() and (v54 < v28)) then
		if v9(v17.Pyroblast, true) then
			return "pyroblast standard_rotation 18";
		end
	end
	if (v17.Scorch:IsReady() and v76() and (v5:DebuffRemains(v17.ImprovedScorchDebuff) < v63)) then
		if v9(v17.Scorch) then
			return "scorch standard_rotation 20";
		end
	end
	if (v64:IsReady() and v4:BuffUp(v17.FrostfireEmpowermentBuff) and not v50 and v4:BuffDown(v17.ExcessFrostBuff)) then
		if v81(v64) then
			return "fireball standard_rotation 22";
		end
	end
	if (v17.Scorch:IsReady() and v4:BuffUp(v17.HeatShimmerBuff) and (v17.Scald:IsAvailable() or v17.ImprovedScorch:IsAvailable()) and (v54 < VarCombustionFlamestrike)) then
		if v9(v17.Scorch) then
			return "scorch standard_rotation 24";
		end
	end
	if (v17.PhoenixFlames:IsCastable() and ((not v50 and (v80() < (203 - (14 + 188))) and (not v4:PrevGCDP(676 - (534 + 141), v17.Fireball) or (not v49 and not v50))) or ((v80() < (1 + 1)) and v4:BuffUp(v17.FlamesFuryBuff)))) then
		if v9(v17.PhoenixFlames) then
			return "phoenix_flames standard_rotation 26";
		end
	end
	local v105 = v83();
	if v105 then
		return v105;
	end
	if (v12() and v17.DragonsBreath:IsReady() and (v54 > (1 + 0)) and v17.AlexstraszasFury:IsAvailable()) then
		if v5:IsInRange(10 + 0) then
			if v9(v17.DragonsBreath) then
				return "dragons_breath standard_rotation 28 ";
			end
		end
	end
	if (v17.Scorch:IsReady() and (v73() or v4:BuffUp(v17.HeatShimmerBuff))) then
		if v9(v17.Scorch) then
			return "scorch standard_rotation 30";
		end
	end
	if (v12() and v17.ArcaneExplosion:IsReady() and (v54 >= v31) and (v4:ManaPercentageP() >= v32)) then
		if v5:IsInRange(21 - 11) then
			if v9(v17.ArcaneExplosion) then
				return "arcane_explosion standard_rotation 32";
			end
		end
	end
	if (v16.GroundSpellCondition() and v12() and v17.Flamestrike:IsReady() and (v52 >= v29)) then
		if v81(v17.Flamestrike) then
			return "flamestrike standard_rotation 34";
		end
	end
	if (v64:IsReady() and not v78()) then
		if v81(v64) then
			return "fireball standard_rotation 36";
		end
	end
end
local function v89(v106)
	if (v106:Exists() and (v106:GUID() ~= v5:GUID()) and not v106:IsDeadOrGhost() and (v106:HealthPercentage() < (47 - 17)) and v106:IsSpellInRange(v17.Scorch)) then
		return true;
	end
end
local function v90()
	if v21.ShouldStopCastUpdate() then
		v8.CastMacro(16 - 10, true);
		return "Stop Cast For Silence";
	end
	if v16.IncorporealBeing() then
		if v16.AutoTarget() then
			return "Tab Away from Incorp";
		end
		return "Ignore Target Incorp";
	end
	local v107 = not v4:AffectingCombat() or not v5:AffectingCombat() or v5:IsDummy();
	Enemies40Yard = v4:GetEnemiesInRange(22 + 18);
	EnemiesRangeOOCCount = v16.RangeOOCCount() or #Enemies40Yard;
	v62 = v2.BossFightRemains();
	IsBossfight = true;
	if ((v62 == (7075 + 4036)) or v5:IsDummy()) then
		IsBossfight = false;
		v62 = v2.FightRemains(Enemies40Yard, false);
	end
	v57 = v5:GetEnemiesInSplashRange(404 - (115 + 281));
	v58 = v4:GetEnemiesInMeleeRange(23 - 13);
	if v12() then
		v52 = (v107 and EnemiesRangeOOCCount) or v5:GetEnemiesInSplashRangeCount(7 + 1);
		v54 = (v107 and EnemiesRangeOOCCount) or v5:GetEnemiesInSplashRangeCount(38 - 22);
	else
		v52 = 3 - 2;
		v54 = 868 - (550 + 317);
	end
	if (v22.Commons.ForceAOE and v12()) then
		v52 = 142 - 43;
	end
	v23 = not v11() or not v16.TTDCondition(v22.Fire.TimeToDie.Combustion, IsBossfight, v62);
	if (v16.Precast() and not v4:AffectingCombat() and not v5:AffectingCombat() and v5:IsSpellInRange(v64)) then
		ShouldReturn = v82();
		if ShouldReturn then
			return ShouldReturn;
		end
	end
	if (v21.TargetIsValid() or v4:AffectingCombat()) then
		v63 = math.floor(v4:GCD() * (1405 - 405)) / (2794 - 1794);
		v46 = v4:BuffUp(v17.CombustionBuff);
		v47 = not v46;
		v48 = (v46 and v4:BuffRemains(v17.CombustionBuff)) or (285 - (134 + 151));
	end
	if (not v4:AffectingCombat() and not v5:AffectingCombat()) then
		if (v17.ArcaneIntellect:IsCastable() and v22.Commons.AutoBuff and ((v21.GroupBuffMissing(v17.ArcaneIntellect) and (v4:IsInRaidArea() or v4:IsInDungeonArea()) and (v4:InstanceDifficulty() ~= (1870 - (970 + 695)))) or v4:BuffDown(v17.ArcaneIntellect, true))) then
			if v8.CastTarget(v17.ArcaneIntellect, "PLAYER") then
				return "arcane_intellect precombat 2";
			end
		end
		if (v17.BlazingBarrier:IsCastable() and (v4:BuffRemains(v17.BlazingBarrier) < (11 - 5))) then
			v8.Cast(v17.BlazingBarrier);
			return "Blazing Barriers precombat";
		end
	end
	v49 = v4:BuffUp(v17.HeatingUpBuff);
	v50 = v4:BuffUp(v17.HotStreakBuff);
	if v16.CombatCheck() then
		if (v17.IceFloes:IsCastable() and v4:BuffUp(v17.IceFloes) and (v4:BuffStack(v17.IceFloes) < (1992 - (582 + 1408))) and v4:IsMoving() and v4:IsCasting() and (v4:CastRemains() < (0.5 - 0)) and (v4:CastSpellID() ~= v17.Scorch:ID())) then
			if v9(v17.IceFloes, true) then
				return "ice_floes movement 2";
			end
		end
		if (v17.IceCold:IsCastable() and (v4:HealthPercentage() < v22.Defense.IceCold)) then
			v8.Cast(v17.IceBlock, true);
			return "Ice Cold Defensive";
		end
		if not v46 then
			if (v17.EnergizedBarrier:IsAvailable() and (v4:DebuffElapsed(v17.EntangledDebuff) > (1 - 0))) then
				if v17.MassBarrier:IsReady() then
					v9(v17.MassBarrier);
					return "Cast MassBarrier Entangled";
				end
				if v17.BlazingBarrier:IsReady() then
					v9(v17.BlazingBarrier);
					return "Cast BlazingBarrier Entangled";
				end
			end
			if (v17.MassBarrier:IsCastable() and not v4:BuffUp(v17.IceCold) and (v4:HealthPercentage() < v22.Defense.MassBarrier)) then
				v8.Cast(v17.MassBarrier);
				return "Mass Barrier Defensive";
			end
			if (v17.BlazingBarrier:IsCastable() and not v4:BuffUp(v17.IceCold) and (v4:HealthPercentage() < v22.Defense.Barrier)) then
				v8.Cast(v17.BlazingBarrier);
				return "Blazing Barrier Defensive";
			end
			if (v17.MirrorImage:IsCastable() and not v4:BuffUp(v17.IceCold) and (v4:HealthPercentage() < v22.Defense.MirrorImage)) then
				v8.Cast(v17.MirrorImage);
				return "Mass Barrier Defensive";
			end
		end
		if v8.ToggleIconFrame:GetToggle(11 - 8) then
			ShouldReturn = not v4:IsCasting() and not v4:IsChanneling() and v21.InterruptCycle(v17.Counterspell, 1864 - (1195 + 629), true, nil, false);
			if ShouldReturn then
				return ShouldReturn;
			end
			ShouldReturn = not v4:IsCasting() and not v4:IsChanneling() and v21.InterruptCycle(v17.DragonsBreath, 10 - 2, true, nil, true, true);
			if ShouldReturn then
				return ShouldReturn;
			end
		end
		ShouldReturn = not v4:IsCasting(v17.Polymorph) and v21.IncorpCycle(v17.Polymorph, 271 - (187 + 54), true, nil, false);
		if ShouldReturn then
			return ShouldReturn;
		end
		if v8.ToggleIconFrame:GetToggle(784 - (162 + 618)) then
			ShouldReturn = not v4:IsChanneling() and v17.SpellSteal:IsAvailable() and v16.StealCycle(v17.SpellSteal, 29 + 11, false, v22.AutoTargetSpellSteal);
			if ShouldReturn then
				return ShouldReturn;
			end
			ShouldReturn = not v4:IsCasting() and not v46 and not v4:IsChanneling() and v17.RemoveCurse:IsAvailable() and v17.RemoveCurse:IsReady() and v21.DispelCycle(v17.RemoveCurse, "Curse");
			if ShouldReturn then
				return ShouldReturn;
			end
			ShouldReturn = not v4:IsCasting() and not v4:IsChanneling() and v17.RemoveCurse:IsAvailable() and v17.RemoveCurse:IsReady() and v21.AfflictedLogic(v17.RemoveCurse);
			if ShouldReturn then
				return ShouldReturn;
			end
		end
		if not v5:IsSpellInRange(v64) then
			return "NOT IN RANGE";
		end
		if (v17.SearingTouch:IsAvailable() and v22.Fire.UseScorchSniping and v12() and (v5:HealthPercentage() > (20 + 10))) then
			ShouldReturn = v21.CastCycle(v17.Scorch, Enemies40Yard, v89, 85 - 45, nil, nil, false);
			if ShouldReturn then
				return ShouldReturn;
			end
		end
		v86();
		if (v22.Commons.Enabled.Potions and v11()) then
			local v123 = v21.PotionSelected();
			if (v123 and v123:IsReady() and (v123:BuffDuration() > (v45 + (19 - 7)))) then
				if v8.CastMacro(1 + 2, nil, nil, v123) then
					return "potion main 4";
				end
			end
		end
		v38 = v45 > v17.ShiftingPower:CooldownRemains();
		if (v22.Commons.Enabled.Trinkets and v11() and v16.TTDCondition(v22.Fire.TimeToDie.Trinkets, IsBossfight, v62)) then
			v39 = ((v45 < v37) or ((v48 > v36) and (v18.DragonfireBombDispenser:CooldownUp() or not v18.DragonfireBombDispenser:IsEquipped()))) and ((v13((v66:Cooldown() > (1636 - (1373 + 263))) and (v66:CooldownRemains() < v37)) + v13(v67:Cooldown() and (v67:CooldownRemains() < v37))) > (1001 - (451 + 549)));
			if (v18.SpymastersWeb:IsEquippedAndReady() and (v48 > (4 + 6)) and (v62 < (31 - 11))) then
				if v9(v18.SpymastersWeb) then
					return "spymasters_web main 6";
				end
			end
			if (v18.TreacherousTransmitter:IsEquippedAndReady() and ((v45 < (16 - 6)) or (v61 < (1409 - (746 + 638))))) then
				if v9(v18.TreacherousTransmitter) then
					return "treacherous_transmitter main 8";
				end
			end
			if (v18.ImperfectAscendancySerum:IsEquippedAndReady() and (v45 < (2 + 1))) then
				if v9(v18.ImperfectAscendancySerum) then
					return "imperfect_ascendancy_serum main 10";
				end
			end
			if (v18.ForgedGladiatorsBadge:IsEquippedAndReady() and (v45 > (v18.ForgedGladiatorsBadge:Cooldown() - (7 - 2)))) then
				if v9(v18.ForgedGladiatorsBadge) then
					return "gladiators_badge (forged) main 12";
				end
			end
			if (v18.CrimsonGladiatorsBadge:IsEquippedAndReady() and (v45 > (v18.CrimsonGladiatorsBadge:Cooldown() - (346 - (218 + 123))))) then
				if v9(v18.CrimsonGladiatorsBadge) then
					return "gladiators_badge (crimson) main 12";
				end
			end
			if (v18.DraconicGladiatorsBadge:IsEquippedAndReady() and (v45 > (v18.DraconicGladiatorsBadge:Cooldown() - (1586 - (1535 + 46))))) then
				if v9(v18.DraconicGladiatorsBadge) then
					return "gladiators_badge (draconic) main 12";
				end
			end
			if (v18.ObsidianGladiatorsBadge:IsEquippedAndReady() and (v45 > (v18.ObsidianGladiatorsBadge:Cooldown() - (5 + 0)))) then
				if v9(v18.ObsidianGladiatorsBadge) then
					return "gladiators_badge (obsidian) main 12";
				end
			end
			if (v18.VerdantGladiatorsBadge:IsEquippedAndReady() and (v45 > (v18.VerdantGladiatorsBadge:Cooldown() - (1 + 4)))) then
				if v9(v18.VerdantGladiatorsBadge) then
					return "gladiators_badge (verdant) main 12";
				end
			end
			if (v18.KahetiShadowweaversEmblem:IsEquippedAndReady() and (v4:BuffStack(v17.KahetiShadowweaversEmblemBuff) >= (565 - (306 + 254)))) then
				if v9(v18.KahetiShadowweaversEmblem) then
					return "Kaheti_Shadowweavers_Emblem items";
				end
			end
		end
		if (v22.Commons.Enabled.Trinkets and v11() and v16.TTDCondition(v22.Fire.TimeToDie.Trinkets, IsBossfight, v62) and not v39) then
			local v124, v125, v126 = v4:GetUseableItems(v19);
			if v124 then
				if (((v125 == (1 + 12)) or (v125 == (27 - 13))) and v22.Commons.Enabled.Trinkets) then
					if v9(v124) then
						return "Generic use_items for " .. v124:Name() .. " main 14";
					end
				end
			end
		end
		v40 = v47 and (((v17.FireBlast:ChargesFractional() + ((v45 + (v77() * v13(v38))) / v17.FireBlast:Cooldown())) - (1468 - (899 + 568))) < ((v17.FireBlast:MaxCharges() + (v35 / v17.FireBlast:Cooldown())) - (((8 + 4) / v17.FireBlast:Cooldown()) % (2 - 1)))) and (v45 < v62);
		if ((v45 <= (603 - (268 + 335))) or v46 or ((v45 < v43) and (v17.Combustion:CooldownRemains() < v43))) then
			local v127 = v85();
			if v127 then
				return v127;
			end
		end
		if (not v40 and v17.SunKingsBlessing:IsAvailable()) then
			v40 = v73() and (v17.FireBlast:FullRechargeTime() > ((293 - (60 + 230)) * v63));
		end
		if (v17.FireBlast:IsReady() and not v78() and v4:IsChanneling(v17.ShiftingPower) and ((v17.FireBlast:FullRechargeTime() < v51) or (v17.SunKingsBlessing:IsAvailable() and v49))) then
			if v9(v17.FireBlast, true) then
				return "fire_blast main 16";
			end
		end
		if (v17.ShiftingPower:IsReady() and v11() and v5:IsInRange(590 - (426 + 146)) and v47 and (not v76() or ((v5:DebuffRemains(v17.ImprovedScorchDebuff) > (v17.ShiftingPower:CastTime() + v17.Scorch:CastTime())) and (v4:BuffDown(v17.FuryoftheSunKingBuff) or not v65()))) and not v50 and v4:BuffDown(v17.HyperthermiaBuff) and ((v17.PhoenixFlames:Charges() <= (1 + 0)) or (v17.Combustion:CooldownRemains() < (1476 - (282 + 1174))))) then
			if v81(v17.ShiftingPower, true) then
				return "shifting_power main 18";
			end
		end
		if v4:IsChanneling(v17.ShiftingPower) then
			if v9(v17.Pool) then
				return "stop casting during shifting power";
			end
		end
		if not v17.SunKingsBlessing:IsAvailable() then
			v41 = ((((v45 + (816 - (569 + 242))) < ((v17.PhoenixFlames:FullRechargeTime() + v17.PhoenixFlames:Cooldown()) - (v77() * v13(v38)))) and (v45 < v62)) or v17.SunKingsBlessing:IsAvailable()) and not v17.AlexstraszasFury:IsAvailable();
		end
		if (v17.FireBlast:IsReady() and not v78() and not v40 and (v45 > (0 - 0)) and (v52 >= v29) and not v74() and not v50 and ((v49 and (v17.Flamestrike:ExecuteRemains() < (0.5 + 0))) or (v17.FireBlast:ChargesFractional() >= (1026 - (706 + 318))))) then
			if v9(v17.FireBlast) then
				return "fire_blast main 20";
			end
		end
		if (v47 and v74() and (v45 > (1251 - (721 + 530)))) then
			local v128 = v87();
			if v128 then
				return v128;
			end
		end
		if ((v45 > (1271 - (945 + 326))) and v47) then
			local v129 = v88();
			if v129 then
				return v129;
			end
		end
		if (v17.IceNova:IsCastable() and not v73() and v5:IsSpellInRange(v17.IceNova)) then
			if v9(v17.IceNova) then
				return "ice_nova main 22";
			end
		end
		if v17.Scorch:IsReady() then
			if v9(v17.Scorch) then
				return "scorch main 24";
			end
		end
	end
end
local function v91(v108, v109)
	return (v108:gsub("{(.-)}", v109));
end
local function v92(v110)
	local v111 = v4:GetEquipment();
	local v112, v113 = v111[32 - 19], v111[13 + 1];
	if (v112 and (v110:ID() == v112)) then
		return 713 - (271 + 429);
	elseif (v113 and (v110:ID() == v113)) then
		return 13 + 1;
	end
end
local function v93()
	v22.Fire.Display();
	v2.Timer.PulseOffset = 1500.01 - (1408 + 92);
	v8:UpdateMacro("macro1", "/use 16");
	local v115;
	local v116 = {bloodFuryValue=((v17.BloodFury:IsAvailable() and ("/cast " .. v17.BloodFury:Name() .. "\n")) or (v17.Berserking:IsAvailable() and ("/cast " .. v17.Berserking:Name() .. "\n")) or ""),pyroblastValue=v17.Pyroblast:Name(),flamestrikeValue=v17.Flamestrike:Name(),trinket=((v115 and ("/use " .. v115 .. "\n")) or "")};
	local v117 = "{trinket}{bloodFuryValue}/cast {pyroblastValue}";
	local v118 = "{trinket}{bloodFuryValue}/cast [@cursor] {flamestrikeValue}";
	v8:UpdateMacro("macro2", v91(v117, v116));
	v8:UpdateMacro("macro6", "/stopcasting");
	v8.Print("Fire Mage rotation has been updated for patch 11.0.7.");
end
v8.SetAPL(1149 - (461 + 625), v90, v93);
