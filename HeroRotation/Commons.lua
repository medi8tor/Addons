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
local v30 = v21.converArrayToList({(426954 - (44 + 386)),(136005 + 292098),(253695 - (201 + 571)),(1116913 - 848635),(963964 - 699914),(254376 - (814 + 45)),(13663 + 239881),(253666 - (261 + 624)),(256121 - (1020 + 60)),(848413 - 598045),(98497 + 151599),(255330 - (760 + 987)),(260338 - (745 + 21)),(688923 - 438555),(2100 + 254749),(201686 - (87 + 968)),(185303 + 18940),(226975 - (447 + 966)),(203216 - (1703 + 114)),(433280 - 168890),(73153 + 182825),(263973 - (9 + 5)),(272439 - (243 + 1022)),(229707 + 48737),(216329 + 49547),(266337 - (1869 + 61)),(937647 - 671422),(57128 + 360353),(392804 + 25396),(412271 - (140 + 831)),(413096 - (15 + 703)),(412671 - (262 + 176)),(408579 - (198 + 490)),(546693 - 318780),(419977 - 219729),(32131 + 167532),(547079 - 382114),(820935 - 655722),(14332 + 155507),(168918 - (660 + 176)),(427661 - (14 + 188)),(30442 + 45280),(73763 + 2957),(677569 - 250786),(221231 + 190763),(416166 - (115 + 281)),(343957 + 71478),(1523324 - 1107887),(601398 - 185142),(1155816 - 742209),(415271 - (970 + 695)),(402170 - (582 + 1408)),(519549 - 106625),(419305 - (1195 + 629)),(412619 - (187 + 54)),(288851 + 123382),(881716 - 468289),(32286 + 380636),(389635 - (451 + 549)),(579537 - 207143),(373699 - (746 + 638)),(574338 - 196056),(397008 - (1535 + 46)),(53862 + 318361),(23783 + 360378),(398392 - (899 + 568)),(901692 - 529077),(372828 - (60 + 230)),(45856 + 336939),(370486 - (569 + 242)),(21141 + 348533),(371074 - (721 + 530)),(923386 - 553783),(370099 - (271 + 429)),(370900 - (1408 + 92)),(378788 - (993 + 295)),(370536 - (418 + 753)),(39396 + 342853),(92877 + 274623),(379719 - (1749 + 20)),(386351 - (1249 + 73)),(374949 - (466 + 679)),(1071265 - 696721),(117909 + 254802),(1103894 - 729997),(382826 - (4 + 110)),(383862 - (41 + 1386)),(259587 + 122887),(1113875 - 729242),(646136 - 272070),(304519 + 69820),(757761 - 383716),(257110 + 116970),(1472350 - 1082907),(1065066 - 669372),(374883 - (53 + 267)),(385554 - (15 + 398)),(1410437 - 1035731),(236506 + 138878),(293463 + 82487),(27874 + 349474),(809039 - 431637),(196937 + 190681),(987365 - 612666),(377722 - (1126 + 425)),(1522221 - 1133829),(1161242 - 764430),(1712032 - 1334643),(397617 - (553 + 424)),(341774 + 46201),(217192 + 155825),(224117 + 168334),(1073595 - 688285),(111721 + 272473),(384950 - (239 + 514)),(386262 - (797 + 532)),(125748 + 247001),(373945 - (373 + 829)),(376726 - (369 + 761)),(682239 - 306637),(387802 - (64 + 174)),(572450 - 185904),(377704 - (42 + 174)),(309755 + 64177),(386312 - (363 + 1141)),(1146880 - 770155),(286892 + 96931),(242065 + 142300),(387948 - (565 + 1368)),(389072 - (1477 + 184)),(361160 + 26453),(668499 - 281059),(373699 - (244 + 60)),(397870 - (41 + 435)),(293426 + 88104),(127562 + 260044),(238454 + 147570),(386279 - (176 + 91)),(570549 - 183424),(436661 - (157 + 1718)),(1543482 - 1108689),(435820 - (697 + 321)),(924396 - 488074),(174478 + 273770),(1163002 - 729161),(442821 - (602 + 9)),(444299 - (826 + 46)),(1401220 - 957790),(445331 - (260 + 1638)),(1419687 - 977151),(934482 - 482320),(447291 - (902 + 303)),(1045584 - 611462),(432993 - (1121 + 569)),(431992 - (483 + 200)),(1233601 - 782845),(451878 - (468 + 297)),(1454880 - 1023547),(784437 - 351917),(451350 - (141 + 95)),(1161126 - 710029),(101027 + 330276),(300941 + 127145),(636704 - 184577),(452969 - (92 + 71)),(716708 - 290425),(370740 + 78715),(219185 + 209925),(429235 - (55 + 71)),(446997 - (573 + 1217)),(32683 + 396862),(430361 - (714 + 225)),(599625 - 169528),(467350 - 144583),(322986 - (25 + 23)),(326662 - (927 + 959)),(325646 - (16 + 716)),(326143 - (11 + 86)),(340829 - (175 + 110)),(1593397 - 1270340),(898802 - 576974),(323511 - (810 + 251)),(102735 + 232013),(320995 - (43 + 490)),(1239125 - 918789),(80875 + 254268),(22732 + 320738),(324698 - (255 + 150)),(179216 + 155532),(1092853 - 754500),(327536 - (183 + 223)),(221800 + 112948),(320508 - (10 + 327)),(322612 - (118 + 220)),(257406 - (108 + 341)),(1086812 - 829749),(528767 - 252941),(147325 + 307115),(810325 - 537744),(9792 + 262779),(1178229 - 726968),(453038 - (645 + 522)),(76332 + 37),(224798 - 148087),(193311 - 116942),(448471 - (351 + 154)),(1214734 - (28 + 238)),(464617 - (1381 + 178)),(373385 + 89676),(4187855 - 2973075),(463241 - (381 + 89)),(319028 + 152705),(426692 - (1074 + 82)),(429803 - (214 + 1570)),(174924 + 249398),(414550 + 11745),(427871 - (1668 + 58)),(1101626 - 679085),(1486426 - 1059250),(79998 + 347358),(1431554 - 1007134),(429052 - (1269 + 200)),(445246 - (98 + 717)),(731924 - 307505),(65681 + 379062),(69589 + 354076),(1262747 - 808838),(162496 + 291822),(374750 + 79569),(206061 + 235290),(2142928 - 1701575),(153020 + 288607),(396119 + 44568),(427586 - (192 + 134)),(190268 + 151634),(305542 + 25020),(331419 - (83 + 468)),(1599673 - 1256998),(946822 - 604853),(330074 + 11903),(97622 + 169732),(49356 + 231248),(271213 - (340 + 1571)),(273351 - (1733 + 39)),(264236 - (125 + 909)),(120533 + 148169),(255301 + 7914),(269033 - (46 + 190)),(84920 + 216168),(294455 - (228 + 498))});
local v31 = v21.converArrayToList({(237103 + 192073),(698745 - 430543),(200869 - (303 + 221)),(196527 + 39311),(929587 - 704025),(563880 - 337917),(578261 - 413296),(666718 - 253112),(226821 - (111 + 1137)),(599416 - 398016),(254106 - (423 + 100)),(1138831 - 727531),(201832 - (326 + 445)),(367338 - 202451),(77524 - (530 + 181)),(76852 - (19 + 13)),(648869 - 370425),(65841 + 187676),(550286 - 284940),(871980 - 444604),(518574 - 247399),(504132 - 290130),(84103 + 328130),(46241 + 153864),(165222 + 99168),(202516 - (673 + 1185)),(1322876 - 910918),(294718 + 117326),(344345 - 89304),(400039 - 199409),(413892 - (446 + 1434)),(1239917 - 824481),(415404 - (609 + 1322)),(1545132 - 1131645),(2054456 - 1641951),(1495009 - 1083365),(180401 + 231299),(225126 + 186281),(272552 + 139710),(296170 + 116030),(403248 + 8908),(766285 - 500914),(104254 + 159784),(246086 + 25089),(402796 - 138271),(257589 - (89 + 578)),(568927 - 295270),(34154 + 219085),(31115 + 229551),(418149 - 164428),(259495 - (497 + 345)),(42716 + 209971),(141914 + 56990),(9170 + 190914),(180562 + 19729),(151270 + 49073),(85001 + 115343),(188743 + 11602),(799637 - 573675),(201935 - (588 + 208)),(202713 - (884 + 916)),(124083 + 89920),(215890 - (1569 + 320)),(32788 + 139790),(173184 - (316 + 289)),(19716 + 407189),(76941 - (360 + 65)),(427638 - (79 + 175)),(295609 + 83209),(716806 - 344605),(372383 - (92 + 89)),(190893 + 181332),(1448396 - 1078543),(842428 - 472963),(176470 + 192996),(47145 + 330587),(375289 - (485 + 759)),(396883 - (442 + 747)),(377117 - (88 + 858)),(311137 + 64813),(389671 - (766 + 23)),(502643 - 135122),(1247253 - 879769),(275019 + 112891),(307525 + 83413),(386449 - (910 + 3)),(214468 - (1466 + 218)),(384841 - (556 + 592)),(398739 - (329 + 479)),(393943 - 279297),(150986 + 60487),(32980 + 339755),(374138 - (135 + 1254)),(1728626 - 1358401),(375459 - (389 + 1138)),(362211 + 21612),(361424 + 26191),(680169 - 298092),(436257 - (157 + 1307)),(1093993 - 655517),(785483 - 343273),(1070819 - 638788),(28192 + 415238),(9708 + 442454),(438004 - (300 + 4)),(1150043 - 710719),(171949 + 259384),(259015 + 193112),(315784 + 106449),(239904 + 83034),(717771 - 395898),(322164 - (627 + 66)),(323152 - (512 + 90)),(335465 - (373 + 344)),(88572 + 246176),(544536 - 222756),(238020 + 89110),(1280 + 319316),(322485 - (233 + 1026)),(163789 + 156569),(95623 + 226271),(257513 - (55 + 166)),(27026 + 241726),(77008 - (36 + 261)),(449381 - (34 + 1334)),(349712 + 100376),(461817 - (20 + 1)),(427661 - (134 + 185)),(428044 - (314 + 371)),(268322 - (478 + 490))});
v21.PurgeList = {(201420 - (786 + 386)),(258228 - (1055 + 324)),(227116 + 28463),(1700542 - 1272213),(755109 - 489741),(131556 + 238267),(1273243 - 903843),(965424 - 587924),(1036096 - 658146),(124884 + 251916),(613215 - 230324),(396962 - (1249 + 19)),(1456055 - 1081989),(296111 + 81291),(1836 + 386119),(4329 + 380734),(373219 - (224 + 246)),(722601 - 330147),(8900 + 365072),(751819 - 373670),(390199 - (203 + 310)),(27046 + 360076),(690629 - 315851),(385550 - (196 + 668)),(800032 - 413809),(386412 - (4 + 89)),(141134 + 246462),(152403 + 236228),(376940 - (28 + 1425)),(413741 + 17752),(643529 - 192773),(432817 - (45 + 252)),(155247 + 295850),(325209 - (114 + 319)),(416342 - 91428),(485762 - 159716),(337104 - (556 + 1407)),(257422 - (170 + 295)),(253355 + 22471)};
v21.SootheList = {(31639 + 6527),(145679 + 111581),(44187 + 121026),(974802 - 718978),(1303106 - 876488),(230098 - (389 + 1391)),(39873 + 343194),(383506 - (783 + 168)),(378463 + 6301),(1135639 - 765833),(126747 + 264191),(262588 + 121105),(69505 + 318109),(1724646 - 1347262),(751042 - 379167),(342075 + 90927),(443340 - (556 + 1139)),(82595 + 368517),(324906 - (28 + 141)),(395861 - 75158),(328472 - (486 + 831)),(1126644 - 806632),(862866 - 589978),(406162 + 45217),(1230011 - 778978)};
v21.DebuffList = {Magic=v21.converArrayToList({(377863 - (1129 + 815)),(146956 - (1326 + 424)),(1552649 - 1127761),(323328 - (720 + 51)),(428510 - (421 + 1355)),(209619 + 217116),(1562350 - 1134968),(465315 - (397 + 42)),(324147 - (24 + 776)),(430330 - (222 + 563)),(316962 + 123276),(451253 - (690 + 1108)),(267491 + 56802),(53547 + 271676),(310842 + 14382),(149471 + 123100),(208943 + 113025),(658401 - 218088),(426615 - (1165 + 561))}),Poison=v21.converArrayToList({(1373277 - 929880),(443880 - (341 + 138)),(900459 - 464137),(1094758 - 754454),(341170 - (581 + 300)),(808258 - 467970),(439853 - (1030 + 205)),(402086 + 30141),(740944 - 414852),(564941 - 289106),(160848 + 114988),(122785 + 311352),(462793 - (671 + 492)),(341498 - (369 + 846)),(382533 + 65715),(366918 + 94569),(434044 - (11 + 192))}),Disease=v21.converArrayToList({(338528 - (135 + 40)),(164306 + 108282),(480606 - 160010),(1265406 - 810966),(323234 - (1233 + 180)),(441734 - (107 + 1314))}),Curse=v21.converArrayToList({(783623 - 526455),(846568 - 420260),(324878 - (716 + 1194)),(46200 + 385109),(870452 - 419228),(1030313 - 580218),(1357466 - 917153)}),RootDispel=v21.converArrayToList({(414039 - (279 + 154)),(329024 + 89176),(137508 + 117533)}),FreedomDispel=v21.converArrayToList({(141380 + 241213),(1572843 - 1204762),(69515 + 301251),(1656311 - 1270283),(89599 + 285992),(444108 - (41 + 1857)),(1120832 - 687170),(434963 - (229 + 953)),(435364 - (874 + 705)),(296162 + 137921),(12573 + 434145),(101107 + 342323),(1113356 - 669929),(1044908 - 593037),(432850 - (718 + 823)),(427540 - (266 + 539)),(432719 - (636 + 589)),(930420 - 479316),(159771 + 280009),(760690 - 473395),(466063 - (1151 + 36)),(112566 + 315595),(442070 - (1552 + 280)),(305869 + 144636),(77920 + 360940)}),SnareRoot=v21.converArrayToList({(827879 - 414273),(252930 - 88045),(165705 - (599 + 220)),(428431 - (1813 + 118)),(419417 - (841 + 376)),(94799 + 313285),(255900 - (464 + 395))}),Entangled=v21.converArrayToList({(196204 + 212352)}),Bleed=v21.converArrayToList({(891690 - 460199),(1107394 - 784351),(597252 - 340543),(439881 - (74 + 1208)),(1541281 - 1216294),(322197 - (14 + 376)),(289408 + 157853),(305378 + 14822),(331089 + 109018),(1043521 - 603208)}),Raid=v21.converArrayToList({(375191 + 42616),(118250 + 257669)})};
v21.AfflictedDispelList = {(1095790 - 686325),(1111480 - 702010),(409499 - (10 + 17))};
v21.TankBustersList2 = v21.converArrayToList({(386329 - (1400 + 332)),(374638 - (242 + 1666)),(141092 + 243886),(396232 - (850 + 90)),(375923 - (360 + 1030)),(1057852 - 683063),(379005 - (909 + 752)),(688279 - 312342),(377239 - (6 + 236)),(313043 + 75868),(686319 - 293395),(62161 + 315830),(30122 + 351390),(106750 + 94389),(630533 - 404801),(87788 + 109630),(190916 + 23087),(630814 - 426203),(467046 - 268667),(97663 + 107004),(136354 + 54972),(410976 - (478 + 244)),(190082 + 227977),(414569 - (655 + 901)),(309991 + 94925),(1665957 - 1252428),(1390335 - 983176),(1069306 - 803425),(619514 - 353754),(68888 + 358488),(178890 + 248780),(255848 - (239 + 30)),(398428 + 16107),(1293527 - 878923),(1446727 - 1032144),(246185 + 155063),(478656 - 311271),(279115 + 159484),(111977 + 324345),(156343 + 276659),(191092 + 242693),(411145 + 27326),(40370 + 403027),(453639 - (1309 + 179)),(196402 + 254836),(328363 + 106359),(877691 - 437223),(1083920 - 642622),(1450260 - 988418),(233728 + 216327),(441051 - (851 + 554)),(1196688 - 765195),(431793 - (115 + 187)),(427062 + 24051),(432798 - (160 + 1001)),(311262 + 139855),(452860 - (237 + 121)),(811601 - 383515),(453354 - (96 + 46)),(154145 + 272856),(1586749 - 1159367),(831659 - 407893),(459929 - (316 + 403)),(1179191 - 750297),(1081439 - 652017),(136934 + 287954),(2047458 - 1618747),(24171 + 398062),(15756 + 306813),(322574 - (12 + 5)),(988327 - 525110),(843680 - 503472),(342262 - (1656 + 317)),(257893 + 63935),(1578317 - 1257621),(1522145 - 1201683),(212061 + 109746),(421905 - 101443),(422646 - 98323),(325460 - (507 + 559)),(1046434 - 708077),(339361 - (250 + 655)),(560370 - 239674),(340592 - (1869 + 87)),(322556 - (484 + 1417)),(560571 - 226083),(524012 - 203241),(149136 + 107480),(71843 + 184866),(258021 - (152 + 701)),(102723 + 165507),(80570 + 192018),(965916 - 690081),(604283 - 323894),(452230 - (39 + 827)),(1008098 - 556720),(693915 - 241944),(1320726 - 869485),(707745 - 260484),(449998 - (475 + 79)),(1439024 - 989337),(394243 + 53723),(1309791 - 859691)});
v21.TankBustersMagicList = {(167689 + 216908),(395611 - (27 + 292)),(477629 - 103096),(774872 - 381948),(378130 - (43 + 96)),(862554 - 481042),(57791 + 146876),(73327 + 117999),(130188 + 283341),(408910 - (1414 + 337)),(693113 - 427232),(788663 - 522903),(332518 + 94858),(143628 + 60983),(226528 + 37850),(133875 + 33510),(274253 + 162069),(435419 - (128 + 569)),(443185 - (687 + 1200)),(1624791 - 1162949),(450476 - (275 + 146)),(439710 - (29 + 35)),(1288839 - 857346),(293822 + 157291),(432045 - (312 + 96)),(452787 - (147 + 138)),(386851 + 41235),(453704 - (18 + 474)),(1498806 - 1039596),(429725 - (121 + 182)),(429951 - (988 + 252)),(101038 + 221531),(323447 - (223 + 667)),(797281 - 334064),(341414 - (146 + 979)),(322433 - (311 + 294)),(135744 + 184718),(321820 - (1233 + 125)),(230725 + 26443),(274233 - (963 + 682)),(453475 - (504 + 1000)),(410933 + 40308),(660584 - 212618),(261760 + 188340)};
v21.TankBustersPhysicalList = {(214724 + 158006),(385142 - (149 + 15)),(374906 - (39 + 78)),(829786 - 452442),(193966 + 181971),(80090 + 296907),(101890 + 287021),(198795 + 2344),(5698 + 220034),(183665 + 13753),(762186 - 548183),(107702 + 96909),(132132 + 66247),(411964 - (1596 + 114)),(418772 - (164 + 549)),(512852 - 99839),(68257 + 336659),(350920 + 76750),(757729 - 502150),(357071 + 57464),(401968 - (254 + 466)),(524018 - 359133),(255687 - (236 + 17)),(324376 + 92340),(1252544 - 987988),(339366 + 72678),(11185 + 254575),(434802 - 267417),(747298 - 308699),(433366 - (326 + 38)),(619260 - 185475),(154562 + 283909),(719657 - 276260),(452643 - (76 + 416)),(1031488 - 580250),(1219406 - 778938),(1264301 - 832810),(453028 - (1261 + 650)),(680516 - 253515),(60287 + 367095),(425610 - (1524 + 320)),(429050 - (18 + 138)),(425990 - (67 + 1035)),(1794238 - 1372005),(313622 + 26586),(321778 - (1050 + 32)),(190352 + 131455),(26172 + 298151),(325119 - (267 + 458)),(650683 - 312326),(339953 - (1410 + 87)),(866855 - 546159),(339432 - (461 + 335)),(322416 - (1730 + 31)),(1184643 - 850155),(734967 - 414196),(234501 + 22115),(220008 + 36701),(269996 - (459 + 1307)),(481673 - 205838),(916 + 279473),(57191 + 394173),(1968531 - 1517153),(381303 + 65958),(355714 + 93730),(450325 - (448 + 190)),(203175 + 246925)};
v21.NPCAlwaysInCombat = v21.converArrayToList({(831188 - 615003),(215937 - (1307 + 187)),(537985 - 308216),(230422 - (232 + 451)),(173039 + 22842),(454217 - 228774),(416541 - 202857),(402160 - 180816),(477076 - 341835),(187182 + 32820),(825793 - 601917),(224318 - (237 + 4)),(592096 - 358072),(180478 + 40023),(829506 - 609792),(117397 + 98429)});
v21.NPCAlwaysInCombatBossFight = v21.converArrayToList({(209827 - 86859),(98914 - (45 + 327)),(187240 - (444 + 58)),(32108 + 154508),(569403 - 372921),(188089 - (1227 + 746)),(352098 - 162379),(5751 + 218028),(94192 + 125686),(107255 + 108571)});
v21.Buggedmobs = v21.converArrayToList({(592301 - 374812),(217809 - (200 + 118)),(382704 - 163820),(194028 + 24342),(119757 + 103393),(484601 - 260927),(391793 - 167425),(34456 + 188748),(152596 + 70722),(63460 + 157884),(349524 - 129023),(220583 - (289 + 548)),(222118 - (195 + 60))});
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
			v142 = 1 + 0;
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
				v142 = v142 + (130 - (118 + 11));
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
local v42 = v7.Persistent.Player.Class[1 + 2];
local v43 = v28[v42];
local v44 = v7.Persistent.Player.Spec[1 + 0];
local v45 = v27[v44];
v20.ClassUpdate = function()
	v42 = v7.Persistent.Player.Class[8 - 5];
	v43 = v28[v42];
	v44 = v7.Persistent.Player.Spec[950 - (551 + 398)];
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
	local v168 = UnitGetIncomingHeals(v167.UnitID) or (0 + 0);
	local v169 = v167:MaxHealth();
	if (v168 == (0 - 0)) then
		return 0 + 0;
	end
	if (v169 <= (89 - (40 + 49))) then
		return 0 - 0;
	end
	local v170 = (v168 / v169) * (590 - (99 + 391));
	return math.ceil(v170);
