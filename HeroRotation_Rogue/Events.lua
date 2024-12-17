local v0, v1 = ...;
local v2 = HeroLib;
local v3, v4 = HeroCache, v2.Utils;
local v5 = v2.Unit;
local v6, v7, v8 = v5.Player, v5.Pet, v5.Target;
local v9, v10 = v5.Focus, v5.MouseOver;
local v11, v12, v13 = v5.Arena, v5.Boss, v5.Nameplate;
local v14, v15 = v5.Party, v5.Raid;
local v16 = v2.Spell;
local v17 = v2.Item;
local v18 = HeroRotation();
local v19 = v18.Commons().Rogue;
local v20 = C_Timer;
local v21 = math.max;
local v22 = math.min;
local v23 = math.abs;
local v24 = pairs;
local v25 = table.insert;
local v26 = UnitAttackSpeed;
local v27 = GetTime;
do
	local v28 = v27();
	v19.RtBRemains = function(v48)
		local v49 = (v28 - v27()) - v2.RecoveryOffset(v48);
		return ((v49 >= (0 - 0)) and v49) or (0 - 0);
	end;
	v2:RegisterForSelfCombatEvent(function(v50, v50, v50, v50, v50, v50, v50, v50, v50, v50, v50, v51)
		if (v51 == (609035 - 293527)) then
			v28 = v27() + (77 - 47);
		end
	end, "SPELL_AURA_APPLIED");
	v2:RegisterForSelfCombatEvent(function(v52, v52, v52, v52, v52, v52, v52, v52, v52, v52, v52, v53)
		if (v53 == (316127 - (555 + 64))) then
			v28 = v27() + v22(971 - (857 + 74), (598 - (367 + 201)) + v19.RtBRemains(true));
		end
	end, "SPELL_AURA_REFRESH");
	v2:RegisterForSelfCombatEvent(function(v54, v54, v54, v54, v54, v54, v54, v54, v54, v54, v54, v55)
		if (v55 == (316435 - (214 + 713))) then
			v28 = v27();
		end
	end, "SPELL_AURA_REMOVED");
end
do
	local v30 = {CrimsonTempest={},Garrote={},Rupture={}};
	v19.Exsanguinated = function(v56, v57)
		local v58 = v56:GUID();
		if not v58 then
			return false;
		end
		local v59 = v57:ID();
		if (v59 == (30391 + 91020)) then
			return v30.CrimsonTempest[v58] or false;
		elseif (v59 == (111 + 592)) then
			return v30.Garrote[v58] or false;
		elseif (v59 == (2820 - (282 + 595))) then
			return v30.Rupture[v58] or false;
		end
		return false;
	end;
	v19.WillLoseExsanguinate = function(v60, v61)
		if v19.Exsanguinated(v60, v61) then
			return true;
		end
		return false;
	end;
	v19.ExsanguinatedRate = function(v62, v63)
		if v19.Exsanguinated(v62, v63) then
			return 1639 - (1523 + 114);
		end
		return 1 + 0;
	end;
	v2:RegisterForSelfCombatEvent(function(v64, v64, v64, v64, v64, v64, v64, v65, v64, v64, v64, v66)
		if (v66 == (286266 - 85460)) then
			for v109, v110 in v24(v30) do
				for v111, v112 in v24(v110) do
					if (v111 == v65) then
						v110[v111] = true;
					end
				end
			end
		end
	end, "SPELL_CAST_SUCCESS");
	v2:RegisterForSelfCombatEvent(function(v67, v67, v67, v67, v67, v67, v67, v68, v67, v67, v67, v69)
		if (v69 == (122476 - (68 + 997))) then
			v30.CrimsonTempest[v68] = false;
		elseif (v69 == (1973 - (226 + 1044))) then
			v30.Garrote[v68] = false;
		elseif (v69 == (8460 - 6517)) then
			v30.Rupture[v68] = false;
		end
	end, "SPELL_AURA_APPLIED", "SPELL_AURA_REFRESH");
	v2:RegisterForSelfCombatEvent(function(v70, v70, v70, v70, v70, v70, v70, v71, v70, v70, v70, v72)
		if (v72 == (121528 - (32 + 85))) then
			if (v30.CrimsonTempest[v71] ~= nil) then
				v30.CrimsonTempest[v71] = nil;
			end
		elseif (v72 == (689 + 14)) then
			if (v30.Garrote[v71] ~= nil) then
				v30.Garrote[v71] = nil;
			end
		elseif (v72 == (431 + 1512)) then
			if (v30.Rupture[v71] ~= nil) then
				v30.Rupture[v71] = nil;
			end
		end
	end, "SPELL_AURA_REMOVED");
	v2:RegisterForCombatEvent(function(v73, v73, v73, v73, v73, v73, v73, v74)
		if (v30.CrimsonTempest[v74] ~= nil) then
			v30.CrimsonTempest[v74] = nil;
		end
		if (v30.Garrote[v74] ~= nil) then
			v30.Garrote[v74] = nil;
		end
		if (v30.Rupture[v74] ~= nil) then
			v30.Rupture[v74] = nil;
		end
	end, "UNIT_DIED", "UNIT_DESTROYED");
