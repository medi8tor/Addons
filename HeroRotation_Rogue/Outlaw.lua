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
local v24 = 0 - 0;
local v25 = false;
local v26 = C_Timer.After;
local v27 = v11.Commons().Everyone;
local v28 = v11.Commons().Rogue;
local v29 = v11.ToggleIconFrame:GetToggle(5 - 3);
local v30 = v11.GUISettingsGet();
local v31 = {General=v30.General,Commons=v30.APL.Rogue.Commons,Outlaw=v30.APL.Rogue.Outlaw,Interrupt=v30.APL.Rogue.Outlaw_Interrupt};
local v32 = v8.Rogue.Outlaw;
local v33 = v10.Rogue.Outlaw;
local v34 = {v33.ImperfectAscendancySerum:ID(),v33.MadQueensMandate:ID()};
local v35, v36 = v6:GetTrinketItems();
if ((v35:ID() == (619 - (555 + 64))) or (v36:ID() == (931 - (857 + 74)))) then
	v26(570 - (367 + 201), function()
		v35, v36 = v6:GetTrinketItems();
	end);
end
local function v37(v76)
	if v76:IsEquippedAndReady() then
		return ((v35:ID() == v76:ID()) and v31.Commons.Enabled.Trinket1) or ((v36:ID() == v76:ID()) and v31.Commons.Enabled.Trinket2);
	end
end
v3:RegisterForEvent(function()
	v35, v36 = v6:GetTrinketItems();
end, "PLAYER_EQUIPMENT_CHANGED");
local v38, v39, v40, v41, v42;
local v43;
local v44 = 933 - (214 + 713);
local v45, v46, v47;
local v48, v49, v50, v51, v52;
local v53, v54 = 0 + 0, 0 + 0;
local function v55(v77)
	local v78 = v6:EnergyTimeToMaxPredicted(nil, v77);
	if ((v78 < v53) or ((v78 - v53) > (877.5 - (282 + 595)))) then
		v53 = v78;
	end
	return v53;
end
local function v56()
	local v79 = v6:EnergyPredicted();
	if ((v79 > v54) or ((v79 - v54) > (1646 - (1523 + 114)))) then
		v54 = v79;
	end
	return v54;
end
local v57 = {v32.Broadside,v32.BuriedTreasure,v32.GrandMelee,v32.RuthlessPrecision,v32.SkullandCrossbones,v32.TrueBearing};
local v58 = false;
local function v59()
	if not v4.APLVar.RtB_Buffs then
		v4.APLVar.RtB_Buffs = {};
		v4.APLVar.RtB_Buffs.Will_Lose = {};
		v4.APLVar.RtB_Buffs.Will_Lose.Total = 0 + 0;
		v4.APLVar.RtB_Buffs.Total = 0 + 0;
		v4.APLVar.RtB_Buffs.Normal = 957 - (892 + 65);
		v4.APLVar.RtB_Buffs.Shorter = 0 - 0;
		v4.APLVar.RtB_Buffs.Longer = 0 - 0;
		v4.APLVar.RtB_Buffs.MinRemains = 183 - 83;
		v4.APLVar.RtB_Buffs.MaxRemains = 350 - (87 + 263);
		local v95 = v28.RtBRemains();
		for v102 = 181 - (67 + 113), #v57 do
			local v103 = v6:BuffRemains(v57[v102]);
			if (v103 > (0 + 0)) then
				v4.APLVar.RtB_Buffs.Total = v4.APLVar.RtB_Buffs.Total + (2 - 1);
				if (v103 > v4.APLVar.RtB_Buffs.MaxRemains) then
					v4.APLVar.RtB_Buffs.MaxRemains = v103;
				end
				if (v103 < v4.APLVar.RtB_Buffs.MinRemains) then
					v4.APLVar.RtB_Buffs.MinRemains = v103;
				end
				local v108 = math.abs(v103 - v95);
				if (v108 <= (0.5 + 0)) then
					v4.APLVar.RtB_Buffs.Normal = v4.APLVar.RtB_Buffs.Normal + (3 - 2);
					v4.APLVar.RtB_Buffs.Will_Lose[v57[v102]:Name()] = true;
					v4.APLVar.RtB_Buffs.Will_Lose.Total = v4.APLVar.RtB_Buffs.Will_Lose.Total + (953 - (802 + 150));
				elseif (v103 > v95) then
					v4.APLVar.RtB_Buffs.Longer = v4.APLVar.RtB_Buffs.Longer + (2 - 1);
				else
					v4.APLVar.RtB_Buffs.Shorter = v4.APLVar.RtB_Buffs.Shorter + (1 - 0);
					v4.APLVar.RtB_Buffs.Will_Lose[v57[v102]:Name()] = true;
					v4.APLVar.RtB_Buffs.Will_Lose.Total = v4.APLVar.RtB_Buffs.Will_Lose.Total + 1 + 0;
				end
			end
			if v58 then
				print("RtbRemains", v95);
				print(v57[v102]:Name(), v103);
			end
		end
		if v58 then
			print("have: ", v4.APLVar.RtB_Buffs.Total);
			print("will lose: ", v4.APLVar.RtB_Buffs.Will_Lose.Total);
			print("shorter: ", v4.APLVar.RtB_Buffs.Shorter);
			print("normal: ", v4.APLVar.RtB_Buffs.Normal);
			print("longer: ", v4.APLVar.RtB_Buffs.Longer);
			print("max remains: ", v4.APLVar.RtB_Buffs.MaxRemains);
			print("min remains: ", v4.APLVar.RtB_Buffs.MinRemains);
		end
	end
	return v4.APLVar.RtB_Buffs.Total;
