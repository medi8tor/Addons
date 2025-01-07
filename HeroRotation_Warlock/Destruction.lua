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
	local v123, v124 = v7:GetTrinketData(v29);
	if ((v72 < (5 + 0)) and ((v123.ID == (0 - 0)) or (v124.ID == (1065 - (68 + 997))) or ((v123.SpellID > (1270 - (226 + 1044))) and not v123.Usable) or ((v124.SpellID > (0 - 0)) and not v124.Usable))) then
		v72 = v72 + (118 - (32 + 85));
		v22(5 + 0, function()
			v73();
		end);
		return;
	end
	v47 = v123.Object;
	v48 = v124.Object;
	v49 = v123.ID;
	v50 = v124.ID;
	v51 = v123.Spell;
	v53 = v123.Range;
	v55 = v123.CastTime;
	v52 = v124.Spell;
	v54 = v124.Range;
	v56 = v124.CastTime;
	v57 = v123.Cooldown;
	v58 = v124.Cooldown;
	v59 = v123.Blacklisted;
	v60 = v124.Blacklisted;
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
	local v139 = ((v69 > (0 + 0)) and v69) or (998 - (915 + 82));
	local v140 = ((v70 > (0 - 0)) and v70) or (1 + 0);
	v71 = 1 - 0;
	if ((not v61 and v62) or (v62 and (((v58 / v140) * v64) > ((v57 / v139) * v63)))) then
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
local function v74(v141)
	for v179 in pairs(v141) do
		local v180 = v141[v179];
		if v180:DebuffUp(v27.Havoc) then
			return true, v180:DebuffRemains(v27.HavocDebuff), v180:DebuffRemains(v27.ImmolateDebuff);
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
local function v82(v142)
	return v20(v142:TimeToDie() * -(773 - (201 + 571)), -(1153 - (116 + 1022))) + v142:DebuffRemains(v27.ImmolateDebuff) + ((412 - 313) * v18(v142:GUID() == v9:GUID()));
end
local function v83(v143)
	return v143:DebuffRemains(v27.ImmolateDebuff) + ((59 + 40) * v143:DebuffRemains(v27.HavocDebuff));
end
local function v84(v144)
	return v144:DebuffRemains(v27.WitherDebuff) + ((361 - 262) * v18(v144:DebuffUp(v27.HavocDebuff))) + ((351 - 252) * v18(v144:DebuffDown(v27.WitherDebuff)));
end
local function v85(v145)
	return v145:DebuffRemains(v27.WitherDebuff) + ((958 - (814 + 45)) * v18(v145:DebuffUp(v27.HavocDebuff)));
end
local function v86(v146)
	return ((v146:DebuffRemains(v27.WitherDebuff) + v146:DebuffRemains(v27.ImmolateDebuff)) - ((12 - 7) * v18(v146:DebuffUp(v27.ConflagrateDebuff)))) + ((6 + 94) * v18(v146:DebuffUp(v27.HavocDebuff)));
end
local function v87(v147)
	return (v147:TimeToDie() > (3 + 5)) and (v147:GUID() ~= v9:GUID());
end
local function v88(v148)
	return v148:DebuffRefreshable(v27.ImmolateDebuff) and (not v27.Cataclysm:IsAvailable() or not IsCataclysm or (v27.Cataclysm:CooldownRemains() > v148:DebuffRemains(v27.ImmolateDebuff))) and (not v27.RagingDemonfire:IsAvailable() or (v27.ChannelDemonfire:CooldownRemains() > v148:DebuffRemains(v27.ImmolateDebuff)) or (v3.CombatTime() < (890 - (261 + 624)))) and (v148:TimeToDie() > (31 - 13));
end
local function v89(v149)
	return ((v149:DebuffRefreshable(v27.ImmolateDebuff) and (v36 < (1085.4 - (1020 + 60)))) or ((v149:DebuffRemains(v27.ImmolateDebuff) < (1425 - (630 + 793))) and (v149:DebuffRemains(v27.ImmolateDebuff) < v35)) or v149:DebuffDown(v27.ImmolateDebuff) or v19(v18(v36 < (6 - 4)) * v18(v34))) and (not v27.Cataclysm:IsAvailable() or (v27.Cataclysm:CooldownRemains() > v149:DebuffRemains(v27.ImmolateDebuff))) and (v149:TimeToDie() > (52 - 41)) and not (v27.DiabolicRitual:IsAvailable() and v27.Inferno:IsAvailable());
end
local function v90(v150)
	return ((v150:DebuffRefreshable(v27.ImmolateDebuff) and (v36 < (2.4000000000000004 + 3))) or ((v150:DebuffRemains(v27.ImmolateDebuff) < (6 - 4)) and (v150:DebuffRemains(v27.ImmolateDebuff) < v35)) or v150:DebuffDown(v27.ImmolateDebuff) or v19(v18(v36 < (1749 - (760 + 987))) * v18(v34))) and (not v27.Cataclysm:IsAvailable() or not IsCataclysm or (v27.Cataclysm:CooldownRemains() > v150:DebuffRemains(v27.ImmolateDebuff))) and (v150:TimeToDie() > (1924 - (1789 + 124)));
end
local function v91(v151)
	return v151:DebuffRefreshable(v27.ImmolateDebuff) and ((v151:DebuffRemains(v27.ImmolateDebuff) < v27.Havoc:CooldownRemains()) or v151:DebuffDown(v27.ImmolateDebuff)) and (not v27.Cataclysm:IsAvailable() or not IsCataclysm or (v27.Cataclysm:CooldownRemains() > v151:DebuffRemains(v27.ImmolateDebuff))) and (not v27.SoulFire:IsAvailable() or ((v27.SoulFire:CooldownRemains() + (v18(not v27.Mayhem:IsAvailable()) * v27.SoulFire:CastTime())) > v151:DebuffRemains(v27.ImmolateDebuff))) and (v151:TimeToDie() > (781 - (745 + 21)));
end
local function v92(v152)
	return v152:DebuffRefreshable(v27.ImmolateDebuff) and ((v152:TimeToDie() > (2 + 3)) or ((((v152:DebuffRemains(v27.ImmolateDebuff) < (5 - 3)) and (v152:DebuffRemains(v27.ImmolateDebuff) < v35)) or v152:DebuffDown(v27.ImmolateDebuff) or (v36 < (7 - 5))) and (v152:TimeToDie() > (1 + 10))));
end
local function v93(v153)
	return v153:DebuffRefreshable(v27.WitherDebuff) and (not v27.Cataclysm:IsAvailable() or not IsCataclysm or (v27.Cataclysm:CooldownRemains() > v153:DebuffRemains(v27.WitherDebuff))) and (not v27.RagingDemonfire:IsAvailable() or (v27.ChannelDemonfire:CooldownRemains() > v153:DebuffRemains(v27.WitherDebuff)) or (v3.CombatTime() < (4 + 1))) and (v153:TimeToDie() > (1073 - (87 + 968)));
end
local function v94(v154)
	return v154:DebuffRefreshable(v27.WitherDebuff) and (not v27.Cataclysm:IsAvailable() or not IsCataclysm or (v27.Cataclysm:CooldownRemains() > v154:DebuffRemains(v27.WitherDebuff))) and (not v27.RagingDemonfire:IsAvailable() or (v27.ChannelDemonfire:CooldownRemains() > v154:DebuffRemains(v27.WitherDebuff)) or (v3.CombatTime() < (22 - 17))) and (v154:TimeToDie() > (17 + 1));
end
local function v95(v155)
	return (((v155.DebuffRemains(v27.WitherDebuff) - ((11 - 6) * v18(v27.ChaosBolt:InFlight()))) < (v27.WitherDebuff:MaxDuration() * (1413.4 - (447 + 966)))) or (v155:DebuffRemains(v27.WitherDebuff) < (8 - 5)) or (((v155:DebuffRemains(v27.WitherDebuff) - v27.ChaosBolt:ExecuteTime()) < (1822 - (1703 + 114))) and v27.ChaosBolt:IsReady())) and (not v27.SoulFire:IsAvailable() or ((v27.SoulFire:CooldownRemains() + v27.SoulFire:CastTime()) > (v155:DebuffRemains(v27.WitherDebuff) - (706 - (376 + 325))))) and (v155:TimeToDie() > (12 - 4));
