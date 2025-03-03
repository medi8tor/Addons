local v0, v1 = ...;
local v2 = HeroDBC.DBC;
local v3 = HeroLib;
local v4 = HeroCache;
local v5 = v3.Unit;
local v6 = v5.Player;
local v7 = v5.Target;
local v8 = v5.MouseOver;
local v9 = v5.Pet;
local v10 = v3.Spell;
local v11 = v3.Item;
local v12 = HeroRotation();
local v13 = v12.AoEON;
local v14 = v12.CDsON;
local v15 = v12.Cast;
local v16 = v12.Commons().Everyone.num;
local v17 = v12.Commons().Everyone.bool;
local v18 = math.max;
local v19 = math.min;
local v20 = v10.Paladin.Protection;
local v21 = v11.Paladin.Protection;
local v22 = {v21.ManicGrieftorch:ID()};
local v23 = {{v20.HammerofJustice,"Cast Hammer of Justice (Interrupt)",function()
	return true;
end}};
local v24;
local v25;
local v26, v27;
local v28, v29;
local v30 = 936 - (857 + 74);
local v31;
local v32 = 11679 - (367 + 201);
local v33 = 12038 - (214 + 713);
local v34, v35, v36, v37;
local v38;
local v39 = v6:GetEquipment();
local v40 = (v39[4 + 9] and v11(v39[3 + 10])) or v11(877 - (282 + 595));
local v41 = (v39[1651 - (1523 + 114)] and v11(v39[13 + 1])) or v11(0 - 0);
v3:RegisterForEvent(function()
	v39 = v6:GetEquipment();
	v40 = (v39[1078 - (68 + 997)] and v11(v39[1283 - (226 + 1044)])) or v11(0 - 0);
	v41 = (v39[131 - (32 + 85)] and v11(v39[14 + 0])) or v11(0 + 0);
end, "PLAYER_EQUIPMENT_CHANGED");
local function v42()
	return v21.ManicGrieftorch:IsEquipped() and (v21.ManicGrieftorch:CooldownUp() or (v21.ManicGrieftorch:CooldownRemains() <= v6:GCDRemains()));
end
local function v43()
	return v21.AlgetharPuzzleBox:IsEquipped() and (v21.AlgetharPuzzleBox:CooldownUp() or (v21.AlgetharPuzzleBox:CooldownRemains() <= v6:GCDRemains()));
end
v3:RegisterForEvent(function()
	v32 = 12068 - (892 + 65);
	v33 = 26505 - 15394;
end, "PLAYER_REGEN_ENABLED");
local v44 = v12.GUISettingsGet();
local v45 = v12.Commons().Everyone;
local v46 = v12.Commons().Paladin;
local v47 = {General=v44.General,Commons=v44.APL.Paladin.Commons,ProtectionDefensives=v44.APL.Paladin.ProtectionDefensives,Protection=v44.APL.Paladin.Protection,ProtTTD=v44.APL.Paladin.ProtTTD};
local function v48()
	if (v44.General.AutoTab and v6:AffectingCombat()) then
		v12.TopPanelAlternative:ChangeIcon(1 - 0, 4 - 1);
		return "Auto tab to target";
	end
end
local function v49(v69)
	return v31 or v45.ISSolo() or (v69 == (350 - (87 + 263))) or v45.Buggedmobs[v7:NPCID()] or ((v33 >= v69) and (v33 < (7957 - (67 + 113))));
end
local function v50(v70, v71)
	return ((v70 ~= "Not Used") and v49(v47.ProtTTD.TrinketsTTD) and (((v70 == "With Cooldowns") and v12.CDsON()) or ((v70 == "With Small or Cooldowns") and (SmallCDToggle or v12.CDsON())) or ((v70 == "With Small CDs") and SmallCDToggle) or ((v70 == "On Mobcount") and (v28 >= v47.Protection.Mobcount)) or ((v70 == "On Mobcount or Cooldowns") and ((v28 >= v47.Protection.Mobcount) or v14())) or (v70 == "Always") or ((v70 == "On Bosses") and v31) or ((v70 == "Mobcount or Boss") and (v31 or (v28 >= v47.Protection.Mobcount))))) or ((v70 == "On HealthPercent") and (v71 ~= nil) and (v6:HealthPercentageWeighted() < v71));
end
local function v51()
	return v6:BuffUp(v20.ArdentDefender) or v6:BuffUp(v20.GuardianofAncientKings) or v6:BuffUp(v20.DivineShield);
end
local function v52()
	return v47.Protection.Consecration or not v6:IsMoving();
