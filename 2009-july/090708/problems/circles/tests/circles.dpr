{$O+,Q+,R+,S-}
{$APPTYPE CONSOLE}
program macro;
const MaxK = 10000;  MaxX = 1000;  MaxR = 1000;
      eps=0.5e-14{0.5e-14};
type float = extended;
     point = record x, y : float end;
var
  M      : integer;
  P      : array [1..2] of point;
  xc, yc : integer;

procedure addp (x, y, z : float);
var k : integer;
begin
  x := x/z + xc;
  y := y/z + yc;
  inc (M);  k := M;
  if (M = 2) and ((x < P[1].x) or ((x = P[1].x) and (y < P[1].y))) then
    begin P[2] := P[1];  k := 1 end;
  if abs(x) < eps then x := 0;
  if abs(y) < eps then y := 0;
  P[k].x := x;
  P[k].y := y
end;

var
  i, j, K  : integer;
  R, x1, y1, R1  : integer;
  A, B, C, S, D  : comp;
  t              : float;
begin
  assign (input, 'circles.in');  reset (input);
  assign (output, 'circles.out');  rewrite (output);
  read (K);  if (K <= 0) or (K > MaxK) then runerror (239);
  for i := 1 to K do begin
    if i > 1 then writeln;
    read (xc, yc, R);
    if (abs(xc) > MaxX) or (abs(yc) > MaxX) or (R <= 0) or (R > MaxR) then runerror (239);
    read (x1, y1, R1);
    if (abs(x1) > MaxX) or (abs(y1) > MaxX) or (R1 <= 0) or (R1 > MaxR) then runerror (239);
    dec (x1, xc);  dec (y1, yc);
    M := 0;
    if (x1 <> 0) or (y1 <> 0) then begin
      A := 2*x1;
      B := 2*y1;
      C := sqr(R) - sqr(R1) + sqr(x1) + sqr(y1);
      S := sqr(A) + sqr(B);
      D := sqr(R)*S - sqr(C);
      if D > 0 then begin
        t := sqrt (D);
        addp (A*C+B*t, B*C-A*t, S);
        addp (A*C-B*t, B*C+A*t, S)
      end else if D = 0 then addp (A*C, B*C, S)
    end else if (R = R1) then M := -1;
    case M of
    -1: writeln ('I can''t count them - too many points :(');
    0:  writeln ('There are no points!!!')
    else begin
      writeln ('There are only ', M, ' of them....');
      for j := 1 to M do writeln (P[j].x:14:14, ' ', P[j].y:14:14)
    end end
  end
end.