end
local function v96(v156)
	return (((v156:DebuffRemains(v27.WitherDebuff) - ((15 - 10) * v18(v27.ChaosBolt:InFlight()))) < (v27.WitherDebuff:MaxDuration() * (0.3 + 0))) or (v156:DebuffRemains(v27.WitherDebuff) < (6 - 3))) and (not v27.SoulFire:IsAvailable() or ((v27.SoulFire:CooldownRemains() + v27.SoulFire:CastTime()) > (v156:DebuffRemains(v27.WitherDebuff)))) and (v156:TimeToDie() > (22 - (9 + 5)));
end
local function v97(v157)
	return (v157:DebuffRefreshable(v27.WitherDebuff) and (v36 < (381.4 - (85 + 291))) and (v157:TimeToDie() > (1270 - (243 + 1022)))) or ((((v157:DebuffRemains(v27.WitherDebuff) < (7 - 5)) and (v157:DebuffRemains(v27.WitherDebuff) < v35)) or v157:DebuffDown(v27.WitherDebuff) or (v36 < (2 + 0))) and (v157:TimeToDie() > (1191 - (1123 + 57))));
end
local function v98()
	local v158 = nil;
	local v159 = v27.SpellLock:CooldownRemains();
	local v160 = v27.SingeMagic:CooldownRemains();
	local v161 = v27.ShadowBulwark:CooldownRemains();
	local v162 = v27.Seduction:CooldownRemains();
	if ((not v8:IsActive() or (v8:HealthPercentage() < (1 + 0))) and not v7:BuffUp(v27.GrimoireofSacrificeBuff)) then
		v158 = nil;
	elseif ((v7:Level() <= (284 - (163 + 91))) and v8:IsActive()) then
		v158 = "Leveling";
	elseif (v27.SpellLock:IsReady() or ((v159 <= (1954 - (1869 + 61))) and not ((v159 == (0 + 0)) and not v27.SpellLock:IsReady()))) then
		v158 = "Felhunter";
	elseif (v27.SingeMagic:IsReady() or ((v160 <= (52 - 37)) and not ((v160 == (0 - 0)) and not v27.SingeMagic:IsReady()))) then
		v158 = "Imp";
	elseif (v27.ShadowBulwark:IsReady() or ((v161 <= (17 + 103)) and not ((v161 == (0 - 0)) and not v27.ShadowBulwark:IsReady()))) then
		v158 = "Voidwalker";
	elseif (v27.Seduction:IsReady() or ((v162 <= (29 + 1)) and not ((v162 == (1474 - (1329 + 145))) and not v27.Seduction:IsReady()))) then
		v158 = "Sayaad";
	end
	return v158;
end
local function v99()
	Currentpet = v98();
end
local v100;
local function v101(v163)
	return (v163 ~= "Not Used") and ((((v163 == "with Cooldowns") or ((v163 == "small CDs") and v26.Destruction_CDUSE.smallcdswithCooldowns) or (v163 == "with Cooldowns or AoE") or (v163 == "on Enemycount or Cooldowns") or (v163 == "on Boss or with Cooldowns")) and v15()) or (v163 == "always") or (((v163 == "on Boss only") or (v163 == "on Boss or on Enemycount") or (v163 == "on Boss or with Cooldowns")) and (v100 or v9:IsDummy())) or ((v163 == "with Bloodlust only") and v7:BloodlustUp()) or ((v163 == "small CDs") and Smallcds) or (((v163 == "on AOE") or (v163 == "with Cooldowns or AoE")) and (v44 > (973 - (140 + 831))) and v14()) or (((v163 == "on Enemycount or Cooldowns") or (v163 == "on Enemycount") or (v163 == "on Boss or on Enemycount")) and (v44 >= v26.Destruction_CDUSE.Enemycount) and v14()));
end
local function v102(v164)
	return (v100 and v26.Destruction_TTD.IgnoreWhenBoss) or v24.Buggedmobs[v9:NPCID()] or (v24.ISSolo() and v26.Destruction_TTD.IgnoreWhenSolo) or (v164 == (1850 - (1409 + 441))) or ((v46 >= v164) and (v46 < (8495 - (15 + 703))));
end
local function v103(v165)
	return v165:NPCID() == (94733 + 109827);
end
local function v104(v166)
	return v166:CastSpellID() == (409243 - (262 + 176));
end
local function v105()
	return (v12:Exists() or not v26.Destruction.CursorCheck) and not v7:IsCameraBusy();
end
local function v106()
	if v24.TargetIsValid() then
		local v184 = v9:MinDistance() or (1726 - (345 + 1376));
		local v185 = v9:MaxDistance() or (728 - (198 + 490));
		v184 = math.max(v184 - (35 - 27), 11 - 6);
		v185 = math.min(v185 + (1214 - (696 + 510)), 83 - 43);
		local v186 = v7:GetEnemiesInRange(v184);
		local v187 = v7:GetEnemiesInRange(v185);
		local v188 = #v187;
		if ((v185 - v184) > (1278 - (1091 + 171))) then
			v188 = v188 - #v186;
		end
		v188 = math.max(v188, 1 + 0);
		return v188;
	else
		return #(v7:GetEnemiesInRange(125 - 85));
	end
end
local v107 = nil;
local function v108()
	if v7:IsMoving() then
		if not v107 then
			v107 = GetTime();
		end
		return GetTime() - v107;
	else
		if v107 then
			v107 = nil;
		end
		return 0 - 0;
	end
end
local v109 = nil;
local function v110()
	if (Currentpet == nil) then
		if not v109 then
			v109 = GetTime();
		end
		return GetTime() - v109;
	else
		if (Currentpet ~= nil) then
			v109 = nil;
		end
		return 374 - (123 + 251);
	end
end
local function v111(v167, v168)
	return (v167:gsub("{(.-)}", v168));
end
local function v112()
	local v169 = v26.Destruction_Pets.PetSelected;
	local v170 = v98();
	if ((v169 == "Imp") and (v170 ~= "Imp") and (v170 ~= "Leveling")) then
		if (v27.SummonImp:IsCastable() and not v7:IsMoving() and not v7:IsCasting(v27.SummonImp) and not v7:PrevGCDP(4 - 3, v27.SummonImp) and not (v7:IsMounted() or v7:IsInVehicle())) then
			if v16(v27.SummonImp, false) then
				return "summon Imp";
			end
		end
	elseif ((v169 == "Voidwalker") and (v170 ~= "Voidwalker") and (v170 ~= "Leveling")) then
		if (v27.SummonVoidwalker:IsCastable() and not v7:IsMoving() and not v7:IsCasting(v27.SummonVoidwalker) and not v7:PrevGCDP(699 - (208 + 490), v27.SummonVoidwalker) and not (v7:IsMounted() or v7:IsInVehicle())) then
			if v16(v27.SummonVoidwalker, false) then
				return "summon Voidwalker";
			end
		end
	elseif ((v169 == "Felhunter") and (v170 ~= "Felhunter") and (v170 ~= "Leveling")) then
		if (v27.SummonFelhunter:IsCastable() and not v7:IsMoving() and not v7:IsCasting(v27.SummonFelhunter) and not v7:PrevGCDP(1 + 0, v27.SummonFelhunter) and not (v7:IsMounted() or v7:IsInVehicle())) then
			if v16(v27.SummonFelhunter, false) then
				return "summon Felhunter";
			end
		end
	elseif ((v169 == "Sayaad") and (v170 ~= "Sayaad") and (v170 ~= "Leveling")) then
		if (v27.SummonSayaad:IsCastable() and not v7:IsMoving() and not v7:IsCasting(v27.SummonSayaad) and not v7:PrevGCDP(1 + 0, v27.SummonSayaad) and not (v7:IsMounted() or v7:IsInVehicle())) then
			if v16(v27.SummonSayaad, false) then
				return "summon Sayaad";
			end
		end
	end
	return false;
