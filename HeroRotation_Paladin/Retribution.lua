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
local v9 = v5.Pet;
local v10 = v3.Spell;
local v11 = v3.Item;
local v12 = HeroRotation();
local v13 = v12.AoEON;
local v14 = v12.CDsON;
local v15 = v12.Cast;
local v16 = v12.Commons().Everyone.num;
local v17 = v12.Commons().Everyone.bool;
local v18 = math.min;
local v19 = C_Timer.After;
local v20 = v10.Paladin.Retribution;
local v21 = v11.Paladin.Retribution;
local v22 = {v21.AlgetharPuzzleBox:ID(),v21.ShadowedRazingAnnihilator:ID()};
local v23 = v12.Commons().Everyone;
local v24 = v12.Commons().Paladin;
local v25 = v12.GUISettingsGet();
local v26 = {[LUAOBFUSACTOR_DECRYPT_STR_0("\246\198\213\32\244\186\203", "\126\177\163\187\69\134\219\167")]=v25.General,[LUAOBFUSACTOR_DECRYPT_STR_0("\0\194\39\200\243\45\222", "\156\67\173\74\165")]=v25.APL.Paladin.Commons,[LUAOBFUSACTOR_DECRYPT_STR_0("\6\178\93\4\181\36\83\32\190\70\24", "\38\84\215\41\118\220\70")]=v25.APL.Paladin.Retribution,[LUAOBFUSACTOR_DECRYPT_STR_0("\98\19\54\49\241\95\26\38\29\233\94\5", "\158\48\118\66\114")]=v25.APL.Paladin.RetCooldowns,[LUAOBFUSACTOR_DECRYPT_STR_0("\153\33\4\2\71\129", "\155\203\68\112\86\19\197")]=v25.APL.Paladin.RetTTD,[LUAOBFUSACTOR_DECRYPT_STR_0("\116\216\34\212\69\121\233\241\72\218", "\152\38\189\86\156\32\24\133")]=v25.APL.Paladin.RetHealing};
local v27 = 8546 + 2565;
local v28 = 12236 - (936 + 189);
local v29;
local v30 = 0 + 0;
local v31 = 1613 - (1565 + 48);
local v32;
local v33 = ((v20.FinalVerdict:IsLearned()) and v20.FinalVerdict) or v20.TemplarsVerdict;
local v34;
local v35;
local v36, v37;
local v38;
local v39, v40;
local v41 = (v20.EternalFlame:IsAvailable() and v20.EternalFlame) or v20.WordofGlory;
local v42, v43;
local v44, v45;
local v46, v47;
local v48, v49;
local v50, v51;
local v52, v53;
local v54, v55;
local v56, v57;
local v58, v59;
local v60, v61;
local v62;
local v63 = 0 + 0;
local function v64()
	local v89, v90 = v6:GetTrinketData(v22);
	if ((v63 < (1143 - (782 + 356))) and ((v89.ID == (267 - (176 + 91))) or (v90.ID == (0 - 0)) or (v89.Level == (0 - 0)) or (v90.Level == (1092 - (975 + 117))) or ((v89.SpellID > (1875 - (157 + 1718))) and not v89.Usable) or ((v90.SpellID > (0 + 0)) and not v90.Usable))) then
		v63 = v63 + (3 - 2);
		v19(17 - 12, function()
			v64();
		end);
		return;
	end
	v42 = v89.Object;
	v43 = v90.Object;
	v44 = v89.ID;
	v45 = v90.ID;
	v46 = v89.Level;
	v47 = v90.Level;
	v48 = v89.Spell;
	v50 = v89.Range;
	v52 = v89.CastTime;
	v49 = v90.Spell;
	v51 = v90.Range;
	v53 = v90.CastTime;
	v54 = v89.Cooldown;
	v55 = v90.Cooldown;
	v56 = v89.Blacklisted;
	v57 = v90.Blacklisted;
	v58 = v42:HasUseBuff();
	v59 = v43:HasUseBuff();
	v60 = 1018.5 - (697 + 321);
	local v107 = ((v54 > (0 - 0)) and v54) or (1 - 0);
	if (v58 and (((v54 % (276 - 156)) == (0 + 0)) or (((224 - 104) % v107) == (0 - 0)))) then
		v60 = 1228 - (322 + 905);
	end
	v61 = 611.5 - (602 + 9);
	local v108 = ((v55 > (1189 - (449 + 740))) and v55) or (873 - (826 + 46));
	if (v59 and (((v55 % (1067 - (245 + 702))) == (0 - 0)) or (((39 + 81) % v108) == (1898 - (260 + 1638))))) then
		v61 = 441 - (382 + 58);
	end
	v62 = 3 - 2;
	local v109 = ((v42:BuffDuration() > (0 + 0)) and v42:BuffDuration()) or (1 - 0);
	local v110 = ((v43:BuffDuration() > (0 - 0)) and v43:BuffDuration()) or (1206 - (902 + 303));
	if ((not v58 and v59) or (v59 and (((v55 / v110) * v61) > ((v54 / v109) * v60)))) then
		v62 = 3 - 1;
	end
end
v64();
local function v65()
	local v111 = (11 - 6) - v20.TemplarStrike:TimeSinceLastCast();
	if (v20.TemplarSlash:TimeSinceLastCast() < v20.TemplarStrike:TimeSinceLastCast()) then
		v111 = 0 + 0;
	end
	return ((v111 > (1690 - (1121 + 569))) and v111) or (214 - (22 + 192));
end
v3:RegisterForEvent(function()
	Equip = v6:GetEquipment();
	v42 = (Equip[696 - (483 + 200)] and v11(Equip[1476 - (1404 + 59)])) or v11(0 - 0);
	v43 = (Equip[18 - 4] and v11(Equip[779 - (468 + 297)])) or v11(562 - (334 + 228));
end, LUAOBFUSACTOR_DECRYPT_STR_0("\204\123\134\127\217\101\152\99\205\98\142\118\209\114\137\114\195\116\143\103\210\112\130\98", "\38\156\55\199"));
v3:RegisterForEvent(function()
	v27 = 37477 - 26366;
	v28 = 25754 - 14643;
end, LUAOBFUSACTOR_DECRYPT_STR_0("\152\81\93\17\54\70\197\113\141\90\89\6\44\81\212\98\138\81\89\12", "\35\200\29\28\72\115\20\154"));
v3:RegisterForEvent(function()
	v33 = ((v20.FinalVerdict:IsLearned()) and v20.FinalVerdict) or v20.TemplarsVerdict;
end, LUAOBFUSACTOR_DECRYPT_STR_0("\42\143\244\243\161\31\11\58\151\240\241\170\9\16", "\84\121\223\177\191\237\76"), LUAOBFUSACTOR_DECRYPT_STR_0("\151\115\232\146\20\117\20\254\136\102\236\140\22\111\25\239\132\98\232\130", "\161\219\54\169\192\90\48\80"));
local function v66()
	return v21.ManicGrieftorch:IsEquipped() and (v21.ManicGrieftorch:CooldownUp() or (v21.ManicGrieftorch:CooldownRemains() <= v6:GCDRemains()));
end
local function v67()
	return v21.AlgetharPuzzleBox:IsEquipped() and (v21.AlgetharPuzzleBox:CooldownUp() or (v21.AlgetharPuzzleBox:CooldownRemains() <= v6:GCDRemains()));
end
local function v68()
	local v112 = v6:GCDRemains();
	local v113 = v18(v20.CrusaderStrike:CooldownRemains(), v20.BladeofJustice:CooldownRemains(), v20.Judgment:CooldownRemains(), (v20.HammerofWrath:IsUsable() and v20.HammerofWrath:CooldownRemains()) or (18 - 8), v20.WakeofAshes:CooldownRemains());
	if (v112 > v113) then
		return v112;
	end
	return v113;
end
local function v69()
	for v145, v146 in pairs(v5.Party) do
		if (v146:Role() == LUAOBFUSACTOR_DECRYPT_STR_0("\97\103\33\9\108\112", "\69\41\34\96")) then
			v37 = v146;
		end
		if (v146:Role() == LUAOBFUSACTOR_DECRYPT_STR_0("\136\226\249\33", "\75\220\163\183\106\98")) then
			v36 = v146;
		end
	end
