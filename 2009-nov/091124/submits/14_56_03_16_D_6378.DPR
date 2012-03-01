Program teeth;

 Var
 z:array[0..31] Of Integer;
 n,s,i,j:Integer;
 t:LongWord;

 Begin

 reset(input, 'teeth.in');
 rewrite(output, 'teeth.out');

 For i := 0 To 31 Do Read(z[i]); //ReadLn();
 ReadLn(n);

 s:= 0;
 For i := 1 To n Do Begin
  Read(t);
  For j := 0 To 31 Do
   If (((t Shr j) And 1) = 1) Then Inc(s, z[j]);
  End;
 Writeln(s);
End.
