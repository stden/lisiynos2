Program lego;

 Var
 filFile1 :TextFile;
 filFile2 :TextFile;

 intN :Integer;
 intB :Array[1..1000, 1..3] Of Integer;

 blnF :Boolean;

 intI :Integer;
 intJ :Integer;

 Begin

 Assign(filFile1, 'lego.in');
 Assign(filFile2, 'lego.out');

 Reset(filFile1);
 Rewrite(filFile2);

 ReadLn(filFile1, intN);
 For intI := 1 To intN Do Begin
  ReadLn(filFile1, intB[intI, 2], intB[intI, 1]);
  intB[intI, 2] := intB[intI, 2] + intB[intI, 1];
  intB[intI, 3] := 0;
  For intJ := 1 To intI - 1 Do Begin
   blnF := (intB[intI, 1] > intB[intJ, 1]) And (intB[intI, 1] < intB[intJ, 2]);
   blnF := blnF Or (intB[intI, 2] > intB[intJ, 1]) And (intB[intI, 2] < intB[intJ, 2]);
   blnF := blnF Or (intB[intI, 1] = intB[intJ, 1]) And (intB[intI, 2] = intB[intJ, 2]);
   blnF := blnF Or (intB[intJ, 1] > intB[intI, 1]) And (intB[intJ, 1] < intB[intI, 2]);
   blnF := blnF Or (intB[intJ, 2] > intB[intI, 1]) And (intB[intJ, 2] < intB[intI, 2]);
   blnF := blnF And (intB[intJ, 3] > intB[intI, 3]);
   If (blnF) Then
    intB[intI, 3] := intB[intJ, 3];
   End;
  Inc(intB[intI, 3]);
  End;

 intJ := 1;
 For intI := 2 To intN Do If (intB[intI, 3] > intB[intJ, 3]) Then intJ := intI;

 Write(filFile2, intB[intJ, 3]);

 CloseFile(filFile1);
 CloseFile(filFile2);

End.
