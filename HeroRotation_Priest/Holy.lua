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
local v17 = v9.Priest.Holy;
local v18 = v10.Priest.Holy;
local v19 = {v18.ScreamingBlackDragonScale:ID(),v18.BroodkeepersPromise:ID()};
local v20, v21;
local v22;
local v23 = v9(464134 - 223691);
local v24 = v9(972426 - 594916);
local v25 = v9(389798 - (555 + 64));
local v26 = v9(392565 - (857 + 74));
local v27 = v11.Commons().Everyone;
local v28 = v11.GUISettingsGet();
local v29 = {General=v28.General,Commons=v28.APL.Priest.Commons,Holy=v28.APL.Priest.Holy,Healing=((not v6:IsInRaid() and v28.APL.Priest.HolyHealing) or v28.APL.Priest.HolyRaidHealing),AoE=((not v6:IsInRaid() and v28.APL.Priest.HolyAoE) or v28.APL.Priest.HolyRaidAoE),Cooldowns=v28.APL.Priest.HolyCooldowns};
local function v30(v68)
	return v68:NPCID() == (205128 - (367 + 201));
end
local function v31(v69)
	return v69:NPCID() == (205700 - (214 + 713));
end
local function v32(v70)
	return (v70:NPCID() == (51177 + 153272)) or (v70:NPCID() == (32785 + 175674)) or (v70:NPCID() == (209338 - (282 + 595))) or (v70:NPCID() == (209437 - (1523 + 114))) or (v70:NPCID() == (174921 + 19725)) or (v70:NPCID() == (303066 - 90476));
end
local function v33()
	return v32(v7) and not v6:CanAttack(v7);
end
local function v34(v71)
	if ((v27.DebuffCountWithStacks(v71, v23, 1068 - (68 + 997)) >= (1272 - (226 + 1044))) or (v27.DebuffCount(v71, v25) >= (12 - 9)) or (v27.DebuffCountWithStacks(v71, v24, 122 - (32 + 85)) >= (3 + 0)) or (v27.DebuffCount(v71, v26) >= (1 + 1))) then
		return true;
	end
	return false;
end
local v35 = v27.converArrayToList({(461671 - 268141),(35934 - 16360),(361132 - (67 + 113)),(467264 - 276945),(49569 - 37097),(32420 - 20378),(265935 + 99415),(38934 - 25184),(149992 - 35942),(258748 - 144697),(35671 + 169509),(263066 + 2121),(833667 - 568394),(122649 - 90765),(740421 - 508526),(803982 - 349609),(108004 - (44 + 386)),(547 + 1172),(48340 - (201 + 571)),(204116 - 155088),(555923 - 403644),(201025 - (814 + 45)),(10466 + 183757),(384295 - (261 + 624)),(103640 - (1020 + 60)),(1322982 - 932568),(42122 + 64829),(104290 - (760 + 987)),(375853 - (745 + 21))});
local v36 = v27.converArrayToList({(13 - 8),(1 + 7),(1058 - (87 + 968)),(2 + 0),(1420 - (447 + 966)),(1826 - (1703 + 114)),(17 - 6),(4 + 8),(27 - (9 + 5))});
local function v37(v72, v73)
	return v73[v72];
end
local function v38(v74)
	local v75 = nil;
	if v29.Holy.SelectPI then
		local v102 = (v6:IsInRaid() and v5(v29.Holy.PIRaidUnit)) or v5(v29.Holy.PIGroupUnit);
		if (v102:Exists() and not v102:IsDeadOrGhost()) then
			return v102;
		end
	end
	for v93, v94 in pairs(v74) do
		if (v94:Exists() and not v94:IsDeadOrGhost() and (v94:Role() == "DAMAGER") and v37(v94:ClassID(), v36)) then
			if (v94:BuffDown(v17.PowerInfusion) and v27.unitHasBuffFromList(v35, v94)) then
				v75 = v94;
				break;
			end
		end
	end
	if not v75 then
		for v103, v104 in pairs(v74) do
			if (v104:Exists() and not v104:IsDeadOrGhost() and (v104:Role() == "DAMAGER")) then
				if (v104:BuffDown(v17.PowerInfusion) and v27.unitHasBuffFromList(v35, v104)) then
					v75 = v104;
					break;
				end
			end
		end
	end
	return v75;
