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

function fast2_mul( a:Int64; b:Integer; m:Int64 ):Int64;
begin
  Result := 1;
  while b > 0 do
    case b mod 2 of
      0: begin Result := (Result*Result) mod m; b := b div 2; end;
      1: begin Result := (Result*a) mod m; b := b - 1; end;
    end;
end;

var
  i:integer;
  a:Int64; b:Integer; m:Int64;
  T:TDateTime;
begin
  randomize;
  assert( fast2_mul(2,5,1000) = 32 );
  writeln(100);
  for i:=1 to 100 do begin
    a := random(MaxLongInt);
    b := random(MaxLongInt);
    m := random(MaxLongInt{MaxLongInt})+1;
//    assert( slow_mul(a,b,m) = fast_mul(a,b,m),
//      ' a='+IntToStr(a)+' b='+IntToStr(b)+' m='+IntToStr(m) );
//    assert( slow_mul(a,b,m) = fast2_mul(a,b,m),
//      ' a='+IntToStr(a)+' b='+IntToStr(b)+' m='+IntToStr(m)+' -- '+IntToStr(fast2_mul(a,b,m)) );
    writeln(a,' ',b,' ',m);
  end;
(*  T := GetTime;
  slow_mul(2349875,10000000,445346);
  T := (GetTime - T) * 60 * 60 * 24 * 1000;
  writeln('slow_mul:',T:0:0);
  T := GetTime;
  fast_mul(2349875,10000000,445346);
  T := (GetTime - T) * 60 * 60 * 24 * 1000;
  writeln('fast_mul:',T:0:0);
  T := GetTime;
  fast2_mul(2349875,10000000,445346);
  T := (GetTime - T) * 60 * 60 * 24 * 1000;
  writeln('fast2_mul:',T:0:0); *)
end.
