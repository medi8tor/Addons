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
if not v9.Shaman then
	v9.Shaman = {};
end
v9.Shaman.Commons = {AncestralCall=v9(858975 - 584237),BagofTricks=v9(894067 - 581656),Berserking=v9(50761 - 24464),BloodFury=v9(86799 - 53102),Fireblood=v9(265840 - (555 + 64)),Bloodlust=v10(3756 - (857 + 74), 32750 - (367 + 201)),Bloodlustcast=v9(3752 - (214 + 713)),FlameShock=v10(47157 + 141232, 73982 + 396429),FlametongueWeapon=v9(318915 - (282 + 595)),FrostShock=v9(198477 - (1523 + 114)),GhostWolf=v9(2377 + 268),HealingSurge=v9(11410 - 3406),HealingStreamTotem=v9(6459 - (68 + 997)),LightningBolt=v9(189466 - (226 + 1044)),LightningShield=v9(836507 - 644401),SkyFury=v9(462971 - (32 + 85)),AstralShift=v9(106107 + 2164),AncestralGuidance=v9(24012 + 84269),CapacitorTotem=v9(193015 - (892 + 65)),ChainLightning=v9(449536 - 261093),CleanseSpirit=v9(95907 - 44021),EarthElemental=v9(363682 - 165579),EarthShield=v9(1324 - (87 + 263)),ElementalBlast=v9(117194 - (67 + 113)),ElementalOrbit=v9(280851 + 102159),LavaBurst=v9(126453 - 74948),DeeplyRootedElements=v9(278200 + 100070),Hex=v9(204741 - 153227),NaturesSwiftness=v9(379033 - (802 + 150)),PrimordialWave=v9(1012270 - 636288),Purge=v9(671 - 301),StoneBulkwarkTotem=v9(78809 + 29461),SpiritwalkersGrace=v9(80203 - (915 + 82)),TotemicRecall=v9(306617 - 198332),Thunderstorm=v9(29996 + 21494),WindShear=v9(76269 - 18275),EarthShieldOtherBuff=v9(2161 - (1069 + 118)),EarthShieldSelfBuff=v9(870386 - 486738),LightningShieldBuff=v9(420226 - 228120),PrimordialWaveBuff=v9(65365 + 310621),SpiritwalkersGraceBuff=v9(140733 - 61527),SplinteredElementsBuff=v9(378987 + 3056),SkyFuryBuff=v9(463645 - (368 + 423)),FlameShockDebuff=v9(592046 - 403657),EntangledDebuff=v9(408574 - (10 + 8)),Corruption=v9(1580899 - 1169927),LightningRodDebuff=v9(197651 - (416 + 26)),EnfeeblingSpittle=v9(1507466 - 1035338),ChaosBrandDebuff=v9(640 + 850),HuntersMarkDebuff=v9(455246 - 197962),SpymastersWebBuff=v9(445397 - (145 + 293)),Pool=v9(1000340 - (44 + 386))};
v9.Shaman.Farseer = {AncestralSwiftness=v9(444940 - (998 + 488)),ElementalReverb=v9(140871 + 302547),PrimordialCapacity=v9(363105 + 80343)};
v9.Shaman.Stormbringer = {TempestAbility=v9(452973 - (201 + 571)),TempestOverload=v9(464489 - (116 + 1022)),ArcDischarge=v9(1894686 - 1439590),AwakeningStorms=v9(267150 + 187979),RollingThunder=v9(1657508 - 1203482),Supercharge=v9(1616135 - 1161025),Tempest=v9(454868 - (814 + 45)),ArcDischargeBuff=v9(1121342 - 666245),AwakeningStormsBuff=v9(24902 + 437229),TempestBuff=v9(160421 + 293594)};
v9.Shaman.Totemic = {AmplificationCore=v9(445914 - (261 + 624)),Earthsurge=v9(809627 - 354037),LivelyTotems=v9(446114 - (1020 + 60)),SurgingTotem=v9(446418 - (630 + 793)),TotemicRebound=v9(1508041 - 1063016),LivelyTotemsBuff=v9(2183869 - 1722627),TotemicReboundBuff=v9(180483 + 277786),WhirlingAirBuff=v9(1561106 - 1107697),WhirlingEarthBuff=v9(455153 - (760 + 987)),WhirlingFireBuff=v9(455318 - (1789 + 124))};
v9.Shaman.Elemental = v12(v9.Shaman.Commons, {EarthShock=v9(8808 - (745 + 21)),Earthquake1=v9(21286 + 40596),Earthquake2=v9(1272966 - 810346),Earthquake=v10(242732 - 180850, 3783 + 458837),Earthquakecast=v9(48585 + 13297),FireElemental=v9(199122 - (87 + 968)),Ascendance=v9(502041 - 387991),EchoChamber=v9(346605 + 35427),EchooftheElements=v9(754839 - 420920),EchoesofGreatSundering=v9(385500 - (447 + 966)),ElectrifiedShocks=v9(1046018 - 663932),EyeoftheStorm=v9(383525 - (1703 + 114)),FlowofPower=v9(386624 - (376 + 325)),FluxMelting=v9(625651 - 243875),FusionofElements=v9(1424147 - 961307),Icefury=v9(60218 + 150496),ImprovedFlametongueWeapon=v9(841408 - 459381),LavaBeam=v9(114088 - (9 + 5)),LightningRod=v9(211065 - (85 + 291)),LiquidMagmaTotem=v9(193487 - (243 + 1022)),MagmaChamber=v9(1453319 - 1071387),MasteroftheElements=v9(13337 + 2829),MountainsWillFall=v9(382906 - (1123 + 57)),PoweroftheMaelstrom=v9(156107 + 35754),PrimalElementalist=v9(117267 - (163 + 91)),SearingFlames=v9(383712 - (1869 + 61)),SkybreakersFieryDemise=v9(105690 + 272620),SplinteredElements=v9(1345556 - 963514),StormElemental=v9(295284 - 103035),Stormkeeper=v9(26223 + 165411),SurgeofPower=v9(360468 - 98165),SwellingMaelstrom=v9(361018 + 23341),ThunderstrikeWard=v9(464231 - (1329 + 145)),AscendanceBuff=v9(115021 - (140 + 831)),EchoesofGreatSunderingBuff=v9(385938 - (1409 + 441)),FluxMeltingBuff=v9(382495 - (15 + 703)),FusionofElementsFire=v9(214345 + 248498),FusionofElementsNature=v9(463279 - (262 + 176)),IcefuryBuff=v9(212435 - (345 + 1376)),LavaSurgeBuff=v9(78450 - (198 + 490)),MagmaChamberBuff=v9(1687364 - 1305431),MasteroftheElementsBuff=v9(625420 - 364686),PoweroftheMaelstromBuff=v9(193083 - (696 + 510)),StormkeeperBuff=v9(401911 - 210277),SurgeofPowerBuff=v9(286776 - (1091 + 171)),ElectrifiedShocksDebuff=v9(61487 + 320602),MaelstromSurgeBuff=v9(1441079 - 983352)});
v9.Shaman.Elemental = v12(v9.Shaman.Elemental, v9.Shaman.Farseer);
v9.Shaman.Elemental = v12(v9.Shaman.Elemental, v9.Shaman.Stormbringer);
v9.Shaman.Enhancement = v12(v9.Shaman.Commons, {PoisonCleansingTotem=v9(1270199 - 887186),SpiritWalk=v9(59249 - (123 + 251)),VoltaicBlazeAbility=v9(2335690 - 1865633),Windstrike=v9(116054 - (208 + 490)),AlphaWolf=v9(16745 + 181689),Ascendance=v9(50804 + 63247),AshenCatalyst=v9(391206 - (660 + 176)),PrimordialStorm=v9(146342 + 1071705),PrimordialStormAbility=v9(1218292 - (14 + 188)),ConvergingStorms=v9(385038 - (534 + 141)),CrashLightning=v9(75529 + 112345),CrashingStorms=v9(295710 + 38598),DoomWinds=v9(369534 + 14818),ElementalAssault=v9(443117 - 232264),ElementalSpirits=v9(416946 - 154322),FeralSpirit=v9(144552 - 93019),FireNova=v9(179336 + 154638),FlowingSpirits=v9(298819 + 170495),Hailstorm=v9(334591 - (115 + 281)),HotHand=v9(469626 - 267726),IceStrike=v10(283355 + 58885, 1136343 - 666149),LashingFlames=v9(1224880 - 890834),LavaLash=v9(60970 - (550 + 317)),LegacyoftheFrostWitch=v9(555446 - 170996),MoltenAssault=v9(469507 - 135474),OverflowingMaelstrom=v9(1073496 - 689347),RagingMaelstrom=v9(384428 - (134 + 151)),StaticAccumulation=v9(386076 - (970 + 695)),Stormblast=v9(610502 - 290572),Stormflurry=v9(346347 - (582 + 1408)),Stormstrike=v9(60219 - 42855),Sundering=v9(248138 - 50924),SwirlingMaelstrom=v9(1448401 - 1064042),ThorimsInvocation=v9(386268 - (1195 + 629)),UnrelentingStorms=v9(622222 - 151732),UnrulyWinds=v9(390529 - (187 + 54)),VoltaicBlaze=v9(470833 - (162 + 618)),WindfuryTotem=v9(5965 + 2547),WindfuryWeapon=v9(22484 + 11273),WitchDoctorsAncestry=v9(819910 - 435463),AscendanceBuff=v9(191741 - 77690),AshenCatalystBuff=v9(30523 + 359848),ConvergingStormsBuff=v9(199936 - (1373 + 263)),CracklingThunderBuff=v9(410834 - (451 + 549)),CrashLightningBuff=v9(59306 + 128572),CLCrashLightningBuff=v9(519731 - 185767),DoomWindsBuff=v9(784485 - 317713),EarthenWeaponBuff=v9(393759 - (746 + 638)),ElectrostaticWagerBuff=v9(460415 + 762995),ElectrostaticWagerDmg=v9(1857363 - 634031),FeralSpiritBuff=v9(334298 - (218 + 123)),GatheringStormsBuff=v9(199881 - (1535 + 46)),HailstormBuff=v9(332058 + 2138),HotHandBuff=v9(31225 + 184560),IceStrikeBuff=v9(384917 - (306 + 254)),LegacyoftheFrostWitchBuff=v9(23801 + 360650),MaelstromWeaponBuff=v9(675465 - 331286),PrimordialStormBuff=v9(1219592 - (899 + 568)),StormblastBuff=v9(309238 + 161228),StormsurgeBuff=v9(488447 - 286601),WindfuryTotemBuff=v9(328545 - (268 + 335)),WinningStreakBuff=v9(1218906 - (60 + 230)),LashingFlamesDebuff=v9(334740 - (426 + 146)),CracklingSurgeBuff=v9(26849 + 197278),IcyEdgeBuff=v9(225582 - (282 + 1174)),MoltenWeaponBuff=v9(224936 - (569 + 242)),MaelstromofElementsBuff=v9(1136904 - 742227),VolcanicStrengthBuff=v9(23437 + 386396)});
v9.Shaman.Enhancement = v12(v9.Shaman.Enhancement, v9.Shaman.Stormbringer);
v9.Shaman.Enhancement = v12(v9.Shaman.Enhancement, v9.Shaman.Totemic);
v9.Shaman.Restoration = v12(v9.Shaman.Commons, {Soulshape=v9(311167 - (706 + 318)),LavaSurge=v9(79013 - (721 + 530)),EarthShieldT=v9(384919 - (945 + 326)),PrimordialWaveBuff=v9(939332 - 563346),VesperTotem=v9(288645 + 35741),SpiritWalkersTidalTotem=v9(336591 - (271 + 429)),TidalWaves=v9(49045 + 4345),Undulation=v9(217751 - (1408 + 92)),ChargedPhylactery=v9(346635 - (461 + 625)),Hightide=v9(289963 - (993 + 295)),Tidebringer=v9(12281 + 224221),SpatialParadox=v9(407903 - (418 + 753)),HealingSurge=v9(3049 + 4955),GhostWolf=v9(273 + 2372),Riptide=v9(17928 + 43367),HealingWave=v9(19580 + 57892),ChainHeal=v9(1593 - (406 + 123)),HealingRain=v9(75689 - (1749 + 20)),HealingStreamTotem=v9(1282 + 4112),WaterShield=v9(53449 - (1249 + 73)),EarthShield=v9(348 + 626),FlameShock=v9(189534 - (466 + 679)),FrostShock=v9(473492 - 276652),LavaBurst=v9(147313 - 95808),LightningBolt=v9(190096 - (106 + 1794)),ChainLightning=v9(59615 + 128828),HealingTideTotem=v9(27371 + 80909),SpiritLinkTotem=v9(289358 - 191350),SpiritWalkersGrace=v9(214485 - 135279),ManaTideTotem=v9(16305 - (4 + 110)),AstralShift=v9(108855 - (57 + 527)),WindShear=v9(59421 - (41 + 1386)),PrimordialWave=v9(428435 - (17 + 86)),Ascendance=v9(77408 + 36644),UnleashLife=v9(164326 - 90641),SurgeofEarth=v9(928862 - 608116),EarthenWallTotem=v9(199004 - (122 + 44)),AncestralProtectionTotem=v9(358246 - 150847),WindRushTotem=v9(637209 - 445132),Downpour=v9(376321 + 86282),CloudburstTotem=v9(22728 + 134425),Wellspring=v9(401109 - 203114),PurifySpirit=v9(77195 - (30 + 35)),PoisonCleansingTotem=v9(263249 + 119764),EarthElemental=v9(199360 - (1043 + 214)),Purge=v9(1398 - 1028),EarthlivingWeapon=v9(383233 - (323 + 889)),StormKeeper=v9(1030922 - 647913),CapacitorTotem=v9(192638 - (361 + 219)),Thunderstorm=v9(51810 - (53 + 267)),EarthbindTotem=v9(562 + 1922),Hex=v9(51927 - (15 + 398)),TotemicProjection=v9(109269 - (18 + 964)),TremorTotem=v9(30651 - 22508),AncestralVision=v9(122768 + 89280),ImprovedPurifySpirit=v9(241314 + 141702),ElementalOrbit=v9(383860 - (20 + 830)),AcidRain=v9(295409 + 83034)});
v9.Shaman.Restoration = v12(v9.Shaman.Restoration, v9.Shaman.Farseer);
v9.Shaman.Restoration = v12(v9.Shaman.Restoration, v9.Shaman.Totemic);
if not v11.Shaman then
	v11.Shaman = {};
end
v11.Shaman.Commons = {SpymastersWeb=v11(220328 - (116 + 10), {(751 - (542 + 196)),(5 + 9)}),AlgetharPuzzleBox=v11(98414 + 95287, {(33 - 20),(1565 - (1126 + 425))}),BeacontotheBeyond=v11(204368 - (118 + 287), {(1134 - (118 + 1003)),(391 - (142 + 235))}),ElementiumPocketAnvil=v11(919175 - 716558, {(990 - (553 + 424)),(13 + 1)}),ManicGrieftorch=v11(192750 + 1558, {(6 + 7),(29 - 15)}),ScreamingBlackDragonScale=v11(564540 - 361928, {(4 + 9),(767 - (239 + 514))}),BroodkeepersPromise=v11(68243 + 126064, {(10 + 3),(32 - 18)})};
v11.Shaman.Enhancement = v12(v11.Shaman.Commons, {});
v11.Shaman.Elemental = v12(v11.Shaman.Commons, {});
v11.Shaman.Restoration = v12(v11.Shaman.Commons, {});
