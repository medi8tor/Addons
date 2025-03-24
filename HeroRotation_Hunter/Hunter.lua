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
local v15 = {};
v13.Commons().Hunter = v15;
local v17 = v13.GUISettingsGet();
local v18 = {General=v17.General,Commons=v17.APL.Hunter.Commons,Defensives=v17.APL.Hunter.Defensives,Survival=v17.APL.Hunter.Survival,Marksmanship=v17.APL.Hunter.Marksmanship,BeastMastery=v17.APL.Hunter.BeastMastery};
if not v9.Hunter then
	v9.Hunter = {};
end
v9.Hunter.Commons = {Bite=v9(53941 - 36688, "Pet"),BloodBolt=v9(826960 - 537998, "Pet"),Claw=v9(32481 - 15654, "Pet"),Growl=v9(6823 - 4174, "Pet"),Smack=v9(50585 - (555 + 64), "Pet"),AncestralCall=v9(275669 - (857 + 74)),ArcanePulse=v9(260932 - (367 + 201)),ArcaneTorrent=v9(81410 - (214 + 713)),ArcaneTorrentCast=v9(12670 + 37943),BagofTricks=v9(49133 + 263278),Berserking=v9(27174 - (282 + 595)),BloodFury=v9(22209 - (1523 + 114)),Fireblood=v9(238344 + 26877),LightsJudgment=v9(364448 - 108801),ArcaneShot=v9(186423 - (68 + 997)),Exhilaration=v9(110574 - (226 + 1044)),SurvivalOfTheFittest=v9(1152763 - 888028),AspectOfTheTurtle=v9(186382 - (32 + 85)),FeignDeath=v9(5277 + 107),FortitudeOfTheBear=v9(60468 + 212211),Flare=v9(2500 - (892 + 65)),FreezingTrap=v9(447644 - 259994),HuntersMark=v9(475572 - 218288),MendPet=v9(248 - 112),RevivePet=v9(1332 - (87 + 263)),SummonPet=v9(1063 - (67 + 113)),SummonPet2=v9(61040 + 22202),SummonPet3=v9(204375 - 121132),SummonPet4=v9(61222 + 22022),SummonPet5=v9(330856 - 247611),AlphaPredator=v9(270689 - (802 + 150)),Barrage=v9(324049 - 203689),BeastMaster=v9(685690 - 307683),BindingShot=v9(79521 + 29727),BurstingShot=v9(187384 - (915 + 82)),CounterShot=v9(417266 - 269904),ExplosiveShot=v9(123751 + 88680),HighExplosiveTrap=v9(311394 - 74618),HydrasBite=v9(261428 - (1069 + 118)),Intimidation=v9(44414 - 24837),ImplosiveTrap=v9(1010680 - 548649),KillCommand=v10(5916 + 28110, 461059 - 201570),KillShot=v10(52925 + 426, 321767 - (368 + 423)),KillshotBM=v9(167665 - 114314),KillerInstinct=v9(273905 - (10 + 8)),Muzzle=v9(722058 - 534351),PoisonInjection=v9(378456 - (416 + 26)),ScareBeast=v9(4830 - 3317),ScatterShot=v9(91706 + 121985),SerpentSting=v9(480910 - 209122),Stampede=v9(201868 - (145 + 293)),TarTrap=v9(188128 - (44 + 386)),WailingArrow=v9(393546 - (998 + 488)),Misdirection=v9(10954 + 23523),BerserkingBuff=v9(21533 + 4764),BloodFuryBuff=v9(21344 - (201 + 571)),SeethingRageBuff=v9(409973 - (116 + 1022)),HuntersMarkDebuff=v9(1071142 - 813858),FreezeTagFixation=v9(188943 + 132948),LatentPoisonDebuff=v9(1229928 - 893025),SerpentStingDebuff=v9(965143 - 693355),TarTrapDebuff=v9(136158 - (814 + 45)),TranquilizingShot=v9(48788 - 28987),PoolFocus=v9(53880 + 946030),WrongWeapon=v9(353306 + 646605)};
v9.Hunter.DarkRanger = {BlackArrow=v9(467815 - (261 + 624)),BlackArrowTalent=v9(829783 - 362851),BleakArrows=v9(468829 - (1020 + 60)),BleakArrowsBMAbility=v9(473507 - (630 + 793)),BleakArrowsMMAbility=v9(1585604 - 1117690),BleakPowder=v9(2215445 - 1747534),PhantomPain=v9(184292 + 283649),PhantomPainAbility=v9(1611409 - 1143390),ShadowHounds=v9(432454 - (760 + 987)),ShadowHoundsAbility=v9(446182 - (1789 + 124)),WitheringFire=v9(467756 - (745 + 21)),WitheringFireBlackArrow=v9(160989 + 307048),WitheringFireBuff=v9(1284993 - 818002),WitheringFireBuildUp=v9(1836027 - 1367953),WitheringFireReady=v9(3827 + 464248),BlackArrowDebuff=v9(367887 + 100685)};
v9.Hunter.PackLeader = {CulltheHerd=v9(446772 - (87 + 968)),HowlofthePack=v9(1961976 - 1516269),HogstriderBuff=v9(428810 + 43830),HowlofthePackBuff=v9(1045538 - 583023),HowlofthePackLeaderCDBuff=v9(473290 - (447 + 966)),PackCoordinationBuff=v9(1220158 - 774463),ScatteredPreyBuff=v9(463683 - (1703 + 114)),HowlBearBuff=v9(473026 - (376 + 325)),HowlBoarBuff=v9(774041 - 301717),HowlWyvernBuff=v9(1451957 - 980079)};
v9.Hunter.Sentinel = {LunarStorm=v9(128710 + 321675),LunarStormBuff=v9(993271 - 542293),SymphonicArsenal=v9(450397 - (9 + 5))};
v9.Hunter.BeastMastery = v12(v9.Hunter.Commons, {AMurderofCrows=v9(132270 - (85 + 291)),AnimalCompanion=v9(268381 - (243 + 1022)),AspectoftheWild=v9(736416 - 542886),BarbedShot=v9(179183 + 38017),BeastCleave=v9(117119 - (1123 + 57)),BestialWrath=v9(15927 + 3647),Bloodshed=v9(321784 - (163 + 91)),BloodyFrenzy=v9(409342 - (1869 + 61)),CalloftheWild=v9(100531 + 259313),CobraShot=v9(681350 - 487895),DireBeast=v9(185356 - 64677),DireCleave=v9(166604 + 1050920),HuntmastersCall=v9(631782 - 172052),KillCleave=v9(355239 + 22968),KillerCobra=v9(201006 - (1329 + 145)),MultiShot=v9(3614 - (140 + 831)),OneWithThePack=v9(201378 - (1409 + 441)),Savagery=v9(425275 - (15 + 703)),ScentofBlood=v9(89626 + 103906),SpiritMend=v9(90799 - (262 + 176)),Stomp=v9(201251 - (345 + 1376)),ThunderingHooves=v9(460381 - (198 + 490)),VenomsBite=v9(2030340 - 1570775),WildCall=v9(445650 - 259861),WildInstincts=v9(379648 - (696 + 510)),AspectoftheWildBuff=v9(405887 - 212357),BeastCleavePetBuff=v9(119717 - (1091 + 171), "Pet"),BeastCleaveBuff=v9(43269 + 225608),BestialWrathBuff=v9(61625 - 42051),BestialWrathPetBuff=v9(617680 - 431426, "Pet"),CalloftheWildBuff=v9(360218 - (123 + 251)),FrenzyPetBuff=v9(1355480 - 1082690, "Pet"),HuntersPreyBuff=v9(378913 - (208 + 490)),BarbedShotDebuff=v9(18329 + 198871)});
v9.Hunter.BeastMastery = v12(v9.Hunter.BeastMastery, v9.Hunter.DarkRanger);
v9.Hunter.BeastMastery = v12(v9.Hunter.BeastMastery, v9.Hunter.PackLeader);
v9.Hunter.Marksmanship = v12(v9.Hunter.Commons, {SteadyShot=v9(25231 + 31410),AimedShot=v9(20270 - (660 + 176)),CarefulAim=v9(31265 + 228963),ChimaeraShot=v9(342251 - (14 + 188)),DoubleTap=v9(261077 - (534 + 141)),InTheRhythm=v9(163784 + 243620),LegacyoftheWindrunners=v9(359500 + 46925),LoneWolf=v9(149244 + 5984),MultiShot=v9(541400 - 283780),RapidFire=v9(408087 - 151043),RapidFireBarrage=v9(1289759 - 829959),Salvo=v9(215035 + 185421),SerpentstalkersTrickery=v9(241244 + 137644),SmallGameHunter=v9(460198 - (115 + 281)),SteadyFocus=v9(450164 - 256631),Streamline=v9(215569 + 44798),SurgingShots=v9(946301 - 554742),TrickShots=v9(944644 - 687023),Trueshot=v9(289480 - (550 + 317)),Volley=v9(375993 - 115750),WindrunnersGuidance=v9(532579 - 153674),BombardmentBuff=v9(1081114 - 694239),BulletstormBuff=v9(389305 - (134 + 151)),DoubleTapBuff=v9(262067 - (970 + 695)),InTheRhythmBuff=v9(777425 - 370020),LockandLoadBuff=v9(196584 - (582 + 1408)),PreciseShotsBuff=v9(902539 - 642297),RazorFragmentsBuff=v9(489445 - 100447),SalvoBuff=v9(1509061 - 1108605),SteadyFocusBuff=v9(195358 - (1195 + 629)),TrickShotsBuff=v9(340703 - 83081),TrueshotBuff=v9(288854 - (187 + 54)),VolleyBuff=v9(261023 - (162 + 618)),Deathblow=v9(265404 + 113366),EagletalonsTrueFocusBuff=v9(224357 + 112494)});
v9.Hunter.Marksmanship = v12(v9.Hunter.Marksmanship, v9.Hunter.DarkRanger);
v9.Hunter.Marksmanship = v12(v9.Hunter.Marksmanship, v9.Hunter.Sentinel);
v9.Hunter.Survival = v12(v9.Hunter.Commons, {Bite=v9(36795 - 19542, "Pet"),BloodBolt=v9(485799 - 196837, "Pet"),Claw=v9(1316 + 15511, "Pet"),Growl=v9(4285 - (1373 + 263), "Pet"),Smack=v9(50966 - (451 + 549), "Pet"),WildfireBomb=v9(81913 + 177582),AspectoftheEagle=v9(289911 - 103622),BirdsofPrey=v9(437528 - 177197),Bombardier=v9(391264 - (746 + 638)),Butchery=v9(79948 + 132488),ContagiousReagents=v9(698016 - 238275),Carve=v9(188049 - (218 + 123)),CoordinatedAssault=v9(362533 - (1535 + 46)),CoordinatedKill=v9(383271 + 2468),FlankersAdvantage=v9(38084 + 225102),FlankingStrike=v9(270311 - (306 + 254)),FuryoftheEagle=v9(12593 + 190822),Harpoon=v9(374698 - 183773),MercilessBlows=v9(461335 - (899 + 568)),Lunge=v9(249074 + 129860),MongooseBite=v10(627691 - 368304, 266491 - (268 + 335)),MongooseBiteCast=v9(259677 - (60 + 230)),Ranger=v9(386267 - (426 + 146)),RaptorStrike=v10(22314 + 163956, 266645 - (282 + 1174)),RaptorStrikeCast=v9(187081 - (569 + 242)),RuthlessMarauder=v9(1111097 - 725379),SicEm=v9(26302 + 433618),Spearhead=v9(361990 - (706 + 318)),SymbioticAdrenaline=v9(461126 - (721 + 530)),TermsofEngagement=v9(267166 - (945 + 326)),TipoftheSpear=v9(650274 - 389989),VipersVenom=v9(238918 + 29583),WildfireInfusion=v9(271714 - (271 + 429)),BombardierBuff=v9(422428 + 37431),BloodseekerBuff=v9(261749 - (1408 + 92)),ContainedExplosionBuff=v9(427430 - (461 + 625)),CoordinatedAssaultBuff=v9(362240 - (993 + 295)),ExposedFlankBuff=v9(23879 + 435985),CoordinatedAssaultEmpowerBuff=v9(362909 - (418 + 753)),DeadlyDuoBuff=v9(151415 + 246153),MercilessBlowsBuff=v9(47395 + 412475),MongooseFuryBuff=v9(75867 + 183521),RelentlessPrimalFerocityBuff=v9(116245 + 343717),SicEmBuff=v9(461938 - (406 + 123)),SpearheadBuff=v9(362735 - (1749 + 20)),TipoftheSpearBuff=v9(61825 + 198461),BloodseekerDebuff=v9(260599 - (1249 + 73)),InternalBleedingDebuff=v9(96450 + 173893),PheromoneBombDebuff=v9(271477 - (466 + 679)),ShrapnelBombDebuff=v9(650292 - 379953),ShreddedArmorDebuff=v9(1173154 - 762987),VolatileBombDebuff=v9(272949 - (106 + 1794)),WildfireBombDebuff=v9(85336 + 184411)});
v9.Hunter.Survival = v12(v9.Hunter.Survival, v9.Hunter.PackLeader);
v9.Hunter.Survival = v12(v9.Hunter.Survival, v9.Hunter.Sentinel);
if not v11.Hunter then
	v11.Hunter = {};
