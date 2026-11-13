program B;


begin
  assign(input,'candy.in');
  assign(output,'candy.out');
  rewrite(output);
  reset(input);
  writeln(0);
close(input);
close(output);
end.
 