program c4;
var a:array[1..1005]of integer;
    i,f,n,p,fl:integer;
    s,m:char;
procedure put(k:integer);
var j:integer;
begin
  inc(i);
  a[i]:=k;
  if fl > i then writeln('[]')else
  begin
  write('[');
  for j:=i downto (fl+1) do
    write(a[j],', ');
  writeln(a[fl],']');
  end;
end;

procedure get();
var j:integer;
begin
  write(a[fl],' ');
  inc(fl);
  if fl > i then writeln('[]')else begin
  write('[');
  for j:=i downto fl+1 do
    write(a[j],', ');
  writeln(a[fl],']');
  end;
end;
begin
  assign(input,'c4.in');
  assign(output,'c4.out');
  reset(input);
  rewrite(output);
  readln(n);
  fl:=1;
  for p:=1 to n do
  begin
    read(m);
    read(s);
    if s='E' then
    begin
      get();
      readln(m);
    end
    else
    begin
      read(m);
      readln(f);
      put(f)
    end;
  end;
  close(input);
  close(output)
end.

