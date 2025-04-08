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
	local v74, v75 = v6:GetTrinketData(v20);
	if ((v55 < (936 - (857 + 74))) and ((v74.ID == (568 - (367 + 201))) or (v75.ID == (927 - (214 + 713))) or ((v74.SpellID > (0 + 0)) and not v74.Usable) or ((v75.SpellID > (0 + 0)) and not v75.Usable))) then
		v55 = v55 + (878 - (282 + 595));
		v16(1642 - (1523 + 114), function()
			v56();
		end);
		return;
	end
	v24 = v74.Object;
	v25 = v75.Object;
	v26 = v74.Spell;
	v28 = v74.Range;
	v30 = v74.CastTime;
	v27 = v75.Spell;
	v29 = v75.Range;
	v31 = v75.CastTime;
	v32 = v74.Cooldown;
	v33 = v75.Cooldown;
	v34 = v74.Blacklisted;
	v35 = v75.Blacklisted;
	v36 = v74.ID == v19.TreacherousTransmitter:ID();
	v37 = v75.ID == v19.TreacherousTransmitter:ID();
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
	local v88 = ((v24:BuffDuration() > (957 - (892 + 65))) and v24:BuffDuration()) or (2 - 1);
	local v89 = ((v25:BuffDuration() > (0 - 0)) and v25:BuffDuration()) or (1 - 0);
	v44 = 351 - (87 + 263);
	if ((not v40 and v41) or (v41 and (((v33 / v89) * v39) > ((v32 / v88) * v38)))) then
		v44 = 182 - (67 + 113);
	end
	v42 = v74.ID == v19.AlgetharPuzzleBox:ID();
	v43 = v75.ID == v19.AlgetharPuzzleBox:ID();
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
local function v61(v90)
	return (v90 ~= "Not Used") and ((((v90 == "with Cooldowns") or ((v90 == "small CDs") and v23.Fury_CDUSE.smallcdswithCooldowns) or (v90 == "with Cooldowns or AoE") or (v90 == "on Enemycount or Cooldowns") or (v90 == "on Boss or with Cooldowns")) and v13()) or (v90 == "always") or (((v90 == "on Boss only") or (v90 == "on Boss or on Enemycount") or (v90 == "on Boss or with Cooldowns")) and (v60 or v7:IsDummy())) or ((v90 == "with Bloodlust only") and v6:BloodlustUp()) or ((v90 == "small CDs") and nb) or (((v90 == "on AOE") or (v90 == "with Cooldowns or AoE")) and (v50 >= (2 + 0))) or (((v90 == "on Enemycount or Cooldowns") or (v90 == "on Enemycount") or (v90 == "on Boss or on Enemycount")) and (v50 >= v23.Fury_CDUSE.Enemycount)));
end
local function v62(v91)
	return (v60 and v23.Fury_TTD.IgnoreWhenBoss) or v21.Buggedmobs[v7:NPCID()] or (v21.ISSolo() and v23.Fury_TTD.IgnoreWhenSolo) or (v91 == (997 - (915 + 82))) or ((v54 >= v91) and (v54 < (22021 - 14244)));
