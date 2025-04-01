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
local v18 = math.max;
local v19 = math.min;
local v20 = v10.Paladin.Protection;
local v21 = v11.Paladin.Protection;
local v22 = {v21.ManicGrieftorch:ID()};
local v23 = {{v20.HammerofJustice,LUAOBFUSACTOR_DECRYPT_STR_0("\242\194\200\49\166\147\198\19\220\198\201\101\233\189\135\52\196\208\207\44\229\190\135\86\248\205\207\32\244\169\210\14\197\138", "\126\177\163\187\69\134\219\167"),function()
	return true;
end}};
local v24 = 14 - 9;
local v25;
local v26;
local v27, v28;
local v29, v30;
local v24 = 382 - (142 + 235);
local v31;
local v32 = 50405 - 39294;
local v33 = 2418 + 8693;
local v34, v35, v36, v37;
local v38;
local v39 = v6:GetEquipment();
local v40 = (v39[990 - (553 + 424)] and v11(v39[23 - 10])) or v11(0 + 0);
local v41 = (v39[14 + 0] and v11(v39[9 + 5])) or v11(0 + 0);
v3:RegisterForEvent(function()
	v39 = v6:GetEquipment();
	v40 = (v39[8 + 5] and v11(v39[27 - 14])) or v11(0 - 0);
	v41 = (v39[31 - 17] and v11(v39[5 + 9])) or v11(0 - 0);
end, LUAOBFUSACTOR_DECRYPT_STR_0("\19\225\11\252\217\17\242\15\244\201\10\253\7\224\210\23\242\9\237\221\13\234\15\225", "\156\67\173\74\165"));
local function v42()
	return v21.ManicGrieftorch:IsEquipped() and (v21.ManicGrieftorch:CooldownUp() or (v21.ManicGrieftorch:CooldownRemains() <= v6:GCDRemains()));
end
local function v43()
	return v21.AlgetharPuzzleBox:IsEquipped() and (v21.AlgetharPuzzleBox:CooldownUp() or (v21.AlgetharPuzzleBox:CooldownRemains() <= v6:GCDRemains()));
end
v3:RegisterForEvent(function()
	v32 = 11864 - (239 + 514);
	v33 = 3903 + 7208;
end, LUAOBFUSACTOR_DECRYPT_STR_0("\4\155\104\47\153\20\121\6\146\110\51\146\25\99\26\150\107\58\153\2", "\38\84\215\41\118\220\70"));
local v44 = v12.GUISettingsGet();
local v45 = v12.Commons().Everyone;
local v46 = v12.Commons().Paladin;
local v47 = {[LUAOBFUSACTOR_DECRYPT_STR_0("\119\19\44\23\236\81\26", "\158\48\118\66\114")]=v44.General,[LUAOBFUSACTOR_DECRYPT_STR_0("\136\43\29\59\124\171\232", "\155\203\68\112\86\19\197")]=v44.APL.Paladin.Commons,[LUAOBFUSACTOR_DECRYPT_STR_0("\118\207\57\232\69\123\241\241\73\211\18\249\70\125\235\235\79\203\51\239", "\152\38\189\86\156\32\24\133")]=v44.APL.Paladin.ProtectionDefensives,[LUAOBFUSACTOR_DECRYPT_STR_0("\204\69\168\82\249\84\179\79\243\89", "\38\156\55\199")]=v44.APL.Paladin.Protection,[LUAOBFUSACTOR_DECRYPT_STR_0("\152\111\115\60\39\64\222", "\35\200\29\28\72\115\20\154")]=v44.APL.Paladin.ProtTTD};
local function v48()
	if (v44.General.AutoTab and v6:AffectingCombat()) then
		v12.TopPanelAlternative:ChangeIcon(1330 - (797 + 532), 3 + 0);
		return LUAOBFUSACTOR_DECRYPT_STR_0("\56\170\197\208\205\56\53\27\255\197\208\205\56\53\11\184\212\203", "\84\121\223\177\191\237\76");
	end
end
local function v49(v68)
	return v31 or v45.ISSolo() or (v68 == (0 + 0)) or v45.Buggedmobs[v7:NPCID()] or ((v33 >= v68) and (v33 < (18285 - 10508)));
end
local function v50(v69, v70)
	return ((v69 ~= LUAOBFUSACTOR_DECRYPT_STR_0("\149\89\221\224\15\67\53\197", "\161\219\54\169\192\90\48\80")) and v49(v47.ProtTTD.TrinketsTTD) and (((v69 == LUAOBFUSACTOR_DECRYPT_STR_0("\126\75\20\45\9\97\15\42\69\70\15\50\71\81", "\69\41\34\96")) and v12.CDsON()) or ((v69 == LUAOBFUSACTOR_DECRYPT_STR_0("\139\202\195\2\66\24\177\194\219\6\66\36\174\131\244\5\13\39\184\204\192\4\17", "\75\220\163\183\106\98")) and (SmallCDToggle or v12.CDsON())) or ((v69 == LUAOBFUSACTOR_DECRYPT_STR_0("\53\179\159\63\153\49\183\138\59\213\66\153\175\36", "\185\98\218\235\87")) and SmallCDToggle) or ((v69 == LUAOBFUSACTOR_DECRYPT_STR_0("\228\50\103\203\209\168\200\51\50\232\202", "\202\171\92\71\134\190")) and (v29 >= v47.Protection.Mobcount)) or ((v69 == LUAOBFUSACTOR_DECRYPT_STR_0("\6\207\108\165\38\195\47\135\60\207\56\200\38\211\108\171\38\206\32\140\38\214\34\155", "\232\73\161\76")) and ((v29 >= v47.Protection.Mobcount) or v14())) or (v69 == LUAOBFUSACTOR_DECRYPT_STR_0("\154\213\85\92\7\168", "\126\219\185\34\61")) or ((v69 == LUAOBFUSACTOR_DECRYPT_STR_0("\59\199\74\122\62\85\255\232\3\202\82\103\109\99\179\232\2\194\71", "\135\108\174\62\18\30\23\147")) and v6:BloodlustUp()) or ((v69 == LUAOBFUSACTOR_DECRYPT_STR_0("\153\231\106\233\23\189\32\194\165", "\167\214\137\74\171\120\206\83")) and v31) or ((v69 == LUAOBFUSACTOR_DECRYPT_STR_0("\166\255\48\94\247\178\133\228\114\82\234\231\169\255\33\78", "\199\235\144\82\61\152")) and (v31 or (v29 >= v47.Protection.Mobcount))))) or ((v69 == LUAOBFUSACTOR_DECRYPT_STR_0("\40\24\249\3\2\23\181\63\15\38\188\57\4\19\183\63", "\75\103\118\217")) and (v70 ~= nil) and (v6:HealthPercentageWeighted() < v70));
