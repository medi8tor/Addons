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
v9.Rogue.Commons = {AncestralCall=v9(858975 - 584237),ArcanePulse=v9(745117 - 484753),ArcaneTorrent=v9(48346 - 23300),BagofTricks=v9(804738 - 492327),Berserking=v9(26916 - (555 + 64)),BloodFury=v9(21503 - (857 + 74)),Fireblood=v9(265789 - (367 + 201)),LightsJudgment=v9(256574 - (214 + 713)),Shadowmeld=v9(14765 + 44219),CloakofShadows=v9(4911 + 26313),CrimsonVial=v9(186188 - (282 + 595)),Evasion=v9(6914 - (1523 + 114)),Feint=v9(1767 + 199),Blind=v9(2985 - 891),CheapShot=v9(2898 - (68 + 997)),ClearTheWitnessesBuff=v9(458449 - (226 + 1044)),Kick=v9(7689 - 5923),KidneyShot=v9(525 - (32 + 85)),PickPocket=v9(903 + 18),Sap=v9(1502 + 5268),Shiv=v9(6895 - (892 + 65)),SliceandDice=v9(752625 - 437129),Shadowstep=v9(67567 - 31013),Sprint=v9(5475 - 2492),TricksoftheTrade=v9(58284 - (87 + 263)),Alacrity=v9(193719 - (67 + 113)),ColdBlood=v9(280290 + 101955),CoupDeGrace=v9(1084632 - 642856),DeeperStratagem=v9(142333 + 51198),DeathStalkersMark=v9(1816547 - 1359495),DeathStalkersMarkDebuff=v9(458081 - (802 + 150)),EchoingReprimand=v9(1038208 - 652592),EchoingReprimand2=v9(586922 - 263364),EchoingReprimand3=v9(235516 + 88043),EchoingReprimand4=v9(324557 - (915 + 82)),EchoingReprimand5=v9(1004750 - 649912),EscalatingBlade=v9(257361 + 184425),EdgeCase=v9(596360 - 142903),FindWeakness=v9(92210 - (1069 + 118)),FindWeaknessDebuff=v9(717411 - 401191),FateboundInevitability=v9(994061 - 539627),ImprovedAmbush=v9(66344 + 315276),MarkedforDeath=v9(244520 - 106901),MomentumOfDespair=v9(453411 + 3656),Nightstalker=v9(14853 - (368 + 423)),ResoundingClarity=v9(1199315 - 817693),Reverberation=v9(394350 - (10 + 8)),SealFate=v9(54585 - 40395),Sepsis=v9(385850 - (416 + 26)),SepsisBuff=v9(1200342 - 824403),ShadowDance=v9(79528 + 105785),ShadowDanceTalent=v9(698802 - 303872),ShadowDanceBuff=v9(185860 - (145 + 293)),Subterfuge=v9(108638 - (44 + 386)),SubterfugeBuff=v9(116678 - (998 + 488)),ThistleTea=v9(121239 + 260384),UnseenBlade=v9(361220 + 79926),UnseenBladeBuff=v9(460257 - (201 + 571)),Vigor=v9(16121 - (116 + 1022)),HandOfFate=v9(1884028 - 1431492),DarkestNight=v9(268282 + 188776),DarkestNightBuff=v9(1669387 - 1212107),FatefulEnding=v9(1613713 - 1159285),FazedDebuff=v9(442083 - (814 + 45)),FlawlessForm=v9(1087399 - 646078),FlawlessFormBuff=v9(23781 + 417545),FollowTheBlood=v9(161499 + 295569),FateboundCoin=v9(453897 - (261 + 624)),FateboundCoinHeads=v9(811206 - 354727),FateboundCoinTails=v9(453618 - (1020 + 60)),FateboundLuckyCoin=v9(463241 - (630 + 793)),Stealth=v9(6045 - 4261),Stealth2=v9(545401 - 430210),Vanish=v9(731 + 1125),VanishBuff=v9(38999 - 27672),VanishBuff2=v9(116940 - (760 + 987)),WithoutATrace=v9(384426 - (1789 + 124)),PoolEnergy=v9(1000676 - (745 + 21))};
v9.Rogue.Assassination = v12(v9.Rogue.Commons, {Ambush=v9(2985 + 5691),AmbushOverride=v9(1183270 - 753247),AmplifyingPoison=v9(1497082 - 1115418),AmplifyingPoisonDebuff=v9(3135 + 380279),AmplifyingPoisonDebuffDeathmark=v9(309596 + 84732),CripplingPoisonDebuff=v9(4464 - (87 + 968)),DeadlyPoison=v9(12426 - 9603),DeadlyPoisonDebuff=v9(2557 + 261),DeadlyPoisonDebuffDeathmark=v9(891388 - 497064),Envenom=v9(34058 - (447 + 966)),FanofKnives=v9(141599 - 89876),Garrote=v9(2520 - (1703 + 114)),GarroteDeathmark=v9(361531 - (376 + 325)),Mutilate=v9(2177 - 848),PoisonedKnife=v9(570979 - 385414),Rupture=v9(556 + 1387),RuptureDeathmark=v9(794713 - 433887),WoundPoison=v9(8693 - (9 + 5)),WoundPoisonDebuff=v9(9056 - (85 + 291)),ArterialPrecision=v9(402048 - (243 + 1022)),AtrophicPoisonDebuff=v9(1493106 - 1100718),BlindsideBuff=v9(99947 + 21206),CausticSpatter=v9(423155 - (1123 + 57)),CausticSpatterDebuff=v9(343339 + 78637),CrimsonTempest=v9(121665 - (163 + 91)),CutToTheChase=v9(53597 - (1869 + 61)),DashingScoundrel=v9(106664 + 275133),Deathmark=v9(1268608 - 908414),Doomblade=v9(586231 - 204558),DragonTemperedBlades=v9(52245 + 329556),Elusiveness=v9(108576 - 29568),EdgeCase=v9(425920 + 27537),ImprovedGarrote=v9(383106 - (1329 + 145)),ImprovedGarroteBuff=v9(393372 - (140 + 831)),ImprovedGarroteAura=v9(394253 - (1409 + 441)),IndiscriminateCarnage=v9(382520 - (15 + 703)),IndiscriminateCarnageAura=v9(178645 + 207109),IndiscriminateCarnageBuff=v9(386185 - (262 + 176)),InternalBleeding=v9(156674 - (345 + 1376)),Kingsbane=v9(386315 - (198 + 490)),LightweightShiv=v9(1745019 - 1350036),MasterAssassin=v9(614038 - 358049),MasterAssassinBuff=v9(257941 - (696 + 510)),PreyontheWeak=v9(275816 - 144305),PreyontheWeakDebuff=v9(257171 - (1091 + 171)),ScentOfBlood=v9(61440 + 320359),ScentOfBloodBuff=v9(1240697 - 846617),SerratedBoneSpike=v9(1278194 - 892770),SerratedBoneSpikeDebuff=v9(394410 - (123 + 251)),ShivDebuff=v9(1587599 - 1268095),ShroudedSuffocation=v9(386176 - (208 + 490)),ThrownPrecision=v9(32204 + 349425),VenomRush=v9(67776 + 84376),ViciousVenoms=v9(382470 - (660 + 176))});
v9.Rogue.Outlaw = v12(v9.Rogue.Commons, {AdrenalineRush=v9(1652 + 12098),Ambush=v9(8878 - (14 + 188)),AmbushOverride=v9(430698 - (534 + 141)),BetweentheEyes=v9(126773 + 188568),BladeFlurry=v9(12275 + 1602),Dispatch=v9(2018 + 80),Elusiveness=v9(166038 - 87030),Opportunity=v9(310580 - 114953),PistolShot=v9(521073 - 335310),RolltheBones=v9(169420 + 146088),SinisterStrike=v9(123087 + 70228),Audacity=v9(382241 - (115 + 281)),AudacityBuff=v9(898478 - 512208),BladeRush=v9(225099 + 46778),CountTheOdds=v9(923156 - 541174),Crackshot=v9(1553634 - 1129931),DeftManeuvers=v9(382745 - (550 + 317)),FanTheHammer=v9(551684 - 169838),GhostlyStrike=v9(276809 - 79872),GreenskinsWickers=v9(1080969 - 694146),GreenskinsWickersBuff=v9(394416 - (134 + 151)),HiddenOpportunity=v9(384946 - (970 + 695)),DoubleJeoPardy=v9(867160 - 412730),ImprovedAdrenalineRush=v9(397412 - (582 + 1408)),ImprovedBetweenTheEyes=v9(816676 - 581192),KeepItRolling=v9(480626 - 98637),KillingSpree=v9(194786 - 143096),LoadedDice=v9(257994 - (1195 + 629)),LoadedDiceBuff=v9(338785 - 82614),PreyontheWeak=v9(131752 - (187 + 54)),PreyontheWeakDebuff=v9(256689 - (162 + 618)),QuickDraw=v9(137994 + 58944),Ruthlessness=v9(9432 + 4729),SummarilyDispatched=v9(814670 - 432680),SwiftSlasher=v9(642194 - 260206),TakeEmBySurprise=v9(29927 + 352815),TakeEmBySurpriseBuff=v9(387543 - (1373 + 263)),UnderhandedUpperhand=v9(425044 - (451 + 549)),Weaponmaster=v9(63364 + 137369),Gouge=v9(2763 - 987),Broadside=v9(324965 - 131609),BuriedTreasure=v9(200984 - (746 + 638)),GrandMelee=v9(72768 + 120590),RuthlessPrecision=v9(293569 - 100212),SkullandCrossbones=v9(199944 - (218 + 123)),TrueBearing=v9(194940 - (1535 + 46)),ViciousFollowup=v9(392352 + 2527)});
v9.Rogue.Subtlety = v12(v9.Rogue.Commons, {Backstab=v9(8 + 45),BlackPowder=v9(319735 - (306 + 254)),Elusiveness=v9(4892 + 74116),Eviscerate=v9(386265 - 189446),Rupture=v9(3410 - (899 + 568)),ShadowBlades=v9(79843 + 41628),Shadowstrike=v9(448742 - 263304),ShurikenStorm=v9(198438 - (268 + 335)),ShurikenToss=v9(114304 - (60 + 230)),SymbolsofDeath=v9(212855 - (426 + 146)),DanseMacabre=v9(45825 + 336703),DanseMacabreBuff=v9(395425 - (282 + 1174)),DeeperDaggers=v9(383328 - (569 + 242)),DeeperDaggersBuff=v9(1104434 - 721029),DarkBrew=v9(21874 + 360630),DarkShadow=v9(246711 - (706 + 318)),EnvelopingShadows=v9(239355 - (721 + 530)),Finality=v9(383796 - (945 + 326)),FinalityBlackPowderBuff=v9(964221 - 578273),FinalityEviscerateBuff=v9(343425 + 42524),FinalityRuptureBuff=v9(386651 - (271 + 429)),Flagellation=v9(353323 + 31308),FlagellationPersistBuff=v9(396258 - (1408 + 92)),Gloomblade=v9(201844 - (461 + 625)),GoremawsBite=v9(427879 - (993 + 295)),ImprovedBackstab=v9(16614 + 303335),ImprovedShadowDance=v9(395143 - (418 + 753)),ImprovedShurikenStorm=v9(121855 + 198096),InvigoratingShadowdust=v9(39424 + 343099),LingeringShadow=v9(111882 + 270642),LingeringShadowBuff=v9(97543 + 288417),MasterofShadows=v9(197505 - (406 + 123)),PerforatedVeins=v9(384287 - (1749 + 20)),PerforatedVeinsBuff=v9(93646 + 300608),PreyontheWeak=v9(132833 - (1249 + 73)),PreyontheWeakDebuff=v9(91300 + 164609),Premeditation=v9(344305 - (466 + 679)),PremeditationBuff=v9(825491 - 482318),ReplicatingShadows=v9(1094038 - 711532),SecretStratagem=v9(396220 - (106 + 1794)),SecretTechnique=v9(88807 + 191912),Shadowcraft=v9(107834 + 318760),ShadowFocus=v9(319476 - 211267),ShurikenTornado=v9(752604 - 474679),SilentStorm=v9(385836 - (4 + 110)),SilentStormBuff=v9(386311 - (57 + 527)),TheFirstDance=v9(383932 - (41 + 1386)),TheRotten=v9(382118 - (17 + 86)),TheRottenBuff=v9(267548 + 126655),Weaponmaster=v9(431609 - 238072),DoubleDance=v9(1143695 - 748765)});
if not v11.Rogue then
	v11.Rogue = {};
