local v0, v1 = ...;
local v2 = HeroDBC.DBC;
local v3 = HeroLib;
local v4 = HeroCache;
local v5 = v3.Utils;
local v6 = v3.Unit;
local v7 = v6.Player;
local v8 = v6.Target;
local v9 = v6.Pet;
local v10 = v3.Spell;
local v11 = v6.MouseOver;
local v12 = v3.MultiSpell;
local v13 = v3.Item;
local v14 = HeroRotation();
local v15 = v14.AoEON;
local v16 = v14.CDsON;
local v17 = v14.Cast;
local v18 = v14.CastAnnotated;
local v19 = v14.Commons().Everyone.num;
local v20 = v14.Commons().Everyone.bool;
local v21 = pairs;
local v22 = v10.Monk.Windwalker;
local v23 = v13.Monk.Windwalker;
local v24 = {v23.AlgetharPuzzleBox:ID(),v23.BeacontotheBeyond:ID(),v23.Djaruun:ID(),v23.DragonfireBombDispenser:ID(),v23.EruptingSpearFragment:ID(),v23.ManicGrieftorch:ID()};
local v25;
local v26;
local v27;
local v28 = 11679 - (367 + 201);
local v29 = 12038 - (214 + 713);
local v30;
local v31;
local v32 = false;
local v33 = false;
local v34 = false;
local v35 = false;
local v36 = false;
local v37 = false;
local v38 = false;
local v39 = 1 + 1;
local v40 = v7:IsInDungeonArea();
local v41 = (v23.NeltharionsCalltoDominance:IsEquipped() or v23.AshesoftheEmbersoul:IsEquipped() or v23.MirrorofFracturedTomorrows:IsEquipped() or v23.WitherbarksBranch:IsEquipped()) and not v40;
local v42 = {{v22.LegSweep,"Cast Leg Sweep (Stun)",function()
	return true;
end},{v22.RingOfPeace,"Cast Ring Of Peace (Stun)",function()
	return true;
end},{v22.Paralysis,"Cast Paralysis (Stun)",function()
	return true;
end}};
local v43 = false;
local v44 = 0 - 0;
local v45;
local v46, v47;
local v48 = v7:GetEquipment();
local v49 = (v48[23 - 10] and v13(v48[23 - 10])) or v13(350 - (87 + 263));
local v50 = (v48[194 - (67 + 113)] and v13(v48[11 + 3])) or v13(0 - 0);
local v51 = v14.Commons().Everyone;
local v52 = v14.Commons().Monk;
local v53 = v14.GUISettingsGet();
local v54 = {General=v53.General,Commons=v53.APL.Monk.Commons,Windwalker=v53.APL.Monk.Windwalker,Cooldowns=v53.APL.Monk.Windwalker.Cooldowns};
v3:RegisterForEvent(function()
	v44 = 0 + 0;
	v28 = 44160 - 33049;
	v29 = 12063 - (802 + 150);
end, "PLAYER_REGEN_ENABLED");
v3:RegisterForEvent(function()
	v39 = 5 - 3;
end, "SPELLS_CHANGED", "LEARNED_SPELL_IN_TAB");
v3:RegisterForEvent(function()
	v48 = v7:GetEquipment();
	v49 = (v48[23 - 10] and v13(v48[10 + 3])) or v13(997 - (915 + 82));
	v50 = (v48[39 - 25] and v13(v48[9 + 5])) or v13(0 - 0);
	v40 = v7:IsInDungeonArea();
	v41 = (v23.NeltharionsCalltoDominance:IsEquipped() or v23.AshesoftheEmbersoul:IsEquipped() or v23.MirrorofFracturedTomorrows:IsEquipped() or v23.WitherbarksBranch:IsEquipped()) and not v40;
end, "PLAYER_EQUIPMENT_CHANGED");
v3:RegisterForEvent(function()
	v40 = v7:IsInDungeonArea();
	v41 = (v23.NeltharionsCalltoDominance:IsEquipped() or v23.AshesoftheEmbersoul:IsEquipped() or v23.MirrorofFracturedTomorrows:IsEquipped() or v23.WitherbarksBranch:IsEquipped()) and not v40;
end, "ZONE_CHANGED_NEW_AREA");
local function v55(v110)
	return v45 or v51.ISSolo() or ((v29 >= v110) and (v29 < (8964 - (1069 + 118))));
end
local function v56()
	return math.floor((v7:EnergyTimeToMaxPredicted() * (22 - 12)) + (0.5 - 0)) / (2 + 8);
end
local function v57()
	return math.floor(v7:EnergyPredicted() + (0.5 - 0));
end
local function v58(v111)
	return not v7:PrevGCD(1 + 0, v111);
end
local function v59()
	return v23.ManicGrieftorch:IsEquipped() and (v23.ManicGrieftorch:CooldownUp() or (v23.ManicGrieftorch:CooldownRemains() <= v7:GCDRemains()));
end
local function v60()
	return (v23.AshesoftheEmbersoul:IsEquipped() and v23.AshesoftheEmbersoul:CooldownDown()) or not v23.AshesoftheEmbersoul:IsEquipped();
