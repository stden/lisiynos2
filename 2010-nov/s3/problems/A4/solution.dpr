{$APPTYPE CONSOLE}

(*

\def\name{a4}%
\begin{problem}{Достижимые вершины}{\name.in}{\name.out}{}{}

  Задан неориентированный граф,
  нужно определить, какие вершины достижимы из заданной вершины
  S (находятся с ней в одной компоненте связности).

\InputFile

  В первой строке записаны три числа $N$,$M$,$S$ разделённые пробелами.
  $N$ - количество верщин ($1 \le N \le 255$). $M$ - количество ребёр.
  $S$ - верщина из которой начинаем обход.

  Далее идёт $M$ строк.
  Каждая строка задаёт одно ребро и содержит 2 числа $F$, $T$.
  Ребро соединяет вершины $F$ и $T$.

\OutputFile

  Выведите все достижимные из $S$ вершины в порядке возрастания разделённые
  пробелами.

\Examples

\begin{example}
\exmp{ \input \name/01 }{ \input \name/01.a }%
\exmp{ \input \name/02 }{ \input \name/02.a }%
\exmp{ \input \name/03 }{ \input \name/03.a }%
\end{example}

\end{problem}
*)

{ Реализация DFS через множества }
var
  N : byte; { количество верщин }
  M : Integer; { количество ребёр }
  A : Array [1..256] of Set of Byte;
  C : Set of Byte;
  S : byte;

procedure DFS( i:byte );
var j : byte;
begin
  if i in C then exit;
  C := C + [i];
  for j := low(Byte) to high(Byte) do
    if j in A[i] then
      DFS(j);
end;

var
  i : integer;
  F,T : byte;
begin
  Reset(input,'a4.in');
  Rewrite(output,'a4.out');
  { Чтение входных данных }
  Read(N,M,S);
  for i:=1 to N do
    A[i] := [];
  for i:=1 to M do begin
    Read(F,T);
    A[F] := A[F] + [T];
    A[T] := A[T] + [F];
  end;
  { Инициализация }
  C := [];
  { Вызов поиска в глубину }
  DFS(S);
  { Вывод ответа }
  for i := low(Byte) to high(Byte) do
    if i in C then
      write(i,' ');
end.



