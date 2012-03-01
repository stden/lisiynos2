program B;


var
    r:integer;

begin
  randomize;
  assign(input,'nim.in');
  assign(output,'nim.out');
  rewrite(output);
  reset(input);
  random(3);
  read(r);
  if r=0 then writeln('First')
  else writeln ('Second');

close(input);
close(output);
end.

