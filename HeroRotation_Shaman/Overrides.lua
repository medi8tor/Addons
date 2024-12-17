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
local v10 = v6.Shaman.Elemental;
local v11 = v6.Shaman.Enhancement;
local v12 = v8.Commons().Shaman;
v0.AddCoreOverride("Player.MaelstromP", function()
	local v14 = v3:Maelstrom();
	if not v3:IsCasting() then
		return v14;
	elseif v3:IsCasting(v10.ElementalBlast) then
		return v14 - (281 - 191);
	elseif v3:IsCasting(v10.Icefury) then
		return v14 + (28 - 18);
	elseif v3:IsCasting(v10.LightningBolt) then
		return v14 + (10 - 4);
	elseif v3:IsCasting(v10.LavaBurst) then
		return v14 + (20 - 12);
	elseif v3:IsCasting(v10.ChainLightning) then
		return v14 + ((621 - (555 + 64)) * v12.ClusterTargets);
	else
		return v14;
	end
end, 1193 - (857 + 74));
v0.AddCoreOverride("Spell.IsViable", function(v15)
	local v16 = v15:IsReady() and v9.ShouldStopCast(v15);
	local v17 = v10;
	if ((v15 == v17.Stormkeeper) or (v15 == v17.ElementalBlast) or (v15 == v17.Icefury)) then
		local v30 = v3:BuffUp(v17.SpiritwalkersGraceBuff) or not v3:IsMoving();
		return v16 and v30 and not v3:IsCasting(v15);
	elseif (v15 == v17.LavaBeam) then
		local v32 = v3:BuffUp(v17.SpiritwalkersGraceBuff) or not v3:IsMoving();
		return v16 and v32;
	elseif (v15 == v17.LightningBolt) then
		local v33 = v3:BuffUp(v17.SpiritwalkersGraceBuff) or v3:BuffUp(v17.StormkeeperBuff) or not v3:IsMoving();
		return v16 and v33;
	elseif (v15 == v17.ChainLightning) then
		local v34 = v3:BuffUp(v17.SpiritwalkersGraceBuff) or v3:BuffUp(v17.StormkeeperBuff) or v3:BuffUp(v17.ArcDischargeBuff) or not v3:IsMoving();
		return v16 and v34;
	elseif (v15 == v17.LavaBurst) then
		local v35 = v3:BuffUp(v17.SpiritwalkersGraceBuff) or v3:BuffUp(v17.LavaSurgeBuff) or not v3:IsMoving();
		local v36 = v3:BuffUp(v17.LavaSurgeBuff);
		local v37 = (v17.LavaBurst:Charges() >= (569 - (367 + 201))) and not v3:IsCasting(v17.LavaBurst);
		local v38 = (v17.LavaBurst:Charges() == (929 - (214 + 713))) and v3:IsCasting(v17.LavaBurst);
		return v16 and v35 and (v36 or v37 or v38);
	else
		return v16;
	end
end, 66 + 196);
v0.AddCoreOverride("Player.MotEUp", function()
	if not v10.MasteroftheElements:IsAvailable() then
		return false;
	end
	local v18 = v3:BuffUp(v10.MasteroftheElementsBuff);
	if not v3:IsCasting() then
		return v18;
	elseif v3:IsCasting(v10.LavaBurst) then
		return true;
	elseif (v3:IsCasting(v10.ElementalBlast) or v3:IsCasting(v10.Icefury) or v3:IsCasting(v10.LightningBolt) or v3:IsCasting(v10.ChainLightning)) then
		return false;
	else
		return v18;
	end
end, 42 + 220);
v0.AddCoreOverride("Player.PotMUp", function()
	if not v10.PoweroftheMaelstrom:IsAvailable() then
		return false;
	end
	local v19 = v3:BuffStack(v10.PoweroftheMaelstromBuff);
	if not v3:IsCasting() then
		return v19 > (877 - (282 + 595));
	elseif ((v19 == (1638 - (1523 + 114))) and (v3:IsCasting(v10.LightningBolt) or v3:IsCasting(v10.ChainLightning))) then
		return false;
	else
		return v19 > (0 + 0);
	end
end, 372 - 110);
v0.AddCoreOverride("Player.StormkeeperUp", function()
	if not v10.Stormkeeper:IsAvailable() then
		return false;
	end
	local v20 = v3:BuffUp(v10.StormkeeperBuff);
	if not v3:IsCasting() then
		return v20;
	elseif v3:IsCasting(v10.Stormkeeper) then
		return true;
	else
		return v20;
	end
end, 1327 - (68 + 997));
v0.AddCoreOverride("Player.IcefuryUp", function()
	if not v10.Icefury:IsAvailable() then
		return false;
	end
	local v21 = v3:BuffUp(v10.IcefuryBuff);
	if not v3:IsCasting() then
		return v21;
	elseif v3:IsCasting(v10.Icefury) then
		return true;
	else
		return v21;
	end
end, 1532 - (226 + 1044));
local v13;
v13 = v0.AddCoreOverride("Spell.IsReady", function(v22, v23, v24, v25, v26, v27)
	local v28 = true;
	if v24 then
		local v31 = v26 or v5;
		v28 = v31:IsInRange(v24, v25);
	end
	local v29 = v13(v22, v23, v24, v25, v26, v27) and v9.ShouldStopCast(v22);
	return v29;
end, 1149 - 885);
