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

const TaskName = 'wave';
 MaxN = 102;

var i, j, k, l, m, n: Integer;
 a: array [1..MaxN, 1..MaxN] of Integer;
 sp: Boolean;

BEGIN
 reset (input, TaskName + '.in');
 rewrite (output, TaskName + '.out');
{$IFDEF DMI} while NOT seekeof do begin {$ENDIF}
 read (n, m, l);
 fillchar (a, sizeof (a), 63);
 for i := 1 to m do begin
  read (j, k);
  a[j][k] := 1;
  a[k][j] := 1;
 end;
 for i := 1 to n do
  a[i][i] := 0;
 for k := 1 to n do
  for i := 1 to n do
   for j := 1 to n do
    if a[i][j] > a[i][k] + a[k][j] then
     a[i][j] := a[i][k] + a[k][j];
 writeln (n);
 sp := False;
 for k := 0 to n - 1 do
  for i := 1 to n do
   if a[l][i] = k then begin
    if NOT sp then sp := True else write (' ');
    write (i);
   end;
 writeln;
{$IFDEF DMI} end; {$ENDIF}
END.
