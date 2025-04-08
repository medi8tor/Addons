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
local v23 = ((v17.Kindling:IsAvailable()) and (0.4 + 0)) or (878 - (282 + 595));
local v24 = 1647 - (1523 + 114);
local v25 = 2 + 0;
local v26 = false;
local v27 = 0 - 0;
local v28 = 1065 - (68 + 997);
local v29 = 1270 - (226 + 1044);
local v30 = 0 - 0;
local v31 = 157 - (32 + 85);
local v32 = 0 + 0;
local v33 = 1 + 0;
local v34 = 957 - (892 + 65);
local v35 = 14 - 8;
local v36 = 36 - 16;
local v37 = false;
local v38 = false;
local v39, v40 = false, false;
local v41, v42 = 0 - 0, 350 - (87 + 263);
local v43 = false;
local v44 = 180 - (67 + 113);
local v45;
local v46;
local v47;
local v48, v49 = false, false;
local v50 = 3 + 0;
local v51, v52;
local v53, v54;
local v55 = 27279 - 16168;
local v56 = 8172 + 2939;
local v57 = (v17.FrostfireBolt:IsAvailable() and v17.FrostfireBolt) or v17.Fireball;
local v58, v59;
local v60;
local v61;
local v62 = 0 - 0;
local function v63()
	local v87, v88 = v4:GetTrinketData(v19);
	if ((v62 < (957 - (802 + 150))) and ((v87.ID == (0 - 0)) or (v88.ID == (0 - 0)) or ((v87.SpellID > (0 + 0)) and not v87.Usable) or ((v88.SpellID > (997 - (915 + 82))) and not v88.Usable))) then
		v62 = v62 + (2 - 1);
		v15(3 + 2, function()
			v63();
		end);
		return;
	end
	v58 = v87.Object;
	v59 = v88.Object;
	v60 = v18.ForgedGladiatorsBadge:IsEquipped() or v18.TreacherousTransmitter:IsEquipped() or v18.CrimsonGladiatorsBadge:IsEquipped() or v18.DraconicGladiatorsBadge:IsEquipped() or v18.ObsidianGladiatorsBadge:IsEquipped() or v18.VerdantGladiatorsBadge:IsEquipped() or v18.MoonlitPrism:IsEquipped() or v18.IrideusFragment:IsEquipped() or v18.SpoilsofNeltharus:IsEquipped() or v18.TimebreachingTalon:IsEquipped() or v18.HornofValor:IsEquipped();
	v61 = 15 - 3;
end
v63();
local function v64()
	v26 = v17.SunKingsBlessing:IsAvailable();
	v27 = ((1192 - (1069 + 118)) * v13(v17.Quickflame:IsAvailable() or v17.FlamePatch:IsAvailable())) + ((13 - 7) * v13(v17.Firefall:IsAvailable())) + ((2184 - 1185) * v13(not v17.FlamePatch:IsAvailable() and not v17.Quickflame:IsAvailable() and not v17.Firefall:IsAvailable()));
	v28 = 174 + 825;
	VarCombustionFlamestrike = ((8 - 3) * v13(v17.Quickflame:IsAvailable() or v17.FlamePatch:IsAvailable())) + ((6 + 0) * v13(v17.Firefall:IsAvailable())) + ((1790 - (368 + 423)) * v13(not v17.FlamePatch:IsAvailable() and not v17.Quickflame:IsAvailable() and not v17.Firefall:IsAvailable()));
	v29 = ((9 - 6) * v13(v17.Quickflame:IsAvailable() or v17.FlamePatch:IsAvailable())) + ((1017 - (10 + 8)) * v13(not v17.FlamePatch:IsAvailable() and not v17.Quickflame:IsAvailable()));
	v30 = 3842 - 2843;
	v31 = 482 - (416 + 26);
	v32 = 3189 - 2190;
	v33 = 1 + 0;
	v34 = 0 - 0;
	v35 = 444 - (145 + 293);
	v36 = (v60 and (450 - (44 + 386))) or v36;
end
v64();
v2:RegisterForEvent(function()
	v63();
end, "PLAYER_EQUIPMENT_CHANGED");
v2:RegisterForEvent(function()
	v17.Pyroblast:RegisterInFlight();
	v17.Fireball:RegisterInFlight();
	v17.FrostfireBolt:RegisterInFlightEffect(470141 - (998 + 488));
	v17.FrostfireBolt:RegisterInFlight();
	v17.Meteor:RegisterInFlightEffect(111555 + 239585);
	v17.Meteor:RegisterInFlight();
	v17.IceFloes:RegisterInFlight();
	v17.PhoenixFlames:RegisterInFlightEffect(210881 + 46661);
	v17.PhoenixFlames:RegisterInFlight();
	v17.Pyroblast:RegisterInFlight(v17.CombustionBuff);
	v17.Fireball:RegisterInFlight(v17.CombustionBuff);
	v17.FrostfireBolt:RegisterInFlight(v17.CombustionBuff);
	v57 = (v17.FrostfireBolt:IsAvailable() and v17.FrostfireBolt) or v17.Fireball;
	v64();
end, "SPELLS_CHANGED", "LEARNED_SPELL_IN_TAB");
v17.Pyroblast:RegisterInFlight();
v17.Fireball:RegisterInFlight();
v17.FrostfireBolt:RegisterInFlightEffect(469427 - (201 + 571));
v17.FrostfireBolt:RegisterInFlight();
v17.Meteor:RegisterInFlightEffect(352278 - (116 + 1022));
v17.Meteor:RegisterInFlight();
v17.IceFloes:RegisterInFlight();
v17.PhoenixFlames:RegisterInFlightEffect(1072216 - 814674);
v17.PhoenixFlames:RegisterInFlight();
v17.Pyroblast:RegisterInFlight(v17.CombustionBuff);
v17.Fireball:RegisterInFlight(v17.CombustionBuff);
v17.FrostfireBolt:RegisterInFlight(v17.CombustionBuff);
v2:RegisterForEvent(function()
	v55 = 6522 + 4589;
	v56 = 40562 - 29451;
end, "PLAYER_REGEN_ENABLED");
local function v65()
	if (not v4 or not v5) then
		return false;
	end
	if (v17.SearingTouch:IsAvailable() and (v5:HealthPercentage() <= (106 - 76))) then
		return true;
	end
	return false;
