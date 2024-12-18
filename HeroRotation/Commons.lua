local v0, v1 = ...;
local v2 = v1.CDsON();
local v3 = v2.AoEON;
local v4 = v2.Cast;
local v5 = v2.CastLeftNameplate;
local v6 = HeroLib;
local v7, v8 = HeroCache, v6.Utils;
local v9 = v6.Unit;
local v10, v11, v12 = v9.Player, v9.Pet, v9.Target;
local v13, v14 = v9.Focus, v9.MouseOver;
local v15 = v6.Spell;
local v16 = v6.Item;
local v17 = pairs;
local v18 = UnitInParty;
local v19 = UnitInRaid;
local v20 = {};
local v21 = {};
v20.Everyone = v21;
local v23 = v2.GUISettingsGet();
local v24 = v23.General;
local v25 = v23.Interrupt;
v2.Commons = function()
	return v20;
end;
local v27 = {[781 - 531]="Blood",[718 - 467]="Frost",[485 - 233]="Unholy",[1486 - 909]="Havoc",[1200 - (555 + 64)]="Vengeance",[1033 - (857 + 74)]="Balance",[671 - (367 + 201)]="Feral",[1031 - (214 + 713)]="Guardian",[27 + 78]="Restoration",[231 + 1236]="Devastation",[2345 - (282 + 595)]="Preservation",[3110 - (1523 + 114)]="Augmentation",[228 + 25]="BeastMastery",[361 - 107]="Marksmanship",[1320 - (68 + 997)]="Survival",[1332 - (226 + 1044)]="Arcane",[274 - 211]="Fire",[181 - (32 + 85)]="Frost",[263 + 5]="Brewmaster",[60 + 209]="Windwalker",[1227 - (892 + 65)]="Mistweaver",[155 - 90]="Holy",[121 - 55]="Protection",[128 - 58]="Retribution",[606 - (87 + 263)]="Discipline",[437 - (67 + 113)]="Holy",[190 + 68]="Shadow",[635 - 376]="Assassination",[192 + 68]="Outlaw",[1037 - 776]="Subtlety",[1214 - (802 + 150)]="Elemental",[707 - 444]="Enhancement",[478 - 214]="Restoration",[193 + 72]="Affliction",[1263 - (915 + 82)]="Demonology",[755 - 488]="Destruction",[42 + 29]="Arms",[94 - 22]="Fury",[1260 - (1069 + 118)]="Protection"};
local v28 = {"Warrior","Paladin","Hunter","Rogue","Priest","DeathKnight","Shaman","Mage","Warlock","Monk","Druid","DemonHunter","Evoker"};
v21.converArrayToList = function(v131)
	local v132 = {};
	for v385, v386 in v17(v131) do
		v132[v386] = true;
	end
	return v132;
