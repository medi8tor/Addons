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
local function v29(v91)
	return v91:NPCID() == (394869 - 190309);
end
local function v30(v92)
	return v92:NPCID() == (527474 - 322701);
end
local function v31(v93)
	return (v93:NPCID() == (205068 - (555 + 64))) or (v93:NPCID() == (209390 - (857 + 74))) or (v93:NPCID() == (209029 - (367 + 201))) or (v93:NPCID() == (208727 - (214 + 713))) or (v93:NPCID() == (48723 + 145923)) or (v93:NPCID() == (33435 + 179155));
end
local v32 = (v17.VoidWraith:IsAvailable() and v17.VoidWraithAbility) or (v17.Mindbender:IsAvailable() and v17.Mindbender) or v17.Shadowfiend;
local function v33()
	return v31(v7) and not v6:CanAttack(v7);
end
local function v34(v94)
	return (877.25 - (282 + 595)) * v94;
end
local function v35(v95)
	local v96 = 1637 - (1523 + 114);
	for v132, v133 in pairs(v95) do
		if not v133:IsDeadOrGhost() then
			v96 = v96 + 1 + 0;
		end
		return v96;
	end
end
local function v36(v97, v98, v99, v100, v101)
	local v102, v103, v104 = v6:GetUseableItems(v19, 17 - 4);
	if (v102 and v26.AoELogic(v97, v98, v101)) then
		if v14(v102) then
			return "trinket1 trinkets 2";
		end
	end
	local v105, v103, v106 = v6:GetUseableItems(v19, 1079 - (68 + 997));
	if (v105 and v26.AoELogic(v99, v100, v101)) then
		if v14(v105) then
			return "trinket2 trinkets 4";
		end
	end
end
local function v37(v107)
	local v108 = v35(v107);
	local v109 = (1270.5 - (226 + 1044)) * v108;
	local v110 = v34(v6:HastePct());
	local v111 = v109 + v110;
	return math.min(v111, v108);
end
local function v38(v112)
	local v113 = v9(1046985 - 806542);
	local v114 = v9(377627 - (32 + 85));
	local v115 = v9(381399 + 7780);
	local v116 = v9(86847 + 304787);
	if ((v26.DebuffCountWithStacks(v112, v113, 960 - (892 + 65)) >= (4 - 2)) or (v26.DebuffCount(v112, v115) >= (5 - 2)) or (v26.DebuffCountWithStacks(v112, v114, 8 - 3) >= (353 - (87 + 263))) or (v26.DebuffCount(v112, v116) >= (182 - (67 + 113)))) then
		return true;
	end
	return false;
end
local v39 = v26.converArrayToList({(475147 - 281617),(77796 - 58222),(971804 - 610852),(138532 + 51787),(35315 - 22843),(15836 - 3794),(828873 - 463523),(2391 + 11359),(113138 + 912),(358425 - 244374),(789272 - 584092),(846720 - 581533),(469382 - 204109),(32314 - (44 + 386)),(73672 + 158223),(455145 - (201 + 571)),(447859 - 340285),(6275 - 4556),(48427 - (814 + 45)),(2642 + 46386),(153164 - (261 + 624)),(201246 - (1020 + 60)),(658156 - 463933),(151001 + 232409),(104307 - (760 + 987)),(391180 - (745 + 21)),(294291 - 187340),(839 + 101704),(376142 - (87 + 968))});
local v40 = v26.converArrayToList({(5 + 0),(1421 - (447 + 966)),(1820 - (1703 + 114)),(2 - 0),(3 + 4),(23 - (9 + 5)),(1276 - (243 + 1022)),(10 + 2),(11 + 2)});
local function v41(v117, v118)
	return v118[v117];
end
local function v42(v119, v120)
	for v134, v135 in ipairs(v119) do
		if v120:BuffUp(v135, true) then
			return true;
		end
	end
	return false;
end
local function v43(v121)
	local v122 = nil;
	if v28.Discipline.SelectPI then
		local v144 = (v6:IsInRaid() and v5(v28.Discipline.PIRaidUnit)) or v5(v28.Discipline.PIGroupUnit);
		if (v144:Exists() and not v144:IsDeadOrGhost()) then
			return v144;
		end
	end
	for v136, v137 in pairs(v121) do
		if (v137:Exists() and not v137:IsDeadOrGhost() and (v137:Role() == "DAMAGER") and v41(v137:ClassID(), v40)) then
			if (v137:BuffDown(v17.PowerInfusion) and v26.unitHasBuffFromList(v39, v137)) then
				v122 = v137;
				break;
			end
		end
	end
	if not v122 then
		for v145, v146 in pairs(v121) do
			if (v146:Exists() and not v146:IsDeadOrGhost() and (v146:Role() == "DAMAGER")) then
				if (v146:BuffDown(v17.PowerInfusion) and v26.unitHasBuffFromList(v39, v146)) then
					v122 = v146;
					break;
				end
			end
		end
	end
	return v122;
