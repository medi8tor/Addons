local n,v=...local G=HeroCache local S=v.Unit local Z=S.Player local y=S.Pet local p=S.Target local t=v.Spell local Q=v.Item local I=pairs do local n=S.Nameplate v:RegisterForEvent(function(v,G)n[G]:Cache()end,"\078\065\077\069\095\080\076\065\084\069\095\085\078\073\084\095\065\068\068\069\068")v:RegisterForEvent(function(v,G)n[G]:Init()end,"\078\065\077\069\095\080\076\065\084\069\095\085\078\073\084\095\082\069\077\079\086\069\068")end v:RegisterForEvent(function()p:Cache()end,"\080\076\065\089\069\082\095\084\065\082\071\069\084\095\067\072\065\078\071\069\068")do local n=S.Focus v:RegisterForEvent(function()n:Cache()end,"\080\076\065\089\069\082\095\070\079\067\085\083\095\067\072\065\078\071\069\068")end do local n=S.Arena v:RegisterForEvent(function(v,G)local S=n[G]if S then S:Cache()end end,"\065\082\069\078\065\095\079\080\080\079\078\069\078\084\095\085\080\068\065\084\069")end do local n=S.Boss v:RegisterForEvent(function()for n,v in I(n)do v:Cache()end end,"\073\078\083\084\065\078\067\069\095\069\078\067\079\085\078\084\069\082\095\069\078\071\065\071\069\095\085\078\073\084")end v:RegisterForEvent(function()for n,v in I(S.Party)do v:Cache()end for n,v in I(S.Raid)do v:Cache()end end,"\071\082\079\085\080\095\082\079\083\084\069\082\095\085\080\068\065\084\069")do local n=S.Focus local G,Z,y,t=S.Boss,S.Party,S.Raid,S.Nameplate v:RegisterForEvent(function(v,S)if S==p:ID()then p:Cache()elseif S==n:ID()then n:Cache()else local n=Z[S]or y[S]or G[S]or t[S]if n then n:Cache()end end end,"\085\078\073\084\095\084\065\082\071\069\084\065\066\076\069\095\067\072\065\078\071\069\068","\085\078\073\084\095\070\065\067\084\073\079\078","\085\078\073\084\095\070\076\065\071\083")end