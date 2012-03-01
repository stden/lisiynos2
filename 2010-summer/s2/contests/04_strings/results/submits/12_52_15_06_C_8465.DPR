Program ssddf;
Var S: String; i,l,k:Integer;
Begin
assign(input,'palin.in');
    reset(input);
    assign(output,'palin.out');
    rewrite(output);
 Readln(S);
l:= Length(s);
K:=0;
For i:=1 to l Do If s[i]=s[l+1-i] Then k:=1;
If k=1 Then Writeln('YES') Else Writeln('NO');
close(input);
close(output);
Readln;
End.