end
local v39 = v27.converArrayToList({(439738 - (243 + 1022)),(362060 + 76819),(365202 + 83645),(259256 - (1869 + 61)),(960491 - 687780),(60122 + 379243),(412225 + 26652),(452193 - (140 + 831)),(436964 - (15 + 703)),(440906 - (262 + 176)),(325597 - (198 + 490)),(769054 - 448440),(571850 - 299188),(43544 + 227046),(892975 - 623709),(2233265 - 1783821),(37003 + 401492)});
local v40 = v27.converArrayToList({(441304 - (660 + 176)),(446919 - (14 + 188)),(177377 + 263839),(420664 + 16869),(697506 - 258165),(242231 + 208871),(432513 - (115 + 281)),(359536 + 74716),(1565085 - 1138259),(648544 - 199656),(1213064 - 778971),(458416 - (970 + 695)),(453929 - (582 + 1408)),(568553 - 116682),(453789 - (1195 + 629)),(460333 - (187 + 54)),(229407 + 97990),(683735 - 363139),(35533 + 418906),(429535 - (451 + 549)),(662921 - 236947),(430263 - (746 + 638)),(706019 - 241007),(426460 - (1535 + 46)),(63608 + 375969),(27456 + 416038),(424791 - (899 + 568)),(1034094 - 606765),(323439 - (60 + 230)),(38534 + 283135),(323425 - (569 + 242)),(18404 + 303417),(324007 - (721 + 530)),(837288 - 502147),(334185 - (271 + 429)),(335133 - (1408 + 92)),(323042 - (993 + 295)),(464353 - (418 + 753)),(47168 + 410496),(113751 + 336344),(451846 - (1749 + 20)),(450766 - (1249 + 73)),(444652 - (466 + 679)),(1290579 - 839357),(134999 + 291735),(1283276 - 848621),(439906 - (4 + 110)),(428198 - (41 + 1386)),(291454 + 137973)});
local function v41()
	local v76 = v6:GetEnemiesInRange(89 - 49);
	for v95, v96 in pairs(v76) do
		if v39[v96:CastSpellID() or v96:ChannelSpellID()] then
			return true;
		end
	end
end
local function v42()
	local v77 = v6:GetEnemiesInRange(115 - 75);
	for v97, v98 in pairs(v77) do
		if v40[v98:CastSpellID() or v98:ChannelSpellID()] then
			return true;
		end
	end
end
local function v43(v78)
	local v79 = nil;
	local v80 = -math.huge;
	for v99, v100 in pairs(v78) do
		local v101 = v100:HealthPercentage();
		if (v101 > v80) then
			v80 = v101;
			v79 = v100;
		end
	end
	if v79 then
		return v79;
	else
		return nil;
	end
end
local function v44()
	if (v17.PowerWordFortitude:IsCastable() and not v6:DebuffUp(v17.Corruption) and ((v27.GroupBuffMissing(v17.PowerWordFortitudeBuff) and (v29.Commons.PowerWordFortitude == "check whole group") and (v6:IsInRaidArea() or v6:IsInDungeonArea())) or (v6:BuffDown(v17.PowerWordFortitudeBuff, true) and ((v29.Commons.PowerWordFortitude == "only check us") or (v29.Commons.PowerWordFortitude == "check whole group")))) and not v6:IsMounted()) then
		if v14(v17.PowerWordFortitude) then
			return "power_word_fortitude precombat";
		end
	end
end
local function v45(v81, v82, v83, v84, v85)
	local v86, v87, v88 = v6:GetUseableItems(v19, 179 - (122 + 44));
	if (v86 and v27.AoELogic(v81, v82, v85)) then
		if v14(v86) then
			return "trinket1 trinkets 2";
		end
	end
	local v89, v87, v90 = v6:GetUseableItems(v19, 23 - 9);
	if (v89 and v27.AoELogic(v83, v84, v85)) then
		if v14(v89) then
			return "trinket2 trinkets 4";
		end
	end
end
local v46 = nil;
local function v47()
	if v6:IsMoving() then
		if not v46 then
			v46 = GetTime();
		end
		return GetTime() - v46;
	else
		if v46 then
			v46 = nil;
		end
		return 0 - 0;
	end
