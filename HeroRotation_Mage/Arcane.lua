local v0, v1 = ...;
local v2 = HeroDBC.DBC;
local v3 = HeroLib;
local v4 = v3.Unit;
local v5 = v4.Player;
local v6 = v4.Target;
local v7 = v3.Spell;
local v8 = v3.Item;
local v9 = HeroRotation();
local v10 = v9.Commons().Mage;
local v11 = v9.Cast;
local v12 = v9.CastLeft;
local v13 = v9.CDsON;
local v14 = v9.AoEON;
local v15 = v9.Commons().Everyone.num;
local v16 = v9.Commons().Everyone.bool;
local v17 = math.max;
local v18 = v7.Mage.Arcane;
local v19 = v8.Mage.Arcane;
local v20 = {v19.AberrantSpellforge:ID(),v19.FearbreakersEcho:ID(),v19.HighSpeakersAccretion:ID(),v19.ImperfectAscendancySerum:ID(),v19.MadQueensMandate:ID(),v19.MereldarsToll:ID(),v19.SpymastersWeb:ID(),v19.TreacherousTransmitter:ID(),v19.KahetiShadowweaversEmblem:ID()};
local v21;
local v22;
local function v23()
	if (not v5:IsMoving() and not v5:IsCameraBusy()) then
		return v11(v18.ArcaneOrb);
	else
		v12(v18.ArcaneOrb);
	end
end
local function v24(v54)
	if (v18.IceFloes:IsCastable() and not v18.IceFloes:InFlight() and (v18.IceFloes:TimeSinceLastCast() > (1 + 0)) and v5:IsMoving() and v5:BuffDown(v18.IceFloes)) then
		v11(v18.IceFloes, true);
		return "ice_floes";
	elseif (not v5:IsMoving() or v5:BuffUp(v18.IceFloes)) then
		v11(v54);
		return v54:Name();
	end
end
local v25 = v9.GUISettingsGet();
local v26 = v9.Commons().Everyone;
local v27 = {General=v25.General,Commons=v25.APL.Mage.Commons,Arcane=v25.APL.Mage.Arcane,Defense=v25.APL.Mage.Defense.Defensive};
v18.ArcaneBlast:RegisterInFlight();
v18.ArcaneBarrage:RegisterInFlight();
local v28 = (not v18.ArcingCleave:IsAvailable() and (886 - (282 + 595))) or (1639 - (1523 + 114));
local v29 = true;
local v30 = false;
local v31, v32;
local v33 = (v18.ImprovedClearcasting:IsAvailable() and (3 + 0)) or (1 - 0);
local v32, v34, v35;
local v36 = v9.ToggleIconFrame:GetToggle(1067 - (68 + 997));
local v37, v38;
local v39 = 12381 - (226 + 1044);
local v40 = 48381 - 37270;
local v41;
local v42 = 128 - (32 + 85);
local v43 = v5:GladiatorsBadgeIsEquipped() or v19.SignetofthePriory:IsEquipped() or v19.HighSpeakersAccretion:IsEquipped() or v19.SpymastersWeb:IsEquipped() or v19.TreacherousTransmitter:IsEquipped() or v19.ImperfectAscendancySerum:IsEquipped() or v19.QuickwickCandlestick:IsEquipped();
local v44 = (v5:GladiatorsBadgeIsEquipped() or v19.SignetofthePriory:IsEquipped() or v19.HighSpeakersAccretion:IsEquipped() or v19.SpymastersWeb:IsEquipped() or v19.ImperfectAscendancySerum:IsEquipped() or v19.QuickwickCandlestick:IsEquipped()) and v19.TreacherousTransmitter:IsEquipped();
v3:RegisterForEvent(function()
	v28 = (not v18.ArcingCleave:IsAvailable() and (9 + 0)) or (1 + 1);
	v29 = true;
	v30 = false;
	v39 = 12068 - (892 + 65);
	v40 = 26505 - 15394;
end, "PLAYER_REGEN_ENABLED");
v3:RegisterForEvent(function()
	v28 = (not v18.ArcingCleave:IsAvailable() and (16 - 7)) or (3 - 1);
	v33 = (v18.ImprovedClearcasting:IsAvailable() and (353 - (87 + 263))) or (181 - (67 + 113));
end, "SPELLS_CHANGED", "LEARNED_SPELL_IN_TAB");
v3:RegisterForEvent(function()
	v43 = v5:GladiatorsBadgeIsEquipped() or v19.SignetofthePriory:IsEquipped() or v19.HighSpeakersAccretion:IsEquipped() or v19.SpymastersWeb:IsEquipped() or v19.TreacherousTransmitter:IsEquipped() or v19.ImperfectAscendancySerum:IsEquipped();
	v44 = (v5:GladiatorsBadgeIsEquipped() or v19.SignetofthePriory:IsEquipped() or v19.HighSpeakersAccretion:IsEquipped() or v19.SpymastersWeb:IsEquipped() or v19.ImperfectAscendancySerum:IsEquipped() or v19.QuickwickCandlestick:IsEquipped()) and v19.TreacherousTransmitter:IsEquipped();
end, "PLAYER_EQUIPMENT_CHANGED");
local function v45()
	if v10.Precast() then
		if (v19.TreacherousTransmitter:IsEquippedAndReady() and not (v18.SplinteringSorcery:IsAvailable() and v44)) then
			if v11(v19.TreacherousTransmitter) then
				return "treacherous_transmitter precombat 2";
			end
		end
		if (v18.MirrorImage:IsCastable() and v27.Arcane.MirrorImagesBeforePull) then
			if v11(v18.MirrorImage) then
				return "mirror_image precombat";
			end
		end
		if (v18.ArcaneBlast:IsReady() and (not v18.Evocation:IsAvailable() or not v13()) and v10.TTDCastTimeCondition(v18.ArcaneBlast, v21, v40)) then
			if v24(v18.ArcaneBlast) then
				return "arcane_blast precombat";
			end
		end
		if (v19.ImperfectAscendancySerum:IsEquippedAndReady() and v13()) then
			if v11(v19.ImperfectAscendancySerum) then
				return "imperfect_ascendancy_serum precombat 8";
			end
		end
		if (v18.Evocation:IsReady() and v13()) then
			if v11(v18.Evocation) then
				return "evocation precombat";
			end
		end
	end
