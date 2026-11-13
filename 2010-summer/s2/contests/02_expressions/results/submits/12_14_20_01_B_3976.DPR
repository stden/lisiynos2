Var pos,k,n,m,l: LONGINT;
Var S: string;
Var T: string;
begin
assign(input, 'regex.in');
assign(output, 'regex.out');
reset(input);
rewrite(output);
Read (n);
Read (m);
Readln;
Readln (S);
Readln (T);
k:=0;
pos:=1;
If n<m then l:=n else l:=m;
While pos<=l do
begin
If not (S[pos]=T[pos]) and not (T[pos]=('*')) then k:=1;
pos:=pos+1;
end;
If k=1 then writeln ('NO') else writeln ('YES');
End.

