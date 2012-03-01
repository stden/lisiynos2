Program code;

 Var
 z :Array[0..15] Of Char;
 c :Char;
 n :Array[1..4] Of Integer;
 s,i :Integer;
begin
 reset(input, 'code.in');
 rewrite(output, 'code.out');
 z[0] := '0';
 z[1] := '1';
 z[2] := '2';
 z[3] := '3';
 z[4] := '4';
 z[5] := '5';
 z[6] := '6';
 z[7] := '7';
 z[8] := '8';
 z[9] := '9';
 z[10] := 'A';
 z[11] := 'B';
 z[12] := 'C';
 z[13] := 'D';
 z[14] := 'E';
 z[15] := 'F';

 i := 0;
 While (Not EOLn) Do Begin
  Inc(i);
  Read(c);
  n[i] := (Ord(c) And 1) Shl (4 - i);
  If (i = 4) Then Begin
   s := n[1] + n[2] + n[3] + n[4];
  // Write(z[s]);
   i:= 0;
   End;
  End;
End.