end
local function v51()
	return v6:BuffUp(v20.ArdentDefender) or v6:BuffUp(v20.GuardianofAncientKings) or v6:BuffUp(v20.DivineShield);
end
local function v52()
	return v47.Protection.Consecration or not v6:IsMoving();
end
local v53 = {(226694 - (476 + 255)),(115800 + 84382),(372091 - 175737),(32115 + 193369),(196712 - (144 + 192)),(195878 + 64863),(181264 + 245396),(414085 - (1183 + 397)),(187524 + 68290),(257409 - (1913 + 62)),(699285 - 435135),(1548294 - 1136594),(561326 - 149368),(265412 - (564 + 292)),(608056 - 406323),(205997 + 61910),(261552 - (938 + 63)),(258532 - (936 + 189)),(428272 - (1565 + 48))};
local function v54(v71)
	local v72 = nil;
	for v81, v82 in pairs(v71) do
		if (v6 ~= v82) then
			if ((v82:Role() ~= LUAOBFUSACTOR_DECRYPT_STR_0("\243\117\94\63", "\126\167\52\16\116\217")) and ((v47.ProtectionDefensives.BoPDebuff and (v45.unitHasDebuffFromList(v45.DebuffList[LUAOBFUSACTOR_DECRYPT_STR_0("\234\34\37\133\176", "\156\168\78\64\224\212\121")], v82) or v45.unitHasDebuffFromList(v53, v82))) or (v82:HealthPercentageWeighted() <= v47.ProtectionDefensives.BoPHP)) and v82:DebuffDown(v20.ForbearanceDebuff)) then
				v72 = v82;
			end
		end
	end
	return v72;
end
local function v55(v73)
	local v74 = v47.ProtectionDefensives.IntercessionUnit;
	if (v74 == LUAOBFUSACTOR_DECRYPT_STR_0("\38\226\169", "\174\103\142\197")) then
		for v94, v95 in pairs(v73) do
			if v95:IsDeadOrGhost() then
				return v95;
			end
		end
		return nil;
	end
	local v75 = {[LUAOBFUSACTOR_DECRYPT_STR_0("\120\39\81\61", "\152\54\72\63\88\69\62")]={},[LUAOBFUSACTOR_DECRYPT_STR_0("\224\197\224\87", "\60\180\164\142")]={LUAOBFUSACTOR_DECRYPT_STR_0("\108\127\43\2", "\114\56\62\101\73\71\141")},[LUAOBFUSACTOR_DECRYPT_STR_0("\144\236\218\200\189\251", "\164\216\137\187")]={LUAOBFUSACTOR_DECRYPT_STR_0("\250\195\16\158\131\204", "\107\178\134\81\210\198\158")},[LUAOBFUSACTOR_DECRYPT_STR_0("\12\15\140\205\234\57\0\134\134\130\61\15\142\195\184", "\202\88\110\226\166")]={LUAOBFUSACTOR_DECRYPT_STR_0("\247\46\172\220", "\170\163\111\226\151"),LUAOBFUSACTOR_DECRYPT_STR_0("\57\21\147\20\107\5", "\73\113\80\210\88\46\87")},[LUAOBFUSACTOR_DECRYPT_STR_0("\165\8", "\135\225\76\173\114")]={LUAOBFUSACTOR_DECRYPT_STR_0("\62\204\149\145\139\152\149", "\199\122\141\216\208\204\221")}};
	local v76 = v75[v74] or {};
	for v83, v84 in pairs(v73) do
		local v85 = v84:Role();
		local v86 = v84:IsDeadOrGhost();
		for v87, v88 in ipairs(v76) do
			if ((v85 == v88) and v86) then
				return v84;
			end
		end
	end
	return nil;
end
local function v56(v77)
	local v78 = UnitGUID(LUAOBFUSACTOR_DECRYPT_STR_0("\185\220\2\247\125\226\185\220\2\247\125\226", "\150\205\189\112\144\24"));
	if (v77 ~= nil) then
		for v96, v97 in pairs(v77) do
			if ((v97:GUID() == v78) and ((v7:CastSpellID() == (321880 - (975 + 117))) or (v7:CastSpellID() == (325605 - (157 + 1718))))) then
				if (v97 ~= nil) then
					return v97;
				end
			end
		end
	end
end
local function v57(v79)
	return v79:DebuffRemains(v20.JudgmentDebuff);
end
local function v58()
	return v6:BuffDown(v20.DevotionAura) and v6:BuffDown(v20.ConcentrationAura) and v6:BuffDown(v20.CrusaderAura);
end
local function v59()
	if not v20.OfDuskandDawn:IsAvailable() then
		return -(1 + 0);
	end
	return ((21 - 15) - v46.HPGCount) - (v6:BuffStack(v20.BlessingofDawnBuff) * (10 - 7));
