local v0 = HeroLib;
local v1 = HeroCache;
local v2 = v0.Unit;
local v3 = v2.Player;
local v4 = v2.Pet;
local v5 = v2.Target;
local v6 = v0.Spell;
local v7 = v0.Item;
local v8 = HeroRotation();
local v9 = v6.Hunter.BeastMastery;
local v10 = v6.Hunter.Marksmanship;
local v11 = v6.Hunter.Survival;
local v12 = v8.GUISettingsGet().APL.Hunter;
local v13 = v8.Commons().Hunter;
local v14 = math.max;
local v15 = GetTime;
local v16;
v16 = v0.AddCoreOverride("Spell.IsCastable", function(v24, v25, v26, v27, v28, v29)
	local v30 = v16(v24, v25, v26, v27, v28, v29);
	if (v24 == v9.SummonPet) then
		return ((v13.Pet.Status == (0 - 0)) or (v13.Pet.Status == (8 - 5)) or ((v13.Pet.Status == (1 - 0)) and (v4:HealthPercentage() <= (0 - 0)))) and v30;
	elseif (v24 == v9.RevivePet) then
		return (v4:IsDeadOrGhost() or ((v13.Pet.Status == (621 - (555 + 64))) and (v13.Pet.FeignGUID == (931 - (857 + 74))))) and v30;
	elseif (v24 == v9.MendPet) then
		return (v4:HealthPercentage() > (568 - (367 + 201))) and (v4:HealthPercentage() <= v12.BMPet.MendPetHP) and v30;
	else
		return v30;
	end
end, 1180 - (214 + 713));
local v17;
v17 = v0.AddCoreOverride("Pet.BuffRemains", function(v31, v32, v33, v34)
	local v35 = v17(v31, v32, v33, v34);
	if (v32 == v9.FrenzyBuff) then
		if v3:IsPrevCastPending() then
			return v35 + (v15() - v3:GCDStartTime());
		end
	elseif (v32 == v9.BeastCleaveBuff) then
		v35 = v14(v35, v3:BuffRemains(v9.BeastCleavePlayerBuff));
		if v3:IsPrevCastPending() then
			return v35 + (v15() - v3:GCDStartTime());
		end
	end
	return v35;
end, 64 + 189);
local v18;
v18 = v0.AddCoreOverride("Spell.IsCastable", function(v36, v37, v38, v39, v40, v41)
	local v42 = v18(v36, v37, v38, v39, v40, v41);
	if (v36 == v10.SummonPet) then
		return ((v13.Pet.Status == (0 + 0)) or (v13.Pet.Status == (880 - (282 + 595))) or ((v13.Pet.Status == (1638 - (1523 + 114))) and (v4:HealthPercentage() <= (0 + 0)))) and v42;
	elseif (v36 == v10.RevivePet) then
		return (v4:IsDeadOrGhost() or ((v13.Pet.Status == (2 - 0)) and (v13.Pet.FeignGUID == (1065 - (68 + 997))))) and v42;
	elseif (v36 == v10.MendPet) then
		return (v4:HealthPercentage() > (1270 - (226 + 1044))) and (v4:HealthPercentage() <= v12.MMPet.MendPetHP) and v42;
	else
		return v42;
	end
end, 1105 - 851);
local v19;
v19 = v0.AddCoreOverride("Spell.IsReady", function(v43, v44, v45, v46, v47, v48)
	local v49 = v19(v43, v44, v45, v46, v47, v48);
	if (v43 == v10.AimedShot) then
		local v72 = (not v3:IsCasting(v10.AimedShot) and (v10.AimedShot:Charges() == (118 - (32 + 85)))) or (v10.AimedShot:Charges() > (1 + 0));
		if true then
			return v49 and v72 and (not v3:IsMoving() or v3:BuffUp(v10.LockandLoadBuff));
		end
	elseif (v43 == v10.WailingArrow) then
		return v49 and not v3:IsCasting(v43);
	else
		return v49;
	end
end, 57 + 197);
local v20;
v20 = v0.AddCoreOverride("Player.BuffRemains", function(v50, v51, v52, v53)
	if ((v51 == v10.TrickShotsBuff) and (v3:IsCasting(v10.AimedShot) or v3:IsChanneling(v10.RapidFire))) then
		return 957 - (892 + 65);
	else
		return v20(v50, v51, v52, v53);
	end
end, 605 - 351);
local v21;
v21 = v0.AddCoreOverride("Player.BuffDown", function(v54, v55, v56, v57)
	if ((v55 == v10.PreciseShotsBuff) and v3:IsCasting(v10.AimedShot)) then
		return false;
	else
		return v21(v54, v55, v56, v57);
	end
end, 469 - 215);
v0.AddCoreOverride("Player.FocusP", function()
	local v58 = v3:Focus() + v3:FocusRemainingCastRegen();
	if not v3:IsCasting() then
		return v58;
	elseif v3:IsCasting(v10.SteadyShot) then
		return v58 + (18 - 8);
	elseif v3:IsChanneling(v10.RapidFire) then
		return v58 + (357 - (87 + 263));
	elseif v3:IsCasting(v10.WailingArrow) then
		return v58 - (195 - (67 + 113));
	elseif v3:IsCasting(v10.AimedShot) then
		return v58 - (26 + 9);
	end
end, 623 - 369);
local v22;
v22 = v0.AddCoreOverride("Spell.IsCastable", function(v59, v60, v61, v62, v63, v64)
	local v65 = v22(v59, v60, v61, v62, v63, v64);
	if (v59 == v11.SummonPet) then
		return ((v13.Pet.Status == (0 + 0)) or (v13.Pet.Status == (11 - 8)) or ((v13.Pet.Status == (953 - (802 + 150))) and (v4:HealthPercentage() <= (0 - 0)))) and v65;
	elseif (v59 == v11.RevivePet) then
		return (v4:IsDeadOrGhost() or ((v13.Pet.Status == (3 - 1)) and (v13.Pet.FeignGUID == (0 + 0)))) and v65;
	elseif (v59 == v11.MendPet) then
		return (v4:HealthPercentage() > (997 - (915 + 82))) and (v4:HealthPercentage() <= v12.SVPet.MendPetHP) and v65;
	elseif (v59 == v11.AspectoftheEagle) then
		return v12.Survival.AspectoftheEagle and v65;
	elseif (v59 == v11.Harpoon) then
		return v65 and not v5:IsInRange(22 - 14);
	else
		return v65;
	end
end, 149 + 106);
local v23;
v23 = v0.AddCoreOverride("Spell.IsReady", function(v66, v67, v68, v69, v70, v71)
	if ((v66 == v11.MongooseBite) or (v66 == v11.RaptorStrike)) then
		return v23(v66, "Melee", v68, v69, v70, v71);
	else
		local v73 = v23(v66, v67, v68, v69, v70, v71);
		if (v66 == v11.Butchery) then
			return v73 and (v3:BuffDown(v11.AspectoftheEagle) or (v3:BuffUp(v11.AspectoftheEagle) and v5:IsInMeleeRange(9 - 1)));
		else
			return v73;
		end
	end
end, 1442 - (1069 + 118));
