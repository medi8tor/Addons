--- ============================ HEADER ============================
--- ======= LOCALIZE =======
-- Addon
local addonName, addonTable = ...
-- HeroDBC
local DBC                   = HeroDBC.DBC
-- HeroLib
local HL                    = HeroLib
local Cache                 = HeroCache
local Unit                  = HL.Unit
local Player                = Unit.Player
local Pet                   = Unit.Pet
local Target                = Unit.Target
local Spell                 = HL.Spell
local MultiSpell            = HL.MultiSpell
local Item                  = HL.Item
-- HeroRotation
local HR                    = HeroRotation()
local AoEON                 = HR.AoEON
local CDsON                 = HR.CDsON
local Cast                  = HR.Cast
local CastPooling           = HR.CastPooling
local Mouseover             = Unit.MouseOver
-- Num/Bool Helper Functions
local num                   = HR.Commons().Everyone.num
local bool                  = HR.Commons().Everyone.bool
-- lua
local mathfloor             = math.floor
local Delay                 = C_Timer.After
local ShouldReturn
--- ============================ CONTENT ============================
--- ======= APL LOCALS =======
-- Commons
local Everyone              = HR.Commons().Everyone

-- GUI Settings
local GUISettings           = HR.GUISettingsGet()
local Settings              = {
  General = GUISettings.General,
  Commons = GUISettings.APL.Druid.Commons,
  Feral = GUISettings.APL.Druid.Feral,
  Feral_Defensives = GUISettings.APL.Druid.Feral.Defensives,
  Feral_TTD = GUISettings.APL.Druid.Feral_TTD,
  Feral_CDUSE = GUISettings.APL.Druid.Feral_CDUSE,
}
-- Spells
local S                     = Spell.Druid.Feral

-- Items
local I                     = Item.Druid.Feral
local OnUseExcludes         = {
  I.ImperfectAscendancySerum:ID(),
}

--- ===== Rotation Variables =====
local Trinket1, Trinket2
local VarTrinket1ID, VarTrinket2ID
local VarTrinket1Spell, VarTrinket2Spell
local VarTrinket1Range, VarTrinket2Range
local VarTrinket1CastTime, VarTrinket2CastTime
local VarTrinket1CD, VarTrinket2CD
local VarTrinket1BL, VarTrinket2BL
local VarTrinket1Buffs, VarTrinket2Buffs
local VarTrinket1Duration, VarTrinket2Duration
local VarTrinket1Sync, VarTrinket2Sync
local VarTrinketPriority
local VarProccingBT
local VarEffectiveEnergy, VarTimeToPool, VarNeedBT
local VarLastConvoke, VarLastZerk, VarLastPotion
local VarZerkBiteweave, VarRegrowth, VarMoonfireSnapshotted
local ComboPoints, ComboPointsDeficit
local BsInc                 = S.Incarnation:IsAvailable() and S.Incarnation or S.Berserk
local IsInMeleeRange, IsInAoERange
local BossFightRemains      = 11111
local FightRemains          = 11111
local EnemiesMelee, EnemiesCountMelee
local Enemies8y, EnemiesCount8y, EnemiesCount20y

--- ===== Trinket Variables =====
local VarTrinketFailures    = 0
local function SetTrinketVariables()
  local T1, T2 = Player:GetTrinketData(OnUseExcludes)

  -- If we don't have trinket items, try again in 2 seconds.
  if VarTrinketFailures < 5 and ((T1.ID == 0 or T2.ID == 0) or (T1.SpellID > 0 and not T1.Usable or T2.SpellID > 0 and not T2.Usable)) then
    VarTrinketFailures = VarTrinketFailures + 1
    Delay(5, function()
      SetTrinketVariables()
    end
    )
    return
  end

  Trinket1 = T1.Object
  Trinket2 = T2.Object

  VarTrinket1ID = Trinket1:ID()
  VarTrinket2ID = Trinket2:ID()

  VarTrinket1Spell = T1.Spell
  VarTrinket1Range = T1.Range
  VarTrinket1CastTime = T1.CastTime
  VarTrinket2Spell = T2.Spell
  VarTrinket2Range = T2.Range
  VarTrinket2CastTime = T2.CastTime

  VarTrinket1CD = T1.Cooldown
  VarTrinket2CD = T2.Cooldown

  VarTrinket1BL = T1.Blacklisted
  VarTrinket2BL = T2.Blacklisted

  VarTrinket1Buffs = Trinket1:HasUseBuff() and VarTrinket1ID ~= I.ImperfectAscendancySerum:ID() and
      VarTrinket1ID ~= I.OvinaxsMercurialEgg:ID() and VarTrinket1ID ~= I.ConcoctionKissofDeath:ID()
  VarTrinket2Buffs = Trinket2:HasUseBuff() and VarTrinket2ID ~= I.ImperfectAscendancySerum:ID() and
      VarTrinket2ID ~= I.OvinaxsMercurialEgg:ID() and VarTrinket2ID ~= I.ConcoctionKissofDeath:ID()

  -- Note: Using value >0 to avoid divide by zero errors.
  VarTrinket1Duration = (Trinket1:BuffDuration() > 0) and Trinket1:BuffDuration() or 1
  VarTrinket2Duration = (Trinket2:BuffDuration() > 0) and Trinket2:BuffDuration() or 1

  VarTrinket1Sync = 0.5
  if (S.ConvoketheSpirits:IsAvailable() and not S.AshamanesGuidance:IsAvailable() and VarTrinket1Buffs and (VarTrinket1CD % 120 == 0 or 120 % VarTrinket1CD == 0)) or (not (S.ConvoketheSpirits:IsAvailable() and not S.AshamanesGuidance:IsAvailable()) and VarTrinket1Buffs and (VarTrinket1CD % 180 == 0 or 180 % VarTrinket1CD == 0 or VarTrinket1CD % 120 == 0 or 120 % VarTrinket1CD == 0)) then
    VarTrinket1Sync = 1
  end
  VarTrinket2Sync = 0.5
  if (S.ConvoketheSpirits:IsAvailable() and not S.AshamanesGuidance:IsAvailable() and VarTrinket2Buffs and (VarTrinket2CD % 120 == 0 or 120 % VarTrinket2CD == 0)) or (not (S.ConvoketheSpirits:IsAvailable() and not S.AshamanesGuidance:IsAvailable()) and VarTrinket2Buffs and (VarTrinket2CD % 180 == 0 or 180 % VarTrinket2CD == 0 or VarTrinket2CD % 120 == 0 or 120 % VarTrinket2CD == 0)) then
    VarTrinket2Sync = 1
  end

  VarTrinketPriority = 1
  if not VarTrinket1Buffs and VarTrinket2Buffs or VarTrinket2Buffs and ((VarTrinket2CD / VarTrinket2Duration) * (VarTrinket2Sync)) > ((VarTrinket1CD / VarTrinket1Duration) * (VarTrinket1Sync)) then
    VarTrinketPriority = 2
  end
end
SetTrinketVariables()

--- ===== Stun Interrupts List =====
local InterruptStuns = {
  { S.MightyBash, "Cast Mighty Bash (Interrupt)", function() return true; end },
}

--- ===== Event Registration =====
HL:RegisterForEvent(function()
  BsInc = S.Incarnation:IsAvailable() and S.Incarnation or S.Berserk
end, "SPELLS_CHANGED", "LEARNED_SPELL_IN_TAB")

HL:RegisterForEvent(function()
  VarTrinketFailures = 0
  SetTrinketVariables()
end, "PLAYER_EQUIPMENT_CHANGED")

HL:RegisterForEvent(function()
  BossFightRemains = 11111
  FightRemains = 11111
end, "PLAYER_REGEN_ENABLED")

HL:RegisterForEvent(function()
  S.AdaptiveSwarm:RegisterInFlightEffect(391889)
  S.AdaptiveSwarm:RegisterInFlight()
end, "LEARNED_SPELL_IN_TAB")
S.AdaptiveSwarm:RegisterInFlightEffect(391889)
S.AdaptiveSwarm:RegisterInFlight()

--- ===== PMultiplier Registrations =====
local function ComputeRakePMultiplier()
  return Player:StealthUp(true, true) and 1.6 or 1
end
S.Rake:RegisterPMultiplier(S.RakeDebuff, ComputeRakePMultiplier)

local function ComputeRipPMultiplier()
  local Mult = 1
  Mult = Player:BuffUp(S.BloodtalonsBuff) and Mult * 1.25 or Mult
  Mult = S.DreadfulBleeding:IsAvailable() and Mult * 1.2 or Mult
  Mult = Player:HasTier("TWW1", 4) and Mult * 1.08 or Mult
  Mult = S.LionsStrength:IsAvailable() and Mult * 1.15 or Mult
  Mult = Player:BuffUp(S.TigersFury) and Mult * 1.15 or Mult
  return Mult
end
S.Rip:RegisterPMultiplier(S.RipDebuff, ComputeRipPMultiplier)

--- ===== Helper Functions =====
local BtTriggers = {
  S.Rake,
  S.LIMoonfire,
  S.ThrashCat,
  S.BrutalSlash,
  S.Swipe,
  S.Shred,
  S.FeralFrenzy,
}

local function DebuffRefreshAny(Enemies, Spell)
  for _, Enemy in pairs(Enemies) do
    if Enemy:DebuffRefreshable(Spell) then
      return true
    end
  end
  return false
end

