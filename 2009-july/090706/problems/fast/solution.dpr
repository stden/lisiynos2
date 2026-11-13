{$apptype console}

uses SysUtils;

{ Быстрое возведение в степень по модулю a^b mod m }

function slow_mul( a:Int64; b:Integer; m:Int64 ):Int64;
var i:Integer;
begin
  Result := 1;
  for i:=1 to b do
    Result := (Result * a) mod m;
  Result := Result mod m;
end;

function fast_mul( a:Int64; b:Integer; m:Int64 ):Int64;
begin
  if b = 0 then
    Result := 1
  else
    case b mod 2 of
      0: begin
           Result := fast_mul(a,b div 2,m);
           Result := Result*Result;
         end;
      1: Result := (fast_mul(a,b-1,m) * a);
    end;
  Result := Result mod m;
end;

function fast_wrong_mul( a:Int64; b:Integer; m:Int64 ):Int64;
begin
  Result := 1;
  while b > 0 do
    case b mod 2 of
      0: begin Result := (Result*Result) mod m; b := b div 2; end;
      1: begin Result := (Result*a) mod m; b := b - 1; end;
    end;
end;

var
  a:Int64; b:Integer; m:Int64;
  Tests,Test : Integer;
begin
  assign(input,'fast.in'); reset(input);
  assign(output,'fast.out'); rewrite(output);
  read(Tests);
  for Test := 1 to Tests do begin
    read(a,b,m);
    writeln( fast_mul(a,b,m) );
  end;
end.
