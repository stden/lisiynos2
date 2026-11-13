{--$A+,B-,D+,E+,F-,G-,I+,L+,N-,O-,P-,Q+,R+,S+,T-,V+,X+}
{--$R-,S-,Q-}
{--$N+}
{--$M 65384,0,655360}
{$APPTYPE CONSOLE}
{Op<=1000, Len<=5000}
{Pestov Andrey. Solution 6}
Const MaxN=1000;
      MaxLen=6000;
      Dx: Array[0..7] Of Integer=( 0, 1, 1, 1, 0,-1,-1,-1);
      Dy: Array[0..7] Of Integer=( 1, 1, 0,-1,-1,-1, 0, 1);
Type TPoint=Record
             x, y: LongInt;
            End;
     TOtr=Array[1..2] Of TPoint;
     TLine=Record
             A, B, C: Comp;
           End;
     TMas=Record
            N: Integer;
            P: Array[1..MaxN] Of TOtr;
          End;
     BMas=Array[1..MaxLen] Of Integer;
 Var A, B: TMas;
     ch: Char;
     resA: LongInt;

 Function GetString: String;
  Var s: String;
   Begin
    s:='';
    While (ch In [#0..#25, #27..#32]) Do Read(ch);
    While (ch In ['A'..'Z', 'a'..'z', '0'..'9']) Do Begin
      s:=s+UpCase(ch);
      Read(ch);
    End;
    GetString:=s;
   End;

 Procedure AddOtr(Var A: TMas; Const lf, rg: TPoint);
  Var sp: Integer;
   Begin
     sp:=Byte((lf.x<rg.x) Or ((lf.x=rg.x) And (lf.y<rg.y)));
     With A Do Begin
       Inc(N);
       P[N, 2-sp]:=lf;
       P[N, sp+1]:=rg;
     End;
   End;

 Procedure ReadProg(Var A: TMas);
  Var ls, nw: TPoint;
      pp: Boolean;
      uk, dp: Integer;
      len: LongInt;
      s: String;
   Begin
    FillChar(A, SizeOf(A), 0);
    FillChar(nw, SizeOf(nw), 0);
    uk:=0; pp:=False;

     s:=GetString;
     While s<>'FINISH' Do Begin
       If s='LEFT' Then uk:=(uk+7) Mod 8 Else
        If s='RIGHT' Then uk:=(uk+1) Mod 8 Else
         If (s='FORWARD') Or (s='BACK') Then Begin
            Val(GetString, len, dp);
            dp:=Byte(s='FORWARD')*2-1;
            ls:=nw;
            nw.x:=nw.x + Dx[uk]*len*dp;
            nw.y:=nw.y + Dy[uk]*len*dp;
            If pp Then AddOtr(A, ls, nw);
         End Else
         If s='PENUP' Then Begin
           If pp And (ls.x=nw.x) And (ls.y=nw.y) Then AddOtr(A, ls, nw);
           pp:=False;
         End Else
         If s='PENDOWN' Then Begin
             pp:=True;
             ls:=nw;
           End Else Begin
             Write('UNKNOWN IDENTIFIER> ',s);
             Halt; 
           End; 
       s:=GetString;
     End;
   End;

 Procedure Init;
  Begin
   Assign(Input, 'F.In');
    Reset(Input);
      Read(ch);
      ReadProg(A);
      ReadProg(B);
    Close(Input);
  End;

 Function Max(Const lf, rg: LongInt): LongInt;
  Begin
   If lf>rg Then Max:=lf Else Max:=rg;
  End;

 Function Min(Const lf, rg: LongInt): LongInt;
  Begin
   If lf<rg Then Min:=lf Else Min:=rg;
  End;

 Function EqPoint(Const A, B: TPoint): Boolean;
  Begin
   EqPoint:=(A.x=B.x) And (A.y=B.y);
  End;

 Function GetLen(Const A, B: TPoint): LongInt;
  Begin
   GetLen:=Max(Abs(A.x-B.x), Abs(A.y-B.y)) + 1;
  End;

 Procedure SetUp(Var c: BMas; Const lf, rg: Integer);
  Begin
   c[lf]:=Max(c[lf], rg);
  End;

 Procedure OneLine(Const A, B: TOtr; Var c: BMas; Const fb: Boolean);
  Var cc: TOtr;
      lf, rg: Boolean;
   Begin
     cc[1].x:=Max(A[1].x, B[1].x);
     cc[2].x:=Min(A[2].x, B[2].x);
     lf:=A[1].y>A[2].y;
     rg:=B[1].y>B[2].y;
     If (fb And lf) Or (Not fb And rg) Then Begin
       cc[1].y:=Min(A[1].y, B[1].y);
       cc[2].y:=Max(A[2].y, B[2].y);
     End Else Begin
       cc[1].y:=Max(A[1].y, B[1].y);
       cc[2].y:=Min(A[2].y, B[2].y);
     End;
     If (cc[1].x<cc[2].x) Or ((cc[1].x=cc[2].x) And (cc[1].y<=cc[2].y)) Then Begin
       SetUp(c, GetLen(cc[1], A[1]), GetLen(cc[2], cc[1]));
     End;
   End;

 Procedure PointLine(Const A, B: TPoint; Var L: TLine);
  Begin
   L.A:=B.y-A.y;
   L.B:=A.x-B.x;
   L.C:=-A.x*L.A-A.y*L.B;
  End;

 Function GetSign(Const L: TLine; Const P: TPoint): LongInt;
  Var a: Comp;
   Begin
    a:=L.A*P.x + L.B*P.y + L.C;
    If a>0 Then GetSign:=1 Else
     If a=0 Then GetSign:=0 Else GetSign:=-1;
   End;

 Function LineOn(Const L: TLine; Const P: TPoint): Boolean;
  Begin
   LineOn:=GetSign(L, P)=0;
  End;

 Function LinePoint(Const fL, sL: TLine; Var P: TPoint): Boolean;
  Var st: Comp;
   Begin
    st:=fL.A*sL.B-sL.A*fL.B;
    If st<>0 Then Begin
      P.x:=Round(-(fL.C*sL.B-sL.C*fL.B)/st);
      P.y:=Round((sL.A*fL.C-fL.A*sL.C)/st);
      LinePoint:=LineOn(fL, P) And LineOn(sL, P);
     End Else LinePoint:=False;
   End;

 Procedure FindPeres(Const A, B: TOtr; Var c: BMas);
  Var L, L1: TLine;
      P: TPoint;
   Begin
    PointLine(A[1], A[2], L);
    PointLine(B[1], B[2], L1);
    If (GetSign(L, B[1])*GetSign(L, B[2])=1) Or
       (GetSign(L1, A[1])*GetSign(L1, A[2])=1) Then Exit;
    If LinePoint(L, L1, P) Then SetUp(c, GetLen(A[1], P), 1);
   End;

 Procedure UpDate(Const A, B: TOtr; Var c: BMas);
  Var L: TLine;
   Begin
     Case Byte(GetLen(A[1], A[2])=1)*2+Byte(GetLen(B[1], B[2])=1) Of
       0: Begin
            PointLine(A[1], A[2], L);
            If LineOn(L, B[1]) And LineOn(L, B[2]) Then OneLine(A, B, c, True)
             Else FindPeres(A, B, c);
          End;
       1: Begin
            PointLine(A[1], A[2], L);
            If LineOn(L, B[1]) Then OneLine(A, B, c, True);
          End;
       2: Begin
            PointLine(B[1], B[2], L);
            If LineOn(L, A[1]) Then OneLine(A, B, c, False);
          End;
       3: If EqPoint(A[1], B[1]) Then SetUp(c, 1, 1);
     End;
   End;

 Procedure Calc(Const p: Integer);
  Var i, len: Integer;
      fA, fB: BMas;
      nxA, nxB: Integer;
   Begin
     FillChar(fA, SizeOf(fA), 0);
     FillChar(fB, SizeOf(fB), 0);
     For i:=1 To p-1 Do UpDate(A.P[p], A.P[i], fA);
     For i:=1 To B.N Do UpDate(A.P[p], B.P[i], fB);

     nxA:=0; nxB:=0;
     len:=GetLen(A.P[p, 1], A.P[p, 2]);
     For i:=1 To len Do Begin
       If fA[i]>0 Then nxA:=Max(nxA, fA[i] + i - 1);
       If fB[i]>0 Then nxB:=Max(nxB, fB[i] + i - 1);
       If (i>nxA) And (i<=nxB) Then Inc(resA);
     End;
   End;

 Procedure Solve;
  Var i: Integer;
   Begin
    resA:=0;
    For i:=1 To A.N Do Calc(i);
   End;

 Procedure Done;
  Begin
   Assign(Output, 'F.Out');
    Rewrite(Output);
     WriteLn(resA);
    Close(Output);
  End;

BEGIN
 Init;
  Solve;
 Done;
END.