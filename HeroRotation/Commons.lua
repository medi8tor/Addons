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
v21.converArrayToList = function(v133)
	local v134 = {};
	for v388, v389 in v17(v133) do
		v134[v389] = true;
	end
	return v134;
end;
local v30 = v21.converArrayToList({(426954 - (44 + 386)),(136005 + 292098),(253695 - (201 + 571)),(1116913 - 848635),(963964 - 699914),(254376 - (814 + 45)),(13663 + 239881),(253666 - (261 + 624)),(256121 - (1020 + 60)),(848413 - 598045),(98497 + 151599),(255330 - (760 + 987)),(260338 - (745 + 21)),(688923 - 438555),(2100 + 254749),(201686 - (87 + 968)),(185303 + 18940),(226975 - (447 + 966)),(203216 - (1703 + 114)),(433280 - 168890),(73153 + 182825),(263973 - (9 + 5)),(272439 - (243 + 1022)),(229707 + 48737),(216329 + 49547),(266337 - (1869 + 61)),(937647 - 671422),(57128 + 360353),(392804 + 25396),(412271 - (140 + 831)),(413096 - (15 + 703)),(412671 - (262 + 176)),(408579 - (198 + 490)),(546693 - 318780),(419977 - 219729),(32131 + 167532),(547079 - 382114),(820935 - 655722),(14332 + 155507),(168918 - (660 + 176)),(427661 - (14 + 188)),(30442 + 45280),(73763 + 2957),(677569 - 250786),(221231 + 190763),(416166 - (115 + 281)),(343957 + 71478),(1523324 - 1107887),(601398 - 185142),(1155816 - 742209),(415271 - (970 + 695)),(402170 - (582 + 1408)),(519549 - 106625),(419305 - (1195 + 629)),(412619 - (187 + 54)),(288851 + 123382),(881716 - 468289),(32286 + 380636),(389635 - (451 + 549)),(579537 - 207143),(373699 - (746 + 638)),(574338 - 196056),(397008 - (1535 + 46)),(53862 + 318361),(23783 + 360378),(398392 - (899 + 568)),(901692 - 529077),(372828 - (60 + 230)),(45856 + 336939),(370486 - (569 + 242)),(21141 + 348533),(371074 - (721 + 530)),(923386 - 553783),(370099 - (271 + 429)),(370900 - (1408 + 92)),(378788 - (993 + 295)),(370536 - (418 + 753)),(39396 + 342853),(92877 + 274623),(379719 - (1749 + 20)),(386351 - (1249 + 73)),(374949 - (466 + 679)),(1071265 - 696721),(117909 + 254802),(1103894 - 729997),(382826 - (4 + 110)),(383862 - (41 + 1386)),(259587 + 122887),(1113875 - 729242),(646136 - 272070),(304519 + 69820),(757761 - 383716),(257110 + 116970),(1472350 - 1082907),(1065066 - 669372),(374883 - (53 + 267)),(385554 - (15 + 398)),(1410437 - 1035731),(236506 + 138878),(293463 + 82487),(27874 + 349474),(809039 - 431637),(196937 + 190681),(987365 - 612666),(377722 - (1126 + 425)),(1522221 - 1133829),(1161242 - 764430),(1712032 - 1334643),(397617 - (553 + 424)),(341774 + 46201),(217192 + 155825),(224117 + 168334),(1073595 - 688285),(111721 + 272473),(384950 - (239 + 514)),(386262 - (797 + 532)),(125748 + 247001),(373945 - (373 + 829)),(376726 - (369 + 761)),(682239 - 306637),(387802 - (64 + 174)),(572450 - 185904),(377704 - (42 + 174)),(309755 + 64177),(386312 - (363 + 1141)),(1146880 - 770155),(286892 + 96931),(242065 + 142300),(387948 - (565 + 1368)),(389072 - (1477 + 184)),(361160 + 26453),(668499 - 281059),(373699 - (244 + 60)),(397870 - (41 + 435)),(293426 + 88104),(127562 + 260044),(238454 + 147570),(386279 - (176 + 91)),(570549 - 183424),(436661 - (157 + 1718)),(1543482 - 1108689),(435820 - (697 + 321)),(924396 - 488074),(174478 + 273770),(1163002 - 729161),(442821 - (602 + 9)),(444299 - (826 + 46)),(1401220 - 957790),(445331 - (260 + 1638)),(1419687 - 977151),(934482 - 482320),(447291 - (902 + 303)),(1045584 - 611462),(432993 - (1121 + 569)),(431992 - (483 + 200)),(1233601 - 782845),(451878 - (468 + 297)),(1454880 - 1023547),(784437 - 351917),(451350 - (141 + 95)),(1161126 - 710029),(101027 + 330276),(300941 + 127145),(636704 - 184577),(452969 - (92 + 71)),(716708 - 290425),(370740 + 78715),(219185 + 209925),(429235 - (55 + 71)),(446997 - (573 + 1217)),(32683 + 396862),(430361 - (714 + 225)),(599625 - 169528),(467350 - 144583),(322986 - (25 + 23)),(326662 - (927 + 959)),(325646 - (16 + 716)),(326143 - (11 + 86)),(340829 - (175 + 110)),(1593397 - 1270340),(898802 - 576974),(323511 - (810 + 251)),(102735 + 232013),(320995 - (43 + 490)),(1239125 - 918789),(80875 + 254268),(22732 + 320738),(324698 - (255 + 150)),(179216 + 155532),(1092853 - 754500),(327536 - (183 + 223)),(221800 + 112948),(320508 - (10 + 327)),(322612 - (118 + 220)),(257406 - (108 + 341)),(1086812 - 829749),(528767 - 252941),(147325 + 307115),(810325 - 537744),(9792 + 262779),(1178229 - 726968),(453038 - (645 + 522)),(76332 + 37),(224798 - 148087),(193311 - 116942),(448471 - (351 + 154))});
local v31 = v21.converArrayToList({(429442 - (28 + 238)),(269761 - (1381 + 178)),(161547 + 38798),(813032 - 577194),(226032 - (381 + 89)),(152817 + 73146),(166121 - (1074 + 82)),(415390 - (214 + 1570)),(92991 + 132582),(195852 + 5548),(255309 - (1668 + 58)),(1072319 - 661019),(699623 - 498562),(30866 + 134021),(259087 - 182274),(78289 - (1269 + 200)),(279259 - (98 + 717)),(437198 - 183681),(39187 + 226159),(70199 + 357177),(754392 - 483217),(76542 + 137460),(340035 + 72198),(93427 + 106678),(1283709 - 1019319),(69527 + 131131),(370295 + 41663),(412370 - (192 + 134)),(141930 + 113111),(185445 + 15185),(412563 - (83 + 468)),(1939335 - 1523899),(1144798 - 731325),(399095 + 14392),(150623 + 261882),(72405 + 339239),(413611 - (340 + 1571)),(413179 - (1733 + 39)),(413296 - (125 + 909)),(184903 + 227297),(399764 + 12392),(265607 - (46 + 190)),(74470 + 189568),(271901 - (228 + 498)),(146140 + 118385),(669357 - 412435),(274181 - (303 + 221)),(211027 + 42212),(1074258 - 813592),(633149 - 379428),(906671 - 648018),(407322 - 154635),(200152 - (111 + 1137)),(595499 - 395415),(200814 - (423 + 100)),(554720 - 354377),(201115 - (326 + 445)),(446332 - 245987),(226673 - (530 + 181)),(201171 - (19 + 13)),(468195 - 267282),(55579 + 158424),(443805 - 229804),(352113 - 179535),(330026 - 157447),(1005676 - 578771),(15611 + 60905),(98761 + 328623),(236730 + 142088),(374059 - (673 + 1185)),(1195211 - 823009),(266237 + 105988),(499359 - 129506),(736682 - 367217),(371346 - (446 + 1434)),(1127385 - 749653),(375976 - (609 + 1322)),(1478643 - 1082949),(1873497 - 1497326),(1365375 - 989425),(170402 + 218480),(201111 + 166410),(242948 + 124536),(278717 + 109193),(382488 + 8450),(1113274 - 727738),(84017 + 128767),(348194 + 35499),(605935 - 208004),(115313 - (89 + 578)),(439647 - 228174),(50270 + 322465),(44493 + 328256),(610157 - 239932),(374774 - (497 + 345)),(64883 + 318940),(276556 + 111059),(17511 + 364566),(391964 + 42829),(331072 + 107404),(187619 + 254591),(407011 + 25020),(1569216 - 1125786),(452958 - (588 + 208)),(439500 - (884 + 916)),(254727 + 184597),(433222 - (1569 + 320)),(85898 + 366229),(422838 - (316 + 289)),(14914 + 308024),(322298 - (360 + 65)),(321725 - (79 + 175)),(251701 + 70849),(644677 - 309929),(334929 - (92 + 89)),(165022 + 156758),(1281087 - 953957),(731000 - 410404),(153429 + 167797),(39984 + 280374),(323138 - (485 + 759)),(258481 - (442 + 747)),(269698 - (88 + 858)),(63487 + 13224),(448802 - (766 + 23)),(615566 - 165478)});
v21.PurgeList = {(679648 - 479400),(182100 + 74749),(201047 + 54532),(429242 - (910 + 3)),(267052 - (1466 + 218)),(370971 - (556 + 592)),(370208 - (329 + 479)),(1297156 - 919656),(269845 + 108105),(33339 + 343461),(384280 - (135 + 1254)),(1847544 - 1451850),(375593 - (389 + 1138)),(356151 + 21251),(361741 + 26214),(685485 - 300422),(374213 - (157 + 1307)),(979168 - 586714),(664273 - 290301),(937269 - 559120),(24775 + 364911),(8311 + 378811),(375082 - (300 + 4)),(1007014 - 622328),(153966 + 232257),(221315 + 165004),(289879 + 97717),(288706 + 99925),(837329 - 461842),(432186 - (627 + 66)),(451358 - (512 + 90)),(433237 - (373 + 344)),(119357 + 331740),(549606 - 224830),(236408 + 88506),(1302 + 324744),(336400 - (233 + 1026)),(131374 + 125583),(81938 + 193888)};
v21.SootheList = {(38387 - (55 + 166)),(25871 + 231389),(165510 - (36 + 261)),(257192 - (34 + 1334)),(331476 + 95142),(228339 - (20 + 1)),(383386 - (134 + 185)),(383240 - (314 + 371)),(385732 - (478 + 490)),(370978 - (786 + 386)),(392317 - (1055 + 324)),(340962 + 42731),(1538896 - 1151282),(1073853 - 696469),(132286 + 239589),(1492466 - 1059464),(1129469 - 687824),(1236659 - 785547),(107629 + 217108),(513619 - 192916),(328423 - (1249 + 19)),(1245649 - 925637),(214109 + 58779),(2136 + 449243),(5071 + 445962)};
v21.DebuffList = {Magic=v21.converArrayToList({(376389 - (224 + 246)),(267358 - 122152),(10111 + 414777),(641293 - 318736),(427247 - (203 + 310)),(29813 + 396922),(787566 - 360184),(465740 - (196 + 668)),(669789 - 346442),(429638 - (4 + 89)),(160303 + 279935),(176255 + 273200),(325746 - (28 + 1425)),(311843 + 13380),(464312 - 139088),(272868 - (45 + 252)),(110807 + 211161),(440746 - (114 + 319)),(544449 - 119560)}),Poison=v21.converArrayToList({(660598 - 217201),(445364 - (556 + 1407)),(436787 - (170 + 295)),(312580 + 27724),(282087 + 58202),(192695 + 147593),(117311 + 321307),(1646975 - 1214748),(996049 - 669957),(277615 - (389 + 1391)),(28711 + 247125),(435088 - (783 + 168)),(454071 + 7559),(1044977 - 704694),(145327 + 302921),(315827 + 145660),(77794 + 356047)}),Disease=v21.converArrayToList({(1546274 - 1207921),(550521 - 277933),(253273 + 67323),(456135 - (556 + 1139)),(58923 + 262898),(440482 - (28 + 141))}),Curse=v21.converArrayToList({(317436 - 60268),(427625 - (486 + 831)),(1137051 - 814083),(1363790 - 932481),(406022 + 45202),(1227453 - 777358),(442257 - (1129 + 815))}),RootDispel=v21.converArrayToList({(415356 - (1326 + 424)),(1528210 - 1110010),(255812 - (720 + 51))}),FreedomDispel=v21.converArrayToList({(384369 - (421 + 1355)),(180807 + 187274),(1355383 - 984617),(386467 - (397 + 42)),(376391 - (24 + 776)),(442995 - (222 + 563)),(312227 + 121435),(435579 - (690 + 1108)),(357805 + 75980),(71470 + 362613),(426963 + 19755),(243166 + 200264),(287765 + 155662),(675683 - 223812),(433035 - (1165 + 561)),(1321672 - 894937),(431973 - (341 + 138)),(930965 - 479861),(1414772 - 974992),(288176 - (581 + 300)),(1104181 - 639305),(429396 - (1030 + 205)),(409538 + 30700),(1023635 - 573130),(898835 - 459975)}),SnareRoot=v21.converArrayToList({(241186 + 172420),(46634 + 118251),(166049 - (671 + 492)),(427715 - (369 + 846)),(356891 + 61309),(324459 + 83625),(255244 - (11 + 192))}),Entangled=v21.converArrayToList({(408731 - (135 + 40))}),Bleed=v21.converArrayToList({(260087 + 171404),(484274 - 161231),(714816 - 458107),(440012 - (1233 + 180)),(326408 - (107 + 1314)),(980586 - 658779),(888177 - 440916),(322110 - (716 + 1194)),(47142 + 392965),(849404 - 409091)}),Raid=v21.converArrayToList({(956402 - 538595),(1158942 - 783023)})};
v21.AfflictedDispelList = {(409898 - (279 + 154)),(322155 + 87315),(220771 + 188701)};
v21.TankBustersList2 = v21.converArrayToList({(142120 + 242477),(1592709 - 1219979),(72180 + 312798),(1696060 - 1300768),(89347 + 285186),(376687 - (41 + 1857)),(975274 - 597930),(377119 - (229 + 953)),(378576 - (874 + 705)),(265343 + 123568),(11059 + 381865),(86186 + 291805),(957899 - 576387),(465114 - 263975),(227273 - (718 + 823)),(198223 - (266 + 539)),(215228 - (636 + 589)),(422018 - 217407),(72071 + 126308),(541910 - 337243),(192513 - (1151 + 36)),(107858 + 302396),(419891 - (1552 + 280)),(280414 + 132599),(71893 + 333023),(827724 - 414195),(624574 - 217415),(266700 - (599 + 220)),(267691 - (1813 + 118)),(428593 - (841 + 376)),(99349 + 328321),(256438 - (464 + 395)),(199076 + 215459),(856793 - 442189),(1421195 - 1006612),(933534 - 532286),(168667 - (74 + 1208)),(2080096 - 1641497),(436712 - (14 + 376)),(280181 + 152821),(413705 + 20080),(329859 + 108612),(1050829 - 607432),(406031 + 46120),(141942 + 309296),(1163382 - 728660),(1195622 - 755154),(441325 - (10 + 17)),(463574 - (1400 + 332)),(451963 - (242 + 1666)),(161128 + 278518),(432433 - (850 + 90)),(432881 - (360 + 1030)),(1273279 - 822166),(433298 - (909 + 752)),(825921 - 374804),(452744 - (6 + 236)),(344576 + 83510),(791625 - 338413),(70221 + 356780),(33743 + 393639),(224905 + 198861),(1282704 - 823494),(190720 + 238174),(383096 + 46326),(1309927 - 885039),(1009321 - 580610),(201482 + 220751),(229888 + 92681),(323279 - (478 + 244)),(210614 + 252603),(341764 - (655 + 901)),(260514 + 79775),(1296527 - 974699),(1095088 - 774392),(1288817 - 968355),(750165 - 428358),(51655 + 268807),(135661 + 188662),(324663 - (239 + 30)),(325210 + 13147),(1055952 - 717496),(1119100 - 798404),(207770 + 130866),(916950 - 596295),(212861 + 121627),(82322 + 238449),(92656 + 163960),(113086 + 143623),(241141 + 16027),(24422 + 243808),(274076 - (1309 + 179)),(120057 + 155778),(211789 + 68600),(899402 - 448038),(1108679 - 657301),(1419263 - 967292),(234344 + 216897),(448666 - (851 + 554)),(1246473 - 797029),(449989 - (115 + 187)),(424083 + 23883),(451261 - (160 + 1001))});
v21.TankBustersMagicList = {(265364 + 119233),(395650 - (237 + 121)),(710071 - 335538),(393066 - (96 + 46)),(136453 + 241538),(1416446 - 1034934),(401667 - 197000),(192045 - (316 + 403)),(1136947 - 723418),(1025373 - 618214),(85689 + 180192),(1269229 - 1003469),(24466 + 402910),(9995 + 194616),(264395 - (12 + 5)),(357135 - 189750),(1082032 - 645710),(436695 - (1656 + 317)),(353628 + 87670),(2272972 - 1811130),(2137692 - 1687637),(289713 + 149933),(568083 - 136590),(587875 - 136762),(432703 - (507 + 559)),(1399450 - 946948),(428991 - (250 + 655)),(791922 - 338710),(461166 - (1869 + 87)),(431323 - (484 + 1417)),(718481 - 289770),(526949 - 204380),(187458 + 135099),(129637 + 333580),(341142 - (152 + 701)),(123249 + 198579),(94721 + 225741),(1122190 - 801728),(554238 - 297070),(273454 - (39 + 827)),(1009423 - 557452),(692794 - 241553),(1311140 - 863174),(712237 - 262137)};
v21.TankBustersPhysicalList = {(373284 - (475 + 79)),(1231951 - 846973),(329842 + 44947),(1098071 - 720727),(163913 + 212024),(377316 - (27 + 292)),(495965 - 107054),(396659 - 195520),(225871 - (43 + 96)),(446339 - 248921),(60427 + 153576),(78419 + 126192),(62454 + 135925),(412005 - (1414 + 337)),(1089820 - 671761),(1225647 - 812634),(315043 + 89873),(300204 + 127466),(218989 + 36590),(331545 + 82990),(252207 + 149041),(165582 - (128 + 569)),(257321 - (687 + 1200)),(1466034 - 1049318),(264977 - (275 + 146)),(412108 - (29 + 35)),(793806 - 528046),(109023 + 58362),(439007 - (312 + 96)),(433287 - (147 + 138)),(392001 + 41784),(438963 - (18 + 474)),(1447194 - 1003797),(452454 - (121 + 182)),(452478 - (988 + 252)),(137968 + 302500),(432381 - (223 + 667)),(776455 - 325338),(428126 - (146 + 979)),(427987 - (311 + 294)),(179502 + 244264),(430252 - (1233 + 125)),(381199 + 43689),(423878 - (963 + 682)),(341712 - (504 + 1000)),(292049 + 28647),(474545 - 152738),(188614 + 135709),(186878 + 137516),(338521 - (149 + 15)),(338573 - (39 + 78)),(705216 - 384520),(174721 + 163915),(68120 + 252535),(87632 + 246856),(317033 + 3738),(6478 + 250138),(238826 + 17883),(955320 - 687090),(145193 + 130642),(186755 + 93634),(453074 - (1596 + 114)),(452091 - (164 + 549)),(555379 - 108118),(75763 + 373681),(368986 + 80701),(1334438 - 884338)};
v21.NPCAlwaysInCombat = v21.converArrayToList({(186217 + 29968),(215163 - (254 + 466)),(730225 - 500456),(229992 - (236 + 17)),(152476 + 43405),(1067363 - 841920),(175994 + 37690),(9316 + 212028),(351304 - 216063),(374846 - 154844),(224240 - (326 + 38)),(319886 - 95809),(82494 + 151530),(357885 - 137384),(220206 - (76 + 416)),(493358 - 277532)});
v21.NPCAlwaysInCombatBossFight = v21.converArrayToList({(340428 - 217460),(288735 - 190193),(188649 - (1261 + 650)),(297411 - 110795),(27716 + 168766),(187960 - (1524 + 320)),(189875 - (18 + 138)),(224881 - (67 + 1035)),(934350 - 714472),(198960 + 16866)});
v21.Buggedmobs = v21.converArrayToList({(218571 - (1050 + 32)),(128648 + 88843),(17664 + 201220),(219095 - (267 + 458)),(429132 - 205982),(225171 - (1410 + 87)),(606476 - 382108),(224000 - (461 + 335)),(225079 - (1730 + 31)),(783925 - 562581),(505223 - 284722),(200808 + 18938),(190144 + 31719)});
do
	local v135 = C_UnitAuras.GetAuraDataByIndex;
	local v136, v137;
	local v138, v139, v140, v141, v142;
	local v143, v144, v145;
	v9.AuraInfo = function(v391, v392, v393, v394)
		v136 = v391:GUID();
		if not v136 then
			return;
		end
		local v395 = v7.UnitInfo[v136];
		if not v395 then
			v395 = {};
			v7.UnitInfo[v136] = v395;
		end
		local v396 = v395[v393];
		if not v396 then
			if (v393 == "HELPFUL") then
				v143 = v393;
				v144 = "HELPFUL|PLAYER";
			elseif (v393 == "HARMFUL") then
				v143 = v393;
				v144 = "HARMFUL|PLAYER";
			elseif (v393 == "HELPFUL|PLAYER") then
				v143 = "HELPFUL";
				v144 = v393;
			elseif (v393 == "HARMFUL|PLAYER") then
				v143 = "HARMFUL";
				v144 = v393;
			end
			UnitFilterInfoAll = {};
			UnitFilterInfoPlayer = {};
			v137 = v391:ID();
			v142 = 4 - 3;
			while true do
				AuraData = v135(v137, v142, v143);
				if (type(AuraData) ~= "table") then
					break;
				end
				v138 = AuraData.applications;
				v139 = AuraData.duration;
				v140 = AuraData.expirationTime;
				v141 = AuraData.spellId;
				v145 = AuraData.sourceUnit;
				if not v141 then
					break;
				end
				UnitFilterInfoAll[v141] = {v138,v139,v140,v145,v142};
				if (v145 == "player") then
					UnitFilterInfoPlayer[v141] = {v138,v139,v140,v145,v142};
				end
				v142 = v142 + 1 + 0;
			end
			v395[v143] = UnitFilterInfoAll;
			v395[v144] = UnitFilterInfoPlayer;
			v396 = v395[v393];
		end
		local v397 = v396[v392:ID()];
		if v397 then
			return unpack(v397);
		end
	end;
