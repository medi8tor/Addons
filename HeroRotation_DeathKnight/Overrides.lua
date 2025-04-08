local v0 = HeroLib;
local v1 = HeroCache;
local v2 = v0.Unit;
local v3 = v2.Player;
local v4 = v2.Pet;
local v5 = v2.Target;
local v6 = v0.Spell;
local v7 = v0.Item;
local v8 = HeroRotation();
local v9 = v6.DeathKnight.Blood;
local v10 = v6.DeathKnight.Frost;
local v11 = v6.DeathKnight.Unholy;
local v12 = GetTime;
local v13 = next;
local v14 = v8.Commons().DeathKnight;
local v15;
v15 = v0.AddCoreOverride("Spell.IsCastable", function(v20, v21, v22, v23, v24, v25)
	local v26 = v15(v20, v21, v22, v23, v24, v25);
	if (v20 == v9.RaiseDead) then
		return not v4:IsActive() and v26;
	else
		return v26;
	end
end, 781 - 531);
v0.AddCoreOverride("Player.DnDTicking", function(v27)
	if (v13(v14.DnDTable) == nil) then
		return false;
	end
	local v28 = false;
	for v55, v56 in pairs(v14.DnDTable) do
		if ((v12() - v56) < (2.25 - 1)) then
			v28 = true;
		end
	end
	if (v28 and v3:BuffUp(v9.DeathAndDecayBuff)) then
		return true;
	end
	return false;
end, 482 - 232);
v0.AddCoreOverride("Player.BonestormTicking", function(v29)
	if (v13(v14.BonestormTable) == nil) then
		return false;
	end
	for v57, v58 in pairs(v14.BonestormTable) do
		if ((v12() - v58) < (2.25 - 1)) then
			return true;
		end
	end
	return false;
end, 869 - (555 + 64));
local v16;
v16 = v0.AddCoreOverride("Spell.IsCastable", function(v30, v31, v32, v33, v34, v35)
	local v36 = v16(v30, v31, v32, v33, v34, v35);
	if (v30 == v10.RaiseDead) then
		return not v4:IsActive() and v36;
	else
		return v36;
	end
end, 1182 - (857 + 74));
local v17;
v17 = v0.AddCoreOverride("Spell.IsCastable", function(v37, v38, v39, v40, v41, v42)
	local v43 = v17(v37, v38, v39, v40, v41, v42);
	if (v37 == v11.RaiseDead) then
		return not v4:IsActive() and v43;
	elseif (v37 == v11.DarkTransformation) then
		return v4:IsActive() and (v4:NPCID() == (26693 - (367 + 201))) and v43;
	else
		return v43;
	end
end, 1179 - (214 + 713));
local v18;
v18 = v0.AddCoreOverride("Spell.IsReady", function(v44, v45, v46, v47, v48, v49)
	local v50 = v18(v44, v45, v46, v47, v48, v49);
	if (v44 == v11.Epidemic) then
		return (v11.VirulentPlagueDebuff:AuraActiveCount() > (1 + 0)) and v50;
	else
		return v50;
	end
end, 40 + 212);
local v19;
v19 = v0.AddCoreOverride("Spell.IsAvailable", function(v51)
	local v52 = v19(v51);
	if (not v8.CDsON() and ((v51 == v11.Apocalypse) or (v51 == v11.UnholyAssault))) then
		return false;
	else
		return v52;
	end
end, 1129 - (282 + 595));
v0.AddCoreOverride("Player.DnDTicking", function(v53)
	if (v13(v14.DnDTable) == nil) then
		return false;
	end
	local v54 = false;
	for v59, v60 in pairs(v14.DnDTable) do
		if ((v12() - v60) < (1638.25 - (1523 + 114))) then
			v54 = true;
		end
	end
	if (v54 and v3:BuffUp(v11.DeathAndDecayBuff)) then
		return true;
	end
	return false;
end, 227 + 25);
