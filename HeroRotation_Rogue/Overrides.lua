return(function(...)local R={"\118\048\080\082\052\065\061\061","\047\108\116\073\055\048\086\061","\118\054\113\068\055\122\118\074";"\043\054\118\068\085\108\089\066\052\054\113\074\120\048\116\097";"\050\054\118\074","\047\108\116\082\085\117\069\088\072\065\061\061";"\043\047\069\088\085\076\061\061";"\050\117\116\101\052\048\050\061","\050\087\105\088\085\054\071\061";"\100\087\118\074\085\054\113\087","\050\054\119\090\072\048\118\068";"\043\054\118\068\085\074\121\090\056\122\090\088","\052\048\080\071\056\048\121\106","\076\047\121\107\056\047\121\107\120\048\080\090\052\054\088\066\085\098\061\061","\047\108\116\101\056\071\061\061";"\050\087\118\077\052\054\119\088\052\109\103\061","\043\054\118\068\085\074\119\082\056\098\061\061","\056\108\088\054\069\118\090\087\067\103\119\086\050\112\051\071"}local function M(M)return R[M-17790]end for M,G in ipairs({{1,18},{1;10},{11;18}})do while G[1]<G[2]do R[G[1]],R[G[2]],G[1],G[2]=R[G[2]],R[G[1]],G[1]+1,G[2]-1 end end do local M=string.sub local G=R local I=table.concat local b=math.floor local i={["\057"]=62,d=19;u=38;p=4;s=28;e=39,L=16;Z=33;T=35;j=43,a=46;q=5,r=15;["\043"]=18;D=50,["\048"]=22;["\049"]=40,X=37;I=44,x=26,c=3,O=11;v=21;U=27,G=48,M=34;l=53;C=12,m=7,g=36,["\050"]=20,["\047"]=23;V=56;R=41,w=49;z=54;["\055"]=25;y=13;Y=9,["\053"]=58,E=17;b=32;F=42,K=59,W=55;J=52,o=63,h=45;H=30,A=0;k=51,["\051"]=60,n=14;N=10,i=1;S=8,t=61;P=57,f=31,Q=2,["\052"]=29,["\054"]=6,B=47;["\056"]=24}local O=type local s=string.char local q=string.len local A=table.insert for R=1,#G,1 do local f=G[R]if O(f)=="\115\116\114\105\110\103"then local O=q(f)local W={}local o=1 local u=0 local U=0 while o<=O do local R=M(f,o,o)local G=i[R]if G then u=u+G*64^(3-U)U=U+1 if U==4 then U=0 local R=b(u/65536)local M=b((u%65536)/256)local G=u%256 A(W,s(R,M,G))u=0 end elseif R=="\061"then A(W,s(b(u/65536)))if o>=O or M(f,o+1,o+1)~="\061"then A(W,s(b((u%65536)/256)))end break end o=o+1 end G[R]=I(W)end end end return(function(R,I,b,i,O,s,q,h,f,l,G,o,U,u,A,W)l,G,o,u,f,A,U,h,W=function(R)f[R]=f[R]-1 if f[R]==0 then f[R],A[R]=nil,nil end end,function(G,b,i,O)local A,W,J,a,q,o,F,j,U,e,h,f,l,u while G do A=b q=M(17799)G=R[q]f=G q=M(17794)G=R[q]q=M(17801)W=G G=f[q]o=G q=M(17793)G=o[q]u=G q=M(17805)G=o[q]U=G q=M(17803)G=o[q]l=G q=M(17791)G=f[q]F=M(17808)q=M(17807)h=G G=f[q]j=G q=M(17804)l=nil G=R[q]u=nil j=nil q=G()o=nil a=M(17808)f=nil e=q q=h[F]e=nil F=M(17796)G=q[F]J=M(17808)q=h[a]a=M(17792)F=G G=q[a]a=G W=nil q=h[J]a=nil J=M(17798)G=q[J]F=nil h=nil U=nil q={}J=G G=R[M(17800)]J=nil end G=#O return I(q)end,0,function(R)for M=1,#R,1 do f[R[M]]=1+f[R[M]]end if b then local G=b(true)local I=O(G)I[M(17806)],I[M(17797)],I[M(17802)]=R,U,function()return-2557646 end return G else return i({},{[M(17797)]=U;[M(17806)]=R;[M(17802)]=function()return-2557646 end})end end,{},{},function(R)local M,G=1,R[1]while G do f[G],M=f[G]-1,M+1 if f[G]==0 then f[G],A[G]=nil,nil end G=R[M]end end,function(R,M)local I=u(M)local b=function(...)return G(R,{...},M,I)end return b end,function()o=o+1 f[o]=1 return o end return(h(4000890,{}))(I(q))end)(getfenv and getfenv()or _ENV,unpack or table[M(17795)],newproxy,setmetatable,getmetatable,select,{...})end)(...)