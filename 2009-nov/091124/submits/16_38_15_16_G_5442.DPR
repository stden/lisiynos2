Program holiday;

 Var
 st :Array[1..1000] Of Boolean;
 t, i :Integer;
 c :Char;
 r :Boolean;

 Begin

reset(input, 'holiday.in');
rewrite(output, 'holiday.out');

 Read(c);
 If (c = 'T') Then st[1] := True Else st[1] := False;
 t := 1;

 While (Not EOLn) Do Begin
  Read(c);
  If (c = '|') Then Begin
   Read(filFile1, c);
   If (c = 'T') Then st[t + 1] := True Else st[t + 1] := False;
   Inc(t);
   End
  Else
   Read(filFile1, c);
   If (c = 'T') Then st[t + 1] := True Else st[t + 1] := False;
   st[t] := st[t] And st[t + 1];
   End;

 r := False;
 For i := 1 To t Do r := r Or st[i];

 If (r) Then Write('YES') Else Write('NO');
End.

