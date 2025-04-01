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
local v24 = 936 - (857 + 74);
local v25;
local v26;
local v27, v28;
local v29, v30;
local v24 = 573 - (367 + 201);
local v31;
local v32 = 12038 - (214 + 713);
local v33 = 2782 + 8329;
local v34, v35, v36, v37;
local v38;
local v39 = v6:GetEquipment();
local v40 = (v39[3 + 10] and v11(v39[890 - (282 + 595)])) or v11(1637 - (1523 + 114));
local v41 = (v39[13 + 1] and v11(v39[19 - 5])) or v11(1065 - (68 + 997));
v3:RegisterForEvent(function()
	v39 = v6:GetEquipment();
	v40 = (v39[1283 - (226 + 1044)] and v11(v39[56 - 43])) or v11(117 - (32 + 85));
	v41 = (v39[14 + 0] and v11(v39[4 + 10])) or v11(957 - (892 + 65));
end, "PLAYER_EQUIPMENT_CHANGED");
local function v42()
	return v21.ManicGrieftorch:IsEquipped() and (v21.ManicGrieftorch:CooldownUp() or (v21.ManicGrieftorch:CooldownRemains() <= v6:GCDRemains()));
end
local function v43()
	return v21.AlgetharPuzzleBox:IsEquipped() and (v21.AlgetharPuzzleBox:CooldownUp() or (v21.AlgetharPuzzleBox:CooldownRemains() <= v6:GCDRemains()));
end
v3:RegisterForEvent(function()
	v32 = 26505 - 15394;
	v33 = 20537 - 9426;
end, "PLAYER_REGEN_ENABLED");
local v44 = v12.GUISettingsGet();
local v45 = v12.Commons().Everyone;
local v46 = v12.Commons().Paladin;
local v47 = {General=v44.General,Commons=v44.APL.Paladin.Commons,ProtectionDefensives=v44.APL.Paladin.ProtectionDefensives,Protection=v44.APL.Paladin.Protection,ProtTTD=v44.APL.Paladin.ProtTTD};
local function v48()
	if (v44.General.AutoTab and v6:AffectingCombat()) then
		v12.TopPanelAlternative:ChangeIcon(1 - 0, 353 - (87 + 263));
		return "Auto tab to target";
	end
end
local function v49(v68)
	return v31 or v45.ISSolo() or (v68 == (180 - (67 + 113))) or v45.Buggedmobs[v7:NPCID()] or ((v33 >= v68) and (v33 < (5703 + 2074)));
end
local function v50(v69, v70)
	return ((v69 ~= "Not Used") and v49(v47.ProtTTD.TrinketsTTD) and (((v69 == "With Cooldowns") and v12.CDsON()) or ((v69 == "With Small or Cooldowns") and (SmallCDToggle or v12.CDsON())) or ((v69 == "With Small CDs") and SmallCDToggle) or ((v69 == "On Mobcount") and (v29 >= v47.Protection.Mobcount)) or ((v69 == "On Mobcount or Cooldowns") and ((v29 >= v47.Protection.Mobcount) or v14())) or (v69 == "Always") or ((v69 == "With Bloodlust only") and v6:BloodlustUp()) or ((v69 == "On Bosses") and v31) or ((v69 == "Mobcount or Boss") and (v31 or (v29 >= v47.Protection.Mobcount))))) or ((v69 == "On HealthPercent") and (v70 ~= nil) and (v6:HealthPercentageWeighted() < v70));
end
local function v51()
	return v6:BuffUp(v20.ArdentDefender) or v6:BuffUp(v20.GuardianofAncientKings) or v6:BuffUp(v20.DivineShield);
end
local function v52()
	return v47.Protection.Consecration or not v6:IsMoving();
