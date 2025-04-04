local v0, v1 = ...;
local v2 = HeroDBC.DBC;
local v3 = HeroLib;
local v4 = HeroCache;
local v5 = v3.Unit;
local v6 = v5.Player;
local v7 = v5.Target;
local v8 = v3.Spell;
local v9 = v3.MultiSpell;
local v10 = v3.Item;
local v11 = HeroRotation();
local v12 = v11.AoEON;
local v13 = v11.CDsON;
local v14 = v11.Cast;
local v15 = v11.CastPooling;
local v16 = v11.CastSuggested;
local v17 = v11.CastAnnotated;
local v18 = v11.CastQueue;
local v19 = v11.Commons().Everyone.num;
local v20 = v11.Commons().Everyone.bool;
local v21 = math.min;
local v22 = math.max;
local v23 = math.abs;
local v24 = C_Timer.After;
local v25 = v11.Commons().Everyone;
local v26 = v11.Commons().Rogue;
local v27 = v11.GUISettingsGet();
local v28 = {General=v27.General,Commons=v27.APL.Rogue.Commons,Outlaw=v27.APL.Rogue.Outlaw,Outlaw_TTD=v27.APL.Rogue.Outlaw_TTD,Outlaw_CDUSE=v27.APL.Rogue.Outlaw_CDUSE,Interrupt=v27.APL.Rogue.Outlaw_Interrupt.Interrupt};
local v29 = v8.Rogue.Outlaw;
local v30 = v10.Rogue.Outlaw;
local v31 = {v30.ImperfectAscendancySerum:ID(),v30.MadQueensMandate:ID(),v30.BottledFlayedwingToxin:ID(),v30.ImperfectAscendancySerum:ID(),v30.MadQueensMandate:ID(),v30.JunkmaestrosMegaMagnet:ID()};
local v32, v33;
local v34 = 568 - (367 + 201);
local function v35()
	local v78, v79 = v6:GetTrinketData(v31);
	if ((v34 < (932 - (214 + 713))) and ((v78.ID == (0 + 0)) or (v79.ID == (0 + 0)) or ((v78.SpellID > (877 - (282 + 595))) and not v78.Usable) or ((v79.SpellID > (1637 - (1523 + 114))) and not v79.Usable))) then
		v34 = v34 + 1 + 0;
		v24(6 - 1, function()
			v35();
		end);
		return;
	end
	v32 = v78.Object;
	v33 = v79.Object;
end
v35();
v3:RegisterForEvent(function()
	v35();
end, "PLAYER_EQUIPMENT_CHANGED");
local v36, v37, v38;
local v39;
local v40 = 1071 - (68 + 997);
local v41, v42, v43, v44;
local v45, v46, v47, v48, v49;
local v50 = 12381 - (226 + 1044);
local v51 = 48381 - 37270;
local v52 = {{v29.Blind,"Cast Blind (Interrupt)",function()
	return true;
end},{v29.KidneyShot,"Cast Kidney Shot (Interrupt)",function()
	return v42 > (180 - (67 + 113));
end}};
local v53, v54 = 0 + 0, 0 - 0;
local function v55(v82)
	local v83 = v6:EnergyTimeToMaxPredicted(nil, v82);
	if ((v83 < v53) or ((v83 - v53) > (0.5 + 0))) then
		v53 = v83;
	end
	return v53;
end
local function v56()
	local v84 = v6:EnergyPredicted();
	if ((v84 > v54) or ((v84 - v54) > (35 - 26))) then
		v54 = v84;
	end
	return v54;
end
local v57;
local function v58(v85)
	return (v85 ~= "Not Used") and ((((v85 == "with Cooldowns") or ((v85 == "small CDs") and v28.Outlaw_CDUSE.smallcdswithCooldowns) or (v85 == "with Cooldowns or AoE") or (v85 == "on Enemycount or Cooldowns") or (v85 == "on Boss or with Cooldowns")) and v13()) or (v85 == "always") or (((v85 == "on Boss only") or (v85 == "on Boss or on Enemycount") or (v85 == "on Boss or with Cooldowns")) and (v57 or v7:IsDummy())) or ((v85 == "with Bloodlust only") and v6:BloodlustUp()) or ((v85 == "small CDs") and Smallcds) or (((v85 == "on AOE") or (v85 == "with Cooldowns or AoE")) and (v38 > (954 - (802 + 150))) and v12()) or (((v85 == "on Enemycount or Cooldowns") or (v85 == "on Enemycount") or (v85 == "on Boss or on Enemycount")) and (v38 >= v28.Outlaw_CDUSE.Enemycount) and v12()));
end
local function v59(v86)
	return (v57 and v28.Outlaw_TTD.IgnoreWhenBoss) or v25.Buggedmobs[v7:NPCID()] or (v25.ISSolo() and v28.Outlaw_TTD.IgnoreWhenSolo) or (v86 == (0 - 0)) or ((v51 >= v86) and (v51 < (14106 - 6329)));
end
local function v60(v87)
	return (v57 and v28.Outlaw_TTD.IgnoreWhenBoss) or v25.Buggedmobs[v7:NPCID()] or (v25.ISSolo() and v28.Outlaw_TTD.IgnoreWhenSolo) or (v87 == (0 + 0)) or (v7:TimeToDie() >= v87);