end
local function v60(v80)
	return (v4.APLVar.RtB_Buffs.Will_Lose and v4.APLVar.RtB_Buffs.Will_Lose[v80] and true) or false;
end
local function v61()
	if not v4.APLVar.RtB_Reroll then
		if (v31.Outlaw.RolltheBonesLogic == "1+ Buff") then
			v4.APLVar.RtB_Reroll = ((v59() <= (997 - (915 + 82))) and true) or false;
		elseif (v31.Outlaw.RolltheBonesLogic == "Broadside") then
			v4.APLVar.RtB_Reroll = (not v6:BuffUp(v32.Broadside) and true) or false;
		elseif (v31.Outlaw.RolltheBonesLogic == "Buried Treasure") then
			v4.APLVar.RtB_Reroll = (not v6:BuffUp(v32.BuriedTreasure) and true) or false;
		elseif (v31.Outlaw.RolltheBonesLogic == "Grand Melee") then
			v4.APLVar.RtB_Reroll = (not v6:BuffUp(v32.GrandMelee) and true) or false;
		elseif (v31.Outlaw.RolltheBonesLogic == "Skull and Crossbones") then
			v4.APLVar.RtB_Reroll = (not v6:BuffUp(v32.SkullandCrossbones) and true) or false;
		elseif (v31.Outlaw.RolltheBonesLogic == "Ruthless Precision") then
			v4.APLVar.RtB_Reroll = (not v6:BuffUp(v32.RuthlessPrecision) and true) or false;
		elseif (v31.Outlaw.RolltheBonesLogic == "True Bearing") then
			v4.APLVar.RtB_Reroll = (not v6:BuffUp(v32.TrueBearing) and true) or false;
		else
			v4.APLVar.RtB_Reroll = false;
			v59();
			v4.APLVar.RtB_Reroll = v59() == (v19(v60(v32.BuriedTreasure)) + (v19(v60(v32.GrandMelee) and v19(v40 < (5 - 3)))));
			v4.APLVar.RtB_Reroll = v32.LoadedDice:IsAvailable() and (v4.APLVar.RtB_Buffs.Will_Lose.Total == v19(v6:BuffUp(v32.LoadedDiceBuff)));
			v4.APLVar.RtB_Reroll = (v4.APLVar.RtB_Reroll and (v4.APLVar.RtB_Buffs.Longer == (0 + 0))) or ((v4.APLVar.RtB_Buffs.Normal == (0 - 0)) and (v4.APLVar.RtB_Buffs.Longer >= (1188 - (1069 + 118))) and (v59() <= (13 - 7)) and (v4.APLVar.RtB_Buffs.MaxRemains <= (84 - 45)) and not v6:StealthUp(true, true) and v6:BuffUp(v32.LoadedDiceBuff));
			if (v7:FilteredTimeToDie("<", 3 + 9) or v3.BossFilteredFightRemains("<", 21 - 9)) then
				v4.APLVar.RtB_Reroll = false;
			end
		end
	end
	return v4.APLVar.RtB_Reroll;
end
local v62, v63;
local function v64()
	v62 = v45;
	v63 = (v28.CPMaxSpend() - (1 + 0)) - v19((v6:StealthUp(true, true) and v32.Crackshot:IsAvailable()) or ((v32.HandOfFate:IsAvailable() or v32.FlawlessForm:IsAvailable()) and v32.HiddenOpportunity:IsAvailable() and (v6:BuffUp(v32.AudacityBuff) or v6:BuffUp(v32.Opportunity))));
	return v45 >= ((v28.CPMaxSpend() - (792 - (368 + 423))) - v19((v6:StealthUp(true, true) and v32.Crackshot:IsAvailable()) or ((v32.HandOfFate:IsAvailable() or v32.FlawlessForm:IsAvailable()) and v32.HiddenOpportunity:IsAvailable() and (v6:BuffUp(v32.AudacityBuff) or v6:BuffUp(v32.Opportunity)))));
end
local function v65()
	return (v32.HiddenOpportunity:IsAvailable() or (v47 >= ((6 - 4) + v19(v32.ImprovedAmbush:IsAvailable()) + v19(v6:BuffUp(v32.Broadside))))) and (v48 >= (68 - (10 + 8)));
end
local function v66()
	return not v27.ISSolo() or v7:IsDummy() or (not v6:IsTanking(v7) and v31.Commons.UseSoloVanish);
