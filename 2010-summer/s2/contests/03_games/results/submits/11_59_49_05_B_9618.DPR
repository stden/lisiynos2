program B;


var
k:integer;


begin
  assign(input,'candy.in');
  assign(output,'candy.out');
  rewrite(output);
  reset(input);
  random(10);
  read(k);
  writeln(k);
close(input);
close(output);
end.
 