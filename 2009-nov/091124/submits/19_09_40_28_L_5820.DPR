Program flyfear;

 Var
 filFile1 :TextFile;
 filFile2 :TextFile;

 sngR :Single;
 intN :Integer;
 sngXc, sngYc, sngZc :Single;
 sngXt, sngYt, sngZt :Single;

 intK :Integer;

 intI :Integer;

 Begin

 Assign(filFile1, 'flyfear.in');
 Assign(filFile2, 'flyfear.out');

 Reset(filFile1);
 Rewrite(filFile2);

 ReadLn(filFile1, sngR);
 ReadLn(filFile1, sngXc, sngYc, sngZc);

 intK := 0;

 ReadlN(filFile1, intN);
 For intI := 1 To intN Do Begin
  ReadLn(filFile1, sngXt, sngYt, sngZt);
  If ((sngXc - sngXt) * (sngXc - sngXt) + (sngYc - sngYt) * (sngYc - sngYt) + (sngZc - sngZt) * (sngZc - sngZt) <= sngR * sngR) Then
   Inc(intK);
  End;

 Write(filFile2, intK);

 CloseFile(filFile1);
 CloseFile(filFile2);

End.
