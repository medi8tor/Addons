return(function(...)local s={"\048\105\076\088\072\074\053\061";"\097\086\111\085\087\103\120\056\072\114\120\088";"\100\085\111\119\050\086\089\061","\110\103\120\102\120\105\118\084\050\075\061\061";"\101\105\120\088\073\102\090\081\071\103\081\118","\075\114\111\106\087\104\061\061";"\072\086\098\104\071\086\090\113","\120\105\111\102\050\086\085\052\071\086\085\118";"\097\114\076\084\050\100\079\119\071\100\110\118","\052\076\081\106\090\077\050\065\097\086\116\103\120\085\109\079\048\120\087\061";"\100\085\111\117\071\104\061\061","\100\085\111\109\073\114\110\118\043\108\061\061","\120\086\098\109\072\108\061\061","\110\114\111\083\072\100\055\061";"\120\105\111\102\050\086\085\101\050\086\085\081\047\086\098\106";"\048\105\116\081\043\086\120\088";"\120\085\069\088\073\105\050\106\075\103\075\106\101\112\076\100\048\122\061\061","\048\105\120\102";"\048\114\076\109\050\108\061\061","\120\105\076\088\050\103\120\102","\048\112\079\118\073\105\104\061","\072\103\109\055\047\120\110\099\101\080\090\068\120\086\110\081\090\104\061\061","\101\100\110\118\073\075\061\061","\120\100\110\109\073\074\055\061";"\110\103\120\102\120\105\111\102\050\086\085\069\073\114\050\070","\043\076\118\071\050\106\053\112\086\114\109\100\110\120\118\065","\075\100\069\118\073\114\080\061"}local function G(G)return s[G+52827]end for G,p in ipairs({{1,27};{1,21},{22;27}})do while p[1]<p[2]do s[p[1]],s[p[2]],p[1],p[2]=s[p[2]],s[p[1]],p[1]+1,p[2]-1 end end do local G=math.floor local p=string.char local C=string.sub local D=string.len local n={w=44,["\047"]=26;X=50;J=7,y=2;n=17,l=0,N=62,S=35,["\057"]=63;I=27;f=52,i=6;u=39,D=8,q=43;g=54,r=38;d=23,c=42;O=1;t=49;["\052"]=14,A=34;B=11,L=5,p=55;["\054"]=60;E=9,["\053"]=36,["\049"]=10,o=61;Q=33;a=19;G=24;["\043"]=30;j=51,P=4;V=22;K=16;e=18,k=58,z=32;["\050"]=25,["\051"]=31,x=21;Z=13,h=48;b=57;C=59;m=41;s=46;["\048"]=20,R=40,["\056"]=15,W=28;["\055"]=12,v=37,Y=56,M=3,F=47,H=29,U=53;T=45}local J=table.insert local B=table.concat local t=type local I=s for s=1,#I,1 do local Z=I[s]if t(Z)=="\115\116\114\105\110\103"then local t=D(Z)local O={}local j=1 local W=0 local m=0 while j<=t do local s=C(Z,j,j)local D=n[s]if D then W=W+D*64^(3-m)m=m+1 if m==4 then m=0 local s=G(W/65536)local C=G((W%65536)/256)local D=W%256 J(O,p(s,C,D))W=0 end elseif s=="\061"then J(O,p(G(W/65536)))if j>=t or C(Z,j+1,j+1)~="\061"then J(O,p(G((W%65536)/256)))end break end j=j+1 end I[s]=B(O)end end end return(function(s,C,D,n,J,B,t,O,a,X,S,m,c,I,W,p,j,Z,v)c,Z,m,W,O,X,p,I,v,j,S,a=function(s,G)local C=W(G)local D=function(D,n,J,B,t,I,Z)return p(s,{D;n,J;B;t;I;Z},G,C)end return D end,{},function(s)local G,p=1,s[1]while p do Z[p],G=Z[p]-1,1+G if Z[p]==0 then Z[p],I[p]=nil,nil end p=s[G]end end,function(s)for G=1,#s,1 do Z[s[G]]=1+Z[s[G]]end if D then local p=D(true)local C=J(p)C[G(-52821)],C[G(-52822)],C[G(-52803)]=s,m,function()return-2577871 end return p else return n({},{[G(-52822)]=m;[G(-52821)]=s,[G(-52803)]=function()return-2577871 end})end end,function()j=j+1 Z[j]=1 return j end,function(s,G)local C=W(G)local D=function(D,n,J)return p(s,{D,n;J},G,C)end return D end,function(p,D,n,J)local j,M,d,Z,V,W,a,h,f,F,x,t,m,w,H,l,o,T,N,q,y while p do if p<8708595 then if p<7822128 then if p<5864903 then a=G(-52808)j=D[2]M=0 Z=D[1]a=Z[a]a={a(Z,j)}m=a[4]W=a[3]p=a[1]t=a[2]N=t t=N or M a=p t={t}p=s[G(-52816)]else M=G(-52815)Z=D p=Z[1]t=Z[2]j=p W=t t=G(-52801)H=G(-52800)p=s[t]m=G(-52809)t=W[m]a=t m=p o=G(-52804)t=G(-52820)p=W[t]t=G(-52817)w=G(-52824)N=p p=N[t]t=N[M]h=G(-52813)q=O()M=N[h]h=p x=t t=G(-52819)p=N[t]t=N[o]o=p f=G(-52814)V=t t=G(-52806)p=N[t]T=O()t=N[H]V=nil H=N[w]w=p y=t t=G(-52805)p=N[t]t=N[f]d=t y=nil t=G(-52812)f=p d=nil p=W[t]F=p t=G(-52810)p=W[t]l=p t=G(-52808)l=nil p=s[t]t=G(-52802)x=nil I[q]=p f=nil M=nil W=nil p=s[t]I[T]=p t=G(-52808)p=c(16762880,{q})w=nil h[t]=p p=X(8366847,{T})t=G(-52818)h[t]=p F=nil q=v(q)m=nil N=nil T=v(T)t=G(-52825)a=nil p=S(2775124,{})H=nil j=nil h[t]=p o=nil h=nil t={}p=s[G(-52811)]end else j=D[2]a=G(-52808)Z=D[1]a=Z[a]a={a(Z,j)}W=a[3]m=a[4]p=a[1]t=a[2]V=0 N=t a=p t=W+m M=I[n[1]]h=M()p=t-h M=p o=M>=V x=p p=o and 12487549 or 10648901 h=o end else if p<12953221 then if p<10932720 then p=x x=0 p=s[G(-52807)]t=h or x t={t}else h=M p=10648901 end else j=D[2]p=I[n[1]]Z=D[1]N={p(j)}p=s[G(-52823)]W=N[2]m=N[3]t=N[1]a=N[4]N=t t={N,W;m;a}end end end p=#J return C(t)end,{},function(s)Z[s]=Z[s]-1 if 0==Z[s]then Z[s],I[s]=nil,nil end end,0,function(s,G)local C=W(G)local D=function(D,n,J,B,t)return p(s,{D;n,J;B;t},G,C)end return D end,function(s,G)local C=W(G)local D=function(...)return p(s,{...},G,C)end return D end return(a(6142139,{}))(C(t))end)(getfenv and getfenv()or _ENV,unpack or table[G(-52826)],newproxy,setmetatable,getmetatable,select,{...})end)(...)