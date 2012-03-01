{$A+,B-,D+,E-,F-,G+,I+,L+,N+,O-,P-,Q+,R+,S+,T-,V-,X+,Y+}
{$M 65520,0,655360}
program macro;
const MaxN = 100; eps = 1e-14;
type float = extended;

var
  Xc, Yc, Rc  : array [1..MaxN] of float;
  N           : integer;

function is0 (x : float) : boolean;
begin is0 := abs(x) < eps end;

function getvdr (x, y : float) : float;
var alpha, t : float; F : boolean;
begin
  F := false;
  if abs(x) < abs(y) then begin F:=true; t:=x; x:=y; y:=t end;
  alpha := arctan (y/x);
  if x < 0 then alpha := alpha + Pi;
  if F then alpha := Pi/2 - alpha;
  getvdr := alpha
end;

function normang (alpha : float) : float;
begin
  while alpha >= 2 * Pi do alpha := alpha - 2 * Pi;
  while alpha < 0 do alpha := alpha + 2 * Pi;
  normang := alpha
end;

var
  alpha       : array [1..2*MaxN] of float;
  M           : integer;

procedure addintr (x0, y0, r0 : float);
var A, B, C, d, beta, gamma : float;
begin
  A := 2 * x0;  B := 2 * y0;  C := sqr(x0) + sqr(y0) + 1 - sqr(r0);
  if is0(A) and is0(B) then exit;
  d := 1 / sqrt (sqr(A) + sqr(B));
  if C < 0 then d := -d;
  A := A * d;  B := B * d;  C := C * d;
  beta := getvdr (A, B);
  if is0 (C - 1) then begin inc(M); alpha[M]:=beta; exit end;
  if C > 1 then exit;
  gamma := getvdr (C, sqrt(1-sqr(C)));
  inc (M, 2);
  alpha[M-1] := beta - gamma;  alpha[M] := beta + gamma
end;


var x0, t, y0, r0, x1, y1, r1, x2, y2, r2:float;
    i, k, kc:integer;

    xn, yn:array [1..2] of float;


begin
  assign (input, 'in.txt'); reset (input);
  assign (output, 'out.txt'); rewrite (output);
  read (k);
  for kc:=1 to k do begin
    N:=0; M:=0;
    read (x1, y1, r1);
    read (x2, y2, r2);
    if (abs (x1)>1000) or (abs (y1)>1000) or
       (abs (x2)>1000) or (abs (y2)>1000) or
       (r1<=0) or (r1>1000) or
       (r2<=0) or (r2>1000)
       then runerror (239);

    if (is0 (x2-x1)) and (is0 (y2-y1)) and (is0 (r2-r1)) then
      begin
        writeln ('I can''t count them - too many points :(');
        if kc<k then writeln;
        continue;
      end;

    x0:=(x2-x1)/r1;
    y0:=(y2-y1)/r1;
    r0:=r2/r1;
    addintr (x0, y0, r0);

    if m=0 then begin
      writeln ('There are no points!!!');
      if kc<k then writeln;
      continue;
    end;

    writeln ('There are only ', m, ' of them....');
    for i:=1 to m do
      begin
         xn[i]:=x1+r1*cos (alpha[i]);
         yn[i]:=y1+r1*sin (alpha[i]);
      end;
    if m=2 then
      if (xn[1]>xn[2]) or (is0 (xn[1]-xn[2]) and (yn[1]>yn[2])) then
        begin
          t:=xn[1];xn[1]:=xn[2];xn[2]:=t;
          t:=yn[1];yn[1]:=yn[2];yn[2]:=t;

        end;
    for i:=1 to m do writeln (xn[i]:0:14, ' ', yn[i]:0:14);
    if kc<k then writeln;
  end;
  if not seekeof then runerror (239);
end.

