// Решение к задаче "D. Цифры"
// Автор: Степулёнок Д.О.
// E-mail: stden@inruscom.com

uses SysUtils;

var
  n,i : longint;
  sum, num : int64;
begin
  assign(input,'digits.in'); reset(input);
  assign(output,'digits.out'); rewrite(output);
  // Чтение исходных данных
  read(n); assert( n <= 100000 );
  // Решение
  //  0
  //  1
  //  ...
  //  9
  // Сумма = 45, Количество чисел = 10
  // Теперь дописываем спереди к каждому числу по цифре 0..9
  sum := 0; num := -1;
  for i:=1 to n do begin
    sum := sum + 45;
    inc( num );
    assert( sum < 10000000 );
  end;
  // Запись результатов
  write(sum);
  for i:=1 to num do write('0');
end.
