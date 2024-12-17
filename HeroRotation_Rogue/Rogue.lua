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
v9.Rogue.Commons = {AncestralCall=v9(858975 - 584237),ArcanePulse=v9(745117 - 484753),ArcaneTorrent=v9(48346 - 23300),BagofTricks=v9(804738 - 492327),Berserking=v9(26916 - (555 + 64)),BloodFury=v9(21503 - (857 + 74)),Fireblood=v9(265789 - (367 + 201)),LightsJudgment=v9(256574 - (214 + 713)),Shadowmeld=v9(14765 + 44219),CloakofShadows=v9(4911 + 26313),CrimsonVial=v9(186188 - (282 + 595)),Evasion=v9(6914 - (1523 + 114)),Feint=v9(1767 + 199),Blind=v9(2985 - 891),CheapShot=v9(2898 - (68 + 997)),ClearTheWitnessesBuff=v9(458449 - (226 + 1044)),Kick=v9(7689 - 5923),KidneyShot=v9(525 - (32 + 85)),PickPocket=v9(903 + 18),Sap=v9(1502 + 5268),Shiv=v9(6895 - (892 + 65)),SliceandDice=v9(752625 - 437129),Shadowstep=v9(67567 - 31013),Sprint=v9(5475 - 2492),TricksoftheTrade=v9(58284 - (87 + 263)),Alacrity=v9(193719 - (67 + 113)),ColdBlood=v9(280290 + 101955),CoupDeGrace=v9(1084632 - 642856),DeeperStratagem=v9(142333 + 51198),DeathStalkersMark=v9(1816547 - 1359495),DeathStalkersMarkDebuff=v9(458081 - (802 + 150)),EchoingReprimand=v9(1038208 - 652592),EchoingReprimand2=v9(586922 - 263364),EchoingReprimand3=v9(235516 + 88043),EchoingReprimand4=v9(324557 - (915 + 82)),EchoingReprimand5=v9(1004750 - 649912),EscalatingBlade=v9(257361 + 184425),EdgeCase=v9(596360 - 142903),FindWeakness=v9(92210 - (1069 + 118)),FindWeaknessDebuff=v9(717411 - 401191),ImprovedAmbush=v9(834783 - 453163),MarkedforDeath=v9(23925 + 113694),MomentumOfDespair=v9(812116 - 355049),Nightstalker=v9(13950 + 112),ResoundingClarity=v9(382413 - (368 + 423)),Reverberation=v9(1239259 - 844927),SealFate=v9(14208 - (10 + 8)),Sepsis=v9(1482561 - 1097153),SepsisBuff=v9(376381 - (416 + 26)),ShadowDance=v9(591689 - 406376),ShadowDanceTalent=v9(169485 + 225445),ShadowDanceBuff=v9(328091 - 142669),Subterfuge=v9(108646 - (145 + 293)),SubterfugeBuff=v9(115622 - (44 + 386)),ThistleTea=v9(383109 - (998 + 488)),UnseenBlade=v9(140149 + 300997),UnseenBladeBuff=v9(376236 + 83249),Vigor=v9(15755 - (201 + 571)),HandOfFate=v9(453674 - (116 + 1022)),DarkestNight=v9(1902854 - 1445796),DarkestNightBuff=v9(268413 + 188867),FatefulEnding=v9(1658975 - 1204547),FazedDebuff=v9(1566825 - 1125601),FlawlessForm=v9(442180 - (814 + 45)),FlawlessFormBuff=v9(1087411 - 646085),FollowTheBlood=v9(24629 + 432439),FateboundCoin=v9(160066 + 292946),FateboundCoinHeads=v9(457364 - (261 + 624)),FateboundCoinTails=v9(804203 - 351665),FateboundLuckyCoin=v9(462898 - (1020 + 60)),Stealth=v9(3207 - (630 + 793)),Stealth2=v9(390343 - 275152),Vanish=v9(8787 - 6931),VanishBuff=v9(4461 + 6866),VanishBuff2=v9(396614 - 281421),WithoutATrace=v9(384260 - (760 + 987)),PoolEnergy=v9(1001823 - (1789 + 124))};
v9.Rogue.Assassination = v12(v9.Rogue.Commons, {Ambush=v9(9442 - (745 + 21)),AmbushOverride=v9(147914 + 282109),AmplifyingPoison=v9(1050204 - 668540),AmplifyingPoisonDebuff=v9(1503947 - 1120533),AmplifyingPoisonDebuffDeathmark=v9(3224 + 391104),CripplingPoisonDebuff=v9(2677 + 732),DeadlyPoison=v9(3878 - (87 + 968)),DeadlyPoisonDebuff=v9(12404 - 9586),DeadlyPoisonDebuffDeathmark=v9(357757 + 36567),Envenom=v9(73795 - 41150),FanofKnives=v9(53136 - (447 + 966)),Garrote=v9(1924 - 1221),GarroteDeathmark=v9(362647 - (1703 + 114)),Mutilate=v9(2030 - (376 + 325)),PoisonedKnife=v9(304102 - 118537),Rupture=v9(5978 - 4035),RuptureDeathmark=v9(103116 + 257710),WoundPoison=v9(19115 - 10436),WoundPoisonDebuff=v9(8694 - (9 + 5)),ArterialPrecision=v9(401159 - (85 + 291)),AtrophicPoisonDebuff=v9(393653 - (243 + 1022)),BlindsideBuff=v9(461008 - 339855),CausticSpatter=v9(348115 + 73860),CausticSpatterDebuff=v9(423156 - (1123 + 57)),CrimsonTempest=v9(98786 + 22625),CutToTheChase=v9(51921 - (163 + 91)),DashingScoundrel=v9(383727 - (1869 + 61)),Deathmark=v9(100629 + 259565),Doomblade=v9(1344257 - 962584),DragonTemperedBlades=v9(586427 - 204626),Elusiveness=v9(10812 + 68196),EdgeCase=v9(623162 - 169705),ImprovedGarrote=v9(358456 + 23176),ImprovedGarroteBuff=v9(393875 - (1329 + 145)),ImprovedGarroteAura=v9(393374 - (140 + 831)),IndiscriminateCarnage=v9(383652 - (1409 + 441)),IndiscriminateCarnageAura=v9(386472 - (15 + 703)),IndiscriminateCarnageBuff=v9(178642 + 207105),InternalBleeding=v9(155391 - (262 + 176)),Kingsbane=v9(387348 - (345 + 1376)),LightweightShiv=v9(395671 - (198 + 490)),MasterAssassin=v9(1130949 - 874960),MasterAssassinBuff=v9(615828 - 359093),PreyontheWeak=v9(132717 - (696 + 510)),PreyontheWeakDebuff=v9(536714 - 280805),ScentOfBlood=v9(383061 - (1091 + 171)),ScentOfBloodBuff=v9(63416 + 330664),SerratedBoneSpike=v9(1213445 - 828021),SerratedBoneSpikeDebuff=v9(1306754 - 912718),ShivDebuff=v9(319878 - (123 + 251)),ShroudedSuffocation=v9(1915421 - 1529943),ThrownPrecision=v9(382327 - (208 + 490)),VenomRush=v9(12840 + 139312),ViciousVenoms=v9(169998 + 211636)});
v9.Rogue.Outlaw = v12(v9.Rogue.Commons, {AdrenalineRush=v9(14586 - (660 + 176)),Ambush=v9(1043 + 7633),AmbushOverride=v9(430225 - (14 + 188)),BetweentheEyes=v9(316016 - (534 + 141)),BladeFlurry=v9(5579 + 8298),Dispatch=v9(1856 + 242),Elusiveness=v9(75962 + 3046),Opportunity=v9(411118 - 215491),PistolShot=v9(294920 - 109157),RolltheBones=v9(885013 - 569505),SinisterStrike=v9(103806 + 89509),Audacity=v9(243126 + 138719),AudacityBuff=v9(386666 - (115 + 281)),BladeRush=v9(632395 - 360518),CountTheOdds=v9(316259 + 65723),Crackshot=v9(1023985 - 600282),DeftManeuvers=v9(1400270 - 1018392),FanTheHammer=v9(382713 - (550 + 317)),GhostlyStrike=v9(284530 - 87593),GreenskinsWickers=v9(543707 - 156884),GreenskinsWickersBuff=v9(1101391 - 707260),HiddenOpportunity=v9(383566 - (134 + 151)),DoubleJeoPardy=v9(456095 - (970 + 695)),ImprovedAdrenalineRush=v9(754558 - 359136),ImprovedBetweenTheEyes=v9(237474 - (582 + 1408)),KeepItRolling=v9(1324767 - 942778),KillingSpree=v9(65037 - 13347),LoadedDice=v9(965340 - 709170),LoadedDiceBuff=v9(257995 - (1195 + 629)),PreyontheWeak=v9(173922 - 42411),PreyontheWeakDebuff=v9(256150 - (187 + 54)),QuickDraw=v9(197718 - (162 + 618)),Ruthlessness=v9(9923 + 4238),SummarilyDispatched=v9(254421 + 127569),SwiftSlasher=v9(814666 - 432678),TakeEmBySurprise=v9(643462 - 260720),TakeEmBySurpriseBuff=v9(30174 + 355733),UnderhandedUpperhand=v9(425680 - (1373 + 263)),Weaponmaster=v9(201733 - (451 + 549)),Gouge=v9(561 + 1215),Broadside=v9(300910 - 107554),BuriedTreasure=v9(335460 - 135860),GrandMelee=v9(194742 - (746 + 638)),RuthlessPrecision=v9(72768 + 120589),SkullandCrossbones=v9(303053 - 103450),TrueBearing=v9(193700 - (218 + 123)),ViciousFollowup=v9(396460 - (1535 + 46))});
v9.Rogue.Subtlety = v12(v9.Rogue.Commons, {Backstab=v9(53 + 0),BlackPowder=v9(46186 + 272989),Elusiveness=v9(79568 - (306 + 254)),Eviscerate=v9(12185 + 184634),Rupture=v9(3812 - 1869),ShadowBlades=v9(122938 - (899 + 568)),Shadowstrike=v9(121889 + 63549),ShurikenStorm=v9(478741 - 280906),ShurikenToss=v9(114617 - (268 + 335)),SymbolsofDeath=v9(212573 - (60 + 230)),DanseMacabre=v9(383100 - (426 + 146)),DanseMacabreBuff=v9(47195 + 346774),DeeperDaggers=v9(383973 - (282 + 1174)),DeeperDaggersBuff=v9(384216 - (569 + 242)),DarkBrew=v9(1101838 - 719334),DarkShadow=v9(14050 + 231637),EnvelopingShadows=v9(239128 - (706 + 318)),Finality=v9(383776 - (721 + 530)),FinalityBlackPowderBuff=v9(387219 - (945 + 326)),FinalityEviscerateBuff=v9(964223 - 578274),FinalityRuptureBuff=v9(343427 + 42524),Flagellation=v9(385331 - (271 + 429)),FlagellationPersistBuff=v9(362626 + 32132),Gloomblade=v9(202258 - (1408 + 92)),GoremawsBite=v9(427677 - (461 + 625)),ImprovedBackstab=v9(321237 - (993 + 295)),ImprovedShadowDance=v9(20458 + 373514),ImprovedShurikenStorm=v9(321122 - (418 + 753)),InvigoratingShadowdust=v9(145685 + 236838),LingeringShadow=v9(39424 + 343100),LingeringShadowBuff=v9(112887 + 273073),MasterofShadows=v9(49781 + 147195),PerforatedVeins=v9(383047 - (406 + 123)),PerforatedVeinsBuff=v9(396023 - (1749 + 20)),PreyontheWeak=v9(31238 + 100273),PreyontheWeakDebuff=v9(257231 - (1249 + 73)),Premeditation=v9(122429 + 220731),PremeditationBuff=v9(344318 - (466 + 679)),ReplicatingShadows=v9(920106 - 537600),SecretStratagem=v9(1127828 - 733508),SecretTechnique=v9(282619 - (106 + 1794)),Shadowcraft=v9(134955 + 291639),ShadowFocus=v9(27353 + 80856),ShurikenTornado=v9(820546 - 542621),SilentStorm=v9(1044512 - 658790),SilentStormBuff=v9(385841 - (4 + 110)),TheFirstDance=v9(383089 - (57 + 527)),TheRotten=v9(383442 - (41 + 1386)),TheRottenBuff=v9(394306 - (17 + 86)),Weaponmaster=v9(131355 + 62182),DoubleDance=v9(880739 - 485809)});
if not v11.Rogue then
	v11.Rogue = {};