end
local function v60()
	if (v20.DevotionAura:IsCastable() and (v58())) then
		if v15(v20.DevotionAura) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\33\129\169\67\16\129\30\30\26\133\170\94\5\200\1\2\32\135\176\65\6\137\5\80\115", "\112\69\228\223\44\100\232\113");
		end
	end
	if (v20.LightsJudgment:IsCastable() and v7:IsInMeleeRange(1023 - (697 + 321)) and RacialsSetting) then
		if v15(v20.LightsJudgment) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\216\22\0\219\162\111\185\222\10\3\212\187\121\136\192\95\23\193\179\127\137\217\29\6\199\246\36", "\230\180\127\103\179\214\28");
		end
	end
	if (v20.ArcaneTorrent:IsCastable() and v7:IsInMeleeRange(21 - 13) and RacialsSetting) then
		if v15(v20.ArcaneTorrent) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\141\23\92\71\234\68\223\152\10\77\84\225\79\244\204\21\77\67\231\78\237\142\4\75\6\181\17", "\128\236\101\63\38\132\33");
		end
	end
	if (v20.Consecration:IsCastable() and v52() and v7:IsInMeleeRange(10 - 5)) then
		if v15(v20.Consecration) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\175\166\31\87\179\232\221\173\189\24\75\184\171\223\190\172\18\75\187\233\206\184\233\64\22", "\175\204\201\113\36\214\139");
		end
	end
	if (v20.AvengersShield:IsCastable() and v7:IsSpellInRange(v20.AvengersShield) and v7:IsSpellInRange(v20.AvengersShield)) then
		if v15(v20.AvengersShield) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\70\218\48\210\3\66\222\38\227\23\79\197\48\208\0\7\220\39\217\7\72\193\55\221\16\7\157\101", "\100\39\172\85\188");
		end
	end
	if (v20.Judgment:IsReady() and v7:IsSpellInRange(v20.Judgment) and v7:IsSpellInRange(v20.Judgment)) then
		if v15(v20.Judgment) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\167\109\189\135\62\168\118\173\192\35\191\125\186\143\62\175\121\173\192\98\255", "\83\205\24\217\224");
		end
	end
end
local function v61()
	if ((v6:HealthPercentage() <= v47.ProtectionDefensives.LoHHP) and v20.LayonHands:IsCastable() and v6:DebuffDown(v20.ForbearanceDebuff)) then
		if v15(v20.LayonHands, nil) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\234\196\212\2\233\203\242\53\231\203\201\46\166\193\200\59\227\203\222\52\240\192\141\111", "\93\134\165\173");
		end
	end
	if (v20.GuardianofAncientKings:IsCastable() and (((v6:HealthPercentageWeighted() <= v47.ProtectionDefensives.GoAKHP) and v6:BuffDown(v20.ArdentDefenderBuff)) or (v47.ProtectionDefensives.TankBusters and v6:IncomingSpell(v45.TankBustersList2))) and not v51()) then
		if v15(v20.GuardianofAncientKingsCast, nil) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\185\231\192\208\62\199\179\112\129\253\199\253\59\192\177\119\187\252\213\253\49\199\188\121\173\178\197\199\60\203\188\109\183\228\196\130\110", "\30\222\146\161\162\90\174\210");
		end
	end
	if (v20.ArdentDefender:IsCastable() and ((v6:HealthPercentageWeighted() <= v47.ProtectionDefensives.ArdentDefenderHP) or (v47.ProtectionDefensives.TankBusters and v6:IncomingSpell(v45.TankBustersList2))) and not v51()) then
		if v15(v20.ArdentDefender, nil) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\228\92\116\15\235\90\79\14\224\72\117\4\225\75\98\74\225\75\118\15\235\93\121\28\224\14\38", "\106\133\46\16");
		end
	end
	if (v20.BlessingOfSpellwarding:IsCastable() and ((v6:HealthPercentageWeighted() <= v47.ProtectionDefensives.BlessingOfSpellwardingHP) or (v47.ProtectionDefensives.TankBusters and v6:IncomingSpell(v45.TankBustersList2))) and not v51()) then
		if v15(v20.BlessingOfSpellwarding, nil) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\90\44\118\239\73\73\86\39\76\243\92\127\75\48\118\240\86\87\89\50\119\245\84\71\24\36\118\250\95\78\75\41\101\249\26\24", "\32\56\64\19\156\58");
		end
	end
	if (v20.WordofGlory:IsReady() and v6:BuffUp(v20.ShiningLightFreeBuff) and v20.FaithintheLight:IsAvailable() and not v6:BuffUp(v20.FaithintheLightBuff) and v47.ProtectionDefensives.WordofGloryFaithintheLight) then
		if v15(v20.WordofGlory) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\77\199\247\82\101\253\134\101\207\233\89\72\235\192\124\201\236\66\82\251\142\78\192\224\122\83\245\136\78\234\240\80\92", "\224\58\168\133\54\58\146");
		end
	end
	if (v20.WordofGlory:IsReady() and ((v6:HealthPercentageWeighted() <= v47.ProtectionDefensives.WordofGloryPlayerHP) or ((v6:HealthPercentageWeighted() <= v47.ProtectionDefensives.FreeWordofGloryPlayerHP) and v6:BuffUp(v20.ShiningLightFreeBuff))) and not v6:HealingAbsorbed()) then
		if v15(v20.WordofGlory) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\78\89\89\249\74\137\129\52\94\90\68\239\108\198\131\14\95\83\69\238\124\144\130\75\1", "\107\57\54\43\157\21\230\231");
		end
	end
	if ((v6:HealthPercentageWeighted() <= v47.ProtectionDefensives.BubbleHP) and v20.DivineShield:IsCastable() and v6:DebuffDown(v20.ForbearanceDebuff)) then
		if v15(v20.DivineShield, nil) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\255\130\7\252\183\217\143\232\131\24\240\181\216\143\223\142\23\240\183\207\198\205\142", "\175\187\235\113\149\217\188");
		end
	end
