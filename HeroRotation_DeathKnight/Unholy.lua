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
local v10 = v5.Boss.boss1;
local v11 = v5.Boss.boss2;
local v12 = v5.Boss.boss3;
local v13 = v5.Pet;
local v14 = v3.Spell;
local v15 = v3.Item;
local v16 = HeroRotation();
local v17 = v16.Cast;
local v18 = v16.CDsON;
local v19 = v16.AoEON;
local v20 = v16.Commons().Everyone.num;
local v21 = v16.Commons().Everyone.bool;
local v22 = C_Timer.After;
local v23 = math.max;
local v24 = table.insert;
local v25 = GetTime;
local v26 = v16.Commons().DeathKnight;
local v27 = v14.DeathKnight.Unholy;
local v28 = v15.DeathKnight.Unholy;
local v29 = {v28.AlgetharPuzzleBox:ID(),v28.Fyralath:ID(),v28.IrideusFragment:ID(),v28.VialofAnimatedBlood:ID(),v28.ManicGrieftorch:ID(),v28.TreacherousTransmitter:ID()};
local v30 = v6:GetEquipment();
local v31 = (v30[10 + 3] and v15(v30[3 + 10])) or v15(0 + 0);
local v32 = (v30[38 - 24] and v15(v30[46 - 32])) or v15(0 + 0);
local v33;
local v34;
local v35 = v16.GUISettingsGet();
local v36 = v16.Commons().Everyone;
local v37 = {[LUAOBFUSACTOR_DECRYPT_STR_0("\246\198\213\32\244\186\203", "\126\177\163\187\69\134\219\167")]=v35.General,[LUAOBFUSACTOR_DECRYPT_STR_0("\0\194\39\200\243\45\222", "\156\67\173\74\165")]=v35.APL.DeathKnight.Commons,[LUAOBFUSACTOR_DECRYPT_STR_0("\16\178\79\19\178\53\79\34\178\90", "\38\84\215\41\118\220\70")]=v35.APL.DeathKnight.Unholy.Defensives,[LUAOBFUSACTOR_DECRYPT_STR_0("\101\24\42\29\242\73", "\158\48\118\66\114")]=v35.APL.DeathKnight.Unholy,[LUAOBFUSACTOR_DECRYPT_STR_0("\159\16\52", "\155\203\68\112\86\19\197")]=v35.APL.DeathKnight.Unholy_TTD};
local v38 = {[LUAOBFUSACTOR_DECRYPT_STR_0("\117\233\6\240\65\118\235\241\72\218", "\152\38\189\86\156\32\24\133")]=nil,[LUAOBFUSACTOR_DECRYPT_STR_0("\221\83\163\85\206\82\170\71\245\89", "\38\156\55\199")]=nil,[LUAOBFUSACTOR_DECRYPT_STR_0("\137\109\115\43\39\125\247\74\166\122", "\35\200\29\28\72\115\20\154")]=nil,[LUAOBFUSACTOR_DECRYPT_STR_0("\41\176\193\232\130\57\58\29\172", "\84\121\223\177\191\237\76")]=nil,[LUAOBFUSACTOR_DECRYPT_STR_0("\139\89\198\172\51\94\55\243\174\88\192\163\10\95\39\196\169", "\161\219\54\169\192\90\48\80")]=nil,[LUAOBFUSACTOR_DECRYPT_STR_0("\122\82\5\43\77\112\48", "\69\41\34\96")]=nil,[LUAOBFUSACTOR_DECRYPT_STR_0("\143\194\217\41\13\34\176\238\194\6\22", "\75\220\163\183\106\98")]=nil,[LUAOBFUSACTOR_DECRYPT_STR_0("\54\168\130\57\210\7\174\218\30\253", "\185\98\218\235\87")]=nil,[LUAOBFUSACTOR_DECRYPT_STR_0("\255\46\46\232\213\175\223\110\14\194", "\202\171\92\71\134\190")]=nil,[LUAOBFUSACTOR_DECRYPT_STR_0("\29\211\37\134\34\196\56\217\10\192\63\156\29\200\33\141", "\232\73\161\76")]=nil,[LUAOBFUSACTOR_DECRYPT_STR_0("\143\203\75\83\21\190\205\16\126\31\168\205\118\84\19\190", "\126\219\185\34\61")]=nil,[LUAOBFUSACTOR_DECRYPT_STR_0("\56\220\87\124\117\114\231\182\47\234", "\135\108\174\62\18\30\23\147")]=nil,[LUAOBFUSACTOR_DECRYPT_STR_0("\130\251\35\197\19\171\39\149\149\205", "\167\214\137\74\171\120\206\83")]=nil,[LUAOBFUSACTOR_DECRYPT_STR_0("\191\226\59\83\243\162\159\161\23\69", "\199\235\144\82\61\152")]=nil,[LUAOBFUSACTOR_DECRYPT_STR_0("\51\4\176\37\12\19\173\121\34\14", "\75\103\118\217")]=nil,[LUAOBFUSACTOR_DECRYPT_STR_0("\243\70\121\26\178\27\211\5\82\1\191\24\212", "\126\167\52\16\116\217")]=nil,[LUAOBFUSACTOR_DECRYPT_STR_0("\252\60\41\142\191\28\232\154\12\53\134\178\10", "\156\168\78\64\224\212\121")]=nil,[LUAOBFUSACTOR_DECRYPT_STR_0("\51\252\172\192\12\235\177\159\35\251\183\207\19\231\170\192", "\174\103\142\197")]=nil,[LUAOBFUSACTOR_DECRYPT_STR_0("\98\58\86\54\46\91\236\4\12\74\42\36\74\241\89\38", "\152\54\72\63\88\69\62")]=nil,[LUAOBFUSACTOR_DECRYPT_STR_0("\224\214\231\82\223\193\250\13\231\221\224\95", "\60\180\164\142")]=nil,[LUAOBFUSACTOR_DECRYPT_STR_0("\108\76\12\39\44\232\6\10\109\28\39\36", "\114\56\62\101\73\71\141")]=nil,[LUAOBFUSACTOR_DECRYPT_STR_0("\140\251\210\202\179\236\207\244\170\224\212\214\177\253\194", "\164\216\137\187")]=nil,[LUAOBFUSACTOR_DECRYPT_STR_0("\246\231\60\179\161\251\63\192\239\63\185\163\234\59\192\239\62\160\175\234\18", "\107\178\134\81\210\198\158")]=nil,[LUAOBFUSACTOR_DECRYPT_STR_0("\29\30\139\194\175\53\7\129\242\171\42\9\135\210\185", "\202\88\110\226\166")]=nil,[LUAOBFUSACTOR_DECRYPT_STR_0("\226\13\141\250\235\192\27\139\225\207", "\170\163\111\226\151")]=nil,[LUAOBFUSACTOR_DECRYPT_STR_0("\48\50\189\53\124\50\36\16\57\188\43", "\73\113\80\210\88\46\87")]=nil,[LUAOBFUSACTOR_DECRYPT_STR_0("\160\60\194\17\192\137\35\216\30\198\130\56\196\4\226", "\135\225\76\173\114")]=nil,[LUAOBFUSACTOR_DECRYPT_STR_0("\59\253\183\179\139\181\168\15\225\138\181\161\188\174\20\254", "\199\122\141\216\208\204\221")]=nil,[LUAOBFUSACTOR_DECRYPT_STR_0("\140\207\29\233\95\254\162\200\28\209\123\226\164\203\21", "\150\205\189\112\144\24")]=nil,[LUAOBFUSACTOR_DECRYPT_STR_0("\4\150\178\85\35\128\30\5\41\182\186\65\5\129\31\3", "\112\69\228\223\44\100\232\113")]=nil,[LUAOBFUSACTOR_DECRYPT_STR_0("\243\30\21\212\151\127\146\221\9\2", "\230\180\127\103\179\214\28")]=nil,[LUAOBFUSACTOR_DECRYPT_STR_0("\171\4\77\65\214\68\237\141\12\81\85", "\128\236\101\63\38\132\33")]=nil};
local v39 = ((v27.VampiricStrikeAction:IsLearned()) and v27.VampiricStrikeAction) or ((v27.ClawingShadows:IsAvailable()) and v27.ClawingShadows) or v27.ScourgeStrike;
local v40 = ((v27.ClawingShadows:IsAvailable()) and v27.ClawingShadows) or v27.ScourgeStrike;
local v41 = ((v27.Defile:IsAvailable()) and v27.Defile) or v27.DeathAndDecay;
local v42 = nil;
local v43 = nil;
local v44 = nil;
local v45 = (v27.EbonFever:IsAvailable() and (2 + 2)) or (7.1 + 1);
local v46 = (v27.EbonFever:IsAvailable() and (3.6 + 0)) or (4.2 + 3);
local v47 = (v27.EbonFever:IsAvailable() and (1436.6 - (797 + 636))) or (33.2 - 26);
local v31, v32;
local v48, v49, v50;
local v51, v52;
local v53 = 12730 - (1427 + 192);
local v54 = 3850 + 7261;
local v55 = v16.Commons().DeathKnight.GhoulTable;
local function v56(v117)
	return (v117 ~= LUAOBFUSACTOR_DECRYPT_STR_0("\130\166\5\4\131\248\202\168", "\175\204\201\113\36\214\139")) and (((v117 == LUAOBFUSACTOR_DECRYPT_STR_0("\112\197\33\212\68\100\195\58\208\0\72\219\59\207", "\100\39\172\85\188")) and v16.CDsON()) or ((v117 == LUAOBFUSACTOR_DECRYPT_STR_0("\154\113\173\136\115\158\117\184\140\63\237\119\171\192\16\162\119\181\132\60\186\118\170", "\83\205\24\217\224")) and (SmallCDToggle or v16.CDsON())) or ((v117 == LUAOBFUSACTOR_DECRYPT_STR_0("\209\204\217\53\166\246\192\60\234\201\141\30\194\214", "\93\134\165\173")) and SmallCDToggle) or ((v117 == LUAOBFUSACTOR_DECRYPT_STR_0("\145\252\129\239\53\204\177\113\171\252\213", "\30\222\146\161\162\90\174\210")) and (v50 >= v37.Unholy.Mobcount)) or ((v117 == LUAOBFUSACTOR_DECRYPT_STR_0("\202\64\48\39\234\76\115\5\240\64\100\74\234\92\48\41\234\65\124\14\234\89\126\25", "\106\133\46\16")) and ((v50 >= v37.Unholy.Mobcount) or v18())) or (v117 == LUAOBFUSACTOR_DECRYPT_STR_0("\121\44\100\253\67\83", "\32\56\64\19\156\58")) or ((v117 == LUAOBFUSACTOR_DECRYPT_STR_0("\117\198\165\116\85\225\147\95\219", "\224\58\168\133\54\58\146")) and IsBossfight) or ((v117 == LUAOBFUSACTOR_DECRYPT_STR_0("\116\89\73\254\122\147\137\31\25\89\89\189\87\137\148\24", "\107\57\54\43\157\21\230\231")) and (IsBossfight or (v50 >= v37.Unholy.Mobcount))));
end
local function v57(v118, v119, v120)
	if (IsBossfight or v36.ISSolo() or (v120 == (0 - 0)) or ((v54 >= v120) and (v54 < (6991 + 786)))) then
		v16.Cast(v118, v119);
		return LUAOBFUSACTOR_DECRYPT_STR_0("\239\191\53\181\186\221\220\207\203", "\175\187\235\113\149\217\188") .. v118:Name();
	end
end
local function v58(v121)
	if (v121 == nil) then
		return true;
	end
	return IsBossfight or v36.ISSolo() or (v121 == (0 + 0)) or v36.Buggedmobs[v7:NPCID()] or ((v54 >= v121) and (v54 < (8103 - (192 + 134))));
end
local v59 = {{v27.Asphyxiate,LUAOBFUSACTOR_DECRYPT_STR_0("\31\174\146\88\163\88\107\44\167\152\84\234\120\108\57\239\201\101\237\109\125\46\189\148\92\247\48", "\24\92\207\225\44\131\25"),function()
	return true;
end}};
local function v60()
	return v28.ManicGrieftorch:IsEquipped() and (v28.ManicGrieftorch:CooldownUp() or (v28.ManicGrieftorch:CooldownRemains() <= v6:GCDRemains()));
end
local function v61()
	return v28.AlgetharPuzzleBox:IsEquipped() and (v28.AlgetharPuzzleBox:CooldownUp() or (v28.AlgetharPuzzleBox:CooldownRemains() <= v6:GCDRemains()));
