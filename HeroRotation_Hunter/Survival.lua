--- ============================ HEADER ============================
--- ======= LOCALIZE =======
-- Addon
local addonName, addonTable = ...
-- HeroLib
local HL                    = HeroLib
local Cache                 = HeroCache
local Unit                  = HL.Unit
local Player                = Unit.Player
local Target                = Unit.Target
local Mouseover             = Unit.MouseOver
local Pet                   = Unit.Pet
local Spell                 = HL.Spell
local MultiSpell            = HL.MultiSpell
local Item                  = HL.Item
-- HeroRotation
local HR                    = HeroRotation()
local Cast                  = HR.Cast
local AoEON                 = HR.AoEON
local CDsON                 = HR.CDsON
-- Num/Bool Helper Functions
local num                   = HR.Commons().Everyone.num
local bool                  = HR.Commons().Everyone.bool

--- ============================ CONTENT ===========================
--- ======= APL LOCALS =======
-- GUI Settings
-- Commons
local Everyone              = HR.Commons().Everyone
local Hunter                = HR.Commons().Hunter
local MainHandWeaponIsValid
local GUISettings           = HR.GUISettingsGet()
local Settings              = {
  General = GUISettings.General,
  Commons = GUISettings.APL.Hunter.Commons,
  Pet = GUISettings.APL.Hunter.SVPet,
  Defensives = GUISettings.APL.Hunter.Defensives,
  Survival = GUISettings.APL.Hunter.Survival,
  TTD = GUISettings.APL.Hunter.Survival_TTD

}
local Enemies40y
-- Spells
local S                     = Spell.Hunter.Survival

-- Items
local I                     = Item.Hunter.Survival
local OnUseExcludes         = {
  I.AlgetharPuzzleBox:ID(),
  I.Djaruun:ID(),
  I.ManicGrieftorch:ID(),
  I.MadQueensMandate:ID(),
}
local ShouldReturn
-- Rotation Var
local SummonPetSpells       = { S.SummonPet, S.SummonPet2, S.SummonPet3, S.SummonPet4, S.SummonPet5 }
local EnemyCount8ySplash
local MBRS                  = S.MongooseBite:IsLearned() and S.MongooseBite or S.RaptorStrike
local EnemyList, EnemyRangeList, EnemyCount
local BossFightRemains      = 11111
local FightRemains          = 11111
local MBRSRange             = 5
local Equip                 = Player:GetEquipment()
local Trinket1              = Equip[13] and Item(Equip[13]) or Item(0)
local Trinket2              = Equip[14] and Item(Equip[14]) or Item(0)

local IsBossfight


HL:RegisterForEvent(function()
  BossFightRemains = 11111
  FightRemains = 11111
end, "PLAYER_REGEN_ENABLED")
HL:RegisterForEvent(function()
  MBRS = S.MongooseBite:IsAvailable() and S.MongooseBite or S.RaptorStrike
end, "SPELLS_CHANGED", "LEARNED_SPELL_IN_TAB")
-- Equipment updates
--[[local function isWeaponSubTypeValid(slotId, weaponTypes)
  local itemLink = GetInventoryItemLink("player", slotId)
  if itemLink then
    local _, _, _, _, _, _, _, _, _, _, _, itemClassID, itemSubClassID = GetItemInfo(itemLink)

    for _, listValue in ipairs(weaponTypes) do
      if listValue == itemSubClassID then
        return true
      end
    end
  end
  return false
end]]

local validWeaponTypes = { 1, 5, 6, 8, 10, 17 }
local forbiddenIds = {
  209230,
  189632
}
local function DoNotJumpOn()
  for _, id in ipairs(forbiddenIds) do
    if Target:NPCID() == id and not Target:IsInMeleeRange(5) or Target:CastSpellID() == 420739 then
      return false -- Target ID found in the list
    end
  end
  return true -- Target ID not found in the list
end
local timerEndTime = 0
local lunarStormTimer = 0
local function LunarStormTimer()
  if S.WildfireBomb:TimeSinceLastCast() > 0 and S.WildfireBomb:TimeSinceLastCast() < 1 then
    if timerEndTime == 0 then 
      timerEndTime = GetTime() + 15 
    end
  end

  if timerEndTime > 0 and GetTime() >= timerEndTime then
    timerEndTime = 0 
  end

  return math.max(0, timerEndTime - GetTime()) 
end
local function GroundSpellCondition()
  return (Mouseover:Exists() or not Settings.Marksmanship.CursorCheck) and not Player:IsCameraBusy()
end
HL:RegisterForEvent(function()
  Equip = Player:GetEquipment()
  Trinket1 = Equip[13] and Item(Equip[13]) or Item(0)
  Trinket2 = Equip[14] and Item(Equip[14]) or Item(0)
  --MainHandWeaponIsValid = isWeaponSubTypeValid(16, validWeaponTypes)
end, "PLAYER_EQUIPMENT_CHANGED", "ADDON_LOADED")
--cooldown settings
local function SpellProperties(property)
  return property ~= "Not Used" and (property == "With Cooldowns" and HR.CDsON() or
    property == "With Small or Cooldowns" and (SmallCDToggle or HR.CDsON()) or property == "With Small CDs" and SmallCDToggle or
    property == "On Mobcount" and EnemyCount >= Settings.Survival.Mobcount or
    property == "On Mobcount or Cooldowns" and (EnemyCount >= Settings.Survival.Mobcount or CDsON()) or
    property == "Always" or
    property == "On Bosses" and IsBossfight or
    property == "Mobcount or Boss" and (IsBossfight or EnemyCount >= Settings.Survival.Mobcount) or
    property == "With Bloodlust only" and Player:BloodlustUp())
end
--TTD functions
local function CastWithTTD(Spell, OffGCD, Threshold)
  if IsBossfight or Everyone.ISSolo() or Threshold == 0 or FightRemains >= Threshold and FightRemains < 7777 then
    HR.Cast(Spell, OffGCD)
    return "TTD cast " .. Spell:Name()
  end
end
local function TTDCheckForCDs(SettingsValue)
  return IsBossfight or Everyone.ISSolo() or SettingsValue == 0 or Everyone.Buggedmobs[Target:NPCID()] or FightRemains >= SettingsValue and FightRemains < 7777
end
local function TrinketSetting(trinketslot, ignoreTTD)
  if trinketslot == 1 then
  return SpellProperties(Settings.Survival.Trinket1Setting) 
  end
  if trinketslot == 2 then
    return SpellProperties(Settings.Survival.Trinket2Setting) 
    end
end
-- Stuns
local StunInterrupts = {
  { S.Intimidation, "Cast Intimidation (Interrupt)", function() return true; end },
}

local function TorchIsReady()
  return I.ManicGrieftorch:IsEquipped() and
      (I.ManicGrieftorch:CooldownUp() or I.ManicGrieftorch:CooldownRemains() <= Player:GCDRemains())
end
local function PuzzleBoxIsReady()
  return I.AlgetharPuzzleBox:IsEquipped() and
      (I.AlgetharPuzzleBox:CooldownUp() or I.AlgetharPuzzleBox:CooldownRemains() <= Player:GCDRemains())
end
-- Bombs
local Bombs = { S.WildfireBomb, S.ShrapnelBomb, S.PheromoneBomb, S.VolatileBomb }
local BombDebuffs = { S.WildfireBombDebuff, S.ShrapnelBombDebuff, S.PheromoneBombDebuff, S.VolatileBombDebuff }

local function MOcanBeExecuted()
  return (Mouseover:HealthPercentage() > 0 and Mouseover:HealthPercentage() <= 20 or Player:BuffUp(S.CoordinatedAssaultEmpowerBuff)) and
      Player:Focus() >= 10 and Mouseover:IsSpellInRange(S.KillShot)
