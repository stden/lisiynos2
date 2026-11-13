{$B-,I+,N+,O-,Q+,R+,S+}
{$APPTYPE CONSOLE}
Program GenTests;
uses SysUtils;

const TaskName = 'maxdist';
 MaxN = 100; MaxC: Extended = 1E25; eps: Extended = 0.5;

var i, j, k, l, m, n: Integer;
 a, b: array [1..MaxN, 1..MaxN] of Boolean;
 x, y: array [1..MaxN] of Integer;
 ok: Boolean;
 xl, yl, p, q: Integer;

function vp (x0, y0, x1, y1, x2, y2: Integer): Extended;
begin
 result := (x1 - x0) * (y2 - y0) - (x2 - x0) * (y1 - y0);
end;

function intersect (x1, y1, x2, y2, x3, y3, x4, y4: Integer): Boolean;
begin
 result := (vp (x1, y1, x2, y2, x3, y3) *
            vp (x1, y1, x2, y2, x4, y4) < -eps) AND
           (vp (x3, y3, x4, y4, x1, y1) *
            vp (x3, y3, x4, y4, x2, y2) < -eps);
end;

BEGIN
 n := StrToInt (ParamStr (1));
 l := StrToInt (ParamStr (2));
 xl := StrToInt (ParamStr (3));
 yl := StrToInt (ParamStr (4));
 randseed := StrToInt (ParamStr (5));
 for i := 1 to n do
  repeat
   x[i] := random (xl * 2 + 1) - xl;
   y[i] := random (yl * 2 + 1) - yl;
   ok := True;
   for j := 1 to i - 2 do if ok then
    for k := j + 1 to i - 1 do if ok then
     if vp (x[i], y[i], x[j], y[j], x[k], y[k]) = 0 then
      ok := False;
  until ok;
 writeln;
 writeln (n);
 for i := 1 to n do
  writeln (x[i], ' ', y[i]);
 fillchar (a, sizeof (a), 0);
 fillchar (b, sizeof (b), 0);
 m := 0;
 while m < l do begin
  k := 0;
  for p := 1 to n - 1 do
   for q := p + 1 to n do
    if NOT b[p][q] then
     inc (k);
  if k = 0 then break;
  k := random (k) + 1;
  i := -1; j := -1;
  for p := 1 to n - 1 do if k > 0 then
   for q := p + 1 to n do if k > 0 then
    if NOT b[p][q] then begin
     dec (k);
     if k = 0 then begin
      i := p;
      j := q;
     end;
    end;
  assert ((i > 0) AND (j > 0));
  a[i][j] := True;
  a[j][i] := True;
  b[i][j] := True;
  for p := 1 to n - 1 do
   for q := p + 1 to n do
    if NOT b[p][q] then
     if intersect (x[i], y[i], x[j], y[j], x[p], y[p], x[q], y[q]) then
      b[p][q] := True;
  inc (m);
 end;
 writeln (m);
 for i := 1 to n - 1 do
  for j := i + 1 to n do
   if a[i][j] then
    writeln (i, ' ', j);
END.
