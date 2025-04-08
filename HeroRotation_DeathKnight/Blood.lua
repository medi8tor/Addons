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
v6.NeedDefensive = function(v85, v86, v87)
	local v88 = v85:IncomingSpell(v86);
	local v89 = v85:IncomingSpell(v87);
	if (v88 or v89) then
		for v209, v210 in ipairs(v24) do
			if v85:BuffUp(v210) then
				return false;
			end
		end
		for v211, v212 in ipairs(v25) do
			if v85:BuffUp(v212) then
				return false;
			end
		end
		return true;
	end
	return false;
end;
local v27 = (v21.ReapersMark:IsAvailable() and (962 - (214 + 713))) or (13 + 37);
local v28 = 4 + 16;
local v29 = (v21.ReapersMark:IsAvailable() and (883 - (282 + 595))) or (1644 - (1523 + 114));
local v30 = 19 + 2 + (v16(v21.Heartbreaker:IsAvailable()) * (2 - 0));
local v31;
local v32;
local v33;
local v34;
local v35;
local v36;
local v37 = v20.GhoulTable;
local v38;
local v39 = 12176 - (68 + 997);
local v40 = 12381 - (226 + 1044);
local v41 = v21.HeartStrike:IsReady() or v21.VampiricStrikeAction:IsReady();
local v42 = (v21.Bonestorm:IsAvailable() and v21.Bonestorm:CooldownUp() and BonestormSetting and (v6:RunicPower() >= v6:RunicPowerMax())) or not v21.Bonestorm:IsAvailable() or v21.Bonestorm:CooldownDown() or not BonestormSetting;
local v43;
local v44 = v12.Commons().Everyone;
local v45 = v12.GUISettingsGet();
local v46 = {General=v45.General,Commons=v45.APL.DeathKnight.Commons,Defensives=v45.APL.DeathKnight.Blood.Defensives,Blood=v45.APL.DeathKnight.Blood,TTD=v45.APL.DeathKnight.Blood_TTD};
local v47, v48;
local v49, v50;
local v51, v52;
local v53, v54;
local v55, v56;
local v57, v58;
local v59, v60;
local v61, v62;
local v63 = 0 - 0;
local function v64()
	local v90, v91 = v6:GetTrinketData(v23);
	if ((v63 < (122 - (32 + 85))) and ((v90.ID == (0 + 0)) or (v91.ID == (0 + 0)) or (v90.Level == (957 - (892 + 65))) or (v91.Level == (0 - 0)) or ((v90.SpellID > (0 - 0)) and not v90.Usable) or ((v91.SpellID > (0 - 0)) and not v91.Usable))) then
		v63 = v63 + (351 - (87 + 263));
		v19(185 - (67 + 113), function()
			v64();
		end);
		return;
	end
	v47 = v90.Object;
	v48 = v91.Object;
	v49 = v90.ID;
	v50 = v91.ID;
	v51 = v90.Level;
	v52 = v91.Level;
	v53 = v90.Spell;
	v55 = v90.Range;
	v57 = v90.CastTime;
	v54 = v91.Spell;
	v56 = v91.Range;
	v58 = v91.CastTime;
	v59 = v90.Cooldown;
	v60 = v91.Cooldown;
	v61 = v90.Blacklisted;
	v62 = v91.Blacklisted;
end
v64();
v3:RegisterForEvent(function()
	v64();
end, "PLAYER_EQUIPMENT_CHANGED");
v5.IsTankingAllAoE = function(v108, v109, v110, v111)
	local v112 = v6:GetEnemiesInRange(v109 or (5.5 + 1));
	local v113 = 0 - 0;
	local v114 = 0 + 0;
	for v169, v170 in pairs(v112) do
		if not (v110 and v110[v170:ID()]) then
			v113 = v113 + (3 - 2);
			if v108:IsTanking(v170, v111) then
				v114 = v114 + (953 - (802 + 150));
			end
		end
	end
	return v114 >= v113;
end;
local function v66()
	local v115 = v6:GetEnemiesInRange(107 - 67);
	for v171, v172 in pairs(v115) do
		if ((v172:NPCID() == (73205 - 32848)) or (v172:CastSpellID() == (326104 + 121909))) then
			print("npc found: do not use abo limb");
			return true;
		end
	end
	return false;
end
local function v67()
	if (v45.General.AutoTab and v6:AffectingCombat()) then
		v12.TopPanelAlternative:ChangeIcon(998 - (915 + 82), 8 - 5);
		return "Auto tab to target";
	end
end
local function v68()
	return v22.ManicGrieftorch:IsEquipped() and (v22.ManicGrieftorch:CooldownUp() or (v22.ManicGrieftorch:CooldownRemains() <= v6:GCDRemains()));
end
local function v69()
	return v22.AlgetharPuzzleBox:IsEquipped() and (v22.AlgetharPuzzleBox:CooldownUp() or (v22.AlgetharPuzzleBox:CooldownRemains() <= v6:GCDRemains()));
end
v3:RegisterForEvent(function()
	v27 = (v21.ReapersMark:IsAvailable() and (21 + 14)) or (65 - 15);
	v28 = 1207 - (1069 + 118);
	v29 = (v21.ReapersMark:IsAvailable() and (13 - 7)) or (14 - 7);
	v30 = 4 + 17 + (v16(v21.Heartbreaker:IsAvailable()) * (3 - 1));
end, "SPELLS_CHANGED", "LEARNED_SPELL_IN_TAB");
local function v70(v116)
	return v38 or v44.ISSolo() or (v116 == (0 + 0)) or v44.Buggedmobs[v7:NPCID()] or ((v40 >= v116) and (v40 < (8568 - (368 + 423))));
end
local function v71(v117, v118)
	return (v117 ~= "Not Used") and ((v70(v46.TTD.TrinketsTTD) and (((v117 == "With Cooldowns") and v12.CDsON()) or ((v117 == "With Small or Cooldowns") and (SmallCDToggle or v12.CDsON())) or ((v117 == "With Small CDs") and SmallCDToggle) or ((v117 == "On Mobcount") and (v34 >= v46.Blood.Mobcount)) or ((v117 == "On Mobcount or Cooldowns") and ((v34 >= v46.Blood.Mobcount) or v15())) or (v117 == "Always") or ((v117 == "On Bosses") and v38) or ((v117 == "Mobcount or Boss") and (v38 or (v34 >= v46.Blood.Mobcount))))) or ((v117 == "On HealthPercent") and (v118 ~= nil) and (v6:HealthPercentageWeighted() <= v118)));
end
local function v72(v119, v120, v121)
	if (v38 or v44.ISSolo() or (v121 == (0 - 0)) or ((v40 >= v121) and (v40 < (7795 - (10 + 8))))) then
		v12.Cast(v119, v120);
		return "TTD cast " .. v119:Name();
	end
end
local v73 = v6:GetEquipment();
local v47 = (v73[49 - 36] and v11(v73[455 - (416 + 26)])) or v11(0 - 0);
local v48 = (v73[7 + 7] and v11(v73[24 - 10])) or v11(438 - (145 + 293));
v3:RegisterForEvent(function()
	v73 = v6:GetEquipment();
	v47 = (v73[443 - (44 + 386)] and v11(v73[1499 - (998 + 488)])) or v11(0 + 0);
	v48 = (v73[12 + 2] and v11(v73[786 - (201 + 571)])) or v11(1138 - (116 + 1022));
end, "PLAYER_EQUIPMENT_CHANGED");
local function v74(v122)
	local v123 = 0 - 0;
	for v173, v174 in pairs(v122) do
		if not v174:DebuffUp(v21.BloodPlagueDebuff) then
			v123 = v123 + 1 + 0;
		end
	end
	return v123;
end
local function v75()
	return v6:BuffUp(v21.DancingRuneWeaponBuff) and ((v21.BloodBoil:TimeSinceLastCast() < v21.DancingRuneWeapon:TimeSinceLastCast()) or (v21.DeathsCaress:TimeSinceLastCast() < v21.DancingRuneWeapon:TimeSinceLastCast()));
end
local function v76(v124)
	for v175, v176 in pairs(v44.TankBustersList) do
		if v124:CastSpellID(v176) then
			return true;
		end
	end
	return false;
end
local function v77(v125)
	for v177, v178 in pairs(v44.TankBustersPhysicalList) do
		if v125:CastSpellID(v178) then
			return true;
		end
	end
	return false;
end
local function v78(v126)
	for v179, v180 in pairs(v44.TankBustersMagicList) do
		if v126:CastSpellID(v180) then
			return true;
		end
	end
	return false;
end
local function v79()
	if (v21.DeathsCaress:IsCastable() and v21.DeathsCaress:IsAvailable() and v7:IsSpellInRange(v21.DeathsCaress)) then
		if v13(v21.DeathsCaress) then
			return "deaths_caress precombat 2";
		end
	end
	if (v21.Marrowrend:IsReady() and v7:IsInMeleeRange(18 - 13)) then
		if v13(v21.Marrowrend) then
			return "marrowrend precombat 6";
		end
	end
