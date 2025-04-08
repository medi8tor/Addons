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
local v14 = v12.CDsON;
local v15 = v12.AoEON;
local v16 = v12.Commons().Everyone.num;
local v17 = v12.Commons().Everyone.bool;
local v18 = strsplit;
local v19 = C_Timer.After;
local v20 = GetInventoryItemLink;
local v21 = C_Item.IsEquippedItemType;
local v22 = v12.Commons().DeathKnight;
local v23 = v10.DeathKnight.Frost;
local v24 = v11.DeathKnight.Frost;
local v25 = {v24.AlgetharPuzzleBox:ID(),v24.Fyralath:ID(),v24.ManicGrieftorch:ID(),v24.TreacherousTransmitter:ID()};
local v26 = v12.Commons().Everyone;
local v27 = v12.GUISettingsGet();
local v28 = {General=v27.General,Commons=v27.APL.DeathKnight.Commons,Defensives=v27.APL.DeathKnight.Frost.Defensives,Frost=v27.APL.DeathKnight.Frost,TTD=v27.APL.DeathKnight.Frost_TTD};
local v29 = ((v23.Icecap:IsAvailable()) and (664 - (555 + 64))) or (991 - (857 + 74));
local v30, v31;
local v32, v33;
local v34, v35;
local v36, v37;
local v38, v39;
local v40, v41;
local v42, v43;
local v44, v45;
local v46, v47;
local v48, v49;
local v50, v51;
local v52, v53;
local v54, v55;
local v56, v57;
local v58;
local v59 = v23.GatheringStorm:IsAvailable() or v23.BitingCold:IsAvailable();
local v60, v61, v62;
local v63, v64, v65;
local v66, v67;
local v68, v69;
local v70, v71;
local v72, v73;
local v74 = 11679 - (367 + 201);
local v75 = 12038 - (214 + 713);
local v76;
local v77 = v22.GhoulTable;
local v78;
local v79;
local v80 = 0 + 0;
local function v81()
	local v115, v116 = v6:GetTrinketData(v25);
	if ((v80 < (1 + 4)) and ((v115.ID == (877 - (282 + 595))) or (v116.ID == (1637 - (1523 + 114))) or ((v115.SpellID > (0 + 0)) and not v115.Usable) or ((v116.SpellID > (0 - 0)) and not v116.Usable))) then
		v80 = v80 + (1066 - (68 + 997));
		v19(1275 - (226 + 1044), function()
			v81();
		end);
		return;
	end
	v30 = v115.Object;
	v31 = v116.Object;
	v34 = v115.Spell;
	v36 = v115.Range;
	v32 = v115.CastTime;
	v35 = v116.Spell;
	v37 = v116.Range;
	v33 = v116.CastTime;
	v38 = v115.Cooldown;
	v39 = v116.Cooldown;
	v50 = v115.Blacklisted;
	v51 = v116.Blacklisted;
	v40 = 0.5 - 0;
	if (v30:HasUseBuff() and ((v23.PillarofFrost:IsAvailable() and not v23.BreathofSindragosa:IsAvailable() and ((v38 % v29) == (117 - (32 + 85)))) or (v23.BreathofSindragosa:IsAvailable() and (((118 + 2) % v38) == (0 + 0))))) then
		v40 = 958 - (892 + 65);
	end
	v41 = 0.5 - 0;
	if (v31:HasUseBuff() and ((v23.PillarofFrost:IsAvailable() and not v23.BreathofSindragosa:IsAvailable() and ((v39 % v29) == (0 - 0))) or (v23.BreathofSindragosa:IsAvailable() and (((220 - 100) % v39) == (350 - (87 + 263)))))) then
		v41 = 181 - (67 + 113);
	end
	v42 = v30:HasCooldown() and v30:HasUseBuff();
	v43 = v31:HasCooldown() and v31:HasUseBuff();
	v44 = ((v115.ID == v24.TreacherousTransmitter:ID()) and (11 + 4)) or ((v30:BuffDuration() > (0 - 0)) and v30:BuffDuration()) or (1 + 0);
	v45 = ((v116.ID == v24.TreacherousTransmitter:ID()) and (59 - 44)) or ((v31:BuffDuration() > (952 - (802 + 150))) and v31:BuffDuration()) or (2 - 1);
	v46 = 1 - 0;
	local v129 = ((v115.ID ~= (0 + 0)) and v30:Level()) or (997 - (915 + 82));
	local v130 = ((v116.ID ~= (0 - 0)) and v31:Level()) or (0 + 0);
	if ((not v42 and v43 and (v31:HasCooldown() or not v30:HasCooldown())) or (v43 and (((v39 / v45) * v41 * ((1 - 0) + ((v130 - v129) / (1287 - (1069 + 118))))) > ((v38 / v44) * v40 * ((2 - 1) + ((v129 - v130) / (218 - 118))))))) then
		v46 = 1 + 1;
	end
	v47 = 1 - 0;
	if (not v42 and not v43 and (v130 >= v129)) then
		v47 = 2 + 0;
	end
	v48 = v115.ID == v24.TreacherousTransmitter:ID();
	v49 = v116.ID == v24.TreacherousTransmitter:ID();
end
v81();
local function v82()
	if (v27.General.AutoTab and v6:AffectingCombat()) then
		v12.TopPanelAlternative:ChangeIcon(792 - (368 + 423), 9 - 6);
		return "Auto tab to target";
	end
end
local function v83(v131)
	return (v131 ~= "Not Used") and (((v131 == "With Cooldowns") and v12.CDsON()) or ((v131 == "With Small or Cooldowns") and (SmallCDToggle or v12.CDsON())) or ((v131 == "With Small CDs") and SmallCDToggle) or ((v131 == "On Mobcount") and (v73 >= v28.Frost.Mobcount)) or ((v131 == "On Mobcount or Cooldowns") and ((v73 >= v28.Frost.Mobcount) or v14())) or (v131 == "Always") or ((v131 == "On Bosses") and (v78 or v7:IsDummy())) or ((v131 == "Mobcount or Boss") and (v78 or v7:IsDummy() or (v73 >= v28.Frost.Mobcount))));
end
local function v84()
	v52 = v20("player", 34 - (10 + 8)) or "";
	v53 = v20("player", 65 - 48) or "";
	v54 = select(445 - (416 + 26), v18(":", v52));
	v55 = select(9 - 6, v18(":", v53));
	v56 = (v54 == "3370") or (v55 == "3370");
	v57 = (v54 == "3368") or (v55 == "3368");
	v58 = v21("Two-Hand");
end
v84();
local function v85()
	VarBreathRPCost = 8 + 9;
	VarStaticRimeBuffs = v23.RageoftheFrozenChampion:IsAvailable() or v23.Icebreaker:IsAvailable();
	VarBreathRPThreshold = 106 - 46;
	VarERWBreathRPTrigger = 508 - (145 + 293);
	VarERWBreathRuneTrigger = 433 - (44 + 386);
	VarOblitRunePooling = 1490 - (998 + 488);
	VarBreathRimeRPThreshold = 20 + 40;
end
v85();
local function v86(v132, v133, v134)
	if (v78 or v26.ISSolo() or (v134 == (0 + 0)) or ((v75 >= v134) and (v75 < (8549 - (201 + 571))))) then
		v12.Cast(v132, v133);
		return "TTD cast " .. v132:Name();
	end
end
local function v87(v135)
	return v78 or v26.ISSolo() or (v135 == (1138 - (116 + 1022))) or v26.Buggedmobs[v7:NPCID()] or ((v75 >= v135) and (v75 < (32377 - 24600)));
end
function IsNpcNearPlayer()
	local v136 = v6:GetEnemiesInRange(24 + 16);
	for v148, v149 in pairs(v136) do
		if ((v149:NPCID() == (147330 - 106973)) or (v149:CastSpellID() == (1590933 - 1142920))) then
			print("npc found: do not use abo limb");
			return true;
		end
	end
	return false;
end
v3:RegisterForEvent(function()
	v74 = 11970 - (814 + 45);
	v75 = 27376 - 16265;
end, "PLAYER_REGEN_ENABLED");
v3:RegisterForEvent(function()
	v59 = v23.GatheringStorm:IsAvailable() or v23.BitingCold:IsAvailable();
	v80 = 0 + 0;
	v81();
	v84();
	v85();
end, "PLAYER_EQUIPMENT_CHANGED", "SPELLS_CHANGED", "LEARNED_SPELL_IN_TAB");
local function v88()
	return v24.ManicGrieftorch:IsEquipped() and (v24.ManicGrieftorch:CooldownUp() or (v24.ManicGrieftorch:CooldownRemains() <= v6:GCDRemains()));
end
local function v89()
	return v24.TreacherousTransmitter:IsEquipped() and (v24.TreacherousTransmitter:CooldownUp() or (v24.TreacherousTransmitter:CooldownRemains() <= v6:GCDRemains()));
