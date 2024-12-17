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
local v17 = v14.Cast;
local v18 = v14.CastLeftNameplate;
local v19 = v14.CastPooling;
local v20 = v14.CastQueue;
local v21 = v14.CastQueuePooling;
local v22 = v14.Commons().Everyone.num;
local v23 = v14.Commons().Everyone.bool;
local v24 = pairs;
local v25 = table.insert;
local v26 = math.min;
local v27 = math.max;
local v28 = math.abs;
local v29 = C_Timer.After;
local v30 = v14.Commons().Everyone;
local v31 = v14.Commons().Rogue;
local v32 = v9.Rogue.Subtlety;
local v33 = v11.Rogue.Subtlety;
local v34 = {v33.ImperfectAscendancySerum:ID(),v33.TreacherousTransmitter:ID()};
local v35, v36, v37, v38;
local v39, v40, v41, v42;
local v43;
local v44, v45, v46;
local v47, v48;
local v49, v50, v51, v52;
local v53;
local v54, v55;
local v56, v57 = v6:GetTrinketItems();
if ((v56:ID() == (0 - 0)) or (v57:ID() == (0 - 0))) then
	v29(621 - (555 + 64), function()
		v56, v57 = v6:GetTrinketItems();
	end);
end
v3:RegisterForEvent(function()
	v56, v57 = v6:GetTrinketItems();
end, "PLAYER_EQUIPMENT_CHANGED");
v32.Eviscerate:RegisterDamageFormula(function()
	return v6:AttackPowerDamageMod() * v49 * (931.176 - (857 + 74)) * (569.21 - (367 + 201)) * ((v32.Nightstalker:IsAvailable() and v6:StealthUp(true, false) and (928.08 - (214 + 713))) or (1 + 0)) * ((v32.DeeperStratagem:IsAvailable() and (1.05 + 0)) or (878 - (282 + 595))) * ((v32.DarkShadow:IsAvailable() and v6:BuffUp(v32.ShadowDanceBuff) and (1638.3 - (1523 + 114))) or (1 + 0)) * ((v6:BuffUp(v32.SymbolsofDeath) and (1.1 - 0)) or (1066 - (68 + 997))) * ((v6:BuffUp(v32.FinalityEviscerateBuff) and (1271.3 - (226 + 1044))) or (4 - 3)) * ((118 - (32 + 85)) + (v6:MasteryPct() / (99 + 1))) * (1 + 0 + (v6:VersatilityDmgPct() / (1057 - (892 + 65)))) * ((v7:DebuffUp(v32.FindWeaknessDebuff) and (2.5 - 1)) or (1 - 0));
end);
local v58 = v14.GUISettingsGet();
local v59 = {General=v58.General,Commons=v58.APL.Rogue.Commons,Subtlety=v58.APL.Rogue.Subtlety,Interrupt=v58.APL.Rogue.Subtlety_Interrupt};
local function v60()
	return not v30.ISSolo() or v7:IsDummy() or (not v6:IsTanking(v7) and v59.Commons.UseSoloVanish);
end
local function v61()
	return (v14.ToggleIconFrame:GetToggle(7 - 3) or v14.CDsON()) and v31.TTDCheck(v59.Subtlety.TimeToDie.Cooldowns, v59.Commons.Enabled.IgnoreTtdOnBoss and v55, v54);
end
local function v62()
	return v14.CDsON() and v31.TTDCheck(v59.Subtlety.TimeToDie.Cooldowns, v59.Commons.Enabled.IgnoreTtdOnBoss and v55, v54);
end
local function v63(v87, v88)
	if not v44 then
		v44 = v87;
		v45 = v88 or (350 - (87 + 263));
	end
end
local function v64(v89)
	if not v46 then
		v46 = v89;
	end
end
local function v65()
	if ((v59.Subtlety.BurnShadowDance == "On Bosses not in Dungeons") and v6:IsInDungeonArea()) then
		return false;
	elseif ((v59.Subtlety.BurnShadowDance ~= "Always") and not v7:IsInBossList()) then
		return false;
	else
		return true;
	end
end
local function v66()
	if (v41 < (182 - (67 + 113))) then
		return false;
	elseif ((v59.Subtlety.UsePriorityRotation == "On Bosses") and v7:IsInBossList()) then
		return true;
	end
	return v14.ToggleIconFrame:GetToggle(2 + 0);
end
local function v67(v90, v91, v92, v93)
	local v94, v95 = nil, v92;
	local v96 = v7:GUID();
	local v97 = v8:Exists() and v8:GUID();
	for v140, v141 in v24(v93) do
		if ((v141:GUID() ~= v96) and v91(v141)) then
			if ((v141:GUID() == v97) and ((v141:TimeToDie() > v92) or (v59.Commons.Enabled.IgnoreTtdOnBoss and v55) or v30.Buggedmobs[v7:NPCID()])) then
				v14.CastTarget(v90, v14.TName().MOUSEOVER);
				return "Cast Mouseover " .. v90:Name();
			end
			if v30.UnitIsCycleValid(v141, v95, -v141:DebuffRemains(v90)) then
				v94, v95 = v141, v141:TimeToDie();
			end
		end
	end
	if v94 then
		v18(v94, v90);
	end
end
local function v68()
	return (49 - 29) + (v32.Vigor:TalentRank() * (19 + 6)) + (v22(v32.ThistleTea:IsAvailable()) * (79 - 59)) + (v22(v32.Shadowcraft:IsAvailable()) * (972 - (802 + 150)));
end
local function v69()
	return v6:BuffUp(v32.SliceandDice);
end
local function v70(v98)
	return (v6:BuffUp(v32.ThistleTea) and (v41 == (2 - 1))) or (v98 and ((v41 == (1 - 0)) or (v7:DebuffUp(v32.Rupture) and (v41 >= (2 + 0))))) or v6:BuffUp(v32.DarkestNightBuff);
