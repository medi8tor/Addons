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
local v12 = HeroRotation();
local v13 = v12.AoEON;
local v14 = v12.CDsON;
local v15 = v12.Cast;
local v16 = v5.MouseOver;
local v17 = v12.Commons().Everyone.num;
local v18 = v12.Commons().Everyone.bool;
local v19 = math.floor;
local v20 = C_Timer.After;
local v21;
local v22 = v12.Commons().Everyone;
local v23 = v12.GUISettingsGet();
local v24 = {General=v23.General,Commons=v23.APL.Druid.Commons,Guardian=v23.APL.Druid.Guardian,Guardian_Defensives=v23.APL.Druid.Guardian.Defensives,Guardian_TTD=v23.APL.Druid.Guardian_TTD,Guardian_CDUSE=v23.APL.Druid.Guardian_CDUSE};
local v25 = v9.Druid.Guardian;
local v26 = v11.Druid.Guardian;
local v27 = {v26.Djaruun:ID(),v26.Jotungeirr:ID(),v26.ManicGrieftorch:ID()};
local v28 = v25.ThornsofIron:IsAvailable() and v25.ReinforcedFur:IsAvailable();
local v29 = v25.PrimalFury:IsAvailable() and v25.FluidForm:IsAvailable() and v25.WildpowerSurge:IsAvailable();
local v30, v31;
local v32, v33;
local v34, v35;
local v36, v37;
local v38;
local v39;
local v40;
local v41, v42;
local v43;
local v44 = 28620 - 17509;
local v45 = 11730 - (555 + 64);
local v46;
local v47 = 931 - (857 + 74);
local function v48()
	local v64, v65 = v6:GetTrinketData(v27);
	if ((v47 < (573 - (367 + 201))) and ((v64.ID == (927 - (214 + 713))) or (v65.ID == (0 + 0)) or ((v64.SpellID > (0 + 0)) and not v64.Usable) or ((v65.SpellID > (877 - (282 + 595))) and not v65.Usable))) then
		v47 = v47 + (1638 - (1523 + 114));
		v20(5 + 0, function()
			v48();
		end);
		return;
	end
	v30 = v64.Object;
	v31 = v65.Object;
	v32 = v64.Range;
	v33 = v65.Range;
end
v48();
v3:RegisterForEvent(function()
	v47 = 0 - 0;
	v48();
end, "PLAYER_EQUIPMENT_CHANGED");
v3:RegisterForEvent(function()
	v44 = 12176 - (68 + 997);
	v45 = 12381 - (226 + 1044);
end, "PLAYER_REGEN_ENABLED");
v3:RegisterForEvent(function()
	v28 = v25.ThornsofIron:IsAvailable() and v25.ReinforcedFur:IsAvailable();
	v29 = v25.PrimalFury:IsAvailable() and v25.FluidForm:IsAvailable() and v25.WildpowerSurge:IsAvailable();
end, "SPELLS_CHANGED", "LEARNED_SPELL_IN_TAB");
local function v49(v70)
	return ((v70:DebuffDown(v25.MoonfireDebuff) and (v70:TimeToDie() > (52 - 40))) or (v70:DebuffRefreshable(v25.MoonfireDebuff) and (v70:TimeToDie() > (129 - (32 + 85))))) and (((v42 < (7 + 0)) and v25.FuryofNature:IsAvailable()) or ((v42 < (1 + 3)) and not v25.FuryofNature:IsAvailable()));
end
local function v50(v71)
	return v71:DebuffStack(v25.ThrashBearDebuff) > (959 - (892 + 65));
end
local function v51(v72)
	return v72:DebuffRefreshable(v25.ThrashBearDebuff) or ((v8:DebuffStack(v25.ThrashBearDebuff) < (11 - 6)) and (v25.FlashingClaws:TalentRank() == (3 - 1))) or ((v72:DebuffStack(v25.ThrashBearDebuff) < (7 - 3)) and (v25.FlashingClaws:TalentRank() == (351 - (87 + 263)))) or ((v8:DebuffStack(v25.ThrashBearDebuff) < (183 - (67 + 113))) and not v25.FlashingClaws:IsAvailable());