end
local function v70(v114)
	local v115 = UnitGUID(LUAOBFUSACTOR_DECRYPT_STR_0("\22\187\153\48\220\22\174\138\37\222\7\174", "\185\98\218\235\87"));
	if (v114 ~= nil) then
		for v163, v164 in pairs(v114) do
			if ((v164:GUID() == v115) and ((v7:CastSpellID() == (91093 + 229695)) or (v7:CastSpellID() == (323966 - (141 + 95))))) then
				if (v164 ~= nil) then
					return v164;
				end
			end
		end
	end
end
v3:RegisterForEvent(function()
	v69();
end, LUAOBFUSACTOR_DECRYPT_STR_0("\251\16\6\223\251\152\244\25\9\210\251\152\226\18\0\217\233\133\249\16\3", "\202\171\92\71\134\190"), LUAOBFUSACTOR_DECRYPT_STR_0("\14\243\3\189\25\254\30\167\26\245\9\186\22\244\28\172\8\245\9", "\232\73\161\76"), LUAOBFUSACTOR_DECRYPT_STR_0("\154\253\102\114\48\132\245\109\124\58\158\253", "\126\219\185\34\61"));
local function v71(v116)
	local v117 = 0 + 0;
	for v147, v148 in pairs(v5.Party) do
		if v23.unitHasDebuffFromList(v23.DebuffList[v116], v148) then
			v117 = v117 + (2 - 1);
		end
	end
	return v117;
end
local function v72(v118, v119)
	local v120 = v23.DebuffList[v119];
	local v121 = 0 - 0;
	for v149, v150 in pairs(v5.Party) do
		if ((v150 ~= LUAOBFUSACTOR_DECRYPT_STR_0("\28\194\95\107\123\101", "\135\108\174\62\18\30\23\147")) and v23.unitHasDebuffFromList(v120, v150)) then
			v121 = v121 + 1 + 0;
			v150:Cast(v118);
			return LUAOBFUSACTOR_DECRYPT_STR_0("\178\224\57\219\29\162", "\167\214\137\74\171\120\206\83");
		end
		if ((v121 == (0 - 0)) and v23.unitHasDebuffFromList(v120, v6)) then
			v5(v26.RetHealing.UnboundFreedomUnit):Cast(v118);
			return LUAOBFUSACTOR_DECRYPT_STR_0("\132\254\114\78\253\171\142\243\38\88\252\231\158\254\59\73", "\199\235\144\82\61\152");
		end
	end
end
local v73 = {(117665 + 108298),(118079 + 82103),(96988 + 99366),(226249 - (574 + 191)),(491981 - 295605),(261590 - (254 + 595)),(562079 - 135419),(1142400 - 729895),(412217 - 156403),(746480 - 491046),(28598 + 235552),(412506 - (118 + 688)),(79791 + 332167),(891791 - 627235),(389426 - 187693),(653470 - 385563),(657837 - 397286),(259203 - (503 + 1293)),(308544 + 118115),((431141 + 190119) - (121318 + 273979))};
local function v74(v122, v123)
	local v124 = nil;
	if (v123 == nil) then
		for v165, v166 in pairs(v122) do
			if ((v166:Role() ~= LUAOBFUSACTOR_DECRYPT_STR_0("\51\55\151\0", "\75\103\118\217")) and ((v26.RetHealing.BoPDebuff and (v23.unitHasDebuffFromList(v23.DebuffList[LUAOBFUSACTOR_DECRYPT_STR_0("\229\88\117\17\189", "\126\167\52\16\116\217")], v166) or v23.unitHasDebuffFromList(v73, v166))) or (v166:HealthPercentageWeighted() <= v26.RetHealing.BoPHP)) and v166:DebuffDown(v20.ForbearanceDebuff)) then
				v124 = v166;
			end
		end
	end
	if (v123 == true) then
		if (((v26.RetHealing.BoPDebuff and (v23.unitHasDebuffFromList(v23.DebuffList[LUAOBFUSACTOR_DECRYPT_STR_0("\234\34\37\133\176", "\156\168\78\64\224\212\121")], v6) or v23.unitHasDebuffFromList(v73, v6))) or (v6:HealthPercentageWeighted() <= v26.RetHealing.BoPHP)) and v6:DebuffDown(v20.ForbearanceDebuff)) then
			v124 = v6;
		end
	end
	return v124;
end
function PreventWithFreedomIfTargetOfTargetIsPlayer(v125)
	local v126 = UnitGUID(LUAOBFUSACTOR_DECRYPT_STR_0("\23\226\164\215\2\252", "\174\103\142\197"));
	local v127 = LUAOBFUSACTOR_DECRYPT_STR_0("\66\41\77\63\32\74", "\152\54\72\63\88\69\62");
	if UnitExists(v127) then
		local v157 = LUAOBFUSACTOR_DECRYPT_STR_0("\192\197\252\91\209\208\250\93\198\195\235\72", "\60\180\164\142");
		if (UnitExists(v157) and (UnitGUID(v157) == v126)) then
			if ((v7:CastSpellID() == v125) and UnitIsPlayer(v127)) then
				return true;
			end
		end
	end
	return false;
end
local function v75()
	if (v25.General.AutoTab and v6:AffectingCombat()) then
		v12.TopPanelAlternative:ChangeIcon(1 + 0, 536 - (43 + 490));
		return LUAOBFUSACTOR_DECRYPT_STR_0("\121\75\17\38\103\249\19\90\30\17\38\103\249\19\74\89\0\61", "\114\56\62\101\73\71\141");
	end
end
function EnemiesWithIDInCCRange(v128)
	local v129 = v6:GetEnemiesInRange(743 - (711 + 22));
	local v130 = 0 - 0;
	for v151, v152 in pairs(v129) do
		if (v152:NPCID() == v128) then
			v130 = v130 + (860 - (240 + 619));
		end
	end
	return v130;
end
local function v76(v131)
	return (v131 ~= LUAOBFUSACTOR_DECRYPT_STR_0("\150\230\207\132\141\250\222\192", "\164\216\137\187")) and (((v131 == LUAOBFUSACTOR_DECRYPT_STR_0("\229\239\37\186\230\221\4\221\234\53\189\177\240\24", "\107\178\134\81\210\198\158")) and v12.CDsON()) or ((v131 == LUAOBFUSACTOR_DECRYPT_STR_0("\15\7\150\206\234\11\3\131\202\166\120\1\144\134\137\55\1\142\194\165\47\0\145", "\202\88\110\226\166")) and (SmallCDToggle or v12.CDsON())) or ((v131 == LUAOBFUSACTOR_DECRYPT_STR_0("\244\6\150\255\138\240\2\131\251\198\131\44\166\228", "\170\163\111\226\151")) and SmallCDToggle) or ((v131 == LUAOBFUSACTOR_DECRYPT_STR_0("\62\62\242\21\65\53\42\30\37\188\44", "\73\113\80\210\88\46\87")) and (v40 >= v26.RetCooldowns.Mobcount)) or ((v131 == LUAOBFUSACTOR_DECRYPT_STR_0("\174\34\141\63\232\131\47\194\7\233\149\108\194\0\167\162\35\194\30\227\142\59\195\1", "\135\225\76\173\114")) and ((v40 >= v26.RetCooldowns.Mobcount) or v14())) or (v131 == LUAOBFUSACTOR_DECRYPT_STR_0("\59\225\175\177\181\174", "\199\122\141\216\208\204\221")) or ((v131 == LUAOBFUSACTOR_DECRYPT_STR_0("\130\211\80\210\119\229\190\216\3", "\150\205\189\112\144\24")) and (v34 or v7:IsDummy())) or ((v131 == LUAOBFUSACTOR_DECRYPT_STR_0("\8\139\189\79\11\157\31\4\101\139\173\12\38\135\2\3", "\112\69\228\223\44\100\232\113")) and (v34 or v7:IsDummy() or (v40 >= v26.RetCooldowns.Mobcount))));
