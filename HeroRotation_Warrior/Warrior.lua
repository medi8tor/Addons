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
local v14 = v13.Commons().Everyone;
Warrior = Warrior or {};
if not v9.Warrior then
	v9.Warrior = {};
end
v9.Warrior.Commons = {AncestralCall=v9(858975 - 584237),ArcaneTorrent=v9(144845 - 94232),BagofTricks=v9(603057 - 290646),Berserking=v9(67738 - 41441),BloodFury=v9(21191 - (555 + 64)),Fireblood=v9(266152 - (857 + 74)),LightsJudgment=v9(256215 - (367 + 201)),BattleShout=v9(7600 - (214 + 713)),BattleStance=v9(96663 + 289501),Charge=v9(16 + 84),HeroicThrow=v9(58632 - (282 + 595)),Pummel=v9(8189 - (1523 + 114)),Slam=v9(1316 + 148),VictoryRush=v9(49079 - 14651),DefensiveStance=v9(387273 - (68 + 997)),Avatar=v9(108844 - (226 + 1044)),BerserkerRage=v9(80551 - 62052),BerserkersTorment=v9(390240 - (32 + 85)),Bladestorm=v10(437119 + 8916, 50527 + 177320, 390731 - (892 + 65)),Bladestormcast=v9(543535 - 315688),BloodandThunder=v9(710310 - 326033),BitterImmunity=v9(704521 - 320759),DoubleTime=v9(104177 - (87 + 263)),ChampionsMight=v9(386464 - (67 + 113)),CrushingForce=v9(280671 + 102093),FrothingBerserker=v9(529261 - 313690),Hurricane=v9(287241 + 103322),ImmovableObject=v9(1567168 - 1172861),IntimidatingShout=v9(6198 - (802 + 150)),HeroicLeap=v9(17618 - 11074),ImpendingVictory=v9(366725 - 164557),OverwhelmingRage=v9(278612 + 104155),RallyingCry=v9(98459 - (915 + 82)),Ravager=v9(648204 - 419284),RumblingEarth=v9(160398 + 114941),Shockwave=v9(61769 - 14801),SonicBoom=v9(391912 - (1069 + 118)),ChampionsSpear=v9(853214 - 477135),SpellReflection=v9(52324 - 28404),StormBolt=v9(18701 + 88869),ThunderClap=v9(11269 - 4926),ThunderousRoar=v9(381244 + 3074),TitanicThrow=v9(384881 - (368 + 423)),WarlordsTorment=v9(1226085 - 835945),WreckingThrow=v9(384128 - (10 + 8)),AvatarBuff=v9(413808 - 306234),BattleShoutBuff=v9(7115 - (416 + 26)),ChampionsMightBuff=v9(1233379 - 847093),HurricaneBuff=v9(167619 + 222962),WarMachineBuff=v9(464001 - 201769),VictoriousBuff=v9(32654 - (145 + 293)),CorruptBuff=v9(422352 - (44 + 386)),SupernovaBuff=v9(425626 - (998 + 488)),ChampionsMightDebuff=v9(119478 + 256602),MarkofFyralathDebuff=v9(339428 + 75104),RavagerDebuff=v9(229692 - (201 + 571)),ThunderousRoarDebuff=v9(398502 - (116 + 1022)),Corruption=v9(1710986 - 1300014),ChargeDebuff=v9(62085 + 43686),Pool=v9(3650362 - 2650452)};
v9.Warrior.Colossus = {Demolish=v9(1549545 - 1113187),ColossalMightBuff=v9(441848 - (814 + 45))};
v9.Warrior.MountainThane = {ThunderBlastAbility=v9(1072371 - 637149),CrashingThunder=v9(23532 + 413175),LightningStrikes=v9(153691 + 281278),ThunderBlast=v9(436492 - (261 + 624)),BurstofPowerBuff=v9(776806 - 339685),ThunderBlastBuff=v9(436695 - (1020 + 60))};
v9.Warrior.Slayer = {SlayersDominance=v9(446190 - (630 + 793)),BrutalFinishBuff=v9(1514456 - 1067538),ImminentDemiseBuff=v9(2109836 - 1664230),OpportunistBuff=v9(179637 + 276483),MarkedforExecutionDebuff=v9(1534165 - 1088581)};
v9.Warrior.Fury = v12(v9.Warrior.Commons, {BerserkerStance=v9(387943 - (760 + 987)),Bloodbath=v9(337009 - (1789 + 124)),CrushingBlow=v9(335863 - (745 + 21)),Execute=v10(1826 + 3482, 772483 - 491748),Executecast=v9(20820 - 15512),Whirlwind=v9(1557 + 188854),AngerManagement=v9(119557 + 32721),AshenJuggernaut=v9(393591 - (87 + 968)),Bloodthirst=v9(105122 - 81241),DancingBlades=v9(355361 + 36322),EnragedRegeneration=v9(416763 - 232399),ImprovedWhilwind=v9(14363 - (447 + 966)),Massacre=v9(564818 - 358503),MeatCleaver=v9(282209 - (1703 + 114)),OdynsFury=v9(385760 - (376 + 325)),Onslaught=v9(517400 - 201680),RagingBlow=v9(262429 - 177141),Rampage=v9(52688 + 131679),RecklessAbandon=v9(873833 - 477084),Recklessness=v9(1733 - (9 + 5)),SlaughteringStrikes=v9(388380 - (85 + 291)),Tenderize=v9(390198 - (243 + 1022)),TitanicRage=v9(1500491 - 1106162),TitansTorment=v9(321848 + 68287),Unhinged=v9(387808 - (1123 + 57)),ViciousContempt=v9(312346 + 71539),WrathandFury=v9(393190 - (163 + 91)),AshenJuggernautBuff=v9(394467 - (1869 + 61)),BloodbathBuff=v9(128871 + 332417),BloodcrazeBuff=v9(1387500 - 993549),ChampionsMightBuff=v9(593316 - 207030),CrushingBlowBuff=v9(54291 + 342461),DancingBladesBuff=v9(538276 - 146588),EnrageBuff=v9(173166 + 11196),FuriousBloodthirstBuff=v9(424685 - (1329 + 145)),MeatCleaverBuff=v9(86710 - (140 + 831)),MercilessAssaultBuff=v9(411833 - (1409 + 441)),RecklessnessBuff=v9(2437 - (15 + 703)),SuddenDeathBuff=v9(130029 + 150747),GushingWoundDebuff=v9(385480 - (262 + 176)),OdynsFuryDebuff=v9(386781 - (345 + 1376))});
v9.Warrior.Fury = v12(v9.Warrior.Fury, v9.Warrior.MountainThane);
v9.Warrior.Fury = v12(v9.Warrior.Fury, v9.Warrior.Slayer);
v9.Warrior.Arms = v12(v9.Warrior.Commons, {Execute=v10(281688 - (198 + 490), 721015 - 557814),Executecast=v9(391469 - 228268),Whirlwind=v9(2886 - (696 + 510)),BlademastersTorment=v9(818230 - 428092),Bloodletting=v9(384416 - (1091 + 171)),Cleave=v9(136 + 709),ColossusSmash=v9(526103 - 358998),DiebytheSword=v9(391453 - 273415),Dreadnaught=v9(262524 - (123 + 251)),ExecutionersPrecision=v9(1921165 - 1534531),FervorofBattle=v9(203014 - (208 + 490)),IgnorePain=v9(16072 + 174384),ImprovedSweepingStrikes=v9(170675 + 212480),Massacre=v9(281837 - (660 + 176)),MercilessBonegrinder=v9(46054 + 337263),MortalStrike=v9(12496 - (14 + 188)),Overpower=v9(8059 - (534 + 141)),Rend=v9(311 + 461),Skullsplitter=v9(230550 + 30093),SweepingStrikes=v9(250657 + 10051),Unhinged=v9(812516 - 425888),Warbreaker=v9(416211 - 154050),Juggernaut=v9(1105094 - 711127),CollateralDamageBuff=v9(179771 + 155012),JuggernautBuff=v9(244046 + 139244),LethalBlowsBuff=v9(455881 - (115 + 281)),MartialProwessBuff=v9(17175 - 9791),MercilessBonegrinderBuff=v9(317364 + 65952),StrikeVulnerabilitiesBuff=v9(952619 - 558446),SuddenDeathBuff=v9(192275 - 139838),SweepingStrikesBuff=v9(261575 - (550 + 317)),ColossusSmashDebuff=v9(300638 - 92552),DeepWoundsDebuff=v9(368422 - 106307),ExecutionersPrecisionDebuff=v9(1080438 - 693805),RendDebuff=v9(388824 - (134 + 151))});
v9.Warrior.Arms = v12(v9.Warrior.Arms, v9.Warrior.Colossus);
v9.Warrior.Arms = v12(v9.Warrior.Arms, v9.Warrior.Slayer);
v9.Warrior.Protection = v12(v9.Warrior.Commons, {Devastate=v9(21908 - (970 + 695)),Execute=v10(311425 - 148224, 282990 - (582 + 1408)),Executecast=v9(565993 - 402792),ShieldBlock=v9(3227 - 662),ShieldSlam=v9(90146 - 66224),BarbaricTraining=v9(392499 - (1195 + 629)),Bolster=v9(370300 - 90299),BoomingVoice=v9(202984 - (187 + 54)),ChampionsBulwark=v9(387108 - (162 + 618)),DemoralizingShout=v9(813 + 347),EnduringDefenses=v9(257110 + 128917),HeavyRepercussions=v9(433315 - 230138),IgnorePain=v9(320192 - 129736),Intervene=v9(267 + 3144),ImpenetrableWall=v9(385708 - (1373 + 263)),Juggernaut=v9(394967 - (451 + 549)),LastStand=v9(4096 + 8879),Massacre=v9(437307 - 156306),Rend=v9(662284 - 268222),Revenge=v9(7956 - (746 + 638)),SeismicReverberation=v9(144121 + 238835),ShieldCharge=v9(585983 - 200031),ShieldWall=v9(1212 - (218 + 123)),SuddenDeath=v9(31306 - (1535 + 46)),UnnervingFocus=v9(381585 + 2457),UnstoppableForce=v9(39842 + 235494),EarthenTenacityBuff=v9(410778 - (306 + 254)),FervidBuff=v9(26343 + 399174),LastStandBuff=v9(25463 - 12488),RallyingCryBuff=v9(98930 - (899 + 568)),RevengeBuff=v9(3486 + 1816),SeeingRedBuff=v9(935258 - 548772),ShieldBlockBuff=v9(133007 - (268 + 335)),ShieldWallBuff=v9(1161 - (60 + 230)),SuddenDeathBuff=v9(53009 - (426 + 146)),ViolentOutburstBuff=v9(46298 + 340180),VanguardsDeterminationBuff=v9(395512 - (282 + 1174)),RendDebuff=v9(389350 - (569 + 242))});
v9.Warrior.Protection = v12(v9.Warrior.Protection, v9.Warrior.Colossus);
v9.Warrior.Protection = v12(v9.Warrior.Protection, v9.Warrior.MountainThane);
if not v11.Warrior then
	v11.Warrior = {};
