local v0, v1 = ...;
local v2 = HeroDBC.DBC;
local v3 = HeroLib;
local v4 = HeroCache;
local v5 = v3.Unit;
local v6 = v5.Player;
local v7 = v5.Target;
local v8 = v5.MouseOver;
local v9 = v3.Spell;
local v10 = v3.MultiSpell;
local v11 = v3.Item;
local v12 = v3.Utils.BoolToInt;
local v13 = v3.Utils.ValueIsInArray;
local v14 = HeroRotation();
local v15 = v14.AoEON;
local v16 = v14.CDsON;
local v17 = v14.CastLeftNameplate;
local v18 = v14.Cast;
local v19 = v14.CastQueue;
local v20 = v14.CastQueuePooling;
local v21 = v14.Commons().Everyone.num;
local v22 = v14.Commons().Everyone.bool;
local v23 = pairs;
local v24 = table.insert;
local v25 = math.min;
local v26 = math.max;
local v27 = math.abs;
local v28 = C_Timer.After;
local v29 = v14.Commons().Everyone;
local v30 = v14.Commons().Rogue;
local v31 = v9.Rogue.Subtlety;
local v32 = v11.Rogue.Subtlety;
local v33 = {v32.BottledFlayedwingToxin:ID(),v32.ImperfectAscendancySerum:ID(),v32.MadQueensMandate:ID(),v32.TreacherousTransmitter:ID()};
local v34, v35, v36, v37;
local v38, v39, v40, v41;
local v42;
local v43, v44, v45;
local v46, v47;
local v48, v49, v50;
local v51;
local v52, v53, v54, v55, v56, v57;
local v58, v59;
local v60, v61 = v6:GetTrinketItems();
if ((v60:ID() == (619 - (555 + 64))) or (v61:ID() == (931 - (857 + 74)))) then
	v28(573 - (367 + 201), function()
		v60, v61 = v6:GetTrinketItems();
	end);
end
v3:RegisterForEvent(function()
	v60, v61 = v6:GetTrinketItems();
end, "PLAYER_EQUIPMENT_CHANGED");
v31.Eviscerate:RegisterDamageFormula(function()
	return v6:AttackPowerDamageMod() * v48 * (927.176 - (214 + 713)) * (1.21 + 0) * ((v31.DeeperStratagem:IsAvailable() and (1.05 + 0)) or (878 - (282 + 595))) * ((v31.DarkShadow:IsAvailable() and v6:BuffUp(v31.ShadowDanceBuff) and (1638.3 - (1523 + 114))) or (1 + 0)) * ((v6:BuffUp(v31.SymbolsofDeath) and (1.1 - 0)) or (1066 - (68 + 997))) * ((v6:BuffUp(v31.FinalityEviscerateBuff) and (1271.3 - (226 + 1044))) or (4 - 3)) * ((118 - (32 + 85)) + (v6:MasteryPct() / (99 + 1))) * (1 + 0 + (v6:VersatilityDmgPct() / (1057 - (892 + 65)))) * ((v7:DebuffUp(v31.FindWeaknessDebuff) and (2.5 - 1)) or (1 - 0));
end);
local v62 = v14.GUISettingsGet();
local v63 = {General=v62.General,Commons=v62.APL.Rogue.Commons,Subtlety=v62.APL.Rogue.Subtlety,Interrupt=v62.APL.Rogue.Subtlety_Interrupt};
local function v64()
	return not v29.ISSolo() or v7:IsDummy() or (not v6:IsTanking(v7) and v63.Commons.UseSoloVanish);
end
local function v65()
	return (v14.ToggleIconFrame:GetToggle(7 - 3) or v14.CDsON()) and v30.TTDCheck(v63.Subtlety.TimeToDie.Cooldowns, v63.Commons.Enabled.IgnoreTtdOnBoss and v59, v58);
end
local function v66()
	return (v14.CDsON() and v30.TTDCheck(v63.Subtlety.TimeToDie.Cooldowns, v63.Commons.Enabled.IgnoreTtdOnBoss and v59, v58)) or v7:IsDummy();
end
local function v67(v91, v92)
	if not v43 then
		v43 = v91;
		v44 = v92 or (350 - (87 + 263));
	end
end
local function v68(v93)
	if not v45 then
		v45 = v93;
	end
