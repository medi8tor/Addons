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
local v7 = v5.Pet;
local v8 = v5.Target;
local v9 = v3.Spell;
local v10 = v3.MultiSpell;
local v11 = v3.Item;
local v12 = v5.MouseOver;
local v13 = HeroRotation();
local v14 = v13.AoEON;
local v15 = v13.CDsON;
local v16 = v13.Cast;
local v17 = v13.Commons().Everyone.num;
local v18 = v13.Commons().Everyone.bool;
local v19;
local v20 = math.max;
local v21 = C_Timer.After;
local v22 = v9.Druid.Balance;
local v23 = v11.Druid.Balance;
local v24 = {v23.AberrantSpellforge:ID(),v23.ImperfectAscendancySerum:ID(),v23.NeuralSynapseEnhancer:ID(),v23.SoullettingRuby:ID(),v23.SpymastersWeb:ID(),v23.TreacherousTransmitter:ID(),v23.BestinSlotsCaster:ID()};
local v25 = v13.Commons().Everyone;
local v26 = v13.Commons().Druid;
local v27 = v13.GUISettingsGet();
local v28 = {[LUAOBFUSACTOR_DECRYPT_STR_0("\246\198\213\32\244\186\203", "\126\177\163\187\69\134\219\167")]=v27.General,[LUAOBFUSACTOR_DECRYPT_STR_0("\0\194\39\200\243\45\222", "\156\67\173\74\165")]=v27.APL.Druid.Commons,[LUAOBFUSACTOR_DECRYPT_STR_0("\22\182\69\23\178\37\67", "\38\84\215\41\118\220\70")]=v27.APL.Druid.Balance,[LUAOBFUSACTOR_DECRYPT_STR_0("\114\23\46\19\240\83\19\29\54\251\86\19\44\1\247\70\19\49", "\158\48\118\66\114")]=v27.APL.Druid.Balance.Defensives,[LUAOBFUSACTOR_DECRYPT_STR_0("\137\37\28\55\125\166\254\148\16\36\18", "\155\203\68\112\86\19\197")]=v27.APL.Druid.Balance_TTD,[LUAOBFUSACTOR_DECRYPT_STR_0("\100\220\58\253\78\123\224\199\101\249\3\207\101", "\152\38\189\86\156\32\24\133")]=v27.APL.Druid.Balance_CDUSE};
local v29;
local v30;
local v31;
local v32;
local v33;
local v34, v35;
local v36, v37;
local v38;
local v39;
local v40;
local v41 = (v22.IncarnationTalent:IsAvailable() and v22.Incarnation) or v22.CelestialAlignment;
local v42 = (v22.OrbitalStrike:IsAvailable() and (39 + 81)) or (2078 - (260 + 1638));
local v43 = (v22.AstralInfluence:IsAvailable() and (485 - (382 + 58))) or (128 - 88);
local v44, v45;
local v46 = 9233 + 1878;
local v47 = 22962 - 11851;
local v48;
local v49, v50;
local v51, v52;
local v53, v54;
local v55, v56;
local v57, v58;
local v59, v60;
local v61, v62;
local v63, v64;
local v65, v66;
local v67;
local v68 = 0 - 0;
local function v69()
	local v95, v96 = v6:GetTrinketData(v24);
	if ((v68 < (1210 - (902 + 303))) and ((v95.ID == (0 - 0)) or (v96.ID == (0 - 0)) or (v95.Level == (0 + 0)) or (v96.Level == (1690 - (1121 + 569))) or ((v95.SpellID > (214 - (22 + 192))) and not v95.Usable) or ((v96.SpellID > (683 - (483 + 200))) and not v96.Usable))) then
		v68 = v68 + (1464 - (1404 + 59));
		v21(13 - 8, function()
			v69();
		end);
		return;
	end
	v49 = v95.Object;
	v50 = v96.Object;
	v51 = v95.ID;
	v52 = v96.ID;
	v53 = v95.Level;
	v54 = v96.Level;
	v55 = v95.Spell;
	v57 = v95.Range;
	v61 = v95.CastTime;
	v56 = v96.Spell;
	v58 = v96.Range;
	v62 = v96.CastTime;
	v63 = v95.Cooldown;
	v64 = v96.Cooldown;
	v65 = v95.Blacklisted;
	v66 = v96.Blacklisted;
	v59 = (v51 == v23.SpymastersWeb:ID()) or (v51 == v23.ImperfectAscendancySerum) or (v51 == v23.TreacherousTransmitter) or (v51 == v23.AberrantSpellforge);
	v60 = (v52 == v23.SpymastersWeb:ID()) or (v52 == v23.ImperfectAscendancySerum) or (v52 == v23.TreacherousTransmitter) or (v51 == v23.AberrantSpellforge);
	local v113 = v17(v49:HasUseBuff() and (v51 ~= v23.OvinaxsMercurialEgg:ID()));
	local v114 = v17(v50:HasUseBuff() and (v52 ~= v23.OvinaxsMercurialEgg:ID())) * (2 - 0);
	v67 = (765 - (468 + 297)) + v113 + v114;
end
v69();
v3:RegisterForEvent(function()
	v69();
end, LUAOBFUSACTOR_DECRYPT_STR_0("\204\123\134\127\217\101\152\99\205\98\142\118\209\114\137\114\195\116\143\103\210\112\130\98", "\38\156\55\199"));
v3:RegisterForEvent(function()
	v46 = 11673 - (334 + 228);
	v47 = 37477 - 26366;
end, LUAOBFUSACTOR_DECRYPT_STR_0("\152\81\93\17\54\70\197\113\141\90\89\6\44\81\212\98\138\81\89\12", "\35\200\29\28\72\115\20\154"));
v3:RegisterForEvent(function()
	v41 = (v22.IncarnationTalent:IsAvailable() and v22.Incarnation) or v22.CelestialAlignment;
	v42 = (v22.OrbitalStrike:IsAvailable() and (278 - 158)) or (v22.WhirlingStars:IsAvailable() and (145 - 65)) or (52 + 128);
	ConvokeCD = (v22.ElunesGuidance:IsAvailable() and (296 - (141 + 95))) or (118 + 2);
	v43 = (v22.AstralInfluence:IsAvailable() and (115 - 70)) or (96 - 56);
end, LUAOBFUSACTOR_DECRYPT_STR_0("\42\143\244\243\161\31\11\58\151\240\241\170\9\16", "\84\121\223\177\191\237\76"), LUAOBFUSACTOR_DECRYPT_STR_0("\151\115\232\146\20\117\20\254\136\102\236\140\22\111\25\239\132\98\232\130", "\161\219\54\169\192\90\48\80"));
local function v70(v115)
	local v116 = 0 + 0;
	if (v115 == v22.Wrath) then
		v116 = 21 - 13;
		if v22.WildSurges:IsAvailable() then
			v116 = v116 + 2 + 0;
		end
		if (v22.SouloftheForest:IsAvailable() and v6:BuffUp(v22.EclipseSolar)) then
			v116 = v116 * (1.6 + 0);
		end
	elseif (v115 == v22.Starfire) then
		v116 = 14 - 4;
		if v22.WildSurges:IsAvailable() then
			v116 = v116 + 2 + 0;
		end
		if v6:BuffUp(v22.WarriorofEluneBuff) then
			v116 = v116 * (164.4 - (92 + 71));
		end
		if (v22.SouloftheForest:IsAvailable() and v6:BuffUp(v22.EclipseLunar)) then
			local v142 = 1 + 0 + ((0.2 - 0) * v45);
			if (v142 > (766.6 - (574 + 191))) then
				v142 = 1.6 + 0;
			end
			v116 = v116 * v142;
		end
	elseif (v115 == v22.Moonfire) then
		v116 = 14 - 8;
		if v22.MoonGuardian:IsAvailable() then
			v116 = v116 + 2 + 0;
		end
	elseif (v115 == v22.Sunfire) then
		v116 = 855 - (254 + 595);
	elseif (v115 == v22.NewMoon) then
		v116 = 136 - (55 + 71);
	elseif (v115 == v22.HalfMoon) then
		v116 = 26 - 6;
	elseif (v115 == v22.FullMoon) then
		v116 = 1830 - (573 + 1217);
	elseif (v115 == v22.ForceofNature) then
		v116 = 55 - 35;
	end
	return v116;
end
local function v71(v117)
	return v117:DebuffRefreshable(v22.MoonfireDebuff) and ((v117:TimeToDie() - v117:DebuffRemains(v22.MoonfireDebuff)) > (1 + 5)) and (not v22.TreantsoftheMoon:IsAvailable() or ((v45 - v22.MoonfireDebuff:AuraActiveCount()) > (9 - 3)) or ((v22.ForceofNature:CooldownRemains() > (942 - (714 + 225))) and v6:BuffDown(v22.HarmonyoftheGroveBuff)));
