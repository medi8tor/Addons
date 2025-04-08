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
local v36 = {(220670 - (857 + 74)),(221553 - (214 + 713))};
local v37, v38, v39, v40;
local v41, v42, v43, v44;
local v45;
local v46, v47 = (1 + 1) * v6:SpellHaste(), (1 + 0) * v6:SpellHaste();
local v48, v49;
local v50, v51, v52, v53, v54;
local v55;
local v56, v57, v58, v59, v60, v61, v62, v63, v64, v65;
local v66 = 877 - (282 + 595);
local v67;
local v68, v69;
local v70 = 1637 - (1523 + 114);
local function v71()
	local v102, v103 = v6:GetTrinketData(OnUseExcludes);
	if ((v70 < (5 + 0)) and ((v102.ID == (0 - 0)) or (v103.ID == (1065 - (68 + 997))) or ((v102.SpellID > (1270 - (226 + 1044))) and not v102.Usable) or ((v103.SpellID > (0 - 0)) and not v103.Usable))) then
		v70 = v70 + (118 - (32 + 85));
		v28(5 + 0, function()
			v71();
		end);
		return;
	end
	TrinketItem1 = v102.Object;
	TrinketItem2 = v103.Object;
	if ((TrinketItem1:HasStatAnyDps() and (not TrinketItem2:HasStatAnyDps() or (v102.Cooldown >= v103.Cooldown)) and (v103.ID ~= v34.TreacherousTransmitter:ID())) or (v102.ID == v34.TreacherousTransmitter:ID())) then
		v66 = 1 + 0;
	elseif ((TrinketItem2:HasStatAnyDps() and (not TrinketItem1:HasStatAnyDps() or (v103.Cooldown > v102.Cooldown)) and (v102.ID ~= v34.TreacherousTransmitter:ID())) or (v103.ID == v34.TreacherousTransmitter:ID())) then
		v66 = 959 - (892 + 65);
	else
		v66 = 0 - 0;
	end
end
v71();
local function v72(v106)
	if v106:IsEquippedAndReady() then
		return ((TrinketItem1:ID() == v106:ID()) and v32.Commons.Enabled.Trinket1) or ((TrinketItem2:ID() == v106:ID()) and v32.Commons.Enabled.Trinket2);
	end
end
v3:RegisterForEvent(function()
	v70 = 0 - 0;
	v71();
end, "PLAYER_EQUIPMENT_CHANGED");
v3:RegisterForEvent(function()
	if v33.FateboundInevitability:IsAvailable() then
		v33.ColdBlood = v9(837744 - 381414);
	else
		v33.ColdBlood = v9(382595 - (87 + 263));
	end
end, "SPELLS_CHANGED", "LEARNED_SPELL_IN_TAB", "PLAYER_LOGIN", "PLAYER_TALENT_UPDATE", "PLAYER_SPECIALIZATION_CHANGED");
local v73 = {{v33.Blind,"Cast Blind (Interrupt)",function()
	return true;
end},{v33.KidneyShot,"Cast Kidney Shot (Interrupt)",function()
	return v48 > (0 + 0);
end}};
local function v74()
	return v6:IsInRaidArea() or v6:IsInDungeonArea() or v7:IsDummy() or (not v6:IsTanking(v7) and v32.Commons.UseSoloVanish);
end
local function v75()
	return ((v15.ToggleIconFrame:GetToggle(1001 - (915 + 82)) or v15.CDsON()) and v30.TTDCheck(v32.Assassination.TimeToDie.Cooldowns, v32.Commons.Enabled.IgnoreTtdOnBoss and v69, v7:TimeToDie())) or v7:DebuffUp(v33.Kingsbane);
end
v33.Envenom:RegisterDamageFormula(function()
	return v6:AttackPowerDamageMod() * v48 * (0.22 - 0) * (1 + 0) * ((v7:DebuffUp(v33.ShivDebuff) and (1.3 - 0)) or (1188 - (1069 + 118))) * ((v33.DeeperStratagem:IsAvailable() and (2.05 - 1)) or (1 - 0)) * (1 + 0 + (v6:MasteryPct() / (177 - 77))) * (1 + 0 + (v6:VersatilityDmgPct() / (891 - (368 + 423))));
end);
v33.Mutilate:RegisterDamageFormula(function()
	return (v6:AttackPowerDamageMod() + v6:AttackPowerDamageMod(true)) * (0.485 - 0) * (19 - (10 + 8)) * ((3 - 2) + (v6:VersatilityDmgPct() / (542 - (416 + 26))));
end);
local function v76()
	return v6:BuffRemains(v33.MasterAssassinBuff) == (31925 - 21926);
end
local function v77()
	if v76() then
		return v6:GCDRemains() + 2 + 1;
	end
	return v6:BuffRemains(v33.MasterAssassinBuff);
end
local function v78()
	if v6:BuffUp(v33.ImprovedGarroteAura) then
		return v6:GCDRemains() + (4 - 1);
	end
	return v6:BuffRemains(v33.ImprovedGarroteBuff);
end
local function v79()
	if v6:BuffUp(v33.IndiscriminateCarnageAura) then
		return v6:GCDRemains() + (448 - (145 + 293));
	end
	return v6:BuffRemains(v33.IndiscriminateCarnageBuff);
end
local function v80()
	if (v43 < (432 - (44 + 386))) then
		return false;
	elseif ((v32.Assassination.UsePriorityRotation == "On Bosses") and v7:IsInBossList()) then
		return true;
	end
	return v15.ToggleIconFrame:GetToggle(1488 - (998 + 488));
end
local function v81()
	if (v7:DebuffUp(v33.Deathmark) or v7:DebuffUp(v33.Kingsbane) or v7:DebuffUp(v33.ShivDebuff) or (v6:BuffUp(v33.Envenom) and (v6:BuffRemains(v33.Envenom) <= (1 + 0))) or (v6:EnergyPercentage() >= ((33 + 7 + ((802 - (201 + 571)) * v22(v33.HandOfFate:IsAvailable()))) - ((1153 - (116 + 1022)) * v22(v33.ViciousVenoms:IsAvailable())))) or v3.BossFilteredFightRemains("<=", 83 - 63)) then
		return true;
	end
	return false;
