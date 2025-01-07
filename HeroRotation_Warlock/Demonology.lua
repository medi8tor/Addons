local v0, v1 = ...;
local v2 = HeroDBC.DBC;
local v3 = HeroLib;
local v4 = HeroCache;
local v5 = v3.Unit;
local v6 = v5.Player;
local v7 = v5.Target;
local v8 = v5.Pet;
local v9 = v3.Spell;
local v10 = v3.Item;
local v11 = v5.MouseOver;
local v12 = HeroRotation();
local v13 = v12.Cast;
local v14 = v12.AoEON;
local v15 = v12.CDsON;
local v16 = v12.Commons().Warlock;
local v17 = v12.Commons().Everyone.num;
local v18 = v12.Commons().Everyone.bool;
local v19 = math.max;
local v20 = math.min;
local v21 = C_Timer.After;
local v22;
local v23 = v9.Warlock.Demonology;
local v24 = v10.Warlock.Demonology;
local v25 = {v24.MirrorofFracturedTomorrows:ID(),v24.ImperfectAscendancySerum:ID(),v24.SpymastersWeb:ID(),v24.KahetiShadowweaversEmblem:ID()};
local v26 = v12.Commons().Everyone;
local v27 = v12.GUISettingsGet();
local v28 = {General=v27.General,Commons=v27.APL.Warlock.Commons,Demonology=v27.APL.Warlock.Demonology,Defensives=v27.APL.Warlock.Defensives,Demonology_Pets=v27.APL.Warlock.Demonology_Pets,Demonology_TTD=v27.APL.Warlock.Demonology_TTD,Demonology_CDUSE=v27.APL.Warlock.Demonology_CDUSE};
local v29 = 619 - (555 + 64);
local v30 = true;
local v31 = 931 - (857 + 74);
local v32 = false;
local v33 = false;
local v34 = 568 - (367 + 201);
local v35 = (v23.MarkofFharg:IsAvailable() and v23.SummonCharhound) or (v23.MarkofShatug:IsAvailable() and v23.SummonGloomhound) or v23.SummonVilefiend;
local v36 = 927 - (214 + 713);
local v37 = 0 + 0;
local v38 = 0 + 0;
local v39 = 877 - (282 + 595);
local v40;
local v41, v42;
local v43 = 12748 - (1523 + 114);
local v44 = 9986 + 1125;
local v45 = 16 - 4;
local function v46()
	v45 = 1077 - (68 + 997);
	v45 = v45 + ((v23.GrimoireFelguard:IsAvailable() and v23.GrimoireFelguard:ExecuteTime()) or (1270 - (226 + 1044)));
	v45 = v45 + ((v23.SummonVilefiend:IsAvailable() and v23.SummonVilefiend:ExecuteTime()) or (0 - 0));
	v45 = v45 + (((v23.GrimoireFelguard:IsAvailable() or v23.SummonVilefiend:IsAvailable()) and v6:GCD()) or (117 - (32 + 85)));
	v45 = v45 - (v23.SummonDemonicTyrant:ExecuteTime() + v23.ShadowBolt:ExecuteTime());
	v45 = v20(v45, 10 + 0);
end
v46();
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
local v71, v72;
local v73, v74;
local v75 = 0 + 0;
local function v76()
	local v121, v122 = v6:GetTrinketData(v25);
	if ((v75 < (962 - (892 + 65))) and ((v121.ID == (0 - 0)) or (v122.ID == (0 - 0)) or (v121.Level == (0 - 0)) or (v122.Level == (350 - (87 + 263))) or ((v121.SpellID > (180 - (67 + 113))) and not v121.Usable) or ((v122.SpellID > (0 + 0)) and not v122.Usable))) then
		v75 = v75 + (2 - 1);
		v21(4 + 1, function()
			v76();
		end);
		return;
	end
	v47 = v121.Object;
	v48 = v122.Object;
	v49 = v121.ID;
	v50 = v122.ID;
	v51 = v121.Level;
	v52 = v122.Level;
	v53 = v121.Spell;
	v55 = v121.Range;
	v57 = v121.CastTime;
	v54 = v122.Spell;
	v56 = v122.Range;
	v58 = v122.CastTime;
	v59 = v121.Cooldown;
	v60 = v122.Cooldown;
	v61 = v121.Blacklisted;
	v62 = v122.Blacklisted;
	v63 = v47:HasUseBuff();
	v64 = v48:HasUseBuff();
	v65 = v49 == (770084 - 576327);
	v66 = v50 == (194709 - (802 + 150));
	v67 = (v49 == v24.SpymastersWeb:ID()) or (v49 == v24.ImperfectAscendancySerum:ID()) or (v49 == v24.KahetiShadowweaversEmblem:ID());
	v68 = (v50 == v24.SpymastersWeb:ID()) or (v50 == v24.ImperfectAscendancySerum:ID()) or (v50 == v24.KahetiShadowweaversEmblem:ID());
	v69 = v47:BuffDuration() + (((v49 == v24.MirrorofFracturedTomorrows:ID()) and (53 - 33)) or (0 - 0));
	v70 = v48:BuffDuration() + (((v50 == v24.MirrorofFracturedTomorrows:ID()) and (15 + 5)) or (997 - (915 + 82)));
	v71 = 0.5 - 0;
	if (v63 and (((v59 % (35 + 25)) == (0 - 0)) or (((1247 - (1069 + 118)) % v59) == (0 - 0)))) then
		v71 = 1 - 0;
	end
	v72 = 0.5 + 0;
	if (v64 and (((v60 % (106 - 46)) == (0 + 0)) or (((851 - (368 + 423)) % v60) == (0 - 0)))) then
		v72 = 19 - (10 + 8);
	end
	v73 = 3 - 2;
	if (not v63 and not v64 and (v52 > v51)) then
		v73 = 444 - (416 + 26);
	end
	local v139 = ((v69 > (0 - 0)) and v69) or (1 + 0);
	local v140 = ((v70 > (0 - 0)) and v70) or (439 - (145 + 293));
	v74 = 431 - (44 + 386);
	if ((not v63 and v64) or (v64 and (((v60 / v140) * v72) > ((v59 / v139) * v71 * ((1487 - (998 + 488)) + ((v47:Level() - v48:Level()) / (32 + 68))))))) then
		v74 = 2 + 0;
	end
end
v76();
local v77 = {{v23.Shadowfury,"Cast Shadowfury (Interrupt)",function()
	return true;
end}};
v3:RegisterForEvent(function()
	v29 = 0 - 0;
	v30 = true;
	v31 = 0 - 0;
	v32 = false;
	v33 = false;
	v34 = 859 - (814 + 45);
	v43 = 27376 - 16265;
	v44 = 599 + 10512;
end, "PLAYER_REGEN_ENABLED");
v3:RegisterForEvent(function()
	v76();
end, "PLAYER_EQUIPMENT_CHANGED");
v3:RegisterForEvent(function()
	v23.Demonbolt:RegisterInFlight();
	v23.HandofGuldan:RegisterInFlight();
	v35 = (v23.MarkofFharg:IsAvailable() and v23.SummonCharhound) or (v23.MarkofShatug:IsAvailable() and v23.SummonGloomhound) or v23.Vilefiend;
	v46();
end, "SPELLS_CHANGED", "LEARNED_SPELL_IN_TAB");
v23.Demonbolt:RegisterInFlight();
v23.HandofGuldan:RegisterInFlight();
local function v78()
	return v16.GuardiansTable.ImpCount or (0 + 0);