end
local function v67(v81)
	if v32.BladeFlurry:IsReady() then
		if (v32.DeftManeuvers:IsAvailable() and not v64() and (((v40 >= (11 - 8)) and (v47 == (v40 + v19(v6:BuffUp(v32.Broadside))))) or (v40 >= (447 - (416 + 26))))) then
			if v81 then
				return v32.BladeFlurry;
			elseif v14(v32.BladeFlurry, true) then
				return "Cast Blade Flurry";
			end
		end
	end
	if (v32.ColdBlood:IsCastable() and v6:BuffDown(v32.ColdBlood) and v7:IsSpellInRange(v32.Dispatch) and v64()) then
		if v11.Cast(v32.ColdBlood, true) then
			return "Cast Cold Blood";
		end
	end
	if (not v25 and v32.BetweentheEyes:IsReady() and v7:IsSpellInRange(v32.BetweentheEyes) and v64() and v32.Crackshot:IsAvailable() and (not v6:BuffUp(v32.Shadowmeld) or v6:StealthUp(true, false))) then
		if v81 then
			return v32.BetweentheEyes;
		elseif v15(v32.BetweentheEyes) then
			return "Cast Between the Eyes";
		end
	end
	if (v32.Dispatch:IsCastable() and v7:IsSpellInRange(v32.Dispatch) and v64()) then
		if v81 then
			return v32.Dispatch;
		elseif v15(v32.Dispatch) then
			return "Cast Dispatch";
		end
	end
	if (v32.PistolShot:IsCastable() and v7:IsSpellInRange(v32.PistolShot) and v32.Crackshot:IsAvailable() and (v32.FanTheHammer:TalentRank() >= (6 - 4)) and (v6:BuffStack(v32.Opportunity) >= (3 + 3)) and ((v6:BuffUp(v32.Broadside) and (v46 <= (1 - 0))) or v6:BuffUp(v32.GreenskinsWickersBuff))) then
		if v81 then
			return v32.PistolShot;
		elseif v15(v32.PistolShot) then
			return "Cast Pistol Shot";
		end
	end
	if (v32.Ambush:IsCastable() and v7:IsSpellInRange(v32.Ambush) and v32.HiddenOpportunity:IsAvailable() and v6:BuffUp(v32.AudacityBuff)) then
		if v81 then
			return v32.SinisterStrike;
		elseif v15(v32.SinisterStrike) then
			return "Cast Ambush (SS High-Prio Buffed)";
		end
	end
	if (v32.Ambush:IsCastable() and v7:IsSpellInRange(v32.Ambush) and v32.HiddenOpportunity:IsAvailable()) then
		if v81 then
			return v32.Ambush;
		elseif v15(v32.Ambush) then
			return "Cast Ambush";
		end
	end
end
local function v68(v82)
	if (v32.BetweentheEyes:IsCastable() and v7:IsSpellInRange(v32.BetweentheEyes) and not v32.Crackshot:IsAvailable() and ((v6:BuffRemains(v32.BetweentheEyes) < (442 - (145 + 293))) or v32.ImprovedBetweenTheEyes:IsAvailable() or v32.GreenskinsWickers:IsAvailable()) and v6:BuffDown(v32.GreenskinsWickers)) then
		if v82 then
			return v32.BetweentheEyes;
		elseif v15(v32.BetweentheEyes) then
			return "Cast Between the Eyes";
		end
	end
	if (not v25 and v32.BetweentheEyes:IsReady() and v7:IsSpellInRange(v32.BetweentheEyes)) then
		if (v32.Crackshot:IsAvailable() and ((v32.Vanish:CooldownRemains() > (475 - (44 + 386))) or (v32.UnderhandedUpperhand:IsAvailable() and v32.WithoutATrace:IsAvailable() and ((v6:BuffRemains(v32.AdrenalineRush) > (1496 - (998 + 488))) or (v6:BuffDown(v32.AdrenalineRush) and (v32.AdrenalineRush:CooldownRemains() > (15 + 30))))))) then
			if v28.CastWithTTD(v32.BetweentheEyes, false, 17 + 3, false, v41) then
				return "Cast Between the Eyes";
			end
		end
	end
	if (v32.SliceandDice:IsCastable() and (v3.FilteredFightRemains(v39, ">", v6:BuffRemains(v32.SliceandDice), true) or (v6:BuffRemains(v32.SliceandDice) == (772 - (201 + 571)))) and v6:BuffRefreshable(v32.SliceandDice)) then
		if v82 then
			return v32.SliceandDice;
		elseif v15(v32.SliceandDice) then
			return "Cast Slice and Dice";
		end
	end
	if (v32.ColdBlood:IsCastable() and v6:BuffDown(v32.ColdBlood) and v7:IsSpellInRange(v32.Dispatch)) then
		if v11.Cast(v32.ColdBlood, true) then
			return "Cast Cold Blood";
		end
	end
	if (v32.CoupDeGrace:IsCastable() and v7:IsSpellInRange(v32.Dispatch)) then
		if v82 then
			return v32.CoupDeGrace;
		elseif v15(v32.CoupDeGrace) then
			return "Cast Coup de Grace";
		end
	end
	if (v32.Dispatch:IsCastable() and v7:IsSpellInRange(v32.Dispatch)) then
		if v82 then
			return v32.Dispatch;
		elseif v15(v32.Dispatch) then
			return "Cast Dispatch";
		end
	end