end
local function v46(v55)
	if not v18.MagisSpark:IsAvailable() then
		return -(2 + 0);
	end
	local v56 = v6:DebuffRemains(v18.TouchoftheMagiDebuff);
	if (v56 == (0 - 0)) then
		return -(1 + 0);
	end
	if v5:IsCasting(v55) then
		return -(11 - 8);
	end
	if (((964 - (802 + 150)) - v56) > v55:TimeSinceLastCast()) then
		return 0 - 0;
	else
		return v56;
	end
end
local function v47()
	if (v18.TouchoftheMagi:CooldownUp(true) and v13() and ((v5:PrevGCDP(1 - 0, v18.ArcaneBarrage) and (((v18.ArcaneBarrage:TravelTime() - v18.ArcaneBarrage:TimeSinceLastCast()) <= (1 + 0)) or (v5:GCDRemains() <= (998 - (915 + 82)))) and (v5:BuffUp(v18.ArcaneSurgeBuff) or (v18.ArcaneSurge:CooldownRemains() > (84 - 54)))) or (v5:PrevGCDP(1 + 0, v18.ArcaneSurge) and (v5:ArcaneCharges() < (4 - 0))))) then
		if v11(v18.TouchoftheMagi, true) then
			return "touch_of_the_magi cd_opener 2";
		end
	end
	if (v18.ArcaneBlast:IsReady() and (v5:BuffUp(v18.PresenceofMindBuff))) then
		if v24(v18.ArcaneBlast) then
			return "arcane_blast cd_opener 4";
		end
	end
	if (v18.ArcaneOrb:IsReady() and (v18.ArcaneOrb:TimeSinceLastCast() >= (1197 - (1069 + 118))) and v18.HighVoltage:IsAvailable() and v29) then
		if v23() then
			return "ArcaneOrb Opener";
		end
	end
	if (v18.Evocation:IsReady() and v13() and (v18.ArcaneSurge:CooldownRemains() < (v41 * (6 - 3))) and (v18.TouchoftheMagi:CooldownRemains() < (v41 * (10 - 5)))) then
		if v24(v18.Evocation) then
			return "Evocation Opener";
		end
	end
	if (v29 and v5:IsChanneling(v18.ArcaneMissiles) and (v18.ArcaneMissiles:TickTime() > v5:GCDRemains()) and v5:BuffDown(v18.AetherAttunementBuff)) then
		v9.CastMacro(2 + 4, true);
		return "ArcaneMissiles Opener break";
	end
	if (v18.ArcaneMissiles:IsReady() and (v18.ArcaneMissiles:TimeSinceLastCast() > (53 - 23)) and v10.TTDCondition(10 + 0, v21, v40) and v29) then
		v11(v18.ArcaneMissiles);
		return "ArcaneMissiles Opener";
	end
	if (v18.ArcaneSurge:IsCastable() and v13() and (v18.TouchoftheMagi:CooldownRemains() < (v18.ArcaneSurge:ExecuteTime() + (v5:GCD() * v15(v5:ArcaneCharges() == (795 - (368 + 423)))))) and v10.TTDCondition(v27.Arcane.TimeToDie.ArcaneSurge, v21, v40)) then
		if v24(v18.ArcaneSurge) then
			return "ArcaneSurge";
		end
	end
