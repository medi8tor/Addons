local v0, v1 = ...;
local v2 = HeroDBC.DBC;
local v3 = HeroLib;
local v4 = v3.Utils;
local v5 = HeroCache;
local v6 = v3.Unit;
local v7 = v6.Player;
local v8 = v6.Pet;
local v9 = v6.Target;
local v10 = v3.Spell;
local v11 = v3.Item;
local v12 = v6.MouseOver;
local v13 = HeroRotation();
local v14 = v13.AoEON;
local v15 = v13.CDsON;
local v16 = v13.Cast;
local v17 = v13.Commons().Warlock;
local v18 = v13.Commons().Everyone.num;
local v19 = v13.Commons().Everyone.bool;
local v20 = math.max;
local v21 = math.floor;
local v22 = C_Timer.After;
local v23;
local v24 = v13.Commons().Everyone;
local v25 = v13.GUISettingsGet();
local v26 = {General=v25.General,Commons=v25.APL.Warlock.Commons,Destruction=v25.APL.Warlock.Destruction,Defensives=v25.APL.Warlock.Defensives,Destruction_Pets=v25.APL.Warlock.Destruction_Pets,Destruction_TTD=v25.APL.Warlock.Destruction_TTD,Destruction_CDUSE=v25.APL.Warlock.Destruction_CDUSE};
local v27 = v10.Warlock.Destruction;
local v28 = v11.Warlock.Destruction;
local v29 = {v28.SpymastersWeb:ID(),v28.KahetiShadowweaversEmblem:ID()};
local v30 = 3 - 1;
local v31 = (v30 > (2.99 - 1)) and not (v27.Cataclysm:IsAvailable() and v27.ImprovedChaosBolt:IsAvailable());
local v32 = v31 or ((v30 > (619.01 - (555 + 64))) and (v30 < (931.99 - (857 + 74))));
local v33 = false;
local v34, v35 = false, 568 - (367 + 201);
local v36 = 927 - (214 + 713);
local v37 = false;
local v38 = false;
local v39 = false;
local v40, v41 = false, false;
local v42 = 0 + 0;
local v43, v44;
local v45 = 1748 + 9363;
local v46 = 11988 - (282 + 595);
local v47, v48;
local v49, v50;
local v51, v52;
local v53, v54;
local v55, v56;
local v57, v58;
local v59, v60;
local v61, v62;
local v63, v64;
local v65, v66;
local v67, v68;
local v69, v70;
local v71;
local v72 = 1637 - (1523 + 114);
local function v73()
	local v125, v126 = v7:GetTrinketData(v29);
	if ((v72 < (5 + 0)) and ((v125.ID == (0 - 0)) or (v126.ID == (1065 - (68 + 997))) or ((v125.SpellID > (1270 - (226 + 1044))) and not v125.Usable) or ((v126.SpellID > (0 - 0)) and not v126.Usable))) then
		v72 = v72 + (118 - (32 + 85));
		v22(5 + 0, function()
			v73();
		end);
		return;
	end
	v47 = v125.Object;
	v48 = v126.Object;
	v49 = v125.ID;
	v50 = v126.ID;
	v51 = v125.Spell;
	v53 = v125.Range;
	v55 = v125.CastTime;
	v52 = v126.Spell;
	v54 = v126.Range;
	v56 = v126.CastTime;
	v57 = v125.Cooldown;
	v58 = v126.Cooldown;
	v59 = v125.Blacklisted;
	v60 = v126.Blacklisted;
	v61 = v47:HasUseBuff();
	v62 = v48:HasUseBuff();
	v63 = 0.5 + 0;
	if (v61 and (((v57 % (1077 - (892 + 65))) == (0 - 0)) or (((221 - 101) % v57) == (0 - 0)))) then
		v63 = 351 - (87 + 263);
	end
	v64 = 180.5 - (67 + 113);
	if (v62 and (((v58 % (88 + 32)) == (0 - 0)) or (((89 + 31) % v58) == (0 - 0)))) then
		v64 = 953 - (802 + 150);
	end
	v65 = (v49 == v28.SpymastersWeb:ID()) or (v49 == v28.KahetiShadowweaversEmblem:ID());
	v66 = (v50 == v28.SpymastersWeb:ID()) or (v50 == v28.KahetiShadowweaversEmblem:ID());
	v67 = v49 == (523123 - 328822);
	v68 = v50 == (352454 - 158153);
	v69 = v47:BuffDuration();
	v70 = v48:BuffDuration();
	local v141 = ((v69 > (0 + 0)) and v69) or (998 - (915 + 82));
	local v142 = ((v70 > (0 - 0)) and v70) or (1 + 0);
	v71 = 1 - 0;
	if ((not v61 and v62) or (v62 and (((v58 / v142) * v64) > ((v57 / v141) * v63)))) then
		v71 = 1189 - (1069 + 118);
	end
end
v73();
v3:RegisterForEvent(function()
	v73();
end, "PLAYER_EQUIPMENT_CHANGED");
v3:RegisterForEvent(function()
	v30 = 4 - 2;
	v31 = (v30 > (1.99 - 0)) and not (v27.Cataclysm:IsAvailable() and v27.ImprovedChaosBolt:IsAvailable());
	v32 = v31 or ((v30 > (0.01 + 0)) and (v30 < (0.99 - 0)));
	v33 = false;
	v34, v35 = false, 0 + 0;
	v36 = 791 - (368 + 423);
	v37 = false;
	v38 = false;
	v39 = false;
	v40, v41 = false, false;
	v45 = 34918 - 23807;
	v46 = 11129 - (10 + 8);
end, "PLAYER_REGEN_ENABLED");
v3:RegisterForEvent(function()
	v27.ChaosBolt:RegisterInFlight();
	v27.Incinerate:RegisterInFlight();
	v27.SoulFire:RegisterInFlight();
	v27.SummonInfernal:RegisterInFlight();
end, "SPELLS_CHANGED", "LEARNED_SPELL_IN_TAB");
v27.ChaosBolt:RegisterInFlight();
v27.Incinerate:RegisterInFlight();
v27.SoulFire:RegisterInFlight();
v27.SummonInfernal:RegisterInFlight();
local function v74(v143)
	for v183 in pairs(v143) do
		local v184 = v143[v183];
		if v184:DebuffUp(v27.Havoc) then
			return true, v184:DebuffRemains(v27.HavocDebuff), v184:DebuffRemains(v27.ImmolateDebuff);
		end
	end
	return false, 0 - 0, 442 - (416 + 26);
end
local function v75()
	return (9 - 6) * v7:SpellHaste() * ((v27.DemonfireMastery:IsAvailable() and (0.65 + 0)) or (1 - 0));
end
local function v76()
	return v7:BuffUp(v27.DemonicArtOverlordBuff) or v7:BuffUp(v27.DemonicArtMotherBuff) or v7:BuffUp(v27.DemonicArtPitLordBuff);
end
local function v77()
	return v7:BuffUp(v27.DiabolicRitualOverlordBuff) or v7:BuffUp(v27.DiabolicRitualMotherBuff) or v7:BuffUp(v27.DiabolicRitualPitLordBuff);
end
local function v78()
	return v17.GuardiansTable.InfernalDuration > (438 - (145 + 293));
end
local function v79()
	return v17.GuardiansTable.InfernalDuration or (v27.SummonInfernal:InFlight() and (460 - (44 + 386))) or (1486 - (998 + 488));
end
local function v80()
	return v17.GuardiansTable.OverfiendDuration > (0 + 0);
end
local function v81()
	return v17.GuardiansTable.OverfiendDuration or (0 + 0);
end
local function v82(v144)
	return v20(v144:TimeToDie() * -(773 - (201 + 571)), -(1153 - (116 + 1022))) + v144:DebuffRemains(v27.ImmolateDebuff) + ((412 - 313) * v18(v144:GUID() == v9:GUID()));
end
local function v83(v145)
	return v145:DebuffRemains(v27.ImmolateDebuff) + ((59 + 40) * v145:DebuffRemains(v27.HavocDebuff));
end
local function v84(v146)
	return v146:TimeToDie();
end
local function v85(v147)
	return v147:DebuffRemains(v27.WitherDebuff) + ((361 - 262) * v18(v147:DebuffUp(v27.HavocDebuff))) + ((351 - 252) * v18(v147:DebuffDown(v27.WitherDebuff)));
end
local function v86(v148)
	return v148:DebuffRemains(v27.WitherDebuff) + ((958 - (814 + 45)) * v18(v148:DebuffUp(v27.HavocDebuff)));
end
local function v87(v149)
	return ((v149:DebuffRemains(v27.WitherDebuff) + v149:DebuffRemains(v27.ImmolateDebuff)) - ((12 - 7) * v18(v149:DebuffUp(v27.ConflagrateDebuff)))) + ((6 + 94) * v18(v149:DebuffUp(v27.HavocDebuff)));
end
local function v88(v150)
	return (v150:TimeToDie() > (3 + 5)) and (v150:GUID() ~= v9:GUID());
end
local function v89(v151)
	return v151:DebuffRefreshable(v27.ImmolateDebuff) and (not v27.Cataclysm:IsAvailable() or not IsCataclysm or (v27.Cataclysm:CooldownRemains() > v151:DebuffRemains(v27.ImmolateDebuff))) and (not v27.RagingDemonfire:IsAvailable() or (v27.ChannelDemonfire:CooldownRemains() > v151:DebuffRemains(v27.ImmolateDebuff)) or (v3.CombatTime() < (890 - (261 + 624)))) and (v151:TimeToDie() > (31 - 13));
