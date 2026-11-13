Program sun;

 Var
 filFile1 :TextFile;
 filFile2 :TextFile;

 sngV1, sngV2 :Single;
 sngA1, sngA2 :Single;

 Begin

 Assign(filFile1, 'sun.in');
 Assign(filFile2, 'sun.out');

 Reset(filFile1);
 Rewrite(filFile2);

 Read(filFile1, sngV1, sngV2, sngA1, sngA2);

 sngV1 := sngV1 - sngV2;
 sngA1 := sngA1;
 sngA2 := sngA2;

 Write(filFile2, (sngA2 - sngA1) / sngV1 :0:2);

 CloseFile(filFile1);
 CloseFile(filFile2);

End.
