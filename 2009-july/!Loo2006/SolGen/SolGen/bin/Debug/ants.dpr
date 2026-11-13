// Решение к задаче "A. Муравьи на кубической земле"
// Автор: Степулёнок Д.О.
// E-mail: stden@inruscom.com

uses SysUtils;

// Ограничения из условия задачи
const
  max_n = 100000;
  max_m = 15000;

var
  n : longint; // количество муравьев на земле
  m : longint; // длина стороны планеты
  x, y : longint; // координаты муравья
  ns_cnt : longint; // количество незанятых с севера на юг
  we_cnt : longint; // количество незанятых с запада на восток
  ns : array [1..max_m] of boolean; // занята ли полоса?
  we : array [1..max_m] of boolean; // занята ли полоса?
  _type : char; // направление движения муравья
  temp : char; // временная переменная для чтения из файла
  i, j : longint;
begin
  assign(input,'ants.in'); reset(input);
  assign(output,'ants.out'); rewrite(output);
  // Чтение исходных данных
  readln( n, m );
  assert( (1 <= n) and (n <= max_n) );
  assert( (1 <= m) and (m <= max_m) );
  fillchar( ns, sizeof(ns), false );
  fillchar( we, sizeof(we), false );
  for i:=1 to n do begin
    readln( x, y, temp, _type );
    assert( _type in ['N','S','W','E'] );
    // Записываем, какие полосы на кубе "вырезаны" муравьями
    if _type in ['N','S'] then ns[x] := true;
    if _type in ['W','E'] then we[y] := true;
    // Рисунка в моей копии условия нет, так что я не знаю как ориентированы оси X и Y
    // возможно, вместо двух предыдущих строк нужно написать так:
//    if _type in ['N','S'] then ns[y] := true;  // Расскоментируйте, если нужно :)
//    if _type in ['W','E'] then we[x] := true;
  end;
  // Решение
  ns_cnt := 0;  
  we_cnt := 0;
  for i:=1 to m do
    if not ns[i] then
      inc( ns_cnt );
  for i:=1 to m do
    if not we[i] then
      inc( we_cnt );
  // Запись результатов
  write( ns_cnt * we_cnt * 2 + // верхняя и нижняя грань
         (ns_cnt + we_cnt) * m * 2 // боковые грани
       );
end.
