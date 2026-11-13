program b4;

var
  a: array [1 .. 1005] of integer;
  i, f, n, p: integer;
  s, m: char;

procedure push(k: int64);
var
  j: integer;
begin
  inc(i);
  a[i] := k;
  if i = 0 then
    writeln('[]')
  else
  begin
    write('[');
    for j := 1 to i - 1 do
      write(a[j], ', ');
    writeln(a[i], ']');
  end;
end;

procedure pop();
var
  j: integer;
begin
  write(a[i], ' ');
  dec(i);
  if i = 0 then
    writeln('[]')
  else
  begin
    write('[');
    for j := 1 to i - 1 do
      write(a[j], ', ');
    writeln(a[i], ']');
  end
end;

begin
  assign(input, 'b4.in');
  assign(output, 'b4.out');
  reset(input);
  rewrite(output);
  readln(n);
  for p := 1 to n do
  begin
    read(m);
    read(s);
    if s = 'O' then
    begin
      pop();
      readln(m);
    end
    else
    begin
      read(m);
      read(m);
      readln(f);
      push(f)
    end;
  end;
  close(input);
  close(output)

end.