end
local function v62()
	v34 = v45.UnitsinRange(v20.FlashofLight);
	v35 = v45.GetLowestHealthUnit(v34);
	v36 = v35:HealthPercentageWeighted();
	v37 = v55(v34);
	BoPTarget = v54(v34);
	if not v35:DebuffUp(v20.ForbearanceDebuff) then
		if (v20.LayonHands:IsReady() and (v36 <= v47.ProtectionDefensives.LoHPartyHP)) then
			v35:Cast(v20.LayonHands);
			return LUAOBFUSACTOR_DECRYPT_STR_0("\16\174\152\12\236\119\56\20\174\143\72\240\57\72\61\189\149\85", "\24\92\207\225\44\131\25");
		end
	end
	if v20.BlessingofProtection:IsReady() then
		if ((BoPTarget ~= nil) and (BoPTarget ~= v6)) then
			BoPTarget:Cast(v20.BlessingofProtection);
			return LUAOBFUSACTOR_DECRYPT_STR_0("\105\223\189\95\8\116\69\212\248\67\29\61\123\193\183\88\30\126\95\218\183\66\91\77\74\193\172\85", "\29\43\179\216\44\123");
		end
	end
	if v20.Intercession:IsReady() then
		if (v8:UnitIsFriend() and v8:UnitIsPlayer() and v8:Exists() and v8:IsDeadOrGhost()) then
			v12.CastTarget(v20.Intercession, v12.TName().MOUSEOVER);
			return LUAOBFUSACTOR_DECRYPT_STR_0("\148\215\52\73\175\218\37\95\174\208\47\66\253\214\46\12\144\214\53\95\184\214\54\73\175", "\44\221\185\64");
		end
		if (v47.ProtectionDefensives.IntercessionTarget and v7:UnitIsFriend() and v7:Exists() and v7:IsDeadOrGhost()) then
			v12.Cast(v20.Intercession);
			return LUAOBFUSACTOR_DECRYPT_STR_0("\40\233\92\90\97\2\226\91\76\122\14\233\8\80\125\65\211\73\77\116\4\243", "\19\97\135\40\63");
		end
	end
	if (v20.BlessingofSacrifice:IsReady() and (v36 <= v47.ProtectionDefensives.BlessingOfSacrificeHP) and (v6:HealthPercentage() > (207 - 117)) and v6:BuffDown(v20.BlessingofProtection)) then
		v35:Cast(v20.BlessingofSacrifice);
		return LUAOBFUSACTOR_DECRYPT_STR_0("\140\80\54\40\60\56\160\91\60\61\28\48\173\78\58\61\38\50\171\28\3\58\61\37\183", "\81\206\60\83\91\79");
	end
	if (v20.WordofGlory:IsReady() and ((v36 <= v47.ProtectionDefensives.WordofGloryPartyHP) or ((v36 <= v47.ProtectionDefensives.FreeWordofGloryPartyHP) and v6:BuffUp(v20.ShiningLightFreeBuff)))) then
		v35:Cast(v20.WordofGlory);
		return LUAOBFUSACTOR_DECRYPT_STR_0("\121\164\194\118\111\204\75\228\105\167\223\96\54\131\125\165\92\191\201", "\196\46\203\176\18\79\163\45");
	end
end
local function v63()
	if (v20.LightsJudgment:IsCastable() and RacialsSetting and v7:IsInRange(2 + 3) and v7:IsSpellInRange(v20.LightsJudgment)) then
		if v15(v20.LightsJudgment, false, nil, not v7:IsSpellInRange(v20.LightsJudgment)) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\180\43\121\22\48\232\208\178\55\122\25\41\254\225\172\98\125\17\43\247\235\183\53\112\13\100\169", "\143\216\66\30\126\68\155");
		end
	end
	if (v20.AvengingWrath:IsCastable() and AvengingWrathSetting and v7:IsInRange(9 - 4)) then
		if v15(v20.AvengingWrath, false) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\171\222\8\197\194\170\217\230\149\223\31\202\209\171\151\226\165\199\1\207\202\180\217\242\234\156", "\129\202\168\109\171\165\195\183");
		end
	end
	if (v20.Sentinel:IsCastable() and AvengingWrathSetting and v7:IsInRange(13 - 8)) then
		if v15(v20.Sentinel, false) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\49\93\57\204\215\26\227\46\24\52\215\209\24\226\45\79\57\203\158\66", "\134\66\56\87\184\190\116");
		end
	end
	if (v47.Commons.Enabled.Potions and PotionSetting and (v6:BuffUp(v20.AvengingWrathBuff))) then
		local v89 = v45.PotionSelected();
		if (v89 and v89:IsReady()) then
			v12.CastMacro(1230 - (322 + 905), nil, nil, v89);
			return LUAOBFUSACTOR_DECRYPT_STR_0("\31\48\26\175\89\219\46\33\53\62\7", "\85\92\81\105\219\121\139\65");
		end
	end
	if (v20.MomentofGlory:IsCastable() and ((v6:BuffUp(v20.AvengingWrathBuff) and (v6:BuffRemains(v20.AvengingWrathBuff) < (626 - (602 + 9)))) or (((v3.CombatTime() > (1199 - (449 + 740))) or (v20.AvengingWrath:CooldownRemains() > (887 - (826 + 46)))) and v20.AvengersShield:CooldownDown() and v20.Judgment:CooldownDown() and v20.HammerofWrath:CooldownDown()))) then
		if v15(v20.MomentofGlory, false) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\240\188\93\64\114\203\194\188\86\122\123\211\242\161\73\5\127\208\242\191\84\74\107\209\238\243\1\21", "\191\157\211\48\37\28");
		end
	end
	if (v20.DivineToll:IsCastable() and DivineTollSetting and (v29 >= (950 - (245 + 702)))) then
		if v15(v20.DivineToll) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\219\22\226\21\52\218\32\224\19\54\211\95\247\19\53\211\27\251\11\52\204\95\165\78", "\90\191\127\148\124");
		end
	end
	if (v20.BastionofLight:IsCastable() and (v6:BuffUp(v20.AvengingWrathBuff) or (v20.AvengingWrath:CooldownRemains() <= (94 - 64)))) then
		if v15(v20.BastionofLight, false) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\122\134\61\3\113\136\32\40\119\129\17\27\113\128\38\3\56\132\33\24\116\131\33\0\118\148\110\70\44", "\119\24\231\78");
		end
	end
	if (v20.Fireblood:IsCastable() and v7:IsInMeleeRange(2 + 3) and RacialsSetting and (v6:BuffRemains(v20.AvengingWrathBuff) > (1906 - (260 + 1638)))) then
		if v15(v20.Fireblood) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\132\36\183\79\222\76\30\141\41\229\73\211\79\29\134\34\178\68\207\0\64\212", "\113\226\77\197\42\188\32");
		end
	end