end;
v9.HealthPercentageWeighted = function(v171)
	GUID = v171:GUID();
	if not GUID then
		return 83 + 17;
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
	return ((v180 >= (0 - 0)) and v180) or (2473 - 1474);
end;
v21.num = function(v181)
	if v181 then
		return 1 + 0;
	else
		return 0 - 0;
	end
end;
v21.bool = function(v182)
	return v182 ~= (1604 - (1032 + 572));
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
local v72 = v15(228735 - (203 + 214));
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
	local v194 = v15(63121 - (568 + 1249));
	v10.GCDDuration = function(v398)
		local v399, v399, v399, v400 = v194:CooldownInfo();
		return v400;
	end;
	v15.CooldownWithoutGCD = function(v401)
		local v402, v403, v402, v404 = v401:CooldownInfo();
		if (v403 == (0 + 0)) then
			return 0 - 0;
		end
		local v405 = ((v403 + v404) - GetTime()) - v10:GCDDuration();
		v405 = ((v405 > (0 - 0)) and v405) or (1306 - (913 + 393));
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
	if ((v223:NPCID() == (289047 - 84487)) and (v223:CastSpellID() == (409215 - (269 + 141)))) then
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
	if (v12:Exists() and (v12:NPCID() == (455449 - 250676)) and v12:IsSpellInRange(v230)) then
		v4(v230, v231);
		return "afflicted";
	end
	if (v14:Exists() and (v14:NPCID() == (206754 - (362 + 1619))) and v14:IsSpellInRange(v230)) then
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
local v86 = v15(4450 - (950 + 675));
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
					if (v258 == (1179 - (216 + 963))) then
						v258 = math.random(1287.4 - (485 + 802), 559.9 - (432 + 127));
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
	local v266 = 1073 - (1065 + 8);
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
					if (v266 == (0 + 0)) then
						v266 = math.random(1601.4 - (635 + 966), 0.9 + 0);
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
local v90 = v15(320830 - (5 + 37));
local v91 = v15(683989 - 408975);
local v92 = v15(186633 + 261928);
local v93 = v15(701891 - 258454);
local v94 = v15(202347 + 230101);
local v95 = v15(958953 - 497466);
local v96 = v15(1610869 - 1185980);
v21.DispelCycle = function(v267, v268, v269, v270)
	local v271 = v21.DebuffList[v268];
	local function v272(v410)
		if (v268 == "Magic") then
			if (v410:DebuffUp(v90, true) and (v410:DebuffElapsed(v90, true) >= (5.25 - 2))) then
				return true;
			end
			if (v410:DebuffUp(v91, true) and (v410:DebuffElapsed(v91, true) >= (7 - 4))) then
				return true;
			end
			if (v410:DebuffUp(v92, true) and (v410:DebuffElapsed(v92, true) >= (3 + 0))) then
				return true;
			end
			if (v410:DebuffUp(v93, true) and (v410:DebuffElapsed(v93, true) >= (532 - (318 + 211)))) then
				return true;
			end
			if (v410:DebuffUp(v94, true) and (v410:DebuffElapsed(v94, true) >= (14 - 11))) then
				return true;
			end
			if (v410:DebuffUp(v96, true) and (v410:DebuffRemains(v96, true) <= (1595 - (963 + 624)))) then
				return true;
			end
		elseif (v268 == "Disease") then
			if (v410:DebuffUp(v90, true) and (v410:DebuffElapsed(v90, true) >= (2.25 + 1))) then
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
local v99 = v15(444458 - (518 + 328));
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
local v102 = {[1031049 - 588764]=(0.3 - 0),[451541 - (301 + 16)]=(0.3 - 0),[900025 - 579563]=(0.4 - 0),[401540 + 41765]=(0.3 + 0),[972279 - 516875]=(0.3 + 0),[40613 + 386123]=(0.3 - 0),[145270 + 304825]=(1019.3 - (829 + 190)),[1578568 - 1136131]=(0.3 - 0),[612791 - 169517]=(0.3 - 0),[104908 + 337752]=(0.3 + 0),[978847 - 656361]=(0.8 + 0),[426921 - (520 + 93)]=(276.8 - (259 + 17)),[25873 + 423281]=(0.8 + 0),[1460197 - 1028888]=(591.8 - (396 + 195)),[1254675 - 822227]=(1761.8 - (440 + 1321)),[433179 - (1059 + 770)]=(0.8 - 0),[443975 - (424 + 121)]=(0.8 + 0),[444780 - (641 + 706)]=(0.8 + 0),[443877 - (249 + 191)]=(0.8 - 0),[200328 + 248233]=(0.8 - 0),[440534 - (183 + 244)]=(0.8 + 0),[434470 - (434 + 296)]=(0.8 - 0),[335260 - (169 + 343)]=(0.8 + 0),[563416 - 243216]=(0.8 - 0),[223303 + 49268]=(0.8 - 0),[274593 - (651 + 472)]=(0.8 + 0),[118659 + 156355]=(0.8 - 0),[440796 - (397 + 86)]=(876.6 - (423 + 453))};
local v103 = v15(10404 + 91938);
local v104 = v15(4377 + 28829);
local v105 = v15(41722 + 6066);
local v106 = v15(5539 + 1401);
v21.CalculateWeight = function(v282)
	local v283 = 1 + 0;
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
	if (v283 > (1190.3 - (50 + 1140))) then
		local v479 = (1 + 0) * (((v282:BuffUp(v103, true) or v282:BuffUp(v106, true) or v282:BuffUp(v104, true)) and (1.1 + 0)) or (1 + 0));
		v479 = v479 * ((v282:BuffUp(v105, true) and (1.3 - 0)) or (1 + 0));
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
			if ((not v412:ClassID() == (602 - (157 + 439))) and (v412:HealthPercentage() >= (112 - 47))) then
				v413 = v413 * (3.9 - 2);
			elseif (v412:PowerPercentage() > (59 - 39)) then
				v413 = v413 * (919.2 - (782 + 136));
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
	local v291 = 855 - (112 + 743);
	local v292 = #v290;
	if (v292 == (1171 - (1026 + 145))) then
		return 18 + 82;
	end
	for v414, v415 in v17(v290) do
		v291 = v291 + v415:HealthPercentage();
	end
	return v291 / v292;
