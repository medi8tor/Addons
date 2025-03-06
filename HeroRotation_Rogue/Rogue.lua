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
v9.Rogue.Commons = {AncestralCall=v9(858975 - 584237),ArcanePulse=v9(745117 - 484753),ArcaneTorrent=v9(48346 - 23300),BagofTricks=v9(804738 - 492327),Berserking=v9(26916 - (555 + 64)),BloodFury=v9(21503 - (857 + 74)),Fireblood=v9(265789 - (367 + 201)),LightsJudgment=v9(256574 - (214 + 713)),Shadowmeld=v9(14765 + 44219),CloakofShadows=v9(4911 + 26313),CrimsonVial=v9(186188 - (282 + 595)),Evasion=v9(6914 - (1523 + 114)),Feint=v9(1767 + 199),Blind=v9(2985 - 891),CheapShot=v9(2898 - (68 + 997)),ClearTheWitnessesBuff=v9(458449 - (226 + 1044)),Kick=v9(7689 - 5923),KidneyShot=v9(525 - (32 + 85)),PickPocket=v9(903 + 18),Sap=v9(1502 + 5268),Shiv=v9(6895 - (892 + 65)),SliceandDice=v9(752625 - 437129),Shadowstep=v9(67567 - 31013),Sprint=v9(5475 - 2492),TricksoftheTrade=v9(58284 - (87 + 263)),Alacrity=v9(193719 - (67 + 113)),ColdBlood=v9(280290 + 101955),CoupDeGrace=v9(1084632 - 642856),DeeperStratagem=v9(142333 + 51198),DeathStalkersMark=v9(1816547 - 1359495),DeathStalkersMarkDebuff=v9(458081 - (802 + 150)),EchoingReprimand=v9(1038208 - 652592),EchoingReprimand2=v9(586922 - 263364),EchoingReprimand3=v9(235516 + 88043),EchoingReprimand4=v9(324557 - (915 + 82)),EchoingReprimand5=v9(1004750 - 649912),EscalatingBlade=v9(257361 + 184425),EdgeCase=v9(596360 - 142903),FindWeakness=v9(92210 - (1069 + 118)),FindWeaknessDebuff=v9(717411 - 401191),FateboundInevitability=v9(994061 - 539627),ImprovedAmbush=v9(66344 + 315276),MarkedforDeath=v9(244520 - 106901),MomentumOfDespair=v9(453411 + 3656),Nightstalker=v9(14853 - (368 + 423)),ResoundingClarity=v9(1199315 - 817693),Reverberation=v9(394350 - (10 + 8)),SealFate=v9(54585 - 40395),Sepsis=v9(385850 - (416 + 26)),SepsisBuff=v9(1200342 - 824403),ShadowDance=v9(79528 + 105785),ShadowDanceTalent=v9(698802 - 303872),ShadowDanceBuff=v9(185860 - (145 + 293)),Subterfuge=v9(108638 - (44 + 386)),SubterfugeBuff=v9(116678 - (998 + 488)),ThistleTea=v9(121239 + 260384),UnseenBlade=v9(361220 + 79926),UnseenBladeBuff=v9(460257 - (201 + 571)),Vigor=v9(16121 - (116 + 1022)),HandOfFate=v9(1884028 - 1431492),DarkestNight=v9(268282 + 188776),DarkestNightBuff=v9(1669387 - 1212107),LingeringDarkness=v9(1623046 - 1165990),LingeringDarknessBuff=v9(458132 - (814 + 45)),FatefulEnding=v9(1119694 - 665266),FazedDebuff=v9(23776 + 417448),FlawlessForm=v9(155935 + 285386),FlawlessFormBuff=v9(442211 - (261 + 624)),FollowTheBlood=v9(812253 - 355185),FateboundCoin=v9(454092 - (1020 + 60)),FateboundCoinHeads=v9(457902 - (630 + 793)),FateboundCoinTails=v9(1533500 - 1080962),FateboundLuckyCoin=v9(2186596 - 1724778),Stealth=v9(703 + 1081),Stealth2=v9(396607 - 281416),Vanish=v9(3603 - (760 + 987)),VanishBuff=v9(13240 - (1789 + 124)),VanishBuff2=v9(115959 - (745 + 21)),WithoutATrace=v9(131572 + 250941),PoolEnergy=v9(2751398 - 1751488)};
v9.Rogue.Assassination = v12(v9.Rogue.Commons, {Ambush=v9(34031 - 25355),AmbushOverride=v9(3516 + 426507),AmplifyingPoison=v9(299653 + 82011),AmplifyingPoisonDebuff=v9(384469 - (87 + 968)),AmplifyingPoisonDebuffDeathmark=v9(1735809 - 1341481),CripplingPoisonDebuff=v9(3093 + 316),DeadlyPoison=v9(6381 - 3558),DeadlyPoisonDebuff=v9(4231 - (447 + 966)),DeadlyPoisonDebuffDeathmark=v9(1079521 - 685197),Envenom=v9(34462 - (1703 + 114)),FanofKnives=v9(52424 - (376 + 325)),Garrote=v9(1151 - 448),GarroteDeathmark=v9(1110265 - 749435),Mutilate=v9(380 + 949),PoisonedKnife=v9(408703 - 223138),Rupture=v9(1957 - (9 + 5)),RuptureDeathmark=v9(361202 - (85 + 291)),WoundPoison=v9(9944 - (243 + 1022)),WoundPoisonDebuff=v9(33028 - 24348),ArterialPrecision=v9(330632 + 70151),AtrophicPoisonDebuff=v9(393568 - (1123 + 57)),BlindsideBuff=v9(98576 + 22577),CausticSpatter=v9(422229 - (163 + 91)),CausticSpatterDebuff=v9(423906 - (1869 + 61)),CrimsonTempest=v9(33919 + 87492),CutToTheChase=v9(181971 - 130304),DashingScoundrel=v9(586421 - 204624),Deathmark=v9(49289 + 310905),Doomblade=v9(524512 - 142839),DragonTemperedBlades=v9(358615 + 23186),Elusiveness=v9(80482 - (1329 + 145)),EdgeCase=v9(454428 - (140 + 831)),ImprovedGarrote=v9(383482 - (1409 + 441)),ImprovedGarroteBuff=v9(393119 - (15 + 703)),ImprovedGarroteAura=v9(181724 + 210679),IndiscriminateCarnage=v9(382240 - (262 + 176)),IndiscriminateCarnageAura=v9(387475 - (345 + 1376)),IndiscriminateCarnageBuff=v9(386435 - (198 + 490)),InternalBleeding=v9(684576 - 529623),Kingsbane=v9(925000 - 539373),LightweightShiv=v9(396189 - (696 + 510)),MasterAssassin=v9(536881 - 280892),MasterAssassinBuff=v9(257997 - (1091 + 171)),PreyontheWeak=v9(21163 + 110348),PreyontheWeakDebuff=v9(805688 - 549779),ScentOfBlood=v9(1266172 - 884373),ScentOfBloodBuff=v9(394454 - (123 + 251)),SerratedBoneSpike=v9(1915153 - 1529729),SerratedBoneSpikeDebuff=v9(394734 - (208 + 490)),ShivDebuff=v9(26962 + 292542),ShroudedSuffocation=v9(171710 + 213768),ThrownPrecision=v9(382465 - (660 + 176)),VenomRush=v9(18281 + 133871),ViciousVenoms=v9(381836 - (14 + 188))});
v9.Rogue.Outlaw = v12(v9.Rogue.Commons, {AdrenalineRush=v9(14425 - (534 + 141)),Ambush=v9(3488 + 5188),AmbushOverride=v9(380374 + 49649),BetweentheEyes=v9(303183 + 12158),BladeFlurry=v9(29162 - 15285),Dispatch=v9(3330 - 1232),Elusiveness=v9(221620 - 142612),Opportunity=v9(105047 + 90580),PistolShot=v9(118278 + 67485),RolltheBones=v9(315904 - (115 + 281)),SinisterStrike=v9(449657 - 256342),Audacity=v9(316146 + 65699),AudacityBuff=v9(933519 - 547249),BladeRush=v9(996918 - 725041),CountTheOdds=v9(382849 - (550 + 317)),Crackshot=v9(612157 - 188454),DeftManeuvers=v9(536757 - 154879),FanTheHammer=v9(1067060 - 685214),GhostlyStrike=v9(197222 - (134 + 151)),GreenskinsWickers=v9(388488 - (970 + 695)),GreenskinsWickersBuff=v9(752095 - 357964),HiddenOpportunity=v9(385271 - (582 + 1408)),DoubleJeoPardy=v9(1575998 - 1121568),ImprovedAdrenalineRush=v9(497528 - 102106),ImprovedBetweenTheEyes=v9(887387 - 651903),KeepItRolling=v9(383813 - (1195 + 629)),KillingSpree=v9(68359 - 16669),LoadedDice=v9(256411 - (187 + 54)),LoadedDiceBuff=v9(256951 - (162 + 618)),PreyontheWeak=v9(92150 + 39361),PreyontheWeakDebuff=v9(170446 + 85463),QuickDraw=v9(420009 - 223071),Ruthlessness=v9(23807 - 9646),SummarilyDispatched=v9(29868 + 352122),SwiftSlasher=v9(383624 - (1373 + 263)),TakeEmBySurprise=v9(383742 - (451 + 549)),TakeEmBySurpriseBuff=v9(121816 + 264091),UnderhandedUpperhand=v9(659918 - 235874),Weaponmaster=v9(337364 - 136631),Gouge=v9(3160 - (746 + 638)),Broadside=v9(72768 + 120588),BuriedTreasure=v9(303049 - 103449),GrandMelee=v9(193699 - (218 + 123)),RuthlessPrecision=v9(194938 - (1535 + 46)),SkullandCrossbones=v9(198326 + 1277),TrueBearing=v9(27980 + 165379),ViciousFollowup=v9(395439 - (306 + 254))});
v9.Rogue.Subtlety = v12(v9.Rogue.Commons, {Backstab=v9(4 + 49),BlackPowder=v9(626394 - 307219),Elusiveness=v9(80475 - (899 + 568)),Eviscerate=v9(129370 + 67449),Rupture=v9(4701 - 2758),ShadowBlades=v9(122074 - (268 + 335)),Shadowstrike=v9(185728 - (60 + 230)),ShurikenStorm=v9(198407 - (426 + 146)),ShurikenToss=v9(13659 + 100355),SymbolsofDeath=v9(213739 - (282 + 1174)),DanseMacabre=v9(383339 - (569 + 242)),DeathPerception=v9(1352848 - 883206),DanseMacabreBuff=v9(22530 + 371439),DeeperDaggers=v9(383541 - (706 + 318)),DeeperDaggersBuff=v9(384656 - (721 + 530)),DarkBrew=v9(383775 - (945 + 326)),DarkShadow=v9(613803 - 368116),EnvelopingShadows=v9(211870 + 26234),Finality=v9(383225 - (271 + 429)),FinalityBlackPowderBuff=v9(354533 + 31415),FinalityEviscerateBuff=v9(387449 - (1408 + 92)),FinalityRuptureBuff=v9(387037 - (461 + 625)),Flagellation=v9(385919 - (993 + 295)),FlagellationBuff=v9(19973 + 364658),FlagellationPersistBuff=v9(395929 - (418 + 753)),Gloomblade=v9(76460 + 124298),GoremawsBite=v9(43965 + 382626),ImprovedBackstab=v9(93580 + 226369),ImprovedShadowDance=v9(99567 + 294405),ImprovedShurikenStorm=v9(320480 - (406 + 123)),InvigoratingShadowdust=v9(384292 - (1749 + 20)),LingeringShadow=v9(90860 + 291664),LingeringShadowBuff=v9(387282 - (1249 + 73)),MasterofShadows=v9(70275 + 126701),PerforatedVeins=v9(383663 - (466 + 679)),PerforatedVeinsBuff=v9(948366 - 554112),PreyontheWeak=v9(376145 - 244634),PreyontheWeakDebuff=v9(257809 - (106 + 1794)),Premeditation=v9(108560 + 234600),PremeditationBuff=v9(86747 + 256426),ReplicatingShadows=v9(1129311 - 746805),SecretStratagem=v9(1067795 - 673475),SecretTechnique=v9(280833 - (4 + 110)),Shadowcraft=v9(427178 - (57 + 527)),ShadowFocus=v9(109636 - (41 + 1386)),ShurikenTornado=v9(278028 - (17 + 86)),SilentStorm=v9(261791 + 123931),SilentStormBuff=v9(860214 - 474487),TheFirstDance=v9(1107713 - 725208),TheRotten=v9(382181 - (122 + 44)),TheRottenBuff=v9(680919 - 286716),Weaponmaster=v9(642053 - 448516),DoubleDance=v9(321270 + 73660)});
if not v11.Rogue then
	v11.Rogue = {};
