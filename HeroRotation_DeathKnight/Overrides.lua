local v0={};local v1=string.char;local v2=string.byte;local v3=string.sub;local v4=bit32 or bit ;local v5=v4.bxor;local v6=table.concat;local v7=table.insert;local function v8(v60,v61) local v62={};for v98=1, #v60 do v7(v62,v1(v5(v2(v3(v60,v98,v98 + 1 )),v2(v3(v61,1 + (v98% #v61) ,1 + (v98% #v61) + 1 )))%256 ));end return v6(v62);end v0[52]=v8("\228\19\6\202\179\110\200\240\17\35\231\191\127\141\221\17\0","\230\180\127\103\179\214\28");v0[50]=v8("\16\138\183\67\8\145\48\3\54\133\170\64\16","\112\69\228\223\44\100\232\113");v0[49]=v8("\140\205\31\243\121\250\180\205\3\245","\150\205\189\112\144\24");v0[47]=v8("\41\253\189\188\160\243\142\9\204\174\177\165\177\166\24\225\189","\199\122\141\216\208\204\221");v0[44]=v8("\183\37\223\7\235\132\34\217\34\235\128\43\216\23\195\132\46\216\20\225","\135\225\76\173\114");v0[43]=v8("\52\32\187\60\75\58\32\18","\73\113\80\210\88\46\87");v0[42]=v8("\240\31\135\251\198\141\38\145\197\207\194\11\155","\170\163\111\226\151");v0[38]=v8("\28\15\144\205\158\42\15\140\213\172\55\28\143\199\190\49\1\140","\202\88\110\226\166");v0[36]=v8("\224\231\56\161\163\218\14\211\226","\107\178\134\81\210\198\158");v0[35]=v8("\139\249\222\200\180\167\242\215\155\232\200\208\185\235\215\193","\164\216\137\187");v0[32]=v8("\106\95\12\58\34\201\23\89\90","\114\56\62\101\73\71\141");v0[31]=v8("\231\212\235\80\216\138\199\79\247\197\253\72\213\198\226\89","\60\180\164\142");v0[27]=v8("\102\36\94\33\32\76\182\116\39\81\61\54\74\247\68\37\107\49\38\85\241\88\47","\152\54\72\63\88\69\62");v0[21]=v8("\55\226\164\215\2\252\235\234\9\202\145\199\4\229\172\192\0","\174\103\142\197");v0[18]=v8("\250\47\41\147\177\61\249\201\42","\156\168\78\64\224\212\121");v0[17]=v8("\244\68\117\24\181\80\238\71\83\21\170\10\198\86\124\17","\126\167\52\16\116\217");v0[15]=v8("\35\19\184\63\15\61\183\34\0\30\173","\75\103\118\217");v0[13]=v8("\190\254\58\82\244\190","\199\235\144\82\61\152");v0[12]=v8("\146\236\43\223\16\133\61\206\177\225\62","\167\214\137\74\171\120\206\83");v0[11]=v8("\42\220\81\97\106","\135\108\174\62\18\30\23\147");v0[10]=v8("\159\220\67\73\22\144\215\75\90\22\175","\126\219\185\34\61");v0[9]=v8("\11\205\35\135\45","\232\73\161\76");v0[8]=v8("\239\57\38\242\214\129\197\53\32\238\202","\202\171\92\71\134\190");v0[7]=v8("\43\174\142\58","\185\98\218\235\87");v0[6]=v8("\143\211\210\6\14","\75\220\163\183\106\98");v0[5]=v8("\125\67\18\34\76\86","\69\41\34\96");v0[4]=v8("\102\204\180","\219\54\169\192\90\48\80");v0[3]=v8("\225\211\140\53\132\173","\223\177\191\237\76\225");v0[2]=v8("\65\244\213\32","\115\20\154\188\84");v0[1]=v8("\136\147\70\186\111\117\83\162\150\13\164\104\125","\55\199\229\35\200\29\28");v0[0]=v8("\250\73\116\224","\86\156\32\24\133\29\38");local v40=HeroLib;local v41=HeroCache;local v42=v40[v0[2]];local v43=v42[v0[3]];local v44=v42[v0[4]];local v45=v42[v0[5]];local v46=v40[v0[6]];local v47=v40[v0[7]];local v48=HeroRotation();local v49=v46[v0[8]][v0[9]];local v50=v46[v0[10]][v0[11]];local v51=v46[v0[12]][v0[13]];local v52=GetTime;local v53=next;local v54=v48.Commons()[v0[15]];local v55;v55=v40.AddCoreOverride(v0[17],function(v63,v64,v65,v66,v67,v68) local v69=v55(v63,v64,v65,v66,v67,v68);if (v63==v49[v0[18]]) then return  not v44:IsActive() and v69 ;else return v69;end end,781 -531 );v40.AddCoreOverride(v0[21],function(v70) if (v53(v54.DnDTable)==nil) then return false;end local v71=false;for v99,v100 in pairs(v54.DnDTable) do if ((v52() -v100)<(2.25 -1)) then v71=true;end end if (v71 and v43:BuffUp(v49.DeathAndDecayBuff)) then return true;end return false;end,482 -232 );v40.AddCoreOverride(v0[27],function(v72) if (v53(v54.BonestormTable)==nil) then return false;end for v101,v102 in pairs(v54.BonestormTable) do if ((v52() -v102)<(2.25 -1)) then return true;end end return false;end,869 -(555 + 64) );local v56;v56=v40.AddCoreOverride(v0[31],function(v73,v74,v75,v76,v77,v78) local v79=v56(v73,v74,v75,v76,v77,v78);if (v73==v50[v0[32]]) then return  not v44:IsActive() and v79 ;else return v79;end end,1182 -(857 + 74) );local v57;v57=v40.AddCoreOverride(v0[35],function(v80,v81,v82,v83,v84,v85) local v86=v57(v80,v81,v82,v83,v84,v85);if (v80==v51[v0[36]]) then return  not v44:IsActive() and v86 ;elseif (v80==v51[v0[38]]) then return v44:IsActive() and (v44:NPCID()==(26693 -(367 + 201))) and v86 ;else return v86;end end,1179 -(214 + 713) );local v58;v58=v40.AddCoreOverride(v0[42],function(v87,v88,v89,v90,v91,v92) local v93=v58(v87,v88,v89,v90,v91,v92);if (v87==v51[v0[43]]) then return (v51[v0[44]]:AuraActiveCount()>(1 + 0)) and v93 ;else return v93;end end,40 + 212 );local v59;v59=v40.AddCoreOverride(v0[47],function(v94) local v95=v59(v94);if ( not v48.CDsON() and ((v94==v51[v0[49]]) or (v94==v51[v0[50]]))) then return false;else return v95;end end,1129 -(282 + 595) );v40.AddCoreOverride(v0[52],function(v96) if (v53(v54.DnDTable)==nil) then return false;end local v97=false;for v103,v104 in pairs(v54.DnDTable) do if ((v52() -v104)<(1638.25 -(1523 + 114))) then v97=true;end end if (v97 and v43:BuffUp(v51.DeathAndDecayBuff)) then return true;end return false;end,227 + 25 );