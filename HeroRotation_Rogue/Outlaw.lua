local StrToNumber = tonumber;
local Byte = string.byte;
local Char = string.char;
local Sub = string.sub;
local Subg = string.gsub;
local Rep = string.rep;
local Concat = table.concat;
local Insert = table.insert;
local LDExp = math.ldexp;
local GetFEnv = getfenv or function()
	return _ENV;
end;
local Setmetatable = setmetatable;
local PCall = pcall;
local Select = select;
local Unpack = unpack or table.unpack;
local ToNumber = tonumber;
local function VMCall(ByteString, vmenv, ...)
	local DIP = 1;
	local repeatNext;
	ByteString = Subg(Sub(ByteString, 5), "..", function(byte)
		if (Byte(byte, 2) == 81) then
			repeatNext = StrToNumber(Sub(byte, 1, 1));
			return "";
		else
			local a = Char(StrToNumber(byte, 16));
			if repeatNext then
				local b = Rep(a, repeatNext);
				repeatNext = nil;
				return b;
			else
				return a;
			end
		end
	end);
	local function gBit(Bit, Start, End)
		if End then
			local Res = (Bit / (2 ^ (Start - 1))) % (2 ^ (((End - 1) - (Start - 1)) + 1));
			return Res - (Res % 1);
		else
			local Plc = 2 ^ (Start - 1);
			return (((Bit % (Plc + Plc)) >= Plc) and 1) or 0;
		end
	end
	local function gBits8()
		local a = Byte(ByteString, DIP, DIP);
		DIP = DIP + 1;
		return a;
	end
	local function gBits16()
		local a, b = Byte(ByteString, DIP, DIP + 2);
		DIP = DIP + 2;
		return (b * 256) + a;
	end
	local function gBits32()
		local a, b, c, d = Byte(ByteString, DIP, DIP + 3);
		DIP = DIP + 4;
		return (d * 16777216) + (c * 65536) + (b * 256) + a;
	end
	local function gFloat()
		local Left = gBits32();
		local Right = gBits32();
		local IsNormal = 1;
		local Mantissa = (gBit(Right, 1, 20) * (2 ^ 32)) + Left;
		local Exponent = gBit(Right, 21, 31);
		local Sign = ((gBit(Right, 32) == 1) and -1) or 1;
		if (Exponent == 0) then
			if (Mantissa == 0) then
				return Sign * 0;
			else
				Exponent = 1;
				IsNormal = 0;
			end
		elseif (Exponent == 2047) then
			return ((Mantissa == 0) and (Sign * (1 / 0))) or (Sign * NaN);
		end
		return LDExp(Sign, Exponent - 1023) * (IsNormal + (Mantissa / (2 ^ 52)));
	end
	local function gString(Len)
		local Str;
		if not Len then
			Len = gBits32();
			if (Len == 0) then
				return "";
			end
		end
		Str = Sub(ByteString, DIP, (DIP + Len) - 1);
		DIP = DIP + Len;
		local FStr = {};
		for Idx = 1, #Str do
			FStr[Idx] = Char(Byte(Sub(Str, Idx, Idx)));
		end
		return Concat(FStr);
	end
	local gInt = gBits32;
	local function _R(...)
		return {...}, Select("#", ...);
	end
	local function Deserialize()
		local Instrs = {};
		local Functions = {};
		local Lines = {};
		local Chunk = {Instrs,Functions,nil,Lines};
		local ConstCount = gBits32();
		local Consts = {};
		for Idx = 1, ConstCount do
			local Type = gBits8();
			local Cons;
			if (Type == 1) then
				Cons = gBits8() ~= 0;
			elseif (Type == 2) then
				Cons = gFloat();
			elseif (Type == 3) then
				Cons = gString();
			end
			Consts[Idx] = Cons;
		end
		Chunk[3] = gBits8();
		for Idx = 1, gBits32() do
			local Descriptor = gBits8();
			if (gBit(Descriptor, 1, 1) == 0) then
				local Type = gBit(Descriptor, 2, 3);
				local Mask = gBit(Descriptor, 4, 6);
				local Inst = {gBits16(),gBits16(),nil,nil};
				if (Type == 0) then
					Inst[3] = gBits16();
					Inst[4] = gBits16();
				elseif (Type == 1) then
					Inst[3] = gBits32();
				elseif (Type == 2) then
					Inst[3] = gBits32() - (2 ^ 16);
				elseif (Type == 3) then
					Inst[3] = gBits32() - (2 ^ 16);
					Inst[4] = gBits16();
				end
				if (gBit(Mask, 1, 1) == 1) then
					Inst[2] = Consts[Inst[2]];
				end
				if (gBit(Mask, 2, 2) == 1) then
					Inst[3] = Consts[Inst[3]];
				end
				if (gBit(Mask, 3, 3) == 1) then
					Inst[4] = Consts[Inst[4]];
				end
				Instrs[Idx] = Inst;
			end
		end
		for Idx = 1, gBits32() do
			Functions[Idx - 1] = Deserialize();
		end
		return Chunk;
	end
	local function Wrap(Chunk, Upvalues, Env)
		local Instr = Chunk[1];
		local Proto = Chunk[2];
		local Params = Chunk[3];
		return function(...)
			local Instr = Instr;
			local Proto = Proto;
			local Params = Params;
			local _R = _R;
			local VIP = 1;
			local Top = -1;
			local Vararg = {};
			local Args = {...};
			local PCount = Select("#", ...) - 1;
			local Lupvals = {};
			local Stk = {};
			for Idx = 0, PCount do
				if (Idx >= Params) then
					Vararg[Idx - Params] = Args[Idx + 1];
				else
					Stk[Idx] = Args[Idx + 1];
				end
			end
			local Varargsz = (PCount - Params) + 1;
			local Inst;
			local Enum;
			while true do
				Inst = Instr[VIP];
				Enum = Inst[1];
				if (Enum <= 218) then
					if (Enum <= 108) then
						if (Enum <= 53) then
							if (Enum <= 26) then
								if (Enum <= 12) then
									if (Enum <= 5) then
										if (Enum <= 2) then
											if (Enum <= 0) then
												local B;
												local A;
												Stk[Inst[2]] = Upvalues[Inst[3]];
												VIP = VIP + 1;
												Inst = Instr[VIP];
												Stk[Inst[2]] = Upvalues[Inst[3]];
												VIP = VIP + 1;
												Inst = Instr[VIP];
												Stk[Inst[2]] = Inst[3];
												VIP = VIP + 1;
												Inst = Instr[VIP];
												Stk[Inst[2]] = Inst[3];
												VIP = VIP + 1;
												Inst = Instr[VIP];
												A = Inst[2];
												Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
												VIP = VIP + 1;
												Inst = Instr[VIP];
												Stk[Inst[2]] = Stk[Inst[3]][Stk[Inst[4]]];
												VIP = VIP + 1;
												Inst = Instr[VIP];
												A = Inst[2];
												B = Stk[Inst[3]];
												Stk[A + 1] = B;
												Stk[A] = B[Inst[4]];
												VIP = VIP + 1;
												Inst = Instr[VIP];
												A = Inst[2];
												Stk[A] = Stk[A](Stk[A + 1]);
												VIP = VIP + 1;
												Inst = Instr[VIP];
												if not Stk[Inst[2]] then
													VIP = VIP + 1;
												else
													VIP = Inst[3];
												end
											elseif (Enum > 1) then
												Stk[Inst[2]] = Stk[Inst[3]] - Stk[Inst[4]];
											else
												local Edx;
												local Results, Limit;
												local B;
												local A;
												Stk[Inst[2]] = Inst[3];
												VIP = VIP + 1;
												Inst = Instr[VIP];
												A = Inst[2];
												B = Stk[Inst[3]];
												Stk[A + 1] = B;
												Stk[A] = B[Stk[Inst[4]]];
												VIP = VIP + 1;
												Inst = Instr[VIP];
												Stk[Inst[2]] = Upvalues[Inst[3]];
												VIP = VIP + 1;
												Inst = Instr[VIP];
												Stk[Inst[2]] = Inst[3];
												VIP = VIP + 1;
												Inst = Instr[VIP];
												A = Inst[2];
												Results, Limit = _R(Stk[A](Stk[A + 1]));
												Top = (Limit + A) - 1;
												Edx = 0;
												for Idx = A, Top do
													Edx = Edx + 1;
													Stk[Idx] = Results[Edx];
												end
												VIP = VIP + 1;
												Inst = Instr[VIP];
												A = Inst[2];
												Stk[A] = Stk[A](Unpack(Stk, A + 1, Top));
												VIP = VIP + 1;
												Inst = Instr[VIP];
												Stk[Inst[2]] = Stk[Inst[3]];
												VIP = VIP + 1;
												Inst = Instr[VIP];
												if (Stk[Inst[2]] < Stk[Inst[4]]) then
													VIP = VIP + 1;
												else
													VIP = Inst[3];
												end
											end
										elseif (Enum <= 3) then
											local A;
											Env[Inst[3]] = Stk[Inst[2]];
											VIP = VIP + 1;
											Inst = Instr[VIP];
											Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
											VIP = VIP + 1;
											Inst = Instr[VIP];
											Stk[Inst[2]] = Inst[3];
											VIP = VIP + 1;
											Inst = Instr[VIP];
											Stk[Inst[2]] = Stk[Inst[3]];
											VIP = VIP + 1;
											Inst = Instr[VIP];
											Stk[Inst[2]] = Stk[Inst[3]];
											VIP = VIP + 1;
											Inst = Instr[VIP];
											A = Inst[2];
											Stk[A](Unpack(Stk, A + 1, Inst[3]));
											VIP = VIP + 1;
											Inst = Instr[VIP];
											do
												return;
											end
										elseif (Enum > 4) then
											local A;
											Stk[Inst[2]] = Upvalues[Inst[3]];
											VIP = VIP + 1;
											Inst = Instr[VIP];
											Stk[Inst[2]] = Inst[3];
											VIP = VIP + 1;
											Inst = Instr[VIP];
											Stk[Inst[2]] = Inst[3];
											VIP = VIP + 1;
											Inst = Instr[VIP];
											A = Inst[2];
											Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
											VIP = VIP + 1;
											Inst = Instr[VIP];
											Stk[Inst[2]] = Stk[Inst[3]][Stk[Inst[4]]];
											VIP = VIP + 1;
											Inst = Instr[VIP];
											Stk[Inst[2]] = Upvalues[Inst[3]];
											VIP = VIP + 1;
											Inst = Instr[VIP];
											Stk[Inst[2]] = Inst[3];
											VIP = VIP + 1;
											Inst = Instr[VIP];
											Stk[Inst[2]] = Inst[3];
											VIP = VIP + 1;
											Inst = Instr[VIP];
											A = Inst[2];
											Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
											VIP = VIP + 1;
											Inst = Instr[VIP];
											Stk[Inst[2]] = Stk[Inst[3]][Stk[Inst[4]]];
										else
											Stk[Inst[2]] = Stk[Inst[3]][Stk[Inst[4]]];
										end
									elseif (Enum <= 8) then
										if (Enum <= 6) then
											local Edx;
											local Results, Limit;
											local A;
											Stk[Inst[2]] = Upvalues[Inst[3]];
											VIP = VIP + 1;
											Inst = Instr[VIP];
											Stk[Inst[2]] = Inst[3];
											VIP = VIP + 1;
											Inst = Instr[VIP];
											Stk[Inst[2]] = Inst[3];
											VIP = VIP + 1;
											Inst = Instr[VIP];
											A = Inst[2];
											Results, Limit = _R(Stk[A](Unpack(Stk, A + 1, Inst[3])));
											Top = (Limit + A) - 1;
											Edx = 0;
											for Idx = A, Top do
												Edx = Edx + 1;
												Stk[Idx] = Results[Edx];
											end
											VIP = VIP + 1;
											Inst = Instr[VIP];
											A = Inst[2];
											Stk[A] = Stk[A](Unpack(Stk, A + 1, Top));
											VIP = VIP + 1;
											Inst = Instr[VIP];
											if not Stk[Inst[2]] then
												VIP = VIP + 1;
											else
												VIP = Inst[3];
											end
										elseif (Enum > 7) then
											local A;
											Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
											VIP = VIP + 1;
											Inst = Instr[VIP];
											Stk[Inst[2]] = Upvalues[Inst[3]];
											VIP = VIP + 1;
											Inst = Instr[VIP];
											Stk[Inst[2]] = Inst[3];
											VIP = VIP + 1;
											Inst = Instr[VIP];
											Stk[Inst[2]] = Stk[Inst[3]][Stk[Inst[4]]];
											VIP = VIP + 1;
											Inst = Instr[VIP];
											for Idx = Inst[2], Inst[3] do
												Stk[Idx] = nil;
											end
											VIP = VIP + 1;
											Inst = Instr[VIP];
											A = Inst[2];
											Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
											VIP = VIP + 1;
											Inst = Instr[VIP];
											if Stk[Inst[2]] then
												VIP = VIP + 1;
											else
												VIP = Inst[3];
											end
										else
											local B;
											local A;
											Stk[Inst[2]] = Inst[3];
											VIP = VIP + 1;
											Inst = Instr[VIP];
											A = Inst[2];
											B = Stk[Inst[3]];
											Stk[A + 1] = B;
											Stk[A] = B[Stk[Inst[4]]];
											VIP = VIP + 1;
											Inst = Instr[VIP];
											Stk[Inst[2]] = Upvalues[Inst[3]];
											VIP = VIP + 1;
											Inst = Instr[VIP];
											A = Inst[2];
											Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
											VIP = VIP + 1;
											Inst = Instr[VIP];
											for Idx = Inst[2], Inst[3] do
												Stk[Idx] = nil;
											end
											VIP = VIP + 1;
											Inst = Instr[VIP];
											Stk[Inst[2]] = Inst[3];
											VIP = VIP + 1;
											Inst = Instr[VIP];
											Stk[Inst[2]] = Inst[3];
											VIP = VIP + 1;
											Inst = Instr[VIP];
											Stk[Inst[2]] = Inst[3];
											VIP = VIP + 1;
											Inst = Instr[VIP];
											if (Stk[Inst[2]] < Stk[Inst[4]]) then
												VIP = VIP + 1;
											else
												VIP = Inst[3];
											end
										end
									elseif (Enum <= 10) then
										if (Enum == 9) then
											local B;
											local A;
											Stk[Inst[2]] = Upvalues[Inst[3]];
											VIP = VIP + 1;
											Inst = Instr[VIP];
											Stk[Inst[2]] = Inst[3];
											VIP = VIP + 1;
											Inst = Instr[VIP];
											Stk[Inst[2]] = Inst[3];
											VIP = VIP + 1;
											Inst = Instr[VIP];
											A = Inst[2];
											Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
											VIP = VIP + 1;
											Inst = Instr[VIP];
											Stk[Inst[2]] = Stk[Inst[3]][Stk[Inst[4]]];
											VIP = VIP + 1;
											Inst = Instr[VIP];
											A = Inst[2];
											B = Stk[Inst[3]];
											Stk[A + 1] = B;
											Stk[A] = B[Inst[4]];
											VIP = VIP + 1;
											Inst = Instr[VIP];
											A = Inst[2];
											Stk[A] = Stk[A](Stk[A + 1]);
											VIP = VIP + 1;
											Inst = Instr[VIP];
											if Stk[Inst[2]] then
												VIP = VIP + 1;
											else
												VIP = Inst[3];
											end
										else
											local A;
											A = Inst[2];
											Stk[A] = Stk[A](Stk[A + 1]);
											VIP = VIP + 1;
											Inst = Instr[VIP];
											Stk[Inst[2]] = Env[Inst[3]];
											VIP = VIP + 1;
											Inst = Instr[VIP];
											Stk[Inst[2]] = Upvalues[Inst[3]];
											VIP = VIP + 1;
											Inst = Instr[VIP];
											Stk[Inst[2]] = Inst[3];
											VIP = VIP + 1;
											Inst = Instr[VIP];
											Stk[Inst[2]] = Inst[3];
											VIP = VIP + 1;
											Inst = Instr[VIP];
											A = Inst[2];
											Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
											VIP = VIP + 1;
											Inst = Instr[VIP];
											Stk[Inst[2]] = Inst[3];
											VIP = VIP + 1;
											Inst = Instr[VIP];
											A = Inst[2];
											Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
											VIP = VIP + 1;
											Inst = Instr[VIP];
											if (Stk[Inst[2]] == Stk[Inst[4]]) then
												VIP = VIP + 1;
											else
												VIP = Inst[3];
											end
										end
									elseif (Enum == 11) then
										local A;
										Stk[Inst[2]] = Inst[3];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Inst[3];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										A = Inst[2];
										Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Stk[Inst[3]][Stk[Inst[4]]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Stk[Inst[3]][Stk[Inst[4]]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										if Stk[Inst[2]] then
											VIP = VIP + 1;
										else
											VIP = Inst[3];
										end
									else
										local A;
										Stk[Inst[2]] = Stk[Inst[3]][Stk[Inst[4]]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Upvalues[Inst[3]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Inst[3];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Inst[3];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										A = Inst[2];
										Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Stk[Inst[3]][Stk[Inst[4]]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Inst[3];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										A = Inst[2];
										Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Stk[Inst[3]] + Stk[Inst[4]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]][Stk[Inst[3]]] = Stk[Inst[4]];
									end
								elseif (Enum <= 19) then
									if (Enum <= 15) then
										if (Enum <= 13) then
											local A;
											Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
											VIP = VIP + 1;
											Inst = Instr[VIP];
											Stk[Inst[2]] = Inst[3];
											VIP = VIP + 1;
											Inst = Instr[VIP];
											A = Inst[2];
											Stk[A](Stk[A + 1]);
											VIP = VIP + 1;
											Inst = Instr[VIP];
											Stk[Inst[2]] = Upvalues[Inst[3]];
											VIP = VIP + 1;
											Inst = Instr[VIP];
											Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
											VIP = VIP + 1;
											Inst = Instr[VIP];
											Stk[Inst[2]]();
											VIP = VIP + 1;
											Inst = Instr[VIP];
											VIP = Inst[3];
										elseif (Enum > 14) then
											local A;
											Stk[Inst[2]] = Inst[3];
											VIP = VIP + 1;
											Inst = Instr[VIP];
											Stk[Inst[2]] = Inst[3];
											VIP = VIP + 1;
											Inst = Instr[VIP];
											A = Inst[2];
											Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
											VIP = VIP + 1;
											Inst = Instr[VIP];
											Stk[Inst[2]] = Upvalues[Inst[3]];
											VIP = VIP + 1;
											Inst = Instr[VIP];
											Stk[Inst[2]] = Upvalues[Inst[3]];
											VIP = VIP + 1;
											Inst = Instr[VIP];
											Stk[Inst[2]] = Upvalues[Inst[3]];
											VIP = VIP + 1;
											Inst = Instr[VIP];
											Stk[Inst[2]] = Inst[3];
											VIP = VIP + 1;
											Inst = Instr[VIP];
											Stk[Inst[2]] = Inst[3];
											VIP = VIP + 1;
											Inst = Instr[VIP];
											A = Inst[2];
											Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
											VIP = VIP + 1;
											Inst = Instr[VIP];
											Stk[Inst[2]] = Stk[Inst[3]][Stk[Inst[4]]];
										else
											local A;
											Stk[Inst[2]] = Upvalues[Inst[3]];
											VIP = VIP + 1;
											Inst = Instr[VIP];
											Stk[Inst[2]] = Inst[3];
											VIP = VIP + 1;
											Inst = Instr[VIP];
											Stk[Inst[2]] = Inst[3];
											VIP = VIP + 1;
											Inst = Instr[VIP];
											A = Inst[2];
											Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
											VIP = VIP + 1;
											Inst = Instr[VIP];
											Stk[Inst[2]] = Stk[Inst[3]][Stk[Inst[4]]];
											VIP = VIP + 1;
											Inst = Instr[VIP];
											Stk[Inst[2]] = Upvalues[Inst[3]];
											VIP = VIP + 1;
											Inst = Instr[VIP];
											Stk[Inst[2]] = Inst[3];
											VIP = VIP + 1;
											Inst = Instr[VIP];
											Stk[Inst[2]] = Inst[3];
											VIP = VIP + 1;
											Inst = Instr[VIP];
											A = Inst[2];
											Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
											VIP = VIP + 1;
											Inst = Instr[VIP];
											Stk[Inst[2]] = Stk[Inst[3]][Stk[Inst[4]]];
										end
									elseif (Enum <= 17) then
										if (Enum > 16) then
											local A;
											Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
											VIP = VIP + 1;
											Inst = Instr[VIP];
											Stk[Inst[2]] = Upvalues[Inst[3]];
											VIP = VIP + 1;
											Inst = Instr[VIP];
											Stk[Inst[2]] = Inst[3];
											VIP = VIP + 1;
											Inst = Instr[VIP];
											Stk[Inst[2]] = Stk[Inst[3]][Stk[Inst[4]]];
											VIP = VIP + 1;
											Inst = Instr[VIP];
											for Idx = Inst[2], Inst[3] do
												Stk[Idx] = nil;
											end
											VIP = VIP + 1;
											Inst = Instr[VIP];
											A = Inst[2];
											Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
											VIP = VIP + 1;
											Inst = Instr[VIP];
											if not Stk[Inst[2]] then
												VIP = VIP + 1;
											else
												VIP = Inst[3];
											end
										else
											local Edx;
											local Results, Limit;
											local A;
											Stk[Inst[2]] = Upvalues[Inst[3]];
											VIP = VIP + 1;
											Inst = Instr[VIP];
											Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
											VIP = VIP + 1;
											Inst = Instr[VIP];
											A = Inst[2];
											Results, Limit = _R(Stk[A](Stk[A + 1]));
											Top = (Limit + A) - 1;
											Edx = 0;
											for Idx = A, Top do
												Edx = Edx + 1;
												Stk[Idx] = Results[Edx];
											end
											VIP = VIP + 1;
											Inst = Instr[VIP];
											A = Inst[2];
											Results, Limit = _R(Stk[A](Unpack(Stk, A + 1, Top)));
											Top = (Limit + A) - 1;
											Edx = 0;
											for Idx = A, Top do
												Edx = Edx + 1;
												Stk[Idx] = Results[Edx];
											end
											VIP = VIP + 1;
											Inst = Instr[VIP];
											A = Inst[2];
											Stk[A] = Stk[A](Unpack(Stk, A + 1, Top));
											VIP = VIP + 1;
											Inst = Instr[VIP];
											Stk[Inst[2]] = Stk[Inst[3]] + Stk[Inst[4]];
											VIP = VIP + 1;
											Inst = Instr[VIP];
											if (Stk[Inst[2]] < Stk[Inst[4]]) then
												VIP = VIP + 1;
											else
												VIP = Inst[3];
											end
										end
									elseif (Enum > 18) then
										local B;
										local A;
										Stk[Inst[2]] = Upvalues[Inst[3]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Inst[3];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Inst[3];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										A = Inst[2];
										Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Stk[Inst[3]][Stk[Inst[4]]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										A = Inst[2];
										B = Stk[Inst[3]];
										Stk[A + 1] = B;
										Stk[A] = B[Inst[4]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										A = Inst[2];
										Stk[A] = Stk[A](Stk[A + 1]);
										VIP = VIP + 1;
										Inst = Instr[VIP];
										if not Stk[Inst[2]] then
											VIP = VIP + 1;
										else
											VIP = Inst[3];
										end
									else
										local A;
										Stk[Inst[2]]();
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Upvalues[Inst[3]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Upvalues[Inst[3]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Inst[3];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Inst[3];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										A = Inst[2];
										Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Upvalues[Inst[3]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										A = Inst[2];
										Stk[A] = Stk[A]();
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]][Stk[Inst[3]]] = Stk[Inst[4]];
									end
								elseif (Enum <= 22) then
									if (Enum <= 20) then
										local B;
										local A;
										Stk[Inst[2]] = Upvalues[Inst[3]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Inst[3];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Inst[3];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										A = Inst[2];
										Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Stk[Inst[3]][Stk[Inst[4]]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										A = Inst[2];
										B = Stk[Inst[3]];
										Stk[A + 1] = B;
										Stk[A] = B[Inst[4]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Env[Inst[3]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										A = Inst[2];
										Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Inst[3];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										if (Stk[Inst[2]] <= Stk[Inst[4]]) then
											VIP = VIP + 1;
										else
											VIP = Inst[3];
										end
									elseif (Enum == 21) then
										if (Inst[2] ~= Inst[4]) then
											VIP = VIP + 1;
										else
											VIP = Inst[3];
										end
									elseif (Stk[Inst[2]] > Inst[4]) then
										VIP = VIP + 1;
									else
										VIP = Inst[3];
									end
								elseif (Enum <= 24) then
									if (Enum == 23) then
										local A;
										Stk[Inst[2]] = Inst[3];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Inst[3];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										A = Inst[2];
										Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Stk[Inst[3]][Stk[Inst[4]]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Upvalues[Inst[3]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Inst[3];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Inst[3];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										A = Inst[2];
										Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Stk[Inst[3]][Stk[Inst[4]]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Upvalues[Inst[3]];
									else
										local A;
										Stk[Inst[2]] = Upvalues[Inst[3]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Inst[3];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Inst[3];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										A = Inst[2];
										Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Stk[Inst[3]][Stk[Inst[4]]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Upvalues[Inst[3]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Inst[3];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Inst[3];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										A = Inst[2];
										Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Stk[Inst[3]][Stk[Inst[4]]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Upvalues[Inst[3]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Inst[3];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Inst[3];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										A = Inst[2];
										Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
										VIP = VIP + 1;
										Inst = Instr[VIP];
										if (Stk[Inst[2]] == Stk[Inst[4]]) then
											VIP = VIP + 1;
										else
											VIP = Inst[3];
										end
									end
								elseif (Enum > 25) then
									local B;
									local A;
									A = Inst[2];
									B = Stk[Inst[3]];
									Stk[A + 1] = B;
									Stk[A] = B[Inst[4]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Upvalues[Inst[3]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									A = Inst[2];
									Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
									VIP = VIP + 1;
									Inst = Instr[VIP];
									if (Inst[2] > Stk[Inst[4]]) then
										VIP = VIP + 1;
									else
										VIP = Inst[3];
									end
								else
									local A;
									Stk[Inst[2]] = Upvalues[Inst[3]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									A = Inst[2];
									Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Stk[Inst[3]][Stk[Inst[4]]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Upvalues[Inst[3]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									A = Inst[2];
									Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Stk[Inst[3]][Stk[Inst[4]]];
								end
							elseif (Enum <= 39) then
								if (Enum <= 32) then
									if (Enum <= 29) then
										if (Enum <= 27) then
											local A;
											Stk[Inst[2]] = Inst[3];
											VIP = VIP + 1;
											Inst = Instr[VIP];
											A = Inst[2];
											Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
											VIP = VIP + 1;
											Inst = Instr[VIP];
											Stk[Inst[2]] = Stk[Inst[3]] + Stk[Inst[4]];
											VIP = VIP + 1;
											Inst = Instr[VIP];
											Stk[Inst[2]] = Stk[Inst[3]] * Stk[Inst[4]];
											VIP = VIP + 1;
											Inst = Instr[VIP];
											A = Inst[2];
											Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
											VIP = VIP + 1;
											Inst = Instr[VIP];
											Stk[Inst[2]] = Stk[Inst[3]] + Stk[Inst[4]];
											VIP = VIP + 1;
											Inst = Instr[VIP];
											if (Stk[Inst[2]] > Stk[Inst[4]]) then
												VIP = VIP + 1;
											else
												VIP = VIP + Inst[3];
											end
										elseif (Enum > 28) then
											local B;
											local A;
											A = Inst[2];
											B = Stk[Inst[3]];
											Stk[A + 1] = B;
											Stk[A] = B[Inst[4]];
											VIP = VIP + 1;
											Inst = Instr[VIP];
											Stk[Inst[2]] = Upvalues[Inst[3]];
											VIP = VIP + 1;
											Inst = Instr[VIP];
											Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
											VIP = VIP + 1;
											Inst = Instr[VIP];
											A = Inst[2];
											Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
											VIP = VIP + 1;
											Inst = Instr[VIP];
											Stk[Inst[2]] = Upvalues[Inst[3]];
											VIP = VIP + 1;
											Inst = Instr[VIP];
											Stk[Inst[2]] = Inst[3];
											VIP = VIP + 1;
											Inst = Instr[VIP];
											Stk[Inst[2]] = Upvalues[Inst[3]];
											VIP = VIP + 1;
											Inst = Instr[VIP];
											A = Inst[2];
											Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
											VIP = VIP + 1;
											Inst = Instr[VIP];
											Stk[Inst[2]] = Upvalues[Inst[3]];
											VIP = VIP + 1;
											Inst = Instr[VIP];
											Stk[Inst[2]] = Inst[3];
										else
											local A;
											Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
											VIP = VIP + 1;
											Inst = Instr[VIP];
											Stk[Inst[2]] = Inst[3];
											VIP = VIP + 1;
											Inst = Instr[VIP];
											Stk[Inst[2]] = Inst[3];
											VIP = VIP + 1;
											Inst = Instr[VIP];
											A = Inst[2];
											Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
											VIP = VIP + 1;
											Inst = Instr[VIP];
											if not Stk[Inst[2]] then
												VIP = VIP + 1;
											else
												VIP = Inst[3];
											end
										end
									elseif (Enum <= 30) then
										local B;
										local A;
										Stk[Inst[2]] = Inst[3];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										A = Inst[2];
										B = Stk[Inst[3]];
										Stk[A + 1] = B;
										Stk[A] = B[Stk[Inst[4]]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										A = Inst[2];
										Stk[A] = Stk[A](Stk[A + 1]);
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Upvalues[Inst[3]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Upvalues[Inst[3]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Inst[3];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Inst[3];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										A = Inst[2];
										Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Stk[Inst[3]][Stk[Inst[4]]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Upvalues[Inst[3]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Inst[3];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Inst[3];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										A = Inst[2];
										Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Stk[Inst[3]][Stk[Inst[4]]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										if (Stk[Inst[2]] < Stk[Inst[4]]) then
											VIP = VIP + 1;
										else
											VIP = Inst[3];
										end
									elseif (Enum == 31) then
										local B;
										local A;
										Stk[Inst[2]] = Upvalues[Inst[3]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Inst[3];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Inst[3];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										A = Inst[2];
										Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Stk[Inst[3]][Stk[Inst[4]]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Inst[3];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										A = Inst[2];
										B = Stk[Inst[3]];
										Stk[A + 1] = B;
										Stk[A] = B[Stk[Inst[4]]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										A = Inst[2];
										Stk[A] = Stk[A](Stk[A + 1]);
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Upvalues[Inst[3]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Inst[3];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										A = Inst[2];
										B = Stk[Inst[3]];
										Stk[A + 1] = B;
										Stk[A] = B[Stk[Inst[4]]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										A = Inst[2];
										Stk[A] = Stk[A](Stk[A + 1]);
										VIP = VIP + 1;
										Inst = Instr[VIP];
										if (Stk[Inst[2]] < Stk[Inst[4]]) then
											VIP = VIP + 1;
										else
											VIP = Inst[3];
										end
									else
										Stk[Inst[2]] = Stk[Inst[3]] % Stk[Inst[4]];
									end
								elseif (Enum <= 35) then
									if (Enum <= 33) then
										local A = Inst[2];
										local T = Stk[A];
										for Idx = A + 1, Top do
											Insert(T, Stk[Idx]);
										end
									elseif (Enum > 34) then
										local A;
										Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Upvalues[Inst[3]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Inst[3];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Stk[Inst[3]][Stk[Inst[4]]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										A = Inst[2];
										Stk[A] = Stk[A](Stk[A + 1]);
										VIP = VIP + 1;
										Inst = Instr[VIP];
										if not Stk[Inst[2]] then
											VIP = VIP + 1;
										else
											VIP = Inst[3];
										end
									else
										local B;
										local A;
										Stk[Inst[2]] = Upvalues[Inst[3]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Inst[3];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Inst[3];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										A = Inst[2];
										Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Stk[Inst[3]][Stk[Inst[4]]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										A = Inst[2];
										B = Stk[Inst[3]];
										Stk[A + 1] = B;
										Stk[A] = B[Inst[4]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										A = Inst[2];
										Stk[A] = Stk[A](Stk[A + 1]);
										VIP = VIP + 1;
										Inst = Instr[VIP];
										if not Stk[Inst[2]] then
											VIP = VIP + 1;
										else
											VIP = Inst[3];
										end
									end
								elseif (Enum <= 37) then
									if (Enum == 36) then
										local A;
										Stk[Inst[2]] = Upvalues[Inst[3]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Inst[3];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Inst[3];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										A = Inst[2];
										Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Inst[3];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]][Stk[Inst[3]]] = Stk[Inst[4]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Upvalues[Inst[3]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Inst[3];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Inst[3];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										A = Inst[2];
										do
											return Stk[A](Unpack(Stk, A + 1, Inst[3]));
										end
										VIP = VIP + 1;
										Inst = Instr[VIP];
										A = Inst[2];
										do
											return Unpack(Stk, A, Top);
										end
										VIP = VIP + 1;
										Inst = Instr[VIP];
										VIP = Inst[3];
									else
										local A;
										Stk[Inst[2]] = Stk[Inst[3]][Stk[Inst[4]]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Upvalues[Inst[3]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Inst[3];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Inst[3];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										A = Inst[2];
										Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Stk[Inst[3]][Stk[Inst[4]]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Inst[3];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										A = Inst[2];
										Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Stk[Inst[3]] + Stk[Inst[4]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]][Stk[Inst[3]]] = Stk[Inst[4]];
									end
								elseif (Enum == 38) then
									Stk[Inst[2]][Stk[Inst[3]]] = Stk[Inst[4]];
								else
									local B;
									local A;
									Stk[Inst[2]] = Upvalues[Inst[3]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									A = Inst[2];
									Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Stk[Inst[3]][Stk[Inst[4]]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									A = Inst[2];
									B = Stk[Inst[3]];
									Stk[A + 1] = B;
									Stk[A] = B[Inst[4]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									A = Inst[2];
									Stk[A] = Stk[A](Stk[A + 1]);
									VIP = VIP + 1;
									Inst = Instr[VIP];
									if Stk[Inst[2]] then
										VIP = VIP + 1;
									else
										VIP = Inst[3];
									end
								end
							elseif (Enum <= 46) then
								if (Enum <= 42) then
									if (Enum <= 40) then
										local B;
										local Edx;
										local Results, Limit;
										local A;
										Stk[Inst[2]] = Upvalues[Inst[3]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Inst[3];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Inst[3];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										A = Inst[2];
										Results, Limit = _R(Stk[A](Unpack(Stk, A + 1, Inst[3])));
										Top = (Limit + A) - 1;
										Edx = 0;
										for Idx = A, Top do
											Edx = Edx + 1;
											Stk[Idx] = Results[Edx];
										end
										VIP = VIP + 1;
										Inst = Instr[VIP];
										A = Inst[2];
										Stk[A] = Stk[A](Unpack(Stk, A + 1, Top));
										VIP = VIP + 1;
										Inst = Instr[VIP];
										A = Inst[2];
										B = Stk[Inst[3]];
										Stk[A + 1] = B;
										Stk[A] = B[Inst[4]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										A = Inst[2];
										Stk[A] = Stk[A](Stk[A + 1]);
										VIP = VIP + 1;
										Inst = Instr[VIP];
										if (Stk[Inst[2]] ~= Inst[4]) then
											VIP = VIP + 1;
										else
											VIP = Inst[3];
										end
									elseif (Enum > 41) then
										local A = Inst[2];
										local Results = {Stk[A](Stk[A + 1])};
										local Edx = 0;
										for Idx = A, Inst[4] do
											Edx = Edx + 1;
											Stk[Idx] = Results[Edx];
										end
									else
										local B;
										local A;
										Stk[Inst[2]] = Upvalues[Inst[3]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Inst[3];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Inst[3];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										A = Inst[2];
										Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Stk[Inst[3]][Stk[Inst[4]]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										A = Inst[2];
										B = Stk[Inst[3]];
										Stk[A + 1] = B;
										Stk[A] = B[Inst[4]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										A = Inst[2];
										Stk[A] = Stk[A](Stk[A + 1]);
										VIP = VIP + 1;
										Inst = Instr[VIP];
										if Stk[Inst[2]] then
											VIP = VIP + 1;
										else
											VIP = Inst[3];
										end
									end
								elseif (Enum <= 44) then
									if (Enum > 43) then
										local A;
										Stk[Inst[2]] = Upvalues[Inst[3]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Inst[3];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Inst[3];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										A = Inst[2];
										Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]][Stk[Inst[3]]] = Inst[4];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Upvalues[Inst[3]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Inst[3];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Inst[3];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										A = Inst[2];
										do
											return Stk[A](Unpack(Stk, A + 1, Inst[3]));
										end
										VIP = VIP + 1;
										Inst = Instr[VIP];
										A = Inst[2];
										do
											return Unpack(Stk, A, Top);
										end
										VIP = VIP + 1;
										Inst = Instr[VIP];
										VIP = Inst[3];
									else
										local B;
										local A;
										Stk[Inst[2]] = Upvalues[Inst[3]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Inst[3];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Inst[3];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										A = Inst[2];
										Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Stk[Inst[3]][Stk[Inst[4]]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										A = Inst[2];
										B = Stk[Inst[3]];
										Stk[A + 1] = B;
										Stk[A] = B[Inst[4]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										A = Inst[2];
										Stk[A] = Stk[A](Stk[A + 1]);
										VIP = VIP + 1;
										Inst = Instr[VIP];
										if Stk[Inst[2]] then
											VIP = VIP + 1;
										else
											VIP = Inst[3];
										end
									end
								elseif (Enum == 45) then
									local A = Inst[2];
									local Results, Limit = _R(Stk[A](Stk[A + 1]));
									Top = (Limit + A) - 1;
									local Edx = 0;
									for Idx = A, Top do
										Edx = Edx + 1;
										Stk[Idx] = Results[Edx];
									end
								else
									local A;
									A = Inst[2];
									Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Stk[Inst[3]][Stk[Inst[4]]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Upvalues[Inst[3]] = Stk[Inst[2]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Env[Inst[3]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Upvalues[Inst[3]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									A = Inst[2];
									Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
								end
							elseif (Enum <= 49) then
								if (Enum <= 47) then
									local A;
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									A = Inst[2];
									Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Stk[Inst[3]][Stk[Inst[4]]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Env[Inst[3]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Upvalues[Inst[3]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									A = Inst[2];
									Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Stk[Inst[3]][Stk[Inst[4]]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Env[Inst[3]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Upvalues[Inst[3]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									A = Inst[2];
									Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Stk[Inst[3]][Stk[Inst[4]]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Env[Inst[3]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Upvalues[Inst[3]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									A = Inst[2];
									Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Stk[Inst[3]][Stk[Inst[4]]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Env[Inst[3]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Upvalues[Inst[3]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									A = Inst[2];
									Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Stk[Inst[3]][Stk[Inst[4]]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Env[Inst[3]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Upvalues[Inst[3]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									A = Inst[2];
									Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Stk[Inst[3]][Stk[Inst[4]]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Env[Inst[3]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Upvalues[Inst[3]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									A = Inst[2];
									Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Stk[Inst[3]][Stk[Inst[4]]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Env[Inst[3]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Upvalues[Inst[3]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									A = Inst[2];
									Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Stk[Inst[3]][Stk[Inst[4]]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Env[Inst[3]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Upvalues[Inst[3]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									A = Inst[2];
									Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Stk[Inst[3]][Stk[Inst[4]]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Env[Inst[3]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Upvalues[Inst[3]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									A = Inst[2];
									Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Stk[Inst[3]][Stk[Inst[4]]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Env[Inst[3]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Upvalues[Inst[3]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									A = Inst[2];
									Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Stk[Inst[3]][Stk[Inst[4]]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Env[Inst[3]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Upvalues[Inst[3]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									A = Inst[2];
									Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
								elseif (Enum == 48) then
									do
										return Stk[Inst[2]];
									end
								else
									local B;
									local A;
									Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Upvalues[Inst[3]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Stk[Inst[3]][Stk[Inst[4]]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									for Idx = Inst[2], Inst[3] do
										Stk[Idx] = nil;
									end
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Upvalues[Inst[3]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									A = Inst[2];
									B = Stk[Inst[3]];
									Stk[A + 1] = B;
									Stk[A] = B[Inst[4]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Upvalues[Inst[3]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Stk[Inst[3]][Stk[Inst[4]]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									A = Inst[2];
									Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = not Stk[Inst[3]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									A = Inst[2];
									Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
									VIP = VIP + 1;
									Inst = Instr[VIP];
									if not Stk[Inst[2]] then
										VIP = VIP + 1;
									else
										VIP = Inst[3];
									end
								end
							elseif (Enum <= 51) then
								if (Enum > 50) then
									local A;
									Stk[Inst[2]] = Env[Inst[3]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Upvalues[Inst[3]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									A = Inst[2];
									Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Stk[Inst[3]][Stk[Inst[4]]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									for Idx = Inst[2], Inst[3] do
										Stk[Idx] = nil;
									end
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Upvalues[Inst[3]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
								else
									local Step;
									local Index;
									local A;
									Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									A = Inst[2];
									Stk[A] = Stk[A]();
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Stk[Inst[3]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Upvalues[Inst[3]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = #Stk[Inst[3]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									A = Inst[2];
									Index = Stk[A];
									Step = Stk[A + 2];
									if (Step > 0) then
										if (Index > Stk[A + 1]) then
											VIP = Inst[3];
										else
											Stk[A + 3] = Index;
										end
									elseif (Index < Stk[A + 1]) then
										VIP = Inst[3];
									else
										Stk[A + 3] = Index;
									end
								end
							elseif (Enum > 52) then
								local B;
								local A;
								Stk[Inst[2]] = Upvalues[Inst[3]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Inst[3];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Inst[3];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								A = Inst[2];
								Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Stk[Inst[3]][Stk[Inst[4]]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								A = Inst[2];
								B = Stk[Inst[3]];
								Stk[A + 1] = B;
								Stk[A] = B[Inst[4]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								A = Inst[2];
								Stk[A] = Stk[A](Stk[A + 1]);
								VIP = VIP + 1;
								Inst = Instr[VIP];
								if (Inst[2] < Stk[Inst[4]]) then
									VIP = VIP + 1;
								else
									VIP = Inst[3];
								end
							else
								local A;
								Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Upvalues[Inst[3]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								for Idx = Inst[2], Inst[3] do
									Stk[Idx] = nil;
								end
								VIP = VIP + 1;
								Inst = Instr[VIP];
								A = Inst[2];
								Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
								VIP = VIP + 1;
								Inst = Instr[VIP];
								if Stk[Inst[2]] then
									VIP = VIP + 1;
								else
									VIP = Inst[3];
								end
							end
						elseif (Enum <= 80) then
							if (Enum <= 66) then
								if (Enum <= 59) then
									if (Enum <= 56) then
										if (Enum <= 54) then
											local A;
											Stk[Inst[2]] = Upvalues[Inst[3]];
											VIP = VIP + 1;
											Inst = Instr[VIP];
											Stk[Inst[2]] = Inst[3];
											VIP = VIP + 1;
											Inst = Instr[VIP];
											Stk[Inst[2]] = Inst[3];
											VIP = VIP + 1;
											Inst = Instr[VIP];
											A = Inst[2];
											Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
											VIP = VIP + 1;
											Inst = Instr[VIP];
											Stk[Inst[2]] = Inst[3];
											VIP = VIP + 1;
											Inst = Instr[VIP];
											Stk[Inst[2]][Stk[Inst[3]]] = Stk[Inst[4]];
											VIP = VIP + 1;
											Inst = Instr[VIP];
											Stk[Inst[2]] = Upvalues[Inst[3]];
											VIP = VIP + 1;
											Inst = Instr[VIP];
											Stk[Inst[2]] = Inst[3];
											VIP = VIP + 1;
											Inst = Instr[VIP];
											Stk[Inst[2]] = Inst[3];
											VIP = VIP + 1;
											Inst = Instr[VIP];
											A = Inst[2];
											do
												return Stk[A](Unpack(Stk, A + 1, Inst[3]));
											end
											VIP = VIP + 1;
											Inst = Instr[VIP];
											A = Inst[2];
											do
												return Unpack(Stk, A, Top);
											end
											VIP = VIP + 1;
											Inst = Instr[VIP];
											VIP = Inst[3];
										elseif (Enum == 55) then
											local A;
											Stk[Inst[2]] = Upvalues[Inst[3]];
											VIP = VIP + 1;
											Inst = Instr[VIP];
											Stk[Inst[2]] = Inst[3];
											VIP = VIP + 1;
											Inst = Instr[VIP];
											Stk[Inst[2]] = Inst[3];
											VIP = VIP + 1;
											Inst = Instr[VIP];
											A = Inst[2];
											Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
											VIP = VIP + 1;
											Inst = Instr[VIP];
											Stk[Inst[2]] = Inst[3];
											VIP = VIP + 1;
											Inst = Instr[VIP];
											Stk[Inst[2]][Stk[Inst[3]]] = Stk[Inst[4]];
											VIP = VIP + 1;
											Inst = Instr[VIP];
											Stk[Inst[2]] = Upvalues[Inst[3]];
											VIP = VIP + 1;
											Inst = Instr[VIP];
											Stk[Inst[2]] = Inst[3];
											VIP = VIP + 1;
											Inst = Instr[VIP];
											Stk[Inst[2]] = Inst[3];
											VIP = VIP + 1;
											Inst = Instr[VIP];
											A = Inst[2];
											Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
										else
											local B;
											local A;
											Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
											VIP = VIP + 1;
											Inst = Instr[VIP];
											Stk[Inst[2]] = Upvalues[Inst[3]];
											VIP = VIP + 1;
											Inst = Instr[VIP];
											Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
											VIP = VIP + 1;
											Inst = Instr[VIP];
											for Idx = Inst[2], Inst[3] do
												Stk[Idx] = nil;
											end
											VIP = VIP + 1;
											Inst = Instr[VIP];
											Stk[Inst[2]] = Upvalues[Inst[3]];
											VIP = VIP + 1;
											Inst = Instr[VIP];
											A = Inst[2];
											B = Stk[Inst[3]];
											Stk[A + 1] = B;
											Stk[A] = B[Inst[4]];
											VIP = VIP + 1;
											Inst = Instr[VIP];
											Stk[Inst[2]] = Inst[3];
											VIP = VIP + 1;
											Inst = Instr[VIP];
											A = Inst[2];
											Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
											VIP = VIP + 1;
											Inst = Instr[VIP];
											Stk[Inst[2]] = not Stk[Inst[3]];
											VIP = VIP + 1;
											Inst = Instr[VIP];
											A = Inst[2];
											Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
										end
									elseif (Enum <= 57) then
										local A;
										Stk[Inst[2]] = Upvalues[Inst[3]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Inst[3];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Inst[3];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										A = Inst[2];
										Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Stk[Inst[3]][Stk[Inst[4]]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Upvalues[Inst[3]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Inst[3];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Inst[3];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										A = Inst[2];
										Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Stk[Inst[3]][Stk[Inst[4]]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Upvalues[Inst[3]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Inst[3];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Inst[3];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										A = Inst[2];
										Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Stk[Inst[3]][Stk[Inst[4]]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										if Stk[Inst[2]] then
											VIP = VIP + 1;
										else
											VIP = Inst[3];
										end
									elseif (Enum == 58) then
										for Idx = Inst[2], Inst[3] do
											Stk[Idx] = nil;
										end
									else
										local A;
										Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Upvalues[Inst[3]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										A = Inst[2];
										Stk[A] = Stk[A](Stk[A + 1]);
										VIP = VIP + 1;
										Inst = Instr[VIP];
										if not Stk[Inst[2]] then
											VIP = VIP + 1;
										else
											VIP = Inst[3];
										end
									end
								elseif (Enum <= 62) then
									if (Enum <= 60) then
										local A;
										Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Upvalues[Inst[3]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Inst[3];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Stk[Inst[3]][Stk[Inst[4]]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										for Idx = Inst[2], Inst[3] do
											Stk[Idx] = nil;
										end
										VIP = VIP + 1;
										Inst = Instr[VIP];
										A = Inst[2];
										Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
										VIP = VIP + 1;
										Inst = Instr[VIP];
										if not Stk[Inst[2]] then
											VIP = VIP + 1;
										else
											VIP = Inst[3];
										end
									elseif (Enum > 61) then
										local A;
										Stk[Inst[2]] = Stk[Inst[3]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Stk[Inst[3]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										A = Inst[2];
										Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Upvalues[Inst[3]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Stk[Inst[3]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Stk[Inst[3]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										A = Inst[2];
										Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Stk[Inst[3]] + Stk[Inst[4]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Env[Inst[3]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										A = Inst[2];
										Stk[A] = Stk[A]();
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Stk[Inst[3]] - Stk[Inst[4]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Inst[3];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										if (Stk[Inst[2]] <= Stk[Inst[4]]) then
											VIP = VIP + 1;
										else
											VIP = Inst[3];
										end
									else
										local A;
										Stk[Inst[2]] = Upvalues[Inst[3]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Inst[3];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Inst[3];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										A = Inst[2];
										Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Inst[3];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]][Stk[Inst[3]]] = Stk[Inst[4]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Upvalues[Inst[3]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Inst[3];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Inst[3];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										A = Inst[2];
										do
											return Stk[A](Unpack(Stk, A + 1, Inst[3]));
										end
										VIP = VIP + 1;
										Inst = Instr[VIP];
										A = Inst[2];
										do
											return Unpack(Stk, A, Top);
										end
										VIP = VIP + 1;
										Inst = Instr[VIP];
										VIP = Inst[3];
									end
								elseif (Enum <= 64) then
									if (Enum > 63) then
										local A = Inst[2];
										local C = Inst[4];
										local CB = A + 2;
										local Result = {Stk[A](Stk[A + 1], Stk[CB])};
										for Idx = 1, C do
											Stk[CB + Idx] = Result[Idx];
										end
										local R = Result[1];
										if R then
											Stk[CB] = R;
											VIP = Inst[3];
										else
											VIP = VIP + 1;
										end
									elseif (Stk[Inst[2]] < Inst[4]) then
										VIP = Inst[3];
									else
										VIP = VIP + 1;
									end
								elseif (Enum > 65) then
									local A;
									Stk[Inst[2]] = Upvalues[Inst[3]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									A = Inst[2];
									Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Stk[Inst[3]][Stk[Inst[4]]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Upvalues[Inst[3]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									A = Inst[2];
									Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Stk[Inst[3]][Stk[Inst[4]]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Upvalues[Inst[3]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									A = Inst[2];
									Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Stk[Inst[3]][Stk[Inst[4]]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									if (Stk[Inst[2]] <= Inst[4]) then
										VIP = VIP + 1;
									else
										VIP = Inst[3];
									end
								else
									local A;
									Stk[Inst[2]] = Upvalues[Inst[3]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									A = Inst[2];
									Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]][Stk[Inst[3]]] = Stk[Inst[4]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Upvalues[Inst[3]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									A = Inst[2];
									do
										return Stk[A](Unpack(Stk, A + 1, Inst[3]));
									end
									VIP = VIP + 1;
									Inst = Instr[VIP];
									A = Inst[2];
									do
										return Unpack(Stk, A, Top);
									end
									VIP = VIP + 1;
									Inst = Instr[VIP];
									VIP = Inst[3];
								end
							elseif (Enum <= 73) then
								if (Enum <= 69) then
									if (Enum <= 67) then
										local A;
										Stk[Inst[2]] = Upvalues[Inst[3]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Inst[3];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Inst[3];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										A = Inst[2];
										Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Inst[3];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]][Stk[Inst[3]]] = Stk[Inst[4]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Upvalues[Inst[3]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Inst[3];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Inst[3];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										A = Inst[2];
										do
											return Stk[A](Unpack(Stk, A + 1, Inst[3]));
										end
										VIP = VIP + 1;
										Inst = Instr[VIP];
										A = Inst[2];
										do
											return Unpack(Stk, A, Top);
										end
										VIP = VIP + 1;
										Inst = Instr[VIP];
										VIP = Inst[3];
									elseif (Enum > 68) then
										local B;
										local A;
										Stk[Inst[2]] = Upvalues[Inst[3]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Inst[3];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Inst[3];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										A = Inst[2];
										Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Stk[Inst[3]][Stk[Inst[4]]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										A = Inst[2];
										B = Stk[Inst[3]];
										Stk[A + 1] = B;
										Stk[A] = B[Inst[4]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										A = Inst[2];
										Stk[A] = Stk[A](Stk[A + 1]);
										VIP = VIP + 1;
										Inst = Instr[VIP];
										if Stk[Inst[2]] then
											VIP = VIP + 1;
										else
											VIP = Inst[3];
										end
									else
										local B;
										local A;
										Stk[Inst[2]] = Upvalues[Inst[3]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Inst[3];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Inst[3];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										A = Inst[2];
										Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Stk[Inst[3]][Stk[Inst[4]]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										A = Inst[2];
										B = Stk[Inst[3]];
										Stk[A + 1] = B;
										Stk[A] = B[Inst[4]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										A = Inst[2];
										Stk[A] = Stk[A](Stk[A + 1]);
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Inst[3];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										if (Stk[Inst[2]] < Stk[Inst[4]]) then
											VIP = Inst[3];
										else
											VIP = VIP + 1;
										end
									end
								elseif (Enum <= 71) then
									if (Enum == 70) then
										local B;
										local A;
										Stk[Inst[2]] = Upvalues[Inst[3]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Inst[3];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Inst[3];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										A = Inst[2];
										Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Stk[Inst[3]][Stk[Inst[4]]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										A = Inst[2];
										B = Stk[Inst[3]];
										Stk[A + 1] = B;
										Stk[A] = B[Inst[4]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										A = Inst[2];
										Stk[A] = Stk[A](Stk[A + 1]);
										VIP = VIP + 1;
										Inst = Instr[VIP];
										if Stk[Inst[2]] then
											VIP = VIP + 1;
										else
											VIP = Inst[3];
										end
									else
										local B;
										local A;
										A = Inst[2];
										B = Stk[Inst[3]];
										Stk[A + 1] = B;
										Stk[A] = B[Inst[4]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Upvalues[Inst[3]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										A = Inst[2];
										Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
										VIP = VIP + 1;
										Inst = Instr[VIP];
										if not Stk[Inst[2]] then
											VIP = VIP + 1;
										else
											VIP = Inst[3];
										end
									end
								elseif (Enum == 72) then
									local B;
									local A;
									Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Upvalues[Inst[3]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									for Idx = Inst[2], Inst[3] do
										Stk[Idx] = nil;
									end
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Upvalues[Inst[3]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									A = Inst[2];
									B = Stk[Inst[3]];
									Stk[A + 1] = B;
									Stk[A] = B[Inst[4]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Upvalues[Inst[3]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									A = Inst[2];
									Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = not Stk[Inst[3]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									A = Inst[2];
									Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
									VIP = VIP + 1;
									Inst = Instr[VIP];
									if Stk[Inst[2]] then
										VIP = VIP + 1;
									else
										VIP = Inst[3];
									end
								else
									local Edx;
									local Results, Limit;
									local B;
									local A;
									A = Inst[2];
									Stk[A] = Stk[A](Unpack(Stk, A + 1, Top));
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Upvalues[Inst[3]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Upvalues[Inst[3]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Upvalues[Inst[3]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									A = Inst[2];
									Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Stk[Inst[3]][Stk[Inst[4]]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									A = Inst[2];
									B = Stk[Inst[3]];
									Stk[A + 1] = B;
									Stk[A] = B[Inst[4]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									A = Inst[2];
									Results, Limit = _R(Stk[A](Stk[A + 1]));
									Top = (Limit + A) - 1;
									Edx = 0;
									for Idx = A, Top do
										Edx = Edx + 1;
										Stk[Idx] = Results[Edx];
									end
								end
							elseif (Enum <= 76) then
								if (Enum <= 74) then
									local B;
									local A;
									Stk[Inst[2]] = Upvalues[Inst[3]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									A = Inst[2];
									Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Stk[Inst[3]][Stk[Inst[4]]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									A = Inst[2];
									B = Stk[Inst[3]];
									Stk[A + 1] = B;
									Stk[A] = B[Stk[Inst[4]]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									A = Inst[2];
									Stk[A] = Stk[A](Stk[A + 1]);
									VIP = VIP + 1;
									Inst = Instr[VIP];
									if Stk[Inst[2]] then
										VIP = VIP + 1;
									else
										VIP = Inst[3];
									end
								elseif (Enum > 75) then
									local A;
									Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Upvalues[Inst[3]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Stk[Inst[3]][Stk[Inst[4]]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									for Idx = Inst[2], Inst[3] do
										Stk[Idx] = nil;
									end
									VIP = VIP + 1;
									Inst = Instr[VIP];
									A = Inst[2];
									Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
									VIP = VIP + 1;
									Inst = Instr[VIP];
									if not Stk[Inst[2]] then
										VIP = VIP + 1;
									else
										VIP = Inst[3];
									end
								else
									local A;
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									A = Inst[2];
									Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Stk[Inst[3]][Stk[Inst[4]]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Upvalues[Inst[3]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									A = Inst[2];
									Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Stk[Inst[3]][Stk[Inst[4]]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
								end
							elseif (Enum <= 78) then
								if (Enum == 77) then
									local B;
									local A;
									Stk[Inst[2]] = Upvalues[Inst[3]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									A = Inst[2];
									Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Stk[Inst[3]][Stk[Inst[4]]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									A = Inst[2];
									B = Stk[Inst[3]];
									Stk[A + 1] = B;
									Stk[A] = B[Inst[4]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									A = Inst[2];
									Stk[A] = Stk[A](Stk[A + 1]);
									VIP = VIP + 1;
									Inst = Instr[VIP];
									if Stk[Inst[2]] then
										VIP = VIP + 1;
									else
										VIP = Inst[3];
									end
								else
									local Edx;
									local Results, Limit;
									local B;
									local A;
									Stk[Inst[2]] = Upvalues[Inst[3]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Upvalues[Inst[3]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Upvalues[Inst[3]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									A = Inst[2];
									Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Stk[Inst[3]][Stk[Inst[4]]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									A = Inst[2];
									B = Stk[Inst[3]];
									Stk[A + 1] = B;
									Stk[A] = B[Inst[4]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									A = Inst[2];
									Results, Limit = _R(Stk[A](Stk[A + 1]));
									Top = (Limit + A) - 1;
									Edx = 0;
									for Idx = A, Top do
										Edx = Edx + 1;
										Stk[Idx] = Results[Edx];
									end
									VIP = VIP + 1;
									Inst = Instr[VIP];
									A = Inst[2];
									Stk[A] = Stk[A](Unpack(Stk, A + 1, Top));
								end
							elseif (Enum == 79) then
								local B;
								local A;
								A = Inst[2];
								B = Stk[Inst[3]];
								Stk[A + 1] = B;
								Stk[A] = B[Inst[4]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Inst[3];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Inst[3];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								A = Inst[2];
								Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
								VIP = VIP + 1;
								Inst = Instr[VIP];
								if Stk[Inst[2]] then
									VIP = VIP + 1;
								else
									VIP = Inst[3];
								end
							else
								local K;
								local B;
								local A;
								A = Inst[2];
								Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Upvalues[Inst[3]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Upvalues[Inst[3]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								A = Inst[2];
								Stk[A] = Stk[A](Stk[A + 1]);
								VIP = VIP + 1;
								Inst = Instr[VIP];
								A = Inst[2];
								B = Stk[Inst[3]];
								Stk[A + 1] = B;
								Stk[A] = B[Inst[4]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								A = Inst[2];
								Stk[A] = Stk[A](Stk[A + 1]);
								VIP = VIP + 1;
								Inst = Instr[VIP];
								B = Inst[3];
								K = Stk[B];
								for Idx = B + 1, Inst[4] do
									K = K .. Stk[Idx];
								end
								Stk[Inst[2]] = K;
								VIP = VIP + 1;
								Inst = Instr[VIP];
								do
									return Stk[Inst[2]];
								end
								VIP = VIP + 1;
								Inst = Instr[VIP];
								VIP = Inst[3];
							end
						elseif (Enum <= 94) then
							if (Enum <= 87) then
								if (Enum <= 83) then
									if (Enum <= 81) then
										local A;
										Stk[Inst[2]] = Upvalues[Inst[3]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Inst[3];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Inst[3];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										A = Inst[2];
										Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Stk[Inst[3]][Stk[Inst[4]]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										if not Stk[Inst[2]] then
											VIP = VIP + 1;
										else
											VIP = Inst[3];
										end
									elseif (Enum > 82) then
										local A;
										Stk[Inst[2]] = Upvalues[Inst[3]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Inst[3];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Inst[3];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										A = Inst[2];
										Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Stk[Inst[3]][Stk[Inst[4]]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Upvalues[Inst[3]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Inst[3];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Inst[3];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										A = Inst[2];
										Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Stk[Inst[3]][Stk[Inst[4]]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Upvalues[Inst[3]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Inst[3];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Inst[3];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										A = Inst[2];
										Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
										VIP = VIP + 1;
										Inst = Instr[VIP];
										if (Stk[Inst[2]] ~= Stk[Inst[4]]) then
											VIP = VIP + 1;
										else
											VIP = Inst[3];
										end
									else
										local A;
										Stk[Inst[2]] = Inst[3];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										A = Inst[2];
										Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Stk[Inst[3]][Stk[Inst[4]]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Upvalues[Inst[3]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Inst[3];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Inst[3];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										A = Inst[2];
										Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Stk[Inst[3]][Stk[Inst[4]]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										A = Inst[2];
										Stk[A](Unpack(Stk, A + 1, Inst[3]));
									end
								elseif (Enum <= 85) then
									if (Enum > 84) then
										local A;
										Stk[Inst[2]] = Upvalues[Inst[3]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Inst[3];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Inst[3];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										A = Inst[2];
										Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Stk[Inst[3]][Stk[Inst[4]]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Upvalues[Inst[3]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Inst[3];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Inst[3];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										A = Inst[2];
										Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Stk[Inst[3]][Stk[Inst[4]]];
									else
										local A;
										Stk[Inst[2]] = Inst[3];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Stk[Inst[3]][Stk[Inst[4]]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										A = Inst[2];
										Stk[A] = Stk[A]();
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Stk[Inst[3]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										if Stk[Inst[2]] then
											VIP = VIP + 1;
										else
											VIP = Inst[3];
										end
									end
								elseif (Enum > 86) then
									local B;
									local A;
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									A = Inst[2];
									B = Stk[Inst[3]];
									Stk[A + 1] = B;
									Stk[A] = B[Stk[Inst[4]]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									A = Inst[2];
									Stk[A] = Stk[A](Stk[A + 1]);
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Upvalues[Inst[3]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Upvalues[Inst[3]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									A = Inst[2];
									Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Stk[Inst[3]][Stk[Inst[4]]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Upvalues[Inst[3]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									A = Inst[2];
									Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Stk[Inst[3]][Stk[Inst[4]]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									if (Stk[Inst[2]] < Stk[Inst[4]]) then
										VIP = VIP + 1;
									else
										VIP = Inst[3];
									end
								else
									local Edx;
									local Results, Limit;
									local B;
									local A;
									Stk[Inst[2]] = Upvalues[Inst[3]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Upvalues[Inst[3]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Upvalues[Inst[3]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									A = Inst[2];
									B = Stk[Inst[3]];
									Stk[A + 1] = B;
									Stk[A] = B[Inst[4]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									A = Inst[2];
									Results, Limit = _R(Stk[A](Unpack(Stk, A + 1, Inst[3])));
									Top = (Limit + A) - 1;
									Edx = 0;
									for Idx = A, Top do
										Edx = Edx + 1;
										Stk[Idx] = Results[Edx];
									end
									VIP = VIP + 1;
									Inst = Instr[VIP];
									A = Inst[2];
									Results, Limit = _R(Stk[A](Unpack(Stk, A + 1, Top)));
									Top = (Limit + A) - 1;
									Edx = 0;
									for Idx = A, Top do
										Edx = Edx + 1;
										Stk[Idx] = Results[Edx];
									end
									VIP = VIP + 1;
									Inst = Instr[VIP];
									A = Inst[2];
									Stk[A] = Stk[A](Unpack(Stk, A + 1, Top));
								end
							elseif (Enum <= 90) then
								if (Enum <= 88) then
									local A;
									Stk[Inst[2]] = Upvalues[Inst[3]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									A = Inst[2];
									Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Stk[Inst[3]][Stk[Inst[4]]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Upvalues[Inst[3]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									A = Inst[2];
									Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Stk[Inst[3]][Stk[Inst[4]]];
								elseif (Enum == 89) then
									local Edx;
									local Results, Limit;
									local A;
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Stk[Inst[3]][Stk[Inst[4]]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Upvalues[Inst[3]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3] ~= 0;
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Upvalues[Inst[3]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									A = Inst[2];
									Results, Limit = _R(Stk[A](Unpack(Stk, A + 1, Inst[3])));
									Top = (Limit + A) - 1;
									Edx = 0;
									for Idx = A, Top do
										Edx = Edx + 1;
										Stk[Idx] = Results[Edx];
									end
									VIP = VIP + 1;
									Inst = Instr[VIP];
									A = Inst[2];
									Stk[A] = Stk[A](Unpack(Stk, A + 1, Top));
								else
									local Edx;
									local Results, Limit;
									local B;
									local A;
									A = Inst[2];
									Stk[A] = Stk[A]();
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Upvalues[Inst[3]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Upvalues[Inst[3]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Upvalues[Inst[3]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									A = Inst[2];
									B = Stk[Inst[3]];
									Stk[A + 1] = B;
									Stk[A] = B[Inst[4]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									A = Inst[2];
									Results, Limit = _R(Stk[A](Unpack(Stk, A + 1, Inst[3])));
									Top = (Limit + A) - 1;
									Edx = 0;
									for Idx = A, Top do
										Edx = Edx + 1;
										Stk[Idx] = Results[Edx];
									end
									VIP = VIP + 1;
									Inst = Instr[VIP];
									A = Inst[2];
									Results, Limit = _R(Stk[A](Unpack(Stk, A + 1, Top)));
									Top = (Limit + A) - 1;
									Edx = 0;
									for Idx = A, Top do
										Edx = Edx + 1;
										Stk[Idx] = Results[Edx];
									end
								end
							elseif (Enum <= 92) then
								if (Enum == 91) then
									local A;
									Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Upvalues[Inst[3]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									A = Inst[2];
									Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									A = Inst[2];
									Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
									VIP = VIP + 1;
									Inst = Instr[VIP];
									if not Stk[Inst[2]] then
										VIP = VIP + 1;
									else
										VIP = Inst[3];
									end
								else
									local B;
									local A;
									Stk[Inst[2]] = Upvalues[Inst[3]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									A = Inst[2];
									Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Stk[Inst[3]][Stk[Inst[4]]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									A = Inst[2];
									B = Stk[Inst[3]];
									Stk[A + 1] = B;
									Stk[A] = B[Inst[4]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									A = Inst[2];
									Stk[A] = Stk[A](Stk[A + 1]);
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = not Stk[Inst[3]];
								end
							elseif (Enum == 93) then
								if (Inst[2] < Inst[4]) then
									VIP = VIP + 1;
								else
									VIP = Inst[3];
								end
							else
								local B;
								local A;
								Stk[Inst[2]] = Inst[3];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								A = Inst[2];
								B = Stk[Inst[3]];
								Stk[A + 1] = B;
								Stk[A] = B[Stk[Inst[4]]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Upvalues[Inst[3]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								A = Inst[2];
								Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Upvalues[Inst[3]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Inst[3];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								A = Inst[2];
								B = Stk[Inst[3]];
								Stk[A + 1] = B;
								Stk[A] = B[Stk[Inst[4]]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Upvalues[Inst[3]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								A = Inst[2];
								Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Stk[Inst[3]];
							end
						elseif (Enum <= 101) then
							if (Enum <= 97) then
								if (Enum <= 95) then
									local B;
									local A;
									A = Inst[2];
									B = Stk[Inst[3]];
									Stk[A + 1] = B;
									Stk[A] = B[Inst[4]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Upvalues[Inst[3]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									A = Inst[2];
									Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
									VIP = VIP + 1;
									Inst = Instr[VIP];
									if Stk[Inst[2]] then
										VIP = VIP + 1;
									else
										VIP = Inst[3];
									end
								elseif (Enum > 96) then
									local A;
									Stk[Inst[2]] = Upvalues[Inst[3]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									A = Inst[2];
									Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]][Stk[Inst[3]]] = Stk[Inst[4]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Upvalues[Inst[3]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									A = Inst[2];
									do
										return Stk[A](Unpack(Stk, A + 1, Inst[3]));
									end
									VIP = VIP + 1;
									Inst = Instr[VIP];
									A = Inst[2];
									do
										return Unpack(Stk, A, Top);
									end
									VIP = VIP + 1;
									Inst = Instr[VIP];
									VIP = Inst[3];
								else
									local B;
									local A;
									Stk[Inst[2]] = Upvalues[Inst[3]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									A = Inst[2];
									Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Stk[Inst[3]][Stk[Inst[4]]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									A = Inst[2];
									B = Stk[Inst[3]];
									Stk[A + 1] = B;
									Stk[A] = B[Inst[4]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									A = Inst[2];
									Stk[A] = Stk[A](Stk[A + 1]);
									VIP = VIP + 1;
									Inst = Instr[VIP];
									if Stk[Inst[2]] then
										VIP = VIP + 1;
									else
										VIP = Inst[3];
									end
								end
							elseif (Enum <= 99) then
								if (Enum > 98) then
									local A;
									Stk[Inst[2]] = Upvalues[Inst[3]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									A = Inst[2];
									Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Stk[Inst[3]][Stk[Inst[4]]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Upvalues[Inst[3]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									A = Inst[2];
									Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Stk[Inst[3]][Stk[Inst[4]]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Upvalues[Inst[3]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									A = Inst[2];
									Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
									VIP = VIP + 1;
									Inst = Instr[VIP];
									if (Stk[Inst[2]] ~= Stk[Inst[4]]) then
										VIP = VIP + 1;
									else
										VIP = Inst[3];
									end
								elseif (Inst[2] ~= Stk[Inst[4]]) then
									VIP = VIP + 1;
								else
									VIP = Inst[3];
								end
							elseif (Enum > 100) then
								local A;
								Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Stk[Inst[3]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								for Idx = Inst[2], Inst[3] do
									Stk[Idx] = nil;
								end
								VIP = VIP + 1;
								Inst = Instr[VIP];
								A = Inst[2];
								Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
								VIP = VIP + 1;
								Inst = Instr[VIP];
								if not Stk[Inst[2]] then
									VIP = VIP + 1;
								else
									VIP = Inst[3];
								end
							else
								local Edx;
								local Results, Limit;
								local A;
								Stk[Inst[2]] = Upvalues[Inst[3]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Inst[3];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Inst[3];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								A = Inst[2];
								Results, Limit = _R(Stk[A](Unpack(Stk, A + 1, Inst[3])));
								Top = (Limit + A) - 1;
								Edx = 0;
								for Idx = A, Top do
									Edx = Edx + 1;
									Stk[Idx] = Results[Edx];
								end
								VIP = VIP + 1;
								Inst = Instr[VIP];
								A = Inst[2];
								Stk[A](Unpack(Stk, A + 1, Top));
								VIP = VIP + 1;
								Inst = Instr[VIP];
								for Idx = Inst[2], Inst[3] do
									Stk[Idx] = nil;
								end
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Inst[3];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								for Idx = Inst[2], Inst[3] do
									Stk[Idx] = nil;
								end
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = {};
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = {};
							end
						elseif (Enum <= 104) then
							if (Enum <= 102) then
								local Edx;
								local Results, Limit;
								local A;
								Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Upvalues[Inst[3]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Inst[3];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								A = Inst[2];
								Results, Limit = _R(Stk[A](Stk[A + 1]));
								Top = (Limit + A) - 1;
								Edx = 0;
								for Idx = A, Top do
									Edx = Edx + 1;
									Stk[Idx] = Results[Edx];
								end
								VIP = VIP + 1;
								Inst = Instr[VIP];
								A = Inst[2];
								Stk[A] = Stk[A](Unpack(Stk, A + 1, Top));
								VIP = VIP + 1;
								Inst = Instr[VIP];
								if not Stk[Inst[2]] then
									VIP = VIP + 1;
								else
									VIP = Inst[3];
								end
							elseif (Enum == 103) then
								local B;
								local A;
								A = Inst[2];
								B = Stk[Inst[3]];
								Stk[A + 1] = B;
								Stk[A] = B[Inst[4]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Upvalues[Inst[3]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Stk[Inst[3]][Stk[Inst[4]]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								A = Inst[2];
								Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
								VIP = VIP + 1;
								Inst = Instr[VIP];
								if (Stk[Inst[2]] > Inst[4]) then
									VIP = VIP + 1;
								else
									VIP = Inst[3];
								end
							else
								local A;
								A = Inst[2];
								Stk[A] = Stk[A]();
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Upvalues[Inst[3]] = Stk[Inst[2]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Upvalues[Inst[3]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								A = Inst[2];
								Stk[A] = Stk[A]();
								VIP = VIP + 1;
								Inst = Instr[VIP];
								if Stk[Inst[2]] then
									VIP = VIP + 1;
								else
									VIP = Inst[3];
								end
							end
						elseif (Enum <= 106) then
							if (Enum == 105) then
								local B;
								local A;
								Stk[Inst[2]] = Upvalues[Inst[3]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Inst[3];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Inst[3];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								A = Inst[2];
								Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Stk[Inst[3]][Stk[Inst[4]]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								A = Inst[2];
								B = Stk[Inst[3]];
								Stk[A + 1] = B;
								Stk[A] = B[Inst[4]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								A = Inst[2];
								Stk[A] = Stk[A](Stk[A + 1]);
								VIP = VIP + 1;
								Inst = Instr[VIP];
								if Stk[Inst[2]] then
									VIP = VIP + 1;
								else
									VIP = Inst[3];
								end
							else
								local B;
								local Edx;
								local Results, Limit;
								local A;
								Stk[Inst[2]] = Upvalues[Inst[3]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Inst[3];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Inst[3];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								A = Inst[2];
								Results, Limit = _R(Stk[A](Unpack(Stk, A + 1, Inst[3])));
								Top = (Limit + A) - 1;
								Edx = 0;
								for Idx = A, Top do
									Edx = Edx + 1;
									Stk[Idx] = Results[Edx];
								end
								VIP = VIP + 1;
								Inst = Instr[VIP];
								A = Inst[2];
								Stk[A] = Stk[A](Unpack(Stk, A + 1, Top));
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Inst[3];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								A = Inst[2];
								B = Stk[Inst[3]];
								Stk[A + 1] = B;
								Stk[A] = B[Stk[Inst[4]]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Inst[3];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								A = Inst[2];
								Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
								VIP = VIP + 1;
								Inst = Instr[VIP];
								if Stk[Inst[2]] then
									VIP = VIP + 1;
								else
									VIP = Inst[3];
								end
							end
						elseif (Enum > 107) then
							Stk[Inst[2]] = Inst[3];
						else
							local B;
							local A;
							Stk[Inst[2]] = Upvalues[Inst[3]];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Inst[3];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Inst[3];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							A = Inst[2];
							Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Stk[Inst[3]][Stk[Inst[4]]];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							A = Inst[2];
							B = Stk[Inst[3]];
							Stk[A + 1] = B;
							Stk[A] = B[Inst[4]];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							A = Inst[2];
							Stk[A] = Stk[A](Stk[A + 1]);
							VIP = VIP + 1;
							Inst = Instr[VIP];
							if Stk[Inst[2]] then
								VIP = VIP + 1;
							else
								VIP = Inst[3];
							end
						end
					elseif (Enum <= 163) then
						if (Enum <= 135) then
							if (Enum <= 121) then
								if (Enum <= 114) then
									if (Enum <= 111) then
										if (Enum <= 109) then
											local A = Inst[2];
											local Index = Stk[A];
											local Step = Stk[A + 2];
											if (Step > 0) then
												if (Index > Stk[A + 1]) then
													VIP = Inst[3];
												else
													Stk[A + 3] = Index;
												end
											elseif (Index < Stk[A + 1]) then
												VIP = Inst[3];
											else
												Stk[A + 3] = Index;
											end
										elseif (Enum == 110) then
											local A;
											Stk[Inst[2]] = Upvalues[Inst[3]];
											VIP = VIP + 1;
											Inst = Instr[VIP];
											Stk[Inst[2]] = Inst[3];
											VIP = VIP + 1;
											Inst = Instr[VIP];
											Stk[Inst[2]] = Inst[3];
											VIP = VIP + 1;
											Inst = Instr[VIP];
											A = Inst[2];
											Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
											VIP = VIP + 1;
											Inst = Instr[VIP];
											Stk[Inst[2]][Stk[Inst[3]]] = Inst[4];
											VIP = VIP + 1;
											Inst = Instr[VIP];
											Stk[Inst[2]] = Upvalues[Inst[3]];
											VIP = VIP + 1;
											Inst = Instr[VIP];
											Stk[Inst[2]] = Inst[3];
											VIP = VIP + 1;
											Inst = Instr[VIP];
											Stk[Inst[2]] = Inst[3];
											VIP = VIP + 1;
											Inst = Instr[VIP];
											A = Inst[2];
											do
												return Stk[A](Unpack(Stk, A + 1, Inst[3]));
											end
											VIP = VIP + 1;
											Inst = Instr[VIP];
											A = Inst[2];
											do
												return Unpack(Stk, A, Top);
											end
											VIP = VIP + 1;
											Inst = Instr[VIP];
											VIP = Inst[3];
										else
											local A;
											A = Inst[2];
											Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
											VIP = VIP + 1;
											Inst = Instr[VIP];
											Stk[Inst[2]] = Upvalues[Inst[3]];
											VIP = VIP + 1;
											Inst = Instr[VIP];
											Stk[Inst[2]] = Inst[3];
											VIP = VIP + 1;
											Inst = Instr[VIP];
											Stk[Inst[2]] = Inst[3];
											VIP = VIP + 1;
											Inst = Instr[VIP];
											A = Inst[2];
											Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
											VIP = VIP + 1;
											Inst = Instr[VIP];
											Stk[Inst[2]] = Stk[Inst[3]][Stk[Inst[4]]];
											VIP = VIP + 1;
											Inst = Instr[VIP];
											Stk[Inst[2]] = Upvalues[Inst[3]];
											VIP = VIP + 1;
											Inst = Instr[VIP];
											Stk[Inst[2]] = Inst[3];
											VIP = VIP + 1;
											Inst = Instr[VIP];
											Stk[Inst[2]] = Inst[3];
											VIP = VIP + 1;
											Inst = Instr[VIP];
											A = Inst[2];
											Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
										end
									elseif (Enum <= 112) then
										local A;
										A = Inst[2];
										Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Stk[Inst[3]][Stk[Inst[4]]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Upvalues[Inst[3]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Inst[3];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Inst[3];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										A = Inst[2];
										Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Stk[Inst[3]][Stk[Inst[4]]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Upvalues[Inst[3]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Inst[3];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Inst[3];
									elseif (Enum == 113) then
										if (Inst[2] <= Inst[4]) then
											VIP = VIP + 1;
										else
											VIP = Inst[3];
										end
									else
										local A = Inst[2];
										Stk[A] = Stk[A](Stk[A + 1]);
									end
								elseif (Enum <= 117) then
									if (Enum <= 115) then
										local B;
										local A;
										Stk[Inst[2]] = Upvalues[Inst[3]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Inst[3];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Inst[3];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										A = Inst[2];
										Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Stk[Inst[3]][Stk[Inst[4]]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										A = Inst[2];
										B = Stk[Inst[3]];
										Stk[A + 1] = B;
										Stk[A] = B[Inst[4]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										A = Inst[2];
										Stk[A] = Stk[A](Stk[A + 1]);
										VIP = VIP + 1;
										Inst = Instr[VIP];
										if Stk[Inst[2]] then
											VIP = VIP + 1;
										else
											VIP = Inst[3];
										end
									elseif (Enum > 116) then
										local A;
										Stk[Inst[2]] = Upvalues[Inst[3]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Inst[3];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Inst[3];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										A = Inst[2];
										Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Stk[Inst[3]][Stk[Inst[4]]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Upvalues[Inst[3]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Inst[3];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Inst[3];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										A = Inst[2];
										Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Upvalues[Inst[3]];
									else
										local A = Inst[2];
										local Results, Limit = _R(Stk[A]());
										Top = (Limit + A) - 1;
										local Edx = 0;
										for Idx = A, Top do
											Edx = Edx + 1;
											Stk[Idx] = Results[Edx];
										end
									end
								elseif (Enum <= 119) then
									if (Enum > 118) then
										Stk[Inst[2]] = Inst[3] ~= 0;
									else
										local B;
										local A;
										A = Inst[2];
										B = Stk[Inst[3]];
										Stk[A + 1] = B;
										Stk[A] = B[Inst[4]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										for Idx = Inst[2], Inst[3] do
											Stk[Idx] = nil;
										end
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Stk[Inst[3]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										A = Inst[2];
										Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Stk[Inst[3]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Upvalues[Inst[3]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										if (Stk[Inst[2]] < Stk[Inst[4]]) then
											VIP = Inst[3];
										else
											VIP = VIP + 1;
										end
									end
								elseif (Enum > 120) then
									local B;
									local A;
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									A = Inst[2];
									Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Stk[Inst[3]][Stk[Inst[4]]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									B = Stk[Inst[4]];
									if not B then
										VIP = VIP + 1;
									else
										Stk[Inst[2]] = B;
										VIP = Inst[3];
									end
								else
									local A;
									Stk[Inst[2]] = Upvalues[Inst[3]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									A = Inst[2];
									Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Stk[Inst[3]][Stk[Inst[4]]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Upvalues[Inst[3]] = Stk[Inst[2]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Env[Inst[3]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Upvalues[Inst[3]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
								end
							elseif (Enum <= 128) then
								if (Enum <= 124) then
									if (Enum <= 122) then
										Stk[Inst[2]] = Inst[3] ~= 0;
										VIP = VIP + 1;
									elseif (Enum > 123) then
										if not Stk[Inst[2]] then
											VIP = VIP + 1;
										else
											VIP = Inst[3];
										end
									else
										Stk[Inst[2]] = Upvalues[Inst[3]];
									end
								elseif (Enum <= 126) then
									if (Enum == 125) then
										local A = Inst[2];
										local T = Stk[A];
										local B = Inst[3];
										for Idx = 1, B do
											T[Idx] = Stk[A + Idx];
										end
									else
										local B;
										local Edx;
										local Results, Limit;
										local A;
										Stk[Inst[2]] = Upvalues[Inst[3]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Inst[3];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Inst[3];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										A = Inst[2];
										Results, Limit = _R(Stk[A](Unpack(Stk, A + 1, Inst[3])));
										Top = (Limit + A) - 1;
										Edx = 0;
										for Idx = A, Top do
											Edx = Edx + 1;
											Stk[Idx] = Results[Edx];
										end
										VIP = VIP + 1;
										Inst = Instr[VIP];
										A = Inst[2];
										Stk[A] = Stk[A](Unpack(Stk, A + 1, Top));
										VIP = VIP + 1;
										Inst = Instr[VIP];
										A = Inst[2];
										B = Stk[Inst[3]];
										Stk[A + 1] = B;
										Stk[A] = B[Inst[4]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Inst[3];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										A = Inst[2];
										Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
										VIP = VIP + 1;
										Inst = Instr[VIP];
										if Stk[Inst[2]] then
											VIP = VIP + 1;
										else
											VIP = Inst[3];
										end
									end
								elseif (Enum > 127) then
									local A;
									Stk[Inst[2]] = Upvalues[Inst[3]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									A = Inst[2];
									Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Stk[Inst[3]][Stk[Inst[4]]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Upvalues[Inst[3]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									A = Inst[2];
									Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Stk[Inst[3]][Stk[Inst[4]]];
								else
									local A;
									Stk[Inst[2]] = Upvalues[Inst[3]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									A = Inst[2];
									Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]][Stk[Inst[3]]] = Stk[Inst[4]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Upvalues[Inst[3]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									A = Inst[2];
									do
										return Stk[A](Unpack(Stk, A + 1, Inst[3]));
									end
									VIP = VIP + 1;
									Inst = Instr[VIP];
									A = Inst[2];
									do
										return Unpack(Stk, A, Top);
									end
									VIP = VIP + 1;
									Inst = Instr[VIP];
									VIP = Inst[3];
								end
							elseif (Enum <= 131) then
								if (Enum <= 129) then
									local Edx;
									local Results, Limit;
									local A;
									Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Upvalues[Inst[3]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									A = Inst[2];
									Results, Limit = _R(Stk[A](Stk[A + 1]));
									Top = (Limit + A) - 1;
									Edx = 0;
									for Idx = A, Top do
										Edx = Edx + 1;
										Stk[Idx] = Results[Edx];
									end
									VIP = VIP + 1;
									Inst = Instr[VIP];
									A = Inst[2];
									Stk[A] = Stk[A](Unpack(Stk, A + 1, Top));
									VIP = VIP + 1;
									Inst = Instr[VIP];
									if Stk[Inst[2]] then
										VIP = VIP + 1;
									else
										VIP = Inst[3];
									end
								elseif (Enum > 130) then
									local B;
									local A;
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									A = Inst[2];
									Stk[A] = Stk[A](Stk[A + 1]);
									VIP = VIP + 1;
									Inst = Instr[VIP];
									A = Inst[2];
									B = Stk[Inst[3]];
									Stk[A + 1] = B;
									Stk[A] = B[Inst[4]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									A = Inst[2];
									Stk[A] = Stk[A](Stk[A + 1]);
									VIP = VIP + 1;
									Inst = Instr[VIP];
									if Stk[Inst[2]] then
										VIP = VIP + 1;
									else
										VIP = Inst[3];
									end
								else
									Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
								end
							elseif (Enum <= 133) then
								if (Enum == 132) then
									local B;
									local A;
									Stk[Inst[2]] = Upvalues[Inst[3]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									A = Inst[2];
									Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Stk[Inst[3]][Stk[Inst[4]]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									A = Inst[2];
									B = Stk[Inst[3]];
									Stk[A + 1] = B;
									Stk[A] = B[Inst[4]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									A = Inst[2];
									Stk[A] = Stk[A](Stk[A + 1]);
									VIP = VIP + 1;
									Inst = Instr[VIP];
									if (Stk[Inst[2]] <= Inst[4]) then
										VIP = VIP + 1;
									else
										VIP = Inst[3];
									end
								else
									local K;
									local B;
									local A;
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									A = Inst[2];
									Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Upvalues[Inst[3]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									B = Inst[3];
									K = Stk[B];
									for Idx = B + 1, Inst[4] do
										K = K .. Stk[Idx];
									end
									Stk[Inst[2]] = K;
									VIP = VIP + 1;
									Inst = Instr[VIP];
									do
										return Stk[Inst[2]];
									end
								end
							elseif (Enum > 134) then
								local A;
								Stk[Inst[2]] = Upvalues[Inst[3]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Upvalues[Inst[3]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Inst[3];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Inst[3];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								A = Inst[2];
								Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Stk[Inst[3]][Stk[Inst[4]]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Upvalues[Inst[3]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Inst[3];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Inst[3];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								A = Inst[2];
								Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
							else
								local A;
								Stk[Inst[2]] = Upvalues[Inst[3]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Inst[3];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Inst[3];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								A = Inst[2];
								Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]][Stk[Inst[3]]] = Inst[4];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Upvalues[Inst[3]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Inst[3];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Inst[3];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								A = Inst[2];
								do
									return Stk[A](Unpack(Stk, A + 1, Inst[3]));
								end
								VIP = VIP + 1;
								Inst = Instr[VIP];
								A = Inst[2];
								do
									return Unpack(Stk, A, Top);
								end
								VIP = VIP + 1;
								Inst = Instr[VIP];
								VIP = Inst[3];
							end
						elseif (Enum <= 149) then
							if (Enum <= 142) then
								if (Enum <= 138) then
									if (Enum <= 136) then
										local B;
										local A;
										Stk[Inst[2]] = Upvalues[Inst[3]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Inst[3];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Inst[3];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										A = Inst[2];
										Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Stk[Inst[3]][Stk[Inst[4]]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										A = Inst[2];
										B = Stk[Inst[3]];
										Stk[A + 1] = B;
										Stk[A] = B[Inst[4]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										A = Inst[2];
										Stk[A] = Stk[A](Stk[A + 1]);
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Inst[3];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										if (Stk[Inst[2]] < Stk[Inst[4]]) then
											VIP = Inst[3];
										else
											VIP = VIP + 1;
										end
									elseif (Enum > 137) then
										local B;
										local A;
										Stk[Inst[2]] = Upvalues[Inst[3]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Upvalues[Inst[3]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Upvalues[Inst[3]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Inst[3];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Inst[3];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										A = Inst[2];
										Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Stk[Inst[3]][Stk[Inst[4]]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										A = Inst[2];
										B = Stk[Inst[3]];
										Stk[A + 1] = B;
										Stk[A] = B[Inst[4]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										A = Inst[2];
										Stk[A] = Stk[A](Stk[A + 1]);
										VIP = VIP + 1;
										Inst = Instr[VIP];
										if Stk[Inst[2]] then
											VIP = VIP + 1;
										else
											VIP = Inst[3];
										end
									else
										local B;
										local A;
										Stk[Inst[2]] = Upvalues[Inst[3]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Inst[3];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Inst[3];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										A = Inst[2];
										Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Stk[Inst[3]][Stk[Inst[4]]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										A = Inst[2];
										B = Stk[Inst[3]];
										Stk[A + 1] = B;
										Stk[A] = B[Inst[4]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Env[Inst[3]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										A = Inst[2];
										Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Inst[3];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										if (Stk[Inst[2]] <= Stk[Inst[4]]) then
											VIP = VIP + 1;
										else
											VIP = Inst[3];
										end
									end
								elseif (Enum <= 140) then
									if (Enum == 139) then
										local A;
										A = Inst[2];
										Stk[A] = Stk[A]();
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Upvalues[Inst[3]] = Stk[Inst[2]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Upvalues[Inst[3]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Upvalues[Inst[3]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Upvalues[Inst[3]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Upvalues[Inst[3]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Inst[3];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Inst[3];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										A = Inst[2];
										Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Stk[Inst[3]][Stk[Inst[4]]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Upvalues[Inst[3]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Inst[3];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Inst[3];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										A = Inst[2];
										Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Stk[Inst[3]][Stk[Inst[4]]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Upvalues[Inst[3]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Inst[3];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Inst[3];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										A = Inst[2];
										Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Stk[Inst[3]][Stk[Inst[4]]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										A = Inst[2];
										Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Upvalues[Inst[3]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Upvalues[Inst[3]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Upvalues[Inst[3]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Upvalues[Inst[3]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Inst[3];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Inst[3];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										A = Inst[2];
										Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Stk[Inst[3]][Stk[Inst[4]]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Upvalues[Inst[3]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Inst[3];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Inst[3];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										A = Inst[2];
										Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Stk[Inst[3]][Stk[Inst[4]]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Upvalues[Inst[3]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Inst[3];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Inst[3];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										A = Inst[2];
										Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Stk[Inst[3]][Stk[Inst[4]]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										A = Inst[2];
										Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Stk[Inst[3]] + Stk[Inst[4]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Upvalues[Inst[3]] = Stk[Inst[2]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										VIP = Inst[3];
									else
										local B;
										local A;
										Stk[Inst[2]] = Upvalues[Inst[3]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										A = Inst[2];
										Stk[A] = Stk[A]();
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Upvalues[Inst[3]] = Stk[Inst[2]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Upvalues[Inst[3]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										A = Inst[2];
										B = Stk[Inst[3]];
										Stk[A + 1] = B;
										Stk[A] = B[Inst[4]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										A = Inst[2];
										Stk[A] = Stk[A](Stk[A + 1]);
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Upvalues[Inst[3]] = Stk[Inst[2]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Upvalues[Inst[3]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Upvalues[Inst[3]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										A = Inst[2];
										Stk[A] = Stk[A](Stk[A + 1]);
									end
								elseif (Enum > 141) then
									local B;
									local A;
									A = Inst[2];
									B = Stk[Inst[3]];
									Stk[A + 1] = B;
									Stk[A] = B[Inst[4]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									A = Inst[2];
									Stk[A] = Stk[A](Stk[A + 1]);
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Upvalues[Inst[3]] = Stk[Inst[2]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Upvalues[Inst[3]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									if Stk[Inst[2]] then
										VIP = VIP + 1;
									else
										VIP = Inst[3];
									end
								else
									local A;
									Stk[Inst[2]] = Upvalues[Inst[3]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									A = Inst[2];
									Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Stk[Inst[3]][Stk[Inst[4]]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Upvalues[Inst[3]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									A = Inst[2];
									Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Stk[Inst[3]][Stk[Inst[4]]];
								end
							elseif (Enum <= 145) then
								if (Enum <= 143) then
									local B;
									local A;
									A = Inst[2];
									B = Stk[Inst[3]];
									Stk[A + 1] = B;
									Stk[A] = B[Inst[4]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Upvalues[Inst[3]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									A = Inst[2];
									Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
									VIP = VIP + 1;
									Inst = Instr[VIP];
									if Stk[Inst[2]] then
										VIP = VIP + 1;
									else
										VIP = Inst[3];
									end
								elseif (Enum == 144) then
									Stk[Inst[2]] = Stk[Inst[3]] + Inst[4];
								else
									local A = Inst[2];
									local Results, Limit = _R(Stk[A](Unpack(Stk, A + 1, Top)));
									Top = (Limit + A) - 1;
									local Edx = 0;
									for Idx = A, Top do
										Edx = Edx + 1;
										Stk[Idx] = Results[Edx];
									end
								end
							elseif (Enum <= 147) then
								if (Enum > 146) then
									local A = Inst[2];
									do
										return Stk[A](Unpack(Stk, A + 1, Inst[3]));
									end
								else
									local Edx;
									local Results, Limit;
									local B;
									local A;
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									A = Inst[2];
									Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Stk[Inst[3]][Stk[Inst[4]]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									A = Inst[2];
									B = Stk[Inst[3]];
									Stk[A + 1] = B;
									Stk[A] = B[Inst[4]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									A = Inst[2];
									Results, Limit = _R(Stk[A](Stk[A + 1]));
									Top = (Limit + A) - 1;
									Edx = 0;
									for Idx = A, Top do
										Edx = Edx + 1;
										Stk[Idx] = Results[Edx];
									end
									VIP = VIP + 1;
									Inst = Instr[VIP];
									A = Inst[2];
									Stk[A] = Stk[A](Unpack(Stk, A + 1, Top));
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Upvalues[Inst[3]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Upvalues[Inst[3]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									A = Inst[2];
									B = Stk[Inst[3]];
									Stk[A + 1] = B;
									Stk[A] = B[Inst[4]];
								end
							elseif (Enum > 148) then
								local B;
								local A;
								A = Inst[2];
								B = Stk[Inst[3]];
								Stk[A + 1] = B;
								Stk[A] = B[Inst[4]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Upvalues[Inst[3]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								A = Inst[2];
								Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
								VIP = VIP + 1;
								Inst = Instr[VIP];
								VIP = Inst[3];
							else
								local A;
								Stk[Inst[2]] = Upvalues[Inst[3]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Inst[3];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Inst[3];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								A = Inst[2];
								Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Stk[Inst[3]][Stk[Inst[4]]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Upvalues[Inst[3]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Inst[3];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Inst[3];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								A = Inst[2];
								Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]][Stk[Inst[3]]] = Inst[4];
							end
						elseif (Enum <= 156) then
							if (Enum <= 152) then
								if (Enum <= 150) then
									local B;
									local A;
									Stk[Inst[2]] = Upvalues[Inst[3]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									A = Inst[2];
									B = Stk[Inst[3]];
									Stk[A + 1] = B;
									Stk[A] = B[Stk[Inst[4]]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									A = Inst[2];
									Stk[A] = Stk[A](Stk[A + 1]);
									VIP = VIP + 1;
									Inst = Instr[VIP];
									if Stk[Inst[2]] then
										VIP = VIP + 1;
									else
										VIP = Inst[3];
									end
								elseif (Enum == 151) then
									local B;
									local A;
									Stk[Inst[2]] = Upvalues[Inst[3]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									A = Inst[2];
									Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Stk[Inst[3]][Stk[Inst[4]]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									A = Inst[2];
									B = Stk[Inst[3]];
									Stk[A + 1] = B;
									Stk[A] = B[Inst[4]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									A = Inst[2];
									Stk[A] = Stk[A](Stk[A + 1]);
									VIP = VIP + 1;
									Inst = Instr[VIP];
									if Stk[Inst[2]] then
										VIP = VIP + 1;
									else
										VIP = Inst[3];
									end
								else
									local B;
									local A;
									Stk[Inst[2]] = Upvalues[Inst[3]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									A = Inst[2];
									Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Stk[Inst[3]][Stk[Inst[4]]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									A = Inst[2];
									B = Stk[Inst[3]];
									Stk[A + 1] = B;
									Stk[A] = B[Inst[4]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									A = Inst[2];
									Stk[A] = Stk[A](Stk[A + 1]);
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									if (Stk[Inst[2]] < Stk[Inst[4]]) then
										VIP = Inst[3];
									else
										VIP = VIP + 1;
									end
								end
							elseif (Enum <= 154) then
								if (Enum > 153) then
									local B;
									local A;
									Stk[Inst[2]] = Upvalues[Inst[3]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									A = Inst[2];
									Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Stk[Inst[3]][Stk[Inst[4]]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									A = Inst[2];
									B = Stk[Inst[3]];
									Stk[A + 1] = B;
									Stk[A] = B[Inst[4]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									A = Inst[2];
									Stk[A] = Stk[A](Stk[A + 1]);
									VIP = VIP + 1;
									Inst = Instr[VIP];
									if Stk[Inst[2]] then
										VIP = VIP + 1;
									else
										VIP = Inst[3];
									end
								else
									local Edx;
									local Results, Limit;
									local B;
									local A;
									A = Inst[2];
									Stk[A] = Stk[A](Unpack(Stk, A + 1, Top));
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Upvalues[Inst[3]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Upvalues[Inst[3]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Upvalues[Inst[3]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									A = Inst[2];
									Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Stk[Inst[3]][Stk[Inst[4]]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									A = Inst[2];
									B = Stk[Inst[3]];
									Stk[A + 1] = B;
									Stk[A] = B[Inst[4]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									A = Inst[2];
									Results, Limit = _R(Stk[A](Stk[A + 1]));
									Top = (Limit + A) - 1;
									Edx = 0;
									for Idx = A, Top do
										Edx = Edx + 1;
										Stk[Idx] = Results[Edx];
									end
								end
							elseif (Enum == 155) then
								local A;
								A = Inst[2];
								Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Stk[Inst[3]][Stk[Inst[4]]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Upvalues[Inst[3]] = Stk[Inst[2]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Env[Inst[3]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Upvalues[Inst[3]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Inst[3];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Inst[3];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								A = Inst[2];
								Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Stk[Inst[3]][Stk[Inst[4]]];
							else
								local A = Inst[2];
								Stk[A] = Stk[A](Unpack(Stk, A + 1, Top));
							end
						elseif (Enum <= 159) then
							if (Enum <= 157) then
								local A;
								Stk[Inst[2]] = Upvalues[Inst[3]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Inst[3];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Inst[3];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								A = Inst[2];
								Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Stk[Inst[3]][Stk[Inst[4]]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Upvalues[Inst[3]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Inst[3];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Inst[3];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								A = Inst[2];
								Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Upvalues[Inst[3]];
							elseif (Enum > 158) then
								local A;
								Stk[Inst[2]] = Upvalues[Inst[3]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Inst[3];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Inst[3];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								A = Inst[2];
								Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = {};
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]][Stk[Inst[3]]] = Stk[Inst[4]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Upvalues[Inst[3]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Upvalues[Inst[3]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Inst[3];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Inst[3];
							else
								local B;
								local A;
								Stk[Inst[2]] = Inst[3];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								A = Inst[2];
								B = Stk[Inst[3]];
								Stk[A + 1] = B;
								Stk[A] = B[Stk[Inst[4]]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Inst[3];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Inst[3];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								A = Inst[2];
								Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
								VIP = VIP + 1;
								Inst = Instr[VIP];
								if not Stk[Inst[2]] then
									VIP = VIP + 1;
								else
									VIP = Inst[3];
								end
							end
						elseif (Enum <= 161) then
							if (Enum > 160) then
								local A;
								Stk[Inst[2]] = Stk[Inst[3]][Stk[Inst[4]]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Env[Inst[3]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Upvalues[Inst[3]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Inst[3];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Inst[3];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								A = Inst[2];
								Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Stk[Inst[3]][Stk[Inst[4]]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Env[Inst[3]];
							else
								local B;
								local A;
								Stk[Inst[2]] = Upvalues[Inst[3]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Inst[3];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Inst[3];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								A = Inst[2];
								Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Stk[Inst[3]][Stk[Inst[4]]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								A = Inst[2];
								B = Stk[Inst[3]];
								Stk[A + 1] = B;
								Stk[A] = B[Inst[4]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								A = Inst[2];
								Stk[A] = Stk[A](Stk[A + 1]);
								VIP = VIP + 1;
								Inst = Instr[VIP];
								if not Stk[Inst[2]] then
									VIP = VIP + 1;
								else
									VIP = Inst[3];
								end
							end
						elseif (Enum > 162) then
							local A;
							Stk[Inst[2]] = Upvalues[Inst[3]];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Inst[3];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Inst[3];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							A = Inst[2];
							Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Inst[3];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]][Stk[Inst[3]]] = Stk[Inst[4]];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Upvalues[Inst[3]];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Inst[3];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Inst[3];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							A = Inst[2];
							do
								return Stk[A](Unpack(Stk, A + 1, Inst[3]));
							end
							VIP = VIP + 1;
							Inst = Instr[VIP];
							A = Inst[2];
							do
								return Unpack(Stk, A, Top);
							end
							VIP = VIP + 1;
							Inst = Instr[VIP];
							VIP = Inst[3];
						else
							local Edx;
							local Results, Limit;
							local B;
							local A;
							Stk[Inst[2]] = Upvalues[Inst[3]];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Upvalues[Inst[3]];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Upvalues[Inst[3]];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Inst[3];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Inst[3];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							A = Inst[2];
							Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Stk[Inst[3]][Stk[Inst[4]]];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							A = Inst[2];
							B = Stk[Inst[3]];
							Stk[A + 1] = B;
							Stk[A] = B[Inst[4]];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							A = Inst[2];
							Results, Limit = _R(Stk[A](Stk[A + 1]));
							Top = (Limit + A) - 1;
							Edx = 0;
							for Idx = A, Top do
								Edx = Edx + 1;
								Stk[Idx] = Results[Edx];
							end
							VIP = VIP + 1;
							Inst = Instr[VIP];
							A = Inst[2];
							Stk[A] = Stk[A](Unpack(Stk, A + 1, Top));
						end
					elseif (Enum <= 190) then
						if (Enum <= 176) then
							if (Enum <= 169) then
								if (Enum <= 166) then
									if (Enum <= 164) then
										local B;
										local A;
										A = Inst[2];
										B = Stk[Inst[3]];
										Stk[A + 1] = B;
										Stk[A] = B[Inst[4]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Upvalues[Inst[3]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										A = Inst[2];
										Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
										VIP = VIP + 1;
										Inst = Instr[VIP];
										if not Stk[Inst[2]] then
											VIP = VIP + 1;
										else
											VIP = Inst[3];
										end
									elseif (Enum > 165) then
										local B;
										local A;
										A = Inst[2];
										B = Stk[Inst[3]];
										Stk[A + 1] = B;
										Stk[A] = B[Inst[4]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Upvalues[Inst[3]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Inst[3];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Stk[Inst[3]][Stk[Inst[4]]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										A = Inst[2];
										Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
										VIP = VIP + 1;
										Inst = Instr[VIP];
										if Stk[Inst[2]] then
											VIP = VIP + 1;
										else
											VIP = Inst[3];
										end
									elseif (Stk[Inst[2]] <= Inst[4]) then
										VIP = VIP + 1;
									else
										VIP = Inst[3];
									end
								elseif (Enum <= 167) then
									local B;
									local Edx;
									local Results, Limit;
									local A;
									Stk[Inst[2]] = Upvalues[Inst[3]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									A = Inst[2];
									Results, Limit = _R(Stk[A](Unpack(Stk, A + 1, Inst[3])));
									Top = (Limit + A) - 1;
									Edx = 0;
									for Idx = A, Top do
										Edx = Edx + 1;
										Stk[Idx] = Results[Edx];
									end
									VIP = VIP + 1;
									Inst = Instr[VIP];
									A = Inst[2];
									Stk[A] = Stk[A](Unpack(Stk, A + 1, Top));
									VIP = VIP + 1;
									Inst = Instr[VIP];
									A = Inst[2];
									B = Stk[Inst[3]];
									Stk[A + 1] = B;
									Stk[A] = B[Inst[4]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									A = Inst[2];
									Stk[A] = Stk[A](Stk[A + 1]);
									VIP = VIP + 1;
									Inst = Instr[VIP];
									if (Stk[Inst[2]] ~= Inst[4]) then
										VIP = VIP + 1;
									else
										VIP = Inst[3];
									end
								elseif (Enum == 168) then
									local B;
									local A;
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									A = Inst[2];
									B = Stk[Inst[3]];
									Stk[A + 1] = B;
									Stk[A] = B[Stk[Inst[4]]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									A = Inst[2];
									Stk[A] = Stk[A](Stk[A + 1]);
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Upvalues[Inst[3]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Upvalues[Inst[3]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									A = Inst[2];
									Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Stk[Inst[3]][Stk[Inst[4]]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Upvalues[Inst[3]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									A = Inst[2];
									Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Stk[Inst[3]][Stk[Inst[4]]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									if (Stk[Inst[2]] < Stk[Inst[4]]) then
										VIP = VIP + 1;
									else
										VIP = Inst[3];
									end
								else
									local B;
									local A;
									Stk[Inst[2]] = Upvalues[Inst[3]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									A = Inst[2];
									Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Stk[Inst[3]][Stk[Inst[4]]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									A = Inst[2];
									B = Stk[Inst[3]];
									Stk[A + 1] = B;
									Stk[A] = B[Inst[4]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									A = Inst[2];
									Stk[A] = Stk[A](Stk[A + 1]);
									VIP = VIP + 1;
									Inst = Instr[VIP];
									if Stk[Inst[2]] then
										VIP = VIP + 1;
									else
										VIP = Inst[3];
									end
								end
							elseif (Enum <= 172) then
								if (Enum <= 170) then
									local Edx;
									local Results, Limit;
									local B;
									local A;
									Stk[Inst[2]] = Upvalues[Inst[3]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Upvalues[Inst[3]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Upvalues[Inst[3]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									A = Inst[2];
									B = Stk[Inst[3]];
									Stk[A + 1] = B;
									Stk[A] = B[Inst[4]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Upvalues[Inst[3]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									A = Inst[2];
									Results, Limit = _R(Stk[A](Unpack(Stk, A + 1, Inst[3])));
									Top = (Limit + A) - 1;
									Edx = 0;
									for Idx = A, Top do
										Edx = Edx + 1;
										Stk[Idx] = Results[Edx];
									end
									VIP = VIP + 1;
									Inst = Instr[VIP];
									A = Inst[2];
									Results, Limit = _R(Stk[A](Unpack(Stk, A + 1, Top)));
									Top = (Limit + A) - 1;
									Edx = 0;
									for Idx = A, Top do
										Edx = Edx + 1;
										Stk[Idx] = Results[Edx];
									end
									VIP = VIP + 1;
									Inst = Instr[VIP];
									A = Inst[2];
									Stk[A] = Stk[A](Unpack(Stk, A + 1, Top));
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Stk[Inst[3]] + Stk[Inst[4]];
								elseif (Enum > 171) then
									local A = Inst[2];
									local B = Stk[Inst[3]];
									Stk[A + 1] = B;
									Stk[A] = B[Inst[4]];
								elseif (Stk[Inst[2]] == Inst[4]) then
									VIP = VIP + 1;
								else
									VIP = Inst[3];
								end
							elseif (Enum <= 174) then
								if (Enum == 173) then
									local A;
									Stk[Inst[2]] = Stk[Inst[3]] - Stk[Inst[4]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									A = Inst[2];
									Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Upvalues[Inst[3]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Stk[Inst[3]] - Stk[Inst[4]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									A = Inst[2];
									Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Stk[Inst[3]] + Stk[Inst[4]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Env[Inst[3]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									A = Inst[2];
									Stk[A] = Stk[A]();
								else
									local A;
									Stk[Inst[2]] = Upvalues[Inst[3]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									A = Inst[2];
									Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Stk[Inst[3]][Stk[Inst[4]]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Upvalues[Inst[3]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									A = Inst[2];
									Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Stk[Inst[3]][Stk[Inst[4]]];
								end
							elseif (Enum > 175) then
								local A;
								Stk[Inst[2]] = Upvalues[Inst[3]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Inst[3];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Inst[3];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								A = Inst[2];
								Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Stk[Inst[3]][Stk[Inst[4]]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Upvalues[Inst[3]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Inst[3];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Inst[3];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								A = Inst[2];
								Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Stk[Inst[3]][Stk[Inst[4]]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Upvalues[Inst[3]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Inst[3];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Inst[3];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								A = Inst[2];
								Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Stk[Inst[3]][Stk[Inst[4]]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								if not Stk[Inst[2]] then
									VIP = VIP + 1;
								else
									VIP = Inst[3];
								end
							else
								local A;
								Upvalues[Inst[3]] = Stk[Inst[2]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Env[Inst[3]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Upvalues[Inst[3]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Inst[3];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Inst[3];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								A = Inst[2];
								Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Stk[Inst[3]][Stk[Inst[4]]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = not Stk[Inst[3]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Upvalues[Inst[3]] = Stk[Inst[2]];
							end
						elseif (Enum <= 183) then
							if (Enum <= 179) then
								if (Enum <= 177) then
									Stk[Inst[2]] = Wrap(Proto[Inst[3]], nil, Env);
								elseif (Enum == 178) then
									local A;
									Stk[Inst[2]] = Upvalues[Inst[3]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									A = Inst[2];
									Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Stk[Inst[3]][Stk[Inst[4]]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Upvalues[Inst[3]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									A = Inst[2];
									Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Stk[Inst[3]][Stk[Inst[4]]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Upvalues[Inst[3]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									A = Inst[2];
									Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
									VIP = VIP + 1;
									Inst = Instr[VIP];
									if (Stk[Inst[2]] == Stk[Inst[4]]) then
										VIP = VIP + 1;
									else
										VIP = Inst[3];
									end
								else
									local B;
									local A;
									Stk[Inst[2]] = Upvalues[Inst[3]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									A = Inst[2];
									Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Stk[Inst[3]][Stk[Inst[4]]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									A = Inst[2];
									B = Stk[Inst[3]];
									Stk[A + 1] = B;
									Stk[A] = B[Inst[4]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									A = Inst[2];
									Stk[A] = Stk[A](Stk[A + 1]);
									VIP = VIP + 1;
									Inst = Instr[VIP];
									if Stk[Inst[2]] then
										VIP = VIP + 1;
									else
										VIP = Inst[3];
									end
								end
							elseif (Enum <= 181) then
								if (Enum > 180) then
									local A = Inst[2];
									do
										return Unpack(Stk, A, Top);
									end
								else
									local A;
									Stk[Inst[2]] = Upvalues[Inst[3]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									A = Inst[2];
									Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Stk[Inst[3]][Stk[Inst[4]]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									do
										return Stk[Inst[2]];
									end
								end
							elseif (Enum == 182) then
								local A;
								Stk[Inst[2]] = Inst[3];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Stk[Inst[3]][Stk[Inst[4]]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Upvalues[Inst[3]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Inst[3];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Stk[Inst[3]][Stk[Inst[4]]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								A = Inst[2];
								Stk[A] = Stk[A](Stk[A + 1]);
								VIP = VIP + 1;
								Inst = Instr[VIP];
								if Stk[Inst[2]] then
									VIP = VIP + 1;
								else
									VIP = Inst[3];
								end
							else
								local Edx;
								local Results;
								local A;
								Stk[Inst[2]] = Stk[Inst[3]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Stk[Inst[3]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Stk[Inst[3]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Stk[Inst[3]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Stk[Inst[3]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Env[Inst[3]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Stk[Inst[3]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								A = Inst[2];
								Results = {Stk[A](Stk[A + 1])};
								Edx = 0;
								for Idx = A, Inst[4] do
									Edx = Edx + 1;
									Stk[Idx] = Results[Edx];
								end
								VIP = VIP + 1;
								Inst = Instr[VIP];
								VIP = Inst[3];
							end
						elseif (Enum <= 186) then
							if (Enum <= 184) then
								local B;
								local A;
								Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = not Stk[Inst[3]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]][Inst[3]] = Stk[Inst[4]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Upvalues[Inst[3]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Upvalues[Inst[3]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Inst[3];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Inst[3];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								A = Inst[2];
								Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Stk[Inst[3]][Stk[Inst[4]]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								A = Inst[2];
								B = Stk[Inst[3]];
								Stk[A + 1] = B;
								Stk[A] = B[Inst[4]];
							elseif (Enum == 185) then
								Stk[Inst[2]] = Env[Inst[3]];
							else
								local A;
								Stk[Inst[2]] = Upvalues[Inst[3]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Inst[3];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Inst[3];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								A = Inst[2];
								Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Stk[Inst[3]][Stk[Inst[4]]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Upvalues[Inst[3]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Inst[3];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Inst[3];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								A = Inst[2];
								Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Stk[Inst[3]][Stk[Inst[4]]];
							end
						elseif (Enum <= 188) then
							if (Enum == 187) then
								local A;
								Stk[Inst[2]] = Upvalues[Inst[3]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Upvalues[Inst[3]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Inst[3];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Inst[3];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								A = Inst[2];
								Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Stk[Inst[3]][Stk[Inst[4]]];
							elseif (Stk[Inst[2]] < Inst[4]) then
								VIP = VIP + 1;
							else
								VIP = Inst[3];
							end
						elseif (Enum == 189) then
							local B;
							local A;
							A = Inst[2];
							B = Stk[Inst[3]];
							Stk[A + 1] = B;
							Stk[A] = B[Inst[4]];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Inst[3];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Inst[3];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							A = Inst[2];
							Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
							VIP = VIP + 1;
							Inst = Instr[VIP];
							if not Stk[Inst[2]] then
								VIP = VIP + 1;
							else
								VIP = Inst[3];
							end
						elseif (Inst[2] < Stk[Inst[4]]) then
							VIP = VIP + 1;
						else
							VIP = Inst[3];
						end
					elseif (Enum <= 204) then
						if (Enum <= 197) then
							if (Enum <= 193) then
								if (Enum <= 191) then
									local A;
									Stk[Inst[2]] = Upvalues[Inst[3]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									A = Inst[2];
									Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Stk[Inst[3]][Stk[Inst[4]]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Upvalues[Inst[3]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									A = Inst[2];
									Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Stk[Inst[3]][Stk[Inst[4]]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Upvalues[Inst[3]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									A = Inst[2];
									Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
									VIP = VIP + 1;
									Inst = Instr[VIP];
									if (Stk[Inst[2]] == Stk[Inst[4]]) then
										VIP = VIP + 1;
									else
										VIP = Inst[3];
									end
								elseif (Enum == 192) then
									local A = Inst[2];
									do
										return Stk[A](Unpack(Stk, A + 1, Top));
									end
								else
									local B;
									local A;
									Stk[Inst[2]] = Upvalues[Inst[3]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									A = Inst[2];
									Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Stk[Inst[3]][Stk[Inst[4]]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									A = Inst[2];
									B = Stk[Inst[3]];
									Stk[A + 1] = B;
									Stk[A] = B[Inst[4]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									A = Inst[2];
									Stk[A] = Stk[A](Stk[A + 1]);
									VIP = VIP + 1;
									Inst = Instr[VIP];
									if (Inst[2] > Stk[Inst[4]]) then
										VIP = VIP + 1;
									else
										VIP = Inst[3];
									end
								end
							elseif (Enum <= 195) then
								if (Enum == 194) then
									local A;
									Stk[Inst[2]] = Upvalues[Inst[3]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									A = Inst[2];
									Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Stk[Inst[3]][Stk[Inst[4]]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Upvalues[Inst[3]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									A = Inst[2];
									Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Stk[Inst[3]][Stk[Inst[4]]];
								else
									local Edx;
									local Results, Limit;
									local A;
									Stk[Inst[2]] = Upvalues[Inst[3]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									A = Inst[2];
									Results, Limit = _R(Stk[A](Unpack(Stk, A + 1, Inst[3])));
									Top = (Limit + A) - 1;
									Edx = 0;
									for Idx = A, Top do
										Edx = Edx + 1;
										Stk[Idx] = Results[Edx];
									end
									VIP = VIP + 1;
									Inst = Instr[VIP];
									A = Inst[2];
									Stk[A] = Stk[A](Unpack(Stk, A + 1, Top));
									VIP = VIP + 1;
									Inst = Instr[VIP];
									if Stk[Inst[2]] then
										VIP = VIP + 1;
									else
										VIP = Inst[3];
									end
								end
							elseif (Enum > 196) then
								if (Stk[Inst[2]] ~= Inst[4]) then
									VIP = VIP + 1;
								else
									VIP = Inst[3];
								end
							else
								local B;
								local A;
								Stk[Inst[2]] = Upvalues[Inst[3]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Inst[3];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Inst[3];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								A = Inst[2];
								Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Stk[Inst[3]][Stk[Inst[4]]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Inst[3];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								A = Inst[2];
								B = Stk[Inst[3]];
								Stk[A + 1] = B;
								Stk[A] = B[Stk[Inst[4]]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								A = Inst[2];
								Stk[A] = Stk[A](Stk[A + 1]);
								VIP = VIP + 1;
								Inst = Instr[VIP];
								if Stk[Inst[2]] then
									VIP = VIP + 1;
								else
									VIP = Inst[3];
								end
							end
						elseif (Enum <= 200) then
							if (Enum <= 198) then
								if (Stk[Inst[2]] <= Stk[Inst[4]]) then
									VIP = VIP + 1;
								else
									VIP = Inst[3];
								end
							elseif (Enum > 199) then
								local A;
								A = Inst[2];
								Stk[A] = Stk[A]();
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Upvalues[Inst[3]] = Stk[Inst[2]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Inst[3];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Inst[3];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								if (Stk[Inst[2]] <= Stk[Inst[4]]) then
									VIP = VIP + 1;
								else
									VIP = Inst[3];
								end
							else
								local A;
								Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Upvalues[Inst[3]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Inst[3];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Stk[Inst[3]][Stk[Inst[4]]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								for Idx = Inst[2], Inst[3] do
									Stk[Idx] = nil;
								end
								VIP = VIP + 1;
								Inst = Instr[VIP];
								A = Inst[2];
								Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
								VIP = VIP + 1;
								Inst = Instr[VIP];
								if not Stk[Inst[2]] then
									VIP = VIP + 1;
								else
									VIP = Inst[3];
								end
							end
						elseif (Enum <= 202) then
							if (Enum == 201) then
								local Edx;
								local Results, Limit;
								local A;
								Stk[Inst[2]] = Upvalues[Inst[3]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Upvalues[Inst[3]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Upvalues[Inst[3]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								A = Inst[2];
								Results, Limit = _R(Stk[A](Stk[A + 1]));
								Top = (Limit + A) - 1;
								Edx = 0;
								for Idx = A, Top do
									Edx = Edx + 1;
									Stk[Idx] = Results[Edx];
								end
								VIP = VIP + 1;
								Inst = Instr[VIP];
								A = Inst[2];
								Results, Limit = _R(Stk[A](Unpack(Stk, A + 1, Top)));
								Top = (Limit + A) - 1;
								Edx = 0;
								for Idx = A, Top do
									Edx = Edx + 1;
									Stk[Idx] = Results[Edx];
								end
								VIP = VIP + 1;
								Inst = Instr[VIP];
								A = Inst[2];
								Stk[A] = Stk[A](Unpack(Stk, A + 1, Top));
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Upvalues[Inst[3]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Inst[3];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Upvalues[Inst[3]];
							else
								Upvalues[Inst[3]] = Stk[Inst[2]];
							end
						elseif (Enum > 203) then
							local B;
							local A;
							A = Inst[2];
							B = Stk[Inst[3]];
							Stk[A + 1] = B;
							Stk[A] = B[Inst[4]];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Inst[3];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							A = Inst[2];
							Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Upvalues[Inst[3]] = Stk[Inst[2]];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Upvalues[Inst[3]];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							A = Inst[2];
							B = Stk[Inst[3]];
							Stk[A + 1] = B;
							Stk[A] = B[Inst[4]];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Upvalues[Inst[3]];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							A = Inst[2];
							Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Upvalues[Inst[3]] = Stk[Inst[2]];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Inst[3];
						else
							local A;
							Stk[Inst[2]] = Inst[3];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Stk[Inst[3]][Stk[Inst[4]]];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Upvalues[Inst[3]];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Inst[3];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Stk[Inst[3]][Stk[Inst[4]]];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Upvalues[Inst[3]];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Inst[3];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Inst[3] ~= 0;
							VIP = VIP + 1;
							Inst = Instr[VIP];
							A = Inst[2];
							Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
							VIP = VIP + 1;
							Inst = Instr[VIP];
							if Stk[Inst[2]] then
								VIP = VIP + 1;
							else
								VIP = Inst[3];
							end
						end
					elseif (Enum <= 211) then
						if (Enum <= 207) then
							if (Enum <= 205) then
								local Edx;
								local Results, Limit;
								local B;
								local A;
								Stk[Inst[2]] = Upvalues[Inst[3]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Upvalues[Inst[3]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Upvalues[Inst[3]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Upvalues[Inst[3]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								A = Inst[2];
								B = Stk[Inst[3]];
								Stk[A + 1] = B;
								Stk[A] = B[Inst[4]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Upvalues[Inst[3]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								A = Inst[2];
								Results, Limit = _R(Stk[A](Unpack(Stk, A + 1, Inst[3])));
								Top = (Limit + A) - 1;
								Edx = 0;
								for Idx = A, Top do
									Edx = Edx + 1;
									Stk[Idx] = Results[Edx];
								end
								VIP = VIP + 1;
								Inst = Instr[VIP];
								A = Inst[2];
								Results, Limit = _R(Stk[A](Unpack(Stk, A + 1, Top)));
								Top = (Limit + A) - 1;
								Edx = 0;
								for Idx = A, Top do
									Edx = Edx + 1;
									Stk[Idx] = Results[Edx];
								end
								VIP = VIP + 1;
								Inst = Instr[VIP];
								A = Inst[2];
								Stk[A] = Stk[A](Unpack(Stk, A + 1, Top));
							elseif (Enum == 206) then
								local B;
								local A;
								Stk[Inst[2]] = Upvalues[Inst[3]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Inst[3];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Inst[3];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								A = Inst[2];
								Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Stk[Inst[3]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								A = Inst[2];
								Stk[A](Unpack(Stk, A + 1, Inst[3]));
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Env[Inst[3]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Upvalues[Inst[3]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Stk[Inst[3]][Stk[Inst[4]]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								A = Inst[2];
								B = Stk[Inst[3]];
								Stk[A + 1] = B;
								Stk[A] = B[Inst[4]];
							else
								local A;
								Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Upvalues[Inst[3]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								A = Inst[2];
								Stk[A](Stk[A + 1]);
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Upvalues[Inst[3]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Inst[3];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Inst[3];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								A = Inst[2];
								do
									return Stk[A](Unpack(Stk, A + 1, Inst[3]));
								end
								VIP = VIP + 1;
								Inst = Instr[VIP];
								A = Inst[2];
								do
									return Unpack(Stk, A, Top);
								end
							end
						elseif (Enum <= 209) then
							if (Enum == 208) then
								local B;
								local A;
								Stk[Inst[2]] = Upvalues[Inst[3]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Inst[3];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Inst[3];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								A = Inst[2];
								Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Stk[Inst[3]][Stk[Inst[4]]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								A = Inst[2];
								B = Stk[Inst[3]];
								Stk[A + 1] = B;
								Stk[A] = B[Inst[4]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								A = Inst[2];
								Stk[A] = Stk[A](Stk[A + 1]);
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Inst[3];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								if (Stk[Inst[2]] <= Stk[Inst[4]]) then
									VIP = VIP + 1;
								else
									VIP = Inst[3];
								end
							else
								local B;
								local A;
								Stk[Inst[2]] = Upvalues[Inst[3]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Inst[3];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Inst[3];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								A = Inst[2];
								Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Stk[Inst[3]][Stk[Inst[4]]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								A = Inst[2];
								B = Stk[Inst[3]];
								Stk[A + 1] = B;
								Stk[A] = B[Inst[4]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Env[Inst[3]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								A = Inst[2];
								Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
								VIP = VIP + 1;
								Inst = Instr[VIP];
								if (Stk[Inst[2]] <= Inst[4]) then
									VIP = VIP + 1;
								else
									VIP = Inst[3];
								end
							end
						elseif (Enum > 210) then
							if (Inst[2] == Stk[Inst[4]]) then
								VIP = VIP + 1;
							else
								VIP = Inst[3];
							end
						elseif (Inst[2] > Inst[4]) then
							VIP = VIP + 1;
						else
							VIP = Inst[3];
						end
					elseif (Enum <= 214) then
						if (Enum <= 212) then
							local B;
							local A;
							Stk[Inst[2]] = Upvalues[Inst[3]];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Inst[3];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Inst[3];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							A = Inst[2];
							Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Stk[Inst[3]][Stk[Inst[4]]];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Inst[3];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							A = Inst[2];
							B = Stk[Inst[3]];
							Stk[A + 1] = B;
							Stk[A] = B[Stk[Inst[4]]];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							A = Inst[2];
							Stk[A] = Stk[A](Stk[A + 1]);
							VIP = VIP + 1;
							Inst = Instr[VIP];
							if Stk[Inst[2]] then
								VIP = VIP + 1;
							else
								VIP = Inst[3];
							end
						elseif (Enum == 213) then
							local B;
							local A;
							A = Inst[2];
							B = Stk[Inst[3]];
							Stk[A + 1] = B;
							Stk[A] = B[Inst[4]];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Inst[3] ~= 0;
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Inst[3] ~= 0;
							VIP = VIP + 1;
							Inst = Instr[VIP];
							A = Inst[2];
							Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
							VIP = VIP + 1;
							Inst = Instr[VIP];
							if not Stk[Inst[2]] then
								VIP = VIP + 1;
							else
								VIP = Inst[3];
							end
						else
							local B;
							local A;
							A = Inst[2];
							B = Stk[Inst[3]];
							Stk[A + 1] = B;
							Stk[A] = B[Inst[4]];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Upvalues[Inst[3]];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							A = Inst[2];
							Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
							VIP = VIP + 1;
							Inst = Instr[VIP];
							if Stk[Inst[2]] then
								VIP = VIP + 1;
							else
								VIP = Inst[3];
							end
						end
					elseif (Enum <= 216) then
						if (Enum > 215) then
							local A;
							Stk[Inst[2]] = Stk[Inst[3]][Stk[Inst[4]]];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Upvalues[Inst[3]];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Inst[3];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Inst[3];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							A = Inst[2];
							Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Stk[Inst[3]][Stk[Inst[4]]];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Inst[3];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							A = Inst[2];
							Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Stk[Inst[3]] + Stk[Inst[4]];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]][Stk[Inst[3]]] = Stk[Inst[4]];
						else
							local B;
							local A;
							Stk[Inst[2]] = Upvalues[Inst[3]];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Inst[3];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Inst[3];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							A = Inst[2];
							Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Stk[Inst[3]][Stk[Inst[4]]];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							A = Inst[2];
							B = Stk[Inst[3]];
							Stk[A + 1] = B;
							Stk[A] = B[Inst[4]];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							A = Inst[2];
							Stk[A] = Stk[A](Stk[A + 1]);
							VIP = VIP + 1;
							Inst = Instr[VIP];
							if Stk[Inst[2]] then
								VIP = VIP + 1;
							else
								VIP = Inst[3];
							end
						end
					elseif (Enum == 217) then
						local A;
						Stk[Inst[2]] = Inst[3];
						VIP = VIP + 1;
						Inst = Instr[VIP];
						Stk[Inst[2]] = Inst[3];
						VIP = VIP + 1;
						Inst = Instr[VIP];
						A = Inst[2];
						Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
						VIP = VIP + 1;
						Inst = Instr[VIP];
						Stk[Inst[2]] = Stk[Inst[3]][Stk[Inst[4]]];
						VIP = VIP + 1;
						Inst = Instr[VIP];
						Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
						VIP = VIP + 1;
						Inst = Instr[VIP];
						Stk[Inst[2]] = Upvalues[Inst[3]];
						VIP = VIP + 1;
						Inst = Instr[VIP];
						Stk[Inst[2]] = Inst[3];
						VIP = VIP + 1;
						Inst = Instr[VIP];
						Stk[Inst[2]] = Inst[3];
						VIP = VIP + 1;
						Inst = Instr[VIP];
						A = Inst[2];
						Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
						VIP = VIP + 1;
						Inst = Instr[VIP];
						Stk[Inst[2]] = Stk[Inst[3]][Stk[Inst[4]]];
					else
						local B;
						local A;
						A = Inst[2];
						B = Stk[Inst[3]];
						Stk[A + 1] = B;
						Stk[A] = B[Inst[4]];
						VIP = VIP + 1;
						Inst = Instr[VIP];
						Stk[Inst[2]] = Upvalues[Inst[3]];
						VIP = VIP + 1;
						Inst = Instr[VIP];
						Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
						VIP = VIP + 1;
						Inst = Instr[VIP];
						A = Inst[2];
						Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
						VIP = VIP + 1;
						Inst = Instr[VIP];
						if Stk[Inst[2]] then
							VIP = VIP + 1;
						else
							VIP = Inst[3];
						end
					end
				elseif (Enum <= 327) then
					if (Enum <= 272) then
						if (Enum <= 245) then
							if (Enum <= 231) then
								if (Enum <= 224) then
									if (Enum <= 221) then
										if (Enum <= 219) then
											Stk[Inst[2]] = Stk[Inst[3]] * Inst[4];
										elseif (Enum > 220) then
											local A;
											Stk[Inst[2]] = Upvalues[Inst[3]];
											VIP = VIP + 1;
											Inst = Instr[VIP];
											Stk[Inst[2]] = Inst[3];
											VIP = VIP + 1;
											Inst = Instr[VIP];
											Stk[Inst[2]] = Inst[3];
											VIP = VIP + 1;
											Inst = Instr[VIP];
											A = Inst[2];
											Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
											VIP = VIP + 1;
											Inst = Instr[VIP];
											Stk[Inst[2]] = Stk[Inst[3]][Stk[Inst[4]]];
											VIP = VIP + 1;
											Inst = Instr[VIP];
											do
												return Stk[Inst[2]];
											end
										else
											local A = Inst[2];
											local B = Inst[3];
											for Idx = A, B do
												Stk[Idx] = Vararg[Idx - A];
											end
										end
									elseif (Enum <= 222) then
										local A;
										Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Upvalues[Inst[3]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Inst[3];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Stk[Inst[3]][Stk[Inst[4]]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										for Idx = Inst[2], Inst[3] do
											Stk[Idx] = nil;
										end
										VIP = VIP + 1;
										Inst = Instr[VIP];
										A = Inst[2];
										Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
										VIP = VIP + 1;
										Inst = Instr[VIP];
										if Stk[Inst[2]] then
											VIP = VIP + 1;
										else
											VIP = Inst[3];
										end
									elseif (Enum == 223) then
										local A = Inst[2];
										local T = Stk[A];
										for Idx = A + 1, Inst[3] do
											Insert(T, Stk[Idx]);
										end
									else
										local A;
										Stk[Inst[2]] = Upvalues[Inst[3]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Inst[3];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Inst[3];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										A = Inst[2];
										Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Stk[Inst[3]][Stk[Inst[4]]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Upvalues[Inst[3]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Inst[3];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Inst[3];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										A = Inst[2];
										Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Stk[Inst[3]][Stk[Inst[4]]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Upvalues[Inst[3]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Inst[3];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Inst[3];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										A = Inst[2];
										Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Stk[Inst[3]][Stk[Inst[4]]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										if (Inst[2] < Stk[Inst[4]]) then
											VIP = VIP + 1;
										else
											VIP = Inst[3];
										end
									end
								elseif (Enum <= 227) then
									if (Enum <= 225) then
										Stk[Inst[2]] = not Stk[Inst[3]];
									elseif (Enum == 226) then
										local A;
										Stk[Inst[2]] = Upvalues[Inst[3]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Inst[3];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Inst[3];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										A = Inst[2];
										Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]][Stk[Inst[3]]] = Inst[4];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Upvalues[Inst[3]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Inst[3];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Inst[3];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										A = Inst[2];
										do
											return Stk[A](Unpack(Stk, A + 1, Inst[3]));
										end
										VIP = VIP + 1;
										Inst = Instr[VIP];
										A = Inst[2];
										do
											return Unpack(Stk, A, Top);
										end
										VIP = VIP + 1;
										Inst = Instr[VIP];
										VIP = Inst[3];
									else
										local A;
										Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Upvalues[Inst[3]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Inst[3];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Stk[Inst[3]][Stk[Inst[4]]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										for Idx = Inst[2], Inst[3] do
											Stk[Idx] = nil;
										end
										VIP = VIP + 1;
										Inst = Instr[VIP];
										A = Inst[2];
										Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
										VIP = VIP + 1;
										Inst = Instr[VIP];
										if Stk[Inst[2]] then
											VIP = VIP + 1;
										else
											VIP = Inst[3];
										end
									end
								elseif (Enum <= 229) then
									if (Enum > 228) then
										local A;
										Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Upvalues[Inst[3]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Inst[3];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Stk[Inst[3]][Stk[Inst[4]]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										for Idx = Inst[2], Inst[3] do
											Stk[Idx] = nil;
										end
										VIP = VIP + 1;
										Inst = Instr[VIP];
										A = Inst[2];
										Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
										VIP = VIP + 1;
										Inst = Instr[VIP];
										if not Stk[Inst[2]] then
											VIP = VIP + 1;
										else
											VIP = Inst[3];
										end
									else
										local B;
										local A;
										Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Upvalues[Inst[3]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Inst[3];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Stk[Inst[3]][Stk[Inst[4]]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										for Idx = Inst[2], Inst[3] do
											Stk[Idx] = nil;
										end
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Upvalues[Inst[3]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										A = Inst[2];
										B = Stk[Inst[3]];
										Stk[A + 1] = B;
										Stk[A] = B[Inst[4]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Upvalues[Inst[3]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Inst[3];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Stk[Inst[3]][Stk[Inst[4]]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										A = Inst[2];
										Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = not Stk[Inst[3]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										A = Inst[2];
										Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
										VIP = VIP + 1;
										Inst = Instr[VIP];
										if Stk[Inst[2]] then
											VIP = VIP + 1;
										else
											VIP = Inst[3];
										end
									end
								elseif (Enum > 230) then
									local B;
									local A;
									Stk[Inst[2]] = Upvalues[Inst[3]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									A = Inst[2];
									Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Stk[Inst[3]][Stk[Inst[4]]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									A = Inst[2];
									B = Stk[Inst[3]];
									Stk[A + 1] = B;
									Stk[A] = B[Inst[4]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									A = Inst[2];
									Stk[A] = Stk[A](Stk[A + 1]);
									VIP = VIP + 1;
									Inst = Instr[VIP];
									if Stk[Inst[2]] then
										VIP = VIP + 1;
									else
										VIP = Inst[3];
									end
								else
									local A;
									Stk[Inst[2]] = Upvalues[Inst[3]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									A = Inst[2];
									Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Stk[Inst[3]][Stk[Inst[4]]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Upvalues[Inst[3]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									A = Inst[2];
									Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Stk[Inst[3]][Stk[Inst[4]]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Upvalues[Inst[3]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									A = Inst[2];
									Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Stk[Inst[3]][Stk[Inst[4]]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									if (Inst[2] < Stk[Inst[4]]) then
										VIP = VIP + 1;
									else
										VIP = Inst[3];
									end
								end
							elseif (Enum <= 238) then
								if (Enum <= 234) then
									if (Enum <= 232) then
										local A;
										Stk[Inst[2]] = Upvalues[Inst[3]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Inst[3];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Inst[3];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										A = Inst[2];
										Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Stk[Inst[3]][Stk[Inst[4]]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Upvalues[Inst[3]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Inst[3];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Inst[3];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										A = Inst[2];
										Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Stk[Inst[3]][Stk[Inst[4]]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										if not Stk[Inst[2]] then
											VIP = VIP + 1;
										else
											VIP = Inst[3];
										end
									elseif (Enum > 233) then
										local Edx;
										local Results, Limit;
										local B;
										local A;
										Stk[Inst[2]] = Upvalues[Inst[3]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Inst[3];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Upvalues[Inst[3]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Upvalues[Inst[3]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										A = Inst[2];
										B = Stk[Inst[3]];
										Stk[A + 1] = B;
										Stk[A] = B[Inst[4]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Upvalues[Inst[3]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										A = Inst[2];
										Results, Limit = _R(Stk[A](Unpack(Stk, A + 1, Inst[3])));
										Top = (Limit + A) - 1;
										Edx = 0;
										for Idx = A, Top do
											Edx = Edx + 1;
											Stk[Idx] = Results[Edx];
										end
										VIP = VIP + 1;
										Inst = Instr[VIP];
										A = Inst[2];
										Results, Limit = _R(Stk[A](Unpack(Stk, A + 1, Top)));
										Top = (Limit + A) - 1;
										Edx = 0;
										for Idx = A, Top do
											Edx = Edx + 1;
											Stk[Idx] = Results[Edx];
										end
										VIP = VIP + 1;
										Inst = Instr[VIP];
										A = Inst[2];
										Stk[A] = Stk[A](Unpack(Stk, A + 1, Top));
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Upvalues[Inst[3]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Inst[3];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Upvalues[Inst[3]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Upvalues[Inst[3]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										A = Inst[2];
										B = Stk[Inst[3]];
										Stk[A + 1] = B;
										Stk[A] = B[Inst[4]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Upvalues[Inst[3]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										A = Inst[2];
										Results, Limit = _R(Stk[A](Unpack(Stk, A + 1, Inst[3])));
										Top = (Limit + A) - 1;
										Edx = 0;
										for Idx = A, Top do
											Edx = Edx + 1;
											Stk[Idx] = Results[Edx];
										end
										VIP = VIP + 1;
										Inst = Instr[VIP];
										A = Inst[2];
										Results, Limit = _R(Stk[A](Unpack(Stk, A + 1, Top)));
										Top = (Limit + A) - 1;
										Edx = 0;
										for Idx = A, Top do
											Edx = Edx + 1;
											Stk[Idx] = Results[Edx];
										end
										VIP = VIP + 1;
										Inst = Instr[VIP];
										A = Inst[2];
										Stk[A] = Stk[A](Unpack(Stk, A + 1, Top));
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Stk[Inst[3]] + Stk[Inst[4]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										if (Stk[Inst[2]] > Stk[Inst[4]]) then
											VIP = VIP + 1;
										else
											VIP = VIP + Inst[3];
										end
									else
										local Edx;
										local Results;
										local A;
										Stk[Inst[2]] = Upvalues[Inst[3]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Inst[3];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Inst[3];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										A = Inst[2];
										Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Stk[Inst[3]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										A = Inst[2];
										Results = {Stk[A](Unpack(Stk, A + 1, Inst[3]))};
										Edx = 0;
										for Idx = A, Inst[4] do
											Edx = Edx + 1;
											Stk[Idx] = Results[Edx];
										end
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Stk[Inst[3]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Stk[Inst[3]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Stk[Inst[3]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Stk[Inst[3]];
									end
								elseif (Enum <= 236) then
									if (Enum > 235) then
										local Edx;
										local Results, Limit;
										local B;
										local A;
										Stk[Inst[2]] = Upvalues[Inst[3]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Upvalues[Inst[3]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Upvalues[Inst[3]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Inst[3];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Inst[3];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										A = Inst[2];
										Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Stk[Inst[3]][Stk[Inst[4]]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										A = Inst[2];
										B = Stk[Inst[3]];
										Stk[A + 1] = B;
										Stk[A] = B[Inst[4]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										A = Inst[2];
										Results, Limit = _R(Stk[A](Stk[A + 1]));
										Top = (Limit + A) - 1;
										Edx = 0;
										for Idx = A, Top do
											Edx = Edx + 1;
											Stk[Idx] = Results[Edx];
										end
										VIP = VIP + 1;
										Inst = Instr[VIP];
										A = Inst[2];
										Stk[A] = Stk[A](Unpack(Stk, A + 1, Top));
									else
										local A;
										Stk[Inst[2]] = Upvalues[Inst[3]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Inst[3];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Inst[3];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										A = Inst[2];
										Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]][Stk[Inst[3]]] = Inst[4];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Upvalues[Inst[3]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Inst[3];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Inst[3];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										A = Inst[2];
										do
											return Stk[A](Unpack(Stk, A + 1, Inst[3]));
										end
										VIP = VIP + 1;
										Inst = Instr[VIP];
										A = Inst[2];
										do
											return Unpack(Stk, A, Top);
										end
									end
								elseif (Enum == 237) then
									if (Stk[Inst[2]] == Stk[Inst[4]]) then
										VIP = VIP + 1;
									else
										VIP = Inst[3];
									end
								else
									local A;
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									A = Inst[2];
									Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									A = Inst[2];
									Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Env[Inst[3]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Upvalues[Inst[3]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									A = Inst[2];
									Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
								end
							elseif (Enum <= 241) then
								if (Enum <= 239) then
									local B;
									local A;
									Stk[Inst[2]] = Upvalues[Inst[3]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									A = Inst[2];
									Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Stk[Inst[3]][Stk[Inst[4]]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									A = Inst[2];
									B = Stk[Inst[3]];
									Stk[A + 1] = B;
									Stk[A] = B[Stk[Inst[4]]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									A = Inst[2];
									Stk[A] = Stk[A](Stk[A + 1]);
									VIP = VIP + 1;
									Inst = Instr[VIP];
									if Stk[Inst[2]] then
										VIP = VIP + 1;
									else
										VIP = Inst[3];
									end
								elseif (Enum == 240) then
									local B;
									local A;
									A = Inst[2];
									B = Stk[Inst[3]];
									Stk[A + 1] = B;
									Stk[A] = B[Inst[4]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Upvalues[Inst[3]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									A = Inst[2];
									Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
									VIP = VIP + 1;
									Inst = Instr[VIP];
									if (Stk[Inst[2]] < Inst[4]) then
										VIP = Inst[3];
									else
										VIP = VIP + 1;
									end
								else
									local B;
									local A;
									A = Inst[2];
									B = Stk[Inst[3]];
									Stk[A + 1] = B;
									Stk[A] = B[Inst[4]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									A = Inst[2];
									Stk[A] = Stk[A](Stk[A + 1]);
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Stk[Inst[3]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Upvalues[Inst[3]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									if (Stk[Inst[2]] < Stk[Inst[4]]) then
										VIP = Inst[3];
									else
										VIP = VIP + 1;
									end
								end
							elseif (Enum <= 243) then
								if (Enum == 242) then
									local A;
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									A = Inst[2];
									Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Upvalues[Inst[3]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Upvalues[Inst[3]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Upvalues[Inst[3]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									A = Inst[2];
									Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Stk[Inst[3]][Stk[Inst[4]]];
								else
									local A;
									Stk[Inst[2]] = Upvalues[Inst[3]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									A = Inst[2];
									Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Stk[Inst[3]][Stk[Inst[4]]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Upvalues[Inst[3]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									A = Inst[2];
									Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Stk[Inst[3]][Stk[Inst[4]]];
								end
							elseif (Enum == 244) then
								local Edx;
								local Results, Limit;
								local B;
								local A;
								A = Inst[2];
								B = Stk[Inst[3]];
								Stk[A + 1] = B;
								Stk[A] = B[Inst[4]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Upvalues[Inst[3]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Inst[3];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								A = Inst[2];
								Results, Limit = _R(Stk[A](Stk[A + 1]));
								Top = (Limit + A) - 1;
								Edx = 0;
								for Idx = A, Top do
									Edx = Edx + 1;
									Stk[Idx] = Results[Edx];
								end
								VIP = VIP + 1;
								Inst = Instr[VIP];
								A = Inst[2];
								Stk[A] = Stk[A](Unpack(Stk, A + 1, Top));
								VIP = VIP + 1;
								Inst = Instr[VIP];
								if Stk[Inst[2]] then
									VIP = VIP + 1;
								else
									VIP = Inst[3];
								end
							else
								local A;
								Stk[Inst[2]] = Upvalues[Inst[3]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Inst[3];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Inst[3];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								A = Inst[2];
								Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]][Stk[Inst[3]]] = Inst[4];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Upvalues[Inst[3]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Inst[3];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Inst[3];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								A = Inst[2];
								do
									return Stk[A](Unpack(Stk, A + 1, Inst[3]));
								end
								VIP = VIP + 1;
								Inst = Instr[VIP];
								A = Inst[2];
								do
									return Unpack(Stk, A, Top);
								end
								VIP = VIP + 1;
								Inst = Instr[VIP];
								VIP = Inst[3];
							end
						elseif (Enum <= 258) then
							if (Enum <= 251) then
								if (Enum <= 248) then
									if (Enum <= 246) then
										local A;
										Stk[Inst[2]] = Upvalues[Inst[3]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Inst[3];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Inst[3];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										A = Inst[2];
										Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Stk[Inst[3]][Stk[Inst[4]]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Env[Inst[3]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Upvalues[Inst[3]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Inst[3];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Inst[3];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										A = Inst[2];
										Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Stk[Inst[3]][Stk[Inst[4]]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = not Stk[Inst[3]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]][Inst[3]] = Stk[Inst[4]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Upvalues[Inst[3]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Upvalues[Inst[3]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Inst[3];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Inst[3];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										A = Inst[2];
										Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Env[Inst[3]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Upvalues[Inst[3]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Inst[3];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Inst[3];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										A = Inst[2];
										Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Stk[Inst[3]][Stk[Inst[4]]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										if Stk[Inst[2]] then
											VIP = VIP + 1;
										else
											VIP = Inst[3];
										end
									elseif (Enum > 247) then
										local A;
										Stk[Inst[2]] = Upvalues[Inst[3]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Inst[3];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Inst[3];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										A = Inst[2];
										Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Inst[3];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]][Stk[Inst[3]]] = Stk[Inst[4]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Upvalues[Inst[3]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Inst[3];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Inst[3];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										A = Inst[2];
										do
											return Stk[A](Unpack(Stk, A + 1, Inst[3]));
										end
										VIP = VIP + 1;
										Inst = Instr[VIP];
										A = Inst[2];
										do
											return Unpack(Stk, A, Top);
										end
										VIP = VIP + 1;
										Inst = Instr[VIP];
										VIP = Inst[3];
									else
										local A = Inst[2];
										Stk[A](Unpack(Stk, A + 1, Top));
									end
								elseif (Enum <= 249) then
									local B;
									local A;
									Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Upvalues[Inst[3]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									for Idx = Inst[2], Inst[3] do
										Stk[Idx] = nil;
									end
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Upvalues[Inst[3]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									A = Inst[2];
									B = Stk[Inst[3]];
									Stk[A + 1] = B;
									Stk[A] = B[Inst[4]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Upvalues[Inst[3]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									A = Inst[2];
									Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = not Stk[Inst[3]];
								elseif (Enum > 250) then
									local B;
									local A;
									Stk[Inst[2]] = Upvalues[Inst[3]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									A = Inst[2];
									Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Stk[Inst[3]][Stk[Inst[4]]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									A = Inst[2];
									B = Stk[Inst[3]];
									Stk[A + 1] = B;
									Stk[A] = B[Inst[4]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									A = Inst[2];
									Stk[A] = Stk[A](Stk[A + 1]);
									VIP = VIP + 1;
									Inst = Instr[VIP];
									if Stk[Inst[2]] then
										VIP = VIP + 1;
									else
										VIP = Inst[3];
									end
								else
									local A;
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									A = Inst[2];
									Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Upvalues[Inst[3]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Upvalues[Inst[3]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Upvalues[Inst[3]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									A = Inst[2];
									Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Stk[Inst[3]][Stk[Inst[4]]];
								end
							elseif (Enum <= 254) then
								if (Enum <= 252) then
									local B;
									local A;
									Stk[Inst[2]] = Upvalues[Inst[3]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									A = Inst[2];
									Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Stk[Inst[3]][Stk[Inst[4]]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									A = Inst[2];
									B = Stk[Inst[3]];
									Stk[A + 1] = B;
									Stk[A] = B[Inst[4]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									A = Inst[2];
									Stk[A] = Stk[A](Stk[A + 1]);
									VIP = VIP + 1;
									Inst = Instr[VIP];
									if Stk[Inst[2]] then
										VIP = VIP + 1;
									else
										VIP = Inst[3];
									end
								elseif (Enum == 253) then
									local A;
									Stk[Inst[2]] = Upvalues[Inst[3]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									A = Inst[2];
									Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]][Stk[Inst[3]]] = Inst[4];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Upvalues[Inst[3]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									A = Inst[2];
									do
										return Stk[A](Unpack(Stk, A + 1, Inst[3]));
									end
									VIP = VIP + 1;
									Inst = Instr[VIP];
									A = Inst[2];
									do
										return Unpack(Stk, A, Top);
									end
									VIP = VIP + 1;
									Inst = Instr[VIP];
									VIP = Inst[3];
								else
									local B;
									local A;
									Stk[Inst[2]] = Upvalues[Inst[3]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									A = Inst[2];
									Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Stk[Inst[3]][Stk[Inst[4]]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									A = Inst[2];
									B = Stk[Inst[3]];
									Stk[A + 1] = B;
									Stk[A] = B[Stk[Inst[4]]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									A = Inst[2];
									Stk[A] = Stk[A](Stk[A + 1]);
									VIP = VIP + 1;
									Inst = Instr[VIP];
									if Stk[Inst[2]] then
										VIP = VIP + 1;
									else
										VIP = Inst[3];
									end
								end
							elseif (Enum <= 256) then
								if (Enum > 255) then
									local B;
									local Edx;
									local Results, Limit;
									local A;
									Stk[Inst[2]] = Upvalues[Inst[3]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									A = Inst[2];
									Results, Limit = _R(Stk[A](Unpack(Stk, A + 1, Inst[3])));
									Top = (Limit + A) - 1;
									Edx = 0;
									for Idx = A, Top do
										Edx = Edx + 1;
										Stk[Idx] = Results[Edx];
									end
									VIP = VIP + 1;
									Inst = Instr[VIP];
									A = Inst[2];
									Stk[A] = Stk[A](Unpack(Stk, A + 1, Top));
									VIP = VIP + 1;
									Inst = Instr[VIP];
									A = Inst[2];
									B = Stk[Inst[3]];
									Stk[A + 1] = B;
									Stk[A] = B[Inst[4]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									A = Inst[2];
									Stk[A] = Stk[A](Stk[A + 1]);
									VIP = VIP + 1;
									Inst = Instr[VIP];
									for Idx = Inst[2], Inst[3] do
										Stk[Idx] = nil;
									end
									VIP = VIP + 1;
									Inst = Instr[VIP];
									if (Stk[Inst[2]] ~= Stk[Inst[4]]) then
										VIP = VIP + 1;
									else
										VIP = Inst[3];
									end
								else
									local A;
									Stk[Inst[2]] = Upvalues[Inst[3]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Upvalues[Inst[3]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Upvalues[Inst[3]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									A = Inst[2];
									Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Stk[Inst[3]][Stk[Inst[4]]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Upvalues[Inst[3]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
								end
							elseif (Enum == 257) then
								Stk[Inst[2]] = Stk[Inst[3]] * Stk[Inst[4]];
							else
								local A;
								Stk[Inst[2]] = Inst[3];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Inst[3];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								A = Inst[2];
								Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Upvalues[Inst[3]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Inst[3];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Inst[3];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								A = Inst[2];
								Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Stk[Inst[3]][Stk[Inst[4]]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Upvalues[Inst[3]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Inst[3];
							end
						elseif (Enum <= 265) then
							if (Enum <= 261) then
								if (Enum <= 259) then
									local B;
									local A;
									A = Inst[2];
									B = Stk[Inst[3]];
									Stk[A + 1] = B;
									Stk[A] = B[Inst[4]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Upvalues[Inst[3]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									A = Inst[2];
									Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Upvalues[Inst[3]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									A = Inst[2];
									B = Stk[Inst[3]];
									Stk[A + 1] = B;
									Stk[A] = B[Inst[4]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									A = Inst[2];
									Stk[A] = Stk[A](Stk[A + 1]);
									VIP = VIP + 1;
									Inst = Instr[VIP];
									if (Stk[Inst[2]] <= Stk[Inst[4]]) then
										VIP = VIP + 1;
									else
										VIP = Inst[3];
									end
								elseif (Enum == 260) then
									if (Inst[2] == Inst[4]) then
										VIP = VIP + 1;
									else
										VIP = Inst[3];
									end
								else
									local A;
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									A = Inst[2];
									Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Stk[Inst[3]][Stk[Inst[4]]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									A = Inst[2];
									Stk[A](Unpack(Stk, A + 1, Inst[3]));
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Env[Inst[3]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Upvalues[Inst[3]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
								end
							elseif (Enum <= 263) then
								if (Enum == 262) then
									local A;
									Stk[Inst[2]] = Upvalues[Inst[3]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									A = Inst[2];
									Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]][Stk[Inst[3]]] = Stk[Inst[4]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Upvalues[Inst[3]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									A = Inst[2];
									do
										return Stk[A](Unpack(Stk, A + 1, Inst[3]));
									end
									VIP = VIP + 1;
									Inst = Instr[VIP];
									A = Inst[2];
									do
										return Unpack(Stk, A, Top);
									end
									VIP = VIP + 1;
									Inst = Instr[VIP];
									VIP = Inst[3];
								else
									local Edx;
									local Results, Limit;
									local A;
									Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Upvalues[Inst[3]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									A = Inst[2];
									Results, Limit = _R(Stk[A](Stk[A + 1]));
									Top = (Limit + A) - 1;
									Edx = 0;
									for Idx = A, Top do
										Edx = Edx + 1;
										Stk[Idx] = Results[Edx];
									end
									VIP = VIP + 1;
									Inst = Instr[VIP];
									A = Inst[2];
									Stk[A] = Stk[A](Unpack(Stk, A + 1, Top));
									VIP = VIP + 1;
									Inst = Instr[VIP];
									if Stk[Inst[2]] then
										VIP = VIP + 1;
									else
										VIP = Inst[3];
									end
								end
							elseif (Enum == 264) then
								local B;
								local A;
								Stk[Inst[2]] = Upvalues[Inst[3]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Inst[3];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Inst[3];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								A = Inst[2];
								Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Stk[Inst[3]][Stk[Inst[4]]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								A = Inst[2];
								B = Stk[Inst[3]];
								Stk[A + 1] = B;
								Stk[A] = B[Inst[4]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								A = Inst[2];
								Stk[A] = Stk[A](Stk[A + 1]);
								VIP = VIP + 1;
								Inst = Instr[VIP];
								if Stk[Inst[2]] then
									VIP = VIP + 1;
								else
									VIP = Inst[3];
								end
							else
								local A;
								Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Upvalues[Inst[3]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Inst[3];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Stk[Inst[3]][Stk[Inst[4]]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								for Idx = Inst[2], Inst[3] do
									Stk[Idx] = nil;
								end
								VIP = VIP + 1;
								Inst = Instr[VIP];
								A = Inst[2];
								Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
								VIP = VIP + 1;
								Inst = Instr[VIP];
								if Stk[Inst[2]] then
									VIP = VIP + 1;
								else
									VIP = Inst[3];
								end
							end
						elseif (Enum <= 268) then
							if (Enum <= 266) then
								local A = Inst[2];
								local Results = {Stk[A](Unpack(Stk, A + 1, Inst[3]))};
								local Edx = 0;
								for Idx = A, Inst[4] do
									Edx = Edx + 1;
									Stk[Idx] = Results[Edx];
								end
							elseif (Enum > 267) then
								local B;
								local A;
								A = Inst[2];
								B = Stk[Inst[3]];
								Stk[A + 1] = B;
								Stk[A] = B[Inst[4]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Upvalues[Inst[3]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Inst[3];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Stk[Inst[3]][Stk[Inst[4]]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								A = Inst[2];
								Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
								VIP = VIP + 1;
								Inst = Instr[VIP];
								if not Stk[Inst[2]] then
									VIP = VIP + 1;
								else
									VIP = Inst[3];
								end
							else
								local B;
								local A;
								Stk[Inst[2]] = Upvalues[Inst[3]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								A = Inst[2];
								B = Stk[Inst[3]];
								Stk[A + 1] = B;
								Stk[A] = B[Inst[4]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								for Idx = Inst[2], Inst[3] do
									Stk[Idx] = nil;
								end
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Upvalues[Inst[3]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								A = Inst[2];
								Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Upvalues[Inst[3]] = Stk[Inst[2]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Upvalues[Inst[3]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								A = Inst[2];
								Stk[A] = Stk[A]();
								VIP = VIP + 1;
								Inst = Instr[VIP];
								if Stk[Inst[2]] then
									VIP = VIP + 1;
								else
									VIP = Inst[3];
								end
							end
						elseif (Enum <= 270) then
							if (Enum == 269) then
								local B;
								local A;
								A = Inst[2];
								B = Stk[Inst[3]];
								Stk[A + 1] = B;
								Stk[A] = B[Inst[4]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Upvalues[Inst[3]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								A = Inst[2];
								Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
								VIP = VIP + 1;
								Inst = Instr[VIP];
								if Stk[Inst[2]] then
									VIP = VIP + 1;
								else
									VIP = Inst[3];
								end
							else
								local B;
								local A;
								Stk[Inst[2]] = Upvalues[Inst[3]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Inst[3];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Inst[3];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								A = Inst[2];
								Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Stk[Inst[3]][Stk[Inst[4]]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								A = Inst[2];
								B = Stk[Inst[3]];
								Stk[A + 1] = B;
								Stk[A] = B[Inst[4]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								A = Inst[2];
								Stk[A] = Stk[A](Stk[A + 1]);
								VIP = VIP + 1;
								Inst = Instr[VIP];
								if Stk[Inst[2]] then
									VIP = VIP + 1;
								else
									VIP = Inst[3];
								end
							end
						elseif (Enum > 271) then
							local Edx;
							local Results, Limit;
							local B;
							local A;
							Stk[Inst[2]] = Inst[3];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							A = Inst[2];
							B = Stk[Inst[3]];
							Stk[A + 1] = B;
							Stk[A] = B[Stk[Inst[4]]];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Upvalues[Inst[3]];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Inst[3];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							A = Inst[2];
							Results, Limit = _R(Stk[A](Stk[A + 1]));
							Top = (Limit + A) - 1;
							Edx = 0;
							for Idx = A, Top do
								Edx = Edx + 1;
								Stk[Idx] = Results[Edx];
							end
							VIP = VIP + 1;
							Inst = Instr[VIP];
							A = Inst[2];
							Stk[A] = Stk[A](Unpack(Stk, A + 1, Top));
							VIP = VIP + 1;
							Inst = Instr[VIP];
							if Stk[Inst[2]] then
								VIP = VIP + 1;
							else
								VIP = Inst[3];
							end
						else
							Stk[Inst[2]] = Inst[3] - Stk[Inst[4]];
						end
					elseif (Enum <= 299) then
						if (Enum <= 285) then
							if (Enum <= 278) then
								if (Enum <= 275) then
									if (Enum <= 273) then
										local B;
										local T;
										local A;
										Stk[Inst[2]] = Inst[3];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Inst[3];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Inst[3];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Inst[3];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Inst[3];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Inst[3];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Inst[3];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Inst[3];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Inst[3];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Inst[3];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Inst[3];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Inst[3];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Inst[3];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Inst[3];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Inst[3];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Inst[3];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Inst[3];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Inst[3];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Inst[3];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Inst[3];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Inst[3];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Inst[3];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Inst[3];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Inst[3];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										A = Inst[2];
										T = Stk[A];
										B = Inst[3];
										for Idx = 1, B do
											T[Idx] = Stk[A + Idx];
										end
									elseif (Enum > 274) then
										Stk[Inst[2]] = Stk[Inst[3]];
									else
										local A;
										Stk[Inst[2]] = Inst[3];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										A = Inst[2];
										Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Stk[Inst[3]] + Stk[Inst[4]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Stk[Inst[3]] * Stk[Inst[4]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										A = Inst[2];
										Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Upvalues[Inst[3]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Inst[3];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Upvalues[Inst[3]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Upvalues[Inst[3]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Upvalues[Inst[3]];
									end
								elseif (Enum <= 276) then
									local A;
									Stk[Inst[2]] = Upvalues[Inst[3]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									A = Inst[2];
									Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Upvalues[Inst[3]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Upvalues[Inst[3]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									A = Inst[2];
									Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Stk[Inst[3]][Stk[Inst[4]]];
								elseif (Enum > 277) then
									local B;
									local A;
									Stk[Inst[2]] = Upvalues[Inst[3]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									A = Inst[2];
									Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Stk[Inst[3]][Stk[Inst[4]]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Upvalues[Inst[3]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									A = Inst[2];
									Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Upvalues[Inst[3]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									A = Inst[2];
									B = Stk[Inst[3]];
									Stk[A + 1] = B;
									Stk[A] = B[Inst[4]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Upvalues[Inst[3]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									A = Inst[2];
									Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
									VIP = VIP + 1;
									Inst = Instr[VIP];
									if not Stk[Inst[2]] then
										VIP = VIP + 1;
									else
										VIP = Inst[3];
									end
								else
									local A;
									Stk[Inst[2]] = Upvalues[Inst[3]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Upvalues[Inst[3]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									A = Inst[2];
									Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Stk[Inst[3]][Stk[Inst[4]]];
								end
							elseif (Enum <= 281) then
								if (Enum <= 279) then
									Stk[Inst[2]][Inst[3]] = Stk[Inst[4]];
								elseif (Enum == 280) then
									local A;
									Stk[Inst[2]] = Upvalues[Inst[3]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									A = Inst[2];
									Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Stk[Inst[3]][Stk[Inst[4]]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Upvalues[Inst[3]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									A = Inst[2];
									Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Stk[Inst[3]][Stk[Inst[4]]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Upvalues[Inst[3]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									A = Inst[2];
									Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
									VIP = VIP + 1;
									Inst = Instr[VIP];
									if (Stk[Inst[2]] == Stk[Inst[4]]) then
										VIP = VIP + 1;
									else
										VIP = Inst[3];
									end
								else
									local B;
									local A;
									Stk[Inst[2]] = Upvalues[Inst[3]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									A = Inst[2];
									Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Stk[Inst[3]][Stk[Inst[4]]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									A = Inst[2];
									B = Stk[Inst[3]];
									Stk[A + 1] = B;
									Stk[A] = B[Inst[4]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									A = Inst[2];
									Stk[A] = Stk[A](Stk[A + 1]);
									VIP = VIP + 1;
									Inst = Instr[VIP];
									if Stk[Inst[2]] then
										VIP = VIP + 1;
									else
										VIP = Inst[3];
									end
								end
							elseif (Enum <= 283) then
								if (Enum > 282) then
									local Edx;
									local Results, Limit;
									local B;
									local A;
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									A = Inst[2];
									B = Stk[Inst[3]];
									Stk[A + 1] = B;
									Stk[A] = B[Stk[Inst[4]]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Upvalues[Inst[3]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									A = Inst[2];
									Results, Limit = _R(Stk[A](Stk[A + 1]));
									Top = (Limit + A) - 1;
									Edx = 0;
									for Idx = A, Top do
										Edx = Edx + 1;
										Stk[Idx] = Results[Edx];
									end
									VIP = VIP + 1;
									Inst = Instr[VIP];
									A = Inst[2];
									Stk[A] = Stk[A](Unpack(Stk, A + 1, Top));
									VIP = VIP + 1;
									Inst = Instr[VIP];
									if not Stk[Inst[2]] then
										VIP = VIP + 1;
									else
										VIP = Inst[3];
									end
								else
									local A;
									Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Upvalues[Inst[3]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									for Idx = Inst[2], Inst[3] do
										Stk[Idx] = nil;
									end
									VIP = VIP + 1;
									Inst = Instr[VIP];
									A = Inst[2];
									Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
									VIP = VIP + 1;
									Inst = Instr[VIP];
									if Stk[Inst[2]] then
										VIP = VIP + 1;
									else
										VIP = Inst[3];
									end
								end
							elseif (Enum == 284) then
								local B = Inst[3];
								local K = Stk[B];
								for Idx = B + 1, Inst[4] do
									K = K .. Stk[Idx];
								end
								Stk[Inst[2]] = K;
							else
								local Step;
								local Index;
								local A;
								Upvalues[Inst[3]] = Stk[Inst[2]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Inst[3];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Inst[3];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Inst[3];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								A = Inst[2];
								Index = Stk[A];
								Step = Stk[A + 2];
								if (Step > 0) then
									if (Index > Stk[A + 1]) then
										VIP = Inst[3];
									else
										Stk[A + 3] = Index;
									end
								elseif (Index < Stk[A + 1]) then
									VIP = Inst[3];
								else
									Stk[A + 3] = Index;
								end
							end
						elseif (Enum <= 292) then
							if (Enum <= 288) then
								if (Enum <= 286) then
									local Edx;
									local Results, Limit;
									local A;
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Env[Inst[3]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Upvalues[Inst[3]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									A = Inst[2];
									Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Stk[Inst[3]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									A = Inst[2];
									Results, Limit = _R(Stk[A](Unpack(Stk, A + 1, Inst[3])));
									Top = (Limit + A) - 1;
									Edx = 0;
									for Idx = A, Top do
										Edx = Edx + 1;
										Stk[Idx] = Results[Edx];
									end
									VIP = VIP + 1;
									Inst = Instr[VIP];
									A = Inst[2];
									Stk[A] = Stk[A](Unpack(Stk, A + 1, Top));
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Env[Inst[3]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									A = Inst[2];
									Stk[A] = Stk[A]();
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Stk[Inst[3]] - Stk[Inst[4]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Upvalues[Inst[3]] = Stk[Inst[2]];
								elseif (Enum == 287) then
									local A;
									Stk[Inst[2]] = Upvalues[Inst[3]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									A = Inst[2];
									Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Stk[Inst[3]][Stk[Inst[4]]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									if (Stk[Inst[2]] == Inst[4]) then
										VIP = VIP + 1;
									else
										VIP = Inst[3];
									end
								else
									local A;
									Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Upvalues[Inst[3]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									for Idx = Inst[2], Inst[3] do
										Stk[Idx] = nil;
									end
									VIP = VIP + 1;
									Inst = Instr[VIP];
									A = Inst[2];
									Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
									VIP = VIP + 1;
									Inst = Instr[VIP];
									if not Stk[Inst[2]] then
										VIP = VIP + 1;
									else
										VIP = Inst[3];
									end
								end
							elseif (Enum <= 290) then
								if (Enum > 289) then
									local B;
									local A;
									Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Upvalues[Inst[3]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									for Idx = Inst[2], Inst[3] do
										Stk[Idx] = nil;
									end
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Upvalues[Inst[3]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									A = Inst[2];
									B = Stk[Inst[3]];
									Stk[A + 1] = B;
									Stk[A] = B[Inst[4]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Upvalues[Inst[3]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									A = Inst[2];
									Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = not Stk[Inst[3]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									A = Inst[2];
									Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
									VIP = VIP + 1;
									Inst = Instr[VIP];
									if Stk[Inst[2]] then
										VIP = VIP + 1;
									else
										VIP = Inst[3];
									end
								else
									local A;
									Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Upvalues[Inst[3]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Stk[Inst[3]][Stk[Inst[4]]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									A = Inst[2];
									Stk[A] = Stk[A](Stk[A + 1]);
									VIP = VIP + 1;
									Inst = Instr[VIP];
									if Stk[Inst[2]] then
										VIP = VIP + 1;
									else
										VIP = Inst[3];
									end
								end
							elseif (Enum > 291) then
								local A;
								Stk[Inst[2]] = {};
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Upvalues[Inst[3]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Upvalues[Inst[3]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Inst[3];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Inst[3];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								A = Inst[2];
								Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Stk[Inst[3]][Stk[Inst[4]]];
							elseif (Stk[Inst[2]] ~= Stk[Inst[4]]) then
								VIP = VIP + 1;
							else
								VIP = Inst[3];
							end
						elseif (Enum <= 295) then
							if (Enum <= 293) then
								local B;
								local A;
								Stk[Inst[2]] = Upvalues[Inst[3]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Inst[3];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Inst[3];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								A = Inst[2];
								Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Stk[Inst[3]][Stk[Inst[4]]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								A = Inst[2];
								B = Stk[Inst[3]];
								Stk[A + 1] = B;
								Stk[A] = B[Inst[4]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								A = Inst[2];
								Stk[A] = Stk[A](Stk[A + 1]);
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Upvalues[Inst[3]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								if (Stk[Inst[2]] == Stk[Inst[4]]) then
									VIP = VIP + 1;
								else
									VIP = Inst[3];
								end
							elseif (Enum > 294) then
								local B;
								local A;
								Stk[Inst[2]] = Inst[3];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								A = Inst[2];
								B = Stk[Inst[3]];
								Stk[A + 1] = B;
								Stk[A] = B[Stk[Inst[4]]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Upvalues[Inst[3]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Inst[3];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Stk[Inst[3]][Stk[Inst[4]]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								A = Inst[2];
								Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
								VIP = VIP + 1;
								Inst = Instr[VIP];
								if Stk[Inst[2]] then
									VIP = VIP + 1;
								else
									VIP = Inst[3];
								end
							else
								VIP = Inst[3];
							end
						elseif (Enum <= 297) then
							if (Enum == 296) then
								local A;
								Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Upvalues[Inst[3]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Inst[3];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Stk[Inst[3]][Stk[Inst[4]]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								for Idx = Inst[2], Inst[3] do
									Stk[Idx] = nil;
								end
								VIP = VIP + 1;
								Inst = Instr[VIP];
								A = Inst[2];
								Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
								VIP = VIP + 1;
								Inst = Instr[VIP];
								if not Stk[Inst[2]] then
									VIP = VIP + 1;
								else
									VIP = Inst[3];
								end
							else
								local A;
								Stk[Inst[2]] = Upvalues[Inst[3]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Upvalues[Inst[3]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								A = Inst[2];
								Stk[A] = Stk[A]();
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Stk[Inst[3]] - Inst[4];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Upvalues[Inst[3]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Upvalues[Inst[3]];
							end
						elseif (Enum > 298) then
							local B;
							local A;
							Stk[Inst[2]] = Upvalues[Inst[3]];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Inst[3];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Inst[3];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							A = Inst[2];
							Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Stk[Inst[3]][Stk[Inst[4]]];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Inst[3];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							A = Inst[2];
							B = Stk[Inst[3]];
							Stk[A + 1] = B;
							Stk[A] = B[Stk[Inst[4]]];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							A = Inst[2];
							Stk[A] = Stk[A](Stk[A + 1]);
							VIP = VIP + 1;
							Inst = Instr[VIP];
							if Stk[Inst[2]] then
								VIP = VIP + 1;
							else
								VIP = Inst[3];
							end
						else
							local A;
							Stk[Inst[2]] = Inst[3];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Inst[3];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							A = Inst[2];
							Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Stk[Inst[3]][Stk[Inst[4]]];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Upvalues[Inst[3]];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Inst[3];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Inst[3];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							A = Inst[2];
							Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Stk[Inst[3]][Stk[Inst[4]]];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Upvalues[Inst[3]];
						end
					elseif (Enum <= 313) then
						if (Enum <= 306) then
							if (Enum <= 302) then
								if (Enum <= 300) then
									local A;
									Stk[Inst[2]] = Upvalues[Inst[3]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									A = Inst[2];
									Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]][Stk[Inst[3]]] = Stk[Inst[4]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Upvalues[Inst[3]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									A = Inst[2];
									do
										return Stk[A](Unpack(Stk, A + 1, Inst[3]));
									end
									VIP = VIP + 1;
									Inst = Instr[VIP];
									A = Inst[2];
									do
										return Unpack(Stk, A, Top);
									end
									VIP = VIP + 1;
									Inst = Instr[VIP];
									VIP = Inst[3];
								elseif (Enum == 301) then
									local A;
									Stk[Inst[2]] = Upvalues[Inst[3]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									A = Inst[2];
									Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Stk[Inst[3]][Stk[Inst[4]]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Upvalues[Inst[3]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									A = Inst[2];
									Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Stk[Inst[3]][Stk[Inst[4]]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Upvalues[Inst[3]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									A = Inst[2];
									Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
									VIP = VIP + 1;
									Inst = Instr[VIP];
									if (Stk[Inst[2]] == Stk[Inst[4]]) then
										VIP = VIP + 1;
									else
										VIP = Inst[3];
									end
								else
									local B;
									local A;
									Stk[Inst[2]] = Upvalues[Inst[3]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									A = Inst[2];
									Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Stk[Inst[3]][Stk[Inst[4]]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									A = Inst[2];
									B = Stk[Inst[3]];
									Stk[A + 1] = B;
									Stk[A] = B[Inst[4]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									A = Inst[2];
									Stk[A] = Stk[A](Stk[A + 1]);
									VIP = VIP + 1;
									Inst = Instr[VIP];
									if Stk[Inst[2]] then
										VIP = VIP + 1;
									else
										VIP = Inst[3];
									end
								end
							elseif (Enum <= 304) then
								if (Enum > 303) then
									local B;
									local A;
									Stk[Inst[2]] = Upvalues[Inst[3]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									A = Inst[2];
									Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Stk[Inst[3]][Stk[Inst[4]]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									A = Inst[2];
									B = Stk[Inst[3]];
									Stk[A + 1] = B;
									Stk[A] = B[Inst[4]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									A = Inst[2];
									Stk[A] = Stk[A](Stk[A + 1]);
									VIP = VIP + 1;
									Inst = Instr[VIP];
									if Stk[Inst[2]] then
										VIP = VIP + 1;
									else
										VIP = Inst[3];
									end
								else
									local Edx;
									local Results, Limit;
									local B;
									local A;
									Stk[Inst[2]] = Upvalues[Inst[3]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									A = Inst[2];
									B = Stk[Inst[3]];
									Stk[A + 1] = B;
									Stk[A] = B[Inst[4]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Upvalues[Inst[3]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									A = Inst[2];
									Results, Limit = _R(Stk[A](Unpack(Stk, A + 1, Inst[3])));
									Top = (Limit + A) - 1;
									Edx = 0;
									for Idx = A, Top do
										Edx = Edx + 1;
										Stk[Idx] = Results[Edx];
									end
									VIP = VIP + 1;
									Inst = Instr[VIP];
									A = Inst[2];
									Results, Limit = _R(Stk[A](Unpack(Stk, A + 1, Top)));
									Top = (Limit + A) - 1;
									Edx = 0;
									for Idx = A, Top do
										Edx = Edx + 1;
										Stk[Idx] = Results[Edx];
									end
									VIP = VIP + 1;
									Inst = Instr[VIP];
									A = Inst[2];
									Stk[A] = Stk[A](Unpack(Stk, A + 1, Top));
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Stk[Inst[3]] + Stk[Inst[4]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									if (Stk[Inst[2]] <= Stk[Inst[4]]) then
										VIP = VIP + 1;
									else
										VIP = Inst[3];
									end
								end
							elseif (Enum > 305) then
								local B;
								local A;
								Stk[Inst[2]] = Inst[3];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								A = Inst[2];
								B = Stk[Inst[3]];
								Stk[A + 1] = B;
								Stk[A] = B[Stk[Inst[4]]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								A = Inst[2];
								Stk[A] = Stk[A](Stk[A + 1]);
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Inst[3];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								if (Stk[Inst[2]] ~= Stk[Inst[4]]) then
									VIP = VIP + 1;
								else
									VIP = Inst[3];
								end
							else
								local B;
								local A;
								Stk[Inst[2]] = Upvalues[Inst[3]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Inst[3];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Inst[3];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								A = Inst[2];
								Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Stk[Inst[3]][Stk[Inst[4]]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								A = Inst[2];
								B = Stk[Inst[3]];
								Stk[A + 1] = B;
								Stk[A] = B[Inst[4]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Env[Inst[3]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								A = Inst[2];
								Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Inst[3];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								if (Stk[Inst[2]] <= Stk[Inst[4]]) then
									VIP = VIP + 1;
								else
									VIP = Inst[3];
								end
							end
						elseif (Enum <= 309) then
							if (Enum <= 307) then
								local A = Inst[2];
								Stk[A] = Stk[A]();
							elseif (Enum > 308) then
								local A;
								Stk[Inst[2]] = Upvalues[Inst[3]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Inst[3];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Inst[3];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								A = Inst[2];
								Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Upvalues[Inst[3]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								A = Inst[2];
								Stk[A] = Stk[A]();
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]][Stk[Inst[3]]] = Stk[Inst[4]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Upvalues[Inst[3]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Inst[3];
							else
								local B;
								local Edx;
								local Results, Limit;
								local A;
								Stk[Inst[2]] = Upvalues[Inst[3]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Inst[3];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Inst[3];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								A = Inst[2];
								Results, Limit = _R(Stk[A](Unpack(Stk, A + 1, Inst[3])));
								Top = (Limit + A) - 1;
								Edx = 0;
								for Idx = A, Top do
									Edx = Edx + 1;
									Stk[Idx] = Results[Edx];
								end
								VIP = VIP + 1;
								Inst = Instr[VIP];
								A = Inst[2];
								Stk[A] = Stk[A](Unpack(Stk, A + 1, Top));
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Inst[3];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								A = Inst[2];
								B = Stk[Inst[3]];
								Stk[A + 1] = B;
								Stk[A] = B[Stk[Inst[4]]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								A = Inst[2];
								Stk[A] = Stk[A](Stk[A + 1]);
								VIP = VIP + 1;
								Inst = Instr[VIP];
								if not Stk[Inst[2]] then
									VIP = VIP + 1;
								else
									VIP = Inst[3];
								end
							end
						elseif (Enum <= 311) then
							if (Enum > 310) then
								local A;
								Stk[Inst[2]] = Upvalues[Inst[3]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Inst[3];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Inst[3];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								A = Inst[2];
								Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Stk[Inst[3]][Stk[Inst[4]]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Upvalues[Inst[3]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Inst[3];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Inst[3];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								A = Inst[2];
								Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Stk[Inst[3]][Stk[Inst[4]]];
							else
								local A;
								Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Upvalues[Inst[3]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								A = Inst[2];
								Stk[A] = Stk[A](Stk[A + 1]);
								VIP = VIP + 1;
								Inst = Instr[VIP];
								if Stk[Inst[2]] then
									VIP = VIP + 1;
								else
									VIP = Inst[3];
								end
							end
						elseif (Enum > 312) then
							local B;
							local A;
							Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Upvalues[Inst[3]];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							for Idx = Inst[2], Inst[3] do
								Stk[Idx] = nil;
							end
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Upvalues[Inst[3]];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							A = Inst[2];
							B = Stk[Inst[3]];
							Stk[A + 1] = B;
							Stk[A] = B[Inst[4]];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Upvalues[Inst[3]];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							A = Inst[2];
							Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = not Stk[Inst[3]];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							A = Inst[2];
							Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
							VIP = VIP + 1;
							Inst = Instr[VIP];
							if Stk[Inst[2]] then
								VIP = VIP + 1;
							else
								VIP = Inst[3];
							end
						elseif (Stk[Inst[2]] < Stk[Inst[4]]) then
							VIP = Inst[3];
						else
							VIP = VIP + 1;
						end
					elseif (Enum <= 320) then
						if (Enum <= 316) then
							if (Enum <= 314) then
								local A;
								Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Stk[Inst[3]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								for Idx = Inst[2], Inst[3] do
									Stk[Idx] = nil;
								end
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Stk[Inst[3]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								A = Inst[2];
								Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
								VIP = VIP + 1;
								Inst = Instr[VIP];
								if Stk[Inst[2]] then
									VIP = VIP + 1;
								else
									VIP = Inst[3];
								end
							elseif (Enum > 315) then
								local A;
								Stk[Inst[2]] = Upvalues[Inst[3]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Inst[3];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Inst[3];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								A = Inst[2];
								Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Stk[Inst[3]][Stk[Inst[4]]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Upvalues[Inst[3]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Inst[3];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Inst[3];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								A = Inst[2];
								Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Upvalues[Inst[3]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Upvalues[Inst[3]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								A = Inst[2];
								Stk[A] = Stk[A](Stk[A + 1]);
								VIP = VIP + 1;
								Inst = Instr[VIP];
								if not Stk[Inst[2]] then
									VIP = VIP + 1;
								else
									VIP = Inst[3];
								end
							else
								local Edx;
								local Results, Limit;
								local A;
								Stk[Inst[2]] = Inst[3];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Stk[Inst[3]][Stk[Inst[4]]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Env[Inst[3]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Upvalues[Inst[3]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Inst[3];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Inst[3];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								A = Inst[2];
								Results, Limit = _R(Stk[A](Unpack(Stk, A + 1, Inst[3])));
								Top = (Limit + A) - 1;
								Edx = 0;
								for Idx = A, Top do
									Edx = Edx + 1;
									Stk[Idx] = Results[Edx];
								end
								VIP = VIP + 1;
								Inst = Instr[VIP];
								A = Inst[2];
								Stk[A] = Stk[A](Unpack(Stk, A + 1, Top));
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Inst[3];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								A = Inst[2];
								Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
								VIP = VIP + 1;
								Inst = Instr[VIP];
								if Stk[Inst[2]] then
									VIP = VIP + 1;
								else
									VIP = Inst[3];
								end
							end
						elseif (Enum <= 318) then
							if (Enum > 317) then
								local B;
								local A;
								Stk[Inst[2]] = Upvalues[Inst[3]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Inst[3];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Inst[3];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								A = Inst[2];
								Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Stk[Inst[3]][Stk[Inst[4]]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								A = Inst[2];
								B = Stk[Inst[3]];
								Stk[A + 1] = B;
								Stk[A] = B[Inst[4]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								A = Inst[2];
								Stk[A] = Stk[A](Stk[A + 1]);
								VIP = VIP + 1;
								Inst = Instr[VIP];
								if Stk[Inst[2]] then
									VIP = VIP + 1;
								else
									VIP = Inst[3];
								end
							else
								local A;
								Stk[Inst[2]] = Upvalues[Inst[3]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Inst[3];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Inst[3];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								A = Inst[2];
								Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Stk[Inst[3]][Stk[Inst[4]]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = {};
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Upvalues[Inst[3]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Inst[3];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Inst[3];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								A = Inst[2];
								Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
							end
						elseif (Enum > 319) then
							local A = Inst[2];
							local B = Stk[Inst[3]];
							Stk[A + 1] = B;
							Stk[A] = B[Stk[Inst[4]]];
						else
							local B = Stk[Inst[4]];
							if not B then
								VIP = VIP + 1;
							else
								Stk[Inst[2]] = B;
								VIP = Inst[3];
							end
						end
					elseif (Enum <= 323) then
						if (Enum <= 321) then
							local B;
							local A;
							A = Inst[2];
							B = Stk[Inst[3]];
							Stk[A + 1] = B;
							Stk[A] = B[Inst[4]];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Inst[3] ~= 0;
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Inst[3] ~= 0;
							VIP = VIP + 1;
							Inst = Instr[VIP];
							A = Inst[2];
							Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
							VIP = VIP + 1;
							Inst = Instr[VIP];
							if not Stk[Inst[2]] then
								VIP = VIP + 1;
							else
								VIP = Inst[3];
							end
						elseif (Enum == 322) then
							local A;
							Stk[Inst[2]] = Upvalues[Inst[3]];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Inst[3];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Inst[3];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							A = Inst[2];
							Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Stk[Inst[3]][Stk[Inst[4]]];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Env[Inst[3]];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Upvalues[Inst[3]];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Inst[3];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Inst[3];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							A = Inst[2];
							Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
						else
							Stk[Inst[2]] = Stk[Inst[3]] + Stk[Inst[4]];
						end
					elseif (Enum <= 325) then
						if (Enum == 324) then
							local Edx;
							local Results, Limit;
							local B;
							local A;
							Stk[Inst[2]] = Upvalues[Inst[3]];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							A = Inst[2];
							B = Stk[Inst[3]];
							Stk[A + 1] = B;
							Stk[A] = B[Inst[4]];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Upvalues[Inst[3]];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							A = Inst[2];
							Results, Limit = _R(Stk[A](Unpack(Stk, A + 1, Inst[3])));
							Top = (Limit + A) - 1;
							Edx = 0;
							for Idx = A, Top do
								Edx = Edx + 1;
								Stk[Idx] = Results[Edx];
							end
							VIP = VIP + 1;
							Inst = Instr[VIP];
							A = Inst[2];
							Results, Limit = _R(Stk[A](Unpack(Stk, A + 1, Top)));
							Top = (Limit + A) - 1;
							Edx = 0;
							for Idx = A, Top do
								Edx = Edx + 1;
								Stk[Idx] = Results[Edx];
							end
							VIP = VIP + 1;
							Inst = Instr[VIP];
							A = Inst[2];
							Stk[A] = Stk[A](Unpack(Stk, A + 1, Top));
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Stk[Inst[3]] + Stk[Inst[4]];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Upvalues[Inst[3]];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Upvalues[Inst[3]];
						else
							do
								return;
							end
						end
					elseif (Enum > 326) then
						local A;
						Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
						VIP = VIP + 1;
						Inst = Instr[VIP];
						Stk[Inst[2]] = Upvalues[Inst[3]];
						VIP = VIP + 1;
						Inst = Instr[VIP];
						Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
						VIP = VIP + 1;
						Inst = Instr[VIP];
						A = Inst[2];
						Stk[A] = Stk[A](Stk[A + 1]);
						VIP = VIP + 1;
						Inst = Instr[VIP];
						if Stk[Inst[2]] then
							VIP = VIP + 1;
						else
							VIP = Inst[3];
						end
					else
						local Edx;
						local Results, Limit;
						local B;
						local A;
						Stk[Inst[2]] = Upvalues[Inst[3]];
						VIP = VIP + 1;
						Inst = Instr[VIP];
						Stk[Inst[2]] = Upvalues[Inst[3]];
						VIP = VIP + 1;
						Inst = Instr[VIP];
						Stk[Inst[2]] = Inst[3];
						VIP = VIP + 1;
						Inst = Instr[VIP];
						Stk[Inst[2]] = Inst[3];
						VIP = VIP + 1;
						Inst = Instr[VIP];
						A = Inst[2];
						Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
						VIP = VIP + 1;
						Inst = Instr[VIP];
						Stk[Inst[2]] = Stk[Inst[3]][Stk[Inst[4]]];
						VIP = VIP + 1;
						Inst = Instr[VIP];
						A = Inst[2];
						B = Stk[Inst[3]];
						Stk[A + 1] = B;
						Stk[A] = B[Inst[4]];
						VIP = VIP + 1;
						Inst = Instr[VIP];
						A = Inst[2];
						Results, Limit = _R(Stk[A](Stk[A + 1]));
						Top = (Limit + A) - 1;
						Edx = 0;
						for Idx = A, Top do
							Edx = Edx + 1;
							Stk[Idx] = Results[Edx];
						end
						VIP = VIP + 1;
						Inst = Instr[VIP];
						A = Inst[2];
						Stk[A] = Stk[A](Unpack(Stk, A + 1, Top));
						VIP = VIP + 1;
						Inst = Instr[VIP];
						Stk[Inst[2]] = Inst[3] + Stk[Inst[4]];
					end
				elseif (Enum <= 382) then
					if (Enum <= 354) then
						if (Enum <= 340) then
							if (Enum <= 333) then
								if (Enum <= 330) then
									if (Enum <= 328) then
										local B;
										local A;
										Stk[Inst[2]] = Upvalues[Inst[3]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Inst[3];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Inst[3];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										A = Inst[2];
										Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Stk[Inst[3]][Stk[Inst[4]]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										A = Inst[2];
										B = Stk[Inst[3]];
										Stk[A + 1] = B;
										Stk[A] = B[Inst[4]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										A = Inst[2];
										Stk[A] = Stk[A](Stk[A + 1]);
										VIP = VIP + 1;
										Inst = Instr[VIP];
										if Stk[Inst[2]] then
											VIP = VIP + 1;
										else
											VIP = Inst[3];
										end
									elseif (Enum == 329) then
										local Edx;
										local Results, Limit;
										local B;
										local A;
										Stk[Inst[2]] = Inst[3];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										A = Inst[2];
										B = Stk[Inst[3]];
										Stk[A + 1] = B;
										Stk[A] = B[Stk[Inst[4]]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Upvalues[Inst[3]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Inst[3];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										A = Inst[2];
										Results, Limit = _R(Stk[A](Stk[A + 1]));
										Top = (Limit + A) - 1;
										Edx = 0;
										for Idx = A, Top do
											Edx = Edx + 1;
											Stk[Idx] = Results[Edx];
										end
										VIP = VIP + 1;
										Inst = Instr[VIP];
										A = Inst[2];
										Stk[A] = Stk[A](Unpack(Stk, A + 1, Top));
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Stk[Inst[3]];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Inst[3];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										Stk[Inst[2]] = Inst[3];
										VIP = VIP + 1;
										Inst = Instr[VIP];
										if (Stk[Inst[2]] == Stk[Inst[4]]) then
											VIP = VIP + 1;
										else
											VIP = Inst[3];
										end
									elseif (Inst[2] < Stk[Inst[4]]) then
										VIP = Inst[3];
									else
										VIP = VIP + 1;
									end
								elseif (Enum <= 331) then
									local B;
									local A;
									Stk[Inst[2]] = Upvalues[Inst[3]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									A = Inst[2];
									Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Stk[Inst[3]][Stk[Inst[4]]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									A = Inst[2];
									B = Stk[Inst[3]];
									Stk[A + 1] = B;
									Stk[A] = B[Inst[4]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									A = Inst[2];
									Stk[A] = Stk[A](Stk[A + 1]);
									VIP = VIP + 1;
									Inst = Instr[VIP];
									if Stk[Inst[2]] then
										VIP = VIP + 1;
									else
										VIP = Inst[3];
									end
								elseif (Enum > 332) then
									if (Inst[2] < Inst[4]) then
										VIP = Inst[3];
									else
										VIP = VIP + 1;
									end
								else
									local A = Inst[2];
									local Step = Stk[A + 2];
									local Index = Stk[A] + Step;
									Stk[A] = Index;
									if (Step > 0) then
										if (Index <= Stk[A + 1]) then
											VIP = Inst[3];
											Stk[A + 3] = Index;
										end
									elseif (Index >= Stk[A + 1]) then
										VIP = Inst[3];
										Stk[A + 3] = Index;
									end
								end
							elseif (Enum <= 336) then
								if (Enum <= 334) then
									local A = Inst[2];
									Top = (A + Varargsz) - 1;
									for Idx = A, Top do
										local VA = Vararg[Idx - A];
										Stk[Idx] = VA;
									end
								elseif (Enum == 335) then
									local A;
									Stk[Inst[2]] = Upvalues[Inst[3]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									A = Inst[2];
									Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Stk[Inst[3]][Stk[Inst[4]]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Upvalues[Inst[3]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									A = Inst[2];
									Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = {};
								else
									local A;
									Stk[Inst[2]] = Upvalues[Inst[3]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									A = Inst[2];
									Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]][Stk[Inst[3]]] = Stk[Inst[4]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Upvalues[Inst[3]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									A = Inst[2];
									do
										return Stk[A](Unpack(Stk, A + 1, Inst[3]));
									end
									VIP = VIP + 1;
									Inst = Instr[VIP];
									A = Inst[2];
									do
										return Unpack(Stk, A, Top);
									end
									VIP = VIP + 1;
									Inst = Instr[VIP];
									VIP = Inst[3];
								end
							elseif (Enum <= 338) then
								if (Enum > 337) then
									local B;
									local A;
									A = Inst[2];
									B = Stk[Inst[3]];
									Stk[A + 1] = B;
									Stk[A] = B[Inst[4]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3] ~= 0;
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3] ~= 0;
									VIP = VIP + 1;
									Inst = Instr[VIP];
									A = Inst[2];
									Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
									VIP = VIP + 1;
									Inst = Instr[VIP];
									if Stk[Inst[2]] then
										VIP = VIP + 1;
									else
										VIP = Inst[3];
									end
								else
									local A;
									Stk[Inst[2]] = Upvalues[Inst[3]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									A = Inst[2];
									Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Stk[Inst[3]][Stk[Inst[4]]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Upvalues[Inst[3]] = Stk[Inst[2]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Env[Inst[3]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Upvalues[Inst[3]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									A = Inst[2];
									Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Stk[Inst[3]][Stk[Inst[4]]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Upvalues[Inst[3]] = Stk[Inst[2]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Env[Inst[3]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Upvalues[Inst[3]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									A = Inst[2];
									Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Stk[Inst[3]][Stk[Inst[4]]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Upvalues[Inst[3]] = Stk[Inst[2]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Env[Inst[3]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Upvalues[Inst[3]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									A = Inst[2];
									Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Stk[Inst[3]][Stk[Inst[4]]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Upvalues[Inst[3]] = Stk[Inst[2]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
								end
							elseif (Enum == 339) then
								local A = Inst[2];
								Stk[A](Unpack(Stk, A + 1, Inst[3]));
							else
								local B;
								local A;
								Stk[Inst[2]] = Upvalues[Inst[3]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Inst[3];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Inst[3];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								A = Inst[2];
								Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Stk[Inst[3]][Stk[Inst[4]]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								A = Inst[2];
								B = Stk[Inst[3]];
								Stk[A + 1] = B;
								Stk[A] = B[Inst[4]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								A = Inst[2];
								Stk[A] = Stk[A](Stk[A + 1]);
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Inst[3];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								if (Stk[Inst[2]] < Stk[Inst[4]]) then
									VIP = Inst[3];
								else
									VIP = VIP + 1;
								end
							end
						elseif (Enum <= 347) then
							if (Enum <= 343) then
								if (Enum <= 341) then
									local Edx;
									local Results, Limit;
									local A;
									Stk[Inst[2]] = Stk[Inst[3]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Upvalues[Inst[3]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Upvalues[Inst[3]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Upvalues[Inst[3]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Upvalues[Inst[3]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Stk[Inst[3]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Stk[Inst[3]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Stk[Inst[3]] + Inst[4];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									A = Inst[2];
									Results, Limit = _R(Stk[A](Unpack(Stk, A + 1, Inst[3])));
									Top = (Limit + A) - 1;
									Edx = 0;
									for Idx = A, Top do
										Edx = Edx + 1;
										Stk[Idx] = Results[Edx];
									end
									VIP = VIP + 1;
									Inst = Instr[VIP];
									A = Inst[2];
									Stk[A] = Stk[A](Unpack(Stk, A + 1, Top));
								elseif (Enum == 342) then
									local A;
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Stk[Inst[3]][Stk[Inst[4]]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									A = Inst[2];
									Stk[A] = Stk[A]();
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Upvalues[Inst[3]] = Stk[Inst[2]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Upvalues[Inst[3]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									if Stk[Inst[2]] then
										VIP = VIP + 1;
									else
										VIP = Inst[3];
									end
								elseif Stk[Inst[2]] then
									VIP = VIP + 1;
								else
									VIP = Inst[3];
								end
							elseif (Enum <= 345) then
								if (Enum > 344) then
									local B;
									local A;
									Stk[Inst[2]] = Upvalues[Inst[3]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									A = Inst[2];
									Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Stk[Inst[3]][Stk[Inst[4]]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									A = Inst[2];
									B = Stk[Inst[3]];
									Stk[A + 1] = B;
									Stk[A] = B[Inst[4]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									A = Inst[2];
									Stk[A] = Stk[A](Stk[A + 1]);
									VIP = VIP + 1;
									Inst = Instr[VIP];
									if Stk[Inst[2]] then
										VIP = VIP + 1;
									else
										VIP = Inst[3];
									end
								else
									local B;
									local A;
									Stk[Inst[2]] = Upvalues[Inst[3]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									A = Inst[2];
									Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Stk[Inst[3]][Stk[Inst[4]]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									A = Inst[2];
									B = Stk[Inst[3]];
									Stk[A + 1] = B;
									Stk[A] = B[Inst[4]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									A = Inst[2];
									Stk[A] = Stk[A](Stk[A + 1]);
									VIP = VIP + 1;
									Inst = Instr[VIP];
									if Stk[Inst[2]] then
										VIP = VIP + 1;
									else
										VIP = Inst[3];
									end
								end
							elseif (Enum == 346) then
								local A;
								A = Inst[2];
								Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Upvalues[Inst[3]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Upvalues[Inst[3]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Inst[3];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Inst[3];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								A = Inst[2];
								Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Stk[Inst[3]][Stk[Inst[4]]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Upvalues[Inst[3]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Inst[3];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Inst[3];
							else
								local B;
								local A;
								Stk[Inst[2]] = Upvalues[Inst[3]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Inst[3];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Inst[3];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								A = Inst[2];
								Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Stk[Inst[3]][Stk[Inst[4]]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								A = Inst[2];
								B = Stk[Inst[3]];
								Stk[A + 1] = B;
								Stk[A] = B[Inst[4]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								A = Inst[2];
								Stk[A] = Stk[A](Stk[A + 1]);
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Inst[3];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								if (Stk[Inst[2]] < Stk[Inst[4]]) then
									VIP = Inst[3];
								else
									VIP = VIP + 1;
								end
							end
						elseif (Enum <= 350) then
							if (Enum <= 348) then
								local B;
								local Edx;
								local Results, Limit;
								local A;
								Stk[Inst[2]] = Upvalues[Inst[3]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Inst[3];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Inst[3];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								A = Inst[2];
								Results, Limit = _R(Stk[A](Unpack(Stk, A + 1, Inst[3])));
								Top = (Limit + A) - 1;
								Edx = 0;
								for Idx = A, Top do
									Edx = Edx + 1;
									Stk[Idx] = Results[Edx];
								end
								VIP = VIP + 1;
								Inst = Instr[VIP];
								A = Inst[2];
								Stk[A] = Stk[A](Unpack(Stk, A + 1, Top));
								VIP = VIP + 1;
								Inst = Instr[VIP];
								A = Inst[2];
								B = Stk[Inst[3]];
								Stk[A + 1] = B;
								Stk[A] = B[Inst[4]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Upvalues[Inst[3]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Inst[3];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Stk[Inst[3]][Stk[Inst[4]]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								A = Inst[2];
								Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
								VIP = VIP + 1;
								Inst = Instr[VIP];
								if Stk[Inst[2]] then
									VIP = VIP + 1;
								else
									VIP = Inst[3];
								end
							elseif (Enum == 349) then
								Stk[Inst[2]] = Inst[3] + Stk[Inst[4]];
							else
								local A;
								Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Upvalues[Inst[3]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Inst[3];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Stk[Inst[3]][Stk[Inst[4]]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								A = Inst[2];
								Stk[A] = Stk[A](Stk[A + 1]);
								VIP = VIP + 1;
								Inst = Instr[VIP];
								if Stk[Inst[2]] then
									VIP = VIP + 1;
								else
									VIP = Inst[3];
								end
							end
						elseif (Enum <= 352) then
							if (Enum == 351) then
								local B;
								local A;
								A = Inst[2];
								B = Stk[Inst[3]];
								Stk[A + 1] = B;
								Stk[A] = B[Inst[4]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Inst[3];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Inst[3];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								A = Inst[2];
								Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
								VIP = VIP + 1;
								Inst = Instr[VIP];
								if not Stk[Inst[2]] then
									VIP = VIP + 1;
								else
									VIP = Inst[3];
								end
							else
								local Edx;
								local Results, Limit;
								local B;
								local A;
								Stk[Inst[2]] = Upvalues[Inst[3]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Upvalues[Inst[3]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Upvalues[Inst[3]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Inst[3];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Inst[3];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								A = Inst[2];
								Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Stk[Inst[3]][Stk[Inst[4]]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								A = Inst[2];
								B = Stk[Inst[3]];
								Stk[A + 1] = B;
								Stk[A] = B[Inst[4]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								A = Inst[2];
								Results, Limit = _R(Stk[A](Stk[A + 1]));
								Top = (Limit + A) - 1;
								Edx = 0;
								for Idx = A, Top do
									Edx = Edx + 1;
									Stk[Idx] = Results[Edx];
								end
								VIP = VIP + 1;
								Inst = Instr[VIP];
								A = Inst[2];
								Stk[A] = Stk[A](Unpack(Stk, A + 1, Top));
							end
						elseif (Enum == 353) then
							local B;
							local A;
							A = Inst[2];
							B = Stk[Inst[3]];
							Stk[A + 1] = B;
							Stk[A] = B[Inst[4]];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Inst[3] ~= 0;
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Inst[3] ~= 0;
							VIP = VIP + 1;
							Inst = Instr[VIP];
							A = Inst[2];
							Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
							VIP = VIP + 1;
							Inst = Instr[VIP];
							if not Stk[Inst[2]] then
								VIP = VIP + 1;
							else
								VIP = Inst[3];
							end
						else
							local B;
							local A;
							Stk[Inst[2]] = Upvalues[Inst[3]];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Inst[3];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Inst[3];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							A = Inst[2];
							Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Stk[Inst[3]][Stk[Inst[4]]];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							A = Inst[2];
							B = Stk[Inst[3]];
							Stk[A + 1] = B;
							Stk[A] = B[Inst[4]];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							A = Inst[2];
							Stk[A] = Stk[A](Stk[A + 1]);
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Inst[3];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							if (Stk[Inst[2]] > Stk[Inst[4]]) then
								VIP = VIP + 1;
							else
								VIP = VIP + Inst[3];
							end
						end
					elseif (Enum <= 368) then
						if (Enum <= 361) then
							if (Enum <= 357) then
								if (Enum <= 355) then
									local B;
									local A;
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									A = Inst[2];
									B = Stk[Inst[3]];
									Stk[A + 1] = B;
									Stk[A] = B[Stk[Inst[4]]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Env[Inst[3]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									A = Inst[2];
									Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
									VIP = VIP + 1;
									Inst = Instr[VIP];
									if not Stk[Inst[2]] then
										VIP = VIP + 1;
									else
										VIP = Inst[3];
									end
								elseif (Enum > 356) then
									local NewProto = Proto[Inst[3]];
									local NewUvals;
									local Indexes = {};
									NewUvals = Setmetatable({}, {__index=function(_, Key)
										local Val = Indexes[Key];
										return Val[1][Val[2]];
									end,__newindex=function(_, Key, Value)
										local Val = Indexes[Key];
										Val[1][Val[2]] = Value;
									end});
									for Idx = 1, Inst[4] do
										VIP = VIP + 1;
										local Mvm = Instr[VIP];
										if (Mvm[1] == 275) then
											Indexes[Idx - 1] = {Stk,Mvm[3]};
										else
											Indexes[Idx - 1] = {Upvalues,Mvm[3]};
										end
										Lupvals[#Lupvals + 1] = Indexes;
									end
									Stk[Inst[2]] = Wrap(NewProto, NewUvals, Env);
								else
									local A;
									Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Upvalues[Inst[3]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Stk[Inst[3]][Stk[Inst[4]]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									for Idx = Inst[2], Inst[3] do
										Stk[Idx] = nil;
									end
									VIP = VIP + 1;
									Inst = Instr[VIP];
									A = Inst[2];
									Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
									VIP = VIP + 1;
									Inst = Instr[VIP];
									if not Stk[Inst[2]] then
										VIP = VIP + 1;
									else
										VIP = Inst[3];
									end
								end
							elseif (Enum <= 359) then
								if (Enum == 358) then
									if (Inst[2] <= Stk[Inst[4]]) then
										VIP = VIP + 1;
									else
										VIP = Inst[3];
									end
								else
									local B;
									local A;
									Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Upvalues[Inst[3]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									for Idx = Inst[2], Inst[3] do
										Stk[Idx] = nil;
									end
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Upvalues[Inst[3]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									A = Inst[2];
									B = Stk[Inst[3]];
									Stk[A + 1] = B;
									Stk[A] = B[Inst[4]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Upvalues[Inst[3]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									A = Inst[2];
									Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = not Stk[Inst[3]];
								end
							elseif (Enum > 360) then
								local A;
								Stk[Inst[2]] = Upvalues[Inst[3]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Inst[3];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Inst[3];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								A = Inst[2];
								Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Inst[3];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]][Stk[Inst[3]]] = Stk[Inst[4]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Upvalues[Inst[3]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Inst[3];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Inst[3];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								A = Inst[2];
								do
									return Stk[A](Unpack(Stk, A + 1, Inst[3]));
								end
								VIP = VIP + 1;
								Inst = Instr[VIP];
								A = Inst[2];
								do
									return Unpack(Stk, A, Top);
								end
							else
								local A;
								Stk[Inst[2]] = Upvalues[Inst[3]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Inst[3];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Upvalues[Inst[3]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								A = Inst[2];
								Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Upvalues[Inst[3]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Inst[3];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Upvalues[Inst[3]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								A = Inst[2];
								Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Stk[Inst[3]] + Stk[Inst[4]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								if (Stk[Inst[2]] < Stk[Inst[4]]) then
									VIP = Inst[3];
								else
									VIP = VIP + 1;
								end
							end
						elseif (Enum <= 364) then
							if (Enum <= 362) then
								local A;
								Stk[Inst[2]] = Upvalues[Inst[3]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Inst[3];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Inst[3];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								A = Inst[2];
								Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Stk[Inst[3]][Stk[Inst[4]]];
							elseif (Enum > 363) then
								local A;
								Stk[Inst[2]] = Upvalues[Inst[3]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Inst[3];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Inst[3];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								A = Inst[2];
								Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]][Stk[Inst[3]]] = Inst[4];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Upvalues[Inst[3]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Inst[3];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Inst[3];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								A = Inst[2];
								do
									return Stk[A](Unpack(Stk, A + 1, Inst[3]));
								end
								VIP = VIP + 1;
								Inst = Instr[VIP];
								A = Inst[2];
								do
									return Unpack(Stk, A, Top);
								end
								VIP = VIP + 1;
								Inst = Instr[VIP];
								VIP = Inst[3];
							else
								local B;
								local A;
								Stk[Inst[2]] = Inst[3];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								A = Inst[2];
								B = Stk[Inst[3]];
								Stk[A + 1] = B;
								Stk[A] = B[Stk[Inst[4]]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Upvalues[Inst[3]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Inst[3];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Stk[Inst[3]][Stk[Inst[4]]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								A = Inst[2];
								Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Upvalues[Inst[3]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Inst[3];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Upvalues[Inst[3]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								A = Inst[2];
								Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Upvalues[Inst[3]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Inst[3];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Upvalues[Inst[3]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								A = Inst[2];
								Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Stk[Inst[3]] + Stk[Inst[4]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Inst[3];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Stk[Inst[3]] * Stk[Inst[4]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								if (Stk[Inst[2]] < Stk[Inst[4]]) then
									VIP = Inst[3];
								else
									VIP = VIP + 1;
								end
							end
						elseif (Enum <= 366) then
							if (Enum > 365) then
								local A;
								Stk[Inst[2]] = Stk[Inst[3]][Stk[Inst[4]]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Env[Inst[3]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Upvalues[Inst[3]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Inst[3];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Inst[3];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								A = Inst[2];
								Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Stk[Inst[3]][Stk[Inst[4]]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Env[Inst[3]];
							else
								Stk[Inst[2]][Stk[Inst[3]]] = Inst[4];
							end
						elseif (Enum == 367) then
							local A;
							Stk[Inst[2]] = Upvalues[Inst[3]];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Inst[3];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Inst[3];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							A = Inst[2];
							Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Stk[Inst[3]][Stk[Inst[4]]];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Upvalues[Inst[3]];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Inst[3];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Inst[3];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							A = Inst[2];
							Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Stk[Inst[3]][Stk[Inst[4]]];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Upvalues[Inst[3]];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Inst[3];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Inst[3];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							A = Inst[2];
							Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Stk[Inst[3]][Stk[Inst[4]]];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							if not Stk[Inst[2]] then
								VIP = VIP + 1;
							else
								VIP = Inst[3];
							end
						else
							local Edx;
							local Results, Limit;
							local A;
							Stk[Inst[2]] = Inst[3];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Env[Inst[3]];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Upvalues[Inst[3]];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Inst[3];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Inst[3];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							A = Inst[2];
							Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Stk[Inst[3]];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							A = Inst[2];
							Results, Limit = _R(Stk[A](Unpack(Stk, A + 1, Inst[3])));
							Top = (Limit + A) - 1;
							Edx = 0;
							for Idx = A, Top do
								Edx = Edx + 1;
								Stk[Idx] = Results[Edx];
							end
							VIP = VIP + 1;
							Inst = Instr[VIP];
							A = Inst[2];
							Stk[A] = Stk[A](Unpack(Stk, A + 1, Top));
							VIP = VIP + 1;
							Inst = Instr[VIP];
							if (Stk[Inst[2]] == Inst[4]) then
								VIP = VIP + 1;
							else
								VIP = Inst[3];
							end
						end
					elseif (Enum <= 375) then
						if (Enum <= 371) then
							if (Enum <= 369) then
								local A;
								Stk[Inst[2]] = Upvalues[Inst[3]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Inst[3];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Inst[3];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								A = Inst[2];
								Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Stk[Inst[3]][Stk[Inst[4]]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Upvalues[Inst[3]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Inst[3];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Inst[3];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								A = Inst[2];
								Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Stk[Inst[3]][Stk[Inst[4]]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Upvalues[Inst[3]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Inst[3];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Inst[3];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								A = Inst[2];
								Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Stk[Inst[3]][Stk[Inst[4]]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								if not Stk[Inst[2]] then
									VIP = VIP + 1;
								else
									VIP = Inst[3];
								end
							elseif (Enum > 370) then
								local A;
								Stk[Inst[2]] = Upvalues[Inst[3]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Inst[3];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Inst[3];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								A = Inst[2];
								Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Inst[3];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]][Stk[Inst[3]]] = Stk[Inst[4]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Upvalues[Inst[3]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Inst[3];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Inst[3];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								A = Inst[2];
								do
									return Stk[A](Unpack(Stk, A + 1, Inst[3]));
								end
								VIP = VIP + 1;
								Inst = Instr[VIP];
								A = Inst[2];
								do
									return Unpack(Stk, A, Top);
								end
								VIP = VIP + 1;
								Inst = Instr[VIP];
								VIP = Inst[3];
							else
								local Edx;
								local Results, Limit;
								local B;
								local A;
								Stk[Inst[2]] = Inst[3];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								A = Inst[2];
								B = Stk[Inst[3]];
								Stk[A + 1] = B;
								Stk[A] = B[Stk[Inst[4]]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Upvalues[Inst[3]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Inst[3];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								A = Inst[2];
								Results, Limit = _R(Stk[A](Stk[A + 1]));
								Top = (Limit + A) - 1;
								Edx = 0;
								for Idx = A, Top do
									Edx = Edx + 1;
									Stk[Idx] = Results[Edx];
								end
								VIP = VIP + 1;
								Inst = Instr[VIP];
								A = Inst[2];
								Stk[A] = Stk[A](Unpack(Stk, A + 1, Top));
								VIP = VIP + 1;
								Inst = Instr[VIP];
								if Stk[Inst[2]] then
									VIP = VIP + 1;
								else
									VIP = Inst[3];
								end
							end
						elseif (Enum <= 373) then
							if (Enum == 372) then
								Stk[Inst[2]] = Stk[Inst[3]] - Inst[4];
							else
								local A;
								Stk[Inst[2]] = Upvalues[Inst[3]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Inst[3];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Inst[3];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								A = Inst[2];
								Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]][Stk[Inst[3]]] = Inst[4];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Upvalues[Inst[3]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Inst[3];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Inst[3];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								A = Inst[2];
								do
									return Stk[A](Unpack(Stk, A + 1, Inst[3]));
								end
								VIP = VIP + 1;
								Inst = Instr[VIP];
								A = Inst[2];
								do
									return Unpack(Stk, A, Top);
								end
								VIP = VIP + 1;
								Inst = Instr[VIP];
								VIP = Inst[3];
							end
						elseif (Enum == 374) then
							Stk[Inst[2]] = Stk[Inst[3]] % Inst[4];
						else
							local A;
							Stk[Inst[2]] = Stk[Inst[3]][Stk[Inst[4]]];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							A = Inst[2];
							Stk[A](Unpack(Stk, A + 1, Inst[3]));
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Env[Inst[3]];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Upvalues[Inst[3]];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Inst[3];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Inst[3];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							A = Inst[2];
							Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Upvalues[Inst[3]];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Upvalues[Inst[3]];
						end
					elseif (Enum <= 378) then
						if (Enum <= 376) then
							local A;
							Stk[Inst[2]] = Upvalues[Inst[3]];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Inst[3];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Inst[3];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							A = Inst[2];
							Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Inst[3];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]][Stk[Inst[3]]] = Stk[Inst[4]];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Upvalues[Inst[3]];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Inst[3];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Inst[3];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							A = Inst[2];
							Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
						elseif (Enum == 377) then
							local A;
							Stk[Inst[2]] = Inst[3];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Inst[3];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							A = Inst[2];
							Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Stk[Inst[3]][Stk[Inst[4]]];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Upvalues[Inst[3]];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Inst[3];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Inst[3];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							A = Inst[2];
							Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Stk[Inst[3]][Stk[Inst[4]]];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							if (Stk[Inst[2]] > Inst[4]) then
								VIP = VIP + 1;
							else
								VIP = Inst[3];
							end
						else
							local A = Inst[2];
							local Results, Limit = _R(Stk[A](Unpack(Stk, A + 1, Inst[3])));
							Top = (Limit + A) - 1;
							local Edx = 0;
							for Idx = A, Top do
								Edx = Edx + 1;
								Stk[Idx] = Results[Edx];
							end
						end
					elseif (Enum <= 380) then
						if (Enum == 379) then
							local A;
							Stk[Inst[2]] = Upvalues[Inst[3]];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Inst[3];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Inst[3];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							A = Inst[2];
							Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Stk[Inst[3]][Stk[Inst[4]]];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Upvalues[Inst[3]];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Inst[3];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Inst[3];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							A = Inst[2];
							Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Stk[Inst[3]][Stk[Inst[4]]];
						else
							local A;
							Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Inst[3];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Inst[3];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							A = Inst[2];
							Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
							VIP = VIP + 1;
							Inst = Instr[VIP];
							if Stk[Inst[2]] then
								VIP = VIP + 1;
							else
								VIP = Inst[3];
							end
						end
					elseif (Enum > 381) then
						local Edx;
						local Results, Limit;
						local A;
						Stk[Inst[2]] = Upvalues[Inst[3]];
						VIP = VIP + 1;
						Inst = Instr[VIP];
						Stk[Inst[2]] = Inst[3];
						VIP = VIP + 1;
						Inst = Instr[VIP];
						Stk[Inst[2]] = Inst[3];
						VIP = VIP + 1;
						Inst = Instr[VIP];
						A = Inst[2];
						Results, Limit = _R(Stk[A](Unpack(Stk, A + 1, Inst[3])));
						Top = (Limit + A) - 1;
						Edx = 0;
						for Idx = A, Top do
							Edx = Edx + 1;
							Stk[Idx] = Results[Edx];
						end
						VIP = VIP + 1;
						Inst = Instr[VIP];
						A = Inst[2];
						Stk[A] = Stk[A](Unpack(Stk, A + 1, Top));
					else
						local B;
						local A;
						Stk[Inst[2]] = Upvalues[Inst[3]];
						VIP = VIP + 1;
						Inst = Instr[VIP];
						Stk[Inst[2]] = Inst[3];
						VIP = VIP + 1;
						Inst = Instr[VIP];
						Stk[Inst[2]] = Inst[3];
						VIP = VIP + 1;
						Inst = Instr[VIP];
						A = Inst[2];
						Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
						VIP = VIP + 1;
						Inst = Instr[VIP];
						Stk[Inst[2]] = Stk[Inst[3]][Stk[Inst[4]]];
						VIP = VIP + 1;
						Inst = Instr[VIP];
						Stk[Inst[2]] = Inst[3];
						VIP = VIP + 1;
						Inst = Instr[VIP];
						A = Inst[2];
						B = Stk[Inst[3]];
						Stk[A + 1] = B;
						Stk[A] = B[Stk[Inst[4]]];
						VIP = VIP + 1;
						Inst = Instr[VIP];
						A = Inst[2];
						Stk[A] = Stk[A](Stk[A + 1]);
						VIP = VIP + 1;
						Inst = Instr[VIP];
						Stk[Inst[2]] = Inst[3];
						VIP = VIP + 1;
						Inst = Instr[VIP];
						if (Stk[Inst[2]] < Stk[Inst[4]]) then
							VIP = Inst[3];
						else
							VIP = VIP + 1;
						end
					end
				elseif (Enum <= 409) then
					if (Enum <= 395) then
						if (Enum <= 388) then
							if (Enum <= 385) then
								if (Enum <= 383) then
									local B;
									local A;
									Stk[Inst[2]] = Upvalues[Inst[3]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									A = Inst[2];
									Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Stk[Inst[3]][Stk[Inst[4]]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									Stk[Inst[2]] = Inst[3];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									A = Inst[2];
									B = Stk[Inst[3]];
									Stk[A + 1] = B;
									Stk[A] = B[Stk[Inst[4]]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									A = Inst[2];
									Stk[A] = Stk[A](Stk[A + 1]);
									VIP = VIP + 1;
									Inst = Instr[VIP];
									if Stk[Inst[2]] then
										VIP = VIP + 1;
									else
										VIP = Inst[3];
									end
								elseif (Enum == 384) then
									Stk[Inst[2]]();
								else
									local K;
									local B;
									local A;
									A = Inst[2];
									B = Stk[Inst[3]];
									Stk[A + 1] = B;
									Stk[A] = B[Stk[Inst[4]]];
									VIP = VIP + 1;
									Inst = Instr[VIP];
									A = Inst[2];
									Stk[A] = Stk[A](Stk[A + 1]);
									VIP = VIP + 1;
									Inst = Instr[VIP];
									B = Inst[3];
									K = Stk[B];
									for Idx = B + 1, Inst[4] do
										K = K .. Stk[Idx];
									end
									Stk[Inst[2]] = K;
									VIP = VIP + 1;
									Inst = Instr[VIP];
									do
										return Stk[Inst[2]];
									end
									VIP = VIP + 1;
									Inst = Instr[VIP];
									VIP = Inst[3];
								end
							elseif (Enum <= 386) then
								local B;
								local A;
								Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Upvalues[Inst[3]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Inst[3];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Stk[Inst[3]][Stk[Inst[4]]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								for Idx = Inst[2], Inst[3] do
									Stk[Idx] = nil;
								end
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Upvalues[Inst[3]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								A = Inst[2];
								B = Stk[Inst[3]];
								Stk[A + 1] = B;
								Stk[A] = B[Inst[4]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Upvalues[Inst[3]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Inst[3];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Stk[Inst[3]][Stk[Inst[4]]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								A = Inst[2];
								Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = not Stk[Inst[3]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								A = Inst[2];
								Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
								VIP = VIP + 1;
								Inst = Instr[VIP];
								if Stk[Inst[2]] then
									VIP = VIP + 1;
								else
									VIP = Inst[3];
								end
							elseif (Enum > 387) then
								local B;
								local A;
								Stk[Inst[2]] = Inst[3];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								A = Inst[2];
								B = Stk[Inst[3]];
								Stk[A + 1] = B;
								Stk[A] = B[Stk[Inst[4]]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Inst[3];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Upvalues[Inst[3]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Inst[3];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Stk[Inst[3]][Stk[Inst[4]]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								A = Inst[2];
								Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
								VIP = VIP + 1;
								Inst = Instr[VIP];
								if not Stk[Inst[2]] then
									VIP = VIP + 1;
								else
									VIP = Inst[3];
								end
							else
								local A;
								A = Inst[2];
								Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Stk[Inst[3]][Stk[Inst[4]]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Upvalues[Inst[3]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Inst[3];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Inst[3];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								A = Inst[2];
								Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Stk[Inst[3]][Stk[Inst[4]]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Upvalues[Inst[3]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Inst[3];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Inst[3];
							end
						elseif (Enum <= 391) then
							if (Enum <= 389) then
								local A;
								Stk[Inst[2]] = Inst[3];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								A = Inst[2];
								Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Stk[Inst[3]][Stk[Inst[4]]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Upvalues[Inst[3]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Inst[3];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Inst[3];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								A = Inst[2];
								Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Stk[Inst[3]][Stk[Inst[4]]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Upvalues[Inst[3]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Inst[3];
							elseif (Enum > 390) then
								local B;
								local A;
								Stk[Inst[2]] = Upvalues[Inst[3]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Inst[3];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Inst[3];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								A = Inst[2];
								Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Stk[Inst[3]][Stk[Inst[4]]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								A = Inst[2];
								B = Stk[Inst[3]];
								Stk[A + 1] = B;
								Stk[A] = B[Inst[4]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								A = Inst[2];
								Stk[A] = Stk[A](Stk[A + 1]);
							else
								local A;
								Stk[Inst[2]] = Upvalues[Inst[3]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Inst[3];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Inst[3];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								A = Inst[2];
								Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Stk[Inst[3]][Stk[Inst[4]]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Upvalues[Inst[3]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Inst[3];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Inst[3];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								A = Inst[2];
								Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Stk[Inst[3]][Stk[Inst[4]]];
							end
						elseif (Enum <= 393) then
							if (Enum > 392) then
								local B;
								local A;
								Stk[Inst[2]] = Inst[3];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Inst[3];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								A = Inst[2];
								Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Stk[Inst[3]][Stk[Inst[4]]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Upvalues[Inst[3]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Stk[Inst[3]][Stk[Inst[4]]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								A = Inst[2];
								B = Stk[Inst[3]];
								Stk[A + 1] = B;
								Stk[A] = B[Inst[4]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								A = Inst[2];
								Stk[A] = Stk[A](Stk[A + 1]);
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]][Stk[Inst[3]]] = Inst[4];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Inst[3];
							else
								local A;
								Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Upvalues[Inst[3]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								A = Inst[2];
								Stk[A] = Stk[A](Stk[A + 1]);
								VIP = VIP + 1;
								Inst = Instr[VIP];
								if not Stk[Inst[2]] then
									VIP = VIP + 1;
								else
									VIP = Inst[3];
								end
							end
						elseif (Enum > 394) then
							local A;
							Stk[Inst[2]] = Upvalues[Inst[3]];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Upvalues[Inst[3]];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Inst[3];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Inst[3];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							A = Inst[2];
							Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Stk[Inst[3]][Stk[Inst[4]]];
						else
							local B;
							local A;
							Stk[Inst[2]] = Upvalues[Inst[3]];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Inst[3];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Inst[3];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							A = Inst[2];
							Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Stk[Inst[3]][Stk[Inst[4]]];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							A = Inst[2];
							B = Stk[Inst[3]];
							Stk[A + 1] = B;
							Stk[A] = B[Inst[4]];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							A = Inst[2];
							Stk[A] = Stk[A](Stk[A + 1]);
							VIP = VIP + 1;
							Inst = Instr[VIP];
							if Stk[Inst[2]] then
								VIP = VIP + 1;
							else
								VIP = Inst[3];
							end
						end
					elseif (Enum <= 402) then
						if (Enum <= 398) then
							if (Enum <= 396) then
								local B;
								local A;
								Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Upvalues[Inst[3]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Inst[3];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Stk[Inst[3]][Stk[Inst[4]]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								for Idx = Inst[2], Inst[3] do
									Stk[Idx] = nil;
								end
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Upvalues[Inst[3]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								A = Inst[2];
								B = Stk[Inst[3]];
								Stk[A + 1] = B;
								Stk[A] = B[Inst[4]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Upvalues[Inst[3]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Inst[3];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Stk[Inst[3]][Stk[Inst[4]]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								A = Inst[2];
								Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = not Stk[Inst[3]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								A = Inst[2];
								Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
								VIP = VIP + 1;
								Inst = Instr[VIP];
								if not Stk[Inst[2]] then
									VIP = VIP + 1;
								else
									VIP = Inst[3];
								end
							elseif (Enum > 397) then
								Env[Inst[3]] = Stk[Inst[2]];
							else
								local A;
								Stk[Inst[2]] = Upvalues[Inst[3]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Inst[3];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Inst[3];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								A = Inst[2];
								Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]][Stk[Inst[3]]] = Inst[4];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Upvalues[Inst[3]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Inst[3];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Inst[3];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								A = Inst[2];
								do
									return Stk[A](Unpack(Stk, A + 1, Inst[3]));
								end
								VIP = VIP + 1;
								Inst = Instr[VIP];
								A = Inst[2];
								do
									return Unpack(Stk, A, Top);
								end
							end
						elseif (Enum <= 400) then
							if (Enum > 399) then
								Stk[Inst[2]] = {};
							elseif (Stk[Inst[2]] < Stk[Inst[4]]) then
								VIP = VIP + 1;
							else
								VIP = Inst[3];
							end
						elseif (Enum > 401) then
							if (Stk[Inst[2]] > Stk[Inst[4]]) then
								VIP = VIP + 1;
							else
								VIP = VIP + Inst[3];
							end
						else
							local A;
							Stk[Inst[2]] = Upvalues[Inst[3]];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Inst[3];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Inst[3];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							A = Inst[2];
							Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Stk[Inst[3]][Stk[Inst[4]]];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Upvalues[Inst[3]];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Inst[3];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Inst[3];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							A = Inst[2];
							Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Stk[Inst[3]][Stk[Inst[4]]];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Upvalues[Inst[3]];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Inst[3];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Inst[3];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							A = Inst[2];
							Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Stk[Inst[3]][Stk[Inst[4]]];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Upvalues[Inst[3]];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Inst[3];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Inst[3];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							A = Inst[2];
							Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Upvalues[Inst[3]];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Upvalues[Inst[3]];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Upvalues[Inst[3]];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Inst[3];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Inst[3];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							A = Inst[2];
							Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Stk[Inst[3]][Stk[Inst[4]]];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Upvalues[Inst[3]];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Inst[3];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Inst[3];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							A = Inst[2];
							Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Stk[Inst[3]][Stk[Inst[4]]];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Upvalues[Inst[3]];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Inst[3];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Inst[3];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							A = Inst[2];
							Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Stk[Inst[3]][Stk[Inst[4]]];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Upvalues[Inst[3]];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Inst[3];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Inst[3];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							A = Inst[2];
							Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Stk[Inst[3]][Stk[Inst[4]]];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Inst[3];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							A = Inst[2];
							Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Upvalues[Inst[3]];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Upvalues[Inst[3]];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Upvalues[Inst[3]];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Inst[3];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Inst[3];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							A = Inst[2];
							Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Stk[Inst[3]][Stk[Inst[4]]];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Upvalues[Inst[3]];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Inst[3];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Inst[3];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							A = Inst[2];
							Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Stk[Inst[3]][Stk[Inst[4]]];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Upvalues[Inst[3]];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Inst[3];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Inst[3];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							A = Inst[2];
							Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Stk[Inst[3]][Stk[Inst[4]]];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Upvalues[Inst[3]];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Inst[3];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Inst[3];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							A = Inst[2];
							Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Stk[Inst[3]][Stk[Inst[4]]];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Inst[3];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							A = Inst[2];
							Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Stk[Inst[3]] + Stk[Inst[4]];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]][Stk[Inst[3]]] = Stk[Inst[4]];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							VIP = Inst[3];
						end
					elseif (Enum <= 405) then
						if (Enum <= 403) then
							local A;
							Stk[Inst[2]] = Inst[3];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Inst[3];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							A = Inst[2];
							Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Stk[Inst[3]][Stk[Inst[4]]];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Inst[3];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							if (Stk[Inst[2]] < Stk[Inst[4]]) then
								VIP = VIP + 1;
							else
								VIP = Inst[3];
							end
						elseif (Enum == 404) then
							local A;
							Stk[Inst[2]] = Upvalues[Inst[3]];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Inst[3];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Inst[3];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							A = Inst[2];
							Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Stk[Inst[3]][Stk[Inst[4]]];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Upvalues[Inst[3]];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Inst[3];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Inst[3];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							A = Inst[2];
							Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Stk[Inst[3]][Stk[Inst[4]]];
						else
							local A;
							Stk[Inst[2]] = Upvalues[Inst[3]];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Inst[3];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Inst[3];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							A = Inst[2];
							Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Inst[3];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]][Stk[Inst[3]]] = Stk[Inst[4]];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Upvalues[Inst[3]];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Inst[3];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Inst[3];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							A = Inst[2];
							do
								return Stk[A](Unpack(Stk, A + 1, Inst[3]));
							end
							VIP = VIP + 1;
							Inst = Instr[VIP];
							A = Inst[2];
							do
								return Unpack(Stk, A, Top);
							end
							VIP = VIP + 1;
							Inst = Instr[VIP];
							VIP = Inst[3];
						end
					elseif (Enum <= 407) then
						if (Enum == 406) then
							local B;
							local A;
							Stk[Inst[2]] = Upvalues[Inst[3]];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Inst[3];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Inst[3];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							A = Inst[2];
							Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Stk[Inst[3]][Stk[Inst[4]]];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							A = Inst[2];
							B = Stk[Inst[3]];
							Stk[A + 1] = B;
							Stk[A] = B[Inst[4]];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							A = Inst[2];
							Stk[A] = Stk[A](Stk[A + 1]);
							VIP = VIP + 1;
							Inst = Instr[VIP];
							if Stk[Inst[2]] then
								VIP = VIP + 1;
							else
								VIP = Inst[3];
							end
						else
							local B;
							local A;
							Stk[Inst[2]] = Upvalues[Inst[3]];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Inst[3];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Inst[3];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							A = Inst[2];
							Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Stk[Inst[3]][Stk[Inst[4]]];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Inst[3];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							A = Inst[2];
							B = Stk[Inst[3]];
							Stk[A + 1] = B;
							Stk[A] = B[Stk[Inst[4]]];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							A = Inst[2];
							Stk[A] = Stk[A](Stk[A + 1]);
							VIP = VIP + 1;
							Inst = Instr[VIP];
							if not Stk[Inst[2]] then
								VIP = VIP + 1;
							else
								VIP = Inst[3];
							end
						end
					elseif (Enum > 408) then
						local A;
						Stk[Inst[2]] = Upvalues[Inst[3]];
						VIP = VIP + 1;
						Inst = Instr[VIP];
						Stk[Inst[2]] = Inst[3];
						VIP = VIP + 1;
						Inst = Instr[VIP];
						Stk[Inst[2]] = Inst[3];
						VIP = VIP + 1;
						Inst = Instr[VIP];
						A = Inst[2];
						Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
						VIP = VIP + 1;
						Inst = Instr[VIP];
						Stk[Inst[2]] = Upvalues[Inst[3]];
						VIP = VIP + 1;
						Inst = Instr[VIP];
						Stk[Inst[2]] = Upvalues[Inst[3]];
						VIP = VIP + 1;
						Inst = Instr[VIP];
						Stk[Inst[2]] = Inst[3];
						VIP = VIP + 1;
						Inst = Instr[VIP];
						Stk[Inst[2]] = Inst[3];
						VIP = VIP + 1;
						Inst = Instr[VIP];
						A = Inst[2];
						Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
						VIP = VIP + 1;
						Inst = Instr[VIP];
						Stk[Inst[2]] = Stk[Inst[3]][Stk[Inst[4]]];
					else
						local A;
						Stk[Inst[2]] = Upvalues[Inst[3]];
						VIP = VIP + 1;
						Inst = Instr[VIP];
						Stk[Inst[2]] = Inst[3];
						VIP = VIP + 1;
						Inst = Instr[VIP];
						Stk[Inst[2]] = Inst[3];
						VIP = VIP + 1;
						Inst = Instr[VIP];
						A = Inst[2];
						Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
						VIP = VIP + 1;
						Inst = Instr[VIP];
						Stk[Inst[2]] = Stk[Inst[3]][Stk[Inst[4]]];
						VIP = VIP + 1;
						Inst = Instr[VIP];
						Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
						VIP = VIP + 1;
						Inst = Instr[VIP];
						if Stk[Inst[2]] then
							VIP = VIP + 1;
						else
							VIP = Inst[3];
						end
					end
				elseif (Enum <= 423) then
					if (Enum <= 416) then
						if (Enum <= 412) then
							if (Enum <= 410) then
								local B;
								local A;
								A = Inst[2];
								B = Stk[Inst[3]];
								Stk[A + 1] = B;
								Stk[A] = B[Inst[4]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Upvalues[Inst[3]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								A = Inst[2];
								Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
								VIP = VIP + 1;
								Inst = Instr[VIP];
								if not Stk[Inst[2]] then
									VIP = VIP + 1;
								else
									VIP = Inst[3];
								end
							elseif (Enum > 411) then
								if (Inst[2] > Stk[Inst[4]]) then
									VIP = VIP + 1;
								else
									VIP = Inst[3];
								end
							else
								local A;
								Stk[Inst[2]] = Upvalues[Inst[3]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Inst[3];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Inst[3];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								A = Inst[2];
								Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Inst[3];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]][Stk[Inst[3]]] = Stk[Inst[4]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Upvalues[Inst[3]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Inst[3];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Inst[3];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								A = Inst[2];
								do
									return Stk[A](Unpack(Stk, A + 1, Inst[3]));
								end
								VIP = VIP + 1;
								Inst = Instr[VIP];
								A = Inst[2];
								do
									return Unpack(Stk, A, Top);
								end
								VIP = VIP + 1;
								Inst = Instr[VIP];
								VIP = Inst[3];
							end
						elseif (Enum <= 414) then
							if (Enum > 413) then
								local B;
								local A;
								Stk[Inst[2]] = Upvalues[Inst[3]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								A = Inst[2];
								B = Stk[Inst[3]];
								Stk[A + 1] = B;
								Stk[A] = B[Inst[4]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Upvalues[Inst[3]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								A = Inst[2];
								Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
								VIP = VIP + 1;
								Inst = Instr[VIP];
								if not Stk[Inst[2]] then
									VIP = VIP + 1;
								else
									VIP = Inst[3];
								end
							else
								local B;
								local Edx;
								local Results, Limit;
								local A;
								Stk[Inst[2]] = Upvalues[Inst[3]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Inst[3];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Inst[3];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								A = Inst[2];
								Results, Limit = _R(Stk[A](Unpack(Stk, A + 1, Inst[3])));
								Top = (Limit + A) - 1;
								Edx = 0;
								for Idx = A, Top do
									Edx = Edx + 1;
									Stk[Idx] = Results[Edx];
								end
								VIP = VIP + 1;
								Inst = Instr[VIP];
								A = Inst[2];
								Stk[A] = Stk[A](Unpack(Stk, A + 1, Top));
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Inst[3];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								A = Inst[2];
								B = Stk[Inst[3]];
								Stk[A + 1] = B;
								Stk[A] = B[Stk[Inst[4]]];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								Stk[Inst[2]] = Inst[3];
								VIP = VIP + 1;
								Inst = Instr[VIP];
								A = Inst[2];
								Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
								VIP = VIP + 1;
								Inst = Instr[VIP];
								if Stk[Inst[2]] then
									VIP = VIP + 1;
								else
									VIP = Inst[3];
								end
							end
						elseif (Enum > 415) then
							local A;
							Stk[Inst[2]] = Upvalues[Inst[3]];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Inst[3];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Inst[3];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							A = Inst[2];
							Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Inst[3];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]][Stk[Inst[3]]] = Stk[Inst[4]];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Upvalues[Inst[3]];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Inst[3];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Inst[3];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							A = Inst[2];
							do
								return Stk[A](Unpack(Stk, A + 1, Inst[3]));
							end
							VIP = VIP + 1;
							Inst = Instr[VIP];
							A = Inst[2];
							do
								return Unpack(Stk, A, Top);
							end
							VIP = VIP + 1;
							Inst = Instr[VIP];
							VIP = Inst[3];
						else
							local A;
							Stk[Inst[2]] = Inst[3];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Inst[3];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							A = Inst[2];
							Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Stk[Inst[3]][Stk[Inst[4]]];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Upvalues[Inst[3]];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Inst[3];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Inst[3];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							A = Inst[2];
							Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Stk[Inst[3]][Stk[Inst[4]]];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Inst[3];
						end
					elseif (Enum <= 419) then
						if (Enum <= 417) then
							local B;
							local A;
							Stk[Inst[2]] = Upvalues[Inst[3]];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Inst[3];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Inst[3];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							A = Inst[2];
							Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Stk[Inst[3]][Stk[Inst[4]]];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							A = Inst[2];
							B = Stk[Inst[3]];
							Stk[A + 1] = B;
							Stk[A] = B[Inst[4]];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							A = Inst[2];
							Stk[A] = Stk[A](Stk[A + 1]);
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Inst[3];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							if (Stk[Inst[2]] < Stk[Inst[4]]) then
								VIP = Inst[3];
							else
								VIP = VIP + 1;
							end
						elseif (Enum == 418) then
							local A = Inst[2];
							Stk[A](Stk[A + 1]);
						else
							local A;
							Stk[Inst[2]] = Upvalues[Inst[3]];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Inst[3];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Inst[3];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							A = Inst[2];
							Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Stk[Inst[3]][Stk[Inst[4]]];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Upvalues[Inst[3]];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Inst[3];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Inst[3];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							A = Inst[2];
							Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Stk[Inst[3]][Stk[Inst[4]]];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Upvalues[Inst[3]];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Inst[3];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Inst[3];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							A = Inst[2];
							Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Stk[Inst[3]][Stk[Inst[4]]];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							if (Stk[Inst[2]] ~= Inst[4]) then
								VIP = VIP + 1;
							else
								VIP = Inst[3];
							end
						end
					elseif (Enum <= 421) then
						if (Enum > 420) then
							local A;
							Stk[Inst[2]] = Upvalues[Inst[3]];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Inst[3];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Inst[3];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							A = Inst[2];
							Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Upvalues[Inst[3]];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							A = Inst[2];
							Stk[A] = Stk[A]();
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]][Stk[Inst[3]]] = Stk[Inst[4]];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							if (Inst[2] <= Inst[4]) then
								VIP = VIP + 1;
							else
								VIP = Inst[3];
							end
						else
							local B;
							local A;
							Stk[Inst[2]] = Upvalues[Inst[3]];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Inst[3];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Inst[3];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							A = Inst[2];
							Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Stk[Inst[3]][Stk[Inst[4]]];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							A = Inst[2];
							B = Stk[Inst[3]];
							Stk[A + 1] = B;
							Stk[A] = B[Inst[4]];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							A = Inst[2];
							Stk[A] = Stk[A](Stk[A + 1]);
							VIP = VIP + 1;
							Inst = Instr[VIP];
							if Stk[Inst[2]] then
								VIP = VIP + 1;
							else
								VIP = Inst[3];
							end
						end
					elseif (Enum == 422) then
						local B;
						local A;
						A = Inst[2];
						B = Stk[Inst[3]];
						Stk[A + 1] = B;
						Stk[A] = B[Inst[4]];
						VIP = VIP + 1;
						Inst = Instr[VIP];
						Stk[Inst[2]] = Upvalues[Inst[3]];
						VIP = VIP + 1;
						Inst = Instr[VIP];
						Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
						VIP = VIP + 1;
						Inst = Instr[VIP];
						A = Inst[2];
						Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
						VIP = VIP + 1;
						Inst = Instr[VIP];
						Stk[Inst[2]] = Upvalues[Inst[3]];
						VIP = VIP + 1;
						Inst = Instr[VIP];
						A = Inst[2];
						B = Stk[Inst[3]];
						Stk[A + 1] = B;
						Stk[A] = B[Inst[4]];
						VIP = VIP + 1;
						Inst = Instr[VIP];
						A = Inst[2];
						Stk[A] = Stk[A](Stk[A + 1]);
						VIP = VIP + 1;
						Inst = Instr[VIP];
						if (Stk[Inst[2]] < Stk[Inst[4]]) then
							VIP = VIP + 1;
						else
							VIP = Inst[3];
						end
					else
						local A = Inst[2];
						do
							return Unpack(Stk, A, A + Inst[3]);
						end
					end
				elseif (Enum <= 430) then
					if (Enum <= 426) then
						if (Enum <= 424) then
							local A = Inst[2];
							Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
						elseif (Enum == 425) then
							local B;
							local A;
							Stk[Inst[2]] = Inst[3];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							A = Inst[2];
							B = Stk[Inst[3]];
							Stk[A + 1] = B;
							Stk[A] = B[Stk[Inst[4]]];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Inst[3];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							A = Inst[2];
							Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
							VIP = VIP + 1;
							Inst = Instr[VIP];
							if Stk[Inst[2]] then
								VIP = VIP + 1;
							else
								VIP = Inst[3];
							end
						else
							local B;
							local A;
							Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Inst[3];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Upvalues[Inst[3]];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Upvalues[Inst[3]];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Inst[3];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Inst[3];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							A = Inst[2];
							Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Stk[Inst[3]][Stk[Inst[4]]];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Inst[3];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							A = Inst[2];
							B = Stk[Inst[3]];
							Stk[A + 1] = B;
							Stk[A] = B[Stk[Inst[4]]];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							A = Inst[2];
							Stk[A] = Stk[A](Stk[A + 1]);
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Inst[3];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Stk[Inst[3]] * Stk[Inst[4]];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							A = Inst[2];
							Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
							VIP = VIP + 1;
							Inst = Instr[VIP];
							if not Stk[Inst[2]] then
								VIP = VIP + 1;
							else
								VIP = Inst[3];
							end
						end
					elseif (Enum <= 428) then
						if (Enum > 427) then
							local Edx;
							local Results, Limit;
							local A;
							Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Upvalues[Inst[3]];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Inst[3];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							A = Inst[2];
							Results, Limit = _R(Stk[A](Stk[A + 1]));
							Top = (Limit + A) - 1;
							Edx = 0;
							for Idx = A, Top do
								Edx = Edx + 1;
								Stk[Idx] = Results[Edx];
							end
							VIP = VIP + 1;
							Inst = Instr[VIP];
							A = Inst[2];
							Stk[A] = Stk[A](Unpack(Stk, A + 1, Top));
							VIP = VIP + 1;
							Inst = Instr[VIP];
							if Stk[Inst[2]] then
								VIP = VIP + 1;
							else
								VIP = Inst[3];
							end
						else
							local B;
							local A;
							A = Inst[2];
							B = Stk[Inst[3]];
							Stk[A + 1] = B;
							Stk[A] = B[Inst[4]];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Upvalues[Inst[3]];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
							VIP = VIP + 1;
							Inst = Instr[VIP];
							A = Inst[2];
							Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
							VIP = VIP + 1;
							Inst = Instr[VIP];
							if not Stk[Inst[2]] then
								VIP = VIP + 1;
							else
								VIP = Inst[3];
							end
						end
					elseif (Enum > 429) then
						local A;
						Stk[Inst[2]] = Upvalues[Inst[3]];
						VIP = VIP + 1;
						Inst = Instr[VIP];
						Stk[Inst[2]] = Inst[3];
						VIP = VIP + 1;
						Inst = Instr[VIP];
						Stk[Inst[2]] = Inst[3];
						VIP = VIP + 1;
						Inst = Instr[VIP];
						A = Inst[2];
						Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
						VIP = VIP + 1;
						Inst = Instr[VIP];
						Stk[Inst[2]] = Stk[Inst[3]][Stk[Inst[4]]];
						VIP = VIP + 1;
						Inst = Instr[VIP];
						Stk[Inst[2]] = Upvalues[Inst[3]];
						VIP = VIP + 1;
						Inst = Instr[VIP];
						Stk[Inst[2]] = Inst[3];
						VIP = VIP + 1;
						Inst = Instr[VIP];
						Stk[Inst[2]] = Inst[3];
						VIP = VIP + 1;
						Inst = Instr[VIP];
						A = Inst[2];
						Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
						VIP = VIP + 1;
						Inst = Instr[VIP];
						Stk[Inst[2]] = Stk[Inst[3]][Stk[Inst[4]]];
					else
						local A;
						Stk[Inst[2]] = Upvalues[Inst[3]];
						VIP = VIP + 1;
						Inst = Instr[VIP];
						Stk[Inst[2]] = Inst[3];
						VIP = VIP + 1;
						Inst = Instr[VIP];
						Stk[Inst[2]] = Inst[3];
						VIP = VIP + 1;
						Inst = Instr[VIP];
						A = Inst[2];
						Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
						VIP = VIP + 1;
						Inst = Instr[VIP];
						Stk[Inst[2]] = Stk[Inst[3]][Stk[Inst[4]]];
						VIP = VIP + 1;
						Inst = Instr[VIP];
						Stk[Inst[2]] = Upvalues[Inst[3]];
						VIP = VIP + 1;
						Inst = Instr[VIP];
						Stk[Inst[2]] = Inst[3];
						VIP = VIP + 1;
						Inst = Instr[VIP];
						Stk[Inst[2]] = Inst[3];
						VIP = VIP + 1;
						Inst = Instr[VIP];
						A = Inst[2];
						Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
						VIP = VIP + 1;
						Inst = Instr[VIP];
						Stk[Inst[2]] = Stk[Inst[3]][Stk[Inst[4]]];
					end
				elseif (Enum <= 433) then
					if (Enum <= 431) then
						Stk[Inst[2]] = #Stk[Inst[3]];
					elseif (Enum > 432) then
						local A;
						Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
						VIP = VIP + 1;
						Inst = Instr[VIP];
						Stk[Inst[2]] = Upvalues[Inst[3]];
						VIP = VIP + 1;
						Inst = Instr[VIP];
						Stk[Inst[2]] = Upvalues[Inst[3]];
						VIP = VIP + 1;
						Inst = Instr[VIP];
						Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
						VIP = VIP + 1;
						Inst = Instr[VIP];
						Stk[Inst[2]] = Upvalues[Inst[3]];
						VIP = VIP + 1;
						Inst = Instr[VIP];
						Stk[Inst[2]] = Upvalues[Inst[3]];
						VIP = VIP + 1;
						Inst = Instr[VIP];
						Stk[Inst[2]] = Inst[3];
						VIP = VIP + 1;
						Inst = Instr[VIP];
						Stk[Inst[2]] = Inst[3];
						VIP = VIP + 1;
						Inst = Instr[VIP];
						A = Inst[2];
						Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
						VIP = VIP + 1;
						Inst = Instr[VIP];
						Upvalues[Inst[3]] = Stk[Inst[2]];
					else
						local B;
						local A;
						Stk[Inst[2]] = Upvalues[Inst[3]];
						VIP = VIP + 1;
						Inst = Instr[VIP];
						A = Inst[2];
						B = Stk[Inst[3]];
						Stk[A + 1] = B;
						Stk[A] = B[Inst[4]];
						VIP = VIP + 1;
						Inst = Instr[VIP];
						A = Inst[2];
						Stk[A] = Stk[A](Stk[A + 1]);
						VIP = VIP + 1;
						Inst = Instr[VIP];
						Upvalues[Inst[3]] = Stk[Inst[2]];
						VIP = VIP + 1;
						Inst = Instr[VIP];
						Stk[Inst[2]] = Upvalues[Inst[3]];
						VIP = VIP + 1;
						Inst = Instr[VIP];
						Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
						VIP = VIP + 1;
						Inst = Instr[VIP];
						Stk[Inst[2]] = Upvalues[Inst[3]];
						VIP = VIP + 1;
						Inst = Instr[VIP];
						A = Inst[2];
						Stk[A] = Stk[A](Stk[A + 1]);
						VIP = VIP + 1;
						Inst = Instr[VIP];
						Upvalues[Inst[3]] = Stk[Inst[2]];
						VIP = VIP + 1;
						Inst = Instr[VIP];
						Stk[Inst[2]] = Upvalues[Inst[3]];
					end
				elseif (Enum <= 435) then
					if (Enum == 434) then
						local A;
						Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
						VIP = VIP + 1;
						Inst = Instr[VIP];
						Stk[Inst[2]] = Upvalues[Inst[3]];
						VIP = VIP + 1;
						Inst = Instr[VIP];
						Stk[Inst[2]] = Inst[3];
						VIP = VIP + 1;
						Inst = Instr[VIP];
						Stk[Inst[2]] = Stk[Inst[3]][Stk[Inst[4]]];
						VIP = VIP + 1;
						Inst = Instr[VIP];
						A = Inst[2];
						Stk[A] = Stk[A](Stk[A + 1]);
						VIP = VIP + 1;
						Inst = Instr[VIP];
						if Stk[Inst[2]] then
							VIP = VIP + 1;
						else
							VIP = Inst[3];
						end
					else
						local A;
						Stk[Inst[2]] = Inst[3];
						VIP = VIP + 1;
						Inst = Instr[VIP];
						Stk[Inst[2]] = Inst[3];
						VIP = VIP + 1;
						Inst = Instr[VIP];
						A = Inst[2];
						Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
						VIP = VIP + 1;
						Inst = Instr[VIP];
						Stk[Inst[2]] = Stk[Inst[3]][Stk[Inst[4]]];
						VIP = VIP + 1;
						Inst = Instr[VIP];
						if (Inst[2] <= Stk[Inst[4]]) then
							VIP = VIP + 1;
						else
							VIP = Inst[3];
						end
					end
				elseif (Enum > 436) then
					local A;
					Stk[Inst[2]] = Upvalues[Inst[3]];
					VIP = VIP + 1;
					Inst = Instr[VIP];
					Stk[Inst[2]] = Inst[3];
					VIP = VIP + 1;
					Inst = Instr[VIP];
					Stk[Inst[2]] = Inst[3];
					VIP = VIP + 1;
					Inst = Instr[VIP];
					A = Inst[2];
					Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
					VIP = VIP + 1;
					Inst = Instr[VIP];
					Stk[Inst[2]] = Stk[Inst[3]][Stk[Inst[4]]];
					VIP = VIP + 1;
					Inst = Instr[VIP];
					Stk[Inst[2]] = Inst[3];
					VIP = VIP + 1;
					Inst = Instr[VIP];
					Stk[Inst[2]] = Env[Inst[3]];
					VIP = VIP + 1;
					Inst = Instr[VIP];
					Stk[Inst[2]] = Upvalues[Inst[3]];
					VIP = VIP + 1;
					Inst = Instr[VIP];
					Stk[Inst[2]] = Inst[3];
					VIP = VIP + 1;
					Inst = Instr[VIP];
					Stk[Inst[2]] = Inst[3];
					VIP = VIP + 1;
					Inst = Instr[VIP];
					A = Inst[2];
					Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
					VIP = VIP + 1;
					Inst = Instr[VIP];
					Stk[Inst[2]] = Stk[Inst[3]][Stk[Inst[4]]];
					VIP = VIP + 1;
					Inst = Instr[VIP];
					Stk[Inst[2]] = Inst[3];
					VIP = VIP + 1;
					Inst = Instr[VIP];
					Stk[Inst[2]] = Stk[Inst[3]][Stk[Inst[4]]];
					VIP = VIP + 1;
					Inst = Instr[VIP];
					Stk[Inst[2]] = not Stk[Inst[3]];
					VIP = VIP + 1;
					Inst = Instr[VIP];
					Stk[Inst[2]][Stk[Inst[3]]] = Stk[Inst[4]];
					VIP = VIP + 1;
					Inst = Instr[VIP];
					Stk[Inst[2]] = Upvalues[Inst[3]];
					VIP = VIP + 1;
					Inst = Instr[VIP];
					Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
					VIP = VIP + 1;
					Inst = Instr[VIP];
					Stk[Inst[2]] = Upvalues[Inst[3]];
					VIP = VIP + 1;
					Inst = Instr[VIP];
					Stk[Inst[2]] = Inst[3];
					VIP = VIP + 1;
					Inst = Instr[VIP];
					Stk[Inst[2]] = Inst[3];
					VIP = VIP + 1;
					Inst = Instr[VIP];
					A = Inst[2];
					Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
					VIP = VIP + 1;
					Inst = Instr[VIP];
					Stk[Inst[2]] = Env[Inst[3]];
					VIP = VIP + 1;
					Inst = Instr[VIP];
					Stk[Inst[2]] = Upvalues[Inst[3]];
					VIP = VIP + 1;
					Inst = Instr[VIP];
					Stk[Inst[2]] = Inst[3];
					VIP = VIP + 1;
					Inst = Instr[VIP];
					Stk[Inst[2]] = Inst[3];
					VIP = VIP + 1;
					Inst = Instr[VIP];
					A = Inst[2];
					Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
					VIP = VIP + 1;
					Inst = Instr[VIP];
					Stk[Inst[2]] = Stk[Inst[3]][Stk[Inst[4]]];
					VIP = VIP + 1;
					Inst = Instr[VIP];
					Stk[Inst[2]] = Inst[3];
					VIP = VIP + 1;
					Inst = Instr[VIP];
					Stk[Inst[2]] = Stk[Inst[3]][Stk[Inst[4]]];
					VIP = VIP + 1;
					Inst = Instr[VIP];
					if Stk[Inst[2]] then
						VIP = VIP + 1;
					else
						VIP = Inst[3];
					end
				else
					local B;
					local A;
					A = Inst[2];
					B = Stk[Inst[3]];
					Stk[A + 1] = B;
					Stk[A] = B[Inst[4]];
					VIP = VIP + 1;
					Inst = Instr[VIP];
					Stk[Inst[2]] = Inst[3];
					VIP = VIP + 1;
					Inst = Instr[VIP];
					Stk[Inst[2]] = Inst[3];
					VIP = VIP + 1;
					Inst = Instr[VIP];
					A = Inst[2];
					Stk[A] = Stk[A](Unpack(Stk, A + 1, Inst[3]));
					VIP = VIP + 1;
					Inst = Instr[VIP];
					if Stk[Inst[2]] then
						VIP = VIP + 1;
					else
						VIP = Inst[3];
					end
				end
				VIP = VIP + 1;
			end
		end;
	end
	return Wrap(Deserialize(), {}, vmenv)(...);
end
return VMCall("LOL!113Q0003063Q00737472696E6703043Q006368617203043Q00627974652Q033Q0073756203053Q0062697433322Q033Q0062697403043Q0062786F7203053Q007461626C6503063Q00636F6E63617403063Q00696E736572742Q033Q00626F7203043Q0062616E6403073Q0072657175697265031D3Q00F9C6C92AD4B4D31FC5CAD42BD989C819C4C6E40AF3AFCB1FC68DD730E703083Q007EB1A3BB4586DBA7031D3Q00A9814AAD6C8E9059B6578E8A67905186915D9D71949054A349CF884DA303053Q003EE1E438C200313Q0012B93Q00013Q0020825Q00020012B9000100013Q0020820001000100030012B9000200013Q0020820002000200040012B9000300053Q00067C0003000A00010001000426012Q000A00010012B9000300063Q0020820004000300070012B9000500083Q0020820005000500090012B9000600083Q00208200060006000A00066501073Q000100062Q0013012Q00064Q0013017Q0013012Q00044Q0013012Q00014Q0013012Q00024Q0013012Q00053Q00208200080003000B00208200090003000C2Q00DC000A000B4Q0090010B5Q0012B9000C000D3Q000665010D0001000100032Q0013012Q000A4Q0013012Q000B4Q0013012Q000C4Q0013010E00073Q00126C000F000E3Q00126C0010000F4Q00A8010E00100002000665010F0002000100032Q0013012Q00074Q0013012Q00094Q0013012Q00084Q0026000B000E000F2Q0013010E00073Q00126C000F00103Q00126C001000114Q00A8010E001000022Q0004000E000B000E2Q004E010F6Q00C0000E6Q00B5000E6Q0045012Q00013Q00033Q00023Q00026Q00F03F026Q00704002264Q009001025Q00126C000300014Q00AF01045Q00126C000500013Q00046D0003002100012Q007B00076Q0055010800026Q000900016Q000A00026Q000B00036Q000C00046Q000D8Q000E00063Q00202Q000F000600014Q000C000F6Q000B3Q00022Q007B000C00034Q007B000D00044Q0013010E00014Q00AF010F00014Q0020000F0006000F00105D010F0001000F2Q00AF011000014Q002000100006001000105D0110000100100020900010001000012Q007A010D00104Q0091000C6Q009C000A3Q0002002076010A000A00022Q002D0009000A4Q00F700073Q000100044C0103000500012Q007B000300054Q0013010400024Q0093000300044Q00B500036Q0045012Q00017Q00093Q00028Q00025Q0088A640025Q002QB240025Q00649240025Q0020AA40025Q0081B140026Q00F03F025Q00CC9B40025Q00088B4001253Q00126C000200014Q003A000300033Q00126C000400013Q0026C50004000900010001000426012Q00090001002ED20003000900010002000426012Q00090001002E5D0005000300010004000426012Q00030001002E040106000900010006000426012Q00120001000ED30007001200010002000426012Q001200012Q0013010500034Q007B00066Q004E01076Q00C000056Q00B500055Q0026C50002001600010001000426012Q00160001002E5D0008000200010009000426012Q000200012Q007B000500014Q0004000300053Q00067C0003002000010001000426012Q002000012Q007B000500024Q001301066Q007B00076Q004E01086Q00C000056Q00B500055Q00126C000200073Q000426012Q00020001000426012Q00030001000426012Q000200012Q0045012Q00017Q00DE3Q0003073Q004865726F4442432Q033Q0007EF0903053Q009C43AD4AA503073Q004865726F4C696203093Q004865726F436163686503043Q0001B9400203073Q002654D72976DC4603063Q00601A230BFB4203053Q009E3076427203063Q009F25023176B103073Q009BCB44705613C503053Q0075CD33F04C03083Q009826BD569C201885030A3Q00D142AB52F564B743F05B03043Q00269C37C703043Q008169792503083Q0023C81D1C4873149A030C3Q004865726F526F746174696F6E03053Q0038B0F4F0A303073Q005479DFB1BFED4C03053Q009872DA8F1403083Q00A1DB36A9C05A305003123Q004865726F526F746174696F6E43686172444203073Q007D4D072245471303043Q0045292260026Q00104003073Q0088CCD00D0E2EAF03063Q004BDCA3B76A62026Q00144003073Q0036B58C30D507A903053Q00B962DAEB57026Q00284003073Q00FF3320E1D2AFD803063Q00CAAB5C4786BE026Q002E4003073Q001DCE2B8F25C43F03043Q00E849A14C026Q00354003073Q008FD6455A12BECA03053Q007EDBB9223D026Q004A4003073Q0038C159752Q72E003083Q00876CAE3E121E1793026Q00364003073Q0082E62DCC14AB2003083Q00A7D6894AAB78CE53026Q00374003073Q00BFFF355AF4A29803063Q00C7EB90523D98026Q00384003073Q003319BE2C0B13AA03043Q004B6776D9026Q00394003073Q00F35B7713B51BD403063Q007EA7341074D9026Q003B4003073Q00FC212787B81CEF03073Q009CA84E40E0D479026Q00494003073Q0033E1A2C90BEBB603043Q00AE678EC5025Q0080494003073Q006227583F295BEB03073Q009836483F58453E025Q00804A4003073Q00E0CBE95BD8C1FD03043Q003CB4A48E026Q003E4003073Q006C51022E2BE80103073Q0072383E6549478D026Q004B4003073Q008CE6DCC3B4ECC803043Q00A4D889BB025Q00C0674003073Q00E6E936B5AAFB1803073Q006BB28651D2C69E026Q00204003093Q00150197D5AF171887D403053Q00CA586EE2A6028Q00030C3Q0047657445717569706D656E7403123Q00476574496E76656E746F72794974656D494403063Q00D30383EECFD103053Q00AAA36FE297026Q002A4003063Q00013CB3214B2503073Q00497150D2582E57026Q002C40025Q00C0A240025Q00549040025Q00E07040025Q005EA740025Q00D21341024Q00F0DE0B41024Q0010CF0541024Q00AC561441024Q00406F1441024Q00DC711441024Q0004D21341024Q00C8EC1341024Q00186A1441024Q00FC921341024Q0030881341024Q00D4C71341024Q00E4561441024Q00D83B1441024Q008C0A1541024Q00747D1641024Q00307C1641024Q00C4AB1541024Q0094BC1541024Q00ECE11441024Q00A8961541024Q0018B71541024Q00CCF71341024Q000854034103043Q006D6174682Q033Q008C25C303053Q0087E14CAD722Q033Q0017ECA003073Q00C77A8DD8D0CCDD2Q033Q00ACDF2Q03063Q0096CDBD70901803073Q00068BB2410B860203083Q007045E4DF2C64E87103083Q00F10902C1AF7388D103073Q00E6B47F67B3D61C03073Q00AF0A524BEB4FF303073Q0080EC653F26842103053Q009EA61651B303073Q00AFCCC97124D68B03073Q0060C93BD91646C003053Q006427AC55BC030B3Q008A4D90B336B96CB08E34BE03053Q0053CD18D9E003073Q00C1C0C338F4C4C103043Q005D86A5AD03073Q009DFDCCCF35C0A103083Q001EDE92A1A25AAED2030B3Q00C27B5939E05A6403EB496303043Q006A852E102Q033Q0079105F03063Q00203840139C3A03053Q0068C7E2435F03073Q00E03AA885363A9203073Q007A5946F07A889403083Q006B39362B9D15E6E703083Q00F8841CF8B6D2DC8903073Q00AFBBEB7195D9BC030B3Q001B9AA87FE66D6C35A1865F03073Q00185CCFE12C83192Q033Q006AE39403063Q001D2BB3D82C7B03053Q008FD62759B803043Q002CDDB94003083Q0022E845527C0FF41A03053Q00136187283F03093Q008D533E36203FBD780003063Q0051CE3C535B4F030B3Q00699EF9412AD759AD40ACC303083Q00C42ECBB0124FA32D2Q033Q0099125203073Q008FD8421E7E449B03053Q0098C70ADEC003083Q0081CAA86DABA5C3B703093Q0001573AD5D11AF5066B03073Q0086423857B8BE7403063Q0013241DB718FC03083Q00555C5169DB798B41030B3Q00DA86797679CBE9BA5E426F03063Q00BF9DD330251C2Q033Q00FE2FD803053Q005ABF7F947C03053Q004A8829027D03043Q007718E74E03063Q00AD38B146DD5703073Q0071E24DC52ABC2003053Q000819F3A03F03043Q00D55A769403063Q00743BA05A2Q4C03053Q002D3B4ED43603053Q002259849E8303083Q00907036E3EBE64ECD03063Q009C3D1BF0D14C03063Q003BD3486F9CB0030F3Q006386ED244DA0F1244B81F7225C84EB03043Q004D2EE78303023Q00494403173Q009E46B747B55AB049A851944FB7569249A944B34EA951A403043Q0020DA34D603113Q006C1230ABFEBE71557A1F348AF4A94A544A03083Q003A2E7751C891D02503103Q005265676973746572466F724576656E7403183Q001BA011958C8F090EBD058599901305B80F8F819C180CA91403073Q00564BEC50CCC9DD026Q00184003053Q00504D7E8BFA03063Q00EB122117E59E03163Q0073BBD2AF1098CDB25EBE81F379B4D5BE42A8D4AB44F303043Q00DB30DAA103103Q00D674685CC941D3EC7E6945DF4CE1F76503073Q008084111C29BB2F030B3Q0052657475726E5370652Q6C03123Q003337122F4F0F1F2Q09550E270A3E5E00211203053Q003D6152665A030D3Q0052657475726E5370652Q6C4D4F03093Q008E3CA44AC344170DA903083Q0069CC4ECB2BA7377E030E3Q0087BF31171600F343A0AB300B2Q0103083Q0031C5CA437E7364A7030A3Q001049DE27847B5B3B5EDA03073Q003E573BBF49E03603113Q00D517EEC1EB07E9DAD710FFCAEE11F3C6E903043Q00A987629A03123Q00F87C3158F132C6CF54365BEE20CAC479214703073Q00A8AB1744349D53030B3Q00C063E0A8072886E678FBAA03073Q00E7941195CD454D03113Q00476574456E656D696573496E52616E6765030E3Q0053696E6973746572537472696B6503063Q0053657441504C025Q004070400031033Q00DC000100033Q0012B9000300014Q006A01045Q00122Q000500023Q00122Q000600036Q0004000600024Q0003000300040012B9000400043Q0012B9000500054Q008000065Q00122Q000700063Q00122Q000800076Q0006000800024Q0006000400064Q00075Q00122Q000800083Q00122Q000900096Q0007000900024Q0007000600072Q008000085Q00122Q0009000A3Q00122Q000A000B6Q0008000A00024Q0008000600084Q00095Q00122Q000A000C3Q00122Q000B000D6Q0009000B00024Q0009000400092Q0080000A5Q00122Q000B000E3Q00122Q000C000F6Q000A000C00024Q000A0004000A4Q000B5Q00122Q000C00103Q00122Q000D00116Q000B000D00024Q000B0004000B0012B9000C00124Q0080000D5Q00122Q000E00133Q00122Q000F00146Q000D000F00024Q000D000C000D4Q000E5Q00122Q000F00153Q00122Q001000166Q000E001000024Q000E000C000E0012B9000F00174Q006A01105Q00122Q001100183Q00122Q001200196Q0010001200024Q000F000F0010002082000F000F001A0012B9001000174Q006A01115Q00122Q0012001B3Q00122Q0013001C6Q0011001300024Q00100010001100208200100010001D0012B9001100174Q006A01125Q00122Q0013001E3Q00122Q0014001F6Q0012001400024Q0011001100120020820011001100200012B9001200174Q006A01135Q00122Q001400213Q00122Q001500226Q0013001500024Q0012001200130020820012001200232Q00E1001200123Q0012B9001300174Q007B00145Q00122F001500243Q00122Q001600256Q0014001600024Q00130013001400202Q00130013002600122Q001400176Q00155Q00122Q001600273Q00122Q001700286Q0015001700024Q00140014001500202Q00140014002900122Q001500176Q00165Q00122Q0017002A3Q00122Q0018002B6Q0016001800024Q00150015001600202Q00150015002C00122Q001600176Q00175Q00122Q0018002D3Q00122Q0019002E6Q0017001900024Q00160016001700202Q00160016002F00122Q001700176Q00185Q00122Q001900303Q00122Q001A00316Q0018001A00024Q00170017001800202Q00170017003200122Q001800176Q00195Q00122Q001A00333Q00122Q001B00346Q0019001B00024Q00180018001900202Q00180018003500122Q001900176Q001A5Q00122Q001B00363Q00122Q001C00376Q001A001C00024Q00190019001A00202Q00190019003800122Q001A00176Q001B5Q00122Q001C00393Q00122Q001D003A6Q001B001D00024Q001A001A001B00202Q001A001A003B00122Q001B00176Q001C5Q00122Q001D003C3Q00122Q001E003D6Q001C001E00024Q001B001B001C00202Q001B001B003E00122Q001C00176Q001D5Q00122Q001E003F3Q00122Q001F00406Q001D001F00024Q001C001C001D00202Q001C001C004100122Q001D00176Q001E5Q00122Q001F00423Q00122Q002000436Q001E002000024Q001D001D001E00202Q001D001D004400122Q001E00176Q001F5Q00122Q002000453Q00122Q002100466Q001F002100022Q00A1001E001E001F00202Q001E001E004700122Q001F00176Q00205Q00122Q002100483Q00122Q002200496Q0020002200024Q001F001F002000202Q001F001F004A00122Q002000174Q006A01215Q00122Q0022004B3Q00122Q0023004C6Q0021002300024Q00200020002100208200200020004D2Q006A01215Q00122Q0022004E3Q00122Q0023004F6Q0021002300024Q00210006002100126C002200503Q0020AC0023000700512Q00720023000200022Q00130124000B3Q00126C002500504Q00720024000200022Q00130125000B3Q00126C002600504Q00720025000200020012B9002600524Q007B00275Q00126C002800533Q0012EE002900546Q00270029000200122Q002800556Q00260028000200122Q002700526Q00285Q00122Q002900563Q00122Q002A00576Q0028002A000200122Q002900584Q00A8012700290002002E71005A00D600010059000426012Q00D60001002082002800230055000657012800D600013Q000426012Q00D600012Q00130128000B3Q0020820029002300552Q00720028000200022Q0013012400283Q002E71005B00DF0001005C000426012Q00DF0001002082002800230058000657012800DF00013Q000426012Q00DF00012Q00130128000B3Q0020820029002300582Q00720028000200022Q0013012500284Q0090012800143Q0012110129005D3Q00122Q002A005E3Q00122Q002B005F3Q00122Q002C00603Q00122Q002D00613Q00122Q002E00623Q00122Q002F00633Q00122Q003000643Q00122Q003100653Q00122Q003200663Q00122Q003300673Q00122Q003400683Q00122Q003500693Q00122Q0036006A3Q00122Q0037006B3Q00122Q0038006C3Q00122Q0039006D3Q00122Q003A006E3Q00122Q003B006F3Q00122Q003C00703Q00122Q003D00713Q00122Q003E00723Q00122Q003F00733Q00122Q004000746Q0028001800010012B9002900754Q0042012A5Q00122Q002B00763Q00122Q002C00776Q002A002C00024Q00290029002A00122Q002A00756Q002B5Q00122Q002C00783Q00122Q002D00796Q002B002D00022Q0004002A002A002B001233002B00756Q002C5Q00122Q002D007A3Q00122Q002E007B6Q002C002E00024Q002B002B002C4Q002C00316Q00325Q00122Q0033007C3Q00122Q0034007D4Q00830132003400024Q0032000C00324Q00335Q00122Q0034007E3Q00122Q0035007F6Q0033003500024Q0032003200334Q00335Q00122Q003400803Q00122Q003500814Q00A80133003500022Q00040033000C00332Q003D01345Q00122Q003500823Q00122Q003600836Q0034003600024Q0033003300344Q00343Q00054Q00355Q00122Q003600843Q00122Q003700856Q0035003700022Q008000365Q00122Q003700863Q00122Q003800876Q0036003800024Q0036000C00364Q00375Q00122Q003800883Q00122Q003900896Q0037003900024Q0036003600372Q00260034003500362Q007B00355Q0012020136008A3Q00122Q0037008B6Q0035003700024Q00365Q00122Q0037008C3Q00122Q0038008D6Q0036003800024Q0036000C00364Q00375Q00122Q0038008E3Q0012850139008F6Q0037003900024Q0036003600374Q00375Q00122Q003800903Q00122Q003900916Q0037003900024Q0036003600374Q00375Q00122Q003800923Q00126C003900934Q00A80137003900022Q00040036003600372Q00260034003500362Q007B00355Q001202013600943Q00122Q003700956Q0035003700024Q00365Q00122Q003700963Q00122Q003800976Q0036003800024Q0036000C00364Q00375Q00122Q003800983Q001285013900996Q0037003900024Q0036003600374Q00375Q00122Q0038009A3Q00122Q0039009B6Q0037003900024Q0036003600374Q00375Q00122Q0038009C3Q00126C0039009D4Q00A80137003900022Q00040036003600372Q00260034003500362Q007B00355Q0012020136009E3Q00122Q0037009F6Q0035003700024Q00365Q00122Q003700A03Q00122Q003800A16Q0036003800024Q0036000C00364Q00375Q00122Q003800A23Q001285013900A36Q0037003900024Q0036003600374Q00375Q00122Q003800A43Q00122Q003900A56Q0037003900024Q0036003600374Q00375Q00122Q003800A63Q00126C003900A74Q00A80137003900022Q00040036003600372Q00260034003500362Q007B00355Q001202013600A83Q00122Q003700A96Q0035003700024Q00365Q00122Q003700AA3Q00122Q003800AB6Q0036003800024Q0036000C00364Q00375Q00122Q003800AC3Q001285013900AD6Q0037003900024Q0036003600374Q00375Q00122Q003800AE3Q00122Q003900AF6Q0037003900024Q0036003600374Q00375Q00122Q003800B03Q00126C003900B14Q00A80137003900022Q00040036003600372Q00260034003500362Q008000355Q00122Q003600B23Q00122Q003700B36Q0035003700024Q0035000900354Q00365Q00122Q003700B43Q00122Q003800B56Q0036003800024Q0035003500362Q008000365Q00122Q003700B63Q00122Q003800B76Q0036003800024Q0036000B00364Q00375Q00122Q003800B83Q00122Q003900B96Q0037003900024Q0036003600372Q0090013700024Q008701385Q00122Q003900BA3Q00122Q003A00BB6Q0038003A00024Q00380036003800202Q0038003800BC4Q0038000200022Q008701395Q00122Q003A00BD3Q00122Q003B00BE6Q0039003B00024Q00390036003900202Q0039003900BC4Q0039000200022Q006A013A5Q00122Q003B00BF3Q00122Q003C00C06Q003A003C00024Q003A0036003A0020AC003A003A00BC2Q002D003A003B4Q002100373Q00010020AC0038000700512Q0072003800020002002082003900380055000657013900C92Q013Q000426012Q00C92Q012Q00130139000B3Q002082003A003800552Q007200390002000200067C003900CC2Q010001000426012Q00CC2Q012Q00130139000B3Q00126C003A00504Q0072003900020002002082003A00380058000657013A00D42Q013Q000426012Q00D42Q012Q0013013A000B3Q002082003B003800582Q0072003A0002000200067C003A00D72Q010001000426012Q00D72Q012Q0013013A000B3Q00126C003B00504Q0072003A000200020020AC003B000400C1000665013D3Q000100052Q0013012Q00384Q0013012Q00074Q0013012Q00394Q0013012Q000B4Q0013012Q003A4Q0064003E5Q00122Q003F00C23Q00122Q004000C36Q003E00406Q003B3Q00014Q003B003E3Q00122Q003F00C46Q004000476Q004800016Q004900034Q006A014A5Q00122Q004B00C53Q00122Q004C00C66Q004A004C00024Q004A0035004A2Q007B004B5Q00126C004C00C73Q00126C004D00C84Q00A8014B004D00020002B1004C00014Q007D0049000300012Q007D0048000100012Q007B00495Q00126C004A00C93Q00126C004B00CA4Q00A80149004B0002002082004A003300CB2Q0033014A000100022Q0026000C0049004A2Q007B00495Q00126C004A00CC3Q00126C004B00CD4Q00A80149004B0002002082004A003300CE2Q0033014A000100022Q0026000C0049004A0002B1004900023Q000665014A0003000100022Q0013012Q00074Q0013012Q00353Q00126C004B00503Q00126C004C00503Q000665014D0004000100022Q0013012Q004B4Q0013012Q00073Q000665014E0005000100022Q0013012Q004C4Q0013012Q00074Q0090014F00064Q008000505Q00122Q005100CF3Q00122Q005200D06Q0050005200024Q0050003500504Q00515Q00122Q005200D13Q00122Q005300D26Q0051005300024Q0051003500512Q008000525Q00122Q005300D33Q00122Q005400D46Q0052005400024Q0052003500524Q00535Q00122Q005400D53Q00122Q005500D66Q0053005500024Q0053003500532Q008000545Q00122Q005500D73Q00122Q005600D86Q0054005600024Q0054003500544Q00555Q00122Q005600D93Q00122Q005700DA6Q0055005700024Q0055003500552Q007D004F000600012Q007700505Q00066501510006000100082Q0013012Q00054Q007B8Q0013012Q00334Q0013012Q004F4Q0013012Q00074Q007B3Q00014Q007B3Q00024Q0013012Q00503Q00066501520007000100022Q0013012Q00054Q007B7Q000665015300080001000D2Q0013012Q00054Q007B8Q0013012Q00344Q0013012Q00514Q0013012Q00074Q0013012Q00354Q0013012Q00494Q0013012Q00524Q0013012Q003D4Q0013012Q00084Q0013012Q00044Q007B3Q00014Q007B3Q00023Q00066501540009000100062Q0013012Q00404Q0013012Q00334Q0013012Q00494Q0013012Q00074Q0013012Q00354Q007B7Q0006650155000A000100082Q0013012Q00354Q007B8Q0013012Q00424Q007B3Q00014Q0013012Q00494Q0013012Q00074Q007B3Q00024Q0013012Q00433Q0006650156000B000100052Q0013012Q00344Q007B8Q0013012Q00324Q0013012Q00074Q0013012Q00083Q0006650157000C000100052Q0013012Q00354Q007B8Q007B3Q00014Q0013012Q00494Q007B3Q00023Q0006650158000D000100032Q0013012Q00074Q0013012Q00354Q007B7Q0006650159000E0001000D2Q0013012Q00354Q007B8Q0013012Q00584Q0013012Q00544Q0013012Q00314Q0013012Q00074Q0013012Q000C4Q0013012Q00344Q0013012Q00134Q0013012Q002F4Q0013012Q00564Q0013012Q00574Q0013012Q00553Q000665015A000F000100202Q0013012Q002E4Q0013012Q00354Q007B8Q0013012Q00074Q0013012Q00544Q0013012Q00414Q0013012Q000C4Q0013012Q003D4Q0013012Q00494Q0013012Q00424Q007B3Q00014Q007B3Q00024Q0013012Q00534Q0013012Q00514Q0013012Q00054Q0013012Q00404Q0013012Q00084Q0013012Q000E4Q0013012Q00044Q0013012Q00344Q0013012Q00364Q0013012Q00264Q0013012Q00274Q0013012Q003E4Q0013012Q00594Q0013012Q00454Q0013012Q00464Q0013012Q00324Q0013012Q00124Q0013012Q00374Q0013012Q00394Q0013012Q003A3Q000665015B00100001000E2Q0013012Q00354Q007B8Q0013012Q00074Q0013012Q000C4Q0013012Q00084Q0013012Q00544Q0013012Q003D4Q0013012Q00424Q007B3Q00014Q0013012Q00494Q007B3Q00024Q0013012Q000D4Q0013012Q00344Q0013012Q00413Q000665015C00110001000A2Q0013012Q00354Q007B8Q0013012Q00084Q0013012Q00074Q0013012Q000C4Q0013012Q00044Q0013012Q003C4Q007B3Q00014Q0013012Q00414Q007B3Q00023Q000665015D00120001000C2Q0013012Q000E4Q0013012Q00354Q007B8Q0013012Q000C4Q0013012Q00074Q0013012Q00084Q0013012Q00424Q007B3Q00014Q0013012Q00494Q007B3Q00024Q0013012Q00414Q0013012Q00463Q000665015E00130001001D2Q0013012Q001F4Q007B8Q0013012Q00204Q0013012Q00264Q0013012Q00274Q0013012Q00344Q0013012Q000E4Q0013012Q000F4Q0013012Q00314Q0013012Q00224Q0013012Q00374Q0013012Q002E4Q0013012Q002F4Q0013012Q00304Q0013012Q00104Q0013012Q00114Q0013012Q00124Q0013012Q00184Q0013012Q00194Q0013012Q001A4Q0013012Q001B4Q0013012Q00134Q0013012Q00154Q0013012Q00164Q0013012Q00174Q0013012Q00144Q0013012Q001C4Q0013012Q001D4Q0013012Q001E3Q0020AC005F000700DB2Q00130161003F3Q0020820062003500DC2Q00A8015F006200022Q0013013C005F3Q000665015F0014000100012Q0013012Q000C3Q000665016000150001003C2Q0013012Q00074Q0013012Q000C4Q0013012Q00354Q007B8Q0013012Q00414Q0013012Q00324Q0013012Q003F4Q0013012Q00404Q0013012Q00334Q0013012Q00424Q0013012Q00474Q0013012Q00434Q0013012Q004E4Q0013012Q00444Q0013012Q00464Q0013012Q004D4Q0013012Q00454Q0013012Q000D4Q0013012Q003B4Q0013012Q003C4Q0013012Q003D4Q0013012Q003E4Q0013012Q005E4Q0013012Q00094Q0013012Q005F4Q0013012Q002C4Q0013012Q002D4Q007B3Q00014Q007B3Q00024Q0013012Q00204Q0013012Q00364Q0013012Q00264Q0013012Q00274Q0013012Q001C4Q0013012Q00154Q0013012Q00084Q0013012Q00064Q0013012Q00164Q0013012Q00174Q0013012Q00184Q0013012Q00194Q0013012Q001B4Q0013012Q001A4Q0013012Q001F4Q0013012Q001D4Q0013012Q00214Q0013012Q00344Q0013012Q001E4Q0013012Q00104Q0013012Q000E4Q0013012Q002E4Q0013012Q00514Q0013012Q00534Q0013012Q005B4Q0013012Q00304Q0013012Q00544Q0013012Q005C4Q0013012Q002A4Q0013012Q005A4Q0013012Q005D3Q00066501610016000100012Q0013012Q00323Q00066501620017000100022Q0013012Q000C4Q007B7Q00128E016200CB3Q00066501620018000100022Q0013012Q000C4Q007B7Q001203006200CE3Q00202Q0062000C00DD00122Q006300DE6Q006400606Q006500616Q0062006500016Q00013Q00193Q000B3Q00028Q00025Q00F2A440025Q000EA540025Q00889A40025Q00C07940030C3Q0047657445717569706D656E74026Q002A40026Q00F03F025Q00406440025Q00A0AF40026Q002C4000353Q00126C3Q00014Q003A000100013Q0026AB3Q000200010001000426012Q0002000100126C000100013Q0026C50001000B00010001000426012Q000B0001002ED20003000B00010002000426012Q000B0001002E5D0004001E00010005000426012Q001E00012Q007B000200013Q00208E0002000200064Q0002000200024Q00028Q00025Q00202Q00020002000700062Q0002001900013Q000426012Q001900012Q007B000200034Q007B00035Q0020820003000300072Q007200020002000200067C0002001C00010001000426012Q001C00012Q007B000200033Q00126C000300014Q00720002000200022Q00CA000200023Q00126C000100083Q000E620008002200010001000426012Q00220001002E5D000A000500010009000426012Q000500012Q007B00025Q00208200020002000B0006570102002C00013Q000426012Q002C00012Q007B000200034Q007B00035Q00208200030003000B2Q007200020002000200067C0002002F00010001000426012Q002F00012Q007B000200033Q00126C000300014Q00720002000200022Q00CA000200043Q000426012Q00340001000426012Q00050001000426012Q00340001000426012Q000200012Q0045012Q00019Q003Q00034Q00773Q00014Q00303Q00024Q0045012Q00017Q00043Q00025Q007CA540025Q00F8AF40026Q00F03F028Q00010A3Q00067C3Q000400010001000426012Q00040001002E5D0002000700010001000426012Q0007000100126C000100034Q0030000100023Q000426012Q0009000100126C000100044Q0030000100024Q0045012Q00017Q00033Q0003063Q0042752Q665570030C3Q00536C696365616E6444696365030E3Q00416472656E616C696E6552757368000E4Q009E016Q00206Q00014Q000200013Q00202Q0002000200026Q0002000200064Q000C00010001000426012Q000C00012Q007B7Q0020AC5Q00012Q007B000200013Q0020820002000200032Q00A8012Q000200022Q00303Q00024Q0045012Q00017Q00123Q00028Q00025Q0020A340025Q00DC9740025Q00049F40025Q000CAD40026Q00F03F025Q008EA040025Q00805F40025Q006CA940025Q000EA540025Q00BEAC40025Q00D07B40025Q00CC9640025Q00688A4003183Q00456E6572677954696D65546F4D6178507265646963746564026Q00E03F025Q00389C40025Q00DEAD4001343Q00126C000100014Q003A000200023Q00126C000300013Q0026C50003000700010001000426012Q00070001002E710002000300010003000426012Q00030001002E710004000D00010005000426012Q000D0001000ED30006000D00010001000426012Q000D00012Q007B00046Q0030000400023Q002E5D0008001100010007000426012Q001100010026C50001001300010001000426012Q00130001002E5D000900020001000A000426012Q0002000100126C000400013Q0026C50004001800010006000426012Q00180001002E5D000B001A0001000C000426012Q001A000100126C000100063Q000426012Q000200010026C50004001E00010001000426012Q001E0001002E5D000D00140001000E000426012Q001400012Q007B000500013Q00207600050005000F4Q000700076Q00088Q0005000800024Q000200056Q00055Q00062Q0002002D00010005000426012Q002D00012Q007B00056Q0002000500020005000E4A0110002D00010005000426012Q002D0001002E710012002E00010011000426012Q002E00012Q00CA00025Q00126C000400063Q000426012Q00140001000426012Q00020001000426012Q00030001000426012Q000200012Q0045012Q00017Q000E3Q00028Q00025Q0032AC40025Q00B4A340025Q00E0A040025Q00F8AE40025Q008AAD40025Q00B0AA40026Q00F03F025Q0018A540025Q0008A340025Q00688840025Q00308540030F3Q00456E65726779507265646963746564026Q002240002C3Q00126C3Q00014Q003A000100013Q00126C000200014Q003A000300033Q002E5D0003000800010002000426012Q000800010026C50002000A00010001000426012Q000A0001002E5D0005000400010004000426012Q0004000100126C000300013Q0026AB0003000B00010001000426012Q000B0001002E710007001300010006000426012Q001300010026AB3Q001300010008000426012Q001300012Q007B00046Q0030000400023Q002E71000A000200010009000426012Q000200010026C53Q001900010001000426012Q00190001002E71000B00020001000C000426012Q000200012Q007B000400013Q0020F100040004000D4Q0004000200024Q000100046Q00045Q00062Q0004002400010001000426012Q002400012Q007B00046Q0002000400010004000EBE000E002500010004000426012Q002500012Q00CA00015Q00126C3Q00083Q000426012Q00020001000426012Q000B0001000426012Q00020001000426012Q00040001000426012Q000200012Q0045012Q00018Q00012Q00028Q00025Q0061B240025Q009EA640025Q0076A640025Q004FB04003063Q00A197EBCD56ED03063Q009FE0C7A79B3703093Q00C5E71EEDD5E63AD4E403043Q00B297935C025Q00A89C40025Q00B2AA40025Q00589640025Q00ACA040025Q00D08040025Q00949A40027Q0040030A3Q0052744252656D61696E73026Q00F03F030B3Q0042752Q6652656D61696E73025Q008C9840025Q0022A840025Q00F0A340025Q00D2AD4003063Q009FC42F7382AC03053Q00E3DE94632503093Q00014670C9DB262Q54E503053Q0099532Q329603053Q006979671D7F03073Q002D3D16137C13CB03063Q00E02221C3036203073Q00D9A1726D95621003093Q0020341A439E6114262B03063Q00147240581CDC03053Q00050EC6B5F403073Q00DD5161B2D498B003063Q00ECD731CD1BDF03053Q007AAD877D9B03093Q00B6D522861D24CE82D203073Q00A8E4A160D95F51030A3Q00F6D0366E2A5ADAD8204F03063Q0037BBB14E3C4F03063Q000CFE73DD47DD03073Q00E04DAE3F8B26AF03093Q00B6557A11A6545E289703043Q004EE42138030A3Q00E37FAA3180C37FBB0D9603053Q00E5AE1ED26303043Q006D6174682Q033Q00616273025Q002EA840025Q0046A040026Q00E03F025Q009AA940025Q00C09B40025Q001EAF40025Q000FB140025Q00D0AF40025Q0030754003063Q009263E6461B2F03083Q00A1D333AA107A5D3503093Q00C9BA9017D9BBB42EE803043Q00489BCED203093Q00717358020C6A75470B03053Q0053261A346E03053Q006C1833475403043Q002638774703063Q00D2DF74E0244403063Q0036938F38B64503093Q00E495DD76FDC387F95A03053Q00BFB6E19F2903093Q001C1B2459B4ABCD381703073Q00A24B724835EBE703053Q00B83350E35F03063Q0062EC5C248233025Q005AA640025Q00089540025Q00849A4003063Q003ADDAA67EC2F03073Q00597B8DE6318D5D03093Q00C165D433325FF577E503063Q002A9311966C7003063Q0021A93F72E6E403063Q00886FC64D1F8703063Q0023398B60BCF603083Q00C96269C736DD847703093Q008B18A11E2Q20AABF1F03073Q00CCD96CE341625503063Q0070CCE7E82DCC03063Q00A03EA395854C03063Q00F7902119C2C403053Q00A3B6C06D4F03093Q00063222FFD7212006D303053Q0095544660A003093Q002Q0F01E1072A02FE3D03043Q008D58666D03043Q004E616D652Q01025Q001BB340025Q00DCA24003063Q008529208C44BA03083Q0050C4796CDA25C8D503093Q0032672040691B8C066003073Q00EA6013621F2B6E03063Q002A105CC0A96003073Q00EB667F32A7CC1203063Q007191D915453C03063Q004E30C195432403093Q00020AA227632518860B03053Q0021507EE07803063Q00C0A70DC359FE03053Q003C8CC863A403063Q005DC7050032B603063Q00C41C9749565303093Q00C1170B2FA04D1E70E003083Q001693634970E2387803093Q008F7CEEF9B2947AF1F003053Q00EDD815829503053Q00B6414B5EBC03073Q003EE22E2Q3FD0A903063Q00C42979B51E1F03083Q003E857935E37F6D4F03093Q00220010CAF4BBA4160703073Q00C270745295B6CE03093Q000EA14014FFCE012AAD03073Q006E59C82C78A08203053Q009FCC5F474F03083Q002DCBA32B26232A5B025Q00D89240025Q0098834003063Q00A6C42810A39503053Q00C2E794644603093Q007458E39CD4DD404AD203063Q00A8262CA1C39603073Q00B3F48D6424EDA403083Q0076E09CE2165088D603063Q0063DE75B643FC03043Q00E0228E3903093Q00ECB3E7E251E45B08CD03083Q006EBEC7A5BD13913D03073Q00E9E378FA9FC2C803063Q00A7BA8B1788EB03063Q003B85A43B1BA703043Q006D7AD5E803093Q00DCE3800FCCE2A436FD03043Q00508E97C203093Q0034CF7B403CEA785F0603043Q002C63A617025Q00749940025Q0010AF40025Q00789740025Q00309C40025Q00989C4003053Q007072696E74030A3Q00E091DE1182A455DB8BCF03073Q0034B2E5BC43E7C903063Q0029404601AD1C03073Q004341213064973C03063Q00FED782EEF2CD03053Q0093BF87CEB803093Q00B63C84FEFA46B4823B03073Q00D2E448C6A1B83303053Q00546F74616C030B3Q002140FF1C33C2395AF64A3303063Q00AE562993701303063Q007A30A13D241D03083Q00CB3B60ED6B456F7103093Q0016028EDE13E5D1220503073Q00B74476CC81519003093Q0039A47CE834AE01BE7503063Q00E26ECD10846B03093Q00F8CBEFCB55EED1BA9903053Q00218BA380B903063Q00766828E8564A03043Q00BE37386403093Q0064BB1E2131F6F550BC03073Q009336CF5C7E738303073Q0053686F7274657203083Q00033E27700C72577103063Q001E6D51551D6D03063Q00DE41788037CC03073Q009C9F1134D656BE03093Q009CFB9F838CFABBBABD03043Q00DCCE8FDD03063Q004E6F726D616C03083Q008A722310DDDE88C603073Q00B2E61D4D77B8AC03063Q00D48E262D76EA03063Q009895DE6A7B1703093Q00EF32D47C97C820F05003053Q00D5BD46962303063Q004C6F6E676572030D3Q0042546C485D507909465B67520F03043Q00682F351403063Q00827CAD2ABD1D03063Q006FC32CE17CDC03093Q00EA52224C89BEDE401303063Q00CBB8266013CB030A3Q004D617852656D61696E73025Q0064A640025Q00E06C4003063Q00ADCD6004135E03073Q001AEC9D2C52722C03093Q00183AF764083BD35D3903043Q003B4A4EB503063Q0004E1766CB23703053Q00D345B12Q3A03093Q0085F15BCACBDEB1E36A03063Q00ABD78519958903093Q00D6C13EF6D01CF351E403083Q002281A8529A8F509C03063Q00A4821F3D495C03073Q00E9E5D2536B282E03093Q00F35610E927D44434C503053Q0065A12252B603093Q00DF0455F2E4CE8D3DED03083Q004E886D399EBB82E203053Q000A30EDF03203043Q00915E5F9903063Q00DCFD38E34FA503063Q00D79DAD74B52E03093Q0007A0A9CDF820B28DE103053Q00BA55D4EB9203053Q00F68E02FF3503073Q0038A2E1769E598E025Q00EDB140025Q0020834003063Q007D35EC9923CA03063Q00B83C65A0CF4203093Q0003965E8313977ABA2203043Q00DC51E21C03063Q003DDA90F6EBCB03063Q00A773B5E29B8A03063Q00C312CB6A7A6303073Q00A68242873C1B1103093Q00765EEC4A12514CC86603053Q0050242AAE1503073Q007D1838685A152503043Q001A2E705703063Q0098138742BEAD03083Q00D4D943CB142QDF2503093Q0088998AED2Q98AED4A903043Q00B2DAEDC803063Q009ABAE8D7B3A703043Q00B0D6D58603063Q00D59D9AE2A94403073Q003994CDD6B4C83603093Q0020E9170B5407FB332703053Q0016729D5554030A3Q00E9CA0BF658FBA9CDC50003073Q00C8A4AB73A43D9603063Q0018435577CF2B03053Q00AE5913192103093Q001D067071D5920D290103073Q006B4F72322E97E703053Q000DA9A1288603083Q00A059C6D549EA59D70059032Q00126C3Q00013Q002E710003000100010002000426012Q00010001000ED30001000100013Q000426012Q0001000100126C000100013Q0026C50001000A00010001000426012Q000A0001002E5D0005000600010004000426012Q000600012Q007B00026Q0080000300013Q00122Q000400063Q00122Q000500076Q0003000500024Q0002000200034Q000300013Q00122Q000400083Q00122Q000500096Q0003000500024Q0002000200030006570102001B00013Q000426012Q001B0001002ED2000B001B0001000A000426012Q001B0001002E5D000D00450301000C000426012Q0045030100126C000200014Q003A000300033Q002E5D000E00B80201000F000426012Q00B802010026AB000200B802010010000426012Q00B802012Q007B000400023Q0020320004000400114Q0004000100024Q000300043Q00122Q000400126Q000500036Q000500053Q00122Q000600123Q00042Q0004004302012Q007B000800043Q0020670008000800134Q000A00036Q000A000A00074Q0008000A000200262Q0008002002010001000426012Q00200201002ED20015002002010014000426012Q00200201002E5D0017003600010016000426012Q00360001000426012Q002002012Q007B00096Q0080000A00013Q00122Q000B00183Q00122Q000C00196Q000A000C00024Q00090009000A4Q000A00013Q00122Q000B001A3Q00122Q000C001B6Q000A000C00024Q00090009000A2Q007B000A00013Q0012F2000B001C3Q00122Q000C001D6Q000A000C00024Q000B00056Q000C8Q000D00013Q00122Q000E001E3Q00122Q000F001F6Q000D000F00024Q000C000C000D2Q0080000D00013Q00122Q000E00203Q00122Q000F00216Q000D000F00024Q000C000C000D4Q000D00013Q00122Q000E00223Q00122Q000F00236Q000D000F00024Q000C000C000D00126C000D00124Q00A8010B000D00022Q00FF000C00066Q000D8Q000E00013Q00122Q000F001E3Q00122Q0010001F6Q000E001000024Q000D000D000E4Q000E00013Q00122Q000F00203Q00122Q001000214Q00A8010E001000022Q000C000D000D000E4Q000E00013Q00122Q000F00223Q00122Q001000236Q000E001000024Q000D000D000E00122Q000E00126Q000C000E00024Q000B000B000C4Q0009000A000B2Q001501098Q000A00013Q00122Q000B00243Q00122Q000C00256Q000A000C00024Q00090009000A2Q0080000A00013Q00122Q000B00263Q00122Q000C00276Q000A000C00024Q00090009000A4Q000A00013Q00122Q000B00283Q00122Q000C00296Q000A000C00024Q00090009000A00068F0109008F00010008000426012Q008F00012Q007B00096Q0080000A00013Q00122Q000B002A3Q00122Q000C002B6Q000A000C00024Q00090009000A4Q000A00013Q00122Q000B002C3Q00122Q000C002D6Q000A000C00024Q00090009000A2Q007B000A00013Q00126C000B002E3Q00126C000C002F4Q00A8010A000C00022Q00260009000A00080012B9000900303Q0020820009000900312Q0002000A000800032Q0072000900020002002E71003300422Q010032000426012Q00422Q010026A5000900422Q010034000426012Q00422Q0100126C000A00014Q003A000B000B3Q002E710036009D00010035000426012Q009D00010026C5000A009F00010001000426012Q009F0001002E04013700FCFF2Q0038000426012Q0099000100126C000B00013Q002E5D003A00EB00010039000426012Q00EB00010026AB000B00EB00010012000426012Q00EB00012Q007B000C6Q0091010D00013Q00122Q000E003B3Q00122Q000F003C6Q000D000F00024Q000C000C000D4Q000D00013Q00122Q000E003D3Q00122Q000F003E6Q000D000F00024Q000C000C000D4Q000D00013Q00122Q000E003F3Q00122Q000F00406Q000D000F00024Q000C000C000D4Q000D00013Q00122Q000E00413Q00122Q000F00426Q000D000F00024Q000E00056Q000F8Q001000013Q00122Q001100433Q00122Q001200446Q0010001200024Q000F000F00104Q001000013Q00122Q001100453Q00122Q001200466Q0010001200024Q000F000F00104Q001000013Q00122Q001100473Q00122Q001200486Q0010001200024Q000F000F00104Q001000013Q00122Q001100493Q00122Q0012004A6Q0010001200024Q000F000F001000122Q001000126Q000E001000024Q000F00066Q00108Q001100013Q00122Q001200433Q00122Q001300446Q0011001300024Q0010001000114Q001100013Q00122Q001200453Q00122Q001300466Q0011001300024Q0010001000114Q001100013Q00122Q001200473Q00122Q001300486Q0011001300024Q0010001000114Q001100013Q00122Q001200493Q00122Q0013004A6Q0011001300024Q00100010001100122Q001100126Q000F001100024Q000E000E000F4Q000C000D000E00044Q00200201002E04014B00B5FF2Q004B000426012Q00A00001002E71004C00A00001004D000426012Q00A000010026AB000B00A000010001000426012Q00A000012Q007B000C6Q0080000D00013Q00122Q000E004E3Q00122Q000F004F6Q000D000F00024Q000C000C000D4Q000D00013Q00122Q000E00503Q00122Q000F00516Q000D000F00024Q000C000C000D2Q007B000D00013Q0012F2000E00523Q00122Q000F00536Q000D000F00024Q000E00056Q000F8Q001000013Q00122Q001100543Q00122Q001200556Q0010001200024Q000F000F00102Q0080001000013Q00122Q001100563Q00122Q001200576Q0010001200024Q000F000F00104Q001000013Q00122Q001100583Q00122Q001200596Q0010001200024Q000F000F001000126C001000124Q00A8010E001000022Q00FF000F00066Q00108Q001100013Q00122Q001200543Q00122Q001300556Q0011001300024Q0010001000114Q001100013Q00122Q001200563Q00122Q001300574Q00A80111001300022Q000C0010001000114Q001100013Q00122Q001200583Q00122Q001300596Q0011001300024Q00100010001100122Q001100126Q000F001100024Q000E000E000F4Q000C000D000E2Q0015010C8Q000D00013Q00122Q000E005A3Q00122Q000F005B6Q000D000F00024Q000C000C000D2Q0080000D00013Q00122Q000E005C3Q00122Q000F005D6Q000D000F00024Q000C000C000D4Q000D00013Q00122Q000E005E3Q00122Q000F005F6Q000D000F00024Q000C000C000D2Q007B000D00034Q0004000D000D00070020AC000D000D00602Q0072000D0002000200206D010C000D006100126C000B00123Q000426012Q00A00001000426012Q00200201000426012Q00990001000426012Q00200201002E5D0063007E2Q010062000426012Q007E2Q0100068F0103007E2Q010008000426012Q007E2Q012Q007B000A6Q0080000B00013Q00122Q000C00643Q00122Q000D00656Q000B000D00024Q000A000A000B4Q000B00013Q00122Q000C00663Q00122Q000D00676Q000B000D00024Q000A000A000B2Q007B000B00013Q0012F2000C00683Q00122Q000D00696Q000B000D00024Q000C00056Q000D8Q000E00013Q00122Q000F006A3Q00122Q0010006B6Q000E001000024Q000D000D000E2Q0080000E00013Q00122Q000F006C3Q00122Q0010006D6Q000E001000024Q000D000D000E4Q000E00013Q00122Q000F006E3Q00122Q0010006F6Q000E001000024Q000D000D000E00126C000E00124Q00A8010C000E00022Q00FF000D00066Q000E8Q000F00013Q00122Q0010006A3Q00122Q0011006B6Q000F001100024Q000E000E000F4Q000F00013Q00122Q0010006C3Q00122Q0011006D4Q00A8010F001100022Q000C000E000E000F4Q000F00013Q00122Q0010006E3Q00122Q0011006F6Q000F001100024Q000E000E000F00122Q000F00126Q000D000F00024Q000C000C000D4Q000A000B000C000426012Q0020020100126C000A00014Q003A000B000B3Q0026AB000A00802Q010001000426012Q00802Q0100126C000B00013Q000ED3001200CC2Q01000B000426012Q00CC2Q012Q007B000C6Q0091010D00013Q00122Q000E00703Q00122Q000F00716Q000D000F00024Q000C000C000D4Q000D00013Q00122Q000E00723Q00122Q000F00736Q000D000F00024Q000C000C000D4Q000D00013Q00122Q000E00743Q00122Q000F00756Q000D000F00024Q000C000C000D4Q000D00013Q00122Q000E00763Q00122Q000F00776Q000D000F00024Q000E00056Q000F8Q001000013Q00122Q001100783Q00122Q001200796Q0010001200024Q000F000F00104Q001000013Q00122Q0011007A3Q00122Q0012007B6Q0010001200024Q000F000F00104Q001000013Q00122Q0011007C3Q00122Q0012007D6Q0010001200024Q000F000F00104Q001000013Q00122Q0011007E3Q00122Q0012007F6Q0010001200024Q000F000F001000122Q001000126Q000E001000024Q000F00066Q00108Q001100013Q00122Q001200783Q00122Q001300796Q0011001300024Q0010001000114Q001100013Q00122Q0012007A3Q00122Q0013007B6Q0011001300024Q0010001000114Q001100013Q00122Q0012007C3Q00122Q0013007D6Q0011001300024Q0010001000114Q001100013Q00122Q0012007E3Q00122Q0013007F6Q0011001300024Q00100010001100122Q001100126Q000F001100024Q000E000E000F4Q000C000D000E00044Q002002010026C5000B00D02Q010001000426012Q00D02Q01002E71008000832Q010081000426012Q00832Q012Q007B000C6Q0080000D00013Q00122Q000E00823Q00122Q000F00836Q000D000F00024Q000C000C000D4Q000D00013Q00122Q000E00843Q00122Q000F00856Q000D000F00024Q000C000C000D2Q007B000D00013Q0012F2000E00863Q00122Q000F00876Q000D000F00024Q000E00056Q000F8Q001000013Q00122Q001100883Q00122Q001200896Q0010001200024Q000F000F00102Q0080001000013Q00122Q0011008A3Q00122Q0012008B6Q0010001200024Q000F000F00104Q001000013Q00122Q0011008C3Q00122Q0012008D6Q0010001200024Q000F000F001000126C001000124Q00A8010E001000022Q00FF000F00066Q00108Q001100013Q00122Q001200883Q00122Q001300896Q0011001300024Q0010001000114Q001100013Q00122Q0012008A3Q00122Q0013008B4Q00A80111001300022Q000C0010001000114Q001100013Q00122Q0012008C3Q00122Q0013008D6Q0011001300024Q00100010001100122Q001100126Q000F001100024Q000E000E000F4Q000C000D000E2Q0015010C8Q000D00013Q00122Q000E008E3Q00122Q000F008F6Q000D000F00024Q000C000C000D2Q0080000D00013Q00122Q000E00903Q00122Q000F00916Q000D000F00024Q000C000C000D4Q000D00013Q00122Q000E00923Q00122Q000F00936Q000D000F00024Q000C000C000D2Q007B000D00034Q0004000D000D00070020AC000D000D00602Q0072000D0002000200206D010C000D006100126C000B00123Q000426012Q00832Q01000426012Q00200201000426012Q00802Q01002E040194002200010094000426012Q004202012Q007B000900073Q00067C0009002702010001000426012Q00270201002E710095004202010096000426012Q0042020100126C000900014Q003A000A000A3Q0026AB0009002902010001000426012Q0029020100126C000A00013Q002E710097002C02010098000426012Q002C02010026AB000A002C02010001000426012Q002C02010012B9000B00994Q00CE000C00013Q00122Q000D009A3Q00122Q000E009B6Q000C000E00024Q000D00036Q000B000D000100122Q000B00996Q000C00036Q000C000C000700202Q000C000C00602Q0072000C000200022Q0013010D00084Q0053010B000D0001000426012Q00420201000426012Q002C0201000426012Q00420201000426012Q0029020100044C0104002A00012Q007B000400073Q0006570104004503013Q000426012Q004503010012B9000400994Q0014010500013Q00122Q0006009C3Q00122Q0007009D6Q0005000700024Q00068Q000700013Q00122Q0008009E3Q00122Q0009009F6Q0007000900024Q0006000600072Q006A010700013Q00122Q000800A03Q00122Q000900A16Q0007000900024Q0006000600070020820006000600A22Q00530104000600010012B9000400994Q0014010500013Q00122Q000600A33Q00122Q000700A46Q0005000700024Q00068Q000700013Q00122Q000800A53Q00122Q000900A66Q0007000900024Q0006000600072Q0080000700013Q00122Q000800A73Q00122Q000900A86Q0007000900024Q0006000600074Q000700013Q00122Q000800A93Q00122Q000900AA6Q0007000900024Q0006000600070020820006000600A22Q00530104000600010012B9000400994Q0014010500013Q00122Q000600AB3Q00122Q000700AC6Q0005000700024Q00068Q000700013Q00122Q000800AD3Q00122Q000900AE6Q0007000900024Q0006000600072Q006A010700013Q00122Q000800AF3Q00122Q000900B06Q0007000900024Q0006000600070020820006000600B12Q00530104000600010012B9000400994Q0014010500013Q00122Q000600B23Q00122Q000700B36Q0005000700024Q00068Q000700013Q00122Q000800B43Q00122Q000900B56Q0007000900024Q0006000600072Q006A010700013Q00122Q000800B63Q00122Q000900B76Q0007000900024Q0006000600070020820006000600B82Q00530104000600010012B9000400994Q0014010500013Q00122Q000600B93Q00122Q000700BA6Q0005000700024Q00068Q000700013Q00122Q000800BB3Q00122Q000900BC6Q0007000900024Q0006000600072Q006A010700013Q00122Q000800BD3Q00122Q000900BE6Q0007000900024Q0006000600070020820006000600BF2Q00530104000600010012B9000400994Q0014010500013Q00122Q000600C03Q00122Q000700C16Q0005000700024Q00068Q000700013Q00122Q000800C23Q00122Q000900C36Q0007000900024Q0006000600072Q006A010700013Q00122Q000800C43Q00122Q000900C56Q0007000900024Q0006000600070020820006000600C62Q0053010400060001000426012Q00450301002E7100C800FF020100C7000426012Q00FF02010026AB000200FF02010001000426012Q00FF02012Q007B00046Q004F010500013Q00122Q000600C93Q00122Q000700CA6Q0005000700024Q0004000400054Q000500013Q00122Q000600CB3Q00122Q000700CC6Q0005000700024Q00066Q00260004000500062Q001501048Q000500013Q00122Q000600CD3Q00122Q000700CE6Q0005000700024Q0004000400052Q004F010500013Q00122Q000600CF3Q00122Q000700D06Q0005000700024Q0004000400054Q000500013Q00122Q000600D13Q00122Q000700D26Q0005000700024Q00066Q00260004000500062Q001501048Q000500013Q00122Q000600D33Q00122Q000700D46Q0005000700024Q0004000400052Q006A010500013Q00122Q000600D53Q00122Q000700D66Q0005000700024Q0004000400052Q0094000500013Q00122Q000600D73Q00122Q000700D86Q0005000700024Q0004000400054Q000500013Q00122Q000600D93Q00122Q000700DA6Q00050007000200202Q0004000500012Q001501048Q000500013Q00122Q000600DB3Q00122Q000700DC6Q0005000700024Q0004000400052Q0094000500013Q00122Q000600DD3Q00122Q000700DE6Q0005000700024Q0004000400054Q000500013Q00122Q000600DF3Q00122Q000700E06Q00050007000200202Q00040005000100126C000200123Q002E5D00E2001D000100E1000426012Q001D00010026AB0002001D00010012000426012Q001D00012Q007B00046Q006A010500013Q00122Q000600E33Q00122Q000700E46Q0005000700024Q0004000400052Q0094000500013Q00122Q000600E53Q00122Q000700E66Q0005000700024Q0004000400054Q000500013Q00122Q000600E73Q00122Q000700E86Q00050007000200202Q0004000500012Q001501048Q000500013Q00122Q000600E93Q00122Q000700EA6Q0005000700024Q0004000400052Q0094000500013Q00122Q000600EB3Q00122Q000700EC6Q0005000700024Q0004000400054Q000500013Q00122Q000600ED3Q00122Q000700EE6Q00050007000200202Q0004000500012Q001501048Q000500013Q00122Q000600EF3Q00122Q000700F06Q0005000700024Q0004000400052Q0094000500013Q00122Q000600F13Q00122Q000700F26Q0005000700024Q0004000400054Q000500013Q00122Q000600F33Q00122Q000700F46Q00050007000200202Q0004000500012Q001501048Q000500013Q00122Q000600F53Q00122Q000700F66Q0005000700024Q0004000400052Q0094000500013Q00122Q000600F73Q00122Q000700F86Q0005000700024Q0004000400054Q000500013Q00122Q000600F93Q00122Q000700FA6Q00050007000200202Q00040005000100126C000200103Q000426012Q001D00012Q007B00026Q0080000300013Q00122Q000400FB3Q00122Q000500FC6Q0003000500024Q0002000200034Q000300013Q00122Q000400FD3Q00122Q000500FE6Q0003000500024Q0002000200032Q00B4000300013Q00122Q000400FF3Q00122Q00052Q00015Q0003000500024Q0002000200034Q000200023Q000426012Q00060001000426012Q000100012Q0045012Q00017Q000C3Q0003063Q00694198C8C45A03053Q00A52811D49E03093Q00D7CD2A0C04F0DF0E2003053Q004685B9685303093Q00334C4826F6284A572F03053Q00A96425244A03063Q0021B78E66019503043Q003060E7C203093Q00FA4E2C123BCDA985DB03083Q00E3A83A6E4D79B8CF03093Q004C35B34C8EF77EB67E03083Q00C51B5CDF20D1BB11012B4Q007B00016Q0039000200013Q00122Q000300013Q00122Q000400026Q0002000400024Q0001000100024Q000200013Q00122Q000300033Q00122Q000400046Q0002000400024Q0001000100024Q000200013Q00122Q000300053Q00122Q000400066Q0002000400024Q00010001000200062Q0001002800013Q000426012Q002800012Q007B00016Q0080000200013Q00122Q000300073Q00122Q000400086Q0002000400024Q0001000100024Q000200013Q00122Q000300093Q00122Q0004000A6Q0002000400024Q0001000100022Q006A010200013Q00122Q0003000B3Q00122Q0004000C6Q0002000400024Q0001000100022Q0004000100013Q0006572Q01002800013Q000426012Q002800012Q0077000100013Q00067C0001002900010001000426012Q002900012Q007700016Q0030000100024Q0045012Q00017Q00EC3Q00028Q00025Q00D07A40025Q00A88340025Q0028B240025Q00ACA540025Q0088804003063Q00226FEFCD024D03043Q009B633FA3030A3Q00B0C583B28B8190DEAD8103063Q00E4E2B1C1EDD9025Q00C49D40025Q0072AF40025Q00C05440025Q0060A64003063Q001BA537EA35A703043Q008654D04303113Q0021A38A5007A4837E1CA2834F3FA381551003043Q003C73CCE603073Q00B671AB52F23CED03043Q0010875A8B03063Q0075442A054F4603073Q0018341466532E34030A3Q00F63B031B3DC13D2E282Q03053Q006FA44F414403063Q00E9CC97D22FFD03063Q008AA6B9E3BE4E03113Q00F97BC93B462B1CE97BCB32410F16CC7DC603073Q0079AB14A557324303093Q00E42AB637BD11CF3CBC03063Q0062A658D956D9025Q006C9740025Q0011B24003063Q00D7C6553787CE03063Q00BC2Q961961E6030A3Q00E89D7D3D3EE8C886530E03063Q008DBAE93F626C03063Q0042752Q66557003093Q0042726F616473696465025Q00509640025Q0078B24003063Q00DEFF38BA24E603053Q0045918A4CD603113Q0042C02Q85AB1E75ED8687BA055CC08E80BC03063Q007610AF2QE9DF030F3Q00A99127B2EB8F3DBF9630BAFD9E6F8E03073Q001DEBE455DB8EEB025Q0024B140025Q00088A4003063Q001CE496EB765C03083Q00325DB4DABD172E47030A3Q00ECB0797376D95AD1A85703073Q0028BEC43B2C24BC030E3Q00427572696564547265617375726503063Q001350C8B8FB6A03073Q006D5C25BCD49A1D03113Q0036E0A8CF255201CDABCD344928E0A3CA3203063Q003A648FC4A351030B3Q003D5022AD3B09C80B16472603083Q006E7A2243C35F298503063Q005481777CD76703053Q00B615D13B2A030A3Q008543E72213BBA558C91103063Q00DED737A57D41030A3Q004772616E644D656C2Q65025Q00389340025Q0048A34003063Q0003C4D216F3D603083Q002A4CB1A67A92A18D03113Q00978509C26D7EA0A80AC07C65898502C77A03063Q0016C5EA65AE1903143Q001E3FB0D07AEFD688297486CE79BCC484223AA0CF03083Q00E64D54C5BC16CFB703063Q00D824EACA8DB303083Q00559974A69CECC190030A3Q0096F46F8CD605B6EF41BF03063Q0060C4802DD38403123Q00536B752Q6C616E6443726F2Q73626F6E6573025Q0008AA4003063Q001A986F53D3B803083Q00B855ED1B3FB2CFD403113Q003A5605531C510C7D07570C4C24560E560B03043Q003F68396903123Q003992B04C0782B7574BB7B641088EB74D048903043Q00246BE7C403063Q007C858EB15CA703043Q00E73DD5C2030A3Q003BB91F4C3BA82F7C05A103043Q001369CD5D03113Q00527574686C652Q73507265636973696F6E03063Q00861DCA8D3EBE03053Q005FC968BEE103113Q009DC4CDC2BBC3C4ECA0C5C4DD83C4C6C7AC03043Q00AECFABA1030C3Q00D9EC18F6B8F5E8FF1FFAF6D003063Q00B78D9E6D9398025Q002EA940025Q00DEB14003063Q000D39CA3A2D1B03043Q006C4C6986030A3Q00D9D193DEFCEED7BEEDC203053Q00AE8BA5D181030B3Q005472756542656172696E67026Q00F03F025Q004FB040025Q0032A54003063Q00DC162924083203063Q00409D46657269030A3Q0072BC85DC2245BAA8EF1C03053Q007020C8C783027Q0040025Q0098884003093Q000F425DBBC8B82A234403073Q00424C303CD8A3CB030B3Q004973417661696C61626C6503073Q0048617354696572026Q003F40026Q001040025Q00BAAF40025Q00BEAA4003063Q009BB655C55EDC03073Q0044DAE619933FAE030A3Q009F3E717384A8385C40BA03053Q00D6CD4A332C03113Q00D245E6F872F463F2EC78E858F7F27EEE5503053Q00179A2C829C03113Q0039AFA9AA331D3EB6BDA1240704A8A4BA2F03063Q007371C6CDCE5603063Q00A567D26C854503043Q003AE4379E03093Q00869DF2111EB833B29A03073Q0055D4E9B04E5CCD03093Q007D5184EE757487F14F03043Q00822A38E803053Q00DEBA30E24C03063Q005F8AD5448320025Q0066AA40025Q00AAA640026Q000840025Q00B6A740025Q0020964003063Q008296E3FC3C3503083Q00CBC3C6AFAA5D47ED030A3Q001C5F1CEA6314EE21473203073Q009C4E2B5EB5317103063Q0053D8E8950A5103073Q00191288A4C36B23030A3Q00DA398B7040B9D3B7E42103083Q00D8884DC92F12DCA103063Q000CDC07EC09CE03073Q00E24D8C4BBA68BC03093Q008BDAF2006DACC8D62C03053Q002FD9AEB05F03063Q0094D27805B74603083Q0046D8BD1662D2341803063Q00FBEF8FB1D2C803053Q00B3BABFC3E703093Q00CB2B3A2QDB2A1EE2EA03043Q0084995F7803063Q009FBD1C20F6D603073Q00C0D1D26E4D97BA03063Q00C1330EDFFED603063Q00A4806342899F03093Q00329DCB81229CEFB81303043Q00DE60E98903063Q0095BCA9188DE103073Q0090D9D3C77FE893026Q00184003063Q00D91F121ED45703083Q0024984F5E48B5256203093Q00E5CC6500F5CD4139C403043Q005FB7B827030A3Q00983EFF14518D03BC31F403073Q0062D55F874634E0025Q0080434003093Q00537465616C74685570030E3Q004C6F616465644469636542752Q66025Q00B49840025Q0018AC4003113Q0046696C746572656454696D65546F44696503013Q003C026Q00284003183Q00426F2Q7346696C7465726564466967687452656D61696E73025Q0040A740025Q00449E4003063Q00DF93E54155EC03053Q00349EC3A917030A3Q0048A8104BB430698476B003083Q00EB1ADC5214E6551B0100025Q00F49A40025Q007FB34003063Q008283CEF7C71103083Q0018C3D382A1A66310030A3Q007417CB136113540CE52003063Q00762663894C33025Q00A88440025Q0030854003093Q00093AA0407D3920AE5703053Q00164A48C123025Q00F49440025Q006C9D4003063Q000D49C86E2D6B03043Q00384C1984030A3Q006CD58919FD5BD3A42AC303053Q00AF3EA1CB4603063Q001DEDEF25342E03053Q00555CBDA37303093Q001BB812070BB9363E3A03043Q005849CC5003093Q00198A1C4A16F621901503063Q00BA4EE370264903053Q00C858E9545F03063Q001A9C379D353303093Q00AFCA17DAB34384D70203063Q0030ECB876B9D803113Q00CDB45334CA3ACAAD473FDD20F0B35E24D603063Q005485DD3750AF03063Q009CD70890C64E03063Q003CDD8744C6A703093Q00DCA9DABC60CCE8BBEB03063Q00B98EDD98E32203093Q006FCC5BF67C1FF84BC003073Q009738A5379A235303053Q00944C11EFAC03043Q008EC02365025Q0052A740025Q0036A64003063Q00F7450595E69E03083Q0076B61549C387ECCC030A3Q003A28387F3608EF07301603073Q009D685C7A20646D2Q0103063Q00A991C5F4759A03053Q0014E8C189A2030A3Q0010CBE799D589057E2ED303083Q001142BFA5C687EC770024032Q00126C3Q00013Q002E710002000100010003000426012Q000100010026AB3Q000100010001000426012Q0001000100126C000100013Q002E5D0005000600010004000426012Q000600010026AB0001000600010001000426012Q0006000100126C000200013Q002E0401063Q00010006000426012Q000B00010026AB0002000B00010001000426012Q000B00012Q007B00036Q0080000400013Q00122Q000500073Q00122Q000600086Q0004000600024Q0003000300044Q000400013Q00122Q000500093Q00122Q0006000A6Q0004000600024Q0003000300040006570103001E00013Q000426012Q001E0001002E04010B00F80201000C000426012Q00140301002E5D000D00450001000E000426012Q004500012Q007B000300024Q002D010400013Q00122Q0005000F3Q00122Q000600106Q0004000600024Q0003000300044Q000400013Q00122Q000500113Q00122Q000600126Q0004000600024Q0003000300044Q000400013Q00122Q000500133Q00122Q000600146Q00040006000200062Q0003004500010004000426012Q004500012Q007B00036Q0075000400013Q00122Q000500153Q00122Q000600166Q0004000600024Q0003000300044Q000400013Q00122Q000500173Q00122Q000600186Q0004000600024Q000500034Q00330105000100020026A50005004200010001000426012Q004200012Q0077000500013Q00067C0005004300010001000426012Q004300012Q007700056Q0026000300040005000426012Q001403012Q007B000300024Q0053000400013Q00122Q000500193Q00122Q0006001A6Q0004000600024Q0003000300044Q000400013Q00122Q0005001B3Q00122Q0006001C6Q0004000600024Q0003000300044Q000400013Q00122Q0005001D3Q00122Q0006001E6Q00040006000200062Q0003005800010004000426012Q00580001002E04011F001900010020000426012Q006F00012Q007B00036Q0016010400013Q00122Q000500213Q00122Q000600226Q0004000600024Q0003000300044Q000400013Q00122Q000500233Q00122Q000600246Q0004000600024Q000500043Q00202Q0005000500254Q000700053Q00202Q0007000700264Q00050007000200062Q0005006C00010001000426012Q006C00012Q0077000500013Q00067C0005006D00010001000426012Q006D00012Q007700056Q0026000300040005000426012Q00140301002E5D0027008200010028000426012Q008200012Q007B000300024Q0053000400013Q00122Q000500293Q00122Q0006002A6Q0004000600024Q0003000300044Q000400013Q00122Q0005002B3Q00122Q0006002C6Q0004000600024Q0003000300044Q000400013Q00122Q0005002D3Q00122Q0006002E6Q00040006000200062Q0003008400010004000426012Q00840001002E5D002F009B00010030000426012Q009B00012Q007B00036Q0016010400013Q00122Q000500313Q00122Q000600326Q0004000600024Q0003000300044Q000400013Q00122Q000500333Q00122Q000600346Q0004000600024Q000500043Q00202Q0005000500254Q000700053Q00202Q0007000700354Q00050007000200062Q0005009800010001000426012Q009800012Q0077000500013Q00067C0005009900010001000426012Q009900012Q007700056Q0026000300040005000426012Q001403012Q007B000300024Q002D010400013Q00122Q000500363Q00122Q000600376Q0004000600024Q0003000300044Q000400013Q00122Q000500383Q00122Q000600396Q0004000600024Q0003000300044Q000400013Q00122Q0005003A3Q00122Q0006003B6Q00040006000200062Q000300C300010004000426012Q00C300012Q007B00036Q0016010400013Q00122Q0005003C3Q00122Q0006003D6Q0004000600024Q0003000300044Q000400013Q00122Q0005003E3Q00122Q0006003F6Q0004000600024Q000500043Q00202Q0005000500254Q000700053Q00202Q0007000700404Q00050007000200062Q000500C000010001000426012Q00C000012Q0077000500013Q00067C000500C100010001000426012Q00C100012Q007700056Q0026000300040005000426012Q00140301002E5D004100ED00010042000426012Q00ED00012Q007B000300024Q002D010400013Q00122Q000500433Q00122Q000600446Q0004000600024Q0003000300044Q000400013Q00122Q000500453Q00122Q000600466Q0004000600024Q0003000300044Q000400013Q00122Q000500473Q00122Q000600486Q00040006000200062Q000300ED00010004000426012Q00ED00012Q007B00036Q0016010400013Q00122Q000500493Q00122Q0006004A6Q0004000600024Q0003000300044Q000400013Q00122Q0005004B3Q00122Q0006004C6Q0004000600024Q000500043Q00202Q0005000500254Q000700053Q00202Q00070007004D4Q00050007000200062Q000500EA00010001000426012Q00EA00012Q0077000500013Q00067C000500EB00010001000426012Q00EB00012Q007700056Q0026000300040005000426012Q00140301002E04014E002A0001004E000426012Q00172Q012Q007B000300024Q002D010400013Q00122Q0005004F3Q00122Q000600506Q0004000600024Q0003000300044Q000400013Q00122Q000500513Q00122Q000600526Q0004000600024Q0003000300044Q000400013Q00122Q000500533Q00122Q000600546Q00040006000200062Q000300172Q010004000426012Q00172Q012Q007B00036Q0016010400013Q00122Q000500553Q00122Q000600566Q0004000600024Q0003000300044Q000400013Q00122Q000500573Q00122Q000600586Q0004000600024Q000500043Q00202Q0005000500254Q000700053Q00202Q0007000700594Q00050007000200062Q000500142Q010001000426012Q00142Q012Q0077000500013Q00067C000500152Q010001000426012Q00152Q012Q007700056Q0026000300040005000426012Q001403012Q007B000300024Q0053000400013Q00122Q0005005A3Q00122Q0006005B6Q0004000600024Q0003000300044Q000400013Q00122Q0005005C3Q00122Q0006005D6Q0004000600024Q0003000300044Q000400013Q00122Q0005005E3Q00122Q0006005F6Q00040006000200062Q0003002A2Q010004000426012Q002A2Q01002E5D006100412Q010060000426012Q00412Q012Q007B00036Q0016010400013Q00122Q000500623Q00122Q000600636Q0004000600024Q0003000300044Q000400013Q00122Q000500643Q00122Q000600656Q0004000600024Q000500043Q00202Q0005000500254Q000700053Q00202Q0007000700664Q00050007000200062Q0005003E2Q010001000426012Q003E2Q012Q0077000500013Q00067C0005003F2Q010001000426012Q003F2Q012Q007700056Q0026000300040005000426012Q0014030100126C000300013Q0026C5000300462Q010067000426012Q00462Q01002E71006800C52Q010069000426012Q00C52Q012Q007B00046Q0075000500013Q00122Q0006006A3Q00122Q0007006B6Q0005000700024Q0004000400054Q000500013Q00122Q0006006C3Q00122Q0007006D6Q0005000700024Q000600034Q00330106000100022Q007B000700064Q007B000800074Q007B000900053Q0020820009000900352Q002D000800094Q009C00073Q00022Q007B000800064Q007B000900074Q007B000A00053Q002082000A000A00402Q0072000900020002000657010900642Q013Q000426012Q00642Q012Q007B000900083Q00263F000900632Q01006E000426012Q00632Q012Q007A00096Q0077000900014Q00720008000200022Q00430107000700080006920106000200010007000426012Q00692Q012Q007A00066Q0077000600014Q0026000400050006002E04016F00590001006F000426012Q00C42Q012Q007B000400054Q004B010500013Q00122Q000600703Q00122Q000700716Q0005000700024Q00040004000500202Q0004000400724Q00040002000200062Q0004007E2Q013Q000426012Q007E2Q012Q007B000400043Q00204F00040004007300122Q000600743Q00122Q000700756Q00040007000200062Q000400802Q013Q000426012Q00802Q01002E5D007600C42Q010077000426012Q00C42Q012Q007B00046Q003C010500013Q00122Q000600783Q00122Q000700796Q0005000700024Q0004000400054Q000500013Q00122Q0006007A3Q00122Q0007007B6Q0005000700024Q000600076Q000700053Q00202Q0007000700664Q00060002000200062Q0006009A2Q010001000426012Q009A2Q012Q007B000600054Q0022000700013Q00122Q0008007C3Q00122Q0009007D6Q0007000900024Q00060006000700202Q0006000600724Q00060002000200062Q000600C32Q010001000426012Q00C32Q012Q007B000600074Q007B000700053Q0020820007000700262Q007200060002000200067C000600C12Q010001000426012Q00C12Q012Q007B000600054Q0022000700013Q00122Q0008007E3Q00122Q0009007F6Q0007000900024Q00060006000700202Q0006000600724Q00060002000200062Q000600C12Q010001000426012Q00C12Q012Q007B00066Q0080000700013Q00122Q000800803Q00122Q000900816Q0007000900024Q0006000600074Q000700013Q00122Q000800823Q00122Q000900836Q0007000900024Q0006000600072Q0080000700013Q00122Q000800843Q00122Q000900856Q0007000900024Q0006000600074Q000700013Q00122Q000800863Q00122Q000900876Q0007000900024Q000600060007002616000600C22Q010067000426012Q00C22Q012Q007A00066Q0077000600014Q002600040005000600126C0003006E3Q002E5D008900C92Q010088000426012Q00C92Q01000E62008A00CB2Q010003000426012Q00CB2Q01002E5D008B005C0201008C000426012Q005C02012Q007B00046Q0075000500013Q00122Q0006008D3Q00122Q0007008E6Q0005000700024Q0004000400054Q000500013Q00122Q0006008F3Q00122Q000700906Q0005000700024Q00066Q0080000700013Q00122Q000800913Q00122Q000900926Q0007000900024Q0006000600074Q000700013Q00122Q000800933Q00122Q000900946Q0007000900024Q0006000600070006570106003D02013Q000426012Q003D02012Q007B00066Q00A3010700013Q00122Q000800953Q00122Q000900966Q0007000900024Q0006000600074Q000700013Q00122Q000800973Q00122Q000900986Q0007000900024Q0006000600074Q000700013Q00122Q000800993Q00122Q0009009A6Q0007000900024Q00060006000700262Q0006003C02010001000426012Q003C02012Q007B00066Q0080000700013Q00122Q0008009B3Q00122Q0009009C6Q0007000900024Q0006000600074Q000700013Q00122Q0008009D3Q00122Q0009009E6Q0007000900024Q0006000600072Q001F010700013Q00122Q0008009F3Q00122Q000900A06Q0007000900024Q00060006000700262Q0006003B02010001000426012Q003B02012Q007B00066Q0080000700013Q00122Q000800A13Q00122Q000900A26Q0007000900024Q0006000600074Q000700013Q00122Q000800A33Q00122Q000900A46Q0007000900024Q0006000600072Q006A010700013Q00122Q000800A53Q00122Q000900A66Q0007000900024Q000600060007000E660167003B02010006000426012Q003B02012Q007B000600034Q00330106000100020026BC0006003B020100A7000426012Q003B02012Q007B00066Q0042000700013Q00122Q000800A83Q00122Q000900A96Q0007000900024Q0006000600074Q000700013Q00122Q000800AA3Q00122Q000900AB6Q0007000900024Q0006000600074Q000700013Q00122Q000800AC3Q00122Q000900AD6Q0007000900024Q00060006000700262Q0006003B020100AE000426012Q003B02012Q007B000600043Q0020410106000600AF4Q000800016Q000900016Q00060009000200062Q0006003B02010001000426012Q003B02012Q007B000600043Q0020950006000600254Q000800053Q00202Q0008000800B04Q00060008000200044Q003D02012Q007A00066Q0077000600014Q0026000400050006002E7100B10014030100B2000426012Q001403012Q007B000400093Q00205F0104000400B300122Q000600B43Q00122Q000700B56Q00040007000200062Q0004005002010001000426012Q005002012Q007B0004000A3Q00201C0004000400B600122Q000500B43Q00122Q000600B56Q00040006000200062Q0004005002010001000426012Q00500201002E5D00B70014030100B8000426012Q001403012Q007B00046Q0094000500013Q00122Q000600B93Q00122Q000700BA6Q0005000700024Q0004000400054Q000500013Q00122Q000600BB3Q00122Q000700BC6Q00050007000200202Q0004000500BD000426012Q00140301002E5D00BE006E020100BF000426012Q006E0201000ED30001006E02010003000426012Q006E02012Q007B00046Q0094000500013Q00122Q000600C03Q00122Q000700C16Q0005000700024Q0004000400054Q000500013Q00122Q000600C23Q00122Q000700C36Q00050007000200202Q0004000500BD2Q007B000400034Q008001040001000100126C000300673Q0026C5000300720201006E000426012Q00720201002E5D00C500422Q0100C4000426012Q00422Q012Q007B000400054Q004B010500013Q00122Q000600C63Q00122Q000700C76Q0005000700024Q00040004000500202Q0004000400724Q00040002000200062Q0004008302013Q000426012Q008302012Q007B000400043Q00205F01040004007300122Q000600743Q00122Q000700756Q00040007000200062Q0004008502010001000426012Q00850201002E7100C900BE020100C8000426012Q00BE02012Q007B00046Q0075000500013Q00122Q000600CA3Q00122Q000700CB6Q0005000700024Q0004000400054Q000500013Q00122Q000600CC3Q00122Q000700CD6Q0005000700024Q00066Q0080000700013Q00122Q000800CE3Q00122Q000900CF6Q0007000900024Q0006000600074Q000700013Q00122Q000800D03Q00122Q000900D16Q0007000900024Q0006000600072Q0080000700013Q00122Q000800D23Q00122Q000900D36Q0007000900024Q0006000600074Q000700013Q00122Q000800D43Q00122Q000900D56Q0007000900024Q0006000600072Q00EA0007000B3Q00122Q000800676Q000900066Q000A00043Q00202Q000A000A00254Q000C00053Q00202Q000C000C00B04Q000A000C6Q00098Q00073Q00024Q0008000C3Q00122Q000900676Q000A00066Q000B00043Q00202Q000B000B00254Q000D00053Q00202Q000D000D00B04Q000B000D6Q000A8Q00083Q00024Q00070007000800062Q0006000200010007000426012Q00BC02012Q007A00066Q0077000600014Q00260004000500062Q007B000400054Q0022000500013Q00122Q000600D63Q00122Q000700D76Q0005000700024Q00040004000500202Q0004000400724Q00040002000200062Q0004000503010001000426012Q000503012Q007B000400054Q004B010500013Q00122Q000600D83Q00122Q000700D96Q0005000700024Q00040004000500202Q0004000400724Q00040002000200062Q0004000503013Q000426012Q000503012Q007B000400074Q007B000500053Q00208200050005004D2Q007200040002000200067C0004000503010001000426012Q000503012Q007B00046Q0080000500013Q00122Q000600DA3Q00122Q000700DB6Q0005000700024Q0004000400054Q000500013Q00122Q000600DC3Q00122Q000700DD6Q0005000700024Q0004000400052Q0080000500013Q00122Q000600DE3Q00122Q000700DF6Q0005000700024Q0004000400054Q000500013Q00122Q000600E03Q00122Q000700E16Q0005000700024Q0004000400052Q007B0005000B3Q00126C0006006E4Q00C9000700066Q000800076Q000900053Q00202Q0009000900404Q000800096Q00078Q00053Q00024Q0006000C3Q00122Q0007006E6Q000800064Q007B000900074Q0010000A00053Q00202Q000A000A00404Q0009000A6Q00088Q00063Q00024Q00050005000600062Q0004000503010005000426012Q000503012Q007B000400083Q00263F000400070301006E000426012Q00070301002E0401E2000D000100E3000426012Q001203012Q007B00046Q0094000500013Q00122Q000600E43Q00122Q000700E56Q0005000700024Q0004000400054Q000500013Q00122Q000600E63Q00122Q000700E76Q00050007000200202Q0004000500E800126C0003008A3Q000426012Q00422Q012Q007B00036Q0080000400013Q00122Q000500E93Q00122Q000600EA6Q0004000600024Q0003000300044Q000400013Q00122Q000500EB3Q00122Q000600EC6Q0004000600024Q0003000300042Q0030000300023Q000426012Q000B0001000426012Q00060001000426012Q000100012Q0045012Q00017Q00063Q00030A3Q0043504D61785370656E64026Q00F03F03093Q00537465616C7468557003093Q002CBDAF10F4FBE4DE1B03083Q00B16FCFCE739F888C030B3Q004973417661696C61626C65001D4Q0029019Q000100013Q00202Q0001000100014Q00010001000200202Q0001000100024Q000200026Q000300033Q0020520103000300034Q000500016Q000600016Q00030006000200062Q0003001500013Q000426012Q001500012Q007B000300044Q0087010400053Q00122Q000500043Q00122Q000600056Q0004000600024Q00030003000400202Q0003000300064Q0003000200022Q00720002000200022Q00020001000100020006922Q01000200013Q000426012Q001A00012Q007A8Q00773Q00014Q00303Q00024Q0045012Q00017Q00093Q0003113Q002D801410D1417015991F06C05A510C9D0903073Q003F65E97074B42F030B3Q004973417661696C61626C65030E3Q00EA36FD00F720C63FCC1FFA23D03303063Q0056A35B8D7298027Q004003063Q0042752Q66557003093Q0042726F616473696465026Q004940003D9Q006Q000100013Q00122Q000200013Q00122Q000300026Q0001000300028Q000100206Q00036Q0002000200064Q003600010001000426012Q003600012Q007B3Q00024Q007B000100034Q00EC000200046Q00038Q000400013Q00122Q000500043Q00122Q000600056Q0004000600024Q00030003000400202Q0003000300034Q000300046Q00023Q000200105D0102000600022Q007B000300044Q007B000400053Q0020AC0004000400072Q007B00065Q0020820006000600082Q007A010400064Q009100036Q009C00013Q00022Q007B000200064Q00EC000300046Q00048Q000500013Q00122Q000600043Q00122Q000700056Q0005000700024Q00040004000500202Q0004000400034Q000400056Q00033Q000200105D0103000600032Q007B000400044Q002F010500053Q00202Q0005000500074Q00075Q00202Q0007000700084Q000500076Q00048Q00023Q00024Q00010001000200062Q0001003900013Q000426012Q003900012Q007B3Q00073Q000E9C0109003A00013Q000426012Q003A00012Q007A8Q00773Q00014Q00303Q00024Q0045012Q00017Q00063Q0003073Q007004797E355D1803053Q005A336B1413030C3Q00B8E380CB0DBEC684E1349EF803053Q005DED90E58F030A3Q004973536F6C6F4D6F646503093Q00497354616E6B696E67001C4Q0015019Q000100013Q00122Q000200013Q00122Q000300026Q0001000300028Q00012Q006A2Q0100013Q00122Q000200033Q00122Q000300046Q0001000300028Q0001000657012Q001A00013Q000426012Q001A00012Q007B3Q00023Q0020825Q00052Q0033012Q00010002000657012Q001900013Q000426012Q001900012Q007B3Q00033Q0020AC5Q00062Q007B000200044Q00A8012Q000200022Q00E17Q000426012Q001A00012Q007A8Q00773Q00014Q00303Q00024Q0045012Q00017Q000E3Q0003113Q0026FEF11D045131F7FE1A0E7214FAF5171F03063Q0026759690796B030B3Q004973417661696C61626C65030C3Q000BBAE00E25BEC63B20B6EB2803043Q005A4DDB8E030A3Q0054616C656E7452616E6B03093Q00D711283A472368E71303073Q001A866441592C6703083Q00D0F63422A7F8F72903053Q00C491835043030C3Q003DBF13060CDC16B5290C1CFB03063Q00887ED0666878030D3Q00538FCB5386460F5E7486C74DA803083Q003118EAAE23CF325D007C9Q006Q000100013Q00122Q000200013Q00122Q000300026Q0001000300028Q000100206Q00036Q0002000200064Q007800010001000426012Q007800012Q007B3Q00024Q007B00016Q0087010200013Q00122Q000300043Q00122Q000400056Q0002000400024Q00010001000200202Q0001000100064Q0001000200022Q00EC000200036Q00038Q000400013Q00122Q000500073Q00122Q000600086Q0004000600024Q00030003000400202Q0003000300034Q000300046Q00023Q00022Q00432Q01000100022Q007B000200034Q001501038Q000400013Q00122Q000500093Q00122Q0006000A6Q0004000600024Q0003000300040020AC0003000300032Q002D000300044Q009100026Q009C5Q00022Q007B000100044Q007B00026Q0087010300013Q00122Q000400043Q00122Q000500056Q0003000500024Q00020002000300202Q0002000200064Q0002000200022Q00EC000300036Q00048Q000500013Q00122Q000600073Q00122Q000700086Q0005000700024Q00040004000500202Q0004000400034Q000400056Q00033Q00022Q00430102000200032Q007B000300034Q001501048Q000500013Q00122Q000600093Q00122Q0007000A6Q0005000700024Q0004000400050020AC0004000400032Q002D000400054Q009100036Q009C00013Q00022Q0043014Q00012Q007B000100024Q00EC000200036Q00038Q000400013Q00122Q0005000B3Q00122Q0006000C6Q0004000600024Q00030003000400202Q0003000300034Q000300046Q00023Q00022Q007B000300034Q001501048Q000500013Q00122Q0006000D3Q00122Q0007000E6Q0005000700024Q0004000400050020AC0004000400032Q002D000400054Q009100036Q009C00013Q00022Q007B000200044Q00EC000300036Q00048Q000500013Q00122Q0006000B3Q00122Q0007000C6Q0005000700024Q00040004000500202Q0004000400034Q000400056Q00033Q00022Q007B000400034Q001501058Q000600013Q00122Q0007000D3Q00122Q0008000E6Q0006000800024Q0005000500060020AC0005000500032Q002D000500064Q009100046Q009C00023Q00022Q00432Q0100010002000638012Q007900010001000426012Q007900012Q007A8Q00773Q00014Q00303Q00024Q0045012Q00017Q000E3Q0003063Q0042752Q665570030E3Q00426574772Q656E7468654579657303113Q0024FBF98C7402DDED987E1EE6E8867818EB03053Q00116C929DE8030B3Q004973417661696C61626C6503083Q0042752Q66446F776E030C3Q00417564616369747942752Q66030C3Q006DC21AD927AD63C219E02ABA03063Q00C82BA3748D4F030A3Q0054616C656E7452616E6B027Q0040030B3Q004F2Q706F7274756E69747903093Q009C243C80BBE7EBB02203073Q0083DF565DE3D09400344Q007B7Q0020DA5Q00014Q000200013Q00202Q0002000200026Q0002000200064Q003200013Q000426012Q003200012Q007B3Q00014Q004B2Q0100023Q00122Q000200033Q00122Q000300046Q0001000300028Q000100206Q00056Q0002000200064Q002900013Q000426012Q002900012Q007B7Q0020DA5Q00064Q000200013Q00202Q0002000200076Q0002000200064Q003200013Q000426012Q003200012Q007B3Q00014Q00872Q0100023Q00122Q000200083Q00122Q000300096Q0001000300028Q000100206Q000A6Q0002000200263F3Q00290001000B000426012Q002900012Q007B7Q0020DA5Q00064Q000200013Q00202Q00020002000C6Q0002000200064Q003200013Q000426012Q003200012Q007B3Q00014Q005C000100023Q00122Q0002000D3Q00122Q0003000E6Q0001000300028Q000100206Q00056Q000200029Q002Q00303Q00024Q0045012Q00017Q00A83Q00028Q00027Q0040030B3Q001C162Q2E0E100B1F21290403063Q00674F7E4F4A6103073Q0049735265616479030D3Q00917AD663770E8870DF7F5714BD03063Q007ADA1FB3133E030B3Q004973417661696C61626C65030D3Q0098D3C8D1E0B577BCDAC1C8C7A603073Q0025D3B6ADA1A9C1030F3Q00432Q6F6C646F776E52656D61696E73026Q003E40030D3Q00DC3F48C9016F8BF83641D0267C03073Q00D9975A2DB9481B026Q005E4003113Q00EB75E31653CD53F70259D168F21C5FD76503053Q0036A31C877203093Q00537465616C7468557003043Q0043617374030B3Q00536861646F7744616E6365025Q0004A640025Q005EA940025Q00507A40025Q00806F40025Q0006AC40025Q0046AB4003103Q001ADE49975C711BD35297427B2BDA4E9603063Q001F48BB3DE22E024Q00089F064103253Q00D01203E14F7F20CC1103F6467027C64668DB753E33CA124BDD526A64E01442D14C6D2CCC1203073Q0044A36623B2271E030A3Q008D78DBC30CA28E14B27403083Q0071DE10BAA763D5E3030A3Q001D06FAF22119F6F3220A03043Q00964E6E9B03073Q00A6CA2AECAB10AC03083Q0020E5A54781C47EDF03073Q00F188C78880D9D003063Q00B5A3E9A42QE1025Q007C9C40025Q00DAAF40025Q00C2B040025Q00DEAB4003093Q0073993F745B9836784403043Q001730EB5E03093Q005FC8D95E5C20DA73CE03073Q00B21CBAB83D3753030C3Q00E7C25232E63AFDC1E24338E103073Q0095A4AD275C926E03113Q00DB2E141B1F15DC370010080FE629190B2Q03063Q007B9347707F7A030A3Q00536861646F776D656C64025Q00649240025Q003C9B40025Q00189E40025Q003CB340025Q00B07B40025Q00C2A04003103Q00FEC8966454C2FE8A7E53C0C9817055D803053Q0026ACADE211025Q00CDEC40030F3Q006E103FFB0D2224EE491E3BE2481D2803043Q008F2D714C025Q0060964003073Q00C04A2QBB12BBF003063Q00D583252QD67D030C3Q001338209BD1151D24B1E8352303053Q0081464B45DF03063Q0070CAFDE06FE703063Q008F26AB93891C03113Q00F88BBDF706EDFBC092B6E117F6DAD996A003073Q00B4B0E2D993638303093Q00F0AB2E04D8AA2708C703043Q0067B3D94F03063Q0042752Q66557003083Q00417564616369747903093Q0042752Q66537461636B030B3Q004F2Q706F7274756E697479026Q001840025Q00DEA540025Q003C9F4003063Q0056616E697368025Q0094AE40025Q00A6AA40025Q0058A840025Q00508140025Q00EEAB40025Q0004A240025Q0018A640025Q00FEA14003103Q0078B208C053829042B809D9458FA259A303073Q00C32AD77CB521EC026Q009D4003103Q002E58242A65CE0C573E2Q2DB84571187703063Q00986D39575E4503063Q00CFD604AAADDA03083Q00C899B76AC3DEB23403113Q001AEA8C394C541DF398325B4E27ED81295003063Q003A5283E85D2903093Q00A045D116562C8B58C403063Q005FE337B0753D03073Q003B712E46A4166D03053Q00CB781E432B030C3Q00C43648CBE9C2134CE1D0E22D03053Q00B991452D8F025Q00E6B240025Q00588E40025Q00107E40025Q00909940025Q00508040025Q006EA54003103Q00B81A0DB3CE842C11A9C9861B1AA7CF9E03053Q00BCEA7F79C603143Q001B3300977804128D31211BC370141A8D31211BCA03043Q00E3585273026Q00F03F025Q000C9B40025Q0026A240025Q00C06E40025Q00209540030B3Q007017BBA30D64671EB4A40703063Q0013237FDAC76203093Q003FE90BE117E802ED0803043Q00827C9B6A03063Q00E3CAF8A6B0FE03083Q00DFB5AB96CFC3961C03073Q006F35EEA306422903053Q00692C5A83CE030C3Q00CAF3B79D380DC9E1BCB01B3603063Q005E9F80D2D968025Q009C9640025Q0064A440025Q0036A940025Q00609040025Q0086A640025Q00808A4003103Q0062FC12AA4D71CA725FEC0ABB5C7EEA6E03083Q001A309966DF3F1F99031B3Q002141FEE74273E5F2064FFAB32641E3F00700CEE10343E6E00A4FF903043Q009362208D025Q00D2AD40025Q00188F40030B3Q002B4BE2CE09416F194DE0CF03073Q002B782383AA6636030D3Q007F0382A68CA4B65B0A8BBFABB703073Q00E43466E7D6C5D0030C3Q00536C696365616E644469636503113Q0036E971CEEF8536C60EEF67DEFF8510C20703083Q00B67E8015AA8AEB7903113Q00A3D331E2831D1F169BD527F2931D39129203083Q0066EBBA5586E6735003063Q00610D305661DC03073Q0042376C5E3F12B403073Q003782883A28570703063Q003974EDE55747030C3Q009FA2E8C347DD71ABBFE4F47F03073Q0027CAD18D87178E025Q0052B340025Q00F09C40025Q00AC9640025Q0076AA40025Q00407340025Q004CA640025Q00E0624003103Q00CD361D1F20F6CC3B061F3E2QFC321A1E03063Q00989F53696A5203113Q00A2C742E6896F89C755FDDE1CA5C75FF1CC03063Q003CE1A63192A900A0022Q00126C3Q00013Q0026AB3Q00DD00010002000426012Q00DD00012Q007B00016Q004B010200013Q00122Q000300033Q00122Q000400046Q0002000400024Q00010001000200202Q0001000100054Q00010002000200062Q0001006A00013Q000426012Q006A00012Q007B00016Q004B010200013Q00122Q000300063Q00122Q000400076Q0002000400024Q00010001000200202Q0001000100084Q00010002000200062Q0001006A00013Q000426012Q006A00012Q007B000100024Q00332Q01000100020006572Q01006A00013Q000426012Q006A00012Q007B00016Q0087010200013Q00122Q000300093Q00122Q0004000A6Q0002000400024Q00010001000200202Q00010001000B4Q0001000200020026160001003D0001000C000426012Q003D00012Q007B00016Q0087010200013Q00122Q0003000D3Q00122Q0004000E6Q0002000400024Q00010001000200202Q00010001000B4Q000100020002000E66010F006A00010001000426012Q006A00012Q007B000100034Q00332Q010001000200067C0001003D00010001000426012Q003D00012Q007B00016Q004B010200013Q00122Q000300103Q00122Q000400116Q0002000400024Q00010001000200202Q0001000100084Q00010002000200062Q0001006A00013Q000426012Q006A00012Q007B000100043Q0006572Q01006A00013Q000426012Q006A00012Q007B000100053Q0020412Q01000100124Q000300016Q00048Q00010004000200062Q0001006A00010001000426012Q006A00012Q007B000100063Q002Q202Q01000100134Q00025Q00202Q0002000200144Q000300036Q00010003000200062Q0001005100010001000426012Q00510001002E710016006A00010015000426012Q006A000100126C000100014Q003A000200023Q002E710018005300010017000426012Q005300010026AB0001005300010001000426012Q0053000100126C000200013Q0026C50002005C00010001000426012Q005C0001002E71001900580001001A000426012Q005800012Q007B000300064Q00E2000400013Q00122Q0005001B3Q00122Q0006001C6Q00040006000200202Q00030004001D4Q000300013Q00122Q0004001E3Q00122Q0005001F6Q000300056Q00035Q00044Q00580001000426012Q006A0001000426012Q005300012Q007B00016Q004B010200013Q00122Q000300203Q00122Q000400216Q0002000400024Q00010001000200202Q0001000100084Q00010002000200062Q0001008B00013Q000426012Q008B00012Q007B00016Q004B010200013Q00122Q000300223Q00122Q000400236Q0002000400024Q00010001000200202Q0001000100054Q00010002000200062Q0001008B00013Q000426012Q008B00012Q007B000100074Q00E8000200013Q00122Q000300243Q00122Q000400256Q0002000400024Q0001000100024Q000200013Q00122Q000300263Q00122Q000400276Q0002000400024Q00010001000200062Q0001008D00010001000426012Q008D0001002E5D0029009F02010028000426012Q009F0201002E5D002B009F0201002A000426012Q009F02012Q007B00016Q004B010200013Q00122Q0003002C3Q00122Q0004002D6Q0002000400024Q00010001000200202Q0001000100084Q00010002000200062Q0001009D00013Q000426012Q009D00012Q007B000100034Q00332Q010001000200067C000100BF00010001000426012Q00BF00012Q007B00016Q0022000200013Q00122Q0003002E3Q00122Q0004002F6Q0002000400024Q00010001000200202Q0001000100084Q00010002000200062Q0001009F02010001000426012Q009F02012Q007B00016Q004B010200013Q00122Q000300303Q00122Q000400316Q0002000400024Q00010001000200202Q0001000100084Q00010002000200062Q000100B500013Q000426012Q00B500012Q007B000100034Q00332Q010001000200067C000100BF00010001000426012Q00BF00012Q007B00016Q004B010200013Q00122Q000300323Q00122Q000400336Q0002000400024Q00010001000200202Q0001000100084Q00010002000200062Q0001009F02013Q000426012Q009F02012Q007B000100063Q002Q202Q01000100134Q00025Q00202Q0002000200344Q000300036Q00010003000200062Q000100C900010001000426012Q00C90001002E04013500D82Q010036000426012Q009F020100126C000100013Q002E71003700CE00010038000426012Q00CE00010026C5000100D000010001000426012Q00D00001002E71003A00CA00010039000426012Q00CA00012Q007B000200064Q00E2000300013Q00122Q0004003B3Q00122Q0005003C6Q00030005000200202Q00020003003D4Q000200013Q00122Q0003003E3Q00122Q0004003F6Q000200046Q00025Q00044Q00CA0001000426012Q009F0201002E04014000DE00010040000426012Q00BB2Q010026AB3Q00BB2Q010001000426012Q00BB2Q012Q007B000100083Q00067C000100332Q010001000426012Q00332Q012Q007B000100074Q0080000200013Q00122Q000300413Q00122Q000400426Q0002000400024Q0001000100024Q000200013Q00122Q000300433Q00122Q000400446Q0002000400024Q0001000100020006572Q0100332Q013Q000426012Q00332Q012Q007B000100093Q0006572Q0100332Q013Q000426012Q00332Q012Q007B00016Q004B010200013Q00122Q000300453Q00122Q000400466Q0002000400024Q00010001000200202Q0001000100054Q00010002000200062Q000100332Q013Q000426012Q00332Q012Q007B0001000A4Q00332Q01000100020006572Q0100332Q013Q000426012Q00332Q012Q007B00016Q004B010200013Q00122Q000300473Q00122Q000400486Q0002000400024Q00010001000200202Q0001000100084Q00010002000200062Q000100332Q013Q000426012Q00332Q012Q007B00016Q0022000200013Q00122Q000300493Q00122Q0004004A6Q0002000400024Q00010001000200202Q0001000100084Q00010002000200062Q000100332Q010001000426012Q00332Q012Q007B000100053Q0020AB2Q010001004B4Q00035Q00202Q00030003004C4Q00010003000200062Q000100332Q010001000426012Q00332Q012Q007B0001000B4Q00332Q010001000200067C000100282Q010001000426012Q00282Q012Q007B000100053Q0020AC00010001004D2Q007B00035Q00208200030003004E2Q00A82Q01000300020026BC000100332Q01004F000426012Q00332Q012Q007B0001000C4Q00332Q01000100020006572Q0100332Q013Q000426012Q00332Q012Q007B000100053Q0020522Q01000100124Q000300016Q00048Q00010004000200062Q000100352Q013Q000426012Q00352Q01002E5D0050005A2Q010051000426012Q005A2Q012Q007B000100063Q002Q202Q01000100134Q00025Q00202Q0002000200524Q000300036Q00010003000200062Q0001003F2Q010001000426012Q003F2Q01002E710053005A2Q010054000426012Q005A2Q0100126C000100014Q003A000200023Q0026C5000100452Q010001000426012Q00452Q01002E71005500412Q010056000426012Q00412Q0100126C000200013Q002E710058004A2Q010057000426012Q004A2Q010026C50002004C2Q010001000426012Q004C2Q01002E71005900462Q01005A000426012Q00462Q012Q007B000300064Q00E2000400013Q00122Q0005005B3Q00122Q0006005C6Q00040006000200202Q00030004005D4Q000300013Q00122Q0004005E3Q00122Q0005005F6Q000300056Q00035Q00044Q00462Q01000426012Q005A2Q01000426012Q00412Q012Q007B00016Q004B010200013Q00122Q000300603Q00122Q000400616Q0002000400024Q00010001000200202Q0001000100054Q00010002000200062Q0001009D2Q013Q000426012Q009D2Q012Q007B000100093Q0006572Q01009D2Q013Q000426012Q009D2Q012Q007B0001000A4Q00332Q01000100020006572Q01009D2Q013Q000426012Q009D2Q012Q007B00016Q004B010200013Q00122Q000300623Q00122Q000400636Q0002000400024Q00010001000200202Q0001000100084Q00010002000200062Q0001007F2Q013Q000426012Q007F2Q012Q007B00016Q004B010200013Q00122Q000300643Q00122Q000400656Q0002000400024Q00010001000200202Q0001000100084Q00010002000200062Q0001009D2Q013Q000426012Q009D2Q012Q007B000100034Q00332Q01000100020006572Q01009D2Q013Q000426012Q009D2Q012Q007B000100083Q00067C0001009D2Q010001000426012Q009D2Q012Q007B000100093Q0006572Q01009D2Q013Q000426012Q009D2Q012Q007B000100074Q0080000200013Q00122Q000300663Q00122Q000400676Q0002000400024Q0001000100024Q000200013Q00122Q000300683Q00122Q000400696Q0002000400024Q0001000100020006572Q01009D2Q013Q000426012Q009D2Q012Q007B000100053Q0020522Q01000100124Q000300016Q00048Q00010004000200062Q0001009F2Q013Q000426012Q009F2Q01002E71006A00BA2Q01006B000426012Q00BA2Q012Q007B000100063Q002Q202Q01000100134Q00025Q00202Q0002000200524Q000300036Q00010003000200062Q000100AB2Q010001000426012Q00AB2Q01002E15006C00AB2Q01006D000426012Q00AB2Q01002E5D006F00BA2Q01006E000426012Q00BA2Q0100126C000100013Q0026AB000100AC2Q010001000426012Q00AC2Q012Q007B000200064Q00E2000300013Q00122Q000400703Q00122Q000500716Q00030005000200202Q00020003005D4Q000200013Q00122Q000300723Q00122Q000400736Q000200046Q00025Q00044Q00AC2Q0100126C3Q00743Q0026C53Q00C12Q010074000426012Q00C12Q01002ED2007600C12Q010075000426012Q00C12Q01002E710078000100010077000426012Q000100012Q007B00016Q004B010200013Q00122Q000300793Q00122Q0004007A6Q0002000400024Q00010001000200202Q0001000100054Q00010002000200062Q0001001E02013Q000426012Q001E02012Q007B00016Q004B010200013Q00122Q0003007B3Q00122Q0004007C6Q0002000400024Q00010001000200202Q0001000100084Q00010002000200062Q0001001E02013Q000426012Q001E02012Q007B000100034Q00332Q01000100020006572Q01001E02013Q000426012Q001E02012Q007B00016Q00C1000200013Q00122Q0003007D3Q00122Q0004007E6Q0002000400024Q00010001000200202Q00010001000B4Q000100020002000E2Q004F00F02Q010001000426012Q00F02Q012Q007B000100074Q00E8000200013Q00122Q0003007F3Q00122Q000400806Q0002000400024Q0001000100024Q000200013Q00122Q000300813Q00122Q000400826Q0002000400024Q00010001000200062Q0001001E02010001000426012Q001E02012Q007B000100053Q0020412Q01000100124Q000300016Q00048Q00010004000200062Q0001001E02010001000426012Q001E02012Q007B000100043Q0006572Q01001E02013Q000426012Q001E02012Q007B000100053Q0020412Q01000100124Q000300016Q00048Q00010004000200062Q0001001E02010001000426012Q001E0201002E710083000B02010084000426012Q000B02012Q007B000100063Q002Q202Q01000100134Q00025Q00202Q0002000200144Q000300036Q00010003000200062Q0001000D02010001000426012Q000D0201002E710085001E02010086000426012Q001E020100126C000100013Q002E5D0088000E02010087000426012Q000E02010026AB0001000E02010001000426012Q000E02012Q007B000200064Q00E2000300013Q00122Q000400893Q00122Q0005008A6Q00030005000200202Q00020003001D4Q000200013Q00122Q0003008B3Q00122Q0004008C6Q000200046Q00025Q00044Q000E0201002E5D008E00780201008D000426012Q007802012Q007B00016Q004B010200013Q00122Q0003008F3Q00122Q000400906Q0002000400024Q00010001000200202Q0001000100054Q00010002000200062Q0001007802013Q000426012Q007802012Q007B00016Q0022000200013Q00122Q000300913Q00122Q000400926Q0002000400024Q00010001000200202Q0001000100084Q00010002000200062Q0001007802010001000426012Q007802012Q007B000100024Q00332Q01000100020006572Q01007802013Q000426012Q007802012Q007B000100053Q0020DA00010001004B4Q00035Q00202Q0003000300934Q00010003000200062Q0001007802013Q000426012Q007802012Q007B000100034Q00332Q010001000200067C0001004D02010001000426012Q004D02012Q007B00016Q004B010200013Q00122Q000300943Q00122Q000400956Q0002000400024Q00010001000200202Q0001000100084Q00010002000200062Q0001007802013Q000426012Q007802012Q007B00016Q004B010200013Q00122Q000300963Q00122Q000400976Q0002000400024Q00010001000200202Q0001000100084Q00010002000200062Q0001006E02013Q000426012Q006E02012Q007B00016Q004B010200013Q00122Q000300983Q00122Q000400996Q0002000400024Q00010001000200202Q0001000100054Q00010002000200062Q0001006E02013Q000426012Q006E02012Q007B000100074Q00E8000200013Q00122Q0003009A3Q00122Q0004009B6Q0002000400024Q0001000100024Q000200013Q00122Q0003009C3Q00122Q0004009D6Q0002000400024Q00010001000200062Q0001007802010001000426012Q007802012Q007B000100043Q0006572Q01007802013Q000426012Q007802012Q007B000100053Q0020522Q01000100124Q000300016Q00048Q00010004000200062Q0001007A02013Q000426012Q007A0201002E5D009E009D0201009F000426012Q009D02012Q007B000100063Q002Q202Q01000100134Q00025Q00202Q0002000200144Q000300036Q00010003000200062Q0001008402010001000426012Q00840201002E7100A1009D020100A0000426012Q009D020100126C000100014Q003A000200023Q0026C50001008A02010001000426012Q008A0201002E5D00A30086020100A2000426012Q0086020100126C000200013Q002E0401A43Q000100A4000426012Q008B02010026AB0002008B02010001000426012Q008B02012Q007B000300064Q00E2000400013Q00122Q000500A53Q00122Q000600A66Q00040006000200202Q00030004001D4Q000300013Q00122Q000400A73Q00122Q000500A86Q000300056Q00035Q00044Q008B0201000426012Q009D0201000426012Q0086020100126C3Q00023Q000426012Q000100012Q0045012Q00017Q00B3022Q00025Q006DB340026Q009440030E3Q0099BC0E39B6B91035B6BD2E29ABB003043Q005C2QD87C030A3Q0049734361737461626C6503063Q0042752Q665570030E3Q00416472656E616C696E655275736803163Q00723FBC52F24D37A861F94937A241F1523CA972E8483A03053Q009D3B52CC20030B3Q004973417661696C61626C6503093Q00537465616C7468557003093Q001B2CE2F9E2F9DBBE2C03083Q00D1585E839A898AB303163Q0001ACD46E1135342609A5D67910223D2B26A4F6690D2B03083Q004248C1A41C7E4351027Q004003043Q0043617374028Q00025Q00E08040025Q00A3B04003103Q00D529BC4D3478D424A74D2A72E42DBB4C03063Q0016874CC83846025Q00DBCA4003143Q00AE31EB301DC08922FD2A5CED843EFD646FF49E3803063Q0081ED5098443D030B3Q0073A405F719315444BA16EA03073Q003831C864937C7703073Q0049735265616479025Q0030B240025Q000CA14003143Q00F930BBF5DE36BEFEC83BBBC5DC2EBAE2C43FB1F403043Q0090AC5EDF030B3Q0042752Q6652656D61696E73030B3Q00426C616465466C752Q72792Q033Q00474344025Q0026AE40025Q00F0A940025Q0094A640025Q00B2A340025Q0034AA40025Q0036A740025Q00D09B40025Q0060734003103Q00160AB6523601914F2B1AAE43270EB15303043Q0027446FC2024Q00801ACB4003113Q00F5A7F4D33995DAA7E3C23991DAB3F5D56003063Q00D7B6C687A719030B3Q00AF45EB4C886FE65D9F5BF303043Q0028ED298A025Q0088A640025Q008C9740030D3Q00E371FCEC67C67AFFED5CC266E903053Q002AA7149A98026Q00084003093Q0042726F616473696465026Q001440026Q00A740025Q00709240025Q002QA640025Q00989F40025Q0040AB40025Q0064984003103Q0078FBB657632F79F6AD577D2549FFB15603063Q00412A9EC2221103113Q00392641186DCF17EF1E22122A21F809FC2Q03083Q008E7A47326C4D8D7B025Q00D88C40026Q009C40025Q001C9C40025Q00A8B040030C3Q0027ADF3142F1DA7DD173510B103053Q005B75C29F78025Q0028A540025Q003AA24003063Q003B2D122E34E303073Q00447A7D5E78559103093Q002508ED61EACCBC110F03073Q00DA777CAF3EA8B9030A3Q0088F150F6A0FD49CDABE303043Q00A4C5902803073Q0048617354696572026Q003F40026Q00104003063Q00A2C086BDDCA403063Q00D6E390CAEBBD03093Q00DFB1A54432A6553AFE03083Q005C8DC5E71B70D333030A3Q00CBFE9291D4EBFE83ADC203053Q00B1869FEAC3026Q001C40030B3Q008EE33EA4C6AACF3EAECAB803053Q00A9DD8B5FC0030F3Q00432Q6F6C646F776E52656D61696E7303063Q00E88A7136312E03063Q0046BEEB1F5F42025Q00F6AB40025Q00D07F40030C3Q00526F2Q6C746865426F6E6573025Q00C07A40025Q00788E40025Q00EEA740025Q00607840025Q00D6A740025Q00C0A340025Q00AC9B40025Q0060804003103Q0088E70EF3F7B4D112E9F0B6E619E7F6AE03053Q0085DA827A86024Q00D041134103133Q001FFEF0D09C913730F3A3D0D4A6781EF0EDC1CF03073Q00585C9F83A4BCC3030D3Q00AB2BBA5BFEFFEF8F22B342D9EC03073Q00BDE04EDF2BB78B03083Q0042752Q66446F776E030B3Q00536861646F7744616E6365026Q001840025Q0011B140025Q0037B240025Q00E06B40025Q004CB040030D3Q004B2Q65704974526F2Q6C696E67025Q0024B240025Q000C9A40025Q00A89040025Q0094B140025Q004AA04003103Q001CF99E03D320CF8219D422F88917D23A03053Q00A14E9CEA76024Q009450174103143Q0084B6DAC8E79CCCD9B7F7C0C8E785C6D0ABBEC7DB03043Q00BCC7D7A9030D3Q00DB015068FCF0106C6FFAF5025A03053Q00889C693F1B030D3Q003C8476270F8060070F9E703F1E03043Q00547BEC19030D3Q0047686F73746C79537472696B65030E3Q0049735370652Q6C496E52616E6765025Q00B6B040025Q0044A040025Q00D49340025Q00507E40025Q00A0A440025Q006C9940025Q0072B040025Q00689E4003103Q00C28EBE02BEBBC383A502A0B1F38AB92Q03063Q00D590EBCA77CC024Q00480A084103134Q0019CD3E6804452C0BCA2631637E370AD7212D03073Q002D4378BE4A484303063Q001327FDB6F09B03083Q008940428DC599E88E03063Q0030D532B5811003053Q00E863B042C603093Q00CF332905709EF123F803083Q004C8C4148661BED99030E3Q0068DF02C5D204B05ED213F7CE04AD03073Q00DE2ABA76B2B76103093Q007EFE458956FF4C854903043Q00EA3D8C2403113Q0046696C746572656454696D65546F44696503013Q003E026Q002640030E3Q00426574772Q656E7468654579657303183Q00426F2Q7346696C7465726564466967687452656D61696E7303013Q003C025Q00F07040025Q00FAA94003063Q00536570736973025Q00F49A40025Q007FB040025Q00A2A640025Q00E49740025Q0068B14003103Q0013D8AE671D2FEEB27D1A2DD9B9731C3503053Q006F41BDDA12024Q00C4091441030B3Q00604A08214B6FAA5358122603073Q00CF232B7B556B3C03073Q0053A5ADE7767EB903053Q001910CAC08A03073Q00D8C5ACE0A5F1F903063Q00949DABCD82C9030D3Q0001DB603DDEFB17C67D27DAF33703063Q009643B41449B103073Q00AE2Q174082160903043Q002DED787A03073Q00F2E6A32EDBEDA603043Q004CB788C2030A3Q004EE9F50C42461A71E3F103073Q00741A868558302F025Q0010AA40025Q0018A040025Q00F89A40025Q00549540025Q00049B40025Q0090A140030F3Q0033C0AEEDBE550CC8A5E2A97D0CC2A803063Q00127EA1C084DD030E3Q00427970612Q735265636F76657279026Q00F03F025Q00707E40025Q002Q704003023Q00037503053Q00363F48CE64025Q00A09440025Q00407E40030F3Q004D616E69634772696566746F72636803093Q004973496E52616E6765026Q004440025Q00A09740025Q00A8A340030F3Q00E5584B73E65CDA50407CF174DA5A4D03063Q001BA839251A8503023Q00494403073Q000EA571A5D823B903053Q00B74DCA1CC803073Q00323D880A1B368D03043Q00687753E9030A3Q00C1F7371651FCF62C275703053Q002395984742025Q00E09140025Q004CA040025Q008EB140025Q004AAF40025Q00689640025Q00B89B40025Q00A0AA40025Q00A0AE40025Q00C07740025Q0073B34003103Q002BED56A52817DB4ABF2F15EC41B1290D03053Q005A798822D0026Q00384003143Q00EA0F5B17C44E720CCE0B530AC81C5616871A5A0E03043Q007EA76E35025Q00F49F40025Q0022AB40030F3Q00101120F1DF182F192BFEC8302F132603063Q005F5D704E98BC03073Q00E2FA8818EBB0C103073Q00B2A195E57584DE03073Q00ADD5DCAEAD13A203083Q0043E8BBBDCCC176C6030D3Q00A921A12Q340FDB9927BB2B3E1603073Q008FEB4ED5405B62025Q00B88A40025Q00F88E40025Q005EB240025Q00F5B040025Q00449C40025Q00606B40025Q0002AB4003103Q00BF4D90FC62B8BE408BFC7CB28E4997FD03063Q00D6ED28E48910026Q00394003143Q00A8E2E1D000E6A2F1E6DC05B28AF1ECD143A48AF303063Q00C6E5838FB963025Q00F0924003113Q007389A9705E829C7C6584AD515495A77D5503043Q001331ECC803123Q004973457175692Q706564416E645265616479025Q00B3B040025Q00BAA04003113Q00426561636F6E546F5468654265796F6E6403093Q00DD38FBBAEBB4ED13C503063Q00DA9E5796D784030C3Q00DF17CAF23A23D4C80AC0EE3303073Q00AD9B7EB982564203083Q005472696E6B657473025Q0004AC40025Q00F0AE4003113Q00C7A3BBC487E2D1A98ECF8DCEE0BFB5C98C03063Q008C85C6DAA7E803073Q009621B9708BBB3D03053Q00E4D54ED41D03073Q00A242B707E7824803053Q008BE72CD665030A3Q00EDE0166A02B83F1DDCFB03083Q0076B98F663E70D151025Q00F07D40025Q0090A740025Q00C8AF40025Q00A07F4003103Q006E753DF3B71B2F30536525E2A6140F2C03083Q00583C104986C5757C03163Q0072EFF9CB4E5EDEF7FC4955C8FDD14E5EEEB888555FFA03053Q0021308A98A8025Q00109B40025Q0064B240025Q0006AA40025Q0038A74003113Q0050133152CE3946190459C415770F3F5FC503063Q005712765031A103073Q006F11D7ADBF420D03053Q00D02C7EBAC003073Q00D214A5C418F9CD03083Q002E977AC4A6749CA9030D3Q00C7E2520EF4E8D95413F5EEE85203053Q009B858D267A03103Q00172FB8545D71962D25B94D4B7CA4363E03073Q00C5454ACC212F1F03163Q00D24A5B84FF416E88C4475FA5F5565589F40F1A85FF5F03043Q00E7902F3A03093Q0091CADB76132EC736A603083Q0059D2B8BA15785DAF030E3Q00935668C27C3FBF4774D05C23B44003063Q005AD1331CB519025Q00509740025Q00E4A140025Q00A6A240025Q0080A540025Q00A2AF40025Q002C9240025Q0068AB40025Q00A4A840025Q006AAD40025Q00C06840030A3Q00E4735EFDABDC7E63EBBE03053Q00DFB01B378E030A3Q0054686973746C65546561026Q005940030A3Q0010B3C7A630B7CB8121BA03043Q00D544DBAE03073Q0043686172676573025Q0042A340025Q00CEA440025Q00405340025Q00107A40025Q0080A040025Q00888D4003103Q0039E537F238CB0C7704F52FE329C42C6B03083Q001F6B8043874AA55F024Q00DC4A174103103Q00FBE9EF590185D0E1EF594DB498DCF94C03063Q00D1B8889C2D21025Q0034A140025Q00B2A640025Q00EC9240025Q0050A04003093Q0025C4740CBD35DD660003053Q00D867A8156803093Q00426C61646552757368025Q00208940025Q00405A4003103Q004AA857B16AA370AC77B84FA07BAC50B003043Q00C418CD23024Q0014981041030F3Q000D8AF0126EA9EF072A8EA3343B98EB03043Q00664EEB8303073Q00D92139494837A403083Q00549A4E54242759D703073Q00D8EF575A09F8E503053Q00659D81363803073Q002DA69EA22C770E03063Q00197DC9EACB43025Q0036A840025Q0060A540025Q00C9B240025Q00807040025Q00406A40025Q0048A340030E3Q00506F74696F6E53656C6563746564030B3Q00426C2Q6F646C7573745570030B3Q005EC1313011330770FA1F1003073Q007319947863744703073Q002B38B721530D3103053Q00216C5DD944030C3Q00F344ADA9EB44B5ABD459838103043Q00CDBB2BC1026Q003E40030B3Q00D9472CECFB6611D6F0751603043Q00BF9E126503073Q00E2C689B2BDC4CF03053Q00CFA5A3E7D7030C3Q00EEF6F552147FD2FFF644065C03063Q0010A62Q993644025Q0087B140025Q006EB040025Q00FCB140026Q003040025Q0050AB40025Q00689B40025Q00A07940025Q00188340025Q00D49740025Q00F3B040025Q00E06F40025Q00C0714003103Q00E0B6D453262FCADABCD54A3022F8C1A703073Q0099B2D3A0265441026Q00494003123Q0092044E228D051A288D04562F8D1C5438C25903043Q004BE26B3A025Q00E07940025Q0034A34003093Q007AD21E7515E4D84AC703073Q00AD38BE711A71A203093Q00426C2Q6F6446757279025Q00D89040025Q0008AD40025Q004DB140025Q00C08D40025Q00C07E40025Q00C07040025Q00B89A40025Q0050AC40025Q00F8AB40025Q0022A34003103Q00F9DB3910E5C5ED250AE2C7DA2E04E4DF03053Q0097ABBE4D65025Q0017D440030F3Q00E62EEBBDB85F07CA20FCE9DE6819DC03073Q006BA54F98C9981D030A3Q00754BFAD8516D5C47E6CC03063Q001F372E88AB34025Q00388840025Q00708540025Q00709D40025Q00989540030A3Q004265727365726B696E67025Q00CCAD40025Q00909E40025Q00406640025Q00B6A640025Q00F49540025Q00E09640025Q00B8A64003103Q00E32DC8E1C326EFFCDE3DD0F0D229CFE003043Q0094B148BC024Q0040AED940030F3Q0085B744C7E69452C1B5B345D8AFB85003043Q00B3C6D637025Q000CA240025Q00805B40025Q00E49940025Q0050A84003093Q00D605607347DFFF037603063Q00B3906C121625025Q0008A740026Q00584003093Q0046697265626C2Q6F64025Q00E2A340025Q0088AE40026Q007140025Q0040724003103Q00F4A60F9CDDC8901386DACAA71888DCD203053Q00AFA6C37BE9024Q0014301041030E3Q00CCC34E5DB0C9CB4F4CF2E3CD524D03053Q00908FA23D29025Q00107340025Q000C9940030D3Q00C1DD1E55619321E1DF3E517E8B03073Q005380B37D3012E7025Q00507840025Q00808940030D3Q00416E6365737472616C43612Q6C025Q00B4A740025Q00B4A140025Q00A08C40025Q00B89940025Q00C6A94003103Q006FB2E7C855106EBFFCC84B1A5EB6E0C903063Q007E3DD793BD27024Q00C8C4104103133Q005BFE0E5138DE13467DEC095779F35D6679F31103043Q0025189F7D03073Q00F9A9784FD5A86603043Q0022BAC61503073Q00DD06C45FCEFD0C03053Q00A29868A53D030D3Q00EF20A6697FE8F93DBB737BE0D903063Q0085AD4FD21D1003073Q00AE73E0268272FE03043Q004BED1C8D03073Q00F951CDB3231EE303083Q0081BC3FACD14F7B87030A3Q0074EBF6F952EDE8C645F003043Q00AD208486025Q00609240025Q00C88C40025Q0076A640030F3Q0047657455736561626C654974656D73025Q00C89C40025Q00B89040025Q00409040025Q000CAF4003173Q006A2Q09E8A13FCB47090DCDA13CCF6A121BFFAB3FDE4B0903073Q00AD2E7B688FCE51026Q002440026Q003440030B3Q00486173432Q6F6C646F776E025Q003C9140025Q007C9E4003173Q00447261676F6E66697265426F6D6244697370656E736572025Q00C89740025Q00F8A34003173Q00900F238D4A8D07BD0F27A84A8E039014319A408D12B10F03073Q0061D47D42EA25E303073Q00A9ECBB381184F003053Q007EEA83D65503073Q00A1DB48584381D103053Q002FE4B5293A030A3Q0092F3C90F113911ADF9CD03073Q007FC69CB95B6350025Q00F8AF40025Q00108740025Q00FEA640025Q00EAA940025Q00DC9F40025Q001AAE40025Q00F2A740025Q007AA940025Q00E89B40025Q0028A14003103Q00C71FD8E5B5050AD6FA0FC0F4A40A2ACA03083Q00BE957AAC90C76B59031D3Q001617F0F9F13C03F8ECFB7227FEF3FC7221F8EDEE370BE2FBEC7211FEEE03053Q009E5265919E03173Q0054EC03114B7EF80B044152F10F146079ED12134A63FB1003053Q0024109E627603073Q00E319CEF657E63403083Q0085A076A39B38884703073Q00D3AC70F0BA1AB103073Q00D596C21192D67F030D3Q0039A6B0C049A9962412A7AFD15203083Q00567BC9C4B426C4C2025Q00C89B40025Q003CAD40025Q00089540025Q0090AA40025Q0082A140025Q00408C40025Q00849540025Q000EA74003103Q00C5EDCDBAE5E6EAA7F8FDD5ABF4E9CABB03043Q00CF9788B9031D3Q008C9129857B7677A1912DC256777CAAC30C8B676874A6902D90347A7EB803073Q0011C8E348E21418025Q00E49340025Q004CA840025Q00BCB040026Q007D40025Q003EB240025Q0038B040030F3Q00835514C5C4D4EEEBB55308F5C6FEE103083Q009FD0217BB7A9918F03073Q00D155353BFD542B03043Q0056923A5803073Q007DD1EBC2A2EC3203083Q009A38BF8AA0CE8956030A3Q00B256E5B36E338FC7834D03083Q00ACE63995E71C5AE1025Q00E08D40025Q00F0AF40025Q00C1B140025Q00C06D40025Q0072AB40025Q0092A840025Q0014A74003103Q0030AF92C73AD531A289C724DF01AB95C603063Q00BB62CAE6B24803133Q0012F5AB224704E0B0355832C3AB3F4461F5AB2003053Q002A4181C450030F3Q00315E52C81A2203FA07584EF818080C03083Q008E622A3DBA77676203073Q001BB00F0537B11103043Q006858DF6203073Q0061F9E3CC0EE84003063Q008D249782AE62030D3Q00A675D6198B77F61F8D74C9089003043Q006DE41AA203103Q006CE0E96DF2E86DEDF26DECE25DE4EE6C03063Q00863E859D188003133Q0034B115CB2294D713A008CA0DBED909E518D63F03073Q00B667C57AB94FD1025Q00F88240025Q00E7B04003113Q00C48EEF73134BF295D67F055CE093EE790503063Q002893E7811760026Q004640025Q00B6AE40025Q00B0AD40025Q00E88B4003113Q0057696E64736361725768657473746F6E65025Q0022AD40025Q0052A240025Q00708C40025Q0008AB4003113Q0042F18241A8AFDD67CF8440AFBFC87AF68903073Q00BC1598EC25DBCC03073Q0063E63A014FE72403043Q006C20895703073Q008FE601A423FC4F03083Q0039CA8860C64F992B030A3Q009F2CBA939FAEF6A026BE03073Q0098CB43CAC7EDC7025Q00FEA040025Q0006AB40025Q00C08040025Q00E88E40026Q005B4003103Q00C846B41A0D7B4AEEF556AC0B1C746AF203083Q00869A23C06F7F151903153Q008F2F070E33D1B9343E0225C6AB3206042592AC291903063Q00B2D846696A4003113Q00082274F2DAD6D59208237FE2DAC1DB8E3A03083Q00E05F4B1A96A9B5B403073Q00282QD5254BA26503073Q00166BBAB84824CC03073Q00C2B3254C02E2B903053Q006E87DD442E030D3Q00C13918FFC1BE0FF13F02E0CBA703073Q005B83566C8BAED3025Q00588F40025Q00509840025Q0039B140025Q00D0AA40025Q0070AC4003103Q00C92EAC024FF518B01848F72FBB164EEF03053Q003D9B4BD87703153Q0033A2BC384B0ADC169CBA394C1AC90BA5B77C5A06CD03073Q00BD64CBD25C3869025Q003BB240025Q0090A440025Q00DAAC40025Q00788440025Q00749740030A3Q004F6E5573655370652Q6C030C3Q000250E5212244F01A2E5FFA2D03043Q00484F319D030C3Q00A5B129B585A53C8E89BE36B903043Q00DCE8D051030C3Q00D8BFFD39214FACC7BFEB372903073Q00C195DE85504C3A025Q00E49A40030D3Q0048617353746174416E79447073025Q008EAE40025Q00A06040025Q0038A840025Q00C0A840025Q006AA640025Q00C06440025Q0068A54003123Q00476574496E76656E746F72794974656D494403063Q00D6514ECBC34F03043Q00B2A63D2F026Q002A4003073Q00D845E577C530E803063Q005E9B2A881AAA03073Q00A13127B7883A2203043Q00D5E45F46030A3Q001EB4D2B06523B5C9816303053Q00174ADBA2E4025Q00C6A340025Q00588A40025Q00849340025Q0094A940025Q003AA140025Q004AB140025Q00E6A240025Q00C05740025Q0084A54003103Q000BE352BA2937D54EA02E35E245AE282D03053Q005B598626CF03163Q0063EBC63301D92404FBDB332CD93341E3DB7615DF350403073Q0047248EA85673B003043Q004E616D6503063Q00CFAD73A606AC03083Q0029BFC112DF63DE36026Q002C4003073Q008829CA272QA53503053Q00CACB46A74A03073Q00090FDD317D290503053Q00114C61BC53030D3Q00A728CD233F8E7FB18C29D2322403083Q00C3E547B95750E32B025Q002AA340025Q002FB340025Q00F08640025Q00249C40025Q0010A940025Q00CEAD40025Q0032B340025Q0018844003103Q00D2F91445FDEECF085FFAECF80351FCF403053Q008F809C603003163Q009FD4FE1705B1D2B00704BDEEF90612B5C2B01418AA9103053Q0077D8B1907200B60A2Q002E710002005B00010001000426012Q005B00012Q007B7Q000657012Q005B00013Q000426012Q005B00012Q007B3Q00014Q004B2Q0100023Q00122Q000200033Q00122Q000300046Q0001000300028Q000100206Q00056Q0002000200064Q005B00013Q000426012Q005B00012Q007B3Q00033Q0020AB014Q00064Q000200013Q00202Q0002000200076Q0002000200064Q002400010001000426012Q002400012Q007B3Q00044Q0033012Q00010002000657012Q004200013Q000426012Q004200012Q007B3Q00014Q004B2Q0100023Q00122Q000200083Q00122Q000300096Q0001000300028Q000100206Q000A6Q0002000200064Q004200013Q000426012Q004200012Q007B3Q00033Q002052014Q000B4Q000200016Q000300018Q0003000200064Q005B00013Q000426012Q005B00012Q007B3Q00014Q004B2Q0100023Q00122Q0002000C3Q00122Q0003000D6Q0001000300028Q000100206Q000A6Q0002000200064Q005B00013Q000426012Q005B00012Q007B3Q00014Q004B2Q0100023Q00122Q0002000E3Q00122Q0003000F6Q0001000300028Q000100206Q000A6Q0002000200064Q005B00013Q000426012Q005B00012Q007B3Q00053Q0026A53Q005B00010010000426012Q005B00012Q007B3Q00063Q0020345Q00114Q000100013Q00202Q0001000100074Q000200028Q0002000200064Q005B00013Q000426012Q005B000100126C3Q00123Q000E620012004F00013Q000426012Q004F0001002E5D0014004B00010013000426012Q004B00012Q007B000100064Q00E2000200023Q00122Q000300153Q00122Q000400166Q00020004000200202Q0001000200174Q000100023Q00122Q000200183Q00122Q000300196Q000100036Q00015Q00044Q004B00012Q007B3Q00014Q0022000100023Q00122Q0002001A3Q00122Q0003001B6Q0001000300028Q000100206Q001C6Q0002000200064Q006700010001000426012Q00670001002E71001D00B80001001E000426012Q00B800012Q007B3Q00074Q008A000100086Q000200016Q000300023Q00122Q0004001F3Q00122Q000500206Q0003000500024Q00020002000300202Q00020002000A4Q00020002000200062Q0002008200013Q000426012Q008200012Q007B000200033Q00204101020002000B4Q000400016Q000500016Q00020005000200062Q0002008000010001000426012Q008000012Q007B000200033Q0020950002000200064Q000400013Q00202Q0004000400074Q00020004000200044Q008200012Q007A00026Q0077000200014Q007200010002000200100F2Q01001000010006C6000100B800013Q000426012Q00B800012Q007B3Q00033Q0020A6014Q00214Q000200013Q00202Q0002000200226Q000200024Q000100033Q00202Q0001000100234Q00010002000200064Q00B800010001000426012Q00B800012Q007B3Q00063Q00203B5Q00114Q000100013Q00202Q0001000100226Q0002000200064Q009B00010001000426012Q009B0001002E4D0124009B00010025000426012Q009B0001002E71002600B800010027000426012Q00B8000100126C3Q00124Q003A000100013Q0026C53Q00A100010012000426012Q00A10001002E04012800FEFF2Q0029000426012Q009D000100126C000100123Q002E5D002B00A20001002A000426012Q00A200010026AB000100A200010012000426012Q00A2000100126C000200123Q0026AB000200A700010012000426012Q00A700012Q007B000300064Q00E2000400023Q00122Q0005002C3Q00122Q0006002D6Q00040006000200202Q00030004002E4Q000300023Q00122Q0004002F3Q00122Q000500306Q000300056Q00035Q00044Q00A70001000426012Q00A20001000426012Q00B80001000426012Q009D00012Q007B3Q00014Q0022000100023Q00122Q000200313Q00122Q000300326Q0001000300028Q000100206Q001C6Q0002000200064Q00C400010001000426012Q00C40001002E5D003300182Q010034000426012Q00182Q012Q007B3Q00014Q004B2Q0100023Q00122Q000200353Q00122Q000300366Q0001000300028Q000100206Q000A6Q0002000200064Q00F000013Q000426012Q00F000012Q007B3Q00044Q0033012Q0001000200067C3Q00F000010001000426012Q00F000012Q007B3Q00073Q000E66013700ED00013Q000426012Q00ED00012Q007B3Q00094Q00CD0001000A6Q000200076Q000300086Q000400033Q00202Q0004000400064Q000600013Q00202Q0006000600384Q000400066Q00038Q00013Q00022Q00CD0002000B6Q000300076Q000400086Q000500033Q00202Q0005000500064Q000700013Q00202Q0007000700384Q000500076Q00048Q00023Q00022Q00432Q0100010002000623012Q00F200010001000426012Q00F200012Q007B3Q00073Q000E9C013900F200013Q000426012Q00F20001002E5D003A00182Q01003B000426012Q00182Q012Q007B3Q00063Q002047014Q00114Q000100013Q00202Q0001000100226Q0002000200064Q00182Q013Q000426012Q00182Q0100126C3Q00124Q003A000100013Q002E04013C3Q0001003C000426012Q00FB00010026AB3Q00FB00010012000426012Q00FB000100126C000100123Q002E04013D3Q0001003D000426013Q002Q01000ED300122Q002Q010001000426013Q002Q0100126C000200123Q002E5D003F00052Q01003E000426012Q00052Q010026AB000200052Q010012000426012Q00052Q012Q007B000300064Q00E2000400023Q00122Q000500403Q00122Q000600416Q00040006000200202Q00030004002E4Q000300023Q00122Q000400423Q00122Q000500436Q000300056Q00035Q00044Q00052Q01000426013Q002Q01000426012Q00182Q01000426012Q00FB0001002E5D0044009F2Q010045000426012Q009F2Q01002E710046009F2Q010047000426012Q009F2Q012Q007B3Q00014Q004B2Q0100023Q00122Q000200483Q00122Q000300496Q0001000300028Q000100206Q001C6Q0002000200064Q009F2Q013Q000426012Q009F2Q01002E71004B009F2Q01004A000426012Q009F2Q012Q007B3Q000C4Q0033012Q0001000200067C3Q006F2Q010001000426012Q006F2Q012Q007B3Q000D4Q0033012Q000100020026C53Q006F2Q010012000426012Q006F2Q012Q007B3Q000E4Q0042000100023Q00122Q0002004C3Q00122Q0003004D6Q0001000300028Q00014Q000100023Q00122Q0002004E3Q00122Q0003004F6Q0001000300028Q00014Q000100023Q00122Q000200503Q00122Q000300516Q0001000300028Q000100264Q00492Q010037000426012Q00492Q012Q007B3Q00033Q00205F014Q005200122Q000200533Q00122Q000300548Q0003000200064Q006F2Q010001000426012Q006F2Q012Q007B3Q000E4Q0042000100023Q00122Q000200553Q00122Q000300566Q0001000300028Q00014Q000100023Q00122Q000200573Q00122Q000300586Q0001000300028Q00014Q000100023Q00122Q000200593Q00122Q0003005A6Q0001000300028Q000100264Q009F2Q01005B000426012Q009F2Q012Q007B3Q00014Q00872Q0100023Q00122Q0002005C3Q00122Q0003005D6Q0001000300028Q000100206Q005E6Q000200020026163Q006F2Q010037000426012Q006F2Q012Q007B3Q00014Q0084000100023Q00122Q0002005F3Q00122Q000300606Q0001000300028Q000100206Q005E6Q0002000200264Q009F2Q010037000426012Q009F2Q01002E5D0062009F2Q010061000426012Q009F2Q012Q007B3Q00063Q00203B5Q00114Q000100013Q00202Q0001000100636Q0002000200064Q007A2Q010001000426012Q007A2Q01002E040164002700010065000426012Q009F2Q0100126C3Q00124Q003A000100013Q0026C53Q00802Q010012000426012Q00802Q01002E5D0066007C2Q010067000426012Q007C2Q0100126C000100123Q0026C5000100872Q010012000426012Q00872Q01002ED2006800872Q010069000426012Q00872Q01002E5D006A00812Q01006B000426012Q00812Q0100126C000200124Q003A000300033Q0026AB000200892Q010012000426012Q00892Q0100126C000300123Q000ED30012008C2Q010003000426012Q008C2Q012Q007B000400064Q00E2000500023Q00122Q0006006C3Q00122Q0007006D6Q00050007000200202Q00040005006E4Q000400023Q00122Q0005006F3Q00122Q000600706Q000400066Q00045Q00044Q008C2Q01000426012Q00812Q01000426012Q00892Q01000426012Q00812Q01000426012Q009F2Q01000426012Q007C2Q012Q007B3Q00014Q004B2Q0100023Q00122Q000200713Q00122Q000300726Q0001000300028Q000100206Q001C6Q0002000200064Q00D12Q013Q000426012Q00D12Q012Q007B3Q000C4Q0033012Q0001000200067C3Q00D12Q010001000426012Q00D12Q012Q007B3Q000D4Q005A3Q000100024Q0001000A3Q00122Q000200376Q000300086Q000400033Q00202Q00040004005200122Q000600533Q00122Q000700546Q000400076Q00036Q009C00013Q00022Q00560002000B3Q00122Q000300376Q000400086Q000500033Q00202Q00050005005200122Q000700533Q00122Q000800546Q000500086Q00048Q00023Q00022Q00432Q01000100020006C6000100D12Q013Q000426012Q00D12Q012Q007B3Q00033Q0020AB014Q00734Q000200013Q00202Q0002000200746Q0002000200064Q00D32Q010001000426012Q00D32Q012Q007B3Q000D4Q0033012Q00010002000E9C017500D32Q013Q000426012Q00D32Q01002E5D0077002Q02010076000426012Q002Q0201002E5D0078002Q02010079000426012Q002Q02012Q007B3Q00063Q0020345Q00114Q000100013Q00202Q00010001007A4Q000200028Q0002000200064Q002Q02013Q000426012Q002Q020100126C3Q00124Q003A000100013Q002E04017B3Q0001007B000426012Q00DF2Q010026AB3Q00DF2Q010012000426012Q00DF2Q0100126C000100123Q0026AB000100E42Q010012000426012Q00E42Q0100126C000200124Q003A000300033Q002E5D007D00E82Q01007C000426012Q00E82Q01000ED3001200E82Q010002000426012Q00E82Q0100126C000300123Q0026C5000300F12Q010012000426012Q00F12Q01002E04017E00FEFF2Q007F000426012Q00ED2Q012Q007B000400064Q00E2000500023Q00122Q000600803Q00122Q000700816Q00050007000200202Q0004000500824Q000400023Q00122Q000500833Q00122Q000600846Q000400066Q00045Q00044Q00ED2Q01000426012Q00E42Q01000426012Q00E82Q01000426012Q00E42Q01000426012Q002Q0201000426012Q00DF2Q012Q007B3Q00014Q004B2Q0100023Q00122Q000200853Q00122Q000300866Q0001000300028Q000100206Q000A6Q0002000200064Q004802013Q000426012Q004802012Q007B3Q00014Q004B2Q0100023Q00122Q000200873Q00122Q000300886Q0001000300028Q000100206Q001C6Q0002000200064Q004802013Q000426012Q004802012Q007B3Q000F3Q0026BC3Q00480201005B000426012Q004802012Q007B3Q00063Q002067014Q00114Q000100013Q00202Q0001000100894Q000200036Q000400103Q00202Q00040004008A4Q000600013Q00202Q0006000600894Q0004000600024Q000400044Q00A8012Q0004000200067C3Q002902010001000426012Q00290201002E5D008B00480201008C000426012Q0048020100126C3Q00124Q003A000100013Q0026C53Q002F02010012000426012Q002F0201002E04018D00FEFF2Q008E000426012Q002B020100126C000100123Q000E620012003402010001000426012Q00340201002E04018F00FEFF2Q0090000426012Q0030020100126C000200123Q0026C50002003902010012000426012Q00390201002E5D0091003502010092000426012Q003502012Q007B000300064Q00E2000400023Q00122Q000500933Q00122Q000600946Q00040006000200202Q0003000400954Q000300023Q00122Q000400963Q00122Q000500976Q000300056Q00035Q00044Q00350201000426012Q00300201000426012Q00480201000426012Q002B02012Q007B3Q00114Q0033012Q00010002000657012Q00CD02013Q000426012Q00CD02012Q007B3Q00014Q004B2Q0100023Q00122Q000200983Q00122Q000300996Q0001000300028Q000100206Q000A6Q0002000200064Q00CD02013Q000426012Q00CD02012Q007B3Q00014Q004B2Q0100023Q00122Q0002009A3Q00122Q0003009B6Q0001000300028Q000100206Q001C6Q0002000200064Q00CD02013Q000426012Q00CD02012Q007B3Q00014Q004B2Q0100023Q00122Q0002009C3Q00122Q0003009D6Q0001000300028Q000100206Q000A6Q0002000200064Q007F02013Q000426012Q007F02012Q007B3Q00014Q004B2Q0100023Q00122Q0002009E3Q00122Q0003009F6Q0001000300028Q000100206Q001C6Q0002000200064Q007F02013Q000426012Q007F02012Q007B3Q00044Q0033012Q00010002000657012Q007F02013Q000426012Q007F02012Q007B3Q00033Q002052014Q000B4Q000200016Q000300018Q0003000200064Q009E02013Q000426012Q009E02012Q007B3Q00014Q0022000100023Q00122Q000200A03Q00122Q000300A16Q0001000300028Q000100206Q000A6Q0002000200064Q009702010001000426012Q009702012Q007B3Q00103Q00204F5Q00A200122Q000200A33Q00122Q000300A48Q0003000200064Q009702013Q000426012Q009702012Q007B3Q00033Q0020AB014Q00064Q000200013Q00202Q0002000200A56Q0002000200064Q009E02010001000426012Q009E02012Q007B3Q00123Q00207C014Q00A600122Q000100A73Q00122Q000200A48Q0002000200064Q00CD02013Q000426012Q00CD0201002E7100A800CD020100A9000426012Q00CD02012Q007B3Q00063Q002039014Q00114Q000100013Q00202Q0001000100AA4Q000200036Q000400103Q00202Q00040004008A4Q000600013Q00202Q0006000600AA4Q0004000600024Q000400048Q0004000200064Q00CD02013Q000426012Q00CD020100126C3Q00124Q003A000100013Q002E0401AB3Q000100AB000426012Q00B00201002E5D00AD00B0020100AC000426012Q00B00201000ED3001200B002013Q000426012Q00B0020100126C000100123Q002E5D00AE00B7020100AF000426012Q00B70201000ED3001200B702010001000426012Q00B7020100126C000200123Q0026AB000200BC02010012000426012Q00BC02012Q007B000300064Q00E2000400023Q00122Q000500B03Q00122Q000600B16Q00040006000200202Q0003000400B24Q000300023Q00122Q000400B33Q00122Q000500B46Q000300056Q00035Q00044Q00BC0201000426012Q00B70201000426012Q00CD0201000426012Q00B002012Q007B3Q00134Q006F2Q0100023Q00122Q000200B53Q00122Q000300B66Q0001000300028Q00014Q000100023Q00122Q000200B73Q00122Q000300B86Q0001000300028Q00014Q000100023Q00122Q000200B93Q00122Q000300BA6Q0001000300028Q000100064Q00F302010001000426012Q00F302012Q007B3Q00134Q006F2Q0100023Q00122Q000200BB3Q00122Q000300BC6Q0001000300028Q00014Q000100023Q00122Q000200BD3Q00122Q000300BE6Q0001000300028Q00014Q000100023Q00122Q000200BF3Q00122Q000300C06Q0001000300028Q000100064Q00F302010001000426012Q00F30201002E5D00C1006F040100C2000426012Q006F040100126C3Q00123Q0026C53Q00F802010012000426012Q00F80201002E7100C300F4020100C4000426012Q00F40201002E7100C500B2030100C6000426012Q00B203012Q007B000100144Q006A010200023Q00122Q000300C73Q00122Q000400C86Q0002000400024Q0001000100020020AC00010001005E0012B9000300C94Q00A82Q010003000200261600010007030100CA000426012Q00070301002E5D00CB00B2030100CC000426012Q00B203012Q007B000100033Q0020412Q010001000B4Q000300016Q000400016Q00010004000200062Q0001001503010001000426012Q001503012Q007B000100033Q0020AB2Q01000100064Q000300013Q00202Q0003000300A54Q00010003000200062Q0001002103010001000426012Q002103012Q007B000100123Q00205B0001000100A64Q000200023Q00122Q000300CD3Q00122Q000400CE6Q00020004000200122Q000300396Q00010003000200062Q0001002103010001000426012Q00210301002E5D00CF00B2030100D0000426012Q00B203012Q007B000100063Q0020380001000100114Q000200143Q00202Q0002000200D14Q000300046Q000500103Q00202Q0005000500D200122Q000700D36Q0005000700024Q000500056Q00010005000200067C0001003003010001000426012Q00300301002E5D00D500B2030100D4000426012Q00B203012Q007B000100144Q0025010200023Q00122Q000300D63Q00122Q000400D76Q0002000400024Q00010001000200202Q0001000100D84Q0001000200024Q000200153Q00062Q0001004D03010002000426012Q004D03012Q007B000100134Q006F010200023Q00122Q000300D93Q00122Q000400DA6Q0002000400024Q0001000100024Q000200023Q00122Q000300DB3Q00122Q000400DC6Q0002000400024Q0001000100024Q000200023Q00122Q000300DD3Q00122Q000400DE6Q0002000400024Q00010001000200062Q0001004F03010001000426012Q004F0301002E5D00E00071030100DF000426012Q0071030100126C000100124Q003A000200023Q002E7100E20055030100E1000426012Q005503010026C50001005703010012000426012Q00570301002E5D00E40051030100E3000426012Q0051030100126C000200123Q0026C50002005C03010012000426012Q005C0301002E7100E60058030100E5000426012Q0058030100126C000300123Q0026C50003006103010012000426012Q00610301002E0401E700FEFF2Q00E8000426012Q005D03012Q007B000400064Q00E2000500023Q00122Q000600E93Q00122Q000700EA6Q00050007000200202Q0004000500EB4Q000400023Q00122Q000500EC3Q00122Q000600ED6Q000400066Q00045Q00044Q005D0301000426012Q00580301000426012Q00B20301000426012Q00510301000426012Q00B20301002E5D00EE00B2030100EF000426012Q00B203012Q007B000100144Q0025010200023Q00122Q000300F03Q00122Q000400F16Q0002000400024Q00010001000200202Q0001000100D84Q0001000200024Q000200163Q00062Q000100B203010002000426012Q00B203012Q007B000100134Q0039000200023Q00122Q000300F23Q00122Q000400F36Q0002000400024Q0001000100024Q000200023Q00122Q000300F43Q00122Q000400F56Q0002000400024Q0001000100024Q000200023Q00122Q000300F63Q00122Q000400F76Q0002000400024Q00010001000200062Q000100B203013Q000426012Q00B2030100126C000100123Q0026C50001009503010012000426012Q00950301002E7100F90091030100F8000426012Q0091030100126C000200124Q003A000300033Q002E7100C40097030100FA000426012Q00970301000ED30012009703010002000426012Q0097030100126C000300123Q002E5D00FC009C030100FB000426012Q009C03010026C5000300A203010012000426012Q00A20301002E7100FE009C030100FD000426012Q009C03012Q007B000400064Q0041000500023Q00122Q000600FF3Q00122Q00072Q00015Q00050007000200122Q0006002Q015Q0004000500064Q000400023Q00122Q00050002012Q00122Q00060003015Q000400066Q00045Q00044Q009C0301000426012Q00910301000426012Q00970301000426012Q0091030100126C00010004012Q00126C00020004012Q0006ED000100C103010002000426012Q00C103012Q007B000100144Q0097010200023Q00122Q00030005012Q00122Q00040006015Q0002000400024Q00010001000200122Q00030007015Q0001000100034Q00010002000200062Q000100C503010001000426012Q00C5030100126C00010008012Q00126C00020009012Q00068F2Q01006F04010002000426012Q006F04012Q007B000100033Q0020412Q010001000B4Q000300016Q000400016Q00010004000200062Q000100D303010001000426012Q00D303012Q007B000100033Q0020AB2Q01000100064Q000300013Q00202Q0003000300A54Q00010003000200062Q000100DA03010001000426012Q00DA03012Q007B000100123Q00207C2Q01000100A600122Q000200A73Q00122Q000300396Q00010003000200062Q0001006F04013Q000426012Q006F04012Q007B000100063Q0020820001000100112Q007B000200143Q00126C0003000A013Q00040002000200032Q003A000300034Q0015010400136Q000500023Q00122Q0006000B012Q00122Q0007000C015Q0005000700024Q0004000400052Q006A010500023Q00122Q0006000D012Q00122Q0007000E015Q0005000700024Q00040004000500126C0005000F013Q00040004000400052Q007B000500103Q0020AC0005000500D200126C000700D34Q00A80105000700022Q00E1000500054Q00A82Q010005000200067C000100F903010001000426012Q00F9030100126C00010010012Q00126C00020011012Q00068F0102006F04010001000426012Q006F04012Q007B000100144Q0025010200023Q00122Q00030012012Q00122Q00040013015Q0002000400024Q00010001000200202Q0001000100D84Q0001000200024Q000200153Q00062Q0001001604010002000426012Q001604012Q007B000100134Q006F010200023Q00122Q00030014012Q00122Q00040015015Q0002000400024Q0001000100024Q000200023Q00122Q00030016012Q00122Q00040017015Q0002000400024Q0001000100024Q000200023Q00122Q00030018012Q00122Q00040019015Q0002000400024Q00010001000200062Q0001001A04010001000426012Q001A040100126C0001001A012Q00126C0002001B012Q00068F0102003004010001000426012Q0030040100126C000100123Q00126C000200123Q0006232Q01002204010002000426012Q0022040100126C0002001C012Q00126C0003001D012Q0006ED0002001B04010003000426012Q001B04012Q007B000200064Q0041000300023Q00122Q0004001E012Q00122Q0005001F015Q00030005000200122Q000400EB6Q0002000300044Q000200023Q00122Q00030020012Q00122Q00040021015Q000200046Q00025Q00044Q001B0401000426012Q006F040100126C00010022012Q00126C00020023012Q0006C60001006F04010002000426012Q006F040100126C00010024012Q00126C00020025012Q0006C60002006F04010001000426012Q006F04012Q007B000100144Q0025010200023Q00122Q00030026012Q00122Q00040027015Q0002000400024Q00010001000200202Q0001000100D84Q0001000200024Q000200163Q00062Q0001006F04010002000426012Q006F04012Q007B000100134Q0039000200023Q00122Q00030028012Q00122Q00040029015Q0002000400024Q0001000100024Q000200023Q00122Q0003002A012Q00122Q0004002B015Q0002000400024Q0001000100024Q000200023Q00122Q0003002C012Q00122Q0004002D015Q0002000400024Q00010001000200062Q0001006F04013Q000426012Q006F040100126C000100124Q003A000200023Q00126C000300123Q0006ED0001005704010003000426012Q0057040100126C000200123Q00126C000300123Q0006ED0003005B04010002000426012Q005B04012Q007B000300064Q0041000400023Q00122Q0005002E012Q00122Q0006002F015Q00040006000200122Q0005002Q015Q0003000400054Q000300023Q00122Q00040030012Q00122Q00050031015Q000300056Q00035Q00044Q005B0401000426012Q006F0401000426012Q00570401000426012Q006F0401000426012Q00F402012Q007B3Q00033Q002041014Q000B4Q000200016Q000300018Q0003000200064Q008A04010001000426012Q008A04012Q007B3Q00014Q004B2Q0100023Q00122Q00020032012Q00122Q00030033015Q0001000300028Q000100206Q000A6Q0002000200064Q009204013Q000426012Q009204012Q007B3Q00014Q0022000100023Q00122Q00020034012Q00122Q00030035015Q0001000300028Q000100206Q001C6Q0002000200064Q009204010001000426012Q0092040100126C3Q0036012Q00126C00010037012Q0006382Q01009204013Q000426012Q0092040100126C3Q0038012Q00126C00010039012Q00068F2Q0100AC04013Q000426012Q00AC040100126C3Q00123Q00126C0001003A012Q00126C0002003A012Q0006ED0001009304010002000426012Q0093040100126C000100123Q0006ED3Q009304010001000426012Q009304012Q007B000100184Q00C80001000100024Q000100173Q00122Q0001003B012Q00122Q0002003C012Q00062Q000100A404010002000426012Q00A404012Q007B000100173Q00067C000100A804010001000426012Q00A8040100126C0001003D012Q00126C0002003E012Q0006C6000200AC04010001000426012Q00AC04012Q007B000100174Q0030000100023Q000426012Q00AC0401000426012Q0093040100126C3Q003F012Q00126C0001003F012Q0006ED3Q000D05010001000426012Q000D05012Q007B3Q00114Q0033012Q00010002000657012Q00DB04013Q000426012Q00DB04012Q007B3Q00014Q004B2Q0100023Q00122Q00020040012Q00122Q00030041015Q0001000300028Q000100206Q00056Q0002000200064Q00DB04013Q000426012Q00DB04012Q007B3Q00033Q00200C014Q00064Q000200013Q00122Q00030042015Q0002000200036Q0002000200064Q00DB04010001000426012Q00DB04012Q007B3Q00193Q00126C00010043012Q0006922Q01001600013Q000426012Q00DF04012Q007B3Q00123Q0020AA014Q00A600122Q000100A76Q000200016Q000300023Q00122Q00040044012Q00122Q00050045015Q0003000500024Q00020002000300122Q00040046015Q0002000200044Q00020002000200122Q000300756Q0002000200036Q0002000200064Q00DF04010001000426012Q00DF040100126C3Q0047012Q00126C00010048012Q0006ED3Q000D05010001000426012Q000D05012Q007B3Q00063Q0020E55Q00114Q000100013Q00122Q00020042015Q0001000100024Q000200028Q0002000200064Q00EC04010001000426012Q00EC040100126C3Q0049012Q00126C0001004A012Q00068F2Q01000D05013Q000426012Q000D050100126C3Q00124Q003A000100013Q00126C000200123Q0006ED3Q00EE04010002000426012Q00EE040100126C000100123Q00126C0002004B012Q00126C0003004C012Q0006C6000300F204010002000426012Q00F2040100126C000200123Q0006ED000100F204010002000426012Q00F2040100126C000200123Q00126C000300123Q0006ED000200FA04010003000426012Q00FA04012Q007B000300064Q0041000400023Q00122Q0005004D012Q00122Q0006004E015Q00040006000200122Q0005004F015Q0003000400054Q000300023Q00122Q00040050012Q00122Q00050051015Q000300056Q00035Q00044Q00FA0401000426012Q00F20401000426012Q000D0501000426012Q00EE040100126C3Q0052012Q00126C00010053012Q0006C63Q006005010001000426012Q0060050100126C3Q0054012Q00126C00010055012Q0006C63Q006005010001000426012Q006005012Q007B3Q00014Q004B2Q0100023Q00122Q00020056012Q00122Q00030057015Q0001000300028Q000100206Q00056Q0002000200064Q006005013Q000426012Q006005012Q007B3Q001A3Q00126C000100543Q00068F2Q01006005013Q000426012Q006005012Q007B3Q00033Q002041014Q000B4Q000200016Q000300018Q0003000200064Q006005010001000426012Q006005012Q007B3Q00063Q002082014Q00114Q000100013Q00122Q00020058015Q0001000100024Q000200036Q000400103Q00202Q00040004008A4Q000600013Q00122Q00070058015Q0006000600074Q0004000600024Q000400048Q0004000200064Q006005013Q000426012Q0060050100126C3Q00124Q003A000100013Q00126C000200123Q0006ED3Q003C05010002000426012Q003C050100126C000100123Q00126C000200123Q0006230102004705010001000426012Q0047050100126C00020059012Q00126C0003005A012Q00068F0102004005010003000426012Q0040050100126C000200123Q00126C000300123Q0006ED0002004805010003000426012Q0048050100126C000300123Q00126C000400123Q0006ED0004004C05010003000426012Q004C05012Q007B000400064Q0041000500023Q00122Q0006005B012Q00122Q0007005C015Q00050007000200122Q0006005D015Q0004000500064Q000400023Q00122Q0005005E012Q00122Q0006005F015Q000400066Q00045Q00044Q004C0501000426012Q00480501000426012Q00400501000426012Q00600501000426012Q003C05012Q007B3Q00134Q006F2Q0100023Q00122Q00020060012Q00122Q00030061015Q0001000300028Q00014Q000100023Q00122Q00020062012Q00122Q00030063015Q0001000300028Q00014Q000100023Q00122Q00020064012Q00122Q00030065015Q0001000300028Q000100064Q007A05010001000426012Q007A050100126C3Q0066012Q00126C00010067012Q000638012Q007A05010001000426012Q007A050100126C3Q0068012Q00126C00010069012Q0006ED3Q001606010001000426012Q0016060100126C3Q00124Q003A000100013Q00126C000200123Q000623012Q008305010002000426012Q0083050100126C0002006A012Q00126C0003006B012Q0006C60003007C05010002000426012Q007C05012Q007B0002001B3Q0012540003006C015Q0002000200034Q0002000100024Q000100023Q00062Q000100D305013Q000426012Q00D305010020AC00020001001C2Q0072000200020002000657010200D305013Q000426012Q00D305012Q007B000200114Q0033010200010002000657010200D305013Q000426012Q00D305012Q007B0002001C3Q000657010200D305013Q000426012Q00D305012Q007B000200033Q00126C0004006D013Q00400102000200042Q0072000200020002000657010200AD05013Q000426012Q00AD05012Q007B000200064Q006F010300023Q00122Q0004006E012Q00122Q0005006F015Q0003000500024Q0002000200034Q000300023Q00122Q00040070012Q00122Q00050071015Q0003000500024Q0002000200034Q000300023Q00122Q00040072012Q00122Q00050073015Q0003000500024Q00020002000300062Q000200D705010001000426012Q00D705012Q007B000200033Q00126C0004006D013Q00400102000200042Q007200020002000200067C000200C105010001000426012Q00C105012Q007B000200123Q00201C0002000200A600122Q000300A73Q00122Q00040074015Q00020004000200062Q000200C105010001000426012Q00C105012Q007B000200033Q0020DA0002000200064Q000400013Q00202Q0004000400074Q00020004000200062Q000200D305013Q000426012Q00D305012Q007B000200064Q0039000300023Q00122Q00040075012Q00122Q00050076015Q0003000500024Q0002000200034Q000300023Q00122Q00040077012Q00122Q00050078015Q0003000500024Q0002000200034Q000300023Q00122Q00040079012Q00122Q0005007A015Q0003000500024Q00020002000300062Q000200D705013Q000426012Q00D7050100126C0002007B012Q00126C0003007C012Q00068F0102001606010003000426012Q001606012Q007B000200063Q0020650002000200114Q000300016Q000400046Q00020004000200062Q000200E605010001000426012Q00E6050100126C0002007D012Q00126C0003007E012Q000623010200E605010003000426012Q00E6050100126C0002007F012Q00126C00030080012Q0006ED0002001606010003000426012Q0016060100126C000200124Q003A000300033Q00126C000400123Q000623010200EF05010004000426012Q00EF050100126C00040081012Q00126C00050082012Q0006ED000400E805010005000426012Q00E8050100126C000300123Q00126C00040083012Q00126C00050084012Q00068F010400F005010005000426012Q00F0050100126C00040085012Q00126C00050086012Q00068F010400F005010005000426012Q00F0050100126C000400123Q0006ED000300F005010004000426012Q00F0050100126C000400123Q00126C000500123Q0006ED000400FC05010005000426012Q00FC050100126C000500123Q00126C000600123Q0006ED00052Q0006010006000426013Q0006012Q007B000600064Q0041000700023Q00122Q00080087012Q00122Q00090088015Q00070009000200122Q00080089015Q0006000700084Q000600023Q00122Q0007008A012Q00122Q0008008B015Q000600086Q00065Q00045Q000601000426012Q00FC0501000426012Q00F00501000426012Q00160601000426012Q00E80501000426012Q00160601000426012Q007C050100126C3Q008C012Q00126C0001008D012Q0006C63Q006706010001000426012Q006706012Q007B3Q00014Q004B2Q0100023Q00122Q0002008E012Q00122Q0003008F015Q0001000300028Q000100206Q00056Q0002000200064Q006706013Q000426012Q006706012Q007B3Q00063Q0020E55Q00114Q000100013Q00122Q00020090015Q0001000100024Q000200028Q0002000200064Q003106010001000426012Q0031060100126C3Q0091012Q00126C00010092012Q0006C60001006706013Q000426012Q0067060100126C3Q00124Q003A000100013Q00126C000200123Q000623012Q003A06010002000426012Q003A060100126C00020093012Q00126C00030094012Q00068F0102003306010003000426012Q0033060100126C000100123Q00126C00020095012Q00126C000300643Q0006C60003003B06010002000426012Q003B060100126C000200123Q0006ED0001003B06010002000426012Q003B060100126C000200123Q00126C00030096012Q00126C00040097012Q0006C60003004306010004000426012Q0043060100126C000300123Q0006ED0002004306010003000426012Q0043060100126C000300123Q00126C00040098012Q00126C00050098012Q0006ED0004005206010005000426012Q0052060100126C000400123Q0006230103005606010004000426012Q0056060100126C00040099012Q00126C0005009A012Q0006C60004004B06010005000426012Q004B06012Q007B000400064Q0041000500023Q00122Q0006009B012Q00122Q0007009C015Q00050007000200122Q0006009D015Q0004000500064Q000400023Q00122Q0005009E012Q00122Q0006009F015Q000400066Q00045Q00044Q004B0601000426012Q00430601000426012Q003B0601000426012Q00670601000426012Q003306012Q007B3Q00014Q0022000100023Q00122Q000200A0012Q00122Q000300A1015Q0001000300028Q000100206Q00056Q0002000200064Q007506010001000426012Q0075060100126C3Q00A2012Q00126C000100A3012Q00068F012Q00B406010001000426012Q00B4060100126C3Q00A4012Q00126C000100A5012Q0006C6000100B406013Q000426012Q00B406012Q007B3Q00063Q0020E55Q00114Q000100013Q00122Q000200A6015Q0001000100024Q000200028Q0002000200064Q008606010001000426012Q0086060100126C3Q00A7012Q00126C000100653Q0006C63Q00B406010001000426012Q00B4060100126C3Q00124Q003A000100013Q00126C000200123Q0006ED3Q008806010002000426012Q0088060100126C000100123Q00126C000200123Q0006232Q01009706010002000426012Q0097060100126C000200A8012Q00126C000300A9012Q0006920102000500010003000426012Q0097060100126C000200AA012Q00126C000300AB012Q0006C60002008C06010003000426012Q008C060100126C000200123Q00126C000300123Q0006230102009F06010003000426012Q009F060100126C000300AC012Q00126C000400AD012Q0006ED0003009806010004000426012Q0098060100126C000300123Q00126C000400123Q0006ED000300A006010004000426012Q00A006012Q007B000400064Q0041000500023Q00122Q000600AE012Q00122Q000700AF015Q00050007000200122Q000600B0015Q0004000500064Q000400023Q00122Q000500B1012Q00122Q000600B2015Q000400066Q00045Q00044Q00A00601000426012Q00980601000426012Q008C0601000426012Q00B40601000426012Q0088060100126C3Q00B3012Q00126C000100B4012Q00068F2Q0100F806013Q000426012Q00F8060100126C3Q00B5012Q00126C000100B6012Q0006C63Q00F806010001000426012Q00F806012Q007B3Q00014Q004B2Q0100023Q00122Q000200B7012Q00122Q000300B8015Q0001000300028Q000100206Q00056Q0002000200064Q00F806013Q000426012Q00F8060100126C3Q00B9012Q00126C000100BA012Q0006C6000100F806013Q000426012Q00F806012Q007B3Q00063Q0020085Q00114Q000100013Q00122Q000200BB015Q0001000100024Q000200028Q0002000200064Q00F806013Q000426012Q00F8060100126C3Q00124Q003A000100013Q00126C000200123Q0006ED3Q00D506010002000426012Q00D5060100126C000100123Q00126C000200BC012Q00126C000300BD012Q00068F010200D906010003000426012Q00D9060100126C000200123Q0006ED000100D906010002000426012Q00D9060100126C000200123Q00126C000300123Q000623010300E806010002000426012Q00E8060100126C000300BE012Q00126C000400BF012Q0006C6000400E106010003000426012Q00E106012Q007B000300064Q0041000400023Q00122Q000500C0012Q00122Q000600C1015Q00040006000200122Q000500C2015Q0003000400054Q000300023Q00122Q000400C3012Q00122Q000500C4015Q000300056Q00035Q00044Q00E10601000426012Q00D90601000426012Q00F80601000426012Q00D5060100126C3Q00C5012Q00126C000100C6012Q00068F012Q003C07010001000426012Q003C07012Q007B3Q00014Q0022000100023Q00122Q000200C7012Q00122Q000300C8015Q0001000300028Q000100206Q00056Q0002000200064Q000A07010001000426012Q000A070100126C3Q00C9012Q00126C000100CA012Q0006C60001003C07013Q000426012Q003C07012Q007B3Q00063Q0020085Q00114Q000100013Q00122Q000200CB015Q0001000100024Q000200028Q0002000200064Q003C07013Q000426012Q003C070100126C3Q00124Q003A000100013Q00126C000200CC012Q00126C000300CD012Q00068F0103001507010002000426012Q0015070100126C000200123Q0006ED3Q001507010002000426012Q0015070100126C000100123Q00126C000200CE012Q00126C00030097012Q0006C60002001D07010003000426012Q001D070100126C000200123Q0006ED0001001D07010002000426012Q001D070100126C000200123Q00126C000300123Q0006230102002C07010003000426012Q002C070100126C000300CF012Q00126C000400D0012Q0006ED0003002507010004000426012Q002507012Q007B000300064Q0041000400023Q00122Q000500D1012Q00122Q000600D2015Q00040006000200122Q000500D3015Q0003000400054Q000300023Q00122Q000400D4012Q00122Q000500D5015Q000300056Q00035Q00044Q00250701000426012Q001D0701000426012Q003C0701000426012Q001507012Q007B3Q00134Q006F2Q0100023Q00122Q000200D6012Q00122Q000300D7015Q0001000300028Q00014Q000100023Q00122Q000200D8012Q00122Q000300D9015Q0001000300028Q00014Q000100023Q00122Q000200DA012Q00122Q000300DB015Q0001000300028Q000100064Q006807010001000426012Q006807012Q007B3Q00134Q006F2Q0100023Q00122Q000200DC012Q00122Q000300DD015Q0001000300028Q00014Q000100023Q00122Q000200DE012Q00122Q000300DF015Q0001000300028Q00014Q000100023Q00122Q000200E0012Q00122Q000300E1015Q0001000300028Q000100064Q006807010001000426012Q0068070100126C3Q002Q012Q00126C000100E2012Q000623012Q006807010001000426012Q0068070100126C3Q00E3012Q00126C000100E4012Q0006C6000100B50A013Q000426012Q00B50A012Q007B3Q00033Q00125E000200E5019Q00024Q0002001D8Q000200024Q000100033Q00122Q000300E5015Q0001000100034Q0003001D6Q0001000300026Q00013Q00067C3Q007D07010001000426012Q007D070100126C000100E6012Q00126C000200E7012Q0006922Q01000500010002000426012Q007D070100126C000100E8012Q00126C000200E9012Q00068F0102006008010001000426012Q006008012Q007B0001001E3Q0020AC0001000100D82Q00720001000200022Q00E1000100014Q007B000200144Q0087010300023Q00122Q000400EA012Q00122Q000500EB015Q0003000500024Q00020002000300202Q0002000200D84Q0002000200020006ED0001009107010002000426012Q009107012Q007B0001001E3Q0020AC00010001005E2Q007200010002000200126C000200EC012Q000638010200AE07010001000426012Q00AE07012Q007B0001001F3Q0020AC00010001005E2Q007200010002000200126C000200EC012Q000638010200AE07010001000426012Q00AE07012Q007B000100123Q00201C0001000100A600122Q000200A73Q00122Q000300ED015Q00010003000200062Q000100AE07010001000426012Q00AE07012Q007B0001001F3Q00126C000300EE013Q00402Q01000100032Q00720001000200020006572Q0100AE07013Q000426012Q00AE07012Q007B0001001E3Q00126C000300EE013Q00402Q01000100032Q00720001000200020006572Q0100AE07013Q000426012Q00AE070100126C000100EF012Q00126C000200F0012Q0006ED0001006008010002000426012Q006008012Q007B000100063Q0020080001000100114Q000200143Q00122Q000300F1015Q0002000200034Q000300046Q00010004000200062Q0001006008013Q000426012Q0060080100126C000100F2012Q00126C000200F3012Q0006C60001001608010002000426012Q001608012Q007B000100144Q0025010200023Q00122Q000300F4012Q00122Q000400F5015Q0002000400024Q00010001000200202Q0001000100D84Q0001000200024Q000200153Q00062Q000100D807010002000426012Q00D807012Q007B000100134Q006F010200023Q00122Q000300F6012Q00122Q000400F7015Q0002000400024Q0001000100024Q000200023Q00122Q000300F8012Q00122Q000400F9015Q0002000400024Q0001000100024Q000200023Q00122Q000300FA012Q00122Q000400FB015Q0002000400024Q00010001000200062Q000100DC07010001000426012Q00DC070100126C000100FC012Q00126C000200FD012Q0006C60001001608010002000426012Q0016080100126C000100124Q003A000200023Q00126C000300123Q0006232Q0100E507010003000426012Q00E5070100126C000300FE012Q00126C000400FF012Q00068F010400DE07010003000426012Q00DE070100126C000200123Q00126C000300123Q000623010200ED07010003000426012Q00ED070100126C00032Q00022Q00126C00040001022Q00068F010400E607010003000426012Q00E6070100126C000300124Q003A000400043Q00126C000500123Q0006ED000300EF07010005000426012Q00EF070100126C000400123Q00126C0005002Q022Q00126C00060003022Q00068F010500F307010006000426012Q00F3070100126C000500123Q0006ED000400F307010005000426012Q00F3070100126C000500123Q00126C000600123Q0006230106000208010005000426012Q0002080100126C00060004022Q00126C00070005022Q0006C6000700FB07010006000426012Q00FB07012Q007B000600064Q0041000700023Q00122Q00080006022Q00122Q00090007025Q00070009000200122Q000800EB6Q0006000700084Q000600023Q00122Q00070008022Q00122Q00080009025Q000600086Q00065Q00044Q00FB0701000426012Q00F30701000426012Q00E60701000426012Q00EF0701000426012Q00E60701000426012Q00600801000426012Q00DE0701000426012Q006008012Q007B000100144Q0025010200023Q00122Q0003000A022Q00122Q0004000B025Q0002000400024Q00010001000200202Q0001000100D84Q0001000200024Q000200163Q00062Q0001003308010002000426012Q003308012Q007B000100134Q006F010200023Q00122Q0003000C022Q00122Q0004000D025Q0002000400024Q0001000100024Q000200023Q00122Q0003000E022Q00122Q0004000F025Q0002000400024Q0001000100024Q000200023Q00122Q00030010022Q00122Q00040011025Q0002000400024Q00010001000200062Q0001003B08010001000426012Q003B080100126C00010012022Q00126C00020013022Q0006380102003B08010001000426012Q003B080100126C00010014022Q00126C00020015022Q00068F0102006008010001000426012Q0060080100126C000100124Q003A000200023Q00126C00030016022Q00126C00040017022Q0006C60004003D08010003000426012Q003D080100126C000300123Q0006ED0001003D08010003000426012Q003D080100126C000200123Q00126C000300123Q0006ED0002004508010003000426012Q0045080100126C000300123Q00126C00040018022Q00126C00050019022Q0006C60004004908010005000426012Q0049080100126C000400123Q0006ED0003004908010004000426012Q004908012Q007B000400064Q0041000500023Q00122Q0006001A022Q00122Q0007001B025Q00050007000200122Q0006002Q015Q0004000500064Q000400023Q00122Q0005001C022Q00122Q0006001D025Q000400066Q00045Q00044Q00490801000426012Q00450801000426012Q00600801000426012Q003D08012Q007B000100033Q00125E000300E5015Q0001000100034Q0003001D6Q0001000300024Q000200033Q00122Q000400E5015Q0002000200044Q0004001D6Q0002000400024Q000100023Q00067C0001007108010001000426012Q0071080100126C0002001E022Q00126C0003001F022Q0006C6000300F108010002000426012Q00F108012Q007B000200073Q00126C000300103Q0006380103008408010002000426012Q008408012Q007B000200123Q00201C0002000200A600122Q000300A73Q00122Q000400EC015Q00020004000200062Q0002008408010001000426012Q0084080100126C00020020022Q00126C00030021022Q0006380102008408010003000426012Q0084080100126C00020022022Q00126C00030023022Q00068F010200F108010003000426012Q00F108012Q007B000200144Q0025010300023Q00122Q00040024022Q00122Q00050025025Q0003000500024Q00020002000300202Q0002000200D84Q0002000200024Q000300153Q00062Q000200A108010003000426012Q00A108012Q007B000200134Q006F010300023Q00122Q00040026022Q00122Q00050027025Q0003000500024Q0002000200034Q000300023Q00122Q00040028022Q00122Q00050029025Q0003000500024Q0002000200034Q000300023Q00122Q0004002A022Q00122Q0005002B025Q0003000500024Q00020002000300062Q000200A508010001000426012Q00A5080100126C0002002C022Q00126C0003002D022Q0006C6000300C808010002000426012Q00C8080100126C000200123Q00126C0003002E022Q00126C0004002F022Q00068F010400AD08010003000426012Q00AD080100126C000300123Q000623010200B108010003000426012Q00B1080100126C00030030022Q00126C00040031022Q00068F010300A608010004000426012Q00A6080100126C000300123Q00126C000400123Q000623010300B908010004000426012Q00B9080100126C00040032022Q00126C0005008F3Q0006C6000400B208010005000426012Q00B208012Q007B000400064Q0041000500023Q00122Q00060033022Q00122Q00070034025Q00050007000200122Q000600EB6Q0004000500064Q000400023Q00122Q00050035022Q00122Q00060036025Q000400066Q00045Q00044Q00B20801000426012Q00A60801000426012Q00F108012Q007B000200144Q0025010300023Q00122Q00040037022Q00122Q00050038025Q0003000500024Q00020002000300202Q0002000200D84Q0002000200024Q000300163Q00062Q000200F108010003000426012Q00F108012Q007B000200134Q0039000300023Q00122Q00040039022Q00122Q0005003A025Q0003000500024Q0002000200034Q000300023Q00122Q0004003B022Q00122Q0005003C025Q0003000500024Q0002000200034Q000300023Q00122Q0004003D022Q00122Q0005003E025Q0003000500024Q00020002000300062Q000200F108013Q000426012Q00F108012Q007B000200064Q0069010300023Q00122Q0004003F022Q00122Q00050040025Q00030005000200122Q0004002Q015Q0002000300044Q000200023Q00122Q00030041022Q00122Q00040042025Q000200046Q00025Q00126C00020043022Q00126C00030044022Q00068F01022Q0009010003000426013Q0009012Q007B000200144Q0097010300023Q00122Q00040045022Q00122Q00050046025Q0003000500024Q00020002000300122Q00040007015Q0002000200044Q00020002000200062Q0002000409010001000426012Q0004090100126C00020047022Q00126C00030048022Q0006C6000300A509010002000426012Q00A509012Q007B000200073Q00126C000300103Q0006380103001309010002000426012Q001309012Q007B000200123Q00201C0002000200A600122Q000300A73Q00122Q0004005B6Q00020004000200062Q0002001309010001000426012Q0013090100126C00020049022Q00126C0003004A022Q0006C6000200A509010003000426012Q00A509012Q007B000200063Q0020E50002000200114Q000300143Q00122Q0004004B025Q0003000300044Q000400056Q00020005000200062Q0002002009010001000426012Q0020090100126C0002004C022Q00126C0003004D022Q00068F010200A509010003000426012Q00A5090100126C0002004E022Q00126C0003004F022Q00068F0102006B09010003000426012Q006B09012Q007B000200144Q0025010300023Q00122Q00040050022Q00122Q00050051025Q0003000500024Q00020002000300202Q0002000200D84Q0002000200024Q000300153Q00062Q0002006B09010003000426012Q006B09012Q007B000200134Q0039000300023Q00122Q00040052022Q00122Q00050053025Q0003000500024Q0002000200034Q000300023Q00122Q00040054022Q00122Q00050055025Q0003000500024Q0002000200034Q000300023Q00122Q00040056022Q00122Q00050057025Q0003000500024Q00020002000300062Q0002006B09013Q000426012Q006B090100126C000200124Q003A000300033Q00126C00040058022Q00126C00050058022Q0006ED0004004A09010005000426012Q004A090100126C000400123Q0006230102004E09010004000426012Q004E090100126C00040059022Q00126C0005005A022Q0006C60004004309010005000426012Q0043090100126C000300123Q00126C000400123Q0006230103005609010004000426012Q0056090100126C0004005B022Q00126C0005005C022Q0006C60004004F09010005000426012Q004F090100126C000400123Q00126C000500123Q0006ED0004005709010005000426012Q005709012Q007B000500064Q0041000600023Q00122Q0007005D022Q00122Q0008005E025Q00060008000200122Q000700EB6Q0005000600074Q000500023Q00122Q0006005F022Q00122Q00070060025Q000500076Q00055Q00044Q00570901000426012Q004F0901000426012Q00A50901000426012Q00430901000426012Q00A509012Q007B000200144Q0025010300023Q00122Q00040061022Q00122Q00050062025Q0003000500024Q00020002000300202Q0002000200D84Q0002000200024Q000300163Q00062Q0002008809010003000426012Q008809012Q007B000200134Q006F010300023Q00122Q00040063022Q00122Q00050064025Q0003000500024Q0002000200034Q000300023Q00122Q00040065022Q00122Q00050066025Q0003000500024Q0002000200034Q000300023Q00122Q00040067022Q00122Q00050068025Q0003000500024Q00020002000300062Q0002009009010001000426012Q0090090100126C00020069022Q00126C0003006A022Q0006380103009009010002000426012Q0090090100126C0002006B022Q00126C0003006C022Q0006ED000200A509010003000426012Q00A5090100126C000200123Q00126C000300123Q0006230102009809010003000426012Q0098090100126C0003008C012Q00126C0004006D022Q0006ED0003009109010004000426012Q009109012Q007B000300064Q0041000400023Q00122Q0005006E022Q00122Q0006006F025Q00040006000200122Q0005002Q015Q0003000400054Q000300023Q00122Q00040070022Q00122Q00050071025Q000300056Q00035Q00044Q009109012Q007B000200033Q001207000400E5015Q0002000200044Q0004001D6Q0002000400024Q000300033Q00122Q00040043012Q00122Q00050072022Q00122Q00060073022Q00062Q000600DE09010005000426012Q00DE090100126C00050074022Q00126C00060074022Q0006ED000500DE09010006000426012Q00DE0901000657010200DE09013Q000426012Q00DE090100126C000500123Q00126C000600123Q000623010500BE09010006000426012Q00BE090100126C00060075022Q00126C00070076022Q00068F010700B709010006000426012Q00B7090100126C00080077023Q00400106000200082Q00720006000200022Q0013010300063Q000657010300DB09013Q000426012Q00DB09012Q007B000600023Q00129301070078022Q00122Q00080079025Q0006000800024Q00060003000600122Q000700123Q00062Q000700DB09010006000426012Q00DB09012Q007B000600023Q00126C0007007A022Q00126C0008007B023Q00A80106000800022Q000400060003000600126C00070043012Q0006C6000600DB09010007000426012Q00DB09012Q007B000600023Q0012790007007C022Q00122Q0008007D025Q0006000800024Q00060003000600062Q000400DC09010006000426012Q00DC090100126C00040043012Q000426012Q00DE0901000426012Q00B7090100126C0005007E022Q00126C000600FC3Q00068F010500F709010006000426012Q00F70901000657010200F709013Q000426012Q00F709012Q007B000500033Q0020AB0105000500064Q000700013Q00202Q0007000700A54Q00050007000200062Q000500FB09010001000426012Q00FB09012Q007B000500123Q00201C0005000500A600122Q000600A73Q00122Q000700ED015Q00050007000200062Q000500FB09010001000426012Q00FB090100126C0007007F023Q00400105000200072Q007200050002000200067C000500FB09010001000426012Q00FB090100126C00050080022Q00126C00060081022Q0006C6000500B50A010006000426012Q00B50A0100126C00050082022Q00126C00060083022Q00068F010500B50A010006000426012Q00B50A012Q007B000500063Q00203A0105000500114Q000600026Q000700086Q000900046Q00050009000200062Q000500B50A013Q000426012Q00B50A0100126C00050084022Q00126C00060085022Q0006C6000600670A010005000426012Q00670A0100126C00050086022Q00126C00060086022Q0006ED000500670A010006000426012Q00670A010020AC0005000200D82Q000A00050002000200122Q00060087025Q000700023Q00122Q00080088022Q00122Q00090089025Q00070009000200122Q0008008A025Q00060008000200062Q000500670A010006000426012Q00670A012Q007B000500134Q0039000600023Q00122Q0007008B022Q00122Q0008008C025Q0006000800024Q0005000500064Q000600023Q00122Q0007008D022Q00122Q0008008E025Q0006000800024Q0005000500064Q000600023Q00122Q0007008F022Q00122Q00080090025Q0006000800024Q00050005000600062Q000500670A013Q000426012Q00670A0100126C000500123Q00126C00060091022Q00126C00070092022Q00068F0107002D0A010006000426012Q002D0A0100126C000600123Q0006ED0005002D0A010006000426012Q002D0A0100126C000600124Q003A000700073Q00126C00080093022Q00126C00090094022Q00068F010800360A010009000426012Q00360A0100126C000800123Q0006ED000600360A010008000426012Q00360A0100126C000700123Q00126C000800123Q000623010700450A010008000426012Q00450A0100126C00080095022Q00126C00090096022Q0006ED0008003E0A010009000426012Q003E0A0100126C000800123Q00126C00090097022Q00126C000A0097022Q0006ED000900460A01000A000426012Q00460A0100126C000900123Q000623010800510A010009000426012Q00510A0100126C00090098022Q00126C000A0099022Q0006C6000A00460A010009000426012Q00460A012Q007B000900064Q0037000A00023Q00122Q000B009A022Q00122Q000C009B025Q000A000C000200122Q000B00EB6Q0009000A000B4Q000900023Q00122Q000A009C022Q00122Q000B009D025Q0009000B000200126C000C009E023Q0081010A0002000C4Q000A000200024Q00090009000A4Q000900023Q00044Q00460A01000426012Q003E0A01000426012Q002D0A01000426012Q00360A01000426012Q002D0A01000426012Q00B50A010020AC0005000200D82Q000A00050002000200122Q00060087025Q000700023Q00122Q0008009F022Q00122Q000900A0025Q00070009000200122Q000800A1025Q00060008000200062Q000500B50A010006000426012Q00B50A012Q007B000500134Q0039000600023Q00122Q000700A2022Q00122Q000800A3025Q0006000800024Q0005000500064Q000600023Q00122Q000700A4022Q00122Q000800A5025Q0006000800024Q0005000500064Q000600023Q00122Q000700A6022Q00122Q000800A7025Q0006000800024Q00050005000600062Q000500B50A013Q000426012Q00B50A0100126C000500124Q003A000600063Q00126C000700A8022Q00126C000800A9022Q0006C6000700860A010008000426012Q00860A0100126C000700123Q0006ED000500860A010007000426012Q00860A0100126C000600123Q00126C000700AA022Q00126C000800AB022Q0006C60007008E0A010008000426012Q008E0A0100126C000700AC022Q00126C000800AD022Q00068F0107008E0A010008000426012Q008E0A0100126C000700123Q0006ED0006008E0A010007000426012Q008E0A0100126C000700123Q00126C000800123Q000623010700A10A010008000426012Q00A10A0100126C000800AE022Q00126C000900AF022Q0006C60008009A0A010009000426012Q009A0A012Q007B000800064Q0037000900023Q00122Q000A00B0022Q00122Q000B00B1025Q0009000B000200122Q000A002Q015Q00080009000A4Q000800023Q00122Q000900B2022Q00122Q000A00B3025Q0008000A000200126C000B009E023Q008101090002000B4Q0009000200024Q0008000800094Q000800023Q00044Q009A0A01000426012Q008E0A01000426012Q00B50A01000426012Q00860A012Q0045012Q00017Q00BE3Q00028Q00026Q00084003063Q00AC02EEB5FF8503053Q008CED6F8CC0030A3Q0049734361737461626C6503113Q002E10791C031752082Q166F0C1317740C1F03043Q007866791D030B3Q004973417661696C61626C6503063Q0042752Q665570030C3Q00417564616369747942752Q66025Q00E0AA40025Q00F09740030B3Q0043617374502Q6F6C696E67030A3Q002Q534175646163697479030E3Q0049735370652Q6C496E52616E676503063Q00416D62757368025Q0023B040025Q002AAE40025Q00A6AE40025Q00E8B14003103Q009EE6AD2EBEED8A33A3F6B53FAFE2AA2F03043Q005BCC83D9025Q00F2C04003213Q00EDFE46C0F3FCF3CCEA46DCF395CDFDBF7DDDB4D5B3FEED5CDBF3FFEBC8F950D0FA03073Q009EAE9F35B4D3BD03063Q0073F0EFC864BD03063Q00D5329D8DBD1703113Q00D62F80A477AAD13694AF60B0EB288DB46B03063Q00C49E46E4C012025Q004EA040025Q00F0A540025Q00F88E40025Q00A89640025Q00088C40025Q00C07A40025Q00DEAE40025Q00FCA24003103Q00785A055BCB446C1941CC465B124FCA5E03053Q00B92A3F712E030B3Q00F7DC322D5BF5D0232C08DC03053Q007BB4BD4159025Q004C9B40025Q00A6A740030B3Q00EB25F846CC0FF557DB3BE003043Q0022A9499903073Q0049735265616479025Q00088540025Q00588340025Q001AAF40025Q0046AE40025Q0040B140030D3Q008EE90D9F87ED058EBFFA0E99B903043Q00EBCA8C6B03093Q0042726F616473696465026Q001440025Q00288440025Q009FB04003043Q0043617374030B3Q00426C616465466C752Q7279026Q004440025Q001EA040025Q00B9B140025Q00C88240025Q0026AA40025Q008EA64003103Q003E7120BDFB29C4CD036138ACEA26E4D103083Q00A56C1454C8894797024Q00801ACB4003113Q0059B5389C3A9627897EB16BAE76A1399A6303043Q00E81AD44B030B3Q00154573ECF2114567FAE52E03053Q009757291288030B3Q0079A3CBD4FB7DA3DFC2EC4203053Q009E3BCFAAB0030A3Q007C4B315D895D58264E8903053Q00EC2F3E532903113Q00D2A0243FAF8CD5B93034B896EFA7292FB303063Q00E29AC9405BCA027Q0040030B3Q0042752Q6652656D61696E732Q033Q00474344025Q004FB340025Q00E0854003063Q00EE5C09144BAB03063Q00DCA1297D782A030B3Q009B52840FAF5EA6089B528403043Q006EDC11C0030B3Q005675351EEE11FDB2666B2D03083Q00C71419547A8B5791025Q002AA840025Q00208740025Q00E4A540025Q003DB14003103Q00750CC9BB09E47401D2BB17EE4408CEBA03063Q008A2769BDCE7B03113Q003C069A39B3DBC3FE1B02C90BFFECDDED0603083Q009F7F67E94D9399AF025Q0090AB40025Q0022B040025Q0047B140025Q00CAA74003103Q0035F5F0BF52C534F8EBBF4CCF04F1F7BE03063Q00AB679084CA2003113Q00332EFA18500DE50D142AA92A1C3AFB1E0903043Q006C704F89026Q00F03F025Q00108240025Q00DAA64003093Q001CCD782C8F0DE63A3B03083Q00555FA21448CD618903083Q0042752Q66446F776E03093Q00436F6C64426C2Q6F6403083Q004469737061746368025Q00B4AE40025Q0060A040025Q00508340025Q004CA540025Q0086A740025Q0080654003103Q00C5F83EC91FF6FEFFF23FD009FBCCE4E903073Q00AD979D4ABC6D98024Q0094541741030F3Q0007092BC99C77DAFF20481AD1D35BD103083Q0093446858BDBC34B5025Q00507E40025Q002FB340030E3Q00388D9FC71F8D85C4128DAEC91F9B03043Q00B07AE8EB030E3Q00426574772Q656E7468654579657303093Q00A3673B4CE5937D355B03053Q008EE0155A2F030A3Q00536861646F776D656C6403093Q00537465616C74685570026Q001040025Q002AB340025Q00809F40025Q0090884003103Q0046D13343B685B67CDB325AA0888467C003073Q00E514B44736C4EB024Q00343F134103153Q000A7FD2F7B588853D69C4E6FBEA94217B81C6ECAF9303073Q00E0491EA18395CA025Q00908940025Q0090A040025Q00708D40025Q000CA040025Q00F07940025Q007AB34003083Q00D5ECE240F0F1F25803043Q0030918591025Q0084A740025Q00109440025Q00F8A940025Q00C8B240025Q00C88640025Q00E4A140025Q00807140025Q00F0AE4003103Q006849A1FBC3226944BAFBDD28594DA6FA03063Q004C3A2CD58EB1025Q0064A040030D3Q00E825013938EF2D013D79DF271A03053Q0018AB44724D025Q00E09D40025Q0092A740030A3Q00DF14434688D237A5E00903083Q00CD8F7D3032E7BE64030A3Q00506973746F6C53686F7403093Q00E2B51506EAF0D7ADD503083Q00C2A1C774658183BF030C3Q00CA25C69CFFA7C425C5A5F2B003063Q00C28C44A8C897030A3Q0054616C656E7452616E6B03093Q0042752Q66537461636B030B3Q004F2Q706F7274756E697479026Q00184003153Q0047722Q656E736B696E735769636B65727342752Q66025Q00449540025Q00407140025Q00909A40025Q0056AC40025Q00CAB040025Q008C9140025Q00B07140025Q0008A14003103Q0070FEC130E74CC8DD2AE04EFFD624E65603053Q0095229BB545024Q0018AD064103103Q0020FCC6EE43CDDCE917F2D9BA30F5DAEE03043Q009A639DB500B9022Q00126C3Q00013Q0026AB3Q008900010002000426012Q008900012Q007B00016Q004B010200013Q00122Q000300033Q00122Q000400046Q0002000400024Q00010001000200202Q0001000100054Q00010002000200062Q0001004500013Q000426012Q004500012Q007B00016Q004B010200013Q00122Q000300063Q00122Q000400076Q0002000400024Q00010001000200202Q0001000100084Q00010002000200062Q0001004500013Q000426012Q004500012Q007B000100023Q0020DA0001000100094Q00035Q00202Q00030003000A4Q00010003000200062Q0001004500013Q000426012Q00450001002E71000C00450001000B000426012Q004500012Q007B000100033Q0020672Q010001000D4Q00025Q00202Q00020002000E4Q000300036Q000400043Q00202Q00040004000F4Q00065Q00202Q0006000600104Q0004000600024Q000400044Q00A82Q010004000200067C0001003000010001000426012Q00300001002E5D0011004500010012000426012Q0045000100126C000100013Q002E710013003100010014000426012Q003100010026AB0001003100010001000426012Q0031000100126C000200013Q0026AB0002003600010001000426012Q003600012Q007B000300034Q00E2000400013Q00122Q000500153Q00122Q000600166Q00040006000200202Q0003000400174Q000300013Q00122Q000400183Q00122Q000500196Q000300056Q00035Q00044Q00360001000426012Q003100012Q007B00016Q004B010200013Q00122Q0003001A3Q00122Q0004001B6Q0002000400024Q00010001000200202Q0001000100054Q00010002000200062Q0001006000013Q000426012Q006000012Q007B000100043Q0020DA00010001000F4Q00035Q00202Q0003000300104Q00010003000200062Q0001006000013Q000426012Q006000012Q007B00016Q0022000200013Q00122Q0003001C3Q00122Q0004001D6Q0002000400024Q00010001000200202Q0001000100084Q00010002000200062Q0001006200010001000426012Q00620001002E71001F00B80201001E000426012Q00B802012Q007B000100033Q00203B00010001000D4Q00025Q00202Q0002000200104Q00010002000200062Q0001006B00010001000426012Q006B0001002E5D002100B802010020000426012Q00B8020100126C000100014Q003A000200023Q002E710023006D00010022000426012Q006D00010026AB0001006D00010001000426012Q006D000100126C000200013Q000ED30001007200010002000426012Q0072000100126C000300013Q002E710025007500010024000426012Q007500010026AB0003007500010001000426012Q007500012Q007B000400034Q00E2000500013Q00122Q000600263Q00122Q000700276Q00050007000200202Q0004000500174Q000400013Q00122Q000500283Q00122Q000600296Q000400066Q00045Q00044Q00750001000426012Q00720001000426012Q00B80201000426012Q006D0001000426012Q00B80201002E5D002A00852Q01002B000426012Q00852Q010026AB3Q00852Q010001000426012Q00852Q012Q007B00016Q0022000200013Q00122Q0003002C3Q00122Q0004002D6Q0002000400024Q00010001000200202Q00010001002E4Q00010002000200062Q0001009900010001000426012Q00990001002E71002F00F200010030000426012Q00F20001002E040131005900010031000426012Q00F20001002E71003200F200010033000426012Q00F200012Q007B00016Q004B010200013Q00122Q000300343Q00122Q000400356Q0002000400024Q00010001000200202Q0001000100084Q00010002000200062Q000100F200013Q000426012Q00F200012Q007B000100054Q00332Q010001000200067C000100F200010001000426012Q00F200012Q007B000100063Q000E66010200C600010001000426012Q00C600012Q007B000100074Q00CD000200086Q000300066Q000400096Q000500023Q00202Q0005000500094Q00075Q00202Q0007000700364Q000500076Q00048Q00023Q00022Q00CD0003000A6Q000400066Q000500096Q000600023Q00202Q0006000600094Q00085Q00202Q0008000800364Q000600086Q00058Q00033Q00022Q00430102000200030006232Q0100C900010002000426012Q00C900012Q007B000100063Q000E66013700F200010001000426012Q00F20001002E71003800F200010039000426012Q00F200012Q007B000100033Q002Q202Q010001003A4Q00025Q00202Q00020002003B4Q000300036Q00010003000200062Q000100D500010001000426012Q00D50001002E5D003D00F20001003C000426012Q00F2000100126C000100014Q003A000200023Q0026C5000100DB00010001000426012Q00DB0001002E5D003E00D70001003F000426012Q00D7000100126C000200013Q002E5D004100DC00010040000426012Q00DC00010026AB000200DC00010001000426012Q00DC000100126C000300013Q0026AB000300E100010001000426012Q00E100012Q007B000400034Q00E2000500013Q00122Q000600423Q00122Q000700436Q00050007000200202Q0004000500444Q000400013Q00122Q000500453Q00122Q000600466Q000400066Q00045Q00044Q00E10001000426012Q00DC0001000426012Q00F20001000426012Q00D700012Q007B00016Q004B010200013Q00122Q000300473Q00122Q000400486Q0002000400024Q00010001000200202Q00010001002E4Q00010002000200062Q000100842Q013Q000426012Q00842Q012Q007B00016Q004B010200013Q00122Q000300493Q00122Q0004004A6Q0002000400024Q00010001000200202Q0001000100054Q00010002000200062Q000100842Q013Q000426012Q00842Q012Q007B0001000B4Q00332Q01000100020006572Q0100842Q013Q000426012Q00842Q012Q007B00016Q004B010200013Q00122Q0003004B3Q00122Q0004004C6Q0002000400024Q00010001000200202Q0001000100084Q00010002000200062Q000100842Q013Q000426012Q00842Q012Q007B00016Q004B010200013Q00122Q0003004D3Q00122Q0004004E6Q0002000400024Q00010001000200202Q0001000100084Q00010002000200062Q000100842Q013Q000426012Q00842Q012Q007B000100063Q000E66014F00842Q010001000426012Q00842Q012Q007B000100023Q0020032Q01000100504Q00035Q00202Q00030003003B4Q0001000300024Q000200023Q00202Q0002000200514Q00020002000200062Q000100842Q010002000426012Q00842Q01002E5D0053003F2Q010052000426012Q003F2Q012Q007B0001000C4Q006F010200013Q00122Q000300543Q00122Q000400556Q0002000400024Q0001000100024Q000200013Q00122Q000300563Q00122Q000400576Q0002000400024Q0001000100024Q000200013Q00122Q000300583Q00122Q000400596Q0002000400024Q00010001000200062Q000100412Q010001000426012Q00412Q01002E71005A00642Q01005B000426012Q00642Q012Q007B000100033Q0020472Q010001003A4Q00025Q00202Q00020002003B4Q00010002000200062Q000100842Q013Q000426012Q00842Q0100126C000100014Q003A000200023Q0026AB0001004A2Q010001000426012Q004A2Q0100126C000200013Q0026AB0002004D2Q010001000426012Q004D2Q0100126C000300013Q0026C5000300542Q010001000426012Q00542Q01002E71005D00502Q01005C000426012Q00502Q012Q007B000400034Q00E2000500013Q00122Q0006005E3Q00122Q0007005F6Q00050007000200202Q0004000500444Q000400013Q00122Q000500603Q00122Q000600616Q000400066Q00045Q00044Q00502Q01000426012Q004D2Q01000426012Q00842Q01000426012Q004A2Q01000426012Q00842Q012Q007B000100033Q0020472Q010001003A4Q00025Q00202Q00020002003B4Q00010002000200062Q000100842Q013Q000426012Q00842Q0100126C000100014Q003A000200023Q002E710062006D2Q010063000426012Q006D2Q01000ED30001006D2Q010001000426012Q006D2Q0100126C000200013Q002E71006500722Q010064000426012Q00722Q010026AB000200722Q010001000426012Q00722Q012Q007B000300034Q00E2000400013Q00122Q000500663Q00122Q000600676Q00040006000200202Q0003000400444Q000300013Q00122Q000400683Q00122Q000500696Q000300056Q00035Q00044Q00722Q01000426012Q00842Q01000426012Q006D2Q0100126C3Q006A3Q0026C53Q00892Q01006A000426012Q00892Q01002E04016B008D0001006C000426012Q001402012Q007B00016Q004B010200013Q00122Q0003006D3Q00122Q0004006E6Q0002000400024Q00010001000200202Q0001000100054Q00010002000200062Q000100A52Q013Q000426012Q00A52Q012Q007B000100023Q0020DA00010001006F4Q00035Q00202Q0003000300704Q00010003000200062Q000100A52Q013Q000426012Q00A52Q012Q007B000100043Q0020DA00010001000F4Q00035Q00202Q0003000300714Q00010003000200062Q000100A52Q013Q000426012Q00A52Q012Q007B000100054Q00332Q010001000200067C000100A72Q010001000426012Q00A72Q01002E040172002900010073000426012Q00CE2Q01002E040174002700010074000426012Q00CE2Q01002E040175002500010075000426012Q00CE2Q012Q007B000100033Q00203400010001003A4Q00025Q00202Q0002000200704Q000300036Q00010003000200062Q000100CE2Q013Q000426012Q00CE2Q0100126C000100013Q000ED3000100B42Q010001000426012Q00B42Q0100126C000200014Q003A000300033Q000ED3000100B82Q010002000426012Q00B82Q0100126C000300013Q0026C5000300BF2Q010001000426012Q00BF2Q01002E5D007600BB2Q010077000426012Q00BB2Q012Q007B000400034Q00E2000500013Q00122Q000600783Q00122Q000700796Q00050007000200202Q00040005007A4Q000400013Q00122Q0005007B3Q00122Q0006007C6Q000400066Q00045Q00044Q00BB2Q01000426012Q00B42Q01000426012Q00B82Q01000426012Q00B42Q01002E71007D00130201007E000426012Q001302012Q007B00016Q004B010200013Q00122Q0003007F3Q00122Q000400806Q0002000400024Q00010001000200202Q0001000100054Q00010002000200062Q0001001302013Q000426012Q001302012Q007B000100043Q0020DA00010001000F4Q00035Q00202Q0003000300814Q00010003000200062Q0001001302013Q000426012Q001302012Q007B000100054Q00332Q01000100020006572Q01001302013Q000426012Q001302012Q007B00016Q004B010200013Q00122Q000300823Q00122Q000400836Q0002000400024Q00010001000200202Q0001000100084Q00010002000200062Q0001001302013Q000426012Q001302012Q007B000100023Q0020DA0001000100094Q00035Q00202Q0003000300844Q00010003000200062Q000100FD2Q013Q000426012Q00FD2Q012Q007B000100023Q0020522Q01000100854Q000300016Q00048Q00010004000200062Q0001001302013Q000426012Q001302012Q007B000100033Q00203B00010001000D4Q00025Q00202Q0002000200814Q00010002000200062Q0001000802010001000426012Q00080201002E150086000802010087000426012Q00080201002E710088001302010089000426012Q001302012Q007B000100034Q008D010200013Q00122Q0003008A3Q00122Q0004008B6Q00020004000200202Q00010002008C4Q000100013Q00122Q0002008D3Q00122Q0003008E6Q000100036Q00015Q00126C3Q004F3Q002E5D008F000100010090000426012Q000100010026C53Q001A0201004F000426012Q001A0201002E710092000100010091000426012Q00010001002E710093003102010094000426012Q003102012Q007B00016Q004B010200013Q00122Q000300953Q00122Q000400966Q0002000400024Q00010001000200202Q0001000100054Q00010002000200062Q0001003102013Q000426012Q003102012Q007B000100043Q0020DA00010001000F4Q00035Q00202Q0003000300714Q00010003000200062Q0001003102013Q000426012Q003102012Q007B000100054Q00332Q010001000200067C0001003302010001000426012Q00330201002E040197001E00010098000426012Q004F02012Q007B000100033Q00203B00010001000D4Q00025Q00202Q0002000200714Q00010002000200062Q0001003C02010001000426012Q003C0201002E71009A004F02010099000426012Q004F020100126C000100013Q0026C50001004302010001000426012Q00430201002E15009B00430201009C000426012Q00430201002E5D009E003D0201009D000426012Q003D02012Q007B000200034Q00E2000300013Q00122Q0004009F3Q00122Q000500A06Q00030005000200202Q0002000300A14Q000200013Q00122Q000300A23Q00122Q000400A36Q000200046Q00025Q00044Q003D0201002E5D00A400B6020100A5000426012Q00B602012Q007B00016Q004B010200013Q00122Q000300A63Q00122Q000400A76Q0002000400024Q00010001000200202Q0001000100054Q00010002000200062Q0001008E02013Q000426012Q008E02012Q007B000100043Q0020DA00010001000F4Q00035Q00202Q0003000300A84Q00010003000200062Q0001008E02013Q000426012Q008E02012Q007B00016Q004B010200013Q00122Q000300A93Q00122Q000400AA6Q0002000400024Q00010001000200202Q0001000100084Q00010002000200062Q0001008E02013Q000426012Q008E02012Q007B00016Q0087010200013Q00122Q000300AB3Q00122Q000400AC6Q0002000400024Q00010001000200202Q0001000100AD4Q000100020002000E66014F008E02010001000426012Q008E02012Q007B000100023Q0020AC0001000100AE2Q007B00035Q0020820003000300AF2Q00A82Q0100030002000E6601B0008E02010001000426012Q008E02012Q007B000100023Q0020DA0001000100094Q00035Q00202Q0003000300364Q00010003000200062Q0001008702013Q000426012Q008702012Q007B0001000D3Q002616000100900201006A000426012Q009002012Q007B000100023Q0020AB2Q01000100094Q00035Q00202Q0003000300B14Q00010003000200062Q0001009002010001000426012Q00900201002E7100B200B6020100B3000426012Q00B602012Q007B000100033Q0020472Q010001000D4Q00025Q00202Q0002000200A84Q00010002000200062Q000100B602013Q000426012Q00B6020100126C000100014Q003A000200023Q0026AB0001009902010001000426012Q0099020100126C000200013Q002E5D00B4009C020100B5000426012Q009C02010026AB0002009C02010001000426012Q009C020100126C000300013Q0026C5000300A702010001000426012Q00A70201002E1500B600A7020100B7000426012Q00A70201002E7100B900A1020100B8000426012Q00A102012Q007B000400034Q00E2000500013Q00122Q000600BA3Q00122Q000700BB6Q00050007000200202Q0004000500BC4Q000400013Q00122Q000500BD3Q00122Q000600BE6Q000400066Q00045Q00044Q00A10201000426012Q009C0201000426012Q00B60201000426012Q0099020100126C3Q00023Q000426012Q000100012Q0045012Q00017Q00913Q00030E3Q00E089E4F38CC782E4EC8CE795F5F703053Q00E9A2EC9084030A3Q0049734361737461626C65030E3Q0049735370652Q6C496E52616E6765030E3Q00426574772Q656E7468654579657303093Q0091D6FF19B2E557BDD003073Q003FD2A49E7AD996030B3Q004973417661696C61626C65030B3Q0042752Q6652656D61696E73026Q00104003163Q001AC6E6FE46EE36CFD4E95DEF36CEF8D841FD16D2F3FF03063Q009853AB968C2903113Q00A5F78636DA08038BEB9004DD180387F79003073Q0068E285E353B47B03073Q0048617354696572026Q003E4003083Q0042752Q66446F776E03113Q0047722Q656E736B696E735769636B657273025Q00D49640025Q0080AA40030B3Q0043617374502Q6F6C696E67028Q00025Q00D89540025Q00C89040025Q00989F40025Q007FB04003103Q00310E3745110510580C1E2F54000A304403043Q0030636B43024Q00343F134103153Q00FDA76EC46D59DBB26AD528759EB275D56D5EC7A36E03063Q001BBEC61DB04D030E3Q00CD4EE923AC4BE15FF5318C57EA5803063Q002E8F2B9D54C903093Q00746A57C15400C0586C03073Q00A8371836A23F7303063Q0021FB2E89C1C603063Q00AE779A40E0B2030F3Q00432Q6F6C646F776E52656D61696E73025Q00804640030B3Q001976C47F0AB03EE5247DC003083Q00844A1EA51B65C77A026Q002840025Q007AAF40025Q00C6A840025Q00D0A340025Q00A0B04003103Q001DE2EBB2B5BB8727E8EAABA3B6B53CF303073Q00D44F879F2QC7D503153Q005AA1A6531CF51D6DB7B04252970C71A5F56245D20B03073Q007819C0D5273CB7025Q0004A940025Q0009B040030C3Q002B4C364B1D41314C3C493C4D03043Q002878205F03143Q0046696C7465726564466967687452656D61696E7303013Q003E030C3Q00536C696365616E6444696365026Q00F03F02CD5QCCFC3F025Q006CA540025Q00805040025Q00F09B40025Q00A07840025Q00AEA040025Q00A5B040025Q00D0A640025Q008EA140025Q002C9840025Q008C9A40025Q0007B040025Q0040A940025Q00206640025Q00F6A84003103Q0008AE2D6FBD1109A3366FA31B39AA2A6E03063Q007F5ACB591ACF024Q00A041134103133Q00FE34BCDF49CED13CACCE49FCD3312QEF00FED803063Q009DBD55CFAB69025Q00E08840025Q007CA040030C3Q00EDA8D4B90AC8A6EBA511C3A403053Q0063A6C1B8D5030C3Q004B692Q6C696E675370722Q6503083Q00446562752Q665570030D3Q0047686F73746C79537472696B65030D3Q00F1BF8FA81886CF8494A90581D303063Q00EAB6D7E0DB6C025Q00989A40025Q00C6AE40025Q00B4A040025Q00708840025Q00849040025Q00689B4003043Q0043617374025Q005EA340025Q0044A240025Q00588D40025Q00FCA840025Q00549940025Q0040AF40025Q008AA640025Q00589940025Q0056B340025Q00E08D40025Q00E3B240025Q00406E40025Q005EAF4003103Q00F284AF20D28F883DCF94B731C380A82103043Q0055A0E1DB024Q00403DE94003123Q007F0490DD76F74250098AC7319C784C1786CC03073Q002B3C65E3A956BC03093Q0053C7DDBB78C0B6387403083Q005710A8B1DF3AACD903093Q00436F6C64426C2Q6F6403083Q004469737061746368025Q0084AD40025Q00508E40025Q0068A340025Q007CB040025Q0050A340025Q0006AD40025Q00A6A740025Q0058A140025Q00E07A40025Q0070784003103Q0006C84DC8293AFE51D22E38C95ADC282003053Q005B54AD39BD024Q0094541741030F3Q0033B81FE8E0F51FB508BC82DA1FB60803063Q00B670D96C9CC003083Q008E015BFF8ABE0B4003053Q00EBCA68288F025Q00DEA540025Q00C4AC40025Q00FC9040025Q00E88140025Q00F89240025Q00A08340025Q00F4934003103Q003F8E0FAC1F8528B1029E17BD0E8A08AD03043Q00D96DEB7B025Q0064A040030D3Q0004886D4230F4C4AE37886A557803083Q00DD47E91E3610B0AD00F7013Q007B8Q004B2Q0100013Q00122Q000200013Q00122Q000300026Q0001000300028Q000100206Q00036Q0002000200064Q006A00013Q000426012Q006A00012Q007B3Q00023Q0020DA5Q00044Q00025Q00202Q0002000200056Q0002000200064Q006A00013Q000426012Q006A00012Q007B8Q0022000100013Q00122Q000200063Q00122Q000300076Q0001000300028Q000100206Q00086Q0002000200064Q006A00010001000426012Q006A00012Q007B3Q00033Q0020F05Q00094Q00025Q00202Q0002000200056Q0002000200264Q003D0001000A000426012Q003D00012Q007B8Q0022000100013Q00122Q0002000B3Q00122Q0003000C6Q0001000300028Q000100206Q00086Q0002000200064Q003D00010001000426012Q003D00012Q007B8Q0022000100013Q00122Q0002000D3Q00122Q0003000E6Q0001000300028Q000100206Q00086Q0002000200064Q003D00010001000426012Q003D00012Q007B3Q00033Q00204F5Q000F00122Q000200103Q00122Q0003000A8Q0003000200064Q006A00013Q000426012Q006A00012Q007B3Q00033Q0020DA5Q00114Q00025Q00202Q0002000200126Q0002000200064Q006A00013Q000426012Q006A0001002E710013006A00010014000426012Q006A00012Q007B3Q00043Q002047014Q00154Q00015Q00202Q0001000100056Q0002000200064Q006A00013Q000426012Q006A000100126C3Q00164Q003A000100013Q0026AB3Q004F00010016000426012Q004F000100126C000100163Q0026C50001005600010016000426012Q00560001002E710017005200010018000426012Q0052000100126C000200163Q002E5D001900570001001A000426012Q005700010026AB0002005700010016000426012Q005700012Q007B000300044Q00E2000400013Q00122Q0005001B3Q00122Q0006001C6Q00040006000200202Q00030004001D4Q000300013Q00122Q0004001E3Q00122Q0005001F6Q000300056Q00035Q00044Q00570001000426012Q00520001000426012Q006A0001000426012Q004F00012Q007B8Q004B2Q0100013Q00122Q000200203Q00122Q000300216Q0001000300028Q000100206Q00036Q0002000200064Q00BD00013Q000426012Q00BD00012Q007B3Q00023Q0020DA5Q00044Q00025Q00202Q0002000200056Q0002000200064Q00BD00013Q000426012Q00BD00012Q007B8Q004B2Q0100013Q00122Q000200223Q00122Q000300236Q0001000300028Q000100206Q00086Q0002000200064Q00BD00013Q000426012Q00BD00012Q007B8Q0035000100013Q00122Q000200243Q00122Q000300256Q0001000300028Q000100206Q00266Q00020002000E2Q002700BD00013Q000426012Q00BD00012Q007B8Q0035000100013Q00122Q000200283Q00122Q000300296Q0001000300028Q000100206Q00266Q00020002000E2Q002A00BD00013Q000426012Q00BD00012Q007B3Q00043Q002047014Q00154Q00015Q00202Q0001000100056Q0002000200064Q00BD00013Q000426012Q00BD000100126C3Q00163Q000E62001600A500013Q000426012Q00A50001002E71002B00A10001002C000426012Q00A1000100126C000100164Q003A000200023Q0026AB000100A700010016000426012Q00A7000100126C000200163Q002E71002D00AA0001002E000426012Q00AA00010026AB000200AA00010016000426012Q00AA00012Q007B000300044Q00E2000400013Q00122Q0005002F3Q00122Q000600306Q00040006000200202Q00030004001D4Q000300013Q00122Q000400313Q00122Q000500326Q000300056Q00035Q00044Q00AA0001000426012Q00A10001000426012Q00A70001000426012Q00A10001002E71003300222Q010034000426012Q00222Q012Q007B8Q004B2Q0100013Q00122Q000200353Q00122Q000300366Q0001000300028Q000100206Q00036Q0002000200064Q00222Q013Q000426012Q00222Q012Q007B3Q00053Q0020825Q00372Q007B000100063Q00126C000200384Q007B000300033Q0020AC0003000300092Q007B00055Q0020820005000500392Q00A80103000500022Q0077000400014Q00A8012Q0004000200067C3Q00DD00010001000426012Q00DD00012Q007B3Q00033Q0020AC5Q00092Q007B00025Q0020820002000200392Q00A8012Q000200020026AB3Q00222Q010016000426012Q00222Q012Q007B3Q00033Q00201D5Q00094Q00025Q00202Q0002000200396Q000200024Q000100073Q00122Q0002003A6Q000300086Q0001000300024Q000200093Q00122Q0003003A4Q007B000400084Q00A80102000400022Q00432Q01000100020020DB00010001003B00068F012Q00222Q010001000426012Q00222Q012Q007B3Q00043Q00203B5Q00154Q00015Q00202Q0001000100396Q0002000200064Q00F700010001000426012Q00F70001002E5D003C00222Q01003D000426012Q00222Q0100126C3Q00164Q003A000100013Q0026C53Q00FD00010016000426012Q00FD0001002E71003E00F90001003F000426012Q00F9000100126C000100163Q002E71004000FE00010041000426012Q00FE0001002E71004300FE00010042000426012Q00FE00010026AB000100FE00010016000426012Q00FE000100126C000200164Q003A000300033Q0026C50002000A2Q010016000426012Q000A2Q01002E04014400FEFF2Q0045000426012Q00062Q0100126C000300163Q002E5D0047000B2Q010046000426012Q000B2Q01002E710048000B2Q010049000426012Q000B2Q010026AB0003000B2Q010016000426012Q000B2Q012Q007B000400044Q00E2000500013Q00122Q0006004A3Q00122Q0007004B6Q00050007000200202Q00040005004C4Q000400013Q00122Q0005004D3Q00122Q0006004E6Q000400066Q00045Q00044Q000B2Q01000426012Q00FE0001000426012Q00062Q01000426012Q00FE0001000426012Q00222Q01000426012Q00F90001002E71004F00462Q010050000426012Q00462Q012Q007B8Q004B2Q0100013Q00122Q000200513Q00122Q000300526Q0001000300028Q000100206Q00036Q0002000200064Q00462Q013Q000426012Q00462Q012Q007B3Q00023Q0020DA5Q00044Q00025Q00202Q0002000200536Q0002000200064Q00462Q013Q000426012Q00462Q012Q007B3Q00023Q0020AB014Q00544Q00025Q00202Q0002000200556Q0002000200064Q00482Q010001000426012Q00482Q012Q007B8Q004B2Q0100013Q00122Q000200563Q00122Q000300576Q0001000300028Q000100206Q00086Q0002000200064Q00482Q013Q000426012Q00482Q01002E71005900842Q010058000426012Q00842Q01002E71005B00842Q01005A000426012Q00842Q01002E71005C00842Q01005D000426012Q00842Q012Q007B3Q00043Q002047014Q005E4Q00015Q00202Q0001000100536Q0002000200064Q00842Q013Q000426012Q00842Q0100126C3Q00164Q003A000100013Q0026C53Q005B2Q010016000426012Q005B2Q01002E4D015F005B2Q010060000426012Q005B2Q01002E5D006200552Q010061000426012Q00552Q0100126C000100163Q002E0401633Q00010063000426012Q005C2Q010026AB0001005C2Q010016000426012Q005C2Q0100126C000200164Q003A000300033Q000ED3001600622Q010002000426012Q00622Q0100126C000300163Q002E5D006500652Q010064000426012Q00652Q010026C50003006B2Q010016000426012Q006B2Q01002E04016600FCFF2Q0067000426012Q00652Q0100126C000400163Q000E62001600722Q010004000426012Q00722Q01002ED2006900722Q010068000426012Q00722Q01002E71006B006C2Q01006A000426012Q006C2Q012Q007B000500044Q00E2000600013Q00122Q0007006C3Q00122Q0008006D6Q00060008000200202Q00050006006E4Q000500013Q00122Q0006006F3Q00122Q000700706Q000500076Q00055Q00044Q006C2Q01000426012Q00652Q01000426012Q005C2Q01000426012Q00622Q01000426012Q005C2Q01000426012Q00842Q01000426012Q00552Q012Q007B8Q004B2Q0100013Q00122Q000200713Q00122Q000300726Q0001000300028Q000100206Q00036Q0002000200064Q009C2Q013Q000426012Q009C2Q012Q007B3Q00033Q0020DA5Q00114Q00025Q00202Q0002000200736Q0002000200064Q009C2Q013Q000426012Q009C2Q012Q007B3Q00023Q0020AB014Q00044Q00025Q00202Q0002000200746Q0002000200064Q009E2Q010001000426012Q009E2Q01002E5D007500C12Q010076000426012Q00C12Q012Q007B3Q00043Q002Q20014Q005E4Q00015Q00202Q0001000100734Q000200028Q0002000200064Q00AA2Q010001000426012Q00AA2Q01002ED2007800AA2Q010077000426012Q00AA2Q01002E71007A00C12Q010079000426012Q00C12Q0100126C3Q00163Q0026AB3Q00AB2Q010016000426012Q00AB2Q0100126C000100163Q0026C5000100B42Q010016000426012Q00B42Q01002ED2007B00B42Q01007C000426012Q00B42Q01002E71007D00AE2Q01007E000426012Q00AE2Q012Q007B000200044Q00E2000300013Q00122Q0004007F3Q00122Q000500806Q00030005000200202Q0002000300814Q000200013Q00122Q000300823Q00122Q000400836Q000200046Q00025Q00044Q00AE2Q01000426012Q00AB2Q012Q007B8Q004B2Q0100013Q00122Q000200843Q00122Q000300856Q0001000300028Q000100206Q00036Q0002000200064Q00D22Q013Q000426012Q00D22Q012Q007B3Q00023Q0020AB014Q00044Q00025Q00202Q0002000200746Q0002000200064Q00D42Q010001000426012Q00D42Q01002E5D008700F62Q010086000426012Q00F62Q012Q007B3Q00043Q002047014Q00154Q00015Q00202Q0001000100746Q0002000200064Q00F62Q013Q000426012Q00F62Q0100126C3Q00164Q003A000100013Q002E0401883Q00010088000426012Q00DD2Q010026AB3Q00DD2Q010016000426012Q00DD2Q0100126C000100163Q0026C5000100E82Q010016000426012Q00E82Q01002E4D018A00E82Q010089000426012Q00E82Q01002E71008C00E22Q01008B000426012Q00E22Q012Q007B000200044Q00E2000300013Q00122Q0004008D3Q00122Q0005008E6Q00030005000200202Q00020003008F4Q000200013Q00122Q000300903Q00122Q000400916Q000200046Q00025Q00044Q00E22Q01000426012Q00F62Q01000426012Q00DD2Q012Q0045012Q00017Q008C3Q00025Q00B4A84003103Q0011FF56B03DF2598D31EC4CB639FD50BB03043Q00DF549C3E03073Q004973526561647903043Q004361737403103Q004563686F696E6752657072696D616E64025Q000EA540025Q0068A84003103Q00E4F9F6C8A535E5F4EDC8BB3FD5FDF1C903063Q005BB69C82BDD7024Q006CBF134103163Q005D72BF413E56AF5D717AA2523E41A9456C7AA154707703043Q00351E13CC03063Q00D8ED7291B4F103053Q00C7998010E4030A3Q0049734361737461626C6503113Q00F923E11DA2DF05F509A8C33EF017AEC53303053Q00C7B14A8579030B3Q004973417661696C61626C6503063Q0042752Q665570030C3Q00417564616369747942752Q66025Q00E2AD40025Q0050AC40030B3Q0043617374502Q6F6C696E67030A3Q002Q534175646163697479030E3Q0049735370652Q6C496E52616E676503063Q00416D62757368028Q00025Q00805140025Q004AB340025Q002Q8040025Q00889540025Q00BCAF40025Q0068844003103Q008ACCA8EB25C819B0C6A9F233C52BABDD03073Q004AD8A9DC9E57A6025Q00F2C040031E3Q00CB2200381AC92E113949E0635B0453EF2B5E1C48E12C530E4FEE2516281303053Q003A8843734C025Q00D6A840025Q00CAA140030C3Q00D7ABD66D8D25835CFCA7DD4B03083Q003D91CAB839E540CB03083Q007D478D465F5B9D5E03043Q00273C32E903113Q00323AA72887269DB30A3CB1389726BBB72Q03083Q00C37A53C34CE248D2030B3Q004F2Q706F7274756E69747903083Q0042752Q66446F776E030A3Q00506973746F6C53686F74025Q00407740025Q00DCAD40025Q00CC9D40025Q0080B240025Q0062B340025Q0092B04003103Q00D6D12FEB33EAE733F134E8D038FF32F003053Q004184B45B9E024Q0018AD0641031B3Q00267DC23A454CD83D1173DD6E3674DE3A4534F03B017DD22711659803043Q004E651CB1030C3Q0003B5EE652DB1C85028B9E54303043Q003145D48003093Q0042752Q66537461636B026Q001840030B3Q0042752Q6652656D61696E73027Q0040025Q00688240025Q00E0A640025Q00588440025Q0094A040025Q00107C40025Q0086AD40025Q00249940025Q00FAA540025Q00D08F40025Q00C0994003103Q002509C4E7F3193FD8FDF41B08D3F3F22Q03053Q0081776CB092031B3Q001FCE14D9653E152FDB08C1653D1433DB4785031A347CEB12C0354703073Q007C5CAF67AD456E030C3Q00E7390D03C93D2B36CC35062503043Q0057A15863026Q00F03F03093Q0023ECE6CFBCF43113EE03073Q004372998FACD7B003093Q0042726F616473696465030C3Q0098A3E03AB6A7C60FB3AFEB1C03043Q006EDEC28E030A3Q0054616C656E7452616E6B030C3Q0025CC0FA15EA404CA15AC41B203063Q00C177B97BC932026Q007340025Q00F4AE40025Q0064A240025Q00BFB040025Q003CA340025Q0092A340025Q00289D40025Q0053B140025Q000FB34003103Q00450DED331D772C7F07EC2A0B7A1E641C03073Q007F176899466F1903103Q002A06B5BB6B1CBEA01D08AAEF1824B8A703083Q00D36967C6CF4B4CD7025Q00389940025Q00B89F40030C3Q00E8A6BEDB760992B7C3AAB5FD03083Q00D6AEC7D08F1E6CDA026Q00F83F03093Q00209102A9AE72CA480603083Q002971E46BCAC536B803083Q005B983C5D79842C4503043Q003C1AED58025Q00588240025Q00C4B040025Q00606740025Q00C89340025Q00FC9B40025Q0064AA4003103Q00EA2F60F3BCD6197CE9BBD42E77E7BDCC03053Q00CEB84A148603103Q001BE5FDA5B37A31DF2CEBE2F1C04237D803083Q00AC58848ED1932A58030E3Q00B483C20425E1BB95B9D81F3FFEBB03073Q00DEE7EAAC6D5695030E3Q0053696E6973746572537472696B65026Q003740025Q00F07640025Q00CEAA40025Q00CEA340025Q00F0A540025Q008CA640025Q00BAA440026Q00A74003103Q00DFEAD40DFFE1F310E2FACC1C2QEED30C03043Q00788D8FA0024Q001899074103143Q0063ADA546009FBF5C49BFA25752EC854652A5BD5703043Q003220CCD600A0022Q002E042Q01002500010001000426012Q002500012Q007B8Q0033012Q00010002000657012Q002500013Q000426012Q002500012Q007B3Q00014Q004B2Q0100023Q00122Q000200023Q00122Q000300036Q0001000300028Q000100206Q00046Q0002000200064Q002500013Q000426012Q002500012Q007B3Q00033Q002Q20014Q00054Q000100013Q00202Q0001000100064Q000200038Q0003000200064Q001A00010001000426012Q001A0001002E5D0008002500010007000426012Q002500012Q007B3Q00034Q008D2Q0100023Q00122Q000200093Q00122Q0003000A6Q00010003000200204Q0001000B6Q00023Q00122Q0001000C3Q00122Q0002000D8Q00029Q004Q007B3Q00014Q004B2Q0100023Q00122Q0002000E3Q00122Q0003000F6Q0001000300028Q000100206Q00106Q0002000200064Q004000013Q000426012Q004000012Q007B3Q00014Q004B2Q0100023Q00122Q000200113Q00122Q000300126Q0001000300028Q000100206Q00136Q0002000200064Q004000013Q000426012Q004000012Q007B3Q00043Q0020AB014Q00144Q000200013Q00202Q0002000200156Q0002000200064Q004200010001000426012Q00420001002E710016006B00010017000426012Q006B00012Q007B3Q00033Q002039014Q00184Q000100013Q00202Q0001000100194Q000200026Q000300053Q00202Q00030003001A4Q000500013Q00202Q00050005001B4Q0003000500024Q000300038Q0003000200064Q006B00013Q000426012Q006B000100126C3Q001C4Q003A000100013Q0026C53Q00560001001C000426012Q00560001002E71001E00520001001D000426012Q0052000100126C0001001C3Q0026C50001005D0001001C000426012Q005D0001002E4D0120005D0001001F000426012Q005D0001002E710021005700010022000426012Q005700012Q007B000200034Q00E2000300023Q00122Q000400233Q00122Q000500246Q00030005000200202Q0002000300254Q000200023Q00122Q000300263Q00122Q000400276Q000200046Q00025Q00044Q00570001000426012Q006B0001000426012Q00520001002E5D002900C200010028000426012Q00C200012Q007B3Q00014Q004B2Q0100023Q00122Q0002002A3Q00122Q0003002B6Q0001000300028Q000100206Q00136Q0002000200064Q00C200013Q000426012Q00C200012Q007B3Q00014Q004B2Q0100023Q00122Q0002002C3Q00122Q0003002D6Q0001000300028Q000100206Q00136Q0002000200064Q00C200013Q000426012Q00C200012Q007B3Q00014Q004B2Q0100023Q00122Q0002002E3Q00122Q0003002F6Q0001000300028Q000100206Q00136Q0002000200064Q00C200013Q000426012Q00C200012Q007B3Q00043Q0020DA5Q00144Q000200013Q00202Q0002000200306Q0002000200064Q00C200013Q000426012Q00C200012Q007B3Q00043Q0020DA5Q00314Q000200013Q00202Q0002000200156Q0002000200064Q00C200013Q000426012Q00C200012Q007B3Q00033Q002039014Q00184Q000100013Q00202Q0001000100324Q000200026Q000300053Q00202Q00030003001A4Q000500013Q00202Q0005000500324Q0003000500024Q000300038Q0003000200064Q00C200013Q000426012Q00C2000100126C3Q001C4Q003A000100013Q002E71003300A900010034000426012Q00A900010026AB3Q00A90001001C000426012Q00A9000100126C0001001C3Q002E71003500AE00010036000426012Q00AE00010026C5000100B40001001C000426012Q00B40001002E04013700FCFF2Q0038000426012Q00AE00012Q007B000200034Q00E2000300023Q00122Q000400393Q00122Q0005003A6Q00030005000200202Q00020003003B4Q000200023Q00122Q0003003C3Q00122Q0004003D6Q000200046Q00025Q00044Q00AE0001000426012Q00C20001000426012Q00A900012Q007B3Q00014Q004B2Q0100023Q00122Q0002003E3Q00122Q0003003F6Q0001000300028Q000100206Q00136Q0002000200064Q00E100013Q000426012Q00E100012Q007B3Q00043Q0020DA5Q00144Q000200013Q00202Q0002000200306Q0002000200064Q00E100013Q000426012Q00E100012Q007B3Q00043Q00201A5Q00404Q000200013Q00202Q0002000200306Q00020002000E2Q004100E300013Q000426012Q00E300012Q007B3Q00043Q0020F05Q00424Q000200013Q00202Q0002000200306Q0002000200264Q00E300010043000426012Q00E30001002E710045000E2Q010044000426012Q000E2Q012Q007B3Q00033Q002067014Q00184Q000100013Q00202Q0001000100324Q000200026Q000300053Q00202Q00030003001A4Q000500013Q00202Q0005000500324Q0003000500024Q000300034Q00A8012Q0003000200067C3Q00F300010001000426012Q00F30001002E040146001D00010047000426012Q000E2Q0100126C3Q001C4Q003A000100013Q0026C53Q00F90001001C000426012Q00F90001002E71004900F500010048000426012Q00F5000100126C0001001C3Q002E5D004A00FA0001004B000426012Q00FA0001002E5D004C00FA0001004D000426012Q00FA0001000ED3001C00FA00010001000426012Q00FA00012Q007B000200034Q00E2000300023Q00122Q0004004E3Q00122Q0005004F6Q00030005000200202Q00020003003B4Q000200023Q00122Q000300503Q00122Q000400516Q000200046Q00025Q00044Q00FA0001000426012Q000E2Q01000426012Q00F500012Q007B3Q00014Q004B2Q0100023Q00122Q000200523Q00122Q000300536Q0001000300028Q000100206Q00136Q0002000200064Q00E92Q013Q000426012Q00E92Q012Q007B3Q00043Q0020DA5Q00144Q000200013Q00202Q0002000200306Q0002000200064Q00E92Q013Q000426012Q00E92Q012Q007B3Q00064Q007B000100073Q00126C000200544Q007B000300074Q00EC000400086Q000500016Q000600023Q00122Q000700553Q00122Q000800566Q0006000800024Q00050005000600202Q0005000500134Q000500066Q00043Q00022Q007B000500084Q007B000600043Q0020AC0006000600142Q007B000800013Q0020820008000800572Q007A010600084Q009100056Q009C00033Q00022Q007B000400094Q00EC000500086Q000600016Q000700023Q00122Q000800553Q00122Q000900566Q0007000900024Q00060006000700202Q0006000600134Q000600076Q00053Q00022Q007B000600084Q0044010700043Q00202Q0007000700144Q000900013Q00202Q0009000900574Q000700096Q00068Q00043Q00024Q0003000300044Q000400076Q000500014Q0087010600023Q00122Q000700583Q00122Q000800596Q0006000800024Q00050005000600202Q00050005005A4Q00050002000200126C000600544Q00A80104000600022Q007B000500094Q007B000600014Q0087010700023Q00122Q000800583Q00122Q000900596Q0007000900024Q00060006000700202Q00060006005A4Q000600020002002Q12010700546Q0005000700024Q0004000400054Q0003000300044Q0001000300024Q000200093Q00122Q000300546Q000400076Q000500086Q000600014Q006A010700023Q00122Q000800553Q00122Q000900566Q0007000900024Q0006000600070020AC0006000600132Q002D000600074Q009C00053Q00022Q007B000600084Q007B000700043Q0020AC0007000700142Q007B000900013Q0020820009000900572Q007A010700094Q009100066Q009C00043Q00022Q007B000500094Q00EC000600086Q000700016Q000800023Q00122Q000900553Q00122Q000A00566Q0008000A00024Q00070007000800202Q0007000700134Q000700086Q00063Q00022Q007B000700084Q0044010800043Q00202Q0008000800144Q000A00013Q00202Q000A000A00574Q0008000A6Q00078Q00053Q00024Q0004000400054Q000500076Q000600014Q0087010700023Q00122Q000800583Q00122Q000900596Q0007000900024Q00060006000700202Q00060006005A4Q00060002000200126C000700544Q00A80105000700022Q007B000600094Q007B000700014Q0087010800023Q00122Q000900583Q00122Q000A00596Q0008000A00024Q00070007000800202Q00070007005A4Q00070002000200121B000800546Q0006000800024Q0005000500064Q0004000400054Q0002000400024Q00010001000200062Q0001000E00013Q000426012Q00B42Q012Q007B3Q000A4Q00EC000100086Q000200016Q000300023Q00122Q0004005B3Q00122Q0005005C6Q0003000500024Q00020002000300202Q0002000200134Q000200036Q00013Q00020006C63Q00E92Q010001000426012Q00E92Q012Q007B3Q00033Q002039014Q00184Q000100013Q00202Q0001000100324Q000200026Q000300053Q00202Q00030003001A4Q000500013Q00202Q0005000500324Q0003000500024Q000300038Q0003000200064Q00E92Q013Q000426012Q00E92Q0100126C3Q001C4Q003A000100013Q002E5D005D00C42Q01005E000426012Q00C42Q01002E04015F00FEFF2Q005F000426012Q00C42Q010026AB3Q00C42Q01001C000426012Q00C42Q0100126C0001001C3Q0026C5000100CF2Q01001C000426012Q00CF2Q01002E71006000CB2Q010061000426012Q00CB2Q0100126C0002001C3Q002E5D006300D02Q010062000426012Q00D02Q010026AB000200D02Q01001C000426012Q00D02Q0100126C0003001C3Q002E71006400D52Q010065000426012Q00D52Q010026AB000300D52Q01001C000426012Q00D52Q012Q007B000400034Q00E2000500023Q00122Q000600663Q00122Q000700676Q00050007000200202Q00040005003B4Q000400023Q00122Q000500683Q00122Q000600696Q000400066Q00045Q00044Q00D52Q01000426012Q00D02Q01000426012Q00CB2Q01000426012Q00E92Q01000426012Q00C42Q01002E5D006A00320201006B000426012Q003202012Q007B3Q00014Q0022000100023Q00122Q0002006C3Q00122Q0003006D6Q0001000300028Q000100206Q00136Q0002000200064Q003202010001000426012Q003202012Q007B3Q00043Q0020DA5Q00144Q000200013Q00202Q0002000200306Q0002000200064Q003202013Q000426012Q003202012Q007B3Q000B3Q000E4A016E003402013Q000426012Q003402012Q007B3Q00064Q00EA000100073Q00122Q000200546Q000300086Q000400043Q00202Q0004000400144Q000600013Q00202Q0006000600574Q000400066Q00038Q00013Q00024Q000200093Q00122Q000300546Q000400086Q000500043Q00202Q0005000500144Q000700013Q00202Q0007000700574Q000500076Q00048Q00023Q00024Q00010001000200064Q001E00010001000426012Q003402012Q007B3Q00014Q0022000100023Q00122Q0002006F3Q00122Q000300706Q0001000300028Q000100206Q00136Q0002000200064Q003402010001000426012Q003402012Q007B3Q00014Q004B2Q0100023Q00122Q000200713Q00122Q000300726Q0001000300028Q000100206Q00136Q0002000200064Q003202013Q000426012Q003202012Q007B3Q00043Q0020AB014Q00314Q000200013Q00202Q0002000200156Q0002000200064Q003402010001000426012Q00340201002E710074005F02010073000426012Q005F02012Q007B3Q00033Q002039014Q00184Q000100013Q00202Q0001000100324Q000200026Q000300053Q00202Q00030003001A4Q000500013Q00202Q0005000500324Q0003000500024Q000300038Q0003000200064Q005F02013Q000426012Q005F020100126C3Q001C4Q003A000100013Q002E710075004402010076000426012Q004402010026AB3Q00440201001C000426012Q0044020100126C0001001C3Q0026AB000100490201001C000426012Q0049020100126C0002001C3Q0026C5000200500201001C000426012Q00500201002E04017700FEFF2Q0078000426012Q004C02012Q007B000300034Q00E2000400023Q00122Q000500793Q00122Q0006007A6Q00040006000200202Q00030004003B4Q000300023Q00122Q0004007B3Q00122Q0005007C6Q000300056Q00035Q00044Q004C0201000426012Q00490201000426012Q005F0201000426012Q004402012Q007B3Q00014Q004B2Q0100023Q00122Q0002007D3Q00122Q0003007E6Q0001000300028Q000100206Q00106Q0002000200064Q009F02013Q000426012Q009F02012Q007B3Q00053Q0020DA5Q001A4Q000200013Q00202Q00020002007F6Q0002000200064Q009F02013Q000426012Q009F0201002E5D0080009F02010081000426012Q009F0201002E5D0083009F02010082000426012Q009F02012Q007B3Q00033Q002039014Q00184Q000100013Q00202Q00010001007F4Q000200026Q000300053Q00202Q00030003001A4Q000500013Q00202Q00050005007F4Q0003000500024Q000300038Q0003000200064Q009F02013Q000426012Q009F020100126C3Q001C4Q003A000100013Q002E710084008402010085000426012Q008402010026AB3Q00840201001C000426012Q0084020100126C0001001C3Q002E5D0086008902010087000426012Q008902010026AB000100890201001C000426012Q0089020100126C0002001C3Q000ED3001C008E02010002000426012Q008E02012Q007B000300034Q00E2000400023Q00122Q000500883Q00122Q000600896Q00040006000200202Q00030004008A4Q000300023Q00122Q0004008B3Q00122Q0005008C6Q000300056Q00035Q00044Q008E0201000426012Q00890201000426012Q009F0201000426012Q008402012Q0045012Q00017Q00E03Q00028Q00026Q001040025Q00188840025Q00207E4003123Q004865726F526F746174696F6E43686172444203073Q0025A64671CC14BA03053Q00A071C92116025Q00C0674003073Q00E057ABA0A5A8C703063Q00CDB438CCC7C9026Q00204003123Q00476574496E76656E746F72794974656D494403063Q0093D23D0186CC03043Q0078E3BE5C026Q002A4003063Q002D501E62264E03083Q00825D3C7F1B433CB9026Q002C40026Q001440026Q001C40026Q00A840025Q00A8A040025Q0004954003063Q00FFD1D619D1D303043Q0075B0A4A2030D3Q00B7CA04F4D56EA0C30BF3DF5AA003063Q0019E4A26590BA2Q033Q006B12AA03063Q00842856D96E9203063Q0051DE33B0A66403083Q003E1EAB47DCC7139C030D3Q00734DAD3252DE0B4C4E46A9157903083Q002D2025CC563DA94F03093Q00665804B0B93C76711603063Q001C2Q3565DCD503063Q0022491C4D5BB603083Q00BF6D3C68213AC130030D3Q00B4DF19E388C03CE689D41DC4A303043Q0087E7B77803063Q00C7065BE52C0903073Q00C9866A2C84557A025Q00D2A740025Q00B6AD40026Q00F03F026Q003440025Q002AA640025Q00EFB14003063Q0073656C656374026Q002440030A3Q00556E6974446562752Q6603063Q0026007626041E03083Q0043566C175F616CA8024Q00F8590D41026Q00184003063Q00B4344D13A13603083Q0030C4582C6AC444B500025Q00A0AF40025Q00F8974003063Q0092D3DD3A85B603083Q004CE2BFBC43E0C4C203073Q0047657454696D65025Q00AEB240025Q00607E4003073Q006B3D3543EF4D6E03073Q001D2852582E802303073Q001E4BD51F0DBD3F03063Q00D85B25B47D61030A3Q0011790CF7452C7817C64303053Q003745167CA303073Q005BDC51E5D07F4303083Q009418B33C88BF113003073Q009724F8A2FAB72E03053Q0096D24A99C0030D3Q00C1C72C9E7A7780F1C13681706E03073Q00D483A858EA151A025Q009EAC40025Q006C914003073Q00667B848137295603063Q00472514E9EC5803073Q00E848B1144CE94803083Q003CAD26D076208C2C030A3Q00753DF1E732C64F39E4C703063Q00AF215281B34003073Q00CDE03DC233BCFD03063Q00D28E8F50AF5C03073Q009CE7F2C4B5ECF703043Q00A6D98993030D3Q00C1AC66B2FE4BD7B17BA8FA43F703063Q002683C312C691025Q0058B040025Q00C89F40025Q0014914003073Q0070D937E6375A4003063Q003433B65A8B5803073Q00D3B7D1E54FF3BD03053Q002396D9B087030D3Q00DB5F1F18784E42EB590507725703073Q001699306B6C172303073Q002D8AB617707B5203083Q00896EE5DB7A1F152103073Q003FB339793A4E2003083Q001E7ADD581B562B44030A3Q000C27FBB22A21E58D3D3C03043Q00E658488B025Q00BAA040025Q0068AE40025Q006DB040025Q00688B4003073Q00B248327EBF149503063Q0071E6275519D303073Q00EAB401EF2BCEB803083Q002BBEDB668847ABCB03073Q001671375E2E7B2303043Q0039421E50026Q00284003073Q001DD7A712883CE703083Q00E449B8C075E45994026Q002E40025Q0003B340025Q0076AC40025Q00A4B24003063Q005DA10217021F03073Q003812D4767B636803103Q003FEDEAD6D1DF12E0F6D6EDCB0DE1DBF703063Q00BE7E8998B3BF2Q033Q000B266103063Q0020486212ABCA03063Q002B9D2678F61303053Q009764E8521403103Q005EDDE40D71D8FA0171DCC41D6CD1D52C03043Q00681FB99603093Q00EFB4F2FBEB8CC3E4CF03083Q00A0BCD9939787AC8003063Q0020C804FC3BDE03063Q00A96FBD70905A03103Q00EC8737A8B181058BC38617B8AC882AA603083Q00E2ADE345CDDFE06903063Q007932355AD60803063Q007B385E423BAF025Q0082A340025Q0060804003063Q00D55667ED1BE903073Q00E19A2313817A9E03083Q006C01E55EE6EFF31003083Q00543A608B379587B02Q033Q00301BB003073Q005E735FC3602EAF03063Q006C5E2B312F3A03083Q0080232B5F5D4E4DE703083Q00921C383D04768A8003073Q00C9C47D5654771E03093Q00F0E305B3CFAE279BD003043Q00DFA38E6403063Q00AD03D7BDB99503053Q00D8E276A3D103083Q0088F1150844781C9A03073Q005FDE907B61371003063Q003888AD42FA0A03053Q008379E4DA23025Q003EAC40025Q00E8824003063Q00F6C5360D780C03063Q007BB9B0426119030F3Q00EF07164201234102DC1D105A100C7C03083Q0051A86F7931754F382Q033Q00E42EF603043Q00D6A76A8503063Q00062D5843356803073Q00B949582C2F541F030F3Q00AFDF15B3C7F391E40EB2DAF48DF43E03063Q009FE8B77AC0B303093Q00173FA92D28728B053703043Q00414452C803063Q000A45662CCED803073Q001E453012402QAF030F3Q00D72410FF2FFC352CF829F9271ACF1F03053Q005B904C7F8C03063Q00C1045120CAA903083Q00B080682641B3DAB5025Q0049B140025Q0016A340025Q00489940025Q009DB240027Q004003073Q00F932E4F6B0F00803073Q007BAD5D8391DC95026Q00394003073Q0022CBEA2678FC0503063Q009976A48D4114026Q003B4003073Q00DA3D81E5FB05FD03063Q00608E52E68297026Q00494003073Q007BBF4845E8EB5C03063Q008E2FD02F2284025Q00804940026Q000840025Q00A2B140025Q004AA64003073Q00FB867213C38C6603043Q0074AFE915026Q00354003073Q00CAF7B941D7342C03073Q005F9E98DE26BB51026Q00364003073Q00CCB232B5AFCDEB03063Q00A898DD55D2C3026Q00374003073Q009FD1F280A7DBE603043Q00E7CBBE95026Q00384003073Q00C2B103055759E503063Q003C96DE64623B026Q004A4003073Q0071335051D7BF2203073Q0051255C3736BBDA025Q00804A4003073Q00344BAA308D055703053Q00E16024CD57026Q003E4003073Q00DDA9457E704A1A03073Q006989C622191C2F026Q004B400083022Q00126C3Q00013Q0026C53Q000500010002000426012Q00050001002E710003002600010004000426012Q002600010012B9000100054Q0078000200013Q00122Q000300063Q00122Q000400076Q0002000400024Q00010001000200202Q0001000100084Q00015Q00122Q000100056Q000200013Q00122Q000300093Q00126C0004000A4Q002E0002000400024Q00010001000200202Q00010001000B4Q000100023Q00122Q0001000C6Q000200013Q00122Q0003000D3Q00122Q0004000E6Q00020004000200122Q0003000F4Q00A82Q01000300022Q00CA000100033Q0012B90001000C4Q007B000200013Q00126C000300103Q00126C000400114Q00A801020004000200126C000300124Q00A82Q01000300022Q00CA000100043Q00126C3Q00133Q0026C53Q002A00010014000426012Q002A0001002E5D0015009D00010016000426012Q009D0001002E040117004000010017000426012Q006A00012Q007B000100054Q002D010200013Q00122Q000300183Q00122Q000400196Q0002000400024Q0001000100024Q000200013Q00122Q0003001A3Q00122Q0004001B6Q0002000400024Q0001000100024Q000200013Q00122Q0003001C3Q00122Q0004001D6Q00020004000200062Q0001004100010002000426012Q004100012Q007B000100064Q00332Q010001000200067C0001006800010001000426012Q006800012Q007B000100054Q002D010200013Q00122Q0003001E3Q00122Q0004001F6Q0002000400024Q0001000100024Q000200013Q00122Q000300203Q00122Q000400216Q0002000400024Q0001000100024Q000200013Q00122Q000300223Q00122Q000400236Q00020004000200062Q0001005500010002000426012Q005500012Q007B000100073Q00067C0001006800010001000426012Q006800012Q007B000100054Q0053000200013Q00122Q000300243Q00122Q000400256Q0002000400024Q0001000100024Q000200013Q00122Q000300263Q00122Q000400276Q0002000400024Q0001000100024Q000200013Q00122Q000300283Q00122Q000400296Q00020004000200062Q0001006800010002000426012Q00680001002E5D002B006A0001002A000426012Q006A00012Q0077000100014Q00CA000100083Q00126C000100014Q001D2Q0100093Q00122Q0001002C3Q00122Q0002002D3Q00122Q0003002C3Q00042Q0001009C0001002E71002E009B0001002F000426012Q009B00010012B9000500303Q001270010600313Q00122Q000700326Q000800013Q00122Q000900333Q00122Q000A00346Q0008000A00024Q000900046Q000700096Q00053Q000200262Q0005009B00010035000426012Q009B00010012B9000500303Q00126C000600363Q0012B9000700324Q007B000800013Q00126C000900373Q00126C000A00384Q00A80108000A00022Q0013010900044Q007A010700094Q009C00053Q00020026C50005009B00010039000426012Q009B0001002E04013A00030001003B000426012Q008D0001000426012Q009B00010012B9000500303Q00121E010600363Q00122Q000700326Q000800013Q00122Q0009003C3Q00122Q000A003D6Q0008000A00024Q000900046Q000700096Q00053Q000200122Q0006003E6Q0006000100024Q0005000500064Q000500093Q00044C2Q0100700001000426012Q00820201002E5D004000292Q01003F000426012Q00292Q010026AB3Q00292Q010013000426012Q00292Q012Q007B000100054Q006F010200013Q00122Q000300413Q00122Q000400426Q0002000400024Q0001000100024Q000200013Q00122Q000300433Q00122Q000400446Q0002000400024Q0001000100024Q000200013Q00122Q000300453Q00122Q000400466Q0002000400024Q00010001000200062Q000100CB00010001000426012Q00CB00012Q007B000100054Q006F010200013Q00122Q000300473Q00122Q000400486Q0002000400024Q0001000100024Q000200013Q00122Q000300493Q00122Q0004004A6Q0002000400024Q0001000100024Q000200013Q00122Q0003004B3Q00122Q0004004C6Q0002000400024Q00010001000200062Q000100CB00010001000426012Q00CB00012Q00902Q0100024Q007B000200034Q007B000300044Q007D0001000200012Q00CA0001000A3Q000426012Q00222Q01002E71004E00F80001004D000426012Q00F800012Q007B000100054Q006F010200013Q00122Q0003004F3Q00122Q000400506Q0002000400024Q0001000100024Q000200013Q00122Q000300513Q00122Q000400526Q0002000400024Q0001000100024Q000200013Q00122Q000300533Q00122Q000400546Q0002000400024Q00010001000200062Q000100F100010001000426012Q00F100012Q007B000100054Q006F010200013Q00122Q000300553Q00122Q000400566Q0002000400024Q0001000100024Q000200013Q00122Q000300573Q00122Q000400586Q0002000400024Q0001000100024Q000200013Q00122Q000300593Q00122Q0004005A6Q0002000400024Q00010001000200062Q000100F300010001000426012Q00F30001002E5D005B00F80001005C000426012Q00F800012Q00902Q0100014Q007B000200034Q007D0001000100012Q00CA0001000A3Q000426012Q00222Q01002E04015D002A0001005D000426012Q00222Q012Q007B000100054Q006F010200013Q00122Q0003005E3Q00122Q0004005F6Q0002000400024Q0001000100024Q000200013Q00122Q000300603Q00122Q000400616Q0002000400024Q0001000100024Q000200013Q00122Q000300623Q00122Q000400636Q0002000400024Q00010001000200062Q000100222Q010001000426012Q00222Q012Q007B000100054Q0039000200013Q00122Q000300643Q00122Q000400656Q0002000400024Q0001000100024Q000200013Q00122Q000300663Q00122Q000400676Q0002000400024Q0001000100024Q000200013Q00122Q000300683Q00122Q000400696Q0002000400024Q00010001000200062Q000100222Q013Q000426012Q00222Q012Q00902Q0100014Q007B000200044Q007D0001000100012Q00CA0001000A4Q007700016Q00CA0001000B4Q007700016Q00CA0001000C4Q007700016Q00CA0001000D3Q00126C3Q00363Q000E620001002F2Q013Q000426012Q002F2Q01002ED2006B002F2Q01006A000426012Q002F2Q01002E5D006C00512Q01006D000426012Q00512Q010012B9000100054Q0078000200013Q00122Q0003006E3Q00122Q0004006F6Q0002000400024Q00010001000200202Q0001000100134Q0001000E3Q00122Q000100056Q000200013Q00122Q000300703Q00126C000400714Q009B0002000400024Q00010001000200202Q0001000100024Q000100073Q00122Q000100056Q000200013Q00122Q000300723Q00122Q000400736Q0002000400024Q0001000100020020820001000100742Q00AF0001000F3Q00122Q000100056Q000200013Q00122Q000300753Q00122Q000400766Q0002000400024Q00010001000200202Q0001000100774Q000100016Q000100103Q00126C3Q002C3Q002E04017800C300010078000426012Q00140201000ED30036001402013Q000426012Q001402012Q007700016Q00CA000100083Q002E5D007900952Q01007A000426012Q00952Q012Q007B000100054Q002D010200013Q00122Q0003007B3Q00122Q0004007C6Q0002000400024Q0001000100024Q000200013Q00122Q0003007D3Q00122Q0004007E6Q0002000400024Q0001000100024Q000200013Q00122Q0003007F3Q00122Q000400806Q00020004000200062Q0001006E2Q010002000426012Q006E2Q012Q007B000100064Q00332Q010001000200067C000100932Q010001000426012Q00932Q012Q007B000100054Q002D010200013Q00122Q000300813Q00122Q000400826Q0002000400024Q0001000100024Q000200013Q00122Q000300833Q00122Q000400846Q0002000400024Q0001000100024Q000200013Q00122Q000300853Q00122Q000400866Q00020004000200062Q000100822Q010002000426012Q00822Q012Q007B000100073Q00067C000100932Q010001000426012Q00932Q012Q007B000100054Q002D010200013Q00122Q000300873Q00122Q000400886Q0002000400024Q0001000100024Q000200013Q00122Q000300893Q00122Q0004008A6Q0002000400024Q0001000100024Q000200013Q00122Q0003008B3Q00122Q0004008C6Q00020004000200062Q000100952Q010002000426012Q00952Q012Q0077000100014Q00CA0001000B3Q002E71008E00D12Q01008D000426012Q00D12Q012Q007B000100054Q002D010200013Q00122Q0003008F3Q00122Q000400906Q0002000400024Q0001000100024Q000200013Q00122Q000300913Q00122Q000400926Q0002000400024Q0001000100024Q000200013Q00122Q000300933Q00122Q000400946Q00020004000200062Q000100AC2Q010002000426012Q00AC2Q012Q007B000100064Q00332Q010001000200067C000100D32Q010001000426012Q00D32Q012Q007B000100054Q002D010200013Q00122Q000300953Q00122Q000400966Q0002000400024Q0001000100024Q000200013Q00122Q000300973Q00122Q000400986Q0002000400024Q0001000100024Q000200013Q00122Q000300993Q00122Q0004009A6Q00020004000200062Q000100C02Q010002000426012Q00C02Q012Q007B000100073Q00067C000100D32Q010001000426012Q00D32Q012Q007B000100054Q0053000200013Q00122Q0003009B3Q00122Q0004009C6Q0002000400024Q0001000100024Q000200013Q00122Q0003009D3Q00122Q0004009E6Q0002000400024Q0001000100024Q000200013Q00122Q0003009F3Q00122Q000400A06Q00020004000200062Q000100D32Q010002000426012Q00D32Q01002E7100A100D52Q0100A2000426012Q00D52Q012Q0077000100014Q00CA0001000C4Q007B000100054Q002D010200013Q00122Q000300A33Q00122Q000400A46Q0002000400024Q0001000100024Q000200013Q00122Q000300A53Q00122Q000400A66Q0002000400024Q0001000100024Q000200013Q00122Q000300A73Q00122Q000400A86Q00020004000200062Q000100EA2Q010002000426012Q00EA2Q012Q007B000100064Q00332Q010001000200067C0001001102010001000426012Q001102012Q007B000100054Q002D010200013Q00122Q000300A93Q00122Q000400AA6Q0002000400024Q0001000100024Q000200013Q00122Q000300AB3Q00122Q000400AC6Q0002000400024Q0001000100024Q000200013Q00122Q000300AD3Q00122Q000400AE6Q00020004000200062Q000100FE2Q010002000426012Q00FE2Q012Q007B000100073Q00067C0001001102010001000426012Q001102012Q007B000100054Q0053000200013Q00122Q000300AF3Q00122Q000400B06Q0002000400024Q0001000100024Q000200013Q00122Q000300B13Q00122Q000400B26Q0002000400024Q0001000100024Q000200013Q00122Q000300B33Q00122Q000400B46Q00020004000200062Q0001001102010002000426012Q00110201002E7100B50013020100B6000426012Q001302012Q0077000100014Q00CA0001000D3Q00126C3Q00143Q002E7100B70039020100B8000426012Q003902010026AB3Q0039020100B9000426012Q003902010012B9000100054Q0051010200013Q00122Q000300BA3Q00122Q000400BB6Q0002000400024Q00010001000200202Q0001000100BC4Q000100113Q00122Q000100056Q000200013Q00122Q000300BD3Q00122Q000400BE6Q0002000400024Q00010001000200202Q0001000100BF4Q000100123Q00122Q000100056Q000200013Q00122Q000300C03Q00122Q000400C16Q0002000400024Q00010001000200202Q0001000100C24Q000100133Q00122Q000100056Q000200013Q00122Q000300C33Q00122Q000400C46Q0002000400024Q00010001000200202Q0001000100C54Q000100143Q00124Q00C63Q0026C53Q003D0201002C000426012Q003D0201002E5D00C7005E020100C8000426012Q005E02010012B9000100054Q0051010200013Q00122Q000300C93Q00122Q000400CA6Q0002000400024Q00010001000200202Q0001000100CB4Q000100153Q00122Q000100056Q000200013Q00122Q000300CC3Q00122Q000400CD6Q0002000400024Q00010001000200202Q0001000100CE4Q000100163Q00122Q000100056Q000200013Q00122Q000300CF3Q00122Q000400D06Q0002000400024Q00010001000200202Q0001000100D14Q000100173Q00122Q000100056Q000200013Q00122Q000300D23Q00122Q000400D36Q0002000400024Q00010001000200202Q0001000100D44Q000100183Q00124Q00B93Q0026AB3Q0001000100C6000426012Q000100010012B9000100054Q0051010200013Q00122Q000300D53Q00122Q000400D66Q0002000400024Q00010001000200202Q0001000100D74Q000100193Q00122Q000100056Q000200013Q00122Q000300D83Q00122Q000400D96Q0002000400024Q00010001000200202Q0001000100DA4Q0001001A3Q00122Q000100056Q000200013Q00122Q000300DB3Q00122Q000400DC6Q0002000400024Q00010001000200202Q0001000100DD4Q0001001B3Q00122Q000100056Q000200013Q00122Q000300DE3Q00122Q000400DF6Q0002000400024Q00010001000200202Q0001000100E04Q0001001C3Q00124Q00023Q000426012Q000100012Q0045012Q00017Q00013Q0003053Q00526573657400044Q007B7Q0020825Q00012Q0080012Q000100012Q0045012Q00017Q00B5062Q00030C3Q0049734368612Q6E656C696E67025Q00149540025Q0070984003043Q0043617374030A3Q00502Q6F6C456E65726779025Q00AC9740025Q00804C40025Q005EAC40025Q0014B140028Q00025Q0028B340025Q003AA140025Q00E09D40025Q00589640025Q000C9940025Q0008B340025Q0002A440025Q0018AC40025Q00D49440025Q00D4954003103Q00EB2D13E5EFD71B0FFFE8D52C04F1EECD03053Q009DB948679003193Q0069BC8576A1BF5EF38E68BDB857B4CA59A0B057BD8F76A1BF5E03063Q00D139D3EA1AC8025Q00F4A740025Q00B0964003143Q004D616E69634772696566746F7263685370652Q6C026Q008A40025Q002EA240025Q00C0A540025Q00F4AA4003103Q0033CBB29442DC32C6A9945CD602CFB59503063Q00B261AEC6E13003173Q00FF590BFD71E8088F7B05FF71E528DD5F01F76CE91DCC5E03073Q006FAF366491188603053Q006115291B4703043Q0075237940025Q005CA040030A3Q00F6B4EAD82656EEB5E1C203063Q002FBDDD8EB643025Q00807940030C3Q0067657457686974654C69737403103Q0001BC35C44AA83420238C33D941A2253A03083Q004940DF47AB28C940030B3Q004973417661696C61626C65026Q002240026Q001840030B3Q00436F6D626F506F696E747303143Q00452Q66656374697665436F6D626F506F696E747303123Q00436F6D626F506F696E74734465666963697403063Q0042752Q665570030E3Q00416472656E616C696E6552757368026Q0049C0030B3Q00456E65726779526567656E03163Q00456E6572677944656669636974507265646963746564025Q00B6AB4003113Q00476574456E656D696573496E52616E6765026Q003E40026Q00F03F030A3Q0051756575656443617374025Q0048B240025Q0025B04003103Q003888D04CB2733985CB4CAC79098CD74D03063Q001D6AEDA439C0030D3Q0092B1F4AEDADFE0C3A4A1F2BF9503083Q0092D1C487DAB5B2C003103Q0052657475726E53686F756C646361737403023Q004944026Q007940025Q0074AE4003103Q001F35970442A91E388C045CA32E31900503063Q00C74D50E37130030B3Q0052657475726E5370652Q6C03123Q00183A4AD8383173C2193751D8263B5DCC392B03043Q00AD4A5F3E030D3Q0052657475726E5370652Q6C4D4F025Q00E88B40025Q004CA740030B3Q00E12C7505CE13A8CF175B2503073Q00DCA6793C56AB6703073Q00CE0733B529CB1603073Q007A89625DD05BAA030B3Q00A8F11941D0A09BCF94E40803083Q00AAE7817C2FB5D2C903123Q004865726F526F746174696F6E43686172444203073Q00BFB43D37062F9803063Q004AEBDB5A506A026Q001440025Q00689840025Q00C08E4003073Q0047657454696D65030B3Q006BF672083FE06EFB42C44803083Q00922CA33B5B5A941A03073Q005228B6845B742103053Q0029154DD8E1030B3Q003B5D774B115F2Q4007486603043Q0025742D12030B3Q00E8CA7F91AEDBEB5F2QACDC03053Q00CBAF9F36C203073Q005CCB173E484ECE03073Q00A21BAE795B3A2F030B3Q00FCD51AFB3ACBE1C00CF02B03063Q00B9B3A57F955F0003073Q00657AC8F31B546603053Q00773115AF94025Q0031B140025Q0088A540025Q0008A140025Q0048964003053Q005072696E74030E3Q009413EBF710D3FB0AFDB91BCEAC4303063Q00A1DB638E997503073Q0048BEA174C179A203053Q00AD1CD1C61303143Q0069EFB1BD25BCB1BD25BCB2B574EEBBBE71F0A5F503043Q00DB158CD703153Q0054BBC0A15E4EE896F7084CB1D5A65A44BDC2BB4A0603053Q003828D8A6C7025Q00889D40025Q00F07840025Q00C8814003073Q0063BA115A214C9903083Q009537D5763D4D29EA03073Q002909CDC1E53CBC03083Q007B7D66AAA68959CF030F3Q007A0F5F3A0286804D0F561B1C82A44B03073Q00C92E60385D6EE303103Q0055706461746542752Q746F6E54657874030A3Q004772696566746F726368030F3Q004D616E69634772696566746F726368026Q003840026Q003940025Q00E2A240030D3Q0001A6143F36B81C2Q219C1A202D03043Q004F46D47503093Q004973557361626C6550030D3Q008004E0D6E901AE18E6EEF602AC03063Q006DC77681A699030F3Q00432Q6F6C646F776E52656D61696E73030E3Q00427970612Q735265636F76657279030D3Q004772612Q706C696E67482Q6F6B025Q00949F40025Q009DB240025Q00088D4003103Q0003B563E323BE44FE3EA57BF232B164E203043Q009651D017024Q0008DC074103143Q00E8D0E59EFC85C799F8D5F087F0CBE7CBD1CAEF8003043Q00EB99A580030D3Q009C5BA33F562AA3F0BC61AD204D03083Q009EDB29C24F2646CA030D3Q0064372E12FEDA814D22070DE1DD03073Q00E823454F628EB6025Q00AEAF40025Q004FB240025Q00809D40025Q0084A34003073Q004D0F18FA75050C03043Q009D19607F025Q00804A4003073Q00938CF2025C34B403063Q0051C7E395653003173Q005A40FA01E68A35B57A12CA04F39339FB7441BB1FF9917C03083Q00DB1D329B7196E65C03073Q00E52FC27CF34D5E03073Q002DB140A51B9F28030F3Q00011509AC224D1009FA22121813B83C03053Q00127D766FCA03103Q004C3F5FFC36AB97AB006C56FC36B1D5B503083Q009B305C399A50CDA703093Q009AC52QBEE8984DB6D903073Q0025D9ADDBDF98CB03093Q002A0D1A375F9BFE061103073Q009669657F562FC803093Q00537465616C74685570030A3Q0056616E69736842752Q6603093Q004973496E52616E6765026Q00204003093Q00C3FDE6A6C2CFD8F7E103063Q00A0AE9293D5A703093Q00436865617053686F7403093Q004DEB0F57094E56E10803063Q002120847A246C03043Q004755494403093Q00B41B675879B602775903053Q001CD974122B030E3Q0049735370652Q6C496E52616E6765025Q0054A440025Q00F2AE40025Q007EB34003123Q00E052C241C2A011DD64DE5BC5A238D156C54003073Q005CB237B634B0CE024Q00C0E7D14003133Q000B2074001F75521D1F346155293D7E015A185E03043Q00757A5511025Q00F2A140025Q004AA740025Q0032A640025Q0031B040025Q007AA440025Q00ACB04003103Q00BAEA3E51B4D3BBE72551AAD98BEE395003063Q00BDE88F4A24C6025Q00A49C4003103Q00EDBF0F5BD24ADFA20F4FC74ACFA2055A03063Q006A9CCA6A2EB7025Q00BEA940025Q00CFB14003093Q001E117E323A0E11742703053Q004A5D791B5303093Q005EB3E37F6D88EE716903043Q001E1DDB8603073Q0061A81EFDF85A0B03083Q006E35C7799A943F78026Q00364003073Q003515F83855F91203063Q009C617A9F5F3903183Q00EDBEDFF91B420CC6B9CEB83A173ADBB39AF1184231C1A19A03073Q005FAED6BA986B6203073Q00BD01768C1FC39A03063Q00A6E96E11EB73030F3Q00640DC2C7A2EE7A7E5E94CEFCA26E3603073Q001C186EA4A192DE03103Q0047C050235DC506750B9359235DDF446B03043Q00453BA336030A3Q009BA1CE4436D485B8A7DE03073Q00D6D0C8AA2A53AD030A3Q00F22876AE70C0127AAF6103053Q0015B94112C003093Q00F3594808A4F140580903053Q00C19E363D7B030A3Q004B69646E657953686F74025Q0034AE4003093Q00381E35AA301E36BC2703043Q00D955714003093Q004600D9D3EA8DF34E1D03073Q00852B6FACA08FE2025Q00EEAA40025Q00AAA140025Q007EA740025Q0050A440025Q008EA240025Q00D89340025Q002FB140025Q00F6AC40025Q009C9E40025Q0070A84003123Q00F9A644C4D2C58E5FE2C8C4B65CD5C3CAB04403053Q00A0ABC330B1025Q00EAAF4003143Q00C2167338598184CED70D73341CF2A7C8C7435B0203083Q00A7B363164D3CA1CF025Q00B09C40025Q0066A54003103Q00337A9F4D5E0F4C8357590D7B88595F1503053Q002C611FEB3803113Q00E01BFDB1F44ED3ADF500FDBDB13DF0ABE503043Q00C4916E98030A3Q007327FAFC5D37CDFA573A03043Q0092384E9E030A3Q0006D24BE85F34E847E94E03053Q003A4DBB2F86025Q0044B240026Q00A740025Q0032A940025Q00F08F4003073Q00263AA600E92B4703083Q007E7255C167854E34026Q00374003073Q00F0D4357FC8DE2103043Q0018A4BB5203193Q00DAD358A4F4E89A6FA2FEE59A6DBFF4E4DF1CA3E2B1D453BDB103053Q002Q91BA3CCA03073Q00D2DF3403EAD52003043Q006486B053030F3Q00CFC244BBE345D5C712EDBC1BCFD30C03063Q0075B3A122DDD303103Q0051B3FCC002F9F51DE0AAC902F9B95FFE03073Q00C52DD09AA6649F03053Q000BF88FB23703053Q00534994E6DC03053Q0011D3FFEEEB03063Q00E953BF96808F026Q002E4003093Q00FA89DA6108F890CA6003053Q006D97E6AF12025Q002DB340025Q0072A34003053Q00426C696E64025Q00FAA840025Q00806C40025Q002AA140025Q0038B14003093Q00ADF5545785AFEC445603053Q00E0C09A212403093Q008E5B0D91865B0E879103043Q00E2E33478025Q00488540025Q00CC994003123Q0037EEF8B158B1FAB6362QE3B146BBD4B816FF03083Q00D9658B8CC42ADFB7024Q004074D440030E3Q000B1AAA0F415A2DA3134A1E4F823503053Q00247A6FCF7A025Q0024924003053Q002E04EDB6BC03063Q00546C68842QD803053Q00EE17CF56E403073Q0022AC7BA63880C4025Q0064A140025Q0032A040025Q0021B240025Q0028AD4003073Q0090A6AFCC4676C603083Q0074C4C9C8AB2A13B503073Q004289FC5A19050F03073Q007C16E69B3D756003133Q00E7A7EFE5FAADC4D0AEF3EEBEE4E685A5E9FCBE03073Q0095A5CB868B9E8D03073Q0007A347213FA95303043Q004653CC20030F3Q0012820D865ED10D865ED1048E12934503043Q00E06EE16B03103Q00E875DB3736C294A4268D3E36C2D8E63803073Q00A49416BD5150A42Q033Q002Q816703073Q0017D2E017D3472B2Q033Q009A870003083Q0090C9E670D7354BBC026Q00244003093Q0058CA0CF9F3AA43C00B03063Q00C535A5798A962Q033Q00536170025Q00A09340025Q00908C40025Q00E88440025Q00A0A64003093Q00E0D0CC33E8D0CF25FF03043Q00408DBFB903093Q000EE5A5C9F2C6B006F803073Q00C6638AD0BA97A9025Q00A1B140025Q006AA940025Q00C89240025Q00BAAB40025Q00D0A94003123Q003FF0974B1FFBAE513EFD8C4B01F1805F1EE103043Q003E6D95E3024Q009087F040030C3Q00E29D8CC105B3BB88C440DEA703053Q006093E8E9B4025Q0042AA40025Q009C974003103Q001A3D0E5E9F371B30155E813D2B39095F03063Q005948587A2BED025Q0072BA4003093Q003DAEA0231E6C88A42603053Q007B4CDBC556025Q0028A940025Q00FAA140025Q00EAAE40026Q007F402Q033Q006BD90503063Q005F38B8756C8E2Q033Q002QC33603043Q008C90A246025Q00BAAD40025Q0030AF40025Q0022A940025Q0096AA4003073Q00E4275E75E2D53B03053Q008EB048391203073Q00923E1723AA342Q03043Q0044C6517003113Q00840EA0547D08B21AB554450EF701BF030C03063Q007DD76FD0742C03073Q00332Q48F474591403063Q003C67272F9318030F3Q00F009F12Q86A348EA5AA78FD8EF5CA203073Q002E8C6A97E0B69303103Q00F72E7B44ED2B2D12BB7D7244ED316F0C03043Q00228B4D1D025Q004AB340025Q00A88940025Q0012AA40025Q003C9A4003053Q0096F5145A3D03053Q0049D0907D3403053Q000CE983C5D303083Q00AB4A8CEAABA77033030F3Q00412Q66656374696E67436F6D62617403073Q005072657647434403053Q004665696E74025Q00507740025Q002EA640025Q00ACAF40025Q0068A64003103Q001D0B584AE3A31C06434AFDA92C0F5F4B03063Q00CD4F6E2C3F91025Q00406940030B3Q00B64A3ADDB14B8219AE512B03083Q007CC73F5FA8D46BC403053Q0020AD5A34B003083Q009366C8335AC497E903053Q001DF5E6C3AA03073Q002Q5B908FADDE80025Q00405A40025Q00A4934003073Q0017AF4B56A74B3003063Q002E43C02C31CB026Q003B4003073Q0030D929A528A11603073Q006564B64EC244C403133Q006E4D39FB990B49C04D5D35B5845838DB475F7003083Q00B52Q285095ED2B1803073Q0021BD2235B64F0103073Q007275D24552DA2A030F3Q0058D55E75FC14D05E23FC4BD84461E203053Q00CC24B6381303103Q00F548DA857B3E42B91B2Q8C7B3E0EFB0503073Q0072892BBCE31D5803093Q00C611A914E12FBD03EC03043Q0070847DC803093Q00DFB4F2775FC7E8ABFB03063Q00959DD893133A025Q00C8B240025Q00C07C40026Q000840025Q00F0A74003093Q00426C61646552757368025Q00307440025Q0018974003103Q00FB830CDDDB882BC0C69314CCCA870BDC03043Q00A8A9E678024Q0014981041030F3Q00ED988102F9CDA61BFD898125E99E8C03043Q00779CEDE403093Q00E1DD017AC6E3156DCB03043Q001EA3B16003093Q00382C548D3819C1092803073Q00B47A4035E95D4B025Q0006A940025Q00B8A040025Q005FB140025Q0008934003073Q00E218143ADA120003043Q005DB67773025Q0080494003073Q00B610D48BBBFB9103063Q009EE27FB3ECD703153Q00D3CCC8D2F4F2DCC5F980D8C3F480C0C5B1CEC6C1B103043Q00B691A0A903073Q000D2F3711AB0A2A03063Q006F59405076C7030F3Q00A3B40840EFE70840EFE70148A3A54003043Q0026DFD76E03103Q0042D80AC3AD588B5C95FB51DD0AD9B91003053Q00CB3EBB6CA5025Q00449940025Q00DEAD4003053Q00DE7B5D397403073Q00B09914285E119E03053Q008F3CAE54C003053Q00A5C853DB33025Q00C4AE40025Q0090964003053Q00476F756765025Q00788C40025Q00BEAA4003093Q00CAE56168D4BAAAE1D503083Q0084A78A141BB1D5DC03093Q00FFDAF65F39FDC3E65E03053Q005C92B5832C025Q007DB340025Q00B07740025Q008DB140025Q005CA640025Q00C3B240025Q00207940025Q0030A040025Q0048AE4003123Q0079FB5593AC4E3AD278F64E93B24414DC58EA03083Q00BD2B9E21E6DE2077024Q004059D140030E3Q004FD548448D1EE742448F5B80607E03053Q00E83EA02D3103063Q0060D2E7ABA46003053Q00C114B395CC025Q00B7B240025Q00907640025Q0087B140025Q00FC9F40025Q00049140025Q00089140025Q00789E4003103Q00E50495D7C50FB2CAD8148DC6D40092D603043Q00A2B761E1025Q00C09B40030B3Q0038D0E1E219A28626D0E3F203073Q00C149A584977C82025Q008AAF40025Q00508E4003053Q00EACDBC5CB303063Q00D6ADA2C93BD603053Q000476BF46D203063Q00404319CA21B7025Q00E89540025Q0066AC4003073Q00DDE176BB22D75003073Q0023898E11DC4EB2026Q00494003073Q0019412206214B3603043Q00614D2E4503133Q00F8D015A2DA9F31B0DACA05E5D6CC40ABD0C84003043Q00C52QBF6003073Q00FE26EA4954ED5E03073Q002DAA498D2E3888030F3Q009D0CCBE3FFD701875F9DEAA19B15CF03073Q0067E16FAD85CFE703103Q005087F3534A82A5051CD4FA534A98E71B03043Q00352CE495030B3Q00EFD73A01CE02C1CE2917D203063Q0044ADBB5B65AB030B3Q00DE0313C34CA471CCEE1D0B03083Q00B99C6F72A729E21D025Q006CA140025Q0034B240030B3Q00426C616465466C752Q7279025Q00D08540025Q006AB340025Q00C05940025Q0044AF40025Q002CAC40025Q009C994003103Q0039000235A6ED380D1935B8E70804053403063Q00836B657640D4024Q00801ACB4003113Q00D0C3293E4280EBCDD7282E61CCDCD3C43503073Q00A9A1B64C4B27A0030B3Q00FB5EB68F1E04A4CC40A59203073Q00C8B932D7EB7B42030B3Q00D08DD8E68F5016E793CBFB03073Q007A92E1B982EA16025Q00FCB040025Q00A49E40025Q0098AA40025Q0042B14003073Q008DEDC7C8E3BEAA03063Q00DBD982A0AF8F025Q00C0674003073Q000AB3453A32B95103043Q005D5EDC2203173Q002DC4C08EDFD1F11ADAD3939AE6E80A88C8999AF9F2188803073Q009D6FA8A1EABA9703073Q002Q4F7236CEBCA103083Q00E51B201551A2D9D2030F3Q0030CFFD3C1A7CCAFD6A1A23C2E7280403053Q002A4CAC9B5A03103Q00EE8E872F06F4DDD17950FD8B873512BC03053Q006092EDE149025Q00F2AD40025Q00A88240025Q00DEAA40030D3Q00C96C0BE9477F96E76C1AED476E03073Q00C2881E6888291A030D3Q00FDC400491AB59D20CEC406460003083Q004FBCB6632874D0C9030D3Q005CD129402D3A49CC385326316903063Q005F1DA34A2143030D3Q00417263616E65546F2Q72656E74025Q0020A640025Q0042A040025Q009EAB40025Q00A88C40025Q0038A740025Q00C89340025Q0079B34003103Q004E3754226D8437743D553B7B89056F2603073Q00641C5220571FEA024Q0048F0024103193Q002047E564FE96C92C3253EE74CFD9FA2C345CF431CAC3ED2B3403083Q005E513280119BB688025Q00BBB140025Q00909340030E3Q00A735E331F6A736928F3BE93CECA003083Q00E7EB5C845982D47C030E3Q00D2BDF337C556D4A1F038DC40F0A003063Q00259ED4945FB1030E3Q005815A38F196736B1830A7919AA9303053Q006D147CC4E7025Q00AC9940025Q001CAE40025Q007EB040030E3Q004C69676874734A7564676D656E74025Q00F8AB40025Q0048B04003103Q0092B860B0232E93B57BB03D24A3BC67B103063Q0040C0DD14C551024Q00F8340F41031A3Q00BEE3E7B7A2EFDAEBA5AFBBE5C8B7A3A8FBE7ACB3EFC7F7A7B2AA03053Q00C7CF9682C2030B3Q00974B7CE745815872EB48A603053Q0023D52A1B88030B3Q0082863CB0DEC6B28E38B4CB03063Q0092C0E75BDFB8030B3Q0078F0F126D780150759FAE503083Q006E3A919649B1D467025Q007CA840025Q0051B340030B3Q004261676F66547269636B73025Q00E08E40026Q007B40026Q006240025Q00B89D40025Q0002B340025Q00BC9140025Q0055B040025Q00507A40025Q00B8AE40025Q00FCA24003103Q00C631DEE759C5DAFC3BDFFE4FC8E8E72003073Q00899454AA922BAB024Q006C11134103173Q0010CA7AE87241FD7EFA7807EB6DF4740ACC3FCC6204CA7A03053Q001761BF1F9D03093Q00A48E080AD91493901E03063Q0052E6E26765BD03093Q00A926BCBE10AD3FA1A803053Q0074EB4AD3D103093Q000A30D12A2C1ACB373103043Q0045485CBE03093Q00426C2Q6F6446757279025Q00E49140025Q00C08D40025Q005EA640025Q00C49040025Q00A6A540025Q00B09F40025Q00DC9440025Q005EA140025Q00789F40025Q00708740025Q00649E40025Q0032AB40025Q00D3B04003103Q00043EF0C1B9A625BF392EE8D0A8A905A303083Q00D7565B84B4CBC876025Q0017D44003153Q0022FB83C636AEA4DF3CE182F526FC9F9302FB83C63603043Q00B3538EE6030A3Q00F82AEF263C0DFCD6D42803083Q00BFBA4F9D55597F97030A3Q00D47FB6DD8157FD73AAC903063Q0025961AC4AEE4030A3Q00EBF5A046329BC2F9BC5203063Q00E9A990D23557025Q00FCAA40025Q0012A540030A3Q004265727365726B696E67025Q0053B340025Q000BB340025Q00E2A440025Q0026A740025Q00C89C4003103Q001043F9C93048DED42D53E1D82147FEC803043Q00BC42268D024Q0040AED94003163Q00F045082476022ACDF3430823784B06CFA1611834664703083Q00A881306D5113226803093Q00511D1E35DD29B4F67303083Q009917746C50BF45DB03093Q006F16EFDDFA8779461B03073Q0016297F9DB898EB03093Q0031CEF3CF15CBEEC51303043Q00AA77A781025Q00F0B240025Q00549940025Q00AAA740025Q006C9040025Q0020774003093Q0046697265626C2Q6F64025Q00207D40025Q00B88F40025Q002EAE40025Q002EAB40025Q00BDB240025Q0028AE4003103Q00E8F5A8669150E9F8B3668F5AD9F1AF6703063Q003EBA90DC13E3024Q001430104103153Q00B02QE9C3A4BCCADFB3F9EEDAAEF3E896902QE9C3A403043Q00B6C19C8C030D3Q00E04215B7F52BD34D1A91E733CD03063Q005FA12C76D286030D3Q00C74E100869C2F7AFEA6312017603083Q00CE8620736D1AB685030D3Q0017F6CC164E4924F9C3305C513A03063Q003D5698AF733D025Q0098A340025Q00E8AA40025Q001C9A40025Q00D07E40030D3Q00416E6365737472616C43612Q6C025Q001CA340025Q00A4AB40025Q00B6AF40025Q002DB140026Q00A040025Q00B08540025Q00DEAB40025Q00D4A040025Q00C07D40025Q0056B040025Q0082A54003103Q009B04C825C38F10CFA614D034D28030D303083Q00A7C961BC50B1E143024Q00C8C4104103193Q005F1D81BAF9C16F0687AAEF955C09888CFD8D4248B5BAF9944B03063Q00E12E68E4CF9C025Q0056AA40025Q0006AB40025Q00B9B240025Q000CA140030D3Q008BD2B04F395686B0B8D2B6402303083Q00DFCAA0D32E5733D2030D3Q00F7FB197503D3DD15661FD3E70E03053Q006DB6897A14030D3Q0073BB11FBEED2DE7340BB172QF403083Q001C32C9729A80B78A030E3Q00868F1EFABE9533E7AE8114F7A49203043Q0092CAE679030E3Q00C2E6E916D3A18A2BEAE8E31BC9A603083Q005E8E8F8E7EA7D2C0030E3Q002CCC1AE9D313EF08E5C00DC013F503053Q00A760A57D81030B3Q0025D711494412598104DD0503083Q00E867B6762622462B030B3Q00175628EC3645275E2CE82303063Q001155374F8350030B3Q00EA84BEA339FC97B0AF34DB03053Q005FA8E5D9CC03093Q00A83789868E1D939B9303043Q00E9EA5BE603093Q00734D8D7CA37754906A03053Q00C73121E21303093Q0070574C10C3744E510603053Q00A7323B237F030A3Q006A1640FFAD5A185BE2AF03053Q00C82873328C030A3Q00D128650CF63F7C16FD2A03043Q007F934D17030A3Q00A9E3E7677599EDFC7A7703053Q0010EB86951403093Q00FC425CA30E8B03D54F03073Q006CBA2B2EC66CE703093Q0014B6E7047E3EB0FA0503053Q001C52DF956103093Q008B3C5F5BAF394251A903043Q003ECD552D030D3Q005402A2AC119D1B740082A80E8503073Q0069156CC1C962E9030D3Q00618B18FBD02AC8418938FFCF3203073Q00BA20E57B9EA35E030D3Q00252D72CF0AB125052F52CB15A903073Q0057644311AA79C5025Q0041B040025Q00889C4003073Q00DA84BD875BB0FD03063Q00D58EEBDAE03703073Q003CADFEC204A7EA03043Q00A568C299031C3Q00A622DAAAF758CDB33FCBB9FC5399C701CCAEEC58CD8E2399A5F64ACD03073Q00EDE750B9CB993D03073Q00913F877549A02303053Q0025C550E012030F3Q0005414A40E449444A16E4164C5054FA03053Q00D479222C2603103Q00A6B92C0378ABA20E2QEA250378B1E01003083Q003E2QDA4A651ECD9203113Q0048616E646C65496E636F72706F7265616C025Q00207C40025Q00188E40025Q0050A640025Q005C9C40025Q0042A540025Q0074924003123Q0070AC6DE4CF30692071A176E4D13A472E51BD03083Q004F22C91991BD5E2403083Q004220E30444146D2Q03063Q0034204C8A6A2003053Q009AF639C87E03053Q001AD89A50A6030A3Q00E7C0E94D7835FFC1E25703063Q004CACA98D231D025Q00DFB240024Q005CD01341025Q001EA740025Q00E6A840026Q002Q40025Q005EAE40025Q00B49540025Q001DB340025Q00989740025Q00907E4003103Q00EEDCEC16CED7CB0BD3CCF407DFD8EB1703043Q0063BCB998024Q00F069F84003163Q00D11CB700ADD718BF00A49232BA0BA2C11CB51CA2D40003053Q00C3B274D66E030B3Q004372696D736F6E5669616C025Q006AA540025Q0030994003073Q0045766173696F6E025Q00CCAD40025Q008AAD40025Q00309A40025Q002FB340025Q00F08440025Q00409E4003103Q004865616C746850657263656E7461676503073Q0026F88B78CEE81603063Q00866597E615A103073Q00998233552F1AD003073Q0080C9EA5A344352030F3Q0094453775C6AB4B0D71D8A1433760D303053Q00AAC42D5E1403073Q0049735265616479030F3Q004E4C0C35CD2F364D411731CF29246703073Q00501E246554A140030F3Q00506869616C6F66536572656E697479025Q00A08F40025Q005CB14003103Q0094540D57CA3595591657D43FA5500A5603063Q005BC6317922B8025Q00804B4003123Q0004CE7EB8853BC044BC9B31C87EAD9074EE4703053Q00E954A617D9025Q00289140025Q0080874003073Q005B77F5EB392F6B03063Q00412Q18988656030D3Q009432E945A83FFB5DB339ED618C03043Q0029DC5788030B3Q000D33E2FCDAA33622ECFECB03063Q00CB45568390AE030B3Q00911B5255DC58F405B6105603083Q0071D97E3339A83087025Q00C2A140025Q00689C40025Q0086A040025Q00F0A040030B3Q004865616C746873746F6E6503103Q002D10225D5A7145C610003A4C4B7E65DA03083Q00AE7F75562Q281F16026Q004440030E3Q00F43E4DD7C8335FCFD335499BF40B03043Q00BBBC5B2C03073Q003CF87328ED030C03063Q006D7F971E458203093Q00FA807614F5DFA63EE203083Q0076B2E51778A5B0D2030D3Q0026D35F0405AC09B804D07C061803083Q00DD65BC2C696CCF41030D3Q00753F04AFDB551812A3DE663F2Q03053Q00B2365077C2025Q00C6AE40025Q00489040025Q00A08140030D3Q00436F736D69634865616C506F74025Q0036A040025Q00B09A40025Q00088240025Q00707F40025Q002FB240025Q00F4A440025Q0068AF40025Q00809E4003103Q00060A55D7FDF78ACA3B1A4DC6ECF8AAD603083Q00A2546F21A28F99D9025Q0080464003103Q0004D40E872ED8358F26D72D85339B35BA03043Q00EA47BB7D025Q00149640025Q008EA14003073Q0032335C56F11F2F03053Q009E715C313B03093Q00C475407CCE09CE2FDC03083Q00678C1021109E66BA03083Q00EF88BC792Q33D3A103063Q005CA7EDDD156303083Q00D7252C2ACF2F390A03043Q00469F404D03083Q004865616C506F744C025Q0068A840025Q00408340025Q007CAF40025Q00909E40025Q00A2A540025Q0074A040025Q0010A540025Q00F89840025Q0028A440025Q007EA34003103Q00E54A46EA08D97C5AF00FDB4B51FE09C303053Q007AB72F329F025Q00804440030E3Q00EA34A643B0CD25E763AFF5718F7F03053Q00E0A251C72F025Q00F09040025Q00CAA44003073Q00CB4A3E308CE65603053Q00E38825535D03093Q0071A8097869A21C5C6903043Q001439CD6803084Q00AE19B52A55270503073Q005348CB78D97A3A03083Q0094ECBAAF9FB2AB9103073Q00DFDC89DBC3CFDD025Q0056A040025Q0080894003083Q004865616C506F744D025Q0081B240025Q00949040025Q003AA340025Q0014A440025Q0058AC40025Q00649140025Q00489240025Q00B8A34003103Q00214D4BF73E1D7B57ED391F4C5CE33F0703053Q004C73283F8203113Q00AF1F2CA186DE935A008892F8B2376D858603063Q00B1E77A4DCDD6025Q00C0AF40025Q005EA24003073Q00671C4C4DA6525703063Q003C24732120C903093Q009F73564A7C5129898703083Q00C1D71637262C3E5D03083Q0007170FC3E5F43B3A03063Q009B4F726EAFB503083Q007051D8E88183C17003073Q00B53834B984D1EC03083Q004865616C506F7448025Q005DB140025Q00849A40025Q0018B240025Q00E4A140025Q003CAA40025Q00F88740025Q00488B40025Q005CA740025Q00FDB24003104Q0049C6BD57A7C93A43C7A441AAFB215803073Q009A522CB2C825C9030F3Q005DEE03018E476135C32B2A96085D4503073Q002Q158B626DDE28030A3Q00556E697445786973747303093Q0009E3B99F3F0BFAA99E03053Q005A648CCCEC03063Q00737472696E6703043Q0066696E6403083Q00556E69744755494403093Q00A11B2BDFB217BA112C03063Q0078CC745EACD7024Q00B074FD40025Q0012A140025Q00C89840025Q0057B140030A3Q0033B4AB1CE4AE43770CA903083Q001F63DDD8688BC210030A3Q0049734361737461626C6503093Q0038AFFF1F0CEC23A5F803063Q008355C08A6C69030E3Q004973496E4D656C2Q6552616E6765026Q003440025Q0008AC40025Q002EAD40030A3Q00506973746F6C53686F74025Q00ECB240025Q008C9F40026Q009B40025Q0006B040025Q00F7B140025Q0094A74003123Q0004A16B1624AA520C05AC70163AA07C0225B003043Q006356C41F024Q00E317324103133Q00552C5FF150B40646310FD070E73F59275BF25303073Q006F30542F9D3FC7030A3Q002A0F93B321163588A83A03053Q004E7A66E0C703063Q00E8196604311103083Q009F9C7814635465CE03063Q0068109E78CD5503083Q00471C71EC1FA82117025Q00AEB240025Q00908140025Q00F0A840025Q0084B240025Q00889940025Q006AA840025Q00608A40025Q000CA440025Q0098B14003103Q007FFB37EDCBD708AF42EB2FFCDAD828B303083Q00C72D9E43982QB95B024Q0018AD064103143Q005F61ADA2DF05DEC65F3989AFC256E7D9496DB2A203083Q00B03A19DDCEB076B7025Q00DCA840025Q0044A140025Q00C7B14003093Q003F1ECC15EBB72414CB03063Q00D85271B9668E03093Q004F5435CB782Q4D25CA03053Q001D223B40B8024Q0080F8084103053Q00301241C43103063Q003D727E28AA5503093Q00C127622AC67CDA2D6503063Q0013AC481759A3025Q0050AC40026Q006E40025Q0056A740025Q0056A340025Q00949A40025Q004EAF40025Q002CAF40025Q0092A540025Q0030B340025Q00DAA340025Q005AAE4003123Q000559DBF0275C88386FC7EA205EA1345DDCF103073Q00C5573CAF855532031A3Q0016722QDD103EF9FC5477DAD01B6CC4DC067BD5DF547FD2D51D6603043Q00B3741EB403063Q00FFC7FF86EED203043Q00E18BA68D03043Q007E83FD3603043Q00402DEB94030D3Q00556E697443616E412Q7461636B03063Q00665D3BFB59C703063Q00B516315A823C03063Q001BD0AA0E0AC503043Q00696FB1D803133Q00556E6974412Q66656374696E67436F6D62617403063Q00A01BDA2Q15C703063Q00B3D47AA87270030A3Q00556E697449734465616403063Q006D7B96CA7C6E03043Q00AD191AE4025Q00849B40025Q00B07140025Q0062AF40025Q00D6AE4003083Q00556E697442752Q6603063Q000277DBBD1D0203053Q00787616A9DA03053Q007061697273025Q00509240025Q00E8A540026Q00E03F025Q00FCA440025Q00EAA14003043Q0053686976025Q00F07340025Q009AB040025Q00EAA540025Q00109640026Q005C40025Q0044B340025Q0086AC40025Q00E09540025Q0020A540025Q0021B04003103Q00F525A2F3D52E85EEC835BAE2C421A5F203043Q0086A740D6025Q0032B740030B3Q003781F79E89ED0A9BFF8FCC03063Q00A864E99EE8A9025Q00849140025Q007CA040027Q0040025Q00A08340025Q00789A40025Q00308A40025Q00A2A640025Q0096AE40025Q00C07640025Q00ECB140025Q00806640025Q00208C40025Q00908740025Q002AB140025Q0048AF40025Q0049B240025Q0008A940026Q002840024Q0080F3C04003073Q00515B14F17D5A0A03043Q009C123479030C3Q006F15CFC285B935D04A03D4C403083Q00BF2370BBAAE4D565030C3Q008FA0695B3A5C4FB7A66F5A3003073Q001FD8CF1C355E7C025Q00E4AB40025Q00F08240030B3Q0042752Q6652656D61696E73025Q00C08540025Q0060734003093Q00497343617374696E67025Q00B2AB40025Q007AA940025Q00D08740025Q0020A740025Q0018A34003103Q001322BF1A492F14A3004E2D23A80E483503053Q003B4147CB6F025Q0060694003143Q0020AF697A8F4C0418A96F7B854C0612A66E71980403073Q005477C01C14EB6C025Q00789740025Q000EA64003073Q00AFF129FB1532BA03083Q0021EC9E44967A5CC9030C3Q00CCDDED1148FD09EFD1EA164703073Q005980B899792991030D3Q00C830A5852E9E400BE33CB78E2C03083Q005B8C55C4E142E760025Q00A88D40026Q004240025Q00509C40025Q00249540025Q00C1B240025Q00449340025Q00707440025Q00ECA540025Q0085B340025Q0007B140025Q0016A740025Q007C9840025Q00F2AF40025Q002CA840025Q001EB240025Q007EA24003103Q0001BDA3A4593D8BBFBE5E3FBCB4B0582703053Q002B53D8D7D1026Q006A4003153Q006FA2B10F2252E780042758A8BE4B1C4EA1A20E3D4303053Q004E2BC7D06B025Q00E08D40025Q0043134103073Q0051870D13B434D603083Q00B612E8607EDB5AA5030C3Q00115B33A03C5217A7344D28A603043Q00C85D3E47030E3Q006F435DCEC5BC1A067D41D3D7BD0003073Q006E262D2EBAA4D2025Q00F8AF40025Q00488E40025Q00C09240025Q006EAC40025Q0040B040025Q00EC9640025Q0072A740025Q0026AB40025Q0035B340025Q0024A940025Q00A09A4003103Q004ABBBC032C768DA0192B74BAAB172D6C03053Q005E18DEC876025Q00A0694003163Q0034CE350D1CCE32592DCF2F0A12CE662B18C6341C0EC803043Q00797DA046024Q00144B1741025Q00509740025Q00708B4003073Q00D0E536BFFCE42803043Q00D2938A5B030F3Q001BF2C66735073DFCC47B3F1A26F2C603063Q0073559DA82B50030F3Q00DE4E95589CC14FCABF6A885E9FC64803083Q00A99F3AE737ECA926025Q0076A740025Q0067B240025Q00D3B140025Q00B89F40025Q00607240025Q00FCA840025Q00A88440025Q0064B140025Q0054A940025Q00F89B40025Q004FB340025Q00849340025Q0036AD4003103Q0023C4AB05D61A4F19CEAA1CC0177D02D503073Q001C71A1DF70A47403173Q00E756536B54D65144396BC951547655866A427F49C34B4F03053Q003BA6382719025Q0081B64003073Q0091D7CBC54CBCCB03053Q0023D2B8A6A8030F3Q007756736E2163515871722B7E4A567303063Q00172Q391D2244030E3Q007E24122E593F186C603E163F5F3F03043Q004C30517F025Q00389140025Q00806340025Q0034AA40025Q00708040026Q00B340030D3Q004E756D62696E67506F69736F6E025Q002CAB40025Q005FB240025Q0094A840025Q0086AF4003103Q003CA045A2187AEE5801B05DB30975CE4403083Q00306EC531D76A14BD025Q0080694003163Q00330745AEC925414C2D1D41BFCF25063E18145AA9D32303083Q006C7D7228CCA04B26025Q00389240025Q00708140025Q00A0AA4003073Q00167FF2003A7EEC03043Q006D55109F030F3Q0009FCA3771E4CB826FF9D54124BBF2903073Q00D04793CD3B7B3803103Q0074328DA8472C8DB65060B4B75E338BB603043Q00D83740E4025Q00907A40025Q00DC9640025Q00608E40025Q00288E40025Q00549C40025Q00549E40025Q00907540025Q00A2AB40025Q00A89140025Q00949940025Q00F8A040025Q00A89C40025Q0046B340025Q00F4AE40025Q00988A40025Q00209A4003103Q002Q8D2AD7ABFBD8B7872BCEBDF6EAAC9C03073Q008BDFE85EA2D995025Q00C0694003183Q00F6912AE1AB59C3DB8463C1B45CD9DA8D63C3BE53D8D0902B03073Q00AAB5E34391DB35025Q0082AC40025Q00E88540025Q001CAA40025Q00406B40025Q00049F40025Q00FEA440025Q00F2A940025Q0006AC40025Q0050874003073Q00537465616C746803063Q006F8410BB4A8D03043Q00D239E57E03113Q0054696D6553696E63654C61737443617374025Q00D88E40025Q002BB340025Q00F89340025Q00FEAB40025Q0008B040025Q00507C40025Q0047B040025Q00D49E40025Q0059B140025Q00349640030D3Q00546172676574497356616C6964030E3Q005AC4B0A2F2B92BF965E1A7A8E3B503083Q009617A5C2C997DD4D030A3Q0043504D61785370656E6403053Q004E50434944024Q00D0C70441025Q00949C4003073Q005D34E5177135FB03043Q007A1E5B88030C3Q008C90C8B6A99EB7C180BE9C8003053Q00EDDFC485D0025Q004CA240025Q00D88A40030E3Q004D61726B6564666F724465617468025Q00B2B140025Q000AA640025Q002AA340025Q007AB040025Q00C4AD4003103Q00EE0DD7AB4CF4EF00CCAB52FEDF09D0AA03063Q009ABC68A3DE3E024Q0098CC0041031B3Q0016EC3EEF5062C327E628FF5049CD27AD09FE115BCA75A502D4330603073Q00A2558D4D9B702F025Q0076A240025Q0070AE40025Q00D49D4003103Q00202CB25B002795461D3CAA4A1128B55A03043Q002E7249C6031B3Q00867F65FB6E67A46C7DEA2A0AA37164AF0A4FA46A7EAF66658A5D3F03063Q002AC51E168F4E030E3Q0052414D3A7D4453367D406D2A604D03043Q005F13253F03163Q005821B7EE7E11742886F863027F2DABF57F024339B4F403063Q0067114CC79C11030E3Q009F2584EC59149DF3B02FA7FD5A1603083Q009AD34AE5883C70D9025Q00E6A040025Q0058B040025Q0090884003103Q009D19FED817499C14E5D80943AC1DF9D903063Q0027CF7C8AAD65025Q00DBCA40031D3Q00ED0050D4E2EF0551C5ACCF0D4ACEA78E3356D3AA8E496CD0A7C004518903053Q00C2AE6123A0030C3Q00CD2F310EEB283820F02E381103043Q00629F405D03083Q00446562752Q665570030B3Q004472656164626C61646573025Q003EA340025Q00688140030C3Q00526F2Q6C746865426F6E6573025Q00408840025Q006AAE4003103Q003CB4390A0308682C01A4211B1207483003083Q00446ED14D7F71663B024Q00D0411341031C3Q008DE5B45B43F1A1A2E8E75B0BC6EE8CEBA94A1083E681F4A24106D1E703073Q002QCE84C72F63A3030E3Q00D7C6C5775FF7CEDE7C54C4D7C47A03053Q003196A2B71203163Q006027AB3315F61D4D0BBF331FEE194523B52428F50B4103073Q0078294ADB417A80026Q009E40025Q003EAB40025Q0043B240025Q00508240025Q00408A40025Q00A2AF40025Q00107840025Q002C9540025Q00A9B140025Q00CCAE40025Q00808540025Q0030A64003103Q006803480FF7A9E652094916E1A4D4491203073Q00B53A663C7A85C7031D3Q0070E3CF0D3A72E6CE1C7452EED5177F13D0C90A7213AAF3097F5DE7CE5003053Q001A3382BC79030C3Q00DB8E251A4C1FF95DCC8B2F1C03083Q003988E24C79297E97030C3Q00536C696365616E644469636502005QCCFC3F025Q00B49B40030B3Q0043617374502Q6F6C696E67025Q00308940025Q00ACA540025Q0088A140025Q00308640025Q00089F40025Q0020A240025Q0082A840025Q0078AB40025Q00109E40025Q0064A94003103Q0010D21D4636ED4E2AD81C5F20E07C31C303073Q001D42B769334483024Q00A0411341031C3Q0066245ADA051645C7462009CF4B2109EA4C264C8E0D0A59CB4B205B8703043Q00AE254529025Q00649640025Q001FB240025Q00BFB140025Q00A09740025Q00DEA94003123Q00B2A24B0F1C95BE0E463F91B3400B02C8EC0E03053Q0070E1D62E6E030D3Q003521264BCDA9DE11282F52EABA03073Q008C7E44433B84DD030D3Q00A579085859139FB1651542461A03073Q00E6E211672B2D7F03103Q00F54FCC448EDE4BF64E97C245C94A89D403053Q00E7B02CA42B030D3Q0047686F73746C79537472696B65025Q00B8A140025Q00389B40025Q002QA640026Q001040025Q00A2B040025Q0096A340025Q00108A4003103Q0093C3302QBC8292CE2BBCA288A2C737BD03063Q00ECC1A644C9CE024Q00480A084103203Q00273ADB65441CC07E172FC4684408DC630D30CD312F32FA314C14D8740A3EDA3803043Q0011645BA803063Q007BAB8EF9A02B03073Q001B3AC6EC8CD34303113Q0009C4C84E8CE50EDDDC459BFF34C3C55E9003063Q008B41ADAC2AE903063Q00416D62757368025Q0064AB40026Q009340025Q00FCA640025Q0066AD40025Q00508540025Q00AAA240025Q003EB040025Q00B7B140025Q00908A40025Q006EA040025Q00A09D40025Q0099B140025Q00D2AA4003103Q00B55365CDD679D34088437DDCC776F35C03083Q0028E73611B8A41780025Q00F2C04003143Q00A7C86CECC5CB89CB6AEB8DAACCE66FFD8BEF968003063Q008AE4A91F98E5030E3Q00FF054C3CF3D7C91E7121F2CAC70903063Q00A3AC6C225580025Q009EA540025Q00CEA240025Q00A07140025Q00207840030E3Q0053696E6973746572537472696B65025Q00C88940025Q0054A240025Q007FB140025Q0054B340025Q00A2AE40026Q006D4003103Q001514E392C94ABB5C2804FB83D8459B4003083Q0034477197E7BB24E8024Q0018990741031D3Q00558C6BB936BE71A37F9E6CA864CD4BB9648473A836C557BD73837DBF3F03043Q00CD16ED18025Q00E09E40025Q00E0AF40025Q0060884003113Q0098717DC12AB6383BE729BB2Q76DA70E43803053Q0059DE1813A8025Q00F89F40025Q0010AF40030E3Q00C6505DBE02E15C418405E75058B203053Q0071953933D7025Q00E89840025Q00C07E40025Q00107140025Q00C6AA4003103Q004B75DFA3F0CE4A78C4A3EEC47A71D8A203063Q00A01910ABD682031D3Q0052D924693DE1827FD1246978C0CB42CC257476D7CB39F7277873D7993803073Q00EB11B8572Q1DB2030B3Q009A3FEBA237E38FAD21F8BF03073Q00E3D8538AC652A503083Q0042752Q66446F776E03143Q001EBBB27DE023B4B87CF72F80A668F739BDB776F603053Q00924BD5D618030E3Q006B7AD3417444594370C4766F565D03073Q00352A1EA1241A25025Q00A49A40025Q0050A040025Q0083B340025Q00EAA340025Q00309E40025Q00D6A740025Q00ECA440025Q0060644003103Q00CFFCE3F5EFF7C4E8F2ECFBE4FEF8E4F403043Q00809D999703153Q0054798D2D10335079993B076A363DA339107D7367C503063Q00131615EC4975025Q00349540025Q0072B340025Q00806040025Q0056A240025Q00107D40025Q00707240030C3Q00537465616C74685370652Q6C025Q00DCB140025Q0088AC40025Q00D08240025Q0016A340030C3Q008CA877CCF8AF8178F5FDAFBB03053Q0090CAC91998030A3Q0009D2176AF446D40836CF03083Q006059BB641E9B2A87030A3Q0047434452656D61696E73025Q0052B240025Q00BEAC40025Q00E6B140025Q002EA140025Q00BC9940030E3Q0046616E54686548612Q6D65724350030B3Q0056616E69736842752Q6632025Q00B08140025Q0078A340025Q005AA14003103Q004765745370652Q6C432Q6F6C646F776E024Q00C049EC40025Q0032B040025Q0066A04003073Q000EC20E4775733E03063Q001D4DAD632A1A03073Q00A5F713756FE0C303083Q006DE482671A3B8F97025Q0082AE4003103Q00B76AA7DA355920829770ABED2C4B2B8103083Q00E4E318CEB95E2A4F03103Q00FA303EABBF083FC8363FAD800931CA2703073Q0050AE4257C8D47B03053Q00CD763DDDE403063Q0073AB195EA89703053Q000ABDE734E403053Q00976CD28441030D3Q004973446561644F7247686F7374030B3Q00556E6974496E506172747903053Q00DE5B0A5DD503083Q0034B8346928A621A7030A3Q00556E6974496E5261696403053Q005401CEBD2903073Q00AC326EADC85AB403113Q0046696C746572656454696D65546F44696503013Q003C025Q00D08A40025Q00FDB040025Q00449E40025Q0090804003103Q00547269636B736F66746865547261646503103Q00C9BFE059E9B4C744F4AFF848F8BBE75803043Q002C9BDA94025Q00E0694003093Q00D9F4187BF228B2F8E803073Q00D18D9B4C5BB447025Q004CA440025Q00D09240025Q008EAB40025Q00389940025Q00EC9140025Q00B4AD40025Q00F8A54003073Q0019051D2EE85AFB03083Q005A5B7074428C60DB025Q00A08A40025Q00489440030D3Q00E445090DEEAD30CA451809EEBC03073Q0064A5376A6C80C803073Q00E6C43CBECAC52203043Q00D3A5AB5103073Q00217BD3C8DBD90003063Q00BC6415B2AAB703073Q004C1653BAB3C16D03063Q00AD1E7730D3D2025Q0088AE40025Q0096A640025Q0067B040025Q001C9940025Q0034A840025Q00A89440025Q0002AE40025Q0009B340025Q00DAA940025Q0018AE40025Q00C8824003103Q0069DC2D2F49D70A3254CC353E58D82A2E03043Q005A3BB95903133Q0063F1495B7B5C52F35B413E3D74FF485D3E735403063Q001D20903A2F5B025Q00E89C40025Q00E88C40025Q00DEAE40025Q0036A240025Q00389840025Q00EC9340025Q00709440025Q00F0AA40030E3Q002ABDFAD53D04F4C4D32100BDFADB03053Q004E6CD494BC025Q00C07340026Q005440025Q00A4AF40025Q00B08940025Q009C9B4003083Q00AED48BB925DDEDFD03083Q00DDE8BDE5D056B5D7025Q0065B140025Q007C9D40025Q00249C40025Q003AA24003053Q00D059CC115A03053Q007A931DBF2B030A3Q00536861646F776D656C64025Q007BB140025Q0018B140026Q003A40025Q0074A440025Q00889040025Q007AAA4003093Q008FC45B08D6EB8424FC03083Q001EDCB03E69BA9FEC025Q004AAE40025Q00206040025Q00C8B040025Q00B49840030B3Q00322772BC4FA423207DAE4403063Q00C1735511DD2103073Q00CE740313A0D2FE03063Q00BC8D1B6E7ECF03073Q00A8385F75E8ED0D03073Q0069ED563E17848803073Q008B483F442211AA03063Q007DD9295C2D43025Q00508A40025Q004C9F40030B3Q00417263616E6550756C7365025Q00349C40025Q0020B04003103Q006BB1124A91556ABC094A8F5F5AB5154B03063Q003B39D4663FE3024Q0060C80F4103113Q005EE96C133DC96D047CE67A474DFD73147803043Q00671D881F025Q00B8B140025Q00C2A840030E3Q003227DD22520D04CF2E41132BD43E03053Q00267E4EBA4A03073Q00E24F2787488AD203063Q00E4A1204AEA2703073Q001B8A0BB7FC843003083Q00E05EE46AD590E15403073Q0082E944C900BCFB03053Q0061D08827A0025Q0058A740025Q0024A340025Q00E0A140025Q00805640025Q0046A240025Q0084AC40025Q009BB040025Q00E0AA4003103Q00C42CD7934B1C08FE26D68A5D113AE53D03073Q005B9649A3E6397203143Q006DACA142B027B75846B9A116DA1EBA5843A8BC4203083Q003F2ECDD236906BDE030B3Q00D22DF348DAC43EFD44D7E303053Q00BC904C942703073Q00A64478A943023103083Q0035E52B15C42C6C4203073Q00163B16A73F301303043Q00C553557703073Q007DFB1D3E4EF60D03043Q00572F9A7E025Q0038AC40025Q0078B240025Q00D09340025Q0044A240025Q0057B340025Q00FCA040025Q00AAAD40025Q0044A340025Q00D4B140025Q00B6A44003103Q00197DD8CEC0DA1870C3CEDED02879DFCF03063Q00B44B18ACBBB203123Q00E0D8F6173C06F81783D6E3434836F013C8CA03083Q0070A3B985631C4499025Q00607E40025Q0068B140025Q00DEB040025Q0021B340025Q0084A140025Q00A8AE40030A3Q009B5DEFDFA458CFC3A44003043Q00ABCB349C026Q33F33F025Q005DB240025Q00A2AC40025Q005CB340025Q00C08A40025Q0056A640025Q001C9340025Q00B88540025Q0077B24003103Q0088CF69A4388F8EA8B5DF71B52980AEB403083Q00C0DAAA1DD14AE1DD03163Q00A0DD48148F7D20EE97D35740FC4526E9C394742FFD0403083Q009DE3BC3B60AF2D4903083Q004469737061746368030D3Q0043617374412Q6E6F74617465642Q033Q00902QE503053Q0051DFAAB776025Q00F1B040025Q00BAA740025Q00FAB040025Q00507140025Q003EAC40025Q00C05C40025Q0004A54003103Q001444B8AEEB3C222E4EB9B7FD3110355503073Q00714621CCDB9952024Q007E842E4103113Q00C18D2Q30BE95FF872D3BE7F0B9AD100EB703063Q00D091E25F5C9E025Q00FEAF40025Q00EDB04003103Q008CE4C959FDFB9C10B1F4D148ECF4BC0C03083Q0078DE81BD2C8F95CF030B3Q00B41E12BD8A6E77BD96160403083Q00D8E4717DD1AA2B1900D71E3Q007B7Q0020AC5Q00012Q00723Q0002000200067C3Q000700010001000426012Q00070001002E5D0003003900010002000426012Q003900012Q007B3Q00013Q00203B5Q00044Q000100023Q00202Q0001000100056Q0002000200064Q001200010001000426012Q00120001002E150006001200010007000426012Q00120001002E5D0009003900010008000426012Q0039000100126C3Q000A4Q003A000100013Q0026C53Q00180001000A000426012Q00180001002E04010B00FEFF2Q000C000426012Q0014000100126C0001000A3Q000E62000A001F00010001000426012Q001F0001002ED2000D001F0001000E000426012Q001F0001002E71001000190001000F000426012Q0019000100126C0002000A3Q0026C5000200240001000A000426012Q00240001002E710012002000010011000426012Q0020000100126C0003000A3Q0026C5000300290001000A000426012Q00290001002E710014002500010013000426012Q002500012Q007B000400014Q00E2000500033Q00122Q000600153Q00122Q000700166Q00050007000200202Q00040005000A4Q000400033Q00122Q000500173Q00122Q000600186Q000400066Q00045Q00044Q00250001000426012Q00200001000426012Q00190001000426012Q00390001000426012Q00140001002E5D001A006200010019000426012Q006200012Q007B7Q0020DA5Q00014Q000200023Q00202Q00020002001B6Q0002000200064Q006200013Q000426012Q00620001002E5D001C00620001001D000426012Q006200012Q007B3Q00013Q002047014Q00044Q000100023Q00202Q0001000100056Q0002000200064Q006200013Q000426012Q0062000100126C3Q000A4Q003A000100013Q002E5D001E004D0001001F000426012Q004D00010026AB3Q004D0001000A000426012Q004D000100126C0001000A3Q0026AB000100520001000A000426012Q005200012Q007B000200014Q00E2000300033Q00122Q000400203Q00122Q000500216Q00030005000200202Q00020003000A4Q000200033Q00122Q000300223Q00122Q000400236Q000200046Q00025Q00044Q00520001000426012Q00620001000426012Q004D00012Q0090012Q00024Q00242Q0100036Q000200026Q000300033Q00122Q000400243Q00122Q000500256Q0003000500024Q0002000200030002B100035Q00126C000400264Q007D0001000300012Q0090010200034Q0015010300026Q000400033Q00122Q000500273Q00122Q000600286Q0004000600024Q00030003000400066501040001000100012Q007B3Q00043Q00126C000500294Q007D0002000300012Q007D3Q000200012Q007B000100053Q00208200010001002A2Q00332Q01000100022Q007B000200024Q004B010300033Q00122Q0004002B3Q00122Q0005002C6Q0003000500024Q00020002000300202Q00020002002D4Q00020002000200062Q0002008900013Q000426012Q0089000100126C0002002E3Q00067C0002008A00010001000426012Q008A000100126C0002002F4Q00CA000200064Q00B001025Q00202Q0002000200304Q0002000200024Q000200046Q000200083Q00202Q0002000200314Q000300046Q0002000200024Q000200076Q00025Q0020AC0002000200322Q00720002000200022Q00CA000200094Q007B00025Q0020AC0002000200332Q007B000400023Q0020820004000400342Q003A000500054Q0077000600014Q00A8010200060002000657010200A400013Q000426012Q00A4000100126C000200353Q00067C000200A500010001000426012Q00A5000100126C0002000A4Q00CA0002000A4Q008C0002000C6Q0002000100024Q0002000B6Q00025Q00202Q0002000200364Q0002000200024Q0002000D6Q0002000F6Q0003000A6Q0002000200022Q00CA0002000E4Q000B01025Q00202Q0002000200374Q000400046Q0005000A6Q0002000500024Q000200106Q000200116Q00020001000200062Q000200D900013Q000426012Q00D9000100126C0002000A4Q003A000300033Q0026AB000200BD0001000A000426012Q00BD000100126C0003000A3Q002E040138000F00010038000426012Q00CF0001000ED3000A00CF00010003000426012Q00CF00012Q007B00045Q0020CC00040004003900122Q0006003A6Q0004000600024Q000400126Q00045Q00202Q0004000400394Q000600066Q0004000600024Q000400133Q00122Q0003003B3Q0026AB000300C00001003B000426012Q00C000012Q007B000400134Q00AF010400044Q00CA000400143Q000426012Q00DB0001000426012Q00C00001000426012Q00DB0001000426012Q00BD0001000426012Q00DB000100126C0002003B4Q00CA000200144Q007B000200164Q00680002000100024Q000200156Q000200013Q00202Q00020002003C4Q00020001000200062Q000200FE00013Q000426012Q00FE000100126C0002000A3Q002E71003E00E40001003D000426012Q00E400010026AB000200E40001000A000426012Q00E400012Q007B000300014Q0035010400033Q00122Q0005003F3Q00122Q000600406Q0004000600024Q000500013Q00202Q00050005003C4Q0005000100024Q0003000400054Q000300033Q00122Q000400413Q00126C000500424Q00500003000500024Q000400176Q000500013Q00202Q0005000500434Q00040002000200202Q0004000400444Q0004000200024Q0003000300044Q000300023Q00044Q00E40001002E5D004500052Q010046000426012Q00052Q012Q007B000200153Q000657010200052Q013Q000426012Q00052Q012Q007B000200154Q0030000200024Q007B000200184Q00120002000100014Q000200016Q000300033Q00122Q000400473Q00122Q000500486Q0003000500024Q000400083Q00202Q0004000400494Q0004000100024Q0002000300042Q007B000200014Q00A5010300033Q00122Q0004004A3Q00122Q0005004B6Q0003000500024Q000400083Q00202Q00040004004C4Q0004000100024Q000200030004002E2Q004D006F2Q01004E000426012Q006F2Q012Q007B000200014Q00E6000300033Q00122Q0004004F3Q00122Q000500506Q0003000500024Q0002000200034Q000300033Q00122Q000400513Q00122Q000500526Q0003000500024Q0002000200034Q000300033Q00122Q000400533Q00122Q000500546Q0003000500024Q000200020003000E2Q000A006F2Q010002000426012Q006F2Q010012B9000200554Q0051000300033Q00122Q000400563Q00122Q000500576Q0003000500024Q00020002000300202Q00020002005800062Q0002006F2Q010001000426012Q006F2Q0100126C0002000A4Q003A000300033Q0026C50002003C2Q01000A000426012Q003C2Q01002E71005900382Q01005A000426012Q00382Q0100126C0003000A3Q0026AB0003003D2Q01000A000426012Q003D2Q010012B90004005B4Q008B0004000100024Q000400196Q0004001B6Q000500196Q000600016Q000700033Q00122Q0008005C3Q00122Q0009005D6Q0007000900024Q0006000600074Q000700033Q00122Q0008005E3Q00122Q0009005F6Q0007000900024Q0006000600074Q000700033Q00122Q000800603Q00122Q000900616Q0007000900024Q0006000600074Q0004000600024Q0005001C6Q000600196Q000700016Q000800033Q00122Q0009005C3Q00122Q000A005D6Q0008000A00024Q0007000700084Q000800033Q00122Q0009005E3Q00122Q000A005F6Q0008000A00024Q0007000700084Q000800033Q00122Q000900603Q00122Q000A00616Q0008000A00024Q0007000700084Q0005000700024Q0004000400054Q0004001A3Q00044Q00DB2Q01000426012Q003D2Q01000426012Q00DB2Q01000426012Q00382Q01000426012Q00DB2Q012Q007B000200014Q00E6000300033Q00122Q000400623Q00122Q000500636Q0003000500024Q0002000200034Q000300033Q00122Q000400643Q00122Q000500656Q0003000500024Q0002000200034Q000300033Q00122Q000400663Q00122Q000500676Q0003000500024Q000200020003000E2Q000A00DB2Q010002000426012Q00DB2Q012Q007B0002001A3Q0026C5000200DB2Q010068000426012Q00DB2Q010012B90002005B4Q00330102000100022Q007B0003001A3Q00068F010300DB2Q010002000426012Q00DB2Q010012B9000200554Q0098010300033Q00122Q000400693Q00122Q0005006A6Q0003000500024Q00020002000300202Q00020002005800062Q000200DB2Q013Q000426012Q00DB2Q0100126C0002000A4Q003A000300033Q000ED3000A00942Q010002000426012Q00942Q0100126C0003000A3Q002E5D006C009B2Q01006B000426012Q009B2Q010026C50003009D2Q01003B000426012Q009D2Q01002E5D006D00B92Q01006E000426012Q00B92Q012Q007B000400013Q00208200040004006F2Q007B000500033Q00126C000600703Q00126C000700714Q00A80105000700020012B9000600554Q0098010700033Q00122Q000800723Q00122Q000900736Q0007000900024Q00060006000700202Q00060006005800062Q000600B22Q013Q000426012Q00B22Q012Q007B000600033Q00126C000700743Q00126C000800754Q00A801060008000200067C000600B62Q010001000426012Q00B62Q012Q007B000600033Q00126C000700763Q00126C000800774Q00A80106000800022Q001C0105000500062Q00A2010400020001000426012Q00DB2Q01002E040178000400010078000426012Q00BD2Q010026C5000300BF2Q01000A000426012Q00BF2Q01002E71007A00972Q010079000426012Q00972Q010012B9000400554Q0042010500033Q00122Q0006007B3Q00122Q0007007C6Q0005000700024Q00040004000500122Q000500556Q000600033Q00122Q0007007D3Q00122Q0008007E6Q0006000800022Q00040005000500060020B80005000500584Q000500053Q00102Q0004005800054Q000400016Q000500033Q00122Q0006007F3Q00122Q000700806Q0005000700024Q00040004000500202Q00040004008100126C000600584Q005301040006000100126C0003003B3Q000426012Q00972Q01000426012Q00DB2Q01000426012Q00942Q012Q007B000200053Q0020B10102000200824Q0003001D6Q0004001E3Q00202Q0004000400834Q0005001F6Q000600203Q00122Q000700843Q00122Q000800856Q0002000800024Q000200154Q007B000200153Q00067C000200EB2Q010001000426012Q00EB2Q01002E5D008600ED2Q010007000426012Q00ED2Q012Q007B000200154Q0030000200024Q007B000200213Q0006570102002B02013Q000426012Q002B02012Q007B000200024Q004B010300033Q00122Q000400873Q00122Q000500886Q0003000500024Q00020002000300202Q0002000200894Q00020002000200062Q0002002B02013Q000426012Q002B02012Q007B000200024Q00D1000300033Q00122Q0004008A3Q00122Q0005008B6Q0003000500024Q00020002000300202Q00020002008C00122Q0004008D6Q00020004000200262Q0002002B0201000A000426012Q002B02012Q007B000200013Q0020340002000200044Q000300023Q00202Q00030003008E4Q000400066Q00020006000200062Q0002007B02013Q000426012Q007B020100126C0002000A4Q003A000300033Q002E5D008F000F02010090000426012Q000F02010026AB0002000F0201000A000426012Q000F020100126C0003000A3Q0026AB000300140201000A000426012Q0014020100126C0004000A3Q002E0401913Q00010091000426012Q00170201000ED3000A001702010004000426012Q001702012Q007B000500014Q00E2000600033Q00122Q000700923Q00122Q000800936Q00060008000200202Q0005000600944Q000500033Q00122Q000600953Q00122Q000700966Q000500076Q00055Q00044Q00170201000426012Q00140201000426012Q007B0201000426012Q000F0201000426012Q007B02012Q007B000200024Q004B010300033Q00122Q000400973Q00122Q000500986Q0003000500024Q00020002000300202Q0002000200894Q00020002000200062Q0002003F02013Q000426012Q003F02012Q007B000200024Q0035000300033Q00122Q000400993Q00122Q0005009A6Q0003000500024Q00020002000300202Q00020002008C4Q000200020002000E2Q000A004202010002000426012Q004202012Q007B000200213Q00067C0002004402010001000426012Q00440201002E71009C007B0201009B000426012Q007B020100126C0002000A4Q003A000300033Q000ED3000A004602010002000426012Q0046020100126C0003000A3Q002E71009D00490201009E000426012Q00490201000ED3000A004902010003000426012Q004902010012B9000400554Q00F6000500033Q00122Q0006009F3Q00122Q000700A06Q0005000700024Q00040004000500122Q000500556Q000600033Q00122Q000700A23Q00122Q000800A36Q0006000800024Q00050005000600202Q0005000500A14Q000500053Q00102Q000400A100054Q000400013Q00202Q00040004006F4Q000500033Q00122Q000600A43Q00122Q000700A56Q00050007000200122Q000600556Q000700033Q00122Q000800A63Q00122Q000900A76Q0007000900024Q00060006000700202Q0006000600A100062Q0006007102013Q000426012Q007102012Q007B000600033Q00126C000700A83Q00126C000800A94Q00A801060008000200067C0006007502010001000426012Q007502012Q007B000600033Q00126C000700AA3Q00126C000800AB4Q00A80106000800022Q001C0105000500062Q00A2010400020001000426012Q007B0201000426012Q00490201000426012Q007B0201000426012Q004602012Q007B000200223Q0006570102001403013Q000426012Q001403012Q007B000200024Q004B010300033Q00122Q000400AC3Q00122Q000500AD6Q0003000500024Q00020002000300202Q0002000200894Q00020002000200062Q0002001403013Q000426012Q001403012Q007B000200024Q00D1000300033Q00122Q000400AE3Q00122Q000500AF6Q0003000500024Q00020002000300202Q00020002008C00122Q0004008D6Q00020004000200262Q000200140301000A000426012Q001403012Q007B00025Q0020410102000200B04Q000400016Q000500016Q00020005000200062Q000200A102010001000426012Q00A102012Q007B00025Q0020DA0002000200334Q000400023Q00202Q0004000400B14Q00020004000200062Q0002001403013Q000426012Q001403012Q007B000200233Q0020AC0002000200B200126C000400B34Q00A801020004000200067C000200B202010001000426012Q00B202012Q007B000200244Q007E000300033Q00122Q000400B43Q00122Q000500B56Q000300056Q00023Q000200202Q0002000200B200122Q000400B36Q00020004000200062Q0002001403013Q000426012Q001403012Q007B000200013Q0020340002000200044Q000300023Q00202Q0003000300B64Q000400066Q00020006000200062Q0002006203013Q000426012Q006203012Q007B000200244Q0028000300033Q00122Q000400B73Q00122Q000500B86Q000300056Q00023Q000200202Q0002000200B94Q00020002000200262Q000200EA02010068000426012Q00EA02012Q007B000200244Q007E010300033Q00122Q000400BA3Q00122Q000500BB6Q000300056Q00023Q00020020DA0002000200BC4Q000400023Q00202Q0004000400B64Q00020004000200062Q000200EA02013Q000426012Q00EA020100126C0002000A4Q003A000300033Q0026C5000200D60201000A000426012Q00D60201002E7100BE00D2020100BD000426012Q00D2020100126C0003000A3Q002E0401BF3Q000100BF000426012Q00D702010026AB000300D70201000A000426012Q00D702012Q007B000400014Q00E2000500033Q00122Q000600C03Q00122Q000700C16Q00050007000200202Q0004000500C24Q000400033Q00122Q000500C33Q00122Q000600C46Q000400066Q00045Q00044Q00D70201000426012Q00620301000426012Q00D20201000426012Q0062030100126C0002000A4Q003A000300033Q0026AB000200EC0201000A000426012Q00EC020100126C0003000A3Q000E62000A00F302010003000426012Q00F30201002E5D00C600EF020100C5000426012Q00EF020100126C0004000A4Q003A000500053Q000ED3000A00F502010004000426012Q00F5020100126C0005000A3Q000ED3000A00F802010005000426012Q00F8020100126C0006000A3Q002E5D00C700FF020100C8000426012Q00FF02010026C5000600010301000A000426012Q00010301002E7100CA00FB020100C9000426012Q00FB02012Q007B000700014Q00E2000800033Q00122Q000900CB3Q00122Q000A00CC6Q0008000A000200202Q0007000800CD4Q000700033Q00122Q000800CE3Q00122Q000900CF6Q000700096Q00075Q00044Q00FB0201000426012Q00F80201000426012Q00EF0201000426012Q00F50201000426012Q00EF0201000426012Q00620301000426012Q00EC0201000426012Q00620301002E7100D00062030100D1000426012Q006203012Q007B000200024Q004B010300033Q00122Q000400D23Q00122Q000500D36Q0003000500024Q00020002000300202Q0002000200894Q00020002000200062Q0002002A03013Q000426012Q002A03012Q007B000200024Q0035000300033Q00122Q000400D43Q00122Q000500D56Q0003000500024Q00020002000300202Q00020002008C4Q000200020002000E2Q000A006203010002000426012Q006203012Q007B000200223Q0006570102006203013Q000426012Q0062030100126C0002000A4Q003A000300033Q0026AB0002002F0301000A000426012Q002F030100126C0003000A3Q0026AB000300320301000A000426012Q003203010012B9000400554Q00F6000500033Q00122Q000600D63Q00122Q000700D76Q0005000700024Q00040004000500122Q000500556Q000600033Q00122Q000700D93Q00122Q000800DA6Q0006000800024Q00050005000600202Q0005000500D84Q000500053Q00102Q000400D800054Q000400013Q00202Q00040004006F4Q000500033Q00122Q000600DB3Q00122Q000700DC6Q00050007000200122Q000600556Q000700033Q00122Q000800DD3Q00122Q000900DE6Q0007000900024Q00060006000700202Q0006000600D800062Q0006005803013Q000426012Q005803012Q007B000600033Q00126C000700DF3Q00126C000800E04Q00A801060008000200067C0006005C03010001000426012Q005C03012Q007B000600033Q00126C000700E13Q00126C000800E24Q00A80106000800022Q001C0105000500062Q00A2010400020001000426012Q00620301000426012Q00320301000426012Q00620301000426012Q002F03012Q007B000200253Q000657010200EA03013Q000426012Q00EA03012Q007B000200024Q004B010300033Q00122Q000400E33Q00122Q000500E46Q0003000500024Q00020002000300202Q0002000200894Q00020002000200062Q000200EA03013Q000426012Q00EA03012Q007B000200024Q00D1000300033Q00122Q000400E53Q00122Q000500E66Q0003000500024Q00020002000300202Q00020002008C00122Q0004008D6Q00020004000200262Q000200EA0301000A000426012Q00EA03012Q007B000200233Q0020AC0002000200B200126C000400B34Q00A801020004000200067C0002008B03010001000426012Q008B03012Q007B000200244Q007E000300033Q00122Q000400E73Q00122Q000500E86Q000300056Q00023Q000200202Q0002000200B200122Q000400B36Q00020004000200062Q000200EA03013Q000426012Q00EA03012Q007B000200013Q002Q200102000200044Q000300023Q00202Q0003000300E94Q000400066Q00020006000200062Q0002009503010001000426012Q00950301002E7100EA0044040100D0000426012Q004404012Q007B000200244Q0028000300033Q00122Q000400EB3Q00122Q000500EC6Q000300056Q00023Q000200202Q0002000200B94Q00020002000200262Q000200AB03010068000426012Q00AB03012Q007B000200244Q007E010300033Q00122Q000400ED3Q00122Q000500EE6Q000300056Q00023Q00020020AB0102000200BC4Q000400023Q00202Q0004000400E94Q00020004000200062Q000200AD03010001000426012Q00AD0301002E7100EF00D3030100F0000426012Q00D3030100126C0002000A4Q003A000300033Q0026C5000200B30301000A000426012Q00B30301002E7100F100AF030100F2000426012Q00AF030100126C0003000A3Q0026C5000300B80301000A000426012Q00B80301002E7100F300B4030100F4000426012Q00B4030100126C0004000A3Q002E5D00F600B9030100F5000426012Q00B903010026AB000400B90301000A000426012Q00B9030100126C0005000A3Q002E5D00F700BE030100F8000426012Q00BE03010026AB000500BE0301000A000426012Q00BE03012Q007B000600014Q00E2000700033Q00122Q000800F93Q00122Q000900FA6Q00070009000200202Q0006000700FB4Q000600033Q00122Q000700FC3Q00122Q000800FD6Q000600086Q00065Q00044Q00BE0301000426012Q00B90301000426012Q00B40301000426012Q00440401000426012Q00AF0301000426012Q0044040100126C0002000A3Q0026C5000200D80301000A000426012Q00D80301002E0401FE00FEFF2Q00FF000426012Q00D4030100126C0003000A3Q0026AB000300D90301000A000426012Q00D903012Q007B000400014Q0041000500033Q00122Q00062Q00012Q00122Q0007002Q015Q00050007000200122Q000600296Q0004000500064Q000400033Q00122Q00050002012Q00122Q00060003015Q000400066Q00045Q00044Q00D90301000426012Q00D40301000426012Q004404012Q007B000200024Q004B010300033Q00122Q00040004012Q00122Q00050005015Q0003000500024Q00020002000300202Q0002000200894Q00020002000200062Q000200FF03013Q000426012Q00FF03012Q007B000200024Q0087010300033Q00122Q00040006012Q00122Q00050007015Q0003000500024Q00020002000300202Q00020002008C4Q00020002000200126C0003000A3Q00068F0103000204010002000426012Q000204012Q007B000200253Q00067C0002000604010001000426012Q0006040100126C00020008012Q00126C00030009012Q00068F0102004404010003000426012Q0044040100126C0002000A4Q003A000300033Q00126C0004000A3Q0006ED0002000804010004000426012Q0008040100126C0003000A3Q00126C0004000A3Q0006230103001304010004000426012Q0013040100126C0004000A012Q00126C0005000B012Q00068F0104000C04010005000426012Q000C04010012B9000400554Q00B5010500033Q00122Q0006000C012Q00122Q0007000D015Q0005000700024Q00040004000500122Q0005000E012Q00122Q000600556Q000700033Q00122Q0008000F012Q00122Q00090010015Q0007000900024Q00060006000700122Q0007000E015Q0006000600074Q000600066Q0004000500064Q000400013Q00202Q00040004006F4Q000500033Q00122Q00060011012Q00122Q00070012015Q00050007000200122Q000600556Q000700033Q00122Q00080013012Q00122Q00090014015Q0007000900024Q00060006000700122Q0007000E015Q00060006000700062Q0006003A04013Q000426012Q003A04012Q007B000600033Q00126C00070015012Q00126C00080016013Q00A801060008000200067C0006003E04010001000426012Q003E04012Q007B000600033Q00126C00070017012Q00126C00080018013Q00A80106000800022Q001C0105000500062Q00A2010400020001000426012Q00440401000426012Q000C0401000426012Q00440401000426012Q000804012Q007B000200263Q000657010200B804013Q000426012Q00B804012Q007B000200024Q004B010300033Q00122Q00040019012Q00122Q0005001A015Q0003000500024Q00020002000300202Q0002000200894Q00020002000200062Q000200B804013Q000426012Q00B804012Q007B000200024Q0014000300033Q00122Q0004001B012Q00122Q0005001C015Q0003000500024Q00020002000300202Q00020002008C00122Q0004008D6Q00020004000200122Q0003000A3Q00062Q000200B804010003000426012Q00B804012Q007B000200233Q0020AC0002000200B200126C0004001D013Q00A801020004000200067C0002006E04010001000426012Q006E04012Q007B000200244Q007E000300033Q00122Q0004001E012Q00122Q0005001F015Q000300056Q00023Q000200202Q0002000200B200122Q0004001D015Q00020004000200062Q000200B804013Q000426012Q00B8040100126C00020020012Q00126C00030021012Q0006C60003007B04010002000426012Q007B04012Q007B000200013Q0020E50002000200044Q000300023Q00122Q00040022015Q0003000300044Q000400066Q00020006000200062Q0002007F04010001000426012Q007F040100126C00020023012Q00126C00030024012Q0006C60002001A05010003000426012Q001A050100126C00020025012Q00126C00030026012Q00068F0102001A05010003000426012Q001A05012Q007B000200245Q00010300033Q00122Q00040027012Q00122Q00050028015Q000300056Q00023Q000200202Q0002000200B94Q0002000200024Q000300033Q00062Q0002001A05010003000426012Q001A05012Q007B000200244Q005C010300033Q00122Q00040029012Q00122Q0005002A015Q000300056Q00023Q000200202Q0002000200BC4Q000400023Q00122Q00050022015Q0004000400054Q00020004000200062Q0002001A05013Q000426012Q001A050100126C0002000A4Q003A000300033Q00126C0004000A3Q0006ED0002009D04010004000426012Q009D040100126C0003000A3Q00126C0004002B012Q00126C0005002C012Q0006C6000400A104010005000426012Q00A1040100126C0004000A3Q0006ED000300A104010004000426012Q00A104012Q007B000400014Q0041000500033Q00122Q0006002D012Q00122Q0007002E015Q00050007000200122Q0006002F015Q0004000500064Q000400033Q00122Q00050030012Q00122Q00060031015Q000400066Q00045Q00044Q00A10401000426012Q001A0501000426012Q009D0401000426012Q001A050100126C00020032012Q00126C00030032012Q0006ED0002001A05010003000426012Q001A05012Q007B000200024Q004B010300033Q00122Q00040033012Q00122Q00050034015Q0003000500024Q00020002000300202Q0002000200894Q00020002000200062Q000200D104013Q000426012Q00D104012Q007B000200024Q0087010300033Q00122Q00040035012Q00122Q00050036015Q0003000500024Q00020002000300202Q00020002008C4Q00020002000200126C0003000A3Q00068F010300D404010002000426012Q00D404012Q007B000200263Q00067C000200D804010001000426012Q00D8040100126C00020037012Q00126C00030038012Q0006ED0002001A05010003000426012Q001A050100126C0002000A4Q003A000300033Q00126C0004000A3Q000623010200E104010004000426012Q00E1040100126C000400C63Q00126C00050039012Q0006C6000500DA04010004000426012Q00DA040100126C0003000A3Q00126C0004003A012Q00126C0005003A012Q0006ED000400E204010005000426012Q00E2040100126C0004000A3Q0006ED000300E204010004000426012Q00E204010012B9000400554Q00B5010500033Q00122Q0006003B012Q00122Q0007003C015Q0005000700024Q00040004000500122Q000500843Q00122Q000600556Q000700033Q00122Q0008003D012Q00122Q0009003E015Q0007000900024Q00060006000700122Q000700846Q0006000600074Q000600066Q0004000500064Q000400013Q00202Q00040004006F4Q000500033Q00122Q0006003F012Q00122Q00070040015Q00050007000200122Q000600556Q000700033Q00122Q00080041012Q00122Q00090042015Q0007000900024Q00060006000700122Q000700846Q00060006000700062Q0006001005013Q000426012Q001005012Q007B000600033Q00126C00070043012Q00126C00080044013Q00A801060008000200067C0006001405010001000426012Q001405012Q007B000600033Q00126C00070045012Q00126C00080046013Q00A80106000800022Q001C0105000500062Q00A2010400020001000426012Q001A0501000426012Q00E20401000426012Q001A0501000426012Q00DA04012Q007B000200273Q000657010200B605013Q000426012Q00B605012Q007B000200024Q004B010300033Q00122Q00040047012Q00122Q00050048015Q0003000500024Q00020002000300202Q0002000200894Q00020002000200062Q000200B605013Q000426012Q00B605012Q007B000200024Q0014000300033Q00122Q00040049012Q00122Q0005004A015Q0003000500024Q00020002000300202Q00020002008C00122Q0004008D6Q00020004000200122Q0003000A3Q00062Q000200B605010003000426012Q00B605012Q007B00025Q0020520102000200B04Q000400016Q000500016Q00020005000200062Q000200B605013Q000426012Q00B605012Q007B000200233Q0020AC0002000200B200126C0004004B013Q00A801020004000200067C0002004B05010001000426012Q004B05012Q007B000200244Q007E000300033Q00122Q0004004C012Q00122Q0005004D015Q000300056Q00023Q000200202Q0002000200B200122Q0004004B015Q00020004000200062Q000200B605013Q000426012Q00B605012Q007B000200013Q0020E50002000200044Q000300023Q00122Q0004004E015Q0003000300044Q000400066Q00020006000200062Q0002005805010001000426012Q0058050100126C0002004F012Q00126C00030050012Q0006C60002001F06010003000426012Q001F060100126C00020051012Q00126C00030052012Q0006C60002009905010003000426012Q009905012Q007B000200245Q00010300033Q00122Q00040053012Q00122Q00050054015Q000300056Q00023Q000200202Q0002000200B94Q0002000200024Q000300033Q00062Q0002009905010003000426012Q009905012Q007B000200244Q005C010300033Q00122Q00040055012Q00122Q00050056015Q000300056Q00023Q000200202Q0002000200BC4Q000400023Q00122Q0005004E015Q0004000400054Q00020004000200062Q0002009905013Q000426012Q0099050100126C0002000A4Q003A000300033Q00126C00040057012Q00126C00050058012Q0006C60005007605010004000426012Q0076050100126C0004000A3Q0006ED0002007605010004000426012Q0076050100126C0003000A3Q00126C000400D13Q00126C00050059012Q00068F0105007E05010004000426012Q007E050100126C0004000A3Q0006230103008905010004000426012Q0089050100126C0004005A012Q00126C0005005B012Q0006ED0004007E05010005000426012Q007E05012Q007B000400014Q0041000500033Q00122Q0006005C012Q00122Q0007005D015Q00050007000200122Q0006005E015Q0004000500064Q000400033Q00122Q0005005F012Q00122Q00060060015Q000400066Q00045Q00044Q007E0501000426012Q001F0601000426012Q00760501000426012Q001F060100126C0002000A4Q003A000300033Q00126C0004000A3Q0006ED0002009B05010004000426012Q009B050100126C0003000A3Q00126C0004000A3Q000623010300A605010004000426012Q00A6050100126C00040061012Q00126C00050062012Q0006C60004009F05010005000426012Q009F05012Q007B000400014Q0041000500033Q00122Q00060063012Q00122Q00070064015Q00050007000200122Q00060065015Q0004000500064Q000400033Q00122Q00050066012Q00122Q00060067015Q000400066Q00045Q00044Q009F0501000426012Q001F0601000426012Q009B0501000426012Q001F060100126C00020068012Q00126C00030069012Q00068F0103001F06010002000426012Q001F060100126C0002006A012Q00126C0003006B012Q0006C60003001F06010002000426012Q001F06012Q007B000200024Q004B010300033Q00122Q0004006C012Q00122Q0005006D015Q0003000500024Q00020002000300202Q0002000200894Q00020002000200062Q000200DA05013Q000426012Q00DA05012Q007B000200024Q0098000300033Q00122Q0004006E012Q00122Q0005006F015Q0003000500024Q00020002000300202Q00020002008C4Q00020002000200122Q0003000A3Q00062Q000300DA05010002000426012Q00DA05012Q007B00025Q0020410102000200B04Q000400016Q000500016Q00020005000200062Q0002001F06010001000426012Q001F06012Q007B000200273Q0006570102001F06013Q000426012Q001F060100126C0002000A4Q003A000300033Q00126C0004000A3Q000623010200E605010004000426012Q00E6050100126C00040070012Q00126C00050071012Q00068F010500DF05010004000426012Q00DF050100126C0003000A3Q00126C00040072012Q00126C00050073012Q00068F010400E705010005000426012Q00E7050100126C0004000A3Q0006ED000300E705010004000426012Q00E705010012B9000400554Q00B5010500033Q00122Q00060074012Q00122Q00070075015Q0005000700024Q00040004000500122Q000500853Q00122Q000600556Q000700033Q00122Q00080076012Q00122Q00090077015Q0007000900024Q00060006000700122Q000700856Q0006000600074Q000600066Q0004000500064Q000400013Q00202Q00040004006F4Q000500033Q00122Q00060078012Q00122Q00070079015Q00050007000200122Q000600556Q000700033Q00122Q0008007A012Q00122Q0009007B015Q0007000900024Q00060006000700122Q000700856Q00060006000700062Q0006001506013Q000426012Q001506012Q007B000600033Q00126C0007007C012Q00126C0008007D013Q00A801060008000200067C0006001906010001000426012Q001906012Q007B000600033Q00126C0007007E012Q00126C0008007F013Q00A80106000800022Q001C0105000500062Q00A2010400020001000426012Q001F0601000426012Q00E70501000426012Q001F0601000426012Q00DF050100126C00020080012Q00126C00030081012Q00068F0103007F06010002000426012Q007F060100126C00020082012Q00126C00030083012Q00068F0103007F06010002000426012Q007F06012Q007B000200283Q0006570102007F06013Q000426012Q007F06012Q007B000200024Q004B010300033Q00122Q00040084012Q00122Q00050085015Q0003000500024Q00020002000300202Q0002000200894Q00020002000200062Q0002007F06013Q000426012Q007F06012Q007B000200024Q0014000300033Q00122Q00040086012Q00122Q00050087015Q0003000500024Q00020002000300202Q00020002008C00122Q0004008D6Q00020004000200122Q0003000A3Q00062Q0002007F06010003000426012Q007F06012Q007B00025Q00126C00040088013Q00400102000200042Q00720002000200020006570102007F06013Q000426012Q007F06012Q007B00025Q00128401040089015Q00020002000400122Q0004003B6Q000500023Q00122Q0006008A015Q0005000500064Q00020005000200062Q0002007F06010001000426012Q007F06012Q007B000200013Q0020E50002000200044Q000300023Q00122Q0004008A015Q0003000300044Q000400066Q00020006000200062Q0002005D06010001000426012Q005D060100126C0002008B012Q00126C0003008C012Q0006C6000300DF06010002000426012Q00DF060100126C0002000A4Q003A000300033Q00126C0004000A3Q0006ED0002005F06010004000426012Q005F060100126C0003000A3Q00126C0004008D012Q00126C0005008E012Q00068F0105006306010004000426012Q0063060100126C0004000A3Q0006ED0003006306010004000426012Q0063060100126C0004000A3Q00126C0005000A3Q0006ED0004006B06010005000426012Q006B06012Q007B000500014Q0041000600033Q00122Q0007008F012Q00122Q00080090015Q00060008000200122Q00070091015Q0005000600074Q000500033Q00122Q00060092012Q00122Q00070093015Q000500076Q00055Q00044Q006B0601000426012Q00630601000426012Q00DF0601000426012Q005F0601000426012Q00DF06012Q007B000200024Q004B010300033Q00122Q00040094012Q00122Q00050095015Q0003000500024Q00020002000300202Q0002000200894Q00020002000200062Q0002009A06013Q000426012Q009A06012Q007B000200024Q0098000300033Q00122Q00040096012Q00122Q00050097015Q0003000500024Q00020002000300202Q00020002008C4Q00020002000200122Q0003000A3Q00062Q0003009A06010002000426012Q009A06012Q007B00025Q00126C00040088013Q00400102000200042Q007200020002000200067C000200DF06010001000426012Q00DF06012Q007B000200283Q000657010200DF06013Q000426012Q00DF060100126C0002000A4Q003A000300033Q00126C00040098012Q00126C00050098012Q0006ED0004009F06010005000426012Q009F060100126C0004000A3Q0006ED0002009F06010004000426012Q009F060100126C0003000A3Q00126C00040099012Q00126C00050099012Q0006ED000400A706010005000426012Q00A7060100126C0004000A3Q0006ED000300A706010004000426012Q00A706010012B9000400554Q00B5010500033Q00122Q0006009A012Q00122Q0007009B015Q0005000700024Q00040004000500122Q0005009C012Q00122Q000600556Q000700033Q00122Q0008009D012Q00122Q0009009E015Q0007000900024Q00060006000700122Q0007009C015Q0006000600074Q000600066Q0004000500064Q000400013Q00202Q00040004006F4Q000500033Q00122Q0006009F012Q00122Q000700A0015Q00050007000200122Q000600556Q000700033Q00122Q000800A1012Q00122Q000900A2015Q0007000900024Q00060006000700122Q0007009C015Q00060006000700062Q000600D506013Q000426012Q00D506012Q007B000600033Q00126C000700A3012Q00126C000800A4013Q00A801060008000200067C000600D906010001000426012Q00D906012Q007B000600033Q00126C000700A5012Q00126C000800A6013Q00A80106000800022Q001C0105000500062Q00A2010400020001000426012Q00DF0601000426012Q00A70601000426012Q00DF0601000426012Q009F06012Q007B000200293Q000657010200FE06013Q000426012Q00FE06012Q007B000200024Q004B010300033Q00122Q000400A7012Q00122Q000500A8015Q0003000500024Q00020002000300202Q0002000200894Q00020002000200062Q000200FE06013Q000426012Q00FE06012Q007B000200024Q0014000300033Q00122Q000400A9012Q00122Q000500AA015Q0003000500024Q00020002000300202Q00020002008C00122Q0004008D6Q00020004000200122Q0003000A3Q00062Q000200FE06010003000426012Q00FE06012Q007B00025Q00126C00040088013Q00400102000200042Q007200020002000200067C0002000207010001000426012Q0002070100126C000200AB012Q00126C000300AC012Q0006C60002002C07010003000426012Q002C070100126C000200AD012Q00126C000300AE012Q0006C60002008C07010003000426012Q008C07012Q007B000200013Q0020820102000200044Q000300023Q00122Q000400AF015Q0003000300044Q000400056Q000600233Q00202Q0006000600BC4Q000800023Q00122Q000900AF015Q0008000800094Q0006000800024Q000600066Q00020006000200062Q0002008C07013Q000426012Q008C070100126C0002000A3Q00126C0003000A3Q0006230102001E07010003000426012Q001E070100126C000300B0012Q00126C000400B1012Q00068F0104001707010003000426012Q001707012Q007B000300014Q0041000400033Q00122Q000500B2012Q00122Q000600B3015Q00040006000200122Q000500B4015Q0003000400054Q000300033Q00122Q000400B5012Q00122Q000500B6015Q000300056Q00035Q00044Q00170701000426012Q008C07012Q007B000200024Q004B010300033Q00122Q000400B7012Q00122Q000500B8015Q0003000500024Q00020002000300202Q0002000200894Q00020002000200062Q0002004707013Q000426012Q004707012Q007B000200024Q0098000300033Q00122Q000400B9012Q00122Q000500BA015Q0003000500024Q00020002000300202Q00020002008C4Q00020002000200122Q0003000A3Q00062Q0003004707010002000426012Q004707012Q007B00025Q00126C00040088013Q00400102000200042Q007200020002000200067C0002004A07010001000426012Q004A07012Q007B000200293Q00067C0002004E07010001000426012Q004E070100126C000200BB012Q00126C000300BC012Q00068F0102008C07010003000426012Q008C070100126C0002000A4Q003A000300033Q00126C000400BD012Q00126C000500BE012Q0006C60005005007010004000426012Q0050070100126C0004000A3Q0006ED0004005007010002000426012Q0050070100126C0003000A3Q00126C0004000A3Q0006ED0004005807010003000426012Q005807010012B9000400554Q00B5010500033Q00122Q000600BF012Q00122Q000700C0015Q0005000700024Q00040004000500122Q000500C1012Q00122Q000600556Q000700033Q00122Q000800C2012Q00122Q000900C3015Q0007000900024Q00060006000700122Q000700C1015Q0006000600074Q000600066Q0004000500064Q000400013Q00202Q00040004006F4Q000500033Q00122Q000600C4012Q00122Q000700C5015Q00050007000200122Q000600556Q000700033Q00122Q000800C6012Q00122Q000900C7015Q0007000900024Q00060006000700122Q000700C1015Q00060006000700062Q0006008207013Q000426012Q008207012Q007B000600033Q00126C000700C8012Q00126C000800C9013Q00A801060008000200067C0006008607010001000426012Q008607012Q007B000600033Q00126C000700CA012Q00126C000800CB013Q00A80106000800022Q001C0105000500062Q00A2010400020001000426012Q008C0701000426012Q00580701000426012Q008C0701000426012Q0050070100126C000200CC012Q00126C000300CD012Q00068F0102004008010003000426012Q004008012Q007B0002002A3Q0006570102004008013Q000426012Q004008012Q007B000200024Q004B010300033Q00122Q000400CE012Q00122Q000500CF015Q0003000500024Q00020002000300202Q0002000200894Q00020002000200062Q0002004008013Q000426012Q004008012Q007B000200024Q0014000300033Q00122Q000400D0012Q00122Q000500D1015Q0003000500024Q00020002000300202Q00020002008C00122Q0004008D6Q00020004000200122Q0003000A3Q00062Q0002004008010003000426012Q0040080100126C000200D2012Q00126C000300D3012Q00068F010300B607010002000426012Q00B607012Q007B000200013Q0020E50002000200044Q000300023Q00122Q000400D4015Q0003000300044Q000400066Q00020006000200062Q000200BA07010001000426012Q00BA070100126C000200D5012Q00126C000300D6012Q0006C6000300A008010002000426012Q00A008012Q007B000200245Q00010300033Q00122Q000400D7012Q00122Q000500D8015Q000300056Q00023Q000200202Q0002000200B94Q0002000200024Q000300033Q00062Q0002000508010003000426012Q000508012Q007B000200244Q005C010300033Q00122Q000400D9012Q00122Q000500DA015Q000300056Q00023Q000200202Q0002000200BC4Q000400023Q00122Q000500D4015Q0004000400054Q00020004000200062Q0002000508013Q000426012Q0005080100126C0002000A4Q003A000300033Q00126C000400DB012Q00126C000500DC012Q00068F010500D407010004000426012Q00D4070100126C0004000A3Q0006ED000200D407010004000426012Q00D4070100126C0003000A3Q00126C000400DD012Q00126C000500DE012Q00068F010500DC07010004000426012Q00DC070100126C0004000A3Q0006ED000300DC07010004000426012Q00DC070100126C0004000A3Q00126C000500DF012Q00126C000600E0012Q0006C6000600E407010005000426012Q00E4070100126C0005000A3Q000623010400EF07010005000426012Q00EF070100126C000500E1012Q00126C000600E2012Q0006C6000600E407010005000426012Q00E4070100126C0005000A3Q00126C0006000A3Q0006ED000600F007010005000426012Q00F007012Q007B000600014Q0041000700033Q00122Q000800E3012Q00122Q000900E4015Q00070009000200122Q000800E5015Q0006000700084Q000600033Q00122Q000700E6012Q00122Q000800E7015Q000600086Q00065Q00044Q00F00701000426012Q00E40701000426012Q00DC0701000426012Q00A00801000426012Q00D40701000426012Q00A008012Q007B000200244Q007E010300033Q00122Q000400E8012Q00122Q000500E9015Q000300056Q00023Q000200200C0102000200BC4Q000400023Q00122Q000500D4015Q0004000400054Q00020004000200062Q0002001608010001000426012Q0016080100126C000200EA012Q00126C000300EB012Q0006C6000200A008010003000426012Q00A0080100126C0002000A3Q00126C000300EC012Q00126C000400EC012Q0006ED0003001708010004000426012Q0017080100126C0003000A3Q0006ED0002001708010003000426012Q0017080100126C0003000A4Q003A000400043Q00126C000500ED012Q00126C000600EE012Q0006C60006002708010005000426012Q0027080100126C0005000A3Q0006230103002B08010005000426012Q002B080100126C000500EF012Q00126C000600F0012Q00068F0106002008010005000426012Q0020080100126C0004000A3Q00126C0005000A3Q0006ED0004002C08010005000426012Q002C08012Q007B000500014Q0041000600033Q00122Q000700F1012Q00122Q000800F2015Q00060008000200122Q000700F3015Q0005000600074Q000500033Q00122Q000600F4012Q00122Q000700F5015Q000500076Q00055Q00044Q002C0801000426012Q00170801000426012Q00200801000426012Q00170801000426012Q00A0080100126C000200F6012Q00126C000300F7012Q00068F010300A008010002000426012Q00A008012Q007B000200024Q004B010300033Q00122Q000400F8012Q00122Q000500F9015Q0003000500024Q00020002000300202Q0002000200894Q00020002000200062Q0002005F08013Q000426012Q005F08012Q007B000200024Q0098000300033Q00122Q000400FA012Q00122Q000500FB015Q0003000500024Q00020002000300202Q00020002008C4Q00020002000200122Q0003000A3Q00062Q0003005F08010002000426012Q005F08012Q007B00025Q00126C00040088013Q00400102000200042Q007200020002000200067C000200A008010001000426012Q00A008012Q007B0002002A3Q000657010200A008013Q000426012Q00A0080100126C0002000A4Q003A000300033Q00126C0004000A3Q0006ED0002006408010004000426012Q0064080100126C0003000A3Q00126C000400FC012Q00126C000500FD012Q00068F0104006808010005000426012Q0068080100126C0004000A3Q0006ED0003006808010004000426012Q006808010012B9000400554Q00B5010500033Q00122Q000600FE012Q00122Q000700FF015Q0005000700024Q00040004000500122Q00052Q00022Q00122Q000600556Q000700033Q00122Q00080001022Q00122Q0009002Q025Q0007000900024Q00060006000700122Q00072Q00025Q0006000600074Q000600066Q0004000500064Q000400013Q00202Q00040004006F4Q000500033Q00122Q00060003022Q00122Q00070004025Q00050007000200122Q000600556Q000700033Q00122Q00080005022Q00122Q00090006025Q0007000900024Q00060006000700122Q00072Q00025Q00060006000700062Q0006009608013Q000426012Q009608012Q007B000600033Q00126C00070007022Q00126C00080008023Q00A801060008000200067C0006009A08010001000426012Q009A08012Q007B000600033Q00126C00070009022Q00126C0008000A023Q00A80106000800022Q001C0105000500062Q00A2010400020001000426012Q00A00801000426012Q00680801000426012Q00A00801000426012Q006408012Q007B0002002B3Q000657010200BF08013Q000426012Q00BF08012Q007B000200024Q004B010300033Q00122Q0004000B022Q00122Q0005000C025Q0003000500024Q00020002000300202Q0002000200894Q00020002000200062Q000200BF08013Q000426012Q00BF08012Q007B000200024Q0014000300033Q00122Q0004000D022Q00122Q0005000E025Q0003000500024Q00020002000300202Q00020002008C00122Q0004008D6Q00020004000200122Q0003000A3Q00062Q000200BF08010003000426012Q00BF08012Q007B00025Q00126C00040088013Q00400102000200042Q007200020002000200067C000200C308010001000426012Q00C3080100126C0002000F022Q00126C00030010022Q00068F010300F108010002000426012Q00F108012Q007B000200013Q0020E50002000200044Q000300023Q00122Q00040011025Q0003000300044Q000400066Q00020006000200062Q000200D008010001000426012Q00D0080100126C00020012022Q00126C00030013022Q00068F0103004A09010002000426012Q004A090100126C0002000A4Q003A000300033Q00126C00040014022Q00126C00050015022Q0006C6000400D208010005000426012Q00D2080100126C0004000A3Q0006ED000200D208010004000426012Q00D2080100126C0003000A3Q00126C0004000A3Q000623010300E108010004000426012Q00E1080100126C00040016022Q00126C00050017022Q0006C6000400DA08010005000426012Q00DA08012Q007B000400014Q0041000500033Q00122Q00060018022Q00122Q00070019025Q00050007000200122Q0006001A025Q0004000500064Q000400033Q00122Q0005001B022Q00122Q0006001C025Q000400066Q00045Q00044Q00DA0801000426012Q004A0901000426012Q00D20801000426012Q004A09012Q007B000200024Q004B010300033Q00122Q0004001D022Q00122Q0005001E025Q0003000500024Q00020002000300202Q0002000200894Q00020002000200062Q0002000C09013Q000426012Q000C09012Q007B000200024Q0098000300033Q00122Q0004001F022Q00122Q00050020025Q0003000500024Q00020002000300202Q00020002008C4Q00020002000200122Q0003000A3Q00062Q0003000C09010002000426012Q000C09012Q007B00025Q00126C00040088013Q00400102000200042Q007200020002000200067C0002000F09010001000426012Q000F09012Q007B0002002B3Q00067C0002001709010001000426012Q0017090100126C00020021022Q00126C00030022022Q0006920102000500010003000426012Q0017090100126C00020023022Q00126C00030024022Q00068F0103004A09010002000426012Q004A090100126C0002000A3Q00126C0003000A3Q0006ED0002001809010003000426012Q001809010012B9000300554Q00B5010400033Q00122Q00050025022Q00122Q00060026025Q0004000600024Q00030003000400122Q00040027022Q00122Q000500556Q000600033Q00122Q00070028022Q00122Q00080029025Q0006000800024Q00050005000600122Q00060027025Q0005000500064Q000500056Q0003000400054Q000300013Q00202Q00030003006F4Q000400033Q00122Q0005002A022Q00122Q0006002B025Q00040006000200122Q000500556Q000600033Q00122Q0007002C022Q00122Q0008002D025Q0006000800024Q00050005000600122Q00060027025Q00050005000600062Q0005004209013Q000426012Q004209012Q007B000500033Q00126C0006002E022Q00126C0007002F023Q00A801050007000200067C0005004609010001000426012Q004609012Q007B000500033Q00126C00060030022Q00126C00070031023Q00A80105000700022Q001C0104000400052Q00A2010300020001000426012Q004A0901000426012Q0018090100126C00020032022Q00126C00030032022Q0006ED0002006E0D010003000426012Q006E0D012Q007B0002002C3Q0006570102006E0D013Q000426012Q006E0D0100126C00020033022Q00126C00030034022Q0006C6000200B209010003000426012Q00B209012Q007B000200024Q004B010300033Q00122Q00040035022Q00122Q00050036025Q0003000500024Q00020002000300202Q00020002002D4Q00020002000200062Q000200B209013Q000426012Q00B209012Q007B000200024Q004B010300033Q00122Q00040037022Q00122Q00050038025Q0003000500024Q00020002000300202Q0002000200894Q00020002000200062Q000200B209013Q000426012Q00B209012Q007B000200024Q0014000300033Q00122Q00040039022Q00122Q0005003A025Q0003000500024Q00020002000300202Q00020002008C00122Q0004008D6Q00020004000200122Q0003000A3Q00062Q000200B209010003000426012Q00B209012Q007B00025Q00126C00040088013Q00400102000200042Q0072000200020002000657010200B209013Q000426012Q00B209012Q007B000200013Q0020E50002000200044Q000300023Q00122Q0004003B025Q0003000300044Q000400066Q00020006000200062Q0002008C09010001000426012Q008C090100126C0002003C022Q00126C0003003D022Q0006920102000500010003000426012Q008C090100126C0002003E022Q00126C0003003F022Q0006C60002006E0D010003000426012Q006E0D0100126C0002000A4Q003A000300033Q00126C0004000A3Q0006230102009509010004000426012Q0095090100126C00040040022Q00126C00050041022Q00068F0104008E09010005000426012Q008E090100126C0003000A3Q00126C00040042022Q00126C00050080012Q0006C60005009609010004000426012Q0096090100126C0004000A3Q0006ED0003009609010004000426012Q0096090100126C0004000A3Q00126C0005000A3Q0006ED0005009E09010004000426012Q009E09012Q007B000500014Q0041000600033Q00122Q00070043022Q00122Q00080044025Q00060008000200122Q00070045025Q0005000600074Q000500033Q00122Q00060046022Q00122Q00070047025Q000500076Q00055Q00044Q009E0901000426012Q00960901000426012Q006E0D01000426012Q008E0901000426012Q006E0D0100126C00020048022Q00126C00030049022Q00068F0103000C0A010002000426012Q000C0A012Q007B000200024Q004B010300033Q00122Q0004004A022Q00122Q0005004B025Q0003000500024Q00020002000300202Q00020002002D4Q00020002000200062Q0002000C0A013Q000426012Q000C0A012Q007B000200024Q004B010300033Q00122Q0004004C022Q00122Q0005004D025Q0003000500024Q00020002000300202Q0002000200894Q00020002000200062Q0002000C0A013Q000426012Q000C0A012Q007B000200024Q0014000300033Q00122Q0004004E022Q00122Q0005004F025Q0003000500024Q00020002000300202Q00020002008C00122Q0004008D6Q00020004000200122Q0003000A3Q00062Q0002000C0A010003000426012Q000C0A012Q007B00025Q00126C00040088013Q00400102000200042Q00720002000200020006570102000C0A013Q000426012Q000C0A0100126C00020050022Q00126C00030050022Q0006ED0002006E0D010003000426012Q006E0D0100126C00020051022Q00126C00030052022Q0006C60002006E0D010003000426012Q006E0D012Q007B000200013Q0020080002000200044Q000300023Q00122Q00040053025Q0003000300044Q000400066Q00020006000200062Q0002006E0D013Q000426012Q006E0D0100126C0002000A3Q00126C00030080012Q00126C00040054022Q0006C6000400EE09010003000426012Q00EE090100126C0003000A3Q0006ED000200EE09010003000426012Q00EE090100126C0003000A3Q00126C00040055022Q00126C00050055022Q0006ED000400F609010005000426012Q00F6090100126C0004000A3Q0006ED000300F609010004000426012Q00F609012Q007B000400014Q0041000500033Q00122Q00060056022Q00122Q00070057025Q00050007000200122Q00060058025Q0004000500064Q000400033Q00122Q00050059022Q00122Q0006005A025Q000400066Q00045Q00044Q00F60901000426012Q00EE0901000426012Q006E0D012Q007B000200024Q004B010300033Q00122Q0004005B022Q00122Q0005005C025Q0003000500024Q00020002000300202Q00020002002D4Q00020002000200062Q000200320A013Q000426012Q00320A012Q007B000200024Q004B010300033Q00122Q0004005D022Q00122Q0005005E025Q0003000500024Q00020002000300202Q0002000200894Q00020002000200062Q000200320A013Q000426012Q00320A012Q007B000200024Q0014000300033Q00122Q0004005F022Q00122Q00050060025Q0003000500024Q00020002000300202Q00020002008C00122Q0004008D6Q00020004000200122Q0003000A3Q00062Q000200320A010003000426012Q00320A012Q007B00025Q00126C00040088013Q00400102000200042Q007200020002000200067C000200360A010001000426012Q00360A0100126C00020061022Q00126C00030062022Q0006ED0002007A0A010003000426012Q007A0A012Q007B000200013Q0020E50002000200044Q000300023Q00122Q00040063025Q0003000300044Q000400066Q00020006000200062Q000200430A010001000426012Q00430A0100126C00020064022Q00126C00030065022Q00068F0102006E0D010003000426012Q006E0D0100126C0002000A4Q003A000300033Q00126C00040066022Q00126C00050067022Q00068F0104004C0A010005000426012Q004C0A0100126C0004000A3Q000623010200500A010004000426012Q00500A0100126C00040068022Q00126C0005008F3Q0006ED000400450A010005000426012Q00450A0100126C0003000A3Q00126C00040069022Q00126C0005006A022Q00068F010400510A010005000426012Q00510A0100126C0004000A3Q0006230103005C0A010004000426012Q005C0A0100126C0004006B022Q00126C0005006C022Q0006ED000400510A010005000426012Q00510A0100126C0004000A3Q00126C0005006D022Q00126C00060061022Q00068F0105005D0A010006000426012Q005D0A0100126C0005000A3Q0006ED0004005D0A010005000426012Q005D0A0100126C0005000A3Q00126C0006000A3Q0006ED000500650A010006000426012Q00650A012Q007B000600014Q0041000700033Q00122Q0008006E022Q00122Q0009006F025Q00070009000200122Q00080070025Q0006000700084Q000600033Q00122Q00070071022Q00122Q00080072025Q000600086Q00065Q00044Q00650A01000426012Q005D0A01000426012Q00510A01000426012Q006E0D01000426012Q00450A01000426012Q006E0D012Q007B000200024Q004B010300033Q00122Q00040073022Q00122Q00050074025Q0003000500024Q00020002000300202Q00020002002D4Q00020002000200062Q000200EA0A013Q000426012Q00EA0A012Q007B000200024Q004B010300033Q00122Q00040075022Q00122Q00050076025Q0003000500024Q00020002000300202Q0002000200894Q00020002000200062Q000200EA0A013Q000426012Q00EA0A012Q007B000200024Q0014000300033Q00122Q00040077022Q00122Q00050078025Q0003000500024Q00020002000300202Q00020002008C00122Q0004008D6Q00020004000200122Q0003000A3Q00062Q000200EA0A010003000426012Q00EA0A012Q007B00025Q00126C00040088013Q00400102000200042Q0072000200020002000657010200EA0A013Q000426012Q00EA0A012Q007B000200013Q0020E50002000200044Q000300023Q00122Q00040079025Q0003000300044Q000400066Q00020006000200062Q000200AD0A010001000426012Q00AD0A0100126C0002007A022Q00126C0003007B022Q0006C60002006E0D010003000426012Q006E0D0100126C0002000A4Q003A000300033Q00126C0004007C022Q00126C0005007D022Q0006C6000500AF0A010004000426012Q00AF0A0100126C0004000A3Q0006ED000200AF0A010004000426012Q00AF0A0100126C0003000A3Q00126C0004000A3Q000623010300C20A010004000426012Q00C20A0100126C0004007E022Q00126C0005007F022Q000638010400C20A010005000426012Q00C20A0100126C00040080022Q00126C00050081022Q0006C6000500B70A010004000426012Q00B70A0100126C0004000A4Q003A000500053Q00126C00060082022Q00126C00070083022Q00068F010700C40A010006000426012Q00C40A0100126C0006000A3Q0006ED000400C40A010006000426012Q00C40A0100126C0005000A3Q00126C0006000A3Q000623010500D70A010006000426012Q00D70A0100126C00060084022Q00126C00070085022Q0006920107000500010006000426012Q00D70A0100126C00060086022Q00126C000700EF3Q00068F010600CC0A010007000426012Q00CC0A012Q007B000600014Q0041000700033Q00122Q00080087022Q00122Q00090088025Q00070009000200122Q00080089025Q0006000700084Q000600033Q00122Q0007008A022Q00122Q0008008B025Q000600086Q00065Q00044Q00CC0A01000426012Q00B70A01000426012Q00C40A01000426012Q00B70A01000426012Q006E0D01000426012Q00AF0A01000426012Q006E0D012Q007B000200024Q004B010300033Q00122Q0004008C022Q00122Q0005008D025Q0003000500024Q00020002000300202Q00020002002D4Q00020002000200062Q000200470B013Q000426012Q00470B012Q007B000200024Q004B010300033Q00122Q0004008E022Q00122Q0005008F025Q0003000500024Q00020002000300202Q0002000200894Q00020002000200062Q000200470B013Q000426012Q00470B012Q007B000200024Q0014000300033Q00122Q00040090022Q00122Q00050091025Q0003000500024Q00020002000300202Q00020002008C00122Q0004008D6Q00020004000200122Q0003000A3Q00062Q000200470B010003000426012Q00470B012Q007B00025Q00126C00040088013Q00400102000200042Q0072000200020002000657010200470B013Q000426012Q00470B0100126C00020092022Q00126C00030093022Q00068F0103006E0D010002000426012Q006E0D012Q007B000200013Q0020080002000200044Q000300023Q00122Q00040094025Q0003000300044Q000400066Q00020006000200062Q0002006E0D013Q000426012Q006E0D0100126C0002000A4Q003A000300033Q00126C00040095022Q00126C00050095022Q0006ED000400260B010005000426012Q00260B0100126C0004000A3Q0006230102002A0B010004000426012Q002A0B0100126C00040096022Q00126C00050097022Q0006C60004001F0B010005000426012Q001F0B0100126C0003000A3Q00126C0004000A3Q000623010300320B010004000426012Q00320B0100126C00040098022Q00126C00050099022Q0006ED0004002B0B010005000426012Q002B0B0100126C0004000A3Q00126C0005000A3Q0006ED000400330B010005000426012Q00330B012Q007B000500014Q0041000600033Q00122Q0007009A022Q00122Q0008009B025Q00060008000200122Q0007009C025Q0005000600074Q000500033Q00122Q0006009D022Q00122Q0007009E025Q000500076Q00055Q00044Q00330B01000426012Q002B0B01000426012Q006E0D01000426012Q001F0B01000426012Q006E0D012Q007B000200024Q004B010300033Q00122Q0004009F022Q00122Q000500A0025Q0003000500024Q00020002000300202Q00020002002D4Q00020002000200062Q0002006D0B013Q000426012Q006D0B012Q007B000200024Q004B010300033Q00122Q000400A1022Q00122Q000500A2025Q0003000500024Q00020002000300202Q0002000200894Q00020002000200062Q0002006D0B013Q000426012Q006D0B012Q007B000200024Q0014000300033Q00122Q000400A3022Q00122Q000500A4025Q0003000500024Q00020002000300202Q00020002008C00122Q0004008D6Q00020004000200122Q0003000A3Q00062Q0002006D0B010003000426012Q006D0B012Q007B00025Q00126C00040088013Q00400102000200042Q007200020002000200067C000200750B010001000426012Q00750B0100126C000200A5022Q00126C000300A6022Q0006920102000500010003000426012Q00750B0100126C000200A7022Q00126C000300A8022Q0006ED000200AC0B010003000426012Q00AC0B0100126C000200A9022Q00126C000300A9022Q0006ED0002006E0D010003000426012Q006E0D012Q007B000200013Q0020E50002000200044Q000300023Q00122Q000400AA025Q0003000300044Q000400066Q00020006000200062Q000200860B010001000426012Q00860B0100126C000200AB022Q00126C000300AC022Q0006C60003006E0D010002000426012Q006E0D0100126C0002000A4Q003A000300033Q00126C000400AD022Q00126C000500AE022Q00068F0105008F0B010004000426012Q008F0B0100126C0004000A3Q000623010200930B010004000426012Q00930B0100126C000400AF022Q00126C000500B0022Q0006ED000400880B010005000426012Q00880B0100126C0003000A3Q00126C0004000A3Q0006ED000400940B010003000426012Q00940B0100126C0004000A3Q00126C0005000A3Q0006ED000500980B010004000426012Q00980B012Q007B000500014Q0041000600033Q00122Q000700B1022Q00122Q000800B2025Q00060008000200122Q000700B3025Q0005000600074Q000500033Q00122Q000600B4022Q00122Q000700B5025Q000500076Q00055Q00044Q00980B01000426012Q00940B01000426012Q006E0D01000426012Q00880B01000426012Q006E0D012Q007B000200024Q004B010300033Q00122Q000400B6022Q00122Q000500B7025Q0003000500024Q00020002000300202Q00020002002D4Q00020002000200062Q000200D20B013Q000426012Q00D20B012Q007B000200024Q004B010300033Q00122Q000400B8022Q00122Q000500B9025Q0003000500024Q00020002000300202Q0002000200894Q00020002000200062Q000200D20B013Q000426012Q00D20B012Q007B000200024Q0014000300033Q00122Q000400BA022Q00122Q000500BB025Q0003000500024Q00020002000300202Q00020002008C00122Q0004008D6Q00020004000200122Q0003000A3Q00062Q000200D20B010003000426012Q00D20B012Q007B00025Q00126C00040088013Q00400102000200042Q007200020002000200067C000200DA0B010001000426012Q00DA0B0100126C000200BC022Q00126C000300BD022Q000623010200DA0B010003000426012Q00DA0B0100126C000200BE022Q00126C000300BF022Q0006ED000200220C010003000426012Q00220C012Q007B000200013Q0020E50002000200044Q000300023Q00122Q000400C0025Q0003000300044Q000400066Q00020006000200062Q000200E70B010001000426012Q00E70B0100126C000200C1022Q00126C000300C2022Q0006C60003006E0D010002000426012Q006E0D0100126C0002000A4Q003A000300033Q00126C000400C3022Q00126C000500C4022Q00068F010400E90B010005000426012Q00E90B0100126C000400C5022Q00126C000500C6022Q0006C6000500E90B010004000426012Q00E90B0100126C0004000A3Q0006ED000200E90B010004000426012Q00E90B0100126C0003000A3Q00126C000400C7022Q00126C00050082022Q0006C6000500F50B010004000426012Q00F50B0100126C0004000A3Q0006ED000300F50B010004000426012Q00F50B0100126C0004000A3Q00126C0005000A3Q000623010400040C010005000426012Q00040C0100126C000500C8022Q00126C00060027022Q0006C6000500FD0B010006000426012Q00FD0B0100126C0005000A3Q00126C000600C9022Q00126C0007002C012Q0006C6000600050C010007000426012Q00050C0100126C0006000A3Q000623010500100C010006000426012Q00100C0100126C000600CA022Q00126C000700CB022Q00068F010600050C010007000426012Q00050C012Q007B000600014Q0041000700033Q00122Q000800CC022Q00122Q000900CD025Q00070009000200122Q000800CE025Q0006000700084Q000600033Q00122Q000700CF022Q00122Q000800D0025Q000600086Q00065Q00044Q00050C01000426012Q00FD0B01000426012Q00F50B01000426012Q006E0D01000426012Q00E90B01000426012Q006E0D0100126C000200D1022Q00126C000300D2022Q0006C60002006E0D010003000426012Q006E0D0100126C000200D3022Q00126C000300D4022Q00068F0103006E0D010002000426012Q006E0D012Q007B000200024Q004B010300033Q00122Q000400D5022Q00122Q000500D6025Q0003000500024Q00020002000300202Q00020002002D4Q00020002000200062Q0002004F0C013Q000426012Q004F0C012Q007B000200024Q004B010300033Q00122Q000400D7022Q00122Q000500D8025Q0003000500024Q00020002000300202Q0002000200894Q00020002000200062Q0002002D0D013Q000426012Q002D0D012Q007B000200024Q0098000300033Q00122Q000400D9022Q00122Q000500DA025Q0003000500024Q00020002000300202Q00020002008C4Q00020002000200122Q0003000A3Q00062Q0003002D0D010002000426012Q002D0D012Q007B00025Q00126C00040088013Q00400102000200042Q00720002000200020006570102002D0D013Q000426012Q002D0D012Q007B000200024Q004B010300033Q00122Q000400DB022Q00122Q000500DC025Q0003000500024Q00020002000300202Q00020002002D4Q00020002000200062Q000200740C013Q000426012Q00740C012Q007B000200024Q004B010300033Q00122Q000400DD022Q00122Q000500DE025Q0003000500024Q00020002000300202Q0002000200894Q00020002000200062Q0002002D0D013Q000426012Q002D0D012Q007B000200024Q0098000300033Q00122Q000400DF022Q00122Q000500E0025Q0003000500024Q00020002000300202Q00020002008C4Q00020002000200122Q0003000A3Q00062Q0003002D0D010002000426012Q002D0D012Q007B00025Q00126C00040088013Q00400102000200042Q00720002000200020006570102002D0D013Q000426012Q002D0D012Q007B000200024Q004B010300033Q00122Q000400E1022Q00122Q000500E2025Q0003000500024Q00020002000300202Q00020002002D4Q00020002000200062Q000200990C013Q000426012Q00990C012Q007B000200024Q004B010300033Q00122Q000400E3022Q00122Q000500E4025Q0003000500024Q00020002000300202Q0002000200894Q00020002000200062Q0002002D0D013Q000426012Q002D0D012Q007B000200024Q0098000300033Q00122Q000400E5022Q00122Q000500E6025Q0003000500024Q00020002000300202Q00020002008C4Q00020002000200122Q0003000A3Q00062Q0003002D0D010002000426012Q002D0D012Q007B00025Q00126C00040088013Q00400102000200042Q00720002000200020006570102002D0D013Q000426012Q002D0D012Q007B000200024Q004B010300033Q00122Q000400E7022Q00122Q000500E8025Q0003000500024Q00020002000300202Q00020002002D4Q00020002000200062Q000200BE0C013Q000426012Q00BE0C012Q007B000200024Q004B010300033Q00122Q000400E9022Q00122Q000500EA025Q0003000500024Q00020002000300202Q0002000200894Q00020002000200062Q0002002D0D013Q000426012Q002D0D012Q007B000200024Q0098000300033Q00122Q000400EB022Q00122Q000500EC025Q0003000500024Q00020002000300202Q00020002008C4Q00020002000200122Q0003000A3Q00062Q0003002D0D010002000426012Q002D0D012Q007B00025Q00126C00040088013Q00400102000200042Q00720002000200020006570102002D0D013Q000426012Q002D0D012Q007B000200024Q004B010300033Q00122Q000400ED022Q00122Q000500EE025Q0003000500024Q00020002000300202Q00020002002D4Q00020002000200062Q000200E30C013Q000426012Q00E30C012Q007B000200024Q004B010300033Q00122Q000400EF022Q00122Q000500F0025Q0003000500024Q00020002000300202Q0002000200894Q00020002000200062Q0002002D0D013Q000426012Q002D0D012Q007B000200024Q0098000300033Q00122Q000400F1022Q00122Q000500F2025Q0003000500024Q00020002000300202Q00020002008C4Q00020002000200122Q0003000A3Q00062Q0003002D0D010002000426012Q002D0D012Q007B00025Q00126C00040088013Q00400102000200042Q00720002000200020006570102002D0D013Q000426012Q002D0D012Q007B000200024Q004B010300033Q00122Q000400F3022Q00122Q000500F4025Q0003000500024Q00020002000300202Q00020002002D4Q00020002000200062Q000200080D013Q000426012Q00080D012Q007B000200024Q004B010300033Q00122Q000400F5022Q00122Q000500F6025Q0003000500024Q00020002000300202Q0002000200894Q00020002000200062Q0002002D0D013Q000426012Q002D0D012Q007B000200024Q0098000300033Q00122Q000400F7022Q00122Q000500F8025Q0003000500024Q00020002000300202Q00020002008C4Q00020002000200122Q0003000A3Q00062Q0003002D0D010002000426012Q002D0D012Q007B00025Q00126C00040088013Q00400102000200042Q00720002000200020006570102002D0D013Q000426012Q002D0D012Q007B000200024Q004B010300033Q00122Q000400F9022Q00122Q000500FA025Q0003000500024Q00020002000300202Q00020002002D4Q00020002000200062Q0002006E0D013Q000426012Q006E0D012Q007B000200024Q004B010300033Q00122Q000400FB022Q00122Q000500FC025Q0003000500024Q00020002000300202Q0002000200894Q00020002000200062Q0002002D0D013Q000426012Q002D0D012Q007B000200024Q0098000300033Q00122Q000400FD022Q00122Q000500FE025Q0003000500024Q00020002000300202Q00020002008C4Q00020002000200122Q0003000A3Q00062Q0003002D0D010002000426012Q002D0D012Q007B00025Q00126C00040088013Q00400102000200042Q007200020002000200067C0002006E0D010001000426012Q006E0D012Q007B0002002C3Q0006570102006E0D013Q000426012Q006E0D0100126C0002000A4Q003A000300033Q00126C0004000A3Q0006ED000200320D010004000426012Q00320D0100126C0003000A3Q00126C000400FF022Q00126C00052Q00032Q0006C6000500360D010004000426012Q00360D0100126C0004000A3Q0006ED000300360D010004000426012Q00360D010012B9000400554Q00B5010500033Q00122Q00060001032Q00122Q00070002035Q0005000700024Q00040004000500122Q0005003A3Q00122Q000600556Q000700033Q00122Q0008002Q032Q00122Q00090004035Q0007000900024Q00060006000700122Q0007003A6Q0006000600074Q000600066Q0004000500064Q000400013Q00202Q00040004006F4Q000500033Q00122Q00060005032Q00122Q00070006035Q00050007000200122Q000600556Q000700033Q00122Q00080007032Q00122Q00090008035Q0007000900024Q00060006000700122Q0007003A6Q00060006000700062Q000600640D013Q000426012Q00640D012Q007B000600033Q00126C00070009032Q00126C0008000A033Q00A801060008000200067C000600680D010001000426012Q00680D012Q007B000600033Q00126C0007000B032Q00126C0008000C033Q00A80106000800022Q001C0105000500062Q00A2010400020001000426012Q006E0D01000426012Q00360D01000426012Q006E0D01000426012Q00320D012Q007B000200053Q0012CB0003000D035Q0002000200034Q000300023Q00122Q00040022015Q0003000300044Q0004002D3Q00122Q0005001D015Q00068Q00020006000200062Q000200B60D013Q000426012Q00B60D012Q007B000200013Q0020210102000200044Q000300023Q00122Q00040022015Q0003000300044Q00020002000200062Q000200B60D013Q000426012Q00B60D0100126C0002000A4Q003A000300033Q00126C0004000E032Q00126C0005000F032Q0006C6000400840D010005000426012Q00840D0100126C00040010032Q00126C00050011032Q0006C6000500840D010004000426012Q00840D0100126C0004000A3Q0006ED000200840D010004000426012Q00840D0100126C0003000A3Q00126C0004000A3Q0006ED000400900D010003000426012Q00900D0100126C0004000A4Q003A000500053Q00126C00060012032Q00126C00070013032Q00068F010700950D010006000426012Q00950D0100126C0006000A3Q0006ED000400950D010006000426012Q00950D0100126C0005000A3Q00126C0006000A3Q000623010600A40D010005000426012Q00A40D0100126C00060025012Q00126C00070012032Q0006C60007009D0D010006000426012Q009D0D012Q007B000600014Q0041000700033Q00122Q00080014032Q00122Q00090015035Q00070009000200122Q0008002F015Q0006000700084Q000600033Q00122Q00070016032Q00122Q00080017035Q000600086Q00065Q00044Q009D0D01000426012Q00900D01000426012Q00950D01000426012Q00900D01000426012Q00B60D01000426012Q00840D012Q0090010200024Q0024010300036Q000400026Q000500033Q00122Q00060018032Q00122Q00070019035Q0005000700024Q0004000400050002B1000500023Q00126C000600264Q007D0003000300012Q0090010400034Q0015010500026Q000600033Q00122Q0007001A032Q00122Q0008001B035Q0006000800024Q00050005000600066501060003000100012Q007B3Q00043Q00126C000700294Q007D0004000300012Q007D00020002000100126C0003009B3Q00126C0004001C032Q00068F010300120E010004000426012Q00120E012Q007B00035Q0020F40003000300014Q000500173Q00122Q0006001D035Q000500066Q00033Q000200062Q000300120E013Q000426012Q00120E012Q007B000300013Q0020340003000300044Q000400023Q00202Q0004000400054Q000500076Q00030007000200062Q000300120E013Q000426012Q00120E0100126C0003000A4Q003A000400043Q00126C0005006D3Q00126C0006006D3Q0006ED000500E30D010006000426012Q00E30D0100126C0005000A3Q000623010300EE0D010005000426012Q00EE0D0100126C0005001E032Q00126C0006001F032Q0006ED000500E30D010006000426012Q00E30D0100126C0004000A3Q00126C0005000A3Q000623010500FA0D010004000426012Q00FA0D0100126C00050020032Q00126C00060021032Q000638010600FA0D010005000426012Q00FA0D0100126C00050022032Q00126C00060023032Q0006C6000600EF0D010005000426012Q00EF0D0100126C0005000A3Q00126C0006000A3Q000623010500020E010006000426012Q00020E0100126C00060024032Q00126C00070025032Q0006C6000600FB0D010007000426012Q00FB0D012Q007B000600014Q0041000700033Q00122Q00080026032Q00122Q00090027035Q00070009000200122Q00080028035Q0006000700084Q000600033Q00122Q00070029032Q00122Q0008002A035Q000600086Q00065Q00044Q00FB0D01000426012Q00EF0D01000426012Q00120E01000426012Q00E30D012Q007B000300083Q0012560104002B035Q0003000300044Q0003000100024Q000300156Q000300153Q00062Q0003001C0E013Q000426012Q001C0E012Q007B000300154Q0030000300024Q007B000300083Q00126C0004008A013Q00040003000300042Q00C80003000100024Q000300153Q00122Q0003002C032Q00122Q0004002D032Q00062Q0004002A0E010003000426012Q002A0E012Q007B000300153Q0006570103002A0E013Q000426012Q002A0E012Q007B000300154Q0030000300024Q007B000300083Q00126C0004002E033Q00040003000300042Q00C80003000100024Q000300153Q00122Q0003002F032Q00122Q00040030032Q00062Q000400360E010003000426012Q00360E012Q007B000300153Q00067C0003003A0E010001000426012Q003A0E0100126C00030031032Q00126C00040032032Q0006ED0003003C0E010004000426012Q003C0E012Q007B000300154Q0030000300023Q00126C00030033032Q00126C00040034032Q0006C6000300850E010004000426012Q00850E012Q007B00035Q00121E00050035035Q0003000300054Q0003000200024Q0004002E6Q000500033Q00122Q00060036032Q00122Q00070037035Q0005000700024Q0004000400054Q000500033Q00122Q00060038032Q00122Q00070039035Q0005000700024Q00040004000500062Q000300850E010004000426012Q00850E012Q007B0003001E4Q00FE000400033Q00122Q0005003A032Q00122Q0006003B035Q0004000600024Q00030003000400122Q0005003C035Q0003000300054Q00030002000200062Q000300850E013Q000426012Q00850E012Q007B0003001E4Q00D0000400033Q00122Q0005003D032Q00122Q0006003E035Q0004000600024Q00030003000400202Q00030003008C4Q00030002000200122Q0004000A3Q00062Q000300850E010004000426012Q00850E012Q007B000300013Q0020080003000300044Q0004001E3Q00122Q0005003F035Q0004000400054Q000500056Q00030005000200062Q000300850E013Q000426012Q00850E0100126C0003000A3Q00126C00040040032Q00126C00050041032Q0006C6000400710E010005000426012Q00710E0100126C0004000A3Q0006ED000300710E010004000426012Q00710E012Q007B000400014Q0041000500033Q00122Q00060042032Q00122Q00070043035Q00050007000200122Q00060044035Q0004000500064Q000400033Q00122Q00050045032Q00122Q00060046035Q000400066Q00045Q00044Q00710E0100126C00030047032Q00126C00040048032Q0006C6000400D20E010003000426012Q00D20E012Q007B00035Q00121E00050035035Q0003000300054Q0003000200024Q0004002E6Q000500033Q00122Q00060049032Q00122Q0007004A035Q0005000700024Q0004000400054Q000500033Q00122Q0006004B032Q00122Q0007004C035Q0005000700024Q00040004000500062Q000300D20E010004000426012Q00D20E012Q007B0003001E4Q00FE000400033Q00122Q0005004D032Q00122Q0006004E035Q0004000600024Q00030003000400122Q0005003C035Q0003000300054Q00030002000200062Q000300D20E013Q000426012Q00D20E012Q007B0003001E4Q00D0000400033Q00122Q0005004F032Q00122Q00060050035Q0004000600024Q00030003000400202Q00030003008C4Q00030002000200122Q0004000A3Q00062Q000300D20E010004000426012Q00D20E0100126C00030051032Q00126C00040052032Q0006C6000400D20E010003000426012Q00D20E0100126C00030053032Q00126C00040054032Q00068F010300D20E010004000426012Q00D20E012Q007B000300013Q0020080003000300044Q0004001E3Q00122Q00050055035Q0004000400054Q000500056Q00030005000200062Q000300D20E013Q000426012Q00D20E0100126C0003000A3Q00126C0004000A3Q0006ED000300C20E010004000426012Q00C20E012Q007B000400014Q0041000500033Q00122Q00060056032Q00122Q00070057035Q00050007000200122Q00060058035Q0004000500064Q000400033Q00122Q00050059032Q00122Q0006005A035Q000400066Q00045Q00044Q00C20E012Q007B00035Q00121E00050035035Q0003000300054Q0003000200024Q0004002E6Q000500033Q00122Q0006005B032Q00122Q0007005C035Q0005000700024Q0004000400054Q000500033Q00122Q0006005D032Q00122Q0007005E035Q0005000700024Q00040004000500062Q000300F90E010004000426012Q00F90E012Q007B0003001E4Q00FE000400033Q00122Q0005005F032Q00122Q00060060035Q0004000600024Q00030003000400122Q0005003C035Q0003000300054Q00030002000200062Q000300F90E013Q000426012Q00F90E012Q007B0003001E4Q0062010400033Q00122Q00050061032Q00122Q00060062035Q0004000600024Q00030003000400202Q00030003008C4Q00030002000200122Q0004000A3Q00062Q0003000500010004000426012Q00FD0E0100126C00030063032Q00126C00040064032Q0006C6000300370F010004000426012Q00370F0100126C0003005A3Q00126C00040065032Q0006C6000400370F010003000426012Q00370F012Q007B000300013Q0020080003000300044Q0004001E3Q00122Q00050066035Q0004000400054Q000500056Q00030005000200062Q000300370F013Q000426012Q00370F0100126C0003000A4Q003A000400043Q00126C00050067032Q00126C00060068032Q0006C60006000C0F010005000426012Q000C0F0100126C0005000A3Q000623010300170F010005000426012Q00170F0100126C00050069032Q00126C0006006A032Q0006ED0005000C0F010006000426012Q000C0F0100126C0004000A3Q00126C0005006B032Q00126C0006006C032Q00068F010600180F010005000426012Q00180F0100126C0005000A3Q0006ED000400180F010005000426012Q00180F0100126C0005000A3Q00126C0006006D032Q00126C0007006E032Q0006C6000700200F010006000426012Q00200F0100126C0006000A3Q0006ED000500200F010006000426012Q00200F012Q007B000600014Q0041000700033Q00122Q0008006F032Q00122Q00090070035Q00070009000200122Q00080071035Q0006000700084Q000600033Q00122Q00070072032Q00122Q00080073035Q000600086Q00065Q00044Q00200F01000426012Q00180F01000426012Q00370F01000426012Q000C0F0100126C00030074032Q00126C00040075032Q00068F0103009C0F010004000426012Q009C0F012Q007B00035Q00121E00050035035Q0003000300054Q0003000200024Q0004002E6Q000500033Q00122Q00060076032Q00122Q00070077035Q0005000700024Q0004000400054Q000500033Q00122Q00060078032Q00122Q00070079035Q0005000700024Q00040004000500062Q0003009C0F010004000426012Q009C0F012Q007B0003001E4Q00FE000400033Q00122Q0005007A032Q00122Q0006007B035Q0004000600024Q00030003000400122Q0005003C035Q0003000300054Q00030002000200062Q0003009C0F013Q000426012Q009C0F012Q007B0003001E4Q00D0000400033Q00122Q0005007C032Q00122Q0006007D035Q0004000600024Q00030003000400202Q00030003008C4Q00030002000200122Q0004000A3Q00062Q0003009C0F010004000426012Q009C0F012Q007B000300013Q0020E50003000300044Q0004001E3Q00122Q0005007E035Q0004000400054Q000500056Q00030005000200062Q000300730F010001000426012Q00730F0100126C0003007F032Q00126C00040080032Q0006920103000500010004000426012Q00730F0100126C00030081032Q00126C00040082032Q00068F0103009C0F010004000426012Q009C0F0100126C0003000A4Q003A000400043Q00126C00050083032Q00126C00060084032Q00068F010600750F010005000426012Q00750F0100126C0005000A3Q0006ED000300750F010005000426012Q00750F0100126C0004000A3Q00126C00050085032Q00126C00060086032Q0006C60006007D0F010005000426012Q007D0F0100126C0005000A3Q0006ED0004007D0F010005000426012Q007D0F0100126C0005000A3Q00126C00060087032Q00126C00070088032Q0006C6000700850F010006000426012Q00850F0100126C0006000A3Q0006ED000500850F010006000426012Q00850F012Q007B000600014Q0041000700033Q00122Q00080089032Q00122Q0009008A035Q00070009000200122Q0008008B035Q0006000700084Q000600033Q00122Q0007008C032Q00122Q0008008D035Q000600086Q00065Q00044Q00850F01000426012Q007D0F01000426012Q009C0F01000426012Q00750F0100126C0003008E032Q00126C0004008F032Q0006C60003000110010004000426012Q000110012Q007B00035Q00121E00050035035Q0003000300054Q0003000200024Q0004002E6Q000500033Q00122Q00060090032Q00122Q00070091035Q0005000700024Q0004000400054Q000500033Q00122Q00060092032Q00122Q00070093035Q0005000700024Q00040004000500062Q0003000110010004000426012Q000110012Q007B0003001E4Q00FE000400033Q00122Q00050094032Q00122Q00060095035Q0004000600024Q00030003000400122Q0005003C035Q0003000300054Q00030002000200062Q0003000110013Q000426012Q000110012Q007B0003001E4Q00D0000400033Q00122Q00050096032Q00122Q00060097035Q0004000600024Q00030003000400202Q00030003008C4Q00030002000200122Q0004000A3Q00062Q0003000110010004000426012Q0001100100126C00030098032Q00126C00040099032Q00068F010400D40F010003000426012Q00D40F012Q007B000300013Q0020E50003000300044Q0004001E3Q00122Q0005009A035Q0004000400054Q000500056Q00030005000200062Q000300D80F010001000426012Q00D80F0100126C0003009B032Q00126C0004009C032Q00068F0103000110010004000426012Q0001100100126C0003000A4Q003A000400043Q00126C0005000A3Q000623010300E10F010005000426012Q00E10F0100126C0005009D032Q00126C0006009E032Q0006C6000600DA0F010005000426012Q00DA0F0100126C0004000A3Q00126C0005009F032Q00126C000600A0032Q0006C6000600E20F010005000426012Q00E20F0100126C000500A1032Q00126C000600A2032Q0006C6000500E20F010006000426012Q00E20F0100126C0005000A3Q0006ED000400E20F010005000426012Q00E20F0100126C0005000A3Q00126C0006000A3Q0006ED000500EE0F010006000426012Q00EE0F012Q007B000600014Q0041000700033Q00122Q000800A3032Q00122Q000900A4035Q00070009000200122Q0008008B035Q0006000700084Q000600033Q00122Q000700A5032Q00122Q000800A6035Q000600086Q00065Q00044Q00EE0F01000426012Q00E20F01000426012Q00011001000426012Q00DA0F0100126C000300A7032Q00126C000400A8032Q00068F0104006D10010003000426012Q006D10012Q007B00035Q00121E00050035035Q0003000300054Q0003000200024Q0004002E6Q000500033Q00122Q000600A9032Q00122Q000700AA035Q0005000700024Q0004000400054Q000500033Q00122Q000600AB032Q00122Q000700AC035Q0005000700024Q00040004000500062Q0003006D10010004000426012Q006D10012Q007B0003001E4Q00FE000400033Q00122Q000500AD032Q00122Q000600AE035Q0004000600024Q00030003000400122Q0005003C035Q0003000300054Q00030002000200062Q0003006D10013Q000426012Q006D10012Q007B0003001E4Q00D0000400033Q00122Q000500AF032Q00122Q000600B0035Q0004000600024Q00030003000400202Q00030003008C4Q00030002000200122Q0004000A3Q00062Q0003006D10010004000426012Q006D10012Q007B000300013Q0020E50003000300044Q0004001E3Q00122Q000500B1035Q0004000400054Q000500056Q00030005000200062Q0003003910010001000426012Q0039100100126C000300B2032Q00126C000400B3032Q0006C60003006D10010004000426012Q006D100100126C0003000A4Q003A000400043Q00126C0005000A3Q0006ED0003003B10010005000426012Q003B100100126C0004000A3Q00126C000500B4032Q00126C000600B5032Q00068F0106003F10010005000426012Q003F100100126C0005000A3Q0006ED0004003F10010005000426012Q003F100100126C0005000A4Q003A000600063Q00126C0007000A3Q0006230105005310010007000426012Q0053100100126C00070012022Q00126C000800B6032Q0006230107005310010008000426012Q0053100100126C000700B7032Q00126C000800B8032Q0006C60008004810010007000426012Q0048100100126C0006000A3Q00126C0007000A3Q0006230106005B10010007000426012Q005B100100126C000700B9032Q00126C000800BA032Q00068F0108005410010007000426012Q005410012Q007B000700014Q0041000800033Q00122Q000900BB032Q00122Q000A00BC035Q0008000A000200122Q0009008B035Q0007000800094Q000700033Q00122Q000800BD032Q00122Q000900BE035Q000700096Q00075Q00044Q00541001000426012Q003F1001000426012Q00481001000426012Q003F1001000426012Q006D1001000426012Q003B10010012B9000300BF033Q00C3000400033Q00122Q000500C0032Q00122Q000600C1035Q000400066Q00033Q000200062Q000300D710013Q000426012Q00D710010012B9000300C2032Q00123B010400C3035Q00030003000400122Q000400C4035Q000500033Q00122Q000600C5032Q00122Q000700C6035Q000500076Q00043Q000200122Q000500C7035Q00030005000200062Q000300D710013Q000426012Q00D7100100126C000300C8032Q00126C000400C9032Q0006C6000400D710010003000426012Q00D7100100126C000300CA032Q00126C000400CA032Q0006ED000300D710010004000426012Q00D710012Q007B000300024Q00FE000400033Q00122Q000500CB032Q00122Q000600CC035Q0004000600024Q00030003000400122Q000500CD035Q0003000300054Q00030002000200062Q000300D710013Q000426012Q00D710012Q007B000300244Q006A000400033Q00122Q000500CE032Q00122Q000600CF035Q000400066Q00033Q000200122Q000500D0035Q00030003000500122Q000500D1035Q00030005000200062Q000300D710013Q000426012Q00D7100100126C000300D2032Q00126C000400D3032Q00068F010300D710010004000426012Q00D710012Q007B000300013Q0020080003000300044Q000400023Q00122Q000500D4035Q0004000400054Q000500056Q00030005000200062Q000300D710013Q000426012Q00D7100100126C0003000A4Q003A000400043Q00126C0005000A3Q0006ED000300B010010005000426012Q00B0100100126C0004000A3Q00126C000500D5032Q00126C000600D6032Q0006C6000600B410010005000426012Q00B4100100126C0005000A3Q000623010400BF10010005000426012Q00BF100100126C000500D7032Q00126C000600D8032Q0006ED000500B410010006000426012Q00B4100100126C0005000A3Q00126C0006000A3Q000623010500C710010006000426012Q00C7100100126C000600D9032Q00126C000700DA032Q00068F010600C010010007000426012Q00C010012Q007B000600014Q0041000700033Q00122Q000800DB032Q00122Q000900DC035Q00070009000200122Q000800DD035Q0006000700084Q000600033Q00122Q000700DE032Q00122Q000800DF035Q000600086Q00065Q00044Q00C01001000426012Q00B41001000426012Q00D71001000426012Q00B010012Q007B000300024Q00FE000400033Q00122Q000500E0032Q00122Q000600E1035Q0004000600024Q00030003000400122Q000500CD035Q0003000300054Q00030002000200062Q000300FB10013Q000426012Q00FB10012Q007B000300244Q006A000400033Q00122Q000500E2032Q00122Q000600E3035Q000400066Q00033Q000200122Q000500D0035Q00030003000500122Q00050058035Q00030005000200062Q000300FB10013Q000426012Q00FB10010012B9000300C2032Q00126C000400C3033Q00040003000300040012B9000400C4033Q007E010500033Q00122Q000600E4032Q00122Q000700E5035Q000500076Q00043Q000200126C000500C7033Q00A801030005000200067C000300FF10010001000426012Q00FF100100126C000300E6032Q00126C000400E7032Q00068F0103002E11010004000426012Q002E110100126C000300E8032Q00126C000400E9032Q00068F0103002E11010004000426012Q002E11012Q007B000300013Q0020080003000300044Q000400023Q00122Q000500D4035Q0004000400054Q000500056Q00030005000200062Q0003002E11013Q000426012Q002E110100126C0003000A3Q00126C000400EA032Q00126C000500EB032Q00068F0104000D11010005000426012Q000D110100126C0004000A3Q0006ED0003000D11010004000426012Q000D110100126C0004000A3Q00126C000500EC032Q00126C000600EC032Q0006ED0005001511010006000426012Q0015110100126C000500ED032Q00126C000600EE032Q00068F0105001511010006000426012Q0015110100126C0005000A3Q0006ED0004001511010005000426012Q001511012Q007B000500014Q0041000600033Q00122Q000700EF032Q00122Q000800F0035Q00060008000200122Q000700F1035Q0005000600074Q000500033Q00122Q000600F2032Q00122Q000700F3035Q000500076Q00055Q00044Q00151101000426012Q000D110100126C000300F4032Q00126C000400F5032Q0006C6000400AC11010003000426012Q00AC110100126C000300F6032Q00126C000400F6032Q0006ED000300AC11010004000426012Q00AC11010012B9000300BF033Q00C3000400033Q00122Q000500F7032Q00122Q000600F8035Q000400066Q00033Q000200062Q000300AC11013Q000426012Q00AC11010012B9000300C2032Q00123B010400C3035Q00030003000400122Q000400C4035Q000500033Q00122Q000600F9032Q00122Q000700FA035Q000500076Q00043Q000200122Q000500FB035Q00030005000200062Q000300AC11013Q000426012Q00AC11012Q007B000300024Q00FE000400033Q00122Q000500FC032Q00122Q000600FD035Q0004000600024Q00030003000400122Q000500CD035Q0003000300054Q00030002000200062Q000300AC11013Q000426012Q00AC11012Q007B000300244Q006A000400033Q00122Q000500FE032Q00122Q000600FF035Q000400066Q00033Q000200122Q000500D0035Q00030003000500122Q000500D1035Q00030005000200062Q000300AC11013Q000426012Q00AC11012Q007B000300013Q0020E50003000300044Q000400023Q00122Q00050022015Q0004000400054Q000500056Q00030005000200062Q0003006F11010001000426012Q006F110100126C00032Q00042Q00126C00040001042Q0006ED000300AC11010004000426012Q00AC110100126C0003000A4Q003A000400043Q00126C00050002042Q00126C00060003042Q00068F0106007811010005000426012Q0078110100126C0005000A3Q0006230103007C11010005000426012Q007C110100126C0005002Q042Q00126C00060005042Q0006ED0005007111010006000426012Q0071110100126C0004000A3Q00126C00050006042Q00126C00060007042Q00068F0106007D11010005000426012Q007D110100126C0005000A3Q0006ED0004007D11010005000426012Q007D110100126C0005000A4Q003A000600063Q00126C0007000A3Q0006ED0005008611010007000426012Q0086110100126C0006000A3Q00126C0007000A3Q0006ED0006008A11010007000426012Q008A110100126C0007000A3Q00126C00080008042Q00126C00090009042Q00068F0109008E11010008000426012Q008E110100126C0008000A042Q00126C0009000A042Q0006ED0008008E11010009000426012Q008E110100126C0008000A3Q0006ED0007008E11010008000426012Q008E11012Q007B000800014Q0041000900033Q00122Q000A000B042Q00122Q000B000C045Q0009000B000200122Q000A002F015Q00080009000A4Q000800033Q00122Q0009000D042Q00122Q000A000E045Q0008000A6Q00085Q00044Q008E1101000426012Q008A1101000426012Q007D1101000426012Q00861101000426012Q007D1101000426012Q00AC1101000426012Q007111010012B9000300BF033Q00C3000400033Q00122Q0005000F042Q00122Q00060010045Q000400066Q00033Q000200062Q0003009012013Q000426012Q009012012Q007B000300024Q00FE000400033Q00122Q00050011042Q00122Q00060012045Q0004000600024Q00030003000400122Q0005003C035Q0003000300054Q00030002000200062Q0003009012013Q000426012Q009012012Q007B0003002F3Q00067C0003009012010001000426012Q009012010012B900030013043Q007B000400033Q00126C00050014042Q00126C00060015043Q00A80104000600022Q00C3000500033Q00122Q00060016042Q00122Q00070017045Q000500076Q00033Q000200062Q000300DF11013Q000426012Q00DF11010012B900030018043Q00C3000400033Q00122Q00050019042Q00122Q0006001A045Q000400066Q00033Q000200062Q000300DF11013Q000426012Q00DF11010012B90003001B043Q007E010400033Q00122Q0005001C042Q00122Q0006001D045Q000400066Q00033Q00022Q0077000400013Q0006ED000300E311010004000426012Q00E3110100126C0003001E042Q00126C0004001F042Q0006C60003009012010004000426012Q0090120100126C0003000A3Q00126C0004004B012Q00126C0005003B3Q00046D00030090120100126C0007000A4Q003A0008000E3Q00126C000F000A3Q0006ED000700EF1101000F000426012Q00EF110100126C0008000A4Q003A000900093Q00126C0007003B3Q00126C000F00AD012Q0006ED000F006A12010007000426012Q006A12012Q003A000E000E3Q00126C000F000A3Q000623010F00FA11010008000426012Q00FA110100126C000F0020042Q00126C00100021042Q0006C6000F00F311010010000426012Q00F311010012B9000F0022043Q00E9001000033Q00122Q00110023042Q00122Q00120024045Q0010001200024Q001100066Q000F001100184Q000E00186Q000900176Q000900166Q000900154Q0013010D00144Q00B7000C00136Q000B00126Q000A00116Q000900106Q0009000F3Q00122Q000F0025045Q001000016Q000F0002001100044Q0065120100126C00140026042Q00126C00150027042Q0006C60014006512010015000426012Q006512010006ED001300651201000E000426012Q006512012Q007B0014001B4Q00AD0015000D000C00122Q00160028045Q0014001600024Q0015001C6Q0016000D000C00122Q00170028045Q0015001700024Q00140014001500122Q0015005B6Q0015000100020006C60014006512010015000426012Q0065120100126C00140029042Q00126C0015002A042Q0006C60015006512010014000426012Q006512012Q007B001400013Q0020E50014001400044Q001500023Q00122Q0016002B045Q0015001500164Q001600166Q00140016000200062Q0014003312010001000426012Q0033120100126C0014002C042Q00126C0015002D042Q0006C60015006512010014000426012Q0065120100126C0014000A4Q003A001500153Q00126C0016002E042Q00126C0017002F042Q00068F0117003512010016000426012Q0035120100126C0016000A3Q0006ED0014003512010016000426012Q0035120100126C0015000A3Q00126C0016000A3Q0006230115004412010016000426012Q0044120100126C00160030042Q00126C00170031042Q0006ED0016003D12010017000426012Q003D120100126C0016000A3Q00126C0017000A3Q0006230116004C12010017000426012Q004C120100126C00170032042Q00126C00180033042Q00068F0117004512010018000426012Q0045120100126C0017000A3Q00126C0018000A3Q0006230117005412010018000426012Q0054120100126C00180034042Q00126C00190035042Q0006C60019004D12010018000426012Q004D12012Q007B001800014Q0041001900033Q00122Q001A0036042Q00122Q001B0037045Q0019001B000200122Q001A0038045Q00180019001A4Q001800033Q00122Q00190039042Q00122Q001A003A045Q0018001A6Q00185Q00044Q004D1201000426012Q00451201000426012Q003D1201000426012Q00651201000426012Q00351201000640000F000F12010002000426012Q000F1201000426012Q008F1201000426012Q00F31101000426012Q008F120100126C000F003B042Q00126C0010003C042Q00068F010F008112010010000426012Q0081120100126C000F003D042Q0006ED000F008112010007000426012Q0081120100126C000F000A3Q00126C0010003B3Q0006ED000F007712010010000426012Q0077120100126C000700AD012Q000426012Q0081120100126C0010000A3Q0006230110007E1201000F000426012Q007E120100126C0010003E042Q00126C0011008E032Q00068F0111007212010010000426012Q007212012Q003A000C000D3Q00126C000F003B3Q000426012Q0072120100126C000F003F042Q00126C00100040042Q0006C6001000E91101000F000426012Q00E9110100126C000F003B3Q0006230107008C1201000F000426012Q008C120100126C000F0041042Q00126C00100042042Q00068F011000E91101000F000426012Q00E911012Q003A000A000B3Q00126C0007003D042Q000426012Q00E9110100044C010300E7110100126C00030043042Q00126C00040044042Q00068F0103008815010004000426012Q008815012Q007B00035Q00126C00050088013Q00400103000300052Q007200030002000200067C0003008815010001000426012Q008815012Q007B00035Q00126C00050088013Q00400103000300052Q0072000300020002000657010300A312013Q000426012Q00A3120100126C00030045042Q00067C000300A412010001000426012Q00A4120100126C00030046043Q003A000400044Q009600055Q00122Q00070088015Q0005000500074Q00050002000200062Q000500B312013Q000426012Q00B3120100126C00050047042Q00126C00060048042Q000638010600B312010005000426012Q00B3120100126C00050049042Q00126C0006004A042Q0006ED0005001814010006000426012Q0018140100126C0005004B042Q00126C0006004C042Q0006C60006001D13010005000426012Q001D13012Q007B000500173Q0012830006004D045Q00050002000200202Q00050005002D4Q00050002000200062Q0005001D13013Q000426012Q001D13012Q007B0005002E4Q002D010600033Q00122Q0007004E042Q00122Q0008004F045Q0006000800024Q0005000500064Q000600033Q00122Q00070050042Q00122Q00080051045Q0006000800024Q0005000500064Q000600033Q00122Q00070052042Q00122Q00080053045Q00060008000200062Q0005001D13010006000426012Q001D130100126C0005000A4Q003A000600063Q00126C00070054042Q00126C00080055042Q0006C6000800D112010007000426012Q00D1120100126C0007000A3Q0006ED000500D112010007000426012Q00D1120100126C0006000A3Q00126C0007000A3Q0006ED000600D912010007000426012Q00D912012Q007B00075Q00126C00090056043Q00400107000700092Q007B000900173Q00126C000A004D043Q002D0009000A4Q009C00073Q00022Q0013010400073Q00126C00070057042Q00126C00080058042Q0006C60008001814010007000426012Q0018140100068F010400F312010003000426012Q00F312012Q007B00075Q00121001090059045Q0007000700094Q000900173Q00122Q000A004D045Q0009000A6Q00073Q000200062Q000700F712013Q000426012Q00F7120100126C0007005A042Q00126C0008005B042Q0006C60007001814010008000426012Q0018140100126C0007005C042Q00126C0008005C042Q0006ED0007001814010008000426012Q001814012Q007B000700013Q0020070107000700044Q000800173Q00122Q0009004D045Q000800096Q00073Q000200062Q0007001814013Q000426012Q0018140100126C0007000A3Q00126C0008000A3Q0006230107000B13010008000426012Q000B130100126C0008005D042Q00126C0009005E042Q0006C60008000413010009000426012Q000413012Q007B000800014Q0041000900033Q00122Q000A005F042Q00122Q000B0060045Q0009000B000200122Q000A0061045Q00080009000A4Q000800033Q00122Q00090062042Q00122Q000A0063045Q0008000A6Q00085Q00044Q00041301000426012Q00181401000426012Q00D91201000426012Q00181401000426012Q00D11201000426012Q0018140100126C0005002Q042Q00126C00060064042Q0006C60006009F13010005000426012Q009F13012Q007B000500173Q00128300060065045Q00050002000200202Q00050005002D4Q00050002000200062Q0005003913013Q000426012Q003913012Q007B0005002E4Q0053000600033Q00122Q00070066042Q00122Q00080067045Q0006000800024Q0005000500064Q000600033Q00122Q00070068042Q00122Q00080069045Q0006000800024Q0005000500064Q000600033Q00122Q0007006A042Q00122Q0008006B045Q00060008000200062Q0005003D13010006000426012Q003D130100126C0005006C042Q00126C0006006D042Q00068F0105009F13010006000426012Q009F130100126C0005000A4Q003A000600063Q00126C0007000A3Q0006230105004613010007000426012Q0046130100126C0007006E042Q00126C0008006F042Q0006C60007003F13010008000426012Q003F130100126C0006000A3Q00126C00070070042Q00126C00080071042Q0006C60008004713010007000426012Q0047130100126C0007000A3Q0006ED0006004713010007000426012Q004713012Q007B00075Q00120100090056045Q0007000700094Q000900173Q00122Q000A0065045Q0009000A6Q00073Q00024Q000400073Q00062Q0004006113010003000426012Q006113012Q007B00075Q00121001090059045Q0007000700094Q000900173Q00122Q000A0065045Q0009000A6Q00073Q000200062Q0007006513013Q000426012Q0065130100126C00070072042Q00126C00080073042Q0006ED0007001814010008000426012Q0018140100126C00070074042Q00126C00080075042Q0006C60008001814010007000426012Q001814012Q007B000700013Q0020070107000700044Q000800173Q00122Q00090065045Q000800096Q00073Q000200062Q0007001814013Q000426012Q0018140100126C0007000A4Q003A000800083Q00126C0009000A3Q0006230107007A13010009000426012Q007A130100126C00090076042Q00126C000A0077042Q0006C6000900731301000A000426012Q0073130100126C0008000A3Q00126C00090078042Q00126C000A0079042Q0006C6000A007B13010009000426012Q007B130100126C0009000A3Q0006230108008613010009000426012Q0086130100126C0009007A042Q00126C000A007B042Q00068F0109007B1301000A000426012Q007B130100126C0009000A3Q00126C000A000A3Q0006ED000900871301000A000426012Q008713012Q007B000A00014Q0041000B00033Q00122Q000C007C042Q00122Q000D007D045Q000B000D000200122Q000C007E045Q000A000B000C4Q000A00033Q00122Q000B007F042Q00122Q000C0080045Q000A000C6Q000A5Q00044Q00871301000426012Q007B1301000426012Q00181401000426012Q00731301000426012Q00181401000426012Q00471301000426012Q00181401000426012Q003F1301000426012Q0018140100126C00050081042Q00126C00060081042Q0006ED0005001814010006000426012Q001814012Q007B000500173Q00128300060082045Q00050002000200202Q00050005002D4Q00050002000200062Q0005001814013Q000426012Q001814012Q007B0005002E4Q002D010600033Q00122Q00070083042Q00122Q00080084045Q0006000800024Q0005000500064Q000600033Q00122Q00070085042Q00122Q00080086045Q0006000800024Q0005000500064Q000600033Q00122Q00070087042Q00122Q00080088045Q00060008000200062Q0005001814010006000426012Q0018140100126C0005000A3Q00126C0006000A3Q000623010500C713010006000426012Q00C7130100126C00060089042Q00126C0007008A042Q0006920106000500010007000426012Q00C7130100126C0006008B042Q00126C0007008C042Q00068F010700BC13010006000426012Q00BC13012Q007B00065Q00126C00080056043Q00400106000600082Q007B000800173Q00126C00090082043Q002D000800094Q009C00063Q00022Q0013010400063Q00126C0006008D042Q00126C0007008E042Q00068F0107001814010006000426012Q0018140100068F0104001814010003000426012Q001814012Q007B00065Q00121B01080059045Q0006000600084Q000800173Q00122Q00090082045Q000800096Q00063Q000200062Q0006001814010001000426012Q0018140100126C0006008F042Q00126C00070090042Q0006C60006001814010007000426012Q001814012Q007B000600013Q0020070106000600044Q000700173Q00122Q00080082045Q000700086Q00063Q000200062Q0006001814013Q000426012Q0018140100126C0006000A4Q003A000700073Q00126C0008000A3Q0006ED000600EC13010008000426012Q00EC130100126C0007000A3Q00126C0008000A3Q000623010700F713010008000426012Q00F7130100126C00080091042Q00126C00090057012Q00068F010800F013010009000426012Q00F0130100126C0008000A4Q003A000900093Q00126C000A0092042Q00126C000B0093042Q00068F010B00F91301000A000426012Q00F9130100126C000A000A3Q0006ED000800F91301000A000426012Q00F9130100126C0009000A3Q00126C000A000A3Q0006ED000900011401000A000426012Q000114012Q007B000A00014Q0041000B00033Q00122Q000C0094042Q00122Q000D0095045Q000B000D000200122Q000C0096045Q000A000B000C4Q000A00033Q00122Q000B0097042Q00122Q000C0098045Q000A000C6Q000A5Q00044Q00011401000426012Q00F01301000426012Q00F91301000426012Q00F01301000426012Q00181401000426012Q00EC1301000426012Q00181401000426012Q00BC13012Q007B00055Q00126C00070056043Q00400105000500072Q007B000700173Q00126C00080099043Q002D000700084Q009C00053Q00022Q0013010400053Q00126C0005009A042Q00126C0006009B042Q0006C60006008D14010005000426012Q008D14012Q007B000500173Q00128300060099045Q00050002000200202Q00050005002D4Q00050002000200062Q0005003C14013Q000426012Q003C14012Q007B0005002E4Q0053000600033Q00122Q0007009C042Q00122Q0008009D045Q0006000800024Q0005000500064Q000600033Q00122Q0007009E042Q00122Q0008009F045Q0006000800024Q0005000500064Q000600033Q00122Q000700A0042Q00122Q000800A1045Q00060008000200062Q0005004014010006000426012Q0040140100126C0005002D042Q00126C000600A2042Q0006C60005008D14010006000426012Q008D140100068F0104004B14010003000426012Q004B14012Q007B00055Q00121001070059045Q0005000500074Q000700173Q00122Q00080099045Q000700086Q00053Q000200062Q0005004F14013Q000426012Q004F140100126C000500A3042Q00126C000600A4042Q00068F0105008815010006000426012Q008815012Q007B000500013Q0020070105000500044Q000600173Q00122Q00070099045Q000600076Q00053Q000200062Q0005008815013Q000426012Q0088150100126C0005000A4Q003A000600063Q00126C00070005042Q00126C000800A5042Q00068F0108005914010007000426012Q0059140100126C000700A6042Q00126C000800A7042Q0006C60007005914010008000426012Q0059140100126C0007000A3Q0006ED0005005914010007000426012Q0059140100126C0006000A3Q00126C000700A8042Q00126C000800A9042Q00068F0107006514010008000426012Q0065140100126C000700AA042Q00126C000800AB042Q0006C60008006514010007000426012Q0065140100126C0007000A3Q0006ED0006006514010007000426012Q0065140100126C0007000A3Q00126C000800AC042Q00126C000900AC042Q0006ED0008007114010009000426012Q0071140100126C0008000A3Q0006230108007C14010007000426012Q007C140100126C000800AD042Q00126C000900AE042Q00068F0109007114010008000426012Q007114012Q007B000800014Q0041000900033Q00122Q000A00AF042Q00122Q000B00B0045Q0009000B000200122Q000A0099045Q00080009000A4Q000800033Q00122Q000900B1042Q00122Q000A00B2045Q0008000A6Q00085Q00044Q00711401000426012Q00651401000426012Q00881501000426012Q00591401000426012Q008815012Q007B000500173Q001283000600B3045Q00050002000200202Q00050005002D4Q00050002000200062Q0005000115013Q000426012Q000115012Q007B0005002E4Q002D010600033Q00122Q000700B4042Q00122Q000800B5045Q0006000800024Q0005000500064Q000600033Q00122Q000700B6042Q00122Q000800B7045Q0006000800024Q0005000500064Q000600033Q00122Q000700B8042Q00122Q000800B9045Q00060008000200062Q0005000115010006000426012Q0001150100126C0005000A4Q003A000600063Q00126C0007000A3Q000623010500AE14010007000426012Q00AE140100126C000700BA042Q00126C000800BB042Q0006ED000700A714010008000426012Q00A7140100126C0006000A3Q00126C0007000A3Q000623010600B614010007000426012Q00B6140100126C000700BC042Q00126C000800BD042Q0006C6000700AF14010008000426012Q00AF14012Q007B00075Q00124901090056045Q0007000700094Q000900173Q00122Q000A00B3045Q0009000A6Q00073Q00024Q000400073Q00122Q000700BE042Q00122Q000800BE042Q00062Q0007008815010008000426012Q0088150100068F0104008815010003000426012Q008815012Q007B00075Q00126301090059045Q00070007000900122Q000900BF045Q00070009000200062Q0007008815010001000426012Q008815012Q007B000700013Q0020660007000700044Q000800173Q00122Q000900B3045Q000800096Q00073Q000200062Q000700D714010001000426012Q00D7140100126C000700C0042Q00126C000800C1042Q0006C60008008815010007000426012Q0088150100126C0007000A4Q003A000800083Q00126C0009000A3Q000623010700E014010009000426012Q00E0140100126C00090061042Q00126C000A00C2042Q0006C6000A00D914010009000426012Q00D9140100126C0008000A3Q00126C000900C3042Q00126C000A00C3042Q0006ED000900E11401000A000426012Q00E1140100126C0009000A3Q0006ED000800E114010009000426012Q00E1140100126C0009000A3Q00126C000A000A3Q0006ED000A00E914010009000426012Q00E914012Q007B000A00014Q0041000B00033Q00122Q000C00C4042Q00122Q000D00C5045Q000B000D000200122Q000C00C6045Q000A000B000C4Q000A00033Q00122Q000B00C7042Q00122Q000C00C8045Q000A000C6Q000A5Q00044Q00E91401000426012Q00E11401000426012Q00881501000426012Q00D91401000426012Q00881501000426012Q00AF1401000426012Q00881501000426012Q00A71401000426012Q0088150100126C000500C9042Q00126C000600CA042Q0006C60006001D15010005000426012Q001D15012Q007B000500173Q001283000600CB045Q00050002000200202Q00050005002D4Q00050002000200062Q0005001D15013Q000426012Q001D15012Q007B0005002E4Q0053000600033Q00122Q000700CC042Q00122Q000800CD045Q0006000800024Q0005000500064Q000600033Q00122Q000700CE042Q00122Q000800CF045Q0006000800024Q0005000500064Q000600033Q00122Q000700D0042Q00122Q000800D1045Q00060008000200062Q0005002115010006000426012Q0021150100126C000500D2042Q00126C000600D3042Q0006C60006008815010005000426012Q0088150100126C0005000A4Q003A000600063Q00126C000700D4042Q00126C000800D4042Q0006ED0007002315010008000426012Q0023150100126C000700D5042Q00126C000800D5042Q0006ED0007002315010008000426012Q0023150100126C0007000A3Q0006ED0005002315010007000426012Q0023150100126C0006000A3Q00126C0007000A3Q0006230106003615010007000426012Q0036150100126C000700D6042Q00126C000800D7042Q00068F0108002F15010007000426012Q002F15012Q007B00075Q00120100090056045Q0007000700094Q000900173Q00122Q000A00CB045Q0009000A6Q00073Q00024Q000400073Q00062Q0004008815010003000426012Q008815012Q007B00075Q00126301090059045Q00070007000900122Q000900BF045Q00070009000200062Q0007008815010001000426012Q0088150100126C000700E9032Q00126C000800E9032Q0006ED0007008815010008000426012Q008815012Q007B000700013Q0020070107000700044Q000800173Q00122Q000900CB045Q000800096Q00073Q000200062Q0007008815013Q000426012Q0088150100126C0007000A4Q003A000800083Q00126C000900D8042Q00126C000A00D9042Q0006C60009005C1501000A000426012Q005C150100126C0009000A3Q0006230107006015010009000426012Q0060150100126C000900DA042Q00126C000A00DB042Q00068F010A005515010009000426012Q0055150100126C0008000A3Q00126C000900DC042Q00126C000A00DD042Q00068F010A006115010009000426012Q0061150100126C0009000A3Q0006230109006C15010008000426012Q006C150100126C000900DE042Q00126C000A00DF042Q0006ED000900611501000A000426012Q0061150100126C0009000A3Q00126C000A00E0042Q00126C000B00E1042Q0006C6000A006D1501000B000426012Q006D150100126C000A000A3Q0006ED0009006D1501000A000426012Q006D15012Q007B000A00014Q0041000B00033Q00122Q000C00E2042Q00122Q000D00E3045Q000B000D000200122Q000C00E4045Q000A000B000C4Q000A00033Q00122Q000B00E5042Q00122Q000C00E6045Q000A000C6Q000A5Q00044Q006D1501000426012Q00611501000426012Q00881501000426012Q00551501000426012Q00881501000426012Q002F1501000426012Q00881501000426012Q0023150100126C000300E7042Q00126C000400E8042Q00068F010400A015010003000426012Q00A015012Q007B00035Q0020AB0103000300334Q000500023Q00202Q0005000500B14Q00030005000200062Q000300A015010001000426012Q00A015012Q007B00035Q00126C00050088013Q00400103000300052Q007200030002000200067C000300A015010001000426012Q00A015012Q007B00035Q0020520103000300B04Q000500016Q000600016Q00030006000200062Q000300A415013Q000426012Q00A4150100126C000300E9042Q00126C000400EA042Q00068F010300CA15010004000426012Q00CA150100126C0003000A4Q003A000400043Q00126C0005000A3Q000623010300B115010005000426012Q00B1150100126C000500EB042Q00126C000600EC042Q0006920106000500010005000426012Q00B1150100126C000500ED042Q00126C000600EE042Q0006C6000600A615010005000426012Q00A6150100126C0004000A3Q00126C000500EF042Q00126C000600EF042Q0006ED000500B215010006000426012Q00B2150100126C0005000A3Q0006ED000400B215010005000426012Q00B215012Q007B000500083Q00126C000600F0043Q00040005000500062Q007B000600023Q00126C000700F0043Q00040006000600072Q00720005000200022Q00CA000500154Q007B000500153Q000657010500CA15013Q000426012Q00CA15012Q007B000500154Q0030000500023Q000426012Q00CA1501000426012Q00B21501000426012Q00CA1501000426012Q00A615012Q007B00035Q00126C00050088013Q00400103000300052Q007200030002000200067C000300DC15010001000426012Q00DC15012Q007B000300024Q007D010400033Q00122Q000500F1042Q00122Q000600F2045Q0004000600024Q00030003000400122Q000500F3045Q0003000300054Q00030002000200122Q0004003B3Q00062Q000400E015010003000426012Q00E0150100126C000300F4042Q00126C000400F5042Q0006C60004005D1A010003000426012Q005D1A0100126C0003000A3Q00126C0004000A3Q00126C0005000A3Q0006ED000400E215010005000426012Q00E2150100126C000500F6042Q00126C000600F7042Q0006C6000500B519010006000426012Q00B5190100126C0005003B3Q000623010300F015010005000426012Q00F0150100126C000500F8042Q00126C000600F9042Q00068F010500B519010006000426012Q00B5190100126C0005000A3Q00126C000600FA042Q00126C000700FB042Q0006C6000700F115010006000426012Q00F1150100126C0006000A3Q0006ED000500F115010006000426012Q00F1150100126C000600FC042Q00126C000700FD042Q00068F010700B319010006000426012Q00B319012Q007B000600053Q00126C000700FE043Q00040006000600072Q0033010600010002000657010600B319013Q000426012Q00B319012Q007B00065Q00126C00080088013Q00400106000600082Q007200060002000200067C000600B319010001000426012Q00B319012Q007B000600303Q000657010600B319013Q000426012Q00B319012Q007B000600314Q00330106000100020006570106009F16013Q000426012Q009F16012Q007B000600024Q00FE000700033Q00122Q000800FF042Q00122Q00092Q00055Q0007000900024Q00060006000700122Q000800CD035Q0006000600084Q00060002000200062Q0006009F16013Q000426012Q009F16012Q007B000600094Q007B000700083Q00126C00080001053Q00040007000700082Q003301070001000200126C0008003B4Q00020007000700080006C60007009F16010006000426012Q009F16012Q007B000600233Q00123201080002055Q0006000600084Q00060002000200122Q00070003052Q00062Q0006009F16010007000426012Q009F160100126C000600C5022Q00126C00070004052Q0006C60007006D16010006000426012Q006D16012Q007B0006002E4Q0080000700033Q00122Q0008002Q052Q00122Q00090006055Q0007000900024Q0006000600074Q000700033Q00122Q00080007052Q00122Q00090008055Q0007000900024Q0006000600070006570106006D16013Q000426012Q006D160100126C00060009052Q00126C0007000A052Q0006C60007009F16010006000426012Q009F16012Q007B000600013Q0020080006000600044Q000700023Q00122Q0008000B055Q0007000700084Q000800086Q00060008000200062Q0006009F16013Q000426012Q009F160100126C0006000A4Q003A000700073Q00126C000800AD022Q00126C0009000C052Q0006C60008004A16010009000426012Q004A160100126C0008000D052Q00126C0009000E052Q00068F0109004A16010008000426012Q004A160100126C0008000A3Q0006ED0006004A16010008000426012Q004A160100126C0007000A3Q00126C0008000F052Q00126C00090010052Q00068F0109005616010008000426012Q0056160100126C0008000A3Q0006ED0007005616010008000426012Q005616012Q007B000800014Q0041000900033Q00122Q000A0011052Q00122Q000B0012055Q0009000B000200122Q000A0013055Q00080009000A4Q000800033Q00122Q00090014052Q00122Q000A0015055Q0008000A6Q00085Q00044Q00561601000426012Q009F1601000426012Q004A1601000426012Q009F16012Q007B000600013Q0020080006000600044Q000700023Q00122Q0008000B055Q0007000700084Q000800086Q00060008000200062Q0006009F16013Q000426012Q009F160100126C0006000A4Q003A000700073Q00126C0008000A3Q0006230108007F16010006000426012Q007F160100126C00080016052Q00126C00090017052Q0006C60009007816010008000426012Q0078160100126C0007000A3Q00126C000800ED032Q00126C000900ED032Q0006ED0008008016010009000426012Q0080160100126C0008000A3Q0006ED0007008016010008000426012Q0080160100126C0008000A3Q00126C0009007E042Q00126C000A0018052Q00068F010900881601000A000426012Q0088160100126C0009000A3Q0006ED0008008816010009000426012Q008816012Q007B000900014Q0041000A00033Q00122Q000B0019052Q00122Q000C001A055Q000A000C000200122Q000B0013055Q0009000A000B4Q000900033Q00122Q000A001B052Q00122Q000B001C055Q0009000B6Q00095Q00044Q00881601000426012Q00801601000426012Q009F1601000426012Q007816012Q007B000600024Q00FE000700033Q00122Q0008001D052Q00122Q0009001E055Q0007000900024Q00060006000700122Q0008003C035Q0006000600084Q00060002000200062Q000600C916013Q000426012Q00C916012Q007B000600323Q000657010600C916013Q000426012Q00C916012Q007B000600024Q004B010700033Q00122Q0008001F052Q00122Q00090020055Q0007000900024Q00060006000700202Q00060006002D4Q00060002000200062Q000600C916013Q000426012Q00C916012Q007B000600043Q00126C0007003D042Q0006C6000600C916010007000426012Q00C916012Q007B000600024Q0022000700033Q00122Q00080021052Q00122Q00090022055Q0007000900024Q00060006000700202Q00060006002D4Q00060002000200062Q000600C916010001000426012Q00C916012Q007B000600043Q00126C0007003D042Q0006920106000500010007000426012Q00CD160100126C00060023052Q00126C00070024052Q00068F010700F016010006000426012Q00F016012Q007B000600013Q0020470106000600044Q000700023Q00202Q0007000700344Q00060002000200062Q000600F016013Q000426012Q00F0160100126C0006000A4Q003A000700073Q00126C0008000A3Q0006ED000600D616010008000426012Q00D6160100126C0007000A3Q00126C0008000A3Q000623010800E116010007000426012Q00E1160100126C00080025052Q00126C00090081012Q0006C6000900DA16010008000426012Q00DA16012Q007B000800014Q0041000900033Q00122Q000A0026052Q00122Q000B0027055Q0009000B000200122Q000A0028055Q00080009000A4Q000800033Q00122Q00090029052Q00122Q000A002A055Q0008000A6Q00085Q00044Q00DA1601000426012Q00F01601000426012Q00D616012Q007B000600024Q00FE000700033Q00122Q0008002B052Q00122Q0009002C055Q0007000900024Q00060006000700122Q0008003C035Q0006000600084Q00060002000200062Q0006000D17013Q000426012Q000D17012Q007B00065Q00126C0008002D053Q00400106000600082Q007B000800023Q00126C0009002E053Q00040008000800092Q00A801060008000200067C0006000D17010001000426012Q000D17012Q007B000600334Q003301060001000200126C0007000A3Q0006230106001117010007000426012Q001117012Q007B000600344Q003301060001000200067C0006001117010001000426012Q0011170100126C0006002F052Q00126C00070030052Q0006C60006003517010007000426012Q003517012Q007B000600013Q0020210106000600044Q000700023Q00122Q00080031055Q0007000700084Q00060002000200062Q0006003517013Q000426012Q0035170100126C0006000A4Q003A000700073Q00126C0008000A3Q0006230106002217010008000426012Q0022170100126C00080032052Q00126C00090033052Q00068F0109001B17010008000426012Q001B170100126C0007000A3Q00126C0008000A3Q0006ED0007002317010008000426012Q002317012Q007B000800014Q0041000900033Q00122Q000A0034052Q00122Q000B0035055Q0009000B000200122Q000A0036055Q00080009000A4Q000800033Q00122Q00090037052Q00122Q000A0038055Q0008000A6Q00085Q00044Q00231701000426012Q00351701000426012Q001B17012Q007B000600024Q00FE000700033Q00122Q00080039052Q00122Q0009003A055Q0007000900024Q00060006000700122Q0008003C035Q0006000600084Q00060002000200062Q0006009217013Q000426012Q009217012Q007B000600323Q0006570106009217013Q000426012Q009217012Q007B000600024Q004B010700033Q00122Q0008003B052Q00122Q0009003C055Q0007000900024Q00060006000700202Q00060006002D4Q00060002000200062Q0006009217013Q000426012Q009217012Q007B000600043Q00126C0007003D042Q0006C60006009217010007000426012Q009217012Q007B000600013Q00203B0006000600044Q000700023Q00202Q0007000700344Q00060002000200062Q0006005C17010001000426012Q005C170100126C0006003D052Q00126C0007003E052Q00068F0107009217010006000426012Q0092170100126C0006000A3Q00126C0007003F052Q00126C00080040052Q0006C60008005D17010007000426012Q005D170100126C00070041052Q00126C00080042052Q00068F0107005D17010008000426012Q005D170100126C0007000A3Q0006ED0006005D17010007000426012Q005D170100126C0007000A4Q003A000800083Q00126C00090043052Q00126C000A0044052Q00068F0109006A1701000A000426012Q006A170100126C0009000A3Q0006ED0007006A17010009000426012Q006A170100126C0008000A3Q00126C00090045052Q00126C000A0046052Q00068F010A007217010009000426012Q0072170100126C0009000A3Q0006ED0009007217010008000426012Q0072170100126C0009000A3Q00126C000A000A3Q000623010900811701000A000426012Q0081170100126C000A0047052Q00126C000B0048052Q00068F010B007A1701000A000426012Q007A17012Q007B000A00014Q0041000B00033Q00122Q000C0049052Q00122Q000D004A055Q000B000D000200122Q000C0028055Q000A000B000C4Q000A00033Q00122Q000B004B052Q00122Q000C004C055Q000A000C6Q000A5Q00044Q007A1701000426012Q00721701000426012Q005D1701000426012Q006A1701000426012Q005D17012Q007B000600024Q00FE000700033Q00122Q0008004D052Q00122Q0009004E055Q0007000900024Q00060006000700122Q0008003C035Q0006000600084Q00060002000200062Q000600B117013Q000426012Q00B117012Q007B00065Q00126B01080056045Q0006000600084Q000800023Q00122Q0009004F055Q0008000800094Q0006000800024Q0007001B3Q00122Q0008003B6Q000900046Q0007000900024Q0008001C3Q00122Q0009003B6Q000A00046Q0008000A00024Q00070007000800122Q00080050055Q00070007000800062Q000600B517010007000426012Q00B5170100126C00060050022Q00126C00070051052Q00068F010700F317010006000426012Q00F317012Q007B000600013Q0012B600070052055Q0006000600074Q000700023Q00122Q0008004F055Q0007000700084Q00060002000200062Q000600F317013Q000426012Q00F3170100126C0006000A4Q003A000700073Q00126C00080053052Q00126C00090053052Q0006ED000800C017010009000426012Q00C0170100126C0008000A3Q000623010600CB17010008000426012Q00CB170100126C00080054052Q00126C00090055052Q00068F010800C017010009000426012Q00C0170100126C0007000A3Q00126C00080056052Q00126C00090056052Q0006ED000800D317010009000426012Q00D3170100126C0008000A3Q000623010700D717010008000426012Q00D7170100126C00080057052Q00126C00090058052Q0006ED000800CC17010009000426012Q00CC170100126C0008000A3Q00126C00090059052Q00126C000A005A052Q0006C6000900DF1701000A000426012Q00DF170100126C0009000A3Q000623010800E317010009000426012Q00E3170100126C0009005B052Q00126C000A005C052Q00068F010A00D817010009000426012Q00D817012Q007B000900014Q0041000A00033Q00122Q000B005D052Q00122Q000C005E055Q000A000C000200122Q000B005F055Q0009000A000B4Q000900033Q00122Q000A0060052Q00122Q000B0061055Q0009000B6Q00095Q00044Q00D81701000426012Q00CC1701000426012Q00F31701000426012Q00C017012Q007B00065Q0020410106000600B04Q000800016Q00098Q00060009000200062Q0006000118010001000426012Q000118012Q007B00065Q0020DA0006000600334Q000800023Q00202Q0008000800B14Q00060008000200062Q0006004219013Q000426012Q0042190100126C0006000A3Q00126C000700FD042Q00126C00080062052Q0006C60007001F18010008000426012Q001F180100126C00070063052Q00126C00080064052Q0006C60008001F18010007000426012Q001F180100126C0007000A3Q0006ED0006001F18010007000426012Q001F18012Q007B000700354Q00330107000100022Q00CA000700153Q00126C00070065052Q00126C00080066052Q00068F0107001E18010008000426012Q001E18012Q007B000700153Q0006570107001E18013Q000426012Q001E18012Q007B000700033Q00128500080067052Q00122Q00090068055Q0007000900024Q000800156Q0007000700084Q000700023Q00126C0006003B3Q00126C0007003B3Q0006ED0006000218010007000426012Q000218012Q007B000700024Q004B010800033Q00122Q00090069052Q00122Q000A006A055Q0008000A00024Q00070007000800202Q00070007002D4Q00070002000200062Q0007008518013Q000426012Q008518012Q007B000700024Q00FE000800033Q00122Q0009006B052Q00122Q000A006C055Q0008000A00024Q00070007000800122Q0009003C035Q0007000700094Q00070002000200062Q0007008518013Q000426012Q008518012Q007B000700024Q004B010800033Q00122Q0009006D052Q00122Q000A006E055Q0008000A00024Q00070007000800202Q00070007002D4Q00070002000200062Q0007008518013Q000426012Q008518012Q007B000700363Q0006570107008518013Q000426012Q008518012Q007B000700013Q0020310007000700044Q000800023Q00122Q0009006F055Q0008000800094Q0009000A6Q000B00233Q00202Q000B000B00BC4Q000D00023Q00122Q000E006F055Q000D000D000E4Q000B000D00024Q000B000B6Q0007000B000200062Q0007005818010001000426012Q0058180100126C00070070052Q00126C00080071052Q0006C60007008518010008000426012Q0085180100126C0007000A4Q003A000800083Q00126C0009000A3Q0006230107006118010009000426012Q0061180100126C00090072052Q00126C000A0008012Q00068F010A005A18010009000426012Q005A180100126C0008000A3Q00126C00090086022Q00126C000A0073052Q00068F010A006218010009000426012Q0062180100126C0009000A3Q0006230108006D18010009000426012Q006D180100126C00090074052Q00126C000A0075052Q0006C6000900621801000A000426012Q0062180100126C0009000A3Q00126C000A0076052Q00126C000B0076052Q0006ED000A006E1801000B000426012Q006E180100126C000A000A3Q0006ED0009006E1801000A000426012Q006E18012Q007B000A00014Q0041000B00033Q00122Q000C0077052Q00122Q000D0078055Q000B000D000200122Q000C0079055Q000A000B000C4Q000A00033Q00122Q000B007A052Q00122Q000C007B055Q000A000C6Q000A5Q00044Q006E1801000426012Q00621801000426012Q00851801000426012Q005A18012Q007B000700024Q00FE000800033Q00122Q0009007C052Q00122Q000A007D055Q0008000A00024Q00070007000800122Q000900CD035Q0007000700094Q00070002000200062Q000700EF18013Q000426012Q00EF18012Q007B000700024Q004B010800033Q00122Q0009007E052Q00122Q000A007F055Q0008000A00024Q00070007000800202Q00070007002D4Q00070002000200062Q000700EF18013Q000426012Q00EF18012Q007B000700013Q0020310007000700044Q000800023Q00122Q00090080055Q0008000800094Q0009000A6Q000B00233Q00202Q000B000B00BC4Q000D00023Q00122Q000E0080055Q000D000D000E4Q000B000D00024Q000B000B6Q0007000B000200062Q000700AE18010001000426012Q00AE180100126C00070081052Q00126C00080082052Q0006ED0007006819010008000426012Q0068190100126C0007000A4Q003A000800083Q00126C00090083052Q00126C000A0083052Q0006ED000900B01801000A000426012Q00B0180100126C0009000A3Q000623010700BB18010009000426012Q00BB180100126C00090084052Q00126C000A0085052Q00068F010900B01801000A000426012Q00B0180100126C0008000A3Q00126C00090086052Q00126C000A0087052Q00068F010900BC1801000A000426012Q00BC180100126C0009000A3Q000623010900C718010008000426012Q00C7180100126C00090088052Q00126C000A0089052Q0006C6000900BC1801000A000426012Q00BC180100126C0009000A4Q003A000A000A3Q00126C000B00F43Q00126C000C0077042Q0006C6000B00C91801000C000426012Q00C9180100126C000B008A052Q00126C000C008B052Q0006C6000C00C91801000B000426012Q00C9180100126C000B000A3Q0006ED000900C91801000B000426012Q00C9180100126C000A000A3Q00126C000B008C052Q00126C000C008D052Q0006C6000C00D51801000B000426012Q00D5180100126C000B000A3Q0006ED000A00D51801000B000426012Q00D518012Q007B000B00014Q0041000C00033Q00122Q000D008E052Q00122Q000E008F055Q000C000E000200122Q000D0090055Q000B000C000D4Q000B00033Q00122Q000C0091052Q00122Q000D0092055Q000B000D6Q000B5Q00044Q00D51801000426012Q00BC1801000426012Q00C91801000426012Q00BC1801000426012Q00681901000426012Q00B01801000426012Q006819012Q007B000700024Q0097010800033Q00122Q00090093052Q00122Q000A0094055Q0008000A00024Q00070007000800122Q000900CD035Q0007000700094Q00070002000200062Q000700FE18010001000426012Q00FE180100126C00070095052Q00126C00080096052Q00068F0107006819010008000426012Q0068190100126C00070097052Q00126C00080098052Q00068F0107001219010008000426012Q001219012Q007B000700013Q0020310007000700044Q000800023Q00122Q00090099055Q0008000800094Q0009000A6Q000B00233Q00202Q000B000B00BC4Q000D00023Q00122Q000E0099055Q000D000D000E4Q000B000D00024Q000B000B6Q0007000B000200062Q0007001619010001000426012Q0016190100126C0007009A052Q00126C0008009B052Q0006C60008006819010007000426012Q0068190100126C0007000A4Q003A000800083Q00126C0009009C052Q00126C000A009D052Q0006C6000900181901000A000426012Q0018190100126C0009000A3Q0006230107002319010009000426012Q0023190100126C0009002C012Q00126C000A009E052Q0006C6000A001819010009000426012Q0018190100126C0008000A3Q00126C000900B5032Q00126C000A009F052Q0006C6000A002419010009000426012Q0024190100126C0009000A3Q0006ED0008002419010009000426012Q0024190100126C0009000A3Q00126C000A000A3Q0006ED0009002C1901000A000426012Q002C19012Q007B000A00014Q0041000B00033Q00122Q000C00A0052Q00122Q000D00A1055Q000B000D000200122Q000C00A2055Q000A000B000C4Q000A00033Q00122Q000B00A3052Q00122Q000C00A4055Q000A000C6Q000A5Q00044Q002C1901000426012Q00241901000426012Q00681901000426012Q00181901000426012Q00681901000426012Q00021801000426012Q006819012Q007B000600374Q00330106000100020006570106006819013Q000426012Q0068190100126C0006000A4Q003A000700073Q00126C0008000A3Q0006ED0006004819010008000426012Q0048190100126C0007000A3Q00126C000800A5052Q00126C000900A5052Q0006ED0008004C19010009000426012Q004C190100126C0008000A3Q0006ED0008004C19010007000426012Q004C19012Q007B000800384Q00C80008000100024Q000800153Q00122Q000800A6052Q00122Q000900A7052Q00062Q0009006819010008000426012Q006819012Q007B000800153Q0006570108006819013Q000426012Q006819012Q007B000800033Q001285000900A8052Q00122Q000A00A9055Q0008000A00024Q000900156Q0008000800094Q000800023Q000426012Q00681901000426012Q004C1901000426012Q00681901000426012Q0048190100126C000600AA052Q00126C000700AB052Q0006C6000600B319010007000426012Q00B319012Q007B000600024Q00FE000700033Q00122Q000800AC052Q00122Q000900AD055Q0007000900024Q00060006000700122Q000800CD035Q0006000600084Q00060002000200062Q000600B319013Q000426012Q00B319012Q007B000600013Q0020820106000600044Q000700023Q00122Q00080099055Q0007000700084Q000800096Q000A00233Q00202Q000A000A00BC4Q000C00023Q00122Q000D0099055Q000C000C000D4Q000A000C00024Q000A000A6Q0006000A000200062Q000600B319013Q000426012Q00B3190100126C0006000A4Q003A000700073Q00126C0008000A3Q0006230108009019010006000426012Q0090190100126C000800AE052Q00126C000900AF052Q0006C60008008919010009000426012Q0089190100126C0007000A3Q00126C0008000A3Q0006ED0008009119010007000426012Q0091190100126C0008000A4Q003A000900093Q00126C000A00B0052Q00126C000B00B1052Q00068F010A00961901000B000426012Q0096190100126C000A000A3Q0006ED000800961901000A000426012Q0096190100126C0009000A3Q00126C000A000A3Q0006ED0009009E1901000A000426012Q009E19012Q007B000A00014Q0041000B00033Q00122Q000C00B2052Q00122Q000D00B3055Q000B000D000200122Q000C00A2055Q000A000B000C4Q000A00033Q00122Q000B00B4052Q00122Q000C00B5055Q000A000C6Q000A5Q00044Q009E1901000426012Q00911901000426012Q00961901000426012Q00911901000426012Q00B31901000426012Q008919012Q0045012Q00013Q000426012Q00F1150100126C0005000A3Q0006ED000500E115010003000426012Q00E115012Q007B000500024Q00FE000600033Q00122Q000700B6052Q00122Q000800B7055Q0006000800024Q00050005000600122Q0007003C035Q0005000500074Q00050002000200062Q000500EF19013Q000426012Q00EF19012Q007B00055Q001227010700B8055Q0005000500074Q000700023Q00122Q00080011025Q0007000700084Q00050007000200062Q000500EF19013Q000426012Q00EF19012Q007B000500024Q004B010600033Q00122Q000700B9052Q00122Q000800BA055Q0006000800024Q00050005000600202Q00050005002D4Q00050002000200062Q000500EF19013Q000426012Q00EF19012Q007B00055Q0020410105000500B04Q000700016Q000800016Q00050008000200062Q000500EF19010001000426012Q00EF19012Q007B000500024Q0097010600033Q00122Q000700BB052Q00122Q000800BC055Q0006000800024Q00050005000600122Q0007003C035Q0005000500074Q00050002000200062Q000500F319010001000426012Q00F319012Q007B00055Q0020AB0105000500334Q000700023Q00202Q0007000700344Q00050007000200062Q000500F319010001000426012Q00F3190100126C000500BD052Q00126C000600BE052Q0006C6000600231A010005000426012Q00231A0100126C000500BF052Q00126C000600BF052Q0006ED000500231A010006000426012Q00231A0100126C000500C0052Q00126C000600C1052Q00068F010600231A010005000426012Q00231A012Q007B000500013Q0020210105000500044Q000600023Q00122Q00070011025Q0006000600074Q00050002000200062Q000500231A013Q000426012Q00231A0100126C0005000A4Q003A000600063Q00126C0007000A3Q0006230107000C1A010005000426012Q000C1A0100126C000700C2052Q00126C000800C3052Q00068F010700051A010008000426012Q00051A0100126C0006000A3Q00126C000700C4052Q00126C000800C4052Q0006ED0007000D1A010008000426012Q000D1A0100126C0007000A3Q0006ED0006000D1A010007000426012Q000D1A012Q007B000700014Q0041000800033Q00122Q000900C5052Q00122Q000A00C6055Q0008000A000200122Q0009001A025Q0007000800094Q000700033Q00122Q000800C7052Q00122Q000900C8055Q000700096Q00075Q00044Q000D1A01000426012Q00231A01000426012Q00051A012Q007B00055Q0020520105000500B04Q000700016Q00088Q00050008000200062Q0005002E1A013Q000426012Q002E1A0100126C000500C9052Q00126C000600CA052Q0006ED000500591A010006000426012Q00591A0100126C0005000A4Q003A000600063Q00126C000700CB052Q00126C000800CC052Q0006C6000700301A010008000426012Q00301A0100126C0007000A3Q0006230107003B1A010005000426012Q003B1A0100126C000700CD052Q00126C000800CE052Q00068F010700301A010008000426012Q00301A0100126C0006000A3Q00126C0007000A3Q0006ED0006003C1A010007000426012Q003C1A012Q007B000700083Q00126C000800F0043Q00040007000700082Q007B000800083Q00126C000900CF053Q00040008000800092Q0074000800014Q009C00073Q00022Q00CA000700153Q00126C000700D0052Q00126C000800D1052Q0006C60008004F1A010007000426012Q004F1A012Q007B000700153Q00067C000700531A010001000426012Q00531A0100126C000700D2052Q00126C000800D3052Q0006C6000800591A010007000426012Q00591A012Q007B000700154Q0030000700023Q000426012Q00591A01000426012Q003C1A01000426012Q00591A01000426012Q00301A0100126C0003003B3Q000426012Q00E11501000426012Q00E21501000426012Q00E115012Q007B000300024Q004B010400033Q00122Q000500D4052Q00122Q000600D5055Q0004000600024Q00030003000400202Q00030003002D4Q00030002000200062Q0003009D1A013Q000426012Q009D1A012Q007B000300024Q001F000400033Q00122Q000500D6052Q00122Q000600D7055Q0004000600024Q00030003000400122Q000500F3045Q0003000300054Q0003000200024Q00045Q00122Q000600D8055Q0004000400064Q00040002000200062Q0003009D1A010004000426012Q009D1A0100126C0003000A3Q00126C0004003B3Q000623010300821A010004000426012Q00821A0100126C000400D9052Q00126C000500DA052Q0006920104000500010005000426012Q00821A0100126C000400DB052Q00126C000500DC052Q0006C6000400871A010005000426012Q00871A012Q007B00045Q0020AC0004000400322Q00720004000200022Q00CA000400093Q000426012Q009D1A0100126C000400DD052Q00126C000500DD052Q0006ED000400771A010005000426012Q00771A0100126C0004000A3Q0006ED000300771A010004000426012Q00771A012Q007B000400394Q007B000500044Q007B000600083Q00126C000700DE053Q00040006000600072Q0074000600014Q009C00043Q00022Q00CA000400044Q007B000400083Q0020820004000400312Q007B000500044Q00720004000200022Q00CA000400073Q00126C0003003B3Q000426012Q00771A012Q007B000300053Q00126C000400FE043Q00040003000300042Q0033010300010002000657010300CB1A013Q000426012Q00CB1A012Q007B00035Q00126C00050088013Q00400103000300052Q007200030002000200067C000300C21A010001000426012Q00C21A012Q007B000300303Q00067C000300C21A010001000426012Q00C21A012Q007B00035Q0020AB0103000300334Q000500023Q00202Q0005000500B14Q00030005000200062Q000300C21A010001000426012Q00C21A012Q007B00035Q0020AB0103000300334Q000500023Q00202Q0005000500B14Q00030005000200062Q000300C21A010001000426012Q00C21A012Q007B00035Q0020A60003000300334Q000500023Q00122Q000600DF055Q0005000500064Q00030005000200062Q000300CB1A013Q000426012Q00CB1A012Q007B000300233Q0012100105002D055Q0003000300054Q000500173Q00122Q00060065015Q000500066Q00033Q000200062Q000300CF1A013Q000426012Q00CF1A0100126C000300E0052Q00126C0004003E022Q00068F010400D61E010003000426012Q00D61E0100126C0003000A4Q003A000400063Q00126C0007000A3Q000623010300D81A010007000426012Q00D81A0100126C000700E1052Q00126C000800E2052Q0006C6000700631B010008000426012Q00631B010012B9000700E3052Q00126C000800E4053Q002A0007000200092Q0013010600094Q0013010500084Q0013010400073Q00126C000700E5052Q00126C000800E6052Q00068F010800EF1A010007000426012Q00EF1A012Q007B0007002E4Q00E8000800033Q00122Q000900E7052Q00122Q000A00E8055Q0008000A00024Q0007000700084Q000800033Q00122Q000900E9052Q00122Q000A00EA055Q0008000A00024Q00070007000800062Q000700F31A010001000426012Q00F31A0100126C000700BF3Q00126C000800EB052Q0006C60007005F1B010008000426012Q005F1B012Q007B0007001B4Q003E000800046Q000900056Q0007000900024Q0008001C6Q000900046Q000A00056Q0008000A00024Q00070007000800122Q0008005B6Q0008000100024Q00070007000800122Q0008000A3Q00062Q000700431B010008000426012Q00431B012Q007B000700024Q004B010800033Q00122Q000900EC052Q00122Q000A00ED055Q0008000A00024Q00070007000800202Q00070007002D4Q00070002000200062Q000700431B013Q000426012Q00431B012Q007B000700024Q0014000800033Q00122Q000900EE052Q00122Q000A00EF055Q0008000A00024Q00070007000800202Q00070007008C00122Q0009008D6Q00070009000200122Q0008000A3Q00062Q000700431B010008000426012Q00431B010012B9000700BF033Q00C3000800033Q00122Q000900F0052Q00122Q000A00F1055Q0008000A6Q00073Q000200062Q000700431B013Q000426012Q00431B012Q007B000700244Q0034010800033Q00122Q000900F2052Q00122Q000A00F3055Q0008000A6Q00073Q000200122Q000900F4055Q0007000700094Q00070002000200062Q000700431B010001000426012Q00431B010012B9000700F5053Q0006000800033Q00122Q000900F6052Q00122Q000A00F7055Q0008000A6Q00073Q000200062Q0007003B1B010001000426012Q003B1B010012B9000700F8053Q00C3000800033Q00122Q000900F9052Q00122Q000A00FA055Q0008000A6Q00073Q000200062Q000700431B013Q000426012Q00431B012Q007B000700233Q00129E000900FB055Q00070007000900122Q000900FC052Q00122Q000A004C045Q0007000A000200062Q000700471B010001000426012Q00471B0100126C000700FD052Q00126C000800FE052Q0006C60008005F1B010007000426012Q005F1B0100126C000700FF052Q00126C00082Q00062Q0006C60008005F1B010007000426012Q005F1B012Q007B000700013Q0020210107000700044Q000800023Q00122Q00090001065Q0008000800094Q00070002000200062Q0007005F1B013Q000426012Q005F1B012Q007B000700014Q0069010800033Q00122Q00090002062Q00122Q000A0003065Q0008000A000200122Q00090004065Q0007000800094Q000700033Q00122Q00080005062Q00122Q0009002Q065Q000700096Q00076Q007B0007003A4Q00330107000100022Q00CA000700153Q00126C0003003B3Q00126C00070007062Q00126C00080008062Q00068F010800041C010007000426012Q00041C0100126C0007003D042Q0006ED000300041C010007000426012Q00041C0100126C0007000A3Q00126C0008000A3Q000623010700721B010008000426012Q00721B0100126C00080009062Q00126C0009000A062Q0006C6000800881B010009000426012Q00881B012Q007B0008003B4Q00C80008000100024Q000800153Q00122Q00080085052Q00122Q0009000B062Q00062Q0008007C1B010009000426012Q007C1B012Q007B000800153Q00067C000800801B010001000426012Q00801B0100126C0008000C062Q00126C0009000D062Q0006ED000800871B010009000426012Q00871B012Q007B000800033Q0012850009000E062Q00122Q000A000F065Q0008000A00024Q000900156Q0008000800094Q000800023Q00126C0007003B3Q00126C00080010062Q00126C0009006E032Q0006C60008006B1B010009000426012Q006B1B0100126C00080011062Q00126C0009000D052Q00068F0108006B1B010009000426012Q006B1B0100126C0008003B3Q0006ED0007006B1B010008000426012Q006B1B012Q007B000800024Q00FE000900033Q00122Q000A0012062Q00122Q000B0013065Q0009000B00024Q00080008000900122Q000A00CD035Q00080008000A4Q00080002000200062Q000800C81B013Q000426012Q00C81B012Q007B0008002E4Q0039000900033Q00122Q000A0014062Q00122Q000B0015065Q0009000B00024Q0008000800094Q000900033Q00122Q000A0016062Q00122Q000B0017065Q0009000B00024Q0008000800094Q000900033Q00122Q000A0018062Q00122Q000B0019065Q0009000B00024Q00080008000900062Q000800C81B013Q000426012Q00C81B012Q007B000800314Q0033010800010002000657010800C81B013Q000426012Q00C81B012Q007B000800233Q0020A60008000800BC4Q000A00023Q00122Q000B0099055Q000A000A000B4Q0008000A000200062Q000800C81B013Q000426012Q00C81B012Q007B000800104Q00680109001B3Q00122Q000A001D015Q000B000D6Q0009000B00024Q000A001C3Q00122Q000B001D015Q000C000D6Q000A000C00024Q00090009000A00062Q000900CC1B010008000426012Q00CC1B0100126C0008001A062Q00126C0009001B062Q0006C6000800011C010009000426012Q00011C0100126C0008001C062Q00126C0009001D062Q00068F010900011C010008000426012Q00011C012Q007B000800013Q0020E50008000800044Q000900023Q00122Q000A003B025Q00090009000A4Q000A000A6Q0008000A000200062Q000800DD1B010001000426012Q00DD1B0100126C0008001E062Q00126C0009001F062Q00068F010800011C010009000426012Q00011C0100126C0008000A4Q003A000900093Q00126C000A000A3Q000623010A00E61B010008000426012Q00E61B0100126C000A0020062Q00126C000B0021062Q0006C6000B00DF1B01000A000426012Q00DF1B0100126C0009000A3Q00126C000A000A3Q000623010900F21B01000A000426012Q00F21B0100126C000A0022062Q00126C000B0085032Q000692010A00050001000B000426012Q00F21B0100126C000A0023062Q00126C000B0024062Q00068F010A00E71B01000B000426012Q00E71B012Q007B000A00014Q0041000B00033Q00122Q000C0025062Q00122Q000D0026065Q000B000D000200122Q000C0045025Q000A000B000C4Q000A00033Q00122Q000B0027062Q00122Q000C0028065Q000A000C6Q000A5Q00044Q00E71B01000426012Q00011C01000426012Q00DF1B0100126C000300AD012Q000426012Q00041C01000426012Q006B1B0100126C00070029062Q00126C00080023032Q0006C6000700AC1C010008000426012Q00AC1C0100126C0007003B3Q0006ED000300AC1C010007000426012Q00AC1C0100126C0007000A3Q00126C0008002A062Q00126C0009002B062Q00068F010800511C010009000426012Q00511C0100126C0008003B3Q0006ED000700511C010008000426012Q00511C012Q007B000800374Q003301080001000200067C0008001B1C010001000426012Q001B1C0100126C0008002C062Q00126C0009002D062Q00068F0108004F1C010009000426012Q004F1C0100126C0008000A3Q00126C0009002E062Q00126C000A002F062Q00068F010900311C01000A000426012Q00311C0100126C000900AB052Q00126C000A0030062Q0006C6000A00311C010009000426012Q00311C0100126C0009003B3Q0006ED000800311C010009000426012Q00311C012Q007B000900013Q0020CF0009000900044Q000A00023Q00202Q000A000A00054Q0009000200014Q000900033Q00122Q000A0031062Q00122Q000B0032065Q0009000B6Q00095Q00126C00090033062Q00126C000A0034062Q0006C6000A002Q1C010009000426012Q002Q1C0100126C0009000A3Q0006ED0008002Q1C010009000426012Q002Q1C012Q007B000900384Q00C80009000100024Q000900153Q00122Q000900C73Q00122Q000A0035062Q00062Q0009004D1C01000A000426012Q004D1C012Q007B000900153Q00067C000900461C010001000426012Q00461C0100126C00090036062Q00126C000A0037062Q00068F010A004D1C010009000426012Q004D1C012Q007B000900033Q001285000A0038062Q00122Q000B0039065Q0009000B00024Q000A00156Q00090009000A4Q000900023Q00126C0008003B3Q000426012Q002Q1C0100126C0003003D042Q000426012Q00AC1C0100126C000800FB3Q00126C0009003A062Q00068F0108000C1C010009000426012Q000C1C0100126C0008003B062Q00126C0009003C062Q0006C60009000C1C010008000426012Q000C1C0100126C0008000A3Q0006ED0007000C1C010008000426012Q000C1C012Q007B000800153Q00067C000800631C010001000426012Q00631C0100126C0008008B032Q00126C0009003D062Q0006C60009006A1C010008000426012Q006A1C012Q007B000800033Q0012850009003E062Q00122Q000A003F065Q0008000A00024Q000900156Q0008000800094Q000800024Q007B00085Q0020410108000800B04Q000A00016Q000B00016Q0008000B000200062Q000800841C010001000426012Q00841C012Q007B00085Q0020AB0108000800334Q000A00023Q00202Q000A000A00B14Q0008000A000200062Q000800841C010001000426012Q00841C012Q007B00085Q00200C0108000800334Q000A00023Q00122Q000B0040065Q000A000A000B4Q0008000A000200062Q000800841C010001000426012Q00841C0100126C00080041062Q00126C00090042062Q0006C6000800AA1C010009000426012Q00AA1C0100126C0008000A4Q003A000900093Q00126C000A000A3Q0006ED000800861C01000A000426012Q00861C0100126C0009000A3Q00126C000A0043062Q00126C000B0044062Q00068F010A008A1C01000B000426012Q008A1C0100126C000A000A3Q000623010900951C01000A000426012Q00951C0100126C000A0045062Q00126C000B0016022Q0006C6000B008A1C01000A000426012Q008A1C012Q007B000A00354Q0033010A000100022Q00CA000A00154Q007B000A00153Q00067C000A009F1C010001000426012Q009F1C0100126C000A00C9022Q00126C000B0046062Q0006C6000B00AA1C01000A000426012Q00AA1C012Q007B000A00033Q001285000B0047062Q00122Q000C0048065Q000A000C00024Q000B00156Q000A000A000B4Q000A00023Q000426012Q00AA1C01000426012Q008A1C01000426012Q00AA1C01000426012Q00861C0100126C0007003B3Q000426012Q000C1C0100126C000700AD012Q000623010300B31C010007000426012Q00B31C0100126C00070049062Q00126C0008004A062Q00068F010700E01D010008000426012Q00E01D0100126C0007004B062Q00126C0008004C062Q0006C6000800081D010007000426012Q00081D012Q007B000700024Q00FE000800033Q00122Q0009004D062Q00122Q000A004E065Q0008000A00024Q00070007000800122Q000900CD035Q0007000700094Q00070002000200062Q000700081D013Q000426012Q00081D012Q007B0007002E4Q0039000800033Q00122Q0009004F062Q00122Q000A0050065Q0008000A00024Q0007000700084Q000800033Q00122Q00090051062Q00122Q000A0052065Q0008000A00024Q0007000700084Q000800033Q00122Q00090053062Q00122Q000A0054065Q0008000A00024Q00070007000800062Q000700081D013Q000426012Q00081D012Q007B000700314Q0033010700010002000657010700081D013Q000426012Q00081D012Q007B000700233Q0020A60007000700BC4Q000900023Q00122Q000A0099055Q00090009000A4Q00070009000200062Q000700081D013Q000426012Q00081D0100126C00070055062Q00126C00080056062Q00068F010700081D010008000426012Q00081D012Q007B000700013Q0020210107000700044Q000800023Q00122Q00090057065Q0008000800094Q00070002000200062Q000700081D013Q000426012Q00081D0100126C0007000A4Q003A000800083Q00126C0009000A3Q0006ED000700EE1C010009000426012Q00EE1C0100126C0008000A3Q00126C0009000A3Q000623010800F91C010009000426012Q00F91C0100126C00090058062Q00126C000A0059062Q00068F010A00F21C010009000426012Q00F21C012Q007B000900014Q0041000A00033Q00122Q000B005A062Q00122Q000C005B065Q000A000C000200122Q000B005C065Q0009000A000B4Q000900033Q00122Q000A005D062Q00122Q000B005E065Q0009000B6Q00095Q00044Q00F21C01000426012Q00081D01000426012Q00EE1C0100126C0007005F062Q00126C00080060062Q00068F0108006E1D010007000426012Q006E1D012Q007B000700024Q00FE000800033Q00122Q00090061062Q00122Q000A0062065Q0008000A00024Q00070007000800122Q000900CD035Q0007000700094Q00070002000200062Q0007006E1D013Q000426012Q006E1D012Q007B0007002E4Q0039000800033Q00122Q00090063062Q00122Q000A0064065Q0008000A00024Q0007000700084Q000800033Q00122Q00090065062Q00122Q000A0066065Q0008000A00024Q0007000700084Q000800033Q00122Q00090067062Q00122Q000A0068065Q0008000A00024Q00070007000800062Q0007006E1D013Q000426012Q006E1D012Q007B000700314Q00330107000100020006570107006E1D013Q000426012Q006E1D012Q007B000700233Q0012A9010900D0035Q00070007000900122Q000900586Q00070009000200062Q0007006E1D013Q000426012Q006E1D012Q007B000700013Q0020E50007000700044Q000800023Q00122Q00090053025Q0008000800094Q000900096Q00070009000200062Q000700411D010001000426012Q00411D0100126C00070069062Q00126C0008006A062Q00068F0107006E1D010008000426012Q006E1D0100126C0007000A4Q003A000800083Q00126C0009000A3Q0006230107004A1D010009000426012Q004A1D0100126C0009006B062Q00126C000A00E9032Q0006C6000A00431D010009000426012Q00431D0100126C0008000A3Q00126C0009000A3Q000623010800521D010009000426012Q00521D0100126C0009006C062Q00126C000A006D062Q0006C6000A004B1D010009000426012Q004B1D0100126C0009000A3Q00126C000A006E062Q00126C000B006E062Q0006ED000A00531D01000B000426012Q00531D0100126C000A000A3Q0006230109005E1D01000A000426012Q005E1D0100126C000A006F062Q00126C000B0070062Q0006ED000A00531D01000B000426012Q00531D012Q007B000A00014Q0041000B00033Q00122Q000C0071062Q00122Q000D0072065Q000B000D000200122Q000C0058025Q000A000B000C4Q000A00033Q00122Q000B0073062Q00122Q000C0074065Q000A000C6Q000A5Q00044Q00531D01000426012Q004B1D01000426012Q006E1D01000426012Q00431D012Q007B000700024Q00FE000800033Q00122Q00090075062Q00122Q000A0076065Q0008000A00024Q00070007000800122Q000900CD035Q0007000700094Q00070002000200062Q000700961D013Q000426012Q00961D012Q007B0007002E4Q0039000800033Q00122Q00090077062Q00122Q000A0078065Q0008000A00024Q0007000700084Q000800033Q00122Q00090079062Q00122Q000A007A065Q0008000A00024Q0007000700084Q000800033Q00122Q0009007B062Q00122Q000A007C065Q0008000A00024Q00070007000800062Q000700961D013Q000426012Q00961D012Q007B000700314Q0033010700010002000657010700961D013Q000426012Q00961D012Q007B000700233Q00126C000900D0033Q004001070007000900126C000900584Q00A801070009000200067C0007009A1D010001000426012Q009A1D0100126C00070043042Q00126C0008007D062Q0006C6000800DF1D010007000426012Q00DF1D012Q007B000700013Q0020E50007000700044Q000800023Q00122Q00090063025Q0008000800094Q000900096Q00070009000200062Q000700AB1D010001000426012Q00AB1D0100126C0007007E062Q00126C0008007F062Q0006920107000500010008000426012Q00AB1D0100126C00070080062Q00126C0008006D042Q0006C6000700DF1D010008000426012Q00DF1D0100126C0007000A4Q003A000800083Q00126C0009000A3Q000623010700B81D010009000426012Q00B81D0100126C00090081062Q00126C000A0082062Q000638010900B81D01000A000426012Q00B81D0100126C000900CA042Q00126C000A0083062Q0006C6000A00AD1D010009000426012Q00AD1D0100126C0008000A3Q00126C0009000A3Q0006ED000800B91D010009000426012Q00B91D0100126C0009000A4Q003A000A000A3Q00126C000B000A3Q0006ED000900BE1D01000B000426012Q00BE1D0100126C000A000A3Q00126C000B0084062Q00126C000C0085062Q00068F010B00C21D01000C000426012Q00C21D0100126C000B0057052Q00126C000C0086062Q0006C6000B00C21D01000C000426012Q00C21D0100126C000B000A3Q0006ED000A00C21D01000B000426012Q00C21D012Q007B000B00014Q0041000C00033Q00122Q000D0087062Q00122Q000E0088065Q000C000E000200122Q000D0070025Q000B000C000D4Q000B00033Q00122Q000C0089062Q00122Q000D008A065Q000B000D6Q000B5Q00044Q00C21D01000426012Q00B91D01000426012Q00BE1D01000426012Q00B91D01000426012Q00DF1D01000426012Q00AD1D0100126C00030073052Q00126C0007008B062Q00126C0008008C062Q00068F010700E71D010008000426012Q00E71D0100126C00070073052Q000623010300EB1D010007000426012Q00EB1D0100126C0007008D062Q00126C0008008E062Q0006C6000800D11A010007000426012Q00D11A0100126C0007008F062Q00126C00080090062Q00068F010700571E010008000426012Q00571E012Q007B000700024Q00FE000800033Q00122Q00090091062Q00122Q000A0092065Q0008000A00024Q00070007000800122Q000900CD035Q0007000700094Q00070002000200062Q000700571E013Q000426012Q00571E012Q007B000700233Q0020A60007000700BC4Q000900023Q00122Q000A00D4035Q00090009000A4Q00070009000200062Q000700571E013Q000426012Q00571E012Q007B000700233Q0020AC0007000700B22Q007B000900064Q00A801070009000200067C000700571E010001000426012Q00571E012Q007B00075Q0020410107000700B04Q000900016Q000A00016Q0007000A000200062Q000700571E010001000426012Q00571E012Q007B000700103Q00126C000800853Q00068F010700571E010008000426012Q00571E012Q007B000700093Q00126C0008003B3Q0006920108000500010007000426012Q001B1E012Q007B0007000E3Q00126C00080093062Q0006C6000700571E010008000426012Q00571E012Q007B000700013Q0020230007000700044Q000800023Q00122Q000900D4035Q0008000800094Q00070002000200062Q000700271E010001000426012Q00271E0100126C00070094062Q00126C00080095062Q0006C6000700571E010008000426012Q00571E0100126C0007000A4Q003A000800083Q00126C0009000A3Q0006ED000900291E010007000426012Q00291E0100126C0008000A3Q00126C00090096062Q00126C000A0097062Q00068F010A002D1E010009000426012Q002D1E0100126C0009000A3Q0006ED0008002D1E010009000426012Q002D1E0100126C0009000A4Q003A000A000A3Q00126C000B0098062Q00126C000C0099062Q0006C6000C00361E01000B000426012Q00361E0100126C000B000A3Q0006ED000900361E01000B000426012Q00361E0100126C000A000A3Q00126C000B000A3Q000623010A00451E01000B000426012Q00451E0100126C000B009A062Q00126C000C009B062Q0006C6000C003E1E01000B000426012Q003E1E012Q007B000B00014Q0041000C00033Q00122Q000D009C062Q00122Q000E009D065Q000C000E000200122Q000D00F1035Q000B000C000D4Q000B00033Q00122Q000C009E062Q00122Q000D009F065Q000B000D6Q000B5Q00044Q003E1E01000426012Q002D1E01000426012Q00361E01000426012Q002D1E01000426012Q00571E01000426012Q00291E012Q007B000700233Q00200C0107000700BC4Q000900023Q00122Q000A00A0065Q00090009000A4Q00070009000200062Q000700A31E010001000426012Q00A31E012Q007B000700013Q001259000800A1065Q0007000700084Q000800023Q00202Q0008000800054Q00098Q000A00033Q00122Q000B00A2062Q00122Q000C00A3065Q000A000C6Q00073Q0002000657010700D61E013Q000426012Q00D61E0100126C0007000A4Q003A000800083Q00126C000900A4062Q00126C000A00A5062Q00068F010A00751E010009000426012Q00751E0100126C0009000A3Q000623010700791E010009000426012Q00791E0100126C00090099012Q00126C000A00A6062Q0006C6000A006E1E010009000426012Q006E1E0100126C0008000A3Q00126C0009000A3Q000623010900811E010008000426012Q00811E0100126C000900A7062Q00126C000A00A8062Q0006C6000A007A1E010009000426012Q007A1E0100126C0009000A3Q00126C000A008B062Q00126C000B008B062Q0006ED000A00821E01000B000426012Q00821E0100126C000A000A3Q0006ED000900821E01000A000426012Q00821E0100126C000A000A3Q00126C000B00A9062Q00126C000C00AA062Q00068F010B008A1E01000C000426012Q008A1E0100126C000B000A3Q0006ED000A008A1E01000B000426012Q008A1E012Q007B000B00014Q0041000C00033Q00122Q000D00AB062Q00122Q000E00AC065Q000C000E000200122Q000D00AD065Q000B000C000D4Q000B00033Q00122Q000C00AE062Q00122Q000D00AF065Q000B000D6Q000B5Q00044Q008A1E01000426012Q00821E01000426012Q007A1E01000426012Q00D61E01000426012Q006E1E01000426012Q00D61E0100126C000700B0062Q00126C000800C6022Q0006C6000800D61E010007000426012Q00D61E012Q007B000700013Q0020470107000700044Q000800023Q00202Q0008000800054Q00070002000200062Q000700D61E013Q000426012Q00D61E0100126C0007000A4Q003A000800083Q00126C0009000A3Q0006ED000700B01E010009000426012Q00B01E0100126C0008000A3Q00126C0009000A3Q000623010800BB1E010009000426012Q00BB1E0100126C000900AE052Q00126C000A00B1062Q0006C6000A00B41E010009000426012Q00B41E0100126C0009000A3Q00126C000A000A3Q0006ED000900BC1E01000A000426012Q00BC1E0100126C000A000A3Q00126C000B000A3Q0006ED000A00C01E01000B000426012Q00C01E012Q007B000B00014Q0041000C00033Q00122Q000D00B2062Q00122Q000E00B3065Q000C000E000200122Q000D00AD065Q000B000C000D4Q000B00033Q00122Q000C00B4062Q00122Q000D00B5065Q000B000D6Q000B5Q00044Q00C01E01000426012Q00BC1E01000426012Q00B41E01000426012Q00D61E01000426012Q00B01E01000426012Q00D61E01000426012Q00D11A012Q0045012Q00013Q00048Q00034Q00773Q00014Q00303Q00024Q0045012Q00017Q00013Q00029Q00074Q007B7Q000E4A2Q01000400013Q000426012Q000400012Q007A8Q00773Q00014Q00303Q00024Q0045012Q00019Q003Q00034Q00773Q00014Q00303Q00024Q0045012Q00017Q00013Q00029Q00074Q007B7Q000E4A2Q01000400013Q000426012Q000400012Q007A8Q00773Q00014Q00303Q00024Q0045012Q00017Q00043Q00028Q0003143Q0052657475726E496E697469616C4D652Q73616765025Q0040704003113Q0052657365744F70656E6572416E642Q4F4300133Q00126C3Q00014Q003A000100013Q0026AB3Q000200010001000426012Q0002000100126C000100013Q0026AB0001000500010001000426012Q000500012Q007B00025Q00200D00020002000200122Q000300036Q0002000200014Q00025Q00202Q0002000200044Q00020001000100044Q00120001000426012Q00050001000426012Q00120001000426012Q000200012Q0045012Q00017Q00063Q00025Q0098B14003103Q00CBFF4C506070CAF257507E7AFAFB4B5103063Q001E999A382512028Q0003103Q002FBCE31929138AFF032E11BDF40D280903053Q005B7DD9976C00153Q002E042Q01000D00010001000426012Q000D00012Q007B8Q001F2Q0100013Q00122Q000200023Q00122Q000300036Q0001000300028Q000100264Q000D00010004000426012Q000D000100126C3Q00044Q00303Q00023Q000426012Q001400012Q007B8Q00B4000100013Q00122Q000200053Q00122Q000300066Q0001000300028Q00016Q00024Q0045012Q00017Q00053Q0003123Q00CB16B265CCF73EA943D6F606AA74DDF800B203053Q00BE9973C610028Q0003123Q00087EBE92287587880973A592367FA986296F03043Q00E75A1BCA00134Q007B8Q001F2Q0100013Q00122Q000200013Q00122Q000300026Q0001000300028Q000100264Q000B00010003000426012Q000B000100126C3Q00034Q00303Q00023Q000426012Q001200012Q007B8Q00B4000100013Q00122Q000200043Q00122Q000300056Q0001000300028Q00016Q00024Q0045012Q00017Q00", GetFEnv(), ...);

