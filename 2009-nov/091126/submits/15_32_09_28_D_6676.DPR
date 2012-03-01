Program numtostr;

 Var
 filFile1 :TextFile;
 filFile2 :TextFile;

 intN :Integer;
 intK :Integer;

 intI :Integer;

 Begin

 Assign(filFile1, 'numtostr.in');
 Assign(filFile2, 'numtostr.out');

 Reset(filFile1);
 Rewrite(filFile2);

 Read(filFile1, intN);
 For intI := 1 To intN Do Begin
  ReadLn(filFile1, intK);

  If (intK Div 1000000000 = 1) Then Write(filFile2, 'один миллиард ');

  Case (intK Mod 1000000000) Div 100000000 Of
   1: Write(filFile2, 'сто ');
   2: Write(filFile2, 'двести ');
   3: Write(filFile2, 'триста ');
   4: Write(filFile2, 'четыреста ');
   5: Write(filFile2, 'п€тьсот ');
   6: Write(filFile2, 'шестьсот ');
   7: Write(filFile2, 'семьсот ');
   8: Write(filFile2, 'восемьсот ');
   9: Write(filFile2, 'дев€тьсот ');
  End;

  Case (intK Mod 100000000) Div 10000000 Of
   1: Case (intK Mod 10000000) Div 1000000 Of
       0: Write(filFile2, 'дес€ть ');
       1: Write(filFile2, 'одиннадцать миллионов ');
       2: Write(filFile2, 'двенадцать миллионов ');
       3: Write(filFile2, 'тринадцать миллионов ');
       4: Write(filFile2, 'четырнадцать миллионов ');
       5: Write(filFile2, 'п€тнадцать миллионов ');
       6: Write(filFile2, 'шестнадцать миллионов ');
       7: Write(filFile2, 'семнадцать миллионов ');
       8: Write(filFile2, 'восемнадцать миллионов ');
       9: Write(filFile2, 'дев€тнадцать миллионов ');
       End;
   2: Write(filFile2, 'двадцать ');
   3: Write(filFile2, 'тридцать ');
   4: Write(filFile2, 'сорок ');
   5: Write(filFile2, 'п€тьдес€т ');
   6: Write(filFile2, 'шестьдес€т ');
   7: Write(filFile2, 'семьдес€т ');
   8: Write(filFile2, 'восемьдес€т ');
   9: Write(filFile2, 'дев€носто ');
  End;

  Case (intK Mod 10000000) Div 1000000 Of
   0: If ((intK Mod 1000000000) Div 100000000 <> 0) Or ((intK Mod 100000000) Div 10000000 <> 0) Then Write(filFile2, 'миллионов ');
   1: If ((intK Mod 100000000) Div 10000000 <> 1) Then Write(filFile2, 'один миллион ');
   2: If ((intK Mod 100000000) Div 10000000 <> 1) Then Write(filFile2, 'два миллиона ');
   3: If ((intK Mod 100000000) Div 10000000 <> 1) Then Write(filFile2, 'три миллиона ');
   4: If ((intK Mod 100000000) Div 10000000 <> 1) Then Write(filFile2, 'четыре миллиона ');
   5: If ((intK Mod 100000000) Div 10000000 <> 1) Then Write(filFile2, 'п€ть миллионов ');
   6: If ((intK Mod 100000000) Div 10000000 <> 1) Then Write(filFile2, 'шесть миллионов ');
   7: If ((intK Mod 100000000) Div 10000000 <> 1) Then Write(filFile2, 'семь миллионов ');
   8: If ((intK Mod 100000000) Div 10000000 <> 1) Then Write(filFile2, 'восемь миллионов ');
   9: If ((intK Mod 100000000) Div 10000000 <> 1) Then Write(filFile2, 'дев€ть миллионов ');
  End;

  Case (intK Mod 1000000) Div 100000 Of
   1: Write(filFile2, 'сто ');
   2: Write(filFile2, 'двести ');
   3: Write(filFile2, 'триста ');
   4: Write(filFile2, 'четыреста ');
   5: Write(filFile2, 'п€тьсот ');
   6: Write(filFile2, 'шестьсот ');
   7: Write(filFile2, 'семьсот ');
   8: Write(filFile2, 'восемьсот ');
   9: Write(filFile2, 'дев€тьсот ');
  End;

  Case (intK Mod 100000) Div 10000 Of
   1: Case (intK Mod 10000) Div 1000 Of
       0: Write(filFile2, 'дес€ть ');
       1: Write(filFile2, 'одиннадцать тыс€ч ');
       2: Write(filFile2, 'двенадцать тыс€ч ');
       3: Write(filFile2, 'тринадцать тыс€ч ');
       4: Write(filFile2, 'четырнадцать тыс€ч ');
       5: Write(filFile2, 'п€тнадцать тыс€ч ');
       6: Write(filFile2, 'шестнадцать тыс€ч ');
       7: Write(filFile2, 'семнадцать тыс€ч ');
       8: Write(filFile2, 'восемнадцать тыс€ч ');
       9: Write(filFile2, 'дев€тнадцать тыс€ч ');
       End;
   2: Write(filFile2, 'двадцать ');
   3: Write(filFile2, 'тридцать ');
   4: Write(filFile2, 'сорок ');
   5: Write(filFile2, 'п€тьдес€т ');
   6: Write(filFile2, 'шестьдес€т ');
   7: Write(filFile2, 'семьдес€т ');
   8: Write(filFile2, 'восемьдес€т ');
   9: Write(filFile2, 'дев€носто ');
  End;

  Case (intK Mod 10000) Div 1000 Of
   0: If ((intK Mod 1000000) Div 100000 <> 0) Or ((intK Mod 100000) Div 10000 <> 0) Then Write(filFile2, 'тыс€ч ');
   1: If ((intK Mod 100000) Div 10000 <> 1) Then Write(filFile2, 'одна тыс€ча ');
   2: If ((intK Mod 100000) Div 10000 <> 1) Then Write(filFile2, 'две тыс€чи ');
   3: If ((intK Mod 100000) Div 10000 <> 1) Then Write(filFile2, 'три тыс€чи ');
   4: If ((intK Mod 100000) Div 10000 <> 1) Then Write(filFile2, 'четыре тыс€чи ');
   5: If ((intK Mod 100000) Div 10000 <> 1) Then Write(filFile2, 'п€ть тыс€ч ');
   6: If ((intK Mod 100000) Div 10000 <> 1) Then Write(filFile2, 'шесть тыс€ч ');
   7: If ((intK Mod 100000) Div 10000 <> 1) Then Write(filFile2, 'семь тыс€ч ');
   8: If ((intK Mod 100000) Div 10000 <> 1) Then Write(filFile2, 'восемь тыс€ч ');
   9: If ((intK Mod 100000) Div 10000 <> 1) Then Write(filFile2, 'дев€ть тыс€ч ');
  End;

  Case (intK Mod 1000) Div 100 Of
   1: Write(filFile2, 'сто ');
   2: Write(filFile2, 'двести ');
   3: Write(filFile2, 'триста ');
   4: Write(filFile2, 'четыреста ');
   5: Write(filFile2, 'п€тьсот ');
   6: Write(filFile2, 'шестьсот ');
   7: Write(filFile2, 'семьсот ');
   8: Write(filFile2, 'восемьсот ');
   9: Write(filFile2, 'дев€тьсот ');
  End;

  Case (intK Mod 100) Div 10 Of
   1: Case intK Mod 10 Of
       0: Write(filFile2, 'дес€ть');
       1: Write(filFile2, 'одиннадцать');
       2: Write(filFile2, 'двенадцать');
       3: Write(filFile2, 'тринадцать');
       4: Write(filFile2, 'четырнадцать');
       5: Write(filFile2, 'п€тнадцать');
       6: Write(filFile2, 'шестнадцать');
       7: Write(filFile2, 'семнадцать');
       8: Write(filFile2, 'восемнадцать');
       9: Write(filFile2, 'дев€тнадцать');
       End;
   2: Write(filFile2, 'двадцать ');
   3: Write(filFile2, 'тридцать ');
   4: Write(filFile2, 'сорок ');
   5: Write(filFile2, 'п€тьдес€т ');
   6: Write(filFile2, 'шестьдес€т ');
   7: Write(filFile2, 'семьдес€т ');
   8: Write(filFile2, 'восемьдес€т ');
   9: Write(filFile2, 'дев€носто ');
  End;

  Case intK Mod 10 Of
   1: If ((intK Mod 100) Div 10 <> 1) Then Write(filFile2, 'один');
   2: If ((intK Mod 100) Div 10 <> 1) Then Write(filFile2, 'два');
   3: If ((intK Mod 100) Div 10 <> 1) Then Write(filFile2, 'три');
   4: If ((intK Mod 100) Div 10 <> 1) Then Write(filFile2, 'четыре');
   5: If ((intK Mod 100) Div 10 <> 1) Then Write(filFile2, 'п€ть');
   6: If ((intK Mod 100) Div 10 <> 1) Then Write(filFile2, 'шесть');
   7: If ((intK Mod 100) Div 10 <> 1) Then Write(filFile2, 'семь');
   8: If ((intK Mod 100) Div 10 <> 1) Then Write(filFile2, 'восемь');
   9: If ((intK Mod 100) Div 10 <> 1) Then Write(filFile2, 'дев€ть');
  End;

  WriteLn(filFile2);
  End;

 CloseFile(filFile1);
 CloseFile(filFile2);

End.
