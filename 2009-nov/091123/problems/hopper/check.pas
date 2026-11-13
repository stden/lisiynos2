Uses Testlib;
Begin
  While Not Ans.SeekEOF Do
    If Ouf.ReadLongInt<>Ans.ReadLongInt Then
      Quit(_WA,'');
  Quit(_OK,'');
End.