end
local v61 = {v29.Broadside,v29.BuriedTreasure,v29.GrandMelee,v29.RuthlessPrecision,v29.SkullandCrossbones,v29.TrueBearing};
local v62 = false;
local function v63()
	if not v4.APLVar.RtB_Buffs then
		v4.APLVar.RtB_Buffs = {};
		v4.APLVar.RtB_Buffs.Will_Lose = {};
		v4.APLVar.RtB_Buffs.Will_Lose.Total = 0 - 0;
		v4.APLVar.RtB_Buffs.Total = 0 + 0;
		v4.APLVar.RtB_Buffs.Normal = 0 - 0;
		v4.APLVar.RtB_Buffs.Shorter = 0 + 0;
		v4.APLVar.RtB_Buffs.Longer = 791 - (368 + 423);
		v4.APLVar.RtB_Buffs.MinRemains = 31423 - 21424;
		v4.APLVar.RtB_Buffs.MaxRemains = 18 - (10 + 8);
		v4.APLVar.RtB_Buffs.BuffsAbovePandemic = 0 - 0;
		local v106 = v26.RtBRemains();
		for v115 = 443 - (416 + 26), #v61 do
			local v116 = v6:BuffRemains(v61[v115]);
			if (v116 > (0 - 0)) then
				if (v116 > (17 + 22)) then
					v4.APLVar.RtB_Buffs.BuffsAbovePandemic = v4.APLVar.RtB_Buffs.BuffsAbovePandemic + (1 - 0);
				end
				v4.APLVar.RtB_Buffs.Total = v4.APLVar.RtB_Buffs.Total + (439 - (145 + 293));
				if (v116 > v4.APLVar.RtB_Buffs.MaxRemains) then
					v4.APLVar.RtB_Buffs.MaxRemains = v116;
				end
				if (v116 < v4.APLVar.RtB_Buffs.MinRemains) then
					v4.APLVar.RtB_Buffs.MinRemains = v116;
				end
				local v119 = math.abs(v116 - v106);
				if (v119 <= (430.5 - (44 + 386))) then
					v4.APLVar.RtB_Buffs.Normal = v4.APLVar.RtB_Buffs.Normal + (1487 - (998 + 488));
					v4.APLVar.RtB_Buffs.Will_Lose[v61[v115]:Name()] = true;
					v4.APLVar.RtB_Buffs.Will_Lose.Total = v4.APLVar.RtB_Buffs.Will_Lose.Total + 1 + 0;
				elseif (v116 > v106) then
					v4.APLVar.RtB_Buffs.Longer = v4.APLVar.RtB_Buffs.Longer + 1 + 0;
				else
					v4.APLVar.RtB_Buffs.Shorter = v4.APLVar.RtB_Buffs.Shorter + (773 - (201 + 571));
					v4.APLVar.RtB_Buffs.Will_Lose[v61[v115]:Name()] = true;
					v4.APLVar.RtB_Buffs.Will_Lose.Total = v4.APLVar.RtB_Buffs.Will_Lose.Total + (1139 - (116 + 1022));
				end
			end
			if v62 then
				print("RtbRemains", v106);
				print(v61[v115]:Name(), v116);
			end
		end
		if v62 then
			print("have: ", v4.APLVar.RtB_Buffs.Total);
			print("will lose: ", v4.APLVar.RtB_Buffs.Will_Lose.Total);
			print("shorter: ", v4.APLVar.RtB_Buffs.Shorter);
			print("normal: ", v4.APLVar.RtB_Buffs.Normal);
			print("longer: ", v4.APLVar.RtB_Buffs.Longer);
			print("min remains: ", v4.APLVar.RtB_Buffs.MinRemains);
			print("max remains: ", v4.APLVar.RtB_Buffs.MaxRemains);
		end
	end
	return v4.APLVar.RtB_Buffs.Total;
end
local function v64(v88)
	return (v4.APLVar.RtB_Buffs.Will_Lose and v4.APLVar.RtB_Buffs.Will_Lose[v88] and true) or false;
end
local function v65(v89)
	if not v4.APLVar.RtB_Reroll then
		if (v28.Outlaw.RolltheBonesLogic == "1+ Buff") then
			v4.APLVar.RtB_Reroll = ((v4.APLVar.RtB_Buffs.Total <= (0 - 0)) and true) or false;
		elseif (v28.Outlaw.RolltheBonesLogic == "Broadside") then
			v4.APLVar.RtB_Reroll = (not v6:BuffUp(v29.Broadside) and true) or false;
		elseif (v28.Outlaw.RolltheBonesLogic == "Buried Treasure") then
			v4.APLVar.RtB_Reroll = (not v6:BuffUp(v29.BuriedTreasure) and true) or false;
		elseif (v28.Outlaw.RolltheBonesLogic == "Grand Melee") then
			v4.APLVar.RtB_Reroll = (not v6:BuffUp(v29.GrandMelee) and true) or false;
		elseif (v28.Outlaw.RolltheBonesLogic == "Skull and Crossbones") then
			v4.APLVar.RtB_Reroll = (not v6:BuffUp(v29.SkullandCrossbones) and true) or false;
		elseif (v28.Outlaw.RolltheBonesLogic == "Ruthless Precision") then
			v4.APLVar.RtB_Reroll = (not v6:BuffUp(v29.RuthlessPrecision) and true) or false;
		elseif (v28.Outlaw.RolltheBonesLogic == "True Bearing") then
			v4.APLVar.RtB_Reroll = (not v6:BuffUp(v29.TrueBearing) and true) or false;
		else
			v4.APLVar.RtB_Reroll = false;
			v4.APLVar.RtB_Reroll = v6:HasTier("TWW2", 3 + 1) and (v4.APLVar.RtB_Buffs.Will_Lose.Total <= (3 - 2)) and ((v4.APLVar.RtB_Buffs.BuffsAbovePandemic < (17 - 12)) or (v4.APLVar.RtB_Buffs.MaxRemains <= (901 - (814 + 45))));
			if not v4.APLVar.RtB_Reroll then
				v4.APLVar.RtB_Reroll = v6:HasTier("TWW2", 9 - 5) and ((v4.APLVar.RtB_Buffs.Total <= (1 + 1)) or (((v4.APLVar.RtB_Buffs.MaxRemains < (4 + 7)) or not v29.KeepItRolling:IsAvailable()) and (v4.APLVar.RtB_Buffs.Will_Lose.Total < (890 - (261 + 624))) and v29.Supercharger:IsAvailable()));
			end
			if not v4.APLVar.RtB_Reroll then
				v4.APLVar.RtB_Reroll = not v6:HasTier("TWW2", 6 - 2) and ((v4.APLVar.RtB_Buffs.Will_Lose.Total <= v19(v6:BuffUp(v29.LoadedDiceBuff) or v89)) or (v29.Supercharger:IsAvailable() and (v6:BuffUp(v29.LoadedDiceBuff) or v89) and (v4.APLVar.RtB_Buffs.Total <= (1082 - (1020 + 60)))) or (v29.HiddenOpportunity:IsAvailable() and (v6:BuffUp(v29.LoadedDiceBuff) or v89) and (v4.APLVar.RtB_Buffs.Total <= (1425 - (630 + 793))) and v6:BuffDown(v29.Broadside) and v6:BuffDown(v29.RuthlessPrecision) and v6:BuffDown(v29.TrueBearing)));
			end
		end
	end
	return v4.APLVar.RtB_Reroll;
