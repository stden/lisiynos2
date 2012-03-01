{$APPTYPE CONSOLE}

Uses Math;

const MaxN = 100;

var
  sum : Extended;
  N : integer; { Размерность пространства }
  X : integer; { Количество векторов }
  A,B : array [1..MaxN] of Extended;
  i : integer;
begin
  assign(input,'scalar.in'); reset(input);
  assign(output,'scalar.out'); rewrite(output);
  {}
  read(N);
  assert( N >= 1 );
  assert( N <= MaxN );
  { Читаем первый вектор }
  for i:=1 to N do 
    read(A[i]);
  { Читаем второй вектор }
  for i:=1 to N do 
    read(B[i]);
  { Считаем скалярное произведение }
  sum := 0;
  for i:=1 to N do 
    sum := sum + A[i]*B[i];
  { Выводим ответ }
  writeln(sum:0:3);
end.