end
local v53 = {(554776 - 328813),(795620 - 595438),(528651 - 332297),(164128 + 61356),(556053 - 359677),(342911 - 82170),(967968 - 541308),(71714 + 340791),(253768 + 2046),(802747 - 547313),(1016114 - 751964),(1314524 - 902824),(728932 - 316974),(264986 - (44 + 386)),(64089 + 137644),(268679 - (201 + 571)),(1084743 - 824192),(939713 - 682306),(427518 - (814 + 45))};
local function v54(v72)
	local v73 = nil;
	for v82, v83 in pairs(v72) do
		if (v6 ~= v83) then
			if ((v83:Role() ~= "TANK") and ((v47.ProtectionDefensives.BoPDebuff and (v45.unitHasDebuffFromList(v45.DebuffList['Bleed'], v83) or v45.unitHasDebuffFromList(v53, v83))) or (v83:HealthPercentageWeighted() <= v47.ProtectionDefensives.BoPHP)) and v83:DebuffDown(v20.ForbearanceDebuff)) then
				v73 = v83;
			end
		end
	end
	return v73;
end
local function v55(v74)
	local v75 = v47.ProtectionDefensives.IntercessionUnit;
	if (v75 == "All") then
		for v96, v97 in pairs(v74) do
			if v97:IsDeadOrGhost() then
				return v97;
			end
		end
		return nil;
	end
	local v76 = {None={},Tank={"TANK"},Healer={"HEALER"},["Tank and Healer"]={"TANK","HEALER"},DD={"DAMAGER"}};
	local v77 = v76[v75] or {};
	for v84, v85 in pairs(v74) do
		local v86 = v85:Role();
		local v87 = v85:IsDeadOrGhost();
		for v88, v89 in ipairs(v77) do
			if ((v86 == v89) and v87) then
				return v85;
			end
		end
	end
	return nil;
end
local function v56(v78)
	local v79 = UnitGUID("targettarget");
	if (v78 ~= nil) then
		for v98, v99 in pairs(v78) do
			if ((v99:GUID() == v79) and ((v7:CastSpellID() == (321868 - (1020 + 60))) or (v7:CastSpellID() == (325153 - (630 + 793))))) then
				if (v99 ~= nil) then
					return v99;
				end
			end
		end
	end
end
local function v57(v80)
	return v80:DebuffRemains(v20.JudgmentDebuff);
end
local function v58()
	return v6:BuffDown(v20.DevotionAura) and v6:BuffDown(v20.ConcentrationAura) and v6:BuffDown(v20.CrusaderAura);
end
local function v59()
	if not v20.OfDuskandDawn:IsAvailable() then
		return -(3 - 2);
	end
	return ((28 - 22) - v46.HPGCount) - (v6:BuffStack(v20.BlessingofDawnBuff) * (2 + 1));
end
local function v60()
	if (v20.DevotionAura:IsCastable() and (v58())) then
		if v15(v20.DevotionAura) then
			return "devotion_aura precombat 6";
		end
	end
	if (v20.LightsJudgment:IsCastable() and v7:IsInMeleeRange(17 - 12) and RacialsSetting) then
		if v15(v20.LightsJudgment) then
			return "lights_judgment precombat 8";
		end
	end
	if (v20.ArcaneTorrent:IsCastable() and v7:IsInMeleeRange(1755 - (760 + 987)) and RacialsSetting) then
		if v15(v20.ArcaneTorrent) then
			return "arcane_torrent precombat 10";
		end
	end
	if (v20.Consecration:IsCastable() and v52() and v7:IsInMeleeRange(1918 - (1789 + 124))) then
		if v15(v20.Consecration) then
			return "consecration precombat 12";
		end
	end
	if (v20.AvengersShield:IsCastable() and v7:IsSpellInRange(v20.AvengersShield) and v7:IsSpellInRange(v20.AvengersShield)) then
		if v15(v20.AvengersShield) then
			return "avengers_shield precombat 10";
		end
	end
	if (v20.Judgment:IsReady() and v7:IsSpellInRange(v20.Judgment) and v7:IsSpellInRange(v20.Judgment)) then
		if v15(v20.Judgment) then
			return "judgment precombat 12";
		end
	end
