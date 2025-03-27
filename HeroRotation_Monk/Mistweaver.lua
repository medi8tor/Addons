local v0, v1 = ...;
local v2 = HeroDBC.DBC;
local v3 = HeroLib;
local v4 = HeroCache;
local v5 = v3.Unit;
local v6 = v5.Player;
local v7 = v5.Target;
local v8 = v5.Pet;
local v9 = v3.Spell;
local v10 = v3.MultiSpell;
local v11 = v3.Item;
local v12 = HeroRotation();
local v13 = v12.AoEON;
local v14 = v12.CDsON;
local v15 = v12.Cast;
local v16, v17 = v5.Focus, v5.MouseOver;
local v18 = v12.Commons().Everyone.num;
local v19 = v12.Commons().Everyone.bool;
local v20 = v9.Monk.Mistweaver;
local v21 = v11.Monk.Mistweaver;
local v22;
local v23 = {v21.ScreamingBlackDragonScale:ID(),v21.BroodkeepersPromise:ID(),v21.FyrakkTainedRageHeart:ID(),v21.SmolderingSeedling:ID()};
local v24;
local v25;
local v26;
local v27;
local v28, v29;
local v30;
local v31, v32, v33, v34;
local v35 = false;
local v36 = true;
local v37 = v12.Commons().Everyone;
local v38 = v12.GUISettingsGet();
local v39 = {General=v38.General,Commons=v38.APL.Monk.Commons,Mistweaver=v38.APL.Monk.Mistweaver,Soothing=((not v6:IsInRaid() and v38.APL.Monk.Mistweaver.Soothing) or v38.APL.Monk.Mistweaver.RaidSoothing),Healing=((not v6:IsInRaid() and v38.APL.Monk.Mistweaver.Healing) or v38.APL.Monk.Mistweaver.RaidHealing),AoE=((not v6:IsInRaid() and v38.APL.Monk.Mistweaver.AoE) or v38.APL.Monk.Mistweaver.RaidAoE),Cooldowns=v38.APL.Monk.Mistweaver.Cooldowns};
local function v40(v90)
	return v90:NPCID() == (205179 - (555 + 64));
end
local function v41(v91)
	return v91:NPCID() == (205704 - (857 + 74));
end
local function v42(v92)
	return (v92:NPCID() == (205017 - (367 + 201))) or (v92:NPCID() == (209386 - (214 + 713))) or (v92:NPCID() == (52181 + 156280)) or (v92:NPCID() == (32681 + 175119)) or (v92:NPCID() == (195523 - (282 + 595))) or (v92:NPCID() == (214227 - (1523 + 114)));
end
local function v43()
	return v42(v7) and not v6:CanAttack(v7);
end
local function v44(v93)
	local v94 = v6:ChannelStart(v93);
	return (v6:IsChanneling(v93) and (GetTime() - v94)) or (0 + 0);
end
local v45 = 0 - 0;
local function v46(v95, v96, v97)
	v45 = v97;
	if (v20.ManaTea:IsReady() and (v6:BuffStack(v20.ManaTeaBuff) >= (1068 - (68 + 997))) and v6:BuffDown(v20.ManaTeaBuff2) and not v6:IsChanneling(v20.ManaTea)) then
		if v12.DebugON() then
			print("Cast ManaTea Spell" .. v95:Name());
		end
		return v15(v20.ManaTea);
	end
	if (v6:IsChanneling(v20.ManaTea) and (v44(v20.ManaTea) <= (v97 or (1271 - (226 + 1044)))) and (not v96 or (v96:HealthPercentage() > (174 - 134)))) then
		return "wait manatea";
	end
	if v96 then
		v45 = 117 - (32 + 85);
		return v96:Cast(v95, true);
	end
	v45 = 0 + 0;
	return v15(v95, true);
end
local function v47(v98)
	return v20.ChiHarmony:IsAvailable() and v98:BuffDown(v20.ChiHarmonyBuff);
end
local v48 = v37.converArrayToList({(261698 - (892 + 65)),(792131 - 363589),(417066 - (87 + 263))});
local function v49(v99, v100, v101)
	return (v100 < v101) or v37.unitHasDebuffFromList(v48, v99);
end
local v50 = {(188365 + 68517),(147305 + 52986),(370280 - (802 + 150)),(679571 - 304937),(386178 - (915 + 82)),(217116 + 155585),(370514 - (1069 + 118))};
local v51 = {(567806 - 308234),(455885 - 199308),(259981 - (368 + 423)),(255595 - (10 + 8)),(202461 - (416 + 26)),(87763 + 116739),(221293 - (145 + 293)),(200875 - (998 + 488)),(167585 + 37081),(415621 - (116 + 1022)),(242786 + 170836),(1448765 - 1040787),(1019110 - 605504),(145558 + 266394),(759216 - 331993),(430374 - (630 + 793)),(802281 - 632836),(1472479 - 1044811),(430781 - (1789 + 124)),(26360 + 50274),(1022607 - 761905),(293394 + 80298),(1728378 - 1335738),(887233 - 494747),(1072157 - 680523),(389583 - (376 + 325)),(1174367 - 792704),(840452 - 458859),(389193 - (85 + 291)),(1463547 - 1078927),(375900 - (1123 + 57)),(384386 - (163 + 91)),(108160 + 278991),(589826 - 205812),(525378 - 143075),(377523 - (1329 + 145)),(376491 - (1409 + 441)),(171101 + 198364),(377611 - (345 + 1376)),(1655144 - 1280504),(390129 - (696 + 510)),(375627 - (1091 + 171)),(1222890 - 834466),(377378 - (123 + 251))};
local v52, v53;
local function v54(v102)
	return v53 or v37.ISSolo() or (v102 == (0 - 0)) or ((v52 >= v102) and (v52 < (8475 - (208 + 490))));
end
local function v55()
	local v103 = v6:GetEnemiesInRange(4 + 36);
	for v126, v127 in ipairs(v103) do
		if v50[v127:CastSpellID() or v127:ChannelSpellID()] then
			return true;
		end
	end
end
local function v56()
	local v104 = v6:GetEnemiesInRange(18 + 22);
	for v128, v129 in ipairs(v104) do
		if v51[v129:CastSpellID() or v129:ChannelSpellID()] then
			return true;
		end
	end
end
local function v57(v105, v106, v107, v108, v109)
	local v110, v111, v112 = v6:GetUseableItems(v23, 849 - (660 + 176));
	if (v110 and v37.AoELogic(v105, v106, v109)) then
		if v15(v110) then
			return "trinket1 trinkets 2";
		end
	end
	local v113, v111, v114 = v6:GetUseableItems(v23, 2 + 12);
	if (v113 and v37.AoELogic(v107, v108, v109)) then
		if v15(v113) then
			return "trinket2 trinkets 4";
		end
	end
end
local function v58()
	return v20.AncientTeachingsTalent:IsAvailable() and v29 and v54(207 - (14 + 188)) and (v6:BuffDown(v20.AncientTeachings, nil, true) or (v6:BuffUp(v20.AncientTeachings, nil, true) and (v6:BuffRemains(v20.AncientTeachings, nil, true) <= (v6:GCD() + (675.25 - (534 + 141))))));
