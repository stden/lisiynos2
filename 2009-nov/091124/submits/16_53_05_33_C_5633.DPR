Program money;

 Var

 n:Array[1..100] Of Integer;
 p:Array[1..3] Of Integer;
 d:Array[0..2] Of Integer;
 nq,r,i,j,k :Integer;
 c:Char;
Begin
 reset(input, 'money.in');
 rewrite(output, 'money.out');
 d[0] := 1;
 d[1] := 10;
 d[2] := 100;
 k := 0;
 Read(c);
 While (c <> '+') And (c <> '*') And (Not EOLn) Do Begin
  Inc(k);
  p[k] := Ord(c) - Ord('0');
  Read(c);
  End;
 If (EOLn) Then Begin Inc(k); p[k] := Ord(c) - Ord('0'); End;

 n[1] := 0;
 For j := 1 To k Do Inc(n[1], p[j] * d[k - j]);
 nq := 1;

 While (Not EOLn) Do
  If (c = '+') Then Begin
   k := 0;
   Read(c);
   While (c <> '+') And (c <> '*')  And (Not EOLn) Do Begin
    Inc(k);
    p[k] := Ord(c) - Ord('0');
    Read(c);
    End;
   If (EOLn) Then Begin Inc(k); p[k] := Ord(c) - Ord('0'); End;

   n[nq + 1] := 0;
   For j := 1 To k Do Inc(n[nq + 1], p[j] * d[k - j]);
   Inc(nq);
   End
  Else Begin
   k := 0;
   Read(c);
   While (c <> '+') And (c <> '*')  And (Not EOLn) Do Begin
    Inc(k);
    p[k] := Ord(c) - Ord('0');
    Read(c);
    End;
   If (EOLn) Then Begin Inc(k); p[k] := Ord(c) - Ord('0'); End;

   n[nq + 1] := 0;
   For j := 1 To k Do Inc(n[nq + 1], p[j] * d[k - j]);
   n[nq] := n[nq] * n[nq + 1];
   End;

 r := 0;
 For i := 1 To nq Do Inc(r, n[i]);

 Write(r);

End.