end
local v61 = 791 - (368 + 423);
local function v62()
	if not v7:AffectingCombat() then
		v61 = 0 - 0;
		return 18 - (10 + 8);
	end
	if v7:PrevGCD(3 - 2, v22.TigerPalm) then
		v61 = 443 - (416 + 26);
	elseif v7:PrevGCD(3 - 2, v22.SpinningCraneKick) then
		v61 = 1 + 1;
	elseif v7:PrevGCD(1 - 0, v22.ExpelHarm) then
		v61 = 441 - (145 + 293);
	elseif v7:PrevGCD(431 - (44 + 386), v22.RisingSunKick) then
		v61 = 1490 - (998 + 488);
	elseif v7:PrevGCD(1 + 0, v22.ChiWave) then
		v61 = 5 + 0;
	elseif v7:PrevGCD(773 - (201 + 571), v22.ChiBurst) then
		v61 = 1144 - (116 + 1022);
	elseif v7:PrevGCD(4 - 3, v22.BlackoutKick) then
		v61 = 5 + 2;
	elseif v7:PrevGCD(3 - 2, v22.FistsofFury) then
		v61 = 28 - 20;
	elseif v7:PrevGCD(860 - (814 + 45), v22.RushingJadeWind) then
		v61 = 21 - 12;
	elseif v7:PrevGCD(1 + 0, v22.WhirlingDragonPunch) then
		v61 = 4 + 6;
	elseif v7:PrevGCD(886 - (261 + 624), v22.StormEarthAndFire) then
		v61 = 19 - 8;
	elseif v7:PrevGCD(1081 - (1020 + 60), v22.JadefireStomp) then
		v61 = 1435 - (630 + 793);
	elseif v7:PrevGCD(3 - 2, v22.TouchofDeath) then
		v61 = 61 - 48;
	elseif v7:PrevGCD(1 + 0, v22.FlyingSerpentKick) then
		v61 = 48 - 34;
	elseif v7:PrevGCD(1748 - (760 + 987), v22.StrikeoftheWindlord) then
		v61 = 1928 - (1789 + 124);
	elseif v7:PrevGCD(767 - (745 + 21), v22.CracklingJadeLightning) then
		v61 = 6 + 10;
	end
	return v61;
end
local function v63()
	if (v7:Level() < (90 - 57)) then
		return 0 - 0;
	end
	local v112 = 0 + 0;
	for v141, v142 in v21(v26) do
		if v142:DebuffUp(v22.MarkoftheCraneDebuff) then
			v112 = v112 + 1 + 0;
		end
	end
	return v112;
end
local function v64()
	if (v7:Level() < (1088 - (87 + 968))) then
		return 0 - 0;
	end
	local v113 = v63();
	local v114 = 1 + 0;
	local v115 = 0.18 - 0;
	if (v113 > (1413 - (447 + 966))) then
		v114 = v114 * ((2 - 1) + (v113 * v115));
	end
	v114 = v114 * ((1818 - (1703 + 114)) + ((701.1 - (376 + 325)) * v22.CraneVortex:TalentRank()));
	v114 = v114 * ((1 - 0) + ((0.3 - 0) * v19(v7:BuffUp(v22.KicksofFlowingMomentumBuff))));
	v114 = v114 * (1 + 0 + ((0.05 - 0) * v22.FastFeet:TalentRank()));
	return v114;
end
local function v65()
	if (v7:Level() < (47 - (9 + 5))) then
		return true;
	end
	local v116 = v63();
	if ((v27 == v116) or (v116 >= (381 - (85 + 291)))) then
		return true;
	end
	return false;
end
local function v66()
	if not (v22.TouchofDeath:CooldownUp() or v7:BuffUp(v22.HiddenMastersForbiddenTouchBuff)) then
		return nil;
	end
	local v117, v118 = nil, nil;
	for v143, v144 in v21(v25) do
		if (not v144:IsFacingBlacklisted() and not v144:IsUserCycleBlacklisted() and (v144:AffectingCombat() or v144:IsDummy()) and ((v22.ImpTouchofDeath:IsAvailable() and (v144:HealthPercentage() <= (1280 - (243 + 1022)))) or (v144:Health() < v7:Health())) and (not v118 or v5.CompareThis("max", v144:Health(), v118))) then
			v117, v118 = v144, v144:Health();
		end
	end
	if (v117 and (v117 == v8)) then
		if not v22.TouchofDeath:IsReady() then
			return nil;
		end
	end
	return v117;
end
local function v67()
	local v119, v120 = nil, nil;
	for v145, v146 in v21(v26) do
		if (not v146:IsFacingBlacklisted() and not v146:IsUserCycleBlacklisted() and (v146:AffectingCombat() or v146:IsDummy()) and (not v120 or v5.CompareThis("max", v146:TimeToDie(), v120))) then
			v119, v120 = v146, v146:TimeToDie();
		end
	end
	return v119;
end
local function v68(v121)
	return v121:DebuffRemains(v22.MarkoftheCraneDebuff);
end
local function v69(v122)
	return v122:DebuffDown(v22.MarkoftheCraneDebuff);
end
local function v70(v123)
	return v123:DebuffRemains(v22.MarkoftheCraneDebuff);
end
local function v71(v124)
	return v124:DebuffRemains(v22.MarkoftheCraneDebuff) + (v19(v124:DebuffUp(v22.SkyreachExhaustionDebuff)) * (76 - 56));
end
local function v72(v125)
	return v125:DebuffRemains(v22.MarkoftheCraneDebuff) + (v19(v8:DebuffDown(v22.SkyreachExhaustionDebuff)) * (17 + 3));
end
local function v73(v126)
	return v126:DebuffRemains(v22.MarkoftheCraneDebuff) - (v19(v65()) * (v126:TimeToDie() + (v126:DebuffRemains(v22.SkyreachCritDebuff) * (1200 - (1123 + 57)))));
