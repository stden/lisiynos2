program C;
var
    R:char;
    n,i:integer;
    s : string;

begin
      n:=1;
      assign(input, 'lexem.in');
      assign(output, 'lexem.out');
      reset (input);
      rewrite (output);

      read(s);

      i := 1;
      while (s[i] <> '.') do
      inc(i);
      dec(i);
close(input);
reset (input);

for n:=1 to i do
begin
      read(R);
      writeln(R);
end;
close(input);
close(output);
end.
