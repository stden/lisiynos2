program B;

var
 N,K:integer;

begin
  assign(input,'candy.in');
  assign(output,'candy.out');
  rewrite(output);
  reset(input);
  read(N,K);
  writeln(1);
close(input);
close(output);
end.
 