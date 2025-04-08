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
local v18 = v8.Warrior.Arms;
local v19 = v9.Warrior.Arms;
local v20 = {v19.TreacherousTransmitter:ID(),v19.Fyralath:ID()};
local v21 = v10.Commons().Everyone;
local v22 = v10.GUISettingsGet();
local v23 = {General=v22.General,Commons=v22.APL.Warrior.Commons,Arms=v22.APL.Warrior.Arms,Arms_Defensives=v22.APL.Warrior.Arms.Defensives,Arms_TTD=v22.APL.Warrior.Arms_TTD,Arms_CDUSE=v22.APL.Warrior.Arms_CDUSE,Interrupt=v22.APL.Warrior.Arms_Interrupt.Interrupt};
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
local v45, v46, v47;
local v48;
local v49, v50;
local v51 = 21447 - 10336;
local v52 = 28620 - 17509;
local v53 = 619 - (555 + 64);
local function v54()
	local v77, v78 = v6:GetTrinketData(v20);
	if ((v53 < (936 - (857 + 74))) and ((v77.ID == (568 - (367 + 201))) or (v78.ID == (927 - (214 + 713))) or ((v77.SpellID > (0 + 0)) and not v77.Usable) or ((v78.SpellID > (0 + 0)) and not v78.Usable))) then
		v53 = v53 + (878 - (282 + 595));
		v16(1642 - (1523 + 114), function()
			v54();
		end);
		return;
	end
	v24 = v77.Object;
	v25 = v78.Object;
	v26 = v77.Spell;
	v28 = v77.Range;
	v30 = v77.CastTime;
	v27 = v78.Spell;
	v29 = v78.Range;
	v31 = v78.CastTime;
	v32 = v77.Cooldown;
	v33 = v78.Cooldown;
	v34 = v77.Blacklisted;
	v35 = v78.Blacklisted;
	v36 = v77.ID == v19.TreacherousTransmitter:ID();
	v37 = v78.ID == v19.TreacherousTransmitter:ID();
	v38 = 0.5 + 0;
	if (v24:HasUseBuff() and ((v32 % (128 - 38)) == (1065 - (68 + 997)))) then
		v38 = 1271 - (226 + 1044);
	end
	v39 = 0.5 - 0;
	if (v25:HasUseBuff() and ((v33 % (207 - (32 + 85))) == (0 + 0))) then
		v39 = 1 + 0;
	end
	v40 = v24:HasUseBuff() or (v24:HasStatAnyDps() and not v36);
	v41 = v25:HasUseBuff() or (v25:HasStatAnyDps() and not v37);
	local v91 = ((v24:BuffDuration() > (957 - (892 + 65))) and v24:BuffDuration()) or (2 - 1);
	local v92 = ((v25:BuffDuration() > (0 - 0)) and v25:BuffDuration()) or (1 - 0);
	v44 = 351 - (87 + 263);
	if ((not v40 and v41) or (v41 and (((v33 / v92) * v39) > ((v32 / v91) * v38)))) then
		v44 = 182 - (67 + 113);
	end
	v42 = v77.ID == v19.AlgetharPuzzleBox:ID();
	v43 = v78.ID == v19.AlgetharPuzzleBox:ID();
end
v54();
local v55 = {{v18.StormBolt,"Cast Storm Bolt (Interrupt)",function()
	return true;
end}};
v3:RegisterForEvent(function()
	v51 = 12063 - (802 + 150);
	v52 = 29914 - 18803;
end, "PLAYER_REGEN_ENABLED");
v3:RegisterForEvent(function()
	v53 = 0 - 0;
	v54();
end, "PLAYER_EQUIPMENT_CHANGED");
local function v56(v93)
	return v93:HealthPercentage();
end
local function v57(v94)
	return v94:NPCID() == (148897 + 55663);
end
local v58;
local function v59()
	return v19.ManicGrieftorch:IsEquipped() and (v19.ManicGrieftorch:CooldownUp() or (v19.ManicGrieftorch:CooldownRemains() <= v6:GCDRemains()));
end
local function v60()
	return v19.AlgetharPuzzleBox:IsEquipped() and (v19.AlgetharPuzzleBox:CooldownUp() or (v19.AlgetharPuzzleBox:CooldownRemains() <= v6:GCDRemains()));
end
local function v61(v95)
	return (v95 ~= "Not Used") and ((((v95 == "with Cooldowns") or ((v95 == "small CDs") and v23.Arms_CDUSE.smallcdswithCooldowns) or (v95 == "with Cooldowns or AoE") or (v95 == "on Enemycount or Cooldowns") or (v95 == "on Boss or with Cooldowns")) and v13()) or (v95 == "always") or (((v95 == "on Boss only") or (v95 == "on Boss or on Enemycount") or (v95 == "on Boss or with Cooldowns")) and (v58 or v7:IsDummy())) or ((v95 == "with Bloodlust only") and v6:BloodlustUp()) or ((v95 == "small CDs") and Smallcds) or (((v95 == "on AOE") or (v95 == "with Cooldowns or AoE")) and (v50 > (999 - (915 + 82))) and v12()) or (((v95 == "on Enemycount or Cooldowns") or (v95 == "on Enemycount") or (v95 == "on Boss or on Enemycount")) and (v50 >= v23.Arms_CDUSE.Enemycount) and v12()));
end
local function v62(v96)
	return (v58 and v23.Arms_TTD.IgnoreWhenBoss) or v21.Buggedmobs[v7:NPCID()] or (v21.ISSolo() and v23.Arms_TTD.IgnoreWhenSolo) or (v96 == (0 - 0)) or ((v52 >= v96) and (v52 < (4531 + 3246)));
end
local function v63()
	if (v18.VictoryRush:IsCastable() and v48 and v6:CanAttack(v7) and v6:BuffUp(v18.VictoriousBuff) and (v6:HealthPercentage() <= v23.Arms.Defensives.VictoryRushHP)) then
		if v11(v18.VictoryRush) then
			return "VictoryRush";
		end
	end
	if (v18.ImpendingVictory:IsCastable() and v48 and v6:CanAttack(v7) and (v6:HealthPercentage() <= v23.Arms.Defensives.ImpendingVictoryHP)) then
		if v11(v18.ImpendingVictory) then
			return "ImpendingVictory";
		end
	end
	if (v18.BitterImmunity:IsCastable() and v6:AffectingCombat() and (v6:HealthPercentage() <= v23.Arms.Defensives.BitterImmunityHP)) then
		if v11(v18.BitterImmunity) then
			return "BitterImmunity";
		end
	end
	if (v18.DiebytheSword:IsCastable() and v6:AffectingCombat() and (v6:HealthPercentage() <= v23.Arms.Defensives.DiebytheSwordHP)) then
		if v11(v18.DiebytheSword) then
			return "DiebytheSword";
		end
	end
	if (v18.IgnorePain:IsReady() and v6:AffectingCombat() and (((v23.Arms_Defensives.IgnorePainUse == "on HP") and (v6:HealthPercentage() <= v23.Arms_Defensives.IgnorePainHP)) or ((v23.Arms_Defensives.IgnorePainUse == "on Enemycount") and (v50 >= v23.Arms_Defensives.IgnorePainEnemycount)) or ((v23.Arms_Defensives.IgnorePainUse == "on Enemycount and HP") and (v6:HealthPercentage() <= v23.Arms_Defensives.IgnorePainHP) and (v50 >= v23.Arms_Defensives.IgnorePainEnemycount)))) then
		if v11(v18.IgnorePain) then
			return "IgnorePain";
		end
	end
	if AutoStance then
		if (v18.DefensiveStance:IsCastable() and v6:BuffUp(v18.BattleStance) and (v6:HealthPercentage() <= v23.Arms_Defensives.DefStanceHP)) then
			if v11(v18.DefensiveStance) then
				return "BearForm";
			end
		end
		if (v18.BattleStance:IsCastable() and v6:BuffUp(v18.DefensiveStance) and (v6:HealthPercentage() > v23.Arms_Defensives.BattleStanceHP) and (v23.Arms_Defensives.BattleStanceHP > (0 - 0))) then
			if v11(v18.BattleStance) then
				return "MoonkinForm";
			end
		end
	end