end
local function v80()
	if (v21.RuneTap:IsReady() and v32 and (v21.RuneTap:Charges() > (3 - 2)) and ((v6:HealthPercentageWeighted() <= v46.Blood.Defensives.RuneTapThreshold) or (v6:NeedDefensive(v44.TankBustersList2, v44.TankBustersMagicList) and v46.Blood.Defensives.TankBusters)) and (v6:Rune() >= (862 - (814 + 45))) and (v21.RuneTap:Charges() >= (2 - 1)) and v6:BuffDown(v21.RuneTapBuff)) then
		if v13(v21.RuneTap, true) then
			return "rune_tap defensives 1";
		end
	end
	if (v21.Lichborne:IsCastable() and v32 and ((v6:HealthPercentageWeighted() <= v46.Blood.Defensives.LichborneHP) or (v6:NeedDefensive(v44.TankBustersList2, v44.TankBustersMagicList) and v46.Blood.Defensives.TankBusters))) then
		if v13(v21.Lichborne, true) then
			return "Lichborne defensives";
		end
	end
	if (v21.IceboundFortitude:IsCastable() and v32 and ((v6:HealthPercentageWeighted() <= v46.Blood.Defensives.IceboundFortitudeHP) or (v6:NeedDefensive(v44.TankBustersList2, v44.TankBustersMagicList) and v46.Blood.Defensives.TankBusters))) then
		if v13(v21.IceboundFortitude, true) then
			return "icebound_fortitude defensives";
		end
	end
	if (v21.RuneTap:IsReady() and v32 and ((v6:HealthPercentageWeighted() <= v46.Blood.Defensives.RuneTapThreshold) or (v6:NeedDefensive(v44.TankBustersList2, v44.TankBustersMagicList) and v46.Blood.Defensives.TankBusters)) and (v6:Rune() >= (1 + 2)) and (v21.RuneTap:Charges() >= (1 + 0)) and v6:BuffDown(v21.RuneTapBuff)) then
		if v13(v21.RuneTap, true) then
			return "rune_tap defensives 2";
		end
	end
	if (v21.AntiMagicShell:IsCastable() and v32 and ((v6:HealthPercentageWeighted() <= v46.Blood.Defensives.AntiMagicShellHP) or (v6:NeedDefensive(v44.TankBustersList2, v44.TankBustersMagicList) and v46.Blood.Defensives.TankBusters))) then
		if v13(v21.AntiMagicShell, true) then
			return "AntiMagicShell defensives";
		end
	end
	if (v21.AntiMagicZone:IsCastable() and v32 and ((v6:HealthPercentageWeighted() <= v46.Blood.Defensives.AntiMagicZoneHP) or (v6:NeedDefensive(v44.TankBustersList2, v44.TankBustersMagicList) and v46.Blood.Defensives.TankBusters and v46.Blood.Defensives.AntiMagicZoneOnTankBuster))) then
		if v12.CastTarget(v21.AntiMagicZone, v12.TName().PLAYER, true) then
			return "AntiMagicZone defensives";
		end
	end
	if (v21.VampiricBlood:IsCastable() and v32 and (v6:HealthPercentageWeighted() <= v46.Blood.Defensives.VampiricBloodThreshold)) then
		if v13(v21.VampiricBlood, true) then
			return "vampiric_blood defensives 14";
		end
	end
	if (v6:ActiveMitigationNeeded() and (v21.Marrowrend:TimeSinceLastCast() > (887.5 - (261 + 624))) and (v21.DeathStrike:TimeSinceLastCast() > (3.5 - 1))) then
		if (v21.DeathStrike:IsReady() and v7:IsSpellInRange(v21.DeathStrike) and (v6:BuffStack(v21.BoneShieldBuff) > (1087 - (1020 + 60)))) then
			if v13(v21.DeathStrike) then
				return "death_strike defensives 4";
			end
		end
		if (v21.Marrowrend:IsReady() and v7:IsInMeleeRange(1428 - (630 + 793))) then
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
	if (v21.DeathStrike:IsReady() and v7:IsSpellInRange(v21.DeathStrike) and (v6:HealthPercentageWeighted() <= ((169 - 119) + (((v6:RunicPower() > v27) and (94 - 74)) or (0 + 0)))) and not v6:HealingAbsorbed()) then
		if v13(v21.DeathStrike) then
			return "death_strike defensives 18";
		end
	end
end
local function v81()
	v30 = (85 - 60) + (v34 * v16(v21.Heartbreaker:IsAvailable()) * (1749 - (760 + 987)));
	if (v46.Commons.Enabled.Potions and v6:BuffUp(v21.DancingRuneWeaponBuff)) then
		local v193 = v44.PotionSelected();
		if (v193 and v193:IsReady()) then
			v12.CastMacro(1916 - (1789 + 124), nil, nil, v193);
			return "Cast Potion";
		end
	end
	if (v21.DeathsCaress:IsReady() and v21.DeathsCaress:IsAvailable() and v7:IsSpellInRange(v21.DeathsCaress) and (v6:BuffDown(v21.BoneShieldBuff))) then
		if v13(v21.DeathsCaress) then
			return "deaths_caress deathbringer 4";
		end
	end
	if (v21.DeathStrike:IsReady() and v7:IsSpellInRange(v21.DeathStrike) and ((v6:BuffRemains(v21.CoagulopathyBuff) <= v6:GCD()) or (v6:RunicPowerDeficit() < (801 - (745 + 21))))) then
		if v13(v21.DeathStrike) then
			return "death_strike deathbringer 6";
		end
	end
	if (v21.BloodBoil:IsCastable() and ((v34 > (0 + 0)) or v7:IsInMeleeRange(21 - 13)) and v6:BuffUp(v21.DancingRuneWeaponBuff) and (v6:BuffRemains(v21.DancingRuneWeaponBuff) >= ((54 - 40) - ((1 + 1) * v6:GCD())))) then
		if v13(v21.BloodBoil) then
			return "blood_boil deathbringer 8";
		end
	end
	if (v21.BloodBoil:IsCastable() and ((v34 > (0 + 0)) or v7:IsInMeleeRange(1063 - (87 + 968))) and v7:DebuffUp(v21.ReapersMarkDebuff) and (v7:DebuffRemains(v21.ReapersMarkDebuff) < (13 - 10))) then
		if v13(v21.BloodBoil) then
			return "blood_boil deathbringer 10";
		end
	end
	if (v31 >= (10 + 0)) then
		local v194, v195, v196 = v6:GetUseableItems(v23);
		if v194 then
			if ((((v195 == (29 - 16)) and Trinket1Setting) or ((v195 == (1427 - (447 + 966))) and Trinket2Setting)) and v46.Commons.Enabled.Trinkets) then
				if v13(v194) then
					return "use_items deathbringer 12";
				end
			end
			if ((v195 ~= (35 - 22)) and (v195 ~= (1831 - (1703 + 114))) and v46.Commons.Enabled.Items) then
				v12.CastMacro(702 - (376 + 325));
				return "weapon cast";
			end
		end
	end
	if (v21.BloodBoil:IsCastable() and ((v34 > (0 - 0)) or v7:IsInMeleeRange(24 - 16)) and ((v21.BloodPlagueDebuff:AuraActiveCount() == (0 + 0)) or ((v21.BloodBoil:ChargesFractional() >= (2 - 1)) and v7:DebuffUp(v21.ReapersMarkDebuff) and (v6:BuffRemains(v21.CoagulopathyBuff) > ((16 - (9 + 5)) * v6:GCD()))))) then
		if v13(v21.BloodBoil) then
			return "blood_boil deathbringer 14";
		end
	end
	if (v21.DeathAndDecay:IsReady() and DnDSetting and ((v34 > (376 - (85 + 291))) or v7:IsInMeleeRange(1273 - (243 + 1022))) and ((v7:DebuffUp(v21.ReapersMarkDebuff) and not v6:DnDTicking()) or v6:BuffDown(v21.DeathAndDecayBuff))) then
		if v12.CastTarget(v21.DeathAndDecay, v12.TName().PLAYER) then
			return "death_and_decay deathbringer 16";
		end
	end
	if (v21.Marrowrend:IsReady() and v7:IsInMeleeRange(19 - 14) and (v6:BuffUp(v21.PainfulDeathBuff) or v6:BuffUp(v21.ExterminateBuff)) and (v6:RunicPowerDeficit() > (25 + 5)) and (v6:BuffRemains(v21.CoagulopathyBuff) > ((1182 - (1123 + 57)) * v6:GCD()))) then
		if v13(v21.Marrowrend) then
			return "marrowrend deathbringer 18";
		end
	end
	if (v21.RaiseDead:IsCastable() and RaiseDeadSetting) then
		if v13(v21.RaiseDead) then
			return "raise_dead deathbringer 20";
		end
	end
	if (v21.AbominationLimb:IsCastable() and AbominationLimbSetting and v7:IsInRange(17 + 3) and (v7:DebuffUp(v21.ReapersMarkDebuff))) then
		if v13(v21.AbominationLimb) then
			return "abomination_limb deathbringer 22";
		end
	end
	if (v21.ReapersMark:IsReady() and ReapersMarkSetting and v7:IsInMeleeRange(259 - (163 + 91)) and (v7:DebuffDown(v21.ReapersMarkDebuff))) then
		if v13(v21.ReapersMark) then
			return "reapers_mark deathbringer 24";
		end
	end
	if (v21.Bonestorm:IsReady() and BonestormSetting and v7:IsInMeleeRange(1938 - (1869 + 61)) and (v31 >= (2 + 3)) and (v21.DancingRuneWeapon:CooldownRemains() >= (35 - 25)) and v7:DebuffUp(v21.ReapersMarkDebuff)) then
		if v13(v21.Bonestorm) then
			return "bonestorm deathbringer 26";
		end
	end
	if (v21.Consumption:IsCastable() and v7:IsInMeleeRange(7 - 2) and (v7:DebuffUp(v21.ReapersMarkDebuff))) then
		if v13(v21.Consumption) then
			return "consumption deathbringer 28";
		end
	end
	if (v21.AbominationLimb:IsCastable() and AbominationLimbSetting and v7:IsInRange(3 + 17)) then
		if v13(v21.AbominationLimb) then
			return "abomination_limb deathbringer 30";
		end
	end
	if (v21.Blooddrinker:IsReady() and v7:IsSpellInRange(v21.Blooddrinker) and (v6:BuffRemains(v21.CoagulopathyBuff) > (5 - 1)) and v6:BuffDown(v21.DancingRuneWeaponBuff)) then
		if v13(v21.Blooddrinker) then
			return "blooddrinker deathbringer 32";
		end
	end
	if (v21.DancingRuneWeapon:IsCastable() and DancingRuneWeaponSetting and v7:IsInMeleeRange(8 + 0) and v6:BuffDown(v21.DancingRuneWeaponBuff) and (v6:BuffRemains(v21.CoagulopathyBuff) > ((1476 - (1329 + 145)) * v6:GCD()))) then
		if v13(v21.DancingRuneWeapon) then
			return "dancing_rune_weapon deathbringer 34";
		end
	end
	if (v21.Marrowrend:IsReady() and v7:IsInMeleeRange(976 - (140 + 831)) and not v6:BonestormTicking() and (((v31 < v29) and (v6:RunicPowerDeficit() > (1870 - (1409 + 441)))) or (v6:BuffRemains(v21.BoneShieldBuff) <= (721 - (15 + 703))))) then
		if v13(v21.Marrowrend) then
			return "marrowrend deathbringer 36";
		end
	end
	if (v21.DancingRuneWeapon:CooldownUp() and RacialsSetting and v7:IsInMeleeRange(4 + 4)) then
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
	if (v21.Tombstone:IsReady() and v7:IsInMeleeRange(446 - (262 + 176)) and v21.Bonestorm:CooldownUp() and (v31 > (1731 - (345 + 1376))) and (v6:RunicPowerDeficit() >= (718 - (198 + 490))) and (v21.DancingRuneWeapon:CooldownRemains() >= (44 - 34))) then
		if v13(v21.Tombstone) then
			return "tombstone deathbringer 42";
		end
	end
	if (v21.Bonestorm:IsReady() and BonestormSetting and v7:IsInMeleeRange(18 - 10) and (v31 > (1211 - (696 + 510))) and (v21.DancingRuneWeapon:CooldownRemains() >= (20 - 10))) then
		if v13(v21.Bonestorm) then
			return "bonestorm deathbringer 44";
		end
	end
	if (v21.Tombstone:IsReady() and v7:IsInMeleeRange(1270 - (1091 + 171)) and (v31 > (1 + 4)) and (v6:RunicPowerDeficit() >= (94 - 64)) and (v21.DancingRuneWeapon:CooldownRemains() >= (33 - 23))) then
		if v13(v21.Tombstone) then
			return "tombstone deathbringer 46";
		end
	end
	if (v21.SoulReaper:IsReady() and v7:IsInMeleeRange(379 - (123 + 251)) and (v34 == (4 - 3)) and (v7:TimeToX(733 - (208 + 490)) < (1 + 4)) and (v7:TimeToDie() > (v7:DebuffRemains(v21.SoulReaperDebuff) + 3 + 2))) then
		if v13(v21.SoulReaper) then
			return "soul_reaper deathbringer 48";
		end
	end
	if (v21.BloodBoil:IsCastable() and ((v34 > (836 - (660 + 176))) or v7:IsInMeleeRange(1 + 7)) and ((v21.BloodBoil:Charges() >= (204 - (14 + 188))) or (v21.BloodBoil:FullRechargeTime() <= v6:GCD()))) then
		if v13(v21.BloodBoil) then
			return "blood_boil deathbringer 50";
		end
	end
	if (v21.Consumption:IsCastable() and v7:IsInMeleeRange(680 - (534 + 141))) then
		if v13(v21.Consumption) then
			return "consumption deathbringer 52";
		end
	end
	if (v21.DeathStrike:IsReady() and v7:IsSpellInRange(v21.DeathStrike) and ((v6:RunicPowerDeficit() <= v30) or (v6:RunicPower() >= v27))) then
		if v13(v21.DeathStrike) then
			return "death_strike deathbringer 54";
		end
	end
	if (v21.BloodTap:IsCastable() and (v6:Rune() <= (1 + 0))) then
		if v13(v21.BloodTap) then
			return "blood_tap deathbringer 56";
		end
	end
	if (v21.BloodBoil:IsCastable() and ((v34 > (0 + 0)) or v7:IsInMeleeRange(8 + 0)) and (v21.BloodBoil:ChargesFractional() >= (1.1 - 0)) and (v6:BuffStack(v21.HemostasisBuff) < (7 - 2))) then
		if v13(v21.BloodBoil) then
			return "blood_boil deathbringer 58";
		end
	end
	if (v41 and v7:IsInMeleeRange(14 - 9) and ((v6:RuneTimeToX(2 + 0) < v6:GCD()) or (v6:RunicPowerDeficit() >= v30))) then
		if v13(v21.HeartStrike) then
			return "heart_strike deathbringer 60";
		end
	end
	if (v21.BloodBoil:IsCastable() and ((v34 > (0 + 0)) or v7:IsInMeleeRange(404 - (115 + 281)))) then
		if v13(v21.BloodBoil) then
			return "blood_boil deathbringer 62";
		end
	end