end
local function v90(v152)
	return ((v152:DebuffRefreshable(v27.ImmolateDebuff) and (not v27.Cataclysm:IsAvailable() or (v27.Cataclysm:CooldownRemains() > v152:DebuffRemains(v27.ImmolateDebuff)))) or (v44 > v27.ImmolateDebuff:AuraActiveCount())) and (v152:TimeToDie() > (1090 - (1020 + 60))) and not v34 and not (v27.DiabolicRitual:IsAvailable() and v27.Inferno:IsAvailable());
end
local function v91(v153)
	return ((v153:DebuffRefreshable(v27.ImmolateDebuff) and (v36 < (1428.4 - (630 + 793)))) or ((v153:DebuffRemains(v27.ImmolateDebuff) < (6 - 4)) and (v153:DebuffRemains(v27.ImmolateDebuff) < v35)) or v153:DebuffDown(v27.ImmolateDebuff) or v19(v18(v36 < (9 - 7)) * v18(v34))) and (not v27.Cataclysm:IsAvailable() or not IsCataclysm or (v27.Cataclysm:CooldownRemains() > v153:DebuffRemains(v27.ImmolateDebuff))) and (v153:TimeToDie() > (5 + 6)) and not (v27.DiabolicRitual:IsAvailable() and v27.Inferno:IsAvailable());
end
local function v92(v154)
	return v154:DebuffRefreshable(v27.ImmolateDebuff) and ((v154:DebuffRemains(v27.ImmolateDebuff) < v27.Havoc:CooldownRemains()) or v154:DebuffDown(v27.ImmolateDebuff)) and (not v27.Cataclysm:IsAvailable() or (v27.Cataclysm:CooldownRemains() > v154:DebuffRemains(v27.ImmolateDebuff))) and (not v27.SoulFire:IsAvailable() or ((v27.SoulFire:CooldownRemains() + (v18(not v27.Mayhem:IsAvailable()) * v27.SoulFire:CastTime())) > v154:DebuffRemains(v27.ImmolateDebuff))) and (v154:TimeToDie() > (51 - 36));
end
local function v93(v155)
	return (v155:DebuffRefreshable(v27.ImmolateDebuff) and (v36 < (1752.4 - (760 + 987))) and (v155:TimeToDie() > (1918 - (1789 + 124)))) or ((((v155:DebuffRemains(v27.ImmolateDebuff) < (768 - (745 + 21))) and (v155:DebuffRemains(v27.ImmolateDebuff) < v35)) or v155:DebuffDown(v27.ImmolateDebuff) or (v36 < (1 + 1))) and (v155:TimeToDie() > (30 - 19)));
end
local function v94(v156)
	return (((v27.Shadowburn:FullRechargeTime() <= (v7:GCD() * (11 - 8))) or ((v156:DebuffRemains(v27.EradicationDebuff) <= v7:GCD()) and v27.Eradication:IsAvailable() and not v27.ChaosBolt:InFlight() and not v27.DiabolicRitual:IsAvailable())) and (v27.ConflagrationofChaos:IsAvailable() or v27.BlisteringAtrophy:IsAvailable()) and (v156:TimeToDie() < (1 + 4))) or (v45 <= (7 + 1));
end
local function v95(v157)
	return v157:DebuffRefreshable(v27.WitherDebuff) and (not v27.Cataclysm:IsAvailable() or not IsCataclysm or (v27.Cataclysm:CooldownRemains() > v157:DebuffRemains(v27.WitherDebuff))) and (not v27.RagingDemonfire:IsAvailable() or (v27.ChannelDemonfire:CooldownRemains() > v157:DebuffRemains(v27.WitherDebuff)) or (v3.CombatTime() < (1060 - (87 + 968)))) and (v157:TimeToDie() > (79 - 61));
end
local function v96(v158)
	return v158:DebuffRefreshable(v27.WitherDebuff) and (not v27.Cataclysm:IsAvailable() or not IsCataclysm or (v27.Cataclysm:CooldownRemains() > v158:DebuffRemains(v27.WitherDebuff))) and (not v27.RagingDemonfire:IsAvailable() or (v27.ChannelDemonfire:CooldownRemains() > v158:DebuffRemains(v27.WitherDebuff)) or (v3.CombatTime() < (5 + 0))) and (v158:TimeToDie() > (40 - 22));
end
local function v97(v159)
	return (((v159.DebuffRemains(v27.WitherDebuff) - ((1418 - (447 + 966)) * v18(v27.ChaosBolt:InFlight()))) < (v27.WitherDebuff:MaxDuration() * (0.4 - 0))) or (v159:DebuffRemains(v27.WitherDebuff) < (1820 - (1703 + 114))) or (((v159:DebuffRemains(v27.WitherDebuff) - v27.ChaosBolt:ExecuteTime()) < (706 - (376 + 325))) and v27.ChaosBolt:IsReady())) and (not v27.SoulFire:IsAvailable() or ((v27.SoulFire:CooldownRemains() + v27.SoulFire:CastTime()) > (v159:DebuffRemains(v27.WitherDebuff) - (8 - 3)))) and (v159:TimeToDie() > (24 - 16));
end
local function v98(v160)
	return (((v160:DebuffRemains(v27.WitherDebuff) - ((2 + 3) * v18(v27.ChaosBolt:InFlight()))) < (v27.WitherDebuff:MaxDuration() * (0.3 - 0))) or (v160:DebuffRemains(v27.WitherDebuff) < (17 - (9 + 5)))) and (not v27.SoulFire:IsAvailable() or ((v27.SoulFire:CooldownRemains() + v27.SoulFire:CastTime()) > (v160:DebuffRemains(v27.WitherDebuff)))) and (v160:TimeToDie() > (384 - (85 + 291)));
end
local function v99(v161)
	return (v161:DebuffRefreshable(v27.WitherDebuff) and (v36 < (1270.4 - (243 + 1022))) and (v161:TimeToDie() > (19 - 14))) or ((((v161:DebuffRemains(v27.WitherDebuff) < (2 + 0)) and (v161:DebuffRemains(v27.WitherDebuff) < v35)) or v161:DebuffDown(v27.WitherDebuff) or (v36 < (1182 - (1123 + 57)))) and (v161:TimeToDie() > (9 + 2)));
end
local function v100()
	local v162 = nil;
	local v163 = v27.SpellLock:CooldownRemains();
	local v164 = v27.SingeMagic:CooldownRemains();
	local v165 = v27.ShadowBulwark:CooldownRemains();
	local v166 = v27.Seduction:CooldownRemains();
	if ((not v8:IsActive() or (v8:HealthPercentage() < (255 - (163 + 91)))) and not v7:BuffUp(v27.GrimoireofSacrificeBuff)) then
		v162 = nil;
	elseif ((v7:Level() <= (1960 - (1869 + 61))) and v8:IsActive()) then
		v162 = "Leveling";
	elseif (v27.SpellLock:IsReady() or ((v163 <= (7 + 17)) and not ((v163 == (0 - 0)) and not v27.SpellLock:IsReady()))) then
		v162 = "Felhunter";
	elseif (v27.SingeMagic:IsReady() or ((v164 <= (23 - 8)) and not ((v164 == (0 + 0)) and not v27.SingeMagic:IsReady()))) then
		v162 = "Imp";
	elseif (v27.ShadowBulwark:IsReady() or ((v165 <= (164 - 44)) and not ((v165 == (0 + 0)) and not v27.ShadowBulwark:IsReady()))) then
		v162 = "Voidwalker";
	elseif (v27.Seduction:IsReady() or ((v166 <= (1504 - (1329 + 145))) and not ((v166 == (971 - (140 + 831))) and not v27.Seduction:IsReady()))) then
		v162 = "Sayaad";
	end
	return v162;
end
local function v101()
	Currentpet = v100();
end
local v102;
local function v103(v167)
	return (v167 ~= "Not Used") and ((((v167 == "with Cooldowns") or ((v167 == "small CDs") and v26.Destruction_CDUSE.smallcdswithCooldowns) or (v167 == "with Cooldowns or AoE") or (v167 == "on Enemycount or Cooldowns") or (v167 == "on Boss or with Cooldowns")) and v15()) or (v167 == "always") or (((v167 == "on Boss only") or (v167 == "on Boss or on Enemycount") or (v167 == "on Boss or with Cooldowns")) and (v102 or v9:IsDummy())) or ((v167 == "with Bloodlust only") and v7:BloodlustUp()) or ((v167 == "small CDs") and Smallcds) or (((v167 == "on AOE") or (v167 == "with Cooldowns or AoE")) and (v44 > (1852 - (1409 + 441))) and v14()) or (((v167 == "on Enemycount or Cooldowns") or (v167 == "on Enemycount") or (v167 == "on Boss or on Enemycount")) and (v44 >= v26.Destruction_CDUSE.Enemycount) and v14()));
end
local function v104(v168)
	return (v102 and v26.Destruction_TTD.IgnoreWhenBoss) or v24.Buggedmobs[v9:NPCID()] or (v24.ISSolo() and v26.Destruction_TTD.IgnoreWhenSolo) or (v168 == (718 - (15 + 703))) or ((v46 >= v168) and (v46 < (3602 + 4175)));
end
local function v105(v169)
	return v169:NPCID() == (204998 - (262 + 176));
end
local function v106(v170)
	return v170:CastSpellID() == (410526 - (345 + 1376));
end
local function v107()
	return (v12:Exists() or not v26.Destruction.CursorCheck) and not v7:IsCameraBusy();