end
local v53 = {(166185 + 59778),(201134 - (802 + 150)),(356178 - 159824),(226481 - (915 + 82)),(114399 + 81977),(261928 - (1069 + 118)),(933307 - 506647),(732938 - 320433),(256605 - (368 + 423)),(255452 - (10 + 8)),(264592 - (416 + 26)),(176682 + 235018),(412396 - (145 + 293)),(266042 - (998 + 488)),(165184 + 36549),(269045 - (116 + 1022)),(152938 + 107613),(914074 - 656667),(1051272 - 624613)};
local function v54(v71)
	local v72 = nil;
	for v81, v82 in pairs(v71) do
		if (v6 ~= v82) then
			if ((v82:Role() ~= "TANK") and ((v47.ProtectionDefensives.BoPDebuff and (v45.unitHasDebuffFromList(v45.DebuffList['Bleed'], v82) or v45.unitHasDebuffFromList(v53, v82))) or (v82:HealthPercentageWeighted() <= v47.ProtectionDefensives.BoPHP)) and v82:DebuffDown(v20.ForbearanceDebuff)) then
				v72 = v82;
			end
		end
	end
	return v72;
end
local function v55(v73)
	local v74 = v47.ProtectionDefensives.IntercessionUnit;
	if (v74 == "All") then
		for v94, v95 in pairs(v73) do
			if v95:IsDeadOrGhost() then
				return v95;
			end
		end
		return nil;
	end
	local v75 = {None={},Tank={"TANK"},Healer={"HEALER"},["Tank and Healer"]={"TANK","HEALER"},DD={"DAMAGER"}};
	local v76 = v75[v74] or {};
	for v83, v84 in pairs(v73) do
		local v85 = v84:Role();
		local v86 = v84:IsDeadOrGhost();
		for v87, v88 in ipairs(v76) do
			if ((v85 == v88) and v86) then
				return v84;
			end
		end
	end
	return nil;
end
local function v56(v77)
	local v78 = UnitGUID("targettarget");
	if (v77 ~= nil) then
		for v96, v97 in pairs(v77) do
			if ((v97:GUID() == v78) and ((v7:CastSpellID() == (322211 - (630 + 793))) or (v7:CastSpellID() == (1097013 - 773283)))) then
				if (v97 ~= nil) then
					return v97;
				end
			end
		end
	end
end
local function v57(v79)
	return v79:DebuffRemains(v20.JudgmentDebuff);
end
local function v58()
	return v6:BuffDown(v20.DevotionAura) and v6:BuffDown(v20.ConcentrationAura) and v6:BuffDown(v20.CrusaderAura);
end
local function v59()
	if not v20.OfDuskandDawn:IsAvailable() then
		return -(4 - 3);
	end
	return ((3 + 3) - v46.HPGCount) - (v6:BuffStack(v20.BlessingofDawnBuff) * (9 - 6));
end
local function v60()
	if (v20.DevotionAura:IsCastable() and (v58())) then
		if v15(v20.DevotionAura) then
			return "devotion_aura precombat 6";
		end
	end
	if (v20.LightsJudgment:IsCastable() and v7:IsInMeleeRange(1752 - (760 + 987)) and RacialsSetting) then
		if v15(v20.LightsJudgment) then
			return "lights_judgment precombat 8";
		end
	end
	if (v20.ArcaneTorrent:IsCastable() and v7:IsInMeleeRange(1921 - (1789 + 124)) and RacialsSetting) then
		if v15(v20.ArcaneTorrent) then
			return "arcane_torrent precombat 10";
		end
	end
	if (v20.Consecration:IsCastable() and v52() and v7:IsInMeleeRange(771 - (745 + 21))) then
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
	if (v20.BlessingofSacrifice:IsReady() and (v36 <= v47.ProtectionDefensives.BlessingOfSacrificeHP) and (v6:HealthPercentage() > (31 + 59)) and v6:BuffDown(v20.BlessingofProtection)) then
		v35:Cast(v20.BlessingofSacrifice);
		return "BlessingofSacrifice Party";
	end
	if (v20.WordofGlory:IsReady() and ((v36 <= v47.ProtectionDefensives.WordofGloryPartyHP) or ((v36 <= v47.ProtectionDefensives.FreeWordofGloryPartyHP) and v6:BuffUp(v20.ShiningLightFreeBuff)))) then
		v35:Cast(v20.WordofGlory);
		return "Word of Glory Party";
	end
