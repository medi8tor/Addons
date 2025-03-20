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
local v8 = v3.Spell;
local v9 = v3.Item;
local v10 = HeroRotation();
local v11 = v10.Cast;
local v12 = v10.AoEON;
local v13 = v10.CDsON;
local v14 = v10.Commons().Everyone.num;
local v15 = v10.Commons().Everyone.bool;
local v16 = C_Timer.After;
local v17;
local v18 = v8.Warrior.Arms;
local v19 = v9.Warrior.Arms;
local v20 = {v19.TreacherousTransmitter:ID(),v19.Fyralath:ID()};
local v21 = v10.Commons().Everyone;
local v22 = v10.GUISettingsGet();
local v23 = {[LUAOBFUSACTOR_DECRYPT_STR_0("\246\198\213\32\244\186\203", "\126\177\163\187\69\134\219\167")]=v22.General,[LUAOBFUSACTOR_DECRYPT_STR_0("\0\194\39\200\243\45\222", "\156\67\173\74\165")]=v22.APL.Warrior.Commons,[LUAOBFUSACTOR_DECRYPT_STR_0("\21\165\68\5", "\38\84\215\41\118\220\70")]=v22.APL.Warrior.Arms,[LUAOBFUSACTOR_DECRYPT_STR_0("\113\4\47\1\193\116\19\36\23\240\67\31\52\23\237", "\158\48\118\66\114")]=v22.APL.Warrior.Arms.Defensives,[LUAOBFUSACTOR_DECRYPT_STR_0("\138\54\29\37\76\145\207\143", "\155\203\68\112\86\19\197")]=v22.APL.Warrior.Arms_TTD,[LUAOBFUSACTOR_DECRYPT_STR_0("\103\207\59\239\127\91\193\205\117\248", "\152\38\189\86\156\32\24\133")]=v22.APL.Warrior.Arms_CDUSE,[LUAOBFUSACTOR_DECRYPT_STR_0("\213\89\179\67\238\69\178\86\232", "\38\156\55\199")]=v22.APL.Warrior.Arms_Interrupt.Interrupt};
local v24, v25;
local v26, v27;
local v28, v29;
local v30, v31;
local v32, v33;
local v34, v35;
local v36, v37;
local v38, v39;
local v40, v41;
local v42, v43;
local v44;
local v45, v46, v47;
local v48;
local v49, v50;
local v51 = 11702 - (426 + 165);
local v52 = 8893 + 2218;
local v53 = 0 - 0;
local function v54()
	local v77, v78 = v6:GetTrinketData(v20);
	if ((v53 < (14 - 9)) and ((v77.ID == (0 - 0)) or (v78.ID == (0 - 0)) or ((v77.SpellID > (1248 - (111 + 1137))) and not v77.Usable) or ((v78.SpellID > (158 - (91 + 67))) and not v78.Usable))) then
		v53 = v53 + (2 - 1);
		v16(2 + 3, function()
			v54();
		end);
		return;
	end
	v24 = v77.Object;
	v25 = v78.Object;
	v26 = v77.Spell;
	v28 = v77.Range;
	v30 = v77.CastTime;
	v27 = v78.Spell;
	v29 = v78.Range;
	v31 = v78.CastTime;
	v32 = v77.Cooldown;
	v33 = v78.Cooldown;
	v34 = v77.Blacklisted;
	v35 = v78.Blacklisted;
	v36 = v77.ID == v19.TreacherousTransmitter:ID();
	v37 = v78.ID == v19.TreacherousTransmitter:ID();
	v38 = 523.5 - (423 + 100);
	if (v24:HasUseBuff() and ((v32 % (1 + 89)) == (0 - 0))) then
		v38 = 1 + 0;
	end
	v39 = 771.5 - (326 + 445);
	if (v25:HasUseBuff() and ((v33 % (392 - 302)) == (0 - 0))) then
		v39 = 2 - 1;
	end
	v40 = v24:HasUseBuff() or (v24:HasStatAnyDps() and not v36);
	v41 = v25:HasUseBuff() or (v25:HasStatAnyDps() and not v37);
	local v91 = ((v24:BuffDuration() > (711 - (530 + 181))) and v24:BuffDuration()) or (882 - (614 + 267));
	local v92 = ((v25:BuffDuration() > (32 - (19 + 13))) and v25:BuffDuration()) or (1 - 0);
	v44 = 2 - 1;
	if ((not v40 and v41) or (v41 and (((v33 / v92) * v39) > ((v32 / v91) * v38)))) then
		v44 = 5 - 3;
	end
	v42 = v77.ID == v19.AlgetharPuzzleBox:ID();
	v43 = v78.ID == v19.AlgetharPuzzleBox:ID();
end
v54();
local v55 = {{v18.StormBolt,LUAOBFUSACTOR_DECRYPT_STR_0("\139\124\111\60\83\71\238\76\186\112\60\10\28\120\238\3\224\84\114\60\22\102\232\86\184\105\53", "\35\200\29\28\72\115\20\154"),function()
	return true;
end}};
v3:RegisterForEvent(function()
	v51 = 22669 - 11558;
	v52 = 29010 - 17899;
end, LUAOBFUSACTOR_DECRYPT_STR_0("\41\147\240\230\168\30\11\43\154\246\250\163\19\17\55\158\243\243\168\8", "\84\121\223\177\191\237\76"));
v3:RegisterForEvent(function()
	v53 = 0 - 0;
	v54();
end, LUAOBFUSACTOR_DECRYPT_STR_0("\139\122\232\153\31\98\15\228\138\99\224\144\23\117\30\245\132\117\225\129\20\119\21\229", "\161\219\54\169\192\90\48\80"));
local function v56(v93)
	return v93:HealthPercentage();
end
local function v57(v94)
	return v94:NPCID() == (882084 - 677524);
end
local v58;
local function v59()
	return v19.ManicGrieftorch:IsEquipped() and (v19.ManicGrieftorch:CooldownUp() or (v19.ManicGrieftorch:CooldownRemains() <= v6:GCDRemains()));
end
local function v60()
	return v19.AlgetharPuzzleBox:IsEquipped() and (v19.AlgetharPuzzleBox:CooldownUp() or (v19.AlgetharPuzzleBox:CooldownRemains() <= v6:GCDRemains()));
end
local function v61(v95)
	return (v95 ~= LUAOBFUSACTOR_DECRYPT_STR_0("\103\77\20\101\124\81\5\33", "\69\41\34\96")) and ((((v95 == LUAOBFUSACTOR_DECRYPT_STR_0("\171\202\195\2\66\8\179\204\219\14\13\60\178\208", "\75\220\163\183\106\98")) or ((v95 == LUAOBFUSACTOR_DECRYPT_STR_0("\17\183\138\59\213\66\153\175\36", "\185\98\218\235\87")) and v23.Arms_CDUSE.smallcdswithCooldowns) or (v95 == LUAOBFUSACTOR_DECRYPT_STR_0("\220\53\51\238\158\137\196\51\43\226\209\189\197\47\103\233\204\234\234\51\2", "\202\171\92\71\134\190")) or (v95 == LUAOBFUSACTOR_DECRYPT_STR_0("\38\207\108\173\39\196\33\145\42\206\57\134\61\129\35\154\105\226\35\135\37\197\35\159\39\210", "\232\73\161\76")) or (v95 == LUAOBFUSACTOR_DECRYPT_STR_0("\180\215\2\127\17\168\202\2\82\12\251\206\75\73\22\251\250\77\82\18\191\214\85\83\13", "\126\219\185\34\61"))) and v13()) or (v95 == LUAOBFUSACTOR_DECRYPT_STR_0("\13\194\73\115\103\100", "\135\108\174\62\18\30\23\147")) or (((v95 == LUAOBFUSACTOR_DECRYPT_STR_0("\185\231\106\233\23\189\32\135\185\231\38\210", "\167\214\137\74\171\120\206\83")) or (v95 == LUAOBFUSACTOR_DECRYPT_STR_0("\132\254\114\127\247\180\152\176\61\79\184\168\133\176\23\83\253\170\146\243\61\72\246\179", "\199\235\144\82\61\152")) or (v95 == LUAOBFUSACTOR_DECRYPT_STR_0("\8\24\249\9\8\5\170\107\8\4\249\60\14\2\177\107\36\25\182\39\3\25\174\37\20", "\75\103\118\217"))) and (v58 or v7:IsDummy())) or ((v95 == LUAOBFUSACTOR_DECRYPT_STR_0("\208\93\100\28\249\60\203\91\127\16\181\11\212\64\48\27\183\18\222", "\126\167\52\16\116\217")) and v6:BloodlustUp()) or ((v95 == LUAOBFUSACTOR_DECRYPT_STR_0("\219\35\33\140\184\89\223\236\61", "\156\168\78\64\224\212\121")) and Smallcds) or (((v95 == LUAOBFUSACTOR_DECRYPT_STR_0("\8\224\229\239\40\203", "\174\103\142\197")) or (v95 == LUAOBFUSACTOR_DECRYPT_STR_0("\65\33\75\48\101\125\247\89\36\91\55\50\80\235\22\39\77\120\4\81\221", "\152\54\72\63\88\69\62"))) and (v50 > (4 - 2)) and v12()) or (((v95 == LUAOBFUSACTOR_DECRYPT_STR_0("\219\202\174\121\218\193\227\69\215\203\251\82\192\132\225\78\148\231\225\83\216\192\225\75\218\215", "\60\180\164\142")) or (v95 == LUAOBFUSACTOR_DECRYPT_STR_0("\87\80\69\12\41\232\31\65\93\10\60\41\249", "\114\56\62\101\73\71\141")) or (v95 == LUAOBFUSACTOR_DECRYPT_STR_0("\183\231\155\230\183\250\200\132\183\251\155\203\182\169\254\202\189\228\194\199\183\252\213\208", "\164\216\137\187"))) and (v50 >= v23.Arms_CDUSE.Enemycount) and v12()));
end
local function v62(v96)
	return (v58 and v23.Arms_TTD.IgnoreWhenBoss) or v21.Buggedmobs[v7:NPCID()] or (v21.ISSolo() and v23.Arms_TTD.IgnoreWhenSolo) or (v96 == (0 + 0)) or ((v52 >= v96) and (v52 < (1587 + 6190)));
