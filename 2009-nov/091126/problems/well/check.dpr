Uses Testlib;
Begin
  If Ouf.ReadLongInt<>Ans.ReadLongInt Then
    Quit(_WA,'')
  Else
    Quit(_OK,'');
End.