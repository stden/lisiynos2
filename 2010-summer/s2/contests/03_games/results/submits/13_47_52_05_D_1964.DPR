program B;


var
    a:array[1..100] of integer;
    r,n,i:integer;

begin
  assign(input,'nim.in');
  assign(output,'nim.out');
  rewrite(output);
  reset(input);
  read(n);
  for i:=1 to n do
  read(a[i]);
  if n mod 2=0 then writeln ('Second') else writeln ('First');


close(input);
close(output);
end.

