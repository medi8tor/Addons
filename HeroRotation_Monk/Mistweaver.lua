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
local function v40(v86)
	return v86:NPCID() == (205179 - (555 + 64));
end
local function v41(v87)
	return v87:NPCID() == (205704 - (857 + 74));
end
local function v42(v88)
	return (v88:NPCID() == (205017 - (367 + 201))) or (v88:NPCID() == (209386 - (214 + 713))) or (v88:NPCID() == (52181 + 156280)) or (v88:NPCID() == (32681 + 175119)) or (v88:NPCID() == (195523 - (282 + 595))) or (v88:NPCID() == (214227 - (1523 + 114)));
end
local function v43()
	return v42(v7) and not v6:CanAttack(v7);
end
local function v44(v89)
	local v90 = v6:ChannelStart(v89);
	return (v6:IsChanneling(v89) and (GetTime() - v90)) or (0 + 0);
end
local v45 = 0 - 0;
local function v46(v91, v92, v93)
	v45 = v93;
	if (v20.ManaTea:IsReady() and (v6:BuffStack(v20.ManaTeaBuff) >= (1068 - (68 + 997))) and v6:BuffDown(v20.ManaTeaBuff2) and not v6:IsChanneling(v20.ManaTea)) then
		if v12.DebugON() then
			print("Cast ManaTea Spell" .. v91:Name());
		end
		return v15(v20.ManaTea);
	end
	if (v6:IsChanneling(v20.ManaTea) and (v44(v20.ManaTea) <= (v93 or (1271 - (226 + 1044)))) and (not v92 or (v92:HealthPercentage() > (174 - 134)))) then
		return "wait manatea";
	end
	if v92 then
		v45 = 117 - (32 + 85);
		return v92:Cast(v91, true);
	end
	v45 = 0 + 0;
	return v15(v91, true);
end
local function v47(v94)
	return v20.ChiHarmony:IsAvailable() and v94:BuffDown(v20.ChiHarmonyBuff);
end
local v48 = v37.converArrayToList({(261698 - (892 + 65)),(792131 - 363589),(417066 - (87 + 263))});
local function v49(v95, v96, v97)
	return (v96 < v97) or v37.unitHasDebuffFromList(v48, v95);
end
local v50 = {(188365 + 68517),(147305 + 52986),(370280 - (802 + 150)),(679571 - 304937),(386178 - (915 + 82)),(217116 + 155585),(370514 - (1069 + 118))};
local v51 = {(567806 - 308234),(455885 - 199308),(259981 - (368 + 423)),(255595 - (10 + 8)),(202461 - (416 + 26)),(87763 + 116739),(221293 - (145 + 293)),(200875 - (998 + 488)),(167585 + 37081),(415621 - (116 + 1022)),(242786 + 170836),(1448765 - 1040787),(1019110 - 605504),(145558 + 266394),(759216 - 331993),(430374 - (630 + 793)),(802281 - 632836),(1472479 - 1044811),(430781 - (1789 + 124)),(26360 + 50274),(1022607 - 761905),(293394 + 80298),(1728378 - 1335738),(887233 - 494747),(1072157 - 680523),(389583 - (376 + 325)),(1174367 - 792704),(840452 - 458859),(389193 - (85 + 291)),(1463547 - 1078927),(375900 - (1123 + 57)),(384386 - (163 + 91)),(108160 + 278991),(589826 - 205812),(525378 - 143075),(377523 - (1329 + 145)),(376491 - (1409 + 441)),(171101 + 198364),(377611 - (345 + 1376)),(1655144 - 1280504),(390129 - (696 + 510)),(375627 - (1091 + 171)),(1222890 - 834466),(377378 - (123 + 251))};
local v52, v53;
local function v54(v98)
	return v53 or v37.ISSolo() or (v98 == (0 - 0)) or ((v52 >= v98) and (v52 < (8475 - (208 + 490))));
end
local function v55()
	local v99 = v6:GetEnemiesInRange(4 + 36);
	for v122, v123 in ipairs(v99) do
		if v50[v123:CastSpellID() or v123:ChannelSpellID()] then
			return true;
		end
	end
end
local function v56()
	local v100 = v6:GetEnemiesInRange(18 + 22);
	for v124, v125 in ipairs(v100) do
		if v51[v125:CastSpellID() or v125:ChannelSpellID()] then
			return true;
		end
	end
end
local function v57(v101, v102, v103, v104, v105)
	local v106, v107, v108 = v6:GetUseableItems(v23, 849 - (660 + 176));
	if (v106 and v37.AoELogic(v101, v102, v105)) then
		if v15(v106) then
			return "trinket1 trinkets 2";
		end
	end
	local v109, v107, v110 = v6:GetUseableItems(v23, 2 + 12);
	if (v109 and v37.AoELogic(v103, v104, v105)) then
		if v15(v109) then
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
local function v61(v111, v112)
	local v113 = nil;
	local v114 = math.huge;
	for v126, v127 in pairs(v111) do
		if v127:BuffUp(v112, nil, true) then
			local v140 = v127:HealthPercentageWeighted();
			if (v140 < v114) then
				v114 = v140;
				v113 = v127;
			end
		end
	end
	if v113 then
		return v113;
	else
		return nil;
	end
end
local function v62(v115)
	local v116 = v115:Name();
	for v128 = 1 + 0, 8 - 4 do
		local v129, v130, v131, v132 = GetTotemInfo(v128);
		if (v130 and v116 and strfind(v116, v130, 1 - 0, true)) then
			local v141 = math.floor(((v131 + v132) - GetTime()) + (0.5 - 0));
			if (v141 > (0 + 0)) then
				return v141;
			end
		end
	end
	return 0 + 0;