end
local function v69()
	if ((v63.Subtlety.BurnShadowDance == "On Bosses not in Dungeons") and v6:IsInDungeonArea()) then
		return false;
	elseif ((v63.Subtlety.BurnShadowDance ~= "Always") and not v7:IsInBossList()) then
		return false;
	else
		return true;
	end
end
local function v70()
	if (v40 < (182 - (67 + 113))) then
		return false;
	elseif ((v63.Subtlety.UsePriorityRotation == "On Bosses") and v7:IsInBossList()) then
		return true;
	end
	return v14.ToggleIconFrame:GetToggle(2 + 0);
end
local function v71(v94, v95, v96, v97)
	local v98, v99 = nil, v96;
	local v100 = v7:GUID();
	local v101 = v8:Exists() and v8:GUID();
	for v122, v123 in v23(v97) do
		if ((v123:GUID() ~= v100) and v95(v123)) then
			if ((v123:GUID() == v101) and ((v123:TimeToDie() > v96) or (v63.Commons.Enabled.IgnoreTtdOnBoss and v59) or v29.Buggedmobs[v7:NPCID()])) then
				v14.CastTarget(v94, v14.TName().MOUSEOVER);
				return "Cast Mouseover " .. v94:Name();
			end
			if v29.UnitIsCycleValid(v123, v99, -v123:DebuffRemains(v94)) then
				v98, v99 = v123, v123:TimeToDie();
			end
		end
	end
	if v98 then
		v17(v98, v94);
	end
end
local function v72()
	return (49 - 29) + (v31.Vigor:TalentRank() * (19 + 6)) + (v21(v31.ThistleTea:IsAvailable()) * (79 - 59)) + (v21(v31.Shadowcraft:IsAvailable()) * (972 - (802 + 150)));
end
local function v73()
	return v6:BuffUp(v31.SliceandDice);
end
local function v74(v102)
	return (v6:BuffUp(v31.ThistleTea) and (v40 == (2 - 1))) or (v102 and ((v40 == (1 - 0)) or (v7:DebuffUp(v31.Rupture) and (v40 >= (2 + 0))))) or v6:BuffUp(v31.DarkestNightBuff);
end
local function v75()
	return v51 or (v40 <= (1001 - (915 + 82))) or (v31.ReplicatingShadows:IsAvailable() and (v40 >= (14 - 9)) and (v31.Rupture:AuraActiveCount() >= (v40 - (2 + 0)))) or not v31.ReplicatingShadows:IsAvailable();
end
local function v76(v103)
	return v6:BuffUp(v31.ShadowDanceBuff) and (v103:TimeSinceLastCast() < v31.ShadowDance:TimeSinceLastCast());
end
local function v77()
	local v104 = 0 - 0;
	if (v60:HasStatAnyDps() and (not v61:HasStatAnyDps() or (v60:Cooldown() >= v60:Cooldown()))) then
		v104 = 1188 - (1069 + 118);
	elseif (v61:HasStatAnyDps() and (not v60:HasStatAnyDps() or (v61:Cooldown() > v61:Cooldown()))) then
		v104 = 4 - 2;
	end
	return v104;
end
local function v78(v105)
	if v105:IsEquippedAndReady() then
		return ((v60:ID() == v105:ID()) and v63.Commons.Enabled.Trinket1) or ((v61:ID() == v105:ID()) and v63.Commons.Enabled.Trinket2);
	end