end
local function v69(v83)
	local v84;
	if ((v83:ID() == v32.Vanish:ID()) or (v83:ID() == v32.Shadowmeld:ID())) then
		v84 = v67(true);
		if (v83:ID() == v32.Vanish:ID()) then
			if v14(v32.Vanish, true) then
				return "Cast Vanish";
			end
			return false;
		elseif (v83:ID() == v32.Shadowmeld:ID()) then
			if v14(v32.Shadowmeld, true) then
				return "Cast Shadowmeld";
			end
			return false;
		end
	elseif (v83:ID() == v32.AdrenalineRush:ID()) then
		v45 = v6:ComboPointsMax();
		if not v6:StealthUp(true, true) then
			v84 = v68(true);
		else
			v84 = v67(true);
		end
		if v14(v32.AdrenalineRush, true) then
			return "Cast Adrenaline Rush";
		end
		return false;
	end
	local v85 = {v83,v84};
	v43 = v18(unpack(v85));
	if v43 then
		return "| " .. v85[2 + 0]:Name();
	end
	return false;
end
local function v70()
	if (v13() and v32.Vanish:IsReady() and v11.ToggleIconFrame:GetToggle(3 - 2) and v7:IsSpellInRange(v32.Dispatch) and v66() and v32.UnderhandedUpperhand:IsAvailable() and v32.Subterfuge:IsAvailable() and (v6:BuffUp(v32.AdrenalineRush) or v32.AdrenalineRush:IsReady() or (not v32.WithoutATrace:IsAvailable() and v32.Crackshot:IsAvailable())) and (v64() or (not v32.Crackshot:IsAvailable() and (v65 or not v32.HiddenOpportunity:IsAvailable())))) then
		v43 = v28.CastWithTTD(v32.Vanish, true, v31.Outlaw.TimeToDie.Stealth, v31.Commons.Enabled.IgnoreTtdOnBoss and v42, v41);
		if v43 then
			return v43 .. "(1)";
		end
	end
	if (v13() and v32.Vanish:IsReady() and v11.ToggleIconFrame:GetToggle(3 - 2) and v7:IsSpellInRange(v32.Dispatch) and v66() and not v32.UnderhandedUpperhand:IsAvailable() and v32.Crackshot:IsAvailable() and v64()) then
		v43 = v28.CastWithTTD(v32.Vanish, true, v31.Outlaw.TimeToDie.Stealth, v31.Commons.Enabled.IgnoreTtdOnBoss and v42, v41);
		if v43 then
			return v43 .. "(2)";
		end
	end
	if (v32.Vanish:IsReady() and v66() and not v32.UnderhandedUpperhand:IsAvailable() and not v32.Crackshot:IsAvailable() and v32.HiddenOpportunity:IsAvailable() and v6:BuffDown(v32.AudacityBuff) and (v6:BuffStack(v32.Opportunity) < (865 - (814 + 45))) and v65()) then
		v43 = v28.CastWithTTD(v32.Vanish, true, v31.Outlaw.TimeToDie.Stealth, v31.Commons.Enabled.IgnoreTtdOnBoss and v42, v41);
		if v43 then
			return v43 .. "(3)";
		end
	end
	if (v32.Vanish:IsReady() and v66()) then
		if (not v32.UnderhandedUpperhand:IsAvailable() and not v32.Crackshot:IsAvailable() and not v32.HiddenOpportunity:IsAvailable() and not v32.FatefulEnding:IsAvailable() and ((v6:BuffDown(v32.FateboundLuckyCoin) and ((v6:BuffStack(v32.FateboundCoinTails) >= (12 - 7)) or (v6:BuffStack(v32.FateboundCoinHeads) >= (1 + 4)))) or v6:BuffUp(v32.FateboundLuckyCoin and not v32.BetweentheEyes:IsReady()))) then
			v43 = v28.CastWithTTD(v32.Vanish, true, v31.Outlaw.TimeToDie.Stealth, v31.Commons.Enabled.IgnoreTtdOnBoss and v42, v41);
			if v43 then
				return v43 .. "(4)";
			end
		end
	end
	if (v32.Vanish:IsReady() and v66()) then
		if (not v32.UnderhandedUpperhand:IsAvailable() and not v32.Crackshot:IsAvailable() and not v32.HiddenOpportunity:IsAvailable() and not v32.FatefulEnding:IsAvailable() and v32.TakeEmBySurprise:IsAvailable() and v6:BuffDown(v32.TakeEmBySurpriseBuff)) then
			v43 = v28.CastWithTTD(v32.Vanish, true, v31.Outlaw.TimeToDie.Stealth, v31.Commons.Enabled.IgnoreTtdOnBoss and v42, v41);
			if v43 then
				return v43 .. "(5)";
			end
		end
	end
	if (v32.Shadowmeld:IsAvailable() and v32.Shadowmeld:IsReady() and v11.ToggleIconFrame:GetToggle(1 + 0) and v7:IsSpellInRange(v32.Dispatch) and v64() and not v32.Vanish:IsReady()) then
		v43 = v28.CastWithTTD(v32.Shadowmeld, true, v31.Outlaw.TimeToDie.Stealth, v31.Commons.Enabled.IgnoreTtdOnBoss and v42, v41);
		if v43 then
			return v43;
		end
	end
