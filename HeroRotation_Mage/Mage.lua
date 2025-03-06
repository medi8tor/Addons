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
v9.Mage.Fire = v12(v9.Mage.Commons, {Fireball=v9(364 - 231),Flamestrike=v9(3937 - (1703 + 114)),BlazingBarrier=v9(236014 - (376 + 325)),AlexstraszasFury=v9(386542 - 150672),CalloftheSunKing=v9(1056085 - 712863),Combustion=v9(54389 + 135930),FeeltheBurn=v9(844412 - 461021),Firefall=v9(384047 - (9 + 5)),FlameAccelerant=v9(203651 - (85 + 291)),FireBlast=v9(110118 - (243 + 1022)),Firestarter=v9(780160 - 575134),FlamePatch=v9(169149 + 35888),Hyperthermia=v9(385040 - (1123 + 57)),ImprovedScorch=v9(312117 + 71487),Kindling=v9(155402 - (163 + 91)),Meteor=v9(155491 - (1869 + 61)),UnleashedInferno=v9(116361 + 300145),PhoenixFlames=v9(907062 - 649521),PhoenixReborn=v9(695975 - 242852),Pyroblast=v9(1556 + 9810),Quickflame=v9(619520 - 168713),Scald=v9(423373 + 27373),Scorch=v9(4422 - (1329 + 145)),SearingTouch=v9(270615 - (140 + 831)),SpontaneousCombustion=v9(453725 - (1409 + 441)),SunKingsBlessing=v9(384604 - (15 + 703)),CombustionBuff=v9(88138 + 102181),FeeltheBurnBuff=v9(383833 - (262 + 176)),FlameAccelerantBuff=v9(204998 - (345 + 1376)),FlamesFuryBuff=v9(410652 - (198 + 490)),HeatShimmerBuff=v9(2027684 - 1568720),HeatingUpBuff=v9(115393 - 67286),HotStreakBuff=v9(49314 - (696 + 510)),HyperthermiaBuff=v9(805093 - 421219),SunKingsBlessingBuff=v9(385144 - (1091 + 171)),FuryoftheSunKingBuff=v9(61776 + 322107),IgniteDebuff=v9(39838 - 27184),ImprovedScorchDebuff=v9(1272172 - 888564)});
v9.Mage.Fire = v12(v9.Mage.Fire, v9.Mage.Frostfire);
v9.Mage.Fire = v12(v9.Mage.Fire, v9.Mage.Sunfury);
v9.Mage.Frost = v12(v9.Mage.Commons, {Blizzard=v9(190730 - (123 + 251)),ConeofCold=v9(596 - 476),FireBlast=v9(320534 - (208 + 490)),IceBarrier=v9(965 + 10461),ColdestSnap=v9(185971 + 231522),CometStorm=v9(154431 - (660 + 176)),DeathsChill=v9(54105 + 396226),Flurry=v9(44816 - (14 + 188)),FreezingRain=v9(270908 - (534 + 141)),Frostbite=v9(152267 + 226489),FrozenOrb=v9(74934 + 9780),GlacialSpike=v9(192084 + 7702),IceCaller=v9(497355 - 260693),IceLance=v9(48350 - 17895),IcyVeins=v9(34984 - 22512),RayofFrost=v9(110092 + 94929),SplinteringCold=v9(241346 + 137703),Freeze=v9(33791 - (115 + 281)),BrainFreezeBuff=v9(442984 - 252538),DeathsChillBuff=v9(376193 + 78178),FingersofFrostBuff=v9(107651 - 63107),FreezingRainBuff=v9(990886 - 720654),FreezingWindsBuff=v9(382973 - (550 + 317)),GlacialSpikeBuff=v9(288730 - 88886),IciclesBuff=v9(288807 - 83334),IcyVeinsBuff=v9(34852 - 22380),WintersChillDebuff=v9(228643 - (134 + 151))});
v9.Mage.Frost = v12(v9.Mage.Frost, v9.Mage.Frostfire);
v9.Mage.Frost = v12(v9.Mage.Frost, v9.Mage.Spellslinger);
if not v11.Mage then
	v11.Mage = {};
