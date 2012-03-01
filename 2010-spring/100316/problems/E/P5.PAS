{Pestov Oleg  30.02.2001}
{Combinatorics}
{$A+,B-,D+,E+,F-,G-,I+,L+,N-,O-,P+,Q+,R+,S+,T-,V+,X+}
{$M 65384,0,655360}


const maxf = 200;
      maxl = 100;
type tlong = array[0..maxl] of byte;
var f{ree}, n{umber} : longint;
    prv, cur : array[0..maxf] of tlong;

procedure readData;
var l{ength}, b{usy} : longint;
    i, t : longint;
begin
  b := 0;
  read(l);
  read(n);
  for i := 1 to n - 1 do
  begin
    read(t);
    b := b + t + 1;
  end;
  t := 0;
  if n <> 0 then read(t);
  b := b + t;
  f := l - b;
  n := n + 1;
end;

procedure setLong(var a : tlong; n : longint);
begin
  fillchar(a, sizeof(a), 0);
  a[0] := 1;
  a[1] := n;
end;

procedure addLong(var a : tlong; b, c : tlong);
var i, m : longint;
begin
  if b[0] > c[0] then m := b[0] else m := c[0];
  fillchar(a, sizeof(a), 0);
  for i := 1 to m do
  begin
    a[i + 1] := (a[i] + b[i] + c[i]) div 10;
    a[i] := (a[i] + b[i] + c[i]) mod 10;
  end;
  if a[m + 1] <> 0 then a[0] := m + 1 else a[0] := m;
end;

procedure c_n_k(n, k : longint);
var i, j : longint;
begin
  fillchar(prv, sizeof(prv), 0);
  setLong(prv[0], 1);
  for i := 1 to n do
  begin
    setLong(cur[0], 1);
    for j := 1 to k do addLong(cur[j], prv[j], prv[j - 1]);
    prv := cur;
  end;

  for i := cur[k][0] downto 1 do write(cur[k][i]);
  writeln;
end;

begin
  assign(input, 'input.txt'); reset(input);
  assign(output, 'output.txt'); rewrite(output);
  readData;
  if f < 0 then writeln('0') else c_n_k(f + n - 1, n - 1);
end.