end
local function v63()
	if (v18.VictoryRush:IsCastable() and v48 and v6:CanAttack(v7) and v6:BuffUp(v18.VictoriousBuff) and (v6:HealthPercentage() <= v23.Arms.Defensives.VictoryRushHP)) then
		if v11(v18.VictoryRush) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\228\239\50\166\169\236\18\224\243\34\186", "\107\178\134\81\210\198\158");
		end
	end
	if (v18.ImpendingVictory:IsCastable() and v48 and v6:CanAttack(v7) and (v6:HealthPercentage() <= v23.Arms.Defensives.ImpendingVictoryHP)) then
		if v11(v18.ImpendingVictory) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\17\3\146\195\164\60\7\140\193\156\49\13\150\201\184\33", "\202\88\110\226\166");
		end
	end
	if (v18.BitterImmunity:IsCastable() and v6:AffectingCombat() and (v6:HealthPercentage() <= v23.Arms.Defensives.BitterImmunityHP)) then
		if v11(v18.BitterImmunity) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\225\6\150\227\207\209\38\143\250\223\205\6\150\238", "\170\163\111\226\151");
		end
	end
	if (v18.DiebytheSword:IsCastable() and v6:AffectingCombat() and (v6:HealthPercentage() <= v23.Arms.Defensives.DiebytheSwordHP)) then
		if v11(v18.DiebytheSword) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\53\57\183\58\87\35\33\20\3\165\55\92\51", "\73\113\80\210\88\46\87");
		end
	end
	if (v18.IgnorePain:IsReady() and v6:AffectingCombat() and (((v23.Arms_Defensives.IgnorePainUse == LUAOBFUSACTOR_DECRYPT_STR_0("\142\34\141\58\215", "\135\225\76\173\114")) and (v6:HealthPercentage() <= v23.Arms_Defensives.IgnorePainHP)) or ((v23.Arms_Defensives.IgnorePainUse == LUAOBFUSACTOR_DECRYPT_STR_0("\21\227\248\149\162\184\170\3\238\183\165\162\169", "\199\122\141\216\208\204\221")) and (v50 >= v23.Arms_Defensives.IgnorePainEnemycount)) or ((v23.Arms_Defensives.IgnorePainUse == LUAOBFUSACTOR_DECRYPT_STR_0("\162\211\80\213\118\243\160\196\19\255\109\248\185\157\17\254\124\182\133\237", "\150\205\189\112\144\24")) and (v6:HealthPercentage() <= v23.Arms_Defensives.IgnorePainHP) and (v50 >= v23.Arms_Defensives.IgnorePainEnemycount)))) then
		if v11(v18.IgnorePain) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\12\131\177\67\22\141\33\17\44\138", "\112\69\228\223\44\100\232\113");
		end
	end
	if AutoStance then
		if (v18.DefensiveStance:IsCastable() and v6:BuffUp(v18.BattleStance) and (v6:HealthPercentage() <= v23.Arms_Defensives.DefStanceHP)) then
			if v11(v18.DefensiveStance) then
				return LUAOBFUSACTOR_DECRYPT_STR_0("\246\26\6\193\144\115\148\217", "\230\180\127\103\179\214\28");
			end
		end
		if (v18.BattleStance:IsCastable() and v6:BuffUp(v18.DefensiveStance) and (v6:HealthPercentage() > v23.Arms_Defensives.BattleStanceHP) and (v23.Arms_Defensives.BattleStanceHP > (0 - 0))) then
			if v11(v18.BattleStance) then
				return LUAOBFUSACTOR_DECRYPT_STR_0("\161\10\80\72\239\72\238\170\10\77\75", "\128\236\101\63\38\132\33");
			end
		end
	end
end
local function v64()
	if v48 then
		if (v18.Skullsplitter:IsCastable() and v48) then
			if v11(v18.Skullsplitter) then
				return LUAOBFUSACTOR_DECRYPT_STR_0("\191\162\4\72\186\248\223\160\160\5\80\179\249\143\188\187\20\71\185\230\205\173\189\81\28", "\175\204\201\113\36\214\139");
			end
		end
		if (v18.ColossusSmash:IsCastable() and v48 and IsColossusSmash) then
			if v11(v18.ColossusSmash, true) then
				return LUAOBFUSACTOR_DECRYPT_STR_0("\68\195\57\211\23\84\217\38\227\23\74\205\38\212\68\87\222\48\223\11\74\206\52\200\68\22\156", "\100\39\172\85\188");
			end
		end
		if (v18.Warbreaker:IsCastable() and v7:IsInMeleeRange(2 + 6) and IsColossusSmash) then
			if v11(v18.Warbreaker, true) then
				return LUAOBFUSACTOR_DECRYPT_STR_0("\186\121\171\130\33\168\121\178\133\33\237\104\171\133\48\162\117\187\129\39\237\41\235", "\83\205\24\217\224");
			end
		end
		if (v18.Overpower:IsCastable() and v48) then
			if v11(v18.Overpower) then
				return LUAOBFUSACTOR_DECRYPT_STR_0("\233\211\200\47\246\202\218\56\244\133\221\47\227\198\194\48\228\196\217\125\183\145", "\93\134\165\173");
			end
		end
	end
end
local function v65()
	if (v18.Cleave:IsReady() and v48 and (v7:DebuffDown(v18.DeepWoundsDebuff))) then
		if v11(v18.Cleave) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\189\254\196\195\44\203\242\125\177\254\206\209\41\219\161\65\191\253\196\130\104", "\30\222\146\161\162\90\174\210");
		end
	end
	if (v18.ThunderClap:IsReady() and v48 and (v7:DebuffDown(v18.RendDebuff))) then
		if v11(v18.ThunderClap) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\241\70\101\4\225\75\98\53\230\66\113\26\165\77\127\6\234\93\99\31\246\113\113\5\224\14\36", "\106\133\46\16");
		end
	end
	if (v18.ThunderousRoar:IsCastable() and v7:IsInMeleeRange(4 + 8) and IsThunderousRoar) then
		if v11(v18.ThunderousRoar, true) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\76\40\102\242\94\69\74\47\102\239\101\82\87\33\97\188\89\79\84\47\96\239\79\83\103\33\124\249\26\22", "\32\56\64\19\156\58");
		end
	end
	if (v18.Avatar:IsCastable() and v48 and IsAvatar) then
		if v11(v18.Avatar, true) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\91\222\228\66\91\224\192\89\199\233\89\73\225\149\73\247\228\89\95\178\216", "\224\58\168\133\54\58\146");
		end
	end
	if (v18.SweepingStrikes:IsCastable() and v7:IsInMeleeRange(5 + 3)) then
		if v11(v18.SweepingStrikes) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\74\65\78\248\101\143\137\12\102\69\95\239\124\141\130\24\25\85\68\241\122\149\148\30\74\105\74\242\112\198\214\89", "\107\57\54\43\157\21\230\231");
		end
	end
	if (IsBladestorm and v48 and v18.Ravager:IsCastable()) then
		if v10.CastTarget(v18.Ravager, v10.TName().PLAYER) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\201\138\7\244\190\217\221\155\136\30\249\182\207\220\206\152\46\244\182\217\143\138\223", "\175\187\235\113\149\217\188");
		end
	end
	if (v18.Warbreaker:IsCastable() and v7:IsInRange(1104 - (709 + 387)) and IsColossusSmash) then
		if v11(v18.Warbreaker, true) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\43\174\147\78\241\124\121\55\170\147\12\224\118\116\51\188\146\89\240\70\121\51\170\193\29\181", "\24\92\207\225\44\131\25");
		end
	end
	if (v18.ChampionsSpear:IsCastable() and v48 and IsChampionsSpear) then
		if v10.CastTarget(v18.ChampionsSpear, v10.TName().PLAYER) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\72\219\185\65\11\116\68\221\171\115\8\109\78\210\170\12\24\114\71\220\171\95\14\110\116\210\183\73\91\47\27", "\29\43\179\216\44\123");
		end
	end
	if (v18.ColossusSmash:IsCastable() and v48 and IsColossusSmash) then
		if v11(v18.ColossusSmash, true) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\190\214\44\67\174\202\53\95\130\202\45\77\174\209\96\79\178\213\47\95\174\204\51\115\188\214\37\12\239\139", "\44\221\185\64");
		end
	end
	if (v18.Cleave:IsReady() and v48) then
		if v11(v18.Cleave) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\2\235\77\94\101\4\167\75\80\127\14\244\91\74\96\62\230\71\90\51\83\179", "\19\97\135\40\63");
		end
	end
	if (v18.Bladestorm:IsCastable() and v48 and IsBladestorm and (v18.Unhinged:IsAvailable() or v18.MercilessBonegrinder:IsAvailable())) then
		if v11(v18.Bladestormcast, true) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\172\80\50\63\42\34\186\83\33\54\111\50\161\80\60\40\60\36\189\99\50\52\42\113\252\4", "\81\206\60\83\91\79");
		end
	end
	if (v18.ThunderClap:IsReady() and v48 and (v7:DebuffRemains(v18.RendDebuff) < (1863 - (673 + 1185)))) then
		if v11(v18.ThunderClap) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\90\163\197\124\43\198\95\155\77\167\209\98\111\192\66\168\65\184\195\103\60\252\76\171\75\235\130\38", "\196\46\203\176\18\79\163\45");
		end
	end
	if (v18.Demolish:IsCastable() and IsDemolish and not v6:IsMoving() and v48 and (v6:BuffStack(v18.ColossalMightBuff) == (29 - 19)) and ((v7:DebuffRemains(v18.ColossusSmashDebuff) >= (6 - 4)) or (v18.ColossusSmash:CooldownRemains() >= (10 - 3)))) then
		if v11(v18.Demolish) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\188\39\115\17\40\242\252\176\98\125\17\40\244\252\171\55\109\33\37\244\234\248\112\40", "\143\216\66\30\126\68\155");
		end
	end
	if (v18.Overpower:IsCastable() and v48 and (v18.Dreadnaught:IsAvailable())) then
		if v11(v18.Overpower) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\165\222\8\217\213\172\192\228\184\136\14\196\201\172\196\242\191\219\50\202\202\166\151\178\250", "\129\202\168\109\171\165\195\183");
		end
	end
	if (v18.MortalStrike:IsReady() and v48) then
		if v11(v18.MortalStrike) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\47\87\37\204\223\24\217\49\76\37\209\213\17\166\33\87\59\215\205\7\243\49\103\54\215\219\84\181\112", "\134\66\56\87\184\190\116");
		end
	end
	if (v18.Overpower:IsCastable() and v48) then
		if v11(v18.Overpower) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\51\39\12\169\9\228\54\48\46\113\10\180\21\228\50\38\41\34\54\186\22\238\97\102\104", "\85\92\81\105\219\121\139\65");
		end
	end
	if (v18.ThunderClap:IsReady() and v48) then
		if v11(v18.ThunderClap) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\233\187\69\75\120\218\239\140\83\73\125\207\189\176\95\73\115\204\238\166\67\122\125\208\248\243\3\29", "\191\157\211\48\37\28");
		end
	end
	if (v18.Skullsplitter:IsCastable() and v48) then
		if v11(v18.Skullsplitter, true) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\204\20\225\16\54\204\15\248\21\46\203\26\230\92\57\208\19\251\15\41\202\12\203\29\53\218\95\167\74", "\90\191\127\148\124");
		end
	end
	if (v18.Execute:IsReady() and v48) then
		if v11(v18.Executecast) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\125\159\43\20\109\147\43\87\123\136\34\24\107\148\59\4\71\134\33\18\56\211\124", "\119\24\231\78");
		end
	end
	if (v18.Bladestorm:IsCastable() and v48 and IsBladestorm) then
		if v11(v18.Bladestormcast, true) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\128\33\164\78\217\83\5\141\63\168\10\223\79\29\141\62\182\95\207\127\16\141\40\229\30\136", "\113\226\77\197\42\188\32");
		end
	end
	if (v18.Whirlwind:IsReady() and v48) then
		if v11(v18.Whirlwind) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\45\30\253\167\54\1\253\187\62\86\247\186\54\25\231\166\47\5\203\180\53\19\180\225\108", "\213\90\118\148");
		end
	end