end
local function v66()
	return v8.ToggleIconFrame:GetToggle(861 - (814 + 45)) and v16.TTDCondition(v22.Fire.TimeToDie.SKB, IsBossfight, v56);
end
local function v67()
	if (not v4 or not v5) then
		return false;
	end
	return v17.Firestarter:IsAvailable() and (v5:HealthPercentage() >= (221 - 131));
end
local function v68()
	return (v17.Firestarter:IsAvailable() and (((v5:HealthPercentage() > (5 + 85)) and v5:TimeToX(32 + 58)) or (885 - (261 + 624)))) or (0 - 0);
end
local function v69()
	return v17.ImprovedScorch:IsAvailable() and (v5:HealthPercentage() < (1110 - (1020 + 60)));
end
local function v70()
	return (v50 * v17.ShiftingPower:BaseDuration()) / v17.ShiftingPower:BaseTickTime();
end
local function v71()
	if not v4 then
		return false;
	end
	local v91 = v4:BuffUp(v17.HotStreakBuff);
	local v92 = v4:BuffUp(v17.HyperthermiaBuff);
	local v93 = v4:BuffUp(v17.FuryoftheSunKingBuff);
	return v91 or v92 or v93;
end
local function v72(v94)
	local v95 = 1423 - (630 + 793);
	for v114, v115 in pairs(v94) do
		if v115:DebuffUp(v17.IgniteDebuff) then
			v95 = v95 + (3 - 2);
		end
	end
	return v95;
end
local function v73()
	if not v4 then
		return 0 - 0;
	end
	local v96 = 0 + 0;
	if v17.Pyroblast:InFlight() then
		v96 = v96 + (3 - 2);
	end
	if v17.Fireball:InFlight() then
		v96 = v96 + (1748 - (760 + 987));
	end
	if v17.PhoenixFlames:InFlight() then
		v96 = v96 + (1914 - (1789 + 124));
	end
	if (v17.FrostfireBolt:IsAvailable() and v17.FrostfireBolt:InFlight()) then
		v96 = v96 + (767 - (745 + 21));
	end
	return v96;
end
local function v74(v97, v98)
	if (v17.IceFloes:IsCastable() and (v17.IceFloes:TimeSinceLastCast() > (1 + 0)) and ((v4:IsMoving() and (v17.IceFloes:Charges() > (2 - 1))) or v98) and v4:BuffDown(v17.IceFloes)) then
		v9(v17.IceFloes, true);
		return "ice_floes";
	elseif (not v4:IsMoving() or v4:BuffUp(v17.IceFloes)) then
		v9(v97);
		return v97:Name();
	end
end
local function v75()
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
		if (v17.Flamestrike:IsReady() and v12() and v16.GroundSpellCondition() and not (v4:IsCasting(v17.Pyroblast) or v4:IsCasting(v17.Flamestrike)) and (v51 >= v27)) then
			if v9(v17.Flamestrike, true) then
				return "Flamestrike precombat";
			end
		end
		if (v17.Pyroblast:IsReady() and not (v4:IsCasting(v17.Pyroblast) or v4:IsCasting(v17.Flamestrike)) and (v51 < v29)) then
			if v9(v17.Pyroblast) then
				return "pyroblast precombat";
			end
		end
		if v17.PhoenixFlames:IsCastable() then
			if v9(v17.PhoenixFlames) then
				return "phoenix_flames precombat 10";
			end
		end
		if v57:IsReady() then
			if v9(v57) then
				return "fireball precombat 12";
			end
		end
	end
end
local function v76()
	if v17.Meteor:IsAvailable() then
		if ((v17.Meteor:IsReady() and v16.GroundSpellCondition() and (v47 < v17.Meteor:CastTime())) or (v44 <= (0 - 0)) or (v47 > v17.Meteor:TravelTime())) then
			if v9(v17.Meteor) then
				return "meteor active_talents 2";
			end
		end
	end
	if (v17.DragonsBreath:IsReady() and v17.AlexstraszasFury:IsAvailable() and v46 and not v49 and (v4:BuffUp(v17.FeeltheBurnBuff) or (v2.CombatTime() > (1 + 14))) and not v69()) then
		if v5:IsInRange(7 + 1) then
			if v9(v17.DragonsBreath) then
				return "dragons_breath active_talents 6";
			end
		end
	end
end
local function v77()
	if (v22.Commons.Enabled.Potions and v11()) then
		local v116 = v21.PotionSelected();
		if (v116 and v116:IsReady()) then
			if v8.CastMacro(1058 - (87 + 968), nil, nil, v116) then
				return "potion combustion_cooldowns";
			end
		end
	end
	if v17.BloodFury:IsCastable() then
		if v9(v17.BloodFury, true) then
			return "blood_fury combustion_cooldowns 4";
		end
	end
	if (v17.Berserking:IsCastable() and v45) then
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
	if (v22.Commons.Enabled.Trinkets and v11() and v16.TTDCondition(v22.Fire.TimeToDie.Trinkets, IsBossfight, v56)) then
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
		if (v18.KahetiShadowweaversEmblem:IsEquippedAndReady() and (v4:BuffStack(v17.KahetiShadowweaversEmblemBuff) >= (22 - 17))) then
			if v9(v18.KahetiShadowweaversEmblem) then
				return "Kaheti_Shadowweavers_Emblem items";
			end
		end
	end
