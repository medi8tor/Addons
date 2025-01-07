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
local v14 = GetTime;
local v15 = v13.GUISettingsGet();
local v16 = v13.Commons().Everyone;
v13.Commons().Mage = {};
local v18 = v15.APL.Mage.Commons;
local v19 = v13.Commons().Mage;
if not v9.Mage then
	v9.Mage = {};
end
v9.Mage.Commons = {AncestralCall=v9(858975 - 584237),Berserking=v9(75257 - 48960),BloodFury=v9(39710 - 19138),EnergizedBarrier=v9(996429 - 609601),Fireblood=v9(265840 - (555 + 64)),LightsJudgment=v9(256578 - (857 + 74)),ArcaneExplosion=v9(2017 - (367 + 201)),ArcaneIntellect=v9(2386 - (214 + 713)),Frostbolt=v9(30 + 86),FrostNova=v9(20 + 102),SlowFall=v9(1007 - (282 + 595)),TimeWarp=v9(81990 - (1523 + 114)),GreaterInvisibility=v9(99715 + 11244),Counterspell=v9(3048 - 909),DragonsBreath=v9(32726 - (68 + 997)),IceCold=v9(415929 - (226 + 1044)),IceFloes=v9(473928 - 365089),IceNova=v9(158114 - (32 + 85)),MirrorImage=v9(54236 + 1106),Polymorph=v9(27 + 91),ShiftingPower=v9(383397 - (892 + 65)),SpellSteal=v9(72636 - 42187),RemoveCurse=v9(878 - 403),MassBarrier=v9(761245 - 346585),TemporalWarp=v9(386889 - (87 + 263)),RingOfFrost=v9(113904 - (67 + 113)),ArcaneIntellectBuff=v9(1070 + 389),KahetiShadowweaversEmblemBuff=v9(1118238 - 662774),EntangledDebuff=v9(300474 + 108082),EtherealPowerlinkBuff=v9(1788336 - 1338382),SpymastersReportBuff=v9(452151 - (802 + 150)),SpymastersWebBuff=v9(1197979 - 753020),Pool=v9(1813799 - 813889)};
v9.Mage.Frostfire = {FrostfireBolt=v9(313753 + 117291),ExcessFire=v9(439592 - (915 + 82)),ExcessFrost=v9(1241929 - 803329),IsothermicCore=v9(251133 + 179962),ExcessFireBuff=v9(576852 - 138228),ExcessFrostBuff=v9(439798 - (1069 + 118)),FrostfireEmpowermentBuff=v9(978215 - 547038)};
v9.Mage.Spellslinger = {ShiftingShards=v9(972714 - 528039),SplinteringSorcery=v9(77144 + 366595),Splinterstorm=v9(788440 - 344698),UnerringProficiency=v9(441415 + 3559),UnerringProficiencyBuff=v9(445772 - (368 + 423))};
v9.Mage.Sunfury = {SpellfireSpheres=v9(1409809 - 961208),SunfuryExecution=v9(449367 - (10 + 8)),ArcaneSoulBuff=v9(1735022 - 1283984),BurdenofPowerBuff=v9(451491 - (416 + 26)),GloriousIncandescenceBuff=v9(1440239 - 989166),SpellfireSpheresBuff=v9(192861 + 256539)};
v9.Mage.Arcane = v12(v9.Mage.Commons, {ArcaneBlast=v9(53880 - 23429),ArcaneBarrage=v9(44863 - (145 + 293)),FireBlast=v9(320266 - (44 + 386)),ArcaneBombardment=v9(386067 - (998 + 488)),ArcaneFamiliar=v9(65134 + 139888),ArcaneHarmony=v9(314798 + 69654),ArcaneMissiles=v9(5915 - (201 + 571)),ArcaneOrb=v9(154764 - (116 + 1022)),ArcaneSurge=v9(1521049 - 1155699),ArcaneTempo=v9(225387 + 158593),ArcingCleave=v9(845368 - 613804),Evocation=v9(42794 - 30743),HighVoltage=v9(462107 - (814 + 45)),Impetus=v9(945364 - 561688),ImprovedClearcasting=v9(17320 + 304100),MagisSpark=v9(160421 + 293595),PrismaticBarrier=v9(236335 - (261 + 624)),OrbBarrage=v9(683929 - 299071),PresenceofMind=v9(206105 - (1020 + 60)),Reverberate=v9(282905 - (630 + 793)),Supernova=v9(535341 - 377361),TouchoftheMagi=v9(1522257 - 1200750),AetherAttunementBuff=v9(178645 + 274956),ArcaneFamiliarBuff=v9(723472 - 513346),ArcaneHarmonyBuff=v9(386202 - (760 + 987)),ArcaneSurgeBuff=v9(367275 - (1789 + 124)),ArcaneTempoBuff=v9(384763 - (745 + 21)),ClearcastingBuff=v9(90713 + 173012),IntuitionBuff=v9(1253872 - 798191),NetherPrecisionBuff=v9(1505394 - 1121611),PresenceofMindBuff=v9(1677 + 203348),SiphonStormBuff=v9(301697 + 82570),MagisSparkABDebuff=v9(454967 - (87 + 968)),MagisSparkABarDebuff=v9(1989286 - 1537375),MagisSparkAMDebuff=v9(411806 + 42092),TouchoftheMagiDebuff=v9(476577 - 265753),StopAM=v9(365066 - (447 + 966))});
v9.Mage.Arcane = v12(v9.Mage.Arcane, v9.Mage.Spellslinger);
v9.Mage.Arcane = v12(v9.Mage.Arcane, v9.Mage.Sunfury);
v9.Mage.Fire = v12(v9.Mage.Commons, {Fireball=v9(364 - 231),Flamestrike=v9(3937 - (1703 + 114)),BlazingBarrier=v9(236014 - (376 + 325)),AlexstraszasFury=v9(386542 - 150672),CalloftheSunKing=v9(1056085 - 712863),Combustion=v9(54389 + 135930),FeeltheBurn=v9(844412 - 461021),FlameAccelerant=v9(203289 - (9 + 5)),FireBlast=v9(109229 - (85 + 291)),Firestarter=v9(206291 - (243 + 1022)),FlamePatch=v9(780202 - 575165),Hyperthermia=v9(316671 + 67189),ImprovedScorch=v9(384784 - (1123 + 57)),Kindling=v9(126236 + 28912),Meteor=v9(153815 - (163 + 91)),PhoenixFlames=v9(259471 - (1869 + 61)),PhoenixReborn=v9(126590 + 326533),Pyroblast=v9(40030 - 28664),Quickflame=v9(692417 - 241610),Scald=v9(61680 + 389066),Scorch=v9(4050 - 1102),SearingTouch=v9(253269 + 16375),SpontaneousCombustion=v9(453349 - (1329 + 145)),SunKingsBlessing=v9(384857 - (140 + 831)),CombustionBuff=v9(192169 - (1409 + 441)),FeeltheBurnBuff=v9(384113 - (15 + 703)),FlameAccelerantBuff=v9(94139 + 109138),FlamesFuryBuff=v9(410402 - (262 + 176)),HeatShimmerBuff=v9(460685 - (345 + 1376)),HeatingUpBuff=v9(48795 - (198 + 490)),HotStreakBuff=v9(212539 - 164431),HyperthermiaBuff=v9(920795 - 536921),SunKingsBlessingBuff=v9(385088 - (696 + 510)),FuryoftheSunKingBuff=v9(805112 - 421229),IgniteDebuff=v9(13916 - (1091 + 171)),ImprovedScorchDebuff=v9(61731 + 321877)});
v9.Mage.Fire = v12(v9.Mage.Fire, v9.Mage.Frostfire);
v9.Mage.Fire = v12(v9.Mage.Fire, v9.Mage.Sunfury);
v9.Mage.Frost = v12(v9.Mage.Commons, {Blizzard=v9(599305 - 408949),ConeofCold=v9(397 - 277),FireBlast=v9(320210 - (123 + 251)),IceBarrier=v9(56775 - 45349),ColdestSnap=v9(418191 - (208 + 490)),CometStorm=v9(12961 + 140634),DeathsChill=v9(200598 + 249733),Flurry=v9(45450 - (660 + 176)),FreezingRain=v9(32467 + 237766),Frostbite=v9(378958 - (14 + 188)),FrozenOrb=v9(85389 - (534 + 141)),GlacialSpike=v9(80318 + 119468),IceCaller=v9(209338 + 27324),IceLance=v9(29281 + 1174),IcyVeins=v9(26210 - 13738),RayofFrost=v9(325495 - 120474),SplinteringCold=v9(1063249 - 684200),Freeze=v9(17933 + 15462),BrainFreezeBuff=v9(121260 + 69186),DeathsChillBuff=v9(454767 - (115 + 281)),FingersofFrostBuff=v9(103610 - 59066),FreezingRainBuff=v9(223737 + 46495),FreezingWindsBuff=v9(923456 - 541350),GlacialSpikeBuff=v9(732788 - 532944),IciclesBuff=v9(206340 - (550 + 317)),IcyVeinsBuff=v9(18018 - 5546),WintersChillDebuff=v9(320973 - 92615)});
v9.Mage.Frost = v12(v9.Mage.Frost, v9.Mage.Frostfire);
v9.Mage.Frost = v12(v9.Mage.Frost, v9.Mage.Spellslinger);
if not v11.Mage then
	v11.Mage = {};
