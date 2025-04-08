local v0, v1 = ...;
local v2 = HeroDBC.DBC;
local v3 = HeroLib;
local v4 = v3.Unit;
local v5 = v4.Player;
local v6 = v4.Target;
local v7 = v3.Spell;
local v8 = v3.Item;
local v9 = HeroRotation();
local v10 = v9.Cast;
local v11 = v9.AoEON;
local v12 = v9.CDsON;
local v13 = v4.MouseOver;
local v14 = v9.Commons().Everyone.num;
local v15 = v9.Commons().Everyone.bool;
local v16 = math.floor;
local v17 = C_Timer.After;
local v18;
local v19 = v7.Warrior.Protection;
local v20 = v8.Warrior.Protection;
local v21 = {};
local v22;
local v23;
local v24;
local v25 = 34738 - 23627;
local v26 = 31797 - 20686;
local v27 = v9.Commons().Everyone;
local v28 = v9.GUISettingsGet();
local v29 = {General=v28.General,Commons=v28.APL.Warrior.Commons,Protection=v28.APL.Warrior.Protection,Prot_Defensives=v28.APL.Warrior.Protection.Defensives,Protection_TTD=v28.APL.Warrior.Protection_TTD,Protection_CDUSE=v28.APL.Warrior.Protection_CDUSE,Interrupt=v28.APL.Warrior.Protection_Interrupt.Interrupt};
v3:RegisterForEvent(function()
	v25 = 21447 - 10336;
	v26 = 28620 - 17509;
end, "PLAYER_REGEN_ENABLED");
local v30 = v5:GetEquipment();
local v31 = (v30[632 - (555 + 64)] and v8(v30[944 - (857 + 74)])) or v8(568 - (367 + 201));
local v32 = (v30[941 - (214 + 713)] and v8(v30[4 + 10])) or v8(0 + 0);
v3:RegisterForEvent(function()
	v30 = v5:GetEquipment();
	v31 = (v30[890 - (282 + 595)] and v8(v30[1650 - (1523 + 114)])) or v8(0 + 0);
	v32 = (v30[19 - 5] and v8(v30[1079 - (68 + 997)])) or v8(1270 - (226 + 1044));
end, "PLAYER_EQUIPMENT_CHANGED");
local v33;
local function v34(v52)
	return (v52 ~= "Not Used") and ((((v52 == "with Cooldowns") or ((v52 == "small CDs") and v29.Protection_CDUSE.smallcdswithCooldowns) or (v52 == "with Cooldowns or AoE") or (v52 == "on Enemycount or Cooldowns") or (v52 == "on Boss or with Cooldowns")) and v12()) or (v52 == "always") or (((v52 == "on Boss only") or (v52 == "on Boss or on Enemycount") or (v52 == "on Boss or with Cooldowns")) and (v33 or v6:IsDummy())) or ((v52 == "with Bloodlust only") and v5:BloodlustUp()) or ((v52 == "small CDs") and Smallcds) or (((v52 == "on AOE") or (v52 == "with Cooldowns or AoE")) and v11() and (v24 >= (8 - 6))) or (((v52 == "on Enemycount or Cooldowns") or (v52 == "on Enemycount") or (v52 == "on Boss or on Enemycount")) and (v24 >= v29.Protection_CDUSE.Enemycount) and v11()));
end
local function v35(v53)
	return (v33 and v29.Protection_TTD.IgnoreWhenBoss) or v27.Buggedmobs[v6:NPCID()] or (v27.ISSolo() and v29.Protection_TTD.IgnoreWhenSolo) or (v53 == (117 - (32 + 85))) or ((v26 >= v53) and (v26 < (7622 + 155)));
end
local v36 = {{v19.IntimidatingShout,"Cast Intimidating Shout (Interrupt)",function()
	return true;
end}};
local function v37()
	return v20.ManicGrieftorch:IsEquipped() and (v20.ManicGrieftorch:CooldownUp() or (v20.ManicGrieftorch:CooldownRemains() <= v5:GCDRemains()));
end
local function v38()
	return v5:IsTankingAoE(28 - 12) or v5:IsTanking(v6) or v6:IsDummy();