end
local function v44()
	if (v6:PrevGCD(255 - (163 + 91), v17.UltimatePentience) and (v6:IsChanneling(v17.UltimatePentience) or v6:IsCasting(v17.UltimatePentience))) then
		return "Dont cut UltimatePentience";
	end
	if (v6:IsChanneling(v17.UltimatePentience) and v6:PrevGCD(1931 - (1869 + 61), v17.UltimatePentience)) then
		return "Dont cut UltimatePentience";
	end
end
local function v45()
	if (v17.PowerWordFortitude:IsCastable() and not v6:DebuffUp(v17.Corruption) and ((v26.GroupBuffMissing(v17.PowerWordFortitudeBuff) and (v28.Commons.PowerWordFortitude == "check whole group") and (v6:IsInRaidArea() or v6:IsInDungeonArea())) or (v6:BuffDown(v17.PowerWordFortitudeBuff, true) and ((v28.Commons.PowerWordFortitude == "only check us") or (v28.Commons.PowerWordFortitude == "check whole group")))) and not v6:IsMounted()) then
		if v14(v17.PowerWordFortitude) then
			return "power_word_fortitude precombat";
		end
	end
end
local function v46()
	if (v17.ArcaneTorrent:IsReady() and (v6:ManaPercentage() <= (27 + 68))) then
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
local v47 = v26.converArrayToList({(673473 - 235000),(603127 - 164248),(450321 - (1329 + 145)),(259176 - (1409 + 441)),(126294 + 146417),(441086 - (345 + 1376)),(1938941 - 1500064),(452428 - (696 + 510)),(437508 - (1091 + 171)),(1386742 - 946274),(325283 - (123 + 251)),(321312 - (208 + 490)),(121457 + 151205),(32510 + 238080),(269941 - (534 + 141)),(397553 + 51891),(921517 - 483022)});
local v48 = v26.converArrayToList({(1235532 - 795064),(284431 + 162286),(1026284 - 585068),(1057409 - 619876),(440208 - (550 + 317)),(634057 - 182955),(432402 - (134 + 151)),(828655 - 394403),(1480265 - 1053439),(1691570 - 1242682),(574086 - 139993),(457531 - (162 + 618)),(301010 + 150929),(759681 - 307810),(453601 - (1373 + 263)),(145233 + 314859),(550242 - 222845),(120653 + 199943),(454780 - (218 + 123)),(425793 + 2742),(426534 - (306 + 254)),(841692 - 412813),(305653 + 159359),(425482 - (268 + 335)),(440149 - (426 + 146)),(444950 - (282 + 1174)),(1219424 - 796100),(428353 - (706 + 318)),(324420 - (945 + 326)),(286228 + 35441),(296354 + 26260),(322907 - (461 + 625)),(16760 + 305996),(127640 + 207501),(97539 + 235946),(334162 - (406 + 123)),(76426 + 245328),(165249 + 297933),(1100896 - 643232),(451995 - (106 + 1794)),(113770 + 336307),(1217067 - 767623),(444091 - (57 + 527)),(451325 - (17 + 86)),(951665 - 524931),(434821 - (122 + 44)),(1458996 - 1019204),(61721 + 365050),(429492 - (30 + 35))});
local function v49()
	local v123 = v6:GetEnemiesInRange(28 + 12);
	for v138, v139 in pairs(v123) do
		if v47[v139:CastSpellID() or v139:ChannelSpellID()] then
			return true;
		end
	end
end
local function v50()
	local v124 = v6:GetEnemiesInRange(1297 - (1043 + 214));
	for v140, v141 in pairs(v124) do
		if v48[v141:CastSpellID() or v141:ChannelSpellID()] then
			return true;
		end
	end
end
local v51 = 0 - 0;
local function v52()
	local v125 = v6:GetEnemiesInRange(1252 - (323 + 889));
	for v142, v143 in pairs(v125) do
		if v26.Interruptspells[v143:CastSpellID()] then
			v51 = v143:CastRemains() + (0.1 - 0);
			return v51;
		end
	end
	v51 = 580 - (361 + 219);
	return v51;
