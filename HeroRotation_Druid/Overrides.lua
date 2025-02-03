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
local v8 = HeroRotation();
local v10 = v6.Druid.Guardian;
local v11 = v6.Druid.Balance;
local v12 = v6.Druid.Feral;
local v13 = v6.Druid.Restoration;
v0.AddCoreOverride("Player.AstralPowerP", function()
	local v20 = v3:AstralPower();
	if not v3:IsCasting() then
		return v20;
	elseif (v3:IsCasting(v11.Wrath) or v3:IsCasting(v11.Starfire) or v3:IsCasting(v11.StellarFlare)) then
		return v20 + (24 - 16);
	elseif v3:IsCasting(v11.NewMoon) then
		return v20 + (28 - 18);
	elseif v3:IsCasting(v11.HalfMoon) then
		return v20 + (38 - 18);
	elseif v3:IsCasting(v11.FullMoon) then
		return v20 + (103 - 63);
	else
		return v20;
	end
end, 721 - (555 + 64));
v0.AddCoreOverride("Spell.EnergizeAmount", function(v21)
	local v22 = 931 - (857 + 74);
	if (v21 == v11.StellarFlare) then
		v22 = 580 - (367 + 201);
	elseif (v21 == v11.AstralCommunion) then
		v22 = 987 - (214 + 713);
	elseif (v21 == v11.ForceofNature) then
		v22 = 6 + 14;
	elseif (v21 == v11.Sunfire) then
		v22 = 2 + 6;
	elseif (v21 == v11.Moonfire) then
		v22 = 883 - (282 + 595);
	elseif (v21 == v11.NewMoon) then
		v22 = 1649 - (1523 + 114);
	elseif (v21 == v11.HalfMoon) then
		v22 = 22 + 2;
	elseif (v21 == v11.FullMoon) then
		v22 = 71 - 21;
	end
	return v22;
end, 1167 - (68 + 997));
local v14;
v14 = v0.AddCoreOverride("Spell.IsCastable", function(v23, v24, v25, v26, v27, v28)
	local v29 = true;
	if v25 then
		local v67 = v27 or v5;
		v29 = v67:IsInRange(v25, v26);
	end
	local v30 = v14(v23, v24, v25, v26, v27, v28) and v9.ShouldStopCast(v23);
	if (v23 == v11.MoonkinForm) then
		return v30 and v3:BuffDown(v23);
	elseif (v23 == v11.StellarFlare) then
		return v30 and not v3:IsCasting(v23);
	elseif ((v23 == v11.Wrath) or (v23 == v11.Starfire)) then
		return v30 and not (v3:IsCasting(v23) and (v23:Count() == (1271 - (226 + 1044))));
	elseif (v23 == v11.WarriorofElune) then
		return v30 and v3:BuffDown(v23);
	elseif ((v23 == v11.NewMoon) or (v23 == v11.HalfMoon) or (v23 == v11.FullMoon)) then
		return v30 and not v3:IsCasting(v23);
	else
		return v30;
	end
end, 444 - 342);
local v15;
v15 = v0.AddCoreOverride("Spell.IsCastable", function(v31, v32, v33, v34, v35, v36)
	local v37 = v15(v31, v32, v33, v34, v35, v36);
	if ((v31 == v12.CatForm) or (v31 == v12.MoonkinForm)) then
		return v37 and v3:BuffDown(v31);
	else
		return v37;
	end
end, 220 - (32 + 85));
local v16;
v16 = v0.AddCoreOverride("Spell.IsReady", function(v38, v39, v40, v41, v42, v43)
	local v44 = v16(v38, v39, v40, v41, v42, v43);
	if (v38 == v12.Prowl) then
		return v44 and not v3:StealthUp(true, true);
	else
		return v44;
	end
end, 101 + 2);
local v17;
v17 = v0.AddCoreOverride("Spell.IsCastable", function(v45, v46, v47, v48, v49, v50)
	local v51 = v17(v45, v46, v47, v48, v49, v50);
	if (v45 == v10.Thrash) then
		return v51 and (((v3:Rage() <= (22 + 73)) and (v5:DebuffRemains(v10.ThrashDebuff) > (v3:GCD() * (959 - (892 + 65))))) or (v5:DebuffStack(v10.ThrashDebuff) < (7 - 4)));
	elseif (v45 == v10.BearForm) then
		return v51 and v3:BuffDown(v45);
	elseif (v45 == v10.WildCharge) then
		return v51 and v5:IsInRange(51 - 23) and not v5:IsInRange(14 - 6);
	else
		return v51;
	end
end, 454 - (87 + 263));
local v18;
v18 = v0.AddCoreOverride("Spell.IsCastable", function(v52, v53, v54, v55, v56, v57)
	local v58 = v18(v52, v53, v54, v55, v56, v57) and v9.ShouldStopCast(v52);
	if ((v52 == v13.CatForm) or (v52 == v13.MoonkinForm)) then
		return v58 and v3:BuffDown(v52);
	else
		return v58;
	end
end, 285 - (67 + 113));
local v19;
v19 = v0.AddCoreOverride("Spell.IsReady", function(v59, v60, v61, v62, v63, v64)
	local v65 = true;
	if v61 then
		local v68 = v63 or v5;
		v65 = v68:IsInRange(v61, v62);
	end
	local v66 = v19(v59, v60, v61, v62, v63, v64) and v9.ShouldStopCast(v59);
	return v66;
end, 77 + 28);