end
local function v66()
	if (v18.SweepingStrikes:IsCastable() and (v50 == (2 + 0)) and v48) then
		if v11(v18.SweepingStrikes) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\72\57\177\83\93\82\32\179\105\94\79\60\189\93\72\72\110\183\89\65\84\61\167\67\94\100\43\172\83\78\78\58\177\22\31", "\45\59\78\212\54");
		end
	end
	if (v18.Rend:IsCastable() and v48 and (v7:DebuffRemains(v18.RendDebuff) <= v6:GCD()) and not v18.Bloodletting:IsAvailable()) then
		if v11(v18.Rend) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\2\83\141\143\198\45\162\252\31\69\144\158\149\17\168\232\21\85\150\159\131\110\249", "\144\112\54\227\235\230\78\205");
		end
	end
	if (v18.ThunderousRoar:IsCastable() and v7:IsInMeleeRange(9 + 3) and IsThunderousRoar) then
		if v11(v18.ThunderousRoar, true) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\167\32\26\242\212\94\161\39\26\239\239\73\188\41\29\188\211\84\191\39\28\239\197\72\140\45\23\249\211\78\167\45\79\170", "\59\211\72\111\156\176");
		end
	end
	if (v18.ChampionsSpear:IsCastable() and v48 and IsChampionsSpear) then
		if v10.CastTarget(v18.ChampionsSpear, v10.TName().PLAYER) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\77\143\226\32\94\142\236\35\93\184\240\61\75\134\241\109\77\136\239\34\93\148\246\62\113\130\251\40\77\146\247\40\14\223", "\77\46\231\131");
		end
	end
	if (v18.Ravager:IsCastable() and v48 and IsBladestorm and (v18.ColossusSmash:CooldownRemains() <= v6:GCD())) then
		if v10.CastTarget(v18.Ravager, v10.TName().PLAYER) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\168\85\160\65\189\81\164\0\185\91\186\79\169\71\163\83\133\81\174\69\185\65\162\69\250\5\230", "\32\218\52\214");
		end
	end
	if (v18.Avatar:IsCastable() and v48 and IsAvatar) then
		if v11(v18.Avatar, true) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\79\1\48\188\240\162\5\89\65\27\62\187\226\165\86\101\75\15\52\171\228\164\64\26\31\69", "\58\46\119\81\200\145\208\37");
		end
	end
	if (v18.ColossusSmash:IsCastable() and v48 and IsColossusSmash) then
		if v11(v18.ColossusSmash, true) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\40\131\60\163\186\174\35\56\179\35\161\168\174\62\107\143\63\160\166\174\37\62\159\15\169\177\184\53\62\152\53\236\248\233", "\86\75\236\80\204\201\221");
		end
	end
	if (v18.Warbreaker:IsCastable() and v7:IsInRange(10 - 2) and IsColossusSmash) then
		if v11(v18.Warbreaker, true) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\101\64\101\135\236\142\115\74\114\151\190\136\125\77\120\150\237\158\97\126\114\157\251\136\103\85\114\197\175\221", "\235\18\33\23\229\158");
		end
	end
	if (v18.Execute:IsReady() and v48 and (v6:BuffRemains(v18.JuggernautBuff) <= v6:GCD()) and v18.Juggernaut:IsAvailable()) then
		if v11(v18.Execute) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\85\162\196\184\69\174\196\251\83\181\205\180\67\169\212\168\111\191\217\190\83\175\213\190\16\235\153", "\219\48\218\161");
		end
	end
	if (v18.Skullsplitter:IsCastable() and v48 and (v6:Rage() < (10 + 30))) then
		if v11(v18.Skullsplitter) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\247\122\105\69\215\92\240\232\120\104\93\222\93\160\231\126\112\70\200\92\245\247\78\121\81\222\76\245\240\116\60\27\139", "\128\132\17\28\41\187\47");
		end
	end
	if (v18.Demolish:IsCastable() and IsDemolish and not v6:IsMoving() and v48 and (v7:DebuffUp(v18.ColossusSmashDebuff))) then
		if v11(v18.Demolish) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\5\55\11\53\81\8\33\14\122\94\14\62\9\41\78\20\33\57\63\69\4\49\19\46\88\65\99\94", "\61\97\82\102\90");
		end
	end
	if (v18.MortalStrike:IsReady() and v48 and (((v7:DebuffStack(v18.ExecutionersPrecisionDebuff) == (3 - 1)) and v7:DebuffDown(v18.RavagerDebuff)) or not v18.ExecutionersPrecision:IsAvailable() or (v18.Battlelord:IsAvailable() and v7:DebuffUp(v18.ExecutionersPrecisionDebuff)))) then
		if v11(v18.MortalStrike) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\161\33\185\95\198\91\33\26\184\60\162\64\194\23\29\6\160\33\184\88\210\68\33\12\180\43\168\94\211\82\94\91\252", "\105\204\78\203\43\167\55\126");
		end
	end
	if (v18.Overpower:IsReady() and v48 and (v6:Rage() < (176 - 86))) then
		if v11(v18.Overpower) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\170\188\38\12\3\11\208\84\183\234\32\17\31\11\212\66\176\185\28\27\11\1\196\68\177\175\99\76\69", "\49\197\202\67\126\115\100\167");
		end
	end
	if (v18.Execute:IsReady() and v48 and (v6:Rage() >= (1920 - (446 + 1434))) and v18.ExecutionersPrecision:IsAvailable()) then
		if v11(v18.Executecast) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\50\67\218\42\149\66\91\119\88\208\37\143\69\77\34\72\224\44\152\83\93\34\79\218\105\210\4", "\62\87\59\191\73\224\54");
		end
	end
	if (v18.Overpower:IsCastable() and v48) then
		if v11(v18.Overpower) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\232\20\255\219\247\13\237\204\245\66\249\198\235\13\233\218\242\17\197\204\255\7\249\220\243\7\186\155\177", "\169\135\98\154");
		end
	end
	if (v18.Bladestorm:IsCastable() and v48 and IsBladestorm) then
		if v11(v18.Bladestormcast, true) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\201\123\37\80\248\32\220\196\101\41\20\254\60\196\196\100\55\65\238\12\205\211\114\39\65\233\54\136\153\47", "\168\171\23\68\52\157\83");
		end
	end
	if (v18.Execute:IsReady() and v48) then
		if v11(v18.Executecast) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\241\105\240\174\48\57\130\180\114\250\161\42\62\148\225\98\202\168\61\40\132\225\101\240\237\118\125", "\231\148\17\149\205\69\77");
		end
	end
end
local function v67()
	if (v18.Rend:IsCastable() and v48 and (v7:DebuffRemains(v18.RendDebuff) <= v6:GCD())) then
		if v11(v18.Rend) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\146\162\201\255\23\252\143\171\200\232\68\234\147\152\212\239\23\173", "\159\224\199\167\155\55");
		end
	end
	if (v18.ThunderousRoar:IsCastable() and v7:IsInMeleeRange(1295 - (1040 + 243)) and IsThunderousRoar) then
		if v11(v18.ThunderousRoar, true) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\227\251\41\220\243\246\46\221\226\224\3\192\248\242\46\146\244\252\48\221\228\224\41\193\200\224\40\146\163", "\178\151\147\92");
		end
	end
	if (v18.Ravager:IsCastable() and v48 and IsBladestorm and (v18.ColossusSmash:CooldownRemains() <= v6:GCD())) then
		if v10.CastTarget(v18.Ravager, v10.TName().PLAYER) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\158\252\90\51\21\73\104\204\254\67\62\29\95\105\153\238\115\33\6\12\34", "\26\236\157\44\82\114\44");
		end
	end
	if (v18.ChampionsSpear:IsCastable() and v48 and IsChampionsSpear) then
		if v10.CastTarget(v18.ChampionsSpear, v10.TName().PLAYER) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\41\38\212\86\58\39\218\85\57\17\198\75\47\47\199\27\41\33\217\84\57\61\192\72\21\61\193\27\124", "\59\74\78\181");
		end
	end
	if (v18.Avatar:IsCastable() and v48 and IsAvatar) then
		if v11(v18.Avatar, true) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\36\199\91\78\178\55\145\89\85\191\42\194\73\79\160\26\194\78\26\226\117", "\211\69\177\58\58");
		end
	end
	if (v18.ColossusSmash:IsCastable() and v48 and IsColossusSmash) then
		if v11(v18.ColossusSmash, true) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\180\234\117\250\250\216\162\246\70\230\228\202\164\237\57\246\230\199\184\246\106\224\250\244\164\241\57\164\187", "\171\215\133\25\149\137");
		end
	end
	if (v18.Warbreaker:IsCastable() and v7:IsInRange(23 - 15) and IsColossusSmash) then
		if v11(v18.Warbreaker, true) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\246\201\32\248\253\53\253\73\228\218\114\249\224\60\243\81\242\221\33\197\252\36\188\19\181", "\34\129\168\82\154\143\80\156");
		end
	end
	if (v18.MortalStrike:IsReady() and v48) then
		if v11(v18.MortalStrike) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\136\189\33\31\73\66\182\150\166\33\2\67\75\201\134\189\63\4\91\93\156\150\141\32\31\8\31\223", "\233\229\210\83\107\40\46");
		end
	end
	if (v18.Demolish:IsCastable() and IsDemolish and not v6:IsMoving() and v48) then
		if v11(v18.Demolish) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\197\71\63\217\9\200\81\58\150\6\206\78\61\197\22\212\81\13\197\17\129\19\106", "\101\161\34\82\182");
		end
	end
	if (v18.Skullsplitter:IsCastable() and v7:IsInMeleeRange(1855 - (559 + 1288))) then
		if v11(v18.Skullsplitter) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\251\26\92\251\203\235\140\41\215\30\77\236\210\233\135\61\168\14\86\242\212\241\145\59\251\50\74\234\155\176\210", "\78\136\109\57\158\187\130\226");
		end
	end
	if (v18.Execute:IsReady() and v48) then
		if v11(v18.Executecast) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\59\39\252\242\43\43\252\177\61\48\245\254\45\44\236\226\1\44\237\177\108\107", "\145\94\95\153");
		end
	end
	if (v18.Overpower:IsCastable() and v48) then
		if v11(v18.Overpower) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\242\219\17\199\94\184\234\200\6\149\77\184\241\194\7\198\91\164\194\222\0\149\28\225", "\215\157\173\116\181\46");
		end
	end
	if (v18.Rend:IsCastable() and v48 and (v7:DebuffRemains(v18.RendDebuff) <= (v6:GCD() * (1936 - (609 + 1322))))) then
		if v11(v18.Rend) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\39\177\133\246\154\54\187\135\253\201\38\161\152\205\201\33\244\217\170", "\186\85\212\235\146");
		end
	end
	if (v18.Slam:IsCastable() and v48) then
		if v11(v18.Slam) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\209\141\23\243\121\237\87\206\142\5\237\44\253\103\209\149\86\173\105", "\56\162\225\118\158\89\142");
		end
	end
