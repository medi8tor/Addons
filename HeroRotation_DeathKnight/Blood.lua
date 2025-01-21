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
local v13 = v12.Cast;
local v14 = v12.AoEON;
local v15 = v12.CDsON;
local v16 = v12.Commons().Everyone.num;
local v17 = v12.Commons().Everyone.bool;
local v18 = math.min;
local v19 = C_Timer.After;
local v20 = v12.Commons().DeathKnight;
local v21 = v10.DeathKnight.Blood;
local v22 = v11.DeathKnight.Blood;
local v23 = {v22.ManicGrieftorch:ID()};
local v24 = {v21.Lichborne,v21.IceboundFortitudeBuff,v21.RuneTapBuff};
local v25 = {v21.AntiMagicShell,v21.AntiMagicZone,v21.RuneTapBuff};
v6.NeedDefensive = function(v83, v84, v85)
	local v86 = v83:IncomingSpell(v84);
	local v87 = v83:IncomingSpell(v85);
	if (v86 or v87) then
		for v207, v208 in ipairs(v24) do
			if v83:BuffUp(v208) then
				return false;
			end
		end
		for v209, v210 in ipairs(v25) do
			if v83:BuffUp(v210) then
				return false;
			end
		end
		return true;
	end
	return false;
end;
local v27 = (v21.ReapersMark:IsAvailable() and (977 - (214 + 713))) or (17 + 48);
local v28 = (v21.ReapersMark:IsAvailable() and (2 + 7)) or (889 - (282 + 595));
local v29 = (1662 - (1523 + 114)) + (v16(v21.Heartbreaker:IsAvailable()) * (2 + 0));
local v30;
local v31;
local v32;
local v33;
local v34;
local v35;
local v36 = v20.GhoulTable;
local v37;
local v38 = 15839 - 4728;
local v39 = 12176 - (68 + 997);
local v40 = v21.HeartStrike:IsReady() or v21.VampiricStrikeAction:IsReady();
local v41 = (v21.Bonestorm:IsAvailable() and v21.Bonestorm:CooldownUp() and BonestormSetting and (v6:RunicPower() >= v6:RunicPowerMax())) or not v21.Bonestorm:IsAvailable() or v21.Bonestorm:CooldownDown() or not BonestormSetting;
local v42;
local v43 = v12.Commons().Everyone;
local v44 = v12.GUISettingsGet();
local v45 = {General=v44.General,Commons=v44.APL.DeathKnight.Commons,Defensives=v44.APL.DeathKnight.Blood.Defensives,Blood=v44.APL.DeathKnight.Blood,TTD=v44.APL.DeathKnight.Blood_TTD};
local v46, v47;
local v48, v49;
local v50, v51;
local v52, v53;
local v54, v55;
local v56, v57;
local v58, v59;
local v60, v61;
local v62 = 1270 - (226 + 1044);
local function v63()
	local v88, v89 = v6:GetTrinketData(v23);
	if ((v62 < (21 - 16)) and ((v88.ID == (117 - (32 + 85))) or (v89.ID == (0 + 0)) or (v88.Level == (0 + 0)) or (v89.Level == (957 - (892 + 65))) or ((v88.SpellID > (0 - 0)) and not v88.Usable) or ((v89.SpellID > (0 - 0)) and not v89.Usable))) then
		v62 = v62 + (1 - 0);
		v19(355 - (87 + 263), function()
			v63();
		end);
		return;
	end
	v46 = v88.Object;
	v47 = v89.Object;
	v48 = v88.ID;
	v49 = v89.ID;
	v50 = v88.Level;
	v51 = v89.Level;
	v52 = v88.Spell;
	v54 = v88.Range;
	v56 = v88.CastTime;
	v53 = v89.Spell;
	v55 = v89.Range;
	v57 = v89.CastTime;
	v58 = v88.Cooldown;
	v59 = v89.Cooldown;
	v60 = v88.Blacklisted;
	v61 = v89.Blacklisted;
end
v63();
v3:RegisterForEvent(function()
	v63();
end, "PLAYER_EQUIPMENT_CHANGED");
v5.IsTankingAllAoE = function(v106, v107, v108, v109)
	local v110 = v6:GetEnemiesInRange(v107 or (186.5 - (67 + 113)));
	local v111 = 0 + 0;
	local v112 = 0 - 0;
	for v167, v168 in pairs(v110) do
		if not (v108 and v108[v168:ID()]) then
			v111 = v111 + 1 + 0;
			if v106:IsTanking(v168, v109) then
				v112 = v112 + (3 - 2);
			end
		end
	end
	return v112 >= v111;
end;
local function v65()
	local v113 = v6:GetEnemiesInRange(992 - (802 + 150));
	for v169, v170 in pairs(v113) do
		if ((v170:NPCID() == (108654 - 68297)) or (v170:CastSpellID() == (812678 - 364665))) then
			print("npc found: do not use abo limb");
			return true;
		end
	end
	return false;
end
local function v66()
	if (v44.General.AutoTab and v6:AffectingCombat()) then
		v12.TopPanelAlternative:ChangeIcon(1 + 0, 1000 - (915 + 82));
		return "Auto tab to target";
	end
end
local function v67()
	return v22.ManicGrieftorch:IsEquipped() and (v22.ManicGrieftorch:CooldownUp() or (v22.ManicGrieftorch:CooldownRemains() <= v6:GCDRemains()));
end
local function v68()
	return v22.AlgetharPuzzleBox:IsEquipped() and (v22.AlgetharPuzzleBox:CooldownUp() or (v22.AlgetharPuzzleBox:CooldownRemains() <= v6:GCDRemains()));
end
v3:RegisterForEvent(function()
	v27 = (v21.ReapersMark:IsAvailable() and (141 - 91)) or (38 + 27);
	v28 = (v21.ReapersMark:IsAvailable() and (11 - 2)) or (1199 - (1069 + 118));
end, "SPELLS_CHANGED", "LEARNED_SPELL_IN_TAB");
local function v69(v114)
	return v37 or v43.ISSolo() or (v114 == (0 - 0)) or v43.Buggedmobs[v7:NPCID()] or ((v39 >= v114) and (v39 < (17011 - 9234)));
end
local function v70(v115, v116)
	return (v115 ~= "Not Used") and ((v69(v45.TTD.TrinketsTTD) and (((v115 == "With Cooldowns") and v12.CDsON()) or ((v115 == "With Small or Cooldowns") and (SmallCDToggle or v12.CDsON())) or ((v115 == "With Small CDs") and SmallCDToggle) or ((v115 == "On Mobcount") and (v33 >= v45.Blood.Mobcount)) or ((v115 == "On Mobcount or Cooldowns") and ((v33 >= v45.Blood.Mobcount) or v15())) or (v115 == "Always") or ((v115 == "On Bosses") and v37) or ((v115 == "Mobcount or Boss") and (v37 or (v33 >= v45.Blood.Mobcount))))) or ((v115 == "On HealthPercent") and (v116 ~= nil) and (v6:HealthPercentageWeighted() <= v116)));
end
local function v71(v117, v118, v119)
	if (v37 or v43.ISSolo() or (v119 == (0 + 0)) or ((v39 >= v119) and (v39 < (13817 - 6040)))) then
		v12.Cast(v117, v118);
		return "TTD cast " .. v117:Name();
	end
end
local v72 = v6:GetEquipment();
local v46 = (v72[13 + 0] and v11(v72[804 - (368 + 423)])) or v11(0 - 0);
local v47 = (v72[32 - (10 + 8)] and v11(v72[53 - 39])) or v11(442 - (416 + 26));
v3:RegisterForEvent(function()
	v72 = v6:GetEquipment();
	v46 = (v72[41 - 28] and v11(v72[6 + 7])) or v11(0 - 0);
	v47 = (v72[452 - (145 + 293)] and v11(v72[444 - (44 + 386)])) or v11(1486 - (998 + 488));
end, "PLAYER_EQUIPMENT_CHANGED");
local function v73(v120)
	local v121 = 0 + 0;
	for v171, v172 in pairs(v120) do
		if not v172:DebuffUp(v21.BloodPlagueDebuff) then
			v121 = v121 + 1 + 0;
		end
	end
	return v121;
end
local function v74(v122)
	for v173, v174 in pairs(v43.TankBustersList) do
		if v122:CastSpellID(v174) then
			return true;
		end
	end
	return false;
end
local function v75(v123)
	for v175, v176 in pairs(v43.TankBustersPhysicalList) do
		if v123:CastSpellID(v176) then
			return true;
		end
	end
	return false;
end
local function v76(v124)
	for v177, v178 in pairs(v43.TankBustersMagicList) do
		if v124:CastSpellID(v178) then
			return true;
		end
	end
	return false;
end
local function v77()
	if (v21.DeathsCaress:IsCastable() and v21.DeathsCaress:IsAvailable() and v7:IsSpellInRange(v21.DeathsCaress)) then
		if v13(v21.DeathsCaress) then
			return "deaths_caress precombat 2";
		end
	end
	if (v21.Marrowrend:IsReady() and v7:IsInMeleeRange(777 - (201 + 571))) then
		if v13(v21.Marrowrend) then
			return "marrowrend precombat 6";
		end
	end