end
local function v82()
	v30 = (58 - 33) + (v34 * v16(v21.Heartbreaker:IsAvailable()) * (2 + 0));
	if (v46.Commons.Enabled.Potions and v6:BuffUp(v21.DancingRuneWeaponBuff)) then
		local v197 = v44.PotionSelected();
		if (v197 and v197:IsReady()) then
			if (v197 and v197:IsReady()) then
				v12.CastMacro(7 - 4, nil, nil, v197);
				return "Cast Potion";
			end
		end
	end
	if (v41 and v7:IsInMeleeRange(18 - 13) and v6:BuffUp(v21.VampiricBloodBuff) and (v6:BuffRemains(v21.EssenceoftheBloodQueenBuff) < ((869 - (550 + 317)) * v6:GCD()))) then
		if v13(v21.HeartStrike) then
			return "heart_strike sanlayn 4";
		end
	end
	if (v41 and v7:IsInMeleeRange(7 - 2) and v21.VampiricStrikeAction:IsLearned() and (v6:BuffRemains(v21.EssenceoftheBloodQueenBuff) < (3 - 0))) then
		if v13(v21.HeartStrike) then
			return "heart_strike sanlayn 6";
		end
	end
	if (v21.VampiricBlood:IsCastable() and not (v21.Bonestorm:CooldownUp() or v21.DancingRuneWeapon:CooldownUp() or v21.Tombstone:CooldownUp()) and v32 and (v6:HealthPercentageWeighted() <= v46.Blood.Defensives.VampiricBloodThreshold)) then
		if v13(v21.VampiricBlood) then
			return "vampiric_blood sanlayn 8";
		end
	end
	if (v21.DeathsCaress:IsReady() and v7:IsSpellInRange(v21.DeathsCaress) and (v6:BuffDown(v21.BoneShieldBuff))) then
		if v13(v21.DeathsCaress) then
			return "deaths_caress sanlayn 10";
		end
	end
	if (v21.DeathStrike:IsReady() and v7:IsInMeleeRange(13 - 8) and (v6:BuffRemains(v21.CoagulopathyBuff) <= v6:GCD())) then
		if v13(v21.DeathStrike) then
			return "death_strike sanlayn 12";
		end
	end
	if ((v46.Commons.Enabled.Trinkets or v46.Commons.Enabled.Items) and (v31 >= (295 - (134 + 151)))) then
		local v198, v199, v200 = v6:GetUseableItems(v23);
		if v198 then
			if ((((v199 == (1678 - (970 + 695))) and Trinket1Setting) or ((v199 == (26 - 12)) and Trinket2Setting)) and v46.Commons.Enabled.Trinkets) then
				if v13(v198) then
					return "use_items sanlayn 12";
				end
			end
			if ((v199 ~= (2003 - (582 + 1408))) and (v199 ~= (48 - 34)) and v46.Commons.Enabled.Items) then
				v12.CastMacro(1 - 0);
				return "weapon cast";
			end
		end
	end
	if (v21.SoulReaper:IsReady() and v7:IsInMeleeRange(18 - 13) and (v34 == (1825 - (1195 + 629))) and (v7:TimeToX(45 - 10) < (246 - (187 + 54))) and (v7:TimeToDie() > (v7:DebuffRemains(v21.SoulReaperDebuff) + (785 - (162 + 618))))) then
		if v13(v21.SoulReaper) then
			return "soul_reaper deathbringer 20";
		end
	end
	if (v21.BloodBoil:IsCastable() and ((v34 > (0 + 0)) or v7:IsInMeleeRange(6 + 2)) and ((v7:DebuffUp(v21.ReapersMarkDebuff) and v6:BuffUp(v21.DancingRuneWeaponBuff) and not v75()) or v7:DebuffDown(v21.BloodPlagueDebuff) or ((v21.BloodBoil:ChargesFractional() >= (1 - 0)) and v7:DebuffUp(v21.ReapersMarkDebuff) and (v6:BuffRemains(v21.CoagulopathyBuff) > ((2 - 0) * v6:GCD()))))) then
		if v13(v21.BloodBoil) then
			return "blood_boil sanlayn 16";
		end
	end
	if (v21.DeathAndDecay:IsReady() and v7:DebuffUp(v21.ReapersMarkDebuff) and DnDSetting and ((v34 > (0 + 0)) or v7:IsInMeleeRange(1644 - (1373 + 263))) and not v6:DnDTicking()) then
		if v12.CastTarget(v21.DeathAndDecay, v12.TName().PLAYER) then
			return "death_and_decay sanlayn 18";
		end
	end
	if (v21.Marrowrend:IsReady() and v7:IsInMeleeRange(1005 - (451 + 549)) and not v6:BonestormTicking() and (((v31 < v29) and (v6:RunicPowerDeficit() > (7 + 13))) or (v6:BuffRemains(v21.BoneShieldBuff) <= (4 - 1)))) then
		if v13(v21.Marrowrend) then
			return "marrowrend sanlayn 24";
		end
	end
	if (v21.AbominationLimb:IsCastable() and AbominationLimbSetting and v7:IsInRange(33 - 13) and (v7:DebuffUp(v21.ReapersMarkDebuff))) then
		if v13(v21.AbominationLimb) then
			return "abomination_limb deathbringer 28";
		end
	end
	if (v21.ReapersMark:IsReady() and v7:IsInMeleeRange(1389 - (746 + 638)) and ReapersMarkSetting and v7:DebuffDown(v21.ReapersMarkDebuff) and v7:DebuffDown(v21.BloodPlagueDebuff)) then
		if v13(v21.ReapersMark) then
			return "reapers_mark deathbringer 30";
		end
	end
	if (v21.Bonestorm:IsReady() and v6:BuffUp(v21.DeathAndDecayBuff) and (v31 > (2 + 3)) and (v21.DancingRuneWeapon:CooldownRemains() >= (15 - 5)) and v7:DebuffUp(v21.ReapersMarkDebuff)) then
		if v13(v21.Bonestorm, v46.Blood.GCDasOffGCD.Bonestorm, nil, not v7:IsInMeleeRange(349 - (218 + 123))) then
			return "bonestorm deathbringer 32";
		end
	end
	if (v21.AbominationLimb:IsCastable() and v7:IsInRange(1601 - (1535 + 46)) and AbominationLimbSetting) then
		if v13(v21.AbominationLimb) then
			return "abomination_limb deathbringer 34";
		end
	end
	if (v21.Blooddrinker:IsReady() and v7:IsSpellInRange(v21.Blooddrinker) and (v6:BuffRemains(v21.CoagulopathyBuff) > ((3 + 0) * v6:GCD())) and v6:BuffDown(v21.DancingRuneWeaponBuff)) then
		if v13(v21.Blooddrinker) then
			return "blooddrinker deathbringer 36";
		end
	end
	if (DancingRuneWeaponSetting and v21.DancingRuneWeapon:IsCastable() and (v6:BuffRemains(v21.CoagulopathyBuff) > ((1 + 1) * v6:GCD()))) then
		if v13(v21.DancingRuneWeapon) then
			return "dancing_rune_weapon deathbringer 38";
		end
	end
	if (v21.Bonestorm:IsReady() and BonestormSetting and v7:IsInMeleeRange(568 - (306 + 254)) and (v31 > (1 + 4)) and (v21.DancingRuneWeapon:CooldownRemains() >= (19 - 9))) then
		if v13(v21.Bonestorm) then
			return "bonestorm sanlayn 38";
		end
	end
	if (v21.Tombstone:IsReady() and v7:IsInMeleeRange(1475 - (899 + 568)) and v6:BuffUp(v21.DeathAndDecayBuff) and (v31 > (4 + 1)) and (v6:RunicPowerDeficit() >= (72 - 42)) and (v21.DancingRuneWeapon:CooldownRemains() >= (613 - (268 + 335)))) then
		if v13(v21.Tombstone) then
			return "tombstone sanlayn 40";
		end
	end
	if (v21.Marrowrend:IsReady() and v7:IsInMeleeRange(295 - (60 + 230)) and not v6:BonestormTicking() and (((v31 < v29) and (v6:RunicPowerDeficit() > (592 - (426 + 146)))) or (v6:BuffRemains(v21.BoneShieldBuff) <= (1 + 2)))) then
		if v13(v21.Marrowrend) then
			return "marrowrend deathbringer 44";
		end
	end
	if (v21.BloodBoil:IsCastable() and ((v34 > (1456 - (282 + 1174))) or v7:IsInMeleeRange(819 - (569 + 242))) and ((v21.BloodBoil:ChargesFractional() >= (2.5 - 1)) or (v21.BloodBoil:FullRechargeTime() <= v6:GCD()))) then
		if v13(v21.BloodBoil) then
			return "blood_boil sanlayn 44";
		end
	end
	if (v21.Consumption:IsCastable() and v7:IsSpellInRange(v21.Consumption)) then
		if v13(v21.Consumption) then
			return "consumption deathbringer 48";
		end
	end
	if (v21.DeathStrike:IsReady() and v7:IsSpellInRange(v21.DeathStrike) and ((v6:RunicPowerDeficit() <= v30) or (v6:RunicPower() >= v27))) then
		if v13(v21.DeathStrike) then
			return "death_strike sanlayn 46";
		end
	end
	if (v21.BloodBoil:IsCastable() and ((v34 > (0 + 0)) or v7:IsInMeleeRange(1032 - (706 + 318))) and v7:IsInMeleeRange(1261 - (721 + 530)) and (v21.BloodBoil:ChargesFractional() >= (1272.5 - (945 + 326))) and (v6:BuffStack(v21.HemostasisBuff) < (12 - 7)) and (v21.ReapersMark:CooldownRemains() > (5 + 0))) then
		if v13(v21.BloodBoil) then
			return "blood_boil deathbringer 52";
		end
	end
	if (v21.HeartStrike:IsReady() and v7:IsSpellInRange(v21.HeartStrike) and ((v6:Rune() >= (701 - (271 + 429))) or (v6:RuneTimeToX(2 + 0) < v6:GCD()) or (v6:RunicPowerDeficit() >= v30))) then
		if v13(v21.HeartStrike) then
			return "heart_strike deathbringer 54";
		end
	end
	if (v21.BloodBoil:IsCastable() and ((v34 > (1500 - (1408 + 92))) or v7:IsInMeleeRange(1094 - (461 + 625)))) then
		if v13(v21.BloodBoil) then
			return "blood_boil deathbringer 56";
		end
	end
