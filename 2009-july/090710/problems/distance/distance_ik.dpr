{$DEFINE DO0}
{$DEFINE DMI}
{$DEFINE DEBUG}
{$IFDEF DEBUG}
{$B-,I+,N+,O-,Q+,R+,S+}
{$ELSE}
{$B-,I-,N+,O+,Q-,R-,S-}
{$ENDIF}
{$APPTYPE CONSOLE}
Program JurySol;
uses SysUtils;

const TaskName = 'distance';
 MaxN = 102; MaxC = $3F3F3F3F;

var i, j, k, l, m, n: Integer;
 a: array [1..MaxN, 1..MaxN] of Integer;

BEGIN
 reset (input, TaskName + '.in');
 rewrite (output, TaskName + '.out');
{$IFDEF DMI} while NOT seekeof do begin {$ENDIF}
 read (n, m);
 fillchar (a, sizeof (a), 63);
 for i := 1 to m do begin
  read (j, k, l);
  if a[j][k] > l then begin
   a[j][k] := l;
   a[k][j] := l;
  end;
 end;
 for i := 1 to n do
  a[i][i] := 0;
 for k := 1 to n do
  for i := 1 to n do
   for j := 1 to n do
    if a[i][j] > a[i][k] + a[k][j] then
     a[i][j] := a[i][k] + a[k][j];
 read (j, k);
 l := a[j][k];
 if l = MaxC then l := -1;
 writeln (l);
{$IFDEF DMI} end; {$ENDIF}
END.
