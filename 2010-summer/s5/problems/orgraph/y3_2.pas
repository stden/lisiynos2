{$A+,B-,D+,E+,F-,G-,I-,L+,N+,O-,P-,Q+,R+,S+,T-,V+,X+,Y+}
{$M 65520,0,655360}

 var i, j, k       : integer;
       t           : array [1..100, 1..100] of byte;
       answer      : text;
       n           : integer;
       visited     : array [1..100] of integer;
       NCC         : integer;
       bridge      : array [1..100, 1..100] of byte;
       ori         : array [1..100, 1..100] of byte;
       mark        : array [1..100, 1..100] of byte;
       q           : array [1..100] of integer;
       nn, cur     : integer;
       nm, when    : array [1..100] of integer;
       te, pred    : array [1..100] of integer;
       bc          : integer;
       ne          : integer;
       a           : integer;

function min (a, b : integer) : integer;
begin
  if a < b then min := a else min := b;
end;

function Search(prev, a : integer; num : integer) : integer;
var i : integer;
mn, q : integer;
begin

  if visited[a]=0 then visited[a] := num else
   begin search := when[a]; exit; end;

  inc(cur);when[a] := a; nm[a] := cur;
  for i := 1 to n do begin
    if (t[a][i]=1) and (i<>prev) then begin
     if ori[i][a] = 0 then ori[a][i] := 1;
     q := search(a, i, num);
     if nm[when[q]] > nm[a] then
       begin bridge[a][i] := 1; bridge[i][a] := 1; end;
     if nm[when[q]] < nm[when[a]] then when[a] := q;

    end; {if}
  end; {fr}
  search := when[a];
end; {search}

procedure add(a, b : integer);
var i : integer;
begin
 if a=b then exit;
 for i := 1 to q[a] do if mark[a][i] = b then exit;
 inc(q[a]); mark[a][q[a]] := b;
end;

procedure delete(a, b : integer);
var i : integer;
qq : integer;
begin
 qq := 1;
 for i := 1 to q[a] do
 begin
  mark[a][qq] := mark[a][i];
  if mark[a][i] <> b then inc(qq);
 end;
 dec(q[a]);
end;

procedure recover;
var i, j, k : integer;
    deleted : array [1..100] of byte;
     qq     : integer;
    r1, r2  : integer;
    used    : array [1..100] of byte;
    rem     : set of byte;
    p       : integer;
    nc      : integer;
    dc      : integer;

function remove( a, prev : integer) : boolean;
var i : integer;
begin
  used[a] := 1;
  for i := 1 to q[a] do
      if (used[mark[a][i]] = 1) then begin
       if (mark[a][i]<>prev) then
         begin remove := true; include(rem, a); exit; end
      end
      else  if remove(mark[a][i], a) then
       begin include(rem, a); exit; end;
  remove := false;
end; {search}

procedure optimize;
var i, j : integer;
a : integer;
begin
  r1 := -1; r2 := -1;
  dc := 2;

  for i := 1 to nn do
    if (deleted[i] = 0) and (q[i]<=1) then
     for j := 1 to nn do begin
      if (deleted[j] = 0) and (q[j]<=1) and (I<>J) then
        if ((q[i]=0) or (q[j]=0)) or (visited[pred[i]]<>visited[pred[j]]) then
         begin
          r1 := i; r2 := j; p := j;
          exit;
         end;

    end;

  for i := 1 to nn do
    if (deleted[i] = 0) and (q[i]<=1) then
     for j := 1 to nn do begin
      if (deleted[j] = 0) and (q[j]<=1) AND (I<>J) then begin
        if (q[i]=1) and (q[j]=1) and (mark[i][1]=j) then continue;
        r1 := i; r2 := j; p := mark[i][1];
        if mark[i][1]<>mark[j][1] then  exit;
        if q[mark[i][1]]>3 then exit;
      end;
    end;
{ dc := 1;}
end;

