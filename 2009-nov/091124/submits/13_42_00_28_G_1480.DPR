Program holiday;

 Var
 filFile1 :TextFile;
 filFile2 :TextFile;

 blnStack :Array[1..100] Of Boolean;
 intTop   :Integer;

 chrC :Char;

 blnR :Boolean;

 intI :Integer;

 Begin

 Assign(filFile1, 'holiday.in');
 Assign(filFile2, 'holiday.out');

 Reset(filFile1);
 Rewrite(filFile2);

 Read(filFile1, chrC);
 If (chrC = 'T') Then blnStack[1] := True Else blnStack[1] := False;
 intTop := 1;

 While (Not EOLn(filFile1)) Do Begin
  Read(filFile1, chrC);
  If (chrC = '|') Then Begin
   Read(filFile1, chrC);
   If (chrC = 'T') Then blnStack[intTop + 1] := True Else blnStack[intTop + 1] := False;
   Inc(intTop);
   End
  Else
   Read(filFile1, chrC);
   If (chrC = 'T') Then blnStack[intTop + 1] := True Else blnStack[intTop + 1] := False;
   blnStack[intTop] := blnStack[intTop] And blnStack[intTop + 1];
   End;

 blnR := False;
 For intI := 1 To intTop Do blnR := blnR Or blnStack[intI];

 If (blnR) Then Write(filFile2, 'YES') Else Write(filFile2, 'NO');

 CloseFile(filFile1);
 CloseFile(filFile2);

End.
