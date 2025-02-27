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
local v13 = v3.Utils.IntToBool;
local v14 = v3.Utils.ValueIsInArray;
local v15 = HeroRotation();
local v16 = v15.AoEON;
local v17 = v15.CDsON;
local v18 = v15.Cast;
local v19 = v15.CastPooling;
local v20 = v15.CastQueue;
local v21 = v15.CastLeftNameplate;
local v22 = v15.Commons().Everyone.num;
local v23 = v15.Commons().Everyone.bool;
local v24 = pairs;
local v25 = math.floor;
local v26 = math.max;
local v27 = math.min;
local v28 = C_Timer.After;
local v29 = v15.Commons().Everyone;
local v30 = v15.Commons().Rogue;
local v31 = v15.GUISettingsGet();
local v32 = {General=v31.General,Commons=v31.APL.Rogue.Commons,Assassination=v31.APL.Rogue.Assassination,Interrupt=v31.APL.Rogue.Assassination_Interrupt};
local v33 = v9.Rogue.Assassination;
local v34 = v11.Rogue.Assassination;
local v35 = {v34.AlgetharPuzzleBox:ID(),v34.AshesoftheEmbersoul:ID(),v34.ImperfectAscendancySerum:ID(),v34.TreacherousTransmitter:ID()};
local v36, v37, v38, v39;
local v40, v41, v42, v43;
local v44;
local v45, v46 = (621 - (555 + 64)) * v6:SpellHaste(), (932 - (857 + 74)) * v6:SpellHaste();
local v47, v48;
local v49, v50, v51, v52, v53, v54, v55;
local v56;
local v57, v58, v59, v60, v61, v62, v63, v64;
local v65 = 568 - (367 + 201);
local v66;
local v67, v68;
local v69 = 927 - (214 + 713);
local function v70()
	local v101, v102 = v6:GetTrinketData(OnUseExcludes);
	if ((v69 < (2 + 3)) and ((v101.ID == (0 + 0)) or (v102.ID == (877 - (282 + 595))) or ((v101.SpellID > (1637 - (1523 + 114))) and not v101.Usable) or ((v102.SpellID > (0 + 0)) and not v102.Usable))) then
		v69 = v69 + (1 - 0);
		v28(1070 - (68 + 997), function()
			v70();
		end);
		return;
	end
	TrinketItem1 = v101.Object;
	TrinketItem2 = v102.Object;
	if ((TrinketItem1:HasStatAnyDps() and (not TrinketItem2:HasStatAnyDps() or (v101.Cooldown >= v102.Cooldown)) and (v102.ID ~= v34.TreacherousTransmitter:ID())) or (v101.ID == v34.TreacherousTransmitter:ID())) then
		v65 = 1271 - (226 + 1044);
	elseif ((TrinketItem2:HasStatAnyDps() and (not TrinketItem1:HasStatAnyDps() or (v102.Cooldown > v101.Cooldown)) and (v101.ID ~= v34.TreacherousTransmitter:ID())) or (v102.ID == v34.TreacherousTransmitter:ID())) then
		v65 = 8 - 6;
	else
		v65 = 117 - (32 + 85);
	end
end
v70();
local function v71(v105)
	if v105:IsEquippedAndReady() then
		return ((TrinketItem1:ID() == v105:ID()) and v32.Commons.Enabled.Trinket1) or ((TrinketItem2:ID() == v105:ID()) and v32.Commons.Enabled.Trinket2);
	end
end
v3:RegisterForEvent(function()
	v69 = 0 + 0;
	v70();
end, "PLAYER_EQUIPMENT_CHANGED");
v3:RegisterForEvent(function()
	if v33.FateboundInevitability:IsAvailable() then
		v33.ColdBlood = v9(101194 + 355136);
	else
		v33.ColdBlood = v9(383202 - (892 + 65));
	end
end, "SPELLS_CHANGED", "LEARNED_SPELL_IN_TAB", "PLAYER_LOGIN", "PLAYER_TALENT_UPDATE", "PLAYER_SPECIALIZATION_CHANGED");
local v72 = {{v33.Blind,"Cast Blind (Interrupt)",function()
	return true;
end},{v33.KidneyShot,"Cast Kidney Shot (Interrupt)",function()
	return v47 > (0 - 0);
end}};
local function v73()
	return v6:IsInRaidArea() or v6:IsInDungeonArea() or v7:IsDummy() or (not v6:IsTanking(v7) and v32.Commons.UseSoloVanish);
end
local function v74()
	return ((v15.ToggleIconFrame:GetToggle(956 - (802 + 150)) or v15.CDsON()) and v30.TTDCheck(v32.Assassination.TimeToDie.Cooldowns, v32.Commons.Enabled.IgnoreTtdOnBoss and v68, v7:TimeToDie())) or v7:DebuffUp(v33.Kingsbane);
end
v33.Envenom:RegisterDamageFormula(function()
	return v6:AttackPowerDamageMod() * v47 * (0.22 - 0) * (1 - 0) * ((v7:DebuffUp(v33.ShivDebuff) and (1.3 + 0)) or (998 - (915 + 82))) * ((v33.DeeperStratagem:IsAvailable() and (2.05 - 1)) or (1 + 0)) * ((1 - 0) + (v6:MasteryPct() / (1287 - (1069 + 118)))) * ((2 - 1) + (v6:VersatilityDmgPct() / (218 - 118)));
end);
v33.Mutilate:RegisterDamageFormula(function()
	return (v6:AttackPowerDamageMod() + v6:AttackPowerDamageMod(true)) * (0.485 + 0) * (1 - 0) * (1 + 0 + (v6:VersatilityDmgPct() / (891 - (368 + 423))));
end);
local function v75()
	return v6:BuffRemains(v33.MasterAssassinBuff) == (31423 - 21424);
end
local function v76()
	if v75() then
		return v6:GCDRemains() + (21 - (10 + 8));
	end
	return v6:BuffRemains(v33.MasterAssassinBuff);
end
local function v77()
	if v6:BuffUp(v33.ImprovedGarroteAura) then
		return v6:GCDRemains() + (11 - 8);
	end
	return v6:BuffRemains(v33.ImprovedGarroteBuff);
end
local function v78()
	if v6:BuffUp(v33.IndiscriminateCarnageAura) then
		return v6:GCDRemains() + (452 - (416 + 26));
	end
	return v6:BuffRemains(v33.IndiscriminateCarnageBuff);