end
local function v113()
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
	if (v27.HealthFunnel:IsCastable() and not v7:IsMoving() and (v8:HealthPercentage() <= v26.Defensives.HealthFunnelHP) and (v8:HealthPercentage() > (836 - (660 + 176)))) then
		if v16(v27.HealthFunnel) then
			return "HealthFunnel";
		end
	end
	if (v27.DrainLife:IsCastable() and v7:AffectingCombat() and v9:IsInRange(5 + 35) and v7:CanAttack(v9) and not v7:IsMoving() and (v7:HealthPercentage() <= v26.Defensives.DrainLifeHP)) then
		if v16(v27.DrainLife) then
			return "DrainLife";
		end
	end
	if (v27.MortalCoil:IsReady() and v7:AffectingCombat() and v9:IsInRange(222 - (14 + 188)) and v7:CanAttack(v9) and (v7:HealthPercentage() <= v26.Defensives.MortalCoilHP)) then
		if v16(v27.MortalCoil) then
			return "MortalCoil";
		end
	end
end
local function v114()
	if (v27.Cataclysm:IsCastable() and not v7:IsMoving() and IsCataclysm) then
		if v16(v27.Cataclysm, true) then
			return "cataclysm precombat 6";
		end
	end
	if (v27.Incinerate:IsCastable() and not v7:IsMoving() and not v7:IsCasting(v27.Incinerate)) then
		if v16(v27.Incinerate) then
			return "incinerate precombat 8";
		end
	end
end
local function v115()
	if v26.Commons.Enabled.Trinkets then
		if (v28.SpymastersWeb:IsEquippedAndReady() and (((v47:ID() == v28.SpymastersWeb:ID()) and IsTrinket1) or ((v48:ID() == v28.SpymastersWeb:ID()) and IsTrinket2)) and (((v79() >= (685 - (534 + 141))) and (v79() <= (9 + 11)) and (v7:BuffStack(v27.SpymastersReportBuff) >= (34 + 4)) and ((v46 > (231 + 9)) or (v46 <= (294 - 154)))) or (v46 <= (47 - 17)))) then
			if v16(v28.SpymastersWeb, true) then
				return "spymasters_web items 2";
			end
		end
		if (v28.KahetiShadowweaversEmblem:IsEquippedAndReady() and (((v47:ID() == v28.KahetiShadowweaversEmblem:ID()) and IsTrinket1) or ((v48:ID() == v28.KahetiShadowweaversEmblem:ID()) and IsTrinket2)) and (v7:BuffStack(v27.KahetiShadowweaversEmblemBuff) >= (14 - 9))) then
			if v16(v28.KahetiShadowweaversEmblem, true) then
				return "Kaheti_Shadowweavers_Emblem items 3";
			end
		end
		if (v28.MadQueensMandate:IsEquippedAndReady() and (((v47:ID() == v28.MadQueensMandate:ID()) and IsTrinket1) or ((v48:ID() == v28.MadQueensMandate:ID()) and IsTrinket2))) then
			if v16(v28.MadQueensMandate, true) then
				return "MadQueensMandate items 5";
			end
		end
		if (v47:IsReady() and v9:IsInRange(v53) and IsTrinket1 and not v59 and (((v39 or not v27.SummonInfernal:IsAvailable() or v40) and ((v71 == (1 + 0)) or v68 or not v48:HasCooldown() or v48:CooldownDown() or ((v71 == (2 + 0)) and (v27.SummonInfernal:CooldownRemains() > (416 - (115 + 281))) and not v39 and (v48:CooldownRemains() < v27.SummonInfernal:CooldownRemains()))) and v61 and not v65) or ((v69 + (2 - 1)) >= v45))) then
			if v16(v47, true) then
				return "trinket1 (" .. v47:Name() .. ") items 4";
			end
		end
		if (v48:IsReady() and v9:IsInRange(v54) and IsTrinket2 and not v60 and (((v39 or not v27.SummonInfernal:IsAvailable() or v41) and ((v71 == (2 + 0)) or v67 or not v47:HasCooldown() or v47:CooldownDown() or ((v71 == (2 - 1)) and (v27.SummonInfernal:CooldownRemains() > (73 - 53)) and not v39 and (v47:CooldownRemains() < v27.SummonInfernal:CooldownRemains()))) and v62 and not v66) or ((v70 + (868 - (550 + 317))) >= v45))) then
			if v16(v48, true) then
				return "trinket2 (" .. v48:Name() .. ") items 6";
			end
		end
		if (v47:IsReady() and v9:IsInRange(v53) and IsTrinket1 and not v59 and not v61 and not v65 and ((not v61 and (v48:CooldownDown() or not v62)) or (v27.SummonInfernal:IsAvailable() and (v27.SummonInfernal:CooldownRemains() > (28 - 8)) and not v7:PrevGCDP(1 - 0, v27.SummonInfernal)) or not v27.SummonInfernal:IsAvailable())) then
			if v16(v47, true) then
				return "trinket1 (" .. v47:Name() .. ") items 8";
			end
		end
		if (v48:IsReady() and v9:IsInRange(v54) and IsTrinket2 and not v60 and not v62 and not v66 and ((not v62 and (v47:CooldownDown() or not v61)) or (v27.SummonInfernal:IsAvailable() and (v27.SummonInfernal:CooldownRemains() > (55 - 35)) and not v7:PrevGCDP(286 - (134 + 151), v27.SummonInfernal)) or not v27.SummonInfernal:IsAvailable())) then
			if v16(v48, true) then
				return "trinket2 (" .. v48:Name() .. ") items 10";
			end
		end
	end
	if v26.Commons.Enabled.Items then
		local v189, v190, v191 = v7:GetUseableItems(v29, 1681 - (970 + 695));
		if (v189 and v189:IsReady() and v9:IsInRange(v191)) then
			v13.CastMacro(1 - 0, nil, nil, v189);
			return "weapon cast";
		end
	end
end
local function v116()
	if (v26.Commons.Enabled.Potions and IsPotions and (v39 or not v27.SummonInfernal:IsAvailable() or not IsSummonInfernal)) then
		local v192 = v24.PotionSelected();
		if (v192 and v192:IsReady()) then
			v13.CastMacro(1993 - (582 + 1408), nil, nil, v192);
			return "Cast Potion";
		end
	end
	if (v27.Berserking:IsCastable() and IsRacials and (v39 or not v27.SummonInfernal:IsAvailable() or ((v46 < (v27.SummonInfernal:CooldownRemains() + (41 - 29))) and (v46 > (14 - 2))) or (v46 < v27.SummonInfernal:CooldownRemains()))) then
		if v16(v27.Berserking, true) then
			return "berserking ogcd 4";
		end
	end
	if (v27.BloodFury:IsCastable() and IsRacials and (v39 or not v27.SummonInfernal:IsAvailable() or ((v46 < (v27.SummonInfernal:CooldownRemains() + (37 - 27) + (1839 - (1195 + 629)))) and (v46 > (19 - 4))) or (v46 < v27.SummonInfernal:CooldownRemains()))) then
		if v16(v27.BloodFury, true) then
			return "blood_fury ogcd 6";
		end
	end
	if (v27.Fireblood:IsCastable() and IsRacials and (v39 or not v27.SummonInfernal:IsAvailable() or ((v46 < (v27.SummonInfernal:CooldownRemains() + (251 - (187 + 54)) + (788 - (162 + 618)))) and (v46 > (6 + 2))) or (v46 < v27.SummonInfernal:CooldownRemains()))) then
		if v16(v27.Fireblood, true) then
			return "fireblood ogcd 8";
		end
	end
	if (v27.AncestralCall:IsCastable() and IsRacials and (v39 or not v27.SummonInfernal:IsAvailable() or ((v46 < (v27.SummonInfernal:CooldownRemains() + 10 + 5)) and (v46 > (31 - 16))) or (v46 < v27.SummonInfernal:CooldownRemains()))) then
		if v16(v27.AncestralCall, true) then
			return "ancestral_call ogcd 10";
		end
	end