end
local function v59()
	if (v20.ExpelHarm:IsCastable() and v49(v6, v6:HealthPercentage(), v39.Mistweaver.ExpelHarmHP)) then
		if (v20.RenewingMist:IsReady() and (v20.RenewingMist:Charges() > (0 + 0)) and v47(v6)) then
			v6:Cast(v20.RenewingMist);
			return "ExpelHarm RenewingMist ";
		end
		if v15(v20.ExpelHarm) then
			return "ExpelHarm defensives 1";
		end
	end
	if (v20.DampenHarm:IsCastable() and v6:BuffDown(v20.FortifyingBrew, nil, true) and ((v6:HealthPercentageWeighted() <= v39.Mistweaver.DampenHarmHP) or v56() or v55())) then
		if v15(v20.DampenHarm) then
			return "dampen_harm defensives 2";
		end
	end
	if (v20.FortifyingBrew:IsCastable() and v6:BuffDown(v20.DampenHarm, nil, true) and ((v6:HealthPercentageWeighted() <= v39.Mistweaver.FortifyingBrewHP) or v55())) then
		if v15(v20.FortifyingBrew) then
			return "fortifying_brew defensives 4";
		end
	end
	if (v20.DiffuseMagic:IsCastable() and v6:BuffDown(v20.DiffuseMagic, nil, true) and ((v6:HealthPercentageWeighted() <= v39.Mistweaver.DiffuseMagicHP) or v56())) then
		if v15(v20.DiffuseMagic) then
			return "fortifying_brew defensives 4";
		end
	end
	if (v39.Commons.Enabled.Trinkets and v21.FyrakkTainedRageHeart:IsEquippedAndReady() and v14()) then
		if (v6:HealthPercentageWeighted() <= (36 + 4)) then
			if v15(v21.FyrakkTainedRageHeart, true) then
				return "FyrakkTainedRageHeart Def";
			end
		end
	end
end
local function v60()
end
local function v61(v115, v116)
	local v117 = nil;
	local v118 = math.huge;
	for v130, v131 in pairs(v115) do
		if v131:BuffUp(v116, nil, true) then
			local v144 = v131:HealthPercentageWeighted();
			if (v144 < v118) then
				v118 = v144;
				v117 = v131;
			end
		end
	end
	if v117 then
		return v117;
	else
		return nil;
	end
end
local function v62(v119)
	local v120 = v119:Name();
	for v132 = 1 + 0, 8 - 4 do
		local v133, v134, v135, v136 = GetTotemInfo(v132);
		if (v134 and v120 and strfind(v120, v134, 1 - 0, true)) then
			local v145 = math.floor(((v135 + v136) - GetTime()) + (0.5 - 0));
			if (v145 > (0 + 0)) then
				return v145;
			end
		end
	end
	return 0 + 0;
end
local function v63(v121)
	local v122 = 396 - (115 + 281);
	for v137, v138 in pairs(v121) do
		if not v138:IsDeadOrGhost() then
			v122 = v122 + (2 - 1);
		end
		return v122;
	end
end
local v64 = nil;
local v65 = nil;
local v66 = nil;
local v67 = nil;
local v68;
local v69, v70, v71, v72, v73, v74, v75, v76, v77, v78, v79, v80, v81;
local v82, v83;
local v84, v85;
local function v86()
	if (v37.TargetIsValid() or v6:AffectingCombat()) then
		v52 = v3.BossFightRemains();
		v53 = true;
		if (v52 == (9200 + 1911)) then
			v53 = false;
			v52 = v3.FightRemains(v26, false);
		end
	end
	v39.Healing = (not v6:IsInRaid() and v38.APL.Monk.Mistweaver.Healing) or v38.APL.Monk.Mistweaver.RaidHealing;
	v39.AoE = (not v6:IsInRaid() and v38.APL.Monk.Mistweaver.AoE) or v38.APL.Monk.Mistweaver.RaidAoE;
	v39.Soothing = (not v6:IsInRaid() and v38.APL.Monk.Mistweaver.Soothing) or v38.APL.Monk.Mistweaver.RaidSoothing;
	v24 = v6:GetEnemiesInMeleeRange(24 - 14);
	v26 = v6:GetEnemiesInMeleeRange(146 - 106);
	v68 = #(v6:GetEnemiesInMeleeRange(872 - (550 + 317)));
	v22 = v37.UnitsinRange(v20.Vivify);
	v30 = v12.ToggleIconFrame:GetToggle(1 - 0);
	v31 = v12.ToggleIconFrame:GetToggle(2 - 0);
	v32 = v12.ToggleIconFrame:GetToggle(8 - 5);
	v33 = v12.ToggleIconFrame:GetToggle(291 - (134 + 151));
	v81 = v12.ToggleIconFrame:GetToggle(1672 - (970 + 695));
	v28 = v7:IsInMeleeRange(9 - 4);
	v84 = v7:IsInRange(2015 - (582 + 1408));
	v85 = v7:IsInRange(138 - 98);
	v83 = v37.UnitsinRange(v20.TigersLust);
	v29 = v7:IsInMeleeRange(12 - 2);
	if v13() then
		v25 = #v24;
		v27 = #v26;
	else
		v25 = 3 - 2;
		v27 = 1825 - (1195 + 629);
	end
	v69, v70 = v37.GetLowestHealthUnit(v22);
	v34 = (v70 and v70:HealthPercentage()) or (132 - 32);
	v71 = v69:HealthPercentageWeighted();
	v72 = v69:HealthPercentage();
	v73 = v37.GetLowestHealthUnitWithoutBuff(v22, v20.RenewingMistBuff) or v37.GetLowestHealthUnitWithoutBuff(v22, v20.ChiHarmonyBuff);
	v74 = v37.GetLowestHealthUnitWithBuffAndNoBuff(v22, v20.ChiHarmonyBuff, v20.EnvelopingMist) or v37.GetLowestHealthUnitWithoutBuff(v22, v20.EnvelopingMist);
	v75 = v61(v22, v20.SoothingMist);
	v80 = v61(v22, v20.ChiHarmonyBuff);
	v76 = v12.ToggleIconFrame:GetToggle(245 - (187 + 54));
	v77 = v12.ToggleIconFrame:GetToggle(785 - (162 + 618));
	v30 = v12.ToggleIconFrame:GetToggle(1 + 0);
	v78 = not v76 or (v20.Chiji:IsAvailable() and v20.Chiji:CooldownDown()) or (v20.Yulon:IsAvailable() and v20.Yulon:CooldownDown());
	v79 = v37.GetAverageGroupHealthPercent(v22);
