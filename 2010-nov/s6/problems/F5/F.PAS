{ Решение задачи F }
Const Logic : Array [1..6,1..4] of Boolean = (
 { A=F B=F  A=T B=F  A=F B=T  A=T B=T }
 (  False,    True,   False,     True ), {A}
 (  False,   False,    True,     True ), {B}
 (  False,   False,   False,     True ), {And}
 (  False,    True,    True,     True ), {Or}
 (  False,    True,    True,    False ), {Xor}
 (   True,   False,    True,     True )); {Imp}

Var Cur : Array [1..4] of Boolean;
    Disable,MaybeTrue,MaybeFalse : Boolean;
    S : String;
    Test,I,J,N : Word; 
Begin
  Assign(Input,'F.IN'); Reset(Input);
  Assign(Output,'F.OUT'); Rewrite(Output);
  Readln(N);
  For Test:=1 to N do
    Begin
      Readln(S);
      For J:=1 to 4 do Cur[J]:=True; { Все значения доступны }
      For I:=1 to 6 do
        If S[I]<>'?' then
          Begin
            Disable:=(S[I]<>'T'); { Что блокировать? 'T'=>False 'F'=>True }
            For J:=1 to 4 do
              If Logic[I,J]=Disable then Cur[J]:=False; { Заблокировали }
          End;
      For I:=1 to 6 do
        Begin
          MaybeTrue:=False; MaybeFalse:=False;
          For J:=1 to 4 do
            If Cur[J] then
              If Logic[I,J] then MaybeTrue:=True Else MaybeFalse:=True;
          If MaybeTrue And (Not MaybeFalse) then S[I]:='T';
          If (Not MaybeTrue) And MaybeFalse then S[I]:='F';
          If (Not MaybeTrue) And (Not MaybeFalse) then Break;
        End;
      If (Not MaybeTrue) And (Not MaybeFalse) then 
        Writeln('ERROR') Else Writeln(S);
    End;
End.