end
local function v64()
	if v48 then
		if (v18.Skullsplitter:IsCastable() and v48) then
			if v11(v18.Skullsplitter) then
				return "skullsplitter precombat 8";
			end
		end
		if (v18.ColossusSmash:IsCastable() and v48 and IsColossusSmash) then
			if v11(v18.ColossusSmash, true) then
				return "colossus_smash precombat 10";
			end
		end
		if (v18.Warbreaker:IsCastable() and v7:IsInMeleeRange(1195 - (1069 + 118)) and IsColossusSmash) then
			if v11(v18.Warbreaker, true) then
				return "warbreaker precombat 12";
			end
		end
		if (v18.Overpower:IsCastable() and v48) then
			if v11(v18.Overpower) then
				return "overpower precombat 14";
			end
		end
	end
end
local function v65()
	if (v18.Cleave:IsReady() and v48 and (v7:DebuffDown(v18.DeepWoundsDebuff))) then
		if v11(v18.Cleave) then
			return "cleave colossus_aoe 2";
		end
	end
	if (v18.ThunderClap:IsReady() and v48 and (v7:DebuffDown(v18.RendDebuff))) then
		if v11(v18.ThunderClap) then
			return "thunder_clap colossus_aoe 4";
		end
	end
	if (v18.ThunderousRoar:IsCastable() and v7:IsInMeleeRange(26 - 14) and IsThunderousRoar) then
		if v11(v18.ThunderousRoar, true) then
			return "thunderous_roar colossus_aoe 6";
		end
	end
	if (v18.Avatar:IsCastable() and v48 and IsAvatar) then
		if v11(v18.Avatar, true) then
			return "avatar colossus_aoe 8";
		end
	end
	if (v18.SweepingStrikes:IsCastable() and v7:IsInMeleeRange(17 - 9)) then
		if v11(v18.SweepingStrikes) then
			return "sweeping_strikes colossus_aoe 12";
		end
	end
	if (IsBladestorm and v48 and v18.Ravager:IsCastable()) then
		if v10.CastTarget(v18.Ravager, v10.TName().PLAYER) then
			return "ravager colossus_aoe 14";
		end
	end
	if (v18.Warbreaker:IsCastable() and v7:IsInRange(2 + 6) and IsColossusSmash) then
		if v11(v18.Warbreaker, true) then
			return "warbreaker colossus_aoe 16";
		end
	end
	if (v18.ChampionsSpear:IsCastable() and v48 and IsChampionsSpear) then
		if v10.CastTarget(v18.ChampionsSpear, v10.TName().PLAYER) then
			return "champions_spear colossus_aoe 20";
		end
	end
	if (v18.ColossusSmash:IsCastable() and v48 and IsColossusSmash) then
		if v11(v18.ColossusSmash, true) then
			return "colossus_smash colossus_aoe 22";
		end
	end
	if (v18.Cleave:IsReady() and v48) then
		if v11(v18.Cleave) then
			return "cleave colossus_aoe 24";
		end
	end
	if (v18.Bladestorm:IsCastable() and v48 and IsBladestorm and (v18.Unhinged:IsAvailable() or v18.MercilessBonegrinder:IsAvailable())) then
		if v11(v18.Bladestormcast, true) then
			return "bladestorm colossus_aoe 28";
		end
	end
	if (v18.ThunderClap:IsReady() and v48 and (v7:DebuffRemains(v18.RendDebuff) < (8 - 3))) then
		if v11(v18.ThunderClap) then
			return "thunder_clap colossus_aoe 24";
		end
	end
	if (v18.Demolish:IsCastable() and IsDemolish and not v6:IsMoving() and v48 and (v6:BuffStack(v18.ColossalMightBuff) == (10 + 0)) and ((v7:DebuffRemains(v18.ColossusSmashDebuff) >= (793 - (368 + 423))) or (v18.ColossusSmash:CooldownRemains() >= (21 - 14)))) then
		if v11(v18.Demolish) then
			return "demolish colossus_aoe 26";
		end
	end
	if (v18.Overpower:IsCastable() and v48 and (v18.Dreadnaught:IsAvailable())) then
		if v11(v18.Overpower) then
			return "overpower colossus_aoe 30";
		end
	end
	if (v18.MortalStrike:IsReady() and v48) then
		if v11(v18.MortalStrike) then
			return "mortal_strike colossus_aoe 32";
		end
	end
	if (v18.Overpower:IsCastable() and v48) then
		if v11(v18.Overpower) then
			return "overpower colossus_aoe 34";
		end
	end
	if (v18.ThunderClap:IsReady() and v48) then
		if v11(v18.ThunderClap) then
			return "thunder_clap colossus_aoe 38";
		end
	end
	if (v18.Skullsplitter:IsCastable() and v48) then
		if v11(v18.Skullsplitter, true) then
			return "skullsplitter colossus_aoe 36";
		end
	end
	if (v18.Execute:IsReady() and v48) then
		if v11(v18.Executecast) then
			return "execute colossus_aoe 42";
		end
	end
	if (v18.Bladestorm:IsCastable() and v48 and IsBladestorm) then
		if v11(v18.Bladestormcast, true) then
			return "bladestorm colossus_aoe 44";
		end
	end
	if (v18.Whirlwind:IsReady() and v48) then
		if v11(v18.Whirlwind) then
			return "whirlwind colossus_aoe 46";
		end
	end
