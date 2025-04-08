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
local v15 = v12.CastSuggested;
local v16 = v12.Commons().Everyone.num;
local v17 = v12.Commons().Everyone.bool;
local v18 = math.max;
local v19 = math.min;
local v20 = v10.Priest.Shadow;
local v21 = v11.Priest.Shadow;
local v22 = {v21.AberrantSpellforge:ID(),v21.SpymastersWeb:ID()};
local v23 = v12.Commons().Everyone;
local v24 = v12.GUISettingsGet();
local v25 = {General=v24.General,Commons=v24.APL.Priest.Commons,Shadow=v24.APL.Priest.Shadow,Shadow_Defensives=v24.APL.Priest.Shadow.Defensives,Shadow_TTD=v24.APL.Priest.Shadow_TTD,Shadow_CDUSE=v24.APL.Priest.Shadow_CDUSE};
local v26, v27 = false, true;
local v28, v29 = 22 - 10, false;
local v30, v31 = false, false;
local v32 = false;
local v33 = false;
local v34 = false;
local v35 = false;
local v36 = (v20.ShadowCrashTarget:IsAvailable() and v20.ShadowCrashTarget) or v20.ShadowCrash;
local v37 = (v20.VoidWraith:IsAvailable() and v20.VoidWraithAbility) or (v20.Mindbender:IsAvailable() and v20.Mindbender) or v20.Shadowfiend;
local v38, v39 = false, 0 - 0;
local v40, v41 = false, 619 - (555 + 64);
local v42, v43 = false, 931 - (857 + 74);
local v44;
local v45;
local v46, v47;
local v48;
local v49 = 11679 - (367 + 201);
local v50 = 12038 - (214 + 713);
local v51;
local v52;
local v53 = v6:GetEquipment();
local v54 = (v53[4 + 9] and v11(v53[3 + 10])) or v11(877 - (282 + 595));
local v55 = (v53[1651 - (1523 + 114)] and v11(v53[13 + 1])) or v11(0 - 0);
v3:RegisterForEvent(function()
	v53 = v6:GetEquipment();
	v54 = (v53[1078 - (68 + 997)] and v11(v53[1283 - (226 + 1044)])) or v11(0 - 0);
	v55 = (v53[131 - (32 + 85)] and v11(v53[14 + 0])) or v11(0 + 0);
end, "PLAYER_EQUIPMENT_CHANGED");
v3:RegisterForEvent(function()
	v26, v27 = false, true;
	v28, v29 = 969 - (892 + 65), false;
	v30, v31 = false, false;
	v32 = false;
	v33 = false;
	v34 = false;
	v35 = false;
	v38, v39 = false, 0 - 0;
	v40, v41 = false, 0 - 0;
	v42, v43 = false, 0 - 0;
	v49 = 11461 - (87 + 263);
	v50 = 11291 - (67 + 113);
end, "PLAYER_REGEN_ENABLED");
v3:RegisterForEvent(function()
	v36 = (v20.ShadowCrashTarget:IsAvailable() and v20.ShadowCrashTarget) or v20.ShadowCrash;
	v37 = (v20.VoidWraith:IsAvailable() and v20.VoidWraithAbility) or (v20.Mindbender:IsAvailable() and v20.Mindbender) or v20.Shadowfiend;
	v20.ShadowCrash:RegisterInFlightEffect(150604 + 54782);
	v20.ShadowCrash:RegisterInFlight();
	v20.ShadowCrashTarget:RegisterInFlightEffect(504256 - 298870);
	v20.ShadowCrashTarget:RegisterInFlight();
end, "SPELLS_CHANGED", "LEARNED_SPELL_IN_TAB");
v20.ShadowCrash:RegisterInFlightEffect(151052 + 54334);
v20.ShadowCrash:RegisterInFlight();
v20.ShadowCrashTarget:RegisterInFlightEffect(816304 - 610918);
v20.ShadowCrashTarget:RegisterInFlight();
local function v56()
	local v103 = 953 - (802 + 150);
	if v6:BuffUp(v20.DarkAscensionBuff) then
		v103 = v103 * (2.25 - 1);
	end
	if v6:BuffUp(v20.DarkEvangelismBuff) then
		v103 = v103 * ((1 - 0) + ((0.01 + 0) * v6:BuffStack(v20.DarkEvangelismBuff)));
	end
	if (v6:BuffUp(v20.DevouredFearBuff) or v6:BuffUp(v20.DevouredPrideBuff)) then
		v103 = v103 * (998.05 - (915 + 82));
	end
	if v20.DistortedReality:IsAvailable() then
		v103 = v103 * (2.2 - 1);
	end
	if v6:BuffUp(v20.MindDevourerBuff) then
		v103 = v103 * (1.2 + 0);
	end
	if v20.Voidtouched:IsAvailable() then
		v103 = v103 * (1.06 - 0);
	end
	return v103;
end
v20.DevouringPlague:RegisterPMultiplier(v20.DevouringPlagueDebuff, v56);
local function v57(v104, v105)
	if v105 then
		return v104:DebuffUp(v20.ShadowWordPainDebuff) and v104:DebuffUp(v20.VampiricTouchDebuff) and v104:DebuffUp(v20.DevouringPlagueDebuff);
	else
		return v104:DebuffUp(v20.ShadowWordPainDebuff) and v104:DebuffUp(v20.VampiricTouchDebuff);
	end
end
local function v58(v106, v107)
	if not v106 then
		return nil;
	end
	local v108 = 1187 - (1069 + 118);
	local v109 = nil;
	for v146, v147 in pairs(v106) do
		local v148 = v147:TimeToDie();
		if v107 then
			if ((v148 * v16(v147:DebuffRefreshable(v20.VampiricTouchDebuff))) > v108) then
				v108 = v148;
				v109 = v147;
			end
		elseif (v148 > v108) then
			v108 = v148;
			v109 = v147;
		end
	end
	return v109;
end
local v59;
local function v60(v110)
	return (v59 and v25.Shadow_TTD.IgnoreWhenBoss) or v23.Buggedmobs[v7:NPCID()] or (v23.ISSolo() and v25.Shadow_TTD.IgnoreWhenSolo) or (v110 == (0 - 0)) or ((v50 >= v110) and (v50 < (17011 - 9234)));
