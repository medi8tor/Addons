local v0=string.char;local v1=string.byte;local v2=string.sub;local v3=bit32 or bit ;local v4=v3.bxor;local v5=table.concat;local v6=table.insert;local function v7(v15,v16) local v17={};for v27=1, #v15 do v6(v17,v0(v4(v1(v2(v15,v27,v27 + 1 )),v1(v2(v16,1 + (v27% #v16) ,1 + (v27% #v16) + 1 )))%256 ));end return v5(v17);end local v8=v3.bor;local v9=v3.band;local v10=...;local v11={};local v12=require;local function v13(v18,...) local v19=0;local v20;local v21;while true do if (v19==0) then local v28=0;while true do if ((4136>2397) and (v28==1)) then v19=1406 -(666 + 739) ;break;end if ((0==v28) or (4334==4245)) then v20=0 -0 ;v21=nil;v28=1;end end end if ((v19==1) or (4276<=3031)) then while true do local v29=0;local v30;while true do if (v29==0) then v30=0;while true do if ((0==v30) or (4782<=1199)) then if (v20==1) then return v21(v10,...);end if ((v20==0) or (870>=3076)) then local v33=0;while true do if ((1629>1202) and (v33==1)) then v20=1 -0 ;break;end if (((1008<3711) and (v33==0)) or (4864<1902)) then v21=v11[v18];if ((4839>=3700) and ( not v21 or (1049<=906))) then return v12(v18,v10,...);end v33=1;end end end break;end end break;end end end break;end end end v11[v7("\249\198\201\42\194\153\228\33\242\204\201\32\168\183\210\31","\126\177\163\187\69\134\219\167")]=function(...) local v22=0 + 0 ;local v23;local v24;local v25;local v26;while true do if (((4513>2726) and (2==v22)) or (1075>1918)) then while true do if ((396<=3804) and ((v23==(791 -(368 + 423))) or (1481>=2658))) then v24=0;v25=nil;v23=1;end if ((v23==1) or (4169==2187)) then v26=nil;while true do if ((1406==1406) and ((v24==1) or (3220==1364))) then v26[v7("\7\239\9","\156\67\173\74\165")]={};break;end if ((v24==0) or (1054>3392)) then local v32=0;while true do if (v32==(0 -0)) then v25,v26=...;HeroDBC=v26;v32=19 -(10 + 8) ;end if ((1531<4271) and ((v32==1) or (676>=1642))) then v24=1;break;end end end end break;end end break;end if (v22==(0 -0)) then v23=442 -(416 + 26) ;v24=nil;v22=3 -2 ;end if (1==v22) then v25=nil;v26=nil;v22=1 + 1 ;end end end;return v11[v7("\28\178\91\25\152\4\101\11\148\70\4\185\104\74\33\182","\38\84\215\41\118\220\70")](...);