end
local function v66()
	if (v18.SweepingStrikes:IsCastable() and (v50 == (20 - (10 + 8))) and v48) then
		if v11(v18.SweepingStrikes) then
			return "sweeping_strikes colossus_execute 2";
		end
	end
	if (v18.Rend:IsCastable() and v48 and (v7:DebuffRemains(v18.RendDebuff) <= v6:GCD()) and not v18.Bloodletting:IsAvailable()) then
		if v11(v18.Rend) then
			return "rend colossus_execute 4";
		end
	end
	if (v18.ThunderousRoar:IsCastable() and v7:IsInMeleeRange(45 - 33) and IsThunderousRoar) then
		if v11(v18.ThunderousRoar, true) then
			return "thunderous_roar colossus_execute 6";
		end
	end
	if (v18.ChampionsSpear:IsCastable() and v48 and IsChampionsSpear) then
		if v10.CastTarget(v18.ChampionsSpear, v10.TName().PLAYER) then
			return "champions_spear colossus_execute 8";
		end
	end
	if (v18.Ravager:IsCastable() and v48 and IsBladestorm and (v18.ColossusSmash:CooldownRemains() <= v6:GCD())) then
		if v10.CastTarget(v18.Ravager, v10.TName().PLAYER) then
			return "ravager colossus_execute 10";
		end
	end
	if (v18.Avatar:IsCastable() and v48 and IsAvatar) then
		if v11(v18.Avatar, true) then
			return "avatar colossus_execute 12";
		end
	end
	if (v18.ColossusSmash:IsCastable() and v48 and IsColossusSmash) then
		if v11(v18.ColossusSmash, true) then
			return "colossus_smash colossus_execute 14";
		end
	end
	if (v18.Warbreaker:IsCastable() and v7:IsInRange(450 - (416 + 26)) and IsColossusSmash) then
		if v11(v18.Warbreaker, true) then
			return "warbreaker colossus_execute 16";
		end
	end
	if (v18.Execute:IsReady() and v48 and (v6:BuffRemains(v18.JuggernautBuff) <= v6:GCD()) and v18.Juggernaut:IsAvailable()) then
		if v11(v18.Executecast) then
			return "execute colossus_execute 18";
		end
	end
	if (v18.Skullsplitter:IsCastable() and v48 and (v6:Rage() < (127 - 87))) then
		if v11(v18.Skullsplitter) then
			return "skullsplitter colossus_execute 20";
		end
	end
	if (v18.Demolish:IsCastable() and IsDemolish and not v6:IsMoving() and v48 and (v7:DebuffUp(v18.ColossusSmashDebuff))) then
		if v11(v18.Demolish) then
			return "demolish colossus_execute 18";
		end
	end
	if (v18.MortalStrike:IsReady() and v48 and (((v7:DebuffStack(v18.ExecutionersPrecisionDebuff) == (1 + 1)) and v7:DebuffDown(v18.RavagerDebuff)) or not v18.ExecutionersPrecision:IsAvailable() or (v18.Battlelord:IsAvailable() and v7:DebuffUp(v18.ExecutionersPrecisionDebuff)))) then
		if v11(v18.MortalStrike) then
			return "mortal_strike colossus_execute 20";
		end
	end
	if (v18.Overpower:IsReady() and v48 and (v6:Rage() < (159 - 69))) then
		if v11(v18.Overpower) then
			return "overpower colossus_execute 26";
		end
	end
	if (v18.Execute:IsReady() and v48 and (v6:Rage() >= (478 - (145 + 293))) and v18.ExecutionersPrecision:IsAvailable()) then
		if v11(v18.Executecast) then
			return "execute colossus_execute 22";
		end
	end
	if (v18.Overpower:IsCastable() and v48) then
		if v11(v18.Overpower) then
			return "overpower colossus_execute 26";
		end
	end
	if (v18.Bladestorm:IsCastable() and v48 and IsBladestorm) then
		if v11(v18.Bladestormcast, true) then
			return "bladestorm colossus_execute 28";
		end
	end
	if (v18.Execute:IsReady() and v48) then
		if v11(v18.Executecast) then
			return "execute colossus_execute 30";
		end
	end
end
local function v67()
	if (v18.Rend:IsCastable() and v48 and (v7:DebuffRemains(v18.RendDebuff) <= v6:GCD())) then
		if v11(v18.Rend) then
			return "rend colossus_st 2";
		end
	end
	if (v18.ThunderousRoar:IsCastable() and v7:IsInMeleeRange(442 - (44 + 386)) and IsThunderousRoar) then
		if v11(v18.ThunderousRoar, true) then
			return "thunderous_roar colossus_st 4";
		end
	end
	if (v18.Ravager:IsCastable() and v48 and IsBladestorm and (v18.ColossusSmash:CooldownRemains() <= v6:GCD())) then
		if v10.CastTarget(v18.Ravager, v10.TName().PLAYER) then
			return "ravager colossus_st 8";
		end
	end
	if (v18.ChampionsSpear:IsCastable() and v48 and IsChampionsSpear) then
		if v10.CastTarget(v18.ChampionsSpear, v10.TName().PLAYER) then
			return "champions_spear colossus_st 6";
		end
	end
	if (v18.Avatar:IsCastable() and v48 and IsAvatar) then
		if v11(v18.Avatar, true) then
			return "avatar colossus_st 10";
		end
	end
	if (v18.ColossusSmash:IsCastable() and v48 and IsColossusSmash) then
		if v11(v18.ColossusSmash, true) then
			return "colossus_smash colossus_st 12";
		end
	end
	if (v18.Warbreaker:IsCastable() and v7:IsInRange(1494 - (998 + 488)) and IsColossusSmash) then
		if v11(v18.Warbreaker, true) then
			return "warbreaker colossus_st 14";
		end
	end
	if (v18.MortalStrike:IsReady() and v48) then
		if v11(v18.MortalStrike) then
			return "mortal_strike colossus_st 16";
		end
	end
	if (v18.Demolish:IsCastable() and IsDemolish and not v6:IsMoving() and v48) then
		if v11(v18.Demolish) then
			return "demolish colossus_st 18";
		end
	end
	if (v18.Skullsplitter:IsCastable() and v7:IsInMeleeRange(3 + 5)) then
		if v11(v18.Skullsplitter) then
			return "sweeping_strikes colossus_st 20";
		end
	end
	if (v18.Execute:IsReady() and v48) then
		if v11(v18.Executecast) then
			return "execute colossus_st 24";
		end
	end
	if (v18.Overpower:IsCastable() and v48) then
		if v11(v18.Overpower) then
			return "overpower colossus_st 26";
		end
	end
	if (v18.Rend:IsCastable() and v48 and (v7:DebuffRemains(v18.RendDebuff) <= (v6:GCD() * (5 + 0)))) then
		if v11(v18.Rend) then
			return "rend colossus_st 28";
		end
	end
	if (v18.Slam:IsCastable() and v48) then
		if v11(v18.Slam) then
			return "slam colossus_st 30";
		end
	end
end
local function v68()
	if (v18.ThunderClap:IsReady() and v48 and v7:DebuffDown(v18.RendDebuff) and v6:BuffDown(v18.SweepingStrikes)) then
		if v11(v18.ThunderClap) then
			return "thunder_clap colossus_sweep 2";
		end
	end
	if (v18.Rend:IsCastable() and v48 and (v7:DebuffRemains(v18.RendDebuff) <= v6:GCD()) and v6:BuffUp(v18.SweepingStrikesBuff)) then
		if v11(v18.Rend) then
			return "rend colossus_sweep 4";
		end
	end
	if (v18.ThunderousRoar:IsCastable() and v7:IsInMeleeRange(784 - (201 + 571)) and IsThunderousRoar) then
		if v11(v18.ThunderousRoar, true) then
			return "thunderous_roar colossus_sweep 6";
		end
	end
	if (v13() and v18.SweepingStrikes:IsCastable() and v48) then
		if v10.Cast(v18.SweepingStrikes) then
			return "sweeping_strikes colossus_sweep 8";
		end
	end
	if (v18.ChampionsSpear:IsCastable() and v48 and IsChampionsSpear) then
		if v10.CastTarget(v18.ChampionsSpear, v10.TName().PLAYER) then
			return "champions_spear colossus_sweep 8";
		end
	end
	if (v18.Ravager:IsCastable() and v48 and IsBladestorm and (v18.ColossusSmash:CooldownUp())) then
		if v10.CastTarget(v18.Ravager, v10.TName().PLAYER) then
			return "ravager colossus_sweep 10";
		end
	end
	if (v18.Avatar:IsCastable() and v48 and IsAvatar) then
		if v11(v18.Avatar, true) then
			return "avatar colossus_sweep 12";
		end
	end
	if (v18.ColossusSmash:IsCastable() and v48 and IsColossusSmash) then
		if v11(v18.ColossusSmash, true) then
			return "colossus_smash colossus_sweep 14";
		end
	end
	if (v18.Warbreaker:IsCastable() and v7:IsInRange(1146 - (116 + 1022)) and IsColossusSmash) then
		if v11(v18.Warbreaker, true) then
			return "warbreaker colossus_sweep 16";
		end
	end
	if (v18.MortalStrike:IsReady() and v48) then
		if v11(v18.MortalStrike) then
			return "mortal_strike colossus_sweep 20";
		end
	end
	if (v18.Demolish:IsCastable() and IsDemolish and not v6:IsMoving() and v48) then
		if v11(v18.Demolish) then
			return "demolish colossus_sweep 24";
		end
	end
	if (v18.Overpower:IsCastable() and v48) then
		if v11(v18.Overpower) then
			return "op colossus_sweep 28";
		end
	end
	if (v18.Execute:IsReady() and v48) then
		if v11(v18.Executecast) then
			return "execute colossus_sweep 30";
		end
	end
	if (v18.Whirlwind:IsReady() and (v18.FervorofBattle:IsAvailable()) and v48) then
		if v11(v18.Whirlwind) then
			return "whirlwind colossus_sweep 32";
		end
	end
	if (v18.Cleave:IsReady() and (v18.FervorofBattle:IsAvailable()) and v48) then
		if v11(v18.Cleave, nil, nil, not v48) then
			return "execute colossus_sweep 34";
		end
	end
	if (v18.ThunderClap:IsReady() and v48 and (v7:DebuffRemains(v18.RendDebuff) < (33 - 25)) and v6:BuffDown(v18.SweepingStrikesBuff)) then
		if v11(v18.ThunderClap) then
			return "thunder_clap colossus_sweep 36";
		end
	end
	if (v18.Rend:IsCastable() and v48 and (v7:DebuffRemains(v18.RendDebuff) <= (3 + 2))) then
		if v11(v18.Rend) then
			return "rend colossus_sweep 38";
		end
	end
	if (v18.Slam:IsReady() and v48) then
		if v11(v18.Slam) then
			return "slam colossus_sweep 44";
		end
	end