end
local function v79(v106, v107)
	if (v31.SecretTechnique:IsReady() and (v55 or v107)) then
		if v106 then
			return v31.SecretTechnique;
		end
		if v18(v31.SecretTechnique, true) then
			return "Cast Secret Technique";
		end
	end
	if v31.Rupture:IsReady() then
		if (not v53 and (not v7:DebuffUp(v31.Rupture) or v7:DebuffRefreshable(v31.Rupture, v46)) and (v7:TimeToDie() > (12 - 6))) then
			if v106 then
				return v31.Rupture;
			elseif v18(v31.Rupture, nil, not v7:IsSpellInRange(v31.Rupture)) then
				return "Cast Rupture";
			end
		end
	end
	if (v31.Rupture:IsReady() and not v53) then
		if (not v106 and v14.AoEON() and not v51 and (v40 >= (1 + 1))) then
			local function v128(v130)
				return v29.CanDoTUnit(v130, v47) and v130:DebuffRefreshable(v31.Rupture, v46);
			end
			v71(v31.Rupture, v128, (3 - 1) * v49, v41);
		end
	end
	if v31.Rupture:IsReady() then
		if (v31.UnseenBlade:IsAvailable() and (v31.Flagellation:CooldownRemains() <= (8 + 0)) and (v7:DebuffRemains(v31.Rupture) <= (v31.Flagellation:CooldownRemains() + (811 - (368 + 423)))) and ((v7:TimeToDie() > (18 - 12)) or (v63.Commons.Enabled.IgnoreTtdOnBoss and v59) or v29.Buggedmobs[v7:NPCID()])) then
			if v106 then
				return v31.Rupture;
			elseif v18(v31.Rupture, nil, not v7:IsSpellInRange(v31.Rupture)) then
				return "Cast Rupture";
			end
		end
	end
	if (v31.CoupDeGrace:IsCastable() and (v6:Energy() >= (53 - (10 + 8))) and v7:DebuffUp(v31.FazedDebuff)) then
		if v106 then
			return v31.CoupDeGrace;
		elseif v18(v31.CoupDeGrace, nil, not v7:IsSpellInRange(v31.CoupDeGrace)) then
			return "Cast Coup De Grace";
		end
	end
	if v31.BlackPowder:IsCastable() then
		if ((not v51 and v54 and (((v40 >= (7 - 5)) and v31.DeathStalkersMark:IsAvailable() and (v6:BuffDown(v31.DarkestNightBuff) or (v6:BuffUp(v31.ShadowDanceBuff) and (v40 >= (447 - (416 + 26)))))) or (v31.UnseenBlade:IsAvailable() and (v40 >= (22 - 15))))) or v31.CoupDeGrace:IsReady()) then
			if v106 then
				return v31.BlackPowder;
			elseif v18(v31.BlackPowder, nil, not v37) then
				return "Cast BlackPowder";
			end
		end
	end
	if v31.Eviscerate:IsCastable() then
		if v106 then
			return v31.Eviscerate;
		elseif v18(v31.Eviscerate, nil, not v7:IsSpellInRange(v31.Eviscerate)) then
			return "Cast Eviscerate";
		end
	end
	return false;
