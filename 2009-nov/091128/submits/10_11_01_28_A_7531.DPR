Program left;

 Const
 csngK :Single = 3.1415926 / 180;

 Var
 filFile1 :TextFile;
 filFile2 :TextFile;

 intN :Integer;

 intX1, intY1 :Integer;
 intX2, intY2 :Integer;
 intX, intY   :Integer;

 sngA1, sngA2 :Single;

 intS :Integer;

 intI :Integer;

 Begin

 Assign(filFile1, 'left.in');
 Assign(filFile2, 'left.out');

 Reset(filFile1);
 Rewrite(filFile2);

 ReadLn(filFile1, intN);
 ReadLn(filFile1, intX1, intY1);
 ReadLn(filFile1, intX2, intY2);

 intX := intX2 - intX1;
 intY := intY2 - intY1;

 If (intX = 0) Then If (intY > 0) Then sngA1 := 90 Else sngA1 := 270 Else
  If (intY = 0) Then If (intX > 0) Then sngA1 := 0 Else sngA1 := 180 Else Begin
   sngA1 := Arctan(Abs(intY) / Abs(intX)) * csngK;
   If (intX < 0) And (intY > 0) Then sngA1 := 180 - sngA1;
   If (intX < 0) And (intY < 0) Then sngA1 := 180 + sngA1;
   If (intX > 0) And (intY < 0) Then sngA1 := 360 - sngA1;
  End;

 intX1 := intX2;
 intY1 := intY2;

 intS := 0;

 For intI := 1 To intN - 2 Do Begin
  ReadLn(filFile1, intX2, intY2);
  intX := intX2 - intX1;
  intY := intY2 - intY1;

  If (intX = 0) Then If (intY > 0) Then sngA2 := 90 Else sngA2 := 270 Else
  If (intY = 0) Then If (intX > 0) Then sngA2 := 0 Else sngA2 := 180 Else Begin
   sngA2 := Arctan(Abs(intY) / Abs(intX)) * csngK;
   If (intX < 0) And (intY > 0) Then sngA2 := 180 - sngA2;
   If (intX < 0) And (intY < 0) Then sngA2 := 180 + sngA2;
   If (intX > 0) And (intY < 0) Then sngA2 := 360 - sngA2;
  End;

  If (sngA2 < sngA1) Then sngA2 := sngA2 + 360;

  If (sngA2 - sngA1 < 180) Then intS := intS + 666;

  intX1 := intX2;
  intY1 := intY2;

  sngA1 := sngA2;
  End;

 Write(filFile2, intS, '$');

 CloseFile(filFile1);
 CloseFile(filFile2);

End.