end
local function v108()
	if v24.TargetIsValid() then
		local v188 = v9:MinDistance() or (693 - (198 + 490));
		local v189 = v9:MaxDistance() or (176 - 136);
		v188 = math.max(v188 - (18 - 10), 1211 - (696 + 510));
		v189 = math.min(v189 + (16 - 8), 1302 - (1091 + 171));
		local v190 = v7:GetEnemiesInRange(v188);
		local v191 = v7:GetEnemiesInRange(v189);
		local v192 = #v191;
		if ((v189 - v188) > (3 + 13)) then
			v192 = v192 - #v190;
		end
		v192 = math.max(v192, 3 - 2);
		return v192;
	else
		return #(v7:GetEnemiesInRange(132 - 92));
	end
end
local v109 = nil;
local function v110()
	if v7:IsMoving() then
		if not v109 then
			v109 = GetTime();
		end
		return GetTime() - v109;
	else
		if v109 then
			v109 = nil;
		end
		return 374 - (123 + 251);
	end
end
local v111 = nil;
local function v112()
	if (Currentpet == nil) then
		if not v111 then
			v111 = GetTime();
		end
		return GetTime() - v111;
	else
		if (Currentpet ~= nil) then
			v111 = nil;
		end
		return 0 - 0;
	end
end
local function v113(v171, v172)
	return (v171:gsub("{(.-)}", v172));
end
local function v114()
	local v173 = v26.Destruction_Pets.PetSelected;
	local v174 = v100();
	if ((v173 == "Imp") and (v174 ~= "Imp") and (v174 ~= "Leveling")) then
		if (v27.SummonImp:IsCastable() and not v7:IsMoving() and not v7:IsCasting(v27.SummonImp) and not v7:PrevGCDP(699 - (208 + 490), v27.SummonImp) and not (v7:IsMounted() or v7:IsInVehicle())) then
			if v16(v27.SummonImp, false) then
				return "summon Imp";
			end
		end
	elseif ((v173 == "Voidwalker") and (v174 ~= "Voidwalker") and (v174 ~= "Leveling")) then
		if (v27.SummonVoidwalker:IsCastable() and not v7:IsMoving() and not v7:IsCasting(v27.SummonVoidwalker) and not v7:PrevGCDP(1 + 0, v27.SummonVoidwalker) and not (v7:IsMounted() or v7:IsInVehicle())) then
			if v16(v27.SummonVoidwalker, false) then
				return "summon Voidwalker";
			end
		end
	elseif ((v173 == "Felhunter") and (v174 ~= "Felhunter") and (v174 ~= "Leveling")) then
		if (v27.SummonFelhunter:IsCastable() and not v7:IsMoving() and not v7:IsCasting(v27.SummonFelhunter) and not v7:PrevGCDP(1 + 0, v27.SummonFelhunter) and not (v7:IsMounted() or v7:IsInVehicle())) then
			if v16(v27.SummonFelhunter, false) then
				return "summon Felhunter";
			end
		end
	elseif ((v173 == "Sayaad") and (v174 ~= "Sayaad") and (v174 ~= "Leveling")) then
		if (v27.SummonSayaad:IsCastable() and not v7:IsMoving() and not v7:IsCasting(v27.SummonSayaad) and not v7:PrevGCDP(837 - (660 + 176), v27.SummonSayaad) and not (v7:IsMounted() or v7:IsInVehicle())) then
			if v16(v27.SummonSayaad, false) then
				return "summon Sayaad";
			end
		end
	end
	return false;
end
local function v115()
	if (v27.UnendingResolve:IsCastable() and v7:AffectingCombat() and (v7:HealthPercentage() <= v26.Defensives.UnendingResolveHP)) then
		if v16(v27.UnendingResolve) then
			return "UnendingResolve";
		end
	end
	if (v27.DarkPact:IsCastable() and v7:AffectingCombat() and (v7:HealthPercentage() <= v26.Defensives.DarkPactHP)) then
		if v16(v27.DarkPact) then
			return "DarkPact";
		end
	end
	if (v27.HealthFunnel:IsCastable() and not v7:IsMoving() and (v8:HealthPercentage() <= v26.Defensives.HealthFunnelHP) and (v8:HealthPercentage() > (0 + 0))) then
		if v16(v27.HealthFunnel) then
			return "HealthFunnel";
		end
	end
	if (v27.DrainLife:IsCastable() and v7:AffectingCombat() and v9:IsInRange(242 - (14 + 188)) and v7:CanAttack(v9) and not v7:IsMoving() and (v7:HealthPercentage() <= v26.Defensives.DrainLifeHP)) then
		if v16(v27.DrainLife) then
			return "DrainLife";
		end
	end
	if (v27.MortalCoil:IsReady() and v7:AffectingCombat() and v9:IsInRange(695 - (534 + 141)) and v7:CanAttack(v9) and (v7:HealthPercentage() <= v26.Defensives.MortalCoilHP)) then
		if v16(v27.MortalCoil) then
			return "MortalCoil";
		end
	end
end
local function v116()
	if (v27.SoulFire:IsReady() and not v7:IsMoving() and not v7:IsCasting(v27.SoulFire)) then
		if v16(v27.SoulFire) then
			return "soul_fire precombat 4";
		end
	end
	if (v27.Incinerate:IsCastable() and not v7:IsMoving() and not v7:IsCasting(v27.Incinerate)) then
		if v16(v27.Incinerate) then
			return "incinerate precombat 8";
		end
	end
end
local function v117()
	if v26.Commons.Enabled.Trinkets then
		if (v28.SpymastersWeb:IsEquippedAndReady() and (((v47:ID() == v28.SpymastersWeb:ID()) and IsTrinket1) or ((v48:ID() == v28.SpymastersWeb:ID()) and IsTrinket2)) and (((v79() >= (5 + 5)) and (v79() <= (18 + 2)) and (v7:BuffStack(v27.SpymastersReportBuff) >= (37 + 1)) and ((v46 > (504 - 264)) or (v46 <= (222 - 82)))) or (v46 <= (84 - 54)))) then
			if v16(v28.SpymastersWeb, true) then
				return "spymasters_web items 2";
			end
		end
		if (v28.KahetiShadowweaversEmblem:IsEquippedAndReady() and (((v47:ID() == v28.KahetiShadowweaversEmblem:ID()) and IsTrinket1) or ((v48:ID() == v28.KahetiShadowweaversEmblem:ID()) and IsTrinket2)) and (v7:BuffStack(v27.KahetiShadowweaversEmblemBuff) >= (3 + 2))) then
			if v16(v28.KahetiShadowweaversEmblem, true) then
				return "Kaheti_Shadowweavers_Emblem items 3";
			end
		end
		if (v28.MadQueensMandate:IsEquippedAndReady() and (((v47:ID() == v28.MadQueensMandate:ID()) and IsTrinket1) or ((v48:ID() == v28.MadQueensMandate:ID()) and IsTrinket2))) then
			if v16(v28.MadQueensMandate, true) then
				return "MadQueensMandate items 5";
			end
		end
		if (v47:IsReady() and v9:IsInRange(v53) and IsTrinket1 and not v59 and (((v39 or not v27.SummonInfernal:IsAvailable() or v40) and ((v71 == (1 + 0)) or v68 or not v48:HasCooldown() or v48:CooldownDown() or ((v71 == (398 - (115 + 281))) and (v27.SummonInfernal:CooldownRemains() > (46 - 26)) and not v39 and (v48:CooldownRemains() < v27.SummonInfernal:CooldownRemains()))) and v61 and not v65) or ((v69 + 1 + 0) >= v45))) then
			if v16(v47, true) then
				return "trinket1 (" .. v47:Name() .. ") items 4";
			end
		end
		if (v48:IsReady() and v9:IsInRange(v54) and IsTrinket2 and not v60 and (((v39 or not v27.SummonInfernal:IsAvailable() or v41) and ((v71 == (4 - 2)) or v67 or not v47:HasCooldown() or v47:CooldownDown() or ((v71 == (3 - 2)) and (v27.SummonInfernal:CooldownRemains() > (887 - (550 + 317))) and not v39 and (v47:CooldownRemains() < v27.SummonInfernal:CooldownRemains()))) and v62 and not v66) or ((v70 + (1 - 0)) >= v45))) then
			if v16(v48, true) then
				return "trinket2 (" .. v48:Name() .. ") items 6";
			end
		end
		if (v47:IsReady() and v9:IsInRange(v53) and IsTrinket1 and not v59 and not v61 and not v65 and ((not v61 and (v48:CooldownDown() or not v62)) or (v27.SummonInfernal:IsAvailable() and (v27.SummonInfernal:CooldownRemains() > (28 - 8)) and not v7:PrevGCDP(2 - 1, v27.SummonInfernal)) or not v27.SummonInfernal:IsAvailable())) then
			if v16(v47, true) then
				return "trinket1 (" .. v47:Name() .. ") items 8";
			end
		end
		if (v48:IsReady() and v9:IsInRange(v54) and IsTrinket2 and not v60 and not v62 and not v66 and ((not v62 and (v47:CooldownDown() or not v61)) or (v27.SummonInfernal:IsAvailable() and (v27.SummonInfernal:CooldownRemains() > (305 - (134 + 151))) and not v7:PrevGCDP(1666 - (970 + 695), v27.SummonInfernal)) or not v27.SummonInfernal:IsAvailable())) then
			if v16(v48, true) then
				return "trinket2 (" .. v48:Name() .. ") items 10";
			end
		end
	end
	if v26.Commons.Enabled.Items then
		local v193, v194, v195 = v7:GetUseableItems(v29, 30 - 14);
		if (v193 and v193:IsReady() and v9:IsInRange(v195)) then
			v13.CastMacro(1991 - (582 + 1408), nil, nil, v193);
			return "weapon cast";
		end
	end
