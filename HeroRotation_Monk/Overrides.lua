local v0={};local v1=string.char;local v2=string.byte;local v3=string.sub;local v4=bit32 or bit ;local v5=v4.bxor;local v6=table.concat;local v7=table.insert;local function v8(v39,v40) local v41={};for v57=1, #v39 do v7(v41,v1(v5(v2(v3(v39,v57,v57 + 1 )),v2(v3(v40,1 + (v57% #v40) ,1 + (v57% #v40) + 1 )))%256 ));end return v6(v41);end v0[19]=v8("\63\222\91\126\114\57\218\244\62\203\95\118\103","\135\108\174\62\18\30\23\147");v0[16]=v8("\143\214\87\94\22\180\223\102\88\31\175\209","\126\219\185\34\61");v0[15]=v8("\26\209\41\132\37\143\5\155\10\192\63\156\40\195\32\141","\232\73\161\76");v0[13]=v8("\252\53\41\226\201\171\199\55\34\244","\202\171\92\71\134\190");v0[12]=v8("\47\181\133\60","\185\98\218\235\87");v0[11]=v8("\158\209\210\29\15\42\175\215\210\24","\75\220\163\183\106\98");v0[10]=v8("\100\77\14\46","\69\41\34\96");v0[9]=v8("\158\64\204\178\35\95\62\196","\161\219\54\169\192\90\48\80");v0[7]=v8("\48\171\212\210","\84\121\223\177\191\237\76");v0[6]=v8("\155\109\121\36\31","\35\200\29\28\72\115\20\154");v0[5]=v8("\200\86\181\65\249\67","\38\156\55\199");v0[4]=v8("\237\51\232","\38\189\86\156\32\24\133");v0[3]=v8("\20\28\55\106\160\172","\203\68\112\86\19\197\222");v0[2]=v8("\27\240\89\2","\70\78\158\48\118\66\114\182");v0[1]=v8("\152\95\19\38\165\64\18\49\164\7\26\33\182","\84\215\41\118");v0[0]=v8("\250\42\193\47","\95\156\67\173\74\165\179");local v25=HeroLib;local v26=HeroCache;local v27=v25[v0[2]];local v28=v27[v0[3]];local v29=v27[v0[4]];local v30=v27[v0[5]];local v31=v25[v0[6]];local v32=v25[v0[7]];local v33=HeroRotation();local v34=v33.Commons()[v0[9]];local v35=v31[v0[10]][v0[11]];local v36=v31[v0[12]][v0[13]];local v37;v37=v25.AddCoreOverride(v0[15],function(v42,v43,v44,v45,v46,v47) local v48=v37(v42,v43,v44,v45,v46,v47);if (v42==v35[v0[16]]) then return v48 and v42:IsUsable() ;else return v48;end end,837 -569 );local v38;v38=v25.AddCoreOverride(v0[19],function(v49,v50,v51,v52,v53,v54) local v55=true;if v51 then local v58=v53 or v30 ;v55=v58:IsInRange(v51,v52);end local v56=v38(v49,v50,v51,v52,v53,v54) and v34.ShouldStopCast(v49) ;return v56;end,772 -502 );