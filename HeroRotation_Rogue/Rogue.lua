local v0, v1 = ...;
local v2 = HeroDBC.DBC;
local v3 = HeroLib;
local v4 = HeroCache;
local v5 = v3.Unit;
local v6 = v5.Player;
local v7 = v5.Target;
local v8 = v5.MouseOver;
local v9 = v3.Spell;
local v10 = v3.MultiSpell;
local v11 = v3.Item;
local v12 = v3.Utils.MergeTableByKey;
local v13 = HeroRotation();
local v14 = v13.Commons().Everyone;
local v15 = math.min;
local v16 = pairs;
local v17 = {};
v13.Commons().Rogue = v17;
local v19 = v13.GUISettingsGet();
local v20 = {General=v19.General,Commons=v19.APL.Rogue.Commons,Assassination=v19.APL.Rogue.Assassination,Outlaw=v19.APL.Rogue.Outlaw,Subtlety=v19.APL.Rogue.Subtlety,Defense=v19.APL.Rogue.Defense};
if not v9.Rogue then
	v9.Rogue = {};
end
v9.Rogue.Commons = {AncestralCall=v9(858975 - 584237),ArcanePulse=v9(745117 - 484753),ArcaneTorrent=v9(48346 - 23300),MeanStreak=v9(1167983 - 714555),BagofTricks=v9(313030 - (555 + 64)),Berserking=v9(27228 - (857 + 74)),BloodFury=v9(21140 - (367 + 201)),Fireblood=v9(266148 - (214 + 713)),LightsJudgment=v9(63992 + 191655),Shadowmeld=v9(9277 + 49707),CloakofShadows=v9(32101 - (282 + 595)),CrimsonVial=v9(186948 - (1523 + 114)),Evasion=v9(4743 + 534),Feint=v9(2801 - 835),Blind=v9(3159 - (68 + 997)),CheapShot=v9(3103 - (226 + 1044)),ClearTheWitnessesBuff=v9(1990741 - 1533562),Kick=v9(1883 - (32 + 85)),KidneyShot=v9(400 + 8),PickPocket=v9(205 + 716),Sap=v9(7727 - (892 + 65)),Shiv=v9(14165 - 8227),SliceandDice=v9(583173 - 267677),Shadowstep=v9(67106 - 30552),Sprint=v9(3333 - (87 + 263)),TricksoftheTrade=v9(58114 - (67 + 113)),Alacrity=v9(141917 + 51622),ColdBlood=v9(938474 - 556229),CoupDeGrace=v9(324906 + 116870),DeeperStratagem=v9(769186 - 575655),DeathStalkersMark=v9(458004 - (802 + 150)),DeathStalkersMarkDebuff=v9(1230745 - 773616),EchoingReprimand=v9(699492 - 313876),EchoingReprimand2=v9(235515 + 88043),EchoingReprimand3=v9(324556 - (915 + 82)),EchoingReprimand4=v9(916184 - 592624),EchoingReprimand5=v9(206710 + 148128),EscalatingBlade=v9(581011 - 139225),EdgeCase=v9(454644 - (1069 + 118)),FindWeakness=v9(206504 - 115481),FindWeaknessDebuff=v9(691722 - 375502),FateboundInevitability=v9(79003 + 375431),ImprovedAmbush=v9(678062 - 296442),MarkedforDeath=v9(136519 + 1100),MomentumOfDespair=v9(457858 - (368 + 423)),Nightstalker=v9(44192 - 30130),ResoundingClarity=v9(381640 - (10 + 8)),Reverberation=v9(1516890 - 1122558),SealFate=v9(14632 - (416 + 26)),Sepsis=v9(1230576 - 845168),SepsisBuff=v9(161335 + 214604),ShadowDance=v9(327898 - 142585),ShadowDanceTalent=v9(395368 - (145 + 293)),ShadowDanceBuff=v9(185852 - (44 + 386)),Subterfuge=v9(109694 - (998 + 488)),SubterfugeBuff=v9(36596 + 78596),ThistleTea=v9(312481 + 69142),UnseenBlade=v9(441918 - (201 + 571)),UnseenBladeBuff=v9(460623 - (116 + 1022)),Vigor=v9(62378 - 47395),HandOfFate=v9(265628 + 186908),DarkestNight=v9(1668577 - 1211519),DarkestNightBuff=v9(1623841 - 1166561),LingeringDarkness=v9(457915 - (814 + 45)),LingeringDarknessBuff=v9(1126704 - 669431),FatefulEnding=v9(24487 + 429941),FazedDebuff=v9(155901 + 285323),FlawlessForm=v9(442206 - (261 + 624)),FlawlessFormBuff=v9(784279 - 342953),FollowTheBlood=v9(458148 - (1020 + 60)),FateboundCoin=v9(454435 - (630 + 793)),FateboundCoinHeads=v9(1546854 - 1090375),FateboundCoinTails=v9(2142658 - 1690120),FateboundLuckyCoin=v9(181881 + 279937),Stealth=v9(6142 - 4358),Stealth2=v9(116938 - (760 + 987)),Vanish=v9(3769 - (1789 + 124)),VanishBuff=v9(12093 - (745 + 21)),VanishBuff2=v9(39623 + 75570),WithoutATrace=v9(1052539 - 670026),PoolEnergy=v9(3922162 - 2922252)};
v9.Rogue.Assassination = v12(v9.Rogue.Commons, {Ambush=v9(71 + 8605),AmbushOverride=v9(337621 + 92402),AmplifyingPoison=v9(382719 - (87 + 968)),AmplifyingPoisonDebuff=v9(1687766 - 1304352),AmplifyingPoisonDebuffDeathmark=v9(357760 + 36568),CripplingPoisonDebuff=v9(7705 - 4296),DeadlyPoison=v9(4236 - (447 + 966)),DeadlyPoisonDebuff=v9(7714 - 4896),DeadlyPoisonDebuffDeathmark=v9(396141 - (1703 + 114)),Envenom=v9(33346 - (376 + 325)),FanofKnives=v9(84763 - 33040),Garrote=v9(2162 - 1459),GarroteDeathmark=v9(103117 + 257713),Mutilate=v9(2926 - 1597),PoisonedKnife=v9(185579 - (9 + 5)),Rupture=v9(2319 - (85 + 291)),RuptureDeathmark=v9(362091 - (243 + 1022)),WoundPoison=v9(33024 - 24345),WoundPoisonDebuff=v9(7161 + 1519),ArterialPrecision=v9(401963 - (1123 + 57)),AtrophicPoisonDebuff=v9(319264 + 73124),BlindsideBuff=v9(121407 - (163 + 91)),CausticSpatter=v9(423905 - (1869 + 61)),CausticSpatterDebuff=v9(117889 + 304087),CrimsonTempest=v9(427611 - 306200),CutToTheChase=v9(79357 - 27690),DashingScoundrel=v9(52245 + 329552),Deathmark=v9(494995 - 134801),Doomblade=v9(358495 + 23178),DragonTemperedBlades=v9(383275 - (1329 + 145)),Elusiveness=v9(79979 - (140 + 831)),EdgeCase=v9(455307 - (1409 + 441)),ImprovedGarrote=v9(382350 - (15 + 703)),ImprovedGarroteBuff=v9(181723 + 210678),ImprovedGarroteAura=v9(392841 - (262 + 176)),IndiscriminateCarnage=v9(383523 - (345 + 1376)),IndiscriminateCarnageAura=v9(386442 - (198 + 490)),IndiscriminateCarnageBuff=v9(1704214 - 1318467),InternalBleeding=v9(371684 - 216731),Kingsbane=v9(386833 - (696 + 510)),LightweightShiv=v9(828392 - 433409),MasterAssassin=v9(257251 - (1091 + 171)),MasterAssassinBuff=v9(41315 + 215420),PreyontheWeak=v9(414041 - 282530),PreyontheWeakDebuff=v9(848679 - 592770),ScentOfBlood=v9(382173 - (123 + 251)),ScentOfBloodBuff=v9(1958164 - 1564084),SerratedBoneSpike=v9(386122 - (208 + 490)),SerratedBoneSpikeDebuff=v9(33251 + 360785),ShivDebuff=v9(142322 + 177182),ShroudedSuffocation=v9(386314 - (660 + 176)),ThrownPrecision=v9(45851 + 335778),VenomRush=v9(152354 - (14 + 188)),ViciousVenoms=v9(382309 - (534 + 141))});
v9.Rogue.Outlaw = v12(v9.Rogue.Commons, {Stealthcast=v9(718 + 1066),AdrenalineRush=v9(12163 + 1587),Ambush=v9(8342 + 334),AmbushOverride=v9(903712 - 473689),BetweentheEyes=v9(500641 - 185300),BladeFlurry=v9(38925 - 25048),Dispatch=v9(1127 + 971),Elusiveness=v9(50306 + 28702),Opportunity=v9(196023 - (115 + 281)),PistolShot=v9(432091 - 246328),RolltheBones=v9(261223 + 54285),SinisterStrike=v9(467194 - 273879),Audacity=v9(1400149 - 1018304),AudacityBuff=v9(387137 - (550 + 317)),BladeRush=v9(392802 - 120925),CountTheOdds=v9(536903 - 154921),Crackshot=v9(1184029 - 760326),DeftManeuvers=v9(382163 - (134 + 151)),FanTheHammer=v9(383511 - (970 + 695)),GhostlyStrike=v9(375801 - 178864),GreenskinsWickers=v9(388813 - (582 + 1408)),GreenskinsWickersBuff=v9(1366876 - 972745),HiddenOpportunity=v9(482252 - 98971),DoubleJeoPardy=v9(1712454 - 1258024),ImprovedAdrenalineRush=v9(397246 - (1195 + 629)),ImprovedBetweenTheEyes=v9(311426 - 75942),KeepItRolling=v9(382230 - (187 + 54)),KillingSpree=v9(52470 - (162 + 618)),LoadedDice=v9(179498 + 76672),LoadedDiceBuff=v9(170621 + 85550),PreyontheWeak=v9(280473 - 148962),PreyontheWeakDebuff=v9(430231 - 174322),QuickDraw=v9(15399 + 181539),Ruthlessness=v9(15797 - (1373 + 263)),SummarilyDispatched=v9(382990 - (451 + 549)),SwiftSlasher=v9(120579 + 261409),TakeEmBySurprise=v9(595642 - 212900),TakeEmBySurpriseBuff=v9(648578 - 262671),UnderhandedUpperhand=v9(425428 - (746 + 638)),Weaponmaster=v9(75544 + 125189),Gouge=v9(2696 - 920),Broadside=v9(193697 - (218 + 123)),BuriedTreasure=v9(201181 - (1535 + 46)),GrandMelee=v9(192121 + 1237),RuthlessPrecision=v9(27980 + 165377),SkullandCrossbones=v9(200163 - (306 + 254)),TrueBearing=v9(11971 + 181388),ViciousFollowup=v9(774966 - 380087),Dreadblades=v9(344609 - (899 + 568)),Supercharger=v9(309159 + 161188)});
v9.Rogue.Subtlety = v12(v9.Rogue.Commons, {Backstab=v9(128 - 75),BlackPowder=v9(319778 - (268 + 335)),Elusiveness=v9(79298 - (60 + 230)),Eviscerate=v9(197391 - (426 + 146)),Rupture=v9(233 + 1710),ShadowBlades=v9(122927 - (282 + 1174)),Shadowstrike=v9(186249 - (569 + 242)),ShurikenStorm=v9(569882 - 372047),ShurikenToss=v9(6521 + 107493),SymbolsofDeath=v9(213307 - (706 + 318)),DanseMacabre=v9(383779 - (721 + 530)),DeathPerception=v9(470913 - (945 + 326)),DanseMacabreBuff=v9(984259 - 590290),DeeperDaggers=v9(340371 + 42146),DeeperDaggersBuff=v9(384105 - (271 + 429)),DarkBrew=v9(351370 + 31134),DarkShadow=v9(247187 - (1408 + 92)),EnvelopingShadows=v9(239190 - (461 + 625)),Finality=v9(383813 - (993 + 295)),FinalityBlackPowderBuff=v9(20041 + 365907),FinalityEviscerateBuff=v9(387120 - (418 + 753)),FinalityRuptureBuff=v9(146991 + 238960),Flagellation=v9(39641 + 344990),FlagellationBuff=v9(112499 + 272132),FlagellationPersistBuff=v9(99766 + 294992),Gloomblade=v9(201287 - (406 + 123)),GoremawsBite=v9(428360 - (1749 + 20)),ImprovedBackstab=v9(75997 + 243952),ImprovedShadowDance=v9(395294 - (1249 + 73)),ImprovedShurikenStorm=v9(114149 + 205802),InvigoratingShadowdust=v9(383668 - (466 + 679)),LingeringShadow=v9(920149 - 537625),LingeringShadowBuff=v9(1103917 - 717957),MasterofShadows=v9(198876 - (106 + 1794)),PerforatedVeins=v9(121011 + 261507),PerforatedVeinsBuff=v9(99660 + 294594),PreyontheWeak=v9(388273 - 256762),PreyontheWeakDebuff=v9(692986 - 437077),Premeditation=v9(343274 - (4 + 110)),PremeditationBuff=v9(343757 - (57 + 527)),ReplicatingShadows=v9(383933 - (41 + 1386)),SecretStratagem=v9(394423 - (17 + 86)),SecretTechnique=v9(190526 + 90193),Shadowcraft=v9(951353 - 524759),ShadowFocus=v9(313367 - 205158),ShurikenTornado=v9(278091 - (122 + 44)),SilentStorm=v9(666269 - 280547),SilentStormBuff=v9(1279637 - 893910),TheFirstDance=v9(311162 + 71343),TheRotten=v9(55248 + 326767),TheRottenBuff=v9(798598 - 404395),Weaponmaster=v9(193602 - (30 + 35)),DoubleDance=v9(271440 + 123490)});
if not v11.Rogue then
	v11.Rogue = {};
