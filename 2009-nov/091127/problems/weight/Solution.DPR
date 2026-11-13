Program weight;

 Var
 filFile1 :TextFile;
 filFile2 :TextFile;

 intN :Integer;
 intW :Array[1..100000] Of Integer;
 intC :Array[1..100000] Of Integer;

 intL :Array[1..100000] Of Integer;
 intM :Integer;

 intI :Integer;
 intJ :Integer;

 Begin

 Assign(filFile1, 'weight.in');
 Assign(filFile2, 'weight.out');

 Reset(filFile1);
 Rewrite(filFile2);

 ReadLn(filFile1, intN);
 ReadLn(filFile1, intW[1], intC[1]);

 intL[1] := 1;
 intM := intW[1];

 For intI := 2 To intN Do Begin
  ReadLn(filFile1, intW[intI], intC[intI]);
  intL[intI] := intL[intI - 1] + 1;
  If (intM > intC[intI]) Then Begin
   intJ := 1;
   While (intJ < intI) And (intM > intC[intI]) Do Begin
    Dec(intL[intI]);
    intM := intM - intW[intJ];
    End;
   End;
  intM := intM + intW[intI];
  End;

 intM := 1;
 For intI := 1 To intN Do
  If (intL[intI] > intL[intM]) Then intM := intI;

 Write(filFile2, intL[intM]);

 CloseFile(filFile1);
 CloseFile(filFile2);

End.
