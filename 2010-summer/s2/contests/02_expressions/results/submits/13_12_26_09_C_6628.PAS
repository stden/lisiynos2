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
 if s[1]='(' then
              begin
               writeln(s[1]);
               for i:=2 to N-1 do
                if S[i] in ['+','-',')','(','*'] then begin writeln; writeln(s[i]); end
                                                 else write(s[i]);
              end
             else
              for i:=2 to N-1 do
                if S[i] in ['+','-',')','(','*'] then begin writeln; writeln(s[i]) end
                                                 else write(s[i]);
close(input);
close(output);
end.