end
v11.Mage.Commons = {NymuesUnravelingSpindle=v11(210280 - (970 + 695), {(2003 - (582 + 1408)),(16 - 2)}),ImperfectAscendancySerum=v11(850344 - 624690, {(16 - 3),(794 - (162 + 618))}),SpymastersWeb=v11(154295 + 65907, {(27 - 14),(2 + 12)}),TreacherousTransmitter=v11(222659 - (1373 + 263), {(5 + 8),(23 - 9)}),KahetiShadowweaversEmblem=v11(227035 - (746 + 638), {(19 - 6),(1595 - (1535 + 46))})};
v11.Mage.Arcane = v12(v11.Mage.Commons, {AberrantSpellforge=v11(211092 + 1359, {(573 - (306 + 254)),(27 - 13)}),FearbreakersEcho=v11(225916 - (899 + 568), {(31 - 18),(304 - (60 + 230))}),HighSpeakersAccretion=v11(219875 - (426 + 146), {(1469 - (282 + 1174)),(40 - 26)}),MadQueensMandate=v11(12150 + 200304, {(1264 - (721 + 530)),(34 - 20)}),MereldarsToll=v11(195149 + 24164, {(12 + 1),(1100 - (461 + 625))}),QuickwickCandlestick=v11(226937 - (993 + 295), {(1184 - (418 + 753)),(2 + 12)}),SignetofthePriory=v11(64144 + 155164, {(542 - (406 + 123)),(4 + 10)})});
v11.Mage.Fire = v12(v11.Mage.Commons, {CrimsonGladiatorsBadge=v11(203129 - (1249 + 73), {(1158 - (466 + 679)),(39 - 25)}),DraconicGladiatorsBadge=v11(218179 - (106 + 1794), {(4 + 9),(37 - 23)}),ObsidianGladiatorsBadge=v11(205822 - (4 + 110), {(1440 - (41 + 1386)),(10 + 4)}),VerdantGladiatorsBadge=v11(466858 - 257515, {(179 - (122 + 44)),(46 - 32)}),ForgedGladiatorsBadge=v11(177920 + 40793, {(26 - 13),(10 + 4)}),DragonfireBombDispenser=v11(203867 - (1043 + 214), {(1225 - (323 + 889)),(594 - (361 + 219))}),HornofValor=v11(133962 - (53 + 267), {(426 - (15 + 398)),(52 - 38)}),IrideusFragment=v11(112170 + 81573, {(863 - (20 + 830)),(140 - (116 + 10))}),MoonlitPrism=v11(10160 + 127381, {(27 - 14),(8 + 6)}),SpoilsofNeltharus=v11(69752 + 124021, {(33 - 20),(419 - (118 + 287))}),TimebreachingTalon=v11(759523 - 565732, {(38 - 25),(63 - 49)})});
v11.Mage.Frost = v12(v11.Mage.Commons, {BelorrelostheSuncaller=v11(45079 + 162093, {(23 - 10),(14 + 0)}),Dreambinder=v11(121468 + 87148, {(10 + 6)})});
v19.IFST = {CurrStacks=(0 - 0),CurrStacksTime=(0 - 0),OldStacks=(0 - 0),OldStacksTime=(0 + 0),Direction=(0 - 0)};
local v32 = {};
v32.IncantersFlowBuff = v9(117020 - (239 + 514));
v3:RegisterForEvent(function()
	v19.IFST.CurrStacks = 0 + 0;
	v19.IFST.CurrStacksTime = 1329 - (797 + 532);
	v19.IFST.OldStacks = 0 + 0;
	v19.IFST.OldStacksTime = 0 + 0;
	v19.IFST.Direction = 0 - 0;
end, "PLAYER_REGEN_ENABLED");
local v34 = {(385417 - (476 + 255)),(216333 + 157639),(735176 - 347221),(52672 + 317151),(375114 - (144 + 192))};
v19.Precast = function()
	return v13.ToggleIconFrame:GetToggle(217 - (42 + 174));
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
		return v7:NPCID() == (153673 + 50887);
	end;
	v19.GroundSpellCondition = function()
		return (v8:Exists() or not v18.GroundSpellOnlyIfMouseover) and (not v6:IsCameraBusy() or not v18.GroundSpellOnlyIfCameraFree);
	end;
	v19.AutoTarget = function()
		if (v15.General.AutoTab and v6:AffectingCombat()) then
			v13.TopPanelAlternative:ChangeIcon(1 + 0, 2 + 1);
			return "Auto tab to target";
		end
	end;
end
v19.TTDCondition = function(v52, v53, v54)
	if ((v53 and v6:IsInRaid()) or v16.Buggedmobs[v7:NPCID()] or v7:IsDummy() or v16.ISSolo() or (v52 == (1504 - (363 + 1141))) or ((v54 >= v52) and (v54 < (9357 - (1183 + 397))))) then
		return true;
	end