end
local function v53(v126)
	return v126:CooldownUp() and v126:IsUsable() and v126:IsLearned();
end
local function v54(v127)
	return v127:CooldownUp() and v127:IsUsable();
end
local v55 = nil;
local v56 = 320 - (53 + 267);
local function v57()
	if v6:IsMoving() then
		if not v55 then
			v55 = GetTime();
		end
		return GetTime() - v55;
	else
		if v55 then
			v55 = nil;
		end
		return 0 + 0;
	end
end
local v58, v59, v60, v61, v62, v63, v64, v65, v66, v67, v68, v69, v70, v71, v72, v73;
local v74, v75, v76, v77, v78, v79, v80, v81;
local v82 = v6:BuffUp(v17.RadiantProvidence) or v6:BuffUp(v17.WasteNoTime);
local function v83()
	local v128 = GetTime();
	if ((v128 - v56) >= (428 - (15 + 398))) then
		v11.Print("Move=" .. tostring(not v6:IsMoving()) .. "\nBuffRadiant=" .. tostring(v6:BuffUp(v17.RadiantProvidence)) .. "\nBuffWaste=" .. tostring(v6:BuffUp(v17.WasteNoTime)));
		v11.Print("RadToggle: " .. tostring(v67) .. "\nNotCasting: " .. tostring(not v6:PrevGCD(983 - (18 + 964), v17.PowerWordRadiance)) .. "\nReady: " .. tostring(v17.PowerWordRadiance:IsReady()) .. "\nIsPowerRadianceInstant: " .. tostring(v82) .. "\nAoELogicWithCount: " .. tostring(v26.AoELogicWithCount(v28.AoE.PWRAtoneHP, v28.AoE.PWRAtoneCount, "With Logic", v25)));
		v56 = v128;
	end
end
local function v84()
	v28.Healing = (not v6:IsInRaid() and v27.APL.Priest.DiscHealing) or v27.APL.Priest.DiscRaidHealing;
	v28.AoE = (not v6:IsInRaid() and v27.APL.Priest.DiscAoE) or v27.APL.Priest.DiscRaidAoE;
	v76 = (not v6:IsInRaid() and v28.DiscExtras.PremPCount) or v28.DiscExtras.PremRCount;
	v75 = v11.ToggleIconFrame:GetToggle(3 - 2);
	v67 = v11.ToggleIconFrame:GetToggle(3 + 1);
	v68 = v11.ToggleIconFrame:GetToggle(2 + 0);
	v69 = v11.ToggleIconFrame:GetToggle(855 - (20 + 830));
	v79 = v11.ToggleIconFrame:GetToggle(5 + 1);
	v78 = v11.ToggleIconFrame:GetToggle(133 - (116 + 10));
	v25 = v26.UnitsinRange(v17.FlashHeal);
	v71 = v28.DiscExtras.AutoRamp and (v50() or v49() or (v26.GetAverageGroupHealthPercent(v25) <= (4 + 41)));
	v66 = v11.ToggleIconFrame:GetToggle(741 - (542 + 196)) or v71;
	v77 = (v17.MiraculousRecoveryT:IsAvailable() and (104 - 55)) or (10 + 23);
	v21 = v6:GetEnemiesInMeleeRange(7 + 5);
	if v12() then
		v22 = #v21;
	else
		v22 = 1 + 0;
	end
	v60, v61 = v26.GetLowestHealthUnit(v25);
	v58 = v26.UnitstWithoutBuff(v25, v17.Atonement);
	v59 = #v58;
	v64 = v26.GetLowestHealthUnit(v58);
	v62 = v60:HealthPercentageWeighted();
	v63 = v26.GetLowestHealthUnitWithoutBuff(v25, v17.PowerWordShield);
	v65 = v26.GetLowestHealthUnitWithoutBuff(v25, v17.Renew);
	v73 = v26.GetLowestHealthUnitWithoutBuff(v25, v17.Atonement);
	if v69 then
		if (v17.PowerInfusion:IsReady() and v6:AffectingCombat()) then
			v72 = v43(v25);
		end
	end
	if (v61 == nil) then
	else
		v80 = v61:IncomingSpell(v26.TankBustersList2);
	end