end
local function v72(v118)
	return (v118:DebuffRemains(v22.MoonfireDebuff) < (8 - 5)) and (not v22.TreantsoftheMoon:IsAvailable() or ((v22.ForceofNature:CooldownRemains() > (3 - 0)) and v6:BuffDown(v22.HarmonyoftheGroveBuff)));
end
local function v73(v119)
	return v119:DebuffRefreshable(v22.MoonfireDebuff) and (not v22.TreantsoftheMoon:IsAvailable() or ((v22.ForceofNature:CooldownRemains() > (1 + 2)) and v6:BuffDown(v22.HarmonyoftheGroveBuff)));
end
local function v74(v120)
	return v120:DebuffRefreshable(v22.StellarFlareDebuff) and ((v120:TimeToDie() - v120:DebuffRemains(v22.StellarFlareDebuff)) > ((10 - 3) + v45));
end
local function v75(v121)
	return v121:DebuffRefreshable(v22.StellarFlareDebuff) and ((v121:TimeToDie() - v121:DebuffRemains(v22.StellarFlareDebuff)) > ((813 - (118 + 688)) + v45));
end
local function v76(v122)
	return v122:DebuffRefreshable(v22.SunfireDebuff) and ((v122:TimeToDie() - v122:DebuffRemains(v22.SunfireDebuff)) > ((54 - (25 + 23)) - (v45 / (1 + 1))));
end
local function v77(v123)
	return (v123:DebuffRemains(v22.SunfireDebuff) < (1889 - (927 + 959))) or v123:DebuffRefreshable(v22.SunfireDebuff);
end
local function v78(v124)
	return v124:DebuffRefreshable(v22.SunfireDebuff);
end
local function v79(v125)
	return v125:NPCID() == (689550 - 484990);
end
local function v80(v126)
	return v126:CastSpellID() == (409537 - (16 + 716));
end
local function v81()
	return (v12:Exists() or not v28.Balance.CursorCheck) and not v6:IsCameraBusy();
end
local function v82()
	if v25.TargetIsValid() then
		local v137 = 77 - 37;
		local v138 = v6:GetEnemiesInRange(v137);
		local v139 = 97 - (11 + 86);
		for v140, v141 in ipairs(v138) do
			if v141:AffectingCombat() then
				v139 = v139 + (2 - 1);
			end
		end
		v139 = math.max(v139, 286 - (175 + 110));
		return v139;
	else
		return #(v6:GetEnemiesInRange(100 - 60));
	end
end
local function v83()
	return v6:ChannelSpellID() == (1931113 - 1539585);
end
local function v84(v127, v128)
	return (v127:gsub(LUAOBFUSACTOR_DECRYPT_STR_0("\82\10\78\104\0\95", "\69\41\34\96"), v128));
end
local v85;
local function v86(v129)
	return (v129 ~= LUAOBFUSACTOR_DECRYPT_STR_0("\146\204\195\74\55\56\185\199", "\75\220\163\183\106\98")) and ((((v129 == LUAOBFUSACTOR_DECRYPT_STR_0("\21\179\159\63\153\33\181\132\59\221\13\173\133\36", "\185\98\218\235\87")) or ((v129 == LUAOBFUSACTOR_DECRYPT_STR_0("\216\49\38\234\210\234\232\24\52", "\202\171\92\71\134\190")) and v28.Balance_CDUSE.smallcdswithCooldowns) or (v129 == LUAOBFUSACTOR_DECRYPT_STR_0("\62\200\56\128\105\226\35\135\37\197\35\159\39\210\108\135\59\129\13\135\12", "\232\73\161\76")) or (v129 == LUAOBFUSACTOR_DECRYPT_STR_0("\180\215\2\120\16\190\212\91\94\17\174\215\86\29\17\169\153\97\82\17\183\221\77\74\16\168", "\126\219\185\34\61")) or (v129 == LUAOBFUSACTOR_DECRYPT_STR_0("\3\192\30\80\113\100\224\167\3\220\30\101\119\99\251\167\47\193\81\126\122\120\228\233\31", "\135\108\174\62\18\30\23\147"))) and v15()) or (v129 == LUAOBFUSACTOR_DECRYPT_STR_0("\183\229\61\202\1\189", "\167\214\137\74\171\120\206\83")) or (((v129 == LUAOBFUSACTOR_DECRYPT_STR_0("\132\254\114\127\247\180\152\176\61\83\244\190", "\199\235\144\82\61\152")) or (v129 == LUAOBFUSACTOR_DECRYPT_STR_0("\8\24\249\9\8\5\170\107\8\4\249\36\9\86\156\37\2\27\160\40\8\3\183\63", "\75\103\118\217")) or (v129 == LUAOBFUSACTOR_DECRYPT_STR_0("\200\90\48\54\182\13\212\20\127\6\249\9\206\64\120\84\154\17\200\88\116\27\174\16\212", "\126\167\52\16\116\217"))) and (v85 or v8:IsDummy())) or ((v129 == LUAOBFUSACTOR_DECRYPT_STR_0("\223\39\52\136\244\59\240\199\33\36\140\161\10\232\136\33\46\140\173", "\156\168\78\64\224\212\121")) and v6:BloodlustUp()) or ((v129 == LUAOBFUSACTOR_DECRYPT_STR_0("\20\227\164\194\11\174\134\234\20", "\174\103\142\197")) and Smallcds) or (((v129 == LUAOBFUSACTOR_DECRYPT_STR_0("\89\38\31\25\10\123", "\152\54\72\63\88\69\62")) or (v129 == LUAOBFUSACTOR_DECRYPT_STR_0("\195\205\250\84\148\231\225\83\216\192\225\75\218\215\174\83\198\132\207\83\241", "\60\180\164\142"))) and (v45 >= (1798 - (503 + 1293)))) or (((v129 == LUAOBFUSACTOR_DECRYPT_STR_0("\87\80\69\12\41\232\31\65\93\10\60\41\249\82\87\76\69\10\40\226\30\92\81\18\39\52", "\114\56\62\101\73\71\141")) or (v129 == LUAOBFUSACTOR_DECRYPT_STR_0("\183\231\155\225\182\236\214\221\187\230\206\202\172", "\164\216\137\187")) or (v129 == LUAOBFUSACTOR_DECRYPT_STR_0("\221\232\113\144\169\237\24\146\233\35\242\169\240\75\247\232\52\191\191\253\4\199\232\37", "\107\178\134\81\210\198\158"))) and (v45 >= v28.Balance_CDUSE.Enemycount)));
end
local function v87(v130)
	return (v85 and v28.Balance_TTD.IgnoreWhenBoss) or v25.Buggedmobs[v8:NPCID()] or (v25.ISSolo() and v28.Balance_TTD.IgnoreWhenSolo) or (v130 == (0 - 0)) or ((v47 >= v130) and (v47 < (5625 + 2152)));
