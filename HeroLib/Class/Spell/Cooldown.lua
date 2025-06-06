--- ============================ HEADER ============================
--- ======= LOCALIZE =======
-- Addon
local addonName, HL          = ...
-- HeroLib
local Cache, Utils           = HeroCache, HL.Utils
local Unit                   = HL.Unit
local Player, Pet, Target    = Unit.Player, Unit.Pet, Unit.Target
local Focus, MouseOver       = Unit.Focus, Unit.MouseOver
local Arena, Boss, Nameplate = Unit.Arena, Unit.Boss, Unit.Nameplate
local Party, Raid            = Unit.Party, Unit.Raid
local Spell                  = HL.Spell
local Item                   = HL.Item

-- C_Spell locals
local GetSpellCharges        = C_Spell.GetSpellCharges
-- Accepts: spellIdentifier; Returns: chargeInfo (SpellChargeInfo: maxCharges, cooldownStartTime, chargeModRate, currentCharges, cooldownDuration)
local GetSpellCooldown       = C_Spell.GetSpellCooldown
-- Accepts: spellIdentifier; Returns spellCooldownInfo (SpellCooldownInfo: isEnabled, startTime, modRate, duration)

-- lua locals
local GetTime                = GetTime

-- File Locals


--- ============================ CONTENT ============================
-- Note: BypassRecovery is a common arg of this module because by default, in order to improve the prediction, we take in account the remaining time of the GCD or the current cast (whichever is higher).
--       Although sometimes we might want to ignore this and return the "raw" value, which this arg is for.

-- Get the CooldownInfo (from GetSpellCooldown).
function Spell:CooldownInfo()
  local SpellID = self:ID()
  local CDInfo = GetSpellCooldown(SpellID)

  return CDInfo.isEnabled, CDInfo.startTime, CDInfo.modRate, CDInfo.duration
end

-- Get the ChargesInfos (from GetSpellCharges).
-- API Documentation: https://warcraft.wiki.gg/wiki/API_C_Spell.GetSpellCharges
function Spell:ChargesInfo()
  local SpellID = self:ID()
  local SpellInfo = GetSpellCharges(SpellID)
  -- Non-charged spells now return nil, so let's return default values to avoid a nil error.
  if not SpellInfo then
    return 1, 1, 0, 0, 1
  end

  return SpellInfo.currentCharges, SpellInfo.maxCharges, SpellInfo.cooldownStartTime, SpellInfo.cooldownDuration, SpellInfo.chargeModRate
end

-- action.foo.cooldown
function Spell:Cooldown()
  -- Try to get charges information.
  local _, _, _, Duration = self:ChargesInfo()
  -- If it does not exist, try it's cooldown information.
  if not Duration then
    _, _, _, Duration = self:CooldownInfo()
  end

  return Duration
end

-- cooldown.foo.remains
function Spell:CooldownRemains(BypassRecovery)
  local _, StartTime, _, Duration = self:CooldownInfo()
  if StartTime == 0 then return 0 end
  local CD = StartTime + Duration - GetTime() - HL.RecoveryOffset(BypassRecovery)

  return CD > 0 and CD or 0
end

-- cooldown.foo.remains_guess 
function Spell:CooldownRemainsGuess(BypassRecovery)
  local _, StartTime, _, Duration = self:CooldownInfo()
  if StartTime == 0 then return 0 end

  local CD = StartTime + Duration - GetTime() - HL.RecoveryOffset(BypassRecovery)
  local reduction = ( GetTime() - self.LastCastTime ) / ( Duration - CD );
  CD = CD * reduction;
  return CD > 0 and CD or 0
end

-- cooldown.foo.up
function Spell:CooldownUp(BypassRecovery)
  return self:CooldownRemains(BypassRecovery) == 0
end

-- "cooldown.foo.down"
-- Since it doesn't exists in SimC, I think it's better to use 'not Spell:CooldownUp' for consistency with APLs.
function Spell:CooldownDown(BypassRecovery)
  return self:CooldownRemains(BypassRecovery) ~= 0
end

-- action.foo.charges or cooldown.foo.charges
function Spell:Charges(BypassRecovery)
  local Charges, MaxCharges = self:ChargesInfo()

  -- Take in account the recharge prediction (let's say the recharge is 300ms and you're half-way through the GCD, it would return 0 so we display a new charge)
  if Charges < MaxCharges and self:Recharge(BypassRecovery) == 0 then
    Charges = Charges + 1
  end

  return Charges
end

-- action.foo.max_charges or cooldown.foo..max_charges
function Spell:MaxCharges()
  local _, MaxCharges = self:ChargesInfo()

  return MaxCharges
end

-- action.foo.recharge_time or cooldown.foo.recharge_time
function Spell:Recharge(BypassRecovery)
  local Charges, MaxCharges, StartTime, Duration = self:ChargesInfo()
  if Charges == MaxCharges then return 0 end
  local Recharge = StartTime + Duration - GetTime() - HL.RecoveryOffset(BypassRecovery)

  return Recharge > 0 and Recharge or 0
end

-- action.foo.charges_fractional or cooldown.foo.charges_fractional
function Spell:ChargesFractional(BypassRecovery)
  local Charges, MaxCharges, _, Duration = self:ChargesInfo()
  if Charges == MaxCharges then return Charges end

  return Charges + ((Duration - self:Recharge(BypassRecovery)) / Duration) -- charges + (chargeDuration - recharge) / chargeDuration
end

-- action.foo.full_recharge_time or cooldown.foo.charges_full_recharge_time
function Spell:FullRechargeTime(BypassRecovery)
  local Charges, MaxCharges, _, Duration = self:ChargesInfo()
  if Charges == MaxCharges then return 0 end

  return (MaxCharges - self:ChargesFractional(BypassRecovery)) * Duration
end

-- action.foo.usable_in
function Spell:UsableIn(BypassRecovery)
  if self:Charges() > 0 then return 0 end

  return self:Recharge(BypassRecovery)
end