end
v11.Rogue.Assassination = {AlgetharPuzzleBox=v11(194958 - (1043 + 214), {(1225 - (323 + 889)),(594 - (361 + 219))}),AshesoftheEmbersoul=v11(207487 - (53 + 267), {(426 - (15 + 398)),(52 - 38)}),WitherbarksBranch=v11(63686 + 46313, {(863 - (20 + 830)),(140 - (116 + 10))}),ManicGrieftorch=v11(14353 + 179955, {(27 - 14),(8 + 6)}),ImperfectAscendancySerum=v11(81228 + 144426, {(33 - 20),(419 - (118 + 287))}),TreacherousTransmitter=v11(866253 - 645230, {(38 - 25),(63 - 49)}),MadQueensMandate=v11(46228 + 166226, {(23 - 10),(14 + 0)})};
v11.Rogue.Outlaw = {JunkmaestrosMegaMagnet=v11(134029 + 96160, {(8 + 5),(38 - 24)}),AlgetharPuzzleBox=v11(433704 - 240003, {(62 - 49),(5 + 9)}),AshesoftheEmbersoul=v11(208496 - (797 + 532), {(5 + 8),(1216 - (373 + 829))}),BottledFlayedwingToxin=v11(179473 - (476 + 255), {(8 + 5),(26 - 12)}),ImperfectAscendancySerum=v11(225892 - (64 + 174), {(18 - 5),(230 - (42 + 174))}),MadQueensMandate=v11(159603 + 52851, {(6 + 7),(1594 - (1183 + 397))}),TreacherousTransmitter=v11(672869 - 451846, {(10 + 3),(9 + 5)}),WitherbarksBranch=v11(291200 - 181201, {(48 - 35),(18 - 4)}),ScrollOfMomentum=v11(211079 + 15460, {(21 - 8),(318 - (244 + 60))})};
v11.Rogue.Subtlety = {AlgetharPuzzleBox=v11(148939 + 44762, {(1014 - (938 + 63)),(1139 - (936 + 189))}),AshesoftheEmbersoul=v11(68179 + 138988, {(9 + 4),(281 - (176 + 91))}),BottledFlayedwingToxin=v11(465681 - 286939, {(1105 - (975 + 117)),(12 + 2)}),ImperfectAscendancySerum=v11(801054 - 575400, {(1031 - (697 + 321)),(29 - 15)}),MadQueensMandate=v11(489787 - 277333, {(23 - 10),(1241 - (322 + 905))}),TreacherousTransmitter=v11(221634 - (602 + 9), {(885 - (826 + 46)),(43 - 29)}),WitherbarksBranch=v11(35362 + 74637, {(453 - (382 + 58)),(12 + 2)})};
local v28 = v9.Rogue.Commons;
v17.StealthSpell = function()
	return (v28.Subterfuge:IsAvailable() and v28.Stealth2) or v28.Stealth;
