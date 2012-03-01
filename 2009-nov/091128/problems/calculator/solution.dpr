Program myproblem;

 Uses
 SysUtils;

 Var
 filFile1 :TextFile;
 filFile2 :TextFile;

 strExpr :String;
 strTemp :String;
 intC    :Integer;

 intStack :Array[1..1000] Of Integer;

 Procedure funReadSeparators(); Forward;
 Function funReadNumber(pintB :Integer) :Integer; Forward;
 Function funCalcExpr(pintE :Integer; pintB :Integer) :Integer; Forward;

 Procedure funReadSeparators();
  Begin

  While (strExpr[intC] = Chr(10)) Or (strExpr[intC] = Chr(13)) Or
        (strExpr[intC] = Chr(7)) Or (strExpr[intC] = ' ') Do Inc(intC);

  End;

 Function funReadNumber(pintB :Integer) :Integer;
  Var
  strN :String;

  intI :Integer;
  intJ :Integer;

  Begin

  If (strExpr[intC] = '(') Then Begin
   Inc(intC);
   intI := intC;
   intJ := 1;
   While (strExpr[intI] <> ')') Or (intJ > 1) Do Begin
    If (strExpr[intI] = '(') Then Inc(intJ);
    If (strExpr[intI] = ')') Then Dec(intJ);
    Inc(intI);
    End;
   Result := funCalcExpr(intI - 1, pintB);
   End
  Else Begin
   strN := '';
   While (strExpr[intC] >= '0') And (strExpr[intC] <= '9') Do Begin
    strN := strN + strExpr[intC];
    Inc(intC);
    End;

   Result := StrToInt(strN);
   End;

  End;

 Function funCalcExpr(pintE :Integer; pintB :Integer) :Integer;
  Var
  intB :Integer;
  intP :Integer;
  chrD :Char;

  intI :Integer;

  Begin

  intB := pintB;
  intP := pintB;

  funReadSeparators();
  If (strExpr[intC] = '+') Then Begin intStack[intB] := 1; Inc(intC) End Else
  If (strExpr[intC] = '-') Then Begin intStack[intB] := -1; Inc(intC) End Else
   intStack[intB] := 1;

  intStack[intB] := intStack[intB] * funReadNumber(intB + 1);

  While (intC <= pintE) Do Begin
   funReadSeparators();
   chrD := strExpr[intC]; Inc(intC);

   funReadSeparators();
   Case chrD Of
    '+': Begin intStack[intP + 1] := funReadNumber(intP + 1); Inc(intP); End;
    '-': Begin intStack[intP + 1] := -funReadNumber(intP + 1); Inc(intP); End;
    '*': intStack[intP] := intStack[intP] * funReadNumber(intP + 1);
    '/': intStack[intP] := intStack[intP] Div funReadNumber(intP + 1);
   End;

   funReadSeparators();
   End;
  Inc(intC);

  Result := 0;
  For intI := intB To intP Do Result := Result + intStack[intI];
  End;

 Begin

 AssignFile(filFile1, 'calculator.in');
 AssignFile(filFile2, 'calculator.out');

 Reset(filFile1);
 Rewrite(filFile2);

 ReadLn(filFile1, strExpr);
 While (Not EOF(filFile1)) Do Begin
  ReadLn(filFile1, strTemp);
  strExpr := strExpr + Chr(10) + Chr(13) + strTemp;
  End;

 intC := 1;
 Write(filFile2, funCalcExpr(Length(strExpr), 1));

 CloseFile(filFile1);
 CloseFile(filFile2);

End.