end
local function v118()
	if (v26.Commons.Enabled.Potions and IsPotions and (v39 or not v27.SummonInfernal:IsAvailable() or not IsSummonInfernal)) then
		local v196 = v24.PotionSelected();
		if (v196 and v196:IsReady()) then
			v13.CastMacro(10 - 7, nil, nil, v196);
			return "Cast Potion";
		end
	end
	if (v27.Berserking:IsCastable() and IsRacials and (v39 or not v27.SummonInfernal:IsAvailable() or ((v46 < (v27.SummonInfernal:CooldownRemains() + (14 - 2))) and (v46 > (45 - 33))) or (v46 < v27.SummonInfernal:CooldownRemains()))) then
		if v16(v27.Berserking, true) then
			return "berserking ogcd 4";
		end
	end
	if (v27.BloodFury:IsCastable() and IsRacials and (v39 or not v27.SummonInfernal:IsAvailable() or ((v46 < (v27.SummonInfernal:CooldownRemains() + (1834 - (1195 + 629)) + (19 - 4))) and (v46 > (256 - (187 + 54)))) or (v46 < v27.SummonInfernal:CooldownRemains()))) then
		if v16(v27.BloodFury, true) then
			return "blood_fury ogcd 6";
		end
	end
	if (v27.Fireblood:IsCastable() and IsRacials and (v39 or not v27.SummonInfernal:IsAvailable() or ((v46 < (v27.SummonInfernal:CooldownRemains() + (790 - (162 + 618)) + 6 + 2)) and (v46 > (6 + 2))) or (v46 < v27.SummonInfernal:CooldownRemains()))) then
		if v16(v27.Fireblood, true) then
			return "fireblood ogcd 8";
		end
	end
	if (v27.AncestralCall:IsCastable() and IsRacials and (v39 or not v27.SummonInfernal:IsAvailable() or ((v46 < (v27.SummonInfernal:CooldownRemains() + (31 - 16))) and (v46 > (25 - 10))) or (v46 < v27.SummonInfernal:CooldownRemains()))) then
		if v16(v27.AncestralCall, true) then
			return "ancestral_call ogcd 10";
		end
	end
end
local function v119()
	if (v27.Conflagrate:IsCastable() and v27.Backdraft:IsAvailable() and v7:BuffDown(v27.BackdraftBuff) and (v42 >= (1 + 0)) and (v42 <= (1640 - (1373 + 263)))) then
		if v16(v27.Conflagrate) then
			return "conflagrate havoc 2";
		end
	end
	if (v27.SoulFire:IsCastable() and not v7:IsMoving() and (v27.SoulFire:CastTime() < v35) and (v42 < (1002.5 - (451 + 549)))) then
		if v16(v27.SoulFire) then
			return "soul_fire havoc 4";
		end
	end
	if (v27.Cataclysm:IsReady() and not v7:IsMoving() and IsCataclysm) then
		if v16(v27.Cataclysm, true) then
			return "cataclysm havoc 8";
		end
	end
	if (v27.Immolate:IsCastable() and (v42 < (2.5 + 2))) then
		if v24.CastTargetIf(v27.Immolate, Enemies8ySplash, "min", v83, v93, 62 - 22) then
			return "immolate havoc 10";
		end
	end
	if (v27.Wither:IsCastable() and (v42 < (6.5 - 2))) then
		if v24.CastTargetIf(v27.Wither, Enemies8ySplash, "min", v86, v99, 1424 - (746 + 638)) then
			return "wither havoc 12";
		end
	end
	if (v27.Shadowburn:IsReady() and (v44 <= (2 + 2)) and ((v27.Shadowburn:FullRechargeTime() <= (v7:GCD() * (4 - 1))) or ((v9:DebuffRemains(v27.EradicationDebuff) <= v7:GCD()) and v27.Eradication:IsAvailable() and not v27.ChaosBolt:InFlight() and not v27.DiabolicRitual:IsAvailable())) and (v27.ConflagrationofChaos:IsAvailable() or v27.BlisteringAtrophy:IsAvailable())) then
		if v16(v27.Shadowburn) then
			return "shadowburn havoc 14";
		end
	end
	if (v27.Shadowburn:IsReady() and (v44 <= (345 - (218 + 123))) and (v35 <= (v7:GCD() * (1584 - (1535 + 46))))) then
		if v16(v27.Shadowburn) then
			return "shadowburn havoc 16";
		end
	end
	if (v27.ChaosBolt:IsReady() and not v7:IsMoving() and (v27.ChaosBolt:CastTime() < v35) and ((not v27.ImprovedChaosBolt:IsAvailable() and (v44 <= (2 + 0))) or (v27.ImprovedChaosBolt:IsAvailable() and ((v27.Wither:IsAvailable() and v27.Inferno:IsAvailable() and (v44 <= (1 + 1))) or (((v27.Wither:IsAvailable() and v27.Cataclysm:IsAvailable()) or (not v27.Wither:IsAvailable() and v27.Inferno:IsAvailable())) and (v44 <= (563 - (306 + 254)))) or (not v27.Wither:IsAvailable() and v27.Cataclysm:IsAvailable() and (v44 <= (1 + 4))))))) then
		if v16(v27.ChaosBolt) then
			return "chaos_bolt havoc 18";
		end
	end
	if (v27.RainofFire:IsReady() and v107() and (v44 >= (5 - 2))) then
		if v16(v27.RainofFire) then
			return "rain_of_fire havoc 20";
		end
	end
	if (v27.ChannelDemonfire:IsReady() and not v7:IsMoving() and (v42 < (1471.5 - (899 + 568)))) then
		if v16(v27.ChannelDemonfire) then
			return "channel_demonfire havoc 22";
		end
	end
	if (v27.Conflagrate:IsCastable() and not v27.Backdraft:IsAvailable()) then
		if v16(v27.Conflagrate) then
			return "conflagrate havoc 24";
		end
	end
	if (v27.DimensionalRift:IsCastable() and IsDimensionalRift and (v42 < (3.7 + 1)) and ((v27.DimensionalRift:Charges() > (4 - 2)) or (v46 < v27.DimensionalRift:Cooldown()))) then
		if v16(v27.DimensionalRift, true) then
			return "dimensional_rift havoc 26";
		end
	end
	if (v27.Incinerate:IsCastable() and not v7:IsMoving() and (v27.Incinerate:CastTime() < v35)) then
		if v16(v27.Incinerate) then
			return "incinerate havoc 28";
		end
	end
