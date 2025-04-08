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
local v10 = v6.Paladin.Protection;
local v11 = v6.Paladin.Retribution;
local v12;
v12 = v0.AddCoreOverride("Spell.IsReady", function(v19, v20, v21, v22, v23, v24)
	local v25 = true;
	if v21 then
		local v55 = v23 or v5;
		v25 = v55:IsInRange(v21, v22);
	end
	local v26 = v12(v19, v20, v21, v22, v23, v24) and v9.ShouldStopCast(v19);
	return v26;
end, 203 - 138);
local v13;
v13 = v0.AddCoreOverride("Player.BuffUp", function(v27, v28, v29, v30)
	local v31 = v13(v27, v28, v29, v30);
	if ((v28 == v10.AvengingWrathBuff) and v10.Sentinel:IsAvailable()) then
		return v3:BuffUp(v10.SentinelBuff);
	else
		return v31;
	end
end, 188 - 122);
local v14;
v14 = v0.AddCoreOverride("Player.BuffRemains", function(v32, v33, v34, v35)
	local v36 = v14(v32, v33, v34, v35);
	if ((v33 == v10.AvengingWrathBuff) and v10.Sentinel:IsAvailable()) then
		return v3:BuffRemains(v10.SentinelBuff);
	else
		return v36;
	end
end, 126 - 60);
local v15;
v15 = v0.AddCoreOverride("Spell.CooldownRemains", function(v37, v38)
	local v39 = v15(v37, v38);
	if ((v37 == v10.AvengingWrath) and v10.Sentinel:IsAvailable()) then
		return v10.Sentinel:CooldownRemains();
	else
		return v39;
	end
end, 169 - 103);
local v16;
v16 = v0.AddCoreOverride("Spell.IsAvailable", function(v40, v41)
	local v42 = v16(v40, v41);
	if ((v40 == v10.AvengingWrath) and v10.Sentinel:IsAvailable()) then
		return v10.Sentinel:IsAvailable();
	else
		return v42;
	end
end, 685 - (555 + 64));
local v17;
v17 = v0.AddCoreOverride("Spell.IsCastable", function(v43, v44, v45, v46, v47, v48)
	local v49 = v17(v43, v44, v45, v46, v47, OffSet);
	if (v43 == v10.RiteofAdjuration) then
		return v49 and v3:BuffDown(v10.RiteofAdjurationBuff);
	elseif (v43 == v10.RiteofSanctification) then
		return v49 and v3:BuffDown(v10.RiteofSanctificationBuff);
	else
		return v49;
	end
end, 997 - (857 + 74));
local v18;
v18 = v0.AddCoreOverride("Player.BuffUp", function(v50, v51, v52, v53)
	local v54 = v18(v50, v51, v52, v53);
	if ((v51 == v11.AvengingWrathBuff) and v11.RadiantGlory:IsAvailable()) then
		return v3:BuffUp(v11.AvengingWrathRadiantGloryBuff);
	end
	if ((v51 == v11.CrusadeBuff) and v11.RadiantGlory:IsAvailable()) then
		return v3:BuffUp(v11.CrusadeRadiantGloryBuff);
	end
	return v54;
end, 638 - (367 + 201));