end
local function v78()
	if (v21.RuneTap:IsReady() and v31 and (v21.RuneTap:Charges() > (1139 - (116 + 1022))) and ((v6:HealthPercentageWeighted() <= v45.Blood.Defensives.RuneTapThreshold) or (v6:NeedDefensive(v43.TankBustersList2, v43.TankBustersMagicList) and v45.Blood.Defensives.TankBusters)) and (v6:Rune() >= (12 - 9)) and (v21.RuneTap:Charges() >= (1 + 0)) and v6:BuffDown(v21.RuneTapBuff)) then
		if v13(v21.RuneTap, true) then
			return "rune_tap defensives 1";
		end
	end
	if (v21.Lichborne:IsCastable() and v31 and ((v6:HealthPercentageWeighted() <= v45.Blood.Defensives.LichborneHP) or (v6:NeedDefensive(v43.TankBustersList2, v43.TankBustersMagicList) and v45.Blood.Defensives.TankBusters))) then
		if v13(v21.Lichborne, true) then
			return "Lichborne defensives";
		end
	end
	if (v21.IceboundFortitude:IsCastable() and v31 and ((v6:HealthPercentageWeighted() <= v45.Blood.Defensives.IceboundFortitudeHP) or (v6:NeedDefensive(v43.TankBustersList2, v43.TankBustersMagicList) and v45.Blood.Defensives.TankBusters))) then
		if v13(v21.IceboundFortitude, true) then
			return "icebound_fortitude defensives";
		end
	end
	if (v21.RuneTap:IsReady() and v31 and ((v6:HealthPercentageWeighted() <= v45.Blood.Defensives.RuneTapThreshold) or (v6:NeedDefensive(v43.TankBustersList2, v43.TankBustersMagicList) and v45.Blood.Defensives.TankBusters)) and (v6:Rune() >= (10 - 7)) and (v21.RuneTap:Charges() >= (3 - 2)) and v6:BuffDown(v21.RuneTapBuff)) then
		if v13(v21.RuneTap, true) then
			return "rune_tap defensives 2";
		end
	end
	if (v21.AntiMagicShell:IsCastable() and v31 and ((v6:HealthPercentageWeighted() <= v45.Blood.Defensives.AntiMagicShellHP) or (v6:NeedDefensive(v43.TankBustersList2, v43.TankBustersMagicList) and v45.Blood.Defensives.TankBusters))) then
		if v13(v21.AntiMagicShell, true) then
			return "AntiMagicShell defensives";
		end
	end
	if (v21.AntiMagicZone:IsCastable() and v31 and ((v6:HealthPercentageWeighted() <= v45.Blood.Defensives.AntiMagicZoneHP) or (v6:NeedDefensive(v43.TankBustersList2, v43.TankBustersMagicList) and v45.Blood.Defensives.TankBusters and v45.Blood.Defensives.AntiMagicZoneOnTankBuster))) then
		if v12.CastTarget(v21.AntiMagicZone, v12.TName().PLAYER, true) then
			return "AntiMagicZone defensives";
		end
	end
	if (v21.VampiricBlood:IsCastable() and v31 and (v6:HealthPercentageWeighted() <= v45.Blood.Defensives.VampiricBloodThreshold)) then
		if v13(v21.VampiricBlood, true) then
			return "vampiric_blood defensives 14";
		end
	end
	if (v6:ActiveMitigationNeeded() and (v21.Marrowrend:TimeSinceLastCast() > (861.5 - (814 + 45))) and (v21.DeathStrike:TimeSinceLastCast() > (4.5 - 2))) then
		if (v21.DeathStrike:IsReady() and v7:IsSpellInRange(v21.DeathStrike) and (v6:BuffStack(v21.BoneShieldBuff) > (1 + 6))) then
			if v13(v21.DeathStrike) then
				return "death_strike defensives 4";
			end
		end
		if (v21.Marrowrend:IsReady() and v7:IsInMeleeRange(2 + 3)) then
			if v13(v21.Marrowrend) then
				return "marrowrend defensives 6";
			end
		end
		if (v21.DeathStrike:IsReady() and v7:IsSpellInRange(v21.DeathStrike)) then
			if v13(v21.DeathStrike) then
				return "death_strike defensives 10";
			end
		end
	end
	if (v21.DeathStrike:IsReady() and v7:IsSpellInRange(v21.DeathStrike) and (v6:HealthPercentageWeighted() <= ((935 - (261 + 624)) + (((v6:RunicPower() > v27) and (35 - 15)) or (1080 - (1020 + 60))))) and not v6:HealingAbsorbed()) then
		if v13(v21.DeathStrike) then
			return "death_strike defensives 18";
		end
	end
end
local function v79()
	v29 = (1448 - (630 + 793)) + (v33 * v16(v21.Heartbreaker:IsAvailable()) * (6 - 4));
	if (v45.Commons.Enabled.Potions and v6:BuffUp(v21.DancingRuneWeaponBuff)) then
		local v191 = v43.PotionSelected();
		if (v191 and v191:IsReady()) then
			v12.CastMacro(14 - 11, nil, nil, v191);
			return "Cast Potion";
		end
	end
	if (v21.DeathsCaress:IsReady() and v21.DeathsCaress:IsAvailable() and v7:IsSpellInRange(v21.DeathsCaress) and (v6:BuffDown(v21.BoneShieldBuff))) then
		if v13(v21.DeathsCaress) then
			return "deaths_caress deathbringer 4";
		end
	end
	if (v21.DeathStrike:IsReady() and v7:IsSpellInRange(v21.DeathStrike) and ((v6:BuffRemains(v21.CoagulopathyBuff) <= v6:GCD()) or (v6:RunicPowerDeficit() < (14 + 21)))) then
		if v13(v21.DeathStrike) then
			return "death_strike deathbringer 6";
		end
	end
	if (v21.BloodBoil:IsCastable() and ((v33 > (0 - 0)) or v7:IsInMeleeRange(1755 - (760 + 987))) and v6:BuffUp(v21.DancingRuneWeaponBuff) and (v6:BuffRemains(v21.DancingRuneWeaponBuff) >= ((1927 - (1789 + 124)) - ((768 - (745 + 21)) * v6:GCD())))) then
		if v13(v21.BloodBoil) then
			return "blood_boil deathbringer 8";
		end
	end
	if (v21.BloodBoil:IsCastable() and ((v33 > (0 + 0)) or v7:IsInMeleeRange(21 - 13)) and v7:DebuffUp(v21.ReapersMarkDebuff) and (v7:DebuffRemains(v21.ReapersMarkDebuff) < (11 - 8))) then
		if v13(v21.BloodBoil) then
			return "blood_boil deathbringer 10";
		end
	end
	if (v30 >= (1 + 9)) then
		local v192, v193, v194 = v6:GetUseableItems(v23);
		if v192 then
			if ((((v193 == (11 + 2)) and Trinket1Setting) or ((v193 == (1069 - (87 + 968))) and Trinket2Setting)) and v45.Commons.Enabled.Trinkets) then
				if v13(v192) then
					return "use_items deathbringer 12";
				end
			end
			if ((v193 ~= (57 - 44)) and (v193 ~= (13 + 1)) and v45.Commons.Enabled.Items) then
				v12.CastMacro(2 - 1);
				return "weapon cast";
			end
		end
	end
	if (v21.BloodBoil:IsCastable() and ((v33 > (1413 - (447 + 966))) or v7:IsInMeleeRange(21 - 13)) and ((v21.BloodPlagueDebuff:AuraActiveCount() == (1817 - (1703 + 114))) or ((v21.BloodBoil:ChargesFractional() >= (702 - (376 + 325))) and v7:DebuffUp(v21.ReapersMarkDebuff) and (v6:BuffRemains(v21.CoagulopathyBuff) > ((2 - 0) * v6:GCD()))))) then
		if v13(v21.BloodBoil) then
			return "blood_boil deathbringer 14";
		end
	end
	if (v21.DeathAndDecay:IsReady() and DnDSetting and ((v33 > (0 - 0)) or v7:IsInMeleeRange(3 + 5)) and ((v7:DebuffUp(v21.ReapersMarkDebuff) and not v6:DnDTicking()) or v6:BuffDown(v21.DeathAndDecayBuff))) then
		if v12.CastTarget(v21.DeathAndDecay, v12.TName().PLAYER) then
			return "death_and_decay deathbringer 16";
		end
	end
	if (v21.Marrowrend:IsReady() and v7:IsInMeleeRange(10 - 5) and (v6:BuffUp(v21.PainfulDeathBuff) or v6:BuffUp(v21.ExterminateBuff)) and (v6:RunicPowerDeficit() > (44 - (9 + 5))) and (v6:BuffRemains(v21.CoagulopathyBuff) > ((378 - (85 + 291)) * v6:GCD()))) then
		if v13(v21.Marrowrend) then
			return "marrowrend deathbringer 18";
		end
	end
	if (v21.RaiseDead:IsCastable() and RaiseDeadSetting) then
		if v13(v21.RaiseDead) then
			return "raise_dead deathbringer 20";
		end
	end
	if (v21.AbominationLimb:IsCastable() and AbominationLimbSetting and v7:IsInRange(1285 - (243 + 1022)) and (v7:DebuffUp(v21.ReapersMarkDebuff))) then
		if v13(v21.AbominationLimb) then
			return "abomination_limb deathbringer 22";
		end
	end
	if (v21.ReapersMark:IsReady() and ReapersMarkSetting and v7:IsInMeleeRange(19 - 14) and (v7:DebuffDown(v21.ReapersMarkDebuff))) then
		if v13(v21.ReapersMark) then
			return "reapers_mark deathbringer 24";
		end
	end
	if (v21.Bonestorm:IsReady() and BonestormSetting and v7:IsInMeleeRange(7 + 1) and (v30 >= (1185 - (1123 + 57))) and (v21.DancingRuneWeapon:CooldownRemains() >= (9 + 1)) and v7:DebuffUp(v21.ReapersMarkDebuff)) then
		if v13(v21.Bonestorm) then
			return "bonestorm deathbringer 26";
		end
	end
	if (v21.Consumption:IsCastable() and v7:IsInMeleeRange(259 - (163 + 91)) and (v7:DebuffUp(v21.ReapersMarkDebuff))) then
		if v13(v21.Consumption) then
			return "consumption deathbringer 28";
		end
	end
	if (v21.AbominationLimb:IsCastable() and AbominationLimbSetting and v7:IsInRange(1950 - (1869 + 61))) then
		if v13(v21.AbominationLimb) then
			return "abomination_limb deathbringer 30";
		end
	end
	if (v21.Blooddrinker:IsReady() and v7:IsSpellInRange(v21.Blooddrinker) and (v6:BuffRemains(v21.CoagulopathyBuff) > (2 + 2)) and v6:BuffDown(v21.DancingRuneWeaponBuff)) then
		if v13(v21.Blooddrinker) then
			return "blooddrinker deathbringer 32";
		end
	end
	if (v21.DancingRuneWeapon:IsCastable() and DancingRuneWeaponSetting and v7:IsInMeleeRange(28 - 20) and v6:BuffDown(v21.DancingRuneWeaponBuff) and (v6:BuffRemains(v21.CoagulopathyBuff) > ((2 - 0) * v6:GCD()))) then
		if v13(v21.DancingRuneWeapon) then
			return "dancing_rune_weapon deathbringer 34";
		end
	end
	if (v21.Marrowrend:IsReady() and v7:IsInMeleeRange(1 + 4) and not v6:BonestormTicking() and (((v30 < v28) and (v6:RunicPowerDeficit() > (27 - 7))) or (v6:BuffRemains(v21.BoneShieldBuff) <= (3 + 0)))) then
		if v13(v21.Marrowrend) then
			return "marrowrend deathbringer 36";
		end
	end
	if (v21.DancingRuneWeapon:CooldownUp() and RacialsSetting and v7:IsInMeleeRange(1482 - (1329 + 145))) then
		if v21.BloodFury:IsCastable() then
			if v13(v21.BloodFury) then
				return "blood_fury deathbringer 38";
			end
		end
		if v21.Berserking:IsCastable() then
			if v13(v21.Berserking) then
				return "berserking deathbringer 40";
			end
		end
	end
	if (v21.Tombstone:IsReady() and v7:IsInMeleeRange(979 - (140 + 831)) and v21.Bonestorm:CooldownUp() and (v30 > (1860 - (1409 + 441))) and (v6:RunicPowerDeficit() >= (748 - (15 + 703))) and (v21.DancingRuneWeapon:CooldownRemains() >= (5 + 5))) then
		if v13(v21.Tombstone) then
			return "tombstone deathbringer 42";
		end
	end
	if (v21.Bonestorm:IsReady() and BonestormSetting and v7:IsInMeleeRange(446 - (262 + 176)) and (v30 > (1726 - (345 + 1376))) and (v21.DancingRuneWeapon:CooldownRemains() >= (698 - (198 + 490)))) then
		if v13(v21.Bonestorm) then
			return "bonestorm deathbringer 44";
		end
	end
	if (v21.Tombstone:IsReady() and v7:IsInMeleeRange(35 - 27) and (v30 > (11 - 6)) and (v6:RunicPowerDeficit() >= (1236 - (696 + 510))) and (v21.DancingRuneWeapon:CooldownRemains() >= (20 - 10))) then
		if v13(v21.Tombstone) then
			return "tombstone deathbringer 46";
		end
	end
	if (v21.SoulReaper:IsReady() and v7:IsInMeleeRange(1267 - (1091 + 171)) and (v33 == (1 + 0)) and (v7:TimeToX(110 - 75) < (16 - 11)) and (v7:TimeToDie() > (v7:DebuffRemains(v21.SoulReaperDebuff) + (379 - (123 + 251))))) then
		if v13(v21.SoulReaper) then
			return "soul_reaper deathbringer 48";
		end
	end
	if (v21.BloodBoil:IsCastable() and ((v33 > (0 - 0)) or v7:IsInMeleeRange(706 - (208 + 490))) and ((v21.BloodBoil:Charges() >= (1 + 1)) or (v21.BloodBoil:FullRechargeTime() <= v6:GCD()))) then
		if v13(v21.BloodBoil) then
			return "blood_boil deathbringer 50";
		end
	end
	if (v21.Consumption:IsCastable() and v7:IsInMeleeRange(3 + 2)) then
		if v13(v21.Consumption) then
			return "consumption deathbringer 52";
		end
	end
	if (v21.DeathStrike:IsReady() and v7:IsSpellInRange(v21.DeathStrike) and ((v6:RunicPowerDeficit() <= v29) or (v6:RunicPower() >= v27))) then
		if v13(v21.DeathStrike) then
			return "death_strike deathbringer 54";
		end
	end
	if (v21.BloodTap:IsCastable() and (v6:Rune() <= (837 - (660 + 176)))) then
		if v13(v21.BloodTap) then
			return "blood_tap deathbringer 56";
		end
	end
	if (v21.BloodBoil:IsCastable() and ((v33 > (0 + 0)) or v7:IsInMeleeRange(210 - (14 + 188))) and (v21.BloodBoil:ChargesFractional() >= (676.1 - (534 + 141))) and (v6:BuffStack(v21.HemostasisBuff) < (3 + 2))) then
		if v13(v21.BloodBoil) then
			return "blood_boil deathbringer 58";
		end
	end
	if (v40 and v7:IsInMeleeRange(5 + 0) and ((v6:RuneTimeToX(2 + 0) < v6:GCD()) or (v6:RunicPowerDeficit() >= v29))) then
		if v13(v21.HeartStrike) then
			return "heart_strike deathbringer 60";
		end
	end
	if (v21.BloodBoil:IsCastable() and ((v33 > (0 - 0)) or v7:IsInMeleeRange(12 - 4))) then
		if v13(v21.BloodBoil) then
			return "blood_boil deathbringer 62";
		end
	end
