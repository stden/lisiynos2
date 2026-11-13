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

const TaskName = 'incident';
 MaxN = 102; MaxM = 10004;

var i, j, k, m, n: Integer;
 a: array [1..MaxN, 1..MaxM] of Byte;

BEGIN
 reset (input, TaskName + '.in');
 rewrite (output, TaskName + '.out');
{$IFDEF DMI} while NOT seekeof do begin {$ENDIF}
 read (n, m);
 fillchar (a, sizeof (a), 0);
 for i := 1 to m do begin
  read (j, k);
  a[j][i] := 1;
  a[k][i] := 1;
 end;
 for i := 1 to n do
  for j := 1 to m do begin
   write (a[i][j]);
   if j < m then write (' ') else writeln;
  end;
{$IFDEF DMI} end; {$ENDIF}
END.
