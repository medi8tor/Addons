local u,j="\076\105\098\083\116\117\098",2 local R=_G[u]if not R or R.minor<j then R=R or{libs={};minors={}}_G[u]=R R.minor=j function R.NewLibrary(R,u,j)assert(type(u)=="\115\116\114\105\110\103","\066\097\100 \097\114\103\117\109\101\110\116 \035\050 \116\111 \096\078\101\119\076\105\098\114\097\114\121\' \040\115\116\114\105\110\103 \101\120\112\101\099\116\101\100\041")j=assert(tonumber(strmatch(j,"\037\100\043")),"\077\105\110\111\114 \118\101\114\115\105\111\110 \109\117\115\116 \101\105\116\104\101\114 \098\101 \097 \110\117\109\098\101\114 \111\114 \099\111\110\116\097\105\110 \097 \110\117\109\098\101\114\046")local h=R.minors[u]if h and h>=j then return nil end R.minors[u],R.libs[u]=j,R.libs[u]or{}return R.libs[u],h end function R.GetLibrary(R,u,j)if not R.libs[u]and not j then error(("\067\097\110\110\111\116 \102\105\110\100 \097 \108\105\098\114\097\114\121 \105\110\115\116\097\110\099\101 \111\102 \037\113\046"):format(tostring(u)),2)end return R.libs[u],R.minors[u]end function R.IterateLibraries(u)return pairs(u.libs)end setmetatable(R,{__call=R.GetLibrary})end local function h()local u,j="\067\097\108\108\098\097\099\107\072\097\110\100\108\101\114-\049\046\048",8 local h=R:NewLibrary(u,j)if not h then return end local Y={__index=function(u,j)u[j]={}return u[j]end}local C,q=securecallfunction,error local G,a=setmetatable,rawget local g,z,Z,l,A=next,select,pairs,type,tostring local function c(u,...)local j,R=g(u)if not R then return end repeat C(R,...)j,R=g(u,j)until not R end function h.New(u,j,R,h,C)R=R or"\082\101\103\105\115\116\101\114\067\097\108\108\098\097\099\107"h=h or"\085\110\114\101\103\105\115\116\101\114\067\097\108\108\098\097\099\107"if C==nil then C="\085\110\114\101\103\105\115\116\101\114\065\108\108\067\097\108\108\098\097\099\107\115"end local P=G({},Y)local N={recurse=0,events=P}function N.Fire(R,u,...)if not a(P,u)or not g(P[u])then return end local h=N.recurse N.recurse=h+1 c(P[u],u,...)N.recurse=h if N.insertQueue and h==0 then for u,R in Z(N.insertQueue)do local h=not a(P,u)or not g(P[u])for R,Y in Z(R)do P[u][R]=Y if h and N.OnUsed then N.OnUsed(N,j,u)h=nil end end end N.insertQueue=nil end end j[R]=function(u,h,C,...)if l(h)~="\115\116\114\105\110\103"then q("\085\115\097\103\101\058 "..(R.."\040\101\118\101\110\116\110\097\109\101\044 \109\101\116\104\111\100\091\044 \097\114\103\093\041\058 \'\101\118\101\110\116\110\097\109\101\' - \115\116\114\105\110\103 \101\120\112\101\099\116\101\100\046"),2)end C=C or h local Z=not a(P,h)or not g(P[h])if l(C)~="\115\116\114\105\110\103"and l(C)~="\102\117\110\099\116\105\111\110"then q("\085\115\097\103\101\058 "..(R.."\040\"\101\118\101\110\116\110\097\109\101\"\044 \"\109\101\116\104\111\100\110\097\109\101\"\041\058 \'\109\101\116\104\111\100\110\097\109\101\' - \115\116\114\105\110\103 \111\114 \102\117\110\099\116\105\111\110 \101\120\112\101\099\116\101\100\046"),2)end local c if l(C)=="\115\116\114\105\110\103"then if l(u)~="\116\097\098\108\101"then q("\085\115\097\103\101\058 "..(R.."\040\"\101\118\101\110\116\110\097\109\101\"\044 \"\109\101\116\104\111\100\110\097\109\101\"\041\058 \115\101\108\102 \119\097\115 \110\111\116 \097 \116\097\098\108\101\063"),2)elseif u==j then q("\085\115\097\103\101\058 "..(R..("\040\"\101\118\101\110\116\110\097\109\101\"\044 \"\109\101\116\104\111\100\110\097\109\101\"\041\058 \100\111 \110\111\116 \117\115\101 \076\105\098\114\097\114\121\058"..(R.."\040\041\044 \117\115\101 \121\111\117\114 \111\119\110 \'\115\101\108\102\'"))),2)elseif l(u[C])~="\102\117\110\099\116\105\111\110"then q("\085\115\097\103\101\058 "..(R..("\040\"\101\118\101\110\116\110\097\109\101\"\044 \"\109\101\116\104\111\100\110\097\109\101\"\041\058 \'\109\101\116\104\111\100\110\097\109\101\' - \109\101\116\104\111\100 \'"..(A(C).."\' \110\111\116 \102\111\117\110\100 \111\110 \115\101\108\102\046"))),2)end if z("\035",...)>=1 then local j=z(1,...)c=function(...)u[C](u,j,...)end else c=function(...)u[C](u,...)end end else if l(u)~="\116\097\098\108\101"and(l(u)~="\115\116\114\105\110\103"and l(u)~="\116\104\114\101\097\100")then q("\085\115\097\103\101\058 "..(R.."\040\115\101\108\102 \111\114 \"\097\100\100\111\110\073\100\"\044 \101\118\101\110\116\110\097\109\101\044 \109\101\116\104\111\100\041\058 \'\115\101\108\102 \111\114 \097\100\100\111\110\073\100\'\058 \116\097\098\108\101 \111\114 \115\116\114\105\110\103 \111\114 \116\104\114\101\097\100 \101\120\112\101\099\116\101\100\046"),2)end if z("\035",...)>=1 then local u=z(1,...)c=function(...)C(u,...)end else c=C end end if P[h][u]or N.recurse<1 then P[h][u]=c if N.OnUsed and Z then N.OnUsed(N,j,h)end else N.insertQueue=N.insertQueue or G({},Y)N.insertQueue[h][u]=c end end j[h]=function(u,R)if not u or u==j then q("\085\115\097\103\101\058 "..(h.."\040\101\118\101\110\116\110\097\109\101\041\058 \098\097\100 \'\115\101\108\102\'"),2)end if l(R)~="\115\116\114\105\110\103"then q("\085\115\097\103\101\058 "..(h.."\040\101\118\101\110\116\110\097\109\101\041\058 \'\101\118\101\110\116\110\097\109\101\' - \115\116\114\105\110\103 \101\120\112\101\099\116\101\100\046"),2)end if a(P,R)and P[R][u]then P[R][u]=nil if N.OnUnused and not g(P[R])then N.OnUnused(N,j,R)end end if N.insertQueue and(a(N.insertQueue,R)and N.insertQueue[R][u])then N.insertQueue[R][u]=nil end end if C then j[C]=function(...)if z("\035",...)<1 then q("\085\115\097\103\101\058 "..(C.."\040\091\119\104\097\116\070\111\114\093\041\058 \109\105\115\115\105\110\103 \'\115\101\108\102\' \111\114 \"\097\100\100\111\110\073\100\" \116\111 \117\110\114\101\103\105\115\116\101\114 \101\118\101\110\116\115 \102\111\114\046"),2)end if z("\035",...)==1 and...==j then q("\085\115\097\103\101\058 "..(C.."\040\091\119\104\097\116\070\111\114\093\041\058 \115\117\112\112\108\121 \097 \109\101\097\110\105\110\103\102\117\108 \'\115\101\108\102\' \111\114 \"\097\100\100\111\110\073\100\""),2)end for u=1,z("\035",...),1 do local R=z(u,...)if N.insertQueue then for u,j in Z(N.insertQueue)do if j[R]then j[R]=nil end end end for u,h in Z(P)do if h[R]then h[R]=nil if N.OnUnused and not g(h)then N.OnUnused(N,j,u)end end end end end end return N end end h()local function Y()assert(R,"\076\105\098\068\097\116\097\066\114\111\107\101\114-\049\046\049 \114\101\113\117\105\114\101\115 \076\105\098\083\116\117\098")assert(R:GetLibrary("\067\097\108\108\098\097\099\107\072\097\110\100\108\101\114-\049\046\048",true),"\076\105\098\068\097\116\097\066\114\111\107\101\114-\049\046\049 \114\101\113\117\105\114\101\115 \067\097\108\108\098\097\099\107\072\097\110\100\108\101\114-\049\046\048")local u,j=R:NewLibrary("\076\105\098\068\097\116\097\066\114\111\107\101\114-\049\046\049",4)if not u then return end j=j or 0 u.callbacks=u.callbacks or(R:GetLibrary("\067\097\108\108\098\097\099\107\072\097\110\100\108\101\114-\049\046\048")):New(u)u.attributestorage,u.namestorage,u.proxystorage=u.attributestorage or{},u.namestorage or{},u.proxystorage or{}local h,Y,C=u.attributestorage,u.namestorage,u.callbacks if j<2 then u.domt={__metatable="\097\099\099\101\115\115 \100\101\110\105\101\100",__index=function(u,j)return h[u]and h[u][j]end}end if j<3 then u.domt.__newindex=function(u,j,R)if not h[u]then h[u]={}end if h[u][j]==R then return end h[u][j]=R local q=Y[u]if not q then return end C:Fire("\076\105\098\068\097\116\097\066\114\111\107\101\114\095\065\116\116\114\105\098\117\116\101\067\104\097\110\103\101\100",q,j,R,u)C:Fire("\076\105\098\068\097\116\097\066\114\111\107\101\114\095\065\116\116\114\105\098\117\116\101\067\104\097\110\103\101\100\095"..q,q,j,R,u)C:Fire("\076\105\098\068\097\116\097\066\114\111\107\101\114\095\065\116\116\114\105\098\117\116\101\067\104\097\110\103\101\100\095"..(q..("\095"..j)),q,j,R,u)C:Fire("\076\105\098\068\097\116\097\066\114\111\107\101\114\095\065\116\116\114\105\098\117\116\101\067\104\097\110\103\101\100\095\095"..j,q,j,R,u)end end if j<2 then function u.NewDataObject(R,u,j)if R.proxystorage[u]then return end if j then assert(type(j)=="\116\097\098\108\101","\073\110\118\097\108\105\100 \100\097\116\097\111\098\106\044 \109\117\115\116 \098\101 \110\105\108 \111\114 \097 \116\097\098\108\101")R.attributestorage[j]={}for u,h in pairs(j)do R.attributestorage[j][u]=h j[u]=nil end end j=setmetatable(j or{},R.domt)R.proxystorage[u],R.namestorage[j]=j,u R.callbacks:Fire("\076\105\098\068\097\116\097\066\114\111\107\101\114\095\068\097\116\097\079\098\106\101\099\116\067\114\101\097\116\101\100",u,j)return j end end if j<1 then function u.DataObjectIterator(u)return pairs(u.proxystorage)end function u.GetDataObjectByName(j,u)return j.proxystorage[u]end function u.GetNameByDataObject(j,u)return j.namestorage[u]end end if j<4 then local j=pairs(h)function u.pairs(R,u)local Y=type(u)assert(Y=="\115\116\114\105\110\103"or Y=="\116\097\098\108\101","\085\115\097\103\101\058 \108\100\098\058\112\097\105\114\115\040\'\100\097\116\097\111\098\106\101\099\116\110\097\109\101\'\041 \111\114 \108\100\098\058\112\097\105\114\115\040\100\097\116\097\111\098\106\101\099\116\041")local C=R.proxystorage[u]or u assert(h[C],"\068\097\116\097 \111\098\106\101\099\116 \110\111\116 \102\111\117\110\100")return j,h[C],nil end local R=ipairs(h)function u.ipairs(j,u)local Y=type(u)assert(Y=="\115\116\114\105\110\103"or Y=="\116\097\098\108\101","\085\115\097\103\101\058 \108\100\098\058\105\112\097\105\114\115\040\'\100\097\116\097\111\098\106\101\099\116\110\097\109\101\'\041 \111\114 \108\100\098\058\105\112\097\105\114\115\040\100\097\116\097\111\098\106\101\099\116\041")local C=j.proxystorage[u]or u assert(h[C],"\068\097\116\097 \111\098\106\101\099\116 \110\111\116 \102\111\117\110\100")return R,h[C],0 end end end Y()local function C()local u="\076\105\098\068\066\073\099\111\110-\049\046\048"local j=51 if not R then error(u.." \114\101\113\117\105\114\101\115 \076\105\098\083\116\117\098\046")end local h=R("\076\105\098\068\097\116\097\066\114\111\107\101\114-\049\046\049",true)if not h then error(u.." \114\101\113\117\105\114\101\115 \076\105\098\068\097\116\097\066\114\111\107\101\114-\049\046\049\046")end local Y=R:NewLibrary(u,j)if not Y then return end Y.objects=Y.objects or{}Y.callbackRegistered=Y.callbackRegistered or nil Y.callbacks=Y.callbacks or(R("\067\097\108\108\098\097\099\107\072\097\110\100\108\101\114-\049\046\048")):New(Y)Y.radius=Y.radius or 5 local C,q,G,a=next,Minimap,CreateFrame,AddonCompartmentFrame Y.tooltip=Y.tooltip or G("\071\097\109\101\084\111\111\108\116\105\112","\076\105\098\068\066\073\099\111\110\084\111\111\108\116\105\112",UIParent,"\071\097\109\101\084\111\111\108\116\105\112\084\101\109\112\108\097\116\101")local g=false function Y.IconCallback(C,u,j,R,h)if Y.objects[j]then if R=="\105\099\111\110"then Y.objects[j].icon:SetTexture(h)elseif R=="\105\099\111\110\067\111\111\114\100\115"then Y.objects[j].icon:UpdateCoord()elseif R=="\105\099\111\110\082"then local u,R,C=Y.objects[j].icon:GetVertexColor()Y.objects[j].icon:SetVertexColor(h,R,C)elseif R=="\105\099\111\110\071"then local u,R,C=Y.objects[j].icon:GetVertexColor()Y.objects[j].icon:SetVertexColor(u,h,C)elseif R=="\105\099\111\110\066"then local u,R=Y.objects[j].icon:GetVertexColor()Y.objects[j].icon:SetVertexColor(u,R,h)end end end if not Y.callbackRegistered then h.RegisterCallback(Y,"\076\105\098\068\097\116\097\066\114\111\107\101\114\095\065\116\116\114\105\098\117\116\101\067\104\097\110\103\101\100\095\095\105\099\111\110","\073\099\111\110\067\097\108\108\098\097\099\107")h.RegisterCallback(Y,"\076\105\098\068\097\116\097\066\114\111\107\101\114\095\065\116\116\114\105\098\117\116\101\067\104\097\110\103\101\100\095\095\105\099\111\110\067\111\111\114\100\115","\073\099\111\110\067\097\108\108\098\097\099\107")h.RegisterCallback(Y,"\076\105\098\068\097\116\097\066\114\111\107\101\114\095\065\116\116\114\105\098\117\116\101\067\104\097\110\103\101\100\095\095\105\099\111\110\082","\073\099\111\110\067\097\108\108\098\097\099\107")h.RegisterCallback(Y,"\076\105\098\068\097\116\097\066\114\111\107\101\114\095\065\116\116\114\105\098\117\116\101\067\104\097\110\103\101\100\095\095\105\099\111\110\071","\073\099\111\110\067\097\108\108\098\097\099\107")h.RegisterCallback(Y,"\076\105\098\068\097\116\097\066\114\111\107\101\114\095\065\116\116\114\105\098\117\116\101\067\104\097\110\103\101\100\095\095\105\099\111\110\066","\073\099\111\110\067\097\108\108\098\097\099\107")Y.callbackRegistered=true end local function z(u)local j,R=u:GetCenter()if not j or not R then return"\067\069\078\084\069\082"end local h=j>(UIParent:GetWidth()*2)/3 and"\082\073\071\072\084"or j<UIParent:GetWidth()/3 and"\076\069\070\084"or""local Y=R>UIParent:GetHeight()/2 and"\084\079\080"or"\066\079\084\084\079\077"return Y..h,u,(Y=="\084\079\080"and"\066\079\084\084\079\077"or"\084\079\080")..h end local function Z(u)if g then return end for u,j in C,Y.objects do if j.showOnMouseover then j.fadeOut:Stop()j:SetAlpha(1)end end local j=u.dataObject if j.OnTooltipShow then Y.tooltip:SetOwner(u,"\065\078\067\072\079\082\095\078\079\078\069")Y.tooltip:SetPoint(z(u))j.OnTooltipShow(Y.tooltip)Y.tooltip:Show()elseif j.OnEnter then j.OnEnter(u)end end local function l(u)Y.tooltip:Hide()if not g then for u,j in C,Y.objects do if j.showOnMouseover then j.fadeOut:Play()end end end local j=u.dataObject if j.OnLeave then j.OnLeave(u)end end local function A(u)local j=u.value local R=Y.objects[j]if R and R.dataObject then if R.dataObject.OnTooltipShow then Y.tooltip:SetOwner(u,"\065\078\067\072\079\082\095\078\079\078\069")Y.tooltip:SetPoint(z(u))R.dataObject.OnTooltipShow(Y.tooltip)Y.tooltip:Show()elseif R.dataObject.OnEnter then R.dataObject.OnEnter(u)end end end local function c(u)Y.tooltip:Hide()local j=u.value local R=Y.objects[j]if R and R.dataObject then if R.dataObject.OnLeave then R.dataObject.OnLeave(u)end end end local P,N do local u={ROUND={true;true;true,true},SQUARE={false;false,false;false},["\067\079\082\078\069\082-\084\079\080\076\069\070\084"]={false,false,false,true},["\067\079\082\078\069\082-\084\079\080\082\073\071\072\084"]={false,false;true,false},["\067\079\082\078\069\082-\066\079\084\084\079\077\076\069\070\084"]={false,true;false;false};["\067\079\082\078\069\082-\066\079\084\084\079\077\082\073\071\072\084"]={true,false;false;false};["\083\073\068\069-\076\069\070\084"]={false,true,false;true},["\083\073\068\069-\082\073\071\072\084"]={true,false;true,false},["\083\073\068\069-\084\079\080"]={false,false,true;true};["\083\073\068\069-\066\079\084\084\079\077"]={true,true,false;false};["\084\082\073\067\079\082\078\069\082-\084\079\080\076\069\070\084"]={false;true;true;true};["\084\082\073\067\079\082\078\069\082-\084\079\080\082\073\071\072\084"]={true,false,true;true},["\084\082\073\067\079\082\078\069\082-\066\079\084\084\079\077\076\069\070\084"]={true,true,false;true},["\084\082\073\067\079\082\078\069\082-\066\079\084\084\079\077\082\073\071\072\084"]={true;true,true;false}}local j,R,h,C,G,a=math.rad,math.cos,math.sin,math.sqrt,math.max,math.min function N(g,z)local Z=j(z or 225)local l,A,c=R(Z),h(Z),1 if l<0 then c=c+1 end if A>0 then c=c+2 end local P=GetMinimapShape and GetMinimapShape()or"\082\079\085\078\068"local N=u[P]local n=q:GetWidth()/2+Y.radius local E=q:GetHeight()/2+Y.radius if N[c]then l,A=l*n,A*E else local u=C(2*n^2)-10 local j=C(2*E^2)-10 l=G(-n,a(l*u,n))A=G(-E,a(A*j,E))end g:SetPoint("\067\069\078\084\069\082",q,"\067\069\078\084\069\082",l,A)end end local function n(u,j)if u.dataObject.OnClick then u.dataObject.OnClick(u,j)end end local function E(u)u.isMouseDown=true u.icon:UpdateCoord()end local function X(u)u.isMouseDown=false u.icon:UpdateCoord()end do local u,j=math.deg,math.atan2 local function R(R)local h,Y=q:GetCenter()local C,G=GetCursorPosition()local a=q:GetEffectiveScale()C,G=C/a,G/a local g=225 if R.db then g=u(j(G-Y,C-h))%360 R.db.minimapPos=g else g=u(j(G-Y,C-h))%360 R.minimapPos=g end N(R,g)end function P(u)u:LockHighlight()u.isMouseDown=true u.icon:UpdateCoord()u:SetScript("\079\110\085\112\100\097\116\101",R)g=true Y.tooltip:Hide()for u,j in C,Y.objects do if j.showOnMouseover then j.fadeOut:Stop()j:SetAlpha(1)end end end end local function x(u)u:SetScript("\079\110\085\112\100\097\116\101",nil)u.isMouseDown=false u.icon:UpdateCoord()u:UnlockHighlight()g=false for u,j in C,Y.objects do if j.showOnMouseover then j.fadeOut:Play()end end end local b={0,1,0;1}local function W(u)local j=(u:GetParent()).dataObject.iconCoords or b local R,h=0,0 if not(u:GetParent()).isMouseDown then R=(j[2]-j[1])*.05 h=(j[4]-j[3])*.05 end u:SetTexCoord(j[1]+R,j[2]-R,j[3]+h,j[4]-h)end local function U(u,j,R,h)local C=G("\066\117\116\116\111\110","\076\105\098\068\066\073\099\111\110\049\048\095"..u,q)C.dataObject=j C.db=R C:SetFrameStrata("\077\069\068\073\085\077")C:SetFixedFrameStrata(true)C:SetFrameLevel(8)C:SetFixedFrameLevel(true)C:SetSize(31,31)C:RegisterForClicks("\097\110\121\085\112")C:RegisterForDrag("\076\101\102\116\066\117\116\116\111\110")C:SetHighlightTexture(136477)if WOW_PROJECT_ID==WOW_PROJECT_MAINLINE then local u=C:CreateTexture(nil,"\079\086\069\082\076\065\089")u:SetSize(50,50)u:SetTexture(136430)u:SetPoint("\084\079\080\076\069\070\084",C,"\084\079\080\076\069\070\084",0,0)local R=C:CreateTexture(nil,"\066\065\067\075\071\082\079\085\078\068")R:SetSize(24,24)R:SetTexture(136467)R:SetPoint("\067\069\078\084\069\082",C,"\067\069\078\084\069\082",0,1)local h=C:CreateTexture(nil,"\065\082\084\087\079\082\075")h:SetSize(18,18)h:SetTexture(j.icon)h:SetPoint("\067\069\078\084\069\082",C,"\067\069\078\084\069\082",0,1)C.icon=h else local u=C:CreateTexture(nil,"\079\086\069\082\076\065\089")u:SetSize(53,53)u:SetTexture(136430)u:SetPoint("\084\079\080\076\069\070\084")local R=C:CreateTexture(nil,"\066\065\067\075\071\082\079\085\078\068")R:SetSize(20,20)R:SetTexture(136467)R:SetPoint("\084\079\080\076\069\070\084",7,-5)local h=C:CreateTexture(nil,"\065\082\084\087\079\082\075")h:SetSize(17,17)h:SetTexture(j.icon)h:SetPoint("\084\079\080\076\069\070\084",7,-6)C.icon=h end C.isMouseDown=false local a,g,z=C.icon:GetVertexColor()C.icon:SetVertexColor(j.iconR or a,j.iconG or g,j.iconB or z)C.icon.UpdateCoord=W C.icon:UpdateCoord()C:SetScript("\079\110\069\110\116\101\114",Z)C:SetScript("\079\110\076\101\097\118\101",l)C:SetScript("\079\110\067\108\105\099\107",n)if not R or not R.lock then C:SetScript("\079\110\068\114\097\103\083\116\097\114\116",P)C:SetScript("\079\110\068\114\097\103\083\116\111\112",x)end C:SetScript("\079\110\077\111\117\115\101\068\111\119\110",E)C:SetScript("\079\110\077\111\117\115\101\085\112",X)C.fadeOut=C:CreateAnimationGroup()local A=C.fadeOut:CreateAnimation("\065\108\112\104\097")A:SetOrder(1)A:SetDuration(.2)A:SetFromAlpha(1)A:SetToAlpha(0)A:SetStartDelay(1)C.fadeOut:SetToFinalAlpha(true)Y.objects[u]=C if Y.loggedIn then N(C,R and R.minimapPos)if not R or not R.hide then C:Show()else C:Hide()end end if R and R.showInCompartment then Y:AddButtonToCompartment(u,h)end Y.callbacks:Fire("\076\105\098\068\066\073\099\111\110\095\073\099\111\110\067\114\101\097\116\101\100",C,u)end if not Y.loggedIn then local u=G("\070\114\097\109\101")u:SetScript("\079\110\069\118\101\110\116",function(u)for u,j in C,Y.objects do N(j,j.db and j.db.minimapPos)if not j.db or not j.db.hide then j:Show()else j:Hide()end end Y.loggedIn=true u:SetScript("\079\110\069\118\101\110\116",nil)end)u:RegisterEvent("\080\076\065\089\069\082\095\076\079\071\073\078")end do local function u()if g then return end for u,j in C,Y.objects do if j.showOnMouseover then j.fadeOut:Stop()j:SetAlpha(1)end end end local function j()if g then return end for u,j in C,Y.objects do if j.showOnMouseover then j.fadeOut:Play()end end end q:HookScript("\079\110\069\110\116\101\114",u)q:HookScript("\079\110\076\101\097\118\101",j)end function Y.Register(q,j,R,h,C)if not R.icon then error("\067\097\110\'\116 \114\101\103\105\115\116\101\114 \076\068\066 \111\098\106\101\099\116\115 \119\105\116\104\111\117\116 \105\099\111\110\115 \115\101\116\033")end if Y:GetMinimapButton(j)then error(u..("\058 \079\098\106\101\099\116 \'"..(j.."\' \105\115 \097\108\114\101\097\100\121 \114\101\103\105\115\116\101\114\101\100\046")))end U(j,R,h,C)end function Y.Lock(j,u)local R=Y:GetMinimapButton(u)if R then R:SetScript("\079\110\068\114\097\103\083\116\097\114\116",nil)R:SetScript("\079\110\068\114\097\103\083\116\111\112",nil)if R.db then R.db.lock=true end end end function Y.Unlock(j,u)local R=Y:GetMinimapButton(u)if R then R:SetScript("\079\110\068\114\097\103\083\116\097\114\116",P)R:SetScript("\079\110\068\114\097\103\083\116\111\112",x)if R.db then R.db.lock=nil end end end function Y.Hide(j,u)local R=Y:GetMinimapButton(u)if R then R:Hide()end end function Y.Show(j,u)local R=Y:GetMinimapButton(u)if R then R:Show()N(R,R.db and R.db.minimapPos or R.minimapPos)end end function Y.IsRegistered(j,u)return Y.objects[u]and true or false end function Y.Refresh(R,u,j)local h=Y:GetMinimapButton(u)if h then if j then h.db=j end N(h,h.db and h.db.minimapPos or h.minimapPos)if not h.db or not h.db.hide then h:Show()else h:Hide()end if not h.db or not h.db.lock then h:SetScript("\079\110\068\114\097\103\083\116\097\114\116",P)h:SetScript("\079\110\068\114\097\103\083\116\111\112",x)else h:SetScript("\079\110\068\114\097\103\083\116\097\114\116",nil)h:SetScript("\079\110\068\114\097\103\083\116\111\112",nil)end end end function Y.ShowOnEnter(R,u,j)local h=Y:GetMinimapButton(u)if h then if j then h.showOnMouseover=true h.fadeOut:Stop()h:SetAlpha(0)else h.showOnMouseover=false h.fadeOut:Stop()h:SetAlpha(1)end end end function Y.GetMinimapButton(j,u)return Y.objects[u]end function Y.GetButtonList(u)local j={}for u in C,Y.objects do j[#j+1]=u end return j end function Y.SetButtonRadius(j,u)if type(u)=="\110\117\109\098\101\114"then Y.radius=u for u,j in C,Y.objects do N(j,j.db and j.db.minimapPos or j.minimapPos)end end end function Y.SetButtonToPosition(R,u,j)N(Y.objects[u]or u,j)end function Y.IsButtonCompartmentAvailable(u)if a then return true end end function Y.IsButtonInCompartment(j,u)local R=Y.objects[u]if R and(R.db and R.db.showInCompartment)then return true end return false end function Y.AddButtonToCompartment(R,u,j)local h=Y.objects[u]if h and(not h.compartmentData and a)then if h.db then h.db.showInCompartment=true end h.compartmentData={text=u,icon=j or h.dataObject.icon;notCheckable=true;registerForAnyClick=true,func=function(u,j,R,Y,C)h.dataObject.OnClick(u,C)end,funcOnEnter=A,funcOnLeave=c}a:RegisterAddon(h.compartmentData)end end function Y.RemoveButtonFromCompartment(j,u)local R=Y.objects[u]if R and R.compartmentData then for u=1,#a.registeredAddons,1 do local j=a.registeredAddons[u]if j==R.compartmentData then R.compartmentData=nil if R.db then R.db.showInCompartment=nil end table.remove(a.registeredAddons,u)a:UpdateDisplay()return end end end end for u,j in C,Y.objects do local R=j.db if not R or not R.lock then j:SetScript("\079\110\068\114\097\103\083\116\097\114\116",P)j:SetScript("\079\110\068\114\097\103\083\116\111\112",x)end j:SetScript("\079\110\069\110\116\101\114",Z)j:SetScript("\079\110\076\101\097\118\101",l)j:SetScript("\079\110\067\108\105\099\107",n)j:SetScript("\079\110\077\111\117\115\101\068\111\119\110",E)j:SetScript("\079\110\077\111\117\115\101\085\112",X)if not j.fadeOut then j.fadeOut=j:CreateAnimationGroup()local u=j.fadeOut:CreateAnimation("\065\108\112\104\097")u:SetOrder(1)u:SetDuration(.2)u:SetFromAlpha(1)u:SetToAlpha(0)u:SetStartDelay(1)j.fadeOut:SetToFinalAlpha(true)end end Y:SetButtonRadius(Y.radius)if Y.notCreated then for u in C,Y.notCreated do U(u,Y.notCreated[u][1],Y.notCreated[u][2])end Y.notCreated=nil end end C()