end
local function v39()
	if v5:BuffUp(v19.IgnorePain) then
		local v66 = C_UnitAuras.GetPlayerAuraBySpellID(v19.IgnorePain:ID());
		local v67 = v66.points[351 - (87 + 263)];
		return v29.Protection.AllowIPOvercap or (v67 < (v5:MaxHealth() * (180.1 - (67 + 113))));
	else
		return true;
	end
end
local function v40()
	if v5:BuffUp(v19.IgnorePain) then
		local v68 = C_UnitAuras.GetPlayerAuraBySpellID(v19.IgnorePain:ID());
		return v68.points[1 + 0];
	else
		return 0 - 0;
	end
end
local function v41()
	return v38() and v19.ShieldBlock:IsReady() and (v5:BuffRemains(v19.ShieldBlockBuff) <= (8 + 2));
end
local function v42(v54)
	return (v54:IsSpellInRange(v19.HeroicThrow));
end
local function v43(v55)
	return v55:NPCID() == (813021 - 608461);
end
local function v44(v56)
	return v56:CastSpellID() == (409757 - (802 + 150));
end
local function v45(v57)
	local v58 = v29.Protection.RageCapValue;
	if ((v58 < (94 - 59)) or (v5:Rage() < (63 - 28))) then
		return false;
	end
	local v59 = false;
	local v60 = (v5:Rage() >= (26 + 9)) and not v41();
	if (v60 and (((v5:Rage() + v57) >= v58) or v19.DemoralizingShout:IsReady())) then
		v59 = true;
	end
	if v59 then
		if (v38() and v5:AffectingCombat() and (v39() or (v5:BuffRemains(v19.IgnorePain) <= (998 - (915 + 82)))) and v22) then
			if v10(v19.IgnorePain, true) then
				return "ignore_pain rage capped";
			end
		elseif v10(v19.Revenge) then
			return "revenge rage capped";
		end
	end
