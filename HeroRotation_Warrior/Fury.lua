local v0, v1 = ...;
local v2 = HeroDBC.DBC;
local v3 = HeroLib;
local v4 = HeroCache;
local v5 = v3.Unit;
local v6 = v5.Player;
local v7 = v5.Target;
local v8 = v3.Spell;
local v9 = v3.Item;
local v10 = HeroRotation();
local v11 = v10.Cast;
local v12 = v10.AoEON;
local v13 = v10.CDsON;
local v14 = v10.Commons().Everyone.num;
local v15 = v10.Commons().Everyone.bool;
local v16 = C_Timer.After;
local v17;
local v18 = v8.Warrior.Fury;
local v19 = v9.Warrior.Fury;
local v20 = {v19.Fyralath:ID(),v19.TreacherousTransmitter:ID()};
local v21 = v10.Commons().Everyone;
local v22 = v10.GUISettingsGet();
local v23 = {General=v22.General,Commons=v22.APL.Warrior.Commons,Fury=v22.APL.Warrior.Fury,Fury_Defensives=v22.APL.Warrior.Fury.Defensives,Fury_TTD=v22.APL.Warrior.Fury_TTD,Fury_CDUSE=v22.APL.Warrior.Fury_CDUSE,Interrupt=v22.APL.Warrior.Fury_Interrupt.Interrupt};
local v24, v25;
local v26, v27;
local v28, v29;
local v30, v31;
local v32, v33;
local v34, v35;
local v36, v37;
local v38, v39;
local v40, v41;
local v42, v43;
local v44;
local v45, v46;
local v47, v48;
local v49, v50;
local v51;
local v52;
local v53 = 21447 - 10336;
local v54 = 28620 - 17509;
local v55 = 619 - (555 + 64);
local function v56()
	local v72, v73 = v6:GetTrinketData(v20);
	if ((v55 < (936 - (857 + 74))) and ((v72.ID == (568 - (367 + 201))) or (v73.ID == (927 - (214 + 713))) or ((v72.SpellID > (0 + 0)) and not v72.Usable) or ((v73.SpellID > (0 + 0)) and not v73.Usable))) then
		v55 = v55 + (878 - (282 + 595));
		v16(1642 - (1523 + 114), function()
			v56();
		end);
		return;
	end
	v24 = v72.Object;
	v25 = v73.Object;
	v26 = v72.Spell;
	v28 = v72.Range;
	v30 = v72.CastTime;
	v27 = v73.Spell;
	v29 = v73.Range;
	v31 = v73.CastTime;
	v32 = v72.Cooldown;
	v33 = v73.Cooldown;
	v34 = v72.Excluded;
	v35 = v73.Excluded;
	v36 = v72.ID == v19.TreacherousTransmitter:ID();
	v37 = v73.ID == v19.TreacherousTransmitter:ID();
	v38 = 0.5 + 0;
	if (v24:HasUseBuff() and (((v32 % (128 - 38)) == (1065 - (68 + 997))) or v32)) then
		v38 = 1271 - (226 + 1044);
	end
	v39 = 0.5 - 0;
	if (v25:HasUseBuff() and ((v33 % (207 - (32 + 85))) == (0 + 0))) then
		v39 = 1 + 0;
	end
	v40 = v24:HasUseBuff() or (v24:HasStatAnyDps() and not v36);
	v41 = v25:HasUseBuff() or (v25:HasStatAnyDps() and not v37);
	local v86 = ((v24:BuffDuration() > (957 - (892 + 65))) and v24:BuffDuration()) or (2 - 1);
	local v87 = ((v25:BuffDuration() > (0 - 0)) and v25:BuffDuration()) or (1 - 0);
	v44 = 351 - (87 + 263);
	if ((not v40 and v41) or (v41 and (((v33 / v87) * v39) > ((v32 / v86) * v38)))) then
		v44 = 182 - (67 + 113);
	end
	v42 = v72.ID == v19.AlgetharPuzzleBox:ID();
	v43 = v73.ID == v19.AlgetharPuzzleBox:ID();
end
v56();
local v57 = {{v18.StormBolt,"Cast Storm Bolt (Interrupt)",function()
	return true;
end}};
v3:RegisterForEvent(function()
	v53 = 12063 - (802 + 150);
	v54 = 29914 - 18803;
end, "PLAYER_REGEN_ENABLED");
v3:RegisterForEvent(function()
	v55 = 0 - 0;
	v56();
end, "PLAYER_EQUIPMENT_CHANGED", "SPELLS_CHANGED", "LEARNED_SPELL_IN_TAB");
local function v58()
	return v19.ManicGrieftorch:IsEquipped() and (v19.ManicGrieftorch:CooldownUp() or (v19.ManicGrieftorch:CooldownRemains() <= v6:GCDRemains()));
