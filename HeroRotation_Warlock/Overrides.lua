local v0 = HeroLib;
local v1 = HeroCache;
local v2 = v0.Unit;
local v3 = v2.Player;
local v4 = v2.Pet;
local v5 = v2.Target;
local v6 = v0.Spell;
local v7 = v0.Item;
local v8 = HeroRotation();
local v9 = v8.Commons().Warlock;
local v10 = v8.Commons().Everyone;
local v11 = v6.Warlock.Affliction;
local v12 = v6.Warlock.Demonology;
local v13 = v6.Warlock.Destruction;
local v14 = math.min;
local v15 = math.max;
local v16 = math.floor;
local v17 = GetTime;
local v18 = v8.GUISettingsGet();
local v19 = {Commons=v18.APL.Warlock.Commons};
v0.AddCoreOverride("Player.SoulShardsP", function()
	local v30 = v3:SoulShards();
	if not v3:IsCasting() then
		return v30;
	elseif (v3:IsCasting(v11.MaleficRapture) or v3:IsCasting(v11.SeedofCorruption) or v3:IsCasting(v11.VileTaint) or v3:IsCasting(v11.SummonImp) or v3:IsCasting(v11.SummonVoidwalker) or v3:IsCasting(v11.SummonFelhunter) or v3:IsCasting(v11.SummonSayaad)) then
		return v30 - (2 - 1);
	else
		return v30;
	end
end, 758 - 493);
local v20;
v20 = v0.AddCoreOverride("Spell.IsCastable", function(v31, v32, v33, v34, v35, v36)
	local v37 = true;
	if v33 then
		local v97 = v35 or v5;
		v37 = v97:IsInRange(v33, v34);
	end
	local v38 = v20(v31, v32, v33, v34, v35, v36) and v10.ShouldStopCast(v31);
	if ((v31 == v11.SummonImp) or (v31 == v11.SummonVoidwalker) or (v31 == v11.SummonFelhunter) or (v31 == v11.SummonSayaad)) then
		return v38 and not v19.Commons.HidePetSummon and (v3:SoulShardsP() > (0 - 0)) and not v3:IsCasting(v31);
	elseif (v31 == v11.GrimoireofSacrifice) then
		return v38 and v3:BuffDown(v11.GrimoireofSacrificeBuff);
	else
		return v38;
	end
end, 682 - 417);
local v21;
v21 = v0.AddCoreOverride("Spell.IsReady", function(v39, v40, v41, v42, v43, v44)
	local v45 = true;
	if v40 then
		local v98 = v42 or v5;
		v45 = v98:IsInRange(v40, v41);
	end
	local v46 = v21(v39, v40, v41, v42, v43, v44) and v10.ShouldStopCast(v39);
	if ((v39 == v11.VileTaint) or (v39 == v11.SoulRot)) then
		return v46 and not v3:IsCasting(v39);
	elseif (v39 == v11.UnstableAffliction) then
		local v105 = v11.UnstableAfflictionDebuff:AuraActiveUnits()[620 - (555 + 64)];
		local v106 = 931 - (857 + 74);
		local v107 = (v11.CreepingDeath:IsAvailable() and (573.4 - (367 + 201))) or (933.3 - (214 + 713));
		if v105 then
			v106 = v105:DebuffRemains(v11.UnstableAfflictionDebuff);
		end
		return v46 and (v106 < v107) and not v3:IsCasting(v39);
	elseif ((v39 == v11.SeedofCorruption) or (v39 == v11.Haunt)) then
		return v46 and not v3:IsCasting(v39) and not v39:InFlight();
	elseif (v39 == v11.MaleficRapture) then
		return v46 and (v3:SoulShardsP() > (0 + 0)) and (v5:DebuffUp(v11.CorruptionDebuff) or v5:DebuffUp(v11.WitherDebuff) or v5:DebuffUp(v11.AgonyDebuff) or v5:DebuffUp(v11.UnstableAfflictionDebuff) or v5:DebuffUp(v11.SiphonLifeDebuff) or v5:DebuffUp(v11.HauntDebuff) or v5:DebuffUp(v11.SoulRotDebuff) or v5:DebuffUp(v11.VileTaintDebuff));
	else
		return v46;
	end
end, 42 + 223);
local v22;
v22 = v0.AddCoreOverride("Player.BuffUp", function(v47, v48, v49, v50)
	local v51 = v22(v47, v48, v49, v50);
	if (v48 == v11.SoulRot) then
		return v9.SoulRotBuffUp;
	else
		return v51;
	end
end, 1142 - (282 + 595));
local v23;
v23 = v0.AddCoreOverride("Player.BuffRemains", function(v52, v53, v54, v55)
	local v56 = v23(v52, v53, v54, v55);
	if (v53 == v11.SoulRot) then
		if not v9.SoulRotBuffUp then
			return 1637 - (1523 + 114);
		end
		local v99 = 8 + 0;
		local v100 = v99 - (v17() - v9.SoulRotAppliedTime);
		return ((v100 > (0 - 0)) and v100) or (1065 - (68 + 997));
	else
		return v56;
	end
end, 1535 - (226 + 1044));
local v24;
v24 = v0.AddCoreOverride("Target.DebuffUp", function(v57, v58, v59, v60)
	local v61 = v24(v57, v58, v59, v60);
	if (v58 == v11.UnstableAfflictionDebuff) then
		return v61 or v3:IsCasting(v11.UnstableAffliction);
	elseif (v58 == v11.HauntDebuff) then
		return v61 or v3:IsCasting(v11.Haunt);
	elseif (v58 == v11.VileTaintDebuff) then
		return v61 or v3:IsCasting(v11.VileTaint);
	elseif (v58 == v11.SoulRotDebuff) then
		return v61 or v3:IsCasting(v11.SoulRot);
	else
		return v61;
	end
end, 1153 - 888);
v0.AddCoreOverride("Player.SoulShardsP", function()
	local v62 = v3:SoulShards();
	v62 = v16(v62);
	if not v3:IsCasting() then
		return v62;
	elseif (v3:IsCasting(v12.SummonDemonicTyrant) and v12.SoulboundTyrant:IsAvailable()) then
		return v14(v62 + (120 - (32 + 85)), 5 + 0);
	elseif v3:IsCasting(v12.Demonbolt) then
		return v14(v62 + 1 + 1, 962 - (892 + 65));
	elseif (v3:IsCasting(v12.ShadowBolt) or v3:IsCasting(v12.SoulStrike)) then
		return v14(v62 + (2 - 1), 9 - 4);
	elseif v3:IsCasting(v12.HandofGuldan) then
		return v15(v62 - (4 - 1), 350 - (87 + 263));
	elseif v3:IsCasting(v12.CallDreadstalkers) then
		return v62 - (182 - (67 + 113));
	elseif (v3:IsCasting(v12.SummonVilefiend) or v3:IsCasting(v12.SummonImp) or v3:IsCasting(v12.SummonVoidwalker) or v3:IsCasting(v12.SummonFelhunter) or v3:IsCasting(v12.SummonSayaad) or v3:IsCasting(v12.SummonFelguard) or v3:IsCasting(v12.NetherPortal)) then
		return v62 - (1 + 0);
	else
		return v62;
	end
end, 652 - 386);
local v25;
v25 = v0.AddCoreOverride("Spell.IsCastable", function(v63, v64, v65, v66, v67, v68)
	local v69 = true;
	if v65 then
		local v101 = v67 or v5;
		v69 = v101:IsInRange(v65, v66);
	end
	local v70 = v25(v63, v64, v65, v66, v67, v68) and v10.ShouldStopCast(v63);
	if ((v63 == v12.SummonImp) or (v63 == v12.SummonVoidwalker) or (v63 == v12.SummonFelhunter) or (v63 == v12.SummonSayaad) or (v63 == v12.SummonFelguard)) then
		return v70 and not v19.Commons.HidePetSummon and (v3:SoulShardsP() > (0 + 0)) and not v3:IsCasting(v63);
	elseif (v63 == v12.SummonDemonicTyrant) then
		return v70 and not v3:IsCasting(v63);
	else
		return v70;
	end
end, 1057 - 791);
local v26;
v26 = v0.AddCoreOverride("Spell.IsReady", function(v71, v72, v73, v74, v75, v76)
	local v77 = true;
	if v72 then
		local v102 = v74 or v5;
		v77 = v102:IsInRange(v72, v73);
	end
	local v78 = v26(v71, v72, v73, v74, v75, v76) and v10.ShouldStopCast(v71);
	if ((v71 == v12.SummonVilefiend) or (v71 == v12.SummonCharhound) or (v71 == v12.SummonGloomhound) or v12.GrimoireFelguard) then
		return v78 and (v3:SoulShardsP() >= (953 - (802 + 150))) and not v3:IsCasting(v71);
	elseif (v71 == v12.CallDreadstalkers) then
		return v78 and ((v3:SoulShardsP() >= (5 - 3)) or v3:BuffUp(v12.DemonicCallingBuff)) and not v3:IsCasting(v71);
	elseif (v71 == v12.SummonSoulkeeper) then
		return v78 and not v3:IsCasting(v71);
	elseif (v71 == v12.HandofGuldan) then
		return v78 and (v3:SoulShardsP() >= (1 - 0));
	elseif (v71 == v12.PowerSiphon) then
		return v78 and (v0.GuardiansTable.ImpCount > (0 + 0));
	else
		return v78;
	end
end, 1263 - (915 + 82));
v0.AddCoreOverride("Player.SoulShardsP", function()
	local v79 = v3:SoulShards();
	if not v3:IsCasting() then
		return v79;
	elseif (v3:IsCasting(v13.ChaosBolt) or (v3:IsCasting(v13.RainofFire) and v13.Inferno:IsAvailable())) then
		return v79 - (5 - 3);
	elseif (v3:IsCasting(v13.RainofFire) and not v13.Inferno:IsAvailable()) then
		return v79 - (2 + 1);
	elseif (v3:IsCasting(v13.SummonImp) or v3:IsCasting(v13.SummonVoidwalker) or v3:IsCasting(v13.SummonFelhunter) or v3:IsCasting(v13.SummonSayaad)) then
		return v79 - (1 - 0);
	elseif v3:IsCasting(v13.Incinerate) then
		return v14(v79 + (1187.2 - (1069 + 118)), 10 - 5);
	elseif v3:IsCasting(v13.Conflagrate) then
		return v14(v79 + (0.5 - 0), 1 + 4);
	elseif v3:IsCasting(v13.SoulFire) then
		return v14(v79 + (1 - 0), 5 + 0);
	else
		return v79;
	end
end, 1058 - (368 + 423));
local v27;
v27 = v0.AddCoreOverride("Spell.IsCastable", function(v80, v81, v82, v83, v84, v85)
	local v86 = true;
	if v82 then
		local v103 = v84 or v5;
		v86 = v103:IsInRange(v82, v83);
	end
	local v87 = v27(v80, v81, v82, v83, v84, v85) and v10.ShouldStopCast(v80);
	if ((v80 == v13.SummonImp) or (v80 == v13.SummonVoidwalker) or (v80 == v13.SummonFelhunter) or (v80 == v13.SummonSayaad)) then
		return v87 and not v19.Commons.HidePetSummon and (v3:SoulShardsP() > (0 - 0)) and not v3:IsCasting(v80);
	elseif ((v80 == v13.Immolate) or (v80 == v13.Cataclysm) or (v80 == v13.SoulRot) or (v80 == v13.SummonSoulkeeper)) then
		return v87 and not v3:IsCasting(v80);
	else
		return v87;
	end
end, 285 - (10 + 8));
local v28;
v28 = v0.AddCoreOverride("Spell.IsReady", function(v88, v89, v90, v91, v92, v93)
	local v94 = true;
	if v89 then
		local v104 = v91 or v5;
		v94 = v104:IsInRange(v89, v90);
	end
	local v95 = v28(v88, v89, v90, v91, v92, v93) and v10.ShouldStopCast(v88);
	if (v88 == v13.GrimoireofSacrifice) then
		return v95 and v3:BuffDown(v13.GrimoireofSacrificeBuff);
	elseif (v88 == v13.ChannelDemonfire) then
		return v95 and not v3:IsCasting(v88);
	else
		return v95;
	end
end, 1027 - 760);
local v29;
v29 = v0.AddCoreOverride("Player.AffectingCombat", function(v96)
	return v13.Incinerate:InFlight() or v3:IsCasting(v13.SoulFire) or v29(v96);
end, 709 - (416 + 26));
