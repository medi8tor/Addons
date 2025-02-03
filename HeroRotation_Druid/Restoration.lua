local v0, v1 = ...;
local v2 = HeroDBC.DBC;
local v3 = HeroLib;
local v4 = HeroCache;
local v5 = v3.Unit;
local v6 = v5.Player;
local v7 = v5.Pet;
local v8 = v5.Target;
local v9, v10 = v5.Focus, v5.MouseOver;
local v11 = v3.Spell;
local v12 = v3.MultiSpell;
local v13 = v3.Item;
local v14 = HeroRotation();
local v15 = v14.AoEON;
local v16 = v14.CDsON;
local v17 = v14.Cast;
local v18 = v14.Commons().Everyone.num;
local v19 = v14.Commons().Everyone.bool;
local v20 = math.floor;
local v21 = v14.Commons().Everyone;
local v22 = v14.GUISettingsGet();
local v23 = {General=v22.General,Commons=v22.APL.Druid.Commons,Restoration=v22.APL.Druid.Restoration,Cooldowns=v22.APL.Druid.Restoration.Cooldowns,AoE=((not v6:IsInRaid() and v22.APL.Druid.Restoration.AoEHealing) or v22.APL.Druid.Restoration.RaidAoEHealing),Soul=v22.APL.Druid.Restoration.Soul,TankHealing=v22.APL.Druid.Restoration.TankHealing,Healing=((not v6:IsInRaid() and v22.APL.Druid.Restoration.Healing) or v22.APL.Druid.Restoration.RaidHealing),Defense=v22.APL.Druid.Restoration.Defensives,Lifebloom=v22.APL.Druid.Restoration.Lifebloom};
local v24 = v11.Druid.Restoration;
local v25 = v13.Druid.Restoration;
local v26 = {v25.ScreamingBlackDragonScale:ID(),v25.BroodkeepersPromise:ID()};
local v27, v28;
local v29 = 21447 - 10336;
local v30 = 28620 - 17509;
local v31 = false;
local v32 = false;
local v33 = false;
local v34 = false;
local v35 = false;
local v36 = false;
local v37 = false;
local v38;
v3:RegisterForEvent(function()
	v29 = 11730 - (555 + 64);
	v30 = 12042 - (857 + 74);
end, "PLAYER_REGEN_ENABLED");
local function v39()
	return (v6:StealthUp(true, true) and (569.6 - (367 + 201))) or (928 - (214 + 713));
end
v24.Rake:RegisterPMultiplier(v24.RakeDebuff, v39);
local function v40()
	v31 = v6:BuffUp(v24.EclipseSolar) or v6:BuffUp(v24.EclipseLunar);
	v32 = v6:BuffUp(v24.EclipseSolar) and v6:BuffUp(v24.EclipseLunar);
	v33 = v6:BuffUp(v24.EclipseLunar) and v6:BuffDown(v24.EclipseSolar);
	v34 = v6:BuffUp(v24.EclipseSolar) and v6:BuffDown(v24.EclipseLunar);
	v35 = (not v31 and (((v24.Starfire:Count() == (0 + 0)) and (v24.Wrath:Count() > (0 + 0))) or v6:IsCasting(v24.Wrath))) or v34;
	v36 = (not v31 and (((v24.Wrath:Count() == (877 - (282 + 595))) and (v24.Starfire:Count() > (1637 - (1523 + 114)))) or v6:IsCasting(v24.Starfire))) or v33;
	v37 = not v31 and (v24.Wrath:Count() > (0 + 0)) and (v24.Starfire:Count() > (0 - 0));
end
local function v41(v110)
	return v110:NPCID() == (205625 - (68 + 997));
end
local function v42(v111)
	return v111:NPCID() == (206043 - (226 + 1044));
end
local function v43(v112)
	return (v112:NPCID() == (890253 - 685804)) or (v112:NPCID() == (208576 - (32 + 85))) or (v112:NPCID() == (204294 + 4167)) or (v112:NPCID() == (46081 + 161719)) or (v112:NPCID() == (195603 - (892 + 65))) or (v112:NPCID() == (507139 - 294549));
end
local function v44()
	return v43(v8) and not v6:CanAttack(v8);
end
local v45 = v21.converArrayToList({(804961 - 366488),(439059 - (67 + 113)),(1101992 - 653145),(1022738 - 765412),(734230 - 461519),(319809 + 119556),(1242713 - 803836),(593420 - 142198),(989715 - 553469),(76575 + 363893),(322310 + 2599),(1007587 - 686973),(1048857 - 776195),(863971 - 593381),(476447 - 207181),(449874 - (44 + 386)),(139307 + 299188)});
local v46 = v21.converArrayToList({(441240 - (201 + 571)),(1859802 - 1413085),(1610743 - 1169527),(438392 - (814 + 45)),(23674 + 415667),(451987 - (261 + 624)),(433197 - (1020 + 60)),(1471535 - 1037283),(168100 + 258726),(450635 - (760 + 987)),(434859 - (745 + 21)),(1256816 - 800065),(3695 + 448244),(452926 - (87 + 968)),(410052 + 41913),(461505 - (447 + 966)),(329214 - (1703 + 114)),(525390 - 204794),(129868 + 324571),(428549 - (9 + 5)),(427239 - (243 + 1022)),(353810 + 75069),(378355 + 86657),(426809 - (1869 + 61)),(1548196 - 1108619),(60687 + 382807),(397617 + 25707),(428300 - (140 + 831)),(323867 - (15 + 703)),(322107 - (262 + 176)),(323302 - (198 + 490)),(771949 - 450128),(676911 - 354155),(53932 + 281209),(1105947 - 772462),(1657806 - 1324173),(27151 + 294603),(464018 - (660 + 176)),(457866 - (14 + 188)),(180946 + 269149),(432725 + 17352),(713545 - 264101),(238153 + 205354),(451618 - (115 + 281)),(353312 + 73422),(1593793 - 1159138),(635403 - 195611),(1192602 - 765831),(431092 - (970 + 695))});
local function v47()
	local v113 = v6:GetEnemiesInRange(76 - 36);
	for v158, v159 in pairs(v113) do
		if v45[v159:CastSpellID() or v159:ChannelSpellID()] then
			return true;
		end
	end
end
local function v48()
	local v114 = v6:GetEnemiesInRange(2030 - (582 + 1408));
	for v160, v161 in pairs(v114) do
		if v46[v161:CastSpellID() or v161:ChannelSpellID()] then
			return true;
		end
	end