end
local function v66()
	return v42 >= ((v26.CPMaxSpend() - (3 - 2)) - v19((v6:StealthUp(true, true) and v29.Crackshot:IsAvailable()) or ((v29.HandOfFate:IsAvailable() or v29.FlawlessForm:IsAvailable()) and v29.HiddenOpportunity:IsAvailable() and (v6:BuffUp(v29.AudacityBuff) or v6:BuffUp(v29.Opportunity)))));
end
local function v67()
	return (v29.HiddenOpportunity:IsAvailable() or (v44 >= ((9 - 7) + v19(v29.ImprovedAmbush:IsAvailable()) + v19(v6:BuffUp(v29.Broadside))))) and (v45 >= (20 + 30));
end
local function v68()
	return IsVanish and not v6:IsTanking(v7);
end
local function v69(v90)
	if v29.BladeFlurry:IsCastable() then
		if (v29.DeftManeuvers:IsAvailable() and not v66() and (((v38 >= (9 - 6)) and (v44 == (v38 + v19(v6:BuffUp(v29.Broadside))))) or (v38 >= (1752 - (760 + 987))))) then
			if v90 then
				return v29.BladeFlurry;
			elseif v14(v29.BladeFlurry, true) then
				return "Cast Blade Flurry";
			end
		end
	end
	if (v29.ColdBlood:IsCastable() and IsColdBlood and v6:BuffDown(v29.ColdBlood) and v66()) then
		if v14(v29.ColdBlood, true) then
			return "Cast Cold Blood";
		end
	end
	if ((v29.BetweentheEyes:CooldownUp() or (v29.BetweentheEyes:CooldownRemains() <= v6:GCDRemains()) or v90) and v7:IsSpellInRange(v29.BetweentheEyes) and v66() and v29.Crackshot:IsAvailable() and (not v6:BuffUp(v29.Shadowmeld) or v6:StealthUp(true, false) or v90)) then
		if v90 then
			return v29.BetweentheEyes;
		elseif v15(v29.BetweentheEyes) then
			return "Cast Between the Eyes (Stealth)";
		end
	end
	if (v29.Dispatch:IsCastable() and v66() and v7:IsSpellInRange(v29.Dispatch)) then
		if v90 then
			return v29.Dispatch;
		elseif v15(v29.Dispatch) then
			return "Cast Dispatch (Stealth)";
		end
	end
	if (v29.PistolShot:IsCastable() and v7:IsSpellInRange(v29.PistolShot) and v29.Crackshot:IsAvailable() and (v29.FanTheHammer:TalentRank() >= (1915 - (1789 + 124))) and (v6:BuffStack(v29.Opportunity) >= (772 - (745 + 21))) and ((v6:BuffUp(v29.Broadside) and (v42 <= (1 + 0))) or v6:BuffUp(v29.GreenskinsWickersBuff))) then
		if v90 then
			return v29.PistolShot;
		elseif v15(v29.PistolShot) then
			return "Cast Pistol Shot (Crackshot)";
		end
	end
	if (v29.Ambush:IsCastable() and v7:IsSpellInRange(v29.Ambush) and v29.HiddenOpportunity:IsAvailable() and v6:BuffUp(v29.AudacityBuff)) then
		if v90 then
			return v29.SSAudacity;
		elseif v15(v29.SinisterStrike) then
			return "Cast Ambush (SS High-Prio Buffed)";
		end
	end
	if (v29.Ambush:IsCastable() and v7:IsSpellInRange(v29.Ambush) and v29.HiddenOpportunity:IsAvailable()) then
		if v90 then
			return v29.Ambush;
		elseif v15(v29.Ambush) then
			return "Cast Ambush";
		end
	end
end
local function v70(v91)
	if (v29.CoupDeGrace:IsCastable() and v7:IsSpellInRange(v29.CoupDeGrace)) then
		if v91 then
			return v29.CoupDeGrace;
		elseif v15(v29.Dispatch) then
			return "Cast Coup de Grace";
		end
	end
	if (v29.BetweentheEyes:IsCastable() and v7:IsSpellInRange(v29.BetweentheEyes) and (v6:BuffUp(v29.RuthlessPrecision) or (v6:BuffRemains(v29.BetweentheEyes) < (10 - 6)) or not v29.MeanStreak:IsAvailable()) and (v6:BuffDown(v29.GreenskinsWickersBuff) or not v29.GreenskinsWickers:IsAvailable())) then
		if v91 then
			return v29.BetweentheEyes;
		elseif v15(v29.BetweentheEyes) then
			return "Cast Between the Eyes (Finish)";
		end
	end
	if (v29.BetweentheEyes:IsCastable() and v7:IsSpellInRange(v29.BetweentheEyes)) then
		if (v29.Crackshot:IsAvailable() and (v6:BuffUp(v29.RuthlessPrecision) or (v6:BuffRemains(v29.BetweentheEyes) < (15 - 11)) or not v29.KeepItRolling:IsAvailable() or not v29.MeanStreak:IsAvailable())) then
			if v91 then
				return v29.BetweentheEyes;
			elseif v15(v29.BetweentheEyes) then
				return "Cast Between the Eyes (Crackshot OOS)";
			end
		end
	end
	if (v29.ColdBlood:IsCastable() and IsColdBlood and v6:BuffDown(v29.ColdBlood)) then
		if v14(v29.ColdBlood, true) then
			return "Cast Cold Blood";
		end
	end
	if (v29.Dispatch:IsCastable() and v7:IsSpellInRange(v29.Dispatch)) then
		if v91 then
			return v29.Dispatch;
		elseif v15(v29.Dispatch) then
			return "Cast Dispatch (Finish)";
		end
	end
