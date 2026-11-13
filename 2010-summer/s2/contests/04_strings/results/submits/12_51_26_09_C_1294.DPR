program palin;

{$APPTYPE CONSOLE}
var
 S:string;
 i,n,k:integer;
begin
 assign(input,'palin.in');
 assign(output,'palin.out');
 reset(input);
 rewrite(output);
 readln(S);
 N:=Length(S);
 for I := N downto 1 do
  if S[i]=' ' then Delete(S,i,1);
 N:=length(S);
 for I := 1 to n div 2 do
   if S[i]<>S[N-i+1] then k:=1;
  if k=1 then writeln('NO')
         else writeln('YES');
close(input);
close(output);
readln;
end.