end
local function v82()
	if not v33.ScentOfBlood:IsAvailable() then
		return true;
	end
	return v6:BuffStack(v33.ScentOfBloodBuff) >= v27(12 + 8, v33.ScentOfBlood:TalentRank() * (7 - 5) * v43);
end
local function v83(v107, v108, v109)
	local v109 = v109 or v108:PandemicThreshold();
	return v107:DebuffRefreshable(v108, v109);
end
local function v84(v110, v111, v112, v113)
	local v114, v115 = nil, v112;
	local v116 = v7:GUID();
	local v117 = v8:Exists() and v8:GUID();
	for v139, v140 in v24(v113) do
		if ((v140:GUID() ~= v116) and v111(v140)) then
			if ((v140:GUID() == v117) and v140:IsInMeleeRange(v37) and ((v140:TimeToDie() > v112) or (v32.Commons.Enabled.IgnoreTtdOnBoss and v69) or v29.Buggedmobs[v7:NPCID()])) then
				if (v140:GUID() == v117) then
				end
				v15.CastTarget(v110, v15.TName().MOUSEOVER);
				return "Cast Mouseover " .. v110:Name();
			end
			if v29.UnitIsCycleValid(v140, v115, -v140:DebuffRemains(v110)) then
				v114, v115 = v140, v140:TimeToDie();
			end
		end
	end
	if v114 then
		v21(v114, v110);
	elseif v32.Commons.RangedMultiDoT then
		v114, v115 = nil, v112;
		for v168, v169 in v24(v42) do
			if ((v169:GUID() ~= v116) and v29.UnitIsCycleValid(v169, v115, -v169:DebuffRemains(v110)) and v111(v169)) then
				v114, v115 = v169, v169:TimeToDie();
			end
		end
		if v114 then
			v21(v114, v110);
		end
	end
end
local function v85(v118, v119, v120)
	local v121 = v119(v7);
	if ((v118 == "first") and (v121 ~= (0 - 0))) then
		return v7;
	end
	local v122 = v119(v8);
	if ((v118 == "first") and (v122 ~= (859 - (814 + 45)))) then
		return v8;
	end
	local v123, v124 = nil, 0 - 0;
	local function v125(v141)
		for v144, v145 in v24(v141) do
			local v146 = v119(v145);
			if (not v123 and (v118 == "first")) then
				if (v146 ~= (0 + 0)) then
					v123, v124 = v145, v146;
				end
			elseif (v118 == "min") then
				if (not v123 or (v146 < v124)) then
					v123, v124 = v145, v146;
				end
			elseif (v118 == "max") then
				if (not v123 or (v146 > v124)) then
					v123, v124 = v145, v146;
				end
			end
			if (v123 and (v146 == v124) and (v145:TimeToDie() > v123:TimeToDie())) then
				v123, v124 = v145, v146;
			end
		end
	end
	v125(v42);
	if (v123 and (v124 == v121) and v120(v7)) then
		return v7;
	end
	if (v123 and (v124 == v122) and v120(v8) and v8:IsInMeleeRange(v37)) then
		return v8;
	end
	if (v123 and v120(v123)) then
		return v123;
	end
	return nil;
end
local function v86()
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
			if ((not v33.Kingsbane:IsAvailable() and v7:DebuffUp(v33.ShivDebuff)) or (v7:DebuffUp(v33.Kingsbane) and (v7:DebuffRemains(v33.Kingsbane) < (3 + 5)))) then
				if v18(v33.AncestralCall, true) then
					return "Cast Ancestral Call";
				end
			end
		end
	end
	return false;
