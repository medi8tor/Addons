local v0=string.char;local v1=string.byte;local v2=string.sub;local v3=bit32 or bit ;local v4=v3.bxor;local v5=table.concat;local v6=table.insert;local function v7(v15,v16) local v17={};for v36=1, #v15 do v6(v17,v0(v4(v1(v2(v15,v36,v36 + 1 )),v1(v2(v16,1 + (v36% #v16) ,1 + (v36% #v16) + 1 )))%256 ));end return v5(v17);end local v8=v3.bor;local v9=v3.band;local v10=...;local v11={};local v12=require;local function v13(v18,...) local v19=0;local v20;while true do local v37=0 + 0 ;while true do if ((0 + 0)==v37) then if ((1==v19) or (3860>4872)) then return v20(v10,...);end if (v19==(0 + 0)) then v20=v11[v18];if  not v20 then return v12(v18,v10,...);end v19=1;end break;end end end end v11[v7("\249\198\201\42\197\186\196\22\212\252\246\36\239\181\137\18\196\194","\126\177\163\187\69\134\219\167")]=function(...) local v21=string[v7("\32\197\43\215","\156\67\173\74\165")];local v22=string[v7("\54\174\93\19","\38\84\215\41\118\220\70")];local v23=string[v7("\67\3\32","\158\48\118\66\114")];local v24=bit32 or bit ;local v25=v24[v7("\169\60\31\36","\155\203\68\112\86\19\197")];local v26=table[v7("\69\210\56\255\65\108","\152\38\189\86\156\32\24\133")];local v27=table[v7("\245\89\180\67\238\67","\38\156\55\199")];local function v28(v38,v39) local v40=0;local v41;while true do local v66=0;while true do if ((0==v66) or (3998==2298)) then if (v40==1) then return v26(v41);end if (v40==0) then local v141=0;while true do if (v141==0) then v41={};for v183=1, #v38 do v27(v41,v21(v25(v22(v23(v38,v183,v9(v183,1) + v8(v183,1) )),v22(v23(v39,v9(2 -1 ,v183% #v39 ) + v8(1,v183% #v39 ) ,v9((4 -3) + (v183% #v39) ,790 -(766 + 23) ) + v8((4 -3) + (v183% #v39) ,1) )))%256 ));end v141=388 -(370 + 17) ;end if ((v141==1) or (8>=2739)) then v40=1;break;end end end break;end end end end local v29=v24[v7("\170\114\110","\35\200\29\28\72\115\20\154")];local v30=v24[v7("\27\190\223\219","\84\121\223\177\191\237\76")];local v31=...;local v32={};local v33=v13;local function v34(v42,...) local v43=0 -0 ;local v44;local v45;local v46;while true do if ((2590==2590) and (v43==(1292 -(783 + 508)))) then v46=nil;while true do if ((v44==1) or (82>=1870)) then while true do local v148=1772 -(1733 + 39) ;local v149;local v150;local v151;while true do if (v148==(3 -2)) then v151=nil;while true do if ((2624<4557) and (v149==0)) then local v200=0 -0 ;while true do if (v200==0) then v150=1898 -(v9(1294 -(125 + 909) ,3586 -(1096 + 852) ) + v8(260,1638)) ;v151=nil;v200=1;end if ((v200==(1074 -(1036 + 37))) or (3131>3542)) then v149=1 + 0 ;break;end end end if ((2577>=1578) and (v149==1)) then while true do if ((713<=847) and (v150==(440 -(v9(271 + 111 ,82 -24 ) + v8(382,58))))) then v151=0;while true do if ((4103<=4571) and (v151==0)) then if ((v45~=(1 -0)) or (1495==4787)) then else return v46(v31,...);end if ((2154<=(3910 + 121)) and (v45==0)) then local v241=0;while true do if ((v241==(512 -(409 + 103))) or (310>4434)) then v46=v32[v42];if ((2168<=4360) and (4615==(4851 -(46 + 190))) and  not v46) then return v33(v42,v31,...);end v241=1481 -(641 + 839) ;end if (v241==(914 -(910 + 3))) then v45=2 -1 ;break;end end end break;end end break;end end break;end end break;end if (v148==0) then v149=0;v150=nil;v148=1;end end end break;end if ((994==994) and (v44==(95 -(51 + 44)))) then local v142=0;while true do if ((1655>401) and ((1685 -(1466 + 218))==v142)) then v44=1;break;end if ((3063<=3426) and (v142==(0 + 0))) then v45=0;v46=nil;v142=1 + 0 ;end end end end break;end if ((1459>764) and (v43==0)) then v44=0;v45=nil;v43=1;end end end v32[v28("\249\198\201\42\197\186\196\22\212\252\246\36\239\181\137\18\196\194","\126\177\163\187\69\134\219\167")]=function(...) local v47,v48=...;local v49=wipe;if ( not HeroCacheDB or (3790==500) or (641>4334)) then local v77=0;local v78;while true do if ((3399>=2260) and (v77==(1148 -(556 + 592)))) then v78=0;while true do if ((89<(79 + 142)) and (0==v78)) then _G[v28("\11\200\56\202\223\34\206\34\192\216\1","\156\67\173\74\165")]={};HeroCacheDB[v28("\17\185\72\20\176\35\66","\38\84\215\41\118\220\70")]=true;break;end end break;end end end HeroCache=v48;ADS={};ADS[v28("\125\19\46\23\251","\158\48\118\66\114")]={};ADS[v28("\153\37\30\49\118\161","\155\203\68\112\86\19\197")]={};v48[v28("\103\237\26\202\65\106","\152\38\189\86\156\32\24\133")]={};v48[v28("\217\89\162\75\245\82\180","\38\156\55\199")]={[v28("\129\105\121\37\50\119\238\74\167\115","\35\200\29\28\72\115\20\154")]={},[v28("\52\186\221\218\136","\84\121\223\177\191\237\76")]={},[v28("\137\87\199\167\63\84","\161\219\54\169\192\90\48\80")]={},[v28("\122\82\5\41\69","\69\41\34\96")]={},[v28("\143\211\210\6\14\10\191\215\222\5\12","\75\220\163\183\106\98")]={}};v48[v28("\37\143\162\19\240\12\188\132","\185\98\218\235\87")]={};v48[v28("\230\53\52\229\247\164\205\51","\202\171\92\71\134\190")]={};v48[v28("\26\209\41\132\37\232\34\142\38","\232\73\161\76")]={};v48[v28("\146\205\71\80\55\181\223\77","\126\219\185\34\61")]={};v48[v28("\57\192\87\102\87\121\245\232","\135\108\174\62\18\30\23\147")]={};v48[v28("\134\236\56\216\17\189\39\194\184\253","\167\214\137\74\171\120\206\83")]={[v28("\174\225\39\84\232\170\142\254\38","\199\235\144\82\61\152")]={},[v28("\51\31\188\57\52\19\173\56","\75\103\118\217")]={},[v28("\247\88\113\13\188\12","\126\167\52\16\116\217")]={[v28("\235\34\33\147\167","\156\168\78\64\224\212\121")]={UnitClass(v28("\23\226\164\215\2\252","\174\103\142\197"))},[v28("\101\56\90\59","\152\54\72\63\88\69\62")]={},[v28("\252\193\252\83\224\214\235\89\199","\60\180\164\142")]={},[v28("\121\93\17\32\49\232\58\93\76\10\29\53\232\23","\114\56\62\101\73\71\141")]={},[v28("\153\234\207\205\174\236\243\193\170\230\239\214\189\236\242\224","\164\216\137\187")]={}},[v28("\240\233\62\185\143\240\15\215\254","\107\178\134\81\210\198\158")]={[v28("\8\11\150","\202\88\110\226\166")]={},[v28("\243\3\131\238\207\209","\170\163\111\226\151")]={}},[v28("\34\32\183\52\66\27\44\16\34\188\61\74","\73\113\80\210\88\46\87")]={[v28("\177\41\217","\135\225\76\173\114")]={},[v28("\42\225\185\169\169\175","\199\122\141\216\208\204\221")]={}},[v28("\153\216\8\228\109\228\168","\150\205\189\112\144\24")]={[v28("\22\148\186\64\8","\112\69\228\223\44\100\232\113")]={},[v28("\253\11\2\222","\230\180\127\103\179\214\28")]={},[v28("\175\16\76\82\235\76","\128\236\101\63\38\132\33")]={}},[v28("\137\165\7\113\159\219\206\171\160\31\67","\175\204\201\113\36\214\139")]={PagingString,[v28("\119\205\50\213\10\64\255\33\206\13\73\203\38","\100\39\172\85\188")]={},[v28("\157\121\190\137\61\170\90\184\146\32","\83\205\24\217\224")]={}},[v28("\210\196\193\56\232\209\222","\93\134\165\173")]={Rank}};v48[v28("\150\243\210\224\63\203\188\76\187\225\196\214","\30\222\146\161\162\90\174\210")]=false;v48.Reset=function() if (((2908 -(174 + 680))>=(4882 -3461)) and  not v48[v28("\205\79\99\40\224\75\126\56\224\93\117\30","\106\133\46\16")]) then local v114=0;local v115;local v116;while true do if (((1317 -(1114 + 203))==v114) or (393>=4242)) then local v143=0;while true do if (1==v143) then v114=1;break;end if ((989<4859) and (v143==0)) then v115=0;v116=nil;v143=727 -(228 + 498) ;end end end if ((1 + 0)==v114) then while true do if (((383 + 309)<3058) and (v115==(0 + 0))) then v116=0;while true do if ((v116==1) or (3254==(2318 -(174 + 489))) or (4795<949)) then local v186=0;local v187;while true do if (v186==0) then v187=0 -0 ;while true do if (v187==(1907 -(830 + 1075))) then v116=526 -(303 + 221) ;break;end if ((1269 -(231 + 1038))==v187) then v49(v48[v28("\254\133\20\248\176\217\220","\175\187\235\113\149\217\188")].Spell);v49(v48[v28("\25\161\132\65\234\124\107","\24\92\207\225\44\131\25")].SpellAction);v187=1;end if ((3842==3842) and (v187==(1 + 0))) then v49(v48.GUIDInfo);v49(v48.MiscInfo);v187=741 -(396 + 343) ;end end break;end end end if ((v116==0) or (1296==4910)) then local v188=0;local v189;while true do if (v188==0) then v189=0;while true do if ((1747<=3601) and (v189==0)) then v49(v48.APLVar);v49(v48[v28("\125\46\118\241\83\69\75","\32\56\64\19\156\58")].ItemAction);v189=1;end if (v189==2) then v116=1163 -(171 + 991) ;break;end if (v189==1) then v49(v48[v28("\127\198\224\91\83\247\147","\224\58\168\133\54\58\146")].Melee);v49(v48[v28("\124\88\78\240\124\131\148","\107\57\54\43\157\21\230\231")].Ranged);v189=8 -6 ;end end break;end end end if ((3368==3368) and (v116==2)) then v49(v48.SpellInfo);v49(v48.ItemInfo);v49(v48.UnitInfo);v48[v28("\99\210\171\110\30\120\69\225\189\95\30\105","\29\43\179\216\44\123")]=true;break;end end break;end end break;end end end end;local v62;do local v67=select;local function v68(v79) local v80=0;local v81;local v82;while true do if ((v80==(2 -1)) or (804>4359)) then while true do local v144=0 + 0 ;local v145;local v146;while true do if ((4670>=3623) and (v144==0)) then v145=1477 -(29 + 1448) ;v146=nil;v144=1390 -(135 + 1254) ;end if (v144==1) then while true do if (v145~=(0 -0)) then else v146=0 -0 ;while true do if (((6595 -3952)<3815) and (v146==(0 -0))) then if (v81~=(1 + 0)) then else return v82;end if ((1913>(329 + 164)) and (v81==0)) then local v213=0;local v214;while true do if (v213==0) then v214=0 -0 ;while true do if ((2065<2544) and (4755>3428) and (v214==(1206 -(v9(902,303) + v8(902,303))))) then v81=1;break;end if ((1311<=3359) and (v214~=0)) then else local v252=0;local v253;while true do if (v252==0) then v253=0 -0 ;while true do if (v253==(0 -0)) then v82={};for v277=1,v79 do v82[v277]=string.format(v28("\188\156\36","\44\221\185\64"),v277);end v253=1;end if (v253==1) then v214=575 -(102 + 472) ;break;end end break;end end end end break;end end end break;end end break;end end break;end end end break;end if ((2717<=3156) and (v80==0)) then local v127=0 + 0 ;while true do if ((1081<4524) and (v127==1)) then v80=3 -2 ;break;end if ((440>=71) and (v127==0)) then v81=0;v82=nil;v127=1;end end end end end local function v69(v83,v84) local v85=0;local v86;local v87;local v88;while true do if (v85==(1249 -(111 + 1137))) then v88=nil;while true do local v147=1545 -(320 + 1225) ;while true do if ((4934>2607) and (v147~=0)) then else local v161=158 -(91 + 67) ;local v162;while true do if ((v161==(0 -0)) or (1400>3116)) then v162=0;while true do if (v162==1) then v147=1;break;end if ((525<1662) and (v162==0)) then if (((345 + 1036)<=2369) and (v86==((523 -(423 + 100)) -0))) then local v215=0;local v216;while true do if (v215==0) then v216=0;while true do if ((0 + 0)~=v216) then else local v254=0;local v255;while true do if ((v254==0) or (876>2550)) then v255=0;while true do if (v255==1) then v216=2 -1 ;break;end if ((219<=2456) and (v255==(0 + 0))) then v87= #v83;v88={};v255=1;end end break;end end end if ((v216==1) or (4843==4084)) then v86=1;break;end end break;end end end if ((4669>(190 + 173)) and (v86==2)) then local v217=0;local v218;while true do if (v217==0) then v218=1464 -(157 + 1307) ;while true do if ((v218~=(1859 -(821 + 1038))) or (4219==1150)) then else local v256=0;local v257;while true do if ((v256==0) or (2989<=222)) then v257=771 -(326 + 445) ;while true do if ((2258>1241) and (v257==(0 -0))) then local v276=0 -0 ;while true do if ((41<4259) and (v276==0)) then local v290=0;while true do if ((0 -0)==v290) then for v302=v84,v87-1  do v88[v9(v30( #v88,1),v29( #v88,1)) + v8(v30( #v88,1),v29( #v88,1)) ]=v28("\14\182","\196\46\203\176\18\79\163\45");end return table.concat(v88);end end end end end end break;end end end end break;end end end v162=2 -1 ;end end break;end end end if ((1==v147) or (1877>=3138)) then if (v86==(1 + 0)) then local v184=0;local v185;while true do if (v184==(0 -0)) then v185=0 + 0 ;while true do if (v185==0) then for v222=v84,v87-1  do v88[v9( #v88,2 -1 ) + v8( #v88,1) ]="["   .. v83[v222]   .. v28("\60\167\21\31\104\65","\19\97\135\40\63") ;end v88[v9(v30( #v88,(713 -(530 + 181)) -1 ),v29( #v88,882 -(614 + 267) )) + v8(v30( #v88,(713 -(530 + 181)) -1 ),v29( #v88,882 -(614 + 267) )) ]="["   .. v83[v87]   .. v28("\147\28\110\123\57\48\162","\81\206\60\83\91\79") ;v185=1;end if (v185==1) then v86=v9(1 -0 ,33 -(19 + 13) ) + v8(1,1) ;break;end end break;end end end break;end end end break;end if (v85==0) then local v128=0;local v129;while true do if (v128==0) then v129=0 -0 ;while true do if ((v129==(0 + 0)) or (1930<56)) then v86=0;v87=nil;v129=1 + 0 ;end if ((3333==3333) and (v129==1)) then v85=1;break;end end break;end end end end end local function v70(v89) local v90=0;local v91;local v92;local v93;local v94;while true do if ((1 -0)==v90) then local v130=0 + 0 ;local v131;while true do if ((v130==0) or (2225==20)) then v131=0 -0 ;while true do if (v131==0) then v93=nil;v94=nil;v131=1 -0 ;end if (v131==1) then v90=2;break;end end break;end end end if (v90==2) then while true do if ((4742>=(3930 -(300 + 4))) and (1==v91)) then v94=nil;while true do local v163=0;local v164;while true do if ((v163==0) or (872>=3092)) then v164=0;while true do if ((4404>=3252) and (1~=v164)) then else if (v92~=0) then else local v220=0;local v221;while true do if ((1107>796) and (v220==(1812 -(1293 + 519)))) then v221=0 -0 ;while true do if ((959==959) and (v221==(1 -0))) then v92=1;break;end if (((0 -0)==v221) or (245>=2204)) then if ((v89~=(1 -0)) or ((19576 -15036)==(2157 -1241))) then else return v28("\170\39\106\11\54\245\175\190\55\112\29\48\242\224\182\106\127\12\35\178\175\170\39\106\11\54\245\175\187\35\125\22\33\192\238\170\37\67\94\33\245\235","\143\216\66\30\126\68\155");end v93=v68(v89);v221=1 + 0 ;end end break;end end end break;end if ((3162>=2069) and (v164~=0)) then else local v205=0 + 0 ;while true do if (v205==0) then if ((1==v92) or (1156>(10885 -6540)) or (306>3081)) then local v232=0;local v233;local v234;local v235;while true do if (1==v232) then v235=nil;while true do if (v233==0) then local v264=0;while true do if (1==v264) then v233=1 + 0 ;break;end if (v264==(0 + 0)) then v234=(111 + 103) -(v9(22,192) + v8(22,192)) ;v235=nil;v264=1 + 0 ;end end end if ((v233==1) or (3513<2706)) then while true do if ((2978<3639) and (2237<4249) and (v234==0)) then v235=683 -(v9(240 + 243 ,200) + v8(483,200)) ;while true do if (v235~=(1463 -(v9(1043 + 361 ,136 -77 ) + v8(1404,59)))) then else local v291=0 -0 ;local v292;while true do if (v291==(0 + 0)) then v292=882 -(244 + 638) ;while true do if (v292==0) then v94={};for v310=1,v89-1  do v94[v310]=string.format(v28("\166\199\14\202\201\227\212\164\174\136\80\139\198\230\211\218\239\219\48\139\204\165\151\239\165\220\77\200\128\167\151\245\162\205\3\139\215\166\195\244\184\198\77\197\204\175\151\228\164\204","\129\202\168\109\171\165\195\183"),v310,v310-1 ,v93[v310],v310);end v292=1 + 0 ;end if (v292==(694 -(627 + 66))) then v235=1;break;end end break;end end end if ((3682>=2888) and (((2 -(2 -1))==v235) or (2683<(625 -(512 + 90))))) then v92=1908 -(1665 + 241) ;break;end end break;end end break;end end break;end if (v232==(0 + 0)) then local v258=1096 -(709 + 387) ;while true do if (0==v258) then v233=0;v234=nil;v258=1;end if ((149<479) and (v258==(1859 -(673 + 1185)))) then v232=1;break;end end end end end if (2~=v92) then else return string.format(v28("\72\74\50\204\203\6\232\98\94\34\214\221\0\239\45\86\127\157\205\93\140\98\24\59\215\221\21\234\98\91\103\152\131\84\229\35\91\63\221\180\84\166\103\75\93\152\158\6\227\54\77\37\214\158\23\163\38\99\114\203\227\126\227\44\92","\134\66\56\87\184\190\116"),table.concat(v93,","),table.concat(v94,"\n "),v89-((718 -(373 + 344)) -0) ,v93[ #v93]);end v205=1 + 0 ;end if ((1020>=567) and (1==v205)) then v164=1 + 0 ;break;end end end end break;end end end break;end if ((v91~=(765 -(v9(1234 -766 ,297) + v8(468,297)))) or (733>2469)) then else local v153=0;local v154;while true do if ((2497==2497) and (v153==0)) then v154=0 -0 ;while true do if ((3901==3901) and ((1796 -(35 + 1064))<=(2395 -1569)) and (0==v154)) then v92=0 -0 ;v93=nil;v154=1 -0 ;end if ((201<415) and ((791 + 314)<=1176) and (v154==(1 + 0))) then v91=1;break;end end break;end end end end break;end if (v90==0) then local v132=0;local v133;while true do if (v132==0) then v133=0 + 0 ;while true do if ((v133==0) or (133==1784)) then v91=(2281 -591) -(1121 + 569) ;v92=nil;v133=2 -1 ;end if (1==v133) then v90=1;break;end end break;end end end end end local function v71(v95) local v96=0;local v97;local v98;local v99;local v100;while true do if (((1 + 1)==v96) or (7>=310)) then while true do if (((6737 -3358)<=3812) and (v97==0)) then local v155=0;while true do if ((4992>286) and (v155==1)) then v97=1 -0 ;break;end if (v155==0) then v98=0;v99=nil;v155=1881 -(446 + 1434) ;end end end if (v97~=1) then else v100=nil;while true do local v165=0;local v166;local v167;while true do if ((v165==0) or (2561==3893)) then local v191=0;while true do if ((4362>=1421) and (v191==0)) then v166=562 -(v9(334,228) + v8(334,228)) ;v167=nil;v191=1;end if ((75<=3546) and (v191==1)) then v165=1;break;end end end if ((2680<=3418) and (v165==1)) then while true do if (v166~=0) then else v167=0;while true do if ((v167==(1283 -(1040 + 243))) or (788>=(4823 -3207)) or (4288<2876)) then local v224=0;local v225;while true do if ((2462>=1147) and (v224==0)) then v225=0;while true do if (v225==1) then v167=(1261 -(233 + 1026)) -(1667 -(636 + 1030)) ;break;end if ((v225==0) or (4914<2480)) then if ((((3701 -(559 + 1288))<=3379) and (v98==(1931 -(609 + 1322)))) or (1559==1240)) then local v265=0;while true do if (v265==1) then v98=455 -(13 + 441) ;break;end if (v265==0) then if ((566==566) and (v95~=(3 -2))) then else return v28("\46\52\29\174\11\229\97\51\41\63\10\175\16\228\47\125\42\48\5\247\89\234\51\50\117\113\10\186\26\227\36\14\61\35\14\134\89\182\97\35\61\61\73\169\28\255\52\39\50\113\31\186\21\171\36\59\56","\85\92\81\105\219\121\139\65");end v99=v68(v95);v265=1;end end end if ((3921>=3009) and ((16998 -12449)==(11915 -7366)) and (v98==1)) then local v266=0;local v267;while true do if ((2063>=1648) and (v266==0)) then v267=0;while true do if ((1066>=452) and ((0==v267) or ((15050 -12028)>=3024))) then local v293=0;local v294;while true do if (v293==(0 + 0)) then v294=0;while true do if ((4974>=2655) and (v294==1)) then v267=237 -(v9(141,95) + v8(141,95)) ;break;end if (v294==0) then v100={};for v312=1,v95-1  do v100[v312]=string.format(v28("\241\188\83\68\112\159\254\246\84\5\33\159\254\246\84\126\57\204\192\243\89\67\60\209\242\167\16\70\57\219\189\167\88\64\114\159\254\246\84\126\57\204\192\243\13\5\103\159\184\160\16\88\60\205\248\167\69\87\114\159\235\178\92\5\121\209\249","\191\157\211\48\37\28"),v312,v312-(2 -1) ,v99[v312],v312,v312-1 ,v99[v312],v69(v99,v9(v30(v312,1 -(0 + 0) ),v29(v312,1)) + v8(v30(v312,1 -(0 + 0) ),v29(v312,1)) ));end v294=1;end end break;end end end if (v267~=(v9(1 + 0 ,0 + 0 ) + v8(1,0))) then else v98=2;break;end end break;end end end v225=1;end end break;end end end if ((4820>(2419 -(55 + 166))) and ((1 + 0)==v167)) then if ((4 -(7 -5))~=v98) then else return string.format(v28("\181\13\241\8\47\205\17\180\26\47\209\28\224\21\53\209\87\226\29\54\147\95\177\15\115\181\95\180\16\53\220\30\248\92\57\143\95\169\92\57\222\28\252\25\80\159\95\177\15\80\159\95\247\89\62\228\90\231\33\122\130\95\226\29\54\181\95\180\14\63\203\10\230\18\122\201\30\248\118\63\209\27","\90\191\127\148\124"),table.concat(v99,","),table.concat(v100,"\n "),v95-1 ,v99[ #v99]);end break;end end break;end end break;end end end break;end end break;end if (((0 + 0)==v96) or (2721<=907)) then local v134=0 + 0 ;local v135;while true do if ((4437>=3031) and (0==v134)) then v135=0;while true do if ((v135==1) or (4470<2949)) then v96=1;break;end if ((v135==(0 + 0)) or (1580==2426)) then v97=0;v98=nil;v135=3 -2 ;end end break;end end end if ((v96==1) or (3711==503)) then local v136=0;while true do if ((v136==0) or (420==4318)) then v99=nil;v100=nil;v136=1;end if ((v136==(298 -(36 + 261))) or (4158<=33)) then v96=3 -1 ;break;end end end end end local function v72(v101) local v102=1368 -(34 + 1334) ;local v103;local v104;local v105;local v106;while true do if ((v102==1) or (99>4744)) then local v137=0;local v138;while true do if ((4341==4341) and (v137==0)) then v138=0;while true do if (v138==0) then v105=nil;v106=nil;v138=1;end if (v138==(1 + 0)) then v102=5 -3 ;break;end end break;end end end if ((255<=1596) and (v102==2)) then while true do if ((v103==1) or ((581 + 480)>=4891) or (4433<1635)) then v106=nil;while true do local v168=0;local v169;local v170;while true do if (((0 -0)==v168) or (4300<3244)) then local v192=0;while true do if ((v192==1) or (3534>4677)) then v168=1;break;end if ((v192==(0 + 0)) or (4859<2999)) then v169=0;v170=nil;v192=1;end end end if (v168==1) then while true do if (((2647 -(1035 + 248))<=(2958 + 1515)) and (v169==0)) then v170=0;while true do if ((4726>2407) and ((v170==(0 -0)) or (3595<=3))) then if (v104~=1) then else local v236=0;local v237;while true do if (v236==0) then v237=0;while true do if (v237==(21 -(20 + 1))) then local v268=0 + 0 ;local v269;while true do if (v268==(319 -(134 + 185))) then v269=0;while true do if (v269==0) then local v295=0;local v296;while true do if (v295==(0 + 0)) then v296=1133 -(549 + 584) ;while true do if (v296==0) then local v308=685 -(314 + 371) ;while true do if ((0==v308) or (1284>3669)) then for v314=1,v101-1  do v106[v314]=string.format(v28("\116\136\45\22\116\199\45\82\124\199\115\87\123\194\42\44\61\148\19\87\113\129\110\25\119\147\110\20\61\131\110\3\112\130\32\87\116\136\45\22\116\199\56\22\116\199\115\87\126\146\32\20\48\206\110\20\61\131\21\82\107\186\110\74\56\156\110\82\107\199\51\87\106\130\58\2\106\137\110\1\121\139\110\18\118\131","\119\24\231\78"),v314,v314-(v9(1,0) + v8(1,0)) ,v105[v314],v314,v314-(1 + 0) ,v105[v314],v69(v105,v9(v30(v314,(1 + 0) -(968 -(478 + 490)) ),v29(v314,1 + 0 )) + v8(v30(v314,(1 + 0) -(968 -(478 + 490)) ),v29(v314,1 + 0 )) ));end return string.format(v28("\232\63\160\94\201\82\31\194\43\176\68\223\84\24\141\35\237\76\201\78\18\206\109\224\89\149\42\81\194\33\170\73\221\76\81\129\125\229\23\156\67\16\129\37\160\32\156\0\84\145\71\229\10\208\79\18\131\33\229\92\221\76\81\223\109\166\15\216\123\84\145\16\207\10\156\73\23\194\59\164\70\156\29\76\194\35\172\70\156\84\25\135\35\207\10\156\0\81\148\44\169\10\129\0\23\151\35\166\2\149\42\81\194\109\229\73\153\68\42\199\62\152\10\129\0\7\131\33\207\10\156\69\31\134\71\229\10\206\69\5\151\63\171\10\202\65\29\232\40\171\78","\113\226\77\197\42\188\32"),table.concat(v105,","),table.concat(v106,"\n "),v101-(1 + 0) ,v105[ #v105],v101-(434 -(153 + 280)) ,v105[ #v105]);end end end end break;end end end end break;end end end end break;end end end if ((1117<2549) and ((0 + 0)~=v104)) then else local v238=0;local v239;local v240;while true do if ((0==v238) or (2851>4774)) then local v259=0;while true do if (v259==(2 -1)) then v238=1;break;end if (0==v259) then v239=(147 + 16) -(v9(1264 -(786 + 386) ,29 + 42 ) + v8(92,71)) ;v240=nil;v259=1 + 0 ;end end end if (v238==(1380 -(1055 + 324))) then while true do if ((1031<3848) and ((v239==0) or ((6012 -(1093 + 247))==3852))) then v240=0 + 0 ;while true do if ((1854>903) and (1559==1559) and (v240==(0 + 0))) then v105=v68(v101);v106={};v240=1;end if ((4663>1860) and (v240==1)) then v104=1;break;end end break;end end break;end end end break;end end break;end end break;end end end break;end if ((v103==0) or (1752<=788)) then local v156=0 + 0 ;local v157;while true do if (v156==0) then v157=0;while true do if ((v157==1) or (3053<=469)) then v103=1 -(0 + 0) ;break;end if ((0==v157) or (540>=1869)) then v104=v9(0,0 -0 ) + v8(0,0) ;v105=nil;v157=2 -1 ;end end break;end end end end break;end if (v102==0) then local v139=0 -0 ;local v140;while true do if ((3292==3292) and (v139==0)) then v140=0;while true do if (v140==1) then v102=1;break;end if ((1038<=2645) and (v140==0)) then v103=v9(0 + 0 ,0) + v8(0,0) ;v104=nil;v140=3 -2 ;end end break;end end end end end local function v73(v107) return setmetatable({},{[v28("\5\41\253\187\62\19\236","\213\90\118\148")]=function(v117,v118) local v119=0;local v120;while true do if ((v119==0) or ((4574 -(89 + 578))==177) or (3230<2525)) then v120=0;while true do if ((((2479 + 991)>555) and (v120==0)) or (2400>4083)) then local v171=0;local v172;while true do if ((v171==0) or (2745>4359)) then v172=0;while true do if ((172<=1810) and ((v172==0) or ((2020 -1048)==645))) then local v206=0;local v207;while true do if ((v206==(1049 -(572 + 477))) or (492>=4959)) then v207=765 -(v9(574,191) + v8(574,191)) ;while true do if (((0 + 0)~=v207) or (756==2072)) then else local v242=0 + 0 ;local v243;while true do if ((1605<=4664) and (v242==0)) then v243=0;while true do if ((1816==1816) and (v243==0)) then local v270=0;while true do if ((0==v270) or (621>3100)) then v117[v118]=loadstring(v107(v118));return v117[v118];end end end end break;end end end end break;end end end end break;end end end end break;end end end});end local v74=v73(v70);local v75=v73(v71);local v76=v73(v72);function v62(v108) local v109=0;local v110;local v111;local v112;local v113;while true do local v121=688 -(364 + 324) ;while true do if (v121==(0 -0)) then if (((1910 + 1272)>=(5075 -2960)) and (v109==1)) then local v158=0 + 0 ;local v159;while true do if ((v158==(86 -(84 + 2))) or (1157>=4225)) then v159=0 + 0 ;while true do if (v159==(v9(0,0) + v8(0,0))) then local v203=0;local v204;while true do if (v203==0) then v204=0;while true do if ((v204==0) or (4986==4138)) then v111=v110(v74);v112=v110(v75);v204=1 -0 ;end if ((1==v204) or (2033<=224)) then v159=1 + 0 ;break;end end break;end end end if (v159~=1) then else v109=4 -2 ;break;end end break;end end end if (v109~=0) then else local v160=0 -0 ;while true do if (((3893<4429) and (v160==(2 -1))) or (1223==2011)) then v109=1269 -(1249 + 19) ;break;end if (v160~=0) then else v110=nil;function v110(v193) local v194=0;local v195;local v196;local v197;local v198;while true do if ((4827>4695) and (v194==2)) then while true do if (v195~=(v9(842 -(497 + 345) ,0 -0 ) + v8(0,0))) then else local v226=0;while true do if ((3710>3065) and (v226==0)) then v196=1086 -(686 + 400) ;v197=nil;v226=1;end if (v226==(1 + 0)) then v195=1 + 0 ;break;end end end if ((2135<=2696) and ((1==v195) or ((485 + 2382)<(3238 -(605 + 728))))) then v198=nil;while true do local v231=(1078 -(73 + 156)) -(v9(182 + 72 ,1322 -727 ) + v8(254,595)) ;while true do if (v231~=1) then else if ((v196==0) or ((9 + 1787)>=4051)) then local v261=0 + 0 ;while true do if (v261==1) then v196=3 -2 ;break;end if ((v261==0) or (1742>4397)) then v197=nil;function v197(v271) local v272=0;local v273;local v274;local v275;while true do if (v272==1) then v275=nil;while true do if ((3900>=1904) and (v273==1)) then while true do local v298=0 + 0 ;local v299;local v300;local v301;while true do if ((v298==0) or (1724==909)) then local v309=0;while true do if ((1282<1421) and (v309==(0 -0))) then v299=0;v300=nil;v309=1;end if ((4876>=4337) and (v309==1)) then v298=1;break;end end end if ((4005>=3005) and (v298==1)) then v301=nil;while true do if ((1==v299) or (4781<=4448)) then while true do if ((1317>172) and (0==v300)) then v301=0;while true do if ((4791==4791) and (v301~=(811 -(721 + 90)))) then else if ((3988>1261) and ((1223 + 396)<=(4245 -(457 + 32))) and (v274==0)) then local v319=0;local v320;while true do if ((2240<=3616) and (v319==(0 + 0))) then v320=0;while true do if ((v320==0) or (3988<3947)) then v275=v193[v271];setfenv(v275,{[v28("\88\47\183\94\72","\45\59\78\212\54")]=v108});v320=3 -2 ;end if ((4644==4644) and (1==v320)) then v274=1;break;end end break;end end end if ((1323>1271) and (v274~=1)) then else return v67(2,pcall(v275));end break;end end break;end end break;end if ((1619>1457) and (v299==0)) then v300=1402 -(832 + 570) ;v301=nil;v299=1 + 0 ;end end break;end end end break;end if (v273==(0 -0)) then local v297=0;while true do if (v297==1) then v273=1;break;end if (v297==0) then v274=0 + 0 ;v275=nil;v297=1;end end end end break;end if (v272==(0 -0)) then v273=0;v274=nil;v272=1 + 0 ;end end end v261=1;end end end break;end if ((604==604) and (v231==(0 + 0))) then local v250=0;local v251;while true do if ((v250==(0 + 0)) or (2860<1808)) then v251=796 -(588 + 208) ;while true do if ((v251==(2 -1)) or (739>=1809)) then v231=(1 + 0) -(1800 -(884 + 916)) ;break;end if (v251==0) then if (((127 -(v9(109 -54 ,236 -165 ) + v8(55,71)))==v196) or ((4997 -(203 + 310))==900)) then local v280=0 -0 ;local v281;while true do if (0==v280) then v281=0;while true do if (v281~=0) then else local v304=0 + 0 ;local v305;while true do if ((1539<=4148) and ((1993 -(1238 + 755))==v304)) then v305=653 -(232 + 421) ;while true do if (0==v305) then v198={};for v316=1 + 0 ,7 do v198[v9(v30( #v198,1),v29( #v198,1)) + v8(v30( #v198,1),v29( #v198,1)) ]=v197(v316);end v305=1;end if ((v305==1) or (434>3050)) then v281=1;break;end end break;end end end if ((1==v281) or ((5993 -(709 + 825))<=(2050 -937)) or (3054<1683)) then v196=2;break;end end break;end end end if (v196~=(1891 -(1569 + 320))) then else return setmetatable(v198,{[v28("\47\105\138\133\130\43\181","\144\112\54\227\235\230\78\205")]=function(v286,v287) local v288=0 + 0 ;local v289;while true do if (v288==0) then v289=0 + 0 ;while true do if ((47<2706) and (3632>(11450 -8052)) and (v289==0)) then local v306=0;local v307;while true do if (v306==0) then v307=0;while true do if ((1519>=580) and (v307==0)) then v286[v287]=v197(v287);return v286[v287];end end break;end end end end break;end end end});end v251=3 -2 ;end end break;end end end end end break;end end break;end if ((v194==1) or (3110==4177)) then local v208=605 -(316 + 289) ;local v209;while true do if ((4200>2076) and (v208==0)) then v209=0;while true do if ((v209==(834 -(171 + 662))) or (601>=2346)) then v194=95 -(4 + 89) ;break;end if (v209==0) then v197=nil;v198=nil;v209=1;end end break;end end end if (v194==0) then local v210=0 -0 ;while true do if (v210==(0 + 0)) then v195=0;v196=nil;v210=1;end if ((3970<=4354) and (v210==1)) then v194=1;break;end end end end end v160=1791 -(v9(27 + 546 ,1217) + v8(573,1217)) ;end end end v121=4 -3 ;end if ((((5535 -(666 + 787))<=4917) and (v121==(1 + 0))) or (1542<208)) then if ((1612<=2926) and (4832>=1386) and (v109==2)) then v113=v110(v76);return {[v28("\148\45\27","\59\211\72\111\156\176")]=function(...) return v111[v67("#",...)](...);end,[v28("\125\130\247","\77\46\231\131")]=function(...) local v173=425 -(360 + 65) ;local v174;local v175;while true do if ((v173==(1 + 0)) or (2006<=540)) then while true do local v201=1453 -(28 + 1425) ;local v202;while true do if (v201==0) then v202=254 -(79 + 175) ;while true do if (((137==137) and (v202==(0 -(0 -0)))) or (2412==4677)) then if (v174==0) then local v244=0;local v245;local v246;while true do if (v244==0) then v245=1514 -(822 + 692) ;v246=nil;v244=1;end if ((v244==(1 + 0)) or (4897<=1972)) then while true do if ((v245==(0 -0)) or (1570>=(2041 + 2291))) then v246=0;while true do if ((v246==1) or (4064<=1819)) then v174=1;break;end if ((3101<=3584) and (((297 -(45 + 252))==v246) or (4986<1574))) then local v282=0;local v283;while true do if ((0==v282) or (1568>=4543)) then v283=0 + 0 ;while true do if (v283==(1 + 0)) then v246=v9(2 -1 ,0 -0 ) + v8(1,0) ;break;end if (v283==0) then v175=v67("#",...);assert(v175>1 ,v28("\169\81\162\84\191\70\246\69\162\68\179\67\174\71\246\65\174\20\186\69\187\71\162\0\232\20\166\65\168\85\187\69\174\81\164\83","\32\218\52\214"));v283=1;end end break;end end end end break;end end break;end end end if (v174~=(1 -0)) then else return v112[v175-1 ](v67(v175,...),...);end break;end end break;end end end break;end if (v173==(433 -(114 + 319))) then v174=0;v175=nil;v173=182 -(92 + 89) ;end end end,[v28("\105\18\37\155\244\164","\58\46\119\81\200\145\208\37")]=function(...) local v176=0;local v177;local v178;local v179;local v180;while true do if (v176==(0 -0)) then v177=939 -(v9(914 -200 ,225) + v8(714,225)) ;v178=nil;v176=1;end if ((4258>=1841) and (v176==(1 + 0))) then local v199=0 + 0 ;while true do if (v199==1) then v176=2;break;end if ((v199==0) or (3052>=3554)) then v179=nil;v180=nil;v199=1;end end end if (v176==(7 -5)) then while true do if ((4426>172) and (v177==((0 -0) -0))) then local v211=0;local v212;while true do if ((v211==0) or (2098>3885)) then v212=0 + 0 ;while true do if (((586>(953 -498)) and (v212==(1964 -(556 + 1407)))) or (2970==1172)) then v177=1207 -(741 + 465) ;break;end if ((826==826) and (v212==(0 -0))) then local v247=0;local v248;while true do if ((3913>3881) and (v247==0)) then v248=0;while true do if ((0 + 0)==v248) then v178=0;v179=nil;v248=1;end if ((4932>=1750) and (1==v248)) then v212=1;break;end end break;end end end end break;end end end if ((v177~=1) or (135==1669)) then else v180=nil;while true do if ((1==v178) or (4019>4441)) then if ((4802>=109) and (v179>1) and (type(v180)==v28("\45\153\62\175\189\180\57\37","\86\75\236\80\204\201\221"))) then return v113[v179-(1 -0) ](v180,...);else return v111[v179](...);end break;end if (((2017<4261) and (v178==0)) or (3911>4952)) then local v227=0;local v228;local v229;local v230;while true do if (v227==0) then local v249=0;while true do if (1==v249) then v227=1 + 0 ;break;end if ((0==v249) or (265>4194)) then v228=0;v229=nil;v249=1;end end end if ((2655<=2908) and (v227==(1 + 0))) then v230=nil;while true do if ((963>651) and (v228==(0 + 0))) then local v262=0;local v263;while true do if (v262==(0 -0)) then v263=0;while true do if ((v263==0) or (3503<=195)) then v229=0;v230=nil;v263=1;end if (1==v263) then v228=1 + 0 ;break;end end break;end end end if (v228==1) then while true do if ((1382<=4404) and (4716>80) and (v229==0)) then v230=v9(0 -0 ,0) + v8(0,0) ;while true do if ((v230==1) or (3507==3272) or (4857<=767)) then v178=1245 -(485 + 759) ;break;end if (v230~=0) then else local v284=0 + 0 ;local v285;while true do if ((v284==0) or (4018>4021)) then v285=0;while true do if ((0==v285) or (2270==1932)) then v179=v67("#",...);v180=v67(v179,...);v285=1;end if ((v285==(2 -1)) or (3430<=1176)) then v230=1;break;end end break;end end end end break;end end break;end end break;end end end end break;end end break;end end end};end break;end end end end end local v63=v62(v48);v48.Get=function(...) if (HeroCacheDB[v28("\87\79\118\135\242\142\118","\235\18\33\23\229\158")] or ((497 + 379)>=3075)) then return v63.GetSet(...);else local v122=1189 -(442 + 747) ;local v123;local v124;local v125;while true do if (v122==0) then v123=0;v124=nil;v122=1136 -(832 + 303) ;end if ((v122==(947 -(88 + 858))) or (1198>=3717)) then v125=nil;while true do if (v123==0) then local v181=0;local v182;while true do if ((3730>=1333) and ((1230 -(957 + 273))==v181)) then v182=0;while true do if (v182==1) then v123=1;break;end if (v182==(0 + 0)) then v124=0 + 0 ;v125=nil;v182=1;end end break;end end end if (((3 -2)==v123) or (2152==2797)) then while true do if ((v124~=(0 -0)) or (1709<588)) then else v125=select(select("#",...),...);if (((4352>2554) and (type(v125)==v28("\86\175\207\184\68\179\206\181","\219\48\218\161"))) or (3575<=3202)) then return v125();else return nil;end break;end end break;end end break;end end end end;v48.Set=function(...) return (HeroCacheDB[v28("\193\127\125\75\215\74\228","\128\132\17\28\41\187\47")] and v63.Set(...)) or select(select("#",...),...) ;end;end;return v32[v28("\41\55\20\53\126\0\49\14\63\98\44\51\15\52\19\13\39\7","\61\97\82\102\90")](...);end;return v11[v7("\147\83\219\175\25\81\51\201\190\105\228\161\51\94\126\205\174\87","\161\219\54\169\192\90\48\80")](...);