end
local function v68()
	if (v18.ThunderClap:IsReady() and v48 and v7:DebuffDown(v18.RendDebuff) and v6:BuffDown(v18.SweepingStrikes)) then
		if v11(v18.ThunderClap) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\72\13\213\161\38\221\78\58\195\163\35\200\28\6\207\163\45\203\79\16\211\144\49\207\89\0\208\239\112", "\184\60\101\160\207\66");
		end
	end
	if (v18.Rend:IsCastable() and v48 and (v7:DebuffRemains(v18.RendDebuff) <= v6:GCD()) and v6:BuffUp(v18.SweepingStrikesBuff)) then
		if v11(v18.Rend) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\35\135\114\184\113\129\115\176\62\145\111\169\34\189\111\171\52\135\108\252\101", "\220\81\226\28");
		end
	end
	if (v18.ThunderousRoar:IsCastable() and v7:IsInMeleeRange(466 - (13 + 441)) and IsThunderousRoar) then
		if v11(v18.ThunderousRoar, true) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\7\221\151\245\238\194\1\218\151\232\213\213\28\212\144\187\233\200\31\218\145\232\255\212\44\198\149\254\239\215\83\131", "\167\115\181\226\155\138");
		end
	end
	if (v13() and v18.SweepingStrikes:IsCastable() and v48) then
		if v10.Cast(v18.SweepingStrikes) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\241\53\226\89\107\120\200\229\29\244\72\105\120\205\231\49\167\95\116\125\201\241\49\242\79\68\98\209\231\39\247\28\35", "\166\130\66\135\60\27\17");
		end
	end
	if (v18.ChampionsSpear:IsCastable() and v48 and IsChampionsSpear) then
		if v10.CastTarget(v18.ChampionsSpear, v10.TName().PLAYER) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\71\66\207\120\32\77\69\192\102\15\87\90\203\116\34\4\73\193\121\63\87\89\219\102\15\87\93\203\112\32\4\18", "\80\36\42\174\21");
		end
	end
	if (v18.Ravager:IsCastable() and v48 and IsBladestorm and (v18.ColossusSmash:CooldownUp())) then
		if v10.CastTarget(v18.Ravager, v10.TName().PLAYER) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\92\17\33\123\73\21\37\58\77\31\59\117\93\3\34\105\113\3\32\127\75\0\119\43\30", "\26\46\112\87");
		end
	end
	if (v18.Avatar:IsCastable() and v48 and IsAvatar) then
		if v11(v18.Avatar, true) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\184\53\170\96\190\173\5\183\182\47\164\103\172\170\86\139\170\52\174\113\175\255\20\230", "\212\217\67\203\20\223\223\37");
		end
	end
	if (v18.ColossusSmash:IsCastable() and v48 and IsColossusSmash) then
		if v11(v18.ColossusSmash, true) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\185\130\164\221\169\158\189\193\133\158\165\211\169\133\232\209\181\129\167\193\169\152\187\237\169\154\173\215\170\205\249\134", "\178\218\237\200");
		end
	end
	if (v18.Warbreaker:IsCastable() and v7:IsInRange(29 - 21) and IsColossusSmash) then
		if v11(v18.Warbreaker, true) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\161\180\244\210\164\176\231\219\179\167\166\211\185\185\233\195\165\160\245\239\165\162\227\213\166\245\183\134", "\176\214\213\134");
		end
	end
	if (v18.MortalStrike:IsReady() and v48) then
		if v11(v18.MortalStrike) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\249\162\164\192\169\90\102\231\185\164\221\163\83\25\247\162\186\219\187\69\76\231\146\165\195\173\83\73\180\255\230", "\57\148\205\214\180\200\54");
		end
	end
	if (v18.Demolish:IsCastable() and IsDemolish and not v6:IsMoving() and v48) then
		if v11(v18.Demolish) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\22\248\56\59\122\27\238\61\116\117\29\241\58\39\101\7\238\10\39\97\23\248\37\116\36\70", "\22\114\157\85\84");
		end
	end
	if (v18.Overpower:IsCastable() and v48) then
		if v11(v18.Overpower) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\203\219\83\199\82\250\167\215\216\6\215\98\229\191\193\206\3\132\15\174", "\200\164\171\115\164\61\150");
		end
	end
	if (v18.Execute:IsReady() and v48) then
		if v11(v18.Executecast) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\187\236\6\70\150\170\241\67\70\140\178\251\16\86\150\173\203\16\82\134\187\228\67\22\211", "\227\222\148\99\37");
		end
	end
	if (v18.Whirlwind:IsReady() and (v18.FervorofBattle:IsAvailable()) and v48) then
		if v11(v18.Whirlwind) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\36\90\91\228\245\36\91\92\242\185\48\93\94\249\234\32\71\65\201\234\36\87\87\230\185\96\0", "\153\83\50\50\150");
		end
	end
	if (v18.Cleave:IsReady() and (v18.FervorofBattle:IsAvailable()) and v48) then
		if v11(v18.Cleave, nil, nil, not v48) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\88\110\118\31\102\191\72\29\117\124\16\124\184\94\72\101\76\15\100\174\72\77\54\32\72", "\45\61\22\19\124\19\203");
		end
	end
	if (v18.ThunderClap:IsReady() and v48 and (v7:DebuffRemains(v18.RendDebuff) < (20 - 12)) and v6:BuffDown(v18.SweepingStrikesBuff)) then
		if v11(v18.ThunderClap) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\213\26\24\251\6\117\171\254\17\1\244\18\48\186\206\30\2\230\17\101\170\254\1\26\240\7\96\249\146\68", "\217\161\114\109\149\98\16");
		end
	end
	if (v18.Rend:IsCastable() and v48 and (v7:DebuffRemains(v18.RendDebuff) <= (24 - 19))) then
		if v11(v18.Rend) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\0\37\54\120\252\119\29\44\55\111\175\97\1\31\43\107\185\113\2\96\107\36", "\20\114\64\88\28\220");
		end
	end
	if (v18.Slam:IsReady() and v48) then
		if v11(v18.Slam) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\34\13\211\185\184\211\178\61\14\193\167\237\195\130\34\22\215\177\232\144\233\101", "\221\81\97\178\212\152\176");
		end
	end
end
local function v69()
	if (v18.StormBolt:IsReady() and (v6:BuffUp(v18.Bladestorm)) and v7:IsInRange(1 + 19)) then
		if v11(v18.StormBolt) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\222\243\18\233\23\242\229\18\247\14\141\244\17\250\3\200\245\34\250\21\200\167\79", "\122\173\135\125\155");
		end
	end
	if (v18.ThunderClap:IsReady() and v48 and (v7:DebuffDown(v18.RendDebuff))) then
		if v11(v18.ThunderClap) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\144\201\21\183\59\52\218\187\194\12\184\47\113\219\136\192\25\188\45\14\201\139\196\64\237", "\168\228\161\96\217\95\81");
		end
	end
	if (v18.SweepingStrikes:IsCastable() and v48) then
		if v11(v18.SweepingStrikes, true) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\200\198\43\89\63\94\213\214\17\79\59\69\210\218\43\79\111\68\215\208\55\89\61\104\218\222\43\28\122", "\55\187\177\78\60\79");
		end
	end
	if (v18.ThunderousRoar:IsCastable() and v7:IsInMeleeRange(43 - 31) and IsThunderousRoar) then
		if v11(v18.ThunderousRoar, true) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\57\198\74\229\66\202\146\34\219\76\212\84\192\129\63\142\76\231\71\214\133\63\241\90\243\67\204\149\57\203\31\189", "\224\77\174\63\139\38\175");
		end
	end
	if (v18.Avatar:IsCastable() and IsAvatar) then
		if v11(v18.Avatar, true) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\133\87\89\58\133\83\24\61\136\64\65\43\150\126\89\33\129\1\0", "\78\228\33\56");
		end
	end
	if (v18.ChampionsSpear:IsCastable() and v48 and IsChampionsSpear) then
		if v10.CastTarget(v18.ChampionsSpear, v10.TName().PLAYER) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\205\118\179\14\149\199\113\188\16\186\221\110\183\2\151\142\109\190\2\156\203\108\141\6\157\203\125\167\23\128\142\38", "\229\174\30\210\99");
		end
	end
	if (IsBladestorm and v48 and v18.Ravager:IsCastable() and (v18.ColossusSmash:CooldownRemains() <= v6:GCD())) then
		if v10.CastTarget(v18.Ravager, v10.TName().PLAYER) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\9\236\144\80\234\56\43\91\254\138\80\244\56\43\36\232\158\84\238\40\45\30\173\222", "\89\123\141\230\49\141\93");
		end
	end
	if (v18.Warbreaker:IsCastable() and v7:IsInRange(3 + 5) and IsColossusSmash) then
		if v11(v18.Warbreaker, true) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\228\112\228\14\2\79\242\122\243\30\80\89\255\112\239\9\2\117\246\105\243\15\5\94\246\49\167\94", "\42\147\17\150\108\112");
		end
	end
	if (v18.ColossusSmash:IsCastable() and v48 and IsColossusSmash) then
		if v11(v18.ColossusSmash, true) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\12\169\33\112\244\251\26\181\18\108\234\233\28\174\109\108\235\233\22\163\63\64\226\240\10\165\56\107\226\168\94\242", "\136\111\198\77\31\135");
		end
	end
	if (v18.Cleave:IsReady() and v48) then
		if v11(v18.Cleave) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\1\5\162\87\171\225\87\186\14\8\190\83\175\219\22\166\7\73\246\14", "\201\98\105\199\54\221\132\119");
		end
	end
	if (v18.Execute:IsReady() and v48 and ((v6:BuffUp(v18.SuddenDeathBuff) and (v6:BuffStack(v18.ImminentDemiseBuff) < (2 + 1))) or ((v6:BuffRemains(v18.JuggernautBuff) < (8 - 5)) and v18.Juggernaut:IsAvailable()))) then
		if v11(v18.Executecast) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\188\20\134\34\23\33\169\249\31\143\32\27\48\190\134\9\155\36\1\32\184\188\76\210\119", "\204\217\108\227\65\98\85");
		end
	end
	if (v18.Bladestorm:IsCastable() and v48 and IsBladestorm) then
		if v11(v18.Bladestormcast, true) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\92\207\244\225\41\211\74\204\231\232\108\211\82\194\236\224\62\255\91\219\240\230\57\212\91\131\164\189", "\160\62\163\149\133\76");
		end
	end
	if (v18.Overpower:IsCastable() and v48 and v6:BuffUp(v18.SweepingStrikesBuff) and (v6:BuffUp(v18.OpportunistBuff) or (v18.Dreadnaught:IsAvailable() and not v18.Juggernaut:IsAvailable()))) then
		if v11(v18.Overpower) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\217\182\8\61\211\217\183\8\61\131\197\172\12\54\198\196\159\12\32\198\150\242\89", "\163\182\192\109\79");
		end
	end
	if (v18.MortalStrike:IsReady() and v48 and (v6:BuffUp(v18.SweepingStrikesBuff))) then
		if v11(v18.MortalStrike) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\57\41\18\212\244\56\25\19\212\231\61\45\5\128\230\56\39\25\197\231\11\35\24\197\246\33\50\5\128\167\102", "\149\84\70\96\160");
		end
	end
	if (v18.Execute:IsReady() and v48 and ((v6:BuffUp(v18.SweepingStrikesBuff) and (v7:DebuffStack(v18.ExecutionersPrecisionDebuff) < (2 + 0)) and v18.ExecutionersPrecision:IsAvailable()) or v7:DebuffUp(v18.MarkedforExecutionDebuff))) then
		if v11(v18.Execute) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\61\30\8\238\45\18\8\173\43\10\12\244\61\20\50\236\55\3\77\191\96", "\141\88\102\109");
		end
	end
	if (v18.Skullsplitter:IsCastable() and v48 and (v6:BuffUp(v18.SweepingStrikesBuff))) then
		if v11(v18.Skullsplitter, true) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\160\88\223\124\22\46\69\205\186\71\222\117\8\125\70\205\178\74\207\98\37\60\90\196\243\0\154", "\161\211\51\170\16\122\93\53");
		end
	end
	if (v18.Overpower:IsCastable() and v48 and (v6:BuffUp(v18.OpportunistBuff) or v18.Dreadnaught:IsAvailable())) then
		if v11(v18.Overpower) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\244\184\183\58\235\161\165\45\233\238\161\36\250\183\183\58\196\171\170\45\248\187\166\45\187\252\230", "\72\155\206\210");
		end
	end
	if (v18.MortalStrike:IsReady() and v48) then
		if v11(v18.MortalStrike) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\107\117\70\26\50\74\73\64\28\58\77\127\20\29\63\71\99\81\28\12\67\98\81\13\38\82\127\20\92\101", "\83\38\26\52\110");
		end
	end
	if (v18.Overpower:IsCastable() and v48) then
		if v11(v18.Overpower) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\87\1\34\84\72\24\48\67\74\87\52\74\89\14\34\84\103\18\63\67\91\2\51\67\24\69\127", "\38\56\119\71");
		end
	end
	if (v18.ThunderClap:IsReady() and v48) then
		if v11(v18.ThunderClap) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\231\231\77\216\33\83\225\208\91\218\36\70\179\252\84\215\60\83\225\208\89\217\32\22\160\183", "\54\147\143\56\182\69");
		end
	end
	if (v18.Execute:IsReady() and v48) then
		if v11(v18.Execute) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\211\153\250\74\202\194\132\191\90\211\215\152\250\91\224\215\142\250\9\139\134", "\191\182\225\159\41");
		end
	end
	if (v18.Whirlwind:IsReady() and v48) then
		if v11(v18.Whirlwind) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\60\26\33\71\135\144\203\37\22\104\70\135\134\219\46\0\23\84\132\130\130\127\64", "\162\75\114\72\53\235\231");
		end
	end
	if (v18.Skullsplitter:IsCastable() and v48) then
		if v11(v18.Skullsplitter) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\159\55\81\238\95\17\156\48\77\246\71\7\158\124\87\238\82\27\137\46\123\227\92\7\204\104\16", "\98\236\92\36\130\51");
		end
	end
	if (v18.Slam:IsReady() and v48) then
		if v11(v18.Slam) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\183\21\13\183\5\187\185\49\189\28\30\133\68\167\176\112\240\79", "\80\196\121\108\218\37\200\213");
		end
	end