end
local function v63(v92)
	return v92:NPCID() == (119166 + 85394);
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
	if (v18.Recklessness:IsCastable() and IsRecklessness and v51 and not v19.Fyralath:IsEquipped()) then
		if v11(v18.Recklessness, true) then
			return "recklessness precombat 8";
		end
	end
	if (v18.Avatar:IsCastable() and IsAvatar and v51 and not v18.TitansTorment:IsAvailable()) then
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
	if (v18.Recklessness:IsCastable() and v51 and IsRecklessness and ((not v18.AngerManagement:IsAvailable() and (v18.Avatar:CooldownRemains() < (1188 - (1069 + 118))) and v18.TitansTorment:IsAvailable()) or v18.AngerManagement:IsAvailable() or not v18.TitansTorment:IsAvailable())) then
		if v11(v18.Recklessness, true) then
			return "recklessness slayer_st 2";
		end
	end
	if (v18.Avatar:IsCastable() and v51 and IsAvatar and ((v18.TitansTorment:IsAvailable() and (v52 or v18.TitanicRage:IsAvailable()) and (v7:DebuffUp(v18.ChampionsMightDebuff) or not v18.ChampionsMight:IsAvailable())) or not v18.TitansTorment:IsAvailable())) then
		if v11(v18.Avatar, true) then
			return "avatar slayer_st 4";
		end
	end
	if (v18.ThunderousRoar:IsCastable() and v7:IsInMeleeRange(26 - 14) and IsThunderousRoar and v52) then
		if v11(v18.ThunderousRoar, true) then
			return "thunderous_roar slayer_st 6";
		end
	end
	if (v18.ChampionsSpear:IsCastable() and v51 and IsChampionsSpear and ((v52 and v18.TitansTorment:IsAvailable() and (v18.Avatar:CooldownRemains() < v6:GCD())) or (v52 and not v18.TitansTorment:IsAvailable()))) then
		if v10.CastTarget(v18.ChampionsSpear, v10.TName().PLAYER) then
			return "champions_spear slayer_st 8";
		end
	end
	if (v18.OdynsFury:IsCastable() and v7:IsInMeleeRange(25 - 13) and IsOdynsFury and (v7:DebuffRemains(v18.OdynsFuryDebuff) < (1 + 0)) and (v52 or v18.TitanicRage:IsAvailable()) and (v18.Avatar:CooldownDown() or not IsAvatar)) then
		if v11(v18.OdynsFury) then
			return "odyns_fury slayer_st 10";
		end
	end
	if (v18.Execute:IsReady() and v51 and ((v7:DebuffStack(v18.MarkedforExecutionDebuff) == (4 - 1)) or (v18.AshenJuggernaut:IsAvailable() and (v6:BuffRemains(v18.AshenJuggernautBuff) <= v6:GCD()) and v52))) then
		if v11(v18.Executecast) then
			return "execute slayer_st 12";
		end
	end
	if (v18.Rampage:IsReady() and v51 and v18.Bladestorm:IsLearned() and (v18.Bladestorm:CooldownRemains() <= v6:GCD()) and v7:DebuffDown(v18.ChampionsMightDebuff)) then
		if v11(v18.Rampage) then
			return "rampage slayer_st 14";
		end
	end
	if (v18.Bladestorm:IsCastable() and v51 and IsRavager and v52 and ((v18.Avatar:CooldownRemains() >= (9 + 0)) or not IsAvatar)) then
		if v11(v18.Bladestormcast, true) then
			return "bladestorm slayer_st 16";
		end
	end
	if (v18.Ravager:IsCastable() and IsRavager and v51 and v52) then
		if v10.CastTarget(v18.Ravager, v10.TName().PLAYER) then
			return "ravager slayer_st 17";
		end
	end
	if (v18.Onslaught:IsReady() and v51 and v18.Tenderize:IsAvailable() and v6:BuffUp(v18.BrutalFinishBuff)) then
		if v11(v18.Onslaught) then
			return "onslaught slayer_st 18";
		end
	end
	if (v18.Rampage:IsReady() and v51 and (v18.AngerManagement:IsAvailable())) then
		if v11(v18.Rampage) then
			return "rampage slayer_st 20";
		end
	end
	if (v18.CrushingBlow:IsCastable() and v51) then
		if v11(v18.CrushingBlow) then
			return "crushing_blow slayer_st 22";
		end
	end
	if (v18.Onslaught:IsReady() and v51 and (v18.Tenderize:IsAvailable())) then
		if v11(v18.Onslaught) then
			return "onslaught slayer_st 24";
		end
	end
	if (v18.Bloodbath:IsCastable() and v51 and ((v6:Rage() < (891 - (368 + 423))) or ((v7:HealthPercentage() < (109 - 74)) and v18.ViciousContempt:IsAvailable()))) then
		if v11(v18.Bloodbath) then
			return "bloodbath slayer_st 26";
		end
	end
	if (v18.RagingBlow:IsCastable() and v51 and (v6:Rage() < (118 - (10 + 8))) and v6:BuffDown(v18.OpportunistBuff)) then
		if v11(v18.RagingBlow) then
			return "raging_blow slayer_st 28";
		end
	end
	if (v18.Rampage:IsReady() and v51 and (v18.RecklessAbandon:IsAvailable())) then
		if v11(v18.Rampage) then
			return "rampage slayer_st 30";
		end
	end
	if (v18.Execute:IsReady() and v51 and v52 and v7:DebuffUp(v18.MarkedforExecutionDebuff)) then
		if v11(v18.Executecast) then
			return "execute slayer_st 32";
		end
	end
	if (v18.Bloodthirst:IsCastable() and v51 and not v18.RecklessAbandon:IsAvailable() and v52) then
		if v11(v18.Bloodthirst) then
			return "bloodthirst slayer_st 34";
		end
	end
	if (v18.RagingBlow:IsCastable() and v51) then
		if v11(v18.RagingBlow) then
			return "raging_blow slayer_st 36";
		end
	end
	if (v18.Onslaught:IsReady() and v51) then
		if v11(v18.Onslaught) then
			return "onslaught slayer_st 38";
		end
	end
	if (v18.Execute:IsReady() and v51) then
		if v11(v18.Executecast) then
			return "execute slayer_st 40";
		end
	end
	if (v18.Bloodthirst:IsCastable() and v51) then
		if v11(v18.Bloodthirst) then
			return "bloodthirst slayer_st 42";
		end
	end
	if (v18.Whirlwind:IsCastable() and v7:IsInMeleeRange(30 - 22) and (v18.MeatCleaver:IsAvailable())) then
		if v11(v18.Whirlwind) then
			return "whirlwind slayer_st 44";
		end
	end
	if (v18.Slam:IsCastable() and v51) then
		if v11(v18.Slam) then
			return "slam slayer_st 46";
		end
	end
	if (v18.StormBolt:IsCastable() and v7:IsInRange(462 - (416 + 26)) and (v6:BuffUp(v18.Bladestorm))) then
		if v11(v18.StormBolt) then
			return "storm_bolt slayer_st 48";
		end
	end
