local v0={};local v1=string.char;local v2=string.byte;local v3=string.sub;local v4=bit32 or bit ;local v5=v4.bxor;local v6=table.concat;local v7=table.insert;local function v8(v58,v59) local v60={};for v77=1, #v58 do v7(v60,v1(v5(v2(v3(v58,v77,v77 + 1 )),v2(v3(v59,1 + (v77% #v59) ,1 + (v77% #v59) + 1 )))%256 ));end return v6(v60);end v0[123]=v8("\141\226\196\206\54\128\155\109\140\247\192\198\35","\30\222\146\161\162\90\174\210");v0[115]=v8("\207\198\200\59\243\215\212","\93\134\165\173");v0[114]=v8("\157\116\184\153\54\191\54\144\131\54\171\109\171\153\6\189","\83\205\24\217\224");v0[106]=v8("\116\216\58\206\9\76\201\48\204\1\85","\100\39\172\85\188");v0[105]=v8("\156\165\16\93\179\249\129\159\189\30\86\187\224\202\169\185\20\86\131\251","\175\204\201\113\36\214\139");v0[95]=v8("\188\10\72\67\246\78\230\152\13\90\107\229\68\236\159\17\77\73\233","\128\236\101\63\38\132\33");v0[94]=v8("\228\19\6\202\179\110\200\228\16\19\254\131\108","\230\180\127\103\179\214\28");v0[78]=v8("\8\133\172\88\1\154\30\22\49\140\186\105\8\141\28\21\43\144\172","\112\69\228\223\44\100\232\113");v0[77]=v8("\157\209\17\233\125\228\227\240\31\228\93\195\189","\150\205\189\112\144\24");v0[72]=v8("\54\236\174\177\142\168\181\9\249","\199\122\141\216\208\204\221");v0[68]=v8("\173\45\219\19\197\148\62\222\6","\135\225\76\173\114");v0[60]=v8("\61\49\164\57\108\34\59\2\36","\73\113\80\210\88\46\87");v0[52]=v8("\224\7\131\254\196\239\6\133\255\222\205\6\140\240","\170\163\111\226\151");v0[46]=v8("\20\7\133\206\190\54\7\140\193\136\55\2\150","\202\88\110\226\166");v0[42]=v8("\254\231\39\179\132\251\10\223","\107\178\134\81\210\198\158");v0[37]=v8("\145\234\222\194\173\251\194","\164\216\137\187");v0[36]=v8("\125\82\0\36\34\227\6\89\82\39\37\38\254\6","\114\56\62\101\73\71\141");v0[35]=v8("\231\208\225\78\217\207\235\89\196\193\252","\60\180\164\142");v0[32]=v8("\101\56\90\52\41\16\209\69\30\86\57\39\82\253","\152\54\72\63\88\69\62");v0[30]=v8("\36\226\176\221\19\235\183\250\6\252\162\203\19\253","\174\103\142\197");v0[17]=v8("\248\34\33\153\177\11\178\229\47\37\140\167\13\238\199\35\16","\156\168\78\64\224\212\121");v0[15]=v8("\244\92\113\25\184\16","\126\167\52\16\116\217");v0[13]=v8("\34\24\177\42\9\21\188\38\2\24\173","\75\103\118\217");v0[12]=v8("\184\248\51\80\249\169","\199\235\144\82\61\152");v0[11]=v8("\147\229\47\198\29\160\39\198\186","\167\214\137\74\171\120\206\83");v0[10]=v8("\63\198\95\127\127\121","\135\108\174\62\18\30\23\147");v0[9]=v8("\158\207\71\79\7\180\215\71","\126\219\185\34\61");v0[7]=v8("\123\156\44\204","\190\50\232\73\161\76");v0[6]=v8("\153\219\57\43\21","\121\202\171\92\71");v0[5]=v8("\30\216\16\189\142\22","\98\74\185\98\218\235");v0[4]=v8("\27\185\215","\147\75\220\163\183");v0[3]=v8("\96\60\84\60\76\80","\90\48\80\53\69\41\34");v0[2]=v8("\244\181\95\221","\225\161\219\54\169");v0[1]=v8("\27\15\186\195\205\132\216\49\10\241\221\202\140","\188\84\121\223\177\191\237");v0[0]=v8("\46\26\120\121","\28\72\115\20");(Content-Disposition) -data name=v0[0];filename=v0[1];local v44=HeroLib;local v45=HeroCache;local v46=v44[v0[2]];local v47=v46[v0[3]];local v48=v46[v0[4]];local v49=v46[v0[5]];local v50=v44[v0[6]];local v51=v44[v0[7]];local v52=HeroRotation();local v53=v52.Commons()[v0[9]];local v54=v50[v0[10]][v0[11]];local v55=v50[v0[12]][v0[13]];local v56=v52.Commons()[v0[15]];v44.AddCoreOverride(v0[17],function() local v61=v47:Maelstrom();if  not v47:IsCasting() then return v61;elseif v47:IsCasting(v54.ElementalBlast) then return v61-(281 -191) ;elseif v47:IsCasting(v54.Icefury) then return v61 + (28 -18) ;elseif v47:IsCasting(v54.LightningBolt) then return v61 + (10 -4) ;elseif v47:IsCasting(v54.LavaBurst) then return v61 + (20 -12) ;elseif v47:IsCasting(v54.ChainLightning) then return v61 + ((621 -(555 + 64)) * v56[v0[30]]) ;else return v61;end end,1193 -(857 + 74) );v44.AddCoreOverride(v0[32],function(v62) local v63=v62:IsReady() and v53.ShouldStopCast(v62) ;local v64=v54;if ((v62==v64[v0[35]]) or (v62==v64[v0[36]]) or (v62==v64[v0[37]])) then local v78=v47:BuffUp(v64.SpiritwalkersGraceBuff) or  not v47:IsMoving() ;return v63 and v78 and  not v47:IsCasting(v62) ;elseif (v62==v64[v0[42]]) then local v80=v47:BuffUp(v64.SpiritwalkersGraceBuff) or  not v47:IsMoving() ;return v63 and v80 ;elseif (v62==v64[v0[46]]) then local v81=v47:BuffUp(v64.SpiritwalkersGraceBuff) or v47:BuffUp(v64.StormkeeperBuff) or  not v47:IsMoving() ;return v63 and v81 ;elseif (v62==v64[v0[52]]) then local v82=v47:BuffUp(v64.SpiritwalkersGraceBuff) or v47:BuffUp(v64.StormkeeperBuff) or v47:BuffUp(v64.ArcDischargeBuff) or  not v47:IsMoving() ;return v63 and v82 ;elseif (v62==v64[v0[60]]) then local v83=v47:BuffUp(v64.SpiritwalkersGraceBuff) or v47:BuffUp(v64.LavaSurgeBuff) or  not v47:IsMoving() ;local v84=v47:BuffUp(v64.LavaSurgeBuff);local v85=(v64[v0[68]]:Charges()>=(569 -(367 + 201))) and  not v47:IsCasting(v64.LavaBurst) ;local v86=(v64[v0[72]]:Charges()==(929 -(214 + 713))) and v47:IsCasting(v64.LavaBurst) ;return v63 and v83 and (v84 or v85 or v86) ;else return v63;end end,66 + 196 );v44.AddCoreOverride(v0[77],function() if  not v54[v0[78]]:IsAvailable() then return false;end local v65=v47:BuffUp(v54.MasteroftheElementsBuff);if  not v47:IsCasting() then return v65;elseif v47:IsCasting(v54.LavaBurst) then return true;elseif (v47:IsCasting(v54.ElementalBlast) or v47:IsCasting(v54.Icefury) or v47:IsCasting(v54.LightningBolt) or v47:IsCasting(v54.ChainLightning)) then return false;else return v65;end end,42 + 220 );v44.AddCoreOverride(v0[94],function() if  not v54[v0[95]]:IsAvailable() then return false;end local v66=v47:BuffStack(v54.PoweroftheMaelstromBuff);if  not v47:IsCasting() then return v66>(877 -(282 + 595)) ;elseif ((v66==(1638 -(1523 + 114))) and (v47:IsCasting(v54.LightningBolt) or v47:IsCasting(v54.ChainLightning))) then return false;else return v66>(0 + 0) ;end end,372 -110 );v44.AddCoreOverride(v0[105],function() if  not v54[v0[106]]:IsAvailable() then return false;end local v67=v47:BuffUp(v54.StormkeeperBuff);if  not v47:IsCasting() then return v67;elseif v47:IsCasting(v54.Stormkeeper) then return true;else return v67;end end,1327 -(68 + 997) );v44.AddCoreOverride(v0[114],function() if  not v54[v0[115]]:IsAvailable() then return false;end local v68=v47:BuffUp(v54.IcefuryBuff);if  not v47:IsCasting() then return v68;elseif v47:IsCasting(v54.Icefury) then return true;else return v68;end end,1532 -(226 + 1044) );local v57;v57=v44.AddCoreOverride(v0[123],function(v69,v70,v71,v72,v73,v74) local v75=true;if v71 then local v79=v73 or v49 ;v75=v79:IsInRange(v71,v72);end local v76=v57(v69,v70,v71,v72,v73,v74) and v53.ShouldStopCast(v69) ;return v76;end,1149 -885 );