end
local function v52()
	return v26.ManicGrieftorch:IsEquipped() and (v26.ManicGrieftorch:CooldownUp() or (v26.ManicGrieftorch:CooldownRemains() <= v6:GCDRemains()));
end
local function v53(v73)
	return (v46 and v24.Guardian_TTD.IgnoreWhenBoss) or v22.Buggedmobs[v8:NPCID()] or (v22.ISSolo() and v24.Guardian_TTD.IgnoreWhenSolo) or (v73 == (0 + 0)) or ((v45 >= v73) and (v45 < (19093 - 11316)));
end
local function v54(v74)
	return (v74 ~= "Not Used") and ((((v74 == "with Cooldowns") or ((v74 == "small CDs") and v24.Guardian_CDUSE.smallcdswithCooldowns) or (v74 == "with Cooldowns or AoE") or (v74 == "on Enemycount or Cooldowns") or (v74 == "on Boss or with Cooldowns")) and v14()) or (v74 == "always") or (((v74 == "on Boss only") or (v74 == "on Boss or on Enemycount") or (v74 == "on Boss or with Cooldowns")) and (v46 or v8:IsDummy())) or ((v74 == "with Bloodlust only") and v6:BloodlustUp()) or ((v74 == "small CDs") and Smallcds) or (((v74 == "on AOE") or (v74 == "with Cooldowns or AoE")) and (v42 >= (2 + 0))) or (((v74 == "on Enemycount or Cooldowns") or (v74 == "on Enemycount") or (v74 == "on Boss or on Enemycount")) and (v42 >= v24.Guardian_CDUSE.Enemycount)));
end
local function v55(v75)
	return v75:NPCID() == (813021 - 608461);
end
local function v56(v76)
	return v76:CastSpellID() == (409757 - (802 + 150));
end
local function v57()
	return v6:ChannelSpellID() == (1054125 - 662597);
end
local function v58()
	local v77 = v6:IncomingSpell(v22.TankBustersList2);
	if (v77 and v12.DebugON()) then
		print("Tank Buster: " .. v77);
	end
	if ((v6:HealthPercentageWeighted() <= v24.Guardian.Defensives.FrenziedRegenHP) and v25.FrenziedRegeneration:IsReady() and v6:BuffDown(v25.FrenziedRegenerationBuff) and not v6:HealingAbsorbed()) then
		if v15(v25.FrenziedRegeneration) then
			return "frenzied_regeneration defensive 2";
		end
	end
	if (v25.Regrowth:IsCastable() and v6:BuffUp(v25.DreamofCenariusBuff) and (v6:HealthPercentageWeighted() <= v24.Guardian.Defensives.RegrowthHP)) then
		if v15(v25.Regrowth) then
			return "regrowth defensive 4";
		end
	end
	if (v25.Renewal:IsCastable() and v6:AffectingCombat() and (v6:HealthPercentage() <= v24.Guardian.Defensives.RenewalHP)) then
		if v15(v25.Renewal) then
			return "renewal defensive 6";
		end
	end
	if (v25.Ironfur:IsReady() and v6:AffectingCombat() and (v6:BuffDown(v25.IronfurBuff) or ((v6:BuffStack(v25.IronfurBuff) < (3 - 1)) and v6:BuffRefreshable(v25.Ironfur)))) then
		if v15(v25.Ironfur, true) then
			return "ironfur defensive 8";
		end
	end
	if (v25.Barkskin:IsCastable() and v6:AffectingCombat() and (((v6:HealthPercentageWeighted() <= v24.Guardian.Defensives.BarkskinHP) and v6:BuffDown(v25.IronfurBuff)) or (v6:HealthPercentageWeighted() < (v24.Guardian.Defensives.BarkskinHP * (0.75 + 0))) or v77)) then
		if v15(v25.Barkskin) then
			return "barkskin defensive 10";
		end
	end
	if (v25.SurvivalInstincts:IsCastable() and v6:AffectingCombat() and (v6:HealthPercentageWeighted() < v24.Guardian.Defensives.SurvivalInstinctsHP)) then
		if v15(v25.SurvivalInstincts) then
			return "survival_instincts defensive 12";
		end
	end
	if (v25.BristlingFur:IsCastable() and v6:AffectingCombat() and (v6:Rage() < v24.Guardian.Defensives.BristlingFurRage) and (v25.RageoftheSleeper:CooldownRemains() > (1005 - (915 + 82)))) then
		if v15(v25.BristlingFur) then
			return "bristling_fur defensive 14";
		end
	end
	if (v25.NaturesVigil:IsCastable() and v6:AffectingCombat() and (v24.Guardian.Defensives.NaturesVigilCount ~= (0 - 0)) and (not v24.Guardian.Defensives.NaturesVigilHP ~= (0 + 0)) and v22.AoELogicWithCount(v24.Guardian.Defensives.NaturesVigilHP, v24.Guardian.Defensives.NaturesVigilCount, nil, v43)) then
		if v15(v25.NaturesVigil) then
			return "NaturesVigil";
		end
	end
