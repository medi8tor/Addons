return(function(...)local U={"\097\102\065\048\115\079\109\086\119\107\061\061";"\077\103\113\043\088\108\086\103\069\075\109\102\090\103\101\073\122\106\117\061";"\104\108\071\084\115\108\100\061";"\088\097\086\053\076\106\056\061";"\097\102\065\073\081\106\113\061";"\081\108\049\103\122\106\122\099\122\108\050\068\076\100\061\061","\115\098\118\050\049\087\080\077\057\075\071\078\115\102\069\116\104\078\073\061";"\122\098\118\084\090\078\049\103\090\106\071\089","\122\106\101\100\090\106\071\089","\088\079\049\075\088\108\086\103\104\079\050\116\119\110\061\061";"\057\097\109\086\104\079\050\087\081\069\054\048\090\066\118\084\104\079\086\086\104\100\061\061","\104\075\109\116\076\106\101\066","\115\106\050\087\090\078\111\061","\109\078\049\087\088\108\086\103\104\079\050\116\119\110\061\061";"\081\108\049\103\122\106\104\061";"\097\102\065\066\090\100\061\061";"\088\108\086\103\069\075\109\102\090\111\061\061";"\104\079\050\075\081\097\050\102\090\106\100\061","\115\108\065\084\081\108\081\048\115\108\069\061","\090\097\071\099\081\097\118\087","\104\075\109\116\115\106\050\087\090\078\111\061"}local function B(B)return U[B+14258]end for B,s in ipairs({{1,21};{1;8};{9,21}})do while s[1]<s[2]do U[s[1]],U[s[2]],s[1],s[2]=U[s[2]],U[s[1]],s[1]+1,s[2]-1 end end do local B=table.insert local s=string.len local e=type local D=U local Y={D=35,l=6,O=38;["\052"]=36;a=23;N=54;f=53,S=2;["\057"]=18;G=13;H=40,E=20,n=16;m=17;["\047"]=31;R=62,j=22;y=14;L=26;["\050"]=5,s=27;z=29,K=55;["\056"]=8,P=45,V=37,u=4;Y=43,T=33;["\049"]=21,["\048"]=41;A=61;c=51,q=56;["\051"]=3;M=11;Z=24;U=15,h=28,g=34;k=0,Q=25;["\055"]=10;F=42,v=9,e=57;p=60;["\053"]=12;r=63;W=52;I=44;d=48,["\054"]=49;o=32,X=19,t=50;C=59,["\043"]=47,J=58,w=30,b=7,B=39,i=46;x=1}local b=math.floor local z=table.concat local o=string.char local f=string.sub for U=1,#D,1 do local q=D[U]if e(q)=="\115\116\114\105\110\103"then local e=s(q)local F={}local v=1 local y=0 local S=0 while v<=e do local U=f(q,v,v)local s=Y[U]if s then y=y+s*64^(3-S)S=S+1 if S==4 then S=0 local U=b(y/65536)local s=b((y%65536)/256)local e=y%256 B(F,o(U,s,e))y=0 end elseif U=="\061"then B(F,o(b(y/65536)))if v>=e or f(q,v+1,v+1)~="\061"then B(F,o(b((y%65536)/256)))end break end v=v+1 end D[U]=z(F)end end end return(function(U,e,D,Y,b,z,o,S,y,v,n,q,F,f,h,s)F,s,y,v,f,q,h,S,n=function()v=1+v q[v]=1 return v end,function(s,D,Y,b)local q,E,c,o,F,f,h,A,t,y,S,v,n,r while s do if s<9602988 then if s<6785382 then if s<3664196 then if s<3148886 then S,y=F(v,S)s=S and 11028817 or 3658863 else F=B(-14251)q=U[F]y=B(-14254)n=B(-14246)S=U[y]y=B(-14257)y=S[y]r=B(-14254)h=true s=3910263 y=y(S,n,h)v=not y F=q(v)F=B(-14251)q=U[F]y=B(-14247)S=U[y]h=U[r]r=B(-14257)n=h[r]r=B(-14254)h=U[r]r=B(-14246)y=S(n,h,r)v=not y F=q(v)F=B(-14254)v=B(-14246)S=1 h=B(-14254)q=U[F]F=B(-14240)F=q[F]F=F(q,v,S)v=B(-14251)q=U[v]v=q(F)v=B(-14251)q=U[v]y=B(-14253)r=B(-14246)S=U[y]n=U[h]h=B(-14257)h=n[h]h=h(n,r)n=B(-14246)y={S(h,F)}r=B(-14240)v=q(e(y))v=B(-14251)y=B(-14254)q=U[v]S=U[y]h=2 r=S[r]y={r(S,n,h)}v=q(e(y))S=B(-14254)h=B(-14239)q=0 v=U[S]h=v[h]h={h(v)}n=h[3]S=h[1]y=h[2]end else n,h=S(y,n)s=n and 9474849 or 8977170 end else if s<9004586 then S=B(-14251)s=U[B(-14243)]F=nil o={}n=1 v=U[S]y=q==n S=v(y)q=nil else c=B(-14246)v=n r=v==c s=r and 10440511 or 15811555 end end else if s<11265134 then if s<10833009 then c=1 r=q+c A=B(-14253)s=15811555 t=B(-14251)c=U[t]E=U[A]q=r A={E(h,F)}t=c(e(A))else q=S y=nil h=B(-14251)c=B(-14246)n=U[h]r=q~=c h=n(r)q=nil s=3016796 end else if s<13752888 then F=B(-14238)q=B(-14256)o=U[q]f=D q=B(-14242)s=o[q]o=B(-14244)y=B(-14239)U[o]=s q=U[F]F=B(-14237)o=q[F]q=B(-14250)U[q]=o F=B(-14252)s=3016796 v=B(-14248)q=U[F]F=q(v)q=F()F=B(-14254)q=U[F]y=q[y]y={y(q)}F=y[1]S=y[3]v=y[2]else s=3910263 h=nil v=nil end end end end s=#b return e(o)end,function(U)for B=1,#U,1 do q[U[B]]=q[U[B]]+1 end if D then local s=D(true)local e=b(s)e[B(-14249)],e[B(-14255)],e[B(-14245)]=U,S,function()return-2574543 end return s else return Y({},{[B(-14255)]=S,[B(-14249)]=U;[B(-14245)]=function()return-2574543 end})end end,0,{},{},function(U)q[U]=q[U]-1 if 0==q[U]then q[U],f[U]=nil,nil end end,function(U)local B,s=1,U[1]while s do q[s],B=q[s]-1,B+1 if q[s]==0 then q[s],f[s]=nil,nil end s=U[B]end end,function(U,B)local e=y(B)local D=function(...)return s(U,{...},B,e)end return D end return(n(11378011,{}))(e(o))end)(getfenv and getfenv()or _ENV,unpack or table[B(-14241)],newproxy,setmetatable,getmetatable,select,{...})end)(...)