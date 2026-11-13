{$APPTYPE CONSOLE}

uses
  SysUtils;
var m, i, n, y, u : longint;

begin
 reset(input,'c.in');
 rewrite(output,'c.out');
 readln(n);
 m := round (sqrt (n));
 y := 0;

 for i := 2 to m do
  if n div i = n / i then begin
   inc(y);
   if y = 1 then u := i;
  end;
 
 if n = 1 then begin
  y := 1;
  u := 1;
 end;

  if y = 0 then writeln('YES') else writeln('NO,',u);

end.