end
local function v79()
	if (v42 < (6 - 4)) then
		return false;
	elseif ((v32.Assassination.UsePriorityRotation == "On Bosses") and v7:IsInBossList()) then
		return true;
	end
	return v15.ToggleIconFrame:GetToggle(1 + 1);
end
local function v80()
	if (v7:DebuffUp(v33.Deathmark) or v7:DebuffUp(v33.Kingsbane) or v7:DebuffUp(v33.ShivDebuff) or (v6:BuffUp(v33.Envenom) and (v6:BuffRemains(v33.Envenom) <= (1 - 0))) or (v6:EnergyPercentage() >= (((478 - (145 + 293)) + ((460 - (44 + 386)) * v22(v33.HandOfFate:IsAvailable()))) - ((1501 - (998 + 488)) * v22(v33.ViciousVenoms:IsAvailable())))) or v3.BossFilteredFightRemains("<=", 7 + 13)) then
		return true;
	end
	return false;
end
local function v81()
	if not v33.ScentOfBlood:IsAvailable() then
		return true;
	end
	return v6:BuffStack(v33.ScentOfBloodBuff) >= v27(17 + 3, v33.ScentOfBlood:TalentRank() * (774 - (201 + 571)) * v42);
end
local function v82(v106, v107, v108)
	local v108 = v108 or v107:PandemicThreshold();
	return v106:DebuffRefreshable(v107, v108);
end
local function v83(v109, v110, v111, v112)
	local v113, v114 = nil, v111;
	local v115 = v7:GUID();
	local v116 = v8:Exists() and v8:GUID();
	for v138, v139 in v24(v112) do
		if ((v139:GUID() ~= v115) and v110(v139)) then
			if ((v139:GUID() == v116) and v139:IsInMeleeRange(v36) and ((v139:TimeToDie() > v111) or (v32.Commons.Enabled.IgnoreTtdOnBoss and v68) or v29.Buggedmobs[v7:NPCID()])) then
				if (v139:GUID() == v116) then
				end
				v15.CastTarget(v109, v15.TName().MOUSEOVER);
				return "Cast Mouseover " .. v109:Name();
			end
			if v29.UnitIsCycleValid(v139, v114, -v139:DebuffRemains(v109)) then
				v113, v114 = v139, v139:TimeToDie();
			end
		end
	end
	if v113 then
		v21(v113, v109);
	elseif v32.Commons.RangedMultiDoT then
		v113, v114 = nil, v111;
		for v167, v168 in v24(v41) do
			if ((v168:GUID() ~= v115) and v29.UnitIsCycleValid(v168, v114, -v168:DebuffRemains(v109)) and v110(v168)) then
				v113, v114 = v168, v168:TimeToDie();
			end
		end
		if v113 then
			v21(v113, v109);
		end
	end
end
local function v84(v117, v118, v119)
	local v120 = v118(v7);
	if ((v117 == "first") and (v120 ~= (1138 - (116 + 1022)))) then
		return v7;
	end
	local v121 = v118(v8);
	if ((v117 == "first") and (v121 ~= (0 - 0))) then
		return v8;
	end
	local v122, v123 = nil, 0 + 0;
	local function v124(v140)
		for v143, v144 in v24(v140) do
			local v145 = v118(v144);
			if (not v122 and (v117 == "first")) then
				if (v145 ~= (0 - 0)) then
					v122, v123 = v144, v145;
				end
			elseif (v117 == "min") then
				if (not v122 or (v145 < v123)) then
					v122, v123 = v144, v145;
				end
			elseif (v117 == "max") then
				if (not v122 or (v145 > v123)) then
					v122, v123 = v144, v145;
				end
			end
			if (v122 and (v145 == v123) and (v144:TimeToDie() > v122:TimeToDie())) then
				v122, v123 = v144, v145;
			end
		end
	end
	v124(v41);
	if (v122 and (v123 == v120) and v119(v7)) then
		return v7;
	end
	if (v122 and (v123 == v121) and v119(v8) and v8:IsInMeleeRange(v36)) then
		return v8;
	end
	if (v122 and v119(v122)) then
		return v122;
	end
	return nil;
end
local function v85()
	if v32.Commons.Enabled.Racials then
		if v33.BloodFury:IsCastable() then
			if v18(v33.BloodFury, true) then
				return "Cast Blood Fury";
			end
		end
		if v33.Berserking:IsCastable() then
			if v18(v33.Berserking, true) then
				return "Cast Berserking";
			end
		end
		if v33.Fireblood:IsCastable() then
			if v18(v33.Fireblood, true) then
				return "Cast Fireblood";
			end
		end
		if v33.AncestralCall:IsCastable() then
			if ((not v33.Kingsbane:IsAvailable() and v7:DebuffUp(v33.ShivDebuff)) or (v7:DebuffUp(v33.Kingsbane) and (v7:DebuffRemains(v33.Kingsbane) < (28 - 20)))) then
				if v18(v33.AncestralCall, true) then
					return "Cast Ancestral Call";
				end
			end
		end
	end
	return false;