end
local function v87(v126, v127)
	if ((v33.Ambush:IsReady() or (v127 and v6:BuffDown(v33.DarkestNightBuff))) and v7:DebuffDown(v33.DeathStalkersMarkDebuff) and v33.DeathStalkersMark:IsAvailable() and (v48 < v67) and (v7:DebuffUp(v33.Rupture) or v62 or not v33.Subterfuge:IsAvailable())) then
		if v126 then
			return v33.Ambush;
		elseif v18(v33.Ambush) then
			return "Cast Ambush Stealthed";
		end
	end
	if (v75 and v33.Kingsbane:IsAvailable() and not v127 and v6:BuffUp(v33.Envenom)) then
		if (v33.Shiv:IsReady() and v7:DebuffUp(v33.Kingsbane) and (v7:DebuffRemains(v33.Kingsbane) < (893 - (261 + 624))) and v7:DebuffDown(v33.ShivDebuff) and (v7:DebuffRemains(v33.ShivDebuff) < (1 - 0))) then
			if v126 then
				return v33.Shiv;
			elseif v18(v33.Shiv, true) then
				return "Cast Shiv (Stealth Kingsbane)";
			end
		end
	end
	if ((v48 >= v67) and (v7:DebuffUp(v33.DeathStalkersMarkDebuff) or v6:BuffUp(v33.ColdBlood) or (v6:BuffUp(v33.DarkestNightBuff) and (v48 == (1087 - (1020 + 60)))))) then
		if (v7:DebuffUp(v33.Kingsbane) and (v6:BuffRemains(v33.Envenom) <= (1426 - (630 + 793)))) then
			if v126 then
				return v33.Envenom;
			elseif v18(v33.Envenom) then
				return "Cast Envenom (Stealth Kingsbane)";
			end
		end
		if (v62 and v76()) then
			if v126 then
				return v33.Envenom;
			elseif v18(v33.Envenom) then
				return "Cast Envenom (Master Assassin)";
			end
		end
	end
	if (v33.Rupture:IsCastable() or v127) then
		local function v147(v154)
			return v154:DebuffRemains(v33.Rupture);
		end
		local function v148(v155)
			return (v48 >= v67) and (v6:BuffUp(v33.IndiscriminateCarnageBuff) or v127) and v155:DebuffRefreshable(v33.Rupture) and (not v61 or not v63 or v155:DebuffDown(v33.Rupture)) and ((v7:TimeToDie() > (50 - 35)) or (v32.Commons.Enabled.IgnoreTtdOnBoss and v69) or v29.Buggedmobs[v7:NPCID()]);
		end
		if v15.AoEON() then
			local v164 = v85("min", v147, v148);
			if (v164 and (v164:GUID() ~= v7:GUID())) then
				if (v164:GUID() == v8:GUID()) then
					v15.CastTarget(v33.Rupture, v15.TName().MOUSEOVER);
					return "Cast Mouseover Rupture";
				else
					v21(v164, v33.Rupture);
				end
			end
		end
		if v148(v7) then
			if v126 then
				return v33.Rupture;
			elseif v18(v33.Rupture) then
				return "Cast Rupture (Stealth Indiscriminate Carnage)";
			end
		end
	end
	if ((v33.Garrote:IsCastable() and (v78() > (0 - 0))) or v127) then
		local function v149(v156)
			return v156:DebuffRemains(v33.Garrote);
		end
		local function v150(v157)
			return ((v157:PMultiplier(v33.Garrote) <= (1 + 0)) or (v157:DebuffRemains(v33.Garrote) < (41 - 29)) or (((v79() > (1747 - (760 + 987))) or v127) and (v33.Garrote:AuraActiveCount() < v43))) and not v62 and (v157:FilteredTimeToDie(">", 1915 - (1789 + 124), -v157:DebuffRemains(v33.Garrote)) or v157:TimeToDieIsNotValid()) and (v49 > ((768 - (745 + 21)) - (v22(v6:BuffUp(v33.DarkestNightBuff)) * (1 + 1)))) and v30.CanDoTUnit(v157, v53);
		end
		if v15.AoEON() then
			local v165 = v85("min", v149, v150);
			if (v165 and (v165:GUID() ~= v7:GUID())) then
				if (v165:GUID() == v8:GUID()) then
					v15.CastTarget(v33.Garrote, v15.TName().MOUSEOVER);
					return "Cast Mouseover Garrote";
				else
					v21(v165, v33.Garrote);
				end
			end
		end
		if v150(v7) then
			if v126 then
				return v33.Garrote;
			elseif v18(v33.Garrote) then
				return "Cast Garrote (Improved Garrote)";
			end
		end
		if ((v49 >= ((2 - 1) + ((7 - 5) * v22(v33.ShroudedSuffocation:IsAvailable())))) and ((v7:PMultiplier(v33.Garrote) <= (1 + 0)) or (v7:DebuffRemains(v33.Garrote) < (10 + 2)) or (not v62 and (v77() < (1058 - (87 + 968)))))) then
			if v126 then
				return v33.Garrote;
			elseif v18(v33.Garrote) then
				return "Cast Garrote (Improved Garrote Low CP)";
			end
		end
	end
end
local function v88(v128)
	if not v15.ToggleIconFrame:GetToggle(4 - 3) then
		return;
	end
	if (v128:ID() == v33.Vanish:ID()) then
		if v18(v33.Vanish, true) then
			return "Cast Vanish";
		end
		return false;
	elseif (v128:ID() == v33.Shadowmeld:ID()) then
		if v18(v33.Shadowmeld, true) then
			return "Cast Shadowmeld";
		end
		return false;
	end
	local v129 = v87(true, true);
	local v130 = {v128,v129};
	v45 = v20(unpack(v130));
	if v45 then
		return "| " .. v130[1415 - (447 + 966)]:Name();
	end
	return false;
end
local function v89()
	if (v32.Commons.ShowPooling and (v6:EnergyPredicted() < (123 - 78))) then
		if v18(v33.PoolEnergy) then
			return "Pool for Vanish";
		end
	end
	if (v33.Vanish:IsCastable() and v6:BuffDown(v33.FateboundLuckyCoin) and (v48 >= v67) and ((v6:BuffStack(v33.FateboundCoinTails) >= (1822 - (1703 + 114))) or (v6:BuffStack(v33.FateboundCoinHeads) >= (706 - (376 + 325))))) then
		if v74() then
			v45 = v88(v33.Vanish);
			if v45 then
				return "Cast Vanish (Fateful Ending Fish)" .. v45;
			end
		end
	end
	if (v33.Vanish:IsCastable() and not v33.MasterAssassin:IsAvailable() and not v33.IndiscriminateCarnage:IsAvailable() and v33.ImprovedGarrote:IsAvailable() and v33.Garrote:CooldownUp() and ((v7:PMultiplier(v33.Garrote) <= (1 - 0)) or v83(v7, v33.Garrote)) and (v7:DebuffUp(v33.Deathmark) or (v33.Deathmark:CooldownRemains() < (12 - 8))) and (v49 >= v27(v43, 2 + 2))) then
		if v74() then
			v45 = v88(v33.Vanish);
			if v45 then
				return "Cast Vanish Garrote Deathmark (No Carnage)" .. v45;
			end
		end
	end
	if (v32.Commons.ShowPooling and (v6:EnergyPredicted() < (98 - 53)) and v74()) then
		if v18(v33.PoolEnergy) then
			return "Pool for Vanish";
		end
	end
	if (v33.Vanish:IsCastable() and v33.IndiscriminateCarnage:IsAvailable() and v33.ImprovedGarrote:IsAvailable() and v33.Garrote:CooldownUp() and ((v7:PMultiplier(v33.Garrote) <= (15 - (9 + 5))) or v83(v7, v33.Garrote)) and (v43 > (378 - (85 + 291)))) then
		if v74() then
			v45 = v88(v33.Vanish);
			if v45 then
				return "Cast Vanish (Garrote Carnage)" .. v45;
			end
		end
	end
	if (v33.Vanish:IsCastable() and v33.MasterAssassin:IsAvailable() and not v83(v7, v33.Rupture) and (v7:DebuffRemains(v33.Garrote) > (1268 - (243 + 1022))) and v7:DebuffUp(v33.Deathmark) and (v7:DebuffRemains(v33.Kingsbane) <= ((22 - 16) + ((3 + 0) * v33.Subterfuge:TalentRank())))) then
		if v74() then
			v45 = v88(v33.Vanish);
			if v45 then
				return "Cast Vanish (Master Assassin)" .. v45;
			end
		end
	end
	if (v33.Vanish:IsCastable() and v33.ImprovedGarrote:IsAvailable() and v33.Garrote:CooldownUp() and ((v7:PMultiplier(v33.Garrote) <= (1181 - (1123 + 57))) or v83(v7, v33.Garrote)) and (v7:DebuffUp(v33.Deathmark) or (v33.Deathmark:CooldownRemains() < (4 + 0)))) then
		if v74() then
			v45 = v88(v33.Vanish);
			if v45 then
				return "Cast Vanish (Improved Garrote during Deathmark)" .. v45;
			end
		end
	end