end
local function v59()
	return v19.AlgetharPuzzleBox:IsEquipped() and (v19.AlgetharPuzzleBox:CooldownUp() or (v19.AlgetharPuzzleBox:CooldownRemains() <= v6:GCDRemains()));
end
local v60;
local function v61(v88)
	return (v88 ~= "Not Used") and ((((v88 == "with Cooldowns") or ((v88 == "small CDs") and v23.Fury_CDUSE.smallcdswithCooldowns) or (v88 == "with Cooldowns or AoE") or (v88 == "on Enemycount or Cooldowns") or (v88 == "on Boss or with Cooldowns")) and v13()) or (v88 == "always") or (((v88 == "on Boss only") or (v88 == "on Boss or on Enemycount") or (v88 == "on Boss or with Cooldowns")) and (v60 or v7:IsDummy())) or ((v88 == "with Bloodlust only") and v6:BloodlustUp()) or ((v88 == "small CDs") and nb) or (((v88 == "on AOE") or (v88 == "with Cooldowns or AoE")) and (v50 >= (2 + 0))) or (((v88 == "on Enemycount or Cooldowns") or (v88 == "on Enemycount") or (v88 == "on Boss or on Enemycount")) and (v50 >= v23.Fury_CDUSE.Enemycount)));
end
local function v62(v89)
	return (v60 and v23.Fury_TTD.IgnoreWhenBoss) or v21.Buggedmobs[v7:NPCID()] or (v21.ISSolo() and v23.Fury_TTD.IgnoreWhenSolo) or (v89 == (997 - (915 + 82))) or ((v54 >= v89) and (v54 < (22021 - 14244)));
end
local function v63(v90)
	return v90:NPCID() == (119166 + 85394);
end
local function v64()
	if (v18.VictoryRush:IsCastable() and v51 and v6:CanAttack(v7) and v6:BuffUp(v18.VictoriousBuff) and (v6:HealthPercentage() <= v23.Fury.Defensives.VictoryRushHP)) then
		if v11(v18.VictoryRush) then
			return "VictoryRush";
		end
	end
	if (v18.ImpendingVictory:IsCastable() and v51 and v6:CanAttack(v7) and (v6:HealthPercentage() <= v23.Fury.Defensives.ImpendingVictoryHP)) then
		if v11(v18.ImpendingVictory) then
			return "ImpendingVictory";
		end
	end
	if (v18.BitterImmunity:IsCastable() and v6:AffectingCombat() and (v6:HealthPercentage() <= v23.Fury.Defensives.BitterImmunityHP)) then
		if v11(v18.BitterImmunity) then
			return "BitterImmunity";
		end
	end
	if (v18.EnragedRegeneration:IsCastable() and v6:AffectingCombat() and (v6:HealthPercentage() <= v23.Fury.Defensives.EnragedRegenerationHP)) then
		if v11(v18.EnragedRegeneration) then
			return "EnragedRegeneration";
		end
	end
	if (AutoStance and v6:AffectingCombat()) then
		if (v18.DefensiveStance:IsCastable() and v6:BuffUp(v18.BerserkerStance) and (v6:HealthPercentage() <= v23.Fury_Defensives.DefStanceHP)) then
			if v11(v18.DefensiveStance) then
				return "BearForm";
			end
		end
		if (v18.BerserkerStance:IsCastable() and v6:BuffUp(v18.DefensiveStance) and (v6:HealthPercentage() > v23.Fury_Defensives.BerserkerStanceHP) and (v23.Fury_Defensives.BerserkerStanceHP > (0 - 0))) then
			if v11(v18.BerserkerStance) then
				return "MoonkinForm";
			end
		end
	end
end
local function v65()
	if (v18.Recklessness:IsCastable() and IsRecklessness and v51) then
		if v11(v18.Recklessness, true) then
			return "recklessness precombat 8";
		end
	end
	if (v18.Avatar:IsCastable() and IsAvatar and v51) then
		if v11(v18.Avatar, true) then
			return "avatar precombat 10";
		end
	end
	if (v18.Bloodthirst:IsCastable() and v51) then
		if v11(v18.Bloodthirst) then
			return "bloodthirst precombat 12";
		end
	end