end
local function v48()
	if (v18.Supernova:IsReady() and (v5:BuffStack(v18.UnerringProficiency) == (94 - 64)) and v6:IsInRange(26 - (10 + 8))) then
		v9.Cast(v18.Supernova);
		return "Supernova 30 stacks AOE";
	end
	if (v18.ShiftingPower:IsReady() and v36 and v5:PrevGCDP(3 - 2, v18.ArcaneBarrage) and (v5:BuffUp(v18.ArcaneSurgeBuff) or v6:DebuffUp(v18.TouchoftheMagiDebuff) or (v18.Evocation:CooldownRemains() < (462 - (416 + 26)))) and v18.ShiftingShards:IsAvailable()) then
		if v24(v18.ShiftingPower) then
			return "ShiftingPower AOE";
		end
	end
	if (v18.ArcaneOrb:IsReady() and (v5:ArcaneCharges() < (6 - 4))) then
		if v23() then
			return "ArcaneOrb AOE";
		end
	end
	if (v18.ArcaneBlast:IsReady() and v6:DebuffUp(v18.MagisSparkABDebuff) and (v18.ArcaneBlast:TimeSinceLastCast() > (0.015 + 0)) and v10.TTDCastTimeCondition(v18.ArcaneBlast, v21, v40)) then
		if v24(v18.ArcaneBlast) then
			return "ArcaneBlast AOE magis_spark";
		end
	end
	if (v18.ArcaneBarrage:IsReady() and v18.ArcaneTempo:IsAvailable() and v5:BuffUp(v18.ArcaneTempoBuff) and (v5:BuffRemains(v18.ArcaneTempoBuff) < v41)) then
		v11(v18.ArcaneBarrage);
		return "ArcaneBarrage AOE 1";
	end
	if (v18.ArcaneBarrage:IsReady() and v5:BuffUp(v18.IntuitionBuff) and ((v5:ArcaneCharges() == v5:ArcaneChargesMax()) or not v18.HighVoltage:IsAvailable()) and v5:BuffUp(v18.NetherPrecisionBuff)) then
		v11(v18.ArcaneBarrage);
		return "ArcaneBarrage AOE 2";
	end
	if (v18.ArcaneBarrage:IsReady() and v5:BuffUp(v18.NetherPrecisionBuff) and (v5:IsCasting(v18.ArcaneBlast) or v5:PrevGCDP(1 - 0, v18.ArcaneBlast))) then
		v11(v18.ArcaneBarrage);
		return "ArcaneBarrage AOE 3";
	end
	if (v5:IsChanneling(v18.ArcaneMissiles) and (v18.ArcaneMissiles:TickTime() > v5:GCDRemains()) and v5:BuffDown(v18.AetherAttunementBuff)) then
		v9.CastMacro(444 - (145 + 293), true);
		return "ArcaneMissiles AOE break";
	end
	if (v18.ArcaneMissiles:IsReady() and v5:BuffUp(v18.ClearcastingBuff) and ((v18.HighVoltage:IsAvailable() and (v5:ArcaneCharges() < v5:ArcaneChargesMax())) or v5:BuffUp(v18.AetherAttunementBuff) or v18.ArcaneHarmony:IsAvailable()) and (v5:BuffDown(v18.NetherPrecisionBuff))) then
		v11(v18.ArcaneMissiles);
		return "ArcaneMissiles AOE";
	end
	if (v18.PresenceofMind:IsReady() and ((v5:ArcaneCharges() == (433 - (44 + 386))) or (v5:ArcaneCharges() == (1488 - (998 + 488))))) then
		if v11(v18.PresenceofMind) then
			return "PresenceofMind AOE";
		end
	end
	if (v18.ArcaneBarrage:IsReady() and (v5:ArcaneCharges() == v5:ArcaneChargesMax())) then
		v11(v18.ArcaneBarrage);
		return "ArcaneBarrage AOE";
	end
	if (v18.ArcaneExplosion:IsReady() and (v37 >= v28)) then
		v11(v18.ArcaneExplosion);
		return "ArcaneExplosion AOE";
	end
end
local function v49()
	if ((v5:BuffDown(v18.ArcaneSurgeBuff) and v5:BuffDown(v18.SiphonStormBuff) and v6:DebuffDown(v18.TouchoftheMagiDebuff) and (v18.Evocation:CooldownRemains() > (5 + 10)) and ((v18.TouchoftheMagi:CooldownRemains() > (9 + 1)) or not v13()) and (v18.ArcaneOrb:CooldownRemains() > (772 - (201 + 571))) and (v18.ArcaneOrb:Charges() == (1138 - (116 + 1022))) and (v40 > (41 - 31))) or (v5:PrevGCDP(1 + 0, v18.ArcaneBarrage) and (v5:BuffUp(v18.ArcaneSurgeBuff) or v6:DebuffUp(v18.TouchoftheMagiDebuff) or (v18.Evocation:CooldownRemains() < (73 - 53))))) then
		if (v18.ShiftingPower:IsReady() and v36) then
			if v24(v18.ShiftingPower) then
				return "ShiftingPower";
			end
		end
	end
	if (v18.PresenceofMind:IsCastable() and (v6:DebuffRemains(v18.TouchoftheMagiDebuff) <= v41) and v5:BuffUp(v18.NetherPrecisionBuff) and (v32 < v28) and not v18.UnerringProficiency:IsAvailable()) then
		if v11(v18.PresenceofMind) then
			return "presence_of_mind spellslinger 4";
		end
	end
	if (v18.Supernova:IsReady() and (v6:DebuffRemains(v18.TouchoftheMagiDebuff) < v41) and (v5:BuffStack(v18.UnerringProficiency) == (106 - 76)) and v6:IsInRange(867 - (814 + 45))) then
		v9.Cast(v18.Supernova);
		return "Supernova 30 stacks";
	end
	if (v18.ArcaneBarrage:IsReady() and (((v5:BuffStack(v18.NetherPrecisionBuff) == (2 - 1)) and ((v18.ArcaneBlast:TimeSinceLastCast() < (0.015 + 0)) or v5:IsCasting(v18.ArcaneBlast))) or v22 or (v18.ArcaneTempo:IsAvailable() and (v5:BuffRemains(v18.ArcaneTempoBuff) < v5:GCD())) or (v18.ArcaneTempo:IsAvailable() and (v5:BuffRemains(v18.ArcaneTempoBuff) < v5:GCD())))) then
		v11(v18.ArcaneBarrage);
		return "ArcaneBarrage ST 1 " .. v5:BuffStack(v18.NetherPrecisionBuff) .. "," .. tostring(v18.ArcaneBlast:TimeSinceLastCast() < (0.015 + 0)) .. "," .. tostring(v5:IsCasting(v18.ArcaneBlast)) .. "," .. tostring(v22);
	end
	if (v5:IsChanneling(v18.ArcaneMissiles) and (v18.ArcaneMissiles:TickTime() > v5:GCDRemains()) and v5:BuffDown(v18.AetherAttunementBuff)) then
		v9.CastMacro(891 - (261 + 624), true);
		return "ArcaneMissiles ST break";
	end
	if (v18.ArcaneMissiles:IsReady() and ((v5:BuffUp(v18.ClearcastingBuff) and v5:BuffDown(v18.NetherPrecisionBuff)) or (v5:BuffStack(v18.ClearcastingBuff) == (4 - 1)))) then
		v11(v18.ArcaneMissiles);
		return "ArcaneMissiles ST";
	end
	if (v18.ArcaneOrb:IsReady() and (v5:ArcaneCharges() < (1082 - (1020 + 60)))) then
		if v23() then
			return "ArcaneOrb ST";
		end
	end
	if (v18.ArcaneBlast:IsReady() and v10.TTDCastTimeCondition(v18.ArcaneBlast, v21, v40)) then
		if v24(v18.ArcaneBlast) then
			return "ArcaneBlast";
		end
	end
	if v18.ArcaneBarrage:IsReady() then
		v11(v18.ArcaneBarrage);
		return "ArcaneBarrage ST";
	end