end
local function v85()
	if v6:BuffUp(v17.PowerInfusion) then
		if v6:IsInRaid() then
			v70 = v37(v25);
		else
			v70 = 12 - 7;
		end
	else
		v70 = (v6:IsInRaid() and (20 - 12)) or (1556 - (1126 + 425));
	end
	if v28.DiscExtras.Movement then
		if (v17.AngelicFeather:IsReady() and v6:BuffDown(v17.AngelicFeatherBuff) and v6:IsMoving() and (v57() > (406 - (118 + 287)))) then
			v11.CastTarget(v17.AngelicFeather, v11.TName().PLAYER);
			return "Angelic Feather";
		end
	end
	if (v69 and v6:AffectingCombat()) then
		if (v72 ~= nil) then
			if v17.PowerInfusion:IsReady() then
				v72:Cast(v17.PowerInfusion, true);
				return "PI -- Has Active Buff on List ? " .. tostring(v26.unitHasBuffFromList(v39, v72)) .. " And is a valid Class " .. tostring(v41(v72:ClassID(), v40)) .. " Unit Name : " .. v72:Name() .. " Unit Role : " .. v72:Role() .. " Unit ID : " .. v72:ID() .. " Unit Class ID " .. v72:ClassID();
			end
		end
	end
	if ((v62 >= (176 - 131)) and v30(v7) and (v17.Purify:CooldownDown() or not v17.ImprovedPurify:IsAvailable()) and v7:IsSpellInRange(v17.FlashHeal)) then
		if (v17.PowerWordLifeCast:IsAvailable() and v17.PowerWordLife:CooldownUp()) then
			v14(v17.PowerWordLifeCast);
			return;
		end
		if (v17.FlashHeal:IsReady() and not v6:IsMoving()) then
			v14(v17.FlashHeal);
			return;
		end
	end
	if ((v62 >= (1156 - (118 + 1003))) and v33() and (v7:HealthPercentage() > (0 - 0)) and (v7:HealthPercentage() < (477 - (142 + 235)))) then
		if (v17.PowerWordLifeCast:IsAvailable() and v17.PowerWordLife:CooldownUp() and (v7:HealthPercentage() < v77)) then
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
	if (v17.Fade:IsReady() and (v28.Discipline.FadeHP > (0 - 0)) and ((v6:HealthPercentageWeighted() <= v28.Discipline.FadeHP) or v50() or v49())) then
		v11.Cast(v17.Fade);
		return "Fade " .. v6:HealthPercentageWeighted();
	end
	if v28.Discipline.VoidShiftTankOnly then
		if (v61 ~= nil) then
			if (v17.VoidShift:IsReady() and (v61:HealthPercentageWeighted() < (6 + 19)) and (v6:HealthPercentage() >= (1022 - (553 + 424)))) then
				v61:Cast(v17.VoidShift);
				return "Void Shift On Tank";
			end
		end
	elseif (v17.VoidShift:IsReady() and (v62 < (46 - 21)) and (v6:HealthPercentage() >= (40 + 5))) then
		v60:Cast(v17.VoidShift);
		return "Void Shift on Lowest Unit";
	end
	if (v17.PowerWordLifeCast:IsAvailable() and v17.PowerWordLife:CooldownUp() and (v60:HealthPercentage() < v77)) then
		v60:Cast(v17.PowerWordLifeCast);
		return "Power Word Life";
	end
	if v68 then
		if (v17.MassDispel:IsReady() and not v6:IsMoving() and v38(v25)) then
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
		if (v61 ~= nil) then
			if (v17.PainSupression:IsReady() and v61:BuffDown(v17.PainSupression) and not v6:PrevGCD(1 + 0, v17.PainSupression) and (v61:HealthPercentageWeighted() <= v28.Healing.PainSupHP)) then
				v61:Cast(v17.PainSupression);
				return "Pain Sup on Tank";
			end
		end
	elseif (v17.PainSupression:IsReady() and v60:BuffDown(v17.PainSupression) and not v6:PrevGCD(1 + 0, v17.PainSupression) and (v62 <= v28.Healing.PainSupHP)) then
		v60:Cast(v17.PainSupression);
		return "Pain Sup on Lowest";
	end
	if (v17.PremonitionTalent:IsAvailable() and v28.DiscExtras.PremUse) then
		if (v17.PrayerofMending:IsReady() and v17.PremonitionInsight:IsReady()) then
			v11.Cast(v17.PremonitionTalent);
			return "PremonitionInsight";
		end
		if (v6:AffectingCombat() and v17.PremonitionPiety:IsReady()) then
			if (v26.AoELogicWithCount(v28.DiscExtras.PremHP, v76, "With Logic", v25) or v50() or v49()) then
				v11.Cast(v17.PremonitionTalent);
				return "PremonitionPiety";
			end
		end
		if (v6:AffectingCombat() and v17.PremonitionSolace:IsReady()) then
			if (v50() or v49()) then
				v11.Cast(v17.PremonitionTalent);
				return "PremonitionSolace";
			end
		end
		if (v17.PremonitionClairvoyanceT:IsAvailable() and v17.PremonitionClairvoyance:IsReady()) then
			if (v26.AoELogicWithCount(v28.DiscExtras.PremHP, v76, "With Logic", v25) or v50() or v49() or v17.PrayerofMending:IsReady()) then
				v11.Cast(v17.PremonitionTalent);
				return "PremonitionClairvoyance";
			end
		end
	end
	if (v67 and not v6:PrevGCD(1 + 0, v17.PowerWordRadiance) and not v6:IsCasting(v17.PowerWordRadiance) and v17.PowerWordRadiance:IsReady() and (not v6:IsMoving() or v82) and v26.AoELogicWithCount(v28.AoE.PWRAtoneHP, v28.AoE.PWRAtoneCount, "With Logic", v25)) then
		v60:Cast(v17.PowerWordRadiance);
		return "Power Word Rad via Atone Ignore Settings";
	end
	if (v17.PowerWordShield:IsReady() and v60:BuffDown(v17.PowerWordShield) and (v62 <= v28.Healing.PWSAtoneIgnoreHP)) then
		v60:Cast(v17.PowerWordShield);
		return "PWS on Lowest Unit based on Atone Ignore Setting";
	end
	if (v17.FlashHeal:IsReady() and (((v62 <= v28.Healing.FlashAtoneIgnoreHP) and v60:BuffUp(v17.Atonement)) or ((v62 <= v28.Healing.FlashHealSurgeHP) and v6:BuffUp(v17.SurgeofLight))) and (not v6:IsMoving() or v6:BuffUp(v17.SurgeofLight))) then
		v60:Cast(v17.FlashHeal);
		return "Flash Heal based on Atone Ignore Settings";
	end
	if (v61 ~= nil) then
		if (v17.PowerWordShield:IsReady() and ((v61:BuffDown(v17.PowerWordShield) and (v61:HealthPercentageWeighted() <= v28.Healing.PWSTankHP)) or v80)) then
			v61:Cast(v17.PowerWordShield);
			return "Power Word Shield on LowestTank";
		end
	end
	if not v66 then
		if (v65 ~= nil) then
			if (v17.Renew:IsReady() and (v65:HealthPercentageWeighted() <= v28.Discipline.RenewMovingHP) and v6:IsMoving()) then
				v65:Cast(v17.Renew);
				return "Renew while Moving";
			end
		end
	end
	if (not v66 and (v26.BuffCount(v25, v17.Atonement) >= v70)) then
		if (v26.TargetIsValid() and not v29(v7) and v7:AffectingCombat()) then
			v11.Print("CHECK=" .. tostring(v32:IsReady() and v79 and v28.Discipline.ShadowFiendRamp and v7:IsSpellInRange(v17.MindBlast)));
			if (v32:IsReady() and v79 and v28.Discipline.ShadowFiendRamp and v7:IsSpellInRange(v17.MindBlast)) then
				v11.Cast(v32);
				return "Shadow Fiend or Mindbender since Atonement Numbers are met";
			end
			if (v17.MindBlast:IsReady() and (v32:CooldownDown() or not v28.Discipline.ShadowFiendRamp) and not v6:IsMoving() and v7:IsSpellInRange(v17.MindBlast) and v79) then
				v11.Cast(v17.MindBlast);
				return "Mind Blast since Atonement Numbers are met";
			end
			if ((v7:DebuffUp(v17.ShadowWordPainDebuff)) and (v53(v17.Penance)) and v7:IsSpellInRange(v17.Penance)) then
				v11.Cast(v17.Penance);
				return "Penance since Atonement Numbers are met";
			end
			if ((v53(v17.Halo)) and v26.AoELogicWithCount(v28.AoE.HaloHP, v28.AoE.HaloCount, "With Logic", v25) and not v6:IsMoving()) then
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
	if v66 then
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
		if (v64 ~= nil) then
			if (v17.PowerWordRadiance:IsReady() and (v6:IsInRaid() or (not v6:IsInRaid() and not v6:PrevGCD(1 + 0, v17.PowerWordRadiance) and not v6:IsCasting(v17.PowerWordRadiance) and not v6:IsCasting() and not v6:IsChanneling() and (v26.BuffCount(v25, v17.Atonement) < v70) and (not v6:IsMoving() or v82)))) then
				v64:Cast(v17.PowerWordRadiance);
				return "Power Word Rad During Spread";
			end
		end
		if ((v26.BuffCount(v25, v17.Atonement) >= v70) and v17.Evangelism:IsReady()) then
			v14(v17.Evangelism);
			return " Evanglism During Spread";
		end
		if (v26.BuffCount(v25, v17.Atonement) >= v70) then
			if (v26.TargetIsValid() and v7:AffectingCombat() and not v29(v7)) then
				if (v32:IsReady() and v7:IsSpellInRange(v17.MindBlast)) then
					v11.Cast(v32);
					return "Shadow Fiend or Mindbender During Spread";
				end
				if (v17.MindBlast:IsReady() and v32:CooldownDown() and not v6:IsMoving() and v7:IsSpellInRange(v17.MindBlast)) then
					v11.Cast(v17.MindBlast);
					return "Mind Blast During Spread";
				end
				if ((v7:DebuffUp(v17.ShadowWordPainDebuff) or v7:DebuffUp(v17.PurgeTheWickedDebuff)) and (v53(v17.Penance)) and v7:IsSpellInRange(v17.Penance)) then
					v11.Cast(v17.PenanceCast);
					return "Penance during Spread";
				end
				if (v17.ShadowWordDeath:IsReady() and v7:IsSpellInRange(v17.ShadowWordDeath)) then
					v11.Cast(v17.ShadowWordDeath);
					return "Shadow Word Death During Spread";
				end
				if ((v53(v17.Halo)) and not v6:IsMoving()) then
					v11.Cast(v17.HaloCast);
					return "Halo Cast During Spread";
				end
				if ((v7:DebuffUp(v17.ShadowWordPainDebuff) or v7:DebuffUp(v17.PurgeTheWickedDebuff)) and not v6:IsMoving() and v53(v17.Smite) and v7:IsSpellInRange(v17.MindBlast)) then
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
		if v11.Cast(v17.UltimatePentience) then
			return "Ultimate Pentience casted based on Settings";
		end
	end
	v44();
	if (v64 ~= nil) then
		if (v67 and v6:BuffDown(v17.Rapture) and not v6:PrevGCD(2 - 1, v17.PowerWordRadiance) and not v6:IsCasting(v17.PowerWordRadiance) and v17.PowerWordRadiance:IsReady() and (not v6:IsMoving() or v82) and (v6:IsInRaid() or (v59 >= (5 - 3))) and v26.AoELogicWithCount(v28.AoE.PWRHP, v28.AoE.PWRCount, "With Logic", v25)) then
			v64:Cast(v17.PowerWordRadiance);
			return "Power Word Rad via Settings";
		end
	end
	if ((v53(v17.Halo)) and not v6:IsMoving() and v26.AoELogicWithCount(v28.AoE.HaloHP, v28.AoE.HaloCount, "With Logic", v25)) then
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
	if (v61 ~= nil) then
		if (v17.PowerWordShield:IsReady() and v61:BuffDown(v17.PowerWordShield) and (v61:HealthPercentageWeighted() <= v28.Healing.PWSTankHP)) then
			v61:Cast(v17.PowerWordShield);
			return "Power Word Shield on LowestTank";
		end
	end
	if (v63 ~= nil) then
		if (v17.PowerWordShield:IsReady() and (v63:HealthPercentageWeighted() <= v28.Healing.PWSHP)) then
			v63:Cast(v17.PowerWordShield);
			return "PWS on Lowest Without PWS";
		end
	end
	if ((v53(v17.Penance)) and (v62 <= v28.Healing.PenanceHP)) then
		v60:Cast(v17.PenanceCast);
		return "Penance on Lowest Unit";
	end
	if (v65 ~= nil) then
		if (v17.Renew:IsReady() and not v28.Discipline.RenewOnlyMoving and (v65:HealthPercentageWeighted() <= v28.Discipline.RenewHP)) then
			v65:Cast(v17.Renew);
			return "Renew based on Settings";
		end
	end
	if (v17.FlashHeal:IsReady() and (((v62 <= v28.Healing.FlashHealHP) and v60:BuffDown(v17.Atonement)) or ((v62 <= v28.Healing.FlashAtoneIgnoreHP) and v60:BuffUp(v17.Atonement))) and (not v6:IsMoving() or v6:BuffUp(v17.SurgeofLight))) then
		v60:Cast(v17.FlashHeal);
		return "Flash Heal based on Settings";
	end
	if (v17.FlashHeal:IsReady() and v6:BuffUp(v17.SurgeofLight) and (((v62 <= v28.Healing.FlashHealSurgeHP) and v60:BuffDown(v17.Atonement)) or ((v62 <= v28.Healing.FlashAtoneIgnoreHP) and v60:BuffUp(v17.Atonement)))) then
		v60:Cast(v17.FlashHeal);
		return "Flash Heal with Surge based on Settings";
	end
	if (v26.TargetIsValid() and (v7:AffectingCombat() or (v28.Discipline.AttackOOC and v75)) and not v29(v7)) then
		if ((v26.BuffCount(v25, v17.Atonement) >= ((not v6:IsInRaid() and v35(v25)) or v37(v25))) or (v62 >= (100 - 55)) or v26.ISSolo()) then
			if ((v53(v17.Halo)) and v26.AoELogicWithCount(v28.AoE.HaloHP, v28.AoE.HaloCount, "With Logic", v25) and not v6:IsMoving()) then
				if v14(v17.HaloCast) then
					return "Halo main 11";
				end
			end
			if v28.Commons.Enabled.Items then
				if v18.Iridal:IsEquippedAndReady() then
					if not v6:IsMoving() then
						v11.CastMacro(1 + 0, nil, nil, v18.Iridal);
						return "weapon cast Iridal";
					end
				else
					local v147, v148, v149 = v6:GetUseableItems(v19, 77 - 61);
					if (v147 and v147:IsReady() and v7:IsInRange(v149)) then
						v11.CastMacro(754 - (239 + 514));
						return "weapon cast";
					end
				end
			end
			if ((v53(v17.DivineStar)) and v7:IsSpellInRange(v17.DivineStar)) then
				if v14(v17.DivineStarCast) then
					return "divine_star main 44";
				end
			end
			if ((v7:DebuffUp(v17.ShadowWordPainDebuff) or v7:DebuffUp(v17.PurgeTheWickedDebuff)) and v7:IsInRange(15 + 25) and (v53(v17.Penance))) then
				if v14(v17.PenanceCast) then
					return "penance main 46";
				end
			end
			if (v17.ShadowWordDeath:IsReady() and v7:DebuffUp(v17.ShadowWordPainDebuff) and v7:IsSpellInRange(v17.ShadowWordDeath) and (v26.BuffCount(v25, v17.Atonement) >= ((not v6:IsInRaid() and v35(v25)) or v37(v25))) and (v6:HealthPercentage() >= (1349 - (797 + 532)))) then
				v11.Cast(v17.ShadowWordDeath);
				return "Shadow Word Death DPS - Atone Numbers Proper;";
			end
			if (v32:IsReady() and v79 and v7:IsSpellInRange(v17.MindBlast) and (v6:ManaPercentage() <= v28.Discipline.ShadowfiendMana)) then
				v11.Cast(v32);
				return "Mindbender/Shadow Fiend DPS";
			end
			if (v17.MindBlast:IsReady() and v78 and not v6:IsMoving() and v7:IsSpellInRange(v17.MindBlast)) then
				v11.Cast(v17.MindBlast);
				return "Mind Blast Filler DPS";
			end
			if (v17.ShadowWordPain:IsReady() and v7:DebuffRefreshable(v17.ShadowWordPainDebuff) and v7:IsSpellInRange(v17.MindBlast)) then
				if v14(v17.ShadowWordPain) then
					return "shadow_word_pain main 60";
				end
			end
			if v28.DiscExtras.UseHolyNova then
				if ((v17.HolyNova:IsReady()) and (v22 >= (3 + 0))) then
					if v14(v17.HolyNova) then
						return "holy_nova main 72";
					end
				end
			end
			if ((v7:DebuffUp(v17.ShadowWordPainDebuff)) and (v53(v17.Smite)) and v7:IsSpellInRange(v17.MindBlast) and not v6:IsMoving()) then
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
local function v86()
	if (v27.General.AutoTab and v6:AffectingCombat()) then
		v11.TopPanelAlternative:ChangeIcon(1 + 0, 6 - 3);
		return "Auto tab to target";
	end