end
local function v80()
	v29 = (70 - 45) + (v33 * v16(v21.Heartbreaker:IsAvailable()) * (2 + 0));
	if (v45.Commons.Enabled.Potions and v6:BuffUp(v21.DancingRuneWeaponBuff)) then
		local v195 = v43.PotionSelected();
		if (v195 and v195:IsReady()) then
			if (v195 and v195:IsReady()) then
				v12.CastMacro(2 + 1, nil, nil, v195);
				return "Cast Potion";
			end
		end
	end
	if (v40 and v7:IsInMeleeRange(401 - (115 + 281)) and v6:BuffUp(v21.VampiricBloodBuff) and (v6:BuffRemains(v21.EssenceoftheBloodQueenBuff) < ((4 - 2) * v6:GCD()))) then
		if v13(v21.HeartStrike) then
			return "heart_strike sanlayn 4";
		end
	end
	if (v40 and v7:IsInMeleeRange(5 + 0) and v21.VampiricStrikeAction:IsLearned() and (v6:BuffRemains(v21.EssenceoftheBloodQueenBuff) < (7 - 4))) then
		if v13(v21.HeartStrike) then
			return "heart_strike sanlayn 6";
		end
	end
	if (v21.VampiricBlood:IsCastable() and not (v21.Bonestorm:CooldownUp() or v21.DancingRuneWeapon:CooldownUp() or v21.Tombstone:CooldownUp()) and v31 and (v6:HealthPercentageWeighted() <= v45.Blood.Defensives.VampiricBloodThreshold)) then
		if v13(v21.VampiricBlood) then
			return "vampiric_blood sanlayn 8";
		end
	end
	if (v21.DeathsCaress:IsReady() and v7:IsSpellInRange(v21.DeathsCaress) and (v6:BuffDown(v21.BoneShieldBuff))) then
		if v13(v21.DeathsCaress) then
			return "deaths_caress sanlayn 10";
		end
	end
	if (v21.DeathStrike:IsReady() and v7:IsInMeleeRange(18 - 13) and (v6:BuffRemains(v21.CoagulopathyBuff) <= v6:GCD())) then
		if v13(v21.DeathStrike) then
			return "death_strike sanlayn 12";
		end
	end
	if ((v45.Commons.Enabled.Trinkets or v45.Commons.Enabled.Items) and (v30 >= (877 - (550 + 317)))) then
		local v196, v197, v198 = v6:GetUseableItems(v23);
		if v196 then
			if ((((v197 == (18 - 5)) and Trinket1Setting) or ((v197 == (18 - 4)) and Trinket2Setting)) and v45.Commons.Enabled.Trinkets) then
				if v13(v196) then
					return "use_items sanlayn 12";
				end
			end
			if ((v197 ~= (36 - 23)) and (v197 ~= (299 - (134 + 151))) and v45.Commons.Enabled.Items) then
				v12.CastMacro(1666 - (970 + 695));
				return "weapon cast";
			end
		end
	end
	if (v21.BloodBoil:IsReady() and ((v33 > (0 - 0)) or v7:IsInMeleeRange(1998 - (582 + 1408))) and (v7:DebuffDown(v21.BloodPlagueDebuff))) then
		if v13(v21.BloodBoil) then
			return "blood_boil sanlayn 16";
		end
	end
	if (v21.DeathAndDecay:IsReady() and DnDSetting and ((v33 > (0 - 0)) or v7:IsInMeleeRange(9 - 1)) and not v6:DnDTicking()) then
		if v12.CastTarget(v21.DeathAndDecay, v12.TName().PLAYER) then
			return "death_and_decay sanlayn 18";
		end
	end
	if (v21.RaiseDead:IsCastable() and RaiseDeadSetting and v7:IsInMeleeRange(30 - 22)) then
		if v13(v21.RaiseDead) then
			return "raise_dead sanlayn 20";
		end
	end
	if (v21.DancingRuneWeapon:IsCastable() and v7:IsInMeleeRange(1832 - (1195 + 629)) and DancingRuneWeaponSetting and (v6:BuffDown(v21.DancingRuneWeaponBuff))) then
		if v13(v21.DancingRuneWeapon) then
			return "dancing_rune_weapon sanlayn 22";
		end
	end
	if (v21.Marrowrend:IsReady() and v7:IsInMeleeRange(6 - 1) and not v6:BonestormTicking() and (((v30 < v28) and (v6:RunicPowerDeficit() > (261 - (187 + 54)))) or (v6:BuffRemains(v21.BoneShieldBuff) <= (783 - (162 + 618))))) then
		if v13(v21.Marrowrend) then
			return "marrowrend sanlayn 24";
		end
	end
	if (v21.Consumption:IsCastable() and v7:IsSpellInRange(v21.Consumption) and ((v6:BuffRemains(v21.VampiricBloodBuff) <= (3 + 0)) or v6:BuffUp(v21.InflictionofSorrowBuff) or (v21.VampiricBlood:CooldownRemains() > (4 + 1)))) then
		if v13(v21.Consumption) then
			return "consumption sanlayn 26";
		end
	end
	if (v21.DeathStrike:IsReady() and v7:IsSpellInRange(v21.DeathStrike) and v6:BuffUp(v21.VampiricBloodBuff) and (v6:BuffRemains(v21.CoagulopathyBuff) < (6 - 3))) then
		if v13(v21.DeathStrike) then
			return "death_strike sanlayn 28";
		end
	end
	if (v40 and v7:IsInMeleeRange(8 - 3) and (v21.VampiricStrikeAction:IsLearned())) then
		if v13(v21.HeartStrike) then
			return "heart_strike sanlayn 30";
		end
	end
	if (v21.AbominationLimb:IsCastable() and AbominationLimbSetting and v7:IsInRange(2 + 18)) then
		if v13(v21.AbominationLimb) then
			return "abomination_limb sanlayn 32";
		end
	end
	if (v21.DancingRuneWeapon:CooldownUp() and RacialsSetting and v7:IsInMeleeRange(1644 - (1373 + 263))) then
		if v21.BloodFury:IsCastable() then
			if v13(v21.BloodFury) then
				return "blood_fury sanlayn 34";
			end
		end
		if v21.Berserking:IsCastable() then
			if v13(v21.Berserking) then
				return "berserking sanlayn 36";
			end
		end
	end
	if (v21.Bonestorm:IsReady() and BonestormSetting and v7:IsInMeleeRange(1008 - (451 + 549)) and (v30 > (2 + 3)) and (v21.DancingRuneWeapon:CooldownRemains() >= (38 - 13))) then
		if v13(v21.Bonestorm) then
			return "bonestorm sanlayn 38";
		end
	end
	if (v21.Tombstone:IsReady() and v7:IsInMeleeRange(13 - 5) and (v30 > (1389 - (746 + 638))) and (v6:RunicPowerDeficit() >= (12 + 18)) and (v21.DancingRuneWeapon:CooldownRemains() >= (37 - 12))) then
		if v13(v21.Tombstone) then
			return "tombstone sanlayn 40";
		end
	end
	if (v21.SoulReaper:IsReady() and v7:IsInMeleeRange(346 - (218 + 123)) and (v33 == (1582 - (1535 + 46))) and (v7:TimeToX(35 + 0) < (1 + 4)) and (v7:TimeToDie() > (v7:DebuffRemains(v21.SoulReaperDebuff) + (565 - (306 + 254))))) then
		if v13(v21.SoulReaper) then
			return "soul_reaper sanlayn 42";
		end
	end
	if (v21.BloodBoil:IsCastable() and ((v33 > (0 + 0)) or v7:IsInMeleeRange(15 - 7)) and ((v21.BloodBoil:Charges() >= (1469 - (899 + 568))) or (v21.BloodBoil:FullRechargeTime() <= v6:GCD()))) then
		if v13(v21.BloodBoil) then
			return "blood_boil sanlayn 44";
		end
	end
	if (v21.DeathStrike:IsReady() and v7:IsSpellInRange(v21.DeathStrike) and ((v6:RunicPowerDeficit() <= v29) or (v6:RunicPower() >= v27))) then
		if v13(v21.DeathStrike) then
			return "death_strike sanlayn 46";
		end
	end
	if (v21.BloodBoil:IsCastable() and ((v33 > (0 + 0)) or v7:IsInMeleeRange(19 - 11))) then
		if v13(v21.BloodBoil) then
			return "blood_boil sanlayn 48";
		end
	end