end
local function v59()
	if (v25.BearForm:IsCastable() and v6:BuffDown(v25.TravelFormBuff) and v6:BuffDown(v25.BearForm) and v6:BuffDown(v25.CatForm)) then
		if v15(v25.BearForm) then
			return "bear_form precombat 4";
		end
	end
	if v6:BuffUp(v25.BearForm) then
		if (v25.Moonfire:IsCastable() and v8:IsSpellInRange(v25.Moonfire)) then
			if v15(v25.Moonfire) then
				return "moonfire precombat 8";
			end
		end
		if (v25.ThrashBear:IsCastable() and v37) then
			if v15(v25.Thrashcast) then
				return "thrash precombat 12";
			end
		end
		if (v25.Mangle:IsCastable() and v36) then
			if v15(v25.Mangle) then
				return "mangle precombat 14";
			end
		end
	end
end
local function v60()
	if (v25.Rake:IsReady() and (v6:StealthUp(false, true)) and v36) then
		if v15(v25.Rake) then
			return "Catweave Rake 1";
		end
	end
	if (v25.Rip:IsReady() and v8:DebuffRefreshable(v25.RipDebuff) and (ComboPoints >= (4 - 0))) then
		if v15(v25.Rip) then
			return "Catweave Rip 2";
		end
	end
	if (v25.FerociousBite:IsReady() and v36 and (ComboPoints >= (1191 - (1069 + 118))) and (v6:Energy() >= (113 - 63))) then
		if v15(v25.FerociousBite) then
			return "Catweave ferocious_bite 3";
		end
	end
	if (ComboPoints < (10 - 5)) then
		if (v25.Rake:IsReady() and v8:DebuffRefreshable(v25.RakeDebuff)) then
			if v15(v25.Rake) then
				return "Catweave Rake 4";
			end
		end
		if (v25.ConvoketheSpirits:IsReady() and IsConvoketheSpirits and v36) then
			if v15(v25.ConvoketheSpirits) then
				return "Catweave Convoke 5";
			end
		end
		if (v25.ThrashCat:IsCastable() and v37 and v8:DebuffRefreshable(v25.ThrashCatDebuff)) then
			if v15(v25.Thrashcast) then
				return "Catweave thrash 6";
			end
		end
		if (v25.Shred:IsReady() and v36 and (v42 < (1 + 1))) then
			if v15(v25.Shred) then
				return "Catweave shred 7";
			end
		end
		if (v25.Swipe:IsReady() and v37 and (v42 > (1 - 0))) then
			if v15(v25.Swipecast) then
				return "Catweave swipe 8";
			end
		end
	end
