{$APPTYPE CONSOLE}
Program step;

 Var
 filFile1 :TextFile;
 filFile2 :TextFile;

 intN, intM :Integer;
 blnG :Array[1..100, 1..100] Of Boolean;

 blnV :Array[1..100] Of Boolean;

 intR :Array[1..200] Of Integer;
 intK :Integer;

 intV :Integer;

 intX, intY :Integer;
 intI :Integer;

 Procedure subDfs(intVb :Integer);
  Var
  intI :Integer;
  Begin
  blnV[intVb] := True;
  Inc(intK);
  intR[intK] := intVb;
  For intI := 1 To intN Do
   If (blnG[intVb, intI]) And (Not blnV[intI]) Then
    subDfs(intI);
  End;

 Begin

 AssignFile(filFile1, 'step.in');
 AssignFile(filFile2, 'step.out');

 Reset(filFile1);
 Rewrite(filFile2);

 ReadLn(filFile1, intN, intM, intV);
 For intI := 1 To intM Do
  Begin
  ReadLn(filFile1, intX, intY);
  blnG[intX, intY] := True;
  blnG[intY, intX] := True;
  End;

 intK := 0;
 subDfs(intV);

 For intI := intK - 1 DownTo 1 Do
  intR[intK + intK - intI] := intR[intI];
 intK := intK * 2 - 1;

 WriteLn(filFile2, intK);
 For intI := 1 To intK Do
  Write(filFile2, intR[intI], ' ');

 CloseFile(filFile1);
 CloseFile(filFile2);

End.