end
local function v61(v111)
	return (v111 ~= "Not Used") and ((((v111 == "with Cooldowns") or ((v111 == "small CDs") and v25.Shadow_CDUSE.smallcdswithCooldowns) or (v111 == "with Cooldowns or AoE") or (v111 == "on Enemycount or Cooldowns") or (v111 == "on Boss or with Cooldowns")) and v14()) or (v111 == "always") or (((v111 == "on Boss only") or (v111 == "on Boss or on Enemycount") or (v111 == "on Boss or with Cooldowns")) and (v59 or v7:IsDummy())) or ((v111 == "with Bloodlust only") and v6:BloodlustUp()) or ((v111 == "small CDs") and Smallcds) or (((v111 == "on AOE") or (v111 == "with Cooldowns or AoE")) and (v48 >= (1 + 1))) or (((v111 == "on Enemycount or Cooldowns") or (v111 == "on Enemycount") or (v111 == "on Boss or on Enemycount")) and (v48 >= v25.Shadow_CDUSE.Enemycount)));
end
local function v62()
	if (not v20.Rhapsody:IsAvailable() and not v20.DivineStar:IsAvailable() and not v20.Halo:IsAvailable()) then
		return false;
	end
	local v112;
	if UnitInRaid("player") then
		v112 = v5.Raid;
	elseif UnitInParty("player") then
		v112 = v5.Party;
	else
		return false;
	end
	local v113 = ((v20.DivineStar:IsAvailable() or v20.Halo:IsAvailable()) and (53 - 23)) or (12 + 0);
	for v149, v150 in pairs(v112) do
		if (v150:Exists() and not v150:IsDeadOrGhost() and v150:IsInRange(v113) and (v150:HealthPercentage() < (826 - (368 + 423)))) then
			return true;
		end
	end
	return false;
end
local function v63()
	return (v8:Exists() or not v25.Shadow.CursorCheck) and not v6:IsCameraBusy();
end
local function v64(v114)
	return (v16(v114:HealthPercentage() <= (62 - 42)) * (118 - (10 + 8))) + v16(v114:DebuffUp(v20.DevouringPlagueDebuff));
end
local function v65(v115)
	return (v115:DebuffRemains(v20.DevouringPlagueDebuff) * (3846 - 2846)) + v115:TimeToDie();
end
local function v66(v116)
	return (v116:DebuffRemains(v20.DevouringPlagueDebuff));
end
local function v67(v117)
	return (v117:DebuffRemains(v20.ShadowWordPainDebuff));
end
local function v68(v118)
	return (v118:TimeToDie());
end
local function v69(v119)
	return v119:TimeToDie() * v16((v119:DebuffRemains(v20.DevouringPlagueDebuff) <= v45) or v26 or (not v20.DistortedReality:IsAvailable() and v27));
end
local function v70(v120)
	return ((v16(v120:DebuffRefreshable(v20.VampiricTouchDebuff)) * (10442 - (416 + 26))) + v120:TimeToDie()) * v16(v120:DebuffUp(v20.VampiricTouchDebuff) or not v33);
end
local function v71(v121)
	return (v121:DebuffRemains(v20.VampiricTouchDebuff));
end
local function v72(v122)
	return ((v20.DevouringPlagueDebuff:AuraActiveCount() <= (3 - 2)) and (v7:DebuffRemains(v20.DevouringPlagueDebuff) <= v45) and (not v20.VoidEruption:IsAvailable() or (v20.VoidEruption:CooldownRemains() >= (v45 * (2 + 1))))) or (v6:InsanityDeficit() <= (27 - 11));
end
local function v73(v123)
	return v123:DebuffRemains(v20.DevouringPlagueDebuff) >= (440.5 - (145 + 293));
end
local function v74(v124)
	return v124:DebuffRemains(v20.DevouringPlagueDebuff) > v20.MindBlast:ExecuteTime();
end
local function v75(v125)
	return (v125:HealthPercentage() <= (450 - (44 + 386))) or (v6:BuffUp(v20.DeathspeakerBuff) and v20.Deathspeaker:IsAvailable());
end
local function v76(v126)
	return (v126:DebuffRemains(v20.DevouringPlagueDebuff) >= v20.VoidBlast:ExecuteTime()) or (v41 <= v45) or (v6:IsChanneling(v20.VoidTorrent) and v20.VoidEmpowerment:IsAvailable());
end
local function v77(v127)
	return v127:DebuffUp(v20.DevouringPlagueDebuff) or (v20.VoidEruption:IsAvailable() and v20.VoidEruption:CooldownUp());
end
local function v78(v128)
	return v128:DebuffRefreshable(v20.VampiricTouchDebuff) and v60(1504 - (998 + 488)) and (v128:DebuffUp(v20.VampiricTouchDebuff) or not v33) and ((v36:CooldownRemains() >= v128:DebuffRemains(v20.VampiricTouchDebuff)) or v32 or not v20.WhisperingShadows:IsAvailable());
end
local function v79(v129)
	return v129:DebuffRefreshable(v20.VampiricTouchDebuff) and v60(6 + 12) and (((v28 > (0 + 0)) and not v34 and not v36:InFlight()) or not v20.WhisperingShadows:IsAvailable() or not IsShadowCrash) and not v40;
end
local function v80(v130)
	return (v130:HealthPercentage() < (792 - (201 + 571))) or ((v6:BuffUp(v20.DeathspeakerBuff) or v6:HasTier(1169 - (116 + 1022), 8 - 6)) and v130:DebuffUp(v20.DevouringPlagueDebuff));
end
local function v81(v131)
	return v131:HealthPercentage() < (12 + 8);
end
local function v82(v132)
	return v132:DebuffRefreshable(v20.VampiricTouchDebuff) or ((v132:DebuffRemains(v20.VampiricTouchDebuff) <= v132:TimeToDie()) and v6:BuffDown(v20.VoidformBuff));
end
local function v83(v133)
	return (v133:MaxHealth() > (v25.Shadow.VTMinHP * (3650690 - 2650690))) and v133:DebuffRefreshable(v20.VampiricTouchDebuff) and v60(63 - 45) and (v133:DebuffUp(v20.VampiricTouchDebuff) or not v33);
end
local function v84(v134)
	return v134:DebuffRefreshable(v20.VampiricTouchDebuff);
end
local function v85(v135)
	return v135:NPCID() == (205419 - (814 + 45));
end
local function v86(v136)
	return v136:CastSpellID() == (1007281 - 598476);
end
local function v87()
	if v23.TargetIsValid() then
		local v152 = v7:MinDistance() or (1 + 4);
		local v153 = v7:MaxDistance() or (15 + 25);
		v152 = math.max(v152 - (893 - (261 + 624)), 8 - 3);
		v153 = math.min(v153 + (1088 - (1020 + 60)), 1463 - (630 + 793));
		local v154 = v6:GetEnemiesInRange(v152);
		local v155 = v6:GetEnemiesInRange(v153);
		local v156 = #v155;
		if ((v153 - v152) > (53 - 37)) then
			v156 = v156 - #v154;
		end
		v156 = math.max(v156, 4 - 3);
		return v156;
	else
		return #(v6:GetEnemiesInRange(16 + 24));
	end
