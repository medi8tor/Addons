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
	if ((TrinketItem1:HasStatAnyDps() and (not TrinketItem2:HasStatAnyDps() or (v101.Cooldown >= v102.Cooldown)) and (v102.ID ~= v34.WitherbarksBranch:ID())) or (v101.ID == v34.WitherbarksBranch:ID())) then
		v65 = 1271 - (226 + 1044);
	elseif ((TrinketItem2:HasStatAnyDps() and (not TrinketItem1:HasStatAnyDps() or (v102.Cooldown > v101.Cooldown)) and (v101.ID ~= v34.WitherbarksBranch:ID())) or (v102.ID == v34.WitherbarksBranch:ID())) then
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
local v72 = {{v33.Blind,"Cast Blind (Interrupt)",function()
	return true;
end},{v33.KidneyShot,"Cast Kidney Shot (Interrupt)",function()
	return v47 > (0 - 0);
end}};
local function v73()
	return v6:IsInRaidArea() or v6:IsInDungeonArea() or v7:IsDummy() or (not v6:IsTanking(v7) and v32.Commons.UseSoloVanish);
end
local function v74()
	return ((v15.ToggleIconFrame:GetToggle(3 + 1) or v15.CDsON()) and v30.TTDCheck(v32.Assassination.TimeToDie.Cooldowns, v32.Commons.Enabled.IgnoreTtdOnBoss and v68, v7:TimeToDie())) or v7:DebuffUp(v33.Kingsbane);
end
v33.Envenom:RegisterDamageFormula(function()
	return v6:AttackPowerDamageMod() * v47 * (0.22 - 0) * (953 - (802 + 150)) * ((v7:DebuffUp(v33.ShivDebuff) and (2.3 - 1)) or (1 - 0)) * ((v33.DeeperStratagem:IsAvailable() and (1.05 + 0)) or (998 - (915 + 82))) * ((2 - 1) + (v6:MasteryPct() / (59 + 41))) * ((1 - 0) + (v6:VersatilityDmgPct() / (1287 - (1069 + 118))));
end);
v33.Mutilate:RegisterDamageFormula(function()
	return (v6:AttackPowerDamageMod() + v6:AttackPowerDamageMod(true)) * (0.485 - 0) * (1 - 0) * (1 + 0 + (v6:VersatilityDmgPct() / (177 - 77)));
end);
local function v75()
	return v6:BuffRemains(v33.MasterAssassinBuff) == (9920 + 79);
end
local function v76()
	if v75() then
		return v6:GCDRemains() + (794 - (368 + 423));
	end
	return v6:BuffRemains(v33.MasterAssassinBuff);
end
local function v77()
	if v6:BuffUp(v33.ImprovedGarroteAura) then
		return v6:GCDRemains() + (9 - 6);
	end
	return v6:BuffRemains(v33.ImprovedGarroteBuff);
end
local function v78()
	if v6:BuffUp(v33.IndiscriminateCarnageAura) then
		return v6:GCDRemains() + (28 - (10 + 8));
	end
	return v6:BuffRemains(v33.IndiscriminateCarnageBuff);
end
local function v79()
	if (v42 < (7 - 5)) then
		return false;
	elseif ((v32.Assassination.UsePriorityRotation == "On Bosses") and v7:IsInBossList()) then
		return true;
	end
	return v15.ToggleIconFrame:GetToggle(444 - (416 + 26));
end
local function v80()
	if (v7:DebuffUp(v33.Deathmark) or v7:DebuffUp(v33.Kingsbane) or v7:DebuffUp(v33.ShivDebuff) or (v6:BuffUp(v33.Envenom) and (v6:BuffRemains(v33.Envenom) <= (3 - 2))) or (v6:EnergyPercentage() >= ((18 + 22 + ((53 - 23) * v22(v33.HandOfFate:IsAvailable()))) - ((453 - (145 + 293)) * v22(v33.ViciousVenoms:IsAvailable())))) or v3.BossFilteredFightRemains("<=", 450 - (44 + 386))) then
		return true;
	end
	return false;
end
local function v81()
	if not v33.ScentOfBlood:IsAvailable() then
		return true;
	end
	return v6:BuffStack(v33.ScentOfBloodBuff) >= v27(1506 - (998 + 488), v33.ScentOfBlood:TalentRank() * (1 + 1) * v42);
end
local function v82(v106, v107, v108)
	local v108 = v108 or v107:PandemicThreshold();
	return v106:DebuffRefreshable(v107, v108);
