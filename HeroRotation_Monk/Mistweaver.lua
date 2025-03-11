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
	for v863, v864 in ipairs(v103) do
		if v50[v864:CastSpellID() or v864:ChannelSpellID()] then
			return true;
		end
	end
end
local function v56()
	local v104 = v6:GetEnemiesInRange(18 + 22);
	for v865, v866 in ipairs(v104) do
		if v51[v866:CastSpellID() or v866:ChannelSpellID()] then
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
	for v867, v868 in pairs(v115) do
		if v868:BuffUp(v116, nil, true) then
			local v887 = v868:HealthPercentageWeighted();
			if (v887 < v118) then
				v118 = v887;
				v117 = v868;
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
	for v869 = 1 + 0, 8 - 4 do
		local v870, v871, v872, v873 = GetTotemInfo(v869);
		if (v871 and v120 and strfind(v120, v871, 1 - 0, true)) then
			local v888 = math.floor(((v872 + v873) - GetTime()) + (0.5 - 0));
			if (v888 > (0 + 0)) then
				return v888;
			end
		end
	end
	return 0 + 0;
end
local function v63(v121)
	local v122 = 396 - (115 + 281);
	for v874, v875 in pairs(v121) do
		if not v875:IsDeadOrGhost() then
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
local v82;
local v83, v84;
local function v85()
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
	v76 = v12.ToggleIconFrame:GetToggle(289 - (134 + 151));
	v77 = v12.ToggleIconFrame:GetToggle(1670 - (970 + 695));
	v33 = v12.ToggleIconFrame:GetToggle(11 - 5);
	v81 = v12.ToggleIconFrame:GetToggle(1997 - (582 + 1408));
	v28 = v7:IsInMeleeRange(17 - 12);
	v83 = v7:IsInRange(25 - 5);
	v84 = v7:IsInRange(150 - 110);
	v29 = v7:IsInMeleeRange(1834 - (1195 + 629));
	if v13() then
		v25 = #v24;
		v27 = #v26;
	else
		v25 = 1 - 0;
		v27 = 242 - (187 + 54);
	end
	v69, v70 = v37.GetLowestHealthUnit(v22);
	v34 = (v70 and v70:HealthPercentage()) or (880 - (162 + 618));
	v71 = v69:HealthPercentageWeighted();
	v72 = v69:HealthPercentage();
	v73 = v37.GetLowestHealthUnitWithoutBuff(v22, v20.RenewingMistBuff) or v37.GetLowestHealthUnitWithoutBuff(v22, v20.ChiHarmonyBuff);
	v74 = v37.GetLowestHealthUnitWithBuffAndNoBuff(v22, v20.ChiHarmonyBuff, v20.EnvelopingMist) or v37.GetLowestHealthUnitWithoutBuff(v22, v20.EnvelopingMist);
	v75 = v61(v22, v20.SoothingMist);
	v80 = v61(v22, v20.ChiHarmonyBuff);
	v78 = not v76 or (v20.Chiji:IsAvailable() and v20.Chiji:CooldownDown()) or (v20.Yulon:IsAvailable() and v20.Yulon:CooldownDown());
	v79 = v37.GetAverageGroupHealthPercent(v22);
end
local function v86()
	if ((v71 >= (25 + 10)) and (v43() or (v41(v7) and (v20.DetoxMW:CooldownDown() or not v20.ImprovedDetox:IsAvailable()))) and (v7:HealthPercentage() < (67 + 33))) then
		if (v6:IsChanneling(v20.SoothingMist) and v7:BuffUp(v20.SoothingMist, nil, true) and (v6:CastRemains() > (v6:GCD() + (0.25 - 0))) and (v6:GCDRemains() < (0.2 - 0))) then
			if ((v7:BuffDown(v20.EnvelopingMist, nil, true) or (v7:BuffUp(v20.EnvelopingMist, nil, true) and (v7:BuffRemains(v20.EnvelopingMist, nil, true) < (1 + 0)))) and not v6:PrevGCD(1637 - (1373 + 263), v20.EnvelopingMist) and v20.EnvelopingMist:IsReady()) then
				v15(v20.EnvelopingMist, true);
				return "NPC EnvelopingMist";
			end
			if (v7:BuffUp(v20.EnvelopingMist, nil, true) and v20.Vivify:IsReady()) then
				v15(v20.Vivify, true);
				return "NPC Vivify";
			end
		else
			if (v20.RenewingMist:IsReady() and (v20.RenewingMist:Charges() > (1000 - (451 + 549))) and v47(v7)) then
				v15(v20.RenewingMist);
				return "NPC RenewingMist";
			end
			if (not v6:IsChanneling(v20.SoothingMist) and v20.SoothingMist:IsReady() and not v6:PrevGCD(1 + 0, v20.SoothingMist)) then
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
		if (v37.BuffCount(v22, v20.EnvelopingMist) > (6 - 2)) then
			v36 = false;
		end
		if not v36 then
			if ((v73 ~= nil) and not v20.AncientTeachingsTalent:IsAvailable() and v20.RenewingMist:IsReady() and (v20.RenewingMist:Charges() > (1384 - (746 + 638)))) then
				if (v20.ThunderFocusTea:IsReady() and v6:BuffDown(v20.ThunderFocusTea, nil, true)) then
					v15(v20.ThunderFocusTea);
					return "Renewing Mist Yulon TFT";
				end
				v73:Cast(v20.RenewingMist);
				return "Renewing Mist Yulon TFT";
			end
			if (v20.RenewingMist:IsReady() and (v73:HealthPercentageWeighted() <= v39.Healing.RenewingMistHP) and ((v20.RenewingMist:Charges() > (1 + 0)) or ((v20.RenewingMist:Charges() > (0 - 0)) and (v20.AncientTeachingsTalent:IsAvailable() or (v20.ThunderFocusTea:CooldownRemains() > (349 - (218 + 123))))))) then
				v73:Cast(v20.RenewingMist);
				return "Renewing Mist Yulon 1";
			end
			if ((v80 ~= nil) and v20.Vivify:IsReady() and (v80:HealthPercentageWeighted() < (1661 - (1535 + 46)))) then
				v80:Cast(v20.Vivify, true);
				return "Vivify Cast on Chi Unit - Yulon Ramp";
			end
			if ((v74 ~= nil) and (v74:HealthPercentageWeighted() < (80 + 0))) then
				if (v20.EnvelopingMist:IsReady() and v74:BuffDown(v20.EnvelopingMist, nil, true)) then
					v74:Cast(v20.EnvelopingMist, true);
					return "Yulong envmist High Prirotiy";
				end
			end
			if (v80 ~= nil) then
				if (v20.EnvelopingMist:IsReady() and v74:BuffDown(v20.EnvelopingMist, nil, true)) then
					v80:Cast(v20.Vivify, true);
					return "Yulong envmist";
				end
			end
			if (v20.ThunderFocusTea:IsReady() and v20.AncientTeachingsTalent:IsAvailable() and v6:AffectingCombat() and not v58() and (v71 < (12 + 68)) and v6:BuffDown(v20.ThunderFocusTea, nil, true) and not v20.Upwelling:IsAvailable() and (v54(570 - (306 + 254)) or v53) and v20.RisingSunKick:IsReady()) then
				v15(v20.ThunderFocusTea, true);
				return "Thunder Focus Yulon RisingSunKick";
			end
			if (v20.RisingSunKick:IsReady() and v28 and (v6:IsInRaid() or (v72 < (5 + 75)))) then
				v15(v20.RisingSunKick);
				return "RisingSunKick raid Yulon";
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
					v74:Cast(v20.EnvelopingMist);
					return "Yulong envmist stack " .. v74:Name();
				end
			end
		end
	end
	if (v20.CelestialConduit:IsReady() and v37.AoELogicWithCount(v39.AoE.CCHP, v39.AoE.CCCount, "With Logic", v22)) then
		v12.Cast(v20.CelestialConduit);
		return "Celestial Conduit";
	end
	if (v75 ~= nil) then
		if (v6:IsChanneling(v20.SoothingMist) and v75:BuffUp(v20.SoothingMist, nil, true) and (v6:GCDRemains() < (0.2 - 0)) and (v6:CastRemains() > (v6:GCD() + (1467.25 - (899 + 568))))) then
			if (v75:BuffDown(v20.EnvelopingMist, nil, true) and v20.EnvelopingMist:IsReady()) then
				v75:Cast(v20.EnvelopingMist, true);
				return "Soothing Mist EnvelopingMist";
			end
			if not v20.PeerIntoPeace:IsAvailable() then
				local v889 = v37.GetLowestHealthUnitWithBuff(v22, v20.RenewingMistBuff);
				if (v75:BuffUp(v20.EnvelopingMist, nil, true) and v20.Vivify:IsReady() and ((v75:HealthPercentageWeighted() <= v39.Healing.VivVivifyHP) or (v889 and (v889:HealthPercentageWeighted() <= v39.Healing.VivVivifyHP)))) then
					v75:Cast(v20.Vivify, true);
					return "Soothing Mist Vivify";
				end
			elseif (v75:BuffUp(v20.EnvelopingMist, nil, true) and v20.Vivify:IsReady() and (v75:HealthPercentageWeighted() <= v39.Healing.VivVivifyHP)) then
				v75:Cast(v20.Vivify, true);
				return "Soothing Mist Vivify peer";
			end
		end
		if (v20.AncientTeachingsTalent:IsAvailable() and (v75:HealthPercentageWeighted() >= v39.Healing.VivVivifyHP) and v28) then
			v12.CastMacro(4 + 2, true);
			return "Break SoothingMist";
		end
	end
	if (v20.PeerIntoPeace:IsAvailable() and v6:IsChanneling(v20.SoothingMist) and (v6:CastRemains() > (v6:GCD() + (0.25 - 0))) and v20.PeerIntoPeace:IsAvailable() and (v6:GCDRemains() < (603.2 - (268 + 335)))) then
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
		if ((v64:HealthPercentageWeighted() > v39.Healing.LCHP) and (v64:HealthPercentageWeighted() > (290 - (60 + 230)))) then
			v64 = nil;
			v65 = nil;
		end
		if (v64 ~= nil) then
			if ((v64:HealthPercentageWeighted() <= v39.Healing.LCHP) and (v64:HealthPercentageWeighted() > (572 - (426 + 146)))) then
				if (v65 == nil) then
					v65 = GetTime();
					v66 = math.random(18 + 132, 2256 - (282 + 1174)) / (1811 - (569 + 242));
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
		if ((v25 >= (11 - 7)) and v54(2 + 18)) then
			if v15(v21.FyrakkTainedRageHeart, true) then
				return "FyrakkTainedRageHeart offense";
			end
		end
	end
	if ((v71 >= (1059 - (706 + 318))) and v20.TigersLust:IsReady() and (v6:DebuffElapsed(v20.EntangledDebuff) > (1254 - (721 + 530)))) then
		v15(v20.TigersLust);
		return "Cast Tiger's Lust";
	end
	if (not v6:AffectingCombat() and v30) then
		if (v20.ManaTea:IsReady() and (v79 >= (1316 - (945 + 326))) and (v71 > (149 - 89)) and (v6:ManaPercentage() <= (63 + 7)) and v39.Mistweaver.ManaTeaOOC and (v6:BuffStack(v20.ManaTeaBuff) >= (710 - (271 + 429))) and not v6:IsChanneling(v20.ManaTea)) then
			v15(v20.ManaTea);
			return "Mana Tea OOC";
		end
		if (v73 ~= nil) then
			if (v20.RenewingMist:IsReady() and (v20.RenewingMist:Charges() > (1 + 0)) and (v73:HealthPercentageWeighted() <= v39.Healing.RenewingMistOOC)) then
				v73:Cast(v20.RenewingMist);
				return "OOC RENEWINGMist";
			end
		end
	end
	if v81 then
		if (v20.TouchofDeath:IsReady() and v37.TargetIsValid() and v28 and not v6:IsInRaid() and ((v7:Health() < v6:Health()) or (v20.ImpTouchofDeath:IsAvailable() and (v7:HealthPercentageWeighted() < (1515 - (1408 + 92)))))) then
			v15(v20.TouchofDeath);
			return "Touch of Death";
		end
	end
	if (v67 ~= nil) then
		if (not v6:AffectingCombat() and (GetTime() >= (v67 + (1101 - (461 + 625))))) then
			v35 = false;
		end
	end
	if (v20.SummonJadeSerpentStatue:CooldownRemains(true) > (1293 - (993 + 295))) then
		v67 = GetTime();
		v35 = true;
	end
	if ((v30 or v6:AffectingCombat()) and not v35) then
		if v20.SummonJadeSerpentStatue:IsReady() then
			v15(v20.SummonJadeSerpentStatue);
			return "Summon Jade Serpent Statue";
		end
	end
	if (v6:BuffDown(v20.ThunderFocusTea) and not v6:PrevGCD(1 + 0, v20.CracklingJadeLightning) and v20.ThunderFocusTea:IsReady() and v20.JadeEmpowerment:IsAvailable() and not (v56() or v55())) then
		v15(v20.ThunderFocusTea, true);
		v15(v20.CracklingJadeLightning);
		return "Thunder Focus Tea for Jade Empower into Crackling - Proactive AoE";
	end
	if (v6:BuffUp(v20.ThunderFocusTea) and v84 and v37.TargetIsValid() and not v6:PrevGCD(1172 - (418 + 753), v20.CracklingJadeLightning)) then
		if v20.CracklingJadeLightning:IsReady() then
			v15(v20.CracklingJadeLightning);
			return "Crackling Jade While Empowerment Up";
		end
	end
	if (v20.AncientTeachingsTalent:IsAvailable() and v20.ManaTea:IsReady() and (v79 >= (18 + 27)) and (v71 > (7 + 53)) and (v6:ManaPercentage() <= v39.Mistweaver.ManaTeaMP) and (v6:BuffStack(v20.ManaTeaBuff) >= v39.Mistweaver.ManaTeaStack) and not v6:BuffUp(v20.YulonBuff, nil, true) and not (v62(v20.Chiji) > (0 + 0)) and not v6:IsChanneling(v20.ManaTea)) then
		v15(v20.ManaTea);
		return "Mana Tea - AT Group Above 45 and Lowest Above 60 - Settings Met for Mana";
	end
	if (v20.SheilunsGift:IsReady() and not v6:IsMoving() and (v20.SheilunsGift:Count() > v39.Cooldowns.SGStack) and v37.AoELogicWithCount(v39.AoE.SGHP, v39.AoE.SGCount, v39.Cooldowns.UseSG, v22) and v78) then
		v69:Cast(v20.SheilunsGift);
		return "SG Outside of Ramp";
	end
	if ((v20.ThunderFocusTea:IsReady() and not v20.AncientTeachingsTalent:IsAvailable()) or (v6:IsInRaid() and not v76 and v6:AffectingCombat() and v6:BuffDown(v20.ThunderFocusTea, nil, true) and v6:BuffDown(v20.ThunderFocusTea, nil, true) and (v54(3 + 7) or v53) and v20.RenewingMist:IsReady() and (v20.RenewingMist:Charges() > (529 - (406 + 123))))) then
		v15(v20.ThunderFocusTea);
		return "Thunder Focus RenewingMist";
	end
	if (v20.ThunderFocusTea:IsReady() and v20.AncientTeachingsTalent:IsAvailable() and not v76 and v6:AffectingCombat() and not v58() and (v71 < (1864 - (1749 + 20))) and v6:BuffDown(v20.ThunderFocusTea, nil, true) and (v54(3 + 7) or v53) and v20.RisingSunKick:IsReady()) then
		v15(v20.ThunderFocusTea, true);
		v15(v20.RisingSunKick);
		return "Thunder Focus RisingSunKick";
	end
	if v6:BuffUp(v20.ThunderFocusTea, nil, true) then
		if (v70 and v6:AffectingCombat() and ((v34 <= (1372 - (1249 + 73))) or ((v25 >= (2 + 2)) and v70:BuffDown(v20.EnvelopingMist) and not v6:IsInRaid())) and v20.ZenPulse:IsReady()) then
			v70:Cast(v20.EnvelopingMist);
			return "Thunder Focus EnvelopingMist";
		end
		if (v6:AffectingCombat() and not v58() and v20.AncientTeachingsTalent:IsAvailable() and v20.RisingSunKick:IsReady()) then
			v15(v20.RisingSunKick);
			return "Thunder Focus RisingSunKick";
		end
		if v20.SecertInfusion:IsAvailable() then
			if (v73 ~= nil) then
				if (v20.RenewingMist:IsReady() and (v20.RenewingMist:Charges() > (1145 - (466 + 679))) and (v73:HealthPercentageWeighted() <= (240 - 140)) and (v6:IsInRaid() or (not v6:IsInRaid() and (v37.BuffCount(v22, v20.RenewingMist) < (14 - 9))))) then
					v73:Cast(v20.RenewingMist);
					return "Renewing Mist - Thunder Focus ";
				end
			end
			if (not v6:IsInRaid() and v20.EnvelopingMist:IsReady() and (v71 <= v39.Healing.EnvMistHP) and (v37.BuffCount(v22, v20.EnvelopingMist) < (1902 - (106 + 1794)))) then
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
				if (v20.RenewingMist:IsReady() and (v20.RenewingMist:Charges() > (0 + 0)) and (v73:HealthPercentageWeighted() <= (26 + 74)) and (v6:IsInRaid() or (not v6:IsInRaid() and (v37.BuffCount(v22, v20.RenewingMist) < (14 - 9))))) then
					v73:Cast(v20.RenewingMist);
					return "Renewing Mist Thudner Focus - No SecertInfusion";
				end
			end
		end
	end
	if (v20.FaelineStomp:IsReady() and v37.TargetIsValid() and not v40(v7) and (not v6:IsCameraBusy() or not v39.Cooldowns.FSCursorBusy) and v7:AffectingCombat() and (not v6:IsMoving() or v39.Cooldowns.FSMoving) and v29) then
		local v881;
		if (v58() or (v6:BuffDown(v20.AncientConcordance) and v20.AncientTeachingsTalent:IsAvailable()) or v37.AoELogicWithCount(v39.AoE.FSHP, v39.AoE.FSCount, "With Logic", v22)) then
			v881 = true;
		else
			v881 = false;
		end
		local v882 = (((v39.Cooldowns.UseFae == "With Logic") or ((v39.Cooldowns.UseFae == "With Cooldowns and Logic") and v14)) and v881) or ((v39.Cooldowns.UseFae == "With Cooldowns") and v14);
		if v882 then
			v15(v20.FaelineStomp);
			return "Faeline/Jadefire Stomp 1";
		end
	end
	if (v62(v20.Chiji) > (0 - 0)) then
		local v883 = v74 or v69;
		if (not v6:PrevGCD(115 - (4 + 110), v20.EnvelopingMist) and (v883:BuffDown(v20.EnvelopingMist, nil, true) or (v883:HealthPercentage() < (664 - (57 + 527)))) and v20.EnvelopingMist:IsReady() and v6:BuffUp(v20.ChijiBuff, nil, true) and ((v6:BuffStack(v20.ChijiBuff) == (1430 - (41 + 1386))) or ((v6:BuffStack(v20.ChijiBuff) == (105 - (17 + 86))) and not v6:IsMoving() and (v883:HealthPercentageWeighted() < (55 + 25))))) then
			v883:Cast(v20.EnvelopingMist);
			return "ChiJi EnvolopingMist ";
		end
		if (v37.TargetIsValid() and v28 and not v40(v7) and v7:AffectingCombat()) then
			if (v20.BlackoutKick:IsReady() and v28 and ((v6:BuffStack(v20.TeachingsMons) > (6 - 3)) or not v20.TeachingsoftheMonasteryTalent:IsAvailable())) then
				v15(v20.BlackoutKick);
				return "Blkout TeachingsMons Chiji";
			end
			if (v20.RisingSunKick:IsReady() and v28 and (v6:IsInRaid() or (v72 < (231 - 151)))) then
				v15(v20.RisingSunKick);
				return "RisingSunKick raid Chiji";
			end
			if (v20.EyeoftheTiger:IsAvailable() and (v37.DebuffCount(v26, v20.EyeOfTheTigerBuff) == (166 - (122 + 44))) and v20.TigerPalm:IsReady() and v28) then
				v15(v20.TigerPalm);
				return "TP EyeoftheTiger ";
			end
			if (v13() and v20.SpinningCraneKick:IsReady() and ((v25 >= (6 - 2)) or v6:BuffUp(v20.DanceOfChijiMW)) and not v6:IsInRaid() and v6:BuffUp(v20.AwkakenedFaeline)) then
				v15(v20.SpinningCraneKick);
				return "SpinningCraneKick Chiji";
			end
			if (v20.BlackoutKick:IsReady() and v28 and v6:BuffUp(v20.AncientConcordance) and (v25 >= (6 - 4))) then
				v15(v20.BlackoutKick);
				return "Blkout AncientConcordance AOE Chiji";
			end
			if (v20.RisingSunKick:IsReady() and v28) then
				v15(v20.RisingSunKick);
				return "RisingSunKick Chiji";
			end
			if (v20.TigerPalm:IsReady() and v28 and v6:BuffUp(v20.AwkakenedFaeline) and (v6:BuffStack(v20.TeachingsMons) <= (3 + 0)) and v20.TeachingsoftheMonasteryTalent:IsAvailable()) then
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
	if (v76 and v6:AffectingCombat() and v6:BuffDown(v20.YulonBuff, nil, true) and (v62(v20.Chiji) <= (0 + 0)) and ((v20.Yulon:IsAvailable() and v20.Yulon:CooldownUp()) or (v20.Chiji:IsAvailable() and v20.Chiji:CooldownUp()))) then
		local v884 = (v20.TeachingsoftheMonasteryTalent:IsAvailable() and v6:BuffUp(v20.TeachingsMons, nil, true) and (v6:BuffStack(v20.TeachingsMons) >= (5 - 2))) or not v20.TeachingsoftheMonasteryTalent:IsAvailable();
		local v885 = (v20.Chiji:IsReady() and v884) or v20.Yulon:IsReady();
		if not v6:IsChanneling() then
			if (not v20.Yulon:IsAvailable() and v20.TeachingsoftheMonasteryTalent:IsAvailable() and (v6:BuffStack(v20.TeachingsMons) < (68 - (30 + 35))) and v28 and v37.TargetIsValid()) then
				v15(v20.TigerPalm);
				return "Tiger Palm Ramp";
			end
			if (v20.ShaohaosLessionTalent:IsAvailable() and v884) then
				if (v20.SheilunsGift:IsReady() and not v6:IsMoving() and (v20.SheilunsGift:Count() >= (3 + 1)) and v885) then
					v69:Cast(v20.SheilunsGift);
					return "SG Ramp";
				end
			end
			if ((v73 ~= nil) and not v20.AncientTeachingsTalent:IsAvailable() and v20.RenewingMist:IsReady() and (v20.RenewingMist:Charges() > (1257 - (1043 + 214)))) then
				if (v20.ThunderFocusTea:IsReady() and v6:BuffDown(v20.ThunderFocusTea, nil, true)) then
					v15(v20.ThunderFocusTea);
					return "Renewing Mist Ramp";
				end
				v73:Cast(v20.RenewingMist);
				return "Renewing Mist Ramp";
			end
		end
		if (v20.Yulon:IsReady() and (not v20.ShaohaosLessionTalent:IsAvailable() or (v20.SheilunsGift:Count() < (26 - 19)))) then
			v46(v20.Yulon);
			return "yulon Ramp";
		end
		if (v884 and v28 and v20.Chiji:IsReady() and (not v20.ShaohaosLessionTalent:IsAvailable() or (v20.SheilunsGift:Count() < (1216 - (323 + 889))))) then
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
	if (v6:BuffUp(v20.EscapeFromReality, nil, true) and not v6:IsMoving() and v37.AoELogic(v39.Cooldowns.EscapeHP, "With Logic", v22) and not v6:PrevGCD(2 - 1, v20.SoothingMist)) then
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
		if (v20.SoothingMist:IsReady() and not v6:PrevGCD(581 - (361 + 219), v20.SoothingMist) and (not v28 or (v20.AncientTeachingsTalent:IsAvailable() and v6:BuffDown(v20.AncientTeachings))) and (v71 <= v39.Soothing.SoothingMistAtRange) and not v6:IsMoving()) then
			if (v20.RenewingMist:IsReady() and (v20.RenewingMist:Charges() > (320 - (53 + 267))) and v47(v69)) then
				v69:Cast(v20.RenewingMist);
				return "SoothingMist RenewingMist 4P";
			end
			if v6:IsInRaid() then
				v46(v20.SoothingMist, v69, 1 + 2);
			else
				v69:Cast(v20.SoothingMist);
			end
			return "Soothing on Lowest Unit Weighted";
		end
		if (v74 ~= nil) then
			if (v6:BuffDown(v20.YulonBuff) and v20.EnvelopingMist:IsReady() and not v6:IsMoving() and not v6:PrevGCD(414 - (15 + 398), v20.EnvelopingMist) and (v74:HealthPercentageWeighted() <= v39.Healing.EnvMistHP)) then
				v74:Cast(v20.EnvelopingMist);
				return "EnV Unit";
			end
		end
		if (v20.SoothingMist:IsReady() and not v6:PrevGCD(983 - (18 + 964), v20.SoothingMist) and (v71 <= v39.Soothing.SoothingMistHP) and not v6:IsMoving()) then
			if (v20.RenewingMist:IsReady() and (v20.RenewingMist:Charges() > (0 - 0)) and v47(v69)) then
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
		if (v20.Vivify:IsReady() and not v6:PrevGCD(1 + 0, v20.Vivify) and not v6:IsMoving() and v49(v69, v72, v39.Healing.VivifyHP)) then
			v69:Cast(v20.Vivify);
			return "Vifify 2";
		end
	end
	if (v20.Vivify:IsReady() and v6:BuffDown(v20.ThunderFocusTea, nil, true) and not v6:PrevGCD(851 - (20 + 830), v20.Vivify) and v6:BuffUp(v20.VivaciousVivification, nil, true) and v49(v69, v72, v39.Healing.VivVivifyHP)) then
		v69:Cast(v20.Vivify);
		return "Vifify";
	end
	if (v33 and v6:BuffDown(v20.YulonBuff, nil, true) and (v62(v20.Chiji) == (0 + 0))) then
		if (v73 ~= nil) then
			if (v20.RenewingMist:IsReady() and (v73:HealthPercentageWeighted() <= v39.Healing.RenewingMistHP) and ((v20.RenewingMist:Charges() > (127 - (116 + 10))) or ((v20.RenewingMist:Charges() > (0 + 0)) and (v20.AncientTeachingsTalent:IsAvailable() or (v20.ThunderFocusTea:CooldownRemains() > (746 - (542 + 196))))))) then
				v73:Cast(v20.RenewingMist);
				return "Renewing Mist Non-Ramp 1";
			end
		end
	end
	if (v20.ZenPulse:IsReady() and v70) then
		if ((v34 <= (107 - 57)) or ((v25 >= (1 + 1)) and (v34 <= (46 + 44)) and v70:BuffUp(v20.EnvelopingMist))) then
			v70:Cast(v20.ZenPulse);
			return "Zen Pulse on Tank";
		end
	end
	if v33 then
		if (v20.Vivify:IsReady() and not v6:PrevGCD(1 + 0, v20.Vivify) and not v6:IsMoving() and v49(v69, v72, v39.Healing.VivifyHP)) then
			v69:Cast(v20.Vivify);
			return "Vifify 2";
		end
	end
	if v20.RisingSunKick:CooldownDown() then
		if (v6:BuffUp(v20.StrengthOfTheBlackOx, nil, true) and not v6:PrevGCD(2 - 1, v20.EnvelopingMist) and v20.EnvelopingMist:IsReady()) then
			if (v70 and v6:AffectingCombat() and not v6:IsMoving() and v70:BuffDown(v20.EnvelopingMist)) then
				v70:Cast(v20.EnvelopingMist);
				return "Strength Ox EnvelopingMist";
			end
		end
		if (v74 ~= nil) then
			if (v6:BuffUp(v20.StrengthOfTheBlackOx, nil, true) and not v6:PrevGCD(2 - 1, v20.EnvelopingMist) and v20.EnvelopingMist:IsReady()) then
				if (v6:AffectingCombat() and not v6:IsMoving()) then
					v74:Cast(v20.EnvelopingMist);
					return "Strength Ox EnvelopingMist";
				end
			end
		end
	end
	if (v78 and v6:BuffDown(v20.YulonBuff, nil, true) and v37.TargetIsValid() and not v40(v7) and v7:AffectingCombat()) then
		if (v20.RisingSunKick:IsReady() and v28 and (v6:IsInRaid() or (v72 < (1631 - (1126 + 425))))) then
			v15(v20.RisingSunKick);
			return "RisingSunKick raid";
		end
		if (v20.EyeoftheTiger:IsAvailable() and (v37.DebuffCount(v26, v20.EyeOfTheTigerBuff) == (405 - (118 + 287))) and v20.TigerPalm:IsReady() and v28) then
			v15(v20.TigerPalm);
			return "TP EyeoftheTiger ";
		end
		if (v14() and v13() and v20.SummonWhiteTigerStatue:IsReady() and (v25 >= (15 - 11)) and v54(1151 - (118 + 1003)) and (not v6:IsCameraBusy() or not v39.Cooldowns.FSCursorBusy) and not v6:IsMoving()) then
			if v12.CastTarget(v20.SummonWhiteTigerStatue, v12.TName().PLAYER) then
				return "WhiterTigerStatue";
			end
		end
		if (v13() and v20.SpinningCraneKick:IsReady() and ((v25 >= (11 - 7)) or v6:BuffUp(v20.DanceOfChijiMW)) and not v6:IsInRaid() and (v6:BuffUp(v20.AwkakenedFaeline) or v6:BuffDown(v20.AncientTeachings))) then
			v15(v20.SpinningCraneKick);
			return "SpinningCraneKick 1";
		end
		if (v20.BlackoutKick:IsReady() and v28 and ((v6:BuffStack(v20.TeachingsMons) > (380 - (142 + 235))) or not v20.TeachingsoftheMonasteryTalent:IsAvailable())) then
			v15(v20.BlackoutKick);
			return "Blkout TeachingsMons";
		end
		if (v20.BlackoutKick:IsReady() and v28 and v6:BuffUp(v20.AncientConcordance) and (v25 >= (9 - 7))) then
			v15(v20.BlackoutKick);
			return "Blkout AncientConcordance AOE";
		end
		if (v20.TigerPalm:IsReady() and v28 and v6:BuffUp(v20.AwkakenedFaeline) and (v6:BuffStack(v20.TeachingsMons) <= (1 + 2)) and v20.TeachingsoftheMonasteryTalent:IsAvailable()) then
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
					v12.CastMacro(978 - (553 + 424), nil, nil, v21.Iridal);
					return "weapon cast Iridal";
				end
			else
				local v890, v891, v892 = v6:GetUseableItems(v23, 29 - 13);
				if (v890 and v890:IsReady() and v7:IsInRange(v892) and v37.TargetIsValid()) then
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
	if (v20.ChiBurst:IsReady() and not v6:IsMoving() and v6:BuffUp(v20.AwkakenedFaeline) and (v27 > (3 + 0)) and not v28 and v7:AffectingCombat() and v20.FaelineStomp:CooldownDown()) then
		v15(v20.ChiBurst);
		return "ChiBurst";
	end