end
local v62 = (0 - 0) - (551 - (83 + 468));
local function v63()
	local v122, v123 = v6:GetTrinketData(v29);
	if ((v62 < (1811 - (1202 + 604))) and ((v122.ID == (0 - 0)) or (v123.ID == (0 - 0)) or (v122.Level == (0 - 0)) or (v123.Level == (325 - (45 + 280))) or ((v122.SpellID > (0 + 0)) and not v122.Usable) or ((v123.SpellID > (0 + 0)) and not v123.Usable))) then
		v62 = v62 + 1 + 0;
		v22(3 + 2, function()
			v63();
		end);
		return;
	end
	v31 = v122.Object;
	v32 = v123.Object;
	v38.Trinket1ID = v122.ID;
	v38.Trinket2ID = v123.ID;
	VarTrinket1Level = v122.Level;
	VarTrinket2Level = v123.Level;
	VarTrinket1Spell = v122.Spell;
	VarTrinket1Range = v122.Range;
	v38.Trinket1CastTime = v122.CastTime;
	VarTrinket2Spell = v123.Spell;
	VarTrinket2Range = v123.Range;
	v38.Trinket2CastTime = v123.CastTime;
	v38.Trinket1CD = v122.Cooldown;
	v38.Trinket2CD = v123.Cooldown;
	v38.Trinket1Ex = v122.Excluded;
	v38.Trinket2Ex = v123.Excluded;
	v38.Trinket1Buffs = v31:HasUseBuff() or (v38.Trinket1ID == v28.TreacherousTransmitter:ID());
	v38.Trinket2Buffs = v32:HasUseBuff() or (v38.Trinket2ID == v28.TreacherousTransmitter:ID());
	v38.Trinket1Duration = 0 + 0;
	v38.Trinket2Duration = 0 - 0;
	if (v38.Trinket1ID == v28.TreacherousTransmitter:ID()) then
		v38.Trinket1Duration = 1926 - (340 + 1571);
	elseif (v38.Trinket1ID == v28.FunhouseLens:ID()) then
		v38.Trinket1Duration = 6 + 9;
	elseif (v38.Trinket1ID == v28.SignetofthePriory:ID()) then
		v38.Trinket1Duration = 1792 - (1733 + 39);
	else
		v38.Trinket1Duration = v31:BuffDuration();
	end
	if (v38.Trinket2ID == v28.TreacherousTransmitter:ID()) then
		v38.Trinket2Duration = 41 - 26;
	elseif (v38.Trinket2ID == v28.FunhouseLens:ID()) then
		v38.Trinket2Duration = 1049 - (125 + 909);
	elseif (v38.Trinket2ID == v28.SignetofthePriory:ID()) then
		v38.Trinket2Duration = 1968 - (1096 + 852);
	else
		v38.Trinket2Duration = v32:BuffDuration();
	end
	VarTrinket1HighValue = ((v38.Trinket1ID == v28.TreacherousTransmitter:ID()) and (1 + 1)) or (1 - 0);
	VarTrinket2HighValue = ((v38.Trinket2ID == v28.TreacherousTransmitter:ID()) and (2 + 0)) or (513 - (409 + 103));
	v38.Trinket1Sync = 236.5 - (46 + 190);
	if ((v38.Trinket1Buffs and ((v27.Apocalypse:IsAvailable() and ((v38.Trinket1CD % (125 - (51 + 44))) == (0 + 0))) or (v27.DarkTransformation:IsAvailable() and ((v38.Trinket1CD % (1362 - (1114 + 203))) == (726 - (228 + 498)))))) or (v38.Trinket1ID == v28.TreacherousTransmitter:ID())) then
		v38.Trinket1Sync = 1 + 0;
	end
	v38.Trinket2Sync = 0.5 + 0;
	if ((v38.Trinket2Buffs and ((v27.Apocalypse:IsAvailable() and ((v38.Trinket2CD % (693 - (174 + 489))) == (0 - 0))) or (v27.DarkTransformation:IsAvailable() and ((v38.Trinket2CD % (1950 - (830 + 1075))) == (524 - (303 + 221)))))) or (v38.Trinket2ID == v28.TreacherousTransmitter:ID())) then
		v38.Trinket2Sync = 1270 - (231 + 1038);
	end
	v38.TrinketPriority = 1 + 0;
	local v155 = ((v38.Trinket1Duration > (1162 - (171 + 991))) and v38.Trinket1Duration) or (4 - 3);
	local v156 = ((v38.Trinket2Duration > (0 - 0)) and v38.Trinket2Duration) or (2 - 1);
	if ((not v38.Trinket1Buffs and v38.Trinket2Buffs and (v32:HasCooldown() or not v31:HasCooldown())) or (v38.Trinket2Buffs and (((v38.Trinket2CD / v156) * v38.Trinket2Sync * VarTrinket2HighValue * (1 + 0 + ((VarTrinket2Level - VarTrinket1Level) / (350 - 250)))) > ((v38.Trinket1CD / v155) * v38.Trinket1Sync * VarTrinket1HighValue * ((2 - 1) + ((VarTrinket1Level - VarTrinket2Level) / (161 - 61))))))) then
		v38.TrinketPriority = 6 - 4;
	end
	v38.DamageTrinketPriority = 1249 - (111 + 1137);
	if (not v38.Trinket1Buffs and not v38.Trinket2Buffs and (VarTrinket2Level >= VarTrinket1Level)) then
		v38.DamageTrinketPriority = 160 - (91 + 67);
	end
end
v63();
local v64 = false;
local v59 = {{v27.Asphyxiate,LUAOBFUSACTOR_DECRYPT_STR_0("\104\210\171\88\91\92\88\195\176\85\3\116\74\199\189\12\83\84\69\199\189\94\9\104\91\199\241", "\29\43\179\216\44\123"),function()
	return true;
end}};
local function v65()
	if (v35.General.AutoTab and v6:AffectingCombat()) then
		v16.TopPanelAlternative:ChangeIcon((3765 - 2405) - (591 + 542 + (989 - (326 + 445))), (52 - 40) - (17 - 9));
		return LUAOBFUSACTOR_DECRYPT_STR_0("\156\204\52\67\253\205\33\78\253\205\47\12\169\216\50\75\184\205", "\44\221\185\64");
	end
end
v3:RegisterForEvent(function()
	v53 = 25935 - 14824;
	v54 = 11822 - (530 + 181);
end, LUAOBFUSACTOR_DECRYPT_STR_0("\49\203\105\102\86\51\216\122\122\84\36\201\119\122\93\32\197\100\122\87", "\19\97\135\40\63"));
v3:RegisterForEvent(function()
	v41 = ((v27.Defile:IsAvailable()) and v27.Defile) or v27.DeathAndDecay;
	v45 = (v27.EbonFever:IsAvailable() and ((882 - (614 + 267)) + (35 - (19 + 13)))) or ((20.1 - 7) - (11 - 6));
	v46 = (v27.EbonFever:IsAvailable() and ((11.6 - 7) - (1 + 0))) or ((759.2 - 327) - ((490 - 253) + (2000 - (1293 + 519))));
	v47 = (v27.EbonFever:IsAvailable() and ((5.6 - 2) + (0 - 0))) or ((13.2 - 6) + (0 - 0));
	v62 = 0 - 0;
	v63();
end, LUAOBFUSACTOR_DECRYPT_STR_0("\158\112\18\2\10\3\145\121\2\14\6\1\131\121\29\15\16\18\134\125\29\28\10\21", "\81\206\60\83\91\79"), LUAOBFUSACTOR_DECRYPT_STR_0("\125\155\245\94\3\240\114\135\102\138\254\85\10\231", "\196\46\203\176\18\79\163\45"), LUAOBFUSACTOR_DECRYPT_STR_0("\148\7\95\44\10\222\203\135\17\78\59\8\215\208\145\12\65\42\5\217", "\143\216\66\30\126\68\155"));
local function v66()
	return (v6:HealthPercentage() < v37.Unholy.Defensives.UseDeathStrikeHP) or ((v6:HealthPercentage() < v37.Unholy.Defensives.UseDarkSuccorHP) and v6:BuffUp(v27.DeathStrikeBuff));
end
local function v67(v158)
	local v159 = 0 + 0;
	for v207, v208 in pairs(v158) do
		if v208:DebuffDown(v27.VirulentPlagueDebuff) then
			v159 = v159 + 1 + 0;
		end
	end
	return v159;
end
function IsNpcNearPlayer()
	local v160 = v6:GetEnemiesInRange(92 - 52);
	for v209, v210 in pairs(v160) do
		if ((v210:NPCID() == (9326 + 31031)) or (v210:CastSpellID() == (148834 + 299179))) then
			print(LUAOBFUSACTOR_DECRYPT_STR_0("\164\216\14\139\195\172\194\239\174\146\77\207\202\227\217\238\190\136\24\216\192\227\214\227\165\136\1\194\200\161", "\129\202\168\109\171\165\195\183"));
			return true;
		end
	end
	return false;
end
local v68 = {((214539 - (709 + 387)) - ((2118 - (673 + 1185)) + (11 - 7))),((571136 - 224012) - (94212 + 37505)),((806875 - 209260) - (106374 + 326740)),((319288 - 156637) - (124212 - (446 + 1434)))};
function NoNPCAvailable(v161)
	for v211, v212 in ipairs(v161) do
		if ((v10:NPCID() == v212) or (v11:NPCID() == v212) or (v12:NPCID() == v212) or (v7:NPCID() == v212)) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\54\74\34\221", "\134\66\56\87\184\190\116");
		end
	end
	return LUAOBFUSACTOR_DECRYPT_STR_0("\58\48\5\168\28", "\85\92\81\105\219\121\139\65");
end
local function v69(v162)
	local v163 = {};
	for v213 in pairs(v162) do
		if not v5:IsInBossList(v162[v213]['UnitNPCID']) then
			v24(v163, v162[v213]);
		end
	end
	return v3.FightRemains(v163);
end
local function v70(v164)
	return v164:DebuffStack(v27.FesteringWoundDebuff);
end
local function v71(v165)
	return v165:DebuffRemains(v27.TrollbaneSlowDebuff);
end
local function v72(v166)
	return v166:DebuffStack(v27.FesteringWoundDebuff) < (1285 - (1040 + 243));
end
local function v73(v167)
	return v167:DebuffStack(v27.FesteringWoundDebuff) <= (5 - 3);
end
local function v74(v168)
	return not v27.VileContagion:IsAvailable() and (v168:DebuffStack(v27.FesteringWoundDebuff) <= ((2386 - (559 + 1288)) - ((2292 - (609 + 1322)) + (628 - (13 + 441)))));
end
local function v75(v169)
	return (v27.VileContagion:IsAvailable() and (v27.VileContagion:CooldownRemains() < ((5866 - 4296) - ((1147 - 709) + (5612 - 4485))))) or ((v27.FesteringWoundDebuff:AuraActiveCount() == v50) and (v169:DebuffStack(v27.FesteringWoundDebuff) <= ((66 + 1684) - ((1612 - 1168) + 463 + 839))));
end
local function v76(v170)
	return ((v27.Apocalypse:CooldownRemains() < v6:GCD()) and v170:DebuffDown(v27.FesteringWoundDebuff)) or (v27.FesteringWoundDebuff:AuraActiveCount() < v50);
end
local function v77(v171)
	return (not v27.VampiricStrikeAction:IsReady() and not v38.PopWounds and (v171:DebuffStack(v27.FesteringWoundDebuff) < (1 + 1))) or v6:BuffUp(v27.FesteringScytheBuff);
end
local function v78(v172)
	return not v27.VampiricStrikeAction:IsReady() and (v27.Apocalypse:CooldownRemains() < v38.ApocTiming) and v172:DebuffDown(v27.FesteringWoundDebuff);
end
local function v79(v173)
	return (v27.Apocalypse:CooldownRemains() < v38.ApocTiming) and (v173:DebuffStack(v27.FesteringWoundDebuff) < ((839 - 556) - (85 + 69 + (229 - 104))));
end
local function v80(v174)
	return v38.AddsRemain and (((v174:DebuffStack(v27.FesteringWoundDebuff) >= (2 + 0)) and (v27.VileContagion:CooldownRemains() < (2 + 1))) or not v27.VileContagion:IsAvailable());
end
local function v81(v175)
	return v38.AddsRemain and (((v175:DebuffStack(v27.FesteringWoundDebuff) >= (2 + 0)) and (v27.VileContagion:CooldownRemains() < (6 + 0))) or not v27.VileContagion:IsAvailable());
end
local function v82(v176)
	return ((v176:DebuffStack(v27.FesteringWoundDebuff) >= (4 + 0)) and (v54 > (437 - (153 + 280))) and ((v41:CooldownRemains() < (8 - 5)) or (v6:BuffUp(v27.DeathAndDecayBuff) and (v176:DebuffStack(v27.FesteringWoundDebuff) >= (4 + 0))))) or (v38.AddsRemain and (v176:DebuffStack(v27.FesteringWoundDebuff) == (3 + 3)));
end
local function v83(v177)
	return ((v177:DebuffStack(v27.FesteringWoundDebuff) == (4 + 2)) and (v6:DnDTicking() or (v41:CooldownRemains() < (3 + 0)))) or (v6:BuffUp(v27.DeathAndDecayBuff) and (v177:DebuffStack(v27.FesteringWoundDebuff) >= (3 + 1))) or ((v41:CooldownRemains() < (4 - 1)) and (v177:DebuffStack(v27.FesteringWoundDebuff) >= (3 + 1)));
end
local function v84(v178)
	return v178:DebuffStack(v27.FesteringWoundDebuff) >= (668 - (89 + 578));
end
local function v85(v179)
	return v179:DebuffUp(v27.TrollbaneSlowDebuff) and (v179:DebuffRemains(v27.TrollbaneSlowDebuff) < v6:GCD());
end
local function v86(v180)
	return ((v180:DebuffStack(v27.FesteringWoundDebuff) >= (1 + 0)) and (v27.Apocalypse:CooldownRemains() > v6:GCD())) or (v27.VampiricStrikeAction:IsLearned() and v180:DebuffUp(v27.VirulentPlagueDebuff));
end
local function v87(v181)
	return (v181:DebuffStack(v27.FesteringWoundDebuff) >= (1 - 0)) or v27.VampiricStrikeAction:IsLearned();
end
local function v88(v182)
	return v182:DebuffUp(v27.TrollbaneSlowDebuff);
end
local function v89(v183)
	return v183:DebuffUp(v27.TrollbaneSlowDebuff) and (v183:DebuffRemains(v27.TrollbaneSlowDebuff) < v6:GCD());
end
local function v90(v184)
	return (v184:TimeToDie() > v184:DebuffRemains(v27.VirulentPlagueDebuff)) and (v184:DebuffTicksRemain(v27.VirulentPlagueDebuff) < (1054 - (572 + 477))) and ((v184:DebuffRemains(v27.VirulentPlagueDebuff) <= v45) or (v27.Superstrain:IsAvailable() and ((v184:DebuffRemains(v27.FrostFeverDebuff) <= v46) or (v184:DebuffRemains(v27.BloodPlagueDebuff) <= v47)))) and (not UnholyBlightSetting or not v27.UnholyBlight:IsAvailable() or v27.Plaguebringer:IsAvailable()) and (not RaiseAbominationSetting or not v27.RaiseAbomination:IsAvailable() or (v27.RaiseAbomination:IsAvailable() and RaiseAbominationSetting and (v27.RaiseAbomination:CooldownRemains() > (v184:DebuffTicksRemain(v27.VirulentPlagueDebuff) * (1 + 2)))));
end
local function v91(v185)
	return (v185:TimeToDie() > v185:DebuffRemains(v27.VirulentPlagueDebuff)) and (v185:DebuffTicksRemain(v27.VirulentPlagueDebuff) < (4 + 1)) and (v185:DebuffRefreshable(v27.VirulentPlagueDebuff) or (v27.Morbidity:IsAvailable() and v6:BuffUp(v27.InflictionofSorrowBuff) and v27.Superstrain:IsAvailable() and v185:DebuffRefreshable(v27.FrostFeverDebuff) and v185:DebuffRefreshable(v27.BloodPlagueDebuff))) and (not v27.UnholyBlight:IsAvailable() or (v27.UnholyBlight:IsAvailable() and (v27.DarkTransformation:CooldownRemains() > (1 + 4)))) and (not v27.RaiseAbomination:IsAvailable() or (v27.RaiseAbomination:IsAvailable() and (v27.RaiseAbomination:CooldownRemains() > (91 - (84 + 2)))));