end
local function v83(v109, v110, v111, v112)
	local v113, v114 = nil, v111;
	local v115 = v7:GUID();
	local v116 = v8:Exists() and v8:GUID();
	for v136, v137 in v24(v112) do
		if ((v137:GUID() ~= v115) and v110(v137)) then
			if ((v137:GUID() == v116) and v137:IsInMeleeRange(v36) and ((v137:TimeToDie() > v111) or (v32.Commons.Enabled.IgnoreTtdOnBoss and v68) or v29.Buggedmobs[v7:NPCID()])) then
				if (v137:GUID() == v116) then
				end
				v15.CastTarget(v109, v15.TName().MOUSEOVER);
				return "Cast Mouseover " .. v109:Name();
			end
			if v29.UnitIsCycleValid(v137, v114, -v137:DebuffRemains(v109)) then
				v113, v114 = v137, v137:TimeToDie();
			end
		end
	end
	if v113 then
		v21(v113, v109);
	elseif v32.Commons.RangedMultiDoT then
		v113, v114 = nil, v111;
		for v163, v164 in v24(v41) do
			if ((v164:GUID() ~= v115) and v29.UnitIsCycleValid(v164, v114, -v164:DebuffRemains(v109)) and v110(v164)) then
				v113, v114 = v164, v164:TimeToDie();
			end
		end
		if v113 then
			v21(v113, v109);
		end
	end
end
local function v84(v117, v118, v119)
	local v120 = v118(v7);
	if ((v117 == "first") and (v120 ~= (0 + 0))) then
		return v7;
	end
	local v121 = v118(v8);
	if ((v117 == "first") and (v121 ~= (772 - (201 + 571)))) then
		return v8;
	end
	local v122, v123 = nil, 1138 - (116 + 1022);
	local function v124(v138)
		for v139, v140 in v24(v138) do
			local v141 = v118(v140);
			if (not v122 and (v117 == "first")) then
				if (v141 ~= (0 - 0)) then
					v122, v123 = v140, v141;
				end
			elseif (v117 == "min") then
				if (not v122 or (v141 < v123)) then
					v122, v123 = v140, v141;
				end
			elseif (v117 == "max") then
				if (not v122 or (v141 > v123)) then
					v122, v123 = v140, v141;
				end
			end
			if (v122 and (v141 == v123) and (v140:TimeToDie() > v122:TimeToDie())) then
				v122, v123 = v140, v141;
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
			if ((not v33.Kingsbane:IsAvailable() and v7:DebuffUp(v33.ShivDebuff)) or (v7:DebuffUp(v33.Kingsbane) and (v7:DebuffRemains(v33.Kingsbane) < (5 + 3)))) then
				if v18(v33.AncestralCall, true) then
					return "Cast Ancestral Call";
				end
			end
		end
	end
	return false;
end
local function v86(v125, v126)
	if (((v33.Ambush:IsCastable() and v6:StealthUp(true, false)) or v126) and v7:DebuffDown(v33.DeathStalkersMarkDebuff) and v33.DeathStalkersMark:IsAvailable()) then
		if v125 then
			return v33.Ambush;
		elseif v18(v33.Ambush) then
			return "Cast Ambush Stealthed";
		end
	end
	if (v74() and v33.Kingsbane:IsAvailable() and v6:BuffUp(v33.Envenom)) then
		if (v33.Shiv:IsReady() and (v7:DebuffUp(v33.Kingsbane) or v33.Kingsbane:CooldownUp()) and v7:DebuffDown(v33.ShivDebuff)) then
			if v125 then
				return v33.Shiv;
			elseif v18(v33.Shiv, true) then
				return "Cast Shiv (Stealth Kingsbane)";
			end
		end
	end
	if ((v47 >= v66) and (v7:DebuffUp(v33.DeathStalkersMarkDebuff) or v6:BuffUp(v33.EdgeCase) or v6:BuffUp(v33.ColdBlood))) then
		if (v7:DebuffUp(v33.Kingsbane) and (v6:BuffRemains(v33.Envenom) <= (10 - 7))) then
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
		local function v142(v149)
			return v149:DebuffRemains(v33.Rupture);
		end
		local function v143(v150)
			return (v47 >= v66) and v6:BuffUp(v33.IndiscriminateCarnageBuff) and v150:DebuffRefreshable(v33.Rupture) and (not v62 or not v64 or v150:DebuffDown(v33.Rupture)) and ((v7:TimeToDie() > (53 - 38)) or (v32.Commons.Enabled.IgnoreTtdOnBoss and v68) or v29.Buggedmobs[v7:NPCID()]);
		end
		if v15.AoEON() then
			local v159 = v84("min", v142, v143);
			if (v159 and (v159:GUID() ~= v7:GUID())) then
				if (v159:GUID() == v8:GUID()) then
					v15.CastTarget(v33.Rupture, v15.TName().MOUSEOVER);
					return "Cast Mouseover Rupture";
				else
					v21(v159, v33.Rupture);
				end
			end
		end
		if v143(v7) then
			if v125 then
				return v33.Rupture;
			elseif v18(v33.Rupture) then
				return "Cast Rupture (Stealth Indiscriminate Carnage)";
			end
		end
	end
	if ((v33.Garrote:IsCastable() and (v77() > (859 - (814 + 45)))) or v126) then
		local function v144(v151)
			return v151:DebuffRemains(v33.Garrote);
		end
		local function v145(v152)
			return ((v152:PMultiplier(v33.Garrote) <= (2 - 1)) or (v152:DebuffRemains(v33.Garrote) < (1 + 11)) or ((v78() > (0 + 0)) and (v33.Garrote:AuraActiveCount() < v42))) and not v63 and (v152:FilteredTimeToDie(">", 887 - (261 + 624), -v152:DebuffRemains(v33.Garrote)) or v152:TimeToDieIsNotValid()) and v30.CanDoTUnit(v152, v52);
		end
		if v15.AoEON() then
			local v160 = v84("min", v144, v145);
			if (v160 and (v160:GUID() ~= v7:GUID())) then
				if (v160:GUID() == v8:GUID()) then
					v15.CastTarget(v33.Garrote, v15.TName().MOUSEOVER);
					return "Cast Mouseover Garrote";
				else
					v21(v160, v33.Garrote);
				end
			end
		end
		if v145(v7) then
			if v125 then
				return v33.Garrote;
			elseif v18(v33.Garrote) then
				return "Cast Garrote (Improved Garrote)";
			end
		end
		if ((v48 >= ((1 - 0) + ((1082 - (1020 + 60)) * v22(v33.ShroudedSuffocation:IsAvailable())))) and ((v7:PMultiplier(v33.Garrote) <= (1424 - (630 + 793))) or (v7:DebuffRemains(v33.Garrote) < (40 - 28)) or (not v63 and (v76() < (14 - 11))))) then
			if v125 then
				return v33.Garrote;
			elseif v18(v33.Garrote) then
				return "Cast Garrote (Improved Garrote Low CP)";
			end
		end
	end