end
local function v117()
	if (v27.Conflagrate:IsCastable() and v27.Backdraft:IsAvailable() and v7:BuffDown(v27.BackdraftBuff) and (v42 >= (1 - 0)) and (v42 <= (1 + 3))) then
		if v16(v27.Conflagrate) then
			return "conflagrate havoc 2";
		end
	end
	if (v27.SoulFire:IsCastable() and not v7:IsMoving() and (v27.SoulFire:CastTime() < v35) and (v42 < (1638.5 - (1373 + 263)))) then
		if v16(v27.SoulFire) then
			return "soul_fire havoc 4";
		end
	end
	if (v27.Cataclysm:IsReady() and not v7:IsMoving() and IsCataclysm) then
		if v16(v27.Cataclysm, true) then
			return "cataclysm havoc 8";
		end
	end
	if (v27.Immolate:IsCastable() and (v42 < (1004.5 - (451 + 549)))) then
		if v24.CastTargetIf(v27.Immolate, Enemies8ySplash, "min", v83, v92, 13 + 27) then
			return "immolate havoc 10";
		end
	end
	if (v27.Wither:IsCastable() and (v42 < (5.5 - 1))) then
		if v24.CastTargetIf(v27.Wither, Enemies8ySplash, "min", v85, v97, 67 - 27) then
			return "wither havoc 12";
		end
	end
	if (v27.Shadowburn:IsReady() and ((v27.Shadowburn:FullRechargeTime() <= (v7:GCD() * (1387 - (746 + 638)))) or ((v9:DebuffRemains(v27.EradicationDebuff) <= v7:GCD()) and v27.Eradication:IsAvailable() and not v27.ChaosBolt:InFlight() and not v27.DiabolicRitual:IsAvailable())) and (v27.ConflagrationofChaos:IsAvailable() or v27.BlisteringAtrophy:IsAvailable())) then
		if v16(v27.Shadowburn) then
			return "shadowburn havoc 14";
		end
	end
	if (v27.Shadowburn:IsReady() and (v35 <= (v7:GCD() * (2 + 1)))) then
		if v16(v27.Shadowburn) then
			return "shadowburn havoc 16";
		end
	end
	if (v27.ChaosBolt:IsReady() and not v7:IsMoving() and (v27.ChaosBolt:CastTime() < v35) and (v44 <= (((2 - 0) - (((v18(v27.Inferno:IsAvailable()) - v18(v27.ImprovedChaosBolt:IsAvailable())) - v18(v27.Cataclysm:IsAvailable())) * v18(v27.Wither:IsAvailable()))) + (v18(v27.Cataclysm:IsAvailable() and v27.ImprovedChaosBolt:IsAvailable()) * v18(not v27.Wither:IsAvailable()))))) then
		if v16(v27.ChaosBolt) then
			return "chaos_bolt havoc 18";
		end
	end
	if (v27.RainofFire:IsReady() and v105() and (v44 >= ((344 - (218 + 123)) - v18(v27.Wither:IsAvailable())))) then
		if v16(v27.RainofFire) then
			return "rain_of_fire havoc 20";
		end
	end
	if (v27.ChannelDemonfire:IsReady() and not v7:IsMoving() and (v42 < (1585.5 - (1535 + 46)))) then
		if v16(v27.ChannelDemonfire) then
			return "channel_demonfire havoc 22";
		end
	end
	if (v27.Conflagrate:IsCastable() and not v27.Backdraft:IsAvailable()) then
		if v16(v27.Conflagrate) then
			return "conflagrate havoc 24";
		end
	end
	if (v27.DimensionalRift:IsCastable() and IsDimensionalRift and (v42 < (4.7 + 0)) and ((v27.DimensionalRift:Charges() > (1 + 1)) or (v46 < v27.DimensionalRift:Cooldown()))) then
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
local function v118()
	local v171 = v116();
	if v171 then
		return v171;
	end
	if (v26.Commons.Enabled.Trinkets or v26.Commons.Enabled.Trinkets) then
		local v193 = v115();
		if v193 then
			return v193;
		end
	end
	if (v27.Malevolence:IsReady() and IsMalevolence and (v27.SummonInfernal:CooldownRemains() >= (615 - (306 + 254))) and (v42 < (1.7000000000000002 + 3)) and ((v44 <= ((5 - 2) + v27.WitherDebuff:AuraActiveCount())) or (v3.CombatTime() > (1497 - (899 + 568))))) then
		if v16(v27.Malevolence) then
			return "malevolence aoe 2";
		end
	end
	if (v27.RainofFire:IsReady() and v105() and (v76())) then
		if v16(v27.RainofFire) then
			return "rain_of_fire aoe 4";
		end
	end
	if (v27.Incinerate:IsCastable() and not v7:IsMoving() and v77() and (VarDRSum <= v27.Incinerate:CastTime()) and (VarDRSum > (v7:GCD() * (0.25 + 0)))) then
		if v16(v27.Incinerate) then
			return "incinerate aoe 6";
		end
	end
	if (v34 and (v35 > v7:GCD()) and (v44 < (12 - 7)) and (v27.SummonInfernal:CooldownDown() or not v27.SummonInfernal:IsAvailable())) then
		local v194 = v117();
		if v194 then
			return v194;
		end
	end
	if (v27.DimensionalRift:IsCastable() and IsDimensionalRift and (v42 < (607.7 - (268 + 335))) and ((v27.DimensionalRift:Charges() > (292 - (60 + 230))) or (v46 < v27.DimensionalRift:Cooldown()))) then
		if v16(v27.DimensionalRift, true) then
			return "dimensional_rift aoe 8";
		end
	end
	if (v27.RainofFire:IsReady() and v105() and ((not v27.Inferno:IsAvailable() and (v42 >= ((576.5 - (426 + 146)) - ((0.1 + 0) * v27.ImmolateDebuff:AuraActiveCount())))) or (v42 >= ((1459.5 - (282 + 1174)) - ((811.1 - (569 + 242)) * v27.ImmolateDebuff:AuraActiveCount()))) or v7:BuffUp(v27.RitualofRuinBuff))) then
		if v16(v27.RainofFire) then
			return "rain_of_fire aoe 10";
		end
	end
	if (v27.WitherAbility:IsReady() and ((v27.WitherDebuff:AuraActiveCount() <= (11 - 7)) or (v3.CombatTime() > (1 + 14)))) then
		if v24.CastTargetIf(v27.WitherAbility, Enemies8ySplash, "min", v84, v93, 1064 - (706 + 318)) then
			return "wither aoe 12";
		end
	end
	if (v27.ChannelDemonfire:IsReady() and not v7:IsMoving() and ((v9:DebuffRemains(v27.ImmolateDebuff) + v9:DebuffRemains(v27.WitherDebuff)) > v75()) and v27.RagingDemonfire:IsAvailable()) then
		if v16(v27.ChannelDemonfire) then
			return "channel_demonfire aoe 14";
		end
	end
	if (v27.Shadowburn:IsReady() and (v44 < ((1255 - (721 + 530)) + ((v18(v27.Cataclysm:IsAvailable()) + ((1275 - (945 + 326)) * v18(v27.Cataclysm:IsAvailable()))) * v18(v27.Wither:IsAvailable())))) and ((((v27.Shadowburn:FullRechargeTime() <= (v7:GCD() * (7 - 4))) or ((v9:DebuffRemains(v27.EradicationDebuff) <= v7:GCD()) and v27.Eradication:IsAvailable() and not v27.ChaosBolt:InFlight() and not v27.DiabolicRitual:IsAvailable())) and (v27.ConflagrationofChaos:IsAvailable() or v27.BlisteringAtrophy:IsAvailable()) and (v44 < (5 + 0 + v18(v27.Wither:IsAvailable() and v27.Cataclysm:IsAvailable()) + v18(v34)))) or (v45 <= (708 - (271 + 429))))) then
		if v16(v27.Shadowburn) then
			return "shadowburn aoe 16";
		end
	end
	if (v27.Shadowburn:IsReady() and (v44 < (4 + 0 + ((v18(v27.Cataclysm:IsAvailable()) + ((1504 - (1408 + 92)) * v18(v27.Cataclysm:IsAvailable()))) * v18(v27.Wither:IsAvailable())))) and ((((v27.Shadowburn:FullRechargeTime() <= (v7:GCD() * (1089 - (461 + 625)))) or ((v9:DebuffRemains(v27.EradicationDebuff) <= v7:GCD()) and v27.Eradication:IsAvailable() and not v27.ChaosBolt:InFlight() and not v27.DiabolicRitual:IsAvailable())) and (v27.ConflagrationofChaos:IsAvailable() or v27.BlisteringAtrophy:IsAvailable()) and (v44 < ((1293 - (993 + 295)) + v18(v27.Wither:IsAvailable() and v27.Cataclysm:IsAvailable()) + v18(v34))) and (v9:TimeToDie() < (1 + 4))) or (v46 <= (1179 - (418 + 753))))) then
		if v16(v27.Shadowburn) then
			return "shadowburn aoe 18";
		end
	end
	if (v27.RuinationAbility:IsReady() and not v7:IsMoving()) then
		if v16(v27.RuinationAbility) then
			return "ruination aoe 20";
		end
	end
	if (v27.RainofFire:IsReady() and v105() and v78() and v27.RainofChaos:IsAvailable()) then
		if v16(v27.RainofFire) then
			return "rain_of_fire aoe 22";
		end
	end
	if (v27.SoulFire:IsReady() and not v7:IsMoving() and v7:BuffUp(v27.DecimationBuff) and not v27.RagingDemonfire:IsAvailable() and v34) then
		if v16(v27.SoulFire) then
			return "soul_fire aoe 24";
		end
	end
	if (v27.InfernalBolt:IsReady() and not v7:IsMoving() and (v42 < (1.5 + 1))) then
		if v16(v27.InfernalBolt) then
			return "infernal_bolt aoe 28";
		end
	end
	if (v27.ChaosBolt:IsReady() and not v7:IsMoving() and (v42 > ((1.5 + 2) - ((0.1 + 0) * v44))) and not v27.RainofFire:IsAvailable()) then
		if v16(v27.ChaosBolt) then
			return "chaos_bolt aoe 30";
		end
	end
	if (v27.Cataclysm:IsReady() and IsCataclysm and not v7:IsMoving()) then
		if v16(v27.Cataclysm, true) then
			return "cataclysm aoe 32";
		end
	end
	if (v27.Havoc:IsReady() and (((v27.SummonInfernal:CooldownDown() or not v27.SummonInfernal:IsAvailable() or not IsSummonInfernal or (v27.Inferno:IsAvailable() and (v44 > (2 + 2)))) and ((v27.Malevolence:CooldownRemains() > (544 - (406 + 123))) or not v27.Malevolence:IsAvailable())) or (v3.CombatTime() < (1774 - (1749 + 20))))) then
		if v24.CastTargetIf(v27.Havoc, v43, "min", v82, v87, 10 + 30, nil, nil, false, true) then
			return "havoc aoe 25";
		end
	end
	if (v27.WitherAbility:IsReady() and (v27.WitherDebuff:AuraActiveCount() <= v44)) then
		if v24.CastTargetIf(v27.WitherAbility, Enemies8ySplash, "min", v85, v94, 1362 - (1249 + 73)) then
			return "wither aoe 34";
		end
	end
	if (v27.Immolate:IsCastable() and not v7:IsMoving() and (((v27.ImmolateDebuff:AuraActiveCount() <= (3 + 3)) and not (v27.DiabolicRitual:IsAvailable() and v27.Inferno:IsAvailable())) or (v27.ImmolateDebuff:AuraActiveCount() <= (1149 - (466 + 679))))) then
		if v24.CastTargetIf(v27.Immolate, Enemies8ySplash, "min", v83, v88, 96 - 56) then
			return "immolate aoe 36";
		end
	end
	if (v27.SummonInfernal:IsReady() and IsSummonInfernal) then
		if v16(v27.SummonInfernal, true) then
			return "summon_infernal aoe 38";
		end
	end
	if (v27.RainofFire:IsReady() and v105() and v9:DebuffDown(v27.PyrogenicsDebuff) and (v44 <= (11 - 7)) and not v27.DiabolicRitual:IsAvailable()) then
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
		if v24.CastTargetIf(v27.Immolate, Enemies8ySplash, "min", v83, v89, 1940 - (106 + 1794)) then
			return "immolate aoe 44";
		end
	end
	if (v27.Immolate:IsCastable() and not v7:IsMoving() and not v7:IsMoving()) then
		if v24.CastTargetIf(v27.Immolate, Enemies8ySplash, "min", v83, v90, 13 + 27) then
			return "immolate aoe 46";
		end
	end
	if (v27.DimensionalRift:IsCastable() and IsDimensionalRift) then
		if v16(v27.DimensionalRift, true) then
			return "dimensional_rift aoe 48";
		end
	end
	if (v27.SoulFire:IsCastable() and not v7:IsMoving() and (v7:BuffUp(v27.BackdraftBuff))) then
		if v16(v27.SoulFire) then
			return "soul_fire aoe 50";
		end
	end
	if (v27.Incinerate:IsCastable() and not v7:IsMoving() and v27.FireandBrimstone:IsAvailable() and v7:BuffUp(v27.BackdraftBuff)) then
		if v16(v27.Incinerate) then
			return "incinerate aoe 52";
		end
	end
	if (v27.Conflagrate:IsCastable() and ((v7:BuffStack(v27.BackdraftBuff) < (1 + 1)) or not v27.Backdraft:IsAvailable())) then
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
local function v119()
	if (v26.Commons.Enabled.Trinkets or v26.Commons.Enabled.Items) then
		local v195 = v115();
		if v195 then
			return v195;
		end
	end
	local v172 = v116();
	if v172 then
		return v172;
	end
	if (v34 and (v35 > v7:GCD())) then
		local v196 = v117();
		if v196 then
			return v196;
		end
	end
	v33 = (v27.Havoc:CooldownRemains() <= (14 - 9)) or v27.Mayhem:IsAvailable();
	if (v27.Malevolence:IsReady() and IsMalevolence and (v27.SummonInfernal:CooldownDown() or not v27.SummonInfernal:IsAvailable())) then
		if v16(v27.Malevolence) then
			return "malevolence cleave 2";
		end
	end
	if (v27.Havoc:IsReady() and (v27.SummonInfernal:CooldownDown() or not v27.SummonInfernal:IsAvailable())) then
		if v24.CastTargetIf(v27.Havoc, v43, "min", v82, v87, 108 - 68, nil, nil, false, true) then
			return "havoc cleave 3";
		end
	end
	if (v27.ChaosBolt:IsReady() and not v7:IsMoving() and (v76())) then
		if v16(v27.ChaosBolt) then
			return "chaos_bolt cleave 4";
		end
	end
	if (v27.SoulFire:IsReady() and not v7:IsMoving() and v7:BuffUp(v27.DecimationBuff) and ((v42 <= (118 - (4 + 110))) or (v7:BuffRemains(v27.DecimationBuff) <= (v7:GCD() * (586 - (57 + 527))))) and (v9:DebuffRemains(v27.ConflagrateDebuff) >= v27.SoulFire:ExecuteTime()) and v27.Havoc:CooldownDown()) then
		if v16(v27.SoulFire) then
			return "soul_fire cleave 6";
		end
	end
	if (v27.WitherAbility:IsReady() and v27.InternalCombustion:IsAvailable() and not v27.SoulFire:InFlight()) then
		if v24.CastTargetIf(v27.WitherAbility, Enemies8ySplash, "min", v85, v95, 1467 - (41 + 1386)) then
			return "wither cleave 8";
		end
	end
	if (v27.WitherAbility:IsReady() and not v27.InternalCombustion:IsAvailable() and not v27.SoulFire:InFlight()) then
		if v24.CastTargetIf(v27.WitherAbility, Enemies8ySplash, "min", v85, v96, 143 - (17 + 86)) then
			return "wither cleave 8";
		end
	end
	if (v27.Conflagrate:IsCastable() and ((v27.RoaringBlaze:IsAvailable() and (v27.Conflagrate:FullRechargeTime() <= (v7:GCD() * (2 + 0)))) or ((v27.Conflagrate:Recharge() <= (17 - 9)) and v77() and (VarDRSum < v7:GCD()) and not v33))) then
		if v16(v27.Conflagrate) then
			return "conflagrate cleave 10";
		end
	end
	if (v27.Shadowburn:IsReady() and ((((v27.Shadowburn:FullRechargeTime() <= (v7:GCD() * (8 - 5))) or ((v9:DebuffRemains(v27.EradicationDebuff) <= v7:GCD()) and v27.Eradication:IsAvailable() and not v27.ChaosBolt:InFlight() and not v27.DiabolicRitual:IsAvailable())) and (v27.ConflagrationofChaos:IsAvailable() or v27.BlisteringAtrophy:IsAvailable())) or (v45 <= (174 - (122 + 44))))) then
		if v16(v27.Shadowburn) then
			return "shadowburn cleave 12";
		end
	end
	if (v27.ChaosBolt:IsReady() and not v7:IsMoving() and (v7:BuffUp(v27.RitualofRuinBuff))) then
		if v16(v27.ChaosBolt) then
			return "chaos_bolt cleave 14";
		end
	end
	if ((v27.SummonInfernal:CooldownRemains() >= (155 - 65)) and v27.RainofChaos:IsAvailable()) then
		if (v27.RainofFire:IsReady() and v105()) then
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
	if (v27.ChannelDemonfire:IsReady() and v27.RagingDemonfire:IsAvailable() and (((v9:DebuffRemains(v27.ImmolateDebuff) + v9:DebuffRemains(v27.WitherDebuff)) - ((16 - 11) * v18(v27.ChaosBolt:InFlight() and v27.InternalCombustion:IsAvailable()))) > v27.ChannelDemonfire:CastTime())) then
		if v16(v27.ChannelDemonfire) then
			return "channel_demonfire cleave 26";
		end
	end
	if (v27.SoulFire:IsCastable() and not v7:IsMoving() and (v42 <= (3.5 + 0)) and ((v9:DebuffRemains(v27.RoaringBlazeDebuff) > (v27.SoulFire:CastTime() + v27.SoulFire:TravelTime())) or (not v27.RoaringBlaze:IsAvailable() and v7:BuffUp(v27.BackdraftBuff))) and not v33) then
		if v16(v27.SoulFire) then
			return "soul_fire cleave 28";
		end
	end
	if (v27.Immolate:IsCastable() and not v7:IsMoving()) then
		if v24.CastTargetIf(v27.Immolate, Enemies8ySplash, "min", v83, v91, 6 + 34) then
			return "immolate cleave 30";
		end
	end
	if (v27.SummonInfernal:IsCastable() and IsSummonInfernal) then
		if v16(v27.SummonInfernal, true) then
			return "summon_infernal cleave 32";
		end
	end
	if (v27.Incinerate:IsCastable() and not v7:IsMoving() and v27.DiabolicRitual:IsAvailable() and v77() and ((((VarDRSum - (3 - 1)) - (v18(not v32) * v27.ChaosBolt:CastTime())) - (v18(v32) * v7:GCD())) <= (65 - (30 + 35)))) then
		if v16(v27.Incinerate) then
			return "incinerate cleave 34";
		end
	end
	if (v27.RainofFire:IsReady() and v105() and v37 and not v27.Wither:IsAvailable() and v7:BuffUp(v27.RainofChaosBuff)) then
		if v16(v27.RainofFire) then
			return "rain_of_fire cleave 36";
		end
	end
	if (v27.RainofFire:IsReady() and v105() and (v30 >= (1 + 0)) and not v27.Wither:IsAvailable() and v27.Pyrogenics:IsAvailable() and (v9:DebuffRemains(v27.PyrogenicsDebuff) <= v7:GCD()) and (not v27.RainofChaos:IsAvailable() or (v27.SummonInfernal:CooldownRemains() >= (v7:GCD() * (1260 - (1043 + 214))))) and v37) then
		if v16(v27.RainofFire) then
			return "rain_of_fire cleave 38";
		end
	end
	if (v27.RainofFire:IsReady() and v105() and v31 and v37 and ((v27.SummonInfernal:CooldownRemains() >= (v7:GCD() * (11 - 8))) or not v27.RainofChaos:IsAvailable())) then
		if v16(v27.RainofFire) then
			return "rain_of_fire cleave 40";
		end
	end
	if (v27.SoulFire:IsCastable() and not v7:IsMoving() and (v42 <= (1216 - (323 + 889))) and v27.Mayhem:IsAvailable()) then
		if v16(v27.SoulFire) then
			return "soul_fire cleave 42";
		end
	end
	if (v27.ChaosBolt:IsReady() and not v7:IsMoving() and not v32 and v38 and ((v27.SummonInfernal:CooldownRemains() >= (v7:GCD() * (7 - 4))) or (v42 > (584 - (361 + 219))) or not v27.RainofChaos:IsAvailable())) then
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
	if (v27.Conflagrate:IsCastable() and ((v27.Conflagrate:Charges() > (v27.Conflagrate:MaxCharges() - (321 - (53 + 267)))) or (v46 < (v7:GCD() * v27.Conflagrate:Charges())))) then
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
local function v120()
	v36 = 0 + 0;
	v37 = (v42 >= (416 - (15 + 398))) or (((v27.SecretsoftheCoven:IsAvailable() and v7:BuffUp(v27.InfernalBoltBuff)) or v7:BuffUp(v27.DecimationBuff)) and (v42 >= (985 - (18 + 964))));
	v38 = v37 or (v78() and (v42 >= (11 - 8)));
	for v181, v182 in pairs(Enemies8ySplash) do
		local v183 = v18(v182:DebuffUp(v27.HavocDebuff));
		v36 = v36 + v20(v182:DebuffRemains(v27.ImmolateDebuff) * v183, v182:DebuffRemains(v27.WitherDebuff) * v183);
	end
	v39 = v78() or (v27.SummonInfernal:TimeSinceLastCast() < (12 + 8));
	local v173 = ((v57 > (0 + 0)) and v57) or (851 - (20 + 830));
	v40 = (((v21((v46 / v173) + 1 + 0) ~= v21((v46 + ((246 - (116 + 10)) - v27.SummonInfernal:CooldownRemains())) / (9 + 111))) and ((v21((v46 / v173) + (739 - (542 + 196)))) ~= (v21(((v46 - v27.SummonInfernal:CooldownRemains()) / v173) + (1 - 0))))) or ((v21((v46 / v173) + 1 + 0) == v21((v46 + ((61 + 59) - v27.SummonInfernal:CooldownRemains())) / (44 + 76))) and ((((v46 - (v27.SummonInfernal:CooldownRemains() % v173)) - v27.SummonInfernal:CooldownRemains()) - v69) > (0 - 0)))) and (v27.SummonInfernal:CooldownRemains() > (51 - 31));
	local v174 = ((v58 > (1551 - (1126 + 425))) and v58) or (406 - (118 + 287));
	v41 = (((v21((v46 / v174) + (3 - 2)) ~= v21((v46 + ((1241 - (118 + 1003)) - v27.SummonInfernal:CooldownRemains())) / (351 - 231))) and ((v21((v46 / v174) + (378 - (142 + 235)))) ~= (v21(((v46 - v27.SummonInfernal:CooldownRemains()) / v174) + (4 - 3))))) or ((v21((v46 / v174) + 1 + 0) == v21((v46 + ((1097 - (553 + 424)) - v27.SummonInfernal:CooldownRemains())) / (226 - 106))) and ((((v46 - (v27.SummonInfernal:CooldownRemains() % v174)) - v27.SummonInfernal:CooldownRemains()) - v70) > (0 + 0)))) and (v27.SummonInfernal:CooldownRemains() > (20 + 0));