end
local function v120()
	local v175 = v118();
	if v175 then
		return v175;
	end
	if (v26.Commons.Enabled.Trinkets or v26.Commons.Enabled.Trinkets) then
		local v197 = v117();
		if v197 then
			return v197;
		end
	end
	if (v27.Malevolence:IsReady() and IsMalevolence and (v27.SummonInfernal:CooldownRemains() >= (658 - (268 + 335))) and (v42 < (294.7 - (60 + 230))) and ((v44 <= ((575 - (426 + 146)) + v27.WitherDebuff:AuraActiveCount())) or (v3.CombatTime() > (4 + 26)))) then
		if v16(v27.Malevolence) then
			return "malevolence aoe 2";
		end
	end
	if (v27.RainofFire:IsReady() and v107() and (v76())) then
		if v16(v27.RainofFire) then
			return "rain_of_fire aoe 4";
		end
	end
	if (v27.Incinerate:IsCastable() and not v7:IsMoving() and v77() and (VarDRSum <= v27.Incinerate:CastTime()) and (VarDRSum > (v7:GCD() * (1456.25 - (282 + 1174))))) then
		if v16(v27.Incinerate) then
			return "incinerate aoe 6";
		end
	end
	if (v34 and (v35 > v7:GCD()) and (v44 < (816 - (569 + 242))) and (v27.SummonInfernal:CooldownDown() or not v27.SummonInfernal:IsAvailable())) then
		local v198 = v119();
		if v198 then
			return v198;
		end
	end
	if (v27.DimensionalRift:IsCastable() and IsDimensionalRift and (v42 < (11.7 - 7)) and ((v27.DimensionalRift:Charges() > (1 + 1)) or (v46 < v27.DimensionalRift:Cooldown()))) then
		if v16(v27.DimensionalRift, true) then
			return "dimensional_rift aoe 8";
		end
	end
	if (v27.RainofFire:IsReady() and v107() and ((not v27.Inferno:IsAvailable() and (v42 >= ((1028.5 - (706 + 318)) - ((1251.1 - (721 + 530)) * v27.ImmolateDebuff:AuraActiveCount())))) or (v42 >= ((1274.5 - (945 + 326)) - ((0.1 - 0) * v27.ImmolateDebuff:AuraActiveCount()))) or v7:BuffUp(v27.RitualofRuinBuff))) then
		if v16(v27.RainofFire) then
			return "rain_of_fire aoe 10";
		end
	end
	if (v27.WitherAbility:IsReady() and ((v27.WitherDebuff:AuraActiveCount() <= (4 + 0)) or (v3.CombatTime() > (715 - (271 + 429))))) then
		if v24.CastTargetIf(v27.WitherAbility, Enemies8ySplash, "min", v85, v95, 37 + 3) then
			return "wither aoe 12";
		end
	end
	if (v27.ChannelDemonfire:IsReady() and not v7:IsMoving() and ((v9:DebuffRemains(v27.ImmolateDebuff) + v9:DebuffRemains(v27.WitherDebuff)) > v75()) and v27.RagingDemonfire:IsAvailable()) then
		if v16(v27.ChannelDemonfire) then
			return "channel_demonfire aoe 14";
		end
	end
	if (v27.Shadowburn:IsReady() and ((v7:BuffUp(v27.MalevolenceBuff) and ((v27.Cataclysm:IsAvailable() and (v44 <= (1510 - (1408 + 92)))) or (v27.Inferno:IsAvailable() and (v44 <= (1092 - (461 + 625)))))) or (v27.Wither:IsAvailable() and v27.Cataclysm:IsAvailable() and (v44 <= (1294 - (993 + 295)))) or (not v27.Wither:IsAvailable() and v27.Cataclysm:IsAvailable() and (v44 <= (1 + 3))) or (v44 <= (1174 - (418 + 753)))) and ((((v27.Shadowburn:FullRechargeTime() <= (v7:GCD() * (2 + 1))) or ((v9:DebuffRemains(v27.EradicationDebuff) <= v7:GCD()) and v27.Eradication:IsAvailable() and not v27.ChaosBolt:InFlight() and not v27.DiabolicRitual:IsAvailable())) and (v27.ConflagrationofChaos:IsAvailable() or v27.BlisteringAtrophy:IsAvailable())) or (v45 <= (1 + 7)))) then
		if v16(v27.Shadowburn) then
			return "shadowburn aoe 16";
		end
	end
	if (v27.Shadowburn:IsReady() and (v44 < (2 + 2 + ((v18(v27.Cataclysm:IsAvailable()) + ((2 + 2) * v18(v27.Cataclysm:IsAvailable()))) * v18(v27.Wither:IsAvailable())))) and ((((v27.Shadowburn:FullRechargeTime() <= (v7:GCD() * (532 - (406 + 123)))) or ((v9:DebuffRemains(v27.EradicationDebuff) <= v7:GCD()) and v27.Eradication:IsAvailable() and not v27.ChaosBolt:InFlight() and not v27.DiabolicRitual:IsAvailable())) and (v27.ConflagrationofChaos:IsAvailable() or v27.BlisteringAtrophy:IsAvailable()) and (v44 < ((1774 - (1749 + 20)) + v18(v27.Wither:IsAvailable() and v27.Cataclysm:IsAvailable()) + v18(v34))) and (v9:TimeToDie() < (2 + 3))) or (v46 <= (1330 - (1249 + 73))))) then
		if v16(v27.Shadowburn) then
			return "shadowburn aoe 18";
		end
	end
	if (v27.RuinationAbility:IsReady() and not v7:IsMoving()) then
		if v16(v27.RuinationAbility) then
			return "ruination aoe 20";
		end
	end
	if (v27.RainofFire:IsReady() and v107() and v78() and v27.RainofChaos:IsAvailable()) then
		if v16(v27.RainofFire) then
			return "rain_of_fire aoe 22";
		end
	end
	if (v27.SoulFire:IsReady() and not v7:IsMoving() and v7:BuffUp(v27.DecimationBuff) and not v27.RagingDemonfire:IsAvailable() and v34) then
		if v16(v27.SoulFire) then
			return "soul_fire aoe 24";
		end
	end
	if (v27.SoulFire:IsReady() and not v7:IsMoving() and v7:BuffUp(v27.DecimationBuff) and (v27.ImmolateDebuff:AuraActiveCount() <= (2 + 2))) then
		if v24.CastTargetIf(v27.SoulFire, Enemies8ySplash, "min", v87, nil, not v9:IsSpellInRange(v27.SoulFire)) then
			return "soul_fire aoe 26";
		end
	end
	if (v27.InfernalBolt:IsReady() and not v7:IsMoving() and (v42 < (1147.5 - (466 + 679)))) then
		if v16(v27.InfernalBolt) then
			return "infernal_bolt aoe 28";
		end
	end
	if (v27.ChaosBolt:IsReady() and not v7:IsMoving() and (((v42 > ((6.5 - 3) - ((0.1 - 0) * v44))) and not v27.RainofFire:IsAvailable()) or (not v27.Wither:IsAvailable() and v27.Cataclysm:IsAvailable() and (v44 <= (1903 - (106 + 1794)))))) then
		if v16(v27.ChaosBolt) then
			return "chaos_bolt aoe 30";
		end
	end
	if (v27.Cataclysm:IsReady() and IsCataclysm and not v7:IsMoving()) then
		if v16(v27.Cataclysm, true) then
			return "cataclysm aoe 32";
		end
	end
	if (v27.Havoc:IsReady() and (((v27.SummonInfernal:CooldownDown() or not v27.SummonInfernal:IsAvailable() or not IsSummonInfernal or (v27.Inferno:IsAvailable() and (v44 > (2 + 2)))) and ((v27.Malevolence:CooldownRemains() > (4 + 11)) or not v27.Malevolence:IsAvailable())) or (v3.CombatTime() < (14 - 9)))) then
		if v24.CastTargetIf(v27.Havoc, v43, "min", v82, v88, 108 - 68, nil, nil, false, true) then
			return "havoc aoe 25";
		end
	end
	if (v27.WitherAbility:IsReady() and (v27.WitherDebuff:AuraActiveCount() <= v44)) then
		if v24.CastTargetIf(v27.WitherAbility, Enemies8ySplash, "min", v86, v96, 154 - (4 + 110)) then
			return "wither aoe 34";
		end
	end
	if (v27.Immolate:IsCastable() and not v7:IsMoving() and (((v27.ImmolateDebuff:AuraActiveCount() <= (590 - (57 + 527))) and not (v27.DiabolicRitual:IsAvailable() and v27.Inferno:IsAvailable())) or (v27.ImmolateDebuff:AuraActiveCount() <= (1431 - (41 + 1386))))) then
		if v24.CastTargetIf(v27.Immolate, Enemies8ySplash, "min", v83, v89, 143 - (17 + 86)) then
			return "immolate aoe 36";
		end
	end
	if (v27.SummonInfernal:IsReady() and IsSummonInfernal) then
		if v16(v27.SummonInfernal, true) then
			return "summon_infernal aoe 38";
		end
	end
	if (v27.RainofFire:IsReady() and v107() and v9:DebuffDown(v27.PyrogenicsDebuff) and (v44 <= (3 + 1)) and not v27.DiabolicRitual:IsAvailable()) then
		if v16(v27.RainofFire) then
			return "rain_of_fire aoe 40";
		end
	end
	if (v27.ChannelDemonfire:IsReady() and not v7:IsMoving() and ((v9:DebuffRemains(v27.ImmolateDebuff) + v9:DebuffRemains(v27.WitherDebuff)) > v75())) then
		if v16(v27.ChannelDemonfire) then
			return "channel_demonfire aoe 42";
		end
	end
	if (v27.Immolate:IsCastable() and not v7:IsMoving()) then
		if v24.CastTargetIf(v27.Immolate, Enemies8ySplash, "min", v83, v90, 89 - 49) then
			return "immolate aoe 44";
		end
	end
	if (v27.Immolate:IsCastable() and not v7:IsMoving() and not v7:IsMoving()) then
		if v24.CastTargetIf(v27.Immolate, Enemies8ySplash, "min", v83, v91, 115 - 75) then
			return "immolate aoe 46";
		end
	end
	if (v27.DimensionalRift:IsCastable() and IsDimensionalRift) then
		if v16(v27.DimensionalRift, true) then
			return "dimensional_rift aoe 48";
		end
	end
	if (v27.SoulFire:IsCastable() and not v7:IsMoving() and (v7:BuffUp(v27.DecimationBuff))) then
		if v16(v27.SoulFire) then
			return "soul_fire aoe 50";
		end
	end
	if (v27.Incinerate:IsCastable() and not v7:IsMoving() and v27.FireandBrimstone:IsAvailable() and v7:BuffUp(v27.BackdraftBuff)) then
		if v16(v27.Incinerate) then
			return "incinerate aoe 52";
		end
	end
	if (v27.Conflagrate:IsCastable() and ((v7:BuffStack(v27.BackdraftBuff) < (168 - (122 + 44))) or not v27.Backdraft:IsAvailable())) then
		if v16(v27.Conflagrate) then
			return "conflagrate aoe 54";
		end
	end
	if (v27.Incinerate:IsCastable() and not v7:IsMoving()) then
		if v16(v27.Incinerate) then
			return "incinerate aoe 56";
		end
	end