end
local function v64()
	if (v20.Judgment:IsReady() and ((v20.Judgment:Charges() >= (442 - (382 + 58))) or (v20.Judgment:FullRechargeTime() <= v6:GCD()))) then
		if v15(v20.Judgment) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\48\3\240\178\55\19\250\161\122\5\224\180\52\18\245\167\62\86\166", "\213\90\118\148");
		end
	end
	if (v20.HammerofLight:IsReady() and v7:IsInRange(38 - 26) and ((v6:BuffRemains(v20.LightsDeliveranceBuff) < (2 + 0)) or (v6:BuffRemains(v20.ShaketheHeavensBuff) < (1 - 0)) or v6:BuffDown(v20.ShaketheHeavensBuff) or (v20.EyeofTyr:CooldownRemains() < (2.5 - 1)) or (v32 < (1207 - (902 + 303))))) then
		if v15(v20.HammerofLight, true) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\83\47\185\91\72\73\17\187\80\114\87\39\179\94\89\27\61\160\87\67\95\47\166\82\13\15", "\45\59\78\212\54");
		end
	end
	if ((v14() or v20.LightsGuidance:IsAvailable()) and EyeOfTyrSetting and v20.EyeofTyr:IsCastable() and v20.LightsGuidance:IsAvailable() and ((v59() == (10 - 5)) or not v20.OfDuskandDawn:IsAvailable() or (v59() == (2 - 1)) or (v6:BuffStack(v20.BlessingofDawnBuff) > (0 + 0)))) then
		if v15(v20.EyeofTyr) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\24\87\142\134\131\60\146\255\22\105\143\130\129\38\185\176\3\66\130\133\130\47\191\244\80\4", "\144\112\54\227\235\230\78\205");
		end
	end
	local v80 = 2689 - (1121 + 569);
	if v20.RighteousProtector:IsAvailable() then
		local v90 = v19(v20.ShieldoftheRighteous:TimeSinceLastCast(), v20.WordofGlory:TimeSinceLastCast());
		v80 = v18(214 - (22 + 192), (684 - (483 + 200)) - v19(v20.ShieldoftheRighteous:TimeSinceLastCast(), v20.WordofGlory:TimeSinceLastCast()));
	end
	if (v20.ShieldoftheRighteous:IsReady() and v7:IsInMeleeRange(1468 - (1404 + 59)) and (not v20.RighteousProtector:IsAvailable() or (v80 == (0 - 0))) and not v20.HammerofLight:IsLearned()) then
		if v15(v20.ShieldoftheRighteous, true) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\160\32\6\249\220\95\140\39\9\195\196\83\182\23\29\245\215\83\167\45\0\233\195\27\160\60\14\242\212\90\161\44\79\168", "\59\211\72\111\156\176");
		end
	end
	if (v20.SacredWeapon:IsCastable() and (v6:BuffDown(v20.SacredWeaponBuff) or ((v6:BuffRemains(v20.SacredWeaponBuff) < (7 - 1)) and v6:BuffDown(v20.AvengingWrathBuff) and (v20.AvengingWrath:CooldownRemains() <= (795 - (468 + 297)))))) then
		if v15(v20.SacredWeapon) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\70\136\239\52\113\134\241\32\79\138\230\35\90\148\163\62\90\134\237\41\79\149\231\109\24", "\77\46\231\131");
		end
	end
	if (v20.Judgment:IsReady() and v7:IsSpellInRange(v20.Judgment) and (v29 > (565 - (334 + 228))) and (v6:BuffStack(v20.BulwarkofRighteousFuryBuff) >= (10 - 7)) and (v6:HolyPower() < (6 - 3))) then
		if v15(v20.Judgment) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\176\65\178\71\183\81\184\84\250\71\162\65\180\80\183\82\190\20\238", "\32\218\52\214");
		end
	end
	if (v6:BuffUp(v20.BlessedAssuranceBuff) and (v29 < (5 - 2))) then
		if (v20.BlessedHammer:IsCastable() and v7:IsInMeleeRange(2 + 3)) then
			if v15(v20.BlessedHammer) then
				return LUAOBFUSACTOR_DECRYPT_STR_0("\76\27\52\187\226\181\65\101\70\22\60\165\244\162\5\73\90\22\63\172\240\162\65\26\31\71", "\58\46\119\81\200\145\208\37");
			end
		end
		if (v20.HammeroftheRighteous:IsCastable() and v7:IsInMeleeRange(241 - (141 + 95))) then
			if v15(v20.HammeroftheRighteous) then
				return LUAOBFUSACTOR_DECRYPT_STR_0("\35\141\61\161\172\175\9\36\138\15\184\161\184\9\57\133\55\164\189\184\57\62\159\112\191\189\188\56\47\141\34\168\233\236\100", "\86\75\236\80\204\201\221");
			end
		end
	end
	if (v20.CrusaderStrike:IsCastable() and v7:IsInMeleeRange(5 + 0) and v6:BuffUp(v20.BlessedAssuranceBuff) and (v29 < (4 - 2))) then
		if v15(v20.CrusaderStrike) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\113\83\98\150\255\143\119\83\72\150\234\153\123\74\114\197\237\159\115\79\115\132\236\143\50\16\35", "\235\18\33\23\229\158");
		end
	end
	if (v20.AvengersShield:IsCastable() and v7:IsSpellInRange(v20.AvengersShield) and v6:BuffDown(v20.BulwarkofRighteousFuryBuff) and v20.BulwarkofRighteousFury:IsAvailable() and (v29 >= (6 - 3))) then
		if v15(v20.AvengersShield) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\81\172\196\181\87\191\211\168\111\169\201\178\85\182\197\251\67\174\192\181\84\187\211\191\16\235\151", "\219\48\218\161");
		end
	end
	if (v20.HammerofWrath:IsReady() and v7:IsSpellInRange(v20.HammerofWrath)) then
		if v15(v20.HammerofWrath) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\236\112\113\68\222\93\223\235\119\67\94\201\78\244\236\49\111\93\218\65\228\229\99\120\9\138\23", "\128\132\17\28\41\187\47");
		end
	end
	if (v20.Judgment:IsReady() and v7:IsSpellInRange(v20.Judgment) and ((v20.Judgment:Charges() >= (1 + 1)) or (v20.Judgment:FullRechargeTime() <= (v6:GCD() + (0.25 - 0))))) then
		if v15(v20.Judgment) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\11\39\2\61\80\4\60\18\122\78\21\51\8\62\92\19\54\70\104\13", "\61\97\82\102\90");
		end
	end
	if (v20.HolyBulwark:IsCastable() and (v20.HolyBulwark:Charges() == (2 + 0))) then
		if v15(v20.HolyBulwark) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\164\33\167\82\248\86\12\4\173\35\174\69\211\68\94\26\184\47\165\79\198\69\26\73\254\124", "\105\204\78\203\43\167\55\126");
		end
	end
	if (v20.DivineToll:IsReady() and v7:IsInRange(16 + 14) and DivineTollSetting) then
		if v15(v20.DivineToll) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\161\163\53\23\29\1\248\69\170\166\47\94\0\16\198\95\161\171\49\26\83\86\147", "\49\197\202\67\126\115\100\167");
		end
	end
	if (v20.Judgment:IsReady() and v7:IsSpellInRange(v20.Judgment)) then
		if v15(v20.Judgment) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\61\78\219\46\141\83\80\35\27\204\61\129\88\90\54\73\219\105\210\0", "\62\87\59\191\73\224\54");
		end
	end
	if (v20.AvengersShield:IsCastable() and v7:IsSpellInRange(v20.AvengersShield) and not v20.LightsGuidance:IsAvailable()) then
		if v15(v20.AvengersShield) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\230\20\255\199\224\7\232\218\216\17\242\192\226\14\254\137\244\22\251\199\227\3\232\205\167\80\162", "\169\135\98\154");
		end
	end
	if (v20.Consecration:IsCastable() and v52() and v7:IsInMeleeRange(7 - 2) and (v6:BuffDown(v20.ConsecrationBuff))) then
		if v15(v20.Consecration) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\200\120\42\71\248\48\218\202\99\45\91\243\115\219\223\118\42\80\252\33\204\139\36\116", "\168\171\23\68\52\157\83");
		end
	end
	if (v20.EyeofTyr:IsCastable() and EyeOfTyrSetting and v7:IsInMeleeRange(5 + 3) and ((v20.InmostLight:IsAvailable() and (v29 <= (164 - (92 + 71)))) or (v29 >= (2 + 1))) and not v20.LightsDeliverance:IsAvailable()) then
		if v15(v20.EyeofTyr) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\241\104\240\146\42\43\184\224\104\231\237\54\57\134\250\117\244\191\33\109\212\166", "\231\148\17\149\205\69\77");
		end
	end
	if v20.HolyBulwark:IsCastable() then
		if v15(v20.HolyBulwark) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\136\168\203\226\104\254\146\170\198\246\82\241\148\180\135\232\67\254\142\163\198\233\83\191\211\243", "\159\224\199\167\155\55");
		end
	end
	if (v20.BlessedHammer:IsCastable() and v7:IsInMeleeRange(8 - 3)) then
		if v15(v20.BlessedHammer) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\245\255\57\193\228\246\56\237\255\242\49\223\242\225\124\193\227\242\50\214\246\225\56\146\164\165", "\178\151\147\92");
		end
	end
	if (v20.HammeroftheRighteous:IsCastable() and v7:IsInMeleeRange(770 - (574 + 191))) then
		if v15(v20.HammeroftheRighteous) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\132\252\65\63\23\94\69\131\251\115\38\26\73\69\158\244\75\58\6\73\117\153\238\12\33\6\77\116\136\252\94\54\82\31\34", "\26\236\157\44\82\114\44");
		end
	end
	if (v20.CrusaderStrike:IsCastable() and v7:IsInMeleeRange(5 + 0)) then
		if v15(v20.CrusaderStrike) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\41\60\192\72\43\42\208\73\21\61\193\73\35\37\208\27\57\58\212\85\46\47\199\95\106\122\133", "\59\74\78\181");
		end
	end
	if (v20.AvengersShield:IsCastable() and v7:IsSpellInRange(v20.AvengersShield)) then
		if v15(v20.AvengersShield) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\36\199\95\84\180\32\195\73\101\160\45\216\95\86\183\101\194\78\91\189\33\208\72\94\243\113\137", "\211\69\177\58\58");
		end
	end
	if (v20.EyeofTyr:IsCastable() and EyeOfTyrSetting and v7:IsInMeleeRange(19 - 11) and not v20.LightsDeliverance:IsAvailable()) then
		if v15(v20.EyeofTyr) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\178\252\124\202\230\205\136\241\96\231\169\216\163\228\119\241\232\217\179\165\44\165", "\171\215\133\25\149\137");
		end
	end
	if (v20.ArcaneTorrent:IsCastable() and v7:IsInMeleeRange(5 + 3) and RacialsSetting and (v6:HolyPower() < (854 - (254 + 595)))) then
		if v15(v20.ArcaneTorrent) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\224\218\49\251\225\53\195\86\238\218\32\255\225\36\188\81\245\201\60\254\238\34\248\2\180\144", "\34\129\168\82\154\143\80\156");
		end
	end
	if (v20.Consecration:IsCastable() and v52() and v7:IsInMeleeRange(131 - (55 + 71)) and (v6:BuffDown(v20.SanctificationEmpowerBuff))) then
		if v15(v20.Consecration) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\134\189\61\24\77\77\155\132\166\58\4\70\14\154\145\179\61\15\73\92\141\197\228\99", "\233\229\210\83\107\40\46");
		end
	end
