local v0 = HeroLib;
local v1 = HeroCache;
local v2 = v0.Unit;
local v3 = v2.Player;
local v4 = v2.Pet;
local v5 = v2.Target;
local v6 = v0.Spell;
local v7 = v0.Item;
local v8 = HeroRotation();
local v9 = v8.Commons().Warrior;
local v10 = v6.Warrior.Fury;
local v11 = v6.Warrior.Arms;
local v12 = v6.Warrior.Protection;
local v13 = GetTime;
local v14;
v14 = v0.AddCoreOverride("Spell.IsCastable", function(v19, v20, v21, v22, v23, v24)
	local v25 = v14(v19, v20, v21, v22, v23, v24);
	if (v19 == v11.Charge) then
		return v25 and (v19:Charges() >= (2 - 1)) and not v5:IsInRange(22 - 14) and v5:IsInRange(47 - 22);
	else
		return v25;
	end
end, 182 - 111);
local v15;
v15 = v0.AddCoreOverride("Unit.DebuffUp", function(v26, v27, v28, v29)
	local v30 = v15(v26, v27, v28, v29);
	if (v27 == v11.RavagerDebuff) then
		if v9.Ravager[v26:GUID()] then
			return (v9.Ravager[v26:GUID()] - v13()) < (v11.Ravager:TickTime() + (619.2 - (555 + 64)));
		else
			return false;
		end
	else
		return v30;
	end
end, 1002 - (857 + 74));
local v16;
v16 = v0.AddCoreOverride("Spell.IsCastable", function(v31, v32, v33, v34, v35, v36)
	local v37 = v16(v31, v32, v33, v34, v35, v36);
	if (v31 == v10.Charge) then
		return v37 and (v31:Charges() >= (569 - (367 + 201))) and not v5:IsInRange(935 - (214 + 713)) and v5:IsInRange(7 + 18);
	else
		return v37;
	end
end, 12 + 60);
local v17;
v17 = v0.AddCoreOverride("Spell.IsReady", function(v38, v39, v40, v41, v42, v43)
	local v44 = v17(v38, v39, v40, v41, v42, v43);
	if (v38 == v10.Rampage) then
		if v3:PrevGCDP(878 - (282 + 595), v10.Bladestorm) then
			return v38:IsCastable() and (v3:Rage() >= v38:Cost());
		else
			return v44;
		end
	else
		return v44;
	end
end, 1709 - (1523 + 114));
local v18;
v18 = v0.AddCoreOverride("Spell.IsCastable", function(v45, v46, v47, v48, v49, v50)
	local v51 = v18(v45, v46, v47, v48, v49, v50);
	if (v45 == v12.Charge) then
		return v51 and (v45:Charges() >= (1 + 0)) and not v5:IsInRange(11 - 3);
	elseif ((v45 == v12.HeroicThrow) or (v45 == v12.TitanicThrow)) then
		return v51 and not v5:IsInRange(1073 - (68 + 997));
	elseif (v45 == v12.Avatar) then
		return v51 and (v3:BuffDown(v12.AvatarBuff));
	elseif (v45 == v12.Intervene) then
		return v51 and (v3:IsInParty() or v3:IsInRaid());
	else
		return v51;
	end
end, 1343 - (226 + 1044));