end
local function v90()
	return v6:BuffDown(v23.BreathofSindragosa) and ((v6:HealthPercentage() <= v28.Frost.Defensives.UseDeathStrikeHP) or ((v6:HealthPercentage() < v28.Frost.Defensives.UseDarkSuccorHP) and v6:BuffUp(v23.DeathStrikeBuff)));
end
local function v91(v137)
	return (v16(v23.ShatteringBlade:IsAvailable() and (v137:DebuffStack(v23.RazoriceDebuff) == (2 + 3))) * (890 - (261 + 624))) + (((v137:DebuffStack(v23.RazoriceDebuff) + (1 - 0)) / (v137:DebuffRemains(v23.RazoriceDebuff) + (1081 - (1020 + 60)))) * v16(v56));
end
local function v92(v138)
	return (((v138:DebuffStack(v23.RazoriceDebuff) + (1424 - (630 + 793))) / (v138:DebuffRemains(v23.RazoriceDebuff) + (3 - 2))) * v16(v56)) + (v16((v6:HeroTreeID() == (156 - 123)) and v7:DebuffDown(v23.ReapersMarkDebuff)) * (2 + 3));
end
local function v93(v139)
	return v139:DebuffStack(v23.RazoriceDebuff);
end
local function v94(v140)
	return ((v140:DebuffStack(v23.RazoriceDebuff) + (3 - 2)) / (v140:DebuffRemains(v23.RazoriceDebuff) + (1748 - (760 + 987)))) * v16(v56);
end
local function v95(v141)
	return v141:DebuffStack(v23.RazoriceDebuff) == (1918 - (1789 + 124));
end
local function v96(v142)
	return v142:DebuffStack(v23.RazoriceDebuff);
end
local function v97(v143)
	return (v6:Rune() < (768 - (745 + 21))) or v64 or ((v143:DebuffStack(v23.RazoriceDebuff) == (2 + 3)) and v23.ShatteringBlade:IsAvailable());
end
local function v98(v144)
	return v70 or (v144:DebuffStack(v23.RazoriceDebuff) < (13 - 8));
end
local function v99(v145)
	return (v70 or (v145:DebuffStack(v23.RazoriceDebuff) < (19 - 14))) and ((not v56 and ((v145:DebuffStack(v23.RazoriceDebuff) < (1 + 4)) or (v145:DebuffRemains(v23.RazoriceDebuff) < (v6:GCD() * (3 + 0))))) or ((v64 or (v6:Rune() < (1057 - (87 + 968)))) and (v73 > (4 - 3))));
end
local function v100(v146)
	return (((v146:TimeToX(32 + 3) < (11 - 6)) or (v146:HealthPercentage() <= (1448 - (447 + 966)))) and (v146:TimeToX(0 - 0) > (1822 - (1703 + 114)))) or ((v146:HealthPercentage() <= (736 - (376 + 325))) and v78);
end
local function v101(v147)
	return v147:DebuffDown(v23.ReapersMarkDebuff);
end
local function v102()
	if (v23.HowlingBlast:IsReady() and not v7:IsInRange(12 - 4)) then
		if v13(v23.HowlingBlast) then
			return "howling_blast precombat 2";
		end
	end
	if (v23.RemorselessWinter:IsReady() and v87(24 - 16) and v7:IsInRange(3 + 5)) then
		if v13(v23.RemorselessWinter) then
			return "remorseless_winter precombat 4";
		end
	end
end
local function v103()
	if (v23.Obliterate:IsReady() and v7:IsInMeleeRange(10 - 5) and v6:BuffUp(v23.KillingMachineBuff) and v23.CleavingStrikes:IsAvailable() and v6:BuffUp(v23.DeathAndDecayBuff)) then
		if v26.CastTargetIf(v23.Obliterate, v72, "max", v92, nil, 19 - (9 + 5)) then
			return "obliterate aoe 2";
		end
	end
	if (v23.HowlingBlast:IsReady() and v7:IsSpellInRange(v23.HowlingBlast) and (v23.FrostFeverDebuff:AuraActiveCount() < v73)) then
		if v13(v23.HowlingBlast) then
			return "howling_blast aoe 4";
		end
	end
	if (v23.FrostStrike:IsReady() and v7:IsInMeleeRange(381 - (85 + 291)) and not v69 and v23.ShatteringBlade:IsAvailable() and (v23.ShatteredFrost:IsAvailable() or (v73 < (1269 - (243 + 1022))))) then
		if v26.CastTargetIf(v23.FrostStrike, v72, "max", v91, v95, 19 - 14) then
			return "frost_strike aoe 6";
		end
	end
	if (v23.HowlingBlast:IsReady() and v7:IsSpellInRange(v23.HowlingBlast) and (v6:BuffUp(v23.RimeBuff))) then
		if v13(v23.HowlingBlast) then
			return "howling_blast aoe 8";
		end
	end
	if (v23.GlacialAdvance:IsReady() and v7:IsInRange(7 + 1) and v98 and not v69) then
		if v13(v23.GlacialAdvance) then
			return "glacial_advance aoe 10";
		end
	end
	if (v23.Obliterate:IsReady() and v7:IsInMeleeRange(1185 - (1123 + 57))) then
		if v13(v23.Obliterate) then
			return "obliterate aoe 12";
		end
	end
	if (v23.FrostStrike:IsReady() and v7:IsInMeleeRange(5 + 0) and not v69) then
		if v26.CastTargetIf(v23.FrostStrike, v72, "max", v91, nil, 259 - (163 + 91)) then
			return "frost_strike aoe 14";
		end
	end
	if (v23.HornofWinter:IsCastable() and (v6:Rune() < (1932 - (1869 + 61))) and (v6:RunicPowerDeficit() > (7 + 18)) and (not v23.BreathofSindragosa:IsAvailable() or (VarTrueBreathCD > (105 - 75)))) then
		if v13(v23.HornofWinter, true) then
			return "horn_of_winter aoe 16";
		end
	end
	if (v23.ArcaneTorrent:IsReady() and RacialsSetting and v7:IsInRange(12 - 4) and (v6:RunicPowerDeficit() > (4 + 21))) then
		if v13(v23.ArcaneTorrent) then
			return "arcane_torrent aoe 18";
		end
	end
end
local function v104()
	if (v23.Obliterate:IsReady() and (v6:BuffStack(v23.KillingMachineBuff) == (2 - 0))) then
		if v26.CastTargetIf(v23.Obliterate, v72, "max", v92, nil, 5 + 0) then
			return "obliterate breath 1";
		end
	end
	if (v23.HowlingBlast:IsReady() and v7:IsSpellInRange(v23.HowlingBlast) and ((v63 and (v6:RunicPower() > (VarBreathRimeRPThreshold - (v16(v23.RageoftheFrozenChampion:IsAvailable()) * (1480 - (1329 + 145)))))) or v7:DebuffDown(v23.FrostFeverDebuff))) then
		if v13(v23.HowlingBlast) then
			return "howling_blast breath 2";
		end
	end
	if (v23.HornofWinter:IsReady() and (v6:Rune() < (973 - (140 + 831))) and (v6:RunicPowerDeficit() > (1880 - (1409 + 441)))) then
		if v13(v23.HornofWinter, true) then
			return "horn_of_winter breath 4";
		end
	end
	if (v23.Obliterate:IsReady() and v7:IsInMeleeRange(723 - (15 + 703)) and (v6:BuffUp(v23.KillingMachineBuff) or (v6:RunicPowerDeficit() > (10 + 10)))) then
		if v26.CastTargetIf(v23.Obliterate, v72, "max", v92, nil, 443 - (262 + 176)) then
			return "obliterate breath 6";
		end
	end
	if (v23.RemorselessWinter:IsReady() and v87(1729 - (345 + 1376)) and v71) then
		if v13(v23.RemorselessWinter, nil, nil, not v7:IsInMeleeRange(696 - (198 + 490))) then
			return "remorseless_winter breath 8";
		end
	end
	if (v23.DeathAndDecay:IsReady() and DnDSetting and (v28.Commons.DnDMoving or not v6:IsMoving()) and v6:BuffDown(v23.DeathAndDecayBuff) and ((v60 and v23.UnholyGround:IsAvailable() and (v6:RunicPowerDeficit() >= (44 - 34)) and not v23.Obliteration:IsAvailable()) or v71)) then
		if v12.CastTarget(v23.DeathAndDecay, v12.TName().PLAYER) then
			return "death_and_decay breath 10";
		end
	end
	if (v23.HowlingBlast:IsReady() and v7:IsSpellInRange(v23.HowlingBlast) and v71) then
		if v13(v23.HowlingBlast) then
			return "howling_blast breath 12";
		end
	end
	if (v23.ArcaneTorrent:IsReady() and RacialsSetting and v7:IsInRange(18 - 10) and (v6:RunicPower() < (1266 - (696 + 510)))) then
		if v13(v23.ArcaneTorrent) then
			return "arcane_torrent breath 14";
		end
	end
	if (v23.HowlingBlast:IsReady() and v7:IsSpellInRange(v23.HowlingBlast) and (v6:BuffUp(v23.RimeBuff))) then
		if v13(v23.HowlingBlast) then
			return "howling_blast breath 16";
		end
	end