end
local function v69()
	if (v18.StormBolt:IsReady() and (v6:BuffUp(v18.Bladestorm)) and v7:IsInRange(73 - 53)) then
		if v11(v18.StormBolt) then
			return "storm_bolt slayer_aoe 2";
		end
	end
	if (v18.ThunderClap:IsReady() and v48 and (v7:DebuffDown(v18.RendDebuff))) then
		if v11(v18.ThunderClap) then
			return "thunder_clap slayer_aoe 4";
		end
	end
	if (v18.SweepingStrikes:IsCastable() and v48) then
		if v11(v18.SweepingStrikes, true) then
			return "sweeping_strikes slayer_aoe 5";
		end
	end
	if (v18.ThunderousRoar:IsCastable() and v7:IsInMeleeRange(42 - 30) and IsThunderousRoar) then
		if v11(v18.ThunderousRoar, true) then
			return "thunderous_roar slayer_execute 6";
		end
	end
	if (v18.Avatar:IsCastable() and IsAvatar) then
		if v11(v18.Avatar, true) then
			return "avatar slayer_aoe 8";
		end
	end
	if (v18.ChampionsSpear:IsCastable() and v48 and IsChampionsSpear) then
		if v10.CastTarget(v18.ChampionsSpear, v10.TName().PLAYER) then
			return "champions_spear slayer_execute 8";
		end
	end
	if (IsBladestorm and v48 and v18.Ravager:IsCastable() and (v18.ColossusSmash:CooldownRemains() <= v6:GCD())) then
		if v10.CastTarget(v18.Ravager, v10.TName().PLAYER) then
			return "ravager slayer_execute 8";
		end
	end
	if (v18.Warbreaker:IsCastable() and v7:IsInRange(867 - (814 + 45)) and IsColossusSmash) then
		if v11(v18.Warbreaker, true) then
			return "warbreaker slayer_execute 12";
		end
	end
	if (v18.ColossusSmash:IsCastable() and v48 and IsColossusSmash) then
		if v11(v18.ColossusSmash, true) then
			return "colossus_smash slayer_execute 14";
		end
	end
	if (v18.Cleave:IsReady() and v48) then
		if v11(v18.Cleave) then
			return "cleave slayer_aoe 18";
		end
	end
	if (v18.Execute:IsReady() and v48 and ((v6:BuffUp(v18.SuddenDeathBuff) and (v6:BuffStack(v18.ImminentDemiseBuff) < (7 - 4))) or ((v6:BuffRemains(v18.JuggernautBuff) < (1 + 2)) and v18.Juggernaut:IsAvailable()))) then
		if v11(v18.Executecast) then
			return "execute slayer_execute 16";
		end
	end
	if (v18.Bladestorm:IsCastable() and v48 and IsBladestorm) then
		if v11(v18.Bladestormcast, true) then
			return "bladestorm slayer_execute 18";
		end
	end
	if (v18.Overpower:IsCastable() and v48 and v6:BuffUp(v18.SweepingStrikesBuff) and (v6:BuffUp(v18.OpportunistBuff) or (v18.Dreadnaught:IsAvailable() and not v18.Juggernaut:IsAvailable()))) then
		if v11(v18.Overpower) then
			return "overpower slayer_aoe 24";
		end
	end
	if (v18.MortalStrike:IsReady() and v48 and (v6:BuffUp(v18.SweepingStrikesBuff))) then
		if v11(v18.MortalStrike) then
			return "mortal_strike slayer_execute 22";
		end
	end
	if (v18.Execute:IsReady() and v48 and ((v6:BuffUp(v18.SweepingStrikesBuff) and (v7:DebuffStack(v18.ExecutionersPrecisionDebuff) < (1 + 1)) and v18.ExecutionersPrecision:IsAvailable()) or v7:DebuffUp(v18.MarkedforExecutionDebuff))) then
		if v11(v18.Executecast) then
			return "execute slayer_aoe 28";
		end
	end
	if (v18.Skullsplitter:IsCastable() and v48 and (v6:BuffUp(v18.SweepingStrikesBuff))) then
		if v11(v18.Skullsplitter, true) then
			return "skullsplitter slayer_aoe 30";
		end
	end
	if (v18.Overpower:IsCastable() and v48 and (v6:BuffUp(v18.OpportunistBuff) or v18.Dreadnaught:IsAvailable())) then
		if v11(v18.Overpower) then
			return "overpower slayer_execute 24";
		end
	end
	if (v18.MortalStrike:IsReady() and v48) then
		if v11(v18.MortalStrike) then
			return "MortalStrike slayer_execute 26";
		end
	end
	if (v18.Overpower:IsCastable() and v48) then
		if v11(v18.Overpower) then
			return "overpower slayer_execute 28";
		end
	end
	if (v18.ThunderClap:IsReady() and v48) then
		if v11(v18.ThunderClap) then
			return "thunder_clap slayer_aoe 38";
		end
	end
	if (v18.Execute:IsReady() and v48) then
		if v11(v18.Executecast) then
			return "execute slayer_aoe 40";
		end
	end
	if (v18.Whirlwind:IsReady() and v48) then
		if v11(v18.Whirlwind) then
			return "whirlwind slayer_aoe 42";
		end
	end
	if (v18.Skullsplitter:IsCastable() and v48) then
		if v11(v18.Skullsplitter) then
			return "skullsplitter slayer_aoe 44";
		end
	end
	if (v18.Slam:IsReady() and v48) then
		if v11(v18.Slam) then
			return "slam slayer_aoe 46";
		end
	end
