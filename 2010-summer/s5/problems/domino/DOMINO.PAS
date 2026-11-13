{ bp }

(* Problem  : 	DOMINO
 * Contest  : 	UOI-2005 (Rovno)
 * Type     : 	Solution
 * Author   : 	Andrey Stasyuk
 * Language :	Pascal
 * Compiler :	Borland Pascal 7.0
 * Algorithm:	Optimal with time O(M*M)
 *)

{$R+}
const
  maxM = 100;
var
  fi, fo: text;
  nabor: array[0..maxM, 0..maxM] of byte; {1 - kostyashka est' v nabore; 0 - net}
  power: array[0..maxM] of integer;       {stepen' vershiny}
  comp: array[0..maxM] of integer;        {k kakoy komponente prinadlejut vershina}
  numodd: array[1..maxM + 1] of integer;  {kol-vo nechetnyh vershin v komponente}
  N, M, i, j: integer;
  a, b, curcomp: integer;
  result: integer;

  procedure dfs(what: integer);
  var
    i: integer;
  begin
    comp[what] := curcomp;
    for i := 0 to M do
      if (nabor[what, i] = 1) AND (comp[i] = 0) then
        dfs(i);
  end;

begin

{INPUT}
  fillchar(nabor, sizeof(nabor), 1);
  assign(fi, 'domino.dat');
  reset(fi);
  readln(fi, M);
  readln(fi, N);
  for i := 1 to N do
  begin
    readln(fi, a, b);
    nabor[a, b] := 0;
    nabor[b, a] := 0;
  end;
  close(fi);

{POWERS}
  for i := 0 to M do
    for j := i to M do
    if nabor[i, j] = 1 then
    begin
      inc(power[i]);
      inc(power[j]);
    end;

{CONNECTIVE COMPONENTS}
  for i := 0 to M do
    if power[i] = 0 then
      comp[i] := 255
    else
    if comp[i] = 0 then
    begin
      inc(curcomp);
      dfs(i);
    end;

{EULER'S RULE}
  for i := 0 to M do
    if odd(power[i]) then
      inc(numodd[comp[i]]);

{RESULT}
  for i := 1 to curcomp do
    if numodd[i] = 0 then
      result := result + 1
    else
      result := result + numodd[i] div 2;

{OUTPUT}
  assign(fo, 'domino.sol');
  rewrite(fo);
  writeln(fo, result);
  close(fo);
end.