end
local function v80(v108, v109)
	if ((v31.Backstab:IsReady() and v7:IsSpellInRange(v31.Backstab) and (v6:BuffUp(v31.ShadowDanceBuff) or v109) and not v76(v31.Backstab)) or (not v52 and v6:BuffUp(v31.ShadowBlades))) then
		if v108 then
			return v31.Backstab;
		elseif v18(v31.Backstab) then
			return "Cast Backstab";
		end
	end
	if ((v31.Gloomblade:IsReady() and v7:IsSpellInRange(v31.Gloomblade) and (v6:BuffUp(v31.ShadowDanceBuff) or v109) and not v76(v31.Gloomblade)) or (not v52 and v6:BuffUp(v31.ShadowBlades))) then
		if v108 then
			return v31.Gloomblade;
		elseif v18(v31.Gloomblade) then
			return "Cast Gloomblade";
		end
	end
	if (v31.Shadowstrike:IsReady() and v14.AoEON() and v6:StealthUp(true, false)) then
		if (((v40 == (1 + 1)) and v31.UnseenBlade:IsAvailable()) or (not v76(v31.Shadowstrike) and not v31.Premeditation:IsAvailable())) then
			if v18(v31.Shadowstrike) then
				return "Cast ShadowstrikeShadowstrikeShadowstrike";
			end
		end
	end
	if (v65() and v31.ShurikenTornado:IsReady() and v31.ShurikenTornado:IsAvailable()) then
		if (v6:BuffUp(v31.LingeringDarknessBuff) or (v31.DeathStalkersMark:IsAvailable() and (v31.ShadowBlades:CooldownRemains() >= (56 - 24)) and (v40 >= (441 - (145 + 293)))) or (v31.UnseenBlade:IsAvailable() and v6:BuffUp(v31.SymbolsofDeath) and (v40 >= (434 - (44 + 386))))) then
			if v108 then
				return v31.ShurikenTornado;
			elseif v18(v31.ShurikenTornado, true) then
				return "Cast ShurikenTornado";
			end
		end
	end
	if (v65() and v31.ShurikenStorm:IsReady() and not v109 and v14.AoEON()) then
		if (v6:BuffUp(v31.ClearTheWitnessesBuff) and ((v40 >= (1488 - (998 + 488))) or v6:BuffDown(v31.SymbolsofDeath))) then
			if v108 then
				return v31.ShurikenStorm;
			elseif v18(v31.ShurikenStorm) then
				return "Cast ShurikenStorm";
			end
		end
	end
	if (v31.Shadowstrike:IsReady() and v14.AoEON() and v6:StealthUp(true, false)) then
		if (v31.DeathStalkersMark:IsAvailable() and v7:DebuffDown(v31.DeathStalkersMarkDebuff) and (v40 >= (1 + 2)) and (v6:BuffUp(v31.ShadowBlades) or v6:BuffUp(v31.PremeditationBuff) or v31.TheRotten:IsAvailable())) then
			for v131, v132 in v23(v39) do
				if (v132:GUID() ~= v7:GUID()) then
					if v18(v31.ShadowStrike) then
						return "Cast Shadowstrike";
					end
				end
			end
		end
	end
	if (v31.ShurikenStorm:IsReady() and not v109 and v14.AoEON()) then
		if (v31.DeathStalkersMark:IsAvailable() and (v40 >= (2 + 0 + ((775 - (201 + 571)) * v21(v6:BuffUp(v31.ShadowDanceBuff)))))) then
			if v108 then
				return v31.ShurikenStorm;
			elseif v18(v31.ShurikenStorm) then
				return "Cast ShurikenStorm";
			end
		end
	end
	if (v31.ShurikenStorm:IsReady() and not v109 and v14.AoEON() and v31.UnseenBlade:IsAvailable() and ((v6:BuffUp(v31.FlawlessFormBuff) and (v40 >= (1141 - (116 + 1022))) and not v52) or ((v6:BuffStack(v31.TheRottenBuff) == (4 - 3)) and (v40 >= (5 + 2)) and v6:BuffUp(v31.ShadowDanceBuff)))) then
		if v108 then
			return v31.ShurikenStorm;
		elseif v18(v31.ShurikenStorm) then
			return "Cast ShurikenStorm";
		end
	end
	if ((v31.Shadowstrike:IsReady() and v7:IsSpellInRange(v31.Shadowstrike)) or v109) then
		if v108 then
			return v31.Shadowstrike;
		elseif v18(v31.Shadowstrike) then
			return "Cast Shadowstrike";
		end
	end
	if (v14.CDsON() and v7:IsSpellInRange(v31.GoremawsBite) and v31.GoremawsBite:IsAvailable() and v31.GoremawsBite:IsReady()) then
		if (v50 >= (10 - 7)) then
			if v108 then
				return v31.GoremawsBite;
			elseif v18(v31.GoremawsBite) then
				return "Cast GoremawsBite";
			end
		end
	end
	if (v31.Gloomblade:IsCastable() and v7:IsSpellInRange(v31.Gloomblade)) then
		if v108 then
			return v31.Gloomblade;
		elseif v18(v31.Gloomblade) then
			return "Cast Gloomblade";
		end
	end
	if (v31.Backstab:IsCastable() and v7:IsSpellInRange(v31.Backstab)) then
		if v108 then
			return v31.Backstab;
		elseif v18(v31.Backstab) then
			return "Cast Backstab";
		end
	end
	return false;
end
local function v81(v110)
	local v111;
	if ((not v6:BuffUp(v31.DarkestNightBuff) and (v48 >= (21 - 15))) or (v6:BuffUp(v31.DarkestNightBuff) and (v49 == v30.CPMaxSpend()))) then
		v111 = v79(true, v110, true);
	end
	if not v111 then
		v111 = v80(true, true);
	end
	if ((v110:ID() == v31.Vanish:ID()) and (not v63.Subtlety.StealthMacro.Vanish or not v111)) then
		if v18(v31.Vanish, true) then
			return "Cast Vanish";
		end
		return false;
	elseif ((v110:ID() == v31.Shadowmeld:ID()) and (not v63.Subtlety.StealthMacro.Shadowmeld or not v111)) then
		if v18(v31.Shadowmeld, true) then
			return "Cast Shadowmeld";
		end
		return false;
	elseif ((v110:ID() == v31.ShadowDance:ID()) and (not v63.Subtlety.StealthMacro.ShadowDance or not v111)) then
		if v18(v31.ShadowDance, true) then
			return "Cast Shadow Dance";
		end
		return false;
	end
	local v112 = {v110,v111};
	v42 = v19(unpack(v112));
	if v42 then
		return "| " .. v112[1 + 1]:Name();
	end
	return false;