end
local function v90()
	if not (v32.Commons.Enabled.Trinket1 or v32.Commons.Enabled.Trinket2) then
		return;
	end
	if v72(v34.AshesoftheEmbersoul) then
		if ((v7:DebuffUp(v33.Kingsbane) and (v7:DebuffRemains(v33.Kingsbane) <= (265 - (163 + 91)))) or v3.BossFilteredFightRemains("<", 1952 - (1869 + 61))) then
			if v18(v34.AshesoftheEmbersoul) then
				return "Ashes of the Embersoul";
			end
		end
	end
	if v72(v34.AlgetharPuzzleBox) then
		if ((v7:DebuffUp(v33.Rupture) and (v33.Deathmark:CooldownRemains() <= (1 + 1))) or v3.BossFilteredFightRemains("<", 77 - 55)) then
			if v18(v34.AlgetharPuzzleBox) then
				return "Algethar Puzzle Box";
			end
		end
	end
	if v72(v34.TreacherousTransmitter) then
		if ((v7:DebuffUp(v33.Rupture) and (v33.Deathmark:CooldownRemains() <= (2 - 0))) or v7:DebuffUp(v33.Deathmark) or v3.BossFilteredFightRemains("<", 4 + 18)) then
			if v18(v34.TreacherousTransmitter) then
				return "Treacherous Transmitter";
			end
		end
	end
	if v72(v34.MadQueensMandate) then
		if (((v33.Deathmark:CooldownRemains() >= (41 - 11)) and v7:DebuffDown(v33.Deathmark)) or v3.BossFilteredFightRemains("<=", 3 + 0)) then
			if v18(v34.MadQueensMandate) then
				return "Mad Queen's Mandate";
			end
		end
	end
	if v72(v34.ImperfectAscendancySerum) then
		if ((v7:DebuffUp(v33.Rupture) and (v33.Deathmark:CooldownRemains() <= (1476 - (1329 + 145)))) or v7:DebuffUp(v33.Deathmark) or v3.BossFilteredFightRemains("<", 993 - (140 + 831))) then
			if v18(v34.ImperfectAscendancySerum) then
				return "Imperfect Ascendancy Serum";
			end
		end
	end
	if (TrinketItem1:IsReady() and v32.Commons.Enabled.Trinket1) then
		if (not v6:IsItemBlacklisted(TrinketItem1) and not v14(v35, TrinketItem1:ID()) and (((v66 == (1851 - (1409 + 441))) and (v33.Deathmark:AnyDebuffUp() or v3.BossFilteredFightRemains("<", 738 - (15 + 703)))) or ((v66 == (1 + 1)) and ((not TrinketItem2:IsReady() and v7:DebuffUp(v33.Kingsbane)) or (not v33.Deathmark:AnyDebuffUp() and (v33.Deathmark:CooldownRemains() > (458 - (262 + 176))) and v7:DebuffUp(v33.Kingsbane)))) or (v66 == (1721 - (345 + 1376))))) then
			if v18(TrinketItem1) then
				return "Trinket 1";
			end
		end
	end
	if (TrinketItem2:IsReady() and v32.Commons.Enabled.Trinket2) then
		if (not v6:IsItemBlacklisted(TrinketItem2) and not v14(v35, TrinketItem2:ID()) and (((v66 == (690 - (198 + 490))) and (v33.Deathmark:AnyDebuffUp() or not v33.Deathmark:IsAvailable() or v3.BossFilteredFightRemains("<", 88 - 68))) or ((v66 == (2 - 1)) and (not TrinketItem1:IsReady() or (not v33.Deathmark:AnyDebuffUp() and (v33.Deathmark:CooldownRemains() > (1226 - (696 + 510)))))) or (v66 == (0 - 0)))) then
			if v18(TrinketItem2) then
				return "Trinket 2";
			end
		end
	end
end
local function v91()
	local v131 = v7:DebuffDown(v33.ShivDebuff) and v7:DebuffUp(v33.Garrote) and v7:DebuffUp(v33.Rupture) and (v43 <= (1267 - (1091 + 171)));
	local v132 = v33.Kingsbane:IsAvailable() and v6:BuffUp(v33.Envenom) and v131;
	if v33.Shiv:IsReady() then
		if (v33.ArterialPrecision:IsAvailable() and v131 and (v43 >= (1 + 3)) and v33.CrimsonTempest:AnyDebuffUp()) then
			if v18(v33.Shiv, true) then
				return "Cast Shiv (Arterial Precision)";
			end
		end
		if not v33.LightweightShiv:IsAvailable() then
			if (v132 and ((v7:DebuffUp(v33.Kingsbane) and (v7:DebuffRemains(v33.Kingsbane) < (25 - 17))) or (not v7:DebuffUp(v33.Kingsbane) and (v33.Kingsbane:CooldownRemains() >= (66 - 46)))) and (not v33.CrimsonTempest:IsAvailable() or v62 or v7:DebuffUp(v33.CrimsonTempest))) then
				if v18(v33.Shiv, true) then
					return "Cast Shiv (Kingsbane)";
				end
			end
		end
		if (v6:BuffUp(v33.DarkestNightBuff) and (v48 >= v67) and v6:BuffUp(v33.LingeringDarknessBuff)) then
			if v18(v33.Shiv, true) then
				return "Cast Shiv Darkest Night, Lingering Darkness";
			end
		end
		if v33.LightweightShiv:IsAvailable() then
			if (v132 and ((v7:DebuffUp(v33.Kingsbane) and (v7:DebuffRemains(v33.Kingsbane) < (382 - (123 + 251)))) or (v33.Kingsbane:CooldownRemains() <= (4 - 3)))) then
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
		if (not v33.Kingsbane:IsAvailable() and not v33.ArterialPrecision:IsAvailable() and v131 and (not v33.CrimsonTempest:IsAvailable() or v62 or v7:DebuffUp(v33.CrimsonTempest))) then
			if v18(v33.Shiv, true) then
				return "Cast Shiv no KB";
			end
		end
		if v3.BossFilteredFightRemains("<=", v33.Shiv:Charges() * (706 - (208 + 490))) then
			if v18(v33.Shiv, true) then
				return "Cast Shiv (End Fight)";
			end
		end
	end