end
local function v81()
	if v6:IsChanneling(v22.ManicGrieftorch.ItemUseSpell) then
		return "Dont cut Torch";
	end
	v32 = v6:GetEnemiesInMeleeRange(611 - (268 + 335));
	InterruptToggle = v12.ToggleIconFrame:GetToggle(293 - (60 + 230));
	SmallCDToggle = v12.ToggleIconFrame:GetToggle(573 - (426 + 146));
	if v14() then
		v33 = #v32;
	else
		v33 = 1 + 0;
	end
	if (v43.TargetIsValid() or v6:AffectingCombat()) then
		v34 = v18(v33, (v6:BuffUp(v21.DeathAndDecayBuff) and (1461 - (282 + 1174))) or (813 - (569 + 242)));
		v35 = v73(v32);
		v31 = v6:IsTankingAoE(22 - 14) or v6:IsTanking(v7);
		v30 = v6:BuffStack(v21.BoneShieldBuff);
	end
	if (v43.TargetIsValid() or v6:AffectingCombat()) then
		v38 = v3.BossFightRemains();
		v37 = true;
		v39 = v38;
		if (v39 == (636 + 10475)) then
			v37 = false;
			v39 = v3.FightRemains(v32, false);
		end
	end
	DnDSetting = v12.ToggleIconFrame:GetToggle(1028 - (706 + 318)) and (v45.Commons.DnDMoving or not v6:IsMoving()) and v69(1259 - (721 + 530));
	v40 = v21.HeartStrike:IsReady() or v21.VampiricStrikeAction:IsReady();
	RacialsSetting = v70(v45.Blood.RacialsSetting) and v69(v45.TTD.RacialsTTD) and v7:IsInMeleeRange(1276 - (945 + 326));
	Trinket1Setting = v70(v45.Blood.Trinket1Setting, v45.Blood.TrinketHP);
	Trinket2Setting = v70(v45.Blood.Trinket2Setting, v45.Blood.TrinketHP);
	PotionSetting = v70(v45.Blood.PotionSetting) and not v43.ISSolo() and v7:IsInMeleeRange(12 - 7);
	AbominationLimbSetting = v70(v45.Blood.AbominationLimbSetting) and not v65() and v69(v45.TTD.AbominationLimbTTD) and v7:IsInMeleeRange(14 + 1);
	EmpowerRuneWeaponSetting = v70(v45.Blood.EmpowerRuneWeaponSetting) and v69(v45.TTD.EmpowerRuneWeaponTTD) and v7:IsInMeleeRange(705 - (271 + 429));
	DancingRuneWeaponSetting = v70(v45.Blood.DancingRuneWeaponSetting, v45.Blood.DancingRuneWeaponHP) and v69(v45.TTD.DancingRuneWeaponTTD) and v7:IsInMeleeRange(5 + 0);
	RaiseDeadSetting = v70(v45.Blood.RaiseDeadSetting) and v69(v45.TTD.RaiseDeadTTD) and v7:IsInMeleeRange(1505 - (1408 + 92));
	WeaponSetting = v70(v45.Blood.Weapon);
	ReapersMarkSetting = v70(v45.Blood.ReapersMarkSetting) and v69(1101 - (461 + 625));
	BonestormSetting = v70(v45.Blood.Bonestorm) and v69(1303 - (993 + 295));
	if (v21.RaiseAlly:IsReady() and v45.Commons.RaiseAlly) then
		if (v8:UnitIsFriend() and v8:UnitIsPlayer() and v8:Exists() and v8:IsDeadOrGhost()) then
			v12.CastTarget(v21.RaiseAlly, v12.TName().MOUSEOVER);
			return "Raise Ally on Mouseover";
		end
		if (v7:UnitIsFriend() and v7:UnitIsPlayer() and v7:Exists() and v7:IsDeadOrGhost()) then
			v12.Cast(v21.RaiseAlly);
			return "Raise Ally on Target";
		end
	end
	if (v43.TargetIsValid() and (v7:AffectingCombat() or v45.Blood.AttackOutOfCombat)) then
		if not v6:AffectingCombat() then
			v42 = v77();
			if v42 then
				return v42;
			end
		end
		if v31 then
			v42 = v78();
			if v42 then
				return v42;
			end
		end
		if InterruptToggle then
			v42 = v43.InterruptCycle(v21.MindFreeze, 1 + 14, true, nil, false);
			if v42 then
				return v42;
			end
			if v45.Commons.BlindingSleet then
				v42 = v43.InterruptCycle(v21.BlindingSleet, 1183 - (418 + 753), true, nil, true, true);
				if v42 then
					return v42;
				end
			end
			v42 = v43.InterruptCycle(v21.Asphyxiate, 8 + 12, true, nil, true);
			if v42 then
				return v42;
			end
		end
		if (v21.BloodBoil:IsCastable() and ((v33 > (0 + 0)) or v7:IsInMeleeRange(3 + 5)) and (v35 > (0 + 0))) then
			if v13(v21.BloodBoil) then
				return "blood_boil missing Plague";
			end
		end
		if ((v6:HeroTreeID() == (562 - (406 + 123))) or (v6:Level() <= (1839 - (1749 + 20)))) then
			local v215 = v79();
			if v215 then
				return v215;
			end
			local v215 = ((v33 > (0 + 0)) or v7:IsInMeleeRange(1330 - (1249 + 73))) and not v7:IsInRange(3 + 5) and v66();
			if v215 then
				return v215;
			end
			if v12.CastAnnotated(v21.Pool, false, "WAIT") then
				return "Pool for Deathbringer()";
			end
		end
		if (v6:HeroTreeID() == (1176 - (466 + 679))) then
			local v216 = v80();
			if v216 then
				return v216;
			end
			local v216 = ((v33 > (0 - 0)) or v7:IsInMeleeRange(22 - 14)) and not v7:IsInRange(1908 - (106 + 1794)) and v66();
			if v216 then
				return v216;
			end
			if v12.CastAnnotated(v21.Pool, false, "WAIT") then
				return "Pool for Sanlayn()";
			end
		end
	end
end
local function v82()
	v21.BloodPlagueDebuff:RegisterAuraTracking();
	v45.Blood.Display();
	v12:UpdateMacro("macro1", "/use 16");
	v12:UpdateMacro("macro2", "/target [@mouseover]");
	v12.Print("Blood Death Knight rotation has been updated for patch 11.0.2.");