end
local v48, v49, v50, v51, v52, v53, v54, v55;
local v56, v57;
local v58, v59;
local v60 = 0 + 0;
local v61, v62, v63;
local function v64()
	v29.Healing = (not v6:IsInRaid() and v28.APL.Priest.HolyHealing) or v28.APL.Priest.HolyRaidHealing;
	v29.AoE = (not v6:IsInRaid() and v28.APL.Priest.HolyAoE) or v28.APL.Priest.HolyRaidAoE;
	v58 = (not v6:IsInRaid() and v29.Cooldowns.ApotheosisPartyCount) or v29.Cooldowns.ApotheosisRaidCount;
	v59 = (not v6:IsInRaid() and v29.Cooldowns.PremPCount) or v29.Cooldowns.PremRCount;
	v61 = (not v6:IsInRaid() and v29.Cooldowns.LightWellPCount) or v29.Cooldowns.LightWellRCount;
	v56 = v11.ToggleIconFrame:GetToggle(1 + 0);
	v52 = v11.ToggleIconFrame:GetToggle(5 - 2);
	v53 = v11.ToggleIconFrame:GetToggle(67 - (30 + 35));
	v54 = v11.ToggleIconFrame:GetToggle(3 + 1);
	v62 = v11.ToggleIconFrame:GetToggle(1262 - (1043 + 214));
	v63 = (v17.MiraculousRecoveryT:IsAvailable() and (185 - 136)) or (1245 - (323 + 889));
	v22 = v27.UnitsinRange(v17.Heal);
	v20 = v6:GetEnemiesInMeleeRange(31 - 19);
	HighestHealthUnitSelected = v43(v22);
	if v12() then
		v21 = #v20;
	else
		v21 = 581 - (361 + 219);
	end
	v48, v49 = v27.GetLowestHealthUnit(v22);
	v50 = v48:HealthPercentageWeighted();
	v51 = v27.GetLowestHealthUnitWithoutBuff(v22, v17.Renew);
	if v54 then
		if (v17.PowerInfusion:IsReady() and ((v60 < (GetTime() + (321 - (53 + 267)))) or not v55)) then
			v55 = v38(v22);
			if v55 then
				timeSinceLastPIUnit = GetTime();
			end
		end
	end