end
local function v92()
	if v32.Commons.Enabled.Potions then
		local v151 = v29.PotionSelected();
		if (v151 and v151:IsReady() and (v6:BloodlustUp() or v3.BossFilteredFightRemains("<", 3 + 27) or v33.Deathmark:AnyDebuffUp())) then
			v15.CastMacro(2 + 1, nil, nil, v151);
			return "Cast Potion";
		end
	end
	if v33.Deathmark:AnyDebuffUp() then
		v45 = v86();
		if v45 then
			return v45;
		end
	end
end
local function v93()
	return (v15.CDsON() and v30.TTDCheck(v32.Assassination.TimeToDie.Cooldowns, v32.Commons.Enabled.IgnoreTtdOnBoss and v69, v7:TimeToDie())) or v7:DebuffUp(v33.Deathmark) or v7:DebuffUp(v33.Kingsbane);
end
local function v94()
	if not v40 then
		return;
	end
	local v133 = not v6:StealthUp(true, false) and (v6:BuffRemains(v33.SliceandDice) > (841 - (660 + 176))) and v7:DebuffUp(v33.Rupture) and (v6:BuffUp(v33.Envenom) or (v43 > (1 + 0))) and not v33.Deathmark:AnyDebuffUp() and (not v33.MasterAssassin:IsAvailable() or v7:DebuffUp(v33.Garrote)) and (not v33.Kingsbane:IsAvailable() or (v33.Kingsbane:CooldownRemains() <= (204 - (14 + 188))));
	if (v93() and (v32.Commons.Enabled.Trinket1 or v32.Commons.Enabled.Trinket2)) then
		v45 = v90();
		if v45 then
			return v45;
		end
	end
	if (v93() and v33.Deathmark:IsCastable()) then
		if ((v133 and (v7:TimeToDie() >= (685 - (534 + 141)))) or v3.BossFilteredFightRemains("<=", 9 + 11)) then
			if v18(v33.Deathmark, true) then
				return "Cast Deathmark";
			end
		end
	end
	v45 = v75() and v91();
	if v45 then
		return v45;
	end
	if (v75() and v33.Kingsbane:IsCastable()) then
		if (((v7:DebuffUp(v33.ShivDebuff) or (v33.Shiv:CooldownRemains() < (6 + 0))) and (v6:BuffUp(v33.Envenom) or (v43 > (1 + 0))) and ((v33.Deathmark:CooldownRemains() >= (105 - 55)) or v7:DebuffUp(v33.Deathmark) or (v133 and v33.Deathmark:IsReady()))) or v3.BossFilteredFightRemains("<=", 23 - 8)) then
			if v18(v33.Kingsbane, true) then
				return "Cast Kingsbane";
			end
		end
	end
	if ((v33.ThistleTea:IsCastable() and v6:BuffDown(v33.ThistleTea) and v7:DebuffUp(v33.Kingsbane) and (v7:DebuffRemains(v33.Kingsbane) < (22 - 14))) or (v6:BuffDown(v33.ThistleTea) and v7:DebuffUp(v33.Kingsbane) and (v7:DebuffRemains(v33.Kingsbane) <= (4 + 2))) or (v6:BuffDown(v33.ThistleTea) and v3.BossFilteredFightRemains("<", v33.ThistleTea:Charges() * (4 + 2)))) then
		if v18(v33.ThistleTea, true) then
			return "Cast Thistle Tea";
		end
	end
	if v93() then
		if v45 then
			v92();
		else
			v45 = v92();
			if v45 then
				return v45;
			end
		end
	end
	if (v93() and not v6:StealthUp(true, true) and (v77() <= (396 - (115 + 281)))) then
		if v45 then
			v89();
		else
			v45 = v89();
			if v45 then
				return v45;
			end
		end
	end
	if (v75() and v33.ColdBlood:IsReady() and v6:DebuffDown(v33.ColdBlood)) then
		if (v6:BuffDown(v33.EdgeCase) and (v33.Deathmark:CooldownRemains() > (23 - 13)) and v6:BuffDown(v33.DarkestNightBuff) and (v48 >= v67) and (v56 or (v7:DebuffStack(v33.AmplifyingPoisonDebuff) >= (17 + 3)) or not v62) and v6:BuffDown(v30.VanishBuffSpell()) and (not v33.Kingsbane:CooldownUp() or not v62) and (not v33.Deathmark:CooldownUp() or not v17())) then
			if v18(v33.ColdBlood, true) then
				return "Cast Cold Blood";
			end
		end
		return v45;
	end
end
local function v95(v134)
	return v83(v134, v33.Garrote) and (v134:PMultiplier(v33.Garrote) <= (2 - 1));
end
local function v96(v135)
	v54 = (14 - 10) + (v12(v33.DashingScoundrel:IsAvailable()) * (872 - (550 + 317))) + (v12(v61) * (8 - 2));
	return v83(v135, v33.Rupture, v50) and (v135:PMultiplier(v33.Rupture) <= (1 - 0)) and (v135:FilteredTimeToDie(">", v54, -v135:DebuffRemains(v33.Rupture)) or v135:TimeToDieIsNotValid());
