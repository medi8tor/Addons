--- ============================ HEADER ============================
--- ======= LOCALIZE =======
-- Addon
local addonName, addonTable = ...
-- HeroDBC
local DBC = HeroDBC.DBC
-- HeroLib
local HL = HeroLib
local Cache = HeroCache
local Unit = HL.Unit
local Player = Unit.Player
local Target = Unit.Target
local Pet = Unit.Pet
local Spell = HL.Spell
local MultiSpell = HL.MultiSpell
local Item = HL.Item
local MergeTableByKey = HL.Utils.MergeTableByKey
-- HeroRotation
local HR = HeroRotation()
local Everyone = HR.Commons().Everyone

-- warrior.lua
Warrior = Warrior or {}

--- ============================ CONTENT ============================

-- Spell
if not Spell.Warrior then Spell.Warrior = {} end
Spell.Warrior.Commons = {
    -- Racials
    AncestralCall = Spell(274738),
    ArcaneTorrent = Spell(50613),
    BagofTricks = Spell(312411),
    Berserking = Spell(26297),
    BloodFury = Spell(20572),
    Fireblood = Spell(265221),
    LightsJudgment = Spell(255647),
    -- Abilities
    BattleShout = Spell(6673),
    BattleStance = Spell(386164),
    Charge = Spell(100),
    HeroicThrow = Spell(57755),
    Pummel = Spell(6552),
    Slam = Spell(1464),
    VictoryRush = Spell(34428),
    DefensiveStance = Spell(386208),
    -- Talents
    Avatar = Spell(107574),
    BerserkerRage = Spell(18499),
    BerserkersTorment = Spell(390123),
    Bladestorm = MultiSpell(446035, 227847, 389774),
    Bladestormcast = Spell(227847),
    BloodandThunder = Spell(384277),
    BitterImmunity = Spell(383762),
    DoubleTime = Spell(103827),
    ChampionsMight = Spell(386284),
    CrushingForce = Spell(382764),
    FrothingBerserker = Spell(215571),
    Hurricane = Spell(390563),
    ImmovableObject = Spell(394307),
    IntimidatingShout = Spell(5246),
    HeroicLeap = Spell(6544),
    ImpendingVictory = Spell(202168),
    OverwhelmingRage = Spell(382767),
    RallyingCry = Spell(97462),
    Ravager = Spell(228920),
    RumblingEarth = Spell(275339),
    Shockwave = Spell(46968),
    SonicBoom = Spell(390725),
    ChampionsSpear = Spell(376079),
    SpellReflection = Spell(23920),
    StormBolt = Spell(107570),
    ThunderClap = Spell(6343),
    ThunderousRoar = Spell(384318),
    TitanicThrow = Spell(384090),
    WarlordsTorment = Spell(390140),
    WreckingThrow = Spell(384110),
    -- Buffs
    AvatarBuff = Spell(107574),
    BattleShoutBuff = Spell(6673),
    ChampionsMightBuff = Spell(386286),
    HurricaneBuff = Spell(390581),
    WarMachineBuff = Spell(262232),
    VictoriousBuff = Spell(32216),
    CorruptBuff = Spell(421922),
    SupernovaBuff = Spell(424140),
    -- Debuffs
    ChampionsMightDebuff = Spell(376080),
    MarkofFyralathDebuff = Spell(414532),
    RavagerDebuff = Spell(228920), -- Dummy Debuff entry. Actually handled in Events.
    ThunderousRoarDebuff = Spell(397364),
    Corruption = Spell(410972),
    ChargeDebuff = Spell(105771),
    -- Pool
    Pool = Spell(999910)
}

Spell.Warrior.Colossus = {
    -- Talents
    Demolish = Spell(436358),
    -- Buffs
    ColossalMightBuff = Spell(440989)
}

Spell.Warrior.MountainThane = {
    -- Abilities
    ThunderBlastAbility = Spell(435222),
    -- Talents
    CrashingThunder = Spell(436707),
    LightningStrikes = Spell(434969),
    ThunderBlast = Spell(435607),
    -- Buffs
    BurstofPowerBuff = Spell(437121),
    ThunderBlastBuff = Spell(435615)
}

Spell.Warrior.Slayer = {
    SlayerBladestorm                      = Spell(446035),
    -- Talents
    FierceFollowthrough                   = Spell(444773),
    Opportunist                           = Spell(444774),
    SlayersDominance                      = Spell(444767),
    UnrelentingOnslaught                  = Spell(444780),
    -- Buffs
    BrutalFinishBuff                      = Spell(446918),
    ImminentDemiseBuff                    = Spell(445606),
    OpportunistBuff                       = Spell(456120),
    -- Debuffs
    MarkedforExecutionDebuff              = Spell(445584),
}