end
local function v71()
	return v53 or (v41 <= (1001 - (915 + 82))) or (v32.InvigoratingShadowdust:IsAvailable() and not v32.FollowTheBlood:IsAvailable()) or (v32.ReplicatingShadows:IsAvailable() and (v41 >= (14 - 9)) and (v32.Rupture:AuraActiveCount() >= (v41 - (2 + 0)))) or not v32.ReplicatingShadows:IsAvailable();
end
local function v72(v99)
	return v6:BuffUp(v32.ShadowDanceBuff) and (v99:TimeSinceLastCast() < v32.ShadowDance:TimeSinceLastCast());
end
local function v73()
	return (v6:BuffStack(v32.DanseMacabreBuff) >= (3 - 0)) or not v32.DanseMacabre:IsAvailable() or (v32.UnseenBlade:IsAvailable() and v6:BuffUp(v32.ShadowDanceBuff) and ((v6:BuffStack(v32.EscalatingBlade) >= (1189 - (1069 + 118))) or v6:BuffUp(v32.ShadowBlades)));
end
local function v74()
	local v100 = 0 - 0;
	if (v56:HasStatAnyDps() and (not v57:HasStatAnyDps() or (v56:Cooldown() >= v56:Cooldown()))) then
		v100 = 1 - 0;
	elseif (v57:HasStatAnyDps() and (not v56:HasStatAnyDps() or (v57:Cooldown() > v57:Cooldown()))) then
		v100 = 1 + 1;
	end
	return v100;
end
local function v75(v101)
	if v101:IsEquippedAndReady() then
		return ((v56:ID() == v101:ID()) and v59.Commons.Enabled.Trinket1) or ((v57:ID() == v101:ID()) and v59.Commons.Enabled.Trinket2);
	end
end
local function v76(v102, v103)
	local v104 = v6:BuffUp(v32.ShadowDanceBuff);
	local v105 = v6:BuffRemains(v32.ShadowDanceBuff);
	local v106 = v6:BuffRemains(v32.SymbolsofDeath);
	local v107 = v50;
	local v108 = v32.ColdBlood:CooldownRemains();
	local v109 = v32.SymbolsofDeath:CooldownRemains();
	local v110 = v6:BuffUp(v32.PremeditationBuff) or (v103 and v32.Premeditation:IsAvailable());
	if (v103 and (v103:ID() == v32.ShadowDance:ID())) then
		v104 = true;
		v105 = (13 - 5) + v32.ImprovedShadowDance:TalentRank();
		if v32.TheFirstDance:IsAvailable() then
			v107 = v26(v6:ComboPointsMax(), v50 + 4 + 0);
		end
		if v6:HasTier(821 - (368 + 423), 6 - 4) then
			v106 = v27(v106, 24 - (10 + 8));
		end
	end
	if (v103 and (v103:ID() == v32.Vanish:ID())) then
		v108 = v26(0 - 0, v32.ColdBlood:CooldownRemains() - ((457 - (416 + 26)) * v32.InvigoratingShadowdust:TalentRank()));
		v109 = v26(0 - 0, v32.SymbolsofDeath:CooldownRemains() - ((7 + 8) * v32.InvigoratingShadowdust:TalentRank()));
	end
	if (v32.Rupture:IsCastable() and v32.Rupture:IsReady()) then
		if (v7:DebuffDown(v32.Rupture) and ((v7:TimeToDie() > (9 - 3)) or (v59.Commons.Enabled.IgnoreTtdOnBoss and v55) or v30.Buggedmobs[v7:NPCID()])) then
			if v102 then
				return v32.Rupture;
			else
				if (v32.Rupture:IsReady() and v17(v32.Rupture)) then
					return "Cast Rupture 1";
				end
				v64(v32.Rupture);
			end
		end
	end
	if ((not v70(v104) or v53) and (v7:TimeToDie() > (444 - (145 + 293))) and v7:DebuffRefreshable(v32.Rupture, v47)) then
		if v102 then
			return v32.Rupture;
		else
			if (v32.Rupture:IsReady() and v17(v32.Rupture)) then
				return "Cast Rupture 2";
			end
			v64(v32.Rupture);
		end
	end
	if (v32.CoupDeGrace:IsReady() and v32.CoupDeGrace:IsCastable()) then
		if (v7:DebuffUp(v32.FazedDebuff) and (v6:BuffUp(v32.ShadowDanceBuff) or (v6:BuffUp(v32.SymbolsofDeath) and (v32.ShadowDance:ChargesFractional() <= (430.85 - (44 + 386)))))) then
			if v102 then
				return v32.CoupDeGrace;
			else
				if (v32.CoupDeGrace:IsReady() and v17(v32.CoupDeGrace)) then
					return "Cast Coup De Grace 1";
				end
				v64(v32.CoupDeGrace);
			end
		end
	end
	if v32.SecretTechnique:IsReady() then
		if (v73(v104, v110) and (not v32.ColdBlood:IsAvailable() or v32.ColdBlood:IsReady() or v6:BuffUp(v32.ColdBlood) or (v108 > (v105 - (1488 - (998 + 488)))) or not v32.ImprovedShadowDance:IsAvailable())) then
			if v102 then
				return v32.SecretTechnique;
			end
			if v14.CastMacro(4 + 6, nil, nil, v32.SecretTechnique) then
				return "Cast Secret Technique";
			end
		end
	end
	if (not v70(v104) and v32.Rupture:IsCastable()) then
		if (not v102 and v14.AoEON() and not v53 and (v41 >= (2 + 0))) then
			local function v147(v150)
				return v30.CanDoTUnit(v150, v48) and v150:DebuffRefreshable(v32.Rupture, v47);
			end
			local v148 = v67(v32.Rupture, v147, (774 - (201 + 571)) * v107, v42);
			if v148 then
				return v148;
			end
		end
		if (v6:BuffUp(v32.FinalityRuptureBuff) and ((v32.SymbolsofDeath:CooldownRemains() <= (1141 - (116 + 1022))) or v6:BuffUp(v32.SymbolsofDeath))) then
			if v102 then
				return v32.Rupture;
			else
				if (v32.Rupture:IsReady() and v17(v32.Rupture)) then
					return "Cast Rupture 2";
				end
				v64(v32.Rupture);
			end
		end
	end
	if (v32.BlackPowder:IsCastable() and not v53 and v32.DeathStalkersMark:IsAvailable() and (v41 >= (12 - 9)) and v6:BuffDown(v32.DarkestNightBuff)) then
		if v102 then
			return v32.BlackPowder;
		else
			if (v32.BlackPowder:IsReady() and v17(v32.BlackPowder)) then
				return "Cast Black Powder 1";
			end
			v64(v32.BlackPowder);
		end
	end
	if (v32.BlackPowder:IsCastable() and not v53 and v32.UnseenBlade:IsAvailable() and (((v6:BuffStack(v32.EscalatingBlade) == (3 + 1)) and v6:BuffDown(v32.ShadowDanceBuff)) or ((v41 >= (10 - 7)) and v6:BuffDown(v32.FlawlessFormBuff)) or (not v72(v32.BlackPowder) and v6:BuffUp(v32.ShadowDanceBuff) and v32.ShurikenTornado:IsAvailable() and (v41 >= (10 - 7))))) then
		if v102 then
			return v32.BlackPowder;
		else
			if (v32.BlackPowder:IsReady() and v17(v32.BlackPowder)) then
				return "Cast BlackPowder 2";
			end
			v64(v32.BlackPowder);
		end
	end
	if (v32.CoupDeGrace:IsCastable() and v37 and v7:DebuffUp(v32.FazedDebuff)) then
		if v102 then
			return v32.CoupDeGrace;
		else
			if (v32.CoupDeGrace:IsReady() and v17(v32.CoupDeGrace)) then
				return "Cast Coup De Grace 2";
			end
			v64(v32.CoupDeGrace);
		end
	end
	if (v32.Eviscerate:IsCastable() and v37) then
		if v102 then
			return v32.Eviscerate;
		else
			if (v32.Eviscerate:IsReady() and v17(v32.Eviscerate)) then
				return "Cast Eviscerate";
			end
			v64(v32.Eviscerate);
		end
	end
	return false;
