local n,v=...local G=v.GUI local S=G.CreatePanel local Z=G.CreateChildPanel local y=G.CreatePanelOption v.GUISettings={General={DebugMode=false;ReduceCPULoad=false;ReduceCPULoadOffset=34,Blacklist={NotFacingExpireMultiplier=3;UserDefined={},CycleUserDefined={[114553]=function(n)return n:HealthPercentage()>=65 and true or false end;[114568]=true,[116335]=true;[104596]=true,[115905]=true,[109041]=function()return v.GetInstanceDifficulty()==16 and true or false end;[109040]=function()return v.GetInstanceDifficulty()==16 and true or false end;[109038]=function()return v.GetInstanceDifficulty()==16 and true or false end,[104688]=true,[115795]=true,[115902]=true;[120437]=true;[151579]=true;[157229]=true,[160966]=true,[165251]=true;[166589]=true};ItemUserDefined={[181333]=true,[184055]=true,[185304]=true;[184052]=true;[184058]=true;[185309]=true,[174044]=true}}}}function v.GUI.CorePanelSettingsInit()local n=S(v.GUI,"\072\101\114\111\076\105\098","\080\097\110\101\108\070\114\097\109\101",v.GUISettings,HeroLibDB.GUISettings)local G=Z(n,"\071\101\110\101\114\097\108")y("\067\104\101\099\107\066\117\116\116\111\110",G,"\071\101\110\101\114\097\108\046\068\101\098\117\103\077\111\100\101","\069\110\097\098\108\101 \068\101\098\117\103 \077\111\100\101","\069\110\097\098\108\101 \105\102 \121\111\117 \119\097\110\116 \072\101\114\111\076\105\098 \116\111 \111\117\116\112\117\116 \100\101\098\117\103 \109\101\115\115\097\103\101\115\046")y("\067\104\101\099\107\066\117\116\116\111\110",G,"\071\101\110\101\114\097\108\046\082\101\100\117\099\101\067\080\085\076\111\097\100","\082\101\100\117\099\101 \067\080\085 \076\111\097\100","\069\110\097\098\108\101 \105\102 \121\111\117 \119\111\117\108\100 \108\105\107\101 \116\111 \105\110\099\114\101\097\115\101 \116\104\101 \099\121\099\108\101 \116\105\109\101 \111\102 \116\104\101 \097\100\100\111\110\044 \099\097\117\115\105\110\103 \072\101\114\111\076\105\098 \097\110\100 \072\101\114\111\082\111\116\097\116\105\111\110 \116\111 \117\115\101 \108\101\115\115 \067\080\085 \098\121 \114\117\110\110\105\110\103 \116\104\114\111\117\103\104 \105\116\115 \099\121\099\108\101\115 \111\110 \097 \108\111\110\103\101\114 \100\101\108\097\121\046")y("\083\108\105\100\101\114",G,"\071\101\110\101\114\097\108\046\082\101\100\117\099\101\067\080\085\076\111\097\100\079\102\102\115\101\116",{0;1000;1},"\082\101\100\117\099\101 \067\080\085 \076\111\097\100 \079\102\102\115\101\116 \040\124\099\102\102\102\102\048\048\048\048\087\065\082\078\073\078\071\124\114\041","\083\101\116 \116\104\105\115 \118\097\108\117\101 \116\111 \116\101\108\108 \116\104\101 \097\100\100\111\110 \104\111\119 \109\097\110\121 \109\111\114\101 \109\105\108\108\105\115\101\099\111\110\100\115 \116\111 \097\100\100 \116\111 \072\101\114\111\076\105\098 \097\110\100 \072\101\114\111\082\111\116\097\116\105\111\110\'\115 \099\121\099\108\101 \116\105\109\101 \119\104\101\110 \116\104\101 \097\098\111\118\101 \'\082\101\100\117\099\101 \067\080\085 \076\111\097\100\' \111\112\116\105\111\110 \105\115 \099\104\101\099\107\101\100\046 \124\099\102\102\102\102\048\048\048\048\087\065\082\078\073\078\071\124\114\058 \072\105\103\104 \118\097\108\117\101\115 \097\114\101 \078\079\084 \114\101\099\111\109\109\101\110\100\101\100\044 \097\115 \116\104\105\115 \119\105\108\108 \099\097\117\115\101 \072\101\114\111\082\111\116\097\116\105\111\110\'\115 \115\117\103\103\101\115\116\105\111\110\115 \116\111 \097\112\112\101\097\114 \108\097\116\101\110\116\046 \066\121 \100\101\102\097\117\108\116\044 \116\104\101 \097\100\100\111\110 \119\105\108\108 \099\121\099\108\101 \049\053 \116\105\109\101\115 \112\101\114 \115\101\099\111\110\100 \040\105\116\115 \098\117\105\108\116-\105\110 \054\054\109\115 \100\101\108\097\121\041\046 \087\104\101\110 \'\082\101\100\117\099\101 \067\080\085 \076\111\097\100\' \105\115 \099\104\101\099\107\101\100\044 \116\104\105\115 \118\097\108\117\101 \119\105\108\108 \098\101 \097\100\100\101\100 \116\111 \116\104\097\116 \054\054\109\115\046 \073\102 \116\104\105\115 \118\097\108\117\101 \105\115 \115\101\116 \116\111 \052\051\052\044 \102\111\114 \101\120\097\109\112\108\101\044 \116\104\097\116 \119\105\108\108 \097\100\100 \052\051\052\109\115\046 \084\104\105\115 \119\111\117\108\100 \109\097\107\101 \072\101\114\111\082\111\116\097\116\105\111\110 \111\110\108\121 \099\121\099\108\101 \116\119\105\099\101 \112\101\114 \115\101\099\111\110\100\046")end