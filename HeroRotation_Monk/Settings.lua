local v0, v1 = ...;
local v2 = HeroRotation();
local v3 = HeroLib;
local v4 = v3.GUI;
local v5 = v4.CreateChildPanel;
local v6 = v4.CreatePanelOption;
local v7 = v2.HRGUIGet().CreateARPanelOption;
local v8 = v2.HRGUIGet().CreateARPanelOptions;
local v9 = v2.GUISettingsGet();
v9.APL.Monk = {Commons={Enabled={Trinkets=true,Potions=true,Items=true}},Brewmaster={OnlyAttackEnnemyInCombat=true,OnlyAttackEnnemyInCombatSolo=false,ExpelHarmHP=(218 - 148),PotionType={Selected="Power"},PotionRank={Selected="Any"},PotionWithLust=false,LegSweepInt=false,ParaInt=false,AutoTabforInc=false,AutoTabMelee=false,VivVivHP=(114 - 74),TTD={WhiterTigerStatue=(57 - 27),Niuzao=(77 - 47),ExplodingKeg=(629 - (555 + 64)),Bonedust=(941 - (857 + 74)),Trinket=(588 - (367 + 201))},Enabled={TouchofDeath=true}},Brewmaster_Interrupt={Interrupt={AutoInterrupt=true,AutoStun=true,AutoTargetInterrupt=true,AutoTargetStun=true,InterruptEverythingSolo=true,InterruptEverythingRaid=true,InterruptInDungeon="Whitelist",InterruptInDungeonUseStunAsInterrupt=true,InterruptPercent=(987 - (214 + 713)),InterruptPercentChannel=(16 + 44)}},Windwalker={ShowFortifyingBrewCD=false,IgnoreToK=false,FortifyingBrewHP=(7 + 33),DampenHarmHP=(917 - (282 + 595)),DiffuseMagicHP=(1677 - (1523 + 114)),VivVivHP=(36 + 4),TestRotation=false,LegSweepInt=false,ParaInt=false,AutoTabMelee=false,OutofCombat=false,AutoTabMoTC=false,Trinket1Usage=true,Trinket2Usage=true,PotionType={Selected="Power"},PotionRank={Selected="Any"},Cooldowns={Mobcount=(6 - 1),InvokeXuen="With Cooldowns",SEF="With Cooldowns",Racials="With Cooldowns",Strike="With Cooldowns",Conduit="With Cooldowns",ConduitTTD=(1080 - (68 + 997)),SEFTTD=(1285 - (226 + 1044)),RacialsTTD=(65 - 50),InvokeXuenTTD=(132 - (32 + 85)),StrikeTTD=(15 + 0)}},Windwalker_Interrupt={Interrupt={AutoInterrupt=true,AutoStun=true,AutoTargetInterrupt=true,AutoTargetStun=true,InterruptEverythingSolo=true,InterruptEverythingRaid=true,InterruptInDungeon="Whitelist",InterruptInDungeonUseStunAsInterrupt=true,InterruptPercent=(14 + 46),InterruptPercentChannel=(1017 - (892 + 65))}},Mistweaver={DampenHarmHP=(143 - 83),ExpelHarmHP=(92 - 42),FortifyingBrewHP=(73 - 33),DiffuseMagicHP=(385 - (87 + 263)),ManaTeaMP=(245 - (67 + 113)),ManaTeaStack=(4 + 1),ManaTeaOOC=false,LegSweepInt=false,ParaInt=false,AutoTabMelee=false,PotionType={Selected="Power"},PotionRank={Selected="Any"},Soothing={SoothingMistHP=(36 - 21),SoothingMistAtRange=(34 + 11)},RaidSoothing={SoothingMistHP=(278 - 208),SoothingMistAtRange=(1022 - (802 + 150))},Healing={EnvMistHP=(148 - 93),EnvMistTFTHPOnPlayer=(81 - 36),VivifyHP=(26 + 9),VivVivifyHP=(1072 - (915 + 82)),RenewingMistHP=(268 - 173),RenewingMistOOC=(59 + 41),LCHP=(29 - 6)},AoE={SGHP=(1252 - (1069 + 118)),RJWHP=(124 - 69),RevivalHP=(43 - 23),YulonHP=(8 + 37),ChijiHP=(79 - 34),FSHP=(55 + 0),CCHP=(876 - (368 + 423)),SGCount=(9 - 6),RJWCount=(21 - (10 + 8)),RevivalCount=(11 - 8),YulonCount=(445 - (416 + 26)),ChijiCount=(9 - 6),FSCount=(1 + 1),CCCount=(6 - 2)},RaidHealing={EnvMistHP=(493 - (145 + 293)),EnvMistTFTHPOnPlayer=(475 - (44 + 386)),VivifyHP=(1521 - (998 + 488)),VivVivifyHP=(24 + 51),RenewingMistHP=(78 + 17),RenewingMistOOC=(872 - (201 + 571)),LCHP=(1161 - (116 + 1022))},RaidAoE={SGHP=(270 - 205),RJWHP=(33 + 22),RevivalHP=(73 - 53),YulonHP=(159 - 114),ChijiHP=(904 - (814 + 45)),FSHP=(135 - 80),CCHP=(5 + 80),SGCount=(2 + 2),RJWCount=(890 - (261 + 624)),RevivalCount=(13 - 5),YulonCount=(1085 - (1020 + 60)),ChijiCount=(1428 - (630 + 793)),FSCount=(16 - 11),CCCount=(28 - 22)},Cooldowns={UseRJW="With Logic",UseRevival="With Logic",UseYulon="With Logic",UseSG="With Logic",UseChiji="With Logic",UseFae="With Logic",YulonEnVCount=(2 + 3),SGStack=(17 - 12),FSMoving=true,FSCursorBusy=true,UseEFAT=false,VivYulonHP=(1792 - (760 + 987)),Trinket1Use="With Logic",Trinket2Use="With Logic",Trinket1HP=(1978 - (1789 + 124)),Trinket2HP=(831 - (745 + 21)),EscapeHP=(16 + 29)}},Mistweaver_Interrupt={Interrupt={AutoInterrupt=true,AutoStun=true,AutoTargetInterrupt=true,AutoTargetStun=true,InterruptEverythingSolo=true,InterruptEverythingRaid=true,InterruptInDungeon="Whitelist",InterruptInDungeonUseStunAsInterrupt=true,InterruptPercent=(165 - 105),InterruptPercentChannel=(235 - 175)}}};
v2.HRGUIGet().LoadSettingsRecursively(v9);
local v11 = v2.HRGUIGet().Panel;
local v12 = v5(v11, "Monk");
local v13 = v5(v12, "Windwalker");
local v14 = v5(v12, "Brewmaster");
local v15 = v5(v12, "TTD");
local v16 = v5(v12, "Mistweaver");
local v17 = v5(v16, "Healing");
local v18 = v5(v16, "AoE Healing");
local v19 = v5(v16, "Soothing");
local v20 = v5(v16, "Cooldowns");
local v21 = {"With Cooldowns","With Logic","With Cooldowns and Logic","Not Used"};
local v22 = v5(v16, "Raid Healing");
local v23 = v5(v16, "Raid AoE Healing");
local v24 = v5(v16, "Raid Soothing");
local v25 = v5(v16, "Interrupt");
v8(v25, "APL.Monk.Mistweaver_Interrupt");
local v26 = v5(v13, "Cooldowns");
local v27 = v5(v13, "Interrupt");
v8(v27, "APL.Monk.Windwalker_Interrupt");
local v28 = v5(v14, "Interrupt");
v8(v28, "APL.Monk.Brewmaster_Interrupt");
local v29 = {"Not Used","Always","With Cooldowns","With Small or Cooldowns","On Mobcount","On Mobcount or Cooldowns","On Bosses","Mobcount or Boss"};
v8(v12, "APL.Monk.Commons");
v8(v13, "APL.Monk.Windwalker");
v6("Slider", v13, "APL.Monk.Windwalker.FortifyingBrewHP", {(2 - 1),(476 - (85 + 291)),(3 - 2)}, "Fortifying Brew HP Threshold", "Set the HP threshold for when to suggest Fortifying Brew.");
v6("Slider", v13, "APL.Monk.Windwalker.DiffuseMagicHP", {(1180 - (1123 + 57)),(354 - (163 + 91)),(1 + 0)}, "Diffuse Magic HP Threshold", "Set the HP threshold to Cast.");
v6("Slider", v13, "APL.Monk.Windwalker.DampenHarmHP", {(0 - 0),(137 - 37),(1475 - (1329 + 145))}, "Dampen Harm HP Threshold", "Set the HP threshold for when to suggest Dampen Harm.");
v6("Slider", v13, "APL.Monk.Windwalker.VivVivHP", {(1850 - (1409 + 441)),(47 + 53),(1722 - (345 + 1376))}, "Vivify with Viv Buff HP Threshold", "Set the HP threshold for self heals.");
v6("CheckButton", v27, "APL.Monk.Windwalker.LegSweepInt", "Use Legsweep as Second interrupt?", "Use as another interrupt.");
v6("CheckButton", v27, "APL.Monk.Windwalker.ParaInt", "Use Paralysis as Second interrupt", "Use as another interrupt.");
v6("CheckButton", v13, "APL.Monk.Windwalker.AutoTabMelee", "Auto Tab Melee", "Auto Tab to always a target in melee.");
v6("CheckButton", v13, "APL.Monk.Windwalker.OutofCombat", "Attack OOC", "Start Rotation when not in combat?");
v6("CheckButton", v13, "APL.Monk.Windwalker.AutoTabMoTC", "Auto Tab For MoTC", "Auto Tab to Spread MoTC.");
v6("CheckButton", v13, "APL.Monk.Windwalker.Trinket1Usage", "Use Trinket 1", "Use Trinket if Items are enabled. IF Trinket is a forced logic trinket like Manic or Ashes, this may be ignored.");
v6("CheckButton", v13, "APL.Monk.Windwalker.Trinket2Usage", "Use Trinket 2", "Use Trinket if Items are enabled. IF Trinket is a forced logic trinket like Manic or Ashes, this may be ignored.");
v8(v26, "APL.Monk.Windwalker.Cooldowns");
v6("Slider", v26, "APL.Monk.Windwalker.Cooldowns.Mobcount", {(0 - 0),(1266 - (696 + 510)),(1263 - (1091 + 171))}, "Mobcount", "Mobcount");
v6("Dropdown", v26, "APL.Monk.Windwalker.Cooldowns.InvokeXuen", v29, "Invoke Xuen Usage", "Select how to use this CD");
v6("Dropdown", v26, "APL.Monk.Windwalker.Cooldowns.SEF", v29, "SEF Usage", "Select how to use this CD");
v6("Dropdown", v26, "APL.Monk.Windwalker.Cooldowns.Racials", v29, "Racials Usage", "Select how to use this CD");
v6("Dropdown", v26, "APL.Monk.Windwalker.Cooldowns.Strike", v29, "Strike of the Windlord Usage", "Select how to use this CD");
v6("Dropdown", v26, "APL.Monk.Windwalker.Cooldowns.Conduit", v29, "Celesital Conduit Usage", "Select how to use this CD");
v6("Slider", v26, "APL.Monk.Windwalker.Cooldowns.ConduitTTD", {(0 - 0),(434 - (123 + 251)),(699 - (208 + 490))}, "Celesital Conduit TTD", "Time to die for spell");
v6("Slider", v26, "APL.Monk.Windwalker.Cooldowns.InvokeXuenTTD", {(0 + 0),(8 + 52),(676 - (534 + 141))}, "Invoke Xuen TTD", "Time to die for spell");
v6("Slider", v26, "APL.Monk.Windwalker.Cooldowns.RacialsTTD", {(0 + 0),(126 - 66),(2 - 1)}, "Racials TTD", "Time to die for spell");
v6("Slider", v26, "APL.Monk.Windwalker.Cooldowns.SEFTTD", {(0 + 0),(139 - 79),(2 - 1)}, "SEF TTD", "Time to die for spell");
v6("Slider", v26, "APL.Monk.Windwalker.Cooldowns.StrikeTTD", {(867 - (550 + 317)),(84 - 24),(286 - (134 + 151))}, "Strike of the Windlord  TTD", "Time to die for spell");
v6("CheckButton", v14, "APL.Monk.Brewmaster.OnlyAttackEnnemyInCombat", "Only attack in combat", "Only attack enemy in combat.");
v6("CheckButton", v14, "APL.Monk.Brewmaster.OnlyAttackEnnemyInCombatSolo", "Only attack in combat Solo", "Only attack enemy in combat when solo.");
v6("Slider", v14, "APL.Monk.Brewmaster.ExpelHarmHP", {(1 - 0),(346 - 246),(3 - 2)}, "Expel Harm HP Threshold", "Set the HP threshold for when to suggest Expel Harm.");
v6("CheckButton", v28, "APL.Monk.Brewmaster.LegSweepInt", "Use Legsweep as Second interrupt?", "Use as another interrupt.");
v6("CheckButton", v28, "APL.Monk.Brewmaster.ParaInt", "Use Paralysis as Second interrupt", "Use as another interrupt.");
v6("Slider", v14, "APL.Monk.Brewmaster.VivVivHP", {(0 - 0),(880 - (162 + 618)),(1 + 0)}, "Vivify with Viv Buff HP Threshold", "Set the HP threshold for self heals.");
v6("CheckButton", v14, "APL.Monk.Brewmaster.AutoTabforInc", "Auto Tab for Incorperal Affix?", "Auto tab for affix.");
v6("CheckButton", v14, "APL.Monk.Brewmaster.AutoTabMelee", "Auto Tab Melee", "Auto Tab to always a target in melee.");
v6("CheckButton", v14, "APL.Monk.Brewmaster.PotionWithLust", "Potion with Lust", "Only Use Potion with Lust.");
v8(v14, "APL.Monk.Brewmaster");
v6("Slider", v15, "APL.Monk.Brewmaster.TTD.WhiterTigerStatue", {(0 - 0),(1696 - (1373 + 263)),(1 + 0)}, "Whiter Tiger Statue TTD", "Time to Die remaining to use Whiter Tiger Statue");
v6("Slider", v15, "APL.Monk.Brewmaster.TTD.Niuzao", {(0 - 0),(23 + 37),(342 - (218 + 123))}, "Niuzao TTD", "Time to Die remaining to use Niuzao");
v6("Slider", v15, "APL.Monk.Brewmaster.TTD.ExplodingKeg", {(0 + 0),(620 - (306 + 254)),(1 - 0)}, "Exploding Keg TTD", "Time to Die remaining to use Exploding Keg");
v6("Slider", v15, "APL.Monk.Brewmaster.TTD.Bonedust", {(0 + 0),(663 - (268 + 335)),(573 - (426 + 146))}, "Bonedust Keg TTD", "Time to Die remaining to use Bonedust Brew");
v6("Slider", v16, "APL.Monk.Mistweaver.ExpelHarmHP", {(1456 - (282 + 1174)),(288 - 188),(1025 - (706 + 318))}, "Expel Harm HP Threshold", "Set the HP threshold for when to suggest Expel Harm.");
v6("Slider", v16, "APL.Monk.Mistweaver.DampenHarmHP", {(1271 - (945 + 326)),(89 + 11),(1 + 0)}, "Dampen Harm HP Threshold", "Set the HP threshold for when to suggest Dampen Harm.");
v6("Slider", v16, "APL.Monk.Mistweaver.FortifyingBrewHP", {(1086 - (461 + 625)),(6 + 94),(1 + 0)}, "Fortifying Brew HP Threshold", "Set the HP threshold for when to suggest Fortifying Brew.)");
v6("Slider", v16, "APL.Monk.Mistweaver.DiffuseMagicHP", {(0 + 0),(629 - (406 + 123)),(1 + 0)}, "Diffuse Magic HP Threshold", "Set the HP threshold to Cast.");
v6("Slider", v16, "APL.Monk.Mistweaver.ManaTeaMP", {(0 + 0),(240 - 140),(1901 - (106 + 1794))}, "Mana Tea MP Threshold", "Set the MP threshold to Cast.");
v6("Slider", v16, "APL.Monk.Mistweaver.ManaTeaStack", {(0 + 0),(54 - 34),(585 - (57 + 527))}, "Mana Tea Stacks", "Set the stack count Cast.");
v6("CheckButton", v16, "APL.Monk.Mistweaver.ManaTeaOOC", "Use Mana Tea OOC?", "Use Mana Tea Out of combat.");
v6("CheckButton", v25, "APL.Monk.Mistweaver.LegSweepInt", "Use Legsweep as Second interrupt?", "Use as another interrupt.");
v6("CheckButton", v25, "APL.Monk.Mistweaver.ParaInt", "Use Paralysis as Second interrupt", "Use as another interrupt.");
v6("CheckButton", v16, "APL.Monk.Mistweaver.AutoTabMelee", "Auto Tab Melee", "Auto Tab to always a target in melee.");
v6("Dropdown", v20, "APL.Monk.Mistweaver.Cooldowns.UseRJW", v21, "Rushing Jade Wind Usage", "How would you like to use this Cooldown?");
v6("Dropdown", v20, "APL.Monk.Mistweaver.Cooldowns.UseRevival", v21, "Revival/Restoral Usage", "How would you like to use this Cooldown?");
v6("Dropdown", v20, "APL.Monk.Mistweaver.Cooldowns.UseYulon", v21, "Yulon Usage", "How would you like to use this Cooldown?");
v6("Slider", v20, "APL.Monk.Mistweaver.Cooldowns.YulonEnVCount", {(103 - (17 + 86)),(22 - 12),(167 - (122 + 44))}, "Enveloping Mist Cast Amount", "Amount of Enveloping Mist Buffs or Cast during Yulon.");
v6("Slider", v20, "APL.Monk.Mistweaver.Cooldowns.VivYulonHP", {(0 - 0),(15 + 85),(66 - (30 + 35))}, "Vivify During Yulon HP ", "Set the HP threshold to Cast.");
v6("Dropdown", v20, "APL.Monk.Mistweaver.Cooldowns.UseChiji", v21, "Chi-Ji Usage", "How would you like to use this Cooldown?");
v6("Dropdown", v20, "APL.Monk.Mistweaver.Cooldowns.UseSG", v21, "Sheiluns Gift Usage", "How would you like to use this Cooldown?");
v6("Slider", v20, "APL.Monk.Mistweaver.Cooldowns.SGStack", {(1257 - (1043 + 214)),(1222 - (323 + 889)),(581 - (361 + 219))}, "Sheiluns Gift Stacks", "Set the stack count Cast.");
v6("Dropdown", v20, "APL.Monk.Mistweaver.Cooldowns.UseFae", v21, "Faeline Stomp Usage", "How would you like to use this Cooldown?");
v6("CheckButton", v20, "APL.Monk.Mistweaver.Cooldowns.FSMoving", "Faeline Stomp Moving? ", "Use FS while Moving?");
v6("CheckButton", v20, "APL.Monk.Mistweaver.Cooldowns.FSCursorBusy", "Skip FS Camera Busy?", "Skip Faeline Stomp While Camera busy? ");
v6("CheckButton", v20, "APL.Monk.Mistweaver.Cooldowns.UseEFAT", "Use EF Refresh AT", "Use Essence Font to refresh AT? ");
v6("Dropdown", v20, "APL.Monk.Mistweaver.Cooldowns.Trinket1Use", v21, "Trinket 1 Usage", "How would you like to use this Cooldown?");
v6("Dropdown", v20, "APL.Monk.Mistweaver.Cooldowns.Trinket2Use", v21, "Trinket 2  Usage", "How would you like to use this Cooldown?");
v6("Slider", v20, "APL.Monk.Mistweaver.Cooldowns.Trinket1HP", {(0 + 0),(1082 - (18 + 964)),(1 + 0)}, "Trinket 1 HP", "Set the Avg HP percentage threshold of when you want to use this at");
v6("Slider", v20, "APL.Monk.Mistweaver.Cooldowns.Trinket2HP", {(850 - (20 + 830)),(226 - (116 + 10)),(739 - (542 + 196))}, "Trinket 2 HP", "Set the Avg HP percentage threshold of when you want to use this at");
v6("Slider", v20, "APL.Monk.Mistweaver.Cooldowns.EscapeHP", {(0 + 0),(36 + 64),(2 - 1)}, "Escape from Reality HP ", "Set the Avg HP threshold to Cast.");
v6("Slider", v18, "APL.Monk.Mistweaver.AoE.SGHP", {(405 - (118 + 287)),(1221 - (118 + 1003)),(378 - (142 + 235))}, "Sheiluns Gift HP ", "Set the HP threshold to Cast.");
v6("Slider", v18, "APL.Monk.Mistweaver.AoE.SGCount", {(0 + 0),(9 - 4),(1 + 0)}, "Sheiluns Gift Count ", "Set the Unit Count  threshold to Cast.");
v6("Slider", v18, "APL.Monk.Mistweaver.AoE.RJWHP", {(0 + 0),(216 - 116),(2 - 1)}, "Rushing Jade Wind HP ", "Set the HP threshold to Cast.");
v6("Slider", v18, "APL.Monk.Mistweaver.AoE.RJWCount", {(0 - 0),(2 + 3),(1 + 0)}, "Rushing Jade Wind Count ", "Set the Unit Count  threshold to Cast.");
v6("Slider", v18, "APL.Monk.Mistweaver.AoE.RevivalHP", {(0 - 0),(831 - (476 + 255)),(1 + 0)}, "Revival/Restoral HP ", "Set the HP threshold to Cast.");
v6("Slider", v18, "APL.Monk.Mistweaver.AoE.RevivalCount", {(0 - 0),(1 + 4),(337 - (144 + 192))}, "Revival/Restoral Count ", "Set the Unit Count  threshold to Cast.");
v6("Slider", v18, "APL.Monk.Mistweaver.AoE.YulonHP", {(0 + 0),(43 + 57),(1581 - (1183 + 397))}, "Yulon HP ", "Set the HP threshold to Cast.");
v6("Slider", v18, "APL.Monk.Mistweaver.AoE.YulonCount", {(0 + 0),(1980 - (1913 + 62)),(2 - 1)}, "Yulon Count ", "Set the Unit Count threshold to Cast.");
v6("Slider", v18, "APL.Monk.Mistweaver.AoE.ChijiHP", {(0 - 0),(136 - 36),(857 - (564 + 292))}, "Chi-Ji HP ", "Set the HP threshold to Cast.");
v6("Slider", v18, "APL.Monk.Mistweaver.AoE.ChijiCount", {(0 - 0),(4 + 1),(1002 - (938 + 63))}, "Chi-Ji Count ", "Set the Unit Count  threshold to Cast.");
v6("Slider", v18, "APL.Monk.Mistweaver.AoE.FSHP", {(1125 - (936 + 189)),(1713 - (1565 + 48)),(1139 - (782 + 356))}, "Faeline Stomp HP ", "Set the HP threshold to Cast.");
v6("Slider", v18, "APL.Monk.Mistweaver.AoE.FSCount", {(0 - 0),(1097 - (975 + 117)),(1 + 0)}, "Faeline Stomp Count ", "Set the Unit Count  threshold to Cast.");
v6("Slider", v18, "APL.Monk.Mistweaver.AoE.CCHP", {(0 - 0),(272 - 172),(2 - 1)}, "Celestial Conduit HP ", "Set the HP threshold to Cast.");
v6("Slider", v18, "APL.Monk.Mistweaver.AoE.CCCount", {(0 - 0),(1267 - (322 + 905)),(1190 - (449 + 740))}, "Celestial Conduit Count ", "Set the Unit Count threshold to Cast.");
v6("Slider", v17, "APL.Monk.Mistweaver.Healing.EnvMistHP", {(947 - (245 + 702)),(33 + 67),(441 - (382 + 58))}, "Enveloping Mist HP ", "Set the HP threshold to Cast.");
v6("Slider", v17, "APL.Monk.Mistweaver.Healing.EnvMistTFTHPOnPlayer", {(0 + 0),(297 - 197),(1 - 0)}, "Enveloping Mist with TFT on Player HP ", "Set the HP threshold to Cast.");
v6("Slider", v17, "APL.Monk.Mistweaver.Healing.VivifyHP", {(0 + 0),(314 - (22 + 192)),(1464 - (1404 + 59))}, "Vivify HP ", "Set the HP threshold to Cast.");
v6("Slider", v17, "APL.Monk.Mistweaver.Healing.VivVivifyHP", {(0 - 0),(662 - (334 + 228)),(2 - 1)}, "Instant Vivify HP ", "Set the HP threshold to Cast.");
v6("Slider", v17, "APL.Monk.Mistweaver.Healing.RenewingMistHP", {(0 + 0),(99 + 1),(2 - 1)}, "Renewing Mist HP ", "Set the HP threshold to Cast.");
v6("Slider", v17, "APL.Monk.Mistweaver.Healing.RenewingMistOOC", {(0 - 0),(53 + 47),(1 + 0)}, "Renewing Mist OOC HP ", "Set the HP threshold to Cast.");
v6("Slider", v17, "APL.Monk.Mistweaver.Healing.LCHP", {(0 + 0),(865 - (574 + 191)),(2 - 1)}, "Life Cocoon HP", "Set the HP threshold to Cast.");
v6("Slider", v22, "APL.Monk.Mistweaver.RaidHealing.EnvMistHP", {(849 - (254 + 595)),(131 - 31),(2 - 1)}, "Enveloping Mist HP ", "Set the HP threshold to Cast.");
v6("Slider", v22, "APL.Monk.Mistweaver.RaidHealing.EnvMistTFTHPOnPlayer", {(0 - 0),(292 - 192),(1 + 0)}, "Enveloping Mist with TFT on Player HP ", "Set the HP threshold to Cast.");
v6("Slider", v22, "APL.Monk.Mistweaver.RaidHealing.VivifyHP", {(806 - (118 + 688)),(20 + 80),(3 - 2)}, "Vivify HP ", "Set the HP threshold to Cast.");
v6("Slider", v22, "APL.Monk.Mistweaver.RaidHealing.VivVivifyHP", {(0 - 0),(243 - 143),(2 - 1)}, "Instant Vivify HP ", "Set the HP threshold to Cast.");
v6("Slider", v22, "APL.Monk.Mistweaver.RaidHealing.RenewingMistHP", {(1796 - (503 + 1293)),(73 + 27),(1 + 0)}, "Renewing Mist HP ", "Set the HP threshold to Cast.");
v6("Slider", v22, "APL.Monk.Mistweaver.RaidHealing.RenewingMistOOC", {(0 + 0),(833 - (711 + 22)),(860 - (240 + 619))}, "Renewing Mist OOC HP ", "Set the HP threshold to Cast.");
v6("Slider", v22, "APL.Monk.Mistweaver.RaidHealing.LCHP", {(0 - 0),(1844 - (1344 + 400)),(1 + 0)}, "Life Cocoon HP", "Set the HP threshold to Cast.");
v6("Slider", v23, "APL.Monk.Mistweaver.RaidAoE.SGHP", {(0 - 0),(1839 - (404 + 1335)),(1 - 0)}, "Sheiluns Gift HP ", "Set the HP threshold to Cast.");
v6("Slider", v23, "APL.Monk.Mistweaver.RaidAoE.SGCount", {(0 + 0),(28 + 12),(1 + 0)}, "Sheiluns Gift Count ", "Set the Unit Count  threshold to Cast.");
v6("Slider", v23, "APL.Monk.Mistweaver.RaidAoE.RJWHP", {(0 + 0),(1593 - (711 + 782)),(470 - (270 + 199))}, "Rushing Jade Wind HP ", "Set the HP threshold to Cast.");
v6("Slider", v23, "APL.Monk.Mistweaver.RaidAoE.RJWCount", {(1819 - (580 + 1239)),(39 + 1),(1 + 0)}, "Rushing Jade Wind Count ", "Set the Unit Count  threshold to Cast.");
v6("Slider", v23, "APL.Monk.Mistweaver.RaidAoE.RevivalHP", {(0 + 0),(1890 - (1010 + 780)),(4 - 3)}, "Revival/Restoral HP ", "Set the HP threshold to Cast.");
v6("Slider", v23, "APL.Monk.Mistweaver.RaidAoE.RevivalCount", {(1836 - (1045 + 791)),(61 - 21),(1575 - (1281 + 293))}, "Revival/Restoral Count ", "Set the Unit Count  threshold to Cast.");
v6("Slider", v23, "APL.Monk.Mistweaver.RaidAoE.YulonHP", {(0 - 0),(94 + 6),(1 + 0)}, "Yulon HP ", "Set the HP threshold to Cast.");
v6("Slider", v23, "APL.Monk.Mistweaver.RaidAoE.YulonCount", {(0 + 0),(36 + 4),(1 - 0)}, "Yulon Count ", "Set the Unit Count threshold to Cast.");
v6("Slider", v23, "APL.Monk.Mistweaver.RaidAoE.ChijiHP", {(0 - 0),(1555 - (990 + 465)),(1 + 0)}, "Chi-Ji HP ", "Set the HP threshold to Cast.");
v6("Slider", v23, "APL.Monk.Mistweaver.RaidAoE.ChijiCount", {(0 - 0),(666 - (512 + 114)),(1 - 0)}, "Chi-Ji Count ", "Set the Unit Count  threshold to Cast.");
v6("Slider", v23, "APL.Monk.Mistweaver.RaidAoE.FSHP", {(0 + 0),(87 + 13),(1995 - (109 + 1885))}, "Faeline Stomp HP ", "Set the HP threshold to Cast.");
v6("Slider", v23, "APL.Monk.Mistweaver.RaidAoE.FSCount", {(0 - 0),(866 - (802 + 24)),(1 - 0)}, "Faeline Stomp Count ", "Set the Unit Count  threshold to Cast.");
v6("Slider", v23, "APL.Monk.Mistweaver.RaidAoE.CCHP", {(0 + 0),(22 + 78),(3 - 2)}, "Celestial Conduit HP ", "Set the HP threshold to Cast.");
v6("Slider", v23, "APL.Monk.Mistweaver.RaidAoE.CCCount", {(0 + 0),(30 + 10),(1434 - (797 + 636))}, "Celestial Conduit Count ", "Set the Unit Count threshold to Cast.");
v6("Slider", v19, "APL.Monk.Mistweaver.Soothing.SoothingMistHP", {(1619 - (1427 + 192)),(232 - 132),(1 + 0)}, "Soothing Mist HP ", "Set the HP threshold to Cast.");
v6("Slider", v19, "APL.Monk.Mistweaver.Soothing.SoothingMistAtRange", {(1276 - (316 + 960)),(78 + 22),(3 - 2)}, "Soothing Mist at Range (Not In Melee) HP ", "Set the HP threshold to Cast.");
v6("Slider", v24, "APL.Monk.Mistweaver.RaidSoothing.SoothingMistHP", {(1806 - (1202 + 604)),(166 - 66),(326 - (45 + 280))}, "Soothing Mist HP ", "Set the HP threshold to Cast.");
v6("Slider", v24, "APL.Monk.Mistweaver.RaidSoothing.SoothingMistAtRange", {(0 + 0),(56 + 44),(1 - 0)}, "Soothing Mist at Range (Not In Melee) HP ", "Set the HP threshold to Cast.");
v8(v16, "APL.Monk.Mistweaver");
v8(v19, "APL.Monk.Mistweaver.Soothing");
v8(v19, "APL.Monk.Mistweaver.Soothing");
v8(v17, "APL.Monk.Mistweaver.Healing");
v8(v23, "APL.Monk.Mistweaver.RaidAoE");
v8(v22, "APL.Monk.Mistweaver.RaidHealing");
v8(v18, "APL.Monk.Mistweaver.AoE");
v8(v20, "APL.Monk.Mistweaver.Cooldowns");
local v30 = v4.GetPanelByName("Interrupt");
v9.APL.Monk.Mistweaver.Display = function()
	v3.GUI.ShowPanel(v16);
	v3.GUI.ShowPanel(v19);
	v3.GUI.ShowPanel(v24);
	v3.GUI.ShowPanel(v17);
	v3.GUI.ShowPanel(v18);
	v3.GUI.ShowPanel(v20);
	v3.GUI.ShowPanel(v22);
	v3.GUI.ShowPanel(v23);
	v3.GUI.HidePanel(v15);
	v3.GUI.HidePanel(v14);
	v3.GUI.HidePanel(v13);
	v3.GUI.HidePanel(v30);
	v3.GUI.ShowPanel(v25);
	v3.GUI.HidePanel(v28);
	v3.GUI.HidePanel(v27);