end
local function v63()
	if (v20.LightsJudgment:IsCastable() and RacialsSetting and v7:IsInRange(13 - 8) and v7:IsSpellInRange(v20.LightsJudgment)) then
		if v15(v20.LightsJudgment, false, nil, not v7:IsSpellInRange(v20.LightsJudgment)) then
			return "lights_judgment cooldowns 2";
		end
	end
	if (v20.AvengingWrath:IsCastable() and AvengingWrathSetting and v7:IsInRange(19 - 14)) then
		if v15(v20.AvengingWrath, false) then
			return "avenging_wrath cooldowns 4";
		end
	end
	if (v20.Sentinel:IsCastable() and AvengingWrathSetting and v7:IsInRange(1 + 4)) then
		if v15(v20.Sentinel, false) then
			return "sentinel cooldowns 6";
		end
	end
	if (v47.Commons.Enabled.Potions and PotionSetting and (v6:BuffUp(v20.AvengingWrathBuff))) then
		local v89 = v45.PotionSelected();
		if (v89 and v89:IsReady()) then
			v12.CastMacro(3 + 0, nil, nil, v89);
			return "Cast Potion";
		end
	end
	if (v20.MomentofGlory:IsCastable() and ((v6:BuffUp(v20.AvengingWrathBuff) and (v6:BuffRemains(v20.AvengingWrathBuff) < (1070 - (87 + 968)))) or (((v3.CombatTime() > (44 - 34)) or (v20.AvengingWrath:CooldownRemains() > (14 + 1))) and v20.AvengersShield:CooldownDown() and v20.Judgment:CooldownDown() and v20.HammerofWrath:CooldownDown()))) then
		if v15(v20.MomentofGlory, false) then
			return "moment_of_glory cooldowns 10";
		end
	end
	if (v20.DivineToll:IsCastable() and DivineTollSetting and (v29 >= (6 - 3))) then
		if v15(v20.DivineToll) then
			return "divine_toll cooldowns 12";
		end
	end
	if (v20.BastionofLight:IsCastable() and (v6:BuffUp(v20.AvengingWrathBuff) or (v20.AvengingWrath:CooldownRemains() <= (1443 - (447 + 966))))) then
		if v15(v20.BastionofLight, false) then
			return "bastion_of_light cooldowns 14";
		end
	end
	if (v20.Fireblood:IsCastable() and v7:IsInMeleeRange(13 - 8) and RacialsSetting and (v6:BuffRemains(v20.AvengingWrathBuff) > (1825 - (1703 + 114)))) then
		if v15(v20.Fireblood) then
			return "fireblood cooldowns 16";
		end
	end