end;
local v30 = v21.converArrayToList({(426954 - (44 + 386)),(136005 + 292098),(253695 - (201 + 571)),(1116913 - 848635),(963964 - 699914),(254376 - (814 + 45)),(13663 + 239881),(253666 - (261 + 624)),(256121 - (1020 + 60)),(848413 - 598045),(98497 + 151599),(255330 - (760 + 987)),(260338 - (745 + 21)),(688923 - 438555),(2100 + 254749),(201686 - (87 + 968)),(185303 + 18940),(226975 - (447 + 966)),(203216 - (1703 + 114)),(433280 - 168890),(73153 + 182825),(263973 - (9 + 5)),(272439 - (243 + 1022)),(229707 + 48737),(216329 + 49547),(266337 - (1869 + 61)),(937647 - 671422),(57128 + 360353),(392804 + 25396),(412271 - (140 + 831)),(413096 - (15 + 703)),(412671 - (262 + 176)),(408579 - (198 + 490)),(546693 - 318780),(419977 - 219729),(32131 + 167532),(547079 - 382114),(820935 - 655722),(14332 + 155507),(168918 - (660 + 176)),(427661 - (14 + 188)),(30442 + 45280),(73763 + 2957),(677569 - 250786),(221231 + 190763),(416166 - (115 + 281)),(343957 + 71478),(1523324 - 1107887),(601398 - 185142),(1155816 - 742209),(415271 - (970 + 695)),(402170 - (582 + 1408)),(519549 - 106625),(419305 - (1195 + 629)),(412619 - (187 + 54)),(288851 + 123382),(881716 - 468289),(32286 + 380636),(389635 - (451 + 549)),(579537 - 207143),(373699 - (746 + 638)),(574338 - 196056),(397008 - (1535 + 46)),(53862 + 318361),(23783 + 360378),(398392 - (899 + 568)),(901692 - 529077),(372828 - (60 + 230)),(45856 + 336939),(370486 - (569 + 242)),(21141 + 348533),(371074 - (721 + 530)),(923386 - 553783),(370099 - (271 + 429)),(370900 - (1408 + 92)),(378788 - (993 + 295)),(370536 - (418 + 753)),(39396 + 342853),(92877 + 274623),(379719 - (1749 + 20)),(386351 - (1249 + 73)),(374949 - (466 + 679)),(1071265 - 696721),(117909 + 254802),(1103894 - 729997),(382826 - (4 + 110)),(383862 - (41 + 1386)),(259587 + 122887),(1113875 - 729242),(646136 - 272070),(304519 + 69820),(757761 - 383716),(257110 + 116970),(1472350 - 1082907),(1065066 - 669372),(374883 - (53 + 267)),(385554 - (15 + 398)),(1410437 - 1035731),(236506 + 138878),(293463 + 82487),(27874 + 349474),(809039 - 431637),(196937 + 190681),(987365 - 612666),(377722 - (1126 + 425)),(1522221 - 1133829),(1161242 - 764430),(1712032 - 1334643),(397617 - (553 + 424)),(341774 + 46201),(217192 + 155825),(224117 + 168334),(1073595 - 688285),(111721 + 272473),(384950 - (239 + 514)),(386262 - (797 + 532)),(125748 + 247001),(373945 - (373 + 829)),(376726 - (369 + 761)),(682239 - 306637),(387802 - (64 + 174)),(572450 - 185904),(377704 - (42 + 174)),(309755 + 64177),(386312 - (363 + 1141)),(1146880 - 770155),(286892 + 96931),(242065 + 142300),(387948 - (565 + 1368)),(389072 - (1477 + 184)),(361160 + 26453),(668499 - 281059),(373699 - (244 + 60)),(397870 - (41 + 435)),(293426 + 88104),(127562 + 260044),(238454 + 147570),(386279 - (176 + 91)),(570549 - 183424),(436661 - (157 + 1718)),(1543482 - 1108689),(435820 - (697 + 321)),(924396 - 488074),(174478 + 273770),(1163002 - 729161),(442821 - (602 + 9)),(444299 - (826 + 46)),(1401220 - 957790),(445331 - (260 + 1638)),(1419687 - 977151),(934482 - 482320),(447291 - (902 + 303)),(1045584 - 611462),(432993 - (1121 + 569)),(431992 - (483 + 200)),(1233601 - 782845),(451878 - (468 + 297)),(1454880 - 1023547),(784437 - 351917),(451350 - (141 + 95)),(1161126 - 710029),(101027 + 330276),(300941 + 127145),(636704 - 184577),(452969 - (92 + 71)),(716708 - 290425),(370740 + 78715),(219185 + 209925),(429235 - (55 + 71)),(446997 - (573 + 1217)),(32683 + 396862),(430361 - (714 + 225)),(599625 - 169528),(467350 - 144583),(322986 - (25 + 23)),(326662 - (927 + 959)),(325646 - (16 + 716)),(326143 - (11 + 86)),(340829 - (175 + 110)),(1593397 - 1270340),(898802 - 576974),(323511 - (810 + 251)),(102735 + 232013),(320995 - (43 + 490)),(1239125 - 918789),(80875 + 254268),(22732 + 320738),(324698 - (255 + 150)),(179216 + 155532),(1092853 - 754500),(327536 - (183 + 223)),(221800 + 112948),(320508 - (10 + 327)),(322612 - (118 + 220)),(257406 - (108 + 341)),(1086812 - 829749),(528767 - 252941),(147325 + 307115),(810325 - 537744),(9792 + 262779),(1178229 - 726968),(453038 - (645 + 522)),(76332 + 37),(224798 - 148087),(193311 - 116942),(448471 - (351 + 154))});
local v31 = v21.converArrayToList({(429442 - (28 + 238)),(269761 - (1381 + 178)),(161547 + 38798),(813032 - 577194),(226032 - (381 + 89)),(152817 + 73146),(166121 - (1074 + 82)),(415390 - (214 + 1570)),(92991 + 132582),(195852 + 5548),(255309 - (1668 + 58)),(1072319 - 661019),(699623 - 498562),(30866 + 134021),(259087 - 182274),(78289 - (1269 + 200)),(279259 - (98 + 717)),(437198 - 183681),(39187 + 226159),(70199 + 357177),(754392 - 483217),(76542 + 137460),(340035 + 72198),(93427 + 106678),(1283709 - 1019319),(69527 + 131131),(370295 + 41663),(412370 - (192 + 134)),(141930 + 113111),(185445 + 15185),(412563 - (83 + 468)),(1939335 - 1523899),(1144798 - 731325),(399095 + 14392),(150623 + 261882),(72405 + 339239),(413611 - (340 + 1571)),(413179 - (1733 + 39)),(413296 - (125 + 909)),(184903 + 227297),(399764 + 12392),(265607 - (46 + 190)),(74470 + 189568),(271901 - (228 + 498)),(146140 + 118385),(669357 - 412435),(274181 - (303 + 221)),(211027 + 42212),(1074258 - 813592),(633149 - 379428),(906671 - 648018),(407322 - 154635),(200152 - (111 + 1137)),(595499 - 395415),(200814 - (423 + 100)),(554720 - 354377),(201115 - (326 + 445)),(446332 - 245987),(226673 - (530 + 181)),(201171 - (19 + 13)),(468195 - 267282),(55579 + 158424),(443805 - 229804),(352113 - 179535),(330026 - 157447),(1005676 - 578771),(15611 + 60905),(98761 + 328623),(236730 + 142088),(374059 - (673 + 1185)),(1195211 - 823009),(266237 + 105988),(499359 - 129506),(736682 - 367217),(371346 - (446 + 1434)),(1127385 - 749653),(375976 - (609 + 1322)),(1478643 - 1082949),(1873497 - 1497326),(1365375 - 989425),(170402 + 218480),(201111 + 166410),(242948 + 124536),(278717 + 109193),(382488 + 8450),(1113274 - 727738),(84017 + 128767),(348194 + 35499),(605935 - 208004),(115313 - (89 + 578)),(439647 - 228174),(50270 + 322465),(44493 + 328256),(610157 - 239932),(374774 - (497 + 345)),(64883 + 318940),(276556 + 111059),(17511 + 364566),(391964 + 42829),(331072 + 107404),(187619 + 254591),(407011 + 25020),(1569216 - 1125786),(452958 - (588 + 208)),(439500 - (884 + 916)),(254727 + 184597),(433222 - (1569 + 320)),(85898 + 366229),(422838 - (316 + 289)),(14914 + 308024),(322298 - (360 + 65)),(321725 - (79 + 175)),(251701 + 70849),(644677 - 309929),(334929 - (92 + 89)),(165022 + 156758),(1281087 - 953957),(731000 - 410404),(153429 + 167797),(39984 + 280374),(323138 - (485 + 759)),(258481 - (442 + 747)),(269698 - (88 + 858)),(63487 + 13224),(448802 - (766 + 23)),(615566 - 165478)});
v21.PurgeList = {(679648 - 479400),(182100 + 74749),(201047 + 54532),(429242 - (910 + 3)),(267052 - (1466 + 218)),(370971 - (556 + 592)),(370208 - (329 + 479)),(1297156 - 919656),(269845 + 108105),(33339 + 343461),(384280 - (135 + 1254)),(1847544 - 1451850),(375593 - (389 + 1138)),(356151 + 21251),(361741 + 26214),(685485 - 300422),(374213 - (157 + 1307)),(979168 - 586714),(664273 - 290301),(937269 - 559120),(24775 + 364911),(8311 + 378811),(375082 - (300 + 4)),(1007014 - 622328),(153966 + 232257),(221315 + 165004),(289879 + 97717),(288706 + 99925),(837329 - 461842),(432186 - (627 + 66)),(451358 - (512 + 90)),(433237 - (373 + 344)),(119357 + 331740),(549606 - 224830),(236408 + 88506),(1302 + 324744),(336400 - (233 + 1026)),(131374 + 125583),(81938 + 193888)};
v21.SootheList = {(38387 - (55 + 166)),(25871 + 231389),(165510 - (36 + 261)),(257192 - (34 + 1334)),(331476 + 95142),(228339 - (20 + 1)),(383386 - (134 + 185)),(383240 - (314 + 371)),(385732 - (478 + 490)),(370978 - (786 + 386)),(392317 - (1055 + 324)),(340962 + 42731),(1538896 - 1151282),(1073853 - 696469),(132286 + 239589),(1492466 - 1059464),(1129469 - 687824),(1236659 - 785547),(107629 + 217108),(513619 - 192916),(328423 - (1249 + 19)),(1245649 - 925637),(214109 + 58779),(2136 + 449243),(5071 + 445962)};
v21.DebuffList = {Magic=v21.converArrayToList({(376389 - (224 + 246)),(267358 - 122152),(10111 + 414777),(641293 - 318736),(427247 - (203 + 310)),(29813 + 396922),(787566 - 360184),(465740 - (196 + 668)),(669789 - 346442),(429638 - (4 + 89)),(160303 + 279935),(176255 + 273200),(325746 - (28 + 1425)),(311843 + 13380),(464312 - 139088),(272868 - (45 + 252)),(110807 + 211161),(440746 - (114 + 319)),(544449 - 119560)}),Poison=v21.converArrayToList({(660598 - 217201),(445364 - (556 + 1407)),(436787 - (170 + 295)),(312580 + 27724),(282087 + 58202),(192695 + 147593),(117311 + 321307),(1646975 - 1214748),(996049 - 669957),(277615 - (389 + 1391)),(28711 + 247125),(435088 - (783 + 168)),(454071 + 7559),(1044977 - 704694),(145327 + 302921),(315827 + 145660),(77794 + 356047)}),Disease=v21.converArrayToList({(1546274 - 1207921),(550521 - 277933),(253273 + 67323),(456135 - (556 + 1139)),(58923 + 262898),(440482 - (28 + 141))}),Curse=v21.converArrayToList({(317436 - 60268),(427625 - (486 + 831)),(1137051 - 814083),(1363790 - 932481),(406022 + 45202),(1227453 - 777358),(442257 - (1129 + 815))}),RootDispel=v21.converArrayToList({(415356 - (1326 + 424)),(1528210 - 1110010),(255812 - (720 + 51))}),FreedomDispel=v21.converArrayToList({(384369 - (421 + 1355)),(180807 + 187274),(1355383 - 984617),(386467 - (397 + 42)),(376391 - (24 + 776)),(442995 - (222 + 563)),(312227 + 121435),(435579 - (690 + 1108)),(357805 + 75980),(71470 + 362613),(426963 + 19755),(243166 + 200264),(287765 + 155662),(675683 - 223812),(433035 - (1165 + 561)),(1321672 - 894937),(431973 - (341 + 138)),(930965 - 479861),(1414772 - 974992),(288176 - (581 + 300)),(1104181 - 639305),(429396 - (1030 + 205)),(409538 + 30700),(1023635 - 573130)}),SnareRoot=v21.converArrayToList({(847112 - 433506),(96150 + 68735),(46634 + 118252),(427663 - (671 + 492)),(419415 - (369 + 846)),(348258 + 59826),(202778 + 52263)}),Entangled=v21.converArrayToList({(408759 - (11 + 192))}),Bleed=v21.converArrayToList({(431666 - (135 + 40)),(194718 + 128325),(384832 - 128123),(1221296 - 782697),(326400 - (1233 + 180)),(323228 - (107 + 1314)),(1362861 - 915600),(635858 - 315658),(442017 - (716 + 1194)),(47164 + 393149)}),Raid=v21.converArrayToList({(805988 - 388181),(860516 - 484597)})};
v21.AfflictedDispelList = {(1262363 - 852898),(409903 - (279 + 154)),(322157 + 87315)};
v21.TankBustersList2 = v21.converArrayToList({(207360 + 177237),(137735 + 234995),(1645045 - 1260067),(74114 + 321178),(1606990 - 1232457),(89408 + 285381),(379242 - (41 + 1857)),(971637 - 595700),(378179 - (229 + 953)),(390490 - (874 + 705)),(268081 + 124843),(10639 + 367352),(86989 + 294523),(505019 - 303880),(521983 - 296251),(198959 - (718 + 823)),(214808 - (266 + 539)),(205836 - (636 + 589)),(409164 - 210785),(74355 + 130312),(506586 - 315260),(411441 - (1151 + 36)),(109910 + 308149),(414845 - (1552 + 280)),(274917 + 129999),(73422 + 340107),(814974 - 407815),(407856 - 141975),(266579 - (599 + 220)),(429307 - (1813 + 118)),(428887 - (841 + 376)),(59372 + 196207),(415394 - (464 + 395)),(199109 + 215495),(856749 - 442166),(1375482 - 974234),(389434 - 222049),(439881 - (74 + 1208)),(2069297 - 1632975),(433392 - (14 + 376)),(280688 + 153097),(418174 + 20297),(333564 + 109833),(1071576 - 619425),(405212 + 46026),(136747 + 297975),(1178759 - 738291),(1197875 - 756577),(461869 - (10 + 17)),(451787 - (1400 + 332)),(441554 - (242 + 1666)),(158140 + 273353),(432431 - (850 + 90)),(452503 - (360 + 1030)),(1218308 - 786671),(452778 - (909 + 752)),(828457 - 375955),(428328 - (6 + 236)),(364800 + 88412),(745842 - 318841),(70284 + 357098),(33458 + 390308),(243716 + 215494),(1198023 - 769129),(190955 + 238467),(379051 + 45837),(1321713 - 893002),(994070 - 571837),(153924 + 168645),(229880 + 92677),(463939 - (478 + 244)),(154685 + 185523),(341845 - (655 + 901)),(246381 + 75447),(1291967 - 971271),(1094289 - 773827),(1294227 - 972420),(747030 - 426568),(52277 + 272046),(135691 + 188703),(338626 - (239 + 30)),(325305 + 13151),(1000542 - 679846),(1181703 - 843067),(196738 + 123917),(956507 - 622019),(204132 + 116639),(65858 + 190758),(92689 + 164020),(113288 + 143880),(251514 + 16716),(24819 + 247769),(277323 - (1309 + 179)),(122040 + 158349),(340933 + 110431),(899430 - 448052),(1110136 - 658165),(1416971 - 965730),(232277 + 214984),(450849 - (851 + 554)),(1247147 - 797460),(448268 - (115 + 187)),(426103 + 23997)});
v21.TankBustersMagicList = {(385758 - (160 + 1001)),(272744 + 122548),(374891 - (237 + 121)),(744939 - 352015),(378133 - (96 + 46)),(137724 + 243788),(759870 - 555203),(375485 - 184159),(414248 - (316 + 403)),(1119434 - 712275),(669584 - 403703),(85650 + 180110),(2041082 - 1613706),(11713 + 192898),(12914 + 251464),(167402 - (12 + 5)),(930943 - 494621),(1078064 - 643342),(443271 - (1656 + 317)),(370091 + 91751),(2214962 - 1764907),(2088251 - 1648605),(284340 + 147153),(593914 - 142801),(562496 - 130859),(453568 - (507 + 559)),(1323939 - 895853),(454117 - (250 + 655)),(802404 - 343194),(431378 - (1869 + 87)),(430612 - (484 + 1417)),(540596 - 218027),(526930 - 204373),(269205 + 194012),(95234 + 245055),(322681 - (152 + 701)),(122726 + 197736),(94721 + 225741),(900548 - 643380),(587471 - 314883),(452837 - (39 + 827)),(1007793 - 556552),(687766 - 239800),(1317386 - 867286)};
v21.TankBustersPhysicalList = {(589807 - 217077),(385532 - (475 + 79)),(1199346 - 824557),(332091 + 45253),(1093976 - 718039),(164376 + 212621),(389230 - (27 + 292)),(256505 - 55366),(445158 - 219426),(197557 - (43 + 96)),(483835 - 269832),(57775 + 146836),(76031 + 122348),(129157 + 281097),(419810 - (1414 + 337)),(1076665 - 663652),(1201619 - 796703),(332747 + 94923),(179405 + 76174),(355188 + 59347),(320918 + 80330),(103640 + 61245),(256131 - (128 + 569)),(418603 - (687 + 1200)),(930725 - 666169),(412465 - (275 + 146)),(265824 - (29 + 35)),(499967 - 332582),(285672 + 152927),(433410 - (312 + 96)),(434070 - (147 + 138)),(396236 + 42235),(443889 - (18 + 474)),(1475766 - 1023615),(451541 - (121 + 182)),(441708 - (988 + 252)),(135156 + 296335),(452007 - (223 + 667)),(734947 - 307946),(428507 - (146 + 979)),(424371 - (311 + 294)),(181674 + 247220),(426246 - (1233 + 125)),(378817 + 43416),(341853 - (963 + 682)),(322200 - (504 + 1000)),(293061 + 28746),(478256 - 153933),(188655 + 135739),(194922 + 143435),(338620 - (149 + 15)),(320813 - (39 + 78)),(744667 - 406031),(165443 + 155212),(71059 + 263429),(84038 + 236733),(253626 + 2990),(6480 + 250229),(249544 + 18686),(982406 - 706571),(147590 + 132799),(300634 + 150730),(453088 - (1596 + 114)),(447974 - (164 + 549)),(558089 - 108645),(75804 + 373883),(369325 + 80775)};
v21.NPCAlwaysInCombat = v21.converArrayToList({(640936 - 424751),(184717 + 29726),(230489 - (254 + 466)),(730130 - 500391),(196134 - (236 + 17)),(175488 + 49955),(1011690 - 798006),(182302 + 39042),(5692 + 129549),(571481 - 351479),(381446 - 157570),(224441 - (326 + 38)),(334086 - 100062),(77727 + 142774),(356607 - 136893),(216318 - (76 + 416))});
v21.NPCAlwaysInCombatBossFight = v21.converArrayToList({(281093 - 158125),(272806 - 174264),(547156 - 360418),(188527 - (1261 + 650)),(313135 - 116653),(26254 + 159862),(191563 - (1524 + 320)),(223935 - (18 + 138)),(220980 - (67 + 1035)),(917131 - 701305)});
v21.Buggedmobs = v21.converArrayToList({(200494 + 16995),(218573 - (1050 + 32)),(129472 + 89412),(17622 + 200748),(223875 - (267 + 458)),(430140 - 206466),(225865 - (1410 + 87)),(603330 - 380126),(224114 - (461 + 335)),(223105 - (1730 + 31)),(780940 - 560439),(503493 - 283747),(202743 + 19120)});
do
	local v133 = C_UnitAuras.GetAuraDataByIndex;
	local v134, v135;
	local v136, v137, v138, v139, v140;
	local v141, v142, v143;
	v9.AuraInfo = function(v388, v389, v390, v391)
		v134 = v388:GUID();
		if not v134 then
			return;
		end
		local v392 = v7.UnitInfo[v134];
		if not v392 then
			v392 = {};
			v7.UnitInfo[v134] = v392;
		end
		local v393 = v392[v390];
		if not v393 then
			if (v390 == "HELPFUL") then
				v141 = v390;
				v142 = "HELPFUL|PLAYER";
			elseif (v390 == "HARMFUL") then
				v141 = v390;
				v142 = "HARMFUL|PLAYER";
			elseif (v390 == "HELPFUL|PLAYER") then
				v141 = "HELPFUL";
				v142 = v390;
			elseif (v390 == "HARMFUL|PLAYER") then
				v141 = "HARMFUL";
				v142 = v390;
			end
			UnitFilterInfoAll = {};
			UnitFilterInfoPlayer = {};
			v135 = v388:ID();
			v140 = 1 + 0;
			while true do
				AuraData = v133(v135, v140, v141);
				if (type(AuraData) ~= "table") then
					break;
				end
				v136 = AuraData.applications;
				v137 = AuraData.duration;
				v138 = AuraData.expirationTime;
				v139 = AuraData.spellId;
				v143 = AuraData.sourceUnit;
				if not v139 then
					break;
				end
				UnitFilterInfoAll[v139] = {v136,v137,v138,v143,v140};
				if (v143 == "player") then
					UnitFilterInfoPlayer[v139] = {v136,v137,v138,v143,v140};
				end
				v140 = v140 + (4 - 3);
			end
			v392[v141] = UnitFilterInfoAll;
			v392[v142] = UnitFilterInfoPlayer;
			v393 = v392[v390];
		end
		local v394 = v393[v389:ID()];
		if v394 then
			return unpack(v394);
		end
	end;
