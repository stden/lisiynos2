Program sort;

 Var
 filFile1 :TextFile;
 filFile2 :TextFile;

 intN :Integer;
 intX :Array[1..1000000] Of Integer;

 intT1 :Integer;
 intT2 :Integer;

 intI :Integer;
 intJ :Integer;

 Begin

 Assign(filFile1, 'sort.in');
 Assign(filFile2, 'sort.out');

 Reset(filFile1);
 Rewrite(filFile2);

 ReadLn(filFile1, intN);
 For intI := 1 To intN Do Read(filFile1, intX[intI]);

 For intI := 1 To intN - 1 Do Begin
  intT1 := intI;
  For intJ := intI + 1 To intN Do
   If (intX[intJ] < intX[intT1]) Then intT1 := intJ;
  intT2 := intX[intI];
  intX[intI] := intX[intT1];
  intX[intT1] := intT2;
  End;

 For intI := 1 To intN Do Write(filFile2, intX[intI], ' ');

 CloseFile(filFile1);
 CloseFile(filFile2);

End.
