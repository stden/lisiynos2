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
 N:=pos('.',S);
 for i:=1 to N-1 do
  if (s[i] in ['1','2','3','4','5','6','7','8','9','0']) and (s[i+1] in ['1','2','3','4','5','6','7','8','9','0']) then write(s[i])
                                                                                                                 else writeln(s[i]);



close(input);
close(output);
end.
