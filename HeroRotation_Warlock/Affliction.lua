local v0, v1 = ...;
local v2 = HeroDBC.DBC;
local v3 = HeroLib;
local v4 = HeroCache;
local v5 = v3.Unit;
local v6 = v5.Player;
local v7 = v5.Pet;
local v8 = v5.Target;
local v9 = v3.Spell;
local v10 = v3.Item;
local v11 = v5.MouseOver;
local v12 = HeroRotation();
local v13 = v12.AoEON;
local v14 = v12.CDsON;
local v15 = v12.Commons().Everyone.num;
local v16 = v12.Commons().Everyone.bool;
local v17 = math.max;
local v18 = C_Timer.After;
local v19;
local v20 = v12.Commons().Everyone;
local v21 = v12.Commons().Warlock;
local v22 = v12.GUISettingsGet();
local v23 = {General=v22.General,Commons=v22.APL.Warlock.Commons,Affliction=v22.APL.Warlock.Affliction,Defensives=v22.APL.Warlock.Defensives,Affliction_Pets=v22.APL.Warlock.Affliction_Pets,Affliction_TTD=v22.APL.Warlock.Affliction_TTD,Affliction_CDUSE=v22.APL.Warlock.Affliction_CDUSE};
local v24 = v9.Warlock.Affliction;
local v25 = v10.Warlock.Affliction;
local v26 = {v25.TimeThiefsGambit:ID(),v25.AberrantSpellforge:ID(),v25.SpymastersWeb:ID(),v25.KahetiShadowweaversEmblem:ID()};
local v27, v28;
local v29, v30;
local v31, v32;
local v33, v34;
local v35, v36;
local v37, v38;
local v39, v40;
local v41, v42;
local v43, v44;
local v45, v46;
local v47, v48;
local v49, v50;
local v51;
local v52, v53, v54;
local v55, v56, v57, v58, v59, v60, v61;
local v62, v63, v64, v65, v66;
local v67 = ((v24.DrainSoulTalent:IsAvailable()) and v24.DrainSoul) or v24.ShadowBolt;
local v68 = (v24.DrainSoul:IsLearned() and v24.ShadowEmbraceDSDebuff) or v24.ShadowEmbraceSBDebuff;
local v69 = (v24.DrainSoul:IsLearned() and (623 - (555 + 64))) or (933 - (857 + 74));
local v70 = 568 - (367 + 201);
local v71 = 12038 - (214 + 713);
local v72 = 2782 + 8329;
local v73;
local v74 = 0 + 0;
local function v75()
	local v132, v133 = v6:GetTrinketData(v26);
	if ((v74 < (882 - (282 + 595))) and ((v132.ID == (1637 - (1523 + 114))) or (v133.ID == (0 + 0)) or ((v132.SpellID > (0 - 0)) and not v132.Usable) or ((v133.SpellID > (1065 - (68 + 997))) and not v133.Usable))) then
		v74 = v74 + (1271 - (226 + 1044));
		v18(21 - 16, function()
			v75();
		end);
		return;
	end
	v27 = v132.Object;
	v28 = v133.Object;
	v29 = v132.ID;
	v30 = v133.ID;
	v31 = v132.Spell;
	v33 = v132.Range;
	v35 = v132.CastTime;
	v32 = v133.Spell;
	v34 = v133.Range;
	v36 = v133.CastTime;
	v37 = v132.Cooldown;
	v38 = v133.Cooldown;
	v39 = v132.Blacklisted;
	v40 = v133.Blacklisted;
	v41 = v27:HasUseBuff();
	v42 = v28:HasUseBuff();
	v43 = 117.5 - (32 + 85);
	if (v41 and (((v37 % (59 + 1)) == (0 + 0)) or (((1017 - (892 + 65)) % v37) == (0 - 0)))) then
		v43 = 1 - 0;
	end
	v44 = 0.5 - 0;
	if (v42 and (((v38 % (410 - (87 + 263))) == (180 - (67 + 113))) or (((44 + 16) % v38) == (0 - 0)))) then
		v44 = 1 + 0;
	end
	v45 = (v29 == v25.SpymastersWeb:ID()) or (v29 == v25.AberrantSpellforge:ID()) or (v29 == v25.KahetiShadowweaversEmblem:ID());
	v46 = (v30 == v25.SpymastersWeb:ID()) or (v30 == v25.AberrantSpellforge:ID()) or (v30 == v25.KahetiShadowweaversEmblem:ID());
	v47 = v29 == (770084 - 576327);
	v48 = v30 == (194709 - (802 + 150));
	v49 = v27:BuffDuration() + (v15(v29 == (558878 - 351297)) * (36 - 16));
	v50 = v28:BuffDuration() + (v15(v30 == (151096 + 56485)) * (1017 - (915 + 82)));
	local v148 = ((v49 > (0 - 0)) and v49) or (1 + 0);
	local v149 = ((v50 > (0 - 0)) and v50) or (1188 - (1069 + 118));
	v51 = 2 - 1;
	if ((not v41 and v42) or (v42 and (((v38 / v149) * v44) > ((v37 / v148) * v43)))) then
		v51 = 3 - 1;
	end
end
v75();
v3:RegisterForEvent(function()
	v24.SeedofCorruption:RegisterInFlight();
	v24.ShadowBolt:RegisterInFlight();
	v24.Haunt:RegisterInFlight();
	v67 = ((v24.DrainSoulTalent:IsAvailable()) and v24.DrainSoul) or v24.ShadowBolt;
	v68 = (v24.DrainSoul:IsLearned() and v24.ShadowEmbraceDSDebuff) or v24.ShadowEmbraceSBDebuff;
	v69 = (v24.DrainSoul:IsLearned() and (1 + 3)) or (3 - 1);
end, "SPELLS_CHANGED", "LEARNED_SPELL_IN_TAB");
v24.SeedofCorruption:RegisterInFlight();
v24.ShadowBolt:RegisterInFlight();
v24.Haunt:RegisterInFlight();
v3:RegisterForEvent(function()
	v75();
end, "PLAYER_EQUIPMENT_CHANGED");
v3:RegisterForEvent(function()
	v71 = 11023 + 88;
	v72 = 11902 - (368 + 423);
end, "PLAYER_REGEN_ENABLED");
local function v76(v150, v151)
	if (not v150 or not v151) then
		return 0 - 0;
	end
	local v152;
	for v201, v202 in pairs(v150) do
		local v203 = v202:DebuffRemains(v151) + ((117 - (10 + 8)) * v15(v202:DebuffDown(v151)));
		if ((v152 == nil) or (v203 < v152)) then
			v152 = v203;
		end
	end
	return v152 or (0 - 0);