end
local function v63(v117)
	local v118 = 396 - (115 + 281);
	for v133, v134 in pairs(v117) do
		if not v134:IsDeadOrGhost() then
			v118 = v118 + (2 - 1);
		end
		return v118;
	end
end
local v64 = nil;
local v65 = nil;
local v66 = nil;
local v67 = nil;
local v68;
local v69, v70, v71, v72, v73, v74, v75, v76, v77, v78, v79, v80;
local v81;
local function v82()
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
	v28 = v7:IsInMeleeRange(1670 - (970 + 695));
	v29 = v7:IsInMeleeRange(19 - 9);
	if v13() then
		v25 = #v24;
		v27 = #v26;
	else
		v25 = 1991 - (582 + 1408);
		v27 = 3 - 2;
	end
	v69, v70 = v37.GetLowestHealthUnit(v22);
	v34 = (v70 and v70:HealthPercentage()) or (125 - 25);
	v71 = v69:HealthPercentageWeighted();
	v72 = v69:HealthPercentage();
	v73 = v37.GetLowestHealthUnitWithoutBuff(v22, v20.RenewingMistBuff) or v37.GetLowestHealthUnitWithoutBuff(v22, v20.ChiHarmonyBuff);
	v74 = v37.GetLowestHealthUnitWithBuffAndNoBuff(v22, v20.ChiHarmonyBuff, v20.EnvelopingMist) or v37.GetLowestHealthUnitWithoutBuff(v22, v20.EnvelopingMist);
	v75 = v61(v22, v20.SoothingMist);
	v80 = v61(v22, v20.ChiHarmonyBuff);
	v76 = v12.ToggleIconFrame:GetToggle(15 - 11);
	v77 = v12.ToggleIconFrame:GetToggle(1829 - (1195 + 629));
	v30 = v12.ToggleIconFrame:GetToggle(1 - 0);
	v78 = not v76 or (v20.Chiji:IsAvailable() and v20.Chiji:CooldownDown()) or (v20.Yulon:IsAvailable() and v20.Yulon:CooldownDown());
	v79 = v37.GetAverageGroupHealthPercent(v22);