end
v11.Mage.Commons = {NymuesUnravelingSpindle=v11(582970 - 374355, {(1678 - (970 + 695)),(2004 - (582 + 1408))}),ImperfectAscendancySerum=v11(782585 - 556931, {(48 - 35),(18 - 4)}),SpymastersWeb=v11(220443 - (187 + 54), {(10 + 3),(29 - 15)}),TreacherousTransmitter=v11(371581 - 150558, {(1649 - (1373 + 263)),(5 + 9)}),KahetiShadowweaversEmblem=v11(351169 - 125518, {(1397 - (746 + 638)),(20 - 6)})};
v11.Mage.Arcane = v12(v11.Mage.Commons, {AberrantSpellforge=v11(212792 - (218 + 123), {(13 + 0),(574 - (306 + 254))}),FearbreakersEcho=v11(13896 + 210553, {(1480 - (899 + 568)),(33 - 19)}),HighSpeakersAccretion=v11(219906 - (268 + 335), {(585 - (426 + 146)),(1470 - (282 + 1174))}),MadQueensMandate=v11(213265 - (569 + 242), {(1 + 12),(1265 - (721 + 530))}),MereldarsToll=v11(220584 - (945 + 326), {(12 + 1),(13 + 1)}),QuickwickCandlestick=v11(227149 - (1408 + 92), {(1301 - (993 + 295)),(1185 - (418 + 753))}),SignetofthePriory=v11(83525 + 135783, {(4 + 9),(543 - (406 + 123))})});
v11.Mage.Fire = v12(v11.Mage.Commons, {CrimsonGladiatorsBadge=v11(203576 - (1749 + 20), {(1335 - (1249 + 73)),(1159 - (466 + 679))}),DraconicGladiatorsBadge=v11(520252 - 303973, {(1913 - (106 + 1794)),(4 + 10)}),ObsidianGladiatorsBadge=v11(607332 - 401624, {(127 - (4 + 110)),(1441 - (41 + 1386))}),VerdantGladiatorsBadge=v11(209446 - (17 + 86), {(28 - 15),(180 - (122 + 44))}),ForgedGladiatorsBadge=v11(377790 - 159077, {(11 + 2),(27 - 13)}),DragonfireBombDispenser=v11(202675 - (30 + 35), {(1270 - (1043 + 214)),(1226 - (323 + 889))}),HornofValor=v11(359716 - 226074, {(333 - (53 + 267)),(427 - (15 + 398))}),IrideusFragment=v11(194725 - (18 + 964), {(8 + 5),(864 - (20 + 830))}),MoonlitPrism=v11(107364 + 30177, {(1 + 12),(29 - 15)}),SpoilsofNeltharus=v11(56585 + 137188, {(5 + 8),(35 - 21)}),TimebreachingTalon=v11(195342 - (1126 + 425), {(50 - 37),(40 - 26)})});
v11.Mage.Frost = v12(v11.Mage.Commons, {BelorrelostheSuncaller=v11(207549 - (142 + 235), {(3 + 10),(26 - 12)}),Dreambinder=v11(183774 + 24842, {(10 + 6)})});
v19.IFST = {CurrStacks=(0 + 0),CurrStacksTime=(0 + 0),OldStacks=(0 - 0),OldStacksTime=(0 - 0),Direction=(0 - 0)};
local v32 = {};
v32.IncantersFlowBuff = v9(33810 + 82457);
v3:RegisterForEvent(function()
	v19.IFST.CurrStacks = 0 - 0;
	v19.IFST.CurrStacksTime = 753 - (239 + 514);
	v19.IFST.OldStacks = 0 + 0;
	v19.IFST.OldStacksTime = 1329 - (797 + 532);
	v19.IFST.Direction = 0 + 0;
end, "PLAYER_REGEN_ENABLED");
local v34 = {(904494 - 519808),(374703 - (476 + 255)),(224422 + 163533),(700815 - 330992),(53378 + 321400)};
v19.Precast = function()
	return v13.ToggleIconFrame:GetToggle(1 - 0);
