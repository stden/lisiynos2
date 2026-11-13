unit Global;

interface

{$I FlashPascal.inc}

type
 TSymbol=class
  name      :string;  // upper case name
  realName  :string;  // the real name as in type or var definition
  NextSymbol:TSymbol; // linked list of symbols
 {$IFDEF MEMCHECK}
  constructor Create;
  destructor Destroy; override;
 {$ENDIF}
 end;

 PScope=^TScope;
 TScope=record
  Symbol:TSymbol;
  Next  :PScope;
 end;


function StrLess(const Str,Value:string):boolean;

{$IFDEF MEMCHECK}
var
  sCount : Integer;
  eCount : Integer;
{$ENDIF}

implementation

// compare two litteral integers
function StrLess(const Str,Value:string):boolean;
var
 i,l:integer;
begin
 l:=Length(Str);
 if l=Length(Value) then begin
  for i:=1 to l do begin
   if Str[i]>Value[i] then begin
    Result:=False;
    exit;
   end;
  end;
  Result:=True;
 end else begin
  Result:=l<Length(Value);
 end;
end;

{$IFDEF MEMCHECK}
constructor TSymbol.Create;
begin
 inc(sCount);
end;

destructor TSymbol.Destroy;
begin
// WriteLn(realName,'->',ClassName);
 dec(sCount);
end;
{$ENDIF}

end.