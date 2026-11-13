Program ferrari;

 Const
 cintInf :Integer = 1000000;

 Var
 filFile1 :TextFile;
 filFile2 :TextFile;

 intK :Integer;

 intN :Integer;
 intM :Integer;
 intD :Array[1..5, 1..5] Of Integer;

 blnP :Array[1..5] Of Boolean;

 intS  :Array[1..10] Of Integer;
 intSq :Integer;

 intX, intY :Integer;
 intW       :Integer;

 intT1 :Integer;
 intT2 :Integer;

 intI :Integer;
 intJ :Integer;

 Procedure proDfs(pintN :Integer; pintV :Integer);
  Var
  intI :Integer;

  Begin

  If (pintN = intN) Then Begin
   Inc(intSq);
   intS[intSq] := pintV;
   Exit;
   End;

  blnP[pintN] := True;

  For intI := 1 To intN Do
   If (Not blnP[intI]) And (intD[pintN, intI] <> cintInf) Then
    proDfs(intI, pintV + intD[pintN, intI]);

  blnP[pintN] := False;

  End;

 Begin

 Assign(filFile1, 'ferrari.in');
 Assign(filFile2, 'ferrari.out');

 Reset(filFile1);
 Rewrite(filFile2);

 ReadLn(filFile1, intK, intN, intM);

 For intI := 1 To intN Do Begin
  blnP[intI] := False;
  For intJ := 1 To intN Do
   intD[intI, intJ] := cintInf;
  End;

 For intI := 1 To intM Do Begin
  ReadLn(filFile1, intX, intY, intW);
  intD[intX, intY] := intW;
  intD[intY, intX] := intW;
  End;

 intSq := 0;
 proDfs(1, 0);

 For intI := 1 To intSq - 1 Do Begin
  intT1 := intI;
  For intJ := intI To intSq Do
   If (intS[intJ] < intS[intT1]) Then intT1 := intJ;
  intT2 := intS[intI];
  intS[intI] := intS[intT1];
  intS[intT1] := intT2;
  End;

 intT1 := 0;
 For intI := 1 To intK Do intT1 := intT1 + intS[intI];

 Write(filFile2, intT1);

 CloseFile(filFile1);
 CloseFile(filFile2);

End.