end
local v42 = v7.Persistent.Player.Class[1422 - (374 + 1045)];
local v43 = v28[v42];
local v44 = v7.Persistent.Player.Spec[1 + 0];
local v45 = v27[v44];
v20.ClassUpdate = function()
	v42 = v7.Persistent.Player.Class[9 - 6];
	v43 = v28[v42];
	v44 = v7.Persistent.Player.Spec[639 - (448 + 190)];
	v45 = v27[v44];
	if v23.APL[v43][v45 .. "_Interrupt"] then
		v25 = v23.APL[v43][v45 .. "_Interrupt"].Interrupt;
	else
		v25 = v23.Interrupt.Interrupt;
	end
end;
local v47, v48, v49 = false, false, 0 + 0;
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
v10.IsCameraBusy = function(v151)
	return (v48 or v47) and (v49 < (GetTime() + 1 + 0));
end;
v9.CanBeStunned = function(v152)
	return (v10:Level() >= v152:Level()) and not v152:IsStunned() and not v152:IsBoss();
end;
v9.IsBoss = function(v153)
	if v9.Boss then
		for v494, v495 in v17(v9.Boss) do
			if (v495:Exists() and (v495:GUID() == v153:GUID())) then
				return true;
			end
		end
	end
end;
v9.AffectingCombat = function(v154)
	return UnitAffectingCombat(v154.UnitID) or v154:IsDummy() or v21.NPCAlwaysInCombat[v154:NPCID()] or v21.NPCAlwaysInCombatBossFight[v9.Boss.boss1:NPCID()] or v21.NPCAlwaysInCombatBossFight[v9.Boss.boss2:NPCID()] or v21.NPCAlwaysInCombatBossFight[v9.Boss.boss3:NPCID()];
