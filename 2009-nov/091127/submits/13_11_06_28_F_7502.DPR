Program company;

 Var
 filFile1 :TextFile;
 filFile2 :TextFile;

 intM :Integer;
 intN :Integer;
 intP :Array[1..5, 1..5] Of Integer;

 intI :Integer;
 intJ :Integer;

 Function funMax(intX1, intX2 :Integer; intY1, intY2 :Integer) :Integer;
  Var
  intMax :Integer;

  intT1 :Integer;
  intT2 :Integer;

  intI :Integer;

  Begin

  If (intX1 = intX2) And (intY1 = intY2) Then Begin
   Result := intP[intY1, intX1];
   Exit;
   End;

  intMax := 0;

  For intI := intX1 To intX2 - 1 Do Begin
   intT1 := funMax(intX1, intI, intY1, intY2);
   intT2 := funMax(intI + 1, intX2, intY1, intY2);
   intT1 := intT1 * intT1 + intT2 * intT2;
   If (intT1 > intMax) Then intMax := intT1;
   End;

  For intI := intY1 To intY2 - 1 Do Begin
   intT1 := funMax(intX1, intX2, intY1, intI);
   intT2 := funMax(intX1, intX2, intI + 1, intY2);
   intT1 := intT1 * intT1 + intT2 * intT2;
   If (intT1 > intMax) Then intMax := intT1;
   End;

  Result := intMax;

  End;

 Begin

 Assign(filFile1, 'company.in');
 Assign(filFile2, 'company.out');

 Reset(filFile1);
 Rewrite(filFile2);

 ReadLn(filFile1, intM, intN);
 For intI := 1 To intM Do Begin
  For intJ := 1 To intN Do
   Read(filFile1, intP[intI, intJ]);
  ReadLn(filFile1);
  End;

 Write(filFile2, funMax(1, intN, 1, intM));

 CloseFile(filFile1);
 CloseFile(filFile2);

End.
