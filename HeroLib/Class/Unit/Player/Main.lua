local v0={};local v1=string.char;local v2=string.byte;local v3=string.sub;local v4=bit32 or bit ;local v5=v4.bxor;local v6=table.concat;local v7=table.insert;local function v8(v18,v19) local v20={};for v54=1, #v18 do v7(v20,v1(v5(v2(v3(v18,v54,v54 + 1 )),v2(v3(v19,1 + (v54% #v19) ,1 + (v54% #v19) + 1 )))%256 ));end return v6(v20);end v0[100 -50 ]=v8("\67\21\48\27\238\68\88\46\7\255","\158\48\118\66\114");v0[30 + 13 ]=v8("\4\178\93\59\179\51\72\32\164","\38\84\215\41\118\220\70");v0[1679 -(1523 + 114) ]=v8("\16\221\47\201\240\48","\156\67\173\74\165");v0[0 + 0 ]=v8("\194\192\201\44\246\175\137\18\196\194","\126\177\163\187\69\134\219\167");local v13=...;local v14={};local v15=require;local function v16(v21,...) local v22=v14[v21];if  not v22 then return v15(v21,v13,...);end return v22(v13,...);end v14[v0[0 -0 ]]=function(...) local v23,v24=...;local v25,v26=HeroCache,v24.Utils;local v27=v24.Unit;local v28,v29,v30=v27.Player,v27.Pet,v27.Target;local v31,v32=v27.Focus,v27.MouseOver;local v33,v34,v35=v27.Arena,v27.Boss,v27.Nameplate;local v36,v37=v27.Party,v27.Raid;local v38=v24.Spell;local v39=v24.Item;local v40=IsMounted;local v41=UnitInParty;local v42=UnitInRaid;local v43=UnitInVehicle;local v44=UnitRace;v28.IsMounted=function(v55) return v40() and  not v55:IsOnCombatMount() ;end;v28.IsInParty=function(v56) return v41(v56.UnitID);end;v28.IsInRaid=function(v57) return v42(v57.UnitID);end;v28.Race=function(v58) local v59,v60=v44(v58.UnitID);return v60;end;v28.IsRace=function(v61,v62) return (v62 and (v61:Race()==v62)) or false ;end;v28.HeroTree=function(v63) return v25.Persistent.Player.ActiveHeroTree;end;v28.HeroTreeID=function(v64) return v25.Persistent.Player.ActiveHeroTreeID;end;v28.ListHeroTrees=function(v65) return v25.Persistent.Player.HeroTrees;end;do local v66={v38(132617 -(226 + 1044) ),v38(900 -(32 + 85) ),v38(36803 + 129159 ),v38(526030 -305521 ),v38(407338 -185455 ),v38(222065 -(67 + 113) ),v38(544766 -322880 ),v38(881887 -660000 ),v38(685121 -430650 ),v38(185228 + 69244 ),v38(720559 -466086 ),v38(334668 -80194 ),v38(500205 -279725 ),v38(38331 + 182153 ),v38(218725 + 1763 ),v38(692926 -472437 ),v38(848170 -627679 ),v38(704051 -483547 ),v38(390172 -169665 ),v38(222025 -(44 + 386) ),v38(70424 + 151247 ),v38(222444 -(201 + 571) ),v38(922883 -701210 ),v38(799369 -580405 ),v38(165081 -(814 + 45) ),v38(8935 + 156868 )};v28.IsOnCombatMount=function(v71) for v75=1 + 0 , #v66 do if v71:BuffUp(v66[v75],true) then return true;end end return false;end;end v28.IsInVehicle=function(v68) return v43(v68.UnitID) and  not v68:IsInWhitelistedVehicle() ;end;do local v69={[v0[927 -(261 + 624) ]]={v38(378302 -(1020 + 60) ),v38(1112936 -784507 ),v38(136596 + 210239 ),v38(189566 -(760 + 987) ),v38(182111 -(745 + 21) ),v38(432170 -275111 )},[v0[168 -125 ]]={91704 + 25098 ,383329 -296247 ,196843 -109765 ,238397 -151316 ,87781 -(376 + 325) ,267939 -180860 ,191783 -104707 }};v28.IsInWhitelistedVehicle=function(v72) local v73=v69.Spells;for v76=15 -(9 + 5) , #v73 do local v77=v73[v76];if v72:DebuffUp(v77,nil,true) then return true;end end local v74=v69.PetMounts;if v29:IsActive() then for v78=377 -(85 + 291) , #v74 do local v79=v74[v78];if (v29:NPCID()==v79) then return true;end end end return false;end;end end;return v14[v0[1315 -(243 + 1022) ]](...);