end
local function v67()
	if (v18.Recklessness:IsCastable() and v51 and IsRecklessness and ((not v18.AngerManagement:IsAvailable() and (v18.Avatar:CooldownRemains() < (3 - 2)) and v18.TitansTorment:IsAvailable()) or v18.AngerManagement:IsAvailable() or not v18.TitansTorment:IsAvailable())) then
		if v11(v18.Recklessness, true) then
			return "recklessness slayer_mt 2";
		end
	end
	if (v18.Avatar:IsCastable() and v51 and IsAvatar and ((v18.TitansTorment:IsAvailable() and (v52 or v18.TitanicRage:IsAvailable()) and (v7:DebuffUp(v18.ChampionsMightDebuff) or not v18.ChampionsMight:IsAvailable())) or not v18.TitansTorment:IsAvailable())) then
		if v11(v18.Avatar, true) then
			return "avatar slayer_mt 4";
		end
	end
	if (v18.ThunderousRoar:IsCastable() and v7:IsInMeleeRange(6 + 6) and IsThunderousRoar and v52) then
		if v11(v18.ThunderousRoar, true) then
			return "thunderous_roar slayer_mt 6";
		end
	end
	if (v18.ChampionsSpear:IsCastable() and v51 and IsChampionsSpear and ((v52 and v18.TitansTorment:IsAvailable() and (v18.Avatar:CooldownRemains() < v6:GCD())) or (v52 and not v18.TitansTorment:IsAvailable()))) then
		if v10.CastTarget(v18.ChampionsSpear, v10.TName().PLAYER) then
			return "champions_spear slayer_mt 8";
		end
	end
	if (v18.OdynsFury:IsCastable() and v7:IsInMeleeRange(20 - 8) and IsOdynsFury and (v7:DebuffRemains(v18.OdynsFuryDebuff) < (439 - (145 + 293))) and (v52 or v18.TitanicRage:IsAvailable()) and (v18.Avatar:CooldownDown() or not IsAvatar)) then
		if v11(v18.OdynsFury) then
			return "odyns_fury slayer_mt 10";
		end
	end
	if (v18.Whirlwind:IsCastable() and v7:IsInMeleeRange(438 - (44 + 386)) and v6:BuffDown(v18.MeatCleaverBuff) and v18.MeatCleaver:IsAvailable()) then
		if v11(v18.Whirlwind) then
			return "whirlwind slayer_mt 12";
		end
	end
	if (v18.Execute:IsReady() and v51 and v18.AshenJuggernaut:IsAvailable() and (v6:BuffRemains(v18.AshenJuggernautBuff) <= v6:GCD()) and v52) then
		if v11(v18.Executecast) then
			return "execute slayer_mt 14";
		end
	end
	if (v18.Rampage:IsReady() and v51 and v18.Bladestorm:IsLearned() and (v18.Bladestorm:CooldownRemains() <= v6:GCD()) and v7:DebuffDown(v18.ChampionsMightDebuff)) then
		if v11(v18.Rampage) then
			return "rampage slayer_mt 16";
		end
	end
	if (v18.Bladestorm:IsCastable() and v51 and IsRavager and v52 and ((v18.Avatar:CooldownRemains() >= (1495 - (998 + 488))) or not IsAvatar)) then
		if v11(v18.Bladestormcast, true) then
			return "bladestorm slayer_mt 18";
		end
	end
	if (v18.Ravager:IsCastable() and IsRavager and v51 and v52) then
		if v10.CastTarget(v18.Ravager, v10.TName().PLAYER) then
			return "ravager slayer_mt 19";
		end
	end
	if (v18.Onslaught:IsReady() and v51 and (v18.Tenderize:IsAvailable() or v6:BuffUp(v18.BrutalFinishBuff))) then
		if v11(v18.Onslaught) then
			return "onslaught slayer_mt 20";
		end
	end
	if (v18.Rampage:IsReady() and v51 and (v18.AngerManagement:IsAvailable())) then
		if v11(v18.Rampage) then
			return "rampage slayer_mt 22";
		end
	end
	if (v18.CrushingBlow:IsCastable() and v51) then
		if v11(v18.CrushingBlow) then
			return "crushing_blow slayer_mt 24";
		end
	end
	if (v18.Onslaught:IsReady() and v51 and (v18.Tenderize:IsAvailable())) then
		if v11(v18.Onslaught) then
			return "onslaught slayer_mt 26";
		end
	end
	if (v18.Bloodbath:IsCastable() and v51 and v52) then
		if v11(v18.Bloodbath) then
			return "bloodbath slayer_mt 28";
		end
	end
	if (v18.Rampage:IsReady() and v51 and (v18.RecklessAbandon:IsAvailable())) then
		if v11(v18.Rampage) then
			return "rampage slayer_mt 30";
		end
	end
	if (v18.Execute:IsReady() and v51 and v52 and v7:DebuffUp(v18.MarkedforExecutionDebuff)) then
		if v11(v18.Executecast) then
			return "execute slayer_mt 32";
		end
	end
	if (v18.Bloodbath:IsCastable() and v51) then
		if v11(v18.Bloodbath) then
			return "bloodbath slayer_mt 34";
		end
	end
	if (v18.RagingBlow:IsCastable() and v51 and (v18.SlaughteringStrikes:IsAvailable())) then
		if v11(v18.RagingBlow) then
			return "raging_blow slayer_mt 36";
		end
	end
	if (v18.Onslaught:IsReady() and v51) then
		if v11(v18.Onslaught) then
			return "onslaught slayer_mt 38";
		end
	end
	if (v18.Execute:IsReady() and v51) then
		if v11(v18.Executecast) then
			return "execute slayer_mt 40";
		end
	end
	if (v18.Bloodthirst:IsCastable() and v51) then
		if v11(v18.Bloodthirst) then
			return "bloodthirst slayer_mt 42";
		end
	end
	if (v18.RagingBlow:IsCastable() and v51) then
		if v11(v18.RagingBlow) then
			return "raging_blow slayer_mt 44";
		end
	end
	if (v18.Whirlwind:IsCastable() and v7:IsInMeleeRange(3 + 5)) then
		if v11(v18.Whirlwind) then
			return "whirlwind slayer_mt 46";
		end
	end
	if (v18.StormBolt:IsCastable() and v7:IsInRange(17 + 3) and (v6:BuffUp(v18.Bladestorm))) then
		if v11(v18.StormBolt) then
			return "storm_bolt slayer_mt 48";
		end
	end
