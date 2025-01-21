local v0, v1 = ...;
local v2 = HeroDBC.DBC;
local v3 = HeroLib;
local v4 = HeroCache;
local v5 = v3.Unit;
local v6 = v5.Player;
local v7 = v5.Target;
local v8 = v5.Pet;
local v9 = v3.Spell;
local v10 = v3.MultiSpell;
local v11 = v3.Item;
local v12 = v3.Utils.MergeTableByKey;
local v13 = HeroRotation();
local v14 = {};
local v15 = v13.GUISettingsGet();
v13.Commons().DeathKnight = v14;
if not v9.DeathKnight then
	v9.DeathKnight = {};
end
v9.DeathKnight.Commons = {DeathAndDecay=v9(135269 - 92004),DeathCoil=v9(136054 - 88513),RaiseAlly=v9(119678 - 57679),AbominationLimb=v9(987261 - 603992),AntiMagicBarrier=v9(206346 - (555 + 64)),AntiMagicShell=v9(49638 - (857 + 74)),AntiMagicZone=v9(51620 - (367 + 201)),Lichborne=v9(49966 - (214 + 713)),Assimilation=v9(93714 + 280669),ChainsofIce=v9(7160 + 38364),CleavingStrikes=v9(317793 - (282 + 595)),DeathStrike=v9(51635 - (1523 + 114)),EmpowerRuneWeapon=v9(42748 + 4820),IceboundFortitude=v9(69556 - 20764),IcyTalons=v9(195943 - (68 + 997)),RaiseDead=v9(47855 - (226 + 1044)),RunicAttenuation=v9(901814 - 694710),SacrificialPact=v9(327691 - (32 + 85)),SoulReaper=v9(336432 + 6862),UnholyGround=v9(82996 + 291269),UnyieldingWill=v9(458531 - (892 + 65)),AbominationLimbBuff=v9(914299 - 531030),DeathAndDecayBuff=v9(348042 - 159752),DeathStrikeBuff=v9(186461 - 84893),EmpowerRuneWeaponBuff=v9(47918 - (87 + 263)),IcyTalonsBuff=v9(195059 - (67 + 113)),RuneofHysteriaBuff=v9(239721 + 87197),UnholyStrengthBuff=v9(131019 - 77654),AntiMagicZoneBuff=v9(107104 + 38525),BloodPlagueDebuff=v9(218906 - 163828),FrostFeverDebuff=v9(56047 - (802 + 150)),MarkofFyralathDebuff=v9(1116060 - 701528),SoulReaperDebuff=v9(622722 - 279428),VirulentPlagueDebuff=v9(139455 + 52132),AncestralCall=v9(275735 - (915 + 82)),ArcanePulse=v9(737240 - 476876),ArcaneTorrent=v9(29485 + 21128),BagofTricks=v9(410864 - 98453),Berserking=v9(27484 - (1069 + 118)),BloodFury=v9(46671 - 26099),Fireblood=v9(580163 - 314942),LightsJudgment=v9(44444 + 211203),MindFreeze=v9(84447 - 36919),Asphyxiate=v9(219790 + 1772),BlindingSleet=v9(207958 - (368 + 423)),ControlUndead=v9(350952 - 239279),Pool=v9(999928 - (10 + 8)),ConcoctionKissofDeathBuff=v9(1675225 - 1239732)};
v9.DeathKnight.Deathbringer = {DarkTalons=v9(437129 - (416 + 26)),Exterminate=v9(1409284 - 967906),ReapersMark=v9(188760 + 251083),PainfulDeath=v9(784856 - 341292),ExterminateBuff=v9(441854 - (145 + 293)),PainfulDeathBuff=v9(448384 - (44 + 386)),ReapersMarkDebuff=v9(436251 - (998 + 488))};
v9.DeathKnight.RideroftheApocalypse = {AFeastofSouls=v9(141079 + 302993),ApocalypseNow=v9(363590 + 80450),AFeastofSoulsBuff=v9(441633 - (201 + 571)),MograinesMightBuff=v9(445643 - (116 + 1022)),TrollbaneSlowDebuff=v9(1851963 - 1407129)};
v9.DeathKnight.Sanlayn = {VampiricStrikeAction=v9(254686 + 179209),GiftoftheSanlayn=v9(1584954 - 1150802),VampiricStrike=v9(1540820 - 1106919),EssenceoftheBloodQueenBuff=v9(434784 - (814 + 45)),GiftoftheSanlaynBuff=v9(1069737 - 635584),InflictionofSorrowBuff=v9(24790 + 435259),VampricStrikeBuff=v9(153313 + 280586)};
v9.DeathKnight.Blood = v12(v9.DeathKnight.Commons, {BloodBoil=v9(51727 - (261 + 624)),BloodTap=v9(393980 - 172281),Blooddrinker=v9(208011 - (1020 + 60)),Bonestorm=v9(196267 - (630 + 793)),Coagulopathy=v9(1326585 - 935108),Consumption=v9(1298062 - 1023906),DancingRuneWeapon=v9(19309 + 29719),DeathsCaress=v9(672398 - 477106),GorefiendsGrasp=v9(109946 - (760 + 987)),HeartStrike=v9(208843 - (1789 + 124)),Heartbreaker=v9(222302 - (745 + 21)),InsatiableBlade=v9(129895 + 247742),Marrowrend=v9(537071 - 341889),RapidDecomposition=v9(763564 - 568902),RelishinBlood=v9(2597 + 315013),RuneTap=v9(152847 + 41832),SanguineGround=v9(392513 - (87 + 968)),ShatteringBone=v9(1662349 - 1284709),TighteningGrasp=v9(187777 + 19193),Tombstone=v9(496888 - 277079),VampiricBlood=v9(56646 - (447 + 966)),BoneShieldBuff=v9(534337 - 339156),CoagulopathyBuff=v9(393298 - (1703 + 114)),CrimsonScourgeBuff=v9(81842 - (376 + 325)),DancingRuneWeaponBuff=v9(133161 - 51905),HemostasisBuff=v9(842928 - 568981),IceboundFortitudeBuff=v9(13944 + 34848),RuneTapBuff=v9(428777 - 234098),VampiricBloodBuff=v9(55247 - (9 + 5)),VampiricStrengthBuff=v9(408732 - (85 + 291))});
v9.DeathKnight.Blood = v12(v9.DeathKnight.Blood, v9.DeathKnight.Deathbringer);
v9.DeathKnight.Blood = v12(v9.DeathKnight.Blood, v9.DeathKnight.Sanlayn);
v9.DeathKnight.Frost = v12(v9.DeathKnight.Commons, {FrostStrike=v9(50408 - (243 + 1022)),HowlingBlast=v9(187153 - 137969),ArcticAssault=v9(376374 + 79856),Avalanche=v9(208322 - (1123 + 57)),BitingCold=v9(306790 + 70266),Bonegrinder=v9(377352 - (163 + 91)),BreathofSindragosa=v9(154209 - (1869 + 61)),ChillStreak=v9(85318 + 220074),ColdHeart=v9(990418 - 709210),EnduringStrength=v9(579345 - 202155),FrigidExecutioner=v9(51598 + 325475),Frostscythe=v9(284785 - 77555),FrostwyrmsFury=v9(262341 + 16961),GatheringStorm=v9(196386 - (1329 + 145)),GlacialAdvance=v9(195884 - (140 + 831)),HornofWinter=v9(59180 - (1409 + 441)),Icebreaker=v9(393668 - (15 + 703)),Icecap=v9(95922 + 111204),Obliterate=v9(49458 - (262 + 176)),Obliteration=v9(282959 - (345 + 1376)),PillarofFrost=v9(51959 - (198 + 490)),RageoftheFrozenChampion=v9(1665906 - 1288830),RemorselessWinter=v9(471990 - 275220),ShatteredFrost=v9(457199 - (696 + 510)),ShatteringBlade=v9(434257 - 227200),SmotheringOffense=v9(436267 - (1091 + 171)),TheLongWinter=v9(73419 + 382821),UnleashedFrenzy=v9(1186625 - 809720),BonegrinderFrostBuff=v9(1250599 - 873496),ColdHeartBuff=v9(281583 - (123 + 251)),KillingMachineBuff=v9(254032 - 202908),PillarofFrostBuff=v9(51969 - (208 + 490)),RimeBuff=v9(4984 + 54068),UnleashedFrenzyBuff=v9(167892 + 209015),RazoriceDebuff=v9(52550 - (660 + 176))});
v9.DeathKnight.Frost = v12(v9.DeathKnight.Frost, v9.DeathKnight.Deathbringer);
v9.DeathKnight.Frost = v12(v9.DeathKnight.Frost, v9.DeathKnight.RideroftheApocalypse);
v9.DeathKnight.Unholy = v12(v9.DeathKnight.Commons, {FesteringScytheAction=v9(55042 + 403086),Apocalypse=v9(275901 - (14 + 188)),ArmyoftheDead=v9(43325 - (534 + 141)),BurstingSores=v9(83324 + 123940),ClawingShadows=v9(183376 + 23935),CoilofDevastation=v9(375223 + 15047),CommanderoftheDead=v9(820146 - 429887),DarkTransformation=v9(100909 - 37349),Defile=v9(427152 - 274872),DoomedBidding=v9(244531 + 210855),EbonFever=v9(131971 + 75298),Epidemic=v9(207713 - (115 + 281)),FesteringStrike=v9(199918 - 113970),Festermight=v9(312623 + 64967),ImprovedDeathCoil=v9(912518 - 534938),Morbidity=v9(1384554 - 1006962),Outbreak=v9(78442 - (550 + 317)),Plaguebringer=v9(563717 - 173542),RaiseAbomination=v9(640091 - 184696),RaiseDead=v9(130177 - 83593),RottenTouch=v9(390560 - (134 + 151)),ScourgeStrike=v9(56755 - (970 + 695)),SummonGargoyle=v10(93896 - 44690, 209339 - (582 + 1408)),Superstrain=v9(1353531 - 963248),UnholyAssault=v9(260814 - 53525),UnholyBlight=v9(437087 - 321098),VileContagion=v9(392103 - (1195 + 629)),CommanderoftheDeadBuff=v9(516118 - 125858),DefileBuff=v9(218341 - (187 + 54)),FesteringScytheBuff=v9(458903 - (162 + 618)),FestermightBuff=v9(264577 + 113014),RunicCorruptionBuff=v9(34275 + 17185),SuddenDoomBuff=v9(173473 - 92133),DeathRotDebuff=v9(634717 - 257177),FesteringWoundDebuff=v9(15193 + 179117),RottenTouchDebuff=v9(391912 - (1373 + 263))});
v9.DeathKnight.Unholy = v12(v9.DeathKnight.Unholy, v9.DeathKnight.RideroftheApocalypse);
v9.DeathKnight.Unholy = v12(v9.DeathKnight.Unholy, v9.DeathKnight.Sanlayn);
if not v11.DeathKnight then
	v11.DeathKnight = {};
