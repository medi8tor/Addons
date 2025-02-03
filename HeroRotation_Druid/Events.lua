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
local v11 = v8.Druid.Balance;
v3.Commons().Druid = {};
local v13 = v3.Commons().Druid;
v13.FullMoonLastCast = nil;
v13.OrbitBreakerStacks = 0 - 0;
v2:RegisterForSelfCombatEvent(function(v16, v17, v17, v17, v17, v17, v17, v17, v17, v17, v17, v18)
	if (v18 == (579511 - 377014)) then
		v13.OrbitBreakerStacks = v13.OrbitBreakerStacks + (1 - 0);
	end
	if (v18 == (706524 - 432241)) then
		if (not v11.NewMoon:IsAvailable() or (v11.NewMoon:IsAvailable() and ((v13.FullMoonLastCast == nil) or ((v16 - v13.FullMoonLastCast) > (620.5 - (555 + 64)))))) then
			v13.OrbitBreakerStacks = 931 - (857 + 74);
		end
	end
end, "SPELL_DAMAGE");
v2:RegisterForSelfCombatEvent(function(v19, v20, v20, v20, v20, v20, v20, v20, v20, v20, v20, v21)
	if (v21 == (274851 - (367 + 201))) then
		v13.FullMoonLastCast = v19;
	end
end, "SPELL_CAST_SUCCESS");
