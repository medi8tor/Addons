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
local v13 = v12.Cast;
local v14 = v12.AoEON;
local v15 = v12.CDsON;
local v16 = v12.Commons().Everyone.num;
local v17 = v12.Commons().Everyone.bool;
local v18 = math.min;
local v19 = GetWeaponEnchantInfo;
local v20 = math.floor;
local v21 = GetTotemInfo;
local v22 = GetTime;
local v23 = v9.Shaman.Restoration;
local v24 = v11.Shaman.Restoration;
local v25 = {v24.ScreamingBlackDragonScale:ID(),v24.BroodkeepersPromise:ID()};
local v26 = v12.GUISettingsGet();
local v27 = v12.Commons().Everyone;
local v28 = v12.Commons().Shaman;
local v29 = {General=v26.General,Commons=v26.APL.Shaman.Commons,Resto=v26.APL.Shaman.Restoration,Cooldowns=v26.APL.Shaman.Restoration.Cooldowns,AoE=((not v6:IsInRaid() and v26.APL.Shaman.Restoration.AoE) or v26.APL.Shaman.Restoration.RaidAoE),Healing=((not v6:IsInRaid() and v26.APL.Shaman.Restoration.Healing) or v26.APL.Shaman.Restoration.RaidHealing)};
local v30;
local v31;
v3:RegisterForEvent(function()
	v23.LavaBurst:RegisterInFlight();
end, "LEARNED_SPELL_IN_TAB");
v23.LavaBurst:RegisterInFlight();
local function v32(v77)
	return (v77:NPCID() == (394654 - 190205)) or (v77:NPCID() == (536968 - 328509)) or (v77:NPCID() == (209080 - (555 + 64))) or (v77:NPCID() == (208731 - (857 + 74))) or (v77:NPCID() == (195214 - (367 + 201))) or (v77:NPCID() == (213517 - (214 + 713)));
end
local function v33()
	return v32(v8) and not v6:CanAttack(v8);
end
local v34;
local v35;
local v36;
local v37;
local v38;
local v39;
local v40;
local v41;
local function v42(v78)
	return v78:NPCID() == (51258 + 153515);
end
local function v43(v79)
	return v79:NPCID() == (32172 + 172388);
end
local function v44(v80)
	for v103 = 878 - (282 + 595), 1641 - (1523 + 114) do
		local v104, v105, v106, v107 = v21(v103);
		if (v105 == v80:Name()) then
			return (v20(((v106 + v107) - v22()) + 0.5 + 0)) or (0 - 0);
		end
	end
	return 1065 - (68 + 997);
end
local function v45(v81)
	if (v81 == nil) then
		return nil;
	end
	local v82 = v81:IsCastable() and v81:IsReady();
	local v83 = v6:BuffUp(v23.SpiritwalkersGraceBuff) or not v6:IsMoving();
	if ((v81 == v23.LightningBolt) or (v81 == v23.ChainLightning) or (v81 == v23.HealingRain) or (v81 == v23.HealingWave) or (v81 == v23.HealingSurge) or (v81 == v23.Wellspring)) then
		return v82 and v83;
	elseif (v81 == v23.LavaBurst) then
		local v112 = v6:BuffUp(v23.LavaSurge);
		local v113 = not v6:IsCasting(v23.LavaBurst) and (v23.LavaBurst:Charges() >= (1271 - (226 + 1044)));
		local v114 = v6:IsCasting(v23.LavaBurst) and (v23.LavaBurst:Charges() == (8 - 6));
		return v82 and (v83 or v6:BuffUp(v23.LavaSurge)) and (v112 or v113 or v114);
	else
		return v82;
	end
end
local function v46(v84, v85, v86, v87, v88)
	local v89, v90, v91 = v6:GetUseableItems(v25, 130 - (32 + 85));
	if (v89 and v27.AoELogic(v84, v85, v88)) then
		if v13(v89) then
			return "trinket1 trinkets 2";
		end
	end
	local v92, v90, v93 = v6:GetUseableItems(v25, 14 + 0);
	if (v92 and v27.AoELogic(v86, v87, v88)) then
		if v13(v92) then
			return "trinket2 trinkets 4";
		end
	end
