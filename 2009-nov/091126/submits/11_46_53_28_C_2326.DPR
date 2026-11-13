Program light;

 Var
 filFile1 :TextFile;
 filFile2 :TextFile;

 intN, intM :Integer;
 intK       :Array[1..100] Of Integer;

 intX, intY :Integer;

 intI :Integer;

 Begin

 Assign(filFile1, 'light.in');
 Assign(filFile2, 'light.out');

 Reset(filFile1);
 Rewrite(filFile2);

 For intI := 1 To 100 Do intK[intI] := 0;

 ReadLn(filFile1, intN, intM);
 For intI := 1 To intM Do Begin
  ReadLn(filFile1, intX, intY);
  Inc(intK[intX]);
  Inc(intK[intY]);
  End;

 For intI := 1 To intN Do
  Write(filFile2, intK[intI], ' ');

 CloseFile(filFile1);
 CloseFile(filFile2);

End.