end
local function v71()
	if v11.DebugON() then
	end
	if (v13() and v32.AdrenalineRush:IsCastable() and v28.TTDCheck(v31.Outlaw.TimeToDie.AdrenalineRush, v31.Commons.Enabled.IgnoreTtdOnBoss and v42, v41) and ((not v6:BuffUp(v32.AdrenalineRush) and (not v64() or not v32.ImprovedAdrenalineRush:IsAvailable())) or (v6:StealthUp(true, true) and v32.Crackshot:IsAvailable() and v32.ImprovedAdrenalineRush:IsAvailable() and (v46 <= (887 - (261 + 624)))))) then
		if v32.ImprovedAdrenalineRush:IsAvailable() then
			v43 = v69(v32.AdrenalineRush);
			if v43 then
				return "AR Finisher Macro 1 " .. v43;
			end
		elseif v14(v32.AdrenalineRush, true) then
			return "Cast Adrenaline Rush";
		end
	end
	if v32.BladeFlurry:IsReady() then
		if ((v40 >= (3 - 1)) and (v6:BuffRemains(v32.BladeFlurry) < v6:GCD())) then
			if v11.Cast(v32.BladeFlurry, true) then
				return "Cast Blade Flurry";
			end
		end
	end
	if (v32.BladeFlurry:IsReady() and v44) then
		if (v32.DeftManeuvers:IsAvailable() and not v64() and (((v40 >= (1083 - (1020 + 60))) and (v47 == (v40 + v19(v6:BuffUp(v32.Broadside))))) or (v40 >= (1428 - (630 + 793))))) then
			if v11.Cast(v32.BladeFlurry, true) then
				return "Cast Blade Flurry";
			end
		end
	end
	if v32.RolltheBones:IsReady() then
		if (v61() or (v59() == (0 - 0)) or ((v4.APLVar.RtB_Buffs.MaxRemains <= (37 - 29)) and (v32.Vanish:CooldownRemains() <= (2 + 1)) and v32.Crackshot:IsAvailable())) then
			if v11.Cast(v32.RolltheBones, true) then
				return "Cast Roll the Bones";
			end
		end
	end
	if (v32.KeepItRolling:IsReady() and (v59() >= (13 - 9)) and ((v4.APLVar.RtB_Buffs.MinRemains < (1750 - (760 + 987))) or v6:BuffUp(v32.Broadside))) then
		if v11.Cast(v32.KeepItRolling, true) then
			return "Cast Keep it Rolling";
		end
	end
	if (v13() and v32.GhostlyStrike:IsAvailable() and v7:IsSpellInRange(v32.SinisterStrike) and v32.GhostlyStrike:IsReady() and (v45 < v28.CPMaxSpend()) and ((v7:TimeToDie() >= (1921 - (1789 + 124))) or (v31.Commons.Enabled.IgnoreTtdOnBoss and v42) or v27.Buggedmobs[v7:NPCID()])) then
		if v11.Cast(v32.GhostlyStrike, true) then
			return "Cast Ghostly Strike";
		end
	end
	if (v13() and (v31.Commons.Enabled.Trinket1 or v31.Commons.Enabled.Trinket2)) then
		if v37(v33.ImperfectAscendancySerum) then
			if (not v6:StealthUp(true, true) or v3.BossFilteredFightRemains("<=", 788 - (745 + 21))) then
				if v28.CastWithTTD(v33.ImperfectAscendancySerum, true, v31.Outlaw.TimeToDie.Trinkets, v31.Commons.Enabled.IgnoreTtdOnBoss and v42, v41) then
					return "Imperfect Ascendancy Serum";
				end
			end
		end
		if v37(v33.MadQueensMandate) then
			if (not v6:StealthUp(true, true) or v3.BossFilteredFightRemains("<=", 2 + 3)) then
				if v28.CastWithTTD(v33.MadQueensMandate, true, v31.Outlaw.TimeToDie.Trinkets, v31.Commons.Enabled.IgnoreTtdOnBoss and v42, v41) then
					return "Mad Queens Mandate";
				end
			end
		end
	end
	if (v32.KillingSpree:IsCastable() and v7:IsSpellInRange(v32.KillingSpree) and v64() and not v6:StealthUp(true, true)) then
		if v28.CastWithTTD(v32.KillingSpree, true, v31.Outlaw.TimeToDie.KillingSpree, v31.Commons.Enabled.IgnoreTtdOnBoss and v42, v41) then
			return "Cast Killing Spree";
		end
	end
	if (not v6:StealthUp(true, true) and (not v32.Crackshot:IsAvailable() or v32.BetweentheEyes:IsReady())) then
		v43 = v70();
		if v43 then
			return v43;
		end
	end
	if (v13() and v32.ThistleTea:IsCastable() and not v6:BuffUp(v32.ThistleTea) and ((v50 >= (412 - 262)) or v3.BossFilteredFightRemains("<", v32.ThistleTea:Charges() * (23 - 17)))) then
		v43 = v28.CastWithTTD(v32.ThistleTea, true, v31.Outlaw.TimeToDie.ThistleTea, v31.Commons.Enabled.IgnoreTtdOnBoss and v42, v41);
		if v43 then
			return v43;
		end
	end
	if (v32.BladeRush:IsCastable() and v7:IsSpellInRange(v32.Ambush) and (v51 > (1 + 3)) and not v6:StealthUp(true, true)) then
		if v11.Cast(v32.BladeRush, true) then
			return "Cast Blade Rush";
		end
	end
	if (v13() and v31.Commons.Enabled.Potions) then
		local v96 = v27.PotionSelected();
		if (v96 and v96:IsReady() and (v6:BloodlustUp() or v3.BossFilteredFightRemains("<", 24 + 6) or v6:BuffUp(v32.AdrenalineRush))) then
			v11.CastMacro(1058 - (87 + 968), nil, nil, v96);
			return "Cast Potion";
		end
	end
	if v31.Commons.Enabled.Racials then
		if (v13() and v32.BloodFury:IsCastable()) then
			if v11.Cast(v32.BloodFury, true) then
				return "Cast Blood Fury";
			end
		end
		if (v13() and v32.Berserking:IsCastable()) then
			if v11.Cast(v32.Berserking, true) then
				return "Cast Berserking";
			end
		end
		if (v13() and v32.Fireblood:IsCastable()) then
			if v11.Cast(v32.Fireblood, true) then
				return "Cast Fireblood";
			end
		end
		if (v13() and v32.AncestralCall:IsCastable()) then
			if v14(v32.AncestralCall, true) then
				return "Cast Ancestral Call";
			end
		end
	end
	if (v13() and (v31.Commons.Enabled.Trinket1 or v31.Commons.Enabled.Trinket2)) then
		local v97 = v6:GetUseableItems(v34, 57 - 44) or v6:GetUseableItems(v34, 13 + 1);
		local v98;
		local v99 = 226 - 126;
		if v97 then
			v98 = v97:OnUseSpell();
			v99 = (v98 and (v98.MaximumRange > (1413 - (447 + 966))) and (v98.MaximumRange <= (273 - 173)) and v98.MaximumRange) or (1917 - (1703 + 114));
		end
		if (v97 and (v6:BuffUp(v32.BetweentheEyes) or v3.BossFilteredFightRemains("<", 721 - (376 + 325)) or v97:HasStatAnyDps())) then
			if (v37(v97) and v28.CastWithTTD(v97, true, v31.Outlaw.TimeToDie.Trinkets, v31.Commons.Enabled.IgnoreTtdOnBoss and v42, v41)) then
				return "Generic use_items for " .. v97:Name();
			end
		end
	end