end
local function v74(v127)
	return v127:DebuffRemains(v22.JadefireBrand);
end
local function v75(v128)
	return v128:TimeToDie();
end
local function v76(v129)
	return v129:DebuffRemains(v22.SkyreachCritDebuff);
end
local function v77(v130)
	return v130:DebuffRemains(v22.JadefireBrand);
end
local function v78(v131)
	return v7:BuffUp(v22.PressurePointBuff) or (v131:DebuffRemains(v22.SkyreachExhaustionDebuff) > (45 + 10));
end
local function v79(v132)
	return v7:BuffUp(v22.KicksofFlowingMomentumBuff) or v7:BuffUp(v22.PressurePointBuff) or (v132:DebuffRemains(v22.SkyreachExhaustionDebuff) > (309 - (163 + 91)));
end
local function v80(v133)
	return v133:DebuffRemains(v22.SkyreachExhaustionDebuff) > v7:BuffRemains(v22.CalltoDominanceBuff);
end
local function v81(v134)
	return v134:DebuffRemains(v22.SkyreachExhaustionDebuff) > (1985 - (1869 + 61));
end
local v82 = v51.converArrayToList({(904741 - 647859),(27408 + 172883)});
local v83 = v51.converArrayToList({(243809 + 15763),(257548 - (140 + 831)),(259908 - (15 + 703)),(256015 - (262 + 176)),(202707 - (198 + 490)),(490537 - 286035),(463196 - 242341),(32086 + 167303),(678740 - 474074),(2059545 - 1645062),(34904 + 378718),(408814 - (660 + 176)),(413808 - (14 + 188)),(165612 + 246340),(410752 + 16471),(681011 - 252060),(90988 + 78457),(428064 - (115 + 281)),(355078 + 73790),(281001 - 204367),(376657 - 115955)});
local function v84()
	local v135 = v7:GetEnemiesInRange(56 - 16);
	for v147, v148 in v21(v135) do
		if v82[v148:CastSpellID() or v148:ChannelSpellID()] then
			return true;
		end
	end
end
local function v85()
	local v136 = v7:GetEnemiesInRange(111 - 71);
	for v149, v150 in v21(v136) do
		if v83[v150:CastSpellID() or v150:ChannelSpellID()] then
			return true;
		end
	end
end
local function v86()
	if (v22.FortifyingBrew:IsCastable() and ((v7:HealthPercentageWeighted() <= v54.Windwalker.FortifyingBrewHP) or v84())) then
		if v17(v22.FortifyingBrew) then
			return "fortifying_brew defensives 4";
		end
	end
	if (v22.DiffuseMagic:IsCastable() and ((v7:HealthPercentageWeighted() <= v54.Windwalker.DiffuseMagicHP) or v85())) then
		if v17(v22.DiffuseMagic) then
			return "fortifying_brew defensives 4";
		end
	end
end
local function v87()
	if (v22.SummonWhiteTigerStatue:IsCastable() and v16()) then
		if v17(v22.SummonWhiteTigerStatue, nil, nil, not v8:IsInRange(325 - (134 + 151))) then
			return "summon_white_tiger_statue precombat 2";
		end
	end
	if (v22.ExpelHarm:IsReady() and (v7:Chi() < v7:ChiMax())) then
		if v17(v22.ExpelHarm, nil, nil, not v8:IsInMeleeRange(1673 - (970 + 695))) then
			return "expel_harm precombat 4";
		end
	end
	if (v22.ChiBurst:IsReady() and not v7:IsMoving() and not v22.JadefireStomp:IsAvailable()) then
		if v17(v22.ChiBurst, nil, nil, not v8:IsInRange(76 - 36)) then
			return "chi_burst precombat 6";
		end
	end
	if v22.ChiWave:IsReady() then
		if v17(v22.ChiWave, nil, nil, not v8:IsInRange(2030 - (582 + 1408))) then
			return "chi_wave precombat 8";
		end
	end
