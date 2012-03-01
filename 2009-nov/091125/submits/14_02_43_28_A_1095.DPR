Program a;

 Var
 filFile1 :TextFile;
 filFile2 :TextFile;

 intN  :Integer;
 intT1 :Integer;
 intT2 :Integer;

 intI :Integer;

 Begin

 Assign(filFile1, 'a.in');
 Assign(filFile2, 'a.out');

 Reset(filFile1);
 Rewrite(filFile2);

 intN := -1;
 While (intN <> 0) Do Begin
  Read(filFile1, intN);
  If (intN = 0) Then Continue;
  intT2 := 0;
  For intI := 1 To intN Do Begin
   Read(filFile1, intT1);
   intT2 := intT2 Xor intT1;
   End;
  WriteLn(filFile2, intT2);
 End;

 CloseFile(filFile1);
 CloseFile(filFile2);

End.