end
local function v70()
	if (v18.StormBolt:IsReady() and v7:IsInRange(36 - 16) and (v6:BuffUp(v18.Bladestorm))) then
		if v11(v18.StormBolt) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\19\103\13\109\70\49\136\15\127\22\63\88\2\139\25\118\16\64\78\22\143\3\102\22\122\11\92", "\234\96\19\98\31\43\110");
		end
	end
	if (v18.SweepingStrikes:IsCastable() and (v50 == (2 + 0)) and v48) then
		if v11(v18.SweepingStrikes, true) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\21\8\87\194\188\123\133\1\32\65\211\190\123\128\3\12\18\212\160\115\146\3\13\109\194\180\119\136\19\11\87\135\248", "\235\102\127\50\167\204\18");
		end
	end
	if (v18.Rend:IsCastable() and v48 and (v7:DebuffRemains(v18.RendDebuff) <= v6:GCD()) and not v18.Bloodletting:IsAvailable()) then
		if v11(v18.Rend) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\66\164\251\39\4\61\92\160\236\38\86\17\67\181\181\113", "\78\48\193\149\67\36");
		end
	end
	if (v18.ThunderousRoar:IsCastable() and v7:IsInMeleeRange(7 + 5) and IsThunderousRoar) then
		if v11(v18.ThunderousRoar, true) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\36\22\149\22\69\53\12\143\13\82\15\12\143\25\83\112\13\140\25\88\53\12\191\11\85\112\74", "\33\80\126\224\120");
		end
	end
	if (IsAvatar and v18.Avatar:IsCastable() and ((v18.ColossusSmash:CooldownRemains() <= (4 + 1)) or v7:DebuffUp(v18.ColossusSmashDebuff))) then
		if v11(v18.Avatar, true) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\237\190\2\208\93\254\232\16\200\93\245\173\17\251\89\244\173\0\209\72\233\232\82\148", "\60\140\200\99\164");
		end
	end
	if (v18.ChampionsSpear:IsCastable() and v48 and IsChampionsSpear) then
		if v10.CastTarget(v18.ChampionsSpear, v10.TName().PLAYER) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\132\252\5\43\178\142\251\10\53\157\148\228\1\39\176\199\231\8\39\187\130\230\59\53\182\199\162", "\194\231\148\100\70");
		end
	end
	if (v18.Ravager:IsCastable() and v48 and IsBladestorm) then
		if v10.CastTarget(v18.Ravager, v10.TName().PLAYER) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\116\77\215\162\241\205\84\12\210\175\247\209\67\94\254\176\226\136\16", "\168\38\44\161\195\150");
		end
	end
	if (v18.Warbreaker:IsCastable() and v48 and IsColossusSmash) then
		if v11(v18.Warbreaker, true) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\151\253\144\116\34\237\183\29\133\238\194\101\60\233\175\19\146\195\135\110\53\235\163\2\133\188\211\32", "\118\224\156\226\22\80\136\214");
		end
	end
	if (v18.ColossusSmash:IsCastable() and v48 and IsColossusSmash) then
		if v11(v18.ColossusSmash, true) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\65\225\85\143\81\253\76\147\125\253\84\129\81\230\25\147\78\239\64\133\80\209\74\148\2\191\9", "\224\34\142\57");
		end
	end
	if (v18.Execute:IsReady() and v48 and (v6:BuffRemains(v18.JuggernautBuff) <= (v6:GCD() * (2 + 0))) and v18.Juggernaut:IsAvailable()) then
		if v11(v18.Executecast) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\219\191\192\222\102\229\88\78\205\171\196\196\118\227\98\29\202\231\148\137", "\110\190\199\165\189\19\145\61");
		end
	end
	if (IsBladestorm and v18.Bladestorm:IsCastable() and (((v7:DebuffStack(v18.ExecutionersPrecisionDebuff) == (2 + 0)) and (v7:DebuffRemains(v18.ColossusSmashDebuff) > (437 - (153 + 280)))) or ((v7:DebuffStack(v18.ExecutionersPrecisionDebuff) == (5 - 3)) and (v18.ColossusSmash:CooldownRemains() > (14 + 1))) or not v18.ExecutionersPrecision:IsAvailable())) then
		if v11(v18.Bladestormcast, true) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\216\231\118\236\142\212\206\228\101\229\203\212\214\234\110\237\153\248\201\255\55\185\221", "\167\186\139\23\136\235");
		end
	end
	if (v18.Skullsplitter:IsCastable() and v7:IsInMeleeRange(4 + 4) and (v6:Rage() < (21 + 19))) then
		if v11(v18.Skullsplitter) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\9\162\141\8\10\188\134\10\37\166\156\31\19\190\141\30\90\166\132\12\3\176\154\50\9\161\200\95\72", "\109\122\213\232");
		end
	end
	if (v18.Overpower:IsCastable() and v48 and (v6:BuffStack(v18.MartialProwessBuff) < (2 + 0)) and v6:BuffUp(v18.OpportunistBuff) and v18.Opportunist:IsAvailable() and (v18.Bladestorm:IsAvailable() or (v18.Ravager:IsAvailable() and (v6:Rage() < (62 + 23))))) then
		if v11(v18.Overpower) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\225\225\167\34\254\248\181\53\252\183\177\60\239\238\167\34\209\228\182\112\191\175", "\80\142\151\194");
		end
	end
	if (v18.MortalStrike:IsReady() and v48 and ((v7:DebuffRemains(v18.RendDebuff) < (2 - 0)) or ((v7:DebuffStack(v18.ExecutionersPrecisionDebuff) == (2 + 0)) and v7:DebuffDown(v18.RavagerDebuff)))) then
		if v11(v18.MortalStrike) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\14\201\101\88\2\202\72\95\23\212\126\71\6\134\100\64\2\223\114\94\60\213\99\12\81\150", "\44\99\166\23");
		end
	end
	if (v18.Overpower:IsCastable() and v48 and (v6:Rage() <= (707 - (89 + 578))) and (v6:BuffStack(v18.MartialProwessBuff) < (2 + 0)) and v18.FierceFollowthrough:IsAvailable()) then
		if v11(v18.Overpower) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\115\225\44\36\35\171\107\242\59\118\32\168\125\238\44\36\12\183\104\183\123\96", "\196\28\151\73\86\83");
		end
	end
	if (v18.Execute:IsReady() and v48) then
		if v11(v18.Executecast) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\246\27\44\19\151\76\29\54\224\15\40\9\135\74\39\115\235\6\42\5\150\93\88\37\161", "\22\147\99\73\112\226\56\120");
		end
	end
	if (v18.Overpower:IsCastable() and v48) then
		if v11(v18.Overpower) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\183\99\231\231\157\183\98\231\231\205\171\121\227\236\136\170\74\231\237\136\187\96\246\240\205\235\33", "\237\216\21\130\149");
		end
	end