end
local function v92(v186)
	return (v186:TimeToDie() > v186:DebuffRemains(v27.VirulentPlagueDebuff)) and (v186:DebuffTicksRemain(v27.VirulentPlagueDebuff) < (8 - 3)) and ((v186:DebuffRemains(v27.VirulentPlagueDebuff) <= v45) or (v27.Morbidity:IsAvailable() and v6:BuffUp(v27.InflictionofSorrowBuff) and v27.Superstrain:IsAvailable() and (v186:DebuffRemains(v27.FrostFeverDebuff) <= v46) and (v186:DebuffRemains(v27.BloodPlagueDebuff) <= v47))) and (not UnholyBlightSetting or not v27.UnholyBlight:IsAvailable() or (v27.UnholyBlight:IsAvailable() and (v27.DarkTransformation:CooldownDown() or not DarkTransformationSetting))) and (not RaiseAbominationSetting or not v27.RaiseAbomination:IsAvailable() or (v27.RaiseAbomination:IsAvailable() and v27.RaiseAbomination:CooldownDown()));
end
local function v93(v187)
	return ((v7:DebuffRemains(v27.VirulentPlagueDebuff) <= v45) or (v27.Morbidity:IsAvailable() and v6:BuffDown(v27.GiftoftheSanlaynBuff) and v27.Superstrain:IsAvailable() and (v7:DebuffRemains(v27.FrostFeverDebuff) <= v46) and (v7:DebuffRemains(v27.BloodPlagueDebuff) <= v47))) and (not v27.UnholyBlight:IsAvailable() or (v27.UnholyBlight:IsAvailable() and (v27.DarkTransformation:CooldownRemains() > (((838 + 325) - ((1482 - (497 + 345)) + 13 + 495)) / ((((149 + 730) - ((1435 - (605 + 728)) + 553 + 222)) * v20(v27.Superstrain:IsAvailable())) + (((1 - 0) + 1 + 0) * v20(v27.EbonFever:IsAvailable())) + (((4691 - 3422) - (566 + 61 + (1773 - 1133))) * v20(v27.Plaguebringer:IsAvailable()))))))) and (not v27.RaiseAbomination:IsAvailable() or not RaiseAbominationSetting or (v27.RaiseAbomination:IsAvailable() and (v27.RaiseAbomination:CooldownRemains() > ((7 + 2 + (495 - (457 + 32))) / ((((842 + 1141) - ((1890 - (832 + 570)) + 1407 + 86)) * v20(v27.Superstrain:IsAvailable())) + (((2 + 4) - (13 - 9)) * v20(v27.EbonFever:IsAvailable())) + (((1 + 1) - (796 - (588 + 208))) * v20(v27.Plaguebringer:IsAvailable())))))));
end
local function v94(v188)
	return (v188:TimeToDie() > v188:DebuffRemains(v27.VirulentPlagueDebuff)) and v188:DebuffRefreshable(v27.VirulentPlagueDebuff);
end
local function v95(v189)
	return v189:DebuffUp(v27.TrollbaneSlowDebuff);
end
local function v96()
	if (v27.ArmyoftheDead:IsReady() and v7:IsInMeleeRange(13 - 8) and ArmyOfTheDeadSetting and not v28.Fyralath:IsEquipped()) then
		if v17(v27.ArmyoftheDead) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\252\161\93\92\67\208\251\140\68\77\121\224\249\182\81\65\60\207\239\182\83\74\113\221\252\167\16\17", "\191\157\211\48\37\28");
		end
	end
	if (v27.Outbreak:IsReady() and v7:IsSpellInRange(v27.Outbreak) and v94(v7)) then
		if v17(v27.Outbreak) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\208\10\224\30\40\218\30\255\92\42\205\26\247\19\55\221\30\224\92\108", "\90\191\127\148\124");
		end
	end
	if (v43:IsReady() and v7:IsInMeleeRange(v44)) then
		if v17(v27.FesteringStrike) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\126\130\61\3\125\149\39\25\127\184\61\3\106\142\37\18\56\151\60\18\123\136\35\21\121\147\110\79", "\119\24\231\78");
		end
	end
end
local function v97()
	if (v27.FesteringScytheAction:IsReady() and v7:IsInMeleeRange(v44)) then
		if v17(v27.FesteringStrike) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\132\40\182\94\217\82\24\140\42\154\89\223\89\5\138\40\229\75\211\69\81\208", "\113\226\77\197\42\188\32");
		end
	end
	if (v39:IsReady() and v7:IsInRange(WoundSpenderRange) and v6:BuffUp(v27.DeathAndDecayBuff) and v27.BurstingSores:IsAvailable() and ((v27.Apocalypse:CooldownRemains() > v38.ApocTiming) or not ApocalypseSetting)) then
		if v36.CastTargetIf(v40, v48, LUAOBFUSACTOR_DECRYPT_STR_0("\55\23\236", "\213\90\118\148"), v70, v84, WoundSpenderRange, false, false, false, true) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\76\33\161\88\73\100\61\164\83\67\95\43\166\22\76\84\43\244\2", "\45\59\78\212\54");
		end
	end
	if (v27.DeathCoil:IsReady() and v7:IsSpellInRange(v27.DeathCoil) and not v38.PoolingRunicPower and (v50 < v38.EpidemicTargets)) then
		if v17(v27.DeathCoil) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\20\83\130\159\142\17\174\255\25\90\195\136\138\43\172\230\21\22\215", "\144\112\54\227\235\230\78\205");
		end
	end
	if (v27.Epidemic:IsReady() and v7:IsInRange(1840 - (884 + 916)) and not v38.PoolingRunicPower) then
		if v17(v27.Epidemic) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\182\56\6\248\213\86\186\43\79\253\223\94\243\126", "\59\211\72\111\156\176");
		end
	end
	if (v39:IsReady() and v7:IsInRange(WoundSpenderRange)) then
		if v36.CastCycle(v40, v48, v95, 10 - 5) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\89\136\246\35\74\184\240\61\75\137\231\40\92\199\226\34\75\199\187", "\77\46\231\131");
		end
	end
	if (v43:IsReady() and v7:IsInMeleeRange(v44) and ((ApocalypseSetting and (v27.Apocalypse:CooldownRemains() < v38.ApocTiming)) or v6:BuffUp(v27.FesteringScytheBuff))) then
		if v36.CastTargetIf(v27.FesteringStrike, v48, LUAOBFUSACTOR_DECRYPT_STR_0("\183\85\174", "\32\218\52\214"), v70, nil, v44, false, false, false, true) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\72\18\34\188\244\162\76\84\73\40\34\188\227\185\78\95\14\22\62\173\177\225\21", "\58\46\119\81\200\145\208\37");
		end
	end
	if (v43:IsReady() and v7:IsInMeleeRange(v44)) then
		if v36.CastTargetIf(v27.FesteringStrike, v48, LUAOBFUSACTOR_DECRYPT_STR_0("\38\133\62", "\86\75\236\80\204\201\221"), v70, v72, v44, false, false, false, true) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\116\68\100\145\251\153\123\79\112\186\237\159\96\72\124\128\190\138\125\68\55\212\172", "\235\18\33\23\229\158");
		end
	end
	if (v39:IsReady() and v7:IsInRange(WoundSpenderRange)) then
		if v36.CastTargetIf(v40, v48, LUAOBFUSACTOR_DECRYPT_STR_0("\93\187\217", "\219\48\218\161"), v70, v86, WoundSpenderRange, false, false, false, true) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\243\126\105\71\223\112\243\244\116\114\77\222\93\160\229\126\121\9\138\27", "\128\132\17\28\41\187\47");
		end
	end
end
local function v98()
	if (v27.FesteringScytheAction:IsReady() and v7:IsInMeleeRange(9 + 5)) then
		if v17(v27.FesteringStrike) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\7\55\21\46\88\19\59\8\61\98\18\49\31\46\85\4\114\7\53\88\62\48\19\40\78\21\114\84", "\61\97\82\102\90");
		end
	end
	if (v27.DeathCoil:IsReady() and v7:IsSpellInRange(v27.DeathCoil) and not v27.VampiricStrikeAction:IsLearned() and (v50 < v38.EpidemicTargets) and (not v27.BurstingSores:IsAvailable() or (v27.BurstingSores:IsAvailable() and (v27.FesteringWoundDebuff:AuraActiveCount() < v50) and (v27.FesteringWoundDebuff:AuraActiveCount() < (v50 * (653.4 - (232 + 421)))) and v6:BuffUp(v27.SuddenDoomBuff)) or (v6:BuffUp(v27.SuddenDoomBuff) and ((v27.DoomedBidding:IsAvailable() and v27.MenacingMagus:IsAvailable()) or v27.RottenTouch:IsAvailable() or (v7:DebuffRemains(v27.DeathRotDebuff) < v6:GCD()))))) then
		if v17(v27.DeathCoil) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\168\43\170\95\207\104\29\6\165\34\235\74\200\82\33\11\185\60\184\95\135\3", "\105\204\78\203\43\167\55\126");
		end
	end
	if (v27.Epidemic:IsReady() and v7:IsInRange(1929 - (1569 + 320)) and not v27.VampiricStrikeAction:IsLearned() and (not v27.BurstingSores:IsAvailable() or (v27.BurstingSores:IsAvailable() and (v27.FesteringWoundDebuff:AuraActiveCount() < v50) and (v27.FesteringWoundDebuff:AuraActiveCount() < (v50 * (0.4 + 0))) and v6:BuffUp(v27.SuddenDoomBuff)) or (v6:BuffUp(v27.SuddenDoomBuff) and (v6:BuffUp(v27.AFeastofSoulsBuff) or (v7:DebuffRemains(v27.DeathRotDebuff) < v6:GCD()) or (v7:DebuffStack(v27.DeathRotDebuff) < (2 + 8)))))) then
		if v17(v27.Epidemic) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\160\186\42\26\22\9\206\82\229\171\44\27\44\6\210\67\182\190\99\74", "\49\197\202\67\126\115\100\167");
		end
	end
	if (v39:IsReady() and v7:IsInRange(WoundSpenderRange)) then
		if v36.CastCycle(v40, v48, v95, WoundSpenderRange, false, false, false, true) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\32\84\202\39\132\105\77\39\94\209\45\133\68\30\54\84\218\22\130\67\76\36\79\159\127", "\62\87\59\191\73\224\54");
		end
	end
	if (v39:IsReady() and v7:IsInRange(WoundSpenderRange)) then
		if v36.CastTargetIf(v40, v48, LUAOBFUSACTOR_DECRYPT_STR_0("\234\3\226", "\169\135\98\154"), v70, v87, WoundSpenderRange, false, false, false, true) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\220\120\49\90\249\12\219\219\114\42\80\248\33\136\202\120\33\107\255\38\218\216\99\100\12", "\168\171\23\68\52\157\83");
		end
	end
	if (v27.DeathCoil:IsReady() and v7:IsSpellInRange(v27.DeathCoil) and (v50 < v38.EpidemicTargets)) then
		if v17(v27.DeathCoil) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\240\116\244\185\45\18\132\251\120\249\237\36\34\130\203\115\224\191\54\57\199\165\33", "\231\148\17\149\205\69\77");
		end
	end
	if (v27.Epidemic:IsReady() and v7:IsInRange(134 - 94)) then
		if v17(v27.Epidemic) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\133\183\206\255\82\242\137\164\135\250\88\250\191\165\210\233\68\235\192\246\151", "\159\224\199\167\155\55");
		end
	end
	if (v43:IsReady() and v7:IsInMeleeRange(v44)) then
		if v36.CastTargetIf(v43, v48, LUAOBFUSACTOR_DECRYPT_STR_0("\250\250\50", "\178\151\147\92"), v70, v73, v44, false, false, false, true) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\138\248\95\38\23\94\115\130\250\115\33\6\94\115\135\248\12\51\29\73\69\142\232\94\33\6\12\43\222", "\26\236\157\44\82\114\44");
		end
	end
	if (v39:IsReady() and v7:IsInRange(WoundSpenderRange)) then
		if v36.CastTargetIf(v40, v48, LUAOBFUSACTOR_DECRYPT_STR_0("\39\47\205", "\59\74\78\181"), v70, nil, WoundSpenderRange, false, false, false, true) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\50\222\79\84\183\26\194\74\95\189\33\212\72\26\178\42\212\101\88\166\55\194\78\26\226\113", "\211\69\177\58\58");
		end
	end
end
local function v99()
	if (v27.FesteringScytheAction:IsReady() and v7:IsInMeleeRange(619 - (316 + 289))) then
		if v36.CastTargetIf(v43, v48, LUAOBFUSACTOR_DECRYPT_STR_0("\186\236\119", "\171\215\133\25\149\137"), v70, v73, v44, false, false, false, true) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\231\205\33\238\234\34\245\76\230\247\33\249\246\36\244\71\161\201\61\255\208\35\249\86\244\216\114\168", "\34\129\168\82\154\143\80\156");
		end
	end
	if (v41:IsReady() and DnDSetting and not v6:DnDTicking() and ((not v27.BurstingSores:IsAvailable() and not v27.VileContagion:IsAvailable()) or (v27.FesteringWoundDebuff:AuraActiveCount() == v50) or (v27.FesteringWoundDebuff:AuraActiveCount() >= (20 - 12)) or v27.Defile:IsAvailable())) then
		if v16.CastTarget(v27.DeathAndDecay, v16.TName().PLAYER) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\132\188\42\52\76\64\141\197\179\60\14\119\93\140\145\167\35\75\28", "\233\229\210\83\107\40\46");
		end
	end
	if (v39:IsReady() and v7:IsInRange(WoundSpenderRange)) then
		if v36.CastCycle(v40, v48, v95, WoundSpenderRange, false, false, false, true) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\214\77\39\216\1\254\81\34\211\11\197\71\32\150\4\206\71\13\197\0\213\87\34\150\83", "\101\161\34\82\182");
		end
	end
	if v43:IsReady() then
		if v36.CastTargetIf(v43, v48, LUAOBFUSACTOR_DECRYPT_STR_0("\229\12\65", "\78\136\109\57\158\187\130\226"), v70, v74, v44, false, false, false, true) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\56\58\234\229\59\45\240\255\57\0\234\229\44\54\242\244\126\62\246\244\1\44\252\229\43\47\185\169", "\145\94\95\153");
		end
	end
	if (v43:IsReady() and v7:IsInMeleeRange(v44)) then
		if v36.CastTargetIf(v43, v48, LUAOBFUSACTOR_DECRYPT_STR_0("\240\204\12", "\215\157\173\116\181\46"), v70, v75, v44, false, false, false, true) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\51\177\152\230\223\39\189\133\245\229\38\160\153\251\209\48\244\138\253\223\10\167\142\230\207\37\244\218\162", "\186\85\212\235\146");
		end
	end
	if (v27.DeathCoil:IsReady() and v7:IsSpellInRange(v27.DeathCoil) and v6:BuffUp(v27.SuddenDoomBuff) and (v50 < v38.EpidemicTargets)) then
		if v17(v27.DeathCoil) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\198\132\23\234\49\209\91\205\136\26\190\56\225\93\253\146\19\234\44\254\24\147\211", "\56\162\225\118\158\89\142");
		end
	end
	if (v27.Epidemic:IsReady() and v7:IsInRange(2 + 38) and not v38.PoolingRunicPower and v6:BuffUp(v27.SuddenDoomBuff)) then
		if v17(v27.Epidemic) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\89\21\201\171\39\213\85\6\128\174\45\221\99\22\197\187\55\200\28\84\146", "\184\60\101\160\207\66");
		end
	end
	if (v43:IsReady() and v7:IsInMeleeRange(v44)) then
		if v36.CastTargetIf(v43, v48, LUAOBFUSACTOR_DECRYPT_STR_0("\60\139\114", "\220\81\226\28"), v70, v76, v44, false, false, false, true) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\21\208\145\239\239\213\26\219\133\196\249\211\1\220\137\254\170\198\28\208\189\232\239\211\6\197\194\170\190", "\167\115\181\226\155\138");
		end
	end
	if (v27.DeathCoil:IsReady() and v7:IsSpellInRange(v27.DeathCoil) and (v50 < v38.EpidemicTargets)) then
		if v17(v27.DeathCoil) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\230\39\230\72\115\78\197\237\43\235\28\122\126\195\221\49\226\72\110\97\134\179\116", "\166\130\66\135\60\27\17");
		end
	end
	if (v27.Epidemic:IsReady() and v7:IsInRange(1493 - (666 + 787)) and not v38.PoolingRunicPower) then
		if v17(v27.Epidemic) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\65\90\199\113\53\73\67\205\53\49\75\79\241\102\53\80\95\222\53\97\18", "\80\36\42\174\21");
		end
	end
