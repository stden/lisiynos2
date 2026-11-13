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

const TaskName = 'connect';
 MaxN = 102;

var i, j, k, m, n: Integer;
 a: array [1..MaxN, 1..MaxN] of Boolean;
 b: array [1..MaxN] of Boolean;
 ok: Boolean;

procedure recur (k: Integer);
var i: Integer;
begin
 if b[k] then exit;
 b[k] := True;
 for i := 1 to n do
  if a[k][i] then
   recur (i);
end;

BEGIN
 reset (input, TaskName + '.in');
 rewrite (output, TaskName + '.out');
{$IFDEF DMI} while NOT seekeof do begin {$ENDIF}
 read (n, m);
 fillchar (a, sizeof (a), 0);
 for i := 1 to m do begin
  read (j, k);
  a[j][k] := True;
  a[k][j] := True;
 end;

 fillchar (b, sizeof (b), 0);
 recur (1);
 ok := True;
 for i := 1 to n do
  ok := ok AND b[i];
 if ok then writeln ('YES')
       else writeln ('NO');
{$IFDEF DMI} end; {$ENDIF}
END.