end
local function v46()
	local v61 = v5:IncomingSpell(v27.TankBustersList2);
	if (v61 and v9.DebugON()) then
		print("Tank Buster: " .. v61);
	end
	if (v19.VictoryRush:IsCastable() and v22 and v5:CanAttack(v6) and v5:BuffUp(v19.VictoriousBuff) and (v5:HealthPercentageWeighted() <= v29.Protection.Defensives.VictoryRushHP)) then
		if v10(v19.VictoryRush) then
			return "VictoryRush";
		end
	end
	if (v19.ImpendingVictory:IsCastable() and v22 and v5:CanAttack(v6) and v5:AffectingCombat() and (v5:HealthPercentageWeighted() <= v29.Protection.Defensives.ImpendingVictoryHP)) then
		if v10(v19.ImpendingVictory) then
			return "ImpendingVictory";
		end
	end
	if (v19.BitterImmunity:IsCastable() and v5:AffectingCombat() and (v5:HealthPercentageWeighted() <= v29.Protection.Defensives.BitterImmunityHP)) then
		if v10(v19.BitterImmunity) then
			return "BitterImmunity";
		end
	end
	if (v19.ShieldWall:IsCastable() and v5:AffectingCombat() and v38() and ((v5:HealthPercentageWeighted() <= v29.Protection.Defensives.ShieldWallHP) or (IsShieldWall and (v3.CombatTime() < (14 - 9)))) and v5:BuffDown(v19.LastStandBuff)) then
		if v10(v19.ShieldWall) then
			return "ShieldWall";
		end
	end
	if (v19.LastStand:IsCastable() and v5:AffectingCombat() and v38() and ((v5:HealthPercentageWeighted() <= v29.Protection.Defensives.LastStandHP) or (IsLastStand and (v3.CombatTime() < (3 + 2)))) and v5:BuffDown(v19.ShieldWallBuff)) then
		if v10(v19.LastStand) then
			return "last_stand main 24";
		end
	end
	if (v41() and v5:AffectingCombat() and (v5:BuffRemains(v19.ShieldBlockBuff) <= (13 - 3)) and ((v5:HealthPercentageWeighted() <= v29.Protection.Defensives.ShieldBlockHP) or v61)) then
		if v10(v19.ShieldBlock, true) then
			return "ShieldBlock";
		end
	end
	if (v19.IgnorePain:IsReady() and v5:AffectingCombat() and (v39() or (v5:BuffRemains(v19.IgnorePain) <= (1188 - (1069 + 118)))) and (v5:HealthPercentageWeighted() <= v29.Protection.Defensives.IgnorePainHP) and (((v5:RageDeficit() <= (33 - 18)) and v19.ShieldSlam:CooldownUp()) or (v5:BuffRemains(v19.IgnorePain) <= (1 - 0)) or ((v5:RageDeficit() <= (7 + 33)) and v19.ShieldCharge:CooldownUp() and v19.ChampionsBulwark:IsAvailable()) or ((v5:RageDeficit() <= (35 - 15)) and v19.ShieldCharge:CooldownUp()) or ((v5:RageDeficit() <= (30 + 0)) and v19.DemoralizingShout:CooldownUp() and v19.BoomingVoice:IsAvailable()) or ((v5:RageDeficit() <= (811 - (368 + 423))) and v19.Avatar:CooldownUp()) or ((v5:RageDeficit() <= (141 - 96)) and v19.DemoralizingShout:CooldownUp() and v19.BoomingVoice:IsAvailable() and v5:BuffUp(v19.LastStandBuff) and v19.UnnervingFocus:IsAvailable()) or ((v5:RageDeficit() <= (48 - (10 + 8))) and v19.Avatar:CooldownUp() and v5:BuffUp(v19.LastStandBuff) and v19.UnnervingFocus:IsAvailable()) or (v5:RageDeficit() <= (76 - 56)) or ((v5:RageDeficit() <= (482 - (416 + 26))) and v19.ShieldSlam:CooldownUp() and v5:BuffUp(v19.ViolentOutburstBuff) and v19.HeavyRepercussions:IsAvailable() and v19.ImpenetrableWall:IsAvailable()) or ((v5:RageDeficit() <= (175 - 120)) and v19.ShieldSlam:CooldownUp() and v5:BuffUp(v19.ViolentOutburstBuff) and v5:BuffUp(v19.LastStandBuff) and v19.UnnervingFocus:IsAvailable() and v19.HeavyRepercussions:IsAvailable() and v19.ImpenetrableWall:IsAvailable()) or ((v5:RageDeficit() <= (8 + 9)) and v19.ShieldSlam:CooldownUp() and v19.HeavyRepercussions:IsAvailable()) or ((v5:RageDeficit() <= (31 - 13)) and v19.ShieldSlam:CooldownUp() and v19.ImpenetrableWall:IsAvailable()) or (((v5:Rage() >= (508 - (145 + 293))) or ((v5:BuffStack(v19.SeeingRedBuff) == (437 - (44 + 386))) and (v5:Rage() >= (1521 - (998 + 488))))) and (v19.ShieldSlam:CooldownRemains() <= (1 + 0)) and (v5:BuffRemains(v19.ShieldBlockBuff) >= (4 + 0)) and v5:HasTier(803 - (201 + 571), 1140 - (116 + 1022))))) then
		if v10(v19.IgnorePain, true) then
			return "ignore_pain main 22";
		end
	end
	if AutoStance then
		if (v19.DefensiveStance:IsCastable() and v5:BuffUp(v19.BattleStance) and (v5:HealthPercentage() <= v29.Prot_Defensives.DefStanceHP)) then
			if v10(v19.DefensiveStance, true) then
				return "BearForm";
			end
		end
		if (v19.BattleStance:IsCastable() and v5:BuffUp(v19.DefensiveStance) and (v5:HealthPercentage() > v29.Prot_Defensives.BattleStanceHP) and (v29.Prot_Defensives.BattleStanceHP > (0 - 0))) then
			if v10(v19.BattleStance, true) then
				return "MoonkinForm";
			end
		end
	end
end
local function v47()
	if v6:IsInMeleeRange(8 + 4) then
		if v19.ThunderClap:IsCastable() then
			if v10(v19.ThunderClap) then
				return "thunder_clap precombat 6";
			end
		end
	else
	end