Spell.Warrior.Fury = MergeTableByKey(Spell.Warrior.Commons, {
    -- Abilities
    BerserkerStance = Spell(386196),
    Bloodbath = Spell(335096),
    CrushingBlow = Spell(335097),
    Execute = MultiSpell(5308, 280735),
    Executecast = Spell(5308),
    Whirlwind = Spell(190411),
    -- Talents
    AngerManagement = Spell(152278),
    AshenJuggernaut = Spell(392536),
    Bloodthirst = Spell(23881),
    DancingBlades = Spell(391683),
    EnragedRegeneration = Spell(184364),
    ImprovedWhilwind = Spell(12950),
    Massacre = Spell(206315),
    MeatCleaver = Spell(280392),
    OdynsFury = Spell(385059),
    Onslaught = Spell(315720),
    RagingBlow = Spell(85288),
    Rampage = Spell(184367),
    RecklessAbandon = Spell(396749),
    Recklessness = Spell(1719),
    SlaughteringStrikes = Spell(388004),
    Tenderize = Spell(388933),
    TitanicRage = Spell(394329),
    TitansTorment = Spell(390135),
    Unhinged = Spell(386628),
    ViciousContempt = Spell(383885),
    WrathandFury = Spell(392936),
    -- Buffs
    AshenJuggernautBuff = Spell(392537),
    BloodbathBuff = Spell(461288),
    BloodcrazeBuff = Spell(393951),
    ChampionsMightBuff = Spell(386286),
    CrushingBlowBuff = Spell(396752),
    DancingBladesBuff = Spell(391688),
    EnrageBuff = Spell(184362),
    FuriousBloodthirstBuff = Spell(423211), -- T31 2pc
    MeatCleaverBuff = Spell(85739),
    MercilessAssaultBuff = Spell(409983),
    RecklessnessBuff = Spell(1719),
    SuddenDeathBuff = Spell(280776),
    -- Debuffs
    GushingWoundDebuff = Spell(385042),
    OdynsFuryDebuff = Spell(385060)
})

Spell.Warrior.Fury = MergeTableByKey(Spell.Warrior.Fury,
                                     Spell.Warrior.MountainThane)
Spell.Warrior.Fury = MergeTableByKey(Spell.Warrior.Fury, Spell.Warrior.Slayer)

Spell.Warrior.Arms = MergeTableByKey(Spell.Warrior.Commons, {
    -- Abilities
    Execute = MultiSpell(281000, 163201),
    Executecast = Spell(163201),
    Whirlwind = Spell(1680),
    -- Talents
    BlademastersTorment = Spell(390138),
    Bloodletting = Spell(383154),
    Cleave = Spell(845),
    ColossusSmash = Spell(167105),
    DiebytheSword = Spell(118038),
    Dreadnaught = Spell(262150),
    ExecutionersPrecision = Spell(386634),
    FervorofBattle = Spell(202316),
    IgnorePain = Spell(190456),
    ImprovedSweepingStrikes = Spell(383155),
    Massacre = Spell(281001),
    MercilessBonegrinder = Spell(383317),
    MortalStrike = Spell(12294),
    Overpower = Spell(7384),
    Rend = Spell(772),
    Skullsplitter = Spell(260643),
    SweepingStrikes = Spell(260708),
    Unhinged = Spell(386628),
    Warbreaker = Spell(262161),
    Juggernaut = Spell(393967),

    -- Buffs
    CollateralDamageBuff = Spell(334783),
    JuggernautBuff = Spell(383290),
    LethalBlowsBuff = Spell(455485), -- TWW S1 4pc
    MartialProwessBuff = Spell(7384),
    MercilessBonegrinderBuff = Spell(383316),
    StrikeVulnerabilitiesBuff = Spell(394173),
    SuddenDeathBuff = Spell(52437),
    SweepingStrikesBuff = Spell(260708),
    -- Debuffs
    ColossusSmashDebuff = Spell(208086),
    DeepWoundsDebuff = Spell(262115),

    ExecutionersPrecisionDebuff = Spell(386633),
    RendDebuff = Spell(388539),
    -- Abilities
  -- Talents
  Battlelord                            = Spell(386630),
  StrengthofArms                        = Spell(400803),
})