end
local function v70()
	if (v18.StormBolt:IsReady() and v7:IsInRange(905 - (261 + 624)) and (v6:BuffUp(v18.Bladestorm))) then
		if v11(v18.StormBolt) then
			return "storm_bolt slayer_execute 2";
		end
	end
	if (v18.SweepingStrikes:IsCastable() and (v50 == (3 - 1)) and v48) then
		if v11(v18.SweepingStrikes, true) then
			return "sweeping_strikes slayer_execute 4";
		end
	end
	if (v18.Rend:IsCastable() and v48 and (v7:DebuffRemains(v18.RendDebuff) <= v6:GCD()) and not v18.Bloodletting:IsAvailable()) then
		if v11(v18.Rend) then
			return "rend slayer_st 2";
		end
	end
	if (v18.ThunderousRoar:IsCastable() and v7:IsInMeleeRange(1092 - (1020 + 60)) and IsThunderousRoar) then
		if v11(v18.ThunderousRoar, true) then
			return "thunderous_roar slayer_st 4";
		end
	end
	if (IsAvatar and v18.Avatar:IsCastable() and ((v18.ColossusSmash:CooldownRemains() <= (1428 - (630 + 793))) or v7:DebuffUp(v18.ColossusSmashDebuff))) then
		if v11(v18.Avatar, true) then
			return "avatar slayer_execute 10";
		end
	end
	if (v18.ChampionsSpear:IsCastable() and v48 and IsChampionsSpear) then
		if v10.CastTarget(v18.ChampionsSpear, v10.TName().PLAYER) then
			return "champions_spear slayer_st 6";
		end
	end
	if (v18.Ravager:IsCastable() and v48 and IsBladestorm) then
		if v10.CastTarget(v18.Ravager, v10.TName().PLAYER) then
			return "Ravager slayer_st 6";
		end
	end
	if (v18.Warbreaker:IsCastable() and v48 and IsColossusSmash) then
		if v11(v18.Warbreaker, true) then
			return "warbreaker slayer_execute 16";
		end
	end
	if (v18.ColossusSmash:IsCastable() and v48 and IsColossusSmash) then
		if v11(v18.ColossusSmash, true) then
			return "colossus_smash slayer_st 10";
		end
	end
	if (v18.Execute:IsReady() and v48 and (v6:BuffRemains(v18.JuggernautBuff) <= (v6:GCD() * (6 - 4))) and v18.Juggernaut:IsAvailable()) then
		if v11(v18.Executecast) then
			return "execute slayer_st 14";
		end
	end
	if (IsBladestorm and v18.Bladestorm:IsCastable() and (((v7:DebuffStack(v18.ExecutionersPrecisionDebuff) == (9 - 7)) and (v7:DebuffRemains(v18.ColossusSmashDebuff) > (2 + 2))) or ((v7:DebuffStack(v18.ExecutionersPrecisionDebuff) == (6 - 4)) and (v18.ColossusSmash:CooldownRemains() > (1762 - (760 + 987)))) or not v18.ExecutionersPrecision:IsAvailable())) then
		if v11(v18.Bladestormcast, true) then
			return "bladestorm slayer_st 16";
		end
	end
	if (v18.Skullsplitter:IsCastable() and v7:IsInMeleeRange(1921 - (1789 + 124)) and (v6:Rage() < (806 - (745 + 21)))) then
		if v11(v18.Skullsplitter) then
			return "sweeping_strikes slayer_st 22";
		end
	end
	if (v18.Overpower:IsCastable() and v48 and (v6:BuffStack(v18.MartialProwessBuff) < (1 + 1)) and v6:BuffUp(v18.OpportunistBuff) and v18.Opportunist:IsAvailable() and (v18.Bladestorm:IsAvailable() or (v18.Ravager:IsAvailable() and (v6:Rage() < (233 - 148))))) then
		if v11(v18.Overpower) then
			return "overpower slayer_st 18";
		end
	end
	if (v18.MortalStrike:IsReady() and v48 and ((v7:DebuffRemains(v18.RendDebuff) < (7 - 5)) or ((v7:DebuffStack(v18.ExecutionersPrecisionDebuff) == (1 + 1)) and v7:DebuffDown(v18.RavagerDebuff)))) then
		if v11(v18.MortalStrike) then
			return "mortal_strike slayer_st 20";
		end
	end
	if (v18.Overpower:IsCastable() and v48 and (v6:Rage() <= (32 + 8)) and (v6:BuffStack(v18.MartialProwessBuff) < (1057 - (87 + 968))) and v18.FierceFollowthrough:IsAvailable()) then
		if v11(v18.Overpower) then
			return "overpower slayer_st 26";
		end
	end
	if (v18.Execute:IsReady() and v48) then
		if v11(v18.Executecast) then
			return "execute slayer_execute 32";
		end
	end
	if (v18.Overpower:IsCastable() and v48) then
		if v11(v18.Overpower) then
			return "overpower slayer_execute 34";
		end
	end
end
local function v71()
	if (v18.StormBolt:IsReady() and v48 and (v6:BuffUp(v18.Bladestorm))) then
		if v11(v18.StormBolt) then
			return "StormBolt slayer_aoe 2";
		end
	end
	if (v18.Rend:IsCastable() and v48 and (v7:DebuffRemains(v18.RendDebuff) <= v6:GCD())) then
		if v11(v18.Rend) then
			return "rend slayer_st 4";
		end
	end
	if (v18.ThunderousRoar:IsCastable() and v7:IsInMeleeRange(52 - 40) and IsThunderousRoar) then
		if v11(v18.ThunderousRoar, true) then
			return "thunderous_roar slayer_aoe 6";
		end
	end
	if (v48 and IsAvatar and v18.Avatar:IsCastable() and ((v18.ColossusSmash:CooldownRemains() <= (5 + 0)) or v7:DebuffUp(v18.ColossusSmashDebuff))) then
		if v11(v18.Avatar, true) then
			return "avatar slayer_aoe 8";
		end
	end
	if (v48 and IsChampionsSpear and v18.ChampionsSpear:IsCastable() and (v7:DebuffUp(v18.ColossusSmashDebuff) or v6:BuffUp(v18.AvatarBuff))) then
		if v10.CastTarget(v18.ChampionsSpear, v10.TName().PLAYER) then
			return "champions_spear slayer_aoe 10";
		end
	end
	if (v48 and IsBladestorm and v18.Ravager:IsCastable() and (v18.ColossusSmash:CooldownRemains() <= v6:GCD())) then
		if v10.CastTarget(v18.Ravager, v10.TName().PLAYER) then
			return "Ravager slayer_aoe 10";
		end
	end
	if (v18.ColossusSmash:IsCastable() and v48 and IsColossusSmash) then
		if v11(v18.ColossusSmash) then
			return "colossus_smash slayer_st 14";
		end
	end
	if (v18.Warbreaker:IsCastable() and v7:IsInRange(17 - 9) and IsColossusSmash) then
		if v11(v18.Warbreaker, true) then
			return "warbreaker slayer_aoe 12";
		end
	end
	if (v18.Execute:IsReady() and v48 and (((v6:BuffRemains(v18.JuggernautBuff) <= (v6:GCD() * (1415 - (447 + 966)))) and v18.Juggernaut:IsAvailable()) or (v6:BuffStack(v18.SuddenDeathBuff) == (5 - 3)) or (v6:BuffRemains(v18.SuddenDeathBuff) <= (v6:GCD() * (1820 - (1703 + 114)))) or (v7:DebuffStack(v18.MarkedforExecutionDebuff) == (704 - (376 + 325))))) then
		if v11(v18.Executecast) then
			return "execute slayer_aoe 20";
		end
	end
	if (v18.Overpower:IsCastable() and v48 and (v6:BuffUp(v18.OpportunistBuff))) then
		if v11(v18.Overpower) then
			return "overpower slayer_aoe 18";
		end
	end
	if (v18.MortalStrike:IsReady() and v48) then
		if v11(v18.MortalStrike) then
			return "mortal_strike slayer_aoe 28";
		end
	end
	if (v18.Bladestorm:IsCastable() and v48 and IsBladestorm and ((v18.ColossusSmash:CooldownRemains() >= (v6:GCD() * (5 - 1))) or (v18.Warbreaker:CooldownRemains() >= (v6:GCD() * (12 - 8))) or (v7:DebuffRemains(v18.ColossusSmashDebuff) >= (v6:GCD() * (2 + 2))))) then
		if v11(v18.Bladestormcast, true) then
			return "bladestorm slayer_st 24";
		end
	end
	if (v18.Skullsplitter:IsCastable() and v48) then
		if v11(v18.Skullsplitter) then
			return "skullsplitter slayer_st 26";
		end
	end
	if (v18.Overpower:IsCastable() and v48) then
		if v11(v18.Overpower) then
			return "overpower slayer_st 28";
		end
	end
	if (v18.Rend:IsCastable() and (v7:DebuffRemains(v18.RendDebuff) <= (17 - 9)) and v48) then
		if v11(v18.Rend) then
			return "rend slayer_st 30";
		end
	end
	if (v18.Execute:IsReady() and not v18.Juggernaut:IsAvailable() and v48) then
		if v11(v18.Executecast) then
			return "execute slayer_st 32";
		end
	end
	if (v18.Cleave:IsReady() and v48) then
		if v11(v18.Cleave) then
			return "cleave slayer_st 34";
		end
	end
	if (v18.Slam:IsReady() and v48) then
		if v11(v18.Slam) then
			return "slam slayer_st 36";
		end
	end