end
local v42 = v7.Persistent.Player.Class[594 - (562 + 29)];
local v43 = v28[v42];
local v44 = v7.Persistent.Player.Spec[1 + 0];
local v45 = v27[v44];
v20.ClassUpdate = function()
	v42 = v7.Persistent.Player.Class[1422 - (374 + 1045)];
	v43 = v28[v42];
	v44 = v7.Persistent.Player.Spec[1 + 0];
	v45 = v27[v44];
	if v23.APL[v43][v45 .. "_Interrupt"] then
		v25 = v23.APL[v43][v45 .. "_Interrupt"].Interrupt;
	else
		v25 = v23.Interrupt.Interrupt;
	end
end;
local v47, v48, v49 = false, false, 0 - 0;
v6:RegisterForEvent(function()
	v47 = true;
end, "PLAYER_STARTED_LOOKING");
v6:RegisterForEvent(function()
	v47 = false;
	v49 = GetTime();
end, "PLAYER_STOPPED_LOOKING");
v6:RegisterForEvent(function()
	v48 = true;
end, "PLAYER_STARTED_TURNING");
v6:RegisterForEvent(function()
	v48 = false;
	v49 = GetTime();
end, "PLAYER_STOPPED_TURNING");
v10.IsCameraBusy = function(v149)
	return (v48 or v47) and (v49 < (GetTime() + (639 - (448 + 190))));