end
local function v65()
	if v29.Holy.Movement then
		if (v17.AngelicFeather:IsReady() and v6:BuffDown(v17.AngelicFeatherBuff) and v6:IsMoving() and (v47() > (1 + 0))) then
			v11.CastTarget(v17.AngelicFeather, v11.TName().PLAYER);
			return "Angelic Feather";
		end
		if (v17.PowerWordShield:IsReady() and v17.BodyAndSoul:IsAvailable() and v6:BuffDown(v17.WeakenedSoul) and v6:IsMoving() and (v47() > (414 - (15 + 398)))) then
			v6:Cast(v17.PowerWordShield);
			return " PWS For Body and Soul";
		end
	end
	if v54 then
		if (v55 ~= nil) then
			if v17.PowerInfusion:IsReady() then
				v55:Cast(v17.PowerInfusion, true);
				return "PI -- Has Active Buff on List ? " .. tostring(v27.unitHasBuffFromList(v35, v55)) .. " And is a vlid Class " .. tostring(v37(v55:ClassID(), v36)) .. " Unit Name : " .. v55:Name() .. " Unit Role : " .. v55:Role() .. " Unit GUID : " .. v55:GUID() .. "Unit ID : " .. v55:ID() .. "Unit Class ID " .. v55:ClassID();
			end
		end
	end
	if ((v50 >= (1027 - (18 + 964))) and v31(v7) and (v17.Purify:CooldownDown() or not v17.ImprovedPurify:IsAvailable()) and v7:IsSpellInRange(v17.FlashHeal)) then
		if (v17.PowerWordLifeCast:IsAvailable() and v17.PowerWordLife:CooldownUp()) then
			v14(v17.PowerWordLifeCast);
			return;
		end
		if (v17.FlashHeal:IsReady() and not v6:IsMoving()) then
			v14(v17.FlashHeal);
			return;
		end
	end
	if ((v50 >= (131 - 96)) and v33() and (v7:HealthPercentage() > (0 + 0)) and (v7:HealthPercentage() < (64 + 36))) then
		if (v17.PowerWordLifeCast:IsAvailable() and v17.PowerWordLife:CooldownUp() and (v7:HealthPercentage() < v63)) then
			v14(v17.PowerWordLifeCast);
			return;
		end
		if (v17.FlashHeal:IsReady() and not v6:IsMoving()) then
			v14(v17.FlashHeal);
			return;
		end
	end
	if (v17.DesperatePrayer:IsReady() and (v6:HealthPercentage() <= v29.Holy.DesperatePrayerHP)) then
		v11.Cast(v17.DesperatePrayer);
		return "Desperate Prayer " .. v6:HealthPercentage();
	end
	if (v17.Fade:IsReady() and (v29.Holy.FadeHP > (850 - (20 + 830))) and ((v6:HealthPercentage() <= v29.Holy.FadeHP) or v42() or v41())) then
		v11.Cast(v17.Fade);
		return "Fade " .. v6:HealthPercentage();
	end
	if v29.Holy.VoidShiftTankOnly then
		if (v49 ~= nil) then
			if (v17.VoidShift:IsReady() and (v49:HealthPercentage() < (20 + 5)) and (v6:HealthPercentage() >= (171 - (116 + 10)))) then
				v49:Cast(v17.VoidShift);
				return "Void Shift On Tank";
			end
		end
	elseif (v17.VoidShift:IsReady() and (v50 < (2 + 23)) and (v6:HealthPercentage() >= (783 - (542 + 196)))) then
		v48:Cast(v17.VoidShift);
		return "Void Shift on Lowest Unit";
	end
	if (v17.PowerWordLifeCast:IsAvailable() and v17.PowerWordLife:CooldownUp() and (v48:HealthPercentage() < v63)) then
		v48:Cast(v17.PowerWordLifeCast);
		return "Power Word Life";
	end
	if v53 then
		if (v17.MassDispel:IsReady() and not v6:IsMoving() and v34(v22)) then
			v11.Cast(v17.MassDispel);
			return "Mass Dispel casted";
		end
	end
	if (v17.DivineWord:IsReady() and (v17.HolyWordSanctify:CooldownUp() or v17.HolyWordSerenity:CooldownUp()) and v6:BuffDown(v17.DivineWord) and (v50 <= v29.Healing.DWHP)) then
		v11.Cast(v17.DivineWord);
		return "Divine Word Casted";
	end
	if (v6:BuffUp(v17.PremonitionSolace) and v6:AffectingCombat()) then
		if (v17.HolyWordSerenity:IsReady() and (v17.HolyWordSerenity:Charges() > (0 - 0)) and not v6:BuffUp(v17.SurgeofLight)) then
			v48:Cast(v17.HolyWordSerenity);
			return "Serenity for Solace";
		end
		if (not v17.HolyWordSerenity:IsReady() or v6:BuffUp(v17.SurgeofLight)) then
			v48:Cast(v17.FlashHeal);
			return "Flash for Solace";
		end
	end
	if v6:BuffUp(v17.PremonitionInsight) then
		if (v49 ~= nil) then
			if (v17.PrayerofMending:IsReady() and v49:BuffDown(v17.PrayerofMendingBuff)) then
				v49:Cast(v17.PrayerofMending);
				return "Prayer of Mending on Lowest Tank for CD Reduction";
			end
		elseif (v17.PrayerofMending:IsReady() and v48:BuffDown(v17.PrayerofMendingBuff)) then
			v48:Cast(v17.PrayerofMending);
			return "PoM on Lowest Unit for CD Reduction ";
		end
	end
	if (v6:AffectingCombat() and v6:BuffUp(v17.PremonitionPiety)) then
		if v6:IsInRaid() then
			if (v17.GuardianSpirit:IsReady() and v17.HolyWordSerenity:IsReady() and (v17.HolyWordSerenity:Charges() > (0 + 0))) then
				v6:Cast(v17.GuardianSpirit);
				return "GA on Self - Piety Logic";
			end
			if (v17.HolyWordSerenity:IsReady() and (v17.HolyWordSerenity:Charges() > (0 + 0))) then
				v6:Cast(v17.HolyWordSerenity);
				return "Serenity for Piety OH";
			end
		end
		if not v6:IsInRaid() then
			if (HighestHealthUnitSelected ~= nil) then
				if (v17.HolyWordSerenity:IsReady() and (v17.HolyWordSerenity:Charges() > (0 + 0))) then
					HighestHealthUnitSelected:Cast(v17.HolyWordSerenity);
					return "Serenity for Piety OH";
				end
				if (not v17.HolyWordSerenity:IsReady() and v17.FlashHeal:IsReady() and (not v6:IsMoving() or v6:BuffUp(v17.SurgeofLight))) then
					HighestHealthUnitSelected:Cast(v17.FlashHeal);
					return "Flash for Piety OH";
				end
			end
			if (HighestHealthUnitSelected == nil) then
				if (v17.HolyWordSerenity:IsReady() and (v17.HolyWordSerenity:Charges() > (0 - 0))) then
					v6:Cast(v17.HolyWordSerenity);
					return "Serenity for Piety OH - Player";
				end
				if (not v17.HolyWordSerenity:IsReady() and v17.FlashHeal:IsReady() and (not v6:IsMoving() or v6:BuffUp(v17.SurgeofLight))) then
					v6:Cast(v17.FlashHeal);
					return "Flash for Piety OH - Player";
				end
			end
		end
	end
	if (v17.PremonitionTalent:IsAvailable() and v29.Cooldowns.PremUse) then
		if (v17.PrayerofMending:IsReady() and v17.PremonitionInsight:IsReady()) then
			v11.Cast(v17.PremonitionTalent);
			return "PremonitionInsight";
		end
		if (v6:AffectingCombat() and v17.PremonitionPiety:IsReady()) then
			if (v27.AoELogicWithCount(v29.Cooldowns.PremHP, v59, "With Logic", v22) or v42() or v41()) then
				v11.Cast(v17.PremonitionTalent);
				return "PremonitionPiety";
			end
		end
		if (v6:AffectingCombat() and v17.PremonitionSolace:IsReady()) then
			if (v42() or v41()) then
				v11.Cast(v17.PremonitionTalent);
				return "PremonitionSolace";
			end
		end
		if (v17.PremonitionClairvoyanceT:IsAvailable() and v17.PremonitionClairvoyance:IsReady()) then
			if (v27.AoELogicWithCount(v29.Cooldowns.PremHP, v59, "With Logic", v22) or v42() or v41() or v17.PrayerofMending:IsReady()) then
				v11.Cast(v17.PremonitionTalent);
				return "PremonitionClairvoyance";
			end
		end
	end
	if v29.Healing.GSTank then
		if (v49 ~= nil) then
			if (v17.GuardianSpirit:IsReady() and (v49:HealthPercentage() >= (4 - 2)) and (v49:HealthPercentage() <= v29.Healing.GSHP)) then
				v49:Cast(v17.GuardianSpirit);
				return "GS on Tank";
			end
		end
	elseif (v17.GuardianSpirit:IsReady() and (v50 >= (1553 - (1126 + 425))) and (v50 <= v29.Healing.GSHP)) then
		v48:Cast(v17.GuardianSpirit);
		return "GS on Lowest Unit";
	end
	if (v17.Apotheosis:IsReady() and (v17.HolyWordSanctify:Charges() < (406 - (118 + 287))) and (v17.HolyWordSerenity:Charges() < (3 - 2)) and v27.AoELogicWithCount(v29.Cooldowns.ApotheosisHP, v58, v29.Cooldowns.ApotheosisUsage, v22)) then
		v11.Cast(v17.Apotheosis);
		return " Apoth per settings";
	end
	if (v17.HolyWordSalvation:IsReady() and not v6:IsMoving() and v27.AoELogicWithCount(v29.AoE.SalvHP, v29.AoE.SalvCount, "With Logic", v22)) then
		v11.Cast(v17.HolyWordSalvation);
		return " HWS per settings";
	end
	if (v17.LightWell:IsReady() and v27.AoELogicWithCount(v29.Cooldowns.LightWellHP, v61, "With Logic", v22)) then
		v11.Cast(v17.LightWell);
		return " Lightwell per settings";
	end
	if (v17.DivineHymn:IsReady() and not v6:IsMoving() and v27.AoELogicWithCount(v29.AoE.DHHP, v29.AoE.DHCount, "With Logic", v22)) then
		v11.Cast(v17.DivineHymn);
		return "Divine Hymn Casted";
	end
	if (v52 and not v62) then
		if (v17.HolyWordSanctify:IsReady() and (v17.HolyWordSanctify:Charges() > (1121 - (118 + 1003))) and ((v27.AoELogicWithCount(v29.AoE.SancHP, v29.AoE.SancCount, "With Logic", v22) and not v6:PrevGCD(2 - 1, v17.HolyWordSanctify)) or (v6:BuffUp(v17.SacredRev) and (v6:BuffStack(v17.SacredRev) >= (379 - (142 + 235)))))) then
			v11.Cast(v17.HolyWordSanctify);
			return "Sanc Casted";
		end
	end
	if (v17.HolyNova:IsReady() and v27.AoELogicWithCount(v29.AoE.HolyNovaHP, v29.AoE.HolyNovaCount, "With Logic", v22) and (v6:BuffStack(v17.Rhapsody) == (90 - 70))) then
		v11.Cast(v17.HolyNova);
		return "Holy Nova with Max Stacks";
	end
	if (v62 and (v6:IsInParty() or v6:IsInRaid())) then
		if (v50 <= (7 + 23)) then
			v11.CastMacro(979 - (553 + 424), true);
		end
	end
	if not v62 then
		if (v17.HolyWordSerenity:IsReady() and v6:BuffDown(v17.ResonateWords) and (v50 <= v29.Healing.HolyWordSerenityHP) and (v17.HolyWordSerenity:Charges() > (0 - 0))) then
			v48:Cast(v17.HolyWordSerenity);
			return "Holy Word Sern Cast";
		end
		if (v17.CoH:IsReady() and ((v29.AoE.CoHOnlyMoving and v6:IsMoving()) or not v29.AoE.CoHOnlyMoving) and (v27.AoELogicWithCount(v29.AoE.CoHHP, v29.AoE.CoHCount, "With Logic", v22) or (v17.PrayerCircle:IsAvailable() and v6:BuffDown(v17.PrayerCircle) and v27.AoELogicWithCount(v29.AoE.PoHHP, v29.AoE.PoHCount, "With Logic", v22)))) then
			v48:Cast(v17.CoH);
			return "CoH Per Settings";
		end
		if (v49 ~= nil) then
			if (v17.PrayerofMending:IsReady() and v49:BuffDown(v17.PrayerofMendingBuff)) then
				v49:Cast(v17.PrayerofMending);
				return "Prayer of Mending on Lowest Tank";
			end
		elseif (v17.PrayerofMending:IsReady() and (v48:HealthPercentage() <= (75 + 10)) and v48:BuffDown(v17.PrayerofMendingBuff)) then
			v48:Cast(v17.PrayerofMending);
			return "PoM on Lowest Unit due to No tank needing it";
		end
		if (v17.PoH:IsReady() and (v27.AoELogicWithCount(v29.AoE.PoHHP, v29.AoE.PoHCount, "With Logic", v22) or (v6:BuffUp(v17.PrayerCircle) and (v6:BuffRemains(v17.PrayerCircle) < (1.8 + 0)))) and not v6:IsMoving()) then
			v48:Cast(v17.PoH);
			return "PoH Cast";
		end
		if (v17.DivineStar:IsReady() and v27.AoELogicWithCount(v29.AoE.DSHP, v29.AoE.DSCount, "With Logic", v22) and v6:AffectingCombat()) then
			v11.Cast(v17.DivineStar);
			return "Divine Star Casted Per Settings";
		end
		if (v51 ~= nil) then
			if (v17.Renew:IsReady() and (((v51:HealthPercentage() <= v29.Holy.RenewHP) and not v29.Holy.RenewOnlyMoving) or (v29.Holy.RenewOnlyMoving and v6:IsMoving() and (v51:HealthPercentage() <= v29.Holy.RenewMovingHP)))) then
				v51:Cast(v17.Renew);
				return "Renew on Unit w/o it";
			end
		end
		if (v17.Halo:IsReady() and not v6:IsMoving() and v27.AoELogicWithCount(v29.AoE.HaloHP, v29.AoE.HaloCount, "With Logic", v22) and v6:AffectingCombat()) then
			v11.Cast(v17.Halo);
			return "Halo Casted";
		end
		if (v17.FlashHeal:IsReady() and v17.LightWeaver:IsAvailable() and (v50 <= v29.Healing.HealHP) and (not v6:IsMoving() or v6:BuffUp(v17.SurgeofLight)) and (v6:BuffDown(v17.LightWeaver) or (v6:BuffUp(v17.LightWeaver) and (v6:BuffStack(v17.LightWeaver) == (1 + 0)) and not v6:IsCasting(v17.FlashHeal)))) then
			v48:Cast(v17.FlashHeal);
			return "Light Weaver Stacks for Heal";
		end
		if (v17.FlashHeal:IsReady() and (v50 <= v29.Healing.FlashHealHP) and (not v6:IsMoving() or v6:BuffUp(v17.SurgeofLight))) then
			v48:Cast(v17.FlashHeal);
			return "Flash Heal Casted";
		end
		if (v17.FlashHeal:IsReady() and v6:BuffUp(v17.SurgeofLight) and (((v50 <= v29.Healing.FlashHealSurge1HP) and (v6:BuffStack(v17.SurgeofLight) == (1 + 0))) or ((v50 <= v29.Healing.FlashHealSurge2HP) and (v6:BuffStack(v17.SurgeofLight) == (2 + 0))))) then
			v48:Cast(v17.FlashHeal);
			return "Flash Heal With Surge of Light Casted";
		end
		if (v17.Heal:IsReady() and not v6:IsMoving() and (v50 <= v29.Healing.HealHP) and ((v17.LightWeaver:IsAvailable() and v6:BuffUp(v17.LightWeaver) and (v6:BuffStack(v17.LightWeaver) == (4 - 2))) or not v17.LightWeaver:IsAvailable())) then
			v48:Cast(v17.Heal);
			return "Heal Cast";
		end
	end
	if (v27.TargetIsValid() and (v7:AffectingCombat() or (v29.Holy.AttackOOC and v56)) and not v30(v7)) then
		if (v17.HolyWordChastise:IsReady() and v62 and v17.DivineWord:IsReady()) then
			v11.Cast(v17.DivineWord);
			return "Divine Word DPS Only";
		end
		if (v17.HolyWordChastise:IsReady() and v7:IsSpellInRange(v17.HolyWordChastise) and v6:AffectingCombat() and ((v21 > (7 - 4)) or v7:DebuffUp(v17.HolyFireDebuff))) then
			v11.Cast(v17.HolyWordChastise);
			return "Chastise Casted";
		end
		if (v17.Mindbender:IsReady() and v7:IsSpellInRange(v17.Mindbender) and (v6:ManaPercentage() <= v29.Holy.ShadowfiendMana)) then
			v11.Cast(v17.Mindbender);
			return "Mindbender/Shadow Fiend DPS";
		end
		if v17.Mindgames:IsReady() then
			if v14(v17.Mindgames) then
				return "mindgames 57";
			end
		end
		if v29.Commons.Enabled.Items then
			if v18.Iridal:IsEquippedAndReady() then
				if not v6:IsMoving() then
					v11.CastMacro(2 - 1, nil, nil, v18.Iridal);
					return "weapon cast Iridal";
				end
			else
				local v105, v106, v107 = v6:GetUseableItems(v19, 5 + 11);
				if (v105 and v105:IsReady() and v7:IsInRange(v107)) then
					v11.CastMacro(4 - 3);
					return "weapon cast";
				end
			end
		end
		if (v17.HolyFire:IsReady() and v6:BuffUp(v17.EmpyrealBlaze) and v7:IsSpellInRange(v17.HolyFire)) then
			v11.Cast(v17.HolyFire);
			return "Holy Fire with Blaze";
		end
		if (v17.HolyNova:IsReady() and (v21 > (756 - (239 + 514))) and ((v17.RhapsodyTalent:IsAvailable() and (v6:BuffStack(v17.Rhapsody) == (8 + 12))) or not v17.RhapsodyTalent:IsAvailable() or (v21 >= (1334 - (797 + 532))))) then
			v11.Cast(v17.HolyNova);
			return "Holy Nova";
		end
		if (v17.HolyFire:IsReady() and v7:IsSpellInRange(v17.HolyFire) and not v6:IsMoving()) then
			v11.Cast(v17.HolyFire);
			return "Holy Fire";
		end
		if (v17.ShadowWordPain:IsReady() and v7:IsSpellInRange(v17.ShadowWordPain) and v7:DebuffRefreshable(v17.ShadowWordPainDebuff)) then
			v11.Cast(v17.ShadowWordPain);
			return "SWP";
		end
		if (v17.ShadowWordDeath:IsReady() and v7:IsSpellInRange(v17.ShadowWordDeath) and (v7:HealthPercentage() <= (15 + 5)) and (v6:HealthPercentage() >= (12 + 23))) then
			v11.Cast(v17.ShadowWordDeath);
			return "ShadowWordDeath";
		end
		if (v17.Smite:IsReady() and v7:IsSpellInRange(v17.Smite) and not v6:IsMoving()) then
			v11.Cast(v17.Smite);
			return "Smite";
		end
	end