end
local function v79(v141)
	local v142 = 885 - (261 + 624);
	for v167, v168 in pairs(v16.GuardiansTable.Pets) do
		if (v168.ImpCasts <= v141) then
			v142 = v142 + (1 - 0);
		end
	end
	return v142;
end
local function v80()
	if v26.TargetIsValid() then
		local v169 = v7:MinDistance() or (1085 - (1020 + 60));
		local v170 = v7:MaxDistance() or (1463 - (630 + 793));
		v169 = math.max(v169 - (26 - 18), 23 - 18);
		v170 = math.min(v170 + 4 + 4, 137 - 97);
		local v171 = v6:GetEnemiesInRange(v169);
		local v172 = v6:GetEnemiesInRange(v170);
		local v173 = #v172;
		if ((v170 - v169) > (1763 - (760 + 987))) then
			v173 = v173 - #v171;
		end
		v173 = math.max(v173, 1914 - (1789 + 124));
		return v173;
	else
		return #(v6:GetEnemiesInRange(806 - (745 + 21)));
	end
end
local function v81()
	return v16.GuardiansTable.FelguardDuration or (0 + 0);
end
local function v82()
	return v81() > (0 - 0);
end
local function v83()
	return v16.GuardiansTable.DemonicTyrantDuration or (0 - 0);
end
local function v84()
	return v83() > (0 + 0);
end
local function v85()
	return v16.GuardiansTable.DreadstalkerDuration or (0 + 0);
end
local function v86()
	return v85() > (1055 - (87 + 968));
end
local function v87()
	return v16.GuardiansTable.VilefiendDuration or (0 - 0);
end
local function v88()
	return v87() > (0 + 0);
end
local function v89()
	return v16.GuardiansTable.PitLordDuration or (0 - 0);
end
local function v90()
	return v89() > (1413 - (447 + 966));
end
local function v91(v143)
	return v143:DebuffRemains(v23.DoomBrandDebuff) > (27 - 17);
end
local function v92(v144)
	return v144:DebuffDown(v23.DoomDebuff) or (not v23.Demonbolt:InFlight() and (v7:DebuffRemains(v23.DoomDebuff) <= (1819 - (1703 + 114))));
end
local function v93(v145)
	return v145:DebuffDown(v23.DoomDebuff) or (v42 < (705 - (376 + 325)));
end
local function v94(v146)
	return (v146:DebuffDown(v23.DoomDebuff) or (v42 < (5 - 1))) and (v7:DebuffRemains(v23.DoomDebuff) > (30 - 20)) and v6:BuffUp(v23.DemonicCoreBuff) and (v36 < ((2 + 2) - v17(v23.Quietus:IsAvailable())));
end
local function v95(v147)
	return v147:DebuffRefreshable(v23.Doom);
end
local function v96(v148)
	return v148:DebuffDown(v23.DoomBrandDebuff);
end
local function v97(v149)
	return v149:NPCID() == (450540 - 245980);
end
local function v98(v150)
	return v150:CastSpellID() == (408819 - (9 + 5));
end
local function v99()
	return (v11:Exists() or not v28.Demonology.CursorCheck) and not v6:IsCameraBusy();
end
local v100 = nil;
local function v101()
	if v6:IsMoving() then
		if not v100 then
			v100 = GetTime();
		end
		return GetTime() - v100;
	else
		if v100 then
			v100 = nil;
		end
		return 376 - (85 + 291);
	end
end
local function v102(v151, v152)
	return (v151:gsub("{(.-)}", v152));
end
local v103;
local function v104(v153)
	return (v153 ~= "Not Used") and ((((v153 == "with Cooldowns") or ((v153 == "small CDs") and v28.Demonology_CDUSE.smallcdswithCooldowns) or (v153 == "with Cooldowns or AoE") or (v153 == "on Enemycount or Cooldowns") or (v153 == "on Boss or with Cooldowns")) and v15()) or (v153 == "always") or (((v153 == "on Boss only") or (v153 == "on Boss or on Enemycount") or (v153 == "on Boss or with Cooldowns")) and (v103 or v7:IsDummy())) or ((v153 == "with Bloodlust only") and v6:BloodlustUp()) or ((v153 == "small CDs") and Smallcds) or (((v153 == "on AOE") or (v153 == "with Cooldowns or AoE")) and (v42 > (1267 - (243 + 1022))) and v14()) or (((v153 == "on Enemycount or Cooldowns") or (v153 == "on Enemycount") or (v153 == "on Boss or on Enemycount")) and (v42 >= v28.Demonology_CDUSE.Enemycount) and v14()));
end
local function v105(v154)
	return (v103 and v28.Demonology_TTD.IgnoreWhenBoss) or v26.Buggedmobs[v7:NPCID()] or (v26.ISSolo() and v28.Demonology_TTD.IgnoreWhenSolo) or (v154 == (0 - 0)) or ((v44 >= v154) and (v44 < (6416 + 1361)));
end
local function v106()
	local v155 = nil;
	local v156 = v23.AxeToss:CooldownRemains();
	local v157 = v23.SpellLock:CooldownRemains();
	local v158 = v23.SingeMagic:CooldownRemains();
	local v159 = v23.ShadowBulwark:CooldownRemains();
	local v160 = v23.Seduction:CooldownRemains();
	if (not v8:IsActive() or (v8:HealthPercentage() < (1181 - (1123 + 57)))) then
		v155 = nil;
	elseif ((v6:Level() <= (25 + 5)) and v8:IsActive()) then
		v155 = "Leveling";
	elseif (v23.AxeToss:IsReady() or ((v156 <= (284 - (163 + 91))) and not ((v156 == (1930 - (1869 + 61))) and not v23.AxeToss:IsReady()))) then
		v155 = "Felguard";
	elseif (v23.SpellLock:IsReady() or ((v157 <= (7 + 17)) and not ((v157 == (0 - 0)) and not v23.SpellLock:IsReady()))) then
		v155 = "Felhunter";
	elseif (v23.SingeMagic:IsReady() or ((v158 <= (23 - 8)) and not ((v158 == (0 + 0)) and not v23.SingeMagic:IsReady()))) then
		v155 = "Imp";
	elseif (v23.ShadowBulwark:IsReady() or ((v159 <= (164 - 44)) and not ((v159 == (0 + 0)) and not v23.ShadowBulwark:IsReady()))) then
		v155 = "Voidwalker";
	elseif (v23.Seduction:IsReady() or ((v160 <= (1504 - (1329 + 145))) and not ((v160 == (971 - (140 + 831))) and not v23.Seduction:IsReady()))) then
		v155 = "Sayaad";
	end
	return v155;
