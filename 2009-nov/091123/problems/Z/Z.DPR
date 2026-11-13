{$APPTYPE CONSOLE}
var A,B : integer;
begin
   assign(input,'z.in'); reset(input);
   assign(output,'z.out'); rewrite(output);
   {}
   read(A,B);
   write(A+B);
end.