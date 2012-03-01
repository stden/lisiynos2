Program marsian;

 Var
 filFile1 :TextFile;
 filFile2 :TextFile;

 intN :Integer;
 intK :Integer;

 Function funQ(pintN :Integer) :Integer;
  Var
  blnF :Boolean;
  intI :Integer;

  Begin

  Result := 0;
  blnF := False;
  For intI := 1 To intK Do
   If (pintN + intI < intN + 1) Then Result := Result + funQ(pintN + intI) Else blnF := True;
  If (blnF) Then Inc(Result);

  End;

 Begin

 Assign(filFile1, 'marsian.in');
 Assign(filFile2, 'marsian.out');

 Reset(filFile1);
 Rewrite(filFile2);

 Read(filFile1, intN, intK);
 Write(filFile2, funQ(0));

 CloseFile(filFile1);
 CloseFile(filFile2);

End.