end
local function v87(v127)
	if not v15.ToggleIconFrame:GetToggle(1 + 0) then
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
		return "| " .. v129[1915 - (1789 + 124)]:Name();
	end
	return false;
end
local function v88()
	if (v32.Commons.ShowPooling and (v6:EnergyPredicted() < (811 - (745 + 21)))) then
		if v18(v33.PoolEnergy) then
			return "Pool for Vanish";
		end
	end
	if (v33.Vanish:IsCastable() and v6:BuffDown(v33.FateboundLuckyCoin) and ((v6:BuffStack(v33.FateboundCoinTails) >= (2 + 3)) or (v6:BuffStack(v33.FateboundCoinHeads) >= (13 - 8)))) then
		if v73() then
			v44 = v87(v33.Vanish);
			if v44 then
				return "Cast Vanish (Fateful Ending Fish)" .. v44;
			end
		end
	end
	if (v33.Vanish:IsCastable() and not v33.MasterAssassin:IsAvailable() and not v33.IndiscriminateCarnage:IsAvailable() and v33.ImprovedGarrote:IsAvailable() and v33.Garrote:CooldownUp() and ((v7:PMultiplier(v33.Garrote) <= (3 - 2)) or v82(v7, v33.Garrote)) and (v7:DebuffUp(v33.Deathmark) or (v33.Deathmark:CooldownRemains() < (1 + 3))) and (v48 >= v27(v42, 4 + 0))) then
		if v73() then
			v44 = v87(v33.Vanish);
			if v44 then
				return "Cast Vanish Garrote Deathmark (No Carnage)" .. v44;
			end
		end
	end
	if (v32.Commons.ShowPooling and (v6:EnergyPredicted() < (1100 - (87 + 968))) and v73()) then
		if v18(v33.PoolEnergy) then
			return "Pool for Vanish";
		end
	end
	if (v33.Vanish:IsCastable() and not v33.MasterAssassin:IsAvailable() and v33.IndiscriminateCarnage:IsAvailable() and v33.ImprovedGarrote:IsAvailable() and v33.Garrote:CooldownUp() and ((v7:PMultiplier(v33.Garrote) <= (4 - 3)) or v82(v7, v33.Garrote)) and (v42 > (2 + 0))) then
		if v73() then
			v44 = v87(v33.Vanish);
			if v44 then
				return "Cast Vanish (Garrote Carnage)" .. v44;
			end
		end
	end
	if (v33.Vanish:IsCastable() and not v33.ImprovedGarrote:IsAvailable() and v33.MasterAssassin:IsAvailable() and not v82(v7, v33.Rupture) and (v7:DebuffRemains(v33.Garrote) > (6 - 3)) and v7.DebuffUp(v33.Deathmark) and (v7.DebuffUp(v33.ShivDebuff) or (v7.DebuffRemains(v33.Deathmark) < (1417 - (447 + 966))))) then
		if v73() then
			v44 = v87(v33.Vanish);
			if v44 then
				return "Cast Vanish (Master Assassin)" .. v44;
			end
		end
	end
	if (v33.Vanish:IsCastable() and v33.ImprovedGarrote:IsAvailable() and v33.Garrote:CooldownUp() and ((v7:PMultiplier(v33.Garrote) <= (2 - 1)) or v82(v7, v33.Garrote)) and (v7:DebuffUp(v33.Deathmark) or (v33.Deathmark:CooldownRemains() < (1821 - (1703 + 114))))) then
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
		if ((v7:DebuffUp(v33.Kingsbane) and (v7:DebuffRemains(v33.Kingsbane) <= (712 - (376 + 325)))) or v3.BossFilteredFightRemains("<", 35 - 13)) then
			if v18(v34.AshesoftheEmbersoul) then
				return "Ashes of the Embersoul";
			end
		end
	end
	if v71(v34.AlgetharPuzzleBox) then
		if ((v7:DebuffUp(v33.Rupture) and (v33.Deathmark:CooldownRemains() <= (5 - 3))) or v3.BossFilteredFightRemains("<", 7 + 15)) then
			if v18(v34.AlgetharPuzzleBox) then
				return "Algethar Puzzle Box";
			end
		end
	end
	if v71(v34.TreacherousTransmitter) then
		if ((v7:DebuffUp(v33.Rupture) and (v33.Deathmark:CooldownRemains() <= (4 - 2))) or v7:DebuffUp(v33.Deathmark) or v3.BossFilteredFightRemains("<", 36 - (9 + 5))) then
			if v18(v34.TreacherousTransmitter) then
				return "Treacherous Transmitter";
			end
		end
	end
	if v71(v34.MadQueensMandate) then
		if (((v33.Deathmark:CooldownRemains() >= (406 - (85 + 291))) and v7:DebuffDown(v33.Deathmark)) or v3.BossFilteredFightRemains("<=", 1268 - (243 + 1022))) then
			if v18(v34.MadQueensMandate) then
				return "Mad Queen's Mandate";
			end
		end
	end
	if v71(v34.ImperfectAscendancySerum) then
		if ((v7:DebuffUp(v33.Rupture) and (v33.Deathmark:CooldownRemains() <= (7 - 5))) or v7:DebuffUp(v33.Deathmark) or v3.BossFilteredFightRemains("<", 19 + 3)) then
			if v18(v34.ImperfectAscendancySerum) then
				return "Imperfect Ascendancy Serum";
			end
		end
	end
	if (TrinketItem1:IsReady() and v32.Commons.Enabled.Trinket1 and not v6:IsItemBlacklisted(TrinketItem1) and not v14(v35, TrinketItem1:ID())) then
		if (((v65 == (1181 - (1123 + 57))) and (v33.Deathmark:AnyDebuffUp() or not v33.Deathmark:IsAvailable() or v3.BossFilteredFightRemains("<", 17 + 3))) or ((v65 == (256 - (163 + 91))) and (not TrinketItem2:IsReady() or (not v33.Deathmark:AnyDebuffUp() and (v33.Deathmark:CooldownRemains() > (1950 - (1869 + 61)))))) or (v65 == (0 + 0))) then
			if v18(TrinketItem1) then
				return "Trinket 1";
			end
		end
	end
	if (TrinketItem2:IsReady() and v32.Commons.Enabled.Trinket2) then
		if (not v6:IsItemBlacklisted(TrinketItem2) and not v14(v35, TrinketItem2:ID()) and (((v65 == (6 - 4)) and (v33.Deathmark:AnyDebuffUp() or not v33.Deathmark:IsAvailable() or v3.BossFilteredFightRemains("<", 30 - 10))) or ((v65 == (1 + 0)) and (not TrinketItem1:IsReady() or (not v33.Deathmark:AnyDebuffUp() and (v33.Deathmark:CooldownRemains() > (27 - 7))))) or (v65 == (0 + 0)))) then
			if v18(TrinketItem2) then
				return "Trinket 2";
			end
		end
	end
