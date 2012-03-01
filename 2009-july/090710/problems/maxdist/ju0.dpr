{Floyd-Warshall algorithm (Флойд-Уоршолл)}
{Suitable for N up to about 400}
{O (N^3)}
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
 for k := 1 to n do
  for i := 1 to n do
   for j := 1 to n do
    if a[i][j] > a[i][k] + a[k][j] then
     a[i][j] := a[i][k] + a[k][j];
 max := -1.0;
 for i := 1 to n do
  for j := 1 to n do
   if max < a[i][j] then
    max := a[i][j];
 {The solution ends here}
 if max = MaxC then max := -1;
 writeln (max:0:12);
{$IFDEF DMI} until seekeof; {$ENDIF}
END.