end;
v17.VanishBuffSpell = function()
	return (v28.Subterfuge:IsAvailable() and v28.VanishBuff2) or v28.VanishBuff;
end;
v17.TTDCheck = function(v38, v39, v40)
	return v39 or v14.ISSolo() or v14.Buggedmobs[v7:NPCID()] or (v38 == (0 - 0)) or ((v40 >= v38) and (v40 < (23117 - 15340)));
end;
v17.CastWithTTD = function(v41, v42, v43, v44, v45)
	if (v44 or v14.ISSolo() or v14.Buggedmobs[v7:NPCID()] or (v43 == (1205 - (902 + 303))) or ((v45 >= v43) and (v45 < (17075 - 9298)))) then
		v13.Cast(v41, v42);
		return "TTD cast " .. v41:Name();
	end
end;
v17.Stealth = function(v46, v47)
	if (v13.ToggleIconFrame:GetToggle(2 - 1) and v46:IsCastable() and v6:StealthDown()) then
		if v13.Cast(v28.Stealth) then
			return "Cast Stealth (OOC)";
		end
	end
	return false;
end;
v17.CombatCheck = function()
	return v14.TargetIsValid() and (v7:AffectingCombat() or not v20.Commons.OnlyAttackEnnemyInCombat or (not v20.Commons.OnlyAttackEnnemyInCombatSolo and v14.ISSolo()));