end
local function v105()
	if (v23.ChainsofIce:IsReady() and v7:IsSpellInRange(v23.ChainsofIce) and (v75 < v6:GCD()) and ((v6:Rune() < (3 - 1)) or (v6:BuffDown(v23.KillingMachineBuff) and ((not v58 and (v6:BuffStack(v23.ColdHeartBuff) >= (1266 - (1091 + 171)))) or (v58 and (v6:BuffStack(v23.ColdHeartBuff) > (2 + 6))))) or (v6:BuffUp(v23.KillingMachineBuff) and ((not v58 and (v6:BuffStack(v23.ColdHeartBuff) > (25 - 17))) or (v58 and (v6:BuffStack(v23.ColdHeartBuff) > (33 - 23))))))) then
		if v13(v23.ChainsofIce) then
			return "chains_of_ice cold_heart 2";
		end
	end
	if (v23.ChainsofIce:IsReady() and v7:IsSpellInRange(v23.ChainsofIce) and not v23.Obliteration:IsAvailable() and v6:BuffUp(v23.PillarofFrostBuff) and (v6:BuffStack(v23.ColdHeartBuff) >= (384 - (123 + 251))) and ((v6:BuffRemains(v23.PillarofFrostBuff) < (v6:GCD() * ((4 - 3) + v16(v23.FrostwyrmsFury:IsAvailable() and v23.FrostwyrmsFury:IsReady())))) or (v6:BuffUp(v23.UnholyStrengthBuff) and (v6:BuffRemains(v23.UnholyStrengthBuff) < v6:GCD())))) then
		if v13(v23.ChainsofIce) then
			return "chains_of_ice cold_heart 4";
		end
	end
	if (v23.ChainsofIce:IsReady() and v7:IsSpellInRange(v23.ChainsofIce) and not v23.Obliteration:IsAvailable() and v57 and v6:BuffDown(v23.PillarofFrostBuff) and (v23.PillarofFrost:CooldownRemains() > (713 - (208 + 490))) and (((v6:BuffStack(v23.ColdHeartBuff) >= (1 + 9)) and v6:BuffUp(v23.UnholyStrengthBuff)) or (v6:BuffStack(v23.ColdHeartBuff) >= (6 + 7)))) then
		if v13(v23.ChainsofIce) then
			return "chains_of_ice cold_heart 6";
		end
	end
	if (v23.ChainsofIce:IsReady() and v7:IsSpellInRange(v23.ChainsofIce) and not v23.Obliteration:IsAvailable() and not v57 and (v6:BuffStack(v23.ColdHeartBuff) >= (846 - (660 + 176))) and v6:BuffDown(v23.PillarofFrostBuff) and (v23.PillarofFrost:CooldownRemains() > (3 + 17))) then
		if v13(v23.ChainsofIce) then
			return "chains_of_ice cold_heart 8";
		end
	end
	if (v23.ChainsofIce:IsReady() and v7:IsSpellInRange(v23.ChainsofIce) and v23.Obliteration:IsAvailable() and v6:BuffDown(v23.PillarofFrostBuff) and (((v6:BuffStack(v23.ColdHeartBuff) >= (216 - (14 + 188))) and v6:BuffUp(v23.UnholyStrengthBuff)) or (v6:BuffStack(v23.ColdHeartBuff) >= (694 - (534 + 141))) or ((v23.PillarofFrost:CooldownRemains() < (2 + 1)) and (v6:BuffStack(v23.ColdHeartBuff) >= (13 + 1))))) then
		if v13(v23.ChainsofIce) then
			return "chains_of_ice cold_heart 10";
		end
	end
