uses
  SysUtils;
var
 n, i, k : longint;
begin
 reset(input,'simple.in');
 rewrite(output,'simple.out');

 readln(n);
 k := 0;

 for i := 2 to n div 2 + 1 do 
  if n div i = n / i then inc(k);

 if k > 0 then writeln(1) else writeln(0);

end.