end
v11.Rogue.Assassination = {AlgetharPuzzleBox=v11(193867 - (122 + 44), {(43 - 30),(3 + 11)}),AshesoftheEmbersoul=v11(419690 - 212523, {(9 + 4),(52 - 38)}),WitherbarksBranch=v11(111211 - (323 + 889), {(593 - (361 + 219)),(4 + 10)}),ManicGrieftorch=v11(194721 - (15 + 398), {(48 - 35),(9 + 5)}),ImperfectAscendancySerum=v11(226504 - (20 + 830), {(139 - (116 + 10)),(752 - (542 + 196))}),TreacherousTransmitter=v11(473808 - 252785, {(7 + 6),(36 - 22)}),MadQueensMandate=v11(544687 - 332233, {(418 - (118 + 287)),(1135 - (118 + 1003))})};
v11.Rogue.Outlaw = {ImperfectAscendancySerum=v11(660360 - 434706, {(58 - 45),(991 - (553 + 424))}),MadQueensMandate=v11(401741 - 189287, {(13 + 0),(6 + 8)})};
v11.Rogue.Subtlety = {ImperfectAscendancySerum=v11(128865 + 96789, {(35 - 22),(5 + 9)}),TreacherousTransmitter=v11(1068128 - 847105, {(5 + 8),(11 + 3)})};
local v28 = v9.Rogue.Commons;
v17.StealthSpell = function()
	return (v28.Subterfuge:IsAvailable() and v28.Stealth2) or v28.Stealth;