local function BTBuffUp(Trigger)
  if not S.Bloodtalons:IsAvailable() then return false end
  return Trigger:TimeSinceLastCast() < math.min(5, S.BloodtalonsBuff:TimeSinceLastAppliedOnPlayer())
end

local function BTBuffDown(Trigger)
  return not BTBuffUp(Trigger)
end

local function CountActiveBtTriggers()
  local ActiveTriggers = 0
  for i = 1, #BtTriggers do
    if BTBuffUp(BtTriggers[i]) then ActiveTriggers = ActiveTriggers + 1 end
  end
  return ActiveTriggers
end

local function TicksGainedOnRefresh(Spell, Tar)
  if not Tar then Tar = Target end
  local AddedDuration = 0
  local MaxDuration = 0
  -- Added TickTime variable, as Rake and Moonfire don't have tick times in DBC
  local TickTime = 0
  if Spell == S.RipDebuff then
    AddedDuration = (4 + ComboPoints * 4)
    MaxDuration = 31.2
    TickTime = Spell:TickTime()
  else
    AddedDuration = Spell:BaseDuration()
    MaxDuration = Spell:MaxDuration()
    TickTime = Spell:TickTime()
  end

  local OldTicks = Tar:DebuffTicksRemain(Spell)
  local OldTime = Tar:DebuffRemains(Spell)
  local NewTime = AddedDuration + OldTime
  if NewTime > MaxDuration then NewTime = MaxDuration end
  local NewTicks = NewTime / TickTime
  if not OldTicks then OldTicks = 0 end
  local TicksAdded = NewTicks - OldTicks
  return TicksAdded
end

local function HighestTTD(enemies)
  if not enemies then return 0 end
  local HighTTD = 0
  local HighTTDTar = nil
  for _, enemy in pairs(enemies) do
    local TTD = enemy:TimeToDie()
    if TTD > HighTTD then
      HighTTD = TTD
      HighTTDTar = enemy
    end
  end
  return HighTTD, HighTTDTar
end

--- ===== CastTargetIf Filter Functions =====
local function EvaluateTargetIfFilterAdaptiveSwarm(TargetUnit)
  -- target_if=max:(1+dot.adaptive_swarm_damage.stack)*dot.adaptive_swarm_damage.stack<3*time_to_die
  return (1 + TargetUnit:DebuffStack(S.AdaptiveSwarmDebuff)) * num(TargetUnit:DebuffStack(S.AdaptiveSwarmDebuff) < 3) *
      TargetUnit:TimeToDie()
end

local function EvaluateTargetIfFilterBloodseeker(TargetUnit)
  -- target_if=max:dot.bloodseeker_vines.ticking
  return TargetUnit:DebuffRemains(S.BloodseekerVinesDebuff)
end

local function EvaluateTargetIfFilterLIMoonfire(TargetUnit)
  -- target_if=max:ticks_gained_on_refresh
  return TicksGainedOnRefresh(S.LIMoonfireDebuff, TargetUnit)
end

local function EvaluateTargetIfFilterRakeAoEBuilder(TargetUnit)
  -- target_if=max:ticks_gained_on_refresh
  return TicksGainedOnRefresh(S.RakeDebuff, TargetUnit)
end

local function EvaluateTargetIfFilterRakeMain(TargetUnit)
  -- target_if=max:refreshable+(persistent_multiplier>dot.rake.pmultiplier)
  return num(TargetUnit:DebuffRefreshable(S.RakeDebuff)) +
      num(Player:PMultiplier(S.Rake) > TargetUnit:PMultiplier(S.Rake))
end

local function EvaluateTargetIfFilterTTD(TargetUnit)
  -- target_if=min:target.time_to_die
  return TargetUnit:TimeToDie()
end

--- ===== CastTargetIf Condition Functions =====
local function EvaluateTargetIfAdaptiveSwarm(TargetUnit)
  -- if=buff.cat_form.up&dot.adaptive_swarm_damage.stack<3&talent.unbridled_swarm.enabled&spell_targets.swipe_cat>1&dot.rip.ticking
  -- Note: Everything but stack count and rip check handled before CastTargetIf call
  return TargetUnit:DebuffStack(S.AdaptiveSwarmDebuff) < 3 and TargetUnit:DebuffUp(S.RipDebuff)
end

local function EvaluateTargetIfBrutalSlashAoeBuilder(TargetUnit)
  -- if=!(variable.need_bt&buff.bt_swipe.up)&(cooldown.brutal_slash.full_recharge_time<4|time_to_die<4|raid_event.adds.remains<4)
  return not (VarNeedBT or BTBuffUp(S.Swipe)) and
      (S.BrutalSlash:FullRechargeTime() < 4 or TargetUnit:TimeToDie() < 4 or FightRemains < 4)
end

local function EvaluateTargetIfLIMoonfireRefreshable(TargetUnit)
  -- if=refreshable
  return TargetUnit:DebuffRefreshable(S.LIMoonfireDebuff)
end

local function EvaluateTargetIfPrimalWrath(TargetUnit)
  -- if=spell_targets.primal_wrath>1&((dot.primal_wrath.remains<6.5&!buff.bs_inc.up|dot.primal_wrath.refreshable)|(!talent.rampant_ferocity.enabled&(spell_targets.primal_wrath>1&!dot.bloodseeker_vines.ticking&!buff.ravage.up|spell_targets.primal_wrath>6+talent.ravage)))
  return (TargetUnit:DebuffRemains(S.RipDebuff) < 6.5 and Player:BuffDown(BsInc) or TargetUnit:DebuffRefreshable(S.RipDebuff)) or
      (not S.RampantFerocity:IsAvailable() and (EnemiesCount8y > 1 and TargetUnit:DebuffDown(S.BloodseekerVinesDebuff) and Player:BuffDown(S.RavageBuffFeral) or EnemiesCount8y > 6 + num(S.Ravage:IsAvailable())))
end

local function EvaluateTargetIfRakeRefreshable(TargetUnit)
  -- if=refreshable
  return TargetUnit:DebuffRefreshable(S.RakeDebuff)
end

--- ===== CastCycle Condition Functions =====
local function EvaluateCycleAdaptiveSwarm(TargetUnit)
  -- target_if=dot.adaptive_swarm_damage.stack<3&(!dot.adaptive_swarm_damage.ticking|dot.adaptive_swarm_damage.remains<2),if=!action.adaptive_swarm_damage.in_flight&(spell_targets=1|!talent.unbridled_swarm)&(dot.rip.ticking|hero_tree.druid_of_the_claw)
  return (TargetUnit:DebuffStack(S.AdaptiveSwarmDebuff) < 3 and (TargetUnit:DebuffDown(S.AdaptiveSwarmDebuff) or TargetUnit:DebuffRemains(S.AdaptiveSwarmDebuff) < 2)) and
      (TargetUnit:DebuffUp(S.RipDebuff) or Player:HeroTreeID() == 21)
end

local function EvaluateCycleMoonfire(TargetUnit)
  -- target_if=refreshable
  return TargetUnit:DebuffRefreshable(S.LIMoonfireDebuff)
end

local function EvaluateCycleRake(TargetUnit)
  -- target_if=!dot.rake.ticking
  return TargetUnit:DebuffDown(S.RakeDebuff)
end

local function EvaluateCycleRakeRefreshable(TargetUnit)
  -- target_if=refreshable
  return TargetUnit:DebuffRefreshable(S.RakeDebuff)
end

local function EvaluateCycleRakeAoeBuilder(TargetUnit)
  -- target_if=dot.rake.pmultiplier<1.6
  return TargetUnit:PMultiplier(S.Rake) < 1.6
end

local function EvaluateCycleRip(TargetUnit)
  -- target_if=refreshable
  return TargetUnit:DebuffRefreshable(S.RipDebuff)
end

local function EvaluateCycleRip2(TargetUnit)
  -- target_if=refreshable,if=(!talent.primal_wrath|spell_targets=1)&(buff.bloodtalons.up|!talent.bloodtalons)&(buff.tigers_fury.up|dot.rip.remains<cooldown.tigers_fury.remains)&(remains<fight_remains|remains<4&buff.ravage.up)
  -- Note: (!talent.primal_wrath|spell_targets=1)&(buff.bloodtalons.up|!talent.bloodtalons) checked before CastCycle.
  return TargetUnit:DebuffRefreshable(S.RipDebuff) and
  (Player:BuffUp(S.TigersFury) or TargetUnit:DebuffRemains(S.RipDebuff) < S.TigersFury:CooldownRemains() or not IsTigersFury) and
  (TargetUnit:DebuffRemains(S.RipDebuff) < FightRemains or TargetUnit:DebuffRemains(S.RipDebuff) < 4 and Player:BuffUp(S.RavageBuffFeral))
end

local IsBossfight
local function TTDCheckForCDs(SettingsValue)
  return (IsBossfight and Settings.Feral_TTD.IgnoreWhenBoss) or Everyone.Buggedmobs[Target:NPCID()] or
      (Everyone.ISSolo() and Settings.Feral_TTD.IgnoreWhenSolo) or
      SettingsValue == 0 or FightRemains >= SettingsValue and FightRemains < 7777
end

