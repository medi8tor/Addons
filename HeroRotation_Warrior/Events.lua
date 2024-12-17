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
local v11 = C_Timer.After;
v3.Commons().Warrior = {};
local v13 = v3.Commons().Warrior;
v13.Ravager = {};
v2:RegisterForSelfCombatEvent(function(...)
	local v15, v16, v16, v16, v17 = select(24 - 16, ...);
	if (v17 == (447266 - 290979)) then
		if not v13.Ravager[v15] then
			v11(28 - 13, function()
				v13.Ravager[v15] = nil;
			end);
		end
		v13.Ravager[v15] = v10();
	end
end, "SPELL_DAMAGE");
v2:RegisterForCombatEvent(function(...)
	local v18 = select(20 - 12, ...);
	if v13.Ravager[v18] then
		v13.Ravager[v18] = nil;
	end
end, "UNIT_DIED", "UNIT_DESTROYED");
