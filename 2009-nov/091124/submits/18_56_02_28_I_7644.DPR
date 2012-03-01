Program stuffbag;

 Var
 filFile1 :TextFile;
 filFile2 :TextFile;

 intP :Array[1..7] Of Integer;

 intN :Integer;
 strS :String;

 intI :Integer;

 Begin

 Assign(filFile1, 'stuffbag.in');
 Assign(filFile2, 'stuffbag.out');

 Reset(filFile1);
 Rewrite(filFile2);

 For intI := 1 To 7 Do intP[intI] := 0;

 ReadLn(filFile1, intN);
 For intI := 1 To intN Do Begin
  ReadLn(filFile1, strS);
  If (strS = 'APTECHKA') Then Inc(intP[1]);
  If (strS = 'AVTOMAT') Then Inc(intP[2]);
  If (strS = 'NOGH') Then Inc(intP[3]);
  If (strS = 'NOSKI') Then Inc(intP[4]);
  If (strS = 'PORTIANKI') Then Inc(intP[5]);
  If (strS = 'SCHETKA') Then Inc(intP[6]);
  If (strS = 'SHLEM') Then Inc(intP[7]);
  End;

 For intI := 1 To intP[1] Do WriteLn(filFile2, 'APTECHKA');
 For intI := 1 To intP[2] Do WriteLn(filFile2, 'AVTOMAT');
 For intI := 1 To intP[3] Do WriteLn(filFile2, 'NOGH');
 For intI := 1 To intP[4] Do WriteLn(filFile2, 'NOSKI');
 For intI := 1 To intP[5] Do WriteLn(filFile2, 'PORTIANKI');
 For intI := 1 To intP[6] Do WriteLn(filFile2, 'SCHETKA');
 For intI := 1 To intP[7] Do WriteLn(filFile2, 'SHLEM');

 CloseFile(filFile1);
 CloseFile(filFile2);

End.
