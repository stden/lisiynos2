{Ford-Bellman algorithm - relaxation}
{(Алгоритм Форда-Беллмана - релаксация)}
{O (n^4)}
{The Ford-Bellman algorithm itself is O (n^3)}
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
 max: Extended;

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
  w[k] := 0.0;
  for l := 1 to n - 1 do
   for i := 1 to n do
    for j := 1 to n do
     if w[j] > w[i] + a[i][j] then
      w[j] := w[i] + a[i][j];
  for i := 1 to n do
   if max < w[i] then
    max := w[i];
 end;
 {The solution ends here}
 if max = MaxC then max := -1;
 writeln (max:0:12);
{$IFDEF DMI} until seekeof; {$ENDIF}
END.