end;
do
	local function v46(v71)
		for v78, v79 in pairs(v34) do
			if v71:BuffUp(v9(v79), true) then
				return true;
			end
		end
		return false;
	end
	v19.StealCycle = function(v72, v73, v74, v75)
		if not (v72:IsLearned() and v72:CooldownWithoutGCD() and v72:IsUsableP() and v72:IsAvailable()) then
			return nil;
		end
		local v76 = v6:GetEnemiesInRange(v73);
		local v77 = v16.CastCycle(v72, v76, v46, v73, v74, nil, v75);
		if v77 then
			return "StealCycle:" .. v77;
		end
	end;
	v19.CombatCheck = function()
		return v16.TargetIsValid() and (v7:AffectingCombat() or not v18.OnlyAttackEnnemyInCombat or (not v18.OnlyAttackEnnemyInCombatSolo and v16.ISSolo()));
	end;
	v19.IncorporealBeing = function()
		return v7:NPCID() == (204896 - (144 + 192));
	end;
	v19.GroundSpellCondition = function()
		return (v8:Exists() or not v18.GroundSpellOnlyIfMouseover) and (not v6:IsCameraBusy() or not v18.GroundSpellOnlyIfCameraFree);
	end;
	v19.AutoTarget = function()
		if (v15.General.AutoTab and v6:AffectingCombat()) then
			v13.TopPanelAlternative:ChangeIcon(217 - (42 + 174), 3 + 0);
			return "Auto tab to target";
		end
	end;
