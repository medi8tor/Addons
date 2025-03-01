local v0, v1 = ...;
local v2 = HeroRotation();
local v3 = HeroLib;
local v4 = v3.GUI;
local v5 = v4.CreateChildPanel;
local v6 = v4.CreatePanelOption;
local v7 = v2.HRGUIGet().CreateARPanelOption;
local v8 = v2.HRGUIGet().CreateARPanelOptions;
local v9 = v4.GetPanelByName("Interrupt");
local v10 = v2.GUISettingsGet();
v10.APL.Warlock = {Commons={Enabled={Potions=true,Trinkets=true,Items=true},DisplayStyle={Potions="Suggested",Trinkets="Suggested",Items="Suggested",Signature="Suggested"},HidePetSummon=false},Destruction={IgnoreSTHavoc=false,AttackonlyinCombat=false,BurningRush="only out of fight",BurningRushcancel=(125 - 85),CursorCheck=true,PotionType={Selected="Tempered Potion"},PotionRank={Selected="Any"}},Destruction_Interrupt={Interrupt={AutoInterrupt=true,AutoStun=true,AutoTargetInterrupt=false,AutoTargetStun=false,InterruptEverythingSolo=true,InterruptEverythingRaid=true,InterruptInDungeon="Whitelist",InterruptInDungeonUseStunAsInterrupt=true,InterruptPercent=(171 - 111),InterruptPercentChannel=(115 - 55)}},Destruction_TTD={RacialsTTD=(51 - 31),TrinketsTTD=(639 - (555 + 64)),SummonInfernalTTD=(961 - (857 + 74)),DimensionalRiftTTD=(583 - (367 + 201)),PotionsTTD=(947 - (214 + 713)),MalevolenceTTD=(6 + 14),CataclysmTTD=(4 + 16),IgnoreWhenSolo=true,IgnoreWhenBoss=true},Destruction_CDUSE={smallcdswithCooldowns=true,Enemycount=(882 - (282 + 595)),Racials="with Cooldowns",Potions="with Cooldowns",Potionswhensolo=false,Trinket1="with Cooldowns",Trinket2="with Cooldowns",SummonInfernal="with Cooldowns",DimensionalRift="with Cooldowns",Malevolence="with Cooldowns",Cataclysm="with Cooldowns"},Destruction_Pets={PetSelected="Felhunter",FelDomination="only Infight"},Demonology={PISource="None",AttackonlyinCombat=false,BurningRush="only out of fight",BurningRushcancel=(1677 - (1523 + 114)),CursorCheck=true,PotionType={Selected="Tempered Potion"},PotionRank={Selected="Any"}},Demonology_Interrupt={Interrupt={AutoInterrupt=true,AutoStun=true,AutoTargetInterrupt=false,AutoTargetStun=false,InterruptEverythingSolo=true,InterruptEverythingRaid=true,InterruptInDungeon="Whitelist",InterruptInDungeonUseStunAsInterrupt=true,InterruptPercent=(54 + 6),InterruptPercentChannel=(85 - 25)}},Demonology_TTD={RacialsTTD=(1085 - (68 + 997)),TrinketsTTD=(1290 - (226 + 1044)),SummonDemonicTyrantTTD=(87 - 67),GrimoireFelguardTTD=(137 - (32 + 85)),GuillotineTTD=(10 + 0),ImplosionTTD=(1 + 1),PotionsTTD=(977 - (892 + 65)),IgnoreWhenSolo=true,IgnoreWhenBoss=true},Demonology_CDUSE={smallcdswithCooldowns=true,Enemycount=(11 - 6),Racials="with Cooldowns",Potions="with Cooldowns",Potionswhensolo=false,Trinket1="with Cooldowns",Trinket2="with Cooldowns",SummonDemonicTyrant="with Cooldowns",GrimoireFelguard="with Cooldowns",Guillotine="with Cooldowns",Implosion="always"},Demonology_Pets={PetSelected="Felguard",FelDomination="only Infight"},Affliction={AttackonlyinCombat=false,BurningRush="only out of fight",BurningRushcancel=(73 - 33),CursorCheck=true,PotionType={Selected="Tempered Potion"},PotionRank={Selected="Any"}},Affliction_Interrupt={Interrupt={AutoInterrupt=true,AutoStun=true,AutoTargetInterrupt=false,AutoTargetStun=false,InterruptEverythingSolo=true,InterruptEverythingRaid=true,InterruptInDungeon="Whitelist",InterruptInDungeonUseStunAsInterrupt=true,InterruptPercent=(110 - 50),InterruptPercentChannel=(410 - (87 + 263))}},Affliction_TTD={RacialsTTD=(200 - (67 + 113)),TrinketsTTD=(15 + 5),SummonDarkglareTTD=(24 - 14),SoulRotTTD=(8 + 2),PotionsTTD=(79 - 59),MalevolenceTTD=(972 - (802 + 150)),OblivionTTD=(53 - 33),VileTaintTTD=(36 - 16),PhantomSingularityTTD=(15 + 5),IgnoreWhenSolo=true,IgnoreWhenBoss=true},Affliction_CDUSE={smallcdswithCooldowns=true,Enemycount=(1002 - (915 + 82)),Racials="with Cooldowns",Potions="with Cooldowns",Potionswhensolo=false,Trinket1="with Cooldowns",Trinket2="with Cooldowns",SummonDarkglare="with Cooldowns",SoulRot="with Cooldowns",Malevolence="with Cooldowns",Oblivion="with Cooldowns",VileTaint="with Cooldowns",PhantomSingularity="with Cooldowns"},Affliction_Pets={PetSelected="Felhunter",FelDomination="only Infight"},Defensives={UnendingResolveHP=(113 - 73),DarkPactHP=(35 + 25),HealthFunnelHP=(26 - 6),DrainLifeHP=(1207 - (1069 + 118)),MortalCoilHP=(68 - 38)}};
v2.HRGUIGet().LoadSettingsRecursively(v10);
local v12 = {"Not Used","always","with Cooldowns","small CDs","with Cooldowns or AoE","on Enemycount or Cooldowns","on Boss or with Cooldowns","on Boss only","with Bloodlust only","on AOE","on Enemycount","on Boss or on Enemycount"};
local v13 = {"never","only Infight","only out of Fight","both"};
local v14 = v2.HRGUIGet().Panel;
local v15 = v5(v14, "Warlock");
local v16 = v5(v15, "Defensives");
local v17 = v5(v15, "Demonology");
local v18 = v5(v17, "Interrupt");
v8(v18, "APL.Warlock.Demonology_Interrupt");
local v19 = v5(v17, "TTD");
local v20 = v5(v17, "Pets");
local v21 = v5(v17, "Cooldown settings");
local v22 = v5(v15, "Affliction");
local v23 = v5(v22, "Interrupt");
v8(v23, "APL.Warlock.Affliction_Interrupt");
local v24 = v5(v22, "TTD");
local v25 = v5(v22, "Pets");
local v26 = v5(v22, "Cooldown settings");
local v27 = v5(v15, "Destruction");
local v28 = v5(v27, "Interrupt");
v8(v28, "APL.Warlock.Destruction_Interrupt");
local v29 = v5(v27, "TTD");
local v30 = v5(v27, "Pets");
local v31 = v5(v27, "Cooldown settings");
v8(v15, "APL.Warlock.Commons");
v6("CheckButton", v27, "APL.Warlock.Destruction.IgnoreSTHavoc", "Ignore Havoc in Single Target", "Enable this option to not receive suggestions to use Havoc while in single target combat.");
v6("CheckButton", v27, "APL.Warlock.Destruction.AttackonlyinCombat", "Only attack Targets in combat", "Enable this if you want the addon to only attack Mobs in combat.");
v6("Dropdown", v27, "APL.Warlock.Destruction.BurningRush", {"Never","only infight","only out of fight","always"}, "Auto use Burning Rush", "Choose when to use Burning Rush.");
v6("Slider", v27, "APL.Warlock.Destruction.BurningRushcancel", {(0 - 0),(919 - (814 + 45)),(1 + 0)}, "Auto cancel Burning Rush", "Choose on which HP threshold Burning Rush has to be canceled");
v6("CheckButton", v27, "APL.Warlock.Destruction.CursorCheck", "Cursor Check", "Will check if an Enemy is at the cursor Place currently before fireing Placeable Spells.");
v8(v27, "APL.Warlock.Destruction");
v6("CheckButton", v29, "APL.Warlock.Destruction_TTD.IgnoreWhenSolo", "Ignore Time to Die when solo", "Enable this if you want to ignore Time to die when you are solo.");
v6("CheckButton", v29, "APL.Warlock.Destruction_TTD.IgnoreWhenBoss", "Ignore Time to Die when in Bossfight", "Enable this if you want to ignore Time to die when you are in a Bossfight.");
v6("Slider", v29, "APL.Warlock.Destruction_TTD.RacialsTTD", {(885 - (261 + 624)),(1140 - (1020 + 60)),(3 - 2)}, "Racials TTD", "Time to die to use Racial spells");
v6("Slider", v29, "APL.Warlock.Destruction_TTD.TrinketsTTD", {(0 + 0),(1807 - (760 + 987)),(767 - (745 + 21))}, "Trinkets TTD", "Time to die to use Trinkets");
v6("Slider", v29, "APL.Warlock.Destruction_TTD.SummonInfernalTTD", {(0 - 0),(1 + 59),(1056 - (87 + 968))}, "Summon Infernal TTD", "Time to die to use Summon Infernal");
v6("Slider", v29, "APL.Warlock.Destruction_TTD.DimensionalRiftTTD", {(0 + 0),(1473 - (447 + 966)),(1818 - (1703 + 114))}, "Dimensional Rift TTD", "Time to die to use Dimensional Rift");
v6("Slider", v29, "APL.Warlock.Destruction_TTD.PotionsTTD", {(0 - 0),(18 + 42),(15 - (9 + 5))}, "Potions TTD", "Time to die to use DPS Potions");
v6("Slider", v29, "APL.Warlock.Destruction_TTD.MalevolenceTTD", {(1265 - (243 + 1022)),(50 + 10),(1 + 0)}, "Malevolence TTD", "Time to die to use Malevolence");
v6("Slider", v29, "APL.Warlock.Destruction_TTD.CataclysmTTD", {(1930 - (1869 + 61)),(211 - 151),(1 + 0)}, "Cataclysm TTD", "Time to die to use Cataclysm");
v8(v29, "APL.Warlock.Destruction_TTD");
v6("CheckButton", v31, "APL.Warlock.Destruction_CDUSE.smallcdswithCooldowns", "Use small cds when Cd toggle is active", "Small cds will also get triggered when the regular cd toggle is active.");
v6("Slider", v31, "APL.Warlock.Destruction_CDUSE.Enemycount", {(2 + 0),(981 - (140 + 831)),(719 - (15 + 703))}, "Enemycount", "How many Enemys we need in range to use a selected Cooldown.");
v6("Dropdown", v31, "APL.Warlock.Destruction_CDUSE.Racials", v12, "Racials", "Choose an option on when to use Racials");
v6("Dropdown", v31, "APL.Warlock.Destruction_CDUSE.Potions", v12, "DPS Potions", "Choose an option on when to use Potions");
v6("CheckButton", v31, "APL.Warlock.Destruction_CDUSE.Potionswhensolo", "Use DPS Potions when solo", "Enable this if you want to use Potions even when doing solo stuff.");
v6("Dropdown", v31, "APL.Warlock.Destruction_CDUSE.Trinket1", v12, "Trinket1", "Choose an option on when to use Trinket1");
v6("Dropdown", v31, "APL.Warlock.Destruction_CDUSE.Trinket2", v12, "Trinket2", "Choose an option on when to use Trinket2");
v6("Dropdown", v31, "APL.Warlock.Destruction_CDUSE.SummonInfernal", v12, "Summon Infernal", "Choose an option on when to use Summon Infernal");
v6("Dropdown", v31, "APL.Warlock.Destruction_CDUSE.DimensionalRift", v12, "Dimensional Rift", "Choose an option on when to use Dimensional Rift");
v6("Dropdown", v31, "APL.Warlock.Destruction_CDUSE.Malevolence", v12, "Malevolence", "Choose an option on when to use Malevolence");
v6("Dropdown", v31, "APL.Warlock.Destruction_CDUSE.Cataclysm", v12, "Cataclysm", "Choose an option on when to use Cataclysm");
v8(v31, "APL.Warlock.Destruction_CDUSE");
v8(v30, "APL.Warlock.Destruction_Pets");
v6("Dropdown", v30, "APL.Warlock.Destruction_Pets.PetSelected", {"None","Imp","Voidwalker","Felhunter","Sayaad"}, "Which Pet you want", "Choose which pet to summon if no pet currently active. If you want to control your pet manual, set it to none");
v6("Dropdown", v30, "APL.Warlock.Destruction_Pets.FelDomination", v13, "Use Fel Domination", "Choose when to use Fel Domination");
v6("Dropdown", v17, "APL.Warlock.Demonology.PISource", {"None","Shadow","Disc/Holy"}, "Power Infusion Source", "If you are receiving Power Infusion, selected what spec Priest is supplying it. Otherwise, leave this set to None.");
v6("CheckButton", v17, "APL.Warlock.Demonology.AttackonlyinCombat", "Only attack Targets in combat", "Enable this if you want the addon to only attack Mobs in combat.");
v6("Dropdown", v17, "APL.Warlock.Demonology.BurningRush", {"Never","only infight","only out of fight","always"}, "Auto use Burning Rush", "Choose when to use Burning Rush.");
v6("Slider", v17, "APL.Warlock.Demonology.BurningRushcancel", {(0 - 0),(6 + 54),(837 - (660 + 176))}, "Auto cancel Burning Rush", "Choose on which HP threshold Burning Rush has to be canceled");
v6("CheckButton", v17, "APL.Warlock.Demonology.CursorCheck", "Cursor Check", "Will check if an Enemy is at the cursor Place currently before fireing Placeable Spells.");
v8(v17, "APL.Warlock.Demonology");
v6("CheckButton", v19, "APL.Warlock.Demonology_TTD.IgnoreWhenSolo", "Ignore Time to Die when solo", "Enable this if you want to ignore Time to die when you are solo.");
v6("CheckButton", v19, "APL.Warlock.Demonology_TTD.IgnoreWhenBoss", "Ignore Time to Die when in Bossfight", "Enable this if you want to ignore Time to die when you are in a Bossfight.");
v6("Slider", v19, "APL.Warlock.Demonology_TTD.RacialsTTD", {(202 - (14 + 188)),(25 + 35),(1 + 0)}, "Racials TTD", "Time to die to use Racial spells");
v6("Slider", v19, "APL.Warlock.Demonology_TTD.TrinketsTTD", {(0 - 0),(33 + 27),(397 - (115 + 281))}, "Trinkets TTD", "Time to die to use Trinkets");
v6("Slider", v19, "APL.Warlock.Demonology_TTD.SummonDemonicTyrantTTD", {(0 + 0),(220 - 160),(1 - 0)}, "Summon Demonic Tyrant TTD", "Time to die to use Summon Demonic Tyrant");
v6("Slider", v19, "APL.Warlock.Demonology_TTD.GrimoireFelguardTTD", {(0 - 0),(1725 - (970 + 695)),(1991 - (582 + 1408))}, "Grimoire Felguard TTD", "Time to die to use Grimoire Felguards");
v6("Slider", v19, "APL.Warlock.Demonology_TTD.GuillotineTTD", {(0 - 0),(1884 - (1195 + 629)),(242 - (187 + 54))}, "Guillotine TTD", "Time to die to use Guillotine");
v6("Slider", v19, "APL.Warlock.Demonology_TTD.ImplosionTTD", {(0 + 0),(127 - 67),(1 + 0)}, "Implosion TTD", "Time to die to use Implosion");
v6("Slider", v19, "APL.Warlock.Demonology_TTD.PotionsTTD", {(1000 - (451 + 549)),(93 - 33),(1385 - (746 + 638))}, "Potions TTD", "Time to die to use DPS Potions");
v8(v19, "APL.Warlock.Demonology_TTD");
v6("CheckButton", v21, "APL.Warlock.Demonology_CDUSE.smallcdswithCooldowns", "Use small cds when Cd toggle is active", "Small cds will also get triggered when the regular cd toggle is active.");
v6("Slider", v21, "APL.Warlock.Demonology_CDUSE.Enemycount", {(2 - 0),(1591 - (1535 + 46)),(1 + 0)}, "Enemycount", "How many Enemys we need in range to use a selected Cooldown.");
v6("Dropdown", v21, "APL.Warlock.Demonology_CDUSE.Racials", v12, "Racials", "Choose an option on when to use Racials");
v6("Dropdown", v21, "APL.Warlock.Demonology_CDUSE.Potions", v12, "DPS Potions", "Choose an option on when to use Potions");
v6("CheckButton", v21, "APL.Warlock.Demonology_CDUSE.Potionswhensolo", "Use DPS Potions when solo", "Enable this if you want to use Potions even when doing solo stuff.");
v6("Dropdown", v21, "APL.Warlock.Demonology_CDUSE.Trinket1", v12, "Trinket1", "Choose an option on when to use Trinket1");
v6("Dropdown", v21, "APL.Warlock.Demonology_CDUSE.Trinket2", v12, "Trinket2", "Choose an option on when to use Trinket2");
v6("Dropdown", v21, "APL.Warlock.Demonology_CDUSE.SummonDemonicTyrant", v12, "Summon Demonic Tyrant", "Choose an option on when to use Summon Demonic Tyrant");
v6("Dropdown", v21, "APL.Warlock.Demonology_CDUSE.GrimoireFelguard", v12, "Grimoire Felguard", "Choose an option on when to use Grimoire Felguards");
v6("Dropdown", v21, "APL.Warlock.Demonology_CDUSE.Guillotine", v12, "Guillotine", "Choose an option on when to use Guillotine");
v6("Dropdown", v21, "APL.Warlock.Demonology_CDUSE.Implosion", v12, "Implosion", "Choose an option on when to use Implosion");
v8(v21, "APL.Warlock.Demonology_CDUSE");
v8(v20, "APL.Warlock.Demonology_Pets");
v6("Dropdown", v20, "APL.Warlock.Demonology_Pets.PetSelected", {"None","Felguard","Imp","Voidwalker","Felhunter","Sayaad"}, "Which Pet you want", "Choose which pet to summon if no pet currently active. If you want to control your pet manual, set it to none");
v6("Dropdown", v20, "APL.Warlock.Demonology_Pets.FelDomination", v13, "Use Fel Domination", "Choose when to use Fel Domination");
v6("CheckButton", v22, "APL.Warlock.Affliction.AttackonlyinCombat", "Only attack Targets in combat", "Enable this if you want the addon to only attack Mobs in combat.");
v6("Dropdown", v22, "APL.Warlock.Affliction.BurningRush", {"Never","only infight","only out of fight","always"}, "Auto use Burning Rush", "Choose when to use Burning Rush.");
v6("Slider", v22, "APL.Warlock.Affliction.BurningRushcancel", {(811 - (569 + 242)),(4 + 56),(1252 - (721 + 530))}, "Auto cancel Burning Rush", "Choose on which HP threshold Burning Rush has to be canceled");
v6("CheckButton", v22, "APL.Warlock.Affliction.CursorCheck", "Cursor Check", "Will check if an Enemy is at the cursor Place currently before fireing Placeable Spells.");
v8(v22, "APL.Warlock.Affliction");
v6("CheckButton", v24, "APL.Warlock.Affliction_TTD.IgnoreWhenSolo", "Ignore Time to Die when solo", "Enable this if you want to ignore Time to die when you are solo.");
v6("CheckButton", v24, "APL.Warlock.Affliction_TTD.IgnoreWhenBoss", "Ignore Time to Die when in Bossfight", "Enable this if you want to ignore Time to die when you are in a Bossfight.");
v6("Slider", v24, "APL.Warlock.Affliction_TTD.RacialsTTD", {(0 - 0),(760 - (271 + 429)),(1501 - (1408 + 92))}, "Racials TTD", "Time to die to use Racial spells");
v6("Slider", v24, "APL.Warlock.Affliction_TTD.TrinketsTTD", {(1288 - (993 + 295)),(1231 - (418 + 753)),(1 + 0)}, "Trinkets TTD", "Time to die to use Trinkets");
v6("Slider", v24, "APL.Warlock.Affliction_TTD.SummonDarkglareTTD", {(0 + 0),(1829 - (1749 + 20)),(1323 - (1249 + 73))}, "Summon Darkglare TTD", "Time to die to use Summon Darkglare");
v6("Slider", v24, "APL.Warlock.Affliction_TTD.SoulRotTTD", {(1145 - (466 + 679)),(171 - 111),(1 + 0)}, "Soul Rot TTD", "Time to die to use Soul Rot");
v6("Slider", v24, "APL.Warlock.Affliction_TTD.PotionsTTD", {(0 - 0),(174 - (4 + 110)),(1428 - (41 + 1386))}, "Potions TTD", "Time to die to use DPS Potions");
v6("Slider", v24, "APL.Warlock.Affliction_TTD.MalevolenceTTD", {(0 + 0),(173 - 113),(1 - 0)}, "Malevolence TTD", "Time to die to use Malevolence");
v6("Slider", v24, "APL.Warlock.Affliction_TTD.OblivionTTD", {(0 + 0),(121 - 61),(1 + 0)}, "Oblivion TTD", "Time to die to use Oblivion");
v6("Slider", v24, "APL.Warlock.Affliction_TTD.VileTaintTTD", {(0 - 0),(161 - 101),(321 - (53 + 267))}, "Vile Taint TTD", "Time to die to use Vile Taint");
v6("Slider", v24, "APL.Warlock.Affliction_TTD.PhantomSingularityTTD", {(413 - (15 + 398)),(225 - 165),(1 + 0)}, "Phantom Singularity TTD", "Time to die to use Phantom Singularity");
v8(v24, "APL.Warlock.Affliction_TTD");
v6("CheckButton", v26, "APL.Warlock.Affliction_CDUSE.smallcdswithCooldowns", "Use small cds when Cd toggle is active", "Small cds will also get triggered when the regular cd toggle is active.");
v6("Slider", v26, "APL.Warlock.Affliction_CDUSE.Enemycount", {(2 + 0),(1 + 9),(1 - 0)}, "Enemycount", "How many Enemys we need in range to use a selected Cooldown.");
v6("Dropdown", v26, "APL.Warlock.Affliction_CDUSE.Racials", v12, "Racials", "Choose an option on when to use Racials");
v6("Dropdown", v26, "APL.Warlock.Affliction_CDUSE.Potions", v12, "DPS Potions", "Choose an option on when to use Potions");
v6("CheckButton", v26, "APL.Warlock.Affliction_CDUSE.Potionswhensolo", "Use DPS Potions when solo", "Enable this if you want to use Potions even when doing solo stuff.");
v6("Dropdown", v26, "APL.Warlock.Affliction_CDUSE.Trinket1", v12, "Trinket1", "Choose an option on when to use Trinket1");
v6("Dropdown", v26, "APL.Warlock.Affliction_CDUSE.Trinket2", v12, "Trinket2", "Choose an option on when to use Trinket2");
v6("Dropdown", v26, "APL.Warlock.Affliction_CDUSE.SummonDarkglare", v12, "Summon Darkglare", "Choose an option on when to use Summon Darkglare");
v6("Dropdown", v26, "APL.Warlock.Affliction_CDUSE.SoulRot", v12, "Soul Rot", "Choose an option on when to use Soul Rot");
v6("Dropdown", v26, "APL.Warlock.Affliction_CDUSE.Malevolence", v12, "Malevolence", "Choose an option on when to use Malevolence");
v6("Dropdown", v26, "APL.Warlock.Affliction_CDUSE.Oblivion", v12, "Oblivion", "Choose an option on when to use Oblivion");
v6("Dropdown", v26, "APL.Warlock.Affliction_CDUSE.VileTaint", v12, "Vile Taint", "Choose an option on when to use Vile Taint");
v6("Dropdown", v26, "APL.Warlock.Affliction_CDUSE.PhantomSingularity", v12, "Phantom Singularity", "Choose an option on when to use Phantom Singularity");
v8(v26, "APL.Warlock.Affliction_CDUSE");
v8(v25, "APL.Warlock.Affliction_Pets");
v6("Dropdown", v25, "APL.Warlock.Affliction_Pets.PetSelected", {"None","Imp","Voidwalker","Felhunter","Sayaad"}, "Which Pet you want", "Choose which pet to summon if no pet currently active. If you want to control your pet manual, set it to none");
v6("Dropdown", v25, "APL.Warlock.Affliction_Pets.FelDomination", v13, "Use Fel Domination", "Choose when to use Fel Domination");
v8(v16, "APL.Warlock.Defensives");
v6("Slider", v16, "APL.Warlock.Defensives.UnendingResolveHP", {(405 - (118 + 287)),(1221 - (118 + 1003)),(378 - (142 + 235))}, "Unending Resolve HP", "Set the Unending Resolve HP threshold.");
v6("Slider", v16, "APL.Warlock.Defensives.DarkPactHP", {(0 + 0),(189 - 89),(1 + 0)}, "Dark Pact HP", "Set the Dark Pact HP threshold.");
v6("Slider", v16, "APL.Warlock.Defensives.HealthFunnelHP", {(0 + 0),(216 - 116),(2 - 1)}, "Health Funnel HP", "Set the Health Funnel HP threshold.");
v6("Slider", v16, "APL.Warlock.Defensives.DrainLifeHP", {(0 - 0),(36 + 64),(1 + 0)}, "Drain Life HP", "Set the Drain Life HP threshold.");
v6("Slider", v16, "APL.Warlock.Defensives.MortalCoilHP", {(0 - 0),(831 - (476 + 255)),(1 + 0)}, "Mortal Coil HP", "Set the Mortal Coil HP threshold.");
v10.APL.Warlock.Demonology.Display = function()
	v3.GUI.HidePanel(v22);
	v3.GUI.HidePanel(v23);
	v3.GUI.HidePanel(v24);
	v3.GUI.HidePanel(v25);
	v3.GUI.HidePanel(v26);
	v3.GUI.HidePanel(v27);
	v3.GUI.HidePanel(v28);
	v3.GUI.HidePanel(v29);
	v3.GUI.HidePanel(v30);
	v3.GUI.HidePanel(v31);
	v3.GUI.HidePanel(v9);
	v3.GUI.ShowPanel(v17);
	v3.GUI.ShowPanel(v18);
	v3.GUI.ShowPanel(v19);
	v3.GUI.ShowPanel(v20);
	v3.GUI.ShowPanel(v21);
