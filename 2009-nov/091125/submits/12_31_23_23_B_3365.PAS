program z;
var n,i,k:longint;
begin
 assign(input,'c.in');
 reset(input);
 assign(output,'c.out');
 rewrite(output);
 readln(n);
 k:=0;
  for i:=2 to round(sqrt(n)) do
   if (n mod i=0) and (k=0) then begin inc(k); writeln('NO,',i); end;
  if k=0 then writeln('YES');
 readln;
End.
