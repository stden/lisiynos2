Program roman;

 Var
 filFile1 :TextFile;
 filFile2 :TextFile;

 intN :Integer;
 intK :Integer;

 intI :Integer;

 Begin

 Assign(filFile1, 'roman.in');
 Assign(filFile2, 'roman.out');

 Reset(filFile1);
 Rewrite(filFile2);

 ReadLn(filFile1, intN);
 For intI := 1 To intN Do Begin
  ReadLn(filFile1, intK);

  Case intK Div 1000 Of
   1: Write(filFile2, 'M');
   2: Write(filFile2, 'MM');
   3: Write(filFile2, 'MMM');
  End;

  Case (intK Mod 1000) Div 100 Of
   1: Write(filFile2, 'C');
   2: Write(filFile2, 'CC');
   3: Write(filFile2, 'CCC');
   4: Write(filFile2, 'CD');
   5: Write(filFile2, 'D');
   6: Write(filFile2, 'DC');
   7: Write(filFile2, 'DCC');
   8: Write(filFile2, 'DCCC');
   9: Write(filFile2, 'CM');
  End;

  Case (intK Mod 100) Div 10 Of
   1: Write(filFile2, 'X');
   2: Write(filFile2, 'XX');
   3: Write(filFile2, 'XXX');
   4: Write(filFile2, 'XL');
   5: Write(filFile2, 'L');
   6: Write(filFile2, 'LX');
   7: Write(filFile2, 'LXX');
   8: Write(filFile2, 'LXXX');
   9: Write(filFile2, 'XC');
  End;

  Case intK Mod 10 Of
   1: Write(filFile2, 'I');
   2: Write(filFile2, 'II');
   3: Write(filFile2, 'III');
   4: Write(filFile2, 'IV');
   5: Write(filFile2, 'V');
   6: Write(filFile2, 'VI');
   7: Write(filFile2, 'VII');
   8: Write(filFile2, 'VIII');
   9: Write(filFile2, 'IX');
  End;

  WriteLn(filFile2);
  End;

 CloseFile(filFile1);
 CloseFile(filFile2);

End.