end
local function v72()
	if (v18.StormBolt:IsCastable() and v7:IsInRange(34 - (9 + 5)) and (v6:BuffUp(v18.Bladestorm))) then
		if v11(v18.StormBolt) then
			return "storm_bolt slayer_sweep 40";
		end
	end
	if (IsThunderousRoar and v48 and v18.ThunderousRoar:IsCastable() and v7:DebuffDown(v18.RendDebuff) and v6:BuffDown(v18.SweepingStrikesBuff)) then
		if v11(v18.ThunderousRoar) then
			return "thunderous_roar slayer_sweep 4";
		end
	end
	if (v18.ThunderousRoar:IsCastable() and v7:IsInMeleeRange(388 - (85 + 291)) and IsThunderousRoar) then
		if v11(v18.ThunderousRoar, true) then
			return "thunderous_roar slayer_sweep 2";
		end
	end
	if (v18.SweepingStrikes:IsCastable() and v48) then
		if v11(v18.SweepingStrikes) then
			return "sweeping_strikes slayer_sweep 4";
		end
	end
	if (v18.Rend:IsCastable() and v48 and (v7:DebuffRemains(v18.RendDebuff) <= v6:GCD())) then
		if v11(v18.Rend) then
			return "rend slayer_sweep 6";
		end
	end
	if (v18.ChampionsSpear:IsCastable() and v48 and IsChampionsSpear) then
		if v10.CastTarget(v18.ChampionsSpear, v10.TName().PLAYER) then
			return "champions_spear slayer_sweep 8";
		end
	end
	if (v18.Avatar:IsCastable() and v48 and IsAvatar) then
		if v11(v18.Avatar, true) then
			return "avatar slayer_sweep 10";
		end
	end
	if (v18.ColossusSmash:IsCastable() and v48 and IsColossusSmash) then
		if v11(v18.ColossusSmash, true) then
			return "colossus_smash slayer_sweep 12";
		end
	end
	if (v18.Warbreaker:IsCastable() and v7:IsInRange(1273 - (243 + 1022)) and IsColossusSmash) then
		if v11(v18.Warbreaker, true) then
			return "warbreaker slayer_sweep 14";
		end
	end
	if (v18.Skullsplitter:IsCastable() and v7:IsInMeleeRange(30 - 22) and (v6:BuffUp(v18.SweepingStrikesBuff))) then
		if v11(v18.Skullsplitter) then
			return "sweeping_strikes slayer_sweep 16";
		end
	end
	if (v18.Execute:IsReady() and v48 and ((v6:BuffRemains(v18.JuggernautBuff) <= (v6:GCD() * (2 + 0))) or (v7:DebuffStack(v18.MarkedforExecutionDebuff) == (1183 - (1123 + 57))) or (v6:BuffStack(v18.SuddenDeathBuff) == (2 + 0)) or (v6:BuffRemains(v18.SuddenDeathBuff) <= (v6:GCD() * (257 - (163 + 91)))))) then
		if v11(v18.Executecast) then
			return "execute slayer_sweep 18";
		end
	end
	if (v48 and IsBladestorm and v18.Bladestorm:IsCastable() and ((v18.ColossusSmash:CooldownRemains() >= (v6:GCD() * (1934 - (1869 + 61)))) or (v18.Warbreaker:CooldownRemains() >= (v6:GCD() * (2 + 2))) or (v7:DebuffRemains(v18.ColossusSmashDebuff) >= (v6:GCD() * (14 - 10))))) then
		if v11(v18.Bladestormcast, true) then
			return "bladestorm slayer_sweep 20";
		end
	end
	if (v18.Overpower:IsCastable() and v48 and (v6:BuffUp(v18.OpportunistBuff))) then
		if v11(v18.Overpower) then
			return "overpower slayer_sweep 22";
		end
	end
	if (v18.MortalStrike:IsReady() and v48) then
		if v11(v18.MortalStrike) then
			return "mortal_strike slayer_sweep 24";
		end
	end
	if (v18.Overpower:IsCastable() and v48) then
		if v11(v18.Overpower) then
			return "overpower slayer_sweep 30";
		end
	end
	if (v18.ThunderClap:IsReady() and v48 and (v7:DebuffRemains(v18.RendDebuff) < (12 - 4)) and v6:BuffDown(v18.SweepingStrikesBuff)) then
		if v11(v18.ThunderClap) then
			return "thunder_clap slayer_sweep 32";
		end
	end
	if (v18.Rend:IsCastable() and v48 and (v7:DebuffRemains(v18.RendDebuff) <= (1 + 4))) then
		if v11(v18.Rend) then
			return "rend slayer_sweep 34";
		end
	end
	if (v18.Cleave:IsReady() and v48 and v18.FervorofBattle:IsAvailable() and v6:BuffDown(v18.MartialProwessBuff)) then
		if v11(v18.Cleave) then
			return "cleave slayer_sweep 36";
		end
	end
	if (v18.Whirlwind:IsReady() and v48 and (v18.FervorofBattle:IsAvailable())) then
		if v11(v18.Whirlwind) then
			return "whirlwind slayer_sweep 36";
		end
	end
	if (v18.Execute:IsReady() and v48 and not v18.Juggernaut:IsAvailable()) then
		if v11(v18.Executecast) then
			return "execute slayer_sweep 40";
		end
	end
	if (v18.Slam:IsReady() and v48) then
		if v11(v18.Slam) then
			return "slam slayer_sweep 38";
		end
	end