end
local function v49()
	return v23.Restoration.PredictLogic and (v48() or v47());
end
local function v50(v115)
	return (v115:DebuffStack(v24.AdaptiveSwarmDebuff));
end
local function v51(v116)
	return v116:DebuffRemains(v24.AdaptiveSwarmDebuff) > (6 - 4);
end
local function v52(v117)
	return (v117:DebuffStack(v24.AdaptiveSwarmDebuff) == (1 - 0)) and (v117:DebuffRemains(v24.AdaptiveSwarmDebuff) > (7 - 5));
end
local function v53(v118)
	return (v118:DebuffStack(v24.AdaptiveSwarmDebuff) == (1826 - (1195 + 629))) and (v118:DebuffRemains(v24.AdaptiveSwarmDebuff) > (2 - 0));
end
local function v54(v119)
	return (v119:DebuffStack(v24.AdaptiveSwarmDebuff) == (244 - (187 + 54))) and (v119:DebuffRemains(v24.AdaptiveSwarmDebuff) > (782 - (162 + 618)));
end
local function v55(v120)
	return (v120:DebuffStack(v24.AdaptiveSwarmDebuff) == (3 + 1)) and (v120:DebuffRemains(v24.AdaptiveSwarmDebuff) > (2 + 0));
end
local function v56(v121)
	return v121:DebuffStack(v24.AdaptiveSwarmDebuff) == (0 - 0);
end
local function v57(v122)
	return v122:DebuffRefreshable(v24.SunfireDebuff) and (v30 > (8 - 3));
end
local function v58(v123)
	return (v123:DebuffRefreshable(v24.MoonfireDebuff) and (v30 > (1 + 11)) and ((((v28 <= ((1640 - (1373 + 263)) + ((1004 - (451 + 549)) * v18(CovenantID == (2 + 2))))) or (v6:Energy() < (77 - 27))) and v6:BuffDown(v24.HeartoftheWildBuff)) or (((v28 <= (6 - 2)) or (v6:Energy() < (1434 - (746 + 638)))) and v6:BuffUp(v24.HeartoftheWildBuff))) and v123:DebuffDown(v24.MoonfireDebuff)) or (v6:PrevGCD(1 + 0, v24.Sunfire) and ((v123:DebuffUp(v24.MoonfireDebuff) and (v123:DebuffRemains(v24.MoonfireDebuff) < (v123:DebuffDuration(v24.MoonfireDebuff) * (0.8 - 0)))) or v123:DebuffDown(v24.MoonfireDebuff)) and (v28 == (342 - (218 + 123))));
end
local function v59(v124)
	return ((v124:DebuffRefreshable(v24.RipDebuff) or ((v6:Energy() > (1671 - (1535 + 46))) and (v124:DebuffRemains(v24.RipDebuff) <= (10 + 0)))) and (((v6:ComboPoints() == (1 + 4)) and (v124:TimeToDie() > (v124:DebuffRemains(v24.RipDebuff) + (584 - (306 + 254))))) or (((v124:DebuffRemains(v24.RipDebuff) + (v6:ComboPoints() * (1 + 3))) < v124:TimeToDie()) and ((v124:DebuffRemains(v24.RipDebuff) + (7 - 3) + (v6:ComboPoints() * (1471 - (899 + 568)))) > v124:TimeToDie())))) or (v124:DebuffDown(v24.RipDebuff) and (v6:ComboPoints() > (2 + 0 + (v28 * (4 - 2)))));
end
local function v60(v125)
	return v125:DebuffRefreshable(v24.RakeDebuff) and (v125:TimeToDie() > (613 - (268 + 335))) and ((v6:ComboPoints() < (295 - (60 + 230))) or v125:DebuffRemains(v24.RakeDebuff));
end
local function v61(v126)
	return (v126:DebuffUp(v24.AdaptiveSwarmDebuff));
end
local function v62()
	local v127 = math.floor((v8:TimeToDie() - (576 - (426 + 146))) / (1 + 3));
	if ((v127 - v6:ComboPoints()) < (1457 - (282 + 1174))) then
		return false;
	end
	return v6:ComboPoints() == math.min(v127, 816 - (569 + 242));
end
local function v63(v128)
	return v128:DebuffRefreshable(v24.MoonfireDebuff) and (v128:TimeToDie() > (14 - 9));
end
local function v64(v129, v130, v131, v132, v133)
	local v134, v135, v136 = v6:GetUseableItems(v26, 1 + 12);
	if (v134 and v21.AoELogic(v129, v130, v133)) then
		if v17(v134) then
			return "trinket1 trinkets 2";
		end
	end
	local v137, v135, v138 = v6:GetUseableItems(v26, 1038 - (706 + 318));
	if (v137 and v21.AoELogic(v131, v132, v133)) then
		if v17(v137) then
			return "trinket2 trinkets 4";
		end
	end