end
local function v48()
	if (v6:DebuffRemains(v19.RendDebuff) <= (3 - 2)) then
		if (v19.ThunderBlastAbility:IsReady() and v6:IsInMeleeRange(28 - 20)) then
			v45(864 - (814 + 45));
			if v10(v19.ThunderBlastAbility) then
				return "thunder_blast aoe 2";
			end
		end
		if (v19.ThunderClap:IsCastable() and v6:IsInMeleeRange(19 - 11) and (v6:DebuffRemains(v19.RendDebuff) <= (1 + 0))) then
			v45(2 + 3);
			if v10(v19.ThunderClap) then
				return "thunder_clap aoe 4";
			end
		end
	end
	if (v5:BuffUp(v19.ViolentOutburstBuff) and (v24 > (891 - (261 + 624))) and v5:BuffUp(v19.Avatar) and v19.UnstoppableForce:IsAvailable()) then
		if (v19.ThunderBlastAbility:IsReady() and (v24 > (3 - 1)) and v6:IsInMeleeRange(1088 - (1020 + 60))) then
			v45(1428 - (630 + 793));
			if v10(v19.ThunderBlastAbility) then
				return "thunder_blast aoe 6";
			end
		end
		if (v19.ThunderClap:IsCastable() and (v24 > (19 - 13)) and v6:IsInMeleeRange(37 - 29)) then
			v45(2 + 3);
			if v10(v19.ThunderClap) then
				return "thunder_clap aoe 8";
			end
		end
	end
	if (v19.Revenge:IsReady() and v22 and (v5:Rage() >= (241 - 171)) and v19.SeismicReverberation:IsAvailable() and (v24 >= (1750 - (760 + 987)))) then
		if v10(v19.Revenge) then
			return "revenge aoe 10";
		end
	end
	if (v19.ShieldSlam:IsCastable() and v22 and ((v5:Rage() <= (1973 - (1789 + 124))) or (v5:BuffUp(v19.ViolentOutburstBuff) and (v24 <= (770 - (745 + 21))) and v19.CrashingThunder:IsAvailable()))) then
		v45(7 + 13);
		if v10(v19.ShieldSlam) then
			return "shield_slam aoe 12";
		end
	end
	if (v19.ThunderBlastAbility:IsReady() and v6:IsInMeleeRange(21 - 13)) then
		v45(19 - 14);
		if v10(v19.ThunderBlastAbility) then
			return "thunder_blast aoe 14";
		end
	end
	if (v19.ThunderClap:IsCastable() and v6:IsInMeleeRange(1 + 7)) then
		v45(4 + 1);
		if v10(v19.ThunderClap) then
			return "thunder_clap aoe 16";
		end
	end
	if (v19.Revenge:IsReady() and v22 and ((v5:Rage() >= (1085 - (87 + 968))) or ((v5:Rage() >= (176 - 136)) and v19.BarbaricTraining:IsAvailable()))) then
		if v10(v19.Revenge) then
			return "revenge aoe 14";
		end
	end
