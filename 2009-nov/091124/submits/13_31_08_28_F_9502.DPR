Program papiros;

 Var
 filFile1 :TextFile;
 filFile2 :TextFile;

 intN :Integer;
 strS :String;

 intK :Integer;

 intI :Integer;

 Begin

 Assign(filFile1, 'papiros.in');
 Assign(filFile2, 'papiros.out');

 Reset(filFile1);
 Rewrite(filFile2);

 ReadLn(filFile1, intN);

 intK := 0;
 For intI := 1 To intN Do Begin
  ReadLn(filFile1, strS);
  If (strS = 'Vasiliy Pupkin') Then Inc(intK);
  End;
 If (intK <> 0) Then Dec(intK);

 Write(filFile2, intK);

 CloseFile(filFile1);
 CloseFile(filFile2);

End.