local function SpellProperties(property)
  return property ~= "Not Used" and (
    (property == "with Cooldowns" or
      (property == "small CDs" and Settings.Feral_CDUSE.smallcdswithCooldowns) or
      property == "with Cooldowns or AoE" or
      property == "on Enemycount or Cooldowns" or
      property == "on Boss or with Cooldowns")
    and CDsON()
    or
    property == "always" or
    ((property == "on Boss only" or property == "on Boss or on Enemycount" or property == "on Boss or with Cooldowns") and (IsBossfight or Target:IsDummy())) or
    (property == "with Bloodlust only" and Player:BloodlustUp()) or
    (property == "small CDs" and Smallcds) or
    ((property == "on AOE" or property == "with Cooldowns or AoE") and EnemiesCount8y >= 2) or
    ((property == "on Enemycount or Cooldowns" or property == "on Enemycount" or property == "on Boss or on Enemycount") and EnemiesCount8y >= Settings.Feral_CDUSE.Enemycount)
  )
end

local function TorchIsReady()
  return I.ManicGrieftorch:IsEquipped() and
      (I.ManicGrieftorch:CooldownUp() or I.ManicGrieftorch:CooldownRemains() <= Player:GCDRemains())
end

local function PuzzleBoxIsReady()
  return I.AlgetharPuzzleBox:IsEquipped() and
      (I.AlgetharPuzzleBox:CooldownUp() or I.AlgetharPuzzleBox:CooldownRemains() <= Player:GCDRemains())
end

local function IncorporealBeing(TargetUnit)
  return (TargetUnit:NPCID() == 204560)
end

local function Destabilize(TargetUnit)
  return (TargetUnit:CastSpellID() == 408805)
end

local function Convoke()
  return Player:ChannelSpellID() == 391528
end

local function Defensives()
  if S.Regrowth:IsReady() and Player:BuffUp(S.PredatorySwiftnessBuff) and Player:HealthPercentage() <= Settings.Feral.Defensives.RegrowthHP and not Player:PrevGCDP(1, S.Regrowth) then
    if Cast(S.Regrowth) then return "regrowth"; end
  end
  if S.Renewal:IsCastable() and Player:AffectingCombat() and Player:HealthPercentage() <= Settings.Feral.Defensives.RenewalHP then
    if Cast(S.Renewal) then return "renewal"; end
  end
  if S.Barkskin:IsCastable() and Player:AffectingCombat() and (Player:HealthPercentage() <= Settings.Feral.Defensives.BarkskinHP) then
    if Cast(S.Barkskin) then return "barkskin"; end
  end
  if S.NaturesVigil:IsCastable() and Player:AffectingCombat() and not Convoke() and IsInMeleeRange and Settings.Feral.Defensives.NaturesVigilCount ~= 0 and not Settings.Feral.Defensives.NaturesVigilHP ~= 0 and Everyone.AoELogicWithCount(Settings.Feral.Defensives.NaturesVigilHP, Settings.Feral.Defensives.NaturesVigilCount, nil, UnitsIn40Yards) then
    if Cast(S.NaturesVigil) then return "NaturesVigil"; end
  end
  if S.Swiftmend:IsCastable() and Player:AffectingCombat() and (Player:HealthPercentage() <= Settings.Feral.Defensives.SwiftmendHP) then
    if Cast(S.Swiftmend) then return "Swiftmend"; end
  end
  if S.SurvivalInstincts:IsCastable() and Player:AffectingCombat() and (Player:HealthPercentage() <= Settings.Feral.Defensives.SurvivalInstinctsHP) then
    if Cast(S.SurvivalInstincts) then return "SurvivalInstincts"; end
  end
  if S.FrenziedRegeneration:IsCastable() and (Player:BuffUp(S.BearForm) or (S.EmpoweredShapeshifting:IsAvailable() and Player:Energy() >= 40)) and (Player:HealthPercentage() <= Settings.Feral.Defensives.FrenziedRegenerationHP) then
    if Cast(S.FrenziedRegeneration) then return "FrenziedRegeneration"; end
  end
  if S.Ironfur:IsCastable() and Player:BuffUp(S.BearForm) and Player:BuffDown(S.Ironfur) and Player:Rage() >= 40 and (Player:HealthPercentage() <= Settings.Feral.Defensives.IronfurHP) then
    if Cast(S.Ironfur) then return "Ironfur"; end
  end
  if S.BearForm:IsCastable() and Player:AffectingCombat() and Player:BuffUp(S.CatForm) and (Player:HealthPercentage() <= Settings.Feral.Defensives.BearFormHP) then
    if Cast(S.BearForm) then return "BearForm"; end
  end
  if S.CatForm:IsCastable() and Player:BuffUp(S.BearForm) and (Player:HealthPercentage() > Settings.Feral.Defensives.CatFormHP and Settings.Feral.Defensives.CatFormHP > 0) then
    if Cast(S.CatForm) then return "CatForm"; end
  end
end
-- APL Functions
local function Precombat()
  -- cat_form,if=!buff.cat_form.up
  if S.CatForm:IsCastable() and Player:BuffDown(S.TravelFormBuff) and Player:BuffDown(S.BearForm) then
    if Cast(S.CatForm) then return "cat_form precombat 2"; end
  end
  -- prowl,if=!buff.prowl.up
  if S.Prowl:IsReady() and ProwlToggle and Player:BuffDown(S.BearForm) and EnemiesCount20y > 1 then
    if Cast(S.Prowlcast, true) then return "prowl precombat 4"; end
  end
  -- Manually added: rake
  if S.Rake:IsReady() and IsInMeleeRange then
    if Cast(S.Rake) then return "rake precombat 8"; end
  end
end

local function Builder()
  -- variable,name=proccing_bt,op=set,value=variable.need_bt
  VarProccingBT = VarNeedBT
  -- prowl,if=gcd.remains=0&energy>=35&!buff.sudden_ambush.up&(dot.rake.refreshable|dot.rake.pmultiplier<1.4)*!(variable.need_bt&buff.bt_rake.up)&buff.tigers_fury.up&!buff.shadowmeld.up
  if S.Prowl:IsReady() and ProwlToggle and IsInMeleeRange and not Everyone.ISSolo() and not Player:StealthUp(false, true) and (Player:Energy() >= 35 and Player:BuffDown(S.SuddenAmbushBuff) and (Target:DebuffRefreshable(S.RakeDebuff) or Target:PMultiplier(S.Rake) < 1.4) * num(not (VarNeedBT and BTBuffUp(S.Rake))) and Player:BuffUp(S.TigersFury)) then
    if Cast(S.Prowlcast) then return "prowl builder 1"; end
  end
  -- shadowmeld,if=gcd.remains=0&energy>=35&!buff.sudden_ambush.up&(dot.rake.refreshable|dot.rake.pmultiplier<1.4)*!(variable.need_bt&buff.bt_rake.up)&buff.tigers_fury.up&!buff.prowl.up
  if S.Shadowmeld:IsCastable() and IsRacials and IsInMeleeRange and not Everyone.ISSolo() and not Player:StealthUp(false, true) and (Player:Energy() >= 35 and Player:BuffDown(S.SuddenAmbushBuff) and (Target:DebuffRefreshable(S.RakeDebuff) or Target:PMultiplier(S.Rake) < 1.4) and not (VarNeedBT and BTBuffUp(S.Rake)) and Player:BuffUp(S.TigersFury)) then
    if Cast(S.Shadowmeld, true) then return "shadowmeld builder 2"; end
  end
  -- rake,if=((refreshable&persistent_multiplier>=dot.rake.pmultiplier|dot.rake.remains<3.5)|buff.sudden_ambush.up&persistent_multiplier>dot.rake.pmultiplier)&!(variable.need_bt&buff.bt_rake.up)
  if S.Rake:IsReady() and IsInMeleeRange and (((Target:DebuffRefreshable(S.RakeDebuff) and Player:PMultiplier(S.Rake) >= Target:PMultiplier(S.Rake) or Target:DebuffRemains(S.RakeDebuff) < 3.5) or Player:BuffUp(S.SuddenAmbushBuff) and Player:PMultiplier(S.Rake) > Target:PMultiplier(S.Rake)) and not (VarNeedBT and BTBuffUp(S.Rake))) then
    if Cast(S.Rake) then return "rake builder 4"; end
  end
  -- brutal_slash,if=cooldown.brutal_slash.full_recharge_time<4&!(variable.need_bt&buff.bt_swipe.up)
  if S.BrutalSlash:IsReady() and IsInAoERange and (S.BrutalSlash:FullRechargeTime() < 4 and not (VarNeedBT and BTBuffUp(S.Swipe))) then
    if Cast(S.BrutalSlash) then return "brutal_slash builder 6"; end
  end
  -- moonfire_cat,if=refreshable
  if S.LIMoonfire:IsReady() and Target:IsInRange(40) and (Target:DebuffRefreshable(S.LIMoonfireDebuff)) then
    if Cast(S.LIMoonfire) then return "moonfire_cat builder 8"; end
  end
  -- thrash_cat,if=refreshable&!talent.thrashing_claws
  if S.ThrashCat:IsCastable() and IsInAoERange and (Target:DebuffRefreshable(S.ThrashCatDebuff) and not S.ThrashingClaws:IsAvailable()) then
    if Cast(S.Thrashcast) then return "thrash builder 10"; end
  end
  -- shred,if=buff.clearcasting.react&!(variable.need_bt&buff.bt_shred.up)
  if S.Shred:IsReady() and IsInMeleeRange and (Player:BuffUp(S.Clearcasting) and not (VarNeedBT and BTBuffUp(S.Shred))) then
    if Cast(S.Shred) then return "shred builder 12"; end
  end
  -- brutal_slash,if=!(variable.need_bt&buff.bt_swipe.up)
  if S.BrutalSlash:IsReady() and IsInAoERange and (not (VarNeedBT and BTBuffUp(S.Swipe))) then
    if Cast(S.BrutalSlash) then return "brutal_slash builder 14"; end
  end
  -- swipe_cat,if=talent.wild_slashes&!(variable.need_bt&buff.bt_swipe.up)
  if S.Swipe:IsReady() and IsInAoERange and (S.WildSlashes:IsAvailable() and not (VarNeedBT and BTBuffUp(S.Swipe))) then
    if Cast(S.Swipecast) then return "swipe builder 16"; end
  end
  -- moonfire_cat,if=!(variable.need_bt&buff.bt_moonfire.up)&!(variable.moonfire_snapshotted&buff.tigers_fury.down)
  if S.LIMoonfire:IsReady() and Target:IsInRange(40) and (not (VarNeedBT and BTBuffUp(S.LIMoonfire)) and not (VarMoonfireSnapshotted and Player:BuffDown(S.TigersFury))) then
    if Cast(S.LIMoonfire) then return "moonfire_cat builder 17"; end
  end
  -- shred,if=!(variable.need_bt&buff.bt_shred.up)
  if S.Shred:IsReady() and IsInMeleeRange and (not (VarNeedBT and BTBuffUp(S.Shred))) then
    if Cast(S.Shred) then return "shred builder 18"; end
  end
  -- swipe_cat,if=variable.need_bt&buff.bt_swipe.down
  if S.Swipe:IsReady() and IsInAoERange and (VarNeedBT and BTBuffDown(S.Swipe)) then
    if Cast(S.Swipecast) then return "swipe builder 20"; end
  end
  -- rake,if=variable.need_bt&buff.bt_rake.down&persistent_multiplier>=dot.rake.pmultiplier
  if S.Rake:IsReady() and IsInMeleeRange and (VarNeedBT and BTBuffDown(S.Rake) and Player:PMultiplier(S.Rake) >= Target:PMultiplier(S.Rake)) then
    if Cast(S.Rake) then return "rake builder 22"; end
  end
  -- moonfire_cat,if=variable.need_bt&buff.bt_moonfire.down
  if S.LIMoonfire:IsReady() and Target:IsInRange(40) and (VarNeedBT and BTBuffDown(S.LIMoonfire)) then
    if Cast(S.LIMoonfire) then return "moonfire_cat builder 24"; end
  end
  -- thrash_cat,if=variable.need_bt&buff.bt_thrash.down
  if S.ThrashCat:IsCastable() and IsInAoERange and (VarNeedBT and BTBuffDown(S.ThrashCat)) then
    if Cast(S.Thrashcast) then return "thrash builder 26"; end
  end