end
local function KSHPTheshhold(TargetUnit)
  -- below 20% health
  return (TargetUnit:HealthPercentage() > 0 and TargetUnit:HealthPercentage() <= 20 or Player:BuffUp(S.CoordinatedAssaultEmpowerBuff) or S.SicEm:IsAvailable()) and
      Player:Focus() >= 10 and TargetUnit:IsSpellInRange(S.KillShot)
end
-- Function to see if we're going to cap focus
local function CheckFocusCap(SpellCastTime, GenFocus)
  local GeneratedFocus = GenFocus or 0
  return (Player:Focus() + Player:FocusCastRegen(SpellCastTime) + GeneratedFocus < Player:FocusMax())
end

-- CastCycle/CastTargetIf functions
local function EvaluateTargetIfFilterBloodseekerRemains(TargetUnit)
  -- target_if=min:bloodseeker.remains
  return (TargetUnit:DebuffDown(S.BloodseekerDebuff, true))
end
local function EvaluateTargetIfFilterSerpentStingRemains(TargetUnit)
  -- target_if=min:dot.serpent_sting.remains
  return TargetUnit:DebuffRemains(S.SerpentStingDebuff)
end

--- ===== CastTargetIf Condition Functions =====
local function EvaluateTargetIfMBRSPLST(TargetUnit)
  -- if=!dot.serpent_sting.ticking&target.time_to_die>12&(!talent.contagious_reagents|active_dot.serpent_sting=0)
  -- Note: Parenthetical is handled before CastTargetIf.
  return TargetUnit:DebuffDown(S.SerpentStingDebuff) and TargetUnit:TimeToDie() > 12
end

local function EvaluateTargetIfMBRSPLST2(TargetUnit)
  -- if=talent.contagious_reagents&active_dot.serpent_sting<active_enemies&dot.serpent_sting.remains
  -- Note: Talent and active_dot conditions handled before CastTargetIf.
  return TargetUnit:DebuffUp(S.SerpentStingDebuff)
end
function CombatCheck()
  return Everyone.TargetIsValid() and
      (Target:AffectingCombat() or Settings.Commons.AttackOutOfCombat == "Solo" and Everyone.ISSolo() or Settings.Commons.AttackOutOfCombat == "Always")
end

local function CDs()
  -- blood_fury,if=buff.coordinated_assault.up|!talent.coordinated_assault&cooldown.spearhead.remains|!talent.spearhead&!talent.coordinated_assault
  if S.BloodFury:IsCastable() and TTDCheckForCDs(Settings.TTD.RacialsTTD) and (Player:BuffUp(S.CoordinatedAssaultBuff) or not S.CoordinatedAssault:IsAvailable() and S.Spearhead:CooldownDown() or not S.Spearhead:IsAvailable() and not S.CoordinatedAssault:IsAvailable()) then
    if Cast(S.BloodFury, false) then return "blood_fury cds 2"; end
  end
  -- harpoon,if=talent.terms_of_engagement.enabled&focus<focus.max
  if S.Harpoon:IsCastable() and DoNotJumpOn() and Settings.Survival.UseHarpoon and Target:IsSpellInRange(S.Harpoon) and (Player:PrevGCD(1, S.KillCommand)) then
    if Cast(S.Harpoon) then
      return
      "harpoon cds 4";
    end
  end
  if (Player:BuffUp(S.CoordinatedAssaultBuff) or not S.CoordinatedAssault:IsAvailable() and S.Spearhead:CooldownDown() or not S.Spearhead:IsAvailable() and not S.CoordinatedAssault:IsAvailable()) then
    -- ancestral_call,if=buff.coordinated_assault.up|buff.spearhead.up|!talent.spearhead&!talent.coordinated_assault
    if S.AncestralCall:IsCastable() and TTDCheckForCDs(Settings.TTD.RacialsTTD) then
      if Cast(S.AncestralCall, false) then return "ancestral_call cds 6"; end
    end
    -- fireblood,if=buff.coordinated_assault.up|buff.spearhead.up|!talent.spearhead&!talent.coordinated_assault
    if S.Fireblood:IsCastable() and TTDCheckForCDs(Settings.TTD.RacialsTTD) then
      if Cast(S.Fireblood, false) then return "fireblood cds 8"; end
    end
  end
  -- lights_judgment
  if S.LightsJudgment:IsCastable() and Target:IsSpellInRange(S.LightsJudgment) and TTDCheckForCDs(Settings.TTD.RacialsTTD) then
    if Cast(S.LightsJudgment) then
      return
      "lights_judgment cds 10";
    end
  end
  -- bag_of_tricks,if=cooldown.kill_command.full_recharge_time>gcd
  if S.BagofTricks:IsCastable() and Target:IsSpellInRange(S.BagofTricks) and TTDCheckForCDs(Settings.TTD.RacialsTTD) and (S.KillCommand:FullRechargeTime() > Player:GCD()) then
    if Cast(S.BagofTricks) then return "bag_of_tricks cds 12"; end
  end
  -- berserking,if=buff.coordinated_assault.up|buff.spearhead.up|!talent.spearhead&!talent.coordinated_assault|time_to_die<13
  if S.Berserking:IsCastable() and TTDCheckForCDs(Settings.TTD.RacialsTTD) and (Player:BuffUp(S.CoordinatedAssaultBuff) or Player:BuffUp(S.SpearheadBuff) or not S.Spearhead:IsAvailable() and not S.CoordinatedAssault:IsAvailable() or FightRemains < 13) then
    if Cast(S.Berserking, false) then return "berserking cds 14"; end
  end
  -- muzzle
  -- Handled via Interrupt in APL()
  -- potion,if=target.time_to_die<25|buff.coordinated_assault.up|buff.spearhead.up|!talent.spearhead&!talent.coordinated_assault
  if Settings.Commons.Enabled.Potions and PotionSetting and (FightRemains < 25 or Player:BuffUp(S.CoordinatedAssaultBuff) or Player:BuffUp(S.SpearheadBuff) or not S.Spearhead:IsAvailable() and not S.CoordinatedAssault:IsAvailable()) then
    local PotionSelected = Everyone.PotionSelected()
    if PotionSelected and PotionSelected:IsReady() then
      HR.CastMacro(3, nil, nil, PotionSelected)
      return "Cast Potion";
    end
  end
  if Settings.Commons.Enabled.Trinkets then
    -- use_item,name=algethar_puzzle_box,use_off_gcd=1,if=gcd.remains>gcd.max-0.1
    -- Note: Widened the available window by half a second to account for player reaction.
    if PuzzleBoxIsReady() then
      if Cast(I.AlgetharPuzzleBox) then return "algethar_puzzle_box cds 18"; end
    end
    -- use_item,name=manic_grieftorch,use_off_gcd=1,if=gcd.remains>gcd.max-0.1&!buff.spearhead.up
    if TorchIsReady() and Player:AffectingCombat() and (Trinket1:ID() == I.ManicGrieftorch:ID() and TrinketSetting(1) or Trinket2:ID() == I.ManicGrieftorch:ID() and TrinketSetting(2)) and Target:IsInRange(40) then
      if Cast(I.ManicGrieftorch) then return "manic_grieftorch cds 20"; end
    end
     -- actions.cds+=/use_item,name=imperfect_ascendancy_serum,use_off_gcd=1,if=gcd.remains>gcd.max-0.1
     if Player:AffectingCombat() and (Trinket1:ID() == I.ImperfectAscendancySerum:ID() and TrinketSetting(1) or Trinket2:ID() == I.ImperfectAscendancySerum:ID() and TrinketSetting(2)) and Target:IsInRange(40) then
      if Cast(I.ImperfectAscendancySerum) then return "imperfect_ascendancy_serum cds 22"; end
    end

    -- use_items,use_off_gcd=1,if=gcd.remains>gcd.max-0.1&!buff.spearhead.up
    if Player:BuffDown(S.SpearheadBuff) then
      local ItemToUse, ItemSlot, ItemRange = Player:GetUseableItems(OnUseExcludes)
      if ItemToUse then
        if ((ItemSlot == 13 and TrinketSetting(1) or ItemSlot == 14 and TrinketSetting(2)) and Target:IsInMeleeRange(5)) then
          if Cast(ItemToUse, true) then
            return "Generic use_items for " ..
                ItemToUse:Name();
          end
        end
      end
    end
  end
    -- use_item,name=mad_queens_mandate,use_off_gcd=1,if=gcd.remains>gcd.max-0.1&(time_to_die<10|time_to_die>120)&(trinket.skardyns_grace.cooldown.remains|!equipped.skardyns_grace)|time_to_die<10
    if Settings.Commons.Enabled.Trinkets and I.MadQueensMandate:IsEquippedAndReady() and (Trinket1:ID() == I.MadQueensMandate:ID() and TrinketSetting(1) or Trinket2:ID() == I.MadQueensMandate:ID() and TrinketSetting(2)) and ((Target:TimeToDie() < 10 or Target:TimeToDie() > 120) and (I.SkardynsGrace:CooldownDown() or not I.SkardynsGrace:IsEquipped()) or Target:TimeToDie() < 10) then
      if Cast(I.MadQueensMandate) then return "mad_queens_mandate cds 22"; end
    end
  -- aspect_of_the_eagle,if=target.distance>=6
  if S.AspectoftheEagle:IsCastable() and Settings.Survival.AspectoftheEagle and not Target:IsInRange(MBRSRange) then
    if Cast(S.AspectoftheEagle, false) then return "aspect_of_the_eagle cds 24"; end
  end