end
local function v87()
	if (((v71 >= (24 + 11)) and v43()) or (v41(v7) and (v20.DetoxMW:CooldownDown() or not v20.ImprovedDetox:IsAvailable()) and (v7:HealthPercentage() < (213 - 113)))) then
		if (v6:IsChanneling(v20.SoothingMist) and v7:BuffUp(v20.SoothingMist, nil, true) and (v6:CastRemains() > (v6:GCD() + (0.25 - 0))) and (v6:GCDRemains() < (0.2 + 0))) then
			if ((v7:BuffDown(v20.EnvelopingMist, nil, true) or (v7:BuffUp(v20.EnvelopingMist, nil, true) and (v7:BuffRemains(v20.EnvelopingMist, nil, true) < (1637 - (1373 + 263))))) and not v6:PrevGCD(1001 - (451 + 549), v20.EnvelopingMist) and v20.EnvelopingMist:IsReady()) then
				v15(v20.EnvelopingMist, true);
				return "NPC EnvelopingMist";
			end
			if (v7:BuffUp(v20.EnvelopingMist, nil, true) and v20.Vivify:IsReady()) then
				v15(v20.Vivify, true);
				return "NPC Vivify";
			end
		else
			if (v20.RenewingMist:IsReady() and (v20.RenewingMist:Charges() > (0 + 0)) and v47(v7)) then
				v15(v20.RenewingMist);
				return "NPC RenewingMist";
			end
			if (not v6:IsChanneling(v20.SoothingMist) and v20.SoothingMist:IsReady() and not v6:PrevGCD(1 - 0, v20.SoothingMist)) then
				print("TEST");
				v46(v20.SoothingMist, nil, 4 - 1);
				return "NPC SoothingMist";
			end
		end
	end
	if v6:BuffDown(v20.YulonBuff, nil, true) then
		v36 = true;
	end
	if v6:BuffUp(v20.YulonBuff, nil, true) then
		if (v37.BuffCount(v22, v20.EnvelopingMist) <= (1388 - (746 + 638))) then
		else
			v36 = false;
		end
		if not v36 then
			if ((v73 ~= nil) and not v20.AncientTeachingsTalent:IsAvailable() and v20.RenewingMist:IsReady() and (v20.RenewingMist:Charges() > (0 + 0))) then
				if (v20.ThunderFocusTea:IsReady() and v6:BuffDown(v20.ThunderFocusTea, nil, true)) then
					v15(v20.ThunderFocusTea, true);
					return "Renewing Mist Yulon TFT";
				end
				v73:Cast(v20.RenewingMist);
				return "Renewing Mist Yulon TFT";
			end
			if (v20.RenewingMist:IsReady() and (v73:HealthPercentageWeighted() <= v39.Healing.RenewingMistHP) and ((v20.RenewingMist:Charges() > (1 - 0)) or ((v20.RenewingMist:Charges() > (348 - (218 + 123))) and (v20.AncientTeachingsTalent:IsAvailable() or (v20.ThunderFocusTea:CooldownRemains() > (1589 - (1535 + 46))))))) then
				v73:Cast(v20.RenewingMist);
				return "Renewing Mist Yulon 1";
			end
			if ((v80 ~= nil) and v20.Vivify:IsReady() and (v80:HealthPercentageWeighted() < (80 + 0))) then
				v80:Cast(v20.Vivify, true);
				return "Vivify Cast on Chi Unit - Yulon Ramp";
			end
			if ((v74 ~= nil) and (v74:HealthPercentageWeighted() < (12 + 68))) then
				if (v20.EnvelopingMist:IsReady() and v74:BuffDown(v20.EnvelopingMist, nil, true)) then
					v74:Cast(v20.EnvelopingMist, true);
					return "Yulong envmist High Prirot";
				end
			end
			if (v74 ~= nil) then
				if (v20.EnvelopingMist:IsReady() and v74:BuffDown(v20.EnvelopingMist, nil, true)) then
					v74:Cast(v20.EnvelopingMist, true);
					return "Yulong envmist";
				end
			end
		end
		if (v20.ThunderFocusTea:IsReady() and v20.AncientTeachingsTalent:IsAvailable() and v6:AffectingCombat() and not v58() and (v71 < (640 - (306 + 254))) and v6:BuffDown(v20.ThunderFocusTea, nil, true) and not v20.Upwelling:IsAvailable() and (v54(1 + 9) or v53) and v20.RisingSunKick:IsReady()) then
			v15(v20.ThunderFocusTea, true);
			return "Thunder Focus Yulon RisingSunKick";
		end
		if (v20.RisingSunKick:IsReady() and v28 and (v6:IsInRaid() or (v72 < (157 - 77)))) then
			v15(v20.RisingSunKickCast);
			return "RisingSunKick  Yulon";
		end
		if ((v80 ~= nil) and v20.Vivify:IsReady()) then
			v80:Cast(v20.Vivify, true);
			return "Vivify Cast on Chi Unit - Yulon Ramp";
		end
		if v20.Vivify:IsReady() then
			v69:Cast(v20.Vivify, true);
			return "Vivify Cast on UnitLowest - Yulon Ramp";
		end
		if ((v74 ~= nil) and v36) then
			if (v20.EnvelopingMist:IsReady() and v74:BuffDown(v20.EnvelopingMist)) then
				v74:Cast(v20.EnvelopingMist, true);
				return "Yulong envmist stack " .. v74:Name();
			end
		end
		return "YULON UP Nothing";
	end
	if (v20.CelestialConduit:IsReady() and v37.AoELogicWithCount(v39.AoE.CCHP, v39.AoE.CCCount, "With Logic", v22)) then
		v12.Cast(v20.CelestialConduit);
		return "Celestial Conduit";
	end
	if (v75 ~= nil) then
		if (v6:IsChanneling(v20.SoothingMist) and v75:BuffUp(v20.SoothingMist, nil, true) and (v6:GCDRemains() < (1467.2 - (899 + 568))) and (v6:CastRemains() > (v6:GCD() + 0.25 + 0))) then
			if (v75:BuffDown(v20.EnvelopingMist, nil, true) and v20.EnvelopingMist:IsReady()) then
				v75:Cast(v20.EnvelopingMist, true);
				return "Soothing Mist EnvelopingMist";
			end
			if not v20.PeerIntoPeace:IsAvailable() then
				local v146 = v37.GetLowestHealthUnitWithBuff(v22, v20.RenewingMistBuff);
				if (v75:BuffUp(v20.EnvelopingMist, nil, true) and v20.Vivify:IsReady() and ((v75:HealthPercentageWeighted() <= v39.Healing.VivVivifyHP) or (v146 and (v146:HealthPercentageWeighted() <= v39.Healing.VivVivifyHP)))) then
					v75:Cast(v20.Vivify, true);
					return "Soothing Mist Vivify";
				end
			elseif (v75:BuffUp(v20.EnvelopingMist, nil, true) and v20.Vivify:IsReady() and (v75:HealthPercentageWeighted() <= v39.Healing.VivVivifyHP)) then
				v75:Cast(v20.Vivify, true);
				return "Soothing Mist Vivify peer";
			end
		end
		if (v20.AncientTeachingsTalent:IsAvailable() and (v75:HealthPercentageWeighted() >= v39.Healing.VivVivifyHP) and v28) then
			v12.CastMacro(14 - 8, true);
			return "Break SoothingMist";
		end
	end
	if (v20.PeerIntoPeace:IsAvailable() and v6:IsChanneling(v20.SoothingMist) and (v6:CastRemains() > (v6:GCD() + (603.25 - (268 + 335)))) and (v6:GCDRemains() < (290.2 - (60 + 230)))) then
		if (v74 ~= nil) then
			if (v20.EnvelopingMist:IsReady() and v74:BuffDown(v20.EnvelopingMist, nil, true)) then
				v74:Cast(v20.EnvelopingMist, true);
				return "Soothing swap envmist";
			end
		end
		if ((v80 ~= nil) and v20.Vivify:IsReady() and (v80:HealthPercentageWeighted() < v39.Healing.VivVivifyHP)) then
			v80:Cast(v20.Vivify, true);
			return "Vivify Cast on Chi Unit peer";
		end
		if (v20.Vivify:IsReady() and (v71 < v39.Healing.VivVivifyHP)) then
			v69:Cast(v20.Vivify, true);
			return "Vivify Cast on lowest Peer";
		end
	end
	if (v20.LifeCocoon:IsReady() and v6:AffectingCombat()) then
		if (v64 == nil) then
			v64 = v69;
		end
		if ((v64:HealthPercentageWeighted() > v39.Healing.LCHP) and (v64:HealthPercentageWeighted() > (572 - (426 + 146)))) then
			v64 = nil;
			startime = nil;
		end
		if (v64 == nil) then
		elseif ((v64:HealthPercentageWeighted() <= v39.Healing.LCHP) and (v64:HealthPercentageWeighted() > (0 + 0))) then
			if (startime == nil) then
				startime = GetTime();
				v66 = math.random(1606 - (282 + 1174), 1611 - (569 + 242)) / (2880 - 1880);
			elseif (GetTime() < (startime + v66)) then
			else
				v64:Cast(v20.LifeCocoon, true);
				return "LC";
			end
		end
	elseif (startime ~= nil) then
		startime = nil;
	end
	if v6:IsChanneling(v20.SoothingMist) then
		return "Soothing Mist Casting";
	end
	if (v39.Commons.Enabled.Trinkets and v21.FyrakkTainedRageHeart:IsEquippedAndReady() and v14() and v13()) then
		if ((v25 >= (1 + 3)) and v54(1044 - (706 + 318))) then
			if v15(v21.FyrakkTainedRageHeart, true) then
				return "FyrakkTainedRageHeart offense";
			end
		end
	end
	if ((v71 >= (1286 - (721 + 530))) and v20.TigersLust:IsReady() and (v6:DebuffElapsed(v20.EntangledDebuff) > (1271 - (945 + 326)))) then
		v15(v20.TigersLust);
		return "Cast Tiger's Lust";
	end
	if (not v6:AffectingCombat() and v30) then
		if (v20.ManaTea:IsReady() and (v79 >= (112 - 67)) and (v71 > (0 + 0)) and (v6:ManaPercentage() <= (770 - (271 + 429))) and v39.Mistweaver.ManaTeaOOC and (v6:BuffStack(v20.ManaTeaBuff) >= (10 + 0)) and not v6:IsChanneling(v20.ManaTea)) then
			v15(v20.ManaTea);
			return "Mana Tea OOC";
		end
		if (v73 ~= nil) then
			if (v20.RenewingMist:IsReady() and (v20.RenewingMist:Charges() > (1501 - (1408 + 92))) and (v73:HealthPercentageWeighted() <= v39.Healing.RenewingMistOOC)) then
				v73:Cast(v20.RenewingMist);
				return "OOC RENEWINGMist";
			end
		end
	end
	if v81 then
		if (v20.TouchofDeath:IsReady() and v37.TargetIsValid() and v28 and not v6:IsInRaid() and ((v7:Health() < v6:Health()) or (v20.ImpTouchofDeath:IsAvailable() and (v7:HealthPercentageWeighted() < (1101 - (461 + 625)))))) then
			v15(v20.TouchofDeath);
			return "Touch of Death";
		end
	end
	if (v67 ~= nil) then
		if (not v6:AffectingCombat() and (GetTime() >= (v67 + (1303 - (993 + 295))))) then
			v35 = false;
		end
	end
	if (v20.SummonJadeSerpentStatue:CooldownRemains(true) <= (1 + 4)) then
		v67 = GetTime();
		v35 = true;
	end
	if ((v30 or v6:AffectingCombat()) and not v35) then
		if v20.SummonJadeSerpentStatue:IsReady() then
			v15(v20.SummonJadeSerpentStatue);
			return "Summon Jade Serpent Statue";
		end
	end
	if (v6:BuffDown(v20.JadeEmpowermentBuff) and not v6:PrevGCD(1172 - (418 + 753), v20.CracklingJadeLightning) and v20.ThunderFocusTea:IsReady() and v20.JadeEmpowerment:IsAvailable() and (v56() or v55())) then
		v15(v20.ThunderFocusTea, true);
		v15(v20.CracklingJadeLightning);
		return "Thunder Focus Tea for Jade Empower into Crackling - Proactive AoE";
	end
	if (v6:BuffUp(v20.JadeEmpowermentBuff) and v85 and v37.TargetIsValid() and not v6:PrevGCD(1 + 0, v20.CracklingJadeLightning)) then
		if v20.CracklingJadeLightning:IsReady() then
			v15(v20.CracklingJadeLightning);
			return "Crackling Jade While Empowerment Up";
		end
	end
	if (v20.AncientTeachingsTalent:IsAvailable() and v20.ManaTea:IsReady() and (v79 >= (5 + 40)) and (v71 > (18 + 42)) and (v6:ManaPercentage() <= v39.Mistweaver.ManaTeaMP) and (v6:BuffStack(v20.ManaTeaBuff) >= v39.Mistweaver.ManaTeaStack) and not v6:BuffUp(v20.YulonBuff, nil, true) and not (v62(v20.Chiji) > (0 + 0)) and not v6:IsChanneling(v20.ManaTea)) then
		v15(v20.ManaTea);
		return "Mana Tea - AT Group Above 45 and Lowest Above 60 - Settings Met for Mana";
	end
	if (v20.SheilunsGift:IsReady() and not v6:IsMoving() and (v20.SheilunsGift:Count() > v39.Cooldowns.SGStack) and v37.AoELogicWithCount(v39.AoE.SGHP, v39.AoE.SGCount, v39.Cooldowns.UseSG, v22) and v78) then
		v69:Cast(v20.SheilunsGift);
		return "SG Outside of Ramp";
	end
	if (v20.ThunderFocusTea:IsReady() and (not v20.AncientTeachingsTalent:IsAvailable() or v6:IsInRaid()) and not v76 and v6:AffectingCombat() and v6:BuffDown(v20.ThunderFocusTea, nil, true) and (v54(539 - (406 + 123)) or v53) and v20.RenewingMist:IsReady() and (v20.RenewingMist:Charges() > (1769 - (1749 + 20)))) then
		v15(v20.ThunderFocusTea, true);
		return "Thunder Focus RenewingMist";
	end
	if (v20.ThunderFocusTea:IsReady() and v20.AncientTeachingsTalent:IsAvailable() and not v76 and v6:AffectingCombat() and not v58() and (v71 < (23 + 72)) and v6:BuffDown(v20.ThunderFocusTea, nil, true) and (v54(1332 - (1249 + 73)) or v53) and v20.RisingSunKick:IsReady()) then
		v15(v20.ThunderFocusTea, true);
		v15(v20.RisingSunKick);
		return "Thunder Focus RisingSunKick";
	end
	if v6:BuffUp(v20.ThunderFocusTea, nil, true) then
		if (v70 and v6:AffectingCombat() and ((v34 <= (18 + 32)) or ((v25 >= (1149 - (466 + 679))) and v70:BuffDown(v20.EnvelopingMist) and not v6:IsInRaid())) and v20.ZenPulse:IsReady()) then
			v70:Cast(v20.EnvelopingMist);
			return "Thunder Focus EnvelopingMist";
		end
		if (v6:AffectingCombat() and not v58() and v20.AncientTeachingsTalent:IsAvailable() and v20.RisingSunKick:IsReady()) then
			v15(v20.RisingSunKickCast);
			return "Thunder Focus RisingSunKick";
		end
		if v20.SecertInfusion:IsAvailable() then
			if (v73 == nil) then
				if (v20.RenewingMist:IsReady() and (v20.RenewingMist:Charges() > (0 - 0)) and (v73:HealthPercentageWeighted() <= (286 - 186)) and (v6:IsInRaid() or (not v6:IsInRaid() and (v37.BuffCount(v22, v20.RenewingMist) < (1905 - (106 + 1794)))))) then
					v73:Cast(v20.RenewingMist);
					return "Renewing Mist - Thunder Focus";
				end
			end
			if (not v6:IsInRaid() and v20.EnvelopingMist:IsReady() and (v71 <= v39.Healing.EnvMistHP) and (v37.BuffCount(v22, v20.EnvelopingMist) < (5 + 10))) then
				v69:Cast(v20.EnvelopingMist);
				return "Enveloping Mist Party - Thunder Focus /w Secert Infusion";
			end
		end
		if not v20.SecertInfusion:IsAvailable() then
			if (v74 == nil) then
				if (v20.EnvelopingMist:IsReady() and v20.ZenPulse:CooldownDown() and (v74:HealthPercentageWeighted() <= v39.Healing.EnvMistHP)) then
					v74:Cast(v20.EnvelopingMist);
					return "Eveloping Mist - Non SecertInfusion - Thunder Focus  - Env Unit";
				end
			end
			if (v6:BuffDown(v20.EnvelopingMist, nil, true) and (v6:HealthPercentageWeighted() <= v39.Healing.EnvMistTFTHPOnPlayer)) then
				v6:Cast(v20.EnvelopingMist);
				return "Eveloping Mist - Non SecertInfusion - Thunder Focus  - Player Unit";
			end
			if (v73 ~= nil) then
				if (v20.RenewingMist:IsReady() and (v20.RenewingMist:Charges() > (0 + 0)) and (v73:HealthPercentageWeighted() <= (295 - 195)) and (v6:IsInRaid() or (not v6:IsInRaid() and (v37.BuffCount(v22, v20.RenewingMist) < (13 - 8))))) then
					v73:Cast(v20.RenewingMist);
					return "Renewing Mist Thudner Focus - No SecertInfusion";
				end
			end
		end
	end
	if (v20.FaelineStomp:IsReady() and v37.TargetIsValid() and not v40(v7) and (not v6:IsCameraBusy() or not v39.Cooldowns.FSCursorBusy) and v7:AffectingCombat() and (not v6:IsMoving() or v39.Cooldowns.FSMoving) and v29) then
		local v139 = v58() or (v6:BuffDown(v20.AwakenedFaeline) and v20.AwakenedFaelineTalent:IsAvailable()) or v37.AoELogicWithCount(v39.AoE.FSHP, v39.AoE.FSCount, "With Logic", v22);
		local v140 = (((v39.Cooldowns.UseFae == "With Logic") or ((v39.Cooldowns.UseFae == "With Cooldowns and Logic") and v14)) and v139) or ((v39.Cooldowns.UseFae == "With Cooldowns") and v14);
		if v140 then
			v15(v20.FaelineStomp);
			return "Faeline/Jadefire Stomp 1";
		end
	end
	if (v62(v20.Chiji) > (114 - (4 + 110))) then
		local v141 = v74 or v69;
		if (not v6:PrevGCD(585 - (57 + 527), v20.EnvelopingMist) and (v141:BuffDown(v20.EnvelopingMist, nil, true) or (v141:HealthPercentage() < (1507 - (41 + 1386)))) and v20.EnvelopingMist:IsReady() and v6:BuffUp(v20.ChijiBuff, nil, true) and ((v6:BuffStack(v20.ChijiBuff) == (106 - (17 + 86))) or ((v6:BuffStack(v20.ChijiBuff) == (2 + 0)) and not v6:IsMoving() and (v141:HealthPercentageWeighted() < (178 - 98))))) then
			v141:Cast(v20.EnvelopingMist);
			return "Env  ";
		end
		if (v37.TargetIsValid() and v28 and not v40(v7) and v7:AffectingCombat()) then
			if (v20.BlackoutKick:IsReady() and v28 and ((v6:BuffStack(v20.TeachingsMons) > (8 - 5)) or not v20.TeachingsoftheMonasteryTalent:IsAvailable())) then
				v15(v20.BlackoutKick);
				return "Blkout TeachingsMons Chiji";
			end
			if (v20.RisingSunKick:IsReady() and v28 and (v6:IsInRaid() or (v72 < (246 - (122 + 44))))) then
				v15(v20.RisingSunKickCast);
				return "RisingSunKick raid Chiji";
			end
			if (v20.EyeoftheTiger:IsAvailable() and (v37.DebuffCount(v26, v20.EyeOfTheTigerBuff) == (0 - 0)) and v20.TigerPalm:IsReady() and v28) then
				v15(v20.TigerPalm);
				return "TP EyeoftheTiger ";
			end
			if (v13() and v20.SpinningCraneKick:IsReady() and ((v25 >= (12 - 8)) or v6:BuffUp(v20.DanceOfChijiMW)) and not v6:IsInRaid() and v6:BuffUp(v20.AwakenedFaeline)) then
				v15(v20.SpinningCraneKick);
				return "SpinningCraneKick Chiji";
			end
			if (v20.BlackoutKick:IsReady() and v28 and v6:BuffUp(v20.AncientConcordance) and (v25 >= (2 + 0))) then
				v15(v20.BlackoutKick);
				return "Blkout AncientConcordance AOE Chiji";
			end
			if (v20.RisingSunKick:IsReady() and v28) then
				v15(v20.RisingSunKickCast);
				return "RisingSunKick Chiji";
			end
			if (v20.TigerPalm:IsReady() and v28 and v6:BuffUp(v20.AwakenedFaeline) and (v6:BuffStack(v20.TeachingsMons) <= (1 + 2)) and v20.TeachingsoftheMonasteryTalent:IsAvailable()) then
				v15(v20.TigerPalm);
				return "TP TeachingsMons Chiji";
			end
			if (v20.BlackoutKick:IsReady() and v28) then
				v15(v20.BlackoutKick);
				return "BlackoutKick basic Chiji";
			end
			if (v20.TigerPalm:IsReady() and v28) then
				v15(v20.TigerPalm);
				return "TP DPS Chiji";
			end
		end
	end
	if (v76 and v6:AffectingCombat() and v6:BuffDown(v20.YulonBuff, nil, true) and (v62(v20.Chiji) <= (0 - 0)) and ((v20.Yulon:IsAvailable() and v20.Yulon:CooldownUp()) or (v20.Chiji:IsAvailable() and v20.Chiji:CooldownUp()))) then
		local v142 = (v20.TeachingsoftheMonasteryTalent:IsAvailable() and v6:BuffUp(v20.TeachingsMons, nil, true) and (v6:BuffStack(v20.TeachingsMons) >= (68 - (30 + 35)))) or not v20.TeachingsoftheMonasteryTalent:IsAvailable();
		local v143 = (v20.Chiji:IsReady() and v142) or v20.Yulon:IsReady();
		if not v6:IsChanneling() then
			if (not v20.Yulon:IsAvailable() and v20.TeachingsoftheMonasteryTalent:IsAvailable() and (v6:BuffStack(v20.TeachingsMons) < (3 + 0)) and v28 and v37.TargetIsValid()) then
				v15(v20.TigerPalm);
				return "Tiger Palm Ramp";
			end
			if (v20.ShaohaosLessionTalent:IsAvailable() and v142) then
				if (v20.SheilunsGift:IsReady() and not v6:IsMoving() and (v20.SheilunsGift:Count() >= (1261 - (1043 + 214))) and v143) then
					v69:Cast(v20.SheilunsGift);
					return "SG Ramp";
				end
			end
			if (v73 and not v20.AncientTeachingsTalent:IsAvailable() and v20.RenewingMist:IsReady() and (v20.RenewingMist:Charges() > (0 - 0))) then
				if (v20.ThunderFocusTea:IsReady() and v6:BuffDown(v20.ThunderFocusTea, nil, true)) then
					v15(v20.ThunderFocusTea, true);
					return "Renewing Mist Ramp";
				end
				v73:Cast(v20.RenewingMist);
				return "Renewing Mist Ramp";
			end
		end
		if (v20.Yulon:IsReady() and (not v20.ShaohaosLessionTalent:IsAvailable() or (v20.SheilunsGift:Count() < (1219 - (323 + 889))))) then
			v46(v20.Yulon);
			return "yulon Ramp";
		end
		if (v142 and v28 and v20.Chiji:IsReady() and (not v20.ShaohaosLessionTalent:IsAvailable() or (v20.SheilunsGift:Count() < (10 - 6)))) then
			v46(v20.Chiji);
			return "Chiji Ramp";
		end
	end
	if (v20.Revival:IsReady() and v20.Revival:IsAvailable() and v37.AoELogicWithCount(v39.AoE.RevivalHP, v39.AoE.RevivalCount, v39.Cooldowns.UseRevival, v22) and v78) then
		v15(v20.Revival);
		return "Revival";
	end
	if (v20.Restoral:IsReady() and v20.Restoral:IsAvailable() and v37.AoELogicWithCount(v39.AoE.RevivalHP, v39.AoE.RevivalCount, v39.Cooldowns.UseRevival, v22) and v78) then
		v15(v20.Restoral);
		return "Restoral";
	end
	if (v20.Chiji:IsReady() and v20.Chiji:IsAvailable() and v37.TargetIsValid() and v28 and v37.AoELogicWithCount(v39.AoE.ChijiHP, v39.AoE.ChijiCount, v39.Cooldowns.UseChiji, v22) and v78) then
		v15(v20.Chiji);
		return "Chiji Cast Settings";
	end
	if (v20.Yulon:IsReady() and v20.Yulon:IsAvailable() and v37.AoELogicWithCount(v39.AoE.YulonHP, v39.AoE.YulonCount, v39.Cooldowns.UseYulon, v22) and v78) then
		v15(v20.Yulon);
		return "Yulon Cast Settings";
	end
	if (v6:BuffUp(v20.EscapeFromReality, nil, true) and not v6:IsMoving() and v37.AoELogic(v39.Cooldowns.EscapeHP, "With Logic", v22) and not v6:PrevGCD(581 - (361 + 219), v20.SoothingMist)) then
		v6:Cast(v20.SoothingMist);
		return "Soothing EFR";
	end
	if v77 then
		if (v20.Transcendence:IsReady() and v37.AoELogic(v39.Cooldowns.EscapeHP, "With Logic", v22) and v6:BuffDown(v20.Transcendence, nil, true) and v20.TranscendenceTransfer:CooldownUp()) then
			v15(v20.Transcendence);
			return "Transcendence";
		end
		if (v20.TranscendenceTransfer:IsReady() and v37.AoELogic(v39.Cooldowns.EscapeHP, "With Logic", v22) and v6:BuffUp(v20.Transcendence, nil, true)) then
			v15(v20.Transcendence);
			return "TranscendenceTransfer";
		end
	end
	if v33 then
		if (v20.SoothingMist:IsReady() and not v6:PrevGCD(321 - (53 + 267), v20.SoothingMist) and (not v28 or (v20.AncientTeachingsTalent:IsAvailable() and v6:BuffDown(v20.AncientTeachings))) and (v71 <= v39.Soothing.SoothingMistAtRange) and not v6:IsMoving()) then
			if (v20.RenewingMist:IsReady() and (v20.RenewingMist:Charges() > (0 + 0)) and v47(v69)) then
				v69:Cast(v20.RenewingMist);
				return "SoothingMist RenewingMist 4P";
			end
			if v6:IsInRaid() then
				v46(v20.SoothingMist, v69, 416 - (15 + 398));
			else
				v69:Cast(v20.SoothingMist);
			end
			return "Soothing on Lowest Unit Weighted";
		end
		if v74 then
			if (v6:BuffDown(v20.YulonBuff) and v20.EnvelopingMist:IsReady() and not v6:IsMoving() and not v6:PrevGCD(983 - (18 + 964), v20.EnvelopingMist) and (v74:HealthPercentageWeighted() <= v39.Healing.EnvMistHP)) then
				v74:Cast(v20.EnvelopingMist);
				return "EnV Unit";
			end
		end
		if (v20.SoothingMist:IsReady() and not v6:PrevGCD(3 - 2, v20.SoothingMist) and (v71 <= v39.Soothing.SoothingMistHP) and not v6:IsMoving()) then
			if (v20.RenewingMist:IsReady() and (v20.RenewingMist:Charges() > (0 + 0)) and v47(v69)) then
				v69:Cast(v20.RenewingMist);
				return "SoothingMist RenewingMist 4P";
			end
			if v6:IsInRaid() then
				v46(v20.SoothingMist, v69, 2 + 1);
			else
				v69:Cast(v20.SoothingMist);
			end
			return "Soothing on Weighted Unit 2";
		end
		if (v20.Vivify:IsReady() and not v6:PrevGCD(851 - (20 + 830), v20.Vivify) and not v6:IsMoving() and v49(v69, v72, v39.Healing.VivifyHP)) then
			v69:Cast(v20.Vivify);
			return "Vivify 2";
		end
	end
	if (v20.Vivify:IsReady() and v6:BuffDown(v20.ThunderFocusTea, nil, true) and not v6:PrevGCD(1 + 0, v20.Vivify) and v6:BuffUp(v20.VivaciousVivification, nil, true) and v49(v69, v72, v39.Healing.VivVivifyHP)) then
		v69:Cast(v20.Vivify);
		return "Vivify";
	end
	if (v33 and v6:BuffDown(v20.YulonBuff, nil, true) and (v62(v20.Chiji) == (126 - (116 + 10)))) then
		if v73 then
			if (v20.RenewingMist:IsReady() and (v73:HealthPercentageWeighted() <= v39.Healing.RenewingMistHP) and ((v20.RenewingMist:Charges() > (1 + 0)) or ((v20.RenewingMist:Charges() > (738 - (542 + 196))) and (v20.AncientTeachingsTalent:IsAvailable() or (v20.ThunderFocusTea:CooldownRemains() > (17 - 9)))))) then
				v73:Cast(v20.RenewingMist);
				return "Renewing Mist Non-Ramp 1";
			end
		end
	end
	if v33 then
		if (v20.Vivify:IsReady() and not v6:PrevGCD(1 + 0, v20.Vivify) and not v6:IsMoving() and v49(v69, v72, v39.Healing.VivifyHP)) then
			v69:Cast(v20.Vivify);
			return "Vivify 2";
		end
	end
	if v20.RisingSunKick:CooldownDown() then
		if (v6:BuffUp(v20.StrengthOfTheBlackOx, nil, true) and not v6:PrevGCD(1 + 0, v20.EnvelopingMist) and v20.EnvelopingMist:IsReady()) then
			if (v70 and v6:AffectingCombat() and not v6:IsMoving() and v70:BuffDown(v20.EnvelopingMist)) then
				v70:Cast(v20.EnvelopingMist);
				return "Strength Ox EnvelopingMist";
			end
		end
		if v74 then
			if (v6:BuffUp(v20.StrengthOfTheBlackOx, nil, true) and not v6:PrevGCD(1 + 0, v20.EnvelopingMist) and v20.EnvelopingMist:IsReady()) then
				if (v6:AffectingCombat() and not v6:IsMoving()) then
					v74:Cast(v20.EnvelopingMist);
					return "Strength Ox EnvelopingMist";
				end
			end
		end
	end
	if (v78 and v6:BuffDown(v20.YulonBuff, nil, true) and v37.TargetIsValid() and not v40(v7) and v7:AffectingCombat()) then
		if (v20.RisingSunKick:IsReady() and v28 and (v6:IsInRaid() or (v72 < (210 - 130)))) then
			v15(v20.RisingSunKickCast);
			return "RisingSunKick raid";
		end
		if (v20.EyeoftheTiger:IsAvailable() and (v37.DebuffCount(v26, v20.EyeOfTheTigerBuff) == (0 - 0)) and v20.TigerPalm:IsReady() and v28) then
			v15(v20.TigerPalm);
			return "TP EyeoftheTiger";
		end
		if (v14() and v13() and v20.SummonWhiteTigerStatue:IsReady() and (v25 >= (1555 - (1126 + 425))) and v54(435 - (118 + 287)) and (not v6:IsCameraBusy() or not v39.Cooldowns.FSCursorBusy) and not v6:IsMoving()) then
			if v12.CastTarget(v20.SummonWhiteTigerStatue, v12.TName().PLAYER) then
				return "WhiterTigerStatue";
			end
		end
		if (v6:BuffUp(v20.JadeEmpowermentBuff) and v37.TargetIsValid()) then
			if (v20.CracklingJadeLightning:IsReady() and not v6:PrevGCD(3 - 2, v20.CracklingJadeLightning)) then
				v15(v20.CracklingJadeLightning);
				return "Crackling Jade While Empowerment Up";
			end
		end
		if (v20.CracklingJadeLightning:IsReady() and not v28 and v85 and not v6:PrevGCD(1122 - (118 + 1003), v20.CracklingJadeLightning)) then
			v15(v20.CracklingJadeLightning);
			return "Crackling Jade While at Range Up";
		end
		if v13() then
			if (v20.RisingSunKick:IsReady() and v20.RushingWindKick:IsAvailable() and (v25 >= (5 - 3)) and v28) then
				v15(v20.RisingSunKickCast);
				return "RisingSunKick2";
			end
		end
		if (v13() and v20.SpinningCraneKick:IsReady() and ((v25 >= (381 - (142 + 235))) or v6:BuffUp(v20.DanceOfChijiMW)) and not v6:IsInRaid() and (v6:BuffUp(v20.AwakenedFaeline) or v6:BuffDown(v20.AncientTeachings))) then
			v15(v20.SpinningCraneKick);
			return "SpinningCraneKick 1";
		end
		if (v20.BlackoutKick:IsReady() and v28 and ((v6:BuffStack(v20.TeachingsMons) > (13 - 10)) or not v20.TeachingsoftheMonasteryTalent:IsAvailable())) then
			v15(v20.BlackoutKick);
			return "Blkout TeachingsMons";
		end
		if (v20.BlackoutKick:IsReady() and v28 and v6:BuffUp(v20.AncientConcordance) and (v25 >= (1 + 1))) then
			v15(v20.BlackoutKick);
			return "Blkout AncientConcordance AOE";
		end
		if (v20.RisingSunKick:IsReady() and v28) then
			v15(v20.RisingSunKick);
			return "RisingSunKick1";
		end
		if (v20.TigerPalm:IsReady() and v28 and v6:BuffUp(v20.AwakenedFaeline) and (v6:BuffStack(v20.TeachingsMons) <= (980 - (553 + 424))) and v20.TeachingsoftheMonasteryTalent:IsAvailable()) then
			v15(v20.TigerPalm);
			return "TP TeachingsMons ";
		end
		if (v20.BlackoutKick:IsReady() and v28) then
			v15(v20.BlackoutKick);
			return "BlackoutKick basic";
		end
		if v39.Commons.Enabled.Items then
			if (v21.Iridal:IsEquippedAndReady() and v37.TargetIsValid()) then
				if not v6:IsMoving() then
					v12.CastMacro(1 - 0, nil, nil, v21.Iridal);
					return "weapon cast Iridal";
				end
			else
				local v147, v148, v149 = v6:GetUseableItems(v23, 15 + 1);
				if (v147 and v147:IsReady() and v7:IsInRange(v149) and v37.TargetIsValid()) then
					v12.CastMacro(1 + 0);
					return "weapon cast";
				end
			end
		end
		if (v20.TigerPalm:IsReady() and v28) then
			v15(v20.TigerPalm);
			return "TP DPS";
		end
	end
	if (v20.ChiBurst:IsReady() and not v6:IsMoving() and v6:BuffUp(v20.AwakenedFaeline) and (v27 > (2 + 1)) and not v28 and v7:AffectingCombat() and v20.FaelineStomp:CooldownDown()) then
		v15(v20.ChiBurst);
		return "ChiBurst";
	end
