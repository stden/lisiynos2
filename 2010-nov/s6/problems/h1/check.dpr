{$I trans.inc}

uses testlib;

var
  ansWord, oufWord : String;
  i, badpos, tmp:longint;
  K : longint; { вес предмета, который положили на левую чашу }
  N : longint; { общее количество гирек }
  W : array [1..50] of LongInt; { Количество гирек с данным весом }
  R : longint; { Первое число в файле пользователя }
  JuryR : longint; { Первое числ в файле жюри }
  K2 : longint; { Вес на другой чашке }
begin
  K := inf.ReadLongint;
  N := inf.ReadLongint;
  for i := low(W) to high(W) do
    W[i] := 0;
  for i := 1 to N do
    inc( W[inf.ReadLongint] );
  { Первая чаша весов }
  JuryR := ans.ReadLongint; { Первое число из правильного ответа }
  R := ouf.ReadLongint; { Первое число из ответа участника }
  if (JuryR = -1) or (R = -1) then
    if R <> JuryR then
      QUIT(_WA,'Jury '+IntToString(JuryR)+' user '+IntToString(R))
    else
      QUIT(_OK,'OK :)');
  { Добавляем первую гирьку к K }
  if R<>0 then begin
    Dec( W[R] );
    if W[R] < 0 then
      QUIT(_WA,'Dont have with weight '+IntToString(R));
    Inc( K, R );
  end;
  { Добавляем остальные к K2 }
  while not ouf.seekeoln do begin
    R := ouf.ReadLongint;
    Dec( W[R] );
    if W[R] < 0 then QUIT(_WA,'Dont have with weight '+IntToString(R));
    Inc( K, R );
  end;
  ouf.newl(true);
  { Собираем вес на другой чашке }
  K2 := 0;
  while not ouf.seekeoln do begin
    R := ouf.ReadLongint;
    Dec( W[R] );
    if W[R] < 0 then QUIT(_WA,'Dont have with weight '+IntToString(R));
    Inc( K2, R );
  end;
  if K = K2 then
    QUIT(_OK,'OK :)')
  else
    QUIT(_WA,'Cup1 = '+IntToString(K)+' Cup2 = ' + IntToString(K2));
end.

