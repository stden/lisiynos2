{$DEFINE DO0}
{$DEFINE DMI}
{$DEFINE DEBUG}
{$IFDEF DEBUG}
{$B-,I+,N+,O-,Q+,R+,S+}
{$ELSE}
{$B-,I-,N+,O+,Q-,R-,S-}
{$ENDIF}
{$APPTYPE CONSOLE}
Program CheckSol;
uses SysUtils;

const TaskName = 'step';
 MaxN = 100; MaxM = 10000; MaxR = 10000;
 OK = 0; WA = 1; PE = 2; JE = 3;

var i, j, k, l, m, n: Integer;
 a: array [1..MaxN, 1..MaxN] of Boolean;
 p: array [1..MaxR] of Integer;
 b: array [1..MaxN] of Boolean;
 fin, fout: Text;
 r, r0: Integer;

procedure assert_je (a: Boolean);
begin
 if NOT a then begin
  writeln ('Assertion failed');
  halt (JE);
 end;
end;

procedure halt_chk (code: Integer; msg: String);
begin
 writeln (msg);
 halt (code);
end;

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
 {$I-}
 reset (fin, ParamStr (1));
 if IOResult <> 0 then halt_chk (JE, 'No input file');
 {$I+}
 read (fin, n, m, l);
 assert_je ((n >= 1) AND (n <= MaxN));
 assert_je ((m >= 0) AND (m <= MaxM));
 assert_je ((l >= 1) AND (l <= n));
 fillchar (a, sizeof (a), 0);
 for i := 1 to m do begin
  read (fin, j, k);
  assert_je ((j >= 1) AND (j <= n));
  assert_je ((k >= 1) AND (k <= n));
  a[j][k] := True;
  a[k][j] := True;
 end;
 assert_je (seekeof (fin));
 close (fin);

 fillchar (b, sizeof (b), 0);
 recur (1);
 for i := 1 to n do
  assert_je (b[i]);

 fillchar (b, sizeof (b), 0);
 fillchar (p, sizeof (p), 0);
 {$I-}
 reset (fout, ParamStr (2));
 if IOResult <> 0 then halt_chk (PE, 'No output file');
 {$I+}
 read (fout, r0);
 if (r0 < 1) OR (r0 > MaxR) then halt_chk (WA, 'Illegal pass length');
 r := 0;
 while NOT seekeof (fout) do begin
  inc (r);
  if r > r0 then halt_chk (PE, 'Pass too long');
  read (fout, p[r]);
  if (p[r] < 1) OR (p[r] > n) then halt_chk (WA, 'No such vertex');
  if r > 1 then
   if NOT a[p[r - 1]][p[r]] then halt_chk (WA, 'No such edge in graph');
  b[p[r]] := True;
 end;
 if r <> r0 then halt_chk (PE, 'Pass length mismatch');
 if (p[1] <> l) OR (p[r] <> l) then halt_chk (WA, 'Start or end not in place');
 for i := 1 to n do
  if NOT b[i] then halt_chk (WA, 'Vertex not visited.');
 close (fout);
 halt_chk (OK, 'OK');
END.