end
local function v71()
	if (v18.StormBolt:IsReady() and v48 and (v6:BuffUp(v18.Bladestorm))) then
		if v11(v18.StormBolt) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\177\90\80\77\189\235\81\142\90\31\76\188\200\71\135\92\96\94\191\204\30\208", "\62\226\46\63\63\208\169");
		end
	end
	if (v18.Rend:IsCastable() and v48 and (v7:DebuffRemains(v18.RendDebuff) <= v6:GCD())) then
		if v11(v18.Rend) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\247\28\91\135\95\30\35\95\252\28\71\188\12\25\111\10", "\62\133\121\53\227\127\109\79");
		end
	end
	if (v18.ThunderousRoar:IsCastable() and v7:IsInMeleeRange(24 - 12) and IsThunderousRoar) then
		if v11(v18.ThunderousRoar, true) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\4\28\39\251\210\171\176\31\1\33\202\196\161\163\2\84\33\249\215\183\167\2\43\51\250\211\238\244", "\194\112\116\82\149\182\206");
		end
	end
	if (v48 and IsAvatar and v18.Avatar:IsCastable() and ((v18.ColossusSmash:CooldownRemains() <= (1054 - (572 + 477))) or v7:DebuffUp(v18.ColossusSmashDebuff))) then
		if v11(v18.Avatar, true) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\56\190\77\12\193\240\78\42\164\77\1\197\240\49\56\167\73\88\152", "\110\89\200\44\120\160\130");
		end
	end
	if (v48 and IsChampionsSpear and v18.ChampionsSpear:IsCastable() and (v7:DebuffUp(v18.ColossusSmashDebuff) or v6:BuffUp(v18.AvatarBuff))) then
		if v10.CastTarget(v18.ChampionsSpear, v10.TName().PLAYER) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\168\203\74\75\83\67\52\67\184\252\88\86\70\75\41\13\184\207\74\95\70\88\4\76\164\198\11\23\19", "\45\203\163\43\38\35\42\91");
		end
	end
	if (v48 and IsBladestorm and v18.Ravager:IsCastable() and (v18.ColossusSmash:CooldownRemains() <= v6:GCD())) then
		if v10.CastTarget(v18.Ravager, v10.TName().PLAYER) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\224\132\202\34\128\172\70\146\150\208\34\158\172\70\237\132\211\38\199\248\4", "\52\178\229\188\67\231\201");
		end
	end
	if (v18.ColossusSmash:IsCastable() and v48 and IsColossusSmash) then
		if v11(v18.ColossusSmash) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\34\78\92\11\228\79\54\50\126\67\9\246\79\43\97\82\92\5\238\89\49\30\82\68\68\166\8", "\67\65\33\48\100\151\60");
		end
	end
	if (v18.Warbreaker:IsCastable() and v7:IsInRange(2 + 6) and IsColossusSmash) then
		if v11(v18.Warbreaker, true) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\200\230\188\218\225\218\230\165\221\225\159\244\162\217\234\218\245\145\217\252\218\167\255\138", "\147\191\135\206\184");
		end
	end
	if (v18.Execute:IsReady() and v48 and (((v6:BuffRemains(v18.JuggernautBuff) <= (v6:GCD() * (2 + 0))) and v18.Juggernaut:IsAvailable()) or (v6:BuffStack(v18.SuddenDeathBuff) == (1 + 1)) or (v6:BuffRemains(v18.SuddenDeathBuff) <= (v6:GCD() * (89 - (84 + 2)))) or (v7:DebuffStack(v18.MarkedforExecutionDebuff) == (4 - 1)))) then
		if v11(v18.Executecast) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\129\48\163\194\205\71\183\196\59\170\192\193\86\160\187\41\169\196\152\1\226", "\210\228\72\198\161\184\51");
		end
	end
	if (v18.Overpower:IsCastable() and v48 and (v6:BuffUp(v18.OpportunistBuff))) then
		if v11(v18.Overpower) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\57\95\246\2\99\193\33\76\225\80\96\194\55\80\246\2\76\207\57\76\179\65\43", "\174\86\41\147\112\19");
		end
	end
	if (v18.MortalStrike:IsReady() and v48) then
		if v11(v18.MortalStrike) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\86\15\159\31\36\3\46\184\79\18\132\0\32\79\2\167\90\25\136\25\26\14\30\174\27\82\213", "\203\59\96\237\107\69\111\113");
		end
	end
	if (v18.Bladestorm:IsCastable() and v48 and IsBladestorm and ((v18.ColossusSmash:CooldownRemains() >= (v6:GCD() * (3 + 1))) or (v18.Warbreaker:CooldownRemains() >= (v6:GCD() * (846 - (497 + 345)))) or (v7:DebuffRemains(v18.ColossusSmashDebuff) >= (v6:GCD() * (1 + 3))))) then
		if v11(v18.Bladestormcast, true) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\38\26\173\229\52\227\195\43\4\161\161\34\252\214\61\19\190\222\34\228\151\118\66", "\183\68\118\204\129\81\144");
		end
	end
	if (v18.Skullsplitter:IsCastable() and v48) then
		if v11(v18.Skullsplitter) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\29\166\101\232\7\145\30\161\121\240\31\135\28\237\99\232\10\155\11\191\79\247\31\194\92\251", "\226\110\205\16\132\107");
		end
	end
	if (v18.Overpower:IsCastable() and v48) then
		if v11(v18.Overpower) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\228\213\229\203\81\228\212\229\203\1\248\207\225\192\68\249\252\243\205\1\185\155", "\33\139\163\128\185");
		end
	end
	if (v18.Rend:IsCastable() and (v7:DebuffRemains(v18.RendDebuff) <= (2 + 6)) and v48) then
		if v11(v18.Rend) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\69\93\10\218\23\75\8\223\78\93\22\225\68\76\68\141\7", "\190\55\56\100");
		end
	end
	if (v18.Execute:IsReady() and not v18.Juggernaut:IsAvailable() and v48) then
		if v11(v18.Executecast) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\83\183\57\29\6\247\246\22\188\48\31\10\230\225\105\188\40\94\64\177", "\147\54\207\92\126\115\131");
		end
	end
	if (v18.Cleave:IsReady() and v48) then
		if v11(v18.Cleave) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\14\61\48\124\27\123\77\34\57\124\20\123\31\14\38\105\77\45\89", "\30\109\81\85\29\109");
		end
	end
	if (v18.Slam:IsReady() and v48) then
		if v11(v18.Slam) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\236\125\85\187\118\205\240\254\104\81\164\9\205\232\191\34\2", "\156\159\17\52\214\86\190");
		end
	end
end
local function v72()
	if (v18.StormBolt:IsCastable() and v7:IsInRange(1353 - (605 + 728)) and (v6:BuffUp(v18.Bladestorm))) then
		if v11(v18.StormBolt) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\189\251\178\174\163\208\191\179\162\251\253\175\162\238\164\185\188\208\174\171\171\234\173\252\250\191", "\220\206\143\221");
		end
	end
	if (IsThunderousRoar and v48 and v18.ThunderousRoar:IsCastable() and v7:DebuffDown(v18.RendDebuff) and v6:BuffDown(v18.SweepingStrikesBuff)) then
		if v11(v18.ThunderousRoar) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\146\117\56\25\220\201\192\137\104\62\40\202\195\211\148\61\62\27\217\213\215\148\66\62\0\221\201\194\198\41", "\178\230\29\77\119\184\172");
		end
	end
	if (v18.ThunderousRoar:IsCastable() and v7:IsInMeleeRange(9 + 3) and IsThunderousRoar) then
		if v11(v18.ThunderousRoar, true) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\225\182\31\21\115\253\231\177\31\8\72\234\250\191\24\91\100\244\244\167\15\9\72\235\226\187\15\11\55\170", "\152\149\222\106\123\23");
		end
	end
	if (v18.SweepingStrikes:IsCastable() and v48) then
		if v11(v18.SweepingStrikes) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\206\49\243\70\165\212\40\241\124\166\201\52\255\72\176\206\102\229\79\180\196\35\228\124\166\202\35\243\83\245\137", "\213\189\70\150\35");
		end
	end
	if (v18.Rend:IsCastable() and v48 and (v7:DebuffRemains(v18.RendDebuff) <= v6:GCD())) then
		if v11(v18.Rend) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\93\80\122\12\15\70\120\9\86\80\102\55\92\66\113\13\95\21\34", "\104\47\53\20");
		end
	end
	if (v18.ChampionsSpear:IsCastable() and v48 and IsChampionsSpear) then
		if v10.CastTarget(v18.ChampionsSpear, v10.TName().PLAYER) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\160\68\128\17\172\6\172\66\146\35\175\31\166\77\147\92\175\3\162\85\132\14\131\28\180\73\132\12\252\87", "\111\195\44\225\124\220");
		end
	end
	if (v18.Avatar:IsCastable() and v48 and IsAvatar) then
		if v11(v18.Avatar, true) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\217\80\1\103\170\185\152\85\12\114\178\174\202\121\19\100\174\174\200\6\81\35", "\203\184\38\96\19\203");
		end
	end
	if (v18.ColossusSmash:IsCastable() and v48 and IsColossusSmash) then
		if v11(v18.ColossusSmash, true) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\58\124\117\78\221\42\102\106\126\221\52\114\106\73\142\42\127\120\88\203\43\76\106\86\203\60\99\57\16\156", "\174\89\19\25\33");
		end
	end
	if (v18.Warbreaker:IsCastable() and v7:IsInRange(17 - 9) and IsColossusSmash) then
		if v11(v18.Warbreaker, true) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\56\19\64\76\229\130\10\36\23\64\14\228\139\10\54\23\64\113\228\144\14\42\2\18\31\163", "\107\79\114\50\46\151\231");
		end
	end
	if (v18.Skullsplitter:IsCastable() and v7:IsInMeleeRange(1 + 7) and (v6:BuffUp(v18.SweepingStrikesBuff))) then
		if v11(v18.Skullsplitter) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\42\177\176\44\154\48\185\199\6\181\161\59\131\50\178\211\121\181\185\40\147\60\165\255\42\177\176\44\154\121\230\150", "\160\89\198\213\73\234\89\215");
		end
	end
	if (v18.Execute:IsReady() and v48 and ((v6:BuffRemains(v18.JuggernautBuff) <= (v6:GCD() * (7 - 5))) or (v7:DebuffStack(v18.MarkedforExecutionDebuff) == (3 + 0)) or (v6:BuffStack(v18.SuddenDeathBuff) == (5 - 3)) or (v6:BuffRemains(v18.SuddenDeathBuff) <= (v6:GCD() * (3 + 0))))) then
		if v11(v18.Executecast) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\77\105\177\253\208\92\116\244\237\201\73\104\177\236\250\91\102\177\251\213\8\32\236", "\165\40\17\212\158");
		end
	end
	if (v48 and IsBladestorm and v18.Bladestorm:IsCastable() and ((v18.ColossusSmash:CooldownRemains() >= (v6:GCD() * (493 - (457 + 32)))) or (v18.Warbreaker:CooldownRemains() >= (v6:GCD() * (2 + 2))) or (v7:DebuffRemains(v18.ColossusSmashDebuff) >= (v6:GCD() * (1406 - (832 + 570)))))) then
		if v11(v18.Bladestormcast, true) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\231\213\9\55\35\246\205\7\33\43\165\202\4\50\63\224\203\55\32\49\224\220\24\115\116\181", "\70\133\185\104\83");
		end
	end
	if (v18.Overpower:IsCastable() and v48 and (v6:BuffUp(v18.OpportunistBuff))) then
		if v11(v18.Overpower) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\11\83\65\56\217\11\82\65\56\137\23\73\69\51\204\22\122\87\61\204\1\85\4\120\155", "\169\100\37\36\74");
		end
	end
	if (v18.MortalStrike:IsReady() and v48) then
		if v11(v18.MortalStrike) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\13\136\176\68\1\139\157\67\20\149\171\91\5\199\177\92\1\158\167\66\63\148\181\85\5\151\226\2\84", "\48\96\231\194");
		end
	end
	if (v18.Overpower:IsCastable() and v48) then
		if v11(v18.Overpower) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\199\76\11\63\9\215\184\134\218\26\29\33\24\193\170\145\247\73\25\40\28\200\239\208\152", "\227\168\58\110\77\121\184\207");
		end
	end
	if (v18.ThunderClap:IsReady() and v48 and (v7:DebuffRemains(v18.RendDebuff) < (8 + 0)) and v6:BuffDown(v18.SweepingStrikesBuff)) then
		if v11(v18.ThunderClap) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\111\52\170\78\181\222\99\154\120\48\190\80\241\200\125\164\98\57\173\127\162\204\116\160\107\124\236\18", "\197\27\92\223\32\209\187\17");
		end
	end
	if (v18.Rend:IsCastable() and v48 and (v7:DebuffRemains(v18.RendDebuff) <= (2 + 3))) then
		if v11(v18.Rend) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\17\90\205\255\67\76\207\250\26\90\209\196\16\72\198\254\19\31\144\175", "\155\99\63\163");
		end
	end
	if (v18.Cleave:IsReady() and v48 and v18.FervorofBattle:IsAvailable() and v6:BuffDown(v18.MartialProwessBuff)) then
		if v11(v18.Cleave) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\129\221\164\140\175\129\194\194\173\140\160\129\144\238\178\154\188\129\146\145\242\219", "\228\226\177\193\237\217");
		end
	end
	if (v18.Whirlwind:IsReady() and v48 and (v18.FervorofBattle:IsAvailable())) then
		if v11(v18.Whirlwind) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\35\184\42\244\56\167\42\232\48\240\48\234\53\169\38\244\11\163\52\227\49\160\99\181\98", "\134\84\208\67");
		end
	end
	if (v18.Execute:IsReady() and v48 and not v18.Juggernaut:IsAvailable()) then
		if v11(v18.Executecast) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\22\180\131\95\6\184\131\28\0\160\135\69\22\190\185\79\4\169\131\76\83\248\214", "\60\115\204\230");
		end
	end
	if (v18.Slam:IsReady() and v48) then
		if v11(v18.Slam) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\244\54\234\125\167\41\231\113\254\63\249\79\244\45\238\117\247\122\184\40", "\16\135\90\139");
		end
	end