end
local function v90()
	local v130 = v7:DebuffDown(v33.ShivDebuff) and v7:DebuffUp(v33.Garrote) and v7:DebuffUp(v33.Rupture);
	local v131 = v33.Kingsbane:IsAvailable() and v6:BuffUp(v33.Envenom) and v130;
	if v33.Shiv:IsReady() then
		if (v33.ArterialPrecision:IsAvailable() and v130 and (v42 >= (1478 - (1329 + 145)))) then
			if v18(v33.Shiv, true) then
				return "Cast Shiv (Arterial Precision)";
			end
		end
		if (not v33.LightweightShiv:IsAvailable() and v131 and ((v7:DebuffUp(v33.Kingsbane) and (v7:DebuffRemains(v33.Kingsbane) < (979 - (140 + 831)))) or (not v7:DebuffUp(v33.Kingsbane) and (v33.Kingsbane:CooldownRemains() >= (1874 - (1409 + 441))))) and (not v33.CrimsonTempest:IsAvailable() or v63 or v7:DebuffUp(v33.CrimsonTempest))) then
			if v18(v33.Shiv, true) then
				return "Cast Shiv (Kingsbane)";
			end
		end
		if (v33.LightweightShiv:IsAvailable() and v131 and (v7:DebuffUp(v33.Kingsbane) or (v33.Kingsbane:CooldownRemains() <= (719 - (15 + 703))))) then
			if v18(v33.Shiv, true) then
				return "Cast Shiv (Kingsbane Lightweight)";
			end
		end
		if (v33.ArterialPrecision:IsAvailable() and v130 and v33.Deathmark:AnyDebuffUp()) then
			if v18(v33.Shiv, true) then
				return "Cast Shiv (Arterial Precision Deathmark)";
			end
		end
		if (not v33.Kingsbane:IsAvailable() and not v33.ArterialPrecision:IsAvailable() and v130 and (not v33.CrimsonTempest:IsAvailable() or v63 or v7:DebuffUp(v33.CrimsonTempest))) then
			if v18(v33.Shiv, true) then
				return "Cast Shiv no KB";
			end
		end
		if v3.BossFilteredFightRemains("<=", v33.Shiv:Charges() * (4 + 4)) then
			if v18(v33.Shiv, true) then
				return "Cast Shiv (End Fight)";
			end
		end
	end