end;
v9.Cast = function(v155, v156, v157)
	local v158 = ((v155:ID() == "player") and "PARTYPLAYER") or string.upper(v155:ID());
	return v2.CastTarget(v156, v158, v157);
end;
v9.UnitIsFriend = function(v159)
	return UnitIsFriend("player", v159:ID());
end;
v9.UnitIsPlayer = function(v160)
	return UnitIsPlayer(v160:ID());
end;
v9.UnitIsEnemy = function(v161)
	return UnitIsEnemy("player", v161:ID());
end;
v9.Role = function(v162)
	return UnitGroupRolesAssigned(v162.UnitID) or -(1 + 0);
end;
v9.SpecID = function(v163)
	return GetInspectSpecialization(v163.UnitID) or -(3 - 2);
end;
v9.ClassID = function(v164)
	local v165, v165, v166 = UnitClass(v164.UnitID);
	return v166 or -(2 - 1);
end;
v9.IncomingHeals = function(v167)
	local v168 = UnitGetIncomingHeals(v167.UnitID) or (1494 - (1307 + 187));
	local v169 = v167:MaxHealth();
	if (v168 == (0 - 0)) then
		return 0 - 0;
	end
	if (v169 <= (0 - 0)) then
		return 683 - (232 + 451);
	end
	local v170 = (v168 / v169) * (96 + 4);
	return math.ceil(v170);