end;
v21.BuffCount = function(v293, v294)
	local v295 = 718 - (493 + 225);
	for v416, v417 in v17(v293) do
		if v417:BuffUp(v294, nil, true) then
			v295 = v295 + (3 - 2);
		end
	end
	return v295;
end;
v21.DebuffCount = function(v296, v297)
	local v298 = 0 + 0;
	for v418, v419 in v17(v296) do
		if v419:DebuffUp(v297, true) then
			v298 = v298 + (2 - 1);
		end
	end
	return v298;
end;
v21.DebuffCountWithStacks = function(v299, v300, v301)
	local v302 = 0 + 0;
	for v420, v421 in v17(v299) do
		if (v421:DebuffUp(v300, true) and (v421:DebuffStack(v300, true) >= v301)) then
			v302 = v302 + (2 - 1);
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
	local v337 = 0 + 0;
	for v436, v437 in v17(v336) do
		v337 = ((v437:HealthPercentageWeighted() < v333) and (v337 + (1 - 0))) or v337;
	end
	return (((v337 >= v334) or (v337 >= #v336)) and ((v335 == nil) or (v335 == "With Logic") or ((v335 == "With Cooldowns and Logic") and v2.CDsON()))) or ((v335 == "With Cooldowns") and v2.CDsON());
end;
v21.AoELogicWithCountUnweighted = function(v338, v339, v340, v341)
	local v342 = 1595 - (210 + 1385);
	for v438, v439 in v17(v341) do
		v342 = ((v439:HealthPercentage() < v338) and (v342 + (1690 - (1201 + 488)))) or v342;
	end
	return (((v342 >= v339) or (v342 >= #v341)) and ((v340 == nil) or (v340 == "With Logic") or ((v340 == "With Cooldowns and Logic") and v2.CDsON()))) or ((v340 == "With Cooldowns") and v2.CDsON());
end;
v21.AoELogic = function(v343, v344, v345)
	local v346 = v21.GetAverageGroupHealthPercent(v345);
	return ((v346 <= v343) and ((v344 == nil) or (v344 == "With Logic") or ((v344 == "With Cooldowns and Logic") and v2.CDsON()))) or ((v344 == "With Cooldowns") and v2.CDsON());
end;
v21.GroupBuffMissing = function(v347, v348)
	local v349 = 25 + 15;
	local v350 = {[1 - 0]=(684679 - 302921),[587 - (352 + 233)]=(922597 - 540845),[2 + 1]=(1085390 - 703641),[578 - (489 + 85)]=(383255 - (277 + 1224)),[1498 - (663 + 830)]=(335318 + 46435),[14 - 8]=(382607 - (461 + 414)),[2 + 5]=(152740 + 229016),[1 + 7]=(376340 + 5410),[259 - (172 + 78)]=(615562 - 233805),[4 + 6]=(550888 - 169137),[3 + 8]=(127507 + 254239),[19 - 7]=(480531 - 98790),[4 + 9]=(211101 + 170647)};
	if (v347:ID() == (2376 + 4297)) then
		v349 = 398 - 298;
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
	local v352 = 0 - 0;
	local v353 = 0 + 0;
	for v440, v441 in v17(v351) do
		if (v441:Exists() and not v441:IsDeadOrGhost() and (v348 or (v441:IsSpellInRange(v347) and not (v10:IsInDelve() and (v441:Name() == "Brann Bronzebeard"))))) then
			v352 = v352 + 1 + 0;
			if (v347:ID() == (382195 - (133 + 314))) then
				local v544, v544, v545 = v441:Class();
				if v441:BuffUp(v15(v350[v545]), true) then
					v353 = v353 + 1 + 0;
				end
			elseif v441:BuffDown(v347, true) then
				return true;
			end
		end
	end
	if ((v347:ID() == (381961 - (199 + 14))) and (v353 < v352)) then
		return true;
	end
	return false;
end;
local v124 = v21.converArrayToList({(387107 - (647 + 902)),(377237 - (85 + 148)),(1785546 - 1404030),(224135 - 56750),(159250 + 225115)});
do
	v21.stopCastRemains = 0 - 0;
	v21.ShouldStopCastUpdate = function()
		local v442 = v10:GetEnemiesInRange(57 - 17);
		for v481, v482 in v17(v442) do
			if v124[v482:CastSpellID()] then
				v21.stopCastRemains = v482:CastRemains() - (0.1 - 0);
				return v482:CastRemains() <= (v10:CastRemains() + (1947.1 - (414 + 1533)));
			end
		end
		v21.stopCastRemains = 0 + 0;
		return false;
	end;
	v21.ShouldStopCast = function(v444)
		return (v21.stopCastRemains == (555 - (443 + 112))) or (v444:ExecuteTime() < v21.stopCastRemains);
	end;
	v15.IsCastable = function(v445, v446)
		return v445:IsLearned() and v445:CooldownUp(v446) and ((v21.stopCastRemains == (1479 - (888 + 591))) or (v445:ExecuteTime() < v21.stopCastRemains));
	end;
	v15.IsReady2 = function(v447)
		return v447:IsCastable2() and v447:IsUsableP();
	end;
end
v21.GetCurrentEmpowerData = function(v359)
	local v360 = 0 - 0;
	local v361 = {};
	_, _, _, StartTimeMS, EndTimeMS, _, _, _, _, StageTotal = UnitChannelInfo("player");
	if (StageTotal and (StageTotal > (0 + 0))) then
		local v483 = 0 - 0;
		for v510 = 1 + 0, StageTotal do
			v361[v510] = {Start=v483,Finish=(v483 + (GetUnitEmpowerStageDuration("player", v510 - (1 + 0)) / (107 + 893)))};
			v2.Print(" Start" .. v510 .. ": " .. v361[v510].Start);
			v2.Print("Finish" .. v510 .. ": " .. v361[v510].Finish);
			v483 = v361[v510].Finish;
			if (((StartTimeMS / (1905 - 905)) + v483) <= GetTime()) then
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
	local v368, v369, v369, v369, v369, v369, v369, v369, v370 = select(6 - 2, ...);
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
				if ((v9.Nameplate[v553]:CastRemains() > (1678 - (136 + 1542))) and (v9.Nameplate[v553]:CastRemains() < (3 - 2))) then
					return v450;
				end
			end
		end
	end
end;
v21.PotionSelected = function()
	local v376 = v23.APL[v43][v45].PotionType.Selected;
	local v377 = v23.APL[v43][v45].PotionRank and v23.APL[v43][v45].PotionRank.Selected;
	local v378 = {(337530 - 125265),(212750 - (68 + 418)),(385128 - 172865)};
	local v379 = {(1095 - (770 + 322)),(1 + 1),(1 - 0)};
	local v380 = "";
	if (v376 == "Tempered Potion") then
		for v515, v516 in ipairs(v378) do
			local v517 = v379[((v515 - (1 - 0)) % #v379) + (2 - 1)];
			if ((not v377 or (tostring(v517) == v377) or (v377 == "Any")) and v16(v516):IsUsable()) then
				return v16(v516);
			end
		end
	else
		return nil;
	end
end;
do
	local v381 = {Spells={v15(210108 + 167114),v15(157549 + 170880),v15(271791 + 75044),v15(260880 - 73061),v15(835359 - 654014),v15(64596 + 92463),v15(205442 - (762 + 69))},PetMounts={(100631 + 16171),(210627 - 123545),(1385 + 85693),(87238 - (8 + 149)),(147354 - 60274),(35853 + 51226),(202053 - 114977)}};
	v10.IsInWhitelistedVehicle = function(v452)
		local v453 = v381.Spells;
		for v486 = 1 + 0, #v453 do
			local v487 = v453[v486];
			if v452:DebuffUp(v487, true, true) then
				return true;
			end
		end
		local v454 = v381.PetMounts;
		if v11:IsActive() then
			for v532 = 1808 - (518 + 1289), #v454 do
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
	local v383 = {v15(375 + 2450),v15(23703 + 8479),v15(75856 + 4497),v15(92324 - (1618 + 351)),v15(161468 - (10 + 1006)),v15(37062 + 227605),v15(391419 - (912 + 121)),v15(36764 - (1140 + 149)),v15(47286 - 11810),v15(501565 - 355010),v15(30741 + 147466),v15(231121 - (165 + 21)),v15(105756 + 150984),v15(623995 - 314337),v15(382761 - (1295 + 165)),v15(178623 + 265634)};
	v9.BloodlustRemains = function(v455, v456)
		local v457 = v455:GUID();
		if not v457 then
			return false;
		end
		for v488 = 1398 - (819 + 578), #v383 do
			local v489 = v383[v488];
			if v455:BuffUp(v489, true) then
				return v455:BuffRemains(v489, true, v456);
			end
		end
		return 1402 - (331 + 1071);
	end;
	v9.BloodlustUp = function(v458, v459)
		return v458:BloodlustRemains(v459) > (743 - (588 + 155));
	end;
	v9.BloodlustDown = function(v460, v461)
		return not v460:BloodlustUp(v461);
	end;
end
v21.HealthPotions = function()
	if ((v10:HealthPercentage() < v23.General.HealthstoneLifePercent) and v10:AffectingCombat() and (v16.Common.HealthStone:IsReady())) then
		if v2.CastMacro(1286 - (546 + 736), nil, nil, v16.Common.HealthStone) then
			return "Use Healthstone";
		end
	elseif ((v10:HealthPercentage() < v23.General.HealthstoneLifePercent) and v10:AffectingCombat() and (v16.Common.HealthStone2:IsReady())) then
		if v2.CastMacro(1947 - (1834 + 103), nil, nil, v16.Common.HealthStone2) then
			return "Use Demonic Healthstone";
		end
	elseif ((v10:HealthPercentage() < v23.General.HealingPotionLifePercent) and v10:AffectingCombat() and (v16.Common.HealingPotion:IsReady() or v16.Common.HealingPotion2:IsReady() or v16.Common.HealingPotion3:IsReady())) then
		v2.CastMacro(4 + 1, nil, nil, v16.Common.HealingPotion);
		return "Use Heal Potion";
	elseif (v23.General.AutoTargetFocusTarget and (not v12:Exists() or v12:IsDeadOrGhost()) and v9.Focus:Exists() and v9.Focus:UnitIsFriend() and v9.Focus:AffectingCombat()) then
		local v555 = v9("focustarget");
		if (v555:Exists() and v555:AffectingCombat() and v10:CanAttack(v555) and not v555:IsDeadOrGhost()) then
			v2.CastMacro(20 - 13, true);
			return "Auto asssist focus";
		end
	elseif (v23.General.AutoTab and v10:AffectingCombat() and (not v12:Exists() or v12:IsDeadOrGhost()) and (v12:NPCID() ~= (209566 - (1536 + 230)))) then
		v2.TopPanelAlternative:ChangeIcon(492 - (128 + 363), 1 + 2);
		return "Auto tab to target";
	end
end;
v21.PostInitialMessage = function(v387)
	if (v387 == (643 - 384)) then
		v2.Print("Assassination Rogue rotation has been updated for patch 11.1.0. Please report any issues on the discord. Thank you!");
	elseif (v387 == (66 + 186)) then
		v2.Print("Unholy DK rotation has been updated for patch 11.1.0. Please report any issues on the discord. Thank you!");
	elseif (v387 == (108 - 42)) then
		v2.Print("Protection Paladin rotation has been updated for patch 11.1.0. Please report any issues on the discord. Thank you!");
	elseif (v387 == (214 - 141)) then
		v2.Print("Protection Warrior rotation has been updated for patch 11.1.0. Please report any issues on the discord. Thank you!");
	end
end;