Spell.Warrior.Arms = MergeTableByKey(Spell.Warrior.Arms, Spell.Warrior.Colossus)
Spell.Warrior.Arms = MergeTableByKey(Spell.Warrior.Arms, Spell.Warrior.Slayer)

Spell.Warrior.Protection = MergeTableByKey(Spell.Warrior.Commons, {
    -- Abilities
    Devastate = Spell(20243),
    Execute = MultiSpell(163201, 281000),
    Executecast = Spell(163201),
    ShieldBlock = Spell(2565),
    ShieldSlam = Spell(23922),
    -- Talents
    BarbaricTraining = Spell(390675),
    Bolster = Spell(280001),
    BoomingVoice = Spell(202743),
    ChampionsBulwark = Spell(386328),
    DemoralizingShout = Spell(1160),
    EnduringDefenses = Spell(386027),
    HeavyRepercussions = Spell(203177),
    IgnorePain = Spell(190456),
    Intervene = Spell(3411),
    ImpenetrableWall = Spell(384072),
    Juggernaut = Spell(393967),
    LastStand = Spell(12975),
    Massacre = Spell(281001),
    Rend = Spell(394062),
    Revenge = Spell(6572),
    SeismicReverberation = Spell(382956),
    ShieldCharge = Spell(385952),
    ShieldWall = Spell(871),
    SuddenDeath = Spell(29725),
    UnnervingFocus = Spell(384042),
    UnstoppableForce = Spell(275336),
    -- Buffs
    EarthenTenacityBuff = Spell(410218), -- T30 4P
    FervidBuff = Spell(425517), -- T31 2P
    LastStandBuff = Spell(12975),
    RallyingCryBuff = Spell(97463),
    RevengeBuff = Spell(5302),
    SeeingRedBuff = Spell(386486),
    ShieldBlockBuff = Spell(132404),
    ShieldWallBuff = Spell(871),
    SuddenDeathBuff = Spell(52437),
    ViolentOutburstBuff = Spell(386478),
    VanguardsDeterminationBuff = Spell(394056), -- T29 2P
    -- Debuffs
    RendDebuff = Spell(388539)
})

Spell.Warrior.Protection = MergeTableByKey(Spell.Warrior.Protection,
                                           Spell.Warrior.Colossus)
Spell.Warrior.Protection = MergeTableByKey(Spell.Warrior.Protection,
                                           Spell.Warrior.MountainThane)

-- Items
if not Item.Warrior then Item.Warrior = {} end
Item.Warrior.Commons = {
    AlgetharPuzzleBox = Item(193701, {13, 14}),
    -- TWW Trinkets
    TreacherousTransmitter = Item(221023, {13, 14}),
    -- Other Items
    Fyralath = Item(206448, {16}),
    ShadowedRazingAnnihilator = Item(205046, {16})
}

Item.Warrior.Fury = MergeTableByKey(Item.Warrior.Commons, {})

Item.Warrior.Arms = MergeTableByKey(Item.Warrior.Commons, {})

Item.Warrior.Protection = MergeTableByKey(Item.Warrior.Commons, {})

