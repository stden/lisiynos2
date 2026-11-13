const name='27';
      n=100;
var i,j:longint;
    RandSeed: Cardinal;
    p: array [1..n] of Longint;

const RANDMULT: Extended = 1.0 / 65536.0 / 65536.0;
function Random (lim: Cardinal): Longint;
begin
  {$Q-}
  RandSeed := RandSeed * 1664525 + 1013904223;
  {$Q+}
  Random := Trunc (RandSeed * RANDMULT * lim);
end;

begin
  randseed:=12349;
  fillchar (p, sizeof (p), 0);
  for i := 1 to n do begin
    j := Random (i) + 1;
    p[i] := p[j];
    p[j] := i;
  end;
  writeln(n);
  for i:=1 to n do
    for j:=1 to n do begin
      if ((p[i] = 1) AND (p[j] = 2)) OR
         ((p[i] = n - 1) AND (p[j] = n)) OR
         ((p[i] >= 2) AND (p[i] < n) AND (p[j] >= 2) AND (p[j] < n) AND
          (p[j] - 1 = (p[i] - 1) mod (n - 2) + 1)) then
        write('-1')
      else 
        write('48');
      if j < n then write (' ') else writeln;
    end;
end.
