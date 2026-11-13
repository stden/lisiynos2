Program teeth;

 Var
 filFile1 :TextFile;
 filFile2 :TextFile;

 intZ :Array[0..31] Of Int64;

 intN :Integer;
 intT :int64;

 intS :Int64;

 intI :integer;
 intJ :longint;

 Begin

 Assign(filFile1, 'teeth.in');
 Assign(filFile2, 'teeth.out');

 Reset(filFile1);
 Rewrite(filFile2);

 For intI := 0 To 31 Do Read(filFile1, intZ[intI]); ReadLn(filFile1);
 ReadLn(filFile1, intN);

 intS := 0;
 For intI := 1 To intN Do Begin
  ReadLn(filFile1, intT);
  For intJ := 0 To 31 Do
   If (((int64(intT) Shr int64(intJ))) And int64(1)) = int64(1) Then 
     intS := intS + intZ[intJ];
   //writeln(filFile2,intS);
  End;

 WriteLn(filFile2, intS);

 CloseFile(filFile1);
 CloseFile(filFile2);

End.