end
local function v86(v125, v126)
	if ((v33.Ambush:IsReady() or (v126 and v6:BuffDown(v33.DarkestNightBuff))) and v7:DebuffDown(v33.DeathStalkersMarkDebuff) and v33.DeathStalkersMark:IsAvailable() and (v47 < v66) and (v7:DebuffUp(v33.Rupture) or v63 or not v33.Subterfuge:IsAvailable())) then
		if v125 then
			return v33.Ambush;
		elseif v18(v33.Ambush) then
			return "Cast Ambush Stealthed";
		end
	end
	if (v74 and v33.Kingsbane:IsAvailable() and not v126 and v6:BuffUp(v33.Envenom)) then
		if (v33.Shiv:IsReady() and v7:DebuffUp(v33.Kingsbane) and (v7:DebuffRemains(v33.Kingsbane) < (867 - (814 + 45))) and v7:DebuffDown(v33.ShivDebuff) and (v7:DebuffRemains(v33.ShivDebuff) < (2 - 1))) then
			if v125 then
				return v33.Shiv;
			elseif v18(v33.Shiv, true) then
				return "Cast Shiv (Stealth Kingsbane)";
			end
		end
	end
	if ((v47 >= v66) and (v7:DebuffUp(v33.DeathStalkersMarkDebuff) or v6:BuffUp(v33.ColdBlood) or (v6:BuffUp(v33.DarkestNightBuff) and (v47 == (1 + 6))))) then
		if (v7:DebuffUp(v33.Kingsbane) and (v6:BuffRemains(v33.Envenom) <= (2 + 1))) then
			if v125 then
				return v33.Envenom;
			elseif v18(v33.Envenom) then
				return "Cast Envenom (Stealth Kingsbane)";
			end
		end
		if (v63 and v75()) then
			if v125 then
				return v33.Envenom;
			elseif v18(v33.Envenom) then
				return "Cast Envenom (Master Assassin)";
			end
		end
	end
	if (v33.Rupture:IsCastable() or v126) then
		local function v146(v153)
			return v153:DebuffRemains(v33.Rupture);
		end
		local function v147(v154)
			return (v47 >= v66) and (v6:BuffUp(v33.IndiscriminateCarnageBuff) or v126) and v154:DebuffRefreshable(v33.Rupture) and (not v62 or not v64 or v154:DebuffDown(v33.Rupture)) and ((v7:TimeToDie() > (900 - (261 + 624))) or (v32.Commons.Enabled.IgnoreTtdOnBoss and v68) or v29.Buggedmobs[v7:NPCID()]);
		end
		if v15.AoEON() then
			local v163 = v84("min", v146, v147);
			if (v163 and (v163:GUID() ~= v7:GUID())) then
				if (v163:GUID() == v8:GUID()) then
					v15.CastTarget(v33.Rupture, v15.TName().MOUSEOVER);
					return "Cast Mouseover Rupture";
				else
					v21(v163, v33.Rupture);
				end
			end
		end
		if v147(v7) then
			if v125 then
				return v33.Rupture;
			elseif v18(v33.Rupture) then
				return "Cast Rupture (Stealth Indiscriminate Carnage)";
			end
		end
	end
	if ((v33.Garrote:IsCastable() and (v77() > (0 - 0))) or v126) then
		local function v148(v155)
			return v155:DebuffRemains(v33.Garrote);
		end
		local function v149(v156)
			return ((v156:PMultiplier(v33.Garrote) <= (1081 - (1020 + 60))) or (v156:DebuffRemains(v33.Garrote) < (1435 - (630 + 793))) or (((v78() > (0 - 0)) or v126) and (v33.Garrote:AuraActiveCount() < v42))) and not v63 and (v156:FilteredTimeToDie(">", 9 - 7, -v156:DebuffRemains(v33.Garrote)) or v156:TimeToDieIsNotValid()) and (v48 > ((1 + 1) - (v22(v6:BuffUp(v33.DarkestNightBuff)) * (6 - 4)))) and v30.CanDoTUnit(v156, v52);
		end
		if v15.AoEON() then
			local v164 = v84("min", v148, v149);
			if (v164 and (v164:GUID() ~= v7:GUID())) then
				if (v164:GUID() == v8:GUID()) then
					v15.CastTarget(v33.Garrote, v15.TName().MOUSEOVER);
					return "Cast Mouseover Garrote";
				else
					v21(v164, v33.Garrote);
				end
			end
		end
		if v149(v7) then
			if v125 then
				return v33.Garrote;
			elseif v18(v33.Garrote) then
				return "Cast Garrote (Improved Garrote)";
			end
		end
		if ((v48 >= ((1748 - (760 + 987)) + ((1915 - (1789 + 124)) * v22(v33.ShroudedSuffocation:IsAvailable())))) and ((v7:PMultiplier(v33.Garrote) <= (767 - (745 + 21))) or (v7:DebuffRemains(v33.Garrote) < (5 + 7)) or (not v63 and (v76() < (7 - 4))))) then
			if v125 then
				return v33.Garrote;
			elseif v18(v33.Garrote) then
				return "Cast Garrote (Improved Garrote Low CP)";
			end
		end
	end
end
local function v87(v127)
	if not v15.ToggleIconFrame:GetToggle(3 - 2) then
		return;
	end
	if (v127:ID() == v33.Vanish:ID()) then
		if v18(v33.Vanish, true) then
			return "Cast Vanish";
		end
		return false;
	elseif (v127:ID() == v33.Shadowmeld:ID()) then
		if v18(v33.Shadowmeld, true) then
			return "Cast Shadowmeld";
		end
		return false;
	end
	local v128 = v86(true, true);
	local v129 = {v127,v128};
	v44 = v20(unpack(v129));
	if v44 then
		return "| " .. v129[1057 - (87 + 968)]:Name();
	end
	return false;
end
local function v88()
	if (v32.Commons.ShowPooling and (v6:EnergyPredicted() < (198 - 153))) then
		if v18(v33.PoolEnergy) then
			return "Pool for Vanish";
		end
	end
	if (v33.Vanish:IsCastable() and v6:BuffDown(v33.FateboundLuckyCoin) and (v47 >= v66) and ((v6:BuffStack(v33.FateboundCoinTails) >= (5 + 0)) or (v6:BuffStack(v33.FateboundCoinHeads) >= (11 - 6)))) then
		if v73() then
			v44 = v87(v33.Vanish);
			if v44 then
				return "Cast Vanish (Fateful Ending Fish)" .. v44;
			end
		end
	end
	if (v33.Vanish:IsCastable() and not v33.MasterAssassin:IsAvailable() and not v33.IndiscriminateCarnage:IsAvailable() and v33.ImprovedGarrote:IsAvailable() and v33.Garrote:CooldownUp() and ((v7:PMultiplier(v33.Garrote) <= (1414 - (447 + 966))) or v82(v7, v33.Garrote)) and (v7:DebuffUp(v33.Deathmark) or (v33.Deathmark:CooldownRemains() < (10 - 6))) and (v48 >= v27(v42, 1821 - (1703 + 114)))) then
		if v73() then
			v44 = v87(v33.Vanish);
			if v44 then
				return "Cast Vanish Garrote Deathmark (No Carnage)" .. v44;
			end
		end
	end
	if (v32.Commons.ShowPooling and (v6:EnergyPredicted() < (746 - (376 + 325))) and v73()) then
		if v18(v33.PoolEnergy) then
			return "Pool for Vanish";
		end
	end
	if (v33.Vanish:IsCastable() and v33.IndiscriminateCarnage:IsAvailable() and v33.ImprovedGarrote:IsAvailable() and v33.Garrote:CooldownUp() and ((v7:PMultiplier(v33.Garrote) <= (1 - 0)) or v82(v7, v33.Garrote)) and (v42 > (5 - 3))) then
		if v73() then
			v44 = v87(v33.Vanish);
			if v44 then
				return "Cast Vanish (Garrote Carnage)" .. v44;
			end
		end
	end
	if (v33.Vanish:IsCastable() and v33.MasterAssassin:IsAvailable() and not v82(v7, v33.Rupture) and (v7:DebuffRemains(v33.Garrote) > (1 + 2)) and v7:DebuffUp(v33.Deathmark) and (v7:DebuffRemains(v33.Kingsbane) <= ((12 - 6) + ((17 - (9 + 5)) * v33.Subterfuge:TalentRank())))) then
		if v73() then
			v44 = v87(v33.Vanish);
			if v44 then
				return "Cast Vanish (Master Assassin)" .. v44;
			end
		end
	end
	if (v33.Vanish:IsCastable() and v33.ImprovedGarrote:IsAvailable() and v33.Garrote:CooldownUp() and ((v7:PMultiplier(v33.Garrote) <= (377 - (85 + 291))) or v82(v7, v33.Garrote)) and (v7:DebuffUp(v33.Deathmark) or (v33.Deathmark:CooldownRemains() < (1269 - (243 + 1022))))) then
		if v73() then
			v44 = v87(v33.Vanish);
			if v44 then
				return "Cast Vanish (Improved Garrote during Deathmark)" .. v44;
			end
		end
	end