end
local function v91()
	if v32.Commons.Enabled.Potions then
		local v146 = v29.PotionSelected();
		if (v146 and v146:IsReady() and (v6:BloodlustUp() or v3.BossFilteredFightRemains("<", 468 - (262 + 176)) or v33.Deathmark:AnyDebuffUp())) then
			v15.CastMacro(1724 - (345 + 1376), nil, nil, v146);
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
	local v132 = not v6:StealthUp(true, false) and (v6:BuffRemains(v33.SliceandDice) > (693 - (198 + 490))) and v7:DebuffUp(v33.Rupture) and v6:BuffUp(v33.Envenom) and not v33.Deathmark:AnyDebuffUp() and (not v33.MasterAssassin:IsAvailable() or v7:DebuffUp(v33.Garrote)) and (not v33.Kingsbane:IsAvailable() or (v33.Kingsbane:CooldownRemains() <= (8 - 6)));
	if (v92() and (v32.Commons.Enabled.Trinket1 or v32.Commons.Enabled.Trinket2)) then
		v44 = v89();
		if v44 then
			return v44;
		end
	end
	if (v92() and v33.Deathmark:IsCastable()) then
		if (v132 or v3.BossFilteredFightRemains("<=", 47 - 27)) then
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
		if (((v7:DebuffUp(v33.ShivDebuff) or (v33.Shiv:CooldownRemains() < (1212 - (696 + 510)))) and v6:BuffUp(v33.Envenom) and ((v33.Deathmark:CooldownRemains() >= (104 - 54)) or v7:DebuffUp(v33.Deathmark) or not v17())) or v3.BossFilteredFightRemains("<=", 1277 - (1091 + 171))) then
			if v18(v33.Kingsbane, true) then
				return "Cast Kingsbane";
			end
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
	if (v92() and not v6:StealthUp(true, true) and (v76() <= (0 + 0))) then
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
		if (v6:BuffDown(v33.EdgeCase) and (v33.Deathmark:CooldownRemains() > (31 - 21)) and v6:BuffDown(v33.DarkestNightBuff) and (v47 >= v66) and (v57 or (v7:DebuffStack(v33.AmplifyingPoisonDebuff) >= (66 - 46)) or not v63) and v6:BuffDown(v30.VanishBuffSpell()) and (not v33.Kingsbane:CooldownUp() or not v63) and (not v33.Deathmark:CooldownUp() or not v17())) then
			if v18(v33.ColdBlood, true) then
				return "Cast Cold Blood";
			end
		end
		return v44;
	end
end
local function v94(v133)
	return v82(v133, v33.Garrote) and (v133:PMultiplier(v33.Garrote) <= (375 - (123 + 251)));
end
local function v95(v134)
	v53 = (19 - 15) + (v12(v33.DashingScoundrel:IsAvailable()) * (703 - (208 + 490))) + (v12(v62) * (1 + 5));
	return v82(v134, v33.Rupture, v49) and (v134:PMultiplier(v33.Rupture) <= (1 + 0)) and (v134:FilteredTimeToDie(">", v53, -v134:DebuffRemains(v33.Rupture)) or v134:TimeToDieIsNotValid());
end
local function v96()
	if (v33.Garrote:IsCastable() and (v48 >= (837 - (660 + 176)))) then
		if (v94(v7) and v30.CanDoTUnit(v7, v52) and (v7:FilteredTimeToDie(">", 2 + 10, -v7:DebuffRemains(v33.Garrote)) or v7:TimeToDieIsNotValid())) then
			if v19(v33.Garrote) then
				return "Pool for Garrote (ST)";
			end
		end
	end
	if (v33.Rupture:IsReady() and (v47 >= v66) and v6:BuffDown(v33.DarkestNightBuff)) then
		if (v95(v7) and v30.CanDoTUnit(v7, v51)) then
			if v19(v33.Rupture) then
				return "Cast Rupture";
			end
		end
	end
	if (v33.CrimsonTempest:IsReady() and (v47 >= v66) and v82(v7, v33.CrimsonTempest) and (v6:BuffRemains(v33.MomentumOfDespair) > (208 - (14 + 188))) and v63) then
		if v18(v33.CrimsonTempest) then
			return "Crimson Tempest with Momentum of Despair";
		end
	end