end
local function v106()
	if (v28.Commons.Enabled.Potions and PotionSetting and ((v23.PillarofFrost:IsAvailable() and v6:BuffUp(v23.PillarofFrostBuff)) or (not v23.PillarofFrost:IsAvailable() and v6:BuffUp(v23.EmpowerRuneWeaponBuff)) or (not v23.PillarofFrost:IsAvailable() and not v23.EmpowerRuneWeapon:IsAvailable()) or ((v73 >= (2 + 0)) and v6:BuffUp(v23.PillarofFrostBuff)) or (v74 < (52 - 27)))) then
		local v150 = v26.PotionSelected();
		if (v150 and v150:IsReady()) then
			v12.CastMacro(4 - 1, nil, nil, v150);
			return "Cast Potion";
		end
	end
	if (v23.AbominationLimb:IsCastable() and v7:IsInRange(56 - 36) and AbominationLimbSetting and ((v23.Obliteration:IsAvailable() and v6:BuffDown(v23.PillarofFrostBuff) and v62) or (v74 < (9 + 6)) or (not v23.Obliteration:IsAvailable() and v62))) then
		if v13(v23.AbominationLimb) then
			return "abomination_limb_talent cooldowns 4";
		end
	end
	if (v23.RemorselessWinter:IsReady() and v87(6 + 2) and v7:IsInMeleeRange(404 - (115 + 281)) and v59 and v62 and (not v23.ArcticAssault:IsAvailable() or v6:BuffDown(v23.PillarofFrostBuff)) and (v75 > (23 - 13))) then
		if v13(v23.RemorselessWinter) then
			return "remorseless_winter cooldowns 6";
		end
	end
	if (v23.ChillStreak:IsReady() and v7:IsSpellInRange(v23.ChillStreak) and v62 and (not v23.ArcticAssault:IsAvailable() or v6:BuffDown(v23.PillarofFrostBuff))) then
		if v13(v23.ChillStreak) then
			return "chill_streak cooldowns 8";
		end
	end
	if (v23.ReapersMark:IsReady() and ReapersMarkSetting and v7:IsInMeleeRange(5 + 0) and v101(v7) and v87(28 - 16)) then
		if v13(v23.ReapersMark) then
			return "reapers_mark cooldowns 10";
		end
	end
	if (v23.EmpowerRuneWeapon:IsCastable() and v7:IsInRange(55 - 40) and EmpowerRuneWeaponSetting and ((v23.Obliteration:IsAvailable() and not v23.BreathofSindragosa:IsAvailable() and v6:BuffUp(v23.PillarofFrostBuff)) or (v74 < (887 - (550 + 317))))) then
		if v13(v23.EmpowerRuneWeapon) then
			return "empower_rune_weapon cooldowns 12";
		end
	end
	if (v23.EmpowerRuneWeapon:IsCastable() and EmpowerRuneWeaponSetting and v6:BuffUp(v23.BreathofSindragosa) and (v6:RunicPower() < VarERWBreathRPTrigger) and (v6:Rune() < VarERWBreathRuneTrigger)) then
		if v13(v23.EmpowerRuneWeapon) then
			return "empower_rune_weapon cooldowns 14";
		end
	end
	if (v23.EmpowerRuneWeapon:IsCastable() and v7:IsInRange(21 - 6) and EmpowerRuneWeaponSetting and not v23.BreathofSindragosa:IsAvailable() and not v23.Obliteration:IsAvailable() and v6:BuffDown(v23.EmpowerRuneWeaponBuff) and (v6:Rune() < (7 - 2)) and ((v23.PillarofFrost:CooldownRemains() < (19 - 12)) or v6:BuffUp(v23.PillarofFrostBuff) or not v23.PillarofFrost:IsAvailable())) then
		if v13(v23.EmpowerRuneWeapon) then
			return "empower_rune_weapon cooldowns 16";
		end
	end
	if (v23.PillarofFrost:IsCastable() and v7:IsInMeleeRange(290 - (134 + 151)) and PillarofFrostSetting and ((v23.Obliteration:IsAvailable() and not v23.BreathofSindragosa:IsAvailable() and v62) or (v74 < (1685 - (970 + 695))))) then
		if v13(v23.PillarofFrost) then
			return "pillar_of_frost cooldowns 18";
		end
	end
	if (v23.PillarofFrost:IsCastable() and v7:IsInMeleeRange(9 - 4) and PillarofFrostSetting and v23.BreathofSindragosa:IsAvailable() and v62 and ((v23.BreathofSindragosa:CooldownRemains() > (2020 - (582 + 1408))) or not BreathOfSindragosaSetting) and v6:BuffUp(v23.UnleashedFrenzyBuff)) then
		if v13(v23.PillarofFrost) then
			return "pillar_of_frost cooldowns 20";
		end
	end
	if (v23.PillarofFrost:IsCastable() and v7:IsInMeleeRange(17 - 12) and PillarofFrostSetting and not v23.Obliteration:IsAvailable() and not v23.BreathofSindragosa:IsAvailable() and v62) then
		if v13(v23.PillarofFrost) then
			return "pillar_of_frost cooldowns 22";
		end
	end
	if (v23.BreathofSindragosa:IsReady() and v7:IsInRange(14 - 2) and BreathOfSindragosaSetting and ((v6:BuffDown(v23.BreathofSindragosa) and (v6:RunicPower() > VarBreathRPThreshold) and ((v6:Rune() < (7 - 5)) or (v6:RunicPower() > (1904 - (1195 + 629)))) and ((v23.PillarofFrost:CooldownUp() and v62) or (v74 < (39 - 9)))) or ((v3.CombatTime() < (251 - (187 + 54))) and (v6:Rune() < (781 - (162 + 618)))))) then
		if v13(v23.BreathofSindragosa) then
			return "breath_of_sindragosa cooldowns 24";
		end
	end
	if (v23.FrostwyrmsFury:IsCastable() and FrostwyrmsFurySetting and v7:IsInRange(6 + 2) and (((v6:HeroTreeID() == (22 + 10)) and v23.ApocalypseNow:IsAvailable() and v62 and ((not v23.BreathofSindragosa:IsAvailable() and v6:BuffUp(v23.PillarofFrostBuff)) or v6:BuffUp(v23.BreathofSindragosa))) or (v74 < (63 - 33)))) then
		if v13(v23.FrostwyrmsFury, true) then
			return "frostwyrms_fury cooldowns 26";
		end
	end
	if (v23.FrostwyrmsFury:IsCastable() and FrostwyrmsFurySetting and v7:IsInRange(13 - 5) and ((not v23.ApocalypseNow:IsAvailable() and (v73 <= (1 + 0)) and ((v23.PillarofFrost:IsAvailable() and v6:BuffUp(v23.PillarofFrostBuff) and not v23.Obliteration:IsAvailable()) or not v23.PillarofFrost:IsAvailable())) or (v74 < (1639 - (1373 + 263))))) then
		if v13(v23.FrostwyrmsFury, true) then
			return "frostwyrms_fury cooldowns 28";
		end
	end
	if (v23.FrostwyrmsFury:IsCastable() and FrostwyrmsFurySetting and v7:IsInRange(1008 - (451 + 549)) and not v23.ApocalypseNow:IsAvailable() and (v73 >= (1 + 1)) and v23.PillarofFrost:IsAvailable() and v6:BuffUp(v23.PillarofFrostBuff)) then
		if v13(v23.FrostwyrmsFury, true) then
			return "frostwyrms_fury cooldowns 30";
		end
	end
	if (v23.FrostwyrmsFury:IsCastable() and FrostwyrmsFurySetting and v7:IsInRange(11 - 3) and not v23.ApocalypseNow:IsAvailable() and v23.Obliteration:IsAvailable() and ((v23.PillarofFrost:IsAvailable() and v6:BuffUp(v23.PillarofFrostBuff) and not v58) or (v6:BuffDown(v23.PillarofFrostBuff) and v58 and v23.PillarofFrost:CooldownDown()) or not v23.PillarofFrost:IsAvailable()) and ((v6:BuffRemains(v23.PillarofFrostBuff) < v6:GCD()) or (v6:BuffUp(v23.UnholyStrengthBuff) and (v6:BuffRemains(v23.UnholyStrengthBuff) < v6:GCD())) or ((v23.Bonegrinder:TalentRank() == (2 - 0)) and v6:BuffUp(v23.BonegrinderFrostBuff) and (v6:BuffRemains(v23.BonegrinderFrostBuff) < v6:GCD()))) and ((v7:DebuffStack(v23.RazoriceDebuff) == (1389 - (746 + 638))) or (not v56 and not v23.GlacialAdvance:IsAvailable()) or v23.ShatteringBlade:IsAvailable())) then
		if v13(v23.FrostwyrmsFury, true) then
			return "frostwyrms_fury cooldowns 32";
		end
	end
	if (v23.RaiseDead:IsCastable() and RaiseDeadSetting) then
		if v13(v23.RaiseDead, true) then
			return "raise_dead cooldowns 34";
		end
	end
	if (v23.SoulReaper:IsReady() and v7:IsInMeleeRange(2 + 3) and (v75 > (7 - 2)) and (v73 <= (342 - (218 + 123))) and ((v23.Obliteration:IsAvailable() and ((v6:BuffUp(v23.PillarofFrostBuff) and v6:BuffDown(v23.KillingMachineBuff) and (v6:Rune() > (1583 - (1535 + 46)))) or v6:BuffDown(v23.PillarofFrostBuff) or ((v6:BuffStack(v23.KillingMachineBuff) < (2 + 0)) and v6:BuffDown(v23.ExterminateBuff) and v6:BuffDown(v23.PainfulDeathBuff) and (v6:BuffRemains(v23.PillarofFrostBuff) < v6:GCD())))) or (v23.BreathofSindragosa:IsAvailable() and ((v6:BuffUp(v23.BreathofSindragosa) and (v6:RunicPower() > (8 + 42))) or v6:BuffDown(v23.BreathofSindragosa))) or (not v23.BreathofSindragosa:IsAvailable() and not v23.Obliteration:IsAvailable()))) then
		if v26.CastCycle(v23.SoulReaper, v72, v100, 565 - (306 + 254), false, false) then
			return "SoulReaper cooldowns 36";
		end
	end
	if (v23.Frostscythe:IsReady() and v7:IsInMeleeRange(1 + 7) and v6:BuffDown(v23.KillingMachineBuff) and v6:BuffDown(v23.PillarofFrostBuff)) then
		if v13(v23.Frostscythe) then
			return "frostscythe cooldowns 38";
		end
	end
	if (v23.DeathAndDecay:IsReady() and DnDSetting and (v28.Commons.DnDMoving or not v6:IsMoving()) and ((v73 > (0 - 0)) or v7:IsInRange(1475 - (899 + 568))) and v6:BuffDown(v23.DeathAndDecayBuff) and v6:BuffDown(v23.MograinesMightBuff) and v61 and ((v6:BuffUp(v23.PillarofFrostBuff) and v6:BuffUp(v23.KillingMachineBuff) and (v23.EnduringStrength:IsAvailable() or (v6:BuffRemains(v23.PillarofFrostBuff) > (4 + 1)))) or (v6:BuffDown(v23.PillarofFrostBuff) and ((v23.DeathAndDecay:Charges() == (4 - 2)) or (v23.PillarofFrost:CooldownRemains() > v23.DeathAndDecay:Cooldown()) or (not v23.TheLongWinter:IsAvailable() and (v23.PillarofFrost:CooldownRemains() < (v6:GCD() * (605 - (268 + 335))))))) or (v74 < (305 - (60 + 230)))) and ((v73 > (577 - (426 + 146))) or (v23.CleavingStrikes:IsAvailable() and (v73 >= (1 + 1))))) then
		if v12.CastTarget(v23.DeathAndDecay, v12.TName().PLAYER) then
			return "death_and_decay cooldowns 40";
		end
	end
