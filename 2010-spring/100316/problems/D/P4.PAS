{$A+,B-,D+,E+,F-,G-,I+,L+,N-,O-,P-,Q+,R+,S+,T-,V+,X+}
{$M 16384,0,655360}
{Oleg Pestov. Solution 2}
const maxn = 180;
      maxk = 80;
var n, k : integer;
    p : array[1..maxn] of longint;
    s : array[1..maxn + 1] of longint;
    a : array[1..maxn + 1, 0..maxk] of longint;

procedure readData;
var i : integer;
begin
  s[1] := 0;
  read(n);
  for i := 1 to n do
  begin
    read(p[i]);
    s[i + 1]:= s[i] + p[i];
  end;
  read(k);
end;

function max(x, y : longint) : longint;
begin
  if x > y then max := x else max := y;
end;

procedure solve;
var i, t : integer;
begin
  fillchar(a,sizeof(a), 0);

  for i := n downto 1 do
    for t := 1 to maxk do
    begin
      a[i, t] := a[i, t - 1];
      if (i + t <= n + 1) and (a[i, t] < s[n + 1] - s[i] - a[i + t, t]) then
        a[i, t] := s[n + 1] - s[i] - a[i + t, t];
    end;

  writeln(a[1, k]);
end;

begin
  assign(input, 'input.txt'); reset(input);
  assign(output, 'output.txt'); rewrite(output);
  readData;
  solve;
end.