end
local function v107()
	local v161 = v28.Demonology_Pets.PetSelected;
	local v162 = v106();
	if ((v161 == "Imp") and (v162 ~= "Imp") and (v162 ~= "Leveling")) then
		if (v23.SummonImp:IsCastable() and not v6:IsMoving() and not v6:IsCasting(v23.SummonImp) and not v6:PrevGCDP(1851 - (1409 + 441), v23.SummonImp) and not (v6:IsMounted() or v6:IsInVehicle())) then
			if v13(v23.SummonImp, false) then
				return "summon Imp";
			end
		end
	elseif ((v161 == "Voidwalker") and (v162 ~= "Voidwalker") and (v162 ~= "Leveling")) then
		if (v23.SummonVoidwalker:IsCastable() and not v6:IsMoving() and not v6:IsCasting(v23.SummonVoidwalker) and not v6:PrevGCDP(719 - (15 + 703), v23.SummonVoidwalker) and not (v6:IsMounted() or v6:IsInVehicle())) then
			if v13(v23.SummonVoidwalker, false) then
				return "summon Voidwalker";
			end
		end
	elseif ((v161 == "Felhunter") and (v162 ~= "Felhunter") and (v162 ~= "Leveling")) then
		if (v23.SummonFelhunter:IsCastable() and not v6:IsMoving() and not v6:IsCasting(v23.SummonFelhunter) and not v6:PrevGCDP(1 + 0, v23.SummonFelhunter) and not (v6:IsMounted() or v6:IsInVehicle())) then
			if v13(v23.SummonFelhunter, false) then
				return "summon Felhunter";
			end
		end
	elseif ((v161 == "Sayaad") and (v162 ~= "Sayaad") and (v162 ~= "Leveling")) then
		if (v23.SummonSayaad:IsCastable() and not v6:IsMoving() and not v6:IsCasting(v23.SummonSayaad) and not v6:PrevGCDP(439 - (262 + 176), v23.SummonSayaad) and not (v6:IsMounted() or v6:IsInVehicle())) then
			if v13(v23.SummonSayaad, false) then
				return "summon Sayaad";
			end
		end
	elseif ((v161 == "Felguard") and (v162 ~= "Felguard") and (v162 ~= "Leveling")) then
		if (v23.SummonFelguard:IsCastable() and not v6:IsMoving() and not v6:IsCasting(v23.SummonFelguard) and not v6:PrevGCDP(1722 - (345 + 1376), v23.SummonFelguard) and not (v6:IsMounted() or v6:IsInVehicle())) then
			if v13(v23.SummonFelguard, false) then
				return "summon Felguard";
			end
		end
	end
	return false;
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
		return 688 - (198 + 490);
	end
end
local function v110()
	Currentpet = v106();
end
local function v111()
	if (v23.UnendingResolve:IsCastable() and v6:AffectingCombat() and (v6:HealthPercentage() <= v28.Defensives.UnendingResolveHP)) then
		if v13(v23.UnendingResolve) then
			return "UnendingResolve";
		end
	end
	if (v23.DarkPact:IsCastable() and v6:AffectingCombat() and (v6:HealthPercentage() <= v28.Defensives.DarkPactHP)) then
		if v13(v23.DarkPact) then
			return "DarkPact";
		end
	end
	if (v23.HealthFunnel:IsCastable() and not v6:IsMoving() and (v8:HealthPercentage() <= v28.Defensives.HealthFunnelHP) and (v8:HealthPercentage() > (0 - 0))) then
		if v13(v23.HealthFunnel) then
			return "HealthFunnel";
		end
	end
	if (v23.DrainLife:IsCastable() and v6:AffectingCombat() and v7:IsInRange(95 - 55) and v6:CanAttack(v7) and v6:AffectingCombat() and not v6:IsMoving() and (v6:HealthPercentage() <= v28.Defensives.DrainLifeHP)) then
		if v13(v23.DrainLife) then
			return "DrainLife";
		end
	end
	if (v23.MortalCoil:IsReady() and v6:AffectingCombat() and v7:IsInRange(1226 - (696 + 510)) and v6:CanAttack(v7) and (v6:HealthPercentage() <= v28.Defensives.MortalCoilHP)) then
		if v13(v23.MortalCoil) then
			return "MortalCoil";
		end
	end
end
local function v112()
	if (v23.PowerSiphon:IsReady() and (v78() > (0 - 0)) and (((v37 + v19(v78(), 1264 - (1091 + 171))) <= (1 + 3)) or (v6:BuffRemains(v23.DemonicCoreBuff) < (9 - 6)))) then
		if v13(v23.PowerSiphon) then
			return "power_siphon precombat 2";
		end
	end
	if (v23.Demonbolt:IsReady() and not v7:IsInBossList() and v6:BuffUp(v23.DemonicCoreBuff)) then
		if v13(v23.Demonbolt) then
			return "demonbolt precombat 4";
		end
	end
	if (v23.ShadowBolt:IsCastable() and not v6:IsMoving()) then
		if v13(v23.ShadowBolt) then
			return "shadow_bolt precombat 8";
		end
	end
end
local function v113()
	if (v23.GrimoireFelguard:IsReady() and IsGrimoireFelguard and (v43 < (66 - 46))) then
		if v13(v23.GrimoireFelguard, true) then
			return "grimoire_felguard fight_end 2";
		end
	end
	if (v23.RuinationAbility:IsReady() and not v6:IsMoving()) then
		if v13(v23.RuinationAbility) then
			return "ruination fight_end 4";
		end
	end
	if (v23.Implosion:IsReady() and IsImplosion and (v43 < ((376 - (123 + 251)) * v6:GCD())) and not v6:PrevGCDP(4 - 3, v23.Implosion)) then
		if v13(v23.Implosion, true) then
			return "implosion fight_end 6";
		end
	end
	if (v23.Demonbolt:IsReady() and (v43 < ((v6:GCD() * (700 - (208 + 490)) * v37) + 1 + 8)) and v6:BuffUp(v23.DemonicCoreBuff) and ((v36 < (2 + 2)) or (v43 < (v37 * v6:GCD())))) then
		if v13(v23.Demonbolt) then
			return "demonbolt fight_end 8";
		end
	end
	if (v23.CallDreadstalkers:IsReady() and (not v6:IsMoving() or v6:BuffUp(v23.DemonicCallingBuff))) then
		if v13(v23.CallDreadstalkers) then
			return "call_dreadstalkers fight_end 10";
		end
	end
	if (v35:IsReady() and not v6:IsMoving()) then
		if v13(v23.SummonVilefiendcast) then
			return "summon_vilefiend fight_end 12";
		end
	end
	if (v23.SummonDemonicTyrant:IsCastable() and not v6:IsMoving() and IsSummonDemonicTyrant and (v43 < (856 - (660 + 176)))) then
		if v13(v23.SummonDemonicTyrant, true) then
			return "summon_demonic_tyrant fight_end 14";
		end
	end
	if (v23.DemonicStrength:IsCastable() and (v43 < (2 + 8))) then
		if v13(v23.DemonicStrength, true) then
			return "demonic_strength fight_end 16";
		end
	end
	if (v23.PowerSiphon:IsReady() and (v78() > (202 - (14 + 188))) and (v37 < (678 - (534 + 141))) and (v43 < (9 + 11))) then
		if v13(v23.PowerSiphon, true) then
			return "power_siphon fight_end 18";
		end
	end
	if (v23.Demonbolt:IsReady() and (v43 < ((v6:GCD() * (2 + 0) * v37) + 9 + 0)) and v6:BuffUp(v23.DemonicCoreBuff) and ((v36 < (8 - 4)) or (v43 < (v37 * v6:GCD())))) then
		if v13(v23.Demonbolt) then
			return "demonbolt fight_end 20";
		end
	end
	if (v23.HandofGuldan:IsReady() and not v6:IsMoving() and (v36 > (2 - 0)) and (v43 < ((v6:GCD() * (5 - 3) * v37) + 5 + 4))) then
		if v13(v23.HandofGuldan) then
			return "hand_of_guldan fight_end 22";
		end
	end
	if (v23.InfernalBolt:IsCastable() and not v6:IsMoving()) then
		if v13(v23.InfernalBolt) then
			return "infernal_bolt fight_end 24";
		end
	end