end
local function v82()
	if (v65() and v31.ColdBlood:IsReady() and v31.SecretTechnique:IsReady() and v6:BuffUp(v31.ShadowDanceBuff) and (v49 >= (3 + 3)) and v55 and v6:BuffUp(v31.FlagellationPersistBuff)) then
		if v18(v31.ColdBlood, true) then
			return "Cast Cold Blood";
		end
	end
	if v63.Commons.Enabled.Potions then
		local v124 = v29.PotionSelected();
		if (v124 and v124:IsReady() and (v6:BloodlustUp() or v3.BossFilteredFightRemains("<", 915 - (261 + 624)) or v6:BuffUp(v31.SymbolsofDeath)) and (v6:BuffUp(v31.ShadowBlades) or (v31.ShadowBlades:CooldownRemains() <= (17 - 7)))) then
			v14.CastMacro(1083 - (1020 + 60), nil, nil, v124);
			return "Cast Potion";
		end
	end
	if (v66() and v31.SymbolsofDeath:IsReady()) then
		if (((v6:BuffRemains(v31.SymbolsofDeath) <= (1426 - (630 + 793))) and v54 and (not v31.Flagellation:IsAvailable() or (((v31.Flagellation:CooldownRemains() >= ((101 - 71) - ((71 - 56) * v21(not v31.DeathPerception:IsAvailable())))) or v31.Flagellation:IsReady()) and (v31.SecretTechnique:CooldownRemains() <= (4 + 4))) or not v31.DeathPerception:IsAvailable())) or v3.BossFilteredFightRemains("<=", 51 - 36)) then
			if v18(v31.SymbolsofDeath, true) then
				return "Cast Symbols of Death";
			end
		end
	end
	if (v66() and v31.ShadowBlades:IsReady()) then
		if (v54 and v57 and v6:BuffUp(v31.ShadowDanceBuff) and not v6:BuffUp(v31.PremeditationBuff) and (v6:BuffUp(v31.FlagellationBuff) or v6:BuffUp(v31.FlagellationPersistBuff))) then
			if v18(v31.ShadowBlades, true) then
				return "Cast Shadow Blades";
			end
		end
	end
	if v31.ThistleTea:IsReady() then
		if ((v6:BuffRemains(v31.ShadowDanceBuff) > (1749 - (760 + 987))) and v6:BuffDown(v31.ThistleTea)) then
			if v18(v31.ThistleTea) then
				return "Thistle Tea";
			end
		end
	end
	if (v66() and v7:IsSpellInRange(v31.Flagellation) and v31.Flagellation:IsAvailable() and v31.Flagellation:IsReady() and (v31.ShadowDance:IsReady() or v6:BuffUp(v31.ShadowDanceBuff)) and (v31.SymbolsofDeath:IsReady() or v6:BuffUp(v31.SymbolsofDeath)) and (v31.ShadowBlades:IsReady() or v6:BuffUp(v31.ShadowBlades))) then
		if (((v49 >= (1918 - (1789 + 124))) and (v31.ShadowBlades:CooldownRemains() <= (769 - (745 + 21)))) or v3.BossFilteredFightRemains("<=", 9 + 16)) then
			if v18(v31.Flagellation) then
				return "Cast Flagellation";
			end
		end
	end
	return false;
end
local function v83()
	if (v31.BloodFury:IsCastable() and v56) then
		if v18(v31.BloodFury, true) then
			return "Cast Blood Fury";
		end
	end
	if (v31.Berserking:IsCastable() and v56) then
		if v18(v31.Berserking, true) then
			return "Cast Berserking";
		end
	end
	if (v31.Fireblood:IsCastable() and v56 and v6:BuffUp(v31.ShadowDanceBuff)) then
		if v18(v31.Fireblood, true) then
			return "Cast Fireblood";
		end
	end
	if (v31.AncestralCall:IsCastable() and v56) then
		if v18(v31.AncestralCall, true) then
			return "Cast Ancestral Call";
		end
	end
