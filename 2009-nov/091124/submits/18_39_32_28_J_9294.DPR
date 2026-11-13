Program flame;

uses SysUtils;

 Const
 csngInf :Single = 2e9;

 Var
 filFile1 :TextFile;
 filFile2 :TextFile;

 sngV1, sngV2 :Single;
 intN, intM :Integer;

 sngX, sngY :Array[0..9] Of Single;

 sngP :Array[0..9, 0..9] Of Single;

 intT1, intT2 :Integer;
 strM         :String;

 sngT :Single;

 intI :Integer;
 intJ :Integer;
 intK :Integer;

 Begin

 Assign(filFile1, 'flame.in');
 Assign(filFile2, 'flame.out');

 Reset(filFile1);
 Rewrite(filFile2);

 ReadLn(filFile1, sngV2, sngV1, intN, intM);
 For intI := 0 To intN - 1 Do ReadLn(filFile1, sngX[intI], sngY[intI]);

 For intI := 0 To 9 Do
  For intJ := 0 To 9 Do
   sngP[intI, intJ] := csngInf;

 For intI := 1 To intM Do Begin
  Read(filFile1, intT1, intT2);
  ReadLn(filFile1, strM);
  sngT := Sqrt((sngX[intT1] - sngX[intT2]) * (sngX[intT1] - sngX[intT2]) + (sngY[intT1] - sngY[intT2]) * (sngY[intT1] - sngY[intT2]));
  If (strM = ' FIELD') Then
   sngT := sngT / sngV1
  Else
   sngT := sngT / sngV2;
  sngP[intT1, intT2] := sngT;
  sngP[intT2, intT1] := sngT;
  End;

 For intK := 0 To intN - 1 Do
  For intI := 0 To intN - 1 Do
   For intJ := 0 To intN - 1 Do
    If (sngP[intI, intK] + sngP[intK, intJ] < sngP[intI, intJ]) Then Begin
     sngP[intI, intJ] := sngP[intI, intK] + sngP[intK, intJ];
     sngP[intJ, intI] := sngP[intI, intK] + sngP[intK, intJ];
     End;

 Write(filFile2, sngP[0, 1] :0:2);

 CloseFile(filFile1);
 CloseFile(filFile2);
End.