end
local function v61()
	if ((v6:HealthPercentage() <= v47.ProtectionDefensives.LoHHP) and v20.LayonHands:IsCastable() and v6:DebuffDown(v20.ForbearanceDebuff)) then
		if v15(v20.LayonHands, nil) then
			return "lay_on_hands defensive 2";
		end
	end
	if (v20.GuardianofAncientKings:IsCastable() and (((v6:HealthPercentageWeighted() <= v47.ProtectionDefensives.GoAKHP) and v6:BuffDown(v20.ArdentDefenderBuff)) or (v47.ProtectionDefensives.TankBusters and v6:IncomingSpell(v45.TankBustersList2))) and not v51()) then
		if v15(v20.GuardianofAncientKingsCast, nil) then
			return "guardian_of_ancient_kings defensive 4";
		end
	end
	if (v20.ArdentDefender:IsCastable() and ((v6:HealthPercentageWeighted() <= v47.ProtectionDefensives.ArdentDefenderHP) or (v47.ProtectionDefensives.TankBusters and v6:IncomingSpell(v45.TankBustersList2))) and not v51()) then
		if v15(v20.ArdentDefender, nil) then
			return "ardent_defender defensive 6";
		end
	end
	if (v20.BlessingOfSpellwarding:IsCastable() and ((v6:HealthPercentageWeighted() <= v47.ProtectionDefensives.BlessingOfSpellwardingHP) or (v47.ProtectionDefensives.TankBusters and v6:IncomingSpell(v45.TankBustersList2))) and not v51()) then
		if v15(v20.BlessingOfSpellwarding, nil) then
			return "blessing_of_spellwarding defensive 8";
		end
	end
	if (v20.WordofGlory:IsReady() and v6:BuffUp(v20.ShiningLightFreeBuff) and v20.FaithintheLight:IsAvailable() and not v6:BuffUp(v20.FaithintheLightBuff) and v47.ProtectionDefensives.WordofGloryFaithintheLight) then
		if v15(v20.WordofGlory) then
			return "word_of_glory FaithintheLightBuff";
		end
	end
	if (v20.WordofGlory:IsReady() and ((v6:HealthPercentageWeighted() <= v47.ProtectionDefensives.WordofGloryPlayerHP) or ((v6:HealthPercentageWeighted() <= v47.ProtectionDefensives.FreeWordofGloryPlayerHP) and v6:BuffUp(v20.ShiningLightFreeBuff))) and not v6:HealingAbsorbed()) then
		if v15(v20.WordofGlory) then
			return "word_of_glory defensive 8";
		end
	end
	if ((v6:HealthPercentageWeighted() <= v47.ProtectionDefensives.BubbleHP) and v20.DivineShield:IsCastable() and v6:DebuffDown(v20.ForbearanceDebuff)) then
		if v15(v20.DivineShield, nil) then
			return "Divine Shield defensive";
		end
	end
end
local function v62()
	v34 = v45.UnitsinRange(v20.FlashofLight);
	v35 = v45.GetLowestHealthUnit(v34);
	v36 = v35:HealthPercentageWeighted();
	v37 = v55(v34);
	BoPTarget = v54(v34);
	if not v35:DebuffUp(v20.ForbearanceDebuff) then
		if (v20.LayonHands:IsReady() and (v36 <= v47.ProtectionDefensives.LoHPartyHP)) then
			v35:Cast(v20.LayonHands);
			return "Lay on Hands Party";
		end
	end
	if v20.BlessingofProtection:IsReady() then
		if ((BoPTarget ~= nil) and (BoPTarget ~= v6)) then
			BoPTarget:Cast(v20.BlessingofProtection);
			return "Blessing of Protection Party";
		end
	end
	if v20.Intercession:IsReady() then
		if (v8:UnitIsFriend() and v8:UnitIsPlayer() and v8:Exists() and v8:IsDeadOrGhost()) then
			v12.CastTarget(v20.Intercession, v12.TName().MOUSEOVER);
			return "Intercession on Mouseover";
		end
		if (v47.ProtectionDefensives.IntercessionTarget and v7:UnitIsFriend() and v7:Exists() and v7:IsDeadOrGhost()) then
			v12.Cast(v20.Intercession);
			return "Intercession on Target";
		end
	end
	if (v20.BlessingofSacrifice:IsReady() and (v36 <= v47.ProtectionDefensives.BlessingOfSacrificeHP) and (v6:HealthPercentage() > (856 - (745 + 21))) and v6:BuffDown(v20.BlessingofProtection)) then
		v35:Cast(v20.BlessingofSacrifice);
		return "BlessingofSacrifice Party";
	end
	if (v20.WordofGlory:IsReady() and ((v36 <= v47.ProtectionDefensives.WordofGloryPartyHP) or ((v36 <= v47.ProtectionDefensives.FreeWordofGloryPartyHP) and v6:BuffUp(v20.ShiningLightFreeBuff)))) then
		v35:Cast(v20.WordofGlory);
		return "Word of Glory Party";
	end