end
local function v89()
	if not (v32.Commons.Enabled.Trinket1 or v32.Commons.Enabled.Trinket2) then
		return;
	end
	if v71(v34.AshesoftheEmbersoul) then
		if ((v7:DebuffUp(v33.Kingsbane) and (v7:DebuffRemains(v33.Kingsbane) <= (41 - 30))) or v3.BossFilteredFightRemains("<", 19 + 3)) then
			if v18(v34.AshesoftheEmbersoul) then
				return "Ashes of the Embersoul";
			end
		end
	end
	if v71(v34.AlgetharPuzzleBox) then
		if ((v7:DebuffUp(v33.Rupture) and (v33.Deathmark:CooldownRemains() <= (1182 - (1123 + 57)))) or v3.BossFilteredFightRemains("<", 18 + 4)) then
			if v18(v34.AlgetharPuzzleBox) then
				return "Algethar Puzzle Box";
			end
		end
	end
	if v71(v34.TreacherousTransmitter) then
		if ((v7:DebuffUp(v33.Rupture) and (v33.Deathmark:CooldownRemains() <= (256 - (163 + 91)))) or v7:DebuffUp(v33.Deathmark) or v3.BossFilteredFightRemains("<", 1952 - (1869 + 61))) then
			if v18(v34.TreacherousTransmitter) then
				return "Treacherous Transmitter";
			end
		end
	end
	if v71(v34.MadQueensMandate) then
		if (((v33.Deathmark:CooldownRemains() >= (9 + 21)) and v7:DebuffDown(v33.Deathmark)) or v3.BossFilteredFightRemains("<=", 10 - 7)) then
			if v18(v34.MadQueensMandate) then
				return "Mad Queen's Mandate";
			end
		end
	end
	if v71(v34.ImperfectAscendancySerum) then
		if ((v7:DebuffUp(v33.Rupture) and (v33.Deathmark:CooldownRemains() <= (2 - 0))) or v7:DebuffUp(v33.Deathmark) or v3.BossFilteredFightRemains("<", 4 + 18)) then
			if v18(v34.ImperfectAscendancySerum) then
				return "Imperfect Ascendancy Serum";
			end
		end
	end
	if (TrinketItem1:IsReady() and v32.Commons.Enabled.Trinket1) then
		if (not v6:IsItemBlacklisted(TrinketItem1) and not v14(v35, TrinketItem1:ID()) and (((v65 == (1 - 0)) and (v33.Deathmark:AnyDebuffUp() or v3.BossFilteredFightRemains("<", 19 + 1))) or ((v65 == (1476 - (1329 + 145))) and ((not TrinketItem2:IsReady() and v7:DebuffUp(v33.Kingsbane)) or (not v33.Deathmark:AnyDebuffUp() and (v33.Deathmark:CooldownRemains() > (991 - (140 + 831))) and v7:DebuffUp(v33.Kingsbane)))) or (v65 == (1850 - (1409 + 441))))) then
			if v18(TrinketItem1) then
				return "Trinket 1";
			end
		end
	end
	if (TrinketItem2:IsReady() and v32.Commons.Enabled.Trinket2) then
		if (not v6:IsItemBlacklisted(TrinketItem2) and not v14(v35, TrinketItem2:ID()) and (((v65 == (720 - (15 + 703))) and (v33.Deathmark:AnyDebuffUp() or not v33.Deathmark:IsAvailable() or v3.BossFilteredFightRemains("<", 10 + 10))) or ((v65 == (439 - (262 + 176))) and (not TrinketItem1:IsReady() or (not v33.Deathmark:AnyDebuffUp() and (v33.Deathmark:CooldownRemains() > (1741 - (345 + 1376)))))) or (v65 == (688 - (198 + 490))))) then
			if v18(TrinketItem2) then
				return "Trinket 2";
			end
		end
	end
