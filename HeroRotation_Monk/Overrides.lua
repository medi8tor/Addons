--- ============================ HEADER ============================
  -- HeroLib
  local HL      = HeroLib
  local Cache   = HeroCache
  local Unit    = HL.Unit
  local Player  = Unit.Player
  local Pet     = Unit.Pet
  local Target  = Unit.Target
  local Spell   = HL.Spell
  local Item    = HL.Item
-- HeroRotation
  local HR      = HeroRotation()
  local Everyone = HR.Commons().Everyone

-- Spells
  local SpellBM = Spell.Monk.Brewmaster
  local SpellWW = Spell.Monk.Windwalker
-- Lua

--- ============================ CONTENT ============================
-- Brewmaster, ID: 268
local BMOldSpellIsCastable
BMOldSpellIsCastable = HL.AddCoreOverride ("Spell.IsCastable",
  function (self, BypassRecovery, Range, AoESpell, ThisUnit, Offset)
    local BaseCheck = BMOldSpellIsCastable(self, BypassRecovery, Range, AoESpell, ThisUnit, Offset)
    if self == SpellBM.TouchofDeath then
      return BaseCheck and self:IsUsable()
    else
      return BaseCheck
    end
  end
, 268)

-- Windwalker, ID: 269

-- Mistweaver, ID: 270
local MWIsReady
MWIsReady = HL.AddCoreOverride("Spell.IsReady",
  function (self, BypassRecovery, Range, AoESpell, ThisUnit, Offset)
    local RangeOK = true
    if Range then
      local RangeUnit = ThisUnit or Target
      RangeOK = RangeUnit:IsInRange(Range, AoESpell)
    end
    -- BaseCheck includes the range check and a global casting stop condition
    local BaseCheck = MWIsReady(self, BypassRecovery, Range, AoESpell, ThisUnit, Offset) and Everyone.ShouldStopCast(self)
    return BaseCheck  -- Simplified to just return the BaseCheck result
  end,
  270
)