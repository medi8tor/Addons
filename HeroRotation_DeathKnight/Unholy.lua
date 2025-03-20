local obf_stringchar = string.char;
local obf_stringbyte = string.byte;
local obf_stringsub = string.sub;
local obf_bitlib = bit32 or bit;
local obf_XOR = obf_bitlib.bxor;
local obf_tableconcat = table.concat;
local obf_tableinsert = table.insert;
local function LUAOBFUSACTOR_DECRYPT_STR_0(LUAOBFUSACTOR_STR, LUAOBFUSACTOR_KEY)
	local result = {};
	for i = 1, #LUAOBFUSACTOR_STR do
		obf_tableinsert(result, obf_stringchar(obf_XOR(obf_stringbyte(obf_stringsub(LUAOBFUSACTOR_STR, i, i + 1)), obf_stringbyte(obf_stringsub(LUAOBFUSACTOR_KEY, 1 + (i % #LUAOBFUSACTOR_KEY), 1 + (i % #LUAOBFUSACTOR_KEY) + 1))) % 256));
	end
	return obf_tableconcat(result);
end
local v0, v1 = ...;
local v2 = HeroDBC.DBC;
local v3 = HeroLib;
local v4 = HeroCache;
local v5 = v3.Unit;
local v6 = v5.Player;
local v7 = v5.Target;
local v8 = v5.MouseOver;
local v9 = v5.Boss;
local v10 = v5.Pet;
local v11 = v3.Spell;
local v12 = v3.Item;
local v13 = HeroRotation();
local v14 = v13.Cast;
local v15 = v13.CDsON;
local v16 = v13.AoEON;
local v17 = v13.Commons().Everyone.num;
local v18 = v13.Commons().Everyone.bool;
local v19 = C_Timer.After;
local v20 = math.max;
local v21 = table.insert;
local v22 = GetTime;
local v23 = v13.Commons().DeathKnight;
local v24 = v11.DeathKnight.Unholy;
local v25 = v12.DeathKnight.Unholy;
local v26 = {[LUAOBFUSACTOR_DECRYPT_STR_0("\226\206\218\41\234\152\227\42\222\196\220\41\227", "\126\177\163\187\69\134\219\167")]=false,[LUAOBFUSACTOR_DECRYPT_STR_0("\23\204\40\241\243\36\202\38\192", "\156\67\173\74\165")]=false,[LUAOBFUSACTOR_DECRYPT_STR_0("\29\185\93\19\174\52\83\36\163\125\25\187\33\74\49", "\38\84\215\41\118\220\70")]=false,[LUAOBFUSACTOR_DECRYPT_STR_0("\116\24\6\33\251\68\2\43\28\249", "\158\48\118\66\114")]=false,[LUAOBFUSACTOR_DECRYPT_STR_0("\143\37\2\61\71\183\250\165\55\22\57\97\168\250\191\45\31\56\64\160\239\191\45\30\49", "\155\203\68\112\86\19\197")]=false,[LUAOBFUSACTOR_DECRYPT_STR_0("\116\220\53\245\65\116\246\203\67\201\34\245\78\127", "\152\38\189\86\156\32\24\133")]=false,[LUAOBFUSACTOR_DECRYPT_STR_0("\200\69\174\72\247\82\179\23\207\82\179\82\245\89\160", "\38\156\55\199")]=false,[LUAOBFUSACTOR_DECRYPT_STR_0("\156\111\117\38\24\113\238\17\155\120\104\60\26\122\253", "\35\200\29\28\72\115\20\154")]=false,[LUAOBFUSACTOR_DECRYPT_STR_0("\41\176\197\214\130\34\7\28\171\197\214\131\43", "\84\121\223\177\191\237\76")]=false,[LUAOBFUSACTOR_DECRYPT_STR_0("\154\70\198\163\59\92\41\209\168\83\250\165\46\68\57\207\188", "\161\219\54\169\192\90\48\80")]=false,[LUAOBFUSACTOR_DECRYPT_STR_0("\124\76\8\42\69\91\33\54\90\67\21\41\93\113\5\49\93\75\14\34", "\69\41\34\96")]=false,[LUAOBFUSACTOR_DECRYPT_STR_0("\157\193\216\7\11\37\189\215\222\5\12\7\181\206\213\57\7\63\168\202\217\13", "\75\220\163\183\106\98")]=false,[LUAOBFUSACTOR_DECRYPT_STR_0("\39\183\155\56\206\7\168\185\34\215\7\141\142\54\201\13\180\184\50\205\22\179\133\48", "\185\98\218\235\87")]=false,[LUAOBFUSACTOR_DECRYPT_STR_0("\254\50\47\233\210\179\233\48\46\225\214\190\248\57\51\242\215\164\204", "\202\171\92\71\134\190")]=false,[LUAOBFUSACTOR_DECRYPT_STR_0("\26\212\33\133\38\207\11\137\59\198\35\145\37\196\31\141\61\213\37\134\46", "\232\73\161\76")]=false,[LUAOBFUSACTOR_DECRYPT_STR_0("\137\216\75\78\27\154\219\77\80\23\181\216\86\84\17\181\234\71\73\10\178\215\69", "\126\219\185\34\61")]=false,[LUAOBFUSACTOR_DECRYPT_STR_0("\45\220\83\107\81\113\199\239\9\234\91\115\122\68\246\243\24\199\80\117", "\135\108\174\62\18\30\23\147")]=false};
local v27 = {v25.AlgetharPuzzleBox:ID(),v25.Fyralath:ID(),v25.IrideusFragment:ID(),v25.VialofAnimatedBlood:ID(),v25.ManicGrieftorch:ID(),v25.TreacherousTransmitter:ID()};
local v28 = v6:GetEquipment();
local v29 = (v28[18 - 5] and v12(v28[170 - (26 + 131)])) or v12(0 + 0);
local v30 = (v28[53 - 39] and v12(v28[873 - (240 + 619)])) or v12(0 + 0);
local v31;
local v32;
local v33 = v13.GUISettingsGet();
local v34 = v13.Commons().Everyone;
local v35 = {[LUAOBFUSACTOR_DECRYPT_STR_0("\145\236\36\206\10\175\63", "\167\214\137\74\171\120\206\83")]=v33.General,[LUAOBFUSACTOR_DECRYPT_STR_0("\168\255\63\80\247\169\152", "\199\235\144\82\61\152")]=v33.APL.DeathKnight.Commons,[LUAOBFUSACTOR_DECRYPT_STR_0("\35\19\191\46\9\5\176\61\2\5", "\75\103\118\217")]=v33.APL.DeathKnight.Unholy.Defensives,[LUAOBFUSACTOR_DECRYPT_STR_0("\242\90\120\27\181\7", "\126\167\52\16\116\217")]=v33.APL.DeathKnight.Unholy,[LUAOBFUSACTOR_DECRYPT_STR_0("\252\26\4", "\156\168\78\64\224\212\121")]=v33.APL.DeathKnight.Unholy_TTD};
local v36;
local v37;
local v38;
local v39;
local v40;
local v41;
local v42;
local v43, v44;
local v45, v46;
local v47, v48;
local v49, v50;
local v51 = ((v24.VampiricStrikeAction:IsLearned()) and v24.VampiricStrikeAction) or ((v24.ClawingShadows:IsAvailable()) and v24.ClawingShadows) or v24.ScourgeStrike;
local v52 = ((v24.ClawingShadows:IsAvailable()) and v24.ClawingShadows) or v24.ScourgeStrike;
local v53 = ((v24.Defile:IsAvailable()) and v24.Defile) or v24.DeathAndDecay;
local v54, v55, v56;
local v57, v58, v59;
local v60, v61;
local v62;
local v63 = 17673 - 6562;
local v64 = 736 + 10375;
local v65 = v13.Commons().DeathKnight.GhoulTable;
local v29, v30;
local v66, v67;
local v68, v69;
local v70, v71;
local v72, v73;
local v74, v75;
local v76, v77;
local v78, v79;
local v80, v81;
local v82, v83;
local v84, v85;
local function v86(v146)
	return (v146 ~= LUAOBFUSACTOR_DECRYPT_STR_0("\41\225\177\142\50\253\160\202", "\174\103\142\197")) and (((v146 == LUAOBFUSACTOR_DECRYPT_STR_0("\97\33\75\48\101\125\247\89\36\91\55\50\80\235", "\152\54\72\63\88\69\62")) and v13.CDsON()) or ((v146 == LUAOBFUSACTOR_DECRYPT_STR_0("\227\205\250\84\148\247\227\93\216\200\174\83\198\132\205\83\219\200\234\83\195\202\253", "\60\180\164\142")) and (v26[1745 - (1344 + 400)] or v13.CDsON())) or ((v146 == LUAOBFUSACTOR_DECRYPT_STR_0("\111\87\17\33\103\222\31\89\82\9\105\4\201\1", "\114\56\62\101\73\71\141")) and v26[406 - (255 + 150)]) or ((v146 == LUAOBFUSACTOR_DECRYPT_STR_0("\151\231\155\233\183\235\216\203\173\231\207", "\164\216\137\187")) and (v59 >= v35.Unholy.Mobcount)) or ((v146 == LUAOBFUSACTOR_DECRYPT_STR_0("\253\232\113\159\169\252\8\221\243\63\166\230\241\25\146\197\62\189\170\250\4\197\232\34", "\107\178\134\81\210\198\158")) and ((v59 >= v35.Unholy.Mobcount) or v15())) or (v146 == LUAOBFUSACTOR_DECRYPT_STR_0("\25\2\149\199\179\43", "\202\88\110\226\166")) or ((v146 == LUAOBFUSACTOR_DECRYPT_STR_0("\236\1\194\213\197\208\28\135\228", "\170\163\111\226\151")) and IsBossfight) or ((v146 == LUAOBFUSACTOR_DECRYPT_STR_0("\60\63\176\59\65\34\39\5\112\189\42\14\21\38\2\35", "\73\113\80\210\88\46\87")) and (IsBossfight or (v59 >= v35.Unholy.Mobcount))));
end
local function v87(v147, v148, v149)
	if (IsBossfight or v34.ISSolo() or (v149 == (0 + 0)) or ((v64 >= v149) and (v64 < (4164 + 3613)))) then
		v13.Cast(v147, v148);
		return LUAOBFUSACTOR_DECRYPT_STR_0("\181\24\233\82\228\128\63\217\82", "\135\225\76\173\114") .. v147:Name();
	end
end
local function v88(v150)
	if (v150 == nil) then
		return true;
	end
	return IsBossfight or v34.ISSolo() or (v150 == (0 - 0)) or v34.Buggedmobs[v7:NPCID()] or ((v64 >= v150) and (v64 < (25118 - 17341)));
end
local v89 = {{v24.Asphyxiate,LUAOBFUSACTOR_DECRYPT_STR_0("\57\236\171\164\236\156\180\10\229\161\168\165\188\179\31\173\240\153\162\169\162\8\255\173\160\184\244", "\199\122\141\216\208\204\221"),function()
	return true;
end}};
local function v90()
	return v25.ManicGrieftorch:IsEquipped() and (v25.ManicGrieftorch:CooldownUp() or (v25.ManicGrieftorch:CooldownRemains() <= v6:GCDRemains()));
end
local function v91()
	return v25.AlgetharPuzzleBox:IsEquipped() and (v25.AlgetharPuzzleBox:CooldownUp() or (v25.AlgetharPuzzleBox:CooldownRemains() <= v6:GCDRemains()));
end
local v92 = 0 + 0;
local function v93()
	local v151, v152 = v6:GetTrinketData(v27);
	if ((v92 < (342 - (10 + 327))) and ((v151.ID == (0 + 0)) or (v152.ID == (338 - (118 + 220))) or (v151.Level == (0 + 0)) or (v152.Level == (449 - (108 + 341))) or ((v151.SpellID > (0 + 0)) and not v151.Usable) or ((v152.SpellID > (0 - 0)) and not v152.Usable))) then
		v92 = v92 + (1494 - (711 + 782));
		v19(9 - 4, function()
			v93();
		end);
		return;
	end
	v29 = v151.Object;
	v30 = v152.Object;
	v66 = v151.ID;
	v67 = v152.ID;
	VarTrinket1Level = v151.Level;
	VarTrinket2Level = v152.Level;
	v68 = v151.Spell;
	v70 = v151.Range;
	v72 = v151.CastTime;
	v69 = v152.Spell;
	v71 = v152.Range;
	v73 = v152.CastTime;
	v74 = v151.Cooldown;
	v75 = v152.Cooldown;
	v76 = v151.Blacklisted;
	v77 = v152.Blacklisted;
	v78 = v29:HasUseBuff() or (v66 == v25.TreacherousTransmitter:ID());
	v79 = v30:HasUseBuff() or (v67 == v25.TreacherousTransmitter:ID());
	v80 = ((v66 == v25.TreacherousTransmitter:ID()) and (484 - (270 + 199))) or v29:BuffDuration();
	v81 = ((v67 == v25.TreacherousTransmitter:ID()) and (5 + 10)) or v30:BuffDuration();
	v82 = 1819.5 - (580 + 1239);
	if ((v78 and ((v24.Apocalypse:IsAvailable() and ((v74 % (89 - 59)) == (0 + 0))) or (v24.DarkTransformation:IsAvailable() and ((v74 % (2 + 43)) == (0 + 0))))) or (v66 == v25.TreacherousTransmitter:ID())) then
		v82 = 2 - 1;
	end
	v83 = 0.5 + 0;
	if ((v79 and ((v24.Apocalypse:IsAvailable() and ((v75 % (1197 - (645 + 522))) == (1790 - (1010 + 780)))) or (v24.DarkTransformation:IsAvailable() and ((v75 % (45 + 0)) == (0 - 0))))) or (v67 == v25.TreacherousTransmitter:ID())) then
		v83 = 2 - 1;
	end
	v84 = 1837 - (1045 + 791);
	local v169 = ((v80 > (0 - 0)) and v80) or (1 - 0);
	local v170 = ((v81 > (505 - (351 + 154))) and v81) or (1575 - (1281 + 293));
	if ((not v78 and v79 and (v30:HasCooldown() or not v29:HasCooldown())) or (v79 and (((v75 / v170) * v83) > ((v74 / v169) * v82 * ((267 - (28 + 238)) + ((VarTrinket1Level - VarTrinket2Level) / (223 - 123))))))) then
		v84 = 1561 - (1381 + 178);
	end
	v85 = 1 + 0;
	if (not v78 and not v79 and (VarTrinket2Level >= VarTrinket1Level)) then
		v85 = 2 + 0;
	end
end
v93();
local v94 = false;
local v89 = {{v24.Asphyxiate,LUAOBFUSACTOR_DECRYPT_STR_0("\142\220\3\228\56\215\190\205\24\233\96\255\172\201\21\176\48\223\163\201\21\226\106\227\189\201\89", "\150\205\189\112\144\24"),function()
	return true;
end}};
local function v95()
	if (v33.General.AutoTab and v6:AffectingCombat()) then
		v13.TopPanelAlternative:ChangeIcon(1 + 0, 3 + 0);
		return LUAOBFUSACTOR_DECRYPT_STR_0("\4\145\171\67\68\156\16\18\101\144\176\12\16\137\3\23\32\144", "\112\69\228\223\44\100\232\113");
	end
end
v3:RegisterForEvent(function()
	v63 = 19032 - 7921;
	v64 = 12267 - (1074 + 82);
end, LUAOBFUSACTOR_DECRYPT_STR_0("\228\51\38\234\147\78\185\230\58\32\246\152\67\163\250\62\37\255\147\88", "\230\180\127\103\179\214\28"));
v3:RegisterForEvent(function()
	v53 = ((v24.Defile:IsAvailable()) and v24.Defile) or v24.DeathAndDecay;
	v92 = 0 - 0;
	v93();
end, LUAOBFUSACTOR_DECRYPT_STR_0("\188\41\126\127\193\115\223\169\52\106\111\212\108\197\162\49\96\101\204\96\206\171\32\123", "\128\236\101\63\38\132\33"), LUAOBFUSACTOR_DECRYPT_STR_0("\159\153\52\104\154\216\240\143\129\48\106\145\206\235", "\175\204\201\113\36\214\139"), LUAOBFUSACTOR_DECRYPT_STR_0("\107\233\20\238\42\98\232\10\239\52\98\224\25\227\45\105\243\1\253\38", "\100\39\172\85\188"));
local function v96()
	return (v6:HealthPercentage() < v35.Unholy.Defensives.UseDeathStrikeHP) or ((v6:HealthPercentage() < v35.Unholy.Defensives.UseDarkSuccorHP) and v6:BuffUp(v24.DeathStrikeBuff));
end
local function v97(v171)
	local v172 = 1784 - (214 + 1570);
	for v218, v219 in pairs(v171) do
		if v219:DebuffDown(v24.VirulentPlagueDebuff) then
			v172 = v172 + (1456 - (990 + 465));
		end
	end
	return v172;
end
function IsNpcNearPlayer()
	local v173 = v6:GetEnemiesInRange(17 + 23);
	for v220, v221 in pairs(v173) do
		if ((v221:NPCID() == (17561 + 22796)) or (v221:CastSpellID() == (435670 + 12343))) then
			print(LUAOBFUSACTOR_DECRYPT_STR_0("\163\104\186\192\53\162\109\183\132\105\237\124\182\192\61\162\108\249\149\32\168\56\184\130\60\237\116\176\141\49", "\83\205\24\217\224"));
			return true;
		end
	end
	return false;
end
local function v98(v174)
	local v175 = {};
	for v222 in pairs(v174) do
		if not v5:IsInBossList(v174[v222]['UnitNPCID']) then
			v21(v175, v174[v222]);
		end
	end
	return v3.FightRemains(v175);
end
local function v99(v176)
	return v176:DebuffStack(v24.FesteringWoundDebuff);
end
local function v100(v177)
	return v177:DebuffRemains(v24.TrollbaneSlowDebuff);
end
local function v101(v178)
	return v178:DebuffStack(v24.FesteringWoundDebuff) < (7 - 5);
end
local function v102(v179)
	return v179:DebuffStack(v24.FesteringWoundDebuff) <= (1728 - (1668 + 58));
end
local function v103(v180)
	return not v24.VileContagion:IsAvailable();
end
local function v104(v181)
	return (v24.VileContagion:CooldownRemains() < (631 - (512 + 114))) or ((v24.FesteringWoundDebuff:AuraActiveCount() == v59) and (v181:DebuffStack(v24.FesteringWoundDebuff) <= (10 - 6)));
end
local function v105(v182)
	return ((v24.Apocalypse:CooldownRemains() < v6:GCD()) and v182:DebuffDown(v24.FesteringWoundDebuff)) or (v24.FesteringWoundDebuff:AuraActiveCount() < v59);
end
local function v106(v183)
	return (not v39 and (v183:DebuffStack(v24.FesteringWoundDebuff) < (8 - 4))) or v6:BuffUp(v24.FesteringScytheBuff);
end
local function v107(v184)
	return (v24.Apocalypse:CooldownRemains() < v38) and (v184:DebuffStack(v24.FesteringWoundDebuff) < (13 - 9));
end
local function v108(v185)
	return v37 and (((v185:DebuffStack(v24.FesteringWoundDebuff) >= (1 + 1)) and (v24.VileContagion:CooldownRemains() < (1 + 2))) or not v24.VileContagion:IsAvailable());
end
local function v109(v186)
	return v37 and (((v186:DebuffStack(v24.FesteringWoundDebuff) >= (2 + 0)) and (v24.VileContagion:CooldownRemains() < (20 - 14))) or not v24.VileContagion:IsAvailable());
end
local function v110(v187)
	return ((v187:DebuffStack(v24.FesteringWoundDebuff) >= (1998 - (109 + 1885))) and (v64 > (1473 - (1269 + 200))) and ((v53:CooldownRemains() < (5 - 2)) or (v6:BuffUp(v24.DeathAndDecayBuff) and (v187:DebuffStack(v24.FesteringWoundDebuff) >= (819 - (98 + 717)))))) or (v37 and (v187:DebuffStack(v24.FesteringWoundDebuff) == (832 - (802 + 24))));
end
local function v111(v188)
	return ((v188:DebuffStack(v24.FesteringWoundDebuff) == (10 - 4)) and (v6:DnDTicking() or (v53:CooldownRemains() < (3 - 0)))) or (v6:BuffUp(v24.DeathAndDecayBuff) and (v188:DebuffStack(v24.FesteringWoundDebuff) >= (1 + 3))) or ((v53:CooldownRemains() < (3 + 0)) and (v188:DebuffStack(v24.FesteringWoundDebuff) >= (1 + 3)));
end
local function v112(v189)
	return v189:DebuffStack(v24.FesteringWoundDebuff) >= (1 + 0);
end
local function v113(v190)
	return v190:DebuffUp(v24.TrollbaneSlowDebuff) and (v190:DebuffRemains(v24.TrollbaneSlowDebuff) < v6:GCD());
end
local function v114(v191)
	return ((v191:DebuffStack(v24.FesteringWoundDebuff) >= (2 - 1)) and (v24.Apocalypse:CooldownRemains() > v6:GCD())) or (v24.VampiricStrikeAction:IsLearned() and v191:DebuffUp(v24.VirulentPlagueDebuff));
end
local function v115(v192)
	return (v192:DebuffStack(v24.FesteringWoundDebuff) >= (3 - 2)) or v24.VampiricStrikeAction:IsLearned();
end
local function v116(v193)
	return v193:DebuffUp(v24.TrollbaneSlowDebuff);
end
local function v117(v194)
	return v194:DebuffUp(v24.TrollbaneSlowDebuff) and (v194:DebuffRemains(v24.TrollbaneSlowDebuff) < v6:GCD());
end
local function v118(v195)
	return (v195:TimeToDie() > v195:DebuffRemains(v24.VirulentPlagueDebuff)) and (v195:DebuffTicksRemain(v24.VirulentPlagueDebuff) < (2 + 3)) and (v195:DebuffRefreshable(v24.VirulentPlagueDebuff) or (v24.Superstrain:IsAvailable() and (v195:DebuffRefreshable(v24.FrostFeverDebuff) or v195:DebuffRefreshable(v24.BloodPlagueDebuff)))) and (not v26[6 + 8] or not v24.UnholyBlight:IsAvailable() or v24.Plaguebringer:IsAvailable()) and (not v26[14 + 2] or not v24.RaiseAbomination:IsAvailable() or (v24.RaiseAbomination:IsAvailable() and (v24.RaiseAbomination:CooldownRemains() > (v195:DebuffTicksRemain(v24.VirulentPlagueDebuff) * (3 + 0)))));
end
local function v119(v196)
	return (v196:TimeToDie() > v196:DebuffRemains(v24.VirulentPlagueDebuff)) and (v196:DebuffTicksRemain(v24.VirulentPlagueDebuff) < (3 + 2)) and (v196:DebuffRefreshable(v24.VirulentPlagueDebuff) or (v24.Morbidity:IsAvailable() and v6:BuffUp(v24.InflictionofSorrowBuff) and v24.Superstrain:IsAvailable() and v196:DebuffRefreshable(v24.FrostFeverDebuff) and v196:DebuffRefreshable(v24.BloodPlagueDebuff))) and (not v26[1447 - (797 + 636)] or not v24.UnholyBlight:IsAvailable() or (v24.UnholyBlight:IsAvailable() and (v24.DarkTransformation:CooldownDown() or not v26[24 - 19]))) and (not v26[1635 - (1427 + 192)] or not v24.RaiseAbomination:IsAvailable() or (v24.RaiseAbomination:IsAvailable() and v24.RaiseAbomination:CooldownDown()));
end
local function v120(v197)
	return (v197:DebuffRefreshable(v24.VirulentPlagueDebuff) or (v24.Morbidity:IsAvailable() and v6:BuffDown(v24.GiftoftheSanlaynBuff) and v24.Superstrain:IsAvailable() and v7:DebuffRefreshable(v24.FrostFeverDebuff) and v7:DebuffRefreshable(v24.BloodPlagueDebuff))) and (not v24.UnholyBlight:IsAvailable() or (v24.UnholyBlight:IsAvailable() and (v24.DarkTransformation:CooldownRemains() > ((6 + 9) / (((4 - 2) * v17(v24.Superstrain:IsAvailable())) + ((2 + 0) * v17(v24.EbonFever:IsAvailable())) + ((1 + 1) * v17(v24.Plaguebringer:IsAvailable()))))))) and (not v24.RaiseAbomination:IsAvailable() or not v26[342 - (192 + 134)] or (v24.RaiseAbomination:IsAvailable() and (v24.RaiseAbomination:CooldownRemains() > ((1291 - (316 + 960)) / (((2 + 0) * v17(v24.Superstrain:IsAvailable())) + ((2 + 0) * v17(v24.EbonFever:IsAvailable())) + ((2 + 0) * v17(v24.Plaguebringer:IsAvailable())))))));
end
local function v121(v198)
	return (v198:TimeToDie() > v198:DebuffRemains(v24.VirulentPlagueDebuff)) and v198:DebuffRefreshable(v24.VirulentPlagueDebuff);
end
local function v122(v199)
	return v199:DebuffUp(v24.TrollbaneSlowDebuff);
end
local function v123()
	if (v24.ArmyoftheDead:IsReady() and v7:IsInMeleeRange(18 - 13) and v26[568 - (83 + 468)] and v26[1823 - (1202 + 604)] and not v25.Fyralath:IsEquipped()) then
		if v14(v24.ArmyoftheDead) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\231\215\192\36\217\202\203\2\242\205\200\2\226\192\204\57\166\213\223\56\229\202\192\63\231\209\141\105", "\93\134\165\173");
		end
	end
	if (v24.Outbreak:IsReady() and v7:IsSpellInRange(v24.Outbreak) and v121(v7)) then
		if v14(v24.Outbreak) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\177\231\213\192\40\203\179\117\254\226\211\199\57\193\191\124\191\230\129\148", "\30\222\146\161\162\90\174\210");
		end
	end
	if (v55:IsReady() and v7:IsInMeleeRange(v56) and v7:IsInMeleeRange(v56)) then
		if v14(v24.FesteringStrike) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\227\75\99\30\224\92\121\4\226\113\99\30\247\71\123\15\165\94\98\15\230\65\125\8\228\90\48\82", "\106\133\46\16");
		end
	end
end
local function v124()
	if (v55:IsReady() and v7:IsInMeleeRange(v56)) then
		if v14(v55) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\94\37\96\232\95\82\81\46\116\195\73\67\65\52\123\249\26\65\87\37\51\174", "\32\56\64\19\156\58");
		end
	end
	if (v51:IsReady() and v7:IsInRange(WoundSpenderRange) and (v54 >= (4 - 3)) and v112(v7) and v6:BuffUp(v24.DeathAndDecayBuff) and v24.BurstingSores:IsAvailable() and (v24.Apocalypse:CooldownRemains() > v38)) then
		if v34.CastCycle(v51, v57, v122, WoundSpenderRange) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\77\199\240\88\94\205\147\74\205\235\82\95\224\192\91\199\224\22\14", "\224\58\168\133\54\58\146");
		end
	end
	if (v24.DeathCoil:IsReady() and not v40 and (v58 < v42)) then
		if v14(v24.DeathCoil, true, nil, not v7:IsInRange(66 - 26)) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\93\83\74\233\125\185\132\4\80\90\11\252\122\131\199\93", "\107\57\54\43\157\21\230\231");
		end
	end
	if (v24.Epidemic:IsReady() and v7:IsInRange(110 - 70) and not v40) then
		if v14(v24.Epidemic) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\222\155\24\241\188\209\198\216\203\16\250\188\156\153", "\175\187\235\113\149\217\188");
		end
	end
	if (v51:IsReady() and v7:IsInRange(WoundSpenderRange) and v122(v7) and (v54 >= (326 - (45 + 280))) and v113(v7)) then
		if v14(v52) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\43\160\148\66\231\70\107\44\170\143\72\230\107\56\61\160\132\12\187", "\24\92\207\225\44\131\25");
		end
	end
	if (v55:IsReady() and v7:IsInMeleeRange(v56) and ((v24.Apocalypse:CooldownRemains() < v38) or v6:BuffUp(v24.FesteringScytheBuff))) then
		if v14(v55) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\77\214\171\88\30\111\66\221\191\115\8\105\89\218\179\73\91\124\68\214\248\29\75", "\29\43\179\216\44\123");
		end
	end
	if (v55:IsReady() and v101(v7) and v7:IsInMeleeRange(v56)) then
		if v14(v55) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\187\220\51\88\184\203\41\66\186\230\51\88\175\208\43\73\253\216\47\73\253\136\114", "\44\221\185\64");
		end
	end
	if (v51:IsReady() and v7:IsInRange(WoundSpenderRange) and (v54 >= (1 + 0)) and v114(v7)) then
		if v14(v52) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\22\232\93\81\119\62\244\88\90\125\5\226\90\31\114\14\226\8\14\39", "\19\97\135\40\63");
		end
	end
end
local function v125()
	if (v24.FesteringScytheAction:IsReady() and v7:IsInMeleeRange(13 + 1)) then
		if v14(v24.FesteringScytheAction) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\168\89\32\47\42\35\167\82\52\4\60\50\183\72\59\62\111\48\161\89\12\57\58\35\189\72\115\105", "\81\206\60\83\91\79");
		end
	end
	if (v24.DeathCoil:IsReady() and not v24.VampiricStrikeAction:IsLearned() and (v58 < v42) and (not v24.BurstingSores:IsAvailable() or (v24.BurstingSores:IsAvailable() and (v24.FesteringWoundDebuff:AuraActiveCount() < v58) and (v24.FesteringWoundDebuff:AuraActiveCount() < (v58 * (0.4 + 0))) and v6:BuffUp(v24.SuddenDoomBuff)) or (v6:BuffUp(v24.SuddenDoomBuff) and ((v24.DoomedBidding:IsAvailable() and v24.MenacingMagus:IsAvailable()) or v24.RottenTouch:IsAvailable() or (v7:DebuffRemains(v24.DeathRotDebuff) < v6:GCD()))))) then
		if v14(v24.DeathCoil, true, nil, not v7:IsInRange(23 + 17)) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\74\174\209\102\39\252\78\171\71\167\144\115\32\198\114\166\91\185\195\102\111\151", "\196\46\203\176\18\79\163\45");
		end
	end
	if (v24.Epidemic:IsReady() and v7:IsInRange(8 + 32) and not v24.VampiricStrikeAction:IsLearned() and (not v24.BurstingSores:IsAvailable() or (v24.BurstingSores:IsAvailable() and (((v24.FesteringWoundDebuff:AuraActiveCount() < v59) and (v24.FesteringWoundDebuff:AuraActiveCount() < (v59 * (0.4 - 0))) and v6:BuffUp(v24.SuddenDoomBuff)) or not v94)) or (v6:BuffUp(v24.SuddenDoomBuff) and (v6:BuffUp(v24.AFeastofSoulsBuff) or (v7:DebuffRemains(v24.DeathRotDebuff) < v6:GCD()) or (v7:DebuffStack(v24.DeathRotDebuff) < (1921 - (340 + 1571))))))) then
		if v14(v24.Epidemic) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\189\50\119\26\33\246\230\187\98\127\17\33\196\237\173\48\109\10\100\175", "\143\216\66\30\126\68\155");
		end
	end
	if (v51:IsReady() and v116(v7) and v7:IsInRange(WoundSpenderRange)) then
		if v34.CastCycle(v51, v57, v122, WoundSpenderRange) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\189\199\24\197\193\156\196\241\175\198\9\206\215\227\214\238\175\247\15\222\215\176\195\161\252", "\129\202\168\109\171\165\195\183");
		end
	end
	if (v51:IsReady() and v7:IsInRange(WoundSpenderRange) and (v54 >= (1 + 0)) and v115(v7)) then
		if v14(v52) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\53\87\34\214\218\43\245\50\93\57\220\219\6\166\35\87\50\231\220\1\244\49\76\119\128", "\134\66\56\87\184\190\116");
		end
	end
	if (v24.Epidemic:IsReady() and v7:IsInRange(1812 - (1733 + 39))) then
		if v14(v24.Epidemic) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\57\33\0\191\28\230\40\54\124\48\6\190\38\233\52\39\47\37\73\234\73", "\85\92\81\105\219\121\139\65");
		end
	end
	if (v55:IsReady() and v7:IsInMeleeRange(v56) and v102(v7)) then
		if v14(v55) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\251\182\67\81\121\205\244\189\87\122\111\203\239\186\91\64\60\222\242\182\111\71\105\205\238\167\16\20\46", "\191\157\211\48\37\28");
		end
	end
	if (v51:IsReady() and v7:IsInRange(WoundSpenderRange) and (v54 >= (2 - 1))) then
		if v14(v52) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\200\16\225\18\62\224\12\228\25\52\219\26\230\92\59\208\26\203\30\47\205\12\224\92\107\139", "\90\191\127\148\124");
		end
	end
end
local function v126()
	if (v24.FesteringScytheAction:IsReady() and v7:IsInMeleeRange(1048 - (125 + 909))) then
		if v14(v24.FesteringScytheAction) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\126\130\61\3\125\149\39\25\127\184\61\20\97\147\38\18\56\134\33\18\71\148\43\3\109\151\110\69", "\119\24\231\78");
		end
	end
	if (v53:IsReady() and v26[1952 - (1096 + 852)] and ((v58 >= (1 + 0)) or v7:IsInRange(11 - 3)) and (v35.Commons.DnDMoving or not v6:IsMoving()) and not v6:DnDTicking() and ((not v24.BurstingSores:IsAvailable() and not v24.VileContagion:IsAvailable()) or (v24.FesteringWoundDebuff:AuraActiveCount() == v59) or (v24.FesteringWoundDebuff:AuraActiveCount() >= (8 + 0)) or (v6:BuffUp(v24.DeathAndDecayBuff) and v24.Defile:IsAvailable()))) then
		if v13.CastTarget(v24.DeathAndDecay, v13.TName().PLAYER) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\131\35\188\117\216\78\21\194\44\170\79\227\83\20\150\56\181\10\136", "\113\226\77\197\42\188\32");
		end
	end
	if (v51:IsReady() and v7:IsInRange(WoundSpenderRange)) then
		if v34.CastCycle(v51, v57, v122, WoundSpenderRange) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\45\25\225\187\62\41\231\165\63\24\240\176\40\86\245\186\63\41\231\176\46\3\228\245\108", "\213\90\118\148");
		end
	end
	if (v55:IsReady() and v7:IsInMeleeRange(v56)) then
		if v34.CastTargetIf(v55, v57, LUAOBFUSACTOR_DECRYPT_STR_0("\86\47\172", "\45\59\78\212\54"), v99, v103, v56) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\22\83\144\159\131\60\164\254\23\105\144\159\148\39\166\245\80\87\140\142\185\61\168\228\5\70\195\211", "\144\112\54\227\235\230\78\205");
		end
	end
	if (v55:IsReady() and v7:IsInMeleeRange(v56)) then
		if v34.CastTargetIf(v55, v57, LUAOBFUSACTOR_DECRYPT_STR_0("\190\41\23", "\59\211\72\111\156\176"), v99, v104, v56) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\72\130\240\57\75\149\234\35\73\184\240\57\92\142\232\40\14\134\236\40\113\148\230\57\91\151\163\124\30", "\77\46\231\131");
		end
	end
	if (v24.DeathCoil:IsReady() and not v40 and v6:BuffUp(v24.SuddenDoomBuff) and (v58 < v42)) then
		if v14(v24.DeathCoil, true, nil, not v7:IsInRange(552 - (409 + 103))) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\190\81\183\84\178\107\181\79\179\88\246\65\181\81\137\83\191\64\163\80\250\5\228", "\32\218\52\214");
		end
	end
	if (v24.Epidemic:IsReady() and v7:IsInRange(276 - (46 + 190)) and not v40 and v6:BuffUp(v24.SuddenDoomBuff)) then
		if v14(v24.Epidemic) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\75\7\56\172\244\189\76\89\14\22\62\173\206\163\64\78\91\7\113\249\163", "\58\46\119\81\200\145\208\37");
		end
	end
	if (v55:IsReady() and v7:IsInMeleeRange(v56)) then
		if v34.CastTargetIf(v55, v57, LUAOBFUSACTOR_DECRYPT_STR_0("\38\133\62", "\86\75\236\80\204\201\221"), v99, v105, v56) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\116\68\100\145\251\153\123\79\112\186\237\159\96\72\124\128\190\138\125\68\72\150\251\159\103\81\55\212\170", "\235\18\33\23\229\158");
		end
	end
	if (v24.DeathCoil:IsReady() and not v40 and (v58 < v42)) then
		if v14(v24.DeathCoil, true, nil, not v7:IsInRange(135 - (51 + 44))) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\84\191\192\175\88\133\194\180\89\182\129\186\95\191\254\168\85\174\212\171\16\235\153", "\219\48\218\161");
		end
	end
	if (v24.Epidemic:IsReady() and v7:IsInRange(12 + 28) and not v40) then
		if v14(v24.Epidemic) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\225\97\117\77\222\66\233\231\49\125\70\222\112\243\225\101\105\89\155\30\182", "\128\132\17\28\41\187\47");
		end
	end
end
local function v127()
	if (v24.DarkTransformation:IsCastable() and v7:IsInMeleeRange(1322 - (1114 + 203)) and v26[731 - (228 + 498)] and ((v36 and ((v24.Apocalypse:CooldownRemains() < (2 + 6)) or not v24.Apocalypse:IsAvailable() or (v59 >= (1 + 0)))) or (v63 < (683 - (174 + 489))))) then
		if v14(v24.DarkTransformation) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\5\51\20\49\98\21\32\7\52\78\7\61\20\55\92\21\59\9\52\29\2\54\21\122\15", "\61\97\82\102\90");
		end
	end
	if (v24.UnholyAssault:IsCastable() and v7:IsInMeleeRange(12 - 7) and v26[1916 - (830 + 1075)] and v36 and ((v24.Apocalypse:CooldownRemains() < (v6:GCD() * (526 - (303 + 221)))) or not v24.Apocalypse:IsAvailable() or ((v59 >= (1271 - (231 + 1038))) and v10:BuffUp(v24.DarkTransformation)))) then
		if v14(v24.UnholyAssault) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\185\32\163\68\203\78\33\8\191\61\170\94\203\67\94\10\168\61\235\31", "\105\204\78\203\43\167\55\126");
		end
	end
	if (v24.Apocalypse:IsReady() and v7:IsInMeleeRange(5 + 0) and v26[1172 - (171 + 991)] and (v36 or (v63 < (82 - 62)))) then
		if v14(v24.Apocalypse) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\164\186\44\29\18\8\222\65\182\175\99\29\23\23\135\0\245", "\49\197\202\67\126\115\100\167");
		end
	end
	if (v24.Outbreak:IsReady() and v7:IsSpellInRange(v24.Outbreak)) then
		if v34.CastCycle(v24.Outbreak, v60, v118, 107 - 67) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\56\78\203\43\146\83\95\60\27\220\45\147\22\6", "\62\87\59\191\73\224\54");
		end
	end
	if (v24.AbominationLimb:IsCastable() and v7:IsInRange(49 - 29) and v26[10 + 2] and ((v36 and v6:BuffDown(v24.SuddenDoomBuff) and ((v6:BuffUp(v24.FestermightBuff) and (v6:BuffStack(v24.FestermightBuff) > (27 - 19))) or not v24.Festermight:IsAvailable()) and ((v46 < (14 - 9)) or not v24.Apocalypse:IsAvailable()) and (v54 <= (2 - 0))) or (v63 < (36 - 24)))) then
		if v14(v24.AbominationLimb) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\230\0\245\196\238\12\251\221\238\13\244\246\235\11\247\203\167\1\254\218\167\83\168", "\169\135\98\154");
		end
	end
end
local function v128()
	if (v24.VileContagion:IsReady() and v110(v7) and v7:IsSpellInRange(v24.VileContagion)) then
		if v14(v24.VileContagion) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\221\126\40\81\194\48\199\197\99\37\83\244\60\198\139\116\32\71\194\50\199\206\55\118", "\168\171\23\68\52\157\83");
		end
	end
	if (v24.UnholyAssault:IsCastable() and v7:IsInMeleeRange(1253 - (111 + 1137)) and v26[169 - (91 + 67)] and v108(v7)) then
		if v14(v24.UnholyAssault) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\225\127\253\162\41\52\184\245\98\230\172\48\33\147\180\114\241\190\26\44\136\241\49\161", "\231\148\17\149\205\69\77");
		end
	end
	if (v24.DarkTransformation:IsCastable() and v7:IsInMeleeRange(14 - 9) and v26[2 + 3] and v37 and ((v24.VileContagion:CooldownRemains() > (528 - (423 + 100))) or not v24.VileContagion:IsAvailable() or v6:DnDTicking() or (v53:CooldownRemains() < (1 + 2)))) then
		if v14(v24.DarkTransformation) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\132\166\213\240\104\235\146\166\201\232\81\240\146\170\198\239\94\240\142\231\196\255\68\192\129\168\194\187\1", "\159\224\199\167\155\55");
		end
	end
	if (v24.Outbreak:IsReady() and v7:IsSpellInRange(v24.Outbreak) and (v7:DebuffTicksRemain(v24.VirulentPlagueDebuff) < (13 - 8)) and v7:DebuffRefreshable(v24.VirulentPlagueDebuff) and (not v24.UnholyBlight:IsAvailable() or (v24.UnholyBlight:IsAvailable() and v24.DarkTransformation:CooldownDown())) and (not v24.RaiseAbomination:IsAvailable() or (v24.RaiseAbomination:IsAvailable() and v24.RaiseAbomination:CooldownDown()))) then
		if v14(v24.Outbreak) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\248\230\40\208\229\246\61\217\183\240\56\193\200\242\51\215\183\171", "\178\151\147\92");
		end
	end
	if (v24.Apocalypse:IsReady() and v7:IsInMeleeRange(3 + 2) and v26[781 - (326 + 445)] and v37 and (v6:Rune() <= (13 - 10))) then
		if v14(v24.Apocalypse) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\141\237\67\49\19\64\99\156\238\73\114\17\72\105\179\252\67\55\82\29\42", "\26\236\157\44\82\114\44");
		end
	end
	if (v24.AbominationLimb:IsCastable() and v7:IsInRange(44 - 24) and v26[27 - 15] and v37) then
		if v14(v24.AbominationLimb) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\43\44\218\86\35\32\212\79\35\33\219\100\38\39\216\89\106\45\209\72\21\47\218\94\106\127\135", "\59\74\78\181");
		end
	end
end
local function v129()
	if (v24.DarkTransformation:IsCastable() and v7:IsInMeleeRange(716 - (530 + 181)) and v26[886 - (614 + 267)] and ((v37 and v6:BuffUp(v24.DeathAndDecayBuff)) or (v59 <= (35 - (19 + 13))))) then
		if v14(v24.DarkTransformation) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\33\208\72\81\140\49\195\91\84\160\35\222\72\87\178\49\216\85\84\243\38\213\73\101\178\42\212\101\73\178\43\145\8", "\211\69\177\58\58");
		end
	end
	if (v24.VileContagion:IsReady() and v7:IsSpellInRange(v24.VileContagion) and v110(v7)) then
		if v14(v24.VileContagion) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\161\236\117\240\214\200\184\235\109\244\238\194\184\235\57\246\237\216\136\228\118\240\214\216\182\235\57\161", "\171\215\133\25\149\137");
		end
	end
	if (v24.UnholyAssault:IsCastable() and v7:IsInMeleeRange(7 - 2) and v26[25 - 14] and v109(v7) and v37) then
		if v14(v24.UnholyAssault) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\244\198\58\245\227\41\195\67\242\219\51\239\227\36\188\65\229\219\13\251\224\53\195\81\224\198\114\172", "\34\129\168\82\154\143\80\156");
		end
	end
	if (v24.Outbreak:IsReady() and v7:IsSpellInRange(v24.Outbreak) and (v7:DebuffTicksRemain(v24.VirulentPlagueDebuff) < (14 - 9)) and (v7:DebuffRefreshable(v24.VirulentPlagueDebuff) or (v24.Morbidity:IsAvailable() and v6:BuffDown(v24.GiftoftheSanlaynBuff) and v24.Superstrain:IsAvailable() and v7:DebuffRefreshable(v24.FrostFeverDebuff) and v7:DebuffRefreshable(v24.BloodPlagueDebuff))) and (not v24.UnholyBlight:IsAvailable() or (v24.UnholyBlight:IsAvailable() and v24.DarkTransformation:CooldownDown())) and (not v24.RaiseAbomination:IsAvailable() or (v24.RaiseAbomination:IsAvailable() and v24.RaiseAbomination:CooldownDown()))) then
		if v14(v24.Outbreak) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\138\167\39\9\90\75\136\142\242\48\15\91\113\136\138\183\12\24\73\64\201\221", "\233\229\210\83\107\40\46");
		end
	end
	if (v24.Apocalypse:IsReady() and v7:IsInMeleeRange(2 + 3) and v26[17 - 7] and v37 and (v6:Rune() <= (6 - 3))) then
		if v14(v24.Apocalypse) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\192\82\61\213\4\205\91\34\197\0\129\65\54\197\58\192\77\55\233\22\192\76\114\135\85", "\101\161\34\82\182");
		end
	end
	if (v24.AbominationLimb:IsCastable() and v7:IsInRange(1832 - (1293 + 519)) and v26[23 - 11] and v37) then
		if v14(v24.AbominationLimb) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\233\15\86\243\210\236\131\58\225\2\87\193\215\235\143\44\168\14\93\237\228\227\141\43\215\30\88\240\155\179\208", "\78\136\109\57\158\187\130\226");
		end
	end
end
local function v130()
	if (v24.DarkTransformation:IsCastable() and v7:IsInMeleeRange(13 - 8) and v26[9 - 4] and (v59 >= (4 - 3)) and v36 and ((v24.Apocalypse:IsAvailable() and v45) or not v24.Apocalypse:IsAvailable())) then
		if v14(v24.DarkTransformation) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\58\62\235\250\1\43\235\240\48\44\255\254\44\50\248\229\55\48\247\177\61\59\234\206\45\62\247\177\108", "\145\94\95\153");
		end
	end
	if (v24.UnholyAssault:IsCastable() and v7:IsInMeleeRange(11 - 6) and v26[6 + 5] and v36 and v10:BuffUp(v24.DarkTransformation) and (v10:BuffRemains(v24.DarkTransformation) < (3 + 9))) then
		if v14(v24.UnholyAssault) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\232\195\28\218\66\174\194\204\7\198\79\162\241\217\84\214\74\164\194\222\21\219\14\227", "\215\157\173\116\181\46");
		end
	end
	if (v24.Apocalypse:IsReady() and v7:IsInMeleeRange(11 - 6) and v26[3 + 7] and ((v36 and (v54 >= (1 + 2))) or (v63 < (13 + 7)))) then
		if v14(v24.Apocalypse) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\52\164\132\241\219\57\173\155\225\223\117\183\143\225\229\38\181\133\178\140", "\186\85\212\235\146");
		end
	end
	if (v24.Outbreak:IsReady() and v7:IsSpellInRange(v24.Outbreak)) then
		if v34.CastCycle(v24.Outbreak, v60, v119, 1136 - (709 + 387)) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\205\148\2\252\43\235\89\201\193\21\250\42\209\75\195\143\86\166", "\56\162\225\118\158\89\142");
		end
	end
	if (v24.AbominationLimb:IsCastable() and v7:IsInRange(1878 - (673 + 1185)) and v26[34 - 22] and (((v59 >= (3 - 2)) and v36 and v6:BuffDown(v24.GiftoftheSanlaynBuff) and v10:BuffDown(v24.DarkTransformation) and v6:BuffDown(v24.SuddenDoomBuff) and v6:BuffUp(v24.FestermightBuff) and (v54 <= (2 - 0))) or (v6:BuffDown(v24.GiftoftheSanlaynBuff) and (v63 < (9 + 3))))) then
		if v14(v24.AbominationLimb) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\93\7\207\162\43\214\93\17\201\160\44\231\80\12\205\173\98\219\88\22\255\188\35\214\28\84\144", "\184\60\101\160\207\66");
		end
	end
end
local function v131()
	if v35.Commons.Enabled.Potions then
		local v223 = v34.PotionSelected();
		if (v223 and v26[7 + 2]) then
			if (v223:IsReady() and (((v59 >= (1 - 0)) and (not v24.SummonGargoyle:IsAvailable() or (v24.SummonGargoyle:CooldownRemains() > (15 + 45))) and ((v10:BuffUp(v24.DarkTransformation) and ((59 - 29) >= v10:BuffRemains(v24.DarkTransformation))) or (v47 and (v48 <= (58 - 28))) or (v45 and (v46 <= (1910 - (446 + 1434)))) or (v43 and (v44 <= (1313 - (1040 + 243)))))) or (v63 <= (89 - 59)))) then
				if v13.CastMacro(1850 - (559 + 1288), nil, nil, v223) then
					return LUAOBFUSACTOR_DECRYPT_STR_0("\33\141\104\181\62\140\60\180\56\133\116\131\33\144\117\179\14\131\127\168\56\141\114\175\113\208", "\220\81\226\28");
				end
			end
		end
	end
	if (v24.ArmyoftheDead:IsReady() and v7:IsInMeleeRange(1936 - (609 + 1322)) and v26[471 - (13 + 441)] and (((v36 or v37) and ((v24.CommanderoftheDead:IsAvailable() and (v24.DarkTransformation:CooldownRemains() < (18 - 13))) or (not v24.CommanderoftheDead:IsAvailable() and (v59 >= (2 - 1))))) or (v63 < (174 - 139)))) then
		if v14(v24.ArmyoftheDead) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\18\199\143\226\213\200\21\234\150\243\239\248\23\208\131\255\170\196\23\198\189\232\226\198\1\208\134\187\190", "\167\115\181\226\155\138");
		end
	end
	if (v24.RaiseAbomination:IsCastable() and v7:IsInMeleeRange(1 + 4) and v26[58 - 42] and (v36 or v37 or (v63 < (11 + 19)))) then
		if v14(v24.RaiseAbomination) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\240\35\238\79\126\78\199\224\45\234\85\117\112\210\235\45\233\28\120\117\213\221\49\239\93\105\116\194\162\116", "\166\130\66\135\60\27\17");
		end
	end
	if (v24.SummonGargoyle:IsReady() and v7:IsInMeleeRange(3 + 2) and v26[44 - 29] and (v36 or v37) and (v6:BuffUp(v24.CommanderoftheDeadBuff) or (not v24.CommanderoftheDead:IsAvailable() and (v59 >= (1 + 0))))) then
		if v14(v24.SummonGargoyle) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\87\95\195\120\63\74\117\201\116\34\67\69\215\121\53\4\73\202\102\15\87\66\207\103\53\64\10\150", "\80\36\42\174\21");
		end
	end
end
local function v132()
	if (v53:IsReady() and v26[7 - 3] and ((v58 >= (1 + 0)) or v7:IsInRange(5 + 3)) and (v35.Commons.DnDMoving or not v6:IsMoving()) and not v6:DnDTicking()) then
		if v13.CastTarget(v24.DeathAndDecay, v13.TName().PLAYER) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\79\30\46\69\74\30\51\58\77\28\50\123\88\21\119\40", "\26\46\112\87");
		end
	end
	if (v24.DeathCoil:IsReady() and v7:IsSpellInRange(v24.DeathCoil) and not v40 and v24.ImprovedDeathCoil:IsAvailable()) then
		if v14(v24.DeathCoil) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\189\38\170\96\183\128\70\187\176\47\235\119\179\186\68\162\188\99\255", "\212\217\67\203\20\223\223\37");
		end
	end
	if (v55:IsReady() and v7:IsInMeleeRange(v56) and v106(v7)) then
		if v14(v55) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\188\136\187\198\191\159\161\220\189\178\187\198\168\132\163\215\250\142\164\215\187\155\173\146\226", "\178\218\237\200");
		end
	end
	if (v55:IsReady() and v7:IsInMeleeRange(v56) and v107(v7)) then
		if v14(v55) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\176\176\245\196\179\167\239\222\177\138\245\196\164\188\237\213\246\182\234\213\183\163\227\144\231\229", "\176\214\213\134");
		end
	end
	if (v51:IsReady() and v7:IsInRange(WoundSpenderRange) and (v54 >= (1 + 0)) and v39) then
		if v14(v52) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\227\162\163\218\172\105\74\228\168\184\208\173\68\25\247\161\179\213\190\83\25\165\255", "\57\148\205\214\180\200\54");
		end
	end
end
local function v133()
	if (v24.ArcaneTorrent:IsCastable() and v7:IsInRange(7 + 1) and v26[6 + 0] and (v6:RunicPower() < (453 - (153 + 280))) and (v6:Rune() < (5 - 3))) then
		if v14(v24.ArcaneTorrent) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\19\239\54\53\120\23\194\33\59\100\0\248\59\32\54\0\252\54\61\119\30\238\117\102", "\22\114\157\85\84");
		end
	end
	if (v24.BloodFury:IsCastable() and v7:IsInRange(5 + 0) and v26[3 + 3] and ((((v24.BloodFury:BaseDuration() + 2 + 1) >= v50) and v49) or ((not v24.SummonGargoyle:IsAvailable() or (v24.SummonGargoyle:CooldownRemains() > (55 + 5))) and ((v47 and (v48 <= (v24.BloodFury:BaseDuration() + 3 + 0))) or (v45 and (v46 <= (v24.BloodFury:BaseDuration() + (4 - 1)))) or ((v59 >= (2 + 0)) and v6:DnDTicking()))) or (v63 <= (v24.BloodFury:BaseDuration() + (670 - (89 + 578)))))) then
		if v14(v24.BloodFury) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\198\199\28\203\89\201\174\209\217\10\132\79\247\171\205\202\31\215\29\162", "\200\164\171\115\164\61\150");
		end
	end
	if (v24.Berserking:IsCastable() and v7:IsInRange(4 + 1) and v26[11 - 5] and ((((v24.Berserking:BaseDuration() + (1052 - (572 + 477))) >= v50) and v49) or ((not v24.SummonGargoyle:IsAvailable() or (v24.SummonGargoyle:CooldownRemains() > (9 + 51))) and ((v47 and (v48 <= (v24.Berserking:BaseDuration() + 2 + 1))) or (v45 and (v46 <= (v24.Berserking:BaseDuration() + 1 + 2))) or ((v59 >= (88 - (84 + 2))) and v6:DnDTicking()))) or (v63 <= (v24.Berserking:BaseDuration() + (4 - 1))))) then
		if v14(v24.Berserking) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\188\241\17\86\134\172\255\10\75\132\254\230\2\70\138\191\248\16\5\213", "\227\222\148\99\37");
		end
	end
	if (v24.LightsJudgment:IsCastable() and v7:IsInRange(4 + 1) and v26[848 - (497 + 345)] and v6:BuffUp(v24.UnholyStrengthBuff) and (not v24.Festermight:IsAvailable() or (v6:BuffRemains(v24.FestermightBuff) < v7:TimeToDie()) or (v6:BuffRemains(v24.UnholyStrengthBuff) < v7:TimeToDie()))) then
		if v14(v24.LightsJudgment) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\63\91\85\254\237\32\109\88\227\253\52\95\87\248\237\115\64\83\245\240\50\94\65\182\161", "\153\83\50\50\150");
		end
	end
	if (v24.AncestralCall:IsCastable() and v7:IsInRange(1 + 4) and v26[2 + 4] and ((((1351 - (605 + 728)) >= v50) and v49) or ((not v24.SummonGargoyle:IsAvailable() or (v24.SummonGargoyle:CooldownRemains() > (43 + 17))) and ((v47 and (v48 <= (39 - 21))) or (v45 and (v46 <= (1 + 17))) or ((v59 >= (7 - 5)) and v6:DnDTicking()))) or (v63 <= (17 + 1)))) then
		if v14(v24.AncestralCall) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\92\120\112\25\96\191\95\92\122\76\31\114\167\65\29\100\114\31\122\170\65\78\54\34\76", "\45\61\22\19\124\19\203");
		end
	end
	if (v24.ArcanePulse:IsCastable() and v7:IsInRange(21 - 13) and v26[5 + 1] and ((v59 >= (491 - (457 + 32))) or ((v6:Rune() <= (1 + 0)) and (v6:RunicPowerDeficit() >= (1462 - (832 + 570)))))) then
		if v14(v24.ArcanePulse) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\192\0\14\244\12\117\134\209\7\1\230\7\48\171\192\17\4\244\14\99\249\144\64", "\217\161\114\109\149\98\16");
		end
	end
	if (v24.Fireblood:IsCastable() and v7:IsInRange(5 + 0) and v26[2 + 4] and ((((v24.Fireblood:BaseDuration() + (10 - 7)) >= v50) and v49) or ((not v24.SummonGargoyle:IsAvailable() or (v24.SummonGargoyle:CooldownRemains() > (29 + 31))) and ((v47 and (v48 <= (v24.Fireblood:BaseDuration() + (799 - (588 + 208))))) or (v45 and (v46 <= (v24.Fireblood:BaseDuration() + (8 - 5)))) or ((v59 >= (1802 - (884 + 916))) and v6:DnDTicking()))) or (v63 <= (v24.Fireblood:BaseDuration() + (6 - 3))))) then
		if v14(v24.Fireblood) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\20\41\42\121\190\120\29\47\60\60\174\117\17\41\57\112\175\52\67\116", "\20\114\64\88\28\220");
		end
	end
	if (v24.BagofTricks:IsCastable() and v7:IsInRange(3 + 2) and v26[659 - (232 + 421)] and (v59 <= (1890 - (1569 + 320))) and (v6:BuffUp(v24.UnholyStrengthBuff) or (v63 < (2 + 3)))) then
		if v14(v24.BagofTricks) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\51\0\213\139\247\214\130\37\19\219\183\243\195\253\35\0\209\189\249\220\174\113\80\132", "\221\81\97\178\212\152\176");
		end
	end
end
local function v134()
	if (v24.AntiMagicShell:IsCastable() and v35.Commons.UseAMSAMZOffensively and (v35.Unholy.AMSAbsorbPercent > (0 + 0)) and (v6:RunicPower() < (134 - 94))) then
		if v14(v24.AntiMagicShell) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\204\233\9\242\23\204\224\20\248\37\222\239\24\247\22\141\244\28\245\37\203\238\14\243\19\195\224\93\169", "\122\173\135\125\155");
		end
	end
	if (v53:IsReady() and v26[609 - (316 + 289)] and ((v58 >= (2 - 1)) or v7:IsInRange(1 + 7)) and (v35.Commons.DnDMoving or not v6:IsMoving()) and v6:BuffDown(v24.DeathAndDecayBuff) and not v24.VampiricStrikeAction:IsLearned()) then
		if v13.CastTarget(v24.DeathAndDecay, v13.TName().PLAYER) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\133\207\25\134\59\63\204\196\210\1\183\0\55\193\151\201\9\183\56\113\156", "\168\228\161\96\217\95\81");
		end
	end
	if (v24.DeathCoil:IsReady() and v7:IsSpellInRange(v24.DeathCoil) and v6:BuffUp(v24.SuddenDoomBuff) and v24.DoomedBidding:IsAvailable()) then
		if v14(v24.DeathCoil) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\223\212\47\72\39\104\216\222\39\80\111\68\218\223\17\90\38\68\211\216\32\91\111\1", "\55\187\177\78\60\79");
		end
	end
	if (v24.SoulReaper:IsReady() and v7:IsInMeleeRange(1458 - (666 + 787)) and ((v7:HealthPercentage() <= (460 - (360 + 65))) or (v7:TimeToX(33 + 2) <= (259 - (79 + 175)))) and (v7:TimeToDie() > (7 - 2))) then
		if v14(v24.SoulReaper) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\62\193\74\231\121\221\133\44\222\90\249\6\220\129\35\241\89\226\85\199\137\35\201\31\179", "\224\77\174\63\139\38\175");
		end
	end
	if (v24.DeathCoil:IsReady() and v7:IsSpellInRange(v24.DeathCoil) and not v24.VampiricStrikeAction:IsLearned()) then
		if v14(v24.DeathCoil) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\128\68\89\58\140\126\91\33\141\77\24\61\133\79\103\40\141\82\80\39\138\70\24\127\212", "\78\228\33\56");
		end
	end
	if (v51:IsReady() and v7:IsInRange(WoundSpenderRange) and (v54 >= (1 + 0)) and (((v54 >= ((8 - 5) - v17(v43))) and (v24.Apocalypse:CooldownRemains() > v38)) or v24.VampiricStrikeAction:IsLearned())) then
		if v14(v52) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\217\113\167\13\129\241\109\162\6\139\202\123\160\67\150\207\112\141\5\140\221\118\187\13\130\142\47\224", "\229\174\30\210\99");
		end
	end
	if (v55:IsReady() and v7:IsInMeleeRange(v56) and (v54 < ((5 - 2) - v17(v43)))) then
		if v14(v55) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\29\232\149\69\232\47\48\21\234\185\66\249\47\48\16\232\198\66\236\51\6\29\228\149\89\228\51\62\91\188\210", "\89\123\141\230\49\141\93");
		end
	end
end
local function v135()
	if (v53:IsReady() and v26[903 - (503 + 396)] and ((v58 >= (182 - (92 + 89))) or v7:IsInRange(15 - 7)) and (v35.Commons.DnDMoving or not v6:IsMoving()) and v6:BuffDown(v24.DeathAndDecayBuff) and v24.UnholyGround:IsAvailable() and (v24.DarkTransformation:CooldownRemains() < (3 + 2))) then
		if v13.CastTarget(v24.DeathAndDecay, v13.TName().PLAYER) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\242\127\239\51\20\68\247\49\229\13\30\117\224\101\182\93", "\42\147\17\150\108\112");
		end
	end
	if (v24.DeathCoil:IsReady() and v7:IsSpellInRange(v24.DeathCoil) and ((v6:BuffUp(v24.SuddenDoomBuff) and v6:BuffUp(v24.GiftoftheSanlaynBuff) and (v24.DoomedBidding:IsAvailable() or v24.RottenTouch:IsAvailable())) or ((v6:Rune() < (2 + 0)) and v6:BuffDown(v24.RunicCorruptionBuff)))) then
		if v14(v24.DeathCoil) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\11\163\44\107\239\215\12\169\36\115\167\251\14\168\18\108\243\168\93", "\136\111\198\77\31\135");
		end
	end
	if (v51:IsReady() and v7:IsSpellInRange(v24.DeathCoil) and ((v6:BuffUp(v24.GiftoftheSanlaynBuff) and v24.VampiricStrikeAction:IsLearned()) or (v24.GiftoftheSanlayn:IsAvailable() and v10:BuffUp(v24.DarkTransformation) and (v10:BuffRemains(v24.DarkTransformation) < v6:GCD())))) then
		if v14(v52) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\21\6\178\88\185\219\4\185\7\7\163\83\175\164\4\168\12\54\180\66\253\176", "\201\98\105\199\54\221\132\119");
		end
	end
	if (v24.SoulReaper:IsReady() and v7:IsInMeleeRange(19 - 14) and ((v7:HealthPercentage() <= (5 + 30)) or (v7:TimeToX(79 - 44) <= (5 + 0))) and (v7:TimeToDie() > (3 + 2)) and v6:BuffDown(v24.GiftoftheSanlaynBuff)) then
		if v14(v24.SoulReaper) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\170\3\150\45\61\39\169\184\28\134\51\66\38\173\183\51\144\53\66\99", "\204\217\108\227\65\98\85");
		end
	end
	if (v51:IsReady() and v24.VampiricStrikeAction:IsLearned() and (v54 >= (2 - 1))) then
		if v14(v51, nil, nil, not v7:IsSpellInRange(v51)) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\73\204\224\235\40\255\77\211\240\235\40\197\76\131\230\228\34\255\77\215\181\178", "\160\62\163\149\133\76");
		end
	end
	if (v55:IsReady() and v7:IsInMeleeRange(v56) and (((v54 < (1 + 3)) and (v24.Apocalypse:CooldownRemains() < v38)) or (((v24.GiftoftheSanlayn:IsAvailable() and v6:BuffDown(v24.GiftoftheSanlaynBuff)) or not v24.GiftoftheSanlayn:IsAvailable()) and (v6:BuffUp(v24.FesteringScytheBuff) or (v54 <= ((1 - 0) - v17(v43))))))) then
		if v14(v55) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\208\165\30\59\198\196\169\3\40\252\197\180\31\38\200\211\224\30\46\205\233\179\25\111\155", "\163\182\192\109\79");
		end
	end
	if (v51:IsReady() and (not v24.Apocalypse:IsAvailable() or (v24.Apocalypse:CooldownRemains() > v38)) and ((v54 >= ((1247 - (485 + 759)) - v17(v43))) or v24.VampiricStrikeAction:IsLearned())) then
		if v14(v52) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\35\41\21\206\241\11\53\16\197\251\48\35\18\128\230\53\40\63\211\225\116\119\80", "\149\84\70\96\160");
		end
	end
	if (v24.DeathCoil:IsReady() and v7:IsSpellInRange(v24.DeathCoil) and ((not v40 and (v7:DebuffRemains(v24.DeathRotDebuff) < v6:GCD())) or (v6:BuffUp(v24.SuddenDoomBuff) and (v54 >= (2 - 1))) or (v6:Rune() < (1191 - (442 + 747))))) then
		if v14(v24.DeathCoil) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\60\3\12\249\48\57\14\226\49\10\77\254\57\8\50\254\44\70\92\191", "\141\88\102\109");
		end
	end
	if (v51:IsReady() and v7:IsInRange(WoundSpenderRange) and (v54 >= (1136 - (832 + 303))) and (v54 > (950 - (88 + 858)))) then
		if v14(v52) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\164\92\223\126\30\2\70\209\182\93\206\117\8\125\70\192\189\108\217\100\90\108\1", "\161\211\51\170\16\122\93\53");
		end
	end
	if (v24.DeathCoil:IsReady() and v7:IsSpellInRange(v24.DeathCoil) and not v40) then
		if v14(v24.DeathCoil) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\255\171\179\60\243\145\177\39\242\162\242\59\250\160\141\59\239\238\227\126", "\72\155\206\210");
		end
	end
end
local function v136()
	if (v35.Commons.Enabled.Items and v25.Fyralath:IsReady() and v7:DebuffUp(v24.MarkofFyralathDebuff) and ((v59 < (2 + 3)) or (v59 > (18 + 3)) or (v63 < (1 + 3))) and (v43 or v47 or (not v24.RaiseAbomination:IsAvailable() and not v24.ArmyoftheDead:IsAvailable()) or (v3.CombatTime() > (804 - (766 + 23))))) then
		v13.CastMacro(4 - 3, nil, nil, v25.Fyralath);
		return LUAOBFUSACTOR_DECRYPT_STR_0("\64\99\70\15\63\71\110\92\49\39\78\127\107\10\33\67\123\89\28\54\72\126\81\28\115\85\123\90\49\39\84\115\90\5\54\82\105\20\92", "\83\38\26\52\110");
	end
end
if v35.Commons.Enabled.Trinkets then
	if (v25.TreacherousTransmitter:IsEquippedAndReady() and (((v66 == v25.TreacherousTransmitter:ID()) and v26[9 - 2]) or ((v67 == v25.TreacherousTransmitter:ID()) and v26[20 - 12].Trinket2Setting)) and v7:IsInMeleeRange(16 - 11) and (v37 or v36) and (v24.DarkTransformation:CooldownRemains() < (1076 - (1036 + 37)))) then
		if v14(v25.TreacherousTransmitter, nil) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\76\5\34\71\91\31\34\84\87\2\52\121\76\5\38\72\75\26\46\82\76\18\53\6\75\22\41\121\76\5\46\72\83\18\51\85\24\69", "\38\56\119\71");
		end
	end
	if (v29:IsReady() and v26[5 + 2] and not v76 and ((v78 and v10:BuffUp(v24.DarkTransformation) and (v10:BuffRemains(v24.DarkTransformation) < (v80 * (0.73 - 0))) and ((v84 == (1 + 0)) or v30:CooldownDown() or not v30:HasCooldown())) or (v80 >= v63))) then
		if v14(v29, true) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\212\234\86\211\55\95\240\175\77\197\32\105\250\251\93\219\101\80\252\253\24", "\54\147\143\56\182\69") .. v29:Name() .. LUAOBFUSACTOR_DECRYPT_STR_0("\150\146\254\71\224\194\147\246\71\212\211\149\236\9\139", "\191\182\225\159\41");
		end
	end
	if (v30:IsReady() and v26[1488 - (641 + 839)] and not v77 and ((v79 and v10:BuffUp(v24.DarkTransformation) and (v10:BuffRemains(v24.DarkTransformation) < (v81 * (913.73 - (910 + 3)))) and ((v84 == (4 - 2)) or v29:CooldownDown() or not v29:HasCooldown())) or (v81 >= v63))) then
		if v14(v30, true) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\12\23\38\80\153\142\193\107\7\59\80\180\142\214\46\31\104\83\132\149\130", "\162\75\114\72\53\235\231") .. v30:Name() .. LUAOBFUSACTOR_DECRYPT_STR_0("\204\47\69\236\108\22\158\53\74\233\86\22\159\124\18", "\98\236\92\36\130\51");
		end
	end
	if (v29:IsReady() and v26[1691 - (1466 + 218)] and not v76 and ((not v78 and (((v72 > (0 + 0)) and v6:BuffDown(v24.GiftoftheSanlaynBuff)) or (v72 == (1148 - (556 + 592)))) and ((v85 == (1 + 0)) or v30:CooldownDown() or not v30:HasCooldown() or (not v24.SummonGargoyle:IsAvailable() and not v24.ArmyoftheDead:IsAvailable() and not v24.RaiseAbomination:IsAvailable()) or (not v24.SummonGargoyle:IsAvailable() and v24.ArmyoftheDead:IsAvailable() and ((not v24.RaiseAbomination:IsAvailable() and (v24.ArmyoftheDead:CooldownRemains() > (828 - (329 + 479)))) or (v24.RaiseAbomination:IsAvailable() and (v24.RaiseAbomination:CooldownRemains() > (874 - (174 + 680)))))) or (not v24.SummonGargoyle:IsAvailable() and not v24.ArmyoftheDead:IsAvailable() and not v24.RaiseAbomination:IsAvailable() and (v24.DarkTransformation:CooldownRemains() > (68 - 48))) or (v24.SummonGargoyle:IsAvailable() and (v24.SummonGargoyle:CooldownRemains() > (41 - 21)) and not v49))) or (v63 < (11 + 4)))) then
		if v14(v29, true) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\131\28\2\191\87\161\182\112\177\10\9\133\76\188\176\61\228\31\3\168\5", "\80\196\121\108\218\37\200\213") .. v29:Name() .. LUAOBFUSACTOR_DECRYPT_STR_0("\64\96\3\113\116\26\152\9\125\9\122\95\29\202\88", "\234\96\19\98\31\43\110");
		end
	end
	if (v30:IsReady() and v26[747 - (396 + 343)] and not v77 and ((not v79 and (((v73 > (0 + 0)) and v6:BuffDown(v24.GiftoftheSanlaynBuff)) or (v73 == (1477 - (29 + 1448)))) and ((v85 == (1391 - (135 + 1254))) or v29:CooldownDown() or not v29:HasCooldown() or (not v24.SummonGargoyle:IsAvailable() and not v24.ArmyoftheDead:IsAvailable() and not v24.RaiseAbomination:IsAvailable()) or (not v24.SummonGargoyle:IsAvailable() and v24.ArmyoftheDead:IsAvailable() and ((not v24.RaiseAbomination:IsAvailable() and (v24.ArmyoftheDead:CooldownRemains() > (75 - 55))) or (v24.RaiseAbomination:IsAvailable() and (v24.RaiseAbomination:CooldownRemains() > (93 - 73))))) or (not SummonGargoyle:IsAvailable() and not v24.ArmyoftheDead:IsAvailable() and not v24.RaiseAbomination:IsAvailable() and (v24.DarkTransformation:CooldownRemains() > (14 + 6))) or (v24.SummonGargoyle:IsAvailable() and (v24.SummonGargoyle:CooldownRemains() > (1547 - (389 + 1138))) and not v49))) or (v63 < (589 - (102 + 472))))) then
		if v14(v30, true) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\33\26\92\194\190\123\136\70\10\65\194\147\123\159\3\18\18\193\163\96\203", "\235\102\127\50\167\204\18") .. v30:Name() .. LUAOBFUSACTOR_DECRYPT_STR_0("\16\178\244\45\123\58\66\168\251\40\65\58\67\225\164\115", "\78\48\193\149\67\36");
		end
	end
	if (v35.Commons.Enabled.Items and WeaponSetting) then
		local v226, v227, v228 = v6:GetUseableItems(v27, nil, true);
		if (v226 and v7:IsInMeleeRange(5 + 0) and (not v78 or v29:CooldownDown()) and (not v79 or v30:CooldownDown())) then
			v13.CastMacro(1 + 0, nil, nil);
			return v226:Name() .. LUAOBFUSACTOR_DECRYPT_STR_0("\112\13\129\22\126\36\12\137\22\74\53\10\147\88\16\98", "\33\80\126\224\120");
		end
	end
end
local function v137()
	if (v24.SoulReaper:IsReady() and v7:IsInMeleeRange(5 + 0) and ((v7:HealthPercentage() <= (1580 - (320 + 1225))) or (v7:TimeToX(62 - 27) <= (4 + 1))) and (v7:TimeToDie() > (1469 - (157 + 1307)))) then
		if v14(v24.SoulReaper) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\255\167\22\200\99\254\173\2\212\89\254\232\16\208\28\190", "\60\140\200\99\164");
		end
	end
	if (v51:IsReady() and v7:IsInMeleeRange(v56) and (v7:DebuffUp(v24.TrollbaneSlowDebuff))) then
		if v14(v51) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\144\251\17\40\166\184\231\20\35\172\131\241\22\102\177\147\180\80", "\194\231\148\100\70");
		end
	end
	if (v53:IsReady() and v26[1863 - (821 + 1038)] and ((v58 >= (2 - 1)) or v7:IsInRange(1 + 7)) and (v35.Commons.DnDMoving or not v6:IsMoving()) and v24.UnholyGround:IsAvailable() and v6:BuffDown(v24.DeathAndDecayBuff) and (v45 or v43 or v49)) then
		if v13.CastTarget(v24.DeathAndDecay, v13.TName().PLAYER) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\71\66\216\156\242\198\66\12\210\183\182\158", "\168\38\44\161\195\150");
		end
	end
	if (v24.DeathCoil:IsReady() and v7:IsSpellInRange(v24.DeathCoil) and ((not v40 and v41) or (v63 < (17 - 7)))) then
		if v14(v24.DeathCoil) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\132\249\131\98\56\215\181\25\137\240\194\101\36\168\238", "\118\224\156\226\22\80\136\214");
		end
	end
	if (v55:IsReady() and v7:IsInMeleeRange(v56) and (v54 < (2 + 2)) and (not v39 or v6:BuffUp(v24.FesteringScytheBuff))) then
		if v14(v55) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\68\235\74\148\71\252\80\142\69\209\74\148\80\231\82\133\2\253\77\192\19\190", "\224\34\142\57");
		end
	end
	if (v51:IsReady() and v7:IsInRange(WoundSpenderRange) and (v54 >= (2 - 1)) and v39) then
		if v14(v52) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\201\168\208\211\119\206\78\30\219\169\193\216\97\177\78\26\158\246\151", "\110\190\199\165\189\19\145\61");
		end
	end
	if (v24.DeathCoil:IsReady() and v7:IsSpellInRange(v24.DeathCoil) and not v40) then
		if v14(v24.DeathCoil) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\222\238\118\252\131\248\217\228\126\228\203\212\206\171\38\188", "\167\186\139\23\136\235");
		end
	end
	if (v51:IsReady() and v7:IsInRange(WoundSpenderRange) and (v54 >= (1027 - (834 + 192))) and not v39 and (v54 >= (1 + 3))) then
		if v14(v52) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\13\186\157\3\30\138\155\29\31\187\140\8\8\245\155\25\90\228\222", "\109\122\213\232");
		end
	end
end
local function v138()
	if (v35.Commons.Enabled.Items and WeaponSetting and v25.Fyralath:IsReady() and v7:DebuffUp(v24.MarkofFyralathDebuff) and ((v59 < (2 + 3)) or (v59 > (1 + 20)) or (v63 < (5 - 1))) and (v43 or v47 or (not v24.RaiseAbomination:IsAvailable() and not v24.ArmyoftheDead:IsAvailable()) or (v3.CombatTime() > (319 - (300 + 4))))) then
		v13.CastMacro(1 + 0, nil, nil, v25.Fyralath);
		return LUAOBFUSACTOR_DECRYPT_STR_0("\249\242\163\32\225\249\226\51\239\228\182", "\80\142\151\194");
	end
	if v35.Commons.Enabled.Trinkets then
		if (v25.TreacherousTransmitter:IsEquippedAndReady() and (((v66 == v25.TreacherousTransmitter:ID()) and v26[18 - 11]) or ((v67 == v25.TreacherousTransmitter:ID()) and v26[370 - (112 + 250)])) and v7:IsInMeleeRange(2 + 3) and (v37 or v36) and (v24.DarkTransformation:CooldownRemains() < (7 - 4))) then
			if v14(v25.TreacherousTransmitter, nil) then
				return LUAOBFUSACTOR_DECRYPT_STR_0("\23\212\114\77\0\206\114\94\12\211\100\115\23\212\118\66\16\203\126\88\23\195\101\12\16\199\121\115\23\212\126\66\8\195\99\95\67\148", "\44\99\166\23");
			end
		end
		if (v29:IsReady() and v26[5 + 2] and ((v78 and ((not v24.SummonGargoyle:IsAvailable() and (((not v24.ArmyoftheDead:IsAvailable() or (v24.ArmyoftheDead:IsAvailable() and (v24.ArmyoftheDead:CooldownRemains() > (v74 * (0.51 + 0)))) or v35.Commons.DisableAotD or (v24.RaiseAbomination:IsAvailable() and (v24.RaiseAbomination:CooldownRemains() > (v74 * (0.51 + 0))))) and ((((10 + 10) > v80) and v45 and (v46 <= (v80 * (1.2 + 0)))) or (((1434 - (1001 + 413)) <= v80) and (v24.Apocalypse:CooldownRemains() < v6:GCD()) and v10:BuffUp(v24.DarkTransformation)) or ((not v24.Apocalypse:IsAvailable() or (v59 >= (4 - 2))) and v10:BuffUp(v24.DarkTransformation)))) or (v47 and (v48 < (v80 * (883.2 - (244 + 638))))) or (v43 and (v44 < (v80 * (694.2 - (627 + 66))))))) or (v24.SummonGargoyle:IsAvailable() and v49 and (v50 < (v80 * (2.2 - 1)))) or (v24.SummonGargoyle:CooldownRemains() > (682 - (512 + 90)))) and ((v84 == (1907 - (1665 + 241))) or Trinekt2:CooldownDown() or not v30:HasCooldown())) or (v80 >= v63))) then
			if v14(v29, true) then
				return LUAOBFUSACTOR_DECRYPT_STR_0("\91\242\39\51\33\173\127\183\60\37\54\155\117\227\44\59\115\162\115\229\105", "\196\28\151\73\86\83") .. v29:Name() .. LUAOBFUSACTOR_DECRYPT_STR_0("\179\23\59\25\140\83\29\98\224\67\125", "\22\147\99\73\112\226\56\120");
			end
		end
		if (v30:IsReady() and v26[725 - (373 + 344)] and ((v79 and ((not v24.SummonGargoyle:IsAvailable() and (((not v24.ArmyoftheDead:IsAvailable() or (v24.ArmyoftheDead:IsAvailable() and (v24.ArmyoftheDead:CooldownRemains() > (v75 * (0.51 + 0)))) or v35.Commons.DisableAotD or (v24.RaiseAbomination:IsAvailable() and (v24.RaiseAbomination:CooldownRemains() > (v75 * (0.51 + 0))))) and ((((52 - 32) > v81) and v45 and (v46 <= (v81 * (1.2 - 0)))) or (((1119 - (35 + 1064)) <= v81) and (v24.Apocalypse:CooldownRemains() < v6:GCD()) and v10:BuffUp(v24.DarkTransformation)) or ((not v24.Apocalypse:IsAvailable() or (v59 >= (2 + 0))) and v10:BuffUp(v24.DarkTransformation)))) or (v47 and (v48 < (v81 * (2.2 - 1)))) or (v43 and (v44 < (v81 * (1.2 + 0)))))) or (v24.SummonGargoyle:IsAvailable() and v49 and (v50 < (v81 * (1237.2 - (298 + 938))))) or (v24.SummonGargoyle:CooldownRemains() > (1339 - (233 + 1026)))) and ((v84 == (1668 - (636 + 1030))) or v29:CooldownDown() or not v29:HasCooldown())) or (v81 >= v63))) then
			if v14(v30, true) then
				return LUAOBFUSACTOR_DECRYPT_STR_0("\159\112\236\240\159\177\118\162\224\158\189\74\235\225\136\181\53\228\250\159\248", "\237\216\21\130\149") .. v30:Name() .. LUAOBFUSACTOR_DECRYPT_STR_0("\194\90\77\86\190\194\91\150\93\31\9", "\62\226\46\63\63\208\169");
			end
		end
		if (v29:IsReady() and v26[4 + 3] and ((not v78 and ((v85 == (1 + 0)) or v30:CooldownDown() or not v30:HasCooldown() or (not v24.SummonGargoyle:IsAvailable() and not v24.ArmyoftheDead:IsAvailable() and not v24.RaiseAbomination:IsAvailable()) or (not v24.SummonGargoyle:IsAvailable() and v24.ArmyoftheDead:IsAvailable() and ((not v24.RaiseAbomination:IsAvailable() and (v24.ArmyoftheDead:CooldownRemains() > (6 + 14))) or (v24.RaiseAbomination:IsAvailable() and (v24.RaiseAbomination:CooldownRemains() > (2 + 18))))) or (not v24.SummonGargoyle:IsAvailable() and not v24.ArmyoftheDead:IsAvailable() and not v24.RaiseAbomination:IsAvailable() and (v24.DarkTransformation:CooldownRemains() > (241 - (55 + 166)))) or (v24.SummonGargoyle:IsAvailable() and (v24.SummonGargoyle:CooldownRemains() > (4 + 16)) and not v49))) or (v63 < (2 + 13)))) then
			if v14(v29, true) then
				return LUAOBFUSACTOR_DECRYPT_STR_0("\194\28\91\134\13\4\44\30\240\10\80\188\22\25\42\83\165\31\90\145\95", "\62\133\121\53\227\127\109\79") .. v29:Name() .. LUAOBFUSACTOR_DECRYPT_STR_0("\80\0\32\252\216\165\167\4\7\114\173", "\194\112\116\82\149\182\206");
			end
		end
		if (v30:IsReady() and v26[30 - 22] and ((not v79 and ((v85 == (299 - (36 + 261))) or v29:CooldownDown() or not v29:HasCooldown() or (not v24.SummonGargoyle:IsAvailable() and not v24.ArmyoftheDead:IsAvailable() and not v24.RaiseAbomination:IsAvailable()) or (not v24.SummonGargoyle:IsAvailable() and v24.ArmyoftheDead:IsAvailable() and ((not v24.RaiseAbomination:IsAvailable() and (v24.ArmyoftheDead:CooldownRemains() > (34 - 14))) or (v24.RaiseAbomination:IsAvailable() and (v24.RaiseAbomination:CooldownRemains() > (1388 - (34 + 1334)))))) or (not v24.SummonGargoyle:IsAvailable() and not v24.ArmyoftheDead:IsAvailable() and not v24.RaiseAbomination:IsAvailable() and (v24.DarkTransformation:CooldownRemains() > (8 + 12))) or (v24.SummonGargoyle:IsAvailable() and (v24.SummonGargoyle:CooldownRemains() > (16 + 4)) and not v49))) or (v63 < (1298 - (1035 + 248))))) then
			if v14(v30, true) then
				return LUAOBFUSACTOR_DECRYPT_STR_0("\30\173\66\29\210\235\13\121\189\95\29\255\235\26\60\165\12\30\207\240\78", "\110\89\200\44\120\160\130") .. v30:Name() .. LUAOBFUSACTOR_DECRYPT_STR_0("\235\215\89\79\77\65\62\89\184\131\26\22", "\45\203\163\43\38\35\42\91");
			end
		end
	end
end
local function v139()
	v36 = (v59 == (22 - (20 + 1))) or not v16();
	v37 = (v59 >= (2 + 0)) and (v64 > (325 - (134 + 185)));
	v38 = ((v24.Apocalypse:CooldownRemains() < (1138 - (549 + 584))) and (v54 < (686 - (314 + 371))) and (v24.UnholyAssault:CooldownRemains() > (17 - 12)) and (971 - (478 + 490))) or (0 + 0);
	v39 = (((v24.Apocalypse:CooldownRemains() > v38) or not v24.Apocalypse:IsAvailable()) and (((v54 >= (1173 - (786 + 386))) and (v24.UnholyAssault:CooldownRemains() < (64 - 44)) and v24.UnholyAssault:IsAvailable() and v36) or (v7:DebuffUp(v24.RottenTouchDebuff) and (v54 >= (1380 - (1055 + 324)))) or (v54 >= ((1344 - (1093 + 247)) - v17(v43))))) or ((v63 < (5 + 0)) and (v54 >= (1 + 0)));
	v40 = v24.VileContagion:IsAvailable() and (v24.VileContagion:CooldownRemains() < (19 - 14)) and (v6:RunicPower() < (101 - 71));
	v41 = (not v24.RottenTouch:IsAvailable() or (v24.RottenTouch:IsAvailable() and v7:DebuffDown(v24.RottenTouchDebuff)) or (v6:RunicPowerDeficit() < (56 - 36))) and ((v24.ImprovedDeathCoil:IsAvailable() and ((v59 == (4 - 2)) or v24.CoilofDevastation:IsAvailable())) or (v6:Rune() < (2 + 1)) or v49 or v6:BuffUp(v24.SuddenDoomBuff) or (not v39 and (v54 >= (15 - 11))));
	v42 = (10 - 7) + v17(v24.ImprovedDeathCoil:IsAvailable()) + v17(v24.FrenziedBloodthirst:IsAvailable() and (v6:BuffStack(v24.EssenceoftheBloodQueenBuff) > (4 + 1))) + v17(v24.HungeringThirst:IsAvailable() and v24.HarbingerofDoom:IsAvailable() and v6:BuffUp(v24.SuddenDoomBuff));
end
local function v140()
	v26[2 - 1] = v13.ToggleIconFrame:GetToggle(689 - (364 + 324));
	v26[5 - 3] = v13.ToggleIconFrame:GetToggle(4 - 2);
	v26[1 + 2] = v13.ToggleIconFrame:GetToggle(12 - 9);
	v26[5 - 1] = v13.ToggleIconFrame:GetToggle(11 - 7) and (v35.Commons.DnDMoving or not v6:IsMoving()) and v88(1276 - (1249 + 19));
end
local function v141()
	v57 = v6:GetEnemiesInMeleeRange(8 + 0);
	v60 = v7:GetEnemiesInSplashRange(38 - 28);
	if v16() then
		v58 = #v57;
		v61 = v7:GetEnemiesInSplashRangeCount(1096 - (686 + 400));
	else
		v58 = 1 + 0;
		v61 = 230 - (73 + 156);
	end
	v59 = v20(v58, v61);
end
local function v142()
	v62 = v97(v60);
end
local function v143()
	v43 = v65:AbomActive();
	v44 = v65:AbomRemains();
	v45 = v24.Apocalypse:TimeSinceLastCast() <= (1 + 14);
	v46 = (v45 and ((826 - (721 + 90)) - v24.Apocalypse:TimeSinceLastCast())) or (0 + 0);
	v47 = v24.ArmyoftheDead:TimeSinceLastCast() <= (97 - 67);
	v48 = (v47 and ((500 - (224 + 246)) - v24.ArmyoftheDead:TimeSinceLastCast())) or (0 - 0);
	v49 = v65:GargActive();
	v50 = v65:GargRemains();
	v54 = v7:DebuffStack(v24.FesteringWoundDebuff);
	if v24.FesteringScytheAction:IsLearned() then
		v55 = v24.FesteringScytheAction;
		v56 = 25 - 11;
	else
		v55 = v24.FesteringStrike;
		v56 = 1 + 4;
	end
end
local function v144()
	v34.HealthPotions();
	if v6:IsChanneling(v25.ManicGrieftorch.ItemUseSpell) then
		return LUAOBFUSACTOR_DECRYPT_STR_0("\246\138\210\55\199\170\65\198\197\232\44\149\170\92", "\52\178\229\188\67\231\201");
	end
	v140();
	v141();
	v142();
	v59 = v20(v58, v61);
	v143();
	v51 = (v24.VampiricStrikeAction:IsLearned() and v24.VampiricStrikeAction) or ((v24.ClawingShadows:IsAvailable()) and v24.ClawingShadows) or v24.ScourgeStrike;
	v26[1 + 4] = v86(v35.Unholy.DarkTransformationSetting) and v88(v35.TTD.DarkTransformationTTD) and v7:IsInMeleeRange(4 + 1);
	v26[11 - 5] = v86(v35.Unholy.RacialsSetting) and v88(v35.TTD.RacialsTTD) and v7:IsInMeleeRange(16 - 11);
	v26[520 - (203 + 310)] = v86(v35.Unholy.Trinket1Setting) and v88(v35.TTD.TrinketsTTD);
	v26[2001 - (1238 + 755)] = v86(v35.Unholy.Trinket2Setting) and v88(v35.TTD.TrinketsTTD);
	v26[1 + 8] = v86(v35.Unholy.PotionSetting) and not v34.ISSolo();
	v26[1544 - (709 + 825)] = v86(v35.Unholy.ApocalypseSetting) and v88(v35.TTD.ApocalypseTTD) and v7:IsInMeleeRange(8 - 3);
	v26[15 - 4] = v86(v35.Unholy.UnholyAssaultSetting) and v88(v35.TTD.UnholyAssaultTTD) and v7:IsInMeleeRange(869 - (196 + 668));
	v26[47 - 35] = v86(v35.Unholy.AbominationLimbSetting) and not IsNpcNearPlayer() and v88(v35.TTD.AbominationLimbTTD) and v7:IsInMeleeRange(31 - 16);
	v26[846 - (171 + 662)] = v86(v35.Unholy.EmpowerRuneWeaponSetting) and v88(v35.TTD.EmpowerRuneWeaponTTD) and v7:IsInMeleeRange(98 - (4 + 89));
	v26[48 - 34] = v86(v35.Unholy.UnholyBlightSetting) and v88(v35.TTD.UnholyBlightTTD);
	v26[6 + 9] = v86(v35.Unholy.SummonGargoyleSetting) and v88(v35.TTD.SummonGargoyleTTD);
	v26[70 - 54] = v86(v35.Unholy.RaiseAbominationSetting) and v88(v35.TTD.SummonGargoyleTTD);
	v26[7 + 10] = v86(v35.Unholy.ArmyOfTheDeadSetting) and v88(1526 - (35 + 1451));
	v26[1471 - (28 + 1425)] = v86(v35.Unholy.Weapon);
	if (v34.TargetIsValid() or v6:AffectingCombat()) then
		v63 = v3.BossFightRemains();
		IsBossfight = true;
		v64 = v63;
		if (v64 == (13104 - (941 + 1052))) then
			IsBossfight = false;
			v64 = v3.FightRemains(v57, false);
		end
		v51 = ((v24.VampiricStrikeAction:IsLearned()) and v24.VampiricStrikeAction) or ((v24.ClawingShadows:IsAvailable()) and v24.ClawingShadows) or v24.ScourgeStrike;
		v53 = ((v24.Defile:IsAvailable()) and v24.Defile) or v24.DeathAndDecay;
		WoundSpenderRange = ((v24.ClawingShadows:IsAvailable() or v24.VampiricStrikeAction:IsAvailable()) and (29 + 1)) or (1519 - (822 + 692));
	end
	if v24.RaiseDead:IsCastable() then
		if v14(v24.RaiseDead) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\51\64\89\23\242\99\39\36\64\84\68\231\78\38\34\78\93\6\246\72\99\115", "\67\65\33\48\100\151\60");
		end
	end
	if (v24.RaiseAlly:IsReady() and v35.Commons.RaiseAlly) then
		if (v8:UnitIsFriend() and v8:UnitIsPlayer() and v8:Exists() and v8:IsDeadOrGhost()) then
			v13.CastTarget(v24.RaiseAlly, v13.TName().MOUSEOVER);
			return LUAOBFUSACTOR_DECRYPT_STR_0("\237\230\167\203\246\159\198\162\212\234\159\232\160\152\222\208\242\189\221\252\201\226\188", "\147\191\135\206\184");
		end
		if (v7:UnitIsFriend() and v7:UnitIsPlayer() and v7:Exists() and v7:IsDeadOrGhost()) then
			v13.Cast(v24.RaiseAlly);
			return LUAOBFUSACTOR_DECRYPT_STR_0("\182\41\175\210\221\19\147\136\36\191\129\215\93\242\176\41\180\198\221\71", "\210\228\72\198\161\184\51");
		end
	end
	if (v34.TargetIsValid() and (v7:AffectingCombat() or v35.Unholy.AttackOutOfCombat)) then
		if not v6:AffectingCombat() then
			local v229 = v123();
			if v229 then
				return v229;
			end
		end
		if (v24.DeathStrike:IsReady() and v96()) then
			if v14(v24.DeathStrike) then
				return LUAOBFUSACTOR_DECRYPT_STR_0("\50\76\242\4\123\241\37\93\225\25\120\203\118\69\252\7\51\198\38\9\252\2\51\222\36\70\240", "\174\86\41\147\112\19");
			end
		end
		if v6:AffectingCombat() then
			if (v24.IceboundFortitude:IsCastable() and (v6:HealthPercentage() <= v35.Unholy.Defensives.IceboundFortitudeHP)) then
				if v14(v24.IceboundFortitude, false) then
					return LUAOBFUSACTOR_DECRYPT_STR_0("\82\3\136\9\42\26\31\175\100\6\130\25\49\6\5\190\95\5\205\15\32\9\20\165\72\9\155\14\54", "\203\59\96\237\107\69\111\113");
				end
			end
			if (v24.AntiMagicShell:IsCastable() and (v6:HealthPercentage() <= v35.Unholy.Defensives.AntiMagicShellHP)) then
				if v14(v24.AntiMagicShell, false) then
					return LUAOBFUSACTOR_DECRYPT_STR_0("\5\24\184\232\28\241\208\45\21\159\233\52\252\219\100\18\169\231\52\254\196\45\0\169\242", "\183\68\118\204\129\81\144");
				end
			end
			if (v24.AntiMagicZone:IsCastable() and (v6:HealthPercentage() <= v35.Unholy.Defensives.AntiMagicZoneHP)) then
				if v14(v24.AntiMagicZone, false) then
					return LUAOBFUSACTOR_DECRYPT_STR_0("\47\163\100\237\38\131\9\164\115\222\4\140\11\237\116\225\13\135\0\190\121\242\14\145", "\226\110\205\16\132\107");
				end
			end
			if (v24.Lichborne:IsCastable() and (v6:HealthPercentage() <= v35.Unholy.Defensives.LichborneHP)) then
				if v14(v24.Lichborne, false) then
					return LUAOBFUSACTOR_DECRYPT_STR_0("\199\202\227\209\67\228\209\238\220\1\239\198\230\220\79\248\202\246\220\82", "\33\139\163\128\185");
				end
			end
		end
		if v26[3 - 0] then
			v31 = v34.InterruptCycle(v24.MindFreeze, 8 + 7, true, nil, false);
			if v31 then
				return v31;
			end
			if v35.Commons.BlindingSleet then
				v31 = v34.InterruptCycle(v24.BlindingSleet, 309 - (45 + 252), true, nil, true, true);
				if v31 then
					return v31;
				end
			end
			v31 = v34.InterruptCycle(v24.Asphyxiate, 20 + 0, true, nil, true);
			if v31 then
				return v31;
			end
		end
		if not v7:IsInRange(4 + 6) then
			if (v24.Outbreak:IsReady() and v7:IsSpellInRange(v24.Outbreak) and v121(v7)) then
				if v14(v24.Outbreak) then
					return LUAOBFUSACTOR_DECRYPT_STR_0("\88\77\16\220\69\93\5\213\23\87\17\202\104\87\2\225\69\89\10\217\82", "\190\55\56\100");
				end
			end
			if (v24.Epidemic:IsReady() and v7:IsInRange(97 - 57) and v16() and (v24.VirulentPlagueDebuff:AuraActiveCount() > (434 - (114 + 319))) and not v40) then
				if v14(v24.Epidemic, false, nil, not v7:IsInRange(57 - 17)) then
					return LUAOBFUSACTOR_DECRYPT_STR_0("\83\191\53\26\22\238\250\85\239\51\11\7\220\252\80\144\46\31\29\228\246", "\147\54\207\92\126\115\131");
				end
			end
			if (v24.DeathCoil:IsReady() and v7:IsSpellInRange(v24.DeathCoil) and (v24.VirulentPlagueDebuff:AuraActiveCount() < (2 - 0)) and not v40) then
				if v14(v24.DeathCoil) then
					return LUAOBFUSACTOR_DECRYPT_STR_0("\9\52\52\105\5\65\14\62\60\113\77\113\24\37\10\114\11\65\31\48\59\122\8", "\30\109\81\85\29\109");
				end
			end
		end
		v139();
		if v24.VampiricStrike:IsAvailable() then
			local v230 = v136();
			if v230 then
				return v230;
			end
		end
		if ((v35.Commons.Enabled.Trinkets or v35.Commons.Enabled.Items) and not v24.VampiricStrike:IsAvailable()) then
			local v231 = v138();
			if v231 then
				return v231;
			end
		end
		if true then
			local v232 = v133();
			if v232 then
				return v232;
			end
		end
		if true then
			local v233 = v131();
			if v233 then
				return v233;
			end
		end
		if (v16() and v24.VampiricStrike:IsAvailable() and (v59 >= (2 + 0))) then
			local v234 = v129();
			if v234 then
				return v234;
			end
		end
		if (v16() and not v24.VampiricStrike:IsAvailable() and (v59 >= (2 - 0))) then
			local v235 = v128();
			if v235 then
				return v235;
			end
		end
		if (v24.VampiricStrike:IsAvailable() and ((v59 <= (1 - 0)) or not v16())) then
			local v236 = v130();
			if v236 then
				return v236;
			end
		end
		if (not v24.VampiricStrike:IsAvailable() and ((v59 <= (1964 - (556 + 1407))) or not v16())) then
			local v237 = v127();
			if v237 then
				return v237;
			end
		end
		if (v16() and (v59 == (1208 - (741 + 465)))) then
			local v238 = v132();
			if v238 then
				return v238;
			end
		end
		if (v16() and (v59 >= (468 - (170 + 295))) and not v6:DnDTicking() and (v53:CooldownRemains() < (6 + 4))) then
			local v239 = v126();
			if v239 then
				return v239;
			end
		end
		if (v16() and (v59 >= (3 + 0)) and v6:BuffUp(v24.DeathAndDecayBuff)) then
			local v240 = v125();
			if v240 then
				return v240;
			end
		end
		if (v16() and (v59 >= (7 - 4)) and v6:BuffDown(v24.DeathAndDecayBuff)) then
			local v241 = v124();
			if v241 then
				return v241;
			end
		end
		if (((v59 <= (1 + 0)) or not v16()) and v24.GiftoftheSanlayn:IsAvailable() and v24.DarkTransformation:CooldownDown() and v6:BuffDown(v24.GiftoftheSanlaynBuff) and (v6:BuffRemains(v24.EssenceoftheBloodQueenBuff) < (v24.DarkTransformation:CooldownRemains() + 2 + 0))) then
			local v242 = v134();
			if v242 then
				return v242;
			end
			if v13.CastAnnotated(v24.Pool, false, LUAOBFUSACTOR_DECRYPT_STR_0("\200\80\125\130", "\156\159\17\52\214\86\190")) then
				return LUAOBFUSACTOR_DECRYPT_STR_0("\158\224\178\176\238\233\178\174\238\220\188\178\136\230\174\180\167\225\186\244\231", "\220\206\143\221");
			end
		end
		if (((v59 <= (1 + 0)) or not v16()) and v24.VampiricStrike:IsAvailable()) then
			local v243 = v135();
			if v243 then
				return v243;
			end
		end
		if (((v59 <= (1231 - (957 + 273))) or not v16()) and not v24.VampiricStrike:IsAvailable()) then
			local v244 = v137();
			if v244 then
				return v244;
			end
		end
		if (v55:IsReady() and v7:IsInMeleeRange(v56) and (v6:Rune() >= (2 + 4))) then
			if v14(v55) then
				return LUAOBFUSACTOR_DECRYPT_STR_0("\128\120\62\3\221\222\219\136\122\18\4\204\222\219\141\120\109\22\214\216\219\198\126\44\7", "\178\230\29\77\119\184\172");
			end
		end
		if (v51:IsReady() and v7:IsInRange(WoundSpenderRange) and not v7:IsInMeleeRange(4 + 4) and (v54 >= (3 - 2))) then
			if v14(v52) then
				return LUAOBFUSACTOR_DECRYPT_STR_0("\194\177\31\21\115\184\198\174\15\21\115\253\231\254\37\52\69", "\152\149\222\106\123\23");
			end
		end
		if v13.CastAnnotated(v24.Pool, false, LUAOBFUSACTOR_DECRYPT_STR_0("\234\7\223\119", "\213\189\70\150\35")) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\95\90\123\4\112\71\113\27\64\64\102\11\74\70", "\104\47\53\20");
		end
		v31 = (v58 > (0 - 0)) and not v7:IsInRange(24 - 16) and v95();
	end
end
local function v145()
	v24.VirulentPlagueDebuff:RegisterAuraTracking();
	v24.FesteringWoundDebuff:RegisterAuraTracking();
	v24.MarkofFyralathDebuff:RegisterAuraTracking();
	v35.Unholy.Display();
	v13:UpdateMacro(LUAOBFUSACTOR_DECRYPT_STR_0("\174\77\130\14\179\94", "\111\195\44\225\124\220"), LUAOBFUSACTOR_DECRYPT_STR_0("\151\83\19\118\235\250\142", "\203\184\38\96\19\203"));
	v13:UpdateMacro(LUAOBFUSACTOR_DECRYPT_STR_0("\52\114\122\83\193\107", "\174\89\19\25\33"), LUAOBFUSACTOR_DECRYPT_STR_0("\96\6\83\92\240\130\31\111\41\114\67\248\146\24\42\29\68\75\229\186", "\107\79\114\50\46\151\231"));
	v34.PostInitialMessage(1247 - 995);
end
v13.SetAPL(2032 - (389 + 1391), v144, v145);
