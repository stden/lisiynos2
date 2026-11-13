const name='24';
      n=100;
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
  randseed:=12346;
  writeln(n);
  for i:=1 to n do
    for j:=1 to n do begin
      if ((i = 1) AND (j = 2)) OR
         ((i = n - 1) AND (j = n)) OR
         ((i >= 2) AND (i < n) AND (j >= 2) AND (j < n) AND
          ((i - 1) = (j - 1) mod (n - 2) + 1)) then
        write('-10000')
      else 
        write('100000');
      if j < n then write (' ') else writeln;
    end;
end.