end
local function v64()
	if (v20.Judgment:IsReady() and ((v20.Judgment:Charges() >= (703 - (376 + 325))) or (v20.Judgment:FullRechargeTime() <= v6:GCD()))) then
		if v15(v20.Judgment) then
			return "judgment standard 2";
		end
	end
	if (v20.HammerofLight:IsReady() and v7:IsInRange(18 - 6) and ((v6:BuffRemains(v20.LightsDeliveranceBuff) < (5 - 3)) or (v6:BuffRemains(v20.ShaketheHeavensBuff) < (1 + 0)) or v6:BuffDown(v20.ShaketheHeavensBuff) or (v20.EyeofTyr:CooldownRemains() < (2.5 - 1)) or (v32 < (16 - (9 + 5))))) then
		if v15(v20.HammerofLight, true) then
			return "hammer_of_light standard 4";
		end
	end
	if ((v14() or v20.LightsGuidance:IsAvailable()) and EyeOfTyrSetting and v20.EyeofTyr:IsCastable() and v20.LightsGuidance:IsAvailable() and ((v59() == (381 - (85 + 291))) or not v20.OfDuskandDawn:IsAvailable() or (v59() == (1266 - (243 + 1022))) or (v6:BuffStack(v20.BlessingofDawnBuff) > (0 - 0)))) then
		if v15(v20.EyeofTyr) then
			return "hammer_of_light standard 2";
		end
	end
	local v80 = 825 + 174;
	if v20.RighteousProtector:IsAvailable() then
		local v90 = v19(v20.ShieldoftheRighteous:TimeSinceLastCast(), v20.WordofGlory:TimeSinceLastCast());
		v80 = v18(1180 - (1123 + 57), (1 + 0) - v19(v20.ShieldoftheRighteous:TimeSinceLastCast(), v20.WordofGlory:TimeSinceLastCast()));
	end
	if (v20.ShieldoftheRighteous:IsReady() and v7:IsInMeleeRange(259 - (163 + 91)) and (not v20.RighteousProtector:IsAvailable() or (v80 == (1930 - (1869 + 61)))) and not v20.HammerofLight:IsLearned()) then
		if v15(v20.ShieldoftheRighteous, true) then
			return "shield_of_the_righteous standard 4";
		end
	end
	if (v20.SacredWeapon:IsCastable() and (v6:BuffDown(v20.SacredWeaponBuff) or ((v6:BuffRemains(v20.SacredWeaponBuff) < (2 + 4)) and v6:BuffDown(v20.AvengingWrathBuff) and (v20.AvengingWrath:CooldownRemains() <= (105 - 75))))) then
		if v15(v20.SacredWeapon) then
			return "holy_armaments standard 6";
		end
	end
	if (v20.Judgment:IsReady() and v7:IsSpellInRange(v20.Judgment) and (v29 > (4 - 1)) and (v6:BuffStack(v20.BulwarkofRighteousFuryBuff) >= (1 + 2)) and (v6:HolyPower() < (3 - 0))) then
		if v15(v20.Judgment) then
			return "judgment standard 8";
		end
	end
	if (v6:BuffUp(v20.BlessedAssuranceBuff) and (v29 < (3 + 0))) then
		if (v20.BlessedHammer:IsCastable() and v7:IsInMeleeRange(1479 - (1329 + 145))) then
			if v15(v20.BlessedHammer) then
				return "blessed_hammer standard 10";
			end
		end
		if (v20.HammeroftheRighteous:IsCastable() and v7:IsInMeleeRange(976 - (140 + 831))) then
			if v15(v20.HammeroftheRighteous) then
				return "hammer_of_the_righteous standard 12";
			end
		end
	end
	if (v20.CrusaderStrike:IsCastable() and v7:IsInMeleeRange(1855 - (1409 + 441)) and v6:BuffUp(v20.BlessedAssuranceBuff) and (v29 < (720 - (15 + 703)))) then
		if v15(v20.CrusaderStrike) then
			return "crusader_strike standard 14";
		end
	end
	if (v20.AvengersShield:IsCastable() and v7:IsSpellInRange(v20.AvengersShield) and v6:BuffDown(v20.BulwarkofRighteousFuryBuff) and v20.BulwarkofRighteousFury:IsAvailable() and (v29 >= (2 + 1))) then
		if v15(v20.AvengersShield) then
			return "avengers_shield standard 16";
		end
	end
	if (v20.HammerofWrath:IsReady() and v7:IsSpellInRange(v20.HammerofWrath)) then
		if v15(v20.HammerofWrath) then
			return "hammer_of_wrath standard 18";
		end
	end
	if (v20.Judgment:IsReady() and v7:IsSpellInRange(v20.Judgment) and ((v20.Judgment:Charges() >= (440 - (262 + 176))) or (v20.Judgment:FullRechargeTime() <= (v6:GCD() + (1721.25 - (345 + 1376)))))) then
		if v15(v20.Judgment) then
			return "judgment standard 20";
		end
	end
	if (v20.HolyBulwark:IsCastable() and (v20.HolyBulwark:Charges() == (690 - (198 + 490)))) then
		if v15(v20.HolyBulwark) then
			return "holy_armaments standard 22";
		end
	end
	if (v20.DivineToll:IsReady() and v7:IsInRange(132 - 102) and DivineTollSetting) then
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
	if (v20.Consecration:IsCastable() and v52() and v7:IsInMeleeRange(11 - 6) and (v6:BuffDown(v20.ConsecrationBuff))) then
		if v15(v20.Consecration) then
			return "consecration standard 30";
		end
	end
	if (v20.EyeofTyr:IsCastable() and EyeOfTyrSetting and v7:IsInMeleeRange(1214 - (696 + 510)) and ((v20.InmostLight:IsAvailable() and (v29 <= (1 - 0))) or (v29 >= (1265 - (1091 + 171)))) and not v20.LightsDeliverance:IsAvailable()) then
		if v15(v20.EyeofTyr) then
			return "eye_of_tyr standard 32";
		end
	end
	if v20.HolyBulwark:IsCastable() then
		if v15(v20.HolyBulwark) then
			return "holy_armaments standard 34";
		end
	end
	if (v20.BlessedHammer:IsCastable() and v7:IsInMeleeRange(1 + 4)) then
		if v15(v20.BlessedHammer) then
			return "blessed_hammer standard 36";
		end
	end
	if (v20.HammeroftheRighteous:IsCastable() and v7:IsInMeleeRange(15 - 10)) then
		if v15(v20.HammeroftheRighteous) then
			return "hammer_of_the_righteous standard 38";
		end
	end
	if (v20.CrusaderStrike:IsCastable() and v7:IsInMeleeRange(16 - 11)) then
		if v15(v20.CrusaderStrike) then
			return "crusader_strike standard 40";
		end
	end
	if (v20.AvengersShield:IsCastable() and v7:IsSpellInRange(v20.AvengersShield)) then
		if v15(v20.AvengersShield) then
			return "avengers_shield standard 48";
		end
	end
	if (v20.EyeofTyr:IsCastable() and EyeOfTyrSetting and v7:IsInMeleeRange(382 - (123 + 251)) and not v20.LightsDeliverance:IsAvailable()) then
		if v15(v20.EyeofTyr) then
			return "eye_of_tyr standard 50";
		end
	end
	if (v20.ArcaneTorrent:IsCastable() and v7:IsInMeleeRange(39 - 31) and RacialsSetting and (v6:HolyPower() < (703 - (208 + 490)))) then
		if v15(v20.ArcaneTorrent) then
			return "arcane_torrent standard 58";
		end
	end
	if (v20.Consecration:IsCastable() and v52() and v7:IsInMeleeRange(1 + 4) and (v6:BuffDown(v20.SanctificationEmpowerBuff))) then
		if v15(v20.Consecration) then
			return "consecration standard 60";
		end
	end
