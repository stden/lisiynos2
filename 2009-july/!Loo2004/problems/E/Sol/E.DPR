{
  Решение к задаче "E. Вещественное число"
  Автор: Степулёнок Д.О.
}

{$APPTYPE CONSOLE}

const
  ne_nol : Set of char = ['1','2','3','4','5','6','7','8','9'];
  cifra : Set of char = ['0','1','2','3','4','5','6','7','8','9'];
  e : Set of char = ['e','E'];

{ <мантисса> ::= <не_ноль><дробная_часть> }
function mantissa( s:string ):boolean;
var i : integer;
begin
  Result:=false;
  if length(s)<1 then exit;
  if not (s[1] in ne_nol) then exit;
  delete(s,1,1);
  {<дробная_часть> := $ |.<любые_цифры><не_ноль> }
  if s='' then begin
    Result:=true;
    exit;
  end;
  {}
  if length(s)<1 then exit;
  if s[1]<>'.' then exit;
  delete(s,1,1);
  if length(s)<1 then exit;
  if not (s[length(s)] in ne_nol) then exit;
  delete(s,length(s),1);
  {<любые_цифры>}
  Result:=true;
  for i:=1 to length(s) do
    if not (s[i] in cifra) then begin
      Result:=false;
      exit;
    end;
end;

{ <экспонента> ::= $ | <е><знак><натур_число> }
function exponenta( s:string ):boolean;
var i : integer;
begin
  if s='' then begin
    Result:=true;
    exit;
  end;
  {}
  result:=false;
  if length(s)<3 then exit;
  if not (s[1] in e) then exit;
  if not (s[2] in ['+','-']) then exit;
  if not (s[3] in ne_nol) then exit;
  delete(s,1,3);
  {<любые_цифры>}
  Result:=true;
  for i:=1 to length(s) do
    if not (s[i] in cifra) then begin
      Result:=false;
      exit;
    end;
end;

{ <вещ_число> ::= 0 | <мантисса><экспонента> }
function vesh_chislo( s:string ):boolean;
var i : integer;
begin
  if s='0' then begin
    Result := true;
  end else begin
    Result := false;
    for i:=0 to Length(s) do
      if mantissa( Copy(s,1,i) ) and
         exponenta( Copy(s,1+i,Length(s)-i) ) then begin
       Result:=true;
       exit;
     end;
  end;
end;

var n,test : Integer;
  s : string;
begin
  assign(input,'e.in'); reset(input);
  assign(output,'e.out'); rewrite(output);
  {}
  readln(n);
  for test:=1 to n do begin
    readln(s);
    if length(s) > 255  then RunError(239);
    if vesh_chislo(s) then writeln('Yes') else writeln('No');
  end;
end.