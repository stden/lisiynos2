program lexem;
var
 s:string;
 n,i:integer;
begin
 assign(input,'lexem.in');
 assign(output,'lexem.out');
 reset(input);
 rewrite(output);
 readln(S);
 N:=length(S);
 for i:=1 to N-1 do
  writeln(S[i]);
close(input);
close(output);
end.