end;
v9.HealthPercentageWeighted = function(v171)
	GUID = v171:GUID();
	if not GUID then
		return 89 + 11;
	end
	local v172 = v7.UnitInfo[GUID];
	if not v172 then
		v172 = {};
		v7.UnitInfo[GUID] = v172;
	end
	local v173 = v172['HealthPercentageWeighted'];
	if not v173 then
		v173 = v21.CalculateWeight(v171);
		v172['HealthPercentageWeighted'] = v173;
	end
	return v173;
end;
v9.DebuffElapsed = function(v174, v175, v176, v177)
	local v178 = v174:DebuffDuration(v175, v176);
	local v179 = v174:DebuffRemains(v175, v176, v177);
	local v180 = v178 - v179;
	return ((v180 >= (564 - (510 + 54))) and v180) or (2012 - 1013);
end;
v21.num = function(v181)
	if v181 then
		return 37 - (13 + 23);
	else
		return 0 - 0;
	end
end;
v21.bool = function(v182)
	return v182 ~= (0 - 0);
end;
v21.TargetIsValid = function()
	return v12:Exists() and v10:CanAttack(v12) and not v12:IsDeadOrGhost();
end;
v21.UnitIsCycleValid = function(v183, v184, v185)
	return not v183:IsFacingBlacklisted() and not v183:IsUserCycleBlacklisted() and (not v184 or v183:FilteredTimeToDie(">", v184, v185));
end;
v21.CanDoTUnit = function(v186, v187)
	return (v186:Health() >= v187) or v186:IsDummy();
end;
v21.Interrupt = function(v188, v189, v190, v191)
	v21.InterruptCycle(v189, v188, nil, nil, false);
end;
v21.IsSoloMode = function()
	return v24.SoloMode and not v10:IsInRaidArea() and not v10:IsInDungeonArea();
end;
v21.ISSolo = function()
	return not v10:IsInRaidArea() and not v10:IsInDungeonArea();
end;
local v72 = v15(414831 - 186513);
local function v73(v192, v193)
	if ((v10:IsInRaidArea() and v25.InterruptEverythingRaid) or (v10:IsInDungeonArea() and v192:BuffDown(v72) and ((v25.InterruptInDungeon == "Everything") or ((v25.InterruptInDungeon == "Whitelist") and v193[v192:CastSpellID() or v192:ChannelSpellID()]))) or (v25.InterruptEverythingSolo and v21.ISSolo())) then
		local v466 = v192:ID();
		if ((v466 ~= "target") and (v466 ~= "mouseover")) then
			return true;
		end
		if (v192:IsChanneling() and (v192:CastPercentage() <= v25.InterruptPercentChannel)) then
			return true;
		elseif (not v192:IsChanneling() and (v192:CastPercentage() >= v25.InterruptPercent)) then
			return true;
		end
		return false, true;
	end
end
do
	local v194 = v15(62392 - (830 + 258));
	v10.GCDDuration = function(v398)
		local v399, v399, v399, v400 = v194:CooldownInfo();
		return v400;
	end;
	v15.CooldownWithoutGCD = function(v401)
		local v402, v403, v402, v404 = v401:CooldownInfo();
		if (v403 == (0 - 0)) then
			return 0 + 0;
		end
		local v405 = ((v403 + v404) - GetTime()) - v10:GCDDuration();
		v405 = ((v405 > (0 + 0)) and v405) or (1441 - (860 + 581));
		return v405 == (0 - 0);
	end;
end
local function v74(v197)
	if (v25.AutoInterrupt and v197:IsInterruptible()) then
		return v73(v197, v30);
	end
end
local function v75(v198)
	if (v25.AutoStun and v198:CanBeStunned() and v198:IsCasting()) then
		return v73(v198, v31) or (v25.InterruptInDungeonUseStunAsInterrupt and v73(v198, v30));
	end
end
v21.InterruptCycle = function(v199, v200, v201, v202, v203, v204)
	if not (v199:IsLearned() and v199:CooldownWithoutGCD() and v199:IsUsableP()) then
		return nil;
	end
	local v205 = v10:GetEnemiesInRange(v200);
	local v206 = (v203 and v75) or v74;
	local v207 = (v203 and v25.AutoTargetStun) or v25.AutoTargetInterrupt;
	local v208 = v21.CastCycle(v199, v205, v206, v200, v201, v202, v207, v204);
	if v208 then
		return "InterruptCycle:" .. v208;
	end
end;
local function v77(v209)
	for v406, v407 in v17(v21.PurgeList) do
		if v209:BuffUp(v15(v407), true) then
			return true;
		end
	end
	return false;
end
v21.PurgeCycle = function(v210, v211, v212, v213)
	if not (v210:IsLearned() and v210:CooldownWithoutGCD() and v210:IsUsableP() and v210:IsAvailable()) then
		return nil;
	end
	local v214 = v10:GetEnemiesInRange(v211);
	local v215 = v21.CastCycle(v210, v214, v77, v211, v212, nil, v213);
	if v215 then
		return "PurgeCycle:" .. v215;
	end
end;
local function v79(v216)
	for v408, v409 in v17(v21.SootheList) do
		if v216:BuffUp(v15(v409), true) then
			return true;
		end
	end
	return false;
end
v21.SootheCycle = function(v217, v218, v219, v220)
	if not (v217:IsLearned() and v217:CooldownWithoutGCD() and v217:IsUsableP() and v217:IsAvailable()) then
		return nil;
	end
	local v221 = v10:GetEnemiesInRange(v218);
	local v222 = v21.CastCycle(v217, v221, v79, v218, v219, nil, v220);
	if v222 then
		return "SootheCycle:" .. v222;
	end
end;
local function v81(v223)
	if ((v223:NPCID() == (162346 + 42214)) and (v223:CastSpellID() == (409046 - (237 + 4)))) then
		return true;
	end
end
v21.IncorpCycle = function(v224, v225, v226, v227)
	if not (v224:IsLearned() and v224:CooldownWithoutGCD() and v224:IsUsableP() and v224:IsAvailable()) then
		return nil;
	end
	local v228 = v10:GetEnemiesInRange(v225);
	local v229 = v21.CastCycle(v224, v228, v81, v225, v226, nil, v227);
	if v229 then
		return "IncorpCycle:" .. v229;
	end