end;
v9.CanBeStunned = function(v150)
	return (v10:Level() >= v150:Level()) and not v150:IsStunned() and not v150:IsBoss();
end;
v9.IsBoss = function(v151)
	if v9.Boss then
		for v491, v492 in v17(v9.Boss) do
			if (v492:Exists() and (v492:GUID() == v151:GUID())) then
				return true;
			end
		end
	end
end;
v9.AffectingCombat = function(v152)
	return UnitAffectingCombat(v152.UnitID) or v152:IsDummy() or v21.NPCAlwaysInCombat[v152:NPCID()] or v21.NPCAlwaysInCombatBossFight[v9.Boss.boss1:NPCID()] or v21.NPCAlwaysInCombatBossFight[v9.Boss.boss2:NPCID()] or v21.NPCAlwaysInCombatBossFight[v9.Boss.boss3:NPCID()];
end;
v9.Cast = function(v153, v154, v155)
	local v156 = ((v153:ID() == "player") and "PARTYPLAYER") or string.upper(v153:ID());
	return v2.CastTarget(v154, v156, v155);
end;
v9.UnitIsFriend = function(v157)
	return UnitIsFriend("player", v157:ID());
end;
v9.UnitIsPlayer = function(v158)
	return UnitIsPlayer(v158:ID());
end;
v9.UnitIsEnemy = function(v159)
	return UnitIsEnemy("player", v159:ID());
end;
v9.Role = function(v160)
	return UnitGroupRolesAssigned(v160.UnitID) or -(1 + 0);
end;
v9.SpecID = function(v161)
	return GetInspectSpecialization(v161.UnitID) or -(1 + 0);
end;
v9.ClassID = function(v162)
	local v163, v163, v164 = UnitClass(v162.UnitID);
	return v164 or -(1 + 0);
end;
v9.IncomingHeals = function(v165)
	local v166 = UnitGetIncomingHeals(v165.UnitID) or (0 - 0);
	local v167 = v165:MaxHealth();
	if (v166 == (0 - 0)) then
		return 1494 - (1307 + 187);
	end
	if (v167 <= (0 - 0)) then
		return 0 - 0;
	end
	local v168 = (v166 / v167) * (306 - 206);
	return math.ceil(v168);
end;
v9.HealthPercentageWeighted = function(v169)
	GUID = v169:GUID();
	if not GUID then
		return 783 - (232 + 451);
	end
	local v170 = v7.UnitInfo[GUID];
	if not v170 then
		v170 = {};
		v7.UnitInfo[GUID] = v170;
	end
	local v171 = v170['HealthPercentageWeighted'];
	if not v171 then
		v171 = v21.CalculateWeight(v169);
		v170['HealthPercentageWeighted'] = v171;
	end
	return v171;
end;
v9.DebuffElapsed = function(v172, v173, v174, v175)
	local v176 = v172:DebuffDuration(v173, v174);
	local v177 = v172:DebuffRemains(v173, v174, v175);
	local v178 = v176 - v177;
	return ((v178 >= (0 + 0)) and v178) or (883 + 116);
end;
v21.num = function(v179)
	if v179 then
		return 565 - (510 + 54);
	else
		return 0 - 0;
	end
end;
v21.bool = function(v180)
	return v180 ~= (36 - (13 + 23));
end;
v21.TargetIsValid = function()
	return v12:Exists() and v10:CanAttack(v12) and not v12:IsDeadOrGhost();
end;
v21.UnitIsCycleValid = function(v181, v182, v183)
	return not v181:IsFacingBlacklisted() and not v181:IsUserCycleBlacklisted() and (not v182 or v181:FilteredTimeToDie(">", v182, v183));
end;
v21.CanDoTUnit = function(v184, v185)
	return (v184:Health() >= v185) or v184:IsDummy();
end;
v21.Interrupt = function(v186, v187, v188, v189)
	v21.InterruptCycle(v187, v186, nil, nil, false);
end;
v21.IsSoloMode = function()
	return v24.SoloMode and not v10:IsInRaidArea() and not v10:IsInDungeonArea();
end;
v21.ISSolo = function()
	return not v10:IsInRaidArea() and not v10:IsInDungeonArea();
end;
local v72 = v15(445067 - 216749);
local function v73(v190, v191)
	if ((v10:IsInRaidArea() and v25.InterruptEverythingRaid) or (v10:IsInDungeonArea() and v190:BuffDown(v72) and ((v25.InterruptInDungeon == "Everything") or ((v25.InterruptInDungeon == "Whitelist") and v191[v190:CastSpellID() or v190:ChannelSpellID()]))) or (v25.InterruptEverythingSolo and v21.ISSolo())) then
		local v463 = v190:ID();
		if ((v463 ~= "target") and (v463 ~= "mouseover")) then
			return true;
		end
		if (v190:IsChanneling() and (v190:CastPercentage() <= v25.InterruptPercentChannel)) then
			return true;
		elseif (not v190:IsChanneling() and (v190:CastPercentage() >= v25.InterruptPercent)) then
			return true;
		end
		return false, true;
	end
end
do
	local v192 = v15(88089 - 26785);
	v10.GCDDuration = function(v395)
		local v396, v396, v396, v397 = v192:CooldownInfo();
		return v397;
	end;
	v15.CooldownWithoutGCD = function(v398)
		local v399, v400, v399, v401 = v398:CooldownInfo();
		if (v400 == (0 - 0)) then
			return 1088 - (830 + 258);
		end
		local v402 = ((v400 + v401) - GetTime()) - v10:GCDDuration();
		v402 = ((v402 > (0 - 0)) and v402) or (0 + 0);
		return v402 == (0 + 0);
	end;
end
local function v74(v195)
	if (v25.AutoInterrupt and v195:IsInterruptible()) then
		return v73(v195, v30);
	end
end
local function v75(v196)
	if (v25.AutoStun and v196:CanBeStunned() and v196:IsCasting()) then
		return v73(v196, v31) or (v25.InterruptInDungeonUseStunAsInterrupt and v73(v196, v30));
	end