end
local function PLST()
  -- kill_command,target_if=min:bloodseeker.remains,if=(buff.relentless_primal_ferocity.up&buff.tip_of_the_spear.stack<1)
  if S.KillCommand:IsCastable() and Target:IsSpellInRange(S.KillCommand) and (Player:BuffUp(S.RelentlessPrimalFerocityBuff) and Player:BuffDown(S.TipoftheSpearBuff)) then
    if Cast(S.KillCommand) then -- if Everyone.CastCycle(S.KillCommand, EnemyRangeList, EvaluateTargetIfFilterBloodseekerRemains, 40) then
      return
      "kill_command plst 2";
    end
  end
  -- spearhead,if=cooldown.coordinated_assault.remains
  if S.Spearhead:IsCastable() and SpearheadSetting and Target:IsSpellInRange(S.Spearhead) and (S.CoordinatedAssault:CooldownDown()) then
    if Cast(S.Spearhead) then return "spearhead plst 4"; end
  end
  -- raptor_bite,target_if=min:dot.serpent_sting.remains,if=!dot.serpent_sting.ticking&target.time_to_die>12&(!talent.contagious_reagents|active_dot.serpent_sting=0)
  if MBRS:IsReady() and Target:IsInMeleeRange(MBRSRange) and EvaluateTargetIfMBRSPLST(Target) and (not S.ContagiousReagents:IsAvailable() or S.SerpentStingDebuff:AuraActiveCount() == 0) then
    if Cast(S.RaptorStrikeCast) then return MBRS:Name() .. " plst 6"; end
  end
  -- raptor_bite,target_if=max:dot.serpent_sting.remains,if=talent.contagious_reagents&active_dot.serpent_sting<active_enemies&dot.serpent_sting.remains
  if MBRS:IsReady() and Target:IsInMeleeRange(MBRSRange) and EvaluateTargetIfMBRSPLST2(Target) and (S.ContagiousReagents:IsAvailable() and S.SerpentStingDebuff:AuraActiveCount() < EnemyCount) then
    if Cast(S.RaptorStrikeCast) then return MBRS:Name() .. " plst 8"; end
  end
  -- wildfire_bomb,if=buff.tip_of_the_spear.stack>0&cooldown.wildfire_bomb.charges_fractional>1.7|cooldown.wildfire_bomb.charges_fractional>1.9|cooldown.coordinated_assault.remains<2*gcd
  if S.WildfireBomb:IsReady() and Target:IsSpellInRange(S.WildfireBomb) and (Player:BuffUp(S.TipoftheSpearBuff) and S.WildfireBomb:ChargesFractional() > 1.7 or S.WildfireBomb:ChargesFractional() > 1.9 or S.CoordinatedAssault:CooldownRemains() < 2 * Player:GCD()) then
    if Cast(S.WildfireBomb) then return "wildfire_bomb plst 10"; end
  end
  -- coordinated_assault,if=!talent.bombardier|talent.bombardier&cooldown.wildfire_bomb.charges_fractional<1
  if S.CoordinatedAssault:IsCastable() and DoNotJumpOn() and CoordinatedAssaultSetting and Target:IsSpellInRange(S.CoordinatedAssault) and (not S.Bombardier:IsAvailable() or S.Bombardier:IsAvailable() and S.WildfireBomb:ChargesFractional() < 1) then
    if Cast(S.CoordinatedAssault) then return "coordinated_assault plst 12"; end
  end
  -- kill_shot,if=(buff.tip_of_the_spear.stack>0|talent.sic_em)
  if S.KillShot:IsReady() and Target:IsSpellInRange(S.KillShot) and (Player:BuffUp(S.TipoftheSpearBuff) or S.SicEm:IsAvailable()) then
    if Everyone.CastCycle(S.KillShot, EnemyRangeList, KSHPTheshhold, 40) then return "kill_shot plst 14"; end
  end
  -- flanking_strike
  if S.FlankingStrike:IsCastable() and Target:IsSpellInRange(S.FlankingStrike) and FlankingStrikeSetting and DoNotJumpOn() then
    if Cast(S.FlankingStrike) then return "flanking_strike plst 16"; end
  end
  -- explosive_shot,if=(talent.spearhead&(!talent.symbiotic_adrenaline&(buff.tip_of_the_spear.stack>0|buff.bombardier.remains)&cooldown.spearhead.remains>20|cooldown.spearhead.remains<2))|((talent.symbiotic_adrenaline|!talent.spearhead)&(buff.tip_of_the_spear.stack>0|buff.bombardier.remains)&cooldown.coordinated_assault.remains>20|cooldown.coordinated_assault.remains<2)
  if S.ExplosiveShot:IsReady() and Target:TimeToDie() > 3 and Target:IsSpellInRange(S.ExplosiveShot) and ((S.Spearhead:IsAvailable() and (not S.SymbioticAdrenaline:IsAvailable() and (Player:BuffUp(S.TipoftheSpearBuff) or Player:BuffUp(S.BombardierBuff)) and S.Spearhead:CooldownRemains() > 20 or S.Spearhead:CooldownRemains() < 2)) or ((S.SymbioticAdrenaline:IsAvailable() or not S.Spearhead:IsAvailable()) and (Player:BuffUp(S.TipoftheSpearBuff) or Player:BuffUp(S.BombardierBuff)) and S.CoordinatedAssault:CooldownRemains() > 20 or S.CoordinatedAssault:CooldownRemains() < 2)) then
    if Cast(S.ExplosiveShot) then return "explosive_shot plst 18"; end
  end
  -- raptor_bite,if=(buff.furious_assault.up&buff.tip_of_the_spear.stack>0)&(!talent.mongoose_bite|buff.mongoose_fury.stack>4)
  if MBRS:IsReady() and Target:IsInMeleeRange(MBRSRange) and ((Player:BuffUp(S.FuriousAssaultBuff) and Player:BuffUp(S.TipoftheSpearBuff)) and (not S.MongooseBite:IsAvailable() or Player:BuffStack(S.MongooseFuryBuff) > 4)) then
    if Cast(S.RaptorStrikeCast) then return MBRS:Name() .. "plst 20"; end
  end
  -- kill_command,target_if=min:bloodseeker.remains
  if S.KillCommand:IsCastable() and Target:IsSpellInRange(S.KillCommand) then
    if Cast(S.KillCommand) then -- if Everyone.CastCycle(S.KillCommand, EnemyRangeList, EvaluateTargetIfFilterBloodseekerRemains, 40) then
      return
      "kill_command plst 22";
    end
  end
  -- wildfire_bomb,if=buff.tip_of_the_spear.stack>0&(!raid_event.adds.exists|raid_event.adds.exists&raid_event.adds.in>15)
  if S.WildfireBomb:IsReady() and Target:IsSpellInRange(S.WildfireBomb) and (Player:BuffUp(S.TipoftheSpearBuff)) then
    if Cast(S.WildfireBomb) then return "wildfire_bomb plst 24"; end
  end
  -- fury_of_the_eagle,interrupt=1,if=(!raid_event.adds.exists|raid_event.adds.exists&raid_event.adds.in>40)
  if S.FuryoftheEagle:IsCastable() and FuryoftheEagleSetting and Target:IsInMeleeRange(5) then
    if Cast(S.FuryoftheEagle) then return "fury_of_the_eagle plst 26"; end
  end
  -- butchery,if=active_enemies>1&(talent.merciless_blows&buff.merciless_blows.down|!talent.merciless_blows)
  if S.Butchery:IsReady() and Target:IsInMeleeRange(5) and (EnemyCount > 1 and (S.MercilessBlows:IsAvailable() and Player:BuffDown(S.MercilessBlowsBuff) or not S.MercilessBlows:IsAvailable())) then
    if Cast(S.Butchery) then return "butchery plst 28"; end
  end
  -- raptor_bite,target_if=min:dot.serpent_sting.remains,if=!talent.contagious_reagents
  if MBRS:IsReady() and Target:IsInMeleeRange(MBRSRange) and (not S.ContagiousReagents:IsAvailable()) then
    if Cast(S.RaptorStrikeCast) then return MBRS:Name() .. " plst 30"; end
  end
  -- raptor_bite,target_if=max:dot.serpent_sting.remains
  if MBRS:IsReady() and Target:IsInMeleeRange(MBRSRange) then
    if Cast(S.RaptorStrikeCast) then return MBRS:Name() .. " plst 32"; end
  end
