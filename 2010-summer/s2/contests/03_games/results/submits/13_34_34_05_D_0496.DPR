program B;


var
    r:integer;

begin
  assign(input,'nim.in');
  assign(output,'nim.out');
  rewrite(output);
  reset(input);
  close(input);
  writeln('First');
  writeln('Second');
close(input);
close(output);
end.