end
local function v107()
	if InterruptToggle then
		v79 = v26.InterruptCycle(v23.MindFreeze, 1471 - (282 + 1174), true, nil, false);
		if v79 then
			return v79;
		end
		if v28.Commons.BlindingSleet then
			v79 = v26.InterruptCycle(v23.BlindingSleet, 823 - (569 + 242), true, nil, true, true);
			if v79 then
				return v79;
			end
		end
		v79 = v26.InterruptCycle(v23.Asphyxiate, 57 - 37, true, nil, true);
		if v79 then
			return v79;
		end
	end
	if (v23.HowlingBlast:IsReady() and v7:IsSpellInRange(v23.HowlingBlast) and v7:DebuffDown(v23.FrostFeverDebuff) and (v73 >= (1 + 1)) and (not v23.Obliteration:IsAvailable() or (v23.Obliteration:IsAvailable() and (v23.PillarofFrost:CooldownDown() or (v6:BuffUp(v23.PillarofFrostBuff) and v6:BuffDown(v23.KillingMachineBuff)))))) then
		if v13(v23.HowlingBlast) then
			return "howling_blast high_prio_actions 6";
		end
	end
	if (v23.GlacialAdvance:IsReady() and v7:IsInRange(1032 - (706 + 318)) and v70 and v64 and v23.Obliteration:IsAvailable() and v23.BreathofSindragosa:IsAvailable() and v6:BuffDown(v23.PillarofFrostBuff) and v6:BuffDown(v23.BreathofSindragosa) and (v23.BreathofSindragosa:CooldownRemains() > v67)) then
		if v13(v23.GlacialAdvance) then
			return "glacial_advance high_prio_actions 8";
		end
	end
	if (v23.GlacialAdvance:IsReady() and v7:IsInRange(1259 - (721 + 530)) and v70 and v64 and v23.BreathofSindragosa:IsAvailable() and v6:BuffDown(v23.BreathofSindragosa) and (v23.BreathofSindragosa:CooldownRemains() > v67)) then
		if v13(v23.GlacialAdvance) then
			return "glacial_advance high_prio_actions 10";
		end
	end
	if (v23.GlacialAdvance:IsReady() and v7:IsInRange(1279 - (945 + 326)) and v70 and v64 and not v23.BreathofSindragosa:IsAvailable() and v23.Obliteration:IsAvailable() and v6:BuffDown(v23.PillarofFrostBuff) and not v23.ShatteredFrost:IsAvailable()) then
		if v13(v23.GlacialAdvance) then
			return "glacial_advance high_prio_actions 12";
		end
	end
	if (v23.FrostStrike:IsReady() and v7:IsSpellInRange(v23.FrostStrike) and (v73 <= (2 - 1)) and v64 and v23.Obliteration:IsAvailable() and v23.BreathofSindragosa:IsAvailable() and v6:BuffDown(v23.PillarofFrostBuff) and v6:BuffDown(v23.BreathofSindragosa) and (v23.BreathofSindragosa:CooldownRemains() > v67)) then
		if v26.CastTargetIf(v23.FrostStrike, v72, "max", v91, nil, 5 + 0) then
			return "frost_strike high_prio_actions 14" .. tostring(v6:BuffUp(v23.BreathofSindragosa));
		end
	end
	if (v23.FrostStrike:IsReady() and v7:IsSpellInRange(v23.FrostStrike) and (v73 <= (701 - (271 + 429))) and v64 and v23.BreathofSindragosa:IsAvailable() and v6:BuffDown(v23.BreathofSindragosa) and (v23.BreathofSindragosa:CooldownRemains() > v67)) then
		if v26.CastTargetIf(v23.FrostStrike, v72, "max", v91, nil, 5 + 0) then
			return "frost_strike high_prio_actions 16 " .. tostring(v6:BuffUp(v23.BreathofSindragosa));
		end
	end
	if (v23.FrostStrike:IsReady() and v7:IsSpellInRange(v23.FrostStrike) and (v73 <= (1501 - (1408 + 92))) and v64 and not v23.BreathofSindragosa:IsAvailable() and v23.Obliteration:IsAvailable() and v6:BuffDown(v23.PillarofFrostBuff)) then
		if v26.CastTargetIf(v23.FrostStrike, v72, "max", v91, nil, 1091 - (461 + 625)) then
			return "frost_strike high_prio_actions 18" .. tostring(v6:BuffUp(v23.BreathofSindragosa));
		end
	end
end
local function v108()
	if (v23.Obliterate:IsReady() and v7:IsInMeleeRange(1293 - (993 + 295)) and v7:IsSpellInRange(v23.HowlingBlast) and v6:BuffUp(v23.KillingMachineBuff) and (v6:BuffUp(v23.ExterminateBuff) or v6:BuffUp(v23.PainfulDeathBuff) or (v74 < (v6:GCD() * (1 + 1))))) then
		if v26.CastTargetIf(v23.Obliterate, v72, "max", v92, nil, 1176 - (418 + 753)) then
			return "obliterate obliteration 1";
		end
	end
	if (v23.HowlingBlast:IsReady() and v7:IsSpellInRange(v23.HowlingBlast) and (v6:BuffStack(v23.KillingMachineBuff) < (1 + 1)) and (v6:BuffRemains(v23.PillarofFrostBuff) < v6:GCD()) and v63) then
		if v13(v23.HowlingBlast) then
			return "howling_blast obliteration 2";
		end
	end
	if (v23.GlacialAdvance:IsReady() and v7:IsInRange(1 + 7) and (v6:BuffStack(v23.KillingMachineBuff) < (1 + 1)) and (v6:BuffRemains(v23.PillarofFrostBuff) < v6:GCD()) and v6:BuffDown(v23.DeathAndDecayBuff) and v70) then
		if v13(v23.GlacialAdvance) then
			return "glacial_advance obliteration 4";
		end
	end
	if (v23.FrostStrike:IsReady() and v7:IsSpellInRange(v23.FrostStrike) and (v6:BuffStack(v23.KillingMachineBuff) < (1 + 1)) and (v6:BuffRemains(v23.PillarofFrostBuff) < v6:GCD()) and v6:BuffDown(v23.DeathAndDecayBuff)) then
		if v26.CastTargetIf(v23.FrostStrike, v72, "max", v91, nil, 534 - (406 + 123)) then
			return "frost_strike obliteration 6";
		end
	end
	if (v23.FrostStrike:IsReady() and v7:IsInMeleeRange(1774 - (1749 + 20)) and v23.ShatteringBlade:IsAvailable() and v23.AFeastofSouls:IsAvailable() and v6:BuffUp(v23.AFeastofSoulsBuff)) then
		if v26.CastTargetIf(v23.FrostStrike, v72, "max", v91, v96, 2 + 3) then
			return "frost_strike obliteration 8";
		end
	end
	if (v23.Obliterate:IsReady() and v7:IsInMeleeRange(1327 - (1249 + 73)) and (v6:BuffUp(v23.KillingMachineBuff))) then
		if v13(v23.Obliterate) then
			return "obliterate obliteration 10";
		end
	end
	if (v23.HowlingBlast:IsReady() and v7:IsSpellInRange(v23.HowlingBlast) and v6:BuffDown(v23.KillingMachineBuff) and (v23.FrostFeverDebuff:AuraActiveCount() < v73)) then
		if v13(v23.HowlingBlast) then
			return "howling_blast obliteration 12";
		end
	end
	if (v23.GlacialAdvance:IsReady() and v99 and v7:IsInRange(3 + 5)) then
		if v13(v23.GlacialAdvance) then
			return "glacial_advance obliteration 14";
		end
	end
	if (v23.FrostStrike:IsReady() and v7:IsSpellInRange(v23.FrostStrike) and v97 and not v69 and (not v23.GlacialAdvance:IsAvailable() or (v73 <= (1146 - (466 + 679))) or v23.ShatteredFrost:IsAvailable())) then
		if v26.CastTargetIf(v23.FrostStrike, v72, "max", v91, v97, 11 - 6) then
			return "frost_strike obliteration 16";
		end
	end
	if (v23.HowlingBlast:IsReady() and v7:IsSpellInRange(v23.HowlingBlast) and (v6:BuffUp(v23.RimeBuff))) then
		if v13(v23.HowlingBlast) then
			return "howling_blast obliteration 18";
		end
	end
	if (v23.FrostStrike:IsReady() and v7:IsSpellInRange(v23.FrostStrike) and not v69 and (not v23.GlacialAdvance:IsAvailable() or (v73 <= (2 - 1)) or v23.ShatteredFrost:IsAvailable())) then
		if v26.CastTargetIf(v23.FrostStrike, v72, "max", v91, nil, 1905 - (106 + 1794)) then
			return "frost_strike obliteration 20";
		end
	end
	if (v23.GlacialAdvance:IsReady() and v7:IsInRange(3 + 5) and not v69 and v70) then
		if v13(v23.GlacialAdvance) then
			return "glacial_advance obliteration 22";
		end
	end
	if (v23.FrostStrike:IsReady() and v7:IsSpellInRange(v23.FrostStrike) and not v69) then
		if v26.CastTargetIf(v23.FrostStrike, v72, "max", v91, v97, 2 + 3) then
			return "frost_strike obliteration 24";
		end
	end
	if (v23.HornofWinter:IsReady() and v7:IsInMeleeRange(23 - 15) and (v6:Rune() < (7 - 4))) then
		if v13(v23.HornofWinter, true) then
			return "horn_of_winter obliteration 26";
		end
	end
	if (v23.ArcaneTorrent:IsReady() and RacialsSetting and v7:IsInRange(122 - (4 + 110)) and (v6:Rune() < (585 - (57 + 527))) and (v6:RunicPower() < (1457 - (41 + 1386)))) then
		if v13(v23.ArcaneTorrent) then
			return "arcane_torrent obliteration 28";
		end
	end
	if (v23.HowlingBlast:IsReady() and v7:IsSpellInRange(v23.HowlingBlast) and (v6:BuffDown(v23.KillingMachineBuff))) then
		if v13(v23.HowlingBlast) then
			return "howling_blast obliteration 30";
		end
	end