end
local function v66()
	if (v18.StormBolt:IsReady() and v7:IsInRange(1207 - (1069 + 118)) and (v6:BuffUp(v18.Bladestorm))) then
		if v11(v18.StormBolt) then
			return "storm_bolt slayer 1";
		end
	end
	if (IsRecklessness and v51 and v18.Recklessness:IsCastable()) then
		if v11(v18.Recklessness, true) then
			return "recklessness slayer 2";
		end
	end
	if (IsRecklessness and v51 and v18.Avatar:IsCastable() and (v18.Recklessness:CooldownDown())) then
		if v11(v18.Avatar, true) then
			return "avatar slayer 4";
		end
	end
	if (v18.Execute:IsReady() and v51 and v6:BuffUp(v18.AshenJuggernautBuff) and (v6:BuffRemains(v18.AshenJuggernautBuff) <= v6:GCD())) then
		if v11(v18.Executecast) then
			return "execute slayer 6";
		end
	end
	if (v51 and IsChampionsSpear and v18.ChampionsSpear:IsCastable() and v52 and ((v18.Bladestorm:CooldownRemains() >= (4 - 2)) or ((v18.Bladestorm:CooldownRemains() >= (34 - 18)) and (v7:DebuffStack(v18.MarkedforExecutionDebuff) == (1 + 2))))) then
		if CastTarget(v18.ChampionsSpear, v10.TName().PLAYER) then
			return "champions_spear slayer 8";
		end
	end
	if (v18.Bladestorm:IsCastable() and v51 and IsRavager and v52 and ((v18.RecklessAbandon:IsAvailable() and (v18.Avatar:CooldownRemains() >= (42 - 18))) or (v18.AngerManagement:IsAvailable() and (v18.Recklessness:CooldownRemains() >= (24 + 0))))) then
		if v11(v18.Bladestormcast, true) then
			return "bladestorm slayer 10";
		end
	end
	if (v7:IsInMeleeRange(803 - (368 + 423)) and IsOdynsFury and v18.OdynsFury:IsCastable() and (v52 or v18.TitanicRage:IsAvailable()) and v18.Avatar:CooldownDown()) then
		if v11(v18.OdynsFury) then
			return "odyns_fury slayer 12";
		end
	end
	if (v18.Whirlwind:IsCastable() and v7:IsInMeleeRange(25 - 17) and (v50 >= (20 - (10 + 8))) and v18.MeatCleaver:IsAvailable() and v6:BuffDown(v18.MeatCleaverBuff)) then
		if v11(v18.Whirlwind) then
			return "whirlwind slayer 14";
		end
	end
	if (v18.Execute:IsReady() and v51 and (v6:BuffStack(v18.SuddenDeathBuff) == (7 - 5)) and (v6:BuffRemains(v18.SuddenDeathBuff) < (449 - (416 + 26)))) then
		if v11(v18.Executecast) then
			return "execute slayer 16";
		end
	end
	if (v18.Execute:IsReady() and v51 and v6:BuffUp(v18.SuddenDeathBuff) and (v6:BuffRemains(v18.SuddenDeathBuff) < (6 - 4))) then
		if v11(v18.Executecast) then
			return "execute slayer 18";
		end
	end
	if (v18.Execute:IsReady() and v51 and v6:BuffUp(v18.SuddenDeathBuff) and (v6:BuffStack(v18.ImminentDemiseBuff) < (2 + 1)) and (v18.Bladestorm:CooldownRemains() < (43 - 18))) then
		if v11(v18.Executecast) then
			return "execute slayer 20";
		end
	end
	if (v18.Onslaught:IsReady() and v51 and (v18.Tenderize:IsAvailable())) then
		if v11(v18.Onslaught) then
			return "onslaught slayer 22";
		end
	end
	if (v18.Rampage:IsReady() and v51 and (not v52 or (v6:BuffStack(v18.SlaughteringStrikesBuff) >= (442 - (145 + 293))))) then
		if v11(v18.Rampage) then
			return "rampage slayer 24";
		end
	end
	if (v18.CrushingBlow:IsCastable() and v51 and ((v18.RagingBlow:Charges() == (432 - (44 + 386))) or (v6:BuffUp(v18.BrutalFinishBuff) and (v7:DebuffDown(v18.ChampionsMightDebuff) or (v7:DebuffRemains(v18.ChampionsMightDebuff) > v6:GCD()))))) then
		if v11(v18.CrushingBlow) then
			return "crushing_blow slayer 26";
		end
	end
	if (v7:IsInMeleeRange(1498 - (998 + 488)) and IsThunderousRoar and v18.ThunderousRoar:IsCastable() and v52 and v6:BuffDown(v18.BrutalFinishBuff)) then
		if v11(v18.ThunderousRoar, true) then
			return "thunderous_roar slayer 28";
		end
	end
	if (v18.Execute:IsReady() and v51 and (v7:DebuffStack(v18.MarkedforExecutionDebuff) == (1 + 2))) then
		if v11(v18.Executecast) then
			return "execute slayer 30";
		end
	end
	if (v18.Bloodbath:IsCastable() and v51 and ((v6:BuffStack(v18.BloodcrazeBuff) >= (1 + 0)) or (v18.Uproar:IsAvailable() and (v7:DebuffRemains(v18.BloodbathDebuff) < (812 - (201 + 571))) and v18.Bloodborne:IsAvailable()) or (v52 and (v6:BuffRemains(v18.EnrageBuff) < v6:GCD())))) then
		if v11(v18.Bloodbath) then
			return "bloodbath slayer_ra_st 32";
		end
	end
	if (v18.RagingBlow:IsCastable() and v51 and v6:BuffUp(v18.BrutalFinishBuff) and (v6:BuffStack(v18.SlaughteringStrikesBuff) < (1143 - (116 + 1022))) and (v7:DebuffDown(v18.ChampionsMightDebuff) or (v7:DebuffRemains(v18.ChampionsMightDebuff) > v6:GCD()))) then
		if v11(v18.RagingBlow) then
			return "raging_blow slayer 34";
		end
	end
	if (v18.Rampage:IsReady() and v51 and (v18.RagingBlow:Charges() <= (4 - 3)) and (v6:Rage() >= (59 + 41)) and v18.AngerManagement:IsAvailable() and v6:BuffDown(v18.RecklessnessBuff)) then
		if v11(v18.Rampage) then
			return "rampage slayer 36";
		end
	end
	if (v18.Rampage:IsReady() and v51 and ((v6:Rage() >= (438 - 318)) or (v18.RecklessAbandon:IsAvailable() and v6:BuffUp(v18.RecklessnessBuff) and (v6:BuffStack(v18.SlaughteringStrikesBuff) >= (10 - 7))))) then
		if v11(v18.Rampage) then
			return "rampage slayer 38";
		end
	end
	local v91 = v6:CritChancePct() + (v14(v6:BuffUp(v18.RecklessnessBuff)) * (879 - (814 + 45))) + (v6:BuffStack(v18.BloodcrazeBuff) * (36 - 21));
	if (v18.Bloodbath:IsCastable() and v51 and ((v6:BuffStack(v18.BloodcrazeBuff) >= (1 + 3)) or (v91 >= (31 + 54)))) then
		if v11(v18.Bloodbath) then
			return "bloodbath slayer 40";
		end
	end
	if (v18.CrushingBlow:IsCastable() and v51) then
		if v11(v18.CrushingBlow) then
			return "crushing_blow slayer 42";
		end
	end
	if (v18.Bloodbath:IsCastable() and v51) then
		if v11(v18.Bloodbath) then
			return "bloodbath slayer 44";
		end
	end
	if (v18.RagingBlow:IsCastable() and v51 and (v6:BuffUp(v18.OpportunistBuff))) then
		if v11(v18.RagingBlow) then
			return "raging_blow slayer 46";
		end
	end
	if (v18.Bloodthirst:IsCastable() and v51 and (v7:HealthPercentage() < (920 - (261 + 624))) and v18.ViciousContempt:IsAvailable() and (v6:BuffStack(v18.BloodcrazeBuff) >= (3 - 1))) then
		if v11(v18.Bloodthirst) then
			return "bloodthirst slayer 48";
		end
	end
	if (v18.Rampage:IsReady() and v51 and (((v6:Rage() >= (1180 - (1020 + 60))) and v18.AngerManagement:IsAvailable()) or v6:BuffUp(v18.RecklessnessBuff))) then
		if v11(v18.Rampage) then
			return "rampage slayer 50";
		end
	end
	if (v18.Bloodthirst:IsCastable() and v51 and ((v6:BuffStack(v18.BloodcrazeBuff) >= (1427 - (630 + 793))) or (v91 >= (287 - 202)))) then
		if v11(v18.Bloodthirst) then
			return "bloodthirst slayer 52";
		end
	end
	if (v18.RagingBlow:IsCastable() and v51) then
		if v11(v18.RagingBlow) then
			return "raging_blow slayer 54";
		end
	end
	if (v18.Bloodthirst:IsCastable() and v51) then
		if v11(v18.Bloodthirst) then
			return "bloodthirst slayer 56";
		end
	end
	if (v18.Rampage:IsReady() and v51) then
		if v11(v18.Rampage) then
			return "rampage slayer 58";
		end
	end
	if (v18.Execute:IsReady() and v51) then
		if v11(v18.Executecast) then
			return "execute slayer 60";
		end
	end
	if (v18.Whirlwind:IsCastable() and v7:IsInMeleeRange(37 - 29) and (v18.ImprovedWhilwind:IsAvailable())) then
		if v11(v18.Whirlwind) then
			return "whirlwind slayer 62";
		end
	end
	if (v18.Slam:IsCastable() and v51 and not v18.ImprovedWhilwind:IsAvailable()) then
		if v11(v18.Slam) then
			return "slam slayer 64";
		end
	end
