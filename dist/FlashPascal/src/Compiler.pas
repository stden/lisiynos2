unit Compiler;

interface

{$I FlashPascal.inc}

uses
 SysUtils { StrToFloat }, {$IFDEF SHELL}Windows, ShellAPI,{$ENDIF}
 Global, Parser, SWF, Deflate;

type
 TExpression = class
   code : string;
   kind : TSymbol;
   procedure Add(ex: TExpression);
   procedure Sub(ex: TExpression);
   procedure _Or(ex: TExpression);
   procedure _And(ex: TExpression);
   procedure MulBy(ex: TExpression);
   procedure DivBy(ex: TExpression);
   procedure Modulo(ex: TExpression);
   procedure Divide(ex: TExpression);
   procedure IsEqual(ex: TExpression);
   procedure IsGreater(ex: TExpression);
   procedure IsGreaterOrEqual(ex: TExpression);
   procedure IsLesser(ex: TExpression);
   procedure IsLesserOrEqual(ex: TExpression);
   procedure Negate;
  {$IFDEF MEMCHECK}
   constructor Create;
   destructor Destroy; override;
  {$ENDIF}
 end;

 TArray=class(TSymbol)
  _open : boolean;
  _low  : integer;
  _high : integer;
  _kind : TSymbol;
 end;

 TInstance=record
  code  : string;
  kind  : TSymbol;
  getter: string;
  setter: string;
 end;

 TUserClass=class(TClass)
  init      : string;
  function InheritedConstructor: TMethod;
 end;

 TBaseType=class(TSymbol)
 end;

 TPrototype=class(TFunction)
  OfObject:boolean;   // function prototype only
 end;

 TCompiler=class;

 TUses=class
   Source : TCompiler;
   Next   : TUses;
 end;

 TCompiler=class(TParser)
 private
   FName : string;
   FNext : TCompiler; // Linked list of source code
   FUses : TUses;
   function ColorMap(const AFileName:string; var AWidth,AHeight:integer):string;
   procedure AddBitmapResource;
   procedure CompilerSwitch(StopToken:TToken);
   function Expression:TExpression;
   function Expression1:TExpression;
   function Expression2:TExpression;
   function Expression3:TExpression;
   procedure VarSuffix(ex:TExpression);
   function GetArray:TArray;
   function GetType:TSymbol;
   function DeclareVar(Owner:TSymbol; var Symbols:TSymbol):string;
   function GetParam(Func:TFunction; Prev:TParameter):TParameter;
   function GetMethod(AClass:TClass; void:boolean):TMethod;
   procedure ConstructorAlias(m:TMethod);
   procedure GetProperty(AClass:TClass);
   procedure ExternalFlashClass(const ClassName, SymbolName:string);
   procedure DefineUserClass(const name,symbol:string);
   procedure FunctionPrototype(const name:string; void:boolean);
   procedure DeclareType;
   procedure DeclareConst;
   function DropVariable: TVariable;
   function PushString: string;
   function PushInteger: string;
   function PushDouble: string;
   procedure VarInstance(variable: TVariable; var Instance: TInstance);
   function GetVariable(Variable: TVariable): string;
   function PushBoolean: string;
   procedure GetInstance(var Instance: TInstance);
   function GetSymbol(List: TSymbol): TSymbol;
   function InheritedSymbol(AClass: TClass): TSymbol;
   function ClassSymbol(AClass: TClass): TSymbol;
   function PushInstance: string;
   function PushMethod: string;
   function PushArray(A: TArray): string;
   function PushKind(Kind: TSymbol): string;
   function CallConstructor(ACreate: TMethod): string;
   function CallFunction(method: TMethod): string;
   function PushParams(Param: TParameter): string;
   function ConstructClass(aclass: TClass): string;
   function AssignStatement(Kind: TSymbol): string;
   function SetProperty(const instance: string; prop: TProperty): string;
   function CallMethod(const instance: string; method: TMethod): string;
   function InstanceSuffix(var instance: TInstance): string;
   function VariableSuffix: string;
   function ParameterSuffix: string;
   function PropertySuffix: string;
   function IfStatement: string;
   function ForStatement: string;
   function CallThisMethod: string;
   function NextCase(Kind: TSymbol): string;
   function CaseStatement: string;
   function RepeatStatement: string;
   function WhileStatement: string;
   function SortStatement: string;
   function Statement: string;
   procedure DropParams(Param: TParameter);
   function MethodCall(AClass: TClass; AMethod: TMethod): string;
   function IsFlashClass(AClass: TClass): boolean;
   function IsConstructor(Symbol: TSymbol): boolean;
   function DeclareConstructor(AClass: TClass): string;
   function DefineConstructor: string;
   function DefineMethod: string;
   function StaticMethod(void: boolean): string;
   function CheckClass(AClass: TUserClass): string;
   function CheckClasses: string;
   function GetArrayIndex(var Kind: TSymbol): string;
   function GetClass: TClass;
   procedure AddUses;
   procedure CompileUnit(const Name:string);
   procedure UnitInterface(const Name:string);
 public
   procedure NextToken; override;
   procedure Compile;
   destructor Destroy; override;
 end;

var
  Path : string;

  _Root     :TVariable; // hidden symbol
  _String   :TSymbol;   // Flash String
  _Integer  :TSymbol;   // base type integer
  _Double   :TSymbol;   // base type double
  _Boolean  :TSymbol;   // base type boolean
  _Object   :TSymbol;

  FlashVersion:byte;
  FrameWidth  :word; // SWF frame properties
  FrameHeight :word;
  FrameRate   :byte;
  Background  :cardinal; // Frame background

  Resources   :string;
  ResourceID  :integer;

  Anonyms   :TSymbol;
  Variable  :TVariable absolute Symbol;
  Parameter :TParameter absolute Symbol;

// linked list of all compilers
  Sources : TCompiler = nil;

implementation

type
 TBMPHeader=packed record
  bfType:array[1..2] of char;
  bfSize:LongInt;
  bfReserved:LongInt;
  bfOffBits:LongInt;
  biSize:LongInt;
  biWidth:LongInt;
  biHeight:LongInt;
  biPlanes:word;
  biBitCount:word;
  biCompression:longint;
  biSizeImage:longint;
  biXPelsPerMeter:longint;
  biYPelsPerMeter:longint;
  biClrUsed:Longint;
  biClrImportant:longint;
 end;

 TBMPColors=packed array[0..255,0..3] of byte;

procedure Error(const Msg:string);
begin
 WriteLn(Msg);
 ReadLn;
 Halt;
end;

function IsNumber(Symbol:TSymbol):boolean;
begin
 Result:=(Symbol=_Integer)or(Symbol=_Double);
end;

function GetParameter(Parameter:TParameter):string;
begin
 Result:={$IFDEF REG_PARAM}SWFGetRegister(Parameter.Reg){$ELSE}SWFGetVariable(Parameter.realName){$ENDIF};
end;

function GetThis:string;
begin
 Result:={$IFDEF REG_THIS}SWFGetRegister(1){$ELSE}SWFGetVariable('this'){$ENDIF};
end;

function SetThis(value:string):string;
begin
 {$IFDEF REG_THIS}
  Result:=value+SWFSetRegister(1)+acPop;
 {$ELSE}
  Result:=SWFPushString('this')+value+acSetVariable;
 {$ENDIF}
end;

function SetVariable(Variable:TVariable; const Value:string):string;
begin
{$IFDEF REG_VARS}
 if Variable.Reg=0 then begin
{$ENDIF}
  Result:=SWFOptimize(
           SWFPushString(Variable.realName)
          +Value
          +acSetVariable
          );
{$IFDEF REG_VARS}
 end else begin
  Result:=SWFOptimize(Value)
          +SWFSetRegister(Variable.Reg)
          +acPop;
 end;
{$ENDIF}
end;

function DeclareFunction(Method:TMethod; const name:string):string;
var
 s:string;
 p:TParameter;
 ss:string;
begin
 s:=name+#0
   +SWFshort(Method.count)
   +chr(Method.regs)
   +SWFShort(FLAG_7);
 p:=Method.params;
 ss:='';
 while p<>nil do begin
  ss:={$IFDEF REG_PARAM}chr(p.Reg){$ELSE}#0{$ENDIF}+p.realName+#0+ss;
  p:=p.NextParam;
 end;
 s:=s+ss+SWFshort(length(Method.code));

 Result:=acDeclareFunction7
        +SWFshort(Length(s))
        +s
        +Method.code;

end;


{ TExpresion }

{$IFDEF MEMCHECK}
constructor TExpression.Create;
begin
 inc(eCount);
end;

destructor TExpression.Destroy;
begin
 dec(eCount);
end;
{$ENDIF}

procedure TExpression.Add(ex:TExpression);
begin
 if Kind=_String then begin
  if (ex.Kind=_String) then begin
   code:=code+ex.Code+acConcat;
   ex.Free;
  end else begin
   Error('string concat error');
  end;
 end else
 if IsNumber(Kind) and IsNumber(ex.Kind) then begin
  code:=code+ex.Code+acAdd;
  ex.Free;
 end else
  Error('Add error');
end;

