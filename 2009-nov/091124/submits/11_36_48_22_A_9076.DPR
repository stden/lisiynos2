uses
  SysUtils;
var
 i, k, n, m : longint;
begin
 reset(input,'simple.in');
 rewrite(output,'simple.out');

 readln(n);
 k := 0;

 m := round(sqrt(n));
 for i := 2 to m do
  if n div i = n / i then inc(k);

 if k > 0 then writeln(1) else writeln(0);

end.