end
local function v114()
	if v28.Commons.Enabled.Trinkets then
		if (v47:IsReady() and v7:IsInRange(v55) and IsTrinket1 and ((v63 and not v67 and ((not v84() and (v57 > (0 + 0))) or not (v57 > (396 - (115 + 281)))) and (v84() or not v23.SummonDemonicTyrant:IsAvailable() or not IsSummonDemonicTyrant or ((v74 == (4 - 2)) and (v23.SummonDemonicTyrant:CooldownRemains() > (17 + 3)) and not v84() and (v48:CooldownRemains() < (v23.SummonDemonicTyrant:CooldownRemains() + (12 - 7))))) and (v66 or not v48:HasCooldown() or v48:CooldownDown() or ((v74 == (3 - 2)) and not v68))) or (v69 >= v44))) then
			if v13(v47, true) then
				return "trinket1 (" .. v47:Name() .. ") items 2";
			end
		end
		if (v48:IsReady() and v7:IsInRange(v56) and IsTrinket2 and ((v64 and not v68 and ((not v84() and (v58 > (867 - (550 + 317)))) or not (v58 > (0 - 0))) and (v84() or not v23.SummonDemonicTyrant:IsAvailable() or not IsSummonDemonicTyrant or ((v74 == (1 - 0)) and (v23.SummonDemonicTyrant:CooldownRemains() > (55 - 35)) and not v84() and (v47:CooldownRemains() < (v23.SummonDemonicTyrant:CooldownRemains() + (290 - (134 + 151)))))) and (v65 or not v47:HasCooldown() or v47:CooldownDown() or ((v74 == (1667 - (970 + 695))) and not v67))) or (v70 >= v44))) then
			if v13(v48, true) then
				return "trinket2 (" .. v48:Name() .. ") items 4";
			end
		end
		if (v47:IsReady() and v7:IsInRange(v55) and IsTrinket1 and not v63 and not v67 and ((((v74 == (1 - 0)) or v48:CooldownDown()) and (((v57 > (1990 - (582 + 1408))) and not v84()) or not (v57 > (0 - 0)))) or ((v38 < (25 - 5)) and v64) or (v23.SummonDemonicTyrant:CooldownRemains() > (75 - 55)) or not IsSummonDemonicTyrant)) then
			if v13(v47, true) then
				return "trinket1 (" .. v47:Name() .. ") items 6";
			end
		end
		if (v48:IsReady() and v7:IsInRange(v56) and IsTrinket2 and not v64 and not v68 and ((((v74 == (1826 - (1195 + 629))) or v47:CooldownDown()) and (((v58 > (0 - 0)) and not v84()) or not (v58 > (241 - (187 + 54))))) or ((v38 < (800 - (162 + 618))) and v63) or (v23.SummonDemonicTyrant:CooldownRemains() > (15 + 5)) or not IsSummonDemonicTyrant)) then
			if v13(v48, true) then
				return "trinket2 (" .. v48:Name() .. ") items 8";
			end
		end
		if (v24.SpymastersWeb:IsEquippedAndReady() and (((v47:ID() == v24.SpymastersWeb:ID()) and IsTrinket1) or ((v48:ID() == v24.SpymastersWeb:ID()) and IsTrinket2)) and ((v84() and (v43 <= (54 + 26)) and (v6:BuffStack(v23.SpymastersReportBuff) >= (63 - 33)) and ((not v63 and (v50 == v24.SpymastersWeb:ID())) or (not v64 and (v49 == v24.SpymastersWeb:ID())))) or ((v43 <= (33 - 13)) and ((v47:CooldownDown() and (v50 == v24.SpymastersWeb:ID())) or (v48:CooldownDown() and (v49 == v24.SpymastersWeb:ID())) or not v63 or not v64)))) then
			if v13(v24.SpymastersWeb, true) then
				return "spymasters_web items 10";
			end
		end
		if (v24.KahetiShadowweaversEmblem:IsEquippedAndReady() and (((v47:ID() == v24.KahetiShadowweaversEmblem:ID()) and IsTrinket1) or ((v48:ID() == v24.KahetiShadowweaversEmblem:ID()) and IsTrinket2)) and (v6:BuffStack(v23.KahetiShadowweaversEmblemBuff) >= (1 + 4))) then
			if v13(v24.KahetiShadowweaversEmblem, true) then
				return "Kaheti_Shadowweavers_Emblem items 11";
			end
		end
		if (v24.ImperfectAscendancySerum:IsEquippedAndReady() and (((v47:ID() == v24.ImperfectAscendancySerum:ID()) and IsTrinket1) or ((v48:ID() == v24.ImperfectAscendancySerum:ID()) and IsTrinket2)) and (v84() or (v43 <= (1666 - (1373 + 263))))) then
			if v13(v24.ImperfectAscendancySerum, true) then
				return "imperfect_ascendancy_serum items 12";
			end
		end
	end
	if v28.Commons.Enabled.Items then
		local v174, v175, v176 = v6:GetUseableItems(v25, 1016 - (451 + 549));
		if (v174 and v174:IsReady() and v7:IsInRange(v176)) then
			v12.CastMacro(1 + 0, nil, nil, v174);
			return "weapon cast";
		end
	end
	if v28.Commons.Enabled.Trinkets then
		if (v24.MirrorofFracturedTomorrows:IsEquippedAndReady() and (((v49 == v24.MirrorofFracturedTomorrows:ID()) and (v74 == (2 - 0))) or ((v50 == v24.MirrorofFracturedTomorrows:ID()) and (v74 == (1 - 0))))) then
			if v13(v24.MirrorofFracturedTomorrows, true) then
				return "mirror_of_fractured_tomorrows items 16";
			end
		end
		if (v47:IsReady() and v7:IsInRange(v55) and IsTrinket1 and not v67 and not v63 and ((v74 == (1385 - (746 + 638))) or v48:CooldownDown())) then
			if v13(v47, true) then
				return "trinket1 (" .. v47:Name() .. ") items 18";
			end
		end
		if (v48:IsReady() and v7:IsInRange(v56) and IsTrinket2 and not v68 and not v64 and ((v74 == (1 + 1)) or v47:CooldownDown())) then
			if v13(v48, true) then
				return "trinket2 (" .. v48:Name() .. ") items 20";
			end
		end
	end
end
local function v115()
	if (v23.GrimoireFelguard:IsReady() and IsGrimoireFelguard and (v36 >= ((7 - 2) - v17(v23.FelInvocation:IsAvailable())))) then
		if v13(v23.GrimoireFelguard, true) then
			return "grimoire_felguard opener 2";
		end
	end
	if (v35:IsReady() and not v6:IsMoving() and (v36 == (346 - (218 + 123)))) then
		if v13(v23.SummonVilefiendcast) then
			return "summon_vilefiend opener 4";
		end
	end
	if (v23.ShadowBolt:IsCastable() and not v6:IsMoving() and (v36 < (1586 - (1535 + 46))) and v23.CallDreadstalkers:CooldownUp()) then
		if v13(v23.ShadowBolt) then
			return "shadow_bolt opener 6";
		end
	end
	if (v23.CallDreadstalkers:IsReady() and (not v6:IsMoving() or v6:BuffUp(v23.DemonicCallingBuff)) and (v36 == (5 + 0))) then
		if v13(v23.CallDreadstalkers) then
			return "call_dreadstalkers opener 8";
		end
	end
	if (v23.RuinationAbility:IsReady() and not v6:IsMoving()) then
		if v13(v23.RuinationAbility) then
			return "ruination opener 10";
		end
	end
end
local function v116()
	if (v23.Berserking:IsCastable() and IsRacials) then
		if v13(v23.Berserking, true) then
			return "berserking racials 2";
		end
	end
	if (v23.BloodFury:IsCastable() and IsRacials) then
		if v13(v23.BloodFury, true) then
			return "blood_fury racials 4";
		end
	end
	if (v23.Fireblood:IsCastable() and IsRacials) then
		if v13(v23.Fireblood, true) then
			return "fireblood racials 6";
		end
	end
	if (v23.AncestralCall:IsCastable() and IsRacials) then
		if v13(v23.AncestralCall, true) then
			return "ancestral_call racials 8";
		end
	end