end
local function v78()
	if ((v47 > v35) or (v55 < (19 + 1))) then
		local v117 = v77();
		if v117 then
			return v117;
		end
	end
	local v99 = v76();
	if v99 then
		return v99;
	end
	v43 = (v17.Combustion:CooldownRemains() < (22 - 12)) and v45;
	if (v17.Combustion:IsReady() and (v73() == (1413 - (447 + 966))) and v46 and (v44 <= (0 - 0)) and ((v4:IsCasting(v17.Scorch) and (v17.Scorch:ExecuteRemains() < v33)) or (v4:IsCasting(v57) and (v57:ExecuteRemains() < v33)) or (v4:IsCasting(v17.Pyroblast) and (v17.Pyroblast:ExecuteRemains() < v33)) or (v4:IsCasting(v17.Flamestrike) and (v17.Flamestrike:ExecuteRemains() < v33)) or (not v17.IsothermicCore:IsAvailable() and v17.Meteor:InFlight() and (v17.Meteor:InFlightRemains() < v33)) or (v17.IsothermicCore:IsAvailable() and v17.Meteor:InFlight()))) then
		if v9(v17.Combustion, true) then
			return "combustion combustion_phase 2";
		end
	end
	if (v17.FireBlast:IsReady() and not v71() and (not v43 or v17.SunKingsBlessing:IsAvailable()) and not v39 and (not v69() or v4:IsCasting(v17.Scorch) or (v5:DebuffRemains(v17.ImprovedScorchDebuff) > ((1821 - (1703 + 114)) * v4:GCD()))) and (v4:BuffDown(v17.FuryoftheSunKingBuff) or v4:IsCasting(v17.Pyroblast)) and v45 and not v49 and ((v73() + (v13(v48) * v13(v4:GCDRemains() > (701 - (376 + 325))))) < (2 - 0))) then
		if v9(v17.FireBlast, true) then
			return "fire_blast combustion_phase 4";
		end
	end
	if (v17.FireBlast:IsReady() and not v71() and v43 and not v39 and (v17.FireBlast:ChargesFractional() > (5.5 - 3)) and (not v69() or v4:IsCasting(v17.Scorch) or (v5:DebuffRemains(v17.ImprovedScorchDebuff) > ((2 + 2) * v4:GCD()))) and (v4:BuffDown(v17.FuryoftheSunKingBuff) or v4:IsCasting(v17.Pyroblast)) and v45 and not v49 and ((v73() + (v13(v48) * v13(v4:GCDRemains() > (0 - 0)))) < (16 - (9 + 5)))) then
		if v9(v17.FireBlast) then
			return "fire_blast combustion_phase 6";
		end
	end
	if (v17.Pyroblast:IsReady() and v45 and v49) then
		if v9(v17.Pyroblast) then
			return "pyroblast combustion_phase 7";
		end
	end
	if (v4:BuffUp(v17.HyperthermiaBuff) and v4:BuffUp(v17.FuryoftheSunKingBuff)) then
		v4:CancelBuff(v17.HyperthermiaBuff);
	end
	if (v12() and v16.GroundSpellCondition() and v66() and v16.TTDCastTimeCondition(v17.Flamestrike, IsBossfight, v56) and v17.Flamestrike:IsReady() and not v4:IsCasting(v17.Flamestrike) and v46 and v4:BuffUp(v17.FuryoftheSunKingBuff) and (v4:BuffRemains(v17.FuryoftheSunKingBuff) > v17.Flamestrike:CastTime()) and (v17.Combustion:CooldownRemains() < v17.Flamestrike:CastTime()) and (v51 >= v29)) then
		if v74(v17.Flamestrike) then
			return "flamestrike combustion_phase 8";
		end
	end
	if (v17.Pyroblast:IsReady() and v66() and v16.TTDCastTimeCondition(v17.Pyroblast, IsBossfight, v56) and not v4:IsCasting(v17.Pyroblast) and v46 and v4:BuffUp(v17.FuryoftheSunKingBuff) and (v4:BuffRemains(v17.FuryoftheSunKingBuff) > v17.Pyroblast:CastTime()) and v4:BuffUp(v17.FlameAccelerantBuff)) then
		if v74(v17.Pyroblast, true) then
			return "pyroblast combustion_phase 10";
		end
	end
	if (v17.Meteor:IsReady() and v16.GroundSpellCondition() and v17.IsothermicCore:IsAvailable() and v46 and (v17.Combustion:CooldownRemains() < v17.Meteor:CastTime())) then
		if v9(v17.Meteor) then
			return "meteor combustion_phase 12";
		end
	end
	if (v57:IsReady() and v46 and (v47 < v57:CastTime()) and (v52 < (378 - (85 + 291))) and not v69() and not (v17.SunKingsBlessing:IsAvailable() and v17.FlameAccelerant:IsAvailable())) then
		if v74(v57) then
			return "fireball combustion_phase 14";
		end
	end
	if (v17.Scorch:IsReady() and v46 and (v17.Combustion:CooldownRemains() < v17.Scorch:CastTime())) then
		if v9(v17.Scorch) then
			return "scorch combustion_phase 16";
		end
	end
	if (v57:IsReady() and v46 and v4:BuffUp(v17.FrostfireEmpowermentBuff)) then
		if v74(v57) then
			return "fireball combustion_phase 17";
		end
	end
	v43 = (v17.Combustion:CooldownRemains() < (1275 - (243 + 1022))) and v45;
	if (v17.PhoenixFlames:IsCastable() and v17.SpellfireSpheres:IsAvailable() and v17.PhoenixReborn:IsAvailable() and v48 and not v49 and v4:BuffUp(v17.FlamesFuryBuff)) then
		if v9(v17.PhoenixFlames) then
			return "phoenix_flames combustion_phase 18";
		end
	end
	if (v12() and v16.GroundSpellCondition() and v17.Flamestrike:IsReady() and ((v49 and (v51 >= VarCombustionFlamestrike)) or (v4:BuffUp(v17.HyperthermiaBuff) and (v51 >= (VarCombustionFlamestrike - v13(v17.Hyperthermia:IsAvailable())))))) then
		if v9(v17.Flamestrike, true) then
			return "flamestrike combustion_phase 19";
		end
	end
	if (v17.Pyroblast:IsReady() and (v4:BuffUp(v17.HyperthermiaBuff))) then
		if v9(v17.Pyroblast, true) then
			return "pyroblast combustion_phase 20";
		end
	end
	if (v17.Pyroblast:IsReady() and v49 and v45) then
		if v9(v17.Pyroblast, true) then
			return "pyroblast combustion_phase 22";
		end
	end
	if (v17.Pyroblast:IsReady() and v4:PrevGCDP(3 - 2, v17.Scorch) and v48 and (v51 < VarCombustionFlamestrike) and v45) then
		if v9(v17.Pyroblast, true) then
			return "pyroblast combustion_phase 24";
		end
	end
	if (v17.Scorch:IsReady() and v5:IsSpellInRange(v17.Scorch) and v17.SunKingsBlessing:IsAvailable() and v69() and (v5:DebuffRemains(v17.ImprovedScorchDebuff) < ((3 + 0) * v4:GCD()))) then
		if v9(v17.Scorch) then
			return "scorch combustion_phase 25";
		end
	end
	if (v12() and v66() and v16.TTDCastTimeCondition(v17.Flamestrike, IsBossfight, v56) and v17.Flamestrike:IsReady() and v16.GroundSpellCondition() and not v4:IsCasting(v17.Flamestrike) and v4:BuffUp(v17.FuryoftheSunKingBuff) and (v4:BuffRemains(v17.FuryoftheSunKingBuff) > v17.Flamestrike:CastTime()) and (v51 >= v29)) then
		if v74(v17.Flamestrike, true) then
			return "flamestrike combustion_phase 26";
		end
	end
	if (v17.Pyroblast:IsReady() and v66() and v16.TTDCastTimeCondition(v17.Pyroblast, IsBossfight, v56) and not v4:IsCasting(v17.Pyroblast) and v4:BuffUp(v17.FuryoftheSunKingBuff) and (v4:BuffRemains(v17.FuryoftheSunKingBuff) > v17.Pyroblast:CastTime()) and ((v47 > (v17.Pyroblast:CastTime() + (1183 - (1123 + 57)))) or (v47 < v17.Pyroblast:CastTime()))) then
		if v74(v17.Pyroblast, true) then
			return "pyroblast combustion_phase 28";
		end
	end
	if (v57:IsReady() and v4:BuffUp(v17.FrostfireEmpowermentBuff) and not v49 and v4:BuffDown(v17.ExcessFrostBuff)) then
		if v74(v57) then
			return "fireball combustion_phase 30";
		end
	end
	if (v17.PhoenixFlames:IsCastable() and v17.PhoenixReborn:IsAvailable() and ((v13(v48) + v73()) < (2 + 0)) and v4:BuffUp(v17.FlamesFuryBuff)) then
		if v9(v17.PhoenixFlames) then
			return "phoenix_flames combustion_phase 32";
		end
	end
	if (v17.Scorch:IsReady() and v69() and (v5:DebuffRemains(v17.ImprovedScorchDebuff) < ((258 - (163 + 91)) * GCDMax)) and (v52 < VarCombustionFlamestrike)) then
		if v9(v17.Scorch) then
			return "scorch combustion_phase 34";
		end
	end
	if (v17.Scorch:IsReady() and v4:BuffUp(v17.HeatShimmerBuff) and (v17.Scald:IsAvailable() or v17.ImprovedScorch:IsAvailable()) and (v52 < VarCombustionFlamestrike)) then
		if v9(v17.Scorch) then
			return "scorch combustion_phase 36";
		end
	end
	if (v17.PhoenixFlames:IsCastable() and ((not v17.CalloftheSunKing:IsAvailable() and (v17.PhoenixFlames:TravelTime() < v47)) or (v17.CalloftheSunKing:IsAvailable() and (v47 < (1934 - (1869 + 61)))) or (v4:BuffStack(v17.SunKingsBlessingBuff) < (3 + 5))) and ((v13(v48) + v73()) < (6 - 4))) then
		if v9(v17.PhoenixFlames) then
			return "phoenix_flames combustion_phase 38";
		end
	end
	if (v57:IsReady() and v4:BuffUp(v17.FrostfireEmpowermentBuff) and not v49) then
		if v74(v57) then
			return "fireball combustion_phase 40";
		end
	end
	if (v17.Scorch:IsReady() and (v47 > v17.Scorch:CastTime()) and (v17.Scorch:CastTime() >= v4:GCD())) then
		if v9(v17.Scorch) then
			return "scorch combustion_phase 42";
		end
	end
	if v57:IsReady() then
		if v74(v57) then
			return "fireball combustion_phase 44";
		end
	end
