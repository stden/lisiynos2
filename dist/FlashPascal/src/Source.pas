unit Source;

interface

uses
 Global;

type
 TSource=class
  Handle   :TextFile; // source file
  Line     :integer;  // current line
  Index    :integer;  // current char in line
  Src      :string;   // current readed line
  SrcToken :string;   // current token
  LastChar :char;     // last readed char
  NextChar :char;     // current readed char (next in token)
  Token    :string;   // current token (uppercase for keywords, without quotes for litteral strings)
  constructor Create(const FileName:string);
  destructor Destroy; override;
  function StrToInt(const Str:string):integer;
  function BitsCount(const Str:string):integer;
  procedure Error(const Msg:string);
  function ReadChar:char;
  function SkipChar(c:char):boolean;
  function StringConst:string;
  function AsciiChar:string;
 end;

implementation

constructor TSource.Create(const FileName:string);
begin
 AssignFile(Handle,FileName);
 Reset(Handle);
 Src  :='';
 Line :=1;
 Index:=0;
 NextChar:=' ';
 ReadChar;
end;

destructor TSource.Destroy;
begin
 CloseFile(Handle);
end;

// convert Str to an integer
function TSource.StrToInt(const Str:string):integer;
var
 e:integer;
begin
 Val(Str,Result,e);
 if e>0 then Error('Invalid number '+str);
end;

// how many bits to store this numeric ?
function TSource.BitsCount(const Str:string):integer;
begin
 case Length(Str) of
  0    : Error('Invalid number');
  1..2 : Result:=8;
  3    : if StrLess(Str,'255') then Result:=8 else Result:=16;
  4    : Result:=16;
  5    : if StrLess(Str,'65535') then Result:=16 else Result:=32;
  else   if StrLess(Str,'4294967295') then Result:=32 else Error('cardinal overflow');
 end;
end;

procedure TSource.Error(const Msg:string);
var
 i:integer;
begin
 WriteLn('Error on line ',line,' at char ',index,' on ',SrcToken);
 WriteLn(Src);
 for i:=1 to Index-Length(SrcToken)-1 do Write(' ');
 for i:=1 to Length(SrcToken) do Write('^');
 WriteLn;
 WriteLn(Msg);
 ReadLn;
 Halt;
end;

// read one char
function TSource.ReadChar:char;
begin
 if NextChar=#27 then Error('Unexpected end of file');
 SrcToken:=SrcToken+NextChar;
 LastChar:=NextChar;
 Result:=NextChar;
 if Eof(Handle) then NextChar:=#27 else Read(Handle,NextChar);
{$IFDEF LOG}Write(NextChar);{$ENDIF}
 if NextChar=#13 then inc(Line) else
 if NextChar=#10 then Index:=0 else begin
  inc(Index);
  if Index=1 then Src:=NextChar else Src:=Src+NextChar;
 end;
end;

// skip one char ?
function TSource.SkipChar(c:char):boolean;
begin
 Result:=NextChar=c;
 if Result then ReadChar;
end;

// read a quoted string
function TSource.StringConst:string;
var
 done:boolean;
begin
 ReadChar; // ''''
 Result:='';
 repeat
  while NextChar<>'''' do begin
   if NextChar=#13 then Error('Open string');
   Result:=Result+ReadChar;
  end;
  ReadChar; // ''''
  if NextChar='''' then begin
   Result:=Result+ReadChar;
   done:=False;
  end else begin
   done:=True;
  end;
 until done;
end;

// read an ascii char value (#xxx)
function TSource.AsciiChar:string;
begin
 ReadChar; // #
 Result:='';
 while NextChar in ['0'..'9'] do Result:=Result+ReadChar;
 if BitsCount(Result)>8 then Error('byte overflow');
 Result:=chr(StrToInt(Result));
end;

end.