end;
v19.TTDCastTimeCondition = function(v55, v56, v57)
	if (not v18.TimeToTimeCastTime or v16.Buggedmobs[v7:NPCID()] or v7:IsDummy() or (v55:TotalTimeRequired() == (0 - 0)) or (v7:TimeToDie() > (3 + 0)) or (v7:TimeToDie() >= v55:TotalTimeRequired())) then
		return true;
	end
end;
v19.IFTracker = function()
	if (v3.CombatTime() == (0 + 0)) then
		return;
	end
	local v58 = v19.IFST.CurrStacksTime - v19.IFST.OldStacksTime;
	local v59 = v19.IFST.CurrStacks;
	local v60 = v19.IFST.CurrStacksTime;
	local v61 = v19.IFST.OldStacks;
	if (v6:BuffUp(v32.IncantersFlowBuff)) then
		if ((v6:BuffStack(v32.IncantersFlowBuff) ~= v59) or ((v6:BuffStack(v32.IncantersFlowBuff) == v59) and (v58 > (1976 - (1913 + 62))))) then
			v19.IFST.OldStacks = v59;
			v19.IFST.OldStacksTime = v60;
		end
		v19.IFST.CurrStacks = v6:BuffStack(v32.IncantersFlowBuff);
		v19.IFST.CurrStacksTime = v3.CombatTime();
		if (v19.IFST.CurrStacks > v19.IFST.OldStacks) then
			if (v19.IFST.CurrStacks == (4 + 1)) then
				v19.IFST.Direction = 0 - 0;
			else
				v19.IFST.Direction = 1934 - (565 + 1368);
			end
		elseif (v19.IFST.CurrStacks < v19.IFST.OldStacks) then
			if (v19.IFST.CurrStacks == (3 - 2)) then
				v19.IFST.Direction = 1661 - (1477 + 184);
			else
				v19.IFST.Direction = -(1 - 0);
			end
		elseif (v19.IFST.CurrStacks == (1 + 0)) then
			v19.IFST.Direction = 857 - (564 + 292);
		else
			v19.IFST.Direction = -(1 - 0);
		end
	else
		v19.IFST.OldStacks = 0 - 0;
		v19.IFST.OldStacksTime = 304 - (244 + 60);
		v19.IFST.CurrStacks = 0 + 0;
		v19.IFST.CurrStacksTime = 476 - (41 + 435);
		v19.IFST.Direction = 1001 - (938 + 63);
	end
end;
v19.IFTimeToX = function(v62, v63)
	local v64;
	local v65;
	local v66;
	if ((v19.IFST.Direction == -(1 + 0)) or ((v19.IFST.Direction == (1125 - (936 + 189))) and (v19.IFST.CurrStacks == (0 + 0)))) then
		v66 = ((1623 - (1565 + 48)) - v19.IFST.CurrStacks) + 1 + 0;
	else
		v66 = v19.IFST.CurrStacks;
	end
	if (v63 == "up") then
		v64 = v62;
		v65 = v62;
	elseif (v63 == "down") then
		v64 = ((1148 - (782 + 356)) - v62) + (268 - (176 + 91));
		v65 = ((26 - 16) - v62) + (1 - 0);
	else
		v64 = v62;
		v65 = ((1102 - (975 + 117)) - v62) + (1876 - (157 + 1718));
	end
	if ((v64 == v66) or (v65 == v66)) then
		return 0 + 0;
	end
	local v67 = (((35 - 25) + v64) - v66) % (34 - 24);
	local v68 = (((1028 - (697 + 321)) + v65) - v66) % (27 - 17);
	return ((v19.IFST.CurrStacksTime - v19.IFST.OldStacksTime) + math.min(v67, v68)) - (1 - 0);
end;
v19.RangeOOCCount = function()
	if v16.TargetIsValid() then
		local v88 = v7:MinDistance();
		v88 = (v88 and ((v88 - (18 - 10)) > (2 + 3)) and (v88 - (14 - 6))) or (13 - 8);
		local v89 = v7:MaxDistance();
		v89 = math.min(1317 - (322 + 905), (v89 and ((v89 + (619 - (602 + 9))) > (1194 - (449 + 740))) and (v89 + (880 - (826 + 46)))) or (952 - (245 + 702)));
		local v90 = v6:GetEnemiesInRange(v88);
		local v91 = v6:GetEnemiesInRange(v89);
		local v92 = (((v89 - v88) > (50 - 34)) and (#v91 - #v90)) or #v91;
		return ((v92 > (0 + 0)) and v92) or (1899 - (260 + 1638));
	end
	return #(v6:GetEnemiesInRange(480 - (382 + 58)));
end;