end
local function v65()
	if (v42() and v6:AffectingCombat() and (((v40:ID() == v21.ManicGrieftorch:ID()) and Trinket1Setting) or ((v41:ID() == v21.ManicGrieftorch:ID()) and Trinket2Setting)) and v49(v47.ProtTTD.TrinketsTTD) and v7:IsInRange(52 - 12)) then
		if v15(v21.ManicGrieftorch) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\204\67\60\223\6\254\69\32\223\0\199\86\61\196\6\201", "\101\161\34\82\182");
		end
	end
	if (v21.ElementiumPocketAnvil:IsEquippedAndReady() and v6:AffectingCombat() and (((v40:ID() == v21.ElementiumPocketAnvil:ID()) and Trinket1Setting) or ((v41:ID() == v21.ElementiumPocketAnvil:ID()) and Trinket2Setting)) and v7:IsInRange(1795 - (573 + 1217))) then
		if v15(v21.ElementiumPocketAnvil) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\205\1\92\243\222\236\150\39\253\0\105\241\216\233\135\58\201\3\79\247\215", "\78\136\109\57\158\187\130\226");
		end
	end
	if (v6:BuffUp(v20.AvengingWrathBuff) or not v20.AvengingWrath:IsAvailable() or v20.Sentinel:IsAvailable() or (v32 <= (110 - 70))) then
		local v91, v92, v93 = v6:GetUseableItems(v22);
		if v91 then
			if ((((v92 == (1 + 12)) and Trinket1Setting) or ((v92 == (21 - 7)) and Trinket2Setting)) and v7:IsInRange(v93) and v47.Commons.Enabled.Trinkets and v6:BuffDown(v20.ConcoctionKissofDeathBuff)) then
				if v15(v91, false) then
					return LUAOBFUSACTOR_DECRYPT_STR_0("\25\58\247\244\44\54\250\177\43\44\252\206\55\43\252\252\45\127\255\254\44\127", "\145\94\95\153") .. v92 .. v91:Name();
				end
			end
		end
	end
