Program d;

 Uses SysUtils;

 Var
 filFile1 :TextFile;
 filFile2 :TextFile;

 intK :Integer;

 strS :String;

 intI :Integer;
 intJ :Integer;

 Begin

 Assign(filFile1, 'd.in');
 Assign(filFile2, 'd.out');

 Reset(filFile1);
 Rewrite(filFile2);

 Read(filFile1, intK);

 strS := '';
 For intI := 1 To 256 Do
  For intJ := 1 To intI Do
   strS := strS + IntToStr(intJ);

 Write(filFile2, strS[intK]);

 CloseFile(filFile1);
 CloseFile(filFile2);

End.