end
local function v100()
	if (v27.DarkTransformation:IsCastable() and v7:IsInMeleeRange(430 - (360 + 65)) and DarkTransformationSetting and ((v38.STPlanning and ((v27.Apocalypse:CooldownRemains() < (8 + 0)) or not v27.Apocalypse:IsAvailable() or (v50 >= (255 - (79 + 175))))) or (v53 < (31 - 11)))) then
		if v17(v27.DarkTransformation) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\74\17\37\113\113\4\37\123\64\3\49\117\92\29\54\110\71\31\57\58\77\20\36\58\28", "\26\46\112\87");
		end
	end
	if (v27.UnholyAssault:IsCastable() and v7:IsInMeleeRange(4 + 1) and UnholyAssaultSetting and ((v38.STPlanning and ((v27.Apocalypse:CooldownRemains() < (v6:GCD() * (5 - 3))) or not v27.Apocalypse:IsAvailable() or ((v50 >= (3 - 1)) and v13:BuffUp(v27.DarkTransformation)))) or (v53 < (919 - (503 + 396))))) then
		if v17(v27.UnholyAssault) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\172\45\163\123\179\166\122\181\170\48\170\97\179\171\5\183\189\48\235\32", "\212\217\67\203\20\223\223\37");
		end
	end
	if (v27.Apocalypse:IsReady() and v7:IsInMeleeRange(191 - (92 + 89)) and ApocalypseSetting and (v38.STPlanning or (v53 < (38 - 18)))) then
		if v17(v27.Apocalypse) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\187\157\167\209\187\129\177\194\169\136\232\209\190\158\232\132", "\178\218\237\200");
		end
	end
	if (v27.Outbreak:IsReady() and v7:IsSpellInRange(v27.Outbreak)) then
		if v36.CastCycle(v27.Outbreak, v51, v90, 21 + 19) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\185\160\242\210\164\176\231\219\246\182\226\195\246\237", "\176\214\213\134");
		end
	end
	if (v27.Apocalypse:IsReady() and v7:IsInMeleeRange(6 + 4) and ApocalypseSetting and ((v38.STPlanning and v6:BuffDown(v27.SuddenDoomBuff) and ((v6:BuffUp(v27.FestermightBuff) and (v6:BuffStack(v27.FestermightBuff) > (31 - 23))) or not v27.Festermight:IsAvailable()) and ((v38.ApocGhoulRemains < (1 + 4)) or not v27.Apocalypse:IsAvailable()) and (v42 <= (4 - 2))) or (v53 < (11 + 1)))) then
		if v17(v27.Apocalypse) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\245\189\185\215\169\90\64\228\190\179\148\171\82\74\180\252\230", "\57\148\205\214\180\200\54");
		end
	end
	if (v27.AbominationLimb:IsCastable() and v7:IsInRange(10 + 10) and AbominationLimbSetting and v38.AddsRemain) then
		if v17(v27.AbominationLimb) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\19\255\58\57\127\28\252\33\61\121\28\194\57\61\123\16\189\54\48\101\82\172\103", "\22\114\157\85\84");
		end
	end
end
local function v101()
	if (v27.VileContagion:IsReady() and v82(v7) and v7:IsSpellInRange(v27.VileContagion)) then
		if v17(v27.VileContagion) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\210\194\31\193\98\245\167\202\223\18\195\84\249\166\132\200\23\215\98\247\167\193\139\65", "\200\164\171\115\164\61\150");
		end
	end
	if (v27.UnholyAssault:IsCastable() and v7:IsInMeleeRange(15 - 10) and UnholyAssaultSetting and v80(v7)) then
		if v17(v27.UnholyAssault) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\171\250\11\74\143\167\203\2\86\144\191\225\15\81\195\189\240\16\122\130\177\241\67\17", "\227\222\148\99\37");
		end
	end
	if (v27.DarkTransformation:IsCastable() and v7:IsInMeleeRange(1 + 4) and DarkTransformationSetting and v38.AddsRemain and ((v27.VileContagion:CooldownRemains() > (7 - 2)) or not v27.VileContagion:IsAvailable() or v6:DnDTicking() or (v41:CooldownRemains() < (1247 - (485 + 759))))) then
		if v17(v27.DarkTransformation) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\55\83\64\253\198\39\64\83\248\234\53\93\64\251\248\39\91\93\248\185\48\86\65\201\248\60\87\18\160", "\153\83\50\50\150");
		end
	end
	if (v27.Outbreak:IsReady() and v7:IsSpellInRange(v27.Outbreak) and (((v7:DebuffTicksRemain(v27.VirulentPlagueDebuff) < (11 - 6)) and (v7:DebuffRemains(v27.VirulentPlagueDebuff) <= v45)) or (v27.Superstrain:IsAvailable() and (v7:DebuffRemains(v27.FrostFeverDebuff) <= v46) and (v7:DebuffRemains(v27.BloodPlagueDebuff) <= v47))) and (not UnholyBlightSetting or not v27.UnholyBlight:IsAvailable() or (v27.UnholyBlight:IsAvailable() and v27.DarkTransformation:CooldownDown())) and (not RaiseAbominationSetting or not v27.RaiseAbomination:IsAvailable() or (v27.RaiseAbomination:IsAvailable() and v27.RaiseAbomination:CooldownDown()))) then
		if v17(v27.Outbreak) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\82\99\103\30\97\174\76\86\54\112\24\96\148\76\82\115\51\68", "\45\61\22\19\124\19\203");
		end
	end
	if (v27.Apocalypse:IsReady() and v7:IsInMeleeRange(1199 - (442 + 747)) and ApocalypseSetting and v38.AddsRemain and (v6:Rune() <= (1138 - (832 + 303)))) then
		if v17(v27.Apocalypse) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\192\2\2\246\3\124\160\209\1\8\181\1\116\170\254\19\2\240\66\33\233", "\217\161\114\109\149\98\16");
		end
	end
	if (v27.AbominationLimb:IsCastable() and v7:IsInRange(966 - (88 + 858)) and AbominationLimbSetting and v38.AddsRemain) then
		if v17(v27.AbominationLimb) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\19\34\55\113\181\122\19\52\49\115\178\75\30\41\53\126\252\119\22\51\7\125\179\113\82\113\106", "\20\114\64\88\28\220");
		end
	end
end
local function v102()
	if (v27.DarkTransformation:IsCastable() and v7:IsInMeleeRange(2 + 3) and DarkTransformationSetting and v38.AddsRemain and (v6:BuffUp(v27.DeathAndDecayBuff) or (v50 <= (3 + 0)))) then
		if v17(v27.DarkTransformation) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\53\0\192\191\199\196\175\48\15\193\178\247\194\176\48\21\219\187\246\144\190\53\18\237\181\247\213\130\34\0\220\244\170", "\221\81\97\178\212\152\176");
		end
	end
	if (v27.VileContagion:IsReady() and v7:IsSpellInRange(v27.VileContagion) and v82(v7)) then
		if v17(v27.VileContagion) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\219\238\17\254\37\206\232\19\239\27\202\238\18\245\90\206\227\14\196\27\194\226\34\232\27\195\167\73", "\122\173\135\125\155");
		end
	end
	if (v27.UnholyAssault:IsCastable() and v7:IsInMeleeRange(1 + 4) and UnholyAssaultSetting and v81(v7) and v38.AddsRemain) then
		if v17(v27.UnholyAssault) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\145\207\8\182\51\40\247\133\210\19\184\42\61\220\196\194\4\170\0\48\199\129\254\19\184\49\113\158", "\168\228\161\96\217\95\81");
		end
	end
	if (v27.Outbreak:IsReady() and v7:IsSpellInRange(v27.Outbreak) and ((v7:DebuffRemains(v27.VirulentPlagueDebuff) <= v45) or (v27.Morbidity:IsAvailable() and v6:BuffDown(v27.GiftoftheSanlaynBuff) and v27.Superstrain:IsAvailable() and (v7:DebuffRemains(v27.FrostFeverDebuff) <= v46) and (v7:DebuffRemains(v27.BloodPlagueDebuff) <= v47))) and (not v27.UnholyBlight:IsAvailable() or (v27.UnholyBlight:IsAvailable() and v27.DarkTransformation:CooldownDown())) and (not v27.RaiseAbomination:IsAvailable() or (v27.RaiseAbomination:IsAvailable() and v27.RaiseAbomination:CooldownDown()))) then
		if v17(v27.Outbreak) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\212\196\58\94\61\82\218\218\110\95\43\68\228\208\33\89\16\68\218\223\110\4", "\55\187\177\78\60\79");
		end
	end
	if (v27.Apocalypse:IsReady() and v7:IsInMeleeRange(799 - (766 + 23)) and ApocalypseSetting and v38.AddsRemain and (v6:Rune() <= (14 - 11))) then
		if v17(v27.Apocalypse) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\44\222\80\232\71\195\153\61\221\90\171\69\203\147\18\207\80\238\121\220\129\35\142\14\187", "\224\77\174\63\139\38\175");
		end
	end
	if (v27.AbominationLimb:IsCastable() and v7:IsInRange(27 - 7) and AbominationLimbSetting and v38.AddsRemain) then
		if v17(v27.AbominationLimb) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\133\67\87\35\141\79\89\58\141\78\86\17\136\72\85\44\196\66\92\61\187\64\87\43\187\82\89\32\196\16\10", "\78\228\33\56");
		end
	end
end
local function v103()
	if (v27.DarkTransformation:IsCastable() and v7:IsInMeleeRange(13 - 8) and DarkTransformationSetting and (((v50 >= (3 - 2)) and v38.STPlanning and ((v27.Apocalypse:IsAvailable() and v38.ApocGhoulActive) or not v27.Apocalypse:IsAvailable() or not ApocalypseSetting)) or (v53 < (1093 - (1036 + 37))))) then
		if v17(v27.DarkTransformation) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\202\127\160\8\186\218\108\179\13\150\200\113\160\14\132\218\119\189\13\197\205\122\161\60\150\207\112\242\81", "\229\174\30\210\99");
		end
	end
	if (v27.UnholyAssault:IsCastable() and v7:IsInMeleeRange(4 + 1) and UnholyAssaultSetting and ((v38.STPlanning and v13:BuffUp(v27.DarkTransformation) and (v13:BuffRemains(v27.DarkTransformation) < (23 - 11))) or (v53 < (16 + 4)))) then
		if v17(v27.UnholyAssault) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\14\227\142\94\225\36\6\26\254\149\80\248\49\45\91\238\130\66\210\46\56\21\173\210", "\89\123\141\230\49\141\93");
		end
	end
	if (v27.Apocalypse:IsReady() and v7:IsInMeleeRange(1490 - (641 + 839)) and ApocalypseSetting and (v38.STPlanning or (v53 < (933 - (910 + 3))))) then
		if v17(v27.Apocalypse) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\242\97\249\15\17\70\234\97\229\9\80\73\247\98\201\31\17\68\179\39", "\42\147\17\150\108\112");
		end
	end
	if (v27.Outbreak:IsReady() and v7:IsSpellInRange(v27.Outbreak)) then
		if v36.CastCycle(v27.Outbreak, v51, v92, 101 - 61) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\0\179\57\125\245\237\14\173\109\124\227\251\48\181\44\113\167\176", "\136\111\198\77\31\135");
		end
	end
	if (v27.AbominationLimb:IsCastable() and v7:IsInRange(1704 - (1466 + 218)) and AbominationLimbSetting and (v50 >= (1 + 0)) and v38.STPlanning and v13:BuffDown(v27.DarkTransformation) and v6:BuffDown(v27.SuddenDoomBuff) and v6:BuffUp(v27.FestermightBuff) and (v42 <= (1150 - (556 + 592)))) then
		if v17(v27.AbominationLimb) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\3\11\168\91\180\234\22\189\11\6\169\105\177\237\26\171\66\10\163\69\130\247\22\167\66\88\247", "\201\98\105\199\54\221\132\119");
		end
	end
