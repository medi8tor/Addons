--- ============================ HEADER ============================
--- ======= LOCALIZE =======
-- Addon
local addonName, addonTable = ...
-- HeroLib
local HL = HeroLib
local Cache, Utils = HeroCache, HL.Utils
local Unit = HL.Unit
local Player, Pet, Target = Unit.Player, Unit.Pet, Unit.Target
local Focus, MouseOver = Unit.Focus, Unit.MouseOver
local Arena, Boss, Nameplate = Unit.Arena, Unit.Boss, Unit.Nameplate
local Party, Raid = Unit.Party, Unit.Raid
local Spell = HL.Spell
local Item = HL.Item
-- HeroRotation
local HR = HeroRotation()
local Monk = HR.Commons().Monk
-- Lua
local C_Timer = C_Timer
local tableremove = table.remove
local tableinsert = table.insert
-- WoW API
local GetTime = GetTime
-- File Locals

--- ============================ CONTENT ============================
--- ======= NON-COMBATLOG =======

--- ======= COMBATLOG =======
--- Combat Log Arguments
------- Base -------
--     1        2         3           4           5           6              7             8         9        10           11
-- TimeStamp, Event, HideCaster, SourceGUID, SourceName, SourceFlags, SourceRaidFlags, DestGUID, DestName, DestFlags, DestRaidFlags

------- Prefixes -------
--- SWING
-- N/A

--- SPELL & SPELL_PACIODIC
--    12        13          14
-- SpellID, SpellName, SpellSchool

------- Suffixes -------
--- _CAST_START & _CAST_SUCCESS & _SUMMON & _RESURRECT
-- N/A

--- _CAST_FAILED
--     15
-- FailedType

--- _AURA_APPLIED & _AURA_REMOVED & _AURA_REFRESH
--    15
-- AuraType

--- _AURA_APPLIED_DOSE
--    15       16
-- AuraType, Charges

--- _INTERRUPT
--      15            16             17
-- ExtraSpellID, ExtraSpellName, ExtraSchool

--- _HEAL
--   15         16         17        18
-- Amount, Overhealing, Absorbed, Critical

--- _DAMAGE
--   15       16       17       18        19       20        21        22        23
-- Amount, Overkill, School, Resisted, Blocked, Absorbed, Critical, Glancing, Crushing

--- _MISSED
--    15        16           17
-- MissType, IsOffHand, AmountMissed

------- Special -------
--- UNIT_DIED, UNIT_DESTROYED
-- N/A

--- End Combat Log Arguments

-- Arguments Variables

--------------------------
------- Brewmaster -------
--------------------------

-- Stagger Tracker
local StaggerSpellID = 115069
local StaggerDoTID = 124255
local IncomingDamage = {}



local function RegisterIncomingDamageTaken(Amount)
    -- If we have table values and any are older than 6 seconds, remove them.
    while #IncomingDamage > 0 and IncomingDamage[#IncomingDamage][1] < GetTime() - 6 do
        tableremove(IncomingDamage, #IncomingDamage)
    end
    -- Add the incoming damage taken time and amount to the front of the table.
    tableinsert(IncomingDamage, 1, {GetTime(), Amount})
end



-- incoming_damage_xxxxms isn't in the current APL, but we may want to use this for Defensives().
function Player:IncomingDamageTaken(Milliseconds)
    local DamageTaken = 0
    -- APL uses milliseconds. Convert to seconds.
    local TimeOffset = Milliseconds / 1000
    for i = 1, #IncomingDamage do
        if IncomingDamage[i][1] > GetTime() - TimeOffset then
            DamageTaken = DamageTaken + IncomingDamage[i][2]
        end
    end
    return DamageTaken
end

HL:RegisterForCombatEvent(function(...)
    local DestGUID, _, _, _, SpellID, _, _, Amount = select(8, ...)
    if Cache.Persistent.Player.Spec[1] == 268 and DestGUID == Player:GUID() then
        -- Damage is coming from our Stagger
      if Amount and Amount > 0 and not SpellID == StaggerDoTID  then
            -- Add to our table of incoming damage taken
            RegisterIncomingDamageTaken(Amount)
        end
    end
end, "SWING_DAMAGE", "SPELL_DAMAGE", "SPELL_PERIODIC_DAMAGE")


HL:RegisterForEvent( -- Reset our damage tables when we exit combat
function()
    if #IncomingDamage > 0 then
        for i = 0, #IncomingDamage do
            IncomingDamage[i] = nil
        end
    end
end, "PLAYER_REGEN_ENABLED")

-- Track Nuizao's Stomp
local ImpNiuzao = Spell(322740)
local Stomp = Spell(227291)
Monk.NiuzaoGUID = 0
Monk.LastNiuzaoStomp = 0
HL:RegisterForCombatEvent(function(...)
    local SourceGUID, _, _, _, DestGUID, _, _, _, SpellID = select(4, ...)
    if SourceGUID == Player:GUID() and SpellID == 132578 then
        Monk.NiuzaoGUID = DestGUID
    end
end, "SPELL_SUMMON")

HL:RegisterForCombatEvent(function(...)
    local SourceGUID, _, _, _, _, _, _, _, SpellID = select(4, ...)
    if SourceGUID == Monk.NiuzaoGUID and SpellID == 227291 then
        Monk.LastNiuzaoStomp = GetTime()
    end
end, "SPELL_DAMAGE")

HL:RegisterForCombatEvent(function(...)
    local DestGUID = select(8, ...)
    if DestGUID == Monk.NiuzaoGUID then
        Monk.NiuzaoGUID = 0
    end
end, "UNIT_DIED")
