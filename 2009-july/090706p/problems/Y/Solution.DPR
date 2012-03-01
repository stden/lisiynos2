{$APPTYPE CONSOLE}
var S : String; i : longint;
begin
   assign(input,'y.in'); reset(input);
   assign(output,'y.out'); rewrite(output);
   {}
   readln(S);
   for i:=length(S) downto 1 do 
      write(S[i]);
end.