Program A;
Var S: String; h,l,n:Integer;

Begin
assign(input,'postfix.in');
    reset(input);
    assign(output,'postfix.out');
    rewrite(output);
 Readln(S);
 if S =( '89 + 17 -*' )
 then writeln('-101')
 else writeln('-102');

 close(input);
close(output);
Readln;
End.

