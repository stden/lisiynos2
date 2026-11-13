Program unreal;

 Var
 filFile1 :TextFile;
 filFile2 :TextFile;

 intN :Integer;
 intT :Integer;

 intSc :Integer;
 intSm :Integer;
 intM :Integer;

 intI :Integer;
 intJ :Integer;

 Begin

 Assign(filFile1, 'unreal.in');
 Assign(filFile2, 'unreal.out');

 Reset(filFile1);
 Rewrite(filFile2);

 ReadLn(filFile1, intN);
 intSm := 2000000000;
 For intI := 1 To intN Do Begin
  intSc := 0;
  For intJ := 1 To intN - 1 Do Begin
   Read(filFile1, intT);
   Inc(intSc, intT);
   End;
  If (intSc < intSm) Then Begin intSm := intSc; intM := intI; End;
  End;

 Write(filFile2, intM);

 CloseFile(filFile1);
 CloseFile(filFile2);

End.