end
local function v72()
	if (v13() and v32.EchoingReprimand:IsReady() and v7:IsSpellInRange(v32.EchoingReprimand)) then
		if v11.Cast(v32.EchoingReprimand, true) then
			return "Cast Echoing Reprimand";
		end
	end
	if (v32.Ambush:IsCastable() and v7:IsSpellInRange(v32.Ambush) and v32.HiddenOpportunity:IsAvailable() and v6:BuffUp(v32.AudacityBuff)) then
		if v11.CastPooling(v32.SinisterStrike) then
			return "Cast Ambush (High-Prio Buffed)";
		end
	end
	if (v32.FanTheHammer:IsAvailable() and v7:IsSpellInRange(v32.PistolShot) and v32.Audacity:IsAvailable() and v32.HiddenOpportunity:IsAvailable() and v6:BuffUp(v32.Opportunity) and v6:BuffDown(v32.AudacityBuff)) then
		if v11.CastPooling(v32.PistolShot) then
			return "Cast Pistol Shot (Audacity)";
		end
	end
	if (v32.FanTheHammer:IsAvailable() and v7:IsSpellInRange(v32.PistolShot) and v6:BuffUp(v32.Opportunity) and ((v6:BuffStack(v32.Opportunity) >= (9 - 3)) or (v6:BuffRemains(v32.Opportunity) < (5 - 3)))) then
		if v11.CastPooling(v32.PistolShot) then
			return "Cast Pistol Shot (FtH Dump)";
		end
	end
	if (v32.FanTheHammer:IsAvailable() and v7:IsSpellInRange(v32.PistolShot) and v6:BuffUp(v32.Opportunity) and ((v47 >= (1 + 0 + ((v19(v32.QuickDraw:IsAvailable()) + v19(v6:BuffUp(v32.Broadside))) * (v32.FanTheHammer:TalentRank() + (2 - 1))))) or (v46 <= v19(v32.Ruthlessness:IsAvailable())))) then
		if v11.CastPooling(v32.PistolShot) then
			return "Cast Pistol Shot";
		end
	end
	if (not v32.FanTheHammer:IsAvailable() and v7:IsSpellInRange(v32.PistolShot) and v6:BuffUp(v32.Opportunity) and ((v51 > (15.5 - (9 + 5))) or (v47 <= ((377 - (85 + 291)) + v19(v6:BuffUp(v32.Broadside)))) or v32.QuickDraw:IsAvailable() or (v32.Audacity:IsAvailable() and v6:BuffDown(v32.AudacityBuff)))) then
		if v11.CastPooling(v32.PistolShot) then
			return "Cast Pistol Shot";
		end
	end
	if (v32.SinisterStrike:IsCastable() and v7:IsSpellInRange(v32.SinisterStrike)) then
		if v11.CastPooling(v32.SinisterStrike) then
			return "Cast Sinister Strike";
		end
	end
