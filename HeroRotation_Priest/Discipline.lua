local v0, v1 = ...;
local v2 = HeroDBC.DBC;
local v3 = HeroLib;
local v4 = HeroCache;
local v5 = v3.Unit;
local v6 = v5.Player;
local v7 = v5.Target;
local v8 = v5.Pet;
local v9 = v3.Spell;
local v10 = v3.Item;
local v11 = HeroRotation();
local v12 = v11.AoEON;
local v13 = v11.CDsON;
local v14 = v11.Cast;
local v15 = v11.Commons().Everyone.num;
local v16 = v11.Commons().Everyone.bool;
local v17 = v9.Priest.Discipline;
local v18 = v10.Priest.Discipline;
local v19 = {v18.ScreamingBlackDragonScale:ID(),v18.BroodkeepersPromise:ID()};
local v20;
local v21, v22;
local v23, v24;
local v25;
local v26 = v11.Commons().Everyone;
local v27 = v11.GUISettingsGet();
local v28 = {General=v27.General,Commons=v27.APL.Priest.Commons,Discipline=v27.APL.Priest.Discipline,Healing=((not v6:IsInRaid() and v27.APL.Priest.DiscHealing) or v27.APL.Priest.DiscRaidHealing),AoE=((not v6:IsInRaid() and v27.APL.Priest.DiscAoE) or v27.APL.Priest.DiscRaidAoE),DiscExtras=v27.APL.Priest.DiscExtras};
local function v29(v87)
	return v87:NPCID() == (394869 - 190309);
end
local function v30(v88)
	return v88:NPCID() == (527474 - 322701);
end
local function v31(v89)
	return (v89:NPCID() == (205068 - (555 + 64))) or (v89:NPCID() == (209390 - (857 + 74))) or (v89:NPCID() == (209029 - (367 + 201))) or (v89:NPCID() == (208727 - (214 + 713))) or (v89:NPCID() == (48723 + 145923)) or (v89:NPCID() == (33435 + 179155));
end
local function v32()
	return v31(v7) and not v6:CanAttack(v7);
end
local function v33(v90)
	return (877.25 - (282 + 595)) * v90;
end
local function v34(v91)
	local v92 = 1637 - (1523 + 114);
	for v128, v129 in pairs(v91) do
		if not v129:IsDeadOrGhost() then
			v92 = v92 + 1 + 0;
		end
		return v92;
	end
end
local function v35(v93, v94, v95, v96, v97)
	local v98, v99, v100 = v6:GetUseableItems(v19, 17 - 4);
	if (v98 and v26.AoELogic(v93, v94, v97)) then
		if v14(v98) then
			return "trinket1 trinkets 2";
		end
	end
	local v101, v99, v102 = v6:GetUseableItems(v19, 1079 - (68 + 997));
	if (v101 and v26.AoELogic(v95, v96, v97)) then
		if v14(v101) then
			return "trinket2 trinkets 4";
		end
	end
end
local function v36(v103)
	local v104 = v34(v103);
	local v105 = (1270.5 - (226 + 1044)) * v104;
	local v106 = v33(v6:HastePct());
	local v107 = v105 + v106;
	return math.min(v107, v104);
end
local function v37(v108)
	local v109 = v9(1046985 - 806542);
	local v110 = v9(377627 - (32 + 85));
	local v111 = v9(381399 + 7780);
	local v112 = v9(86847 + 304787);
	if ((v26.DebuffCountWithStacks(v108, v109, 960 - (892 + 65)) >= (4 - 2)) or (v26.DebuffCount(v108, v111) >= (5 - 2)) or (v26.DebuffCountWithStacks(v108, v110, 8 - 3) >= (353 - (87 + 263))) or (v26.DebuffCount(v108, v112) >= (182 - (67 + 113)))) then
		return true;
	end
	return false;
end
local v38 = v26.converArrayToList({(475147 - 281617),(77796 - 58222),(971804 - 610852),(138532 + 51787),(35315 - 22843),(15836 - 3794),(828873 - 463523),(2391 + 11359),(113138 + 912),(358425 - 244374),(789272 - 584092),(846720 - 581533),(469382 - 204109),(32314 - (44 + 386)),(73672 + 158223),(455145 - (201 + 571)),(447859 - 340285),(6275 - 4556),(48427 - (814 + 45)),(2642 + 46386),(153164 - (261 + 624)),(201246 - (1020 + 60)),(658156 - 463933),(151001 + 232409),(104307 - (760 + 987)),(391180 - (745 + 21)),(294291 - 187340),(839 + 101704),(376142 - (87 + 968))});
local v39 = v26.converArrayToList({(5 + 0),(1421 - (447 + 966)),(1820 - (1703 + 114)),(2 - 0),(3 + 4),(23 - (9 + 5)),(1276 - (243 + 1022)),(10 + 2),(11 + 2)});
local function v40(v113, v114)
	return v114[v113];
end
local function v41(v115, v116)
	for v130, v131 in ipairs(v115) do
		if v116:BuffUp(v131, true) then
			return true;
		end
	end
	return false;
