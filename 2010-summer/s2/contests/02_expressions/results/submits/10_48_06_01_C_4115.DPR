Var R,pos,N,l: LONGINT;
Var s: string;
begin
assign(input, 'lexem.in');
assign(output, 'lexem.out');
reset(input);
rewrite(output);
Read (s);
N:=length(s);
l:=0;
Pos:=1;
While pos<N do
Begin
Writeln (s[pos]);
Pos:=pos+1;
End;
End.