end
local function v109()
	if (v65 and RacialsSetting) then
		if v23.BloodFury:IsCastable() then
			if v13(v23.BloodFury, false) then
				return "blood_fury racials 2";
			end
		end
		if v23.Berserking:IsCastable() then
			if v13(v23.Berserking, false) then
				return "berserking racials 4";
			end
		end
		if v23.ArcanePulse:IsCastable() then
			if v13(v23.ArcanePulse, false, nil, not v7:IsInRange(111 - (17 + 86))) then
				return "arcane_pulse racials 6";
			end
		end
		if v23.LightsJudgment:IsCastable() then
			if v13(v23.LightsJudgment, false, nil, not v7:IsSpellInRange(v23.LightsJudgment)) then
				return "lights_judgment racials 8";
			end
		end
		if v23.AncestralCall:IsCastable() then
			if v13(v23.AncestralCall, false) then
				return "ancestral_call racials 10";
			end
		end
		if v23.Fireblood:IsCastable() then
			if v13(v23.Fireblood, false) then
				return "fireblood racials 12";
			end
		end
	end
	if (v23.BagofTricks:IsCastable() and v23.Obliteration:IsAvailable() and v6:BuffDown(v23.PillarofFrostBuff) and v6:BuffUp(v23.UnholyStrengthBuff)) then
		if v13(v23.BagofTricks, false, nil, not v7:IsInRange(28 + 12)) then
			return "bag_of_tricks racials 14";
		end
	end
	if (v23.BagofTricks:IsCastable() and not v23.Obliteration:IsAvailable() and v6:BuffUp(v23.PillarofFrostBuff) and ((v6:BuffUp(v23.UnholyStrengthBuff) and (v6:BuffRemains(v23.UnholyStrengthBuff) < (v6:GCD() * (6 - 3)))) or (v6:BuffRemains(v23.PillarofFrostBuff) < (v6:GCD() * (8 - 5))))) then
		if v13(v23.BagofTricks, false, nil, not v7:IsInRange(206 - (122 + 44))) then
			return "bag_of_tricks racials 16";
		end
	end
end
local function v110()
	if (v23.FrostStrike:IsReady() and v7:IsInMeleeRange(8 - 3) and v23.AFeastofSouls:IsAvailable() and (v7:DebuffStack(v23.RazoriceDebuff) == (16 - 11)) and v23.ShatteringBlade:IsAvailable() and v6:BuffUp(v23.AFeastofSoulsBuff)) then
		if v13(v23.FrostStrike) then
			return "frost_strike single_target 2";
		end
	end
	if (v23.Obliterate:IsReady() and v7:IsInMeleeRange(5 + 0) and ((v6:BuffStack(v23.KillingMachineBuff) == (1 + 1)) or v6:BuffUp(v23.ExterminateBuff) or v6:BuffUp(v23.PainfulDeathBuff))) then
		if v13(v23.Obliterate) then
			return "obliterate single_target 4";
		end
	end
	if (v23.HornofWinter:IsReady() and v7:IsInMeleeRange(16 - 8) and (not v23.BreathofSindragosa:IsAvailable() or (VarTrueBreathCD > (95 - (30 + 35)))) and (v23.PillarofFrost:CooldownRemains() < v66)) then
		if v13(v23.HornofWinter, true) then
			return "horn_of_winter single_target 6";
		end
	end
	if (v23.FrostStrike:IsReady() and v7:IsInMeleeRange(4 + 1) and (((v7:DebuffStack(v23.RazoriceDebuff) == (1262 - (1043 + 214))) and v23.ShatteringBlade:IsAvailable()) or (v6:BuffUp(v23.KillingMachineBuff) and (v6:Rune() < (7 - 5)) and not v23.Icebreaker:IsAvailable()))) then
		if v13(v23.FrostStrike) then
			return "frost_strike single_target 8";
		end
	end
	if (v23.HowlingBlast:IsReady() and v7:IsSpellInRange(v23.HowlingBlast) and v63 and (not v23.BreathofSindragosa:IsAvailable() or v23.RageoftheFrozenChampion:IsAvailable() or v23.BreathofSindragosa:CooldownDown())) then
		if v13(v23.HowlingBlast) then
			return "howling_blast single_target 10";
		end
	end
	if (v23.Obliterate:IsReady() and v7:IsInMeleeRange(1217 - (323 + 889)) and v6:BuffUp(v23.KillingMachineBuff) and not v68) then
		if v13(v23.Obliterate) then
			return "obliterate single_target 12";
		end
	end
	if (v23.GlacialAdvance:IsReady() and v7:IsInRange(21 - 13) and not v69 and not v56 and ((v7:DebuffStack(v23.RazoriceDebuff) < (585 - (361 + 219))) or (v7:DebuffRemains(v23.RazoriceDebuff) < (v6:GCD() * (323 - (53 + 267)))))) then
		if v13(v23.GlacialAdvance) then
			return "glacial_advance single_target 14";
		end
	end
	if (v23.FrostStrike:IsReady() and v7:IsInMeleeRange(2 + 3) and not v69 and (v64 or (not v23.ShatteringBlade:IsAvailable() and (v6:RunicPowerDeficit() < (433 - (15 + 398)))))) then
		if v13(v23.FrostStrike) then
			return "frost_strike single_target 16";
		end
	end
	if (v23.HowlingBlast:IsReady() and v7:IsSpellInRange(v23.HowlingBlast) and v6:BuffUp(v23.RimeBuff) and (not v23.BreathofSindragosa:IsAvailable() or v23.RageoftheFrozenChampion:IsAvailable() or v23.BreathofSindragosa:CooldownDown())) then
		if v13(v23.HowlingBlast) then
			return "howling_blast single_target 18";
		end
	end
	if (v23.FrostStrike:IsReady() and v7:IsInMeleeRange(987 - (18 + 964)) and not v69 and not (v58 or v23.ShatteringBlade:IsAvailable())) then
		if v13(v23.FrostStrike) then
			return "frost_strike single_target 20";
		end
	end
	if (v23.Obliterate:IsReady() and v7:IsInMeleeRange(18 - 13) and not v68) then
		if v13(v23.Obliterate) then
			return "obliterate single_target 22";
		end
	end
	if (v23.FrostStrike:IsReady() and v7:IsInMeleeRange(3 + 2) and not v69) then
		if v13(v23.FrostStrike) then
			return "frost_strike single_target 24";
		end
	end
	if (v23.DeathAndDecay:IsReady() and DnDSetting and ((v73 > (0 + 0)) or v7:IsInRange(858 - (20 + 830))) and (v28.Commons.DnDMoving or not v6:IsMoving()) and v23.BreathofSindragosa:IsAvailable() and v6:BuffDown(v23.BreathofSindragosa) and not v17(VarTrueBreathCD) and (v6:Rune() < (2 + 0)) and v6:BuffDown(v23.DeathAndDecayBuff)) then
		if v12.CastTarget(v23.DeathAndDecay, v12.TName().PLAYER) then
			return "death_and_decay single_target 28";
		end
	end
	if (v23.HowlingBlast:IsReady() and v7:IsSpellInRange(v23.HowlingBlast) and (v7:DebuffDown(v23.FrostFeverDebuff))) then
		if v13(v23.HowlingBlast) then
			return "howling_blast single_target 28";
		end
	end
	if (v23.HornofWinter:IsReady() and v7:IsInMeleeRange(134 - (116 + 10)) and (v6:Rune() < (1 + 1)) and (v6:RunicPowerDeficit() > (763 - (542 + 196))) and (not v23.BreathofSindragosa:IsAvailable() or (VarTrueBreathCD > (64 - 34)))) then
		if v13(v23.HornofWinter, true) then
			return "horn_of_winter single_target 30";
		end
	end
	if (v23.ArcaneTorrent:IsReady() and RacialsSetting and v7:IsInRange(3 + 5) and not v23.BreathofSindragosa:IsAvailable() and (v6:RunicPowerDeficit() > (11 + 9))) then
		if v13(v23.ArcaneTorrent) then
			return "arcane_torrent single_target 32";
		end
	end