end

local function PLCleave()
  -- spearhead,if=cooldown.coordinated_assault.remains
  if S.Spearhead:IsCastable() and SpearheadSetting and Target:IsSpellInRange(S.Spearhead) and (S.CoordinatedAssault:CooldownDown()) then
    if Cast(S.Spearhead) then return "spearhead plcleave 2"; end
  end
  -- kill_command,target_if=min:bloodseeker.remains,if=buff.relentless_primal_ferocity.up&buff.tip_of_the_spear.stack<1
  if S.KillCommand:IsCastable() and Target:IsSpellInRange(S.KillCommand) and (Player:BuffUp(S.RelentlessPrimalFerocityBuff) and Player:BuffDown(S.TipoftheSpearBuff)) then
    if Cast(S.KillCommand) then -- if Everyone.CastCycle(S.KillCommand, EnemyRangeList, EvaluateTargetIfFilterBloodseekerRemains, 40) then
      return
      "kill_command plcleave 4";
    end
  end
  -- explosive_shot,if=buff.bombardier.remains
  if S.ExplosiveShot:IsReady() and Target:TimeToDie() > 3 and Target:IsSpellInRange(S.ExplosiveShot) and (Player:BuffUp(S.BombardierBuff)) then
    if Cast(S.ExplosiveShot) then return "explosive_shot plcleave 6"; end
  end
  -- wildfire_bomb,if=buff.tip_of_the_spear.stack>0&cooldown.wildfire_bomb.charges_fractional>1.7|cooldown.wildfire_bomb.charges_fractional>1.9|cooldown.coordinated_assault.remains<2*gcd
  if S.WildfireBomb:IsReady() and Target:IsSpellInRange(S.WildfireBomb) and (Player:BuffUp(S.TipoftheSpearBuff) and S.WildfireBomb:ChargesFractional() > 1.7 or S.WildfireBomb:ChargesFractional() > 1.9 or S.CoordinatedAssault:CooldownRemains() < 2 * Player:GCD()) then
    if Cast(S.WildfireBomb) then return "wildfire_bomb plcleave 8"; end
  end
  -- coordinated_assault,if=!talent.bombardier|talent.bombardier&cooldown.wildfire_bomb.charges_fractional<1
  if S.CoordinatedAssault:IsCastable() and DoNotJumpOn() and CoordinatedAssaultSetting and Target:IsSpellInRange(S.CoordinatedAssault) and (not S.Bombardier:IsAvailable() or S.Bombardier:IsAvailable() and S.WildfireBomb:ChargesFractional() < 1) then
    if Cast(S.CoordinatedAssault) then return "coordinated_assault plcleave 10"; end
  end
  -- flanking_strike,if=buff.tip_of_the_spear.stack<2
  if S.FlankingStrike:IsCastable() and Target:IsSpellInRange(S.FlankingStrike) and FlankingStrikeSetting and DoNotJumpOn() and (Player:BuffStack(S.TipoftheSpearBuff) < 2) then
    if Cast(S.FlankingStrike) then return "flanking_strike plcleave 12"; end
  end
  -- explosive_shot,if=(buff.tip_of_the_spear.stack>0|buff.bombardier.remains)&((cooldown.coordinated_assault.remains>20&(cooldown.coordinated_assault.remains<80|buff.coordinated_assault.remains))|(cooldown.coordinated_assault.remains>12&cooldown.coordinated_assault.remains<20))|cooldown.coordinated_assault.remains<2
  if S.ExplosiveShot:IsReady() and Target:TimeToDie() > 3 and Target:IsSpellInRange(S.ExplosiveShot) and ((Player:BuffUp(S.TipoftheSpearBuff) or Player:BuffUp(S.BombardierBuff)) and ((S.CoordinatedAssault:CooldownRemains() > 20 and (S.CoordinatedAssault:CooldownRemains() < 80 or Player:BuffUp(S.CoordinatedAssaultBuff))) or (S.CoordinatedAssault:CooldownRemains() > 12 and S.CoordinatedAssault:CooldownRemains() < 20)) or S.CoordinatedAssault:CooldownRemains() < 2) then
    if Cast(S.ExplosiveShot) then return "explosive_shot plcleave 14"; end
  end
  -- fury_of_the_eagle,if=buff.tip_of_the_spear.stack>0
  if S.FuryoftheEagle:IsCastable() and FuryoftheEagleSetting and Target:IsInMeleeRange(5) and (Player:BuffUp(S.TipoftheSpearBuff)) then
    if Cast(S.FuryoftheEagle) then return "fury_of_the_eagle plcleave 16"; end
  end
  -- kill_shot,if=buff.sic_em.remains
  if S.KillShot:IsReady() and Target:IsSpellInRange(S.KillShot) and (Player:BuffUp(S.SicEmBuff)) then
    if Everyone.CastCycle(S.KillShot, EnemyRangeList, KSHPTheshhold, 40) then return "kill_shot plcleave 18"; end
  end
  -- kill_command,target_if=min:bloodseeker.remains,if=focus+cast_regen<focus.max|buff.exposed_flank.remains&buff.tip_of_the_spear.stack<2
  if S.KillCommand:IsCastable() and Target:IsInRange(40) and (CheckFocusCap(S.KillCommand:ExecuteTime(), 15) or Player:BuffUp(S.ExposedFlankBuff) and Player:BuffStack(S.TipoftheSpearBuff) < 2) then
    if Cast(S.KillCommand) then -- if Everyone.CastCycle(S.KillCommand, EnemyRangeList, EvaluateTargetIfFilterBloodseekerRemains, 40) then
      return
      "kill_command plcleave 20";
    end
  end
  -- wildfire_bomb,if=buff.tip_of_the_spear.stack>0
  if S.WildfireBomb:IsReady() and Target:IsSpellInRange(S.WildfireBomb) and (Player:BuffUp(S.TipoftheSpearBuff)) then
    if Cast(S.WildfireBomb) then return "wildfire_bomb plcleave 22"; end
  end
  -- butchery,if=charges_fractional>2.8&cooldown.wildfire_bomb.charges_fractional<1.5
  if S.Butchery:IsReady() and Target:IsInMeleeRange(5) and (S.Butchery:ChargesFractional() > 2.8 and S.WildfireBomb:ChargesFractional() < 1.5) then
    if Cast(S.Butchery) then return "butchery plcleave 24"; end
  end
  -- raptor_bite,if=buff.merciless_blows.up
  if MBRS:IsReady() and Target:IsInMeleeRange(MBRSRange) and (Player:BuffUp(S.MercilessBlowsBuff)) then
    if Cast(S.RaptorStrikeCast) then return MBRS:Name() .. " plcleave 26"; end
  end
  -- butchery
  if S.Butchery:IsReady() and Target:IsInMeleeRange(5) then
    if Cast(S.Butchery) then return "butchery plcleave 28"; end
  end
  -- kill_shot
  if S.KillShot:IsReady() and Target:IsSpellInRange(S.KillShot) then
    if Everyone.CastCycle(S.KillShot, EnemyRangeList, KSHPTheshhold, 40) then return "kill_shot plcleave 30"; end
  end
  -- kill_command,target_if=min:bloodseeker.remains
  if S.KillCommand:IsCastable() and Target:IsInRange(40) then
    if Cast(S.KillCommand) then -- if Everyone.CastCycle(S.KillCommand, EnemyRangeList, EvaluateTargetIfFilterBloodseekerRemains, 40) then
      return
      "kill_command plcleave 32";
    end
  end
  -- raptor_bite
  if MBRS:IsReady() then
    if Cast(S.RaptorStrikeCast) then return MBRS:Name() .. " plcleave 34"; end
  end