end
local function v63()
	if (v20.LightsJudgment:IsCastable() and RacialsSetting and v7:IsInRange(2 + 3) and v7:IsSpellInRange(v20.LightsJudgment)) then
		if v15(v20.LightsJudgment, false, nil, not v7:IsSpellInRange(v20.LightsJudgment)) then
			return "lights_judgment cooldowns 2";
		end
	end
	if (v20.AvengingWrath:IsCastable() and AvengingWrathSetting and v7:IsInRange(13 - 8)) then
		if v15(v20.AvengingWrath, false) then
			return "avenging_wrath cooldowns 4";
		end
	end
	if (v20.Sentinel:IsCastable() and AvengingWrathSetting and v7:IsInRange(19 - 14)) then
		if v15(v20.Sentinel, false) then
			return "sentinel cooldowns 6";
		end
	end
	if (v47.Commons.Enabled.Potions and PotionSetting and (v6:BuffUp(v20.AvengingWrathBuff))) then
		local v90 = v45.PotionSelected();
		if (v90 and v90:IsReady()) then
			v12.CastMacro(1 + 2, nil, nil, v90);
			return "Cast Potion";
		end
	end
	if (v20.MomentofGlory:IsCastable() and ((v6:BuffUp(v20.AvengingWrathBuff) and (v6:BuffRemains(v20.AvengingWrathBuff) < (12 + 3))) or (((v3.CombatTime() > (1065 - (87 + 968))) or (v20.AvengingWrath:CooldownRemains() > (66 - 51))) and v20.AvengersShield:CooldownDown() and v20.Judgment:CooldownDown() and v20.HammerofWrath:CooldownDown()))) then
		if v15(v20.MomentofGlory, false) then
			return "moment_of_glory cooldowns 10";
		end
	end
	if (v20.DivineToll:IsCastable() and DivineTollSetting and (v28 >= (3 + 0))) then
		if v15(v20.DivineToll) then
			return "divine_toll cooldowns 12";
		end
	end
	if (v20.BastionofLight:IsCastable() and (v6:BuffUp(v20.AvengingWrathBuff) or (v20.AvengingWrath:CooldownRemains() <= (67 - 37)))) then
		if v15(v20.BastionofLight, false) then
			return "bastion_of_light cooldowns 14";
		end
	end
	if (v20.Fireblood:IsCastable() and v7:IsInMeleeRange(1418 - (447 + 966)) and RacialsSetting and (v6:BuffRemains(v20.AvengingWrathBuff) > (21 - 13))) then
		if v15(v20.Fireblood) then
			return "fireblood cooldowns 16";
		end
	end
end
local function v64()
	if (v20.HammerofLight:IsReady() and v7:IsInRange(1829 - (1703 + 114)) and (v6:BuffUp(v20.BlessingofDawnBuff) or not v20.OfDuskandDawn:IsAvailable() or (v28 >= (706 - (376 + 325))))) then
		if v15(v20.EyeofTyr) then
			return "hammer_of_light hammer_of_light 2";
		end
	end
	if (v20.EyeofTyr:IsCastable() and EyeOfTyrSetting and v7:IsInMeleeRange(12 - 4) and ((v59() == (15 - 10)) or not v20.OfDuskandDawn:IsAvailable())) then
		if v15(v20.EyeofTyr) then
			return "eye_of_tyr hammer_of_light 4";
		end
	end
	if (v20.ShieldoftheRighteous:IsReady() and v7:IsInMeleeRange(2 + 3) and (v59() == (8 - 4))) then
		if v15(v20.ShieldoftheRighteous, true) then
			return "shield_of_the_righteous standard 6";
		end
	end
	if (v20.EyeofTyr:IsCastable() and EyeOfTyrSetting and v7:IsInMeleeRange(22 - (9 + 5)) and ((v59() == (377 - (85 + 291))) or v6:BuffUp(v20.BlessingofDawnBuff))) then
		if v15(v20.EyeofTyr) then
			return "eye_of_tyr hammer_of_light 8";
		end
	end
	if (v20.HammerofWrath:IsReady() and v7:IsSpellInRange(v20.HammerofWrath)) then
		if v15(v20.HammerofWrath) then
			return "hammer_of_wrath hammer_of_light 10";
		end
	end
	if (v20.Judgment:IsReady() and v7:IsSpellInRange(v20.Judgment)) then
		if v15(v20.Judgment) then
			return "judgment hammer_of_light 12";
		end
	end
	if (v20.BlessedHammer:IsCastable() and v7:IsInMeleeRange(1270 - (243 + 1022))) then
		if v15(v20.BlessedHammer) then
			return "blessed_hammer hammer_of_light 14";
		end
	end
	if (v20.HammeroftheRighteous:IsCastable() and v7:IsInMeleeRange(19 - 14)) then
		if v15(v20.HammeroftheRighteous) then
			return "hammer_of_the_righteous hammer_of_light 16";
		end
	end
	if (v20.CrusaderStrike:IsCastable() and v7:IsInMeleeRange(5 + 0)) then
		if v15(v20.CrusaderStrike) then
			return "crusader_strike hammer_of_light 18";
		end
	end
	if (v20.DivineToll:IsReady() and v7:IsInRange(1210 - (1123 + 57)) and DivineTollSetting) then
		if v15(v20.DivineToll) then
			return "divine_toll hammer_of_light 20";
		end
	end
