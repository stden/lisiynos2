Program c;

 Var
 filFile1 :TextFile;
 filFile2 :TextFile;

 intK :Integer;
 intS :Integer;

 intM :Integer;

 intI :Integer;

 Begin

 Assign(filFile1, 'c.in');
 Assign(filFile2, 'c.out');

 Reset(filFile1);
 Rewrite(filFile2);

 Read(filFile1, intK);
 intS := Trunc(Sqrt(intK)) + 1;

 intI := 2;
 intM := -1;
 While (intI <= intS) And (intM = -1) Do Begin
  If (intK Mod intI = 0) And (intK <> intI) Then intM := intI;
  Inc(intI);
  End;

 If (intM = -1) Then
  Write(filFile2, 'YES')
 Else
  Write(filFile2, 'NO, ', intM);

 CloseFile(filFile1);
 CloseFile(filFile2);

End.