end
local function v77(v132)
	local v133 = v26.RetHealing.IntercessionUnit;
	if (v133 == LUAOBFUSACTOR_DECRYPT_STR_0("\245\19\11", "\230\180\127\103\179\214\28")) then
		for v167, v168 in pairs(v132) do
			if v168:IsDeadOrGhost() then
				return v168;
			end
		end
		return nil;
	end
	local v134 = {[LUAOBFUSACTOR_DECRYPT_STR_0("\162\10\81\67", "\128\236\101\63\38\132\33")]={},[LUAOBFUSACTOR_DECRYPT_STR_0("\152\168\31\79", "\175\204\201\113\36\214\139")]={LUAOBFUSACTOR_DECRYPT_STR_0("\115\237\27\247", "\100\39\172\85\188")},[LUAOBFUSACTOR_DECRYPT_STR_0("\133\125\184\140\54\191", "\83\205\24\217\224")]={LUAOBFUSACTOR_DECRYPT_STR_0("\206\224\236\17\195\247", "\93\134\165\173")},[LUAOBFUSACTOR_DECRYPT_STR_0("\138\243\207\201\122\207\188\122\254\218\196\195\54\203\160", "\30\222\146\161\162\90\174\210")]={LUAOBFUSACTOR_DECRYPT_STR_0("\209\111\94\33", "\106\133\46\16"),LUAOBFUSACTOR_DECRYPT_STR_0("\112\5\82\208\127\114", "\32\56\64\19\156\58")},[LUAOBFUSACTOR_DECRYPT_STR_0("\126\236", "\224\58\168\133\54\58\146")]={LUAOBFUSACTOR_DECRYPT_STR_0("\125\119\102\220\82\163\181", "\107\57\54\43\157\21\230\231")}};
	local v135 = v134[v133] or {};
	for v153, v154 in pairs(v132) do
		local v155 = v154:Role();
		local v156 = v154:IsDeadOrGhost();
		for v158, v159 in ipairs(v135) do
			if ((v155 == v159) and v156) then
				return v154;
			end
		end
	end
	return nil;
end
local function v78(v136, v137, v138)
	if (v34 or v23.ISSolo() or (v138 == (0 + 0)) or ((v28 >= v138) and (v28 < (4164 + 3613)))) then
		v12.Cast(v136, v137);
		return LUAOBFUSACTOR_DECRYPT_STR_0("\239\191\53\181\186\221\220\207\203", "\175\187\235\113\149\217\188") .. v136:Name();
	end
end
local function v79(v139)
	return v34 or v23.ISSolo() or (v139 == (0 - 0)) or v23.Buggedmobs[v7:NPCID()] or ((v28 >= v139) and (v28 < (25118 - 17341)));
end
local function v80()
	if (v33:IsReady() and (v30 >= (1743 - (404 + 1335))) and v7:IsSpellInRange(v33)) then
		if v15(v33) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\57\166\149\68\230\107\56\42\170\147\72\234\122\108\124\191\147\73\224\118\117\62\174\149\12\177", "\24\92\207\225\44\131\25");
		end
	end
	if (v20.BladeofJustice:IsCastable() and v7:IsSpellInRange(v20.BladeofJustice)) then
		if v15(v20.BladeofJustice) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\73\223\185\72\30\66\68\213\135\70\14\110\95\218\187\73\91\109\89\214\187\67\22\127\74\199\248\24", "\29\43\179\216\44\123");
		end
	end
	if (v20.Judgment:IsCastable() and v7:IsSpellInRange(v20.Judgment)) then
		if v15(v20.Judgment, nil, nil, not v7:IsSpellInRange(v20.Judgment)) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\183\204\36\75\176\220\46\88\253\201\50\73\190\214\45\78\188\205\96\26", "\44\221\185\64");
		end
	end
	if (v20.HammerofWrath:IsReady() and v7:IsSpellInRange(v20.HammerofWrath)) then
		if v15(v20.HammerofWrath, true) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\9\230\69\82\118\19\216\71\89\76\22\245\73\75\123\65\247\90\90\112\14\234\74\94\103\65\191", "\19\97\135\40\63");
		end
	end
	if (v20.CrusaderStrike:IsCastable() and v7:IsSpellInRange(v20.CrusaderStrike)) then
		if v15(v20.CrusaderStrike) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\173\78\38\40\46\53\171\78\12\40\59\35\167\87\54\123\126\97", "\81\206\60\83\91\79");
		end
	end
