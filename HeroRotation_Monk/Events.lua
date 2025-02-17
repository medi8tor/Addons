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
local v19 = v18.Commons().Monk;
local v20 = C_Timer;
local v21 = table.remove;
local v22 = table.insert;
local v23 = GetTime;
local v24 = 359765 - 244696;
local v25 = 355596 - 231341;
local v26 = {};
local function v27(v33)
	while (#v26 > (0 - 0)) and (v26[#v26][2 - 1] < (v23() - (625 - (555 + 64)))) do
		v21(v26, #v26);
	end
	v22(v26, 932 - (857 + 74), {v23(),v33});
end
v6.IncomingDamageTaken = function(v34, v35)
	local v36 = 0 + 0;
	local v37 = v35 / (158 + 842);
	for v50 = 878 - (282 + 595), #v26 do
		if (v26[v50][1638 - (1523 + 114)] > (v23() - v37)) then
			v36 = v36 + v26[v50][2 + 0];
		end
	end
	return v36;
end;
v2:RegisterForCombatEvent(function(...)
	local v38, v39, v39, v39, v40, v39, v39, v41 = select(11 - 3, ...);
	if ((v3.Persistent.Player.Spec[1066 - (68 + 997)] == (1538 - (226 + 1044))) and (v38 == v6:GUID())) then
		if (v41 and (v41 > (0 - 0)) and (not v40 == v25)) then
			v27(v41);
		end
	end
end, "SWING_DAMAGE", "SPELL_DAMAGE", "SPELL_PERIODIC_DAMAGE");
v2:RegisterForEvent(function()
	if (#v26 > (117 - (32 + 85))) then
		for v54 = 0 + 0, #v26 do
			v26[v54] = nil;
		end
	end
end, "PLAYER_REGEN_ENABLED");
local v29 = v16(71570 + 251170);
local v30 = v16(228248 - (892 + 65));
v19.NiuzaoGUID = 0 - 0;
v19.LastNiuzaoStomp = 0 - 0;
v2:RegisterForCombatEvent(function(...)
	local v42, v43, v43, v43, v44, v43, v43, v43, v45 = select(7 - 3, ...);
	if ((v42 == v6:GUID()) and (v45 == (132928 - (87 + 263)))) then
		v19.NiuzaoGUID = v44;
	end
end, "SPELL_SUMMON");
v2:RegisterForCombatEvent(function(...)
	local v46, v47, v47, v47, v47, v47, v47, v47, v48 = select(184 - (67 + 113), ...);
	if ((v46 == v19.NiuzaoGUID) and (v48 == (166667 + 60624))) then
		v19.LastNiuzaoStomp = v23();
	end
end, "SPELL_DAMAGE");
v2:RegisterForCombatEvent(function(...)
	local v49 = select(19 - 11, ...);
	if (v49 == v19.NiuzaoGUID) then
		v19.NiuzaoGUID = 0 + 0;
	end
end, "UNIT_DIED");