end
v11.Rogue.Assassination = {AlgetharPuzzleBox=v11(28014 + 165687, {(78 - (30 + 35)),(1271 - (1043 + 214))}),AshesoftheEmbersoul=v11(783227 - 576060, {(34 - 21),(334 - (53 + 267))}),WitherbarksBranch=v11(24851 + 85148, {(995 - (18 + 964)),(9 + 5)}),ManicGrieftorch=v11(122422 + 71886, {(11 + 2),(2 + 12)}),ImperfectAscendancySerum=v11(226392 - (542 + 196), {(4 + 9),(6 + 8)}),TreacherousTransmitter=v11(582415 - 361392, {(1564 - (1126 + 425)),(54 - 40)}),MadQueensMandate=v11(213575 - (118 + 1003), {(390 - (142 + 235)),(4 + 10)})};
v11.Rogue.Outlaw = {ImperfectAscendancySerum=v11(226631 - (553 + 424), {(12 + 1),(9 + 5)}),MadQueensMandate=v11(90313 + 122141, {(27 - 14),(31 - 17)})};
v11.Rogue.Subtlety = {AlgetharPuzzleBox=v11(56327 + 137374, {(766 - (239 + 514)),(1343 - (797 + 532))}),AshesoftheEmbersoul=v11(150531 + 56636, {(29 - 16),(745 - (476 + 255))}),BottledFlayedwingToxin=v11(179872 - (369 + 761), {(23 - 10),(252 - (64 + 174))}),ImperfectAscendancySerum=v11(32139 + 193515, {(349 - (144 + 192)),(11 + 3)}),MadQueensMandate=v11(175991 + 36463, {(1517 - (363 + 1141)),(42 - 28)}),TreacherousTransmitter=v11(162020 + 59003, {(1988 - (1913 + 62)),(36 - 22)}),WitherbarksBranch=v11(111932 - (565 + 1368), {(1674 - (1477 + 184)),(14 + 0)})};
local v28 = v9.Rogue.Commons;
v17.StealthSpell = function()
	return (v28.Subterfuge:IsAvailable() and v28.Stealth2) or v28.Stealth;
