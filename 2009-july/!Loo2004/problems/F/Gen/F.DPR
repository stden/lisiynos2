{
Решение к задаче F."Сапёр"
Автор: Зубарев П.С.
}

{$APPTYPE CONSOLE}

Const Max_N = 100;

Var Row, A, R1, R2: Array [1..Max_N] of Longint;
    N, I, J, Ans : Longint;
    Fl1, Fl2 : Boolean;

Function Exist(X:Longint):Boolean;
Begin
  Exist:= (X>=1) And (X<=N);
End;

Function Can(X : Longint):Boolean;
Var I, Mines : Longint;
Begin
  Mines:=0;
  For i:=X-1 to X+1 do
    Inc(Mines,Row[i]);
  Can := Mines<=(A[X]-1);
End;

Function Good(X:Longint):Boolean;
Var I, Mines : Longint;
Begin
  If Not Exist(X) then Begin
    Good:= True;
    Exit;
  End;
  Mines := Row[X-1]+Row[X]+Row[X+1];
  If Mines = A[X] then Begin
    Good := True;
    Exit;
  End;
  Good := False;
End;

Begin
  Ans:=0;Fl1:=False;Fl2:=False;
  Assign(input,Paramstr(1));Reset(input);
  Assign(output,ParamStr(2));Rewrite(output);
  Read(N);
  For i:=1 to n do Read(A[i]);
  Row[1]:=1;
//-------------------------
  For i:=2 to N do Begin
    If Can(I-1) then Row[i]:=1;
    If Not Good(I-2) then Break;
  End;
  If (i=N+1) And (Good(N-1)) And (Good(N)) then Begin
    Inc(Ans);
    Fl1:=True;
    r1:=Row;
  End;
  For i:=1 to n do Row[i]:=0;
//-------------------------
  For i:=2 to N do Begin
    If Can(I-1) then Row[i]:=1;
    If Not Good(I-2) then Break;
  End;
  If (i=N+1) And (Good(N-1)) And (Good(N)) then Begin
     Inc(Ans);
     Fl2:= True;
     r2:=Row;
  End;
  Writeln(Ans);
  If Fl1 then Begin
    For i:=1 to N do
      If R1[i]=1 then Write('!') else Write('_');
    Writeln;
  End;
  If Fl2 then
    For i:=1 to N do
      If R2[i]=1 then Write('!') else Write('_');
End.