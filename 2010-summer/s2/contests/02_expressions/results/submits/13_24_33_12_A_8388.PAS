program lexem;
var s:string;
    a:array[1..100] of char;
    i,j,n:integer;
begin
assign(input,'expr.in');
assign(output,'expr.out');
reset(input);
rewrite(output);
write('WRONG');



close(input);
close(output);
end.