Program hb;

 Uses
 SysUtils, DateUtils;

 Var
 filFile1 :TextFile;
 filFile2 :TextFile;

 datD1 :TDateTime;
 datD2 :TDateTime;

 intN :Integer;

 intD1, intM1, intY1 :Integer;
 intD2, intM2        :Integer;

 intDays  :Array[1..1000000] Of Integer;
 intWDays :Array[1..1000000] Of Integer;
 strNames :Array[1..1000000] Of String;

 intM :Integer;

 intD  :Integer;
 intWD :Integer;
 strN  :String;

 intI :Integer;
 intJ :Integer;

 Begin

 Assign(filFile1, 'hb.in');
 Assign(filFile2, 'hb.out');

 Reset(filFile1);
 Rewrite(filFile2);

 ReadLn(filFile1, intD1, intM1, intY1);
 datD1 := StrToDate(IntToStr(intD1) + '.' + IntToStr(intM1) + '.' + IntToStr(intY1));

 ReadLn(filFile1, intN);
 intJ := 0;
 For intI := 1 To intN Do Begin
  Inc(intJ);

  ReadLn(filFile1, intD2, intM2, strNames[intJ]);

  datD2 := StrToDate(IntToStr(intD2) + '.' + IntToStr(intM2) + '.' + IntToStr(intY1));
  If (datD2 - datD1 < 0) Then datD2 := StrToDate(IntToStr(intD2) + '.' + IntToStr(intM2) + '.' + IntToStr(intY1 + 1));
  intDays[intJ] := Trunc(datD2 - datD1);

  intWDays[intJ] := DayOfTheWeek(datD2);
  End;

 For intI := 1 To intN - 1 Do Begin
  intM := intI;
  For intJ := intI + 1 To intN Do
   If (intDays[intJ] < intDays[intM]) Then intM := intJ;
  intD := intDays[intI];
  intWD := intWDays[intI];
  strN := strNames[intI];
  intDays[intI] := intDays[intM];
  intWDays[intI] := intWDays[intM];
  strNames[intI] := strNames[intM];
  intDays[intM] := intD;
  intWDays[intM] := intWD;
  strNames[intM] := strN;
  End;

 For intI := 1 To intN Do Begin
  Write(filFile2, intDays[intI], ' ');
  Case intWDays[intI] Of
   1: Write(filFile2, 'пн');
   2: Write(filFile2, 'вт');
   3: Write(filFile2, 'ср');
   4: Write(filFile2, 'чт');
   5: Write(filFile2, 'пт');
   6: Write(filFile2, 'сб');
   7: Write(filFile2, 'вс');
  End;
  WriteLn(filFile2, strNames[intI]);
  End;

 CloseFile(filFile1);
 CloseFile(filFile2);

End.