end;
v17.VanishBuffSpell = function()
	return (v28.Subterfuge:IsAvailable() and v28.VanishBuff2) or v28.VanishBuff;
end;
v17.TTDCheck = function(v38, v39, v40)
	return v39 or v14.ISSolo() or v14.Buggedmobs[v7:NPCID()] or (v38 == (856 - (564 + 292))) or ((v40 >= v38) and (v40 < (13418 - 5641)));
end;
v17.CastWithTTD = function(v41, v42, v43, v44, v45)
	if (v44 or v14.ISSolo() or v14.Buggedmobs[v7:NPCID()] or (v43 == (0 - 0)) or ((v45 >= v43) and (v45 < (8081 - (244 + 60))))) then
		v13.Cast(v41, v42);
		return "TTD cast " .. v41:Name();
	end
end;
v17.Stealth = function(v46, v47)
	if (v13.ToggleIconFrame:GetToggle(1 + 0) and v46:IsCastable() and v6:StealthDown()) then
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
		v13.TopPanelAlternative:ChangeIcon(477 - (41 + 435), 1004 - (938 + 63));
		return "Auto tab to target";
	end
end;
do
	local v48 = v14.converArrayToList({(440920 - (936 + 189))});
	local function v49()
		if v20.Defense.FeintDanger then
			local v97 = v6:GetEnemiesInRange(14 + 26);
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
		if (v20.Commons.Enabled["Tricks of Trade Focus"] and v14.TargetIsValid() and ((v3.CombatTime() < (1633 - (1565 + 48))) or not v6:AffectingCombat()) and v28.TricksoftheTrade:IsCastable() and v28.TricksoftheTrade:IsUsable() and v5.Focus:Exists() and (v5.Focus:Role() == "TANK") and v5.Focus:IsSpellInRange(v28.Shadowstep) and v5.Focus:UnitIsFriend() and not v5.Focus:IsDeadOrGhost()) then
			v5.Focus:Cast(v28.TricksoftheTrade, true);
			return "Tricks of Trade on Focus (Defensives)";
		end
		return false;
	end;