end
local function v42(v117)
	local v118 = nil;
	if v28.Discipline.SelectPI then
		local v140 = (v6:IsInRaid() and v5(v28.Discipline.PIRaidUnit)) or v5(v28.Discipline.PIGroupUnit);
		if (v140:Exists() and not v140:IsDeadOrGhost()) then
			return v140;
		end
	end
	for v132, v133 in pairs(v117) do
		if (v133:Exists() and not v133:IsDeadOrGhost() and (v133:Role() == "DAMAGER") and v40(v133:ClassID(), v39)) then
			if (v133:BuffDown(v17.PowerInfusion) and v26.unitHasBuffFromList(v38, v133)) then
				v118 = v133;
				break;
			end
		end
	end
	if not v118 then
		for v141, v142 in pairs(v117) do
			if (v142:Exists() and not v142:IsDeadOrGhost() and (v142:Role() == "DAMAGER")) then
				if (v142:BuffDown(v17.PowerInfusion) and v26.unitHasBuffFromList(v38, v142)) then
					v118 = v142;
					break;
				end
			end
		end
	end
	return v118;
end
local function v43()
	if (v17.PowerWordFortitude:IsCastable() and not v6:DebuffUp(v17.Corruption) and ((v26.GroupBuffMissing(v17.PowerWordFortitudeBuff) and (v28.Commons.PowerWordFortitude == "check whole group") and (v6:IsInRaidArea() or v6:IsInDungeonArea())) or (v6:BuffDown(v17.PowerWordFortitudeBuff, true) and ((v28.Commons.PowerWordFortitude == "only check us") or (v28.Commons.PowerWordFortitude == "check whole group")))) and not v6:IsMounted()) then
		if v14(v17.PowerWordFortitude) then
			return "power_word_fortitude precombat";
		end
	end
end
local function v44()
	if (v17.ArcaneTorrent:IsReady() and (v6:ManaPercentage() <= (349 - (163 + 91)))) then
		if v14(v17.ArcaneTorrent) then
			return "arcane_torrent racials 2";
		end
	end
	if v17.BloodFury:IsReady() then
		if v14(v17.Fireblood) then
			return "blood_fury racials 4";
		end
	end
	if v17.Berserking:IsReady() then
		if v14(v17.Berserking) then
			return "berserking racials 6";
		end
	end
	if v17.ArcaneTorrent:IsReady() then
		if v14(v17.ArcaneTorrent) then
			return "arcane_torrent racials 8";
		end
	end
	if v17.LightsJudgment:IsReady() then
		if v14(v17.LightsJudgment, nil, not v7:IsSpellInRange(v17.LightsJudgment)) then
			return "lights_judgment racials 10";
		end
	end
	if v17.Fireblood:IsReady() then
		if v14(v17.Fireblood) then
			return "fireblood racials 12";
		end
	end
	if v17.AncestralCall:IsReady() then
		if v14(v17.AncestralCall) then
			return "ancestral_call racials 14";
		end
	end
	if v17.BagofTricks:IsReady() then
		if v14(v17.BagofTricks, nil, not v7:IsSpellInRange(v17.BagofTricks)) then
			return "bag_of_tricks racials 16";
		end
	end
end
local v45 = v26.converArrayToList({(122498 + 315975),(674096 - 235217),(616826 - 167979),(258800 - (1329 + 145)),(274561 - (1409 + 441)),(203472 + 235893),(440598 - (345 + 1376)),(1993480 - 1542258),(437452 - (696 + 510)),(441730 - (1091 + 171)),(1022923 - 698014),(320988 - (123 + 251)),(273360 - (208 + 490)),(120534 + 150056),(32351 + 236915),(450119 - (534 + 141)),(387868 + 50627)});
local v46 = v26.converArrayToList({(925663 - 485195),(1253061 - 806344),(280929 + 160287),(1017717 - 580184),(1061779 - 622438),(451969 - (550 + 317)),(607372 - 175255),(434537 - (134 + 151)),(814484 - 387658),(1556778 - 1107890),(1635817 - 1201724),(604052 - 147301),(452719 - (162 + 618)),(300965 + 150906),(759839 - 307874),(461728 - (1373 + 263)),(103347 + 224050),(538813 - 218217),(171023 + 283416),(428876 - (218 + 123)),(423248 + 2726),(429439 - (306 + 254)),(912605 - 447593),(279273 + 145606),(440180 - (268 + 335)),(444066 - (426 + 146)),(424780 - (282 + 1174)),(1230961 - 803632),(324173 - (706 + 318)),(322940 - (945 + 326)),(287068 + 35546),(295626 + 26195),(323842 - (461 + 625)),(17403 + 317738),(127009 + 206476),(97583 + 236050),(322283 - (406 + 123)),(110018 + 353164),(163280 + 294384),(1082689 - 632594),(451977 - (106 + 1794)),(113610 + 335834),(1200990 - 757483),(451806 - (57 + 527)),(426837 - (17 + 86)),(969330 - 534675),(439958 - (122 + 44)),(1415800 - 989029),(62105 + 367322)});
local function v47()
	local v119 = v6:GetEnemiesInRange(81 - 41);
	for v134, v135 in pairs(v119) do
		if v45[v135:CastSpellID() or v135:ChannelSpellID()] then
			return true;
		end
	end
end
local function v48()
	local v120 = v6:GetEnemiesInRange(105 - (30 + 35));
	for v136, v137 in pairs(v120) do
		if v46[v137:CastSpellID() or v137:ChannelSpellID()] then
			return true;
		end
	end