end
local function v77(v111, v112)
	local v113 = v6:BuffUp(v32.ShadowDanceBuff);
	local v114 = v6:BuffRemains(v32.ShadowDanceBuff);
	local v115 = v6:BuffUp(v32.TheRottenBuff);
	local v116, v117 = v50, v51;
	local v118 = v6:BuffUp(v32.PremeditationBuff) or (v112 and v32.Premeditation:IsAvailable());
	local v119 = v6:BuffUp(v31.StealthSpell()) or (v112 and (v112:ID() == v31.StealthSpell():ID()));
	local v120 = v6:BuffUp(v31.VanishBuffSpell()) or (v112 and (v112:ID() == v32.Vanish:ID()));
	if (v112 and (v112:ID() == v32.ShadowDance:ID())) then
		v113 = true;
		v114 = (867 - (814 + 45)) + v32.ImprovedShadowDance:TalentRank();
		if (v32.TheRotten:IsAvailable() and v6:HasTier(73 - 43, 1 + 1)) then
			v115 = true;
		end
		if v32.TheFirstDance:IsAvailable() then
			v116 = v26(v6:ComboPointsMax(), v50 + 2 + 2);
			v117 = v6:ComboPointsMax() - v116;
		end
	end
	local v121 = v31.EffectiveComboPoints(v116);
	local v122 = v32.Shadowstrike:IsCastable() or v119 or v120 or v113 or v6:BuffUp(v32.SepsisBuff);
	if (v119 or v120) then
		v122 = v122 and v7:IsInRange(910 - (261 + 624));
	else
		v122 = v122 and v37;
	end
	if (v122 and v32.DeathStalkersMark:IsAvailable() and v7:DebuffDown(v32.DeathStalkersMarkDebuff) and v6:BuffDown(v32.DarkestNightBuff)) then
		if v111 then
			return v32.Shadowstrike;
		elseif v17(v32.Shadowstrike) then
			return "Cast Shadowstrike (Stealth 1)";
		end
	end
	if (v6:BuffUp(v32.DarkestNightBuff) and (v50 == v31.CPMaxSpend())) then
		return v76(v111, v112);
	end
	if ((v49 >= v31.CPMaxSpend()) and v6:BuffDown(v32.DarkestNightBuff)) then
		return v76(v111, v112);
	end
	if (v6:BuffUp(v32.ShurikenTornado) and (v117 <= (3 - 1)) and v6:BuffDown(v32.DarkestNightBuff)) then
		return v76(v111, v112);
	end
	if ((v51 <= ((1081 - (1020 + 60)) + v22(v32.DeathStalkersMark:IsAvailable()))) and v6:BuffDown(v32.DarkestNightBuff)) then
		return v76(v111, v112);
	end
	if ((v122 and not v72(v32.Shadowstrike) and v6:BuffUp(v32.ShadowBlades)) or (v32.UnseenBlade:IsAvailable() and (v41 >= (1425 - (630 + 793))))) then
		if v111 then
			return v32.Shadowstrike;
		elseif v17(v32.Shadowstrike) then
			return "Cast Shadowstrike (Stealth 2)";
		end
	end
	if v32.ShurikenStorm:IsCastable() then
		if (v6:BuffDown(v32.PremeditationBuff) and (v41 >= (13 - 9))) then
			if v111 then
				return v32.ShurikenStorm;
			elseif v17(v32.ShurikenStorm) then
				return "Cast ShurikenStorm (Stealth)";
			end
		end
	end
	if v32.Gloomblade:IsAvailable() then
		if ((v6:BuffRemains(v32.LingeringShadowBuff) >= (47 - 37)) and v6:BuffUp(v32.ShadowBlades) and (v41 == (1 + 0))) then
			if v111 then
				if v112 then
					return v32.Gloomblade;
				else
					return {v32.Gloomblade,v32.Stealth};
				end
			elseif v20(v32.Gloomblade, v32.Stealth) then
				return "Cast Gloomblade (Danse)";
			end
		end
	end
	if v122 then
		if v111 then
			return v32.Shadowstrike;
		elseif v17(v32.Shadowstrike) then
			return "Cast Shadowstrike";
		end
	end
	return false;