end
do
	local v34 = v16(196584 - (892 + 65));
	local v35 = 0 - 0;
	local v36 = v27();
	v19.FanTheHammerCP = function()
		if (((v27() - v36) < (0.5 - 0)) and (v35 > (0 - 0))) then
			if (v35 > v6:ComboPoints()) then
				return v35;
			else
				v35 = 350 - (87 + 263);
			end
		end
		return 180 - (67 + 113);
	end;
	v2:RegisterForSelfCombatEvent(function(v75, v75, v75, v75, v75, v75, v75, v75, v75, v75, v75, v76, v75, v75, v77, v78)
		if (v76 == (136215 + 49548)) then
			if ((v27() - v36) > (0.5 - 0)) then
				v35 = v22(v19.CPMaxSpend(), v6:ComboPoints() + v77 + (v21(0 + 0, v77 - (3 - 2)) * v22(954 - (802 + 150), v6:BuffStack(v34) - (2 - 1))));
				v36 = v27();
			end
		end
	end, "SPELL_ENERGIZE");
end
do
	local v38, v39 = 0 - 0, 0 + 0;
	local v40 = v16(278922 - (915 + 82));
	v19.TimeToNextTornado = function()
		if not v6:BuffUp(v40, nil, true) then
			return 0 - 0;
		end
		local v79 = v6:BuffRemains(v40, nil, true) % (1 + 0);
		if (v27() == v38) then
			return 0 - 0;
		elseif (((v27() - v38) < (1187.1 - (1069 + 118))) and (v79 < (0.25 - 0))) then
			return 1 - 0;
		elseif (((v79 > (0.9 + 0)) or (v79 == (0 - 0))) and ((v27() - v38) > (0.75 + 0))) then
			return 791.1 - (368 + 423);
		end
		return v79;
	end;
	v2:RegisterForSelfCombatEvent(function(v80, v80, v80, v80, v80, v80, v80, v80, v80, v80, v80, v81)
		if (v81 == (668582 - 455839)) then
			v38 = v27();
		elseif (v81 == (197853 - (10 + 8))) then
			v39 = v27();
		end
		if (v39 == v38) then
			v38 = 0 - 0;
		end
	end, "SPELL_CAST_SUCCESS");
end
do
	local v42 = {Counter=(442 - (416 + 26)),LastMH=(0 - 0),LastOH=(0 + 0)};
	v19.TimeToSht = function(v82)
		if (v42.Counter >= v82) then
			return 0 - 0;
		end
		local v83, v84 = v26("player");
		local v85 = v21(v42.LastMH + v83, v27());
		local v86 = v21(v42.LastOH + v84, v27());
		local v87 = {};
		for v99 = 438 - (145 + 293), 432 - (44 + 386) do
			v25(v87, v85 + (v99 * v83));
			v25(v87, v86 + (v99 * v84));
		end
		table.sort(v87);
		local v88 = v22(1491 - (998 + 488), v21(1 + 0, v82 - v42.Counter));
		return v87[v88] - v27();
	end;
	v2:RegisterForSelfCombatEvent(function()
		v42.Counter = 0 + 0;
		v42.LastMH = v27();
		v42.LastOH = v27();
	end, "PLAYER_ENTERING_WORLD");
	v2:RegisterForSelfCombatEvent(function(v92, v92, v92, v92, v92, v92, v92, v92, v92, v92, v92, v93)
		if (v93 == (197683 - (201 + 571))) then
			v42.Counter = 1138 - (116 + 1022);
		end
	end, "SPELL_ENERGIZE");
	v2:RegisterForSelfCombatEvent(function(v94, v94, v94, v94, v94, v94, v94, v94, v94, v94, v94, v94, v94, v94, v94, v94, v94, v94, v94, v94, v94, v94, v94, v95)
		v42.Counter = v42.Counter + (4 - 3);
		if v95 then
			v42.LastOH = v27();
		else
			v42.LastMH = v27();
		end
	end, "SWING_DAMAGE");
	v2:RegisterForSelfCombatEvent(function(v97, v97, v97, v97, v97, v97, v97, v97, v97, v97, v97, v97, v97, v97, v97, v98)
		if v98 then
			v42.LastOH = v27();
		else
			v42.LastMH = v27();
		end
	end, "SWING_MISSED");
end
do
	local v44 = v6:CritChancePct();
	local v45 = 0 + 0;
	local function v46()
		if not v6:AffectingCombat() then
			v44 = v6:CritChancePct();
			v2.Debug("Base Crit Set to: " .. v44);
		end
		if ((v45 == nil) or (v45 < (0 - 0))) then
			v45 = 0 - 0;
		else
			v45 = v45 - (860 - (814 + 45));
		end
		if (v45 > (0 - 0)) then
			v20.After(1 + 2, v46);
		end
	end
	v2:RegisterForEvent(function()
		if (v45 == (0 + 0)) then
			v20.After(888 - (261 + 624), v46);
			v45 = 3 - 1;
		end
	end, "PLAYER_EQUIPMENT_CHANGED");
	v19.BaseAttackCrit = function()
		return v44;
	end;
end
