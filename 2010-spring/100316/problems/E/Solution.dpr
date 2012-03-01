{--$A+,B-,D+,E+,F-,G-,I+,L+,N-,O-,P-,Q+,R+,S+,T-,V+,X+}
{--$M 16384,0,655360}
{$APPTYPE CONSOLE}
{Pestov Andrey. Solution 5}
Const InputFile='E.In';
      OutputFile='E.Out';
      Osn=10000;
      MaxN=100;
      MaxDg=80;
Type TLong=Array[0..MaxDg] Of Word;
     BMas=Array[0..MaxN] Of TLong;
 Var A: Array[1..MaxN] Of Integer;
     N, len: Integer;
     res: TLong;

 Procedure Init;
  Var i: Integer;
   Begin
    Assign(Input, InputFile);
     Reset(Input);
      { len - длина полоски (1<=len<=200) }
      Read(len, N);
      assert( 1 <= len );
      assert( len <= 200 );
      { K - количество чисел в коде (0 K (N+1)/2).  }
      For i:=1 To N Do Read(A[i]);
     Close(Input);
   End;

Var ls, nw: BMas;

 Procedure Add(Const lf, rg: TLong; Var res: TLong);
  Var i, j: Integer;
      cp: LongInt;
   Begin
     j:=lf[0];
     FillChar(res, SizeOf(res), 0);
     If lf[0]<rg[0] Then j:=rg[0];
     For i:=1 To j Do Begin
       cp:=lf[i];
       cp:=(cp + rg[i]) + res[i];
       res[i+1]:=cp Div Osn;
       res[i]:=cp Mod Osn;
     End;
    res[0]:=j;
    If res[j+1]>0 Then Inc(res[0]);
   End;

 Procedure Calc;
  Var i, j: Integer;
   Begin
    If len<0 Then Exit;
    FillChar(ls, SizeOf(ls), 0);
    For i:=0 To N Do ls[i][0]:=1;
    ls[0, 1]:=1;

    For i:=1 To N+len Do Begin
      nw[0]:=ls[0];
      For j:=1 To N Do Add(ls[j], ls[j-1], nw[j]);
      ls:=nw;
    End;
    res:=nw[N];
   End;

 Procedure Solve;
  Var i: Integer;
   Begin
     len:=len-A[1];
     For i:=2 To N Do len:=len-A[i]-1;
     res[0]:=1;
     res[1]:=0;
     Calc;
   End;

 Procedure SayOut(Const res: TLong);
  Var i: Integer;
      s, lp: String;
   Begin
     Write(res[res[0]]); Str(Osn Div 10, lp);
     For i:=res[0]-1 DoWnto 1 Do Begin
       Str(res[i], s);
       While Length(s)<Length(lp) Do s:='0'+s;
       Write(s);
     End;
     WriteLn;
   End;

 Procedure Done;
  Begin
   Assign(Output, OutputFile);
    Rewrite(Output);
     SayOut(res);
    Close(Output);
  End;

BEGIN
  Init;
  Solve;
  Done;
END.