end
local function v90()
	local v130 = v7:DebuffDown(v33.ShivDebuff) and v7:DebuffUp(v33.Garrote) and v7:DebuffUp(v33.Rupture) and (v42 <= (22 - 17));
	local v131 = v33.Kingsbane:IsAvailable() and v6:BuffUp(v33.Envenom) and v130;
	if v33.Shiv:IsReady() then
		if (v33.ArterialPrecision:IsAvailable() and v130 and (v42 >= (9 - 5)) and v33.CrimsonTempest:AnyDebuffUp()) then
			if v18(v33.Shiv, true) then
				return "Cast Shiv (Arterial Precision)";
			end
		end
		if not v33.LightweightShiv:IsAvailable() then
			if (v131 and ((v7:DebuffUp(v33.Kingsbane) and (v7:DebuffRemains(v33.Kingsbane) < (1214 - (696 + 510)))) or (not v7:DebuffUp(v33.Kingsbane) and (v33.Kingsbane:CooldownRemains() >= (41 - 21)))) and (not v33.CrimsonTempest:IsAvailable() or v63 or v7:DebuffUp(v33.CrimsonTempest))) then
				if v18(v33.Shiv, true) then
					return "Cast Shiv (Kingsbane)";
				end
			end
		end
		if (v6:BuffUp(v33.DarkestNightBuff) and (v47 >= v66) and v6:BuffUp(v33.LingeringDarknessBuff)) then
			if v18(v33.Shiv, true) then
				return "Cast Shiv Darkest Night, Lingering Darkness";
			end
		end
		if v33.LightweightShiv:IsAvailable() then
			if (v131 and (v7:DebuffUp(v33.Kingsbane) or (v33.Kingsbane:CooldownRemains() <= (1263 - (1091 + 171))))) then
				if v18(v33.Shiv, true) then
					return "Cast Shiv (Kingsbane Lightweight)";
				end
			end
		end
		if (v33.ArterialPrecision:IsAvailable() and v7:DebuffDown(v33.ShivDebuff) and v7:DebuffUp(v33.Rupture) and v33.Deathmark:AnyDebuffUp()) then
			if v18(v33.Shiv, true) then
				return "Cast Shiv (Arterial Precision Deathmark)";
			end
		end
		if (not v33.Kingsbane:IsAvailable() and not v33.ArterialPrecision:IsAvailable() and v130 and (not v33.CrimsonTempest:IsAvailable() or v63 or v7:DebuffUp(v33.CrimsonTempest))) then
			if v18(v33.Shiv, true) then
				return "Cast Shiv no KB";
			end
		end
		if v3.BossFilteredFightRemains("<=", v33.Shiv:Charges() * (2 + 6)) then
			if v18(v33.Shiv, true) then
				return "Cast Shiv (End Fight)";
			end
		end
	end
end
local function v91()
	if v32.Commons.Enabled.Potions then
		local v150 = v29.PotionSelected();
		if (v150 and v150:IsReady() and (v6:BloodlustUp() or v3.BossFilteredFightRemains("<", 94 - 64) or v33.Deathmark:AnyDebuffUp())) then
			v15.CastMacro(9 - 6, nil, nil, v150);
			return "Cast Potion";
		end
	end
	if v33.Deathmark:AnyDebuffUp() then
		v44 = v85();
		if v44 then
			return v44;
		end
	end
end
local function v92()
	return (v15.CDsON() and v30.TTDCheck(v32.Assassination.TimeToDie.Cooldowns, v32.Commons.Enabled.IgnoreTtdOnBoss and v68, v7:TimeToDie())) or v7:DebuffUp(v33.Deathmark) or v7:DebuffUp(v33.Kingsbane);
end
local function v93()
	if not v39 then
		return;
	end
	local v132 = not v6:StealthUp(true, false) and (v6:BuffRemains(v33.SliceandDice) > (379 - (123 + 251))) and v7:DebuffUp(v33.Rupture) and (v6:BuffUp(v33.Envenom) or (v42 > (4 - 3))) and not v33.Deathmark:AnyDebuffUp() and (not v33.MasterAssassin:IsAvailable() or v7:DebuffUp(v33.Garrote)) and (not v33.Kingsbane:IsAvailable() or (v33.Kingsbane:CooldownRemains() <= (700 - (208 + 490))));
	if (v92() and (v32.Commons.Enabled.Trinket1 or v32.Commons.Enabled.Trinket2)) then
		v44 = v89();
		if v44 then
			return v44;
		end
	end
	if (v92() and v33.Deathmark:IsCastable()) then
		if ((v132 and (v7:TimeToDie() >= (1 + 9))) or v3.BossFilteredFightRemains("<=", 9 + 11)) then
			if v18(v33.Deathmark, true) then
				return "Cast Deathmark";
			end
		end
	end
	v44 = v74() and v90();
	if v44 then
		return v44;
	end
	if (v74() and v33.Kingsbane:IsCastable()) then
		if (((v7:DebuffUp(v33.ShivDebuff) or (v33.Shiv:CooldownRemains() < (842 - (660 + 176)))) and (v6:BuffUp(v33.Envenom) or (v42 > (1 + 0))) and ((v33.Deathmark:CooldownRemains() >= (252 - (14 + 188))) or v7:DebuffUp(v33.Deathmark) or (v132 and v33.Deathmark:IsReady()))) or v3.BossFilteredFightRemains("<=", 690 - (534 + 141))) then
			if v18(v33.Kingsbane, true) then
				return "Cast Kingsbane";
			end
		end
	end
	if ((v33.ThistleTea:IsCastable() and v6:BuffDown(v33.ThistleTea) and v7:DebuffUp(v33.Kingsbane) and (v7:DebuffRemains(v33.Kingsbane) < (4 + 4))) or (v6:BuffDown(v33.ThistleTea) and (v33.ThistleTea:Charges() >= (2 + 0)) and (v7:DebuffRemains(v33.ShivDebuff) > (6 + 0))) or (v6:BuffDown(v33.ThistleTea) and v3.BossFilteredFightRemains("<", v33.ThistleTea:Charges() * (12 - 6)))) then
		if v18(v33.ThistleTea, true) then
			return "Cast Thistle Tea";
		end
	end
	if v92() then
		if v44 then
			v91();
		else
			v44 = v91();
			if v44 then
				return v44;
			end
		end
	end
	if (v92() and not v6:StealthUp(true, true) and (v76() <= (0 - 0))) then
		if v44 then
			v88();
		else
			v44 = v88();
			if v44 then
				return v44;
			end
		end
	end
	if (v74() and v33.ColdBlood:IsReady() and v6:DebuffDown(v33.ColdBlood)) then
		if (v6:BuffDown(v33.EdgeCase) and (v33.Deathmark:CooldownRemains() > (28 - 18)) and v6:BuffDown(v33.DarkestNightBuff) and (v47 >= v66) and (v57 or (v7:DebuffStack(v33.AmplifyingPoisonDebuff) >= (11 + 9)) or not v63) and v6:BuffDown(v30.VanishBuffSpell()) and (not v33.Kingsbane:CooldownUp() or not v63) and (not v33.Deathmark:CooldownUp() or not v17())) then
			if v18(v33.ColdBlood, true) then
				return "Cast Cold Blood";
			end
		end
		return v44;
	end
