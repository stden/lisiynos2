program MySol;

{$APPTYPE CONSOLE}

uses
  SysUtils;

const
  Task = 'b';
  MaxN = 100;
  NumLang = 50;

var
  N : integer; { Количество людей }
  Lang : array [1..MaxN,1..NumLang] of Boolean;
  Answer : integer;

{ Считаем количество человек, до которых может «дойти»
 отданная руководителем команда
 (включая самого руководителя). }
procedure Calc;
var
  Understand : array [1..MaxN,1..MaxN] of Boolean;
  Doshla : array [1..MaxN] of Boolean;
  i,j : integer;
  L : integer;
  Changes : boolean;
begin
  { Сначала никто никого не понимает }
  for i := 1 to N do
    for j := 1 to N do
      Understand[i,j] := false;
  { Отмечаем кто кого может понять }
  { Пробегаем все языки и отмечаем людей, которые могут
    друг друга понять на языке L }
  for L := 1 to 50 do
    for i := 1 to N do
      for j := 1 to N do
        { Если оба знают язык L }
        if Lang[i,L] and Lang[j,L] then begin
          { То они друг друга поняли }
          Understand[i,j] := true;
          Understand[j,i] := true;
        end;
  { = Подсчитаем до кого дойдёт команда = }
  { Сначала считаем, что команда руководителя понятна только ему }
  Doshla[1] := true;
  for i := 2 to N do
    Doshla[i] := false;
  repeat
    Changes := false;
    { Смотрим, кто ещё может понять тех,
      до кого уже дошла команда }
    for i:=1 to N do
      { Если до i-ого дошла }
      if Doshla[i] then
        for j := 1 to N do
          { И его понимает j-ый, до которого ещё не дошла }
          if Understand[i,j] and not Doshla[j] then begin
            { Тогда до j-ого команда тоже дошла }
            Doshla[j] := true;
            Changes := true;
          end;
  until not Changes;
  { Считаем количество понявших }
  Answer := 0;
  for i := 1 to N do
    if Doshla[i] then
      inc( Answer );
end;

procedure ReadData;
var
  i,Mi,j,L: Integer;
begin
  Reset(input,Task+'.in');
  { количество людей N (1<=N<=100) }
  Read(N);
  assert( (1 <= N) and (N <= 100) );
  { описания того, какие языки знают эти люди }
  for i := 1 to N do begin
    { число Mi (0<=Mi<=50), определяющее количество языков }
    Read(Mi);
    assert( (0 <= Mi) and (Mi <= 50) );
    { очищаем строку с языками, которые знает этот человек }
    { Сначала считаем, что человек не знает никаких языков }
    for j := 1 to NumLang do
      Lang[i,j] := false;
    { Отмечаем те языки, которые человек знает }
    { Во входном файле номера самих этих языков в }
    {  возрастающем порядке }
    for j:=1 to Mi do begin
      Read(L);
      { Человек i знает язык L }
      Lang[i,L] := true;
    end;
  end;
end;

procedure WriteAnswer;
begin
  Rewrite(output,Task+'.out');
  Writeln(Answer);
end;

begin
  try
    ReadData;
    Calc;
    WriteAnswer;
  except
    on E: Exception do
      Writeln(E.ClassName, ': ', E.Message);
  end;
end.