end
local function v87()
	v37.HealthPotions();
	if v37.ShouldStopCastUpdate() then
		v12.CastMacro(4 + 2, true);
		return "Stop Cast For Silence";
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
		if v6:AffectingCombat() then
			if v32 then
				if v20.SpearHandStrike:IsReady() then
					v82 = v37.InterruptCycle(v20.SpearHandStrike, 3 + 2, true, nil, false);
					if v82 then
						return v82;
					end
				end
				if v20.LegSweep:IsReady() then
					v82 = v37.InterruptCycle(v20.LegSweep, 5 + 3, true, nil, true, true);
					if v82 then
						return v82;
					end
				end
				if v39.Mistweaver.LegSweepInt then
					if (v20.SpearHandStrike:CooldownDown() and v20.LegSweep:IsReady()) then
						v82 = v37.InterruptCycle(v20.LegSweep, 17 - 9, true, nil, false, true);
						if v82 then
							return v82;
						end
					end
				end
				if v39.Mistweaver.ParaInt then
					if v20.Paralysis:IsReady() then
						v82 = v37.InterruptCycle(v20.Paralysis, 55 - 35, true, nil, true);
						if v82 then
							return v82;
						end
						if v20.SpearHandStrike:CooldownDown() then
							v82 = v37.InterruptCycle(v20.Paralysis, 44 - 24, true, nil, false);
							if v82 then
								return v82;
							end
						end
					end
				end
			end
			if v20.Paralysis:IsReady() then
				v82 = v37.IncorpCycle(v20.Paralysis, 6 + 14, true, false);
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
		if (v39.Mistweaver.AutoTabMelee and (v68 > (0 - 0)) and not v28 and v6:CanAttack(v7)) then
			v12.TopPanelAlternative:ChangeIcon(754 - (239 + 514), 2 + 1);
			return "Auto tab to melee";
		end
		if v6:IsChanneling(v20.ManaTea) then
			if ((((v71 < (1409 - (797 + 532))) or (v6:ManaPercentage() >= (66 + 24)) or (v6:BuffUp(v20.YulonBuff, nil, true) and (v62(v20.Chiji) > (0 + 0)))) and (v44(v20.ManaTea) > (v45 or (2 - 1)))) or (v44(v20.ManaTea) > (1207 - (373 + 829)))) then
				v12.CastMacro(737 - (476 + 255), true);
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
		v82 = v86();
		if v82 then
			return v82;
		end
		if ((v71 > (1220 - (369 + 761))) and (v6:ManaPercentage() <= v39.Mistweaver.ManaTeaMP) and (v6:BuffStack(v20.ManaTeaBuff) >= v39.Mistweaver.ManaTeaStack) and not v6:IsChanneling(v20.ManaTea)) then
			v15(v20.ManaTea);
			return "Mana Tea - Settings Met for Mana";
		end
	end
