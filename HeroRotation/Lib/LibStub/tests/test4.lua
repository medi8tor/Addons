return(function(...)local C={"\107\103\108\120\113\048\113\054\113\103\056\112\088\075\061\061";"\087\052\100\061";"\085\104\078\112\102\083\113\121\119\119\105\100\048\112\066\079\107\083\119\061";"\113\114\105\066\051\116\108\120\051\048\071\099";"\051\121\071\054\107\121\105\052","\085\048\056\052\051\116\106\061","\113\048\072\075\051\048\071\099";"\087\103\078\120\119\053\102\083\051\106\061\061";"\076\121\102\078\074\068\056\052\107\119\065\079\051\070\105\066\074\068\078\078\074\075\061\061","\121\083\067\070\051\075\061\061";"\107\070\108\057\051\053\102\079\085\116\101\061","\085\103\067\066\107\103\107\079\085\103\119\061";"\121\083\067\100\107\048\101\061";"\113\114\078\075\107\069\061\061","\074\114\105\079\085\070\069\061","\085\048\078\057\085\053\118\061";"\074\053\102\077\085\048\056\052\051\116\106\061","\107\103\108\120\113\048\074\061";"\121\083\067\079\085\068\102\078\043\089\061\061","\074\053\102\077\088\048\072\070","\110\120\101\115\087\103\078\120\119\053\102\083\051\120\072\100\113\048\081\061"}for Z,e in ipairs({{1;21};{1;2};{3;21}})do while e[1]<e[2]do C[e[1]],C[e[2]],e[1],e[2]=C[e[2]],C[e[1]],e[1]+1,e[2]-1 end end local function Z(Z)return C[Z+65131]end do local Z=table.insert local e=C local z=table.concat local g=string.char local V=string.sub local U=type local y=string.len local W=math.floor local Q={M=50;R=14,S=53;T=40;["\050"]=10,G=13;["\056"]=5,["\057"]=46;r=7,h=36,W=19;B=33,n=11;a=31;z=3,N=37;d=44,Z=2;O=41;A=49,v=8,k=25,u=15,Y=0;s=47;C=61;m=60,["\053"]=55,l=21,K=48;t=54,y=23;X=26,E=16;V=1,e=56;U=27;["\052"]=52,o=42;f=17,D=38,w=20,P=63,F=39,j=32,Q=4,b=59,H=57;g=6;["\049"]=12,q=29;["\048"]=22;["\047"]=62;J=28,L=18,["\043"]=30;I=58;["\054"]=51,["\055"]=45,i=9,x=34;p=35,c=43,["\051"]=24}for C=1,#e,1 do local m=e[C]if U(m)=="\115\116\114\105\110\103"then local U=y(m)local r={}local k=1 local S=0 local D=0 while k<=U do local C=V(m,k,k)local e=Q[C]if e then S=S+e*64^(3-D)D=D+1 if D==4 then D=0 local C=W(S/65536)local e=W((S%65536)/256)local z=S%256 Z(r,g(C,e,z))S=0 end elseif C=="\061"then Z(r,g(W(S/65536)))if k>=U or V(m,k+1,k+1)~="\061"then Z(r,g(W((S%65536)/256)))end break end k=k+1 end e[C]=z(r)end end end return(function(C,z,g,V,U,y,W,Q,r,P,D,e,m,E,S,k)k,E,m,e,S,r,P,Q,D=0,function(C)m[C]=m[C]-1 if 0==m[C]then m[C],Q[C]=nil,nil end end,{},function(e,g,V,U)local Q,D,E,P,k,H,S,m,r,W while e do Q=g m=Z(-65111)W=C[m]m=Z(-65125)r=Z(-65130)k=Z(-65129)e=W[m]W=Z(-65128)C[W]=e m=C[r]E=Z(-65121)S=Z(-65121)r=Z(-65123)W=m[r]r=Z(-65117)m=Z(-65112)C[m]=W m=C[r]r=m(k)m=r()r=Z(-65124)m=C[r]D=C[S]S=Z(-65113)k=D[S]r=m(k)r=Z(-65121)m=C[r]S=C[E]r=Z(-65113)E=Z(-65113)D=S[E]S=.0001 k=D-S m[r]=k r=Z(-65121)k=nil P=Z(-65121)m=C[r]r=Z(-65120)m[r]=k r=Z(-65117)m=C[r]k=Z(-65129)S=Z(-65115)r=m(k)m=r()r=Z(-65124)m=C[r]D=C[S]H=C[P]P=Z(-65120)E=H[P]S=D(E)D=Z(-65118)k=S==D r=m(k)r=Z(-65121)k=123 m=C[r]r=Z(-65120)m[r]=k r=Z(-65117)m=C[r]k=Z(-65129)r=m(k)m=r()E=Z(-65121)r=Z(-65124)m=C[r]S=C[E]E=Z(-65120)D=S[E]E=Z(-65121)S=123 k=D==S r=m(k)r=Z(-65121)m=C[r]S=C[E]r=Z(-65113)E=Z(-65113)D=S[E]S=.0001 k=D+S m[r]=k k=Z(-65129)r=Z(-65117)m=C[r]r=m(k)m=r()r=Z(-65124)E=Z(-65121)m=C[r]S=C[E]E=Z(-65120)D=S[E]E=Z(-65121)e=C[Z(-65126)]S=123 k=D==S r=m(k)r=Z(-65121)m=C[r]r=Z(-65113)S=C[E]E=Z(-65113)D=S[E]S=1234567890 E=Z(-65121)k=D+S m[r]=k k=Z(-65129)r=Z(-65117)m=C[r]r=m(k)m=r()r=Z(-65124)m=C[r]S=C[E]E=Z(-65120)D=S[E]S=123 k=D==S r=m(k)r=Z(-65114)k=Z(-65127)m=C[r]r=m(k)W={}end e=#U return z(W)end,function(C)for Z=1,#C,1 do m[C[Z]]=m[C[Z]]+1 end if g then local e=g(true)local z=U(e)z[Z(-65110)],z[Z(-65119)],z[Z(-65116)]=C,D,function()return-2573519 end return e else return V({},{[Z(-65119)]=D;[Z(-65110)]=C,[Z(-65116)]=function()return-2573519 end})end end,function()k=k+1 m[k]=1 return k end,function(C,Z)local z=S(Z)local g=function(...)return e(C,{...},Z,z)end return g end,{},function(C)local Z,e=1,C[1]while e do m[e],Z=m[e]-1,Z+1 if m[e]==0 then m[e],Q[e]=nil,nil end e=C[Z]end end return(P(103427,{}))(z(W))end)(getfenv and getfenv()or _ENV,unpack or table[Z(-65122)],newproxy,setmetatable,getmetatable,select,{...})end)(...)