end
local function v73()
	if (v23.Commons.Enabled.Items and IsWeapon and v48 and not v6:IsMoving() and v19.Fyralath:IsEquippedAndReady() and (((v18.MarkofFyralathDebuff:AuraActiveCount() > (0 - 0)) and not v18.BlademastersTorment:IsAvailable()) or ((v18.MarkofFyralathDebuff:AuraActiveCount() > (0 + 0)) and (v18.Avatar:CooldownRemains() > (799 - (588 + 208))) and (v18.Bladestorm:CooldownRemains() > (8 - 5)) and v7:DebuffDown(v18.ColossusSmashDebuff)))) then
		v10.CastMacro(1801 - (884 + 916), nil, nil, v19.Fyralath);
		return LUAOBFUSACTOR_DECRYPT_STR_0("\67\113\7\35\65\90\56\87\117\21\39", "\24\52\20\102\83\46\52");
	end
	if v23.Commons.Enabled.Trinkets then
		if (v19.TreacherousTransmitter:IsEquippedAndReady() and (((v24:ID() == v19.TreacherousTransmitter:ID()) and IsTrinket1) or ((v25:ID() == v19.TreacherousTransmitter:ID()) and IsTrinket2)) and (v45 or v46) and (v18.Avatar:CooldownRemains() < (6 - 3))) then
			if v11(v19.TreacherousTransmitter, true) then
				return LUAOBFUSACTOR_DECRYPT_STR_0("\208\61\36\37\12\204\42\51\43\26\215\16\53\54\14\202\60\44\45\27\208\42\51\100\27\214\38\47\47\10\208\60\97\118", "\111\164\79\65\68");
			end
		end
		if (v24:IsReady() and v48 and IsTrinket1 and not v34 and ((v40 and not v42 and ((v6:BuffDown(v18.AvatarBuff) and (v30 > (0 + 0))) or (v30 == (653 - (232 + 421)))) and v6:BuffUp(v18.AvatarBuff) and (v37 or not v25:HasCooldown() or v33 or (v44 == (1890 - (1569 + 320))))) or (v24:BuffDuration() >= v52))) then
			if v11(v24, true) then
				return LUAOBFUSACTOR_DECRYPT_STR_0("\211\202\134\225\39\254\195\212\195\216\33\248\134", "\138\166\185\227\190\78") .. v24:Name() .. LUAOBFUSACTOR_DECRYPT_STR_0("\139\96\215\62\92\40\28\223\103\133\99", "\121\171\20\165\87\50\67");
			end
		end
		if (v25:IsReady() and v48 and IsTrinket2 and not v35 and ((v41 and not v43 and ((v6:BuffDown(v18.AvatarBuff) and (v31 > (0 + 0))) or (v31 == (0 + 0))) and v6:BuffUp(v18.AvatarBuff) and (v36 or not v24:HasCooldown() or v32 or (v44 == (6 - 4)))) or (v25:BuffDuration() >= v52))) then
			if v11(v25, true) then
				return LUAOBFUSACTOR_DECRYPT_STR_0("\211\43\188\9\176\22\195\53\249\48\182\16\134", "\98\166\88\217\86\217") .. v25:Name() .. LUAOBFUSACTOR_DECRYPT_STR_0("\182\226\107\8\136\215\243\226\106\65\208", "\188\150\150\25\97\230");
			end
		end
		if (v24:IsReady() and v48 and IsTrinket1 and not v34 and not v40 and (((v30 > (605 - (316 + 289))) and v6:BuffDown(v18.AvatarBuff)) or (v30 == (0 - 0))) and not v42 and ((not v40 and (v33 or not v41)) or ((v30 > (0 + 0)) and v6:BuffDown(v18.AvatarBuff)) or (v30 == (1453 - (666 + 787))) or (v18.Avatar:CooldownRemains() > (445 - (360 + 65))))) then
			if v11(v24, true) then
				return LUAOBFUSACTOR_DECRYPT_STR_0("\207\154\90\61\5\249\223\132\31\4\3\255\154", "\141\186\233\63\98\108") .. v24:Name() .. LUAOBFUSACTOR_DECRYPT_STR_0("\177\254\62\191\43\250\239\56\165\101\169", "\69\145\138\76\214");
			end
		end
		if (v25:IsReady() and v48 and IsTrinket2 and not v35 and not v41 and (((v31 > (0 + 0)) and v6:BuffDown(v18.AvatarBuff)) or (v31 == (254 - (79 + 175)))) and not v43 and ((not v41 and (v32 or not v40)) or ((v31 > (0 - 0)) and v6:BuffDown(v18.AvatarBuff)) or (v31 == (0 + 0)) or (v18.Avatar:CooldownRemains() > (61 - 41)))) then
			if v11(v25, true) then
				return LUAOBFUSACTOR_DECRYPT_STR_0("\101\220\140\182\182\2\117\194\201\143\176\4\48", "\118\16\175\233\233\223") .. v25:Name() .. LUAOBFUSACTOR_DECRYPT_STR_0("\203\144\39\178\224\128\120\159\151\117\234\190", "\29\235\228\85\219\142\235");
			end
		end
	end
	if v23.Commons.Enabled.Items then
		local v101, v102, v103 = v6:GetUseableItems(v20, 30 - 14);
		if (v101 and v101:IsReady() and IsWeapon and v7:IsInRange(v103) and not v19.Fyralath:IsEquipped() and (not v40 or v32) and (not v41 or v33)) then
			v10.CastMacro(900 - (503 + 396));
			return LUAOBFUSACTOR_DECRYPT_STR_0("\42\209\187\205\120\64\103\81\60\199\174", "\50\93\180\218\189\23\46\71");
		end
	end
end
local function v74()
	v46 = v50 == (182 - (92 + 89));
	v45 = v50 >= (3 - 1);
	v47 = (v18.Massacre:IsAvailable() and (v7:HealthPercentage() < (18 + 17))) or (v7:HealthPercentage() < (12 + 8));