Warrior.SpellReflectList = Everyone.converArrayToList({
    385536, -- FlameDance
    1217138, -- NecroticBolt
    369823, -- SpikedCarapace
    423479, -- WicklighterBolt
    264556, -- TearingStrike
    426541, -- RunicBolt
    341969, -- WitheringDischarge
    201837, -- ShadowBolt
    320637, -- FetidGas
    69839, -- UnstableOozeExplosion
    76851, -- Steelspark
    51971, -- ScourgeDisguiseInstability
    69840, -- UnstableOozeExplosionSummon
    88863, -- InstantPoison
    78003, -- [DND]Play
    52687, -- BombardtheBallistae:Knockback
    70185, -- Dizzy
    61438, -- NassHeartbeat
    28086, -- [PH]ButtressActivator
    85036, -- GodfreyQuestCredit
    84273, -- ReverseCastRide-CUSTOM
    77503, -- PetrifyingStare
    85551, -- SummonSmotheringOvergrowth
    93827, -- DarkspearChampion
    30875, -- TagMurloc
    72394, -- ReverseCastTurtleRide
    43427, -- IceLance
    85812, -- Chieftan'sCall
    73932, -- CitizenCostume
    39341, -- Karazhan-Chess,MedivhCHEAT:FuryofMedivh,TargetHorde
    36787, -- ForcefulCleave
    73424, -- Shrink
    69620, -- BoulderCrash
    42536, -- BrewfestRequestChickChuckMug
    28103, -- CreatePrimalWater
    41772, -- IncreasedCritical14
    77004, -- GnawsIIKillCredit
    73939, -- CitizenCostume
    32448, -- NetherAura
    78155, -- TremorTotem
    74706, -- SeeSpecialSoldier
    85310, -- PingHeadSeat
    31302, -- InfernoEffect
    87613, -- Gargal'sShieldWall
    39865, -- Rizzle'sBlackjack
    82249, -- OgrebladeSmash
    73693, -- ArcingSlash
    642, -- DivineShield
    90942, -- QuestCredit:Mylra
    51113, -- MonteMuzzleshot'sInvisibility(Mangal)
    27863, -- TheBaron'sUltimatum
    51241, -- ZP-Retch!(BunnyAura)
    51114, -- MonteMuzzleshot'sInvisibility(Camp)
    73698, -- VoidRift
    77405, -- StripVisionAuras
    65880, -- FrostTrap
    65881, -- ViperSting
    72808, -- BloodbathedFrostbroodVanquisher
    23015, -- CrystalPrison
    65372, -- SummonPossessedAncientGroveHippogryph
    24420, -- ZandalarSignetofSerenity
    72683, -- UpdateCathedralAuras
    219386, -- GrapplingHook
    89804, -- MeteorShard
    437839, -- NetherRift
    19669, -- ArcaniteSkeletonKey
    378818, -- MagmaConflagration
    429153, -- TwistingSinge
    387125, -- Thunderstrike
    384823, -- Inferno
    334748, -- DrainFluids
    381379, -- DecayedSenses
    387127, -- ChainLightning
    326319, -- SpiritBolt
    322486, -- Overgrowth
    416256, -- Stonebolt
    264105, -- RunicMark
    376783, -- FlameEruption
    75992, -- LightningSurge
    260699, -- SoulBolt
    429545, -- CensoringGear
    384194, -- Cinderbolt
    333602, -- Frostbolt
    388923, -- BurstForth
    260700, -- RuinousBolt
    430186, -- SeepingCorruption
    372315, -- FrostSpike
    427885, -- ArcaneBlast
    474388, -- Flamethrower
    428526, -- InkBlast
    201361, -- DarksoulBite
    384197, -- Cinderbolt
    396206, -- StormShock
    436322, -- PoisonBolt
    324923, -- BrambleBurst
    374365, -- VolatileMutation
    386757, -- Hailstorm
    382670, -- GaleArrow
    417030, -- Fireball
    429422, -- StoneBolt
    257063, -- BrackishBolt
    429173, -- MindRot
    389443, -- PurifyingBlast
    266036, -- DrainEssence
    421638, -- WicklighterBarrage
    437733, -- BoilingFlames
    413590, -- NoxiousEjection
    327100, -- NoxiousFog
    429048, -- FlameShock
    429176, -- Aquablast
    375649, -- InfusedGround
    462776, -- SurveyingBeam
    371306, -- ArcaneBolt
    280604, -- IcedSpritzer
    1215415, -- StickySludge
    254959, -- Soulburn
    473126, -- Mudslide
    427900, -- MoltenPool
    375653, -- StaticJolt
    384978, -- DragonStrike
    204243, -- TormentingEye
    428542, -- CrushingDepths
    428161, -- MoltenMetal
    388942, -- ViciousAmbush
    388817, -- ShardsofStone
    469811, -- Backwash
    168092, -- WaterBolt
    372718, -- EarthenShards
    392395, -- ThunderJaw
    465595, -- LightningBolt
    274991, -- PutridWaters
    447966, -- ShadowflameBolt
    1216475, -- NecroticBolt
    418202, -- TemporalBlast
    278444, -- Infest
    459210, -- ShadowClaw
    386012, -- Stormbolt
    263628, -- ChargedShield
    164965, -- ChokingVines
    413607, -- CorrodingVolley
    330697, -- DecayingStrike
    404154, -- VoidSurge
    374389, -- GulpSwogToxin
    1214468, -- Trickshot
    397386, -- LavaBolt
    460847, -- ElectricBlast
    252923, -- VenomBlast
    253562, -- Wildfire
    426768, -- LightningBolt
    431494, -- BlackEdge
    330810, -- BindSoul
    407121, -- Immolate
    372222, -- ArcaneCleave
    430238, -- VoidBolt
    467907, -- FesteringVoid
    415435, -- InfiniteBolt
    333299, -- CurseofDesolation
    1222949, -- WellofDarkness
    330784, -- NecroticBolt
    427951, -- SealofFlame
    427357, -- HolySmite
    427469, -- Fireball
    268846, -- EchoBlade
    375727, -- SandBreath
    424421, -- Fireball
    322274, -- Enfeeble
    428563, -- FlameBolt
    260323, -- AlphaCannon
    381530, -- StormShock
    465871, -- BloodBlast
    272581, -- WaterBolt
    369417, -- VenomousFangs
    260701, -- BrambleBolt
    411958, -- Stonebolt
    369610, -- ShockingQuake
    1215934, -- RockLance
    421284, -- CoilingFlames
    164886, -- DreadpetalPollen
    436996, -- StalkingShadows
    373692, -- Inferno
    369674, -- StoneSpike
    428263, -- WaterBolt
    369675, -- ChainLightning
    320462, -- NecroticBolt
    264024, -- SoulBolt
    264153, -- Spit
    164973, -- DancingThorns
    410351, -- FlamingCudgel
    266225, -- DarkenedLightning
    431303, -- NightBolt
    374020, -- ContainmentBeam
    369006, -- BurningHeat
    294195, -- ArcingZap
    168040, -- Nature'sWrath
    395690, -- LightningBlast
    426677, -- CandleflameBolt
    384014, -- StaticSurge
    369365, -- CurseofStone
    291878, -- PulseBlast
    451222, -- VoidRush
    422700, -- ExtinguishingGust
    426783, -- MindFlay
    374789, -- InfusedStrike
    374343, -- EnergyBomb
    376827, -- ConductiveStrike
    436640, -- BurningRicochet
    325223, -- AnimaInjection
    374535, -- HeatedSwings
    400165, -- EpochBolt
    323730, -- FrozenBinds
    201298, -- Bloodbolt
    333479, -- SpewDisease
    369399, -- StoneBolt
    267824, -- ScarSoul
    450087, -- Depth'sGrasp
    250096, -- WrackingPain
    392394, -- FireMaw
    320788, -- FrozenBinds
    446717, -- UmbralWeave
    385958, -- ArcaneExpulsion
    430109, -- LightningBolt
    371984, -- Icebolt
    200684, -- NightmareToxin
    324589, -- DeathBolt
    322493, -- FrostboltVolley
    381694, -- DecayedSenses
    263943, -- Etch
    384761, -- WindBurst
    326092, -- DebilitatingPoison
    323057, -- SpiritBolt
    387571, -- FocusedDeluge
    375251, -- LavaSpray
    199663, -- SoulBlast
    76820, -- Hex
    200238, -- FeedontheWeak
    438860, -- UmbralWeave
    401525, -- ScorchingDetonation
    432031, -- GraspingBlood
    434786, -- WebBolt
    385963, -- FrostShock
    323250, -- AnimaPuddle
    322655, -- AcidExpulsion
    383231, -- LavaBolt
    426283, -- ArcingVoid
    428889, -- FoulBolt
    375950, -- IceShard
    169657, -- PoisonousClaws
    385536, -- Flame Dance
    1217138, -- Necrotic Bolt
    369823, -- Spiked Carapace
    423479, -- Wicklighter Bolt
    264556, -- Tearing Strike
    426541, -- Runic Bolt
    341969, -- Withering Discharge
    201837, -- Shadow Bolt
    320637, -- Fetid Gas
    69839, -- Unstable Ooze Explosion
    76851, -- Steelspark
    51971, -- Scourge Disguise Instability
    69840, -- Unstable Ooze Explosion Summon
    88863, -- Instant Poison
    78003, -- [DND] Play
    52687, -- Bombard the Ballistae: Knockback
    70185, -- Dizzy
    61438, -- Nass Heartbeat
    28086, -- [PH] Buttress Activator
    85036, -- Godfrey Quest Credit
    84273, -- Reverse Cast Ride - CUSTOM
    77503, -- Petrifying Stare
    85551, -- Summon Smothering Overgrowth
    93827, -- Darkspear Champion
    30875, -- Tag Murloc
    72394, -- Reverse Cast Turtle Ride
    43427, -- Ice Lance
    85812, -- Chieftan's Call
    73932, -- Citizen Costume
    39341, -- Karazhan - Chess, Medivh CHEAT: Fury of Medivh, Target Horde
    36787, -- Forceful Cleave
    73424, -- Shrink
    69620, -- Boulder Crash
    42536, -- Brewfest Request Chick Chuck Mug
    28103, -- Create Primal Water
    41772, -- Increased Critical 14
    77004, -- Gnaws II Kill Credit
    73939, -- Citizen Costume
    32448, -- Nether Aura
    78155, -- Tremor Totem
    74706, -- See Special Soldier
    85310, -- Ping Head Seat
    31302, -- Inferno Effect
    87613, -- Gargal's Shield Wall
    39865, -- Rizzle's Blackjack
    82249, -- Ogreblade Smash
    73693, -- Arcing Slash
    642, -- Divine Shield
    90942, -- Quest Credit: Mylra
    51113, -- Monte Muzzleshot's Invisibility (Mangal)
    27863, -- The Baron's Ultimatum
    51241, -- ZP - Retch! (Bunny Aura)
    51114, -- Monte Muzzleshot's Invisibility (Camp)
    73698, -- Void Rift
    77405, -- Strip Vision Auras
    65880, -- Frost Trap
    65881, -- Viper Sting
    72808, -- Bloodbathed Frostbrood Vanquisher
    23015, -- Crystal Prison
    65372, -- Summon Possessed Ancient Grove Hippogryph
    24420, -- Zandalar Signet of Serenity
    72683, -- Update Cathedral Auras
    219386, -- Grappling Hook
    89804, -- Meteor Shard
    437839, -- Nether Rift
    19669, -- Arcanite Skeleton Key
    378818, -- Magma Conflagration
    429153, -- Twisting Singe
    387125, -- Thunderstrike
    384823, -- Inferno
    334748, -- Drain Fluids
    381379, -- Decayed Senses
    387127, -- Chain Lightning
    326319, -- Spirit Bolt
    322486, -- Overgrowth
    416256, -- Stonebolt
    264105, -- Runic Mark
    376783, -- Flame Eruption
    75992, -- Lightning Surge
    260699, -- Soul Bolt
    429545, -- Censoring Gear
    384194, -- Cinderbolt
    333602, -- Frostbolt
    388923, -- Burst Forth
    260700, -- Ruinous Bolt
    430186, -- Seeping Corruption
    372315, -- Frost Spike
    427885, -- Arcane Blast
    474388, -- Flamethrower
    428526, -- Ink Blast
    201361, -- Darksoul Bite
    384197, -- Cinderbolt
    396206, -- Storm Shock
    436322, -- Poison Bolt
    324923, -- Bramble Burst
    374365, -- Volatile Mutation
    386757, -- Hailstorm
    382670, -- Gale Arrow
    417030, -- Fireball
    429422, -- Stone Bolt
    257063, -- Brackish Bolt
    429173, -- Mind Rot
    389443, -- Purifying Blast
    266036, -- Drain Essence
    421638, -- Wicklighter Barrage
    437733, -- Boiling Flames
    413590, -- Noxious Ejection
    327100, -- Noxious Fog
    429048, -- Flame Shock
    429176, -- Aquablast
    375649, -- Infused Ground
    462776, -- Surveying Beam
    371306, -- Arcane Bolt
    280604, -- Iced Spritzer
    1215415, -- Sticky Sludge
    254959, -- Soulburn
    473126, -- Mudslide
    427900, -- Molten Pool
    375653, -- Static Jolt
    384978, -- Dragon Strike
    204243, -- Tormenting Eye
    428542, -- Crushing Depths
    428161, -- Molten Metal
    388942, -- Vicious Ambush
    388817, -- Shards of Stone
    469811, -- Backwash
    168092, -- Water Bolt
    372718, -- Earthen Shards
    392395, -- Thunder Jaw
    465595, -- Lightning Bolt
    274991, -- Putrid Waters
    447966, -- Shadowflame Bolt
    1216475, -- Necrotic Bolt
    418202, -- Temporal Blast
    278444, -- Infest
    459210, -- Shadow Claw
    386012, -- Stormbolt
    263628, -- Charged Shield
    164965, -- Choking Vines
    413607, -- Corroding Volley
    330697, -- Decaying Strike
    404154, -- Void Surge
    374389, -- Gulp Swog Toxin
    1214468, -- Trickshot
    397386, -- Lava Bolt
    460847, -- Electric Blast
    252923, -- Venom Blast
    253562, -- Wildfire
    426768, -- Lightning Bolt
    431494, -- Black Edge
    330810, -- Bind Soul
    407121, -- Immolate
    372222, -- Arcane Cleave
    430238, -- Void Bolt
    467907, -- Festering Void
    415435, -- Infinite Bolt
    333299, -- Curse of Desolation
    1222949, -- Well of Darkness
    330784, -- Necrotic Bolt
    427951, -- Seal of Flame
    427357, -- Holy Smite
    427469, -- Fireball
    268846, -- Echo Blade
    375727, -- Sand Breath
    424421, -- Fireball
    322274, -- Enfeeble
    428563, -- Flame Bolt
    260323, -- Alpha Cannon
    381530, -- Storm Shock
    465871, -- Blood Blast
    272581, -- Water Bolt
    369417, -- Venomous Fangs
    260701, -- Bramble Bolt
    411958, -- Stonebolt
    369610, -- Shocking Quake
    1215934, -- Rock Lance
    421284, -- Coiling Flames
    164886, -- Dreadpetal Pollen
    436996, -- Stalking Shadows
    373692, -- Inferno
    369674, -- Stone Spike
    428263, -- Water Bolt
    369675, -- Chain Lightning
    320462, -- Necrotic Bolt
    264024, -- Soul Bolt
    264153, -- Spit
    164973, -- Dancing Thorns
    410351, -- Flaming Cudgel
    266225, -- Darkened Lightning
    431303, -- Night Bolt
    374020, -- Containment Beam
    369006, -- Burning Heat
    294195, -- Arcing Zap
    168040, -- Nature's Wrath
    395690, -- Lightning Blast
    426677, -- Candleflame Bolt
    384014, -- Static Surge
    369365, -- Curse of Stone
    291878, -- Pulse Blast
    451222, -- Void Rush
    422700, -- Extinguishing Gust
    426783, -- Mind Flay
    374789, -- Infused Strike
    374343, -- Energy Bomb
    376827, -- Conductive Strike
    436640, -- Burning Ricochet
    325223, -- Anima Injection
    374535, -- Heated Swings
    400165, -- Epoch Bolt
    323730, -- Frozen Binds
    201298, -- Bloodbolt
    333479, -- Spew Disease
    369399, -- Stone Bolt
    267824, -- Scar Soul
    450087, -- Depth's Grasp
    250096, -- Wracking Pain
    392394, -- Fire Maw
    320788, -- Frozen Binds
    446717, -- Umbral Weave
    385958, -- Arcane Expulsion
    430109, -- Lightning Bolt
    371984, -- Icebolt
    200684, -- Nightmare Toxin
    324589, -- Death Bolt
    322493, -- Frostbolt Volley
    381694, -- Decayed Senses
    263943, -- Etch
    384761, -- Wind Burst
    326092, -- Debilitating Poison
    323057, -- Spirit Bolt
    387571, -- Focused Deluge
    375251, -- Lava Spray
    199663, -- Soul Blast
    76820, -- Hex
    200238, -- Feed on the Weak
    438860, -- Umbral Weave
    401525, -- Scorching Detonation
    432031, -- Grasping Blood
    434786, -- Web Bolt
    385963, -- Frost Shock
    323250, -- Anima Puddle
    322655, -- Acid Expulsion
    383231, -- Lava Bolt
    426283, -- Arcing Void
    428889, -- Foul Bolt
    375950, -- Ice Shard
    169657, -- Poisonous Claws
    1219386, -- Scrap Rockets
    443694, -- Crude Weapons
    469620, -- Creeping Shadow
    294860, -- Blossom Blast
    293827, -- Giga-Wallop
    262270, -- Caustic Compound
    1215916, -- Mind Lash
    424420, -- Cinderblast
    423015, -- Castigator's Shield
    423536, -- Holy Smite
    319669, -- Spectral Reach
    323608, -- Dark Devastation
    330875, -- Spirit Frost
    430805 -- Arcing Void

})

