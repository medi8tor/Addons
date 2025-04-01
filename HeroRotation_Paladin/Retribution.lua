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
local v27 = 11722 - (602 + 9);
local v28 = 12300 - (449 + 740);
local v29;
local v30 = 872 - (826 + 46);
local v31 = 947 - (245 + 702);
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
local v63 = 0 - 0;
local function v64()
	local v90, v91 = v6:GetTrinketData(v22);
	if ((v63 < (2 + 3)) and ((v90.ID == (1898 - (260 + 1638))) or (v91.ID == (440 - (382 + 58))) or (v90.Level == (0 - 0)) or (v91.Level == (0 + 0)) or ((v90.SpellID > (0 - 0)) and not v90.Usable) or ((v91.SpellID > (0 - 0)) and not v91.Usable))) then
		v63 = v63 + (1206 - (902 + 303));
		v19(10 - 5, function()
			v64();
		end);
		return;
	end
	v42 = v90.Object;
	v43 = v91.Object;
	v44 = v90.ID;
	v45 = v91.ID;
	v46 = v90.Level;
	v47 = v91.Level;
	v48 = v90.Spell;
	v50 = v90.Range;
	v52 = v90.CastTime;
	v49 = v91.Spell;
	v51 = v91.Range;
	v53 = v91.CastTime;
	v54 = v90.Cooldown;
	v55 = v91.Cooldown;
	v56 = v90.Excluded;
	v57 = v91.Excluded;
	v58 = v42:HasUseBuff();
	v59 = v43:HasUseBuff();
	v60 = 0.5 - 0;
	local v108 = ((v54 > (0 + 0)) and v54) or (1691 - (1121 + 569));
	if (v58 and (((v54 % (334 - (22 + 192))) == (683 - (483 + 200))) or (((1583 - (1404 + 59)) % v108) == (0 - 0)))) then
		v60 = 1 - 0;
	end
	v61 = 765.5 - (468 + 297);
	local v109 = ((v55 > (562 - (334 + 228))) and v55) or (3 - 2);
	if (v59 and (((v55 % (278 - 158)) == (0 - 0)) or (((35 + 85) % v109) == (236 - (141 + 95))))) then
		v61 = 1 + 0;
	end
	v62 = 2 - 1;
	local v110 = ((v42:BuffDuration() > (0 - 0)) and v42:BuffDuration()) or (1 + 0);
	local v111 = ((v43:BuffDuration() > (0 - 0)) and v43:BuffDuration()) or (1 + 0);
	if ((not v58 and v59) or (v59 and (((v55 / v111) * v61) > ((v54 / v110) * v60)))) then
		v62 = 2 + 0;
	end
end
v64();
local function v65()
	local v112 = (7 - 2) - v20.TemplarStrike:TimeSinceLastCast();
	if (v20.TemplarSlash:TimeSinceLastCast() < v20.TemplarStrike:TimeSinceLastCast()) then
		v112 = 0 + 0;
	end
	return ((v112 > (163 - (92 + 71))) and v112) or (0 + 0);