end
local function v65()
	if (v20.LightsGuidance:IsAvailable() and ((v20.EyeofTyr:CooldownRemains() < (2 + 0)) or v20.HammerofLight:IsLearned()) and (not v20.Redoubt:IsAvailable() or (v6:BuffStack(v20.RedoubtBuff) >= (256 - (163 + 91))) or not v20.BastionofLight:IsAvailable()) and (v20.HammerofLight:Cost() > (1930 - (1869 + 61)))) then
		local v91 = v64();
		if v91 then
			return v91;
		end
	end
	if (v20.HammerofLight:IsReady() and v7:IsInRange(4 + 8) and ((v6:BuffRemains(v20.LightsDeliveranceBuff) < (6 - 4)) or (v6:BuffRemains(v20.ShaketheHeavensBuff) < (1 - 0)) or v6:BuffDown(v20.ShaketheHeavensBuff) or (v20.EyeofTyr:CooldownRemains() < (1.5 + 0)) or (v32 < (2 - 0)))) then
		if v15(v20.EyeofTyr) then
			return "hammer_of_light standard 2";
		end
	end
	local v81 = 939 + 60;
	if v20.RighteousProtector:IsAvailable() then
		local v92 = v19(v20.ShieldoftheRighteous:TimeSinceLastCast(), v20.WordofGlory:TimeSinceLastCast());
		v81 = v18(1474 - (1329 + 145), (972 - (140 + 831)) - v19(v20.ShieldoftheRighteous:TimeSinceLastCast(), v20.WordofGlory:TimeSinceLastCast()));
	end
	if (v20.ShieldoftheRighteous:IsReady() and v7:IsInMeleeRange(1855 - (1409 + 441)) and (not v20.RighteousProtector:IsAvailable() or (v81 == (718 - (15 + 703)))) and not v20.HammerofLight:IsLearned()) then
		if v15(v20.ShieldoftheRighteous, true) then
			return "shield_of_the_righteous standard 4";
		end
	end
	if (v20.SacredWeapon:IsCastable() and (v6:BuffDown(v20.SacredWeaponBuff) or ((v6:BuffRemains(v20.SacredWeaponBuff) < (3 + 3)) and v6:BuffDown(v20.AvengingWrathBuff) and (v20.AvengingWrath:CooldownRemains() <= (468 - (262 + 176)))))) then
		if v15(v20.SacredWeapon) then
			return "holy_armaments standard 6";
		end
	end
	if (v20.Judgment:IsReady() and v7:IsSpellInRange(v20.Judgment) and (v28 > (1724 - (345 + 1376))) and (v6:BuffStack(v20.BulwarkofRighteousFuryBuff) >= (691 - (198 + 490))) and (v6:HolyPower() < (13 - 10))) then
		if v15(v20.Judgment) then
			return "judgment standard 8";
		end
	end
	if (v6:BuffUp(v20.BlessedAssuranceBuff) and (v28 < (6 - 3))) then
		if (v20.BlessedHammer:IsCastable() and v7:IsInMeleeRange(1211 - (696 + 510))) then
			if v15(v20.BlessedHammer) then
				return "blessed_hammer standard 10";
			end
		end
		if (v20.HammeroftheRighteous:IsCastable() and v7:IsInMeleeRange(10 - 5)) then
			if v15(v20.HammeroftheRighteous) then
				return "hammer_of_the_righteous standard 12";
			end
		end
	end
	if (v20.CrusaderStrike:IsCastable() and v7:IsInMeleeRange(1267 - (1091 + 171)) and v6:BuffUp(v20.BlessedAssuranceBuff) and (v28 < (1 + 1))) then
		if v15(v20.CrusaderStrike) then
			return "crusader_strike standard 14";
		end
	end
	if (v20.AvengersShield:IsCastable() and v7:IsSpellInRange(v20.AvengersShield) and v6:BuffDown(v20.BulwarkofRighteousFuryBuff) and v20.BulwarkofRighteousFury:IsAvailable() and (v28 >= (9 - 6))) then
		if v15(v20.AvengersShield) then
			return "avengers_shield standard 16";
		end
	end
	if (v20.HammerofWrath:IsReady() and v7:IsSpellInRange(v20.HammerofWrath)) then
		if v15(v20.HammerofWrath) then
			return "hammer_of_wrath standard 18";
		end
	end
	if (v20.Judgment:IsReady() and v7:IsSpellInRange(v20.Judgment) and ((v20.Judgment:Charges() >= (6 - 4)) or (v20.Judgment:FullRechargeTime() <= (v6:GCD() + (374.25 - (123 + 251)))))) then
		if v15(v20.Judgment) then
			return "judgment standard 20";
		end
	end
	if (v20.HolyBulwark:IsCastable() and (v20.HolyBulwark:Charges() == (9 - 7))) then
		if v15(v20.HolyBulwark) then
			return "holy_armaments standard 22";
		end
	end
	if (v20.DivineToll:IsReady() and v7:IsInRange(728 - (208 + 490)) and DivineTollSetting) then
		if v15(v20.DivineToll) then
			return "divine_toll standard 24";
		end
	end
	if (v20.Judgment:IsReady() and v7:IsSpellInRange(v20.Judgment)) then
		if v15(v20.Judgment) then
			return "judgment standard 26";
		end
	end
	if (v20.AvengersShield:IsCastable() and v7:IsSpellInRange(v20.AvengersShield) and not v20.LightsGuidance:IsAvailable()) then
		if v15(v20.AvengersShield) then
			return "avengers_shield standard 28";
		end
	end
	if (v20.Consecration:IsCastable() and v52() and v7:IsInMeleeRange(1 + 4) and (v6:BuffDown(v20.ConsecrationBuff))) then
		if v15(v20.Consecration) then
			return "consecration standard 30";
		end
	end
	if (v20.EyeofTyr:IsCastable() and EyeOfTyrSetting and v7:IsInMeleeRange(4 + 4) and ((v20.InmostLight:IsAvailable() and (v28 <= (837 - (660 + 176)))) or (v28 >= (1 + 2))) and not v20.LightsDeliverance:IsAvailable()) then
		if v15(v20.EyeofTyr) then
			return "eye_of_tyr standard 32";
		end
	end
	if v20.HolyBulwark:IsCastable() then
		if v15(v20.HolyBulwark) then
			return "holy_armaments standard 34";
		end
	end
	if (v20.BlessedHammer:IsCastable() and v7:IsInMeleeRange(207 - (14 + 188))) then
		if v15(v20.BlessedHammer) then
			return "blessed_hammer standard 36";
		end
	end
	if (v20.HammeroftheRighteous:IsCastable() and v7:IsInMeleeRange(680 - (534 + 141))) then
		if v15(v20.HammeroftheRighteous) then
			return "hammer_of_the_righteous standard 38";
		end
	end
	if (v20.CrusaderStrike:IsCastable() and v7:IsInMeleeRange(3 + 2)) then
		if v15(v20.CrusaderStrike) then
			return "crusader_strike standard 40";
		end
	end
	if (v20.AvengersShield:IsCastable() and v7:IsSpellInRange(v20.AvengersShield)) then
		if v15(v20.AvengersShield) then
			return "avengers_shield standard 48";
		end
	end
	if (v20.EyeofTyr:IsCastable() and EyeOfTyrSetting and v7:IsInMeleeRange(8 + 0) and not v20.LightsDeliverance:IsAvailable()) then
		if v15(v20.EyeofTyr) then
			return "eye_of_tyr standard 50";
		end
	end
	if (v20.ArcaneTorrent:IsCastable() and v7:IsInMeleeRange(8 + 0) and RacialsSetting and (v6:HolyPower() < (10 - 5))) then
		if v15(v20.ArcaneTorrent) then
			return "arcane_torrent standard 58";
		end
	end
	if (v20.Consecration:IsCastable() and v52() and v7:IsInMeleeRange(7 - 2) and (v6:BuffDown(v20.SanctificationEmpowerBuff))) then
		if v15(v20.Consecration) then
			return "consecration standard 60";
		end
	end