Warrior.ShieldBlockList = Everyone.converArrayToList({
    439037, -- Disembowel
    458340, -- CosmicSimulacrum
    447261, -- Skullsplitter
    256627, -- SlobberKnocker
    440468, -- RimeDagger
    436592, -- CashCannon
    263586, -- ThrowShield
    434722, -- Subjugate
    338357, -- Tenderize
    320771, -- IcyShard
    446819, -- PhaseLunge
    444694, -- SavageAssault
    256867, -- HeavyHitter
    439646, -- ProcessofElimination
    443361, -- Gorge
    270926, -- DrillSmash
    334488, -- SeverFlesh
    320614, -- BloodGorge
    474350, -- ShreddationSawblade
    438949, -- VoraciousBite
    451364, -- BrutalStrike
    256709, -- SingingSteel
    324394, -- Shatter
    331319, -- SavageFlurry
    273470, -- GutShot
    256616, -- ToothBreaker
    424888, -- SeismicSmash
    324079, -- ReapingScythe
    445016, -- SpectralSlam
    443654, -- Infest
    272711, -- CrushingSlam
    434702, -- BrutalCrush
    450100, -- Crush
    448640, -- ShieldStampede
    459627, -- TankBuster
    320655, -- Crunch
    425561, -- NastyNibble
    433785, -- GraspingSlash
    439468, -- DownwardTrend
    428894, -- StonebreakerStrike
    432229, -- KegSmash
    466976, -- GoldKnuckles
    450042, -- Gorge
    323515, -- HatefulStrike
    460472, -- TheBigHit
    451408, -- Oust
    473009, -- ExplosiveShrapnel
    442995, -- SwarmingSurprise
    465171, -- GoblinGravi-Gun
    474406, -- GearGrinder
    440900, -- Liquefy
    434773, -- MeanMug
    262019, -- GreaseGun
    320376, -- Mutilate
    318102, -- FinishingBlow
    464112, -- Demolish
    448935, -- RecklessDelivery
    282945, -- BuzzSaw
    331224, -- Bonestorm
    267357, -- FanofKnives
    465128, -- WindUp
    449444, -- MoltenFlurry
    468932, -- WrenchWallop
    466748, -- InfectedBite
    422233, -- CrystallineSmash
    469479, -- SludgeClaws
    439031, -- BottomsUppercut
    424426, -- LungingStrike
    464876, -- ConcussiveSmash
    463206, -- Tenderize
    435000, -- HighSteaks
    320069, -- MortalStrike
    438651, -- SnackTime
    427621, -- Impale
    333845, -- UnbalancingBlow
    427361, -- Fracture
    460965, -- BarrelingCharge
    321807, -- Boneflay
    452151, -- RigorousJab
    466974, -- GoblinGun
    459799, -- Wallop
    422245, -- RockBuster
    285377, -- B.4.T.T.L.3.Mine
    320200, -- Stitchneedle
    424621, -- BrutalSmash
    434758, -- ThrowChair
    425027, -- SeismicWave
    268230 -- CrimsonSwipe

})

