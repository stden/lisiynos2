Program b;

 Uses
 SysUtils;

 Var
 filFile1 :TextFile;
 filFile2 :TextFile;

 intN, intM :Integer;

 strS :String;

 intI, intJ, intL :Integer;
 intK             :Integer;

 Begin

 Assign(filFile1, 'b.in');
 Assign(filFile2, 'b.out');

 Reset(filFile1);
 Rewrite(filFile2);

 Read(filFile1, intN, intM);

 intK := 0;
 For intI := 1 To intN Do
  For intJ := 1 To intI Do Begin
   strS := IntToStr(intI);
   For intL := 1 To Length(strS) Do Begin
    Write(filFile2, strS[intL]); Inc(intK);
    If (intK = intM) Then Begin
     WriteLn(filFile2);
     intK := 0;
     End;
    End;
   End;

 CloseFile(filFile1);
 CloseFile(filFile2);

End.
