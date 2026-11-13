{$APPTYPE CONSOLE}

Uses SysUtils;

function Full_Sol( N,M:Integer ):Integer;
var i,j,k : Integer;
begin
  Result:=0;
  for i:=1 to n do begin
    j:=i;
    k:=0;
    while j>0 do begin
      k:=k+j mod 10;
      j:=j div 10;
      end;
    if k mod m = 0 then inc(Result);
  end;
end;

Const
  MaxLen = 10;
  MaxSum = 100;

Var
  F : Array [0..MaxLen*2,0..MaxSum*2] of Int64;

procedure PreCalc;
Var Len,Sum,Dig : Integer;
begin
  { F[Len,Sum] - Количество чисел длины Len с суммой цифр Sum }
  { Лидирующие нули входят в сумму }
  fillChar(F,sizeOf(F),0);
  { Для длины 0 количество вариантов с суммой 0 - 1, остальных - 0 }
  F[0,0] := 1;
  for Len:=0 to MaxLen do
    for Sum:=0 to MaxSum do
      for Dig:=0 to 9 do
        F[Len+1,Sum+Dig] := F[Len+1,Sum+Dig] + F[Len,Sum];
end;

function mySol( N,K : Integer ):Integer;
var
  S : String;
  i,j : Integer;
  X : String;
  ch,Up : Char;
  D : Array [0..MaxSum*2] of Int64;
  Sum,Len,SS : Integer;
  Ans : Integer;
begin
//  writeln(N); // DEBUG
  S := IntToStr(N);
  for i:=1 to Length(S) do X := X+'X';
  { Обнуляем ответы }
  fillChar(D,SizeOf(D),0);
  { Главный цикл подсчёта }
  for i:=1 to Length(S) do begin
    if i=Length(S) then Up := S[i] else Up := Pred(S[i]);
    for ch:='0' to Up do begin
      { Формирование строки }
      X:='';
      for j:=1 to i-1 do X:=X+S[j];
      X := X + ch;
      for j:=i+1 to Length(S) do X := X + 'X';
      { Длина (именно она меня интересует) }
      Len := Length(S)-i;
      { Сумма цифр - тоже интересует }
      Sum := Ord(ch)-Ord('0');
      for j:=1 to i-1 do Sum:=Sum+Ord(S[j])-Ord('0');
      { Вывод }
(*      write(X,' ');   // DEBUG
      for j:=1 to Length(X) do if X[j]='X' then write('0') else write(X[j]);
      write('-');
      for j:=1 to Length(X) do if X[j]='X' then write('9') else write(X[j]);
      writeln(' ('+IntToStr(Len)+') '+IntToStr(Sum));  *)
      { Считаем ответы  }
      for SS:=0 to MaxSum do begin
        Inc( D[SS+Sum], F[Len,SS] );
//      if F[Len,SS]<>0 then writeln(Format('  D[%d]=%d',[SS+Sum,D[SS+Sum]])); // DEBUG
      end;
    end;
  end;
  { Ответ }
  Ans := 0;
  for Sum:=0 to MaxSum do
    if Sum mod K = 0 then
      Inc( Ans, D[Sum] );
//  Writeln(Ans);
  Result := Ans-1; // Нас не интересует число 0
end;

function Wrong_Sol( N,K:Integer ):Integer;
begin
  Result := N div K;
end;

procedure SaveInOutTest( TestNo:Integer; InF,OutF:String );
var TestName : String;
begin
  TestName := IntToStr(TestNo);
  while Length(TestName)<2 do TestName := '0'+TestName;
  assign(output,TestName); Rewrite(Output);
  write(InF);
  close(output);
  assign(output,TestName+'.a'); Rewrite(Output);
  write(OutF);
  close(output);
end;

var N,K,Test : Integer;
begin
//  assign(input,'a.in'); rewrite(output);
//  assign(output,'a.out'); rewrite(output);
//  assign(output,'new_sol.txt'); rewrite(output);
  RandSeed := 239;
  PreCalc;
  For Test:=9 to 50 do begin
    repeat
      N := Random(1000000000)+1;
      K := Random(9*9)+1;
    until (Wrong_Sol(N,K) - mySol(N,K) >= 15) and (mySol(N,K)>2);
    assert( (1 <= N) and (N <= 1000000000) );
    assert( (1 <= K) and (K <= 9*9) );
    SaveInOutTest(Test,
      Format('%d %d',[N,K]),
      Format('%d',[mySol(N,K)]) );
  end;
end.
