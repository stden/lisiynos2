{ Ленинградская областная олимпиада 2004-2005. Районный тур }
{ Задача A. Королевство }
{ Решение: Степулёнок Денис - Denis@nic.spb.ru }
{ Язык: Delphi 6.0/7.0 }
{$APPTYPE CONSOLE}

uses SysUtils;

const 
  FileName = 'connect';
  maxN = 100;
  maxM = 10000;

var
  N,M,i,j,k,t,Answer : Integer;
  Color : Array [1..MaxN] of Integer;
  Use : Array [1..MaxN] of Boolean;
begin
  { Открываем входные/выходные файлы }
  assign(input,FileName+'.in'); reset(input);
  assign(output,FileName+'.out'); rewrite(output);
  { Считываем количество замков и дорог }
  read(N,M);
  { Проверка теста на соответствие ограничениям }
  assert( (1<=N) and (N<=MaxN) );
  assert( (0<=M) and (M<=MaxM) );
  { Красим каждый замок в свой цвет }
  for k:=1 to N do Color[k]:=k;
  { Считываем дороги. Если дорога соединяет вершины c цветами Color1 и Color2,
    перекрасим все замки цвета Color2 в цвет Color1.
    После окончания алгоритма все замки, находящиеся в одной группе будут
    одного цвета. }
  for k:=1 to M do begin
    read(i,j);
    { Проверка теста на корректность }
    assert( (1<=i) and (i<=N) );
    assert( (1<=j) and (j<=N) );
    { Перекрашивание }
    for t:=1 to N do
      if Color[t] = Color[j] then Color[t]:=Color[i];
  end;
  { Выясняем количество различных цветов, для этого заведём логический массив
    Use. Use[i] - учли ли мы уже цвет i }
  fillChar(Use,SizeOf(Use),false); // Сначала считаем, что 
                     // не просмотрели ни одного цвета
  Answer := 0; // Ответ задачи - количество групп = количество цветов
  for i:=1 to N do 
    if not Use[Color[i]] then begin
      Use[Color[i]] := true;
      Inc(Answer);
    end;
  { Выводим ответ }
  write( Answer );
end.