end
local function v88()
	if v37.ShouldStopCastUpdate() then
		v12.CastMacro(3 + 3, true);
		return "Stop Cast For Silence";
	end
	if v6:IsChanneling(v20.CelestialConduit) then
		return;
	end
	if (not v6:IsMounted() and (v37.TargetIsValid() or v6:AffectingCombat() or v30)) then
		if not v6:AffectingCombat() then
			v82 = v60();
			if v82 then
				return v82;
			end
		end
		if (v31 and not v6:IsInRaid() and v20.DetoxMW:IsReady() and v20.ImprovedDetox:IsAvailable() and not v6:IsChanneling(v20.SoothingMist)) then
			v82 = v37.AfflictedLogic(v20.DetoxMW, true);
			if v82 then
				return v82;
			end
		end
		if (v31 and v20.TigersLust:IsReady()) then
			v82 = v37.DispelCycle(v20.TigersLust, "FreedomDispel", nil, v83);
			if v82 then
				return v82;
			end
		end
		if v6:AffectingCombat() then
			if v32 then
				if v20.SpearHandStrike:IsReady() then
					v82 = v37.InterruptCycle(v20.SpearHandStrike, 3 + 2, true, nil, false);
					if v82 then
						return v82;
					end
				end
				if v20.LegSweep:IsReady() then
					v82 = v37.InterruptCycle(v20.LegSweep, 17 - 9, true, nil, true, true);
					if v82 then
						return v82;
					end
				end
				if v39.Mistweaver.LegSweepInt then
					if (v20.SpearHandStrike:CooldownDown() and v20.LegSweep:IsReady()) then
						v82 = v37.InterruptCycle(v20.LegSweep, 22 - 14, true, nil, false, true);
						if v82 then
							return v82;
						end
					end
				end
				if v39.Mistweaver.ParaInt then
					if v20.Paralysis:IsReady() then
						v82 = v37.InterruptCycle(v20.Paralysis, 44 - 24, true, nil, true);
						if v82 then
							return v82;
						end
						v82 = v20.PressurePoints:IsAvailable() and v37.SootheCycle(v20.Paralysis, 6 + 14, false);
						if v82 then
							return v82;
						end
						if v20.SpearHandStrike:CooldownDown() then
							v82 = v37.InterruptCycle(v20.Paralysis, 96 - 76, true, nil, false);
							if v82 then
								return v82;
							end
						end
					end
				end
			end
			if v20.Paralysis:IsReady() then
				v82 = v37.IncorpCycle(v20.Paralysis, 773 - (239 + 514), true, false);
				if v82 then
					return v82;
				end
			end
			if (v31 and not v6:IsInRaid() and v20.DetoxMW:IsReady() and not v6:IsChanneling(v20.SoothingMist)) then
				v82 = v37.DispelCycle(v20.DetoxMW, "Magic", true, v22);
				if v82 then
					return v82;
				end
				if v20.ImprovedDetox:IsAvailable() then
					v82 = v37.DispelCycle(v20.DetoxMW, "Disease", true, v22);
					if v82 then
						return v82;
					end
					v82 = v37.DispelCycle(v20.DetoxMW, "Poison", true, v22);
					if v82 then
						return v82;
					end
				end
				if v20.TigersLust:IsReady() then
					v82 = v37.DispelCycle(v20.TigersLust, "RootDispel", true);
					if v82 then
						return v82;
					end
					v82 = v37.DispelCycle(v20.TigersLust, "SnareRoot", true);
					if v82 then
						return v82;
					end
				end
			end
			if (v31 and v6:IsInRaid() and v20.DetoxMW:IsReady()) then
				v82 = v37.DispelCycle(v20.DetoxMW, "Raid", true, v22);
				if v82 then
					return v82;
				end
			end
		end
		if (v39.Mistweaver.AutoTabMelee and (v68 > (0 + 0)) and not v28 and v6:CanAttack(v7)) then
			v12.TopPanelAlternative:ChangeIcon(1330 - (797 + 532), 3 + 0);
			return "Auto tab to melee";
		end
		if v6:IsChanneling(v20.ManaTea) then
			if ((((v71 < (27 + 53)) or (v6:ManaPercentage() >= (211 - 121)) or (v6:BuffUp(v20.YulonBuff, nil, true) and (v62(v20.Chiji) > (1202 - (373 + 829))))) and (v44(v20.ManaTea) > (v45 or (732 - (476 + 255))))) or (v44(v20.ManaTea) > (1135 - (369 + 761)))) then
				v12.CastMacro(4 + 2, true);
				return "Break Mana tea";
			end
		end
		v82 = v59();
		if v82 then
			return v82;
		end
		v82 = v57(v39.Cooldowns.Trinket1HP, v39.Cooldowns.Trinket1Use, v39.Cooldowns.Trinket2HP, v39.Cooldowns.Trinket2Use, v22);
		if v82 then
			return v82;
		end
		v82 = v87();
		if v82 then
			return v82;
		end
		if ((v71 > (163 - 73)) and (v6:ManaPercentage() <= v39.Mistweaver.ManaTeaMP) and (v6:BuffStack(v20.ManaTeaBuff) >= v39.Mistweaver.ManaTeaStack) and not v6:IsChanneling(v20.ManaTea)) then
			v15(v20.ManaTea);
			return "Mana Tea - Settings Met for Mana";
		end
	end
end
local function v89()
	v12.ResetToggle();
	v39.Mistweaver.Display();
	v12:UpdateMacro("macro1", "/use 16");
	v12:UpdateMacro("macro6", "/stopcasting");
	v12.ToggleIconFrame:AddButtonCustom("O", 1 - 0, "OOC", "ooc");
	v12.ToggleIconFrame:AddButtonCustom("D", 240 - (64 + 174), "Dispel", "dispel");
	v12.ToggleIconFrame:AddButtonCustom("K", 1 + 2, "Kick", "kick");
	v12.ToggleIconFrame:AddButtonCustom("R", 5 - 1, "Ramp", "ramp");
	v12.ToggleIconFrame:AddButtonCustom("T", 341 - (144 + 192), "Transcendence", "transcendence");
	v12.ToggleIconFrame:AddButtonCustom("H", 222 - (42 + 174), "Heal", "heal");
	v12.ToggleIconFrame:AddButtonCustom("TD", 6 + 1, "Touch of Death", "touchofdeath");
	v12.Print("Mistweaver Monk rotation updated to 10.20.5.");
end
v12.SetAPL(224 + 46, v88, v89, v86);
