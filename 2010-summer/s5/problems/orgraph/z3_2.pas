{$A+,B-,D+,E-,F-,G+,I+,L+,N+,O-,P-,Q-,R-,S-,T-,V+,X+,Y+}
{$M 63384,0,655360}

program Suh;

type TarrI = array [1..10000] of integer;
     ParrI = ^TarrI;

var n: integer;
    m: integer;
    lb, le: array [1..10000] of integer;
    time: longint absolute $0000:$046C;
    times: longint;
    lc: integer;
    fl, ll: array [0..100] of integer;
    vv,v: array [1..100] of integer;
    badr: ParrI;
    g: array [1..100, 1..100] of shortint;
    rb, re: array [1..300] of integer;
    rc: integer;
    TreeB: array [0..100] of integer;
    Trees: integer;
    OneLeaf: array [0..100] of integer;
    cv, bc: integer;
    comps: integer;
    Forbb, Forbe: integer;
    ref: array [1..100] of integer;
    Leafs: integer;
    LeafsThere: array [1..100] of integer;
    Bral: array [1..100] of integer;

procedure ReadAll;
var i, j: integer;
begin
  assign (input, 'input.txt');
  reset (input);
  readln (n);
  lc := 0;
    while not SeekEof (input) do
    begin
      read (input, i, j);
      inc (lc);
      lb [lc] := i;
      le [lc] := j;
      inc (lc);
      lb [lc] := j;
      le [lc] := i;
    end;
  close (input);
end;

procedure SortLinks (l, r: integer);
var i, j, x, y: integer;
begin
  i := l; j := r; x := lb [(l+r) div 2];
  repeat
    while lb [i] < x do inc (i);
    while x < lb [j] do dec (j);
    if i <= j then
     begin
       y := lb [i]; lb [i] := lb [j]; lb [j] := y;
       y := le [i]; le [i] := le [j]; le [j] := y;
       inc (i);
       dec (j);
     end;
  until i > j;
  if l < j then SortLinks (l, j);
  if i < r then SortLinks (i, r);
end;


procedure PrepareLinks;
var i, j, q: integer;
begin
  SortLinks (1, lc);
  q := 0;
  for i := 1 to lc do
    while lb [i] > q do
      begin
        ll [q] := i-1;
        inc (q);
        fl [q] := i;
      end;
  ll [q] := lc;
  for i := 1 to n do if fl[i] = 0 then fl [i] := lc+3;
end;

procedure Bulk (a: byte);
var i: integer;
begin
  v[a] := 1;
  for i := fl [a] to ll[a] do
  if v[le[i]] = 0 then
     if not ((a = ForbB) and (le[i] = ForbE)) then
     if not ((a = ForbE) and (le[i] = ForbB)) then
     Bulk (le[i]);
end;

function FindComps: integer;
var i, c: integer;
begin
  for i := 1 to n do v[i] := 0;
  c := 0;
  for i := 1 to n do
  if v[i] = 0 then
   begin
     inc (c);
     bulk (i);
   end;
  FindComps := c;
end;

procedure TaskA;
begin
  ForbB := 0; ForbE := 0;
  Comps := FindComps;
  writeln (Comps);
end;

procedure TaskB;
var i: integer;
    c: integer;
label Fail;
begin
  bc := 0;
  if lc > ((n-2) * (n-1)) then goto Fail;
  for i := 1 to lc do
  if lb[i] < le[i] then
  begin
    if Time-Times > 127 then goto Fail;
    ForbB := lb [i];
    ForbE := le [i];
    c := FindComps;
    if c > Comps then
      begin
        inc (bc);
        badr^[bc] := i;
      end;
  end;
Fail: writeln (bc);
    for i := 1 to bc do
      writeln (lb[badr^[i]], ' ',le[badr^[i]]);
end;

procedure TaskV;
begin
  if Comps <> 1 then exit;
  if bc = 0 then writeln ('POSSIBLE') else writeln ('NOT POSSIBLE');
end;

procedure DirSo (x, y: integer);
begin
  writeln (x, ' ', y);
  g[x, y] := 0;
  g[y, x] := 0;
end;

procedure SearchDeep (a: integer);
var i: integer;
begin
  v[a] := 1;
  for i := fl [a] to ll [a] do
  if g[a, le[i]] <> 0 then
      if v[le[i]] = 0 then
         begin
           DirSo (a, le[i]);
           SearchDeep (le[i]);
         end else
         begin
           DirSo (a, le[i]);
         end;