end
local function v50()
	if (v18.ArcaneBarrage:IsCastable() and v5:BuffUp(v18.ArcaneSoulBuff) and ((v5:BuffStack(v18.ClearcastingBuff) < (1426 - (630 + 793))) or (v5:BuffRemains(v18.ArcaneSoulBuff) < v5:GCD()))) then
		if v11(v18.ArcaneBarrage, nil, nil, not v6:IsSpellInRange(v18.ArcaneBarrage)) then
			return "ArcaneBarrage SF AOE";
		end
	end
	if (v5:IsChanneling(v18.ArcaneMissiles) and (v18.ArcaneMissiles:TickTime() > v5:GCDRemains()) and v5:BuffDown(v18.AetherAttunementBuff)) then
		v9.CastMacro(19 - 13, true);
		return "ArcaneMissiles SF AOE break";
	end
	if (v18.ArcaneMissiles:IsReady() and (v5:BuffUp(v18.ArcaneSoulBuff))) then
		v11(v18.ArcaneMissiles);
		return "ArcaneMissiles SF AOE";
	end
	if (v18.ShiftingPower:IsReady() and v5:BuffDown(v18.ArcaneSurgeBuff) and v5:BuffDown(v18.SiphonStormBuff) and v6:DebuffDown(v18.TouchoftheMagiDebuff) and (v18.Evocation:CooldownRemains() > (71 - 56)) and (v18.TouchoftheMagi:CooldownRemains() > (6 + 9)) and v18.ArcaneOrb:CooldownDown() and (v18.ArcaneOrb:Charges() == (0 - 0)) and (v40 > (1757 - (760 + 987)))) then
		if (v18.ShiftingPower:IsReady() and v36) then
			if v24(v18.ShiftingPower) then
				return "ShiftingPower SF AOE";
			end
		end
	end
	if (v18.ArcaneOrb:IsReady() and (v5:ArcaneCharges() < (1915 - (1789 + 124))) and (not v18.HighVoltage:IsAvailable() or v5:BuffDown(v18.ClearcastingBuff))) then
		if v23() then
			return "ArcaneOrb SF AOE";
		end
	end
	if (v18.ArcaneBlast:IsReady() and v10.TTDCastTimeCondition(v18.ArcaneBlast, v21, v40) and v6:DebuffUp(v18.MagisSparkABDebuff) and (v18.ArcaneBlast:TimeSinceLastCast() > (766.015 - (745 + 21)))) then
		if v24(v18.ArcaneBlast) then
			return "arcane_blast sunfury_aoe 12";
		end
	end
	if (v18.ArcaneBarrage:IsReady() and (v5:ArcaneCharges() == (2 + 2))) then
		v11(v18.ArcaneBarrage);
		return "ArcaneBarrage SF AOE 2";
	end
	if (v5:IsChanneling(v18.ArcaneMissiles) and v5:IsChanneling(v18.ArcaneMissiles) and (v18.ArcaneMissiles:TickTime() > v5:GCDRemains()) and v5:BuffDown(v18.AetherAttunementBuff)) then
		v9.CastMacro(16 - 10, true);
		return "ArcaneMissiles SF AOE break";
	end
	if (v18.ArcaneMissiles:IsReady() and v5:BuffUp(v18.ClearcastingBuff) and (v5:BuffUp(v18.AetherAttunementBuff) or v18.ArcaneHarmony:IsAvailable())) then
		v11(v18.ArcaneMissiles);
		return "ArcaneMissiles SF AOE2";
	end
	if (v18.PresenceofMind:IsReady() and ((v5:ArcaneCharges() == (11 - 8)) or (v5:ArcaneCharges() == (1 + 1)))) then
		if v11(v18.PresenceofMind) then
			return "PresenceofMind SF AOE";
		end
	end
	if (v18.ArcaneExplosion:IsReady() and (v37 >= v28) and (v18.Reverberate:IsAvailable() or (v5:ArcaneCharges() < (1 + 0)))) then
		v11(v18.ArcaneExplosion);
		return "ArcaneExplosion SF AOE 2";
	end
	if (v18.ArcaneBlast:IsReady() and v10.TTDCastTimeCondition(v18.ArcaneBlast, v21, v40)) then
		if v24(v18.ArcaneBlast) then
			return "ArcaneBlast SF AOE";
		end
	end
	if v18.ArcaneBarrage:IsReady() then
		v11(v18.ArcaneBarrage);
		return "ArcaneBarrage SF AOE 3";
	end