begin
  fillchar(deleted, sizeof(deleted), 0); nc := 0;
{  writeln('---------------');}
  for i := 1 to nn do begin
   if q[i] = 0 then inc(nc, 2);
   if q[i] = 1 then inc(nc, 1);
  end;

  writeln((nc+1) div 2);

  if nc>2 then
  repeat
     for i:= 1 to nn do
     if deleted[i]=0 then  begin
      if q[i]=2 then begin q[i] := 0;
       delete(mark[i][1], i);
       delete(mark[i][2], i);
       add(mark[i][1], mark[i][2]);
       add(mark[i][2], mark[i][1]);
       deleted[i] := 1;
      end;
     end;
     Optimize;
     add(r1, r2);
     add(r2, r1);

     for i := 1 to n do begin
       if visited[i] = visited[pred[r2]] then
            visited[i] := visited[pred[r1]];
     end;

     fillChar(used, sizeof(used), 0);
     rem := [];
     remove(r1, 0);
     for i := 1 to nn do begin
       for j := q[i] downto 1  do begin
        if not (i in rem) then
         if  (mark[i][j] in rem) then begin
           mark[i][j] := p ;
           if p<>0 then add(p, i);
         end;
        if (i in rem) and (i<>p) then
          delete(i, mark[i][j]);
       end;
     end;
     for i := 1 to nn do begin
       if (i in rem) and (i<>p) then deleted[i] := 1;
     end;
     writeln(pred[r1], ' ', pred[r2]);
     dec(nc, dc);
  until nc<=2;

  for i := 1 to nn do
   if (deleted[i] = 0) and (q[i]<=1) then
      begin write(pred[i], ' '); dc := i; end;
   if nc = 1 then writeln(pred[dc mod nn +1]);
  writeln;
end;


begin

   assign(input, 'input.txt'); reset(input);
   assign(output, 'output.txt'); rewrite(output);
   assign(answer, 'answer.$$$'); rewrite(answer);

   read(n);
   while not seekeof do begin
    read(i, j); t[i][j] := 1; t[j][i] := 1;
    inc(ne);
   end;
   fillChar(bridge, sizeof(bridge), 0);

   for i := 1 to n do
     if visited[i] = 0 then begin inc(ncc); search(0, i, ncc); end;

   bc := 0;

   for i := 1 to n do
    for j := i+1 to n do
      if bridge[i][j]=1 then inc(bc);

   writeln(ncc); writeln(answer, ncc);
   writeln(bc); writeln(answer, bc);

   for i := 1 to n do
    for j := i + 1 to n do
      if bridge[i][j] = 1 then
       begin
         writeln(i, ' ', j);
         writeln(answer, i, ' ', j);
       end;

   if ncc = 1 then begin {SOLVING C D subtasks}
     if bc = 0 then begin
        writeln('POSSIBLE');
        writeln(answer, 'POSSIBLE');
     end else begin
        writeln('NOT POSSIBLE');
        writeln(answer, 'NOT POSSIBLE');
     end;

     writeln(ne - bc);
     for i := 1 to n do begin
       for j := 1 to n do begin
        if (ori[i][j] = 1) and (bridge[i][j]=0) then writeln(i, ' ', j);
       end;
     end;
   end;
  {SOLVING E subtask}
   for i:=1 to N do begin
    a := i;
    repeat a := when[a]; until when[a]=a;
    j := i;
    repeat k := when[j];   when[j] := a;     j := k;  until when[j] = a;
   end;

   Fillchar(te, sizeof(te), 0);
   for i := 1 to N do
    if te[when[i]] = 0 then
     begin inc(nn); te[when[i]] := nn; end;

   FillChar(mark, sizeof(mark), 0);
   for i := 1 to n do
    for j := 1 to n do
     if (when[i]<>when[j]) and (t[i][j]=1) then begin
            add(te[when[i]], te[when[j]]);
            add(te[when[j]], te[when[i]])
     End;

   for i := 1 to n do begin
    pred[te[when[i]]] := i;
   end;
   if nn>1 then
   Recover else writeln(0);

   close(answer); close(output); close(input);
end.