end
local function v88()
	local v137 = v54.Windwalker.Trinket1Usage;
	local v138 = v54.Windwalker.Trinket2Usage;
	if (v16() and v54.Commons.Enabled.Trinkets and v59() and v60() and (((v49:ID() == v23.ManicGrieftorch:ID()) and not v50:HasUseBuff()) or ((v50:ID() == v23.ManicGrieftorch:ID()) and not v49:HasUseBuff()))) then
		if v17(v23.ManicGrieftorch) then
			return "manic_grieftorch Trinkets 2";
		end
	end
	if (v16() and (v39 == (3 - 2))) then
		if v54.Commons.Enabled.Trinkets then
			if (v23.AlgetharPuzzleBox:IsEquippedAndReady() and (v30 or not v22.InvokeXuenTheWhiteTiger:IsAvailable() or (v29 < (31 - 6)))) then
				if v17(v23.AlgetharPuzzleBox) then
					return "algethar_puzzle_box serenity_Trinkets 4";
				end
			end
			if v23.EruptingSpearFragment:IsEquippedAndReady() then
				if v17(v23.EruptingSpearFragment) then
					return "erupting_spear_fragment serenity_Trinkets 6";
				end
			end
			if (v59() and v60() and ((not v49:HasUseBuff() and not v50:HasUseBuff() and not v30) or ((v49:HasUseBuff() or v50:HasUseBuff()) and (v22.InvokeXuenTheWhiteTiger:CooldownRemains() > (113 - 83))) or (v29 < (1829 - (1195 + 629))))) then
				if v17(v23.ManicGrieftorch) then
					return "manic_grieftorch serenity_Trinkets 8";
				end
			end
			if (v23.BeacontotheBeyond:IsEquippedAndReady() and ((not v49:HasUseBuff() and not v50:HasUseBuff() and not v30) or ((v49:HasUseBuff() or v50:HasUseBuff()) and (v22.InvokeXuenTheWhiteTiger:CooldownRemains() > (39 - 9))) or (v29 < (251 - (187 + 54))))) then
				if v17(v23.BeacontotheBeyond) then
					return "beacon_to_the_beyond Trinkets 10";
				end
			end
		end
		if (v54.Commons.Enabled.Items and v23.Djaruun:IsEquippedAndReady() and (((v22.FistsofFury:CooldownRemains() < (782 - (162 + 618))) and (v22.InvokeXuenTheWhiteTiger:CooldownRemains() > (8 + 2))) or (v29 < (8 + 4)))) then
			v14.CastMacro(3 - 1, nil, nil, v23.Djaruun);
			return "Djaruun";
		end
		if v54.Commons.Enabled.Trinkets then
			if (v23.DragonfireBombDispenser:IsEquippedAndReady() and ((not v49:HasUseBuff() and not v50:HasUseBuff()) or ((v49:HasUseBuff() or v50:HasUseBuff()) and (v22.InvokeXuenTheWhiteTiger:CooldownRemains() > (16 - 6))) or (v29 < (1 + 9)))) then
				if v17(v23.DragonfireBombDispenser) then
					return "dragonfire_bomb_dispenser Trinkets 14";
				end
			end
			local v151, v152, v153 = v7:GetUseableItems(v24, 1649 - (1373 + 263));
			local v154, v152, v155 = v7:GetUseableItems(v24, 1014 - (451 + 549));
			if (v151 and v137 and v151:HasUseBuff() and (v30 or not v22.InvokeXuenTheWhiteTiger:IsAvailable() or (v29 < (8 + 17)))) then
				if v17(v151) then
					return "Generic use_items for " .. v151:Name() .. " (serenity_Trinkets stat_buff Trinket1)";
				end
			end
			if (v154 and v138 and v154:HasUseBuff() and (v30 or not v22.InvokeXuenTheWhiteTiger:IsAvailable() or (v29 < (38 - 13)))) then
				if v17(v154) then
					return "Generic use_items for " .. v154:Name() .. " (serenity_Trinkets stat_buff Trinket2)";
				end
			end
			if (v151 and v137 and (not v151:HasUseBuff() or (v151:HasUseBuff() and (v22.InvokeXuenTheWhiteTiger:CooldownRemains() > (50 - 20))))) then
				if v17(v151) then
					return "Generic use_items for " .. v151:Name() .. " (serenity_Trinkets dmg_buff Trinket1)";
				end
			end
			if (v154 and v138 and (not v154:HasUseBuff() or (v154:HasUseBuff() and (v22.InvokeXuenTheWhiteTiger:CooldownRemains() > (1414 - (746 + 638)))))) then
				if v17(v154) then
					return "Generic use_items for " .. v154:Name() .. " (serenity_Trinkets dmg_buff Trinket2)";
				end
			end
		end
	else
		if (v54.Commons.Enabled.Trinkets and v16()) then
			if (v23.AlgetharPuzzleBox:IsEquippedAndReady() and (((v30 or not v22.InvokeXuenTheWhiteTiger:IsAvailable()) and v7:BuffDown(v22.StormEarthAndFireBuff)) or (v29 < (10 + 15)))) then
				if v17(v23.AlgetharPuzzleBox) then
					return "algethar_puzzle_box sef_Trinkets 16";
				end
			end
			if (v23.EruptingSpearFragment:IsEquippedAndReady() and (v7:BuffUp(v22.InvokersDelightBuff))) then
				if v17(v23.EruptingSpearFragment) then
					return "erupting_spear_fragment sef_Trinkets 18";
				end
			end
			if (v59() and v60() and ((not v49:HasUseBuff() and not v50:HasUseBuff() and v7:BuffDown(v22.StormEarthAndFireBuff) and not v30) or ((v49:HasUseBuff() or v50:HasUseBuff()) and (v22.InvokeXuenTheWhiteTiger:CooldownRemains() > (45 - 15))) or (v29 < (346 - (218 + 123))))) then
				if v17(v23.ManicGrieftorch) then
					return "manic_grieftorch sef_Trinkets 20";
				end
			end
			if (v23.BeacontotheBeyond:IsEquippedAndReady() and ((not v49:HasUseBuff() and not v50:HasUseBuff() and v7:BuffDown(v22.StormEarthAndFireBuff) and not v30) or ((v49:HasUseBuff() or v50:HasUseBuff()) and (v22.InvokeXuenTheWhiteTiger:CooldownRemains() > (1611 - (1535 + 46)))) or (v29 < (10 + 0)))) then
				if v17(v23.BeacontotheBeyond) then
					return "beacon_to_the_beyond sef_Trinkets 22";
				end
			end
		end
		if (v54.Commons.Enabled.Items and v23.Djaruun:IsEquippedAndReady() and (((v22.FistsofFury:CooldownRemains() < (1 + 1)) and (v22.InvokeXuenTheWhiteTiger:CooldownRemains() > (570 - (306 + 254)))) or (v29 < (1 + 11)))) then
			v14.CastMacro(3 - 1, nil, nil, v23.Djaruun);
			return "Djaruun";
		end
		if v54.Commons.Enabled.Trinkets then
			if (v23.DragonfireBombDispenser:IsEquippedAndReady() and ((not v49:HasUseBuff() and not v50:HasUseBuff()) or ((v49:HasUseBuff() or v50:HasUseBuff()) and (v22.InvokeXuenTheWhiteTiger:CooldownRemains() > (1477 - (899 + 568)))) or (v29 < (7 + 3)))) then
				if v17(v23.DragonfireBombDispenser) then
					return "dragonfire_bomb_dispenser sef_Trinkets 26";
				end
			end
			local v156, v157, v158 = v7:GetUseableItems(v24, 31 - 18);
			local v159, v157, v160 = v7:GetUseableItems(v24, 617 - (268 + 335));
			if (v156 and v137 and v156:HasUseBuff() and (((v30 or not v22.InvokeXuenTheWhiteTiger:IsAvailable()) and v7:BuffUp(v22.StormEarthAndFireBuff)) or (v29 < (315 - (60 + 230))))) then
				if v17(v156) then
					return "Generic use_items for " .. v156:Name() .. " (sef_Trinkets stat_buff Trinket1)";
				end
			end
			if (v159 and v138 and v159:HasUseBuff() and (((v30 or not v22.InvokeXuenTheWhiteTiger:IsAvailable()) and v7:BuffUp(v22.StormEarthAndFireBuff)) or (v29 < (597 - (426 + 146))))) then
				if v17(v159) then
					return "Generic use_items for " .. v159:Name() .. " (sef_Trinkets stat_buff Trinket2)";
				end
			end
			if (v156 and v137 and (not v156:HasUseBuff() or (v156:HasUseBuff() and (v22.InvokeXuenTheWhiteTiger:CooldownRemains() > (4 + 26))))) then
				if v17(v156) then
					return "Generic use_items for " .. v156:Name() .. " (sef_Trinkets dmg_buff Trinket1)";
				end
			end
			if (v159 and v138 and (not v159:HasUseBuff() or (v159:HasUseBuff() and (v22.InvokeXuenTheWhiteTiger:CooldownRemains() > (1486 - (282 + 1174)))))) then
				if v17(v159) then
					return "Generic use_items for " .. v159:Name() .. " (sef_Trinkets dmg_buff Trinket2)";
				end
			end
		end
	end