end
local function v104()
	if (v27.DarkTransformation:IsCastable() and v7:IsInMeleeRange(2 + 3) and DarkTransformationSetting and ((v6:BuffUp(v27.DeathAndDecayBuff) and ((v27.Apocalypse:IsAvailable() and v38.ApocGhoulActive) or not v27.Apocalypse:IsAvailable())) or (v53 < (828 - (329 + 479))))) then
		if v17(v27.DarkTransformation) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\189\13\145\42\61\33\190\184\2\144\39\13\39\161\184\24\138\46\12\117\175\189\31\188\34\14\48\173\175\9\188\50\3\59\236\235", "\204\217\108\227\65\98\85");
		end
	end
	if (v27.UnholyAssault:IsCastable() and v7:IsInMeleeRange(859 - (174 + 680)) and UnholyAssaultSetting and ((v13:BuffUp(v27.DarkTransformation) and (v13:BuffRemains(v27.DarkTransformation) < (41 - 29))) or (v53 < (41 - 21)))) then
		if v17(v27.UnholyAssault) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\75\205\253\234\32\217\97\194\230\246\45\213\82\215\181\230\40\211\97\192\249\224\45\214\91\252\230\228\34\128\10", "\160\62\163\149\133\76");
		end
	end
	if (v27.Apocalypse:IsReady() and v7:IsInMeleeRange(8 + 2) and ApocalypseSetting) then
		if v17(v27.Apocalypse) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\215\176\2\44\194\218\185\29\60\198\150\163\9\60\252\213\172\8\46\213\211\159\30\46\205\150\246", "\163\182\192\109\79");
		end
	end
	if (v27.Outbreak:IsReady() and v7:IsSpellInRange(v27.Outbreak)) then
		if v36.CastCycle(v27.Outbreak, v48, v91, 779 - (396 + 343)) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\59\51\20\194\231\49\39\11\128\246\48\53\63\195\249\49\39\22\197\202\39\39\14\128\173", "\149\84\70\96\160");
		end
	end
	if (v27.AbominationLimb:IsCastable() and v7:IsInRange(2 + 18) and AbominationLimbSetting and ((v6:BuffDown(v27.GiftoftheSanlaynBuff) and v6:BuffDown(v27.SuddenDoomBuff) and v6:BuffUp(v27.FestermightBuff) and (v42 <= (1479 - (29 + 1448)))) or (v6:BuffUp(v27.GiftoftheSanlaynBuff) and (v53 < (1401 - (135 + 1254)))))) then
		if v17(v27.AbominationLimb) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\57\4\2\224\49\8\12\249\49\9\3\210\52\15\0\239\120\5\9\254\7\5\1\232\57\16\8\210\43\7\3\173\105\86", "\141\88\102\109");
		end
	end
end
local function v105()
	if v37.Commons.Enabled.Potions then
		local v220 = v36.PotionSelected();
		if (v220 and PotionSetting) then
			if (v220:IsReady() and (((v50 >= (3 - 2)) and (not v27.SummonGargoyle:IsAvailable() or (v27.SummonGargoyle:CooldownRemains() > (280 - 220))) and ((v13:BuffUp(v27.DarkTransformation) and ((20 + 10) >= v13:BuffRemains(v27.DarkTransformation))) or (v38.ArmyGhoulActive and (v38.ArmyGhoulRemains <= (1557 - (389 + 1138)))) or (v38.ApocGhoulActive and (v38.ApocGhoulRemains <= (604 - (102 + 472)))) or (v38.AbomActive and (v38.AbomRemains <= (29 + 1))))) or (v53 <= (17 + 13)))) then
				if v16.CastMacro(3 + 0, nil, nil, v220) then
					return LUAOBFUSACTOR_DECRYPT_STR_0("\163\92\222\121\21\51\21\201\186\84\194\79\10\47\92\206\140\82\201\100\19\50\91\210\243\1", "\161\211\51\170\16\122\93\53");
				end
			end
		end
	end
	if (v27.ArmyoftheDead:IsReady() and v7:IsInMeleeRange(1550 - (320 + 1225)) and ArmyOfTheDeadSetting and (((v38.STPlanning or v38.AddsRemain) and ((v27.CommanderoftheDead:IsAvailable() and (v27.DarkTransformation:CooldownRemains() < (8 - 3))) or (not v27.CommanderoftheDead:IsAvailable() and (v50 >= (1 + 0))))) or (v53 < (1499 - (157 + 1307))))) then
		if v17(v27.ArmyoftheDead) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\250\188\191\49\196\161\180\23\239\166\183\23\255\171\179\44\187\173\182\59\196\189\186\41\233\171\182\104\175", "\72\155\206\210");
		end
	end
	if (v27.RaiseAbomination:IsCastable() and v7:IsInMeleeRange(1864 - (821 + 1038)) and RaiseAbominationSetting and (v38.STPlanning or v38.AddsRemain or (v53 < (74 - 44)))) then
		if v17(v27.RaiseAbomination) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\84\123\93\29\54\121\123\86\1\62\79\116\85\26\58\73\116\20\13\55\85\69\71\6\50\84\127\80\78\101", "\83\38\26\52\110");
		end
	end
	if (v27.SummonGargoyle:IsReady() and v7:IsInMeleeRange(1 + 4) and SummonGargoyleSetting and (((v38.STPlanning or v38.AddsRemain) and (v6:BuffUp(v27.CommanderoftheDeadBuff) or (not v27.CommanderoftheDead:IsAvailable() and (v50 >= (1 - 0))))) or (v53 < (10 + 15)))) then
		if v17(v27.SummonGargoyle) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\75\2\42\75\87\25\24\65\89\5\32\73\65\27\34\6\91\19\52\121\75\31\38\84\93\19\103\30", "\38\56\119\71");
		end
	end
end
local function v106()
	if (v41:IsReady() and DnDSetting and not v6:DnDTicking() and v38.AddsRemain and (v27.Apocalypse:CooldownDown() or not v27.Apocalypse:IsAvailable())) then
		if v16.CastTarget(v27.DeathAndDecay, v16.TName().PLAYER) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\242\225\65\233\33\88\247\175\91\218\32\87\229\234\24\132", "\54\147\143\56\182\69");
		end
	end
	if (v27.DeathCoil:IsReady() and v7:IsSpellInRange(v27.DeathCoil) and not v38.PoolingRunicPower and v27.ImprovedDeathCoil:IsAvailable()) then
		if v17(v27.DeathCoil) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\210\132\254\93\215\233\130\240\64\211\150\130\243\76\222\192\132\191\29", "\191\182\225\159\41");
		end
	end
	if (v39:IsReady() and v7:IsInRange(WoundSpenderRange) and (v27.VampiricStrikeAction:IsLearned())) then
		if v17(v40) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\60\29\61\91\143\184\209\59\23\38\81\142\149\130\40\30\45\84\157\130\130\125", "\162\75\114\72\53\235\231");
		end
	end
	if (v27.DeathCoil:IsReady() and v7:IsSpellInRange(v27.DeathCoil) and not v38.PoolingRunicPower and not v27.ImprovedDeathCoil:IsAvailable()) then
		if v17(v27.DeathCoil) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\136\57\69\246\91\61\143\51\77\238\19\1\128\57\69\244\86\66\219", "\98\236\92\36\130\51");
		end
	end
	if (v43:IsReady() and v7:IsInMeleeRange(v44)) then
		if v36.CastTargetIf(v27.FesteringStrike, v48, LUAOBFUSACTOR_DECRYPT_STR_0("\169\16\2", "\80\196\121\108\218\37\200\213"), v70, v77, v44, false, false, false, true) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\6\118\17\107\78\28\131\14\116\61\108\95\28\131\11\118\66\124\71\11\139\22\118\66\39", "\234\96\19\98\31\43\110");
		end
	end
	if (v43:IsReady() and v7:IsInMeleeRange(v44)) then
		if v36.CastTargetIf(v27.FesteringStrike, v48, LUAOBFUSACTOR_DECRYPT_STR_0("\11\30\74", "\235\102\127\50\167\204\18"), v70, v79, v44, false, false, false, true) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\86\164\230\55\65\60\89\175\242\28\87\58\66\168\254\38\4\45\92\164\244\53\65\110\1\241", "\78\48\193\149\67\36");
		end
	end
	if (v39:IsReady() and v7:IsInRange(WoundSpenderRange) and (v42 >= (2 - 1)) and v38.PopWounds) then
		if v17(v40) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\39\17\149\22\69\15\13\144\29\79\52\27\146\88\66\60\27\129\14\68\112\79\210", "\33\80\126\224\120");
		end
	end
end
local function v107()
	if (v27.ArcaneTorrent:IsCastable() and v7:IsInRange(1034 - (834 + 192)) and RacialsSetting and (v6:RunicPower() < (2 + 18)) and (v6:Rune() < (1 + 1))) then
		if v17(v27.ArcaneTorrent) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\237\186\0\197\82\233\151\23\203\78\254\173\13\208\28\254\169\0\205\93\224\187\67\150", "\60\140\200\99\164");
		end
	end
	if (v27.BloodFury:IsCastable() and v7:IsInRange(1 + 4) and RacialsSetting and ((((v27.BloodFury:BaseDuration() + (4 - 1)) >= v38.GargRemains) and v38.GargActive) or ((not v27.SummonGargoyle:IsAvailable() or (v27.SummonGargoyle:CooldownRemains() > (364 - (300 + 4)))) and ((v38.ArmyGhoulActive and (v38.ArmyGhoulRemains <= (v27.BloodFury:BaseDuration() + 1 + 2))) or (v38.ApocGhoulActive and (v38.ApocGhoulRemains <= (v27.BloodFury:BaseDuration() + (7 - 4)))) or ((v50 >= (364 - (112 + 250))) and v6:DnDTicking()))) or (v53 <= (v27.BloodFury:BaseDuration() + 2 + 1)))) then
		if v17(v27.BloodFury) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\133\248\11\41\166\184\242\17\52\187\199\230\5\37\171\134\248\23\102\246", "\194\231\148\100\70");
		end
	end
	if (v27.Berserking:IsCastable() and v7:IsInRange(12 - 7) and RacialsSetting and ((((v27.Berserking:BaseDuration() + 2 + 1) >= v38.GargRemains) and v38.GargActive) or ((not v27.SummonGargoyle:IsAvailable() or (v27.SummonGargoyle:CooldownRemains() > (32 + 28))) and ((v38.ArmyGhoulActive and (v38.ArmyGhoulRemains <= (v27.Berserking:BaseDuration() + 3 + 0))) or (v38.ApocGhoulActive and (v38.ApocGhoulRemains <= (v27.Berserking:BaseDuration() + 2 + 1))) or ((v50 >= (2 + 0)) and v6:DnDTicking()))) or (v53 <= (v27.Berserking:BaseDuration() + (1417 - (1001 + 413)))))) then
		if v17(v27.Berserking) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\68\73\211\176\243\218\77\69\207\164\182\218\71\79\200\162\250\219\6\26", "\168\38\44\161\195\150");
		end
	end
	if (v27.LightsJudgment:IsCastable() and v7:IsInRange(11 - 6) and RacialsSetting and v6:BuffUp(v27.UnholyStrengthBuff) and (not v27.Festermight:IsAvailable() or (v6:BuffRemains(v27.FestermightBuff) < v7:TimeToDie()) or (v6:BuffRemains(v27.UnholyStrengthBuff) < v7:TimeToDie()))) then
		if v17(v27.LightsJudgment) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\140\245\133\126\36\251\137\28\149\248\133\123\53\230\162\86\146\253\129\127\49\228\165\86\216", "\118\224\156\226\22\80\136\214");
		end
	end
	if (v27.AncestralCall:IsCastable() and v7:IsInRange(887 - (244 + 638)) and RacialsSetting and ((((694 - (627 + 66)) >= v38.GargRemains) and v38.GargActive) or ((not v27.SummonGargoyle:IsAvailable() or (v27.SummonGargoyle:CooldownRemains() > (178 - 118))) and ((v38.ArmyGhoulActive and (v38.ArmyGhoulRemains <= (620 - (512 + 90)))) or (v38.ApocGhoulActive and (v38.ApocGhoulRemains <= (1924 - (1665 + 241)))) or ((v50 >= (719 - (373 + 344))) and v6:DnDTicking()))) or (v53 <= (9 + 9)))) then
		if v17(v27.AncestralCall) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\67\224\90\133\81\250\75\129\78\209\90\129\78\226\25\146\67\237\80\129\78\253\25\209\18", "\224\34\142\57");
		end
	end
	if (v27.ArcanePulse:IsCastable() and v7:IsInRange(3 + 5) and RacialsSetting and ((v50 >= (5 - 3)) or ((v6:Rune() <= (1 - 0)) and (v6:RunicPowerDeficit() >= (1159 - (35 + 1064)))))) then
		if v17(v27.ArcanePulse) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\223\181\198\220\125\244\98\30\203\171\214\216\51\227\92\13\215\166\201\206\51\160\15", "\110\190\199\165\189\19\145\61");
		end
	end
	if (v27.Fireblood:IsCastable() and v7:IsInRange(4 + 1) and RacialsSetting and ((((v27.Fireblood:BaseDuration() + (6 - 3)) >= v38.GargRemains) and v38.GargActive) or ((not v27.SummonGargoyle:IsAvailable() or (v27.SummonGargoyle:CooldownRemains() > (1 + 59))) and ((v38.ArmyGhoulActive and (v38.ArmyGhoulRemains <= (v27.Fireblood:BaseDuration() + (1239 - (298 + 938))))) or (v38.ApocGhoulActive and (v38.ApocGhoulRemains <= (v27.Fireblood:BaseDuration() + (1262 - (233 + 1026))))) or ((v50 >= (1668 - (636 + 1030))) and v6:DnDTicking()))) or (v53 <= (v27.Fireblood:BaseDuration() + 2 + 1)))) then
		if v17(v27.Fireblood) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\220\226\101\237\137\203\213\228\115\168\153\198\217\226\118\228\152\135\139\191", "\167\186\139\23\136\235");
		end
	end
	if (v27.BagofTricks:IsCastable() and v7:IsInRange(5 + 0) and RacialsSetting and (v50 <= (1 + 0)) and (v6:BuffUp(v27.UnholyStrengthBuff) or (v53 < (1 + 4)))) then
		if v17(v27.BagofTricks) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\24\180\143\50\21\179\183\25\8\188\139\6\9\245\154\12\25\188\137\1\9\245\217\91", "\109\122\213\232");
		end
	end
