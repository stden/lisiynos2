program B;


begin
  assign(input,'nim.in');
  assign(output,'nim.out');
  rewrite(output);
  reset(input);
  writeln('Second');
close(input);
close(output);
end.

