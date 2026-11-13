Program road;

 Var
 filFile1 :TextFile;
 filFile2 :TextFile;

 intN :Integer;
 intP :Array[1..100] Of Integer;

 intX :Integer;
 intM :Integer;

 intI :Integer;

 Begin

 Assign(filFile1, 'road.in');
 Assign(filFile2, 'road.out');

 Reset(filFile1);
 Rewrite(filFile2);

 ReadLn(filFile1, intN);
 For intI := 1 To intN Do Read(filFile1, intP[intI]); ReadLn(filFile1);
 Read(filFile1, intX);

 intM := 1;
 For intI := 2 To intN Do
  If (Abs(intP[intI] - intX) < Abs(intP[intM] - intX)) Then intM := intI;

 Write(filFile2, intM);

 CloseFile(filFile1);
 CloseFile(filFile2);

End.