end

local function SentST()
  --actions.sentst=wildfire_bomb,if=!cooldown.lunar_storm.remains
  if S.WildfireBomb:IsReady() and Target:IsSpellInRange(S.WildfireBomb) and (lunarStormTimer == 0) then
    if Cast(S.WildfireBomb) then return "wildfire_bomb sentst 1"; end
  end
  -- kill_command,target_if=min:bloodseeker.remains,if=(buff.relentless_primal_ferocity.up&buff.tip_of_the_spear.stack<1)
  if S.KillCommand:IsCastable() and Target:IsSpellInRange(S.KillCommand) and (Player:BuffUp(S.RelentlessPrimalFerocityBuff) and Player:BuffDown(S.TipoftheSpearBuff)) then
    if Cast(S.KillCommand) then -- if Everyone.CastCycle(S.KillCommand, EnemyRangeList, EvaluateTargetIfFilterBloodseekerRemains, 40) then
      return
      "kill_command sentst 2";
    end
  end
  -- spearhead,if=cooldown.coordinated_assault.remains
  if S.Spearhead:IsCastable() and SpearheadSetting and Target:IsSpellInRange(S.Spearhead) and (S.CoordinatedAssault:CooldownDown()) then
    if Cast(S.Spearhead) then return "spearhead sentst 4"; end
  end
  -- raptor_bite,target_if=min:dot.serpent_sting.remains,if=!dot.serpent_sting.ticking&target.time_to_die>12&(!talent.contagious_reagents|active_dot.serpent_sting=0)
  if MBRS:IsReady() and Target:IsInMeleeRange(MBRSRange) and EvaluateTargetIfMBRSPLST(Target) and (not S.ContagiousReagents:IsAvailable() or S.SerpentStingDebuff:AuraActiveCount() == 0) then
    if Cast(S.RaptorStrikeCast) then
      return
          MBRS:Name() .. " sentst 6";
    end
  end
  -- raptor_bite,target_if=max:dot.serpent_sting.remains,if=talent.contagious_reagents&active_dot.serpent_sting<active_enemies&dot.serpent_sting.remains
  if MBRS:IsReady() and Target:IsInMeleeRange(MBRSRange) and EvaluateTargetIfMBRSPLST2(Target) and (S.ContagiousReagents:IsAvailable() and S.SerpentStingDebuff:AuraActiveCount() < EnemyCount) then
    if Cast(S.RaptorStrikeCast) then
      return
          MBRS:Name() .. " sentst 8";
    end
  end
  -- flanking_strike,if=buff.tip_of_the_spear.stack<2
  if S.FlankingStrike:IsCastable() and Target:IsSpellInRange(S.FlankingStrike) and FlankingStrikeSetting and DoNotJumpOn() and (Player:BuffStack(S.TipoftheSpearBuff) < 2) then
    if Cast(S.FlankingStrike) then return "flanking_strike sentst 10"; end
  end
  -- actions.sentst+=/wildfire_bomb,if=(cooldown.lunar_storm.remains>full_recharge_time-gcd)&(buff.tip_of_the_spear.stack>0&cooldown.wildfire_bomb.charges_fractional>1.7|cooldown.wildfire_bomb.charges_fractional>1.9)|cooldown.coordinated_assault.remains<2*gcd
  if S.WildfireBomb:IsReady() and Target:IsSpellInRange(S.WildfireBomb) and ((lunarStormTimer > S.WildfireBomb:FullRechargeTime() - Player:GCD()) and (Player:BuffUp(S.TipoftheSpearBuff) and S.WildfireBomb:ChargesFractional() > 1.7 or S.WildfireBomb:ChargesFractional() > 1.9) or S.CoordinatedAssault:CooldownRemains() < 2 * Player:GCD()) then
    if Cast(S.WildfireBomb) then return "wildfire_bomb sentst 12"; end
  end
  -- coordinated_assault,if=!talent.bombardier|talent.bombardier&cooldown.wildfire_bomb.charges_fractional<1
  if S.CoordinatedAssault:IsCastable() and DoNotJumpOn() and CoordinatedAssaultSetting and Target:IsSpellInRange(S.CoordinatedAssault) and (not S.Bombardier:IsAvailable() or S.Bombardier:IsAvailable() and S.WildfireBomb:ChargesFractional() < 1) then
    if Cast(S.CoordinatedAssault) then return "coordinated_assault sentst 14"; end
  end
  -- explosive_shot,if=(talent.spearhead&(!talent.symbiotic_adrenaline&(buff.tip_of_the_spear.stack>0|buff.bombardier.remains)&cooldown.spearhead.remains>20|cooldown.spearhead.remains<2))|((talent.symbiotic_adrenaline|!talent.spearhead)&(buff.tip_of_the_spear.stack>0|buff.bombardier.remains)&cooldown.coordinated_assault.remains>20|cooldown.coordinated_assault.remains<2)
  if S.ExplosiveShot:IsReady() and Target:TimeToDie() > 3 and Target:IsSpellInRange(S.ExplosiveShot) and ((S.Spearhead:IsAvailable() and (not S.SymbioticAdrenaline:IsAvailable() and (Player:BuffUp(S.TipoftheSpearBuff) or Player:BuffUp(S.BombardierBuff)) and S.Spearhead:CooldownRemains() > 20 or S.Spearhead:CooldownRemains() < 2)) or ((S.SymbioticAdrenaline:IsAvailable() or not S.Spearhead:IsAvailable()) and (Player:BuffUp(S.TipoftheSpearBuff) or Player:BuffUp(S.BombardierBuff)) and S.CoordinatedAssault:CooldownRemains() > 20 or S.CoordinatedAssault:CooldownRemains() < 2)) then
    if Cast(S.ExplosiveShot) then return "explosive_shot sentst 16"; end
  end
  --actions.sentst+=/fury_of_the_eagle,if=buff.tip_of_the_spear.stack>0&talent.ruthless_marauder
  if S.FuryoftheEagle:IsCastable() and FuryoftheEagleSetting and Target:IsInMeleeRange(5) and Player:BuffStack(S.TipoftheSpearBuff) > 0 and S.RuthlessMarauder:IsAvailable() then
    if Cast(S.FuryoftheEagle) then return "fury_of_the_eagle sentst 17"; end
  end
  -- kill_shot,if=buff.tip_of_the_spear.stack>0|talent.sic_em
  if S.KillShot:IsReady() and Target:IsSpellInRange(S.KillShot) and (Player:BuffUp(S.TipoftheSpearBuff) or S.SicEm:IsAvailable()) then
    if Everyone.CastCycle(S.KillShot, EnemyRangeList, KSHPTheshhold, 40) then return "kill_shot sentst 18"; end
  end
  --actions.sentst+=/kill_command,target_if=min:bloodseeker.remains,if=buff.tip_of_the_spear.stack<1&cooldown.flanking_strike.remains<gcd
  if S.KillCommand:IsReady() and Target:IsSpellInRange(S.KillCommand) and (Player:BuffStack(S.TipoftheSpearBuff) < 1 and S.FlankingStrike:CooldownRemains() < Player:GCD()) then
    if Cast(S.KillCommand) then -- if Everyone.CastCycle(S.KillCommand, EnemyRangeList, EvaluateTargetIfFilterBloodseekerRemains, 40) then
      return
      "kill_command sentst 19";
    end
  end
  -- kill_command,target_if=min:bloodseeker.remains,if=focus+cast_regen<focus.max&(!buff.relentless_primal_ferocity.up||(buff.relentless_primal_ferocity.up&buff.tip_of_the_spear.stack<2))
  if S.KillCommand:IsReady() and Target:IsSpellInRange(S.KillCommand) and (CheckFocusCap(S.KillCommand:ExecuteTime(), 15) and (Player:BuffDown(S.RelentlessPrimalFerocityBuff) or (Player:BuffUp(S.RelentlessPrimalFerocityBuff) and Player:BuffStack(S.TipoftheSpearBuff) < 2))) then
    if Cast(S.KillCommand) then -- if Everyone.CastCycle(S.KillCommand, EnemyRangeList, EvaluateTargetIfFilterBloodseekerRemains, 40) then
      return
      "kill_command sentst 20";
    end
  end
  -- actions.sentst+=/wildfire_bomb,if=buff.tip_of_the_spear.stack>0&cooldown.lunar_storm.remains>full_recharge_time&(!raid_event.adds.exists|raid_event.adds.exists&raid_event.adds.in>15)
  if S.WildfireBomb:IsReady() and Target:IsSpellInRange(S.WildfireBomb) and (Player:BuffUp(S.TipoftheSpearBuff) and lunarStormTimer > S.WildfireBomb:FullRechargeTime()) then
    if Cast(S.WildfireBomb) then return "wildfire_bomb sentst 22"; end
  end
  -- actions.sentst+=/fury_of_the_eagle,if=buff.tip_of_the_spear.stack>0
  if S.FuryoftheEagle:IsCastable() and FuryoftheEagleSetting and Target:IsInMeleeRange(5) and Player:BuffStack(S.TipoftheSpearBuff) > 0 then
    if Cast(S.FuryoftheEagle) then return "fury_of_the_eagle sentst 24"; end
  end
  -- butchery,if=active_enemies>1&(talent.merciless_blows&buff.merciless_blows.down|!talent.merciless_blows)
  if S.Butchery:IsReady() and Target:IsInMeleeRange(5) and (EnemyCount > 1 and (S.MercilessBlows:IsAvailable() and Player:BuffDown(S.MercilessBlowsBuff) or not S.MercilessBlows:IsAvailable())) then
    if Cast(S.Butchery) then return "butchery sentst 26"; end
  end
  -- raptor_bite,target_if=min:dot.serpent_sting.remains,if=!talent.contagious_reagents
  if MBRS:IsReady() and Target:IsInMeleeRange(MBRSRange) and (not S.ContagiousReagents:IsAvailable()) then
    if Cast(S.RaptorStrikeCast) then return MBRS:Name() .. " sentst 28"; end
  end
  -- raptor_bite,target_if=max:dot.serpent_sting.remains
  if MBRS:IsReady() and Target:IsInMeleeRange(MBRSRange) then
    if Cast(S.RaptorStrikeCast) then return MBRS:Name() .. " sentst 30"; end
  end