end
local function v94(v133)
	return v82(v133, v33.Garrote) and (v133:PMultiplier(v33.Garrote) <= (1 + 0));
end
local function v95(v134)
	v53 = (400 - (115 + 281)) + (v12(v33.DashingScoundrel:IsAvailable()) * (11 - 6)) + (v12(v62) * (5 + 1));
	return v82(v134, v33.Rupture, v49) and (v134:PMultiplier(v33.Rupture) <= (2 - 1)) and (v134:FilteredTimeToDie(">", v53, -v134:DebuffRemains(v33.Rupture)) or v134:TimeToDieIsNotValid());
end
local function v96()
	if (v33.Garrote:IsCastable() and (v48 >= (3 - 2))) then
		if (v94(v7) and v30.CanDoTUnit(v7, v52) and (v7:FilteredTimeToDie(">", 879 - (550 + 317), -v7:DebuffRemains(v33.Garrote)) or v7:TimeToDieIsNotValid())) then
			if v19(v33.Garrote) then
				return "Pool for Garrote (ST)";
			end
		end
	end
	if (v33.Rupture:IsReady() and (v47 >= v66) and (v6:BuffDown(v33.DarkestNightBuff) or (v33.CausticSpatter:IsAvailable() and not v7:DebuffUp(v33.CausticSpatterDebuff)))) then
		if (v95(v7) and v30.CanDoTUnit(v7, v51)) then
			if v19(v33.Rupture) then
				return "Cast Rupture";
			end
		end
	end
	if (v33.CrimsonTempest:IsReady() and (v47 >= v66) and v82(v7, v33.CrimsonTempest) and (v7:TimeToDie() > (11 - 3)) and (v6:BuffRemains(v33.MomentumOfDespair) > (8 - 2)) and v63) then
		if v18(v33.CrimsonTempest) then
			return "Crimson Tempest with Momentum of Despair";
		end
	end
end
local function v97()
	local v135 = v47 >= v66;
	if (v15.AoEON() and v33.CrimsonTempest:IsCastable() and (v42 >= (5 - 3)) and v135) then
		for v157, v158 in v24(v41) do
			if (v82(v158, v33.CrimsonTempest, v50) and v158:FilteredTimeToDie(">", 291 - (134 + 151), -v158:DebuffRemains(v33.CrimsonTempest))) then
				if v18(v33.CrimsonTempest) then
					return "Cast Crimson Tempest (AoE High Energy)";
				end
			end
		end
	end
	if (v33.Garrote:IsCastable() and (v48 >= (1666 - (970 + 695)))) then
		if (v94(v7) and not v62 and (v7:FilteredTimeToDie(">", 22 - 10, -v7:DebuffRemains(v33.Garrote)) or v7:TimeToDieIsNotValid())) then
			local v165 = v83(v33.Garrote, v94, 2002 - (582 + 1408), v41);
			if v165 then
				return v165;
			end
		end
	end
	if (v33.Rupture:IsReady() and v15.AoEON() and v135 and (v7:DebuffDown(v33.Kingsbane) or v6:BuffUp(v33.ColdBlood)) and not v62 and ((v33.ScentOfBlood:TalentRank() == (6 - 4)) or ((v33.ScentOfBlood:TalentRank() <= (1 - 0)) and (v6:BuffUp(v33.IndiscriminateCarnageBuff or (v7:TimeToDie() > (56 - 41)) or (v32.Commons.Enabled.IgnoreTtdOnBoss and v68) or v29.Buggedmobs[v7:NPCID()])))) and ((v7:TimeToDie() > ((1831 - (1195 + 629)) + (v12(v33.DashingScoundrel:IsAvailable()) * (6 - 1)) + (v12(v62) * (247 - (187 + 54))))) or (v32.Commons.Enabled.IgnoreTtdOnBoss and v68) or v29.Buggedmobs[v7:NPCID()]) and v6:BuffDown(v33.DarkestNightBuff)) then
		local v151 = v83(v33.Rupture, v95, v53, v41);
		if v151 then
			return v151;
		end
	end
	if (v33.Rupture:IsReady() and v135 and v6:BuffDown(v33.DarkestNightBuff) and v15.AoEON()) then
		v53 = (787 - (162 + 618)) + (v12(v33.DashingScoundrel:IsAvailable()) * (4 + 1)) + (v12(v62) * (4 + 2));
		if ((not v7:DebuffUp(v33.Kingsbane or v6:BuffUp(v33.ColdBlood)) and v62) or not v64) then
			local v166 = v83(v33.Rupture, v95, v53, v43);
			if v166 then
				return v166;
			end
		end
	end
	if (v33.Garrote:IsReady() and (v48 >= (1 - 0)) and (v76() <= (0 - 0)) and ((v7:PMultiplier(v33.Garrote) <= (1 + 0)) or ((v7:DebuffRemains(v33.Garrote) < v45) and (v42 >= (1639 - (1373 + 263))))) and (v7:DebuffRemains(v33.Garrote) < (v45 * (1002 - (451 + 549)))) and (v42 >= (1 + 2)) and (v7:FilteredTimeToDie(">", 5 - 1, -v7:DebuffRemains(v33.Garrote)) or v7:TimeToDieIsNotValid())) then
		if v18(v33.Garrote) then
			return "Garrote (Fallback)";
		end
	end
	return false;