end
local v49 = 0 + 0;
local function v50()
	local v121 = v6:GetEnemiesInRange(1297 - (1043 + 214));
	for v138, v139 in pairs(v121) do
		if v26.Interruptspells[v139:CastSpellID()] then
			v49 = v139:CastRemains() + (0.1 - 0);
			return v49;
		end
	end
	v49 = 1212 - (323 + 889);
	return v49;
end
local function v51(v122)
	return v122:CooldownUp() and v122:IsUsable() and v122:IsLearned();
end
local function v52(v123)
	return v123:CooldownUp() and v123:IsUsable();
end
local v53 = nil;
local v54 = 0 - 0;
local function v55()
	if v6:IsMoving() then
		if not v53 then
			v53 = GetTime();
		end
		return GetTime() - v53;
	else
		if v53 then
			v53 = nil;
		end
		return 580 - (361 + 219);
	end
end
local v56, v57, v58, v59, v60, v61, v62, v63, v64, v65, v66, v67, v68, v69, v70, v71;
local v72, v73, v74, v75, v76, v77, v78, v79;
local v80 = v6:BuffUp(v17.RadiantProvidence) or v6:BuffUp(v17.WasteNoTime);
local function v81()
	local v124 = GetTime();
	if ((v124 - v54) >= (335 - (53 + 267))) then
		v11.Print("Move=" .. tostring(not v6:IsMoving()) .. "\nBuffRadiant=" .. tostring(v6:BuffUp(v17.RadiantProvidence)) .. "\nBuffWaste=" .. tostring(v6:BuffUp(v17.WasteNoTime)));
		v11.Print("RadToggle: " .. tostring(v65) .. "\nNotCasting: " .. tostring(not v6:PrevGCD(1 + 0, v17.PowerWordRadiance)) .. "\nReady: " .. tostring(v17.PowerWordRadiance:IsReady()) .. "\nIsPowerRadianceInstant: " .. tostring(v80) .. "\nAoELogicWithCount: " .. tostring(v26.AoELogicWithCount(v28.AoE.PWRAtoneHP, v28.AoE.PWRAtoneCount, "With Logic", v25)));
		v54 = v124;
	end
end
local function v82()
	v28.Healing = (not v6:IsInRaid() and v27.APL.Priest.DiscHealing) or v27.APL.Priest.DiscRaidHealing;
	v28.AoE = (not v6:IsInRaid() and v27.APL.Priest.DiscAoE) or v27.APL.Priest.DiscRaidAoE;
	v74 = (not v6:IsInRaid() and v28.DiscExtras.PremPCount) or v28.DiscExtras.PremRCount;
	v73 = v11.ToggleIconFrame:GetToggle(414 - (15 + 398));
	v65 = v11.ToggleIconFrame:GetToggle(986 - (18 + 964));
	v66 = v11.ToggleIconFrame:GetToggle(7 - 5);
	v67 = v11.ToggleIconFrame:GetToggle(3 + 2);
	v77 = v11.ToggleIconFrame:GetToggle(4 + 2);
	v76 = v11.ToggleIconFrame:GetToggle(857 - (20 + 830));
	v25 = v26.UnitsinRange(v17.FlashHeal);
	v69 = v28.DiscExtras.AutoRamp and (v48() or v47() or (v26.GetAverageGroupHealthPercent(v25) <= (36 + 9)));
	v64 = v11.ToggleIconFrame:GetToggle(129 - (116 + 10)) or v69;
	v75 = (v17.MiraculousRecoveryT:IsAvailable() and (4 + 45)) or (771 - (542 + 196));
	v21 = v6:GetEnemiesInMeleeRange(25 - 13);
	if v12() then
		v22 = #v21;
	else
		v22 = 1 + 0;
	end
	v58, v59 = v26.GetLowestHealthUnit(v25);
	v56 = v26.UnitstWithoutBuff(v25, v17.Atonement);
	v57 = #v56;
	v62 = v26.GetLowestHealthUnit(v56);
	v60 = v58:HealthPercentageWeighted();
	v61 = v26.GetLowestHealthUnitWithoutBuff(v25, v17.PowerWordShield);
	v63 = v26.GetLowestHealthUnitWithoutBuff(v25, v17.Renew);
	v71 = v26.GetLowestHealthUnitWithoutBuff(v25, v17.Atonement);
	if v67 then
		if (v17.PowerInfusion:IsReady() and v6:AffectingCombat()) then
			v70 = v42(v25);
		end
	end
	if (v59 == nil) then
	else
		v78 = v59:IncomingSpell(v26.TankBustersList2);
	end
