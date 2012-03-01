Program sun;

 Var
 filFile1 :TextFile;
 filFile2 :TextFile;

 dblV1, dblV2 :Double;
 dblA1, dblA2 :Double;

 Begin

 Assign(filFile1, 'sun.in');
 Assign(filFile2, 'sun.out');

 Reset(filFile1);
 Rewrite(filFile2);

 Read(filFile1, dblV1, dblV2, dblA1, dblA2);

 dblV1 := dblV1 - dblV2;
 dblA1 := dblA1 - Trunc(dblA1 / 360) * 360;
 dblA2 := dblA2 - Trunc(dblA1 / 360) * 360;

 Write(filFile2, (dblA2 - dblA1) / dblV1 :0:2);

 CloseFile(filFile1);
 CloseFile(filFile2);

End.