end
local function v117()
	if (v31 and (v31 < (v38 + (v6:GCD() * (1 + 1)) + v23.SummonDemonicTyrant:CastTime())) and (v6:PrevGCDP(561 - (306 + 254), v23.HandofGuldan) or v6:PrevGCDP(1 + 0, v23.RuinationAbility)) and ((v31 and (v31 < (v38 + v6:GCD() + v23.SummonDemonicTyrant:CastTime()))) or (v36 < (3 - 1)))) then
		local v177 = v116();
		if v177 then
			return v177;
		end
	end
	if (v28.Commons.Enabled.Potions and IsPotions) then
		local v178 = v26.PotionSelected();
		if (v178 and v178:IsReady() and v31 and (v31 < (v38 + (v6:GCD() * (1469 - (899 + 568))) + v23.SummonDemonicTyrant:CastTime())) and (v6:PrevGCDP(1 + 0, v23.HandofGuldan) or v6:PrevGCDP(2 - 1, v23.RuinationAbility)) and ((v31 and (v31 < (v38 + v6:GCD() + v23.SummonDemonicTyrant:CastTime()))) or (v36 < (605 - (268 + 335))))) then
			v12.CastMacro(293 - (60 + 230), nil, nil, v178);
			return "Cast Potion";
		end
	end
	if (v23.PowerSiphon:IsReady() and (v78() > (572 - (426 + 146))) and (v23.SummonDemonicTyrant:CooldownRemains() < (2 + 13))) then
		if v13(v23.PowerSiphon, true) then
			return "power_siphon tyrant 4";
		end
	end
	if (v23.RuinationAbility:IsReady() and not v6:IsMoving() and (v85() > (v6:GCD() + v23.SummonDemonicTyrant:CastTime())) and ((v36 == (1461 - (282 + 1174))) or v31)) then
		if v13(v23.RuinationAbility) then
			return "ruination tyrant 6";
		end
	end
	if (v23.InfernalBolt:IsCastable() and not v6:IsMoving() and v6:BuffDown(v23.DemonicCoreBuff) and (v31 > (v38 + (v6:GCD() * (813 - (569 + 242))) + v23.SummonDemonicTyrant:CastTime())) and (v36 < (8 - 5))) then
		if v13(v23.InfernalBolt) then
			return "infernal_bolt tyrant 8";
		end
	end
	if (v23.ShadowBolt:IsCastable() and not v6:IsMoving() and ((v6:PrevGCDP(1 + 0, v23.CallDreadstalkers) and (v36 < (1028 - (706 + 318))) and (v37 < (1255 - (721 + 530)))) or (v6:PrevGCDP(1273 - (945 + 326), v23.CallDreadstalkers) and v6:PrevGCDP(2 - 1, v23.ShadowBolt) and v6:BloodlustUp() and (v36 < (5 + 0))) or (v6:PrevGCDP(701 - (271 + 429), v35) and (v6:BuffDown(v23.DemonicCallingBuff) or v6:PrevGCDP(2 + 0, v23.GrimoireFelguard))) or (v6:PrevGCDP(1501 - (1408 + 92), v23.GrimoireFelguard) and (v37 < (1089 - (461 + 625))) and (v6:BuffRemains(v23.DemonicCallingBuff) > (v6:GCD() * (1291 - (993 + 295))))))) then
		if v13(v23.ShadowBolt) then
			return "shadow_bolt tyrant 10";
		end
	end
	if (v23.HandofGuldan:IsReady() and not v6:IsMoving() and (v31 > (v38 + (v6:GCD() * (1 + 1)) + v23.SummonDemonicTyrant:CastTime())) and v6:BuffDown(v23.DemonicCoreBuff) and v6:BuffUp(v23.DemonicArtPitLordBuff) and (v31 < (v38 + (v6:GCD() * (1176 - (418 + 753))) + v23.SummonDemonicTyrant:CastTime()))) then
		if v13(v23.HandofGuldan) then
			return "hand_of_guldan tyrant 12";
		end
	end
	if (v23.HandofGuldan:IsReady() and not v6:IsMoving() and (v31 > (v38 + v6:GCD() + v23.SummonDemonicTyrant:CastTime())) and (v31 < (v38 + (v6:GCD() * (1 + 1)) + v23.SummonDemonicTyrant:CastTime())) and (v85() > (v6:GCD() + v23.SummonDemonicTyrant:CastTime())) and (v36 > (1 + 0))) then
		if v13(v23.HandofGuldan) then
			return "hand_of_guldan tyrant 14";
		end
	end
	if (v23.ShadowBolt:IsCastable() and not v6:IsMoving() and v6:BuffDown(v23.DemonicCoreBuff) and (v31 > (v38 + (v6:GCD() * (1 + 1)) + v23.SummonDemonicTyrant:CastTime())) and (v31 < (v38 + (v6:GCD() * (2 + 2)) + v23.SummonDemonicTyrant:CastTime())) and (v36 < (532 - (406 + 123))) and (v85() > ((v6:GCD() * (1771 - (1749 + 20))) + v23.SummonDemonicTyrant:CastTime()))) then
		if v13(v23.ShadowBolt) then
			return "shadow_bolt tyrant 16";
		end
	end
	if (v23.GrimoireFelguard:IsReady() and not v6:IsMoving() and IsGrimoireFelguard and (v23.SummonDemonicTyrant:CooldownRemains() < (4 + 9 + v6:GCD())) and (v35:CooldownRemains() < v6:GCD()) and (v23.CallDreadstalkers:CooldownRemains() < (v6:GCD() * (1325.33 - (1249 + 73)))) and (((v36 == ((2 + 3) - v17(v23.SoulStrikePetAbility:CooldownRemains() < v6:GCD()))) and v23.FelInvocation:IsAvailable()) or (v36 == (1150 - (466 + 679))))) then
		if v13(v23.GrimoireFelguard, true) then
			return "grimoire_felguard tyrant 18";
		end
	end
	if (v35:IsReady() and not v6:IsMoving() and (v82() or (v23.GrimoireFelguard:CooldownRemains() > (24 - 14)) or not v23.GrimoireFelguard:IsAvailable()) and (v23.SummonDemonicTyrant:CooldownRemains() < (37 - 24)) and (v23.CallDreadstalkers:CooldownRemains() < (v6:GCD() * (1902.33 - (106 + 1794)))) and ((v36 == (2 + 3)) or ((v36 == (2 + 2)) and (v37 == (11 - 7))) or v82())) then
		if v13(v23.SummonVilefiendcast) then
			return "summon_vilefiend tyrant 20";
		end
	end
	if (v23.CallDreadstalkers:IsReady() and (not v6:IsMoving() or v6:BuffUp(v23.DemonicCallingBuff)) and (((not v23.SummonVilefiend:IsAvailable() or v88()) and (v23.SummonDemonicTyrant:CooldownRemains() < (27 - 17)) and (v36 >= ((119 - (4 + 110)) - v17(v37 >= (587 - (57 + 527)))))) or v6:PrevGCDP(1430 - (41 + 1386), v23.GrimoireFelguard))) then
		if v13(v23.CallDreadstalkers) then
			return "call_dreadstalkers tyrant 22";
		end
	end
	if (v23.SummonDemonicTyrant:IsReady() and not v6:IsMoving() and IsSummonDemonicTyrant and v86() and (v85() < ((v6:GCD() * (107 - (17 + 86))) + v23.SummonDemonicTyrant:CastTime()))) then
		if v13(v23.SummonDemonicTyrant, true) then
			return "summon_demonic_tyrant tyrant 24";
		end
	end
	if ((v23.HandofGuldan:IsReady() and not v6:IsMoving() and v86() and (v36 >= (3 + 0))) or (v36 == (11 - 6))) then
		if v13(v23.HandofGuldan) then
			return "hand_of_guldan tyrant 26";
		end
	end
	if (v23.InfernalBolt:IsCastable() and not v6:IsMoving() and v31 and (v36 < (8 - 5))) then
		if v13(v23.InfernalBolt) then
			return "infernal_bolt tyrant 28";
		end
	end
	if (v23.Demonbolt:IsReady() and ((v31 and v6:BuffUp(v23.DemonicCoreBuff) and (v36 < (170 - (122 + 44)))) or (v6:PrevGCDP(1 - 0, v23.CallDreadstalkers) and (v36 < (12 - 8)) and (v37 == (4 + 0))) or ((v37 == (1 + 3)) and (v36 < (7 - 3))) or ((v37 >= (67 - (30 + 35))) and (v23.PowerSiphon:CooldownRemains() < (4 + 1))))) then
		if v13(v23.Demonbolt) then
			return "demonbolt tyrant 30";
		end
	end
	if (v23.RuinationAbility:IsReady() and not v6:IsMoving() and (v31 or ((v36 == (1262 - (1043 + 214))) and (v35:CooldownRemains() > (v6:GCD() * (11 - 8)))))) then
		if v13(v23.RuinationAbility) then
			return "ruination tyrant 32";
		end
	end
	if (v23.ShadowBolt:IsCastable() and not v6:IsMoving()) then
		if v13(v23.ShadowBolt) then
			return "shadow_bolt tyrant 34";
		end
	end
	if (v23.InfernalBolt:IsCastable() and not v6:IsMoving()) then
		if v13(v23.InfernalBolt) then
			return "infernal_bolt tyrant 36";
		end
	end
