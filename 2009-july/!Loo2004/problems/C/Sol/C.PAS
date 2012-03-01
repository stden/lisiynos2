{
  Решение к задаче "C. Сумма простых"
  Автор: Степуленок Д.О.
}

{ Храним только нечётные числа }

{ (1000000/2) div 8 = 62500 }
var
  b : array [0..62500] of byte;

procedure setBit( N:longint; value:boolean );
var x,y : longint;
begin
  x := N div 8;
  y := N mod 8;
  if value=true then
    b[x] := b[x] or (1 shl y)
  else
    b[x] := b[x] and ($FF - (1 shl y));
end;

function getBit( N:longint ):boolean;
var x,y : longint;
begin
  x := N div 8;
  y := N mod 8;
  getBit := (b[x] and (1 shl y)) <> 0;
end;

const MaxN = 1000000;

var
  i,q,chislo : longint;
begin
  assign(output,'simple.txt'); rewrite(output);
  {}
  fillChar(b,sizeOf(b),$FF);
  for i:=1 to (MaxN div 2) do
    if getbit(i) then begin
      chislo := i*2+1; { Вычисляем реальное число }
      q := chislo+chislo;
      while q<=MaxN do begin
        if odd(q) then setbit( (q-1) div 2, false );
        q:=q+chislo;
      end;
    end;
  {}
  for i:=2 to (MaxN div 2) do
    if getBit(i-1) and getBit(i) then
      writeln(2,' ',i*2+1);
  close(output);
end.
