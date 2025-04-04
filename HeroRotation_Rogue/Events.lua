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
	v19.RtBRemains = function(v50)
		local v51 = (v28 - v27()) - v2.RecoveryOffset(v50);
		return ((v51 >= (0 - 0)) and v51) or (0 - 0);
	end;
	v2:RegisterForSelfCombatEvent(function(v52, v52, v52, v52, v52, v52, v52, v52, v52, v52, v52, v53)
		if (v53 == (609035 - 293527)) then
			v28 = v27() + (77 - 47);
		end
	end, "SPELL_AURA_APPLIED");
	v2:RegisterForSelfCombatEvent(function(v54, v54, v54, v54, v54, v54, v54, v54, v54, v54, v54, v55)
		if (v55 == (316127 - (555 + 64))) then
			v28 = v27() + v22(971 - (857 + 74), (598 - (367 + 201)) + v19.RtBRemains(true));
		end
	end, "SPELL_AURA_REFRESH");
	v2:RegisterForSelfCombatEvent(function(v56, v56, v56, v56, v56, v56, v56, v56, v56, v56, v56, v57)
		if (v57 == (316435 - (214 + 713))) then
			v28 = v27();
		end
	end, "SPELL_AURA_REMOVED");
end
do
	local v30 = {CrimsonTempest={},Garrote={},Rupture={}};
	v19.Exsanguinated = function(v58, v59)
		local v60 = v58:GUID();
		if not v60 then
			return false;
		end
		local v61 = v59:ID();
		if (v61 == (30391 + 91020)) then
			return v30.CrimsonTempest[v60] or false;
		elseif (v61 == (111 + 592)) then
			return v30.Garrote[v60] or false;
		elseif (v61 == (2820 - (282 + 595))) then
			return v30.Rupture[v60] or false;
		end
		return false;
	end;
	v19.WillLoseExsanguinate = function(v62, v63)
		if v19.Exsanguinated(v62, v63) then
			return true;
		end
		return false;
	end;
	v19.ExsanguinatedRate = function(v64, v65)
		if v19.Exsanguinated(v64, v65) then
			return 1639 - (1523 + 114);
		end
		return 1 + 0;
	end;
	v2:RegisterForSelfCombatEvent(function(v66, v66, v66, v66, v66, v66, v66, v67, v66, v66, v66, v68)
		if (v68 == (286266 - 85460)) then
			for v113, v114 in v24(v30) do
				for v115, v116 in v24(v114) do
					if (v115 == v67) then
						v114[v115] = true;
					end
				end
			end
		end
	end, "SPELL_CAST_SUCCESS");
	v2:RegisterForSelfCombatEvent(function(v69, v69, v69, v69, v69, v69, v69, v70, v69, v69, v69, v71)
		if (v71 == (122476 - (68 + 997))) then
			v30.CrimsonTempest[v70] = false;
		elseif (v71 == (1973 - (226 + 1044))) then
			v30.Garrote[v70] = false;
		elseif (v71 == (8460 - 6517)) then
			v30.Rupture[v70] = false;
		end
	end, "SPELL_AURA_APPLIED", "SPELL_AURA_REFRESH");
	v2:RegisterForSelfCombatEvent(function(v72, v72, v72, v72, v72, v72, v72, v73, v72, v72, v72, v74)
		if (v74 == (121528 - (32 + 85))) then
			if (v30.CrimsonTempest[v73] ~= nil) then
				v30.CrimsonTempest[v73] = nil;
			end
		elseif (v74 == (689 + 14)) then
			if (v30.Garrote[v73] ~= nil) then
				v30.Garrote[v73] = nil;
			end
		elseif (v74 == (431 + 1512)) then
			if (v30.Rupture[v73] ~= nil) then
				v30.Rupture[v73] = nil;
			end
		end
	end, "SPELL_AURA_REMOVED");
	v2:RegisterForCombatEvent(function(v75, v75, v75, v75, v75, v75, v75, v76)
		if (v30.CrimsonTempest[v76] ~= nil) then
			v30.CrimsonTempest[v76] = nil;
		end
		if (v30.Garrote[v76] ~= nil) then
			v30.Garrote[v76] = nil;
		end
		if (v30.Rupture[v76] ~= nil) then
			v30.Rupture[v76] = nil;
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
	v2:RegisterForSelfCombatEvent(function(v77, v77, v77, v77, v77, v77, v77, v77, v77, v77, v77, v78, v77, v77, v79, v80)
		if (v78 == (136215 + 49548)) then
			if ((v27() - v36) > (0.5 - 0)) then
				v35 = v22(v19.CPMaxSpend(), v6:ComboPoints() + v79 + (v21(0 + 0, v79 - (3 - 2)) * v22(954 - (802 + 150), v6:BuffStack(v34) - (2 - 1))));
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
		local v81 = v6:BuffRemains(v40, nil, true) % (1 + 0);
		if (v27() == v38) then
			return 0 - 0;
		elseif (((v27() - v38) < (1187.1 - (1069 + 118))) and (v81 < (0.25 - 0))) then
			return 1 - 0;
		elseif (((v81 > (0.9 + 0)) or (v81 == (0 - 0))) and ((v27() - v38) > (0.75 + 0))) then
			return 791.1 - (368 + 423);
		end
		return v81;
	end;
	v2:RegisterForSelfCombatEvent(function(v82, v82, v82, v82, v82, v82, v82, v82, v82, v82, v82, v83)
		if (v83 == (668582 - 455839)) then
			v38 = v27();
		elseif (v83 == (197853 - (10 + 8))) then
			v39 = v27();
		end
		if (v39 == v38) then
			v38 = 0 - 0;
		end
	end, "SPELL_CAST_SUCCESS");
end
do
	local v42 = {Counter=(442 - (416 + 26)),LastMH=(0 - 0),LastOH=(0 + 0)};
	v19.TimeToSht = function(v84)
		if (v42.Counter >= v84) then
			return 0 - 0;
		end
		local v85, v86 = v26("player");
		local v87 = v21(v42.LastMH + v85, v27());
		local v88 = v21(v42.LastOH + v86, v27());
		local v89 = {};
		for v103 = 438 - (145 + 293), 432 - (44 + 386) do
			v25(v89, v87 + (v103 * v85));
			v25(v89, v88 + (v103 * v86));
		end
		table.sort(v89);
		local v90 = v22(1491 - (998 + 488), v21(1 + 0, v84 - v42.Counter));
		return v89[v90] - v27();
	end;
	v2:RegisterForSelfCombatEvent(function()
		v42.Counter = 0 + 0;
		v42.LastMH = v27();
		v42.LastOH = v27();
	end, "PLAYER_ENTERING_WORLD");
	v2:RegisterForSelfCombatEvent(function(v94, v94, v94, v94, v94, v94, v94, v94, v94, v94, v94, v95)
		if (v95 == (197683 - (201 + 571))) then
			v42.Counter = 1138 - (116 + 1022);
		end
	end, "SPELL_ENERGIZE");
	v2:RegisterForSelfCombatEvent(function(v96, v96, v96, v96, v96, v96, v96, v96, v96, v96, v96, v96, v96, v96, v96, v96, v96, v96, v96, v96, v96, v96, v96, v97)
		v42.Counter = v42.Counter + (4 - 3);
		if v97 then
			v42.LastOH = v27();
		else
			v42.LastMH = v27();
		end
	end, "SWING_DAMAGE");
	v2:RegisterForSelfCombatEvent(function(v99, v99, v99, v99, v99, v99, v99, v99, v99, v99, v99, v99, v99, v99, v99, v100)
		if v100 then
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
do
	local v48 = 1080 - (1020 + 60);
	v2:RegisterForSelfCombatEvent(function(v101, v101, v101, v101, v101, v101, v101, v101, v101, v101, v101, v102)
		if (v102 == (53113 - (630 + 793))) then
			v48 = 6 - 4;
		end
		if ((v102 == (915299 - 721984)) or (v102 == (3417 + 5259)) or (v102 == (1480587 - 1050564))) then
			if (v48 > (1747 - (760 + 987))) then
				v48 = v48 - (1914 - (1789 + 124));
			end
		end
	end, "SPELL_CAST_SUCCESS");
	v19.DisorientingStrikesCount = function()
		return v48;
	end;
end
