Program color;

 Var
 filFile1 :TextFile;
 filFile2 :TextFile;

 intN :Integer;
 intM :Array[1..100, 1..100] Of Integer;
 intC :Array[1..100] Of Integer;

 intK :Integer;

 intI :Integer;
 intJ :Integer;

 Begin

 Assign(filFile1, 'color.in');
 Assign(filFile2, 'color.out');

 Reset(filFile1);
 Rewrite(filFile2);

 ReadLn(filFile1, intN);
 For intI := 1 To intN Do Begin
  For intJ := 1 To intN Do
   Read(filFile1, intM[intI, intJ]);
  ReadLn(filFile1);
  End;

 For intI := 1 To intN Do
  Read(filFile1, intC[intI]);

 intK := 0;
 For intI := 2 To intN Do
  For intJ := 1 To intI - 1 Do
   If (intM[intI, intJ] = 1) And (intC[intI] <> intC[intJ]) Then Inc(intK);

 Write(filFile2, intK);

 CloseFile(filFile1);
 CloseFile(filFile2);

End.
