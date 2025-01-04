local v0, v1 = ...;
local v2 = HeroLib;
local v3 = HeroRotation();
local v4 = HeroCache;
local v5 = v2.Unit;
local v6 = v5.Player;
local v7 = v5.Target;
local v8 = v2.Spell;
local v9 = v2.Item;
local v10 = GetTime;
local v11 = C_Timer;
local v12 = select;
v3.Commons().Shaman = {};
local v14 = v3.Commons().Shaman;
v14.LastSKCast = 0 - 0;
v14.LastSKBuff = 0 - 0;
v14.LastRollingThunderTick = 0 - 0;
v14.FeralSpiritCount = 0 - 0;
v14.CracklingSurgeStacks = 619 - (555 + 64);
v14.IcyEdgeStacks = 931 - (857 + 74);
v14.MoltenWeaponStacks = 568 - (367 + 201);
v14.TempestMaelstrom = 927 - (214 + 713);
v2:RegisterForSelfCombatEvent(function(...)
	local v25, v26, v26, v26, v26, v26, v26, v26, v27 = v12(2 + 2, ...);
	
	if ((v25 == v6:GUID()) and (v27 == (30139 + 161495))) then
		v14.LastSKCast = v10();
	end
end, "SPELL_CAST_SUCCESS");
v2:RegisterForSelfCombatEvent(function(...)
	local v28, v29, v29, v29, v30 = v12(885 - (282 + 595), ...);
	if ((v28 == v6:GUID()) and (v30 == (193271 - (1523 + 114)))) then
		v14.LastSKBuff = v10();
		v11.After(0.1 + 0, function()
			if (v14.LastSKBuff ~= v14.LastSKCast) then
				v14.LastRollingThunderTick = v14.LastSKBuff;
			end
		end);
	end
end, "SPELL_AURA_APPLIED", "SPELL_AURA_APPLIED_DOSE");
v2:RegisterForSelfCombatEvent(function(...)
	local v31 = v12(16 - 4, ...);
	if (v31 == (263692 - (68 + 997))) then
		v14.FeralSpiritCount = v14.FeralSpiritCount + (1271 - (226 + 1044));
		v11.After(65 - 50, function()
			v14.FeralSpiritCount = v14.FeralSpiritCount - (118 - (32 + 85));
		end);
	end
end, "SPELL_SUMMON");
v2:RegisterForCombatEvent(function(...)
	local v32, v33, v33, v33, v34 = v12(8 + 0, ...);
	if (v32 == v6:GUID()) then
		if (v34 == (49701 + 174424)) then
			v14.MoltenWeaponStacks = v14.MoltenWeaponStacks + (958 - (892 + 65));
		elseif (v34 == (534659 - 310533)) then
			v14.IcyEdgeStacks = v14.IcyEdgeStacks + (1 - 0);
		elseif (v34 == (411458 - 187331)) then
			v14.CracklingSurgeStacks = v14.CracklingSurgeStacks + (351 - (87 + 263));
		end
	end
end, "SPELL_AURA_APPLIED");
v2:RegisterForCombatEvent(function(...)
	local v35, v36, v36, v36, v37 = v12(188 - (67 + 113), ...);
	if (v35 == v6:GUID()) then
		if (v37 == (164345 + 59780)) then
			v14.MoltenWeaponStacks = v14.MoltenWeaponStacks - (2 - 1);
		elseif (v37 == (164834 + 59292)) then
			v14.IcyEdgeStacks = v14.IcyEdgeStacks - (3 - 2);
		elseif (v37 == (225079 - (802 + 150))) then
			v14.CracklingSurgeStacks = v14.CracklingSurgeStacks - (2 - 1);
		end
	end
end, "SPELL_AURA_REMOVED");
v14.FireElemental = {GreaterActive=false,LesserActive=false};
v14.StormElemental = {GreaterActive=false,LesserActive=false};
v2:RegisterForSelfCombatEvent(function(...)
	local v38, v39, v39, v39, v40 = v12(14 - 6, ...);
	if ((v40 == (137275 + 51317)) or (v40 == (119288 - (915 + 82)))) then
		v14.FireElemental.GreaterActive = true;
		v11.After(84 - 54, function()
			v14.FireElemental.GreaterActive = false;
		end);
	elseif ((v40 == (269715 + 193277)) or (v40 == (608898 - 145907))) then
		v14.FireElemental.LesserActive = true;
		v11.After(1202 - (1069 + 118), function()
			v14.FireElemental.LesserActive = false;
		end);
	elseif ((v40 == (356865 - 199566)) or (v40 == (344130 - 186811))) then
		v14.StormElemental.GreaterActive = true;
		v11.After(6 + 24, function()
			v14.StormElemental.GreaterActive = false;
		end);
	elseif ((v40 == (822645 - 359652)) or (v40 == (459286 + 3704))) then
		v14.StormElemental.LesserActive = true;
		v11.After(806 - (368 + 423), function()
			v14.StormElemental.LesserActive = false;
		end);
	end
end, "SPELL_SUMMON");
v2:RegisterForSelfCombatEvent(function(...)
	local v41 = v12(37 - 25, ...);
	if (v41 == (344197 - (10 + 8))) then
		v14.TempestMaelstrom = v14.TempestMaelstrom + (3 - 2);
		if (v14.TempestMaelstrom >= (482 - (416 + 26))) then
			v14.TempestMaelstrom = v14.TempestMaelstrom - (127 - 87);
		end
	end
end, "SPELL_AURA_APPLIED", "SPELL_AURA_APPLIED_DOSE");
