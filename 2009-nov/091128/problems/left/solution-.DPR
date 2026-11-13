{$APPTYPE CONSOLE}

uses
  SysUtils;

const
  debug = false;

var
  A : array [1..100,1..100] of integer;
  Sum : array [1..100,0..100] of integer;
  N,i,j,gmax,B,E,Left,Right,Up,Down,P,
  max,min,max_idx,min_idx,AreaSum  : integer;
  SP : array [1..100] of integer;
begin
  Rewrite(output,'left.out');
  { Чтение }
  Reset(input,'left.in');
  { В первой строке вводится одно число N (1<=n<=666) - количество 
    данных нам координат пути водителя (начало пути, повороты и конец пути). }
  Read(N);
  assert( (1<=N) and (N<=666) );
  { В следующих N строках вводятся 2 числа X и Y (-10000<=x,y<=10000; x, y - целые) - 
    координаты поворотов водителя (а также начала его пути и конца). } 

  { Считаем частичные суммы по строкам для
    быстрого вычисления сумм горизотальных полосок }
  for i:=1 to N do
    Sum[i,0] := 0;
  for i:=1 to N do
    for j:=1 to N do
      Sum[i,j] := Sum[i,j-1] + A[i,j];
  if debug then begin
    Writeln('Частичные суммы');
    for i:=1 to N do begin
      for j:=1 to N do
        write(Sum[i,j]:6);
      writeln;
    end;
  end;
  { Глобальный максимум и границы }
  gmax := 0;
  { Перебираем начало и конец суммируемой области }
  for B:=1 to N do
    for E:=B to N do begin
      { Поиск максимального подмассива }
      { Подмассив состоит из сумм полосок }
      for P:=1 to N do
        SP[P] := Sum[P,E]-Sum[P,B-1];
      { Поиск максимальной суммы }
      max := 0; max_idx := 0;
      min := 0; min_idx := 0;
      AreaSum := 0;
      for i:=1 to N do begin
        AreaSum := AreaSum + SP[i];
        if AreaSum > max then begin
          max := AreaSum;
          max_idx := i;
        end;
        if AreaSum < min then begin
          min := AreaSum;
          min_idx := i;
          max := AreaSum;
          max_idx := i;
        end;
      end;
      { Сравниваем с глобальным максимумом }
      if max-min > gmax then begin
        gmax := max-min;
        Left:=B; Right:=E;
        Up:=min_idx+1; Down:=max_idx;
      end;
    end;
  { Вывод ответа }
  if gmax > 0 then
    for i:=Up to Down do begin
      for j:=Left to Right do
        write(A[i,j]:8);
      writeln;
    end;
end.
