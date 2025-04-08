local v0 = HeroLib;
local v1 = HeroCache;
local v2 = v0.Unit;
local v3 = v2.Player;
local v4 = v2.Pet;
local v5 = v2.Target;
local v6 = v0.Spell;
local v7 = v0.Item;
local v8 = HeroRotation();
local v9 = v8.Commons().Everyone.num;
local v10 = v8.Commons().Everyone;
local v11 = v6.Priest.Discipline;
local v12 = v6.Priest.Shadow;
local v13 = UnitPower;
local v14 = Enum.PowerType.Insanity;
local v15;
v15 = v0.AddCoreOverride("Spell.IsCastable", function(v21, v22, v23, v24, v25, v26)
	local v27 = v15(v21, v22, v23, v24, v25, v26);
	if ((v21 == v11.MindBlast) or (v21 == v11.Schism)) then
		return v27 and not v3:IsCasting(v21);
	elseif ((v21 == v11.Smite) or (v21 == v11.DivineStar) or (v21 == v11.Halo) or (v21 == v11.Penance) or (v21 == v11.PowerWordSolace)) then
		return v27 and not v3:BuffUp(v11.ShadowCovenantBuff);
	else
		return v27;
	end
end, 800 - 544);
local v16;
v16 = v0.AddCoreOverride("Spell.IsReady", function(v28, v29, v30, v31, v32, v33)
	local v34 = true;
	if v30 then
		local v61 = v32 or v5;
		v34 = v61:IsInRange(v30, v31);
	end
	local v35 = v16(v28, v29, v30, v31, v32, v33) and v10.ShouldStopCast(v28);
	return v35;
end, 732 - 476);
local v17;
v17 = v0.AddCoreOverride("Spell.IsReady", function(v36, v37, v38, v39, v40, v41)
	local v42 = true;
	if v38 then
		local v62 = v40 or v5;
		v42 = v62:IsInRange(v38, v39);
	end
	local v43 = v17(v36, v37, v38, v39, v40, v41) and v10.ShouldStopCast(v36);
	return v43;
end, 496 - 239);
v0.AddCoreOverride("Player.Insanity", function()
	local v44 = v13("Player", v14);
	if not v3:IsCasting() then
		return v44;
	elseif v3:IsCasting(v12.MindBlast) then
		return v44 + (15 - 9);
	elseif (v3:IsCasting(v12.VampiricTouch) or v3:IsCasting(v12.MindSpike)) then
		return v44 + (623 - (555 + 64));
	elseif v3:IsCasting(v12.MindFlay) then
		return v44 + ((943 - (857 + 74)) / v12.MindFlay:BaseDuration());
	elseif v3:IsCasting(v12.DarkAscension) then
		return v44 + (598 - (367 + 201));
	elseif v3:IsCasting(v12.VoidTorrent) then
		return v44 + ((987 - (214 + 713)) / v12.VoidTorrent:BaseDuration());
	else
		return v44;
	end
end, 65 + 193);
local v18;
v18 = v0.AddCoreOverride("Spell.IsReady", function(v45, v46, v47, v48, v49, v50)
	local v51 = v18(v45, v46, v47, v48, v49, v50) and v10.ShouldStopCast(v45);
	if (v45 == v12.MindSpikeInsanity) then
		return v51 and ((v3:BuffStack(v12.MindSpikeInsanityBuff) - v9(v3:IsCasting(v12.MindSpikeInsanity))) > (0 + 0));
	elseif (v45 == v12.Halo) then
		return v51 and not v3:IsCasting(v45);
	else
		return v51;
	end
end, 1135 - (282 + 595));
local v19;
v19 = v0.AddCoreOverride("Spell.IsCastable", function(v52, v53, v54, v55, v56, v57)
	local v58 = v19(v52, v53, v54, v55, v56, v57) and v10.ShouldStopCast(v52);
	if (v52 == v12.VampiricTouch) then
		return v58 and (not v12.ShadowCrash:InFlight() or (v12.ShadowCrash:TimeSinceLastCast() > v3:GCD())) and (not v12.ShadowCrashTarget:InFlight() or (v12.ShadowCrashTarget:TimeSinceLastCast() > v3:GCD())) and (v12.UnfurlingDarkness:IsAvailable() or not v3:IsCasting(v52));
	elseif (v52 == v12.MindBlast) then
		return v58 and ((v52:Charges() >= (1639 - (1523 + 114))) or not v3:IsCasting(v52));
	elseif (v52 == v12.VoidEruption) then
		return v58 and not v3:IsCasting(v52);
	elseif (v52 == v12.VoidBolt) then
		return v58 or v3:IsCasting(v12.VoidEruption);
	else
		return v58;
	end
end, 232 + 26);
local v20;
v20 = v0.AddCoreOverride("Spell.InFlight", function(v59)
	local v60 = v20(v59);
	if (v59 == v12.ShadowCrash) then
		return v12.ShadowCrash:TimeSinceLastCast() < (2 - 0);
	else
		return v60;
	end
end, 1323 - (68 + 997));