end
local function v83()
	if ((v71 >= (276 - (187 + 54))) and (v43() or (v41(v7) and (v20.DetoxMW:CooldownDown() or not v20.ImprovedDetox:IsAvailable()))) and (v7:HealthPercentage() < (880 - (162 + 618)))) then
		if (v6:IsChanneling(v20.SoothingMist) and v7:BuffUp(v20.SoothingMist, nil, true) and (v6:CastRemains() > (v6:GCD() + 0.25 + 0)) and (v6:GCDRemains() < (0.2 + 0))) then
			if ((v7:BuffDown(v20.EnvelopingMist, nil, true) or (v7:BuffUp(v20.EnvelopingMist, nil, true) and (v7:BuffRemains(v20.EnvelopingMist, nil, true) < (1 - 0)))) and not v6:PrevGCD(1 - 0, v20.EnvelopingMist) and v20.EnvelopingMist:IsReady()) then
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
			if (not v6:IsChanneling(v20.SoothingMist) and v20.SoothingMist:IsReady() and not v6:PrevGCD(1637 - (1373 + 263), v20.SoothingMist)) then
				print("TEST");
				v46(v20.SoothingMist, nil, 1003 - (451 + 549));
				return "NPC SoothingMist";
			end
		end
	end
	if v6:BuffDown(v20.YulonBuff, nil, true) then
		v36 = true;
	end
	if v6:BuffUp(v20.YulonBuff, nil, true) then
		if (v37.BuffCount(v22, v20.EnvelopingMist) > (2 + 2)) then
			v36 = false;
		end
		if v20.SoothingMist:IsAvailable() then
			if (v6:IsChanneling(v20.SoothingMist) and (v6:CastRemains() > (v6:GCD() + (0.25 - 0))) and (v6:GCDRemains() < (0.2 - 0))) then
				if ((v74 ~= nil) and v36) then
					if (v20.EnvelopingMist:IsReady() and v74:BuffDown(v20.EnvelopingMist)) then
						v74:Cast(v20.EnvelopingMist, true);
						return "Yulong envmist stack " .. v74:Name();
					end
				end
				if ((v80 ~= nil) and v20.Vivify:IsReady() and (v80:HealthPercentageWeighted() < (1464 - (746 + 638)))) then
					v80:Cast(v20.Vivify, true);
					return "Vivify Cast on Chi Unit - Yulon Ramp";
				end
				if ((v74 ~= nil) and (v74:HealthPercentageWeighted() < (31 + 49))) then
					if (v20.EnvelopingMist:IsReady() and v74:BuffDown(v20.EnvelopingMist, nil, true)) then
						v74:Cast(v20.EnvelopingMist, true);
						return "Yulong envmist";
					end
				end
				if ((v80 ~= nil) and v20.Vivify:IsReady()) then
					v80:Cast(v20.Vivify, true);
					return "Vivify Cast on Chi Unit - Yulon Ramp";
				end
				if v20.Vivify:IsReady() then
					v69:Cast(v20.Vivify, true);
					return "Vivify Cast on UnitLowest - Yulon Ramp";
				end
				if (v74 ~= nil) then
					if (v20.EnvelopingMist:IsReady() and v74:BuffDown(v20.EnvelopingMist, nil, true)) then
						v74:Cast(v20.EnvelopingMist, true);
						return "Yulong envmist";
					end
				end
			end
			if (v20.RisingSunKick:IsReady() and v28 and (v6:IsInRaid() or (v72 < (121 - 41)))) then
				v15(v20.RisingSunKick);
				return "RisingSunKick raid Yulon";
			end
			if ((v80 ~= nil) and v20.SoothingMist:IsReady() and not v6:PrevGCD(342 - (218 + 123), v20.SoothingMist) and not v6:IsMoving()) then
				v80:Cast(v20.SoothingMist);
				return "Chi Harmony Soothing Mist Unit - Yulon Ramp";
			end
			if (v20.SoothingMist:IsReady() and not v6:PrevGCD(1582 - (1535 + 46), v20.SoothingMist) and not v6:IsMoving()) then
				v69:Cast(v20.SoothingMist);
				return "Lowest Soothing Mist Unit - Yulon Ramp";
			end
		end
		if not v20.SoothingMist:IsAvailable() then
			if not v36 then
				if ((v73 ~= nil) and not v20.AncientTeachingsTalent:IsAvailable() and v20.RenewingMist:IsReady() and (v20.RenewingMist:Charges() > (0 + 0))) then
					if (v20.ThunderFocusTea:IsReady() and v6:BuffDown(v20.ThunderFocusTea, nil, true)) then
						v15(v20.ThunderFocusTea);
						return "Renewing Mist Yulon TFT";
					end
					v73:Cast(v20.RenewingMist);
					return "Renewing Mist Yulon TFT";
				end
				if (v20.RenewingMist:IsReady() and (v73:HealthPercentageWeighted() <= v39.Healing.RenewingMistHP) and ((v20.RenewingMist:Charges() > (1 + 0)) or ((v20.RenewingMist:Charges() > (560 - (306 + 254))) and (v20.AncientTeachingsTalent:IsAvailable() or (v20.ThunderFocusTea:CooldownRemains() > (1 + 7)))))) then
					v73:Cast(v20.RenewingMist);
					return "Renewing Mist Yulon 1";
				end
				if ((v80 ~= nil) and v20.Vivify:IsReady() and (v80:HealthPercentageWeighted() < (157 - 77))) then
					v80:Cast(v20.Vivify, true);
					return "Vivify Cast on Chi Unit - Yulon Ramp";
				end
				if ((v74 ~= nil) and (v74:HealthPercentageWeighted() < (1547 - (899 + 568)))) then
					if (v20.EnvelopingMist:IsReady() and v74:BuffDown(v20.EnvelopingMist, nil, true)) then
						v74:Cast(v20.EnvelopingMist, true);
						return "Yulong envmist";
					end
				end
				if ((v80 ~= nil) and v20.Vivify:IsReady()) then
					v80:Cast(v20.Vivify, true);
					return "Vivify Cast on Chi Unit - Yulon Ramp";
				end
				if v20.Vivify:IsReady() then
					v69:Cast(v20.Vivify, true);
					return "Vivify Cast on UnitLowest - Yulon Ramp";
				end
				if (v74 ~= nil) then
					if (v20.EnvelopingMist:IsReady() and v74:BuffDown(v20.EnvelopingMist, nil, true)) then
						v74:Cast(v20.EnvelopingMist, true);
						return "Yulong envmist";
					end
				end
			end
			if (v20.RisingSunKick:IsReady() and v28 and (v6:IsInRaid() or (v72 < (53 + 27)))) then
				v15(v20.RisingSunKick);
				return "RisingSunKick raid Yulon";
			end
			if ((v74 ~= nil) and v36) then
				if (v20.EnvelopingMist:IsReady() and v74:BuffDown(v20.EnvelopingMist)) then
					v74:Cast(v20.EnvelopingMist, true);
					return "Yulong envmist stack " .. v74:Name();
				end
			end
		end
		return "YULON UP Nothing";
	end
	if (v20.CelestialConduit:IsReady() and v37.AoELogicWithCount(v39.AoE.CCHP, v39.AoE.CCCount, "With Logic", v22)) then
		v12.Cast(v20.CelestialConduit);
		return "Celestial Conduit";
	end
	if (v75 ~= nil) then
		if (v6:IsChanneling(v20.SoothingMist) and v75:BuffUp(v20.SoothingMist, nil, true) and (v6:GCDRemains() < (0.2 - 0)) and (v6:CastRemains() > (v6:GCD() + (603.25 - (268 + 335))))) then
			if (v75:BuffDown(v20.EnvelopingMist, nil, true) and v20.EnvelopingMist:IsReady()) then
				v75:Cast(v20.EnvelopingMist, true);
				return "Soothing Mist EnvelopingMist";
			end
			if not v20.PeerIntoPeace:IsAvailable() then
				local v142 = v37.GetLowestHealthUnitWithBuff(v22, v20.RenewingMistBuff);
				if (v75:BuffUp(v20.EnvelopingMist, nil, true) and v20.Vivify:IsReady() and ((v75:HealthPercentageWeighted() <= v39.Healing.VivVivifyHP) or (v142 and (v142:HealthPercentageWeighted() <= v39.Healing.VivVivifyHP)))) then
					v75:Cast(v20.Vivify, true);
					return "Soothing Mist Vivify";
				end
			elseif (v75:BuffUp(v20.EnvelopingMist, nil, true) and v20.Vivify:IsReady() and (v75:HealthPercentageWeighted() <= v39.Healing.VivVivifyHP)) then
				v75:Cast(v20.Vivify, true);
				return "Soothing Mist Vivify peer";
			end
		end
		if (v20.AncientTeachingsTalent:IsAvailable() and (v75:HealthPercentageWeighted() >= v39.Healing.VivVivifyHP) and v28) then
			v12.CastMacro(296 - (60 + 230), true);
			return "Break SoothingMist";
		end
	end
	if (v20.PeerIntoPeace:IsAvailable() and v6:IsChanneling(v20.SoothingMist) and (v6:CastRemains() > (v6:GCD() + (572.25 - (426 + 146)))) and v20.PeerIntoPeace:IsAvailable() and (v6:GCDRemains() < (0.2 + 0))) then
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
		if ((v64:HealthPercentageWeighted() > v39.Healing.LCHP) and (v64:HealthPercentageWeighted() > (1456 - (282 + 1174)))) then
			v64 = nil;
			v65 = nil;
		end
		if (v64 ~= nil) then
			if ((v64:HealthPercentageWeighted() <= v39.Healing.LCHP) and (v64:HealthPercentageWeighted() > (811 - (569 + 242)))) then
				if (v65 == nil) then
					v65 = GetTime();
					v66 = math.random(432 - 282, 46 + 754) / (2024 - (706 + 318));
				elseif (GetTime() >= (v65 + v66)) then
					v64:Cast(v20.LifeCocoon, true);
					return "LC";
				end
			end
		end
	elseif (v65 ~= nil) then
		v65 = nil;
	end
	if v6:IsChanneling(v20.SoothingMist) then
		return "Soothing Mist Casting";
	end
	if (v39.Commons.Enabled.Trinkets and v21.FyrakkTainedRageHeart:IsEquippedAndReady() and v14() and v13()) then
		if ((v25 >= (1255 - (721 + 530))) and v54(1291 - (945 + 326))) then
			if v15(v21.FyrakkTainedRageHeart, true) then
				return "FyrakkTainedRageHeart offense";
			end
		end
	end
	if ((v71 >= (87 - 52)) and v20.TigersLust:IsReady() and (v6:DebuffElapsed(v20.EntangledDebuff) > (3 + 0))) then
		v15(v20.TigersLust);
		return "Cast Tiger's Lust";
	end
	if (not v6:AffectingCombat() and v30) then
		if (v20.ManaTea:IsReady() and (v79 >= (745 - (271 + 429))) and (v71 > (56 + 4)) and (v6:ManaPercentage() <= (1570 - (1408 + 92))) and v39.Mistweaver.ManaTeaOOC and (v6:BuffStack(v20.ManaTeaBuff) >= (1096 - (461 + 625))) and not v6:IsChanneling(v20.ManaTea)) then
			v15(v20.ManaTea);
			return "Mana Tea OOC";
		end
		if (v73 ~= nil) then
			if (v20.RenewingMist:IsReady() and (v20.RenewingMist:Charges() > (1289 - (993 + 295))) and (v73:HealthPercentageWeighted() <= v39.Healing.RenewingMistOOC)) then
				v73:Cast(v20.RenewingMist);
				return "OOC RENEWINGMist";
			end
		end
	end
	if (v20.TouchofDeath:IsReady() and v37.TargetIsValid() and v28 and not v6:IsInRaid() and ((v7:Health() < v6:Health()) or (v20.ImpTouchofDeath:IsAvailable() and (v7:HealthPercentageWeighted() < (1 + 14))))) then
		v15(v20.TouchofDeath);
		return "Touch of Death";
	end
	if (v67 ~= nil) then
		if (not v6:AffectingCombat() and (GetTime() >= (v67 + (1186 - (418 + 753))))) then
			v35 = false;
		end
	end
	if (v20.SummonJadeSerpentStatue:CooldownRemains(true) > (2 + 3)) then
		v67 = GetTime();
		v35 = true;
	end
	if ((v30 or v6:AffectingCombat()) and not v35) then
		if v20.SummonJadeSerpentStatue:IsReady() then
			v15(v20.SummonJadeSerpentStatue);
			return "Summon Jade Serpent Statue";
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
	if (v20.ThunderFocusTea:IsReady() and not v20.AncientTeachingsTalent:IsAvailable() and not v76 and v6:AffectingCombat() and not ((v20.Yulon:IsAvailable() and (v20.Yulon:CooldownRemains() < (549 - (406 + 123)))) or (v20.Chiji:IsAvailable() and (v20.Chiji:CooldownRemains() < (1789 - (1749 + 20))))) and v6:BuffDown(v20.ThunderFocusTea, nil, true) and not v20.Upwelling:IsAvailable() and (v54(3 + 7) or v53) and v20.RenewingMist:IsReady() and (v20.RenewingMist:Charges() > (1322 - (1249 + 73)))) then
		v15(v20.ThunderFocusTea);
		return "Thunder Focus RenewingMist";
	end
	if (v70 and v20.ThunderFocusTea:IsReady() and v20.AncientTeachingsTalent:IsAvailable() and not v76 and v6:AffectingCombat() and ((v34 <= (18 + 32)) or ((v25 >= (1149 - (466 + 679))) and v70:BuffDown(v20.EnvelopingMist) and not v6:IsInRaid())) and v6:BuffDown(v20.ThunderFocusTea, nil, true) and v20.ZenPulse:IsReady()) then
		v15(v20.ThunderFocusTea);
		return "Thunder Focus ZenPulse";
	end
	if (v20.ThunderFocusTea:IsReady() and v20.AncientTeachingsTalent:IsAvailable() and not v76 and v6:AffectingCombat() and not v58() and (v71 < (192 - 112)) and not ((v20.Yulon:IsAvailable() and (v20.Yulon:CooldownRemains() < (57 - 37))) or (v20.Chiji:IsAvailable() and (v20.Chiji:CooldownRemains() < (1920 - (106 + 1794))))) and v6:BuffDown(v20.ThunderFocusTea, nil, true) and not v20.Upwelling:IsAvailable() and (v54(4 + 6) or v53) and v20.RisingSunKick:IsReady()) then
		v15(v20.ThunderFocusTea);
		return "Thunder Focus RisingSunKick";
	end
	if v6:BuffUp(v20.ThunderFocusTea, nil, true) then
		if (v70 and v6:AffectingCombat() and ((v34 <= (13 + 37)) or ((v25 >= (11 - 7)) and v70:BuffDown(v20.EnvelopingMist) and not v6:IsInRaid())) and v20.ZenPulse:IsReady()) then
			v70:Cast(v20.EnvelopingMist);
			return "Thunder Focus EnvelopingMist";
		end
		if (v6:AffectingCombat() and not v58() and v20.AncientTeachingsTalent:IsAvailable() and v20.RisingSunKick:IsReady()) then
			v15(v20.RisingSunKick);
			return "Thunder Focus RisingSunKick";
		end
		if v20.SecertInfusion:IsAvailable() then
			if (v73 ~= nil) then
				if (v20.RenewingMist:IsReady() and (v20.RenewingMist:Charges() > (0 - 0)) and (v73:HealthPercentageWeighted() <= (214 - (4 + 110))) and (v6:IsInRaid() or (not v6:IsInRaid() and (v37.BuffCount(v22, v20.RenewingMist) < (589 - (57 + 527)))))) then
					v73:Cast(v20.RenewingMist);
					return "Renewing Mist - Thunder Focus ";
				end
			end
			if (not v6:IsInRaid() and v20.EnvelopingMist:IsReady() and (v71 <= v39.Healing.EnvMistHP) and (v37.BuffCount(v22, v20.EnvelopingMist) < (1429 - (41 + 1386)))) then
				v69:Cast(v20.EnvelopingMist);
				return "Enveloping Mist Party - Thunder Focus /w Secert Infusion";
			end
		end
		if not v20.SecertInfusion:IsAvailable() then
			if (v74 ~= nil) then
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
				if (v20.RenewingMist:IsReady() and (v20.RenewingMist:Charges() > (103 - (17 + 86))) and (v73:HealthPercentageWeighted() <= (68 + 32)) and (v6:IsInRaid() or (not v6:IsInRaid() and (v37.BuffCount(v22, v20.RenewingMist) < (11 - 6))))) then
					v73:Cast(v20.RenewingMist);
					return "Renewing Mist Thudner Focus - No SecertInfusion";
				end
			end
		end
	end
	if (v20.FaelineStomp:IsReady() and v37.TargetIsValid() and not v40(v7) and (not v6:IsCameraBusy() or not v39.Cooldowns.FSCursorBusy) and v7:AffectingCombat() and (not v6:IsMoving() or v39.Cooldowns.FSMoving) and v29) then
		local v135;
		if (v58() or (v6:BuffDown(v20.AncientConcordance) and v20.AncientTeachingsTalent:IsAvailable()) or v37.AoELogicWithCount(v39.AoE.FSHP, v39.AoE.FSCount, "With Logic", v22)) then
			v135 = true;
		else
			v135 = false;
		end
		local v136 = (((v39.Cooldowns.UseFae == "With Logic") or ((v39.Cooldowns.UseFae == "With Cooldowns and Logic") and v14)) and v135) or ((v39.Cooldowns.UseFae == "With Cooldowns") and v14);
		if v136 then
			v15(v20.FaelineStomp);
			return "Faeline/Jadefire Stomp 1";
		end
	end
	if (v62(v20.Chiji) > (0 - 0)) then
		local v137 = v74 or v69;
		if (not v6:PrevGCD(167 - (122 + 44), v20.EnvelopingMist) and (v137:BuffDown(v20.EnvelopingMist, nil, true) or (v137:HealthPercentage() < (138 - 58))) and v20.EnvelopingMist:IsReady() and v6:BuffUp(v20.ChijiBuff, nil, true) and ((v6:BuffStack(v20.ChijiBuff) == (9 - 6)) or ((v6:BuffStack(v20.ChijiBuff) == (2 + 0)) and not v6:IsMoving() and (v137:HealthPercentageWeighted() < (12 + 68))))) then
			v137:Cast(v20.EnvelopingMist);
			return "Env  ";
		end
		if (v37.TargetIsValid() and v28 and not v40(v7) and v7:AffectingCombat()) then
			if (v20.BlackoutKick:IsReady() and v28 and ((v6:BuffStack(v20.TeachingsMons) > (5 - 2)) or not v20.TeachingsoftheMonasteryTalent:IsAvailable())) then
				v15(v20.BlackoutKick);
				return "Blkout TeachingsMons Chiji";
			end
			if (v20.RisingSunKick:IsReady() and v28 and (v6:IsInRaid() or (v72 < (145 - (30 + 35))))) then
				v15(v20.RisingSunKick);
				return "RisingSunKick raid Chiji";
			end
			if (v20.EyeoftheTiger:IsAvailable() and (v37.DebuffCount(v26, v20.EyeOfTheTigerBuff) == (0 + 0)) and v20.TigerPalm:IsReady() and v28) then
				v15(v20.TigerPalm);
				return "TP EyeoftheTiger ";
			end
			if (v13() and v20.SpinningCraneKick:IsReady() and ((v25 >= (1261 - (1043 + 214))) or v6:BuffUp(v20.DanceOfChijiMW)) and not v6:IsInRaid() and v6:BuffUp(v20.AwkakenedFaeline)) then
				v15(v20.SpinningCraneKick);
				return "SpinningCraneKick Chiji";
			end
			if (v20.BlackoutKick:IsReady() and v28 and v6:BuffUp(v20.AncientConcordance) and (v25 >= (7 - 5))) then
				v15(v20.BlackoutKick);
				return "Blkout AncientConcordance AOE Chiji";
			end
			if (v20.RisingSunKick:IsReady() and v28) then
				v15(v20.RisingSunKick);
				return "RisingSunKick Chiji";
			end
			if (v20.TigerPalm:IsReady() and v28 and v6:BuffUp(v20.AwkakenedFaeline) and (v6:BuffStack(v20.TeachingsMons) <= (1215 - (323 + 889))) and v20.TeachingsoftheMonasteryTalent:IsAvailable()) then
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
		local v138 = (v20.TeachingsoftheMonasteryTalent:IsAvailable() and v6:BuffUp(v20.TeachingsMons, nil, true) and (v6:BuffStack(v20.TeachingsMons) >= (583 - (361 + 219)))) or not v20.TeachingsoftheMonasteryTalent:IsAvailable();
		local v139 = (v20.Chiji:IsReady() and v138) or v20.Yulon:IsReady();
		if not v6:IsChanneling() then
			if (not v20.Yulon:IsAvailable() and v20.TeachingsoftheMonasteryTalent:IsAvailable() and (v6:BuffStack(v20.TeachingsMons) < (323 - (53 + 267))) and v28 and v37.TargetIsValid()) then
				v15(v20.TigerPalm);
				return "Tiger Palm Ramp";
			end
			if (v20.ShaohaosLessionTalent:IsAvailable() and v138) then
				if (v20.SheilunsGift:IsReady() and not v6:IsMoving() and (v20.SheilunsGift:Count() >= (1 + 3)) and v139) then
					v69:Cast(v20.SheilunsGift);
					return "SG Ramp";
				end
			end
			if ((v73 ~= nil) and not v20.AncientTeachingsTalent:IsAvailable() and v20.RenewingMist:IsReady() and (v20.RenewingMist:Charges() > (413 - (15 + 398)))) then
				if (v20.ThunderFocusTea:IsReady() and v6:BuffDown(v20.ThunderFocusTea, nil, true)) then
					v15(v20.ThunderFocusTea);
					return "Renewing Mist Ramp";
				end
				v73:Cast(v20.RenewingMist);
				return "Renewing Mist Ramp";
			end
		end
		if (v20.Yulon:IsReady() and (not v20.ShaohaosLessionTalent:IsAvailable() or (v20.SheilunsGift:Count() < (989 - (18 + 964))))) then
			v46(v20.Yulon);
			return "yulon Ramp";
		end
		if (v138 and v28 and v20.Chiji:IsReady() and (not v20.ShaohaosLessionTalent:IsAvailable() or (v20.SheilunsGift:Count() < (14 - 10)))) then
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
	if (v20.RefreshingJadeWind:IsReady() and v37.TargetIsValid() and v28 and v37.AoELogicWithCount(v39.AoE.RJWHP, v39.AoE.RJWCount, v39.Cooldowns.UseRJW, v22)) then
		v15(v20.RefreshingJadeWind);
		return "RJW";
	end
	if (v6:BuffUp(v20.EscapeFromReality, nil, true) and not v6:IsMoving() and v37.AoELogic(v39.Cooldowns.EscapeHP, "With Logic", v22) and not v6:PrevGCD(1 + 0, v20.SoothingMist)) then
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
		if (v20.SoothingMist:IsReady() and not v6:PrevGCD(1 + 0, v20.SoothingMist) and (not v28 or (v20.AncientTeachingsTalent:IsAvailable() and v6:BuffDown(v20.AncientTeachings))) and (v71 <= v39.Soothing.SoothingMistAtRange) and not v6:IsMoving()) then
			if (v20.RenewingMist:IsReady() and (v20.RenewingMist:Charges() > (850 - (20 + 830))) and v47(v69)) then
				v69:Cast(v20.RenewingMist);
				return "SoothingMist RenewingMist 4P";
			end
			if v6:IsInRaid() then
				v46(v20.SoothingMist, v69, 3 + 0);
			else
				v69:Cast(v20.SoothingMist);
			end
			return "Soothing on Lowest Unit Weighted";
		end
		if (v74 ~= nil) then
			if (v6:BuffDown(v20.YulonBuff) and v20.EnvelopingMist:IsReady() and not v6:IsMoving() and not v6:PrevGCD(127 - (116 + 10), v20.EnvelopingMist) and (v74:HealthPercentageWeighted() <= v39.Healing.EnvMistHP)) then
				v74:Cast(v20.EnvelopingMist);
				return "EnV Unit";
			end
		end
		if (v20.SoothingMist:IsReady() and not v6:PrevGCD(1 + 0, v20.SoothingMist) and (v71 <= v39.Soothing.SoothingMistHP) and not v6:IsMoving()) then
			if (v20.RenewingMist:IsReady() and (v20.RenewingMist:Charges() > (738 - (542 + 196))) and v47(v69)) then
				v69:Cast(v20.RenewingMist);
				return "SoothingMist RenewingMist 4P";
			end
			if v6:IsInRaid() then
				v46(v20.SoothingMist, v69, 6 - 3);
			else
				v69:Cast(v20.SoothingMist);
			end
			return "Soothing on Weighted Unit 2";
		end
		if (v20.Vivify:IsReady() and not v6:PrevGCD(1 + 0, v20.Vivify) and not v6:IsMoving() and v49(v69, v72, v39.Healing.VivifyHP)) then
			v69:Cast(v20.Vivify);
			return "Vifify 2";
		end
	end
	if (v20.Vivify:IsReady() and v6:BuffDown(v20.ThunderFocusTea, nil, true) and not v6:PrevGCD(1 + 0, v20.Vivify) and v6:BuffUp(v20.VivaciousVivification, nil, true) and v49(v69, v72, v39.Healing.VivVivifyHP)) then
		v69:Cast(v20.Vivify);
		return "Vifify";
	end
	if (v33 and v6:BuffDown(v20.YulonBuff, nil, true) and (v62(v20.Chiji) == (0 + 0))) then
		if (v73 ~= nil) then
			if (v20.RenewingMist:IsReady() and (v73:HealthPercentageWeighted() <= v39.Healing.RenewingMistHP) and ((v20.RenewingMist:Charges() > (2 - 1)) or ((v20.RenewingMist:Charges() > (0 - 0)) and (v20.AncientTeachingsTalent:IsAvailable() or (v20.ThunderFocusTea:CooldownRemains() > (1559 - (1126 + 425))))))) then
				v73:Cast(v20.RenewingMist);
				return "Renewing Mist Non-Ramp 1";
			end
		end
	end
	if (v20.ZenPulse:IsReady() and v70) then
		if ((v34 <= (455 - (118 + 287))) or ((v25 >= (7 - 5)) and (v34 <= (1211 - (118 + 1003))) and v70:BuffUp(v20.EnvelopingMist))) then
			v70:Cast(v20.ZenPulse);
			return "Zen Pulse on Tank";
		end
	end
	if v33 then
		if (v20.Vivify:IsReady() and not v6:PrevGCD(2 - 1, v20.Vivify) and not v6:IsMoving() and v49(v69, v72, v39.Healing.VivifyHP)) then
			v69:Cast(v20.Vivify);
			return "Vifify 2";
		end
	end
	if v20.RisingSunKick:CooldownDown() then
		if (v6:BuffUp(v20.StrengthOfTheBlackOx, nil, true) and not v6:PrevGCD(378 - (142 + 235), v20.EnvelopingMist) and v20.EnvelopingMist:IsReady()) then
			if (v70 and v6:AffectingCombat() and not v6:IsMoving() and v70:BuffDown(v20.EnvelopingMist)) then
				v70:Cast(v20.EnvelopingMist);
				return "Strength Ox EnvelopingMist";
			end
		end
		if (v74 ~= nil) then
			if (v6:BuffUp(v20.StrengthOfTheBlackOx, nil, true) and not v6:PrevGCD(4 - 3, v20.EnvelopingMist) and v20.EnvelopingMist:IsReady()) then
				if (v6:AffectingCombat() and not v6:IsMoving()) then
					v74:Cast(v20.EnvelopingMist);
					return "Strength Ox EnvelopingMist";
				end
			end
		end
	end
	if (v78 and v6:BuffDown(v20.YulonBuff, nil, true) and v37.TargetIsValid() and not v40(v7) and v7:AffectingCombat()) then
		if (v20.RisingSunKick:IsReady() and v28 and (v6:IsInRaid() or (v72 < (18 + 62)))) then
			v15(v20.RisingSunKick);
			return "RisingSunKick raid";
		end
		if (v20.EyeoftheTiger:IsAvailable() and (v37.DebuffCount(v26, v20.EyeOfTheTigerBuff) == (977 - (553 + 424))) and v20.TigerPalm:IsReady() and v28) then
			v15(v20.TigerPalm);
			return "TP EyeoftheTiger ";
		end
		if (v14() and v13() and v20.SummonWhiteTigerStatue:IsReady() and (v25 >= (7 - 3)) and v54(27 + 3) and (not v6:IsCameraBusy() or not v39.Cooldowns.FSCursorBusy) and not v6:IsMoving()) then
			if v12.CastTarget(v20.SummonWhiteTigerStatue, v12.TName().PLAYER) then
				return "WhiterTigerStatue";
			end
		end
		if (v13() and v20.SpinningCraneKick:IsReady() and ((v25 >= (4 + 0)) or v6:BuffUp(v20.DanceOfChijiMW)) and not v6:IsInRaid() and (v6:BuffUp(v20.AwkakenedFaeline) or v6:BuffDown(v20.AncientTeachings))) then
			v15(v20.SpinningCraneKick);
			return "SpinningCraneKick 1";
		end
		if (v20.BlackoutKick:IsReady() and v28 and ((v6:BuffStack(v20.TeachingsMons) > (2 + 1)) or not v20.TeachingsoftheMonasteryTalent:IsAvailable())) then
			v15(v20.BlackoutKick);
			return "Blkout TeachingsMons";
		end
		if (v20.BlackoutKick:IsReady() and v28 and v6:BuffUp(v20.AncientConcordance) and (v25 >= (1 + 1))) then
			v15(v20.BlackoutKick);
			return "Blkout AncientConcordance AOE";
		end
		if (v20.TigerPalm:IsReady() and v28 and v6:BuffUp(v20.AwkakenedFaeline) and (v6:BuffStack(v20.TeachingsMons) <= (2 + 1)) and v20.TeachingsoftheMonasteryTalent:IsAvailable()) then
			v15(v20.TigerPalm);
			return "TP TeachingsMons ";
		end
		if (v20.RisingSunKick:IsReady() and v28) then
			v15(v20.RisingSunKick);
			return "RisingSunKick1";
		end
		if (v20.BlackoutKick:IsReady() and v28) then
			v15(v20.BlackoutKick);
			return "BlackoutKick basic";
		end
		if v39.Commons.Enabled.Items then
			if (v21.Iridal:IsEquippedAndReady() and v37.TargetIsValid()) then
				if not v6:IsMoving() then
					v12.CastMacro(2 - 1, nil, nil, v21.Iridal);
					return "weapon cast Iridal";
				end
			else
				local v143, v144, v145 = v6:GetUseableItems(v23, 44 - 28);
				if (v143 and v143:IsReady() and v7:IsInRange(v145) and v37.TargetIsValid()) then
					v12.CastMacro(2 - 1);
					return "weapon cast";
				end
			end
		end
		if (v20.TigerPalm:IsReady() and v28) then
			v15(v20.TigerPalm);
			return "TP DPS";
		end
	end
	if (v20.ChiBurst:IsReady() and not v6:IsMoving() and v6:BuffUp(v20.AwkakenedFaeline) and (v27 > (1 + 2)) and not v28 and v7:AffectingCombat() and v20.FaelineStomp:CooldownDown()) then
		v15(v20.ChiBurst);
		return "ChiBurst";
	end
