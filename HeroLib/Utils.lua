local v0={};local v1=string.char;local v2=string.byte;local v3=string.sub;local v4=bit32 or bit ;local v5=v4.bxor;local v6=table.concat;local v7=table.insert;local function v8(v38,v39) local v40={};for v73=1, #v38 do v7(v40,v1(v5(v2(v3(v38,v73,v73 + 1 )),v2(v3(v39,1 + (v73% #v39) ,1 + (v73% #v39) + 1 )))%256 ));end return v6(v40);end v0[481 -(306 + 105) ]=v8("\69\43\77\49\53\74\182\90\61\94","\152\54\72\63\88\69\62");v0[176 -107 ]=v8("\66\165","\174\103\142\197");v0[495 -(166 + 261) ]=v8("\248\2\21\179","\156\168\78\64\224\212\121");v0[573 -(289 + 218) ]=v8("\130\30","\126\167\52\16\116\217");v0[1409 -(1213 + 131) ]=v8("\42\35\149\31\46\38\149\18","\75\103\118\217");v0[15 + 48 ]=v8("\206\189","\199\235\144\82\61\152");v0[37 + 25 ]=v8("\155\192\4\254\43","\167\214\137\74\171\120\206\83");v0[215 -156 ]=v8("\40\231\104\91\90\82","\135\108\174\62\18\30\23\147");v0[198 -142 ]=v8("\149\236\111\109\63\159","\126\219\185\34\61");v0[912 -(814 + 45) ]=v8("\11\244\24\188\6\239","\232\73\161\76");v0[123 -73 ]=v8("\248\20\14\192\234\239\134","\202\171\92\71\134\190");v0[3 + 44 ]=v8("\33\142\185\27\156\79","\185\98\218\235\87");v0[16 + 28 ]=v8("\157\239\227\79\79","\75\220\163\183\106\98");v0[922 -(261 + 624) ]=v8("\90\86\18\44\71\69","\69\41\34\96");v0[63 -27 ]=v8("\181\67\196\162\63\66","\161\219\54\169\192\90\48\80");v0[1115 -(1020 + 60) ]=v8("\23\170\220\221\136\62","\84\121\223\177\191\237\76");v0[1457 -(630 + 793) ]=v8("\187\105\110\33\29\115","\35\200\29\28\72\115\20\154");v0[67 -47 ]=v8("\241\86\191","\38\156\55\199");v0[89 -70 ]=v8("\75\212\56","\152\38\189\86\156\32\24\133");v0[8 + 10 ]=v8("\246\121","\155\203\68\112\86\19\197");v0[58 -41 ]=v8("\12\75","\158\48\118\66\114");v0[1763 -(760 + 987) ]=v8("\106\234","\38\84\215\41\118\220\70");v0[1921 -(1789 + 124) ]=v8("\29\136\38","\156\67\173\74\165");v0[766 -(745 + 21) ]=v8("\194\192\201\44\246\175\137\18\196\194","\126\177\163\187\69\134\219\167");local v33=...;local v34={};local v35=require;local function v36(v41,...) local v42=v34[v41];if  not v42 then return v35(v41,v33,...);end return v42(v33,...);end v34[v0[0 + 0 ]]=function(...) local v43,v44=...;local v45=HeroCache;local v46=gmatch;local v47=pairs;local v48=string.upper;local v49=table.insert;local v50=tonumber;local v51=type;local v52={};v44.Utils=v52;v52.BoolToInt=function(v74) return (v74 and (2 -1)) or (0 -0) ;end;v52.IntToBool=function(v75) return v75~=(0 + 0) ;end;v52.UpperCaseFirst=function(v76) return (v76:gsub(v0[7 + 1 ],v48));end;v52.ValueIsInTable=function(v77,v78) for v125,v126 in v47(v77) do if (v126==v78) then return true;end end return false;end;v52.ValueIsInArray=function(v79,v80) for v127=1056 -(87 + 968) , #v79 do local v128=v79[v127];if (v128==v80) then return true;end end return false;end;v52.FindValueIndexInArray=function(v81,v82) for v129=4 -3 , #v81 do local v130=v81[v129];if (v130==v82) then return v129;end end end;v52.MergeTable=function(v83,v84) local v85={};for v131,v132 in v47(v83) do v49(v85,v132);end for v133,v134 in v47(v84) do v49(v85,v134);end return v85;end;v52.MergeTableByKey=function(v86,v87) local v88={};for v135,v136 in v47(v86) do v88[v135]=v136;end for v138,v139 in v47(v87) do v88[v138]=v139;end return v88;end;local v62={[">"]=function(v89,v90) return v89>v90 ;end,["<"]=function(v91,v92) return v91<v92 ;end,[v0[15 + 1 ]]=function(v93,v94) return v93>=v94 ;end,[v0[38 -21 ]]=function(v95,v96) return v95<=v96 ;end,[v0[1431 -(447 + 966) ]]=function(v97,v98) return v97==v98 ;end,[v0[51 -32 ]]=function(v99,v100) return v99<v100 ;end,[v0[1837 -(1703 + 114) ]]=function(v101,v102) return v101>v102 ;end};v52.CompareThis=function(v103,v104,v105) return v62[v103](v104,v105);end;v52.StringToNumberIfPossible=function(v106) local v107=v50(v106);return ((v107~=nil) and v107) or v106 ;end;v52.SubStringCount=function(v108,v109) local v110=701 -(376 + 325) ;for v141 in v108:gmatch(v109) do v110=v110 + (1 -0) ;end return v110;end;v52.StartsWith=function(v111,v112) return v111:sub(2 -1 , #v112)==v112 ;end;v52.EndsWith=function(v113,v114) return (v114=="") or (v113:sub( -#v114)==v114) ;end;v52.RevertTableIndex=function(v115) local v116={};for v142= #v115,1 + 0 , -(2 -1) do v49(v116,v115[v142]);end return v116;end;v52.SortASC=function(v117,v118) return v117<v118 ;end;v52.SortDESC=function(v119,v120) return v119>v120 ;end;v52.SortMixedASC=function(v121,v122) if ((v51(v121)==v0[48 -(9 + 5) ]) and (v51(v122)==v0[411 -(85 + 291) ])) then return v121<tostring(v122) ;elseif ((v51(v121)==v0[1301 -(243 + 1022) ]) and (v51(v122)==v0[140 -103 ])) then return v122<tostring(v121) ;else return v121<v122 ;end end;v52.ShortenHotKey=function(v123) local v124=v123:upper():gsub(" ",""):gsub(v0[37 + 7 ],"A"):gsub(v0[1227 -(1123 + 57) ],"C"):gsub(v0[41 + 9 ],"S"):gsub(v0[307 -(163 + 91) ],"M"):gsub(v0[1986 -(1869 + 61) ],"N"):gsub(v0[17 + 42 ],"%/"):gsub(v0[218 -156 ],v0[96 -33 ]):gsub(v0[9 + 56 ],v0[89 -23 ]):gsub(v0[64 + 4 ],v0[1543 -(1329 + 145) ]);return v124;end;end;return v34[v0[1041 -(140 + 831) ]](...);