end
local function v97()
	local v135 = v47 >= v66;
	if (v15.AoEON() and v33.CrimsonTempest:IsCastable() and (v42 >= (677 - (534 + 141))) and v135) then
		for v153, v154 in v24(v41) do
			if (v82(v154, v33.CrimsonTempest, v50) and v154:FilteredTimeToDie(">", 3 + 3, -v154:DebuffRemains(v33.CrimsonTempest))) then
				if v18(v33.CrimsonTempest) then
					return "Cast Crimson Tempest (AoE High Energy)";
				end
			end
		end
	end
	if (v33.Garrote:IsCastable() and (v48 >= (1 + 0))) then
		if (v94(v7) and not v62 and (v7:FilteredTimeToDie(">", 12 + 0, -v7:DebuffRemains(v33.Garrote)) or v7:TimeToDieIsNotValid())) then
			local v161 = v83(v33.Garrote, v94, 24 - 12, v41);
			if v161 then
				return v161;
			end
		end
	end
	if (v33.Rupture:IsReady() and v15.AoEON() and v135 and (v7:DebuffDown(v33.Kingsbane) or v6:BuffUp(v33.ColdBlood)) and not v62 and ((v33.ScentOfBlood:TalentRank() == (2 - 0)) or ((v33.ScentOfBlood:TalentRank() <= (2 - 1)) and (v6:BuffUp(v33.IndiscriminateCarnageBuff or (v7:TimeToDie() > (9 + 6)) or (v32.Commons.Enabled.IgnoreTtdOnBoss and v68) or v29.Buggedmobs[v7:NPCID()])))) and ((v7:TimeToDie() > (5 + 2 + (v12(v33.DashingScoundrel:IsAvailable()) * (401 - (115 + 281))) + (v12(v62) * (13 - 7)))) or (v32.Commons.Enabled.IgnoreTtdOnBoss and v68) or v29.Buggedmobs[v7:NPCID()]) and v6:BuffDown(v33.DarkestNightBuff)) then
		local v147 = v83(v33.Rupture, v95, v53, v41);
		if v147 then
			return v147;
		end
	end
	if (v33.Rupture:IsReady() and v135 and v6:BuffDown(v33.DarkestNightBuff) and v15.AoEON()) then
		v53 = 6 + 1 + (v12(v33.DashingScoundrel:IsAvailable()) * (12 - 7)) + (v12(v62) * (21 - 15));
		if ((not v7:DebuffUp(v33.Kingsbane or v6:BuffUp(v33.ColdBlood)) and v62) or not v64) then
			local v162 = v83(v33.Rupture, v95, v53, v43);
			if v162 then
				return v162;
			end
		end
	end
	if (v33.Garrote:IsReady() and (v48 >= (868 - (550 + 317))) and (v76() <= (0 - 0)) and ((v7:PMultiplier(v33.Garrote) <= (1 - 0)) or ((v7:DebuffRemains(v33.Garrote) < v45) and (v42 >= (8 - 5)))) and (v7:DebuffRemains(v33.Garrote) < (v45 * (287 - (134 + 151)))) and (v42 >= (1668 - (970 + 695))) and (v7:FilteredTimeToDie(">", 7 - 3, -v7:DebuffRemains(v33.Garrote)) or v7:TimeToDieIsNotValid())) then
		if v18(v33.Garrote) then
			return "Garrote (Fallback)";
		end
	end
	return false;
