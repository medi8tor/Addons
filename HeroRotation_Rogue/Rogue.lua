local S,B=...local T=HeroDBC.DBC local l=HeroLib local q=HeroCache local p=l.Unit local E=p.Player local L=p.Target local P=p.MouseOver local c=l.Spell local F=l.MultiSpell local O=l.Item local k=l.Utils.MergeTableByKey local o=HeroRotation()local R=(o.Commons()).Everyone local I=math.min local Z=pairs local i={};(o.Commons()).Rogue=i local t=o.GUISettingsGet()local x={General=t.General;Commons=t.APL.Rogue.Commons;Assassination=t.APL.Rogue.Assassination;Outlaw=t.APL.Rogue.Outlaw;Subtlety=t.APL.Rogue.Subtlety,Defense=t.APL.Rogue.Defense}if not c.Rogue then c.Rogue={}end c.Rogue.Commons={AncestralCall=c(274738);ArcanePulse=c(260364);ArcaneTorrent=c(25046),BagofTricks=c(312411),Berserking=c(26297);BloodFury=c(20572);Fireblood=c(265221),LightsJudgment=c(255647),Shadowmeld=c(58984);CloakofShadows=c(31224);CrimsonVial=c(185311),Evasion=c(5277),Feint=c(1966),Blind=c(2094);CheapShot=c(1833);ClearTheWitnessesBuff=c(457179);Kick=c(1766);KidneyShot=c(408),PickPocket=c(921),Sap=c(6770);Shiv=c(5938);SliceandDice=c(315496);Shadowstep=c(36554);Sprint=c(2983),TricksoftheTrade=c(57934),Alacrity=c(193539);ColdBlood=c(382245),CoupDeGrace=c(441776),DeeperStratagem=c(193531);DeathStalkersMark=c(457052),DeathStalkersMarkDebuff=c(457129);EchoingReprimand=c(385616),EchoingReprimand2=c(323558);EchoingReprimand3=c(323559);EchoingReprimand4=c(323560),EchoingReprimand5=c(354838);EscalatingBlade=c(441786);EdgeCase=c(453457),FindWeakness=c(91023),FindWeaknessDebuff=c(316220);ImprovedAmbush=c(381620),MarkedforDeath=c(137619),MomentumOfDespair=c(457067);Nightstalker=c(14062);ResoundingClarity=c(381622),Reverberation=c(394332),SealFate=c(14190);Sepsis=c(385408);SepsisBuff=c(375939);ShadowDance=c(185313);ShadowDanceTalent=c(394930),ShadowDanceBuff=c(185422),Subterfuge=c(108208);SubterfugeBuff=c(115192);ThistleTea=c(381623),UnseenBlade=c(441146),UnseenBladeBuff=c(459485),Vigor=c(14983);HandOfFate=c(452536),DarkestNight=c(457058);DarkestNightBuff=c(457280),FatefulEnding=c(454428);FazedDebuff=c(441224),FlawlessForm=c(441321);FlawlessFormBuff=c(441326),FollowTheBlood=c(457068);FateboundCoin=c(453012),FateboundCoinHeads=c(456479),FateboundCoinTails=c(452538);FateboundLuckyCoin=c(461818),Stealth=c(1784);Stealth2=c(115191),Vanish=c(1856);VanishBuff=c(11327),VanishBuff2=c(115193);WithoutATrace=c(382513),PoolEnergy=c(999910)}c.Rogue.Assassination=k(c.Rogue.Commons,{Ambush=c(8676);AmbushOverride=c(430023),AmplifyingPoison=c(381664);AmplifyingPoisonDebuff=c(383414);AmplifyingPoisonDebuffDeathmark=c(394328),CripplingPoisonDebuff=c(3409);DeadlyPoison=c(2823);DeadlyPoisonDebuff=c(2818),DeadlyPoisonDebuffDeathmark=c(394324);Envenom=c(32645);FanofKnives=c(51723);Garrote=c(703);GarroteDeathmark=c(360830);Mutilate=c(1329);PoisonedKnife=c(185565),Rupture=c(1943),RuptureDeathmark=c(360826),WoundPoison=c(8679),WoundPoisonDebuff=c(8680);ArterialPrecision=c(400783);AtrophicPoisonDebuff=c(392388);BlindsideBuff=c(121153),CausticSpatter=c(421975);CausticSpatterDebuff=c(421976),CrimsonTempest=c(121411);CutToTheChase=c(51667),DashingScoundrel=c(381797),Deathmark=c(360194),Doomblade=c(381673);DragonTemperedBlades=c(381801);Elusiveness=c(79008);EdgeCase=c(453457);ImprovedGarrote=c(381632);ImprovedGarroteBuff=c(392401);ImprovedGarroteAura=c(392403),IndiscriminateCarnage=c(381802);IndiscriminateCarnageAura=c(385754);IndiscriminateCarnageBuff=c(385747);InternalBleeding=c(154953);Kingsbane=c(385627),LightweightShiv=c(394983),MasterAssassin=c(255989),MasterAssassinBuff=c(256735),PreyontheWeak=c(131511);PreyontheWeakDebuff=c(255909);ScentOfBlood=c(381799),ScentOfBloodBuff=c(394080),SerratedBoneSpike=c(385424),SerratedBoneSpikeDebuff=c(394036);ShivDebuff=c(319504);ShroudedSuffocation=c(385478),ThrownPrecision=c(381629);VenomRush=c(152152),ViciousVenoms=c(381634)})c.Rogue.Outlaw=k(c.Rogue.Commons,{AdrenalineRush=c(13750);Ambush=c(8676);AmbushOverride=c(430023),BetweentheEyes=c(315341);BladeFlurry=c(13877),Dispatch=c(2098);Elusiveness=c(79008),Opportunity=c(195627),PistolShot=c(185763);RolltheBones=c(315508),SinisterStrike=c(193315),Audacity=c(381845);AudacityBuff=c(386270);BladeRush=c(271877),CountTheOdds=c(381982);Crackshot=c(423703),DeftManeuvers=c(381878),FanTheHammer=c(381846);GhostlyStrike=c(196937);GreenskinsWickers=c(386823);GreenskinsWickersBuff=c(394131),HiddenOpportunity=c(383281);DoubleJeoPardy=c(454430),ImprovedAdrenalineRush=c(395422);ImprovedBetweenTheEyes=c(235484);KeepItRolling=c(381989);KillingSpree=c(51690),LoadedDice=c(256170),LoadedDiceBuff=c(256171);PreyontheWeak=c(131511);PreyontheWeakDebuff=c(255909);QuickDraw=c(196938),Ruthlessness=c(14161),SummarilyDispatched=c(381990);SwiftSlasher=c(381988);TakeEmBySurprise=c(382742),TakeEmBySurpriseBuff=c(385907),UnderhandedUpperhand=c(424044);Weaponmaster=c(200733);Gouge=c(1776),Broadside=c(193356);BuriedTreasure=c(199600),GrandMelee=c(193358);RuthlessPrecision=c(193357),SkullandCrossbones=c(199603);TrueBearing=c(193359),ViciousFollowup=c(394879)})c.Rogue.Subtlety=k(c.Rogue.Commons,{Backstab=c(53);BlackPowder=c(319175);Elusiveness=c(79008),Eviscerate=c(196819);Rupture=c(1943);ShadowBlades=c(121471),Shadowstrike=c(185438);ShurikenStorm=c(197835);ShurikenToss=c(114014);SymbolsofDeath=c(212283),DanseMacabre=c(382528),DanseMacabreBuff=c(393969),DeeperDaggers=c(382517),DeeperDaggersBuff=c(383405);DarkBrew=c(382504),DarkShadow=c(245687);EnvelopingShadows=c(238104),Finality=c(382525);FinalityBlackPowderBuff=c(385948);FinalityEviscerateBuff=c(385949),FinalityRuptureBuff=c(385951),Flagellation=c(384631),FlagellationPersistBuff=c(394758),Gloomblade=c(200758);GoremawsBite=c(426591);ImprovedBackstab=c(319949);ImprovedShadowDance=c(393972),ImprovedShurikenStorm=c(319951);InvigoratingShadowdust=c(382523);LingeringShadow=c(382524);LingeringShadowBuff=c(385960);MasterofShadows=c(196976),PerforatedVeins=c(382518),PerforatedVeinsBuff=c(394254),PreyontheWeak=c(131511),PreyontheWeakDebuff=c(255909),Premeditation=c(343160),PremeditationBuff=c(343173);ReplicatingShadows=c(382506),SecretStratagem=c(394320);SecretTechnique=c(280719);Shadowcraft=c(426594);ShadowFocus=c(108209),ShurikenTornado=c(277925),SilentStorm=c(385722),SilentStormBuff=c(385727),TheFirstDance=c(382505),TheRotten=c(382015),TheRottenBuff=c(394203);Weaponmaster=c(193537);DoubleDance=c(394930)})if not O.Rogue then O.Rogue={}end O.Rogue.Assassination={AlgetharPuzzleBox=O(193701,{13;14}),AshesoftheEmbersoul=O(207167,{13;14});WitherbarksBranch=O(109999,{13;14}),ManicGrieftorch=O(194308,{13;14}),ImperfectAscendancySerum=O(225654,{13;14});TreacherousTransmitter=O(221023,{13;14}),MadQueensMandate=O(212454,{13,14})}O.Rogue.Outlaw={ImperfectAscendancySerum=O(225654,{13,14}),MadQueensMandate=O(212454,{13;14})}O.Rogue.Subtlety={ImperfectAscendancySerum=O(225654,{13,14}),TreacherousTransmitter=O(221023,{13,14})}local C=c.Rogue.Commons function i.StealthSpell()return C.Subterfuge:IsAvailable()and C.Stealth2 or C.Stealth end function i.VanishBuffSpell()return C.Subterfuge:IsAvailable()and C.VanishBuff2 or C.VanishBuff end function i.TTDCheck(S,B,T)return B or R.ISSolo()or R.Buggedmobs[L:NPCID()]or S==0 or T>=S and T<7777 end function i.CastWithTTD(S,B,T,l,q)if l or R.ISSolo()or R.Buggedmobs[L:NPCID()]or T==0 or q>=T and q<7777 then o.Cast(S,B)return"\084\084\068 \099\097\115\116 "..S:Name()end end function i.Stealth(S,B)if o.ToggleIconFrame:GetToggle(1)and(S:IsCastable()and E:StealthDown())then if o.Cast(C.Stealth)then return"\067\097\115\116 \083\116\101\097\108\116\104 \040\079\079\067\041"end end return false end function i.CombatCheck()return R.TargetIsValid()and(L:AffectingCombat()or not x.Commons.OnlyAttackEnnemyInCombat or not x.Commons.OnlyAttackEnnemyInCombatSolo and R.ISSolo())end function i.AutoTarget()if t.General.AutoTab and E:AffectingCombat()then o.TopPanelAlternative:ChangeIcon(1,3)return"\065\117\116\111 \116\097\098 \116\111 \116\097\114\103\101\116"end end do local S=R.converArrayToList({439795})local function B()if x.Defense.FeintDanger then local B=E:GetEnemiesInRange(40)for B,T in Z(B)do if S[T:CastSpellID()or T:ChannelSpellID()]then return true end end end end function i.Defense()if C.CrimsonVial:IsCastable()and E:HealthPercentage()<=x.Defense.CrimsonVialHP then o.Cast(C.CrimsonVial)return"\067\097\115\116 \067\114\105\109\115\111\110 \086\105\097\108 \040\068\101\102\101\110\115\105\118\101\115\041"end if C.Evasion:IsCastable()and E:HealthPercentage()<=x.Defense.EvasionHP then o.Cast(C.Evasion,true)return"\067\097\115\116 \069\118\097\115\105\111\110 \040\068\101\102\101\110\115\105\118\101\115\041"end if C.Feint:IsCastable()and(E:BuffDown(C.Feint)and(E:HealthPercentage()<=x.Defense.FeintHP or B()))then o.Cast(C.Feint)return"\067\097\115\116 \070\101\105\110\116 \040\068\101\102\101\110\115\105\118\101\115\041"end if C.CloakofShadows:IsCastable()and E:HealthPercentage()<=x.Defense.CloakofShadowsHP then o.Cast(C.CloakofShadows,true)return"\067\097\115\116 \067\108\111\097\107 \111\102 \083\104\097\100\111\119\115 \040\068\101\102\101\110\115\105\118\101\115\041"end if x.Commons.Enabled["\084\114\105\099\107\115 \111\102 \084\114\097\100\101 \070\111\099\117\115"]and(R.TargetIsValid()and((l.CombatTime()<20 or not E:AffectingCombat())and(C.TricksoftheTrade:IsCastable()and(C.TricksoftheTrade:IsUsable()and(p.Focus:Exists()and(p.Focus:Role()=="\084\065\078\075"and(p.Focus:IsSpellInRange(C.Shadowstep)and(p.Focus:UnitIsFriend()and not p.Focus:IsDeadOrGhost()))))))))then p.Focus:Cast(C.TricksoftheTrade,true)return"\084\114\105\099\107\115 \111\102 \084\114\097\100\101 \111\110 \070\111\099\117\115 \040\068\101\102\101\110\115\105\118\101\115\041"end return false end end do local S=c(3408)local B=c(2823)local T=c(315584)local l=c(381664)local q=c(5761)local p=c(8679)local L=c(381637)local P=0 local F=false local function O(S)P=E:BuffRemains(S)if P<(E:AffectingCombat()and 120 or 300)and(not E:IsCasting()and S:CooldownRemains(true)==0)then o.Cast(S)return"\067\097\115\116 "..S:Name()end end function i.Poisons()local P=E:AffectingCombat()and 120 or 300 local k local o F=E:BuffUp(p)if c.Rogue.Assassination.DragonTemperedBlades:IsAvailable()then o=O(F and p or B)if o then return o end if l:IsAvailable()then o=O(l)if o then return o end else o=O(T)if o then return o end end else if F then o=O(p)if o then return o end elseif l:IsAvailable()and E:BuffDown(B)then o=O(l)if o then return o end elseif B:IsAvailable()then o=O(B)if o then return o end else o=O(T)if o then return o end end end if E:BuffDown(S)then if L:IsAvailable()then o=O(L)if o then return o end elseif q:IsAvailable()then o=O(q)if o then return o end else o=O(S)if o then return o end end if c.Rogue.Assassination.DragonTemperedBlades:IsAvailable()then o=O(S)if o then return o end end else o=O(S)if o then return o end end end end function i.CanDoTUnit(S,B)return R.CanDoTUnit(S,B)end do local S=c.Rogue.Assassination local B=c.Rogue.Subtlety local function T()if S.Nightstalker:IsAvailable()and E:StealthUp(true,false,true)then return 1+.05*S.Nightstalker:TalentRank()end return 1 end local function l()if S.ImprovedGarrote:IsAvailable()and(E:BuffUp(S.ImprovedGarroteAura,nil,true)or E:BuffUp(S.ImprovedGarroteBuff,nil,true)or E:BuffUp(S.SepsisBuff,nil,true))then return 1.5 end return 1 end S.Rupture:RegisterPMultiplier(T,{B.FinalityRuptureBuff;1.3})S.Garrote:RegisterPMultiplier(T,l)S.CrimsonTempest:RegisterPMultiplier(T)end do local S=c(193531)local B=c(394321)local T=c(394320)function i.CPMaxSpend()return((5+(S:IsAvailable()and 1 or 0))+(B:IsAvailable()and 1 or 0))+(T:IsAvailable()and 1 or 0)end end function i.CPSpend()return I(E:ComboPoints(),i.CPMaxSpend())end do function i.AnimachargedCP()if E:BuffUp(c.Rogue.Commons.EchoingReprimand2)then return 2 elseif E:BuffUp(c.Rogue.Commons.EchoingReprimand3)then return 3 elseif E:BuffUp(c.Rogue.Commons.EchoingReprimand4)then return 4 elseif E:BuffUp(c.Rogue.Commons.EchoingReprimand5)then return 5 end return-1 end function i.EffectiveComboPoints(S)if S==2 and E:BuffUp(c.Rogue.Commons.EchoingReprimand2)or S==3 and E:BuffUp(c.Rogue.Commons.EchoingReprimand3)or S==4 and E:BuffUp(c.Rogue.Commons.EchoingReprimand4)or S==5 and E:BuffUp(c.Rogue.Commons.EchoingReprimand5)then return 7 end return S end end do local S=c.Rogue.Assassination.DeadlyPoisonDebuff local B=c.Rogue.Assassination.WoundPoisonDebuff local T=c.Rogue.Assassination.AmplifyingPoisonDebuff local l=c.Rogue.Assassination.CripplingPoisonDebuff local q=c.Rogue.Assassination.AtrophicPoisonDebuff function i.Poisoned(p)return(p:DebuffUp(S)or p:DebuffUp(T)or p:DebuffUp(l)or p:DebuffUp(B)or p:DebuffUp(q))and true or false end end do local S=c.Rogue.Assassination.Garrote local B=c.Rogue.Assassination.GarroteDeathmark local T=c.Rogue.Assassination.Rupture local l=c.Rogue.Assassination.RuptureDeathmark local q=c.Rogue.Assassination.InternalBleeding local p=0 function i.PoisonedBleeds()p=0 for E,L in Z(E:GetEnemiesInRange(50))do if i.Poisoned(L)then if L:DebuffUp(S)then p=p+1 if L:DebuffUp(B)then p=p+1 end end if L:DebuffUp(T)then p=p+1 if L:DebuffUp(l)then p=p+1 end end if L:DebuffUp(q)then p=p+1 end end end return p end end