end;
v21.AfflictedLogic = function(v230, v231)
	if (v12:Exists() and (v12:NPCID() == (481263 - 276490)) and v12:IsSpellInRange(v230)) then
		v4(v230, v231);
		return "afflicted";
	end
	if (v14:Exists() and (v14:NPCID() == (518088 - 313315)) and v14:IsSpellInRange(v230)) then
		v2.CastTarget(v230, v2.TName().MOUSEOVER, v231);
		return "afflicted mouseover";
	end
end;
v21.CastCycle = function(v232, v233, v234, v235, v236, v237, v238, v239, v240)
	local v241, v242 = v234(v12);
	if (v12:Exists() and v10:CanAttack(v12) and not v12:IsDeadOrGhost() and v12:IsInRange(v235)) then
		if (v241 and v4(v232, v236, v237, false)) then
			return "CastCycle Target Cast " .. v232:Name();
		end
		if v242 then
			return;
		end
	end
	if ((v3() or not v240) and not v239 and v14:Exists() and v10:CanAttack(v14) and not v14:IsDeadOrGhost() and v234(v14) and v14:IsInRange(v235)) then
		if v2.CastTarget(v232, v2.TName().MOUSEOVER, v236, v237, false) then
			return "CastCycle Mouseover Cast " .. v232:Name();
		end
	end
	if (v3() or not v240) then
		local v467 = v12:GUID();
		for v496, v497 in v17(v233) do
			if ((v497:GUID() ~= v467) and not v497:IsFacingBlacklisted() and not v497:IsUserCycleBlacklisted() and v234(v497)) then
				if v239 then
					if v4(v232, v236, v237, false) then
						return "CastCycle AOESpell Cast " .. v232:Name();
					end
				end
				v5(v497, v232, v238);
				if v238 then
					return "CastCycle Tab to " .. v497:Name() .. " to Cast " .. v232:Name();
				end
			end
		end
	end
end;
v21.CastTargetIf = function(v243, v244, v245, v246, v247, v248, v249, v250, v251, v252)
	local v253 = not v247 or (v247 and v247(v12));
	local v254 = not v247 or (v247 and v247(v14));
	if (v253 and v12:IsInRange(v248) and v10:CanAttack(v12) and not v12:IsDeadOrGhost() and not v252) then
		v4(v243, v249, v250, false);
		return "CastTargetIf Target Cast " .. v243:Name();
	end
	if (v254 and v14:IsInRange(v248) and v10:CanAttack(v14) and not v14:IsDeadOrGhost() and not v252) then
		v2.CastTarget(v243, v2.TName().MOUSEOVER, v249, v250, false);
		return "CastTargetIf Mouseover Cast " .. v243:Name();
	end
	if v3() then
		local v468, v469 = nil, nil;
		for v498, v499 in v17(v244) do
			if (not v499:IsFacingBlacklisted() and not v499:IsUserCycleBlacklisted() and (v499:AffectingCombat() or v499:IsDummy()) and (not v469 or v8.CompareThis(v245, v246(v499), v469))) then
				v468, v469 = v499, v246(v499);
			end
		end
		if v468 then
			if (v253 and ((v468:GUID() == v12:GUID()) or (v469 == v246(v12)))) then
				v4(v243, v249, v250, false);
				return "CastTargetIf to Target is best Cast" .. v243:Name();
			elseif ((v247 and v247(v468)) or not v247) then
				if ((v468:GUID() == v14:GUID()) or ((v469 == v246(v14)) and v14:Exists() and v10:CanAttack(v14) and not v14:IsDeadOrGhost())) then
					v2.CastTarget(v243, v2.TName().MOUSEOVER, v249, v250, false);
					return "CastTargetIf to Mouseover is best Cast" .. v243:Name();
				end
				v5(v468, v243, v251);
				if v251 then
					return "CastTargetIf Tab to " .. v468:Name() .. " to Cast " .. v243:Name();
				end
			end
		end
	end
	if (v253 and v12:IsInRange(v248) and v10:CanAttack(v12) and not v12:IsDeadOrGhost() and v252) then
		v4(v243, v249, v250, false);
		return "CastTargetIf Target Cast " .. v243:Name();
	end
	if (v254 and v14:IsInRange(v248) and v10:CanAttack(v14) and not v14:IsDeadOrGhost() and v252) then
		v2.CastTarget(v243, v2.TName().MOUSEOVER, v249, v250, false);
		return "CastTargetIf Mouseover Cast " .. v243:Name();
	end
end;
local v86 = v15(5356 - 2531);
v21.unitHasBuffFromList = function(v255, v256)
	local v257 = v7.UnitInfo[v256:GUID()];
	local v258 = 0 + 0;
	if not v257 then
		v256:BuffInfo(v86, "HELPFUL");
		v257 = v7.UnitInfo[v256:GUID()];
	end
	if v257 then
		local v471 = v257['HELPFUL'];
		if not v471 then
			v256:BuffInfo(v86, "HELPFUL");
			v471 = v257['HELPFUL'];
		end
		if v471 then
			for v534, v535 in v17(v471) do
				if v255[v534] then
					if (v258 == (0 + 0)) then
						v258 = math.random(0.4 - 0, 0.9 + 0);
					end
					if (v256:BuffRemains(v15(v534), true) >= v258) then
						if v2.DebugON() then
							print("unitHasBuffFromList " .. v534 .. " on unit " .. v256:Name());
						end
						return true;
					end
				end
			end
		end
	end
	return false;
end;
v21.unitHasBuffFromListRemainingTime = function(v259, v260, v261)
	local v262 = v7.UnitInfo[v260:GUID()];
	if not v262 then
		v260:BuffInfo(v86, "HELPFUL");
		v262 = v7.UnitInfo[v260:GUID()];
	end
	if v262 then
		local v473 = v262['HELPFUL'];
		if not v473 then
			v260:BuffInfo(v86, "HELPFUL");
			v473 = v262['HELPFUL'];
		end
		if v473 then
			for v536, v537 in v17(v473) do
				if v259[v536] then
					if (v260:BuffRemains(v15(v536), true) >= v261) then
						if v2.DebugON() then
							print("unitHasBuffFromList " .. v536 .. " on unit " .. v260:Name());
						end
						return true;
					end
				end
			end
		end
	end
	return false;
end;
v21.unitHasDebuffFromList = function(v263, v264)
	local v265 = v7.UnitInfo[v264:GUID()];
	local v266 = 0 + 0;
	if not v265 then
		v264:DebuffInfo(v72, "HARMFUL");
		v265 = v7.UnitInfo[v264:GUID()];
	end
	if v265 then
		local v475 = v265['HARMFUL'];
		if not v475 then
			v264:DebuffInfo(v72, "HARMFUL");
			v475 = v265['HARMFUL'];
		end
		if v475 then
			for v538, v539 in v17(v475) do
				if v263[v538] then
					if (v266 == (1426 - (85 + 1341))) then
						v266 = math.random(0.4 - 0, 0.9 - 0);
					end
					if (v264:DebuffElapsed(v15(v538), true) >= v266) then
						if v2.DebugON() then
							print("unitHasDebuffFromList " .. v538 .. " on unit " .. v264:Name());
						end
						return true;
					end
				end
			end
		end
	end
	return false;
end;
local v90 = v15(321160 - (45 + 327));
local v91 = v15(518962 - 243948);
local v92 = v15(449063 - (444 + 58));
local v93 = v15(192696 + 250741);
local v94 = v15(74403 + 358045);
local v95 = v15(225609 + 235878);
local v96 = v15(1231325 - 806436);
v21.DispelCycle = function(v267, v268, v269, v270)
	local v271 = v21.DebuffList[v268];
	local function v272(v410)
		if (v268 == "Magic") then
			if (v410:DebuffUp(v90, true) and (v410:DebuffElapsed(v90, true) >= (1735.25 - (64 + 1668)))) then
				return true;
			end
			if (v410:DebuffUp(v91, true) and (v410:DebuffElapsed(v91, true) >= (1976 - (1227 + 746)))) then
				return true;
			end
			if (v410:DebuffUp(v92, true) and (v410:DebuffElapsed(v92, true) >= (9 - 6))) then
				return true;
			end
			if (v410:DebuffUp(v93, true) and (v410:DebuffElapsed(v93, true) >= (5 - 2))) then
				return true;
			end
			if (v410:DebuffUp(v94, true) and (v410:DebuffElapsed(v94, true) >= (497 - (415 + 79)))) then
				return true;
			end
			if (v410:DebuffUp(v96, true) and (v410:DebuffRemains(v96, true) <= (1 + 7))) then
				return true;
			end
		elseif (v268 == "Disease") then
			if (v410:DebuffUp(v90, true) and (v410:DebuffElapsed(v90, true) >= (494.25 - (142 + 349)))) then
				return true;
			end
		elseif (v268 == "Poison") then
		elseif (v268 == "Raid") then
		end
		if v21.unitHasDebuffFromList(v271, v410) then
			return true;
		end
		return false;
	end
	return v21.CycleFriendly(v267, v272, v269, nil, v270);