end
local function v84()
	if ((v63.Commons.Enabled.Trinket1 or v63.Commons.Enabled.Trinket2) and v66()) then
		if v78(v32.TreacherousTransmitter) then
			if (v6:BuffUp(v31.ShadowBlades) or v3.BossFilteredFightRemains("<=", 40 - 25)) then
				if v18(v32.TreacherousTransmitter) then
					return "Treacherous Transmitter";
				end
			end
		end
		if v78(v32.ImperfectAscendancySerum) then
			if (v7:DebuffUp(v31.Rupture) and v6:BuffUp(v31.Flagellation)) then
				if v18(v32.ImperfectAscendancySerum) then
					return "Imperfect Ascendancy Serum";
				end
			end
		end
		if v32.MadQueensMandate:IsEquippedAndReady() then
			if ((v7:IsInRange(196 - 146) and (not v31.LingeringDarkness:IsAvailable() or v6:BuffUp(v31.LingeringDarknessBuff) or v32.TreacherousTransmitter:IsEquipped()) and (not v32.TreacherousTransmitter:IsEquipped() or (v32.TreacherousTransmitter:CooldownRemains() > (1 + 19)))) or v3.BossFilteredFightRemains("<=", 12 + 3)) then
				if v18(v32.MadQueensMandate) then
					return "Mad Queens Mandate";
				end
			end
		end
		local v125;
		local v126 = 1155 - (87 + 968);
		if v60 then
			v125 = v60:OnUseSpell();
			v126 = (v125 and (v125.MaximumRange > (0 - 0)) and (v125.MaximumRange <= (91 + 9)) and v125.MaximumRange) or (226 - 126);
		end
		if v78(v60) then
			if (not v13(v33, v60:ID()) and (((v77() == (1414 - (447 + 966))) and (v6:BuffUp(v31.ShadowBlades) or (((2 - 1) + v31.ShadowBlades:CooldownRemains()) >= v60:CooldownRemains()) or v3.BossFilteredFightRemains("<=", 1837 - (1703 + 114)))) or ((v77() == (703 - (376 + 325))) and not v61:IsReady() and not v6:BuffUp(v31.ShadowBlades) and (v31.ShadowBlades:CooldownRemains() > (32 - 12))) or (v77() == (0 - 0)))) then
				if v18(v60) then
					return "Generic use_items for " .. v60:Name();
				end
			end
		end
		if v61 then
			v125 = v61:OnUseSpell();
			v126 = (v125 and (v125.MaximumRange > (0 + 0)) and (v125.MaximumRange <= (220 - 120)) and v125.MaximumRange) or (114 - (9 + 5));
		end
		if v78(v61) then
			if (not v13(v33, v61:ID()) and (((v77() == (378 - (85 + 291))) and (v6:BuffUp(v31.ShadowBlades) or (((1266 - (243 + 1022)) + v31.ShadowBlades:CooldownRemains()) >= v61:CooldownRemains()) or v3.BossFilteredFightRemains("<=", 76 - 56))) or ((v77() == (1 + 0)) and not v60:IsReady() and not v6:BuffUp(v31.ShadowBlades) and (v31.ShadowBlades:CooldownRemains() > (1200 - (1123 + 57)))) or (v77() == (0 + 0)))) then
				if v18(v61) then
					return "Generic use_items for " .. v61:Name();
				end
			end
		end
	end
	return false;
end
local function v85()
	if v64() then
		if v31.ShadowDance:IsReady() then
			if ((v57 and v54 and (v31.SecretTechnique:CooldownRemains() <= (278 - (163 + 91))) and ((v6:BuffRemains(v31.SymbolsofDeath) >= (1936 - (1869 + 61))) or (v6:BuffRemains(v31.ShadowBlades) >= (2 + 4)))) or v3.BossFilteredFightRemains("<=", 35 - 25)) then
				v42 = v81(v31.ShadowDance);
				if v42 then
					return "Shadow Dance Macro " .. v42;
				end
			end
		end
		if (v31.Vanish:IsReady() and v64()) then
			if ((v6:Energy() >= (61 - 21)) and not v6:BuffUp(v31.Subterfuge) and (v48 <= (1 + 2))) then
				v42 = v81(v31.Vanish);
				if v42 then
					return "Vanish Macro " .. v42;
				end
			end
		end
		if (v63.Commons.ShowPooling and v31.Shadowmeld:IsReady() and (v6:Energy() >= (54 - 14)) and (v50 >= (3 + 0))) then
			v42 = v81(v31.Shadowmeld);
			if v42 then
				return "Shadowmeld Macro " .. v42;
			end
			return false;
		end
	end