end
local function v51()
	if (v18.ShiftingPower:IsReady() and v36 and v5:BuffDown(v18.ArcaneSurgeBuff) and v5:BuffDown(v18.SiphonStormBuff) and v6:DebuffDown(v18.TouchoftheMagiDebuff) and (v18.Evocation:CooldownRemains() > (1070 - (87 + 968))) and ((v18.TouchoftheMagi:CooldownRemains() > (44 - 34)) or not v13()) and (v40 > (10 + 0)) and v5:BuffDown(v18.ArcaneSoulBuff)) then
		if v24(v18.ShiftingPower) then
			return "ShiftingPower SF";
		end
	end
	if (v18.PresenceofMind:IsCastable() and (v6:DebuffRemains(v18.TouchoftheMagiDebuff) <= v41) and v5:BuffUp(v18.NetherPrecisionBuff) and (v32 < (8 - 4))) then
		if v11(v18.PresenceofMind) then
			return "presence_of_mind sunfury 4";
		end
	end
	if (v18.ArcaneBarrage:IsCastable() and (((v5:ArcaneCharges() == (1417 - (447 + 966))) and v5:PrevGCDP(2 - 1, v18.ArcaneBlast) and (v5:BuffStack(v18.NetherPrecisionBuff) == (1818 - (1703 + 114))) and (v32 >= ((706 - (376 + 325)) - ((2 - 0) * v15(v18.ArcaneBombardment:IsAvailable() and (v6:HealthPercentage() < (107 - 72)))))) and v18.ArcingCleave:IsAvailable() and ((v18.HighVoltage:IsAvailable() and v5:BuffUp(v18.ClearcastingBuff)) or (v18.ArcaneOrb:CooldownRemains() < v41) or (v18.ArcaneOrb:Charges() > (0 + 0)))) or (v5:BuffUp(v18.AetherAttunementBuff) and v18.HighVoltage:IsAvailable() and v5:BuffUp(v18.ClearcastingBuff) and (v5:ArcaneCharges() > (2 - 1)) and (v32 > (15 - (9 + 5)))))) then
		if v11(v18.ArcaneBarrage) then
			return "arcane_barrage sunfury 6";
		end
	end
	if (v18.ArcaneOrb:IsReady() and (v5:ArcaneCharges() < (378 - (85 + 291))) and v5:BuffDown(v18.ArcaneSoulBuff) and (not v18.HighVoltage:IsAvailable() or v5:BuffDown(v18.ClearcastingBuff))) then
		if v23() then
			return "ArcaneOrb SF";
		end
	end
	if (v18.ArcaneBarrage:IsCastable() and (((v5:ArcaneCharges() == (1269 - (243 + 1022))) and (v5:BuffUp(v18.BurdenofPowerBuff) or v5:BuffUp(v18.GloriousIncandescenceBuff) or v5:BuffUp(v18.IntuitionBuff)) and ((v5:PrevGCDP(3 - 2, v18.ArcaneBlast) and (v5:BuffStack(v18.NetherPrecisionBuff) == (1 + 0))) or (((v3.CombatTime() - v18.ArcaneBlast:TimeSinceLastCast()) > (1180.015 - (1123 + 57))) and (v5:BuffStack(v18.NetherPrecisionBuff) == (2 + 0))) or (v5:BuffDown(v18.NetherPrecisionBuff) and v5:BuffDown(v18.ClearcastingBuff)))) or (v5:BuffUp(v18.ArcaneSoulBuff) and ((v5:BuffStack(v18.ClearcastingBuff) < (257 - (163 + 91))) or (v5:BuffRemains(v18.ArcaneSoulBuff) < v41))) or ((v5:ArcaneCharges() == (1934 - (1869 + 61))) and v18.TouchoftheMagi:CooldownUp()))) then
		v11(v18.ArcaneBarrage);
		return "ArcaneBarrage SF 3";
	end
	if (v5:IsChanneling(v18.ArcaneMissiles) and (v5:GCDRemains() == (0 + 0))) then
		v9.CastMacro(20 - 14, true);
		return "ArcaneMissiles SF break";
	end
	if (v18.ArcaneMissiles:IsReady() and v5:BuffUp(v18.ClearcastingBuff) and (v5:BuffDown(v18.NetherPrecisionBuff) or (v5:BuffStack(v18.ClearcastingBuff) == (4 - 1)) or (v18.HighVoltage:IsAvailable() and (v5:ArcaneCharges() < (1 + 2))) or ((v5:BuffStack(v18.NetherPrecisionBuff) == (1 - 0)) and v5:PrevGCDP(1 + 0, v18.ArcaneBlast)))) then
		v11(v18.ArcaneMissiles);
		return "ArcaneMissiles SF";
	end
	if (v18.PresenceofMind:IsCastable() and ((v5:ArcaneCharges() == (1477 - (1329 + 145))) or (v5:ArcaneCharges() == (973 - (140 + 831)))) and (v32 >= (1853 - (1409 + 441)))) then
		if v11(v18.PresenceofMind) then
			return "presence_of_mind sunfury 16";
		end
	end
	if (v18.ArcaneExplosion:IsReady() and (v37 >= v28) and (v18.Reverberate:IsAvailable() or (v5:ArcaneCharges() < (719 - (15 + 703)))) and (v32 >= (2 + 2))) then
		if v11(v18.ArcaneExplosion) then
			return "arcane_explosion sunfury 18";
		end
	end
	if (v18.ArcaneBlast:IsReady() and v10.TTDCastTimeCondition(v18.ArcaneBlast, v21, v40)) then
		if v24(v18.ArcaneBlast) then
			return "ArcaneBlast SF";
		end
	end
	if v18.ArcaneBarrage:IsReady() then
		v11(v18.ArcaneBarrage);
		return "ArcaneBarrage SF";
	end
