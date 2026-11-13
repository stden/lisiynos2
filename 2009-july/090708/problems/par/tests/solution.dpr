{$apptype console}

uses SysUtils;

function Zp( n,p : int64 ):int64;
begin
  assert( p > 0 );
  if n<0 then
    result := (p-1) - ((-n-1) mod p)
  else
    result := n mod p;
end;

{ Вариант должен быть медленнее из-за тормозов с mod -
  но на деле оказывается что почти одно и то же :) }
function Zp2( n,p : int64 ):int64;
begin
  assert( p > 0 );
  if n<0 then
    result := (p - (-n mod p)) mod p
  else
    result := n mod p;
end;

function Zp_Longint( n,p : Longint ):Longint;
begin
  assert( p > 0 );
  if n<0 then
    result := (p - (-n mod p)) mod p
  else
    result := n mod p;
end;

var
  i:Integer;
  Start,Diff : TDateTime;
  L : Longint;
  a,b : Int64;
begin
  { Проверки }
    assert( Zp(i,7) = Zp2(i,7) );

  assign(input,'par.in'); reset(input);
  assign(output,'par.out'); rewrite(output);
  repeat
    read(A1,B1,C1);
    read(A2,B2,C2);
  until 
  read(a,b);
  writeln(Zp(a,b));
end.