end
local function v89()
	local v139 = 811 - (569 + 242);
	if v7:BuffUp(v22.InvokersDelightBuff) then
		v139 = v139 + (2 - 1);
	end
	if v7:BloodlustUp() then
		v139 = v139 + 1 + 0;
	end
	if v7:PowerInfusionUp() then
		v139 = v139 + (1025 - (706 + 318));
	end
	return v139 >= (1253 - (721 + 530));
end
local function v90()
	return v7:BuffUp(v22.KicksofFlowingMomentumBuff) or v7:BuffUp(v22.FistsofFlowingMomentumBuff);
end
local function v91(v140)
	return (v140 ~= "Not Used") and (((v140 == "With Cooldowns") and v14.CDsON()) or ((v140 == "With Small or Cooldowns") and (v47 or v14.CDsON())) or ((v140 == "With Small CDs") and v47) or ((v140 == "On Mobcount") and (v27 >= v54.Cooldowns.Mobcount)) or ((v140 == "On Mobcount or Cooldowns") and ((v27 >= v54.Cooldowns.Mobcount) or v14.CDsON())) or (v140 == "Always") or ((v140 == "On Bosses") and v45) or ((v140 == "Mobcount or Boss") and (v45 or (v27 >= v54.Cooldowns.Mobcount))));