end
local function v111()
	if (WeaponSetting and v28.Commons.Enabled.Items and v7:IsInRange(9 + 16) and v24.Fyralath:IsEquippedAndReady() and (v23.MarkofFyralathDebuff:AuraActiveCount() > (0 - 0)) and v6:BuffDown(v23.PillarofFrostBuff) and v6:BuffDown(v23.EmpowerRuneWeaponBuff) and v6:BuffDown(v23.DeathAndDecayBuff) and ((v73 < (4 - 2)) or v7:DebuffUp(v23.FrostFeverDebuff))) then
		v12.CastMacro(1552 - (1126 + 425), nil, nil, v24.Fyralath);
		return "weapon cast";
	end
	if (v24.TreacherousTransmitter:IsEquippedAndReady() and (((v30:ID() == v24.TreacherousTransmitter:ID()) and Trinket1Setting) or ((v31:ID() == v24.TreacherousTransmitter:ID()) and Trinket2Setting)) and (((v23.PillarofFrost:CooldownRemains() < (411 - (118 + 287))) and (not v23.BreathofSindragosa:IsAvailable() or v6:BuffUp(v23.BreathofSindragosa) or (VarTrueBreathCD < (23 - 17)))) or (v74 < (1151 - (118 + 1003))))) then
		if v13(v24.TreacherousTransmitter, true) then
			return "TreacherousTransmitter Trinkets 2";
		end
	end
	if (v88() and v6:AffectingCombat() and (((v30:ID() == v24.ManicGrieftorch:ID()) and Trinket1Setting) or ((v31:ID() == v24.ManicGrieftorch:ID()) and Trinket2Setting)) and v7:IsInRange(117 - 77)) then
		if v13(v24.ManicGrieftorch) then
			return "manic_grieftorch";
		end
	end
	if (v28.Commons.Enabled.Trinkets and v6:BuffDown(v23.ConcoctionKissofDeathBuff)) then
		if (v30:IsReady() and v7:IsInMeleeRange(382 - (142 + 235)) and Trinket1Setting and not v50 and (v32 == (0 - 0)) and v42 and not v48 and (not v23.BreathofSindragosa:IsAvailable() or v6:BuffUp(v23.BreathofSindragosa) or (v23.BreathofSindragosa:CooldownRemains() > (v30:CooldownRemains() / (1 + 1)))) and (v6:BuffUp(v23.BreathofSindragosa) or (not v23.BreathofSindragosa:IsAvailable() and (v6:BuffRemains(v23.PillarofFrostBuff) > (987 - (553 + 424))))) and (not v31:HasCooldown() or v31:CooldownDown() or (v46 == (1 - 0)))) then
			if v13(v30, false) then
				return "Generic use_item for " .. v30:Name() .. " trinkets 4";
			end
		end
		if (v31:IsReady() and v7:IsInMeleeRange(5 + 0) and Trinket2Setting and not v51 and (v32 == (0 + 0)) and v43 and not v49 and (not v23.BreathofSindragosa:IsAvailable() or v6:BuffUp(v23.BreathofSindragosa) or (v23.BreathofSindragosa:CooldownRemains() > (v31:CooldownRemains() / (2 + 0)))) and (v6:BuffUp(v23.BreathofSindragosa) or (not v23.BreathofSindragosa:IsAvailable() and (v6:BuffRemains(v23.PillarofFrostBuff) > (5 + 5)))) and (not v30:HasCooldown() or v30:CooldownDown() or (v46 == (2 + 0)))) then
			if v13(v31, false) then
				return "Generic use_item for " .. v31:Name() .. " trinkets 6";
			end
		end
		if (v30:IsReady() and v7:IsInMeleeRange(10 - 5) and Trinket1Setting and not v50 and (((v32 > (0 - 0)) and v42 and not v48 and v6:BuffDown(v23.PillarofFrostBuff) and (not v23.BreathofSindragosa:IsAvailable() or (v6:BuffDown(v23.BreathofSindragosa) and (v6:RunicPower() > VarBreathRPThreshold) and v23.PillarofFrost:CooldownUp() and v62)) and (not v31:HasCooldown() or v31:CooldownDown() or (v46 == (2 - 1)))) or (v44 >= v75))) then
			if v13(v30) then
				return "Generic use_item for " .. v30:Name() .. " trinkets 8";
			end
		end
		if (v31:IsReady() and v7:IsInMeleeRange(2 + 3) and Trinket2Setting and not v51 and (((v33 > (0 - 0)) and v43 and not v49 and v6:BuffDown(v23.PillarofFrostBuff) and (not v23.BreathofSindragosa:IsAvailable() or (v6:BuffDown(v23.BreathofSindragosa) and (v6:RunicPower() > VarBreathRPThreshold) and v23.PillarofFrost:CooldownUp() and v62)) and (not v30:HasCooldown() or v30:CooldownDown() or (v46 == (755 - (239 + 514))))) or (v45 >= v75))) then
			if v13(v31) then
				return "Generic use_item for " .. v31:Name() .. " trinkets 10";
			end
		end
		if (v30:IsReady() and v7:IsInMeleeRange(2 + 3) and Trinket1Setting and not v50 and ((not v42 and not v48 and ((v47 == (1330 - (797 + 532))) or not v31:HasCooldown() or v31:CooldownDown()) and (((((v32 > (0 + 0)) and (not v23.BreathofSindragosa:IsAvailable() or v6:BuffDown(v23.BreathofSindragosa) or not v71) and v6:BuffDown(v23.PillarofFrostBuff)) or (v32 == (0 + 0))) and (not v43 or (v23.PillarofFrost:CooldownRemains() > (47 - 27)))) or not v23.PillarofFrost:IsAvailable())) or (v74 < (1217 - (373 + 829))))) then
			if v13(v30) then
				return "Generic use_item for " .. v30:Name() .. " trinkets 12";
			end
		end
		if (v31:IsReady() and v7:IsInMeleeRange(736 - (476 + 255)) and Trinket2Setting and not v51 and ((not v43 and not v49 and ((v47 == (1132 - (369 + 761))) or not v30:HasCooldown() or v30:CooldownDown()) and (((((v33 > (0 + 0)) and (not v23.BreathofSindragosa:IsAvailable() or v6:BuffDown(v23.BreathofSindragosa) or not v71) and v6:BuffDown(v23.PillarofFrostBuff)) or (v33 == (0 - 0))) and (not v42 or (v23.PillarofFrost:CooldownRemains() > (37 - 17)))) or not v23.PillarofFrost:IsAvailable())) or (v74 < (253 - (64 + 174))))) then
			if v13(v31) then
				return "Generic use_item for " .. v31:Name() .. " trinkets 14";
			end
		end
		if (v28.Commons.Enabled.Items and WeaponSetting) then
			local v151, v152, v153 = v6:GetUseableItems(v25, nil, true);
			if (v151 and (not v42 or v30:CooldownDown()) and v7:IsInMeleeRange(1 + 4) and (not v43 or v31:CooldownDown())) then
				if v13(v151) then
					return "Generic use_item for " .. v151:Name() .. " trinkets 16";
				end
			end
		end
	end
end
local function v112()
	v60 = (v73 <= (1 - 0)) or not v15();
	v61 = (v73 >= (338 - (144 + 192))) and v15();
	v62 = v60 or v61;
	v63 = v6:BuffUp(v23.RimeBuff) and (VarStaticRimeBuffs or (v23.Avalanche:IsAvailable() and not v23.ArcticAssault:IsAvailable() and (v7:DebuffStack(v23.RazoriceDebuff) < (221 - (42 + 174)))));
	VarTrueBreathCD = ((v23.BreathofSindragosa:CooldownRemains() > v23.PillarofFrost:CooldownRemains()) and v23.BreathofSindragosa:CooldownRemains()) or v23.PillarofFrost:CooldownRemains();
	v64 = (v23.UnleashedFrenzy:IsAvailable() and ((v6:BuffRemains(v23.UnleashedFrenzyBuff) < (v6:GCD() * (3 + 0))) or (v6:BuffStack(v23.UnleashedFrenzyBuff) < (3 + 0)))) or (v23.IcyTalons:IsAvailable() and ((v6:BuffRemains(v23.IcyTalonsBuff) < (v6:GCD() * (2 + 1))) or (v6:BuffStack(v23.IcyTalonsBuff) < ((1507 - (363 + 1141)) + ((1582 - (1183 + 397)) * v16(v23.SmotheringOffense:IsAvailable())) + ((5 - 3) * v16(v23.DarkTalons:IsAvailable()))))));
	v65 = (v23.PillarofFrost:IsAvailable() and v6:BuffUp(v23.PillarofFrostBuff) and ((v23.Obliteration:IsAvailable() and (v6:BuffRemains(v23.PillarofFrostBuff) > (8 + 2))) or not v23.Obliteration:IsAvailable())) or (not v23.PillarofFrost:IsAvailable() and v6:BuffUp(v23.EmpowerRuneWeaponBuff)) or (not v23.PillarofFrost:IsAvailable() and not v23.EmpowerRuneWeapon:IsAvailable()) or ((v73 >= (2 + 0)) and v6:BuffUp(v23.PillarofFrostBuff));
	v66 = 1978 - (1913 + 62);
	if ((v6:RunicPower() < (23 + 12)) and (v6:Rune() < (5 - 3)) and (v23.PillarofFrost:CooldownRemains() < (1943 - (565 + 1368)))) then
		v66 = (((v23.PillarofFrost:CooldownRemains() + (3 - 2)) / v76) / ((v6:Rune() + (1662 - (1477 + 184))) * (v6:RunicPower() + (6 - 1)))) * (94 + 6);
	end
	v67 = 858 - (564 + 292);
	if ((v6:RunicPowerDeficit() > (17 - 7)) and (VarTrueBreathCD < (30 - 20))) then
		v67 = (((VarTrueBreathCD + (305 - (244 + 60))) / v76) / ((v6:Rune() + 1 + 0) * (v6:RunicPower() + (496 - (41 + 435))))) * (1101 - (938 + 63));
	end
	if not BreathOfSindragosaSetting then
		v67 = -(1 + 0);
	end
	v68 = (v6:Rune() < VarOblitRunePooling) and v23.Obliteration:IsAvailable() and (not v23.BreathofSindragosa:IsAvailable() or v17(VarTrueBreathCD)) and (v23.PillarofFrost:CooldownRemains() < v66);
	v69 = (v23.BreathofSindragosa:IsAvailable() and BreathOfSindragosaSetting and ((VarTrueBreathCD < v67) or ((v75 < (1155 - (936 + 189))) and v23.BreathofSindragosa:CooldownUp()))) or (v23.Obliteration:IsAvailable() and (v6:RunicPower() < (12 + 23)) and (v23.PillarofFrost:CooldownRemains() < v66));
	v70 = (not v23.ShatteredFrost:IsAvailable() and v23.ShatteringBlade:IsAvailable() and (v73 >= (1617 - (1565 + 48)))) or (not v23.ShatteredFrost:IsAvailable() and not v23.ShatteringBlade:IsAvailable() and (v73 >= (2 + 0)));
	v71 = (v6:RunicPower() < (VarBreathRPCost * (1140 - (782 + 356)))) and (v6:RuneTimeToX(269 - (176 + 91)) > (v6:RunicPower() / VarBreathRPCost));
