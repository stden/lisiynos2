program Project2;

{$APPTYPE CONSOLE}

uses
  SysUtils;
var
a:array[1..70]of int64;
n,i:integer;
begin
assign(input, 'c.in');
reset(input);
assign(output, 'c.out');
rewrite(output);
a[1]:=1;
a[2]:=2;
a[3]:=4;
readln(n);
for i := 4 to n do begin
a[i]:=a[i-1]+a[i-2]+a[i-3];
end;
writeln(a[n]);

close(input);
close(output);

end.