end
local function v79()
	v41 = v17.Combustion:CooldownRemains() * v23;
	v42 = ((v57:CastTime() * v13(v51 < VarCombustionFlamestrike)) + (v17.Flamestrike:CastTime() * v13(v51 >= VarCombustionFlamestrike))) - v33;
	v44 = v41;
	if (v17.Firestarter:IsAvailable() and not v26) then
		v44 = v14(v68(), v44);
	end
	if (v17.SunKingsBlessing:IsAvailable() and v67() and v4:BuffDown(v17.FuryoftheSunKingBuff)) then
		v44 = v14((v24 - v4:BuffStack(v17.SunKingsBlessingBuff)) * (4 - 1) * v4:GCD(), v44);
	end
	if (v18.ForgedGladiatorsBadge:IsEquipped() and ((v18.ForgedGladiatorsBadge:CooldownRemains() - (3 + 17)) < v44)) then
		v44 = v14(v18.ForgedGladiatorsBadge:CooldownRemains(), v44);
	end
	if (v18.CrimsonGladiatorsBadge:IsEquipped() and ((v18.CrimsonGladiatorsBadge:CooldownRemains() - (27 - 7)) < v44)) then
		v44 = v14(v18.CrimsonGladiatorsBadge:CooldownRemains(), v44);
	end
	if (v18.DraconicGladiatorsBadge:IsEquipped() and ((v18.DraconicGladiatorsBadge:CooldownRemains() - (19 + 1)) < v44)) then
		v44 = v14(v18.DraconicGladiatorsBadge:CooldownRemains(), v44);
	end
	if (v18.ObsidianGladiatorsBadge:IsEquipped() and ((v18.ObsidianGladiatorsBadge:CooldownRemains() - (1494 - (1329 + 145))) < v44)) then
		v44 = v14(v18.ObsidianGladiatorsBadge:CooldownRemains(), v44);
	end
	if (v18.VerdantGladiatorsBadge:IsEquipped() and ((v18.VerdantGladiatorsBadge:CooldownRemains() - (991 - (140 + 831))) < v44)) then
		v44 = v14(v18.VerdantGladiatorsBadge:CooldownRemains(), v44);
	end
	v44 = v14(v47, v44);
	if (((v41 + ((1970 - (1409 + 441)) * ((719 - (15 + 703)) - ((0.4 + 0 + ((438.2 - (262 + 176)) * v13(v17.Firestarter:IsAvailable()))) * v13(v17.Kindling:IsAvailable()))))) <= v44) or (v44 > (v56 - (1741 - (345 + 1376))))) then
		v44 = v41;
	end
	if var_disable_combustion then
		v44 = 1687 - (198 + 490);
	end