end
local v88 = nil;
local function v89()
	if v6:IsMoving() then
		if not v88 then
			v88 = GetTime();
		end
		return GetTime() - v88;
	else
		if v88 then
			v88 = nil;
		end
		return 0 - 0;
	end
end
local function v90(v137, v138)
	if Shouldskip then
		if v12.Cast(v137, true) then
			return "HR skip cast";
		end
	end
	if v12.Cast(v137) then
		return "normal cast";
	end
end
local function v91()
	if (v20.FlashHeal:IsReady() and (v6:HealthPercentage() <= v25.Shadow.Defensives.FlashHealHP)) then
		if v90(v20.FlashHeal) then
			return "FlashHeal";
		end
	end
	if (v20.PowerWordLife:IsCastable() and v6:AffectingCombat() and (v6:HealthPercentage() <= v25.Shadow.Defensives.PowerWordLifeHP)) then
		if v90(v20.PowerWordLife) then
			return "PowerWordLife";
		end
	end
	if (v20.Fade:IsCastable() and v6:AffectingCombat() and (v6:HealthPercentage() <= v25.Shadow.Defensives.FadeHP)) then
		if v90(v20.Fade) then
			return "Fade";
		end
	end
	if (v20.DesperatePrayer:IsCastable() and v6:AffectingCombat() and (v6:HealthPercentage() <= v25.Shadow.Defensives.DesperatePrayerHP)) then
		if v90(v20.DesperatePrayer) then
			return "DesperatePrayer";
		end
	end
	if (v20.Dispersion:IsCastable() and v6:AffectingCombat() and (v6:HealthPercentage() <= v25.Shadow.Defensives.DispersionHP)) then
		if v90(v20.Dispersion) then
			return "Dispersion";
		end
	end
	if (v20.PowerWordShield:IsReady() and v6:AffectingCombat() and (v6:HealthPercentage() <= v25.Shadow.Defensives.PWShieldHP)) then
		if v90(v20.PowerWordShield) then
			return "PowerWordShield";
		end
	end
	if (v20.VampiricEmbrace:IsCastable() and v6:AffectingCombat() and (v25.Shadow.Defensives.VampiricEmbraceCount ~= (1747 - (760 + 987))) and (not v25.Shadow.Defensives.VampiricEmbraceHP ~= (1913 - (1789 + 124))) and v23.AoELogicWithCount(v25.Shadow.Defensives.VampiricEmbraceHP, v25.Shadow.Defensives.VampiricEmbraceCount, nil, v51)) then
		if v90(v20.VampiricEmbrace) then
			return "NaturesVigil";
		end
	end
end
local function v92()
	if (v20.ArcaneTorrent:IsCastable() and IsRacials) then
		if v90(v20.ArcaneTorrent, true) then
			return "arcane_torrent precombat 6";
		end
	end
	if (v25.Commons.Enabled.Trinkets and v21.AberrantSpellforge:IsEquippedAndReady() and (((v54:ID() == v21.AberrantSpellforge:ID()) and IsTrinket1) or ((v55:ID() == v21.AberrantSpellforge:ID()) and IsTrinket2))) then
		if v90(v21.AberrantSpellforge, true) then
			return "aberrant_spellforge precombat 8";
		end
	end
	if (v36:IsCastable() and IsShadowCrash and v7:IsInRange(806 - (745 + 21))) then
		if v90(v20.ShadowCrash, true) then
			return "shadow_crash precombat 8";
		end
	end
	if (v20.VampiricTouch:IsCastable() and (not v6:IsMoving() or v6:BuffUp(v20.UnfurlingDarknessBuff)) and (not v36:IsAvailable() or not IsShadowCrash or (v36:CooldownDown() and not v36:InFlight()))) then
		if v90(v20.VampiricTouch) then
			return "vampiric_touch precombat 10";
		end
	end
	if (v20.ShadowWordPain:IsCastable() and not v20.Misery:IsAvailable()) then
		if v90(v20.ShadowWordPain) then
			return "shadow_word_pain precombat 12";
		end
	end
end
local function v93()
	v28 = v19(v48, 5 + 7);
	v29 = false;
	local v139 = v58(v47, true);
	if (v139 and (v139:TimeToDie() >= (49 - 31))) then
		v29 = true;
	end
	v33 = ((v20.VampiricTouchDebuff:AuraActiveCount() + ((31 - 23) * v16(v36:InFlight() and v20.WhisperingShadows:IsAvailable()))) >= v28) or not v29;
	if (v32 and v20.WhisperingShadows:IsAvailable()) then
		v32 = (v28 - v20.VampiricTouchDebuff:AuraActiveCount()) < (1 + 3);
	end
	v34 = ((v20.VampiricTouchDebuff:AuraActiveCount() + ((7 + 1) * v16(not v32))) >= v28) or not v29;
end
local function v94()
	v93();
	if (v20.VampiricTouch:IsCastable() and (not v6:IsMoving() or v6:BuffUp(v20.UnfurlingDarknessBuff))) then
		if v23.CastTargetIf(v20.VampiricTouch, v46, "min", v71, v79, 1095 - (87 + 968), Shouldskip) then
			return "vampiric_touch aoe 2";
		end
	end
	if (v36:IsCastable() and IsShadowCrash) then
		if v23.CastCycle(v20.ShadowCrash, v46, v82, 176 - 136, Shouldskip, nil, nil, true) then
			return "shadow_crash aoe 4";
		end
	end