end
local function v66()
	if (v42() and v6:AffectingCombat() and (((v40:ID() == v21.ManicGrieftorch:ID()) and Trinket1Setting) or ((v41:ID() == v21.ManicGrieftorch:ID()) and Trinket2Setting)) and v49(v47.ProtTTD.TrinketsTTD) and v7:IsInRange(112 - 72)) then
		if v15(v21.ManicGrieftorch) then
			return "manic_grieftorch";
		end
	end
	if (v21.ElementiumPocketAnvil:IsEquippedAndReady() and v6:AffectingCombat() and (((v40:ID() == v21.ElementiumPocketAnvil:ID()) and Trinket1Setting) or ((v41:ID() == v21.ElementiumPocketAnvil:ID()) and Trinket2Setting)) and v7:IsInRange(3 + 2)) then
		if v15(v21.ElementiumPocketAnvil) then
			return "ElementiumPocketAnvil";
		end
	end
	if (v6:BuffUp(v20.AvengingWrathBuff) or not v20.AvengingWrath:IsAvailable() or v20.Sentinel:IsAvailable() or (v32 <= (26 + 14))) then
		local v93, v94, v95 = v6:GetUseableItems(v22);
		if v93 then
			if ((((v94 == (409 - (115 + 281))) and Trinket1Setting) or ((v94 == (32 - 18)) and Trinket2Setting)) and v7:IsInRange(v95) and v47.Commons.Enabled.Trinkets and v6:BuffDown(v20.ConcoctionKissofDeathBuff)) then
				if v15(v93, false) then
					return "Generic use_items for " .. v94 .. v93:Name();
				end
			end
		end
	end