end
local function v80()
	if (v17.FireBlast:IsReady() and not v71() and not v39 and not v49 and ((v13(v48) + v73()) == (4 - 3)) and (v17.ShiftingPower:CooldownUp() or (v17.FireBlast:Charges() > (2 - 1)) or (v4:BuffRemains(v17.FeeltheBurnBuff) < ((1208 - (696 + 510)) * GCDMax)))) then
		if v9(v17.FireBlast, true) then
			return "fire_blast firestarter_fire_blasts 2";
		end
	end
	if (v17.FireBlast:IsReady() and not v71() and not v39 and ((v13(v48) + v73()) == (1 - 0)) and ((v17.FeeltheBurn:IsAvailable() and (v4:BuffRemains(v17.FeeltheBurnBuff) < v4:GCDRemains())) or v17.ShiftingPower:CooldownUp())) then
		if v10(v17.FireBlast, true) then
			return "fire_blast firestarter_fire_blasts 4";
		end
	end
end
local function v81()
	if (v12() and v16.GroundSpellCondition() and v17.Flamestrike:IsReady() and (v51 >= v27) and (v49 or v4:BuffUp(v17.HyperthermiaBuff))) then
		if v9(v17.Flamestrike, true) then
			return "flamestrike standard_rotation 2";
		end
	end
	if (v57:IsReady() and v49 and v4:BuffDown(v17.FrostfireEmpowermentBuff) and v4:BuffDown(v17.HyperthermiaBuff) and v17.ShiftingPower:CooldownDown() and (v17.PhoenixFlames:Charges() < (1263 - (1091 + 171))) and not v65() and not v4:PrevGCDP(1 + 0, v57)) then
		if v74(v57) then
			return "fireball standard_rotation 4";
		end
	end
	if (v17.Pyroblast:IsReady() and v71()) then
		if v9(v17.Pyroblast, true) then
			return "pyroblast standard_rotation 6";
		end
	end
	if (v17.FireBlast:IsReady() and not v71() and not v67() and (not v39 or v17.SpontaneousCombustion:IsAvailable()) and (v4:BuffDown(v17.FuryoftheSunKingBuff) or not v66()) and (((v4:IsCasting(v57) or v4:IsCasting(v17.Pyroblast)) and v48) or (v65() and (not v69() or (v5:DebuffStack(v17.ImprovedScorchDebuff) == v25) or (v17.FireBlast:FullRechargeTime() < (9 - 6))) and ((v48 and not v4:IsCasting(v17.Scorch)) or (not v49 and not v48 and v4:IsCasting(v17.Scorch) and (v73() == (0 - 0))))))) then
		if v9(v17.FireBlast, true) then
			return "fire_blast standard_rotation 8";
		end
	end
	if (v17.FireBlast:IsReady() and not v71() and ((not v67() and (not v39 or v17.SpontaneousCombustion:IsAvailable()) and (v4:BuffDown(v17.FuryoftheSunKingBuff) or not v66()) and v48 and (v73() < (375 - (123 + 251))) and (v4:PrevGCDP(4 - 3, v17.PhoenixFlames) or v4:PrevGCDP(699 - (208 + 490), v17.Scorch))) or (((v4:BloodlustUp() and (v17.FireBlast:ChargesFractional() > (1.5 + 0))) or (v17.FireBlast:ChargesFractional() > (1.5 + 1)) or (v4:BuffRemains(v17.FeeltheBurnBuff) < (836.5 - (660 + 176))) or (((v17.FireBlast:FullRechargeTime() * (1 + 0)) - ((202.5 - (14 + 188)) * v13(v17.ShiftingPower:CooldownUp()))) < (681 - (534 + 141)))) and v48))) then
		if v10(v17.FireBlast, true) then
			return "fire_blast standard_rotation 10";
		end
	end
	if (v17.FireBlast:IsReady() and not v71() and v4:BuffUp(v17.HyperthermiaBuff) and (v17.FireBlast:ChargesFractional() > (1.5 + 0)) and v48) then
		if v10(v17.FireBlast) then
			return "fire_blast standard_rotation 11";
		end
	end
	if (v12() and v66() and v16.TTDCastTimeCondition(v17.Flamestrike, IsBossfight, v56) and v16.GroundSpellCondition() and v17.Flamestrike:IsReady() and not v4:IsCasting(v17.Flamestrike) and (v51 >= v29) and v4:BuffUp(v17.FuryoftheSunKingBuff)) then
		if v74(v17.Flamestrike, true) then
			return "flamestrike standard_rotation 12";
		end
	end
	if (v17.Scorch:IsReady() and v69() and ((v17.UnleashedInferno:IsAvailable() and (v5:DebuffRemains(v17.ImprovedScorchDebuff) < (v17.Pyroblast:CastTime() + ((5 + 0) * v4:GCD()))) and v66()) or (v17.SunKingsBlessing:IsAvailable() and (v5:DebuffRemains(v17.ImprovedScorchDebuff) < ((4 + 0) * v4:GCD())))) and v4:BuffUp(v17.FuryoftheSunKingBuff) and not v4:IsCasting(v17.Scorch)) then
		if v9(v17.Scorch) then
			return "scorch standard_rotation 14";
		end
	end
	if (v17.Pyroblast:IsReady() and v66() and v16.TTDCastTimeCondition(v17.Pyroblast, IsBossfight, v56) and not v4:IsCasting(v17.Pyroblast) and (v4:BuffUp(v17.FuryoftheSunKingBuff))) then
		if v74(v17.Pyroblast, true) then
			return "pyroblast standard_rotation 16";
		end
	end
	if (v17.Pyroblast:IsReady() and v4:PrevGCDP(1 - 0, v17.Scorch) and v49 and v65() and (v52 < v27)) then
		if v9(v17.Pyroblast, true) then
			return "pyroblast standard_rotation 18";
		end
	end
	if (v17.Scorch:IsReady() and v69() and (v5:DebuffRemains(v17.ImprovedScorchDebuff) < GCDMax)) then
		if v9(v17.Scorch) then
			return "scorch standard_rotation 20";
		end
	end
	if (v57:IsReady() and v4:BuffUp(v17.FrostfireEmpowermentBuff) and not v49 and v4:BuffDown(v17.ExcessFrostBuff)) then
		if v74(v57) then
			return "fireball standard_rotation 22";
		end
	end
	if (v17.Scorch:IsReady() and v4:BuffUp(v17.HeatShimmerBuff) and (v17.Scald:IsAvailable() or v17.ImprovedScorch:IsAvailable()) and (v52 < VarCombustionFlamestrike)) then
		if v9(v17.Scorch) then
			return "scorch standard_rotation 24";
		end
	end
	if (v17.PhoenixFlames:IsCastable() and ((not v49 and (v73() < (1 - 0)) and (not v4:PrevGCDP(2 - 1, v17.Fireball) or (not v48 and not v49))) or ((v73() < (2 + 0)) and v4:BuffUp(v17.FlamesFuryBuff)))) then
		if v9(v17.PhoenixFlames) then
			return "phoenix_flames standard_rotation 26";
		end
	end
	local v100 = v76();
	if v100 then
		return v100;
	end
	if (v12() and v17.DragonsBreath:IsReady() and (v52 > (1 + 0)) and v17.AlexstraszasFury:IsAvailable()) then
		if v5:IsInRange(406 - (115 + 281)) then
			if v9(v17.DragonsBreath) then
				return "dragons_breath standard_rotation 28 ";
			end
		end
	end
	if (v17.Scorch:IsReady() and ((v65() and not (v17.UnleashedInferno:IsAvailable() and v17.FrostfireBolt:IsAvailable())) or v4:BuffUp(v17.HeatShimmerBuff))) then
		if v9(v17.Scorch) then
			return "scorch standard_rotation 30";
		end
	end
	if (v12() and v17.ArcaneExplosion:IsReady() and (v52 >= v30) and (v4:ManaPercentageP() >= v31)) then
		if v5:IsInRange(23 - 13) then
			if v9(v17.ArcaneExplosion) then
				return "arcane_explosion standard_rotation 32";
			end
		end
	end
	if (v16.GroundSpellCondition() and v12() and v17.Flamestrike:IsReady() and (v51 >= v28)) then
		if v74(v17.Flamestrike) then
			return "flamestrike standard_rotation 34";
		end
	end
	if (v57:IsReady() and not v71()) then
		if v74(v57) then
			return "fireball standard_rotation 36";
		end
	end