end;
v21.CycleFriendly = function(v273, v274, v275, v276, v277)
	local v278 = (v277 and true) or false;
	if (v10:Exists() and not v10:IsDeadOrGhost() and v274(v10)) then
		return v10:Cast(v273, v275);
	end
	if (not v277 and v19("player")) then
		v277 = v9.Raid;
	elseif (not v277 and v18("player")) then
		v277 = v9.Party;
	end
	if v277 then
		for v500, v501 in v17(v277) do
			if (v501:Exists() and not v501:IsDeadOrGhost() and v501:UnitIsFriend() and (v278 or v501:IsSpellInRange(v276 or v273)) and v274(v501)) then
				return v501:Cast(v273, v275);
			end
		end
	end
end;
local v99 = v15(190036 + 253576);
local function v100(v279)
	return (v10:DebuffUp(v99, true) and v279:DebuffUp(v99, true)) or (v10:DebuffDown(v99, true) and v279:DebuffDown(v99, true));
end
v21.UnitsinRange = function(v280)
	local v281 = {};
	if v19("player") then
		for v502, v503 in v17(v9.Raid) do
			if (v503:Exists() and not v503:IsDeadOrGhost() and v100(v503) and v503:IsSpellInRange(v280) and v503:UnitIsFriend()) then
				table.insert(v281, v503);
			end
		end
	elseif v18("player") then
		for v540, v541 in v17(v9.Party) do
			if (v541:Exists() and not v541:IsDeadOrGhost() and v541:IsSpellInRange(v280) and v541:UnitIsFriend()) then
				table.insert(v281, v541);
			end
		end
		if (v10:Exists() and not v10:IsDeadOrGhost()) then
			table.insert(v281, v10);
		end
	elseif (v10:Exists() and not v10:IsDeadOrGhost()) then
		table.insert(v281, v10);
	end
	return v281;
end;
local v102 = {[608132 - 165847]=(0.3 + 0),[317909 + 133315]=(0.3 - 0),[322326 - (1710 + 154)]=(318.4 - (200 + 118)),[175654 + 267651]=(0.3 - 0),[675465 - 220061]=(0.3 + 0),[422109 + 4627]=(0.3 + 0),[71876 + 378219]=(0.3 - 0),[443687 - (363 + 887)]=(0.3 - 0),[2109916 - 1666642]=(0.3 + 0),[1035787 - 593127]=(0.3 + 0),[324150 - (674 + 990)]=(0.8 + 0),[174470 + 251838]=(0.8 - 0),[450209 - (507 + 548)]=(837.8 - (289 + 548)),[433127 - (821 + 997)]=(255.8 - (195 + 60)),[116281 + 316167]=(1501.8 - (251 + 1250)),[1263681 - 832331]=(0.8 + 0),[444462 - (809 + 223)]=(0.8 - 0),[1331688 - 888255]=(0.8 - 0),[326558 + 116879]=(0.8 + 0),[449178 - (14 + 603)]=(129.8 - (118 + 11)),[71207 + 368900]=(0.8 + 0),[1264047 - 830307]=(949.8 - (551 + 398)),[211552 + 123196]=(0.8 + 0),[260221 + 59979]=(0.8 - 0),[628050 - 355479]=(0.8 + 0),[1085623 - 812153]=(0.8 + 0),[275103 - (40 + 49)]=(0.8 - 0),[440803 - (99 + 391)]=(0.6 + 0)};
local v103 = v15(449890 - 347548);
local v104 = v15(82230 - 49024);
local v105 = v15(46550 + 1238);
local v106 = v15(18261 - 11321);
v21.CalculateWeight = function(v282)
	local v283 = 1605 - (1032 + 572);
	local v284 = v7.UnitInfo[v282:GUID()];
	if not v284 then
		v282:DebuffInfo(v72, "HARMFUL");
		v284 = v7.UnitInfo[v282:GUID()];
	end
	if v284 then
		local v478 = v284['HARMFUL'];
		if not v478 then
			v282:DebuffUp(v72, true);
			v478 = v284['HARMFUL'];
		end
		if v478 then
			for v542, v543 in v17(v478) do
				if v102[v542] then
					if v2.DebugON() then
					end
					v283 = v283 * v102[v542];
				end
			end
		end
	end
	if (v283 > (417.3 - (203 + 214))) then
		local v479 = (1818 - (568 + 1249)) * (((v282:BuffUp(v103, true) or v282:BuffUp(v106, true) or v282:BuffUp(v104, true)) and (1.1 + 0)) or (2 - 1));
		v479 = v479 * ((v282:BuffUp(v105, true) and (3.3 - 2)) or (1307 - (913 + 393)));
		v283 = v283 * v479;
	end
	return v282:HealthPercentage() * v283;
end;
v21.GetLowestHealthUnit = function(v285)
	local v286 = v10;
	local v287 = v286:HealthPercentageWeighted();
	local v288 = nil;
	local v289 = math.huge;
	for v411, v412 in v17(v285) do
		local v413 = v412:HealthPercentageWeighted();
		if (v412:Role() == "TANK") then
			if ((not v412:ClassID() == (16 - 10)) and (v412:HealthPercentage() >= (91 - 26))) then
				v413 = v413 * (411.9 - (269 + 141));
			elseif (v412:PowerPercentage() > (44 - 24)) then
				v413 = v413 * (1982.2 - (362 + 1619));
			end
		end
		if (v413 < v287) then
			v287 = v413;
			v286 = v412;
		end
		if (v412:Role() == "TANK") then
			if ((v288 == nil) or (v413 < v289)) then
				v289 = v413;
				v288 = v412;
			end
		end
	end
	return v286, v288;
end;
v21.GetAverageGroupHealthPercent = function(v290)
	local v291 = 1625 - (950 + 675);
	local v292 = #v290;
	if (v292 == (0 + 0)) then
		return 1279 - (216 + 963);
	end
	for v414, v415 in v17(v290) do
		v291 = v291 + v415:HealthPercentage();
	end
	return v291 / v292;
end;
v21.BuffCount = function(v293, v294)
	local v295 = 1287 - (485 + 802);
	for v416, v417 in v17(v293) do
		if v417:BuffUp(v294, nil, true) then
			v295 = v295 + (560 - (432 + 127));
		end
	end
	return v295;
end;
v21.DebuffCount = function(v296, v297)
	local v298 = 1073 - (1065 + 8);
	for v418, v419 in v17(v296) do
		if v419:DebuffUp(v297, true) then
			v298 = v298 + 1 + 0;
		end
	end
	return v298;
end;
v21.DebuffCountWithStacks = function(v299, v300, v301)
	local v302 = 1601 - (635 + 966);
	for v420, v421 in v17(v299) do
		if (v421:DebuffUp(v300, true) and (v421:DebuffStack(v300, true) >= v301)) then
			v302 = v302 + 1 + 0;
		end
	end
	return v302;
end;
v21.GetLowestHealthUnitWithBuffAndNoBuff = function(v303, v304, v305)
	local v306 = nil;
	local v307 = math.huge;
	for v422, v423 in v17(v303) do
		if (v423:BuffUp(v304, nil, true) and v423:BuffDown(v305, nil, true)) then
			local v504 = v423:HealthPercentageWeighted();
			if (v504 < v307) then
				v307 = v504;
				v306 = v423;
			end
		end
	end
	if v306 then
		return v306;
	else
		return nil;
	end