end
local function v73()
	if (v23.Commons.Enabled.Items and IsWeapon and v48 and not v6:IsMoving() and v19.Fyralath:IsEquippedAndReady() and (((v18.MarkofFyralathDebuff:AuraActiveCount() > (0 - 0)) and not v18.BlademastersTorment:IsAvailable()) or ((v18.MarkofFyralathDebuff:AuraActiveCount() > (0 + 0)) and (v18.Avatar:CooldownRemains() > (1477 - (1329 + 145))) and (v18.Bladestorm:CooldownRemains() > (974 - (140 + 831))) and v7:DebuffDown(v18.ColossusSmashDebuff)))) then
		v10.CastMacro(1851 - (1409 + 441), nil, nil, v19.Fyralath);
		return "weapon cast";
	end
	if v23.Commons.Enabled.Trinkets then
		if (v19.TreacherousTransmitter:IsEquippedAndReady() and (((v24:ID() == v19.TreacherousTransmitter:ID()) and IsTrinket1) or ((v25:ID() == v19.TreacherousTransmitter:ID()) and IsTrinket2)) and (v45 or v46) and (v18.Avatar:CooldownRemains() < (721 - (15 + 703)))) then
			if v11(v19.TreacherousTransmitter, true) then
				return "treacherous_transmitter trinkets 2";
			end
		end
		if (v24:IsReady() and v48 and IsTrinket1 and not v34 and ((v40 and not v42 and ((v6:BuffDown(v18.AvatarBuff) and (v30 > (0 + 0))) or (v30 == (438 - (262 + 176)))) and v6:BuffUp(v18.AvatarBuff) and (v37 or not v25:HasCooldown() or v33 or (v44 == (1722 - (345 + 1376))))) or (v24:BuffDuration() >= v52))) then
			if v11(v24, true) then
				return "use_item for " .. v24:Name() .. " trinkets 4";
			end
		end
		if (v25:IsReady() and v48 and IsTrinket2 and not v35 and ((v41 and not v43 and ((v6:BuffDown(v18.AvatarBuff) and (v31 > (688 - (198 + 490)))) or (v31 == (0 - 0))) and v6:BuffUp(v18.AvatarBuff) and (v36 or not v24:HasCooldown() or v32 or (v44 == (4 - 2)))) or (v25:BuffDuration() >= v52))) then
			if v11(v25, true) then
				return "use_item for " .. v25:Name() .. " trinkets 6";
			end
		end
		if (v24:IsReady() and v48 and IsTrinket1 and not v34 and not v40 and (((v30 > (1206 - (696 + 510))) and v6:BuffDown(v18.AvatarBuff)) or (v30 == (0 - 0))) and not v42 and ((not v40 and (v33 or not v41)) or ((v30 > (1262 - (1091 + 171))) and v6:BuffDown(v18.AvatarBuff)) or (v30 == (0 + 0)) or (v18.Avatar:CooldownRemains() > (62 - 42)))) then
			if v11(v24, true) then
				return "use_item for " .. v24:Name() .. " trinkets 8";
			end
		end
		if (v25:IsReady() and v48 and IsTrinket2 and not v35 and not v41 and (((v31 > (0 - 0)) and v6:BuffDown(v18.AvatarBuff)) or (v31 == (374 - (123 + 251)))) and not v43 and ((not v41 and (v32 or not v40)) or ((v31 > (0 - 0)) and v6:BuffDown(v18.AvatarBuff)) or (v31 == (698 - (208 + 490))) or (v18.Avatar:CooldownRemains() > (2 + 18)))) then
			if v11(v25, true) then
				return "use_item for " .. v25:Name() .. " trinkets 10";
			end
		end
	end
	if v23.Commons.Enabled.Items then
		local v101, v102, v103 = v6:GetUseableItems(v20, 8 + 8);
		if (v101 and v101:IsReady() and IsWeapon and v7:IsInRange(v103) and not v19.Fyralath:IsEquipped() and (not v40 or v32) and (not v41 or v33)) then
			v10.CastMacro(837 - (660 + 176));
			return "weapon cast";
		end
	end
end
local function v74()
	v46 = v50 == (1 + 0);
	v45 = v50 >= (204 - (14 + 188));
	v47 = (v18.Massacre:IsAvailable() and (v7:HealthPercentage() < (710 - (534 + 141)))) or (v7:HealthPercentage() < (9 + 11));