end
local v92, v93, v94, v95, v96;
local function v97()
	if v8:IsInMeleeRange(1276 - (945 + 326)) then
		if (v22.InvokeXuenTheWhiteTiger:IsReady() and v91(v54.Cooldowns.InvokeXuen) and v55(v54.Cooldowns.InvokeXuenTTD)) then
			v17(v22.InvokeXuenTheWhiteTiger);
			return "Xuen";
		end
		if (v22.StormEarthAndFire:IsReady() and v91(v54.Cooldowns.SEF) and v55(v54.Cooldowns.SEFTTD)) then
			v17(v22.StormEarthAndFire);
			return "SEF";
		end
		if (v91(v54.Cooldowns.Racials) and v55(v54.Cooldowns.RacialsTTD)) then
			if v22.AncestralCall:IsCastable() then
				if v17(v22.AncestralCall) then
					return "ancestral_call";
				end
			end
			if v22.BloodFury:IsCastable() then
				if v17(v22.BloodFury) then
					return "blood_fury ";
				end
			end
			if v22.Fireblood:IsCastable() then
				if v17(v22.Fireblood) then
					return "fireblood ";
				end
			end
			if v22.Berserking:IsCastable() then
				if v17(v22.Berserking) then
					return "berserking ";
				end
			end
			if v22.BagofTricks:IsCastable() then
				if v17(v22.BagofTricks) then
					return "bag_of_tricks ";
				end
			end
			if v22.LightsJudgment:IsCastable() then
				if v17(v22.LightsJudgment) then
					return "lights_judgment ";
				end
			end
		end
		if (v27 >= (7 - 4)) then
			if (v22.JadefireStomp:IsReady() and v92 and v22.JadefireHarmony:IsAvailable() and (v8:DebuffDown(v22.JadefireBrand) or (v8:DebuffUp(v22.JadefireBrand) and (v8:DebuffRemains(v22.JadefireBrand) <= (1.5 + 0))))) then
				v17(v22.JadefireStomp);
				return "JadeFire - AoE";
			end
			if (v22.SpinningCraneKick:IsReady() and v93 and v7:BuffUp(v22.DanceofChijiBuff)) then
				v17(v22.SpinningCraneKick);
				return "SCK /w Dance Buff - AoE";
			end
			if (v91(v54.Cooldowns.Conduit) and v55(v54.Cooldowns.ConduitTTD)) then
				if (v22.CelestialConduit:IsReady() and v8:DebuffUp(v22.AcclamationDebuff) and (v8:DebuffStack(v22.AcclamationDebuff) >= (702 - (271 + 429))) and v7:BuffUp(v22.StormEarthAndFireBuff) and not v22.StrikeoftheWindlord:IsReady() and (v22.XuensBond:IsAvailable() or (not v22.XuensBond:IsAvailable() and v7:BuffUp(v22.InvokersDelightBuff)))) then
					v17(v22.CelestialConduit);
					return "Celestial Conduit - AoE";
				end
			end
			if (v94 and v22.RisingSunKick:IsReady() and v22.FistsofFury:CooldownDown() and v22.WhirlingDragonPunch:IsAvailable() and (v7:Chi() > (1 + 0))) then
				v17(v22.RisingSunKick);
				return "RSK - AoE";
			end
			if v22.WhirlingDragonPunch:IsReady() then
				v17(v22.WhirlingDragonPunch);
				return "WDP - AoE";
			end
			if (v95 and v22.BlackoutKick:IsReady() and v7:BuffUp(v22.BlackoutKickBuff) and (v7:Chi() < (1502 - (1408 + 92)))) then
				v17(v22.BlackoutKick);
				return "BLK - Teachings - AoE";
			end
			if (v91(v54.Cooldowns.Strike) and v55(v54.Cooldowns.StrikeTTD)) then
				if v22.StrikeoftheWindlord:IsReady() then
					v17(v22.StrikeoftheWindlord);
					return "Strike - AoE";
				end
			end
			if ((v7:BuffStack(v22.TeachingsoftheMonasteryBuff) >= (1088 - (461 + 625))) and v95 and v22.BlackoutKick:IsReady() and (v7:Chi() > (1288 - (993 + 295)))) then
				v17(v22.BlackoutKick);
				return "BLK - Teachings - AoE";
			end
			if (v22.CracklingJadeLightning:IsReady() and not v7:IsMoving() and v22.LastEmperorsCapacitor:IsAvailable() and v22.PoweroftheThunderKing:IsAvailable() and v7:BuffUp(v22.TheEmperorsCapacitorTalentBuff) and (v7:BuffStack(v22.TheEmperorsCapacitorTalentBuff) >= (1 + 17))) then
				v17(v22.CracklingJadeLightning);
				return "CJL - AoE";
			end
			if (v22.FistsofFury:IsReady() and (v7:Chi() > (1173 - (418 + 753)))) then
				v17(v22.FistsofFury);
				return "FoF - AoE";
			end
			if (v22.RisingSunKick:IsReady() and (v7:Chi() > (1 + 0)) and v94 and v7:BuffUp(v22.PressurePointBuff)) then
				v17(v22.RisingSunKick);
				return "RSK - AoE";
			end
			if (v22.SpinningCraneKick:IsReady() and v93 and (v7:Chi() > (1 + 0))) then
				v17(v22.SpinningCraneKick);
				return "SCK - AoE";
			end
			if (v95 and v22.BlackoutKick:IsReady() and (v7:Chi() > (0 + 0))) then
				v17(v22.BlackoutKick);
				return "BLK  - AoE";
			end
			if (v22.JadefireStomp:IsReady() and v92) then
				v17(v22.JadefireStomp);
				return "Jadefire Low Prior - - AoE";
			end
			if (v22.SpinningCraneKick:IsReady() and v93 and (v7:Chi() > (1 + 0))) then
				v17(v22.SpinningCraneKick);
				return "SCK - AoE - Low Priority";
			end
			if (v22.ChiBurst:IsReady() and not v7:IsMoving()) then
				v17(v22.ChiBurst);
				return "Chi Burst - AoE";
			end
			if (v22.TigerPalm:IsReady() and v96 and (v7:Energy() >= (579 - (406 + 123))) and (v7:Chi() < (1774 - (1749 + 20)))) then
				v17(v22.TigerPalm);
				return "TP Fall back - AoE";
			end
		end
		if (v27 < (1 + 2)) then
			if (v22.ExpelHarm:IsReady() and not v22.CombatWisdom:IsAvailable() and (v7:Energy() >= (1412 - (1249 + 73))) and (v7:Chi() < (3 + 3))) then
				v17(v22.ExpelHarm);
				return "Expel Harm - Fallback - ST";
			end
			if (v22.TigerPalm:IsReady() and v96 and (v7:Energy() >= (1195 - (466 + 679))) and (v7:Chi() < (11 - 6))) then
				v17(v22.TigerPalm);
				return "TP Fall Back - - ST";
			end
			if (v91(v54.Cooldowns.Conduit) and v55(v54.Cooldowns.ConduitTTD)) then
				if (v22.CelestialConduit:IsReady() and v7:BuffUp(v22.StormEarthAndFireBuff) and (not v22.OrderedElementsTalent:IsAvailable() or v7:BuffUp(v22.OrderedElements)) and not v22.StrikeoftheWindlord:IsReady() and (v22.XuensBond:IsAvailable() or (not v22.XuensBond:IsAvailable() and v7:BuffUp(v22.InvokersDelightBuff)))) then
					v17(v22.CelestialConduit);
					return "Celestial Conduit - AoE";
				end
			end
			if (v22.JadefireStomp:IsReady() and v92 and v22.JadefireHarmony:IsAvailable() and (v8:DebuffDown(v22.JadefireBrand) or (v8:DebuffUp(v22.JadefireBrand) and (v8:DebuffRemains(v22.JadefireBrand) <= (2.5 - 1))))) then
				v17(v22.JadefireStomp);
				return "Jadefire - ST";
			end
			if v22.WhirlingDragonPunch:IsReady() then
				v17(v22.WhirlingDragonPunch);
				return "WDP - ST";
			end
			if (v91(v54.Cooldowns.Strike) and v55(v54.Cooldowns.StrikeTTD)) then
				if v22.StrikeoftheWindlord:IsReady() then
					v17(v22.StrikeoftheWindlord);
					return "Strike - ST";
				end
			end
			if (v22.RisingSunKick:IsReady() and (v7:Chi() > (1901 - (106 + 1794))) and v94) then
				v17(v22.RisingSunKick);
				return "RSK - ST";
			end
			if (v22.FistsofFury:IsReady() and (v7:Chi() > (1 + 1))) then
				v17(v22.FistsofFury);
				return " FOF - ST";
			end
			if ((v7:BuffStack(v22.TeachingsoftheMonasteryBuff) >= (1 + 1)) and (v7:Chi() > (0 - 0)) and v95 and v22.BlackoutKick:IsReady()) then
				v17(v22.BlackoutKick);
				return "BLK -Teachings - ST";
			end
			if v22.SingularlyFocused:IsAvailable() then
				if (v22.JadefireStomp:IsReady() and v92) then
					v17(v22.JadefireStomp);
					return "Jade Fire w/ ST Talent - ST";
				end
			end
			if (v22.SpinningCraneKick:IsReady() and v93 and v7:BuffUp(v22.DanceofChijiBuff)) then
				v17(v22.SpinningCraneKick);
				return "SCK /w Dance Buff - ST";
			end
			if v22.ChiWave:IsReady() then
				v17(v22.ChiWave);
				return "Chi Wave - ST";
			end
			if (v22.ChiBurst:IsReady() and not v7:IsMoving()) then
				v17(v22.ChiBurst);
				return "Chi Burst";
			end
			if ((v7:Chi() > (0 - 0)) and v95 and v22.BlackoutKick:IsReady()) then
				v17(v22.BlackoutKick);
				return "BLK -Teachings - ST";
			end
			if (v22.CracklingJadeLightning:IsReady() and not v7:IsMoving() and v22.LastEmperorsCapacitor:IsAvailable() and v7:BuffUp(v22.TheEmperorsCapacitorTalentBuff) and (v7:BuffStack(v22.TheEmperorsCapacitorTalentBuff) >= (132 - (4 + 110)))) then
				v17(v22.CracklingJadeLightning);
				return "CJL - ST";
			end
			if (v22.JadefireStomp:IsReady() and v92) then
				v17(v22.JadefireStomp);
				return "Jade Fire Low Prior - ST";
			end
		end
	end