end
local function v77(v153)
	if (not v153 or (#v153 == (442 - (416 + 26)))) then
		return false;
	end
	if (v24.SeedofCorruption:InFlight() or v6:PrevGCDP(3 - 2, v24.SeedofCorruption)) then
		return false;
	end
	local v154 = 0 + 0;
	local v155 = 0 - 0;
	for v204, v205 in pairs(v153) do
		v154 = v154 + (439 - (145 + 293));
		if v205:DebuffUp(v24.SeedofCorruptionDebuff) then
			v155 = v155 + (431 - (44 + 386));
		end
	end
	return v154 == v155;
end
local function v78()
	return v21.GuardiansTable.DarkglareDuration > (1486 - (998 + 488));
end
local function v79()
	return v21.GuardiansTable.DarkglareDuration;
end
local function v80(v156)
	return v156:DebuffRemains(v24.AgonyDebuff);
end
local function v81(v157)
	return v157:DebuffRemains(v24.CorruptionDebuff);
end
local function v82(v158)
	return v158:DebuffRemains(v68);
end
local function v83(v159)
	return v159:DebuffRemains(v24.WitherDebuff);
end
local function v84(v160)
	return ((v160:DebuffRemains(v24.AgonyDebuff) < (v24.VileTaint:CooldownRemains() + v24.VileTaint:CastTime())) or not v24.VileTaint:IsAvailable() or not IsVileTaint) and (v160:DebuffRemains(v24.AgonyDebuff) < (4 + 6));
end
local function v85(v161)
	return ((v161:DebuffRemains(v24.AgonyDebuff) < (v24.VileTaint:CooldownRemains() + v24.VileTaint:CastTime())) or not v24.VileTaint:IsAvailable()) and ((v161:DebuffRemains(v24.AgonyDebuff) < (v6:GCD() * (2 + 0))) or (v24.DemonicSoul:IsAvailable() and (v161:DebuffRemains(v24.AgonyDebuff) < (v24.SoulRot:CooldownRemains() + (780 - (201 + 571)))) and (v24.SoulRot:CooldownRemains() < (1143 - (116 + 1022))))) and (v72 > (v161:DebuffRemains(v24.AgonyDebuff) + (20 - 15)));
end
local function v86(v162)
	return v162:DebuffRemains(v24.CorruptionDebuff) < (3 + 2);
end
local function v87(v163)
	return (v163:DebuffRemains(v24.CorruptionDebuff) < (18 - 13)) and not (v24.SeedofCorruption:InFlight() or v163:DebuffUp(v24.SeedofCorruptionDebuff)) and (v72 > (v163:DebuffRemains(v24.CorruptionDebuff) + (17 - 12)));
end
local function v88(v164)
	return (v24.ShadowEmbrace:IsAvailable() and ((v164:DebuffStack(v68) < (862 - (814 + 45))) or (v164:DebuffRemains(v68) < (7 - 4)))) or not v24.ShadowEmbrace:IsAvailable();
end
local function v89(v165)
	return (v24.ShadowEmbrace:IsAvailable() and ((v165:DebuffStack(v68) < (1 + 3)) or (v165:DebuffRemains(v68) < (2 + 1)))) or not v24.ShadowEmbrace:IsAvailable();
end
local function v90(v166)
	return (v166:DebuffStack(v68) < v69) or v166:DebuffRemains(v68);
end
local function v91(v167)
	return (v24.ShadowEmbrace:IsAvailable() and ((v167:DebuffStack(v68) < (887 - (261 + 624))) or (v167:DebuffRemains(v68) < (4 - 1)))) or not v24.ShadowEmbrace:IsAvailable();
end
local function v92(v168)
	return ((v168:DebuffStack(v68) + v15(v24.ShadowBolt:InFlight())) < v69) or ((v168:DebuffRemains(v68) < (1083 - (1020 + 60))) and not v24.ShadowBolt:InFlight());
end
local function v93(v169)
	return v169:DebuffRemains(v24.WitherDebuff) < (1428 - (630 + 793));
end
local function v94(v170)
	return (v170:DebuffRemains(v24.WitherDebuff) < (16 - 11)) and not (v24.SeedofCorruption:InFlight() or v170:DebuffUp(v24.SeedofCorruptionDebuff)) and (v72 > (v170:DebuffRemains(v24.WitherDebuff) + (23 - 18)));
end
local function v95(v171)
	return v171:DebuffRefreshable(v24.AgonyDebuff);
end
local function v96(v172)
	return v172:DebuffRefreshable(v24.CorruptionDebuff);
end
local function v97(v173)
	return (v173:DebuffStack(v68) < (2 + 2)) or (v173:DebuffRemains(v68) < (9 - 6));
end
local function v98(v174)
	return (v24.ShadowEmbrace:IsAvailable() and ((v174:DebuffStack(v68) < (1751 - (760 + 987))) or (v174:DebuffRemains(v68) < (1916 - (1789 + 124))))) or not v24.ShadowEmbrace:IsAvailable();
end
local function v99(v175)
	return (v175:DebuffStack(v68) < (768 - (745 + 21))) or (v175:DebuffRemains(v68) < (2 + 1));
end
local function v100(v176)
	return v176:DebuffRefreshable(v24.WitherDebuff);
end
local function v101(v177)
	return ((not v24.Wither:IsAvailable() and (v177:DebuffRemains(v24.CorruptionDebuff) < (13 - 8))) or (v24.Wither:IsAvailable() and (v177:DebuffRemains(v24.WitherDebuff) < (19 - 14)))) and not (v24.SeedofCorruption:InFlight() or (v177:DebuffRemains(v24.SeedofCorruptionDebuff) > (0 + 0)));
end
local function v102(v178)
	local v179 = v54;
	local v180 = v24.CorruptionDebuff:AuraActiveCount() + v24.WitherDebuff:AuraActiveCount();
	return ((v179 - v180) >= (4 + 1)) and not (v24.SeedofCorruption:InFlight() or (v178:DebuffRemains(v24.SeedofCorruptionDebuff) > (1055 - (87 + 968))));
end
local function v103(v181)
	return v181:NPCID() == (900461 - 695901);
end
local function v104(v182)
	return v182:CastSpellID() == (370895 + 37910);
end
local function v105()
	return (v11:Exists() or not v23.Affliction.CursorCheck) and not v6:IsCameraBusy();
end
local v106 = nil;
local function v107()
	if v6:IsMoving() then
		if not v106 then
			v106 = GetTime();
		end
		return GetTime() - v106;
	else
		if v106 then
			v106 = nil;
		end
		return 0 - 0;
	end
end
local v108 = nil;
local function v109()
	if (Currentpet == nil) then
		if not v108 then
			v108 = GetTime();
		end
		return GetTime() - v108;
	else
		if (Currentpet ~= nil) then
			v108 = nil;
		end
		return 1413 - (447 + 966);
	end
end
local function v110(v183, v184)
	return (v183:gsub("{(.-)}", v184));
end
local function v111(v185, v186)
	if Shouldskip then
		if v12.Cast(v185, true) then
			return "HR skip cast";
		end
	end
	if v12.Cast(v185) then
		return "normal cast";
	end
end
local function v112()
	if v20.TargetIsValid() then
		local v206 = v8:MinDistance() or (13 - 8);
		local v207 = v8:MaxDistance() or (1857 - (1703 + 114));
		v206 = math.max(v206 - (709 - (376 + 325)), 8 - 3);
		v207 = math.min(v207 + (24 - 16), 12 + 28);
		local v208 = v6:GetEnemiesInRange(v206);
		local v209 = v6:GetEnemiesInRange(v207);
		local v210 = #v209;
		if ((v207 - v206) > (34 - 18)) then
			v210 = v210 - #v208;
		end
		v210 = math.max(v210, 15 - (9 + 5));
		return v210;
	else
		return #(v6:GetEnemiesInRange(416 - (85 + 291)));
	end
end
local v113;
local function v114(v187)
	return (v187 ~= "Not Used") and ((((v187 == "with Cooldowns") or ((v187 == "small CDs") and v23.Affliction_CDUSE.smallcdswithCooldowns) or (v187 == "with Cooldowns or AoE") or (v187 == "on Enemycount or Cooldowns") or (v187 == "on Boss or with Cooldowns")) and v14()) or (v187 == "always") or (((v187 == "on Boss only") or (v187 == "on Boss or on Enemycount") or (v187 == "on Boss or with Cooldowns")) and (v113 or v8:IsDummy())) or ((v187 == "with Bloodlust only") and v6:BloodlustUp()) or ((v187 == "small CDs") and Smallcds) or (((v187 == "on AOE") or (v187 == "with Cooldowns or AoE")) and (v54 > (1267 - (243 + 1022))) and v13()) or (((v187 == "on Enemycount or Cooldowns") or (v187 == "on Enemycount") or (v187 == "on Boss or on Enemycount")) and (v54 >= v23.Affliction_CDUSE.Enemycount) and v13()));
end
local function v115(v188)
	return (v113 and v23.Affliction_TTD.IgnoreWhenBoss) or v20.Buggedmobs[v8:NPCID()] or (v20.ISSolo() and v23.Affliction_TTD.IgnoreWhenSolo) or (v188 == (0 - 0)) or ((v72 >= v188) and (v72 < (6416 + 1361)));
end
local function v116()
	local v189 = nil;
	local v190 = v24.SpellLock:CooldownRemains();
	local v191 = v24.SingeMagic:CooldownRemains();
	local v192 = v24.ShadowBulwark:CooldownRemains();
	local v193 = v24.Seduction:CooldownRemains();
	if ((not v7:IsActive() or (v7:HealthPercentage() < (1181 - (1123 + 57)))) and not v6:BuffUp(v24.GrimoireofSacrificeBuff)) then
		v189 = nil;
	elseif ((v6:Level() <= (25 + 5)) and v7:IsActive()) then
		v189 = "Leveling";
	elseif (v24.SpellLock:IsReady() or ((v190 <= (278 - (163 + 91))) and not ((v190 == (1930 - (1869 + 61))) and not v24.SpellLock:IsReady()))) then
		v189 = "Felhunter";
	elseif (v24.SingeMagic:IsReady() or ((v191 <= (5 + 10)) and not ((v191 == (0 - 0)) and not v24.SingeMagic:IsReady()))) then
		v189 = "Imp";
	elseif (v24.ShadowBulwark:IsReady() or ((v192 <= (184 - 64)) and not ((v192 == (0 + 0)) and not v24.ShadowBulwark:IsReady()))) then
		v189 = "Voidwalker";
	elseif (v24.Seduction:IsReady() or ((v193 <= (41 - 11)) and not ((v193 == (0 + 0)) and not v24.Seduction:IsReady()))) then
		v189 = "Sayaad";
	end
	return v189;
end
local function v117()
	Currentpet = v116();
end
local function v118()
	local v194 = v23.Affliction_Pets.PetSelected;
	local v195 = v116();
	if ((v194 == "Imp") and (v195 ~= "Imp") and (v195 ~= "Leveling")) then
		if (v24.SummonImp:IsCastable() and not v6:IsMoving() and not v6:IsCasting(v24.SummonImp) and not v6:PrevGCDP(1475 - (1329 + 145), v24.SummonImp) and not (v6:IsMounted() or v6:IsInVehicle())) then
			if v111(v24.SummonImp, false) then
				return "summon Imp";
			end
		end
	elseif ((v194 == "Voidwalker") and (v195 ~= "Voidwalker") and (v195 ~= "Leveling")) then
		if (v24.SummonVoidwalker:IsCastable() and not v6:IsMoving() and not v6:IsCasting(v24.SummonVoidwalker) and not v6:PrevGCDP(972 - (140 + 831), v24.SummonVoidwalker) and not (v6:IsMounted() or v6:IsInVehicle())) then
			if v111(v24.SummonVoidwalker, false) then
				return "summon Voidwalker";
			end
		end
	elseif ((v194 == "Felhunter") and (v195 ~= "Felhunter") and (v195 ~= "Leveling")) then
		if (v24.SummonFelhunter:IsCastable() and not v6:IsMoving() and not v6:IsCasting(v24.SummonFelhunter) and not v6:PrevGCDP(1851 - (1409 + 441), v24.SummonFelhunter) and not (v6:IsMounted() or v6:IsInVehicle())) then
			if v111(v24.SummonFelhunter, false) then
				return "summon Felhunter";
			end
		end
	elseif ((v194 == "Sayaad") and (v195 ~= "Sayaad") and (v195 ~= "Leveling")) then
		if (v24.SummonSayaad:IsCastable() and not v6:IsMoving() and not v6:IsCasting(v24.SummonSayaad) and not v6:PrevGCDP(719 - (15 + 703), v24.SummonSayaad) and not (v6:IsMounted() or v6:IsInVehicle())) then
			if v111(v24.SummonSayaad, false) then
				return "summon Sayaad";
			end
		end
	end
	return false;
end
local function v119()
	if (v24.UnendingResolve:IsCastable() and v6:AffectingCombat() and (v6:HealthPercentage() <= v23.Defensives.UnendingResolveHP)) then
		if v111(v24.UnendingResolve) then
			return "UnendingResolve";
		end
	end
	if (v24.DarkPact:IsCastable() and v6:AffectingCombat() and (v6:HealthPercentage() <= v23.Defensives.DarkPactHP)) then
		if v111(v24.DarkPact) then
			return "DarkPact";
		end
	end
	if (v24.HealthFunnel:IsCastable() and not v6:IsMoving() and (v7:HealthPercentage() <= v23.Defensives.HealthFunnelHP) and (v7:HealthPercentage() > (0 + 0))) then
		if v111(v24.HealthFunnel) then
			return "HealthFunnel";
		end
	end
	if (v24.DrainLife:IsCastable() and v6:AffectingCombat() and v8:IsInRange(478 - (262 + 176)) and v6:CanAttack(v8) and v6:AffectingCombat() and not v6:IsMoving() and (v6:HealthPercentage() <= v23.Defensives.DrainLifeHP)) then
		if v111(v24.DrainLife) then
			return "DrainLife";
		end
	end
	if (v24.MortalCoil:IsReady() and v6:AffectingCombat() and v8:IsInRange(1741 - (345 + 1376)) and v6:CanAttack(v8) and (v6:HealthPercentage() <= v23.Defensives.MortalCoilHP)) then
		if v111(v24.MortalCoil) then
			return "MortalCoil";
		end
	end
end
local function v120()
	if (v24.SeedofCorruption:IsReady() and not v6:IsMoving() and ((v54 > (690 - (198 + 490))) or ((v54 > (4 - 3)) and v24.DemonicSoul:IsAvailable()))) then
		if v20.CastCycle(v24.SeedofCorruption, v53, v101, 95 - 55, Shouldskip, nil, nil, true) then
			return "Seed_of_Corruption precombat 2";
		end
	end
	if (v24.Haunt:IsReady() and not v6:IsMoving()) then
		if v111(v24.Haunt) then
			return "haunt precombat 4";
		end
	end
	if (v24.UnstableAffliction:IsReady() and not v6:IsMoving()) then
		if v111(v24.UnstableAffliction) then
			return "unstable_affliction precombat 6";
		end
	end
end
local function v121()
	if v23.Commons.Enabled.Trinkets then
		if (v25.AberrantSpellforge:IsEquippedAndReady() and (((v27:ID() == v25.AberrantSpellforge:ID()) and IsTrinket1) or ((v28:ID() == v25.AberrantSpellforge:ID()) and IsTrinket2))) then
			if v111(v25.AberrantSpellforge, true) then
				return "aberrant_spellforge items 2";
			end
		end
		if (v25.SpymastersWeb:IsEquippedAndReady() and (((v27:ID() == v25.SpymastersWeb:ID()) and IsTrinket1) or ((v28:ID() == v25.SpymastersWeb:ID()) and IsTrinket2)) and ((v59 and ((v6:BuffStack(v24.SpymastersReportBuff) >= (1244 - (696 + 510))) or (v72 <= (167 - 87)) or (v24.DrainSoul:IsAvailable() and (v8:HealthPercentage() < (1282 - (1091 + 171)))))) or (v71 < (4 + 16)))) then
			if v111(v25.SpymastersWeb, true) then
				return "spymasters_web items 4";
			end
		end
		if (v25.KahetiShadowweaversEmblem:IsEquippedAndReady() and (((v27:ID() == v25.KahetiShadowweaversEmblem:ID()) and IsTrinket1) or ((v28:ID() == v25.KahetiShadowweaversEmblem:ID()) and IsTrinket2)) and (v6:BuffStack(v24.KahetiShadowweaversEmblemBuff) >= (15 - 10))) then
			if v111(v25.KahetiShadowweaversEmblem, true) then
				return "Kaheti_Shadowweavers_Emblem items 5";
			end
		end
		if (v25.MadQueensMandate:IsEquippedAndReady() and (((v27:ID() == v25.MadQueensMandate:ID()) and IsTrinket1) or ((v28:ID() == v25.MadQueensMandate:ID()) and IsTrinket2))) then
			if v111(v25.MadQueensMandate, true) then
				return "MadQueensMandate items 5";
			end
		end
		if (v27:IsReady() and v8:IsInRange(v33) and IsTrinket1 and not v39 and ((v61 and ((v51 == (3 - 2)) or v48 or not v28:HasCooldown() or v28:CooldownDown() or ((v51 == (376 - (123 + 251))) and (v24.SummonDarkglare:CooldownRemains() > (99 - 79)) and not v78() and (v28:CooldownRemains() < v24.SummonDarkglare:CooldownRemains()))) and v41 and not v45) or ((v49 + (699 - (208 + 490))) >= v71))) then
			if v111(v27, true) then
				return "trinket1 (" .. v27:Name() .. ") items 6";
			end
		end
		if (v28:IsReady() and v8:IsInRange(v34) and IsTrinket2 and not v40 and ((v61 and ((v51 == (1 + 1)) or v47 or not v27:HasCooldown() or v27:CooldownDown() or ((v51 == (1 + 0)) and (v24.SummonDarkglare:CooldownRemains() > (856 - (660 + 176))) and not v78() and (v27:CooldownRemains() < v24.SummonDarkglare:CooldownRemains()))) and v42 and not v46) or ((v50 + 1 + 0) >= v71))) then
			if v111(v28, true) then
				return "trinket2 (" .. v28:Name() .. ") items 8";
			end
		end
		if (v25.TimeThiefsGambit:IsEquippedAndReady() and (((v27:ID() == v25.TimeThiefsGambit:ID()) and IsTrinket1) or ((v28:ID() == v25.TimeThiefsGambit:ID()) and IsTrinket2)) and (v61 or (v71 < (217 - (14 + 188))) or ((v27:Cooldown() < (v24.SummonDarkglare:CooldownRemains() + (680 - (534 + 141)))) and (v54 == (1 + 0))) or (v54 > (1 + 0)))) then
			if v111(v25.TimeThiefsGambit, true) then
				return "time_thiefs_gambit items 10";
			end
		end
		if (v27:IsReady() and v8:IsInRange(v33) and IsTrinket1 and not v39 and not v41 and not v45 and ((not v41 and (v28:CooldownDown() or not v42)) or (v24.SummonDarkglare:IsAvailable() and (v24.SummonDarkglare:CooldownRemains() > (20 + 0))) or not v24.SummonDarkglare:IsAvailable())) then
			if v111(v27, true) then
				return "trinket1 (" .. v27:Name() .. ") items 12";
			end
		end
		if (v28:IsReady() and v8:IsInRange(v34) and IsTrinket2 and not v40 and not v42 and not v46 and ((not v42 and (v27:CooldownDown() or not v41)) or (v24.SummonDarkglare:IsAvailable() and (v24.SummonDarkglare:CooldownRemains() > (42 - 22))) or not v24.SummonDarkglare:IsAvailable())) then
			if v111(v28, true) then
				return "trinket2 (" .. v28:Name() .. ") items 12";
			end
		end
	end
	if v23.Commons.Enabled.Items then
		local v211, v212, v213 = v6:GetUseableItems(v26, 25 - 9);
		if (v211 and v211:IsReady() and v8:IsInRange(v213)) then
			v12.CastMacro(2 - 1, nil, nil, v211);
			return "weapon cast";
		end
	end
end
local function v122()
	local v196 = v6:PrevGCDP(1 + 0, v24.SoulRot) and (v3.CombatTime() < (13 + 7));
	if (v23.Commons.Enabled.Potions and IsPotions) then
		local v214 = v20.PotionSelected();
		if (v214 and v214:IsReady()) then
			v12.CastMacro(399 - (115 + 281), nil, nil, v214);
			return "Cast Potion";
		end
	end
	if (v24.Berserking:IsCastable() and IsRacials and (v61 or (v71 < (32 - 18)) or v196)) then
		if v111(v24.Berserking, true) then
			return "berserking ogcd 4";
		end
	end
	if (v24.BloodFury:IsCastable() and IsRacials and (v61 or (v71 < (15 + 2)) or v196)) then
		if v111(v24.BloodFury, true) then
			return "blood_fury ogcd 6";
		end
	end
	if (v24.Fireblood:IsCastable() and IsRacials and (v61 or (v71 < (24 - 14)) or v196)) then
		if v111(v24.Fireblood, true) then
			return "fireblood ogcd 8";
		end
	end
	if (v24.AncestralCall:IsCastable() and IsRacials and (v61 or (v71 < (62 - 45)) or v196)) then
		if v111(v24.AncestralCall, true) then
			return "ancestral_call ogcd 10";
		end
	end
end
local function v123()
	if (v24.DrainSoul:IsReady() and not v6:IsMoving() and v24.DemonicSoul:IsAvailable() and (((v71 < (872 - (550 + 317))) and v6:BuffUp(v24.NightfallBuff)) or (v6:PrevGCDP(1 - 0, v24.Haunt) and (v6:BuffStack(v24.NightfallBuff) == (2 - 0)) and v6:BuffDown(v24.TormentedCrescendoBuff)))) then
		if v12.Cast(v24.DrainSoul) then
			return "drain_soul end_of_fight 2";
		end
	end
	if (v24.Oblivion:IsReady() and IsOblivion and (v70 > (2 - 1)) and (v71 < (((v70 + v6:BuffStack(v24.TormentedCrescendoBuff)) * v73) + v24.Oblivion:ExecuteTime()))) then
		if v111(v24.Oblivion) then
			return "oblivion end_of_fight 4";
		end
	end
	if (v24.MaleficRapture:IsReady() and (not v6:IsMoving() or v6:BuffUp(v24.TormentedCrescendoBuff)) and (v71 < (289 - (134 + 151))) and (not v24.DemonicSoul:IsAvailable() or (v24.DemonicSoul:IsAvailable() and v6:BuffDown(v24.NightfallBuff)))) then
		if v111(v24.MaleficRapture) then
			return "malefic_rapture end_of_fight 6";
		end
	end
end
local function v124()
	v19 = v122();
	if v19 then
		return v19;
	end
	if (v23.Commons.Enabled.Trinkets or v23.Commons.Enabled.Items) then
		v19 = v121();
		if v19 then
			return v19;
		end
	end
	if (v24.SeedofCorruption:IsReady() and not v6:IsMoving()) then
		if v20.CastCycle(v24.SeedofCorruption, v53, v102, 1705 - (970 + 695), Shouldskip, nil, nil, true) then
			return "Seed of Corruption aoe high prio";
		end
	end
	if (v24.Haunt:IsReady() and not v6:IsMoving() and (v8:DebuffRemains(v24.HauntDebuff) < (5 - 2))) then
		if v111(v24.Haunt) then
			return "haunt aoe 2";
		end
	end
	if (v24.VileTaint:IsReady() and IsVileTaint and not v6:IsMoving() and ((v24.SoulRot:CooldownRemains() <= v24.VileTaint:ExecuteTime()) or (v24.SoulRot:CooldownRemains() >= (2015 - (582 + 1408))))) then
		if v111(v24.VileTaint, true) then
			return "vile_taint aoe 4";
		end
	end
	if (v24.PhantomSingularity:IsCastable() and IsPhantomSingularity and ((v24.SoulRot:CooldownRemains() <= v24.PhantomSingularity:ExecuteTime()) or (v24.SoulRot:CooldownRemains() >= (86 - 61)) or not IsSoulRot) and v8:DebuffUp(v24.AgonyDebuff)) then
		if v111(v24.PhantomSingularity, true) then
			return "phantom_singularity aoe 6";
		end
	end
	if (v24.UnstableAffliction:IsReady() and not v6:IsMoving() and (v8:DebuffRemains(v24.UnstableAfflictionDebuff) < (6 - 1))) then
		if v111(v24.UnstableAffliction) then
			return "unstable_affliction aoe 8";
		end
	end
	if (v24.Agony:IsReady() and (v24.AgonyDebuff:AuraActiveCount() < (30 - 22)) and ((v73 + v24.SoulRot:CastTime() + v73) < (v64 * v17(v15(v24.VileTaint:IsAvailable()), v65) * v15(v24.PhantomSingularity:IsAvailable())))) then
		if v20.CastTargetIf(v24.Agony, v52, "min", v80, v84, 1864 - (1195 + 629), Shouldskip) then
			return "agony aoe 10";
		end
	end
	if (v24.SoulRot:IsReady() and IsSoulRot and not v6:IsMoving() and v56 and (v55 or v56) and v8:DebuffUp(v24.AgonyDebuff)) then
		if v111(v24.SoulRot) then
			return "soul_rot aoe 12";
		end
	end
	if (v24.Malevolence:IsReady() and IsMalevolence and v55 and v56 and v58) then
		if v111(v24.Malevolence, true) then
			return "malevolence aoe 14";
		end
	end
	if (v24.SeedofCorruption:IsReady() and not v6:IsMoving()) then
		if v20.CastCycle(v24.SeedofCorruption, v53, v101, 52 - 12, Shouldskip, nil, nil, true) then
			return "Seed of Corruption aoe 16";
		end
	end
	if (v24.Corruption:IsReady() and not v24.SeedofCorruption:IsAvailable()) then
		if v20.CastTargetIf(v24.Corruption, v52, "min", v81, v86, 281 - (187 + 54), Shouldskip) then
			return "corruption aoe 18";
		end
	end
	if (v24.WitherAbility:IsReady() and not v24.SeedofCorruption:IsAvailable()) then
		if v20.CastTargetIf(v24.WitherAbility, v52, "min", v83, v93, 820 - (162 + 618), Shouldskip) then
			return "wither aoe 20";
		end
	end
	if (v24.SummonDarkglare:IsCastable() and IsSummonDarkglare and v55 and v56 and v58) then
		if v111(v24.SummonDarkglare, true) then
			return "summon_darkglare aoe 22";
		end
	end
	if (v24.MaleficRapture:IsReady() and (not v6:IsMoving() or v6:BuffUp(v24.TormentedCrescendoBuff)) and ((((v24.SummonDarkglare:CooldownRemains() > (11 + 4)) or (v70 > (2 + 1)) or (v24.DemonicSoul:IsAvailable() and (v70 > (3 - 1)))) and v6:BuffUp(v24.TormentedCrescendoBuff)) or (v70 > (6 - 2)) or (v24.TormentedCrescendo:IsAvailable() and (v6:BuffStack(v24.TormentedCrescendoBuff) == (1 + 0)) and (v70 > (1639 - (1373 + 263)))) or (v24.DemonicSoul:IsAvailable() and ((v70 > (1002 - (451 + 549))) or (v24.TormentedCrescendo:IsAvailable() and (v6:BuffStack(v24.TormentedCrescendoBuff) == (1 + 0)) and (v70 > (0 - 0))))) or (v24.TormentedCrescendo:IsAvailable() and v6:BuffUp(v24.TormentedCrescendoBuff)) or ((v59 or v57) and ((v70 > (2 - 0)) or (v24.Oblivion:CooldownRemains() > (1394 - (746 + 638))) or not v24.Oblivion:IsAvailable())) or (v24.TormentedCrescendo:IsAvailable() and v24.Nightfall:IsAvailable() and v6:BuffUp(v24.TormentedCrescendoBuff) and v6:BuffUp(v24.NightfallBuff)))) then
		if v111(v24.MaleficRapture) then
			return "malefic_rapture aoe 24";
		end
	end
	if (v24.DrainSoul:IsReady() and not v6:IsMoving() and v6:BuffUp(v24.NightfallBuff) and v24.ShadowEmbrace:IsAvailable() and ((v8:DebuffStack(v68) < (2 + 2)) or (v8:DebuffRemains(v68) < (4 - 1)))) then
		if v12.Cast(v24.DrainSoul) then
			return "drain_soul aoe 26";
		end
	end
	if (v24.DrainSoul:IsReady() and not v6:IsMoving()) then
		if v12.Cast(v24.DrainSoul) then
			return "drain_soul aoe 28";
		end
	end
	if (v24.ShadowBolt:IsReady() and not v6:IsMoving()) then
		if v111(v24.ShadowBolt) then
			return "shadow_bolt aoe 30";
		end
	end
end
local function v125()
	if (v24.DrainSoul:IsReady() and not v6:IsMoving() and v24.ShadowEmbrace:IsAvailable() and v6:BuffUp(v24.NightfallBuff) and ((v8:DebuffStack(v68) < v69) or (v8:DebuffRemains(v68) < (344 - (218 + 123)))) and ((v72 > (1596 - (1535 + 46))) or (v3.CombatTime() < (20 + 0)))) then
		if v12.Cast(v24.DrainSoul) then
			return "drain_soul opener_cleave_se 2";
		end
	end
end
local function v126()
	if (v24.DrainSoul:IsReady() and not v6:IsMoving() and v24.ShadowEmbrace:IsAvailable() and (v24.Wither:IsAvailable() or (v24.DemonicSoul:IsAvailable() and v6:BuffUp(v24.NightfallBuff))) and (v72 > (3 + 12))) then
		if v20.CastTargetIf(v24.DrainSoul, v53, "min", v82, v90, 600 - (306 + 254)) then
			return "drain_soul cleave_se_maintenance 2";
		end
	end
	if (v24.ShadowBolt:IsReady() and not v6:IsMoving() and v24.ShadowEmbrace:IsAvailable() and not v24.DrainSoul:IsAvailable() and (v72 > (1 + 14))) then
		if v20.CastTargetIf(v24.ShadowBolt, v53, "min", v82, v92, 78 - 38) then
			return "shadow_bolt cleave_se_maintenance 4";
		end
	end
end
local function v127()
	local v197 = v122();
	if v197 then
		return v197;
	end
	if (v23.Commons.Enabled.Trinkets or v23.Commons.Enabled.Items) then
		local v215 = v121();
		if v215 then
			return v215;
		end
	end
	local v197 = v123();
	if v197 then
		return v197;
	end
	if v24.Agony:IsReady() then
		if v20.CastTargetIf(v24.Agony, v52, "min", v80, v85, 1507 - (899 + 568), Shouldskip) then
			return "agony cleave 2";
		end
	end
	if v24.WitherAbility:IsReady() then
		if v20.CastTargetIf(v24.WitherAbility, v52, "min", v83, v94, 27 + 13, Shouldskip) then
			return "wither cleave 4";
		end
	end
	if (v24.Haunt:IsReady() and not v6:IsMoving() and ((v24.DemonicSoul:IsAvailable() and (v6:BuffStack(v24.NightfallBuff) < ((4 - 2) - v15(v6:PrevGCDP(604 - (268 + 335), v24.DrainSoul)))) and (not v24.VileTaint:IsAvailable() or v24.VileTaint:CooldownDown())) or v8:DebuffRemains(v24.HauntDebuff))) then
		if v111(v24.Haunt) then
			return "haunt cleave 6";
		end
	end
	if (v24.UnstableAffliction:IsReady() and not v6:IsMoving() and ((v8:DebuffRemains(v24.UnstableAfflictionDebuff) < (295 - (60 + 230))) or (v24.DemonicSoul:IsAvailable() and (v8:DebuffRemains(v24.UnstableAfflictionDebuff) < (v24.SoulRot:CooldownRemains() + (580 - (426 + 146)))) and (v24.SoulRot:CooldownRemains() < (1 + 4)))) and (v72 > (v8:DebuffRemains(v24.UnstableAfflictionDebuff) + (1461 - (282 + 1174))))) then
		if v111(v24.UnstableAffliction) then
			return "unstable_affliction cleave 8";
		end
	end
	if v24.Corruption:IsReady() then
		if v20.CastTargetIf(v24.Corruption, v52, "min", v81, v87, 851 - (569 + 242), Shouldskip) then
			return "corruption cleave 10";
		end
	end
	if v24.Wither:IsAvailable() then
		local v216 = v126();
		if v216 then
			return v216;
		end
	end
	if (v24.VileTaint:IsReady() and not v6:IsMoving() and IsVileTaint and (not v24.SoulRot:IsAvailable() or (v63 < (2.5 - 1)) or (v24.SoulRot:CooldownRemains() <= (v24.VileTaint:ExecuteTime() + v73)) or (v24.SoulRot:CooldownRemains() >= (2 + 18)))) then
		if v111(v24.VileTaint, true) then
			return "vile_taint cleave 12";
		end
	end
	if (v24.PhantomSingularity:IsReady() and IsPhantomSingularity and (not v24.SoulRot:IsAvailable() or (v24.SoulRot:CooldownRemains() < (1028 - (706 + 318))) or (v72 < v24.SoulRot:CooldownRemains())) and (v24.AgonyDebuff:AuraActiveCount() == (1253 - (721 + 530)))) then
		if v111(v24.PhantomSingularity, true) then
			return "phantom_singularity cleave 14";
		end
	end
	if v57 then
		if (v24.Malevolence:IsReady() and IsMalevolence) then
			if v111(v24.Malevolence, true) then
				return "malevolence cleave 16";
			end
		end
		if (v24.SoulRot:IsReady() and not v6:IsMoving() and IsSoulRot and (v24.AgonyDebuff:AuraActiveCount() == (1273 - (945 + 326)))) then
			if v111(v24.SoulRot) then
				return "soul_rot cleave 18";
			end
		end
	end
	if (v24.SummonDarkglare:IsReady() and IsSummonDarkglare and v59) then
		if v111(v24.SummonDarkglare, true) then
			return "summon_darkglare cleave 20";
		end
	end
	if v24.DemonicSoul:IsAvailable() then
		local v217 = v125();
		if v217 then
			return v217;
		end
		local v217 = v126();
		if v217 then
			return v217;
		end
	end
	if (v24.MaleficRapture:IsReady() and (not v6:IsMoving() or v6:BuffUp(v24.TormentedCrescendoBuff)) and (((v70 > (9 - 5)) and ((v24.DemonicSoul:IsAvailable() and (v6:BuffStack(v24.NightfallBuff) < (2 + 0))) or not v24.DemonicSoul:IsAvailable())) or (v6:BuffStack(v24.TormentedCrescendoBuff) > (701 - (271 + 429))))) then
		if v111(v24.MaleficRapture) then
			return "malefic_rapture cleave 22";
		end
	end
	if (v24.DrainSoul:IsReady() and not v6:IsMoving() and v24.DemonicSoul:IsAvailable() and v6:BuffUp(v24.NightfallBuff) and (v6:BuffStack(v24.TormentedCrescendoBuff) < (2 + 0)) and (v8:HealthPercentage() < (1520 - (1408 + 92)))) then
		if v12.Cast(v24.DrainSoul) then
			return "drain_soul cleave 24";
		end
	end
	if (v24.MaleficRapture:IsReady() and (not v6:IsMoving() or v6:BuffUp(v24.TormentedCrescendoBuff)) and ((v24.DemonicSoul:IsAvailable() and ((v70 > (1087 - (461 + 625))) or (v8:BuffUp(v24.TormentedCrescendoBuff) and (v24.SoulRot:CooldownRemains() > (v6:BuffRemains(v24.TormentedCrescendoBuff) * v73)))) and (not v24.VileTaint:IsAvailable() or ((v70 > (1289 - (993 + 295))) and (v24.VileTaint:CooldownRemains() > (1 + 9)))) and (not v24.Oblivion:IsAvailable() or (v24.Oblivion:CooldownRemains() > (1181 - (418 + 753))) or ((v70 > (1 + 1)) and (v24.Oblivion:CooldownRemains() < (2 + 8))))) or (v24.TormentedCrescendo:IsAvailable() and v6:BuffUp(v24.TormentedCrescendoBuff) and ((v6:BuffRemains(v24.TormentedCrescendoBuff) < (v73 * (1 + 1))) or (v6:BuffStack(v24.TormentedCrescendoBuff) == (1 + 1)))) or ((v59 or ((v24.DemonicSoul:IsAvailable() or v24.PhantomSingularity:IsAvailable()) and v57) or (v24.Wither:IsAvailable() and v57 and v8:DebuffDown(v24.SoulRotDebuff) and (v70 > (530 - (406 + 123))))) and (not v24.Oblivion:IsAvailable() or (v24.Oblivion:CooldownRemains() > (1779 - (1749 + 20))) or ((v70 > (1 + 1)) and (v24.Oblivion:CooldownRemains() < (1332 - (1249 + 73)))))) or (v24.TormentedCrescendo:IsAvailable() and v24.NightfallBuff:IsAvailable() and v6:BuffUp(v24.TormentedCrescendoBuff) and v6:BuffUp(v24.NightfallBuff)) or (v24.DemonicSoul:IsAvailable() and v6:BuffDown(v24.NightfallBuff) and (not v24.VileTaint:IsAvailable() or (v24.VileTaint:CooldownRemains() > (4 + 6)) or ((v70 > (1146 - (466 + 679))) and (v24.VileTaint:CooldownRemains() < (24 - 14))))) or (v24.DemonicSoul:IsAvailable() and v6:BuffUp(v24.TormentedCrescendoBuff)))) then
		if v111(v24.MaleficRapture) then
			return "malefic_rapture cleave 26";
		end
	end
	if (v24.Agony:IsReady() and (v8:DebuffRefreshable(v24.AgonyDebuff) or ((v24.SoulRot:CooldownRemains() < (14 - 9)) and v8:DebuffRemains(v24.AgonyDebuff)))) then
		if v111(v24.Agony) then
			return "agony cleave 28";
		end
	end
	if (v24.UnstableAffliction:IsReady() and not v6:IsMoving() and (v8:DebuffRefreshable(v24.UnstableAfflictionDebuff) or ((v24.SoulRot:CooldownRemains() < (1905 - (106 + 1794))) and (v8:DebuffRemains(v24.UnstableAfflictionDebuff) < (3 + 5))))) then
		if v111(v24.UnstableAffliction) then
			return "unstable_affliction cleave 30";
		end
	end
	if (v6:BuffUp(v24.NightfallBuff) and not v6:IsMoving()) then
		if v24.DrainSoul:IsReady() then
			if v12.Cast(v24.DrainSoul) then
				return "drain_soul cleave 32";
			end
		end
		if v24.ShadowBolt:IsReady() then
			if v111(v24.ShadowBolt) then
				return "shadow_bolt cleave 34";
			end
		end
	end
	if (v24.Wither:IsReady() and (v8:DebuffRefreshable(v24.WitherDebuff))) then
		if v111(v24.Wither) then
			return "wither cleave 36";
		end
	end
	if (v24.Corruption:IsReady() and (v8:DebuffRefreshable(v24.CorruptionDebuff))) then
		if v111(v24.Corruption) then
			return "corruption cleave 38";
		end
	end
	if (v24.DrainSoul:IsReady() and not v6:IsMoving()) then
		if v12.Cast(v24.DrainSoul) then
			return "drain_soul cleave 39";
		end
	end
	if (v24.ShadowBolt:IsReady() and not v6:IsMoving()) then
		if v111(v24.ShadowBolt) then
			return "shadow_bolt cleave 40";
		end
	end
end
local function v128()
	if (v24.DrainSoul:IsReady() and not v6:IsMoving() and v24.ShadowEmbrace:IsAvailable() and ((v8:DebuffStack(v68) < v69) or (v8:DebuffRemains(v68) < (1 + 2))) and (v54 <= (11 - 7)) and (v72 > (40 - 25))) then
		if v12.Cast(v24.DrainSoul) then
			return "drain_soul se_maintenance 2";
		end
	end
	if (v24.ShadowBolt:IsReady() and not v6:IsMoving() and v24.ShadowEmbrace:IsAvailable() and (((v8:DebuffStack(v68) + v15(v24.ShadowBolt:InFlight() or v6:IsCasting(v24.ShadowBolt))) < v69) or ((v8:DebuffRemains(v68) < (117 - (4 + 110))) and not v24.ShadowBolt:InFlight())) and (v54 <= (588 - (57 + 527))) and (v72 > (1442 - (41 + 1386)))) then
		if v111(v24.ShadowBolt) then
			return "shadow_bolt se_maintenance 4";
		end
	end
end
local function v129()
	v55 = not v24.PhantomSingularity:IsAvailable() or not IsPhantomSingularity or v8:DebuffUp(v24.PhantomSingularityDebuff);
	v56 = v8:DebuffUp(v24.VileTaintDebuff) or not v24.VileTaint:IsAvailable() or not IsVileTaint;
	v57 = (not (v24.VileTaint:IsAvailable() or IsVileTaint) and not (v24.PhantomSingularity:IsAvailable() or IsPhantomSingularity)) or v8:DebuffUp(v24.VileTaintDebuff) or v8:DebuffUp(v24.PhantomSingularityDebuff);
	v58 = v8:DebuffUp(v24.SoulRotDebuff) or not v24.SoulRot:IsAvailable() or not IsSoulRot;
	v59 = v55 and v56 and v58;
	v60 = (v24.PhantomSingularity:IsAvailable() and IsPhantomSingularity) or (v24.VileTaint:IsAvailable() and IsVileTaint) or (v24.SoulRot:IsAvailable() and IsSoulRot) or (v24.SummonDarkglare:IsAvailable() and IsSummonDarkglare);
	v61 = not v60 or (v59 and ((v24.SummonDarkglare:CooldownRemains() > (123 - (17 + 86))) or not v24.SummonDarkglare:IsAvailable() or not IsSummonDarkglare));
end
local function v130()
	if v20.ShouldStopCastUpdate() then
		v12.CastMacro(5 + 1, true);
		return "Stop Cast For Silence";
	end
	local v198 = v116();
	v107();
	v117();
	v109();
	BurningRushToggle = v12.ToggleIconFrame:GetToggle(1 - 0);
	InterruptToggle = v12.ToggleIconFrame:GetToggle(5 - 3);
	Smallcds = v12.ToggleIconFrame:GetToggle(169 - (122 + 44));
	v52 = v6:GetEnemiesInRange(69 - 29);
	EnemiesRangeOOCCount = v112() or #v52;
	v53 = v8:GetEnemiesInSplashRange(33 - 23);
	if v13() then
		v54 = EnemiesRangeOOCCount;
	else
		v54 = 1 + 0;
	end
	IsRacials = v115(v23.Affliction_TTD.RacialsTTD) and v114(v23.Affliction_CDUSE.Racials);
	IsPotions = v115(v23.Affliction_TTD.PotionsTTD) and (v23.Affliction_CDUSE.Potionswhensolo or (not v23.Affliction_CDUSE.Potionswhensolo and not v20.ISSolo())) and v114(v23.Affliction_CDUSE.Potions);
	IsTrinket1 = v115(v23.Affliction_TTD.TrinketsTTD) and v114(v23.Affliction_CDUSE.Trinket1);
	IsTrinket2 = v115(v23.Affliction_TTD.TrinketsTTD) and v114(v23.Affliction_CDUSE.Trinket2);
	IsSummonDarkglare = v115(v23.Affliction_TTD.SummonDarkglareTTD) and v114(v23.Affliction_CDUSE.SummonDarkglare);
	IsSoulRot = v115(v23.Affliction_TTD.SoulRotTTD) and v114(v23.Affliction_CDUSE.SoulRot);
	IsMalevolence = v115(v23.Affliction_TTD.MalevolenceTTD) and v114(v23.Affliction_CDUSE.Malevolence);
	IsOblivion = v115(v23.Affliction_TTD.OblivionTTD) and v114(v23.Affliction_CDUSE.Oblivion);
	IsVileTaint = v105() and v115(v23.Affliction_TTD.VileTaintTTD) and v114(v23.Affliction_CDUSE.VileTaint);
	IsPhantomSingularity = v115(v23.Affliction_TTD.PhantomSingularityTTD) and v114(v23.Affliction_CDUSE.PhantomSingularity);
	Shouldskip = (v6:ChannelSpellID() == (33864 + 200289)) or ((v6:ChannelSpellID() == (402315 - 203725)) and (v6:GCDRemains() == (65 - (30 + 35))));
	if (v20.TargetIsValid() or v6:AffectingCombat()) then
		v71 = v3.BossFightRemains();
		v113 = true;
		v72 = v71;
		if (v72 == (7637 + 3474)) then
			v113 = false;
			v72 = v3.FightRemains(v52, false);
		end
		v70 = v6:SoulShardsP();
		v62 = v8:DebuffUp(v24.AgonyDebuff) and (v8:DebuffUp(v24.CorruptionDebuff) or v8:DebuffUp(v24.WitherDebuff)) and v8:DebuffUp(v24.UnstableAfflictionDebuff);
		v63 = v76(v53, v24.AgonyDebuff);
		v64 = v76(v53, v24.VileTaintDebuff);
		v65 = v76(v53, v24.PhantomSingularityDebuff);
		v66 = v64 * v17(v15(v24.VileTaint:IsAvailable()), v65) * v15(v24.PhantomSingularity:IsAvailable());
		v73 = v6:GCD() + (1257.25 - (1043 + 214));
	end
	if ((v198 == nil) and ((v109() > (18 - 13)) or v6:AffectingCombat()) and not (v6:IsMounted() or v6:IsInVehicle()) and v24.FelDomination:IsReady() and (((v23.Affliction_Pets.FelDomination == "only Infight") and v6.AffectingCombat) or ((v23.Affliction_Pets.FelDomination == "only out of Fight") and not v6.AffectingCombat) or (v23.Affliction_Pets.FelDomination == "both")) and (not v7:IsActive() or (v7:HealthPercentage() < (1213 - (323 + 889))) or v6:BuffUp(v24.GrimoireofSacrificeBuff))) then
		if v111(v24.FelDomination) then
			return "FelDomination missing Pet";
		end
	end
	v19 = ((v109() > (13 - 8)) or v6:AffectingCombat()) and v118() and not (v6:IsMounted() or v6:IsInVehicle());
	if v19 then
		return v19;
	end
	if (v24.GrimoireofSacrifice:IsCastable() and not v6:IsMoving() and (v7:HealthPercentage() > (580 - (361 + 219)))) then
		if v111(v24.GrimoireofSacrifice) then
			return "grimoire_of_sacrifice";
		end
	end
	if BurningRushToggle then
		if ((v23.Affliction.BurningRush == "always") or ((v23.Affliction.BurningRush == "only infight") and v6:AffectingCombat()) or ((v23.Affliction.BurningRush == "only out of fight") and not v6:AffectingCombat())) then
			if (v24.BurningRush:IsCastable() and v6:IsMoving() and ((v107() > (321 - (53 + 267))) or not v6:AffectingCombat()) and v6:BuffDown(v24.BurningRush) and (v6:HealthPercentage() > v23.Affliction.BurningRushcancel) and not v6:IsMounted()) then
				if v111(v24.BurningRush) then
					return "Burning Rush";
				end
			end
		end
		if (v6:BuffUp(v24.BurningRush) and (((v23.Affliction.BurningRush == "only infight") and not v6:AffectingCombat()) or ((v23.Affliction.BurningRush == "only out of fight") and v6:AffectingCombat()) or (v6:HealthPercentage() < v23.Affliction.BurningRushcancel) or (not v6:IsMoving() and v6:BuffUp(v24.BurningRush)))) then
			v12.CastMacro(1 + 1, nil, nil, v24.BurningRush);
			return "Burnind Rush cancel";
		end
	end
	v19 = not v6:IsCasting(v24.Banish) and v20.IncorpCycle(v24.Banish, 443 - (15 + 398), false, false);
	if v19 then
		return v19;
	end
	if (v24.Soulstone:IsReady() and not v6:IsCasting(v24.Soulstone) and v6:AffectingCombat() and not v6:IsMoving()) then
		if (v8:UnitIsFriend() and v8:UnitIsPlayer() and v8:Exists() and v8:IsDeadOrGhost() and v8:IsInRange(1022 - (18 + 964))) then
			v12.Cast(v24.Soulstone);
			return "Soulstone on Target";
		end
		if (v11:UnitIsFriend() and v11:UnitIsPlayer() and v11:Exists() and v11:IsDeadOrGhost() and v11:IsInRange(150 - 110)) then
			v12.CastTarget(v24.Soulstone, v12.TName().MOUSEOVER);
			return "Soulstone on Mouseover";
		end
	end
	v19 = v119();
	if v19 then
		return v19;
	end
	if v20.TargetIsValid() then
		if (not v23.Affliction.AttackonlyinCombat or (v23.Affliction.AttackonlyinCombat and v8:AffectingCombat())) then
			if not v103(v5.Target) then
				if not v6:AffectingCombat() then
					v19 = v120();
					if v19 then
						return v19;
					end
				end
				if InterruptToggle then
					v19 = v20.InterruptCycle(v24.SpellLockcast, 24 + 16, true, nil, false);
					if v19 then
						return v19;
					end
					v19 = v20.InterruptCycle(v24.SpellLock, 26 + 14, true, nil, false);
					if v19 then
						return v19;
					end
				end
				v129();
				if v8:IsInRange(890 - (20 + 830)) then
					if (v13() and (v54 > (1 + 0)) and (v54 < (129 - (116 + 10)))) then
						local v219 = v127();
						if v219 then
							return v219;
						end
					end
					if (v13() and (v54 > (1 + 1))) then
						local v220 = v124();
						if v220 then
							return v220;
						end
					end
					local v218 = v122();
					if v218 then
						return v218;
					end
					if (v23.Commons.Enabled.Trinkets or v23.Commons.Enabled.Items) then
						local v221 = v121();
						if v221 then
							return v221;
						end
					end
					local v218 = v123();
					if v218 then
						return v218;
					end
					if (not v13() or (v54 < (740 - (542 + 196)))) then
						if (v24.Agony:IsReady() and (not v24.VileTaint:IsAvailable() or not IsVileTaint or (v8:DebuffRemains(v24.AgonyDebuff) < (v24.VileTaint:CooldownRemains() + v24.VileTaint:CastTime()))) and ((v24.AbsoluteCorruption:IsAvailable() and (v8:DebuffRemains(v24.AgonyDebuff) < (6 - 3))) or (not v24.AbsoluteCorruption:IsAvailable() and (v8:DebuffRemains(v24.AgonyDebuff) < (2 + 3))) or ((v24.SoulRot:CooldownRemains() < (3 + 2)) and (v8:DebuffRemains(v24.AgonyDebuff) < (3 + 5)))) and (v72 > (v8:DebuffRemains(v24.AgonyDebuff) + (12 - 7)))) then
							if v111(v24.Agony) then
								return "agony main 2";
							end
						end
						if (v24.Haunt:IsReady() and not v6:IsMoving() and v24.DemonicSoul:IsAvailable() and (v6:BuffStack(v24.NightfallBuff) < ((4 - 2) - v15(v6:PrevGCDP(1552 - (1126 + 425), v24.DrainSoul)))) and (not v24.VileTaint:IsAvailable() or not IsVileTaint or v24.VileTaint:CooldownDown())) then
							if v111(v24.Haunt) then
								return "haunt main 4";
							end
						end
						if (v24.UnstableAffliction:IsReady() and not v6:IsMoving() and ((v24.AbsoluteCorruption:IsAvailable() and (v8:DebuffRemains(v24.UnstableAfflictionDebuff) < (408 - (118 + 287)))) or (not v24.AbsoluteCorruption:IsAvailable() and (v8:DebuffRemains(v24.UnstableAfflictionDebuff) < (19 - 14))) or ((v24.SoulRot:CooldownRemains() < (1126 - (118 + 1003))) and (v8:DebuffRemains(v24.UnstableAfflictionDebuff) < (23 - 15)))) and (not v24.DemonicSoul:IsAvailable() or (v8:BuffStack(v24.NightfallBuff) < (379 - (142 + 235))) or (v6:PrevGCDP(4 - 3, v24.Haunt) and (v8:DebuffStack(v24.NightfallBuff) < (1 + 1)))) and (v72 > (v8:DebuffRemains(v24.UnstableAfflictionDebuff) + (982 - (553 + 424))))) then
							if v111(v24.UnstableAffliction) then
								return "unstable_affliction main 6";
							end
						end
						if (v24.Haunt:IsReady() and not v6:IsMoving() and ((v24.AbsoluteCorruption:IsAvailable() and (v8:DebuffRemains(v24.HauntDebuff) < (5 - 2))) or (not v24.AbsoluteCorruption:IsAvailable() and (v8:DebuffRemains(v24.HauntDebuff) < (5 + 0))) or ((v24.SoulRot:CooldownRemains() < (5 + 0)) and (v8:DebuffRemains(v24.HauntDebuff) < (5 + 3)))) and (not v24.VileTaint:IsAvailable() or not IsVileTaint or v24.VileTaint:CooldownDown()) and (v72 > (v8:DebuffRemains(v24.HauntDebuff) + 3 + 2))) then
							if v111(v24.Haunt) then
								return "haunt main 8";
							end
						end
						if (v24.WitherAbility:IsReady() and ((v24.AbsoluteCorruption:IsAvailable() and (v8:DebuffRemains(v24.WitherDebuff) < (2 + 1))) or (not v24.AbsoluteCorruption:IsAvailable() and (v8:DebuffRemains(v24.WitherDebuff) < (10 - 5)))) and (v72 > (v8:DebuffRemains(v24.WitherDebuff) + (13 - 8)))) then
							if v111(v24.WitherAbility) then
								return "wither main 10";
							end
						end
						if (v24.Corruption:IsReady() and v8:DebuffRefreshable(v24.CorruptionDebuff) and (v72 > (v8:DebuffRemains(v24.CorruptionDebuff) + (11 - 6)))) then
							if v111(v24.Corruption) then
								return "corruption main 12";
							end
						end
						if (v24.DrainSoul:IsReady() and not v6:IsMoving() and v6:BuffUp(v24.NightfallBuff) and ((v6:BuffStack(v24.NightfallBuff) > (1 + 0)) or (v6:BuffRemains(v24.NightfallBuff) < (v24.DrainSoul:ExecuteTime() * (9 - 7)))) and v6:BuffDown(v24.TormentedCrescendoBuff) and v24.SoulRot:CooldownDown() and (v70 < ((758 - (239 + 514)) - v6:BuffStack(v24.TormentedCrescendoBuff))) and (not v24.VileTaint:IsAvailable() or not IsVileTaint or v24.VileTaint:CooldownDown())) then
							if v12.Cast(v24.DrainSoul) then
								return "drain_soul main 14";
							end
						end
						if (v24.ShadowBolt:IsReady() and not v6:IsMoving() and v6:BuffUp(v24.NightfallBuff) and ((v6:BuffStack(v24.NightfallBuff) > (1 + 0)) or (v6:BuffRemains(v24.NightfallBuff) < (v24.ShadowBolt:ExecuteTime() * (1331 - (797 + 532))))) and (v6:BuffStack(v24.TormentedCrescendoBuff) < (2 + 0)) and v24.SoulRot:CooldownDown() and (v70 < ((2 + 3) - v6:BuffStack(v24.TormentedCrescendoBuff))) and (not v24.VileTaint:IsAvailable() or not IsVileTaint or v24.VileTaint:CooldownDown())) then
							if v111(v24.ShadowBolt) then
								return "shadow_bolt main 16";
							end
						end
						if v24.Wither:IsAvailable() then
							local v222 = v128();
							if v222 then
								return v222;
							end
						end
						if (v24.VileTaint:IsReady() and IsVileTaint and not v6:IsMoving() and (not v24.SoulRot:IsAvailable() or (v24.SoulRot:CooldownRemains() > (47 - 27)) or not IsSoulRot or (v24.SoulRot:CooldownRemains() <= (v24.VileTaint:ExecuteTime() + v73)) or (v71 < v24.SoulRot:CooldownRemains())) and v62) then
							if v111(v24.VileTaint, true) then
								return "vile_taint main 18";
							end
						end
						if (v24.PhantomSingularity:IsReady() and IsPhantomSingularity and (not v24.SoulRot:IsAvailable() or (v24.SoulRot:CooldownRemains() < (1206 - (373 + 829))) or not IsSoulRot or (v71 < v24.SoulRot:CooldownRemains())) and v62) then
							if v111(v24.PhantomSingularity, true) then
								return "phantom_singularity main 20";
							end
						end
						if v57 then
							if (v24.Malevolence:IsReady() and IsMalevolence) then
								if v111(v24.Malevolence, true) then
									return "malevolence main 22";
								end
							end
							if (v24.SoulRot:IsReady() and IsSoulRot and not v6:IsMoving()) then
								if v111(v24.SoulRot) then
									return "soul_rot main 24";
								end
							end
						end
						if (v24.SummonDarkglare:IsReady() and IsSummonDarkglare and v59 and (v8:DebuffStack(v68) == v69)) then
							if v111(v24.SummonDarkglare, true) then
								return "summon_darkglare main 26";
							end
						end
						if v24.DemonicSoul:IsAvailable() then
							local v223 = v128();
							if v223 then
								return v223;
							end
						end
						if (v24.MaleficRapture:IsReady() and (not v6:IsMoving() or v6:BuffUp(v24.TormentedCrescendoBuff)) and (((v70 > (735 - (476 + 255))) and ((v24.DemonicSoul:IsAvailable() and (v6:BuffStack(v24.NightfallBuff) < (1132 - (369 + 761)))) or not v24.DemonicSoul:IsAvailable())) or (v6:BuffStack(v24.TormentedCrescendoBuff) > (1 + 0)))) then
							if v111(v24.MaleficRapture) then
								return "malefic_rapture main 28";
							end
						end
						if (v24.DrainSoul:IsReady() and not v6:IsMoving() and v24.DemonicSoul:IsAvailable() and v6:BuffUp(v24.NightfallBuff) and (v6:BuffStack(v24.TormentedCrescendoBuff) < (2 - 0)) and (v8:HealthPercentage() < (37 - 17))) then
							if v12.Cast(v24.DrainSoul) then
								return "drain_soul main 30";
							end
						end
						if (v24.MaleficRapture:IsReady() and (not v6:IsMoving() or v6:BuffUp(v24.TormentedCrescendoBuff)) and v24.DemonicSoul:IsAvailable() and ((v70 > (239 - (64 + 174))) or (v8:BuffUp(v24.TormentedCrescendoBuff) and (v24.SoulRot:CooldownRemains() > (v6:BuffRemains(v24.TormentedCrescendoBuff) * v73)))) and (not v24.VileTaint:IsAvailable() or not IsVileTaint or ((v70 > (1 + 0)) and (v24.VileTaint:CooldownRemains() > (14 - 4)))) and (not v24.Oblivion:IsAvailable() or (v24.Oblivion:CooldownRemains() > (346 - (144 + 192))) or ((v70 > (218 - (42 + 174))) and (v24.Oblivion:CooldownRemains() < (8 + 2))))) then
							if v111(v24.MaleficRapture) then
								return "malefic_rapture main 32";
							end
						end
						if (v24.Oblivion:IsReady() and IsOblivion and not v6:IsMoving() and v62 and (v8:DebuffRemains(v24.HauntDebuff) > (5 + 0))) then
							if v111(v24.Oblivion) then
								return "oblivion main 34";
							end
						end
						if (v24.MaleficRapture:IsReady() and (not v6:IsMoving() or v6:BuffUp(v24.TormentedCrescendoBuff)) and ((v24.TormentedCrescendo:IsAvailable() and v6:BuffUp(v24.TormentedCrescendoBuff) and ((v6:BuffRemains(v24.TormentedCrescendoBuff) < (v73 * (1 + 1))) or (v6:BuffStack(v24.TormentedCrescendoBuff) == (1506 - (363 + 1141))))) or ((v59 or ((v24.DemonicSoul:IsAvailable() or v24.PhantomSingularity:IsAvailable()) and v57) or (v24.Wither:IsAvailable() and v57 and v8:DebuffDown(v24.SoulRot) and (v70 > (1582 - (1183 + 397))))) and (not v24.Oblivion:IsAvailable() or (v24.Oblivion:CooldownRemains() > (30 - 20)) or ((v70 > (2 + 0)) and (v24.Oblivion:CooldownRemains() < (8 + 2))))) or (v24.TormentedCrescendo:IsAvailable() and v24.NightfallBuff:IsAvailable() and v6:BuffUp(v24.TormentedCrescendoBuff) and v6:BuffUp(v24.NightfallBuff)) or (v24.DemonicSoul:IsAvailable() and v6:BuffDown(v24.NightfallBuff) and (not v24.VileTaint:IsAvailable() or (v24.VileTaint:CooldownRemains() > (1985 - (1913 + 62))) or ((v70 > (1 + 0)) and (v24.VileTaint:CooldownRemains() < (26 - 16))))) or (v24.DemonicSoul:IsAvailable() and v6:BuffUp(v24.TormentedCrescendoBuff)))) then
							if v111(v24.MaleficRapture) then
								return "malefic_rapture main 36";
							end
						end
						if (v67:IsReady() and not v6:IsMoving() and v6:BuffUp(v24.NightfallBuff)) then
							if v12.Cast(v67) then
								return "drain_soul/shadow_bolt main 38";
							end
						end
						if (v24.Agony:IsReady() and (v8:DebuffRefreshable(v24.AgonyDebuff))) then
							if v111(v24.Agony) then
								return "agony main 40";
							end
						end
						if (v24.UnstableAffliction:IsReady() and not v6:IsMoving() and (v8:DebuffRefreshable(v24.UnstableAfflictionDebuff))) then
							if v111(v24.UnstableAffliction) then
								return "unstable_affliction main 42";
							end
						end
						if (v67:IsReady() and not v6:IsMoving()) then
							if v12.Cast(v67) then
								return "drain_soul/shadow_bolt main 44";
							end
						end
					end
				end
			end
		end
	end
end
local function v131()
	v12.ResetToggle();
	v23.Affliction.Display();
	v24.AgonyDebuff:RegisterAuraTracking();
	v24.CorruptionDebuff:RegisterAuraTracking();
	v24.UnstableAfflictionDebuff:RegisterAuraTracking();
	v24.WitherDebuff:RegisterAuraTracking();
	local v199 = {Burningreushvalue=v24.BurningRush:Name()};
	local v200 = "/cancelaura {Burningreushvalue}";
	v12:UpdateMacro("macro1", "/use 16");
	v12:UpdateMacro("macro2", v110(v200, v199));
	v12:UpdateMacro("macro6", "/stopcasting");
	v12.ToggleIconFrame:AddButtonCustom("B", 1934 - (565 + 1368), "BurningRush", "burningrush");
	v12.ToggleIconFrame:AddButtonCustom("I", 7 - 5, "Interrupt", "interrupt");
	v12.ToggleIconFrame:AddButtonCustom("S", 1664 - (1477 + 184), "smallCDs", "smallcds");
	v12.Print("Affliction Warlock rotation has been updated for patch 11.0.2. Last Update 23.09.2024");
end
v12.SetAPL(360 - 95, v130, v131);