end;
v17.VanishBuffSpell = function()
	return (v28.Subterfuge:IsAvailable() and v28.VanishBuff2) or v28.VanishBuff;
end;
v17.TTDCheck = function(v38, v39, v40)
	return v39 or v14.ISSolo() or v14.Buggedmobs[v7:NPCID()] or (v38 == (0 + 0)) or ((v40 >= v38) and (v40 < (18285 - 10508)));
end;
v17.CastWithTTD = function(v41, v42, v43, v44, v45)
	if (v44 or v14.ISSolo() or v14.Buggedmobs[v7:NPCID()] or (v43 == (1202 - (373 + 829))) or ((v45 >= v43) and (v45 < (8508 - (476 + 255))))) then
		v13.Cast(v41, v42);
		return "TTD cast " .. v41:Name();
	end
end;
v17.Stealth = function(v46, v47)
	if (v13.ToggleIconFrame:GetToggle(1131 - (369 + 761)) and v46:IsCastable() and v6:StealthDown()) then
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
		v13.TopPanelAlternative:ChangeIcon(1 + 0, 5 - 2);
		return "Auto tab to target";
	end
end;
do
	local v48 = v14.converArrayToList({(440033 - (64 + 174))});
	local function v49()
		if v20.Defense.FeintDanger then
			local v97 = v6:GetEnemiesInRange(6 + 34);
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
		if (v20.Commons.Enabled["Tricks of Trade Focus"] and v14.TargetIsValid() and ((v3.CombatTime() < (29 - 9)) or not v6:AffectingCombat()) and v28.TricksoftheTrade:IsCastable() and v28.TricksoftheTrade:IsUsable() and v5.Focus:Exists() and (v5.Focus:Role() == "TANK") and v5.Focus:IsSpellInRange(v28.Shadowstep) and v5.Focus:UnitIsFriend() and not v5.Focus:IsDeadOrGhost()) then
			v5.Focus:Cast(v28.TricksoftheTrade, true);
			return "Tricks of Trade on Focus (Defensives)";
		end
		return false;
	end;
