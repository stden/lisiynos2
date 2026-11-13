Uses CRT;


Const OperSet:set of char= ['+','-','*','/','(',')','^'];

Var Stack : array [1..10] of Char;
    InputString : String;
    OutputString : String;
    I,J,K, TopStack : Word;
    Symb : Char;
    Temp : Char;
    Variable, VarStack : array [1..10] Of Real;
    Result, Op : Real;

Function Calc(Op1, Op2 : Real; Op : Char):Real;
Var Result : Real;
Begin
      Case Op Of
           '+':Result := Op1 + Op2;
           '-':Result := Op1 - Op2;
           '*':Result := Op1 * Op2;
           '/':Result := Op1 / Op2;
      End;
      Calc := Result;
End;


Function ChToInt(C:Char):Integer;
Var Result : Integer;
Begin
     Case C Of
          '-': Result := 1;
          '+': Result := 1;
          '*': Result := 2;
          '/': Result := 2;
     End;
     ChToInt := Result;
End;

Function PRCD(Ch1, Ch2 : Char):Boolean;
Var Result : Boolean;
Begin
     If ChToInt(Ch1) >= ChToInt(Ch2) Then Result := True
                                     Else Result := False;

     If Ch2='(' Then Result := False;
     If Ch1='(' Then Result := False;
     If (Ch2=')') And (Ch1<>'(') Then Result := True;
     If (Ch2='(') And (Ch1=')') Then Result := False;

     PRCD := Result;
End;

Procedure Push(Ch : Char);
Begin
     Inc(TopStack);
     Stack[TopStack] := Ch;
End;

Function Pop:Char;
Begin
     Pop := Stack[TopStack];
     Stack[TopStack] := ' ';
     Dec(TopStack);
End;

Begin
     ClrScr;
     TopStack := 0;
     OutputString := '';

     Write('Введите выражение: ');
     ReadLn(InputString);

     For I := 1 To 10 Do Stack[I] := ' ';
     For I := 1 To 10 Do Variable[I] := 0;
     For I := 1 To 10 Do VarStack[I] := 0;

     For I := 1 To Length(InputString) Do Begin
         Symb := InputString[I];
         If Symb IN OperSet Then Begin
            While (TopStack <> 0) And PRCD(Stack[TopStack],Symb) Do Begin
                  Temp := Pop;
                  OutputString := OutputString + Temp;
            End; { while }
            If (TopStack = 0) Or (Symb<>')') Then Push(Symb)
                                             Else Temp := Pop;

         End Else OutputString := OutputString + Symb;
     End; { for }

     While TopStack <> 0 Do Begin
           Temp := Pop;
           OutputString := OutputString + Temp;
     End;

     WriteLn(InputString);
     WriteLn(OutputString);

     K := 0;
     For I := 1 To Length(OutputString) Do Begin
         If Not(OutputString[I] IN OperSet) Then Begin
            Inc(K);
            Write('Input value of ',OutputString[I],' = ');
            ReadLn(Variable[K]);
         End; { if }
     End; { for }

     K := 0;
     Result := 0;
     TopStack := 0;

     For I := 1 To Length(OutputString) Do Begin
         If OutputString[I] IN OperSet Then Begin
            If TopStack = 1
               Then Result := Calc(0,VarStack[TopStack],OutputString[I])
               Else Begin
                    VarStack[TopStack-1] := Calc(VarStack[TopStack-1],VarStack[TopStack],OutputString[I]);
                    VarStack[TopStack] := 0;
                    Dec(TopStack);
                    Result := VarStack[TopStack];
               End;
         End Else Begin
             Inc(K);
             Inc(TopStack);
             VarStack[TopStack] := Variable[K];
         End; { if }
     End; { for }

     WriteLn(Result:3:3);
     ReadLn;
End.