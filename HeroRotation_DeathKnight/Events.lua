local v0, v1 = ...;
local v2 = HeroLib;
local v3 = HeroCache;
local v4 = v2.Unit;
local v5 = v4.Player;
local v6 = v4.Target;
local v7 = v2.Spell;
local v8 = v2.Item;
local v9 = GetTime;
local v10 = {(122057 - 79407),(141906 - 86816),(208242 - (857 + 74)),(44192 - (214 + 713)),(23950 + 128330),(79212 - (1523 + 114)),(165352 - 49363),(46794 - (226 + 1044)),(3831 - (32 + 85)),(76128 + 267166),(266399 - 154726)};
local v11 = HeroRotation();
v11.Commons().DeathKnight = {};
local v13 = v11.GUISettingsGet();
local v14 = v11.Commons().DeathKnight;
v14.GhoulTable = {AbominationExpiration=(0 - 0),ApocMagusExpiration=(0 - 0),ArmyMagusExpiration=(350 - (87 + 263)),GargoyleExpiration=(180 - (67 + 113)),SummonExpiration=(0 + 0),SummonedAbomination=nil,SummonedGargoyle=nil,SummonedGhoul=nil};
v14.DnDTable = {};
v14.BonestormTable = {};
v2:RegisterForSelfCombatEvent(function(v29, v29, v29, v29, v29, v29, v29, v30, v29, v29, v29, v31)
	if (v31 == (114373 - 67788)) then
		v14.GhoulTable.SummonedGhoul = v30;
		v14.GhoulTable.SummonExpiration = v9() + 45 + 15;
	end
	if ((v31 == (195568 - 146362)) or (v31 == (208301 - (802 + 150)))) then
		v14.GhoulTable.SummonedGargoyle = v30;
		v14.GhoulTable.GargoyleExpiration = v9() + (67 - 42);
	end
	if (v31 == (826069 - 370674)) then
		v14.GhoulTable.SummonedAbomination = v30;
		v14.GhoulTable.AbominationExpiration = v9() + 22 + 8;
	end
end, "SPELL_SUMMON");
v2:RegisterForSelfCombatEvent(function(v32, v32, v32, v32, v32, v32, v32, v32, v32, v32, v32, v33)
	if (v33 == (328571 - (915 + 82))) then
		v14.GhoulTable.SummonedGhoul = nil;
		v14.GhoulTable.SummonExpiration = 0 - 0;
	end
	if (v5:HasTier(19 + 12, 4 - 0) and ((v14.GhoulTable.ApocMagusExpiration > (1187 - (1069 + 118))) or (v14.GhoulTable.ArmyMagusExpiration > (0 - 0)))) then
		if (v33 == (188008 - 102060)) then
			if v14.GhoulTable:ApocMagusActive() then
				v14.GhoulTable.ApocMagusExpiration = v14.GhoulTable.ApocMagusExpiration + 1 + 0;
			end
			if v14.GhoulTable:ArmyMagusActive() then
				v14.GhoulTable.ArmyMagusExpiration = v14.GhoulTable.ArmyMagusExpiration + (1 - 0);
			end
		end
		for v69, v70 in pairs(v10) do
			if (v70 == v33) then
				if v14.GhoulTable:ApocMagusActive() then
					v14.GhoulTable.ApocMagusExpiration = v14.GhoulTable.ApocMagusExpiration + 0.5 + 0;
				end
				if v14.GhoulTable:ArmyMagusActive() then
					v14.GhoulTable.ArmyMagusExpiration = v14.GhoulTable.ArmyMagusExpiration + (791.5 - (368 + 423));
				end
			end
		end
	end
	if (v5:HasTier(97 - 66, 20 - (10 + 8)) and (v33 == (1060540 - 784841))) then
		v14.GhoulTable.ApocMagusExpiration = v9() + (462 - (416 + 26));
	end
	if (v5:HasTier(98 - 67, 1 + 1) and (v33 == (75466 - 32816))) then
		v14.GhoulTable.ArmyMagusExpiration = v9() + (468 - (145 + 293));
	end
end, "SPELL_CAST_SUCCESS");
v2:RegisterForCombatEvent(function(v34, v34, v34, v34, v34, v34, v34, v35)
	if (v35 == v14.GhoulTable.SummonedGhoul) then
		v14.GhoulTable.SummonedGhoul = nil;
		v14.GhoulTable.SummonExpiration = 430 - (44 + 386);
	end
	if (v35 == v14.GhoulTable.SummonedGargoyle) then
		v14.GhoulTable.SummonedGargoyle = nil;
		v14.GhoulTable.GargoyleExpiration = 1486 - (998 + 488);
	end
	if (v35 == v14.GhoulTable.SummonedAbomination) then
		v14.GhoulTable.SummonedAbomination = nil;
		v14.GhoulTable.AbominationExpiration = 0 + 0;
	end
end, "UNIT_DESTROYED");
v14.GhoulTable.AbomRemains = function(v36)
	if (v14.GhoulTable.AbominationExpiration == (0 + 0)) then
		return 772 - (201 + 571);
	end
	return v14.GhoulTable.AbominationExpiration - v9();
end;
v14.GhoulTable.AbomActive = function(v37)
	return (v14.GhoulTable.SummonedAbomination ~= nil) and (v14.GhoulTable:AbomRemains() > (1138 - (116 + 1022)));
end;
v14.GhoulTable.ApocMagusRemains = function(v38)
	return v14.GhoulTable.ApocMagusExpiration - v9();
end;
v14.GhoulTable.ApocMagusActive = function(v39)
	return v14.GhoulTable.ApocMagusRemains() > (0 - 0);
end;
v14.GhoulTable.ArmyMagusRemains = function(v40)
	return v14.GhoulTable.ArmyMagusExpiration - v9();
end;
v14.GhoulTable.ArmyMagusActive = function(v41)
	return v14.GhoulTable:ArmyMagusRemains() > (0 + 0);
end;
v14.GhoulTable.GargRemains = function(v42)
	if (v14.GhoulTable.GargoyleExpiration == (0 - 0)) then
		return 0 - 0;
	end
	return v14.GhoulTable.GargoyleExpiration - v9();
end;
v14.GhoulTable.GargActive = function(v43)
	return (v14.GhoulTable.SummonedGargoyle ~= nil) and (v14.GhoulTable:GargRemains() > (859 - (814 + 45)));
end;
v14.GhoulTable.GhoulRemains = function(v44)
	if (v14.GhoulTable.SummonExpiration == (0 - 0)) then
		return 0 + 0;
	end
	return v14.GhoulTable.SummonExpiration - v9();
end;
v14.GhoulTable.GhoulActive = function(v45)
	return (v14.GhoulTable.SummonedGhoul ~= nil) and (v14.GhoulTable:GhoulRemains() > (0 + 0));
end;
v2.DnDTable = {};
v2:RegisterForCombatEvent(function(v46, v46, v46, v47, v46, v46, v46, v48, v46, v46, v46, v49)
	if (v47 == v5:GUID()) then
		if (v49 == (53097 - (261 + 624))) then
			v14.DnDTable[v48] = v9();
		elseif (v49 == (277227 - 121227)) then
			v14.DnDTable[v48] = v9();
		elseif (v49 == (197608 - (1020 + 60))) then
			v14.BonestormTable[v48] = v9();
		end
	end
end, "SPELL_DAMAGE");
v2:RegisterForCombatEvent(function(v50, v50, v50, v50, v50, v50, v50, v51)
	if v2.DnDTable[v51] then
		v2.DnDTable[v51] = nil;
	end
end, "UNIT_DIED", "UNIT_DESTROYED");
