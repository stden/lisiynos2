var q:array[1..19999] of integer;
    n,m,i,j:integer;
function min(a,b:integer):integer;
begin
  if a<b then min:=a else min:=b;
end;
procedure update(k,x:integer);
begin;
  k:=k+n-1;
  q[k]:=x;
  k:=k shr 1;
  while k>0 do begin
    q[k]:=min(q[k shl 1],q[k shl 1+1]);
    k:=k shr 1;
  end; 
end;
begin
  assign(input,'interval.in');
  assign(output,'interval.out');
  rewrite(output);
  reset(input);
  readln(m,n);
  for i:=n to n*2-1 do read(q[i]);
  for i:=n-1 downto 1 do q[i]:=min(q[i shl 1],q[i shl 1+1]);
  for i:=n+1 to m do begin
    read(j);
    writeln(q[1]);
    update((i-1) mod n+1,j);
  end;
  writeln(q[1]);
  close(input);
  close(output);
end.