end
local function v83()
	if v6:BuffUp(v17.PowerInfusion) then
		if v6:IsInRaid() then
			v68 = v36(v25);
		else
			v68 = 3 + 2;
		end
	else
		v68 = (v6:IsInRaid() and (3 + 5)) or (12 - 7);
	end
	if v28.DiscExtras.Movement then
		if (v17.AngelicFeather:IsReady() and v6:BuffDown(v17.AngelicFeatherBuff) and v6:IsMoving() and (v55() > (2 - 1))) then
			v11.CastTarget(v17.AngelicFeather, v11.TName().PLAYER);
			return "Angelic Feather";
		end
	end
	if (v67 and v6:AffectingCombat()) then
		if (v70 ~= nil) then
			if v17.PowerInfusion:IsReady() then
				v70:Cast(v17.PowerInfusion, true);
				return "PI -- Has Active Buff on List ? " .. tostring(v26.unitHasBuffFromList(v38, v70)) .. " And is a valid Class " .. tostring(v40(v70:ClassID(), v39)) .. " Unit Name : " .. v70:Name() .. " Unit Role : " .. v70:Role() .. " Unit ID : " .. v70:ID() .. " Unit Class ID " .. v70:ClassID();
			end
		end
	end
	if ((v60 >= (1596 - (1126 + 425))) and v30(v7) and (v17.Purify:CooldownDown() or not v17.ImprovedPurify:IsAvailable()) and v7:IsSpellInRange(v17.FlashHeal)) then
		if (v17.PowerWordLifeCast:IsAvailable() and v17.PowerWordLife:CooldownUp()) then
			v14(v17.PowerWordLifeCast);
			return;
		end
		if (v17.FlashHeal:IsReady() and not v6:IsMoving()) then
			v14(v17.FlashHeal);
			return;
		end
	end
	if ((v60 >= (440 - (118 + 287))) and v32() and (v7:HealthPercentage() > (0 - 0)) and (v7:HealthPercentage() < (1221 - (118 + 1003)))) then
		if (v17.PowerWordLifeCast:IsAvailable() and v17.PowerWordLife:CooldownUp() and (v7:HealthPercentage() < v75)) then
			v14(v17.PowerWordLifeCast);
			return;
		end
		if (v17.FlashHeal:IsReady() and not v6:IsMoving()) then
			v14(v17.FlashHeal);
			return;
		end
	end
	if (v17.DesperatePrayer:IsReady() and (v6:HealthPercentageWeighted() <= v28.Discipline.DesperatePrayerHP)) then
		v11.Cast(v17.DesperatePrayer);
		return "Desperate Prayer " .. v6:HealthPercentageWeighted();
	end
	if (v17.Fade:IsReady() and (v28.Discipline.FadeHP > (0 - 0)) and ((v6:HealthPercentageWeighted() <= v28.Discipline.FadeHP) or v48() or v47())) then
		v11.Cast(v17.Fade);
		return "Fade " .. v6:HealthPercentageWeighted();
	end
	if v28.Discipline.VoidShiftTankOnly then
		if (v59 ~= nil) then
			if (v17.VoidShift:IsReady() and (v59:HealthPercentageWeighted() < (402 - (142 + 235))) and (v6:HealthPercentage() >= (204 - 159))) then
				v59:Cast(v17.VoidShift);
				return "Void Shift On Tank";
			end
		end
	elseif (v17.VoidShift:IsReady() and (v60 < (6 + 19)) and (v6:HealthPercentage() >= (1022 - (553 + 424)))) then
		v58:Cast(v17.VoidShift);
		return "Void Shift on Lowest Unit";
	end
	if (v17.PowerWordLifeCast:IsAvailable() and v17.PowerWordLife:CooldownUp() and (v58:HealthPercentage() < v75)) then
		v58:Cast(v17.PowerWordLifeCast);
		return "Power Word Life";
	end
	if v66 then
		if (v17.MassDispel:IsReady() and not v6:IsMoving() and v37(v25)) then
			v11.Cast(v17.MassDispel);
			return "Mass Dispel casted";
		end
	end
	if (v17.PowerWordBarrier:IsReady() and v26.AoELogicWithCount(v28.AoE.PWBLHP, v28.AoE.PWBLCount, "With Logic", v25)) then
		v11.Cast(v17.PowerWordBarrier);
		return "Power Word Barrier Based on Settings";
	end
	if (v17.LuminousBarrier:IsReady() and v26.AoELogicWithCount(v28.AoE.PWBLHP, v28.AoE.PWBLCount, "With Logic", v25)) then
		v11.Cast(v17.LuminousBarrier);
		return "Luminous Barrier Based on Settings";
	end
	if v28.Healing.PainSupOnTank then
		if (v59 ~= nil) then
			if (v17.PainSupression:IsReady() and v59:BuffDown(v17.PainSupression) and not v6:PrevGCD(1 - 0, v17.PainSupression) and (v59:HealthPercentageWeighted() <= v28.Healing.PainSupHP)) then
				v59:Cast(v17.PainSupression);
				return "Pain Sup on Tank";
			end
		end
	elseif (v17.PainSupression:IsReady() and v58:BuffDown(v17.PainSupression) and not v6:PrevGCD(1 + 0, v17.PainSupression) and (v60 <= v28.Healing.PainSupHP)) then
		v58:Cast(v17.PainSupression);
		return "Pain Sup on Lowest";
	end
	if (v17.PremonitionTalent:IsAvailable() and v28.DiscExtras.PremUse) then
		if (v17.PrayerofMending:IsReady() and v17.PremonitionInsight:IsReady()) then
			v11.Cast(v17.PremonitionTalent);
			return "PremonitionInsight";
		end
		if (v6:AffectingCombat() and v17.PremonitionPiety:IsReady()) then
			if (v26.AoELogicWithCount(v28.DiscExtras.PremHP, v74, "With Logic", v25) or v48() or v47()) then
				v11.Cast(v17.PremonitionTalent);
				return "PremonitionPiety";
			end
		end
		if (v6:AffectingCombat() and v17.PremonitionSolace:IsReady()) then
			if (v48() or v47()) then
				v11.Cast(v17.PremonitionTalent);
				return "PremonitionSolace";
			end
		end
		if (v17.PremonitionClairvoyanceT:IsAvailable() and v17.PremonitionClairvoyance:IsReady()) then
			if (v26.AoELogicWithCount(v28.DiscExtras.PremHP, v74, "With Logic", v25) or v48() or v47() or v17.PrayerofMending:IsReady()) then
				v11.Cast(v17.PremonitionTalent);
				return "PremonitionClairvoyance";
			end
		end
	end
	if (v65 and not v6:PrevGCD(1 + 0, v17.PowerWordRadiance) and not v6:IsCasting(v17.PowerWordRadiance) and v17.PowerWordRadiance:IsReady() and (not v6:IsMoving() or v80) and v26.AoELogicWithCount(v28.AoE.PWRAtoneHP, v28.AoE.PWRAtoneCount, "With Logic", v25)) then
		v58:Cast(v17.PowerWordRadiance);
		return "Power Word Rad via Atone Ignore Settings";
	end
	if (v17.PowerWordShield:IsReady() and v58:BuffDown(v17.PowerWordShield) and (v60 <= v28.Healing.PWSAtoneIgnoreHP)) then
		v58:Cast(v17.PowerWordShield);
		return "PWS on Lowest Unit based on Atone Ignore Setting";
	end
	if (v17.FlashHeal:IsReady() and (((v60 <= v28.Healing.FlashAtoneIgnoreHP) and v58:BuffUp(v17.Atonement)) or ((v60 <= v28.Healing.FlashHealSurgeHP) and v6:BuffUp(v17.SurgeofLight))) and (not v6:IsMoving() or v6:BuffUp(v17.SurgeofLight))) then
		v58:Cast(v17.FlashHeal);
		return "Flash Heal based on Atone Ignore Settings";
	end
	if (v59 ~= nil) then
		if (v17.PowerWordShield:IsReady() and ((v59:BuffDown(v17.PowerWordShield) and (v59:HealthPercentageWeighted() <= v28.Healing.PWSTankHP)) or v78)) then
			v59:Cast(v17.PowerWordShield);
			return "Power Word Shield on LowestTank";
		end
	end
	if not v64 then
		if (v63 ~= nil) then
			if (v17.Renew:IsReady() and (v63:HealthPercentageWeighted() <= v28.Discipline.RenewMovingHP) and v6:IsMoving()) then
				v63:Cast(v17.Renew);
				return "Renew while Moving";
			end
		end
	end
	if (not v64 and (v26.BuffCount(v25, v17.Atonement) >= v68)) then
		if (v26.TargetIsValid() and not v29(v7) and v7:AffectingCombat()) then
			if (v17.Mindbender:IsReady() and v77 and v28.Discipline.ShadowFiendRamp and v7:IsSpellInRange(v17.MindBlast)) then
				v11.Cast(v17.Mindbender);
				return "Shadow Fiend or Mindbender since Atonement Numbers are met";
			end
			if (v17.MindBlast:IsReady() and (v17.Mindbender:CooldownDown() or not v28.Discipline.ShadowFiendRamp) and not v6:IsMoving() and v7:IsSpellInRange(v17.MindBlast) and v77) then
				v11.Cast(v17.MindBlast);
				return "Mind Blast since Atonement Numbers are met";
			end
			if ((v7:DebuffUp(v17.ShadowWordPainDebuff)) and (v51(v17.Penance)) and v7:IsSpellInRange(v17.Penance)) then
				v11.Cast(v17.Penance);
				return "Penance since Atonement Numbers are met";
			end
			if ((v51(v17.Halo)) and v26.AoELogicWithCount(v28.AoE.HaloHP, v28.AoE.HaloCount, "With Logic", v25) and not v6:IsMoving()) then
				v11.Cast(v17.HaloCast);
				return "Halo Cast since Atonement Numbers are met";
			end
			if ((v7:DebuffUp(v17.ShadowWordPainDebuff) or v7:DebuffUp(v17.PurgeTheWickedDebuff)) and not v6:IsMoving() and v17.Smite:IsReady() and v7:IsSpellInRange(v17.MindBlast)) then
				v11.Cast(v17.Smite);
				return "Smite Filler since Atonement Numbers are met";
			end
			if ((v7:DebuffUp(v17.ShadowWordPainDebuff) or v7:DebuffUp(v17.PurgeTheWickedDebuff)) and not v6:IsMoving() and v17.VoidBlastAbilityDisc:IsReady() and v7:IsSpellInRange(v17.MindBlast)) then
				v11.Cast(v17.Smite);
				return "Void Blast Filler since Atonement Numbers are met";
			end
		end
	end
	if v64 then
		if (v17.ShadowWordPain:IsReady() and v7:DebuffRefreshable(v17.ShadowWordPainDebuff) and v7:IsSpellInRange(v17.MindBlast)) then
			if v14(v17.ShadowWordPain) then
				return "shadow_word_pain main 60";
			end
		end
		if (v17.Voidwraith:IsReady() and v7:BuffUp(v17.ShadowWordPainDebuff)) then
			if v14(v17.Voidwraith) then
				return "Voidwraith main 64";
			end
		end
		if (v62 ~= nil) then
			if (v17.PowerWordRadiance:IsReady() and (v6:IsInRaid() or (not v6:IsInRaid() and not v6:PrevGCD(1 + 0, v17.PowerWordRadiance) and not v6:IsCasting(v17.PowerWordRadiance) and not v6:IsCasting() and not v6:IsChanneling() and (v26.BuffCount(v25, v17.Atonement) < v68) and (not v6:IsMoving() or v80)))) then
				v62:Cast(v17.PowerWordRadiance);
				return "Power Word Rad During Spread";
			end
		end
		if ((v26.BuffCount(v25, v17.Atonement) >= v68) and v17.Evangelism:IsReady()) then
			v14(v17.Evangelism);
			return " Evanglism During Spread";
		end
		if (v26.BuffCount(v25, v17.Atonement) >= v68) then
			if (v26.TargetIsValid() and v7:AffectingCombat() and not v29(v7)) then
				if (v17.Mindbender:IsReady() and v7:IsSpellInRange(v17.MindBlast)) then
					v11.Cast(v17.Mindbender);
					return "Shadow Fiend or Mindbender During Spread";
				end
				if (v17.MindBlast:IsReady() and v17.Mindbender:CooldownDown() and not v6:IsMoving() and v7:IsSpellInRange(v17.MindBlast)) then
					v11.Cast(v17.MindBlast);
					return "Mind Blast During Spread";
				end
				if ((v7:DebuffUp(v17.ShadowWordPainDebuff) or v7:DebuffUp(v17.PurgeTheWickedDebuff)) and (v51(v17.Penance)) and v7:IsSpellInRange(v17.Penance)) then
					v11.Cast(v17.PenanceCast);
					return "Penance during Spread";
				end
				if (v17.ShadowWordDeath:IsReady() and v7:IsSpellInRange(v17.ShadowWordDeath)) then
					v11.Cast(v17.ShadowWordDeath);
					return "Shadow Word Death During Spread";
				end
				if ((v51(v17.Halo)) and not v6:IsMoving()) then
					v11.Cast(v17.HaloCast);
					return "Halo Cast During Spread";
				end
				if ((v7:DebuffUp(v17.ShadowWordPainDebuff) or v7:DebuffUp(v17.PurgeTheWickedDebuff)) and not v6:IsMoving() and v51(v17.Smite) and v7:IsSpellInRange(v17.MindBlast)) then
					v11.Cast(v17.Smite);
					return "Smite Filler During Spread";
				end
				if ((v7:DebuffUp(v17.ShadowWordPainDebuff) or v7:DebuffUp(v17.PurgeTheWickedDebuff)) and not v6:IsMoving() and v17.VoidBlastAbilityDisc:IsReady() and v7:IsSpellInRange(v17.MindBlast)) then
					v11.Cast(v17.Smite);
					return "Void Blast Filler During Spread";
				end
			end
		end
	end
	if (v17.UltimatePentience:IsReady() and v26.TargetIsValid() and not v6:IsMoving() and v26.AoELogicWithCount(v28.AoE.UPHP, v28.AoE.UPCount, "With Logic", v25)) then
		v11.Cast(v17.UltimatePentience);
		return "Ultimate Pentience casted based on Settings";
	end
	if (v62 ~= nil) then
		if (v65 and v6:BuffDown(v17.Rapture) and not v6:PrevGCD(1 + 0, v17.PowerWordRadiance) and not v6:IsCasting(v17.PowerWordRadiance) and v17.PowerWordRadiance:IsReady() and (not v6:IsMoving() or v80) and (v6:IsInRaid() or (v57 >= (2 + 0))) and v26.AoELogicWithCount(v28.AoE.PWRHP, v28.AoE.PWRCount, "With Logic", v25)) then
			v62:Cast(v17.PowerWordRadiance);
			return "Power Word Rad via Settings";
		end
	end
	if ((v51(v17.Halo)) and not v6:IsMoving() and v26.AoELogicWithCount(v28.AoE.HaloHP, v28.AoE.HaloCount, "With Logic", v25)) then
		v11.Cast(v17.HaloCast);
		return "Halo Based on Settings";
	end
	if (v17.VampiricEmbrace:IsReady() and v26.TargetIsValid() and v26.AoELogicWithCount(v28.AoE.VEHP, v28.AoE.VECount, "With Logic", v25)) then
		v11.Cast(v17.VampiricEmbrace);
		return "VE Based on Settings";
	end
	if (v17.DivineStar:IsReady() and v26.TargetIsValid() and v7:IsSpellInRange(v17.DivineStar) and v26.AoELogicWithCount(v28.AoE.DSHP, v28.AoE.DSCount, "With Logic", v25)) then
		v11.Cast(v17.DivineStarCast);
		return "Divine Star Via Settings";
	end
	if (v59 ~= nil) then
		if (v17.PowerWordShield:IsReady() and v59:BuffDown(v17.PowerWordShield) and (v59:HealthPercentageWeighted() <= v28.Healing.PWSTankHP)) then
			v59:Cast(v17.PowerWordShield);
			return "Power Word Shield on LowestTank";
		end
	end
	if (v61 ~= nil) then
		if (v17.PowerWordShield:IsReady() and (v61:HealthPercentageWeighted() <= v28.Healing.PWSHP)) then
			v61:Cast(v17.PowerWordShield);
			return "PWS on Lowest Without PWS";
		end
	end
	if ((v51(v17.Penance)) and (v60 <= v28.Healing.PenanceHP)) then
		v58:Cast(v17.PenanceCast);
		return "Penance on Lowest Unit";
	end
	if (v63 ~= nil) then
		if (v17.Renew:IsReady() and not v28.Discipline.RenewOnlyMoving and (v63:HealthPercentageWeighted() <= v28.Discipline.RenewHP)) then
			v63:Cast(v17.Renew);
			return "Renew based on Settings";
		end
	end
	if (v17.FlashHeal:IsReady() and (((v60 <= v28.Healing.FlashHealHP) and v58:BuffDown(v17.Atonement)) or ((v60 <= v28.Healing.FlashAtoneIgnoreHP) and v58:BuffUp(v17.Atonement))) and (not v6:IsMoving() or v6:BuffUp(v17.SurgeofLight))) then
		v58:Cast(v17.FlashHeal);
		return "Flash Heal based on Settings";
	end
	if (v17.FlashHeal:IsReady() and v6:BuffUp(v17.SurgeofLight) and (((v60 <= v28.Healing.FlashHealSurgeHP) and v58:BuffDown(v17.Atonement)) or ((v60 <= v28.Healing.FlashAtoneIgnoreHP) and v58:BuffUp(v17.Atonement)))) then
		v58:Cast(v17.FlashHeal);
		return "Flash Heal with Surge based on Settings";
	end
	if (v26.TargetIsValid() and (v7:AffectingCombat() or (v28.Discipline.AttackOOC and v73)) and not v29(v7)) then
		if ((v26.BuffCount(v25, v17.Atonement) >= ((not v6:IsInRaid() and v34(v25)) or v36(v25))) or (v60 >= (97 - 52)) or v26.ISSolo()) then
			if ((v51(v17.Halo)) and v26.AoELogicWithCount(v28.AoE.HaloHP, v28.AoE.HaloCount, "With Logic", v25) and not v6:IsMoving()) then
				if v14(v17.HaloCast) then
					return "Halo main 11";
				end
			end
			if v28.Commons.Enabled.Items then
				if v18.Iridal:IsEquippedAndReady() then
					if not v6:IsMoving() then
						v11.CastMacro(2 - 1, nil, nil, v18.Iridal);
						return "weapon cast Iridal";
					end
				else
					local v143, v144, v145 = v6:GetUseableItems(v19, 35 - 19);
					if (v143 and v143:IsReady() and v7:IsInRange(v145)) then
						v11.CastMacro(1 + 0);
						return "weapon cast";
					end
				end
			end
			if ((v51(v17.DivineStar)) and v7:IsSpellInRange(v17.DivineStar)) then
				if v14(v17.DivineStarCast) then
					return "divine_star main 44";
				end
			end
			if ((v7:DebuffUp(v17.ShadowWordPainDebuff) or v7:DebuffUp(v17.PurgeTheWickedDebuff)) and v7:IsInRange(193 - 153) and (v51(v17.Penance))) then
				if v14(v17.PenanceCast) then
					return "penance main 46";
				end
			end
			if (v17.ShadowWordDeath:IsReady() and v7:DebuffUp(v17.ShadowWordPainDebuff) and v7:IsSpellInRange(v17.ShadowWordDeath) and (v26.BuffCount(v25, v17.Atonement) >= ((not v6:IsInRaid() and v34(v25)) or v36(v25))) and (v6:HealthPercentage() >= (773 - (239 + 514)))) then
				v11.Cast(v17.ShadowWordDeath);
				return "Shadow Word Death DPS - Atone Numbers Proper;";
			end
			if (v17.Mindbender:IsReady() and v77 and v7:IsSpellInRange(v17.MindBlast) and (v6:ManaPercentage() <= v28.Discipline.ShadowfiendMana)) then
				v11.Cast(v17.Mindbender);
				return "Mindbender/Shadow Fiend DPS";
			end
			if (v17.MindBlast:IsReady() and v76 and not v6:IsMoving() and v7:IsSpellInRange(v17.MindBlast)) then
				v11.Cast(v17.MindBlast);
				return "Mind Blast Filler DPS";
			end
			if (v17.ShadowWordPain:IsReady() and v7:DebuffRefreshable(v17.ShadowWordPainDebuff) and v7:IsSpellInRange(v17.MindBlast)) then
				if v14(v17.ShadowWordPain) then
					return "shadow_word_pain main 60";
				end
			end
			if v28.DiscExtras.UseHolyNova then
				if ((v17.HolyNova:IsReady()) and (v22 >= (2 + 1))) then
					if v14(v17.HolyNova) then
						return "holy_nova main 72";
					end
				end
			end
			if ((v7:DebuffUp(v17.ShadowWordPainDebuff)) and (v51(v17.Smite)) and v7:IsSpellInRange(v17.MindBlast) and not v6:IsMoving()) then
				if v14(v17.Smite) then
					return "smite main 70";
				end
			end
			if (v7:DebuffUp(v17.ShadowWordPainDebuff) and v17.VoidBlastAbilityDisc:IsReady() and v7:IsSpellInRange(v17.MindBlast) and not v6:IsMoving()) then
				if v14(v17.Smite) then
					return "Void Blast main 70";
				end
			end
		end
	end