end
v11.Rogue.Assassination = {AlgetharPuzzleBox=v11(560947 - 367246, {(22 - 9),(12 + 2)}),AshesoftheEmbersoul=v11(29961 + 177206, {(78 - (30 + 35)),(1271 - (1043 + 214))}),WitherbarksBranch=v11(415868 - 305869, {(34 - 21),(334 - (53 + 267))}),ManicGrieftorch=v11(43899 + 150409, {(995 - (18 + 964)),(9 + 5)}),ImperfectAscendancySerum=v11(142171 + 83483, {(11 + 2),(2 + 12)}),TreacherousTransmitter=v11(221761 - (542 + 196), {(4 + 9),(6 + 8)}),MadQueensMandate=v11(559835 - 347381, {(1564 - (1126 + 425)),(54 - 40)})};
v11.Rogue.Outlaw = {ImperfectAscendancySerum=v11(226775 - (118 + 1003), {(390 - (142 + 235)),(4 + 10)}),MadQueensMandate=v11(213431 - (553 + 424), {(12 + 1),(9 + 5)})};
v11.Rogue.Subtlety = {ImperfectAscendancySerum=v11(95924 + 129730, {(27 - 14),(31 - 17)}),TreacherousTransmitter=v11(64272 + 156751, {(766 - (239 + 514)),(1343 - (797 + 532))})};
local v28 = v9.Rogue.Commons;
v17.StealthSpell = function()
	return (v28.Subterfuge:IsAvailable() and v28.Stealth2) or v28.Stealth;
