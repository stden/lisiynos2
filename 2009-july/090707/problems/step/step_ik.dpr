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

const TaskName = 'step';
 MaxN = 102;

var i, j, k, l, m, n: Integer;
 a: array [1..MaxN, 1..MaxN] of Boolean;
 b: array [1..MaxN] of Boolean;
 sp: Boolean;

procedure recur (k: Integer);
var i: Integer;
begin
 b[k] := True;
 if NOT sp then sp := True else write (' ');
 write (k);
 for i := 1 to n do
  if a[k][i] AND NOT b[i] then begin
   recur (i);
   write (' ', k);
  end;
end;

BEGIN
 reset (input, TaskName + '.in');
 rewrite (output, TaskName + '.out');
{$IFDEF DMI} while NOT seekeof do begin {$ENDIF}
 read (n, m, l);
 fillchar (a, sizeof (a), 0);
 for i := 1 to m do begin
  read (j, k);
  a[j][k] := True;
  a[k][j] := True;
 end;
 fillchar (b, sizeof (b), 0);
 writeln ((n shl 1) - 1);
 sp := False;
 recur (l);
 writeln;
{$IFDEF DMI} end; {$ENDIF}
END.