end
local v71;
local function v72(v92, v93)
	local v94;
	if ((v92:ID() == v29.Vanish:ID()) or (v92:ID() == v29.Shadowmeld:ID())) then
		v94 = v69(true);
		if (v94 and v93) then
			return v94;
		end
		if ((v92:ID() == v29.Vanish:ID()) and IsVanish) then
			if v14(v29.Vanish, true) then
				return "Cast Vanish";
			end
			return false;
		elseif ((v92:ID() == v29.Shadowmeld:ID()) and IsRacials) then
			if v14(v29.Shadowmeld, true) then
				return "Cast Shadowmeld";
			end
			return false;
		end
	elseif (v92:ID() == v29.AdrenalineRush:ID()) then
		v42 = v6:ComboPointsMax();
		if v29.RolltheBones:IsCastable() then
			if (v65(v29.LoadedDice:IsAvailable()) or (v4.APLVar.RtB_Buffs.Total == (0 + 0))) then
				v94 = v29.RolltheBones;
			end
		end
		if not v94 then
			if not v6:StealthUp(true, true) then
				if (v29.CoupDeGrace:IsCastable() and (v29.CoupDeGrace:TimeSinceLastCast() < (1 + 0)) and v6:BuffUp(v29.AdrenalineRush)) then
					v94 = v29.CoupDeGrace;
				else
					local v135 = v71(true);
					if (v135 and v135[1057 - (87 + 968)] and (v135[8 - 6] ~= "Cast Vanish") and v28.Outlaw.SpellQueueMacro.ImprovedAdrenalineRush) then
						local v137 = {v92,unpack(v135)};
						v39 = v18(unpack(v137));
						if v39 then
							return "| " .. v137[1415 - (447 + 966)]:Name() .. " | " .. v137[8 - 5]:Name();
						end
					end
					v94 = v70(true);
				end
			else
				v94 = v69(true);
			end
		end
		if IsAdrenalineRush then
			if v14(v29.AdrenalineRush, true) then
				return "Cast Adrenaline Rush";
			end
			return false;
		end
	end
	local v95 = {v92,v94};
	v39 = v18(unpack(v95));
	if v39 then
		return "| " .. v95[2 - 0]:Name();
	end
	v42 = v6:ComboPoints();
	return false;
end
function v71()
	v11.Print(tostring(v29.Vanish:IsCastable() and IsVanish and v68()));
	v11.Print("Castable=" .. tostring(v29.Vanish:IsCastable()) .. " IsVanish=" .. tostring(IsVanish) .. " Vanish_DPS_Condition=" .. tostring(v68()));
	if (v29.Vanish:IsCastable() and v68() and IsVanish) then
		if (not v29.KillingSpree:IsAvailable() and not v29.BetweentheEyes:IsReady() and (v6:BuffRemains(v29.RuthlessPrecision) > (12 - 8)) and (((v29.KeepItRolling:CooldownRemains() > (43 + 107)) and (v4.APLVar.RtB_Buffs.Normal > (0 - 0))) or not v29.KeepItRolling:IsAvailable())) then
			if v14(v29.Vanish, true) then
				return "Cast Vanish 1";
			end
		end
	end
	if (v29.Vanish:IsCastable() and IsVanish and v68()) then
		if ((v6:BuffRemains(v29.AdrenalineRush) < (17 - (9 + 5))) and (v29.AdrenalineRush:CooldownRemains() > (386 - (85 + 291)))) then
			if v14(v29.Vanish, true) then
				return "Cast Vanish 2";
			end
		end
	end
	if (v29.Vanish:IsCastable() and IsVanish and v68()) then
		if (not v29.KillingSpree:IsAvailable() and (v43 > (1265 - (243 + 1022)))) then
			if v14(v29.Vanish, true) then
				return "Cast Vanish 3";
			end
		end
	end
	if (v29.Vanish:IsCastable() and IsVanish and v68()) then
		if (v29.KillingSpree:CooldownRemains() > (57 - 42)) then
			if v14(v29.Vanish, true) then
				return "Cast Vanish 4";
			end
		end
	end
	if (v29.Vanish:IsCastable() and IsVanish and v68()) then
		if ((v29.Vanish:FullRechargeTime() < (13 + 2)) or v3.BossFilteredFightRemains("<", 1188 - (1123 + 57))) then
			if v14(v29.Vanish, true) then
				return "Cast Vanish 5";
			end
		end
	end
end
local function v73()
	v11.Print(tostring(v29.Vanish:IsCastable() and IsVanish and v68()));
	v11.Print(tostring(v29.Vaniish:IsCastable()) .. tostring(v29.Subterfuge:IsAvailable()) .. tostring(not v29.Crackshot:IsAvailable()));
	if (v29.Vanish:IsCastable() and IsVanish and v68()) then
		if (v29.UnderhandedUpperhand:IsAvailable() and v29.Subterfuge:IsAvailable() and not v29.Crackshot:IsAvailable() and v6:BuffUp(v29.AdrenalineRush) and (v67() or not v29.HiddenOpportunity:IsAvailable()) and ((not v29.BetweentheEyes:IsReady() and v6:BuffUp(v29.RuthlessPrecision)) or v6:BuffDown(v29.RuthlessPrecision or (v6:BuffRemains(v29.AdrenalineRush) < (3 + 0))))) then
			if v14(v29.Vanish, true) then
				return "Cast Vanish Off Meta 1";
			end
		end
	end
	if (v29.Vanish:IsCastable() and IsVanish and v68()) then
		if (not v29.UnderhandedUpperhand:IsAvailable() and v29.Crackshot:IsAvailable() and v66()) then
			if v14(v29.Vanish, true) then
				return "Cast Vanish Off Meta 2";
			end
		end
	end
	if (v29.Vanish:IsCastable() and IsVanish and v68()) then
		if (not v29.UnderhandedUpperhand:IsAvailable() and not v29.Crackshot:IsAvailable() and v29.HiddenOpportunity:IsAvailable() and not v6:BuffUp(v29.AudacityBuff) and (v6:BuffStack(v29.Opportunity) < (260 - (163 + 91))) and v67()) then
			if v14(v29.Vanish, true) then
				return "Cast Vanish Off Meta 3";
			end
		end
	end
	if (v29.Vanish:IsCastable() and IsVanish and v68()) then
		if (not v29.UnderhandedUpperhand:IsAvailable() and not v29.Crackshot:IsAvailable() and not v29.HiddenOpportunity:IsAvailable() and v29.FatefulEnding:IsAvailable() and ((not v6:BuffUp(v29.FateboundLuckyCoin) and ((v6:BuffStack(v29.FateboundCoinTails) >= (1935 - (1869 + 61))) or (v6:BuffStack(v29.FateboundCoinHeads) >= (2 + 3)))) or (v6:BuffUp(v29.FateboundLuckyCoin) and not v29.BetweentheEyes:IsReady()))) then
			if v14(v29.Vanish, true) then
				return "Cast Vanish Off Meta 4";
			end
		end
	end
	if (v29.Vanish:IsCastable() and IsVanish and v68()) then
		if (not v29.UnderhandedUpperhand:IsAvailable() and not v29.Crackshot:IsAvailable() and not v29.HiddenOpportunity:IsAvailable() and not v29.FatefulEnding:IsAvailable() and v29.TakeEmBySurprise:IsAvailable() and not v6:BuffUp(v29.TakeEmBySurpriseBuff)) then
			if v14(v29.Vanish, true) then
				return "Cast Vanish Off Meta 5";
			end
		end
	end
	if (v29.Shadowmeld:IsCastable() and IsRacials and v66() and not v29.Vanish:IsReady()) then
		if v14(v29.Shadowmeld, true) then
			return "Cast Shadowmeld (Off Meta)";
		end
	end