end
v11.DeathKnight.Commons = {AlgetharPuzzleBox=v11(194701 - (451 + 549), {(19 - 6),(1398 - (746 + 638))}),IrideusFragment=v11(72913 + 120830, {(354 - (218 + 123)),(14 + 0)}),VialofAnimatedBlood=v11(23099 + 136526, {(1 + 12),(1481 - (899 + 568))}),ManicGrieftorch=v11(127719 + 66589, {(616 - (268 + 335)),(586 - (426 + 146))}),ConcoctionKissofDeath=v11(25777 + 189397, {(824 - (569 + 242)),(1 + 13)}),MirrorofFracturedTomorrows=v11(208605 - (706 + 318), {(1284 - (945 + 326)),(13 + 1)}),TreacherousTransmitter=v11(221723 - (271 + 429), {(1513 - (1408 + 92)),(1302 - (993 + 295))}),Fyralath=v11(10720 + 195728, {(7 + 9)})};
v11.DeathKnight.Blood = v12(v11.DeathKnight.Commons, {});
v11.DeathKnight.Frost = v12(v11.DeathKnight.Commons, {});
v11.DeathKnight.Unholy = v12(v11.DeathKnight.Commons, {});
v13.ToggleIconFrame:AddButtonCustom("S", 1 + 0, "Small CDs", "smallcds");
v13.ToggleIconFrame:AddButtonCustom("T", 1 + 1, "Tab", "tab");
v13.ToggleIconFrame:AddButtonCustom("I", 1 + 2, "Interrupt", "interrupt");
v13.ToggleIconFrame:AddButtonCustom("D", 533 - (406 + 123), "DeathAndDecay", "deathanddecay");