end
local function v67()
	if v6:IsChanneling(v21.ManicGrieftorch.ItemUseSpell) then
		return "Dont cut Torch";
	end
	if (((v40:ID() == v21.ConcoctionKissofDeath:ID()) or (v41:ID() == v21.ConcoctionKissofDeath:ID())) and v6:BuffUp(v20.ConcoctionKissofDeathBuff) and (v6:BuffRemains(v20.ConcoctionKissofDeathBuff) < (1 + 0))) then
		if v15(v21.ConcoctionKissofDeath, true) then
			return "ConcoctionKissofDeath cooldowns 8";
		end
	end
	v34 = v45.UnitsinRange(v20.FlashofLight);
	UnitForFreezingBinds = v56(v34);
	SmallCDToggle = v12.ToggleIconFrame:GetToggle(2 - 1);
	TabToggle = v12.ToggleIconFrame:GetToggle(7 - 5);
	InterruptToggle = v12.ToggleIconFrame:GetToggle(870 - (550 + 317));
	DispelToggle = v12.ToggleIconFrame:GetToggle(5 - 1);
	v26 = v6:GetEnemiesInRange(10 - 2);
	v27 = v6:GetEnemiesInRange(83 - 53);
	v34 = v45.UnitsinRange(v20.FlashofLight);
	if (v13()) then
		v28 = #v26;
		v29 = #v27;
	else
		v28 = 286 - (134 + 151);
		v29 = 1666 - (970 + 695);
	end
	RacialsSetting = v50(v47.Protection.RacialsSetting) and v49(v47.ProtTTD.RacialsTTD);
	Trinket1Setting = v50(v47.Protection.Trinket1Setting, v47.Protection.TrinketHP);
	Trinket2Setting = v50(v47.Protection.Trinket2Setting, v47.Protection.TrinketHP);
	PotionSetting = v50(v47.Protection.PotionSetting) and not v45.ISSolo();
	DivineTollSetting = v50(v47.Protection.DivineTollSetting) and v49(v47.ProtTTD.DivineTollTTD) and v7:IsInRange(57 - 27);
	AvengingWrathSetting = v50(v47.Protection.AvengingWrathSetting) and v49(v47.ProtTTD.AvengingWrathTTD);
	EyeOfTyrSetting = v50(v47.Protection.EyeOfTyrSetting) and v49(2005 - (582 + 1408));
	if (v45.TargetIsValid() or v6:AffectingCombat()) then
		v24 = v6:ActiveMitigationNeeded();
		v25 = v6:IsTankingAoE(27 - 19) or v6:IsTanking(v7);
		v32 = v3.BossFightRemains();
		v31 = true;
		v33 = v32;
		if (v33 == (13979 - 2868)) then
			v31 = false;
			v33 = v3.FightRemains(v26, false);
		end
	end
	if (v20.DevotionAura:IsCastable() and v6:BuffDown(v20.DevotionAura, true) and (v58())) then
		if v15(v20.DevotionAura) then
			return "devotion_aura precombat 2";
		end
	end
	if v20.RiteofSanctification:IsCastable() then
		if v12.Cast(v20.RiteofSanctification) then
			return "rite_of_sanctification precombat 2";
		end
	end
	if v20.RiteofAdjuration:IsCastable() then
		if v12.CastLeft(v20.RiteofAdjuration) then
			return "rite_of_adjuration precombat 4";
		end
	end
	if v45.TargetIsValid() then
		if (not v6:AffectingCombat() and v47.Protection.AttackOutOfCombat) then
			v38 = v60();
			if v38 then
				return v38;
			end
		end
		if (v20.CleanseToxins:IsReady() and v47.Protection.UseCleanse and DispelToggle) then
			v38 = v45.DispelCycle(v20.CleanseToxins, "Poison");
			if v38 then
				return v38;
			end
			v38 = v45.DispelCycle(v20.CleanseToxins, "Disease");
			if v38 then
				return v38;
			end
			v38 = v45.AfflictedLogic(v20.CleanseToxins);
			if v38 then
				return v38;
			end
			if v38 then
				return v38;
			end
		end
		if (v20.BlessingofFreedom:IsReady() and v47.Protection.UseFreedom) then
			if UnitForFreezingBinds then
				if UnitForFreezingBinds:Cast(v20.BlessingofFreedom) then
					return "Blessing of Freedom Frozen Binds";
				end
			end
			if (v6:DebuffElapsed(v20.EntangledDebuff) > (7 - 5)) then
				if v6:Cast(v20.BlessingofFreedom) then
					return "Blessing of Freedom entangling";
				end
			end
			v38 = v45.DispelCycle(v20.BlessingofFreedom, "RootDispel", nil, v34);
			if v38 then
				return v38;
			end
			v38 = v45.DispelCycle(v20.BlessingofFreedom, "SnareRoot", nil, v34);
			if v38 then
				return v38;
			end
			v38 = v45.DispelCycle(v20.BlessingofFreedom, "FreedomDispel", nil, v34);
			if v38 then
				return v38;
			end
		end
		if InterruptToggle then
			v38 = v45.InterruptCycle(v20.Rebuke, 1829 - (1195 + 629), true, nil, false);
			if v38 then
				return v38;
			end
			v38 = not v6:IsMoving() and v45.InterruptCycle(v20.HammerofJustice, 13 - 3, false, nil, true);
			if v38 then
				return v38;
			end
			v38 = not v6:IsMoving() and v45.InterruptCycle(v20.BlindingLight, 251 - (187 + 54), false, nil, true, true);
			if v38 then
				return v38;
			end
		end
		if (v7:AffectingCombat() or v47.Protection.AttackOutOfCombat) then
			if v25 then
				v38 = v61();
				if v38 then
					return v38;
				end
			end
			if (v6:AffectingCombat() and v6:IsInParty() and not v6:IsInRaid()) then
				v38 = v62();
				if v38 then
					return v38;
				end
			end
			if (v20.Consecration:IsCastable() and v52() and v7:IsInMeleeRange(785 - (162 + 618)) and ((v3.CombatTime() < (4 + 1)) or v47.ProtectionDefensives.MostDefensive) and (v6:BuffDown(v20.ConsecrationBuff) or (v6:BuffStack(v20.DivineGuidanceBuff) >= (4 + 1)))) then
				if v15(v20.Consecration) then
					return "consecration defensive";
				end
			end
			if (v20.BlessedHammer:IsCastable() and v7:IsInMeleeRange(21 - 11) and (v3.CombatTime() < (8 - 3)) and (v20.BlessedHammer:TimeSinceLastCast() > (1 + 4)) and v47.ProtectionDefensives.MostDefensive) then
				if v15(v20.BlessedHammer) then
					return "blessed_hammer defensive";
				end
			end
			if (v20.ShieldoftheRighteous:IsReady() and v7:IsInMeleeRange(1646 - (1373 + 263)) and v47.ProtectionDefensives.MostDefensive and v6:BuffDown(v20.ShieldoftheRighteousBuff)) then
				if v15(v20.ShieldoftheRighteous, true) then
					return "shield_of_the_righteous defensive";
				end
			end
			v38 = v63();
			if v38 then
				return v38;
			end
			if (v47.Commons.Enabled.Trinkets or v47.Commons.Enabled.Items) then
				v38 = v66();
				if v38 then
					return v38;
				end
			end
			v38 = v65();
			if v38 then
				return v38;
			end
		end
		v38 = (v28 > (1000 - (451 + 549))) and not v7:IsInRange(3 + 5) and v48();
		if v38 then
			return v38;
		end
	end
end
local function v68()
	v47.Protection.Display();
	v12.ResetToggle();
	v12.ToggleIconFrame:AddButtonCustom("S", 1 - 0, "Small CDs", "smallcds");
	v12.ToggleIconFrame:AddButtonCustom("T", 2 - 0, "Tab", "tab");
	v12.ToggleIconFrame:AddButtonCustom("I", 1387 - (746 + 638), "Interrupt", "interrupt");
	v12.ToggleIconFrame:AddButtonCustom("D", 2 + 2, "Dispel", "dispel");
	v45.PostInitialMessage(99 - 33);
end
v12.SetAPL(407 - (218 + 123), v67, v68);