end
local function v82(v101)
	if (v101:Exists() and (v101:GUID() ~= v5:GUID()) and not v101:IsDeadOrGhost() and (v101:HealthPercentage() < (25 + 5)) and v101:IsSpellInRange(v17.Scorch)) then
		return true;
	end
end
local function v83()
	v21.HealthPotions();
	if v21.ShouldStopCastUpdate() then
		v8.CastMacro(14 - 8, true);
		return "Stop Cast For Silence";
	end
	if v16.IncorporealBeing() then
		if v16.AutoTarget() then
			return "Tab Away from Incorp";
		end
		return "Ignore Target Incorp";
	end
	local v102 = not v4:AffectingCombat() or not v5:AffectingCombat() or v5:IsDummy();
	Enemies40Yard = v4:GetEnemiesInRange(146 - 106);
	EnemiesRangeOOCCount = v16.RangeOOCCount() or #Enemies40Yard;
	v56 = v2.BossFightRemains();
	IsBossfight = true;
	if ((v56 == (11978 - (550 + 317))) or v5:IsDummy()) then
		IsBossfight = false;
		v56 = v2.FightRemains(Enemies40Yard, false);
	end
	v53 = v5:GetEnemiesInSplashRange(11 - 3);
	Enemies10yMelee = v4:GetEnemiesInMeleeRange(14 - 4);
	if v12() then
		v51 = (v102 and EnemiesRangeOOCCount) or v5:GetEnemiesInSplashRangeCount(22 - 14);
		v52 = (v102 and EnemiesRangeOOCCount) or v5:GetEnemiesInSplashRangeCount(301 - (134 + 151));
	else
		v51 = 1666 - (970 + 695);
		v52 = 1 - 0;
	end
	if (v22.Commons.ForceAOE and v12()) then
		v51 = 2089 - (582 + 1408);
	end
	var_disable_combustion = not v11() or not v16.TTDCondition(v22.Fire.TimeToDie.Combustion, IsBossfight, v56);
	if (v16.Precast() and not v4:AffectingCombat() and not v5:AffectingCombat() and v5:IsSpellInRange(v57)) then
		ShouldReturn = v75();
		if ShouldReturn then
			return ShouldReturn;
		end
	end
	if (v21.TargetIsValid() or v4:AffectingCombat()) then
		GCDMax = math.floor(v4:GCD() * (3468 - 2468)) / (1258 - 258);
		v45 = v4:BuffUp(v17.CombustionBuff);
		v46 = not v45;
		v47 = (v45 and v4:BuffRemains(v17.CombustionBuff)) or (0 - 0);
	end
	if (not v4:AffectingCombat() and not v5:AffectingCombat()) then
		if (v17.ArcaneIntellect:IsCastable() and v22.Commons.AutoBuff and ((v21.GroupBuffMissing(v17.ArcaneIntellect) and (v4:IsInRaidArea() or v4:IsInDungeonArea()) and (v4:InstanceDifficulty() ~= (2029 - (1195 + 629)))) or v4:BuffDown(v17.ArcaneIntellect, true))) then
			if v8.CastTarget(v17.ArcaneIntellect, "PLAYER") then
				return "arcane_intellect precombat 2";
			end
		end
		if (v17.BlazingBarrier:IsCastable() and (v4:BuffRemains(v17.BlazingBarrier) < (7 - 1))) then
			v8.Cast(v17.BlazingBarrier);
			return "Blazing Barriers precombat";
		end
	end
	v48 = v4:BuffUp(v17.HeatingUpBuff);
	v49 = v4:BuffUp(v17.HotStreakBuff);
	if v16.CombatCheck() then
		if (v17.IceFloes:IsCastable() and v4:BuffUp(v17.IceFloes) and (v4:BuffStack(v17.IceFloes) < (243 - (187 + 54))) and v4:IsMoving() and v4:IsCasting() and (v4:CastRemains() < (780.5 - (162 + 618))) and (v4:CastSpellID() ~= v17.Scorch:ID())) then
			if v9(v17.IceFloes, true) then
				return "ice_floes movement 2";
			end
		end
		if (v17.IceCold:IsCastable() and (v4:HealthPercentage() < v22.Defense.IceCold)) then
			v8.Cast(v17.IceBlock, true);
			return "Ice Cold Defensive";
		end
		if not v45 then
			if (v17.EnergizedBarrier:IsAvailable() and (v4:DebuffElapsed(v17.EntangledDebuff) > (1 + 0))) then
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
		if v8.ToggleIconFrame:GetToggle(2 + 1) then
			ShouldReturn = not v4:IsCasting() and not v4:IsChanneling() and v21.InterruptCycle(v17.Counterspell, 85 - 45, true, nil, false);
			if ShouldReturn then
				return ShouldReturn;
			end
			ShouldReturn = not v4:IsCasting() and not v4:IsChanneling() and v21.InterruptCycle(v17.DragonsBreath, 13 - 5, true, nil, true, true);
			if ShouldReturn then
				return ShouldReturn;
			end
		end
		ShouldReturn = not v4:IsCasting(v17.Polymorph) and v21.IncorpCycle(v17.Polymorph, 3 + 27, true, nil, false);
		if ShouldReturn then
			return ShouldReturn;
		end
		if v8.ToggleIconFrame:GetToggle(1640 - (1373 + 263)) then
			ShouldReturn = not v4:IsChanneling() and v17.SpellSteal:IsAvailable() and v16.StealCycle(v17.SpellSteal, 1040 - (451 + 549), false, v22.AutoTargetSpellSteal);
			if ShouldReturn then
				return ShouldReturn;
			end
			ShouldReturn = not v4:IsCasting() and not v45 and not v4:IsChanneling() and v17.RemoveCurse:IsAvailable() and v17.RemoveCurse:IsReady() and v21.DispelCycle(v17.RemoveCurse, "Curse");
			if ShouldReturn then
				return ShouldReturn;
			end
			ShouldReturn = not v4:IsCasting() and not v4:IsChanneling() and v17.RemoveCurse:IsAvailable() and v17.RemoveCurse:IsReady() and v21.AfflictedLogic(v17.RemoveCurse);
			if ShouldReturn then
				return ShouldReturn;
			end
		end
		if not v5:IsSpellInRange(v57) then
			return "NOT IN RANGE";
		end
		if (v17.SearingTouch:IsAvailable() and v22.Fire.UseScorchSniping and v12() and (v5:HealthPercentage() > (10 + 20))) then
			ShouldReturn = v21.CastCycle(v17.Scorch, Enemies40Yard, v82, 62 - 22, nil, nil, false);
			if ShouldReturn then
				return ShouldReturn;
			end
		end
		v79();
		if (v22.Commons.Enabled.Potions and v11()) then
			local v118 = v21.PotionSelected();
			if (v118 and v118:IsReady() and (v118:BuffDuration() > (v44 + (19 - 7)))) then
				if v8.CastMacro(1387 - (746 + 638), nil, nil, v118) then
					return "potion main 4";
				end
			end
		end
		v37 = v44 > v17.ShiftingPower:CooldownRemains();
		if (v22.Commons.Enabled.Trinkets and v11() and v16.TTDCondition(v22.Fire.TimeToDie.Trinkets, IsBossfight, v56)) then
			v38 = ((v44 < v36) or ((v47 > v35) and (v18.DragonfireBombDispenser:CooldownUp() or not v18.DragonfireBombDispenser:IsEquipped()))) and ((v13((v58:Cooldown() > (0 + 0)) and (v58:CooldownRemains() < v36)) + v13(v59:Cooldown() and (v59:CooldownRemains() < v36))) > (1 - 0));
			if (v18.SpymastersWeb:IsEquippedAndReady() and (v47 > (351 - (218 + 123))) and (v56 < (1601 - (1535 + 46)))) then
				if v9(v18.SpymastersWeb) then
					return "spymasters_web main 6";
				end
			end
			if (v18.TreacherousTransmitter:IsEquippedAndReady() and ((v44 < (10 + 0)) or (v55 < (4 + 21)))) then
				if v9(v18.TreacherousTransmitter) then
					return "treacherous_transmitter main 8";
				end
			end
			if (v18.ImperfectAscendancySerum:IsEquippedAndReady() and (v44 < (563 - (306 + 254)))) then
				if v9(v18.ImperfectAscendancySerum) then
					return "imperfect_ascendancy_serum main 10";
				end
			end
			if (v18.ForgedGladiatorsBadge:IsEquippedAndReady() and (v44 > (v18.ForgedGladiatorsBadge:Cooldown() - (1 + 4)))) then
				if v9(v18.ForgedGladiatorsBadge) then
					return "gladiators_badge (forged) main 12";
				end
			end
			if (v18.CrimsonGladiatorsBadge:IsEquippedAndReady() and (v44 > (v18.CrimsonGladiatorsBadge:Cooldown() - (9 - 4)))) then
				if v9(v18.CrimsonGladiatorsBadge) then
					return "gladiators_badge (crimson) main 12";
				end
			end
			if (v18.DraconicGladiatorsBadge:IsEquippedAndReady() and (v44 > (v18.DraconicGladiatorsBadge:Cooldown() - (1472 - (899 + 568))))) then
				if v9(v18.DraconicGladiatorsBadge) then
					return "gladiators_badge (draconic) main 12";
				end
			end
			if (v18.ObsidianGladiatorsBadge:IsEquippedAndReady() and (v44 > (v18.ObsidianGladiatorsBadge:Cooldown() - (4 + 1)))) then
				if v9(v18.ObsidianGladiatorsBadge) then
					return "gladiators_badge (obsidian) main 12";
				end
			end
			if (v18.VerdantGladiatorsBadge:IsEquippedAndReady() and (v44 > (v18.VerdantGladiatorsBadge:Cooldown() - (12 - 7)))) then
				if v9(v18.VerdantGladiatorsBadge) then
					return "gladiators_badge (verdant) main 12";
				end
			end
			if (v18.KahetiShadowweaversEmblem:IsEquippedAndReady() and (v4:BuffStack(v17.KahetiShadowweaversEmblemBuff) >= (608 - (268 + 335)))) then
				if v9(v18.KahetiShadowweaversEmblem) then
					return "Kaheti_Shadowweavers_Emblem items";
				end
			end
		end
		if (v22.Commons.Enabled.Trinkets and v11() and v16.TTDCondition(v22.Fire.TimeToDie.Trinkets, IsBossfight, v56) and not v38) then
			local v119, v120, v121 = v4:GetUseableItems(v19);
			if v119 then
				if (((v120 == (303 - (60 + 230))) or (v120 == (586 - (426 + 146)))) and v22.Commons.Enabled.Trinkets) then
					if v9(v119) then
						return "Generic use_items for " .. v119:Name() .. " main 14";
					end
				end
			end
		end
		v39 = v46 and (((v17.FireBlast:ChargesFractional() + ((v44 + (v70() * v13(v37))) / v17.FireBlast:Cooldown())) - (1 + 0)) < ((v17.FireBlast:MaxCharges() + (v34 / v17.FireBlast:Cooldown())) - (((1468 - (282 + 1174)) / v17.FireBlast:Cooldown()) % (812 - (569 + 242))))) and (v44 < v56);
		if ((v44 <= (0 - 0)) or v45 or ((v44 < v42) and (v17.Combustion:CooldownRemains() < v42))) then
			local v122 = v78();
			if v122 then
				return v122;
			end
		end
		if (not v39 and v17.SunKingsBlessing:IsAvailable()) then
			v39 = v65() and (v17.FireBlast:FullRechargeTime() > ((1 + 2) * v4:GCD()));
		end
		if (v17.FireBlast:IsReady() and not v71() and v4:IsChanneling(v17.ShiftingPower) and ((v17.FireBlast:FullRechargeTime() < v50) or (v17.SunKingsBlessing:IsAvailable() and v48))) then
			if v9(v17.FireBlast, true) then
				return "fire_blast main 16";
			end
		end
		if (v17.ShiftingPower:IsReady() and v11() and v5:IsInRange(1042 - (706 + 318)) and v46 and (not v69() or ((v5:DebuffRemains(v17.ImprovedScorchDebuff) > (v17.ShiftingPower:CastTime() + v17.Scorch:CastTime())) and (v4:BuffDown(v17.FuryoftheSunKingBuff) or not v66()))) and not v49 and v4:BuffDown(v17.HyperthermiaBuff) and ((v17.PhoenixFlames:Charges() <= (1252 - (721 + 530))) or (v17.Combustion:CooldownRemains() < (1291 - (945 + 326))))) then
			if v74(v17.ShiftingPower, true) then
				return "shifting_power main 18";
			end
		end
		if v4:IsChanneling(v17.ShiftingPower) then
			if v9(v17.Pool) then
				return "stop casting during shifting power";
			end
		end
		if not v17.SunKingsBlessing:IsAvailable() then
			v40 = ((((v44 + (12 - 7)) < ((v17.PhoenixFlames:FullRechargeTime() + v17.PhoenixFlames:Cooldown()) - (v70() * v13(v37)))) and (v44 < v56)) or v17.SunKingsBlessing:IsAvailable()) and not v17.AlexstraszasFury:IsAvailable();
		end
		if (v17.FireBlast:IsReady() and not v71() and not v39 and (v44 > (0 + 0)) and (v51 >= v28) and not v67() and not v49 and ((v48 and (v17.Flamestrike:ExecuteRemains() < (700.5 - (271 + 429)))) or (v17.FireBlast:ChargesFractional() >= (2 + 0)))) then
			if v9(v17.FireBlast) then
				return "fire_blast main 20";
			end
		end
		if (v46 and v67() and (v44 > (1500 - (1408 + 92)))) then
			local v123 = v80();
			if v123 then
				return v123;
			end
		end
		if ((v44 > (1086 - (461 + 625))) and v46) then
			local v124 = v81();
			if v124 then
				return v124;
			end
		end
		if (v17.IceNova:IsCastable() and not v65() and v5:IsSpellInRange(v17.IceNova)) then
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
local function v84(v103, v104)
	return (v103:gsub("{(.-)}", v104));