end
local function v95()
	if v25.Commons.Enabled.Trinkets then
		if (v21.AberrantSpellforge:IsEquippedAndReady() and (((v54:ID() == v21.AberrantSpellforge:ID()) and IsTrinket1) or ((v55:ID() == v21.AberrantSpellforge:ID()) and IsTrinket2)) and (v6:BuffStack(v20.AberrantSpellforgeBuff) <= (4 + 0))) then
			if v90(v21.AberrantSpellforge, true) then
				return "aberrant_spellforge trinkets 26";
			end
		end
		if (v21.SpymastersWeb:IsEquippedAndReady() and (((v54:ID() == v21.SpymastersWeb:ID()) and IsTrinket1) or ((v55:ID() == v21.SpymastersWeb:ID()) and IsTrinket2)) and ((v6:PowerInfusionUp() and (v6:BuffStack(v20.SpymastersReportBuff) >= (90 - 50)) and (v50 > (1653 - (447 + 966)))) or (v6:PowerInfusionUp() and v6:BloodlustUp()) or (v6:PowerInfusionUp() and (v50 < (328 - 208))) or (((v49 <= (1837 - (1703 + 114))) or (v6:BuffUp(v20.DarkAscensionBuff) and (v49 <= (761 - (376 + 325)))) or (v40 and v20.EntropicRift:IsAvailable() and (v49 <= (49 - 19)))) and v6:BuffDown(v20.SpymastersWebBuff)))) then
			if v90(v21.SpymastersWeb, true) then
				return "spymasters_web trinkets 28";
			end
		end
	end
	local v140, v141, v142 = v6:GetUseableItems(v22);
	if (v140 and (v6:BuffUp(v20.VoidformBuff) or v6:PowerInfusionUp() or v6:BuffUp(v20.DarkAscensionBuff) or ((v20.VoidEruption:CooldownRemains() > (30 - 20)) and ((v140:Cooldown() <= (18 + 42)) or ((v141 ~= (28 - 15)) and (v141 ~= (28 - (9 + 5)))))) or (v49 < (396 - (85 + 291))))) then
		if ((((v141 == (1278 - (243 + 1022))) and IsTrinket1) or ((v141 == (53 - 39)) and IsTrinket2)) and v7:IsInRange(v142) and v25.Commons.Enabled.Trinkets) then
			if v90(v140, true) then
				return "Generic use_items for " .. v140:Name() .. " trinkets 30";
			end
		end
	end
	if v25.Commons.Enabled.Items then
		local v157, v158, v159 = v6:GetUseableItems(v22, 14 + 2);
		if (v157 and v157:IsReady() and v7:IsInRange(v159)) then
			v12.CastMacro(1181 - (1123 + 57), nil, nil, v157);
			return "weapon cast";
		end
	end
end
local function v96()
	if (v25.Commons.Enabled.Potions and IsPotions and (((v6:BuffUp(v20.VoidformBuff) or v6:PowerInfusionUp() or (v6:BuffUp(v20.DarkAscensionBuff) and (v49 <= (v20.PowerInfusion:CooldownRemains() + 13 + 2)))) and ((v49 >= (574 - (163 + 91))) or v6:BloodlustUp())) or (v49 <= (1960 - (1869 + 61))))) then
		local v160 = v23.PotionSelected();
		if (v160 and v160:IsReady()) then
			v12.CastMacro(1 + 2, true, nil, v160);
			return "Cast Potion";
		end
	end
	if (v20.Fireblood:IsCastable() and IsRacials and (v6:PowerInfusionUp() or (v49 <= (28 - 20)))) then
		if v90(v20.Fireblood, true) then
			return "fireblood cds 4";
		end
	end
	if (v20.Berserking:IsCastable() and IsRacials and (v6:PowerInfusionUp() or (v49 <= (17 - 5)))) then
		if v90(v20.Berserking, true) then
			return "berserking cds 6";
		end
	end
	if (v20.BloodFury:IsCastable() and IsRacials and (v6:PowerInfusionUp() or (v49 <= (3 + 12)))) then
		if v90(v20.BloodFury, true) then
			return "blood_fury cds 8";
		end
	end
	if (v20.AncestralCall:IsCastable() and IsRacials and (v6:PowerInfusionUp() or (v49 <= (20 - 5)))) then
		if v90(v20.AncestralCall, true) then
			return "ancestral_call cds 10";
		end
	end
	if (v25.Commons.Enabled.Trinkets and v7:IsInRange(43 + 2) and v21.NymuesUnravelingSpindle:IsEquippedAndReady() and (((v54:ID() == v21.NymuesUnravelingSpindle:ID()) and IsTrinket1) or ((v55:ID() == v21.NymuesUnravelingSpindle:ID()) and IsTrinket2)) and v33 and ((v49 < (1504 - (1329 + 145))) or (v7:TimeToDie() > (986 - (140 + 831)))) and (not v20.DarkAscension:IsAvailable() or (v20.DarkAscension:CooldownRemains() < ((1853 - (1409 + 441)) + v45)) or (v49 < (733 - (15 + 703))))) then
		if v90(v21.NymuesUnravelingSpindle, true) then
			return "nymues_unraveling_spindle cds 12";
		end
	end
	if (v20.PowerInfusion:IsCastable() and IsPowerInfusion and (v6:BuffUp(v20.VoidformBuff) or (v6:BuffUp(v20.DarkAscension) and ((v49 <= (38 + 42)) or (v49 >= (578 - (262 + 176))))))) then
		if (v5.Focus:Exists() and v25.Shadow_CDUSE.CleverPI and v5.Focus:IsSpellInRange(v20.PowerInfusion) and v5.Focus:UnitIsFriend() and not v5.Focus:IsDeadOrGhost()) then
			v5.Focus:Cast(v20.PowerInfusion, true);
			return "power_infusion";
		elseif v12.CastTarget(v20.PowerInfusion, v12.TName().PLAYER, true) then
			return "PowerInfusion";
		end
	end
	if (v20.Halo:IsReady() and IsHalo and not v6:IsMoving() and (v6:HeroTreeID() == (1740 - (345 + 1376))) and ((v38 and (v37:CooldownRemains() >= (692 - (198 + 490))) and v20.Mindbender:IsAvailable()) or (not v20.Mindbender:IsAvailable() and v37:CooldownDown()) or ((v48 > (8 - 6)) and not v20.InescapableTorment:IsAvailable()) or not v20.DarkAscension:IsAvailable()) and ((v20.MindBlast:Charges() == (0 - 0)) or not v20.VoidEruption:IsAvailable() or (v20.VoidEruption:CooldownRemains() >= (v45 * (1210 - (696 + 510)))))) then
		if v90(v20.Halo, true) then
			return "halo cds 20";
		end
	end
	if (v20.VoidEruption:IsCastable() and not v6:IsMoving() and IsVoidEruption and ((v37:CooldownDown() and ((v38 and (v37:CooldownRemains() >= (7 - 3))) or not v20.Mindbender:IsAvailable() or ((v48 > (1264 - (1091 + 171))) and not v20.InescapableTorment:IsAvailable())) and ((v20.MindBlast:Charges() == (0 + 0)) or ((v20.MindBlast:Charges() == (3 - 2)) and v6:IsCasting(v20.MindBlast)) or (v3.CombatTime() > (49 - 34)) or v30)) or v25.Shadow_CDUSE.VoidEruptionASAP)) then
		if v90(v20.VoidEruption, true) then
			return "void_eruption cds 22";
		end
	end
	if (v20.DarkAscension:IsCastable() and IsVoidEruption and not v6:IsCasting(v20.DarkAscension) and not v6:IsMoving() and ((v38 and (v37:CooldownRemains() >= (378 - (123 + 251)))) or (not v20.Mindbender:IsAvailable() and v37:CooldownDown()) or ((v48 > (9 - 7)) and not v20.InescapableTorment:IsAvailable()) or v25.Shadow_CDUSE.VoidEruptionASAP)) then
		if v90(v20.DarkAscension, true) then
			return "dark_ascension cds 24";
		end
	end
	if (v25.Commons.Enabled.Trinkets or v25.Commons.Enabled.Items) then
		local v161 = v95();
		if v161 then
			return v161;
		end
	end