end
local function v67()
	if (IsRecklessness and v51 and v18.Recklessness:IsCastable()) then
		if v11(v18.Recklessness, true) then
			return "recklessness thane 2";
		end
	end
	if (IsRecklessness and v51 and v18.Avatar:IsCastable()) then
		if v11(v18.Avatar, true) then
			return "avatar thane 4";
		end
	end
	if (IsRavager and v51 and v18.Ravager:IsCastable()) then
		if v10.CastTarget(v18.Ravager, v10.TName().PLAYER) then
			return "ravager thane 6";
		end
	end
	if (v18.ThunderBlastAbility:IsReady() and v7:IsInMeleeRange(4 + 4) and v52 and v18.MeatCleaver:IsAvailable()) then
		if v11(v18.ThunderBlastAbility) then
			return "thunder_blast thane 8";
		end
	end
	if (v18.ThunderClap:IsCastable() and v7:IsInMeleeRange(27 - 19) and v6:BuffUp(v18.MeatCleaverBuff) and v18.MeatCleaver:IsAvailable() and (v50 >= (1749 - (760 + 987)))) then
		if v11(v18.ThunderClap) then
			return "thunder_clap thane 10";
		end
	end
	if (v7:IsInMeleeRange(1925 - (1789 + 124)) and IsThunderousRoar and v18.ThunderousRoar:IsCastable() and v52) then
		if v11(v18.ThunderousRoar, true) then
			return "thunderous_roar thane 12";
		end
	end
	if (v51 and IsChampionsSpear and v18.ChampionsSpear:IsCastable() and v52) then
		if v10.CastTarget(v18.ChampionsSpear, v10.TName().PLAYER) then
			return "champions_spear thane 14";
		end
	end
	if (v7:IsInMeleeRange(778 - (745 + 21)) and IsOdynsFury and v18.OdynsFury:IsCastable() and (v52 or v18.TitanicRage:IsAvailable()) and v18.Avatar:CooldownDown()) then
		if v11(v18.OdynsFury) then
			return "odyns_fury thane 16";
		end
	end
	if (v18.Rampage:IsReady() and v51 and not v52) then
		if v11(v18.Rampage) then
			return "rampage thane 18";
		end
	end
	if (v18.Execute:IsReady() and v51 and v18.AshenJuggernaut:IsAvailable() and (v6:BuffRemains(v18.AshenJuggernautBuff) <= v6:GCD())) then
		if v11(v18.Executecast) then
			return "execute thane 20";
		end
	end
	if (v18.Rampage:IsReady() and v51 and v18.Bladestorm:IsLearned() and (v18.Bladestorm:CooldownRemains() <= v6:GCD()) and v7:DebuffDown(v18.ChampionsMightDebuff)) then
		if v11(v18.Rampage) then
			return "rampage thane 22";
		end
	end
	if (v18.Bladestorm:IsCastable() and v51 and IsRavager and v52 and v18.Unhinged:IsAvailable()) then
		if v11(v18.Bladestormcast, true) then
			return "bladestorm thane 24";
		end
	end
	if (v18.Bloodbath:IsCastable() and v51 and (v6:BuffStack(v18.BloodcrazeBuff) >= (1 + 1))) then
		if v11(v18.Bloodbath) then
			return "bloodbath thane 26";
		end
	end
	if (v18.Rampage:IsReady() and v51 and (v6:Rage() >= (316 - 201)) and v18.RecklessAbandon:IsAvailable() and v6:BuffUp(v18.RecklessnessBuff) and (v6:BuffStack(v18.SlaughteringStrikesBuff) >= (11 - 8))) then
		if v11(v18.Rampage) then
			return "rampage thane 28";
		end
	end
	if (v18.CrushingBlow:IsCastable() and v51) then
		if v11(v18.CrushingBlow) then
			return "crushing_blow thane 30";
		end
	end
	if (v18.Bloodbath:IsCastable() and v51) then
		if v11(v18.Bloodbath) then
			return "bloodbath thane 32";
		end
	end
	if (v18.Onslaught:IsReady() and v51 and (v18.Tenderize:IsAvailable())) then
		if v11(v18.Onslaught) then
			return "onslaught thane 34";
		end
	end
	if (v18.Rampage:IsReady() and v51) then
		if v11(v18.Rampage) then
			return "rampage thane 36";
		end
	end
	if (v18.Bloodthirst:IsCastable() and v51 and ((v18.ViciousContempt:IsAvailable() and (v7:HealthPercentage() < (1 + 34)) and (v6:BuffStack(v18.BloodcrazeBuff) >= (2 + 0))) or (v7:DebuffDown(v18.RavagerDebuff) and (v6:BuffStack(v18.BloodcrazeBuff) >= (1058 - (87 + 968)))) or (v50 >= (26 - 20)))) then
		if v11(v18.Bloodthirst) then
			return "bloodthirst thane 38";
		end
	end
	if (v18.RagingBlow:IsCastable() and v51) then
		if v11(v18.RagingBlow) then
			return "raging_blow thane 40";
		end
	end
	if (v18.Execute:IsReady() and v51 and (v18.AshenJuggernaut:IsAvailable())) then
		if v11(v18.Executecast) then
			return "execute thane 42";
		end
	end
	if (v18.ThunderBlastAbility:IsReady() and v7:IsInMeleeRange(8 + 0)) then
		if v11(v18.ThunderBlastAbility) then
			return "thunder_blast thane 44";
		end
	end
	if (v18.Bloodthirst:IsCastable() and v51) then
		if v11(v18.Bloodthirst) then
			return "bloodthirst thane 46";
		end
	end
	if (v18.Execute:IsReady() and v51) then
		if v11(v18.Executecast) then
			return "execute thane 48";
		end
	end
	if (v18.ThunderClap:IsCastable() and v7:IsInMeleeRange(17 - 9)) then
		if v11(v18.ThunderClap) then
			return "thunder_clap thane 50";
		end
	end
