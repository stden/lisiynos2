program Project2;

{$APPTYPE CONSOLE}

uses
  SysUtils;
var
a:array[1..70]of int64;
n,i:integer;
begin
assign(input, 'b.in');
reset(input);
assign(output, 'b.out');
rewrite(output);
a[1]:=1;
a[2]:=1;
readln(n);
for i := 3 to n do begin
a[i]:=a[i-1]+a[i-2];
end;
writeln(a[n]);

close(input);
close(output);

end.