end
do
	local v51 = v9(2106 + 1302);
	local v52 = v9(3961 - (782 + 356));
	local v53 = v9(315851 - (176 + 91));
	local v54 = v9(994360 - 612696);
	local v55 = v9(8490 - 2729);
	local v56 = v9(9771 - (975 + 117));
	local v57 = v9(383512 - (157 + 1718));
	local v58 = 0 + 0;
	local v59 = false;
	local function v60(v89)
		v58 = v6:BuffRemains(v89);
		if ((v58 < ((v6:AffectingCombat() and (425 - 305)) or (1025 - 725))) and not v6:IsCasting() and (v89:CooldownRemains(true) == (1018 - (697 + 321)))) then
			v13.Cast(v89);
			return "Cast " .. v89:Name();
		end
	end
	v17.Poisons = function()
		local v90 = (v6:AffectingCombat() and (326 - 206)) or (635 - 335);
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
			return (2 - 1) + ((0.05 + 0) * v64.Nightstalker:TalentRank());
		end
		return 1 - 0;
	end
	local function v67()
		if (v64.ImprovedGarrote:IsAvailable() and (v6:BuffUp(v64.ImprovedGarroteAura, nil, true) or v6:BuffUp(v64.ImprovedGarroteBuff, nil, true) or v6:BuffUp(v64.SepsisBuff, nil, true))) then
			return 2.5 - 1;
		end
		return 1228 - (322 + 905);
	end
	v64.Rupture:RegisterPMultiplier(v66, {v65.FinalityRuptureBuff,(873.3 - (826 + 46))});
	v64.Garrote:RegisterPMultiplier(v66, v67);
	v64.CrimsonTempest:RegisterPMultiplier(v66);