end
v21.InterruptCycle = function(v197, v198, v199, v200, v201, v202)
	if not (v197:IsLearned() and v197:CooldownWithoutGCD() and v197:IsUsableP()) then
		return nil;
	end
	local v203 = v10:GetEnemiesInRange(v198);
	local v204 = (v201 and v75) or v74;
	local v205 = (v201 and v25.AutoTargetStun) or v25.AutoTargetInterrupt;
	local v206 = v21.CastCycle(v197, v203, v204, v198, v199, v200, v205, v202);
	if v206 then
		return "InterruptCycle:" .. v206;
	end
end;
local function v77(v207)
	for v403, v404 in v17(v21.PurgeList) do
		if v207:BuffUp(v15(v404), true) then
			return true;
		end
	end
	return false;
end
v21.PurgeCycle = function(v208, v209, v210, v211)
	if not (v208:IsLearned() and v208:CooldownWithoutGCD() and v208:IsUsableP() and v208:IsAvailable()) then
		return nil;
	end
	local v212 = v10:GetEnemiesInRange(v209);
	local v213 = v21.CastCycle(v208, v212, v77, v209, v210, nil, v211);
	if v213 then
		return "PurgeCycle:" .. v213;
	end
end;
local function v79(v214)
	for v405, v406 in v17(v21.SootheList) do
		if v214:BuffUp(v15(v406), true) then
			return true;
		end
	end
	return false;
end
v21.SootheCycle = function(v215, v216, v217, v218)
	if not (v215:IsLearned() and v215:CooldownWithoutGCD() and v215:IsUsableP() and v215:IsAvailable()) then
		return nil;
	end
	local v219 = v10:GetEnemiesInRange(v216);
	local v220 = v21.CastCycle(v215, v219, v79, v216, v217, nil, v218);
	if v220 then
		return "SootheCycle:" .. v220;
	end
end;
local function v81(v221)
	if ((v221:NPCID() == (206001 - (860 + 581))) and (v221:CastSpellID() == (1507925 - 1099120))) then
		return true;
	end
end
v21.IncorpCycle = function(v222, v223, v224, v225)
	if not (v222:IsLearned() and v222:CooldownWithoutGCD() and v222:IsUsableP() and v222:IsAvailable()) then
		return nil;
	end
	local v226 = v10:GetEnemiesInRange(v223);
	local v227 = v21.CastCycle(v222, v226, v81, v223, v224, nil, v225);
	if v227 then
		return "IncorpCycle:" .. v227;
	end
end;
v21.AfflictedLogic = function(v228, v229)
	if (v12:Exists() and (v12:NPCID() == (162515 + 42258)) and v12:IsSpellInRange(v228)) then
		v4(v228, v229);
		return "afflicted";
	end
	if (v14:Exists() and (v14:NPCID() == (205014 - (237 + 4))) and v14:IsSpellInRange(v228)) then
		v2.CastTarget(v228, v2.TName().MOUSEOVER, v229);
		return "afflicted mouseover";
	end
end;
v21.CastCycle = function(v230, v231, v232, v233, v234, v235, v236, v237, v238)
	local v239, v240 = v232(v12);
	if (v12:Exists() and v10:CanAttack(v12) and not v12:IsDeadOrGhost() and v12:IsInRange(v233)) then
		if (v239 and v4(v230, v234, v235, false)) then
			return "CastCycle Target Cast " .. v230:Name();
		end
		if v240 then
			return;
		end
	end
	if ((v3() or not v238) and not v237 and v14:Exists() and v10:CanAttack(v14) and not v14:IsDeadOrGhost() and v232(v14) and v14:IsInRange(v233)) then
		if v2.CastTarget(v230, v2.TName().MOUSEOVER, v234, v235, false) then
			return "CastCycle Mouseover Cast " .. v230:Name();
		end
	end
	if (v3() or not v238) then
		local v464 = v12:GUID();
		for v493, v494 in v17(v231) do
			if ((v494:GUID() ~= v464) and not v494:IsFacingBlacklisted() and not v494:IsUserCycleBlacklisted() and v232(v494)) then
				if v237 then
					if v4(v230, v234, v235, false) then
						return "CastCycle AOESpell Cast " .. v230:Name();
					end
				end
				v5(v494, v230, v236);
				if v236 then
					return "CastCycle Tab to " .. v494:Name() .. " to Cast " .. v230:Name();
				end
			end
		end
	end
end;
v21.CastTargetIf = function(v241, v242, v243, v244, v245, v246, v247, v248, v249, v250)
	local v251 = not v245 or (v245 and v245(v12));
	local v252 = not v245 or (v245 and v245(v14));
	if (v251 and v12:IsInRange(v246) and v10:CanAttack(v12) and not v12:IsDeadOrGhost() and not v250) then
		v4(v241, v247, v248, false);
		return "CastTargetIf Target Cast " .. v241:Name();
	end
	if (v252 and v14:IsInRange(v246) and v10:CanAttack(v14) and not v14:IsDeadOrGhost() and not v250) then
		v2.CastTarget(v241, v2.TName().MOUSEOVER, v247, v248, false);
		return "CastTargetIf Mouseover Cast " .. v241:Name();
	end
	if v3() then
		local v465, v466 = nil, nil;
		for v495, v496 in v17(v242) do
			if (not v496:IsFacingBlacklisted() and not v496:IsUserCycleBlacklisted() and (v496:AffectingCombat() or v496:IsDummy()) and (not v466 or v8.CompareThis(v243, v244(v496), v466))) then
				v465, v466 = v496, v244(v496);
			end
		end
		if v465 then
			if (v251 and ((v465:GUID() == v12:GUID()) or (v466 == v244(v12)))) then
				v4(v241, v247, v248, false);
				return "CastTargetIf to Target is best Cast" .. v241:Name();
			elseif ((v245 and v245(v465)) or not v245) then
				if ((v465:GUID() == v14:GUID()) or ((v466 == v244(v14)) and v14:Exists() and v10:CanAttack(v14) and not v14:IsDeadOrGhost())) then
					v2.CastTarget(v241, v2.TName().MOUSEOVER, v247, v248, false);
					return "CastTargetIf to Mouseover is best Cast" .. v241:Name();
				end
				v5(v465, v241, v249);
				if v249 then
					return "CastTargetIf Tab to " .. v465:Name() .. " to Cast " .. v241:Name();
				end
			end
		end
	end
	if (v251 and v12:IsInRange(v246) and v10:CanAttack(v12) and not v12:IsDeadOrGhost() and v250) then
		v4(v241, v247, v248, false);
		return "CastTargetIf Target Cast " .. v241:Name();
	end
	if (v252 and v14:IsInRange(v246) and v10:CanAttack(v14) and not v14:IsDeadOrGhost() and v250) then
		v2.CastTarget(v241, v2.TName().MOUSEOVER, v247, v248, false);
		return "CastTargetIf Mouseover Cast " .. v241:Name();
	end
end;
local v86 = v15(6639 - 3814);
v21.unitHasBuffFromList = function(v253, v254)
	local v255 = v7.UnitInfo[v254:GUID()];
	local v256 = 0 - 0;
	if not v255 then
		v254:BuffInfo(v86, "HELPFUL");
		v255 = v7.UnitInfo[v254:GUID()];
	end
	if v255 then
		local v468 = v255['HELPFUL'];
		if not v468 then
			v254:BuffInfo(v86, "HELPFUL");
			v468 = v255['HELPFUL'];
		end
		if v468 then
			for v531, v532 in v17(v468) do
				if v253[v531] then
					if (v256 == (0 - 0)) then
						v256 = math.random(0.4 + 0, 0.9 + 0);
					end
					if (v254:BuffRemains(v15(v531), true) >= v256) then
						if v2.DebugON() then
							print("unitHasBuffFromList " .. v531 .. " on unit " .. v254:Name());
						end
						return true;
					end
				end
			end
		end
	end
	return false;
