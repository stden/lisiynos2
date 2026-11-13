{ Задача J. Большая сортировка
  Нужно отсортировать массив натуральных чисел }
{$APPTYPE CONSOLE}

{ Дано число N (1<=N<=1000000),
  а затем N натуральных чисел из диапазона от 1 до 100000. }

procedure QuickSort(var A: array of Integer; iLo, iHi: Integer) ;
var
  Lo, Hi, Pivot, T: Integer;
begin
  Lo := iLo;
  Hi := iHi;
  Pivot := A[(Lo + Hi) div 2];
  repeat
    while A[Lo] < Pivot do Inc(Lo);
    while A[Hi] > Pivot do Dec(Hi);
    if Lo <= Hi then begin
      T := A[Lo];
      A[Lo] := A[Hi];
      A[Hi] := T;
      Inc(Lo) ;
      Dec(Hi) ;
    end;
  until Lo > Hi;
  if Hi > iLo then QuickSort(A, iLo, Hi);
  if Lo < iHi then QuickSort(A, Lo, iHi);
end;

var
  A : array of integer;
  N,I : integer;
begin
  Reset(Input,'sort.in');
  Rewrite(Output,'sort.out');
  read(N);
  SetLength(A,N) ;
  for I := 0 to N-1 do
    read(A[I]);
  { Сортировка }
  QuickSort(A, Low(A), High(A)) ;
  { Вывод }
  for I := 0 to N-1 do
    write(A[I],' ');
end.