end
local function v74()
	if (v29.AdrenalineRush:IsCastable() and IsAdrenalineRush and ((not v6:BuffUp(v29.AdrenalineRush) and (not v66() or not v29.ImprovedAdrenalineRush:IsAvailable())) or (v29.ImprovedAdrenalineRush:IsAvailable() and (v42 <= (6 - 4))))) then
		if v29.ImprovedAdrenalineRush:IsAvailable() then
			v39 = v72(v29.AdrenalineRush);
			if v39 then
				return "AR Finisher Macro 1 " .. v39;
			end
		elseif v14(v29.AdrenalineRush, true) then
			return "Cast Adrenaline Rush";
		end
	end
	if (v29.CoupDeGrace:IsCastable() and v7:IsSpellInRange(v29.CoupDeGrace) and (v29.CoupDeGrace:TimeSinceLastCast() < (1 - 0)) and v6:BuffUp(v29.AdrenalineRush)) then
		if v15(v29.Dispatch) then
			return "Double Coup De Grace CDs";
		end
	end
	if (v29.Sprint:IsCastable() and v6:BuffDown(v29.Sprint) and ((v32:ID() == v30.ScrollOfMomentum:ID()) or (v33:ID() == v30.ScrollOfMomentum:ID())) and v6:BuffUp(v29.FullMomentum)) then
		if v14(v29.Sprint, true) then
			return "Cast Sprint";
		end
	end
	if v29.BladeFlurry:IsCastable() then
		if ((v38 >= (1 + 1)) and (v6:BuffRemains(v29.BladeFlurry) < v6:GCD())) then
			if v14(v29.BladeFlurry, true) then
				return "Cast Blade Flurry";
			end
		end
	end
	if v29.BladeFlurry:IsCastable() then
		if (v29.DeftManeuvers:IsAvailable() and not v66() and (((v38 >= (3 - 0)) and (v44 == (v38 + v19(v6:BuffUp(v29.Broadside))))) or (v38 >= (5 + 0)))) then
			if v14(v29.BladeFlurry, true) then
				return "Cast Blade Flurry";
			end
		end
	end
	if (v29.KeepItRolling:IsCastable() and IsKeepItRolling) then
		if ((v4.APLVar.RtB_Buffs.Normal >= (1479 - (1329 + 145))) and (v4.APLVar.RtB_Buffs.Total == (977 - (140 + 831))) and (v4.APLVar.RtB_Buffs.MaxRemains <= (1880 - (1409 + 441)))) then
			if v14(v29.KeepItRolling, true) then
				return "Cast Keep it Rolling";
			end
		end
	end
	if (v29.KeepItRolling:IsCastable() and IsKeepItRolling and (v4.APLVar.RtB_Buffs.Total >= (722 - (15 + 703))) and (v4.APLVar.RtB_Buffs.Normal <= (1 + 1))) then
		if v14(v29.KeepItRolling, true) then
			return "Cast Keep it Rolling";
		end
	end
	if (v29.KeepItRolling:IsCastable() and IsKeepItRolling and (v4.APLVar.RtB_Buffs.Total >= (441 - (262 + 176))) and (v4.APLVar.RtB_Buffs.Normal <= (1723 - (345 + 1376))) and v6:BuffUp(v29.Broadside) and v6:BuffUp(v29.RuthlessPrecision) and v6:BuffUp(v29.TrueBearing)) then
		if v14(v29.KeepItRolling, true) then
			return "Cast Keep it Rolling";
		end
	end
	if v29.RolltheBones:IsCastable() then
		if (v65() or (v4.APLVar.RtB_Buffs.Total == (688 - (198 + 490)))) then
			if v14(v29.RolltheBones, true) then
				return "Cast Roll the Bones";
			end
		end
	end
	if (v29.GhostlyStrike:IsAvailable() and v29.GhostlyStrike:IsCastable() and (v41 < v26.CPMaxSpend())) then
		if v14(v29.GhostlyStrike, true) then
			return "Cast Ghostly Strike";
		end
	end
	if v28.Commons.Enabled.Trinkets then
		if (v30.ImperfectAscendancySerum:IsEquippedAndReady() and v7:IsItemInRange(v30.ImperfectAscendancySerum) and (((v32:ID() == v30.ImperfectAscendancySerum:ID()) and IsTrinket1) or ((v33:ID() == v30.ImperfectAscendancySerum:ID()) and IsTrinket2))) then
			if (not v6:StealthUp(true, true) or v3.BossFilteredFightRemains("<=", (79 - 61) + (9 - 5))) then
				if v14(v30.ImperfectAscendancySerum, true) then
					return "Imperfect Ascendancy Serum";
				end
			end
		end
		if (v30.MadQueensMandate:IsEquippedAndReady() and v7:IsItemInRange(v30.MadQueensMandate) and (((v32:ID() == v30.MadQueensMandate:ID()) and IsTrinket1) or ((v33:ID() == v30.MadQueensMandate:ID()) and IsTrinket2))) then
			if (not v6:StealthUp(true, true) or v3.BossFilteredFightRemains("<=", (2504 - (696 + 510)) - ((2472 - 1293) + (1376 - (1091 + 171))))) then
				if v14(v30.MadQueensMandate, true) then
					return "Mad Queens Mandate";
				end
			end
		end
		if (v30.JunkmaestrosMegaMagnet:IsEquippedAndReady() and v7:IsItemInRange(v30.JunkmaestrosMegaMagnet) and (v6:BuffStack(v29.JunkmaestrosBuff) > ((0 + 0) - (0 - 0))) and (((v32:ID() == v30.JunkmaestrosMegaMagnet:ID()) and IsTrinket1) or ((v33:ID() == v30.JunkmaestrosMegaMagnet:ID()) and IsTrinket2))) then
			if (((v32:ID() == v30.JunkmaestrosMegaMagnet:ID()) and ((v33:CooldownRemains() > ((5932 - 4143) - ((1824 - (123 + 251)) + (1585 - 1266)))) or not v33:IsUsable() or not IsTrinket2)) or ((v33:ID() == v30.JunkmaestrosMegaMagnet:ID()) and ((v32:CooldownRemains() > ((729 - (208 + 490)) - (1 + 10))) or not v32:IsUsable() or not IsTrinket1))) then
				if v14(v30.JunkmaestrosMegaMagnet, true) then
					return "Junkmaestros Mega Magnet";
				end
			end
		end
	end
	if (v29.KillingSpree:IsCastable() and IsKillingSpree and v7:IsSpellInRange(v29.KillingSpree) and v66() and not v6:StealthUp(true, true)) then
		if v14(v29.KillingSpree) then
			return "Cast Killing Spree";
		end
	end
	if (not v6:StealthUp(true, true) and v29.Crackshot:IsAvailable() and v29.UnderhandedUpperhand:IsAvailable() and v29.Subterfuge:IsAvailable() and (v6:BuffStack(v29.EscalatingBlade) < (2 + 2)) and (v6:BuffUp(v29.AdrenalineRush) or v3.BossFilteredFightRemains("<=", 844 - (660 + 176))) and v66()) then
		v39 = v71();
		if v39 then
			return v39;
		end
	end
	if (not v6:StealthUp(true, true) and (not v29.UnderhandedUpperhand:IsAvailable() or not v29.Crackshot:IsAvailable() or not v29.Subterfuge:IsAvailable())) then
		v39 = v73();
		if v39 then
			return v39;
		end
	end
	if (v29.ThistleTea:IsCastable() and IsThistleTea and not v6:BuffUp(v29.ThistleTea) and ((v47 >= (19 + 131)) or v3.BossFilteredFightRemains("<", v29.ThistleTea:Charges() * (208 - (14 + 188))))) then
		if v14(v29.ThistleTea, true) then
			return "Cast Thistle Tea";
		end
	end
	if (v29.Shadowmeld:IsAvailable() and IsRacials and not v25:ISSolo() and v29.Shadowmeld:IsReady() and v66() and not v29.Vanish:IsReady()) then
		if v14(v29.Shadowmeld, true) then
			return "Cast Shadowmeld";
		end
	end
	if (v29.BladeRush:IsCastable() and v7:IsSpellInRange(v29.BladeRush) and IsBladeRush and (v48 > (679 - (534 + 141))) and not v6:StealthUp(true, true)) then
		if v14(v29.BladeRush, v28.Outlaw.GCDasOffGCD.BladeRush, nil, not v7:IsSpellInRange(v29.BladeRush)) then
			return "Cast Blade Rush";
		end
	end
	if v28.Commons.Enabled.Potions then
		local v107 = v25.PotionSelected();
		if (v107 and IsPotions and v107:IsReady() and (v6:BloodlustUp() or v3.BossFilteredFightRemains("<", 13 + 17) or v6:BuffUp(v29.AdrenalineRush))) then
			v11.CastMacro(3 + 0, nil, nil, v107);
			return "Cast Potion";
		end
	end
	if (v29.BloodFury:IsCastable() and IsRacials) then
		if v14(v29.BloodFury, true) then
			return "Cast Blood Fury";
		end
	end
	if (v29.Berserking:IsCastable() and IsRacials) then
		if v14(v29.Berserking, true) then
			return "Cast Berserking";
		end
	end
	if (v29.Fireblood:IsCastable() and IsRacials) then
		if v14(v29.Fireblood, true) then
			return "Cast Fireblood";
		end
	end
	if (v29.AncestralCall:IsCastable() and IsRacials) then
		if v14(v29.AncestralCall, true) then
			return "Cast Ancestral Call";
		end
	end
	if v28.Commons.Enabled.Trinkets then
		local v108, v109, v110 = v6:GetUseableItems(v31, 13 + 0);
		local v111, v109, v112 = v6:GetUseableItems(v31, 29 - 15);
		local v113, v114;
		if (v108 and IsTrinket1) then
			v113 = v108;
			v114 = v110;
		elseif (v111 and IsTrinket2) then
			v113 = v111;
			v114 = v112;
		end
		if (v113 and v7:IsInRange(v114) and (v6:BuffUp(v29.BetweentheEyes) or v3.BossFilteredFightRemains("<", 31 - 11) or v113:HasStatAnyDps())) then
			if v14(v113, true) then
				return "Generic use_items for  " .. v113:Name();
			end
		end
	end
