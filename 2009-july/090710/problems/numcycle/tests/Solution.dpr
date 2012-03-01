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

const TaskName = 'numcycle';
 MaxN = 12;

var i, j, k, m, n: Integer;
 a: array [1..MaxN, 1..MaxN] of Boolean;
 b: array [1..MaxN] of Boolean;
 first, second, ans: Integer;

procedure recur (prev, cur: Integer);
var i: Integer;
begin
 b[cur] := True;
 if (cur > second) AND a[cur][first] then inc (ans);
 for i := first + 1 to n do
  if NOT b[i] AND a[cur][i] then
   recur (cur, i);
 b[cur] := False;
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
 ans := 0;
 for i := 1 to n do
  for j := i + 1 to n do begin
   first := i;
   second := j;
   recur (i, j);
  end;
 writeln (ans);
{$IFDEF DMI} end; {$ENDIF}
END.
