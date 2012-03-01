program z;
var n,i,k:longint;
begin
 assign(input,'simple.in');
 reset(input);
 assign(output,'simple.out');
 rewrite(output);
 readln(n);
 k:=0;
  for i:=2 to round(sqrt(n)) do
   if n mod i=0 then inc(k);
  if k>0 then writeln(1)
         else writeln(0);
 readln;
End.