end;
v17.AutoTarget = function()
	if (v19.General.AutoTab and v6:AffectingCombat()) then
		v13.TopPanelAlternative:ChangeIcon(1 + 0, 1693 - (1121 + 569));
		return "Auto tab to target";
	end
end;
do
	local v48 = v14.converArrayToList({(440478 - (483 + 200))});
	local function v49()
		if v20.Defense.FeintDanger then
			local v97 = v6:GetEnemiesInRange(1503 - (1404 + 59));
			for v98, v99 in v16(v97) do
				if v48[v99:CastSpellID() or v99:ChannelSpellID()] then
					return true;
				end
			end
		end
	end
	v17.Defense = function()
		if (v28.CrimsonVial:IsCastable() and (v6:HealthPercentage() <= v20.Defense.CrimsonVialHP)) then
			v13.Cast(v28.CrimsonVial);
			return "Cast Crimson Vial (Defensives)";
		end
		if (v28.Evasion:IsCastable() and (v6:HealthPercentage() <= v20.Defense.EvasionHP)) then
			v13.Cast(v28.Evasion, true);
			return "Cast Evasion (Defensives)";
		end
		if (v28.Feint:IsCastable() and v6:BuffDown(v28.Feint) and ((v6:HealthPercentage() <= v20.Defense.FeintHP) or v49())) then
			v13.Cast(v28.Feint);
			return "Cast Feint (Defensives)";
		end
		if (v28.CloakofShadows:IsCastable() and (v6:HealthPercentage() <= v20.Defense.CloakofShadowsHP)) then
			v13.Cast(v28.CloakofShadows, true);
			return "Cast Cloak of Shadows (Defensives)";
		end
		if (v20.Commons.Enabled["Tricks of Trade Focus"] and v14.TargetIsValid() and ((v3.CombatTime() < (54 - 34)) or not v6:AffectingCombat()) and v28.TricksoftheTrade:IsReady() and v28.TricksoftheTrade:IsUsable() and v5.Focus:Exists() and (v5.Focus:Role() == "TANK") and v5.Focus:IsSpellInRange(v28.Shadowstep) and v5.Focus:UnitIsFriend() and not v5.Focus:IsDeadOrGhost()) then
			if v13.CastTarget(v28.TricksoftheTrade, v13.TName().FOCUS) then
				return "Tricks of Trade on Focus (Defensives)";
			end
		end
		return false;
	end;