end
local function v81()
	if (v26.Commons.Enabled.Potions and PotionSetting and ((AvengingWrathSetting and v6:BuffUp(v20.AvengingWrathBuff)) or (CrusadeSetting and v6:BuffUp(v20.CrusadeBuff)) or (ExecutionSentenceSetting and v7:DebuffUp(v20.ExecutionSentenceDebuff)) or (v27 < (436 - (183 + 223))))) then
		local v160 = v23.PotionSelected();
		if (v160 and v160:IsReady()) then
			v12.CastMacro(3 - 0, nil, nil, v160);
			return LUAOBFUSACTOR_DECRYPT_STR_0("\109\170\195\102\111\243\66\176\71\164\222", "\196\46\203\176\18\79\163\45");
		end
	end
	if (RacialsSetting and v20.LightsJudgment:IsCastable()) then
		if v15(v20.LightsJudgment, false, nil, not v7:IsInRange(27 + 13)) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\180\43\121\22\48\232\208\178\55\122\25\41\254\225\172\98\125\17\43\247\235\183\53\112\13\100\175", "\143\216\66\30\126\68\155");
		end
	end
	if (RacialsSetting and v20.Fireblood:IsCastable() and (v6:BuffUp(v20.AvengingWrathBuff) or (v6:BuffUp(v20.CrusadeBuff) and (v6:BuffStack(v20.CrusadeBuff) == (4 + 6))))) then
		if v15(v20.Fireblood, false) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\172\193\31\206\199\175\216\238\174\136\14\196\202\175\211\238\189\198\30\139\147", "\129\202\168\109\171\165\195\183");
		end
	end
	if (v20.Fireblood:IsCastable() and v20.Fireblood:IsCastable() and (v6:BuffUp(v20.AvengingWrathBuff) or (v6:BuffUp(v20.CrusadeBuff) and (v6:BuffStack(v20.CrusadeBuff) == (347 - (10 + 327)))) or v7:DebuffUp(v20.ExecutionSentenceDebuff))) then
		if v15(v20.Fireblood, false) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\36\81\37\221\220\24\233\45\92\119\219\209\27\234\38\87\32\214\205\84\176", "\134\66\56\87\184\190\116");
		end
	end
	if v26.Commons.Enabled.Trinkets then
		if (v42:IsReady() and Trinket1Setting and not v56 and ((((((v20.Crusade:IsLearned() and not CrusadeSetting) or (v20.AvengingWrath:IsLearned() and not AvengingWrathSetting) or (v6:BuffUp(v20.AvengingWrathBuff) and (v20.AvengingWrath:CooldownRemains() > (28 + 12))) or (v6:BuffUp(v20.CrusadeBuff) and (v6:BuffStack(v20.CrusadeBuff) == (348 - (118 + 220))))) and not v20.RadiantGlory:IsAvailable()) or (v20.RadiantGlory:IsAvailable() and ((not v20.ExecutionSentence:IsAvailable() and v20.WakeofAshes:CooldownUp()) or v7:DebuffUp(v20.ExecutionSentenceDebuff)))) and (not v43:HasCooldown() or v43:CooldownDown() or (v62 == (1 + 0)))) or (v42:BuffDuration() >= v28))) then
			if v15(v42) then
				return LUAOBFUSACTOR_DECRYPT_STR_0("\41\34\12\132\16\255\36\56\124\55\6\169\89\255\51\60\50\58\12\175\72\171\105", "\85\92\81\105\219\121\139\65") .. v42:Name() .. LUAOBFUSACTOR_DECRYPT_STR_0("\180\243\83\74\115\211\249\188\71\75\111\159\165", "\191\157\211\48\37\28");
			end
		end
		if (v43:IsReady() and Trinket2Setting and not v57 and ((((((v20.Crusade:IsLearned() and not CrusadeSetting) or (v20.AvengingWrath:IsLearned() and not AvengingWrathSetting) or (v6:BuffUp(v20.AvengingWrathBuff) and (v20.AvengingWrath:CooldownRemains() > (489 - (108 + 341)))) or (v6:BuffUp(v20.CrusadeBuff) and (v6:BuffStack(v20.CrusadeBuff) == (1 + 0)))) and not v20.RadiantGlory:IsAvailable()) or (v20.RadiantGlory:IsAvailable() and ((not v20.ExecutionSentence:IsAvailable() and v20.WakeofAshes:CooldownUp()) or v7:DebuffUp(v20.ExecutionSentenceDebuff)))) and (not v42:HasCooldown() or v42:CooldownDown() or (v62 == (8 - 6)))) or (v43:BuffDuration() >= v28))) then
			if v15(v43) then
				return LUAOBFUSACTOR_DECRYPT_STR_0("\202\12\241\35\51\203\26\249\92\60\208\13\180\8\40\214\17\255\25\46\141\95\188", "\90\191\127\148\124") .. v43:Name() .. LUAOBFUSACTOR_DECRYPT_STR_0("\49\199\45\24\119\139\42\24\111\137\61\87\32", "\119\24\231\78");
			end
		end
		if (v42:IsReady() and Trinket1Setting and not v56 and not v58 and (v43:CooldownDown() or not v59 or (v20.Crusade:IsLearned() and not CrusadeSetting) or (v20.AvengingWrath:IsLearned() and not AvengingWrathSetting) or (v6:BuffDown(v20.CrusadeBuff) and (v20.Crusade:CooldownRemains() > (1513 - (711 + 782)))) or (v6:BuffDown(v20.AvengingWrathBuff) and (v20.AvengingWrath:CooldownRemains() > (38 - 18))))) then
			if v15(v42) then
				return LUAOBFUSACTOR_DECRYPT_STR_0("\151\62\160\117\213\84\20\143\109\163\69\206\0\5\144\36\171\65\217\84\64\194\101", "\113\226\77\197\42\188\32") .. v42:Name() .. LUAOBFUSACTOR_DECRYPT_STR_0("\115\86\247\186\53\26\240\186\45\24\231\245\107\70", "\213\90\118\148");
			end
		end
		if (v43:IsReady() and Trinket2Setting and not v57 and not v59 and (v42:CooldownDown() or not v58 or (v20.Crusade:IsLearned() and not CrusadeSetting) or (v20.AvengingWrath:IsLearned() and not AvengingWrathSetting) or (v6:BuffDown(v20.CrusadeBuff) and (v20.Crusade:CooldownRemains() > (489 - (270 + 199)))) or (v6:BuffDown(v20.AvengingWrathBuff) and (v20.AvengingWrath:CooldownRemains() > (7 + 13))))) then
			if v15(v43) then
				return LUAOBFUSACTOR_DECRYPT_STR_0("\78\61\177\105\68\79\43\185\22\75\84\60\244\66\95\82\32\191\83\89\9\110\252", "\45\59\78\212\54") .. v43:Name() .. LUAOBFUSACTOR_DECRYPT_STR_0("\89\22\128\132\137\34\169\255\7\88\144\203\215\124", "\144\112\54\227\235\230\78\205");
			end
		end
	end
	if v26.Commons.Enabled.Items then
		if (v21.BestinSlotsMelee:IsEquippedAndReady() and WeaponSetting and v7:IsInRange(1824 - (580 + 1239)) and (v42:CooldownDown() or not v42:HasUseBuff()) and (v43:CooldownDown() or not v43:HasUseBuff())) then
			v12.CastMacro(2 - 1, nil, nil, v21.BestinSlotsMelee);
			return LUAOBFUSACTOR_DECRYPT_STR_0("\145\45\28\232\217\85\128\36\0\232\195\118\182\36\10\249\144\27\176\39\0\240\212\84\164\38\28\188\129\11", "\59\211\72\111\156\176");
		end
		if (v21.Fyralath:IsEquippedAndReady() and v14() and WeaponSetting and v7:IsInRange(5 + 0) and (v20.MarkofFyralathDebuff:AuraActiveCount() > (0 + 0)) and v6:BuffDown(v20.AvengingWrathBuff) and v6:BuffDown(v20.CrusadeBuff)) then
			v12.CastMacro(1 + 0, nil, nil, v21.Fyralath);
			return LUAOBFUSACTOR_DECRYPT_STR_0("\104\158\241\44\66\134\247\37\14\132\226\62\90", "\77\46\231\131");
		end
	end
	if (v20.ShieldofVengeance:IsCastable() and (v28 > (39 - 24)) and (not v20.ExecutionSentence:IsAvailable() or v7:DebuffDown(v20.ExecutionSentence))) then
		if v15(v20.ShieldofVengeance, false) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\169\92\191\69\182\80\137\79\188\107\160\69\180\83\179\65\180\87\179\0\185\91\185\76\190\91\161\78\169\20\231\18", "\32\218\52\214");
		end
	end
	if (v20.ExecutionSentence:IsCastable() and v7:IsInRange(19 + 11) and ExecutionSentenceSetting and (v7:TimeToDie() > (1175 - (645 + 522))) and ((v6:BuffDown(v20.CrusadeBuff) and (v20.Crusade:CooldownRemains() > (1805 - (1010 + 780)))) or (v6:BuffStack(v20.CrusadeBuff) == (10 + 0)) or (not v20.Crusade:IsAvailable() and (v20.AvengingWrath:CooldownRemains() < (0.75 - 0))) or (v20.AvengingWrath:CooldownRemains() > (43 - 28)) or v20.RadiantGlory:IsAvailable() or (v20.Crusade:IsLearned() and not CrusadeSetting) or (v20.AvengingWrath:IsLearned() and not AvengingWrathSetting)) and (((v30 >= (1840 - (1045 + 791))) and (v3.CombatTime() < (12 - 7))) or ((v30 >= (4 - 1)) and (v3.CombatTime() > (510 - (351 + 154)))) or ((v30 >= (1576 - (1281 + 293))) and (v20.DivineAuxiliary:IsAvailable() or v20.RadiantGlory:IsAvailable()))) and (((v7:TimeToDie() > (274 - (28 + 238))) and not v20.ExecutionersWill:IsAvailable()) or (v7:TimeToDie() > (26 - 14))) and (v20.WakeofAshes:CooldownRemains() < v6:GCD())) then
		if v15(v20.ExecutionSentence) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\75\15\52\171\228\164\76\85\64\40\34\173\255\164\64\84\77\18\113\171\254\191\73\94\65\0\63\187\177\225\17", "\58\46\119\81\200\145\208\37");
		end
	end
	if (v20.AvengingWrath:IsCastable() and v7:IsInRange(1564 - (1381 + 178)) and AvengingWrathSetting and (((v30 >= (4 + 0)) and (v3.CombatTime() < (5 + 0))) or ((v30 >= (2 + 1)) and (v3.CombatTime() > (17 - 12))) or ((v30 >= (2 + 0)) and v20.DivineAuxiliary:IsAvailable() and (v20.ExecutionSentence:CooldownUp() or v20.FinalReckoning:CooldownUp()))) and ((v40 <= (471 - (381 + 89))) or (v7:TimeToDie() > (9 + 1)))) then
		if v15(v20.AvengingWrath, false) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\42\154\53\162\174\180\56\44\179\39\190\168\169\62\107\143\63\163\165\185\57\60\130\35\236\248\235", "\86\75\236\80\204\201\221");
		end
	end
	if (v20.Crusade:IsCastable() and v7:IsInRange(4 + 1) and CrusadeSetting and (((v30 >= (8 - 3)) and (v3.CombatTime() < (1161 - (1074 + 82)))) or ((v30 >= (6 - 3)) and (v3.CombatTime() >= (1789 - (214 + 1570)))))) then
		if v15(v20.Crusade, false) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\113\83\98\150\255\143\119\1\116\138\241\135\118\78\96\139\237\203\35\25", "\235\18\33\23\229\158");
		end
	end
	if (v20.FinalReckoning:IsCastable() and v7:IsInMeleeRange(1460 - (990 + 465)) and FinalReckoningSetting and (((v30 >= (2 + 2)) and (v3.CombatTime() < (4 + 4))) or ((v30 >= (3 + 0)) and (v3.CombatTime() >= (31 - 23))) or ((v30 >= (1728 - (1668 + 58))) and (v20.DivineAuxiliary:IsAvailable() or v20.RadiantGlory:IsAvailable()))) and (not AvengingWrathSetting or (v20.AvengingWrath:CooldownRemains() > (636 - (512 + 114))) or (v20.Crusade:CooldownDown() and (v6:BuffDown(v20.CrusadeBuff) or (v6:BuffStack(v20.CrusadeBuff) >= (26 - 16)))) or (v20.RadiantGlory:IsAvailable() and (v6:BuffUp(v20.AvengingWrathBuff) or (v20.Crusade:IsAvailable() and (v20.WakeofAshes:CooldownRemains() < v6:GCD())))))) then
		if v12.CastTarget(v20.FinalReckoning, v12.TName().PLAYER) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\86\179\207\186\92\133\211\190\83\177\206\181\89\180\198\251\83\181\206\183\84\181\214\181\67\250\147\235", "\219\48\218\161");
		end
	end