end
local function v98()
	local v136 = ((v47 < v66) and not CDSoon) or v57 or not v63;
	local v137 = v33.CausticSpatter:IsAvailable() and v7:DebuffUp(v33.Rupture) and (not v7:DebuffUp(v33.CausticSpatterDebuff) or (v7:DebuffRemains(v33.CausticSpatterDebuff) <= (2 - 0))) and (v48 >= (1385 - (746 + 638))) and not v63;
	if (v33.Mutilate:IsCastable() and v137) then
		if v19(v33.Mutilate) then
			return "Cast Mutilate (Caustic)";
		end
	end
	if ((v33.Ambush:IsCastable() or v33.AmbushOverride:IsReady()) and v6:StealthUp(true, true) and v137) then
		if v19(v33.Ambush) then
			return "Cast Ambush (Caustic)";
		end
	end
	if (v33.Envenom:IsCastable() and v6:BuffDown(v33.DarkestNightBuff) and (v47 >= v66) and (v57 or (v7:DebuffStack(v33.AmplifyingPoisonDebuff) >= (8 + 12)) or not v63) and v6:BuffDown(v30.VanishBuffSpell())) then
		if v18(v33.Envenom) then
			return "Cast Envenom 1";
		end
	end
	if (v33.Envenom:IsCastable() and v6:BuffUp(v33.DarkestNightBuff) and (v47 >= v30.CPMaxSpend())) then
		if v18(v33.Envenom) then
			return "Cast Envenom 2";
		end
	end
	if ((v33.Ambush:IsCastable() or v33.AmbushOverride:IsReady()) and v136 and (v6:BuffUp(v33.BlindsideBuff) or v6:StealthUp(true, false)) and (v7:DebuffDown(v33.Kingsbane) or v7:DebuffDown(v33.Deathmark) or v6:BuffUp(v33.BlindsideBuff))) then
		if v19(v33.Ambush, nil, not v38) then
			return "Cast Ambush";
		end
	end
	if v33.FanofKnives:IsCastable() then
		if ((v15.AoEON() and v136 and not v56 and (v42 >= ((4 - 1) - v12(v33.MomentumOfDespair and v33.ThrownPrecision)))) or (v6:BuffUp(v33.ClearTheWitnessesBuff) and not v33.ViciousVenoms:IsAvailable())) then
			if v19(v33.FanofKnives) then
				return "Cast Fan of Knives";
			end
		end
	end
	if (v15.AoEON() and v6:BuffUp(v33.DeadlyPoison) and v136 and (v42 >= ((344 - (218 + 123)) - v12(v33.MomentumOfDespair:IsAvailable() and v33.ThrownPrecision:IsAvailable())))) then
		for v159, v160 in v24(v41) do
			if (not v160:DebuffUp(v33.DeadlyPoisonDebuff, true) and (not v56 or v160:DebuffUp(v33.Garrote) or v160:DebuffUp(v33.Rupture))) then
				if v19(v33.FanofKnives) then
					return "Cast Fan of Knives (DP Refresh)";
				end
			end
		end
	end
	if (v33.Mutilate:IsCastable() and v136 and (v42 == (1583 - (1535 + 46))) and v7:DebuffDown(v33.DeadlyPoisonDebuff, true) and v7:DebuffDown(v33.AmplifyingPoisonDebuff, true)) then
		local v152 = v7:GUID();
		if ((v7:DebuffUp(v33.Garrote) or v7:DebuffUp(v33.Rupture)) and not v7:DebuffUp(v33.DeadlyPoisonDebuff, true) and not v7:DebuffUp(v33.AmplifyingPoisonDebuff, true)) then
			v18(v33.Mutilate);
			return "Cast ReapplyDebuff Mutilate";
		end
		for v161, v162 in v24(v41) do
			if ((v162:GUID() ~= v152) and (v162:DebuffUp(v33.Garrote) or v162:DebuffUp(v33.Rupture)) and not v162:DebuffUp(v33.DeadlyPoisonDebuff, true) and not v162:DebuffUp(v33.AmplifyingPoisonDebuff, true)) then
				if ((v162:GUID() == v8:GUID()) and v162:IsInMeleeRange(v36)) then
					v15.CastTarget(v33.Mutilate, v15.TName().MOUSEOVER);
					return "Cast Mouseover Mutilate";
				else
					v21(v162, v33.Mutilate);
				end
				break;
			end
		end
	end
	if (v33.Mutilate:IsCastable() and v136) then
		if v19(v33.Mutilate) then
			return "Cast Mutilate Filler";
		end
	end
	return false;