end
local function v118()
	if not IsSummonDemonicTyrant then
		v29 = 2211 - (323 + 889);
	else
		v29 = v23.SummonDemonicTyrant:CooldownRemains();
	end
	if (v30 and v84()) then
		v30 = false;
	end
	if (v6:PrevGCDP(2 - 1, v23.HandofGuldan) and v86() and (v23.SummonDemonicTyrant:CooldownRemains() < (593 - (361 + 219))) and (v31 == (320 - (53 + 267)))) then
		v31 = ((1 + 1) * v6:SpellHaste() * (419 - (15 + 398))) + (982.58 - (18 + 964)) + v38;
	end
	if (v31 > (0 - 0)) then
		v31 = v20(v31, v85() + v38);
	end
	if ((v31 > (0 + 0)) and v82()) then
		v31 = v20(v31, v81() + v38);
	end
	if v84() then
		v31 = 0 + 0;
	end
	if (v42 > ((851 - (20 + 830)) + v17(v23.SacrificedSouls:IsAvailable()))) then
		v32 = not v84();
	end
	if ((v42 > (2 + 0 + v17(v23.SacrificedSouls:IsAvailable()))) and (v42 < ((131 - (116 + 10)) + v17(v23.SacrificedSouls:IsAvailable())))) then
		v32 = v83() < (1 + 5);
	end
	if (v42 > ((742 - (542 + 196)) + v17(v23.SacrificedSouls:IsAvailable()))) then
		v32 = v83() < (17 - 9);
	end
	v33 = (v23.SummonDemonicTyrant:CooldownRemains() < (6 + 14)) and IsSummonDemonicTyrant and v23.SummonDemonicTyrant:IsAvailable() and (v29 < (11 + 9)) and ((v37 <= (1 + 1)) or v6:BuffDown(v23.DemonicCoreBuff)) and (v35:CooldownRemains() < (v6:GCD() * (20 - 12))) and (v23.CallDreadstalkers:CooldownRemains() < (v6:GCD() * (20 - 12)));
	if v6:BuffUp(v23.DiabolicRitualMotherBuff) then
		v34 = v6:BuffRemains(v23.DiabolicRitualMotherBuff);
	end
	if v6:BuffUp(v23.DiabolicRitualOverlordBuff) then
		v34 = v6:BuffRemains(v23.DiabolicRitualOverlordBuff);
	end
	if v6:BuffUp(v23.DiabolicRitualPitLordBuff) then
		v34 = v6:BuffRemains(v23.DiabolicRitualPitLordBuff);
	end
