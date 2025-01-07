local v0, v1 = ...;
local v2 = HeroLib;
local v3 = HeroRotation();
local v4 = HeroCache;
local v5 = v2.Unit;
local v6 = v5.Player;
local v7 = v5.Target;
local v8 = v2.Spell;
local v9 = v2.Item;
local v10 = string.find;
local v11 = GetTime;
local v12 = select;
local v13 = UnitGUID;
v3.Commons().Warlock = {};
local v15 = v3.Commons().Warlock;
v15.GuardiansTable = {Pets={},ImpCount=(0 - 0),FelguardDuration=(0 - 0),DreadstalkerDuration=(0 - 0),DemonicTyrantDuration=(0 - 0),VilefiendDuration=(619 - (555 + 64)),PitLordDuration=(931 - (857 + 74)),InfernalDuration=(568 - (367 + 201)),OverfiendDuration=(927 - (214 + 713)),BlasphemyDuration=(0 + 0),DarkglareDuration=(0 + 0),InnerDemonsNextCast=(877 - (282 + 595)),ImpsSpawnedFromHoG=(1637 - (1523 + 114))};
local v17 = {[88101 + 9934]={name="Dreadstalker",duration=(16.25 - 4)},[56724 - (68 + 997)]={name="Wild Imp",duration=(1290 - (226 + 1044))},[625388 - 481766]={name="Wild Imp",duration=(137 - (32 + 85))},[16908 + 344]={name="Felguard",duration=(4 + 13)},[135959 - (892 + 65)]={name="Demonic Tyrant",duration=(35 - 20)},[251046 - 115230]={name="Vilefiend",duration=(27 - 12)},[196461 - (87 + 263)]={name="Pit Lord",duration=(190 - (67 + 113))},[66 + 23]={name="Infernal",duration=(73 - 43)},[136489 + 49095]={name="Blasphemy",duration=(31 - 23)},[104625 - (802 + 150)]={name="Darkglare",duration=(67 - 42)},[414069 - 185801]={name="Vilefiend",duration=(11 + 4)},[227266 - (915 + 82)]={name="Vilefiend",duration=(42 - 27)},[126663 + 90766]={name="Overfiend",duration=(9 - 1)}};
v15.UpdatePetTable = function()
	for v33, v34 in pairs(v15.GuardiansTable.Pets) do
		if v34 then
			if (v11() >= v34.despawnTime) then
				if (v34.name == "Wild Imp") then
					v15.GuardiansTable.ImpCount = v15.GuardiansTable.ImpCount - (1188 - (1069 + 118));
				end
				if (v34.name == "Felguard") then
					v15.GuardiansTable.FelguardDuration = 0 - 0;
				elseif (v34.name == "Dreadstalker") then
					v15.GuardiansTable.DreadstalkerDuration = 0 - 0;
				elseif (v34.name == "Demonic Tyrant") then
					v15.GuardiansTable.DemonicTyrantDuration = 0 + 0;
				elseif (v34.name == "Vilefiend") then
					v15.GuardiansTable.VilefiendDuration = 0 - 0;
				elseif (v34.name == "Pit Lord") then
					v15.GuardiansTable.PitLordDuration = 0 + 0;
				elseif (v34.name == "Infernal") then
					v15.GuardiansTable.InfernalDuration = 791 - (368 + 423);
				elseif (v34.name == "Blasphemy") then
					v15.GuardiansTable.BlasphemyDuration = 0 - 0;
				elseif (v34.name == "Overfiend") then
					v15.GuardiansTable.OverfiendDuration = 18 - (10 + 8);
				elseif (v34.name == "Darkglare") then
					v15.GuardiansTable.DarkglareDuration = 0 - 0;
				end
				v15.GuardiansTable.Pets[v33] = nil;
			end
		end
		if (v34.ImpCasts <= (442 - (416 + 26))) then
			v15.GuardiansTable.ImpCount = v15.GuardiansTable.ImpCount - (3 - 2);
			v15.GuardiansTable.Pets[v33] = nil;
		end
		if (v11() <= v34.despawnTime) then
			v34.Duration = v34.despawnTime - v11();
			if (v34.name == "Felguard") then
				v15.GuardiansTable.FelguardDuration = v34.Duration;
			elseif (v34.name == "Dreadstalker") then
				v15.GuardiansTable.DreadstalkerDuration = v34.Duration;
			elseif (v34.name == "Demonic Tyrant") then
				v15.GuardiansTable.DemonicTyrantDuration = v34.Duration;
			elseif (v34.name == "Vilefiend") then
				v15.GuardiansTable.VilefiendDuration = v34.Duration;
			elseif (v34.name == "Pit Lord") then
				v15.GuardiansTable.PitLordDuration = v34.Duration;
			elseif (v34.name == "Infernal") then
				v15.GuardiansTable.InfernalDuration = v34.Duration;
			elseif (v34.name == "Blasphy") then
				v15.GuardiansTable.BlasphemyDuration = v34.Duration;
			elseif (v34.name == "Overfiend") then
				v15.GuardiansTable.OverfiendDuration = v34.Duration;
			elseif (v34.name == "Darkglare") then
				v15.GuardiansTable.DarkglareDuration = v34.Duration;
			end
		end
	end
