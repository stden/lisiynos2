{$APPTYPE CONSOLE}
{$N+,E-}
Const
  MaxN=1000;
Var
  Fi,Fo:Text;
  Mn:Array[1..MaxN]Of Record X,Y:LongInt End;
  N:Word;
  S,M,K:Comp;

Procedure LoadFile;
Var
  I:Word;
Begin
  Assign(Fi,'e.in');
  ReSet(Fi);
  Read(Fi,N);
  For I:=1 To N Do Begin
    Read(Fi,Mn[I].X);
    Read(Fi,Mn[I].Y);
  End;
  Close(Fi);
End;


Procedure CountS;
Var
  I:Word;
Begin
  S:=0;
  For I:=1 To N-1 Do
    S:=S+(Mn[I].Y+Mn[I+1].Y+0.0)*(Mn[I].X-Mn[I+1].X);
  S:=Abs(S+(Mn[N].Y+Mn[1].Y+0.0)*(Mn[N].X-Mn[1].X));
End;

Procedure CountM;
Var
  I:Word;
Function NOD(a,b:LongInt):LongInt;
Var
  T:LongInt;
Begin
  If a<b Then Begin t:=a;a:=b;b:=t; End;
  While B<>0 Do Begin
    T:=b;
    b:=A Mod B;
    A:=T;
  End;
  NOD:=A;
End;
Begin
  M:=0;
  For I:=1 To N-1 Do 
    M:=M+NOD(Abs(Mn[I].Y-Mn[I+1].Y),Abs(Mn[I].X-Mn[I+1].X));
  M:=M+NOD(Abs(Mn[N].Y-Mn[1].Y),Abs(Mn[N].X-Mn[1].X));
End;

Procedure CountK;
Begin
  writeln('S = ',S);
  writeln('M = ',M);
  K:=(S+2-M)/2;
  writeln('K = ',K);
End;

Procedure SaveResult;
Begin
  Assign(Fo,'e.out');
  ReWrite(Fo);
  WriteLn(Fo,K:0:0);
  Close(Fo);
End;

Begin
  LoadFile;
  CountS;
  CountM;
  CountK;
  SaveResult;
End.