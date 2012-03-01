Program time;

 Var
 filFile1 :TextFile;
 filFile2 :TextFile;

 intN :Integer;
 intX :Array[1..100, 1..3] Of Integer;

 intT1 :Integer;
 intT2 :Array[1..3] Of Integer;

 intI :Integer;
 intJ :Integer;

 Begin

 Assign(filFile1, 'time.in');
 Assign(filFile2, 'time.out');

 Reset(filFile1);
 Rewrite(filFile2);

 ReadLn(filFile1, intN);
 For intI := 1 To intN Do ReadLn(filFile1, intX[intI, 1], intX[intI, 2], intX[intI, 3]);

 For intI := 1 To intN - 1 Do Begin
  intT1 := intI;
  For intJ := intI + 1 To intN Do
   If (intX[intJ, 1] < intX[intT1, 1]) Or
      ((intX[intJ, 1] = intX[intT1, 1]) And (intX[intJ, 2] < intX[intT1, 2])) Or
      ((intX[intJ, 1] = intX[intT1, 1]) And (intX[intJ, 2] = intX[intT1, 2]) And (intX[intJ, 3] < intX[intT1, 3])) Then
    intT1 := intJ;
  intT2[1] := intX[intI, 1];
  intT2[2] := intX[intI, 2];
  intT2[3] := intX[intI, 3];
  intX[intI, 1] := intX[intT1, 1];
  intX[intI, 2] := intX[intT1, 2];
  intX[intI, 3] := intX[intT1, 3];
  intX[intT1, 1] := intT2[1];
  intX[intT1, 2] := intT2[2];
  intX[intT1, 3] := intT2[3];
  End;

 For intI := 1 To intN Do WriteLn(filFile2, intX[intI, 1], ' ', intX[intI, 2], ' ', intX[intI, 3]);

 CloseFile(filFile1);
 CloseFile(filFile2);

End.
