local v0, v1 = ...;
local v2 = HeroDBC.DBC;
local v3 = HeroLib;
local v4 = HeroCache;
local v5 = HeroRotation();
local v6 = v3.Unit;
local v7 = v6.Player;
local v8 = v6.Target;
local v9 = v6.Pet;
local v10 = v3.Spell;
local v11 = v3.Item;
local v12 = C_Timer.After;
local v13 = GetTime;
local v14 = select;
v5.Commons().Hunter = {};
local v16 = v5.Commons().Hunter;
v16.Pet = {};
v16.Pet.Status = ((v9:IsActive()) and (2 - 1)) or (0 - 0);
v16.Pet.GUID = ((v9:IsActive()) and v9:GUID()) or (0 - 0);
v16.Pet.FeignGUID = 0 - 0;
v16.Pet.SummonSpells = {(1814 - (857 + 74)),(84169 - (214 + 713)),(13092 + 70151),(84881 - (1523 + 114)),(118672 - 35427),(2252 - (226 + 1044))};
local v22 = v16.Pet;
v3:RegisterForSelfCombatEvent(function(...)
	local v27, v28, v28, v28, v29 = v14(34 - 26, ...);
	for v40, v41 in pairs(v22.SummonSpells) do
		if (v29 == v41) then
			v22.Status = 118 - (32 + 85);
			v22.GUID = v27;
			v22.FeignGUID = 0 + 0;
		end
	end
end, "SPELL_SUMMON");
v3:RegisterForEvent(function()
	if ((v22.Status == (0 + 0)) and v9:IsActive()) then
		v22.Status = 958 - (892 + 65);
		v22.GUID = v9:GUID();
		v22.FeignGUID = 0 - 0;
	end
end, "SPELLS_CHANGED");
v3:RegisterForSelfCombatEvent(function(...)
	local v30 = v14(21 - 9, ...);
	if (v30 == (4848 - 2207)) then
		v12(351 - (87 + 263), function()
			v22.Status = 180 - (67 + 113);
			v22.GUID = 0 + 0;
			v22.FeignGUID = 0 - 0;
		end);
	end
end, "SPELL_CAST_SUCCESS");
v3:RegisterForCombatEvent(function(...)
	local v31 = v14(6 + 2, ...);
	if (v31 == v22.GUID) then
		v22.Status = 7 - 5;
		v22.GUID = 952 - (802 + 150);
	elseif ((v31 == v7:GUID()) and (v22.Status == (2 - 1))) then
		v22.Status = 5 - 2;
		v22.GUID = 0 + 0;
	end
end, "UNIT_DIED");
v3:RegisterForEvent(function(...)
	local v32, v33, v32, v34 = ...;
	if (v33 ~= "player") then
		return;
	end
	if (v34 == (210994 - (915 + 82))) then
		v22.FeignGUID = v22.GUID;
	end
	if ((v34 == (594630 - 384630)) and (v22.FeignGUID ~= (0 + 0))) then
		v22.GUID = v22.FeignGUID;
		v22.FeignGUID = 0 - 0;
		v22.Status = 1188 - (1069 + 118);
	end
end, "UNIT_SPELLCAST_SUCCEEDED");
v3:RegisterForEvent(function(...)
	v22.GUID = 0 - 0;
	v22.FeignGUID = 0 - 0;
	v22.Status = 0 + 0;
end, "CHALLENGE_MODE_START");
v16.SteadyFocus = {};
v16.SteadyFocus.Count = 0 - 0;
v16.SteadyFocus.LastCast = 0 + 0;
local v26 = v16.SteadyFocus;
v3:RegisterForSelfCombatEvent(function(...)
	local v38 = v14(803 - (368 + 423), ...);
	if (v38 == (178004 - 121363)) then
		v26.Count = v26.Count + (19 - (10 + 8));
		v26.LastCast = v13();
	end
end, "SPELL_CAST_SUCCESS");
v3:RegisterForSelfCombatEvent(function(...)
	local v39 = v14(45 - 33, ...);
	if (v39 == (193976 - (416 + 26))) then
		v26.Count = 0 - 0;
		v26.LastCast = 0 + 0;
	end
end, "SPELL_AURA_APPLIED");
