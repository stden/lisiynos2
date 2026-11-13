Program e;

 Uses
 SysUtils;

 Var
 filFile1 :TextFile;
 filFile2 :TextFile;

 intK :Int64;

 intP :Array[1..1000000] Of Int64;
 intS :Int64;

 strS :String;

 intI :Int64;
 intJ :Int64;

 Begin

 Assign(filFile1, 'e.in');
 Assign(filFile2, 'e.out');

 Reset(filFile1);
 Rewrite(filFile2);

 Read(filFile1, intK);

 intP[1] := 1;
 intI := 1;
 intS := 1;
 While (intS < intK) Do Begin
  Inc(intI);
  intP[intI] := intP[intI - 1] + Length(IntToStr(intI));
  intS := intS + intP[intI];
  End;

 intK := intK - (intS - intP[intI]);

 strS := '';
 intJ := 1;
 While (intJ < intI) Do Begin
  strS := strS + IntToStr(intJ);
  Inc(intJ);
  End;

 Write(filFile2, strS[intK]);

 CloseFile(filFile1);
 CloseFile(filFile2);

End.