end
local function v86()
	if (v66() or v14.CDsON()) then
		if (v31.ArcaneTorrent:IsReady() and (v6:EnergyDeficitPredicted() >= ((1489 - (1329 + 145)) + v6:EnergyRegen()))) then
			if v18(v31.ArcaneTorrent, true) then
				return "Cast Arcane Torrent";
			end
		end
		if v31.ArcanePulse:IsReady() then
			if v18(v31.ArcanePulse, true) then
				return "Cast Arcane Pulse";
			end
		end
		if v31.LightsJudgment:IsReady() then
			if v18(v31.LightsJudgment, true) then
				return "Cast Lights Judgment";
			end
		end
		if v31.BagofTricks:IsReady() then
			if v18(v31.BagofTricks, true) then
				return "Cast Bag of Tricks";
			end
		end
	end
end
local function v87()
	v29.HealthPotions();
	v43 = nil;
	v45 = nil;
	v44 = 971 - (140 + 831);
	v34 = 1855 - (1409 + 441);
	v35 = 728 - (15 + 703);
	v36 = v7:IsInMeleeRange(v34);
	v37 = v7:IsInMeleeRange(v35);
	v58 = v3.BossFightRemains();
	v59 = true;
	if (v58 == (5146 + 5965)) then
		v59 = false;
		v58 = v3.FightRemains(v38, false);
	end
	if v15() then
		v38 = v6:GetEnemiesInRange(468 - (262 + 176));
		v39 = v6:GetEnemiesInMeleeRange(v35);
		v40 = #v39;
		v41 = v6:GetEnemiesInMeleeRange(v34);
	else
		v38 = {};
		v39 = {};
		v40 = 1722 - (345 + 1376);
		v41 = {};
	end
	v49 = v6:ComboPoints();
	v48 = v30.EffectiveComboPoints(v49);
	v50 = v6:ComboPointsDeficit();
	v51 = v70();
	v52 = v6:StealthUp(true, false);
	v53 = v6:BuffUp(v31.ShadowDanceBuff) or v6:BuffDown(v31.SliceandDice) or v6:BuffUp(v31.DarkestNightBuff) or ((v40 >= (696 - (198 + 490))) and not v31.ReplicatingShadows:IsAvailable() and v31.UnseenBlade:IsAvailable());
	v54 = (v7:DebuffUp(v31.Rupture) or v53) and (v6:BuffUp(v31.SliceandDice) or (v40 <= (8 - 6)));
	v55 = v6:BuffUp(v31.ShadowDanceBuff) or ((v31.Flagellation:CooldownRemains() < (95 - 55)) and (v31.Flagellation:CooldownRemains() > (1226 - (696 + 510))) and v31.DeathPerception:IsAvailable());
	v56 = (v6:BuffUp(v31.ShadowBlades) and v6:BuffUp(v31.ShadowDanceBuff)) or (not v31.ShadowBlades:IsAvailable() and v6:BuffUp(v31.SymbolsofDeath)) or v3.BossFilteredFightRemains("<", 41 - 21);
	v57 = (v49 <= (1263 - (1091 + 171))) or (v6:BuffUp(v31.DarkestNightBuff) and (v49 >= (2 + 5))) or ((v48 >= (18 - 12)) and v31.UnseenBlade:IsAvailable());
	if (v6:BuffUp(v31.ShurikenTornado, nil, true) and (v49 < v30.CPMaxSpend())) then
		local v127 = v30.TimeToNextTornado();
		if ((v127 <= v6:GCDRemains()) or (v27(v6:GCDRemains() - v127) < (0.25 - 0))) then
			local v129 = v40 + v21(v6:BuffUp(v31.ShadowBlades));
			v49 = v25(v49 + v129, v30.CPMaxSpend());
			v50 = v26(v50 - v129, 374 - (123 + 251));
			if (v48 < v30.CPMaxSpend()) then
				v48 = v49;
			end
		end
	end
	v46 = ((19 - 15) + (v48 * (702 - (208 + 490)))) * (0.3 + 0);
	v47 = v31.Eviscerate:Damage() * v63.Subtlety.EviscerateDMGOffset;
	v42 = v30.Defense();
	if v42 then
		return v42;
	end
	v42 = v30.Poisons();
	if v42 then
		return v42;
	end
	if not v6:AffectingCombat() then
		if (not v6:BuffUp(v31.ShadowDanceBuff) and not v6:BuffUp(v30.VanishBuffSpell())) then
			v42 = v30.Stealth(v30.StealthSpell());
			if v42 then
				return v42;
			end
		end
		if (v30.CombatCheck() and (v7:IsSpellInRange(v31.Shadowstrike) or v36)) then
			if (v49 >= (3 + 2)) then
				v42 = v79();
				if v42 then
					return v42 .. " (OOC)";
				end
			else
				v42 = v80();
				if v42 then
					return v42 .. " (OOC)";
				end
			end
		end
		return;
	end
	if v30.CombatCheck() then
		if v14.ToggleIconFrame:GetToggle(839 - (660 + 176)) then
			v42 = v29.InterruptCycle(v31.Kick, v34, true, nil, false);
			if v42 then
				return v42;
			end
			v42 = v29.IncorpCycle(v31.Blind, 2 + 13, true, nil, false);
			if v42 then
				return v42;
			end
			v42 = v63.Interrupt.UseBlind and v29.InterruptCycle(v31.Blind, 217 - (14 + 188), true, nil, true);
			if v42 then
				return v42;
			end
			v42 = v63.Interrupt.UseKidneyShot and (v49 > (675 - (534 + 141))) and v29.InterruptCycle(v31.KidneyShot, v34, true, nil, true);
			if v42 then
				return v42;
			end
			v42 = v63.Interrupt.UseCheapShop and v6:StealthUp(true, true) and v29.InterruptCycle(v31.CheapShot, v34, true, nil, true);
			if v42 then
				return v42;
			end
		end
		v42 = v63.Commons.Enabled.Shiv and v29.SootheCycle(v31.Shiv, 4 + 5, false, v63.Commons.Enabled["Shiv Auto Target"]);
		if v42 then
			return v42;
		end
		v42 = v82();
		if v42 then
			return "CDs: " .. v42;
		end
		v42 = v83();
		if v42 then
			return "Racials: " .. v42;
		end
		v42 = v84();
		if v42 then
			return "Items: " .. v42;
		end
		if (v31.SliceandDice:IsCastable() and (v49 >= (1 + 0)) and not v73()) then
			if (v31.SliceandDice:IsReady() and v18(v31.SliceandDice)) then
				return "Cast Slice and Dice";
			end
		end
		if not v6:StealthUp(true, false) then
			v42 = v85();
			if v42 then
				return "Stealth CDs: " .. v42;
			end
		end
		if ((not v6:BuffUp(v31.DarkestNightBuff) and (v48 >= (6 + 0))) or (v6:BuffUp(v31.DarkestNightBuff) and (v49 == v30.CPMaxSpend()))) then
			v42 = v79();
			if v42 then
				return "Finish: " .. v42;
			end
		end
		v42 = v80();
		if v42 then
			return "Build: " .. v42;
		end
		if not v52 then
			v42 = v86();
			if v42 then
				return "Fill: " .. v42;
			end
		end
		if (v31.ShurikenToss:IsCastable() and v7:IsInRange(63 - 33) and not v37 and not v6:StealthUp(true, true) and not v6:BuffUp(v31.Sprint) and (v6:EnergyDeficitPredicted() < (31 - 11)) and ((v50 >= (2 - 1)) or (v6:EnergyTimeToMax() <= (1.2 + 0)))) then
			if v18(v31.ShurikenToss) then
				return "Cast Shuriken Toss";
			end
		end
	end