end
local function v61()
	if (v25.RavageAbilityBear:IsReady() and v36 and v6:BuffUp(v25.RavageBuffGuardian) and (v42 > (1 + 0))) then
		if v15(v25.RavageAbilityBear) then
			return "ravage bear 2";
		end
	end
	if (v25.HeartoftheWild:IsCastable() and v14() and (not v25.Rip:IsAvailable() or ((v6:BuffStack(v25.FelinePotentialBuff) == (797 - (368 + 423))) and (v42 < (9 - 6))))) then
		if v15(v25.HeartoftheWild, true) then
			return "heart_of_the_wild bear 4";
		end
	end
	if (v25.Moonfire:IsCastable() and v6:BuffUp(v25.BearForm)) then
		if v22.CastCycle(v25.Moonfire, v41, v49, 58 - (10 + 8)) then
			return "moonfire bear 6";
		end
	end
	if v25.ThrashBear:IsCastable() then
		if v22.CastCycle(v25.Thrashcast, v41, v51, 30 - 22, false, nil, false, true) then
			return "thrash bear 8";
		end
	end
	if (v25.LunarBeam:IsReady() and IsLunarBeam and not v6:IsMoving() and v36) then
		if v15(v25.LunarBeam) then
			return "lunar_beam bear 10";
		end
	end
	if (v25.ConvoketheSpirits:IsCastable() and v36 and IsConvoketheSpirits) then
		if v15(v25.ConvoketheSpirits) then
			return "convoke_the_spirits bear 12";
		end
	end
	if (v25.Berserk:IsCastable() and v36 and IsIncarnation) then
		if v15(v25.Berserk, true) then
			return "berserk bear 14";
		end
	end
	if (v25.Incarnation:IsCastable() and v36 and IsIncarnation) then
		if v15(v25.Incarnation, true) then
			return "incarnation bear 16";
		end
	end
	if (v25.RageoftheSleeper:IsCastable() and v36 and IsRageoftheSleeper and ((((v6:BuffDown(v25.Incarnation) and (v25.Incarnation:CooldownRemains() > (502 - (416 + 26)))) or v6:BuffDown(v25.Berserk)) and (v6:Rage() > (127 - 87)) and not v25.ConvoketheSpirits:IsAvailable()) or ((v6:BuffUp(v25.Incarnation) or v6:BuffUp(v25.Berserk)) and (v6:Rage() > (18 + 22)) and not v25.ConvoketheSpirits:IsAvailable()) or (v25.ConvoketheSpirits:IsAvailable() and (v6:Rage() > (70 - 30))))) then
		if v15(v25.RageoftheSleeper, true) then
			return "rage_of_the_sleeper bear 18";
		end
	end
	if (v25.Berserking:IsCastable() and v36 and IsRacials and (v6:BuffUp(v25.Berserk) or v6:BuffUp(v25.Incarnation))) then
		if v15(v25.Berserking, true) then
			return "berserking bear 20";
		end
	end
	if (v25.RavageAbilityBear:IsReady() and v36 and v6:BuffUp(v25.RavageBuffGuardian) and (v42 < (440 - (145 + 293)))) then
		if v15(v25.RavageAbilityBear) then
			return "ravage bear 22";
		end
	end
	if (v25.Raze:IsReady() and v36 and ((v6:BuffStack(v25.ToothandClawBuff) > (431 - (44 + 386))) or (v6:BuffRemains(v25.ToothandClawBuff) < ((1487 - (998 + 488)) + v6:GCD()))) and v28 and (v42 > (1 + 0))) then
		if v15(v25.Raze) then
			return "raze bear 24";
		end
	end
	if (v25.ThrashBear:IsCastable() and v37 and (v42 >= (5 + 0)) and v25.LunarCalling:IsAvailable()) then
		if v15(v25.Thrashcast) then
			return "thrash bear 26";
		end
	end
	if (v25.Ironfur:IsReady() and v6:AffectingCombat() and v36 and ((v6:BuffDown(v25.IronfurBuff) and (v6:Rage() > (822 - (201 + 571))) and v39 and not v28 and v6:BuffDown(v25.RageoftheSleeper)) or ((v6:Rage() > (1228 - (116 + 1022))) and not v28) or (v6:BuffDown(v25.ToothandClawBuff) and v6:BuffDown(v25.IronfurBuff) and (v6:Rage() > (208 - 158)) and v39 and not v28 and v6:BuffDown(v25.RageoftheSleeper)))) then
		if v15(v25.Ironfur, true) then
			return "ironfur bear 28";
		end
	end
	if (v25.Ironfur:IsReady() and v6:AffectingCombat() and v36 and v6:BuffDown(v25.RavageBuffGuardian) and (((v6:Rage() > (24 + 16)) and v28 and (v25.RageoftheSleeper:CooldownRemains() > (10 - 7)) and v25.RageoftheSleeper:IsAvailable()) or ((v6:BuffUp(v25.Incarnation) or v6:BuffUp(v25.Berserk)) and (v6:Rage() > (71 - 51)) and v28 and (v25.RageoftheSleeper:CooldownRemains() > (862 - (814 + 45))) and v25.RageoftheSleeper:IsAvailable()) or ((v6:Rage() > (221 - 131)) and v28 and not v25.FountofStrength:IsAvailable()) or ((v6:Rage() > (6 + 104)) and v28 and v25.FountofStrength:IsAvailable()) or ((v6:BuffUp(v25.Incarnation) or v6:BuffUp(v25.Berserk)) and (v6:Rage() > (8 + 12)) and v28 and v6:BuffUp(v25.RageoftheSleeper) and v25.RageoftheSleeper:IsAvailable()))) then
		if v15(v25.Ironfur, true) then
			return "ironfur bear 30";
		end
	end
	if (v25.Ironfur:IsReady() and v6:AffectingCombat() and v36 and v6:BuffDown(v25.RavageBuffGuardian) and (((v6:Rage() > (925 - (261 + 624))) and v28 and not v25.RageoftheSleeper:IsAvailable()) or ((v6:BuffUp(v25.Incarnation) or v6:BuffUp(v25.Berserk)) and (v6:Rage() > (35 - 15)) and v28 and not v25.RageoftheSleeper:IsAvailable()) or ((v6:BuffUp(v25.Incarnation) or v6:BuffUp(v25.Berserk)) and (v6:Rage() > (1100 - (1020 + 60))) and v28 and not v25.RageoftheSleeper:IsAvailable()))) then
		if v15(v25.Ironfur, true) then
			return "ironfur bear 32";
		end
	end
	if (v25.Raze:IsReady() and v36 and v28 and (v6:BuffStack(v25.ViciousCycleMaulBuff) == (1426 - (630 + 793))) and (v42 > (3 - 2)) and not v25.Ravage:IsAvailable()) then
		if v15(v25.Raze) then
			return "raze bear 38";
		end
	end
	if (v25.Mangle:IsCastable() and v36 and ((v6:BuffUp(v25.GoreBuff) and (v42 < (52 - 41))) or (v6:BuffUp(v25.Incarnation) and (v6:BuffStack(v25.FelinePotentialBuff) < (3 + 3)) and v25.WildpowerSurge:IsAvailable()))) then
		if v15(v25.Mangle) then
			return "mangle bear 40";
		end
	end
	if (v25.Raze:IsReady() and v36 and not v28 and ((v42 > (3 - 2)) or (v6:BuffUp(v25.ToothandClawBuff) and (v42 > (1748 - (760 + 987)))) or ((v6:BuffStack(v25.ViciousCycleMaulBuff) == (1916 - (1789 + 124))) and (v42 > (767 - (745 + 21)))))) then
		if v15(v25.Raze) then
			return "raze bear 42";
		end
	end
	if (v25.Mangle:IsCastable() and v36 and v6:BuffUp(v25.CatForm) and v25.FluidForm:IsAvailable()) then
		if v15(v25.Mangle) then
			return "mangle bear 48";
		end
	end
	if (v25.Maul:IsReady() and v36 and v40 and v28 and ((((v6:BuffStack(v25.ToothandClawBuff) > (1 + 0)) or (v6:BuffRemains(v25.ToothandClawBuff) < ((2 - 1) + v6:GCD()))) and (v42 <= (19 - 14)) and not v25.Raze:IsAvailable()) or (((v6:BuffStack(v25.ToothandClawBuff) > (1 + 0)) or (v6:BuffRemains(v25.ToothandClawBuff) < (1 + 0 + v6:GCD()))) and (v42 == (1056 - (87 + 968))) and v25.Raze:IsAvailable()) or (((v6:BuffStack(v25.ToothandClawBuff) > (4 - 3)) or (v6:BuffRemains(v25.ToothandClawBuff) < (1 + 0 + v6:GCD()))) and (v42 <= (11 - 6)) and not v25.Raze:IsAvailable()))) then
		if v15(v25.Maul) then
			return "maul bear 50";
		end
	end
	if (v25.Maul:IsReady() and v36 and v40 and not v28 and ((v6:BuffUp(v25.ToothandClawBuff) and (v42 <= (1418 - (447 + 966))) and not v25.Raze:IsAvailable()) or (v6:BuffUp(v25.ToothandClawBuff) and (v42 == (2 - 1)) and v25.Raze:IsAvailable()))) then
		if v15(v25.Maul) then
			return "maul bear 52";
		end
	end
	if (v25.Maul:IsReady() and v36 and v40 and (((v42 <= (1822 - (1703 + 114))) and not v25.Raze:IsAvailable() and not v28) or ((v42 == (702 - (376 + 325))) and v25.Raze:IsAvailable() and not v28) or ((v6:BuffStack(v25.ViciousCycleMaulBuff) == (4 - 1)) and (v42 <= (15 - 10)) and not v25.Raze:IsAvailable()))) then
		if v15(v25.Maul) then
			return "maul bear 54";
		end
	end
	if (v25.ThrashBear:IsCastable() and v37 and (v42 >= (2 + 3))) then
		if v15(v25.Thrashcast) then
			return "thrash bear 56";
		end
	end
	if (v25.Mangle:IsCastable() and v36 and ((v6:BuffUp(v25.Incarnation) and (v42 <= (8 - 4))) or (v6:BuffUp(v25.Incarnation) and v25.SouloftheForest:IsAvailable() and (v42 <= (19 - (9 + 5))) and (v6:Rage() < (464 - (85 + 291))) and (v42 < (1276 - (243 + 1022)))) or ((v6:Rage() < (315 - 232)) and (v42 < (10 + 1)) and v25.SouloftheForest:IsAvailable()))) then
		if v15(v25.Mangle) then
			return "mangle bear 58";
		end
	end
	if (v25.ThrashBear:IsCastable() and v37 and (v42 > (1181 - (1123 + 57)))) then
		if v15(v25.Thrashcast) then
			return "thrash bear 60";
		end
	end
	if (v25.Pulverize:IsReady() and v36 and (v8:DebuffStack(v25.ThrashBearDebuff) > (2 + 0))) then
		if v15(v25.Pulverize) then
			return "pulverize bear 62";
		end
	end
	if (v25.ThrashBear:IsCastable() and v37) then
		if v15(v25.Thrashcast) then
			return "thrash bear 64";
		end
	end
	if (v25.Moonfire:IsCastable() and v8:IsSpellInRange(v25.Moonfire) and v6:BuffUp(v25.GalacticGuardianBuff) and v6:BuffUp(v25.BearForm) and v25.BoundlessMoonlight:IsAvailable()) then
		if v15(v25.Moonfire) then
			return "moonfire bear 66";
		end
	end
	if (v25.Swipe:IsCastable() and v37 and ((v25.LunarInsight:IsAvailable() and (v42 > (258 - (163 + 91)))) or not v25.LunarInsight:IsAvailable() or (v25.LunarInsight:IsAvailable() and (v42 < (1932 - (1869 + 61)))))) then
		if v15(v25.Swipecast) then
			return "swipe bear 78";
		end
	end
	if (v25.Moonfire:IsCastable() and v8:IsSpellInRange(v25.Moonfire) and v25.LunarInsight:IsAvailable() and (v42 > (1 + 0)) and v6:BuffUp(v25.BearForm)) then
		if v15(v25.Moonfire) then
			return "moonfire bear 80";
		end
	end