end;
v17.VanishBuffSpell = function()
	return (v28.Subterfuge:IsAvailable() and v28.VanishBuff2) or v28.VanishBuff;
end;
v17.TTDCheck = function(v38, v39, v40)
	return v39 or v14.ISSolo() or v14.Buggedmobs[v7:NPCID()] or (v38 == (0 + 0)) or ((v40 >= v38) and (v40 < (2624 + 5153)));
end;
v17.CastWithTTD = function(v41, v42, v43, v44, v45)
	if (v44 or v14.ISSolo() or v14.Buggedmobs[v7:NPCID()] or (v43 == (0 - 0)) or ((v45 >= v43) and (v45 < (8979 - (373 + 829))))) then
		v13.Cast(v41, v42);
		return "TTD cast " .. v41:Name();
	end
end;
v17.Stealth = function(v46, v47)
	if (v13.ToggleIconFrame:GetToggle(732 - (476 + 255)) and v46:IsCastable() and v6:StealthDown()) then
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
		v13.TopPanelAlternative:ChangeIcon(1131 - (369 + 761), 2 + 1);
		return "Auto tab to target";
	end
end;
do
	local v48 = v14.converArrayToList({(833413 - 393618)});
	local function v49()
		if v20.Defense.FeintDanger then
			local v97 = v6:GetEnemiesInRange(278 - (64 + 174));
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
		if (v20.Commons.Enabled["Tricks of Trade Focus"] and v14.TargetIsValid() and ((v3.CombatTime() < (3 + 17)) or not v6:AffectingCombat()) and v28.TricksoftheTrade:IsCastable() and v28.TricksoftheTrade:IsUsable() and v5.Focus:Exists() and (v5.Focus:Role() == "TANK") and v5.Focus:IsSpellInRange(v28.Shadowstep) and v5.Focus:UnitIsFriend() and not v5.Focus:IsDeadOrGhost()) then
			v5.Focus:Cast(v28.TricksoftheTrade, true);
			return "Tricks of Trade on Focus (Defensives)";
		end
		return false;
	end;