end;
v21.unitHasBuffFromListRemainingTime = function(v257, v258, v259)
	local v260 = v7.UnitInfo[v258:GUID()];
	if not v260 then
		v258:BuffInfo(v86, "HELPFUL");
		v260 = v7.UnitInfo[v258:GUID()];
	end
	if v260 then
		local v470 = v260['HELPFUL'];
		if not v470 then
			v258:BuffInfo(v86, "HELPFUL");
			v470 = v260['HELPFUL'];
		end
		if v470 then
			for v533, v534 in v17(v470) do
				if v257[v533] then
					if (v258:BuffRemains(v15(v533), true) >= v259) then
						if v2.DebugON() then
							print("unitHasBuffFromList " .. v533 .. " on unit " .. v258:Name());
						end
						return true;
					end
				end
			end
		end
	end
	return false;
end;
v21.unitHasDebuffFromList = function(v261, v262)
	local v263 = v7.UnitInfo[v262:GUID()];
	local v264 = 0 - 0;
	if not v263 then
		v262:DebuffInfo(v72, "HARMFUL");
		v263 = v7.UnitInfo[v262:GUID()];
	end
	if v263 then
		local v472 = v263['HARMFUL'];
		if not v472 then
			v262:DebuffInfo(v72, "HARMFUL");
			v472 = v263['HARMFUL'];
		end
		if v472 then
			for v535, v536 in v17(v472) do
				if v261[v535] then
					if (v264 == (0 + 0)) then
						v264 = math.random(0.4 + 0, 1426.9 - (85 + 1341));
					end
					if (v262:DebuffElapsed(v15(v535), true) >= v264) then
						if v2.DebugON() then
							print("unitHasDebuffFromList " .. v535 .. " on unit " .. v262:Name());
						end
						return true;
					end
				end
			end
		end
	end
	return false;
end;
local v90 = v15(547380 - 226592);
local v91 = v15(776687 - 501673);
local v92 = v15(448933 - (45 + 327));
local v93 = v15(836784 - 393347);
local v94 = v15(432950 - (444 + 58));
local v95 = v15(200539 + 260948);
local v96 = v15(73103 + 351786);
v21.DispelCycle = function(v265, v266, v267, v268)
	local v269 = v21.DebuffList[v266];
	local function v270(v407)
		if (v266 == "Magic") then
			if (v407:DebuffUp(v90, true) and (v407:DebuffElapsed(v90, true) >= (2.25 + 1))) then
				return true;
			end
			if (v407:DebuffUp(v91, true) and (v407:DebuffElapsed(v91, true) >= (8 - 5))) then
				return true;
			end
			if (v407:DebuffUp(v92, true) and (v407:DebuffElapsed(v92, true) >= (1735 - (64 + 1668)))) then
				return true;
			end
			if (v407:DebuffUp(v93, true) and (v407:DebuffElapsed(v93, true) >= (1976 - (1227 + 746)))) then
				return true;
			end
			if (v407:DebuffUp(v94, true) and (v407:DebuffElapsed(v94, true) >= (9 - 6))) then
				return true;
			end
			if (v407:DebuffUp(v96, true) and (v407:DebuffRemains(v96, true) <= (14 - 6))) then
				return true;
			end
		elseif (v266 == "Disease") then
			if (v407:DebuffUp(v90, true) and (v407:DebuffElapsed(v90, true) >= (497.25 - (415 + 79)))) then
				return true;
			end
		elseif (v266 == "Poison") then
		elseif (v266 == "Raid") then
		end
		if v21.unitHasDebuffFromList(v269, v407) then
			return true;
		end
		return false;
	end
	return v21.CycleFriendly(v265, v270, v267, nil, v268);
end;
v21.CycleFriendly = function(v271, v272, v273, v274, v275)
	local v276 = (v275 and true) or false;
	if (v10:Exists() and not v10:IsDeadOrGhost() and v272(v10)) then
		return v10:Cast(v271, v273);
	end
	if (not v275 and v19("player")) then
		v275 = v9.Raid;
	elseif (not v275 and v18("player")) then
		v275 = v9.Party;
	end
	if v275 then
		for v497, v498 in v17(v275) do
			if (v498:Exists() and not v498:IsDeadOrGhost() and v498:UnitIsFriend() and (v276 or v498:IsSpellInRange(v274 or v271)) and v272(v498)) then
				return v498:Cast(v271, v273);
			end
		end
	end
end;
local v99 = v15(11400 + 432212);
local function v100(v277)
	return (v10:DebuffUp(v99, true) and v277:DebuffUp(v99, true)) or (v10:DebuffDown(v99, true) and v277:DebuffDown(v99, true));
end
v21.UnitsinRange = function(v278)
	local v279 = {};
	if v19("player") then
		for v499, v500 in v17(v9.Raid) do
			if (v500:Exists() and not v500:IsDeadOrGhost() and v100(v500) and v500:IsSpellInRange(v278) and v500:UnitIsFriend()) then
				table.insert(v279, v500);
			end
		end
	elseif v18("player") then
		for v537, v538 in v17(v9.Party) do
			if (v538:Exists() and not v538:IsDeadOrGhost() and v538:IsSpellInRange(v278) and v538:UnitIsFriend()) then
				table.insert(v279, v538);
			end
		end
		if (v10:Exists() and not v10:IsDeadOrGhost()) then
			table.insert(v279, v10);
		end
	elseif (v10:Exists() and not v10:IsDeadOrGhost()) then
		table.insert(v279, v10);
	end
	return v279;
end;
local v102 = {[442776 - (142 + 349)]=(0.3 + 0),[620423 - 169199]=(0.3 + 0),[225781 + 94681]=(0.4 - 0),[445169 - (1710 + 154)]=(318.3 - (200 + 118)),[180448 + 274956]=(0.3 - 0),[632944 - 206208]=(0.3 + 0),[445215 + 4880]=(0.3 + 0),[70653 + 371784]=(0.3 - 0),[444524 - (363 + 887)]=(0.3 - 0),[2106993 - 1664333]=(0.3 + 0),[754589 - 432103]=(0.8 + 0),[427972 - (674 + 990)]=(0.8 + 0),[183820 + 265334]=(0.8 - 0),[432364 - (507 + 548)]=(837.8 - (289 + 548)),[434266 - (821 + 997)]=(255.8 - (195 + 60)),[115985 + 315365]=(1501.8 - (251 + 1250)),[1299070 - 855640]=(0.8 + 0),[444465 - (809 + 223)]=(0.8 - 0),[1331700 - 888263]=(0.8 - 0),[330331 + 118230]=(0.8 + 0),[440724 - (14 + 603)]=(129.8 - (118 + 11)),[70177 + 363563]=(0.8 + 0),[975555 - 640807]=(949.8 - (551 + 398)),[202358 + 117842]=(0.8 + 0),[221514 + 51057]=(0.8 - 0),[630122 - 356652]=(0.8 + 0),[1091752 - 816738]=(0.8 + 0),[440402 - (40 + 49)]=(0.6 - 0)};
local v103 = v15(102832 - (99 + 391));
local v104 = v15(27466 + 5740);
local v105 = v15(210073 - 162285);
local v106 = v15(17186 - 10246);
v21.CalculateWeight = function(v280)
	local v281 = 1 + 0;
	local v282 = v7.UnitInfo[v280:GUID()];
	if not v282 then
		v280:DebuffInfo(v72, "HARMFUL");
		v282 = v7.UnitInfo[v280:GUID()];
	end
	if v282 then
		local v475 = v282['HARMFUL'];
		if not v475 then
			v280:DebuffUp(v72, true);
			v475 = v282['HARMFUL'];
		end
		if v475 then
			for v539, v540 in v17(v475) do
				if v102[v539] then
					if v2.DebugON() then
					end
					v281 = v281 * v102[v539];
				end
			end
		end
	end
	if (v281 > (0.3 - 0)) then
		local v476 = (1605 - (1032 + 572)) * (((v280:BuffUp(v103, true) or v280:BuffUp(v106, true) or v280:BuffUp(v104, true)) and (418.1 - (203 + 214))) or (1818 - (568 + 1249)));
		v476 = v476 * ((v280:BuffUp(v105, true) and (1.3 + 0)) or (2 - 1));
		v281 = v281 * v476;
	end
	return v280:HealthPercentage() * v281;