procedure TExpression.Sub(ex:TExpression);
begin
 if IsNumber(Kind) and IsNumber(ex.Kind) then begin
  code:=code+ex.Code+acSubstract;
  ex.Free;
 end else
  Error('Sub error');
end;

procedure TExpression._Or(ex:TExpression);
begin
 if IsNumber(Kind) and IsNumber(ex.Kind) then begin
  code:=code+ex.Code+acBitwiseOr;
  ex.Free;
 end else
 if (Kind=_Boolean) and (ex.kind=_Boolean) then begin
  code:=code+ex.Code+acLogicalOr;
  ex.Free;
 end else
  Error('Sub error');
end;

procedure TExpression._And(ex:TExpression);
begin
 if IsNumber(Kind) and IsNumber(ex.Kind) then begin
  code:=code+ex.Code+acBitwiseAnd;
  ex.Free;
 end else
 if (Kind=_Boolean) and (ex.kind=_Boolean) then begin
  code:=code+ex.Code+acLogicalAnd;
  ex.Free;
 end else
  Error('Sub error');
end;

procedure TExpression.MulBy(ex:TExpression);
begin
 if not IsNumber(kind) then Error('Number expected');
 if not IsNumber(ex.Kind) then Error('Number expected');
 code:=code+ex.Code+acMultiply;
 if (ex.Kind=_Double) then Kind:=_Double;
 ex.Free;
end;

procedure TExpression.DivBy(ex:TExpression);
begin
 if (kind<>_Integer)or(ex.kind<>_Integer) then Error('Integer expected');
 code:=code+ex.Code+acDivide+acIntegralPart;
 ex.Free;
end;

procedure TExpression.Modulo(ex:TExpression);
begin
 if (kind<>_Integer)or(ex.kind<>_Integer) then Error('Integer expected');
 code:=code+ex.Code+acModulo;
 ex.Free;
end;

procedure TExpression.Divide(ex:TExpression);
begin
 if not IsNumber(Kind) then Error('Number expected');
 if not IsNumber(ex.Kind) then Error('Number expected');
 code:=code+ex.Code+acDivide;
 kind:=_Double;
 ex.Free;
end;

procedure TExpression.IsEqual(ex:TExpression);
begin
 if Kind<>ex.kind then Error('type mismatch');
 code:=code+ex.code+acEqual;
 kind:=_Boolean;
 ex.Free;
end;

procedure TExpression.IsGreater(ex:TExpression);
begin
 if IsNumber(Kind) then begin
  if not IsNumber(ex.Kind) then Error('incompatible types');
 end else begin
  if Kind<>ex.kind then Error('type mismatch');
 end;
 code:=code+ex.code+acGreaterThan;
 kind:=_Boolean;
 ex.Free;
end;

procedure TExpression.IsGreaterOrEqual(ex:TExpression);
begin
 if IsNumber(Kind) then begin
  if not IsNumber(ex.Kind) then Error('incompatible types');
 end else begin
  if Kind<>ex.kind then Error('type mismatch');
 end;
 code:=code+ex.code+acLessThan+acLogicalNot;
 kind:=_Boolean;
 ex.Free;
end;

procedure TExpression.IsLesser(ex:TExpression);
begin
 if IsNumber(Kind) then begin
  if not IsNumber(ex.Kind) then Error('incompatible types');
 end else begin
  if Kind<>ex.kind then Error('type mismatch');
 end;
 code:=code+ex.code+acLessThan;
 kind:=_Boolean;
 ex.Free;
end;

procedure TExpression.IsLesserOrEqual(ex:TExpression);
begin
 if IsNumber(Kind) then begin
  if not IsNumber(ex.Kind) then Error('incompatible types');
 end else begin
  if Kind<>ex.kind then Error('type mismatch');
 end;
 code:=code+ex.code+acGreaterThan+acLogicalNot;
 kind:=_Boolean;
 ex.Free;
end;

procedure TExpression.Negate;
var
 i:integer;