end
local function v78(v123, v124)
	if not v14.ToggleIconFrame:GetToggle(1914 - (1789 + 124)) then
		return;
	end
	if (v123:ID() == v32.Vanish:ID()) then
		if v14.Cast(v32.Vanish, true) then
			return "Cast Vanish";
		end
		return false;
	elseif (v123:ID() == v32.Shadowmeld:ID()) then
		if v14.Cast(v32.Shadowmeld, true) then
			return "Cast Shadowmeld";
		end
		return false;
	elseif (v123:ID() == v32.ShadowDance:ID()) then
		if v14.Cast(v32.ShadowDance, true) then
			return "Cast Shadow Dance";
		end
		return false;
	end
	local v125 = v77(true, v123);
	local v126 = {v123,v125};
	if (v124 and (v6:EnergyPredicted() < v124)) then
		v63(v126, v124);
		return false;
	end
	v43 = v14.CastQueue(unpack(v126));
	if v43 then
		return "| " .. v126[5 - 3]:Name();
	end
	return false;
end
local function v79()
	if (v61() and v32.ColdBlood:IsReady() and not v32.SecretTechnique:IsAvailable() and (v50 >= (23 - 17))) then
		if v17(v32.ColdBlood, true) then
			return "Cast Cold Blood";
		end
	end
	if (v62() and v32.Sepsis:IsAvailable() and v32.Sepsis:IsReady()) then
		if (v69() and (((v32.ShadowBlades:CooldownRemains() <= (1 + 2)) and (v32.SymbolsofDeath:CooldownRemains() <= (3 + 0))) or v3.BossFilteredFightRemains("<=", 1067 - (87 + 968)))) then
			if v17(v32.Sepsis) then
				return "Cast Sepsis";
			end
		end
	end
	if (v62() and v32.Flagellation:IsAvailable() and v32.Flagellation:IsReady()) then
		if (v69() and v71() and (v49 >= (22 - 17)) and ((v7:TimeToDie() > (10 + 0)) or (v59.Commons.Enabled.IgnoreTtdOnBoss and v55) or v30.Buggedmobs[v7:NPCID()]) and ((v32.ShadowBlades:CooldownRemains() <= (4 - 2)) or v3.BossFilteredFightRemains("<=", 1437 - (447 + 966))) and (not v32.InvigoratingShadowdust:IsAvailable() or (v32.SymbolsofDeath:CooldownRemains() <= (8 - 5)) or (v6:BuffRemains(v32.SymbolsofDeath) > (1820 - (1703 + 114))))) then
			if v17(v32.Flagellation) then
				return "Cast Flagellation";
			end
		end
	end
	if (v61() and v32.SymbolsofDeath:IsReady()) then
		if (not v32.InvigoratingShadowdust:IsAvailable() and v69() and (v6:BuffUp(v32.ShadowBlades) or (v32.ShadowBlades:CooldownRemains() > (721 - (376 + 325))) or not v62())) then
			if v17(v32.SymbolsofDeath, true) then
				return "Cast Symbols of Death without Dust";
			end
		end
	end
	if (v61() and v32.SymbolsofDeath:IsReady()) then
		if (v32.InvigoratingShadowdust:IsAvailable() and v69() and (v6:BuffRemains(v32.SymbolsofDeath) <= (4 - 1)) and v6:BuffDown(v32.TheRottenBuff) and ((v32.Flagellation:CooldownRemains() > (30 - 20)) or (v32.Flagellation:IsReady() and (v32.ShadowBlades:CooldownRemains() >= (6 + 14))) or not v62() or (v6:BuffRemains(v32.ShadowDanceBuff) >= (4 - 2)))) then
			if v17(v32.SymbolsofDeath, true) then
				return "Cast Symbols of Death with Dust";
			end
		end
	end
	if (v62() and v32.ShadowBlades:IsReady()) then
		if ((v69() and (v49 <= (15 - (9 + 5))) and (v6:BuffUp(v32.Flagellation) or not v32.Flagellation:IsAvailable())) or v3.BossFilteredFightRemains("<=", 396 - (85 + 291))) then
			if v17(v32.ShadowBlades, true) then
				return "Cast Shadow Blades";
			end
		end
	end
	if (v61() and v32.EchoingReprimand:IsCastable() and v32.EchoingReprimand:IsAvailable()) then
		if (v69() and (v51 >= (1268 - (243 + 1022))) and (not v32.TheRotten:IsAvailable() or not v32.Reverberation:IsAvailable() or v6:BuffUp(v32.ShadowDance))) then
			if v17(v32.EchoingReprimand) then
				return "Cast Echoing Reprimand";
			end
		end
	end
	if (v61() and v32.ShurikenTornado:IsAvailable() and v32.ShurikenTornado:IsReady()) then
		if (v69() and v6:BuffUp(v32.SymbolsofDeath) and (v49 <= (7 - 5)) and not v6:BuffUp(v32.PremeditationBuff) and (not v32.Flagellation:IsAvailable() or not v62() or (v32.Flagellation:CooldownRemains() > (17 + 3))) and (v41 >= (1183 - (1123 + 57)))) then
			if v17(v32.ShurikenTornado) then
				return "Cast Shuriken Tornado 1";
			end
		end
	end
	if (v61() and v32.ShurikenTornado:IsAvailable() and v32.ShurikenTornado:IsReady()) then
		if (v69() and v6:BuffDown(v32.ShadowDanceBuff) and v6:BuffDown(v32.Flagellation) and v6:BuffDown(v32.FlagellationPersistBuff) and v6:BuffDown(v32.ShadowBlades) and (v41 <= (2 + 0))) then
			if v17(v32.ShurikenTornado) then
				return "Cast Shuriken Tornado 2";
			end
		end
	end
	if (v61() and v32.Vanish:IsReady()) then
		if (v6:BuffUp(v32.ShadowDanceBuff) and v32.InvigoratingShadowdust:IsAvailable() and v32.UnseenBlade:IsAvailable() and (v51 > (255 - (163 + 91))) and ((v32.Flagellation:CooldownRemains() >= (1990 - (1869 + 61))) or not v62() or not v32.Flagellation:IsAvailable() or v3.BossFilteredFightRemains("<=", (9 + 21) * v32.Vanish:Charges())) and (v32.SecretTechnique:CooldownRemains() >= (35 - 25))) then
			v43 = v78(v32.Vanish, v52);
			if v43 then
				return "Vanish Macro" .. v43;
			end
		end
	end
	if (v61() and v6:BuffDown(v32.ShadowDanceBuff) and v32.ShadowDance:IsReady() and v32.ShadowDance:IsCastable() and v32.InvigoratingShadowdust:IsAvailable() and v6:BuffUp(v32.ShadowBlades)) then
		if ((v32.DeathStalkersMark:IsAvailable() and v6:BuffUp(v32.SubterfugeBuff)) or (v7:DebuffUp(v32.Rupture) and v69() and v32.UnseenBlade:IsAvailable())) then
			v43 = v78(v32.ShadowDance, v52);
			if v43 then
				return "Shadow Dance Macro" .. v43;
			end
		end
	end
	if (v61() and v32.GoremawsBite:IsAvailable() and v32.GoremawsBite:IsReady()) then
		if (v69() and (v51 >= (4 - 1)) and (not v32.ShadowDance:IsReady() or (v32.DoubleDance:IsAvailable() and v6:BuffUp(v32.ShadowDanceBuff) and not v32.InvigoratingShadowdust:IsAvailable()) or ((v41 < (1 + 3)) and not v32.InvigoratingShadowdust:IsAvailable()) or v32.TheRotten:IsAvailable())) then
			if v17(v32.GoremawsBite) then
				return "Cast Goremaw's Bite";
			end
		end
	end
	if v32.ThistleTea:IsReady() then
		if (v6:BuffDown(v32.ThistleTea) and ((v6:BuffRemains(v32.ShadowDanceBuff) >= (7 - 1)) or v3.BossFilteredFightRemains("<=", (6 + 0) * v32.ThistleTea:Charges()))) then
			if v17(v32.ThistleTea, true) then
				return "Thistle Tea";
			end
		end
	end
	if v59.Commons.Enabled.Potions then
		local v142 = v30.PotionSelected();
		if (v142 and v142:IsReady() and (v6:BloodlustUp() or v3.BossFilteredFightRemains("<", 1504 - (1329 + 145)) or v6:BuffUp(v32.SymbolsofDeath)) and (v6:BuffUp(v32.ShadowBlades) or (v32.ShadowBlades:CooldownRemains() <= (981 - (140 + 831))))) then
			v14.CastMacro(1853 - (1409 + 441), nil, nil, v142);
			return "Cast Potion";
		end
	end
	local v127 = v59.Commons.Enabled.Racials and (v6:BuffUp(v32.ShadowBlades) or (not v32.ShadowBlades:IsAvailable() and v6:BuffUp(v32.SymbolsofDeath)) or v3.BossFilteredFightRemains("<", 738 - (15 + 703)));
	if (v32.BloodFury:IsCastable() and v127) then
		if v14.Cast(v32.BloodFury, true) then
			return "Cast Blood Fury";
		end
	end
	if (v32.Berserking:IsCastable() and v127) then
		if v14.Cast(v32.Berserking, true) then
			return "Cast Berserking";
		end
	end
	if (v32.Fireblood:IsCastable() and v127) then
		if v14.Cast(v32.Fireblood, true) then
			return "Cast Fireblood";
		end
	end
	if (v32.AncestralCall:IsCastable() and v127) then
		if v14.Cast(v32.AncestralCall, true) then
			return "Cast Ancestral Call";
		end
	end
	return false;