end
do
	local v51 = v9(4579 - 1171);
	local v52 = v9(3588 - (468 + 297));
	local v53 = v9(316146 - (334 + 228));
	local v54 = v9(1287347 - 905683);
	local v55 = v9(13353 - 7592);
	local v56 = v9(15740 - 7061);
	local v57 = v9(108372 + 273265);
	local v58 = 236 - (141 + 95);
	local v59 = false;
	local function v60(v89)
		v58 = v6:BuffRemains(v89);
		if ((v58 < ((v6:AffectingCombat() and (118 + 2)) or (772 - 472))) and not v6:IsCasting() and (v89:CooldownRemains(true) == (0 - 0))) then
			v13.Cast(v89);
			return "Cast " .. v89:Name();
		end
	end
	v17.Poisons = function()
		local v90 = (v6:AffectingCombat() and (29 + 91)) or (821 - 521);
		local v91;
		local v92;
		v59 = v6:BuffUp(v56);
		if v9.Rogue.Assassination.DragonTemperedBlades:IsAvailable() then
			v92 = v60((v59 and v56) or v52);
			if v92 then
				return v92;
			end
			if v54:IsAvailable() then
				v92 = v60(v54);
				if v92 then
					return v92;
				end
			else
				v92 = v60(v53);
				if v92 then
					return v92;
				end
			end
		elseif v59 then
			v92 = v60(v56);
			if v92 then
				return v92;
			end
		elseif (v54:IsAvailable() and v6:BuffDown(v52)) then
			v92 = v60(v54);
			if v92 then
				return v92;
			end
		elseif v52:IsAvailable() then
			v92 = v60(v52);
			if v92 then
				return v92;
			end
		else
			v92 = v60(v53);
			if v92 then
				return v92;
			end
		end
		if v6:BuffDown(v51) then
			if v57:IsAvailable() then
				v92 = v60(v57);
				if v92 then
					return v92;
				end
			elseif v55:IsAvailable() then
				v92 = v60(v55);
				if v92 then
					return v92;
				end
			else
				v92 = v60(v51);
				if v92 then
					return v92;
				end
			end
			if v9.Rogue.Assassination.DragonTemperedBlades:IsAvailable() then
				v92 = v60(v51);
				if v92 then
					return v92;
				end
			end
		else
			v92 = v60(v51);
			if v92 then
				return v92;
			end
		end
	end;