end
v12.SetAPL(80 + 170, v81, v82);
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
local v13 = v12.Cast;
local v14 = v12.AoEON;
local v15 = v12.CDsON;
local v16 = v12.Commons().Everyone.num;
local v17 = v12.Commons().Everyone.bool;
local v18 = math.min;
local v19 = C_Timer.After;
local v20 = v12.Commons().DeathKnight;
local v21 = v10.DeathKnight.Blood;
local v22 = v11.DeathKnight.Blood;
local v23 = {v22.ManicGrieftorch:ID()};
local v24 = {v21.Lichborne,v21.IceboundFortitudeBuff,v21.RuneTapBuff};
local v25 = {v21.AntiMagicShell,v21.AntiMagicZone,v21.RuneTapBuff};
v6.NeedDefensive = function(v125, v126, v127)
	local v128 = v125:IncomingSpell(v126);
	local v129 = v125:IncomingSpell(v127);
	if (v128 or v129) then
		for v211, v212 in ipairs(v24) do
			if v125:BuffUp(v212) then
				return false;
			end
		end
		for v213, v214 in ipairs(v25) do
			if v125:BuffUp(v214) then
				return false;
			end
		end
		return true;
	end
	return false;
end;
local v27 = (v21.ReapersMark:IsAvailable() and (34 + 16)) or (144 - 79);
local v28 = (v21.ReapersMark:IsAvailable() and (26 - 17)) or (178 - (122 + 44));
local v29 = (43 - 18) + (v16(v21.Heartbreaker:IsAvailable()) * (6 - 4));
local v30;
local v31;
local v32;
local v33;
local v34;
local v35;
local v36 = v20.GhoulTable;
local v37;
local v38 = 9039 + 2072;
local v39 = 1607 + 9504;
local v40 = v21.HeartStrike:IsReady() or v21.VampiricStrikeAction:IsReady();
local v41 = (v21.Bonestorm:IsAvailable() and v21.Bonestorm:CooldownUp() and BonestormSetting and (v6:RunicPower() >= v6:RunicPowerMax())) or not v21.Bonestorm:IsAvailable() or v21.Bonestorm:CooldownDown() or not BonestormSetting;
local v42;
local v43 = v12.Commons().Everyone;
local v44 = v12.GUISettingsGet();
local v45 = {General=v44.General,Commons=v44.APL.DeathKnight.Commons,Defensives=v44.APL.DeathKnight.Blood.Defensives,Blood=v44.APL.DeathKnight.Blood,TTD=v44.APL.DeathKnight.Blood_TTD};
local v46, v47;
local v48, v49;
local v50, v51;
local v52, v53;
local v54, v55;
local v56, v57;
local v58, v59;
local v60, v61;
local v62 = 0 - 0;
local function v63()
	local v130, v131 = v6:GetTrinketData(v23);
	if ((v62 < (70 - (30 + 35))) and ((v130.ID == (0 + 0)) or (v131.ID == (1257 - (1043 + 214))) or (v130.Level == (0 - 0)) or (v131.Level == (1212 - (323 + 889))) or ((v130.SpellID > (0 - 0)) and not v130.Usable) or ((v131.SpellID > (580 - (361 + 219))) and not v131.Usable))) then
		v62 = v62 + (321 - (53 + 267));
		v19(2 + 3, function()
			v63();
		end);
		return;
	end
	v46 = v130.Object;
	v47 = v131.Object;
	v48 = v130.ID;
	v49 = v131.ID;
	v50 = v130.Level;
	v51 = v131.Level;
	v52 = v130.Spell;
	v54 = v130.Range;
	v56 = v130.CastTime;
	v53 = v131.Spell;
	v55 = v131.Range;
	v57 = v131.CastTime;
	v58 = v130.Cooldown;
	v59 = v131.Cooldown;
	v60 = v130.Blacklisted;
	v61 = v131.Blacklisted;
end
v63();
v3:RegisterForEvent(function()
	v63();
end, "PLAYER_EQUIPMENT_CHANGED");
v5.IsTankingAllAoE = function(v148, v149, v150, v151)
	local v152 = v6:GetEnemiesInRange(v149 or (419.5 - (15 + 398)));
	local v153 = 982 - (18 + 964);
	local v154 = 0 - 0;
	for v179, v180 in pairs(v152) do
		if not (v150 and v150[v180:ID()]) then
			v153 = v153 + 1 + 0;
			if v148:IsTanking(v180, v151) then
				v154 = v154 + 1 + 0;
			end
		end
	end
	return v154 >= v153;
end;
local function v65()
	local v155 = v6:GetEnemiesInRange(890 - (20 + 830));
	for v181, v182 in pairs(v155) do
		if ((v182:NPCID() == (31503 + 8854)) or (v182:CastSpellID() == (448139 - (116 + 10)))) then
			print("npc found: do not use abo limb");
			return true;
		end
	end
	return false;
end
local function v66()
	if (v44.General.AutoTab and v6:AffectingCombat()) then
		v12.TopPanelAlternative:ChangeIcon(1 + 0, 741 - (542 + 196));
		return "Auto tab to target";
	end
end
local function v67()
	return v22.ManicGrieftorch:IsEquipped() and (v22.ManicGrieftorch:CooldownUp() or (v22.ManicGrieftorch:CooldownRemains() <= v6:GCDRemains()));
end
local function v68()
	return v22.AlgetharPuzzleBox:IsEquipped() and (v22.AlgetharPuzzleBox:CooldownUp() or (v22.AlgetharPuzzleBox:CooldownRemains() <= v6:GCDRemains()));
end
v3:RegisterForEvent(function()
	v27 = (v21.ReapersMark:IsAvailable() and (107 - 57)) or (19 + 46);
	v28 = (v21.ReapersMark:IsAvailable() and (5 + 4)) or (5 + 7);
end, "SPELLS_CHANGED", "LEARNED_SPELL_IN_TAB");
local function v69(v156)
	return v37 or v43.ISSolo() or (v156 == (0 - 0)) or v43.Buggedmobs[v7:NPCID()] or ((v39 >= v156) and (v39 < (19938 - 12161)));
end
local function v70(v157, v158)
	return (v157 ~= "Not Used") and ((v69(v45.TTD.TrinketsTTD) and (((v157 == "With Cooldowns") and v12.CDsON()) or ((v157 == "With Small or Cooldowns") and (SmallCDToggle or v12.CDsON())) or ((v157 == "With Small CDs") and SmallCDToggle) or ((v157 == "On Mobcount") and (v33 >= v45.Blood.Mobcount)) or ((v157 == "On Mobcount or Cooldowns") and ((v33 >= v45.Blood.Mobcount) or v15())) or (v157 == "Always") or ((v157 == "On Bosses") and v37) or ((v157 == "Mobcount or Boss") and (v37 or (v33 >= v45.Blood.Mobcount))))) or ((v157 == "On HealthPercent") and (v158 ~= nil) and (v6:HealthPercentageWeighted() <= v158)));
end
local function v71(v159, v160, v161)
	if (v37 or v43.ISSolo() or (v161 == (1551 - (1126 + 425))) or ((v39 >= v161) and (v39 < (8182 - (118 + 287))))) then
		v12.Cast(v159, v160);
		return "TTD cast " .. v159:Name();
	end
end
local v72 = v6:GetEquipment();
local v46 = (v72[50 - 37] and v11(v72[1134 - (118 + 1003)])) or v11(0 - 0);
local v47 = (v72[391 - (142 + 235)] and v11(v72[63 - 49])) or v11(0 + 0);
v3:RegisterForEvent(function()
	v72 = v6:GetEquipment();
	v46 = (v72[990 - (553 + 424)] and v11(v72[23 - 10])) or v11(0 + 0);
	v47 = (v72[14 + 0] and v11(v72[9 + 5])) or v11(0 + 0);
end, "PLAYER_EQUIPMENT_CHANGED");
local function v73(v162)
	local v163 = 0 + 0;
	for v183, v184 in pairs(v162) do
		if not v184:DebuffUp(v21.BloodPlagueDebuff) then
			v163 = v163 + (2 - 1);
		end
	end
	return v163;
end
local function v74(v164)
	for v185, v186 in pairs(v43.TankBustersList) do
		if v164:CastSpellID(v186) then
			return true;
		end
	end
	return false;
end
local function v75(v165)
	for v187, v188 in pairs(v43.TankBustersPhysicalList) do
		if v165:CastSpellID(v188) then
			return true;
		end
	end
	return false;
end
local function v76(v166)
	for v189, v190 in pairs(v43.TankBustersMagicList) do
		if v166:CastSpellID(v190) then
			return true;
		end
	end
	return false;
end
local function v77()
	if (v21.DeathsCaress:IsCastable() and v21.DeathsCaress:IsAvailable() and v7:IsSpellInRange(v21.DeathsCaress)) then
		if v13(v21.DeathsCaress) then
			return "deaths_caress precombat 2";
		end
	end
	if (v21.Marrowrend:IsReady() and v7:IsInMeleeRange(13 - 8)) then
		if v13(v21.Marrowrend) then
			return "marrowrend precombat 6";
		end
	end
