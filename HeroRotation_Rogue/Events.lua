local v0={};local v1=string.char;local v2=string.byte;local v3=string.sub;local v4=bit32 or bit ;local v5=v4.bxor;local v6=table.concat;local v7=table.insert;local function v8(v115,v116) local v117={};for v140=1, #v115 do v7(v117,v1(v5(v2(v3(v115,v140,v140 + 1 )),v2(v3(v116,1 + (v140% #v116) ,1 + (v140% #v116) + 1 )))%256 ));end return v6(v117);end v0[120]=v8("\254\215\56\215\54\242\196\60\200\46\242\212\40\216\57\232\212\46","\122\173\135\125\155");v0[117]=v8("\1\45\243\141\221\226\130\20\48\231\157\200\253\152\31\53\237\151\208\241\147\22\36\246","\221\81\97\178\212\152\176");v0[113]=v8("\48\33\43\121\252\87\0\41\44\60\143\113\6\96\44\115\230\52","\20\114\64\88\28\220");v0[108]=v8("\242\37\36\219\37\79\148\232\33\62\208\38","\217\161\114\109\149\98\16");v0[107]=v8("\113\119\96\8\94\131","\45\61\22\19\124\19\203");v0[106]=v8("\31\83\65\226\214\27","\153\83\50\50\150");v0[104]=v8("\141\195\42\107\164\129\208\34\104\162\153\209","\227\222\148\99\37");v0[103]=v8("\232\202\0\208\112\222","\200\164\171\115\164\61\150");v0[102]=v8("\62\252\38\32\89\58","\22\114\157\85\84");v0[101]=v8("\215\162\163\218\188\83\75","\57\148\205\214\180\200\54");v0[100]=v8("\149\186\243\222\162\176\244","\176\214\213\134");v0[98]=v8("\137\189\141\254\150\178\141\252\159\191\143\251\128\168","\178\218\237\200");v0[97]=v8("\154\44\190\122\171\186\87","\212\217\67\203\20\223\223\37");v0[95]=v8("\126\60\22\67\107\34\8\95\96\36\18\72\103\62\16\69\121\63\5\86\106","\26\46\112\87");v0[94]=v8("\104\75\221\97\31\108","\80\36\42\174\21");v0[93]=v8("\206\35\244\72\86\89","\166\130\66\135\60\27\17");v0[92]=v8("\48\218\151\245\254\194\1","\167\115\181\226\155\138");v0[90]=v8("\18\141\105\178\37\135\110","\220\81\226\28");v0[88]=v8("\112\4\211\187\13\240","\184\60\101\160\207\66");v0[87]=v8("\238\128\5\234\20\198","\56\162\225\118\158\89\142");v0[86]=v8("\37\184\138\235\223\39","\186\85\212\235\146");v0[85]=v8("\222\194\1\219\90\178\239","\215\157\173\116\181\46");v0[83]=v8("\18\62\234\229\17\23","\145\94\95\153");v0[82]=v8("\196\12\74\234\246\202","\78\136\109\57\158\187\130\226");v0[81]=v8("\226\77\39\216\17\196\80","\101\161\34\82\182");v0[80]=v8("\182\130\22\39\100\113\170\164\129\7\52\123\123\170\166\151\0\56","\233\229\210\83\107\40\46");v0[75]=v8("\210\248\23\214\195\15\217\108\196\250\21\211\213\21","\34\129\168\82\154\143\80\156");v0[68]=v8("\130\203\80\193\214\239\146\214\77\199\198\242\146\193","\171\215\133\25\149\137");v0[67]=v8("\16\255\115\110\140\1\248\127\126","\211\69\177\58\58");v0[66]=v8("\24\59\197\79\63\60\208","\59\74\78\181");v0[65]=v8("\190\232\92\38\7\94\127","\26\236\157\44\82\114\44");v0[64]=v8("\208\242\46\192\248\231\57","\178\151\147\92");v0[63]=v8("\167\166\213\233\88\235\133","\159\224\199\167\155\55");v0[62]=v8("\215\99\252\160\54\34\137\192\116\248\189\32\62\147","\231\148\17\149\205\69\77");v0[61]=v8("\232\101\45\89\238\60\198\255\114\41\68\248\32\220","\168\171\23\68\52\157\83");v0[59]=v8("\212\50\223\229\203\61\219\252\213\35\197\251\194\47\213\255\194\38","\169\135\98\154");v0[58]=v8("\5\78\207\61\149\68\91","\62\87\59\191\73\224\54");v0[57]=v8("\151\191\51\10\6\22\194","\49\197\202\67\126\115\100\167");v0[56]=v8("\139\47\185\89\200\67\27","\105\204\78\203\43\167\55\126");v0[55]=v8("\38\51\20\40\82\21\55","\61\97\82\102\90");v0[54]=v8("\199\99\117\68\200\64\238\208\116\113\89\222\92\244","\128\132\17\28\41\187\47");v0[53]=v8("\115\168\200\182\67\181\207\143\85\183\209\190\67\174","\219\48\218\161");v0[51]=v8("\65\113\82\169\210\180\83\116\69\164\193\185\87\103\69\160\205\163","\235\18\33\23\229\158");v0[50]=v8("\24\188\21\128\133\130\23\30\190\17\147\136\141\6\7\165\21\136","\86\75\236\80\204\201\221");v0[49]=v8("\124\2\33\188\228\162\64","\58\46\119\81\200\145\208\37");v0[48]=v8("\157\85\164\82\181\64\179","\32\218\52\214");v0[47]=v8("\109\149\234\32\93\136\237\25\75\138\243\40\93\147","\77\46\231\131");v0[45]=v8("\128\24\42\208\252\100\144\9\60\200\239\104\134\11\44\217\227\104","\59\211\72\111\156\176");v0[39]=v8("\34\67\147\159\147\60\168","\144\112\54\227\235\230\78\205");v0[38]=v8("\124\47\166\68\66\79\43","\45\59\78\212\54");v0[37]=v8("\25\4\253\184\41\25\250\129\63\27\228\176\41\2","\213\90\118\148");v0[33]=v8("\176\56\181\94\201\82\20","\113\226\77\197\42\188\32");v0[32]=v8("\95\134\60\5\119\147\43","\119\24\231\78");v0[31]=v8("\252\13\253\17\41\208\17\192\25\55\207\26\231\8","\90\191\127\148\124");v0[30]=v8("\206\131\117\105\80\224\220\134\98\100\67\237\216\158\127\115\89\251","\191\157\211\48\37\28");v0[28]=v8("\15\1\44\151\53\212\0\0\14\16\54\137\60\205\19\16\15\25","\85\92\81\105\219\121\139\65");v0[25]=v8("\17\104\18\244\242\43\199\23\106\22\231\255\36\214\14\113\18\252","\134\66\56\87\184\190\116");v0[21]=v8("\163\198\30\206\215\183","\129\202\168\109\171\165\195\183");v0[20]=v8("\185\32\109","\143\216\66\30\126\68\155");v0[19]=v8("\67\162\222","\196\46\203\176\18\79\163\45");v0[18]=v8("\163\93\43","\81\206\60\83\91\79");v0[17]=v8("\51\232\79\74\118","\19\97\135\40\63");v0[15]=v8("\148\205\37\65","\44\221\185\64");v0[14]=v8("\120\195\189\64\23","\29\43\179\216\44\123");v0[13]=v8("\179\77\234\125","\207\225\44\131\25");v0[12]=v8("\33\244\171\200\215","\235\113\149\217\188\174\24");v0[11]=v8("\169\251\194\131\151\246\206\146\130","\230\231\154\175");v0[10]=v8("\41\86\69\88","\227\107\57\54\43\157");v0[9]=v8("\196\68\95\198\228","\168\133\54\58");v0[8]=v8("\119\219\149\239\95\251\150\249\72","\156\58\180\224");v0[7]=v8("\86\226\67\77\51","\46\16\141\32\56\64");v0[6]=v8("\245\195\40\201\183\66","\146\161\162\90\174\210\54\106");v0[5]=v8("\124\56\242","\224\44\93\134\165\173\193\30");v0[4]=v8("\5\63\172\97\217\39","\188\85\83\205\24");v0[3]=v8("\113\184\226\58","\113\36\214\139\78\100\39\172");v0[2]=v8("\106\82\237\77\203","\101\63\38\132\33\184\175\204");v0[1]=v8("\58\17\214\184\104\220\174\216\10\6","\180\127\103\179\214\28\175\128");v0[0]=v8("\142\24\205\1","\100\232\113\161");local v87,v88=...;local v89=HeroLib;local v90,v91=HeroCache,v89[v0[2]];local v92=v89[v0[3]];local v93,v94,v95=v92[v0[4]],v92[v0[5]],v92[v0[6]];local v96,v97=v92[v0[7]],v92[v0[8]];local v98,v99,v100=v92[v0[9]],v92[v0[10]],v92[v0[11]];local v101,v102=v92[v0[12]],v92[v0[13]];local v103=v89[v0[14]];local v104=v89[v0[15]];local v105=HeroRotation();local v106=v105.Commons()[v0[17]];local v107=C_Timer;local v108=math[v0[18]];local v109=math[v0[19]];local v110=math[v0[20]];local v111=pairs;local v112=table[v0[21]];local v113=UnitAttackSpeed;local v114=GetTime;do local v118=v114();v106.RtBRemains=function(v141) local v142=(v118-v114()) -v89.RecoveryOffset(v141) ;return ((v142>=(0 -0)) and v142) or (0 -0) ;end;v89:RegisterForSelfCombatEvent(function(v143,v143,v143,v143,v143,v143,v143,v143,v143,v143,v143,v144) if (v144==(609035 -293527)) then v118=v114() + (77 -47) ;end end,v0[25]);v89:RegisterForSelfCombatEvent(function(v145,v145,v145,v145,v145,v145,v145,v145,v145,v145,v145,v146) if (v146==(316127 -(555 + 64))) then v118=v114() + v109(971 -(857 + 74) ,(598 -(367 + 201)) + v106.RtBRemains(true) ) ;end end,v0[28]);v89:RegisterForSelfCombatEvent(function(v147,v147,v147,v147,v147,v147,v147,v147,v147,v147,v147,v148) if (v148==(316435 -(214 + 713))) then v118=v114();end end,v0[30]);end do local v120={[v0[31]]={},[v0[32]]={},[v0[33]]={}};v106.Exsanguinated=function(v149,v150) local v151=v149:GUID();if  not v151 then return false;end local v152=v150:ID();if (v152==(30391 + 91020)) then return v120[v0[37]][v151] or false ;elseif (v152==(111 + 592)) then return v120[v0[38]][v151] or false ;elseif (v152==(2820 -(282 + 595))) then return v120[v0[39]][v151] or false ;end return false;end;v106.WillLoseExsanguinate=function(v153,v154) if v106.Exsanguinated(v153,v154) then return true;end return false;end;v106.ExsanguinatedRate=function(v155,v156) if v106.Exsanguinated(v155,v156) then return 1639 -(1523 + 114) ;end return 1 + 0 ;end;v89:RegisterForSelfCombatEvent(function(v157,v157,v157,v157,v157,v157,v157,v158,v157,v157,v157,v159) if (v159==(286266 -85460)) then for v204,v205 in v111(v120) do for v206,v207 in v111(v205) do if (v206==v158) then v205[v206]=true;end end end end end,v0[45]);v89:RegisterForSelfCombatEvent(function(v160,v160,v160,v160,v160,v160,v160,v161,v160,v160,v160,v162) if (v162==(122476 -(68 + 997))) then v120[v0[47]][v161]=false;elseif (v162==(1973 -(226 + 1044))) then v120[v0[48]][v161]=false;elseif (v162==(8460 -6517)) then v120[v0[49]][v161]=false;end end,v0[50],v0[51]);v89:RegisterForSelfCombatEvent(function(v163,v163,v163,v163,v163,v163,v163,v164,v163,v163,v163,v165) if (v165==(121528 -(32 + 85))) then if (v120[v0[53]][v164]~=nil) then v120[v0[54]][v164]=nil;end elseif (v165==(689 + 14)) then if (v120[v0[55]][v164]~=nil) then v120[v0[56]][v164]=nil;end elseif (v165==(431 + 1512)) then if (v120[v0[57]][v164]~=nil) then v120[v0[58]][v164]=nil;end end end,v0[59]);v89:RegisterForCombatEvent(function(v166,v166,v166,v166,v166,v166,v166,v167) if (v120[v0[61]][v167]~=nil) then v120[v0[62]][v167]=nil;end if (v120[v0[63]][v167]~=nil) then v120[v0[64]][v167]=nil;end if (v120[v0[65]][v167]~=nil) then v120[v0[66]][v167]=nil;end end,v0[67],v0[68]);end do local v124=v103(196584 -(892 + 65) );local v125=0 -0 ;local v126=v114();v106.FanTheHammerCP=function() if (((v114() -v126)<(0.5 -0)) and (v125>(0 -0))) then if (v125>v93:ComboPoints()) then return v125;else v125=350 -(87 + 263) ;end end return 180 -(67 + 113) ;end;v89:RegisterForSelfCombatEvent(function(v168,v168,v168,v168,v168,v168,v168,v168,v168,v168,v168,v169,v168,v168,v170,v171) if (v169==(136215 + 49548)) then if ((v114() -v126)>(0.5 -0)) then v125=v109(v106.CPMaxSpend(),v93:ComboPoints() + v170 + (v108(0 + 0 ,v170-(3 -2) ) * v109(954 -(802 + 150) ,v93:BuffStack(v124) -(2 -1) )) );v126=v114();end end end,v0[75]);end do local v128,v129=0 -0 ,0 + 0 ;local v130=v103(278922 -(915 + 82) );v106.TimeToNextTornado=function() if  not v93:BuffUp(v130,nil,true) then return 0 -0 ;end local v172=v93:BuffRemains(v130,nil,true)%(1 + 0) ;if (v114()==v128) then return 0 -0 ;elseif (((v114() -v128)<(1187.1 -(1069 + 118))) and (v172<(0.25 -0))) then return 1 -0 ;elseif (((v172>(0.9 + 0)) or (v172==(0 -0))) and ((v114() -v128)>(0.75 + 0))) then return 791.1 -(368 + 423) ;end return v172;end;v89:RegisterForSelfCombatEvent(function(v173,v173,v173,v173,v173,v173,v173,v173,v173,v173,v173,v174) if (v174==(668582 -455839)) then v128=v114();elseif (v174==(197853 -(10 + 8))) then v129=v114();end if (v129==v128) then v128=0 -0 ;end end,v0[80]);end do local v132={[v0[81]]=442 -(416 + 26) ,[v0[82]]=0 -0 ,[v0[83]]=0 + 0 };v106.TimeToSht=function(v175) if (v132[v0[85]]>=v175) then return 0 -0 ;end local v176,v177=v113(v0[86]);local v178=v108(v132[v0[87]] + v176 ,v114());local v179=v108(v132[v0[88]] + v177 ,v114());local v180={};for v194=438 -(145 + 293) ,432 -(44 + 386)  do v112(v180,v178 + (v194 * v176) );v112(v180,v179 + (v194 * v177) );end table.sort(v180);local v181=v109(1491 -(998 + 488) ,v108(1 + 0 ,v175-v132[v0[90]] ));return v180[v181] -v114() ;end;v89:RegisterForSelfCombatEvent(function() v132[v0[92]]=0 + 0 ;v132[v0[93]]=v114();v132[v0[94]]=v114();end,v0[95]);v89:RegisterForSelfCombatEvent(function(v185,v185,v185,v185,v185,v185,v185,v185,v185,v185,v185,v186) if (v186==(197683 -(201 + 571))) then v132[v0[97]]=1138 -(116 + 1022) ;end end,v0[98]);v89:RegisterForSelfCombatEvent(function(v187,v187,v187,v187,v187,v187,v187,v187,v187,v187,v187,v187,v187,v187,v187,v187,v187,v187,v187,v187,v187,v187,v187,v188) v132[v0[100]]=v132[v0[101]] + (4 -3) ;if v188 then v132[v0[102]]=v114();else v132[v0[103]]=v114();end end,v0[104]);v89:RegisterForSelfCombatEvent(function(v190,v190,v190,v190,v190,v190,v190,v190,v190,v190,v190,v190,v190,v190,v190,v191) if v191 then v132[v0[106]]=v114();else v132[v0[107]]=v114();end end,v0[108]);end do local v134=v93:CritChancePct();local v135=0 + 0 ;local function v136() if  not v93:AffectingCombat() then v134=v93:CritChancePct();v89.Debug(v0[113]   .. v134 );end if ((v135==nil) or (v135<(0 -0))) then v135=0 -0 ;else v135=v135-(860 -(814 + 45)) ;end if (v135>(0 -0)) then v107.After(1 + 2 ,v136);end end v89:RegisterForEvent(function() if (v135==(0 + 0)) then v107.After(888 -(261 + 624) ,v136);v135=3 -1 ;end end,v0[117]);v106.BaseAttackCrit=function() return v134;end;end do local v138=1080 -(1020 + 60) ;v89:RegisterForSelfCombatEvent(function(v192,v192,v192,v192,v192,v192,v192,v192,v192,v192,v192,v193) if (v193==(53113 -(630 + 793))) then v138=6 -4 ;end if ((v193==(915299 -721984)) or (v193==(3417 + 5259)) or (v193==(1480587 -1050564))) then if (v138>(1747 -(760 + 987))) then v138=v138-(1914 -(1789 + 124)) ;end end end,v0[120]);v106.DisorientingStrikesCount=function() return v138;end;end