end
v3:RegisterForEvent(function()
	Equip = v6:GetEquipment();
	v42 = (Equip[21 - 8] and v11(Equip[778 - (574 + 191)])) or v11(0 + 0);
	v43 = (Equip[34 - 20] and v11(Equip[8 + 6])) or v11(849 - (254 + 595));
end, LUAOBFUSACTOR_DECRYPT_STR_0("\204\123\134\127\217\101\152\99\205\98\142\118\209\114\137\114\195\116\143\103\210\112\130\98", "\38\156\55\199"));
v3:RegisterForEvent(function()
	v27 = 11237 - (55 + 71);
	v28 = 14637 - 3526;
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
	local v113 = v6:GCDRemains();
	local v114 = v18(v20.CrusaderStrike:CooldownRemains(), v20.BladeofJustice:CooldownRemains(), v20.Judgment:CooldownRemains(), (v20.HammerofWrath:IsUsable() and v20.HammerofWrath:CooldownRemains()) or (1800 - (573 + 1217)), v20.WakeofAshes:CooldownRemains());
	if (v113 > v114) then
		return v113;
	end
	return v114;
end
local function v69()
	for v146, v147 in pairs(v5.Party) do
		if (v147:Role() == LUAOBFUSACTOR_DECRYPT_STR_0("\97\103\33\9\108\112", "\69\41\34\96")) then
			v37 = v147;
		end
		if (v147:Role() == LUAOBFUSACTOR_DECRYPT_STR_0("\136\226\249\33", "\75\220\163\183\106\98")) then
			v36 = v147;
		end
	end
end
local function v70(v115)
	local v116 = UnitGUID(LUAOBFUSACTOR_DECRYPT_STR_0("\22\187\153\48\220\22\174\138\37\222\7\174", "\185\98\218\235\87"));
	if (v115 ~= nil) then
		for v164, v165 in pairs(v115) do
			if ((v165:GUID() == v116) and ((v7:CastSpellID() == (888397 - 567609)) or (v7:CastSpellID() == (24632 + 299098)))) then
				if (v165 ~= nil) then
					return v165;
				end
			end
		end
	end
end
v3:RegisterForEvent(function()
	v69();
end, LUAOBFUSACTOR_DECRYPT_STR_0("\251\16\6\223\251\152\244\25\9\210\251\152\226\18\0\217\233\133\249\16\3", "\202\171\92\71\134\190"), LUAOBFUSACTOR_DECRYPT_STR_0("\14\243\3\189\25\254\30\167\26\245\9\186\22\244\28\172\8\245\9", "\232\73\161\76"), LUAOBFUSACTOR_DECRYPT_STR_0("\154\253\102\114\48\132\245\109\124\58\158\253", "\126\219\185\34\61"));
local function v71(v117)
	local v118 = 0 - 0;
	for v148, v149 in pairs(v5.Party) do
		if v23.unitHasDebuffFromList(v23.DebuffList[v117], v149) then
			v118 = v118 + (940 - (714 + 225));
		end
	end
	return v118;
end
local function v72(v119, v120)
	local v121 = v23.DebuffList[v120];
	local v122 = 0 - 0;
	for v150, v151 in pairs(v5.Party) do
		if ((v151 ~= LUAOBFUSACTOR_DECRYPT_STR_0("\28\194\95\107\123\101", "\135\108\174\62\18\30\23\147")) and v23.unitHasDebuffFromList(v121, v151)) then
			v122 = v122 + (1 - 0);
			v151:Cast(v119);
			return LUAOBFUSACTOR_DECRYPT_STR_0("\178\224\57\219\29\162", "\167\214\137\74\171\120\206\83");
		end
		if ((v122 == (0 + 0)) and v23.unitHasDebuffFromList(v121, v6)) then
			v5(v26.RetHealing.UnboundFreedomUnit):Cast(v119);
			return LUAOBFUSACTOR_DECRYPT_STR_0("\132\254\114\78\253\171\142\243\38\88\252\231\158\254\59\73", "\199\235\144\82\61\152");
		end
	end
end
local v73 = {(226769 - (118 + 688)),(38773 + 161409),(661889 - 465535),(435275 - 209791),(478994 - 282618),(658317 - 397576),(428456 - (503 + 1293)),(298309 + 114196),(177530 + 78284),(230262 + 25172),(264883 - (711 + 22)),(412559 - (240 + 619)),(655303 - 243345),(266300 - (1344 + 400)),(158901 + 42832),(1144653 - 876746),(262290 - (404 + 1335)),(313229 - 55822),(153545 + 273114),((432639 + 188621) - (395635 - (118 + 220)))};
local v74 = v23.converArrayToList({(211246 - (108 + 341)),(882541 - 673794)});
local function v75(v123, v124)
	local v125 = nil;
	if (v124 == nil) then
		for v166, v167 in pairs(v123) do
			if ((v167:Role() ~= LUAOBFUSACTOR_DECRYPT_STR_0("\51\55\151\0", "\75\103\118\217")) and ((v26.RetHealing.BoPDebuff and (v23.unitHasDebuffFromList(v23.DebuffList[LUAOBFUSACTOR_DECRYPT_STR_0("\229\88\117\17\189", "\126\167\52\16\116\217")], v167) or v23.unitHasDebuffFromList(v73, v167))) or (v167:HealthPercentageWeighted() <= v26.RetHealing.BoPHP)) and v167:DebuffDown(v20.ForbearanceDebuff)) then
				v125 = v167;
			end
		end
	end
	if (v124 == true) then
		if (((v26.RetHealing.BoPDebuff and (v23.unitHasDebuffFromList(v23.DebuffList[LUAOBFUSACTOR_DECRYPT_STR_0("\234\34\37\133\176", "\156\168\78\64\224\212\121")], v6) or v23.unitHasDebuffFromList(v73, v6))) or (v6:HealthPercentageWeighted() <= v26.RetHealing.BoPHP)) and v6:DebuffDown(v20.ForbearanceDebuff)) then
			v125 = v6;
		end
	end
	return v125;
end
function PreventWithFreedomIfTargetOfTargetIsPlayer(v126)
	local v127 = UnitGUID(LUAOBFUSACTOR_DECRYPT_STR_0("\23\226\164\215\2\252", "\174\103\142\197"));
	local v128 = LUAOBFUSACTOR_DECRYPT_STR_0("\66\41\77\63\32\74", "\152\54\72\63\88\69\62");
	if UnitExists(v128) then
		local v158 = LUAOBFUSACTOR_DECRYPT_STR_0("\192\197\252\91\209\208\250\93\198\195\235\72", "\60\180\164\142");
		if (UnitExists(v158) and (UnitGUID(v158) == v127)) then
			if ((v7:CastSpellID() == v126) and UnitIsPlayer(v128)) then
				return true;
			end
		end
	end
	return false;
end
local function v76()
	if (v25.General.AutoTab and v6:AffectingCombat()) then
		v12.TopPanelAlternative:ChangeIcon(1494 - (711 + 782), 5 - 2);
		return LUAOBFUSACTOR_DECRYPT_STR_0("\121\75\17\38\103\249\19\90\30\17\38\103\249\19\74\89\0\61", "\114\56\62\101\73\71\141");
	end
end
function EnemiesWithIDInCCRange(v129)
	local v130 = v6:GetEnemiesInRange(479 - (270 + 199));
	local v131 = 0 + 0;
	for v152, v153 in pairs(v130) do
		if (v153:NPCID() == v129) then
			v131 = v131 + (1820 - (580 + 1239));
		end
	end
	return v131;
end
local function v77(v132)
	return (v132 ~= LUAOBFUSACTOR_DECRYPT_STR_0("\150\230\207\132\141\250\222\192", "\164\216\137\187")) and (((v132 == LUAOBFUSACTOR_DECRYPT_STR_0("\229\239\37\186\230\221\4\221\234\53\189\177\240\24", "\107\178\134\81\210\198\158")) and v12.CDsON()) or ((v132 == LUAOBFUSACTOR_DECRYPT_STR_0("\15\7\150\206\234\11\3\131\202\166\120\1\144\134\137\55\1\142\194\165\47\0\145", "\202\88\110\226\166")) and (SmallCDToggle or v12.CDsON())) or ((v132 == LUAOBFUSACTOR_DECRYPT_STR_0("\244\6\150\255\138\240\2\131\251\198\131\44\166\228", "\170\163\111\226\151")) and SmallCDToggle) or ((v132 == LUAOBFUSACTOR_DECRYPT_STR_0("\62\62\242\21\65\53\42\30\37\188\44", "\73\113\80\210\88\46\87")) and (v40 >= v26.RetCooldowns.Mobcount)) or ((v132 == LUAOBFUSACTOR_DECRYPT_STR_0("\174\34\141\63\232\131\47\194\7\233\149\108\194\0\167\162\35\194\30\227\142\59\195\1", "\135\225\76\173\114")) and ((v40 >= v26.RetCooldowns.Mobcount) or v14())) or (v132 == LUAOBFUSACTOR_DECRYPT_STR_0("\59\225\175\177\181\174", "\199\122\141\216\208\204\221")) or ((v132 == LUAOBFUSACTOR_DECRYPT_STR_0("\130\211\80\210\119\229\190\216\3", "\150\205\189\112\144\24")) and (v34 or v7:IsDummy())) or ((v132 == LUAOBFUSACTOR_DECRYPT_STR_0("\8\139\189\79\11\157\31\4\101\139\173\12\38\135\2\3", "\112\69\228\223\44\100\232\113")) and (v34 or v7:IsDummy() or (v40 >= v26.RetCooldowns.Mobcount))) or ((v132 == LUAOBFUSACTOR_DECRYPT_STR_0("\227\22\19\219\246\94\138\219\16\3\223\163\111\146\148\16\9\223\175", "\230\180\127\103\179\214\28")) and v6:BloodlustUp()));
end
local function v78(v133)
	local v134 = v26.RetHealing.IntercessionUnit;
	if (v134 == LUAOBFUSACTOR_DECRYPT_STR_0("\173\9\83", "\128\236\101\63\38\132\33")) then
		for v168, v169 in pairs(v133) do
			if v169:IsDeadOrGhost() then
				return v169;
			end
		end
		return nil;
	end
	local v135 = {[LUAOBFUSACTOR_DECRYPT_STR_0("\130\166\31\65", "\175\204\201\113\36\214\139")]={},[LUAOBFUSACTOR_DECRYPT_STR_0("\115\205\59\215", "\100\39\172\85\188")]={LUAOBFUSACTOR_DECRYPT_STR_0("\153\89\151\171", "\83\205\24\217\224")},[LUAOBFUSACTOR_DECRYPT_STR_0("\206\192\204\49\227\215", "\93\134\165\173")]={LUAOBFUSACTOR_DECRYPT_STR_0("\150\215\224\238\31\252", "\30\222\146\161\162\90\174\210")},[LUAOBFUSACTOR_DECRYPT_STR_0("\209\79\126\1\165\79\126\14\165\102\117\11\233\75\98", "\106\133\46\16")]={LUAOBFUSACTOR_DECRYPT_STR_0("\108\1\93\215", "\32\56\64\19\156\58"),LUAOBFUSACTOR_DECRYPT_STR_0("\114\237\196\122\127\192", "\224\58\168\133\54\58\146")},[LUAOBFUSACTOR_DECRYPT_STR_0("\125\114", "\107\57\54\43\157\21\230\231")]={LUAOBFUSACTOR_DECRYPT_STR_0("\255\170\60\212\158\249\253", "\175\187\235\113\149\217\188")}};
	local v136 = v135[v134] or {};
	for v154, v155 in pairs(v133) do
		local v156 = v155:Role();
		local v157 = v155:IsDeadOrGhost();
		for v159, v160 in ipairs(v136) do
			if ((v156 == v160) and v157) then
				return v155;
			end
		end
	end
	return nil;
end
local function v79(v137, v138, v139)
	if (v34 or v23.ISSolo() or (v139 == (0 + 0)) or ((v28 >= v139) and (v28 < (8944 - (645 + 522))))) then
		v12.Cast(v137, v138);
		return LUAOBFUSACTOR_DECRYPT_STR_0("\8\155\165\12\224\120\107\40\239", "\24\92\207\225\44\131\25") .. v137:Name();
	end
end
local function v80(v140)
	return v34 or v23.ISSolo() or (v140 == (1790 - (1010 + 780))) or v23.Buggedmobs[v7:NPCID()] or ((v28 >= v140) and (v28 < (7774 + 3)));
end
local function v81()
	if (v33:IsReady() and (v30 >= (19 - 15)) and v7:IsSpellInRange(v33)) then
		if v15(v33) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\78\218\172\68\30\111\11\197\189\94\31\116\72\199\248\92\9\120\72\220\181\78\26\105\11\129", "\29\43\179\216\44\123");
		end
	end
	if (v20.BladeofJustice:IsCastable() and v7:IsSpellInRange(v20.BladeofJustice)) then
		if v15(v20.BladeofJustice) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\191\213\33\72\184\230\47\74\130\211\53\95\169\208\35\73\253\201\50\73\190\214\45\78\188\205\96\24", "\44\221\185\64");
		end
	end
	if (v20.Judgment:IsCastable() and v7:IsSpellInRange(v20.Judgment)) then
		if v15(v20.Judgment, nil, nil, not v7:IsSpellInRange(v20.Judgment)) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\11\242\76\88\126\4\233\92\31\99\19\226\75\80\126\3\230\92\31\37", "\19\97\135\40\63");
		end
	end
	if (v20.HammerofWrath:IsReady() and v7:IsSpellInRange(v20.HammerofWrath)) then
		if v15(v20.HammerofWrath, true) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\166\93\62\54\42\35\145\83\53\4\56\35\175\72\59\123\63\35\171\95\60\54\45\48\186\28\107", "\81\206\60\83\91\79");
		end
	end
	if (v20.CrusaderStrike:IsCastable() and v7:IsSpellInRange(v20.CrusaderStrike)) then
		if v15(v20.CrusaderStrike) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\77\185\197\97\46\199\72\182\113\184\196\96\38\200\72\228\31\251", "\196\46\203\176\18\79\163\45");
		end
	end
end
local function v82()
	if (v26.Commons.Enabled.Potions and PotionSetting and ((AvengingWrathSetting and v6:BuffUp(v20.AvengingWrathBuff)) or (CrusadeSetting and v6:BuffUp(v20.CrusadeBuff)) or (ExecutionSentenceSetting and v7:DebuffUp(v20.ExecutionSentenceDebuff)) or (v27 < (87 - 57)))) then
		local v161 = v23.PotionSelected();
		if (v161 and v161:IsReady()) then
			v12.CastMacro(1839 - (1045 + 791), nil, nil, v161);
			return LUAOBFUSACTOR_DECRYPT_STR_0("\155\35\109\10\100\203\224\172\43\113\16", "\143\216\66\30\126\68\155");
		end
	end
	if (RacialsSetting and v20.LightsJudgment:IsCastable() and v7:IsInRange(101 - 61)) then
		if v15(v20.LightsJudgment) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\166\193\10\195\209\176\232\235\191\204\10\198\192\173\195\161\169\199\2\199\193\172\192\239\185\136\89", "\129\202\168\109\171\165\195\183");
		end
	end
	if (RacialsSetting and v20.Fireblood:IsCastable() and (v6:BuffUp(v20.AvengingWrathBuff) or (v6:BuffUp(v20.CrusadeBuff) and (v6:BuffStack(v20.CrusadeBuff) == (15 - 5))))) then
		if v15(v20.Fireblood, false) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\36\81\37\221\220\24\233\45\92\119\219\209\27\234\38\87\32\214\205\84\176", "\134\66\56\87\184\190\116");
		end
	end
	if (((Trinket1Setting and (v42:ID() == v21.AlgetharPuzzleBox:ID())) or (Trinket2Setting and (v43:ID() == v21.AlgetharPuzzleBox:ID()))) and v80(v26.RetTTD.TrinketsTTD) and v26.Commons.Enabled.Trinkets and v67() and ((not v20.Crusade:IsAvailable() and (v20.AvengingWrath:CooldownRemains() < (510 - (351 + 154)))) or ((v20.Crusade:CooldownRemains() < (1579 - (1281 + 293))) and v20.Crusade:IsAvailable())) and (((v30 >= (270 - (28 + 238))) and (v3.CombatTime() < (10 - 5))) or ((v30 >= (1562 - (1381 + 178))) and (v3.CombatTime() > (5 + 0)))) and v7:IsInRange(5 + 0)) then
		if v15(v21.AlgetharPuzzleBox, nil) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\61\61\14\190\13\227\32\39\3\33\28\161\3\231\36\10\62\62\17\251\26\228\46\57\56\62\30\181\10\171\121", "\85\92\81\105\219\121\139\65");
		end
	end
	if (((Trinket1Setting and (v42:ID() == v21.ElementiumPocketAnvil:ID())) or (Trinket2Setting and (v43:ID() == v21.ElementiumPocketAnvil:ID()))) and v26.Commons.Enabled.Trinkets and v21.ElementiumPocketAnvil:IsEquippedAndReady() and v7:IsInRange(3 + 2)) then
		if v15(v21.ElementiumPocketAnvil, nil) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\216\191\85\72\121\209\233\186\69\72\60\239\242\176\91\64\104\159\220\189\70\76\112\159\254\188\95\73\120\208\234\189\67\5\36", "\191\157\211\48\37\28");
		end
	end
	if (((Trinket1Setting and (v42:ID() == v21.BranchOfTheTormentedAncient:ID())) or (Trinket2Setting and (v43:ID() == v21.BranchOfTheTormentedAncient:ID()))) and v80(v26.RetTTD.TrinketsTTD) and v26.Commons.Enabled.Trinkets and v21.BranchOfTheTormentedAncient:IsEquippedAndReady() and v7:IsInRange(17 - 12)) then
		if v15(v21.BranchOfTheTormentedAncient) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\253\13\245\18\57\215\48\242\40\50\218\43\251\14\55\218\17\224\25\62\254\17\247\21\63\209\11\180\31\53\208\19\240\19\45\209\12\180\68", "\90\191\127\148\124");
		end
	end
	if v26.Commons.Enabled.Trinkets then
		if (v42:IsReady() and Trinket1Setting and not v56 and ((((((v20.Crusade:IsLearned() and not CrusadeSetting) or (v20.AvengingWrath:IsLearned() and not AvengingWrathSetting) or (v6:BuffUp(v20.AvengingWrathBuff) and (v20.AvengingWrath:CooldownRemains() > (21 + 19))) or (v6:BuffUp(v20.CrusadeBuff) and (v6:BuffStack(v20.CrusadeBuff) == (480 - (381 + 89))))) and not v20.RadiantGlory:IsAvailable()) or (v20.RadiantGlory:IsAvailable() and ((not v20.ExecutionSentence:IsAvailable() and v20.WakeofAshes:CooldownUp()) or v7:DebuffUp(v20.ExecutionSentenceDebuff)))) and (not v43:HasCooldown() or v43:CooldownDown() or (v62 == (1 + 0)))) or (v42:BuffDuration() >= v28))) then
			if v15(v42) then
				return LUAOBFUSACTOR_DECRYPT_STR_0("\109\148\43\40\113\147\43\26\56\129\33\5\56\147\60\30\118\140\43\3\41\199\102", "\119\24\231\78") .. v42:Name() .. LUAOBFUSACTOR_DECRYPT_STR_0("\203\109\166\69\211\76\21\141\58\171\89\156\24", "\113\226\77\197\42\188\32");
			end
		end
		if (v43:IsReady() and Trinket2Setting and not v57 and ((((((v20.Crusade:IsLearned() and not CrusadeSetting) or (v20.AvengingWrath:IsLearned() and not AvengingWrathSetting) or (v6:BuffUp(v20.AvengingWrathBuff) and (v20.AvengingWrath:CooldownRemains() > (28 + 12))) or (v6:BuffUp(v20.CrusadeBuff) and (v6:BuffStack(v20.CrusadeBuff) == (1 - 0)))) and not v20.RadiantGlory:IsAvailable()) or (v20.RadiantGlory:IsAvailable() and ((not v20.ExecutionSentence:IsAvailable() and v20.WakeofAshes:CooldownUp()) or v7:DebuffUp(v20.ExecutionSentenceDebuff)))) and (not v42:HasCooldown() or v42:CooldownDown() or (v62 == (1158 - (1074 + 82))))) or (v43:BuffDuration() >= v28))) then
			if v15(v43) then
				return LUAOBFUSACTOR_DECRYPT_STR_0("\47\5\241\138\51\2\241\184\122\16\251\167\122\2\230\188\52\29\241\161\104\86\188", "\213\90\118\148") .. v43:Name() .. LUAOBFUSACTOR_DECRYPT_STR_0("\18\110\183\89\66\87\42\187\65\67\72\110\236", "\45\59\78\212\54");
			end
		end
		if (v42:IsReady() and Trinket1Setting and not v56 and not v58 and (v43:CooldownDown() or not v59 or (v20.Crusade:IsLearned() and not CrusadeSetting) or (v20.AvengingWrath:IsLearned() and not AvengingWrathSetting) or (v6:BuffDown(v20.CrusadeBuff) and (v20.Crusade:CooldownRemains() > (43 - 23))) or (v6:BuffDown(v20.AvengingWrathBuff) and (v20.AvengingWrath:CooldownRemains() > (1804 - (214 + 1570)))))) then
			if v15(v42) then
				return LUAOBFUSACTOR_DECRYPT_STR_0("\5\69\134\180\143\58\168\253\80\80\140\153\198\58\191\249\30\93\134\159\215\110\229", "\144\112\54\227\235\230\78\205") .. v42:Name() .. LUAOBFUSACTOR_DECRYPT_STR_0("\250\104\12\243\223\87\183\39\24\242\195\27\226\120", "\59\211\72\111\156\176");
			end
		end
		if (v43:IsReady() and Trinket2Setting and not v57 and not v59 and (v42:CooldownDown() or not v58 or (v20.Crusade:IsLearned() and not CrusadeSetting) or (v20.AvengingWrath:IsLearned() and not AvengingWrathSetting) or (v6:BuffDown(v20.CrusadeBuff) and (v20.Crusade:CooldownRemains() > (1475 - (990 + 465)))) or (v6:BuffDown(v20.AvengingWrathBuff) and (v20.AvengingWrath:CooldownRemains() > (9 + 11))))) then
			if v15(v43) then
				return LUAOBFUSACTOR_DECRYPT_STR_0("\91\148\230\18\71\147\230\32\14\129\236\63\14\147\241\36\64\140\230\57\28\199\171", "\77\46\231\131") .. v43:Name() .. LUAOBFUSACTOR_DECRYPT_STR_0("\243\20\181\79\181\88\178\79\173\90\165\0\235\6", "\32\218\52\214");
			end
		end
		if (v21.BestinSlotsMelee:IsEquippedAndReady() and (((v26.Retribution.DisableCrusadeAWCDCheck or (v6:BuffUp(v20.AvengingWrathBuff) and (v20.AvengingWrath:CooldownRemains() > (18 + 22))) or (v6:BuffUp(v20.CrusadeBuff) and (v6:BuffStack(v20.CrusadeBuff) == (10 + 0)))) and not v20.RadiantGlory:IsAvailable()) or (v20.RadiantGlory:IsAvailable() and ((not v20.ExecutionSentence:IsAvailable() and v20.WakeofAshes:CooldownUp()) or v7:DebuffUp(v20.ExecutionSentenceDebuff))))) then
			v12.CastMacro(3 - 2, nil, nil, v21.BestinSlotsMelee);
			return LUAOBFUSACTOR_DECRYPT_STR_0("\121\18\48\184\254\190\5\89\79\4\37", "\58\46\119\81\200\145\208\37");
		end
		if ((((v42:ID() == v21.ConcoctionKissofDeath:ID()) and Trinket1Setting) or ((v43:ID() == v21.ConcoctionKissofDeath:ID()) and Trinket2Setting)) and v21.ConcoctionKissofDeath:IsEquippedAndReady() and (v6:BuffUp(v20.AvengingWrathBuff) or (v6:BuffStack(v20.CrusadeBuff) == (1736 - (1668 + 58))))) then
			if v15(v21.ConcoctionKissofDeath, true) then
				return LUAOBFUSACTOR_DECRYPT_STR_0("\8\131\62\175\166\190\34\34\131\62\135\160\174\37\36\138\20\169\168\169\62", "\86\75\236\80\204\201\221");
			end
		end
	end
	if v26.Commons.Enabled.Items then
		if (v21.ShadowedRazingAnnihilator:IsEquippedAndReady() and WeaponSetting and v7:IsInRange(631 - (512 + 114)) and (v42:CooldownDown() or not v42:HasUseBuff()) and (v43:CooldownDown() or not v43:HasUseBuff())) then
			v12.CastMacro(2 - 1, nil, nil, v21.ShadowedRazingAnnihilator);
			return LUAOBFUSACTOR_DECRYPT_STR_0("\97\73\118\129\241\156\119\69\72\151\255\145\123\79\112\186\255\133\124\72\127\140\242\138\102\78\101\197\253\132\125\77\115\138\233\133\97\1\38\213", "\235\18\33\23\229\158");
		end
		if (v21.Fyralath:IsEquippedAndReady() and v14() and WeaponSetting and v7:IsInRange(10 - 5) and (v20.MarkofFyralathDebuff:AuraActiveCount() > (0 - 0)) and v6:BuffDown(v20.AvengingWrathBuff) and v6:BuffDown(v20.CrusadeBuff)) then
			v12.CastMacro(1 + 0, nil, nil, v21.Fyralath);
			return LUAOBFUSACTOR_DECRYPT_STR_0("\118\163\211\186\92\187\213\179\16\185\192\168\68", "\219\48\218\161");
		end
	end
	if (v20.ExecutionSentence:IsCastable() and v7:IsInRange(6 + 24) and ExecutionSentenceSetting and ((v7:TimeToDie() > (14 + 1)) or v23.Buggedmobs[v7:NPCID()]) and (((UnitClassification(LUAOBFUSACTOR_DECRYPT_STR_0("\240\112\110\78\222\91", "\128\132\17\28\41\187\47")) ~= LUAOBFUSACTOR_DECRYPT_STR_0("\15\61\20\55\92\13", "\61\97\82\102\90")) and (UnitClassification(LUAOBFUSACTOR_DECRYPT_STR_0("\184\47\185\76\194\67", "\105\204\78\203\43\167\55\126")) ~= LUAOBFUSACTOR_DECRYPT_STR_0("\177\184\42\8\26\5\203", "\49\197\202\67\126\115\100\167")) and (UnitClassification(LUAOBFUSACTOR_DECRYPT_STR_0("\35\90\205\46\133\66", "\62\87\59\191\73\224\54")) ~= LUAOBFUSACTOR_DECRYPT_STR_0("\234\11\244\220\244", "\169\135\98\154"))) or not v6:IsInDungeonArea() or v74[v7:NPCID()]) and ((v6:BuffDown(v20.CrusadeBuff) and (v20.Crusade:CooldownRemains() > (50 - 35))) or (v6:BuffStack(v20.CrusadeBuff) == (2004 - (109 + 1885))) or (not v20.Crusade:IsAvailable() and (v20.AvengingWrath:CooldownRemains() < (1469.75 - (1269 + 200)))) or (v20.AvengingWrath:CooldownRemains() > (28 - 13)) or v20.RadiantGlory:IsAvailable() or (v20.Crusade:IsLearned() and not CrusadeSetting) or (v20.AvengingWrath:IsLearned() and not AvengingWrathSetting)) and (((v30 >= (819 - (98 + 717))) and (v3.CombatTime() < (831 - (802 + 24)))) or ((v30 >= (5 - 2)) and (v3.CombatTime() > (6 - 1))) or (((v30 >= (1 + 1)) or (v3.CombatTime() > (4 + 1))) and (v20.DivineAuxiliary:IsAvailable() or v20.RadiantGlory:IsAvailable()))) and ((v20.DivineHammer:CooldownRemains() > (1 + 4)) or v6:BuffUp(v20.DivineHammerBuff) or not v20.DivineHammer:IsAvailable() or not DivineHammerSetting) and (((v7:TimeToDie() > (2 + 6)) and not v20.ExecutionersWill:IsAvailable()) or (v7:TimeToDie() > (33 - 21))) and (v20.WakeofAshes:CooldownRemains() < v6:GCD())) then
		if v15(v20.ExecutionSentence) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\206\111\33\87\232\39\193\196\121\27\71\248\61\220\206\121\39\81\189\48\199\196\123\32\91\234\61\219\139\38\112", "\168\171\23\68\52\157\83");
		end
	end
	if (v20.AvengingWrath:IsCastable() and v7:IsInRange(16 - 11) and AvengingWrathSetting and (((v30 >= (2 + 2)) and (v3.CombatTime() < (3 + 2))) or ((v30 >= (3 + 0)) and (v3.CombatTime() > (4 + 1))) or ((v30 >= (1 + 1)) and v20.DivineAuxiliary:IsAvailable() and (v20.ExecutionSentence:CooldownUp() or v20.FinalReckoning:CooldownUp()))) and ((v40 <= (1434 - (797 + 636))) or (v7:TimeToDie() > (48 - 38)))) then
		if v15(v20.AvengingWrath, false) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\245\103\240\163\34\36\137\243\78\226\191\36\57\143\180\114\250\162\41\41\136\227\127\230\237\116\123", "\231\148\17\149\205\69\77");
		end
	end
	if (v20.Crusade:IsCastable() and v7:IsInRange(1624 - (1427 + 192)) and CrusadeSetting and (((v30 >= (2 + 3)) and (v3.CombatTime() < (11 - 6))) or ((v30 >= (3 + 0)) and (v3.CombatTime() >= (3 + 2))))) then
		if v15(v20.Crusade, false) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\131\181\210\232\86\251\133\231\196\244\88\243\132\168\208\245\68\191\209\255", "\159\224\199\167\155\55");
		end
	end
	if (v20.FinalReckoning:IsCastable() and v7:IsInMeleeRange(331 - (192 + 134)) and FinalReckoningSetting and (((v30 >= (1280 - (316 + 960))) and (v3.CombatTime() < (5 + 3))) or ((v30 >= (3 + 0)) and (v3.CombatTime() >= (8 + 0))) or ((v30 >= (7 - 5)) and (v20.DivineAuxiliary:IsAvailable() or v20.RadiantGlory:IsAvailable()))) and (not AvengingWrathSetting or (v20.AvengingWrath:CooldownRemains() > (561 - (83 + 468))) or (v20.Crusade:CooldownDown() and (v6:BuffDown(v20.CrusadeBuff) or (v6:BuffStack(v20.CrusadeBuff) >= (1816 - (1202 + 604))))) or (v20.RadiantGlory:IsAvailable() and (v6:BuffUp(v20.AvengingWrathBuff) or (v20.Crusade:IsAvailable() and (v20.WakeofAshes:CooldownRemains() < v6:GCD())))))) then
		if v12.CastTarget(v20.FinalReckoning, v12.TName().PLAYER) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\241\250\50\211\251\204\46\215\244\248\51\220\254\253\59\146\244\252\51\222\243\252\43\220\228\179\110\130", "\178\151\147\92");
		end
	end
end
local function v83()
	v32 = ((v40 >= (9 - 7)) or v6:BuffUp(v20.EmpyreanPowerBuff) or (not v20.FinalVerdict:IsLearned() and v20.TempestoftheLightbringer:IsAvailable())) and v6:BuffDown(v20.EmpyreanLegacyBuff) and not (v6:BuffUp(v20.DivineArbiterBuff) and (v6:BuffStack(v20.DivineArbiterBuff) > (39 - 15)));
	if (v20.HammerofLight:IsReady() and v7:IsInRange(38 - 24) and (v20.HammerofLight:IsReady() or not v20.DivineHammer:IsAvailable() or not DivineHammerSetting or v24.DivineHammerActive or (v20.DivineHammer:CooldownRemains() > (335 - (45 + 280))))) then
		if v15(v20.WakeofAshes, true) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\132\252\65\63\23\94\69\131\251\115\62\27\75\114\152\189\74\59\28\69\105\132\248\94\33\82\30", "\26\236\157\44\82\114\44");
		end
	end
	if (v20.DivineHammer:IsReady() and DivineHammerSetting and v7:IsInRange(8 + 0) and not v24.DivineHammerActive) then
		if v15(v20.DivineHammer) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\46\39\195\82\36\43\234\83\43\35\216\94\56\110\211\82\36\39\198\83\47\60\198\27\126", "\59\74\78\181");
		end
	end
	if (v20.DivineStorm:IsReady() and v32 and not v20.HammerofLight:IsReady() and (v20.DivineHammer:CooldownDown() or v24.DivineHammerActive or not v20.DivineHammer:IsAvailable() or not DivineHammerSetting) and (not CrusadeSetting or v20.Crusade:IsAvailable() or (v20.Crusade:CooldownRemains() > (v31 * (3 + 0))) or (v6:BuffUp(v20.CrusadeBuff) and (v6:BuffStack(v20.CrusadeBuff) < (4 + 6))) or v20.RadiantGlory:IsAvailable())) then
		if v15(v20.DivineStorm) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\33\216\76\83\189\32\238\73\78\188\55\220\26\92\186\43\216\73\82\182\55\194\26\12", "\211\69\177\58\58");
		end
	end
	if (v20.JusticarsVengeance:IsReady() and v7:IsInRange(5 + 3) and (not v20.Crusade:IsAvailable() or (not AvengingWrathSetting and not CrusadeSetting) or (v20.Crusade:CooldownRemains() > (v31 * (1 + 2))) or (v6:BuffUp(v20.CrusadeBuff) and (v6:BuffStack(v20.CrusadeBuff) < (18 - 8))) or v20.RadiantGlory:IsAvailable()) and not v20.HammerofLight:IsReady() and (v20.DivineHammer:CooldownDown() or v24.DivineHammerActive or not v20.DivineHammer:IsAvailable() or not DivineHammerSetting)) then
		if v15(v20.JusticarsVengeance) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\189\240\106\225\224\200\182\247\106\202\255\206\185\226\124\244\231\200\178\165\127\252\231\194\164\237\124\231\250\139\239", "\171\215\133\25\149\137");
		end
	end
	if (v33:IsReady() and v7:IsSpellInRange(v33) and (not v20.Crusade:IsAvailable() or (not AvengingWrathSetting and not CrusadeSetting) or (v20.Crusade:CooldownRemains() > (v31 * (1914 - (340 + 1571)))) or (v6:BuffUp(v20.CrusadeBuff) and (v6:BuffStack(v20.CrusadeBuff) < (4 + 6))) or v20.RadiantGlory:IsAvailable()) and not v20.HammerofLight:IsReady() and (v20.DivineHammer:CooldownDown() or not v20.DivineHammer:IsAvailable() or not DivineHammerSetting)) then
		if v15(v33) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\228\193\38\242\234\34\188\84\228\218\54\243\236\36\188\68\232\198\59\233\231\53\238\81\161\158", "\34\129\168\82\154\143\80\156");
		end
	end
end
local function v84()
	if (((v30 == (1777 - (1733 + 39))) or ((v30 == (10 - 6)) and v6:BuffUp(v20.DivineResonanceBuff)) or v6:BuffUp(v20.TWW_S2_4pcBuff)) and v20.WakeofAshes:CooldownDown()) then
		local v162 = v83();
		if v162 then
			return v162;
		end
	end
	if (v20.HammerofLight:IsReady() and v7:IsInRange(1048 - (125 + 909))) then
		if v15(v20.WakeofAshes, true) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\173\179\62\6\77\92\134\131\158\58\12\64\90\201\130\183\61\14\90\79\157\138\160\115\90", "\233\229\210\83\107\40\46");
		end
	end
	if (v20.TemplarSlash:IsReady() and v7:IsInMeleeRange(1953 - (1096 + 852)) and (v20.TemplarStrike:TimeSinceLastCast() > ((3 + 2) - (v6:GCD() * (2 - 0))))) then
		if v15(v20.TemplarSlash) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\213\71\63\198\9\192\80\13\197\9\192\81\58\150\2\196\76\55\196\4\213\77\32\197\69\147", "\101\161\34\82\182");
		end
	end
	if (v20.BladeofJustice:IsCastable() and v7:IsSpellInRange(v20.BladeofJustice) and ((v7:DebuffDown(v20.ExpurgationDebuff) and v20.HolyFlames:IsAvailable() and v20.DivineToll:CooldownDown()) or not DivineTollSetting)) then
		if v15(v20.BladeofJustice) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\234\1\88\250\222\221\141\40\215\7\76\237\207\235\129\43\168\10\92\240\222\240\131\58\231\31\74\190\143", "\78\136\109\57\158\187\130\226");
		end
	end
	if (v20.WakeofAshes:IsCastable() and WakeofAshesSetting and v7:IsInRange(14 + 0) and (not v20.LightsGuidance:IsAvailable() or ((v30 >= (514 - (409 + 103))) and v20.LightsGuidance:IsAvailable())) and ((v20.AvengingWrath:CooldownRemains() > (242 - (46 + 190))) or not AvengingWrathSetting or (v20.Crusade:IsAvailable() and ((v20.Crusade:CooldownRemains() > (101 - (51 + 44))) or not CrusadeSetting)) or v20.RadiantGlory:IsAvailable()) and ((v20.FinalReckoning:CooldownRemains() > (2 + 2)) or (v20.FinalReckoning:IsLearned() and not FinalReckoningSetting) or (v20.ExecutionSentence:CooldownRemains() > (1321 - (1114 + 203))) or (v20.ExecutionSentence:IsLearned() and not ExecutionSentenceSetting) or (v27 < (734 - (228 + 498))))) then
		if v15(v20.WakeofAshes) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\41\62\242\244\1\48\255\206\63\44\241\244\45\127\254\244\48\58\235\240\42\48\235\226\126\109", "\145\94\95\153");
		end
	end
	if (v20.DivineToll:IsCastable() and DivineTollSetting and v7:IsInRange(7 + 23) and (((v30 <= (2 + 0)) and ((v20.AvengingWrath:IsAvailable() and (v20.AvengingWrath:CooldownRemains() > (678 - (174 + 489)))) or not AvengingWrathSetting)) or (v20.Crusade:IsAvailable() and (v20.Crusade:CooldownRemains() > (38 - 23))) or not CrusadeSetting or v20.RadiantGlory:IsAvailable() or (v27 < (1913 - (830 + 1075))))) then
		if v15(v20.DivineToll) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\249\196\2\220\64\178\194\217\27\217\66\247\250\200\26\208\92\182\233\194\6\198\14\225", "\215\157\173\116\181\46");
		end
	end
	local v141 = v83();
	if v141 then
		return v141;
	end
	if (v20.TemplarSlash:IsReady() and v7:IsInMeleeRange(529 - (303 + 221)) and (v20.TemplarStrike:TimeSinceLastCast() > ((1274 - (231 + 1038)) - v6:GCD())) and (v40 >= (2 + 0))) then
		if v15(v20.TemplarSlash) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\33\177\134\226\214\52\166\180\225\214\52\167\131\178\221\48\186\142\224\219\33\187\153\225\154\109", "\186\85\212\235\146");
		end
	end
	if (v20.BladeofJustice:IsCastable() and v7:IsSpellInRange(v20.BladeofJustice) and (v40 >= (1164 - (171 + 991))) and v20.BladeofVengeance:IsAvailable()) then
		if v15(v20.BladeofJustice) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\192\141\23\250\60\209\87\196\190\28\235\42\250\81\193\132\86\249\60\224\93\208\128\2\241\43\253\24\147\209", "\56\162\225\118\158\89\142");
		end
	end
	if (v20.HammerofWrath:IsReady() and v7:IsSpellInRange(v20.HammerofWrath) and ((v40 < (8 - 6)) or not v20.BlessedChampion:IsAvailable()) and v6:BuffUp(v20.BlessingofAnsheRetBuff)) then
		if v15(v20.HammerofWrath, true) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\84\4\205\162\39\202\99\10\198\144\53\202\93\17\200\239\37\221\82\0\210\174\54\215\78\22\128\254\112", "\184\60\101\160\207\66");
		end
	end
	if (v20.TemplarStrike:IsReady() and v7:IsSpellInRange(v20.TemplarStrike)) then
		if v15(v20.TemplarStrike) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\37\135\113\172\61\131\110\131\34\150\110\181\58\135\60\187\52\140\121\174\48\150\115\174\34\194\45\232", "\220\81\226\28");
		end
	end
	if (v20.Judgment:IsReady() and v7:IsSpellInRange(v20.Judgment)) then
		if v15(v20.Judgment, nil, nil, not v7:IsSpellInRange(v20.Judgment)) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\25\192\134\252\231\194\29\193\194\252\239\201\22\199\131\239\229\213\0\149\211\163", "\167\115\181\226\155\138");
		end
	end
	if (v20.BladeofJustice:IsCastable() and v7:IsSpellInRange(v20.BladeofJustice)) then
		if v15(v20.BladeofJustice) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\224\46\230\88\126\78\201\228\29\237\73\104\101\207\225\39\167\91\126\127\195\240\35\243\83\105\98\134\179\116", "\166\130\66\135\60\27\17");
		end
	end
	if (v20.HammerofWrath:IsReady() and v7:IsSpellInRange(v20.HammerofWrath) and ((v40 < (5 - 3)) or not v20.BlessedChampion:IsAvailable())) then
		if v15(v20.HammerofWrath, true) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\76\75\195\120\53\86\117\193\115\15\83\88\207\97\56\4\77\203\123\53\86\75\218\122\34\87\10\159\45", "\80\36\42\174\21");
		end
	end
	if (v20.TemplarSlash:IsReady() and v7:IsInMeleeRange(12 - 7)) then
		if v15(v20.TemplarSlash) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\90\21\58\106\66\17\37\69\93\28\54\105\70\80\48\127\64\21\37\123\90\31\37\105\14\66\103", "\26\46\112\87");
		end
	end
	if (v20.CrusaderStrike:IsCastable() and v7:IsSpellInRange(v20.CrusaderStrike)) then
		if v15(v20.CrusaderStrike) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\186\49\190\103\190\187\64\166\134\48\191\102\182\180\64\244\190\38\165\113\173\190\81\187\171\48\235\38\233", "\212\217\67\203\20\223\223\37");
		end
	end
	if (v20.HammerofWrath:IsReady() and v7:IsSpellInRange(v20.HammerofWrath)) then
		if v15(v20.HammerofWrath, true) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\178\140\165\223\191\159\151\221\188\178\191\192\187\153\160\146\189\136\166\215\168\140\188\221\168\158\232\128\226", "\178\218\237\200");
		end
	end
	if (v20.ArcaneTorrent:IsCastable() and v7:IsInRange(7 + 1)) then
		if v15(v20.ArcaneTorrent) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\183\167\229\209\184\176\217\196\185\167\244\213\184\161\166\215\179\187\227\194\183\161\233\194\165\245\180\136", "\176\214\213\134");
		end
	end
end
local function v85()
	if ((v6:HealthPercentage() <= v26.RetHealing.LoHHP) and v20.LayonHands:IsCastable() and not v6:DebuffUp(v20.ForbearanceDebuff)) then
		if v15(v20.LayonHands, true) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\248\172\175\235\167\88\102\252\172\184\208\187\22\93\241\171\179\218\187\95\79\241", "\57\148\205\214\180\200\54");
		end
	end
	if ((v6:HealthPercentage() <= v26.RetHealing.BubbleHP) and v20.DivineShield:IsCastable() and not v6:DebuffUp(v20.ForbearanceDebuff)) then
		if v15(v20.DivineShield, true) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\54\244\35\61\120\23\189\6\60\127\23\241\49\116\114\23\251\48\58\101\27\235\48", "\22\114\157\85\84");
		end
	end
	if ((v6:HealthPercentage() <= v26.RetHealing.WordofGloryPlayerHP) and v41:IsReady()) then
		if v15(v41, true) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\243\196\1\192\29\249\174\132\236\31\203\79\239\232\192\206\21\193\83\229\161\210\206", "\200\164\171\115\164\61\150");
		end
	end
	if ((v6:HealthPercentage() <= v26.RetHealing.FlashofLightPlayerHP) and (not v6:IsMoving() or v20.LightsCelerity:IsAvailable()) and v20.FlashofLight:IsReady()) then
		if v15(v20.FlashofLight, true) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\152\248\2\86\139\254\251\5\5\175\183\243\11\81\195\186\241\5\64\141\173\253\21\64", "\227\222\148\99\37");
		end
	end
	if ((v6:HealthPercentage() <= v26.RetHealing.ShieldofVengeanceHP) and v20.ShieldofVengeance:IsCastable()) then
		if v15(v20.ShieldofVengeance, true) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\32\90\91\243\245\55\18\93\240\185\37\87\92\241\252\50\92\81\243\185\55\87\84\243\247\32\91\68\243", "\153\83\50\50\150");
		end
	end
	if ((v6:HealthPercentage() <= v26.RetHealing.DivineProtectionHP) and v20.DivineProtection:IsCastable()) then
		if v15(v20.DivineProtectionCast, true) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\121\127\101\21\125\174\13\109\100\124\8\118\168\89\84\121\125\92\119\174\75\88\120\96\21\101\174", "\45\61\22\19\124\19\203");
		end
	end
end
local function v86()
	local v142 = v23.UnitsinRange(v20.FlashofLight);
	local v143 = v23.GetLowestHealthUnit(v142);
	local v144 = v143:HealthPercentage();
	if not v143:DebuffUp(v20.ForbearanceDebuff) then
		if (v20.LayonHands:IsReady() and (v144 <= v26.RetHealing.LoHPartyHP)) then
			v143:Cast(v20.LayonHands);
			return LUAOBFUSACTOR_DECRYPT_STR_0("\237\19\20\181\13\126\249\233\19\3\241\17\48\137\192\0\25\236", "\217\161\114\109\149\98\16");
		end
	end
	if v20.BlessingofProtection:IsReady() then
		BoPTarget = v75(v142);
		PlayerIsBoPTarget = v75(v142, true);
		if ((BoPTarget ~= nil) and not v26.RetHealing.BoPPlayerOnly and not BoPTarget:DebuffUp(v20.ForbearanceDebuff)) then
			BoPTarget:Cast(v20.BlessingofProtection);
			return LUAOBFUSACTOR_DECRYPT_STR_0("\48\44\61\111\175\125\28\39\120\115\186\52\34\50\55\104\185\119\6\41\55\114\252\68\19\50\44\101", "\20\114\64\88\28\220");
		end
		if ((PlayerIsBoPTarget ~= nil) and not v6:DebuffUp(v20.ForbearanceDebuff)) then
			v6:Cast(v20.BlessingofProtection);
			return LUAOBFUSACTOR_DECRYPT_STR_0("\19\13\215\167\235\217\179\54\65\221\178\184\224\175\62\21\215\183\236\217\178\63\65\226\184\249\201\184\35", "\221\81\97\178\212\152\176");
		end
	end
	if (v41:IsReady() and (v144 <= v26.RetHealing.WordofGloryPartyHP)) then
		v143:Cast(v41);
		return LUAOBFUSACTOR_DECRYPT_STR_0("\250\232\15\255\90\194\225\93\220\22\194\245\4\187\42\204\245\9\226", "\122\173\135\125\155");
	end
	if (v20.FlashofLight:IsReady() and (not v6:IsMoving() or v20.LightsCelerity:IsAvailable()) and (v144 <= v26.RetHealing.FlashofLightPartyHP)) then
		v143:Cast(v20.FlashofLight);
		return LUAOBFUSACTOR_DECRYPT_STR_0("\162\205\1\170\55\113\199\130\129\44\176\56\57\220\196\241\1\171\43\40", "\168\228\161\96\217\95\81");
	end
	if (v20.BlessingofSacrifice:IsReady() and (v144 <= v26.RetHealing.BlessingOfSacrificeHP) and (v6:HealthPercentage() > (315 - 225)) and v6:BuffDown(v20.BlessingofProtection)) then
		v143:Cast(v20.BlessingofSacrifice);
		return LUAOBFUSACTOR_DECRYPT_STR_0("\249\221\43\79\60\94\213\214\33\90\28\86\216\195\39\90\38\84\222\145\30\93\61\67\194", "\55\187\177\78\60\79");
	end
end
local function v87()
	if v6:AffectingCombat() then
		if (v20.Intercession:IsReady() and not v6:IsMoving()) then
			if (v8:UnitIsFriend() and v8:UnitIsPlayer() and v8:Exists() and v8:IsDeadOrGhost()) then
				v12.CastTarget(v20.Intercession, v12.TName().MOUSEOVER);
				return LUAOBFUSACTOR_DECRYPT_STR_0("\4\192\75\238\84\204\133\62\221\86\228\72\143\143\35\142\114\228\83\220\133\34\216\90\249", "\224\77\174\63\139\38\175");
			end
			if (v26.RetHealing.IntercessionTarget and v7:UnitIsFriend() and v7:Exists() and v7:IsDeadOrGhost()) then
				v12.Cast(v20.Intercession);
				return LUAOBFUSACTOR_DECRYPT_STR_0("\173\79\76\43\150\66\93\61\151\72\87\32\196\78\86\110\176\64\74\41\129\85", "\78\228\33\56");
			end
		end
	end
end
local function v88()
	v35 = v23.HealthPotions();
	if v35 then
		return v35;
	end
	if v6:IsChanneling(v21.ManicGrieftorch.ItemUseSpell) then
		return LUAOBFUSACTOR_DECRYPT_STR_0("\234\113\188\23\197\205\107\166\67\177\193\108\177\11", "\229\174\30\210\99");
	end
	if (v6:IsInParty() or v6:IsInRaid()) then
		local v163 = v87();
		if v163 then
			return v163;
		end
	end
	SmallCDToggle = v12.ToggleIconFrame:GetToggle(2 - 1);
	InterruptToggle = v12.ToggleIconFrame:GetToggle(2 - 0);
	DispelToggle = v12.ToggleIconFrame:GetToggle(9 - 6);
	v38 = v23.UnitsinRange(v20.FlashofLight);
	UnitForFreezingBinds = v70(v38);
	v41 = (v20.EternalFlame:IsAvailable() and v20.EternalFlame) or v20.WordofGlory;
	v39 = v6:GetEnemiesInRange(1256 - (111 + 1137));
	if v13() then
		v40 = #v39;
	else
		v40 = 159 - (91 + 67);
	end
	RacialsSetting = v77(v26.RetCooldowns.RacialsSetting) and v80(v26.RetTTD.RacialsTTD);
	Trinket1Setting = v77(v26.RetCooldowns.Trinket1Setting) and v80(v26.RetTTD.TrinketsTTD);
	Trinket2Setting = v77(v26.RetCooldowns.Trinket2Setting) and v80(v26.RetTTD.TrinketsTTD);
	PotionSetting = v77(v26.RetCooldowns.PotionSetting) and not v23.ISSolo();
	DivineTollSetting = v77(v26.RetCooldowns.DivineTollSetting) and v80(v26.RetTTD.DivineTollTTD);
	AvengingWrathSetting = v77(v26.RetCooldowns.AvengingWrathSetting) and v80(v26.RetTTD.AvengingWrathTTD);
	ExecutionSentenceSetting = v77(v26.RetCooldowns.ExecutionSentenceSetting) and v80(v26.RetTTD.ExecutionSentenceTTD);
	FinalReckoningSetting = v77(v26.RetCooldowns.FinalReckoningSetting) and v80(v26.RetTTD.FinalReckoningTTD);
	CrusadeSetting = v77(v26.RetCooldowns.CrusadeSetting) and v80(v26.RetTTD.CrusadeTTD);
	WakeofAshesSetting = v77(v26.RetCooldowns.WakeofAshesSetting) and v80(v26.RetTTD.WakeofAshesTTD);
	DivineHammerSetting = v77(v26.RetCooldowns.DivineHammerSetting) and v80(v26.RetTTD.DivineHammerTTD);
	WeaponSetting = v77(v26.RetCooldowns.WeaponSetting) and v80(44 - 29);
	AuraSelected = v26.Retribution.AuraSelect;
	if (v23.TargetIsValid() or v6:AffectingCombat()) then
		v29 = v68();
		v27 = v3.BossFightRemains();
		v34 = true;
		v28 = v27;
		if (v28 == (2773 + 8338)) then
			v34 = false;
			v28 = v3.FightRemains(v39, false);
		end
		v31 = v6:GCD();
		v30 = v6:HolyPower();
	end
	if (v20.DevotionAura:IsReady() and (AuraSelected == LUAOBFUSACTOR_DECRYPT_STR_0("\63\232\144\94\249\52\54\21\173\167\68\255\60", "\89\123\141\230\49\141\93")) and v6:BuffDown(v20.DevotionAura, true)) then
		v15(v20.DevotionAura);
		return LUAOBFUSACTOR_DECRYPT_STR_0("\215\116\224\3\4\67\252\127\182\45\5\88\242", "\42\147\17\150\108\112");
	end
	if (v20.CrusaderAura:IsReady() and (AuraSelected == LUAOBFUSACTOR_DECRYPT_STR_0("\44\180\56\108\230\236\10\180\109\94\242\250\14", "\136\111\198\77\31\135")) and v6:BuffDown(v20.CrusaderAura, true)) then
		v15(v20.CrusaderAura);
		return LUAOBFUSACTOR_DECRYPT_STR_0("\33\27\178\69\188\224\18\187\66\40\178\68\188", "\201\98\105\199\54\221\132\119");
	end
	if (v20.ConcentrationAura:IsReady() and (AuraSelected == LUAOBFUSACTOR_DECRYPT_STR_0("\154\3\141\34\7\59\184\171\13\151\40\13\59\236\152\25\145\32", "\204\217\108\227\65\98\85")) and v6:BuffDown(v20.ConcentrationAura, true)) then
		v15(v20.ConcentrationAura);
		return LUAOBFUSACTOR_DECRYPT_STR_0("\125\204\251\230\41\206\74\209\244\241\37\207\80\131\212\240\62\193", "\160\62\163\149\133\76");
	end
	if v6:AffectingCombat() then
		v35 = v85();
		if v35 then
			return v35;
		end
	end
	if (v6:IsInParty() and not v6:IsInRaid()) then
		v35 = v86();
		if v35 then
			return v35;
		end
		if (v20.CleanseToxins:IsReady() and v26.Retribution.UseCleanse and DispelToggle) then
			v35 = v23.DispelCycle(v20.CleanseToxins, LUAOBFUSACTOR_DECRYPT_STR_0("\230\175\4\60\204\216", "\163\182\192\109\79"));
			if v35 then
				return v35;
			end
			v35 = v23.DispelCycle(v20.CleanseToxins, LUAOBFUSACTOR_DECRYPT_STR_0("\16\47\19\197\244\39\35", "\149\84\70\96\160"));
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
						return LUAOBFUSACTOR_DECRYPT_STR_0("\26\10\8\254\43\15\3\234\120\9\11\173\30\20\8\232\60\9\0\173\30\20\2\247\61\8\77\207\49\8\9\254", "\141\88\102\109");
					end
				end
				if v20.UnboundFreedom:IsAvailable() then
					if (v23.unitHasDebuffFromList(v23.DebuffList[LUAOBFUSACTOR_DECRYPT_STR_0("\150\93\222\113\20\58\89\196\183", "\161\211\51\170\16\122\93\53")], v5(v26.RetHealing.UnboundFreedomUnit)) or v23.unitHasDebuffFromList(v23.DebuffList[LUAOBFUSACTOR_DECRYPT_STR_0("\222\160\166\41\245\169\190\45\255", "\72\155\206\210")], v6)) then
						v5(v26.RetHealing.UnboundFreedomUnit):Cast(v20.BlessingofFreedom);
						return LUAOBFUSACTOR_DECRYPT_STR_0("\100\117\114\78\60\72\58", "\83\38\26\52\110") .. v26.RetHealing.UnboundFreedomUnit;
					end
					v35 = v72(v20.BlessingofFreedom, LUAOBFUSACTOR_DECRYPT_STR_0("\106\24\40\82\124\30\52\86\93\27", "\38\56\119\71"));
					if v35 then
						return v35;
					end
					v35 = v72(v20.BlessingofFreedom, LUAOBFUSACTOR_DECRYPT_STR_0("\192\225\89\196\32\100\252\224\76", "\54\147\143\56\182\69"));
					if v35 then
						return v35;
					end
					v35 = v72(v20.BlessingofFreedom, LUAOBFUSACTOR_DECRYPT_STR_0("\240\147\250\76\219\217\140\219\64\204\198\132\243", "\191\182\225\159\41"));
					if v35 then
						return v35;
					end
				else
					if (v6:DebuffElapsed(v20.EntangledDebuff) > (525 - (423 + 100))) then
						if v6:Cast(v20.BlessingofFreedom) then
							return LUAOBFUSACTOR_DECRYPT_STR_0("\9\30\45\70\152\142\204\44\82\39\83\203\161\208\46\23\44\90\134\199\199\37\6\41\91\140\139\203\37\21", "\162\75\114\72\53\235\231");
						end
					end
					v35 = v23.DispelCycle(v20.BlessingofFreedom, LUAOBFUSACTOR_DECRYPT_STR_0("\190\51\75\246\119\11\159\44\65\238", "\98\236\92\36\130\51"), nil, v38);
					if v35 then
						return v35;
					end
					v35 = v23.DispelCycle(v20.BlessingofFreedom, LUAOBFUSACTOR_DECRYPT_STR_0("\151\23\13\168\64\154\186\63\176", "\80\196\121\108\218\37\200\213"), nil, v38);
					if v35 then
						return v35;
					end
					v35 = v23.DispelCycle(v20.BlessingofFreedom, LUAOBFUSACTOR_DECRYPT_STR_0("\38\97\7\122\79\1\135\36\122\17\111\78\2", "\234\96\19\98\31\43\110"), nil, v38);
					if v35 then
						return v35;
					end
				end
			end
			if (v23.unitHasDebuffFromList(v23.DebuffList[LUAOBFUSACTOR_DECRYPT_STR_0("\52\16\93\211\136\123\152\22\26\94", "\235\102\127\50\167\204\18")], v6) or v23.unitHasDebuffFromList(v23.DebuffList[LUAOBFUSACTOR_DECRYPT_STR_0("\99\175\244\49\65\28\95\174\225", "\78\48\193\149\67\36")], v6) or v23.unitHasDebuffFromList(v23.DebuffList[LUAOBFUSACTOR_DECRYPT_STR_0("\22\12\133\29\69\63\19\164\17\82\32\27\140", "\33\80\126\224\120")], v6)) then
				v6:Cast(v20.BlessingofFreedom);
				return LUAOBFUSACTOR_DECRYPT_STR_0("\206\167\37\132\83\226\232\51\200\93\245\173\17", "\60\140\200\99\164");
			end
			if ((v6:DebuffUp(v10(2980 + 421515), true) or v6:DebuffUp(v10(1175371 - 750874), true)) and v6:IsInRaid()) then
				v6:Cast(v20.BlessingofFreedom);
				return;
			end
		end
	end
	if v20.BlessingofProtection:IsReady() then
		BoPTarget = v75(v38);
		PlayerIsBoPTarget = v75(v38, true);
		if ((BoPTarget ~= nil) and not v26.RetHealing.BoPPlayerOnly) then
			BoPTarget:Cast(v20.BlessingofProtection);
			return LUAOBFUSACTOR_DECRYPT_STR_0("\165\248\1\53\177\142\250\3\102\173\129\180\52\52\173\147\241\7\50\171\136\250\68\22\163\149\224\29\102\226", "\194\231\148\100\70") .. BoPTarget:Name() .. the .. BoPTarget:Role();
		end
		if (PlayerIsBoPTarget == nil) then
		else
			v6:Cast(v20.BlessingofProtection);
			return LUAOBFUSACTOR_DECRYPT_STR_0("\100\64\196\176\229\193\72\75\129\172\240\136\118\94\206\183\243\203\82\69\206\173\182\248\74\77\216\166\228", "\168\38\44\161\195\150");
		end
	end
	if v23.TargetIsValid() then
		if (not v6:AffectingCombat() and v26.Retribution.AttackOutOfCombat) then
			v35 = v81();
			if v35 then
				return v35;
			end
		end
		if InterruptToggle then
			v35 = v23.InterruptCycle(v20.Rebuke, 3 + 2, true, nil, false);
			if v35 then
				return v35;
			end
			v35 = not v6:IsMoving() and v23.InterruptCycle(v20.HammerofJustice, 781 - (326 + 445), false, nil, true);
			if v35 then
				return v35;
			end
			v35 = not v6:IsMoving() and not v26.Retribution.XalatathsBargain and v23.InterruptCycle(v20.BlindingLight, 43 - 33, false, nil, true, true);
			if v35 then
				return v35;
			end
			if (v26.Retribution.XalatathsBargain and (EnemiesWithIDInCCRange(510830 - 281534) >= (9 - 5)) and v20.BlindingLight:IsCastable()) then
				if v15(v20.BlindingLight) then
					return LUAOBFUSACTOR_DECRYPT_STR_0("\162\240\139\120\52\225\184\17\172\245\133\126\36\168\185\24\192\196\131\122\49\252\183\2\136\239\160\119\34\239\183\31\142", "\118\224\156\226\22\80\136\214");
				end
			end
		end
		if (v7:AffectingCombat() or v26.Retribution.AttackOutOfCombat) then
			local v170 = v82();
			if v170 then
				return v170;
			end
			local v170 = v84();
			if v170 then
				return v170;
			end
		end
	end
	v35 = (v40 > (711 - (530 + 181))) and not v7:IsInRange(889 - (614 + 267)) and v76();
	if v35 then
		return v35;
	end
end
local function v89()
	v26.Retribution.Display();
	v12.ResetToggle();
	v12.ToggleIconFrame:AddButtonCustom("S", 33 - (19 + 13), LUAOBFUSACTOR_DECRYPT_STR_0("\113\227\88\140\78\174\122\164\81", "\224\34\142\57"), LUAOBFUSACTOR_DECRYPT_STR_0("\205\170\196\209\127\242\89\29", "\110\190\199\165\189\19\145\61"));
	v12.ToggleIconFrame:AddButtonCustom("I", 2 - 0, LUAOBFUSACTOR_DECRYPT_STR_0("\243\229\99\237\153\213\207\251\99", "\167\186\139\23\136\235"), LUAOBFUSACTOR_DECRYPT_STR_0("\19\187\156\8\8\167\157\29\14", "\109\122\213\232"));
	v12.ToggleIconFrame:AddButtonCustom("D", 6 - 3, LUAOBFUSACTOR_DECRYPT_STR_0("\202\254\177\32\235\251", "\80\142\151\194"), LUAOBFUSACTOR_DECRYPT_STR_0("\7\207\100\92\6\202", "\44\99\166\23"));
	v20.MarkofFyralathDebuff:RegisterAuraTracking();
	v23.PostInitialMessage(199 - 129);
end
v12.SetAPL(19 + 51, v88, v89);