end

local function Finisher()
  -- primal_wrath,target_if=max:dot.bloodseeker_vines.ticking,if=spell_targets.primal_wrath>1&((dot.primal_wrath.remains<6.5&!buff.bs_inc.up|dot.primal_wrath.refreshable)|(!talent.rampant_ferocity.enabled&(spell_targets.primal_wrath>1&!dot.bloodseeker_vines.ticking&!buff.ravage.up|spell_targets.primal_wrath>6+talent.ravage)))
  if S.PrimalWrath:IsReady() and IsInAoERange and EnemiesCount8y > 1 and AoEON() and ((Target:DebuffRemains(S.RipDebuff) < 6.5 and Player:BuffDown(BsInc) or Target:DebuffRefreshable(S.RipDebuff)) or (not S.RampantFerocity:IsAvailable() and (EnemiesCount8y > 1 and Target:DebuffDown(S.BloodseekerVinesDebuff) and Player:BuffDown(S.RavageBuffFeral) or EnemiesCount8y > 6 + num(S.Ravage:IsAvailable()))) or Target:PMultiplier(S.Rip) < Player:PMultiplier(S.Rip)) then
    if Cast(S.PrimalWrath) then
      return
      "primal_wrath finisher 2";
    end
  end
  -- rip,target_if=refreshable,if=(!talent.primal_wrath|spell_targets=1)&(buff.bloodtalons.up|!talent.bloodtalons)&(buff.tigers_fury.up|dot.rip.remains<cooldown.tigers_fury.remains)
  if S.Rip:IsReady() and ((not S.PrimalWrath:IsAvailable() or EnemiesCountMelee == 1) and (Player:BuffUp(S.BloodtalonsBuff) or not S.Bloodtalons:IsAvailable())) then
    if Everyone.CastCycle(S.Rip, EnemiesMelee, EvaluateCycleRip2, 8, nil, nil, Settings.Feral.AutoTabDot) then
      return "rip finisher 4";
    end
  end
  -- pool_resource,for_next=1
  -- ferocious_bite,max_energy=1,target_if=max:dot.bloodseeker_vines.ticking,if=!buff.bs_inc.up|!talent.soul_of_the_forest.enabled
  -- TODO: Determine a way to do both pool_resource and target_if together.
  if BiteFinisher:IsReady() and IsInMeleeRange and (Player:BuffDown(BsInc)) then
    if CastPooling(BiteFinisher, Player:EnergyTimeToX(50)) then return "ferocious_bite finisher 6"; end
  end
  -- ferocious_bite,target_if=max:dot.bloodseeker_vines.ticking
  if BiteFinisher:IsReady() and Player:HeroTreeID() == 22 then
    if Everyone.CastTargetIf(BiteFinisher, EnemiesMelee, "max", EvaluateTargetIfFilterBloodseeker, nil, 5, nil, nil, false) then
      return
      "ferocious_bite finisher 8";
    end
  end
  if BiteFinisher:IsReady() and IsInMeleeRange and Player:HeroTreeID() ~= 22 then
    if Cast(BiteFinisher) then return "ferocious_bite finisher (non-WS) 10"; end
  end
end