end
local function v68()
	if (v18.Recklessness:IsCastable() and v51 and IsRecklessness and ((not v18.AngerManagement:IsAvailable() and (v18.Avatar:CooldownRemains() < (773 - (201 + 571))) and v18.TitansTorment:IsAvailable()) or v18.AngerManagement:IsAvailable() or not v18.TitansTorment:IsAvailable())) then
		if v11(v18.Recklessness, true) then
			return "recklessness thane_st 2";
		end
	end
	if (v18.ThunderBlastAbility:IsReady() and v7:IsInMeleeRange(1146 - (116 + 1022)) and v52) then
		if v11(v18.ThunderBlastAbility) then
			return "thunder_blast thane_st 4";
		end
	end
	if (v18.Avatar:IsCastable() and v51 and IsAvatar and ((v18.TitansTorment:IsAvailable() and (v52 or v18.TitanicRage:IsAvailable()) and (v7:DebuffUp(v18.ChampionsMightDebuff) or not v18.ChampionsMight:IsAvailable())) or not v18.TitansTorment:IsAvailable())) then
		if v11(v18.Avatar, true) then
			return "avatar thane_st 6";
		end
	end
	if (v18.Ravager:IsCastable() and v51 and IsRavager) then
		if v10.CastTarget(v18.Ravager, v10.TName().PLAYER) then
			return "ravager thane_st 8";
		end
	end
	if (v18.ThunderousRoar:IsCastable() and v7:IsInMeleeRange(49 - 37) and IsThunderousRoar and v52) then
		if v11(v18.ThunderousRoar, true) then
			return "thunderous_roar thane_st 10";
		end
	end
	if (v18.ChampionsSpear:IsCastable() and v51 and IsChampionsSpear and v52 and ((v18.Avatar:CooldownRemains() < v6:GCD()) or not v18.TitansTorment:IsAvailable())) then
		if v10.CastTarget(v18.ChampionsSpear, v10.TName().PLAYER) then
			return "champions_spear thane_st 12";
		end
	end
	if (v18.OdynsFury:IsCastable() and v7:IsInMeleeRange(8 + 4) and IsOdynsFury and (v7:DebuffRemains(v18.OdynsFuryDebuff) < (3 - 2)) and (v52 or v18.TitanicRage:IsAvailable()) and (v18.Avatar:CooldownDown() or not IsAvatar)) then
		if v11(v18.OdynsFury) then
			return "odyns_fury thane_st 14";
		end
	end
	if (v18.Execute:IsReady() and v51 and v18.AshenJuggernaut:IsAvailable() and (v6:BuffRemains(v18.AshenJuggernautBuff) <= v6:GCD()) and v52) then
		if v11(v18.Executecast) then
			return "execute thane_st 16";
		end
	end
	if (v18.Rampage:IsReady() and v51 and v18.Bladestorm:IsLearned() and (v18.Bladestorm:CooldownRemains() <= v6:GCD()) and v7:DebuffDown(v18.ChampionsMightDebuff)) then
		if v11(v18.Rampage) then
			return "rampage thane_st 18";
		end
	end
	if (v18.Bladestorm:IsCastable() and v51 and IsRavager and v52 and v18.Unhinged:IsAvailable()) then
		if v11(v18.Bladestormcast, true) then
			return "bladestorm thane_st 20";
		end
	end
	if (v18.Rampage:IsReady() and v51 and (v18.AngerManagement:IsAvailable())) then
		if v11(v18.Rampage) then
			return "rampage thane_st 22";
		end
	end
	if (v18.CrushingBlow:IsCastable() and v51) then
		if v11(v18.CrushingBlow) then
			return "crushing_blow thane_st 24";
		end
	end
	if (v18.Onslaught:IsReady() and v51 and (v18.Tenderize:IsAvailable())) then
		if v11(v18.Onslaught) then
			return "onslaught thane_st 26";
		end
	end
	if (v18.Bloodbath:IsCastable() and v51) then
		if v11(v18.Bloodbath) then
			return "bloodbath thane_st 28";
		end
	end
	if (v18.Rampage:IsReady() and v51 and (v18.RecklessAbandon:IsAvailable())) then
		if v11(v18.Rampage) then
			return "rampage thane_st 30";
		end
	end
	if (v18.RagingBlow:IsCastable() and v51) then
		if v11(v18.RagingBlow) then
			return "raging_blow thane_st 32";
		end
	end
	if (v18.Execute:IsReady() and v51) then
		if v11(v18.Executecast) then
			return "execute thane_st 34";
		end
	end
	if (v18.Bloodthirst:IsCastable() and v51 and v52 and (v6:BuffDown(v18.BurstofPowerBuff) or not v18.RecklessAbandon:IsAvailable())) then
		if v11(v18.Bloodthirst) then
			return "bloodthirst thane_st 36";
		end
	end
	if (v18.Onslaught:IsReady() and v51) then
		if v11(v18.Onslaught) then
			return "onslaught thane_st 38";
		end
	end
	if (v18.Bloodthirst:IsCastable() and v51) then
		if v11(v18.Bloodthirst) then
			return "bloodthirst thane_st 40";
		end
	end
	if (v18.ThunderClap:IsCastable() and v7:IsInMeleeRange(28 - 20)) then
		if v11(v18.ThunderClap) then
			return "thunder_clap thane_st 42";
		end
	end
	if (v18.Whirlwind:IsCastable() and v7:IsInMeleeRange(867 - (814 + 45)) and (v18.MeatCleaver:IsAvailable())) then
		if v11(v18.Whirlwind) then
			return "whirlwind thane_st 44";
		end
	end
	if (v18.Slam:IsCastable() and v51) then
		if v11(v18.Slam) then
			return "slam thane_st 46";
		end
	end