Warrior.SpellBlockList = Everyone.converArrayToList({
    473519, 441772, 474731, 433740, 443494, 422393, 431637, 272581, 321669,
    26283, 34252, 23479, 43433, 97127, 39991, 94195, 217294, 30238, 61563,
    22756, 26860, 34829, 35148, 20462, 48791, 40289, 40887, 28711, 20464, 35788,
    20784, 67385, 47966, 66519, 42484, 21638, 34707, 24421, 92035, 25974, 60847,
    57168, 20596, 29545, 214910, 219386, 33602, 35156, 62347, 217126, 30758,
    73652, 39811, 68260, 222949, 23547, 40577, 47271, 22274, 214190, 60388,
    29422, 42192, 40300, 41344, 59474, 93827, 27001, 27439, 37839, 74032, 48057,
    28086, 38860, 76234, 27616, 61487, 26968, 30109, 40304, 30186, 27897, 73351,
    35165, 30805, 56713, 39692, 43847, 29110, 45537, 215934, 63217, 25113,
    27900, 76068, 63218, 48492, 40141, 49130, 441289, 330784, 442437, 1214326,
    424460, 330720, 330875, 453212, 419871, 1217138, 330697, 324589, 474084,
    462776, 440149, 1215636, 1215741, 438807, 428161, 322655, 423665, 291928,
    436322, 473081, 322465, 427951, 451113, 427472, 465666, 459210, 451114,
    430013, 432117, 1216611, 425554, 443274, 452008, 446717, 448566, 1217933,
    441612, 263628, 421282, 469796, 451606, 256639, 444743, 465462, 451387,
    291878, 423324, 448888, 460427, 465595, 468727, 427469, 444363, 427597,
    439646, 465830, 426259, 465871, 1215916, 465466, 272588, 427854, 1215410,
    441242, 1215412, 424795, 1217964, 472794, 473126, 427601, 1215504, 460158,
    439778, 269100, 426136, 262270, 431364, 432448, 260323, 260103, 426265,
    432959, 431493, 465982, 473440, 423015, 431494, 431303, 294860, 294961,
    430171, 1218117, 428563, 323057, 439401, 426677, 442589, 432198, 461842,
    274991, 453810, 423019, 424322, 448562, 442530, 427100, 324909, 1216475,
    1217496, 441395, 444250, 428276, 432903, 427357, 434786, 438960, 420919,
    76369, 257063, 445518, 422700, 425394, 437733, 442536, 441362, 443491,
    443397, 322557, 426787, 423536, 436640, 469819, 322493, 443427, 456751,
    438200, 438656, 436996, 440687, 451971, 438012
})