end
local function v108()
	if (v27.AntiMagicShell:IsCastable() and v37.Commons.UseAMSAMZOffensively and (v37.Unholy.AMSAbsorbPercent > (221 - (55 + 166))) and (v6:RunicPower() < (8 + 32))) then
		if v17(v27.AntiMagicShell) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\239\249\182\57\227\246\165\57\237\200\177\56\235\251\174\112\253\246\172\15\232\254\177\56\231\249\165\112\188", "\80\142\151\194");
		end
	end
	if (v39:IsReady() and v7:IsInRange(WoundSpenderRange) and (v6:BuffUp(v27.InflictionofSorrowBuff))) then
		if v17(v40) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\20\201\98\66\7\249\100\92\6\200\115\73\17\134\100\77\13\249\113\69\16\206\126\66\4\134\36", "\44\99\166\23");
		end
	end
	if (v41:IsReady() and DnDSetting and v6:BuffDown(v27.DeathAndDecayBuff) and not v27.VampiricStrikeAction:IsLearned()) then
		if v16.CastTarget(v27.DeathAndDecay, v16.TName().PLAYER) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\125\249\48\9\55\170\120\183\58\55\61\155\122\254\58\62\58\170\123\183\125", "\196\28\151\73\86\83");
		end
	end
	if (v27.DeathCoil:IsReady() and v7:IsSpellInRange(v27.DeathCoil) and v6:BuffUp(v27.SuddenDoomBuff) and v27.DoomedBidding:IsAvailable()) then
		if v17(v27.DeathCoil) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\247\6\40\4\138\103\27\121\250\15\105\3\131\86\39\112\250\16\33\25\140\95\88\32", "\22\147\99\73\112\226\56\120");
		end
	end
	if (v27.SoulReaper:IsReady() and v7:IsInMeleeRange(1 + 4) and ((v7:HealthPercentage() <= (133 - 98)) or (v7:TimeToX(332 - (36 + 261)) <= (8 - 3))) and (v7:TimeToDie() > (1373 - (34 + 1334)))) then
		if v17(v27.SoulReaper) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\171\122\247\249\178\170\112\227\229\136\170\53\241\244\131\135\115\235\230\133\177\123\229\181\213", "\237\216\21\130\149");
		end
	end
	if (v27.DeathCoil:IsReady() and v7:IsSpellInRange(v27.DeathCoil) and not v27.VampiricStrikeAction:IsLearned()) then
		if v17(v27.DeathCoil) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\134\75\94\75\184\246\93\141\71\83\31\163\200\80\189\72\86\76\184\192\80\133\14\14\15", "\62\226\46\63\63\208\169");
		end
	end
	if (v39:IsReady() and v7:IsInRange(WoundSpenderRange) and (v42 >= (1 + 0)) and (((v42 >= ((3 + 0) - v20(v38.AbomActive))) and (v27.Apocalypse:CooldownRemains() > v38.ApocTiming)) or v27.VampiricStrikeAction:IsLearned())) then
		if v17(v40) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\242\22\64\141\27\50\60\78\224\23\81\134\13\77\60\95\235\38\83\138\12\5\38\80\226\89\4\209", "\62\133\121\53\227\127\109\79");
		end
	end
	if (v43:IsReady() and v7:IsInMeleeRange(v44) and (v42 < ((1286 - (1035 + 248)) - v20(v38.AbomActive)))) then
		if v17(v27.FesteringStrike) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\22\17\33\225\211\188\171\30\19\13\230\194\188\171\27\17\114\230\215\160\157\22\29\33\253\223\160\165\80\69\102", "\194\112\116\82\149\182\206");
		end
	end
end
local function v109()
	if (v41:IsReady() and DnDSetting and v6:BuffDown(v27.DeathAndDecayBuff) and v27.UnholyGround:IsAvailable() and (v27.DarkTransformation:CooldownRemains() < (26 - (20 + 1)))) then
		if v16.CastTarget(v27.DeathAndDecay, v16.TName().PLAYER) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\56\166\85\39\196\236\10\121\187\77\22\255\241\26\121\249", "\110\89\200\44\120\160\130");
		end
	end
	if (v39:IsReady() and v7:IsInRange(WoundSpenderRange) and (v6:BuffUp(v27.InflictionofSorrowBuff))) then
		if v17(v40) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\188\204\94\72\71\117\40\93\174\205\79\67\81\10\40\76\165\252\88\82\3\24", "\45\203\163\43\38\35\42\91");
		end
	end
	if (v27.DeathCoil:IsReady() and v7:IsSpellInRange(v27.DeathCoil) and ((v6:BuffUp(v27.SuddenDoomBuff) and v6:BuffUp(v27.GiftoftheSanlaynBuff) and (v27.DoomedBidding:IsAvailable() or v27.RottenTouch:IsAvailable())) or ((v6:Rune() < (2 + 1)) and v6:BuffDown(v27.RunicCorruptionBuff)))) then
		if v17(v27.DeathCoil) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\214\128\221\55\143\150\87\221\140\208\99\148\168\90\237\150\200\99\212", "\52\178\229\188\67\231\201");
		end
	end
	if (v39:IsReady() and v7:IsInRange(WoundSpenderRange) and ((v6:BuffUp(v27.GiftoftheSanlaynBuff) and v27.VampiricStrikeAction:IsLearned()) or (v27.GiftoftheSanlayn:IsAvailable() and v13:BuffUp(v27.DarkTransformation) and (v13:BuffRemains(v27.DarkTransformation) < v6:GCD())))) then
		if v17(v40) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\54\78\69\10\243\99\48\49\68\94\0\242\78\99\50\64\94\59\228\72\99\117", "\67\65\33\48\100\151\60");
		end
	end
	if (v27.SoulReaper:IsReady() and v7:IsInMeleeRange(324 - (134 + 185)) and ((v7:HealthPercentage() <= (1168 - (549 + 584))) or (v7:TimeToX(720 - (314 + 371)) <= (17 - 12))) and (v7:TimeToDie() > (973 - (478 + 490))) and v6:BuffDown(v27.GiftoftheSanlaynBuff)) then
		if v17(v27.SoulReaper) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\204\232\187\212\204\205\226\175\200\246\205\167\189\217\253\224\244\186\152\165", "\147\191\135\206\184");
		end
	end
	if (v39:IsReady() and v27.VampiricStrikeAction:IsLearned() and (v42 >= (1 + 0))) then
		if v17(v40) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\147\39\179\207\220\108\161\148\45\168\197\221\65\242\151\41\168\254\203\71\242\211", "\210\228\72\198\161\184\51");
		end
	end
	if (v43:IsReady() and v7:IsInMeleeRange(v44) and (((v42 == (1172 - (786 + 386))) and (v27.Apocalypse:CooldownRemains() < v38.ApocTiming)) or (((v27.GiftoftheSanlayn:IsAvailable() and v6:BuffDown(v27.GiftoftheSanlaynBuff)) or not v27.GiftoftheSanlayn:IsAvailable()) and (v6:BuffUp(v27.FesteringScytheBuff) or (v42 <= (3 - 2)))))) then
		if v17(v27.FesteringStrike) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\48\76\224\4\118\220\63\71\244\47\96\218\36\64\248\21\51\221\55\71\204\3\103\142\110", "\174\86\41\147\112\19");
		end
	end
	if (v39:IsReady() and v7:IsInRange(WoundSpenderRange) and (v42 >= (1380 - (1055 + 324))) and (not v27.Apocalypse:IsAvailable() or (v27.Apocalypse:CooldownRemains() > v38.ApocTiming) or not ApocalypseSetting) and ((v42 >= ((1343 - (1093 + 247)) - v20(v38.AbomActive))) or v27.VampiricStrikeAction:IsLearned())) then
		if v17(v40) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\76\15\152\5\33\48\2\187\94\14\137\14\55\79\2\170\85\63\158\31\101\94\65", "\203\59\96\237\107\69\111\113");
		end
	end
	if (v27.DeathCoil:IsReady() and v7:IsSpellInRange(v27.DeathCoil) and ((not v38.PoolingRunicPower and (v7:DebuffRemains(v27.DeathRotDebuff) < v6:GCD())) or (v6:BuffUp(v27.SuddenDoomBuff) and (v42 >= (1 + 0))) or (v6:Rune() < (1 + 1)))) then
		if v17(v27.DeathCoil) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\32\19\173\245\57\207\212\43\31\160\161\34\241\217\27\5\184\161\96\162", "\183\68\118\204\129\81\144");
		end
	end
	if (v39:IsReady() and v7:IsInRange(WoundSpenderRange) and (v42 >= (3 - 2)) and (v42 > (13 - 9))) then
		if v17(v40) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\25\162\101\234\15\189\29\189\117\234\15\135\28\237\99\229\5\189\29\185\48\181\95", "\226\110\205\16\132\107");
		end
	end
	if (v27.DeathCoil:IsReady() and v7:IsSpellInRange(v27.DeathCoil) and not v38.PoolingRunicPower) then
		if v17(v27.DeathCoil) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\239\198\225\205\73\212\192\239\208\77\171\208\225\215\126\248\215\160\136\23", "\33\139\163\128\185");
		end
	end
end
local function v110()
	if (v37.Commons.Enabled.Items and v28.Fyralath:IsReady() and v7:DebuffUp(v27.MarkofFyralathDebuff) and ((v50 < (14 - 9)) or (v50 > (52 - 31)) or (v53 < (2 + 2))) and (v38.AbomActive or v38.ArmyGhoulActive or (not v27.RaiseAbomination:IsAvailable() and not v27.ArmyoftheDead:IsAvailable()) or (v3.CombatTime() > (57 - 42)))) then
		v16.CastMacro(3 - 2, nil, nil, v28.Fyralath);
		return LUAOBFUSACTOR_DECRYPT_STR_0("\81\65\22\223\91\89\16\214\104\76\12\219\104\92\22\219\86\85\22\219\89\92\1\204\23\75\5\208\104\76\22\215\89\83\1\202\68\24\86", "\190\55\56\100");
	end
	if v37.Commons.Enabled.Trinkets then
		if (v28.TreacherousTransmitter:IsEquippedAndReady() and (((v38.Trinket1ID == v28.TreacherousTransmitter:ID()) and Trinket1Setting) or ((v38.Trinket2ID == v28.TreacherousTransmitter:ID()) and Trinket2Setting)) and v7:IsInMeleeRange(4 + 1) and (v38.AddsRemain or v38.STPlanning) and (v27.DarkTransformation:CooldownRemains() < (25 - 15))) then
			if v17(v28.TreacherousTransmitter, nil) then
				return LUAOBFUSACTOR_DECRYPT_STR_0("\66\189\57\31\16\235\246\68\160\41\13\44\247\225\87\161\47\19\26\247\231\83\189\124\13\18\237\204\66\189\53\16\24\230\231\69\239\110", "\147\54\207\92\126\115\131");
			end
		end
		if (v31:IsReady() and Trinket1Setting and not v38.Trinket1Ex and not v6:IsItemBlacklisted(v31) and ((v38.Trinket1Buffs and v13:BuffUp(v27.DarkTransformation) and (v13:BuffRemains(v27.DarkTransformation) < (v38.Trinket1Duration * (688.73 - (364 + 324)))) and ((v38.TrinketPriority == (2 - 1)) or v32:CooldownDown() or not v32:HasCooldown())) or (v38.Trinket1Duration >= v53))) then
			if v17(v31, true) then
				return LUAOBFUSACTOR_DECRYPT_STR_0("\42\52\59\120\31\119\14\113\32\110\8\65\4\37\48\112\77\120\2\35\117", "\30\109\81\85\29\109") .. v31:Name() .. LUAOBFUSACTOR_DECRYPT_STR_0("\191\98\85\184\9\202\238\246\127\95\179\34\205\188\171", "\156\159\17\52\214\86\190");
			end
		end
		if (v32:IsReady() and Trinket2Setting and not v38.Trinket2Ex and not v6:IsItemBlacklisted(v32) and ((v38.Trinket2Buffs and v13:BuffUp(v27.DarkTransformation) and (v13:BuffRemains(v27.DarkTransformation) < (v38.Trinket2Duration * (0.73 - 0))) and ((v38.TrinketPriority == (1 + 1)) or v31:CooldownDown() or not v31:HasCooldown())) or (v38.Trinket2Duration >= v53))) then
			if v17(v32, true) then
				return LUAOBFUSACTOR_DECRYPT_STR_0("\137\234\179\185\188\230\190\252\187\252\184\131\167\251\184\177\238\233\178\174\238", "\220\206\143\221") .. v32:Name() .. LUAOBFUSACTOR_DECRYPT_STR_0("\198\110\44\25\231\216\192\143\115\38\18\204\223\146\208", "\178\230\29\77\119\184\172");
			end
		end
		if (v31:IsReady() and Trinket1Setting and not v38.Trinket1Ex and not v6:IsItemBlacklisted(v31) and ((not v38.Trinket1Buffs and (((v38.Trinket1CastTime > (0 - 0)) and v6:BuffDown(v27.GiftoftheSanlaynBuff)) or (v38.Trinket1CastTime == (0 - 0))) and ((v38.DamageTrinketPriority == (2 - 1)) or v32:CooldownDown() or not v32:HasCooldown() or (not v27.SummonGargoyle:IsAvailable() and not v27.ArmyoftheDead:IsAvailable() and not v27.RaiseAbomination:IsAvailable()) or (not v27.SummonGargoyle:IsAvailable() and v27.ArmyoftheDead:IsAvailable() and ((not v27.RaiseAbomination:IsAvailable() and (v27.ArmyoftheDead:CooldownRemains() > (1288 - (1249 + 19)))) or (v27.RaiseAbomination:IsAvailable() and (v27.RaiseAbomination:CooldownRemains() > (19 + 1))))) or (not v27.SummonGargoyle:IsAvailable() and not v27.ArmyoftheDead:IsAvailable() and not v27.RaiseAbomination:IsAvailable() and (v27.DarkTransformation:CooldownRemains() > (77 - 57))) or (v27.SummonGargoyle:IsAvailable() and (v27.SummonGargoyle:CooldownRemains() > (1106 - (686 + 400))) and not v38.GargActive))) or (v53 < (12 + 3)))) then
			if v17(v31, true) then
				return LUAOBFUSACTOR_DECRYPT_STR_0("\210\187\4\30\101\241\246\254\31\8\114\199\252\170\15\22\55\254\250\172\74", "\152\149\222\106\123\23") .. v31:Name() .. LUAOBFUSACTOR_DECRYPT_STR_0("\157\53\247\77\138\201\52\255\77\190\216\50\229\3\237", "\213\189\70\150\35");
			end
		end
		if (v32:IsReady() and Trinket2Setting and not v38.Trinket2Ex and not v6:IsItemBlacklisted(v32) and ((not v38.Trinket2Buffs and (((v38.Trinket2CastTime > (229 - (73 + 156))) and v6:BuffDown(v27.GiftoftheSanlaynBuff)) or (v38.Trinket2CastTime == (0 + 0))) and ((v38.DamageTrinketPriority == (813 - (721 + 90))) or v31:CooldownDown() or not v31:HasCooldown() or (not v27.SummonGargoyle:IsAvailable() and not v27.ArmyoftheDead:IsAvailable() and not v27.RaiseAbomination:IsAvailable()) or (not v27.SummonGargoyle:IsAvailable() and v27.ArmyoftheDead:IsAvailable() and ((not v27.RaiseAbomination:IsAvailable() and (v27.ArmyoftheDead:CooldownRemains() > (1 + 19))) or (v27.RaiseAbomination:IsAvailable() and (v27.RaiseAbomination:CooldownRemains() > (64 - 44))))) or (not v27.SummonGargoyle:IsAvailable() and not v27.ArmyoftheDead:IsAvailable() and not v27.RaiseAbomination:IsAvailable() and (v27.DarkTransformation:CooldownRemains() > (490 - (224 + 246)))) or (v27.SummonGargoyle:IsAvailable() and (v27.SummonGargoyle:CooldownRemains() > (32 - 12)) and not v38.GargActive))) or (v53 < (27 - 12)))) then
			if v17(v32, true) then
				return LUAOBFUSACTOR_DECRYPT_STR_0("\104\80\122\13\93\92\119\72\90\70\113\55\70\65\113\5\15\83\123\26\15", "\104\47\53\20") .. v32:Name() .. LUAOBFUSACTOR_DECRYPT_STR_0("\227\95\128\18\131\27\177\69\143\23\185\27\176\12\208\76", "\111\195\44\225\124\220");
			end
		end
	end
	local v190 = v6:GetUseableItems(v29, 3 + 13, true);
	if (v37.Commons.Enabled.Items and WeaponSetting and v190 and v7:IsInMeleeRange(1 + 4) and ((not v38.Trinket1Buffs and not v38.Trinket2Buffs) or ((v31:CooldownRemains() > (15 + 5)) and not v38.Trinket2Buffs) or ((v32:CooldownRemains() > (39 - 19)) and not v38.Trinket1Buffs) or ((v31:CooldownRemains() > (66 - 46)) and (v32:CooldownRemains() > (533 - (203 + 310))))) and v13:BuffUp(v27.DarkTransformation) and (v13:BuffRemains(v27.DarkTransformation) > (2003 - (1238 + 755))) and ((not v27.RaiseAbomination:IsAvailable() and not v27.ArmyoftheDead:IsAvailable()) or (not v27.RaiseAbomination:IsAvailable() and v27.ArmyoftheDead:IsAvailable() and v38.ArmyGhoulActive) or (v27.RaiseAbomination:IsAvailable() and v38.AbomActive) or v38.Trinket1Buffs or v38.Trinket2Buffs or (v53 < (2 + 13)))) then
		v16.CastMacro(1535 - (709 + 825), nil, nil);
		return v190:Name() .. LUAOBFUSACTOR_DECRYPT_STR_0("\152\113\5\114\187\164\214\6\81\33", "\203\184\38\96\19\203");
	end