end
local function v80()
	if ((v59.Commons.Enabled.Trinket1 or v59.Commons.Enabled.Trinket2) and v62()) then
		if v75(v33.TreacherousTransmitter) then
			if (v6:BuffUp(v32.ShadowBlades) or v3.BossFilteredFightRemains("<=", 7 + 8)) then
				if v17(v33.TreacherousTransmitter) then
					return "Treacherous Transmitter";
				end
			end
		end
		if v75(v33.ImperfectAscendancySerum) then
			if (v7:DebuffUp(v32.Rupture) and v6:BuffUp(v32.Flagellation)) then
				if v17(v33.ImperfectAscendancySerum) then
					return "Imperfect Ascendancy Serum";
				end
			end
		end
		local v143;
		local v144 = 538 - (262 + 176);
		if v56 then
			v143 = v56:OnUseSpell();
			v144 = (v143 and (v143.MaximumRange > (1721 - (345 + 1376))) and (v143.MaximumRange <= (788 - (198 + 490))) and v143.MaximumRange) or (441 - 341);
		end
		if v75(v56) then
			if (not v13(v34, v56:ID()) and (((v74() == (2 - 1)) and (v6:BuffUp(v32.ShadowBlades) or (((1207 - (696 + 510)) + v32.ShadowBlades:CooldownRemains()) >= v56:CooldownRemains()) or v3.BossFilteredFightRemains("<=", 41 - 21))) or ((v74() == (1264 - (1091 + 171))) and not v57:IsReady() and not v6:BuffUp(v32.ShadowBlades) and (v32.ShadowBlades:CooldownRemains() > (4 + 16))) or (v74() == (0 - 0)))) then
				if v17(v56) then
					return "Generic use_items for " .. v56:Name();
				end
			end
		end
		if v57 then
			v143 = v57:OnUseSpell();
			v144 = (v143 and (v143.MaximumRange > (0 - 0)) and (v143.MaximumRange <= (474 - (123 + 251))) and v143.MaximumRange) or (496 - 396);
		end
		if v75(v57) then
			if (not v13(v34, v57:ID()) and (((v74() == (700 - (208 + 490))) and (v6:BuffUp(v32.ShadowBlades) or ((1 + 0 + v32.ShadowBlades:CooldownRemains()) >= v57:CooldownRemains()) or v3.BossFilteredFightRemains("<=", 9 + 11))) or ((v74() == (837 - (660 + 176))) and not v56:IsReady() and not v6:BuffUp(v32.ShadowBlades) and (v32.ShadowBlades:CooldownRemains() > (3 + 17))) or (v74() == (202 - (14 + 188))))) then
				if v17(v57) then
					return "Generic use_items for " .. v57:Name();
				end
			end
		end
	end
	return false;