end
local function v49()
	if (v19.ThunderBlastAbility:IsReady() and v6:IsInMeleeRange(8 + 0) and (v5:BuffStack(v19.ThunderBlastBuff) == (4 - 2)) and (v5:BuffStack(v19.BurstofPowerBuff) <= (1414 - (447 + 966))) and v5:BuffUp(v19.Avatar) and v19.UnstoppableForce:IsAvailable()) then
		v45(13 - 8);
		if v10(v19.ThunderBlastAbility) then
			return "thunder_blast generic 2";
		end
	end
	if (v19.ShieldSlam:IsCastable() and v22 and (((v5:BuffStack(v19.BurstofPowerBuff) == (1819 - (1703 + 114))) and (v5:BuffStack(v19.ThunderBlastBuff) <= (702 - (376 + 325)))) or v5:BuffUp(v19.ViolentOutburstBuff) or ((v5:Rage() <= (114 - 44)) and v19.Demolish:IsAvailable()))) then
		v45(61 - 41);
		if v10(v19.ShieldSlam) then
			return "shield_slam generic 4";
		end
	end
	if (v19.Execute:IsReady() and v22 and ((v5:Rage() >= (21 + 49)) or ((v5:Rage() >= (88 - 48)) and v19.ShieldSlam:CooldownDown() and v19.Demolish:IsAvailable()) or ((v5:Rage() >= (64 - (9 + 5))) and v19.ShieldSlam:CooldownDown()) or (v5:BuffUp(v19.SuddenDeathBuff) and v19.SuddenDeath:IsAvailable()))) then
		if v10(v19.Executecast) then
			return "execute generic 6";
		end
	end
	if (v19.ShieldSlam:IsCastable() and v22) then
		v45(396 - (85 + 291));
		if v10(v19.ShieldSlam) then
			return "shield_slam generic 8";
		end
	end
	if (v19.ThunderBlastAbility:IsReady() and v6:IsInMeleeRange(1273 - (243 + 1022))) then
		v45(19 - 14);
		if v10(v19.ThunderBlastAbility) then
			return "thunder_blast generic 10";
		end
	end
	if (v19.ThunderClap:IsCastable() and v6:IsInMeleeRange(7 + 1) and (v6:DebuffRemains(v19.RendDebuff) <= (1182 - (1123 + 57))) and v5:BuffDown(v19.ViolentOutburstBuff)) then
		v45(5 + 0);
		if v10(v19.ThunderClap) then
			return "thunder_clap generic 12";
		end
	end
	if (v19.ThunderClap:IsCastable() and v6:IsInMeleeRange(262 - (163 + 91)) and ((v24 > (1931 - (1869 + 61))) or (v19.ShieldSlam:CooldownDown() and v5:BuffDown(v19.ViolentOutburstBuff)))) then
		v45(2 + 3);
		if v10(v19.ThunderClap) then
			return "thunder_clap generic 14";
		end
	end
	if (v19.Revenge:IsReady() and v22 and (((v5:Rage() >= (281 - 201)) and (v6:HealthPercentage() > (30 - 10))) or (v5:BuffUp(v19.RevengeBuff) and (v6:HealthPercentage() <= (3 + 17)) and (v5:Rage() <= (24 - 6)) and v19.ShieldSlam:CooldownDown()) or (v5:BuffUp(v19.RevengeBuff) and (v6:HealthPercentage() > (19 + 1))) or ((((v5:Rage() >= (1554 - (1329 + 145))) and (v6:HealthPercentage() > (1006 - (140 + 831)))) or (v5:BuffUp(v19.RevengeBuff) and (v6:HealthPercentage() <= (1885 - (1409 + 441))) and (v5:Rage() <= (736 - (15 + 703))) and v19.ShieldSlam:CooldownDown()) or (v5:BuffUp(v19.RevengeBuff) and (v6:HealthPercentage() > (17 + 18)))) and v19.Massacre:IsAvailable()))) then
		if v10(v19.Revenge) then
			return "revenge generic 16";
		end
	end
	if (v19.Execute:IsReady() and v22) then
		if v10(v19.Executecast) then
			return "execute generic 18";
		end
	end
	if (v19.Revenge:IsReady() and v22) then
		if v10(v19.Revenge) then
			return "revenge generic 20";
		end
	end
	if ((v24 >= (439 - (262 + 176))) or (v19.ShieldSlam:CooldownDown() and v5:BuffUp(v19.ViolentOutburstBuff))) then
		if (v19.ThunderBlastAbility:IsReady() and v6:IsInMeleeRange(1729 - (345 + 1376))) then
			v45(693 - (198 + 490));
			if v10(v19.ThunderBlastAbility) then
				return "thunder_blast generic 22";
			end
		end
		if (v19.ThunderClap:IsCastable() and v6:IsInMeleeRange(35 - 27)) then
			v45(11 - 6);
			if v10(v19.ThunderClap) then
				return "thunder_clap generic 24";
			end
		end
	end
	if (v19.Devastate:IsCastable() and v22) then
		if v10(v19.Devastate) then
			return "devastate generic 26";
		end
	end