end;
v2:RegisterForSelfCombatEvent(function(...)
	local v19, v20, v21, v22, v21, v21, v21, v23, v21, v21, v21, v24 = v12(1 + 0, ...);
	local v21, v21, v21, v21, v21, v21, v21, v25 = v10(v23, "(%S+)-(%d+)-(%d+)-(%d+)-(%d+)-(%d+)-(%S+)");
	v25 = tonumber(v25);
	if ((v23 ~= v13("pet")) and (v20 == "SPELL_SUMMON") and v17[v25]) then
		local v35 = v17[v25];
		local v36;
		if (v35.name == "Wild Imp") then
			v15.GuardiansTable.ImpCount = v15.GuardiansTable.ImpCount + (1 - 0);
			v36 = v35.duration;
		elseif (v35.name == "Felguard") then
			v15.GuardiansTable.FelguardDuration = v35.duration;
			v36 = v35.duration;
		elseif (v35.name == "Dreadstalker") then
			v15.GuardiansTable.DreadstalkerDuration = v35.duration;
			v36 = v35.duration;
		elseif (v35.name == "Demonic Tyrant") then
			if (v24 == (265625 - (145 + 293))) then
				v15.GuardiansTable.DemonicTyrantDuration = v35.duration;
				v36 = v35.duration;
			end
		elseif (v35.name == "Vilefiend") then
			v15.GuardiansTable.VilefiendDuration = v35.duration;
			v36 = v35.duration;
		elseif (v35.name == "Pit Lord") then
			v15.GuardiansTable.PitLordDuration = v35.duration;
			v36 = v35.duration;
		elseif (v35.name == "Infernal") then
			v15.GuardiansTable.InfernalDuration = v35.duration;
			v36 = v35.duration;
		elseif (v35.name == "Blasphemy") then
			v15.GuardiansTable.BlasphemyDuration = v35.duration;
			v36 = v35.duration;
		elseif (v35.name == "Overfiend") then
			v15.GuardiansTable.OverfiendDuration = v35.duration;
			v36 = v35.duration;
		elseif (v35.name == "Darkglare") then
			v15.GuardiansTable.DarkglareDuration = v35.duration;
			v36 = v35.duration;
		end
		local v37 = {ID=v23,name=v35.name,spawnTime=v11(),ImpCasts=(435 - (44 + 386)),Duration=v36,despawnTime=(v11() + tonumber(v36))};
		table.insert(v15.GuardiansTable.Pets, v37);
	end
	if (v17[v25] and (v17[v25].name == "Demonic Tyrant")) then
		for v45, v46 in pairs(v15.GuardiansTable.Pets) do
			if (v46 and (v46.name ~= "Demonic Tyrant") and (v46.name ~= "Pit Lord")) then
				v46.despawnTime = v46.despawnTime + (1501 - (998 + 488));
				v46.ImpCasts = v46.ImpCasts + 3 + 4;
			end
		end
	end
	if (v25 == (117601 + 26021)) then
		v15.GuardiansTable.InnerDemonsNextCast = v11() + (784 - (201 + 571));
	end
	if ((v25 == (56797 - (116 + 1022))) and (v15.GuardiansTable.ImpsSpawnedFromHoG > (0 - 0))) then
		v15.GuardiansTable.ImpsSpawnedFromHoG = v15.GuardiansTable.ImpsSpawnedFromHoG - (1 + 0);
	end
	v15.UpdatePetTable();
end, "SPELL_SUMMON", "SPELL_CAST_SUCCESS");
v2:RegisterForCombatEvent(function(...)
	local v26, v27, v27, v27, v28, v27, v27, v27, v29 = v12(14 - 10, ...);
	if (v29 == (370442 - 266124)) then
		for v47, v48 in pairs(v15.GuardiansTable.Pets) do
			if (v26 == v48.ID) then
				v48.ImpCasts = v48.ImpCasts - (860 - (814 + 45));
			end
		end
	end
	if ((v26 == v6:GUID()) and (v29 == (483619 - 287342))) then
		for v49, v50 in pairs(v15.GuardiansTable.Pets) do
			if (v50.name == "Wild Imp") then
				v15.GuardiansTable.Pets[v49] = nil;
			end
		end
		v15.GuardiansTable.ImpCount = 0 + 0;
	end
	v15.UpdatePetTable();
end, "SPELL_CAST_SUCCESS");
v2:RegisterForSelfCombatEvent(function(v30, v31, v30, v30, v30, v30, v30, v30, v30, v30, v30, v32)
	if (v32 == (37162 + 68012)) then
		v15.GuardiansTable.ImpsSpawnedFromHoG = v15.GuardiansTable.ImpsSpawnedFromHoG + (((v6:SoulShards() >= (888 - (261 + 624))) and (4 - 1)) or v6:SoulShards());
	end
end, "SPELL_CAST_SUCCESS");