end;
v21.GetLowestHealthUnitWithBuff = function(v308, v309)
	local v310 = nil;
	local v311 = math.huge;
	for v424, v425 in v17(v308) do
		if v425:BuffUp(v309, nil, true) then
			local v505 = v425:HealthPercentageWeighted();
			if (v505 < v311) then
				v311 = v505;
				v310 = v425;
			end
		end
	end
	if v310 then
		return v310;
	else
		return nil;
	end
end;
v21.UnitstWithoutBuff = function(v312, v313)
	local v314 = {};
	for v426, v427 in v17(v312) do
		if not v427:BuffUp(v313, nil, true) then
			table.insert(v314, v427);
		end
	end
	return v314;
end;
v21.GetLowestHealthUnitWithoutBuff = function(v315, v316)
	local v317 = nil;
	local v318 = math.huge;
	for v428, v429 in v17(v315) do
		if not v429:BuffUp(v316, nil, true) then
			local v506 = v429:HealthPercentageWeighted();
			if (v506 < v318) then
				v318 = v506;
				v317 = v429;
			end
		end
	end
	if v317 then
		return v317;
	else
		return nil;
	end
end;
v21.GetLowestHealthUnitWithoutDebuff = function(v319, v320)
	local v321 = nil;
	local v322 = math.huge;
	for v430, v431 in v17(v319) do
		if not v431:DebuffUp(v320, nil, true) then
			local v507 = v431:HealthPercentageWeighted();
			if (v507 < v322) then
				v322 = v507;
				v321 = v431;
			end
		end
	end
	if v321 then
		return v321;
	else
		return nil;
	end
end;
v21.GetLowestHealthUnitWithoutBuffandDebuff = function(v323, v324, v325)
	local v326 = nil;
	local v327 = math.huge;
	for v432, v433 in v17(v323) do
		if (not v433:BuffUp(v324, nil, true) and not v433:DebuffUp(v325, nil, true)) then
			local v508 = v433:HealthPercentageWeighted();
			if (v508 < v327) then
				v327 = v508;
				v326 = v433;
			end
		end
	end
	if v326 then
		return v326;
	else
		return nil;
	end
end;
v21.GetLowestHealthUnitWithout2Buff = function(v328, v329, v330)
	local v331 = nil;
	local v332 = math.huge;
	for v434, v435 in v17(v328) do
		if (not v435:BuffUp(v329, nil, true) and not v435:BuffUp(v330, nil, true)) then
			local v509 = v435:HealthPercentageWeighted();
			if (v509 < v332) then
				v332 = v509;
				v331 = v435;
			end
		end
	end
	if v331 then
		return v331;
	else
		return nil;
	end
