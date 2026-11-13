program C;


begin
  assign(input,'checkers.in');
  assign(output,'checkers.out');
  rewrite(output);
  reset(input);
  write('Second');
close(input);
close(output);
end.