end
do
	local v51 = v9(5046 - 1638);
	local v52 = v9(3159 - (144 + 192));
	local v53 = v9(315800 - (42 + 174));
	local v54 = v9(286719 + 94945);
	local v55 = v9(4773 + 988);
	local v56 = v9(3688 + 4991);
	local v57 = v9(383141 - (363 + 1141));
	local v58 = 1580 - (1183 + 397);
	local v59 = false;
	local function v60(v89)
		v58 = v6:BuffRemains(v89);
		if ((v58 < ((v6:AffectingCombat() and (365 - 245)) or (220 + 80))) and not v6:IsCasting() and (v89:CooldownRemains(true) == (0 + 0))) then
			v13.Cast(v89);
			return "Cast " .. v89:Name();
		end
	end
	v17.Poisons = function()
		local v90 = (v6:AffectingCombat() and (2095 - (1913 + 62))) or (189 + 111);
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
			return (2 - 1) + ((1933.05 - (565 + 1368)) * v64.Nightstalker:TalentRank());
		end
		return 3 - 2;
	end
	local function v67()
		if (v64.ImprovedGarrote:IsAvailable() and (v6:BuffUp(v64.ImprovedGarroteAura, nil, true) or v6:BuffUp(v64.ImprovedGarroteBuff, nil, true) or v6:BuffUp(v64.SepsisBuff, nil, true))) then
			return 1662.5 - (1477 + 184);
		end
		return 1 - 0;
	end
	v64.Rupture:RegisterPMultiplier(v66, {v65.FinalityRuptureBuff,(1.3 - 0)});
	v64.Garrote:RegisterPMultiplier(v66, v67);
	v64.CrimsonTempest:RegisterPMultiplier(v66);