end
local function v88()
	if (v22.Regrowth:IsCastable() and not v6:IsMoving() and (v6:HealthPercentage() <= v28.Balance.Defensives.RegrowthHP)) then
		if v16(v22.Regrowth) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\42\11\133\212\165\47\26\138", "\202\88\110\226\166");
		end
	end
	if (v22.Regrowth:IsCastable() and (v6:HealthPercentage() <= v28.Balance.Defensives.RegrowthBloomingHP) and v6:BuffUp(v22.BloomingInfusionBuff)) then
		if v16(v22.Regrowth) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\209\10\133\229\197\212\27\138", "\170\163\111\226\151");
		end
	end
	if (v22.Renewal:IsCastable() and v6:AffectingCombat() and (v6:HealthPercentage() <= v28.Balance.Defensives.RenewalHP)) then
		if v16(v22.Renewal) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\3\53\188\61\89\54\37", "\73\113\80\210\88\46\87");
		end
	end
	if (v22.Barkskin:IsCastable() and v6:AffectingCombat() and (v6:HealthPercentage() <= v28.Balance.Defensives.BarkskinHP)) then
		if v16(v22.Barkskin) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\131\45\223\25\244\138\37\195", "\135\225\76\173\114");
		end
	end
	if (v22.NaturesVigil:IsCastable() and v6:AffectingCombat() and (v28.Balance.Defensives.NaturesVigilCount ~= (1061 - (810 + 251))) and (v28.Balance.Defensives.NaturesVigilHP ~= (0 + 0)) and v25.AoELogicWithCount(v28.Balance.Defensives.NaturesVigilHP, v28.Balance.Defensives.NaturesVigilCount, nil, v48)) then
		if v16(v22.NaturesVigil) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\52\236\172\165\190\184\180\44\228\191\185\160", "\199\122\141\216\208\204\221");
		end
	end
	if (v22.Swiftmend:IsCastable() and v6:AffectingCombat() and (v6:HealthPercentage() <= v28.Balance.Defensives.SwiftmendHP)) then
		if v16(v22.Swiftmend) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\158\202\25\246\108\251\168\211\20", "\150\205\189\112\144\24");
		end
	end
	if (v22.SurvivalInstincts:IsCastable() and v6:AffectingCombat() and (v6:HealthPercentage() <= v28.Balance.Defensives.SurvivalInstinctsHP)) then
		if v16(v22.SurvivalInstincts) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\22\145\173\90\13\158\16\28\12\138\172\88\13\134\18\4\54", "\112\69\228\223\44\100\232\113");
		end
	end
	if (v22.FrenziedRegeneration:IsCastable() and v6:BuffUp(v22.BearForm) and (v6:HealthPercentage() <= v28.Balance.Defensives.FrenziedRegenerationHP)) then
		if v16(v22.FrenziedRegeneration) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\242\13\2\221\172\117\131\208\45\2\212\179\114\131\198\30\19\218\185\114", "\230\180\127\103\179\214\28");
		end
	end
	if (v22.Ironfur:IsCastable() and v6:BuffUp(v22.BearForm) and v6:BuffDown(v22.Ironfur) and (v6:Rage() >= (13 + 27)) and (v6:HealthPercentage() <= v28.Balance.Defensives.IronfurHP)) then
		if v16(v22.Ironfur) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\165\23\80\72\226\84\242", "\128\236\101\63\38\132\33");
		end
	end
	if (v22.BearForm:IsCastable() and v6:AffectingCombat() and v6:BuffUp(v22.MoonkinForm) and (v6:HealthPercentage() <= v28.Balance.Defensives.BearFormHP)) then
		if v16(v22.BearForm) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\142\172\16\86\144\228\221\161", "\175\204\201\113\36\214\139");
		end
	end
	if (v22.MoonkinForm:IsCastable() and v6:BuffUp(v22.BearForm) and (v6:HealthPercentage() > v28.Balance.Defensives.MoonkinFormHP) and (v28.Balance.Defensives.MoonkinFormHP > (0 + 0))) then
		if v16(v22.MoonkinForm) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\106\195\58\210\15\78\194\19\211\22\74", "\100\39\172\85\188");
		end
	end
end
local function v89()
	if (v22.MoonkinForm:IsCastable() and v6:BuffDown(v22.TravelFormBuff) and v6:BuffDown(v22.BearForm) and v6:BuffDown(v22.CatForm)) then
		if v16(v22.MoonkinForm) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\160\119\182\142\56\164\118\134\134\60\191\117\249\144\33\168\123\182\141\49\172\108", "\83\205\24\217\224");
		end
	end
	if (v22.Wrath:IsCastable() and not v6:IsMoving() and not v6:IsCasting(v22.Wrath)) then
		if v16(v22.Wrath) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\241\215\204\41\238\133\221\47\227\198\194\48\228\196\217\125\180", "\93\134\165\173");
		end
	end
	if (v22.Wrath:IsCastable() and not v6:IsMoving() and ((v6:IsCasting(v22.Wrath) and (v22.Wrath:Count() == (535 - (43 + 490)))) or (v6:PrevGCD(734 - (711 + 22), v22.Wrath) and (v22.Wrath:Count() == (3 - 2))))) then
		if v16(v22.Wrath) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\169\224\192\214\50\142\162\108\187\241\206\207\56\207\166\62\234", "\30\222\146\161\162\90\174\210");
		end
	end
	if (v22.Starfire:IsCastable() and (not v6:IsMoving() or v6:BuffUp(v22.WarriorofEluneBuff)) and not v22.StellarFlare:IsAvailable() and (v6:HeroTreeID() == (883 - (240 + 619)))) then
		if v16(v22.Starfire) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\246\90\113\24\227\71\98\15\165\94\98\15\230\65\125\8\228\90\48\92", "\106\133\46\16");
		end
	end
end
local function v90()
	if (v15() and v22.Berserking:IsCastable() and v32) then
		if v16(v22.Berserking, true) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\90\37\97\239\95\82\83\41\125\251\26\80\74\37\76\255\94\0\12", "\32\56\64\19\156\58");
		end
	end
	if (v28.Commons.Enabled.Items and v23.BestinSlotsCaster:IsEquippedAndReady() and (((v6:HeroTreeID() == (6 + 17)) and v6:BuffUp(v22.HarmonyoftheGroveBuff)) or ((v6:HeroTreeID() == (37 - 13)) and ((CaInc:FullRechargeTime() > (2 + 18)) or v39)))) then
		v13.CastMacro(1745 - (1344 + 400), nil, nil, v23.BestinSlotsCaster);
		return LUAOBFUSACTOR_DECRYPT_STR_0("\79\219\224\105\83\230\133\87\219\165\66\72\251\142\81\205\241\4\26\186", "\224\58\168\133\54\58\146") .. v50:Name() .. LUAOBFUSACTOR_DECRYPT_STR_0("\16\22\91\239\112\185\132\15\25\7\27", "\107\57\54\43\157\21\230\231");
	end
