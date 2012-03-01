program lexem;
var s:string;
    a:array[1..100] of char;
    i,j,n:integer;
begin
assign(input,'regex.in');
assign(output,'regex.out');
reset(input);
rewrite(output);
write('NO');



close(input);
close(output);
end.