end
local v87 = nil;
local function v88()
	if v11.ToggleIconFrame:GetToggle(1210 - (373 + 829)) then
		if not v87 then
			v87 = GetTime();
			print("Ramp Timer gestartet bei:", v87);
		end
		if ((GetTime() - v87) >= (751 - (476 + 255))) then
			v11.ToggleIconFrame:ToggleState(1138 - (369 + 761));
			print("Ramp Off");
			v87 = nil;
		end
	else
		v87 = nil;
	end
end
local function v89()
	if v26.ShouldStopCastUpdate() then
		v11.CastMacro(4 + 2, true);
		return "Stop Cast For Silence";
	end
	v44();
	local v131 = v26.HealthPotions();
	if v131 then
		return v131;
	end
	if (not v6:IsMounted() and not v6:IsChanneling() and not v6:PrevGCD(1 - 0, v17.UltimatePentience) and (not v6:AffectingCombat() or (v75 and not v6:AffectingCombat()))) then
		if (not v6:AffectingCombat() or v75) then
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
			v131 = v45();
			if v131 then
				return v131;
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
	if (not v6:IsMounted() and not v6:IsChanneling() and (v26.TargetIsValid() or v6:AffectingCombat() or v75)) then
		if v6:IsChanneling(v17.UltimatePentience) then
			return "Dont cut UltimatePentience";
		end
		if (not v6:AffectingCombat() or v75) then
			v131 = v45();
			if v131 then
				return v131;
			end
		end
		if (v68 and v17.Purify:IsReady() and not v6:IsInRaid()) then
			if v17.ImprovedPurify:IsAvailable() then
				v131 = v26.AfflictedLogic(v17.Purify);
				if v131 then
					return v131;
				end
			end
			v131 = v26.DispelCycle(v17.Purify, "Magic", nil, v25);
			if v131 then
				return v131;
			end
			if v17.ImprovedPurify:IsAvailable() then
				v131 = v26.DispelCycle(v17.Purify, "Disease", nil, v25);
				if v131 then
					return v131;
				end
			end
		end
		if (v68 and v17.Purify:IsReady() and v6:IsInRaid()) then
			v131 = v26.DispelCycle(v17.Purify, "Raid", nil, v25);
			if v131 then
				return v131;
			end
		end
		if (v17.PsychicScream:IsReady() and v28.Discipline.ScreamInt) then
			v131 = v26.InterruptCycle(v17.PsychicScream, 14 - 6, false, nil, true, true);
			if v131 then
				return v131;
			end
		end
		if (v6:AffectingCombat() and v17.DispelMagic:IsReady()) then
			v131 = v26.PurgeCycle(v17.DispelMagic, 278 - (64 + 174), false, v28.Commons.TabForDispelMagic);
			if v131 then
				return v131;
			end
		end
		v131 = v36(v28.Discipline.Trinket1HP, v28.Discipline.Trinket1Use, v28.Discipline.Trinket2HP, v28.Discipline.Trinket2Use, v25);
		if v131 then
			return v131;
		end
		v131 = v85();
		if v131 then
			return v131;
		end
	end
end
local function v90()
	v11.ResetToggle();
	v11:UpdateMacro("macro1", "/use 16");
	v11:UpdateMacro("macro6", "/stopcasting");
	v28.Discipline.Display();
	v11.ToggleIconFrame:AddButtonCustom("O", 1 + 0, "OOC", "ooc");
	v11.ToggleIconFrame:AddButtonCustom("D", 2 - 0, "Dispel", "dispel");
	v11.ToggleIconFrame:AddButtonCustom("S", 339 - (144 + 192), "Spread", "spread");
	v11.ToggleIconFrame:AddButtonCustom("P", 220 - (42 + 174), "Power Word Radiance", "powerwordradiance");
	v11.ToggleIconFrame:AddButtonCustom("I", 4 + 1, "Power Infusion", "powerinfusion");
	v11.ToggleIconFrame:AddButtonCustom("F", 5 + 1, "Shadowfiend", "shadowfiend");
	v11.ToggleIconFrame:AddButtonCustom("MB", 3 + 4, "Mind Blast", "mindblast");
	v11.Print("Discipline Priest rotation has been Updated for has been updated for Season 2 - Updated : 2/26/25");
end
v11.SetAPL(1760 - (363 + 1141), v89, v90, v84);