end
local function v98()
	if (v33.Envenom:IsReady() and v6:BuffDown(v33.DarkestNightBuff) and (v47 > v66) and (v57 or (v7:DebuffStack(v33.AmplifyingPoisonDebuff) >= (2010 - (582 + 1408))) or (v47 > v30.CPMaxSpend()) or not v63) and v6:BuffDown(v30.VanishBuffSpell())) then
		if v18(v33.Envenom) then
			return "Cast Envenom 1";
		end
	end
	if (v33.Envenom:IsReady() and v6:BuffUp(v33.DarkestNightBuff) and (v47 >= v30.CPMaxSpend())) then
		if v18(v33.Envenom) then
			return "Cast Envenom 2";
		end
	end
	if not ((v48 > (3 - 2)) or v57 or not v63) then
		return false;
	end
	if (not v63 and v33.CausticSpatter:IsAvailable() and v7:DebuffUp(v33.Rupture) and (v7:DebuffRemains(v33.CausticSpatterDebuff) <= (2 - 0))) then
		if v33.Mutilate:IsCastable() then
			if v19(v33.Mutilate) then
				return "Cast Mutilate (Casutic)";
			end
		end
		if ((v33.Ambush:IsReady() or v33.AmbushOverride:IsReady()) and (v6:StealthUp(true, true) or v6:BuffUp(v33.BlindsideBuff))) then
			if v18(v33.Ambush) then
				return "Cast Ambush (Caustic)";
			end
		end
	end
	if (v74() and v33.EchoingReprimand:IsReady()) then
		if v18(v33.EchoingReprimand, true) then
			return "Cast Echoing Reprimand";
		end
	end
	if v33.FanofKnives:IsReady() then
		if ((v15.AoEON() and not v56 and (v42 >= ((11 - 8) - v12(v33.MomentumOfDespair and v33.ThrownPrecision)))) or (v6:BuffUp(v33.ClearTheWitnessesBuff) and not v33.ViciousVenoms:IsAvailable())) then
			if v19(v33.FanofKnives) then
				return "Cast Fan of Knives";
			end
		end
	end
	if (v15.AoEON() and v6:BuffUp(v33.DeadlyPoison) and (v42 >= ((1827 - (1195 + 629)) - v12(v33.MomentumOfDespair:IsAvailable() and v33.ThrownPrecision:IsAvailable())))) then
		for v155, v156 in v24(v41) do
			if (not v156:DebuffUp(v33.DeadlyPoisonDebuff, true) and (not v56 or v156:DebuffUp(v33.Garrote) or v156:DebuffUp(v33.Rupture))) then
				if v19(v33.FanofKnives) then
					return "Cast Fan of Knives (DP Refresh)";
				end
			end
		end
	end
	if ((v33.Ambush:IsReady() or v33.AmbushOverride:IsReady()) and (v6:BuffUp(v33.BlindsideBuff) or v6:StealthUp(true, false)) and (v7:DebuffDown(v33.Kingsbane) or v7:DebuffDown(v33.Deathmark) or v6:BuffUp(v33.BlindsideBuff))) then
		if v19(v33.Ambush) then
			return "Cast Ambush";
		end
	end
	if (v33.Mutilate:IsCastable() and (v42 == (2 - 0)) and v7:DebuffDown(v33.DeadlyPoisonDebuff, true) and v7:DebuffDown(v33.AmplifyingPoisonDebuff, true)) then
		local v148 = v7:GUID();
		if ((v7:DebuffUp(v33.Garrote) or v7:DebuffUp(v33.Rupture)) and not v7:DebuffUp(v33.DeadlyPoisonDebuff, true) and not v7:DebuffUp(v33.AmplifyingPoisonDebuff, true)) then
			v18(v33.Mutilate);
			return "Cast ReapplyDebuff Mutilate";
		end
		for v157, v158 in v24(v41) do
			if ((v158:GUID() ~= v148) and (v158:DebuffUp(v33.Garrote) or v158:DebuffUp(v33.Rupture)) and not v158:DebuffUp(v33.DeadlyPoisonDebuff, true) and not v158:DebuffUp(v33.AmplifyingPoisonDebuff, true)) then
				if ((v158:GUID() == v8:GUID()) and v158:IsInMeleeRange(v36)) then
					v15.CastTarget(v33.Mutilate, v15.TName().MOUSEOVER);
					return "Cast Mouseover Mutilate";
				else
					v21(v158, v33.Mutilate);
				end
				break;
			end
		end
	end
	if v33.Mutilate:IsCastable() then
		if v19(v33.Mutilate) then
			return "Cast Mutilate";
		end
	end
	return false;
