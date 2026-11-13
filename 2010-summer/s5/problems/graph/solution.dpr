program macro;
{$G+,F-,B-,O-,S-,R-,N-,E-}

const
  infile        = 'graph.in';
  outfile       = 'graph.out';
  MaxN          = 100;
var
  G             : array [1..MaxN, 1..MaxN] of boolean;
  mark          : array [1..maxN] of integer;
  N, done, L    : integer;

function perfmark : boolean;
var
  i, j, C, cte, cto : integer;
  B                 : boolean;
begin
  for i:=2 to N do mark[i]:=0;
  mark[1] := 2; done:=0;
  perfmark := true;
  repeat
    cte := 0; cto := 0;
    repeat
      B := true;
      for i:=1 to N do
        if abs(mark[i])=2 then
          begin
            inc (done);
            B := false;
            C := -mark[i];
            if C < 0 then inc (cte) else inc (cto);
            mark[i] := -C div 2;
            for j:=1 to N do
              if G[i,j] then
                if mark[j]=0 then mark[j] := C else
                  if mark[j]*C < 0 then exit;
          end
    until B;
    if cte < cto then C:=-4 else C:=4;
    for i:=1 to N do
      if abs(mark[i])=1 then mark[i] := mark[i] * C;
    if (done < N) then
      for i:=1 to N do if mark[i]=0 then
        begin mark[i] := 2; break end;
  until done = N;
  perfmark := false;
  L := 0;
  for i:=1 to N do
    begin
      mark[i] := mark[i] div 4;
      if mark[i]=1 then inc(L)
    end
end;


var i, j : integer;
begin
  assign (input, infile); reset (input);
  read (N); for i:=1 to N do for j:=1 to N do G[i,j] := false;
  while not seekeof do
    begin read(i,j);
          G[i,j] := true;
          G[j,i] := true end;

  assign (output, outfile); rewrite (output);
  if perfmark then writeln ('YES') else
    begin
      writeln ('NO');
      writeln (L);
      for i:=1 to N do
        if mark[i]=1 then write(i,' ');
      writeln
    end
end.