end
local function v75()
	Smallcds = v10.ToggleIconFrame:GetToggle(1 + 0);
	AutoStance = v10.ToggleIconFrame:GetToggle(2 + 0);
	InterruptToggle = v10.ToggleIconFrame:GetToggle(6 - 3);
	Lowlevel = not v18.SlayersDominance:IsAvailable() and not v18.Demolish:IsAvailable();
	v49 = v6:GetEnemiesInMeleeRange(12 - 4);
	if v12() then
		v50 = #v49;
	else
		v50 = 2 - 1;
	end
	IsAvatar = v62(v23.Arms_TTD.AvatarTTD) and v61(v23.Arms_CDUSE.Avatar);
	IsRacials = v62(v23.Arms_TTD.RacialsTTD) and v61(v23.Arms_CDUSE.Racials);
	IsPotions = v62(v23.Arms_TTD.PotionsTTD) and (v23.Arms_CDUSE.Potionswhensolo or (not v23.Arms_CDUSE.Potionswhensolo and not v21.ISSolo())) and v61(v23.Arms_CDUSE.Potions);
	IsTrinket1 = v62(v23.Arms_TTD.TrinketsTTD) and v61(v23.Arms_CDUSE.Trinket1);
	IsTrinket2 = v62(v23.Arms_TTD.TrinketsTTD) and v61(v23.Arms_CDUSE.Trinket2);
	IsColossusSmash = v62(v23.Arms_TTD.ColossusSmashTTD) and v61(v23.Arms_CDUSE.ColossusSmash);
	IsWarbreaker = v62(v23.Arms_TTD.ColossusSmashTTD) and v61(v23.Arms_CDUSE.Warbreaker);
	IsThunderousRoar = v62(v23.Arms_TTD.ThunderousRoarTTD) and v61(v23.Arms_CDUSE.ThunderousRoar);
	IsChampionsSpear = v62(v23.Arms_TTD.ChampionsSpearTTD) and v61(v23.Arms_CDUSE.ChampionsSpear);
	IsBladestorm = v62(v23.Arms_TTD.BladestormTTD) and v61(v23.Arms_CDUSE.Bladestorm);
	IsWeapon = v62(v23.Arms_TTD.WeaponTTD) and v61(v23.Arms_CDUSE.Weapon);
	IsDemolish = v62(v23.Arms_TTD.DemolishTTD) and v61(v23.Arms_CDUSE.Demolish);
	local v97 = 0 + 0;
	if v18.RumblingEarth:IsAvailable() then
		v97 = 11 + 5;
	else
		v97 = 406 - (115 + 281);
	end
	if (v21.TargetIsValid() or v6:AffectingCombat()) then
		v48 = v7:IsSpellInRange(v18.MortalStrike);
		v51 = v3.BossFightRemains();
		v58 = true;
		v52 = v51;
		if (v52 == (25844 - 14733)) then
			v58 = false;
			v52 = v3.FightRemains(v49, false);
		end
	end
	if (v18.BattleShout:IsCastable() and not v6:DebuffUp(v18.Corruption) and ((v21.GroupBuffMissing(v18.BattleShoutBuff, true) and (v23.Commons.BattleShout == "check whole group") and (v6:IsInRaidArea() or v6:IsInDungeonArea())) or (v6:BuffDown(v18.BattleShoutBuff, true) and ((v23.Commons.BattleShout == "only check us") or (v23.Commons.BattleShout == "check whole group")))) and not v6:IsMounted()) then
		if v10.Cast(v18.BattleShout) then
			return "BattleShout";
		end
	end
	if v23.Commons.CCIncorperal then
		v17 = v21.IncorpCycle(v18.IntimidatingShout, 7 + 1, false, false);
		v17 = v21.IncorpCycle(v18.StormBolt, 48 - 28, false, false);
		if v17 then
			return v17;
		end
	end
	local v98 = v6:IncomingSpell(Warrior.SpellReflectList);
	local v99 = v6:IncomingSpellreflection(Warrior.SpellReflectList);
	if (v99 and v10.DebugON()) then
		print("Spell Reflect Cast: " .. v99);
	end
	local v100 = v6:BuffUp(v18.SpellReflection) or (v98 and v18.SpellReflection:IsReady() and v23.Commons.AutoSpellreflection);
	if (v18.SpellReflection:IsReady() and v99 and v23.Commons.AutoSpellreflection) then
		if v11(v18.SpellReflection, true) then
			return "Spell Reflection";
		end
	end
	v17 = v63();
	if v17 then
		return v17;
	end
	if (v18.BattleStance:IsCastable() and AutoStance and v6:BuffDown(v18.BattleStance, true) and (v6:HealthPercentage() > v23.Arms_Defensives.BattleStanceHP)) then
		if v11(v18.BattleStance) then
			return "battle_stance precombat 6";
		end
	end
	if v21.TargetIsValid() then
		if (not v23.Arms.AttackonlyinCombat or (v23.Arms.AttackonlyinCombat and v7:AffectingCombat())) then
			if not v57(v5.Target) then
				if not v6:AffectingCombat() then
					v17 = v64();
					if v17 then
						return v17;
					end
				end
				if (v23.Commons.Enabled.Potions and IsPotions and ((v7:DebuffRemains(v18.ColossusSmashDebuff) > (29 - 21)) or (v51 < (892 - (550 + 317)))) and v48) then
					local v104 = v21.PotionSelected();
					if (v104 and v104:IsReady()) then
						v10.CastMacro(3 - 0, nil, nil, v104);
						return "Cast Potion";
					end
				end
				if (InterruptToggle and not v100) then
					v17 = v21.InterruptCycle(v18.Pummel, 7 - 2, true, nil, false);
					if v17 then
						return v17;
					end
					v17 = v23.Interrupt.UseStormbolt and v21.InterruptCycle(v18.StormBolt, 55 - 35, false, nil, true);
					if v17 then
						return v17;
					end
					v17 = v23.Interrupt.UseShockwave and v21.InterruptCycle(v18.Shockwave, v97, false, nil, true, true);
					if v17 then
						return v17;
					end
				end
				if v17 then
					return v17;
				end
				v74();
				if (v23.Commons.Enabled.Trinkets or v23.Commons.Enabled.Items) then
					v17 = v73();
					if v17 then
						return v17;
					end
				end
				if (v18.WreckingThrow:IsCastable() and v48 and (v7:BuffUp(v18.CorruptBuff) or v7:BuffUp(v18.SupernovaBuff))) then
					if v11(v18.WreckingThrow) then
						return "Wrecking Throw Shield";
					end
				end
				if (v18.ArcaneTorrent:IsCastable() and IsRacials and v7:IsInRange(293 - (134 + 151)) and (v18.MortalStrike:CooldownRemains() > (1666.5 - (970 + 695))) and (v6:Rage() < (95 - 45))) then
					if v11(v18.ArcaneTorrent, true) then
						return "arcane_torrent main 8";
					end
				end
				if (v18.LightsJudgment:IsCastable() and IsRacials and v7:IsSpellInRange(v18.LightsJudgment) and v7:DebuffDown(v18.ColossusSmashDebuff) and not v18.MortalStrike:CooldownUp()) then
					if v11(v18.LightsJudgment, true) then
						return "lights_judgment main 10";
					end
				end
				if (v18.BagofTricks:IsCastable() and IsRacials and v7:IsSpellInRange(v18.BagofTricks) and v7:DebuffDown(v18.ColossusSmashDebuff) and not v18.MortalStrike:CooldownUp()) then
					if v11(v18.BagofTricks, true) then
						return "bag_of_tricks main 12";
					end
				end
				if (v18.Berserking:IsCastable() and IsRacials and (((v7:TimeToDie() > (2170 - (582 + 1408))) and v6:BuffUp(v18.AvatarBuff)) or ((v7:TimeToDie() < (624 - 444)) and v47 and v6:BuffUp(v18.AvatarBuff)) or (v7:TimeToDie() < (25 - 5)))) then
					if v11(v18.Berserking, true) then
						return "berserking main 14";
					end
				end
				if (v18.BloodFury:IsCastable() and IsRacials and (v7:DebuffUp(v18.ColossusSmashDebuff))) then
					if v11(v18.BloodFury, true) then
						return "blood_fury main 16";
					end
				end
				if (v18.Fireblood:IsCastable() and IsRacials and (v7:DebuffUp(v18.ColossusSmashDebuff))) then
					if v11(v18.Fireblood, true) then
						return "fireblood main 18";
					end
				end
				if (v18.AncestralCall:IsCastable() and IsRacials and (v7:DebuffUp(v18.ColossusSmashDebuff))) then
					if v11(v18.AncestralCall, true) then
						return "ancestral_call main 20";
					end
				end
				if (v18.Demolish:IsAvailable() and v12() and (v50 > (7 - 5))) then
					local v105 = v65();
					if v105 then
						return v105;
					end
					if v10.CastAnnotated(v18.Pool, false, "WAIT") then
						return "Pool for ColossusAoE()";
					end
				end
				if (v18.Demolish:IsAvailable() and v47) then
					local v106 = v66();
					if v106 then
						return v106;
					end
					if v10.CastAnnotated(v18.Pool, false, "WAIT") then
						return "Pool for ColossusExecute()";
					end
				end
				if (v18.Demolish:IsAvailable() and v12() and (v50 == (1826 - (1195 + 629))) and not v47) then
					local v107 = v68();
					if v107 then
						return v107;
					end
					if v10.CastAnnotated(v18.Pool, false, "WAIT") then
						return "Pool for ColossusSweep()";
					end
				end
				if v18.Demolish:IsAvailable() then
					local v108 = v67();
					if v108 then
						return v108;
					end
					if v10.CastAnnotated(v18.Pool, false, "WAIT") then
						return "Pool for ColossusST()";
					end
				end
				if ((v18.SlayersDominance:IsAvailable() or Lowlevel) and v12() and (v50 > (2 - 0))) then
					local v109 = v69();
					if v109 then
						return v109;
					end
					if v10.CastAnnotated(v18.Pool, false, "WAIT") then
						return "Pool for SlayerAoE()";
					end
				end
				if ((v18.SlayersDominance:IsAvailable() or Lowlevel) and v47) then
					local v110 = v70();
					if v110 then
						return v110;
					end
					if v10.CastAnnotated(v18.Pool, false, "WAIT") then
						return "Pool for SlayerExecute()";
					end
				end
				if ((v18.SlayersDominance:IsAvailable() or Lowlevel) and v12() and (v50 == (243 - (187 + 54))) and not v47) then
					local v111 = v72();
					if v111 then
						return v111;
					end
					if v10.CastAnnotated(v18.Pool, false, "WAIT") then
						return "Pool for SlayerSweep()";
					end
				end
				if (v18.SlayersDominance:IsAvailable() or Lowlevel) then
					local v112 = v71();
					if v112 then
						return v112;
					end
					if v10.CastAnnotated(v18.Pool, false, "WAIT") then
						return "Pool for SlayerST()";
					end
				end
				if v10.CastAnnotated(v18.Pool, false, "WAIT") then
					return "Wait/Pool Resources";
				end
			end
		end
	end
end
local function v76()
	v10.ResetToggle();
	v23.Arms.Display();
	v18.MarkofFyralathDebuff:RegisterAuraTracking();
	v10:UpdateMacro("macro1", "/use 16");
	v10.ToggleIconFrame:AddButtonCustom("S", 781 - (162 + 618), "smallCDs", "smallcds");
	v10.ToggleIconFrame:AddButtonCustom("A", 2 + 0, "Auto Stance", "autostance");
	v10.ToggleIconFrame:AddButtonCustom("I", 2 + 1, "Interrupt", "interrupt");
	v21.PostInitialMessage(151 - 80);
end
v10.SetAPL(119 - 48, v75, v76);