local function AoeBuilder()
  -- variable,name=proccing_bt,op=set,value=variable.need_bt
  VarProccingBT = VarNeedBT
  -- thrash_cat,if=refreshable&!talent.thrashing_claws&!(variable.need_bt&buff.bt_thrash.up)
  if S.ThrashCat:IsReady() and IsInAoERange and (Target:DebuffRefreshable(S.ThrashCatDebuff) and not S.ThrashingClaws:IsAvailable() and not (VarNeedBT and BTBuffUp(S.ThrashCat))) then
    if Cast(S.Thrashcast) then return "thrash aoe_builder 2"; end
  end
  -- brutal_slash,target_if=min:time_to_die,if=(cooldown.brutal_slash.full_recharge_time<4|time_to_die<4|raid_event.adds.remains<4)&!(variable.need_bt&buff.bt_swipe.up)
  if S.BrutalSlash:IsReady() and IsInAoERange and ((S.BrutalSlash:FullRechargeTime() < 4 or FightRemains < 4 or (Player:BuffUp(BsInc) and EnemiesCount8y >= 3 - num(Player:HeroTreeID() == 21))) and not (VarNeedBT and BTBuffUp(S.Swipe) and (Player:BuffDown(BsInc) or EnemiesCount8y < 3 - num(Player:HeroTreeID() == 21)))) then
    if Cast(S.BrutalSlash) then return "brutal_slash aoe_builder 4"; end
  end
  -- swipe_cat,if=time_to_die<4|(talent.wild_slashes&spell_targets.swipe_cat>4&!(variable.need_bt&buff.bt_swipe.up))
  if S.Swipe:IsReady() and IsInAoERange and (FightRemains < 4 or (S.WildSlashes:IsAvailable() and EnemiesCount8y > 4 and not (VarNeedBT and BTBuffUp(S.Swipe)))) then
    if Cast(S.Swipecast) then return "swipe aoe_builder 6"; end
  end
  -- prowl,target_if=dot.rake.refreshable|dot.rake.pmultiplier<1.4,if=!(variable.need_bt&buff.bt_rake.up)&action.rake.ready&gcd.remains=0&!buff.sudden_ambush.up&!variable.cc_capped
  -- Note: Skipping cycling and putting target_if into main condition.
  if S.Prowl:IsReady() and ProwlToggle and not Everyone:ISSolo() and IsInMeleeRange and not Player:StealthUp(false, true) and ((not (VarNeedBT and BTBuffUp(S.Rake)) and S.Rake:IsReady() and Player:BuffDown(S.SuddenAmbushBuff) and not VarCCCapped) and (DebuffRefreshAny(EnemiesMelee, S.RakeDebuff) or Target:PMultiplier(S.Rake) < 1.4)) then
    if Cast(S.Prowlcast) then return "prowl aoe_builder 8"; end
  end
  -- shadowmeld,target_if=dot.rake.refreshable|dot.rake.pmultiplier<1.4,if=!(variable.need_bt&buff.bt_rake.up)&action.rake.ready&!buff.sudden_ambush.up&!buff.prowl.up&!variable.cc_capped
  -- Note: Skipping cycling and putting target_if into main condition.
  if S.Shadowmeld:IsReady() and not Everyone:ISSolo() and IsRacials and IsInMeleeRange and not Player:StealthUp(false, true) and ((not (VarNeedBT and BTBuffUp(S.Rake)) and S.Rake:IsReady() and Player:BuffDown(S.SuddenAmbushBuff) and Player:BuffDown(S.Prowl) and not VarCCCapped) and (DebuffRefreshAny(EnemiesMelee, S.RakeDebuff) or Target:PMultiplier(S.Rake) < 1.4)) then
    if Cast(S.Shadowmeld, true) then return "shadowmeld aoe_builder 10"; end
  end
  -- rake,target_if=refreshable,if=talent.doubleclawed_rake&!(variable.need_bt&buff.bt_rake.up)&!variable.cc_capped
  if S.Rake:IsReady() and (S.DoubleClawedRake:IsAvailable() and not (VarNeedBT and BTBuffUp(S.Rake)) and not VarCCCapped) then
    if Everyone.CastCycle(S.Rake, EnemiesMelee, EvaluateCycleRakeRefreshable, 5, nil, nil, Settings.Feral.AutoTabDot) then
      return
      "rake aoe_builder 12";
    end
  end
  -- swipe_cat,if=talent.wild_slashes&spell_targets.swipe_cat>3&!(variable.need_bt&buff.bt_swipe.up)
  if S.Swipe:IsReady() and IsInAoERange and (S.WildSlashes:IsAvailable() and EnemiesCount8y > 3 and not (VarNeedBT and BTBuffUp(S.Swipe))) then
    if Cast(S.Swipecast) then return "swipe aoe_builder 14"; end
  end
  -- moonfire_cat,target_if=refreshable,if=!(variable.need_bt&buff.bt_moonfire.up)&!variable.cc_capped
  if S.LIMoonfire:IsReady() and (not (VarNeedBT and BTBuffUp(S.LIMoonfireDebuff)) and not VarCCCapped) then
    if Everyone.CastCycle(S.LIMoonfire, Enemies8y, EvaluateCycleMoonfire, 40) then return "moonfire_cat aoe_builder 16"; end
  end
  -- rake,target_if=refreshable,if=!(variable.need_bt&buff.bt_rake.up)&!variable.cc_capped
  if S.Rake:IsReady() and (S.DoubleClawedRake:IsAvailable() and not (VarNeedBT and BTBuffUp(S.Rake)) and not VarCCCapped) then
    if Everyone.CastCycle(S.Rake, EnemiesMelee, EvaluateCycleRakeRefreshable, 5, nil, nil, Settings.Feral.AutoTabDot) then
      return
      "rake aoe_builder 18";
    end
  end
  -- brutal_slash,if=!(variable.need_bt&buff.bt_swipe.up)
  if S.BrutalSlash:IsReady() and IsInAoERange and (not (VarNeedBT and BTBuffUp(S.Swipe))) then
    if Cast(S.BrutalSlash) then return "brutal_slash aoe_builder 20"; end
  end
  -- swipe_cat,if=!(variable.need_bt&buff.bt_swipe.up)
  if S.Swipe:IsReady() and IsInAoERange and (not (VarNeedBT and BTBuffUp(S.Swipe))) then
    if Cast(S.Swipecast) then return "swipe aoe_builder 22"; end
  end
  -- shred,if=!buff.sudden_ambush.up&!variable.easy_swipe&!(variable.need_bt&buff.bt_shred.up)
  if S.Shred:IsReady() and IsInMeleeRange and (Player:BuffDown(S.SuddenAmbushBuff) and not (VarNeedBT and BTBuffUp(S.Shred))) then
    if Cast(S.Shred) then return "shred aoe_builder 24"; end
  end
  -- thrash_cat,if=!talent.thrashing_claws&!(variable.need_bt&buff.bt_thrash.up)
  if S.ThrashCat:IsReady() and IsInAoERange and (not S.ThrashingClaws:IsAvailable() and not (VarNeedBT and BTBuffUp(S.ThrashCat))) then
    if Cast(S.Thrashcast) then return "thrash aoe_builder 26"; end
  end
  -- rake,target_if=max:ticks_gained_on_refresh,if=talent.doubleclawed_rake&buff.sudden_ambush.up&variable.need_bt&buff.bt_rake.down
  if S.Rake:IsReady() and (S.DoubleClawedRake:IsAvailable() and Player:BuffUp(S.SuddenAmbushBuff) and VarNeedBT and BTBuffDown(S.Rake)) then
    if Everyone.CastTargetIf(S.Rake, Enemies8y, "max", EvaluateTargetIfFilterRakeAoEBuilder, nil, 5, nil, nil, Settings.Feral.AutoTabDot) then
      return
      "rake aoe_builder 28";
    end
  end
  -- moonfire_cat,target_if=max:ticks_gained_on_refresh,if=variable.need_bt&buff.bt_moonfire.down
  if S.LIMoonfire:IsReady() and (VarNeedBT and BTBuffDown(S.LIMoonfire)) then
    if Everyone.CastTargetIf(S.LIMoonfire, Enemies8y, "max", EvaluateTargetIfFilterLIMoonfire, nil, 40) then
      return
      "moonfire_cat aoe_builder 30";
    end
  end
  -- rake,target_if=max:ticks_gained_on_refresh,if=buff.sudden_ambush.up&variable.need_bt&buff.bt_rake.down
  if S.Rake:IsReady() and (Player:BuffUp(S.SuddenAmbushBuff) and VarNeedBT and BTBuffDown(S.Rake)) then
    if Everyone.CastTargetIf(S.Rake, Enemies8y, "max", EvaluateTargetIfFilterRakeAoEBuilder, nil, 5, nil, nil, Settings.Feral.AutoTabDot) then
      return
      "rake aoe_builder 32";
    end
  end
  -- shred,if=variable.need_bt&buff.bt_shred.down&!variable.easy_swipe
  if S.Shred:IsReady() and IsInMeleeRange and (VarNeedBT and BTBuffDown(S.Shred)) then
    if Cast(S.Shred) then return "shred aoe_builder 34"; end
  end
  -- rake,target_if=dot.rake.pmultiplier<1.6,if=variable.need_bt&buff.bt_rake.down
  if S.Rake:IsReady() and (VarNeedBT and BTBuffDown(S.Rake)) then
    if Everyone.CastCycle(S.Rake, EnemiesMelee, EvaluateCycleRakeAoeBuilder, 5) then return "rake aoe_builder 36"; end
  end
  -- thrash_cat,if=variable.need_bt&buff.bt_shred.down
  if S.ThrashCat:IsReady() and IsInAoERange and (VarNeedBT and BTBuffDown(S.Shred)) then
    if Cast(S.Thrashcast) then return "thrash aoe_builder 38"; end
  end
end

