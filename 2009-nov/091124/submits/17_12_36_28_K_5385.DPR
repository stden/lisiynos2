Program code;

 Var
 filFile1 :TextFile;
 filFile2 :TextFile;

 chrZ :Array[0..15] Of Char;

 chrC :Char;
 intN :Array[1..4] Of Integer;
 intS :Integer;

 intI :Integer;

 Begin

 Assign(filFile1, 'code.in');
 Assign(filFile2, 'code.out');

 Reset(filFile1);
 Rewrite(filFile2);

 chrZ[0] := '0';  chrZ[1] := '1';  chrZ[2] := '2';  chrZ[3] := '3';
 chrZ[4] := '4';  chrZ[5] := '5';  chrZ[6] := '6';  chrZ[7] := '7';
 chrZ[8] := '8';  chrZ[9] := '9';  chrZ[10] := 'A'; chrZ[11] := 'B';
 chrZ[12] := 'C'; chrZ[13] := 'D'; chrZ[14] := 'E'; chrZ[15] := 'F';

 intI := 0;
 While (Not EOLn(filFile1)) Do Begin
  Inc(intI);
  Read(filFile1, chrC);
  intN[intI] := (Ord(chrC) And 1) Shl (4 - intI);
  If (intI = 4) Then Begin
   intS := intN[1] + intN[2] + intN[3] + intN[4];
   Write(filFile2, chrZ[intS]);
   intI := 0;
   End;
  End;

 {Case intI Of
  1: intS := intN[1] Shr 3;
  2: intS := intN[1] Shr 3 + intN[2] Shr 2;
  3: intS := intN[1] Shr 3 + intN[2] Shr 2 + intN[1] Shr 1;
 End;
 Write(filFile2, chrZ[intS]);}

 CloseFile(filFile1);
 CloseFile(filFile2);

End.