end
local function v97()
	if (v20.Halo:IsReady() and IsHalo and not v6:IsMoving()) then
		if v90(v20.Halo) then
			return "halo heal_for_tof 2";
		end
	end
	if v20.DivineStar:IsReady() then
		if v90(v20.DivineStar) then
			return "divine_star heal_for_tof 4";
		end
	end
end
local function v98()
	if (v20.MindSpikeInsanity:IsReady() and v7:DebuffRemains(v20.DevouringPlagueDebuff)) then
		if v90(v20.MindSpikeInsanity) then
			return "mind_spike_insanity empowered_filler 2";
		end
	end
	if (v44:IsCastable() and not v6:IsMoving() and v6:BuffUp(v20.MindFlayInsanityBuff) and v7:DebuffRemains(v20.DevouringPlagueDebuff)) then
		if v90(v44) then
			return "mind_flay empowered_filler 4";
		end
	end
end
local function v99()
	if (v20.VampiricTouch:IsCastable() and (not v6:IsMoving() or v6:BuffUp(v20.UnfurlingDarknessBuff)) and v6:BuffUp(v20.UnfurlingDarknessBuff)) then
		if v90(v20.VampiricTouch) then
			return "vampiric_touch filler 2";
		end
	end
	if (v20.TwistofFate:IsAvailable() and v6:BuffDown(v20.TwistofFateBuff) and v62()) then
		local v162 = v97();
		if v162 then
			return v162;
		end
	end
	if ((v7:DebuffRemains(v20.DevouringPlagueDebuff) > v20.MindSpike:CastTime()) or not v20.MindSpike:IsAvailable()) then
		local v163 = v98();
		if v163 then
			return v163;
		end
	end
	if (v20.ShadowWordDeath:IsReady() and v20.InescapableTorment:IsAvailable() and v38) then
		if v23.CastCycle(v20.ShadowWordDeath, v46, v80, 738 - (208 + 490), Shouldskip, nil, false) then
			return "shadow_word_death filler 4";
		end
	end
	if (v20.DevouringPlague:IsReady() and (v6:BuffUp(v20.VoidformBuff) or v20.DarkAscension:CooldownUp() or v6:BuffUp(v20.MindDevourerBuff))) then
		if v90(v20.DevouringPlague, Shouldskip) then
			return "devouring_plague filler ";
		end
	end
	if (v20.Halo:IsReady() and IsHalo and v7:IsInRange(3 + 27) and not v6:IsMoving() and (v48 > (1 + 0))) then
		if v90(v20.Halo, Shouldskip) then
			return "halo filler 14";
		end
	end
	local v143 = v98();
	if v143 then
		return v143;
	end
	if (v20.MindSpike:IsCastable() and not v6:IsMoving() and v7:DebuffRemains(v20.DevouringPlagueDebuff)) then
		if v90(v20.MindSpike) then
			return "mind_spike filler 16";
		end
	end
	if (v44:IsCastable() and not v6:IsMoving() and v7:DebuffRemains(v20.DevouringPlagueDebuff)) then
		if v90(v44) then
			return "mind_flay filler 18";
		end
	end
	if (v20.DivineStar:IsReady() and v7:IsInRange(866 - (660 + 176))) then
		if v90(v20.DivineStar, Shouldskip) then
			return "divine_star filler 20";
		end
	end
	if (v36:IsCastable() and v7:IsInRange(5 + 35) and IsShadowCrash and not v6:HasTier(233 - (14 + 188), 679 - (534 + 141))) then
		if v90(v20.ShadowCrash, Shouldskip) then
			return "shadow_crash filler 22";
		end
	end
	if v20.ShadowWordDeath:IsReady() then
		if v23.CastCycle(v20.ShadowWordDeath, v46, v81, 17 + 23, Shouldskip) then
			return "shadow_word_death filler 24";
		end
	end
	if (v20.ShadowWordDeath:IsReady() and v7:DebuffRemains(v20.DevouringPlagueDebuff) and v6:IsMoving()) then
		if v90(v20.ShadowWordDeath) then
			return "shadow_word_death movement filler 26";
		end
	end
	if (v20.ShadowWordPain:IsReady() and v7:DebuffRemains(v20.DevouringPlagueDebuff) and v6:IsMoving() and (v6:HasTier(28 + 3, 4 + 0))) then
		if v90(v20.ShadowWordPain) then
			return "shadow_word_pain filler 30";
		end
	end
	if (v20.ShadowWordPain:IsReady() and v7:DebuffRemains(v20.ShadowWordPainDebuff) and v6:IsMoving() and (v6:HasTier(64 - 33, 5 - 1))) then
		if v90(v20.ShadowWordPain) then
			return "shadow_word_pain filler 32";
		end
	end