end;
v21.GetLowestHealthUnit = function(v283)
	local v284 = v10;
	local v285 = v284:HealthPercentageWeighted();
	local v286 = nil;
	local v287 = math.huge;
	for v408, v409 in v17(v283) do
		local v410 = v409:HealthPercentageWeighted();
		if (v409:Role() == "TANK") then
			if ((not v409:ClassID() == (23 - 17)) and (v409:HealthPercentage() >= (1371 - (913 + 393)))) then
				v410 = v410 * (2.9 - 1);
			elseif (v409:PowerPercentage() > (28 - 8)) then
				v410 = v410 * (411.2 - (269 + 141));
			end
		end
		if (v410 < v285) then
			v285 = v410;
			v284 = v409;
		end
		if (v409:Role() == "TANK") then
			if ((v286 == nil) or (v410 < v287)) then
				v287 = v410;
				v286 = v409;
			end
		end
	end
	return v284, v286;
end;
v21.GetAverageGroupHealthPercent = function(v288)
	local v289 = 0 - 0;
	local v290 = #v288;
	if (v290 == (1981 - (362 + 1619))) then
		return 1725 - (950 + 675);
	end
	for v411, v412 in v17(v288) do
		v289 = v289 + v412:HealthPercentage();
	end
	return v289 / v290;
end;
v21.BuffCount = function(v291, v292)
	local v293 = 0 + 0;
	for v413, v414 in v17(v291) do
		if v414:BuffUp(v292, nil, true) then
			v293 = v293 + (1180 - (216 + 963));
		end
	end
	return v293;
end;
v21.DebuffCount = function(v294, v295)
	local v296 = 1287 - (485 + 802);
	for v415, v416 in v17(v294) do
		if v416:DebuffUp(v295, true) then
			v296 = v296 + (560 - (432 + 127));
		end
	end
	return v296;
end;
v21.DebuffCountWithStacks = function(v297, v298, v299)
	local v300 = 1073 - (1065 + 8);
	for v417, v418 in v17(v297) do
		if (v418:DebuffUp(v298, true) and (v418:DebuffStack(v298, true) >= v299)) then
			v300 = v300 + 1 + 0;
		end
	end
	return v300;
end;
v21.GetLowestHealthUnitWithBuffAndNoBuff = function(v301, v302, v303)
	local v304 = nil;
	local v305 = math.huge;
	for v419, v420 in v17(v301) do
		if (v420:BuffUp(v302, nil, true) and v420:BuffDown(v303, nil, true)) then
			local v501 = v420:HealthPercentageWeighted();
			if (v501 < v305) then
				v305 = v501;
				v304 = v420;
			end
		end
	end
	if v304 then
		return v304;
	else
		return nil;
	end
end;
v21.GetLowestHealthUnitWithBuff = function(v306, v307)
	local v308 = nil;
	local v309 = math.huge;
	for v421, v422 in v17(v306) do
		if v422:BuffUp(v307, nil, true) then
			local v502 = v422:HealthPercentageWeighted();
			if (v502 < v309) then
				v309 = v502;
				v308 = v422;
			end
		end
	end
	if v308 then
		return v308;
	else
		return nil;
	end
end;
v21.UnitstWithoutBuff = function(v310, v311)
	local v312 = {};
	for v423, v424 in v17(v310) do
		if not v424:BuffUp(v311, nil, true) then
			table.insert(v312, v424);
		end
	end
	return v312;
end;
v21.GetLowestHealthUnitWithoutBuff = function(v313, v314)
	local v315 = nil;
	local v316 = math.huge;
	for v425, v426 in v17(v313) do
		if not v426:BuffUp(v314, nil, true) then
			local v503 = v426:HealthPercentageWeighted();
			if (v503 < v316) then
				v316 = v503;
				v315 = v426;
			end
		end
	end
	if v315 then
		return v315;
	else
		return nil;
	end
end;
v21.GetLowestHealthUnitWithoutDebuff = function(v317, v318)
	local v319 = nil;
	local v320 = math.huge;
	for v427, v428 in v17(v317) do
		if not v428:DebuffUp(v318, nil, true) then
			local v504 = v428:HealthPercentageWeighted();
			if (v504 < v320) then
				v320 = v504;
				v319 = v428;
			end
		end
	end
	if v319 then
		return v319;
	else
		return nil;
	end
end;
v21.GetLowestHealthUnitWithoutBuffandDebuff = function(v321, v322, v323)
	local v324 = nil;
	local v325 = math.huge;
	for v429, v430 in v17(v321) do
		if (not v430:BuffUp(v322, nil, true) and not v430:DebuffUp(v323, nil, true)) then
			local v505 = v430:HealthPercentageWeighted();
			if (v505 < v325) then
				v325 = v505;
				v324 = v430;
			end
		end
	end
	if v324 then
		return v324;
	else
		return nil;
	end
end;
v21.GetLowestHealthUnitWithout2Buff = function(v326, v327, v328)
	local v329 = nil;
	local v330 = math.huge;
	for v431, v432 in v17(v326) do
		if (not v432:BuffUp(v327, nil, true) and not v432:BuffUp(v328, nil, true)) then
			local v506 = v432:HealthPercentageWeighted();
			if (v506 < v330) then
				v330 = v506;
				v329 = v432;
			end
		end
	end
	if v329 then
		return v329;
	else
		return nil;
	end