end
local function v84()
	if (v27.General.AutoTab and v6:AffectingCombat()) then
		v11.TopPanelAlternative:ChangeIcon(1330 - (797 + 532), 3 + 0);
		return "Auto tab to target";
	end
end
local function v85()
	if v26.ShouldStopCastUpdate() then
		v11.CastMacro(3 + 3, true);
		return "Stop Cast For Silence";
	end
	if (v6:PrevGCD(2 - 1, v17.UltimatePentience) and (v6:IsChanneling(v17.UltimatePentience) or v6:IsCasting(v17.UltimatePentience))) then
		return;
	end
	if v6:IsChanneling(v17.UltimatePentience) then
		return "Dont cut UltimatePentience";
	end
	local v127 = v26.HealthPotions();
	if v127 then
		return v127;
	end
	if (not v6:IsMounted() and not v6:IsChanneling() and not v6:PrevGCD(1203 - (373 + 829), v17.UltimatePentience) and (not v6:AffectingCombat() or (v73 and not v6:AffectingCombat()))) then
		if (not v6:AffectingCombat() or v73) then
			if v6:IsChanneling(v17.UltimatePentience) then
				return "Dont cut UltimatePentience";
			end
			if (v28.DiscExtras.Movement and not v6:AffectingCombat()) then
				if (v17.AngelicFeather:IsReady() and v6:BuffDown(v17.AngelicFeatherBuff) and v6:IsMoving()) then
					v11.CastTarget(v17.AngelicFeather, v11.TName().PLAYER);
					return "Angelic Feather";
				end
				if (v17.PowerWordShield:IsCastable() and v17.BodyAndSoul:IsAvailable() and v6:IsMoving() and v6:BuffDown(v17.AngelicFeatherBuff) and v6:BuffDown(v17.BodyAndSoulBuff) and not v6:IsMounted()) then
					v6:Cast(v17.PowerWordShield);
					return "PWS Body and Soul";
				end
			end
			v127 = v43();
			if v127 then
				return v127;
			end
		end
	end
	if (v17.Fade:IsCastable() and v17.Phantasm:IsAvailable() and v6:DebuffUp(v17.EntangledDebuff) and v28.Commons.AutoFadeEntangling) then
		if v6:IsChanneling(v17.UltimatePentience) then
			return "Dont cut UltimatePentience";
		end
		if v14(v17.Fade) then
			return "Fade for entangling";
		end
	end
	if (not v6:IsMounted() and not v6:IsChanneling() and (v26.TargetIsValid() or v6:AffectingCombat() or v73)) then
		if v6:IsChanneling(v17.UltimatePentience) then
			return "Dont cut UltimatePentience";
		end
		if (not v6:AffectingCombat() or v73) then
			v127 = v43();
			if v127 then
				return v127;
			end
		end
		if (v66 and v17.Purify:IsReady() and not v6:IsInRaid()) then
			if v17.ImprovedPurify:IsAvailable() then
				v127 = v26.AfflictedLogic(v17.Purify);
				if v127 then
					return v127;
				end
			end
			v127 = v26.DispelCycle(v17.Purify, "Magic", nil, v25);
			if v127 then
				return v127;
			end
			if v17.ImprovedPurify:IsAvailable() then
				v127 = v26.DispelCycle(v17.Purify, "Disease", nil, v25);
				if v127 then
					return v127;
				end
			end
		end
		if (v66 and v17.Purify:IsReady() and v6:IsInRaid()) then
			v127 = v26.DispelCycle(v17.Purify, "Raid", nil, v25);
			if v127 then
				return v127;
			end
		end
		if (v17.PsychicScream:IsReady() and v28.Discipline.ScreamInt) then
			v127 = v26.InterruptCycle(v17.PsychicScream, 739 - (476 + 255), false, nil, true, true);
			if v127 then
				return v127;
			end
		end
		if (v6:AffectingCombat() and v17.DispelMagic:IsReady()) then
			v127 = v26.PurgeCycle(v17.DispelMagic, 1170 - (369 + 761), false, v28.Commons.TabForDispelMagic);
			if v127 then
				return v127;
			end
		end
		v127 = v35(v28.Discipline.Trinket1HP, v28.Discipline.Trinket1Use, v28.Discipline.Trinket2HP, v28.Discipline.Trinket2Use, v25);
		if v127 then
			return v127;
		end
		v127 = v83();
		if v127 then
			return v127;
		end
	end
end
local function v86()
	v11.ResetToggle();
	v11:UpdateMacro("macro1", "/use 16");
	v11:UpdateMacro("macro6", "/stopcasting");
	v28.Discipline.Display();
	v11.ToggleIconFrame:AddButtonCustom("O", 1 + 0, "OOC", "ooc");
	v11.ToggleIconFrame:AddButtonCustom("D", 2 - 0, "Dispel", "dispel");
	v11.ToggleIconFrame:AddButtonCustom("S", 5 - 2, "Spread", "spread");
	v11.ToggleIconFrame:AddButtonCustom("P", 242 - (64 + 174), "Power Word Radiance", "powerwordradiance");
	v11.ToggleIconFrame:AddButtonCustom("I", 1 + 4, "Power Infusion", "powerinfusion");
	v11.ToggleIconFrame:AddButtonCustom("F", 8 - 2, "Shadowfiend", "shadowfiend");
	v11.ToggleIconFrame:AddButtonCustom("MB", 343 - (144 + 192), "Mind Blast", "mindblast");
	v11.Print("Discipline Priest rotation has been Updated for has been updated for Season 2 - Updated : 2/26/25");
end
v11.SetAPL(472 - (42 + 174), v85, v86, v82);