end
local function v65()
	if (v42() and v6:AffectingCombat() and (((v40:ID() == v21.ManicGrieftorch:ID()) and Trinket1Setting) or ((v41:ID() == v21.ManicGrieftorch:ID()) and Trinket2Setting)) and v49(v47.ProtTTD.TrinketsTTD) and v7:IsInRange(18 + 22)) then
		if v15(v21.ManicGrieftorch) then
			return "manic_grieftorch";
		end
	end
	if (v21.ElementiumPocketAnvil:IsEquippedAndReady() and v6:AffectingCombat() and (((v40:ID() == v21.ElementiumPocketAnvil:ID()) and Trinket1Setting) or ((v41:ID() == v21.ElementiumPocketAnvil:ID()) and Trinket2Setting)) and v7:IsInRange(841 - (660 + 176))) then
		if v15(v21.ElementiumPocketAnvil) then
			return "ElementiumPocketAnvil";
		end
	end
	if (v6:BuffUp(v20.AvengingWrathBuff) or not v20.AvengingWrath:IsAvailable() or v20.Sentinel:IsAvailable() or (v32 <= (5 + 35))) then
		local v91, v92, v93 = v6:GetUseableItems(v22);
		if v91 then
			if ((((v92 == (215 - (14 + 188))) and Trinket1Setting) or ((v92 == (689 - (534 + 141))) and Trinket2Setting)) and v7:IsInRange(v93) and v47.Commons.Enabled.Trinkets and v6:BuffDown(v20.ConcoctionKissofDeathBuff)) then
				if v15(v91, false) then
					return "Generic use_items for " .. v92 .. v91:Name();
				end
			end
		end
	end