end
local function v119()
	if v26.ShouldStopCastUpdate() then
		v12.CastMacro(1557 - (1126 + 425), true);
		return "Stop Cast For Silence";
	end
	local v163 = v106();
	v101();
	v110();
	v109();
	BurningRushToggle = v12.ToggleIconFrame:GetToggle(406 - (118 + 287));
	InterruptToggle = v12.ToggleIconFrame:GetToggle(7 - 5);
	Smallcds = v12.ToggleIconFrame:GetToggle(1124 - (118 + 1003));
	local v164 = not v6:AffectingCombat() or not v7:AffectingCombat() or v7:IsDummy();
	v40 = v6:GetEnemiesInRange(117 - 77);
	EnemiesRangeOOCCount = v80() or #v40;
	if v14() then
		v41 = v7:GetEnemiesInSplashRange(385 - (142 + 235));
		v42 = EnemiesRangeOOCCount;
	else
		v41 = {};
		v42 = 4 - 3;
		v40 = {};
	end
	IsRacials = v105(v28.Demonology_TTD.RacialsTTD) and v104(v28.Demonology_CDUSE.Racials);
	IsPotions = v105(v28.Demonology_TTD.PotionsTTD) and (v28.Demonology_CDUSE.Potionswhensolo or (not v28.Demonology_CDUSE.Potionswhensolo and not v26.ISSolo())) and v104(v28.Demonology_CDUSE.Potions);
	IsTrinket1 = v105(v28.Demonology_TTD.TrinketsTTD) and v104(v28.Demonology_CDUSE.Trinket1);
	IsTrinket2 = v105(v28.Demonology_TTD.TrinketsTTD) and v104(v28.Demonology_CDUSE.Trinket2);
	IsSummonDemonicTyrant = v105(v28.Demonology_TTD.SummonDemonicTyrantTTD) and v104(v28.Demonology_CDUSE.SummonDemonicTyrant);
	IsGrimoireFelguard = v105(v28.Demonology_TTD.GrimoireFelguardTTD) and v104(v28.Demonology_CDUSE.GrimoireFelguard);
	IsGuillotine = v99() and v105(v28.Demonology_TTD.GuillotineTTD) and v104(v28.Demonology_CDUSE.Guillotine);
	IsImplosion = v105(v28.Demonology_TTD.ImplosionTTD) and v104(v28.Demonology_CDUSE.Implosion);
	if (v26.TargetIsValid() or v6:AffectingCombat()) then
		v43 = v3.BossFightRemains();
		v103 = true;
		v44 = v43;
		if (v44 == (2418 + 8693)) then
			v103 = false;
			v44 = v3.FightRemains(v40, false);
		end
		v16.UpdatePetTable();
		v38 = v3.CombatTime();
		v36 = v6:SoulShardsP();
		v37 = v6:BuffStack(v23.DemonicCoreBuff);
		if not v35 then
			v35 = (v23.MarkofFharg:IsAvailable() and v23.SummonCharhound) or (v23.MarkofShatug:IsAvailable() and v23.SummonGloomhound) or v23.SummonVilefiend;
		end
	end
	if ((v163 == nil) and ((v109() > (982 - (553 + 424))) or v6:AffectingCombat()) and not (v6:IsMounted() or v6:IsInVehicle()) and v23.FelDomination:IsReady() and (((v28.Demonology_Pets.FelDomination == "only Infight") and v6.AffectingCombat) or ((v28.Demonology_Pets.FelDomination == "only out of Fight") and not v6.AffectingCombat) or (v28.Demonology_Pets.FelDomination == "both")) and (not v8:IsActive() or (v8:HealthPercentage() < (1 - 0)))) then
		if v13(v23.FelDomination) then
			return "FelDomination missing Pet";
		end
	end
	v22 = ((v109() > (5 + 0)) or v6:AffectingCombat()) and not (v6:IsMounted() or v6:IsInVehicle()) and v107();
	if v22 then
		return v22;
	end
	if BurningRushToggle then
		if ((v28.Demonology.BurningRush == "always") or ((v28.Demonology.BurningRush == "only infight") and v6:AffectingCombat()) or ((v28.Demonology.BurningRush == "only out of fight") and not v6:AffectingCombat())) then
			if (v23.BurningRush:IsCastable() and v6:IsMoving() and ((v101() > (1 + 0)) or not v6:AffectingCombat()) and v6:BuffDown(v23.BurningRush) and (v6:HealthPercentage() > v28.Demonology.BurningRushcancel) and not v6:IsMounted()) then
				if v13(v23.BurningRush) then
					return "Burning Rush";
				end
			end
		end
		if (v6:BuffUp(v23.BurningRush) and (((v28.Demonology.BurningRush == "only infight") and not v6:AffectingCombat()) or ((v28.Demonology.BurningRush == "only out of fight") and v6:AffectingCombat()) or (v6:HealthPercentage() < v28.Demonology.BurningRushcancel) or (not v6:IsMoving() and v6:BuffUp(v23.BurningRush)))) then
			v12.CastMacro(2 + 0, nil, nil, v23.BurningRush);
			return "Burnind Rush cancel";
		end
	end
	v22 = not v6:IsCasting(v23.Banish) and v26.IncorpCycle(v23.Banish, 13 + 17, false, false);
	if v22 then
		return v22;
	end
	if (v23.Soulstone:IsReady() and not v6:IsCasting(v23.Soulstone) and v6:AffectingCombat() and not v6:IsMoving()) then
		if (v7:UnitIsFriend() and v7:UnitIsPlayer() and v7:Exists() and v7:IsDeadOrGhost() and v7:IsInRange(23 + 17)) then
			v12.Cast(v23.Soulstone);
			return "Soulstone on Target";
		end
		if (v11:UnitIsFriend() and v11:UnitIsPlayer() and v11:Exists() and v11:IsDeadOrGhost() and v11:IsInRange(86 - 46)) then
			v12.CastTarget(v23.Soulstone, v12.TName().MOUSEOVER);
			return "Soulstone on Mouseover";
		end
	end
	if v26.TargetIsValid() then
		if (v111()) then
			v22 = v111();
			if v22 then
				return v22;
			end
		end
		if (not v28.Demonology.AttackonlyinCombat or (v28.Demonology.AttackonlyinCombat and v7:AffectingCombat())) then
			if not v97(v5.Target) then
				if (not v6:AffectingCombat() and not (v6:IsCasting(v23.Demonbolt) or v6:IsCasting(v23.ShadowBolt))) then
					v22 = v112();
					if v22 then
						return v22;
					end
				end
				if InterruptToggle then
					v22 = v26.InterruptCycle(v23.SpellLock, 111 - 71, true, nil, false);
					if v22 then
						return v22;
					end
					v22 = v26.InterruptCycle(v23.AxeToss, 89 - 49, true, nil, false);
					if v22 then
						return v22;
					end
					v22 = v26.InterruptCycle(v23.AxeToss, 12 + 28, true, nil, true);
					if v22 then
						return v22;
					end
				end
				v118();
				if v7:IsInRange(193 - 153) then
					if (v28.Commons.Enabled.Potions and (v83() > (763 - (239 + 514))) and IsPotions) then
						local v179 = v26.PotionSelected();
						if (v179 and v179:IsReady()) then
							v12.CastMacro(2 + 1, nil, nil, v179);
							return "Cast Potion";
						end
					end
					if (v84() or (v43 < (1351 - (797 + 532))) or (v6:CastSpellID() == v23.SummonDemonicTyrant:ID())) then
						local v180 = v116();
						if v180 then
							return v180;
						end
					end
					if (v28.Commons.Enabled.Trinkets or v28.Commons.Enabled.Items) then
						local v181 = v114();
						if v181 then
							return v181;
						end
					end
					if (v44 < (22 + 8)) then
						local v182 = v113();
						if v182 then
							return v182;
						end
					end
					if (v38 < v45) then
						local v183 = v115();
						if v183 then
							return v183;
						end
					end
					if ((v23.SummonDemonicTyrant:CooldownRemains() < (v6:GCD() * (5 + 9))) and IsSummonDemonicTyrant and v23.SummonDemonicTyrant:IsAvailable()) then
						local v184 = v117();
						if v184 then
							return v184;
						end
					end
					if (v23.HandofGuldan:IsReady() and not v6:IsMoving() and (v38 < (0.5 - 0)) and (((v44 % (1297 - (373 + 829))) > (771 - (476 + 255))) or ((v44 % (1225 - (369 + 761))) < (9 + 6))) and (v23.ReignofTyranny:IsAvailable() or (v42 > (2 - 0)))) then
						if v13(v23.HandofGuldan) then
							return "hand_of_guldan main 4";
						end
					end
					if (v23.CallDreadstalkers:IsReady() and (not v6:IsMoving() or v6:BuffUp(v23.DemonicCallingBuff)) and ((v23.SummonDemonicTyrant:CooldownRemains() > (47 - 22)) or not IsSummonDemonicTyrant or (v29 > (263 - (64 + 174))))) then
						if v13(v23.CallDreadstalkers) then
							return "call_dreadstalkers main 6";
						end
					end
					if (v23.SummonDemonicTyrant:IsReady() and not v6:IsMoving() and IsSummonDemonicTyrant and (v88() or v82() or (v23.GrimoireFelguard:CooldownRemains() > (9 + 51)))) then
						if v13(v23.SummonDemonicTyrant, true) then
							return "summon_demonic_tyrant main 8";
						end
					end
					if (v35:IsReady() and not v6:IsMoving() and ((v23.SummonDemonicTyrant:CooldownRemains() > (44 - 14)) or not IsSummonDemonicTyrant)) then
						if v13(v23.SummonVilefiendcast) then
							return "summon_vilefiend main 10";
						end
					end
					if (v23.Demonbolt:IsReady() and v6:BuffUp(v23.DemonicCoreBuff) and (((not v23.SoulStrike:IsAvailable() or ((v23.SoulStrike:CooldownRemains() > (v6:GCD() * (338 - (144 + 192)))) and v23.FelInvocation:IsAvailable())) and (v36 < (220 - (42 + 174)))) or (v36 < ((4 + 0) - (v17(v42 > (2 + 0)))))) and not v6:PrevGCDP(1 + 0, v23.Demonbolt) and v23.Doom:IsAvailable() and (v23.SummonDemonicTyrant:CooldownRemains() > (1519 - (363 + 1141)))) then
						if v26.CastCycle(v23.Demonbolt, v41, v92, 1620 - (1183 + 397)) then
							return "demonbolt main 12";
						end
					end
					if (v23.Demonbolt:IsReady() and (v37 >= (8 - 5)) and (v36 <= (3 + 0)) and not v33) then
						if v13(v23.Demonbolt) then
							return "demonbolt main 14";
						end
					end
					if (v23.PowerSiphon:IsCastable() and (v78() > (0 + 0)) and (v37 < (1978 - (1913 + 62))) and ((v23.SummonDemonicTyrant:CooldownRemains() > (16 + 9)) or not IsSummonDemonicTyrant)) then
						if v13(v23.PowerSiphon, true) then
							return "power_siphon main 16";
						end
					end
					if v23.DemonicStrength:IsCastable() then
						if v13(v23.DemonicStrength, true) then
							return "demonic_strength main 18";
						end
					end
					if v23.BilescourgeBombers:IsReady() then
						if v13(v23.BilescourgeBombers) then
							return "bilescourge_bombers main 20";
						end
					end
					if (v23.Guillotine:IsCastable() and IsGuillotine and (v23.DemonicStrength:CooldownDown() or not v23.DemonicStrength:IsAvailable())) then
						if v13(v23.Guillotine, true) then
							return "guillotine main 22";
						end
					end
					if (v23.RuinationAbility:IsReady() and not v6:IsMoving()) then
						if v13(v23.RuinationAbility) then
							return "ruination main 24";
						end
					end
					if (v23.InfernalBolt:IsCastable() and not v6:IsMoving() and (v36 < (7 - 4)) and ((v23.SummonDemonicTyrant:CooldownRemains() > (1953 - (565 + 1368))) or not IsSummonDemonicTyrant)) then
						if v13(v23.InfernalBolt) then
							return "infernal_bolt main 26";
						end
					end
					if (v23.Implosion:IsReady() and IsImplosion and (v79(7 - 5) > (1661 - (1477 + 184))) and v32 and not v6:PrevGCDP(1 - 0, v23.Implosion) and (v42 > (3 + 0))) then
						if v13(v23.Implosion, true) then
							return "implosion main 28";
						end
					end
					if (v23.Demonbolt:IsReady() and (v34 > v6:GCD()) and (v34 < (v6:GCD() * (858 - (564 + 292)))) and v6:BuffUp(v23.DemonicCoreBuff) and (v36 <= (4 - 1))) then
						if v13(v23.Demonbolt) then
							return "demonbolt main 30";
						end
					end
					if (v23.ShadowBolt:IsCastable() and not v6:IsMoving() and (v34 > v6:GCD()) and (v34 < ((((15 - 10) - v36) * v23.ShadowBolt:CastTime()) + v6:GCD())) and (v36 < (309 - (244 + 60)))) then
						if v13(v23.ShadowBolt) then
							return "shadow_bolt main 32";
						end
					end
					if (v23.HandofGuldan:IsReady() and not v6:IsMoving() and (((v36 > (2 + 0)) and ((v23.CallDreadstalkers:CooldownRemains() > (v6:GCD() * (480 - (41 + 435)))) or ((v6:BuffRemains(v23.DemonicCallingBuff) - v6:GCD()) > v23.CallDreadstalkers:CooldownRemains())) and ((v23.SummonDemonicTyrant:CooldownRemains() > (1018 - (938 + 63))) or not IsSummonDemonicTyrant)) or (v36 == (4 + 1)) or ((v36 == (1129 - (936 + 189))) and v23.FelInvocation:IsAvailable())) and (v42 == (1 + 0))) then
						if v13(v23.HandofGuldan) then
							return "hand_of_guldan main 34";
						end
					end
					if (v23.HandofGuldan:IsReady() and not v6:IsMoving() and (v36 > (1615 - (1565 + 48))) and not (v42 == (1 + 0))) then
						if v13(v23.HandofGuldan) then
							return "hand_of_guldan main 36";
						end
					end
					if (v23.Demonbolt:IsReady() and (v37 > (1139 - (782 + 356))) and (((v36 < (271 - (176 + 91))) and not v23.SoulStrike:IsAvailable()) or ((v23.SoulStrike:CooldownRemains() > (v6:GCD() * (4 - 2))) and v23.FelInvocation:IsAvailable()) or (v36 < (4 - 1))) and not v33) then
						if v26.CastCycle(v23.Demonbolt, v41, v93, 1132 - (975 + 117)) then
							return "demonbolt main 38";
						end
					end
					if (v23.Demonbolt:IsReady() and v6:BuffUp(v23.DemonicCoreBuff) and v84() and (v36 < ((1878 - (157 + 1718)) - v17(v23.Quietus:IsAvailable())))) then
						if v13(v23.Demonbolt) then
							return "demonbolt main 40";
						end
					end
					if (v23.Demonbolt:IsReady() and (v37 > (1 + 0)) and (v36 < ((14 - 10) - v17(v23.Quietus:IsAvailable())))) then
						if v13(v23.Demonbolt) then
							return "demonbolt main 42";
						end
					end
					if (v23.Demonbolt:IsReady() and v23.Doom:IsAvailable() and not v33 and (v7:DebuffDown(v23.DoomDebuff) or (v42 < (13 - 9))) and (v7:DebuffRemains(v23.DoomDebuff) > (1028 - (697 + 321))) and v6:BuffUp(v23.DemonicCoreBuff) and (v36 < ((10 - 6) - v17(v23.Quietus:IsAvailable())))) then
						if v13(v23.Demonbolt) then
							return "demonbolt main 44";
						end
					end
					if (v23.Demonbolt:IsReady() and v6:BuffUp(v23.DemonicCoreBuff) and (v23.PowerSiphon:CooldownRemains() < (8 - 4)) and (v36 < ((8 - 4) - v17(v23.Quietus:IsAvailable()))) and not v33) then
						if v26.CastCycle(v23.Demonbolt, v41, v93, 16 + 24) then
							return "demonbolt main 46";
						end
					end
					if (v23.PowerSiphon:IsCastable() and (v78() > (0 - 0)) and v6:BuffDown(v23.DemonicCoreBuff) and ((v23.SummonDemonicTyrant:CooldownRemains() > (66 - 41)) or not IsSummonDemonicTyrant)) then
						if v13(v23.PowerSiphon, true) then
							return "power_siphon main 48";
						end
					end
					if (v35:IsReady() and not v6:IsMoving() and (v43 < (v23.SummonDemonicTyrant:CooldownRemains() + (1232 - (322 + 905))))) then
						if v13(v23.SummonVilefiendcast) then
							return "summon_vilefiend main 50";
						end
					end
					if (v23.ShadowBolt:IsCastable() and not v6:IsMoving()) then
						if v13(v23.ShadowBolt) then
							return "shadow_bolt main 52";
						end
					end
					if (v23.InfernalBolt:IsCastable() and not v6:IsMoving()) then
						if v13(v23.InfernalBolt) then
							return "infernal_bolt main 54";
						end
					end
				end
			end
		end
	end
end
local function v120()
	v12.ResetToggle();
	v28.Demonology.Display();
	local v165 = {Burningreushvalue=v23.BurningRush:Name()};
	local v166 = "/cancelaura {Burningreushvalue}";
	v12:UpdateMacro("macro1", "/use 16");
	v12:UpdateMacro("macro2", v102(v166, v165));
	v12:UpdateMacro("macro6", "/stopcasting");
	v12.ToggleIconFrame:AddButtonCustom("B", 612 - (602 + 9), "BurningRush", "burningrush");
	v12.ToggleIconFrame:AddButtonCustom("I", 1191 - (449 + 740), "Interrupt", "interrupt");
	v12.ToggleIconFrame:AddButtonCustom("S", 875 - (826 + 46), "smallCDs", "smallcds");
	v12.Print("Demonology Warlock rotation has been updated for patch 11.0.2. Last Update 23.09.2024");
end
v12.SetAPL(1213 - (245 + 702), v119, v120);