end
local function v83()
	if v6:IsChanneling(v22.ManicGrieftorch.ItemUseSpell) then
		return "Dont cut Torch";
	end
	v33 = v6:GetEnemiesInMeleeRange(1296 - (993 + 295));
	InterruptToggle = v12.ToggleIconFrame:GetToggle(1 + 2);
	SmallCDToggle = v12.ToggleIconFrame:GetToggle(1172 - (418 + 753));
	if v14() then
		v34 = #v33;
	else
		v34 = 1 + 0;
	end
	if (v44.TargetIsValid() or v6:AffectingCombat()) then
		v35 = v18(v34, (v6:BuffUp(v21.DeathAndDecayBuff) and (1 + 4)) or (1 + 1));
		v36 = v74(v33);
		v32 = v6:IsTankingAoE(3 + 5) or v6:IsTanking(v7);
		v31 = v6:BuffStack(v21.BoneShieldBuff);
	end
	if (v44.TargetIsValid() or v6:AffectingCombat()) then
		v39 = v3.BossFightRemains();
		v38 = true;
		v40 = v39;
		if (v40 == (11640 - (406 + 123))) then
			v38 = false;
			v40 = v3.FightRemains(v33, false);
		end
	end
	DnDSetting = v12.ToggleIconFrame:GetToggle(1773 - (1749 + 20)) and (v46.Commons.DnDMoving or not v6:IsMoving()) and v70(2 + 6);
	v41 = v21.HeartStrike:IsReady() or v21.VampiricStrikeAction:IsReady();
	RacialsSetting = v71(v46.Blood.RacialsSetting) and v70(v46.TTD.RacialsTTD) and v7:IsInMeleeRange(1327 - (1249 + 73));
	Trinket1Setting = v71(v46.Blood.Trinket1Setting, v46.Blood.TrinketHP);
	Trinket2Setting = v71(v46.Blood.Trinket2Setting, v46.Blood.TrinketHP);
	PotionSetting = v71(v46.Blood.PotionSetting) and not v44.ISSolo() and v7:IsInMeleeRange(2 + 3);
	AbominationLimbSetting = v71(v46.Blood.AbominationLimbSetting) and not v66() and v70(v46.TTD.AbominationLimbTTD) and v7:IsInMeleeRange(1160 - (466 + 679));
	EmpowerRuneWeaponSetting = v71(v46.Blood.EmpowerRuneWeaponSetting) and v70(v46.TTD.EmpowerRuneWeaponTTD) and v7:IsInMeleeRange(11 - 6);
	DancingRuneWeaponSetting = v71(v46.Blood.DancingRuneWeaponSetting, v46.Blood.DancingRuneWeaponHP) and v70(v46.TTD.DancingRuneWeaponTTD) and v7:IsInMeleeRange(14 - 9);
	RaiseDeadSetting = v71(v46.Blood.RaiseDeadSetting) and v70(v46.TTD.RaiseDeadTTD) and v7:IsInMeleeRange(1905 - (106 + 1794));
	WeaponSetting = v71(v46.Blood.Weapon);
	ReapersMarkSetting = v71(v46.Blood.ReapersMarkSetting) and v70(5 + 10);
	BonestormSetting = v71(v46.Blood.Bonestorm) and v70(4 + 11);
	if (v21.RaiseAlly:IsReady() and v46.Commons.RaiseAlly) then
		if (v8:UnitIsFriend() and v8:UnitIsPlayer() and v8:Exists() and v8:IsDeadOrGhost()) then
			v12.CastTarget(v21.RaiseAlly, v12.TName().MOUSEOVER);
			return "Raise Ally on Mouseover";
		end
		if (v7:UnitIsFriend() and v7:UnitIsPlayer() and v7:Exists() and v7:IsDeadOrGhost()) then
			v12.Cast(v21.RaiseAlly);
			return "Raise Ally on Target";
		end
	end
	if (v44.TargetIsValid() and (v7:AffectingCombat() or v46.Blood.AttackOutOfCombat)) then
		if not v6:AffectingCombat() then
			v43 = v79();
			if v43 then
				return v43;
			end
		end
		if v32 then
			v43 = v80();
			if v43 then
				return v43;
			end
		end
		if InterruptToggle then
			v43 = v44.InterruptCycle(v21.MindFreeze, 44 - 29, true, nil, false);
			if v43 then
				return v43;
			end
			if v46.Commons.BlindingSleet then
				v43 = v44.InterruptCycle(v21.BlindingSleet, 32 - 20, true, nil, true, true);
				if v43 then
					return v43;
				end
			end
			v43 = v44.InterruptCycle(v21.Asphyxiate, 134 - (4 + 110), true, nil, true);
			if v43 then
				return v43;
			end
		end
		if (v21.BloodBoil:IsCastable() and ((v34 > (584 - (57 + 527))) or v7:IsInMeleeRange(1435 - (41 + 1386))) and (v36 > (103 - (17 + 86)))) then
			if v13(v21.BloodBoil) then
				return "blood_boil missing Plague";
			end
		end
		if ((v6:HeroTreeID() == (23 + 10)) or (v6:Level() <= (156 - 86))) then
			local v217 = v81();
			if v217 then
				return v217;
			end
			local v217 = ((v34 > (0 - 0)) or v7:IsInMeleeRange(174 - (122 + 44))) and not v7:IsInRange(13 - 5) and v67();
			if v217 then
				return v217;
			end
			if v12.CastAnnotated(v21.Pool, false, "WAIT") then
				return "Pool for Deathbringer()";
			end
		end
		if (v6:HeroTreeID() == (102 - 71)) then
			local v218 = v82();
			if v218 then
				return v218;
			end
			local v218 = ((v34 > (0 + 0)) or v7:IsInMeleeRange(2 + 6)) and not v7:IsInRange(16 - 8) and v67();
			if v218 then
				return v218;
			end
			if v12.CastAnnotated(v21.Pool, false, "WAIT") then
				return "Pool for Sanlayn()";
			end
		end
	end
