Var pos,N: LONGINT;
Var s: string;
begin
assign(input, 'lexem.in');
assign(output, 'lexem.out');
reset(input);
rewrite(output);
Read (s);
N:=length(s);
Pos:=1;
While s[pos]<>('.') do
Begin
If (ord(s[pos])>=ord('0')) and (ord(s[pos])<=ord('9')) and (ord(s[pos+1])<=ord('9')) and (ord(s[pos+1])>=ord('0')) then Write (s[pos]) else Writeln (s[pos]);
Pos:=pos+1;
End;
End.

