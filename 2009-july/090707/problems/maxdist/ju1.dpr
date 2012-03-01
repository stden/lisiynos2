{Dynamic programming - Dijkstra's algorithm}
{(Динамическое программирование - алгоритм Дейкстры)}
{O (n^3)}
{Could be improved to O (n * m log m) by using heap}
{The Dijkstra's algorithm itself is O (n^2) or O (m log m), respectively}
{Note that since it's a planar graph, m = O (n) here}
{$DEFINE DO0}
{$DEFINE DMI}
{$DEFINE DEBUG}
{$IFDEF DEBUG}
{$B-,I+,N+,O-,Q+,R+,S+}
{$ELSE}
{$B-,I-,N+,O+,Q-,R-,S-}
{$ENDIF}
{$APPTYPE CONSOLE}
Program OlympSol;
uses SysUtils;

const TaskName = 'maxdist';
 MaxN = 100; MaxC: Extended = 1E25;

var i, j, k, l, m, n: Integer;
 a: array [1..MaxN, 1..MaxN] of Extended;
 x, y: array [1..MaxN] of Integer;
 w: array [1..MaxN] of Extended;
 b: array [1..MaxN] of Boolean;
 p, q: Integer;
 min, max: Extended;

function rho (x1, y1, x2, y2: Integer): Extended;
begin
 result := sqrt (sqr (x2 - x1) + sqr (y2 - y1));
end;

BEGIN
 reset (input, TaskName + '.in');
 rewrite (output, TaskName + '.out');
{$IFDEF DMI} repeat {$ENDIF}
 read (n);
 for i := 1 to n do
  read (x[i], y[i]);
 for i := 1 to n do
  for j := 1 to n do
   a[i][j] := MaxC;
 for i := 1 to n do
  a[i][i] := 0.0;
 read (m);
 for j := 1 to m do begin
  read (k, l);
  a[k][l] := rho (x[k], y[k], x[l], y[l]);
  a[l][k] := a[k][l];
 end;
 {The solution starts here}
 max := -1.0;
 for k := 1 to n do begin
  for i := 1 to n do w[i] := MaxC;
  fillchar (b, sizeof (b), 0);
  j := k;
  w[j] := 0.0;
  repeat
   l := j;
   b[l] := True;
   min := MaxC;
   for i := 1 to n do if NOT b[i] then begin
    if w[i] > a[i][l] + w[l] then
     w[i] := a[i][l] + w[l];
    if min > w[i] then begin
     min := w[i]; j := i;
    end;
   end;
  until min = MaxC;
  for i := 1 to n do
   if max < w[i] then
    max := w[i];
 end;
 {The solution ends here}
 if max = MaxC then max := -1;
 writeln (max:0:12);
{$IFDEF DMI} until seekeof; {$ENDIF}
END.
