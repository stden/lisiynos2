Program marsian;

 Type
 tNumber = Record
  intN :Array[1..1000] Of Integer;
  intL :Integer;
 End;

 Var
 filFile1 :TextFile;
 filFile2 :TextFile;

 intN :Integer;
 intK :Integer;

 udtC :Array[1..1000] Of tNumber;
 udt1 :tNumber;

 udtR :tNumber;

 intI :Integer;
 intJ :Integer;

 Procedure proAdd(Var pudtN1, pudtN2 :tNumber);
  Var
  intP :Integer;
  intI :Integer;

  Begin

  intP := 0;

  If (pudtN1.intL > pudtN2.intL) Then Begin

   For intI := 1 To pudtN1.intL Do Begin
    intP := pudtN1.intN[intI] + pudtN2.intN[intI] + intP;
    pudtN1.intN[intI] := intP Mod 10;
    intP := intP Div 10;
    End;

   intI := pudtN1.intL + 1;
   While (intP > 0) Do Begin
    pudtN1.intN[intI] := intP Mod 10;
    intP := intP Div 10;
    Inc(intI);
    End;

   pudtN1.intL := intI - 1;

   End
  Else Begin

   For intI := 1 To pudtN2.intL Do Begin
    intP := pudtN1.intN[intI] + pudtN2.intN[intI] + intP;
    pudtN1.intN[intI] := intP Mod 10;
    intP := intP Div 10;
    End;

   intI := pudtN2.intL + 1;
   While (intP > 0) Do Begin
    pudtN1.intN[intI] := intP Mod 10;
    intP := intP Div 10;
    Inc(intI);
    End;

   pudtN1.intL := intI - 1;

   End;

  End;

 Function funQ(pintN :Integer) :tNumber;
  Var
  blnF :Boolean;
  intI :Integer;

  Begin

  Result.intL := 1;
  For intI := 1 To 1000 Do Result.intN[intI] := 0;

  blnF := False;
  For intI := 1 To intK Do
   If (pintN + intI < intN + 1) Then Begin
    If (udtC[pintN + intI].intL = -1) Then udtC[pintN + intI] := funQ(pintN + intI);
    proAdd(Result, udtC[pintN + intI]);
    End
   Else
    blnF := True;
  If (blnF) Then proAdd(Result, udt1);

  End;

 Begin

 Assign(filFile1, 'marsian.in');
 Assign(filFile2, 'marsian.out');

 Reset(filFile1);
 Rewrite(filFile2);

 For intI := 1 To 1000 Do Begin
  udtC[intI].intL := -1;
  For intJ := 1 To 1000 Do
   udtC[intI].intN[intJ] := 0;
  End;

 udt1.intL := 1;
 udt1.intN[1] := 1;
 For intI := 2 To 1000 Do
  udt1.intN[intI] := 0;

 Read(filFile1, intN, intK);
 udtR := funQ(0);

 For intI := udtR.intL DownTo 1 Do Write(filFile2, udtR.intN[intI]);
 WriteLn(filFile2);

 CloseFile(filFile1);
 CloseFile(filFile2);

End.