end
local function v75()
	Smallcds = v10.ToggleIconFrame:GetToggle(3 - 2);
	AutoStance = v10.ToggleIconFrame:GetToggle(1 + 1);
	InterruptToggle = v10.ToggleIconFrame:GetToggle(6 - 3);
	Lowlevel = not v18.SlayersDominance:IsAvailable() and not v18.Demolish:IsAvailable();
	v49 = v6:GetEnemiesInMeleeRange(7 + 1);
	if v12() then
		v50 = #v49;
	else
		v50 = 1 + 0;
	end
	IsAvatar = v62(v23.Arms_TTD.AvatarTTD) and v61(v23.Arms_CDUSE.Avatar);
	IsRacials = v62(v23.Arms_TTD.RacialsTTD) and v61(v23.Arms_CDUSE.Racials);
	IsPotions = v62(v23.Arms_TTD.PotionsTTD) and (v23.Arms_CDUSE.Potionswhensolo or (not v23.Arms_CDUSE.Potionswhensolo and not v21.ISSolo())) and v61(v23.Arms_CDUSE.Potions);
	IsTrinket1 = v62(v23.Arms_TTD.TrinketsTTD) and v61(v23.Arms_CDUSE.Trinket1);
	IsTrinket2 = v62(v23.Arms_TTD.TrinketsTTD) and v61(v23.Arms_CDUSE.Trinket2);
	IsColossusSmash = v62(v23.Arms_TTD.ColossusSmashTTD) and v61(v23.Arms_CDUSE.ColossusSmash);
	IsWarbreaker = v62(v23.Arms_TTD.ColossusSmashTTD) and v61(v23.Arms_CDUSE.Warbreaker);
	IsThunderousRoar = v62(v23.Arms_TTD.ThunderousRoarTTD) and v61(v23.Arms_CDUSE.ThunderousRoar);
	IsChampionsSpear = v62(v23.Arms_TTD.ChampionsSpearTTD) and v61(v23.Arms_CDUSE.ChampionsSpear);
	IsBladestorm = v62(v23.Arms_TTD.BladestormTTD) and v61(v23.Arms_CDUSE.Bladestorm);
	IsWeapon = v62(v23.Arms_TTD.WeaponTTD) and v61(v23.Arms_CDUSE.Weapon);
	IsDemolish = v62(v23.Arms_TTD.DemolishTTD) and v61(v23.Arms_CDUSE.Demolish);
	local v97 = 0 - 0;
	if v18.RumblingEarth:IsAvailable() then
		v97 = 2 + 14;
	else
		v97 = 15 - 5;
	end
	if (v21.TargetIsValid() or v6:AffectingCombat()) then
		v48 = v7:IsSpellInRange(v18.MortalStrike);
		v51 = v3.BossFightRemains();
		v58 = true;
		v52 = v51;
		if (v52 == (12355 - (485 + 759))) then
			v58 = false;
			v52 = v3.FightRemains(v49, false);
		end
	end
	if (v18.BattleShout:IsCastable() and not v6:DebuffUp(v18.Corruption) and ((v21.GroupBuffMissing(v18.BattleShoutBuff, true) and (v23.Commons.BattleShout == LUAOBFUSACTOR_DECRYPT_STR_0("\221\172\94\79\79\156\95\214\171\87\73\4\219\90\209\177\75", "\40\190\196\59\44\36\188")) and (v6:IsInRaidArea() or v6:IsInDungeonArea())) or (v6:BuffDown(v18.BattleShoutBuff, true) and ((v23.Commons.BattleShout == LUAOBFUSACTOR_DECRYPT_STR_0("\51\75\208\173\186\126\5\57\70\215\244\239\110", "\109\92\37\188\212\154\29")) or (v23.Commons.BattleShout == LUAOBFUSACTOR_DECRYPT_STR_0("\7\231\161\192\58\26\19\231\171\207\52\26\3\253\171\214\33", "\58\100\143\196\163\81"))))) and not v6:IsMounted()) then
		if v10.Cast(v18.BattleShout) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\56\67\55\183\51\76\214\6\21\87\55", "\110\122\34\67\195\95\41\133");
		end
	end
	if v23.Commons.CCIncorperal then
		v17 = v21.IncorpCycle(v18.IntimidatingShout, 18 - 10, false, false);
		v17 = v21.IncorpCycle(v18.StormBolt, 1209 - (442 + 747), false, false);
		if v17 then
			return v17;
		end
	end
	local v98 = v6:IncomingSpell(Warrior.SpellReflectList);
	local v99 = v6:IncomingSpellreflection(Warrior.SpellReflectList);
	if (v99 and v10.DebugON()) then
		print(LUAOBFUSACTOR_DECRYPT_STR_0("\70\161\94\70\218\53\131\94\76\218\112\178\79\10\245\116\162\79\16\150", "\182\21\209\59\42") .. v99);
	end
	local v100 = v6:BuffUp(v18.SpellReflection) or (v98 and v18.SpellReflection:IsReady() and v23.Commons.AutoSpellreflection);
	if (v18.SpellReflection:IsReady() and v99 and v23.Commons.AutoSpellreflection) then
		if v11(v18.SpellReflection, true) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\132\71\192\17\45\254\133\82\195\17\36\189\163\94\202\19", "\222\215\55\165\125\65");
		end
	end
	v17 = v63();
	if v17 then
		return v17;
	end
	if (v18.BattleStance:IsCastable() and AutoStance and v6:BuffDown(v18.BattleStance, true) and (v6:HealthPercentage() > v23.Arms_Defensives.BattleStanceHP)) then
		if v11(v18.BattleStance) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\46\208\210\14\254\196\210\89\56\208\200\25\247\129\253\88\41\210\201\23\240\192\249\10\122", "\42\76\177\166\122\146\161\141");
		end
	end
	if v21.TargetIsValid() then
		if (not v23.Arms.AttackonlyinCombat or (v23.Arms.AttackonlyinCombat and v7:AffectingCombat())) then
			if not v57(v5.Target) then
				if not v6:AffectingCombat() then
					v17 = v64();
					if v17 then
						return v17;
					end
				end
				if (v23.Commons.Enabled.Potions and IsPotions and ((v7:DebuffRemains(v18.ColossusSmashDebuff) > (1143 - (832 + 303))) or (v51 < (971 - (88 + 858)))) and v48) then
					local v104 = v21.PotionSelected();
					if (v104 and v104:IsReady()) then
						v10.CastMacro(1 + 2, nil, nil, v104);
						return LUAOBFUSACTOR_DECRYPT_STR_0("\134\139\22\218\57\70\170\158\12\193\119", "\22\197\234\101\174\25");
					end
				end
				if (InterruptToggle and not v100) then
					v17 = v21.InterruptCycle(v18.Pummel, 5 + 0, true, nil, false);
					if v17 then
						return v17;
					end
					v17 = v23.Interrupt.UseStormbolt and v21.InterruptCycle(v18.StormBolt, 1 + 19, false, nil, true);
					v17 = v23.Interrupt.UseShockwave and v21.InterruptCycle(v18.Shockwave, v97, false, nil, true, true);
					if v17 then
						return v17;
					end
				end
				if v17 then
					return v17;
				end
				v74();
				if (v23.Commons.Enabled.Trinkets or v23.Commons.Enabled.Items) then
					v17 = v73();
					if v17 then
						return v17;
					end
				end
				if (v18.WreckingThrow:IsCastable() and v48 and (v7:BuffUp(v18.CorruptBuff) or v7:BuffUp(v18.SupernovaBuff))) then
					if v11(v18.WreckingThrow) then
						return LUAOBFUSACTOR_DECRYPT_STR_0("\26\38\160\223\125\166\217\129\109\0\173\206\121\184\151\181\37\61\160\208\114", "\230\77\84\197\188\22\207\183");
					end
				end
				if (v18.ArcaneTorrent:IsCastable() and IsRacials and v7:IsInRange(797 - (766 + 23)) and (v18.MortalStrike:CooldownRemains() > (4.5 - 3)) and (v6:Rage() < (68 - 18))) then
					if v11(v18.ArcaneTorrent, true) then
						return LUAOBFUSACTOR_DECRYPT_STR_0("\248\6\197\253\130\164\207\33\246\6\212\249\130\181\176\56\248\29\200\188\212", "\85\153\116\166\156\236\193\144");
					end
				end
				if (v18.LightsJudgment:IsCastable() and IsRacials and v7:IsSpellInRange(v18.LightsJudgment) and v7:DebuffDown(v18.ColossusSmashDebuff) and not v18.MortalStrike:CooldownUp()) then
					if v11(v18.LightsJudgment, true) then
						return LUAOBFUSACTOR_DECRYPT_STR_0("\168\233\74\187\240\19\155\234\88\183\227\13\161\238\89\243\233\1\173\238\13\226\180", "\96\196\128\45\211\132");
					end
				end
				if (v18.BagofTricks:IsCastable() and IsRacials and v7:IsSpellInRange(v18.BagofTricks) and v7:DebuffDown(v18.ColossusSmashDebuff) and not v18.MortalStrike:CooldownUp()) then
					if v11(v18.BagofTricks, true) then
						return LUAOBFUSACTOR_DECRYPT_STR_0("\55\140\124\96\221\169\139\204\39\132\120\84\193\239\185\217\60\131\59\14\128", "\184\85\237\27\63\178\207\212");
					end
				end
				if (v18.Berserking:IsCastable() and IsRacials and (((v7:TimeToDie() > (474 - 294)) and v6:BuffUp(v18.AvatarBuff)) or ((v7:TimeToDie() < (610 - 430)) and v47 and v6:BuffUp(v18.AvatarBuff)) or (v7:TimeToDie() < (1093 - (1036 + 37))))) then
					if v11(v18.Berserking, true) then
						return LUAOBFUSACTOR_DECRYPT_STR_0("\10\92\27\76\13\75\2\86\6\94\73\82\9\80\7\31\89\13", "\63\104\57\105");
					end
				end
				if (v18.BloodFury:IsCastable() and IsRacials and (v7:DebuffUp(v18.ColossusSmashDebuff))) then
					if v11(v18.BloodFury, true) then
						return LUAOBFUSACTOR_DECRYPT_STR_0("\9\139\171\75\15\184\162\81\25\158\228\73\10\142\170\4\90\209", "\36\107\231\196");
					end
				end
				if (v18.Fireblood:IsCastable() and IsRacials and (v7:DebuffUp(v18.ColossusSmashDebuff))) then
					if v11(v18.Fireblood, true) then
						return LUAOBFUSACTOR_DECRYPT_STR_0("\91\188\176\130\95\185\173\136\89\245\175\134\84\187\226\214\5", "\231\61\213\194");
					end
				end
				if (v18.AncestralCall:IsCastable() and IsRacials and (v7:DebuffUp(v18.ColossusSmashDebuff))) then
					if v11(v18.AncestralCall, true) then
						return LUAOBFUSACTOR_DECRYPT_STR_0("\8\163\62\118\26\185\47\114\5\146\62\114\5\161\125\126\8\164\51\51\91\253", "\19\105\205\93");
					end
				end
				if (v18.Demolish:IsAvailable() and v12() and (v50 > (2 + 0))) then
					local v105 = v65();
					if v105 then
						return v105;
					end
					if v10.CastAnnotated(v18.Pool, false, LUAOBFUSACTOR_DECRYPT_STR_0("\158\41\247\181", "\95\201\104\190\225")) then
						return LUAOBFUSACTOR_DECRYPT_STR_0("\159\196\206\194\239\205\206\220\239\232\206\194\160\216\210\219\188\234\206\235\231\130", "\174\207\171\161");
					end
				end
				if (v18.Demolish:IsAvailable() and v47) then
					local v106 = v66();
					if v106 then
						return v106;
					end
					if v10.CastAnnotated(v18.Pool, false, LUAOBFUSACTOR_DECRYPT_STR_0("\218\223\36\199", "\183\141\158\109\147\152")) then
						return LUAOBFUSACTOR_DECRYPT_STR_0("\28\6\233\0\108\15\233\30\108\42\233\0\35\26\245\25\63\44\254\9\47\28\242\9\100\64", "\108\76\105\134");
					end
				end
				if (v18.Demolish:IsAvailable() and v12() and (v50 == (3 - 1)) and not v47) then
					local v107 = v68();
					if v107 then
						return v107;
					end
					if v10.CastAnnotated(v18.Pool, false, LUAOBFUSACTOR_DECRYPT_STR_0("\220\228\152\213", "\174\139\165\209\129")) then
						return LUAOBFUSACTOR_DECRYPT_STR_0("\147\188\237\205\134\5\127\106\227\144\237\205\201\16\99\109\176\128\245\196\195\19\56\49", "\24\195\211\130\161\166\99\16");
					end
				end
				if v18.Demolish:IsAvailable() then
					local v108 = v67();
					if v108 then
						return v108;
					end
					if v10.CastAnnotated(v18.Pool, false, LUAOBFUSACTOR_DECRYPT_STR_0("\113\34\192\24", "\118\38\99\137\76\51")) then
						return LUAOBFUSACTOR_DECRYPT_STR_0("\205\41\10\30\73\38\242\52\69\49\6\44\242\53\22\7\26\19\201\110\76", "\64\157\70\101\114\105");
					end
				end
				if ((v18.SlayersDominance:IsAvailable() or Lowlevel) and v12() and (v50 > (2 + 0))) then
					local v109 = v69();
					if v109 then
						return v109;
					end
					if v10.CastAnnotated(v18.Pool, false, LUAOBFUSACTOR_DECRYPT_STR_0("\119\137\142\215", "\112\32\200\199\131")) then
						return LUAOBFUSACTOR_DECRYPT_STR_0("\28\95\83\180\131\173\45\62\16\111\180\194\178\39\62\113\83\157\139\226", "\66\76\48\60\216\163\203");
					end
				end
				if ((v18.SlayersDominance:IsAvailable() or Lowlevel) and v47) then
					local v110 = v70();
					if v110 then
						return v110;
					end
					if v10.CastAnnotated(v18.Pool, false, LUAOBFUSACTOR_DECRYPT_STR_0("\141\167\80\199", "\68\218\230\25\147\63\174")) then
						return LUAOBFUSACTOR_DECRYPT_STR_0("\157\37\92\64\246\171\37\65\12\133\161\43\74\73\164\136\50\86\79\163\185\47\27\5", "\214\205\74\51\44");
					end
				end
				if ((v18.SlayersDominance:IsAvailable() or Lowlevel) and v12() and (v50 == (1482 - (641 + 839))) and not v47) then
					local v111 = v72();
					if v111 then
						return v111;
					end
					if v10.CastAnnotated(v18.Pool, false, LUAOBFUSACTOR_DECRYPT_STR_0("\205\109\203\200", "\23\154\44\130\156")) then
						return LUAOBFUSACTOR_DECRYPT_STR_0("\33\169\162\162\118\21\30\180\237\157\58\18\8\163\191\157\33\22\20\182\229\231", "\115\113\198\205\206\86");
					end
				end
				if (v18.SlayersDominance:IsAvailable() or Lowlevel) then
					local v112 = v71();
					if v112 then
						return v112;
					end
					if v10.CastAnnotated(v18.Pool, false, LUAOBFUSACTOR_DECRYPT_STR_0("\179\118\215\110", "\58\228\55\158")) then
						return LUAOBFUSACTOR_DECRYPT_STR_0("\132\134\223\34\124\171\58\166\201\227\34\61\180\48\166\186\228\102\117", "\85\212\233\176\78\92\205");
					end
				end
				if v10.CastAnnotated(v18.Pool, false, LUAOBFUSACTOR_DECRYPT_STR_0("\125\121\161\214", "\130\42\56\232")) then
					return LUAOBFUSACTOR_DECRYPT_STR_0("\221\180\45\247\15\15\229\186\40\163\114\58\249\186\49\241\67\58\249", "\95\138\213\68\131\32");
				end
			end
		end
	end
end
local function v76()
	v10.ResetToggle();
	v23.Arms.Display();
	v18.MarkofFyralathDebuff:RegisterAuraTracking();
	v10:UpdateMacro(LUAOBFUSACTOR_DECRYPT_STR_0("\39\41\162\81\121\123", "\22\74\72\193\35"), LUAOBFUSACTOR_DECRYPT_STR_0("\99\108\247\93\108\40\178", "\56\76\25\132"));
	v10.ToggleIconFrame:AddButtonCustom("S", 914 - (910 + 3), LUAOBFUSACTOR_DECRYPT_STR_0("\77\204\170\42\195\125\229\184", "\175\62\161\203\70"), LUAOBFUSACTOR_DECRYPT_STR_0("\47\208\194\31\57\63\217\208", "\85\92\189\163\115"));
	v10.ToggleIconFrame:AddButtonCustom("A", 4 - 2, LUAOBFUSACTOR_DECRYPT_STR_0("\8\185\36\55\105\159\36\57\39\175\53", "\88\73\204\80"), LUAOBFUSACTOR_DECRYPT_STR_0("\47\150\4\73\58\206\47\141\19\67", "\186\78\227\112\38\73"));
	v10.ToggleIconFrame:AddButtonCustom("I", 1687 - (1466 + 218), LUAOBFUSACTOR_DECRYPT_STR_0("\213\89\233\80\65\104\233\71\233", "\26\156\55\157\53\51"), LUAOBFUSACTOR_DECRYPT_STR_0("\133\214\2\220\170\66\153\200\2", "\48\236\184\118\185\216"));
	v21.PostInitialMessage(33 + 38);
end
v10.SetAPL(1219 - (556 + 592), v75, v76);