end;
v21.AoELogicWithCount = function(v333, v334, v335, v336)
	local v337 = 42 - (5 + 37);
	for v436, v437 in v17(v336) do
		v337 = ((v437:HealthPercentageWeighted() < v333) and (v337 + (2 - 1))) or v337;
	end
	return (((v337 >= v334) or (v337 >= #v336)) and ((v335 == nil) or (v335 == "With Logic") or ((v335 == "With Cooldowns and Logic") and v2.CDsON()))) or ((v335 == "With Cooldowns") and v2.CDsON());
end;
v21.AoELogicWithCountUnweighted = function(v338, v339, v340, v341)
	local v342 = 0 + 0;
	for v438, v439 in v17(v341) do
		v342 = ((v439:HealthPercentage() < v338) and (v342 + (1 - 0))) or v342;
	end
	return (((v342 >= v339) or (v342 >= #v341)) and ((v340 == nil) or (v340 == "With Logic") or ((v340 == "With Cooldowns and Logic") and v2.CDsON()))) or ((v340 == "With Cooldowns") and v2.CDsON());
end;
v21.AoELogic = function(v343, v344, v345)
	local v346 = v21.GetAverageGroupHealthPercent(v345);
	return ((v346 <= v343) and ((v344 == nil) or (v344 == "With Logic") or ((v344 == "With Cooldowns and Logic") and v2.CDsON()))) or ((v344 == "With Cooldowns") and v2.CDsON());
end;
v21.GroupBuffMissing = function(v347, v348)
	local v349 = 19 + 21;
	local v350 = {[1 - 0]=(1447348 - 1065590),[3 - 1]=(912750 - 530998),[3 + 0]=(382278 - (318 + 211)),[19 - 15]=(383341 - (963 + 624)),[3 + 2]=(382599 - (518 + 328)),[13 - 7]=(610161 - 228429),[324 - (301 + 16)]=(1118881 - 737125),[22 - 14]=(996143 - 614393),[9 + 0]=(216758 + 164999),[21 - 11]=(229667 + 152084),[2 + 9]=(1213702 - 831956),[4 + 8]=(382760 - (829 + 190)),[46 - 33]=(483041 - 101293)};
	if (v347:ID() == (9224 - 2551)) then
		v349 = 248 - 148;
	end
	if v10:BuffDown(v347, true) then
		return true;
	end
	local v351;
	if v19("player") then
		v351 = v9.Raid;
	elseif v18("player") then
		v351 = v9.Party;
	else
		return false;
	end
	local v352 = 0 + 0;
	local v353 = 0 + 0;
	for v440, v441 in v17(v351) do
		if (v441:Exists() and not v441:IsDeadOrGhost() and (v348 or (v441:IsSpellInRange(v347) and not (v10:IsInDelve() and (v441:Name() == "Brann Bronzebeard"))))) then
			v352 = v352 + (2 - 1);
			if (v347:ID() == (360209 + 21539)) then
				local v544, v544, v545 = v441:Class();
				if v441:BuffUp(v15(v350[v545]), true) then
					v353 = v353 + (614 - (520 + 93));
				end
			elseif v441:BuffDown(v347, true) then
				return true;
			end
		end
	end
	if ((v347:ID() == (382024 - (259 + 17))) and (v353 < v352)) then
		return true;
	end
	return false;
end;
local v124 = v21.converArrayToList({(138741 + 246817),(377595 - (396 + 195)),(383277 - (440 + 1321)),(774009 - 606624),(70060 + 314305)});
do
	v21.stopCastRemains = 1347 - (641 + 706);
	v21.ShouldStopCastUpdate = function()
		local v442 = v10:GetEnemiesInRange(16 + 24);
		for v481, v482 in v17(v442) do
			if v124[v482:CastSpellID()] then
				v21.stopCastRemains = v482:CastRemains() - (440.1 - (249 + 191));
				return v482:CastRemains() <= (v10:CastRemains() + (0.1 - 0));
			end
		end
		v21.stopCastRemains = 0 + 0;
		return false;
	end;
	v21.ShouldStopCast = function(v444)
		return (v21.stopCastRemains == (0 - 0)) or (v444:ExecuteTime() < v21.stopCastRemains);
	end;
	v15.IsCastable = function(v445, v446)
		return v445:IsLearned() and v445:CooldownUp(v446) and ((v21.stopCastRemains == (427 - (183 + 244))) or (v445:ExecuteTime() < v21.stopCastRemains));
	end;
	v15.IsReady2 = function(v447)
		return v447:IsCastable2() and v447:IsUsableP();
	end;
end
v21.GetCurrentEmpowerData = function(v359)
	local v360 = 0 + 0;
	local v361 = {};
	_, _, _, StartTimeMS, EndTimeMS, _, _, _, _, StageTotal = UnitChannelInfo("player");
	if (StageTotal and (StageTotal > (730 - (434 + 296)))) then
		local v483 = 0 - 0;
		for v510 = 513 - (169 + 343), StageTotal do
			v361[v510] = {Start=v483,Finish=(v483 + (GetUnitEmpowerStageDuration("player", v510 - (1 + 0)) / (1759 - 759)))};
			v2.Print(" Start" .. v510 .. ": " .. v361[v510].Start);
			v2.Print("Finish" .. v510 .. ": " .. v361[v510].Finish);
			v483 = v361[v510].Finish;
			if (((StartTimeMS / (2935 - 1935)) + v483) <= GetTime()) then
				v360 = v510;
			end
		end
	end
	if v359 then
		return v360;
	else
		return v361;
	end
end;
local v126 = {};
v6:RegisterForEvent(function(v362, v363)
	v126[UnitGUID(v363)] = v363;
end, "NAME_PLATE_UNIT_ADDED");
v6:RegisterForEvent(function(v365, v366)
	v126[UnitGUID(v366)] = nil;
end, "NAME_PLATE_UNIT_REMOVED");
local v127 = {};
v6:RegisterForCombatEvent(function(...)
	local v368, v369, v369, v369, v369, v369, v369, v369, v370 = select(4 + 0, ...);
	local v371 = v126[v368];
	if v371 then
		if (UnitIsUnit(v371 .. "target", v10:ID()) and v370) then
			if not v127[v10:ID()] then
				v127[v10:ID()] = {};
			end
			for v546, v547 in v17(v127[v10:ID()]) do
				if ((v547 < GetTime()) and v546) then
					v127[v546] = nil;
				end
			end
			v127[v10:ID()][v370] = v9.Nameplate[v371]:CastEnd();
			return;
		end
		if not v19("player") then
			for v548, v549 in v17(v9.Party) do
				if (v549:Exists() and not v549:IsDeadOrGhost() and v549:UnitIsFriend()) then
					if (UnitIsUnit(v371 .. "target", v549:ID()) and v370) then
						if not v127[v549:ID()] then
							v127[v549:ID()] = {};
						end
						for v557, v558 in v17(v127[v549:ID()]) do
							if ((v558 < GetTime()) and v557) then
								v127[v557] = nil;
							end
						end
						v127[v549:ID()][v370] = v9.Nameplate[v371]:CastEnd();
						return;
					end
				end
			end
		end
	end
end, "SPELL_CAST_START", "SPELL_PERIODIC__CAST_START");
v9.IncomingSpell = function(v372, v373)
	if not v127[v372:ID()] then
		v127[v372:ID()] = {};
	end
	for v448, v449 in v17(v127[v372:ID()]) do
		if ((v449 < GetTime()) and v448) then
			v127[v372:ID()][v448] = nil;
		elseif v373[v448] then
			return v448;
		end
	end
end;
v9.IncomingSpellreflection = function(v374, v375)
	if not v127[v374:ID()] then
		v127[v374:ID()] = {};
	end
	for v450, v451 in v17(v127[v374:ID()]) do
		if ((v451 < GetTime()) and v450) then
			v127[v374:ID()][v450] = nil;
		elseif v375[v450] then
			for v552, v553 in v17(v126) do
				if ((v9.Nameplate[v553]:CastRemains() > (0 - 0)) and (v9.Nameplate[v553]:CastRemains() < (1124 - (651 + 472)))) then
					return v450;
				end
			end
		end
	end
end;
v21.PotionSelected = function()
	local v376 = v23.APL[v43][v45].PotionType.Selected;
	local v377 = v23.APL[v43][v45].PotionRank and v23.APL[v43][v45].PotionRank.Selected;
	local v378 = {(91585 + 120680),(212747 - (397 + 86)),(21577 + 190686)};
	local v379 = {(3 + 0),(2 + 0),(1 + 0)};
	local v380 = "";
	if (v376 == "Tempered Potion") then
		for v515, v516 in ipairs(v378) do
			local v517 = v379[((v515 - (1 + 0)) % #v379) + 1 + 0];
			if ((not v377 or (tostring(v517) == v377) or (v377 == "Any")) and v16(v516):IsUsable()) then
				return v16(v516);
			end
		end
	else
		return nil;
	end
end;
do
	local v381 = {Spells={v15(272948 + 104274),v15(571099 - 242670),v15(1025942 - 679107),v15(188674 - (112 + 743)),v15(31128 + 150217),v15(577298 - 420239),v15(548585 - 343974)},PetMounts={(333803 - 217001),(145490 - 58408),(88767 - (1201 + 488)),(154877 - 67796),(87665 - (352 + 233)),(47370 + 39709),(87650 - (489 + 85))}};
	v10.IsInWhitelistedVehicle = function(v452)
		local v453 = v381.Spells;
		for v486 = 1502 - (277 + 1224), #v453 do
			local v487 = v453[v486];
			if v452:DebuffUp(v487, true, true) then
				return true;
			end
		end
		local v454 = v381.PetMounts;
		if v11:IsActive() then
			for v532 = 1494 - (663 + 830), #v454 do
				local v533 = v454[v532];
				if (v11:NPCID() == v533) then
					return true;
				end
			end
		end
		return false;
	end;
end
do
	local v383 = {v15(6917 - 4092),v15(5395 + 26787),v15(7656 + 72697),v15(90605 - (172 + 78)),v15(59054 + 101398),v15(72175 + 192492),v15(654057 - 263671),v15(8918 + 26557),v15(12627 + 22849),v15(341449 - 194894),v15(101754 + 76453),v15(40144 + 190791),v15(919085 - 662345),v15(931127 - 621469),v15(382590 - (426 + 863)),v15(445911 - (873 + 781))};
	v9.BloodlustRemains = function(v455, v456)
		local v457 = v455:GUID();
		if not v457 then
			return false;
		end
		for v488 = 1 - 0, #v383 do
			local v489 = v383[v488];
			if v455:BuffUp(v489, true) then
				return v455:BuffRemains(v489, true, v456);
			end
		end
		return 0 - 0;
	end;
	v9.BloodlustUp = function(v458, v459)
		return v458:BloodlustRemains(v459) > (0 + 0);
	end;
	v9.BloodlustDown = function(v460, v461)
		return not v460:BloodlustUp(v461);
	end;
end
v21.HealthPotions = function()
	if ((v10:HealthPercentage() < v23.General.HealthstoneLifePercent) and v10:AffectingCombat() and (v16.Common.HealthStone:IsReady())) then
		if v2.CastMacro(14 - 10, nil, nil, v16.Common.HealthStone) then
			return "Use Healthstone";
		end
	elseif ((v10:HealthPercentage() < v23.General.HealthstoneLifePercent) and v10:AffectingCombat() and (v16.Common.HealthStone2:IsReady())) then
		if v2.CastMacro(14 - 4, nil, nil, v16.Common.HealthStone2) then
			return "Use Demonic Healthstone";
		end
	elseif ((v10:HealthPercentage() < v23.General.HealingPotionLifePercent) and v10:AffectingCombat() and (v16.Common.HealingPotion:IsReady() or v16.Common.HealingPotion2:IsReady() or v16.Common.HealingPotion3:IsReady())) then
		v2.CastMacro(14 - 9, nil, nil, v16.Common.HealingPotion);
		return "Use Heal Potion";
	elseif (v23.General.AutoTargetFocusTarget and (not v12:Exists() or v12:IsDeadOrGhost()) and v9.Focus:Exists() and v9.Focus:UnitIsFriend() and v9.Focus:AffectingCombat()) then
		local v555 = v9("focustarget");
		if (v555:Exists() and v555:AffectingCombat() and v10:CanAttack(v555) and not v555:IsDeadOrGhost()) then
			v2.CastMacro(1954 - (414 + 1533), true);
			return "Auto asssist focus";
		end
	elseif (v23.General.AutoTab and v10:AffectingCombat() and (not v12:Exists() or v12:IsDeadOrGhost()) and (v12:NPCID() ~= (180168 + 27632))) then
		v2.TopPanelAlternative:ChangeIcon(556 - (443 + 112), 1482 - (888 + 591));
		return "Auto tab to target";
	end
end;
v21.PostInitialMessage = function(v387)
	if (v387 == (669 - 410)) then
		v2.Print("Assassination Rogue rotation has been updated for patch 11.1.0. Please report any issues on the discord. Thank you!");
	elseif (v387 == (15 + 237)) then
		v2.Print("Unholy DK rotation has been updated for patch 11.1.0. Please report any issues on the discord. Thank you!");
	elseif (v387 == (248 - 182)) then
		v2.Print("Protection Paladin rotation has been updated for patch 11.1.0. Please report any issues on the discord. Thank you!");
	elseif (v387 == (29 + 44)) then
		v2.Print("Protection Warrior rotation has been updated for patch 11.1.0. Please report any issues on the discord. Thank you!");
	end
end;
