local v0={};local v1=string.char;local v2=string.byte;local v3=string.sub;local v4=bit32 or bit ;local v5=v4.bxor;local v6=table.concat;local v7=table.insert;local function v8(v26,v27) local v28={};for v70=1, #v26 do v7(v28,v1(v5(v2(v3(v26,v70,v70 + 1 )),v2(v3(v27,1 + (v70% #v27) ,1 + (v70% #v27) + 1 )))%256 ));end return v6(v28);end v0[1569 -(568 + 962) ]=v8("\175\192\197\3\18\63\242\207\194\11","\75\220\163\183\106\98");v0[113 -75 ]=v8("\106\109\45\7\104\118\63\9\102\101\63\0\127\103\46\17\118\119\46\3\96\110\52\0\123\103\36","\69\41\34\96");v0[53 -29 ]=v8("\148\88\236\182\63\94\36","\161\219\54\169\192\90\48\80");v0[4 + 14 ]=v8("\42\136\248\241\170","\84\121\223\177\191\237\76");v0[1971 -(508 + 1446) ]=v8("\155\77\89\4\63","\35\200\29\28\72\115\20\154");v0[12 + 4 ]=v8("\207\103\130\106\208\104\151\99\206\126\136\98\213\116","\38\156\55\199");v0[1012 -(915 + 82) ]=v8("\117\237\19\208\108\71\199\205\111\241\18\213\110\95","\152\38\189\86\156\32\24\133");v0[39 -25 ]=v8("\153\5\62\17\86","\155\203\68\112\86\19\197");v0[8 + 5 ]=v8("\117\56\20\59\204\127\56\15\55\208\100\55\14","\158\48\118\66\114");v0[15 -3 ]=v8("\28\178\91\25\144\47\68\11\146\95\19\178\50\96\38\182\68\19","\38\84\215\41\118\220\70");v0[1198 -(1069 + 118) ]=v8("\5\223\43\200\249","\156\67\173\74\165");v0[0 -0 ]=v8("\194\192\201\44\246\175\137\18\196\194","\126\177\163\187\69\134\219\167");local v21=...;local v22={};local v23=require;local function v24(v29,...) local v30=v22[v29];if  not v30 then return v23(v29,v21,...);end return v30(v21,...);end v22[v0[0 -0 ]]=function(...) local v31,v32=...;local v33=HeroCache;local v34=v32.Unit;local v35=v34.Player;local v36=v34.Pet;local v37=v34.Target;local v38=v32.Spell;local v39=v32.Item;local v40=CombatLogGetCurrentEventInfo;local v41=CreateFrame;local v42=pairs;local v43=select;local v44=string.find;local v45=string.sub;local v46=table.insert;local v47=table.remove;local v48=v41(v0[2 + 9 ],v0[21 -9 ],UIParent);local v49={};local v50={};local v51={};local v52={};local v53={};local v54={};local v55={v0[804 -(368 + 423) ],v0[32 -(10 + 8) ],v0[457 -(416 + 26) ],v0[7 + 9 ],v0[455 -(145 + 293) ],v0[1504 -(998 + 488) ]};local v56= #v55;v32.RegisterForEvent=function(v71,v72,...) local v73={...};for v113=1 + 0 , #v73 do local v114=v73[v113];if  not v49[v114] then v49[v114]={v72};v48:RegisterEvent(v114);else v46(v49[v114],v72);end end end;v32.UnregisterForEvent=function(v74,v75,v76) if v49[v76] then for v129,v130 in v42(v49[v76]) do if (v130==v75) then v47(v49[v76],v129);if ( #v49[v76]==(1138 -(116 + 1022))) then v48:UnregisterEvent(v76);end return;end end end end;v48:SetScript(v0[99 -75 ],function(v77,v78,...) for v115,v116 in v42(v49[v78]) do v116(v78,...);end end);v32.RegisterForCombatEvent=function(v79,v80,...) local v81={...};for v117=3 -2 , #v81 do local v118=v81[v117];if  not v50[v118] then v50[v118]={v80};else v46(v50[v118],v80);end end end;v32.RegisterForSelfCombatEvent=function(v82,v83,...) local v84={...};for v119=2 -1 , #v84 do local v120=v84[v119];if  not v51[v120] then v51[v120]={v83};else v46(v51[v120],v83);end end end;v32.RegisterForPetCombatEvent=function(v85,v86,...) local v87={...};for v121=886 -(261 + 624) , #v87 do local v122=v87[v121];if  not v52[v122] then v52[v122]={v86};else v46(v52[v122],v86);end end end;v32.RegisterForCombatPrefixEvent=function(v88,v89,...) local v90={...};for v123=1424 -(630 + 793) , #v90 do local v124=v90[v123];if  not v53[v124] then v53[v124]={v89};else v46(v53[v124],v89);end end end;v32.RegisterForCombatSuffixEvent=function(v91,v92,...) local v93={...};for v125=1 + 0 , #v93 do local v126=v93[v125];if  not v54[v126] then v54[v126]={v92};else v46(v54[v126],v92);end end end;v32.UnregisterForCombatEvent=function(v94,v95,v96) if v50[v96] then for v136,v137 in v42(v50[v96]) do if (v137==v95) then v47(v50[v96],v136);return;end end end end;v32.UnregisterForSelfCombatEvent=function(v97,v98,v99) if v51[v99] then for v138,v139 in v42(v51[v99]) do if (v139==v98) then v47(v51[v99],v138);return;end end end end;v32.UnregisterForPetCombatEvent=function(v100,v101,v102) if v52[v102] then for v140,v141 in v42(v52[v102]) do if (v141==v101) then v47(v52[v102],v140);return;end end end end;v32.UnregisterForCombatPrefixEvent=function(v103,v104,v105) if v53[v105] then for v142,v143 in v42(v53[v105]) do if (v143==v104) then v47(v53,v142);return;end end end end;v32.UnregisterForCombatSuffixEvent=function(v106,v107,v108) if v54[v108] then for v144,v145 in v42(v54[v108]) do if (v145==v107) then v47(v54[v108],v144);return;end end end end;local function v69(v109,v110,v111,...) if v50[v111] then for v146,v147 in v42(v50[v111]) do v147(v110,v111,...);end end if v51[v111] then if (v43(1749 -(760 + 987) ,...)==v35:GUID()) then for v150,v151 in v42(v51[v111]) do v151(v110,v111,...);end end end if v52[v111] then if (v43(1915 -(1789 + 124) ,...)==v36:GUID()) then for v152,v153 in v42(v52[v111]) do v153(v110,v111,...);end end end for v127=767 -(745 + 21) ,v56 do if v111 then local v148,v149=v44(v111,v55[v127]);if (v148 and v149) then local v154,v155=v45(v111,v148,v149),v45(v111,v149 + 1 + 0 );if v53[v154] then for v156,v157 in v42(v53[v154]) do v157(v110,v111,...);end end if v54[v155] then for v158,v159 in v42(v54[v155]) do v159(v110,v111,...);end end end end end end v32:RegisterForEvent(function(v112) v69(v112,v40());end,v0[104 -66 ]);end;return v22[v0[152 -113 ]](...);
