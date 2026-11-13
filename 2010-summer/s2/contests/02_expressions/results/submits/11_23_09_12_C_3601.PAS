program lexem;
var s:string;
    a:array[1..100] of char;
    i,j,n:integer;
begin
assign(input,'lexem.in');
assign(output,'lexem.out');
reset(input);
rewrite(output);
read(s);
n:=length(s);
for i:=1 to n do
   begin
   a[i]:=s[i];
   for i:=1 to n do
   while not (a[i]='.') do
   writeln(a[i]);

   end;







close(input);
close(output);

end.