end
local function v66()
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
	SmallCDToggle = v12.ToggleIconFrame:GetToggle(1 + 0);
	TabToggle = v12.ToggleIconFrame:GetToggle(2 + 0);
	InterruptToggle = v12.ToggleIconFrame:GetToggle(6 - 3);
	DispelToggle = v12.ToggleIconFrame:GetToggle(5 - 1);
	v27 = v6:GetEnemiesInRange(22 - 14);
	v28 = v6:GetEnemiesInRange(17 + 13);
	v34 = v45.UnitsinRange(v20.FlashofLight);
	if (v13()) then
		v29 = #v27;
		v30 = #v28;
	else
		v29 = 1 + 0;
		v30 = 397 - (115 + 281);
	end
	RacialsSetting = v50(v47.Protection.RacialsSetting) and v49(v47.ProtTTD.RacialsTTD);
	Trinket1Setting = v50(v47.Protection.Trinket1Setting, v47.Protection.TrinketHP);
	Trinket2Setting = v50(v47.Protection.Trinket2Setting, v47.Protection.TrinketHP);
	PotionSetting = v50(v47.Protection.PotionSetting) and not v45.ISSolo();
	DivineTollSetting = v50(v47.Protection.DivineTollSetting) and v49(v47.ProtTTD.DivineTollTTD) and v7:IsInRange(69 - 39);
	AvengingWrathSetting = v50(v47.Protection.AvengingWrathSetting) and v49(v47.ProtTTD.AvengingWrathTTD);
	EyeOfTyrSetting = v50(v47.Protection.EyeOfTyrSetting) and v49(13 + 2);
	if (v45.TargetIsValid() or v6:AffectingCombat()) then
		v25 = v6:ActiveMitigationNeeded();
		v26 = v6:IsTankingAoE(19 - 11) or v6:IsTanking(v7);
		v32 = v3.BossFightRemains();
		v31 = true;
		v33 = v32;
		if (v33 == (40741 - 29630)) then
			v31 = false;
			v33 = v3.FightRemains(v27, false);
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
			if (v6:DebuffElapsed(v20.EntangledDebuff) > (869 - (550 + 317))) then
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
			v38 = v45.InterruptCycle(v20.Rebuke, 7 - 2, true, nil, false);
			if v38 then
				return v38;
			end
			v38 = not v6:IsMoving() and v45.InterruptCycle(v20.HammerofJustice, 14 - 4, false, nil, true);
			if v38 then
				return v38;
			end
			v38 = not v6:IsMoving() and v45.InterruptCycle(v20.BlindingLight, 27 - 17, false, nil, true, true);
			if v38 then
				return v38;
			end
		end
		if (v7:AffectingCombat() or v47.Protection.AttackOutOfCombat) then
			if v26 then
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
			if (v20.Consecration:IsCastable() and v52() and v7:IsInMeleeRange(290 - (134 + 151)) and ((v3.CombatTime() < (1670 - (970 + 695))) or v47.ProtectionDefensives.MostDefensive) and (v6:BuffDown(v20.ConsecrationBuff) or (v6:BuffStack(v20.DivineGuidanceBuff) >= (9 - 4)))) then
				if v15(v20.Consecration) then
					return "consecration defensive";
				end
			end
			if (v20.BlessedHammer:IsCastable() and v7:IsInMeleeRange(2000 - (582 + 1408)) and (v3.CombatTime() < (17 - 12)) and (v20.BlessedHammer:TimeSinceLastCast() > (6 - 1)) and v47.ProtectionDefensives.MostDefensive) then
				if v15(v20.BlessedHammer) then
					return "blessed_hammer defensive";
				end
			end
			if (v20.ShieldoftheRighteous:IsReady() and v7:IsInMeleeRange(37 - 27) and v47.ProtectionDefensives.MostDefensive and v6:BuffDown(v20.ShieldoftheRighteousBuff)) then
				if v15(v20.ShieldoftheRighteous, true) then
					return "shield_of_the_righteous defensive";
				end
			end
			v38 = v63();
			if v38 then
				return v38;
			end
			if (v47.Commons.Enabled.Trinkets or v47.Commons.Enabled.Items) then
				v38 = v65();
				if v38 then
					return v38;
				end
			end
			v38 = v64();
			if v38 then
				return v38;
			end
		end
		v38 = (v29 > (1824 - (1195 + 629))) and not v7:IsInRange(10 - 2) and v48();
		if v38 then
			return v38;
		end
	end
end
local function v67()
	v47.Protection.Display();
	v12.ResetToggle();
	v12.ToggleIconFrame:AddButtonCustom("S", 242 - (187 + 54), "Small CDs", "smallcds");
	v12.ToggleIconFrame:AddButtonCustom("T", 782 - (162 + 618), "Tab", "tab");
	v12.ToggleIconFrame:AddButtonCustom("I", 3 + 0, "Interrupt", "interrupt");
	v12.ToggleIconFrame:AddButtonCustom("D", 3 + 1, "Dispel", "dispel");
	v45.PostInitialMessage(140 - 74);
end
v12.SetAPL(110 - 44, v66, v67);