end
local function v84()
	v21.BloodPlagueDebuff:RegisterAuraTracking();
	v46.Blood.Display();
	v12:UpdateMacro("macro1", "/use 16");
	v12:UpdateMacro("macro2", "/target [@mouseover]");
	v12.Print("Blood Death Knight rotation has been updated for patch 11.0.2.");
end
v12.SetAPL(315 - (30 + 35), v83, v84);
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
v6.NeedDefensive = function(v127, v128, v129)
	local v130 = v127:IncomingSpell(v128);
	local v131 = v127:IncomingSpell(v129);
	if (v130 or v131) then
		for v213, v214 in ipairs(v24) do
			if v127:BuffUp(v214) then
				return false;
			end
		end
		for v215, v216 in ipairs(v25) do
			if v127:BuffUp(v216) then
				return false;
			end
		end
		return true;
	end
	return false;
end;
local v27 = (v21.ReapersMark:IsAvailable() and (12 + 38)) or (478 - (15 + 398));
local v29 = (v21.ReapersMark:IsAvailable() and (991 - (18 + 964))) or (44 - 32);
local v30 = 15 + 10 + (v16(v21.Heartbreaker:IsAvailable()) * (2 + 0));
local v31;
local v32;
local v33;
local v34;
local v35;
local v36;
local v37 = v20.GhoulTable;
local v38;
local v39 = 11961 - (20 + 830);
local v40 = 8674 + 2437;
local v41 = v21.HeartStrike:IsReady() or v21.VampiricStrikeAction:IsReady();
local v42 = (v21.Bonestorm:IsAvailable() and v21.Bonestorm:CooldownUp() and BonestormSetting and (v6:RunicPower() >= v6:RunicPowerMax())) or not v21.Bonestorm:IsAvailable() or v21.Bonestorm:CooldownDown() or not BonestormSetting;
local v43;
local v44 = v12.Commons().Everyone;
local v45 = v12.GUISettingsGet();
local v46 = {General=v45.General,Commons=v45.APL.DeathKnight.Commons,Defensives=v45.APL.DeathKnight.Blood.Defensives,Blood=v45.APL.DeathKnight.Blood,TTD=v45.APL.DeathKnight.Blood_TTD};
local v47, v48;
local v49, v50;
local v51, v52;
local v53, v54;
local v55, v56;
local v57, v58;
local v59, v60;
local v61, v62;
local v63 = 126 - (116 + 10);
local function v64()
	local v132, v133 = v6:GetTrinketData(v23);
	if ((v63 < (1 + 4)) and ((v132.ID == (738 - (542 + 196))) or (v133.ID == (0 - 0)) or (v132.Level == (0 + 0)) or (v133.Level == (0 + 0)) or ((v132.SpellID > (0 + 0)) and not v132.Usable) or ((v133.SpellID > (0 - 0)) and not v133.Usable))) then
		v63 = v63 + (2 - 1);
		v19(1556 - (1126 + 425), function()
			v64();
		end);
		return;
	end
	v47 = v132.Object;
	v48 = v133.Object;
	v49 = v132.ID;
	v50 = v133.ID;
	v51 = v132.Level;
	v52 = v133.Level;
	v53 = v132.Spell;
	v55 = v132.Range;
	v57 = v132.CastTime;
	v54 = v133.Spell;
	v56 = v133.Range;
	v58 = v133.CastTime;
	v59 = v132.Cooldown;
	v60 = v133.Cooldown;
	v61 = v132.Blacklisted;
	v62 = v133.Blacklisted;
end
v64();
v3:RegisterForEvent(function()
	v64();
end, "PLAYER_EQUIPMENT_CHANGED");
v5.IsTankingAllAoE = function(v150, v151, v152, v153)
	local v154 = v6:GetEnemiesInRange(v151 or (411.5 - (118 + 287)));
	local v155 = 0 - 0;
	local v156 = 1121 - (118 + 1003);
	for v181, v182 in pairs(v154) do
		if not (v152 and v152[v182:ID()]) then
			v155 = v155 + (2 - 1);
			if v150:IsTanking(v182, v153) then
				v156 = v156 + (378 - (142 + 235));
			end
		end
	end
	return v156 >= v155;
end;
local function v66()
	local v157 = v6:GetEnemiesInRange(181 - 141);
	for v183, v184 in pairs(v157) do
		if ((v184:NPCID() == (8782 + 31575)) or (v184:CastSpellID() == (448990 - (553 + 424)))) then
			print("npc found: do not use abo limb");
			return true;
		end
	end
	return false;
end
local function v67()
	if (v45.General.AutoTab and v6:AffectingCombat()) then
		v12.TopPanelAlternative:ChangeIcon(1 - 0, 3 + 0);
		return "Auto tab to target";
	end
end
local function v68()
	return v22.ManicGrieftorch:IsEquipped() and (v22.ManicGrieftorch:CooldownUp() or (v22.ManicGrieftorch:CooldownRemains() <= v6:GCDRemains()));
end
local function v69()
	return v22.AlgetharPuzzleBox:IsEquipped() and (v22.AlgetharPuzzleBox:CooldownUp() or (v22.AlgetharPuzzleBox:CooldownRemains() <= v6:GCDRemains()));
end
v3:RegisterForEvent(function()
	v27 = (v21.ReapersMark:IsAvailable() and (50 + 0)) or (38 + 27);
	v29 = (v21.ReapersMark:IsAvailable() and (4 + 5)) or (7 + 5);
end, "SPELLS_CHANGED", "LEARNED_SPELL_IN_TAB");
local function v70(v158)
	return v38 or v44.ISSolo() or (v158 == (0 - 0)) or v44.Buggedmobs[v7:NPCID()] or ((v40 >= v158) and (v40 < (21669 - 13892)));
end
local function v71(v159, v160)
	return (v159 ~= "Not Used") and ((v70(v46.TTD.TrinketsTTD) and (((v159 == "With Cooldowns") and v12.CDsON()) or ((v159 == "With Small or Cooldowns") and (SmallCDToggle or v12.CDsON())) or ((v159 == "With Small CDs") and SmallCDToggle) or ((v159 == "On Mobcount") and (v34 >= v46.Blood.Mobcount)) or ((v159 == "On Mobcount or Cooldowns") and ((v34 >= v46.Blood.Mobcount) or v15())) or (v159 == "Always") or ((v159 == "On Bosses") and v38) or ((v159 == "Mobcount or Boss") and (v38 or (v34 >= v46.Blood.Mobcount))))) or ((v159 == "On HealthPercent") and (v160 ~= nil) and (v6:HealthPercentageWeighted() <= v160)));
end
local function v72(v161, v162, v163)
	if (v38 or v44.ISSolo() or (v163 == (0 - 0)) or ((v40 >= v163) and (v40 < (2262 + 5515)))) then
		v12.Cast(v161, v162);
		return "TTD cast " .. v161:Name();
	end
end
local v73 = v6:GetEquipment();
local v47 = (v73[62 - 49] and v11(v73[766 - (239 + 514)])) or v11(0 + 0);
local v48 = (v73[1343 - (797 + 532)] and v11(v73[11 + 3])) or v11(0 + 0);
v3:RegisterForEvent(function()
	v73 = v6:GetEquipment();
	v47 = (v73[29 - 16] and v11(v73[1215 - (373 + 829)])) or v11(731 - (476 + 255));
	v48 = (v73[1144 - (369 + 761)] and v11(v73[9 + 5])) or v11(0 - 0);
end, "PLAYER_EQUIPMENT_CHANGED");
local function v74(v164)
	local v165 = 0 - 0;
	for v185, v186 in pairs(v164) do
		if not v186:DebuffUp(v21.BloodPlagueDebuff) then
			v165 = v165 + (239 - (64 + 174));
		end
	end
	return v165;
end
local function v76(v166)
	for v187, v188 in pairs(v44.TankBustersList) do
		if v166:CastSpellID(v188) then
			return true;
		end
	end
	return false;
end
local function v77(v167)
	for v189, v190 in pairs(v44.TankBustersPhysicalList) do
		if v167:CastSpellID(v190) then
			return true;
		end
	end
	return false;
end
local function v78(v168)
	for v191, v192 in pairs(v44.TankBustersMagicList) do
		if v168:CastSpellID(v192) then
			return true;
		end
	end
	return false;
end
local function v79()
	if (v21.DeathsCaress:IsCastable() and v21.DeathsCaress:IsAvailable() and v7:IsSpellInRange(v21.DeathsCaress)) then
		if v13(v21.DeathsCaress) then
			return "deaths_caress precombat 2";
		end
	end
	if (v21.Marrowrend:IsReady() and v7:IsInMeleeRange(1 + 4)) then
		if v13(v21.Marrowrend) then
			return "marrowrend precombat 6";
		end
	end