end;
v10.APL.Warlock.Affliction.Display = function()
	v3.GUI.HidePanel(v17);
	v3.GUI.HidePanel(v18);
	v3.GUI.HidePanel(v19);
	v3.GUI.HidePanel(v20);
	v3.GUI.HidePanel(v21);
	v3.GUI.HidePanel(v27);
	v3.GUI.HidePanel(v28);
	v3.GUI.HidePanel(v29);
	v3.GUI.HidePanel(v30);
	v3.GUI.HidePanel(v31);
	v3.GUI.HidePanel(v9);
	v3.GUI.ShowPanel(v22);
	v3.GUI.ShowPanel(v23);
	v3.GUI.ShowPanel(v24);
	v3.GUI.ShowPanel(v25);
	v3.GUI.ShowPanel(v26);
end;
v10.APL.Warlock.Destruction.Display = function()
	v3.GUI.HidePanel(v22);
	v3.GUI.HidePanel(v23);
	v3.GUI.HidePanel(v24);
	v3.GUI.HidePanel(v25);
	v3.GUI.HidePanel(v26);
	v3.GUI.HidePanel(v17);
	v3.GUI.HidePanel(v18);
	v3.GUI.HidePanel(v19);
	v3.GUI.HidePanel(v20);
	v3.GUI.HidePanel(v21);
	v3.GUI.HidePanel(v9);
	v3.GUI.ShowPanel(v27);
	v3.GUI.ShowPanel(v28);
	v3.GUI.ShowPanel(v29);
	v3.GUI.ShowPanel(v30);
	v3.GUI.ShowPanel(v31);
end;