end
local function v88(v113, v114)
	return (v113:gsub("{(.-)}", v114));
end
local function v89(v115)
	local v116 = v6:GetEquipment();
	local v117, v118 = v116[9 + 4], v116[410 - (115 + 281)];
	if (v117 and (v115:ID() == v117)) then
		return 30 - 17;
	elseif (v118 and (v115:ID() == v118)) then
		return 12 + 2;
	end
end
local function v90()
	v31.Rupture:RegisterAuraTracking();
	v63.Subtlety.Display();
	v29.PostInitialMessage(630 - 369);
	local v119 = {bloodFuryValue=((v31.BloodFury:IsAvailable() and ("/cast " .. v31.BloodFury:Name() .. "\n")) or (v31.Berserking:IsAvailable() and ("/cast " .. v31.Berserking:Name() .. "\n")) or ""),ColdBlood=((v31.ColdBlood:IsAvailable() and ("/cast " .. v31.ColdBlood:Name() .. "\n")) or ""),SecretTechnique=v31.SecretTechnique:Name()};
	v3.Timer.PulseOffset = 0.01 - 0;
	local v121 = "{bloodFuryValue}{ColdBlood}/cast {SecretTechnique}";
	v14:UpdateMacro("macro1", v88(v121, v119));
end
v14.SetAPL(1128 - (550 + 317), v87, v90);