end
do
	local v68 = v9(583334 - 389803);
	local v69 = v9(394625 - (244 + 60));
	local v70 = v9(303198 + 91122);
	v17.CPMaxSpend = function()
		return (481 - (41 + 435)) + ((v68:IsAvailable() and (1002 - (938 + 63))) or (0 + 0)) + ((v69:IsAvailable() and (1126 - (936 + 189))) or (0 + 0)) + ((v70:IsAvailable() and (1614 - (1565 + 48))) or (0 + 0));
	end;
end
v17.CPSpend = function()
	return v15(v6:ComboPoints(), v17.CPMaxSpend());
end;
do
	v17.AnimachargedCP = function()
		if v6:BuffUp(v9.Rogue.Commons.EchoingReprimand2) then
			return 1140 - (782 + 356);
		elseif v6:BuffUp(v9.Rogue.Commons.EchoingReprimand3) then
			return 270 - (176 + 91);
		elseif v6:BuffUp(v9.Rogue.Commons.EchoingReprimand4) then
			return 10 - 6;
		elseif v6:BuffUp(v9.Rogue.Commons.EchoingReprimand5) then
			return 7 - 2;
		end
		return -(1093 - (975 + 117));
	end;
	v17.EffectiveComboPoints = function(v93)
		if (((v93 == (1877 - (157 + 1718))) and v6:BuffUp(v9.Rogue.Commons.EchoingReprimand2)) or ((v93 == (3 + 0)) and v6:BuffUp(v9.Rogue.Commons.EchoingReprimand3)) or ((v93 == (14 - 10)) and v6:BuffUp(v9.Rogue.Commons.EchoingReprimand4)) or ((v93 == (17 - 12)) and v6:BuffUp(v9.Rogue.Commons.EchoingReprimand5))) then
			return 1025 - (697 + 321);
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
	local v85 = 0 - 0;
	v17.PoisonedBleeds = function()
		v85 = 0 - 0;
		for v95, v96 in v16(v6:GetEnemiesInRange(115 - 65)) do
			if v17.Poisoned(v96) then
				if v96:DebuffUp(v80) then
					v85 = v85 + 1 + 0;
					if v96:DebuffUp(v81) then
						v85 = v85 + (1 - 0);
					end
				end
				if v96:DebuffUp(v82) then
					v85 = v85 + (2 - 1);
					if v96:DebuffUp(v83) then
						v85 = v85 + (1228 - (322 + 905));
					end
				end
				if v96:DebuffUp(v84) then
					v85 = v85 + (612 - (602 + 9));
				end
			end
		end
		return v85;
	end;
end