end;

procedure Orient (a: integer);
begin
  v[a] := a;
  SearchDeep (a);
end;

procedure BuildGraph;
var i, j: integer;
begin
  FillChar (g, sizeof (g), 0);
  for i := 1 to lc do
    g[lb[i], le[i]] := 1;
end;

procedure KillBad;
var i, x, y: integer;
begin
  for i := 1 to bc do
  begin
    x := lb[badr^[i]];
    y := le[badr^[i]];
    g [x, y] := 0;
    g [y, x] := 0;
  end;
end;


procedure TaskG;
var i: integer;
begin
  if Comps <> 1 then exit;
  writeln ((lc div 2)-bc);
  BuildGraph;
  KillBad;
  for i := 1 to n do
    v[i] := 0;
  for i := 1 to n do
    if v[i] = 0 then Orient (i);
end;

procedure Fill (a, c: integer);
var i: integer;
begin
  v[a] := c;
  for i := fl [a] to ll [a] do
  if g[a, le[i]] <> 0 then
      if v[le[i]] = 0 then Fill (le[i], c);
end;

procedure BuildCondensedGraph;
var i: integer;
begin
 FillChar (g, sizeof (g), 0);
  for i := 1 to lc do
    g[vv[lb[i]], vv[le[i]]] := 1;
  for i := 1 to cv do g[i, i] := 0;
end;

var leaf: array [1..100] of boolean;

procedure GetTree (a: integer);
var i: integer;
begin
  v[a] := 1;
  leaf [a] := true;
  for i := 1 to cv do
  if g [a, i] > 0 then
    if v[i] = 0 then
    begin
      leaf [a] := false;
      GetTree (i);
    end;
end;

procedure CheckIfLeaf (a: integer);
var j, i: integer;
begin
  j := 0;
  for i := 1 to cv do
    if g[a,i] > 0 then inc (j);
  if j = 1 then leaf[a] := true else Leaf[a] := false;
end;

procedure CountLeafs;
var i: integer;
begin
  Leafs := 0;
  for i := 1 to cv do
    if leaf[i] then inc (Leafs);
end;

procedure ProcessSimpleTree;
var i, j: integer;
begin
  i := 1; while leaf[i] = false do inc (i);
  j := i+1; while leaf[j] = false do inc (j);
  inc (rc);
  rb[rc] := i;
  re[rc] := j;
end;

procedure MoveFromLeaf (var a: integer);
var i: integer;
begin
  for i := 1 to cv do
  if g[a, i] > 0 then
    begin
      a := i;
      exit;
    end;
end;

procedure SubLeafsThere (a: integer; branch: byte);
var i: integer;
    j: integer;
begin
  j := 0;
  v[a] := 2;
  for i := 1 to cv do
  if (v[i] = 0) then
    if g[a, i] > 0 then
      begin
        SubLeafsThere (i, branch);
        j := 2;
      end;
 if leaf [a] then
     begin
       inc (LeafsThere [Branch]);
       bral[a] := Branch;
     end;
end;

procedure CalcLeafsThere (a: integer);
var i: integer;
begin
  for i := 1 to cv do v[i] := 0;
  for i := 1 to cv do LeafsThere[i] := 0;
  v[a] := 1;
  for i := 1 to n do
  if g[a, i] > 0 then if v[i] = 0 then
    SubLeafsThere (i, i);
end;

function ManyBranchesHaveLeafs: boolean;
var i, j: integer;
begin
  j := 0;
  for i := 1 to cv do
    if LeafsThere [i] > 0 then inc (j);
  if j > 1 then ManyBranchesHaveLeafs := true
           else ManyBranchesHaveLeafs := false;
end;

procedure FindTwoLeafs;
var max, max1: integer;
    bst, bst1: integer;
    i, j: integer;
begin
  max := 0; bst := 0;
  for i := 1 to cv do
    if LeafsThere [i] > max then
      begin max := LeafsThere[i]; bst := i; end;
  max1 := 0;
  bst1 := 0;
  for i := 1 to cv do
    if LeafsThere [i] > max1 then
      if i <> bst then
      begin max1 := LeafsThere[i]; bst1 := i; end;

  dec (LeafsThere [bst]);
  dec (LeafsThere [bst1]);
  dec (Leafs, 2);
  inc (rc);
  for i := 1 to cv do
    if leaf[i] and (Bral [i] = bst)  then
      begin leaf[i] := false; rb [rc] := i; break; end;
  for i := 1 to cv do
    if leaf[i] and (Bral [i] = bst1) then
      begin leaf[i] := false; re [rc] := i; break; end;