end
local function v75()
	if (v29.Ambush:IsCastable() and v7:IsSpellInRange(v29.Ambush) and v29.HiddenOpportunity:IsAvailable() and v6:BuffUp(v29.AudacityBuff)) then
		if v15(v29.SinisterStrike) then
			return "Cast Ambush (SS High-Prio Buffed)";
		end
	end
	if (v29.SinisterStrike:IsCastable() and v7:IsSpellInRange(v29.SinisterStrike) and (v29.KillingSpree:CooldownRemains() < (28 - 18)) and (v26.DisorientingStrikesCount() > (0 + 0))) then
		if v15(v29.SinisterStrike) then
			return "Cast Sinister Strike... dump Disorienting Strike stacks before KS";
		end
	end
	if (v29.FanTheHammer:IsAvailable() and v7:IsSpellInRange(v29.PistolShot) and v29.Audacity:IsAvailable() and v29.HiddenOpportunity:IsAvailable() and v6:BuffUp(v29.Opportunity) and v6:BuffDown(v29.AudacityBuff)) then
		if v15(v29.PistolShot) then
			return "Cast Pistol Shot (Audacity)";
		end
	end
	if (v29.FanTheHammer:IsAvailable() and v7:IsSpellInRange(v29.PistolShot) and v6:BuffUp(v29.Opportunity) and ((v6:BuffStack(v29.Opportunity) >= (4 + 2)) or (v6:BuffRemains(v29.Opportunity) < (398 - (115 + 281))))) then
		if v15(v29.PistolShot) then
			return "Cast Pistol Shot (FtH Dump)";
		end
	end
	if (v29.FanTheHammer:IsAvailable() and v7:IsSpellInRange(v29.PistolShot) and v6:BuffUp(v29.Opportunity) and ((v44 >= ((2 - 1) + ((v19(v29.QuickDraw:IsAvailable()) + v19(v6:BuffUp(v29.Broadside))) * (v29.FanTheHammer:TalentRank() + 1 + 0)))) or (v42 <= v19(v29.Ruthlessness:IsAvailable())))) then
		if v15(v29.PistolShot) then
			return "Cast Pistol Shot (Low CP Opportunity)";
		end
	end
	if (not v29.FanTheHammer:IsAvailable() and v7:IsSpellInRange(v29.PistolShot) and v6:BuffUp(v29.Opportunity) and ((v48 > (2.5 - 1)) or (v44 <= ((3 - 2) + v19(v6:BuffUp(v29.Broadside)))) or v29.QuickDraw:IsAvailable() or (v29.Audacity:IsAvailable() and v6:BuffDown(v29.AudacityBuff)))) then
		if v15(v29.PistolShot) then
			return "Cast Pistol Shot (No Fan the Hammer)";
		end
	end
	if (v29.SinisterStrike:IsCastable() and v7:IsSpellInRange(v29.SinisterStrike)) then
		if v15(v29.SinisterStrike, nil, not v7:IsSpellInRange(v29.SinisterStrike)) then
			return "Cast Sinister Strike";
		end
	end