local function Cooldown()
  if Settings.Commons.Enabled.Trinkets then
    -- use_item,name=imperfect_ascendancy_serum,if=cooldown.bs_inc.remains<=1
    if I.ImperfectAscendancySerum:IsEquippedAndReady() and (Trinket1:ID() == I.ImperfectAscendancySerum:ID() and IsTrinket1 or Trinket2:ID() == I.ImperfectAscendancySerum:ID() and IsTrinket2) and (BsInc:CooldownRemains() <= 1) then
      if Cast(I.ImperfectAscendancySerum, true) then return "imperfect_ascendancy_serum cooldown 2"; end
    end
    -- use_item,slot=trinket1,if=(trinket.1.has_use_damage|trinket.1.is.twin_fang_instruments|trinket.1.is.sikrans_endless_arsenal)&(trinket.2.cooldown.remains>20|!variable.trinket_2_buffs|trinket.2.cooldown.remains&cooldown.tigers_fury.remains>20)
    -- TODO: Handle has_use_damage. Until then, using HasUseBuff logic.
    if Trinket1:IsReady() and IsInMeleeRange and IsTrinket1 and not VarTrinket1BL and ((Trinket1:HasUseBuff() or VarTrinket1ID == I.TwinFangInstruments:ID() or VarTrinket1ID == I.SikransEndlessArsenal:ID()) and (Trinket2:CooldownRemains() > 20 or not VarTrinket2Buffs or Trinket2:CooldownDown() and S.TigersFury:CooldownRemains() > 20)) then
      if Cast(Trinket1, true) then return "Generic use_item for " .. Trinket1:Name() .. " cooldown 20"; end
    end
    -- use_item,slot=trinket1,if=!trinket.1.is.ovinaxs_mercurial_egg&!variable.trinket_1_buffs&(trinket.2.cooldown.remains>20|!variable.trinket_2_buffs|trinket.2.cooldown.remains&cooldown.tigers_fury.remains>20)
    if Trinket1:IsReady() and IsInMeleeRange and IsTrinket1 and not VarTrinket1BL and (VarTrinket1ID ~= I.OvinaxsMercurialEgg:ID() and not VarTrinket1Buffs and (Trinket2:CooldownRemains() > 20 or not VarTrinket2Buffs or Trinket2:CooldownDown() and S.TigersFury:CooldownRemains() > 20)) then
      if Cast(Trinket1, true) then return "Generic use_item for " .. Trinket1:Name() .. " cooldown 21"; end
    end
    -- use_item,slot=trinket2,if=!trinket.2.is.ovinaxs_mercurial_egg&!variable.trinket_2_buffs&(trinket.1.cooldown.remains>20|!variable.trinket_1_buffs|trinket.1.cooldown.remains&cooldown.tigers_fury.remains>20)
    if Trinket2:IsReady() and IsInMeleeRange and IsTrinket2 and not VarTrinket2BL and (VarTrinket2ID ~= I.OvinaxsMercurialEgg:ID() and not VarTrinket2Buffs and (Trinket1:CooldownRemains() > 20 or not VarTrinket1Buffs or Trinket1:CooldownDown() and S.TigersFury:CooldownRemains() > 20)) then
      if Cast(Trinket2, true) then return "Generic use_item for " .. Trinket2:Name() .. " cooldown 22"; end
    end
    -- use_item,slot=trinket2,if=(trinket.2.has_use_damage|trinket.2.is.twin_fang_instruments|trinket.2.is.sikrans_endless_arsenal)&(trinket.1.cooldown.remains>20|!variable.trinket_1_buffs|trinket.1.cooldown.remains&cooldown.tigers_fury.remains>20)
    -- TODO: Handle has_use_damage. Until then, using HasUseBuff logic.
    if Trinket2:IsReady() and IsInMeleeRange and IsTrinket2 and not VarTrinket2BL and ((Trinket2:HasUseBuff() or VarTrinket2ID == I.TwinFangInstruments:ID() or VarTrinket2ID == I.SikransEndlessArsenal:ID()) and (Trinket1:CooldownRemains() > 20 or not VarTrinket1Buffs or Trinket1:CooldownDown() and S.TigersFury:CooldownRemains() > 20)) then
      if Cast(Trinket2, true) then return "Generic use_item for " .. Trinket2:Name() .. " cooldown 23"; end
    end
  end
  -- incarnation
  if S.Incarnation:IsReady() and IsIncarnation and IsInMeleeRange then
    if Cast(S.Incarnation, true) then return "incarnation cooldown 4"; end
  end
  -- berserk,if=buff.tigers_fury.up&(target.time_to_die>12|target.time_to_die=fight_remains)
  if S.Berserk:IsReady() and IsIncarnation and IsInMeleeRange and (Player:BuffUp(S.TigersFury) and (Target:TimeToDie() > 12 or Target:TimeToDie() == FightRemains)) then
    if Cast(S.Berserk, true) then return "berserk cooldown 6"; end
  end
  -- berserking,if=buff.bs_inc.up
  if S.Berserking:IsCastable() and IsInMeleeRange and IsRacials and (Player:BuffUp(BsInc)) then
    if Cast(S.Berserking, true) then return "berserking cooldown 8"; end
  end
  -- potion,if=buff.bs_inc.up|fight_remains<32|(!variable.lastZerk&variable.lastConvoke&cooldown.convoke_the_spirits.remains<10)
  if Settings.Commons.Enabled.Potions and IsPotions and (Player:BuffUp(BsInc) or FightRemains < 32 or (not VarLastZerk and VarLastConvoke and S.ConvoketheSpirits:CooldownRemains() < 10)) then
    local PotionSelected = Everyone.PotionSelected()
    if PotionSelected and PotionSelected:IsReady() then
      HR.CastMacro(3, nil, nil, PotionSelected)
      return "Cast Potion";
    end
  end
  -- use_items
  if Settings.Commons.Enabled.Items then
    local MHToUse, _, MHRange = Player:GetUseableItems(OnUseExcludes, 16)
    if MHToUse and MHToUse:IsReady() and Target:IsInRange(MHRange) and IsDjaruun then
      HR.CastMacro(1, nil, nil, MHToUse)
      return "Generic use_item for " .. MHToUse:Name() .. " cooldown 12";
    end
  end
  if Settings.Commons.Enabled.Trinkets then
    -- use_item,slot=trinket1,if=variable.trinket_1_buffs&(buff.bs_inc.up|((buff.tigers_fury.up&cooldown.tigers_fury.remains>20)&(cooldown.convoke_the_spirits.remains<4|cooldown.convoke_the_spirits.remains>45|(variable.trinket_2_buffs&cooldown.convoke_the_spirits.remains-trinket.2.cooldown.remains>0)|!talent.convoke_the_spirits&(cooldown.bs_inc.remains>40|cooldown.bs_inc.remains-trinket.2.cooldown.remains>0))))&(!trinket.2.has_cooldown|trinket.2.cooldown.remains|variable.trinket_priority=1)|trinket.1.proc.any_dps.duration>=fight_remains
    if Trinket1:IsReady() and IsInMeleeRange and IsTrinket1 and not VarTrinket1BL and (VarTrinket1Buffs and (Player:BuffUp(BsInc) or ((Player:BuffUp(S.TigersFury) and S.TigersFury:CooldownRemains() > 20) and (S.ConvoketheSpirits:CooldownRemains() < 4 or S.ConvoketheSpirits:CooldownRemains() > 45 or (VarTrinket2Buffs and S.ConvoketheSpirits:CooldownRemains() - Trinket2:CooldownRemains() > 0) or not S.ConvoketheSpirits:IsAvailable() and (BsInc:CooldownRemains() > 40 or BsInc:CooldownRemains() - Trinket2:CooldownRemains() > 0)))) and (not Trinket2:HasCooldown() or Trinket2:CooldownDown() or VarTrinketPriority == 1) or VarTrinket1Duration >= FightRemains) then
      if Cast(Trinket1, true) then return "Generic use_item for " .. Trinket1:Name() .. " cooldown 16"; end
    end
    -- use_item,slot=trinket2,if=variable.trinket_2_buffs&(buff.bs_inc.up|((buff.tigers_fury.up&cooldown.tigers_fury.remains>20)&(cooldown.convoke_the_spirits.remains<4|cooldown.convoke_the_spirits.remains>45|(variable.trinket_1_buffs&cooldown.convoke_the_spirits.remains-trinket.1.cooldown.remains>0)|!talent.convoke_the_spirits&(cooldown.bs_inc.remains>40|cooldown.bs_inc.remains-trinket.1.cooldown.remains>0))))&(!trinket.1.has_cooldown|trinket.1.cooldown.remains|variable.trinket_priority=2)|trinket.2.proc.any_dps.duration>=fight_remains
    if Trinket2:IsReady() and IsInMeleeRange and IsTrinket2 and not VarTrinket2BL and (VarTrinket2Buffs and (Player:BuffUp(BsInc) or ((Player:BuffUp(S.TigersFury) and S.TigersFury:CooldownRemains() > 20) and (S.ConvoketheSpirits:CooldownRemains() < 4 or S.ConvoketheSpirits:CooldownRemains() > 45 or (VarTrinket1Buffs and S.ConvoketheSpirits:CooldownRemains() - Trinket1:CooldownRemains() > 0) or not S.ConvoketheSpirits:IsAvailable() and (BsInc:CooldownRemains() > 40 or BsInc:CooldownRemains() - Trinket1:CooldownRemains() > 0)))) and (not Trinket1:HasCooldown() or Trinket1:CooldownDown() or VarTrinketPriority == 2) or VarTrinket2Duration >= FightRemains) then
      if Cast(Trinket2, true) then return "Generic use_item for " .. Trinket2:Name() .. " cooldown 18"; end
    end
  end
  -- feral_frenzy,if=combo_points<=1|buff.bs_inc.up&combo_points<=2
  if S.FeralFrenzy:IsReady() and IsInMeleeRange and IsFeralFrenzy and (ComboPoints <= 1 or Player:BuffUp(BsInc) and ComboPoints <= 2) then
    if Cast(S.FeralFrenzy, true) then return "feral_frenzy cooldown 24"; end
  end
  -- convoke_the_spirits,if=fight_remains<5|(cooldown.bs_inc.remains>45|buff.bs_inc.up|!talent.berserk_heart_of_the_lion)&(buff.tigers_fury.up&(combo_points<=2|buff.bs_inc.up&combo_points<=3)&(target.time_to_die>5-talent.ashamanes_guidance.enabled|target.time_to_die=fight_remains))
  if S.ConvoketheSpirits:IsCastable() and IsInMeleeRange and IsConvoketheSpirits and (BossFightRemains < 5 or (BsInc:CooldownRemains() > 45 or Player:BuffUp(BsInc) or not S.BerserkHeartoftheLion:IsAvailable()) and (Player:BuffUp(S.TigersFury) and (ComboPoints <= 4 or Player:BuffUp(BsInc) and ComboPoints <= 3) and (Target:TimeToDie() > 5 - num(S.AshamanesGuidance:IsAvailable()) or Target:TimeToDie() == FightRemains))) then
    if Cast(S.ConvoketheSpirits) then return "convoke_the_spirits cooldown 26"; end
  end
end