end
local function v99()
	v36 = 246 - (187 + 54);
	v37 = 790 - (162 + 618);
	v38 = v7:IsInMeleeRange(v36);
	v39 = v7:IsInMeleeRange(v37);
	v67 = v3.BossFightRemains();
	v68 = true;
	if (v67 == (7786 + 3325)) then
		v68 = false;
		v67 = v3.FightRemains(v40, false);
	end
	if v16() then
		v40 = v6:GetEnemiesInRange(20 + 10);
		v41 = v6:GetEnemiesInMeleeRange(v37);
		v42 = #v41;
		v43 = v6:GetEnemiesInMeleeRange(v36);
	else
		v40 = {};
		v41 = {};
		v42 = 1 - 0;
		v43 = {};
	end
	v45, v46 = (2 - 0) * v6:SpellHaste(), (1 + 0) * v6:SpellHaste();
	v47 = v30.EffectiveComboPoints(v6:ComboPoints());
	v48 = v6:ComboPointsMax() - v47;
	v49 = ((1640 - (1373 + 263)) + (v47 * (1004 - (451 + 549)))) * (0.3 + 0);
	v50 = ((5 - 1) + (v47 * (2 - 0))) * (1384.3 - (746 + 638));
	v51 = v33.Envenom:Damage() * v32.Assassination.EnvenomDMGOffset;
	v52 = v33.Mutilate:Damage() * v32.Assassination.MutilateDMGOffset;
	v56 = v79();
	v66 = v26(v6:ComboPointsMax() - (1 + 1), (7 - 2) * v22(v33.HandOfFate:IsAvailable()));
	v44 = v30.Defense();
	if v44 then
		return v44;
	end
	v44 = v30.Poisons();
	if v44 then
		return v44;
	end
	v66 = v26(v6:ComboPointsMax() - (343 - (218 + 123)), (1586 - (1535 + 46)) * v22(v33.HandOfFate:IsAvailable()));
	if not v6:AffectingCombat() then
		if not v6:BuffUp(v30.VanishBuffSpell()) then
			v44 = v30.Stealth(v30.StealthSpell());
			if v44 then
				return v44;
			end
		end
		if v30.CombatCheck() then
			if not v6:BuffUp(v33.SliceandDice) then
				if (v33.SliceandDice:IsReady() and (v47 >= (2 + 0))) then
					if v18(v33.SliceandDice) then
						return "Cast Slice and Dice";
					end
				end
			end
		end
	end
	if v30.CombatCheck() then
		if v15.ToggleIconFrame:GetToggle(1 + 2) then
			v44 = v29.InterruptCycle(v33.Kick, v36, true, nil, false);
			if v44 then
				return v44;
			end
			v44 = v32.Interrupt.UseBlind and v29.IncorpCycle(v33.Blind, 575 - (306 + 254), true, nil, false);
			if v44 then
				return v44;
			end
			v44 = v32.Interrupt.UseBlind and v29.InterruptCycle(v33.Blind, 1 + 14, true, nil, true);
			if v44 then
				return v44;
			end
			if (v7:DebuffDown(v33.Deathmark) or v7:DebuffDown(v33.Kingsbane)) then
				v44 = v32.Interrupt.UseKidneyShot and (v47 > (0 - 0)) and v29.InterruptCycle(v33.KidneyShot, v36, true, nil, true);
				if v44 then
					return v44;
				end
				v44 = v32.Interrupt.UseCheapShop and v6:StealthUp(true, true) and v29.InterruptCycle(v33.CheapShot, v36, true, nil, true);
				if v44 then
					return v44;
				end
			end
		end
		v44 = v32.Commons.Enabled.Shiv and v29.SootheCycle(v33.Shiv, 1476 - (899 + 568), false, v32.Commons.Enabled["Shiv Auto Target"]);
		if v44 then
			return v44;
		end
		v59 = v30.PoisonedBleeds();
		v60 = v6:EnergyRegen() + ((v59 * (4 + 2)) / ((4 - 2) * v6:SpellHaste()));
		v61 = v6:EnergyDeficit() / v60;
		v62 = v60 > (638 - (268 + 335));
		v57 = v80();
		v64 = v81();
		v63 = v42 < (292 - (60 + 230));
		if v63 then
			if not v7:IsInRange(597 - (426 + 146)) then
				return;
			end
		elseif (v42 == (1 + 0)) then
			return;
		end
		if (v74() and v33.ThistleTea:IsCastable() and not v6:BuffUp(v33.ThistleTea)) then
			if ((((v6:EnergyDeficit() >= ((1556 - (282 + 1174)) + v60)) or (v33.ThistleTea:Charges() >= (814 - (569 + 242)))) and (v7:DebuffRemains(v33.ShivDebuff) >= (11 - 7))) or ((v42 >= (1 + 3)) and (v7:DebuffRemains(v33.Shiv) >= (1030 - (706 + 318)))) or v3.BossFilteredFightRemains("<", v33.ThistleTea:Charges() * (1257 - (721 + 530)))) then
				if v15.Cast(v33.ThistleTea, true) then
					return "Cast Thistle Tea";
				end
			end
		end
		if (v6:StealthUp(true, false) or (v77() > (1271 - (945 + 326))) or (v76() > (0 - 0))) then
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
			if (v33.Envenom:IsReady() and (v6:BuffRemains(v33.SliceandDice) < (705 - (271 + 429))) and (v6:ComboPoints() >= (5 + 0))) then
				if v18(v33.Envenom) then
					return "Cast Envenom (CttC)";
				end
			end
		elseif (v33.PoisonedKnife:IsCastable() and v7:IsInRange(1530 - (1408 + 92)) and not v6:StealthUp(true, true) and (v42 == (1086 - (461 + 625))) and (v6:EnergyTimeToMax() <= (v6:GCD() * (1289.5 - (993 + 295))))) then
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
			if (v33.ArcaneTorrent:IsCastable() and v38 and (v6:EnergyDeficit() >= (1 + 14 + v60))) then
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
	v15.Print("Assassination Rogue rotation has been updated for patch 11.0.0.");
end
v15.SetAPL(1430 - (418 + 753), v99, v100);
