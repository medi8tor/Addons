local v0={};local v1=string.char;local v2=string.byte;local v3=string.sub;local v4=bit32 or bit ;local v5=v4.bxor;local v6=table.concat;local v7=table.insert;local function v8(v21,v22) local v23={};for v43=1, #v21 do v7(v23,v1(v5(v2(v3(v21,v43,v43 + 1 )),v2(v3(v22,1 + (v43% #v22) ,1 + (v43% #v22) + 1 )))%256 ));end return v6(v23);end v0[42 -13 ]=v8("\239\84\181\79\236\67\233\74\233\86","\38\156\55\199");v0[538 -(232 + 281) ]=v8("\98\216\52\233\70\126","\152\38\189\86\156\32\24\133");v0[1271 -(976 + 277) ]=v8("\136\44\17\56\125\160\247","\155\203\68\112\86\19\197");v0[974 -(892 + 65) ]=v8("\115\23\49\6","\158\48\118\66\114");v0[37 -21 ]=v8("\16\178\75\3\186\32","\38\84\215\41\118\220\70");v0[27 -12 ]=v8("\1\216\44\195","\156\67\173\74\165");v0[0 -0 ]=v8("\194\192\201\44\246\175\137\18\196\194","\126\177\163\187\69\134\219\167");local v16=...;local v17={};local v18=require;local function v19(v24,...) local v25=v17[v24];if  not v25 then return v18(v24,v16,...);end return v25(v16,...);end v17[v0[350 -(87 + 263) ]]=function(...) local v26,v27=...;local v28,v29=HeroCache,v27.Utils;local v30=v27.Unit;local v31,v32,v33=v30.Player,v30.Pet,v30.Target;local v34,v35=v30.Focus,v30.MouseOver;local v36,v37,v38=v30.Arena,v30.Boss,v30.Nameplate;local v39,v40=v30.Party,v30.Raid;local v41=v27.Spell;local v42=v27.Item;do local v44={[v0[195 -(67 + 113) ]]={v41(471246 -279305 ),v41(811395 -607244 ),v41(645977 -406045 )},[v0[28 -12 ]]={},[v0[13 + 4 ]]={560114 -362304 ,259632 -62214 ,449383 -251304 ,37204 + 176799 ,233865 + 1886 ,608636 -414968 ,875104 -647611 ,730705 -501853 ,341873 -148662 ,201162 -(44 + 386) ,76766 + 164869 ,242408 -(201 + 571) ,984587 -748093 ,875917 -635985 ,255778 -(814 + 45) ,13197 + 231702 ,246343 -(261 + 624) ,249579 -(1020 + 60) ,874407 -616368 ,148192 + 228087 ,373803 -(760 + 987) ,376346 -(745 + 21) ,1074649 -684101 ,3074 + 372796 ,378713 -(87 + 968) ,367210 + 37534 ,405112 -(447 + 966) ,405020 -(1703 + 114) ,665208 -259294 ,116249 + 290534 ,401272 -(9 + 5) ,411616 -(243 + 1022) ,336212 + 71335 ,331639 + 75958 ,403278 -(1869 + 61) ,1412404 -1011382 ,55802 + 351988 ,376954 + 24371 ,412207 -(140 + 831) ,409140 -(15 + 703) ,424790 -(262 + 176) ,421708 -(198 + 490) ,1004181 -585544 ,883676 -462333 ,67174 + 350257 ,1411073 -985581 },[v0[392 -(123 + 251) ]]={}};v31.ActiveMitigationNeeded=function(v48) if  not v31:IsTanking(v33) then return false;end if v44.Cast[v33:CastSpellID()] then return true;end for v50,v51 in pairs(v44.Buff) do if v33:BuffUp(v51,true) then return true;end end return false;end;end do local v46={[v0[124 -99 ]]={v41(20587 + 223374 ),v41(422492 -(660 + 176) )}};v31.HealingAbsorbed=function(v49) for v52,v53 in pairs(v46.Debuff) do if v31:DebuffUp(v53,true) then return true;end end return false;end;end end;return v17[v0[4 + 25 ]](...);