end
local function v78()
	if (v21.RuneTap:IsReady() and v31 and (v21.RuneTap:Charges() > (2 - 1)) and ((v6:HealthPercentageWeighted() <= v45.Blood.Defensives.RuneTapThreshold) or (v6:NeedDefensive(v43.TankBustersList2, v43.TankBustersMagicList) and v45.Blood.Defensives.TankBusters)) and (v6:Rune() >= (1 + 2)) and (v21.RuneTap:Charges() >= (4 - 3)) and v6:BuffDown(v21.RuneTapBuff)) then
		if v13(v21.RuneTap, true) then
			return "rune_tap defensives 1";
		end
	end
	if (v21.Lichborne:IsCastable() and v31 and ((v6:HealthPercentageWeighted() <= v45.Blood.Defensives.LichborneHP) or (v6:NeedDefensive(v43.TankBustersList2, v43.TankBustersMagicList) and v45.Blood.Defensives.TankBusters))) then
		if v13(v21.Lichborne, true) then
			return "Lichborne defensives";
		end
	end
	if (v21.IceboundFortitude:IsCastable() and v31 and ((v6:HealthPercentageWeighted() <= v45.Blood.Defensives.IceboundFortitudeHP) or (v6:NeedDefensive(v43.TankBustersList2, v43.TankBustersMagicList) and v45.Blood.Defensives.TankBusters))) then
		if v13(v21.IceboundFortitude, true) then
			return "icebound_fortitude defensives";
		end
	end
	if (v21.RuneTap:IsReady() and v31 and ((v6:HealthPercentageWeighted() <= v45.Blood.Defensives.RuneTapThreshold) or (v6:NeedDefensive(v43.TankBustersList2, v43.TankBustersMagicList) and v45.Blood.Defensives.TankBusters)) and (v6:Rune() >= (756 - (239 + 514))) and (v21.RuneTap:Charges() >= (1 + 0)) and v6:BuffDown(v21.RuneTapBuff)) then
		if v13(v21.RuneTap, true) then
			return "rune_tap defensives 2";
		end
	end
	if (v21.AntiMagicShell:IsCastable() and v31 and ((v6:HealthPercentageWeighted() <= v45.Blood.Defensives.AntiMagicShellHP) or (v6:NeedDefensive(v43.TankBustersList2, v43.TankBustersMagicList) and v45.Blood.Defensives.TankBusters))) then
		if v13(v21.AntiMagicShell, true) then
			return "AntiMagicShell defensives";
		end
	end
	if (v21.AntiMagicZone:IsCastable() and v31 and ((v6:HealthPercentageWeighted() <= v45.Blood.Defensives.AntiMagicZoneHP) or (v6:NeedDefensive(v43.TankBustersList2, v43.TankBustersMagicList) and v45.Blood.Defensives.TankBusters and v45.Blood.Defensives.AntiMagicZoneOnTankBuster))) then
		if v12.CastTarget(v21.AntiMagicZone, v12.TName().PLAYER, true) then
			return "AntiMagicZone defensives";
		end
	end
	if (v21.VampiricBlood:IsCastable() and v31 and (v6:HealthPercentageWeighted() <= v45.Blood.Defensives.VampiricBloodThreshold)) then
		if v13(v21.VampiricBlood, true) then
			return "vampiric_blood defensives 14";
		end
	end
	if (v6:ActiveMitigationNeeded() and (v21.Marrowrend:TimeSinceLastCast() > (1331.5 - (797 + 532))) and (v21.DeathStrike:TimeSinceLastCast() > (2.5 + 0))) then
		if (v21.DeathStrike:IsReady() and v7:IsSpellInRange(v21.DeathStrike) and (v6:BuffStack(v21.BoneShieldBuff) > (3 + 4))) then
			if v13(v21.DeathStrike) then
				return "death_strike defensives 4";
			end
		end
		if (v21.Marrowrend:IsReady() and v7:IsInMeleeRange(11 - 6)) then
			if v13(v21.Marrowrend) then
				return "marrowrend defensives 6";
			end
		end
		if (v21.DeathStrike:IsReady() and v7:IsSpellInRange(v21.DeathStrike)) then
			if v13(v21.DeathStrike) then
				return "death_strike defensives 10";
			end
		end
	end
	if (v21.DeathStrike:IsReady() and v7:IsSpellInRange(v21.DeathStrike) and (v6:HealthPercentageWeighted() <= ((1252 - (373 + 829)) + (((v6:RunicPower() > v27) and (751 - (476 + 255))) or (1130 - (369 + 761))))) and not v6:HealingAbsorbed()) then
		if v13(v21.DeathStrike) then
			return "death_strike defensives 18";
		end
	end
end
local function v79()
	v29 = 15 + 10 + (v33 * v16(v21.Heartbreaker:IsAvailable()) * (2 - 0));
	if (v45.Commons.Enabled.Potions and v6:BuffUp(v21.DancingRuneWeaponBuff)) then
		local v199 = v43.PotionSelected();
		if (v199 and v199:IsReady()) then
			v12.CastMacro(5 - 2, nil, nil, v199);
			return "Cast Potion";
		end
	end
	if (v21.DeathsCaress:IsReady() and v21.DeathsCaress:IsAvailable() and v7:IsSpellInRange(v21.DeathsCaress) and (v6:BuffDown(v21.BoneShieldBuff))) then
		if v13(v21.DeathsCaress) then
			return "deaths_caress deathbringer 4";
		end
	end
	if (v21.DeathStrike:IsReady() and v7:IsSpellInRange(v21.DeathStrike) and ((v6:BuffRemains(v21.CoagulopathyBuff) <= v6:GCD()) or (v6:RunicPowerDeficit() < (273 - (64 + 174))))) then
		if v13(v21.DeathStrike) then
			return "death_strike deathbringer 6";
		end
	end
	if (v21.BloodBoil:IsCastable() and ((v33 > (0 + 0)) or v7:IsInMeleeRange(11 - 3)) and v6:BuffUp(v21.DancingRuneWeaponBuff) and (v6:BuffRemains(v21.DancingRuneWeaponBuff) >= ((350 - (144 + 192)) - ((218 - (42 + 174)) * v6:GCD())))) then
		if v13(v21.BloodBoil) then
			return "blood_boil deathbringer 8";
		end
	end
	if (v21.BloodBoil:IsCastable() and ((v33 > (0 + 0)) or v7:IsInMeleeRange(7 + 1)) and v7:DebuffUp(v21.ReapersMarkDebuff) and (v7:DebuffRemains(v21.ReapersMarkDebuff) < (2 + 1))) then
		if v13(v21.BloodBoil) then
			return "blood_boil deathbringer 10";
		end
	end
	if (v30 >= (1514 - (363 + 1141))) then
		local v200, v201, v202 = v6:GetUseableItems(v23);
		if v200 then
			if ((((v201 == (1593 - (1183 + 397))) and Trinket1Setting) or ((v201 == (42 - 28)) and Trinket2Setting)) and v45.Commons.Enabled.Trinkets) then
				if v13(v200) then
					return "use_items deathbringer 12";
				end
			end
			if ((v201 ~= (10 + 3)) and (v201 ~= (11 + 3)) and v45.Commons.Enabled.Items) then
				v12.CastMacro(1976 - (1913 + 62));
				return "weapon cast";
			end
		end
	end
	if (v21.BloodBoil:IsCastable() and ((v33 > (0 + 0)) or v7:IsInMeleeRange(20 - 12)) and ((v21.BloodPlagueDebuff:AuraActiveCount() == (1933 - (565 + 1368))) or ((v21.BloodBoil:ChargesFractional() >= (3 - 2)) and v7:DebuffUp(v21.ReapersMarkDebuff) and (v6:BuffRemains(v21.CoagulopathyBuff) > ((1663 - (1477 + 184)) * v6:GCD()))))) then
		if v13(v21.BloodBoil) then
			return "blood_boil deathbringer 14";
		end
	end
	if (v21.DeathAndDecay:IsReady() and DnDSetting and ((v33 > (0 - 0)) or v7:IsInMeleeRange(8 + 0)) and ((v7:DebuffUp(v21.ReapersMarkDebuff) and not v6:DnDTicking()) or v6:BuffDown(v21.DeathAndDecayBuff))) then
		if v12.CastTarget(v21.DeathAndDecay, v12.TName().PLAYER) then
			return "death_and_decay deathbringer 16";
		end
	end
	if (v21.Marrowrend:IsReady() and v7:IsInMeleeRange(861 - (564 + 292)) and (v6:BuffUp(v21.PainfulDeathBuff) or v6:BuffUp(v21.ExterminateBuff)) and (v6:RunicPowerDeficit() > (51 - 21)) and (v6:BuffRemains(v21.CoagulopathyBuff) > ((5 - 3) * v6:GCD()))) then
		if v13(v21.Marrowrend) then
			return "marrowrend deathbringer 18";
		end
	end
	if (v21.RaiseDead:IsCastable() and RaiseDeadSetting) then
		if v13(v21.RaiseDead) then
			return "raise_dead deathbringer 20";
		end
	end
	if (v21.AbominationLimb:IsCastable() and AbominationLimbSetting and v7:IsInRange(324 - (244 + 60)) and (v7:DebuffUp(v21.ReapersMarkDebuff))) then
		if v13(v21.AbominationLimb) then
			return "abomination_limb deathbringer 22";
		end
	end
	if (v21.ReapersMark:IsReady() and ReapersMarkSetting and v7:IsInMeleeRange(4 + 1) and (v7:DebuffDown(v21.ReapersMarkDebuff))) then
		if v13(v21.ReapersMark) then
			return "reapers_mark deathbringer 24";
		end
	end
	if (v21.Bonestorm:IsReady() and BonestormSetting and v7:IsInMeleeRange(484 - (41 + 435)) and (v30 >= (1006 - (938 + 63))) and (v21.DancingRuneWeapon:CooldownRemains() >= (8 + 2)) and v7:DebuffUp(v21.ReapersMarkDebuff)) then
		if v13(v21.Bonestorm) then
			return "bonestorm deathbringer 26";
		end
	end
	if (v21.Consumption:IsCastable() and v7:IsInMeleeRange(1130 - (936 + 189)) and (v7:DebuffUp(v21.ReapersMarkDebuff))) then
		if v13(v21.Consumption) then
			return "consumption deathbringer 28";
		end
	end
	if (v21.AbominationLimb:IsCastable() and AbominationLimbSetting and v7:IsInRange(7 + 13)) then
		if v13(v21.AbominationLimb) then
			return "abomination_limb deathbringer 30";
		end
	end
	if (v21.Blooddrinker:IsReady() and v7:IsSpellInRange(v21.Blooddrinker) and (v6:BuffRemains(v21.CoagulopathyBuff) > (1617 - (1565 + 48))) and v6:BuffDown(v21.DancingRuneWeaponBuff)) then
		if v13(v21.Blooddrinker) then
			return "blooddrinker deathbringer 32";
		end
	end
	if (v21.DancingRuneWeapon:IsCastable() and DancingRuneWeaponSetting and v7:IsInMeleeRange(5 + 3) and v6:BuffDown(v21.DancingRuneWeaponBuff) and (v6:BuffRemains(v21.CoagulopathyBuff) > ((1140 - (782 + 356)) * v6:GCD()))) then
		if v13(v21.DancingRuneWeapon) then
			return "dancing_rune_weapon deathbringer 34";
		end
	end
	if (v21.Marrowrend:IsReady() and v7:IsInMeleeRange(272 - (176 + 91)) and not v6:BonestormTicking() and (((v30 < v28) and (v6:RunicPowerDeficit() > (52 - 32))) or (v6:BuffRemains(v21.BoneShieldBuff) <= (4 - 1)))) then
		if v13(v21.Marrowrend) then
			return "marrowrend deathbringer 36";
		end
	end
	if (v21.DancingRuneWeapon:CooldownUp() and RacialsSetting and v7:IsInMeleeRange(1100 - (975 + 117))) then
		if v21.BloodFury:IsCastable() then
			if v13(v21.BloodFury) then
				return "blood_fury deathbringer 38";
			end
		end
		if v21.Berserking:IsCastable() then
			if v13(v21.Berserking) then
				return "berserking deathbringer 40";
			end
		end
	end
	if (v21.Tombstone:IsReady() and v7:IsInMeleeRange(1883 - (157 + 1718)) and v21.Bonestorm:CooldownUp() and (v30 > (9 + 1)) and (v6:RunicPowerDeficit() >= (106 - 76)) and (v21.DancingRuneWeapon:CooldownRemains() >= (34 - 24))) then
		if v13(v21.Tombstone) then
			return "tombstone deathbringer 42";
		end
	end
	if (v21.Bonestorm:IsReady() and BonestormSetting and v7:IsInMeleeRange(1026 - (697 + 321)) and (v30 > (13 - 8)) and (v21.DancingRuneWeapon:CooldownRemains() >= (21 - 11))) then
		if v13(v21.Bonestorm) then
			return "bonestorm deathbringer 44";
		end
	end
	if (v21.Tombstone:IsReady() and v7:IsInMeleeRange(18 - 10) and (v30 > (2 + 3)) and (v6:RunicPowerDeficit() >= (56 - 26)) and (v21.DancingRuneWeapon:CooldownRemains() >= (26 - 16))) then
		if v13(v21.Tombstone) then
			return "tombstone deathbringer 46";
		end
	end
	if (v21.SoulReaper:IsReady() and v7:IsInMeleeRange(1232 - (322 + 905)) and (v33 == (612 - (602 + 9))) and (v7:TimeToX(1224 - (449 + 740)) < (877 - (826 + 46))) and (v7:TimeToDie() > (v7:DebuffRemains(v21.SoulReaperDebuff) + (952 - (245 + 702))))) then
		if v13(v21.SoulReaper) then
			return "soul_reaper deathbringer 48";
		end
	end
	if (v21.BloodBoil:IsCastable() and ((v33 > (0 - 0)) or v7:IsInMeleeRange(3 + 5)) and ((v21.BloodBoil:Charges() >= (1900 - (260 + 1638))) or (v21.BloodBoil:FullRechargeTime() <= v6:GCD()))) then
		if v13(v21.BloodBoil) then
			return "blood_boil deathbringer 50";
		end
	end
	if (v21.Consumption:IsCastable() and v7:IsInMeleeRange(445 - (382 + 58))) then
		if v13(v21.Consumption) then
			return "consumption deathbringer 52";
		end
	end
	if (v21.DeathStrike:IsReady() and v7:IsSpellInRange(v21.DeathStrike) and ((v6:RunicPowerDeficit() <= v29) or (v6:RunicPower() >= v27))) then
		if v13(v21.DeathStrike) then
			return "death_strike deathbringer 54";
		end
	end
	if (v21.BloodTap:IsCastable() and (v6:Rune() <= (3 - 2))) then
		if v13(v21.BloodTap) then
			return "blood_tap deathbringer 56";
		end
	end
	if (v21.BloodBoil:IsCastable() and ((v33 > (0 + 0)) or v7:IsInMeleeRange(16 - 8)) and (v21.BloodBoil:ChargesFractional() >= (2.1 - 1)) and (v6:BuffStack(v21.HemostasisBuff) < (1210 - (902 + 303)))) then
		if v13(v21.BloodBoil) then
			return "blood_boil deathbringer 58";
		end
	end
	if (v40 and v7:IsInMeleeRange(10 - 5) and ((v6:RuneTimeToX(4 - 2) < v6:GCD()) or (v6:RunicPowerDeficit() >= v29))) then
		if v13(v21.HeartStrike) then
			return "heart_strike deathbringer 60";
		end
	end
	if (v21.BloodBoil:IsCastable() and ((v33 > (0 + 0)) or v7:IsInMeleeRange(1698 - (1121 + 569)))) then
		if v13(v21.BloodBoil) then
			return "blood_boil deathbringer 62";
		end
	end