end
local function v76()
	Smallcds = v11.ToggleIconFrame:GetToggle(868 - (550 + 317));
	AutoStealth = v11.ToggleIconFrame:GetToggle(2 - 0);
	InterruptToggle = v11.ToggleIconFrame:GetToggle(3 - 0);
	VanishToggle = v11.ToggleIconFrame:GetToggle(11 - 7);
	KillingspreeToggle = v11.ToggleIconFrame:GetToggle(290 - (134 + 151));
	v63();
	v40 = 1673 - (970 + 695);
	v42 = v6:ComboPoints();
	v43 = v6:ChargedComboPoints();
	v41 = v26.EffectiveComboPoints(v42);
	v44 = v6:ComboPointsDeficit();
	v49 = (v6:BuffUp(v29.AdrenalineRush, nil, true) and -(95 - 45)) or (1990 - (582 + 1408));
	v45 = v56();
	v46 = v6:EnergyRegen();
	v48 = v55(v49);
	v47 = v6:EnergyDeficitPredicted(nil, v49);
	if v12() then
		v36 = v6:GetEnemiesInRange(104 - 74);
		v37 = v6:GetEnemiesInRange(v40);
		v38 = #v37;
		Enemies30yCount = #v36;
	else
		v38 = 1 - 0;
		Enemies30yCount = 3 - 2;
	end
	if (v25.TargetIsValid() or v6:AffectingCombat()) then
		v51 = v3.BossFightRemains();
		IsBossfight = true;
		if (v51 == (12935 - (1195 + 629))) then
			IsBossfight = false;
			v51 = v3.FightRemains(v36, false);
		end
		IsInMeleeRange = v7:IsInRange(6 - 1);
	end
	IsRacials = v59(v28.Outlaw_TTD.RacialsTTD) and v58(v28.Outlaw_CDUSE.Racials);
	IsPotions = v59(v28.Outlaw_TTD.PotionsTTD) and (v28.Outlaw_CDUSE.Potionswhensolo or (not v28.Outlaw_CDUSE.Potionswhensolo and not v25.ISSolo())) and v58(v28.Outlaw_CDUSE.Potions);
	IsTrinket1 = v59(v28.Outlaw_TTD.TrinketsTTD) and v58(v28.Outlaw_CDUSE.Trinket1);
	IsTrinket2 = v59(v28.Outlaw_TTD.TrinketsTTD) and v58(v28.Outlaw_CDUSE.Trinket2);
	IsVanish = (v28.Commons.UseSoloVanish or not v25.ISSolo()) and VanishToggle and v59(v28.Outlaw_TTD.VanishTTD) and v58(v28.Outlaw_CDUSE.Vanish);
	IsAdrenalineRush = v59(v28.Outlaw_TTD.AdrenalineRushTTD) and v58(v28.Outlaw_CDUSE.AdrenalineRush);
	IsKeepItRolling = v59(v28.Outlaw_TTD.KeepItRollingTTD) and v58(v28.Outlaw_CDUSE.KeepItRolling);
	IsGhostlyStrike = v60(v28.Outlaw_TTD.GhostlyStrikeTTD) and v58(v28.Outlaw_CDUSE.GhostlyStrike);
	IsThistleTea = v59(v28.Outlaw_TTD.ThistleTeaTTD) and v58(v28.Outlaw_CDUSE.ThistleTea);
	IsKillingSpree = KillingspreeToggle and not v6:IsMoving() and v59(v28.Outlaw_TTD.KillingSpreeTTD) and v58(v28.Outlaw_CDUSE.KillingSpree);
	IsBladeRush = v59(v28.Outlaw_TTD.BladeRushTTD) and v58(v28.Outlaw_CDUSE.BladeRush);
	v39 = v26.Defense(v29.Shadowstep);
	if v39 then
		return v39;
	end
	v39 = v26.Poisons();
	if v39 then
		return v39;
	end
	if not v6:AffectingCombat() then
		if (AutoStealth and (v29.Stealth:IsCastable() or v29.Stealth2:IsCastable()) and v6:StealthDown() and (((Enemies30yCount >= ((242 - (187 + 54)) + (780 - (162 + 618)))) and (v28.Outlaw.AutoStealth == "near Target")) or (v28.Outlaw.AutoStealth == "always"))) then
			if v11.Cast(v29.Stealthcast) then
				return "Cast Stealth (OOC)";
			end
		end
		if v25.TargetIsValid() then
			if (not v28.Outlaw.AttackonlyinCombat or (v28.Outlaw.AttackonlyinCombat and v7:AffectingCombat())) then
				if (v30.ImperfectAscendancySerum:IsEquippedAndReady() and v7:IsItemInRange(v30.ImperfectAscendancySerum) and (((v32:ID() == v30.ImperfectAscendancySerum:ID()) and IsTrinket1) or ((v32:ID() == v30.ImperfectAscendancySerum:ID()) and IsTrinket2))) then
					if v14(v30.ImperfectAscendancySerum, true) then
						return "Imperfect Ascendancy Serum";
					end
				end
				if (v29.AdrenalineRush:IsCastable() and v58(v28.Outlaw_CDUSE.AdrenalineRush) and IsInMeleeRange and v29.ImprovedAdrenalineRush:IsAvailable() and v29.KeepItRolling:IsAvailable() and v29.LoadedDice:IsAvailable()) then
					if v14(v29.AdrenalineRush, true) then
						return "Cast Adrenaline Rush (Opener KiR)";
					end
				end
				if (v29.RolltheBones:IsCastable() and IsInMeleeRange and not v6:DebuffUp(v29.Dreadblades) and ((v4.APLVar.RtB_Buffs.Total == ((767 + 327) - (500 + 250 + (733 - 389)))) or v65())) then
					if v14(v29.RolltheBones, true) then
						return "Cast Roll the Bones (Opener)";
					end
				end
				if (v29.AdrenalineRush:IsCastable() and v58(v28.Outlaw_CDUSE.AdrenalineRush) and IsInMeleeRange and v29.ImprovedAdrenalineRush:IsAvailable()) then
					if v14(v29.AdrenalineRush, true) then
						return "Cast Adrenaline Rush (Opener)";
					end
				end
				if v6:StealthUp(true, false) then
					v39 = v69();
					if v39 then
						return "Stealth (Opener):" .. v39;
					end
					if (v29.KeepItRolling:IsAvailable() and v29.GhostlyStrike:IsReady() and v7:IsSpellInRange(v29.GhostlyStrike) and IsGhostlyStrike and v29.EchoingReprimand:IsAvailable()) then
						if v14(v29.GhostlyStrike) then
							return "Cast Ghostly Strike KiR (Opener)";
						end
					end
					if (v29.Ambush:IsCastable() and v7:IsSpellInRange(v29.Ambush) and v29.HiddenOpportunity:IsAvailable()) then
						if v14(v29.Ambush) then
							return "Cast Ambush (Opener)";
						end
					elseif (v29.SinisterStrike:IsCastable() and v7:IsSpellInRange(v29.SinisterStrike)) then
						if v14(v29.SinisterStrike) then
							return "Cast Sinister Strike (Opener)";
						end
					end
				elseif v66() then
					v39 = v70();
					if v39 then
						return "Finish (Opener):" .. v39;
					end
				end
				if (v29.SinisterStrike:IsCastable() and v7:IsSpellInRange(v29.SinisterStrike)) then
					if v14(v29.SinisterStrike) then
						return "Cast Sinister Strike (Opener)";
					end
				end
			end
			return;
		end
	end
	if (v29.FanTheHammer:IsAvailable() and (v29.PistolShot:TimeSinceLastCast() < v6:GCDRemains())) then
		v42 = v22(v42, v26.FanTheHammerCP());
		v41 = v26.EffectiveComboPoints(v42);
		v44 = v6:ComboPointsDeficit();
	end
	if v25.TargetIsValid() then
		if (not v28.Outlaw.AttackonlyinCombat or (v28.Outlaw.AttackonlyinCombat and v7:AffectingCombat())) then
			if InterruptToggle then
				v39 = v25.InterruptCycle(v29.Kick, 8 - 3, true, nil, false);
				if v39 then
					return v39;
				end
				v39 = v28.Interrupt.UseBlind and v25.InterruptCycle(v29.Blind, 2 + 13, true, nil, true);
				if v39 then
					return v39;
				end
				v39 = v28.Interrupt.UseKidneyShot and (v42 > (1636 - (1373 + 263))) and v25.InterruptCycle(v29.KidneyShot, 1005 - (451 + 549), true, nil, true);
				if v39 then
					return v39;
				end
				v39 = v28.Interrupt.UseCheapShop and v6:StealthUp(true, true) and v25.InterruptCycle(v29.CheapShot, 2 + 3, true, nil, true);
				if v39 then
					return v39;
				end
			end
			v39 = v28.Commons.Enabled.Shiv and v25.SootheCycle(v29.Shiv, 13 - 4);
			if v39 then
				return v39;
			end
			v39 = v74();
			if v39 then
				return "CDs:" .. v39;
			end
			if v6:StealthUp(true, true) then
				v39 = v69();
				if v39 then
					return "Stealth:" .. v39;
				end
			end
			if v66() then
				v39 = v70();
				if v39 then
					return "Finish:" .. v39;
				end
			else
				v39 = v75();
				if v39 then
					return "Build:" .. v39;
				end
			end
			if (v29.ArcaneTorrent:IsCastable() and IsRacials and v7:IsSpellInRange(v29.SinisterStrike) and (v47 > ((25 - 10) + v46))) then
				if v14(v29.ArcaneTorrent, true) then
					return "Cast Arcane Torrent";
				end
			end
			if (v29.ArcanePulse:IsCastable() and IsRacials and v7:IsSpellInRange(v29.SinisterStrike)) then
				if v14(v29.ArcanePulse) then
					return "Cast Arcane Pulse";
				end
			end
			if (v29.LightsJudgment:IsCastable() and IsRacials and v7:IsInMeleeRange(1389 - (746 + 638))) then
				if v14(v29.LightsJudgment, true) then
					return "Cast Lights Judgment";
				end
			end
			if (v29.BagofTricks:IsCastable() and IsRacials and v7:IsInMeleeRange(2 + 3)) then
				if v14(v29.BagofTricks, true) then
					return "Cast Bag of Tricks";
				end
			end
			if (v29.PistolShot:IsCastable() and v7:IsSpellInRange(v29.PistolShot) and not v7:IsInRange(v40) and not v6:StealthUp(true, true) and (v47 < ((61 - 20) - (357 - (218 + 123)))) and ((v44 >= ((1585 - (1535 + 46)) - (3 + 0))) or (v48 <= (1.2 + 0 + (560 - (306 + 254)))))) then
				if v14(v29.PistolShot) then
					return "Cast Pistol Shot (OOR)";
				end
			end
			if not v7:IsSpellInRange(v29.Dispatch) then
				if v17(v29.PoolEnergy, false, "OOR") then
					return "Pool Energy (OOR)";
				end
			elseif v14(v29.PoolEnergy) then
				return "Pool Energy";
			end
		end
	end
end
local function v77()
	v11.ResetToggle();
	v28.Outlaw.Display();
	v11.ToggleIconFrame:AddButtonCustom("S", 1 + 0, "smallCDs", "smallcds");
	v11.ToggleIconFrame:AddButtonCustom("A", 3 - 1, "AutoStealth", "autoStealth");
	v11.ToggleIconFrame:AddButtonCustom("I", 1470 - (899 + 568), "Interrupt", "interrupt");
	v11.ToggleIconFrame:AddButtonCustom("V", 3 + 1, "Vanish", "vanish");
	v11.ToggleIconFrame:AddButtonCustom("K", 12 - 7, "KillingSpree", "killingspree");
end
v11.SetAPL(863 - (268 + 335), v76, v77);