end
local v98, v99, v100, v101, v102, v103, v104;
local v105, v106, v107;
local function v108()
	v46 = v51.UnitsinRange(v22.Vivify);
	v25 = v7:GetEnemiesInMeleeRange(589 - (57 + 527));
	v26 = v7:GetEnemiesInMeleeRange(1435 - (41 + 1386));
	v98 = #(v7:GetEnemiesInMeleeRange(108 - (17 + 86)));
	v100 = v14.ToggleIconFrame:GetToggle(1 + 0);
	v99 = v14.ToggleIconFrame:GetToggle(3 - 1);
	v103 = v14.ToggleIconFrame:GetToggle(8 - 5);
	v101 = v8:IsInMeleeRange(171 - (122 + 44));
	v107 = v11:IsInMeleeRange(8 - 3);
	v96 = v62() ~= (3 - 2);
	v95 = v62() ~= (6 + 1);
	v94 = v62() ~= (1 + 3);
	v93 = v62() ~= (3 - 1);
	v92 = v62() ~= (77 - (30 + 35));
	v104 = v62() ~= (9 + 4);
	v47 = v14.ToggleIconFrame:GetToggle(1261 - (1043 + 214));
	if v15() then
		v27 = #v26;
	else
		v27 = 3 - 2;
	end
	v106 = (v25 and #v25) or (1213 - (323 + 889));
	v102 = v63() < v106;
	if (v51.TargetIsValid() or v7:AffectingCombat()) then
		v45 = true;
		v28 = v3.BossFightRemains();
		v29 = v28;
		if (v29 == (29906 - 18795)) then
			v45 = false;
			v29 = v3.FightRemains(v26, false);
		end
	end
	if (v51.TargetIsValid() or v7:AffectingCombat()) then
		v30 = v22.InvokeXuenTheWhiteTiger:TimeSinceLastCast() <= (604 - (361 + 219));
	end
	if (v51.TargetIsValid() and (v54.Windwalker.OutofCombat or v7:AffectingCombat())) then
		if v103 then
			if (v22.TouchofDeath:IsReady() and v104 and v51.TargetIsValid() and v101 and ((v8:Health() < v7:Health()) or (v22.ImpTouchofDeath:IsAvailable() and (v8:HealthPercentage() < (335 - (53 + 267)))))) then
				v17(v22.TouchofDeath);
				return;
			end
		end
		if v7:AffectingCombat() then
			v31 = v86();
			if v31 then
				return v31;
			end
			if (v100 and not v7:IsInRaid() and v22.Detox:IsReady()) then
				v31 = v51.DispelCycle(v22.Detox, "Disease", nil, v46);
				if v31 then
					return v31;
				end
				v31 = v51.DispelCycle(v22.Detox, "Poison", nil, v46);
				if v31 then
					return v31;
				end
				v31 = v51.AfflictedLogic(v22.Detox);
				if v31 then
					return v31;
				end
			end
			if v99 then
				if v22.SpearHandStrike:IsReady() then
					v31 = v51.InterruptCycle(v22.SpearHandStrike, 2 + 3, true, nil, false);
					if v31 then
						return v31;
					end
				end
				if v22.LegSweep:IsReady() then
					v31 = v51.InterruptCycle(v22.LegSweep, 421 - (15 + 398), false, nil, true, true);
					if v31 then
						return v31;
					end
				end
				if v54.Windwalker.LegSweepInt then
					if (v22.SpearHandStrike:CooldownDown() and v22.LegSweep:IsReady()) then
						v31 = v51.InterruptCycle(v22.LegSweep, 990 - (18 + 964), false, nil, false, true);
						if v31 then
							return v31;
						end
					end
				end
				if v54.Windwalker.ParaInt then
					if (v22.SpearHandStrike:CooldownDown() and v22.Paralysis:IsReady()) then
						v31 = v51.InterruptCycle(v22.Paralysis, 75 - 55, false, nil, false);
						if v31 then
							return v31;
						end
					end
				end
			end
			if v22.Paralysis:IsReady() then
				v31 = v51.IncorpCycle(v22.Paralysis, 12 + 8, false, false);
				if v31 then
					return v31;
				end
			end
		end
		if (v54.Windwalker.AutoTabMelee and (v98 > (0 + 0)) and not v101 and v7:CanAttack(v8)) then
			v14.TopPanelAlternative:ChangeIcon(851 - (20 + 830), 3 + 0);
			return "Auto tab to melee";
		end
		if ((v7:Level() >= (159 - (116 + 10))) and v102 and ((v8:DebuffDown(v22.MarkoftheCraneDebuff) and v101) or (v11:IsInRange(1 + 4) and v7:CanAttack(v11) and v11:DebuffDown(v22.MarkoftheCraneDebuff)))) then
			if (v22.RisingSunKick:IsReady() and v94 and (v7:Chi() > (739 - (542 + 196)))) then
				v51.CastTargetIf(v22.RisingSunKick, v25, "min", v70, nil, 10 - 5, nil, nil, v54.Windwalker.AutoTabMoTC, false);
				return "RSK - MoTC";
			end
			if (v22.BlackoutKick:IsReady() and v95 and (v7:Chi() > (1 + 0))) then
				v51.CastTargetIf(v22.BlackoutKick, v25, "min", v70, nil, 3 + 2, nil, nil, v54.Windwalker.AutoTabMoTC, true);
				return "BLK - MoTC ";
			end
			if (v22.TigerPalm:IsReady() and v96 and (v7:Energy() >= (18 + 32))) then
				v51.CastTargetIf(v22.TigerPalm, v25, "min", v70, nil, 12 - 7, nil, nil, v54.Windwalker.AutoTabMoTC, true);
				return "TP - MoTC";
			end
		end
		if (v22.Vivify:IsReady() and (v7:HealthPercentage() <= v54.Windwalker.VivVivHP) and v7:BuffUp(v22.VivaciousVivification)) then
			v7:Cast(v22.Vivify);
			return "Vivify With Buff on Self";
		end
		if (v54.Commons.Enabled.Potions and v16()) then
			local v161 = v51.PotionSelected();
			if (v161 and v161:IsReady()) then
				if v22.InvokeXuenTheWhiteTiger:IsAvailable() then
					if ((v7:BuffUp(v22.StormEarthAndFireBuff) and v30) or (v29 <= (76 - 46))) then
						v14.CastMacro(1554 - (1126 + 425), nil, nil, v161);
						return "potion with xuen main 4";
					end
				elseif (v7:BuffUp(v22.StormEarthAndFireBuff) or (v29 <= (435 - (118 + 287)))) then
					v14.CastMacro(11 - 8, nil, nil, v161);
					return "potion without xuen main 6";
				end
			end
		end
		if (v54.Commons.Enabled.Trinkets and v16()) then
			v31 = v88();
			if v31 then
				return v31;
			end
		end
		v31 = v97();
		if v31 then
			return v31;
		end
	end
end
local function v109()
	v14.ResetToggle();
	v54.Windwalker.Display();
	v14.ToggleIconFrame:AddButtonCustom("D", 1122 - (118 + 1003), "Dispel", "dispel");
	v14.ToggleIconFrame:AddButtonCustom("K", 5 - 3, "Kick", "kick");
	v14.ToggleIconFrame:AddButtonCustom("T", 380 - (142 + 235), "Touch of Death", "touchofdeath");
	v14.ToggleIconFrame:AddButtonCustom("S", 18 - 14, "Small CDs", "smallcds");
	v14:UpdateMacro("macro1", "/stopcasting");
	v14:UpdateMacro("macro2", "/use 16");
	v14.Print("Windwalker Monk rotation has been updated for TWW Season 1");
end
v14.SetAPL(59 + 210, v108, v109);