end
local function v68()
	if (v23.Commons.Enabled.Items and v19.Fyralath:IsEquippedAndReady() and v51 and IsWeapon and (v18.MarkofFyralathDebuff:AuraActiveCount() > (1413 - (447 + 966)))) then
		v10.CastMacro(2 - 1, nil, nil, v19.Fyralath);
		return "weapon cast";
	end
	if v23.Commons.Enabled.Trinkets then
		if (v19.TreacherousTransmitter:IsEquippedAndReady() and (((v24:ID() == v19.TreacherousTransmitter:ID()) and IsTrinket1) or ((v25:ID() == v19.TreacherousTransmitter:ID()) and IsTrinket2)) and (v46 or v45)) then
			if v11(v19.TreacherousTransmitter, true) then
				return "treacherous_transmitter trinkets 2";
			end
		end
		if (v24:IsReady() and v51 and IsTrinket1 and not v34 and ((v40 and not v42 and ((v6:BuffDown(v18.AvatarBuff) and (v30 > (1817 - (1703 + 114)))) or (v30 == (701 - (376 + 325)))) and ((v18.TitansTorment:IsAvailable() and v18.Avatar:CooldownUp()) or (v6:BuffUp(v18.AvatarBuff) and not v18.TitansTorment:IsAvailable())) and (v37 or not v25:HasCooldown() or v25:CooldownDown() or (v44 == (1 - 0)))) or (v24:BuffDuration() >= v53))) then
			if v11(v24, true) then
				return "use_item for " .. v24:Name() .. " trinkets 4";
			end
		end
		if (v25:IsReady() and v51 and IsTrinket2 and not v35 and ((v41 and not v43 and ((v6:BuffDown(v18.AvatarBuff) and (v31 > (0 - 0))) or (v31 == (0 + 0))) and ((v18.TitansTorment:IsAvailable() and v18.Avatar:CooldownUp()) or (v6:BuffUp(v18.AvatarBuff) and not v18.TitansTorment:IsAvailable())) and (v36 or not v24:HasCooldown() or v24:CooldownDown() or (v44 == (4 - 2)))) or (v25:BuffDuration() >= v53))) then
			if v11(v25, true) then
				return "use_item for " .. v25:Name() .. " trinkets 6";
			end
		end
		if (v24:IsReady() and v51 and IsTrinket1 and not v34 and not v40 and (((v30 > (14 - (9 + 5))) and v6:BuffDown(v18.AvatarBuff)) or (v30 == (376 - (85 + 291)))) and not v42 and ((not v40 and (v25:CooldownDown() or not v41)) or ((v30 > (1265 - (243 + 1022))) and v6:BuffDown(v18.AvatarBuff)) or (v30 == (0 - 0)) or (v18.Avatar:CooldownRemains() > (17 + 3)))) then
			if v11(v24, true) then
				return "use_item for " .. v24:Name() .. " trinkets 8";
			end
		end
		if (v25:IsReady() and v51 and IsTrinket2 and not v35 and not v41 and (((v31 > (1180 - (1123 + 57))) and v6:BuffDown(v18.AvatarBuff)) or (v31 == (0 + 0))) and not v43 and ((not v41 and (v24:CooldownDown() or not v40)) or ((v31 > (254 - (163 + 91))) and v6:BuffDown(v18.AvatarBuff)) or (v31 == (1930 - (1869 + 61))) or (v18.Avatar:CooldownRemains() > (6 + 14)))) then
			if v11(v25, true) then
				return "use_item for " .. v25:Name() .. " trinkets 10";
			end
		end
	end
	if v23.Commons.Enabled.Items then
		local v96, v97, v98 = v6:GetUseableItems(v20, 56 - 40);
		if (v96 and v96:IsReady() and IsWeapon and v7:IsInRange(v98) and not v19.Fyralath:IsEquipped() and (not v40 or v32) and (not v41 or v33)) then
			v10.CastMacro(1 - 0, nil, nil, v96);
			return "weapon cast";
		end
	end