end
v11.Hunter.Commons = {AlgetharPuzzleBox=v11(48964 + 144737, {(34 - 21),(598 - (57 + 527))}),BeacontotheBeyond=v11(205390 - (41 + 1386), {(9 + 4),(40 - 26)}),DMDDance=v11(198254 - (122 + 44), {(43 - 30),(3 + 11)}),DMDDanceBox=v11(402087 - 203609, {(9 + 4),(52 - 38)}),DMDInferno=v11(199298 - (323 + 889), {(593 - (361 + 219)),(4 + 10)}),DMDInfernoBox=v11(195285 - (15 + 398), {(48 - 35),(9 + 5)}),DMDRime=v11(198937 - (20 + 830), {(139 - (116 + 10)),(752 - (542 + 196))}),DMDRimeBox=v11(425476 - 226999, {(7 + 6),(36 - 22)}),DMDWatcher=v11(507858 - 309769, {(418 - (118 + 287)),(1135 - (118 + 1003))}),DMDWatcherBox=v11(580840 - 382359, {(58 - 45),(991 - (553 + 424))}),DecorationofFlame=v11(367410 - 173111, {(13 + 0),(6 + 8)}),GlobeofJaggedIce=v11(110635 + 83097, {(35 - 22),(5 + 9)}),MadQueensMandate=v11(1026717 - 814263, {(5 + 8),(11 + 3)}),ManicGrieftorch=v11(65551 + 128757, {(1215 - (373 + 829)),(1144 - (369 + 761))}),MirrorofFracturedTomorrows=v11(120080 + 87501, {(24 - 11),(2 + 12)}),SkardynsGrace=v11(197382 - 64100, {(229 - (42 + 174)),(12 + 2)}),StormeatersBoon=v11(82548 + 111754, {(1593 - (1183 + 397)),(11 + 3)}),WindscarWhetstone=v11(102765 + 34721, {(9 + 4),(1947 - (565 + 1368))}),ImperfectAscendancySerum=v11(848625 - 622971, {(16 - 3),(870 - (564 + 292))}),SignetofthePriory=v11(378399 - 159091, {(317 - (244 + 60)),(490 - (41 + 435))}),Djaruun=v11(203570 - (938 + 63), {(1141 - (936 + 189))})};
v11.Hunter.BeastMastery = v12(v11.Hunter.Commons, {});
v11.Hunter.Marksmanship = v12(v11.Hunter.Commons, {});
v11.Hunter.Survival = v12(v11.Hunter.Commons, {});
FeignDeathList = v14.converArrayToList({(371290 - (1565 + 48)),(388289 - (782 + 356)),(969769 - 597544),(374825 - (975 + 117)),(307432 + 71386),(1278704 - 904684),(1025998 - 649364),(868815 - 491951),(728743 - 339801),(375247 - (322 + 905)),(380007 - (449 + 740)),(379176 - (245 + 702)),(124750 + 263310),(167825 - (382 + 58))});
v13.ToggleIconFrame:AddButtonCustom("S", 3 - 2, "Small CDs", "smallcds");
v13.ToggleIconFrame:AddButtonCustom("I", 2 + 0, "Interrupt", "interrupt");