end
local function v81(v128)
	if (v61() and not (v30.IsSoloMode() and v6:IsTanking(v7))) then
		local v145 = not v32.ColdBlood:IsAvailable() or (v32.ColdBlood:CooldownRemains() < (679 - (534 + 141))) or (v32.ColdBlood:CooldownRemains() > (5 + 5));
		if (v60() and v32.Vanish:IsCastable()) then
			if (not v32.InvigoratingShadowdust:IsAvailable() and not v32.Subterfuge:IsAvailable() and (v51 >= (3 + 0)) and (v7:DebuffDown(v32.Rupture) or (v6:BuffUp(v32.ShadowBlades) and v6:BuffUp(v32.SymbolsofDeath)) or v32.Premeditation:IsAvailable() or v3.BossFilteredFightRemains("<", 10 + 0))) then
				v43 = v78(v32.Vanish, v128);
				if v43 then
					return "Vanish Macro 1 No Dust" .. v43;
				end
			end
		end
		if (v60() and v32.Vanish:IsCastable()) then
			if (v6:BuffDown(v32.ShadowDanceBuff) and v32.InvigoratingShadowdust:IsAvailable() and v32.DeathStalkersMark:IsAvailable() and ((v51 > (1 - 0)) or v6:BuffUp(v32.ShadowBlades)) and ((v32.Flagellation:CooldownRemains() >= (95 - 35)) or not v32.Flagellation:IsAvailable() or not v62() or v3.BossFilteredFightRemains("<=", (84 - 54) * v32.Vanish:Charges())) and (v32.SecretTechnique:CooldownRemains() >= (6 + 4))) then
				v43 = v78(v32.Vanish, v128);
				if v43 then
					return "Vanish Macro 2 Dust" .. v43;
				end
			end
		end
		if (v32.ShadowDance:IsReady() and v32.ShadowDance:IsCastable()) then
			if (v7:DebuffUp(v32.Rupture) and v69() and (((v6:BuffRemains(v32.SymbolsofDeath) >= (4 + 2)) and v6:BuffDown(v32.Flagellation)) or (v6:BuffUp(v32.SymbolsofDeath) and v6:BuffUp(v32.ShadowBlades)) or (v6:BuffUp(v32.ShadowBlades) and not v32.InvigoratingShadowdust:IsAvailable())) and (v32.SecretTechnique:CooldownRemains() < ((406 - (115 + 281)) + ((27 - 15) * v22(v32.InvigoratingShadowdust:IsAvailable())))) and (not v32.TheFirstDance:IsAvailable() or ((v51 >= (6 + 1)) and v6:BuffDown(v32.ShadowBlades)) or v6:BuffUp(v32.ShadowBlades))) then
				v43 = v78(v32.ShadowDance, v128);
				if v43 then
					return "Shadow Dance Macro 1 " .. v43;
				end
			end
		end
		if (v60() and v32.Vanish:IsCastable()) then
			if (not v32.InvigoratingShadowdust:IsAvailable() and not v32.Subterfuge:IsAvailable() and (v51 >= (7 - 4)) and (v6:BuffUp(v32.SymbolsofDeath) or (v32.SymbolsofDeath:CooldownRemains() >= (10 - 7)))) then
				v43 = v78(v32.Vanish, v128);
				if v43 then
					return "Vanish Macro 3 No Dust Subterfuge " .. v43;
				end
			end
		end
		if (v59.Commons.ShowPooling and (v6:Energy() < (907 - (550 + 317))) and v32.Shadowmeld:IsCastable() and (v51 > (3 - 0))) then
			if v19(v32.Shadowmeld, v6:EnergyTimeToX(56 - 16)) then
				return "Pool for Shadowmeld";
			end
		end
	end
	return false;