end
local function v82()
	v32 = ((v40 >= (3 - 1)) or v6:BuffUp(v20.EmpyreanPowerBuff) or (not v20.FinalVerdict:IsAvailable() and v20.TempestoftheLightbringer:IsAvailable())) and v6:BuffDown(v20.EmpyreanLegacyBuff) and not (v6:BuffUp(v20.DivineArbiterBuff) and (v6:BuffStack(v20.DivineArbiterBuff) > (83 - 59)));
	if (v20.HammerofLight:IsReady() and v7:IsInRange(6 + 6) and (v20.HammerofLight:IsReady() or not v20.DivineHammer:IsAvailable() or v24.DivineHammerActive or (v20.DivineHammer:CooldownRemains() > (2 + 8)))) then
		if v15(v20.HammerofLight, true) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\236\112\113\68\222\93\223\235\119\67\69\210\72\232\240\49\122\64\213\70\243\236\116\110\90\155\29", "\128\132\17\28\41\187\47");
		end
	end
	if (v20.DivineHammer:IsReady() and not v24.DivineHammerActive and v7:IsInRange(7 + 1)) then
		if v15(v20.DivineHammer) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\5\59\16\51\83\4\13\14\59\80\12\55\20\122\91\8\60\15\41\85\4\32\21\122\9", "\61\97\82\102\90");
		end
	end
	if (v20.DivineStorm:IsReady() and v32 and not v20.HammerofLight:IsReady() and (v20.DivineHammer:CooldownDown() or v24.DivineHammerActive or not v20.DivineHammer:IsAvailable()) and (not CrusadeSetting or not v20.Crusade:IsAvailable() or (v20.Crusade:CooldownRemains() > (v31 * (10 - 7))) or (v6:BuffUp(v20.CrusadeBuff) and (v6:BuffStack(v20.CrusadeBuff) < (2004 - (109 + 1885)))) or v20.RadiantGlory:IsAvailable())) then
		if v15(v20.DivineStorm) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\168\39\189\66\201\82\33\26\184\33\185\70\135\81\23\7\165\61\163\78\213\68\94\95", "\105\204\78\203\43\167\55\126");
		end
	end
	if (v20.JusticarsVengeance:IsReady() and v7:IsInRange(1477 - (1269 + 200)) and (not v20.Crusade:IsAvailable() or (not AvengingWrathSetting and not CrusadeSetting) or (v20.Crusade:CooldownRemains() > (v31 * (5 - 2))) or (v6:BuffUp(v20.CrusadeBuff) and (v6:BuffStack(v20.CrusadeBuff) < (825 - (98 + 717)))) or v20.RadiantGlory:IsAvailable()) and not v20.HammerofLight:IsReady() and (not v6:BuffUp(v20.DivineHammerBuff) or v24.DivineHammerActive or not v20.DivineHammer:IsAvailable())) then
		if v15(v20.JusticarsVengeance) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\175\191\48\10\26\7\198\67\182\149\53\27\29\3\194\80\171\169\38\94\21\13\201\88\182\162\38\12\0\68\159", "\49\197\202\67\126\115\100\167");
		end
	end
	if (v33:IsReady() and v7:IsSpellInRange(v33) and (not CrusadeSetting or not v20.Crusade:IsAvailable() or (not AvengingWrathSetting and not CrusadeSetting) or (v20.Crusade:CooldownRemains() > (v31 * (829 - (802 + 24)))) or (v6:BuffUp(v20.CrusadeBuff) and (v6:BuffStack(v20.CrusadeBuff) < (17 - 7))) or v20.RadiantGlory:IsAvailable()) and not v20.HammerofLight:IsReady() and (not v6:BuffUp(v20.DivineHammerBuff) or not v20.DivineHammer:IsAvailable())) then
		if v15(v33) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\50\82\203\33\133\68\30\33\94\205\45\137\85\74\119\93\214\39\137\69\86\50\73\204\105\214", "\62\87\59\191\73\224\54");
		end
	end
