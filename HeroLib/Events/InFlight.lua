local G,U=...local h=HeroCache local w=U.Unit local i=w.Player local Z=w.Target local M=U.Spell local d=pairs local O=math.max local c={}local C={}function M.RegisterInFlightEffect(U,G)U.InFlightEffectID=G end function M.InFlightEffect(G)return G.InFlightEffectID end function M.RegisterInFlight(G,...)local U={...}local h=G.SpellID local w={Inflight=false,DestGUID=nil;Count=0;Auras={}}c[h]=w for G,U in d(U)do if U:ID()then w.Auras[U]=false end end local i=G:InFlightEffect()if i then C[i]=h end end U:RegisterForSelfCombatEvent(function(G,U,h,w,M,O,C,H,W,k,Y,n)local g=c[n]if not g then return end if H==""then g.DestGUID=Z:GUID()else g.DestGUID=H end g.Inflight=true g.Count=g.Count+1 for G,U in d(g.Auras)do g.Auras[G]=i:BuffUp(G)or G:TimeSinceLastRemovedOnPlayer()<.1 end end,"\083\080\069\076\076\095\067\065\083\084\095\083\085\067\067\069\083\083")U:RegisterForSelfCombatEvent(function(G,U,h,w,i,Z,M,d,H,W,k,Y)local n=C[Y]local g=n and c[n]or c[Y]if not g then return end if g.DestGUID==d then g.Inflight=false g.Count=O(0,g.Count-1)end end,"\083\080\069\076\076\095\068\065\077\065\071\069","\083\080\069\076\076\095\077\073\083\083\069\068","\083\080\069\076\076\095\065\085\082\065\095\065\080\080\076\073\069\068","\083\080\069\076\076\095\065\085\082\065\095\082\069\070\082\069\083\072")U:RegisterForCombatEvent(function(G,U,h,w,i,Z,M,C)for G,U in d(c)do local h=c[G]if h.DestGUID==C then h.Inflight=false h.Count=O(0,h.Count-1)end end end,"\085\078\073\084\095\068\073\069\068","\085\078\073\084\095\068\069\083\084\082\079\089\069\068")function M.InFlight(U,G)local h=c[U:ID()]if not h then error("\089\111\117 \102\111\114\103\111\116 \116\111 \114\101\103\105\115\116\101\114 "..(U:Name().." \102\111\114 \073\110\070\108\105\103\104\116 \116\114\097\099\107\105\110\103\046"))end if G then return h.Inflight and h.Auras[G]end return h.Inflight end