end
local function v82(v129)
	local v130 = not v129 or (v6:EnergyPredicted() >= v129);
	if (v14.AoEON() and v32.ShurikenStorm:IsCastable() and (v41 >= (((5 - 3) + v12((v32.Gloomblade:IsAvailable() and (v6:BuffRemains(v32.LingeringShadowBuff) >= (291 - (134 + 151)))) or v6:BuffUp(v32.PerforatedVeinsBuff))) - v12(v7:BuffDown(v32.FindWeaknessDebuff) and not v32.ImprovedBackstab:IsAvailable()))) and (v6:BuffUp(v32.FlawlessFormBuff) or not v32.UnseenBlade:IsAvailable())) then
		if (v130 and v17(v32.ShurikenStorm)) then
			return "Cast Shuriken Storm";
		end
		v63(v32.ShurikenStorm, v129);
	end
	if (v14.AoEON() and v32.ShurikenStorm:IsCastable()) then
		if (v6:BuffUp(v32.ClearTheWitnessesBuff) and (v6:BuffDown(v32.SymbolsofDeath) or not v32.Inevitability:IsAvailable()) and ((v6:BuffRemains(v32.LingeringShadowBuff) <= (1671 - (970 + 695))) or not v32.LingeringShadow:IsAvailable())) then
			if (v130 and v17(v32.ShurikenStorm)) then
				return "Cast Shuriken Storm Deathstalker ST";
			end
			v63(v32.ShurikenStorm, v129);
		end
	end
	if v37 then
		if v32.Gloomblade:IsCastable() then
			if (v130 and v17(v32.Gloomblade)) then
				return "Cast Gloomblade";
			end
			v63(v32.Gloomblade, v129);
		elseif v32.Backstab:IsCastable() then
			if (v130 and v17(v32.Backstab)) then
				return "Cast Backstab";
			end
			v63(v32.Backstab, v129);
		end
	end
	return false;