end
local function v88()
	local v126 = {};
	local v127 = string.char;
	local v128 = string.byte;
	local v129 = string.sub;
	local v130 = bit32 or bit;
	local v131 = v130.bxor;
	local v132 = table.concat;
	local v133 = table.insert;
	local function v134(v876, v877)
		local v878 = {};
		for v886 = 1 + 0, #v876 do
			v133(v878, v127(v131(v128(v129(v876, v886, v886 + (1 - 0))), v128(v129(v877, (1 - 0) + (v886 % #v877), (239 - (64 + 174)) + (v886 % #v877) + 1 + 0))) % (378 - 122)));
		end
		return v132(v878);
	end
	v126[(2120 - (144 + 192)) - (1211 - (42 + 174))] = v134("\103\184\120", "\50\32\237\49\181\78\67");
	v126[(2849 + 943) - (2490 + 515)] = v134("\227\129\47", "\205\164\212\102\100");
	v126[36 + 48 + (2205 - (363 + 1141))] = v134("\219\52\98", "\106\156\97\43\183\72");
	v126[(3803 - (1183 + 397)) - (4383 - 2943)] = v134("\106\116\119", "\122\45\33\62");
	v126[(2203 + 802) - (1663 + 561)] = v134("\114\231\37", "\132\53\178\108");
	v126[(4550 - (1913 + 62)) - (611 + 358 + (2189 - 1362))] = v134("\29\2\218", "\223\90\87\147");
	v126[(2203 - (565 + 1368)) + (1906 - 1399)] = v134("\144\14\118", "\87\215\91\63\48\159\31\190");
	v126[(3935 - (1477 + 184)) - (2041 - 542)] = v134("\155\70\40", "\63\220\19\97\183\98");
	v126[478 + 34 + (1117 - (564 + 292))] = v134("\193\58\124", "\64\134\111\53\58\30\173");
	v126[(2468 - 1037) - ((774 - 517) + (707 - (244 + 60)))] = v134("\252\251\7", "\24\187\174\78\27\98\65");
	v126[(2212 + 664) - (2583 - (41 + 435))] = v134("\28\145\19", "\120\91\196\90\165\75\185");
	v126[(1700 - (938 + 63)) + 53 + 15] = v134("\97\200\139", "\65\38\157\194\170\163\129\99");
	v126[(1888 - (936 + 189)) + 1 + 1] = v134("\237\180\22", "\109\170\225\95\96\210");
	v126[(4180 - (1565 + 48)) - (1115 + 689)] = v134("\239\41\63", "\230\168\124\118\105");
	v126[(2211 - (782 + 356)) - ((483 - (176 + 91)) + (249 - 153))] = v134("\88\223\129", "\140\31\138\200");
	v126[(3623 - 1164) - (2792 - (975 + 117))] = v134("\105\59\105", "\207\46\110\32\87\20\48\42");
	v126[(4058 - (157 + 1718)) - (445 + 103 + (3116 - 2238))] = v134("\101\232\137\218\74\251\159\217\66\232", "\173\39\154\236");
	v126[(6068 - 4293) - (2037 - (697 + 321))] = v134("\247\90\73\60", "\102\186\53\39\87\136\139\20");
	v126[(936 - 592) + (870 - 459)] = v134("\5\233\155", "\97\68\185\215\108\45\95");
	v126[(5004 - 2833) - (340 + 531 + (1024 - 477))] = v134("\39\19\122", "\109\96\70\51\93\217\87");
	v126[(873 - 547) + (1652 - (322 + 905))] = v134("\10\150\63", "\185\77\195\118\41\119");
	v126[(1032 - (602 + 9)) + (1517 - (449 + 740))] = v134("\198\231\216", "\60\129\178\145\216");
	v126[(1770 - (826 + 46)) - (1098 - (245 + 702))] = v134("\34\51\4", "\180\101\102\77\94\120\102");
	v126[(5608 - 3833) - (12 + 23 + (2893 - (260 + 1638)))] = v134("\228\13\14", "\75\163\88\71\213");
	v126[(2507 - (382 + 58)) - (4247 - 2923)] = v134("\217\205\227", "\183\158\152\170");
	v126[235 + 47 + (948 - 489)] = v134("\122\246\99", "\180\61\163\42\157\126\132\181");
	v126[(787 - 522) + (1679 - (902 + 303))] = v134("\155\67\197", "\172\220\22\140\19\190\55");
	v126[(5034 - 2741) - ((1673 - 978) + 74 + 787)] = v134("\121\97\39", "\229\62\52\110\16\193\229");
	v126[(3777 - (1121 + 569)) - ((780 - (22 + 192)) + (1469 - (483 + 200)))] = v134("\102\34\54", "\98\33\119\127\123\121\145");
	v126[(2631 - (1404 + 59)) - ((678 - 430) + (250 - 63))] = v134("\107\22\105", "\36\44\67\32");
	v126[(2664 - (468 + 297)) - ((1599 - (334 + 228)) + (441 - 310))] = v134("\138\178\144", "\16\205\231\217\195\102\32\85");
	v126[(4616 - 2624) - (2290 - 1027)] = v134("\56\71\227", "\46\127\18\170\52\212\182\46");
	v126[(640 + 1613) - ((1325 - (141 + 95)) + 430 + 7)] = v134("\211\225\57", "\138\148\180\112\174\147\160");
	v126[(5163 - 3157) - (3079 - 1798)] = v134("\84\203\121", "\120\19\158\48");
	v126[53 + 170 + (1369 - 869)] = v134("\202\42\141", "\47\141\127\196\161\186\147\165");
	v126[(869 + 367) - (269 + 246)] = v134("\68\30\228\91\100\22\230\84\118\5", "\63\19\119\138");
	v126[(3359 - 973) - (872 + 605 + (352 - (92 + 71)))] = v134("\196\214\125\41", "\104\137\185\19\66\70\27");
	v126[(1000 + 1023) - ((1045 - 423) + (1447 - (574 + 191)))] = v134("\148\183\135", "\214\213\231\203\168");
	v126[(2287 + 485) - (5148 - 3093)] = v134("\48\63\128", "\221\119\106\201\26");
	v126[(814 + 779) - ((939 - (254 + 595)) + (914 - (55 + 71)))] = v134("\45\181\129", "\221\106\224\200");
	v126[(94 - 22) + (2431 - (573 + 1217))] = v134("\204\24\61", "\105\139\77\116\98\167\74");
	v126[(742 - 474) + 34 + 409] = v134("\128\136\53", "\234\199\221\124");
	v126[(3296 - 1250) - ((1300 - (714 + 225)) + (2851 - 1875))] = v134("\193\42\203", "\55\134\127\130\104\123");
	v126[(322 - 90) + 52 + 423] = v134("\83\157\31", "\109\20\200\86\130\71\186\202");
	v126[(1860 - 575) - (1386 - (118 + 688))] = v134("\103\188\199", "\63\32\233\142");
	v126[(1194 - (25 + 23)) - (79 + 326 + (1924 - (927 + 959)))] = v134("\7\7\146", "\20\64\82\219\225\71");
	v126[(16 - 11) + (1428 - (16 + 716))] = v134("\221\247\248", "\140\154\162\177");
	v126[(3422 - 1649) - (1171 - (11 + 86))] = v134("\46\111\20", "\220\105\58\93\124\68");
	v126[(5097 - 3007) - ((1393 - (175 + 110)) + (719 - 434))] = v134("\58\227\6", "\144\125\182\79\155\130\35\46");
	v126[(11186 - 8918) - ((3357 - (503 + 1293)) + (33 - 21))] = v134("\8\123\44", "\232\79\46\101\138\49\94");
	v126[(1918 + 734) - (3020 - (810 + 251))] = v134("\9\139\230", "\210\78\222\175\162\116\216\172");
	v126[288 + 126 + 86 + 191] = v134("\211\2\87", "\100\148\87\30");
	v126[211 + 23 + (988 - (43 + 490))] = v134("\6\8\20", "\169\65\93\93\118\134\175");
	v126[(2545 - (711 + 22)) - (4351 - 3226)] = v134("\230\25\238", "\225\161\76\167\164\61");
	v126[(3083 - (240 + 619)) - (202 + 633 + (1119 - 415))] = v134("\110\229\51\20\198\70\237\54\5\195", "\177\35\140\64\96");
	v126[(175 + 2468) - ((2952 - (1344 + 400)) + (1156 - (255 + 150)))] = v134("\27\219\31\23", "\217\86\180\113\124\224\116\43");
	v126[302 + 81 + 161 + 139] = v134("\2\25\120", "\18\67\73\52");
	v126[(2717 - 2081) + (148 - 102)] = v134("\109\23\105\174\44\196\105\101\80", "\21\36\121\29\203\94\182\28");
	v126[(3822 - (404 + 1335)) - ((491 - (183 + 223)) + (1603 - 285))] = v134("\32\110\217\58\44\81\251\127\79\115\252\103\21\73\240\117\23\91\231\58\34\81\250\120\5\81\226\122\18", "\20\97\62\149");
	v126[(1049 + 534) - (326 + 578)] = v134("\140\44\89\131\218\162\18\126\131\218\164\15\97\218\242\172\10\112\223\185\140\19\80", "\151\205\124\21\173");
	v126[(3421 - (10 + 327)) - (1676 + 730)] = v134("\127\194\136\130\115\253\170\199\16\223\173\223\74\229\161\205\72\247\182\130\108\243\173\200\118\247\165\192\87\252\163", "\172\62\146\196");
	v126[(2091 - (118 + 220)) - (327 + 652 + (546 - (108 + 341)))] = v134("\58\30\220\109\227\90\33\126\85\3\249\48\218\66\42\116\13\43\226\109\252\84\38\113\58\33\213", "\21\123\78\144\67\174\53\79");
	v126[(785 + 961) - (4523 - 3453)] = v134("\161\74\10\14\231\52\142\113\104\109\195\40\148\109\35\65\220\62\146\52\14\69\203\55\137\116\33", "\91\224\26\70\32\170");
	v126[(1792 - (711 + 782)) + (720 - 344)] = v134("\84\204\119\31\84\176\21\126\178\118\88\106\171\12\112\253\77\84\107\241\40\122\243\79\89\112\177\28", "\123\21\156\59\49\25\223");
	v126[(1665 - (270 + 199)) - (170 + 352)] = v134("\198\228\117\128\202\219\87\197\169\249\80\221\243\195\92\207\241\209\75\128\212\219\86\218\239\221\87\201", "\174\135\180\57");
	v126[(2297 - (580 + 1239)) + (579 - 384)] = v134("\81\134\217\232\250\115\171\123\248\216\175\196\104\178\117\183\227\163\197", "\197\16\214\149\198\183\28");
	v126[(1083 + 49) - (17 + 443)] = v134("\229\135\145\74\194\138\128\74\254\178\197\30\222\144\128\25\222\141\137\14\150\150\138\74\245\131\150\30\152", "\106\182\226\229");
	v126[192 + 247 + (605 - 373)] = v134("\108\54\201\110\43\86\55\193\58\14\86\42\210\58\34\75\121\244\123\45\88\60\134\50\13\80\45\134\83\45\31\20\195\118\38\90\112\134\82\19\31", "\67\63\89\166\26");
	v126[92 + 55 + (1690 - (645 + 522))] = v134("\145\23\20\117\157\40\54\48\254\10\49\40\164\48\61\58\166\34\42\117\130\38\49\63\131\40\55\47\184\46\54\60\254\20\55\52\164\47\49\53\183\10\49\40\164\6\44\9\177\41\63\62", "\91\208\71\88");
	v126[(4076 - (1010 + 780)) - (1617 + 0)] = v134("\214\86\1\142\42\86", "\22\133\58\104\234\79\36\83");
	v126[(1972 - 1558) + (744 - 490)] = v134("\58\6\102\54\1\1\6\50\94\37\73\23\122\100\16\26\11\125\122\17\73\23\125\54\54\8\16\102\56", "\117\105\99\18\22");
	v126[(2536 - (1045 + 791)) - ((25 - 15) + (34 - 11))] = v134("\54\174\165\208\50\81\11\166\234\233\51\75\17\225\130\244\122", "\56\101\193\202\164\90");
	v126[(2983 - (351 + 154)) - ((1676 - (1281 + 293)) + (1976 - (28 + 238)))] = v134("\85\40\25\159\41\123\22\62\159\41\125\11\33\198\1\117\14\48\195\74\70\25\60\213\55\123\23\33\217\13\122\31\123\226\11\123\12\61\216\10\115\53\60\194\16\92\40", "\100\20\120\85\177");
	v126[(4314 - 2383) - ((1903 - (1381 + 178)) + 865 + 57)] = v134("\76\250\231\122\122\228", "\30\31\150\142");
	v126[(779 + 186) - (129 + 172)] = v134("\235\224\8\122\67\116\39\122\240\213\92\46\95\110\39\41\208\234\16\62\23\104\45\122\251\228\15\46\25", "\90\184\133\124\90\55\28\66");
	v126[(2840 - 2016) - (55 + 51 + (525 - (381 + 89)))] = v134("\14\94\15\198\178\250\51\86\64\255\179\224\41\17\1\198\250\193\60\95\7\215\250\187\19\94\20\146\147\253\125\124\5\222\191\246\116\17\40\226\250", "\147\93\49\96\178\218");
	v126[(2153 + 274) - (481 + 229 + (1807 - 752))] = v134("\158\6\147\203\53\176\56\180\203\53\182\37\171\146\29\190\32\186\151\86\140\57\176\145\16\182\56\184\203\43\176\57\171\141\17\177\49\146\140\11\171\23\171\183\25\177\49\186", "\120\223\86\223\229");
	v126[(2364 - (1074 + 82)) - (1198 - 651)] = v134("\156\143\180\29\255\57", "\229\207\227\221\121\154\75\96");
	v126[(1975 - (214 + 1570)) + (1924 - (990 + 465))] = v134("\214\7\204\151\241\10\221\151\205\50\152\195\237\16\221\196\237\13\212\211\165\22\215\151\198\3\203\195\171", "\183\133\98\184");
	v126[28 + 38 + 259 + 334] = v134("\225\92\249\37\213\167\220\84\182\28\212\189\198\19\222\1\157", "\206\178\51\150\81\189");
	v126[(1465 + 41) - (3337 - 2489)] = v134("\160\176\160\225\172\142\142\135\225\172\136\147\152\184\132\128\150\137\189\207\178\143\131\187\137\136\142\139\225\178\142\143\152\167\136\143\135\161\166\146\149\168\188", "\225\225\224\236\207");
	v126[(3146 - (1668 + 58)) - ((663 - (512 + 114)) + (1892 - 1166))] = v134("\186\206\24\163\14\247", "\39\233\162\113\199\107\133\45");
	v126[(26 - 13) + (2237 - 1594)] = v134("\251\65\232\93\220\76\249\93\253\74\245\9\136\103\243\8\198\80\188\9\192\86\249\14\192\75\240\25\136\80\243\93\235\69\239\9\134", "\125\168\36\156");
	v126[(804 + 923) - (55 + 237 + 679 + 101)] = v134("\17\213\208\4\86\38\217\221\13\5\17\223\210\5\80\59\196\156\34\74\39\222\200\65", "\37\82\176\188\97");
	v126[(2630 - 1850) - ((2019 - (109 + 1885)) + (1570 - (1269 + 200)))] = v134("\61\205\145\114\49\242\179\55\82\208\180\47\8\234\184\61\10\248\175\114\46\252\180\56\61\242\152\114\63\222\158\51\9\243\169", "\92\124\157\221");
	v126[(5243 - 2507) - (2898 - (98 + 717))] = v134("\27\46\30\32\72\17", "\141\72\66\119\68\45\99");
	v126[(2110 - (802 + 24)) - ((768 - 322) + (234 - 48))] = v134("\200\192\15\176\44\116\23\59\211\245\91\228\48\110\23\104\243\202\23\244\120\104\29\59\216\196\8\228\118", "\27\155\165\123\144\88\28\114");
	v126[(186 + 1072) - (352 + 105 + 25 + 125)] = v134("\160\219\1\54\144\202\4\50\143\158\46\60\141\218\24\58\151\158\37\3\195", "\83\227\190\109");
	v126[55 + 197 + (1107 - 709)] = v134("\192\107\13\119\232\132\228\234\21\12\48\214\159\253\228\90\55\60\215\197\216\224\82\37\24\202\174\164\194\120\9\9", "\138\129\59\65\89\165\235");
	v126[(6332 - 4433) - (448 + 802)] = v134("\6\135\167\94\76\39", "\41\85\235\206\58");
	v126[167 + 241 + 198 + 42] = v134("\55\69\99\76\16\72\114\76\49\78\126\24\68\99\120\25\10\84\55\76\16\72\101\9\23\72\120\0\0\0\99\3\68\99\118\31\16\14", "\108\100\32\23");
	v126[(1169 + 438) - (212 + 240 + (1941 - (797 + 636)))] = v134("\109\120\92\240\141\139\85\124\24\198\159\141\74\105\24\214\132\151\73\109\24", "\226\39\25\56\149\235");
	v126[(6156 - 4888) - (2241 - (1427 + 192))] = v134("\134\251\128\185\17\168\197\167\185\17\174\216\184\224\57\166\221\169\229\114\149\202\165\243\29\168\238\226\209\15\132\196\185\249\40", "\92\199\171\204\151");
	v126[(600 + 1130) - (2519 - 1434)] = v134("\196\228\37\8\25\7", "\165\151\136\76\108\124\117");
	v126[226 + 25 + 179 + 214] = v134("\103\21\211\66\48\113\241\100\124\32\135\22\44\107\241\55\92\31\203\6\100\109\251\100\119\17\212\22\106", "\68\52\112\167\98\68\25\148");
	v126[(2351 - (192 + 134)) - ((1613 - (316 + 960)) + 582 + 463)] = v134("\242\46\73\34\195\253\202\42\13\20\209\251\213\63\13\15\245\180", "\148\184\79\45\71\165");
	v126[376 + 110 + 145 + 11] = v134("\136\129\174\254\132\190\140\187\231\156\139\163\189\166\135\177\191\180\144\254\155\176\139\180\136\190\167\254\143\130\170\128", "\208\201\209\226");
	v126[(9561 - 7060) - ((934 - (83 + 468)) + (3283 - (1202 + 604)))] = v134("\29\217\204\38\11\183", "\132\78\181\165\66\110\197\49");
	v126[(2838 - 2230) + (52 - 20)] = v134("\193\94\193\121\253\243\208\203\199\85\220\45\169\216\218\158\252\79\149\121\253\243\199\142\225\83\218\53\237\187\193\132\178\120\212\42\253\181", "\235\146\59\181\89\137\155\181");
	v126[(2234 - 1427) - ((465 - (45 + 280)) + 28 + 0)] = v134("\192\120\218\114\247\33\163\83\220\42\211\60\163", "\72\131\16\179\95\189");
	v126[(2511 + 362) - (817 + 1418)] = v134("\4\0\113\206\247\83\127\43\107\29\84\147\206\75\116\33\51\53\79\206\232\93\120\36\4\63\120\206\249\84\120\42\44\19\82\149\212\72", "\64\69\80\61\224\186\60\17");
	v126[(948 + 765) - (29 + 131 + (1696 - 780))] = v134("\215\83\200\4\162\55", "\231\132\63\161\96\199\69\91");
	v126[(3504 - (340 + 1571)) - (378 + 579)] = v134("\2\201\11\26\144\57\201\95\114\180\113\216\23\72\129\34\196\16\86\128\113\216\16\26\167\48\223\11\20", "\228\81\172\127\58");
	v126[(3948 - (1733 + 39)) - ((4141 - 2634) + (1068 - (125 + 909)))] = v134("\112\89\52\13\121\88\125\104\99\17", "\32\51\49\93");
	v126[(2355 - (1096 + 852)) + 102 + 125] = v134("\6\76\49\48\223\40\114\22\48\223\46\111\9\105\247\38\106\24\108\188\21\125\20\122\211\40\89\83\93\250\46\118\20\86\194", "\146\71\28\125\30");
	v126[(3044 - 912) - (1454 + 45)] = v134("\126\140\160\25\167\151", "\71\45\224\201\125\194\229");
	v126[(1710 - (409 + 103)) - ((759 - (46 + 190)) + (138 - (51 + 44)))] = v134("\126\74\148\171\223\166\72\15\181\229\194\186\13\108\143\254\197\186\13\91\136\249\206\189\69\64\140\239\139\186\66\15\163\234\216\186\3", "\206\45\47\224\139\171");
	v126[(364 + 925) - (1975 - (1114 + 203))] = v134("\201\8\173\239\254\93\130\239\229\19\181\160", "\128\144\125\193");
	v126[(1252 - (228 + 498)) + 23 + 81] = v134("\206\99\22\94\194\92\52\27\161\126\51\3\251\68\63\17\249\86\40\94\221\82\51\20\206\92\31\94\214\70\54\31\225\112\53\5\225\71", "\112\143\51\90");
	v126[200 + 161 + (931 - (174 + 489))] = v134("\43\15\43\233\29\17", "\141\120\99\66");
	v126[(312 - 192) + (2413 - (830 + 1075))] = v134("\44\220\180\159\11\209\165\159\55\233\224\203\23\203\165\204\23\214\172\219\95\205\175\159\60\216\179\203\81", "\191\127\185\192");
	v126[(680 - (303 + 221)) + (1740 - (231 + 1038))] = v134("\197\165\126\213\9\155\174\121\188", "\41\156\208\18\186\103\187\230");
	v126[60 + 11 + (1717 - (171 + 991))] = v134("\203\35\41\20\240\243\228\24\75\119\212\239\254\4\0\91\203\249\248\93\55\91\212\248\203\28\32\20\228\233\230\28\11\114\237", "\156\138\115\101\58\189");
	v126[(181 - 137) + (1560 - 979)] = v134("\119\127\164\78\65\97", "\42\36\19\205");
	v126[(6058 - 3630) - (1444 + 360)] = v134("\17\47\207\140\54\34\222\140\23\36\210\216\98\9\212\217\44\62\155\140\54\34\201\201\49\34\212\192\38\106\207\195\98\9\218\223\54\100", "\172\66\74\187");
	v126[(5927 - 4236) - ((925 - 604) + (1205 - 457))] = v134("\60\149\4\4\226\18\171\35\4\226\20\182\60\93\202\28\179\45\88\129\47\164\33\78\238\18\128\102\120\202\11\172\62\75\195\62\170\61\68\219", "\175\125\197\72\42");
	v126[(1592 - 1077) + (1354 - (111 + 1137))] = v134("\69\28\133\55\231\29", "\111\22\112\236\83\130");
	v126[(255 - (91 + 67)) + (1556 - 1033)] = v134("\15\95\1\104\223\52\95\85\0\251\124\78\29\58\206\47\82\26\36\207\124\78\26\104\232\61\73\1\102", "\171\92\58\117\72");
	v126[(331 + 994) - (1230 - (423 + 100))] = v134("\135\194\206\240\131\169\252\233\240\131\175\225\246\169\171\167\228\231\172\224\148\243\235\186\143\169\215\172\140\171\176\251\244\191\162\142\194", "\206\198\146\130\222");
	v126[(11 + 1440) - (2309 - 1475)] = v134("\183\8\61\173\31\79", "\61\228\100\84\201\122");
	v126[131 + 120 + (1136 - (326 + 445))] = v134("\112\79\241\28\32\75\79\165\105\58\74\94\165\127\59\86\68\241\28\116\87\66\247\89\39\75\69\233\88\116\87\69\165\127\53\80\94\171", "\84\35\42\133\60");
	v126[(8697 - 6704) - ((2252 - 1241) + (856 - 489))] = v134("\6\29\31\143\57\0\20\149\117\50\19\128\33\85\57\137\32\27\14\198", "\230\85\117\122");
	v126[(1231 - (530 + 181)) + (975 - (614 + 267))] = v134("\156\46\124\73\57\1\179\21\30\42\29\29\169\9\85\6\2\11\175\80\98\6\29\10\156\17\117\73\39\41\158\17\69\9\0", "\110\221\126\48\103\116");
	v126[(1220 - (19 + 13)) - ((393 - 151) + (775 - 442))] = v134("\139\204\17\213\192\170", "\165\216\160\120\177");
	v126[(6124 - 3980) - (189 + 537 + (1416 - 610))] = v134("\31\173\202\28\207\67\57\13\4\152\158\72\211\89\57\94\36\167\210\88\155\95\51\13\15\169\205\72\149", "\45\76\200\190\60\187\43\92");
	v126[(4085 - 2115) - ((2590 - (1293 + 519)) + (1185 - 604))] = v134("\76\253\177\94\127\250\0\70\63\210\189\81\103\175\38\101\63", "\53\31\149\212\55\19\143\110");
	v126[(913 - 563) + (497 - 237)] = v134("\92\186\121\233\119\167\201\118\196\120\174\73\188\208\120\139\67\162\72\230\245\124\131\81\134\85\141\137\78\173\125\151", "\167\29\234\53\199\58\200");
	v126[(9654 - 7415) - ((718 - 413) + 702 + 623)] = v134("\159\72\74\196\75\206", "\188\204\36\35\160\46");
	v126[(354 + 1381) - (2618 - 1491)] = v134("\14\191\156\113\212\53\191\200\25\240\125\174\128\35\197\46\178\135\61\196\125\174\135\113\227\60\169\156\127", "\160\93\218\232\81");
	v126[(489 + 1627) - (495 + 993 + 14 + 7)] = v134("\214\143\85\85\68\217\137\80\95\11\244\198\123\96", "\100\154\230\51\48");
	v126[(2307 - (709 + 387)) - (2463 - (673 + 1185))] = v134("\205\149\82\163\196\88\16\231\235\83\228\250\67\9\233\164\104\232\251\25\44\237\172\122\197\236\86\18\229\171\121\163\197\116\54\220", "\126\140\197\30\141\137\55");
	v126[(3767 - 2468) - (2228 - 1534)] = v134("\5\234\41\124\51\244", "\24\86\134\64");
	v126[(2744 - 1076) - (762 + 302)] = v134("\211\64\27\200\71\164\167\160\109\63\200\71\164\176\229\86\7\135\95\168\226\244\74\79\171\82\191\182\174", "\194\128\37\111\232\51\204");
	v126[(586 + 198) - (244 - 63)] = v134("\135\198\29\213\76\216\187\196\83\253\82\194\161\131\60\255\120\145\157\243\83", "\177\213\163\115\176\59");
	v126[(575 + 1766) - (3467 - 1728)] = v134("\85\43\19\69\205\88\122\16\113\38\233\68\96\12\58\10\246\82\102\85\13\10\233\83\92\30\62\7\233\89\115\85\13\14\238\82\99\18\49\12\205\94\103\15\16\36\195", "\55\20\123\95\107\128");
	v126[(2767 - 1357) - (2689 - (446 + 1434))] = v134("\198\85\75\76\216\211", "\161\149\57\34\40\189");
	v126[(1946 - (1040 + 243)) - ((41 - 27) + (1896 - (559 + 1288)))] = v134("\48\33\228\78\96\220\216\67\12\192\78\96\220\207\6\55\248\1\120\208\157\23\43\176\45\117\199\201\77", "\189\99\68\144\110\20\180");
	v126[(2234 - (609 + 1322)) + (750 - (13 + 441))] = v134("\255\0\7\66\47\231\54\202\69\36\78\43\250\120\229\53\73", "\88\173\101\105\39\88\142");
	v126[(9734 - 7129) - (5256 - 3249)] = v134("\164\19\125\29\93\95\228\142\109\124\90\99\68\253\128\34\71\86\98\30\216\132\42\85\123\117\81\230\140\45\86\29\66\85\228\128\52\88\93\119\125\227\150\55\121\99", "\138\229\67\49\51\16\48");
	v126[(7077 - 5656) - (25 + 624 + (635 - 460))] = v134("\200\141\43\59\253\159", "\237\155\225\66\95\152");
	v126[(1022 + 1855) - (1000 + 1281)] = v134("\151\73\110\248\64\86\253\246\140\124\58\172\92\76\253\165\172\67\118\188\20\74\247\246\135\77\105\172\26", "\214\196\44\26\216\52\62\152");
	v126[(3798 - 2518) - (254 + 210 + (406 - 185))] = v134("\11\180\17\192\236\243\54\250\52\221\251\244\36\163\66\252\221\189", "\157\66\218\98\180\141");
	v126[(1427 + 730) - (870 + 693)] = v134("\99\228\252\150\219\77\218\219\150\219\75\199\196\207\243\67\194\213\202\184\112\213\217\220\222\71\213\220\209\248\69\154\230\209\224\116\221\198\209\240\91\252\224", "\150\34\180\176\184");
	v126[(1029 + 403) - (705 + 134)] = v134("\76\243\198\171\239\109", "\138\31\159\175\207");
	v126[(2436 + 53) - ((538 - (153 + 280)) + (5174 - 3382))] = v134("\52\57\62\13\148\15\57\106\101\176\71\40\34\95\133\20\52\37\65\132\71\40\37\13\163\6\47\62\3", "\224\103\92\74\45");
	v126[(2267 + 258) - (430 + 658 + 443 + 403)] = v134("\138\113\44\30\186\97\122\63\140\56", "\119\220\24\90");
	v126[490 + 49 + 37 + 14] = v134("\214\18\33\77\218\45\3\8\185\15\4\16\227\53\8\2\225\39\31\77\197\35\4\7\223\39\12\15\254\44\10\77\193\43\27\10\241\59\37\51", "\99\151\66\109");
	v126[(3205 - 1100) - (937 + 579)] = v134("\66\61\240\242\134\14", "\124\17\81\153\150\227");
	v126[(3119 - (89 + 578)) - (755 + 301 + (1679 - 871))] = v134("\241\133\97\112\151\202\133\53\24\179\130\148\125\34\134\209\136\122\60\135\130\148\122\112\160\195\147\97\126", "\227\162\224\21\80");
	v126[(1173 - (572 + 477)) + 63 + 400] = v134("\96\12\84\236\73\13\82\224\75\5\2\196\76\17\86\169\82\11\86\225\5\54\100\221\5\13\76\169\117\14\67\240\64\16\2\193\117\66", "\137\37\98\34");
	v126[(1041 + 693) - (138 + 1010)] = v134("\199\185\229\161\7\239\234\237\199\228\230\57\244\243\227\136\223\234\56\174\214\231\128\205\199\47\225\232\239\135\206\161\15\238\242\203\128\218\251\30\198\208\206\185\230\225\26\236\229\255\140\219", "\132\134\233\169\143\74\128");
	v126[(1515 - (84 + 2)) - (1390 - 546)] = v134("\102\38\125\221\119\52", "\40\53\74\20\185\18\70\21");
	v126[(797 + 308) - ((1266 - (497 + 345)) + 3 + 94)] = v134("\143\225\233\79\81\92\113\3\148\212\189\27\77\70\113\80\180\235\241\11\5\64\123\3\159\229\238\27\11", "\35\220\132\157\111\37\52\20");
	v126[(157 + 770) - ((1412 - (605 + 728)) + 190 + 75)] = v134("\125\115\216\132\203\160\203\46\86\122\142\172\206\188\207\103\112\77\142", "\71\56\29\174\225\167\207\187");
	v126[(3859 - 2123) - (53 + 1101)] = v134("\218\230\103\167\243\244\216\64\167\243\242\197\95\254\219\250\192\78\251\144\201\215\66\237\246\254\215\71\224\208\252\152\110\231\200\214\223\88\253\246\203", "\190\155\182\43\137");
	v126[(491 - 358) + 404 + 44] = v134("\60\162\65\90\119\89", "\196\111\206\40\62\18\43\112");
	v126[(3543 - 2264) - (528 + 171)] = v134("\55\42\198\19\87\126\166\68\7\226\19\87\126\177\1\60\218\92\79\114\227\16\32\146\112\66\101\183\74", "\195\100\79\178\51\35\22");
	v126[(1861 - (457 + 32)) - (337 + 456)] = v134("\27\255\20\190\119\213\29\184\56\249\28\251\31\198", "\219\87\150\114");
	v126[(1625 - (832 + 570)) + 335 + 20] = v134("\171\250\159\252\12\39\95\114\196\231\186\161\53\63\84\120\156\207\161\252\9\45\80\117\131\196\180\252\13\11\121\73", "\25\234\170\211\210\65\72\49");
	v126[(235 + 663) - (1135 - 814)] = v134("\148\52\78\203\162\42", "\175\199\88\39");
	v126[(978 + 1052) - ((1874 - (588 + 208)) + (1013 - 637))] = v134("\235\217\80\164\241\242\60\5\240\236\4\240\237\232\60\86\208\211\72\224\165\238\54\5\251\221\87\240\171", "\37\184\188\36\132\133\154\89");
	v126[(2173 - (884 + 916)) + (422 - 220)] = v134("\212\235\66\120\57\93\232\233\12\80\39\71\242\174\99\82\13\20\206\222\12", "\52\134\142\44\29\78");
	v126[199 + 143 + (885 - (232 + 421))] = v134("\29\127\125\110\101\220\167\55\1\124\41\91\199\190\57\78\71\37\90\157\129\57\78\93\41\70\212\231\14\74\95\37\95\218\167\59\98\88\51\92\252\134\31", "\201\92\47\49\64\40\179");
	v126[(3847 - (1569 + 320)) - (340 + 1045)] = v134("\192\239\13\204\246\241", "\168\147\131\100");
	v126[(354 + 1507) - (4343 - 3054)] = v134("\63\218\6\60\151\4\218\82\84\179\76\203\26\110\134\31\215\29\112\135\76\203\29\60\160\13\204\6\50", "\227\108\191\114\28");
	v126[(863 - (316 + 289)) + (819 - 506)] = v134("\34\62\123\181\89\25\53\114\240\99\25\40\97\240\102\32\123", "\46\112\91\21\208");
	v126[(37 + 746) - ((1620 - (666 + 787)) + (471 - (360 + 65)))] = v134("\209\16\5\173\81\250\63\218\190\13\32\240\104\226\52\208\230\37\59\173\84\240\48\221\249\46\46\173\78\240\63\212\231\41\39\228\81\252\34\197\216\16", "\177\144\64\73\131\28\149\81");
	v126[(2037 + 142) - (1864 - (79 + 175))] = v134("\180\65\240\222\81\214", "\164\231\45\153\186\52");
	v126[(2699 - 987) - (721 + 202 + (677 - 456))] = v134("\185\191\241\239\255\15\143\250\205\159\171\19\130\168\224\188\227\8\134\190\165\187\228\71\169\187\246\187\165", "\103\234\218\133\207\139");
	v126[(4662 - 2241) - ((2088 - (503 + 396)) + (846 - (92 + 89)))] = v134("\47\254\40\202\7\254\47\158\48\249\45\215\0\233\123\246\54\176", "\190\102\144\91");
	v126[(77 - 37) + 270 + 256] = v134("\146\135\203\248\135\188\185\236\248\135\186\164\243\161\175\178\161\226\164\228\155\178\230\186\163\189\176\169\128\163\165\129\238\160\163\181\174\207\134", "\202\211\215\135\214");
	v126[(980 + 675) - (4268 - 3178)] = v134("\73\41\85\51\119\91", "\128\26\69\60\87\18\41");
	v126[(223 + 1403) - (2421 - 1359)] = v134("\145\7\201\187\247\220\167\66\245\203\163\192\170\16\216\232\235\219\174\6\157\239\236\148\129\3\206\239\173", "\180\194\98\189\155\131");
	v126[421 + 61 + 39 + 42] = v134("\215\128\35\44\235\192\75\201\185\117", "\107\129\233\85\69\141\185");
	v126[(2521 - 1693) - (34 + 232)] = v134("\41\114\6\81\226\11\23\3\12\7\22\220\16\14\13\67\60\26\221\74\49\13\67\38\22\193\3\87\62\75\60\22\201\29\49\56", "\121\104\34\74\127\175\100");
	v126[(431 - 148) + (1522 - (485 + 759))] = v134("\121\43\67\201\186\158", "\38\42\71\42\173\223\236\138");
	v126[(2572 - 1460) - (1741 - (442 + 747))] = v134("\107\167\10\245\196\80\167\94\157\224\24\182\22\167\213\75\170\17\185\212\24\182\17\245\243\89\177\10\251", "\176\56\194\126\213");
	v126[(3015 - (832 + 303)) - (2267 - (88 + 858))] = v134("\86\63\76\126\185\198\99\56\84\124\245\228\122\34\78\59\162\192\103\57\26\79\147\253\51\62\84\59\133\197\114\40\95\105\245\225\67\113", "\169\19\81\58\27\213");
	v126[(709 + 1617) - (1464 + 304)] = v134("\108\151\13\231\194\66\169\42\231\194\68\180\53\190\234\76\177\36\187\161\101\162\32\165\230\67\160\111\140\225\91\138\40\186\251\121\129\21\129\223\98\169\17\165\238\84\162\51", "\143\45\199\65\201");
	v126[(37 + 844) - (1113 - (766 + 23))] = v134("\4\89\14\177\57\182", "\196\87\53\103\213\92");
	v126[(7059 - 5629) - (1195 - 321)] = v134("\140\245\105\190\180\193\192\149\151\192\61\234\168\219\192\198\183\255\113\250\224\221\202\149\156\241\110\234\238", "\181\223\144\29\158\192\169\165");
	v126[(5535 - 3434) - ((3533 - 2492) + (1578 - (1036 + 37)))] = v134("\240\42\196\129\217\43\194\141\219\35\146\169\220\55\198\196\253\20\146", "\228\181\68\178");
	v126[380 + 155 + (36 - 17)] = v134("\215\145\193\84\127\163\114\253\239\192\19\65\184\107\243\160\251\31\64\226\84\243\160\225\19\92\171\50\211\175\251\55\91\191\104\222\145", "\28\150\193\141\122\50\204");
	v126[(1088 + 294) - ((2062 - (641 + 839)) + (1160 - (910 + 3)))] = v134("\68\199\61\220\229\233", "\145\23\171\84\184\128\155");
	v126[(1294 - 786) + (1728 - (1466 + 218))] = v134("\224\63\211\254\108\42\91\147\15\201\183\108\98\125\220\47\201\170\56\54\86\193\63\212\182\119\46\90\147\46\200\254\91\35\77\199\116", "\62\179\90\167\222\24\66");
	v126[(329 + 386) - ((1301 - (556 + 592)) + 4 + 7)] = v134("\26\168\18\25\33\176\166\180\53\237\61\19\60\160\186\188\45\237\61\19\39\170\187\245", "\213\89\205\126\124\82\196\207");
	v126[(1612 - (329 + 479)) - ((1062 - (174 + 680)) + (157 - 111))] = v134("\103\41\40\58\42\73\23\15\58\42\79\10\16\99\2\71\15\1\102\73\103\22\33\58\36\101\58\11\97\9\82", "\103\38\121\100\20");
	v126[(1054 - 545) + 29 + 11] = v134("\66\85\221\11\116\75", "\111\17\57\180");
	v126[(1752 - (396 + 343)) - (37 + 370 + (1535 - (29 + 1448)))] = v134("\16\3\168\117\55\43\3\252\29\19\99\18\180\39\38\48\14\179\57\39\99\18\179\117\0\34\21\168\123", "\67\67\102\220\85");
	v126[(2417 - (135 + 1254)) - ((1653 - 1214) + (196 - 154))] = v134("\222\232\254\174\238\249\251\170\241\173\209\164\243\233\231\162\233\173\218\155\189", "\203\157\141\146");
	v126[(1438 + 719) - (3138 - (389 + 1138))] = v134("\29\99\169\190\209\45\40\55\29\168\249\239\54\49\57\82\147\245\238\108\7\51\118\203\211\223\10\22", "\70\92\51\229\144\156\66");
	v126[(2441 - (102 + 472)) - (162 + 9 + 639 + 512)] = v134("\16\115\233\121\70\49", "\35\67\31\128\29");
	v126[(518 + 37) - ((1550 - (320 + 1225)) + (10 - 4))] = v134("\52\225\249\182\176\123\160\198\50\234\228\226\228\80\170\147\9\240\173\182\176\123\183\131\20\236\226\250\160\51\177\137\71\199\236\229\176\61", "\230\103\132\141\150\196\19\197");
	v126[292 + 184 + (1531 - (157 + 1307))] = v134("\144\87\214\251\129\174\53\172\250\101\198\241\138\183\103\138\181\67\220\234\199", "\201\218\54\178\158\231\199\71");
	v126[(2028 - (821 + 1038)) + (930 - 557)] = v134("\16\207\107\4\100\62\241\76\4\100\56\236\83\93\76\48\233\66\88\7\16\240\98\4\111\2\220\72\95\71\37", "\41\81\159\39\42");
	v126[23 + 187 + (587 - 256)] = v134("\52\5\199\55\131\185", "\203\103\105\174\83\230");
	v126[(592 + 999) - ((346 - 206) + (1937 - (834 + 192)))] = v134("\45\30\146\241\20\222\12\94\51\182\241\20\222\27\27\8\142\190\12\210\73\10\20\198\146\1\197\29\80", "\105\126\123\230\209\96\182");
	v126[13 + 183 + 89 + 254] = v134("\124\200\185\180\82\143\89\83\137\142\165\91\139\91\22\225\141\241", "\43\54\169\221\209\52\230");
	v126[(48 + 2182) - ((1081 - 383) + (1298 - (300 + 4)))] = v134("\221\13\57\14\169\133\242\54\91\109\141\153\232\42\16\65\146\143\238\115\52\79\161\196\218\14\61\112", "\234\156\93\117\32\228");
	v126[(176 + 482) - ((162 - 100) + (421 - (112 + 250)))] = v134("\66\57\23\218\75\70", "\52\17\85\126\190\46");
	v126[(642 + 967) - (2687 - 1614)] = v134("\118\117\149\153\189\227\53\5\69\143\208\189\171\19\74\101\143\205\233\171\36\77\98\132\202\161\228\60\65\48\149\214\233\200\49\86\100\207", "\80\37\16\225\185\201\139");
	v126[(787 + 586) - (434 + 404)] = v134("\122\10\46\185\115\11\103\215\86\23\41\224\25", "\148\57\98\71");
	v126[19 + 6 + 253 + 256] = v134("\57\183\200\182\108\210\229\86\86\170\237\235\85\202\238\92\14\130\246\182\96\210\206\19\59\143\237\242\72\254\228\72\22\147", "\61\120\231\132\152\33\189\139");
	v126[227 + 78 + (1642 - (1001 + 413))] = v134("\241\95\28\210\26\228", "\178\162\51\117\182\127\150\67");
	v126[(1765 - 973) - (1142 - (244 + 638))] = v134("\67\197\219\63\79\250\49\48\232\255\63\79\250\38\117\211\199\112\87\246\116\100\207\143\92\90\225\32\62", "\84\16\160\175\31\59\146");
	v126[(2162 - (627 + 66)) - (2794 - 1856)] = v134("\167\193\126\25\96\76\13\172\249\55", "\45\228\169\23\52\42\37");
	v126[(1351 - (512 + 90)) - (2125 - (1665 + 241))] = v134("\51\2\148\109\63\61\182\40\92\31\177\48\6\37\189\34\4\55\170\109\51\61\157\109\49\58\177\41\27\26\136", "\67\114\82\216");
	v126[(1156 - (373 + 344)) + 41 + 49] = v134("\234\16\36\239\58\230", "\71\185\124\77\139\95\148");
	v126[102 + 281 + (382 - 237)] = v134("\157\15\78\111\186\2\95\111\155\4\83\59\238\41\85\58\160\30\26\59\166\24\95\60\166\5\86\43\238\30\85\111\141\11\73\59\224", "\79\206\106\58");
	v126[(2917 - 1193) - (2296 - (35 + 1064))] = v134("\218\84\25\165\223\16\143\236\84\27\190\145", "\204\131\33\117\202\177\48");
	v126[(626 + 233) - ((294 - 156) + 1 + 194)] = v134("\5\233\132\163\226\43\215\163\163\226\45\202\188\250\202\37\207\173\255\129\5\214\141\163\246\49\213\167\227\236\43\204\166\249", "\175\68\185\200\141");
	v126[(1651 - (298 + 938)) + (1369 - (233 + 1026))] = v134("\140\127\235\234\250\6", "\179\223\19\130\142\159\116\182");
	v126[(1818 - (636 + 1030)) + 191 + 181] = v134("\240\15\70\163\198\95\188\194\235\58\18\247\218\69\188\145\203\5\94\231\146\67\182\194\224\11\65\247\156", "\226\163\106\50\131\178\55\217");
	v126[166 + 3 + 106 + 248] = v134("\0\31\32\187\55\74\4\132\121", "\212\89\106\76");
	v126[(152 + 2085) - ((1353 - (55 + 166)) + 113 + 470)] = v134("\165\128\198\105\169\191\228\44\202\157\227\52\144\167\239\38\146\181\248\105\165\191\207\105\189\165\230\40\138\152\218", "\71\228\208\138");
	v126[(128 + 1144) - (2868 - 2117)] = v134("\39\27\39\61\36\6", "\65\116\119\78\89");
	v126[(771 - (36 + 261)) + (79 - 33)] = v134("\238\58\185\8\29\227\216\127\152\70\0\255\157\28\162\93\7\255\157\127\185\64\27\238\206\55\162\68\13\171\201\48\237\107\8\248\201\113", "\139\189\95\205\40\105");
	v126[(2996 - (34 + 1334)) - (114 + 181 + 634 + 181)] = v134("\100\42\174\60\88\247\23\163\11\55\139\97\97\239\28\169\83\31\144\60\84\247\60\230\119\31\148\123\99\249\21\139\74\15\140\102", "\200\37\122\226\18\21\152\121");
	v126[(3301 - (1035 + 248)) - (1522 - (20 + 1))] = v134("\223\94\203\132\205\48", "\126\140\50\162\224\168\66\41");
	v126[(780 + 716) - (1299 - (134 + 185))] = v134("\141\226\75\73\250\58\92\254\207\111\73\250\58\75\187\244\87\6\226\54\25\170\232\31\42\239\33\77\240", "\57\222\135\63\105\142\82");
	v126[(1294 - (549 + 584)) + (1038 - (314 + 371))] = v134("\4\23\161\162\8\40\131\231\107\10\132\255\49\48\136\237\51\34\159\162\4\40\168\162\23\34\155\229\51\38\129\196\21", "\140\69\71\237");
	v126[(3065 - 2172) - (1348 - (478 + 490))] = v134("\230\116\133\57\129\64", "\27\181\24\236\93\228\50");
	v126[(987 + 876) - (2523 - (786 + 386))] = v134("\219\230\178\105\177\224\230\230\28\171\225\247\230\10\170\253\237\178\105\229\252\235\180\44\182\224\236\170\45\229\252\236\230\10\164\251\247\232", "\197\136\131\198\73");
	v126[(2629 - 1817) - ((1504 - (1055 + 324)) + (1516 - (1093 + 247)))] = v134("\14\201\42\177\241\25\51\210\111\159\244\10\41\129\12\183\232\2\41\129", "\108\93\161\79\216\157");
	v126[(1668 + 208) - (144 + 1222)] = v134("\250\240\59\232\204\176\115\208\142\58\175\242\171\106\222\193\1\163\243\241\92\212\229\89\149\198\156\114\206\206\3", "\29\187\160\119\198\129\223");
	v126[(4081 - 3053) - ((53 - 37) + (1430 - 927))] = v134("\11\246\182\22\59\174", "\203\88\154\223\114\94\220\179");
	v126[(4513 - 2717) - (459 + 829)] = v134("\113\33\40\250\174\171\36\2\12\12\250\174\171\51\71\55\52\181\182\167\97\86\43\124\153\187\176\53\12", "\65\34\68\92\218\218\195");
	v126[(5493 - 4067) - ((1713 - 1216) + 319 + 103)] = v134("\224\6\35\194\85\64\221\29\102\236\80\83\199\78\14\251\25", "\53\179\110\70\171\57");
	v126[(825 - 502) + (871 - (364 + 324))] = v134("\253\188\93\97\241\131\127\36\146\161\120\60\200\155\116\46\202\137\99\97\253\131\84\97\239\171\89\31", "\79\188\236\17");
	v126[(761 - 483) + (544 - 317)] = v134("\241\160\137\130\199\190", "\230\162\204\224");
	v126[(264 + 531) - ((790 - 601) + (162 - 60))] = v134("\230\188\9\97\193\177\24\97\244\175\26\97\253\137\93\53\221\171\24\50\221\182\17\37\149\173\18\97\246\184\14\53\155", "\65\181\217\125");
	v126[(4895 - 3283) - ((2331 - (1249 + 19)) + 42 + 4)] = v134("\130\103\58\181\85\133\231\114\43\187\72\192\149\113\56\184\76\148\190\52\17\132\5", "\224\199\20\89\212\37");
	v126[(1837 - 1365) + (1116 - (686 + 400))] = v134("\43\67\141\128\38\17\4\120\239\227\2\13\30\100\164\207\29\27\24\61\130\193\4\18\14\124\182\192\24\80\47\96\162\207\27\27\34\67", "\126\106\19\193\174\107");
	v126[(596 + 163) - (487 - (73 + 156))] = v134("\247\73\174\38\182\103", "\224\164\37\199\66\211\21");
	v126[(10 + 2065) - ((1454 - (721 + 90)) + 11 + 921)] = v134("\228\63\185\188\147\94\91\194\246\44\170\188\175\102\30\146\210\40\174\249\137\66\95\133\210\122\185\244\149\83\77\138\216\54\169\188\136\80\30\149\223\63\163\188\158\89\75\194\192\59\163\232\199\66\81\194\194\41\168\188\147\94\87\145\151\59\185", "\226\183\90\205\156\231\54\62");
	v126[(3607 - 2496) - (1082 - (224 + 246))] = v134("\121\218\75\42\32\72\220\2\118\107\101\248", "\75\45\168\34\68");
	v126[(2427 - 928) - ((23 - 10) + 180 + 808)] = v134("\158\245\229\195\168\17\177\206\135\160\140\13\171\210\204\140\147\27\173\139\234\130\138\18\187\202\222\131\150\80\139\215\192\131\142\27\171\151\225\189", "\126\223\165\169\237\229");
	v126[12 + 467 + 14 + 4] = v134("\133\62\232\30\188\19", "\113\214\82\129\122\217\97");
	v126[(2786 - 1384) - (3014 - 2108)] = v134("\249\49\158\99\222\60\143\99\235\34\141\99\226\4\202\51\207\38\137\38\196\32\139\36\207\116\158\43\216\49\153\43\197\56\142\99\197\50\202\52\194\49\132\99\211\59\159\99\221\53\132\55\138\32\133\99\223\39\143\99\222\60\131\48\138\53\158", "\67\170\84\234");
	v126[(2359 - (203 + 310)) - ((2359 - (1238 + 755)) + 69 + 916)] = v134("\200\180\131\243\79\249\178\202\172\4\212\150", "\36\156\198\234\157");
	v126[(3562 - (709 + 825)) - ((1182 - 540) + (1298 - 406))] = v134("\161\185\25\74\28\81\57\139\199\24\13\34\74\32\133\136\35\1\35\16\20\143\134\57\0\62\73\57\147\199\1\22\56\80\60\133\157\100\44\1", "\87\224\233\85\100\81\62");
	v126[(1376 - (196 + 668)) - ((59 - 44) + (7 - 3))] = v134("\50\143\244\140\71\234", "\195\97\227\157\232\34\152\163");
	v126[(1280 - (171 + 662)) + (138 - (4 + 89))] = v134("\38\20\2\6\25\20\0\74\10\91\12\73\27\91\25\79\5\30\85\82\1\91\0\85\11\91\1\78\7\8\85\101\1\20\25\66\1\12\27\25", "\38\110\123\117");
	v126[(3872 - 2767) - (224 + 390)] = v134("\60\235\94\202\3\252\67\132\90\185\23\241\27\248\80\193", "\164\104\153\55");
	v126[(6368 - 4918) - (377 + 583)] = v134("\207\207\247\185\214\77\253\24\160\210\210\228\239\85\246\18\248\250\201\185\216\77\252\31\234\240\204\249\232\12\199\1\231\241\208\242\239\16\198\0\235", "\115\142\159\187\151\155\34\147");
	v126[(3144 - (35 + 1451)) - (2622 - (28 + 1425))] = v134("\244\158\143\190\83\130\199\130", "\237\176\236\224\206\55");
	v126[(2417 - (941 + 1052)) + 62 + 2] = v134("\253\60\23\140\225\137\218\217\55\64\213\249\147\143\217\58\11\201\182\146\192\149\38\19\201\182\146\199\220\32\64\239\249\137\195\209\60\23\194\169", "\175\181\83\96\172\150\230");
	v126[(1538 - (822 + 692)) + (660 - 197)] = v134("\246\169\221\7\4\87\214\251\133\73\58\65\195\188\209", "\50\162\219\180\105\111");
	v126[(792 + 888) - ((1026 - (45 + 252)) + 461 + 4)] = v134("\250\74\147\242\123\38\213\113\241\145\95\58\207\109\186\189\64\44\201\52\156\179\89\37\223\117\168\178\69\103\239\104\182\178\93\44\207\43\138\175\83", "\73\187\26\223\220\54");
	v126[78 + 147 + (632 - 372)] = v134("\201\247\71\57\137\200\223\187", "\213\141\133\40\73\237\167\168");
	v126[(625 - (114 + 319)) + (418 - 126)] = v134("\98\42\160\52\113\253\68\60\171\119\81\174\113\54\171\96\20\250\88\121\183\113\82\252\82\42\173\52\117\218\8\121", "\142\55\89\197\20\52");
	v126[(1813 - 398) - (595 + 337)] = v134("\152\238\119\245\136\219\50\135\168\251\96\176\190\245\50\148\153", "\213\205\157\18");
	v126[(139 - 45) + (812 - 424)] = v134("\169\253\194\119\56\194\134\198\160\20\28\222\156\218\235\56\3\200\154\131\205\54\26\193\140\194\249\55\6\131\189\222\235\28\51\236\188", "\173\232\173\142\89\117");
	v126[(3166 - (556 + 1407)) - (1928 - (741 + 465))] = v134("\87\189\182\164\0\86\160\167\179\4\122", "\107\20\213\211\199");
	v126[(1506 - (170 + 295)) - (296 + 265)] = v134("\44\228\12\38\194\7\220\253\26\233\12\36\135\109\238\237\16\226\21\118\181\37\212\245\26\175\38\55\143\40\207\248\95\237\16\37\155\114\157", "\153\127\143\101\86\226\77\189");
	v126[67 + 5 + (1002 - 595)] = v134("\230\255\34\92\65\61\76\228\246\245\38\73\19\26\63\134\192\231\50\19", "\196\181\148\75\44\97\123\31");
	v126[(902 + 186) - (223 + 124 + 149 + 114)] = v134("\165\40\158\139\242\142\138\19\252\232\214\146\144\15\183\196\201\132\150\86\145\202\208\141\128\23\165\203\204\207\162\43\145\208\205\146\139\10\144\208\204\152", "\225\228\120\210\165\191");
	v126[(1678 - (957 + 273)) + 8 + 21] = v134("\246\232\123\68\21\6\192\244\106\72\16", "\68\181\128\30\39\126");
	v126[171 + 254 + (194 - 143)] = v134("\147\41\81\83\48\107\176\177\50\93\31\19\24\221\169\44\93\29\17\7", "\144\198\90\52\115\118\56");
	v126[(2550 - 1582) - (1505 - 1012)] = v134("\200\46\185\123\234\39\240\42\253\77\248\33\239\63\253\83\227\56\235\33\186\33\172", "\78\130\79\221\30\140");
	v126[(3599 - 2872) - (2033 - (389 + 1391))] = v134("\106\203\22\83\136\235\69\240\116\48\172\247\95\236\63\28\179\225\89\181\25\18\170\232\79\244\45\19\182\170\109\200\23\18\179\237\69\252", "\132\43\155\90\125\197");
	v126[237 + 140 + 10 + 86] = v134("\49\43\221\45\25\1\205\58\6\44\214", "\78\114\67\184");
	v126[(3207 - 1798) - (1888 - (783 + 168))] = v134("\239\114\54\197\200\200\104\45\129\159\222\114\52\197\211\206\118\36\197\203\200\61\52\150\218\135\105\41\140\204\135\94\46\138\211\195\114\54\139\128", "\191\167\29\65\229");
	v126[(2117 - 1486) - (158 + 2)] = v134("\105\67\240\197\118\75\81\71\180\243\100\77\78\82\180\245\99\67\68\71", "\34\35\34\148\160\16");
	v126[(542 - (309 + 2)) + (733 - 494)] = v134("\221\26\26\51\230\243\36\61\51\230\245\57\34\106\206\253\60\51\111\133\223\37\57\113\207\243\61\56\110\133\201\57\51\91\202\249", "\171\156\74\86\29");
	v126[(3102 - (1090 + 122)) - (350 + 729 + (1148 - 806))] = v134("\104\42\26\222\38\85\91\54", "\58\44\88\117\174\66");
	v126[(1061 + 489) - (2200 - (628 + 490))] = v134("\78\173\244\178\241\117\173\160\225\241\124\171\235\178\230\114\189\238\230\165\94\169\243\230\171", "\133\29\200\128\146");
	v126[(117 + 532) - ((435 - 259) + (27 - 21))] = v134("\248\175\128\244\38\25\245\216\231\162\244\44\24\187\248\179\132\254\33\31", "\155\171\199\229\157\74\108");
	v126[(2327 - (431 + 343)) - ((356 - 179) + (2632 - 1722))] = v134("\196\201\99\243\160\219\90\238\183\98\180\158\192\67\224\248\89\184\159\154\119\234\246\67\185\130\195\90\246\183\124\154\190\192\85\230\242", "\52\133\153\47\221\237\180");
	v126[(961 + 255) - (88 + 596 + (1762 - (556 + 1139)))] = v134("\249\212\172\10\114\217", "\171\170\184\197\110\23");
	v126[(1165 - (6 + 9)) - (5 + 19 + 340 + 322)] = v134("\81\3\19\244\79\250\193\117\8\68\173\87\224\148\117\5\15\177\24\225\219\57\25\23\177\24\225\220\112\31\68\151\87\250\216\125\3\19\186\7", "\180\25\108\100\212\56\149");
	v126[(1317 - (28 + 141)) - (266 + 419)] = v134("\239\254\242\196\46\241\51\207\182\208\196\36\240\125\233\229\246\202\39", "\93\188\150\151\173\66\132");
	v126[(2923 - 554) - (1220 + 502 + (1502 - (486 + 831)))] = v134("\107\141\105\88\57\115\68\182\11\59\29\111\94\170\64\23\2\121\88\243\102\25\27\112\78\178\82\24\7\50\127\174\64\37\51", "\28\42\221\37\118\116");
	v126[(947 - 583) + (341 - 244)] = v134("\3\238\140\255\119\22\48\242", "\121\71\156\227\143\19");
	v126[69 + 295 + (303 - 207)] = v134("\36\190\97\197\207\58\25\189\114\197\193\58\25\241\122\140\211\48\76\165\121\197\205\38\9\241\98\141\209\38\76\146\121\138\212\49\3\166\120\218", "\85\108\209\22\229\184");
	v126[(2030 - (668 + 595)) - (278 + 30)] = v134("\169\65\205\144\105\88\129\191\90\197\218\70", "\161\234\41\164\189\35\49");
	v126[(486 + 1924) - ((1559 - 987) + (1670 - (23 + 267)))] = v134("\153\31\16\4\106\6\182\36\114\103\78\26\172\56\57\75\81\12\170\97\31\69\72\5\188\32\43\68\84\71\141\60\57\105\79\0\178\38", "\105\216\79\92\42\39");
	v126[(2031 - (1129 + 815)) + (757 - (371 + 16))] = v134("\58\97\34\193\198\6\9\125", "\105\126\19\77\177\162");
	v126[(3537 - (1326 + 424)) - ((2071 - 977) + (866 - 629))] = v134("\128\228\204\75\178\23\62\243\201\232\75\178\23\41\182\242\208\4\170\27\123\167\238\152\40\167\12\47\253", "\91\211\129\184\107\198\127");
	v126[(1748 - (88 + 30)) - ((832 - (720 + 51)) + (2477 - 1363))] = v134("\191\164\229\244\77\201\151\173\184\225\244\69\215\151\176\184\255\242\69\144\255\185\237", "\183\233\205\147\157\43\176");
	v126[(2704 - (421 + 1355)) - ((59 - 23) + 216 + 222)] = v134("\105\60\93\14\42\26\70\7\63\109\14\6\92\27\116\65\17\16\90\66\82\79\8\25\76\3\102\78\20\91\126\5\103\121\18\25\71\2\89\112", "\117\40\108\17\32\103");
	v126[(3311 - (286 + 797)) - ((5731 - 4163) + (342 - 135))] = v134("\192\217\58\249\65\54", "\136\147\181\83\157\36\68\162");
	v126[(2880 - (397 + 42)) - (279 + 612 + (1898 - (24 + 776)))] = v134("\193\58\232\107\127\92\61\239\49\167\91\127\94\120\236\56\247\119\127\79\61\205\62\244\106\49\106\104\230\49\244\62\126\90\61\195\54\244\106\49\76\104\242\62\233\121\49\113\104\236\56\233\48", "\29\128\87\135\30\17\40");
	v126[(170 - 59) + (1125 - (222 + 563))] = v134("\59\64\148\164\227\80\106\90\16\73\194\140\230\76\110\19\61\79\145\181\175\126\119\92\11\64\150", "\51\126\46\226\193\143\63\26");
	v126[(407 - 222) + 191 + 74] = v134("\192\34\199\255\53\232\239\25\165\156\17\244\245\5\238\176\14\226\243\92\200\190\23\235\229\29\252\191\11\169\216\7\231\190\22\194\239\36\200\190\13\233\245", "\135\129\114\139\209\120");
	v126[(1638 - (23 + 167)) - (2797 - (690 + 1108))] = v134("\221\39\219\59\237\252", "\136\142\75\178\95");
	v126[(612 + 1084) - (1030 + 218)] = v134("\217\178\38\254\197\254\168\61\186\146\232\178\36\254\222\248\182\52\254\198\254\253\36\173\215\177\169\57\183\193\177\158\62\177\222\245\178\38\176\141", "\178\145\221\81\222");
	v126[(1703 - (40 + 808)) - (68 + 340)] = v134("\45\233\38\67\193\14\139\7\253\45\73", "\222\116\156\74\44\175\46");
	v126[(252 - 186) + 364 + 16] = v134("\235\104\239\81\42\171\122\205\132\117\202\12\19\179\113\199\220\93\209\81\36\171\123\202\206\87\212\17\20\234\65\213\207\97\214\19\8\170", "\166\170\56\163\127\103\196\20");
	v126[26 + 22 + 218 + 179] = v134("\27\185\234\7\88\48\188\235", "\60\95\203\133\119");
	v126[(1261 - (47 + 524)) - (52 + 27 + (456 - 289))] = v134("\135\134\94\138\204\28\230\163\141\9\211\212\6\179\163\128\66\207\155\7\252\239\156\90\207\155\7\251\166\154\9\233\212\28\255\171\134\94\196\132", "\147\207\233\41\170\187\115");
	v126[(1630 - 539) - (1479 - 830)] = v134("\249\97\238\117\121\241\53\126\150\124\203\40\64\233\62\116\206\84\208\117\119\241\52\121\220\94\213\53\71\176\14\102\221\99\199\45\93\232\58\121", "\21\184\49\162\91\52\158\91");
	v126[(1750 - (1165 + 561)) + 13 + 404] = v134("\254\164\48\232\222\185\40\246", "\152\186\214\95");
	v126[(919 - 622) + 55 + 88] = v134("\247\14\214\107\110\186\202\13\197\107\96\186\202\65\205\34\114\176\159\21\206\107\108\166\218\65\213\35\112\166\159\34\206\36\117\177\208\22\207\116", "\213\191\97\161\75\25");
	v126[(708 - (341 + 138)) + 57 + 153] = v134("\31\22\10\233\11\179\114\109\41\24\229\7\253\66\36\13\29\161\55\174\116\42\6", "\21\77\99\121\129\98\221");
	v126[(3258 - 1679) - ((615 - (89 + 237)) + (2740 - 1888))] = v134("\201\192\35\145\197\32\1\180\166\221\6\204\252\56\10\190\254\245\29\145\203\32\0\179\236\255\24\209\251\97\58\172\237\194\37\232", "\223\136\144\111\191\136\79\111");
	v126[(275 - 144) + (1187 - (581 + 300))] = v134("\4\7\126\205\19\113\166\46", "\209\64\117\17\189\119\30");
	v126[(1631 - (855 + 365)) + (59 - 34)] = v134("\201\43\181\223\188\30\233\60\225\196\243\106\233\50\182\209\229\57\168\63\225\196\253\56\239\59\181\144\245\36\168\51\164\220\249\47\166", "\74\136\94\193\176\156");
	v126[(235 + 482) - (1517 - (1030 + 205))] = v134("\157\111\17\86\252\78\4\91\252\87\0\85\185\127", "\57\220\26\101");
	v126[259 + 16 + 148 + 11] = v134("\87\216\213\158\122\0\120\227\183\253\94\28\98\255\252\209\65\10\100\166\216\197\67\0\66\233\251\253\82\3\115\237", "\111\22\136\153\176\55");
	v126[(1150 - (156 + 130)) - ((956 - 535) + (16 - 6))] = v134("\217\163\188\36\25\251\78\238\191\182\41", "\59\154\203\217\71\114\185");
	v126[(2293 - 1173) - (182 + 506)] = v134("\244\228\233\235\243\63\27\71\207\248\248\163\247\62\27\79\207\227\233\185\224\57\75\82\143", "\38\161\151\140\203\146\76\59");
	v126[(395 + 282) - ((182 - (10 + 59)) + 38 + 95)] = v134("\155\189\204\174\4\175\188\200\226\45\189\167\218\174\53\189\238\250\235\55\161\160\205\174\61\160\186\204\252\38\187\190\221", "\84\206\206\169\142");
	v126[(733 - 584) + (1444 - (671 + 492))] = v134("\36\43\234\165\40\20\200\224\75\54\207\248\17\12\195\234\19\30\212\165\53\26\212\234\44\21\210", "\139\101\123\166");
	v126[286 + 73 + (1285 - (369 + 846))] = v134("\17\251\121\192\193\254\39\231\104\204\196", "\188\82\147\28\163\170");
	v126[(514 + 1426) - (760 + 130 + (2567 - (1036 + 909)))] = v134("\60\106\4\185\211\42\11\8\119\14\237\218\60\89\73\112\15\237\215\43\89\28\105\21\183", "\43\105\25\97\153\178\89");
	v126[(1220 + 314) - ((795 - 321) + (836 - (11 + 192)))] = v134("\218\25\213\184\236\234\13\195\239\197\234\26\144\249\211\175\57\213\251\207\225\14\144\241\206\251\15\194\234\213\255\30\143", "\160\143\106\176\152");
	v126[(969 + 947) - ((852 - (135 + 40)) + (1969 - 1156))] = v134("\219\196\2\66\255\245\250\37\66\255\243\231\58\27\215\251\226\43\30\156\214\241\41\63\197\255\241\62\37\220\238", "\178\154\148\78\108");
	v126[(720 + 473) - (1691 - 923)] = v134("\231\86\225\138\208\4\224\208\74\235\135", "\149\164\62\132\233\187\70");
	v126[(56 - 18) + (562 - (50 + 126))] = v134("\3\186\172\43\48\245\160\40\33\245\181\46\63\176\249\51\60\176\249\53\59\161\184\51\61\186\183\103\32\186\249\38\32\161\188\42\36\161\249\51\59\245\169\53\59\180\186\51\61\163\188\103\38\180\180\55\116\163\176\38\116\188\183\36\59\184\176\41\51\245\184\40\49\245\181\46\39\161\170\120", "\71\84\213\217");
	v126[(2010 - 1288) - (11 + 38 + (1663 - (1233 + 180)))] = v134("\211\162\38\87\224\164\32\64\230\240\27\87\238\160\32\88\228\239", "\54\131\208\73");
	v126[(2897 - (522 + 447)) - ((2060 - (107 + 1314)) + 403 + 464)] = v134("\124\195\25\164\112\252\59\225\19\222\60\249\73\228\48\235\75\246\39\164\109\225\58\235\94\231\60\252\88\193\52\231\77", "\138\61\147\85");
	v126[(746 - 501) + 75 + 101] = v134("\205\27\248\34\255\80\215\149\250\28\243", "\225\142\115\157\65\148\18\162");
	v126[(2142 - 1063) - ((783 - 585) + (2371 - (716 + 1194)))] = v134("\29\72\209\249\196\161\38\90\148\141\236\161\104\116\193\173\169\175\46\27\215\182\228\162\41\79\154", "\192\72\59\180\217\137");
	v126[(11 + 629) - (24 + 197)] = v134("\28\43\137\127\212\40\54\141\127\205\44\57\204\16\214\10\103", "\153\73\88\236\95");
	v126[(1480 - (74 + 429)) - (1077 - 518)] = v134("\145\156\158\24\32\162\190\167\252\123\4\190\164\187\183\87\27\168\162\226\159\87\3\172\132\169\179\121\34\142", "\205\208\204\210\54\109");
	v126[(522 + 530) - (1453 - 818)] = v134("\169\32\43\230\140\168\61\58\241\136\132", "\231\234\72\78\133");
	v126[262 + 107 + (144 - 97)] = v134("\102\71\231\53\193\63\228\21\81\231\116\214\60\161\86\77\230\123\193\119\194\84\81\231\59", "\129\53\34\147\21\181\87");
	v126[(3815 - 2272) - ((1290 - (279 + 154)) + (1049 - (454 + 324)))] = v134("\225\116\8\207\13\7\193\171\140\70\18\207\78\56\215", "\202\172\21\102\174\45\83\164");
	v126[(426 + 115) - ((64 - (12 + 5)) + 44 + 36)] = v134("\151\184\202\88\20\185\134\237\88\20\191\155\242\1\60\183\158\227\4\119\155\137\232\23\13\179\137\213\2\56\181\131", "\89\214\232\134\118");
	v126[(733 - 445) + 47 + 78] = v134("\19\248\29\215\227\49", "\62\64\148\116\179\134\67\71");
	v126[(3347 - (277 + 816)) - ((2409 - 1845) + (2461 - (1058 + 125)))] = v134("\150\251\174\100\177\246\191\100\136\206\250\48\173\236\191\55\173\241\182\32\229\234\181\100\134\255\169\48\235", "\68\197\158\218");
	v126[(251 + 1086) - ((1641 - (815 + 160)) + (1115 - 855))] = v134("\0\245\174\222\240\227\40\245\224\242\128\151\25\252\178\218\163\223\34\248\164", "\183\77\148\192\191\208");
	v126[(2603 - 1506) - (164 + 523)] = v134("\173\194\37\15\102\68\130\249\71\108\66\88\152\229\12\64\93\78\158\188\36\64\69\74\184\247\8\108\123", "\43\236\146\105\33\43");
	v126[(3224 - 2121) - (2592 - (41 + 1857))] = v134("\17\133\70\182\182\188", "\118\66\233\47\210\211\206\119");
	v126[(3386 - (1222 + 671)) - (2804 - 1719)] = v134("\26\160\25\199\83\141\165\105\141\61\199\83\141\178\44\182\5\136\75\129\224\61\170\77\164\70\150\180\103", "\192\73\197\109\231\39\229");
	v126[(1438 - 437) - (1776 - (229 + 953))] = v134("\38\143\204\254\171\17\131\138\213\191\5\143\201\184\150\50\198\254\240\172\7\149\194\247\178\6", "\222\98\230\170\152");
	v126[(2008 - (1111 + 663)) + (1751 - (874 + 705))] = v134("\232\41\20\86\247\161\7\194\87\21\17\201\186\30\204\24\46\29\200\224\45\192\31\62\13\201\171\36\200\30\49\27\242\158", "\105\169\121\88\120\186\206");
	v126[53 + 320 + 22 + 10] = v134("\205\225\229\114\251\255", "\22\158\141\140");
	v126[(117 - 60) + 10 + 337] = v134("\35\10\216\254\4\7\201\254\56\63\140\170\24\29\201\173\24\0\192\186\80\9\195\172\80\24\196\187\30\79\216\177\80\28\217\185\23\10\223\170\80\41\195\172\4\6\202\167\25\1\203\254\50\29\201\169\94\70", "\222\112\111\172");
	v126[(1869 - (642 + 37)) - (180 + 607)] = v134("\126\192\54\0\81\201\61\29\86\200\100\54\74\202\51\84\112\255\100\32\80\221\33\7\80\192\40\16", "\116\56\175\68");
	v126[30 + 155 + (544 - 327)] = v134("\251\196\134\111\142\213\250\161\111\142\211\231\190\54\166\219\226\175\51\237\252\251\184\53\170\220\237\163\47\164\248\230\175\54\139\234", "\195\186\148\202\65");
	v126[(1134 - (233 + 221)) - ((524 - 297) + 46 + 6)] = v134("\7\254\130\25\75\218", "\143\84\146\235\125\46\168\138");
	v126[(1753 - (718 + 823)) + 119 + 69] = v134("\64\233\91\179\222\14\250\51\196\127\179\222\14\237\118\255\71\252\198\2\191\117\227\93\179\221\14\250\125\172\91\252\138\21\234\116\235\74\224\222\70\219\114\225\95\246\196\70\215\114\254\66\189", "\159\19\140\47\147\170\102");
	v126[(981 - (266 + 539)) + (630 - 407)] = v134("\3\185\249\253\168\206\103\144\245\255\160\128\15\136\180\217\165\210\34\171\252\226\161\196", "\160\71\216\148\141\205");
	v126[(1268 - (636 + 589)) + (842 - 487)] = v134("\96\34\47\67\87\78\28\8\67\87\72\1\23\26\127\64\4\6\31\52\101\19\14\29\127\79\58\2\31\119\105\34", "\26\33\114\99\109");
	v126[(4093 - 2108) - (443 + 115 + 375 + 655)] = v134("\28\253\67\174\137\23", "\168\79\145\42\202\236\101\207");
	v126[(1275 - (657 + 358)) + (359 - 223)] = v134("\124\208\177\24\46\126\41\172\103\229\229\76\50\100\41\255\71\218\169\92\122\112\35\254\15\194\173\93\52\54\56\227\15\198\176\95\61\115\63\248\15\240\189\72\63\122\108\196\78\199\168\22", "\140\47\181\197\56\90\22\76");
	v126[(1533 - 860) - (1465 - (1151 + 36))] = v134("\132\74\6\68\32\11\100\160\64\27\1\4\123\12\149\90\4\68\63\67\67\173\86", "\44\193\50\118\33\76\43");
	v126[(1034 + 36) - (178 + 498)] = v134("\169\103\34\101\131\135\89\5\101\131\129\68\26\60\171\137\65\11\57\224\173\79\30\46\162\160\86\28\38\134\184", "\206\232\55\110\75");
	v126[(6429 - 4276) - ((3130 - (1552 + 280)) + (1296 - (64 + 770)))] = v134("\38\192\219\22\88\87", "\47\117\172\178\114\61\37\218");
	v126[231 + 109 + (117 - 65)] = v134("\251\60\222\13\143\33\220\72\235\60\214\72\221\48\222\9\198\59\218\6\200\117\199\7\143\32\192\13\143\23\220\6\202\49\198\27\219\117\241\26\202\34", "\104\175\85\179");
	v126[(214 + 986) - (2052 - (157 + 1086))] = v134("\28\250\177\185\185\39\45\225\255\151\184\53\126\193\139\152", "\82\94\149\223\220\221");
	v126[(2317 - 1159) - (3363 - 2595)] = v134("\201\225\139\49\23\139\254\227\159\133\109\63\147\253\233\194\179\122\40\202\196\220\245\233\93\53\138\245\236\196\180\107", "\144\136\177\199\31\90\228");
	v126[(284 - 98) + (276 - 73)] = v134("\51\2\130\54\8\79", "\39\96\110\235\82\109\61");
	v126[(1049 - (599 + 220)) + (314 - 156)] = v134("\104\179\217\194\167\72\181\148\227\238\89\250\198\194\234\93\179\218\206\233\91\250\192\200\167\73\169\209\135\194\68\170\216\200\227\85\180\211\135\204\89\189", "\135\60\218\180\167");
	v126[(3386 - (1813 + 118)) - (115 + 41 + (2129 - (841 + 376)))] = v134("\13\221\245\134\234\15\133\38\194\165\161\224\12\204\28\241\193", "\236\72\165\133\234\133\107");
	v126[(995 - 284) - (76 + 249)] = v134("\248\156\0\187\0\214\162\39\187\15\203\169\59\248\44\202\184\41\231\99\237\152\8\187\8\193\188\32\250\41\208\162\43\222\40\222", "\77\185\204\76\149");
	v126[(799 - 506) + (951 - (464 + 395))] = v134("\98\202\200\253\28\89", "\48\49\166\161\153\121\43\225");
	v126[(2669 - 1629) - (316 + 340)] = v134("\218\179\90\206\253\223\83\174\158\94\206\253\217\89\227\187\94\197\180\197\91\174\174\88\139\168\216\89\174\148\94\222\167\202\83", "\60\142\218\55\171\221\171");
	v126[(1454 - (467 + 370)) - ((353 - 182) + 47 + 16)] = v134("\10\94\68\252\37\88\17\210\16\115", "\134\68\55\49");
	v126[(5512 - 3904) - (192 + 1034)] = v134("\5\100\112\205\37\43\90\87\205\42\54\81\75\142\9\55\64\89\145\70\16\96\120\205\38\45\65\70\130\7", "\104\68\52\60\227");
	v126[(2668 - 1521) - ((1042 - (150 + 370)) + (1526 - (74 + 1208)))] = v134("\250\67\231\58\204\93", "\94\169\47\142");
	v126[(151 - 89) + (1508 - 1190)] = v134("\250\52\234\132\103\212\32\87\234\52\226\193\53\197\34\22\199\51\238\143\32\128\59\24\142\40\244\132\103\247\39\30\218\56\245\193\19\201\40\18\220\125\212\149\38\212\58\18", "\119\174\93\135\225\71\160\79");
	v126[44 + 17 + (708 - (14 + 376))] = v134("\158\217\182\252\25\187\145\139\225\27\172\195\255\219\8\168\197\170\237\92\157\229\155", "\124\201\177\223\136");
	v126[(1465 - 620) - (303 + 164)] = v134("\104\215\32\27\166\52\71\236\66\119\153\62\94\234\13\70\159\62\91\169\56\97\175\117\126\239\5\65\142\41\125\238\11\80\153\8\93\230\24\64\142", "\91\41\135\108\53\235");
	v126[(889 + 123) - (606 + 29)] = v134("\63\14\253\86\9\16", "\50\108\98\148");
	v126[(5019 - 3306) - (723 + 237 + (455 - (23 + 55)))] = v134("\225\205\41\11\212\9\232\203\179\39\87\252\17\235\193\238\17\64\235", "\134\160\157\101\37\153\102");
	v126[(670 - 387) + 62 + 30] = v134("\87\12\231\42\136\77\17\238\115\248\119\22\226\60\198\56\21\226\39\192\56\46\254\32\220\54", "\168\24\98\139\83");
	v126[58 + 6 + (480 - 170)] = v134("\8\248\96\230\247\54\183\99\230\236\48\183\88\250\235\44", "\152\88\151\20\143");
	v126[(533 + 1161) - (2222 - (652 + 249))] = v134("\81\8\201\141\165\208\42\255\62\26\247\198\159\210\37\231\100\61\247\141\184\208\48\253\127\54\210\202\156\215\8\225\99\44", "\148\16\88\133\163\232\191\68");
	v126[(353 - 221) + (2108 - (708 + 1160))] = v134("\22\170\129\243\62\128\145\228\33\173\138", "\144\85\194\228");
	v126[(694 - 438) + (209 - 94)] = v134("\115\146\109\126\105\102\134\123\49\61\93\199\120\125\62\83\158\106\49\40\18\147\120\99\46\87\147\57\120\39\18\138\124\125\44\87\201", "\73\50\231\25\17");
	v126[(1512 - (10 + 17)) - (251 + 864)] = v134("\145\151\188\137\23\229\80\72\240\175\173\138\82\212", "\42\208\226\200\230\55\177\49");
	v126[(3685 - (1400 + 332)) - ((2587 - 1238) + (2143 - (242 + 1666)))] = v134("\89\226\254\25\199\30\6\115\156\240\69\239\6\5\121\193\198\82\248\95\41\109\198\221\99\235\19\37\125\222\215\82", "\104\24\178\178\55\138\113");
	v126[(663 + 885) - (433 + 747)] = v134("\175\190\237\125\204\174\163\252\106\200\130", "\167\236\214\136\30");
	v126[295 + 51 + (961 - (850 + 90))] = v134("\203\159\72\236\91\31\235\136\28\229\20\25\170\139\90\229\18\19\164", "\107\138\234\60\131\123");
	v126[(214 - 91) + (1633 - (360 + 1030))] = v134("\13\110\41\16\19\33\88\46\59\59\16\65\85\112\34\120\50\13\67\16\75\45\119\125\62\85\19\80\52\36", "\57\76\27\93\127\51\117");
	v126[134 + 17 + (603 - 389)] = v134("\15\189\13\49\252\51\32\134\111\93\195\57\57\128\32\108\197\57\60\195\0\106\197\51\26\140\35\121\222\46\7\131\34", "\92\78\237\65\31\177");
	v126[(2737 - 747) - ((1823 - (909 + 752)) + (2687 - (109 + 1114)))] = v134("\46\250\232\226\51\200\24\230\249\238\54", "\138\109\146\141\129\88");
	v126[(4197 - 1904) - (171 + 267 + (1734 - (6 + 236)))] = v134("\250\220\33\28\221\209\48\28\225\233\117\72\193\203\48\79\193\214\57\88\137\223\58\78\137\202\48\80\207\153\61\89\200\213\38\18", "\60\169\185\85");
	v126[(474 + 277) - (314 + 75)] = v134("\221\252\23\122\237\236\65\100\226\225\9\51\221\252\23\51\201\224\7\117\171\221\49\51\223\253\19\118\248\253\14\127\239", "\19\139\149\97");
	v126[(3910 - 2252) - (2265 - 968)] = v134("\170\237\115\4\205\132\211\84\4\194\153\216\72\71\225\152\201\90\88\174\189\212\73\124\233\157\245\111", "\128\235\189\63\42");
	v126[(2045 - (1076 + 57)) - (17 + 86 + (1138 - (579 + 110)))] = v134("\241\162\20\91\160\232", "\168\162\206\125\63\197\154\81");
	v126[(102 + 1188) - (824 + 107)] = v134("\127\191\2\151\75\191\71\214\68\163\19\223\79\190\71\222\68\184\2\197\88\185\23\195\4", "\183\42\204\103");
	v126[57 + 50 + (658 - (174 + 233))] = v134("\198\97\84\101\225\228\236\60\255\107\66\44\194\165\255\46\179\65\84\38\222\235\250\125\250\124\69\32\195\247\235\45\231", "\93\147\18\49\69\177\133\158");
	v126[(6284 - 4034) - ((2546 - 1095) + 197 + 245)] = v134("\233\131\145\110\129\127\90\195\253\159\50\169\103\89\201\160\169\37\190\62\100\201\161\188\9\162\100", "\52\168\211\221\64\204\16");
	v126[(1368 - (663 + 511)) + 145 + 17] = v134("\160\42\235\40\24\13\56\151\54\225\37", "\77\227\66\142\75\115\79");
	v126[(413 + 1488) - ((1744 - 1178) + 594 + 386)] = v134("\38\18\178\169\46\200\87\218\29\14\163\225\42\201\87\210\29\21\178\251\61\206\7\207\93", "\187\115\97\215\137\79\187\119");
	v126[(2165 - 1245) - ((401 - 235) + 191 + 209)] = v134("\25\241\1\226\170\134\43\241\19\167\131\147\108\227\23\226\181\134\47\237\10\166\198\138\34\246\1\176\148\150\60\246\91", "\227\76\130\100\194\230");
	v126[(114 - 55) + 210 + 84] = v134("\251\157\131\83\247\162\161\22\148\143\189\24\205\160\174\14\206\168\189\83\246\168\168\46\205\168\170\13\243\163\187", "\125\186\205\207");
	v126[25 + 240 + (809 - (478 + 244))] = v134("\44\143\21\52\58\45\146\4\35\62\1", "\81\111\231\112\87");
	v126[(1454 - (440 + 77)) - (267 + 319)] = v134("\235\66\46\182\150\237\235\78\240\119\122\226\138\247\235\29\208\72\54\242\194\227\225\28\152\80\50\243\140\165\250\1\152\84\47\241\133\224\253\26\152\98\34\230\135\233\174\38\217\85\55\184", "\110\184\39\90\150\226\133\142");
	v126[(3531 - 2566) - ((1599 - (655 + 901)) + 107 + 465)] = v134("\255\207\79\66\55\154\255\94\85\54\154\255\111\7\15\210\197\90\84\51\213\219\91", "\91\186\183\63\39");
	v126[(927 + 283) - (582 + 279)] = v134("\224\5\11\186\236\58\41\255\143\23\53\241\214\56\38\231\213\48\53\186\228\45\55\241\205\29\38\230\204\29\23", "\148\161\85\71");
	v126[(8472 - 6369) - ((2790 - (695 + 750)) + (1400 - 990))] = v134("\54\35\160\230\164\97", "\110\101\79\201\130\193\19\127");
	v126[(737 - 259) - ((390 - 293) + (385 - (285 + 66)))] = v134("\247\9\216\217\152\6\192\212\217\4\223\128\221\9\209\205\193\71\221\206\152\4\219\205\218\6\192\128\207\15\209\206\152\20\219\204\215\73", "\160\184\103\180");
	v126[(719 - 410) + (1347 - (682 + 628))] = v134("\167\27\33\67\17\222\253\156\20\46\81\17\214\231\200\22\34\87\83\222\253\200\38\34\86\94", "\137\232\117\77\58\49\191");
	v126[(134 + 692) - (780 - (176 + 123))] = v134("\90\248\40\123\170\189\117\195\74\23\149\183\108\197\5\38\147\183\105\134\43\59\139\171\90\220\16\52\132\185\94\198\10\48\138\171\82\198\39\58\138\176\122\220\55\58\139\189", "\210\27\168\100\85\231");
	v126[(278 + 385) - (115 + 43 + (430 - (239 + 30)))] = v134("\121\8\83\92\138\120\21\66\75\142\84", "\225\58\96\54\63");
	v126[(399 + 1066) - (532 + 21 + (1006 - 437))] = v134("\28\79\172\173\15\198\43\72\50\66\171\244\74\201\58\81\42\1\169\186\15\196\48\81\49\64\180\250", "\60\83\33\192\212\47\167\95");
	v126[(2995 - 2035) - (933 - (306 + 9))] = v134("\15\168\29\234\77\132\52\178\16\240\6\197\41\168\81\240\2\136\34\167\5", "\229\64\198\113\147\109");
	v126[(3269 - 2332) - (104 + 492)] = v134("\169\239\88\85\128\135\209\127\85\143\154\218\99\22\172\155\203\113\9\227\167\209\120\2\140\156\203\117\24\166\173\209\122\30\160\145\246\122\56\162\133\221\117\15", "\205\232\191\20\123");
	v126[126 + 79 + 65 + 70] = v134("\103\217\18\66\196\227\14\210\80\222\25", "\166\36\177\119\33\175\161\123");
	v126[(874 - 568) + (1408 - (1140 + 235))] = v134("\176\77\51\116\196\80\49\49\128\77\59\49\130\75\44\49\151\84\59\125\136", "\17\228\36\94");
	v126[(963 + 550) - (1078 + 97)] = v134("\200\247\203\19\210\196\125\244\229\153\14\209\196\125\204\234\215\30\213\206\47\255\163\153\46\237\229", "\93\155\131\185\122\185\161");
	v126[(178 + 514) - (407 - (33 + 19))] = v134("\26\125\37\54\24\52\67\2\54\2\50\67\13\111\52\55\70\12\106\123\24\66\6\116\49\52\90\7\107\123\8\89\27\113\62\62\121\61\92", "\85\91\45\105\24");
	v126[(525 + 927) - ((3260 - 2172) + 13 + 15)] = v134("\51\57\113\237\82\190", "\193\96\85\24\137\55\204");
	v126[(2233 - 1094) - (754 + 50)] = v134("\27\161\170\174\108\235\46\111\172\174\174\108\249\46\61\232\180\187\41\243\45", "\65\79\200\199\203\76\159");
	v126[(1807 - (586 + 103)) - (72 + 712)] = v134("\30\201\165\235\238\25\200", "\186\77\140\227\203");
	v126[(4146 - 2799) - ((1955 - (1309 + 179)) + (986 - 439))] = v134("\245\100\94\116\118\33\218\95\60\13\82\32\208\67\115\54\80\43\198\26\81\53\84\34\208\91\101\52\72\96\231\113\84\14\111\10", "\78\180\52\18\90\59");
	v126[(924 + 1198) - ((1135 - 712) + 1033 + 334)] = v134("\75\137\181\239\49\44", "\233\24\229\220\139\84\94\97");
	v126[(4716 - 2496) - ((3723 - 1854) + (629 - (295 + 314)))] = v134("\50\228\183\8\70\249\181\77\2\228\191\77\0\226\168\77\21\253\191\1\10", "\109\102\141\218");
	v126[(1515 - 898) - (2249 - (1300 + 662))] = v134("\115\66\163\239\68\201\15\1\119\148\194", "\124\33\35\192\134\37\165");
	v126[(2898 - 1975) - (2349 - (1178 + 577))] = v134("\3\128\236\85\137\45\190\203\85\147\43\190\196\12\165\46\187\197\9\234\1\191\207\23\160\45\167\206\8\234\16\177\195\18\165\46\163\244\47\128", "\196\66\208\160\123");
	v126[(559 + 516) - ((534 - 353) + (1971 - (851 + 554)))] = v134("\230\44\80\186\39\149", "\225\181\64\57\222\66\231\132");
	v126[138 + 18 + (474 - 303)] = v134("\54\243\50\54\66\238\48\115\6\243\58\115\4\245\45\115\17\234\58\63\14", "\83\98\154\95");
	v126[(516 - 278) + (390 - (115 + 187))] = v134("\34\95\154\64\85\20\184\151\30\84\130\15\106\37\220", "\207\107\49\236\47\62\113\152");
	v126[(752 + 229) - (397 + 22 + (933 - 696))] = v134("\57\244\42\138\53\203\8\207\86\243\15\202\28\211\7\200\19\193\20\138\59\203\9\200\28\203\17\202\11\138\47\202\14\203\13\193\32\209\3\202\44\240\34", "\164\120\164\102");
	v126[(1226 - (160 + 1001)) + 227 + 32] = v134("\218\182\33\54\63\251", "\90\137\218\72\82");
	v126[(332 + 148) - (320 - 163)] = v134("\18\2\235\217\126\253\74\2\34\2\227\156\56\230\87\2\53\27\227\208\50", "\34\70\107\134\188\94\137\37");
	v126[(1070 - (237 + 121)) - (1287 - (525 + 372))] = v134("\251\92\238\236\203\80\246\232\212\25\193\230\214\93\247\224\204\25\214\221\252", "\137\184\57\130");
	v126[(322 - 152) + (495 - 344)] = v134("\113\235\241\247\243\187\229\91\149\234\176\208\176\252\81\215\214\188\204\250\200\95\212\209\189\209\163\229\67\149\254\182\208\176\254\89\207\233\141\250", "\139\48\187\189\217\190\212");
	v126[(261 - (96 + 46)) + (978 - (643 + 134))] = v134("\69\128\245\212\201\226", "\216\22\236\156\176\172\144\131");
	v126[(325 + 575) - (1393 - 812)] = v134("\31\169\64\166\29\56\236\68\172\9\108\184\67\227\11\63\169\12\183\22\37\191\12\128\58", "\126\76\204\44\195");
	v126[(6853 - 5007) - (27 + 1 + (2943 - 1443))] = v134("\165\52\213\184\90\18\146\48\213\253\106\20\136\53\204\180\93\91\179\34\216\186\76", "\123\230\81\185\221\41");
	v126[(641 - 327) + (722 - (316 + 403))] = v134("\19\106\47\201\106\61\84\8\201\112\59\84\7\144\70\62\81\6\149\9\17\85\12\139\67\61\77\13\148\9\17\85\13\131\82\59\78", "\39\82\58\99\231");
	v126[106 + 53 + (431 - 274)] = v134("\51\44\208\66\94\24\41\209", "\58\119\94\191\50");
	v126[(186 + 326) - ((480 - 289) + 5 + 1)] = v134("\133\245\118\19\181\228\58\30\185\231\58\2\185\176\111\5\179\176\110\30\191\227\58\53\146", "\118\214\144\26");
	v126[87 + 180 + (162 - 115)] = v134("\33\111\250\125\25\126\168\123\20\59\252\124\23\59\223\125\28\127\228\123\0\127\168\65\1\122\239\113", "\20\114\27\136");
	v126[(3448 - 2726) - ((485 - 251) + 11 + 164)] = v134("\52\228\98\194\56\219\64\135\91\227\71\130\17\195\79\128\30\209\92\194\54\219\65\128\17\219\89\130\6\154\125\152\7\221\69\137", "\236\117\180\46");
	v126[(94 - 46) + 13 + 251] = v134("\241\234\67\254\121\131\194\246", "\236\181\152\44\142\29");
	v126[(6790 - 4482) - ((923 - (12 + 5)) + (4237 - 3146))] = v134("\14\71\235\166\91\225\18\190\50\85\167\183\87\181\71\165\56\2\243\171\81\230\18\149\25", "\214\93\34\135\195\56\149\50");
	v126[(1410 - 749) - (745 - 394)] = v134("\8\29\210\250\42\91\41\92\228\224\42\80\63", "\55\90\124\177\147\75");
	v126[(3660 - 2184) - (229 + 896 + (2015 - (1656 + 317)))] = v134("\236\138\153\84\224\181\187\17\131\141\188\20\201\173\180\22\198\191\167\84\238\181\186\22\201\181\162\20\222\244\135\27\206\179\180\22\222", "\122\173\218\213");
	v126[(1010 + 123) - (662 + 163)] = v134("\219\90\13\152\72\4\232\70", "\107\159\40\98\232\44");
	v126[(3863 - 2410) - (5640 - 4494)] = v134("\136\226\73\216\209\34\135\72\180\240\5\201\221\118\210\83\190\167\81\213\219\37\135\99\159", "\32\219\135\37\189\178\86\167");
	v126[(470 - (5 + 349)) + (902 - 712)] = v134("\234\49\89\253\236\7\126\186\220", "\221\185\116\31");
	v126[(2673 - (266 + 1005)) - (723 + 374)] = v134("\220\221\100\7\3\235\243\230\6\126\39\234\249\250\73\69\37\225\239\163\107\70\33\232\249\226\95\71\61\170\206\200\110", "\132\157\141\40\41\78");
	v126[(64 - 45) + (375 - 90)] = v134("\24\0\39\244\56\29\63\234", "\132\92\114\72");
	v126[(2377 - (561 + 1135)) - (492 - 114)] = v134("\152\137\190\75\198\84\7\36\164\155\242\90\202\0\82\63\174\204\166\70\204\83\7\15\143", "\76\203\236\210\46\165\32\39");
	v126[(6925 - 4818) - ((1116 - (507 + 559)) + (4403 - 2648))] = v134("\134\66\38\196\15\35\149\151\89\53\197\68\19\198\174\75\53", "\181\207\44\80\171\100\70");
	v126[(4341 - 2937) - (1491 - (212 + 176))] = v134("\5\24\22\161\9\39\52\228\106\31\51\225\32\63\59\227\47\45\40\161\7\39\53\227\32\39\45\225\55\102\19\225\50\39\49\234\28\61\63\225", "\143\68\72\90");
	v126[(948 - (250 + 655)) + (700 - 443)] = v134("\12\239\133\240\196\83\203\38", "\188\72\157\234\128\160\60");
	v126[(247 - 105) + (245 - 88)] = v134("\241\203\4\24\71\248\171\200", "\197\188\164\102\123\40\141");
	v126[(2126 - (1869 + 87)) + (443 - 315)] = v134("\54\35\28\142\194\28\215\15", "\185\123\76\126\237\173\105");
	v126[(1998 - (484 + 1417)) + (428 - 228)] = v134("\157\11\241\99\199\125\178\48\147\26\227\124\184\44\220\33\225\119\174\117\254\34\229\126\184\52\202\35\249\60\145\52\223\46\229\103\178\47", "\18\220\91\189\77\138");
	v126[(255 - 102) + (916 - (48 + 725))] = v134("\153\16\164\216\30\96", "\78\202\124\205\188\123\18");
	v126[(2913 - 1129) - ((638 - 400) + 728 + 523)] = v134("\8\234\135\159\4\213\165\218\103\237\162\223\45\205\170\221\34\223\185\159\10\213\164\221\45\213\188\223\58", "\177\73\186\203");
	v126[(571 - 357) + 23 + 57] = v134("\60\185\50\190\61\184\62\240\2\175\35\190\0\172\119\215\29\175\58\237\73\171\37\251\73\175\57\255\11\166\50\250\71\234\30\216\73\158\37\247\7\161\50\234\73\163\36\190\8\234\49\241\27\169\50\250\73\166\56\249\0\169\119\234\27\163\57\245\12\190\119\242\0\161\50\190\36\171\57\247\10\234\56\236\73\139\36\246\12\185\123\190\29\162\62\237\73\167\54\231\73\168\50\190\0\173\57\241\27\175\51\176", "\158\105\202\87");
	v126[(655 + 1591) - ((910 - (152 + 701)) + (3207 - (430 + 881)))] = v134("\248\47\193\103\249\46\205\41\198\57\208\103\159", "\71\173\92\164");
	v126[71 + 113 + (1003 - (557 + 338))] = v134("\100\11\7\115\99\116\138\227\11\12\34\51\74\108\133\228\78\62\57\115\122\105\141\230\78\62\63\111\123\104\133\239\64", "\136\37\91\75\93\46\27\228");
	v126[44 + 104 + (402 - 259)] = v134("\128\47\52\32\168\5\36\55\183\40\63", "\67\195\71\81");
	v126[(493 - 352) + (395 - 246)] = v134("\57\197\6\248\57\52\5\216\8\189\25\102\5\208\67\145\25\35\1\197\67\185\31\35\76\211\13\185\15\42\9\210\77\248\36\0\76\226\17\177\3\45\9\194\67\177\30\102\13\150\5\183\31\37\9\210\67\180\2\33\5\213\67\172\31\47\2\221\6\172\77\42\5\221\6\248\32\39\2\223\0\248\2\52\76\247\16\176\8\53\64\150\23\176\4\53\76\219\2\161\77\36\9\150\10\191\3\41\30\211\7\246", "\70\108\182\99\216\109");
	v126[(2415 - 1294) - (1633 - (499 + 302))] = v134("\134\235\163\199\131\244\43\186\184\253\178\199\230", "\212\211\152\198\231\215\134\66");
	v126[(2136 - (39 + 827)) - (2710 - 1728)] = v134("\238\149\224\125\134\192\171\199\125\156\198\171\200\36\170\195\174\201\33\229\251\183\197\61\160\202\177\157\6\184\206\162\201", "\203\175\197\172\83");
	v126[(1027 - 567) - ((59 - 44) + (242 - 84))] = v134("\105\127\37\5\79\104\98\52\18\75\68", "\36\42\23\64\102");
	v126[(56 + 591) - ((111 - 73) + 52 + 271)] = v134("\226\36\109\37\91\64\194\51\57\62\20\52\240\33\107\47\26\112\131\28\118\30\56\58", "\20\163\81\25\74\123");
	v126[(289 - 106) + (206 - (103 + 1))] = v134("\225\246\147\4\128\215\134\9\128\197\136\25\128\206\136\63\227", "\107\160\131\231");
	v126[(1280 - (475 + 79)) - ((832 - 447) + (182 - 125))] = v134("\204\213\20\239\241\60\227\238\118\150\213\61\233\242\57\173\215\54\255\171\25\180\200\60\217\228\58\140\211\7\206", "\83\141\133\88\193\188");
	v126[18 + 115 + 133 + 17] = v134("\149\78\53\232\0\147\79\87\162\73\62", "\35\214\38\80\139\107\209\58");
	v126[(2341 - (1395 + 108)) - (1617 - 1061)] = v134("\155\29\183\163\33\232\59\185\165\52\188\0\185\191\117\191\1\179\191\117\166\6\162\241\60\166\73\181\190\56\170\8\162\238", "\85\200\105\214\209");
	v126[(1800 - (7 + 1197)) - (138 + 177)] = v134("\46\187\98\230\12\164\54\200\32\140", "\135\111\207\22");
	v126[(343 + 639) - ((427 - (27 + 292)) + (1740 - 1146))] = v134("\172\159\6\150\82\78\181\134\225\29\209\113\69\172\140\163\33\221\109\15\148\152\187\37\222\92\78\182\143\174\62", "\219\237\207\74\184\31\33");
	v126[(46 - 9) + (1014 - 772)] = v134("\160\24\77\41\43\157\28\151\4\71\36", "\105\227\112\40\74\64\223");
	v126[(230 - 113) + (306 - 145)] = v134("\255\189\12\68\161\113\223\170\88\95\238\5\223\164\15\74\248\86\158\169\88\95\224\87\217\173\12\11\232\75\158\165\29\71\228\64\144", "\37\190\200\120\43\129");
	v126[(1805 - (43 + 96)) - ((4266 - 3220) + (775 - 432))] = v134("\42\244\201\222\202\63\224\223\145\167\14\237\216\212", "\234\107\129\189\177");
	v126[(569 + 116) - (116 + 293)] = v134("\210\59\248\136\141\230\220\237\189\60\221\200\164\254\211\234\248\14\198\136\129\252\198\233\199\10\214\235\165\229\215\227", "\134\147\107\180\166\192\137\178");
	v126[(2181 - 1077) - (67 + 106 + (1229 - 573))] = v134("\214\239\92\196\181\251\210\210\225\232\87", "\166\149\135\57\167\222\185\167");
	v126[(431 + 935) - (81 + 1011)] = v134("\236\194\55\102\11\202\145\51\40\5\205\217\55\52\74\208\223\38\35\24\203\196\34\50\68", "\106\185\177\82\70");
	v126[(2719 - (1414 + 337)) - ((2373 - (1642 + 298)) + (682 - 420))] = v134("\220\74\52\131\44\174\77\216\229\64\34\202\15\239\94\202\169\106\52\192\19\161\91\153\224\87\37\198\14\189\74\201\253", "\185\137\57\81\163\124\207\63");
	v126[(2448 - 1597) - (1717 - 1138)] = v134("\145\232\102\124\242\191\214\65\124\232\185\214\78\37\222\188\211\79\32\145\128\217\88\51\246\190\204", "\191\208\184\42\82");
	v126[26 + 50 + 152 + 43] = v134("\233\238\41\5\192\121\108\222\242\35\8", "\25\170\134\76\102\171\59");
	v126[(2590 - (357 + 615)) - (69 + 28 + (3069 - 1818))] = v134("\157\69\121\199\116\59\178\200\166\89\104\143\112\58\178\192\166\66\121\149\103\61\226\221\230", "\169\200\54\28\231\21\72\146");
	v126[216 + 36 + (36 - 19)] = v134("\118\4\198\115\219\70\16\208\36\242\70\7\131\50\228\3\36\198\48\248\77\19\131\58\249\87\18\209\33\226\83\3\156", "\151\35\119\163\83");
	v126[(524 + 130) - (27 + 359)] = v134("\27\184\58\17\113\178\213\49\198\33\86\82\185\204\59\132\29\90\78\243\247\63\143\37\72\89\184\203\19\134\2", "\187\90\232\118\63\60\221");
	v126[24 + 14 + (1530 - (384 + 917))] = v134("\219\4\72\15\140\221\239\217\236\3\67", "\173\152\108\45\108\231\159\154");
	v126[(2037 - (128 + 569)) - ((2043 - (1407 + 136)) + (2461 - (687 + 1200)))] = v134("\234\0\52\196\82\139\194\97\241\53\96\144\78\145\194\50\209\10\44\128\6\133\200\51\153\22\37\136\64\195\207\36\216\9\51\202", "\65\185\101\64\228\38\227\167");
	v126[(3562 - (556 + 1154)) - ((235 - 168) + (1615 - (9 + 86)))] = v134("\43\227\163\245\22\4\170\162\245\4\21\170\131\245\6\93\200\160\250\22\93\194\133\188\36\21\248\176\239\24\18\230\177", "\112\125\138\213\156");
	v126[(630 - (275 + 146)) + 9 + 46] = v134("\208\21\153\237\133\247\223\250\107\130\170\166\252\198\240\41\190\166\186\182\231\248\51\131\170\190\208\225", "\177\145\69\213\195\200\152");
	v126[(123 - (29 + 35)) + (903 - 699)] = v134("\12\41\86\204\160\45", "\197\95\69\63\168");
	v126[(1809 - 1203) - ((273 - 211) + 184 + 98)] = v134("\230\50\213\237\193\63\196\237\253\7\129\185\221\37\196\190\221\56\205\169\149\49\206\191\149\32\201\168\219\119\213\162\149\36\212\170\210\50\210\185\149\19\192\160\197\50\207\237\253\54\211\160\155", "\205\181\87\161");
	v126[(1248 - (53 + 959)) + (433 - (312 + 96))] = v134("\247\77\47\26\189\77\147\100\35\24\181\3\251\124\98\62\176\81\214\95\42\5\180\71", "\35\179\44\66\106\216");
	v126[(2291 - 971) - ((842 - (147 + 138)) + (1402 - (813 + 86)))] = v134("\145\65\58\206\230\118\126\187\63\33\137\197\125\103\177\125\29\133\217\55\84\177\124\6\133\197\81\113\162\124\62\176", "\16\208\17\118\224\171\25");
	v126[(835 + 89) - (1231 - 566)] = v134("\222\51\221\218\161\107", "\25\141\95\180\190\196");
	v126[(1380 - (18 + 474)) - (213 + 417)] = v134("\183\70\44\64\13\140\70\120\40\41\196\87\48\18\28\151\75\55\12\29\196\87\55\64\58\133\80\44\78", "\121\228\35\88\96");
	v126[(3302 - 2290) - ((1346 - (860 + 226)) + (798 - (121 + 182)))] = v134("\25\231\226\44\249\46\235\164\7\237\58\231\231\106\196\13\174\208\34\254\56\253\236\37\224\57", "\140\93\142\132\74");
	v126[13 + 89 + (1394 - (988 + 252))] = v134("\6\217\213\64\101\30\173\44\167\206\7\70\21\180\38\229\242\11\90\95\135\46\239\255\27\91\20\142\38\238\240\13\96\33", "\195\71\137\153\110\40\113");
	v126[18 + 141 + 31 + 65] = v134("\64\139\61\54\118\149", "\82\19\231\84");
	v126[(3127 - (49 + 1921)) - (1793 - (223 + 667))] = v134("\133\93\214\56\188\77\179\24\234\72\232\81\190\74\199\107\160\74\186\92\130\126\167\87\246\79\202\125\166\5\162\87\130\107\189\66\177\93\209\108\232\99\185\74\214\113\174\92\191\86\197\56\138\87\179\79\140", "\37\214\56\162\24\200");
	v126[(268 - (51 + 1)) + (63 - 26)] = v134("\231\236\46\247\223\199\250\53\237\209\129\193\46\230\193\129\203\12\163\226\201\241\57\240\222\206\239\56", "\182\161\131\92\131");
	v126[(2473 - 1318) - (2028 - (146 + 979))] = v134("\21\41\149\60\233\37\52\116\122\46\176\124\192\61\59\115\63\28\171\60\226\37\40\107\61\31\160\123\202\45\24\109\49\14\145\66", "\31\84\121\217\18\164\74\90");
	v126[(328 + 832) - (1514 - (311 + 294))] = v134("\38\240\142\28\173\155", "\233\117\156\231\120\200");
	v126[(1946 - 1248) - (190 + 258)] = v134("\4\153\165\250\147\171\43\162\199\131\183\170\33\190\136\184\181\161\55", "\196\69\201\233\212\222");
	v126[(2548 - (496 + 947)) - ((1379 - (1233 + 125)) + 339 + 496)] = v134("\12\63\156\233\55\233\177\139\99\44\191\170\23\233\177\147", "\224\77\111\208\199\122\134\223");
	v126[(568 + 65) - (74 + 311)] = v134("\243\195\90\240\86\203\194\76\179\86\204\140\122\252\74\205", "\57\190\172\56\147");
	v126[(1991 - (963 + 682)) - (83 + 16)] = v134("\209\31\13\175\162\247\237\20\94", "\132\158\113\45\237\205");
	v126[(2302 - (504 + 1000)) - (372 + 180)] = v134("\173\32\252\47\192\248\129\33\169\12\219\186\141\60\252\33\192\245\142\42\179\21\193\233", "\154\226\78\220\98\175");
	v126[(583 + 57) - (38 + 357)] = v134("\56\53\170\84\24\57\233\118\2\53\254", "\25\119\91\138");
	v126[(3134 - 1008) - (609 + 103 + 681 + 489)] = v134("\37\16\204\47\238\211\31\24\212\43\238\239\0\89\251\40\161\236\22\22\207\41\189", "\128\114\121\184\71\206");
	v126[(1358 - (156 + 26)) - (538 + 395)] = v134("\70\193\106\54\67\82\199\113\50\7\126\223\112\45", "\99\17\168\30\94");
	v126[(2759 - 995) - ((1168 - (149 + 15)) + (1478 - (890 + 70)))] = v134("\29\230\246\231\37\249", "\134\92\138\129");
	v126[(680 - (39 + 78)) - (804 - (14 + 468))] = v134("\28\42\201\159\211\190\200\48", "\84\82\69\189\191\134\205\173");
	v126[(2832 - 1544) - ((293 - 188) + 487 + 456)] = v134("\164\1\244\99\168\62\214\38\203\19\202\40\146\60\217\62\145\52\202\18\172\63\204\40\151\35\205\61\145", "\77\229\81\184");
	v126[10 + 5 + 48 + 176] = v134("\226\116\86\218\217\104\87\207\223", "\191\171\26\34");
	v126[103 + 125 + 3 + 7] = v134("\63\96\31\171\80\17\94\56\171\74\23\94\55\242\124\18\91\54\247\66\55\94\39\224\111\12\69\35\241", "\29\126\48\83\133");
	v126[(3196 - 1526) - (1340 + 15 + (273 - 195))] = v134("\218\47\236\26\167\225\52\232\11", "\213\147\65\152\127");
	v126[(44 + 1662) - ((684 - (12 + 39)) + 779 + 58)] = v134("\219\237\215\205\252\237\207\207\235", "\161\152\130\184");
	v126[(2869 - 1942) - (2464 - 1772)] = v134("\89\219\105\202\85\228\75\143\54\198\76\151\108\252\64\133\110\238\87\187\81\229\81\129\106\249\80\148\108", "\228\24\139\37");
	v126[49 + 113 + 38 + 34] = v134("\208\87\7\14\154\211\195\229\237", "\149\153\57\115\107\232\161\182");
	v126[(232 - 140) + 94 + 47] = v134("\73\71\183\12\158\72\73\177\28\214\114\72\185", "\190\27\38\222\104");
	v126[(338 - 268) + (1872 - (1596 + 114))] = v134("\148\60\245\140\28\135\50\217\200\116\163\60\240\129\82\161", "\60\198\93\156\232");
	v126[(435 - 268) + (777 - (164 + 549))] = v134("\145\22\2\201\147\219\121\198\175\30\5\202", "\167\195\119\107\173\179\147\28");
	v126[(2382 - (1059 + 379)) - ((478 - 93) + 171 + 158)] = v134("\28\192\82\177\7\220\67\245", "\145\82\175\38");
	v126[(100 + 489) - (752 - (145 + 247))] = v134("\147\62\198\193\88\194\234\171\59\214\198\15\239\246\228\54\220\205\88\205\234\163\62\209", "\133\196\87\178\169\120\129");
	v126[140 + 30 + 27 + 31] = v134("\32\64\14\182\87\101\21\185\30\74", "\222\119\41\122");
	v126[(1654 - 1096) - (64 + 267)] = v134("\224\203\153\170\87\10\216\205\129\166\24\62\217\209", "\73\183\162\237\194\119");
	v126[179 + 28 + (30 - 11)] = v134("\48\90\165\75\23\90\189\73\0", "\39\115\53\202");
	v126[(724 - (254 + 466)) + (781 - (544 + 16))] = v134("\128\16\67\4\232\112\189\24", "\25\211\127\44\112\128");
	v126[(3470 - 2378) - ((1432 - (294 + 334)) + (317 - (236 + 17)))] = v134("\218\210\141\240\161\116\250\209\161\190\142", "\17\155\189\200\208\233");
	v126[(398 + 525) - (21 + 5 + (2538 - 1864))] = v134("\112\221\182\185\28\170\95", "\196\56\184\215\213\117");
	v126[(4237 - 3342) - (327 + 308 + 32 + 6)] = v134("\157\208\153\29\179\35\134\250\181\203", "\140\208\185\234\105\196\70\231");
	v126[(2756 - (413 + 381)) - (68 + 1542 + (278 - 147))] = v134("\131\224\18", "\76\215\180\86\71\92");
	v126[(4020 - 2472) - ((3059 - (582 + 1388)) + (406 - 167))] = v134("\89\246\43\37\40\235\222\111\225\60", "\173\27\132\78\82\69\138");
	v126[145 + 57 + (381 - (326 + 38))] = v134("\150\89\66\231\233\9\237\170\85\94", "\129\193\48\44\131\158\104");
	v126[(1014 - 671) - (178 - 53)] = v134("\102\116\231\199", "\92\43\27\137\172\105\220\110");
	v126[(743 - (47 + 573)) + 34 + 60] = v134("\216\186\17\2\228", "\103\136\219\127");
	v126[(2102 - 1607) - ((84 - 32) + (1894 - (1269 + 395)))] = v134("\81\252\80\197\217\106\231\84\212\251\125\224\71\197\197\108\209\76\193\197\118\247\72", "\171\24\146\36\160");
	v126[(941 - (76 + 416)) - ((676 - (319 + 124)) + (9 - 5))] = v134("\42\236\48\177\145\17\247\52\160\179\6\240\39\177\141\23", "\227\99\130\68\212");
	v126[(3097 - (564 + 443)) - ((1167 - 745) + (1915 - (337 + 121)))] = v134("\155\112\219\66\85\7\161\162\106\230\73\99\0\186\181\123\192\73\114\6\177\129\106\218\73\102\6\157\188\106\202\85\85\0\164\166", "\212\210\30\175\39\39\117");
	v126[(4274 - 2815) - ((925 - 647) + (2882 - (1261 + 650)))] = v134("\34\166\133\18\57\43\28\189\152", "\71\117\206\236\102\92");
	v126[(564 + 767) - ((482 - 179) + (2636 - (772 + 1045)))] = v134("\161\204\27\124\241\74\184\152\214\38\119\199\77\163\143\199\0\119", "\205\232\162\111\25\131\56");
	v126[21 + 121 + (210 - (102 + 42))] = v134("\236\80\191\255\21\215\75\187\238\34\211\91\185\227\19\205\87\165\253\53\196\87\175", "\103\165\62\203\154");
	v126[(3344 - (1524 + 320)) - ((1619 - (1049 + 221)) + (1100 - (18 + 138)))] = v134("\196\6\33\223\99\255\29\37\206\84\251\13\39\195\101\229\1\59\221\66\226\4\58", "\17\141\104\85\186");
	v126[(4814 - 2847) - ((2287 - (67 + 1035)) + (924 - (136 + 212)))] = v134("\201\20\240\243\8\233\19\227\249\40\219\21\241\242", "\92\136\97\132\156");
	v126[(2557 - 1955) - (266 + 65 + 61 + 5)] = v134("\6\5\219\7\135\3\17\32\21\219\33\189\22\6\53\2\218\24\167", "\99\71\112\175\104\211\98");
	v126[(2371 - (240 + 1364)) - (1645 - (1050 + 32))] = v134("\32\247\207\167\66\55\205\15", "\184\97\130\187\200\17\67");
	v126[(3606 - 2596) - (478 + 329)] = v134("\85\86\53\248\106\242\53\113\81\51\226\83\232", "\65\20\35\65\151\35\156");
	v126[(1081 - (331 + 724)) + 15 + 161] = v134("\126\244\216\53\223\30\66\234\216", "\108\55\154\172\80\173");
	v126[(2775 - (269 + 375)) - ((1006 - (267 + 458)) + 513 + 1136)] = v134("\4\21\228\47\64\88\179\169\44\14\200\18\89\73\183\173\59\9\231\47", "\223\73\124\151\91\55\61\210");
	v126[(132 - 63) + (949 - (667 + 151))] = v134("\98\84\143\0\11\178\133\119", "\205\39\39\236\97\123\215");
	v126[(2993 - (1410 + 87)) - ((3047 - (1504 + 393)) + (397 - 250))] = v134("\221\31\191\142\175\187\16\187\37\134", "\100\137\109\214\224\196\222");
	v126[(287 - 176) + (883 - (461 + 335))] = v134("\53\155\189\19\117\4\157\229\53\78", "\30\97\233\212\125");
	v126[24 + 163 + (1771 - (1730 + 31))] = v134("\53\186\171\120\180\125\79\5\186\188", "\32\98\211\223\16\148\49");
	v126[(2012 - (728 + 939)) - (527 - 378)] = v134("\44\200\127\135\228\239\199\74\239\101\140", "\179\120\186\22\233\143\138");
	v126[(304 - 154) + (102 - 57)] = v134("\69\48\162\211\129\228\202\226\123\58", "\133\18\89\214\187\161\168\165");
	v126[(2032 - (138 + 930)) - (329 + 30 + 322 + 89)] = v134("\56\251\75\60\7\236\86\99\57\250\71", "\82\108\137\34");
	v126[(296 + 49) - (620 - 468)] = v134("\112\141\213\146\174\165\194\72\172\243", "\173\38\228\163\203\219\201");
	v126[(2050 - (459 + 1307)) - (1962 - (474 + 1396))] = v134("\47\242\165\130\60\192\148", "\199\122\129\192");
	v126[(1233 - 526) - (484 + 32)] = v134("\249\126\158\233\48\30\140\174\253\88\174\229", "\220\191\45\221\156\66\109\227");
	v126[1 + 97 + (263 - 171)] = v134("\232\254\230\71\150\179\32\194", "\165\174\173\171\40\224\218\78");
	v126[21 + 143 + (83 - 58)] = v134("\214\237\210\255\8\230\193", "\105\133\170\129\139");
	v126[(6144 - 4735) - ((1764 - (562 + 29)) + 41 + 7)] = v134("\39\225\236\191\9\44\142\40\215\239\165\9\29", "\224\126\148\128\208\103\105");
	v126[(3178 - (374 + 1045)) - (1079 + 284 + (648 - 439))] = v134("\211\45\218\25\233\244\235\35\199\18", "\184\132\68\174\113\201");
	v126[(1057 - (448 + 190)) - (76 + 157)] = v134("\74\85\50\38\211\166", "\93\31\38\87\96\178\195\232");
	v126[(141 + 170) - (59 + 31 + (138 - 102))] = v134("\245\93\0\57\67\115\254\197\93\23", "\145\162\52\116\81\99\63");
	v126[(3619 - 2454) - ((2300 - (1307 + 187)) + (693 - 518))] = v134("\51\196\199\29\14\222\200\55", "\94\102\183\162");
	v126[(2350 - 1346) - ((640 - 431) + (1295 - (232 + 451)))] = v134("\97\200\225\253\22\237\250\242\95\194", "\149\54\161\149");
	v126[(1825 + 86) - (295 + 38 + (1960 - (510 + 54)))] = v134("\179\80\185\247\50", "\89\230\35\220\164\117\17");
	v126[(1533 - 772) - (616 - (13 + 23))] = v134("\108\36\65\118\27\1\90\121\82\46", "\30\59\77\53");
	v126[(21 - 10) + (242 - 73)] = v134("\29\84\141\239\202\201\39\73", "\165\72\39\232\182\191");
	v126[(915 - 411) - ((1226 - (830 + 258)) + (659 - 472))] = v134("\128\163\222\13\247\134\197\2\190\169", "\101\215\202\170");
	v126[(202 + 120) - (123 + 21)] = v134("\188\217\221\227\253\100\128\220\217\221", "\18\233\170\184\177\152");
	v126[(1581 - (860 + 581)) + (136 - 99)] = v134("\204\63\150\78\239\101\10\129\242\53", "\230\155\86\226\38\207\41\101");
	v126[(1221 + 317) - ((319 - (237 + 4)) + (3017 - 1733))] = v134("\78\9\27\156\140\76", "\198\27\122\126\206");
	v126[(5477 - 3312) - ((1437 - 679) + 1009 + 223)] = v134("\169\220\204\252\166\70\94\66\153", "\44\234\179\163\144\194\41\41");
	v126[97 + 71 + (22 - 16)] = v134("\156\236\6\247\249\57\171", "\87\223\175\69\152\140");
	v126[(415 + 552) - (217 + 181 + (1822 - (85 + 1341)))] = v134("\159\55\151\40\194\202\187", "\207\217\100\212\71\183\164");
	v126[(1856 - 768) - ((1584 - 1023) + (727 - (45 + 327)))] = v134("\133\236\3\182\193\239\169\241\4\168", "\172\198\132\106\220\168");
	v126[(543 - 255) - (619 - (444 + 58))] = v134("\198\56\78\205\55\42\127\204\241\57", "\185\159\77\34\162\89\105\16");
	v126[(844 + 1096) - (5 + 22 + 853 + 890)] = v134("\227\128\205\20\61\113\221\166\212\8\37\100", "\16\177\229\187\125\75");
	v126[(2092 - 1370) - (2285 - (64 + 1668))] = v134("\73\170\106\228\237\22\47\111", "\65\27\224\61\167\130\99");
	v126[(3380 - (1227 + 746)) - ((457 - 308) + (2022 - 932))] = v134("\218\40\1\77\78\210\60", "\72\137\111\66\34\59\188");
	v126[(568 - (415 + 79)) + 3 + 90] = v134("\5\31\203\205", "\74\70\92\131\157");
	v126[(644 - (142 + 349)) + 6 + 7] = v134("\97\0\225\129", "\33\39\83\169\209\74\202");
	v126[(734 - 200) - (184 + 185)] = v134("\50\213\141\55\179\152\77", "\92\113\189\228\93\218\208\29");
	v126[(1488 + 623) - ((4607 - 2915) + (2119 - (1710 + 154)))] = v134("\133\146\248\240\50\192\140", "\136\220\231\148\159\92");
	v126[(567 - (200 + 118)) - (35 + 51)] = v134("\39\235\21\64\3\116\25\198\51", "\21\117\142\99\41\117");
	v126[(259 - 110) + (19 - 6)] = v134("\8\157\140\26\10", "\82\90\215\219");
	v126[(414 + 51) - (301 + 3)] = v134("\230\22\152\56", "\42\181\81\208\104\219\137");
	v126[67 + 56 + 6 + 31] = v134("\107\253\202\177\247\75\124", "\36\57\156\163\213\182");
	v126[(589 - 317) - (1363 - (363 + 887))] = v134("\98\221\124\100", "\101\46\158\52\52\224");
	v126[(2654 - 1134) - ((4988 - 3940) + 49 + 265)] = v134("\34\7\134\206\224\94\30\5\165\194\228\67\63\45\171", "\55\112\98\232\171\151");
	v126[(4962 - 2841) - (1024 + 474 + (2130 - (674 + 990)))] = v134("\201\14\247\32\213\24\245\12\212\44\209\5\211\59", "\113\155\107\153\69\162");
	v126[(330 + 820) - (282 + 406 + (484 - 178))] = v134("\183\180\107\206\209\181\38\121\152\149\77", "\31\225\221\29\152\184\195\79");
	v126[(1608 - (507 + 548)) - (1235 - (289 + 548))] = v134("\131\137\40\85\179\153\22\108", "\60\213\224\94");
	v126[(1933 - (821 + 997)) + (294 - (195 + 60))] = v134("\175\216\216\174\71\227\5\190\240\250\171\126\223\31\186\218\207\154\75\226", "\113\234\182\174\227\46\144");
	v126[(199 + 540) - ((1738 - (251 + 1250)) + (1021 - 672))] = v134("\161\199\252\122\9\104\210\50\180", "\122\228\169\138\55\96\27\166");
	v126[(877 + 399) - ((1151 - (809 + 223)) + (1466 - 461))] = v134("\230\119\220\142\100\55\213\122\220\132\75", "\82\180\22\181\234\44");
	v126[(1654 - 1103) - (1322 - 922)] = v134("\38\88\41\66\185\207\17", "\161\101\27\106\45\204");
	v126[(221 + 79) - (55 + 49 + (663 - (14 + 603)))] = v134("\96\104\29\118\42\174\28", "\104\38\59\94\25\95\192");
	v126[(940 - (118 + 11)) - (85 + 438 + 116 + 23)] = v134("\201\61\37\7\116\201\58\57\3\105", "\29\138\85\76\109");
	v126[(1206 - 792) - (1215 - (551 + 398))] = v134("\72\73\70\50\115\153\14\100\82\94", "\97\17\60\42\93\29\218");
	v126[(637 + 370) - (204 + 367 + 235 + 54)] = v134("\78\63\168\68\250\73\112\25\177\88\226\92", "\40\28\90\222\45\140");
	v126[(1056 - 772) - (317 - 179)] = v134("\190\231\61\0\131\216\4\55", "\67\236\173\106");
	v126[19 + 38 + (349 - 261)] = v134("\196\99\205\119\226\74\250", "\24\151\36\142");
	v126[9 + 22 + (202 - (40 + 49))] = v134("\112\23\236\45", "\165\51\84\164\125\236\167");
	v126[(1138 - 839) - (646 - (99 + 391))] = v134("\131\206\173\240", "\184\197\157\229\160");
	v126[(220 + 45) - (540 - 417)] = v134("\36\201\26\11\238\157\28", "\76\103\161\115\97\135\213");
	v126[(2520 - 1502) - (64 + 1 + (2136 - 1324))] = v134("\201\81\42\9\22\216\116", "\120\144\36\70\102");
	v126[(1684 - (1032 + 572)) + (477 - (203 + 214))] = v134("\102\207\167\166\220\179\88\226\129", "\210\52\170\209\207\170");
	v126[(2249 - (568 + 1249)) - (230 + 63)] = v134("\64\81\143\158\238", "\190\18\27\216\214");
	v126[(4 - 2) + (525 - 389)] = v134("\44\241\55\153", "\79\127\182\127\201\150");
	v126[(1440 - (913 + 393)) + (8 - 5)] = v134("\162\82\17", "\74\227\61\84\230\112\195\118");
	v126[(77 - 22) + (491 - (269 + 141))] = v134("\174\21\231\55", "\237\226\86\175\103");
	v126[(3038 - 1672) - ((2753 - (362 + 1619)) + (2084 - (950 + 675)))] = v134("\52\19\18\51\17\31\18\49\43\31\15\34\41\57\63", "\86\102\118\124");
	v126[39 + 62 + (1212 - (216 + 963))] = v134("\57\164\50\56\187\140\5\166\17\52\191\145\35\145", "\229\107\193\92\93\204");
	v126[(1329 - (485 + 802)) + (650 - (432 + 127))] = v134("\146\247\59\79\40\160\173\248\52\81\17", "\214\196\158\77\25\65");
	v126[(1074 - (1065 + 8)) + 73 + 58] = v134("\8\182\52\51\56\166\10\10", "\90\94\223\66");
	v126[(1721 - (635 + 966)) + 8 + 3] = v134("\136\40\51\35\180\8\25\153\0\17\38\141\52\3\157\42\36\23\184\9", "\109\205\70\69\110\221\123");
	v126[(185 - (5 + 37)) - ((19 - 11) + 3 + 2)] = v134("\249\189\190\145\14\207\167\128\140", "\103\188\211\200\220");
	v126[(126 - 46) + 23 + 26] = v134("\253\205\181\91\214\219\207", "\191\181\168\212\55");
	v126[(226 - 117) + (71 - 52)] = v134("\127\198\189\220\14\247\66\206\159\193\21\234\109\221\128\201\8\249\73", "\158\44\169\210\168\102");
	v126[(708 - 332) - (594 - 345)] = v134("\115\179\197\199\10\73\178\205\254\11\83\168\226\227", "\98\32\220\170\179");
	v126[(167 + 64) - (634 - (318 + 211))] = v134("\113\118\219\38\200\210\252\87\127\219\44\252", "\147\35\23\178\66\155\189");
	v126[(49 - 39) + (1702 - (963 + 624))] = v134("\225\73\32\42\1\219\72\40\19\0\193\82\14\42\59\211\72\40\59", "\105\178\38\79\94");
	v126[(584 + 782) - ((1123 - (518 + 328)) + (2249 - 1284))] = v134("\66\94\70\232\13\216\127\86\100\245\22\197\89\97", "\177\17\49\41\156\101");
	v126[(764 - 285) - (673 - (301 + 16))] = v134("\96\94\70\187\37\90\95\78", "\77\51\49\41\207");
	v126[(826 - 544) - (449 - 289)] = v134("\217\176\71", "\56\152\222\62\38\46\114");
	v126[(187 - 115) + 45 + 4] = v134("\128\230\218\172\115\183\207\44", "\72\211\131\182\201\16\195\170");
	v126[(155 + 117) - ((14 - 7) + 88 + 57)] = v134("\57\162\98\129\6\163\68\137\7\166", "\232\105\205\22");
	v126[6 + 47 + (209 - 143)] = v134("\187\127\90\165\160", "\110\235\16\45\192\210");
	v126[(113 + 237) - (1251 - (829 + 190))] = v134("\123\175\189\214\123\44\241\76", "\148\40\202\209\179\24\88");
	v126[(296 - 213) + (42 - 8)] = v134("\24\172\229\69\76\6\28\186\225\73", "\104\72\195\145\44\35");
	v126[(491 - 135) - ((96 - 57) + 48 + 153)] = v134("\254\96\33\184\115\218\123\56\188\66\207\127\62", "\16\174\18\78\217");
	v126[(529 + 1089) - ((1827 - 1225) + 851 + 50)] = v134("\150\79\5\95\131\91\19\125\178\86\20\85", "\48\215\58\113");
	v126[(626 - (520 + 93)) + (377 - (259 + 17))] = v134("\1\205\192\234\84\63\216", "\29\81\172\178\139");
	v126[(95 + 1544) - (218 + 387 + (3118 - 2197))] = v134("\245\76\189\5\82\187\137\51\240\71\174", "\67\185\41\218\86\37\222\236");
	v126[(668 - (396 + 195)) + (101 - 66)] = v134("\125\235\216\33\17\235\238\127\197\245", "\143\48\138\182\64\69\142");
	v126[(3252 - (440 + 1321)) - ((2561 - (1059 + 770)) + (2996 - 2348))] = v134("\116\127\1\31\56\92\127\60\10\13\90\117", "\108\57\30\111\126");
	v126[(587 - (424 + 121)) + 13 + 55] = v134("\167\254\48\15\194\143\254\19\62", "\150\234\159\94\110");
	v126[(2382 - (641 + 706)) - (214 + 324 + (828 - (249 + 191)))] = v134("\30\52\62\81\15\44\63\16\57\80\19\60\18\13", "\95\90\93\88\55\122");
	v126[(8412 - 6481) - (355 + 438 + (3969 - 2939))] = v134("\103\194\24\93\129\190\88\196\4\78\170\170\68\218\34\121", "\216\33\173\106\41\232");
	v126[(784 - (183 + 244)) - (13 + 237)] = v134("\146\196\93\237\229\135\202\77\186\244\125", "\63\215\188\45\136\137\207\171");
	v126[(891 - (434 + 296)) - (175 - 120)] = v134("\52\126\52\46\227\4\210\55\2\114\17\14", "\86\112\31\89\94\134\106\154");
	v126[(818 - (169 + 343)) - (177 + 24)] = v134("\244\78\63\32\89\174\49\207\66\62", "\80\185\39\76\84\46\203");
	v126[(2753 - 1188) - ((575 - 379) + 1037 + 228)] = v134("\48\114\16\163\10\174\197\9\104\52\163\10\191\213\23\104\39\174\25\178\222\28\112", "\176\121\28\100\198\120\220");
	v126[(862 - 558) - (1324 - (651 + 472))] = v134("\58\170\146\218\12\220\15\3\176\182\218\12\205\31\29\176", "\122\115\196\230\191\126\174");
	v126[31 + 9 + 27 + 35] = v134("\80\244\92\21\1\37\108\234\92\57\29\19\108\244\79\21\28\57\76\233\77\35\7\34\119\219\91\57\29\35\124\232\90\5\3\35", "\87\25\154\40\112\115");
	v126[(555 - 100) - (837 - (397 + 86))] = v134("\205\226\208\203\133\86\243\249\205", "\58\154\138\185\191\224");
	v126[(2028 - (423 + 453)) - (39 + 339 + 89 + 585)] = v134("\168\238\46\5\51\147\245\42\20\8\143\196\47\14\38\132\239\52", "\65\225\128\90\96");
	v126[(233 + 33) - (134 + 33)] = v134("\84\55\100\230\111\43\101\243\105\28\102\230\111\32\100\235\116\55\119\209\124\48\116", "\131\29\89\16");
	v126[(1368 + 163) - ((1658 - (50 + 1140)) + 835 + 130)] = v134("\218\70\22\231\210\21\18\227\92\39\244\197\21\30\231\64\11\236\199\52\8\255\71", "\103\147\40\98\130\160\103");
	v126[(113 + 78) - (6 + 88)] = v134("\113\239\181\74\35\200\12\170\85\238\146\81\2\199", "\205\48\154\193\37\119\169\126");
	v126[(373 - 113) - (119 + 45)] = v134("\146\152\93\194\96\178\159\78\200\64\154\131\93\200\70\161\152\89\217", "\52\211\237\41\173");
	v126[(630 - (157 + 439)) + (105 - 44)] = v134("\40\85\64\125\152\29\85\90", "\203\105\32\52\18");
	v126[(1701 - 1189) - ((1020 - 675) + (991 - (782 + 136)))] = v134("\44\75\163\65\6\205\25\91\165\92\58\211\25", "\163\109\62\215\46\79");
	v126[(935 - (112 + 743)) + (1184 - (1026 + 145))] = v134("\201\228\166\26\203\32\42\240\254", "\95\128\138\210\127\185\82");
	v126[(38 + 178) - (842 - (493 + 225))] = v134("\24\243\112\57\230\31\14\19\42\232\65\20\255\10\7\10\61\239\110\41", "\120\79\154\30\93\145\126\98");
	v126[(915 - 666) - (97 + 61)] = v134("\196\90\182\67\118\244\230\35\211", "\119\151\46\196\42\29\145\178");
	v126[(704 - 441) - (4 + 169)] = v134("\131\22\187\36\255\175\32\184\46\250\158\44\137", "\148\202\120\205\75");
	v126[(5021 - 3264) - (105 + 255 + (2184 - 876))] = v134("\43\94\132\64\24\83\148\125\45\123", "\41\121\63\231");
	v126[(1769 - (210 + 1385)) - (1775 - (1201 + 488))] = v134("\1\130\61\21\34\246", "\168\82\199\123\65\118\178\32");
	v126[(552 + 338) - ((890 - 389) + (540 - 238))] = v134("\128\219\249\75\244\214\182\151\224\211", "\194\195\180\151\47\129\191");
	v126[(594 - (352 + 233)) + (185 - 108)] = v134("\240\187\207\206\195\228\189\212\202\135\200\165\213\213", "\227\167\210\187\166");
	v126[(82 + 68) - (184 - 119)] = v134("\127\37\254\130\180\85\62", "\193\60\74\144\230");
	v126[(608 - (489 + 85)) + (1551 - (277 + 1224))] = v134("\118\6\89\166\96\232\78\0\65\170\47\220\79\28", "\171\33\111\45\206\64");
	v126[(1837 - (663 + 830)) - (230 + 31)] = v134("\64\230\178\194\14\53", "\80\19\146\192\171\101");
	v126[(4194 - 2481) - ((1095 - (461 + 414)) + 237 + 1174)] = v134("\39\45\54\219\80\7\45\220\28\32\45\196\30\55", "\179\112\68\66");
	v126[(136 + 202) - (25 + 232)] = v134("\218\246\124\83\254\11\58", "\73\136\151\31\58\159\103");
	v126[64 + 0 + (266 - (172 + 78))] = v134("\25\181\184\36\76\13\179\163\32\8\33\171\162\63", "\108\78\220\204\76");
	v126[(253 - 96) - (29 + 49)] = v134("\230\81\22", "\143\181\20\80\232");
	v126[(93 - 28) + 4 + 9] = v134("\159\29\73\212\149\139\27\82\208\209\167\3\83\207", "\181\200\116\61\188");
	v126[(52 + 103) - (130 - 52)] = v134("\54\170\252\222\139\8\209\10\161\228", "\137\127\196\138\177\224\109");
	v126[(1986 - 407) - (131 + 387 + 545 + 440)] = v134("\158\189\227\38\70\100\189\166", "\17\211\210\129\69\41");
	v126[7 + 10 + (230 - 172)] = v134("\203\234\166\217\29\135\255\235\186", "\232\136\133\201\181\121");
	v126[(78 - 44) + 13 + 27] = v134("\225\32\166", "\129\160\78\223\27\189\48\67");
	v126[(64 + 47) - (485 - (133 + 314))] = v134("\20\194\229\24\130\223\118\35", "\19\71\167\137\125\225\171");
	v126[11 + 51 + (223 - (199 + 14))] = v134("\33\82\195\15\168\29\147\16\83\220", "\193\113\61\183\102\199\115");
	v126[(601 - 433) - (1646 - (647 + 902))] = v134("\249\234\44\203\29", "\211\169\133\91\174\111\155\129");
	v126[(393 - 262) - (294 - (85 + 148))] = v134("\45\235\132\252\128\10\235\140", "\227\126\142\232\153");
	v126[(1308 - (426 + 863)) + (234 - 184)] = v134("\245\141\7\184\127\201\241\155\3\180", "\167\165\226\115\209\16");
	v126[(1672 - (873 + 781)) + (66 - 16)] = v134("\99\4\176\117\118\82\2\235\78\110\86\17\188", "\29\55\118\217\27");
	v126[(3394 - 2137) - (32 + 43 + (4119 - 3004))] = v134("\221\44\67\163\1\168\160\184\11\89\172\13\168", "\212\137\94\42\205\106\205");
	v126[(210 - 63) - (240 - 159)] = v134("\119\236\212\52\49\192\124\123\246\244\24", "\30\54\153\160\91\101\161");
	v126[(1994 - (414 + 1533)) + 16 + 2] = v134("\206\187\14\93\123\194\161\23\80\124\245", "\29\129\206\122\50");
	v126[(619 - (443 + 112)) + (1479 - (888 + 591))] = v134("\112\249\105\92\9\80\238\80\86\49\84\233", "\93\49\140\29\51");
	v126[(428 - 262) - (6 + 97)] = v134("\117\66\63\198\108\77\57", "\167\37\35\77");
	v126[(188 - 138) + 5 + 7] = v134("\84\121\50\13\111\121\48\46\81\114\33", "\94\24\28\85");
	v126[(45 + 46) - (4 + 26)] = v134("\18\10\5\43\72\120\50\14\2\54\117\121", "\23\70\111\118\95\26");
	v126[(430 - 204) - (307 - 141)] = v134("\15\178\96\145\233\154\17\139", "\236\89\219\22\199\128");
	v126[(1844 - (136 + 1542)) - (350 - 243)] = v134("\12\84\20\191\252\54\171\36\41\90\27\186\193\21", "\105\72\61\114\217\137\69\206");
	v126[(1728 + 13) - ((37 - 13) + 1201 + 458)] = v134("\136\13\181\82\56\93\132\13\170\79\21\99", "\51\204\108\216\34\93");
	v126[(739 - (68 + 418)) - (531 - 335)] = v134("\233\119\67\106\131\91\207\198\118\86\92\152\88\193\231\72", "\182\175\24\49\30\234\61");
	v126[(86 - 38) + 7 + 1] = v134("\252\47\228\171\56\243\101\15\254", "\96\181\72\138\196\74\150\49");
	v126[(1098 - (770 + 322)) + 3 + 46] = v134("\26\208\52\242\196\123\59\204\50\227\251\125\39\223\25\247\231\99\10\252", "\20\73\184\91\133\130");
	v126[13 + 31 + 2 + 8] = v134("\119\75\33\90\87\67\35\85\69\80", "\62\32\34\79");
	v126[(198 - 59) - (166 - 80)] = v134("\7\10\35\222\239\21\214\62\16\7\222\239\4\198\32\16\20\211\252\9\205\43\8", "\163\78\100\87\187\157\103");
	v126[(2192 - 1387) - ((2166 - 1577) + 92 + 72)] = v134("\125\58\228\3\82\152\2\68\32\192\3\82\137\18\90\32", "\119\52\84\144\102\32\234");
	v126[(69 - 22) + 2 + 2] = v134("\160\21\243\238\155\9\242\251\157\50\233\207\156\21\224\238\134\21\210\248\140\40\243\254\135\58\244\194\135\15\226\249\155\14\247\255", "\139\233\123\135");
	v126[14 + 8 + 22 + 6] = v134("\43\160\19\238\121\62\246\15\188", "\159\124\200\122\154\28\82");
	v126[(4526 - 3324) - ((570 - 159) + 251 + 491)] = v134("\16\73\92\75\174\43\82\88\90\149\55\99\93\64\187\60\72\70", "\220\89\39\40\46");
	v126[(2326 - 1821) - ((1275 - 889) + 30 + 41)] = v134("\81\48\161\122\54\106\43\165\107\1\110\59\167\102\48\112\55\187\120\22\121\55\177", "\68\24\94\213\31");
	v126[(113 - 90) + (855 - (762 + 69))] = v134("\218\171\69\235\34\9\192\227\177\116\248\53\9\204\231\173\88\224\55\40\218\255\170", "\181\147\197\49\142\80\123");
	v126[(488 - 337) - (91 + 14)] = v134("\165\253\76\84\57\87\220\131\237\76\104\25\67\192", "\174\228\136\56\59\109\54");
	v126[(1236 + 672) - ((3047 - 1787) + 190 + 413)] = v134("\119\147\247\2\241\194\63\81\131\247\36\203\215\40\68\148\246\29\209", "\77\54\230\131\109\165\163");
	v126[1 + 15 + (109 - 81)] = v134("\150\29\243\181\132\28\242\180", "\218\215\104\135");
	v126[(228 - (8 + 149)) - (1348 - (1199 + 121))] = v134("\230\144\181\91\238\139\181\81\213\151\180\68\211", "\52\167\229\193");
	v126[(3 - 1) + (90 - 50)] = v134("\88\41\69\42\203\96\87\232\101", "\152\17\71\49\79\185\18\34");
	v126[(28 + 39) - (92 - 66)] = v134("\0\183\215\232\219\13\78\54\160\192\192\255\2\73\39\183\192\234\198\24", "\61\66\197\178\159\182\108");
	v126[(303 - 172) - (81 + 10)] = v134("\43\4\206\54\230\38\16\234\59\232\27\15\214", "\141\105\104\175\85");
	v126[(2621 - (518 + 1289)) - ((591 - 246) + 58 + 372)] = v134("\114\32\194\168\143\30\63\141\67\46\195\163", "\201\38\79\183\203\231\113\89");
	v126[(49 - 15) + 3 + 1] = v134("\175\48\186\131\208\41\163", "\47\234\94\219\225\188\76\199");
	v126[(478 - (304 + 165)) + 27 + 1] = v134("\54\155\129\255\216\7\193", "\181\98\233\232\145\179\98");
	v126[(815 - (54 + 106)) - ((2156 - (1618 + 351)) + 305 + 127)] = v134("\217\174\185\8\143\238\178\163", "\235\155\193\215\109");
	v126[(1026 - (10 + 1006)) + 7 + 18] = v134("\219\222\147\163\65\250\207\141\168\101\251\193", "\46\158\166\227\207");
	v126[(13 + 76) - (178 - 123)] = v134("\104\243\196\151\197\132", "\140\38\154\177\237\164\235\221");
	v126[(1090 - (912 + 121)) - (12 + 12)] = v134("\49\56\73\226\245\210\21\50\78\221\232\216\3\47", "\188\102\93\40\146\154");
	v126[(1320 - (1140 + 149)) + 1 + 0] = v134("\241\44\65\85\119\59\24\207\35\77\83\65\61\45\210\49\77", "\76\166\68\40\33\18\73");
	v126[(872 - 217) - (78 + 337 + (715 - 506))] = v134("\15\54\48", "\202\91\98\116\165\201");
	v126[(28 - 13) + 3 + 12] = v134("\42\76\151\5\21\83\169\3", "\83\124\37\225");
	v126[(360 - 256) - (261 - (165 + 21))] = v134("\168\15\105\133\158\85\63\164\31\113\143\175", "\93\233\122\29\234\202\52");
	v126[(162 - (61 + 50)) - (10 + 13)] = v134("\48\39\232\203\225\16\48\250\203\199\56\60\255", "\181\113\82\156\164");
	v126[(57 - 45) + (29 - 14)] = v134("\19\240\51\161\157\45\229", "\212\67\145\65\192");
	v126[(446 + 687) - ((1765 - (1295 + 165)) + 183 + 619)] = v134("\235\200\174\155\88\245\194\221\128\166\91", "\144\167\173\201\200\47");
	v126[(15 + 20) - (1407 - (819 + 578))] = v134("\152\240\192\32\57\40\212\161\235\220\5\35\53\247", "\131\200\159\180\73\86\70");
	v126[(1440 - (331 + 1071)) - (757 - (588 + 155))] = v134("\155\68\34", "\108\218\42\91\163\67\27");
	v126[(1538 - (546 + 736)) - ((2005 - (1834 + 103)) + 102 + 63)] = v134("\156\71\184\134\77\16\193\88", "\60\207\34\212\227\46\100\164");
	v126[(5 - 3) + (1786 - (1536 + 230))] = v134("\239\202\89\71\186\209\247\76\64\190", "\213\191\165\45\46");
	v126[(528 - (128 + 363)) - (4 + 12)] = v134("\25\73\177\213\90", "\40\73\38\198\176");
	v126[(4885 - 2921) - (264 + 755 + (1532 - 607))] = v134("\195\194\63\207\243\211\54\206", "\170\144\167\83");
	v126[(126 - 83) - (57 - 33)] = v134("\238\77\166\118\209\76\134\102\206\71", "\31\190\34\210");
	v126[(42 + 19) - (1052 - (615 + 394))] = v134("\44\166\193\255\168\41\9\27\179\249\202", "\104\105\222\177\154\196\97");
	v126[16 + 1 + 0 + 0] = v134("\37\54\117\252\46\11\52\11\59\114\192\1\17\37\7\33\80\235\44\16\45\8\57\109\214\0\19\47", "\64\106\88\25\133\111\127");
	v126[(124 - 83) - (113 - 88)] = v134("\36\29\57\167\111\31\7\52\189\69\46\29\59\187\67\18\58\59\157\65\6\17\52\170", "\46\107\115\85\222");
	v126[(2452 - (59 + 592)) - ((1164 - 638) + (2320 - 1060))] = v134("\202\39\13\54\47\63\251\33\13\51", "\94\136\85\104\65\66");
	v126[(619 + 259) - ((838 - (70 + 101)) + (486 - 289))] = v134("\159\243\19\190\194", "\128\214\135\118\211\177\80\145");
	v126[6 + 2 + (12 - 7)] = v134("\21\44\65\239\233\43\48", "\134\69\67\53\134");
	v126[(263 - (123 + 118)) - (3 + 7)] = v134("\184\217\20\68\135\206\9\89", "\42\236\171\125");
	v126[(1 + 19) - (1408 - (653 + 746))] = v134("\62\141\227\0\26\253\189", "\217\123\227\130\98\118\152");
	v126[(1611 - 749) - ((398 - 121) + (1539 - 964))] = v134("\144\243\226\27\230\67\107", "\24\211\156\143\118\137\45");
	v126[(389 + 491) - (457 + 256 + 138 + 20)] = v134("\201\56\219\127", "\76\132\87\181\20");
	v126[(40 + 281) - (17 + 89 + (507 - 300))] = v134("\158\104\214", "\94\223\56\154\96\229\168\102");
	v126[1 + 0 + (8 - 3)] = v134("\95\232\14\139\93\222\247\78\202\10\132\76\215\249\108\238\2\133\71\200", "\182\28\154\107\234\41\187");
	v126[(1236 - (885 + 349)) + 2 + 0] = v134("\137\70\123\223\74\175\117\76\238\95\164\81\114\241\78\190\93\113\208", "\62\202\52\30\190");
	v126[(10 - 6) - (5 - 3)] = v134("\143\62\203\174\224\72\207\173\34\203\163\219\93\235\165\35\192", "\159\204\76\174\207\148\45");
	v126[(969 - (915 + 53)) + (801 - (768 + 33))] = v134("\97\103\125\34\26\71\86\112\42\2\70\69\121\45\11\78", "\110\34\21\24\67");
	v126[(5360 - 3960) - ((279 - 120) + (1569 - (287 + 41)))] = v134("\255\178\152", "\166\184\231\209\231\75\144");
	for v879 = 848 - (638 + 209), #v126 do
		local v880 = v126[v879];
		if (v880 ~= nil) then
			print("v0[" .. v879 .. "] = " .. v880);
		else
			print("v0[" .. v879 .. "] = nil");
		end
	end
end
local function v89()
	v12.ResetToggle();
	v39.Mistweaver.Display();
	v12:UpdateMacro("macro1", "/use 16");
	v12:UpdateMacro("macro6", "/stopcasting");
	v12.ToggleIconFrame:AddButtonCustom("O", 1 + 0, "OOC", "ooc");
	v12.ToggleIconFrame:AddButtonCustom("D", 1688 - (96 + 1590), "Dispel", "dispel");
	v12.ToggleIconFrame:AddButtonCustom("K", 1675 - (741 + 931), "Kick", "kick");
	v12.ToggleIconFrame:AddButtonCustom("R", 2 + 2, "Ramp", "ramp");
	v12.ToggleIconFrame:AddButtonCustom("T", 14 - 9, "Transcendence", "transcendence");
	v12.ToggleIconFrame:AddButtonCustom("H", 27 - 21, "Heal", "heal");
	v12.ToggleIconFrame:AddButtonCustom("TD", 4 + 3, "Touchh of Death", "touchofdeath");
	v37.PostInitialMessage(117 + 153);
end
v12.SetAPL(87 + 183, v87, v89, v85);
