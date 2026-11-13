{$A+,B-,D+,E+,F-,G-,I+,L+,N+,O-,P-,Q+,R+,S+,T-,V+,X+,Y+}
{$M 16384,0,655360}
{Prokushkin Ivan. Solution 6}
Program Solution_of_problem_Truetle;

const maxCom = 1000;
      MaxLen = 5000;
      Dx  : array [0..7] of integer=(1,1,0,-1,-1,-1,0,1);
      Dy  : array [0..7] of integer=(0,-1,-1,-1,0,1,1,1);

Type point = Record
       x, y : longint;
     end;
     line  = Record
       A, B, C : extended;
     end;
     otr = Record
       b, e : point;
       d : byte;
     end;
     pic = Record
       N : integer;
       O : array [1..maxCom] of otr;
     end;
    switch = array [0..maxLen] of Integer;
    lines  = array [1..maxCom] of line;

Var A,B : pic;
    lnA, lnB  : ^lines;
    On, Off : switch;
    Res : longint;

Procedure readWord(Var str : string);
var ch:char;
Begin
  str := '';
  read(ch);
  while not (ch in ['A'..'Z']) do read(ch);
  while ch in ['A'..'Z'] do
    Begin
      str := str + ch;
      read(ch);
    End;
End;

Procedure Swap(Var A, B: point);
Var C: point;
Begin
  C := A;
  A := B;
  B := C;
End;

procedure makeOtr(T, N: point; var A : pic);
Begin
  if (T.x>N.x) or
     ((T.x = N.x) and (T.y>N.y)) Then swap(T, N);
  Inc(A.N);
  A.O[A.N].b := T;
  A.O[A.N].e := N;
     if T.x = N.x Then A.O[A.N].d :=1
else if T.y < N.y Then A.O[A.N].d :=2
else if T.y = N.y Then A.O[A.N].d :=3
else if T.y > N.y Then A.O[A.N].d :=4;
End;

Procedure readProgram(Var A: pic);
var S : string;
    T, N: point;
    D : byte;
    L, K : longint;
    P : boolean;
Begin
  T.x := 0;
  T.y := 0;
  D   := 0;
  P   := False;
  readWord(S);
  while S <> 'FINISH' do
    Begin
      if S = 'LEFT'    Then d := (d+7) mod 8
 else if S = 'RIGHT'   Then d := (d+1) mod 8
 else if S = 'PENUP'   Then p := false
 else if S = 'PENDOWN' Then
         Begin
           Inc(A.N);
           A.O[A.N].b := T;
           A.O[A.N].e := T;
           A.O[A.N].d := 1;
           p := true;
         End
 else if (S = 'FORWARD') or (S = 'BACK') Then
         Begin
           read(L);
           if S = 'FORWARD' Then K := 1
           else K := -1;
           N.x := T.x + Dx[D] * L * K;
           N.y := T.y + Dy[D] * L * K;
           if p then makeOtr(T, N, A);
           T := N;
         End;
      readWord(S);
    End;
End;

Procedure init;
Begin
  new(lnA);
  new(lnB);
  Assign(InPut, 'InPut.Txt');
  ReSet(InPut);
  Assign(OutPut, 'OutPut.Txt');
  ReWrite(OutPut);
  ReadProgram(A);
  ReadProgram(B);
End;

Function Max(A, B: longint): longint;
Begin
  if A > B Then Max := A
  else Max := B;
End;

Function  minPoint(A, B : point) : boolean;
Begin
  if A.x = B.x Then minPoint := (A.y <= B.y)
  else MinPoint := (A.x <= B.x)
End;

function length(A, B : point) : longint;
Begin
  length:=Max(B.x - A.x, B.y - A.y);
End;

Procedure sameDirect(S, P : otr; Var is : switch);
var begP, endP : point;
Begin
  if (S.d = 1) and (S.b.x <> P.b.x) then exit;
  if (S.d = 2) and (S.b.x - S.b.y <> P.b.x - P.b.y) then exit;
  if (S.d = 3) and (S.b.y <> P.b.y) then exit;
  if (S.d = 4) and (S.b.x + S.b.y <> P.b.x + P.b.y) then exit;
  if minPoint(S.b, P.b) Then begP := P.b
  else begP := S.b;
  if minPoint(S.e, P.e) Then endP := S.e
  else endP := P.e;
  if length(S.B, begP) > length(S.b, S.e) Then exit;
  if not minPoint(begP, endP) Then exit;
  if length(begP, endP) + 1 > is[length(S.b, begP)] Then
     is[length(S.b, begP)] := length(begP, endP) + 1;
End;

procedure makeLine(S : otr; var R : line);
begin
  R.A := S.b.y - S.e.y;
  R.B := S.e.x - S.b.x;
  R.C := S.b.x * S.e.y - S.e.x * S.b.y;
end;

Procedure lPoint(L1,L2:Line; var T: point;Var Is:Boolean);
var X, Y, R : Real;
Begin
  R:=L1.B*L2.A-L1.A*L2.B;
  X:=(L2.B*L1.C-L2.C*L1.B)/R;
  Y:=(L1.A*L2.C-L1.C*L2.A)/R;
  if Abs(Frac(x)) > 0.1 then Is := False
  else Is:=true;
  T.x := round(X);
  T.y := round(Y);
End;

Function isIn(S : otr; P : point) : boolean;
Begin
  isIn:=false;
  if P.x < S.b.x Then exit;
  if P.x > S.e.x Then exit;
  if (P.x = S.b.x) and
     (P.x = S.e.x) then
     if (P.y < S.b.y) or (P.y > S.e.y) then exit;
  isIn:=true;
End;

Procedure intersect(S, P : otr; Const l1, l2: line; Var is : switch);
var M : point;
    can : boolean;
Begin
  if length(S.b, S.e) = 0 Then S.d := P.d;
  if length(P.b, P.e) = 0 Then P.d := S.d;
  if S.d = P.d then sameDirect(S, P, is)
  else
  Begin
    lPoint(l1, l2, M, can);
    if can and isIn(S, M) and isIn(P, M) then
       if is[length(S.b, M)] = 0 Then is [length(S.b, M)] := 1;
  End;
End;

Procedure find(K : integer);
var i : integer;
    On_Len, Off_Len : integer;
Begin
  FillChar(On, sizeOf(On), 0);
  FillChar(Off, sizeOf(Off), 0);
  For i:=1 to B.N do
      intersect(A.O[K], B.O[i], lnA^[K], lnB^[i], On);
  For i:=1 to K-1 do
      intersect(A.O[K], A.O[i], lnA^[K], lnA^[i], Off);
  On_Len  := 0;
  Off_Len := 0;
  For i:=0 to length(A.O[K].b, A.O[K].e) do
      Begin
        if On[i] > On_Len then On_Len := On[i];
        if Off[i] > Off_Len then Off_Len := Off[i];
        if (On_Len > 0) and (Off_Len = 0) then inc(Res);
        if On_Len > 0 then dec(On_Len);
        if Off_Len > 0 then dec(off_Len);
      End;
End;

Procedure solve;
var i : integer;
Begin
  For i:=1 to A.N do
     makeLine(A.O[i], lnA^[i]);
  For i:=1 to B.N do
     makeLine(B.O[i], lnB^[i]);
  Res := 0;
  For i:=1 to A.N do
    find(i);
  WriteLn(Res);
End;

Begin
  init;
  solve;
End.