end
v17.CanDoTUnit = function(v62, v63)
	return v14.CanDoTUnit(v62, v63);
end;
do
	local v64 = v9.Rogue.Assassination;
	local v65 = v9.Rogue.Subtlety;
	local function v66()
		if (v64.Nightstalker:IsAvailable() and v6:StealthUp(true, false, true)) then
			return 1 + 0 + ((0.05 + 0) * v64.Nightstalker:TalentRank());
		end
		return 1 - 0;
	end
	local function v67()
		if (v64.ImprovedGarrote:IsAvailable() and (v6:BuffUp(v64.ImprovedGarroteAura, nil, true) or v6:BuffUp(v64.ImprovedGarroteBuff, nil, true) or v6:BuffUp(v64.SepsisBuff, nil, true))) then
			return 1.5 + 0;
		end
		return 164 - (92 + 71);
	end
	v64.Rupture:RegisterPMultiplier(v66, {v65.FinalityRuptureBuff,(766.3 - (574 + 191))});
	v64.Garrote:RegisterPMultiplier(v66, v67);
	v64.CrimsonTempest:RegisterPMultiplier(v66);
end
do
	local v68 = v9(159637 + 33894);
	local v69 = v9(987894 - 593573);
	local v70 = v9(201415 + 192905);
	v17.CPMaxSpend = function()
		return (854 - (254 + 595)) + ((v68:IsAvailable() and (127 - (55 + 71))) or (0 - 0)) + ((v69:IsAvailable() and (1791 - (573 + 1217))) or (0 - 0)) + ((v70:IsAvailable() and (1 + 0)) or (0 - 0));
	end;