end
local function v100()
	v32 = false;
	if (v48 < (8 - 5)) then
		v33 = (v20.VampiricTouchDebuff:AuraActiveCount() == v48) or (v36:InFlight() and v20.WhisperingShadows:IsAvailable()) or (v6:IsCasting(v20.VampiricTouch) and v20.Misery:IsAvailable());
	end
	if v20.VoidBlast:IsAvailable() then
		v30 = IsVoidTorrent and (v20.VoidTorrent:CooldownRemains() <= (v45 * (1 + 0 + (v16(v20.MindMelt:IsAvailable()) * (2 + 1)))));
	end
	if ((v50 < (426 - (115 + 281))) or ((v7:TimeToDie() > (34 - 19)) and (not v32 or (v48 > (2 + 0))))) then
		local v164 = v96();
		if v164 then
			return v164;
		end
	end
	if (v37:IsCastable() and IsMindbender and ((v7:DebuffUp(v20.ShadowWordPainDebuff) and v33) or (v36:InFlight() and v20.WhisperingShadows:IsAvailable())) and ((v49 < (72 - 42)) or (v7:TimeToDie() > (55 - 40))) and (not v20.DarkAscension:IsAvailable() or (v20.DarkAscension:CooldownRemains() < v45) or (v49 < (882 - (550 + 317))))) then
		if v90(v37, true) then
			return "mindbender main 2";
		end
	end
	if (v20.VoidBlastAbility:IsReady() and ((v6:InsanityDeficit() >= (22 - 6)) or (v20.MindBlast:FullRechargeTime() <= v45)) and (not v20.MindDevourer:IsAvailable() or v6:BuffDown(v20.MindDevourerBuff) or (v41 <= v45))) then
		if v23.CastTargetIf(v20.VoidBlastAbility, v47, "max", v65, v76, 56 - 16, Shouldskip, nil, false) then
			return "void_blast main 4";
		end
	end
	if ((v20.MindBlast:Recharge() < v41) and v40 and (v41 < v45) and (v20.MindBlast:Charges() < (2 - 1))) then
		if v12.CastAnnotated(v20.Pool, false, "WAIT") then
			return "Wait for Mind Blast";
		end
	end
	if (v20.MindBlast:IsCastable() and (not v6:IsMoving() or v6:BuffUp(v20.DarkThoughtBuff) or v6:BuffUp(v20.ShadowyInsightBuff)) and v6:BuffUp(v20.VoidformBuff) and (v20.MindBlast:FullRechargeTime() <= v45) and (not v20.InsidiousIre:IsAvailable() or (v7:DebuffRemains(v20.DevouringPlagueDebuff) >= v20.MindBlast:ExecuteTime())) and ((((v20.VoidBolt:CooldownRemains() / v45) - (v20.VoidBolt:CooldownRemains() % v45)) * v45) <= (285.25 - (134 + 151))) and (((v20.VoidBolt:CooldownRemains() / v45) - (v20.VoidBolt:CooldownRemains() % v45)) >= (1665.01 - (970 + 695)))) then
		if v90(v20.MindBlast, Shouldskip) then
			return "mind_blast main 6";
		end
	end
	if (v20.VoidBolt:IsCastable() and (v6:InsanityDeficit() > (30 - 14)) and (v20.VoidBolt:CooldownRemains() <= (1990.1 - (582 + 1408)))) then
		if v90(v20.VoidBolt, Shouldskip) then
			return "void_bolt main 8";
		end
	end
	if v20.DevouringPlague:IsReady() then
		if v23.CastTargetIf(v20.DevouringPlague, v47, "max", v69, v72, 138 - 98, Shouldskip, nil, false) then
			return "devouring_plague main 10";
		end
	end
	if (v20.VoidTorrent:IsReady() and IsVoidTorrent and (not v6:IsMoving() or v20.DarkEnergy:IsAvailable()) and (v6:HeroTreeID() == (22 - 4)) and not v32 and ((v7:DebuffRemains(v20.DevouringPlagueDebuff) * (3768 - 2768)) + v7:TimeToDie()) and v7:DebuffRefreshable(v20.VampiricTouchDebuff) and (v7:TimeToDie() > (1836 - (1195 + 629))) and (v7:DebuffUp(v20.VampiricTouchDebuff) or not v33) and ((v36:CooldownRemains() >= v7:DebuffRemains(v20.VampiricTouchDebuff)) or v32 or not IsShadowCrash or not v20.WhisperingShadows:IsAvailable())) then
		if v90(v20.VoidTorrent, Shouldskip) then
			return "void_torrent main 12";
		end
	end
	if (v20.ShadowWordDeath:IsReady() and (v20.DepthofShadows:IsAvailable())) then
		if v23.CastTargetIf(v20.ShadowWordDeath, v47, "max", v64, v75, 52 - 12, Shouldskip, nil, false) then
			return "shadow_word_death main 14";
		end
	end
	if (v20.MindBlast:IsCastable() and (not v6:IsMoving() or v6:BuffUp(v20.DarkThoughtBuff) or v6:BuffUp(v20.ShadowyInsightBuff)) and ((v20.MindBlast:FullRechargeTime() <= (v45 + v20.MindBlast:ExecuteTime())) or (v39 <= (v20.MindBlast:ExecuteTime() + v45))) and v38 and v20.InescapableTorment:IsAvailable() and (v39 >= v20.MindBlast:ExecuteTime()) and (v48 <= (248 - (187 + 54))) and (v6:BuffDown(v20.MindDevourerBuff) or not v20.MindDevourer:IsAvailable()) and not v30 and v33) then
		if v23.CastTargetIf(v20.MindBlast, v47, "max", v66, v74, 820 - (162 + 618), Shouldskip, nil, false) then
			return "mind_blast main 16";
		end
	end
	if (v20.ShadowWordDeath:IsReady() and (v39 <= (v45 + 1 + 0)) and v38 and v20.InescapableTorment:IsAvailable() and (v48 <= (5 + 2))) then
		if v23.CastTargetIf(v20.ShadowWordDeath, v47, "max", v66, nil, 85 - 45, Shouldskip, nil, false) then
			return "shadow_word_death main 18";
		end
	end
	if (v20.VoidBolt:IsCastable() and (v20.VoidBolt:CooldownRemains() <= (0.1 - 0))) then
		if v23.CastTargetIf(v20.VoidBolt, v47, "max", v68, nil, 4 + 36, Shouldskip, nil, false) then
			return "void_bolt main 20";
		end
	end
	if ((((v6:BuffStack(v20.MindSpikeInsanityBuff) > (1638 - (1373 + 263))) and v20.MindSpike:IsAvailable()) or ((v6:BuffStack(v20.MindFlayInsanityBuff) > (1002 - (451 + 549))) and not v20.MindSpike:IsAvailable())) and v20.EmpoweredSurges:IsAvailable() and v20.VoidEruption:CooldownDown()) then
		local v165 = v98();
		if v165 then
			return v165;
		end
	end
	if (v6:BuffDown(v20.TwistofFateBuff) and v62()) then
		local v166 = v97();
		if v166 then
			return v166;
		end
	end
	if (v20.DevouringPlague:IsReady() and (v50 <= (v20.DevouringPlagueDebuff:BaseDuration() + 2 + 2))) then
		if v90(v20.DevouringPlague, Shouldskip) then
			return "devouring_plague main 22";
		end
	end
	if (v20.DevouringPlague:IsReady() and (((v6:InsanityDeficit() <= (54 - 19)) and v20.DistortedReality:IsAvailable()) or v6:BuffUp(v20.DarkAscensionBuff) or (v6:BuffUp(v20.MindDevourerBuff) and v20.MindBlast:CooldownUp() and ((v20.VoidEruption:CooldownRemains() >= ((4 - 1) * v45)) or not v20.VoidEruption:IsAvailable())) or v40)) then
		if v23.CastTargetIf(v20.DevouringPlague, v47, "max", v69, nil, 1424 - (746 + 638), Shouldskip, nil, false) then
			return "devouring_plague main 24";
		end
	end
	if (v20.VoidTorrent:IsCastable() and IsVoidTorrent and (not v6:IsMoving() or v20.DarkEnergy:IsAvailable())) then
		if (v7:DebuffRemains(v20.DevouringPlagueDebuff) >= (1.5 + 1)) then
			if v90(v20.VoidTorrent, Shouldskip) then
				return "void_torrent main 26 (primary target)";
			end
		elseif v23.CastTargetIf(v20.VoidTorrent, v47, "max", v65, v73, 60 - 20, Shouldskip, nil, false) then
			return "void_torrent main 26 (off-target)";
		end
	end
	if (v36:IsCastable() and v7:IsInRange(381 - (218 + 123)) and IsShadowCrash and not v32 and v7:DebuffRefreshable(v20.VampiricTouchDebuff)) then
		if v90(v20.ShadowCrash, Shouldskip) then
			return "shadow_crash main 28";
		end
	end
	if (v20.VampiricTouch:IsCastable() and (not v6:IsMoving() or v6:BuffUp(v20.UnfurlingDarknessBuff)) and ((v28 > (1581 - (1535 + 46))) or (v48 == (1 + 0))) and (not v36:InFlight() or not v20.WhisperingShadows:IsAvailable() or not IsShadowCrash)) then
		if v23.CastTargetIf(v20.VampiricTouch, v47, "max", v70, v78, 6 + 34, Shouldskip, nil, false) then
			return "vampiric_touch main 30";
		end
	end
	if (v20.ShadowWordDeath:IsReady() and v33 and v6:BuffUp(v20.DeathspeakerBuff)) then
		if v23.CastTargetIf(v20.ShadowWordDeath, v47, "max", v66, nil, 600 - (306 + 254), Shouldskip, nil, false) then
			return "shadow_word_death main 32";
		end
	end
	if (v20.MindBlast:IsCastable() and (not v6:IsMoving() or v6:BuffUp(v20.DarkThoughtBuff) or v6:BuffUp(v20.ShadowyInsightBuff)) and (v6:BuffDown(v20.MindDevourerBuff) or not v20.MindDevourer:IsAvailable() or (v20.VoidEruption:CooldownUp() and v20.VoidEruption:IsAvailable())) and not v30) then
		if v23.CastTargetIf(v20.MindBlast, v47, "max", v66, nil, 3 + 37, Shouldskip, nil, false) then
			return "mind_blast main 34";
		end
	end
	local v144 = v99();
	if v144 then
		return v144;
	end