end

local function SentCleave()
  -- spearhead,if=cooldown.coordinated_assault.remains
  if S.Spearhead:IsCastable() and SpearheadSetting and Target:IsSpellInRange(S.Spearhead) and (S.CoordinatedAssault:CooldownDown()) then
    if Cast(S.Spearhead) then return "spearhead sentcleave 2"; end
  end
  -- kill_command,target_if=min:bloodseeker.remains,if=buff.relentless_primal_ferocity.up&buff.tip_of_the_spear.stack<1
  if S.KillCommand:IsCastable() and Target:IsSpellInRange(S.KillCommand) and (Player:BuffUp(S.RelentlessPrimalFerocityBuff) and Player:BuffDown(S.TipoftheSpearBuff)) then
    if Cast(S.KillCommand) then -- if Everyone.CastCycle(S.KillCommand, EnemyRangeList, EvaluateTargetIfFilterBloodseekerRemains, 40) then
      return
      "kill_command sentcleave 4";
    end
  end
  -- explosive_shot,if=buff.bombardier.remains
  if S.ExplosiveShot:IsReady() and Target:TimeToDie() > 3 and Target:IsSpellInRange(S.ExplosiveShot) and (Player:BuffUp(S.BombardierBuff)) then
    if Cast(S.ExplosiveShot) then return "explosive_shot sentcleave 6"; end
  end
  -- wildfire_bomb,if=buff.tip_of_the_spear.stack>0&cooldown.wildfire_bomb.charges_fractional>1.7|cooldown.wildfire_bomb.charges_fractional>1.9|cooldown.coordinated_assault.remains<2*gcd
  if S.WildfireBomb:IsReady() and Target:IsSpellInRange(S.WildfireBomb) and (Player:BuffUp(S.TipoftheSpearBuff) and S.WildfireBomb:ChargesFractional() > 1.7 or S.WildfireBomb:ChargesFractional() > 1.9 or S.CoordinatedAssault:CooldownRemains() < 2 * Player:GCD()) then
    if Cast(S.WildfireBomb) then return "wildfire_bomb sentcleave 8"; end
  end
  -- coordinated_assault,if=!talent.bombardier|talent.bombardier&cooldown.wildfire_bomb.charges_fractional<1
  if S.CoordinatedAssault:IsCastable() and DoNotJumpOn() and CoordinatedAssaultSetting and Target:IsSpellInRange(S.CoordinatedAssault) and (not S.Bombardier:IsAvailable() or S.Bombardier:IsAvailable() and S.WildfireBomb:ChargesFractional() < 1) then
    if Cast(S.CoordinatedAssault) then return "coordinated_assault sentcleave 10"; end
  end
  -- flanking_strike,if=buff.tip_of_the_spear.stack=2|buff.tip_of_the_spear.stack=1
  if S.FlankingStrike:IsCastable() and Target:IsSpellInRange(S.FlankingStrike)  and FlankingStrikeSetting and DoNotJumpOn() and (Player:BuffStack(S.TipoftheSpearBuff) == 2 or Player:BuffStack(S.TipoftheSpearBuff) == 1) then
    if Cast(S.FlankingStrike) then return "flanking_strike sentcleave 12"; end
  end
  -- explosive_shot,if=(buff.tip_of_the_spear.stack>0|buff.bombardier.remains)&((cooldown.coordinated_assault.remains>20&(cooldown.coordinated_assault.remains<80|buff.coordinated_assault.remains))|(cooldown.coordinated_assault.remains>12&cooldown.coordinated_assault.remains<20))|cooldown.coordinated_assault.remains<2
  if S.ExplosiveShot:IsReady() and Target:TimeToDie() > 3 and Target:IsSpellInRange(S.ExplosiveShot) and ((Player:BuffUp(S.TipoftheSpearBuff) or Player:BuffUp(S.BombardierBuff)) and ((S.CoordinatedAssault:CooldownRemains() > 20 and (S.CoordinatedAssault:CooldownRemains() < 80 or Player:BuffUp(S.CoordinatedAssaultBuff))) or (S.CoordinatedAssault:CooldownRemains() > 12 and S.CoordinatedAssault:CooldownRemains() < 20)) or S.CoordinatedAssault:CooldownRemains() < 2) then
    if Cast(S.ExplosiveShot) then return "explosive_shot sentcleave 14"; end
  end
  -- fury_of_the_eagle,if=buff.tip_of_the_spear.stack>0
  if S.FuryoftheEagle:IsCastable() and FuryoftheEagleSetting and Target:IsInMeleeRange(5) and (Player:BuffUp(S.TipoftheSpearBuff)) then
    if Cast(S.FuryoftheEagle) then return "fury_of_the_eagle sentcleave 16"; end
  end
  -- kill_shot,if=buff.sic_em.remains&active_enemies<4
  if S.KillShot:IsReady() and Target:IsSpellInRange(S.KillShot) and (Player:BuffUp(S.TipoftheSpearBuff) or S.SicEm:IsAvailable()) then
    if Everyone.CastCycle(S.KillShot, EnemyRangeList, KSHPTheshhold, 40) then return "kill_shot sentcleave 18"; end
  end
  -- kill_command,target_if=min:bloodseeker.remains,if=focus+cast_regen<focus.max
  if S.KillCommand:IsCastable() and Target:IsSpellInRange(S.KillCommand) and (CheckFocusCap(S.KillCommand:ExecuteTime(), 15)) then
    if Cast(S.KillCommand) then -- if Everyone.CastCycle(S.KillCommand, EnemyRangeList, EvaluateTargetIfFilterBloodseekerRemains, 40) then
      return
      "kill_command sentcleave 20";
    end
  end
  -- wildfire_bomb,if=buff.tip_of_the_spear.stack>0
  if S.WildfireBomb:IsReady() and Target:IsSpellInRange(S.WildfireBomb) and (Player:BuffUp(S.TipoftheSpearBuff)) then
    if Cast(S.WildfireBomb) then return "wildfire_bomb sentcleave 22"; end
  end
  -- raptor_bite,if=buff.merciless_blows.up
  if MBRS:IsReady() and Target:IsInMeleeRange(MBRSRange) and (Player:BuffUp(S.MercilessBlowsBuff)) then
    if Cast(S.RaptorStrikeCast) then return MBRS:Name() .. " sentcleave 24"; end
  end
  -- butchery
  if S.Butchery:IsReady() and Target:IsInMeleeRange(5) then
    if Cast(S.Butchery) then return "butchery sentcleave 26"; end
  end
  -- kill_shot
  if S.KillShot:IsReady() and Target:IsSpellInRange(S.KillShot) then
    if Everyone.CastCycle(S.KillShot, EnemyRangeList, KSHPTheshhold, 40) then return "kill_shot sentcleave 28"; end
  end
  -- raptor_bite
  if MBRS:IsReady() and Target:IsInMeleeRange(MBRSRange) then
    if Cast(S.RaptorStrikeCast) then return MBRS:Name() .. " sentcleave 30"; end
  end