end
local function v121()
	if (v26.Commons.Enabled.Trinkets or v26.Commons.Enabled.Items) then
		local v199 = v117();
		if v199 then
			return v199;
		end
	end
	local v176 = v118();
	if v176 then
		return v176;
	end
	if (v34 and (v35 > v7:GCD())) then
		local v200 = v119();
		if v200 then
			return v200;
		end
	end
	v33 = (v27.Havoc:CooldownRemains() <= (8 - 3)) or v27.Mayhem:IsAvailable();
	if (v27.Malevolence:IsReady() and IsMalevolence and (v27.SummonInfernal:CooldownDown() or not v27.SummonInfernal:IsAvailable())) then
		if v16(v27.Malevolence) then
			return "malevolence cleave 2";
		end
	end
	if (v27.Havoc:IsReady() and (v27.SummonInfernal:CooldownDown() or not v27.SummonInfernal:IsAvailable())) then
		if v24.CastTargetIf(v27.Havoc, v43, "min", v82, v88, 132 - 92, nil, nil, false, true) then
			return "havoc cleave 3";
		end
	end
	if (v27.ChaosBolt:IsReady() and not v7:IsMoving() and (v76())) then
		if v16(v27.ChaosBolt) then
			return "chaos_bolt cleave 4";
		end
	end
	if (v27.SoulFire:IsReady() and not v7:IsMoving() and v7:BuffUp(v27.DecimationBuff) and ((v42 <= (4 + 0)) or (v7:BuffRemains(v27.DecimationBuff) <= (v7:GCD() * (1 + 1)))) and (v9:DebuffRemains(v27.ConflagrateDebuff) >= v27.SoulFire:ExecuteTime()) and v27.Havoc:CooldownDown()) then
		if v16(v27.SoulFire) then
			return "soul_fire cleave 6";
		end
	end
	if (v27.WitherAbility:IsReady() and v27.InternalCombustion:IsAvailable() and not v27.SoulFire:InFlight()) then
		if v24.CastTargetIf(v27.WitherAbility, Enemies8ySplash, "min", v86, v97, 81 - 41) then
			return "wither cleave 8";
		end
	end
	if (v27.WitherAbility:IsReady() and not v27.InternalCombustion:IsAvailable() and not v27.SoulFire:InFlight()) then
		if v24.CastTargetIf(v27.WitherAbility, Enemies8ySplash, "min", v86, v98, 105 - (30 + 35)) then
			return "wither cleave 8";
		end
	end
	if (v27.Conflagrate:IsCastable() and ((v27.RoaringBlaze:IsAvailable() and (v27.Conflagrate:FullRechargeTime() <= (v7:GCD() * (2 + 0)))) or ((v27.Conflagrate:Recharge() <= (1265 - (1043 + 214))) and v77() and (VarDRSum < v7:GCD()) and not v33))) then
		if v16(v27.Conflagrate) then
			return "conflagrate cleave 10";
		end
	end
	if (v27.Shadowburn:IsReady() and ((((v27.Shadowburn:FullRechargeTime() <= (v7:GCD() * (11 - 8))) or ((v9:DebuffRemains(v27.EradicationDebuff) <= v7:GCD()) and v27.Eradication:IsAvailable() and not v27.ChaosBolt:InFlight() and not v27.DiabolicRitual:IsAvailable())) and (v27.ConflagrationofChaos:IsAvailable() or v27.BlisteringAtrophy:IsAvailable())) or (v45 <= (1220 - (323 + 889))))) then
		if v16(v27.Shadowburn) then
			return "shadowburn cleave 12";
		end
	end
	if (v27.ChaosBolt:IsReady() and not v7:IsMoving() and (v7:BuffUp(v27.RitualofRuinBuff))) then
		if v16(v27.ChaosBolt) then
			return "chaos_bolt cleave 14";
		end
	end
	if ((v27.SummonInfernal:CooldownRemains() >= (242 - 152)) and v27.RainofChaos:IsAvailable()) then
		if (v27.RainofFire:IsReady() and v107()) then
			if v16(v27.RainofFire) then
				return "rain_of_fire cleave 16";
			end
		end
		if v27.Shadowburn:IsReady() then
			if v16(v27.Shadowburn) then
				return "shadowburn cleave 18";
			end
		end
		if (v27.ChaosBolt:IsReady() and not v7:IsMoving()) then
			if v16(v27.ChaosBolt) then
				return "chaos_bolt cleave 20";
			end
		end
	end
	if (v27.RuinationAbility:IsReady() and not v7:IsMoving() and ((v9:DebuffRemains(v27.EradicationDebuff) >= v27.RuinationAbility:ExecuteTime()) or not v27.Eradication:IsAvailable() or not v27.Shadowburn:IsAvailable())) then
		if v16(v27.RuinationAbility) then
			return "ruination cleave 22";
		end
	end
	if (v27.Cataclysm:IsCastable() and not v7:IsMoving() and IsCataclysm) then
		if v16(v27.Cataclysm, true) then
			return "cataclysm cleave 24";
		end
	end
	if (v27.ChannelDemonfire:IsReady() and v27.RagingDemonfire:IsAvailable() and (((v9:DebuffRemains(v27.ImmolateDebuff) + v9:DebuffRemains(v27.WitherDebuff)) - ((585 - (361 + 219)) * v18(v27.ChaosBolt:InFlight() and v27.InternalCombustion:IsAvailable()))) > v27.ChannelDemonfire:CastTime())) then
		if v16(v27.ChannelDemonfire) then
			return "channel_demonfire cleave 26";
		end
	end
	if (v27.SoulFire:IsCastable() and not v7:IsMoving() and (v42 <= (323.5 - (53 + 267))) and ((v9:DebuffRemains(v27.RoaringBlazeDebuff) > (v27.SoulFire:CastTime() + v27.SoulFire:TravelTime())) or (not v27.RoaringBlaze:IsAvailable() and v7:BuffUp(v27.BackdraftBuff))) and not v33) then
		if v16(v27.SoulFire) then
			return "soul_fire cleave 28";
		end
	end
	if (v27.Immolate:IsCastable() and not v7:IsMoving()) then
		if v24.CastTargetIf(v27.Immolate, Enemies8ySplash, "min", v83, v92, 10 + 30) then
			return "immolate cleave 30";
		end
	end
	if (v27.SummonInfernal:IsCastable() and IsSummonInfernal) then
		if v16(v27.SummonInfernal, true) then
			return "summon_infernal cleave 32";
		end
	end
	if (v27.Incinerate:IsCastable() and not v7:IsMoving() and v27.DiabolicRitual:IsAvailable() and v77() and ((((VarDRSum - (415 - (15 + 398))) - (v18(not v32) * v27.ChaosBolt:CastTime())) - (v18(v32) * v7:GCD())) <= (982 - (18 + 964)))) then
		if v16(v27.Incinerate) then
			return "incinerate cleave 34";
		end
	end
	if (v27.RainofFire:IsReady() and v107() and v37 and not v27.Wither:IsAvailable() and v7:BuffUp(v27.RainofChaosBuff)) then
		if v16(v27.RainofFire) then
			return "rain_of_fire cleave 36";
		end
	end
	if (v27.RainofFire:IsReady() and v107() and (v30 >= (3 - 2)) and not v27.Wither:IsAvailable() and v27.Pyrogenics:IsAvailable() and (v9:DebuffRemains(v27.PyrogenicsDebuff) <= v7:GCD()) and (not v27.RainofChaos:IsAvailable() or (v27.SummonInfernal:CooldownRemains() >= (v7:GCD() * (2 + 1)))) and v37) then
		if v16(v27.RainofFire) then
			return "rain_of_fire cleave 38";
		end
	end
	if (v27.RainofFire:IsReady() and v107() and v31 and v37 and ((v27.SummonInfernal:CooldownRemains() >= (v7:GCD() * (2 + 1))) or not v27.RainofChaos:IsAvailable())) then
		if v16(v27.RainofFire) then
			return "rain_of_fire cleave 40";
		end
	end
	if (v27.SoulFire:IsCastable() and not v7:IsMoving() and (v42 <= (854 - (20 + 830))) and v27.Mayhem:IsAvailable()) then
		if v16(v27.SoulFire) then
			return "soul_fire cleave 42";
		end
	end
	if (v27.ChaosBolt:IsReady() and not v7:IsMoving() and not v32 and v38 and ((v27.SummonInfernal:CooldownRemains() >= (v7:GCD() * (3 + 0))) or (v42 > (130 - (116 + 10))) or not v27.RainofChaos:IsAvailable())) then
		if v16(v27.ChaosBolt) then
			return "chaos_bolt cleave 44";
		end
	end
	if (v27.ChannelDemonfire:IsReady() and not v7:IsMoving()) then
		if v16(v27.ChannelDemonfire) then
			return "channel_demonfire cleave 46";
		end
	end
	if (v27.DimensionalRift:IsCastable() and IsDimensionalRift) then
		if v16(v27.DimensionalRift, true) then
			return "dimensional_rift cleave 48";
		end
	end
	if (v27.InfernalBolt:IsReady() and not v7:IsMoving()) then
		if v16(v27.InfernalBolt) then
			return "infernal_bolt cleave 50";
		end
	end
	if (v27.Conflagrate:IsCastable() and ((v27.Conflagrate:Charges() > (v27.Conflagrate:MaxCharges() - (1 + 0))) or (v46 < (v7:GCD() * v27.Conflagrate:Charges())))) then
		if v16(v27.Conflagrate) then
			return "conflagrate cleave 52";
		end
	end
	if (v27.Incinerate:IsCastable() and not v7:IsMoving()) then
		if v16(v27.Incinerate) then
			return "incinerate cleave 54";
		end
	end
end
local function v122()
	v36 = 738 - (542 + 196);
	v37 = (v42 >= (6 - 3)) or (((v27.SecretsoftheCoven:IsAvailable() and v7:BuffUp(v27.InfernalBoltBuff)) or v7:BuffUp(v27.DecimationBuff)) and (v42 >= (1 + 2)));
	v38 = v37 or (v78() and (v42 >= (2 + 1)));
	for v185, v186 in pairs(Enemies8ySplash) do
		local v187 = v18(v186:DebuffUp(v27.HavocDebuff));
		v36 = v36 + v20(v186:DebuffRemains(v27.ImmolateDebuff) * v187, v186:DebuffRemains(v27.WitherDebuff) * v187);
	end
	v39 = v78() or (v27.SummonInfernal:TimeSinceLastCast() < (8 + 12));
	local v177 = ((v57 > (0 - 0)) and v57) or (2 - 1);
	v40 = (((v21((v46 / v177) + (1552 - (1126 + 425))) ~= v21((v46 + ((525 - (118 + 287)) - v27.SummonInfernal:CooldownRemains())) / (470 - 350))) and ((v21((v46 / v177) + (1122 - (118 + 1003)))) ~= (v21(((v46 - v27.SummonInfernal:CooldownRemains()) / v177) + (2 - 1))))) or ((v21((v46 / v177) + (378 - (142 + 235))) == v21((v46 + ((544 - 424) - v27.SummonInfernal:CooldownRemains())) / (27 + 93))) and ((((v46 - (v27.SummonInfernal:CooldownRemains() % v177)) - v27.SummonInfernal:CooldownRemains()) - v69) > (977 - (553 + 424))))) and (v27.SummonInfernal:CooldownRemains() > (37 - 17));
	local v178 = ((v58 > (0 + 0)) and v58) or (1 + 0);
	v41 = (((v21((v46 / v178) + 1 + 0) ~= v21((v46 + ((52 + 68) - v27.SummonInfernal:CooldownRemains())) / (69 + 51))) and ((v21((v46 / v178) + (2 - 1))) ~= (v21(((v46 - v27.SummonInfernal:CooldownRemains()) / v178) + (2 - 1))))) or ((v21((v46 / v178) + (2 - 1)) == v21((v46 + ((35 + 85) - v27.SummonInfernal:CooldownRemains())) / (579 - 459))) and ((((v46 - (v27.SummonInfernal:CooldownRemains() % v178)) - v27.SummonInfernal:CooldownRemains()) - v70) > (753 - (239 + 514))))) and (v27.SummonInfernal:CooldownRemains() > (8 + 12));
