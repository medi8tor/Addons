local n,v=...local G=HeroCache local S=v.Unit local Z=S.Player local y=S.Target local p=v.Spell local t=v.Item local Q=GetInstanceInfo local I=GetNetStats local s=CreateFrame local B=GetTime local O=UIParent local c=math.max local w=select function v.GetInstanceInfo(n)if n then local v=w(n,Q())return v end return Q()end function v.GetInstanceDifficulty()return v.GetInstanceInfo(3)end function v.CombatTime()return v.CombatStarted~=0 and B()-v.CombatStarted or 0 end function v.OutOfCombatTime()return v.CombatEnded~=0 and B()-v.CombatEnded or 0 end function v.BMPullTime()if not v.BossModTime or v.BossModTime==0 or v.BossModEndTime-B()<0 then return 60 else return v.BossModEndTime-B()end end do local n=0 local G=s("\070\114\097\109\101","\072\101\114\111\076\105\098\095\076\097\116\101\110\099\121\070\114\097\109\101",O)local S=0 local y=30 G:SetScript("\079\110\085\112\100\097\116\101",function()if B()<=S then return end S=B()+y local v,G,Z,p=I()n=p/1000 end)function v.Latency()return n end function v.RecoveryTimer()local n=Z:CastRemains()local v=Z:GCDRemains()return c(v,n)end function v.RecoveryOffset(G)if G then return 0 end return n+v.RecoveryTimer()end end