end;

procedure MoveToNextNode (var a: integer);
var i: integer;
begin
  for i := 1 to cv do
   if LeafsThere [i] > 0 then
      begin
        a := i;
        exit;
      end;
end;

procedure TreatLastLeaf;
var i,  l: integer;
begin
  for i := 1 to cv do
    if leaf [i] then begin l := i; break; end;
  for i := 1 to cv do
    if (v[i] > 0) and (g[l, i] = 0) then
      begin
        inc (rc);
        rb[rc] := l;
        re[rc] := i;
        exit;
      end;
end;

procedure PartProcessTree (a: integer);
var i: integer;
label BigTree;
begin
  for i := 1 to cv do leaf [i] := false;
  v[a] := 1;
  inc (Trees);
  TreeB [Trees] := rc + 1;
  for i := 1 to cv do
    if g [i, a] <> 0 then Goto BigTree;
{  inc (rc);
  rb[rc] := a;
  re[rc] := a;}
  oneLeaf [Trees] := a;
  exit;

BigTree:
  GetTree (a);
  for i := 1 to cv do if Leaf[i] then
    begin
      OneLeaf [Trees] := i;
      exit;
    end;
end;

procedure ProcessTree (a: integer);
var i: integer;
label BigTree;
begin
  for i := 1 to cv do leaf [i] := false;
  v[a] := 1;
  inc (Trees);
  TreeB [Trees] := rc + 1;
  for i := 1 to cv do
    if g [i, a] <> 0 then Goto BigTree;
  inc (rc);
  rb[rc] := a;
  re[rc] := a;
  exit;

BigTree:
  GetTree (a);
  CheckIfLeaf (a);
  CountLeafs;
  if Leafs = 2 then
      begin
        ProcessSimpleTree;
        exit;
      end;
  { Brrrr!.. }
  if leaf [a] then MoveFromLeaf (a);
  CalcLeafsThere (a);
  repeat
    while ManyBranchesHaveLeafs do
      FindTwoLeafs;
    if (Leafs >= 2) then
        begin
          MoveToNextNode (a);
          CalcLeafsThere (a);
        end;
  until Leafs < 2;
  if Leafs = 1 then TreatLastLeaf;
end;

procedure TaskD;
var savrb, rcc, i: integer;
begin
  BuildGraph;
  KillBad;
  for i := 1 to n do
    v[i] := 0;
  cv := 0;
  for i := 1 to n do
  if v[i] = 0 then
  begin
    inc (cv); Fill (i, cv);
    ref [cv] := i;
  end;
  vv := v;
  BuildCondensedGraph;
rc := 0;
{}  repeat
      for i := 1 to cv do
        v[i] := 0;
      Trees := 0; TreeB [0] := 0;
      for i := 1 to cv do
        if v[i] = 0 then PartProcessTree (i);
      if trees > 1 then
         begin
           inc (rc);
           rb[rc] := OneLeaf[1];
           re[rc] := OneLeaf[2];
           g[OneLeaf[1], OneLeaf[2]] := 1;
           g[OneLeaf[2], OneLeaf[1]] := 1;
         end;
{}  until trees <= 1;

  for i := 1 to cv do
    v[i] := 0;
  Trees := 0; TreeB [0] := 0;
  for i := 1 to cv do
    if v[i] = 0 then ProcessTree (i);
  if trees > 1 then
      begin
        SavRb := rb[Treeb[1]];
        for i := 1 to Trees-1 do
        begin
          rb [Treeb[i]] := re [Treeb[i]];
          re [Treeb[i]] := rb [Treeb[i+1]];
        end;
        rb [Treeb[Trees]] := re[Treeb[Trees]];
        re [Treeb[Trees]] := Savrb;
      end;
  rcc := rc;
  for i := 1 to rc do if rb[i] = re[i] then dec (rcc);
  writeln (rcc);
  for i := 1 to rc do
    if rb[i] <> re [i] then writeln (ref[rb[i]], ' ', ref[re[i]]);
end;

procedure Solve;
begin
  assign (output, 'output.txt'); rewrite (output);
  PrepareLinks;
  TaskA;
  TaskB;
  TaskV;
  TaskG;
  TaskD;
  close (output);
end;

begin
  times := time;
  new (badr);
  ReadAll;
  Solve;
end.