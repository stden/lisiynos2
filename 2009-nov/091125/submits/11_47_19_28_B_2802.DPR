Program b;

 Var
 filFile1 :TextFile;
 filFile2 :TextFile;

 intN, intM :Integer;

 intI, intJ :Integer;
 intK       :Integer;

 Begin

 Assign(filFile1, 'b.in');
 Assign(filFile2, 'b.out');

 Reset(filFile1);
 Rewrite(filFile2);

 Read(filFile1, intN, intM);

 intK := 0;
 For intI := 1 To intN Do
  For intJ := 1 To intI Do Begin
   Write(filFile2, Chr(Ord('0') + intI)); Inc(intK);
   If (intK = intM) Then Begin
    WriteLn(filFile2);
    intK := 0;
    End;
   End;

 CloseFile(filFile1);
 CloseFile(filFile2);

End.