end
local function v83()
	if (((v30 == (6 - 1)) or ((v30 == (1 + 3)) and v6:BuffUp(v20.DivineResonanceBuff)) or v6:BuffUp(v20.TWW_S2_4pcBuff)) and v20.WakeofAshes:CooldownDown()) then
		local v161 = v82();
		if v161 then
			return v161;
		end
	end
	if (v20.TemplarSlash:IsReady() and v7:IsInMeleeRange(4 + 1) and (v65() < (v6:GCD() * (1 + 1)))) then
		if v15(v20.TemplarSlash) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\243\7\247\217\235\3\232\246\244\14\251\218\239\66\253\204\233\7\232\200\243\13\232\218\167\80", "\169\135\98\154");
		end
	end
	if (v20.BladeofJustice:IsCastable() and v7:IsSpellInRange(v20.BladeofJustice) and v7:DebuffDown(v20.ExpurgationDebuff) and v20.HolyFlames:IsAvailable() and v20.DivineToll:CooldownDown()) then
		if v15(v20.BladeofJustice) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\201\123\37\80\248\12\199\205\72\46\65\238\39\193\200\114\100\83\248\61\205\217\118\48\91\239\32\136\159", "\168\171\23\68\52\157\83");
		end
	end
	if (v20.WakeofAshes:IsCastable() and WakeofAshesSetting and v7:IsInRange(4 + 10) and (not v20.LightsGuidance:IsAvailable() or ((v30 >= (5 - 3)) and v20.LightsGuidance:IsAvailable())) and ((v20.AvengingWrath:CooldownRemains() > (19 - 13)) or not AvengingWrathSetting or (v20.Crusade:IsAvailable() and ((v20.Crusade:CooldownRemains() > (3 + 3)) or not CrusadeSetting)) or v20.RadiantGlory:IsAvailable()) and ((v20.FinalReckoning:CooldownRemains() > (2 + 2)) or (v20.FinalReckoning:IsLearned() and not FinalReckoningSetting) or (v20.ExecutionSentence:CooldownRemains() > (4 + 0)) or (v20.ExecutionSentence:IsLearned() and not ExecutionSentenceSetting) or (v27 < (6 + 2)))) then
		if v15(v20.WakeofAshes) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\227\112\254\168\26\34\129\203\112\230\165\32\62\199\243\116\251\168\55\44\147\251\99\230\237\119", "\231\148\17\149\205\69\77");
		end
	end
	if (v20.DivineToll:IsCastable() and DivineTollSetting and v7:IsInRange(15 + 15) and (v30 <= (1435 - (797 + 636))) and ((v20.AvengingWrath:CooldownRemains() > (72 - 57)) or (v20.Crusade:CooldownRemains() > (1634 - (1427 + 192))) or v20.RadiantGlory:IsAvailable() or (v27 < (3 + 5)) or not AvengingWrathSetting)) then
		if v15(v20.DivineToll) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\132\174\209\242\89\250\191\179\200\247\91\191\135\162\201\254\69\254\148\168\213\232\23\169", "\159\224\199\167\155\55");
		end
	end
	local v140 = v82();
	if v140 then
		return v140;
	end
	if (v20.TemplarSlash:IsReady() and v7:IsInMeleeRange(11 - 6) and (v65() < v6:GCD()) and (v40 >= (2 + 0))) then
		if v15(v20.TemplarSlash) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\227\246\49\194\251\242\46\237\228\255\61\193\255\179\59\215\249\246\46\211\227\252\46\193\183\171", "\178\151\147\92");
		end
	end
	if (v20.BladeofJustice:IsCastable() and v7:IsSpellInRange(v20.BladeofJustice) and (v40 >= (1 + 1)) and v20.BladeofVengeance:IsAvailable()) then
		if v15(v20.BladeofJustice) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\142\241\77\54\23\115\117\138\194\70\39\1\88\115\143\248\12\53\23\66\127\158\252\88\61\0\95\58\221\173", "\26\236\157\44\82\114\44");
		end
	end
	if (v20.HammerofWrath:IsReady() and v7:IsSpellInRange(v20.HammerofWrath) and ((v40 < (328 - (192 + 134))) or not v20.BlessedChampion:IsAvailable()) and v6:BuffUp(v20.BlessingofAnsheRetBuff)) then
		if v15(v20.HammerofWrath, true) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\34\47\216\86\47\60\234\84\44\17\194\73\43\58\221\27\45\43\219\94\56\47\193\84\56\61\149\10\120", "\59\74\78\181");
		end
	end
	if (v20.TemplarStrike:IsReady() and v7:IsSpellInRange(v20.TemplarStrike)) then
		if v15(v20.TemplarStrike) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\49\212\87\74\191\36\195\101\73\167\55\216\81\95\243\34\212\84\95\161\36\197\85\72\160\101\128\14", "\211\69\177\58\58");
		end
	end
	if (v20.Judgment:IsReady() and v7:IsSpellInRange(v20.Judgment)) then
		if v15(v20.Judgment, nil, nil, not v7:IsSpellInRange(v20.Judgment)) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\189\240\125\242\228\206\185\241\57\242\236\197\178\247\120\225\230\217\164\165\40\173", "\171\215\133\25\149\137");
		end
	end
	if (v20.BladeofJustice:IsCastable() and v7:IsSpellInRange(v20.BladeofJustice)) then
		if v15(v20.BladeofJustice) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\227\196\51\254\234\15\243\68\222\194\39\233\251\57\255\71\161\207\55\244\234\34\253\86\238\218\33\186\190\102", "\34\129\168\82\154\143\80\156");
		end
	end
	if (v20.HammerofWrath:IsReady() and v7:IsSpellInRange(v20.HammerofWrath) and ((v40 < (1278 - (316 + 960))) or not v20.BlessedChampion:IsAvailable())) then
		if v15(v20.HammerofWrath, true) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\141\179\62\6\77\92\182\138\180\12\28\90\79\157\141\242\52\14\70\75\155\132\166\60\25\91\14\216\221", "\233\229\210\83\107\40\46");
		end
	end
	if (v20.TemplarSlash:IsReady() and v7:IsInMeleeRange(3 + 2)) then
		if v15(v20.TemplarSlash) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\213\71\63\198\9\192\80\13\197\9\192\81\58\150\2\196\76\55\196\4\213\77\32\197\69\147\18", "\101\161\34\82\182");
		end
	end
	if (v20.CrusaderStrike:IsCastable() and v7:IsSpellInRange(v20.CrusaderStrike)) then
		if v15(v20.CrusaderStrike) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\235\31\76\237\218\230\135\60\215\30\77\236\210\233\135\110\239\8\87\251\201\227\150\33\250\30\25\172\141", "\78\136\109\57\158\187\130\226");
		end
	end
	if (v20.HammerofWrath:IsReady() and v7:IsSpellInRange(v20.HammerofWrath)) then
		if v15(v20.HammerofWrath, true) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\54\62\244\252\59\45\198\254\56\0\238\227\63\43\241\177\57\58\247\244\44\62\237\254\44\44\185\163\102", "\145\94\95\153");
		end
	end
	if (v20.ArcaneTorrent:IsCastable() and v7:IsInRange(7 + 1)) then
		if v15(v20.ArcaneTorrent) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\252\223\23\212\64\178\194\217\27\199\92\178\243\217\84\210\75\185\248\223\21\193\65\165\238\141\70\141", "\215\157\173\116\181\46");
		end
	end
end
local function v84()
	if ((v6:HealthPercentage() <= v26.RetHealing.LoHHP) and v20.LayonHands:IsCastable() and not v6:DebuffUp(v20.ForbearanceDebuff)) then
		if v15(v20.LayonHands, true) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\57\181\146\205\213\59\139\131\243\212\49\167\203\246\223\51\177\133\225\211\35\177", "\186\85\212\235\146");
		end
	end
	if ((v6:HealthPercentage() <= v26.RetHealing.BubbleHP) and v20.DivineShield:IsCastable() and not v6:DebuffUp(v20.ForbearanceDebuff)) then
		if v15(v20.DivineShield, true) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\230\136\0\247\55\235\24\241\137\31\251\53\234\24\198\132\16\251\55\253\81\212\132", "\56\162\225\118\158\89\142");
		end
	end
	if ((v6:HealthPercentage() <= v26.RetHealing.WordofGloryPlayerHP) and v41:IsReady()) then
		if v15(v41, true) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\107\10\210\171\98\215\90\69\231\163\45\202\69\69\196\170\36\221\82\22\201\185\39", "\184\60\101\160\207\66");
		end
	end
	if ((v6:HealthPercentage() <= v26.RetHealing.FlashofLightPlayerHP) and (not v6:IsMoving() or v20.LightsCelerity:IsAvailable()) and v20.FlashofLight:IsReady()) then
		if v15(v20.FlashofLight, true) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\23\142\125\175\57\194\115\186\113\174\117\187\57\150\60\184\52\132\121\178\34\139\106\185", "\220\81\226\28");
		end
	end
	if ((v6:HealthPercentage() <= v26.RetHealing.ShieldofVengeanceHP) and v20.ShieldofVengeance:IsCastable()) then
		if v15(v20.ShieldofVengeance, true) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\0\221\139\254\230\195\83\218\132\187\252\194\29\210\135\250\228\196\22\149\134\254\236\194\29\198\139\237\239", "\167\115\181\226\155\138");
		end
	end
	if ((v6:HealthPercentage() <= v26.RetHealing.DivineProtectionHP) and v20.DivineProtection:IsCastable()) then
		if v15(v20.DivineProtectionCast, true) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\198\43\241\85\117\116\134\210\48\232\72\126\114\210\235\45\233\28\127\116\192\231\44\244\85\109\116", "\166\130\66\135\60\27\17");
		end
	end
