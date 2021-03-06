{$APPTYPE CONSOLE}
Uses testlib,sysutils;

Const
  Eps: Extended = 1e-5;

Var
  X,Y,R: Array[1..3] Of Extended;
  TX,TY: Array[1..3] Of Extended;
  I: LongInt;
  JuryAnswer,PlayerAnswer: String;

Function Dist(X1,Y1,X2,Y2: Extended): Extended;
Begin
  Dist:=Sqrt(Sqr(X1-X2)+Sqr(Y1-Y2));
End;

Function Vct(X1,Y1,X2,Y2: Extended): Extended;
Begin
  Vct:=X1*Y2-X2*Y1;
End;

Function DistFromLine(X,Y,X1,Y1,X2,Y2: Extended): Extended;
Var
  Area2,Length: Extended;
Begin
  Area2:=Abs(Vct(X1-X,Y1-Y,X2-X,Y2-Y));
  Length:=Dist(X1,Y1,X2,Y2);
  DistFromLine:=Area2/Length;
End;

Function InsideTriangle(X,Y,R: Extended): Boolean;
Var
  I,Next: LongInt;
  Area1,Area2: Extended;
  Inside: Boolean;
Begin
  Inside:=True;
  Area1:=0;
  Area2:=0;
  For I:=1 To 3 Do Begin
    Next:=I+1;
    If Next=4 Then
        Next:=1;
    Area1:=Area1+Vct(TX[I],TY[I],TX[Next],TY[Next]);
    Area2:=Area2+Abs(Vct(TX[I]-X,TY[i]-Y,TX[Next]-X,TY[Next]-Y));
  End;
  Area1:=Abs(Area1);
  If Abs(Area1-Area2)>Eps Then
    Inside:=False;
  For I:=1 To 3 Do Begin
    Next:=I+1;
    If Next=4 Then
       Next:=1;
    If DistFromLine(X,Y,TX[I],TY[I],TX[Next],TY[Next])<R-Eps Then
      Inside:=False;
  End;
  InsideTriangle:=Inside;
End;

Begin
  For I:=1 To 3 Do Begin
    X[i]:=Inf.ReadReal;
    Y[i]:=Inf.ReadReal;
    R[i]:=Inf.ReadReal;
  End;
  JuryAnswer:=Ans.ReadString;
  PlayerAnswer:=Ouf.ReadString;
  If (PlayerAnswer<>'impossible') And (PlayerAnswer<>'possible') Then
    Quit(_PE,'Strange word at the beginning of the output file');
  If (JuryAnswer='impossible') And (PlayerAnswer='impossible') Then
    Quit(_OK,'It is really impossible');
  If (JuryAnswer='possible') And (PlayerAnswer='impossible') Then
    Quit(_WA,'Jury is more clever');
  For I:=1 To 3 Do Begin
    TX[I]:=Ouf.ReadReal;
    TY[I]:=Ouf.ReadReal;
  End;
  For I:=1 To 3 Do
    If (Abs(TX[I])>1e5) Or (Abs(TY[I])>1e5) Then
      Quit(_WA,'Point number '+IntToStr(I)+' lies outside the inner circle');
  For I:=1 To 3 Do
    If Dist(TX[I],TY[I],X[1],Y[1])>R[1]+Eps Then
      Quit(_WA,'Point number '+IntToStr(I)+' lies outside the inner circle');
  If Abs(Vct(TX[2]-TX[1],TY[2]-TY[1],TX[3]-TX[1],TY[3]-TY[1]))<Eps Then
    Quit(_WA,'It is not a triangle');
  For I:=2 To 3 Do
    If Not InsideTriangle(X[I],Y[I],R[I]) Then
      Quit(_WA,'Circle number '+IntToStr(I)+' is not inside the triangle');
  If (JuryAnswer='possible') Then
    Quit(_OK,'')
  Else
    Quit(_Fail,'Player is more clever');
End.