end
local function v66()
	if v6:IsChanneling(v21.ManicGrieftorch.ItemUseSpell) then
		return LUAOBFUSACTOR_DECRYPT_STR_0("\217\194\26\193\14\180\232\217\84\225\65\165\254\197", "\215\157\173\116\181\46");
	end
	if (((v40:ID() == v21.ConcoctionKissofDeath:ID()) or (v41:ID() == v21.ConcoctionKissofDeath:ID())) and v6:BuffUp(v20.ConcoctionKissofDeathBuff) and (v6:BuffRemains(v20.ConcoctionKissofDeathBuff) < (940 - (714 + 225)))) then
		if v15(v21.ConcoctionKissofDeath, true) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\22\187\133\241\213\54\160\130\253\212\30\189\152\225\213\51\144\142\243\206\61\244\136\253\213\57\176\132\229\212\38\244\211", "\186\85\212\235\146");
		end
	end
	v34 = v45.UnitsinRange(v20.FlashofLight);
	UnitForFreezingBinds = v56(v34);
	SmallCDToggle = v12.ToggleIconFrame:GetToggle(2 - 1);
	TabToggle = v12.ToggleIconFrame:GetToggle(2 - 0);
	InterruptToggle = v12.ToggleIconFrame:GetToggle(1 + 2);
	DispelToggle = v12.ToggleIconFrame:GetToggle(5 - 1);
	v27 = v6:GetEnemiesInRange(814 - (118 + 688));
	v28 = v6:GetEnemiesInRange(78 - (25 + 23));
	v34 = v45.UnitsinRange(v20.FlashofLight);
	if (v13()) then
		v29 = #v27;
		v30 = #v28;
	else
		v29 = 1 + 0;
		v30 = 1887 - (927 + 959);
	end
	RacialsSetting = v50(v47.Protection.RacialsSetting) and v49(v47.ProtTTD.RacialsTTD);
	Trinket1Setting = v50(v47.Protection.Trinket1Setting, v47.Protection.TrinketHP);
	Trinket2Setting = v50(v47.Protection.Trinket2Setting, v47.Protection.TrinketHP);
	PotionSetting = v50(v47.Protection.PotionSetting) and not v45.ISSolo();
	DivineTollSetting = v50(v47.Protection.DivineTollSetting) and v49(v47.ProtTTD.DivineTollTTD) and v7:IsInRange(101 - 71);
	AvengingWrathSetting = v50(v47.Protection.AvengingWrathSetting) and v49(v47.ProtTTD.AvengingWrathTTD);
	EyeOfTyrSetting = v50(v47.Protection.EyeOfTyrSetting) and v49(747 - (16 + 716));
	if (v45.TargetIsValid() or v6:AffectingCombat()) then
		v25 = v6:ActiveMitigationNeeded();
		v26 = v6:IsTankingAoE(15 - 7) or v6:IsTanking(v7);
		v32 = v3.BossFightRemains();
		v31 = true;
		v33 = v32;
		if (v33 == (11208 - (11 + 86))) then
			v31 = false;
			v33 = v3.FightRemains(v27, false);
		end
	end
	if (v20.DevotionAura:IsCastable() and v6:BuffDown(v20.DevotionAura, true) and (v58())) then
		if v15(v20.DevotionAura) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\198\132\0\241\45\231\87\204\190\23\235\43\239\24\210\147\19\253\54\227\90\195\149\86\172", "\56\162\225\118\158\89\142");
		end
	end
	if v20.RiteofSanctification:IsCastable() then
		if v12.Cast(v20.RiteofSanctification) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\78\12\212\170\29\215\90\58\211\174\44\219\72\12\198\166\33\217\72\12\207\161\98\200\78\0\195\160\47\218\93\17\128\253", "\184\60\101\160\207\66");
		end
	end
	if v20.RiteofAdjuration:IsCastable() then
		if v12.CastLeft(v20.RiteofAdjuration) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\35\139\104\185\14\141\122\131\48\134\118\169\35\131\104\181\62\140\60\172\35\135\127\179\60\128\125\168\113\214", "\220\81\226\28");
		end
	end
	if v45.TargetIsValid() then
		if (not v6:AffectingCombat() and v47.Protection.AttackOutOfCombat) then
			v38 = v60();
			if v38 then
				return v38;
			end
		end
		if (v20.CleanseToxins:IsReady() and v47.Protection.UseCleanse and DispelToggle) then
			v38 = v45.DispelCycle(v20.CleanseToxins, LUAOBFUSACTOR_DECRYPT_STR_0("\35\218\139\232\229\201", "\167\115\181\226\155\138"));
			if v38 then
				return v38;
			end
			v38 = v45.DispelCycle(v20.CleanseToxins, LUAOBFUSACTOR_DECRYPT_STR_0("\198\43\244\89\122\98\195", "\166\130\66\135\60\27\17"));
			if v38 then
				return v38;
			end
			v38 = v45.AfflictedLogic(v20.CleanseToxins);
			if v38 then
				return v38;
			end
			if v38 then
				return v38;
			end
		end
		if (v20.BlessingofFreedom:IsReady() and v47.Protection.UseFreedom) then
			if UnitForFreezingBinds then
				if UnitForFreezingBinds:Cast(v20.BlessingofFreedom) then
					return LUAOBFUSACTOR_DECRYPT_STR_0("\102\70\203\102\35\77\68\201\53\63\66\10\232\103\53\65\78\193\120\112\98\88\193\111\53\74\10\236\124\62\64\89", "\80\36\42\174\21");
				end
			end
			if (v6:DebuffElapsed(v20.EntangledDebuff) > (4 - 2)) then
				if v6:Cast(v20.BlessingofFreedom) then
					return LUAOBFUSACTOR_DECRYPT_STR_0("\108\28\50\105\93\25\57\125\14\31\49\58\104\2\50\127\74\31\58\58\75\30\35\123\64\23\59\115\64\23", "\26\46\112\87");
				end
			end
			v38 = v45.DispelCycle(v20.BlessingofFreedom, LUAOBFUSACTOR_DECRYPT_STR_0("\139\44\164\96\155\182\86\164\188\47", "\212\217\67\203\20\223\223\37"), nil, v34);
			if v38 then
				return v38;
			end
			v38 = v45.DispelCycle(v20.BlessingofFreedom, LUAOBFUSACTOR_DECRYPT_STR_0("\137\131\169\192\191\191\167\221\174", "\178\218\237\200"), nil, v34);
			if v38 then
				return v38;
			end
			v38 = v45.DispelCycle(v20.BlessingofFreedom, LUAOBFUSACTOR_DECRYPT_STR_0("\144\167\227\213\178\186\235\244\191\166\246\213\186", "\176\214\213\134"), nil, v34);
			if v38 then
				return v38;
			end
		end
		if InterruptToggle then
			v38 = v45.InterruptCycle(v20.Rebuke, 290 - (175 + 110), true, nil, false);
			if v38 then
				return v38;
			end
			v38 = not v6:IsMoving() and v45.InterruptCycle(v20.HammerofJustice, 25 - 15, false, nil, true);
			if v38 then
				return v38;
			end
			v38 = not v6:IsMoving() and v45.InterruptCycle(v20.BlindingLight, 49 - 39, false, nil, true, true);
			if v38 then
				return v38;
			end
		end
		if (v7:AffectingCombat() or v47.Protection.AttackOutOfCombat) then
			if v26 then
				v38 = v61();
				if v38 then
					return v38;
				end
			end
			if (v6:AffectingCombat() and v6:IsInParty() and not v6:IsInRaid()) then
				v38 = v62();
				if v38 then
					return v38;
				end
			end
			if (v20.Consecration:IsCastable() and v52() and v7:IsInMeleeRange(1801 - (503 + 1293)) and ((v3.CombatTime() < (13 - 8)) or v47.ProtectionDefensives.MostDefensive) and (v6:BuffDown(v20.ConsecrationBuff) or (v6:BuffStack(v20.DivineGuidanceBuff) >= (4 + 1)))) then
				if v15(v20.Consecration) then
					return LUAOBFUSACTOR_DECRYPT_STR_0("\247\162\184\199\173\85\75\245\185\191\219\166\22\93\241\171\179\218\187\95\79\241", "\57\148\205\214\180\200\54");
				end
			end
			if (v20.BlessedHammer:IsCastable() and v7:IsInMeleeRange(1071 - (810 + 251)) and (v3.CombatTime() < (4 + 1)) and (v20.BlessedHammer:TimeSinceLastCast() > (2 + 3)) and v47.ProtectionDefensives.MostDefensive) then
				if v15(v20.BlessedHammer) then
					return LUAOBFUSACTOR_DECRYPT_STR_0("\16\241\48\39\101\23\249\10\60\119\31\240\48\38\54\22\248\51\49\120\1\244\35\49", "\22\114\157\85\84");
				end
			end
			if (v20.ShieldoftheRighteous:IsReady() and v7:IsInMeleeRange(10 + 0) and v47.ProtectionDefensives.MostDefensive and v6:BuffDown(v20.ShieldoftheRighteousBuff)) then
				if v15(v20.ShieldoftheRighteous, true) then
					return LUAOBFUSACTOR_DECRYPT_STR_0("\215\195\26\193\81\242\151\203\205\44\208\85\243\151\214\194\20\204\73\243\167\209\216\83\192\88\240\173\202\216\26\210\88", "\200\164\171\115\164\61\150");
				end
			end
			v38 = v63();
			if v38 then
				return v38;
			end
			if (v47.Commons.Enabled.Trinkets or v47.Commons.Enabled.Items) then
				v38 = v65();
				if v38 then
					return v38;
				end
			end
			v38 = v64();
			if v38 then
				return v38;
			end
		end
		v38 = (v29 > (533 - (43 + 490))) and not v7:IsInRange(741 - (711 + 22)) and v48();
		if v38 then
			return v38;
		end
	end