end
local function v85()
	local v141 = v23.UnitsinRange(v20.FlashofLight);
	local v142 = v23.GetLowestHealthUnit(v141);
	local v143 = v142:HealthPercentage();
	if not v142:DebuffUp(v20.ForbearanceDebuff) then
		if (v20.LayonHands:IsReady() and (v143 <= v26.RetHealing.LoHPartyHP)) then
			v142:Cast(v20.LayonHands);
			return LUAOBFUSACTOR_DECRYPT_STR_0("\104\75\215\53\63\74\10\230\116\62\64\89\142\69\49\86\94\215", "\80\36\42\174\21");
		end
	end
	if v20.BlessingofProtection:IsReady() then
		BoPTarget = v74(v141);
		PlayerIsBoPTarget = v74(v141, true);
		if ((BoPTarget ~= nil) and not v26.RetHealing.BoPPlayerOnly) then
			BoPTarget:Cast(v20.BlessingofProtection);
			return LUAOBFUSACTOR_DECRYPT_STR_0("\108\28\50\105\93\25\57\125\14\31\49\58\126\2\56\110\75\19\35\115\65\30\119\74\79\2\35\99", "\26\46\112\87");
		end
		if (PlayerIsBoPTarget ~= nil) then
			v6:Cast(v20.BlessingofProtection);
			return LUAOBFUSACTOR_DECRYPT_STR_0("\155\47\174\103\172\182\75\179\249\44\173\52\143\173\74\160\188\32\191\125\176\177\5\132\181\34\178\113\173", "\212\217\67\203\20\223\223\37");
		end
	end
	if (v41:IsReady() and (v143 <= v26.RetHealing.WordofGloryPartyHP)) then
		v142:Cast(v41);
		return LUAOBFUSACTOR_DECRYPT_STR_0("\141\130\186\214\250\130\174\146\157\129\167\192\163\205\152\211\168\153\177", "\178\218\237\200");
	end
	if (v20.FlashofLight:IsReady() and (not v6:IsMoving() or v20.LightsCelerity:IsAvailable()) and (v143 <= v26.RetHealing.FlashofLightPartyHP)) then
		v142:Cast(v20.FlashofLight);
		return LUAOBFUSACTOR_DECRYPT_STR_0("\144\185\231\195\190\245\233\214\246\153\239\215\190\161\166\224\183\167\242\201", "\176\214\213\134");
	end
	if (v20.BlessingofSacrifice:IsReady() and (v143 <= v26.RetHealing.BlessingOfSacrificeHP) and (v6:HealthPercentage() > (84 + 6)) and v6:BuffDown(v20.BlessingofProtection)) then
		v142:Cast(v20.BlessingofSacrifice);
		return LUAOBFUSACTOR_DECRYPT_STR_0("\214\161\179\199\187\95\87\243\162\176\231\169\85\75\253\171\191\215\173\22\105\245\191\162\205", "\57\148\205\214\180\200\54");
	end
end
local function v86()
	if v6:AffectingCombat() then
		if (v20.Intercession:IsReady() and not v6:IsMoving()) then
			if (v8:UnitIsFriend() and v8:UnitIsPlayer() and v8:Exists() and v8:IsDeadOrGhost()) then
				v12.CastTarget(v20.Intercession, v12.TName().MOUSEOVER);
				return LUAOBFUSACTOR_DECRYPT_STR_0("\59\243\33\49\100\17\248\38\39\127\29\243\117\59\120\82\208\58\33\101\23\242\35\49\100", "\22\114\157\85\84");
			end
			if (v26.RetHealing.IntercessionTarget and v7:UnitIsFriend() and v7:Exists() and v7:IsDeadOrGhost()) then
				v12.Cast(v20.Intercession);
				return LUAOBFUSACTOR_DECRYPT_STR_0("\237\197\7\193\79\245\173\215\216\26\203\83\182\167\202\139\39\197\79\241\173\208", "\200\164\171\115\164\61\150");
			end
		end
	end