end
local function v123()
	v24.HealthPotions();
	if v24.ShouldStopCastUpdate() then
		v13.CastMacro(1335 - (797 + 532), true);
		return "Stop Cast For Silence";
	end
	local v179 = v100();
	v110();
	v101();
	v112();
	BurningRushToggle = v13.ToggleIconFrame:GetToggle(1 + 0);
	InterruptToggle = v13.ToggleIconFrame:GetToggle(1 + 1);
	Smallcds = v13.ToggleIconFrame:GetToggle(6 - 3);
	local v180 = not v7:AffectingCombat() or not v9:AffectingCombat() or v9:IsDummy();
	v43 = v7:GetEnemiesInRange(1242 - (373 + 829));
	EnemiesRangeOOCCount = v108() or #v43;
	Enemies8ySplash = v9:GetEnemiesInSplashRange(743 - (476 + 255));
	if v14() then
		v44 = EnemiesRangeOOCCount;
	else
		v44 = 1131 - (369 + 761);
	end
	IsRacials = v104(v26.Destruction_TTD.RacialsTTD) and v103(v26.Destruction_CDUSE.Racials);
	IsPotions = v104(v26.Destruction_TTD.PotionsTTD) and (v26.Destruction_CDUSE.Potionswhensolo or (not v26.Destruction_CDUSE.Potionswhensolo and not v24.ISSolo())) and v103(v26.Destruction_CDUSE.Potions);
	IsTrinket1 = v104(v26.Destruction_TTD.TrinketsTTD) and v103(v26.Destruction_CDUSE.Trinket1);
	IsTrinket2 = v104(v26.Destruction_TTD.TrinketsTTD) and v103(v26.Destruction_CDUSE.Trinket2);
	IsSummonInfernal = v107() and v104(v26.Destruction_TTD.SummonInfernalTTD) and v103(v26.Destruction_CDUSE.SummonInfernal);
	IsDimensionalRift = v104(v26.Destruction_TTD.DimensionalRiftTTD) and v103(v26.Destruction_CDUSE.DimensionalRift);
	IsMalevolence = v104(v26.Destruction_TTD.MalevolenceTTD) and v103(v26.Destruction_CDUSE.Malevolence);
	IsCataclysm = v107() and v104(v26.Destruction_TTD.CataclysmTTD) and v103(v26.Destruction_CDUSE.Cataclysm);
	if (v24.TargetIsValid() or v7:AffectingCombat()) then
		GCDMax = v7:GCD() + 0.25 + 0;
		v34, v35, v36 = v74(v43);
		v45 = v3.BossFightRemains();
		v102 = true;
		v46 = v45;
		if (v46 == (20181 - 9070)) then
			v102 = false;
			v46 = v3.FightRemains(v43, false);
		end
		v42 = v7:SoulShardsP();
		VarDRMotherBuffRemains = v7:BuffRemains(v27.DiabolicRitualMotherBuff);
		VarDROverlordBuffRemains = v7:BuffRemains(v27.DiabolicRitualOverlordBuff);
		VarDRPitLordBuffRemains = v7:BuffRemains(v27.DiabolicRitualPitLordBuff);
		VarDRSum = VarDRMotherBuffRemains + VarDROverlordBuffRemains + VarDRPitLordBuffRemains;
		VarSFCDRPlusCT = v27.SoulFire:CooldownRemains() + v27.SoulFire:CastTime();
	end
	if ((v179 == nil) and ((v112() > (9 - 4)) or v7:AffectingCombat()) and not (v7:IsMounted() or v7:IsInVehicle()) and v27.FelDomination:IsReady() and (((v26.Destruction_Pets.FelDomination == "only Infight") and v7.AffectingCombat) or ((v26.Destruction_Pets.FelDomination == "only out of Fight") and not v7.AffectingCombat) or (v26.Destruction_Pets.FelDomination == "both")) and (not v8:IsActive() or (v8:HealthPercentage() < (239 - (64 + 174))) or v7:BuffUp(v27.GrimoireofSacrificeBuff))) then
		if v16(v27.FelDomination) then
			return "FelDomination missing Pet";
		end
	end
	v23 = ((v112() > (1 + 4)) or v7:AffectingCombat()) and v114() and not (v7:IsMounted() or v7:IsInVehicle());
	if v23 then
		return v23;
	end
	if (v27.GrimoireofSacrifice:IsCastable() and not v7:IsMoving() and (v8:HealthPercentage() > (0 - 0))) then
		if v16(v27.GrimoireofSacrifice) then
			return "grimoire_of_sacrifice";
		end
	end
	if BurningRushToggle then
		if ((v26.Destruction.BurningRush == "always") or ((v26.Destruction.BurningRush == "only infight") and v7:AffectingCombat()) or ((v26.Destruction.BurningRush == "only out of fight") and not v7:AffectingCombat())) then
			if (v27.BurningRush:IsCastable() and v7:IsMoving() and ((v110() > (337 - (144 + 192))) or not v7:AffectingCombat()) and v7:BuffDown(v27.BurningRush) and (v7:HealthPercentage() > v26.Destruction.BurningRushcancel) and not v7:IsMounted()) then
				if v16(v27.BurningRush) then
					return "Burning Rush";
				end
			end
		end
		if (v7:BuffUp(v27.BurningRush) and (((v26.Destruction.BurningRush == "only infight") and not v7:AffectingCombat()) or ((v26.Destruction.BurningRush == "only out of fight") and v7:AffectingCombat()) or (v7:HealthPercentage() < v26.Destruction.BurningRushcancel) or (not v7:IsMoving() and v7:BuffUp(v27.BurningRush)))) then
			v13.CastMacro(218 - (42 + 174), false, nil, v27.BurningRush);
			return "Burnind Rush cancel";
		end
	end
	v23 = not v7:IsCasting(v27.Banish) and v24.IncorpCycle(v27.Banish, 23 + 7, false, false);
	if v23 then
		return v23;
	end
	if (v27.Soulstone:IsReady() and not v7:IsCasting(v27.Soulstone) and v7:AffectingCombat() and not v7:IsMoving()) then
		if (v9:UnitIsFriend() and v9:UnitIsPlayer() and v9:Exists() and v9:IsDeadOrGhost() and v9:IsInRange(34 + 6)) then
			v13.Cast(v27.Soulstone);
			return "Soulstone on Target";
		end
		if (v12:UnitIsFriend() and v12:UnitIsPlayer() and v12:Exists() and v12:IsDeadOrGhost() and v12:IsInRange(17 + 23)) then
			v13.CastTarget(v27.Soulstone, v13.TName().MOUSEOVER);
			return "Soulstone on Mouseover";
		end
	end
	v23 = v115();
	if v23 then
		return v23;
	end
	if v24.TargetIsValid() then
		if (not v26.Destruction.AttackonlyinCombat or (v26.Destruction.AttackonlyinCombat and v9:AffectingCombat())) then
			if not v105(v6.Target) then
				if not v7:AffectingCombat() then
					v23 = v116();
					if v23 then
						return v23;
					end
				end
				if InterruptToggle then
					v23 = v24.InterruptCycle(v27.SpellLockcast, 1544 - (363 + 1141), true, nil, false);
					if v23 then
						return v23;
					end
					v23 = v24.InterruptCycle(v27.SpellLock, 1620 - (1183 + 397), true, nil, false);
					if v23 then
						return v23;
					end
				end
				v122();
				if v9:IsInRange(121 - 81) then
					if (v14() and (v44 >= (3 + 0))) then
						local v202 = v120();
						if v202 then
							return v202;
						end
					end
					if (v14() and (v44 > (1 + 0))) then
						local v203 = v121();
						if v203 then
							return v203;
						end
					end
					local v201 = v118();
					if v201 then
						return v201;
					end
					if (v26.Commons.Enabled.Trinkets or v26.Commons.Enabled.Trinkets) then
						local v204 = v117();
						if v204 then
							return v204;
						end
					end
					if (v27.Malevolence:IsReady() and IsMalevolence and (v27.SummonInfernal:CooldownRemains() >= (2030 - (1913 + 62)))) then
						if v16(v27.Malevolence) then
							return "malevolence main 2";
						end
					end
					if (v27.ChaosBolt:IsReady() and not v7:IsMoving() and (v76())) then
						if v16(v27.ChaosBolt) then
							return "chaos_bolt main 4";
						end
					end
					if (v27.SoulFire:IsCastable() and not v7:IsMoving() and v7:BuffUp(v27.DecimationBuff) and ((v42 <= (3 + 1)) or (v7:BuffRemains(v27.DecimationBuff) <= (v7:GCD() * (5 - 3)))) and (v9:DebuffRemains(v27.ConflagrateDebuff) >= v27.SoulFire:ExecuteTime())) then
						if v16(v27.SoulFire) then
							return "soul_fire main 6";
						end
					end
					if (v27.WitherAbility:IsReady() and v27.InternalCombustion:IsAvailable() and (((v9:DebuffRemains(v27.WitherDebuff) - ((1938 - (565 + 1368)) * v18(v27.ChaosBolt:InFlight()))) < (v27.WitherDebuff:MaxDuration() * (15 - 11))) or (v9:DebuffRemains(v27.WitherDebuff) < (1664 - (1477 + 184))) or (((v9:DebuffRemains(v27.WitherDebuff) - v27.ChaosBolt:ExecuteTime()) < (6 - 1)) and v27.ChaosBolt:IsReady())) and (not v27.SoulFire:IsAvailable() or (VarSFCDRPlusCT > (v9:DebuffRemains(v27.WitherDebuff) - (5 + 0)))) and (v9:TimeToDie() > (864 - (564 + 292))) and not v27.SoulFire:InFlight()) then
						if v16(v27.WitherAbility) then
							return "wither main 8";
						end
					end
					if (v27.Conflagrate:IsReady() and ((v27.RoaringBlaze:IsAvailable() and (v9:DebuffRemains(v27.RoaringBlazeDebuff) < (1.5 - 0))) or (v27.Conflagrate:FullRechargeTime() <= (v7:GCD() * (5 - 3))) or ((v27.Conflagrate:Recharge() <= (312 - (244 + 60))) and v77() and (VarDRSum < v7:GCD()) and (v42 >= (1.5 + 0))))) then
						if v16(v27.Conflagrate) then
							return "conflagrate main 10";
						end
					end
					if (v27.Shadowburn:IsReady() and ((((v27.Shadowburn:FullRechargeTime() <= (v7:GCD() * (479 - (41 + 435)))) or ((v9:DebuffRemains(v27.EradicationDebuff) <= v7:GCD()) and v27.Eradication:IsAvailable() and not v27.ChaosBolt:InFlight() and not v27.DiabolicRitual:IsAvailable())) and (v27.ConflagrationofChaos:IsAvailable() or v27.BlisteringAtrophy:IsAvailable())) or (v45 <= (1009 - (938 + 63))))) then
						if v16(v27.Shadowburn) then
							return "shadowburn main 12";
						end
					end
					if (v27.ChaosBolt:IsReady() and not v7:IsMoving() and (v7:BuffUp(v27.RitualofRuinBuff))) then
						if v16(v27.ChaosBolt) then
							return "chaos_bolt main 14";
						end
					end
					if (v27.Shadowburn:IsReady() and (((v27.SummonInfernal:CooldownRemains() >= (70 + 20)) and v27.RainofChaos:IsAvailable()) or v7:BuffUp(v27.MalevolenceBuff))) then
						if v16(v27.Shadowburn) then
							return "shadowburn main 16";
						end
					end
					if (v27.ChaosBolt:IsReady() and not v7:IsMoving() and (((v27.SummonInfernal:CooldownRemains() >= (1215 - (936 + 189))) and v27.RainofChaos:IsAvailable()) or v7:BuffUp(v27.MalevolenceBuff))) then
						if v16(v27.ChaosBolt) then
							return "chaos_bolt main 16";
						end
					end
					if (v27.RuinationAbility:IsReady() and not v7:IsMoving() and ((v9:DebuffRemains(v27.EradicationDebuff) >= v27.RuinationAbility:ExecuteTime()) or not v27.Eradication:IsAvailable() or not v27.Shadowburn:IsAvailable())) then
						if v16(v27.RuinationAbility) then
							return "ruination main 18";
						end
					end
					if (v27.Cataclysm:IsReady() and not v7:IsMoving() and IsCataclysm and ((v9:DebuffRefreshable(v27.ImmolateDebuff) and not v27.Wither:IsAvailable()) or (v27.Wither:IsAvailable() and v9:DebuffRefreshable(v27.WitherDebuff)))) then
						if v16(v27.Cataclysm, true) then
							return "cataclysm main 20";
						end
					end
					if (v27.ChannelDemonfire:IsReady() and not v7:IsMoving() and v27.RagingDemonfire:IsAvailable() and (((v9:DebuffRemains(v27.ImmolateDebuff) + v9:DebuffRemains(v27.WitherDebuff)) - ((2 + 3) * v18(v27.ChaosBolt:InFlight() and v27.InternalCombustion:IsAvailable()))) > v27.ChannelDemonfire:CastTime())) then
						if v16(v27.ChannelDemonfire) then
							return "channel_demonfire main 22";
						end
					end
					if (v27.WitherAbility:IsReady() and not v27.InternalCombustion:IsAvailable() and (((v9:DebuffRemains(v27.WitherDebuff) - ((1618 - (1565 + 48)) * v18(v27.ChaosBolt:InFlight()))) < (v27.WitherDebuff:MaxDuration() * (0.3 + 0))) or (v9:DebuffRemains(v27.WitherDebuff) < (1141 - (782 + 356)))) and (not v27.Cataclysm:IsAvailable() or not IsCataclysm or (v27.Cataclysm:CooldownRemains() > v9:DebuffRemains(v27.WitherDebuff))) and (not v27.SoulFire:IsAvailable() or (VarSFCDRPlusCT > v9:DebuffRemains(v27.WitherDebuff))) and (v9:TimeToDie() > (275 - (176 + 91))) and not v27.SoulFire:InFlight()) then
						if v16(v27.WitherAbility) then
							return "wither main 24";
						end
					end
					if (v27.Immolate:IsReady() and not v7:IsMoving() and (((v9:DebuffRemains(v27.ImmolateDebuff) - ((13 - 8) * v18(v27.ChaosBolt:InFlight() and v27.InternalCombustion:IsAvailable()))) < (v27.ImmolateDebuff:MaxDuration() * (0.3 - 0))) or (v9:DebuffRemains(v27.ImmolateDebuff) < (1095 - (975 + 117))) or (((v9:DebuffRemains(v27.ImmolateDebuff) - v27.ChaosBolt:ExecuteTime()) < (1880 - (157 + 1718))) and v27.InternalCombustion:IsAvailable() and v27.ChaosBolt:IsReady())) and (not v27.Cataclysm:IsAvailable() or not IsCataclysm or (v27.Cataclysm:CooldownRemains() > v9:DebuffRemains(v27.ImmolateDebuff))) and (not v27.SoulFire:IsAvailable() or (VarSFCDRPlusCT > (v9:DebuffRemains(v27.ImmolateDebuff) - ((5 + 0) * v18(v27.InternalCombustion:IsAvailable()))))) and (v9:TimeToDie() > (28 - 20)) and not v27.SoulFire:InFlight()) then
						if v16(v27.Immolate) then
							return "immolate main 26";
						end
					end
					if (v27.SummonInfernal:IsCastable() and IsSummonInfernal) then
						if v16(v27.SummonInfernal, true) then
							return "summon_infernal main 28";
						end
					end
					if (v27.Incinerate:IsCastable() and not v7:IsMoving() and v27.DiabolicRitual:IsAvailable() and v77() and ((((VarDRSum - (6 - 4)) - (v18(not v32) * v27.ChaosBolt:CastTime())) - (v18(v32) * v7:GCD())) <= (1018 - (697 + 321)))) then
						if v16(v27.Incinerate) then
							return "incinerate main 30";
						end
					end
					if (v27.ChaosBolt:IsReady() and not v7:IsMoving() and v38 and ((v27.SummonInfernal:CooldownRemains() >= (v7:GCD() * (7 - 4))) or (v42 > (8 - 4)) or not v27.RainofChaos:IsAvailable())) then
						if v16(v27.ChaosBolt) then
							return "chaos_bolt main 32";
						end
					end
					if (v27.ChannelDemonfire:IsReady() and not v7:IsMoving()) then
						if v16(v27.ChannelDemonfire) then
							return "channel_demonfire main 34";
						end
					end
					if (v27.DimensionalRift:IsCastable() and IsDimensionalRift) then
						if v16(v27.DimensionalRift, true) then
							return "dimensional_rift main 36";
						end
					end
					if (v27.InfernalBolt:IsCastable() and not v7:IsMoving()) then
						if v16(v27.InfernalBolt) then
							return "infernal_bolt main 38";
						end
					end
					if (v27.Conflagrate:IsCastable() and ((v27.Conflagrate:Charges() > (v27.Conflagrate:MaxCharges() - (2 - 1))) or (v46 < (v7:GCD() * v27.Conflagrate:Charges())))) then
						if v16(v27.Conflagrate) then
							return "conflagrate main 40";
						end
					end
					if (v27.SoulFire:IsCastable() and not v7:IsMoving() and (v7:BuffUp(v27.BackdraftBuff))) then
						if v16(v27.SoulFire) then
							return "soul_fire main 42";
						end
					end
					if (v27.Incinerate:IsCastable() and not v7:IsMoving()) then
						if v16(v27.Incinerate) then
							return "incinerate main 36";
						end
					end
				end
			end
		end
	end
end
local function v124()
	v13.ResetToggle();
	v26.Destruction.Display();
	v27.ImmolateDebuff:RegisterAuraTracking();
	v27.WitherDebuff:RegisterAuraTracking();
	local v181 = {Burningreushvalue=v27.BurningRush:Name()};
	local v182 = "/cancelaura {Burningreushvalue}";
	v13:UpdateMacro("macro1", "/use 16");
	v13:UpdateMacro("macro2", v113(v182, v181));
	v13:UpdateMacro("macro6", "/stopcasting");
	v13.ToggleIconFrame:AddButtonCustom("B", 1 + 0, "BurningRush", "burningrush");
	v13.ToggleIconFrame:AddButtonCustom("I", 3 - 1, "Interrupt", "interrupt");
	v13.ToggleIconFrame:AddButtonCustom("S", 7 - 4, "smallCDs", "smallcds");
	v24.PostInitialMessage(1494 - (322 + 905));
end
v13.SetAPL(878 - (602 + 9), v123, v124);
