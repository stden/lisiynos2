const name='18';
      n=100;
      c=7;
var i,j:longint;
    RandSeed: Cardinal;

const RANDMULT: Extended = 1.0 / 65536.0 / 65536.0;
function Random (lim: Cardinal): Longint;
begin
  {$Q-}
  RandSeed := RandSeed * 1664525 + 1013904223;
  {$Q+}
  Random := Trunc (RandSeed * RANDMULT * lim);
end;

begin
  randseed:=1;
  writeln(n);
  for i:=1 to n do
    for j:=1 to n do begin
      if (random(c)=0)and(i<>j) then
        write(random(20000)-10000)
      else
        if i=j then
          write('0')
        else
          write('100000');
      if j < n then write (' ') else writeln;
    end;
end.
