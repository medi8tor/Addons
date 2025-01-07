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
local v10 = v6.Mage.Arcane;
local v11 = v6.Mage.Fire;
local v12 = v6.Mage.Frost;
local v13 = math.min;
local v14 = v8.GUISettingsGet();
local v15 = {General=v14.General,Commons=v14.APL.Mage.Commons,Frost=v14.APL.Mage.Frost,Fire=v14.APL.Mage.Fire,Arcane=v14.APL.Mage.Arcane};
local function v16(v30)
	if v30 then
		return 2 - 1;
	else
		return 0 - 0;
	end
end
local function v17(v31)
	return v31 ~= (0 - 0);
end
local v18;
v18 = v0.AddCoreOverride("Player.AffectingCombat", function(v32)
	return v10.ArcaneBlast:InFlight() or v18(v32);
end, 159 - 97);
v0.AddCoreOverride("Spell.IsCastable", function(v33, v34, v35, v36, v37, v38)
	if ((v33:CastTime() > (619 - (555 + 64))) and v3:IsMoving() and v15.Arcane.MovingRotation) then
		return false;
	end
	local v39 = true;
	if v35 then
		local v109 = v37 or v5;
		v39 = v109:IsInRange(v35, v36);
	end
	local v40 = v33:IsLearned() and (v33:CooldownRemains(v34, v38 or "Auto") == (931 - (857 + 74))) and v39 and (v3:Mana() >= v33:Cost()) and v9.ShouldStopCast(v33);
	if (v33 == v10.PresenceofMind) then
		return v40 and v3:BuffDown(v10.PresenceofMind);
	elseif (v33 == v10.RadiantSpark) then
		return v40 and not v3:IsCasting(v33);
	elseif (v33 == v10.ShiftingPower) then
		return v40 and not v3:IsCasting(v33);
	elseif (v33 == v10.TouchoftheMagi) then
		return v40 and not v3:IsCasting(v33);
	elseif (v33 == v10.ConjureManaGem) then
		local v114 = v7.Mage.Arcane.ManaGem;
		local v115 = v114:CooldownRemains();
		return v40 and not v3:IsCasting(v33) and not (v114:IsReady() or (v115 > (568 - (367 + 201))));
	elseif (v33 == v10.ArcaneSurge) then
		return v33:IsLearned() and v33:CooldownUp() and v39;
	else
		return v40;
	end
end, 989 - (214 + 713));
local v19;
v19 = v0.AddCoreOverride("Player.BuffStack", function(v41, v42, v43, v44)
	local v45 = v19(v41, v42, v43, v44);
	if ((v42 == v11.PyroclasmBuff) and v41:IsCasting(v11.Pyroblast)) then
		return 0 + 0;
	else
		return v45;
	end
end, 10 + 53);
local v20;
v20 = v0.AddCoreOverride("Player.BuffRemains", function(v46, v47, v48, v49)
	local v50 = v20(v46, v47, v48, v49);
	if ((v47 == v11.PyroclasmBuff) and v46:IsCasting(v11.Pyroblast)) then
		return 877 - (282 + 595);
	end
	return v50;
end, 1700 - (1523 + 114));
v0.AddCoreOverride("Spell.IsReady", function(v51, v52, v53, v54, v55, v56)
	local v57 = v51:IsCastable() and v51:IsUsableP();
	local v58 = true;
	if ((v51:CastTime() > (0 + 0)) and v3:IsMoving() and v15.Fire.MovingRotation) then
		if ((v51 == v11.Scorch) or ((v51 == v11.Pyroblast) and v3:BuffUp(v11.HotStreakBuff)) or ((v51 == v11.Flamestrike) and v3:BuffUp(v11.HotStreakBuff))) then
			v58 = true;
		else
			return false;
		end
	else
		return v57;
	end
end, 88 - 25);
v0.AddCoreOverride("Spell.IsCastable", function(v59, v60, v61, v62, v63, v64)
	if ((v59:CastTime() > (1065 - (68 + 997))) and v3:IsMoving() and v15.Arcane.MovingRotation) then
		return false;
	end
	local v65 = true;
	if v61 then
		local v110 = v63 or v5;
		v65 = v110:IsInRange(v61, v62);
	end
	local v66 = v59:IsLearned() and (v59:CooldownRemains(v60, v64 or "Auto") == (1270 - (226 + 1044))) and v65 and v9.ShouldStopCast(v59);
	if (v59 == v11.RadiantSpark) then
		return v66 and not v3:IsCasting(v59);
	elseif (v59 == v11.ShiftingPower) then
		return v66 and not v3:IsCasting(v59);
	else
		return v66;
	end
end, 274 - 211);
local v21;
v21 = v0.AddCoreOverride("Player.AffectingCombat", function(v67)
	return v21(v67) or v3:IsCasting(v11.Pyroblast) or v3:IsCasting(v11.Fireball);
end, 180 - (32 + 85));
v0.AddCoreOverride("Spell.TotalTimeRequired", function(v68)
	return v68:TravelTime() + v68:CastTime();
end, 61 + 1);
v0.AddCoreOverride("Spell.TotalTimeRequired", function(v69)
	return v69:TravelTime() + v69:CastTime();
end, 14 + 49);
v0.AddCoreOverride("Spell.TotalTimeRequired", function(v70)
	return v70:TravelTime() + v70:CastTime();
end, 1021 - (892 + 65));
v0.AddCoreOverride("Spell.InFlightRemains", function(v71)
	return v71:TravelTime() - v71:TimeSinceLastCast();
end, 150 - 87);
local v22;
v22 = v0.AddCoreOverride("Spell.IsCastable", function(v72, v73, v74, v75, v76, v77)
	local v78 = true;
	if ((v72:CastTime() > (0 - 0)) and v3:IsMoving() and v15.Frost.MovingRotation) then
		if ((v72 == v12.Blizzard) and v3:BuffUp(v12.FreezingRain)) then
			v78 = true;
		else
			return false;
		end
	end
	local v79 = true;
	if v74 then
		local v111 = v76 or v5;
		v79 = v111:IsInRange(v74, v75) and v9.ShouldStopCast(v72);
	end
	if (v72 == v12.GlacialSpike) then
		return v72:IsLearned() and v79 and v78 and not v3:IsCasting(v72) and (v3:BuffUp(v12.GlacialSpikeBuff) or (v3:BuffStack(v12.IciclesBuff) == (8 - 3)));
	else
		local v112 = v22(v72, v73, v74, v75, v76, v77);
		if (v72 == v12.MirrorsofTorment) then
			return v112 and not v3:IsCasting(v72);
		elseif (v72 == v12.RadiantSpark) then
			return v112 and not v3:IsCasting(v72);
		elseif (v72 == v12.ShiftingPower) then
			return v112 and not v3:IsCasting(v72);
		elseif (v72 == v12.Deathborne) then
			return v112 and not v3:IsCasting(v72);
		else
			return v112;
		end
	end
end, 414 - (87 + 263));
local v23;
v23 = v0.AddCoreOverride("Spell.CooldownRemains", function(v80, v81, v82)
	if ((v80 == v12.Blizzard) and v3:IsCasting(v80)) then
		return 188 - (67 + 113);
	else
		return v23(v80, v81, v82);
	end
end, 47 + 17);
local v24;
v24 = v0.AddCoreOverride("Player.BuffStackP", function(v83, v84, v85, v86)
	local v87 = v3:BuffStack(v84);
	if (v84 == v12.IciclesBuff) then
		local v113 = v87;
		if v83:IsCasting(v12.GlacialSpike) then
			return 0 - 0;
		end
		if (not v12.GlacialSpike:IsAvailable() and (v12.IceLance:TimeSinceLastCast() < ((2 + 0) * v3:SpellHaste()))) then
			v113 = 0 - 0;
		end
		return v13(v113 + ((v83:IsCasting(v12.Frostbolt) and (953 - (802 + 150))) or (0 - 0)), 9 - 4);
	elseif (v84 == v12.GlacialSpikeBuff) then
		return (v83:IsCasting(v12.GlacialSpike) and (0 + 0)) or v87;
	elseif (v84 == v12.WintersReachBuff) then
		return (v83:IsCasting(v12.Flurry) and (997 - (915 + 82))) or v87;
	elseif (v84 == v12.FingersofFrostBuff) then
		if v12.IceLance:InFlight() then
			if (v87 == (0 - 0)) then
				return 0 + 0;
			else
				return v87 - (1 - 0);
			end
		else
			return v87;
		end
	else
		return v87;
	end
end, 1251 - (1069 + 118));
local v25;
v25 = v0.AddCoreOverride("Player.BuffUpP", function(v88, v89, v90, v91)
	local v92 = v3:BuffUp(v89);
	if (v89 == v12.FingersofFrostBuff) then
		if v12.IceLance:InFlight() then
			return v3:BuffStack(v89) >= (2 - 1);
		else
			return v92;
		end
	else
		return v92;
	end
end, 139 - 75);
local v26;
v26 = v0.AddCoreOverride("Player.BuffDownP", function(v93, v94, v95, v96)
	local v97 = v3:BuffDown(v94);
	if (v94 == v12.FingersofFrostBuff) then
		if v12.IceLance:InFlight() then
			return v3:BuffStack(v94) == (0 + 0);
		else
			return v97;
		end
	else
		return v97;
	end
end, 113 - 49);
local v27;
v27 = v0.AddCoreOverride("Target.DebuffStack", function(v98, v99, v100, v101)
	local v102 = v27(v98, v99, v100, v101);
	if (v99 == v12.WintersChillDebuff) then
		if v12.Flurry:InFlight() then
			return 2 + 0;
		elseif v12.IceLance:InFlight() then
			if (v102 == (791 - (368 + 423))) then
				return 0 - 0;
			else
				return v102 - (19 - (10 + 8));
			end
		else
			return v102;
		end
	else
		return v102;
	end
end, 246 - 182);
local v28;
v28 = v0.AddCoreOverride("Target.DebuffRemains", function(v103, v104, v105, v106)
	local v107 = v28(v103, v104, v105, v106);
	if (v104 == v12.WintersChillDebuff) then
		return (v12.Flurry:InFlight() and (448 - (416 + 26))) or v107;
	else
		return v107;
	end
end, 204 - 140);
local v29;
v29 = v0.AddCoreOverride("Player.AffectingCombat", function(v108)
	return v12.Frostbolt:InFlight() or v29(v108);
end, 28 + 36);