end
local function v69()
	if (v18.Recklessness:IsCastable() and v51 and IsRecklessness and ((not v18.AngerManagement:IsAvailable() and (v18.Avatar:CooldownRemains() < (2 - 1)) and v18.TitansTorment:IsAvailable()) or v18.AngerManagement:IsAvailable() or not v18.TitansTorment:IsAvailable())) then
		if v11(v18.Recklessness, true) then
			return "recklessness thane_mt 2";
		end
	end
	if (v18.ThunderBlastAbility:IsReady() and v7:IsInMeleeRange(1 + 7) and v52) then
		if v11(v18.ThunderBlastAbility) then
			return "thunder_blast thane_mt 4";
		end
	end
	if (v18.Avatar:IsCastable() and v51 and IsAvatar and ((v18.TitansTorment:IsAvailable() and (v52 or v18.TitanicRage:IsAvailable()) and (v7:DebuffUp(v18.ChampionsMightDebuff) or not v18.ChampionsMight:IsAvailable())) or not v18.TitansTorment:IsAvailable())) then
		if v11(v18.Avatar) then
			return "avatar thane_mt 6";
		end
	end
	if (v18.ThunderClap:IsCastable() and v7:IsInMeleeRange(3 + 5) and v6:BuffDown(v18.MeatCleaverBuff) and v18.MeatCleaver:IsAvailable()) then
		if v11(v18.ThunderClap) then
			return "thunder_clap thane_mt 8";
		end
	end
	if (v18.ThunderousRoar:IsCastable() and v7:IsInMeleeRange(897 - (261 + 624)) and IsThunderousRoar and v52) then
		if v11(v18.ThunderousRoar, true) then
			return "thunderous_roar thane_mt 10";
		end
	end
	if (v18.Ravager:IsCastable() and v51 and IsRavager) then
		if v10.CastTarget(v18.Ravager, v10.TName().PLAYER) then
			return "ravager thane_mt 12";
		end
	end
	if (v18.ChampionsSpear:IsCastable() and v51 and IsChampionsSpear and v52) then
		if v10.CastTarget(v18.ChampionsSpear, v10.TName().PLAYER) then
			return "champions_spear thane_mt 14";
		end
	end
	if (v18.OdynsFury:IsCastable() and v7:IsInMeleeRange(21 - 9) and IsOdynsFury and (v7:DebuffRemains(v18.OdynsFuryDebuff) < (1081 - (1020 + 60))) and (v52 or v18.TitanicRage:IsAvailable()) and (v18.Avatar:CooldownDown() or not IsAvatar)) then
		if v11(v18.OdynsFury) then
			return "odyns_fury thane_mt 16";
		end
	end
	if (v18.Execute:IsReady() and v51 and v18.AshenJuggernaut:IsAvailable() and (v6:BuffRemains(v18.AshenJuggernautBuff) <= v6:GCD()) and v52) then
		if v11(v18.Executecast) then
			return "execute thane_mt 18";
		end
	end
	if (v18.Rampage:IsReady() and v51 and v18.Bladestorm:IsLearned() and (v18.Bladestorm:CooldownRemains() <= v6:GCD()) and v7:DebuffDown(v18.ChampionsMightDebuff)) then
		if v11(v18.Rampage) then
			return "rampage thane_mt 20";
		end
	end
	if (v18.Bladestorm:IsCastable() and v51 and IsRavager and v52) then
		if v11(v18.Bladestormcast, true) then
			return "bladestorm thane_mt 22";
		end
	end
	if (v18.Rampage:IsReady() and v51 and (v18.AngerManagement:IsAvailable())) then
		if v11(v18.Rampage) then
			return "rampage thane_mt 24";
		end
	end
	if (v18.CrushingBlow:IsCastable() and v51 and v52) then
		if v11(v18.CrushingBlow) then
			return "crushing_blow thane_mt 26";
		end
	end
	if (v18.Onslaught:IsReady() and v51 and (v18.Tenderize:IsAvailable())) then
		if v11(v18.Onslaught) then
			return "onslaught thane_mt 28";
		end
	end
	if (v18.Bloodbath:IsCastable() and v51) then
		if v11(v18.Bloodbath) then
			return "bloodbath thane_mt 30";
		end
	end
	if (v18.Rampage:IsReady() and v51 and (v18.RecklessAbandon:IsAvailable())) then
		if v11(v18.Rampage) then
			return "rampage thane_mt 32";
		end
	end
	if (v18.Bloodthirst:IsCastable() and v51) then
		if v11(v18.Bloodthirst) then
			return "bloodthirst thane_mt 34";
		end
	end
	if (v18.ThunderClap:IsCastable() and v7:IsInMeleeRange(1431 - (630 + 793))) then
		if v11(v18.ThunderClap) then
			return "thunder_clap thane_mt 36";
		end
	end
	if (v18.Onslaught:IsReady() and v51) then
		if v11(v18.Onslaught) then
			return "onslaught thane_mt 38";
		end
	end
	if (v18.Execute:IsReady() and v51) then
		if v11(v18.Executecast) then
			return "execute thane_mt 40";
		end
	end
	if (v18.RagingBlow:IsCastable() and v51) then
		if v11(v18.RagingBlow) then
			return "raging_blow thane_mt 42";
		end
	end
	if (v18.Whirlwind:IsCastable() and v7:IsInMeleeRange(26 - 18)) then
		if v11(v18.Whirlwind) then
			return "whirlwind thane_mt 44";
		end
	end
