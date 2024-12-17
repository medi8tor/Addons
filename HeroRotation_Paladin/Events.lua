local v0, v1 = ...;
local v2 = HeroLib;
local v3 = HeroRotation();
local v4 = HeroCache;
local v5 = v2.Unit;
local v6 = v5.Player;
local v7 = v5.Target;
local v8 = v2.Spell;
local v9 = v2.Item;
local v10 = pairs;
local v11 = select;
v3.Commons().Paladin = {};
local v13 = v3.Commons().Paladin;
v13.HPGCount = 0 - 0;
v13.DivineHammerActive = false;
local v16 = v4.Persistent.Player.Spec[2 - 1];
v13.HPGCount = 0 - 0;
v2:RegisterForSelfCombatEvent(function(...)
	if (v16 == (169 - 103)) then
		v13.HPGCount = v13.HPGCount + (620 - (555 + 64));
	end
end, "SPELL_ENERGIZE");
v2:RegisterForSelfCombatEvent(function(...)
	local v17 = v11(943 - (857 + 74), ...);
	if (v17 == (385695 - (367 + 201))) then
		v13.HPGCount = 927 - (214 + 713);
	elseif (v17 == (49571 + 148463)) then
		v13.DivineHammerActive = true;
	end
end, "SPELL_AURA_APPLIED", "SPELL_AURA_APPLIED_DOSE");
v2:RegisterForSelfCombatEvent(function(...)
	local v18 = v11(2 + 10, ...);
	if (v18 == (198911 - (282 + 595))) then
		v13.DivineHammerActive = false;
	end
end, "SPELL_AURA_REMOVED");