end
local function v111()
	if (v27.SoulReaper:IsReady() and v7:IsInMeleeRange(8 - 3) and ((v7:HealthPercentage() <= (50 - 15)) or (v7:TimeToX(899 - (196 + 668)) <= (19 - 14))) and (v7:TimeToDie() > (10 - 5))) then
		if v17(v27.SoulReaper) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\42\124\108\77\241\43\118\120\81\203\43\51\106\85\142\107", "\174\89\19\25\33");
		end
	end
	if (v39:IsReady() and v7:IsInMeleeRange(v44) and v7:DebuffUp(v27.TrollbaneSlowDebuff)) then
		if v17(v40) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\56\29\71\64\243\184\24\63\23\92\74\242\149\75\60\6\18\26", "\107\79\114\50\46\151\231");
		end
	end
	if (v41:IsReady() and DnDSetting and v27.UnholyGround:IsAvailable() and v6:BuffDown(v27.DeathAndDecayBuff) and (v38.ApocGhoulActive or v38.AbomActive or v38.GargActive)) then
		if v16.CastTarget(v27.DeathAndDecay, v16.TName().PLAYER) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\56\168\172\22\142\55\179\128\42\178\245\127", "\160\89\198\213\73\234\89\215");
		end
	end
	if (v27.DeathCoil:IsReady() and v7:IsSpellInRange(v27.DeathCoil) and ((not v38.PoolingRunicPower and v38.SpendRP) or (v53 < (843 - (171 + 662))))) then
		if v17(v27.DeathCoil) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\76\116\181\234\205\119\114\187\247\201\8\98\160\190\157", "\165\40\17\212\158");
		end
	end
	if (v43:IsReady() and v7:IsInMeleeRange(v44) and (v42 < (97 - (4 + 89))) and (not v38.PopWounds or v6:BuffUp(v27.FesteringScytheBuff))) then
		if v17(v27.FesteringStrike) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\227\220\27\39\35\247\208\6\52\25\246\205\26\58\45\224\153\27\39\102\180\137", "\70\133\185\104\83");
		end
	end
	if (v39:IsReady() and v7:IsInRange(WoundSpenderRange) and (v42 >= (3 - 2)) and v38.PopWounds) then
		if v17(v40) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\19\74\81\36\205\59\86\84\47\199\0\64\86\106\218\16\5\21\120", "\169\100\37\36\74");
		end
	end
	if (v27.DeathCoil:IsReady() and v7:IsSpellInRange(v27.DeathCoil) and not v38.PoolingRunicPower) then
		if v17(v27.DeathCoil) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\4\130\163\68\8\184\161\95\9\139\226\67\20\199\243\4", "\48\96\231\194");
		end
	end
	if (v39:IsReady() and v7:IsInRange(WoundSpenderRange) and (v42 >= (1 + 0)) and not v38.PopWounds and (v42 >= (17 - 13))) then
		if v17(v40) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\223\85\27\35\29\231\188\147\205\84\10\40\11\152\188\151\136\11\88", "\227\168\58\110\77\121\184\207");
		end
	end
end
local function v112()
	if (v37.Commons.Enabled.Items and WeaponSetting and v28.Fyralath:IsReady() and v7:DebuffUp(v27.MarkofFyralathDebuff) and ((v50 < (2 + 3)) or (v50 > (1507 - (35 + 1451))) or (v53 < (1457 - (28 + 1425)))) and (v38.AbomActive or v38.ArmyGhoulActive or (not v27.RaiseAbomination:IsAvailable() and not v27.ArmyoftheDead:IsAvailable()) or (v3.CombatTime() > (2008 - (941 + 1052))))) then
		v16.CastMacro(1 + 0, nil, nil, v28.Fyralath);
		return LUAOBFUSACTOR_DECRYPT_STR_0("\108\57\190\80\190\213\49\166\122\47\171", "\197\27\92\223\32\209\187\17");
	end
	if v37.Commons.Enabled.Trinkets then
		if (v28.TreacherousTransmitter:IsEquippedAndReady() and (((v38.Trinket1ID == v28.TreacherousTransmitter:ID()) and Trinket1Setting) or ((v38.Trinket2ID == v28.TreacherousTransmitter:ID()) and Trinket2Setting)) and v7:IsInMeleeRange(1519 - (822 + 692)) and (v38.AddsRemain or v38.STPlanning) and (v27.DarkTransformation:CooldownRemains() < (14 - 4))) then
			if v17(v28.TreacherousTransmitter, nil) then
				return LUAOBFUSACTOR_DECRYPT_STR_0("\23\77\198\250\0\87\198\233\12\74\208\196\23\77\194\245\16\82\202\239\23\90\209\187\16\94\205\196\23\77\202\245\8\90\215\232\67\13", "\155\99\63\163");
			end
		end
		if (v31:IsReady() and Trinket1Setting and not v38.Trinket1Ex and not v6:IsItemBlacklisted(v31) and ((v38.Trinket1Buffs and ((v38.TrinketPriority == (1 + 0)) or not v32:HasCooldown() or ((v32:CooldownRemains() > (317 - (45 + 252))) and ((not v27.Apocalypse:IsAvailable() and v13:BuffUp(v27.DarkTransformation)) or (v38.ApocGhoulActive and (v38.ApocGhoulRemains <= v38.Trinket1Duration) and (v38.ApocGhoulRemains > (5 + 0))))))) or (v53 <= v38.Trinket1Duration))) then
			if v17(v31, true) then
				return LUAOBFUSACTOR_DECRYPT_STR_0("\165\212\175\136\171\141\129\145\180\158\188\187\139\197\164\128\249\130\141\195\225", "\228\226\177\193\237\217") .. v31:Name() .. LUAOBFUSACTOR_DECRYPT_STR_0("\116\164\49\239\58\187\38\242\39\240\119", "\134\84\208\67");
			end
		end
		if (v32:IsReady() and Trinket2Setting and not v38.Trinket2Ex and not v6:IsItemBlacklisted(v32) and ((v38.Trinket2Buffs and ((v38.TrinketPriority == (1 + 1)) or not v31:HasCooldown() or ((v31:CooldownRemains() > (48 - 28)) and ((not v27.Apocalypse:IsAvailable() and v13:BuffUp(v27.DarkTransformation)) or (v38.ApocGhoulActive and (v38.ApocGhoulRemains <= v38.Trinket2Duration) and (v38.ApocGhoulRemains > (438 - (114 + 319)))))))) or (v53 <= v38.Trinket2Duration))) then
			if v17(v32, true) then
				return LUAOBFUSACTOR_DECRYPT_STR_0("\52\169\136\89\1\165\133\28\6\191\131\99\26\184\131\81\83\170\137\78\83", "\60\115\204\230") .. v32:Name() .. LUAOBFUSACTOR_DECRYPT_STR_0("\167\46\249\121\233\49\238\100\244\122\189", "\16\135\90\139");
			end
		end
	end
end
local function v113()
	v38.STPlanning = (v50 <= (1 - 0)) or not v19();
	v38.AddsRemain = (v50 >= (2 - 0)) and (v54 > (4 + 2));
	v38.ApocTiming = ((v27.Apocalypse:CooldownRemains() < (7 - 2)) and (v42 < (1 - 0)) and (v27.UnholyAssault:CooldownRemains() > (1968 - (556 + 1407))) and (1209 - (741 + 465))) or (465 - (170 + 295));
	v38.PopWounds = (((v27.Apocalypse:CooldownRemains() > v38.ApocTiming) or not v27.Apocalypse:IsAvailable() or not ApocalypseSetting) and (((v42 >= (1 + 0)) and (v27.UnholyAssault:CooldownRemains() < (19 + 1)) and v27.UnholyAssault:IsAvailable() and v38.STPlanning) or (v7:DebuffUp(v27.RottenTouchDebuff) and (v42 >= (2 - 1))) or (v42 >= ((4 + 0) - v20(v38.AbomActive))))) or ((v53 < (4 + 1)) and (v42 >= (1 + 0)));
	v38.PoolingRunicPower = v27.VileContagion:IsAvailable() and (v27.VileContagion:CooldownRemains() < (1235 - (957 + 273))) and (v6:RunicPower() < (9 + 21));
	v38.SpendRP = (not v27.RottenTouch:IsAvailable() or (v27.RottenTouch:IsAvailable() and v7:DebuffDown(v27.RottenTouchDebuff)) or (v6:RunicPowerDeficit() < (9 + 11))) and ((v27.ImprovedDeathCoil:IsAvailable() and ((v50 == (7 - 5)) or v27.CoilofDevastation:IsAvailable())) or (v6:Rune() < (7 - 4)) or v38.GargActive or v6:BuffUp(v27.SuddenDoomBuff) or (not v38.PopWounds and (v42 >= (11 - 7))));
end
local function v114()
	DarkTransformationSetting = v56(v37.Unholy.DarkTransformationSetting) and v58(v37.TTD.DarkTransformationTTD) and v7:IsInMeleeRange(24 - 19);
	RacialsSetting = v56(v37.Unholy.RacialsSetting) and v58(v37.TTD.RacialsTTD) and v7:IsInMeleeRange(1785 - (389 + 1391));
	Trinket1Setting = v56(v37.Unholy.Trinket1Setting) and v58(v37.TTD.TrinketsTTD);
	Trinket2Setting = v56(v37.Unholy.Trinket2Setting) and v58(v37.TTD.TrinketsTTD);
	PotionSetting = v56(v37.Unholy.PotionSetting) and v58(19 + 11, true) and not v36.ISSolo();
	ApocalypseSetting = v56(v37.Unholy.ApocalypseSetting) and v58(v37.TTD.ApocalypseTTD) and v7:IsInMeleeRange(1 + 4);
	UnholyAssaultSetting = v56(v37.Unholy.UnholyAssaultSetting) and v58(v37.TTD.UnholyAssaultTTD) and v7:IsInMeleeRange(11 - 6);
	AbominationLimbSetting = v56(v37.Unholy.AbominationLimbSetting) and not IsNpcNearPlayer() and v58(v37.TTD.AbominationLimbTTD) and not NoNPCAvailable(v68) and v7:IsInMeleeRange(966 - (783 + 168));
	EmpowerRuneWeaponSetting = v56(v37.Unholy.EmpowerRuneWeaponSetting) and v58(v37.TTD.EmpowerRuneWeaponTTD) and v7:IsInMeleeRange(16 - 11);
	UnholyBlightSetting = v56(v37.Unholy.UnholyBlightSetting) and v58(v37.TTD.UnholyBlightTTD);
	SummonGargoyleSetting = v56(v37.Unholy.SummonGargoyleSetting) and v58(v37.TTD.SummonGargoyleTTD);
	RaiseAbominationSetting = v56(v37.Unholy.RaiseAbominationSetting) and v58(v37.TTD.RaiseAbominationTTD);
	ArmyOfTheDeadSetting = v56(v37.Unholy.ArmyOfTheDeadSetting) and v58(40 + 0);
	WeaponSetting = v56(v37.Unholy.Weapon);