end
local function v113()
	if v12.DebugON() then
	end
	if v6:IsChanneling(v24.ManicGrieftorch.ItemUseSpell) then
		return "Dont cut Torch";
	end
	if (((v30:ID() == v24.ConcoctionKissofDeath:ID()) or (v31:ID() == v24.ConcoctionKissofDeath:ID())) and v6:BuffUp(v23.ConcoctionKissofDeathBuff) and (v6:BuffRemains(v23.ConcoctionKissofDeathBuff) < (2 - 1))) then
		if v13(v24.ConcoctionKissofDeath, true) then
			return "ConcoctionKissofDeath cooldowns 8";
		end
	end
	SmallCDToggle = v12.ToggleIconFrame:GetToggle(1 - 0);
	TabToggle = v12.ToggleIconFrame:GetToggle(1094 - (975 + 117));
	InterruptToggle = v12.ToggleIconFrame:GetToggle(1878 - (157 + 1718));
	DnDSetting = v12.ToggleIconFrame:GetToggle(4 + 0) and (v28.Commons.DnDMoving or not v6:IsMoving()) and v87(28 - 20);
	v72 = v6:GetEnemiesInMeleeRange(27 - 19);
	if v15() then
		v73 = #v72;
	else
		v73 = 1019 - (697 + 321);
	end
	EmpowerRuneWeaponSetting = v83(v28.Frost.EmpowerRuneWeaponSetting) and v87(v28.TTD.EmpowerRuneWeaponTTD);
	RacialsSetting = v83(v28.Frost.RacialsSetting) and v87(v28.TTD.RacialsTTD);
	Trinket1Setting = v83(v28.Frost.Trinket1Setting) and v87(v28.TTD.TrinketsTTD);
	Trinket2Setting = v83(v28.Frost.Trinket2Setting) and v87(v28.TTD.TrinketsTTD);
	PotionSetting = v83(v28.Frost.PotionSetting) and not v26.ISSolo();
	BreathOfSindragosaSetting = v83(v28.Frost.BreathOfSindragosaSetting) and v87(v28.TTD.BreathOfSindragosaTTD);
	PillarofFrostSetting = v83(v28.Frost.PillarofFrostSetting) and v87(v28.TTD.PillarofFrostTTD);
	FrostwyrmsFurySetting = v83(v28.Frost.FrostwyrmsFurySetting) and v87(v28.TTD.FrostwyrmsFuryTTD);
	AbominationLimbSetting = v83(v28.Frost.AbominationLimbSetting) and not IsNpcNearPlayer() and v87(v28.TTD.AbominationLimbTTD);
	RaiseDeadSetting = v83(v28.Frost.RaiseDeadSetting) and v87(v28.TTD.RaiseDeadTTD);
	WeaponSetting = v83(v28.Frost.Weapon);
	ReapersMarkSetting = v83(v28.Frost.ReapersMarkSetting) and v87(40 - 25);
	if (v26.TargetIsValid() or v6:AffectingCombat()) then
		v74 = v3.BossFightRemains();
		v78 = true;
		v75 = v74;
		if (v75 == (23539 - 12428)) then
			v78 = false;
			v75 = v3.FightRemains(v72, false);
		end
		v76 = v6:GCD() + (0.25 - 0);
	end
	if (v23.RaiseAlly:IsReady() and v28.Commons.RaiseAlly) then
		if (v8:UnitIsFriend() and v8:UnitIsPlayer() and v8:Exists() and v8:IsDeadOrGhost()) then
			v12.CastTarget(v23.RaiseAlly, v12.TName().MOUSEOVER);
			return "Raise Ally on Mouseover";
		end
		if (v7:UnitIsFriend() and v7:UnitIsPlayer() and v7:Exists() and v7:IsDeadOrGhost()) then
			v12.Cast(v23.RaiseAlly);
			return "Raise Ally on Target";
		end
	end
	if (v26.TargetIsValid() and (v7:AffectingCombat() or v28.Frost.AttackOutOfCombat)) then
		if not v6:AffectingCombat() then
			v79 = v102();
			if v79 then
				return v79;
			end
		end
		if (v23.DeathStrike:IsReady() and v90() and v7:IsInMeleeRange(2 + 3)) then
			if v13(v23.DeathStrike) then
				return "death_strike low hp or proc";
			end
		end
		if v6:AffectingCombat() then
			if (v23.IceboundFortitude:IsCastable() and (v6:HealthPercentage() <= v28.Frost.Defensives.IceboundFortitudeHP)) then
				if v13(v23.IceboundFortitude, false) then
					return "icebound_fortitude defensives";
				end
			end
			if (v23.AntiMagicShell:IsCastable() and (v6:HealthPercentage() <= v28.Frost.Defensives.AntiMagicShellHP) and v6:BuffDown(v23.AntiMagicZoneBuff) and v6:BuffDown(v23.IceboundFortitude)) then
				if v13(v23.AntiMagicShell, false) then
					return "AntiMagicShell defensives";
				end
			end
			if (v23.AntiMagicZone:IsCastable() and (v6:HealthPercentage() <= v28.Frost.Defensives.AntiMagicZoneHP) and v6:BuffDown(v23.AntiMagicShell) and v6:BuffDown(v23.IceboundFortitude)) then
				if v12.CastTarget(v23.AntiMagicZone, v12.TName().PLAYER) then
					return "AntiMagicZone defensives";
				end
			end
			if (v23.Lichborne:IsCastable() and (v6:HealthPercentage() <= v28.Frost.Defensives.LichborneHP)) then
				if v13(v23.Lichborne, false) then
					return "Lichborne defensives";
				end
			end
		end
		v112();
		if (v28.Commons.Enabled.Trinkets or v28.Commons.Enabled.Items) then
			v79 = v111();
			if v79 then
				return v79;
			end
		end
		v79 = v107();
		if v79 then
			return v79;
		end
		v79 = v106();
		if v79 then
			return v79;
		end
		v79 = v109();
		if v79 then
			return v79;
		end
		if (v23.ColdHeart:IsAvailable() and (v6:BuffDown(v23.KillingMachineBuff) or v23.BreathofSindragosa:IsAvailable()) and ((v7:DebuffStack(v23.RazoriceDebuff) == (9 - 4)) or (not v56 and not v23.GlacialAdvance:IsAvailable() and not v23.Avalanche:IsAvailable() and not v23.ArcticAssault:IsAvailable()) or (v74 <= (v6:GCD() + (0.5 - 0))))) then
			v79 = v105();
			if v79 then
				return v79;
			end
		end
		if v6:BuffUp(v23.BreathofSindragosa) then
			local v154 = v104();
			if v154 then
				return v154;
			end
			if v12.CastAnnotated(v23.Pool, false, "WAIT") then
				return "Wait for Breath()";
			end
		end
		if (v23.Obliteration:IsAvailable() and v6:BuffUp(v23.PillarofFrostBuff) and v6:BuffDown(v23.BreathofSindragosa)) then
			local v155 = v108();
			if v155 then
				return v155;
			end
			if v12.CastAnnotated(v23.Pool, false, "WAIT") then
				return "Wait for Obliteration()";
			end
		end
		if ((v73 >= (1229 - (322 + 905))) and v15()) then
			local v156 = v103();
			if v156 then
				return v156;
			end
		end
		if ((v73 <= (612 - (602 + 9))) or not v15()) then
			local v157 = v110();
			if v157 then
				return v157;
			end
		end
		v79 = (v73 > (1189 - (449 + 740))) and not v7:IsInRange(877 - (826 + 46)) and v82();
		if v79 then
			return v79;
		end
		if v12.CastAnnotated(v23.Pool, false, "WAIT") then
			return "Wait/Pool Resources RP:" .. v6:RunicPower() .. "R:" .. v6:Rune();
		end
	end
end
local function v114()
	v23.FrostFeverDebuff:RegisterAuraTracking();
	v23.MarkofFyralathDebuff:RegisterAuraTracking();
	v28.Frost.Display();
	v12:UpdateMacro("macro1", "/use 16");
	v12:UpdateMacro("macro2", "/target [@mouseover]");
	v12.Print("Frost Death Knight rotation has been updated for patch 11.0.2.");
end
v12.SetAPL(1198 - (245 + 702), v113, v114);