end
local function v80()
	if (v21.RuneTap:IsReady() and v32 and (v21.RuneTap:Charges() > (1 - 0)) and ((v6:HealthPercentageWeighted() <= v46.Blood.Defensives.RuneTapThreshold) or (v6:NeedDefensive(v44.TankBustersList2, v44.TankBustersMagicList) and v46.Blood.Defensives.TankBusters)) and (v6:Rune() >= (339 - (144 + 192))) and (v21.RuneTap:Charges() >= (217 - (42 + 174))) and v6:BuffDown(v21.RuneTapBuff)) then
		if v13(v21.RuneTap, true) then
			return "rune_tap defensives 1";
		end
	end
	if (v21.Lichborne:IsCastable() and v32 and ((v6:HealthPercentageWeighted() <= v46.Blood.Defensives.LichborneHP) or (v6:NeedDefensive(v44.TankBustersList2, v44.TankBustersMagicList) and v46.Blood.Defensives.TankBusters))) then
		if v13(v21.Lichborne, true) then
			return "Lichborne defensives";
		end
	end
	if (v21.IceboundFortitude:IsCastable() and v32 and ((v6:HealthPercentageWeighted() <= v46.Blood.Defensives.IceboundFortitudeHP) or (v6:NeedDefensive(v44.TankBustersList2, v44.TankBustersMagicList) and v46.Blood.Defensives.TankBusters))) then
		if v13(v21.IceboundFortitude, true) then
			return "icebound_fortitude defensives";
		end
	end
	if (v21.RuneTap:IsReady() and v32 and ((v6:HealthPercentageWeighted() <= v46.Blood.Defensives.RuneTapThreshold) or (v6:NeedDefensive(v44.TankBustersList2, v44.TankBustersMagicList) and v46.Blood.Defensives.TankBusters)) and (v6:Rune() >= (3 + 0)) and (v21.RuneTap:Charges() >= (1 + 0)) and v6:BuffDown(v21.RuneTapBuff)) then
		if v13(v21.RuneTap, true) then
			return "rune_tap defensives 2";
		end
	end
	if (v21.AntiMagicShell:IsCastable() and v32 and ((v6:HealthPercentageWeighted() <= v46.Blood.Defensives.AntiMagicShellHP) or (v6:NeedDefensive(v44.TankBustersList2, v44.TankBustersMagicList) and v46.Blood.Defensives.TankBusters))) then
		if v13(v21.AntiMagicShell, true) then
			return "AntiMagicShell defensives";
		end
	end
	if (v21.AntiMagicZone:IsCastable() and v32 and ((v6:HealthPercentageWeighted() <= v46.Blood.Defensives.AntiMagicZoneHP) or (v6:NeedDefensive(v44.TankBustersList2, v44.TankBustersMagicList) and v46.Blood.Defensives.TankBusters and v46.Blood.Defensives.AntiMagicZoneOnTankBuster))) then
		if v12.CastTarget(v21.AntiMagicZone, v12.TName().PLAYER, true) then
			return "AntiMagicZone defensives";
		end
	end
	if (v21.VampiricBlood:IsCastable() and v32 and (v6:HealthPercentageWeighted() <= v46.Blood.Defensives.VampiricBloodThreshold)) then
		if v13(v21.VampiricBlood, true) then
			return "vampiric_blood defensives 14";
		end
	end
	if (v6:ActiveMitigationNeeded() and (v21.Marrowrend:TimeSinceLastCast() > (1.5 + 1)) and (v21.DeathStrike:TimeSinceLastCast() > (1506.5 - (363 + 1141)))) then
		if (v21.DeathStrike:IsReady() and v7:IsSpellInRange(v21.DeathStrike) and (v6:BuffStack(v21.BoneShieldBuff) > (1587 - (1183 + 397)))) then
			if v13(v21.DeathStrike) then
				return "death_strike defensives 4";
			end
		end
		if (v21.Marrowrend:IsReady() and v7:IsInMeleeRange(15 - 10)) then
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
	if (v21.DeathStrike:IsReady() and v7:IsSpellInRange(v21.DeathStrike) and (v6:HealthPercentageWeighted() <= (37 + 13 + (((v6:RunicPower() > v27) and (15 + 5)) or (1975 - (1913 + 62))))) and not v6:HealingAbsorbed()) then
		if v13(v21.DeathStrike) then
			return "death_strike defensives 18";
		end
	end
end
local function v81()
	v30 = 16 + 9 + (v34 * v16(v21.Heartbreaker:IsAvailable()) * (5 - 3));
	if (v46.Commons.Enabled.Potions and v6:BuffUp(v21.DancingRuneWeaponBuff)) then
		local v201 = v44.PotionSelected();
		if (v201 and v201:IsReady()) then
			v12.CastMacro(1936 - (565 + 1368), nil, nil, v201);
			return "Cast Potion";
		end
	end
	if (v21.DeathsCaress:IsReady() and v21.DeathsCaress:IsAvailable() and v7:IsSpellInRange(v21.DeathsCaress) and (v6:BuffDown(v21.BoneShieldBuff))) then
		if v13(v21.DeathsCaress) then
			return "deaths_caress deathbringer 4";
		end
	end
	if (v21.DeathStrike:IsReady() and v7:IsSpellInRange(v21.DeathStrike) and ((v6:BuffRemains(v21.CoagulopathyBuff) <= v6:GCD()) or (v6:RunicPowerDeficit() < (131 - 96)))) then
		if v13(v21.DeathStrike) then
			return "death_strike deathbringer 6";
		end
	end
	if (v21.BloodBoil:IsCastable() and ((v34 > (1661 - (1477 + 184))) or v7:IsInMeleeRange(10 - 2)) and v6:BuffUp(v21.DancingRuneWeaponBuff) and (v6:BuffRemains(v21.DancingRuneWeaponBuff) >= ((14 + 0) - ((858 - (564 + 292)) * v6:GCD())))) then
		if v13(v21.BloodBoil) then
			return "blood_boil deathbringer 8";
		end
	end
	if (v21.BloodBoil:IsCastable() and ((v34 > (0 - 0)) or v7:IsInMeleeRange(23 - 15)) and v7:DebuffUp(v21.ReapersMarkDebuff) and (v7:DebuffRemains(v21.ReapersMarkDebuff) < (307 - (244 + 60)))) then
		if v13(v21.BloodBoil) then
			return "blood_boil deathbringer 10";
		end
	end
	if (v31 >= (8 + 2)) then
		local v202, v203, v204 = v6:GetUseableItems(v23);
		if v202 then
			if ((((v203 == (489 - (41 + 435))) and Trinket1Setting) or ((v203 == (1015 - (938 + 63))) and Trinket2Setting)) and v46.Commons.Enabled.Trinkets) then
				if v13(v202) then
					return "use_items deathbringer 12";
				end
			end
			if ((v203 ~= (10 + 3)) and (v203 ~= (1139 - (936 + 189))) and v46.Commons.Enabled.Items) then
				v12.CastMacro(1 + 0);
				return "weapon cast";
			end
		end
	end
	if (v21.BloodBoil:IsCastable() and ((v34 > (1613 - (1565 + 48))) or v7:IsInMeleeRange(5 + 3)) and ((v21.BloodPlagueDebuff:AuraActiveCount() == (1138 - (782 + 356))) or ((v21.BloodBoil:ChargesFractional() >= (268 - (176 + 91))) and v7:DebuffUp(v21.ReapersMarkDebuff) and (v6:BuffRemains(v21.CoagulopathyBuff) > ((4 - 2) * v6:GCD()))))) then
		if v13(v21.BloodBoil) then
			return "blood_boil deathbringer 14";
		end
	end
	if (v21.DeathAndDecay:IsReady() and DnDSetting and ((v34 > (0 - 0)) or v7:IsInMeleeRange(1100 - (975 + 117))) and ((v7:DebuffUp(v21.ReapersMarkDebuff) and not v6:DnDTicking()) or v6:BuffDown(v21.DeathAndDecayBuff))) then
		if v12.CastTarget(v21.DeathAndDecay, v12.TName().PLAYER) then
			return "death_and_decay deathbringer 16";
		end
	end
	if (v21.Marrowrend:IsReady() and v7:IsInMeleeRange(1880 - (157 + 1718)) and (v6:BuffUp(v21.PainfulDeathBuff) or v6:BuffUp(v21.ExterminateBuff)) and (v6:RunicPowerDeficit() > (25 + 5)) and (v6:BuffRemains(v21.CoagulopathyBuff) > ((6 - 4) * v6:GCD()))) then
		if v13(v21.Marrowrend) then
			return "marrowrend deathbringer 18";
		end
	end
	if (v21.RaiseDead:IsCastable() and RaiseDeadSetting) then
		if v13(v21.RaiseDead) then
			return "raise_dead deathbringer 20";
		end
	end
	if (v21.AbominationLimb:IsCastable() and AbominationLimbSetting and v7:IsInRange(68 - 48) and (v7:DebuffUp(v21.ReapersMarkDebuff))) then
		if v13(v21.AbominationLimb) then
			return "abomination_limb deathbringer 22";
		end
	end
	if (v21.ReapersMark:IsReady() and ReapersMarkSetting and v7:IsInMeleeRange(1023 - (697 + 321)) and (v7:DebuffDown(v21.ReapersMarkDebuff))) then
		if v13(v21.ReapersMark) then
			return "reapers_mark deathbringer 24";
		end
	end
	if (v21.Bonestorm:IsReady() and BonestormSetting and v7:IsInMeleeRange(21 - 13) and (v31 >= (10 - 5)) and (v21.DancingRuneWeapon:CooldownRemains() >= (23 - 13)) and v7:DebuffUp(v21.ReapersMarkDebuff)) then
		if v13(v21.Bonestorm) then
			return "bonestorm deathbringer 26";
		end
	end
	if (v21.Consumption:IsCastable() and v7:IsInMeleeRange(2 + 3) and (v7:DebuffUp(v21.ReapersMarkDebuff))) then
		if v13(v21.Consumption) then
			return "consumption deathbringer 28";
		end
	end
	if (v21.AbominationLimb:IsCastable() and AbominationLimbSetting and v7:IsInRange(37 - 17)) then
		if v13(v21.AbominationLimb) then
			return "abomination_limb deathbringer 30";
		end
	end
	if (v21.Blooddrinker:IsReady() and v7:IsSpellInRange(v21.Blooddrinker) and (v6:BuffRemains(v21.CoagulopathyBuff) > (10 - 6)) and v6:BuffDown(v21.DancingRuneWeaponBuff)) then
		if v13(v21.Blooddrinker) then
			return "blooddrinker deathbringer 32";
		end
	end
	if (v21.DancingRuneWeapon:IsCastable() and DancingRuneWeaponSetting and v7:IsInMeleeRange(1235 - (322 + 905)) and v6:BuffDown(v21.DancingRuneWeaponBuff) and (v6:BuffRemains(v21.CoagulopathyBuff) > ((613 - (602 + 9)) * v6:GCD()))) then
		if v13(v21.DancingRuneWeapon) then
			return "dancing_rune_weapon deathbringer 34";
		end
	end
	if (v21.Marrowrend:IsReady() and v7:IsInMeleeRange(1194 - (449 + 740)) and not v6:BonestormTicking() and (((v31 < v29) and (v6:RunicPowerDeficit() > (892 - (826 + 46)))) or (v6:BuffRemains(v21.BoneShieldBuff) <= (950 - (245 + 702))))) then
		if v13(v21.Marrowrend) then
			return "marrowrend deathbringer 36";
		end
	end
	if (v21.DancingRuneWeapon:CooldownUp() and RacialsSetting and v7:IsInMeleeRange(24 - 16)) then
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
	if (v21.Tombstone:IsReady() and v7:IsInMeleeRange(3 + 5) and v21.Bonestorm:CooldownUp() and (v31 > (1908 - (260 + 1638))) and (v6:RunicPowerDeficit() >= (470 - (382 + 58))) and (v21.DancingRuneWeapon:CooldownRemains() >= (32 - 22))) then
		if v13(v21.Tombstone) then
			return "tombstone deathbringer 42";
		end
	end
	if (v21.Bonestorm:IsReady() and BonestormSetting and v7:IsInMeleeRange(7 + 1) and (v31 > (9 - 4)) and (v21.DancingRuneWeapon:CooldownRemains() >= (29 - 19))) then
		if v13(v21.Bonestorm) then
			return "bonestorm deathbringer 44";
		end
	end
	if (v21.Tombstone:IsReady() and v7:IsInMeleeRange(1213 - (902 + 303)) and (v31 > (10 - 5)) and (v6:RunicPowerDeficit() >= (72 - 42)) and (v21.DancingRuneWeapon:CooldownRemains() >= (1 + 9))) then
		if v13(v21.Tombstone) then
			return "tombstone deathbringer 46";
		end
	end
	if (v21.SoulReaper:IsReady() and v7:IsInMeleeRange(1695 - (1121 + 569)) and (v34 == (215 - (22 + 192))) and (v7:TimeToX(718 - (483 + 200)) < (1468 - (1404 + 59))) and (v7:TimeToDie() > (v7:DebuffRemains(v21.SoulReaperDebuff) + (13 - 8)))) then
		if v13(v21.SoulReaper) then
			return "soul_reaper deathbringer 48";
		end
	end
	if (v21.BloodBoil:IsCastable() and ((v34 > (0 - 0)) or v7:IsInMeleeRange(773 - (468 + 297))) and ((v21.BloodBoil:Charges() >= (564 - (334 + 228))) or (v21.BloodBoil:FullRechargeTime() <= v6:GCD()))) then
		if v13(v21.BloodBoil) then
			return "blood_boil deathbringer 50";
		end
	end
	if (v21.Consumption:IsCastable() and v7:IsInMeleeRange(16 - 11)) then
		if v13(v21.Consumption) then
			return "consumption deathbringer 52";
		end
	end
	if (v21.DeathStrike:IsReady() and v7:IsSpellInRange(v21.DeathStrike) and ((v6:RunicPowerDeficit() <= v30) or (v6:RunicPower() >= v27))) then
		if v13(v21.DeathStrike) then
			return "death_strike deathbringer 54";
		end
	end
	if (v21.BloodTap:IsCastable() and (v6:Rune() <= (2 - 1))) then
		if v13(v21.BloodTap) then
			return "blood_tap deathbringer 56";
		end
	end
	if (v21.BloodBoil:IsCastable() and ((v34 > (0 - 0)) or v7:IsInMeleeRange(3 + 5)) and (v21.BloodBoil:ChargesFractional() >= (237.1 - (141 + 95))) and (v6:BuffStack(v21.HemostasisBuff) < (5 + 0))) then
		if v13(v21.BloodBoil) then
			return "blood_boil deathbringer 58";
		end
	end
	if (v41 and v7:IsInMeleeRange(12 - 7) and ((v6:RuneTimeToX(4 - 2) < v6:GCD()) or (v6:RunicPowerDeficit() >= v30))) then
		if v13(v21.HeartStrike) then
			return "heart_strike deathbringer 60";
		end
	end
	if (v21.BloodBoil:IsCastable() and ((v34 > (0 + 0)) or v7:IsInMeleeRange(21 - 13))) then
		if v13(v21.BloodBoil) then
			return "blood_boil deathbringer 62";
		end
	end