end
local function v84()
	if v37.ShouldStopCastUpdate() then
		v12.CastMacro(28 - 22, true);
		return "Stop Cast For Silence";
	end
	if (not v6:IsMounted() and (v37.TargetIsValid() or v6:AffectingCombat() or v30)) then
		if not v6:AffectingCombat() then
			v81 = v60();
			if v81 then
				return v81;
			end
		end
		if (v31 and not v6:IsInRaid() and v20.DetoxMW:IsReady() and v20.ImprovedDetox:IsAvailable() and not v6:IsChanneling(v20.SoothingMist)) then
			v81 = v37.AfflictedLogic(v20.DetoxMW, true);
			if v81 then
				return v81;
			end
		end
		if v6:AffectingCombat() then
			if v32 then
				if v20.SpearHandStrike:IsReady() then
					v81 = v37.InterruptCycle(v20.SpearHandStrike, 758 - (239 + 514), true, nil, false);
					if v81 then
						return v81;
					end
				end
				if v20.LegSweep:IsReady() then
					v81 = v37.InterruptCycle(v20.LegSweep, 3 + 5, true, nil, true, true);
					if v81 then
						return v81;
					end
				end
				if v39.Mistweaver.LegSweepInt then
					if (v20.SpearHandStrike:CooldownDown() and v20.LegSweep:IsReady()) then
						v81 = v37.InterruptCycle(v20.LegSweep, 1337 - (797 + 532), true, nil, false, true);
						if v81 then
							return v81;
						end
					end
				end
				if v39.Mistweaver.ParaInt then
					if v20.Paralysis:IsReady() then
						v81 = v37.InterruptCycle(v20.Paralysis, 15 + 5, true, nil, true);
						if v81 then
							return v81;
						end
						if v20.SpearHandStrike:CooldownDown() then
							v81 = v37.InterruptCycle(v20.Paralysis, 7 + 13, true, nil, false);
							if v81 then
								return v81;
							end
						end
					end
				end
			end
			if v20.Paralysis:IsReady() then
				v81 = v37.IncorpCycle(v20.Paralysis, 47 - 27, true, false);
				if v81 then
					return v81;
				end
			end
			if (v31 and not v6:IsInRaid() and v20.DetoxMW:IsReady() and not v6:IsChanneling(v20.SoothingMist)) then
				v81 = v37.DispelCycle(v20.DetoxMW, "Magic", true, v22);
				if v81 then
					return v81;
				end
				if v20.ImprovedDetox:IsAvailable() then
					v81 = v37.DispelCycle(v20.DetoxMW, "Disease", true, v22);
					if v81 then
						return v81;
					end
					v81 = v37.DispelCycle(v20.DetoxMW, "Poison", true, v22);
					if v81 then
						return v81;
					end
				end
				if v20.TigersLust:IsReady() then
					v81 = v37.DispelCycle(v20.TigersLust, "RootDispel", true);
					if v81 then
						return v81;
					end
					v81 = v37.DispelCycle(v20.TigersLust, "SnareRoot", true);
					if v81 then
						return v81;
					end
				end
			end
			if (v31 and v6:IsInRaid() and v20.DetoxMW:IsReady()) then
				v81 = v37.DispelCycle(v20.DetoxMW, "Raid", true, v22);
				if v81 then
					return v81;
				end
			end
		end
		if (v39.Mistweaver.AutoTabMelee and (v68 > (1202 - (373 + 829))) and not v28 and v6:CanAttack(v7)) then
			v12.TopPanelAlternative:ChangeIcon(732 - (476 + 255), 1133 - (369 + 761));
			return "Auto tab to melee";
		end
		if v6:IsChanneling(v20.ManaTea) then
			if ((((v71 < (47 + 33)) or (v6:ManaPercentage() >= (163 - 73)) or (v6:BuffUp(v20.YulonBuff, nil, true) and (v62(v20.Chiji) > (0 - 0)))) and (v44(v20.ManaTea) > (v45 or (239 - (64 + 174))))) or (v44(v20.ManaTea) > (1 + 4))) then
				v12.CastMacro(8 - 2, true);
				return "Break Mana tea";
			end
		end
		v81 = v59();
		if v81 then
			return v81;
		end
		v81 = v57(v39.Cooldowns.Trinket1HP, v39.Cooldowns.Trinket1Use, v39.Cooldowns.Trinket2HP, v39.Cooldowns.Trinket2Use, v22);
		if v81 then
			return v81;
		end
		v81 = v83();
		if v81 then
			return v81;
		end
		if ((v71 > (426 - (144 + 192))) and (v6:ManaPercentage() <= v39.Mistweaver.ManaTeaMP) and (v6:BuffStack(v20.ManaTeaBuff) >= v39.Mistweaver.ManaTeaStack) and not v6:IsChanneling(v20.ManaTea)) then
			v15(v20.ManaTea);
			return "Mana Tea - Settings Met for Mana";
		end
	end
end
local function v85()
	v12.ResetToggle();
	v39.Mistweaver.Display();
	v12:UpdateMacro("macro1", "/use 16");
	v12:UpdateMacro("macro6", "/stopcasting");
	v12.ToggleIconFrame:AddButtonCustom("O", 217 - (42 + 174), "OOC", "ooc");
	v12.ToggleIconFrame:AddButtonCustom("D", 2 + 0, "Dispel", "dispel");
	v12.ToggleIconFrame:AddButtonCustom("K", 3 + 0, "Kick", "kick");
	v12.ToggleIconFrame:AddButtonCustom("R", 2 + 2, "Ramp", "ramp");
	v12.ToggleIconFrame:AddButtonCustom("T", 1509 - (363 + 1141), "Transcendence", "transcendence");
	v12.ToggleIconFrame:AddButtonCustom("H", 1586 - (1183 + 397), "Heal", "heal");
	v12.Print("Mistweaver Monk rotation updated to 10.20.5.");
end
v12.SetAPL(821 - 551, v84, v85, v82);
