local v0={};local v1=string.char;local v2=string.byte;local v3=string.sub;local v4=bit32 or bit ;local v5=v4.bxor;local v6=table.concat;local v7=table.insert;local function v8(v16,v17) local v18={};for v38=1, #v16 do v7(v18,v1(v5(v2(v3(v16,v38,v38 + 1 )),v2(v3(v17,1 + (v38% #v17) ,1 + (v38% #v17) + 1 )))%256 ));end return v6(v18);end v0[118 -76 ]=v8("\48\206\56\204\236\55\131\38\208\253","\156\67\173\74\165");v0[931 -(857 + 74) ]=v8("\194\192\201\44\246\175\137\18\196\194","\126\177\163\187\69\134\219\167");local v11=...;local v12={};local v13=require;local function v14(v19,...) local v20=v12[v19];if  not v20 then return v13(v19,v11,...);end return v20(v11,...);end v12[v0[568 -(367 + 201) ]]=function(...) local v21,v22=...;local v23,v24=HeroCache,v22.Utils;local v25=v22.Unit;local v26,v27,v28=v25.Player,v25.Pet,v25.Target;local v29,v30=v25.Focus,v25.MouseOver;local v31,v32,v33=v25.Arena,v25.Boss,v25.Nameplate;local v34,v35=v25.Party,v25.Raid;local v36=v22.Spell;local v37=v22.Item;do local v39={{v36(281 + 1503 ),v36(116828 -(1523 + 114) ),v36(16147 -4820 ),v36(116463 -(226 + 1044) ),v36(5332 -(32 + 85) )},{v36(116149 -(892 + 65) ),v36(342740 -157318 ),v36(102893 -(87 + 263) )},{v36(922991 -547052 ),v36(234431 -175447 )}};v26.StealthRemains=function(v43,v44,v45,v46) if v36.Rogue then if ((v44 and ((v36.Rogue.Commons.ShadowDance:TimeSinceLastCast()<(952.3 -(802 + 150))) or (v36.Rogue.Commons.Vanish:TimeSinceLastCast()<(0.3 -0)))) or (v45 and (v36.Rogue.Commons.Shadowmeld:TimeSinceLastCast()<(0.3 -0)))) then return 1 + 0 ;end end if v36.Druid then local v56=v36.Druid.Feral;if v56 then if ((v44 and (v56.Incarnation:TimeSinceLastCast()<(997.3 -(915 + 82)))) or (v45 and (v56.Shadowmeld:TimeSinceLastCast()<(0.3 -0)))) then return 1 + 0 ;end end end for v55=1 -0 , #v39 do if ((v55==(1188 -(1069 + 118))) or ((v55==(4 -2)) and v44) or ((v55==(6 -3)) and v45)) then local v57=v39[v55];for v58=1 + 0 , #v57 do local v59=v57[v58];if v26:BuffUp(v59,nil,v46) then return v26:BuffRemains(v59,nil,v46);end end end end return 0 -0 ;end;v26.StealthUp=function(v47,v48,v49,v50) return v47:StealthRemains(v48,v49,v50)>(0 + 0) ;end;v26.StealthDown=function(v51,v52,v53,v54) return  not v51:StealthUp(v52,v53,v54);end;end end;return v12[v0[833 -(368 + 423) ]](...);