end
local function v91()
	if (v22.WarriorofElune:IsCastable() and IsWarriorofElune and (v22.LunarCalling:IsAvailable() or (not v22.LunarCalling:IsAvailable() and (v35 <= (412 - (255 + 150)))))) then
		if v16(v22.WarriorofElune, true) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\204\138\3\231\176\211\221\228\132\23\202\188\208\218\213\142\81\230\173\156\157", "\175\187\235\113\149\217\188");
		end
	end
	if (v22.Wrath:IsCastable() and v43 and v36 and v34 and (v35 < v22.Wrath:CastTime()) and not v32) then
		if v16(v22.Wrath) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\43\189\128\88\235\57\107\40\239\213", "\24\92\207\225\44\131\25");
		end
	end
	if (v22.Starfire:IsCastable() and v43 and not v36 and v34 and (v35 < v22.Starfire:CastTime()) and not v32) then
		if v16(v22.Starfire) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\88\199\185\94\29\116\89\214\248\95\15\61\29", "\29\43\179\216\44\123");
		end
	end
	if v22.Sunfire:IsCastable() then
		if v25.CastCycle(v22.Sunfire, v44, v77, v43) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\174\204\46\74\180\203\37\12\174\205\96\30", "\44\221\185\64");
		end
	end
	if (v22.Moonfire:IsCastable() and (not v22.ForceofNature:IsAvailable() or (v22.ForceofNature:CooldownRemains() > (4 + 1)) or not IsForceofNature or not v22.TreantsoftheMoon:IsAvailable())) then
		if v25.CastCycle(v22.Moonfire, v44, v72, v43) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\12\232\71\81\117\8\245\77\31\96\21\167\28", "\19\97\135\40\63");
		end
	end
	local v131 = v90();
	if v131 then
		return v131;
	end
	if (v15() and v32) then
		if (v22.CelestialAlignment:IsCastable() and IsIncarnation) then
			if v16(v22.CelestialAlignmentcast, true) then
				return LUAOBFUSACTOR_DECRYPT_STR_0("\173\89\63\62\60\37\167\93\63\4\46\61\167\91\61\54\42\63\186\28\32\47\111\103", "\81\206\60\83\91\79");
			end
		end
		if (v22.Incarnation:IsCastable() and IsIncarnation) then
			if v16(v22.Incarnationcast, true) then
				return LUAOBFUSACTOR_DECRYPT_STR_0("\77\174\220\119\60\215\68\165\66\148\209\126\38\196\67\169\75\165\196\50\60\215\13\252", "\196\46\203\176\18\79\163\45");
			end
		end
	end
	if (v22.Wrath:IsCastable() and v43 and v36 and (not v34 or (v35 < v22.Wrath:CastTime()))) then
		if v16(v22.Wrath) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\175\48\127\10\44\187\252\172\98\47\72", "\143\216\66\30\126\68\155");
		end
	end
	if (v22.Starfire:IsCastable() and v43 and not v36 and (not v34 or (v35 < v22.Starfire:CastTime()))) then
		if v16(v22.Starfire, nil, nil, RangeformagicSpells) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\185\220\12\217\195\170\197\228\234\219\25\139\148\251", "\129\202\168\109\171\165\195\183");
		end
	end
	if (v22.Starsurge:IsReady() and v43 and v32 and (v6:AstralPowerDeficit() > (v29 + v70(v22.ForceofNature)))) then
		if v16(v22.Starsurge) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\49\76\54\202\205\1\244\37\93\119\203\202\84\180\114", "\134\66\56\87\184\190\116");
		end
	end
	if (v22.ForceofNature:IsCastable() and IsForceofNature and (((v41:CooldownRemains() < v6:GCD()) and (not v22.ConvoketheSpirits:IsAvailable() or (v22.ConvoketheSpirits:CooldownRemains() < (v6:GCD() * (2 + 1))) or (v22.ConvoketheSpirits:CooldownRemains() > v41:FullRechargeTime()) or (v47 < (v22.ConvoketheSpirits:CooldownRemains() + (12 - 9))))) or (((v41:FullRechargeTime() + (16 - 11) + ((1754 - (404 + 1335)) * v17(v22.ControloftheDream:IsAvailable()))) > (466 - (183 + 223))) and (not v22.ConvoketheSpirits:IsAvailable() or ((v22.ConvoketheSpirits:CooldownRemains() + (12 - 2) + ((10 + 5) * v17(v22.ControloftheDream:IsAvailable()))) > (22 + 38)) or (v47 < (v22.ConvoketheSpirits:CooldownRemains() + ConvokeCD + (342 - (10 + 327))))) and ((v47 > (46 + 19)) or (v47 < (v41:CooldownRemains() + (345 - (118 + 220)))))) or (v22.WhirlingStars:IsAvailable() and v22.ConvoketheSpirits:IsAvailable() and (v22.ConvoketheSpirits:CooldownRemains() > (17 + 33)) and (v47 > (v22.ConvoketheSpirits:CooldownRemains() + (455 - (108 + 341))))))) then
		if v16(v22.ForceofNature, true) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\58\62\27\184\28\212\46\51\3\63\8\175\12\249\36\117\47\37\73\233\75", "\85\92\81\105\219\121\139\65");
		end
	end
	if (v22.FuryofElune:IsCastable() and IsFuryofElune and ((3 + 2 + v29) < v6:AstralPowerDeficit())) then
		if v16(v22.FuryofElune, true) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\251\166\66\92\67\208\251\140\85\73\105\209\248\243\67\81\60\142\175", "\191\157\211\48\37\28");
		end
	end
	if (v22.Starfall:IsReady() and (v6:BuffUp(v22.StarweaversWarp))) then
		if v16(v22.Starfall, true, nil, RangeformagicSpells) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\204\11\245\14\60\222\19\248\92\41\203\95\166\74", "\90\191\127\148\124");
		end
	end
	if (v22.Starsurge:IsReady() and UseSpender and v22.Starlord:IsAvailable() and (v6:BuffStack(v22.StarlordBuff) < (12 - 9))) then
		if v16(v22.Starsurge) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\107\147\47\5\107\146\60\16\125\199\61\3\56\214\122", "\119\24\231\78");
		end
	end
	if v22.Sunfire:IsCastable() then
		if v25.CastCycle(v22.Sunfire, v44, v78, v43) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\145\56\171\76\213\82\20\194\62\177\10\143\16", "\113\226\77\197\42\188\32");
		end
	end
	if v22.Moonfire:IsCastable() then
		if v25.CastCycle(v22.Moonfire, v44, v73, v43) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\55\25\251\187\60\31\230\176\122\5\224\245\105\68", "\213\90\118\148");
		end
	end
	if v22.StellarFlare:IsCastable() then
		if v25.CastCycle(v22.StellarFlare, v44, v75, v43) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\72\58\177\90\65\90\60\139\80\65\90\60\177\22\94\79\110\231\2", "\45\59\78\212\54");
		end
	end
	if (v22.Starsurge:IsReady() and UseSpender and (v22.ConvoketheSpirits:CooldownRemains() < (v6:GCD() * (1495 - (711 + 782)))) and v38) then
		if v16(v22.Starsurge) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\3\66\130\153\149\59\191\247\21\22\144\159\198\124\255", "\144\112\54\227\235\230\78\205");
		end
	end
	if (v22.ConvoketheSpirits:IsCastable() and IsConvoketheSpirits and v38) then
		if v16(v22.ConvoketheSpirits) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\176\39\1\234\223\80\182\23\27\244\213\100\160\56\6\238\217\79\160\104\28\232\144\9\231", "\59\211\72\111\156\176");
		end
	end
	if (v22.Starsurge:IsReady() and UseSpender and (((v6:BuffRemains(v22.StarlordBuff) > (7 - 3)) and (v37 >= (472 - (270 + 199)))) or (v46 < (2 + 2)))) then
		if v16(v22.Starsurge) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\93\147\226\63\93\146\241\42\75\199\240\57\14\213\181", "\77\46\231\131");
		end
	end
	if (v22.NewMoon:IsCastable() and not v6:IsMoving() and ((v6:AstralPowerDeficit() > (v29 + v70(v22.NewMoon))) or (v46 < (1839 - (580 + 1239))) or (v41:CooldownRemains() > (44 - 29)))) then
		if v16(v22.NewMoon) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\180\81\161\127\183\91\185\78\250\71\162\0\232\12", "\32\218\52\214");
		end
	end
	if (v22.HalfMoon:IsCastable() and not v6:IsMoving() and (((v6:AstralPowerDeficit() > (v29 + v70(v22.HalfMoon))) and ((v6:BuffRemains(v22.EclipseLunar) > v22.HalfMoon:ExecuteTime()) or (v6:BuffRemains(v22.EclipseSolar) > v22.HalfMoon:ExecuteTime()))) or (v46 < (20 + 0)) or (v41:CooldownRemains() > (1 + 14)))) then
		if v16(v22.HalfMoon) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\70\22\61\174\206\189\74\85\64\87\34\188\177\227\21", "\58\46\119\81\200\145\208\37");
		end
	end
	if (v22.FullMoon:IsCastable() and not v6:IsMoving() and (((v6:AstralPowerDeficit() > (v29 + v70(v22.FullMoon))) and ((v6:BuffRemains(v22.EclipseLunar) > v22.FullMoon:ExecuteTime()) or (v6:BuffRemains(v22.EclipseSolar) > v22.FullMoon:ExecuteTime()))) or (v46 < (9 + 11)) or (v41:CooldownRemains() > (39 - 24)))) then
		if v16(v22.FullMoon) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\45\153\60\160\150\176\57\36\130\112\191\189\253\101\121", "\86\75\236\80\204\201\221");
		end
	end
	if (v22.Starsurge:IsReady() and UseSpender and (v6:BuffUp(v22.StarweaversWeft) or v6:BuffUp(v22.TouchtheCosmosStarsurge))) then
		if v16(v22.Starsurge) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\97\85\118\151\237\158\96\70\114\197\237\159\50\18\35", "\235\18\33\23\229\158");
		end
	end
	if (v22.Starsurge:IsReady() and UseSpender and (v6:AstralPowerDeficit() < (v29 + v70(v22.Wrath) + ((v70(v22.Starfire) + v29) * (v17(v6:BuffRemains(v22.EclipseSolar) < (v6:GCD() * (2 + 1)))))))) then
		if v16(v22.Starsurge) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\67\174\192\169\67\175\211\188\85\250\210\175\16\233\153", "\219\48\218\161");
		end
	end
	if (v22.ForceofNature:IsCastable() and IsForceofNature and (v6:HeroTreeID() ~= (1190 - (645 + 522)))) then
		if v16(v22.ForceofNature, true) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\226\126\110\74\222\112\239\226\78\114\72\207\90\242\225\49\111\93\155\27\176", "\128\132\17\28\41\187\47");
		end
	end
	if (v22.WildMushroom:IsCastable() and IsWildMushroom and not v6:PrevGCD(1791 - (1010 + 780), v22.WildMushroom) and (v8:DebuffRemains(v22.FungalGrowthDebuff) < (2 + 0))) then
		if v16(v22.WildMushroom, true) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\22\59\10\62\98\12\39\21\50\79\14\61\11\122\78\21\114\83\110", "\61\97\82\102\90");
		end
	end
	if (v22.Starfire:IsCastable() and (not v6:IsMoving() or v6:BuffUp(v22.WarriorofEluneBuff)) and (v22.LunarCalling:IsAvailable())) then
		if v16(v22.Starfire) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\191\58\170\89\193\94\12\12\236\61\191\11\147\5", "\105\204\78\203\43\167\55\126");
		end
	end
	if (v22.Wrath:IsCastable() and not v6:IsMoving()) then
		if v16(v22.Wrath) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\178\184\34\10\27\68\212\69\229\254\119", "\49\197\202\67\126\115\100\167");
		end
	end
	if (v6:IsMoving() and v28.Balance.SpamDot) then
		if (v22.Sunfire:IsCastable() and (v45 > (4 - 3))) then
			if v16(v22.Sunfire) then
				return LUAOBFUSACTOR_DECRYPT_STR_0("\36\78\209\47\137\68\91\119\86\208\63\137\88\89", "\62\87\59\191\73\224\54");
			end
		end
		if v22.Moonfire:IsCastable() then
			if v16(v22.Moonfire) then
				return LUAOBFUSACTOR_DECRYPT_STR_0("\234\13\245\199\225\11\232\204\167\15\245\223\238\12\253", "\169\135\98\154");
			end
		end
	end