end
local function v115()
	if v6:IsChanneling(v28.ManicGrieftorch.ItemUseSpell) then
		return LUAOBFUSACTOR_DECRYPT_STR_0("\112\123\8\39\14\87\109\64\52\50\60\92\87\112", "\24\52\20\102\83\46\52");
	end
	v48 = v6:GetEnemiesInMeleeRange(319 - (309 + 2));
	v51 = v7:GetEnemiesInSplashRange(30 - 20);
	if v19() then
		v49 = #v48;
		v52 = v7:GetEnemiesInSplashRangeCount(1222 - (1090 + 122));
	else
		v49 = 1 + 0;
		v52 = 3 - 2;
	end
	v50 = v23(v49, v52);
	DnDSetting = v16.ToggleIconFrame:GetToggle(3 + 0) and ((v49 >= (1119 - (628 + 490))) or v7:IsInRange(2 + 6)) and (v37.Commons.DnDMoving or not v6:IsMoving()) and v58(19 - 11);
	SmallCDToggle = v16.ToggleIconFrame:GetToggle(4 - 3);
	InterruptToggle = v16.ToggleIconFrame:GetToggle(776 - (431 + 343));
	v38.AbomActive = v55:AbomActive();
	v38.AbomRemains = v55:AbomRemains();
	v38.ApocGhoulActive = v27.Apocalypse:TimeSinceLastCast() <= (30 - 15);
	v38.ApocGhoulRemains = (v38.ApocGhoulActive and ((43 - 28) - v27.Apocalypse:TimeSinceLastCast())) or (0 + 0);
	v38.ArmyGhoulActive = v27.ArmyoftheDead:TimeSinceLastCast() <= (4 + 26);
	v38.ArmyGhoulRemains = (v38.ArmyGhoulActive and ((1725 - (556 + 1139)) - v27.ArmyoftheDead:TimeSinceLastCast())) or (15 - (6 + 9));
	v38.GargActive = v55:GargActive();
	v38.GargRemains = v55:GargRemains();
	v38.SanCoilMult = ((v6:BuffStack(v27.EssenceoftheBloodQueenBuff) >= (1 + 3)) and (2 + 0)) or (170 - (28 + 141));
	v38.EpidemicTargets = 2 + 1 + v20(v27.ImprovedDeathCoil:IsAvailable()) + v20(v27.FrenziedBloodthirst:IsAvailable() and v38.SanCoilMult) + v20(v27.HungeringThirst:IsAvailable() and v27.HarbingerofDoom:IsAvailable() and v6:BuffUp(v27.SuddenDoomBuff));
	v42 = v7:DebuffStack(v27.FesteringWoundDebuff);
	if v27.FesteringScytheAction:IsLearned() then
		v43 = v27.FesteringScytheAction;
		v44 = 16 - 2;
	else
		v43 = v27.FesteringStrike;
		v44 = 4 + 1;
	end
	v39 = (v27.VampiricStrikeAction:IsLearned() and v27.VampiricStrikeAction) or (v27.ClawingShadows:IsAvailable() and v27.ClawingShadows) or v27.ScourgeStrike;
	v40 = (v27.ClawingShadows:IsAvailable() and v27.ClawingShadows) or v27.ScourgeStrike;
	v114();
	if (v36.TargetIsValid() or v6:AffectingCombat()) then
		v53 = v3.BossFightRemains();
		IsBossfight = true;
		v54 = v53;
		if (v54 == (12428 - (486 + 831))) then
			IsBossfight = false;
			v54 = v3.FightRemains(v48, false);
		end
		v41 = (v27.Defile:IsAvailable() and v27.Defile) or v27.DeathAndDecay;
		WoundSpenderRange = ((v27.ClawingShadows:IsAvailable() or v27.VampiricStrikeAction:IsAvailable()) and (78 - 48)) or (17 - 12);
	end
	if v27.RaiseDead:IsCastable() then
		if v17(v27.RaiseDead) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\214\46\40\55\10\251\43\36\37\11\132\63\51\33\12\203\34\35\37\27\132\125", "\111\164\79\65\68");
		end
	end
	if (v27.RaiseAlly:IsReady() and v37.Commons.RaiseAlly) then
		if (v8:UnitIsFriend() and v8:UnitIsPlayer() and v8:Exists() and v8:IsDeadOrGhost()) then
			v16.CastTarget(v27.RaiseAlly, v16.TName().MOUSEOVER);
			return LUAOBFUSACTOR_DECRYPT_STR_0("\244\216\138\205\43\170\231\213\143\199\110\229\200\153\174\209\59\249\195\214\149\219\60", "\138\166\185\227\190\78");
		end
		if (v7:UnitIsFriend() and v7:UnitIsPlayer() and v7:Exists() and v7:IsDeadOrGhost()) then
			v16.Cast(v27.RaiseAlly);
			return LUAOBFUSACTOR_DECRYPT_STR_0("\249\117\204\36\87\99\56\199\120\220\119\93\45\89\255\117\215\48\87\55", "\121\171\20\165\87\50\67");
		end
	end
	if (v36.TargetIsValid() and (v7:AffectingCombat() or v37.Commons.AttackOutOfCombat)) then
		if not v6:AffectingCombat() then
			local v225 = v96();
			if v225 then
				return v225;
			end
		end
		if (v27.DeathStrike:IsReady() and v66()) then
			if v17(v27.DeathStrike) then
				return LUAOBFUSACTOR_DECRYPT_STR_0("\194\61\184\34\177\61\213\44\171\63\178\7\134\52\182\33\249\10\214\120\182\36\249\18\212\55\186", "\98\166\88\217\86\217");
			end
		end
		if v6:AffectingCombat() then
			if (v27.IceboundFortitude:IsCastable() and (v6:HealthPercentage() <= v37.Unholy.Defensives.IceboundFortitudeHP)) then
				if v17(v27.IceboundFortitude, false) then
					return LUAOBFUSACTOR_DECRYPT_STR_0("\255\245\124\3\137\201\248\242\70\7\137\206\226\255\109\20\130\217\182\242\124\7\131\210\229\255\111\4\149", "\188\150\150\25\97\230");
				end
			end
			if (v27.AntiMagicShell:IsCastable() and (v6:HealthPercentage() <= v37.Unholy.Defensives.AntiMagicShellHP)) then
				if v17(v27.AntiMagicShell, false) then
					return LUAOBFUSACTOR_DECRYPT_STR_0("\251\135\75\11\33\236\221\128\92\49\4\232\214\133\31\6\9\235\223\135\76\11\26\232\201", "\141\186\233\63\98\108");
				end
			end
			if (v27.AntiMagicZone:IsCastable() and (v6:HealthPercentage() <= v37.Unholy.Defensives.AntiMagicZoneHP)) then
				if v17(v27.AntiMagicZone, false) then
					return LUAOBFUSACTOR_DECRYPT_STR_0("\208\228\56\191\8\240\237\37\181\31\254\228\41\246\33\244\236\41\184\54\248\252\41\165", "\69\145\138\76\214");
				end
			end
			if (v27.Lichborne:IsCastable() and (v6:HealthPercentage() <= v37.Unholy.Defensives.LichborneHP)) then
				if v17(v27.Lichborne, false) then
					return LUAOBFUSACTOR_DECRYPT_STR_0("\92\198\138\129\189\25\98\193\140\201\187\19\118\202\135\154\182\0\117\220", "\118\16\175\233\233\223");
				end
			end
		end
		if InterruptToggle then
			v33 = v36.InterruptCycle(v27.MindFreeze, (137 + 588) - ((651 - 445) + (1767 - (668 + 595))), true, nil, false);
			if v33 then
				return v33;
			end
			if v37.Commons.BlindingSleet then
				v33 = v36.InterruptCycle(v27.BlindingSleet, 9 + 0 + 1 + 2, true, nil, true, true);
				if v33 then
					return v33;
				end
			end
			v33 = v36.InterruptCycle(v27.Asphyxiate, (188 - 119) - (339 - (23 + 267)), true, nil, true);
			if v33 then
				return v33;
			end
		end
		if not v7:IsInRange((2800 - (1129 + 815)) - ((960 - (371 + 16)) + (2023 - (1326 + 424)))) then
			if (v27.Outbreak:IsReady() and v7:IsSpellInRange(v27.Outbreak) and v94(v7)) then
				if v17(v27.Outbreak) then
					return LUAOBFUSACTOR_DECRYPT_STR_0("\132\145\33\185\252\142\124\128\196\58\174\250\180\114\141\187\39\186\224\140\120", "\29\235\228\85\219\142\235");
				end
			end
			if (v27.Epidemic:IsReady() and v7:IsInRange((518 - 244) - ((621 - 451) + (182 - (88 + 30)))) and (v27.VirulentPlagueDebuff:AuraActiveCount() >= v38.EpidemicTargets) and not v38.PoolingRunicPower) then
				if v17(v27.Epidemic) then
					return LUAOBFUSACTOR_DECRYPT_STR_0("\56\196\179\217\114\67\46\81\125\219\175\201\72\65\33\109\47\213\180\218\114", "\50\93\180\218\189\23\46\71");
				end
			end
			if (v27.DeathCoil:IsReady() and v7:IsSpellInRange(v27.DeathCoil) and (v27.VirulentPlagueDebuff:AuraActiveCount() < v38.EpidemicTargets) and not v38.PoolingRunicPower) then
				if v17(v27.DeathCoil) then
					return LUAOBFUSACTOR_DECRYPT_STR_0("\218\161\90\88\76\227\75\209\173\87\12\75\201\92\225\171\93\115\86\221\70\217\161", "\40\190\196\59\44\36\188");
				end
			end
		end
		v113();
		if v27.VampiricStrike:IsAvailable() then
			local v226 = v110();
			if v226 then
				return v226;
			end
		end
		if ((v37.Commons.Enabled.Trinkets or v37.Commons.Enabled.Items) and not v27.VampiricStrike:IsAvailable()) then
			local v227 = v112();
			if v227 then
				return v227;
			end
		end
		if true then
			local v228 = v107();
			if v228 then
				return v228;
			end
		end
		if true then
			local v229 = v105();
			if v229 then
				return v229;
			end
		end
		if (v27.VampiricStrike:IsAvailable() and (v50 >= ((773 - (720 + 51)) + (2 - 1)))) then
			local v230 = v102();
			if v230 then
				return v230;
			end
		end
		if (not v27.VampiricStrike:IsAvailable() and (v50 >= ((3418 - (421 + 1355)) - ((2353 - 926) + 105 + 108)))) then
			local v231 = v101();
			if v231 then
				return v231;
			end
		end
		if (v27.VampiricStrike:IsAvailable() and (v50 == ((2953 - (286 + 797)) - ((3461 - 2514) + (1525 - 604))))) then
			local v232 = v104();
			if v232 then
				return v232;
			end
		end
		if (v27.VampiricStrike:IsAvailable() and ((v50 <= ((440 - (397 + 42)) + 0 + 0)) or not v19())) then
			local v233 = v103();
			if v233 then
				return v233;
			end
		end
		if (not v27.VampiricStrike:IsAvailable() and ((v50 <= ((803 - (24 + 776)) - (2 - 0))) or not v19())) then
			local v234 = v100();
			if v234 then
				return v234;
			end
		end
		if (v50 ~= ((787 - (222 + 563)) + (0 - 0))) then
		else
			local v235 = v106();
			if v235 then
				return v235;
			end
		end
		if ((v50 >= ((7 + 2) - (196 - (23 + 167)))) and not v6:DnDTicking() and (v41:CooldownRemains() < ((1808 - (690 + 1108)) + 0 + 0))) then
			local v236 = v99();
			if v236 then
				return v236;
			end
		end
		if ((v50 >= (2 + 0 + (849 - (40 + 808)))) and (v6:DnDTicking() or (v6:BuffUp(v27.DeathAndDecayBuff) and (v27.FesteringWoundDebuff:AuraActiveCount() >= (v50 * ((0.5 + 0) - (0 - 0))))))) then
			local v237 = v98();
			if v237 then
				return v237;
			end
		end
		if ((v50 >= (1 + 0 + 2 + 0)) and v6:BuffDown(v27.DeathAndDecayBuff)) then
			local v238 = v97();
			if v238 then
				return v238;
			end
		end
		if (((v50 <= (1 + 0 + (571 - (47 + 524)))) or not v19()) and v27.GiftoftheSanlayn:IsAvailable() and v27.DarkTransformation:CooldownDown() and v6:BuffDown(v27.GiftoftheSanlaynBuff) and (v6:BuffRemains(v27.EssenceoftheBloodQueenBuff) < (v27.DarkTransformation:CooldownRemains() + ((792 + 427) - ((207 - 131) + (1704 - 564)))))) then
			local v239 = v108();
			if v239 then
				return v239;
			end
			if v16.CastAnnotated(v27.Pool, false, LUAOBFUSACTOR_DECRYPT_STR_0("\11\100\245\128", "\109\92\37\188\212\154\29")) then
				return LUAOBFUSACTOR_DECRYPT_STR_0("\52\224\171\207\113\92\11\253\228\240\48\84\34\230\183\203\56\84\3\167\237", "\58\100\143\196\163\81");
			end
		end
		if (((v50 <= ((4 - 2) - (1727 - (1165 + 561)))) or not v19()) and v27.VampiricStrike:IsAvailable()) then
			local v240 = v109();
			if v240 then
				return v240;
			end
		end
		if (((v50 <= (1 + 0 + (0 - 0))) or not v19()) and not v27.VampiricStrike:IsAvailable()) then
			local v241 = v111();
			if v241 then
				return v241;
			end
		end
		if (v43:IsReady() and v7:IsInMeleeRange(v44) and (v6:Rune() >= (1 + 1 + (483 - (341 + 138))))) then
			if v17(v27.FesteringStrike) then
				return LUAOBFUSACTOR_DECRYPT_STR_0("\28\71\48\183\58\91\236\0\29\125\48\183\45\64\238\11\90\67\45\183\54\9\230\15\10", "\110\122\34\67\195\95\41\133");
			end
		end
		if (v39:IsReady() and v7:IsInRange(WoundSpenderRange) and not v7:IsInMeleeRange((6 + 14) - (24 - 12)) and (v42 >= ((327 - (89 + 237)) - (0 - 0)))) then
			if v17(v40) then
				return LUAOBFUSACTOR_DECRYPT_STR_0("\66\190\78\68\210\53\130\75\79\216\113\180\73\10\249\90\131", "\182\21\209\59\42");
			end
		end
		if v16.CastAnnotated(v27.Pool, false, LUAOBFUSACTOR_DECRYPT_STR_0("\128\118\236\41", "\222\215\55\165\125\65")) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\60\222\201\22\205\211\232\89\35\196\212\25\247\210", "\42\76\177\166\122\146\161\141");
		end
	end
end
local function v116()
	v27.VirulentPlagueDebuff:RegisterAuraTracking();
	v27.FesteringWoundDebuff:RegisterAuraTracking();
	v27.MarkofFyralathDebuff:RegisterAuraTracking();
	v37.Unholy.Display();
	v16:UpdateMacro(LUAOBFUSACTOR_DECRYPT_STR_0("\168\139\6\220\118\39", "\22\197\234\101\174\25"), LUAOBFUSACTOR_DECRYPT_STR_0("\98\33\182\217\54\254\129", "\230\77\84\197\188\22\207\183"));
	v16:UpdateMacro(LUAOBFUSACTOR_DECRYPT_STR_0("\244\21\197\238\131\243", "\85\153\116\166\156\236\193\144"), LUAOBFUSACTOR_DECRYPT_STR_0("\235\244\76\161\227\5\176\160\118\147\233\15\177\243\72\188\242\5\182\221", "\96\196\128\45\211\132"));
	v16.Print(LUAOBFUSACTOR_DECRYPT_STR_0("\0\131\115\80\222\182\244\252\30\205\105\80\198\174\160\209\58\131", "\184\85\237\27\63\178\207\212"));
end
v16.SetAPL((1254 - 658) - (1225 - (581 + 300)), v115, v116);