local function Variables()
  -- variable,name=effective_energy,op=set,value=energy+(40*buff.clearcasting.stack)+(3*energy.regen)+(50*(cooldown.tigers_fury.remains<3.5))
  VarEffectiveEnergy = Player:Energy() + (40 * Player:BuffStack(S.Clearcasting)) + (3 * Player:EnergyRegen()) +
      (50 * num(S.TigersFury:CooldownRemains() < 3.5))
  -- variable,name=time_to_pool,op=set,value=((115-variable.effective_energy-(23*buff.incarnation.up))%energy.regen)
  VarTimeToPool = ((115 - VarEffectiveEnergy - (23 * num(Player:BuffUp(S.Incarnation)))) / Player:EnergyRegen())
  -- variable,name=need_bt,value=talent.bloodtalons&buff.bloodtalons.stack<=1
  VarNeedBT = S.Bloodtalons:IsAvailable() and Player:BuffStack(S.BloodtalonsBuff) <= 1
  -- variable,name=cc_capped,value=buff.clearcasting.stack=(1+talent.moment_of_clarity)
  VarCCCapped = Player:BuffStack(S.Clearcasting) == (1 + num(S.MomentofClarity:IsAvailable()))
  -- variable,name=lastConvoke,value=(cooldown.convoke_the_spirits.remains+cooldown.convoke_the_spirits.duration)>remains&cooldown.convoke_the_spirits.remains<remains
  VarLastConvoke = (S.ConvoketheSpirits:CooldownRemains() + 120) > FightRemains and
      S.ConvoketheSpirits:CooldownRemains() < FightRemains
  -- variable,name=lastZerk,value=(cooldown.bs_inc.remains+cooldown.bs_inc.duration+5)>remains&cooldown.convoke_the_spirits.remains<remains
  VarLastZerk = (BsInc:CooldownRemains() + 185) > FightRemains and BsInc:CooldownRemains() < FightRemains
  -- variable,name=lastPotion,value=(cooldown.potions.remains+cooldown.potions.duration+15)>remains&cooldown.potions.remains+15<remains
  local PotionSelected = nil
  local PotionCDRemains = 0
  if Settings.Commons.Enabled.Potions then
    PotionSelected = Everyone.PotionSelected()
    if PotionSelected then
      PotionCDRemains = PotionSelected:CooldownRemains()
    end
  end
  VarLastPotion = false
  if PotionSelected then
    VarLastPotion = (PotionCDRemains + 315) > FightRemains and PotionCDRemains + 15 < FightRemains
  end
  -- variable,name=moonfire_snapshotted,value=buff.tigers_fury.up,op=set,if=prev.lunar_inspiration
  VarMoonfireSnapshotted = Player:PrevGCD(1, S.LIMoonfire) and Player:BuffUp(S.TigersFury)
end