end
local function v92()
	local v132 = v6:IsInDungeonArea();
	if (v22.Wrath:IsCastable() and v43 and v36 and v34 and (v35 < v22.Wrath:CastTime())) then
		if v16(v22.Wrath) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\220\101\37\64\245\115\201\196\114\100\6", "\168\171\23\68\52\157\83");
		end
	end
	if (v22.Starfire:IsCastable() and v43 and not v36 and v34 and (v35 < v22.Starfire:CastTime())) then
		if v16(v22.Starfire) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\231\101\244\191\35\36\149\241\49\244\162\32\109\211", "\231\148\17\149\205\69\77");
		end
	end
	if (v22.Starfall:IsReady() and v43 and (v6:AstralPowerDeficit() <= (v29 + (17 - 11)))) then
		if v16(v22.Starfall, true) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\147\179\198\233\81\254\140\171\135\250\88\250\192\241", "\159\224\199\167\155\55");
		end
	end
	if (v22.Moonfire:IsCastable() and v132) then
		if v25.CastCycle(v22.Moonfire, v44, v71, v43) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\250\252\51\220\241\250\46\215\183\242\51\215\183\161", "\178\151\147\92");
		end
	end
	if v22.Sunfire:IsCastable() then
		if v25.CastCycle(v22.Sunfire, v44, v76, v43) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\159\232\66\52\27\94\127\204\252\67\55\82\24", "\26\236\157\44\82\114\44");
		end
	end
	if (v22.Moonfire:IsCastable() and not v132) then
		if v25.CastCycle(v22.Moonfire, v44, v71, v43) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\39\33\218\85\44\39\199\94\106\47\218\94\106\120", "\59\74\78\181");
		end
	end
	if (v22.Wrath:IsCastable() and v43 and v36 and (not v34 or (v35 < v22.Wrath:CastTime()))) then
		if v16(v22.Wrath) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\50\195\91\78\187\101\208\85\95\243\116\133", "\211\69\177\58\58");
		end
	end
	if (v22.Starfire:IsCastable() and v43 and not v36 and (not v34 or (v35 < v22.Starfire:CastTime()))) then
		if v16(v22.Starfire) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\164\241\120\231\239\194\165\224\57\244\230\206\247\180\47", "\171\215\133\25\149\137");
		end
	end
	if (v22.StellarFlare:IsCastable() and (v45 < ((((1847 - (1045 + 791)) - v22.UmbralIntensity:TalentRank()) - ((4 - 2) * v17(v22.AstralSmolder:IsAvailable()))) - v17(v22.LunarCalling:IsAvailable())))) then
		if v25.CastCycle(v22.StellarFlare, v44, v74, v43) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\242\220\55\246\227\49\238\125\231\196\51\232\234\112\253\77\228\136\106", "\34\129\168\82\154\143\80\156");
		end
	end
	if (v22.ForceofNature:IsCastable() and (((v41:CooldownRemains() < v6:GCD()) and (not v34 or (v35 > (8 - 2)))) or ((v35 >= (508 - (351 + 154))) and (v41:CooldownRemains() > ((1584 - (1281 + 293)) + ((281 - (28 + 238)) * v17(v22.ControloftheDream:IsAvailable())))) and ((v47 > (144 - 79)) or (v41:CooldownRemains() > v47))))) then
		if v16(v22.ForceofNature, true) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\131\189\33\8\77\113\134\131\141\61\10\92\91\155\128\242\50\4\77\14\216\213", "\233\229\210\83\107\40\46");
		end
	end
	if (v22.FuryofElune:IsCastable() and IsFuryofElune and v34) then
		if v16(v22.FuryofElune, true) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\199\87\32\207\58\206\68\13\211\9\212\76\55\150\4\206\71\114\135\87", "\101\161\34\82\182");
		end
	end
	local v133 = v90();
	if v133 then
		return v133;
	end
	if (v15() and v32) then
		if (v22.CelestialAlignment:IsCastable() and IsIncarnation) then
			if v16(v22.CelestialAlignmentcast, true) then
				return LUAOBFUSACTOR_DECRYPT_STR_0("\235\8\85\251\200\246\139\47\228\50\88\242\210\229\140\35\237\3\77\190\218\237\135\110\185\89", "\78\136\109\57\158\187\130\226");
			end
		end
		if (v22.Incarnation:IsCastable() and IsIncarnation) then
			if v16(v22.Incarnationcast, true) then
				return LUAOBFUSACTOR_DECRYPT_STR_0("\61\58\245\244\45\43\240\240\50\0\248\253\55\56\247\252\59\49\237\177\63\48\252\177\111\105", "\145\94\95\153");
			end
		end
	end
	if (v22.WarriorofElune:IsCastable() and IsWarriorofElune and ((not v22.LunarCalling:IsAvailable() and (v6:BuffRemains(v22.EclipseSolar) < (1566 - (1381 + 178)))) or v22.LunarCalling:IsAvailable())) then
		if v16(v22.WarriorofElune, true) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\234\204\6\199\71\184\239\242\27\211\113\178\241\216\26\208\14\182\242\200\84\132\22", "\215\157\173\116\181\46");
		end
	end
	if (v22.Starfire:IsCastable() and (not v6:IsMoving() or v6:BuffUp(v22.WarriorofEluneBuff)) and not v22.LunarCalling:IsAvailable() and (v45 == (1 + 0)) and ((v6:BuffUp(v22.EclipseSolar) and (v6:BuffRemains(v22.EclipseSolar) < v22.Starfire:CastTime())) or not v34)) then
		if v16(v22.Starfire) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\38\160\138\224\220\60\166\142\178\219\58\177\203\160\138", "\186\85\212\235\146");
		end
	end
	if (v22.Starfall:IsReady() and UseSpender and (v6:BuffUp(v22.StarweaversWarp) or v6:BuffUp(v22.TouchtheCosmosStarfall))) then
		if v16(v22.Starfall) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\209\149\23\236\63\239\84\206\193\23\241\60\174\10\144", "\56\162\225\118\158\89\142");
		end
	end
	if (v22.Starsurge:IsReady() and UseSpender and (v6:BuffUp(v22.StarweaversWeft) or v6:BuffUp(v22.TouchtheCosmosStarsurge))) then
		if v16(v22.Starsurge) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\79\17\193\189\49\205\78\2\197\239\35\215\89\69\146\251", "\184\60\101\160\207\66");
		end
	end
	if (v22.Starfall:IsReady() and UseSpender) then
		if v16(v22.Starfall) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\34\150\125\174\55\131\112\176\113\131\115\185\113\208\42", "\220\81\226\28");
		end
	end
	if (v22.ConvoketheSpirits:IsCastable() and IsConvoketheSpirits and ((v6:BuffDown(v22.DreamstateBuff) and v6:BuffDown(v22.UmbralEmbraceBuff) and (v45 < (6 + 1))) or (v45 == (1 + 0))) and ((v46 < (17 - 12)) or ((v39 or (v41:CooldownRemains() > (21 + 19))) and ((v6:HeroTreeID() ~= (504 - (381 + 89))) or v6:BuffUp(v22.HarmonyoftheGroveBuff) or (v22.ForceofNature:CooldownRemains() > (14 + 1)))))) then
		if v16(v22.ConvoketheSpirits) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\16\218\140\237\229\204\22\234\150\243\239\248\0\197\139\233\227\211\0\149\131\244\239\135\65\141", "\167\115\181\226\155\138");
		end
	end
	if v22.NewMoon:IsCastable() then
		if v16(v22.NewMoon) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\236\39\240\99\118\126\201\236\98\230\83\126\49\149\178", "\166\130\66\135\60\27\17");
		end
	end
	if v22.HalfMoon:IsCastable() then
		if v16(v22.HalfMoon) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\76\75\194\115\15\73\69\193\123\112\69\69\203\53\99\22", "\80\36\42\174\21");
		end
	end
	if v22.FullMoon:IsCastable() then
		if v16(v22.FullMoon) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\72\5\59\118\113\29\56\117\64\80\54\117\75\80\100\46", "\26\46\112\87");
		end
	end
	if (v22.WildMushroom:IsCastable() and IsWildMushroom) then
		if v16(v22.WildMushroom, true) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\174\42\167\112\128\178\80\167\177\49\164\123\178\255\68\187\188\99\248\34", "\212\217\67\203\20\223\223\37");
		end
	end
	if (v22.ForceofNature:IsCastable() and IsForceofNature and (v6:HeroTreeID() ~= (16 + 7))) then
		if v16(v22.ForceofNature, true) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\188\130\186\209\191\178\167\212\133\131\169\198\175\159\173\146\187\130\173\146\238\213", "\178\218\237\200");
		end
	end
	if (v22.Starfire:IsCastable() and (not v6:IsMoving() or v6:BuffUp(v22.WarriorofEluneBuff)) and (v22.LunarCalling:IsAvailable() or (v6:BuffUp(v22.EclipseLunar) and (v45 > (1 - 0))))) then
		if v16(v22.Starfire) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\165\161\231\194\176\188\244\213\246\180\233\213\246\230\190", "\176\214\213\134");
		end
	end
	if (v22.Wrath:IsCastable() and not v6:IsMoving()) then
		if v16(v22.Wrath) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\227\191\183\192\160\22\88\251\168\246\128\248", "\57\148\205\214\180\200\54");
		end
	end
	if (v6:IsMoving() and v28.Balance.SpamDot) then
		if v22.Sunfire:IsCastable() then
			if v16(v22.Sunfire) then
				return LUAOBFUSACTOR_DECRYPT_STR_0("\1\232\59\50\127\0\248\117\57\121\4\244\59\51", "\22\114\157\85\84");
			end
		end
	end