end
local function v52()
	v36 = v9.ToggleIconFrame:GetToggle(440 - (262 + 176));
	if v26.ShouldStopCastUpdate() then
		v9.CastMacro(1727 - (345 + 1376), true);
		return "Stop Cast For Silence";
	end
	if v10.IncorporealBeing() then
		if v10.AutoTarget() then
			return "Tab Away from Incorp";
		end
		return "Ignore Target Incorp";
	end
	local v57 = not v5:AffectingCombat() or not v6:AffectingCombat() or v6:IsDummy();
	v34 = v5:GetEnemiesInRange(728 - (198 + 490));
	v35 = v10.RangeOOCCount() or #v34;
	v38 = v5:GetEnemiesInRange(44 - 34);
	if v14() then
		v32 = (v57 and v35) or v6:GetEnemiesInSplashRangeCount(18 - 10);
		v37 = #v38;
	else
		v32 = 1207 - (696 + 510);
		v37 = 1 - 0;
	end
	if (v26.TargetIsValid() or v5:AffectingCombat()) then
		v39 = v3.BossFightRemains();
		v21 = true;
		v40 = v39;
		if (v40 == (12373 - (1091 + 171))) then
			v21 = false;
			v40 = v3.FightRemains(v34, false);
		end
	end
	v22 = v18.TouchoftheMagi:IsReady() and v13() and v10.TTDCondition(v27.Arcane.TimeToDie.TouchoftheMagi, v21, v40) and (v5:BuffUp(v18.ArcaneSurgeBuff) or (v18.ArcaneSurge:CooldownRemains() > (5 + 25)));
	v41 = v5:GCD() + (0.25 - 0);
	if (not v5:AffectingCombat() and not v6:AffectingCombat()) then
		if (v18.ArcaneIntellect:IsCastable() and v27.Commons.AutoBuff and ((v26.GroupBuffMissing(v18.ArcaneIntellect) and (v5:IsInRaidArea() or v5:IsInDungeonArea()) and (v5:InstanceDifficulty() ~= (679 - 474))) or v5:BuffDown(v18.ArcaneIntellect, true) or (v5:BuffDown(v18.ArcaneFamiliarBuff, true) and v18.ArcaneFamiliar:IsAvailable()))) then
			if v9.CastTarget(v18.ArcaneIntellect, "PLAYER") then
				return "arcane_intellect precombat 2";
			end
		end
		if (v18.PrismaticBarrier:IsCastable() and (v5:BuffRemains(v18.PrismaticBarrier) < (380 - (123 + 251)))) then
			v9.Cast(v18.PrismaticBarrier);
			return "Prismatic Barrier precombat";
		end
	end
	if (v26.TargetIsValid() and v6:IsInRange(198 - 158) and not v5:AffectingCombat() and (v10.Precast() or v10.CombatCheck())) then
		ShouldReturn = v45();
		if ShouldReturn then
			return ShouldReturn;
		end
	end
	if (v10.CombatCheck() and v6:IsInRange(738 - (208 + 490))) then
		if (v18.IceFloes:IsCastable() and v5:BuffUp(v18.IceFloes) and (v5:BuffStack(v18.IceFloes) < (1 + 1)) and v5:IsMoving() and v5:IsCasting() and (v5:CastRemains() < (0.5 + 0))) then
			if v11(v18.IceFloes, true) then
				return "ice_floes movement 2";
			end
		end
		if (v18.EnergizedBarrier:IsAvailable() and (v5:DebuffElapsed(v18.EntangledDebuff) > (837 - (660 + 176)))) then
			if v18.MassBarrier:IsReady() then
				v11(v18.MassBarrier);
				return "Cast MassBarrier Entangled";
			end
			if v18.PrismaticBarrier:IsReady() then
				v11(v18.PrismaticBarrier);
				return "Cast PrismaticBarrier Entangled";
			end
		end
		if (v18.MassBarrier:IsCastable() and not v5:BuffUp(v18.IceCold) and (v5:HealthPercentage() < v27.Defense.MassBarrier)) then
			v9.Cast(v18.MassBarrier);
			return "Mass Barrier Defensive";
		end
		if (v18.PrismaticBarrier:IsCastable() and not v5:BuffUp(v18.IceCold) and (v5:HealthPercentage() < v27.Defense.Barrier)) then
			v9.Cast(v18.PrismaticBarrier);
			return "Ice Barrier Defensive";
		end
		if (v18.IceCold:IsCastable() and (v5:HealthPercentage() < v27.Defense.IceCold)) then
			v9.Cast(v18.IceBlock);
			return "Ice Cold Defensive";
		end
		if (v18.MirrorImage:IsCastable() and not v5:BuffUp(v18.IceCold) and (v5:HealthPercentage() < v27.Defense.MirrorImage)) then
			v9.Cast(v18.MirrorImage);
			return "Mass Barrier Defensive";
		end
		if (v9.ToggleIconFrame:GetToggle(1 + 2) and v6:DebuffDown(v18.TouchoftheMagiDebuff) and v5:BuffDown(v18.ArcaneSurgeBuff)) then
			if (not v5:IsCasting() and not v5:IsChanneling()) then
				ShouldReturn = v26.InterruptCycle(v18.Counterspell, 242 - (14 + 188), true, nil, false);
				if ShouldReturn then
					return ShouldReturn;
				end
				ShouldReturn = v26.InterruptCycle(v18.DragonsBreath, 685 - (534 + 141), true, nil, true);
				if ShouldReturn then
					return ShouldReturn;
				end
				ShouldReturn = v26.InterruptCycle(v18.Supernova, 4 + 4, true, nil, true);
				if ShouldReturn then
					return ShouldReturn;
				end
			end
			ShouldReturn = not v5:IsCasting(v18.Polymorph) and v26.IncorpCycle(v18.Polymorph, 27 + 3, true, nil, false);
			if ShouldReturn then
				return ShouldReturn;
			end
			if (v9.ToggleIconFrame:GetToggle(4 + 0) and v6:DebuffDown(v18.TouchoftheMagiDebuff) and v5:BuffDown(v18.ArcaneSurgeBuff)) then
				ShouldReturn = v18.RemoveCurse:IsAvailable() and v18.RemoveCurse:IsReady() and not v5:IsInRaid() and v26.DispelCycle(v18.RemoveCurse, "Curse");
				if ShouldReturn then
					return ShouldReturn;
				end
				ShouldReturn = v18.RemoveCurse:IsAvailable() and v18.RemoveCurse:IsReady() and v26.AfflictedLogic(v18.RemoveCurse);
				if ShouldReturn then
					return ShouldReturn;
				end
			end
			ShouldReturn = not v5:IsChanneling() and v18.SpellSteal:IsAvailable() and v10.StealCycle(v18.SpellSteal, 84 - 44, false, v27.AutoTargetSpellSteal);
			if ShouldReturn then
				return ShouldReturn;
			end
		end
		if (v13() and v27.Commons.Enabled.Potions and ((not v19.SpymastersWeb:IsEquipped() and (v5:BuffUp(v18.SiphonStormBuff) or (not v18.Evocation:IsAvailable() and v18.ArcaneSurge:CooldownUp()))) or (v19.SpymastersWeb:IsEquipped() and (v5:BuffUp(v18.SpymastersWebBuff) or ((v40 > (523 - 193)) and v5:BuffUp(v18.SiphonStormBuff)))))) then
			local v59 = v26.PotionSelected();
			if (v59 and v59:IsReady()) then
				if v9.CastMacro(8 - 5, true, nil, v59) then
					return "potion main 2";
				end
			end
		end
		if (v13() and not v5:IsMoving()) then
			if (v18.LightsJudgment:IsCastable() and v5:BuffDown(v18.ArcaneSurgeBuff) and v6:DebuffDown(v18.TouchoftheMagiDebuff) and (v32 >= (2 + 0))) then
				if v11(v18.LightsJudgment) then
					return "lights_judgment main 6";
				end
			end
			if ((v5:PrevGCDP(1 + 0, v18.ArcaneSurge) and v29) or (v5:PrevGCDP(397 - (115 + 281), v18.ArcaneSurge) and ((v40 < (186 - 106)) or (v6:HealthPercentage() < (29 + 6)) or not v18.ArcaneBombardment:IsAvailable())) or (v5:PrevGCDP(2 - 1, v18.ArcaneSurge) and not v19.SpymastersWeb:IsEquipped())) then
				if v18.Berserking:IsCastable() then
					if v11(v18.Berserking, true) then
						return "berserking main 8";
					end
				end
				if v18.BloodFury:IsCastable() then
					if v11(v18.BloodFury, true) then
						return "blood_fury main 10";
					end
				end
				if v18.Fireblood:IsCastable() then
					if v11(v18.Fireblood, true) then
						return "fireblood main 12";
					end
				end
				if v18.AncestralCall:IsCastable() then
					if v11(v18.AncestralCall, true) then
						return "ancestral_call main 14";
					end
				end
			end
			if (v27.Commons.Enabled.Trinkets and v13()) then
				local v64, v65, v66 = v5:GetUseableItems(v20);
				if (v64 and (v5:PrevGCDP(3 - 2, v18.ArcaneSurge) or v5:PrevGCDP(868 - (550 + 317), v18.Evocation) or (v39 < (28 - 8)) or not v43)) then
					if ((v65 == (17 - 4)) or (v65 == (39 - 25))) then
						if v11(v64) then
							return "Generic use_items for " .. v64:Name() .. " main 14";
						end
					end
				end
			end
			if (v27.Commons.Enabled.Trinkets and v13()) then
				if (v19.SpymastersWeb:IsEquippedAndReady() and (((v5:PrevGCDP(286 - (134 + 151), v18.ArcaneSurge) or v5:PrevGCDP(1666 - (970 + 695), v18.Evocation) or (v5:BuffUp(v18.EtherealPowerlinkBuff) and v5:BuffUp(v18.SiphonStormBuff) and v18.SpellfireSpheres:IsAvailable())) and ((v40 < (152 - 72)) or (v6:HealthPercentage() < (2025 - (582 + 1408))) or not v18.ArcaneBombardment:IsAvailable() or ((v5:BuffStack(v18.SpymastersWebBuff) == (138 - 98)) and (v40 > (301 - 61))))) or (v39 < (75 - 55)))) then
					if v11(v19.SpymastersWeb) then
						return "spymasters_web main 16";
					end
				end
				if (v19.HighSpeakersAccretion:IsEquippedAndReady() and (v5:PrevGCDP(1825 - (1195 + 629), v18.ArcaneSurge) or v5:PrevGCDP(1 - 0, v18.Evocation) or (v18.Evocation:CooldownRemains() < (245 - (187 + 54))) or (v39 < (800 - (162 + 618))))) then
					if v11(v19.HighSpeakersAccretion) then
						return "high_speakers_accretion main 18";
					end
				end
				if (v19.ImperfectAscendancySerum:IsEquippedAndReady() and (v18.Evocation:CooldownUp() or v18.ArcaneSurge:CooldownUp() or (v39 < (15 + 5)))) then
					if v11(v19.ImperfectAscendancySerum) then
						return "imperfect_ascendancy_serum main 20";
					end
				end
				if (v19.TreacherousTransmitter:IsEquippedAndReady() and (((v18.Evocation:CooldownRemains() < (5 + 2)) and v18.Evocation:CooldownDown()) or (v39 < (42 - 22)))) then
					if v11(v19.TreacherousTransmitter) then
						return "treacherous_transmitter main 22";
					end
				end
				if (v19.AberrantSpellforge:IsEquippedAndReady() and (not v43 or v5:BuffDown(v18.SiphonStormBuff) or (v19.SpymastersWeb:IsEquipped() and (v6:HealthPercentage() > (58 - 23))))) then
					if v11(v19.AberrantSpellforge) then
						return "aberrant_spellforge main 24";
					end
				end
				if (v19.MadQueensMandate:IsEquippedAndReady() and (not v43 or v5:BuffDown(v18.SiphonStormBuff))) then
					if v11(v19.MadQueensMandate) then
						return "mad_queens_mandate main 26";
					end
				end
				if (v19.FearbreakersEcho:IsEquippedAndReady() and (not v43 or v5:BuffDown(v18.SiphonStormBuff))) then
					if v11(v19.FearbreakersEcho) then
						return "fearbreakers_echo main 28";
					end
				end
				if (v19.MereldarsToll:IsEquippedAndReady() and (not v43 or v5:BuffDown(v18.SiphonStormBuff))) then
					if v11(v19.MereldarsToll) then
						return "mereldars_toll main 30";
					end
				end
				if (v19.KahetiShadowweaversEmblem:IsEquippedAndReady() and (v5:BuffStack(v18.KahetiShadowweaversEmblemBuff) >= (1 + 4))) then
					if v11(v19.KahetiShadowweaversEmblem) then
						return "Kaheti_Shadowweavers_Emblem items";
					end
				end
			end
		end
		if ((v6:DebuffUp(v18.TouchoftheMagiDebuff) or (v18.TouchoftheMagi:CooldownRemains() > (v41 * (1640 - (1373 + 263)))) or not v18.TouchoftheMagi:IsAvailable() or not v13()) and v29) then
			v29 = false;
		end
		local v58 = v47();
		if v58 then
			return v58;
		end
		if (v18.SpellfireSpheres:IsAvailable() and v30) then
			local v60 = v50();
			if v60 then
				return v60;
			end
		end
		if ((v32 >= (v28 + v15(v18.Impetus:IsAvailable()))) and not v18.SpellfireSpheres:IsAvailable()) then
			local v61 = v48();
			if v61 then
				return v61;
			end
		end
		if v18.SpellfireSpheres:IsAvailable() then
			local v62 = v51();
			if v62 then
				return v62;
			end
		end
		if not v18.SpellfireSpheres:IsAvailable() then
			local v63 = v49();
			if v63 then
				return v63;
			end
		end
		if v18.ArcaneBarrage:IsReady() then
			if v11(v18.ArcaneBarrage) then
				return "arcane_barrage main 32";
			end
		end
	end
end
local function v53()
	v9.Print("Arcane Mage rotation has been updated for patch 11.0.2.");
	v27.Arcane.Display();
	v9:UpdateMacro("macro2", "/use 16");
	v9:UpdateMacro("macro6", "/stopcasting");
end
v9.SetAPL(1062 - (451 + 549), v52, v53);