end
local function v47()
	local v94, v95, v96, v96, v97, v98 = v19();
	if (v23.WaterShield:IsCastable() and v6:BuffDown(v23.WaterShield)) then
		v12.Cast(v23.WaterShield);
		return "Water Shield";
	end
	if (v23.ElementalOrbit:IsAvailable() and v23.EarthShield:IsCastable() and v6:BuffDown(v23.EarthShieldT)) then
		v6:Cast(v23.EarthShield);
		return "Earth shield on self for Orbit";
	end
	if v29.Resto.EarthlivingWeapon then
		if ((not v94 or (v95 < (133054 + 466946))) and v23.EarthlivingWeapon:IsCastable()) then
			if v13(v23.EarthlivingWeapon) then
				return "Earthliving Weapon enchant";
			end
		end
	end
	if ((v29.Commons.AutoWolf == "always") or ((v29.Commons.AutoWolf == "Only in Combat") and v6:AffectingCombat()) or ((v29.Commons.AutoWolf == "Only out of combat") and not v6:AffectingCombat())) then
		if (v6:IsMoving() and not v6:IsMounted() and v6:BuffDown(v23.GhostWolf)) then
			v13(v23.GhostWolf);
			return "Ghost Wolf";
		end
	end
end
local v48 = v27.converArrayToList({(1045990 - 607517),(805706 - 366827),(449027 - (67 + 113)),(631777 - 374451),(1083886 - 811175),(1182919 - 743554),(319454 + 119423),(1277669 - 826447),(573725 - 137479),(999294 - 558826),(56485 + 268424),(318050 + 2564),(856889 - 584227),(1040887 - 770297),(859744 - 590478),(795261 - 345817),(438925 - (44 + 386))});
local v49 = v27.converArrayToList({(139934 + 300534),(447489 - (201 + 571)),(1836900 - 1395684),(1597297 - 1159764),(440200 - (814 + 45)),(24308 + 426794),(433002 - (261 + 624)),(435332 - (1020 + 60)),(1446370 - 1019544),(176788 + 272100),(435840 - (760 + 987)),(457517 - (745 + 21)),(1243575 - 791636),(3695 + 448176),(453020 - (87 + 968)),(417426 + 42666),(328810 - (447 + 966)),(322413 - (1703 + 114)),(744731 - 290292),(122466 + 306069),(425988 - (9 + 5)),(430144 - (243 + 1022)),(383619 + 81393),(345701 + 79178),(441507 - (1869 + 61)),(1561991 - 1118497),(57927 + 365397),(401378 + 25951),(324120 - (140 + 831)),(322387 - (15 + 703)),(323052 - (262 + 176)),(322509 - (198 + 490)),(774192 - 451436),(702886 - 367745),(53665 + 279820),(1106438 - 772805),(1598779 - 1277025),(39086 + 424096),(458500 - (660 + 176)),(450297 - (14 + 188)),(180939 + 269138),(432116 + 17328),(704120 - 260613),(242295 + 208927),(427130 - (115 + 281)),(359870 + 74785),(1612629 - 1172837),(616590 - 189819),(1200025 - 770598)});
local function v50()
	local v99 = v6:GetEnemiesInRange(325 - (134 + 151));
	for v108, v109 in pairs(v99) do
		if v48[v109:CastSpellID() or v109:ChannelSpellID()] then
			return true;
		end
	end
end
local function v51()
	local v100 = v6:GetEnemiesInRange(1705 - (970 + 695));
	for v110, v111 in pairs(v100) do
		if v49[v111:CastSpellID() or v111:ChannelSpellID()] then
			return true;
		end
	end
end
local v52 = nil;
local function v53()
	if v6:IsMoving() then
		if not v52 then
			v52 = v22();
		end
		return v22() - v52;
	else
		if v52 then
			v52 = nil;
		end
		return 0 - 0;
	end