end
local function v93()
	v25.HealthPotions();
	if v25.ShouldStopCastUpdate() then
		v13.CastMacro(1162 - (1074 + 82), true);
		return LUAOBFUSACTOR_DECRYPT_STR_0("\247\223\28\212\29\213\169\215\223\83\226\82\228\232\247\194\31\193\83\245\173", "\200\164\171\115\164\61\150");
	end
	InterruptToggle = v13.ToggleIconFrame:GetToggle(1 - 0);
	DispelToggle = v13.ToggleIconFrame:GetToggle(1786 - (214 + 1570));
	Smallcds = v13.ToggleIconFrame:GetToggle(1458 - (990 + 465));
	UseSpender = v13.ToggleIconFrame:GetToggle(2 + 2);
	local v134 = not v6:AffectingCombat() or not v8:AffectingCombat() or v8:IsDummy();
	Enemies40Yard = v6:GetEnemiesInRange(18 + 22);
	EnemiesRangeOOCCount = v82() or #Enemies40Yard;
	v48 = v25.UnitsinRange(v22.Regrowth);
	v44 = v8:GetEnemiesInSplashRange(10 + 0);
	if v14() then
		v45 = (v134 and #Enemies40Yard) or EnemiesRangeOOCCount;
	else
		v45 = 3 - 2;
	end
	IsRacials = v87(v28.Balance_TTD.RacialsTTD) and v86(v28.Balance_CDUSE.Racials);
	IsPotions = v87(v28.Balance_TTD.PotionsTTD) and (v28.Balance_CDUSE.Potionswhensolo or (not v28.Balance_CDUSE.Potionswhensolo and not v25.ISSolo())) and v86(v28.Balance_CDUSE.Potions);
	IsTrinket1 = v87(v28.Balance_TTD.TrinketsTTD) and v86(v28.Balance_CDUSE.Trinket1);
	IsTrinket2 = v87(v28.Balance_TTD.TrinketsTTD) and v86(v28.Balance_CDUSE.Trinket2);
	IsIncarnation = (not v22.OrbitalStrike:IsAvailable() or v81()) and v87(v28.Balance_TTD.IncarnationTTD) and v86(v28.Balance_CDUSE.Incarnation);
	IsWarriorofElune = v87(v28.Balance_TTD.WarriorofEluneTTD) and v86(v28.Balance_CDUSE.WarriorofElune);
	IsForceofNature = v81() and v87(v28.Balance_TTD.ForceofNatureTTD) and v86(v28.Balance_CDUSE.ForceofNature);
	IsWildMushroom = v87(v28.Balance_TTD.WildMushroomTTD) and v86(v28.Balance_CDUSE.WildMushroom);
	IsFuryofElune = v87(v28.Balance_TTD.FuryofEluneTTD) and v86(v28.Balance_CDUSE.FuryofElune);
	IsConvoketheSpirits = v87(v28.Balance_TTD.ConvoketheSpiritsTTD) and v86(v28.Balance_CDUSE.ConvoketheSpirits);
	if (v25.TargetIsValid() or (v6:AffectingCombat() and v8 and v8:AffectingCombat())) then
		TargetinRange = v8:IsSpellInRange(v22.Wrath);
		v46 = v3.BossFightRemains();
		v85 = true;
		v47 = v46;
		if (v47 == (12837 - (1668 + 58))) then
			v85 = false;
			v47 = v3.FightRemains(v44, false);
		end
		v39 = (v22.IncarnationTalent:IsAvailable() and (v6:BuffUp(v22.IncarnationBuff1) or v6:BuffUp(v22.IncarnationBuff2))) or v6:BuffUp(v22.CABuff1) or v6:BuffUp(v22.CABuff2);
		v40 = 626 - (512 + 114);
		if v39 then
			v40 = (v22.IncarnationTalent:IsAvailable() and v20(v6:BuffRemains(v22.IncarnationBuff1), v6:BuffRemains(v22.IncarnationBuff2))) or v20(v6:BuffRemains(v22.CABuff1), v6:BuffRemains(v22.CABuff2));
		end
	end
	if (v22.MarkoftheWild:IsCastable() and not v6:DebuffUp(v22.Corruption) and ((v25.GroupBuffMissing(v22.MarkoftheWildBuff) and (v28.Commons.MarkoftheWild == LUAOBFUSACTOR_DECRYPT_STR_0("\189\252\6\70\136\254\227\11\74\143\187\180\4\87\140\171\228", "\227\222\148\99\37")) and (v6:IsInRaidArea() or v6:IsInDungeonArea()) and (v6:InstanceDifficulty() ~= (534 - 329))) or (v6:BuffDown(v22.MarkoftheWildBuff, true) and ((v28.Commons.MarkoftheWild == LUAOBFUSACTOR_DECRYPT_STR_0("\60\92\94\239\185\48\90\87\245\242\115\71\65", "\153\83\50\50\150")) or (v28.Commons.MarkoftheWild == LUAOBFUSACTOR_DECRYPT_STR_0("\94\126\118\31\120\235\90\85\121\127\25\51\172\95\82\99\99", "\45\61\22\19\124\19\203")))))) then
		if v13.CastTarget(v22.MarkoftheWild, v13.TName().PLAYER) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\204\19\31\254\61\127\191\254\6\5\240\61\103\176\205\22\77\229\16\117\186\206\31\15\244\22", "\217\161\114\109\149\98\16");
		end
	end
	if (v22.MoonkinForm:IsCastable() and v6:BuffDown(v22.TravelFormBuff) and v6:BuffDown(v22.BearForm) and v6:BuffDown(v22.CatForm) and v28.Balance.ShowMoonkinFormOOC) then
		if v16(v22.MoonkinForm) then
			return LUAOBFUSACTOR_DECRYPT_STR_0("\31\47\55\114\183\125\28\31\62\115\174\121\82\47\55\127", "\20\114\64\88\28\220");
		end
	end
	if not v6:IsMoving() then
		v19 = not v6:IsCasting(v22.Hibernate) and v25.IncorpCycle(v22.Hibernate, 72 - 37, false, false);
		if v19 then
			return v19;
		end
	end
	if DispelToggle then
		v19 = v6:AffectingCombat() and v25.SootheCycle(v22.Soothe, 156 - 111, false, v28.Balance.TabForSoothe);
		if v19 then
			return v19;
		end
		if (v22.RemoveCorruption:IsCastable() and v6:IsInDungeonArea() and v6:IsInParty()) then
			v19 = v25.DispelCycle(v22.RemoveCorruption, LUAOBFUSACTOR_DECRYPT_STR_0("\1\14\219\167\247\222", "\221\81\97\178\212\152\176"), nil, v48);
			if v19 then
				return v19;
			end
			v19 = v25.DispelCycle(v22.RemoveCorruption, LUAOBFUSACTOR_DECRYPT_STR_0("\238\242\15\232\31", "\122\173\135\125\155"), nil, v48);
			if v19 then
				return v19;
			end
		end
	end
	if (v22.Rebirth:IsReady() and not v6:IsCasting(v22.Rebirth) and v6:AffectingCombat() and not v6:IsMoving()) then
		if (v8:UnitIsFriend() and v8:UnitIsPlayer() and v8:Exists() and v8:IsDeadOrGhost()) then
			v13.Cast(v22.Rebirth);
			return LUAOBFUSACTOR_DECRYPT_STR_0("\182\196\2\176\45\37\192\196\206\14\249\11\48\218\131\196\20", "\168\228\161\96\217\95\81");
		end
		if (v12:UnitIsFriend() and v12:UnitIsPlayer() and v12:Exists() and v12:IsDeadOrGhost()) then
			v13.CastTarget(v22.Rebirth, v13.TName().MOUSEOVER);
			return LUAOBFUSACTOR_DECRYPT_STR_0("\233\212\44\85\61\67\211\145\33\82\111\122\212\196\61\89\32\65\222\195", "\55\187\177\78\60\79");
		end
	end
	v19 = v88();
	if v19 then
		return v19;
	end
	if (v25.TargetIsValid() and v6:BuffDown(v22.TravelFormBuff)) then
		if (not v28.Balance.AttackonlyinCombat or (v28.Balance.AttackonlyinCombat and v8:AffectingCombat())) then
			if not v79(v5.Target) then
				if TargetinRange then
					if not v6:AffectingCombat() then
						local v144 = v6:BuffDown(v22.BearForm) and v89();
						if v144 then
							return v144;
						end
					end
					if (InterruptToggle and not v83()) then
						v19 = v25.InterruptCycle(v22.SolarBeam, 19 + 21, true, nil, false);
						if v19 then
							return v19;
						end
						v19 = v25.InterruptCycle(v22.MightyBash, 2 + 6, false, nil, true);
						if v19 then
							return v19;
						end
					end
					v29 = ((6 + 0) / v6:SpellHaste()) + v17(v22.NaturesBalance:IsAvailable()) + (v17(v22.OrbitBreaker:IsAvailable()) * v17(v22.MoonfireDebuff:AuraActiveCount() > (0 - 0)) * v17(v26.OrbitBreakerStacks > ((2021 - (109 + 1885)) - ((1471 - (1269 + 200)) * v17(v6:BuffUp(v22.SolsticeBuff))))) * (45 - 21));
					v30 = v20(v41:CooldownRemains(), v22.ForceofNature:CooldownRemains());
					v31 = v46 < (v42 + v30);
					v32 = ((v46 < (((830 - (98 + 717)) + ((831 - (802 + 24)) * v17(v22.Incarnation:IsAvailable()))) * ((1 - 0) - (v17(v22.WhirlingStars:IsAvailable()) * (0.2 - 0))))) or ((v8:TimeToDie() > (2 + 8)) and ((v6:HeroTreeID() ~= (18 + 5)) or v6:BuffUp(v22.HarmonyoftheGroveBuff)) and (not v22.WhirlingStars:IsAvailable() or not v22.ConvoketheSpirits:IsAvailable() or (v22.ConvoketheSpirits:CooldownRemains() < (v6:GCD() * (1 + 1))) or (v46 < (v22.ConvoketheSpirits:CooldownRemains() + 1 + 2)) or (v22.ConvoketheSpirits:CooldownRemains() > v41:FullRechargeTime())))) and v41:CooldownUp() and not v39;
					v38 = (v46 < (13 - 8)) or ((v39 or (v41:CooldownRemains() > (133 - 93))) and ((v6:HeroTreeID() ~= (9 + 14)) or v6:BuffUp(v22.HarmonyoftheGroveBuff) or (v22.ForceofNature:CooldownRemains() > (7 + 8))));
					v34 = v6:BuffUp(v22.EclipseLunar) or v6:BuffUp(v22.EclipseSolar);
					v35 = v20(v6:BuffRemains(v22.EclipseLunar), v6:BuffRemains(v22.EclipseSolar));
					v36 = v22.LunarCalling:IsAvailable() or (v45 > ((2 + 0) - v17((v22.UmbralIntensity:TalentRank() + v17(v22.SouloftheForest:IsAvailable())) > (1 + 0))));
					v37 = v6:BuffStack(v22.BOATArcaneBuff) + v6:BuffStack(v22.BOATNatureBuff);
					v33 = (not v22.CelestialAlignment:IsAvailable() and not v22.Incarnation:IsAvailable()) or not v15();
					if v28.Commons.Enabled.Trinkets then
						if (v23.AberrantSpellforge:IsEquippedAndReady() and (((v49:ID() == v23.AberrantSpellforge:ID()) and IsTrinket1) or ((v50:ID() == v23.AberrantSpellforge:ID()) and IsTrinket2))) then
							if v16(v23.AberrantSpellforge, true) then
								return LUAOBFUSACTOR_DECRYPT_STR_0("\44\204\90\249\84\206\142\57\241\76\251\67\195\140\43\193\77\236\67\143\141\44\199\81\171\20", "\224\77\174\63\139\38\175");
							end
						end
						if (v23.SpymastersWeb:IsEquippedAndReady() and (((v49:ID() == v23.SpymastersWeb:ID()) and IsTrinket1) or ((v50:ID() == v23.SpymastersWeb:ID()) and IsTrinket2)) and ((v32 and ((v6:BuffStack(v22.SpymastersReportBuff) > (14 + 15)) or (v46 < v42))) or (v46 < (1453 - (797 + 636))))) then
							if v16(v23.SpymastersWeb, true) then
								return LUAOBFUSACTOR_DECRYPT_STR_0("\151\81\65\35\133\82\76\43\150\82\103\57\129\67\24\35\133\72\86\110\208", "\78\228\33\56");
							end
						end
						if (v23.ImperfectAscendancySerum:IsEquippedAndReady() and (((v49:ID() == v23.ImperfectAscendancySerum:ID()) and IsTrinket1) or ((v50:ID() == v23.ImperfectAscendancySerum:ID()) and IsTrinket2)) and (v8:DebuffRemains(v22.SunfireDebuff) > (19 - 15)) and ((v8:DebuffRemains(v22.MoonfireDebuff) > (1623 - (1427 + 192))) or (v22.TreantsoftheMoon:IsAvailable() and ((v22.ForceofNature:CooldownRemains() < (2 + 1)) or v6:BuffUp(v22.HarmonyoftheGroveBuff)) and (v30 < (2 - 1))) or (v46 < (18 + 2)) or ((v46 < v30) and (v6:BuffUp(v22.HarmonyoftheGroveBuff) or v22.ConvoketheSpirits:CooldownUp()))) and (v6:BuffStack(v22.SpymastersReportBuff) <= (14 + 15))) then
							if v16(v23.ImperfectAscendancySerum, true) then
								return LUAOBFUSACTOR_DECRYPT_STR_0("\199\115\162\6\151\200\123\177\23\186\207\109\177\6\139\202\127\188\0\156\241\109\183\17\144\195\62\191\2\140\192\62\228", "\229\174\30\210\99");
							end
						end
						if (v23.TreacherousTransmitter:IsEquippedAndReady() and (((v49:ID() == v23.TreacherousTransmitter:ID()) and IsTrinket1) or ((v50:ID() == v23.TreacherousTransmitter:ID()) and IsTrinket2)) and ((v30 < (329 - (192 + 134))) or (v46 < (1296 - (316 + 960))) or ((v46 < v30) and (v6:BuffUp(v22.HarmonyoftheGroveBuff) or v22.ConvoketheSpirits:CooldownUp()))) and (v6:BuffStack(v22.SpymastersReportBuff) <= (17 + 12))) then
							if v16(v23.TreacherousTransmitter, true) then
								return LUAOBFUSACTOR_DECRYPT_STR_0("\15\255\131\80\238\53\60\9\226\147\66\210\41\43\26\227\149\92\228\41\45\30\255\198\92\236\52\55\91\181", "\89\123\141\230\49\141\93");
							end
						end
					end
					VarGenericTrinketCondition = v33 or ((v46 < v30) and (v6:BuffUp(v22.HarmonyoftheGroveBuff) or v22.ConvoketheSpirits:CooldownUp())) or ((((v6:BuffStack(v22.SpymastersReportBuff) + (v30 / (5 + 1))) > (27 + 2)) or (v46 < (v42 + v30))) and (v30 > (76 - 56))) or (v67 == (551 - (83 + 468)));
					if v28.Commons.Enabled.Trinkets then
						if (v49:IsReady() and v8:IsInRange(v57) and IsTrinket1 and not v59 and not v65 and (((v67 ~= (1807 - (1202 + 604))) and (v50:CooldownRemains() > (93 - 73))) or (((v67 == (1 - 0)) or (v67 == (8 - 5))) and v32) or (v46 < ((345 - (45 + 280)) + ((20 + 0) * v17(v50:CooldownRemains() < (22 + 3))))) or VarGenericTrinketCondition)) then
							if v16(v49, true) then
								return LUAOBFUSACTOR_DECRYPT_STR_0("\230\98\243\51\25\94\246\124\229\76\4\88\250\127\253\9\4\27\179\57", "\42\147\17\150\108\112") .. v49:Name() .. LUAOBFUSACTOR_DECRYPT_STR_0("\70\230\32\126\238\230\79\247\125", "\136\111\198\77\31\135");
							end
						end
						if (v50:IsReady() and v8:IsInRange(v58) and IsTrinket2 and not v60 and not v66 and (((v67 ~= (1 + 1)) and (v49:CooldownRemains() > (12 + 8))) or ((v67 == (1 + 1)) and v32) or (v46 < ((37 - 17) + ((1931 - (340 + 1571)) * v17(v49:CooldownRemains() < (10 + 15))))) or VarGenericTrinketCondition)) then
							if v16(v50, true) then
								return LUAOBFUSACTOR_DECRYPT_STR_0("\23\26\162\105\180\240\18\164\17\73\179\68\180\234\28\172\22\91\231\30", "\201\98\105\199\54\221\132\119") .. v50:Name() .. LUAOBFUSACTOR_DECRYPT_STR_0("\240\76\142\32\11\59\236\232\94", "\204\217\108\227\65\98\85");
							end
						end
					end
					if (v28.Commons.Enabled.Potions and (v39 or (v46 <= (1802 - (1733 + 39))))) then
						local v145 = v25.PotionSelected();
						if (v145 and v145:IsReady() and IsPotions) then
							v13.CastMacro(8 - 5, nil, nil, v145);
							return LUAOBFUSACTOR_DECRYPT_STR_0("\78\204\225\236\35\206\30\206\244\236\34\128\15\151", "\160\62\163\149\133\76");
						end
					end
					if v6:BuffUp(v22.BearForm) then
						if (v22.ThrashBear:IsCastable() and v8:IsInRange(1039 - (125 + 909)) and v8:DebuffRefreshable(v22.ThrashBearDebuff)) then
							if v16(v22.Thrashcast) then
								return LUAOBFUSACTOR_DECRYPT_STR_0("\194\168\31\46\208\222\224\15\42\194\196", "\163\182\192\109\79");
							end
						end
						if (v22.Mangle:IsCastable() and v8:IsInRange(1953 - (1096 + 852)) and (v8:DebuffUp(v22.ThrashBearDebuff) or not v22.ThrashBear:IsAvailable())) then
							if v16(v22.Mangle) then
								return LUAOBFUSACTOR_DECRYPT_STR_0("\25\39\14\199\249\49\102\2\197\244\38", "\149\84\70\96\160");
							end
						end
						if (v22.Swipe:IsCastable() and v8:IsInRange(3 + 2)) then
							if v16(v22.Swipecast) then
								return LUAOBFUSACTOR_DECRYPT_STR_0("\11\17\4\253\61\70\15\232\57\20", "\141\88\102\109");
							end
						end
						if (v22.ThrashBear:IsCastable() and v8:IsInRange(6 - 1)) then
							if v16(v22.Thrashcast) then
								return LUAOBFUSACTOR_DECRYPT_STR_0("\167\91\216\113\9\53\21\195\182\82\216", "\161\211\51\170\16\122\93\53");
							end
						end
					end
					if (v22.Berserking:IsCastable() and IsRacials and (v32 or v33 or (v46 < (15 + 0)))) then
						if v16(v22.Berserking, true) then
							return LUAOBFUSACTOR_DECRYPT_STR_0("\249\171\160\59\254\188\185\33\245\169\242\37\250\167\188\104\170\248", "\72\155\206\210");
						end
					end
					v34 = v6:BuffUp(v22.EclipseLunar) or v6:BuffUp(v22.EclipseSolar);
					v35 = v20(v6:BuffRemains(v22.EclipseLunar), v6:BuffRemains(v22.EclipseSolar));
					v36 = v22.LunarCalling:IsAvailable() or (v45 > ((514 - (409 + 103)) - v17((v22.UmbralIntensity:TalentRank() + v17(v22.SouloftheForest:IsAvailable())) > (237 - (46 + 190)))));
					v37 = v6:BuffStack(v22.BOATArcaneBuff) + v6:BuffStack(v22.BOATNatureBuff);
					if (v22.WarriorofElune:IsCastable() and IsWarriorofElune and (v22.LunarCalling:IsAvailable() or ((v35 >= (102 - (51 + 44))) and (v41:CooldownRemains() > (6 + 14))))) then
						if v16(v22.WarriorofElune, true) then
							return LUAOBFUSACTOR_DECRYPT_STR_0("\81\123\70\28\58\73\104\107\1\53\121\127\88\27\61\67\58\89\15\58\72\58\5\86", "\83\38\26\52\110");
						end
					end
					if (v22.Wrath:IsCastable() and not v6:IsMoving() and v36 and (not v34 or (v35 < v22.Wrath:CastTime()))) then
						if v16(v22.Wrath) then
							return LUAOBFUSACTOR_DECRYPT_STR_0("\79\5\38\82\80\87\42\71\81\25\103\20\8", "\38\56\119\71");
						end
					end
					if (v22.Starfire:IsCastable() and (not v6:IsMoving() or v6:BuffUp(v22.WarriorofEluneBuff)) and not v36 and (not v34 or (v35 < v22.Starfire:CastTime()))) then
						if v16(v22.Starfire) then
							return LUAOBFUSACTOR_DECRYPT_STR_0("\224\251\89\196\35\95\225\234\24\219\36\95\253\175\10\132", "\54\147\143\56\182\69");
						end
					end
					if (v14() and (v45 > (1318 - (1114 + 203))) and v22.Starfall:IsAvailable()) then
						local v146 = v92();
						if v146 then
							return v146;
						end
					end
					local v143 = v91();
					if v143 then
						return v143;
					end
					if v13.CastAnnotated(v22.Pool, false, LUAOBFUSACTOR_DECRYPT_STR_0("\225\160\214\125", "\191\182\225\159\41")) then
						return LUAOBFUSACTOR_DECRYPT_STR_0("\27\29\39\89\203\181\199\56\29\61\71\136\130\209", "\162\75\114\72\53\235\231");
					end
				end
			end
		end
	end
end
local function v94()
	v13.ResetToggle();
	v22.MoonfireDebuff:RegisterAuraTracking();
	v28.Balance.Display();
	local v135 = {[LUAOBFUSACTOR_DECRYPT_STR_0("\191\40\69\240\95\13\158\56\82\227\95\23\137", "\98\236\92\36\130\51")]=v22.StarlordBuff:Name()};
	local v136 = LUAOBFUSACTOR_DECRYPT_STR_0("\235\26\13\180\70\173\185\49\177\11\13\250\94\155\161\49\182\21\3\168\65\190\180\60\177\28\17", "\80\196\121\108\218\37\200\213");
	v13:UpdateMacro(LUAOBFUSACTOR_DECRYPT_STR_0("\13\114\1\109\68\95", "\234\96\19\98\31\43\110"), v84(v136, v135));
	v13:UpdateMacro(LUAOBFUSACTOR_DECRYPT_STR_0("\11\30\81\213\163\32", "\235\102\127\50\167\204\18"), LUAOBFUSACTOR_DECRYPT_STR_0("\31\180\230\38\4\127\6", "\78\48\193\149\67\36"));
	v13:UpdateMacro(LUAOBFUSACTOR_DECRYPT_STR_0("\61\31\131\10\78\102", "\33\80\126\224\120"), LUAOBFUSACTOR_DECRYPT_STR_0("\163\187\23\203\76\239\169\16\208\85\226\175", "\60\140\200\99\164"));
	v13.ToggleIconFrame:AddButtonCustom("I", 727 - (228 + 498), LUAOBFUSACTOR_DECRYPT_STR_0("\174\250\16\35\176\149\225\20\50", "\194\231\148\100\70"), LUAOBFUSACTOR_DECRYPT_STR_0("\79\66\213\166\228\218\83\92\213", "\168\38\44\161\195\150"));
	v13.ToggleIconFrame:AddButtonCustom("D", 1 + 1, LUAOBFUSACTOR_DECRYPT_STR_0("\164\245\145\102\53\228", "\118\224\156\226\22\80\136\214"), LUAOBFUSACTOR_DECRYPT_STR_0("\70\231\74\144\71\226", "\224\34\142\57"));
	v13.ToggleIconFrame:AddButtonCustom("S", 2 + 1, LUAOBFUSACTOR_DECRYPT_STR_0("\205\170\196\209\127\210\121\29", "\110\190\199\165\189\19\145\61"), LUAOBFUSACTOR_DECRYPT_STR_0("\201\230\118\228\135\196\222\248", "\167\186\139\23\136\235"));
	v13.ToggleIconFrame:AddButtonCustom("P", 667 - (174 + 489), LUAOBFUSACTOR_DECRYPT_STR_0("\47\166\141\62\10\176\134\9\31\167", "\109\122\213\232"), LUAOBFUSACTOR_DECRYPT_STR_0("\251\228\167\35\254\242\172\52\235\229", "\80\142\151\194"));
	v13.Print(LUAOBFUSACTOR_DECRYPT_STR_0("\33\199\123\77\13\197\114\12\39\212\98\69\7\134\101\67\23\199\99\69\12\200\55\68\2\213\55\78\6\195\121\12\22\214\115\77\23\195\115\12\5\201\101\12\19\199\99\79\11\134\38\29\77\150\57\30\77\134\91\77\16\210\55\121\19\194\118\88\6\134\39\27\77\151\39\2\81\150\37\24", "\44\99\166\23"));
end
v13.SetAPL(265 - 163, v93, v94);