end
do
	local v51 = v9(3744 - (144 + 192));
	local v52 = v9(3039 - (42 + 174));
	local v53 = v9(237078 + 78506);
	local v54 = v9(316160 + 65504);
	local v55 = v9(2448 + 3313);
	local v56 = v9(10183 - (363 + 1141));
	local v57 = v9(383217 - (1183 + 397));
	local v58 = 0 - 0;
	local v59 = false;
	local function v60(v89)
		v58 = v6:BuffRemains(v89);
		if ((v58 < ((v6:AffectingCombat() and (88 + 32)) or (225 + 75))) and not v6:IsCasting() and (v89:CooldownRemains(true) == (1975 - (1913 + 62)))) then
			v13.Cast(v89);
			return "Cast " .. v89:Name();
		end
	end
	v17.Poisons = function()
		local v90 = (v6:AffectingCombat() and (76 + 44)) or (794 - 494);
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
			return (1934 - (565 + 1368)) + ((0.05 - 0) * v64.Nightstalker:TalentRank());
		end
		return 1662 - (1477 + 184);
	end
	local function v67()
		if (v64.ImprovedGarrote:IsAvailable() and (v6:BuffUp(v64.ImprovedGarroteAura, nil, true) or v6:BuffUp(v64.ImprovedGarroteBuff, nil, true) or v6:BuffUp(v64.SepsisBuff, nil, true))) then
			return 1.5 - 0;
		end
		return 1 + 0;
	end
	v64.Rupture:RegisterPMultiplier(v66, {v65.FinalityRuptureBuff,(2.3 - 1)});
	v64.Garrote:RegisterPMultiplier(v66, v67);
	v64.CrimsonTempest:RegisterPMultiplier(v66);