end
local function v82()
	v30 = 18 + 7 + (v34 * v16(v21.Heartbreaker:IsAvailable()) * (2 + 0));
	if (v46.Commons.Enabled.Potions and v6:BuffUp(v21.DancingRuneWeaponBuff)) then
		local v205 = v44.PotionSelected();
		if (v205 and v205:IsReady()) then
			if (v205 and v205:IsReady()) then
				v12.CastMacro(4 - 1, nil, nil, v205);
				return "Cast Potion";
			end
		end
	end
	if (v41 and v7:IsInMeleeRange(3 + 2) and v6:BuffUp(v21.VampiricBloodBuff) and (v6:BuffRemains(v21.EssenceoftheBloodQueenBuff) < ((165 - (92 + 71)) * v6:GCD()))) then
		if v13(v21.HeartStrike) then
			return "heart_strike sanlayn 4";
		end
	end
	if (v41 and v7:IsInMeleeRange(3 + 2) and v21.VampiricStrikeAction:IsLearned() and (v6:BuffRemains(v21.EssenceoftheBloodQueenBuff) < (4 - 1))) then
		if v13(v21.HeartStrike) then
			return "heart_strike sanlayn 6";
		end
	end
	if (v21.VampiricBlood:IsCastable() and not (v21.Bonestorm:CooldownUp() or v21.DancingRuneWeapon:CooldownUp() or v21.Tombstone:CooldownUp()) and v32 and (v6:HealthPercentageWeighted() <= v46.Blood.Defensives.VampiricBloodThreshold)) then
		if v13(v21.VampiricBlood) then
			return "vampiric_blood sanlayn 8";
		end
	end
	if (v21.DeathsCaress:IsReady() and v7:IsSpellInRange(v21.DeathsCaress) and (v6:BuffDown(v21.BoneShieldBuff))) then
		if v13(v21.DeathsCaress) then
			return "deaths_caress sanlayn 10";
		end
	end
	if (v21.DeathStrike:IsReady() and v7:IsInMeleeRange(770 - (574 + 191)) and (v6:BuffRemains(v21.CoagulopathyBuff) <= v6:GCD())) then
		if v13(v21.DeathStrike) then
			return "death_strike sanlayn 12";
		end
	end
	if ((v46.Commons.Enabled.Trinkets or v46.Commons.Enabled.Items) and (v31 >= (9 + 1))) then
		local v206, v207, v208 = v6:GetUseableItems(v23);
		if v206 then
			if ((((v207 == (32 - 19)) and Trinket1Setting) or ((v207 == (8 + 6)) and Trinket2Setting)) and v46.Commons.Enabled.Trinkets) then
				if v13(v206) then
					return "use_items sanlayn 12";
				end
			end
			if ((v207 ~= (862 - (254 + 595))) and (v207 ~= (140 - (55 + 71))) and v46.Commons.Enabled.Items) then
				v12.CastMacro(1 - 0);
				return "weapon cast";
			end
		end
	end
	if (v21.BloodBoil:IsReady() and ((v34 > (1790 - (573 + 1217))) or v7:IsInMeleeRange(22 - 14)) and (v7:DebuffDown(v21.BloodPlagueDebuff))) then
		if v13(v21.BloodBoil) then
			return "blood_boil sanlayn 16";
		end
	end
	if (v21.DeathAndDecay:IsReady() and DnDSetting and ((v34 > (0 + 0)) or v7:IsInMeleeRange(12 - 4)) and not v6:DnDTicking()) then
		if v12.CastTarget(v21.DeathAndDecay, v12.TName().PLAYER) then
			return "death_and_decay sanlayn 18";
		end
	end
	if (v21.RaiseDead:IsCastable() and RaiseDeadSetting and v7:IsInMeleeRange(947 - (714 + 225))) then
		if v13(v21.RaiseDead) then
			return "raise_dead sanlayn 20";
		end
	end
	if (v21.DancingRuneWeapon:IsCastable() and v7:IsInMeleeRange(23 - 15) and DancingRuneWeaponSetting and (v6:BuffDown(v21.DancingRuneWeaponBuff))) then
		if v13(v21.DancingRuneWeapon) then
			return "dancing_rune_weapon sanlayn 22";
		end
	end
	if (v21.Marrowrend:IsReady() and v7:IsInMeleeRange(6 - 1) and not v6:BonestormTicking() and (((v31 < v29) and (v6:RunicPowerDeficit() > (3 + 17))) or (v6:BuffRemains(v21.BoneShieldBuff) <= (3 - 0)))) then
		if v13(v21.Marrowrend) then
			return "marrowrend sanlayn 24";
		end
	end
	if (v21.Consumption:IsCastable() and v7:IsSpellInRange(v21.Consumption) and ((v6:BuffRemains(v21.VampiricBloodBuff) <= (809 - (118 + 688))) or v6:BuffUp(v21.InflictionofSorrowBuff) or (v21.VampiricBlood:CooldownRemains() > (53 - (25 + 23))))) then
		if v13(v21.Consumption) then
			return "consumption sanlayn 26";
		end
	end
	if (v21.DeathStrike:IsReady() and v7:IsSpellInRange(v21.DeathStrike) and v6:BuffUp(v21.VampiricBloodBuff) and (v6:BuffRemains(v21.CoagulopathyBuff) < (1 + 2))) then
		if v13(v21.DeathStrike) then
			return "death_strike sanlayn 28";
		end
	end
	if (v41 and v7:IsInMeleeRange(1891 - (927 + 959)) and (v21.VampiricStrikeAction:IsLearned())) then
		if v13(v21.HeartStrike) then
			return "heart_strike sanlayn 30";
		end
	end
	if (v21.AbominationLimb:IsCastable() and AbominationLimbSetting and v7:IsInRange(67 - 47)) then
		if v13(v21.AbominationLimb) then
			return "abomination_limb sanlayn 32";
		end
	end
	if (v21.DancingRuneWeapon:CooldownUp() and RacialsSetting and v7:IsInMeleeRange(740 - (16 + 716))) then
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
	if (v21.Bonestorm:IsReady() and BonestormSetting and v7:IsInMeleeRange(15 - 7) and (v31 > (102 - (11 + 86))) and (v21.DancingRuneWeapon:CooldownRemains() >= (60 - 35))) then
		if v13(v21.Bonestorm) then
			return "bonestorm sanlayn 38";
		end
	end
	if (v21.Tombstone:IsReady() and v7:IsInMeleeRange(293 - (175 + 110)) and (v31 > (12 - 7)) and (v6:RunicPowerDeficit() >= (147 - 117)) and (v21.DancingRuneWeapon:CooldownRemains() >= (1821 - (503 + 1293)))) then
		if v13(v21.Tombstone) then
			return "tombstone sanlayn 40";
		end
	end
	if (v21.SoulReaper:IsReady() and v7:IsInMeleeRange(13 - 8) and (v34 == (1 + 0)) and (v7:TimeToX(1096 - (810 + 251)) < (4 + 1)) and (v7:TimeToDie() > (v7:DebuffRemains(v21.SoulReaperDebuff) + 2 + 3))) then
		if v13(v21.SoulReaper) then
			return "soul_reaper sanlayn 42";
		end
	end
	if (v21.BloodBoil:IsCastable() and ((v34 > (0 + 0)) or v7:IsInMeleeRange(541 - (43 + 490))) and ((v21.BloodBoil:Charges() >= (735 - (711 + 22))) or (v21.BloodBoil:FullRechargeTime() <= v6:GCD()))) then
		if v13(v21.BloodBoil) then
			return "blood_boil sanlayn 44";
		end
	end
	if (v21.DeathStrike:IsReady() and v7:IsSpellInRange(v21.DeathStrike) and ((v6:RunicPowerDeficit() <= v30) or (v6:RunicPower() >= v27))) then
		if v13(v21.DeathStrike) then
			return "death_strike sanlayn 46";
		end
	end
	if (v21.BloodBoil:IsCastable() and ((v34 > (0 - 0)) or v7:IsInMeleeRange(867 - (240 + 619)))) then
		if v13(v21.BloodBoil) then
			return "blood_boil sanlayn 48";
		end
	end