local function APL()
  if Player:IsChanneling(I.ManicGrieftorch.ItemUseSpell) then
    return "Dont cut Torch"
  end
  InterruptToggle = HR.ToggleIconFrame:GetToggle(1)
  DispelToggle = HR.ToggleIconFrame:GetToggle(2)
  Smallcds = HR.ToggleIconFrame:GetToggle(3)
  ProwlToggle = HR.ToggleIconFrame:GetToggle(4)

  UnitsIn40Yards = Everyone.UnitsinRange(S.Regrowth)
  -- Update Enemies
  EnemiesMelee = Player:GetEnemiesInMeleeRange(5)
  Enemies8y = Player:GetEnemiesInMeleeRange(8)
  Enemies20y = Player:GetEnemiesInMeleeRange(20)
  if AoEON() then
    EnemiesCountMelee = #EnemiesMelee
    EnemiesCount8y = #Enemies8y
    EnemiesCount20y = #Enemies20y
  else
    EnemiesCountMelee = 1
    EnemiesCount8y = 1
    EnemiesCount20y = 1
  end

  local HoldCD = PuzzleBoxIsReady() and
      (Trinket1:ID() == I.AlgetharPuzzleBox:ID() and IsTrinket1 or Trinket2:ID() == I.AlgetharPuzzleBox:ID() and IsTrinket2)

  IsRacials = TTDCheckForCDs(Settings.Feral_TTD.RacialsTTD) and SpellProperties(Settings.Feral_CDUSE.Racials)
  IsPotions = TTDCheckForCDs(Settings.Feral_TTD.PotionsTTD) and
      (Settings.Feral_CDUSE.Potionswhensolo or (not Settings.Feral_CDUSE.Potionswhensolo and not Everyone.ISSolo())) and
      SpellProperties(Settings.Feral_CDUSE.Potions)
  IsTrinket1 = TTDCheckForCDs(Settings.Feral_TTD.TrinketsTTD) and SpellProperties(Settings.Feral_CDUSE.Trinket1)
  IsTrinket2 = TTDCheckForCDs(Settings.Feral_TTD.TrinketsTTD) and SpellProperties(Settings.Feral_CDUSE.Trinket2)
  IsIncarnation = not HoldCD and TTDCheckForCDs(Settings.Feral_TTD.IncarnationTTD) and
      SpellProperties(Settings.Feral_CDUSE.Incarnation)
  IsFeralFrenzy = TTDCheckForCDs(Settings.Feral_TTD.FeralFrenzyTTD) and SpellProperties(Settings.Feral_CDUSE.FeralFrenzy)
  IsAdaptiveSwarm = SpellProperties(Settings.Feral_CDUSE.AdaptiveSwarm)
  IsConvoketheSpirits = not HoldCD and TTDCheckForCDs(Settings.Feral_TTD.ConvoketheSpiritsTTD) and
      SpellProperties(Settings.Feral_CDUSE.ConvoketheSpirits)
  IsTigersFury = TTDCheckForCDs(Settings.Feral_TTD.TigersFuryTTD) and SpellProperties(Settings.Feral_CDUSE.TigersFury)
  IsDjaruun = SpellProperties(Settings.Feral_CDUSE.Djaruun)

  if Everyone.TargetIsValid() or Player:AffectingCombat() then
    -- Calculate fight_remains
    BossFightRemains = HL.BossFightRemains()
    IsBossfight = true
    FightRemains = BossFightRemains
    if FightRemains == 11111 then
      IsBossfight = false
      FightRemains = HL.FightRemains(Enemies8y, false)
    end

    -- Combo Points
    ComboPoints = Player:ComboPoints()
    ComboPointsDeficit = Player:ComboPointsDeficit()

    -- Range Stuffs
    IsInMeleeRange = Target:IsInRange(5)
    IsInAoERange = Target:IsInRange(8)
    -- Bite Finisher to handle DotC's Ravage
    if Player:HeroTreeID() == 21 then
      BiteFinisher = S.RavageAbilityCat:IsLearned() and S.RavageAbilityCat or S.FerociousBite
    else
      BiteFinisher = S.FerociousBite
    end
  end

  --S.Mangle:IsCastable() and IsInMeleeRange and Target:DebuffUp(S.ThrashDebuff)
  --print("mangle castable?", S.Mangle:IsCastable(), "melee?", IsInMeleeRange, "thrash up?", Target:DebuffUp(S.ThrashBearDebuff))
  --print ("set? ", Player:HasTier(31, 4))
  if S.MarkoftheWild:IsCastable() and not (Player:StealthUp(false, true)) and not Player:DebuffUp(S.Corruption) and ((Everyone.GroupBuffMissing(S.MarkoftheWildBuff) and Settings.Commons.MarkoftheWild == "check whole group" and (Player:IsInRaidArea() or Player:IsInDungeonArea()) and Player:InstanceDifficulty() ~= 205) or Player:BuffDown(S.MarkoftheWildBuff, true) and (Settings.Commons.MarkoftheWild == "only check us" or Settings.Commons.MarkoftheWild == "check whole group")) then
    if HR.CastTarget(S.MarkoftheWild, HR.TName().PLAYER) then return "mark_of_the_wild precombat"; end
  end
  -- cat_form OOC, if setting is true
  if S.CatForm:IsCastable() and Player:BuffDown(S.TravelFormBuff) and Player:BuffDown(S.BearForm) and Settings.Feral.ShowCatFormOOC then
    if Cast(S.CatForm) then return "cat_form ooc"; end
  end

  if not Player:IsMoving() then
    ShouldReturn = not Player:IsCasting(S.Hibernate) and Everyone.IncorpCycle(S.Hibernate, 33, false, false);
    if ShouldReturn then
      return ShouldReturn;
    end
  end

  if DispelToggle then
    ShouldReturn = Player:AffectingCombat() and Everyone.SootheCycle(S.Soothe, 45, false, Settings.Feral.TabForSoothe); if ShouldReturn then
      return
          ShouldReturn;
    end
    if S.RemoveCorruption:IsCastable() and Player:IsInDungeonArea() and Player:IsInParty() then
      ShouldReturn = Everyone.DispelCycle(S.RemoveCorruption, "Poison", nil, UnitsIn40Yards); if ShouldReturn then
        return
            ShouldReturn;
      end
      ShouldReturn = Everyone.DispelCycle(S.RemoveCorruption, "Curse", nil, UnitsIn40Yards); if ShouldReturn then
        return
            ShouldReturn;
      end
    end
  end

  if S.Rebirth:IsReady() and not Player:IsCasting(S.Rebirth) and Player:AffectingCombat() and not Player:IsMoving() then
    if Target:UnitIsFriend() and Target:UnitIsPlayer() and Target:Exists() and Target:IsDeadOrGhost() then
      HR.Cast(S.Rebirth)
      return "Rebirth on Target"
    end
    if Mouseover:UnitIsFriend() and Mouseover:UnitIsPlayer() and Mouseover:Exists() and Mouseover:IsDeadOrGhost() then
      HR.CastTarget(S.Rebirth, HR.TName().MOUSEOVER)
      return "Rebirth on Mouseover"
    end
  end

  -- prowl,if=(buff.bs_inc.down|!in_combat)&!buff.prowl.up
  if S.Prowl:IsReady() and ProwlToggle and (Player:BuffDown(BsInc) or not Player:AffectingCombat()) and Player:BuffUp(S.CatForm) and EnemiesCount20y > 1 then
    if Cast(S.Prowlcast, true) then return "prowl main 2"; end
  end

  ShouldReturn = Defensives(); if ShouldReturn then return ShouldReturn; end

  if Everyone.TargetIsValid() and Player:BuffDown(S.TravelFormBuff) then
    if not Settings.Feral.AttackonlyinCombat or Settings.Feral.AttackonlyinCombat and Target:AffectingCombat() then
      if not IncorporealBeing(Unit.Target) then
        -- Precombat
        if not Player:AffectingCombat() then
          ShouldReturn = Precombat(); if ShouldReturn then return ShouldReturn; end
        end
        if InterruptToggle and not Convoke() then
          -- Interrupts
          --ShouldReturn = Everyone.Interrupt(13, S.SkullBash, false, InterruptStuns); if ShouldReturn then return ShouldReturn; end
          ShouldReturn = Everyone.InterruptCycle(S.SkullBash, 13, true, nil, false)
          if ShouldReturn then return ShouldReturn end

          ShouldReturn = Everyone.InterruptCycle(S.MightyBash, 8, false, nil, true)
          if ShouldReturn then return ShouldReturn end

          ShouldReturn = ComboPoints > 0 and Everyone.InterruptCycle(S.Maim, 9, false, nil, true)
          if ShouldReturn then return ShouldReturn end
        end
        -- cat_form,if=!buff.cat_form.up
        if S.CatForm:IsCastable() and Player:BuffDown(S.TravelFormBuff) and Player:BuffDown(S.BearForm) then
          if Cast(S.CatForm) then return "cat_form main 4"; end
        end
        -- invoke_external_buff,name=power_infusion,if=!variable.align_cds|variable.align_cds&buff.bs_inc.up|fight_remains<25
        -- Note: We're not handling external buffs
        -- call_action_list,name=variables
        Variables()
        if Player:BuffUp(S.BearForm) then
          if S.ThrashBear:IsCastable() and IsInAoERange and Target:DebuffRefreshable(S.ThrashBearDebuff) then
            if Cast(S.Thrashcast) then return "thrash bear"; end
          end
          if S.Mangle:IsCastable() and IsInMeleeRange and Target:DebuffUp(S.ThrashBearDebuff) then
            if Cast(S.Mangle) then return "Mangle bear"; end
          end
          if S.BrutalSlash:IsCastable() and IsInAoERange then
            if Cast(S.BrutalSlash) then return "Brutal Slash bear"; end
          end
          if S.Swipe:IsCastable() and IsInAoERange then
            if Cast(S.Swipecast) then return "Swipe bear"; end
          end
          if S.ThrashBear:IsCastable() and IsInAoERange then
            if Cast(S.Thrashcast) then return "thrash bear"; end
          end
        end
        if Player:BuffUp(S.CatForm) then
          -- rake,target_if=persistent_multiplier>dot.rake.pmultiplier,if=buff.prowl.up|buff.shadowmeld.up
          if S.Rake:IsReady() and (Player:StealthUp(false, true)) then
            if Everyone.CastCycle(S.Rake, EnemiesMelee, EvaluateTargetIfFilterRakeMain, 5, nil, nil, Settings.Feral.AutoTabDot) then
              return
              "rake main 8";
            end
          end
          if not (Player:StealthUp(false, true)) then
            -- tigers_fury,if=(energy.deficit>35|combo_points=5)&(fight_remains<=15|(cooldown.bs_inc.remains>20&target.time_to_die>5)|(cooldown.bs_inc.ready&target.time_to_die>12|target.time_to_die=fight_remains))
            if S.TigersFury:IsCastable() and IsTigersFury and ((Player:EnergyDeficit() > 35 or ComboPoints == 5 or ComboPoints >= 3 and Target:DebuffRefreshable(S.RipDebuff) and Player:BuffUp(S.BloodtalonsBuff)) and (BossFightRemains <= 15 or (BsInc:CooldownRemains() > 20 and Target:TimeToDie() > 5) or (BsInc:CooldownUp() and Target:TimeToDie() > 12 or Target:TimeToDie() == FightRemains))) then
              if Cast(S.TigersFury, true) then return "tigers_fury main 6"; end
            end
            -- adaptive_swarm,target_if=dot.adaptive_swarm_damage.stack<3&(!dot.adaptive_swarm_damage.ticking|dot.adaptive_swarm_damage.remains<2),if=!action.adaptive_swarm_damage.in_flight&(spell_targets=1|!talent.unbridled_swarm)&(dot.rip.ticking|hero_tree.druid_of_the_claw)
            if S.AdaptiveSwarm:IsReady() and IsAdaptiveSwarm and (not S.AdaptiveSwarm:InFlight() and (EnemiesCount8y == 1 or not S.UnbridledSwarm:IsAvailable())) then
              if Everyone.CastCycle(S.AdaptiveSwarm, Enemies8y, EvaluateCycleAdaptiveSwarm, 40) then
                return
                "adaptive_swarm main 14";
              end
            end
            -- adaptive_swarm,target_if=max:(1+dot.adaptive_swarm_damage.stack)*dot.adaptive_swarm_damage.stack<3*time_to_die,if=buff.cat_form.up&dot.adaptive_swarm_damage.stack<3&talent.unbridled_swarm.enabled&spell_targets.swipe_cat>1&dot.rip.ticking
            if S.AdaptiveSwarm:IsReady() and IsAdaptiveSwarm and (Player:BuffUp(S.CatForm) and S.UnbridledSwarm:IsAvailable() and EnemiesCount8y > 1) then
              if Everyone.CastTargetIf(S.AdaptiveSwarm, Enemies8y, "max", EvaluateTargetIfFilterAdaptiveSwarm, EvaluateTargetIfAdaptiveSwarm, 40) then
                return
                "adaptive_swarm main 16";
              end
            end
            -- ferocious_bite,if=buff.apex_predators_craving.up&!(variable.need_bt&active_bt_triggers=2)
            if BiteFinisher:IsReady() and IsInMeleeRange and (Player:BuffUp(S.ApexPredatorsCravingBuff) and not (VarNeedBT and CountActiveBtTriggers() == 2)) then
              if Cast(BiteFinisher) then return "ferocious_bite main 18"; end
            end
            -- call_action_list,name=cooldown,if=dot.rip.ticking
            if Target:DebuffUp(S.RipDebuff) then
              local ShouldReturn = Cooldown(); if ShouldReturn then return ShouldReturn; end
            end
            -- rip,if=spell_targets=1&hero_tree.wildstalker&!(talent.raging_fury&talent.veinripper)&(buff.bloodtalons.up|!talent.bloodtalons)&(dot.rip.pmultiplier<persistent_multiplier&buff.tigers_fury.remains>10&combo_points>=3|((buff.tigers_fury.remains<3&combo_points=5)|buff.tigers_fury.remains<=1)&buff.tigers_fury.up&combo_points>=3&remains<cooldown.tigers_fury.remains)
            if S.Rip:IsReady() and IsInMeleeRange and (EnemiesCountMelee == 1 and Player:HeroTreeID() == 22 and not (S.RagingFury:IsAvailable() and S.Veinripper:IsAvailable()) and (Player:BuffUp(S.BloodtalonsBuff) or not S.Bloodtalons:IsAvailable()) and (Target:DebuffRemains(S.RipDebuff) < 5 and Player:BuffRemains(S.TigersFury) > 10 and ComboPoints >= 3 or ((Player:BuffRemains(S.TigersFury) < 3 and ComboPoints == 5) or Player:BuffRemains(S.TigersFury) <= 1) and Player:BuffUp(S.TigersFury) and ComboPoints >= 3 and Target:DebuffRemains(S.RipDebuff) < S.TigersFury:CooldownRemains())) then
              if Cast(S.Rip) then return "rip main 20"; end
            end
            -- call_action_list,name=finisher,if=combo_points=5
            if ComboPoints == 5 then
              local ShouldReturn = Finisher(); if ShouldReturn then return ShouldReturn; end
            end
            -- call_action_list,name=builder,if=spell_targets.swipe_cat=1&combo_points<5&(variable.time_to_pool<=0|!variable.need_bt|variable.proccing_bt)
            if (EnemiesCount8y < 2 or not AoEON) and ComboPoints < 5 and (VarTimeToPool <= 0 or not VarNeedBT or VarProccingBT) then
              local ShouldReturn = Builder(); if ShouldReturn then return ShouldReturn; end
            end
            -- call_action_list,name=aoe_builder,if=spell_targets.swipe_cat>=2&combo_points<5&(variable.time_to_pool<=0|!variable.need_bt|variable.proccing_bt)
            if EnemiesCount8y >= 2 and ComboPoints < 5 and (VarTimeToPool <= 0 or not VarNeedBT or VarProccingBT) then
              local ShouldReturn = AoeBuilder(); if ShouldReturn then return ShouldReturn; end
            end
          end
        end
        -- Pool if nothing else to do
        if (true) then
          if HR.CastAnnotated(S.Pool, false, "WAIT") then return "Pool Energy"; end
        end
      end
    end
  end
end

local function OnInit()
  HR.ResetToggle()
  Settings.Feral.Display()
  S.RipDebuff:RegisterAuraTracking()
  HR:UpdateMacro("macro1", "/use 16")
  HR.ToggleIconFrame:AddButtonCustom("I", 1, "Interrupt", "interrupt");
  HR.ToggleIconFrame:AddButtonCustom("D", 2, "Dispel", "dispel");
  HR.ToggleIconFrame:AddButtonCustom("S", 3, "smallCDs", "smallcds");
  HR.ToggleIconFrame:AddButtonCustom("P", 4, "Prowl", "prowl");

  HR.Print("Feral Druid rotation has been updated for patch 11.0.2. Last Update 07.10.2024")
end

HR.SetAPL(103, APL, OnInit)