end

local function APL()
  if Player:IsChanneling(I.ManicGrieftorch.ItemUseSpell) then
    return "Dont cut Torch"
  end
  --[[if not MainHandWeaponIsValid then
    HR.CastAnnotated(S.WrongWeapon, false, "WRONG WEAPON")
    return "Main hand weapon subtype is not valid"
  end]]
  SmallCDToggle = HR.ToggleIconFrame:GetToggle(1)
  TabToggle = HR.ToggleIconFrame:GetToggle(2)
  InterruptToggle = HR.ToggleIconFrame:GetToggle(3)

  -- Target Count Checking
  local EagleUp = Player:BuffUp(S.AspectoftheEagle)
  local AddedRange = S.Lunge:IsAvailable() and 3 or 0
  Enemies40y = Player:GetEnemiesInRange(40)
  MBRSRange = EagleUp and 40 or 5
  MBRS = S.MongooseBite:IsLearned() and S.MongooseBite or S.RaptorStrike
  if AoEON() then
    if EagleUp and not Target:IsInMeleeRange(8) then
      EnemyList = Player:GetEnemiesInRange(40)
      EnemyCount = Target:GetEnemiesInSplashRangeCount(8)
    else
      EnemyList = Player:GetEnemiesInRange(8)
      EnemyCount = #EnemyList
    end
  else
    EnemyCount = 1
  end
  EnemyRangeList = Player:GetEnemiesInRange(40, S.KillCommand)
  if EagleUp then
    EnemyList = Player:GetEnemiesInRange(40, S.KillCommand)
  else
    EnemyList = Player:GetEnemiesInRange(8, S.RaptorStrike)
  end
  RacialsSetting = SpellProperties(Settings.Survival.RacialsSetting)

  PotionSetting = SpellProperties(Settings.Survival.PotionSetting) and not Everyone.ISSolo()

  FuryoftheEagleSetting = SpellProperties(Settings.Survival.FuryoftheEagleSetting)
  SpearheadSetting = SpellProperties(Settings.Survival.SpearheadSetting)
  CoordinatedAssaultSetting = SpellProperties(Settings.Survival.CoordinatedAssaultSetting)
  DjaruunSetting = SpellProperties(Settings.Survival.DjaruunSetting) and TTDCheckForCDs(10)
  FlankingStrikeSetting = SpellProperties(Settings.Survival.FlankingStrikeSetting)
  KillShotTab = Settings.Commons.KillShot and TabToggle
  KillCommandTab = Settings.Survival.KillCommand and TabToggle
  lunarStormTimer = LunarStormTimer()

  if Everyone.TargetIsValid() or Player:AffectingCombat() then
    -- Calculate fight_remains
    BossFightRemains = HL.BossFightRemains()
    IsBossfight = true
    FightRemains = BossFightRemains
    if FightRemains == 11111 then
      IsBossfight = false
      FightRemains = HL.FightRemains(EnemyList, false)
    end
  end
  if (Player:DebuffUp(S.FreezeTagFixation) and S.FreezingTrap:IsCastable()) then
    if Cast(S.FreezingTrap) then return "Freezing Trap on Fixate"; end
  end
  -- Pet Management; Conditions handled via override
  if not (Player:IsMounted() or Player:IsInVehicle()) then
    if S.SummonPet:IsCastable() and not IsFalling() and Settings.Pet.SummonPetSlot > 0 and (Settings.Pet.WhenSummonPet == "Always" or (Settings.Pet.WhenSummonPet == "In combat" and Player:AffectingCombat() or Settings.Pet.WhenSummonPet == "Out of combat" and not Player:AffectingCombat())) then      if Cast(SummonPetSpells[Settings.Pet.SummonPetSlot]) then return "Summon Pet"; end
    end
    if S.RevivePet:IsCastable() and not Player:IsMoving() then
      if Cast(S.RevivePet, false) then return "Revive Pet"; end
    end
    if S.MendPet:IsCastable() then
      if Cast(S.MendPet, false) then return "Mend Pet"; end
    end
  end
  -- Defensives
  -- Exhilaration
  if Player:AffectingCombat() then
    if S.Exhilaration:IsCastable() and Player:HealthPercentage() <= Settings.Defensives.ExhilarationHP then
      if Cast(S.Exhilaration, false) then return "Exhilaration"; end
    end
    if S.SurvivalOfTheFittest:IsCastable() and Player:BuffDown(S.SurvivalOfTheFittest) and Player:HealthPercentage() <= Settings.Defensives.SurvivalOfTheFittestHP then
      if Cast(S.SurvivalOfTheFittest, false) then return "Survival of the Fittest"; end
    end
    if S.AspectOfTheTurtle:IsCastable() and Player:HealthPercentage() <= Settings.Defensives.AspectOfTheTurtleHP then
      if Cast(S.AspectOfTheTurtle, false) then return "Survival of the Fittest"; end
    end
    if (Settings.Defensives.FeignDeathOnSpell and Player:IncomingSpell(FeignDeathList) or Player:HealthPercentage() <= Settings.Defensives.FeignDeathHP) then
      if S.FeignDeath:IsCastable() then
        if Cast(S.FeignDeath, false) then return "Feign Death"; end
      end
      if HR.CastAnnotated(S.PoolFocus, false, "Wait in Feign Death") then return "Wait in Feign Death"; end
    end
    if S.FortitudeOfTheBear:IsCastable() and Player:HealthPercentage() <= Settings.Defensives.FortitudeOfTheBearHP then
      if Cast(S.FortitudeOfTheBear, false) then return "Fortitude of the Bear"; end
    end
  end
  if CombatCheck() then
    if (Settings.Commons.UseMisdirection == "Always" or                                      -- Always misdirect
          (Settings.Commons.UseMisdirection == "On Combat Start" and HL.CombatTime() < 5) or -- On Combat Start condition
          (Settings.Commons.UseMisdirection == "Solo" and Everyone.ISSolo()) or              -- Solo condition
          (Settings.Commons.UseMisdirection == "On AoE" and AoEON() and EnemyCount > 2)      -- AoE
        ) and
        Everyone.TargetIsValid() and
        S.Misdirection:IsCastable() and
        Unit.Focus:Exists() and
        Unit.Focus:UnitIsFriend() and
        not Unit.Focus:IsDeadOrGhost() and
        Unit.Focus:IsSpellInRange(S.Misdirection) and
        Player:BuffDown(S.Misdirection) and
        (
          (Unit.Focus:Role() == "TANK") or                   -- Focus is tank
          (UnitIsUnit("focus", "pet") and Everyone.ISSolo()) -- Focus is pet in solo scenario
        )
    then
      HR.CastTarget(S.Misdirection, HR.TName().FOCUS)
      return "Misdirection"
    end
    --Hunters Mark
    if S.HuntersMark:IsCastable() and Target:DebuffDown(S.HuntersMark, true) and Everyone.TargetIsValid() and not (Settings.Commons.HuntersMark == "Not Used") and (Settings.Commons.HuntersMark == "On Bosses" and (IsBossfight or Target:IsBoss()) or Settings.Commons.HuntersMark == "Always") and Target:IsInRange(60) and S.HuntersMark:TimeSinceLastCast() > 5 and Target:HealthPercentage() > 80 then
      if Cast(S.HuntersMark) then return "Hunters Mark"; end
    end
    if InterruptToggle then
      if Settings.Commons.ImplosiveTrap then
      ShouldReturn = Everyone.InterruptCycle(S.ImplosiveTrap, 5, false, nil, true, true); if ShouldReturn then
        if HR.CastTarget(S.ImplosiveTrap, HR.TName().PLAYER) then return "HighExplosiveTrap Player"; end
      end
    end
    if Settings.Commons.HighExplosiveTrap then
      ShouldReturn = Everyone.InterruptCycle(S.HighExplosiveTrap, 5, false, nil, true, true); if ShouldReturn then
        if S.BindingShot:IsCastable() then
          if HR.CastTarget(S.BindingShot, HR.TName().PLAYER) then return "Binding Shot Player"; end
          if HR.CastTarget(S.HighExplosiveTrap, HR.TName().PLAYER) then return "HighExplosiveTrap Player"; end
        end
      end
    end
      if Settings.Commons.BurstingShot then
        ShouldReturn = Everyone.InterruptCycle(S.BurstingShot, 5, false, nil, true, true); if ShouldReturn then
          return
              ShouldReturn;
        end
      end
      ShouldReturn = Everyone.InterruptCycle(S.ScatterShot, 40, false, nil, true); if ShouldReturn then
        return
            ShouldReturn;
      end
      -- muzzle
      ShouldReturn = Everyone.InterruptCycle(S.Muzzle, 5, true, nil, false); if ShouldReturn then
        return
            ShouldReturn;
      end
      --stun
      ShouldReturn = Everyone.InterruptCycle(S.Intimidation, 40, false, nil, true); if ShouldReturn then
        return
            ShouldReturn;
      end
    end
    ShouldReturn = Everyone.PurgeCycle(S.TranquilizingShot, 40, false, Settings.Commons.TabForTranquilizingShot); if ShouldReturn then
      return
          ShouldReturn;
    end
    ShouldReturn = Everyone.SootheCycle(S.TranquilizingShot, 40, false, Settings.Commons.TabForTranquilizingShot); if ShouldReturn then
      return
          ShouldReturn;
    end
    -- auto_attack
    -- invoke_external_buff,name=power_infusion,if=buff.coordinated_assault.up|buff.spearhead.up|!talent.coordinated_assault&!talent.spearhead
    -- Note: Not handling external buffs.
    -- Manually added: If out of range, use Aspect of the Eagle, otherwise Harpoon to get back into range
    if not EagleUp and not Target:IsInMeleeRange(8) and Settings.Survival.AspectoftheEagle then
      if S.AspectoftheEagle:IsCastable() then
        if Cast(S.AspectoftheEagle, false) then return "aspect_of_the_eagle oor"; end
      end
      if S.Harpoon:IsCastable() and DoNotJumpOn() and Target:IsSpellInRange(S.Harpoon) and Settings.Survival.UseHarpoon then
        if Cast(S.Harpoon) then
          return
          "harpoon oor";
        end
      end
    end
    -- call_action_list,name=cds
      ShouldReturn = CDs(); if ShouldReturn then return ShouldReturn; end
    -- call_action_list,name=plst,if=active_enemies<3&talent.vicious_hunt
    if EnemyCount < 3 and S.ViciousHunt:IsAvailable() then
      local ShouldReturn = PLST(); if ShouldReturn then return ShouldReturn; end
    end
    -- call_action_list,name=plcleave,if=active_enemies>2&talent.vicious_hunt
    if EnemyCount > 2 and S.ViciousHunt:IsAvailable() then
      local ShouldReturn = PLCleave(); if ShouldReturn then return ShouldReturn; end
    end
    -- call_action_list,name=sentst,if=active_enemies<3&!talent.vicious_hunt
    if EnemyCount < 3 and not S.ViciousHunt:IsAvailable() then
      local ShouldReturn = SentST(); if ShouldReturn then return ShouldReturn; end
    end
    -- call_action_list,name=sentcleave,if=active_enemies>2&!talent.vicious_hunt
    if EnemyCount > 2 and not S.ViciousHunt:IsAvailable() then
      local ShouldReturn = SentCleave(); if ShouldReturn then return ShouldReturn; end
    end
    -- arcane_torrent
    if S.ArcaneTorrent:IsCastable() and Target:IsInRange(8) and RacialsSetting then
      if Cast(S.ArcaneTorrentCast) then return "arcane_torrent main"; end
    end
    if S.BagofTricks:IsCastable() and RacialsSetting and Target:IsSpellInRange(S.BagofTricks) and TTDCheckForCDs(Settings.TTD.RacialsTTD) then
      if Cast(S.BagofTricks) then return "bag_of_tricks main"; end
    end
    -- PoolFocus if nothing else to do
    if HR.CastAnnotated(S.PoolFocus, false, "WAIT") then return "Pooling Focus"; end
  end
end

local function OnInit()
  S.SerpentStingDebuff:RegisterAuraTracking()
  Settings.Survival.Display()
  HR:UpdateMacro("macro1", "/use 16")
  HR.Print("Survival Hunter rotation has been updated for patch 11.0.2.")
end

HR.SetAPL(255, APL, OnInit)