end
local function v97()
	if (v33.Garrote:IsCastable() and (v49 >= (2 - 1))) then
		if (v95(v7) and v30.CanDoTUnit(v7, v53) and (v7:FilteredTimeToDie(">", 297 - (134 + 151), -v7:DebuffRemains(v33.Garrote)) or v7:TimeToDieIsNotValid())) then
			if v19(v33.Garrote) then
				return "Pool for Garrote (ST)";
			end
		end
	end
	if (v33.Rupture:IsReady() and (v48 >= v67) and (v6:BuffDown(v33.DarkestNightBuff) or (v33.CausticSpatter:IsAvailable() and not v7:DebuffUp(v33.CausticSpatterDebuff)))) then
		if (v96(v7) and v30.CanDoTUnit(v7, v52)) then
			if v19(v33.Rupture) then
				return "Cast Rupture";
			end
		end
	end
	if (v33.CrimsonTempest:IsReady() and (v48 >= v67) and v83(v7, v33.CrimsonTempest) and v6:BuffDown(v33.DarkestNightBuff) and not v33.AmplifyingPoison:IsAvailable() and v62) then
		if v18(v33.CrimsonTempest) then
			return "Crimson Tempest with Momentum of Despair";
		end
	end
end
local function v98()
	local v136 = v48 >= v67;
	if (v15.AoEON() and v33.CrimsonTempest:IsCastable() and (v43 >= (1667 - (970 + 695))) and v136) then
		for v158, v159 in v24(v42) do
			if (v83(v159, v33.CrimsonTempest, v51) and v159:FilteredTimeToDie(">", 11 - 5, -v159:DebuffRemains(v33.CrimsonTempest))) then
				if v18(v33.CrimsonTempest) then
					return "Cast Crimson Tempest (AoE High Energy)";
				end
			end
		end
	end
	if (v33.Garrote:IsCastable() and (v49 >= (1991 - (582 + 1408)))) then
		if (v95(v7) and not v61 and (v7:FilteredTimeToDie(">", 41 - 29, -v7:DebuffRemains(v33.Garrote)) or v7:TimeToDieIsNotValid())) then
			local v166 = v84(v33.Garrote, v95, 14 - 2, v42);
			if v166 then
				return v166;
			end
		end
	end
	if (v33.Rupture:IsReady() and v15.AoEON() and v136 and (v7:DebuffDown(v33.Kingsbane) or v6:BuffUp(v33.ColdBlood)) and not v61 and ((v33.ScentOfBlood:TalentRank() == (7 - 5)) or ((v33.ScentOfBlood:TalentRank() <= (1825 - (1195 + 629))) and (v6:BuffUp(v33.IndiscriminateCarnageBuff or (v7:TimeToDie() > (19 - 4)) or (v32.Commons.Enabled.IgnoreTtdOnBoss and v69) or v29.Buggedmobs[v7:NPCID()])))) and ((v7:TimeToDie() > ((248 - (187 + 54)) + (v12(v33.DashingScoundrel:IsAvailable()) * (785 - (162 + 618))) + (v12(v61) * (5 + 1)))) or (v32.Commons.Enabled.IgnoreTtdOnBoss and v69) or v29.Buggedmobs[v7:NPCID()]) and v6:BuffDown(v33.DarkestNightBuff)) then
		local v152 = v84(v33.Rupture, v96, v54, v42);
		if v152 then
			return v152;
		end
	end
	if (v33.Rupture:IsReady() and v136 and v6:BuffDown(v33.DarkestNightBuff) and v15.AoEON()) then
		v54 = 5 + 2 + (v12(v33.DashingScoundrel:IsAvailable()) * (10 - 5)) + (v12(v61) * (9 - 3));
		if ((not v7:DebuffUp(v33.Kingsbane or v6:BuffUp(v33.ColdBlood)) and v61) or not v63) then
			local v167 = v84(v33.Rupture, v96, v54, v44);
			if v167 then
				return v167;
			end
		end
	end
	if (v33.Garrote:IsReady() and (v49 >= (1 + 0)) and (v77() <= (1636 - (1373 + 263))) and ((v7:PMultiplier(v33.Garrote) <= (1001 - (451 + 549))) or ((v7:DebuffRemains(v33.Garrote) < v46) and (v43 >= (1 + 2)))) and (v7:DebuffRemains(v33.Garrote) < (v46 * (2 - 0))) and (v43 >= (4 - 1)) and (v7:FilteredTimeToDie(">", 1388 - (746 + 638), -v7:DebuffRemains(v33.Garrote)) or v7:TimeToDieIsNotValid())) then
		if v18(v33.Garrote) then
			return "Garrote (Fallback)";
		end
	end
	return false;