end
local function v99()
	v29.HealthPotions();
	v36 = 5 + 0;
	v37 = 2 + 8;
	v38 = v7:IsInMeleeRange(v36);
	v39 = v7:IsInMeleeRange(v37);
	v67 = v3.BossFightRemains();
	v68 = true;
	if (v67 == (11671 - (306 + 254))) then
		v68 = false;
		v67 = v3.FightRemains(v40, false);
	end
	if v16() then
		v40 = v6:GetEnemiesInRange(2 + 28);
		v41 = v6:GetEnemiesInMeleeRange(v37);
		v42 = #v41;
		v43 = v6:GetEnemiesInMeleeRange(v36);
	else
		v40 = {};
		v41 = {};
		v42 = 1 - 0;
		v43 = {};
	end
	v45, v46 = (1469 - (899 + 568)) * v6:SpellHaste(), (1 + 0) * v6:SpellHaste();
	v47 = v30.EffectiveComboPoints(v6:ComboPoints());
	v48 = v6:ComboPointsMax() - v47;
	v49 = ((9 - 5) + (v47 * (607 - (268 + 335)))) * (290.3 - (60 + 230));
	v50 = ((576 - (426 + 146)) + (v47 * (1 + 1))) * (1456.3 - (282 + 1174));
	v51 = v33.Envenom:Damage() * v32.Assassination.EnvenomDMGOffset;
	v52 = v33.Mutilate:Damage() * v32.Assassination.MutilateDMGOffset;
	v56 = v79();
	v66 = v26(v6:ComboPointsMax() - (813 - (569 + 242)), (14 - 9) * v22(v33.HandOfFate:IsAvailable()));
	v44 = v30.Defense();
	if v44 then
		return v44;
	end
	v44 = v30.Poisons();
	if v44 then
		return v44;
	end
	v66 = v26(v6:ComboPointsMax() - (1 + 1), (1029 - (706 + 318)) * v22(v33.HandOfFate:IsAvailable()));
	if not v6:AffectingCombat() then
		if not v6:BuffUp(v30.VanishBuffSpell()) then
			v44 = v30.Stealth(v30.StealthSpell());
			if v44 then
				return v44;
			end
		end
		if v30.CombatCheck() then
			if not v6:BuffUp(v33.SliceandDice) then
				if (v33.SliceandDice:IsReady() and (v47 >= (1253 - (721 + 530)))) then
					if v18(v33.SliceandDice) then
						return "Cast Slice and Dice";
					end
				end
			end
		end
	end
	if v30.CombatCheck() then
		if v15.ToggleIconFrame:GetToggle(1274 - (945 + 326)) then
			v44 = v29.InterruptCycle(v33.Kick, v36, true, nil, false);
			if v44 then
				return v44;
			end
			v44 = v32.Interrupt.UseBlind and v29.IncorpCycle(v33.Blind, 37 - 22, true, nil, false);
			if v44 then
				return v44;
			end
			v44 = v32.Interrupt.UseBlind and v29.InterruptCycle(v33.Blind, 14 + 1, true, nil, true);
			if v44 then
				return v44;
			end
			if (v7:DebuffDown(v33.Deathmark) or v7:DebuffDown(v33.Kingsbane)) then
				v44 = v32.Interrupt.UseKidneyShot and (v47 > (700 - (271 + 429))) and v29.InterruptCycle(v33.KidneyShot, v36, true, nil, true);
				if v44 then
					return v44;
				end
				v44 = v32.Interrupt.UseCheapShop and v6:StealthUp(true, true) and v29.InterruptCycle(v33.CheapShot, v36, true, nil, true);
				if v44 then
					return v44;
				end
			end
		end
		v44 = v32.Commons.Enabled.Shiv and v29.SootheCycle(v33.Shiv, 9 + 0, false, v32.Commons.Enabled["Shiv Auto Target"]);
		if v44 then
			return v44;
		end
		v59 = v30.PoisonedBleeds();
		v60 = v6:EnergyRegen() + ((v59 * (1506 - (1408 + 92))) / ((1088 - (461 + 625)) * v6:SpellHaste()));
		v61 = v6:EnergyDeficit() / v60;
		v62 = v60 > (1318 - (993 + 295));
		v57 = v80();
		InCooldowns = v7:DebuffUp(v33.Deathmark) or v7:DebuffUp(v33.Kingsbane) or v7:DebuffUp(v33.Shiv);
		ClipEnvenom = v6:BuffUp(v33.Envenom);
		UpperLimitEnergy = v6:EnergyPercentage() >= ((3 + 47) - ((1181 - (418 + 753)) * v33.ViciousVenoms:TalentRank()));
		AvoidTea = v6:Energy() > (16 + 24 + 6 + 44 + ((2 + 3) * v33.ViciousVenoms:TalentRank()));
		CDSoon = (v33.Kingsbane:CooldownRemains() < (1 + 2)) and not v33.Kingsbane:IsReady();
		v57 = InCooldowns or (not CDSoon and AvoidTea and v6:BuffUp(v33.DarkestNightBuff)) or (not CDSoon and AvoidTea and ClipEnvenom) or UpperLimitEnergy or v3.BossFilteredFightRemains("<=", 549 - (406 + 123));
		v64 = v81();
		v63 = v42 < (1771 - (1749 + 20));
		if v63 then
			if not v7:IsInRange(6 + 19) then
				return;
			end
		elseif (v42 == (1323 - (1249 + 73))) then
			return;
		end
		if (v74() and v33.ThistleTea:IsCastable() and not v6:BuffUp(v33.ThistleTea)) then
			if ((v7:DebuffUp(v33.Kingsbane) and (v7:DebuffRemains(v33.Kingsbane) < (3 + 5))) or (v6:BuffDown(v33.ThistleTea) and (v33.ThistleTea:Charges() >= (1147 - (466 + 679))) and (v7:DebuffRemains(v33.ShivDebuff) > (14 - 8))) or (v6:BuffDown(v33.ThistleTea) and v3.BossFilteredFightRemains("<", v33.ThistleTea:Charges() * (17 - 11)))) then
				if v15.Cast(v33.ThistleTea, true) then
					return "Cast Thistle Tea";
				end
			end
		end
		if (v6:StealthUp(true, false) or (v77() > (1900 - (106 + 1794))) or (v76() > (0 + 0))) then
			v44 = v86();
			if v44 then
				return v44 .. " (Stealthed)";
			end
		end
		if not v6:BuffUp(v33.SliceandDice) then
			if (v33.SliceandDice:IsReady() and v7:DebuffUp(v33.Rupture) and (v6:ComboPoints() >= (1 + 0)) and (v6:BuffDown(v33.IndiscriminateCarnageBuff) or v63)) then
				if v18(v33.SliceandDice) then
					return "Cast Slice and Dice";
				end
			end
		elseif v39 then
			if (v33.Envenom:IsReady() and (v6:BuffRemains(v33.SliceandDice) < (14 - 9)) and (v6:ComboPoints() >= (13 - 8))) then
				if v18(v33.Envenom) then
					return "Cast Envenom (CttC)";
				end
			end
		elseif (v33.PoisonedKnife:IsCastable() and v7:IsInRange(144 - (4 + 110)) and not v6:StealthUp(true, true) and (v42 == (584 - (57 + 527))) and (v6:EnergyTimeToMax() <= (v6:GCD() * (1428.5 - (41 + 1386))))) then
			if v18(v33.PoisonedKnife) then
				return "Cast Poisoned Knife";
			end
		end
		v44 = v93();
		if v44 then
			return v44;
		end
		v44 = v96();
		if v44 then
			return v44;
		end
		if (v15.AoEON() and not v63) then
			v44 = v97();
			if v44 then
				return v44;
			end
		end
		v44 = v98();
		if v44 then
			return v44;
		end
		if (v92() and v32.Commons.Enabled.Racials) then
			if (v33.ArcaneTorrent:IsCastable() and v38 and (v6:EnergyDeficit() >= ((118 - (17 + 86)) + v60))) then
				if v18(v33.ArcaneTorrent, true) then
					return "Cast Arcane Torrent";
				end
			end
			if (v33.ArcanePulse:IsCastable() and v38) then
				if v18(v33.ArcanePulse, true) then
					return "Cast Arcane Pulse";
				end
			end
			if (v33.LightsJudgment:IsCastable() and v38) then
				if v18(v33.LightsJudgment, true) then
					return "Cast Lights Judgment";
				end
			end
			if (v33.BagofTricks:IsCastable() and v38) then
				if v18(v33.BagofTricks, true) then
					return "Cast Bag of Tricks";
				end
			end
		end
		if (v33.Mutilate:IsCastable() or v33.Ambush:IsReady() or v33.AmbushOverride:IsReady()) then
			if v18(v33.PoolEnergy) then
				return "Normal Pooling";
			end
		end
	end
end
local function v100()
	v33.Deathmark:RegisterAuraTracking();
	v33.Sepsis:RegisterAuraTracking();
	v33.Garrote:RegisterAuraTracking();
	v32.Assassination.Display();
	v33.CrimsonTempest:RegisterAuraTracking();
	v29.PostInitialMessage(176 + 83);
end
v15.SetAPL(577 - 318, v99, v100);
