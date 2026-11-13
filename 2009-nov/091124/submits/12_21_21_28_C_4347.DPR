Program money;

 Var
 filFile1 :TextFile;
 filFile2 :TextFile;

 intN  :Array[1..100] Of Byte;
 intP  :Array[1..3] Of Byte;
 intNq :Byte;

 chrC :Char;

 intR :Integer;

 intI :Integer;
 intJ :Integer;
 intK :Integer;

 Begin

 Assign(filFile1, 'money.in');
 Assign(filFile2, 'money.out');

 Reset(filFile1);
 Rewrite(filFile2);

 intK := 0;
 Read(filFile1, chrC);
 While (chrC <> '+') And (chrC <> '*') And (Not EOLn(filFile1)) Do Begin
  Inc(intK);
  intP[intK] := Ord(chrC) - Ord('0');
  Read(filFile1, chrC);
  End;
 If (EOLn(filFile1)) Then Begin Inc(intK); intP[intK] := Ord(chrC) - Ord('0'); End;

 intN[1] := 0;
 For intJ := 1 To intK Do Inc(intN[1], intP[intJ]);
 intNq := 1;

 While (Not EOLn(filFile1)) Do
  If (chrC = '+') Then Begin
   intK := 0;
   Read(filFile1, chrC);
   While (chrC <> '+') And (chrC <> '*')  And (Not EOLn(filFile1)) Do Begin
    Inc(intK);
    intP[intK] := Ord(chrC) - Ord('0');
    Read(filFile1, chrC);
    End;
   If (EOLn(filFile1)) Then Begin Inc(intK); intP[intK] := Ord(chrC) - Ord('0'); End;

   intN[intNq + 1] := 0;
   For intJ := 1 To intK Do Inc(intN[intNq + 1], intP[intJ]);
   Inc(intNq);
   End
  Else Begin
   intK := 0;
   Read(filFile1, chrC);
   While (chrC <> '+') And (chrC <> '*')  And (Not EOLn(filFile1)) Do Begin
    Inc(intK);
    intP[intK] := Ord(chrC) - Ord('0');
    Read(filFile1, chrC);
    End;
   If (EOLn(filFile1)) Then Begin Inc(intK); intP[intK] := Ord(chrC) - Ord('0'); End;

   intN[intNq + 1] := 0;
   For intJ := 1 To intK Do Inc(intN[intNq + 1], intP[intJ]);
   intN[intNq] := intN[intNq] * intN[intNq + 1];
   End;

 intR := 0;
 For intI := 1 To intNq Do Inc(intR, intN[intI]);

 Write(filFile2, intR);

 CloseFile(filFile1);
 CloseFile(filFile2);

End.