end
local function v70()
	if (v23.Commons.Enabled.Items and v19.Fyralath:IsEquippedAndReady() and v51 and IsWeapon and (v18.MarkofFyralathDebuff:AuraActiveCount() > (0 - 0))) then
		v10.CastMacro(1 + 0, nil, nil, v19.Fyralath);
		return "weapon cast";
	end
	if v23.Commons.Enabled.Trinkets then
		if (v19.TreacherousTransmitter:IsEquippedAndReady() and (((v24:ID() == v19.TreacherousTransmitter:ID()) and IsTrinket1) or ((v25:ID() == v19.TreacherousTransmitter:ID()) and IsTrinket2)) and (v46 or v45)) then
			if v11(v19.TreacherousTransmitter, true) then
				return "treacherous_transmitter trinkets 2";
			end
		end
		if (v24:IsReady() and v51 and IsTrinket1 and not v34 and ((v40 and not v42 and ((v6:BuffDown(v18.AvatarBuff) and (v30 > (0 - 0))) or (v30 == (1747 - (760 + 987)))) and ((v18.TitansTorment:IsAvailable() and v18.Avatar:CooldownUp()) or (v6:BuffUp(v18.AvatarBuff) and not v18.TitansTorment:IsAvailable())) and (v37 or not v25:HasCooldown() or v25:CooldownDown() or (v44 == (1914 - (1789 + 124))))) or (v24:BuffDuration() >= v53))) then
			if v11(v24, true) then
				return "use_item for " .. v24:Name() .. " trinkets 4";
			end
		end
		if (v25:IsReady() and v51 and IsTrinket2 and not v35 and ((v41 and not v43 and ((v6:BuffDown(v18.AvatarBuff) and (v31 > (766 - (745 + 21)))) or (v31 == (0 + 0))) and ((v18.TitansTorment:IsAvailable() and v18.Avatar:CooldownUp()) or (v6:BuffUp(v18.AvatarBuff) and not v18.TitansTorment:IsAvailable())) and (v36 or not v24:HasCooldown() or v24:CooldownDown() or (v44 == (5 - 3)))) or (v25:BuffDuration() >= v53))) then
			if v11(v25, true) then
				return "use_item for " .. v25:Name() .. " trinkets 6";
			end
		end
		if (v24:IsReady() and v51 and IsTrinket1 and not v34 and not v40 and (((v30 > (0 - 0)) and v6:BuffDown(v18.AvatarBuff)) or (v30 == (0 + 0))) and not v42 and ((not v40 and (v25:CooldownDown() or not v41)) or ((v30 > (0 + 0)) and v6:BuffDown(v18.AvatarBuff)) or (v30 == (1055 - (87 + 968))) or (v18.Avatar:CooldownRemains() > (88 - 68)))) then
			if v11(v24, true) then
				return "use_item for " .. v24:Name() .. " trinkets 8";
			end
		end
		if (v25:IsReady() and v51 and IsTrinket2 and not v35 and not v41 and (((v31 > (0 + 0)) and v6:BuffDown(v18.AvatarBuff)) or (v31 == (0 - 0))) and not v43 and ((not v41 and (v24:CooldownDown() or not v40)) or ((v31 > (1413 - (447 + 966))) and v6:BuffDown(v18.AvatarBuff)) or (v31 == (0 - 0)) or (v18.Avatar:CooldownRemains() > (1837 - (1703 + 114))))) then
			if v11(v25, true) then
				return "use_item for " .. v25:Name() .. " trinkets 10";
			end
		end
	end
	if v23.Commons.Enabled.Items then
		local v97, v98, v99 = v6:GetUseableItems(v20, 717 - (376 + 325));
		if (v97 and v97:IsReady() and IsWeapon and v7:IsInRange(v99) and not v19.Fyralath:IsEquipped() and (not v40 or v32) and (not v41 or v33)) then
			v10.CastMacro(1 - 0, nil, nil, v97);
			return "weapon cast";
		end
	end
