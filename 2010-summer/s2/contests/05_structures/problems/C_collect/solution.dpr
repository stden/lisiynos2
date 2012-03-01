Const MaxN = 1000000;

Var I, N, K, Left, Right, Middle: Longint;
    A: array[1..MaxN] of Longint;

Procedure Swap(var A, B: Longint);
Var C: Longint;
Begin
  C := A;
  A := B;
  B := C;
End;

Procedure Hoar(Left, Right: Integer);
Var I, J: Integer;
    X: Longint;
Begin
  I := Left;
  J := Right;
  X := A[Random(J - I + 1) + I];
  While I < J do Begin
    While A[I] < X do Inc(I);
    While A[J] > X do Dec(J);
    If I <= J Then Begin
      Swap(A[I], A[J]);
      Inc(I);
      Dec(J);
    End;
  End;
  If Left < J Then Hoar(Left, J);
  If I < Right Then Hoar(I, Right);
End;

Begin
  Assign(Input, 'butterfly.in');
  Assign(Output, 'butterfly.out');
  Reset(Input);
  Rewrite(Output);
  Read(N);
  For I := 1 to N do
    Read(A[I]);
  read(k);
  Hoar(1, N);
  for i:=1 to n-1 do
    if a[i]=a[i+1] then halt(0);
  For I := 1 to K do Begin
    Read(K);
    Left := 1;
    Right := N;
    While Left <= Right do Begin
      Middle := (Left + Right) shr 1;
      If A[Middle] < K Then Left := Middle + 1;
      If A[Middle] > K Then Right := Middle - 1;
      If A[Middle] = K Then Break;
    End;
    If A[Middle] = K Then Writeln(1)
                     Else Writeln(0);
  End;
  Close(Input);
  Close(Output);
End.