end
v19.TTDCondition = function(v52, v53, v54)
	if ((v53 and v6:IsInRaid()) or v16.Buggedmobs[v7:NPCID()] or v7:IsDummy() or v16.ISSolo() or (v52 == (0 + 0)) or ((v54 >= v52) and (v54 < (3304 + 4473)))) then
		return true;
	end
end;
v19.TTDCastTimeCondition = function(v55, v56, v57)
	if (not v18.TimeToTimeCastTime or v16.Buggedmobs[v7:NPCID()] or v7:IsDummy() or (v55:TotalTimeRequired() == (1504 - (363 + 1141))) or (v7:TimeToDie() > (1583 - (1183 + 397))) or (v7:TimeToDie() >= v55:TotalTimeRequired())) then
		return true;
	end
end;
v19.IFTracker = function()
	if (v3.CombatTime() == (0 - 0)) then
		return;
	end
	local v58 = v19.IFST.CurrStacksTime - v19.IFST.OldStacksTime;
	local v59 = v19.IFST.CurrStacks;
	local v60 = v19.IFST.CurrStacksTime;
	local v61 = v19.IFST.OldStacks;
	if (v6:BuffUp(v32.IncantersFlowBuff)) then
		if ((v6:BuffStack(v32.IncantersFlowBuff) ~= v59) or ((v6:BuffStack(v32.IncantersFlowBuff) == v59) and (v58 > (1 + 0)))) then
			v19.IFST.OldStacks = v59;
			v19.IFST.OldStacksTime = v60;
		end
		v19.IFST.CurrStacks = v6:BuffStack(v32.IncantersFlowBuff);
		v19.IFST.CurrStacksTime = v3.CombatTime();
		if (v19.IFST.CurrStacks > v19.IFST.OldStacks) then
			if (v19.IFST.CurrStacks == (4 + 1)) then
				v19.IFST.Direction = 1975 - (1913 + 62);
			else
				v19.IFST.Direction = 1 + 0;
			end
		elseif (v19.IFST.CurrStacks < v19.IFST.OldStacks) then
			if (v19.IFST.CurrStacks == (2 - 1)) then
				v19.IFST.Direction = 1933 - (565 + 1368);
			else
				v19.IFST.Direction = -(3 - 2);
			end
		elseif (v19.IFST.CurrStacks == (1662 - (1477 + 184))) then
			v19.IFST.Direction = 1 - 0;
		else
			v19.IFST.Direction = -(1 + 0);
		end
	else
		v19.IFST.OldStacks = 856 - (564 + 292);
		v19.IFST.OldStacksTime = 0 - 0;
		v19.IFST.CurrStacks = 0 - 0;
		v19.IFST.CurrStacksTime = 304 - (244 + 60);
		v19.IFST.Direction = 0 + 0;
	end