end
local function v99()
	local v137 = ((v48 < v67) and not v65) or v56 or not v62;
	local v138 = v33.CausticSpatter:IsAvailable() and v7:DebuffUp(v33.Rupture) and (not v7:DebuffUp(v33.CausticSpatterDebuff) or (v7:DebuffRemains(v33.CausticSpatterDebuff) <= (1 + 1))) and (v49 >= (1 - 0)) and not v62;
	if (v33.Mutilate:IsCastable() and v138) then
		if v19(v33.Mutilate) then
			return "Cast Mutilate (Caustic)";
		end
	end
	if ((v33.Ambush:IsCastable() or v33.AmbushOverride:IsReady()) and v6:StealthUp(true, true) and v138) then
		if v19(v33.Ambush) then
			return "Cast Ambush (Caustic)";
		end
	end
	if (v33.Envenom:IsCastable() and v6:BuffDown(v33.DarkestNightBuff) and (v48 >= v67) and (v56 or (v7:DebuffStack(v33.AmplifyingPoisonDebuff) >= (361 - (218 + 123))) or not v62) and v6:BuffDown(v30.VanishBuffSpell())) then
		if v18(v33.Envenom) then
			return "Cast Envenom 1";
		end
	end
	if (v33.Envenom:IsCastable() and v6:BuffUp(v33.DarkestNightBuff) and (v48 >= v30.CPMaxSpend())) then
		if v18(v33.Envenom) then
			return "Cast Envenom 2";
		end
	end
	if ((v33.Ambush:IsCastable() or v33.AmbushOverride:IsReady()) and v137 and (v6:BuffUp(v33.BlindsideBuff) or v6:StealthUp(true, false)) and (v7:DebuffDown(v33.Kingsbane) or v7:DebuffDown(v33.Deathmark) or v6:BuffUp(v33.BlindsideBuff))) then
		if v19(v33.Ambush, nil, not v39) then
			return "Cast Ambush";
		end
	end
	if (v33.FanofKnives:IsCastable() and v39) then
		if (v6:BuffUp(v33.DarkestNightBuff) and (v48 == (1587 - (1535 + 46)))) then
			if v19(v33.FanofKnives) then
				return "Cast Fan of Knives";
			end
		end
	end
	if v33.FanofKnives:IsCastable() then
		if ((v15.AoEON() and v137 and not v55 and (v43 >= ((3 + 0) - v12(v33.MomentumOfDespair and v33.ThrownPrecision)))) or (v6:BuffUp(v33.ClearTheWitnessesBuff) and not v33.ViciousVenoms:IsAvailable())) then
			if v19(v33.FanofKnives) then
				return "Cast Fan of Knives";
			end
		end
	end
	if (v15.AoEON() and v6:BuffUp(v33.DeadlyPoison) and v137 and (v43 >= ((1 + 2) - v12(v33.MomentumOfDespair:IsAvailable() and v33.ThrownPrecision:IsAvailable())))) then
		for v160, v161 in v24(v42) do
			if (not v161:DebuffUp(v33.DeadlyPoisonDebuff, true) and (not v55 or v161:DebuffUp(v33.Garrote) or v161:DebuffUp(v33.Rupture))) then
				if v19(v33.FanofKnives) then
					return "Cast Fan of Knives (DP Refresh)";
				end
			end
		end
	end
	if (v33.Mutilate:IsCastable() and v137 and (v43 == (562 - (306 + 254))) and v7:DebuffDown(v33.DeadlyPoisonDebuff, true) and v7:DebuffDown(v33.AmplifyingPoisonDebuff, true)) then
		local v153 = v7:GUID();
		if ((v7:DebuffUp(v33.Garrote) or v7:DebuffUp(v33.Rupture)) and not v7:DebuffUp(v33.DeadlyPoisonDebuff, true) and not v7:DebuffUp(v33.AmplifyingPoisonDebuff, true)) then
			v18(v33.Mutilate);
			return "Cast ReapplyDebuff Mutilate";
		end
		for v162, v163 in v24(v42) do
			if ((v163:GUID() ~= v153) and (v163:DebuffUp(v33.Garrote) or v163:DebuffUp(v33.Rupture)) and not v163:DebuffUp(v33.DeadlyPoisonDebuff, true) and not v163:DebuffUp(v33.AmplifyingPoisonDebuff, true)) then
				if ((v163:GUID() == v8:GUID()) and v163:IsInMeleeRange(v37)) then
					v15.CastTarget(v33.Mutilate, v15.TName().MOUSEOVER);
					return "Cast Mouseover Mutilate";
				else
					v21(v163, v33.Mutilate);
				end
				break;
			end
		end
	end
	if (v33.Mutilate:IsCastable() and v137) then
		if v19(v33.Mutilate) then
			return "Cast Mutilate Filler";
		end
	end
	return false;