end
local function v67()
	v47.Protection.Display();
	v12.ResetToggle();
	v12.ToggleIconFrame:AddButtonCustom("S", 3 - 2, LUAOBFUSACTOR_DECRYPT_STR_0("\141\249\2\73\143\254\215\39\86", "\227\222\148\99\37"), LUAOBFUSACTOR_DECRYPT_STR_0("\32\95\83\250\245\48\86\65", "\153\83\50\50\150"));
	v12.ToggleIconFrame:AddButtonCustom("T", 861 - (240 + 619), LUAOBFUSACTOR_DECRYPT_STR_0("\105\119\113", "\45\61\22\19\124\19\203"), LUAOBFUSACTOR_DECRYPT_STR_0("\213\19\15", "\217\161\114\109\149\98\16"));
	v12.ToggleIconFrame:AddButtonCustom("I", 1 + 2, LUAOBFUSACTOR_DECRYPT_STR_0("\59\46\44\121\174\102\7\48\44", "\20\114\64\88\28\220"), LUAOBFUSACTOR_DECRYPT_STR_0("\56\15\198\177\234\194\168\33\21", "\221\81\97\178\212\152\176"));
	v12.ToggleIconFrame:AddButtonCustom("D", 5 - 1, LUAOBFUSACTOR_DECRYPT_STR_0("\233\238\14\235\31\193", "\122\173\135\125\155"), LUAOBFUSACTOR_DECRYPT_STR_0("\128\200\19\169\58\61", "\168\228\161\96\217\95\81"));
	v45.PostInitialMessage(5 + 61);
end
v12.SetAPL(1810 - (1344 + 400), v66, v67);