end;
v19.IFTimeToX = function(v62, v63)
	local v64;
	local v65;
	local v66;
	if ((v19.IFST.Direction == -(477 - (41 + 435))) or ((v19.IFST.Direction == (1001 - (938 + 63))) and (v19.IFST.CurrStacks == (0 + 0)))) then
		v66 = ((1135 - (936 + 189)) - v19.IFST.CurrStacks) + 1 + 0;
	else
		v66 = v19.IFST.CurrStacks;
	end
	if (v63 == "up") then
		v64 = v62;
		v65 = v62;
	elseif (v63 == "down") then
		v64 = ((1623 - (1565 + 48)) - v62) + 1 + 0;
		v65 = ((1148 - (782 + 356)) - v62) + (268 - (176 + 91));
	else
		v64 = v62;
		v65 = ((26 - 16) - v62) + (1 - 0);
	end
	if ((v64 == v66) or (v65 == v66)) then
		return 1092 - (975 + 117);
	end
	local v67 = (((1885 - (157 + 1718)) + v64) - v66) % (9 + 1);
	local v68 = (((35 - 25) + v65) - v66) % (34 - 24);
	return ((v19.IFST.CurrStacksTime - v19.IFST.OldStacksTime) + math.min(v67, v68)) - (1019 - (697 + 321));
end;
v19.RangeOOCCount = function()
	if v16.TargetIsValid() then
		local v88 = v7:MinDistance();
		v88 = (v88 and ((v88 - (21 - 13)) > (10 - 5)) and (v88 - (18 - 10))) or (2 + 3);
		local v89 = v7:MaxDistance();
		v89 = math.min(168 - 78, (v89 and ((v89 + (21 - 13)) > (1232 - (322 + 905))) and (v89 + (619 - (602 + 9)))) or (1194 - (449 + 740)));
		local v90 = v6:GetEnemiesInRange(v88);
		local v91 = v6:GetEnemiesInRange(v89);
		local v92 = (((v89 - v88) > (888 - (826 + 46))) and (#v91 - #v90)) or #v91;
		return ((v92 > (947 - (245 + 702))) and v92) or (3 - 2);
	end
	return #(v6:GetEnemiesInRange(13 + 27));
end;