end
local function v101()
	if v23.ShouldStopCastUpdate() then
		v12.CastMacro(11 - 5, true);
		return "Stop Cast For Silence";
	end
	InterruptToggle = v12.ToggleIconFrame:GetToggle(1468 - (899 + 568));
	DispelToggle = v12.ToggleIconFrame:GetToggle(2 + 0);
	Smallcds = v12.ToggleIconFrame:GetToggle(7 - 4);
	ShadowCrashToggle = v12.ToggleIconFrame:GetToggle(607 - (268 + 335));
	v89();
	local v145 = not v6:AffectingCombat() or not v7:AffectingCombat() or v7:IsDummy();
	v51 = v23.UnitsinRange(v20.FlashHeal);
	v46 = v6:GetEnemiesInRange(330 - (60 + 230));
	EnemiesRangeOOCCount = v87() or #v46;
	v47 = v7:GetEnemiesInSplashRange(582 - (426 + 146));
	if v13() then
		v48 = EnemiesRangeOOCCount;
	else
		v48 = 1 + 0;
	end
	Cursorcheck = (v63() and v20.ShadowCrash:IsAvailable()) or v20.ShadowCrashTarget:IsAvailable();
	IsRacials = v60(v25.Shadow_TTD.RacialsTTD) and v61(v25.Shadow_CDUSE.Racials);
	IsPotions = v60(v25.Shadow_TTD.PotionsTTD) and (v25.Shadow_CDUSE.Potionswhensolo or (not v25.Shadow_CDUSE.Potionswhensolo and not v23.ISSolo())) and v61(v25.Shadow_CDUSE.Potions);
	IsTrinket1 = v60(v25.Shadow_TTD.TrinketsTTD) and v61(v25.Shadow_CDUSE.Trinket1);
	IsTrinket2 = v60(v25.Shadow_TTD.TrinketsTTD) and v61(v25.Shadow_CDUSE.Trinket2);
	IsVoidEruption = v60(v25.Shadow_TTD.VoidEruptionTTD) and v61(v25.Shadow_CDUSE.VoidEruption);
	IsVoidTorrent = v60(v25.Shadow_TTD.VoidTorrentTTD) and v61(v25.Shadow_CDUSE.VoidTorrent);
	IsShadowCrash = ShadowCrashToggle and Cursorcheck and v61(v25.Shadow_CDUSE.ShadowCrash);
	IsMindbender = v60(v25.Shadow_TTD.MindbenderTTD) and v61(v25.Shadow_CDUSE.Mindbender);
	IsPowerInfusion = v60(v25.Shadow_TTD.PowerInfusionTTD) and v61(v25.Shadow_CDUSE.PowerInfusion);
	IsWeapon = v60(v25.Shadow_TTD.WeaponTTD) and v61(v25.Shadow_CDUSE.Weapon);
	IsHalo = v60(v25.Shadow_TTD.HaloTTD) and v61(v25.Shadow_CDUSE.Halo);
	v32 = false;
	Shouldskip = (v6:ChannelSpellID() == (16863 - (282 + 1174))) and (v6:GCDRemains() == (811 - (569 + 242)));
	if (v23.TargetIsValid() or v6:AffectingCombat()) then
		TargetinRange = v7:IsInRange(115 - 75);
		v49 = v3.BossFightRemains();
		v59 = true;
		v50 = v49;
		if (v50 == (636 + 10475)) then
			v59 = false;
			v50 = v3.FightRemains(v47, false);
		end
		v38 = v37:TimeSinceLastCast() <= (1039 - (706 + 318));
		v39 = v18((1266 - (721 + 530)) - v37:TimeSinceLastCast(), 1271 - (945 + 326));
		if (v6:HeroTreeID() == (44 - 26)) then
			v40 = v20.VoidTorrent:TimeSinceLastCast() <= (8 + 0);
			v41 = v18((708 - (271 + 429)) - v20.VoidTorrent:TimeSinceLastCast(), 0 + 0);
			v42 = false;
			v43 = 1500 - (1408 + 92);
		else
			v40 = false;
			v41 = 1086 - (461 + 625);
			v42 = v20.Halo:TimeSinceLastCast() <= (1298 - (993 + 295));
			v43 = v18((1 + 9) - v20.Halo:TimeSinceLastCast(), 1171 - (418 + 753));
		end
		v44 = ((v6:BuffUp(v20.MindFlayInsanityBuff)) and v20.MindFlayInsanity) or v20.MindFlay;
		v45 = v6:GCD() + 0.25 + 0;
	end
	v52 = not v6:IsMoving() and v23.IncorpCycle(v20.DominateMind, 4 + 26, Shouldskip, false);
	if v52 then
		return v52;
	end
	v52 = not v6:IsCasting(v20.ShackleUndead) and not v6:IsCasting(v20.DominateMind) and not v6:PrevGCDP(1 + 0, v20.ShackleUndead) and not v6:IsMoving() and v23.IncorpCycle(v20.ShackleUndead, 8 + 22, Shouldskip, false);
	if v52 then
		return v52;
	end
	if DispelToggle then
		v52 = v23.PurgeCycle(v20.DispelMagic, 569 - (406 + 123), false, v25.Commons.TabForDispelMagic);
		if v52 then
			return v52;
		end
		if (v20.PurifyDisease:IsCastable() and v6:IsInDungeonArea() and v6:IsInParty()) then
			v52 = v23.DispelCycle(v20.PurifyDisease, "Disease", nil, v51);
			if v52 then
				return v52;
			end
		end
	end
	if (v20.Fade:IsCastable() and v20.Phantasm:IsAvailable() and v6:DebuffUp(v20.EntangledDebuff) and v25.Commons.AutoFadeEntangling) then
		if v90(v20.Fade) then
			return "Fade for entangling";
		end
	end
	if (v20.Shadowform:IsCastable() and (v6:BuffDown(v20.ShadowformBuff))) then
		if v90(v20.Shadowform) then
			return "shadowform";
		end
	end
	if (v20.PowerWordFortitude:IsCastable() and not v6:DebuffUp(v20.Corruption) and ((v23.GroupBuffMissing(v20.PowerWordFortitudeBuff) and (v25.Commons.PowerWordFortitude == "check whole group") and (v6:IsInRaidArea() or v6:IsInDungeonArea())) or (v6:BuffDown(v20.PowerWordFortitudeBuff, true) and ((v25.Commons.PowerWordFortitude == "only check us") or (v25.Commons.PowerWordFortitude == "check whole group")))) and not v6:IsMounted()) then
		if v12.CastTarget(v20.PowerWordFortitude, v12.TName().PLAYER) then
			return "Power Word Fortitude";
		end
	end
	if ((v25.Shadow.Movement == "always") or ((v25.Shadow.Movement == "Only in Combat") and v6:AffectingCombat()) or ((v25.Shadow.Movement == "Only out of combat") and not v6:AffectingCombat())) then
		if (v20.AngelicFeather:IsCastable() and v6:IsMoving() and ((v89() > (1770 - (1749 + 20))) or not v6:AffectingCombat()) and v6:BuffDown(v20.AngelicFeatherBuff) and v6:BuffDown(v20.BodyAndSoulBuff) and not v6:IsMounted()) then
			if v12.CastTarget(v20.AngelicFeather, v12.TName().PLAYER) then
				return "AngelicFeather";
			end
		end
		if (v20.PowerWordShield:IsReady() and v20.BodyAndSoul:IsAvailable() and v6:IsMoving() and ((v89() > (1 + 0)) or not v6:AffectingCombat()) and v6:BuffDown(v20.AngelicFeatherBuff) and v6:BuffDown(v20.BodyAndSoulBuff) and not v6:IsMounted()) then
			if v90(v20.PowerWordShield) then
				return "PowerWordShield";
			end
		end
	end
	v52 = v91();
	if v52 then
		return v52;
	end
	if v23.TargetIsValid() then
		if (not v25.Shadow.AttackonlyinCombat or (v25.Shadow.AttackonlyinCombat and v7:AffectingCombat())) then
			if not v85(v5.Target) then
				if TargetinRange then
					if not v6:AffectingCombat() then
						v52 = v92();
						if v52 then
							return v52;
						end
					end
					if InterruptToggle then
						v52 = v23.InterruptCycle(v20.Silence, 1352 - (1249 + 73), true, nil, false);
						if v52 then
							return v52;
						end
					end
					v32 = false;
					v35 = v25.Shadow.PreferVTWhenSTinDungeon and (v48 == (1 + 0)) and v6:IsInDungeonArea() and v6:IsInParty() and not v6:IsInRaidArea();
					v31 = ((v20.VoidEruption:CooldownRemains() <= (v6:GCD() * (1148 - (466 + 679)))) and v20.VoidEruption:IsAvailable()) or (v20.DarkAscension:CooldownUp() and v20.DarkAscension:IsAvailable()) or (v20.VoidTorrent:IsAvailable() and v20.PsychicLink:IsAvailable() and (v20.VoidTorrent:CooldownRemains() <= (9 - 5)) and v6:BuffDown(v20.VoidformBuff));
					if ((v48 > (5 - 3)) and v13()) then
						local v169 = v94();
						if v169 then
							return v169;
						end
					end
					local v168 = v100();
					if v168 then
						return v168;
					end
					if v12.CastAnnotated(v20.Pool, false, "WAIT") then
						return "Pool for Main()";
					end
				end
			end
		end
	end
end
local function v102()
	v12.ResetToggle();
	v25.Shadow.Display();
	v20.VampiricTouchDebuff:RegisterAuraTracking();
	v20.DevouringPlague:RegisterAuraTracking();
	v12:UpdateMacro("macro1", "/use 16");
	v12:UpdateMacro("macro6", "/stopcasting");
	v12.ToggleIconFrame:AddButtonCustom("I", 1901 - (106 + 1794), "Interrupt", "interrupt");
	v12.ToggleIconFrame:AddButtonCustom("D", 1 + 1, "Dispel", "dispel");
	v12.ToggleIconFrame:AddButtonCustom("S", 1 + 2, "smallCDs", "smallcds");
	v12.ToggleIconFrame:AddButtonCustom("C", 11 - 7, "ShadowCrash", "shadowcrash");
	v12.Print("Shadow Priest rotation has been updated for patch 11.0.2. Last Update 03.10.2024");
end
v12.SetAPL(698 - 440, v101, v102);