end
v17.CPSpend = function()
	return v15(v6:ComboPoints(), v17.CPMaxSpend());
end;
do
	v17.AnimachargedCP = function()
		if v6:BuffUp(v9.Rogue.Commons.EchoingReprimand2) then
			return 941 - (714 + 225);
		elseif v6:BuffUp(v9.Rogue.Commons.EchoingReprimand3) then
			return 8 - 5;
		elseif v6:BuffUp(v9.Rogue.Commons.EchoingReprimand4) then
			return 5 - 1;
		elseif v6:BuffUp(v9.Rogue.Commons.EchoingReprimand5) then
			return 1 + 4;
		end
		return -(1 - 0);
	end;
	v17.EffectiveComboPoints = function(v93)
		if (((v93 == (808 - (118 + 688))) and v6:BuffUp(v9.Rogue.Commons.EchoingReprimand2)) or ((v93 == (51 - (25 + 23))) and v6:BuffUp(v9.Rogue.Commons.EchoingReprimand3)) or ((v93 == (1 + 3)) and v6:BuffUp(v9.Rogue.Commons.EchoingReprimand4)) or ((v93 == (1891 - (927 + 959))) and v6:BuffUp(v9.Rogue.Commons.EchoingReprimand5))) then
			return 23 - 16;
		end
		return v93;
	end;
end
do
	local v74 = v9.Rogue.Assassination.DeadlyPoisonDebuff;
	local v75 = v9.Rogue.Assassination.WoundPoisonDebuff;
	local v76 = v9.Rogue.Assassination.AmplifyingPoisonDebuff;
	local v77 = v9.Rogue.Assassination.CripplingPoisonDebuff;
	local v78 = v9.Rogue.Assassination.AtrophicPoisonDebuff;
	v17.Poisoned = function(v94)
		return ((v94:DebuffUp(v74) or v94:DebuffUp(v76) or v94:DebuffUp(v77) or v94:DebuffUp(v75) or v94:DebuffUp(v78)) and true) or false;
	end;
end
do
	local v80 = v9.Rogue.Assassination.Garrote;
	local v81 = v9.Rogue.Assassination.GarroteDeathmark;
	local v82 = v9.Rogue.Assassination.Rupture;
	local v83 = v9.Rogue.Assassination.RuptureDeathmark;
	local v84 = v9.Rogue.Assassination.InternalBleeding;
	local v85 = 732 - (16 + 716);
	v17.PoisonedBleeds = function()
		v85 = 0 - 0;
		for v95, v96 in v16(v6:GetEnemiesInRange(147 - (11 + 86))) do
			if v17.Poisoned(v96) then
				if v96:DebuffUp(v80) then
					v85 = v85 + (2 - 1);
					if v96:DebuffUp(v81) then
						v85 = v85 + (286 - (175 + 110));
					end
				end
				if v96:DebuffUp(v82) then
					v85 = v85 + (2 - 1);
					if v96:DebuffUp(v83) then
						v85 = v85 + (4 - 3);
					end
				end
				if v96:DebuffUp(v84) then
					v85 = v85 + (1797 - (503 + 1293));
				end
			end
		end
		return v85;
	end;
end