end
do
	local v68 = v9(193835 - (244 + 60));
	local v69 = v9(303198 + 91123);
	local v70 = v9(394796 - (41 + 435));
	v17.CPMaxSpend = function()
		return (1006 - (938 + 63)) + ((v68:IsAvailable() and (1 + 0)) or (1125 - (936 + 189))) + ((v69:IsAvailable() and (1 + 0)) or (1613 - (1565 + 48))) + ((v70:IsAvailable() and (1 + 0)) or (1138 - (782 + 356)));
	end;
end
v17.CPSpend = function()
	return v15(v6:ComboPoints(), v17.CPMaxSpend());
end;
do
	v17.AnimachargedCP = function()
		if v6:BuffUp(v9.Rogue.Commons.EchoingReprimand2) then
			return 269 - (176 + 91);
		elseif v6:BuffUp(v9.Rogue.Commons.EchoingReprimand3) then
			return 7 - 4;
		elseif v6:BuffUp(v9.Rogue.Commons.EchoingReprimand4) then
			return 5 - 1;
		elseif v6:BuffUp(v9.Rogue.Commons.EchoingReprimand5) then
			return 1097 - (975 + 117);
		end
		return -(1876 - (157 + 1718));
	end;
	v17.EffectiveComboPoints = function(v93)
		if (((v93 == (2 + 0)) and v6:BuffUp(v9.Rogue.Commons.EchoingReprimand2)) or ((v93 == (10 - 7)) and v6:BuffUp(v9.Rogue.Commons.EchoingReprimand3)) or ((v93 == (13 - 9)) and v6:BuffUp(v9.Rogue.Commons.EchoingReprimand4)) or ((v93 == (1023 - (697 + 321))) and v6:BuffUp(v9.Rogue.Commons.EchoingReprimand5))) then
			return 18 - 11;
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
		for v95, v96 in v16(v6:GetEnemiesInRange(20 + 30)) do
			if v17.Poisoned(v96) then
				if v96:DebuffUp(v80) then
					v85 = v85 + (1 - 0);
					if v96:DebuffUp(v81) then
						v85 = v85 + (2 - 1);
					end
				end
				if v96:DebuffUp(v82) then
					v85 = v85 + (1228 - (322 + 905));
					if v96:DebuffUp(v83) then
						v85 = v85 + (612 - (602 + 9));
					end
				end
				if v96:DebuffUp(v84) then
					v85 = v85 + (1190 - (449 + 740));
				end
			end
		end
		return v85;
	end;
end