end;
v9.APL.Monk.Windwalker.Display = function()
	v3.GUI.HidePanel(v16);
	v3.GUI.HidePanel(v19);
	v3.GUI.HidePanel(v24);
	v3.GUI.HidePanel(v17);
	v3.GUI.HidePanel(v18);
	v3.GUI.HidePanel(v20);
	v3.GUI.HidePanel(v22);
	v3.GUI.HidePanel(v23);
	v3.GUI.HidePanel(v15);
	v3.GUI.HidePanel(v14);
	v3.GUI.ShowPanel(v13);
	v3.GUI.HidePanel(v30);
	v3.GUI.HidePanel(v25);
	v3.GUI.HidePanel(v28);
	v3.GUI.ShowPanel(v27);
end;
v9.APL.Monk.Brewmaster.Display = function()
	v3.GUI.HidePanel(v16);
	v3.GUI.HidePanel(v19);
	v3.GUI.HidePanel(v24);
	v3.GUI.HidePanel(v17);
	v3.GUI.HidePanel(v18);
	v3.GUI.HidePanel(v20);
	v3.GUI.HidePanel(v22);
	v3.GUI.HidePanel(v23);
	v3.GUI.ShowPanel(v14);
	v3.GUI.ShowPanel(v15);
	v3.GUI.HidePanel(v13);
	v3.GUI.HidePanel(v30);
	v3.GUI.HidePanel(v25);
	v3.GUI.ShowPanel(v28);
	v3.GUI.HidePanel(v27);
end;