end
local function v83()
	v44.HealthPotions();
	if v6:IsChanneling(v22.ManicGrieftorch.ItemUseSpell) then
		return "Dont cut Torch";
	end
	v33 = v6:GetEnemiesInMeleeRange(2 + 6);
	InterruptToggle = v12.ToggleIconFrame:GetToggle(4 - 1);
	SmallCDToggle = v12.ToggleIconFrame:GetToggle(1 + 0);
	if v14() then
		v34 = #v33;
	else
		v34 = 1745 - (1344 + 400);
	end
	if (v44.TargetIsValid() or v6:AffectingCombat()) then
		v35 = v18(v34, (v6:BuffUp(v21.DeathAndDecayBuff) and (410 - (255 + 150))) or (2 + 0));
		v36 = v74(v33);
		v32 = v6:IsTankingAoE(5 + 3) or v6:IsTanking(v7);
		v31 = v6:BuffStack(v21.BoneShieldBuff);
	end
	if (v44.TargetIsValid() or v6:AffectingCombat()) then
		v39 = v3.BossFightRemains();
		v38 = true;
		v40 = v39;
		if (v40 == (47472 - 36361)) then
			v38 = false;
			v40 = v3.FightRemains(v33, false);
		end
	end
	DnDSetting = v12.ToggleIconFrame:GetToggle(12 - 8) and (v46.Commons.DnDMoving or not v6:IsMoving()) and v70(1747 - (404 + 1335));
	v41 = v21.HeartStrike:IsReady() or v21.VampiricStrikeAction:IsReady();
	RacialsSetting = v71(v46.Blood.RacialsSetting) and v70(v46.TTD.RacialsTTD) and v7:IsInMeleeRange(411 - (183 + 223));
	Trinket1Setting = v71(v46.Blood.Trinket1Setting, v46.Blood.TrinketHP);
	Trinket2Setting = v71(v46.Blood.Trinket2Setting, v46.Blood.TrinketHP);
	PotionSetting = v71(v46.Blood.PotionSetting) and not v44.ISSolo() and v7:IsInMeleeRange(6 - 1);
	AbominationLimbSetting = v71(v46.Blood.AbominationLimbSetting) and not v66() and v70(v46.TTD.AbominationLimbTTD) and v7:IsInMeleeRange(10 + 5);
	EmpowerRuneWeaponSetting = v71(v46.Blood.EmpowerRuneWeaponSetting) and v70(v46.TTD.EmpowerRuneWeaponTTD) and v7:IsInMeleeRange(2 + 3);
	DancingRuneWeaponSetting = v71(v46.Blood.DancingRuneWeaponSetting, v46.Blood.DancingRuneWeaponHP) and v70(v46.TTD.DancingRuneWeaponTTD) and v7:IsInMeleeRange(342 - (10 + 327));
	RaiseDeadSetting = v71(v46.Blood.RaiseDeadSetting) and v70(v46.TTD.RaiseDeadTTD) and v7:IsInMeleeRange(4 + 1);
	WeaponSetting = v71(v46.Blood.Weapon);
	ReapersMarkSetting = v71(v46.Blood.ReapersMarkSetting) and v70(353 - (118 + 220));
	BonestormSetting = v71(v46.Blood.Bonestorm) and v70(5 + 10);
	if (v21.RaiseAlly:IsReady() and v46.Commons.RaiseAlly) then
		if (v8:UnitIsFriend() and v8:UnitIsPlayer() and v8:Exists() and v8:IsDeadOrGhost()) then
			v12.CastTarget(v21.RaiseAlly, v12.TName().MOUSEOVER);
			return "Raise Ally on Mouseover";
		end
		if (v7:UnitIsFriend() and v7:UnitIsPlayer() and v7:Exists() and v7:IsDeadOrGhost()) then
			v12.Cast(v21.RaiseAlly);
			return "Raise Ally on Target";
		end
	end
	if (v44.TargetIsValid() and (v7:AffectingCombat() or v46.Blood.AttackOutOfCombat)) then
		if not v6:AffectingCombat() then
			v43 = v79();
			if v43 then
				return v43;
			end
		end
		if v32 then
			v43 = v80();
			if v43 then
				return v43;
			end
		end
		if InterruptToggle then
			v43 = v44.InterruptCycle(v21.MindFreeze, 464 - (108 + 341), true, nil, false);
			if v43 then
				return v43;
			end
			if v46.Commons.BlindingSleet then
				v43 = v44.InterruptCycle(v21.BlindingSleet, 6 + 6, true, nil, true, true);
				if v43 then
					return v43;
				end
			end
			v43 = v44.InterruptCycle(v21.Asphyxiate, 84 - 64, true, nil, true);
			if v43 then
				return v43;
			end
		end
		if (v21.BloodBoil:IsCastable() and ((v34 > (1493 - (711 + 782))) or v7:IsInMeleeRange(15 - 7)) and (v36 > (469 - (270 + 199)))) then
			if v13(v21.BloodBoil) then
				return "blood_boil missing Plague";
			end
		end
		if ((v6:HeroTreeID() == (11 + 22)) or (v6:Level() <= (1889 - (580 + 1239)))) then
			local v219 = v81();
			if v219 then
				return v219;
			end
			local v219 = ((v34 > (0 - 0)) or v7:IsInMeleeRange(8 + 0)) and not v7:IsInRange(1 + 7) and v67();
			if v219 then
				return v219;
			end
			if v12.CastAnnotated(v21.Pool, false, "WAIT") then
				return "Pool for Deathbringer()";
			end
		end
		if (v6:HeroTreeID() == (14 + 17)) then
			local v220 = v82();
			if v220 then
				return v220;
			end
			local v220 = ((v34 > (0 - 0)) or v7:IsInMeleeRange(5 + 3)) and not v7:IsInRange(1175 - (645 + 522)) and v67();
			if v220 then
				return v220;
			end
			if v12.CastAnnotated(v21.Pool, false, "WAIT") then
				return "Pool for Sanlayn()";
			end
		end
	end
end
local function v84()
	v21.BloodPlagueDebuff:RegisterAuraTracking();
	v46.Blood.Display();
	v12:UpdateMacro("macro1", "/use 16");
	v12:UpdateMacro("macro2", "/target [@mouseover]");
	v44.PostInitialMessage(2040 - (1010 + 780));
end
v12.SetAPL(250 + 0, v83, v84);