end
do
	local v68 = v9(194478 - (245 + 702));
	local v69 = v9(1246038 - 851717);
	local v70 = v9(126762 + 267558);
	v17.CPMaxSpend = function()
		return (1903 - (260 + 1638)) + ((v68:IsAvailable() and (441 - (382 + 58))) or (0 - 0)) + ((v69:IsAvailable() and (1 + 0)) or (0 - 0)) + ((v70:IsAvailable() and (2 - 1)) or (1205 - (902 + 303)));
	end;
end
v17.CPSpend = function()
	return v15(v6:ComboPoints(), v17.CPMaxSpend());
end;
do
	v17.AnimachargedCP = function()
		if v6:BuffUp(v9.Rogue.Commons.EchoingReprimand2) then
			return 3 - 1;
		elseif v6:BuffUp(v9.Rogue.Commons.EchoingReprimand3) then
			return 6 - 3;
		elseif v6:BuffUp(v9.Rogue.Commons.EchoingReprimand4) then
			return 1 + 3;
		elseif v6:BuffUp(v9.Rogue.Commons.EchoingReprimand5) then
			return 1695 - (1121 + 569);
		end
		return -(215 - (22 + 192));
	end;
	v17.EffectiveComboPoints = function(v93)
		if (((v93 == (685 - (483 + 200))) and v6:BuffUp(v9.Rogue.Commons.EchoingReprimand2)) or ((v93 == (1466 - (1404 + 59))) and v6:BuffUp(v9.Rogue.Commons.EchoingReprimand3)) or ((v93 == (10 - 6)) and v6:BuffUp(v9.Rogue.Commons.EchoingReprimand4)) or ((v93 == (6 - 1)) and v6:BuffUp(v9.Rogue.Commons.EchoingReprimand5))) then
			return 772 - (468 + 297);
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
	local v85 = 562 - (334 + 228);
	v17.PoisonedBleeds = function()
		v85 = 0 - 0;
		for v95, v96 in v16(v6:GetEnemiesInRange(115 - 65)) do
			if v17.Poisoned(v96) then
				if v96:DebuffUp(v80) then
					v85 = v85 + (1 - 0);
					if v96:DebuffUp(v81) then
						v85 = v85 + 1 + 0;
					end
				end
				if v96:DebuffUp(v82) then
					v85 = v85 + (237 - (141 + 95));
					if v96:DebuffUp(v83) then
						v85 = v85 + 1 + 0;
					end
				end
				if v96:DebuffUp(v84) then
					v85 = v85 + (2 - 1);
				end
			end
		end
		return v85;
	end;
end
