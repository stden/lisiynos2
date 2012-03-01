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

const TaskName = 'wave';
 MaxN = 100; MaxM = 10000; MaxR = 10000; MaxC = $3F3F3F3F;
 OK = 0; WA = 1; PE = 2; JE = 3;

var i, j, k, l, m, n: Integer;
 a: array [1..MaxN, 1..MaxN] of Integer;
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

BEGIN
 {$I-}
 reset (fin, ParamStr (1));
 if IOResult <> 0 then halt_chk (JE, 'No input file');
 {$I+}
 read (fin, n, m, l);
 assert_je ((n >= 1) AND (n <= MaxN));
 assert_je ((m >= 0) AND (m <= MaxM));
 assert_je ((l >= 1) AND (l <= n));
 fillchar (a, sizeof (a), 63);
 for i := 1 to m do begin
  read (fin, j, k);
  assert_je ((j >= 1) AND (j <= n));
  assert_je ((k >= 1) AND (k <= n));
  a[j][k] := 1;
  a[k][j] := 1;
 end;
 assert_je (seekeof (fin));
 close (fin);

 for i := 1 to n do
  a[i][i] := 0;
 for k := 1 to n do
  for i := 1 to n do
   for j := 1 to n do
    if a[i][j] > a[i][k] + a[k][j] then
     a[i][j] := a[i][k] + a[k][j];
 for i := 1 to n do
  for j := 1 to n do
   assert_je (a[i][j] < MaxC);

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
   if a[l][p[r - 1]] > a[l][p[r]] then halt_chk (WA, 'Non-monotonic sequence');
  b[p[r]] := True;
 end;
 if r <> r0 then halt_chk (PE, 'Pass length mismatch');
 if (p[1] <> l)then halt_chk (WA, 'Start not in place');
 for i := 1 to n do
  if NOT b[i] then halt_chk (WA, 'Vertex not visited.');
 close (fout);
 halt_chk (OK, 'OK');
END.