end
local function v71()
	v45 = v50 == (2 - 1);
	v46 = v50 >= (1 + 1);
	v47 = (v18.Massacre:IsAvailable() and (v7:HealthPercentage() < (76 - 41))) or (v7:HealthPercentage() < (34 - (9 + 5)));
	v48 = v6:BuffDown(v18.RecklessnessBuff) and v6:BuffDown(v18.AvatarBuff) and (v6:Rage() < (456 - (85 + 291))) and v6:BuffDown(v18.BloodbathBuff) and v6:BuffDown(v18.CrushingBlowBuff) and v6:BuffDown(v18.SuddenDeathBuff) and v18.Bladestorm:CooldownDown() and (v18.Execute:CooldownDown() or not v47);
end
local function v72()
	v49 = v6:GetEnemiesInMeleeRange(1273 - (243 + 1022));
	if v12() then
		v50 = #v49;
	else
		v50 = 3 - 2;
	end
	Smallcds = v10.ToggleIconFrame:GetToggle(1 + 0);
	AutoStance = v10.ToggleIconFrame:GetToggle(1182 - (1123 + 57));
	InterruptToggle = v10.ToggleIconFrame:GetToggle(3 + 0);
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
	local v93 = 254 - (163 + 91);
	if v18.RumblingEarth:IsAvailable() then
		v93 = 1946 - (1869 + 61);
	else
		v93 = 3 + 7;
	end
	v52 = v6:BuffUp(v18.EnrageBuff);
	v51 = v7:IsInRange(17 - 12);
	if (v21.TargetIsValid() or v6:AffectingCombat()) then
		v53 = v3.BossFightRemains();
		v60 = true;
		v54 = v53;
		if (v54 == (17065 - 5954)) then
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
		v17 = v21.IncorpCycle(v18.IntimidatingShout, 2 + 6, false, false);
		v17 = v21.IncorpCycle(v18.StormBolt, 27 - 7, false, false);
		if v17 then
			return v17;
		end
	end
	local v94 = v6:IncomingSpell(Warrior.SpellReflectList);
	local v95 = v6:IncomingSpellreflection(Warrior.SpellReflectList);
	if (v95 and v10.DebugON()) then
		print("Spell Reflect Cast: " .. v95);
	end
	local v96 = v6:BuffUp(v18.SpellReflection) or (v94 and v18.SpellReflection:IsReady() and v23.Commons.AutoSpellreflection);
	if (v18.SpellReflection:IsReady() and v95 and v23.Commons.AutoSpellreflection) then
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
				if (InterruptToggle and not v96) then
					v17 = v21.InterruptCycle(v18.Pummel, 5 + 0, true, nil, false);
					if v17 then
						return v17;
					end
					v17 = v23.Interrupt.UseStormbolt and v21.InterruptCycle(v18.StormBolt, 1494 - (1329 + 145), false, nil, true);
					if v17 then
						return v17;
					end
					v17 = v23.Interrupt.UseShockwave and v21.InterruptCycle(v18.Shockwave, v93, false, nil, true, true);
					if v17 then
						return v17;
					end
				end
				if (IsPotions and v23.Commons.Enabled.Potions and v51) then
					local v100 = v21.PotionSelected();
					if (v100 and v100:IsReady()) then
						v10.CastMacro(974 - (140 + 831), nil, nil, v100);
						return "Cast Potion";
					end
				end
				if (v23.Commons.Enabled.Trinkets or v23.Commons.Enabled.Items) then
					local v101 = v70();
					if v101 then
						return v101;
					end
				end
				v71();
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
				if ((v18.SlayersDominance:IsAvailable() or Lowlevel) and (v50 < (1852 - (1409 + 441)))) then
					local v102 = v66();
					if v102 then
						return v102;
					end
					if v10.CastAnnotated(v18.Pool, false, "WAIT") then
						return "Pool for SlayerST()";
					end
				end
				if ((v18.SlayersDominance:IsAvailable() or Lowlevel) and (v50 > (719 - (15 + 703)))) then
					local v103 = v67();
					if v103 then
						return v103;
					end
					if v10.CastAnnotated(v18.Pool, false, "WAIT") then
						return "Pool for SlayerMT()";
					end
				end
				if (v18.LightningStrikes:IsAvailable() and ((v50 < (1 + 1)) or not v12())) then
					local v104 = v68();
					if v104 then
						return v104;
					end
					if v10.CastAnnotated(v18.Pool, false, "WAIT") then
						return "Pool for ThaneST()";
					end
				end
				if (v18.LightningStrikes:IsAvailable() and (v50 > (439 - (262 + 176))) and v12()) then
					local v105 = v69();
					if v105 then
						return v105;
					end
					if v10.CastAnnotated(v18.Pool, false, "WAIT") then
						return "Pool for ThaneMT()";
					end
				end
				if v10.CastAnnotated(v18.Pool, false, "WAIT") then
					return "Wait/Pool Resources";
				end
			end
		end
	end
end
local function v73()
	v10.ResetToggle();
	v23.Fury.Display();
	v18.MarkofFyralathDebuff:RegisterAuraTracking();
	v10:UpdateMacro("macro1", "/use item:206448");
	v10.ToggleIconFrame:AddButtonCustom("S", 1722 - (345 + 1376), "smallCDs", "smallcds");
	v10.ToggleIconFrame:AddButtonCustom("A", 690 - (198 + 490), "Auto Stance", "autostance");
	v10.ToggleIconFrame:AddButtonCustom("I", 13 - 10, "Interrupt", "interrupt");
	v10.Print("Fury Warrior rotation has been updated for patch 11.0.2. Last Update 28.09.2024");
end
v10.SetAPL(172 - 100, v72, v73);
