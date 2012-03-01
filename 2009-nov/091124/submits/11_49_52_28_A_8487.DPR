Program simple;

 Var
 filFile1 :TextFile;
 filFile2 :TextFile;

 intN :Integer;
 intS :Integer;

 intP :Integer;

 intI :Integer;

 Begin

 Assign(filFile1, 'simple.in');
 Assign(filFile2, 'simple.out');

 Reset(filFile1);
 Rewrite(filFile2);

 Read(filFile1, intN);
 intS := Trunc(Sqrt(intN)) + 1;

 intP := 0;
 For intI := 2 To intS Do
  If (intN Mod intI = 0) Then intP := 1;

 Write(filFile2, intP);

 CloseFile(filFile1);
 CloseFile(filFile2);

End.
