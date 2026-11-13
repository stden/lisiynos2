program B;


var
    r:integer;

begin
  assign(input,'nim.in');
  assign(output,'nim.out');
  rewrite(output);
  reset(input);
  close(input);
  random(2);
  read(r);
  if r=0 then writeln ('Second') else writeln ('First');

close(input);
close(output);
end.

