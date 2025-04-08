local v0 = HeroLib;
local v1 = HeroCache;
local v2 = v0.Unit;
local v3 = v2.Player;
local v4 = v2.Pet;
local v5 = v2.Target;
local v6 = v0.Spell;
local v7 = v0.Item;
local v8 = HeroRotation();
local v9 = v8.Commons().Everyone;
local v10 = v6.Monk.Brewmaster;
local v11 = v6.Monk.Windwalker;
local v12;
v12 = v0.AddCoreOverride("Spell.IsCastable", function(v14, v15, v16, v17, v18, v19)
	local v20 = v12(v14, v15, v16, v17, v18, v19);
	if (v14 == v10.TouchofDeath) then
		return v20 and v14:IsUsable();
	else
		return v20;
	end
end, 837 - 569);
local v13;
v13 = v0.AddCoreOverride("Spell.IsReady", function(v21, v22, v23, v24, v25, v26)
	local v27 = true;
	if v23 then
		local v29 = v25 or v5;
		v27 = v29:IsInRange(v23, v24);
	end
	local v28 = v13(v21, v22, v23, v24, v25, v26) and v9.ShouldStopCast(v21);
	return v28;
end, 772 - 502);