end
local function v121()
	if v24.ShouldStopCastUpdate() then
		v13.CastMacro(4 + 2, true);
		return "Stop Cast For Silence";
	end
	local v175 = v98();
	v108();
	v99();
	v110();
	BurningRushToggle = v13.ToggleIconFrame:GetToggle(1 + 0);
	InterruptToggle = v13.ToggleIconFrame:GetToggle(2 + 0);
	Smallcds = v13.ToggleIconFrame:GetToggle(6 - 3);
	local v176 = not v7:AffectingCombat() or not v9:AffectingCombat() or v9:IsDummy();
	v43 = v7:GetEnemiesInRange(111 - 71);
	EnemiesRangeOOCCount = v106() or #v43;
	Enemies8ySplash = v9:GetEnemiesInSplashRange(26 - 14);
	if v14() then
		v44 = EnemiesRangeOOCCount;
	else
		v44 = 1 + 0;
	end
	IsRacials = v102(v26.Destruction_TTD.RacialsTTD) and v101(v26.Destruction_CDUSE.Racials);
	IsPotions = v102(v26.Destruction_TTD.PotionsTTD) and (v26.Destruction_CDUSE.Potionswhensolo or (not v26.Destruction_CDUSE.Potionswhensolo and not v24.ISSolo())) and v101(v26.Destruction_CDUSE.Potions);
	IsTrinket1 = v102(v26.Destruction_TTD.TrinketsTTD) and v101(v26.Destruction_CDUSE.Trinket1);
	IsTrinket2 = v102(v26.Destruction_TTD.TrinketsTTD) and v101(v26.Destruction_CDUSE.Trinket2);
	IsSummonInfernal = v105() and v102(v26.Destruction_TTD.SummonInfernalTTD) and v101(v26.Destruction_CDUSE.SummonInfernal);
	IsDimensionalRift = v102(v26.Destruction_TTD.DimensionalRiftTTD) and v101(v26.Destruction_CDUSE.DimensionalRift);
	IsMalevolence = v102(v26.Destruction_TTD.MalevolenceTTD) and v101(v26.Destruction_CDUSE.Malevolence);
	IsCataclysm = v105() and v102(v26.Destruction_TTD.CataclysmTTD) and v101(v26.Destruction_CDUSE.Cataclysm);
	if (v24.TargetIsValid() or v7:AffectingCombat()) then
		GCDMax = v7:GCD() + (0.25 - 0);
		v34, v35, v36 = v74(v43);
		v45 = v3.BossFightRemains();
		v100 = true;
		v46 = v45;
		if (v46 == (11864 - (239 + 514))) then
			v100 = false;
			v46 = v3.FightRemains(v43, false);
		end
		v42 = v7:SoulShardsP();
		VarDRMotherBuffRemains = v7:BuffRemains(v27.DiabolicRitualMotherBuff);
		VarDROverlordBuffRemains = v7:BuffRemains(v27.DiabolicRitualOverlordBuff);
		VarDRPitLordBuffRemains = v7:BuffRemains(v27.DiabolicRitualPitLordBuff);
		VarDRSum = VarDRMotherBuffRemains + VarDROverlordBuffRemains + VarDRPitLordBuffRemains;
		VarSFCDRPlusCT = v27.SoulFire:CooldownRemains() + v27.SoulFire:CastTime();
	end
	if ((v175 == nil) and ((v110() > (2 + 3)) or v7:AffectingCombat()) and not (v7:IsMounted() or v7:IsInVehicle()) and v27.FelDomination:IsReady() and (((v26.Destruction_Pets.FelDomination == "only Infight") and v7.AffectingCombat) or ((v26.Destruction_Pets.FelDomination == "only out of Fight") and not v7.AffectingCombat) or (v26.Destruction_Pets.FelDomination == "both")) and (not v8:IsActive() or (v8:HealthPercentage() < (1330 - (797 + 532))) or v7:BuffUp(v27.GrimoireofSacrificeBuff))) then
		if v16(v27.FelDomination) then
			return "FelDomination missing Pet";
		end
	end
	v23 = ((v110() > (4 + 1)) or v7:AffectingCombat()) and v112() and not (v7:IsMounted() or v7:IsInVehicle());
	if v23 then
		return v23;
	end
	if (v27.GrimoireofSacrifice:IsCastable() and not v7:IsMoving() and (v8:HealthPercentage() > (0 + 0))) then
		if v16(v27.GrimoireofSacrifice) then
			return "grimoire_of_sacrifice";
		end
	end
	if BurningRushToggle then
		if ((v26.Destruction.BurningRush == "always") or ((v26.Destruction.BurningRush == "only infight") and v7:AffectingCombat()) or ((v26.Destruction.BurningRush == "only out of fight") and not v7:AffectingCombat())) then
			if (v27.BurningRush:IsCastable() and v7:IsMoving() and ((v108() > (2 - 1)) or not v7:AffectingCombat()) and v7:BuffDown(v27.BurningRush) and (v7:HealthPercentage() > v26.Destruction.BurningRushcancel) and not v7:IsMounted()) then
				if v16(v27.BurningRush) then
					return "Burning Rush";
				end
			end
		end
		if (v7:BuffUp(v27.BurningRush) and (((v26.Destruction.BurningRush == "only infight") and not v7:AffectingCombat()) or ((v26.Destruction.BurningRush == "only out of fight") and v7:AffectingCombat()) or (v7:HealthPercentage() < v26.Destruction.BurningRushcancel) or (not v7:IsMoving() and v7:BuffUp(v27.BurningRush)))) then
			v13.CastMacro(1204 - (373 + 829), false, nil, v27.BurningRush);
			return "Burnind Rush cancel";
		end
	end
	v23 = not v7:IsCasting(v27.Banish) and v24.IncorpCycle(v27.Banish, 761 - (476 + 255), false, false);
	if v23 then
		return v23;
	end
	if (v27.Soulstone:IsReady() and not v7:IsCasting(v27.Soulstone) and v7:AffectingCombat() and not v7:IsMoving()) then
		if (v9:UnitIsFriend() and v9:UnitIsPlayer() and v9:Exists() and v9:IsDeadOrGhost() and v9:IsInRange(1170 - (369 + 761))) then
			v13.Cast(v27.Soulstone);
			return "Soulstone on Target";
		end
		if (v12:UnitIsFriend() and v12:UnitIsPlayer() and v12:Exists() and v12:IsDeadOrGhost() and v12:IsInRange(24 + 16)) then
			v13.CastTarget(v27.Soulstone, v13.TName().MOUSEOVER);
			return "Soulstone on Mouseover";
		end
	end
	v23 = v113();
	if v23 then
		return v23;
	end
	if v24.TargetIsValid() then
		if (not v26.Destruction.AttackonlyinCombat or (v26.Destruction.AttackonlyinCombat and v9:AffectingCombat())) then
			if not v103(v6.Target) then
				if not v7:AffectingCombat() then
					v23 = v114();
					if v23 then
						return v23;
					end
				end
				if InterruptToggle then
					v23 = v24.InterruptCycle(v27.SpellLockcast, 72 - 32, true, nil, false);
					if v23 then
						return v23;
					end
					v23 = v24.InterruptCycle(v27.SpellLock, 75 - 35, true, nil, false);
					if v23 then
						return v23;
					end
				end
				v120();
				if v9:IsInRange(278 - (64 + 174)) then
					if (v14() and (v44 >= (1 + 2))) then
						local v198 = v118();
						if v198 then
							return v198;
						end
					end
					if (v14() and (v44 > (1 - 0))) then
						local v199 = v119();
						if v199 then
							return v199;
						end
					end
					local v197 = v116();
					if v197 then
						return v197;
					end
					if (v26.Commons.Enabled.Trinkets or v26.Commons.Enabled.Trinkets) then
						local v200 = v115();
						if v200 then
							return v200;
						end
					end
					if (v27.Malevolence:IsReady() and IsMalevolence and (v27.SummonInfernal:CooldownRemains() >= (391 - (144 + 192)))) then
						if v16(v27.Malevolence) then
							return "malevolence main 2";
						end
					end
					if (v27.ChaosBolt:IsReady() and not v7:IsMoving() and (v76())) then
						if v16(v27.ChaosBolt) then
							return "chaos_bolt main 4";
						end
					end
					if (v27.SoulFire:IsCastable() and not v7:IsMoving() and v7:BuffUp(v27.DecimationBuff) and ((v42 <= (220 - (42 + 174))) or (v7:BuffRemains(v27.DecimationBuff) <= (v7:GCD() * (2 + 0)))) and (v9:DebuffRemains(v27.ConflagrateDebuff) >= v27.SoulFire:ExecuteTime())) then
						if v16(v27.SoulFire) then
							return "soul_fire main 6";
						end
					end
					if (v27.WitherAbility:IsReady() and v27.InternalCombustion:IsAvailable() and (((v9:DebuffRemains(v27.WitherDebuff) - ((5 + 0) * v18(v27.ChaosBolt:InFlight()))) < (v27.WitherDebuff:MaxDuration() * (2 + 2))) or (v9:DebuffRemains(v27.WitherDebuff) < (1507 - (363 + 1141))) or (((v9:DebuffRemains(v27.WitherDebuff) - v27.ChaosBolt:ExecuteTime()) < (1585 - (1183 + 397))) and v27.ChaosBolt:IsReady())) and (not v27.SoulFire:IsAvailable() or (VarSFCDRPlusCT > (v9:DebuffRemains(v27.WitherDebuff) - (15 - 10)))) and (v9:TimeToDie() > (6 + 2)) and not v27.SoulFire:InFlight()) then
						if v16(v27.WitherAbility) then
							return "wither main 8";
						end
					end
					if (v27.Conflagrate:IsReady() and ((v27.RoaringBlaze:IsAvailable() and (v9:DebuffRemains(v27.RoaringBlazeDebuff) < (1.5 + 0))) or (v27.Conflagrate:FullRechargeTime() <= (v7:GCD() * (1977 - (1913 + 62)))) or ((v27.Conflagrate:Recharge() <= (6 + 2)) and v77() and (VarDRSum < v7:GCD()) and (v42 >= (2.5 - 1))))) then
						if v16(v27.Conflagrate) then
							return "conflagrate main 10";
						end
					end
					if (v27.Shadowburn:IsReady() and ((((v27.Shadowburn:FullRechargeTime() <= (v7:GCD() * (1936 - (565 + 1368)))) or ((v9:DebuffRemains(v27.EradicationDebuff) <= v7:GCD()) and v27.Eradication:IsAvailable() and not v27.ChaosBolt:InFlight() and not v27.DiabolicRitual:IsAvailable())) and (v27.ConflagrationofChaos:IsAvailable() or v27.BlisteringAtrophy:IsAvailable())) or (v45 <= (30 - 22)))) then
						if v16(v27.Shadowburn) then
							return "shadowburn main 12";
						end
					end
					if (v27.ChaosBolt:IsReady() and not v7:IsMoving() and (v7:BuffUp(v27.RitualofRuinBuff))) then
						if v16(v27.ChaosBolt) then
							return "chaos_bolt main 14";
						end
					end
					if (v27.Shadowburn:IsReady() and (((v27.SummonInfernal:CooldownRemains() >= (1751 - (1477 + 184))) and v27.RainofChaos:IsAvailable()) or v7:BuffUp(v27.MalevolenceBuff))) then
						if v16(v27.Shadowburn) then
							return "shadowburn main 16";
						end
					end
					if (v27.ChaosBolt:IsReady() and not v7:IsMoving() and (((v27.SummonInfernal:CooldownRemains() >= (122 - 32)) and v27.RainofChaos:IsAvailable()) or v7:BuffUp(v27.MalevolenceBuff))) then
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
					if (v27.ChannelDemonfire:IsReady() and not v7:IsMoving() and v27.RagingDemonfire:IsAvailable() and (((v9:DebuffRemains(v27.ImmolateDebuff) + v9:DebuffRemains(v27.WitherDebuff)) - ((5 + 0) * v18(v27.ChaosBolt:InFlight() and v27.InternalCombustion:IsAvailable()))) > v27.ChannelDemonfire:CastTime())) then
						if v16(v27.ChannelDemonfire) then
							return "channel_demonfire main 22";
						end
					end
					if (v27.WitherAbility:IsReady() and not v27.InternalCombustion:IsAvailable() and (((v9:DebuffRemains(v27.WitherDebuff) - ((861 - (564 + 292)) * v18(v27.ChaosBolt:InFlight()))) < (v27.WitherDebuff:MaxDuration() * (0.3 - 0))) or (v9:DebuffRemains(v27.WitherDebuff) < (8 - 5))) and (not v27.Cataclysm:IsAvailable() or not IsCataclysm or (v27.Cataclysm:CooldownRemains() > v9:DebuffRemains(v27.WitherDebuff))) and (not v27.SoulFire:IsAvailable() or (VarSFCDRPlusCT > v9:DebuffRemains(v27.WitherDebuff))) and (v9:TimeToDie() > (312 - (244 + 60))) and not v27.SoulFire:InFlight()) then
						if v16(v27.WitherAbility) then
							return "wither main 24";
						end
					end
					if (v27.Immolate:IsReady() and not v7:IsMoving() and (((v9:DebuffRemains(v27.ImmolateDebuff) - ((4 + 1) * v18(v27.ChaosBolt:InFlight() and v27.InternalCombustion:IsAvailable()))) < (v27.ImmolateDebuff:MaxDuration() * (476.3 - (41 + 435)))) or (v9:DebuffRemains(v27.ImmolateDebuff) < (1004 - (938 + 63))) or (((v9:DebuffRemains(v27.ImmolateDebuff) - v27.ChaosBolt:ExecuteTime()) < (4 + 1)) and v27.InternalCombustion:IsAvailable() and v27.ChaosBolt:IsReady())) and (not v27.Cataclysm:IsAvailable() or not IsCataclysm or (v27.Cataclysm:CooldownRemains() > v9:DebuffRemains(v27.ImmolateDebuff))) and (not v27.SoulFire:IsAvailable() or (VarSFCDRPlusCT > (v9:DebuffRemains(v27.ImmolateDebuff) - ((1130 - (936 + 189)) * v18(v27.InternalCombustion:IsAvailable()))))) and (v9:TimeToDie() > (3 + 5)) and not v27.SoulFire:InFlight()) then
						if v16(v27.Immolate) then
							return "immolate main 26";
						end
					end
					if (v27.SummonInfernal:IsCastable() and IsSummonInfernal) then
						if v16(v27.SummonInfernal, true) then
							return "summon_infernal main 28";
						end
					end
					if (v27.Incinerate:IsCastable() and not v7:IsMoving() and v27.DiabolicRitual:IsAvailable() and v77() and ((((VarDRSum - (1615 - (1565 + 48))) - (v18(not v32) * v27.ChaosBolt:CastTime())) - (v18(v32) * v7:GCD())) <= (0 + 0))) then
						if v16(v27.Incinerate) then
							return "incinerate main 30";
						end
					end
					if (v27.ChaosBolt:IsReady() and not v7:IsMoving() and v38 and ((v27.SummonInfernal:CooldownRemains() >= (v7:GCD() * (1141 - (782 + 356)))) or (v42 > (271 - (176 + 91))) or not v27.RainofChaos:IsAvailable())) then
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
local function v122()
	v13.ResetToggle();
	v26.Destruction.Display();
	v27.ImmolateDebuff:RegisterAuraTracking();
	v27.WitherDebuff:RegisterAuraTracking();
	local v177 = {Burningreushvalue=v27.BurningRush:Name()};
	local v178 = "/cancelaura {Burningreushvalue}";
	v13:UpdateMacro("macro1", "/use 16");
	v13:UpdateMacro("macro2", v111(v178, v177));
	v13:UpdateMacro("macro6", "/stopcasting");
	v13.ToggleIconFrame:AddButtonCustom("B", 1 - 0, "BurningRush", "burningrush");
	v13.ToggleIconFrame:AddButtonCustom("I", 1094 - (975 + 117), "Interrupt", "interrupt");
	v13.ToggleIconFrame:AddButtonCustom("S", 1878 - (157 + 1718), "smallCDs", "smallcds");
	v13.Print("Destruction Warlock rotation has been updated for patch 11.0.2. Last Update 23.09.2024");
end
v13.SetAPL(217 + 50, v121, v122);