end
local function v69()
	v45 = v50 == (1 + 0);
	v46 = v50 >= (2 - 0);
	v47 = (v18.Massacre:IsAvailable() and (v7:HealthPercentage() < (33 + 2))) or (v7:HealthPercentage() < (1494 - (1329 + 145)));
	v48 = v6:BuffDown(v18.RecklessnessBuff) and v6:BuffDown(v18.AvatarBuff) and (v6:Rage() < (1051 - (140 + 831))) and v6:BuffDown(v18.SuddenDeathBuff) and v18.Bladestorm:CooldownDown() and (v18.Execute:CooldownDown() or not v47);
end
local function v70()
	v21.HealthPotions();
	v49 = v6:GetEnemiesInMeleeRange(1858 - (1409 + 441));
	if v12() then
		v50 = #v49;
	else
		v50 = 719 - (15 + 703);
	end
	Smallcds = v10.ToggleIconFrame:GetToggle(1 + 0);
	AutoStance = v10.ToggleIconFrame:GetToggle(440 - (262 + 176));
	InterruptToggle = v10.ToggleIconFrame:GetToggle(1724 - (345 + 1376));
	Lowlevel = not v18.SlayersDominance:IsAvailable() and not v18.LightningStrikes:IsAvailable();
	IsAvatar = v62(v23.Fury_TTD.AvatarTTD) and v61(v23.Fury_CDUSE.Avatar);
	IsRacials = v62(v23.Fury_TTD.RacialsTTD) and v61(v23.Fury_CDUSE.Racials);
	IsPotions = v62(v23.Fury_TTD.PotionsTTD) and (v23.Fury_CDUSE.Potionswhensolo or (not v23.Fury_CDUSE.Potionswhensolo and not v21.ISSolo())) and v61(v23.Fury_CDUSE.Potions);
	IsTrinket1 = v62(v23.Fury_TTD.TrinketsTTD) and v61(v23.Fury_CDUSE.Trinket1);
	IsTrinket2 = v62(v23.Fury_TTD.TrinketsTTD) and v61(v23.Fury_CDUSE.Trinket2);
	IsRecklessness = v62(v23.Fury_TTD.RecklessnessTTD) and v61(v23.Fury_CDUSE.Recklessness);
	IsRavager = v62(v23.Fury_TTD.RavagerTTD) and v61(v23.Fury_CDUSE.Ravager);
	IsThunderousRoar = v62(v23.Fury_TTD.ThunderousRoarTTD) and v61(v23.Fury_CDUSE.ThunderousRoar);
	IsChampionsSpear = v62(v23.Fury_TTD.ChampionsSpearTTD) and v61(v23.Fury_CDUSE.ChampionsSpear);
	IsOdynsFury = v62(v23.Fury_TTD.OdynsFuryTTD) and v61(v23.Fury_CDUSE.OdynsFury);
	IsWeapon = v62(v23.Fury_TTD.WeaponTTD) and v61(v23.Fury_CDUSE.Weapon);
	local v92 = 688 - (198 + 490);
	if v18.RumblingEarth:IsAvailable() then
		v92 = 70 - 54;
	else
		v92 = 23 - 13;
	end
	v52 = v6:BuffUp(v18.EnrageBuff);
	v51 = v7:IsInRange(1211 - (696 + 510));
	if (v21.TargetIsValid() or v6:AffectingCombat()) then
		v53 = v3.BossFightRemains();
		v60 = true;
		v54 = v53;
		if (v54 == (23302 - 12191)) then
			v60 = false;
			v54 = v3.FightRemains(v49, false);
		end
	end
	if (v18.BattleShout:IsCastable() and not v6:DebuffUp(v18.Corruption) and ((v21.GroupBuffMissing(v18.BattleShoutBuff, true) and (v23.Commons.BattleShout == "check whole group") and (v6:IsInRaidArea() or v6:IsInDungeonArea())) or (v6:BuffDown(v18.BattleShoutBuff, true) and ((v23.Commons.BattleShout == "only check us") or (v23.Commons.BattleShout == "check whole group")))) and not v6:IsMounted()) then
		if v10.Cast(v18.BattleShout) then
			return "BattleShout";
		end
	end
	if v23.Commons.CCIncorperal then
		v17 = v21.IncorpCycle(v18.IntimidatingShout, 1270 - (1091 + 171), false, false);
		v17 = v21.IncorpCycle(v18.StormBolt, 4 + 16, false, false);
		if v17 then
			return v17;
		end
	end
	local v93 = v6:IncomingSpell(Warrior.SpellReflectList);
	local v94 = v6:IncomingSpellreflection(Warrior.SpellReflectList);
	if (v94 and v10.DebugON()) then
		print("Spell Reflect Cast: " .. v94);
	end
	local v95 = v6:BuffUp(v18.SpellReflection) or (v93 and v18.SpellReflection:IsReady() and v23.Commons.AutoSpellreflection);
	if (v18.SpellReflection:IsReady() and v94 and v23.Commons.AutoSpellreflection) then
		if v11(v18.SpellReflection, true) then
			return "Spell Reflection";
		end
	end
	if (v18.BerserkerStance:IsCastable() and AutoStance and v6:BuffDown(v18.BerserkerStance, true) and (v6:HealthPercentage() > v23.Fury_Defensives.BerserkerStanceHP)) then
		if v11(v18.BerserkerStance) then
			return "berserker_stance precombat 4";
		end
	end
	v17 = v64();
	if v17 then
		return v17;
	end
	if v21.TargetIsValid() then
		if (not v23.Fury.AttackonlyinCombat or (v23.Fury.AttackonlyinCombat and v7:AffectingCombat())) then
			if not v63(v5.Target) then
				if not v6:AffectingCombat() then
					v17 = v65();
					if v17 then
						return v17;
					end
				end
				if (InterruptToggle and not v95) then
					v17 = v21.InterruptCycle(v18.Pummel, 15 - 10, true, nil, false);
					if v17 then
						return v17;
					end
					v17 = v23.Interrupt.UseStormbolt and v21.InterruptCycle(v18.StormBolt, 66 - 46, false, nil, true);
					if v17 then
						return v17;
					end
					v17 = v23.Interrupt.UseShockwave and v21.InterruptCycle(v18.Shockwave, v92, false, nil, true, true);
					if v17 then
						return v17;
					end
				end
				if (IsPotions and v23.Commons.Enabled.Potions and v51) then
					local v99 = v21.PotionSelected();
					if (v99 and v99:IsReady()) then
						v10.CastMacro(377 - (123 + 251), nil, nil, v99);
						return "Cast Potion";
					end
				end
				if (v23.Commons.Enabled.Trinkets or v23.Commons.Enabled.Items) then
					local v100 = v68();
					if v100 then
						return v100;
					end
				end
				v69();
				if (v18.LightsJudgment:IsCastable() and v7:IsSpellInRange(v18.LightsJudgment) and IsRacials and v48) then
					if v11(v18.LightsJudgment, true) then
						return "lights_judgment main 16";
					end
				end
				if (v18.Berserking:IsCastable() and v51 and IsRacials and v48) then
					if v11(v18.Berserking, true) then
						return "berserking main 18";
					end
				end
				if (v18.BloodFury:IsCastable() and v51 and IsRacials) then
					if v11(v18.BloodFury, true) then
						return "blood_fury main 20";
					end
				end
				if (v18.Fireblood:IsCastable() and v51 and IsRacials) then
					if v11(v18.Fireblood, true) then
						return "fireblood main 22";
					end
				end
				if (v18.AncestralCall:IsCastable() and v51 and IsRacials) then
					if v11(v18.AncestralCall, true) then
						return "ancestral_call main 24";
					end
				end
				if (v18.SlayersDominance:IsAvailable() or Lowlevel) then
					local v101 = v66();
					if v101 then
						return v101;
					end
					if v10.CastAnnotated(v18.Pool, false, "WAIT") then
						return "Pool for SlayerAMMT()";
					end
				end
				if v18.LightningStrikes:IsAvailable() then
					local v102 = v67();
					if v102 then
						return v102;
					end
					if v10.CastAnnotated(v18.Pool, false, "WAIT") then
						return "Pool for ThaneAMMT()";
					end
				end
				if v10.CastAnnotated(v18.Pool, false, "WAIT") then
					return "Wait/Pool Resources";
				end
			end
		end
	end
end
local function v71()
	v10.ResetToggle();
	v23.Fury.Display();
	v18.MarkofFyralathDebuff:RegisterAuraTracking();
	v10:UpdateMacro("macro1", "/use item:206448");
	v10.ToggleIconFrame:AddButtonCustom("S", 4 - 3, "smallCDs", "smallcds");
	v10.ToggleIconFrame:AddButtonCustom("A", 700 - (208 + 490), "Auto Stance", "autostance");
	v10.ToggleIconFrame:AddButtonCustom("I", 1 + 2, "Interrupt", "interrupt");
	v21.PostInitialMessage(32 + 39);
end
v10.SetAPL(908 - (660 + 176), v70, v71);