begin
 if not IsNumber(Kind) then Error('Number expected');
 // have we push a constant integer ?
 if (Length(Code)=8)and(copy(code,1,4)=#$96#$05#$00#$07) then begin
  move(code[5],i,4);
  i:=-i;
  move(i,code[5],4);
 end else begin
  code:=SWFPushInteger(0)+code+acSubstract;
 end;
end;

{ TUserClass }

function TUserClass.InheritedConstructor:TMethod;
var
 base  :TClass;
 create:TMethod;
 s     :string;
 pp    :^TParameter;
 pi    :TParameter;
 p     :TParameter;
 s1    :string;
 s2    :string;
begin
 base:=Self;
 create:=base._constructor;
 while create=nil do begin
  base:=base._inherite;
  if base=nil then Error('TObject constructor');
  create:=base._constructor;
 end;
 Result:=TMethod.Create;
 Result.Owner:=Self;
 Result.name:=create.name;
 Result.realName:=Self.realName+'$'+create.realName;
 Result.count:=create.Count;
 Result.regs:=2;

 pp:=@Result.params;
 pi:=create.params;
 while pi<>nil do begin
  p:=pi.Clone;
  p.Reg:=Result.regs;
  inc(Result.regs);
  pp^:=p;
  pp:=@p.NextParam;
  pi:=pi.NextParam;
 end;

 s:='';
 if create.alias<>'' then begin
 // push parameters
  p:=Result.params;
  while p<>nil do begin
  {$IFDEF REG_PARAM}
   inc(p.Reg);
  {$ENDIF}
   s:=s+GetParameter(p);
   p:=p.NextParam;
  end;
  s:=s+SWFPushInteger(Result.Count-1); // ignore the "Parent" parameter in Count
 // add Parent parameter for this constructor
  p:=create.Parent.Clone;
  p.Reg:=2;//Result.regs;
  inc(Result.regs);
  pp^:=p;

  s2:=SWFGetVariable('_root');
  s1:=GetParameter(p)
      +Branch(Length(s2));

  s:=SWFOptimize(s
     +GetParameter(p)
     +SWFPushInteger(0)
    )
    +acEqual
    +BranchIfEq(Length(s1))
    +s1
    +s2
    +SWFCallMethod(create.alias);
 end else begin
  Error('inherited Create');
 end;

 Result.code:=SetThis(s)
             +Self.init
             +GetThis
             +acReturn;
 Result.NextSymbol:=Self._symbols;
 Self._symbols:=Result;
end;

{ TCompiler }

function TCompiler.ColorMap(const AFileName:string; var AWidth,AHeight:integer):string;
var
 f     :file;
 header:TBMPHeader;
 Colors:TBMPColors;
 Count :integer;
 Size  :integer;
 i,x   :integer;
 width :integer;
begin
 AssignFile(f,AFileName);
 Reset(f,1);
 try
  BlockRead(f,header,SizeOf(header));

  if header.bfType<>'BM' then Error('not a valid bitmap file '+AFileName);
  if header.biBitCount<>8 then Error('not a 256 colors bitmap '+AFilename);

  Count:=header.biClrUsed;
  if Count=0 then Count:=256;
  BlockRead(f,Colors,4*Count);

  Seek(f,header.bfOffBits);

  AWidth:=header.biWidth;
  AHeight:=header.biHeight;

  width:=(header.biWidth+3) and (not 3);
  Size:=width*header.biHeight;
  SetLength(Result,3*Count+Size);
  x:=1;
  for i:=0 to Count-1 do begin
   Result[x]:=chr(Colors[i,2]); inc(x);
   Result[x]:=chr(Colors[i,1]); inc(x);
   Result[x]:=chr(Colors[i,0]); inc(x);
  end;
  x:=Length(Result)+1;
  for i:=0 to header.biHeight-1 do begin
   dec(x,width);
   BlockRead(f,Result[x],header.biWidth);
  end;

  Result:=#3  // RGB with colormap
         +SWFshort(header.biWidth)
         +SWFshort(header.biHeight)
         +chr(Count-1)
         +zCompressStr(Result);

 finally
  CloseFile(f);
 end;

end;

procedure TCompiler.AddBitmapResource;
var
 name:string;
 data:string;
 w,h :integer;
begin
 name:=SrcToken; DropToken(tk_Ident);
 data:=Token; DropToken(tk_String);
 data:=SWFlhead(20, // DefineBitsLossLess
        SWFshort(ResourceID+1)
       +ColorMap(data,w,h)
       );
 data:=data
       +SWFdefineshape(
         0,0,20*w,20*h,
	 1,SWFFillStyleBitmap(ResourceID+1),
         0,'',
         SWFShapeBox(0,0,20*w,20*h,1),
         ResourceID+2
        );
        //+SWFPlaceObject(ResourceID+2,word(-1));

 inc(ResourceID,2);
 Resources:=Resources+Data;
end;

// deal with Frame properties
procedure TCompiler.CompilerSwitch(StopToken:TToken);
var
 s:string;
 switch:(sFrameWidth,sFrameHeight,sFrameRate,sBackground,sVersion,sBitmap);
 b:integer;
begin
 s:='';
 while upcase(NextChar) in ['A'..'Z','_'] do s:=s+upcase(ReadChar);
 if s='FRAME_WIDTH'  then switch:=sFrameWidth  else
 if s='FRAME_HEIGHT' then switch:=sFrameHeight else
 if s='FRAME_RATE'   then switch:=sFrameRate   else
 if s='BACKGROUND'   then switch:=sBackground  else
 if s='VERSION'      then switch:=sVersion     else
 if s='BITMAP'       then switch:=sBitmap      else
  error('Unknow switch '+s);
 GetToken;
 if switch=sBitmap then begin
  AddBitmapResource;
 end else
 begin
  if TokenType<>tk_Number then Error('Integer expected');
  b:=BitsCount(Token);
  if switch=sBackground then begin
   if b>32  then Error('Ordinal overflow');
  end else
  if switch in [sFrameRate,sVersion] then begin
   if b>8  then Error('Byte overflow');
  end else begin
   if b>16 then Error('Word overflow');
  end;
  case switch of
   sFrameWidth  : FrameWidth  :=StrToInt(Token);
   sFrameHeight : FrameHeight :=StrToInt(Token);
   sFrameRate   : FrameRate   :=StrToInt(Token);
   sBackground  : Background  :=StrToInt(Token);
   sVersion     : FlashVersion:=StrToInt(Token);
  end;
  GetToken;
 end;
 DropToken(StopToken);
end;

procedure TCompiler.NextToken;
begin
 inherited;
 if TokenType=tk_Switch1 then CompilerSwitch(tk_RComment1);
end;

function TCompiler.GetArrayIndex(var Kind:TSymbol):string;
begin
 Result:=PushInteger;
 Kind:=TArray(Kind)._kind;
 while Kind is TArray do begin
  DropToken(tk_Comma);
  with TArray(Kind) do
   Result:=Result+SWFPushInteger(1+_high-_low)+acMultiply+PushInteger+acAdd;
  Kind:=TArray(Kind)._kind;
 end;
end;

procedure TCompiler.VarSuffix(ex:TExpression);
var
 s:TSymbol;
begin
 while TokenType in [tk_Dot,tk_LBracket] do begin
  if SkipToken(tk_Dot) then begin
   if not (ex.Kind is TClass) then Error('Class expected');
   s:=ClassSymbol(ex.Kind as TClass);
   if s is TVariable then begin
    ex.code:=ex.code+SWFPushString(s.realName)+acGetMember;
    ex.kind:=TVariable(s).Kind;
   end else
   if s is TProperty then begin
    ex.code:=ex.code+SWFPushString(s.realName)+acGetMember;
    ex.kind:=TProperty(s).Kind;
   end else
   if s is TMethod then begin
    ex.code:=CallMethod(ex.code,TMethod(s));
    ex.kind:=TMethod(s).Kind;
   end else
    Error('VarSuffix '+s.className);
  end else begin
   DropToken(tk_LBracket);
   if not (ex.Kind is TArray) then Error('Array expected');
   ex.code:=ex.code+GetArrayIndex(ex.Kind)+acGetMember;
   DropToken(tk_RBracket);
  end;
 end;
end;


function TCompiler.Expression1:TExpression;
var
 e:TExpression;
 m:TMethod;
begin
 if SkipToken(tkNil) then begin
  Result:=TExpression.Create;
  Result.code:=SWFPushUndefined;
  Result.kind:=_Object;
 end else
 if SkipToken(tk_Add) then begin
  Result:=Expression;
  if not IsNumber(Result.Kind) then Error('number expected'); 
 end else
 if SkipToken(tk_LParen) then begin
  Result:=Expression;
  DropToken(tk_RParen);
 end else
 if TokenType=tk_String then begin
  Result:=TExpression.Create;
  Result.code:=SWFPushString(Token);
  Result.kind:=_String;
  NextToken;
 end else
 if TokenType=tkIntToStr then begin
  NextToken;
  DropToken(tk_LParen);
  Result:=Expression;
  if Result.Kind<>_Integer then Error('ordinal expected');
  DropToken(tk_RParen);
  Result.Kind:=_String; // nothing else to do ? or add acString(#$4B)
 end else
 if TokenType=tkFloatToStr then begin
  NextToken;
  DropToken(tk_LParen);
  Result:=Expression;
  if Result.Kind<>_Double then Error('float expected');
  DropToken(tk_RParen);
  Result.Kind:=_String; // nothing else to do ? or add acString(#$4B)
 end else
 if TokenType=tkCopy then begin
  NextToken;
  DropToken(tk_LParen);
  Result:=Expression;
  if Result.Kind<>_String then Error('String expected');
  DropToken(tk_Comma);
  e:=Expression;
  if e.kind<>_Integer then Error('integer expected');
  Result.code:=Result.code+e.code;
  e.Free;
  DropToken(tk_Comma);
  e:=Expression;
  if e.kind<>_Integer then Error('integer expected');
  Result.code:=Result.code+e.code;
  e.Free;
  DropToken(tk_RParen);
  Result.code:=Result.code+acSubString;
 end else
 if TokenType=tk_Variable then begin
  Result:=TExpression.Create;
  Result.Code:=GetVariable(Variable);
  Result.Kind:=Variable.Kind;
  NextToken;
  VarSuffix(Result);
 end else
 if TokenType=tk_Property then begin
  Result:=TExpression.Create;
  Result.Kind:=TProperty(Symbol).Kind;
  Result.Code:=SWFOptimize(GetThis+SWFPushString(Symbol.realName))+acGetMember;
  NextToken;
  VarSuffix(Result);
 end else
 if TokenType=tk_Constant then begin
  Result:=TExpression.Create;
  Result.Kind:=TConstant(Symbol).Kind;
  Result.Code:=TConstant(Symbol).Code;
  NextToken;
 end else
 if TokenType=tk_Parameter then begin
  //if not ((Parameter.Kind is TBaseType)or(Parameter.K)) then Error('base type parameter expected');
  Result:=TExpression.Create;
  Result.Code:=GetParameter(Parameter);
  Result.Kind:=Parameter.Kind;
  NextToken;
  VarSuffix(Result);
 end else
 if TokenType=tk_Sub then begin
  NextToken;
  Result:=Expression1;
  Result.Negate;
 end else
 if TokenType=tk_Number then begin
  Result:=TExpression.Create;
  if NextChar='.' then begin
   Token:=Token+ReadChar;
   while NextChar in ['0'..'9'] do begin
    Token:=Token+ReadChar;
   end;
   Result.Code:=SWFPushDouble(StrToFloat(Token));
   Result.Kind:=_Double;
  end else begin
   if BitsCount(Token)>32 then begin
    Result.Code:=SWFPushDouble(StrToFloat(Token));
    Result.Kind:=_Double;
   end else begin
    Result.Code:=SWFPushInteger(StrToInt(Token));
    Result.kind:=_Integer;
   end;
  end; 
  NextToken;
 end else
 if TokenType=tk_Method then begin
  m:=TMethod(Symbol);
  NextToken;
  Result:=TExpression.Create;
  Result.Kind:=m.Kind;
  if m.Externe='' then begin
   if m.Owner=nil then begin
    Result.Code:=CallMethod('',m)
   end else begin 
    Result.Code:=CallMethod(GetThis,m);
   end;
  end else begin
   Result.Code:=CallMethod(SWFGetVariable(m.Externe),m);
  end;
 end else
  Error('Expression1');
end;

function TCompiler.Expression2:TExpression;
var
 op:TToken;
 ex:TExpression;
begin
 Result:=Expression1;
 while TokenType in [tk_Mul, tkDiv, tkMod, tk_Slash, tkAnd] do begin
  op:=TokenType;
  NextToken;
  ex:=Expression1;
  case op of
   tk_Mul  : Result.MulBy(ex);
   tkDiv   : Result.DivBy(ex);
   tkMod   : Result.Modulo(ex);
   tk_Slash: Result.Divide(ex);
   tkAnd   : Result._And(ex);
  end;
 end;
end;

function TCompiler.Expression3:TExpression;
var
 op:TToken;
 ex:TExpression;
begin
 Result:=Expression2;
 while TokenType in [tk_Add, tk_Sub, tkOr] do begin
  op:=TokenType;
  NextToken;
  ex:=Expression2;
  case op of
   tk_Add : Result.Add(ex);
   tk_Sub : Result.Sub(ex);
   tkOr   : Result._Or(ex);
  end;
 end;
end;

function TCompiler.Expression:TExpression;
var
 op:TToken;
 ex:TExpression;
begin
 Result:=Expression3;
 while TokenType in [tk_Equal,tk_Greater,tk_Lesser,tk_GE,tk_LE] do begin
  op:=TokenType;
  NextToken;
  ex:=Expression3;
  case op of
   tk_Equal  : Result.IsEqual(ex);
   tk_Greater: Result.IsGreater(ex);
   tk_Lesser : Result.IsLesser(ex);
   tk_GE     : Result.IsGreaterOrEqual(ex);
   tk_LE     : Result.IsLesserOrEqual(ex);
  end;
 end;
end;

function TCompiler.GetArray:TArray;
var
 final:TArray;
 next :TArray;
begin
 NextToken;
 Result:=TArray.Create;
 Result.NextSymbol:=Anonyms;
 Anonyms:=Result;
 final:=Result;
 if SkipToken(tkOf) then
  Result._open:=True
 else begin
  Result._open:=False;
  DropToken(tk_LBracket);

  Result._low:=GetInteger;
  DropToken(tk_Range);
  Result._high:=GetInteger;

  while SkipToken(tk_Comma) do begin
   next:=TArray.Create;
   next.NextSymbol:=Anonyms;
   Anonyms:=Next;
   next._low:=GetInteger;
   DropToken(tk_Range);
   next._high:=GetInteger;
   final._kind:=next;
   final:=next;
  end;

  DropToken(tk_RBracket);
  DropToken(tkOf);
 end;
 final._kind:=GetType;
end;

// NB: Flash do not use typed variable, but we are Pascal programmers :D
function TCompiler.GetType:TSymbol;
begin
 if TokenType=tk_Class then begin
  Result:=Symbol;
  NextToken;
 end else
 if TokenType=tk_Symbol then begin
  if (Symbol is TBaseType) or (Symbol is TClass) or (Symbol is TFunction) then begin
   Result:=Symbol;
   NextToken;
  end else begin
   Error('type expected 1');
  end;
 end else
 if TokenType=tkArray then
  Result:=GetArray
 else begin
  Error('type expected 2 ');
 end;
end;

function TCompiler.GetClass:TClass;
var
 s:TSymbol;
begin
 s:=GetType;
 if not (s is TClass) then Error('Class expected');
 Result:=TClass(s);
end;

// var declaration
function TCompiler.DeclareVar(Owner:TSymbol; var Symbols:TSymbol):string;
var
 v:TVariable;
begin
 Result:='';
 v:=TVariable.Create;
 v.Owner:=Owner;
 v.realName:=SrcToken;
 v.name:=GetIdent;
 v.NextSymbol:=Symbols;
 Symbols:=v;
 if SkipToken(tk_Comma) then begin
  Result:=DeclareVar(Owner,Symbols);
  v.Kind:=TVariable(Symbols).Kind;
 end else begin
  Result:='';
  DropToken(tk_Colon);
  v.Kind:=GetType;
 end;

 if v.Kind is TArray then begin
  if v.Owner=nil then begin
   Result:=Result
          +SetVariable(v,
            SWFPushInteger(0)
           +SWFNewObject('Array')
           );
  end else begin
   Result:=Result
          +SWFOptimize(
            GetThis
           +SWFPushstring(v.realName)
           +SWFPushInteger(0)
           +SWFNewObject('Array')
           )
          +acSetMember;
  end;
 end else
 if v.Owner is TMethod then begin
//  Result:=Result+SWFPushString(v.realName)+acDeclareLocalVar;
 {$IFDEF REG_VARS}
  v.Reg:=TMethod(v.Owner).regs;
  inc(TMethod(v.Owner).Regs);
 {$ENDIF}
 end;
end;

// one method parameter
function TCompiler.GetParam(Func:TFunction; Prev:TParameter):TParameter;
var
 p:TParameter;
begin
 Result:=TParameter.Create;
// param1,param2 : type
 if Prev=nil then begin
  if SkipToken(tkConst) then Result.IsConst:=True else
  if SkipToken(tkVar)   then Result.ByRef:=True;
 end else begin
  Result.IsConst:=Prev.IsConst;
  Result.ByRef:=Prev.ByRef;
 end;
{$IFDEF REG_PARAM}
 Result.Reg:=Func.regs;
 inc(Func.Regs);
{$ENDIF}
// param name
 Result.realName:=SrcToken;
 Result.name:=GetIdent;
// check for duplicates
 p:=Func.params;
 while p<>nil do begin
  if p.name=Result.name then Error('Duplicate param name');
  p:=p.NextParam;
 end;
// add the parameter to the method
 Result.NextParam:=Func.params;
 Result.NextSymbol:=Func.params; // prepare linked list
 Func.params:=Result;
 inc(Func.count);
// one more ?
 if SkipToken(tk_Comma) then begin
  p:=GetParam(Func,Result);
  Result.Kind:=p.Kind;
 end else begin
// get type
  DropToken(tk_Colon);
  Result.Kind:=GetType;
 end;
end;

// read a class method
function TCompiler.GetMethod(AClass:TClass; void:boolean):TMethod;
var
 m:TMethod;
begin
 m:=TMethod.Create;
 m.Owner:=AClass;
 m.realName:=SrcToken;
 m.name:=GetIdent;
 m.Regs:=2;
 if SkipToken(tk_LParen) then begin
  while not SkipToken(tk_RParen) do begin
   GetParam(m,nil);
   if TokenType<>tk_RParen then DropToken(tk_SemiColon);
  end;
 end;
 if not void then begin
 // function method
  DropToken(tk_Colon);
  m.Kind:=GetType;
  m.Return:=TVariable.Create;
  m.Return.Owner:=m;
  m.Return.Name:='RESULT';
  m.Return.realName:='$Result';
  m.Return.NextSymbol:=m.Symbols;
  m.Symbols:=m.Return;
  m.Return.Kind:=m.Kind;
 {$IFDEF REG_VARS}
  m.Return.Reg:=m.Regs;
  inc(m.Regs);
 {$ENDIF}
 end;
 if AClass=nil then begin
 // global symbol
  m.NextSymbol:=Symbols;
  Symbols:=m;
 end else begin
 // class method
  m.NextSymbol:=AClass._symbols;
  AClass._symbols:=m;
 end;
 Result:=m;
end;

// we use a special syntax to define a pseudo constructor for "MovieClip.createTextField(instanceName,...)"
// constructor Create(Parent:MovieClip,...) as Parent.createTextField
procedure TCompiler.ConstructorAlias(m:TMethod);
var
 p:TParameter;
begin
// Last parm is the first one (reversed chained list)
 p:=m.LastParm;
// we need one
 if (p=nil) then Error('method alias need at least one parameter');
// need to be a class
 if (p.Kind=nil)or(not(p.Kind is TClass)) then Error('method alias need a parent class parameter');
// skip it name
 if GetIdent<>p.name then Error(p.name+' expected');
// dot
 DropToken(tk_Dot);
// get alias
 m.alias:=SrcToken;
 GetIdent;
// save the parent
 m.Parent:=p;
// remove it from param list
 if m.params=p then
  m.params:=nil
 else begin
  p:=m.params;
  while p.NextParam<>m.Parent do p:=p.NextParam;
  p.NextParam:=nil;
 end;
end;

// read class property
procedure TCompiler.GetProperty(AClass:TClass);
var
 p:TProperty;
begin
 p:=TProperty.Create;
 p.realName:=SrcToken;
 p.name:=GetIdent;
 p.NextSymbol:=AClass._symbols;
 AClass._symbols:=p;
 DropToken(tk_Colon);
 p.Kind:=GetType;
end;

// define an external class : a Flash class
procedure TCompiler.ExternalFlashClass(const ClassName, SymbolName:string);
var
 cl:TClass;
 mt:TMethod;
begin
 DropToken(tkClass);
 cl:=TClass.Create;
// we nee a case sensitive name !
 if SkipToken(tk_LParen) then begin
  cl.realName:=SrcToken;
  GetIdent;
  while SkipToken(tk_Dot) do begin
   cl.realName:=cl.realName+'.'+SrcToken;
   GetIdent;
  end;
  DropToken(tk_RParen);
 end else begin
  cl.realName:=ClassName;
 end;
 cl.name:=SymbolName;
 cl.NextSymbol:=Symbols;
 Symbols:=cl;
 while not SkipToken(tkEnd) do begin
 // todo: support multiple constructor ?
  if SkipToken(tkConstructor) then begin
   if cl._constructor<>nil then Error('duplicate constructor');
   cl._constructor:=GetMethod(cl,true);
   cl._constructor.Kind:=cl;
   if SkipToken(tkAs) then ConstructorAlias(cl._constructor);
  end else
  if SkipToken(tkProcedure) then begin
   GetMethod(cl,true);
  end else
  if SkipToken(tkFunction) then begin
   mt:=GetMethod(cl,false);
  {$IFDEF REG_VARS}
   dec(mt.Regs);
  {$ENDIF}
  end else
 // todo: readonly, writeonly attributes
  if SkipToken(tkProperty) then begin
   GetProperty(cl);
  end else
   Error('unexpected');
  if TokenType<>tkEnd then DropToken(tk_SemiColon);
 end;
end;

procedure TCompiler.DefineUserClass(const name,symbol:string);
var
 c:TUserClass;
 m:TMethod;
begin
 c:=TUserClass.Create;
 c.realName:=name;
 c.name:=symbol;
 c.NextSymbol:=Symbols;
 Symbols:=c;
 if SkipToken(tk_LParen) then begin
  c._inherite:=GetClass;
  DropToken(tk_RParen);
 end else begin
 // init this
  c.init:=SetThis(SWFPushInteger(0)+acDeclareObject);
 end;
 while not SkipToken(tkEnd) do begin
  if TokenType=tk_Ident then begin
   c.init:=c.init+DeclareVar(c,c._symbols);
  end else
  if SkipToken(tkConstructor) then begin
   if c._constructor<>nil then Error('duplicate constructor');
   c._constructor:=GetMethod(c,true);
   c._constructor.Kind:=c;
  end else
  if SkipToken(tkProcedure) then begin
   m:=GetMethod(c,true);
   c.init:=c.init+SWFOptimize(GetThis
                  +SWFPushString(m.realName)
                  +SWFGetVariable(c.realName+'$'+m.realName)
                 )
                 +acSetMember;
  end else
  if SkipToken(tkFunction) then begin
   m:=GetMethod(c,False);
   c.init:=c.init+SWFOptimize(GetThis
                  +SWFPushString(m.realName)
                  +SWFGetVariable(c.realName+'$'+m.realName)
                 )
                 +acSetMember;
  end else
   Error('what is this ?');
  if TokenType<>tkEnd then DropToken(tk_SemiColon);
 end;
end;

// declare a function prototype
procedure TCompiler.FunctionPrototype(const name:string; void:boolean);
var
 f:TPrototype;
begin
 f:=TPrototype.Create;
 f.name:=name;
 f.NextSymbol:=Symbols;
 Symbols:=f;
 f.Regs:=2;
 if SkipToken(tk_LParen) then begin
  while not SkipToken(tk_RParen) do begin
   GetParam(f,nil);
   if TokenType<>tk_RParen then DropToken(tk_SemiColon);
  end;
 end;
 if SkipToken(tkOf) then begin
  DropToken(tkObject);
  f.OfObject:=True;
 end;
end;

// declare a new type
procedure TCompiler.DeclareType;
var
 cname:string;
 uname:string;
begin
 cname:=SrcToken;
 uname:=GetIdent;
 DropToken(tk_Equal);
 if SkipToken(tkExternal) then begin
  ExternalFlashClass(cname,uname);
 end else
 if SkipToken(tkProcedure) then begin
  FunctionPrototype(uname,true);
 end else
 if SkipToken(tkFunction) then begin
  FunctionPrototype(uname,false);
 end else
 if SkipToken(tkClass) then begin
  DefineUserClass(cname,uname);
 end else
 // todo: user defined class, record ?
  Error('type expected (DeclareType)');
 DropToken(tk_SemiColon);
end;

procedure TCompiler.DeclareConst;
var
 c:TConstant;
 e:TExpression;
begin
 c:=TConstant.Create;
 c.realName:=SrcToken;
 c.Name:=GetIdent;
 DropToken(tk_Equal);
 e:=Expression;
 c.Code:=e.code;
 c.Kind:=e.Kind;
 e.Free;
 DropToken(tk_SemiColon);
 c.NextSymbol:=Symbols;
 Symbols:=c;
end;

// get a variable reference
function TCompiler.DropVariable:TVariable;
begin
 Result:=Variable;
 DropToken(tk_Variable);
end;

// push a string
function TCompiler.PushString:string;
var
 e:TExpression;
begin
 e:=Expression;
 if e.kind<>_String then Error('String expected');
 Result:=e.Code;
 e.Free;
end;

// push an integer
function TCompiler.PushInteger:string;
var
 e:TExpression;
begin
 e:=Expression;
 if e.kind<>_Integer then Error('Ordinal expected');
 Result:=e.Code;
 e.Free;
end;

// push a double
function TCompiler.PushDouble:string;
var
 e:TExpression;
begin
 e:=Expression;
 if (e.kind<>_Integer)and(e.kind<>_Double) then Error('Ordinal expected');
 Result:=e.Code;
 e.Free;
end;

procedure TCompiler.VarInstance(variable:TVariable; var Instance:TInstance);
begin
 if variable.Owner=nil then begin
  instance.code  :=SWFPushString(variable.realName);
  instance.kind  :=variable.Kind;
  instance.getter:=acGetVariable;
  instance.setter:=acSetVariable;
 end else
 if variable.Owner is TClass then begin
  instance.code  :=SWFOptimize(GetThis
                   +SWFPushString(variable.realName)
                  );
  instance.kind  :=variable.Kind;
  instance.getter:=acGetMember;
  instance.setter:=acSetMember;
 end else
 if variable.owner is TMethod then begin
 {$IFDEF REG_VARS}
  if Variable.Reg=0 then begin
 {$ENDIF}
   instance.code  :=SWFPushString(variable.realName);
   instance.getter:=acGetVariable;
   instance.setter:=acSetLocalVar;
 {$IFDEF REG_VARS}
  end else begin
   instance.code  :='';
   instance.getter:=SWFGetRegister(variable.Reg);
   instance.setter:=SWFSetRegister(variable.Reg)+acPop;
  end;
 {$ENDIF}
  instance.kind  :=variable.Kind;
 end else
  Error('VarInstance for '+variable.Owner.ClassName);
 if SkipToken(tk_LBracket) then begin
  if not (instance.Kind is TArray) then Error('Array expected');
  instance.code:=instance.code
                +instance.getter
                +GetArrayIndex(instance.kind);
  instance.getter:=acGetMember;
  instance.setter:=acSetMember;
  DropToken(tk_RBracket);
 end;
end;

function TCompiler.GetVariable(Variable:TVariable):string;
var
 Instance:TInstance;
begin
 VarInstance(Variable,Instance);
 Result:=Instance.code+Instance.getter;
end;

// todo: boolean expression
function TCompiler.PushBoolean:string;
begin
 if SkipToken(tkTrue) then Result:=SWFPushBoolean(True) else
 if SkipToken(tkFalse) then Result:=SWFPushBoolean(False) else
 error('Unknow boolean');
end;

procedure TCompiler.GetInstance(var Instance:TInstance);
var
 target:TVariable;
begin
 target:=DropVariable;
 VarInstance(target,Instance);
end;

function TCompiler.GetSymbol(List:TSymbol):TSymbol;
begin
 while List<>nil do begin
  if List.name=Token then begin
   NextToken;
   Result:=List;
   exit;
  end;
  List:=List.NextSymbol;
 end;
 Result:=nil;
end;

function TCompiler.InheritedSymbol(AClass:TClass):TSymbol;
var
 base:TClass;
begin
 base:=AClass._inherite;
 Result:=GetSymbol(base._symbols);
 while Result=nil do begin
  base:=base._inherite;
  if base=nil then Error('unknow inherited symbol');
  Result:=GetSymbol(base._symbols);
 end;
end;

function TCompiler.ClassSymbol(AClass:TClass):TSymbol;
begin
 Result:=GetSymbol(AClass._symbols);
 if Result=nil then Result:=InheritedSymbol(AClass);
end;


function TCompiler.PushInstance:string;
var
 i:TInstance;
 s:TSymbol;
begin
 if SkipToken(tkNil) then
  Result:=SWFPushInteger(0)
 else begin
  GetInstance(i);
  while SkipToken(tk_Dot) do begin
   if not (i.Kind is TClass) then Error('Class expected');
   s:=ClassSymbol(i.kind as TClass);
   if s is TVariable then begin
    i.code:=i.code+i.getter+SWFPushString(s.realName);
    i.kind:=TVariable(s).Kind;
    i.getter:=acGetMember;
    i.setter:=acSetMember;
   end else
    Error(s.className);
  end;
  Result:=i.code+i.getter;
 end;
end;

function TCompiler.PushMethod:string;
begin
 if not (Symbol is TMethod) then Error('Method expected');
 Result:=SWFOptimize(GetThis+SWFGetMember(TMethod(Symbol).realName));
 NextToken;
end;

function TCompiler.PushArray(A:TArray):string;
var
 count:integer;
begin
 DropToken(tk_LBracket);
 count:=0;
 Result:='';
 while not SkipToken(tk_RBracket) do begin
  Result:=PushKind(A._kind)+Result;
  inc(count);
  if TokenType<>tk_RBracket then DropToken(tk_Comma);
 end;
 if (A._open=False) then begin
  if (count<a._high-a._low) then Error('not enough items');
  if (count>a._high-a._low) then Error('too many items');
 end;
 Result:=Result+SWFPushInteger(count)+acDeclareArray;
end;

function TCompiler.PushKind(Kind:TSymbol):string;
var
 e:TExpression;
begin
 if (Kind is TArray)and(TokenType=tk_LBracket) then Result:=PushArray(TArray(Kind)) else
 if Kind=_String then Result:=PushString else
 if Kind=_Integer then Result:=PushInteger else
 if Kind=_Double  then Result:=PushDouble  else
 if Kind=_Boolean then Result:=PushBoolean else
 if Kind is TPrototype then Result:=PushMethod else
 if Kind is TClass then Result:=PushInstance else begin
  e:=Expression;
  if e.Kind<>Kind then begin
   if (e.Kind is TClass)and(Kind=_Object) then { ok } else
   Error(Kind.Name+' expected');
  end;
  Result:=e.Code;
  e.Free;
 end;
end;

function TCompiler.PushParams(Param:TParameter):string;
begin
 Result:='';
 if Param<>nil then begin
  if Param.NextParam<>nil then begin
   Result:=PushParams(Param.NextParam);
   DropToken(tk_Comma);
  end;
  Result:=PushKind(Param.Kind)+Result;
 end;
end;

function TCompiler.CallConstructor(ACreate:TMethod):string;
var
 parent:string;
begin
 Result:='';
 if acreate.alias<>'' then begin
 // call a parent method to create the new instance
 // Parent.create('instance',...)
  DropToken(tk_LParen);
 // nil parent is _root !
  if SkipToken(tkNil) then
   parent:=SWFGetVariable('_root')
  else
  if SkipToken(tkSelf) then
   parent:=GetThis
  else
   parent:=PushInstance;
  if SkipToken(tk_Comma) then begin
   Result:=PushParams(acreate.params);
  end else begin
   if acreate.params<>nil then Error('parameter expected');
  end;
  DropToken(tk_RParen);
  Result:=SWFOptimize(
           Result
          +SWFPushInteger(acreate.count-1)
          +parent
          +SWFCallMethod(acreate.alias)
          );
 end else begin
 // instance=new Class(...)
  if SkipToken(tk_LParen) then begin
   Result:=PushParams(acreate.params);
   DropToken(tk_RParen);
  end else begin
   if acreate.params<>nil then Error('parameter expected');
  end;
  if acreate.Kind is TUserClass then begin
   Result:=SWFOptimize(
            Result
           +SWFPushInteger(acreate.count)
           +SWFCallFunction(acreate.realName)
           );
  end else begin
   Result:=SWFOptimize(
            Result
           +SWFPushInteger(acreate.count)
           +SWFNewObject(TClass(acreate.Kind).realName)
           );
  end;
 end;
end;

function TCompiler.CallFunction(method:TMethod):string;
begin
 Result:='';
 if SkipToken(tk_LParen) then begin
  Result:=PushParams(method.params);
  DropToken(tk_RParen);
 end;
 Result:=SWFOptimize(
          Result
         +SWFPushInteger(method.count)
         +SWFCallFunction(method.realName)
         );
end;

function TCompiler.ConstructClass(aclass:TClass):string;
var
 base  :TClass;
 create:TMethod;
 s     :string;
begin
 NextToken;
 DropToken(tk_Dot);
 base:=aclass;
 create:=base._constructor;
 while create=nil do begin
  base:=base._inherite;
  if base=nil then error('Constructor not found');
  create:=base._constructor;
 end;
 DropIdent(create.name);
 if (base is TUserClass) then begin
  if create.code='' then begin
   s:=create.realName;
   create.realName:=aclass.realName+'$'+s;
  end;
  Result:=CallFunction(create);
  if create.code='' then create.realName:=s;
 end else begin
  Result:=CallConstructor(create);
 end;
end;

// todo: a lot of things !
function TCompiler.AssignStatement(Kind:TSymbol):string;
var
 e:TExpression;
begin
 if Kind is TClass then begin
  if (TokenType=tk_Class) then
   Result:=ConstructClass(TClass(Symbol))
  else begin
   e:=Expression;
   if (e.Kind<>Kind)and(e.Kind<>_Object) then Error('Type mismatch');
   Result:=e.Code;
   e.Free;
  end;
 end else
 if Kind is TPrototype then begin
  if TokenType<>tk_Method then Error('Method expected');
  if TMethod(Symbol).Owner=nil then Error('Object method expected');
  Result:=SWFOptimize(GetThis
          +SWFGetMember(TMethod(Symbol).realName)
          );
  NextToken;
 end else
  Result:=PushKind(Kind);
end;

function TCompiler.SetProperty(const instance:string; prop:TProperty):string;
begin
 DropToken(tk_Assign);
 if (prop.Kind is TPrototype)and SkipToken(tkNil) then begin
  Result:=SWFOptimize(
          instance
         +SWFPushString(prop.realName)
         +acDelete
          );
 end else begin
  Result:=SWFOptimize(
          instance
         +SWFPushString(prop.realName)
         +PushKind(prop.Kind)
         +acSetMember
         );
 end;
end;

function TCompiler.CallMethod(const instance:string; method:TMethod):string;
begin
 Result:='';
 if SkipToken(tk_LParen) then begin
  Result:=PushParams(method.params);
  DropToken(tk_RParen);
 end;
 if instance='' then begin
  Result:=SWFOptimize(
           Result
          +SWFPushInteger(method.count)
          +SWFCallFunction(method.realName)
          );
 end else begin
  Result:=SWFOptimize(
           Result
          +SWFPushInteger(method.count)
          +instance
          +SWFCallMethod(method.realName)
          );
 end;
end;

function TCompiler.InstanceSuffix(var instance:TInstance):string;
var
 suffix:TSymbol;
 base:TClass;
begin
 if SkipToken(tk_Dot) then begin
  if not (instance.kind is TClass) then Error('Class expected');

  base:=TClass(instance.Kind);
  repeat
   if base=nil then Error('unknow member');
   suffix:=GetSymbol(base._symbols);
   base:=base._inherite;
  until suffix<>nil;

  if suffix is TProperty then Result:=SetProperty(instance.code+instance.getter,TProperty(suffix)) else
  if suffix is TMethod then Result:=CallMethod(instance.code+instance.getter,TMethod(suffix))+acPop else
  if suffix is TVariable then begin
   instance.code:=instance.code
                 +instance.getter
                 +SWFPushString(suffix.realName);
   instance.getter:=acGetMember;
   instance.setter:=acSetMember;
   instance.kind:=TVariable(Suffix).Kind;
   Result:=InstanceSuffix(instance);
  end else
  Error('suffix '+suffix.ClassName);
 end else begin
  DropToken(tk_Assign);
  Result:=SWFOptimize(
           instance.code
          +AssignStatement(instance.kind)
          +instance.setter
          );
 end;
end;


function TCompiler.VariableSuffix:string;
var
 instance:TInstance;
begin
 GetInstance(instance);
 Result:=InstanceSuffix(instance);
end;

function TCompiler.ParameterSuffix:string;
var
 instance:TInstance;
begin
 instance.code:=GetParameter(TParameter(Symbol));
 instance.kind:=TParameter(Symbol).Kind;
 instance.getter:='';
 instance.setter:='';
 NextToken;
 Result:=InstanceSuffix(instance);
end;

function TCompiler.PropertySuffix:string;
var
 instance:TInstance;
begin
 instance.code:=SWFOptimize(GetThis
                +SWFPushString(TProperty(Symbol).realName)
                );
 instance.kind:=TProperty(Symbol).Kind;
 instance.getter:=acGetMember;
 instance.setter:=acSetMember;
 NextToken;
 Result:=InstanceSuffix(instance);
end;

// if boolean then statement [else statement]
function TCompiler.IfStatement:string;
var
 e:TExpression;
 s1:string;
 s2:string;
begin
 NextToken;
 e:=Expression;
 if e.Kind<>_Boolean then Error('boolean expected');
 DropToken(tkThen);
 s1:=Statement;
 if SkipToken(tkElse) then begin
  s2:=Statement;
  s1:=s1+Branch(Length(s2));
 end else begin
  s2:='';
 end;
 Result:=e.code+acLogicalNot+BranchIfEq(Length(s1))+s1+s2;
 e.Free;
end;

// for var:=a to b do/downto statement;
function TCompiler.ForStatement:string;
var
 v:TVariable;
 init:string;
 test:string;
 code:string;
begin
{-$DEFINE FULLTEST}
 NextToken;
 v:=DropVariable;
 if v.Kind<>_Integer then Error('ordinal expected');
 DropToken(tk_Assign);
 init:=SetVariable(v,PushInteger);
 if SkipToken(tkTo) then begin
 {$IFDEF FULLTEST}
  test:=PushInteger
       +GetVariable(v)
       +acLessThan;
 {$ELSE}
  init:=init+PushInteger;
  test:=acDuplicate
       +GetVariable(v)
       +acLessThan;
 {$ENDIF}
  code:=SetVariable(v,GetVariable(v)+acIncrement);
 end else begin
  DropToken(tkDownto);
 {$IFDEF FULLTEST}
  test:=PushInteger
       +GetVariable(v)
       +acLessThan;
 {$ELSE}
  init:=init+PushInteger;
  test:=acDuplicate
       +GetVariable(v)
       +acLessThan;
 {$ENDIF}
  code:=SetVariable(v,GetVariable(v)+acDecrement);
 end;
 DropToken(tkDo);
 code:=Statement+SWFOptimize(code);
 code:=SWFOptimize(test)+BranchIfEq(Length(code)+5 { Branch(-Length-(Code) } )+code;
 Result:=SWFOptimize(init)+code+Branch(-Length(Code)-5){$IFDEF FULLTEST}+acPop{$ENDIF};
end;

function TCompiler.CallThisMethod:string;
var
 m:TMethod;
begin
 m:=Symbol as TMethod;
 NextToken;
 if m.Owner=nil then
  Result:=CallFunction(m)+acPop
 else
  Result:=CallMethod(GetThis,m)+acPop;
end;

function TCompiler.NextCase(Kind:TSymbol):string;
var
 s1,s2:string;
     l:integer;
begin
 if SkipToken(tkEnd) then begin
  Result:='';
 end else
 if SkipToken(tkElse) then begin
  Result:=Statement;
  SkipToken(tk_SemiColon);
  DropToken(tkEnd);
 end else
 begin
  Result:=acDuplicate+PushKind(Kind)+acEqual+acLogicalNot;
  DropToken(tk_Colon);
  s1:=Statement;
  DropToken(tk_SemiColon);
  s2:=NextCase(Kind);
  l:=length(s1);
  if s2<>'' then inc(l,5);
  Result:=Result+BranchIfEq(l)+s1;
  if s2<>'' then Result:=Result+Branch(Length(s2))+s2;
 end;
end;

// the case statement accept any kind of expression
// so it's time to uses TExpression :)
function TCompiler.CaseStatement:string;
var
 e:TExpression;
begin
 NextToken; // case
 e:=Expression;
 DropToken(tkOf);
 Result:=e.code+NextCase(e.Kind)+acPop;
 e.Free;
end;

function TCompiler.RepeatStatement:string;
var
 e:TExpression;
begin
 NextToken;
 Result:='';
 while not SkipToken(tkUntil) do begin
  Result:=Result+Statement;
  if TokenType<>tkUntil then DropToken(tk_SemiColon);
 end;
 e:=Expression;
 if e.Kind<>_Boolean then Error('Boolean expression expected');
 Result:=Result+e.Code+acLogicalNot;
 Result:=Result+BranchIfEq(-Length(Result)-5);
 e.Free;
end;

function TCompiler.WhileStatement:string;
var
 e:TExpression;
begin
 NextToken;
 Result:='';
 e:=Expression;
 if e.Kind<>_Boolean then Error('Boolean expression expected');
 DropToken(tkDo);
 Result:=Statement;
 Result:=e.Code+acLogicalNot+BranchIfEq(Length(Result)+5)+Result;
 Result:=Result+Branch(-Length(Result)-5);
 e.Free;
end;

function TCompiler.SortStatement:string;
var
 v:TVariable;
 s:TSymbol;
 m:string;
begin
 NextToken;
 DropToken(tk_LParen);
 v:=DropVariable;
 if not (v.Kind is TArray) then Error('Array expected');
 if SkipToken(tk_Comma) then begin
  if not (TArray(v.Kind)._kind is TClass) then Error('Class expected');
  s:=GetSymbol(TClass(TArray(v.Kind)._kind)._symbols);
  Result:=SWFPushString(s.realName)+SWFPushInteger(1);
  m:='sortOn';
 end else begin
  Result:=SWFPushInteger(0);
  m:='sort';
 end;
 DropToken(tk_RParen);
 Result:=SWFOptimize(
          Result+GetVariable(v)+SWFCallMethod(m)+acPop
         );
end;

// statement -or- begin statement1; statement2; end;
function TCompiler.Statement:string;
begin
 Result:='';
 case TokenType of
  tkBegin: begin
   NextToken;
   SkipToken(tk_SemiColon);
   while not SkipToken(tkEnd) do begin
    Result:=Result+Statement;
    if TokenType<>tkEnd then DropToken(tk_SemiColon) else SkipToken(tk_SemiColon);
   end;
  end;
  tk_Variable : Result:=VariableSuffix;
  tk_Parameter: Result:=ParameterSuffix;
  tk_Property : Result:=PropertySuffix;
  tk_Method   : Result:=CallThisMethod;
  tkIf        : Result:=IfStatement;
  tkFor       : Result:=ForStatement;
  tkCase      : Result:=CaseStatement;
  tkRepeat    : Result:=RepeatStatement;
  tkWhile     : Result:=WhileStatement;
  tkSort      : Result:=SortStatement;
  tk_Symbol   : Error('unexpected symbol '+Symbol.ClassName+' '+Symbol.realName);
  else Error('Unexpected token (statement)');
 end;
end;

procedure TCompiler.DropParams(Param:TParameter);
begin
 if Param.NextParam=nil then begin
 // publish the parameters
 // Param.NextSymbol:=Symbols;
 // Symbols:=Param;
 end else begin
  DropParams(Param.NextParam);
  SkipToken(tk_SemiColon);
 end;
 DropIdent(Param.name);
 if SkipToken(tk_Comma) then begin

 end else begin
  DropToken(tk_Colon);
  DropIdent(Param.Kind.name);
 end;
end;

function TCompiler.MethodCall(AClass:TClass; AMethod:TMethod):string;
begin
 Error('need to be fixed');
 if (AMethod.Kind is TClass) and (TClass(AMethod.Kind)._constructor=AMethod) then begin
 end else begin
 end;
end;

function TCompiler.IsFlashClass(AClass:TClass):boolean;
begin
 if not (AClass is TUserClass) then
  Result:=True
 else begin
  if AClass._inherite=nil then
   Result:=False
  else
   Result:=IsFlashClass(AClass._inherite);
 end;
end;

function TCompiler.IsConstructor(Symbol:TSymbol):boolean;
begin
 Result:=(Symbol is TMethod)
      and(TMethod(Symbol).Kind is TClass)
      and(TClass(TMethod(Symbol).Kind)._constructor=Symbol);
end;

function TCompiler.DeclareConstructor(AClass:TClass):string;
var
 s,ss:string;
 p:TParameter;
 f:word;
begin
// if AClass is TUserClass then f:=FLAG_7+1 else
  f:=FLAG_7;
 s:=AClass._constructor.realName+#0
   +SWFshort(AClass._constructor.count)
   +chr(AClass._constructor.regs)
   +SWFshort(f); // preload this
 p:=AClass._constructor.params;
 ss:='';
 while p<>nil do begin
  ss:={$IFDEF REG_PARAM}chr(p.Reg){$ELSE}#0{$ENDIF}+p.realName+#0+ss;
  p:=p.NextParam;
 end;
 s:=s+ss+SWFshort(length(AClass._constructor.code));

 Result:=acDeclareFunction7
        +SWFshort(Length(s))
        +s
        +AClass._constructor.code;
end;

function TCompiler.DefineConstructor:string;
var
 cl:TClass;
 sy:TSymbol;
 s :string;
 flash:boolean;
 scope:TScope;
 parms:TScope;
 local:TScope;
begin
 NextToken;
 cl:=GetClass;
 if not (cl is TUserClass) then Error('not a user defined class');
 DropToken(tk_Dot);
 if cl._constructor=nil then Error('unknow constructor');
 DropIdent(cl._constructor.name);

 Scope.Symbol:=cl;
 Scope.Next:=Scopes;
 Scopes:=@Scope;

 if cl._constructor.params<>nil then begin
  DropToken(tk_LParen);
  DropParams(cl._constructor.params);
  DropToken(tk_RParen);
  Parms.Symbol:=cl._constructor;
  Parms.Next:=Scopes;
  Scopes:=@Parms;
 end;
 DropToken(tk_SemiColon);
 cl._constructor.realName:=cl.realName+'$'+cl._constructor.realName;
 s:='';
 flash:=IsFlashClass(cl);

 if SkipToken(tkVar) then begin
  repeat
   s:=s+DeclareVar(cl._constructor,cl._constructor.Symbols);
   DropToken(tk_SemiColon);
  until TokenType<>tk_Ident;
  local.Symbol:=cl._constructor;
  local.Next:=@Scope;
  Scopes:=@local;
 end;

 DropToken(tkBegin);

 // for a Flash Class we need to imediatly call the inherited constructor !
 if flash then begin
  DropToken(tkInherited);
  sy:=InheritedSymbol(cl);
  if not IsConstructor(sy) then Error('Flash constructor need to be called first !');
  s:=s+SetThis(CallConstructor(TMethod(sy)));
  if TokenType=tkEnd then SkipToken(tk_SemiColon) else DropToken(tk_SemiColon);
 end;

 if cl is TUserClass then begin
  s:=s+TUserClass(cl).init;
 end;

 while not SkipToken(tkEnd) do begin
  if SkipToken(tkInherited) then begin
   sy:=InheritedSymbol(cl);
   if sy is TMethod then begin
    s:=s+MethodCall(cl,TMethod(sy));
   end else
    Error(sy.realName);
  end else
   s:=s+Statement;
  if TokenType=tkEnd then SkipToken(tk_SemiColon) else DropToken(tk_SemiColon);
 end;

 cl._constructor.code:=s+GetThis+acReturn;

 DropToken(tk_SemiColon);

{ VERSION 7 }
 Result:=DeclareConstructor(cl);

 Scopes:=Scope.Next;
end;

function TCompiler.DefineMethod:string;
var
 cl:TClass;
 mt:TMethod;
 sy:TSymbol;
 s :string;
 scope:TScope;
 parms:TScope;
 local:TScope;
begin
 cl:=GetClass;
 if not (cl is TUserClass) then Error('not a user defined class');
 DropToken(tk_Dot);

 sy:=GetSymbol(cl._symbols);
 if not (sy is TMethod) then Error('Method expected');
 mt:=TMethod(sy);

 Scope.Symbol:=cl;
 Scope.Next:=Scopes;
 Scopes:=@Scope;

 if mt.params<>nil then begin
  DropToken(tk_LParen);
  DropParams(mt.params);
  DropToken(tk_RParen);
  parms.Symbol:=mt;
  parms.Next:=@Scope;
  Scopes:=@parms;
 end else begin
  if SkipToken(tk_LParen) then DropToken(tk_RParen);
 end;

 if mt.Kind<>nil then begin
  DropToken(tk_Colon);
  DropIdent(mt.Kind.name);
 end;
 DropToken(tk_SemiColon);
// mt.realName:=cl.realName+'$'+mt.realName;

 s:='';
 if SkipToken(tkVar) then begin
  repeat
   s:=s+DeclareVar(mt,mt.Symbols);
   DropToken(tk_SemiColon);
  until TokenType<>tk_Ident;
  local.Symbol:=mt;
  local.Next:=@Scope;
  Scopes:=@local;
 end;

 DropToken(tkBegin);

 while not SkipToken(tkEnd) do begin
  if SkipToken(tkInherited) then begin
   sy:=InheritedSymbol(cl);
   if sy is TMethod then begin
    s:=s+MethodCall(cl,TMethod(sy));
   end else
    Error(sy.realName);
  end else
   s:=s+Statement;
  if TokenType=tkEnd then SkipToken(tk_SemiColon) else DropToken(tk_SemiColon);
 end;

 if mt.Return<>nil then
  s:=s+GetVariable(mt.Return)+acReturn
{ else
  s:=s+SWFPushUndefined+acReturn};

 mt.code:=s;

 DropToken(tk_SemiColon);

 Result:=DeclareFunction(mt,cl.realName+'$'+mt.realName);

 Scopes:=Scope.Next;
end;

function TCompiler.StaticMethod(void:boolean):string;
var
 m:TMethod;
 s:string;
 syms :PScope;
 parms:TScope;
 local:TScope;
begin
 m:=GetMethod(nil,void);
 if SkipToken(tkExternal) then begin
 {$IFDEF REG_VARS}
  if m.Return<>nil then dec(m.Regs);
 {$ENDIF}
  m.Externe:=SrcToken;
  GetIdent;
  DropToken(tk_Dot);
  m.realName:=SrcToken;
  NextToken;
  while SkipToken(tk_Dot) do begin
   m.Externe:=m.Externe+':'+m.realName;
   m.realName:=SrcToken;
   NextToken;
  end;
  DropToken(tk_SemiColon);
 end else begin
  DropToken(tk_SemiColon);

  syms:=Scopes;

  if m.params<>nil then begin
   parms.Symbol:=m;
   parms.Next:=Scopes;
   Scopes:=@parms;
  end;

  s:='';
  if SkipToken(tkVar) then begin
   repeat
    s:=s+DeclareVar(m,m.Symbols);
    DropToken(tk_SemiColon);
   until TokenType<>tk_Ident;
   local.Symbol:=m;
   local.Next:=Scopes;
   Scopes:=@local;
  end;

  DropToken(tkBegin);

  while not SkipToken(tkEnd) do begin
   s:=s+Statement;
   if TokenType=tkEnd then SkipToken(tk_SemiColon) else DropToken(tk_SemiColon);
  end;

  if m.Return<>nil then
   s:=s+GetVariable(m.Return)+acReturn;
{  else
   s:=s+SWFPushUndefined; }

  m.code:=s;//+acReturn;

  DropToken(tk_SemiColon);

  Result:=DeclareFunction(m,m.realName);

  Scopes:=syms;
 end;
end;

function TCompiler.CheckClass(AClass:TUserClass):string;
var
 s:TSymbol;
 m:TMethod absolute s;
begin
 Result:='';

 s:=AClass._symbols;

 if (AClass.init<>'')and(AClass._constructor=nil) then begin
  AClass._constructor:=AClass.InheritedConstructor;
  AClass._constructor.kind:=AClass;
  Result:=DeclareConstructor(AClass);
 end;

 while s<>nil do begin
  if s is TMethod then begin
   if m.code='' then Error(AClass.realName+'.'+m.realName+' not defined');
  end;
  s:=s.NextSymbol;
 end;
end;

function TCompiler.CheckClasses:string;
var
 s:TSymbol;
begin
 Result:='';
 s:=Symbols;
 while s<>nil do begin
  if s is TUserClass then
   Result:=Result+CheckClass(TUserClass(s));
  s:=s.NextSymbol;
 end;
end;

procedure TCompiler.UnitInterface(const Name:string);
var
 code : string;
begin
 NextToken;
 DropToken(tkUnit);
 DropIdent(name);
 DropToken(tk_SemiColon);
 FNext := Sources;
 Sources := Self;
 DropToken(tkInterface);
 if SkipToken(tkUses) then AddUses;
 while not SkipToken(tkImplementation) do begin
  case TokenType of
   tkVar : begin
    NextToken;
    repeat
     code:=code+DeclareVar(nil,Symbols);
     DropToken(tk_SemiColon);
    until TokenType<>tk_Ident;
   end;
   tkType : begin
    NextToken;
    repeat DeclareType until TokenType<>tk_Ident;
   end;
   tkConst : begin
    NextToken;
    repeat DeclareConst until TokenType<>tk_Ident;
   end;
   tkProcedure   : begin
    NextToken;
    if TokenType=tk_Class then code:=code+DefineMethod else code:=code+StaticMethod(True);
   end;
   tkFunction    : begin
    NextToken;
    if TokenType=tk_Class then code:=code+DefineMethod else code:=code+StaticMethod(false);
   end;
   else Error('Unexpected token (UnitInterface)');
  end;
 end;
end;

procedure TCompiler.Compile;
var
  code: string;
  name: string;
     f: file;
begin
  Assert(Sources=nil,'Sources not null');
  NextToken;
  DropToken(tkProgram);
  name := SrcToken+'.swf';
  FName := GetIdent;
  Sources := Self;
  DropToken(tk_SemiColon);
  if SkipToken(tkUses) then AddUses;
  code:='';
  while not SkipToken(tkBegin) do begin
   case TokenType of
    tkVar : begin
     NextToken;
     repeat
      code:=code+DeclareVar(nil,Symbols);
      DropToken(tk_SemiColon);
     until TokenType<>tk_Ident;
    end;
    tkType : begin
     NextToken;
     repeat DeclareType until TokenType<>tk_Ident;
    end;
    tkConst : begin
     NextToken;
     repeat DeclareConst until TokenType<>tk_Ident;
    end;
    tkConstructor : code:=code+DefineConstructor;
    tkProcedure   : begin
     NextToken;
     if TokenType=tk_Class then code:=code+DefineMethod else code:=code+StaticMethod(True);
    end;
    tkFunction    : begin
     NextToken;
     if TokenType=tk_Class then code:=code+DefineMethod else code:=code+StaticMethod(false);
    end;
    else Error('Unexpected token (compile)');
   end;
  end;

  code:=code+CheckClasses;

  while not SkipToken(tkEnd) do begin
   code:=code+Statement;
   if TokenType<>tkEnd then DropToken(tk_SemiColon) else SkipToken(tk_SemiColon);
  end;
  if TokenType<>tk_Dot then Error('Expected .');

  code:=SWFAttributes(0)
       +SWFBackground((Background shr 16) and $FF,(Background shr 8) and $FF,Background and $FF)
       +Resources
       +SWFDoAction(code+acEndAction)
       +SWFShowFrame // needed by FlashPlayer.exe to show the first frame
       +SWFEndTag;
  code := SWFFile(FlashVersion, FrameWidth, FrameHeight, FrameRate, 1, code);

  AssignFile(f,name);
  Rewrite(f,1);
  BlockWrite(f,code[1],Length(code));
  CloseFile(f);

 {$IFDEF SHELL}
 {$IFDEF PLAYER}
  ShellExecute(0,nil,pchar('"'+ExtractFilePath(ParamStr(0))+'FlashPlayer.exe"'),pchar(name),nil,SW_SHOW);
 {$ELSE}
  ShellExecute(0,'open',pchar('"'+ExtractFilePath(ParamStr(0))+name+'"'),nil,nil,SW_SHOW);
 {$ENDIF}
 {$ENDIF}
end;

procedure TCompiler.AddUses;
var
  name: string;
begin
  repeat
    name := GetIdent;
    CompileUnit(name);
   until SkipToken(tk_Comma)=False;
   DropToken(tk_SemiColon);
end;

procedure TCompiler.CompileUnit(const Name:string);
var
  u : TUses;
  c : TCompiler;
begin
  u := FUses;
  while u<>nil do
  begin
    if u.Source.FName = Name then
      Error('');
    u := u.Next;
  end;
  c := Sources;
  while c<>nil do
  begin
    if c.FName=Name then
    begin
      if c=Sources then Error('Can''t use main program');
      Break;
    end;
    c := c.FNext;
  end;
  if c = nil then
  begin
    c := TCompiler.Create(Path+Name+'.pas');
    c.UnitInterface(Name);
  end;
  u := TUses.Create;
  u.Source := c;
  u.Next := FUses;
  FUses := u;
end;

destructor TCompiler.Destroy;
var
  u : TUses;
begin
  if FNext<>nil then
    FNext.Free;
  while FUses<>nil do
  begin
    u := FUses;
    FUses := u.Next;
    u.Free;
  end;
  Sources := nil;
  inherited;
end;

end.