end;
v21.AoELogicWithCount = function(v331, v332, v333, v334)
	local v335 = 1601 - (635 + 966);
	for v433, v434 in v17(v334) do
		v335 = ((v434:HealthPercentageWeighted() < v331) and (v335 + 1 + 0)) or v335;
	end
	return (((v335 >= v332) or (v335 >= #v334)) and ((v333 == nil) or (v333 == "With Logic") or ((v333 == "With Cooldowns and Logic") and v2.CDsON()))) or ((v333 == "With Cooldowns") and v2.CDsON());
end;
v21.AoELogicWithCountUnweighted = function(v336, v337, v338, v339)
	local v340 = 42 - (5 + 37);
	for v435, v436 in v17(v339) do
		v340 = ((v436:HealthPercentage() < v336) and (v340 + (2 - 1))) or v340;
	end
	return (((v340 >= v337) or (v340 >= #v339)) and ((v338 == nil) or (v338 == "With Logic") or ((v338 == "With Cooldowns and Logic") and v2.CDsON()))) or ((v338 == "With Cooldowns") and v2.CDsON());
end;
v21.AoELogic = function(v341, v342, v343)
	local v344 = v21.GetAverageGroupHealthPercent(v343);
	return ((v344 <= v341) and ((v342 == nil) or (v342 == "With Logic") or ((v342 == "With Cooldowns and Logic") and v2.CDsON()))) or ((v342 == "With Cooldowns") and v2.CDsON());
end;
v21.GroupBuffMissing = function(v345, v346)
	local v347 = 17 + 23;
	local v348 = {[1 - 0]=(178629 + 203129),[3 - 1]=(1447325 - 1065573),[5 - 2]=(912743 - 530994),[3 + 1]=(382283 - (318 + 211)),[24 - 19]=(383340 - (963 + 624)),[3 + 3]=(382578 - (518 + 328)),[16 - 9]=(610199 - 228443),[325 - (301 + 16)]=(1118863 - 737113),[24 - 15]=(996161 - 614404),[10 + 0]=(216755 + 164996),[23 - 12]=(229664 + 152082),[2 + 10]=(1213686 - 831945),[5 + 8]=(382767 - (829 + 190))};
	if (v345:ID() == (23808 - 17135)) then
		v347 = 126 - 26;
	end
	if v10:BuffDown(v345, true) then
		return true;
	end
	local v349;
	if v19("player") then
		v349 = v9.Raid;
	elseif v18("player") then
		v349 = v9.Party;
	else
		return false;
	end
	local v350 = 0 - 0;
	local v351 = 0 - 0;
	for v437, v438 in v17(v349) do
		if (v438:Exists() and not v438:IsDeadOrGhost() and (v346 or (v438:IsSpellInRange(v345) and not (v10:IsInDelve() and (v438:Name() == "Brann Bronzebeard"))))) then
			v350 = v350 + 1 + 0;
			if (v345:ID() == (124693 + 257055)) then
				local v541, v541, v542 = v438:Class();
				if v438:BuffUp(v15(v348[v542]), true) then
					v351 = v351 + (2 - 1);
				end
			elseif v438:BuffDown(v345, true) then
				return true;
			end
		end
	end
	if ((v345:ID() == (360209 + 21539)) and (v351 < v350)) then
		return true;
	end
	return false;
end;
local v124 = v21.converArrayToList({(385834 - (259 + 17)),(135663 + 241341),(382107 - (396 + 195)),(169146 - (440 + 1321)),(1777352 - 1392987)});
do
	v21.stopCastRemains = 545 - (424 + 121);
	v21.ShouldStopCastUpdate = function()
		local v439 = v10:GetEnemiesInRange(8 + 32);
		for v478, v479 in v17(v439) do
			if v124[v479:CastSpellID()] then
				v21.stopCastRemains = v479:CastRemains() - (1347.1 - (641 + 706));
				return v479:CastRemains() <= (v10:CastRemains() + 0.1 + 0);
			end
		end
		v21.stopCastRemains = 440 - (249 + 191);
		return false;
	end;
	v21.ShouldStopCast = function(v441)
		return (v21.stopCastRemains == (0 - 0)) or (v441:ExecuteTime() < v21.stopCastRemains);
	end;
	v15.IsCastable = function(v442, v443)
		return v442:IsLearned() and v442:CooldownUp(v443) and ((v21.stopCastRemains == (0 + 0)) or (v442:ExecuteTime() < v21.stopCastRemains));
	end;
	v15.IsReady2 = function(v444)
		return v444:IsCastable2() and v444:IsUsableP();
	end;
end
v21.GetCurrentEmpowerData = function(v357)
	local v358 = 0 - 0;
	local v359 = {};
	_, _, _, StartTimeMS, EndTimeMS, _, _, _, _, StageTotal = UnitChannelInfo("player");
	if (StageTotal and (StageTotal > (427 - (183 + 244)))) then
		local v480 = 0 + 0;
		for v507 = 731 - (434 + 296), StageTotal do
			v359[v507] = {Start=v480,Finish=(v480 + (GetUnitEmpowerStageDuration("player", v507 - (2 - 1)) / (1512 - (169 + 343))))};
			v2.Print(" Start" .. v507 .. ": " .. v359[v507].Start);
			v2.Print("Finish" .. v507 .. ": " .. v359[v507].Finish);
			v480 = v359[v507].Finish;
			if (((StartTimeMS / (877 + 123)) + v480) <= GetTime()) then
				v358 = v507;
			end
		end
	end
	if v357 then
		return v358;
	else
		return v359;
	end
end;
local v126 = {};
v6:RegisterForEvent(function(v360, v361)
	v126[UnitGUID(v361)] = v361;
end, "NAME_PLATE_UNIT_ADDED");
v6:RegisterForEvent(function(v363, v364)
	v126[UnitGUID(v364)] = nil;
end, "NAME_PLATE_UNIT_REMOVED");
local v127 = {};
v6:RegisterForCombatEvent(function(...)
	local v366, v367, v367, v367, v367, v367, v367, v367, v368 = select(6 - 2, ...);
	local v369 = v126[v366];
	if v369 then
		if (UnitIsUnit(v369 .. "target", v10:ID()) and v368) then
			if not v127[v10:ID()] then
				v127[v10:ID()] = {};
			end
			for v543, v544 in v17(v127[v10:ID()]) do
				if ((v544 < GetTime()) and v543) then
					v127[v543] = nil;
				end
			end
			v127[v10:ID()][v368] = v9.Nameplate[v369]:CastEnd();
			return;
		end
		if not v19("player") then
			for v545, v546 in v17(v9.Party) do
				if (v546:Exists() and not v546:IsDeadOrGhost() and v546:UnitIsFriend()) then
					if (UnitIsUnit(v369 .. "target", v546:ID()) and v368) then
						if not v127[v546:ID()] then
							v127[v546:ID()] = {};
						end
						for v553, v554 in v17(v127[v546:ID()]) do
							if ((v554 < GetTime()) and v553) then
								v127[v553] = nil;
							end
						end
						v127[v546:ID()][v368] = v9.Nameplate[v369]:CastEnd();
						return;
					end
				end
			end
		end
	end
end, "SPELL_CAST_START", "SPELL_PERIODIC__CAST_START");
v9.IncomingSpell = function(v370, v371)
	if not v127[v370:ID()] then
		v127[v370:ID()] = {};
	end
	for v445, v446 in v17(v127[v370:ID()]) do
		if ((v446 < GetTime()) and v445) then
			v127[v370:ID()][v445] = nil;
		elseif v371[v445] then
			return v445;
		end
	end
end;
v9.IncomingSpellreflection = function(v372, v373)
	if not v127[v372:ID()] then
		v127[v372:ID()] = {};
	end
	for v447, v448 in v17(v127[v372:ID()]) do
		if ((v448 < GetTime()) and v447) then
			v127[v372:ID()][v447] = nil;
		elseif v373[v447] then
			for v549, v550 in v17(v126) do
				if ((v9.Nameplate[v550]:CastRemains() > (0 - 0)) and (v9.Nameplate[v550]:CastRemains() < (1 + 0))) then
					return v447;
				end
			end
		end
	end
end;
v21.PotionSelected = function()
	local v374 = v23.APL[v43][v45].PotionType.Selected;
	local v375 = v23.APL[v43][v45].PotionRank and v23.APL[v43][v45].PotionRank.Selected;
	local v376 = {(213388 - (651 + 472)),(91585 + 120679),(212746 - (397 + 86))};
	local v377 = {(1 + 2),(2 + 0),(1 + 0)};
	local v378 = "";
	if (v374 == "Tempered Potion") then
		for v512, v513 in ipairs(v376) do
			local v514 = v377[((v512 - (1191 - (50 + 1140))) % #v377) + 1 + 0];
			if ((not v375 or (tostring(v514) == v375) or (v375 == "Any")) and v16(v513):IsUsable()) then
				return v16(v513);
			end
		end
	else
		return nil;
	end
end;
do
	local v379 = {Spells={v15(23452 + 353770),v15(237642 + 90787),v15(603105 - 256270),v15(555570 - 367751),v15(182200 - (112 + 743)),v15(26959 + 130100),v15(752084 - 547473)},PetMounts={(313159 - 196357),(248868 - 161786),(145483 - 58405),(88770 - (1201 + 488)),(154876 - 67796),(87664 - (352 + 233)),(47369 + 39707)}};
	v10.IsInWhitelistedVehicle = function(v449)
		local v450 = v379.Spells;
		for v483 = 2 - 1, #v450 do
			local v484 = v450[v483];
			if v449:DebuffUp(v484, true, true) then
				return true;
			end
		end
		local v451 = v379.PetMounts;
		if v11:IsActive() then
			for v529 = 575 - (489 + 85), #v451 do
				local v530 = v451[v529];
				if (v11:NPCID() == v530) then
					return true;
				end
			end
		end
		return false;
	end;
end
do
	local v381 = {v15(4318 - (663 + 830)),v15(78806 - 46624),v15(13469 + 66884),v15(8609 + 81746),v15(160702 - (172 + 78)),v15(97410 + 167257),v15(106458 + 283928),v15(59435 - 23960),v15(8918 + 26558),v15(52164 + 94391),v15(415193 - 236986),v15(131861 + 99074),v15(44629 + 212111),v15(1108522 - 798864),v15(1146555 - 765254),v15(445546 - (426 + 863))};
	v9.BloodlustRemains = function(v452, v453)
		local v454 = v452:GUID();
		if not v454 then
			return false;
		end
		for v485 = 4 - 3, #v381 do
			local v486 = v381[v485];
			if v452:BuffUp(v486, true) then
				return v452:BuffRemains(v486, true, v453);
			end
		end
		return 1654 - (873 + 781);
	end;
	v9.BloodlustUp = function(v455, v456)
		return v455:BloodlustRemains(v456) > (0 - 0);
	end;
	v9.BloodlustDown = function(v457, v458)
		return not v457:BloodlustUp(v458);
	end;
end