end
local function v65()
	if v21.TargetIsValid() then
		local v172 = v8:MinDistance();
		v172 = (v172 and ((v172 - (1259 - (721 + 530))) > (1276 - (945 + 326))) and (v172 - (19 - 11))) or (5 + 0);
		local v173 = v8:MaxDistance();
		v173 = (v173 and ((v173 + (708 - (271 + 429))) > (5 + 0)) and (v173 + (1508 - (1408 + 92)))) or (1091 - (461 + 625));
		local v174 = v6:GetEnemiesInRange(v172);
		local v175 = v6:GetEnemiesInRange(v173);
		local v176 = (((v173 - v172) > (1304 - (993 + 295))) and (#v175 - #v174)) or #v175;
		return ((v176 > (0 + 0)) and v176) or (1171 - (418 + 753));
	end
end
local function v66()
	if (v24.MarkoftheWild:IsCastable() and not v6:DebuffUp(v24.Corruption) and ((v21.GroupBuffMissing(v24.MarkoftheWildBuff) and (v23.Commons.MarkoftheWild == "check whole group") and (v6:IsInRaidArea() or v6:IsInDungeonArea()) and (v6:InstanceDifficulty() ~= (79 + 126))) or (v6:BuffDown(v24.MarkoftheWildBuff, true) and ((v23.Commons.MarkoftheWild == "only check us") or (v23.Commons.MarkoftheWild == "check whole group"))))) then
		if v17(v24.MarkoftheWild) then
			return "mark_of_the_wild precombat";
		end
	end
end
local function v67(v139, v140, v141)
	local v142 = nil;
	local v143 = math.huge;
	for v162, v163 in pairs(v139) do
		if (v163:BuffUp(v140) and not v163:BuffUp(v141)) then
			local v178 = v163:HealthPercentage();
			if (v178 < v143) then
				v143 = v178;
				v142 = v163;
			end
		end
	end
	if v142 then
		return v142;
	else
		return nil;
	end
end
local function v68(v144, v145, v146)
	local v147 = nil;
	local v148 = math.huge;
	for v164, v165 in pairs(v144) do
		if (v165:BuffUp(v145) or v165:BuffUp(v146)) then
			local v179 = v165:HealthPercentage();
			if (v179 < v148) then
				v148 = v179;
				v147 = v165;
			end
		end
	end
	if v147 then
		return v147;
	else
		return nil;
	end
end
local function v69(v149, v150)
	local v151 = nil;
	local v152 = math.huge;
	for v166, v167 in pairs(v149) do
		local v168 = ((v23.Lifebloom.LifeBloomTarget == "DPS") and "DAMAGER") or "TANK";
		local v169 = v23.Lifebloom.LifeBloomOnBothTanks and v6:IsInRaid();
		if (((v167:Role() == v168) and v6:IsInParty() and not v6:IsInRaid()) or (v169 and (v167:Role() == "TANK")) or (v6:IsInRaid() and not v23.Lifebloom.LifeBloomOnBothTanks and (v167:Role() == v168))) then
			if (not v167:BuffUp(v150) or (v167:BuffUp(v150) and (v167:BuffRemains(v150) < (1 + 4)))) then
				local v181 = v167:HealthPercentage();
				if (v181 < v152) then
					v152 = v181;
					v151 = v167;
				end
			end
		end
	end
	if v151 then
		return v151;
	else
		return nil;
	end
end
local function v70(v153, v154)
	local v155 = 0 + 0;
	for v170, v171 in pairs(v153) do
		if (v171:BuffUp(v154) and (v171:BuffRemains(v154) >= (2.5 + 2))) then
			v155 = v155 + (530 - (406 + 123));
		end
	end
	return v155;
end
local v71, v72, v73, v74, v75, v76, v77, v78, v79, v80, v81, v82, v83, v84, v85, v86, v87, v88, v89, v90, v91, v92, v93, v94, v95, v96, v97, v98, v99, v100, v101, v102;
local v103, v104, v105;
local function v106()
	v23.AoE = (not v6:IsInRaid() and v22.APL.Druid.Restoration.AoEHealing) or v22.APL.Druid.Restoration.RaidAoEHealing;
	v23.Healing = (not v6:IsInRaid() and v22.APL.Druid.Restoration.Healing) or v22.APL.Druid.Restoration.RaidHealing;
	v87 = v14.ToggleIconFrame:GetToggle(1770 - (1749 + 20));
	v86 = v14.ToggleIconFrame:GetToggle(1 + 1);
	v85 = v14.ToggleIconFrame:GetToggle(1325 - (1249 + 73));
	v79 = v14.ToggleIconFrame:GetToggle(2 + 2);
	v80 = v14.ToggleIconFrame:GetToggle(1150 - (466 + 679)) or v6:BuffUp(v24.Innervate) or v6:BuffUp(v24.TreeofLife) or v6:BuffUp(v24.Flourish) or v49();
	v82 = v14.ToggleIconFrame:GetToggle(16 - 9);
	v38 = v21.UnitsinRange(v24.Regrowth);
	v104 = v6:GetEnemiesInRange(114 - 74);
	v81 = v14.ToggleIconFrame:GetToggle(1906 - (106 + 1794)) and not v80;
	if v15() then
		v27 = v6:GetEnemiesInMeleeRange(3 + 5);
		v28 = #v27;
		v105 = #v104;
	else
		v27 = {};
		v28 = 1 + 0;
		v105 = 2 - 1;
	end
	if (v21.TargetIsValid() or v6:AffectingCombat()) then
		v29 = v3.BossFightRemains();
		v30 = v29;
		if (v30 == (30087 - 18976)) then
			v30 = v3.FightRemains(v27, false);
		end
	end
	v71, v72 = v21.GetLowestHealthUnit(v38);
	v73 = v71:HealthPercentage();
	v74 = v71:HealthPercentageWeighted();
	v75 = v21.GetLowestHealthUnitWithoutBuff(v38, v24.Rejuvenation);
	v76 = v67(v38, v24.Rejuvenation, v24.GerminationHoT);
	v77 = v70(v38, v24.Lifebloom) < ((v24.Undergrowth:IsAvailable() and (116 - (4 + 110))) or (585 - (57 + 527)));
	v78 = v69(v38, v24.Lifebloom);
	v83 = v68(v38, v24.Rejuvenation, v24.Regrowth);
	v84 = v6:BuffDown(v24.SouloftheForest) or (v6:BuffUp(v24.SouloftheForest) and v24.WildGrowth:CooldownDown());
	v95 = (v24.AstralInfluence:IsAvailable() and (1432 - (41 + 1386))) or (103 - (17 + 86));
	v97 = 28 + 12 + v95;
	v98 = v8:IsSpellInRange(v24.Shred);
	v99 = v8:IsInRange(v97);
	v100 = ((v23.Cooldowns.NaturesVigilUse == "With Logic") and (v73 >= (111 - 61))) or ((v23.Cooldowns.NaturesVigilUse == "With Cooldowns") and v16()) or ((v23.Cooldowns.NaturesVigilUse == "With Cooldowns and Logic") and v16() and (v73 >= (144 - 94)));
	v101 = ((v23.Cooldowns.HeartOfTheWildUse == "With Logic") and (v73 >= (216 - (122 + 44)))) or ((v23.Cooldowns.HeartOfTheWildUse == "With Cooldowns") and v16()) or ((v23.Cooldowns.HeartOfTheWildUse == "With Cooldowns and Logic") and v16() and (v73 >= (86 - 36)));
	v91 = v21.BuffCount(v38, v24.Rejuvenation) >= (9 - 6);
	v92 = v21.BuffCount(v38, v24.Lifebloom) >= (1 + 0);
	v93 = v21.BuffCount(v38, v24.Tranquility) >= (1 + 0);
	v94 = v21.BuffCount(v38, v24.WildGrowth) >= (1 - 0);
	v102 = (v24.Prosperity:IsAvailable() and (v24.Swiftmend:Charges() > (65 - (30 + 35))) and not v6:PrevGCD(1 + 0, v24.Swiftmend)) or v24.Swiftmend:CooldownUp();
end
local function v107()
	if ((v73 >= (1302 - (1043 + 214))) and v42(v8) and (v24.NaturesCure:CooldownDown() or not v24.ImprovedNaturesCure:IsAvailable()) and v8:IsSpellInRange(v24.Rejuvenation)) then
		if (v8:BuffDown(v24.Rejuvenation) and v24.Rejuvenation:IsReady()) then
			v17(v24.Rejuvenation);
			return;
		end
		if (v8:BuffUp(v24.Rejuvenation) and v24.Regrowth:IsReady() and not v6:IsMoving()) then
			v17(v24.Regrowth);
			return;
		end
	end
	if ((v73 >= (132 - 97)) and v44() and (v8:HealthPercentage() > (1212 - (323 + 889))) and (v8:HealthPercentage() < (269 - 169))) then
		if (v8:BuffDown(v24.Rejuvenation) and v24.Rejuvenation:IsReady()) then
			v17(v24.Rejuvenation);
			return;
		end
		if (v102 and v8:BuffUp(v24.Rejuvenation) and v8:BuffUp(v24.Regrowth) and v82) then
			v8:Cast(v24.Swiftmend);
			return;
		end
		if (v8:BuffUp(v24.Rejuvenation) and v24.Regrowth:IsReady() and not v6:IsMoving()) then
			v17(v24.Regrowth);
			return;
		end
	end
	if v24.Rebirth:IsReady() then
		if (v8:UnitIsFriend() and v8:IsAPlayer() and v8:Exists() and v8:IsDeadOrGhost()) then
			v14.Cast(v24.Rebirth);
			return "Rebirth on Target";
		end
		if (v10:UnitIsFriend() and v10:IsAPlayer() and v10:Exists() and v10:IsDeadOrGhost()) then
			v14.CastTarget(v24.Rebirth, v14.TName().MOUSEOVER);
			return "Rebirth on Mouseover";
		end
	end
	if v79 then
		if (v24.BearForm:IsReady() and v6:BuffDown(v24.BearForm) and (v6:HealthPercentage() <= v23.Defense.BearFormHP)) then
			v14.Cast(v24.BearForm);
			return;
		end
		if (v24.BearForm:IsReady() and v6:BuffDown(v24.FrenziedRegenerationBuff) and v6:BuffUp(v24.BearForm) and (v6:HealthPercentage() >= ((v23.Defense.BearFormHP + (590 - (361 + 219))) or (420 - (53 + 267))))) then
			v14.Cast(v24.BearForm);
			return;
		end
	end
	if (v24.Innervate:IsReady() and v6:BuffDown(v24.CatForm) and v6:AffectingCombat() and ((v6:ManaPercentage() <= v23.Restoration.InnervateMP) or (v23.Restoration.InnervateTree and v6:BuffUp(v24.TreeofLife)))) then
		v14.CastTarget(v24.Innervate, v14.TName().PLAYER);
		return;
	end
	if (v24.Barkskin:IsReady() and (v23.Defense.BarkskinHP > (0 + 0)) and v6:AffectingCombat() and ((v6:HealthPercentageWeighted() <= v23.Defense.BarkskinHP) or v48() or v47())) then
		v14.Cast(v24.Barkskin);
		return "Bark Skin Casted per HP Value";
	end
	if (v24.Renewal:IsReady() and v6:AffectingCombat() and (v6:HealthPercentage() <= v23.Defense.RenewalHP)) then
		v14.Cast(v24.Renewal);
		return;
	end
	if v6:BuffUp(v24.BearForm) then
		if (v24.FrenziedRegeneration:IsReady() and (v6:Rage() >= (423 - (15 + 398))) and (v6:HealthPercentage() <= v23.Defense.FrenziedRegenerationHP)) then
			v14.Cast(v24.FrenziedRegeneration);
			return;
		end
		if (v24.Ironfur:IsReady() and (v6:Rage() >= (1022 - (18 + 964))) and (v6:HealthPercentage() <= v23.Defense.IronfurHP)) then
			v14.Cast(v24.Ironfur);
			return;
		end
	end
	if (v6:BuffUp(v24.NaturesSwiftness) and v24.Regrowth:IsReady() and (v73 <= v23.Healing.NaturesSwiftnessHP)) then
		v71:Cast(v24.Regrowth);
		return;
	end
	if (v24.NaturesSwiftness:IsReady() and v6:BuffDown(v24.NaturesSwiftness) and (v73 <= v23.Healing.NaturesSwiftnessHP)) then
		v14.Cast(v24.NaturesSwiftness);
		return;
	end
	if (v24.GroveGuardians:IsReady() and (v24.GroveGuardians:Charges() > (0 - 0)) and (v6:TotemRemains(1 + 0) <= (0 + 0)) and (v74 <= v23.Healing.GroveGuardiansHP)) then
		v71:Cast(v24.GroveGuardians);
		return;
	end
	v89 = ((v23.Healing.GroveGuardiansHP > (870 - (20 + 830))) and (v23.Healing.GroveGuardiansHP - (16 + 4))) or (171 - (116 + 10));
	if (v24.GroveGuardians:IsReady() and (v24.GroveGuardians:Charges() > (0 + 0)) and (v6:TotemRemains(739 - (542 + 196)) > (0 - 0)) and (v6:TotemRemains(1 + 1) <= (0 + 0)) and (v74 <= v89)) then
		v71:Cast(v24.GroveGuardians);
		return;
	end
	v90 = ((v23.Healing.GroveGuardiansHP > (13 + 22)) and (v23.Healing.GroveGuardiansHP - (91 - 56))) or (76 - 46);
	if (v24.GroveGuardians:IsReady() and (v24.GroveGuardians:Charges() > (1551 - (1126 + 425))) and (v6:TotemRemains(406 - (118 + 287)) > (0 - 0)) and (v6:TotemRemains(1123 - (118 + 1003)) > (0 - 0)) and (v6:TotemRemains(380 - (142 + 235)) > (0 - 0)) and (v73 <= v90)) then
		v71:Cast(v24.GroveGuardians);
		return;
	end
	if (v81 and (v6:IsInParty() or v6:IsInRaid())) then
		if ((v73 <= (7 + 23)) or v80) then
			v14.CastMacro(979 - (553 + 424), true);
		end
	end
	if not v81 then
		if ((v6:BuffDown(v24.CatForm) and v6:BuffDown(v24.BearForm) and v6:BuffDown(v24.MoonkinForm)) or not v79 or v80 or (v73 <= (103 - 48))) then
			if (v24.Flourish:IsReady() and v21.AoELogicWithCount(v23.AoE.FlourishHP, v23.AoE.FlourishCount, "With Logic", v38)) then
				if ((v91 and v92) or (v94 and v93) or (v93 and v92) or (v21.BuffCount(v38, v24.Tranquility) >= #v38) or (not v6:IsInRaid() and v6:IsInParty() and v94)) then
					v14.Cast(v24.Flourish);
					return;
				end
			end
			if (v24.Convoke:IsReady() and v6:AffectingCombat() and v6:BuffDown(v24.CatForm) and v6:BuffDown(v24.MoonkinForm) and v21.AoELogicWithCount(v23.AoE.ConvokeHP, v23.AoE.ConvokeCount, v23.Cooldowns.ConvokeUse, v38)) then
				v14.Cast(v24.Convoke);
				return;
			end
			if (v24.Tranquility:IsReady() and v6:AffectingCombat() and not v6:IsMoving() and v21.AoELogicWithCount(v23.AoE.TranquilityHP, v23.AoE.TranquilityCount, "With Logic", v38)) then
				v14.Cast(v24.Tranquility);
				return;
			end
			if (v24.TreeofLife:IsReady() and v6:AffectingCombat() and v6:BuffDown(v24.TreeofLife) and v21.AoELogicWithCount(v23.AoE.TreeofLife, v23.AoE.TreeofLifeCount, "With Logic", v38)) then
				v14.Cast(v24.TreeofLife);
				return;
			end
			if (v83 ~= nil) then
				if (v102 and v82 and (v83:HealthPercentage() <= v23.Healing.SwiftmendHP)) then
					v83:Cast(v24.Swiftmend);
					return;
				end
			end
			if ((v6:BuffUp(v24.SouloftheForest) or (v23.AoE.WGSpread and v80)) and v24.WildGrowth:IsReady() and not v6:IsMoving() and (v21.AoELogicWithCount(v23.Soul.WildGrowthSoulHP, v23.Soul.WildGrowthSoulCount, "With Logic", v38) or v21.AoELogic(v23.AoE.WildGrowthHP, "With Logic", v38) or (v23.AoE.WGSpread and v80) or (v6:BuffRemains(v24.SouloftheForest) < (3 + 0)))) then
				v71:Cast(v24.WildGrowth);
				return;
			end
			if (v24.WildGrowth:IsReady() and not v6:IsMoving() and v21.AoELogicWithCount(v23.AoE.WildGrowthHP, v23.AoE.WildGrowthCount, "With Logic", v38)) then
				v71:Cast(v24.WildGrowth);
				return;
			end
			if (v24.Regrowth:IsReady() and not v6:IsMoving() and v6:BuffUp(v24.Clear) and (((v74 <= v23.Healing.RegrowthClearHP) and v6:BuffDown(v24.SouloftheForest)) or (v6:BuffUp(v24.SouloftheForest) and (v73 <= v23.Soul.RegrowthSoulHP)))) then
				v71:Cast(v24.Regrowth);
				return;
			end
			if (v72 ~= nil) then
				if (v24.Ironbark:IsReady() and (v72:HealthPercentageWeighted() <= v23.TankHealing.IronbarkTankHP)) then
					v72:Cast(v24.Ironbark);
					return;
				end
			end
			if ((not v6:IsInRaid() or (v6:IsInRaid() and not v23.Lifebloom.LifeBloomOnBothTanks)) and v24.Photosynthesis:IsAvailable() and (v6:BuffDown(v24.Lifebloom) or (v6:BuffUp(v24.Lifebloom) and (v6:BuffRemains(v24.Lifebloom) < (4.5 + 0)))) and v24.Lifebloom:IsReady() and v77) then
				v6:Cast(v24.LifebloomCast);
				return;
			end
			if v23.TankHealing.IronbarkOnTankOnly then
				if (v72 ~= nil) then
					if (v24.Ironbark:IsReady() and (v72:HealthPercentageWeighted() <= v23.TankHealing.IronbarkTankHP)) then
						v72:Cast(v24.Ironbark);
						return;
					end
				end
			elseif (v24.Ironbark:IsReady() and (v74 <= v23.Healing.IronbarkHP)) then
				v71:Cast(v24.Ironbark);
				return;
			end
			if (v72 ~= nil) then
				if (v24.Invigorate:IsReady() and (v72:HealthPercentageWeighted() <= v23.TankHealing.InvigorateTankHP)) then
					v72:Cast(v24.Invigorate);
					return;
				end
			end
			if v23.TankHealing.InvigorateOnTankOnly then
				if (v72 ~= nil) then
					if (v24.Invigorate:IsReady() and (v72:HealthPercentageWeighted() <= v23.TankHealing.InvigorateTankHP)) then
						v72:Cast(v24.Invigorate);
						return;
					end
				end
			elseif (v24.Invigorate:IsReady() and (v74 <= v23.Healing.InvigorateHP)) then
				v71:Cast(v24.Invigorate);
				return;
			end
			if v24.SouloftheForestTalent:IsAvailable() then
				if (v83 ~= nil) then
					if (v102 and v24.WildGrowth:CooldownUp() and v82 and (v21.AoELogicWithCount(v23.Soul.WildGrowthSoulHP, v23.Soul.WildGrowthSoulCount, "With Logic", v38) or v21.AoELogicWithCount(v23.AoE.WildGrowthHP, v23.AoE.WildGrowthCount, "With Logic", v38) or v80)) then
						v83:Cast(v24.Swiftmend);
						return;
					end
				end
			end
			if (v72 ~= nil) then
				if (v24.CenarionWard:IsReady() and (v72:HealthPercentageWeighted() <= v23.TankHealing.CenWardHP)) then
					v72:Cast(v24.CenarionWard);
					return;
				end
				if (v24.Rejuvenation:IsReady() and v84 and v72:BuffDown(v24.Rejuvenation) and (v72:HealthPercentageWeighted() <= v23.TankHealing.RejTankHP)) then
					v72:Cast(v24.Rejuvenation);
					return;
				end
				if (v102 and (v72:BuffUp(v24.Rejuvenation) or v72:BuffUp(v24.Regrowth)) and (v72:HealthPercentage() <= v23.TankHealing.SwiftTankHP)) then
					v72:Cast(v24.Swiftmend);
					return;
				end
				if (v24.Regrowth:IsReady() and not v6:IsMoving() and v84 and (v72:HealthPercentageWeighted() <= v23.TankHealing.RegrowthTankHP)) then
					v72:Cast(v24.Regrowth);
					return;
				end
			end
			if v80 then
				if ((not v6:IsInRaid() or (v6:IsInRaid() and not v23.Lifebloom.LifeBloomOnBothTanks)) and v24.Photosynthesis:IsAvailable() and (v6:BuffDown(v24.Lifebloom) or (v6:BuffUp(v24.Lifebloom) and (v6:BuffRemains(v24.Lifebloom) < (3.5 + 1)))) and v24.Lifebloom:IsReady() and v77) then
					v6:Cast(v24.LifebloomCast);
					return;
				end
				if ((v78 ~= nil) and (v74 >= v23.Lifebloom.LifebloomRefreshIgnore)) then
					if v77 then
						if v24.Lifebloom:IsReady() then
							v78:Cast(v24.LifebloomCast);
							return;
						end
					end
				end
				if (v83 ~= nil) then
					if (v24.SouloftheForestTalent:IsAvailable() and v6:BuffDown(v24.SouloftheForest)) then
						if v102 then
							v83:Cast(v24.Swiftmend);
							return;
						end
					end
				end
				if (v75 ~= nil) then
					if v24.Rejuvenation:IsReady() then
						v75:Cast(v24.Rejuvenation);
						return;
					end
				end
				if v24.GerminationTalent:IsAvailable() then
					if ((v75 == nil) and (v76 ~= nil)) then
						if v24.Rejuvenation:IsReady() then
							v76:Cast(v24.Rejuvenation);
							return;
						end
					end
				end
			end
			if ((v78 ~= nil) and (v74 >= v23.Lifebloom.LifebloomRefreshIgnore)) then
				if v77 then
					if v24.Lifebloom:IsReady() then
						v78:Cast(v24.LifebloomCast);
						return;
					end
				end
			end
			if (v24.Efflor:IsReady() and v6:BuffDown(v24.Efflor) and v6:AffectingCombat() and v23.Restoration.EfflorUsage) then
				v14.Cast(v24.Efflor);
				return;
			end
			if (v24.Overgrowth:IsReady() and (v74 <= v23.Healing.OvergrowthHP) and (v71:BuffDown(v24.Lifebloom) or v71:BuffDown(v24.WildGrowth) or v71:BuffDown(v24.Rejuvenation) or v71:BuffDown(v24.Regrowth))) then
				v71:Cast(v24.Overgrowth);
				return;
			end
			if (v83 ~= nil) then
				if (v102 and v82 and (v83:HealthPercentage() <= v23.Healing.SwiftmendHP)) then
					v83:Cast(v24.Swiftmend);
					return;
				end
			end
			if v71:BuffUp(v24.Rejuvenation) then
				if (v24.Nourish:IsReady() and not v6:IsMoving() and v6:BuffUp(v24.WildSynthesis) and (v6:BuffStack(v24.WildSynthesis) >= (2 + 1)) and (v74 <= v23.Healing.Nourish)) then
					v71:Cast(v24.Nourish);
					return;
				end
				if (v24.Regrowth:IsReady() and not v6:IsMoving() and not v6:IsMoving() and ((v6:BuffUp(v24.Clear) and (v74 <= v23.Healing.RegrowthClearHP) and v6:BuffDown(v24.SouloftheForest)) or (v74 <= v23.Healing.RegrowthHP) or (v6:BuffUp(v24.SouloftheForest) and (v73 <= v23.Soul.RegrowthSoulHP)))) then
					v71:Cast(v24.Regrowth);
					return;
				end
			end
			if (v75 ~= nil) then
				if (v24.Rejuvenation:IsReady() and ((v6:BuffDown(v24.SouloftheForest) and (v75:HealthPercentageWeighted() <= v23.Healing.RejuvenationHP)) or (v6:BuffUp(v24.SouloftheForest) and (v75:HealthPercentageWeighted() <= v23.Soul.RejSoulHP)))) then
					v75:Cast(v24.Rejuvenation);
					return;
				end
			end
			if (v76 ~= nil) then
				if (v24.Rejuvenation:IsReady() and v6:BuffDown(v24.SouloftheForest) and (v76:HealthPercentageWeighted() <= v23.Healing.GerminationHoTHP)) then
					v76:Cast(v24.Rejuvenation);
					return;
				end
			end
			if (v24.Regrowth:IsReady() and not v6:IsMoving() and ((v6:BuffUp(v24.Clear) and (v74 <= v23.Healing.RegrowthClearHP) and v6:BuffDown(v24.SouloftheForest)) or (v74 <= v23.Healing.RegrowthHP) or (v6:BuffUp(v24.SouloftheForest) and (v73 <= v23.Soul.RegrowthSoulHP)))) then
				v71:Cast(v24.Regrowth);
				return;
			end
		end
	end
	if (v21.TargetIsValid() and v6:BuffDown(v24.BearForm) and (v8:AffectingCombat() or (v23.Restoration.AttackOOC and v87)) and ((v74 >= (29 + 21)) or v81)) then
		local function v177(v180)
			return v180:DebuffRemains(v24.RakeDebuff);
		end
		if (v24.NaturesVigil:IsReady() and v100) then
			v14.Cast(v24.NaturesVigil);
			return "Natures Vigil";
		end
		if (v24.HeartoftheWild:IsReady() and v101) then
			v14.Cast(v24.HeartoftheWild);
			return "Heart of the Wild";
		end
		if v23.Commons.Enabled.Items then
			if v25.Iridal:IsEquippedAndReady() then
				if not v6:IsMoving() then
					v14.CastMacro(2 - 1, nil, nil, v25.Iridal);
					return "weapon cast Iridal";
				end
			else
				local v182, v183, v184 = v6:GetUseableItems(v26, 44 - 28);
				if (v182 and v182:IsReady() and v8:IsInRange(v184)) then
					v14.CastMacro(2 - 1);
					return "weapon cast";
				end
			end
		end
		if v79 then
			if ((v23.Restoration.DPSForm == "Cat") and v98 and (v8:DebuffUp(v24.SunfireDebuff) or not v24.Sunfire:IsAvailable()) and v8:DebuffUp(v24.MoonfireDebuff)) then
				if (v6:BuffDown(v24.CatForm) and v24.CatForm:IsReady() and not v24.FluidForm:IsAvailable() and v6:BuffDown(v24.TreeofLife)) then
					v14.Cast(v24.CatForm);
					return "Cat From Auto Form";
				end
			end
			if (not v98 and (v23.Restoration.DPSForm == "Cat") and not v6:IsMoving() and v6:BuffUp(v24.CatForm)) then
				v14.Cast(v24.CatForm);
				return "Removal of Cat due not being in Melee and not Moving";
			end
		end
		if v98 then
			if (v6:BuffUp(v24.CatForm) and v6:BuffDown(v24.TreeofLife)) then
				if (v24.Rip:IsReady() and v62() and (v6:Energy() >= (6 + 14)) and v8:DebuffRefreshable(v24.RipDebuff)) then
					v14.Cast(v24.Rip);
					return "Rip Cast";
				end
				if ((v8:DebuffUp(v24.RipDebuff) or not v24.Rip:IsAvailable() or not v62()) and (v6:ComboPoints() >= (24 - 19))) then
					if (v24.FerociousBite:IsReady() and (v6:Energy() >= (778 - (239 + 514)))) then
						v14.Cast(v24.FerociousBite);
						return "Ferocious Bite";
					end
				end
				if v23.Restoration.ConvokeDPS then
					if (v6:ComboPoints() < (1 + 0)) then
						if (v16() and v24.Convoke:IsReady()) then
							v14.Cast(v24.Convoke);
							return;
						end
					end
				end
			end
			if ((v6:BuffUp(v24.CatForm) and v6:BuffDown(v24.TreeofLife)) or (v24.FluidForm:IsAvailable() and (v23.Restoration.DPSForm == "Cat") and v79 and v6:BuffDown(v24.CatForm) and v6:BuffDown(v24.TreeofLife))) then
				if (v24.Shred:IsReady() and (v6:Energy() >= (1364 - (797 + 532))) and (v8:DebuffUp(v24.ThrashCatDebuff) or not v24.ThrashCat:IsAvailable() or (not v6:BuffUp(v24.CatForm) and v24.FluidForm:IsAvailable())) and (v8:DebuffUp(v24.RakeDebuff) or not v24.Rake:IsAvailable()) and ((v28 <= (1 + 0)) or (v24.FluidForm:IsAvailable() and v6:BuffDown(v24.CatForm)))) then
					v14.Cast(v24.Shred);
					return "Shred";
				end
				if (v24.Rake:IsReady() and (v6:Energy() >= (12 + 23)) and (v8:DebuffRefreshable(v24.RakeDebuff) or v8:DebuffDown(v24.RakeDebuff))) then
					v14.Cast(v24.Rake);
					return "Rake";
				end
			end
			if (v6:BuffUp(v24.CatForm) and v6:BuffDown(v24.TreeofLife)) then
				if (v24.ThrashCat:IsReady() and (v6:Energy() >= (94 - 54)) and (v8:DebuffRefreshable(v24.ThrashCatDebuff) or v8:DebuffDown(v24.ThrashCatDebuff))) then
					v14.Cast(v24.ThrashCastResto);
					return "Trash Cast";
				end
				if (v24.Swipe:IsReady() and (v6:Energy() >= (1242 - (373 + 829))) and (v8:DebuffUp(v24.ThrashCatDebuff) or not v24.ThrashCat:IsAvailable()) and (v8:DebuffUp(v24.RakeDebuff) or not v24.Rake:IsAvailable()) and (v28 > (732 - (476 + 255)))) then
					v14.Cast(v24.Swipecast);
					return "Swipe";
				end
				if ((v6:ComboPoints() < (1135 - (369 + 761))) and (v6:Energy() < (21 + 14))) then
					if (v24.Sunfire:IsReady() and (v8:DebuffRefreshable(v24.SunfireDebuff) or v8:DebuffDown(v24.SunfireDebuff))) then
						v14.Cast(v24.Sunfire);
						return "Sunfire in Cat - Low Energy and Combo Points - Refresh or Apply";
					end
					if (v24.Moonfire:IsReady() and ((v24.Sunfire:IsAvailable() and v8:DebuffUp(v24.Sunfire)) or not v24.Sunfire:IsAvailable()) and (v8:DebuffRefreshable(v24.MoonfireDebuff) or v8:DebuffDown(v24.MoonfireDebuff))) then
						v14.Cast(v24.Moonfire);
						return "Moonfire in Cat - Low Energy and Combo Points - Refresh or Apply";
					end
					if (((v24.Sunfire:IsAvailable() and v8:DebuffUp(v24.SunfireDebuff)) or not v24.Sunfire:IsAvailable()) and v8:DebuffUp(v24.MoonfireDebuff)) then
						if v24.Starsurge:IsReady() then
							v14.Cast(v24.Starsurge);
							return "Starsurge in Cat - Low Energy and Combo Points - Debuffs Already applied";
						end
					end
				end
			end
		end
		if (v6:BuffUp(v24.MoonkinForm) and v99) then
			if (v24.Sunfire:IsReady() and (v8:DebuffRefreshable(v24.SunfireDebuff) or v8:DebuffDown(v24.SunfireDebuff))) then
				if v17(v24.Sunfire) then
					return "sunfire main 24";
				end
			end
			if (v24.Moonfire:IsReady() and (v8:DebuffRefreshable(v24.MoonfireDebuff) or v8:DebuffDown(v24.MoonfireDebuff))) then
				if v17(v24.Moonfire) then
					return "moonfire main 26";
				end
			end
			if (v24.Moonfire:IsReady() and v23.Restoration.MoonfireMouseover and v10:DebuffRefreshable(v24.MoonfireDebuff) and ((v24.Sunfire:IsAvailable() and v10:DebuffUp(v24.SunfireDebuff)) or not v24.Sunfire:IsAvailable())) then
				v14.CastTarget(v24.Moonfire, v14.TName().MOUSEOVER);
				return "Moonfire Mouseover";
			end
			if (v23.Restoration.ConvokeDPS and v8:DebuffUp(v24.SunfireDebuff) and v8:DebuffUp(v24.MoonfireDebuff)) then
				if (v16() and v24.Convoke:IsReady()) then
					v14.Cast(v24.Convoke);
					return;
				end
			end
			if v24.Starsurge:IsReady() then
				v14.Cast(v24.Starsurge);
				return;
			end
			if (v24.Starfire:IsReady() and not v6:IsMoving() and (v105 > (1 - 0))) then
				v14.Cast(v24.Starfire);
				return "Starfire Enemies count Higher than 1";
			end
			if (v24.Wrath:IsReady() and not v6:IsMoving()) then
				if v17(v24.Wrath) then
					return "wrath main 28";
				end
			end
		end
		if (v6:BuffDown(v24.CatForm) and v99) then
			if (v24.Sunfire:IsReady() and v8:DebuffRefreshable(v24.SunfireDebuff)) then
				v14.Cast(v24.Sunfire);
				return;
			end
			if (v24.Moonfire:IsReady() and v8:DebuffRefreshable(v24.MoonfireDebuff) and ((v24.Sunfire:IsAvailable() and v8:DebuffUp(v24.SunfireDebuff)) or not v24.Sunfire:IsAvailable())) then
				v14.Cast(v24.Moonfire);
				return;
			end
			if (v24.Moonfire:IsReady() and v10:AffectingCombat() and v23.Restoration.MoonfireMouseover and v10:DebuffRefreshable(v24.MoonfireDebuff)) then
				v14.CastTarget(v24.Moonfire, v14.TName().MOUSEOVER);
				return "Moonfire Mouseover";
			end
			if v24.Starsurge:IsReady() then
				v14.Cast(v24.Starsurge);
				return;
			end
			if (v24.Starfire:IsReady() and ((not v98 and (v23.Restoration.DPSForm == "Cat")) or (v23.Restoration.DPSForm ~= "Cat")) and not v6:IsMoving() and (v105 > (1 - 0))) then
				v14.Cast(v24.Starfire);
				return "Starfire Enemies count Higher than 1";
			end
			if (v24.Wrath:IsReady() and ((not v98 and (v23.Restoration.DPSForm == "Cat")) or (v23.Restoration.DPSForm ~= "Cat")) and not v6:IsMoving() and not v6:BuffUp(v24.CatForm)) then
				v14.Cast(v24.Wrath);
				return "Wrath Cast Filler At Range";
			end
		end
	end
end
local function v108()
	if v21.ShouldStopCastUpdate() then
		v14.CastMacro(244 - (64 + 174), true);
		return "Stop Cast For Silence";
	end
	if (not v6:IsMounted() and not v6:BuffUp(v24.TravelFormBuff) and not v6:IsChanneling() and (v21.TargetIsValid() or v6:AffectingCombat() or v87)) then
		v40();
		if not v6:AffectingCombat() then
			v103 = v66();
			if v103 then
				return v103;
			end
		end
		if (v6:AffectingCombat() or v87) then
			if (v85 and v6:AffectingCombat()) then
				if v24.IncapacitatingRoar:IsReady() then
					v103 = v21.InterruptCycle(v24.IncapacitatingRoar, 2 + 8, false, nil, true, true);
					if v103 then
						return v103;
					end
				end
				if (v6:BuffUp(v24.CatForm) and v24.SkullBash:IsReady()) then
					v103 = v21.InterruptCycle(v24.SkullBash, 18 - 5, true, nil, false);
					if v103 then
						return v103;
					end
				end
			end
			if (v86 and v6:AffectingCombat()) then
				v103 = v21.SootheCycle(v24.Soothe, 376 - (144 + 192), false, v23.Restoration.TabForSoothe);
				if v103 then
					return v103;
				end
			end
			if (v86 and not v6:IsInRaid() and v24.NaturesCure:IsReady()) then
				v103 = v21.DispelCycle(v24.NaturesCure, "Magic", nil, v38);
				if v103 then
					return v103;
				end
				if v24.ImprovedNaturesCure:IsAvailable() then
					v103 = v21.AfflictedLogic(v24.NaturesCure);
					if v103 then
						return v103;
					end
					v103 = v21.DispelCycle(v24.NaturesCure, "Curse", nil, v38);
					if v103 then
						return v103;
					end
					v103 = v21.DispelCycle(v24.NaturesCure, "Poison", nil, v38);
					if v103 then
						return v103;
					end
				end
			end
			if (v86 and v6:IsInRaid() and v24.NaturesCure:IsReady()) then
				v103 = v21.DispelCycle(v24.NaturesCure, "Raid", nil, v38);
				if v103 then
					return v103;
				end
			end
			if v24.Cyclone:IsReady() then
				v103 = v21.IncorpCycle(v24.Cyclone, 256 - (42 + 174), false, false);
				if v103 then
					return v103;
				end
			end
			if (v24.Hibernate:IsReady() and (not v24.Cyclone:IsAvailable() or v24.Cyclone:CooldownDown())) then
				v103 = v21.IncorpCycle(v24.Hibernate, 31 + 9, false, false);
				if v103 then
					return v103;
				end
			end
		end
		v103 = v64(v23.Cooldowns.Trinket1HP, v23.Cooldowns.Trinket1Use, v23.Cooldowns.Trinket2HP, v23.Cooldowns.Trinket2Use, v38);
		if v103 then
			return v103;
		end
		v103 = v107();
		if v103 then
			return v103;
		end
	end
end
local function v109()
	v14.ResetToggle();
	v14.ToggleIconFrame:AddButtonCustom("O", 1 + 0, "OOC", "ooc");
	v14.ToggleIconFrame:AddButtonCustom("D", 1 + 1, "Dispel", "dispel");
	v14.ToggleIconFrame:AddButtonCustom("K", 1507 - (363 + 1141), "Kick", "kick");
	v14.ToggleIconFrame:AddButtonCustom("A", 1584 - (1183 + 397), "Auto Form", "autoform");
	v14.ToggleIconFrame:AddButtonCustom("S", 15 - 10, "Spread", "spread");
	v14.ToggleIconFrame:AddButtonCustom("DP", 5 + 1, "DPS Only", "dpsonly");
	v14.ToggleIconFrame:AddButtonCustom("SM", 6 + 1, "Swiftmend", "swiftmend");
	v23.Restoration.Display();
	v14:UpdateMacro("macro1", "/use 16");
	v14:UpdateMacro("macro2", "/hr dpsonly");
	v14:UpdateMacro("macro6", "/stopcasting");
	v14.Print("Restoration Druid rotation has been updated for TWW - Updated : 9/28/24");
	v14.Print("Convoke Will Be Used for DPS, if the Settings is Enabled and Cooldown Toggle is on");
end
v14.SetAPL(2080 - (1913 + 62), v108, v109, v106);