end
local function v100()
	v29.HealthPotions();
	v37 = 1 + 4;
	v38 = 19 - 9;
	v39 = v7:IsInMeleeRange(v37);
	v40 = v7:IsInMeleeRange(v38);
	v68 = v3.BossFightRemains();
	v69 = true;
	if (v68 == (12578 - (899 + 568))) then
		v69 = false;
		v68 = v3.FightRemains(v41, false);
	end
	if v16() then
		v41 = v6:GetEnemiesInRange(20 + 10);
		v42 = v6:GetEnemiesInMeleeRange(v38);
		v43 = #v42;
		v44 = v6:GetEnemiesInMeleeRange(v37);
	else
		v41 = {};
		v42 = {};
		v43 = 2 - 1;
		v44 = {};
	end
	v46, v47 = (605 - (268 + 335)) * v6:SpellHaste(), (291 - (60 + 230)) * v6:SpellHaste();
	v48 = v30.EffectiveComboPoints(v6:ComboPoints());
	v49 = v6:ComboPointsMax() - v48;
	v50 = ((576 - (426 + 146)) + (v48 * (1 + 3))) * (1456.3 - (282 + 1174));
	v51 = ((815 - (569 + 242)) + (v48 * (5 - 3))) * (0.3 + 0);
	v52 = v33.Envenom:Damage() * v32.Assassination.EnvenomDMGOffset;
	v53 = v33.Mutilate:Damage() * v32.Assassination.MutilateDMGOffset;
	v55 = v80();
	v67 = v26(v6:ComboPointsMax() - (1026 - (706 + 318)), (1256 - (721 + 530)) * v22(v33.HandOfFate:IsAvailable()));
	v45 = v30.Defense();
	if v45 then
		return v45;
	end
	v45 = v30.Poisons();
	if v45 then
		return v45;
	end
	v67 = v26(v6:ComboPointsMax() - (1273 - (945 + 326)), (12 - 7) * v22(v33.HandOfFate:IsAvailable()));
	if not v6:AffectingCombat() then
		if not v6:BuffUp(v30.VanishBuffSpell()) then
			v45 = v30.Stealth(v30.StealthSpell());
			if v45 then
				return v45;
			end
		end
		if v30.CombatCheck() then
			if not v6:BuffUp(v33.SliceandDice) then
				if (v33.SliceandDice:IsReady() and (v48 >= (2 + 0))) then
					if v18(v33.SliceandDice) then
						return "Cast Slice and Dice";
					end
				end
			end
		end
	end
	if v30.CombatCheck() then
		if v15.ToggleIconFrame:GetToggle(703 - (271 + 429)) then
			v45 = v29.InterruptCycle(v33.Kick, v37, true, nil, false);
			if v45 then
				return v45;
			end
			v45 = v32.Interrupt.UseBlind and v29.IncorpCycle(v33.Blind, 14 + 1, true, nil, false);
			if v45 then
				return v45;
			end
			v45 = v32.Interrupt.UseBlind and v29.InterruptCycle(v33.Blind, 1515 - (1408 + 92), true, nil, true);
			if v45 then
				return v45;
			end
			if (v7:DebuffDown(v33.Deathmark) or v7:DebuffDown(v33.Kingsbane)) then
				v45 = v32.Interrupt.UseKidneyShot and (v48 > (1086 - (461 + 625))) and v29.InterruptCycle(v33.KidneyShot, v37, true, nil, true);
				if v45 then
					return v45;
				end
				v45 = v32.Interrupt.UseCheapShop and v6:StealthUp(true, true) and v29.InterruptCycle(v33.CheapShot, v37, true, nil, true);
				if v45 then
					return v45;
				end
			end
		end
		v45 = v32.Commons.Enabled.Shiv and v29.SootheCycle(v33.Shiv, 1297 - (993 + 295), false, v32.Commons.Enabled["Shiv Auto Target"]);
		if v45 then
			return v45;
		end
		v58 = v30.PoisonedBleeds();
		v59 = v6:EnergyRegen() + ((v58 * (1 + 5)) / ((1173 - (418 + 753)) * v6:SpellHaste()));
		v60 = v6:EnergyDeficit() / v59;
		v61 = v59 > (12 + 18);
		v56 = v81();
		v57 = v7:DebuffUp(v33.Deathmark) or v7:DebuffUp(v33.Kingsbane) or v7:DebuffUp(v33.Shiv);
		ClipEnvenom = v6:BuffUp(v33.Envenom);
		v64 = v6:EnergyPercentage() >= ((6 + 44) - ((3 + 7) * v33.ViciousVenoms:TalentRank()));
		AvoidTea = v6:Energy() > (11 + 29 + (579 - (406 + 123)) + ((1774 - (1749 + 20)) * v33.ViciousVenoms:TalentRank()));
		v65 = (v33.Kingsbane:CooldownRemains() < (1 + 2)) and not v33.Kingsbane:IsReady();
		v56 = v57 or (not v65 and v6:BuffUp(v33.DarkestNightBuff)) or v64 or v3.BossFilteredFightRemains("<=", 1342 - (1249 + 73));
		v63 = v82();
		v62 = v43 < (1 + 1);
		if v62 then
			if not v7:IsInRange(1170 - (466 + 679)) then
				return;
			end
		elseif (v43 == (2 - 1)) then
			return;
		end
		if (v75() and v33.ThistleTea:IsCastable() and not v6:BuffUp(v33.ThistleTea)) then
			if ((v7:DebuffUp(v33.Kingsbane) and (v7:DebuffRemains(v33.Kingsbane) < (22 - 14))) or (v6:BuffDown(v33.ThistleTea) and (v33.ThistleTea:Charges() >= (1902 - (106 + 1794))) and (v7:DebuffRemains(v33.ShivDebuff) > (2 + 4))) or (v6:BuffDown(v33.ThistleTea) and v3.BossFilteredFightRemains("<", v33.ThistleTea:Charges() * (2 + 4)))) then
				if v15.Cast(v33.ThistleTea, true) then
					return "Cast Thistle Tea";
				end
			end
		end
		if (v6:StealthUp(true, false) or (v78() > (0 - 0)) or (v77() > (0 - 0))) then
			v45 = v87();
			if v45 then
				return v45 .. " (Stealthed)";
			end
		end
		if not v6:BuffUp(v33.SliceandDice) then
			if (v33.SliceandDice:IsReady() and v7:DebuffUp(v33.Rupture) and (v6:ComboPoints() >= (115 - (4 + 110))) and (v6:BuffDown(v33.IndiscriminateCarnageBuff) or v62)) then
				if v18(v33.SliceandDice) then
					return "Cast Slice and Dice";
				end
			end
		elseif v40 then
			if (v33.Envenom:IsReady() and (v6:BuffRemains(v33.SliceandDice) < (589 - (57 + 527))) and (v6:ComboPoints() >= (1432 - (41 + 1386)))) then
				if v18(v33.Envenom) then
					return "Cast Envenom (CttC)";
				end
			end
		elseif (v33.PoisonedKnife:IsCastable() and v7:IsInRange(133 - (17 + 86)) and not v6:StealthUp(true, true) and (v43 == (0 + 0)) and (v6:EnergyTimeToMax() <= (v6:GCD() * (1.5 - 0)))) then
			if v18(v33.PoisonedKnife) then
				return "Cast Poisoned Knife";
			end
		end
		v45 = v94();
		if v45 then
			return v45;
		end
		v45 = v97();
		if v45 then
			return v45;
		end
		if (v15.AoEON() and not v62) then
			v45 = v98();
			if v45 then
				return v45;
			end
		end
		v45 = v99();
		if v45 then
			return v45;
		end
		if (v93() and v32.Commons.Enabled.Racials) then
			if (v33.ArcaneTorrent:IsCastable() and v39 and (v6:EnergyDeficit() >= ((43 - 28) + v59))) then
				if v18(v33.ArcaneTorrent, true) then
					return "Cast Arcane Torrent";
				end
			end
			if (v33.ArcanePulse:IsCastable() and v39) then
				if v18(v33.ArcanePulse, true) then
					return "Cast Arcane Pulse";
				end
			end
			if (v33.LightsJudgment:IsCastable() and v39) then
				if v18(v33.LightsJudgment, true) then
					return "Cast Lights Judgment";
				end
			end
			if (v33.BagofTricks:IsCastable() and v39) then
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
local function v101()
	v33.Deathmark:RegisterAuraTracking();
	v33.Sepsis:RegisterAuraTracking();
	v33.Garrote:RegisterAuraTracking();
	v33.CrimsonTempest:RegisterAuraTracking();
	v32.Assassination.Display();
	v29.PostInitialMessage(425 - (122 + 44));
end
v15.SetAPL(446 - 187, v100, v101);