end
local function v80()
	v29 = (239 - (22 + 192)) + (v33 * v16(v21.Heartbreaker:IsAvailable()) * (685 - (483 + 200)));
	if (v45.Commons.Enabled.Potions and v6:BuffUp(v21.DancingRuneWeaponBuff)) then
		local v203 = v43.PotionSelected();
		if (v203 and v203:IsReady()) then
			if (v203 and v203:IsReady()) then
				v12.CastMacro(1466 - (1404 + 59), nil, nil, v203);
				return "Cast Potion";
			end
		end
	end
	if (v40 and v7:IsInMeleeRange(13 - 8) and v6:BuffUp(v21.VampiricBloodBuff) and (v6:BuffRemains(v21.EssenceoftheBloodQueenBuff) < ((2 - 0) * v6:GCD()))) then
		if v13(v21.HeartStrike) then
			return "heart_strike sanlayn 4";
		end
	end
	if (v40 and v7:IsInMeleeRange(770 - (468 + 297)) and v21.VampiricStrikeAction:IsLearned() and (v6:BuffRemains(v21.EssenceoftheBloodQueenBuff) < (565 - (334 + 228)))) then
		if v13(v21.HeartStrike) then
			return "heart_strike sanlayn 6";
		end
	end
	if (v21.VampiricBlood:IsCastable() and not (v21.Bonestorm:CooldownUp() or v21.DancingRuneWeapon:CooldownUp() or v21.Tombstone:CooldownUp()) and v31 and (v6:HealthPercentageWeighted() <= v45.Blood.Defensives.VampiricBloodThreshold)) then
		if v13(v21.VampiricBlood) then
			return "vampiric_blood sanlayn 8";
		end
	end
	if (v21.DeathsCaress:IsReady() and v7:IsSpellInRange(v21.DeathsCaress) and (v6:BuffDown(v21.BoneShieldBuff))) then
		if v13(v21.DeathsCaress) then
			return "deaths_caress sanlayn 10";
		end
	end
	if (v21.DeathStrike:IsReady() and v7:IsInMeleeRange(16 - 11) and (v6:BuffRemains(v21.CoagulopathyBuff) <= v6:GCD())) then
		if v13(v21.DeathStrike) then
			return "death_strike sanlayn 12";
		end
	end
	if ((v45.Commons.Enabled.Trinkets or v45.Commons.Enabled.Items) and (v30 >= (23 - 13))) then
		local v204, v205, v206 = v6:GetUseableItems(v23);
		if v204 then
			if ((((v205 == (23 - 10)) and Trinket1Setting) or ((v205 == (4 + 10)) and Trinket2Setting)) and v45.Commons.Enabled.Trinkets) then
				if v13(v204) then
					return "use_items sanlayn 12";
				end
			end
			if ((v205 ~= (249 - (141 + 95))) and (v205 ~= (14 + 0)) and v45.Commons.Enabled.Items) then
				v12.CastMacro(2 - 1);
				return "weapon cast";
			end
		end
	end
	if (v21.BloodBoil:IsReady() and ((v33 > (0 - 0)) or v7:IsInMeleeRange(2 + 6)) and (v7:DebuffDown(v21.BloodPlagueDebuff))) then
		if v13(v21.BloodBoil) then
			return "blood_boil sanlayn 16";
		end
	end
	if (v21.DeathAndDecay:IsReady() and DnDSetting and ((v33 > (0 - 0)) or v7:IsInMeleeRange(6 + 2)) and not v6:DnDTicking()) then
		if v12.CastTarget(v21.DeathAndDecay, v12.TName().PLAYER) then
			return "death_and_decay sanlayn 18";
		end
	end
	if (v21.RaiseDead:IsCastable() and RaiseDeadSetting and v7:IsInMeleeRange(5 + 3)) then
		if v13(v21.RaiseDead) then
			return "raise_dead sanlayn 20";
		end
	end
	if (v21.DancingRuneWeapon:IsCastable() and v7:IsInMeleeRange(11 - 3) and DancingRuneWeaponSetting and (v6:BuffDown(v21.DancingRuneWeaponBuff))) then
		if v13(v21.DancingRuneWeapon) then
			return "dancing_rune_weapon sanlayn 22";
		end
	end
	if (v21.Marrowrend:IsReady() and v7:IsInMeleeRange(3 + 2) and not v6:BonestormTicking() and (((v30 < v28) and (v6:RunicPowerDeficit() > (183 - (92 + 71)))) or (v6:BuffRemains(v21.BoneShieldBuff) <= (2 + 1)))) then
		if v13(v21.Marrowrend) then
			return "marrowrend sanlayn 24";
		end
	end
	if (v21.Consumption:IsCastable() and v7:IsSpellInRange(v21.Consumption) and ((v6:BuffRemains(v21.VampiricBloodBuff) <= (4 - 1)) or v6:BuffUp(v21.InflictionofSorrowBuff) or (v21.VampiricBlood:CooldownRemains() > (770 - (574 + 191))))) then
		if v13(v21.Consumption) then
			return "consumption sanlayn 26";
		end
	end
	if (v21.DeathStrike:IsReady() and v7:IsSpellInRange(v21.DeathStrike) and v6:BuffUp(v21.VampiricBloodBuff) and (v6:BuffRemains(v21.CoagulopathyBuff) < (3 + 0))) then
		if v13(v21.DeathStrike) then
			return "death_strike sanlayn 28";
		end
	end
	if (v40 and v7:IsInMeleeRange(12 - 7) and (v21.VampiricStrikeAction:IsLearned())) then
		if v13(v21.HeartStrike) then
			return "heart_strike sanlayn 30";
		end
	end
	if (v21.AbominationLimb:IsCastable() and AbominationLimbSetting and v7:IsInRange(11 + 9)) then
		if v13(v21.AbominationLimb) then
			return "abomination_limb sanlayn 32";
		end
	end
	if (v21.DancingRuneWeapon:CooldownUp() and RacialsSetting and v7:IsInMeleeRange(857 - (254 + 595))) then
		if v21.BloodFury:IsCastable() then
			if v13(v21.BloodFury) then
				return "blood_fury sanlayn 34";
			end
		end
		if v21.Berserking:IsCastable() then
			if v13(v21.Berserking) then
				return "berserking sanlayn 36";
			end
		end
	end
	if (v21.Bonestorm:IsReady() and BonestormSetting and v7:IsInMeleeRange(134 - (55 + 71)) and (v30 > (6 - 1)) and (v21.DancingRuneWeapon:CooldownRemains() >= (1815 - (573 + 1217)))) then
		if v13(v21.Bonestorm) then
			return "bonestorm sanlayn 38";
		end
	end
	if (v21.Tombstone:IsReady() and v7:IsInMeleeRange(22 - 14) and (v30 > (1 + 4)) and (v6:RunicPowerDeficit() >= (48 - 18)) and (v21.DancingRuneWeapon:CooldownRemains() >= (964 - (714 + 225)))) then
		if v13(v21.Tombstone) then
			return "tombstone sanlayn 40";
		end
	end
	if (v21.SoulReaper:IsReady() and v7:IsInMeleeRange(14 - 9) and (v33 == (1 - 0)) and (v7:TimeToX(4 + 31) < (6 - 1)) and (v7:TimeToDie() > (v7:DebuffRemains(v21.SoulReaperDebuff) + (811 - (118 + 688))))) then
		if v13(v21.SoulReaper) then
			return "soul_reaper sanlayn 42";
		end
	end
	if (v21.BloodBoil:IsCastable() and ((v33 > (48 - (25 + 23))) or v7:IsInMeleeRange(2 + 6)) and ((v21.BloodBoil:Charges() >= (1888 - (927 + 959))) or (v21.BloodBoil:FullRechargeTime() <= v6:GCD()))) then
		if v13(v21.BloodBoil) then
			return "blood_boil sanlayn 44";
		end
	end
	if (v21.DeathStrike:IsReady() and v7:IsSpellInRange(v21.DeathStrike) and ((v6:RunicPowerDeficit() <= v29) or (v6:RunicPower() >= v27))) then
		if v13(v21.DeathStrike) then
			return "death_strike sanlayn 46";
		end
	end
	if (v21.BloodBoil:IsCastable() and ((v33 > (0 - 0)) or v7:IsInMeleeRange(740 - (16 + 716)))) then
		if v13(v21.BloodBoil) then
			return "blood_boil sanlayn 48";
		end
	end