end
v11.Warrior.Commons = {AlgetharPuzzleBox=v11(557974 - 364273, {(1037 - (706 + 318)),(1285 - (945 + 326))}),TreacherousTransmitter=v11(552185 - 331162, {(713 - (271 + 429)),(1514 - (1408 + 92))}),Fyralath=v11(207534 - (461 + 625), {(1 + 15)}),ShadowedRazingAnnihilator=v11(206217 - (418 + 753), {(2 + 14)})};
v11.Warrior.Fury = v12(v11.Warrior.Commons, {});
v11.Warrior.Arms = v12(v11.Warrior.Commons, {});
v11.Warrior.Protection = v12(v11.Warrior.Commons, {});
Warrior.SpellReflectList = v14.converArrayToList({(97435 + 288101),(1218907 - (1749 + 20)),(371145 - (1249 + 73)),(424624 - (466 + 679)),(756679 - 492123),(134938 + 291603),(1009629 - 667660),(201951 - (4 + 110)),(322064 - (41 + 1386)),(47400 + 22439),(222556 - 145705),(89770 - 37799),(56814 + 13026),(180023 - 91160),(53613 + 24390),(199191 - 146504),(188912 - 118727),(61758 - (53 + 267)),(28499 - (15 + 398)),(320085 - 235049),(53096 + 31177),(60499 + 17004),(6320 + 79231),(201137 - 107310),(15687 + 15188),(190764 - 118370),(44978 - (1126 + 425)),(336322 - 250510),(216356 - 142424),(178471 - 139130),(37764 - (553 + 424)),(64681 + 8743),(40537 + 29083),(24292 + 18244),(78303 - 50200),(12147 + 29625),(77757 - (239 + 514)),(75268 - (797 + 532)),(10947 + 21501),(79357 - (373 + 829)),(75836 - (369 + 761)),(154956 - 69646),(31540 - (64 + 174)),(129748 - 42135),(40081 - (42 + 174)),(68133 + 14116),(75197 - (363 + 1141)),(1954 - 1312),(67976 + 22966),(32190 + 18923),(29796 - (565 + 1368)),(52902 - (1477 + 184)),(47626 + 3488),(127160 - 53462),(77709 - (244 + 60)),(66356 - (41 + 435)),(50668 + 15213),(23962 + 48846),(14217 + 8798),(65639 - (176 + 91)),(35990 - 11570),(74558 - (157 + 1718)),(778803 - 559417),(90822 - (697 + 321)),(927610 - 489771),(7657 + 12012),(1015501 - 636683),(429764 - (602 + 9)),(387997 - (826 + 46)),(1216024 - 831201),(336646 - (260 + 1638)),(1223491 - 842112),(800075 - 412948),(327524 - (902 + 303)),(776708 - 454222),(417946 - (1121 + 569)),(264788 - (483 + 200)),(1031156 - 654373),(76757 - (468 + 297)),(879334 - 618635),(779041 - 349496),(384430 - (141 + 95)),(858693 - 525091),(91100 + 297823),(183270 + 77430),(605806 - 175620),(372478 - (92 + 71)),(719402 - 291517),(391306 + 83082),(218887 + 209639),(201487 - (55 + 71)),(385987 - (573 + 1217)),(30147 + 366059),(437261 - (714 + 225)),(452994 - 128071),(542061 - 167696),(386805 - (25 + 23)),(384556 - (927 + 959)),(417762 - (16 + 716)),(429519 - (11 + 86)),(257348 - (175 + 110)),(2116788 - 1687615),(1087637 - 698194),(267097 - (810 + 251)),(129402 + 292236),(438266 - (43 + 490)),(1599851 - 1186261),(78934 + 248166),(28395 + 400653),(429581 - (255 + 150)),(201113 + 174536),(1494730 - 1031954),(371712 - (183 + 223)),(185925 + 94679),(1215752 - (10 + 327)),(255297 - (118 + 220)),(473575 - (108 + 341)),(1809078 - 1381178),(720139 - 344486),(124806 + 260172),(607170 - 402927),(15395 + 413147),(1117915 - 689754),(390109 - (645 + 522)),(388625 + 192),(1376761 - 906950),(425488 - 257396),(373223 - (351 + 154)),(392661 - (28 + 238)),(467154 - (1381 + 178)),(221737 + 53254),(1544326 - 1096360),(1216945 - (381 + 89)),(282826 + 135376),(279600 - (1074 + 82)),(460994 - (214 + 1570)),(159131 + 226881),(256365 + 7263),(166691 - (1668 + 58)),(1078333 - 664726),(1150712 - 820015),(75655 + 328499),(1262801 - 888412),(1215937 - (1269 + 200)),(398201 - (98 + 717)),(794745 - 333898),(37352 + 215571),(41649 + 211913),(1187242 - 760474),(154332 + 277162),(272872 + 57938),(190079 + 217042),(1807272 - 1435050),(149074 + 281164),(420586 + 47321),(415761 - (192 + 134)),(185480 + 147819),(1130383 + 92566),(331335 - (83 + 468)),(1997757 - 1569806),(1183239 - 755882),(412591 + 14878),(98167 + 170679),(66087 + 309640),(426332 - (340 + 1571)),(324046 - (1733 + 39)),(429597 - (125 + 909)),(116775 + 143548),(370059 + 11471),(466107 - (46 + 190)),(76880 + 195701),(370143 - (228 + 498)),(144027 + 116674),(1073272 - 661314),(370134 - (303 + 221)),(1013251 + 202683),(1736198 - 1314914),(411465 - 246579),(1531827 - 1094831),(602378 - 228686),(370922 - (111 + 1137)),(1274617 - 846354),(370198 - (423 + 100)),(887313 - 566851),(264795 - (326 + 445)),(588485 - 324332),(165684 - (530 + 181)),(410383 - (19 + 13)),(620394 - 354169),(112013 + 319290),(775660 - 401640),(752887 - 383881),(562595 - 268400),(395858 - 227818),(80728 + 314962),(98597 + 328080),(239977 + 144037),(371223 - (673 + 1185)),(937276 - 645398),(322740 + 128482),(570712 - 148012),(850969 - 424186),(376669 - (446 + 1434)),(1117270 - 742927),(378758 - (609 + 1322)),(1631651 - 1195011),(1619753 - 1294530),(1360236 - 985701),(175346 + 224819),(177149 + 146581),(133081 + 68217),(239608 + 93871),(361415 + 7984),(773368 - 505544),(177714 + 272373),(226958 + 23138),(597504 - 205110),(321455 - (89 + 578)),(347989 - 180604),(60248 + 386469),(46070 + 339888),(708849 - 278740),(372826 - (497 + 345)),(33925 + 166759),(231588 + 93001),(14780 + 307713),(344096 + 37598),(199291 + 64652),(163245 + 221516),(307208 + 18884),(1143238 - 820181),(388367 - (588 + 208)),(377051 - (884 + 916)),(115768 + 83895),(78709 - (1569 + 320)),(38043 + 162195),(439465 - (316 + 289)),(18544 + 382981),(432456 - (360 + 65)),(435040 - (79 + 175)),(301185 + 84778),(622533 - 299283),(322836 - (92 + 89)),(196537 + 186694),(1669384 - 1243101),(977922 - 549033),(179567 + 196383),(21175 + 148482)});
Warrior.ShieldBlockList = v14.converArrayToList({(440281 - (485 + 759)),(459529 - (442 + 747)),(448207 - (88 + 858)),(212385 + 44242),(441257 - (766 + 23)),(597108 - 160516),(894619 - 631033),(308208 + 126514),(266163 + 72194),(321684 - (910 + 3)),(448503 - (1466 + 218)),(445842 - (556 + 592)),(257675 - (329 + 479)),(1510700 - 1071054),(316547 + 126814),(23972 + 246954),(335877 - (135 + 1254)),(1496986 - 1176372),(475877 - (389 + 1138)),(414233 + 24716),(420865 + 30499),(456990 - 200281),(325858 - (157 + 1307)),(826637 - 495318),(485755 - 212285),(636040 - 379424),(27013 + 397875),(6958 + 317121),(445320 - (300 + 4)),(1161378 - 717724),(108715 + 163996),(249032 + 185670),(336625 + 113475),(333285 + 115355),(1024960 - 565333),(321348 - (627 + 66)),(426163 - (512 + 90)),(434502 - (373 + 344)),(116280 + 323188),(725801 - 296907),(314490 + 117739),(1864 + 465112),(451301 - (233 + 1026)),(165403 + 158112),(136789 + 323683),(451629 - (55 + 166)),(47566 + 425443),(443292 - (36 + 261)),(466539 - (34 + 1334)),(368607 + 105799),(440921 - (20 + 1)),(435092 - (134 + 185)),(262704 - (314 + 371)),(321344 - (478 + 490)),(319274 - (786 + 386)),(465491 - (1055 + 324)),(398938 + 49997),(1123341 - 840396),(942504 - 611280),(95106 + 172251),(1603197 - 1138069),(1149414 - 699970),(1285510 - 816578),(154696 + 312052),(676223 - 253990),(470747 - (1249 + 19)),(1708932 - 1269901),(333006 + 91420),(2199 + 462677),(5208 + 457998),(435470 - (224 + 246)),(589322 - 269253),(10439 + 428212),(850177 - 422556),(334358 - (203 + 310)),(29857 + 397504),(849452 - 388487),(322671 - (196 + 668)),(936597 - 484446),(467067 - (4 + 89)),(167425 + 292374),(165584 + 256661),(286830 - (28 + 1425)),(307027 + 13173),(606218 - 181597),(435055 - (45 + 252)),(146275 + 278752),(268663 - (114 + 319))});
Warrior.SpellBlockList = v14.converArrayToList({(606763 - 133244),(658177 - 216405),(476694 - (556 + 1407)),(434205 - (170 + 295)),(407363 + 36131),(350149 + 72244),(244423 + 187214),(72903 + 199678),(1225701 - 904032),(80281 - 53998),(36032 - (389 + 1391)),(2444 + 21035),(44384 - (783 + 168)),(95537 + 1590),(122808 - 82817),(30539 + 63656),(148709 + 68585),(5423 + 24815),(281343 - 219780),(45957 - 23201),(21220 + 5640),(36524 - (556 + 1139)),(6436 + 28712),(20631 - (28 + 141)),(60225 - 11434),(41606 - (486 + 831)),(143947 - 103060),(90783 - 62072),(18414 + 2050),(97597 - 61809),(22728 - (1129 + 815)),(69135 - (1326 + 424)),(175279 - 127313),(67290 - (720 + 51)),(44260 - (421 + 1355)),(10629 + 11009),(126875 - 92168),(24860 - (397 + 42)),(92835 - (24 + 776)),(26759 - (222 + 563)),(43809 + 17038),(58966 - (690 + 1108)),(16989 + 3607),(4865 + 24680),(205406 + 9504),(120306 + 99080),(21807 + 11795),(52568 - 17412),(64073 - (1165 + 561)),(672476 - 455350),(31237 - (341 + 138)),(151999 - 78347),(128071 - 88260),(69141 - (581 + 300)),(529552 - 306603),(24782 - (1030 + 205)),(37748 + 2829),(107408 - 60137),(45619 - 23345),(124901 + 89289),(17080 + 43308),(30585 - (671 + 492)),(43407 - (369 + 846)),(34392 + 5908),(32872 + 8472),(59677 - (11 + 192)),(94002 - (135 + 40)),(16276 + 10725),(41133 - 13694),(105364 - 67525),(75445 - (1233 + 180)),(49478 - (107 + 1314)),(85581 - 57495),(77168 - 38308),(78144 - (716 + 1194)),(2959 + 24657),(118613 - 57126),(61732 - 34764),(92824 - 62715),(40737 - (279 + 154)),(23750 + 6436),(15041 + 12856),(27106 + 46245),(150263 - 115098),(5776 + 25029),(243335 - 186622),(9469 + 30223),(45745 - (41 + 1857)),(75237 - 46127),(46719 - (229 + 953)),(217513 - (874 + 705)),(43132 + 20085),(707 + 24406),(6362 + 21538),(190991 - 114923),(146185 - 82967),(50033 - (718 + 823)),(40946 - (266 + 539)),(50355 - (636 + 589)),(910176 - 468887),(120173 + 210611),(1171469 - 729032),(1215513 - (1151 + 36)),(111593 + 312867),(332552 - (1552 + 280)),(224647 + 106228),(80468 + 372744),(840419 - 420548),(1867068 - 649930),(331516 - (599 + 220)),(326520 - (1813 + 118)),(475301 - (841 + 376)),(107504 + 355272),(441008 - (464 + 395)),(583795 + 631841),(2512370 - 1296629),(1504235 - 1065428),(996149 - 567988),(323937 - (74 + 1208)),(2009270 - 1585605),(292318 - (14 + 376)),(282329 + 153993),(451181 + 21900),(242588 + 79877),(1014223 - 586272),(405099 + 46014),(134466 + 293006),(1246192 - 780526),(1246496 - 787286),(451141 - (10 + 17)),(431745 - (1400 + 332)),(434025 - (242 + 1666)),(445880 + 770731),(426494 - (850 + 90)),(444664 - (360 + 1030)),(1275805 - 823797),(448378 - (909 + 752)),(821251 - 372685),(1218175 - (6 + 236)),(355463 + 86149),(460478 - 196850),(69281 + 352001),(37092 + 432704),(239680 + 211926),(716865 - 460226),(197768 + 246975),(415248 + 50214),(1391623 - 940236),(687173 - 395295),(202002 + 221322),(319913 + 128975),(461149 - (478 + 244)),(211695 + 253900),(470283 - (655 + 901)),(327256 + 100213),(1790176 - 1345813),(1460126 - 1032529),(1768146 - 1328500),(1085898 - 620068),(68708 + 357551),(194869 + 271002),(1216185 - (239 + 30)),(447380 + 18086),(850450 - 577862),(1493038 - 1065184),(745713 + 469697),(1261782 - 820540),(773460 + 441952),(109019 + 315776),(439766 + 778198),(208276 + 264518),(443640 + 29486),(38932 + 388669),(1216992 - (1309 + 179)),(200284 + 259874),(332182 + 107596),(536217 - 267117),(1046680 - 620544),(823571 - 561301),(224021 + 207343),(433853 - (851 + 554)),(721971 - 461648),(260405 - (115 + 187)),(403539 + 22726),(434120 - (160 + 1001)),(297722 + 133771),(466340 - (237 + 121)),(897588 - 424148),(423157 - (96 + 46)),(155767 + 275727),(1601307 - 1170004),(578675 - 283815),(295680 - (316 + 403)),(1182702 - 752531),(3067658 - 1849541),(138119 + 290444),(1542871 - 1219814),(25154 + 414247),(20841 + 405836),(442606 - (12 + 5)),(922144 - 489946),(1145319 - 683477),(276964 - (1656 + 317)),(363655 + 90155),(2081903 - 1658884),(2015465 - 1591143),(295588 + 152974),(582614 - 140084),(556583 - 129483),(325975 - (507 + 559)),(3762186 - 2545711),(1218401 - (250 + 655)),(771274 - 329879),(446206 - (1869 + 87)),(430177 - (484 + 1417)),(725506 - 292603),(698132 - 270775),(252682 + 182104),(122848 + 316112),(421772 - (152 + 701)),(29247 + 47122),(75982 + 181081),(1560110 - 1114592),(910987 - 488287),(426260 - (39 + 827)),(977624 - 539891),(679429 - 236893),(1291811 - 850449),(701779 - 258288),(443951 - (475 + 79)),(1032200 - 709643),(375604 + 51183),(1232489 - 808953),(190381 + 246259),(470138 - (27 + 292)),(411264 - 88771),(874467 - 431040),(456890 - (43 + 96)),(990719 - 552519),(123860 + 314796),(167482 + 269514),(138738 + 301949),(453722 - (1414 + 337)),(1141834 - 703822)});