end
local function v50()
	v27.HealthPotions();
	Enemies30Yard = v5:GetEnemiesInRange(1236 - (696 + 510));
	v23 = v5:GetEnemiesInMeleeRange(16 - 8);
	if v11() then
		v24 = #v23;
	else
		v24 = 1263 - (1091 + 171);
	end
	Smallcds = v9.ToggleIconFrame:GetToggle(1 + 0);
	AutoStance = v9.ToggleIconFrame:GetToggle(6 - 4);
	InterruptToggle = v9.ToggleIconFrame:GetToggle(9 - 6);
	IsAvatar = v35(v29.Protection_TTD.AvatarTTD) and v34(v29.Protection_CDUSE.Avatar);
	IsRacials = v35(v29.Protection_TTD.RacialsTTD) and v34(v29.Protection_CDUSE.Racials);
	IsPotions = v35(v29.Protection_TTD.PotionsTTD) and (v29.Protection_CDUSE.Potionswhensolo or (not v29.Protection_CDUSE.Potionswhensolo and not v27.ISSolo())) and v34(v29.Protection_CDUSE.Potions);
	IsTrinket1 = v35(v29.Protection_TTD.TrinketsTTD) and v34(v29.Protection_CDUSE.Trinket1);
	IsTrinket2 = v35(v29.Protection_TTD.TrinketsTTD) and v34(v29.Protection_CDUSE.Trinket2);
	IsRavager = v35(v29.Protection_TTD.RavagerTTD) and v34(v29.Protection_CDUSE.Ravager);
	IsThunderousRoar = v35(v29.Protection_TTD.ThunderousRoarTTD) and v34(v29.Protection_CDUSE.ThunderousRoar);
	IsChampionsSpear = v35(v29.Protection_TTD.ChampionsSpearTTD) and v34(v29.Protection_CDUSE.ChampionsSpear);
	IsDemolish = v35(v29.Protection_TTD.DemolishTTD) and v34(v29.Protection_CDUSE.Demolish);
	IsDemoralizingShout = v35(v29.Protection_TTD.DemoralizingShoutTTD) and v34(v29.Protection_CDUSE.DemoralizingShout);
	IsLastStand = v34(v29.Protection_CDUSE.LastStand);
	IsShieldWall = v34(v29.Protection_CDUSE.ShieldWall);
	local v62 = 374 - (123 + 251);
	if v19.RumblingEarth:IsAvailable() then
		v62 = 79 - 63;
	else
		v62 = 708 - (208 + 490);
	end
	if (v27.TargetIsValid() or v5:AffectingCombat()) then
		v25 = v3.BossFightRemains();
		v33 = true;
		v26 = v25;
		if (v26 == (938 + 10173)) then
			v33 = false;
			v26 = v3.FightRemains(v23, false);
		end
	end
	if (v27.TargetIsValid() or v5:AffectingCombat()) then
		v22 = v6:IsInMeleeRange(3 + 2);
	end
	if (v19.BattleShout:IsCastable() and not v5:DebuffUp(v19.Corruption) and ((v27.GroupBuffMissing(v19.BattleShoutBuff, true) and (v29.Commons.BattleShout == "check whole group") and (v5:IsInRaidArea() or v5:IsInDungeonArea())) or (v5:BuffDown(v19.BattleShoutBuff, true) and ((v29.Commons.BattleShout == "only check us") or (v29.Commons.BattleShout == "check whole group")))) and not v5:IsMounted()) then
		if v9.Cast(v19.BattleShout) then
			return "BattleShout";
		end
	end
	if v29.Commons.CCIncorperal then
		v18 = v27.IncorpCycle(v19.IntimidatingShout, 844 - (660 + 176), false, false);
		v18 = v27.IncorpCycle(v19.StormBolt, 3 + 17, false, false);
		if v18 then
			return v18;
		end
	end
	local v63 = v5:IncomingSpell(Warrior.SpellReflectList);
	local v64 = v5:IncomingSpellreflection(Warrior.SpellReflectList);
	if (v64 and v9.DebugON()) then
		print("Spell Reflect Cast: " .. v64);
	end
	local v65 = v5:BuffUp(v19.SpellReflection) or ((v63 or v5:IncomingSpell(v27.TankBustersMagicList)) and v19.SpellReflection:IsReady() and v29.Commons.AutoSpellreflection);
	if (v19.SpellReflection:IsReady() and (v64 or v5:IncomingSpell(v27.TankBustersMagicList)) and v29.Commons.AutoSpellreflection) then
		if v10(v19.SpellReflection, true) then
			return "Spell Reflection";
		end
	end
	if (v19.BattleStance:IsCastable() and AutoStance and v5:BuffDown(v19.BattleStance, true) and (v5:HealthPercentage() > v29.Prot_Defensives.BattleStanceHP) and (v29.Protection.Stance == "Battle Stance")) then
		if v10(v19.BattleStance, true) then
			return "battle_stance precombat 6";
		end
	end
	if (v19.DefensiveStance:IsCastable() and AutoStance and v5:BuffDown(v19.DefensiveStance, true) and (v29.Protection.Stance == "Defensive Stance")) then
		if v10(v19.DefensiveStance, true) then
			return "DefensiveStance precombat 6";
		end
	end
	v18 = v46();
	if v18 then
		return v18;
	end
	if v27.TargetIsValid() then
		if (not v29.Protection.AttackonlyinCombat or (v29.Protection.AttackonlyinCombat and v6:AffectingCombat())) then
			if not v43(v4.Target) then
				if not v5:AffectingCombat() then
					v18 = v47();
					if v18 then
						return v18;
					end
				end
				if (InterruptToggle and not v65) then
					v18 = v27.InterruptCycle(v19.Pummel, 207 - (14 + 188), true, nil, false);
					if v18 then
						return v18;
					end
					v18 = v29.Interrupt.UseStormbolt and v27.InterruptCycle(v19.StormBolt, 695 - (534 + 141), false, nil, true);
					if v18 then
						return v18;
					end
					v18 = v29.Interrupt.UseShockwave and v27.InterruptCycle(v19.Shockwave, v62, false, nil, true, true);
					if v18 then
						return v18;
					end
				end
				if (v29.Commons.Enabled.Trinkets or v29.Commons.Enabled.Items) then
					local v69, v70, v71 = v5:GetUseableItems(v21);
					if v69 then
						local v73 = v29.Commons.DisplayStyle.Trinkets;
						if ((((v70 == (6 + 7)) and IsTrinket1) or ((v70 == (13 + 1)) and IsTrinket2)) and v22 and v29.Commons.Enabled.Trinkets) then
							if (v70 == (16 + 0)) then
								v9.CastMacro(1 - 0);
								return "weapon cast";
							end
							if v10(v69, true, v73) then
								return "Generic use_items for " .. v69:Name();
							end
						end
					end
				end
				if (v19.WreckingThrow:IsCastable() and v22 and (v6:BuffUp(v19.CorruptBuff) or v6:BuffUp(v19.SupernovaBuff))) then
					if v10(v19.WreckingThrow) then
						return "Wrecking Throw Shield";
					end
				end
				if (v19.HeroicThrow:IsCastable() and v5:AffectingCombat()) then
					if v27.CastCycle(v19.HeroicThrow, Enemies30Yard, v42, 48 - 17, nil, nil, false) then
						return "Heroic Throw cycle";
					end
				end
				if (v19.Avatar:IsCastable() and IsAvatar and v22 and (v5:BuffDown(v19.ThunderBlastBuff) or (v5:BuffStack(v19.ThunderBlastBuff) <= (5 - 3)))) then
					if v10(v19.Avatar, true) then
						return "avatar main 2";
					end
				end
				if (v19.BloodFury:IsCastable() and IsRacials and v22) then
					if v10(v19.BloodFury, true) then
						return "blood_fury main 6";
					end
				end
				if (v19.Berserking:IsCastable() and IsRacials and v22) then
					if v10(v19.Berserking, true) then
						return "berserking main 8";
					end
				end
				if (v19.ArcaneTorrent:IsCastable() and IsRacials and v22) then
					if v10(v19.ArcaneTorrent, true) then
						return "arcane_torrent main 10";
					end
				end
				if (v19.LightsJudgment:IsCastable() and IsRacials and v22) then
					if v10(v19.LightsJudgment, true) then
						return "lights_judgment main 12";
					end
				end
				if (v19.Fireblood:IsCastable() and IsRacials and v22) then
					if v10(v19.Fireblood, true) then
						return "fireblood main 14";
					end
				end
				if (v19.AncestralCall:IsCastable() and IsRacials and v22) then
					if v10(v19.AncestralCall, true) then
						return "ancestral_call main 16";
					end
				end
				if (v19.BagofTricks:IsCastable() and IsRacials and v22) then
					if v10(v19.BagofTricks, true) then
						return "ancestral_call main 18";
					end
				end
				if (v29.Commons.Enabled.Potions and IsPotions and (v5:BuffUp(v19.Avatar) or (v5:BuffDown(v19.Avatar) and (v6:HealthPercentage() <= (11 + 9))) or not IsAvatar) and v22) then
					local v72 = v27.PotionSelected();
					if (v72 and v72:IsReady()) then
						v9.CastMacro(2 + 1, true, nil, v72);
						return "Cast Potion";
					end
				end
				if (v19.Ravager:IsCastable() and IsRavager and v22) then
					v45(406 - (115 + 281));
					if v9.CastTarget(v19.Ravager, v9.TName().PLAYER) then
						return "ravager main 26";
					end
				end
				if (v19.DemoralizingShout:IsCastable() and IsDemoralizingShout and v22 and (v19.BoomingVoice:IsAvailable())) then
					v45(69 - 39);
					if v10(v19.DemoralizingShout, false) then
						return "demoralizing_shout main 28";
					end
				end
				if (v19.ChampionsSpear:IsCastable() and IsChampionsSpear and v22) then
					v45(17 + 3);
					if v9.CastTarget(v19.ChampionsSpear, v9.TName().PLAYER) then
						return "ChampionsSpear main 30";
					end
				end
				if (v19.ThunderBlastAbility:IsReady() and v6:IsInMeleeRange(19 - 11) and (v24 >= (7 - 5)) and (v5:BuffStack(v19.ThunderBlastBuff) == (869 - (550 + 317)))) then
					v45(7 - 2);
					if v10(v19.ThunderBlastAbility) then
						return "thunder_blast main ";
					end
				end
				if (v19.Demolish:IsCastable() and IsDemolish and not v5:IsMoving() and v22 and (v5:BuffStack(v19.ColossalMightBuff) >= (3 - 0))) then
					if v10(v19.Demolish) then
						return "demolish main ";
					end
				end
				if (v19.ThunderousRoar:IsCastable() and IsThunderousRoar and v6:IsInMeleeRange(22 - 14)) then
					if v10(v19.ThunderousRoar) then
						return "thunderous_roar main 32";
					end
				end
				if (v19.ShieldCharge:IsCastable() and v29.Protection.UseShieldCharge and v6:IsInMeleeRange(290 - (134 + 151))) then
					v45(1705 - (970 + 695));
					if v10(v19.ShieldCharge) then
						return "shield_charge main 38";
					end
				end
				if (v24 > (5 - 2)) then
					v18 = v48();
					if v18 then
						return v18;
					end
					if v9.CastAnnotated(v19.Pool, false, "WAIT") then
						return "Pool for Aoe()";
					end
				end
				v18 = v49();
				if v18 then
					return v18;
				end
				if v9.CastAnnotated(v19.Pool, false, "WAIT") then
					return "Wait/Pool Resources";
				end
			end
		end
	end
end
local function v51()
	v9.ResetToggle();
	v29.Protection.Display();
	v9:UpdateMacro("macro1", "/use 16");
	v9.ToggleIconFrame:AddButtonCustom("S", 1991 - (582 + 1408), "smallCDs", "smallcds");
	v9.ToggleIconFrame:AddButtonCustom("A", 6 - 4, "Auto Stance", "autostance");
	v9.ToggleIconFrame:AddButtonCustom("I", 3 - 0, "Interrupt", "interrupt");
	v27.PostInitialMessage(275 - 202);
end
v9.SetAPL(1897 - (1195 + 629), v50, v51);