end
local v54 = v9(442303 - (582 + 1408));
local v55, v56, v57, v58, v59, v60;
local v61, v62, v63, v64, v65;
local v66, v67, v68, v69, v70, v71, v72;
local function v73()
	v29.AoE = (not v6:IsInRaid() and v26.APL.Shaman.Restoration.AoE) or v26.APL.Shaman.Restoration.RaidAoE;
	v29.Healing = (not v6:IsInRaid() and v26.APL.Shaman.Restoration.Healing) or v26.APL.Shaman.Restoration.RaidHealing;
	v61 = v12.ToggleIconFrame:GetToggle(3 - 2);
	v62 = v12.ToggleIconFrame:GetToggle(2 - 0);
	v63 = v12.ToggleIconFrame:GetToggle(11 - 8);
	v64 = v12.ToggleIconFrame:GetToggle(1828 - (1195 + 629));
	v72 = v12.ToggleIconFrame:GetToggle(6 - 1);
	v30 = v27.UnitsinRange(v23.HealingSurge);
	if v14() then
		v31 = (v8:IsDummy() and #(v6:GetEnemiesInRange(281 - (187 + 54)))) or ((v8:GetEnemiesInSplashRangeCount(788 - (162 + 618)) > (1 + 0)) and v8:GetEnemiesInSplashRangeCount(6 + 2)) or #(v6:GetEnemiesInRange(85 - 45));
	else
		v31 = 1 - 0;
	end
	if (v23.PoisonCleansingTotem:IsAvailable() and v23.PoisonCleansingTotem:IsReady()) then
		v65 = v27.DebuffCount(v30, v54);
	else
		v65 = 0 + 0;
	end
	v55, v56 = v27.GetLowestHealthUnit(v30);
	if v56 then
		v67 = v56:HealthPercentage();
		v68 = math.min(v67 + v56:IncomingHeals(), 1736 - (1373 + 263));
	else
		v67 = 1100 - (451 + 549);
		v68 = 32 + 68;
	end
	if v55 then
		v57 = v55:HealthPercentageWeighted();
		v69 = v55:HealthPercentage();
		v70 = math.min(v57 + v55:IncomingHeals(), 155 - 55);
		v71 = math.min(v69 + v55:IncomingHeals(), 168 - 68);
	else
		v57 = 1484 - (746 + 638);
		v69 = 38 + 62;
		v70 = 151 - 51;
		v71 = 441 - (218 + 123);
	end
	v58 = v27.GetLowestHealthUnitWithoutBuff(v30, v23.Riptide);
	v59 = ((v29.Healing.WhichUndulation == "Healing Surge") and v23.HealingSurge) or v23.HealingWave;
	v60 = not v6:IsMoving() or v6:BuffUp(v23.SpiritwalkersGrace);
end
local function v74()
	if ((v57 >= (1626 - (1535 + 46))) and v42(v8) and (v23.PurifySpirit:CooldownDown() or not v23.ImprovedPurifySpirit:IsAvailable()) and v8:IsSpellInRange(v23.Riptide)) then
		if (v23.HealingSurge:IsReady() and v60) then
			v13(v23.HealingSurge);
			return;
		end
	end
	if ((v57 >= (35 + 0)) and v33() and (v8:HealthPercentage() > (0 + 0)) and (v8:HealthPercentage() < (660 - (306 + 254)))) then
		if (v8:BuffDown(v23.Riptide) and v23.Riptide:IsReady()) then
			v13(v23.Riptide);
			return;
		end
		if (v23.HealingSurge:IsReady() and v60) then
			v13(v23.HealingSurge);
			return;
		end
	end
	if (v6:IsMoving() and v23.SpiritwalkersGrace:IsReady() and v29.Resto.SpiritwalkersGrace and (v53() > (1 + 0))) then
		v13(v23.SpiritwalkersGrace);
		return "SWG";
	end
	if ((v29.Commons.AutoWolf == "always") or ((v29.Commons.AutoWolf == "Only in Combat") and v6:AffectingCombat()) or ((v29.Commons.AutoWolf == "Only out of combat") and not v6:AffectingCombat())) then
		if (v6:IsMoving() and not v6:IsMounted() and v6:BuffDown(v23.GhostWolf) and not v6:AffectingCombat()) then
			v13(v23.GhostWolf);
			return "Ghost Wolf";
		end
		if (v6:IsMoving() and not v6:IsMounted() and v6:BuffDown(v23.GhostWolf) and v6:AffectingCombat() and (v53() > (3 - 1))) then
			v13(v23.GhostWolf);
			return "Ghost Wolf";
		end
	end
	if (v23.WaterShield:IsReady() and v6:BuffDown(v23.WaterShield)) then
		v12.Cast(v23.WaterShield);
		return "Water Shield";
	end
	if ((v57 >= (1497 - (899 + 568))) and (v6:HealthPercentage() >= (47 + 23))) then
		if (v23.ElementalOrbit:IsAvailable() and v23.EarthShield:IsCastable() and v6:BuffDown(v23.EarthShieldT)) then
			v6:Cast(v23.EarthShield);
			return "Earth shield on self for Orbit";
		end
	end
	if (v23.AstralShift:IsReady() and (v29.Resto.AstralShiftHP > (0 - 0)) and ((v6:HealthPercentage() <= v29.Resto.AstralShiftHP) or v51() or v50())) then
		v12.Cast(v23.AstralShift);
		return "Astral Shift Per Settings";
	end
	if v29.Resto.TotemRecall then
		if (v23.TotemicRecall:IsReady() and ((v23.CloudburstTotem:IsAvailable() and v23.CloudburstTotem:CooldownDown()) or (v23.EarthenWallTotem:IsAvailable() and v23.EarthenWallTotem:CooldownDown()) or (v23.HealingStreamTotem:IsAvailable() and v23.HealingStreamTotem:CooldownDown()))) then
			v12.Cast(v23.TotemicRecall);
			return "Totem Recall";
		end
	end
	if v23.Downpour:IsReady() then
		v12.Cast(v23.Downpour);
		return "Downpour";
	end
	if (v72 and (v6:IsInParty() or v6:IsInRaid())) then
		if (v57 <= (633 - (268 + 335))) then
			v12.CastMacro(292 - (60 + 230), true);
		end
	end
	if (v23.Ascendance:IsReady() and v27.AoELogicWithCount(v29.AoE.AscendanceHP, v29.AoE.AscendanceCount, v29.Cooldowns.UseAscendance, v30)) then
		v12.Cast(v23.Ascendance);
		return "Ascendance Cast";
	end
	if (v6:BuffUp(v23.NaturesSwiftness) and v59:IsReady()) then
		v55:Cast(v59);
		return "NS Buff Spell Cast";
	end
	if (v23.NaturesSwiftness:IsReady() and v6:AffectingCombat() and (v57 <= v29.Healing.NSHP)) then
		v12.CastTarget(v23.NaturesSwiftness, v12.TName().PLAYER, true);
		return "NS Actual Cast";
	end
	if (v23.AncestralSwiftness:IsReady() and v6:AffectingCombat() and (v57 <= v29.Healing.NSHP)) then
		v12.CastTarget(v23.AncestralSwiftness, v12.TName().PLAYER, true);
		return "AS Actual Cast";
	end
	if (v23.AncestralGuidance:IsReady() and v6:AffectingCombat() and v27.AoELogicWithCount(v29.AoE.AGHP, v29.AoE.AGCount, v29.Cooldowns.UseAG, v30)) then
		v12.Cast(v23.AncestralGuidance);
		return "Ancestral Guidance";
	end
	if (v23.EarthElemental:IsReady() and v6:AffectingCombat() and ((((v29.Cooldowns.EarthEle == "With Logic") or ((v29.Cooldowns.EarthEle == "With Cooldowns and Logic") and v15)) and (v6:HealthPercentage() <= (597 - (426 + 146)))) or (v15 and (v29.Cooldowns.EarthEle == "With Cooldowns")))) then
		v12.CastTarget(v23.EarthElemental, v12.TName().PLAYER);
		return "Earth Elemental";
	end
	if (v23.SpiritLinkTotem:IsReady() and v6:AffectingCombat() and v27.AoELogicWithCount(v29.AoE.SpiritLinkHP, v29.AoE.SpiritLinkCount, "With Logic", v30)) then
		v12.Cast(v23.SpiritLinkTotem);
		return "SpiritLinkTotem Casted to be Placed";
	end
	if (v23.HealingTideTotem:IsReady() and v27.AoELogicWithCount(v29.AoE.HealingTideHP, v29.AoE.HealingTideCount, "With Logic", v30)) then
		v12.Cast(v23.HealingTideTotem);
		return "Healing Tide Totem";
	end
	if v23.StoneBulkwarkTotem:IsReady() then
		if (v51() or v50()) then
			v13(v23.StoneBulkwarkTotem);
			return "Stone Bulkwark Totem";
		end
	end
	if ((v8:NPCID() == (11389 + 83683)) and not v8:IsDeadOrGhost()) then
		if (v23.Riptide:IsReady() and v8:BuffDown(v23.Riptide)) then
			v12.Cast(v23.Riptide);
			return "Riptide on Ele";
		end
		if (v23.HealingWave:IsReady() and (v8:HealthPercentage() <= (1546 - (282 + 1174))) and v60) then
			v12.Cast(v23.HealingWave);
			return "Healing Wave on Ele";
		end
	end
	if not v72 then
		if (v23.ChainHeal:IsReady() and v6:BuffUp(v23.Hightide) and v27.AoELogicWithCount(v29.AoE.ChainHealHighTideHP, v29.AoE.ChainHealHighTideCount, "With Logic", v30) and v60) then
			v55:Cast(v23.ChainHeal);
			return " Chain Heal with High Tide";
		end
		if (v23.UnleashLife:IsReady() and (v57 <= v29.Healing.UnleashLifeHP)) then
			v55:Cast(v23.UnleashLife);
			return "Unleash Life";
		end
		if (v23.Wellspring:IsReady() and v60 and v27.AoELogicWithCount(v29.AoE.WellspringHP, v29.AoE.WellspringCount, "With Logic", v30)) then
			v12.Cast(v23.Wellspring);
			return "Well Spring Cast";
		end
		if ((v70 <= (831 - (569 + 242))) and (v27.GetAverageGroupHealthPercent(v30) >= (100 - 65)) and v23.NaturesSwiftness:CooldownUp() and not v6:IsInRaid()) then
			if (v23.HealingSurge:IsReady() and v6:BuffDown(v23.PrimordialWave) and (v70 <= v29.Healing.HealingSurgeHP) and v60) then
				v55:Cast(v23.HealingSurge);
				return "Healing Surge when someone to low";
			end
			if (v23.HealingWave:IsReady() and v6:BuffDown(v23.PrimordialWave) and (v70 <= v29.Healing.HealingWaveHP) and v60) then
				v55:Cast(v23.HealingWave);
				return "Healing Surge when someone to low";
			end
		end
		if (v70 >= (2 + 28)) then
			if (v56 ~= nil) then
				if (v23.EarthShield:IsReady() and v56:BuffDown(v23.EarthShield) and (v27.BuffCount(v30, v23.EarthShield) < (1025 - (706 + 318)))) then
					v56:Cast(v23.EarthShield);
					return "Earth Shield Casted";
				end
			end
		end
		if (v58 ~= nil) then
			if (v23.PrimordialWave:IsReady() and (v58:HealthPercentage() <= v29.Healing.PrimordiaWaveHP) and (v27.BuffCount(v30, v23.Riptide) >= (1253 - (721 + 530)))) then
				v58:Cast(v23.PrimordialWave);
				return " PrimordialWave on Unit w/o Riptide";
			end
		elseif (v23.PrimordialWave:IsReady() and (v55:HealthPercentage() <= v29.Healing.PrimordiaWaveHP) and (v27.BuffCount(v30, v23.Riptide) >= (1273 - (945 + 326)))) then
			v55:Cast(v23.PrimordialWave);
			return " PrimordialWave on Unit w/o Riptide";
		end
		if (v6:BuffUp(v23.PrimordialWaveBuff) and v23.HealingWave:IsReady() and v60 and (v57 <= (174 - 104)) and ((v27.BuffCount(v30, v23.Riptide) >= (3 + 0)) or (v6:BuffRemains(v23.PrimordialWaveBuff) <= (702 - (271 + 429))))) then
			v55:Cast(v23.HealingWave);
			return "Healing Wave due to PW and RT Buffs";
		end
		if (v56 ~= nil) then
			if (v23.Riptide:IsReady() and (v23.Riptide:Charges() > (0 + 0)) and v56:BuffDown(v23.Riptide) and (v56:HealthPercentage() <= v29.Healing.RiptideHP)) then
				v56:Cast(v23.Riptide);
				return "Riptide on Lowest Tank W/O Riptide";
			end
		end
		if (v58 ~= nil) then
			if (v23.Riptide:IsReady() and (v23.Riptide:Charges() > (1500 - (1408 + 92))) and (v58:HealthPercentage() <= v29.Healing.RiptideHP)) then
				v58:Cast(v23.Riptide);
				return "Riptide on Lowest Tank W/O Riptide";
			end
		end
		if (v23.CloudburstTotem:IsReady() and v23.CloudburstTotem:IsAvailable() and (v44(v23.CloudburstTotem) <= (1086 - (461 + 625))) and v27.AoELogicWithCount(v29.AoE.CloudBurstHP, v29.AoE.CloudBurstCount, "With Logic", v30)) then
			v12.CastTarget(v23.CloudburstTotem, v12.TName().PLAYER);
			return "Cloud Burst Totem";
		end
		if (v23.CloudburstTotem:IsAvailable() and (v44(v23.CloudburstTotem) > (1288 - (993 + 295))) and ((v27.AoELogicWithCount(v29.AoE.CloudBurstRecastHP, v29.AoE.CloudBurstRecastCount, "With Logic", v30) and (v44(v23.CloudburstTotem) < (1 + 9))) or (v44(v23.CloudburstTotem) < (1174 - (418 + 753))))) then
			v12.CastTarget(v23.CloudburstTotem, v12.TName().PLAYER);
			return "Cloud Burst Totem Recast";
		end
		if (v23.ChainHeal:IsReady() and (v6:BuffUp(v23.Tidebringer) or v6:BuffUp(v23.TidalWaves)) and (v27.AoELogicWithCount(v29.AoE.ChainHealHP, v29.AoE.ChainHealCount, "With Logic", v30) or v6:BuffUp(v23.UnleashLife)) and v60) then
			v55:Cast(v23.ChainHeal);
			return "Chain Heal";
		end
		if (v23.ManaTideTotem:IsReady() and (v6:ManaPercentage() <= v29.Healing.ManaTideMP)) then
			v12.Cast(v23.ManaTideTotem);
			return "Mana Tide Totem";
		end
		if (v23.UnleashLife:IsReady() and v6:BuffUp(v23.Hightide) and (v57 <= v29.Healing.UnleashLifeHP)) then
			v55:Cast(v23.UnleashLife);
			return "Unleash Life";
		end
		if (v64 and v6:AffectingCombat()) then
			if (v23.SurgingTotem:IsReady() and not v6:PrevGCD(1 + 0, v23.SurgingTotem) and (v27.AoELogicWithCount(v29.AoE.HealingRainHP, v29.AoE.HealingRainCount, "With Logic", v30) or (v23.AcidRain:IsAvailable() and v27.TargetIsValid()))) then
				v12.Cast(v23.SurgingTotem);
				return "Surging Totem Casted to be Placed";
			end
			if (v23.HealingRain:IsReady() and not v6:PrevGCD(1 + 0, v23.HealingRain) and (v27.AoELogicWithCount(v29.AoE.HealingRainHP, v29.AoE.HealingRainCount, "With Logic", v30) or (v23.AcidRain:IsAvailable() and v27.TargetIsValid())) and v60) then
				v12.Cast(v23.HealingRain);
				return "Healing Rain Casted to be Placed";
			end
		end
		if (v23.HealingStreamTotem:IsReady() and v23.HealingStreamTotem:IsAvailable() and ((v44(v23.HealingStreamTotem) <= (0 + 0)) or ((v44(v23.HealingStreamTotem) < (2 + 3)) and (v23.HealingStreamTotem:Charges() >= (530 - (406 + 123))) and (v27.GetAverageGroupHealthPercent(v30) <= (1814 - (1749 + 20))))) and v27.AoELogicWithCount(v29.AoE.CloudBurstHP, v29.AoE.CloudBurstCount, "With Logic", v30)) then
			v12.Cast(v23.HealingStreamTotem);
			return "Healing Stream Totem";
		end
		if (v23.EarthenWallTotem:IsReady() and v6:AffectingCombat() and v27.AoELogicWithCount(v29.AoE.EarthenWallHP, v29.AoE.EarthenWallCount, "With Logic", v30)) then
			v12.Cast(v23.EarthenWallTotem);
			return "EarthenWallTotem Casted to be Placed";
		end
		if (v23.ChainHeal:IsReady() and (v27.AoELogicWithCount(v29.AoE.ChainHealHP, v29.AoE.ChainHealCount, "With Logic", v30) or v6:BuffUp(v23.UnleashLife)) and v60) then
			v55:Cast(v23.ChainHeal);
			return "Chain Heal";
		end
		if (v59:IsReady() and v6:BuffUp(v23.Undulation) and (v70 <= v29.Healing.NSHP) and v60) then
			v55:Cast(v59);
			return "Undlation Spell Cast";
		end
		if (v56 ~= nil) then
			if (v23.HealingSurge:IsReady() and v6:BuffDown(v23.PrimordialWave) and (v56:HealthPercentage() <= v29.Healing.HealingSurgeTankHP) and v60) then
				v56:Cast(v23.HealingSurge);
				return "Healing Surge when someone to low";
			end
			if (v23.HealingWave:IsReady() and v6:BuffDown(v23.PrimordialWave) and (v56:HealthPercentage() <= v29.Healing.HealingWaveTankHP) and v60) then
				v56:Cast(v23.HealingWave);
				return "Healing Surge when someone to low";
			end
		end
		if (v23.HealingSurge:IsReady() and v6:BuffDown(v23.PrimordialWave) and (v70 <= v29.Healing.HealingSurgeHP) and v60) then
			v55:Cast(v23.HealingSurge);
			return "Healing Surge when someone to low";
		end
		if (v23.HealingWave:IsReady() and v6:BuffDown(v23.PrimordialWave) and (v70 <= v29.Healing.HealingWaveHP) and v60) then
			v55:Cast(v23.HealingWave);
			return "Healing Surge when someone to low";
		end
	end
	if (v27.TargetIsValid() and (v6:AffectingCombat() or (v29.Resto.AttackOOC and v61)) and ((v57 >= (9 + 26)) or v72) and not v43(v8)) then
		if (v23.StormKeeper:IsReady() and ((v29.Cooldowns.Stormkeeper == "With Logic") or ((v29.Cooldowns.Stormkeeper == "With Cooldowns and Logic") and v15) or ((v29.Cooldowns.Stormkeeper == "With Cooldowns") and v15)) and v60) then
			v12.Cast(v23.StormKeeper);
			return "Storm Keeper";
		end
		if (v8:AffectingCombat() and v6:BuffUp(v23.StormKeeper)) then
			if (v14 and (v31 >= (1324 - (1249 + 73)))) then
				if (v23.ChainLightning:IsReady() and v60 and v8:IsSpellInRange(v23.ChainLightning)) then
					v12.Cast(v23.ChainLightning);
					return "Chain Lighting";
				end
			elseif (v23.LightningBolt and v60 and v8:IsSpellInRange(v23.LightningBolt)) then
				v12.Cast(v23.LightningBolt);
				return "Lighting Bolt";
			end
		end
		if (v14 and (v31 >= (1 + 1))) then
			if (v23.ChainLightning:IsReady() and v60 and v8:IsSpellInRange(v23.ChainLightning)) then
				v12.Cast(v23.ChainLightning);
				return "Chain Lighting AoE Spam";
			end
		end
		if (v23.FlameShock:IsReady() and v8:AffectingCombat() and v8:IsSpellInRange(v23.FlameShock) and v8:DebuffRefreshable(v23.FlameShock)) then
			v12.Cast(v23.FlameShock);
			return "Flame Shock";
		end
		if v45(v23.LavaBurst) then
			v12.Cast(v23.LavaBurst);
			return "Lava Burst Cast";
		end
		if (v14 and (v31 >= (1147 - (466 + 679)))) then
			if (v23.ChainLightning:IsReady() and v60 and v8:IsSpellInRange(v23.ChainLightning)) then
				v12.Cast(v23.ChainLightning);
				return "Chain Lighting";
			end
		elseif (v23.LightningBolt and v60 and v8:IsSpellInRange(v23.LightningBolt)) then
			v12.Cast(v23.LightningBolt);
			return "Lighting Bolt";
		end
	end
end
local function v75()
	if v27.ShouldStopCastUpdate() then
		v12.CastMacro(14 - 8, true);
		return "Stop Cast For Silence";
	end
	v53();
	if (v23.SkyFury:IsReady() and (v6:Level() >= (45 - 29)) and not v6:DebuffUp(v23.Corruption) and ((v27.GroupBuffMissing(v23.SkyFuryBuff) and (v29.Commons.SkyFury == "check whole group") and (v6:IsInRaidArea() or v6:IsInDungeonArea())) or (v6:BuffDown(v23.SkyFuryBuff, true) and ((v29.Commons.SkyFury == "only check us") or (v29.Commons.SkyFury == "check whole group")))) and not v6:IsMounted()) then
		if v12.CastTarget(v23.SkyFury, v12.TName().PLAYER) then
			return "SkyFury";
		end
	end
	if (not v6:IsMounted() and not v6:IsChanneling() and (v27.TargetIsValid() or v6:AffectingCombat() or v61)) then
		if (not v6:AffectingCombat() or v61) then
			v66 = v47();
			if v66 then
				return v66;
			end
		end
		if v6:AffectingCombat() then
			if (v63 and v23.WindShear:IsReady()) then
				v66 = v27.InterruptCycle(v23.WindShear, 1930 - (106 + 1794), true, nil, false);
				if v66 then
					return v66;
				end
			end
			if v23.Purge:IsReady() then
				v66 = v27.PurgeCycle(v23.Purge, 13 + 27, false, v29.Commons.TabForPurge);
				if v66 then
					return v66;
				end
			end
			if (v23.Hex:IsReady() and v6:AffectingCombat()) then
				v66 = v27.IncorpCycle(v23.Hex, 11 + 29, false, false);
				if v66 then
					return v66;
				end
			end
			if (v62 and not v6:IsInRaid() and v23.PurifySpirit:IsReady()) then
				v66 = v27.DispelCycle(v23.PurifySpirit, "Magic", nil, v30);
				if v66 then
					return v66;
				end
				if v23.ImprovedPurifySpirit:IsAvailable() then
					v66 = v27.AfflictedLogic(v23.PurifySpirit);
					if v66 then
						return v66;
					end
					v66 = v27.DispelCycle(v23.PurifySpirit, "Curse", nil, v30);
					if v66 then
						return v66;
					end
				end
				if (v23.PoisonCleansingTotem:IsAvailable() and v23.PoisonCleansingTotem:IsReady()) then
					if v27.DispelCycle(v23.PoisonCleansingTotem, "Poison", nil, v30) then
						return v12.CastTarget(v23.PoisonCleansingTotem, v12.TName().PLAYER);
					end
					if ((v65 > (2 - 1)) or (v23.PurifySpirit:CooldownDown() and (v65 > (0 - 0)))) then
						return v12.CastTarget(v23.PoisonCleansingTotem, v12.TName().PLAYER);
					end
				end
			end
			if (v62 and v6:IsInRaid() and v23.PurifySpirit:IsReady()) then
				v66 = v27.DispelCycle(v23.PurifySpirit, "Raid", nil, v30);
				if v66 then
					return v66;
				end
			end
		end
		v66 = v46(v29.Cooldowns.Trinket1HP, v29.Cooldowns.Trinket1Use, v29.Cooldowns.Trinket2HP, v29.Cooldowns.Trinket2Use, v30);
		if v66 then
			return v66;
		end
		v66 = v74();
		if v66 then
			return v66;
		end
	end
end
local function v76()
	v12.ResetToggle();
	v29.Resto.Display();
	v12:UpdateMacro("macro1", "/use 16");
	v12:UpdateMacro("macro2", "/hr dpsonly");
	v12:UpdateMacro("macro6", "/stopcasting");
	v12.ToggleIconFrame:AddButtonCustom("O", 115 - (4 + 110), "OOC", "ooc");
	v12.ToggleIconFrame:AddButtonCustom("D", 586 - (57 + 527), "Dispel", "dispel");
	v12.ToggleIconFrame:AddButtonCustom("K", 1430 - (41 + 1386), "Kick", "kick");
	v12.ToggleIconFrame:AddButtonCustom("H", 107 - (17 + 86), "Healing Rain", "healingrain");
	v12.ToggleIconFrame:AddButtonCustom("DP", 4 + 1, "DPS Only", "dpsonly");
	v12.Print("Restoration Shaman rotation has been updated for 10.2. Last Update 04/5/24");
end
v12.SetAPL(588 - 324, v75, v76, v73);