end
local function v66()
	if v27.ShouldStopCastUpdate() then
		v11.CastMacro(13 - 7, true);
		return "Stop Cast For Silence";
	end
	if (not v6:IsMounted() and not v6:IsChanneling() and (not v6:AffectingCombat() or (v56 and not v6:AffectingCombat()))) then
		if (not v6:AffectingCombat() or v56) then
			if (v29.Holy.Movement and not v6:AffectingCombat()) then
				if (v17.AngelicFeather:IsReady() and v6:BuffDown(v17.AngelicFeatherBuff) and v6:IsMoving()) then
					v11.CastTarget(v17.AngelicFeather, v11.TName().PLAYER);
					return "Angelic Feather";
				end
				if (v17.PowerWordShield:IsCastable() and v17.BodyAndSoul:IsAvailable() and v6:IsMoving() and v6:BuffDown(v17.AngelicFeatherBuff) and v6:BuffDown(v17.BodyAndSoulBuff) and not v6:IsMounted()) then
					v6:Cast(v17.PowerWordShield);
					return "PWS Body and Soul";
				end
			end
			v57 = v44();
			if v57 then
				return v57;
			end
		end
	end
	if (v17.Fade:IsCastable() and v17.Phantasm:IsAvailable() and v6:DebuffUp(v17.EntangledDebuff) and v29.Commons.AutoFadeEntangling) then
		if v14(v17.Fade) then
			return "Fade for entangling";
		end
	end
	if (not v6:IsMounted() and not v6:IsChanneling() and (v27.TargetIsValid() or v6:AffectingCombat() or v56)) then
		if (not v6:AffectingCombat() or v56) then
			v57 = v44();
			if v57 then
				return v57;
			end
		end
		if (v53 and v17.Purify:IsReady() and not v6:IsInRaid()) then
			if v17.ImprovedPurify:IsAvailable() then
				v57 = v27.AfflictedLogic(v17.Purify);
				if v57 then
					return v57;
				end
			end
			v57 = v27.DispelCycle(v17.Purify, "Magic", nil, v22);
			if v57 then
				return v57;
			end
			if v17.ImprovedPurify:IsAvailable() then
				v57 = v27.DispelCycle(v17.Purify, "Disease", nil, v22);
				if v57 then
					return v57;
				end
			end
		end
		if (v53 and v17.Purify:IsReady() and v6:IsInRaid()) then
			v57 = v27.DispelCycle(v17.Purify, "Raid", nil, v22);
			if v57 then
				return v57;
			end
		end
		if v17.DominateMind:IsReady() then
			v57 = v27.IncorpCycle(v17.DominateMind, 1232 - (373 + 829), false, false);
			if v57 then
				return v57;
			end
		end
		if (v17.ShackleUndead:IsReady() and (not v17.DominateMind:IsAvailable() or v17.DominateMind:CooldownDown())) then
			v57 = v27.IncorpCycle(v17.ShackleUndead, 761 - (476 + 255), false, false);
			if v57 then
				return v57;
			end
		end
		if (v6:AffectingCombat() and v17.DispelMagic:IsReady()) then
			v57 = v27.PurgeCycle(v17.DispelMagic, 1170 - (369 + 761), false, v29.Commons.TabForDispelMagic);
			if v57 then
				return v57;
			end
		end
		if v17.PsychicScream:IsReady() then
			v57 = v27.InterruptCycle(v17.PsychicScream, 5 + 3, false, nil, true, true);
			if v57 then
				return v57;
			end
		end
		v57 = v45(v29.Cooldowns.Trinket1HP, v29.Cooldowns.Trinket1Use, v29.Cooldowns.Trinket2HP, v29.Cooldowns.Trinket2Use, v22);
		if v57 then
			return v57;
		end
		v57 = v65();
		if v57 then
			return v57;
		end
	end
end
local function v67()
	v11.ResetToggle();
	v29.Holy.Display();
	v11:UpdateMacro("macro1", "/use 16");
	v11:UpdateMacro("macro2", "/hr dpsonly");
	v11:UpdateMacro("macro6", "/stopcasting");
	v11.ToggleIconFrame:AddButtonCustom("O", 1 - 0, "OOC", "ooc");
	v11.ToggleIconFrame:AddButtonCustom("D", 3 - 1, "Dispel", "dispel");
	v11.ToggleIconFrame:AddButtonCustom("P", 241 - (64 + 174), "Power Word Sanctify", "powerwordsanctify");
	v11.ToggleIconFrame:AddButtonCustom("I", 1 + 3, "Power Infusion", "powerinfusion");
	v11.ToggleIconFrame:AddButtonCustom("DP", 7 - 2, "DPS Only", "dpsonly");
	v11.Print("Holy Priest rotation has been updated for Pre-Patch ");
end
v11.SetAPL(593 - (144 + 192), v66, v67, v64);