end
local function v73()
	if (v30.General.AutoTab and v6:AffectingCombat()) then
		local v100 = v6:GetEnemiesInRange(v44);
		local v101 = v7:GUID();
		for v104, v105 in pairs(v100) do
			if ((v105:GUID() ~= v101) and not v105:IsFacingBlacklisted() and v105:DebuffUp(v32.GhostlyStrike)) then
				v11.TopPanelAlternative:ChangeIcon(1266 - (243 + 1022), 11 - 8);
				return "Auto tab to target GS";
			end
		end
	end
end
local function v74()
	v29 = v11.ToggleIconFrame:GetToggle(2 + 0);
	v44 = 1186 - (1123 + 57);
	v46 = v6:ComboPoints();
	v45 = v28.EffectiveComboPoints(v46);
	v47 = v6:ComboPointsDeficit();
	v52 = (v6:BuffUp(v32.AdrenalineRush, nil, true) and -(41 + 9)) or (254 - (163 + 91));
	v48 = v56();
	v49 = v6:EnergyRegen();
	v51 = v55(v52);
	v50 = v6:EnergyDeficitPredicted(nil, v52);
	v38 = v6:GetEnemiesInRange(1960 - (1869 + 61));
	v41 = v3.BossFightRemains();
	v42 = true;
	if (v41 == (3105 + 8006)) then
		v42 = false;
		v41 = v3.FightRemains(v38, false);
	end
	if v12() then
		v39 = v6:GetEnemiesInRange(v44);
		v40 = #v39;
	else
		v40 = 3 - 2;
	end
	v43 = v28.Defense();
	if v43 then
		return v43;
	end
	v43 = v28.Poisons();
	if v43 then
		return v43;
	end
	v43 = (v40 > (0 - 0)) and not v7:IsInRange(v44 + 1 + 1) and v28.AutoTarget();
	if v43 then
		return v43;
	end
	if (not v6:AffectingCombat() and (v32.Vanish:TimeSinceLastCast() > (1 - 0))) then
		if not v6:StealthUp(false, false, true) then
			v43 = v28.Stealth(v28.StealthSpell());
			if v43 then
				return v43;
			end
		end
		if (v28.CombatCheck() or (v29 and v27.TargetIsValid())) then
			if not v6:StealthUp(false, false, true) then
				v43 = v28.Stealth(v28.StealthSpell());
				if v43 then
					return v43;
				end
			elseif v32.BetweentheEyes:CooldownDown() then
				v24 = v32.BetweentheEyes:CooldownRemains() + GetTime();
			end
			if (v13() and (v31.Commons.Enabled.Trinket1 or v31.Commons.Enabled.Trinket2)) then
				if v37(v33.ImperfectAscendancySerum) then
					if v28.CastWithTTD(v33.ImperfectAscendancySerum, true, v31.Outlaw.TimeToDie.Trinkets, v31.Commons.Enabled.IgnoreTtdOnBoss and v42, v41) then
						return "Imperfect Ascendancy Serum";
					end
				end
			end
			if (v32.RolltheBones:IsAvailable() and v32.RolltheBones:IsReady() and ((v59() == (0 + 0)) or v61())) then
				if v11.Cast(v32.RolltheBones) then
					return "Cast Roll the Bones";
				end
			end
			if (v32.AdrenalineRush:IsReady() and v13() and v32.ImprovedAdrenalineRush:IsAvailable() and (v46 <= (1476 - (1329 + 145))) and v6:BuffDown(v32.AdrenalineRush)) then
				if v11.Cast(v32.AdrenalineRush) then
					return "Cast Adrenaline Rush";
				end
			end
			if (v32.SliceandDice:IsReady() and (v6:BuffRemains(v32.SliceandDice) < (((972 - (140 + 831)) + v46) * (1851.8 - (1409 + 441))))) then
				if v11.CastPooling(v32.SliceandDice) then
					return "Cast Slice and Dice (Opener)";
				end
			end
			if v6:StealthUp(true, false) then
				v43 = v67();
				if v43 then
					return "Stealth (Opener): " .. v43;
				end
				if (v32.KeepItRolling:IsAvailable() and v7:IsSpellInRange(v32.SinisterStrike) and v32.GhostlyStrike:IsReady() and v32.EchoingReprimand:IsAvailable()) then
					if v14(v32.GhostlyStrike) then
						return "Cast Ghostly Strike KiR (Opener)";
					end
				end
				if (v32.Ambush:IsCastable() and v32.HiddenOpportunity:IsAvailable() and v7:IsSpellInRange(v32.SinisterStrike)) then
					if v14(v32.Ambush) then
						return "Cast Ambush (Opener)";
					end
				elseif (v32.SinisterStrike:IsCastable() and v7:IsSpellInRange(v32.SinisterStrike)) then
					if v14(v32.SinisterStrike) then
						return "Cast Sinister Strike (Opener)";
					end
				end
			elseif v64() then
				v43 = v68();
				if v43 then
					return "Finish (Opener): " .. v43;
				end
			end
			if (v32.SinisterStrike:IsCastable() and v7:IsSpellInRange(v32.SinisterStrike)) then
				if v14(v32.SinisterStrike) then
					return "Cast Sinister Strike (Opener)";
				end
			end
		end
		v25 = v24 > GetTime();
	end
	v25 = v24 > GetTime();
	if (v32.FanTheHammer:IsAvailable() and (v32.PistolShot:TimeSinceLastCast() < v6:GCDRemains())) then
		v46 = v22(v46, v28.FanTheHammerCP());
		v45 = v28.EffectiveComboPoints(v46);
		v47 = v6:ComboPointsDeficit();
	end
	if v28.CombatCheck() then
		if v11.ToggleIconFrame:GetToggle(721 - (15 + 703)) then
			v43 = v27.InterruptCycle(v32.Kick, v44, true, nil, false);
			if v43 then
				return v43;
			end
			v43 = v27.IncorpCycle(v32.Blind, 7 + 8, true, nil, false);
			if v43 then
				return v43;
			end
			v43 = v31.Interrupt.UseBlind and v27.InterruptCycle(v32.Blind, 453 - (262 + 176), true, nil, true);
			if v43 then
				return v43;
			end
			v43 = v31.Interrupt.UseKidneyShot and (v46 > (1721 - (345 + 1376))) and v27.InterruptCycle(v32.KidneyShot, v44, true, nil, true);
			if v43 then
				return v43;
			end
			v43 = v31.Interrupt.UseCheapShop and v6:StealthUp(true, true) and v27.InterruptCycle(v32.CheapShot, v44, true, nil, true);
			if v43 then
				return v43;
			end
		end
		v43 = v31.Commons.Enabled.Shiv and v27.SootheCycle(v32.Shiv, 697 - (198 + 490), true, v31.Commons.Enabled["Shiv Auto Target"]);
		if v43 then
			return v43;
		end
		v43 = v31.Outlaw.AutoTabGS and v73();
		if v43 then
			return v43;
		end
		v43 = v71();
		if v43 then
			return "CDs: " .. v43;
		end
		if v6:StealthUp(true, true) then
			v43 = v67();
			if v43 then
				return "Stealth: " .. v43;
			end
		end
		if v64() then
			v43 = v68();
			if v43 then
				return "Finish: " .. v43 .. " CP:" .. v62 .. " count:" .. v63;
			end
			v11.Cast(v32.PoolEnergy);
			return "Finish Pooling";
		end
		v43 = v72();
		if v43 then
			return "Build: " .. v43;
		end
		if v31.Commons.Enabled.Racials then
			if (v32.ArcaneTorrent:IsCastable() and v7:IsSpellInRange(v32.SinisterStrike) and (v50 > ((66 - 51) + v49))) then
				if v11.Cast(v32.ArcaneTorrent, true) then
					return "Cast Arcane Torrent";
				end
			end
			if (v32.ArcanePulse:IsCastable() and v7:IsSpellInRange(v32.SinisterStrike)) then
				if v11.Cast(v32.ArcanePulse) then
					return "Cast Arcane Pulse";
				end
			end
			if (v32.LightsJudgment:IsCastable() and v7:IsInMeleeRange(11 - 6)) then
				if v11.Cast(v32.LightsJudgment, true) then
					return "Cast Lights Judgment";
				end
			end
			if (v32.BagofTricks:IsCastable() and v7:IsInMeleeRange(1211 - (696 + 510))) then
				if v11.Cast(v32.BagofTricks, true) then
					return "Cast Bag of Tricks";
				end
			end
		end
		if (v32.PistolShot:IsCastable() and v7:IsSpellInRange(v32.PistolShot) and not v7:IsInRange(v44) and not v6:StealthUp(true, true) and (v50 < (52 - 27)) and ((v47 >= (1263 - (1091 + 171))) or (v51 <= (1.2 + 0)))) then
			if v11.Cast(v32.PistolShot) then
				return "Cast Pistol Shot (OOR)";
			end
		end
		if not v7:IsSpellInRange(v32.Dispatch) then
			if v17(v32.PoolEnergy, false, "OOR") then
				return "Pool Energy (OOR)";
			end
		elseif v14(v32.PoolEnergy) then
			return "Pool Energy";
		end
	end
end
local function v75()
	v31.Outlaw.Display();
end
v11.SetAPL(818 - 558, v74, v75);