end
local function v83()
	v44 = nil;
	v46 = nil;
	v45 = 0 - 0;
	v35 = 1995 - (582 + 1408);
	v36 = 34 - 24;
	v37 = v7:IsInMeleeRange(v35);
	v38 = v7:IsInMeleeRange(v36);
	v54 = v3.BossFightRemains();
	v55 = true;
	if (v54 == (13979 - 2868)) then
		v55 = false;
		v54 = v3.FightRemains(v39, false);
	end
	if v15() then
		v39 = v6:GetEnemiesInRange(113 - 83);
		v40 = v6:GetEnemiesInMeleeRange(v36);
		v41 = #v40;
		v42 = v6:GetEnemiesInMeleeRange(v35);
	else
		v39 = {};
		v40 = {};
		v41 = 1825 - (1195 + 629);
		v42 = {};
	end
	v50 = v6:ComboPoints();
	v49 = v31.EffectiveComboPoints(v50);
	v51 = v6:ComboPointsDeficit();
	v53 = v66();
	v52 = v6:EnergyMax() - v68();
	if (v6:BuffUp(v32.ShurikenTornado, nil, true) and (v50 < v31.CPMaxSpend())) then
		local v146 = v31.TimeToNextTornado();
		if ((v146 <= v6:GCDRemains()) or (v28(v6:GCDRemains() - v146) < (0.25 - 0))) then
			local v149 = v41 + v22(v6:BuffUp(v32.ShadowBlades));
			v50 = v26(v50 + v149, v31.CPMaxSpend());
			v51 = v27(v51 - v149, 241 - (187 + 54));
			if (v49 < v31.CPMaxSpend()) then
				v49 = v50;
			end
		end
	end
	v47 = ((784 - (162 + 618)) + (v49 * (3 + 1))) * (0.3 + 0);
	v48 = v32.Eviscerate:Damage() * v59.Subtlety.EviscerateDMGOffset;
	v43 = v31.Defense();
	if v43 then
		return v43;
	end
	v43 = v31.Poisons();
	if v43 then
		return v43;
	end
	if not v6:AffectingCombat() then
		if (not v6:BuffUp(v32.ShadowDanceBuff) and not v6:BuffUp(v31.VanishBuffSpell())) then
			v43 = v31.Stealth(v31.StealthSpell());
			if v43 then
				return v43;
			end
		end
		if (v31.CombatCheck() and (v7:IsSpellInRange(v32.Shadowstrike) or v37)) then
			if v6:StealthUp(true, true) then
				v44 = v77(true);
				if v44 then
					if (v32.ColdBlood:IsCastable() and v32.ColdBlood:IsReady()) then
						if v14.Cast(v32.ColdBlood) then
							return "Cast Cold Blood (OOC)";
						end
					end
					if (v44:ID() == v32.SecretTechnique:ID()) then
						if v14.CastMacro(21 - 11, nil, nil, v32.SecretTechnique) then
							return "Cast Secret Technique";
						end
					end
					if ((type(v44) == "table") and (#v44 > (1 - 0))) then
						if v21(nil, unpack(v44)) then
							return "Stealthed Macro Cast or Pool (OOC): " .. v44[1 + 0]:Name();
						end
					elseif v19(v44) then
						return "Stealthed Cast or Pool (OOC): " .. v44:Name();
					end
				end
			elseif (v50 >= (1641 - (1373 + 263))) then
				v43 = v76();
				if v43 then
					return v43 .. " (OOC)";
				end
			elseif v32.Backstab:IsCastable() then
				if v17(v32.Backstab) then
					return "Cast Backstab (OOC)";
				end
			end
		end
		return;
	end
	if v31.CombatCheck() then
		if v14.ToggleIconFrame:GetToggle(1003 - (451 + 549)) then
			v43 = v30.InterruptCycle(v32.Kick, v35, true, nil, false);
			if v43 then
				return v43;
			end
			v43 = v30.IncorpCycle(v32.Blind, 5 + 10, true, nil, false);
			if v43 then
				return v43;
			end
			v43 = v59.Interrupt.UseBlind and v30.InterruptCycle(v32.Blind, 23 - 8, true, nil, true);
			if v43 then
				return v43;
			end
			v43 = v59.Interrupt.UseKidneyShot and (v50 > (0 - 0)) and v30.InterruptCycle(v32.KidneyShot, v35, true, nil, true);
			if v43 then
				return v43;
			end
			v43 = v59.Interrupt.UseCheapShop and v6:StealthUp(true, true) and v30.InterruptCycle(v32.CheapShot, v35, true, nil, true);
			if v43 then
				return v43;
			end
		end
		v43 = v59.Commons.Enabled.Shiv and v30.SootheCycle(v32.Shiv, 1393 - (746 + 638), false, v59.Commons.Enabled["Shiv Auto Target"]);
		if v43 then
			return v43;
		end
		v43 = v79();
		if v43 then
			return "CDs: " .. v43;
		end
		v43 = v80();
		if v43 then
			return "Items: " .. v43;
		end
		if (v32.SliceandDice:IsCastable() and (v50 >= (1 + 0)) and not v69()) then
			if (v32.SliceandDice:IsReady() and v17(v32.SliceandDice)) then
				return "Cast Slice and Dice";
			end
		end
		if v6:StealthUp(true, true) then
			v44 = v77(true);
			if v44 then
				if (v44:ID() == v32.SecretTechnique:ID()) then
					if v14.CastMacro(15 - 5, nil, nil, v32.SecretTechnique) then
						return "Cast Secret Technique";
					end
				end
				if ((type(v44) == "table") and (#v44 > (342 - (218 + 123)))) then
					if v21(nil, unpack(v44)) then
						return "Stealthed Macro " .. v44[1582 - (1535 + 46)]:Name() .. "|" .. v44[2 + 0]:Name();
					end
				elseif (v6:BuffUp(v32.ShurikenTornado) and (v50 ~= v6:ComboPoints()) and ((v44 == v32.BlackPowder) or (v44 == v32.Eviscerate) or (v44 == v32.Rupture) or (v44 == v32.SliceandDice))) then
					if v21(nil, v32.ShurikenTornado, v44) then
						return "Stealthed Tornado Cast  " .. v44:Name();
					end
				elseif v19(v44) then
					return "Stealthed Cast " .. v44:Name();
				end
			end
			v17(v32.PoolEnergy);
			return "Stealthed Pooling";
		end
		v43 = v81(v52);
		if v43 then
			return "Stealth CDs: " .. v43;
		end
		if (v6:BuffUp(v32.DarkestNightBuff) and (v50 == v31.CPMaxSpend())) then
			v43 = v76();
			if v43 then
				return "Finish: 1 " .. v43;
			end
		end
		if ((v49 >= v31.CPMaxSpend()) and v6:BuffDown(v32.DarkestNightBuff)) then
			v43 = v76();
			if v43 then
				return "Finish: 2 " .. v43;
			end
		end
		if (((v51 <= (1 + 0 + v22(v32.DeathStalkersMark:IsAvailable()))) or (v3.FilteredFightRemains(v40, "<=", 561 - (306 + 254)) and (v49 >= (1 + 2)))) and v6:BuffDown(v32.DarkestNightBuff)) then
			v43 = v76();
			if v43 then
				return "Finish: 3 " .. v43;
			end
		end
		if v46 then
			v63(v46);
		end
		v43 = v82(v52);
		if v43 then
			return "Build: " .. v43;
		end
		if (v61() and v59.Commons.Enabled.Racials) then
			if (v32.ArcaneTorrent:IsReady() and v37 and (v6:EnergyDeficitPredicted() > ((29 - 14) + v6:EnergyRegen()))) then
				if v14.Cast(v32.ArcaneTorrent, true) then
					return "Cast Arcane Torrent";
				end
			end
			if (v32.ArcanePulse:IsReady() and v37) then
				if v14.Cast(v32.ArcanePulse, true) then
					return "Cast Arcane Pulse";
				end
			end
			if v32.LightsJudgment:IsReady() then
				if v14.Cast(v32.LightsJudgment, true) then
					return "Cast Lights Judgment";
				end
			end
			if v32.BagofTricks:IsReady() then
				if v14.Cast(v32.BagofTricks, true) then
					return "Cast Bag of Tricks";
				end
			end
		end
		if (v44 and v37) then
			if ((type(v44) == "table") and (#v44 > (1468 - (899 + 568)))) then
				if v21(v6:EnergyTimeToX(v45), unpack(v44)) then
					return "Macro pool towards " .. v44[1 + 0]:Name() .. " at " .. v45;
				end
			elseif v44:IsCastable() then
				v45 = v27(v45, v44:Cost());
				if v19(v44, v6:EnergyTimeToX(v45)) then
					return "Pool towards: " .. v44:Name() .. " at " .. v45;
				end
			end
		end
		if (v32.ShurikenToss:IsCastable() and v7:IsInRange(72 - 42) and not v38 and not v6:StealthUp(true, true) and not v6:BuffUp(v32.Sprint) and (v6:EnergyDeficitPredicted() < (623 - (268 + 335))) and ((v51 >= (291 - (60 + 230))) or (v6:EnergyTimeToMax() <= (573.2 - (426 + 146))))) then
			if v19(v32.ShurikenToss) then
				return "Cast Shuriken Toss";
			end
		end
	end
end
local function v84(v131, v132)
	return (v131:gsub("{(.-)}", v132));
end
local function v85(v133)
	local v134 = v6:GetEquipment();
	local v135, v136 = v134[2 + 11], v134[1470 - (282 + 1174)];
	if (v135 and (v133:ID() == v135)) then
		return 824 - (569 + 242);
	elseif (v136 and (v133:ID() == v136)) then
		return 40 - 26;
	end
end
local function v86()
	v32.Rupture:RegisterAuraTracking();
	v59.Subtlety.Display();
	v14.Print("Subtlety Rogue rotation has been updated for patch 11.0.0.");
	local v137 = {bloodFuryValue=((v32.BloodFury:IsAvailable() and ("/cast " .. v32.BloodFury:Name() .. "\n")) or (v32.Berserking:IsAvailable() and ("/cast " .. v32.Berserking:Name() .. "\n")) or ""),ColdBlood=((v32.ColdBlood:IsAvailable() and ("/cast " .. v32.ColdBlood:Name() .. "\n")) or ""),SecretTechnique=v32.SecretTechnique:Name()};
	v3.Timer.PulseOffset = 0.01 + 0;
	local v139 = "{bloodFuryValue}{ColdBlood}/cast {SecretTechnique}";
	v14:UpdateMacro("macro1", v84(v139, v137));
end
v14.SetAPL(1285 - (706 + 318), v83, v86);
