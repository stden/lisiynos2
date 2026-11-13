{$APPTYPE CONSOLE}

Uses SysUtils;

{ Вычисление ответа }
Function Solve(R: LongInt): LongInt;
Var
  X, Y, K: LongInt;
Begin
  K := 0;
  { Подсчитаем количество клеток внутри одной четвертинки }
  X := 1; { Изначально предполагаем что координата X = 1 }
  Y := R; { А Y - равна R (конечно же, она будет реально меньше) }
  for X := 1 to R do { Цикл по столбцам }
  Begin
    { Пока вылезает за пределы окружности, уменьшаем Y }
    While Y*Y + X*X > R*R do  { R*R - квадрат радиуса окружности }
      Dec(Y);
    K := K + Y; { Добавляем полученное количество клеточек }
  End;
  Solve := K * 4; { Поскольку мы посчитали для 1/4 окружности, то умножаем на 4 }
End;

Const
  FileName = 'sqr';

var
  R: LongInt;
begin
  Reset(input, FileName + '.in');
  Rewrite(output, FileName + '.out');
  Read(R);
  Writeln(Solve(R));
end.