end
local function v62()
	if v6:IsChanneling() then
		return "Dont cut Torch";
	end
	InterruptToggle = v12.ToggleIconFrame:GetToggle(3 - 2);
	DispelToggle = v12.ToggleIconFrame:GetToggle(2 - 0);
	Smallcds = v12.ToggleIconFrame:GetToggle(1 + 2);
	ComboPoints = v6:ComboPoints();
	v43 = v22.UnitsinRange(v25.Regrowth);
	v41 = v6:GetEnemiesInMeleeRange(10 - 2);
	if v13() then
		v42 = #v41;
	else
		v42 = 1 + 0;
	end
	IsRacials = v53(v24.Guardian_TTD.RacialsTTD) and v54(v24.Guardian_CDUSE.Racials);
	IsPotions = v53(v24.Guardian_TTD.PotionsTTD) and (v24.Guardian_CDUSE.Potionswhensolo or (not v24.Guardian_CDUSE.Potionswhensolo and not v22.ISSolo())) and v54(v24.Guardian_CDUSE.Potions);
	IsTrinket1 = v53(v24.Guardian_TTD.TrinketsTTD) and v54(v24.Guardian_CDUSE.Trinket1);
	IsTrinket2 = v53(v24.Guardian_TTD.TrinketsTTD) and v54(v24.Guardian_CDUSE.Trinket2);
	IsIncarnation = v53(v24.Guardian_TTD.IncarnationTTD) and v54(v24.Guardian_CDUSE.Incarnation);
	IsRageoftheSleeper = v25.RageoftheSleeper:IsAvailable() and v53(v24.Guardian_TTD.RageoftheSleeperTTD) and v54(v24.Guardian_CDUSE.RageoftheSleeper);
	IsLunarBeam = v53(v24.Guardian_TTD.LunarBeamTTD) and v54(v24.Guardian_CDUSE.LunarBeam);
	IsConvoketheSpirits = v53(v24.Guardian_TTD.ConvoketheSpiritsTTD) and v54(v24.Guardian_CDUSE.ConvoketheSpirits);
	IsDjaruun = v54(v24.Guardian_CDUSE.Djaruun);
	if (v22.TargetIsValid() or v6:AffectingCombat()) then
		v44 = v3.BossFightRemains();
		v46 = true;
		v45 = v44;
		if (v45 == (12585 - (1329 + 145))) then
			v46 = false;
			v45 = v3.FightRemains(v41, false);
		end
	end
	if (v22.TargetIsValid() or v6:AffectingCombat()) then
		v38 = v6:ActiveMitigationNeeded();
		v39 = v6:IsTankingAoE(979 - (140 + 831)) or v6:IsTanking(v8);
		v40 = false;
		if (((v6:Rage() >= (v25.Maul:Cost() + (1870 - (1409 + 441)))) and not v39) or (v6:RageDeficit() <= (728 - (15 + 703))) or not v24.Guardian.UseRageDefensively or v6:BuffUp(v25.ToothandClawBuff)) then
			v40 = true;
		end
		v36 = v8:IsInRange(3 + 2);
		v37 = v8:IsInRange(446 - (262 + 176));
	end
	if (v25.MarkoftheWild:IsCastable() and not v6:DebuffUp(v25.Corruption) and ((v22.GroupBuffMissing(v25.MarkoftheWildBuff) and (v24.Commons.MarkoftheWild == "check whole group") and (v6:IsInRaidArea() or v6:IsInDungeonArea()) and (v6:InstanceDifficulty() ~= (1926 - (345 + 1376)))) or (v6:BuffDown(v25.MarkoftheWildBuff, true) and ((v24.Commons.MarkoftheWild == "only check us") or (v24.Commons.MarkoftheWild == "check whole group"))))) then
		if v12.CastTarget(v25.MarkoftheWild, v12.TName().PLAYER) then
			return "mark_of_the_wild precombat";
		end
	end
	if (v25.Rebirth:IsReady() and not v6:IsCasting(v25.Rebirth) and v6:AffectingCombat() and not v6:IsMoving()) then
		if (v8:UnitIsFriend() and v8:UnitIsPlayer() and v8:Exists() and v8:IsDeadOrGhost()) then
			v12.Cast(v25.Rebirth);
			return "Rebirth on Target";
		end
		if (v16:UnitIsFriend() and v16:UnitIsPlayer() and v16:Exists() and v16:IsDeadOrGhost()) then
			v12.CastTarget(v25.Rebirth, v12.TName().MOUSEOVER);
			return "Rebirth on Mouseover";
		end
	end
	if not v6:IsMoving() then
		v21 = not v6:IsCasting(v25.Hibernate) and v22.IncorpCycle(v25.Hibernate, 718 - (198 + 490), false, false);
		if v21 then
			return v21;
		end
	end
	if DispelToggle then
		v21 = v6:AffectingCombat() and v22.SootheCycle(v25.Soothe, 198 - 153, false, v24.Guardian.TabForSoothe);
		if v21 then
			return v21;
		end
		if (v25.RemoveCorruption:IsCastable() and v6:IsInDungeonArea() and v6:IsInParty()) then
			v21 = v22.DispelCycle(v25.RemoveCorruption, "Poison", nil, v43);
			if v21 then
				return v21;
			end
			v21 = v22.DispelCycle(v25.RemoveCorruption, "Curse", nil, v43);
			if v21 then
				return v21;
			end
		end
	end
	if v6:BuffUp(v25.BearForm) then
		v21 = v58();
		if v21 then
			return v21;
		end
	end
	if (v25.BearForm:IsCastable() and v6:BuffDown(v25.TravelFormBuff) and v6:BuffDown(v25.BearForm) and v6:BuffDown(v25.CatForm)) then
		if v15(v25.BearForm) then
			return "bear_form";
		end
	end
	if (v22.TargetIsValid() and v6:BuffDown(v25.TravelFormBuff)) then
		if (not v24.Guardian.AttackonlyinCombat or (v24.Guardian.AttackonlyinCombat and v8:AffectingCombat())) then
			if not v55(v5.Target) then
				if not v6:AffectingCombat() then
					v21 = v59();
					if v21 then
						return v21;
					end
				end
				if (InterruptToggle and not v57()) then
					v21 = v22.InterruptCycle(v25.SkullBash, 30 - 17, true, nil, false);
					if v21 then
						return v21;
					end
					v21 = v22.InterruptCycle(v25.MightyBash, 1214 - (696 + 510), false, nil, true);
					if v21 then
						return v21;
					end
					v21 = v22.InterruptCycle(v25.IncapacitatingRoar, 26 - 13, false, nil, true, true);
					if v21 then
						return v21;
					end
				end
				if (v24.Commons.Enabled.Items and v26.Jotungeirr:IsEquippedAndReady()) then
					v12.CastMacro(1263 - (1091 + 171), nil, nil, v26.Jotungeirr);
					return "Jotungeirr";
				end
				if v24.Commons.Enabled.Trinkets then
					if (v52() and v6:AffectingCombat() and (((v30:ID() == v26.ManicGrieftorch:ID()) and IsTrinket1) or ((v31:ID() == v26.ManicGrieftorch:ID()) and IsTrinket2)) and v8:IsInRange(7 + 33)) then
						if v15(v26.ManicGrieftorch) then
							return "manic_grieftorch";
						end
					end
					if (v30:IsReady() and v8:IsInRange(v32) and IsTrinket1) then
						if v15(v30, true) then
							return "use_item trinket1 (" .. tostring(v30:Name()) .. ") main 4";
						end
					end
					if (v31:IsReady() and v8:IsInRange(v33) and IsTrinket2) then
						if v15(v31, true) then
							return "use_item trinket2 (" .. tostring(v31:Name()) .. ") main 6";
						end
					end
				end
				if (v24.Commons.Enabled.Items and v26.Djaruun:IsEquippedAndReady() and (v6:BuffUp(v25.BerserkBuff) or v6:BuffUp(v25.Incarnation)) and v36 and IsDjaruun) then
					v12.CastMacro(3 - 2, nil, nil, v26.Djaruun);
					return "Djaruun";
				end
				if (v24.Commons.Enabled.Potions and IsPotions and (v6:BuffUp(v25.Berserk) or v6:BuffUp(v25.Incarnation))) then
					local v78 = v22.PotionSelected();
					if (v78 and v78:IsReady()) then
						v12.CastMacro(9 - 6, nil, nil, v78);
						return "Cast Potion";
					end
				end
				if v6:BuffUp(v25.CatForm) then
					v21 = v60();
					if v21 then
						return v21;
					end
				end
				if v6:BuffDown(v25.CatForm) then
					v21 = v61();
					if v21 then
						return v21;
					end
				end
				if v12.CastAnnotated(v25.Pool, false, "WAIT") then
					return "Wait/Pool Resources";
				end
			end
		end
	end
end
local function v63()
	v12.ResetToggle();
	v24.Guardian.Display();
	v12:UpdateMacro("macro1", "/use 16");
	v12.ToggleIconFrame:AddButtonCustom("I", 375 - (123 + 251), "Interrupt", "interrupt");
	v12.ToggleIconFrame:AddButtonCustom("D", 9 - 7, "Dispel", "dispel");
	v12.ToggleIconFrame:AddButtonCustom("S", 701 - (208 + 490), "smallCDs", "smallcds");
	v12.Print("Guardian Druid rotation has been updated for patch 11.0.2. Last Update 23.09.2024");
end
v12.SetAPL(9 + 95, v62, v63);