end
local function v87()
	v23.HealthPotions();
	if v6:IsChanneling(v21.ManicGrieftorch.ItemUseSpell) then
		return LUAOBFUSACTOR_DECRYPT_STR_0("\154\251\13\81\195\189\225\23\5\183\177\230\0\77", "\227\222\148\99\37");
	end
	if (v6:IsInParty() or v6:IsInRaid()) then
		local v162 = v86();
		if v162 then
			return v162;
		end
	end
	SmallCDToggle = v12.ToggleIconFrame:GetToggle(3 - 2);
	TabToggle = v26.Retribution.TabToggle and v12.ToggleIconFrame:GetToggle(553 - (83 + 468));
	InterruptToggle = v12.ToggleIconFrame:GetToggle(1809 - (1202 + 604));
	DispelToggle = v12.ToggleIconFrame:GetToggle(18 - 14);
	v38 = v23.UnitsinRange(v20.FlashofLight);
	UnitForFreezingBinds = v70(v38);
	v41 = (v20.EternalFlame:IsAvailable() and v20.EternalFlame) or v20.WordofGlory;
	v39 = v6:GetEnemiesInRange(13 - 5);
	if v13() then
		v40 = #v39;
	else
		v40 = 2 - 1;
	end
	RacialsSetting = v76(v26.RetCooldowns.RacialsSetting) and v79(v26.RetTTD.RacialsTTD);
	Trinket1Setting = v76(v26.RetCooldowns.Trinket1Setting) and v79(v26.RetTTD.TrinketsTTD);
	Trinket2Setting = v76(v26.RetCooldowns.Trinket2Setting) and v79(v26.RetTTD.TrinketsTTD);
	PotionSetting = v76(v26.RetCooldowns.PotionSetting) and not v23.ISSolo();
	DivineTollSetting = v76(v26.RetCooldowns.DivineTollSetting) and v79(v26.RetTTD.DivineTollTTD);
	AvengingWrathSetting = v76(v26.RetCooldowns.AvengingWrathSetting) and v79(v26.RetTTD.AvengingWrathTTD);
	ExecutionSentenceSetting = v76(v26.RetCooldowns.ExecutionSentenceSetting) and v79(v26.RetTTD.ExecutionSentenceTTD);
	FinalReckoningSetting = v76(v26.RetCooldowns.FinalReckoningSetting) and v79(v26.RetTTD.FinalReckoningTTD);
	CrusadeSetting = v76(v26.RetCooldowns.CrusadeSetting) and v79(v26.RetTTD.CrusadeTTD);
	WakeofAshesSetting = v76(v26.RetCooldowns.WakeofAshesSetting) and v79(v26.RetTTD.WakeofAshesTTD);
	WeaponSetting = v76(v26.RetCooldowns.WeaponSetting) and v79(340 - (45 + 280));
	AuraSelected = v26.Retribution.AuraSelect;
	if (v23.TargetIsValid() or v6:AffectingCombat()) then
		v29 = v68();
		v27 = v3.BossFightRemains();
		v34 = true;
		v28 = v27;
		if (v28 == (10725 + 386)) then
			v34 = false;
			v28 = v3.FightRemains(v39, false);
		end
		v31 = v6:GCD();
		v30 = v6:HolyPower();
	end
	if (v20.DevotionAura:IsReady() and (AuraSelected == LUAOBFUSACTOR_DECRYPT_STR_0("\23\87\68\249\237\58\93\92\182\216\38\64\83", "\153\83\50\50\150")) and v6:BuffDown(v20.DevotionAura, true)) then
		v15(v20.DevotionAura);
		return LUAOBFUSACTOR_DECRYPT_STR_0("\121\115\101\19\103\162\66\83\54\82\9\97\170", "\45\61\22\19\124\19\203");
	end
	if (v20.CrusaderAura:IsReady() and (AuraSelected == LUAOBFUSACTOR_DECRYPT_STR_0("\226\0\24\230\3\116\188\211\82\44\224\16\113", "\217\161\114\109\149\98\16")) and v6:BuffDown(v20.CrusaderAura, true)) then
		v15(v20.CrusaderAura);
		return LUAOBFUSACTOR_DECRYPT_STR_0("\49\50\45\111\189\112\23\50\120\93\169\102\19", "\20\114\64\88\28\220");
	end
	if (v20.ConcentrationAura:IsReady() and (AuraSelected == LUAOBFUSACTOR_DECRYPT_STR_0("\18\14\220\183\253\222\169\35\0\198\189\247\222\253\16\20\192\181", "\221\81\97\178\212\152\176")) and v6:BuffDown(v20.ConcentrationAura, true)) then
		v15(v20.ConcentrationAura);
		return LUAOBFUSACTOR_DECRYPT_STR_0("\238\232\19\248\31\195\243\15\250\14\196\232\19\187\59\216\245\28", "\122\173\135\125\155");
	end
	if v6:AffectingCombat() then
		v35 = v84();
		if v35 then
			return v35;
		end
	end
	if (v6:IsInParty() and not v6:IsInRaid()) then
		v35 = v85();
		if v35 then
			return v35;
		end
		if (v20.CleanseToxins:IsReady() and v26.Retribution.UseCleanse and DispelToggle) then
			v35 = v23.DispelCycle(v20.CleanseToxins, LUAOBFUSACTOR_DECRYPT_STR_0("\180\206\9\170\48\63", "\168\228\161\96\217\95\81"));
			if v35 then
				return v35;
			end
			v35 = v23.DispelCycle(v20.CleanseToxins, LUAOBFUSACTOR_DECRYPT_STR_0("\255\216\61\89\46\68\222", "\55\187\177\78\60\79"));
			if v35 then
				return v35;
			end
			v35 = v23.AfflictedLogic(v20.CleanseToxins);
			if v35 then
				return v35;
			end
		end
		if v20.BlessingofFreedom:IsReady() then
			if (v6:IsInParty() and not v6:IsInRaid() and v26.Retribution.UseBoF) then
				if UnitForFreezingBinds then
					if UnitForFreezingBinds:Cast(v20.BlessingofFreedom) then
						return LUAOBFUSACTOR_DECRYPT_STR_0("\15\194\90\248\85\198\142\42\142\80\237\6\233\146\40\203\91\228\75\143\166\63\193\69\238\72\143\162\36\192\91\248", "\224\77\174\63\139\38\175");
					end
				end
				if v20.UnboundFreedom:IsAvailable() then
					if (v23.unitHasDebuffFromList(v23.DebuffList[LUAOBFUSACTOR_DECRYPT_STR_0("\161\79\76\47\138\70\84\43\128", "\78\228\33\56")], v5(v26.RetHealing.UnboundFreedomUnit)) or v23.unitHasDebuffFromList(v23.DebuffList[LUAOBFUSACTOR_DECRYPT_STR_0("\235\112\166\2\139\201\114\183\7", "\229\174\30\210\99")], v6)) then
						v5(v26.RetHealing.UnboundFreedomUnit):Cast(v20.BlessingofFreedom);
						return LUAOBFUSACTOR_DECRYPT_STR_0("\57\226\160\17\226\51\121", "\89\123\141\230\49\141\93") .. v26.RetHealing.UnboundFreedomUnit;
					end
					v35 = v72(v20.BlessingofFreedom, LUAOBFUSACTOR_DECRYPT_STR_0("\193\126\249\24\52\67\224\97\243\0", "\42\147\17\150\108\112"));
					if v35 then
						return v35;
					end
					v35 = v72(v20.BlessingofFreedom, LUAOBFUSACTOR_DECRYPT_STR_0("\60\168\44\109\226\218\0\169\57", "\136\111\198\77\31\135"));
					if v35 then
						return v35;
					end
					v35 = v72(v20.BlessingofFreedom, LUAOBFUSACTOR_DECRYPT_STR_0("\36\27\162\83\185\235\26\141\11\26\183\83\177", "\201\98\105\199\54\221\132\119"));
					if v35 then
						return v35;
					end
				else
					if (v6:DebuffElapsed(v20.EntangledDebuff) > (2 + 0)) then
						if v6:Cast(v20.BlessingofFreedom) then
							return LUAOBFUSACTOR_DECRYPT_STR_0("\155\0\134\50\17\60\162\190\76\140\39\66\19\190\188\9\135\46\15\117\169\183\24\130\47\5\57\165\183\11", "\204\217\108\227\65\98\85");
						end
					end
					v35 = v23.DispelCycle(v20.BlessingofFreedom, LUAOBFUSACTOR_DECRYPT_STR_0("\108\204\250\241\8\201\77\211\240\233", "\160\62\163\149\133\76"), nil, v38);
					if v35 then
						return v35;
					end
					v35 = v23.DispelCycle(v20.BlessingofFreedom, LUAOBFUSACTOR_DECRYPT_STR_0("\229\174\12\61\198\228\175\2\59", "\163\182\192\109\79"), nil, v38);
					if v35 then
						return v35;
					end
					v35 = v23.DispelCycle(v20.BlessingofFreedom, LUAOBFUSACTOR_DECRYPT_STR_0("\18\52\5\197\241\59\43\36\201\230\36\35\12", "\149\84\70\96\160"), nil, v38);
					if v35 then
						return v35;
					end
				end
			end
			if (v23.unitHasDebuffFromList(v23.DebuffList[LUAOBFUSACTOR_DECRYPT_STR_0("\10\9\2\249\28\15\30\253\61\10", "\141\88\102\109")], v6) or v23.unitHasDebuffFromList(v23.DebuffList[LUAOBFUSACTOR_DECRYPT_STR_0("\128\93\203\98\31\15\90\206\167", "\161\211\51\170\16\122\93\53")], v6) or v23.unitHasDebuffFromList(v23.DebuffList[LUAOBFUSACTOR_DECRYPT_STR_0("\221\188\183\45\255\161\191\12\242\189\162\45\247", "\72\155\206\210")], v6)) then
				v6:Cast(v20.BlessingofFreedom);
				return LUAOBFUSACTOR_DECRYPT_STR_0("\100\117\114\78\60\72\58\100\2\50\95\127\70", "\83\38\26\52\110");
			end
			if ((v6:DebuffUp(v10(155001 + 269494), true) or v6:DebuffUp(v10(234903 + 189594), true)) and v6:IsInRaid()) then
				v6:Cast(v20.BlessingofFreedom);
				return;
			end
		end
	end
	if v23.TargetIsValid() then
		if (not v6:AffectingCombat() and v26.Retribution.AttackOutOfCombat) then
			v35 = v80();
			if v35 then
				return v35;
			end
		end
		if InterruptToggle then
			v35 = v23.InterruptCycle(v20.Rebuke, 1 + 4, true, nil, false);
			if v35 then
				return v35;
			end
			v35 = not v6:IsMoving() and v23.InterruptCycle(v20.HammerofJustice, 18 - 8, false, nil, true);
			if v35 then
				return v35;
			end
			v35 = not v6:IsMoving() and not v26.Retribution.XalatathsBargain and v23.InterruptCycle(v20.BlindingLight, 1921 - (340 + 1571), false, nil, true, true);
			if v35 then
				return v35;
			end
			if (v26.Retribution.XalatathsBargain and (EnemiesWithIDInCCRange(90440 + 138856) >= (1776 - (1733 + 39))) and v20.BlindingLight:IsCastable()) then
				if v15(v20.BlindingLight) then
					return LUAOBFUSACTOR_DECRYPT_STR_0("\122\27\46\72\92\30\41\65\116\30\32\78\76\87\40\72\24\47\38\74\89\3\38\82\80\4\5\71\74\16\38\79\86", "\38\56\119\71");
				end
			end
		end
		if (v7:AffectingCombat() or v26.Retribution.AttackOutOfCombat) then
			local v169 = v81();
			if v169 then
				return v169;
			end
			local v169 = v83();
			if v169 then
				return v169;
			end
		end
	end
	v35 = (v40 > (0 - 0)) and not v7:IsInRange(1042 - (125 + 909)) and v75();
	if v35 then
		return v35;
	end
end
local function v88()
	v26.Retribution.Display();
	v12.ResetToggle();
	v12.ToggleIconFrame:AddButtonCustom("S", 1949 - (1096 + 852), LUAOBFUSACTOR_DECRYPT_STR_0("\192\226\89\218\41\22\208\203\75", "\54\147\143\56\182\69"), LUAOBFUSACTOR_DECRYPT_STR_0("\197\140\254\69\211\213\133\236", "\191\182\225\159\41"));
	v12.ToggleIconFrame:AddButtonCustom("T", 1 + 1, LUAOBFUSACTOR_DECRYPT_STR_0("\31\19\42", "\162\75\114\72\53\235\231"), LUAOBFUSACTOR_DECRYPT_STR_0("\152\61\70", "\98\236\92\36\130\51"));
	v12.ToggleIconFrame:AddButtonCustom("I", 3 - 0, LUAOBFUSACTOR_DECRYPT_STR_0("\141\23\24\191\87\186\160\32\176", "\80\196\121\108\218\37\200\213"), LUAOBFUSACTOR_DECRYPT_STR_0("\9\125\22\122\89\28\159\16\103", "\234\96\19\98\31\43\110"));
	v12.ToggleIconFrame:AddButtonCustom("D", 4 + 0, LUAOBFUSACTOR_DECRYPT_STR_0("\34\22\65\215\169\126", "\235\102\127\50\167\204\18"), LUAOBFUSACTOR_DECRYPT_STR_0("\84\168\230\51\65\34", "\78\48\193\149\67\36"));
	v20.MarkofFyralathDebuff:RegisterAuraTracking();
	v23.PostInitialMessage(582 - (409 + 103));
end
v12.SetAPL(306 - (46 + 190), v87, v88);