end
local function v81()
	if v6:IsChanneling(v22.ManicGrieftorch.ItemUseSpell) then
		return "Dont cut Torch";
	end
	v32 = v6:GetEnemiesInMeleeRange(15 - 7);
	InterruptToggle = v12.ToggleIconFrame:GetToggle(100 - (11 + 86));
	SmallCDToggle = v12.ToggleIconFrame:GetToggle(2 - 1);
	if v14() then
		v33 = #v32;
	else
		v33 = 286 - (175 + 110);
	end
	if (v43.TargetIsValid() or v6:AffectingCombat()) then
		v34 = v18(v33, (v6:BuffUp(v21.DeathAndDecayBuff) and (12 - 7)) or (9 - 7));
		v35 = v73(v32);
		v31 = v6:IsTankingAoE(1804 - (503 + 1293)) or v6:IsTanking(v7);
		v30 = v6:BuffStack(v21.BoneShieldBuff);
	end
	if (v43.TargetIsValid() or v6:AffectingCombat()) then
		v38 = v3.BossFightRemains();
		v37 = true;
		v39 = v38;
		if (v39 == (31030 - 19919)) then
			v37 = false;
			v39 = v3.FightRemains(v32, false);
		end
	end
	DnDSetting = v12.ToggleIconFrame:GetToggle(3 + 1) and (v45.Commons.DnDMoving or not v6:IsMoving()) and v69(1069 - (810 + 251));
	v40 = v21.HeartStrike:IsReady() or v21.VampiricStrikeAction:IsReady();
	RacialsSetting = v70(v45.Blood.RacialsSetting) and v69(v45.TTD.RacialsTTD) and v7:IsInMeleeRange(4 + 1);
	Trinket1Setting = v70(v45.Blood.Trinket1Setting, v45.Blood.TrinketHP);
	Trinket2Setting = v70(v45.Blood.Trinket2Setting, v45.Blood.TrinketHP);
	PotionSetting = v70(v45.Blood.PotionSetting) and not v43.ISSolo() and v7:IsInMeleeRange(2 + 3);
	AbominationLimbSetting = v70(v45.Blood.AbominationLimbSetting) and not v65() and v69(v45.TTD.AbominationLimbTTD) and v7:IsInMeleeRange(14 + 1);
	EmpowerRuneWeaponSetting = v70(v45.Blood.EmpowerRuneWeaponSetting) and v69(v45.TTD.EmpowerRuneWeaponTTD) and v7:IsInMeleeRange(538 - (43 + 490));
	DancingRuneWeaponSetting = v70(v45.Blood.DancingRuneWeaponSetting, v45.Blood.DancingRuneWeaponHP) and v69(v45.TTD.DancingRuneWeaponTTD) and v7:IsInMeleeRange(738 - (711 + 22));
	RaiseDeadSetting = v70(v45.Blood.RaiseDeadSetting) and v69(v45.TTD.RaiseDeadTTD) and v7:IsInMeleeRange(19 - 14);
	WeaponSetting = v70(v45.Blood.Weapon);
	ReapersMarkSetting = v70(v45.Blood.ReapersMarkSetting) and v69(874 - (240 + 619));
	BonestormSetting = v70(v45.Blood.Bonestorm) and v69(4 + 11);
	if (v21.RaiseAlly:IsReady() and v45.Commons.RaiseAlly) then
		if (v8:UnitIsFriend() and v8:UnitIsPlayer() and v8:Exists() and v8:IsDeadOrGhost()) then
			v12.CastTarget(v21.RaiseAlly, v12.TName().MOUSEOVER);
			return "Raise Ally on Mouseover";
		end
		if (v7:UnitIsFriend() and v7:UnitIsPlayer() and v7:Exists() and v7:IsDeadOrGhost()) then
			v12.Cast(v21.RaiseAlly);
			return "Raise Ally on Target";
		end
	end
	if (v43.TargetIsValid() and (v7:AffectingCombat() or v45.Blood.AttackOutOfCombat)) then
		if not v6:AffectingCombat() then
			v42 = v77();
			if v42 then
				return v42;
			end
		end
		if v31 then
			v42 = v78();
			if v42 then
				return v42;
			end
		end
		if InterruptToggle then
			v42 = v43.InterruptCycle(v21.MindFreeze, 23 - 8, true, nil, false);
			if v42 then
				return v42;
			end
			if v45.Commons.BlindingSleet then
				v42 = v43.InterruptCycle(v21.BlindingSleet, 1 + 11, true, nil, true, true);
				if v42 then
					return v42;
				end
			end
			v42 = v43.InterruptCycle(v21.Asphyxiate, 1764 - (1344 + 400), true, nil, true);
			if v42 then
				return v42;
			end
		end
		if (v21.BloodBoil:IsCastable() and ((v33 > (405 - (255 + 150))) or v7:IsInMeleeRange(7 + 1)) and (v35 > (0 + 0))) then
			if v13(v21.BloodBoil) then
				return "blood_boil missing Plague";
			end
		end
		if ((v6:HeroTreeID() == (140 - 107)) or (v6:Level() <= (226 - 156))) then
			local v217 = v79();
			if v217 then
				return v217;
			end
			local v217 = ((v33 > (1739 - (404 + 1335))) or v7:IsInMeleeRange(414 - (183 + 223))) and not v7:IsInRange(9 - 1) and v66();
			if v217 then
				return v217;
			end
			if v12.CastAnnotated(v21.Pool, false, "WAIT") then
				return "Pool for Deathbringer()";
			end
		end
		if (v6:HeroTreeID() == (21 + 10)) then
			local v218 = v80();
			if v218 then
				return v218;
			end
			local v218 = ((v33 > (0 + 0)) or v7:IsInMeleeRange(345 - (10 + 327))) and not v7:IsInRange(6 + 2) and v66();
			if v218 then
				return v218;
			end
			if v12.CastAnnotated(v21.Pool, false, "WAIT") then
				return "Pool for Sanlayn()";
			end
		end
	end
end
local function v82()
	v21.BloodPlagueDebuff:RegisterAuraTracking();
	v45.Blood.Display();
	v12:UpdateMacro("macro1", "/use 16");
	v12:UpdateMacro("macro2", "/target [@mouseover]");
	v12.Print("Blood Death Knight rotation has been updated for patch 11.0.2.");
end
v12.SetAPL(588 - (118 + 220), v81, v82);