end
local function v85(v105)
	local v106 = v4:GetEquipment();
	local v107, v108 = v106[1301 - (993 + 295)], v106[1 + 13];
	if (v107 and (v105:ID() == v107)) then
		return 1184 - (418 + 753);
	elseif (v108 and (v105:ID() == v108)) then
		return 6 + 8;
	end
end
local function v86()
	v22.Fire.Display();
	v2.Timer.PulseOffset = 0.01 + 0;
	v8:UpdateMacro("macro1", "/use 16");
	local v110;
	local v111 = {bloodFuryValue=((v17.BloodFury:IsAvailable() and ("/cast " .. v17.BloodFury:Name() .. "\n")) or (v17.Berserking:IsAvailable() and ("/cast " .. v17.Berserking:Name() .. "\n")) or ""),pyroblastValue=v17.Pyroblast:Name(),flamestrikeValue=v17.Flamestrike:Name(),trinket=((v110 and ("/use " .. v110 .. "\n")) or "")};
	local v112 = "{trinket}{bloodFuryValue}/cast {pyroblastValue}";
	local v113 = "{trinket}{bloodFuryValue}/cast [@cursor] {flamestrikeValue}";
	v8:UpdateMacro("macro2", v84(v112, v111));
	v8:UpdateMacro("macro6", "/stopcasting");
	v21.PostInitialMessage(19 + 44);
end
v8.SetAPL(16 + 47, v83, v86);
