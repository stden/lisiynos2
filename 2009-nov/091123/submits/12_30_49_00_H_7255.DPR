uses SysUtils;

const Nmax=16;

var
  Save : array [1..nmax,1..nmax,1..nmax] of Int64;

function F( i,n,p:byte; x:integer ):Int64;
{ i-ый паровоз впереди,
  n паровозов всего
  p групп }
var j:byte;
begin
  if Save[i,n,p]=-1 then begin
    if x=0 then writeln( Format('F(i=%d,n=%d,p=%d)=',[i,n,p] ) );
    Result := 0;
    { Рассмотрим, как может i-ый паровозик оказаться впереди }
    { При этом есть 2 варианта: }
    {  1. Он уйдёт вперёд и образует новую группу }
    {    Т.е. он быстрее предыдущего паровозика }
    {    Пусть предыдущий едет со скоростью j }
    { Мы могли получить это из ситуации:
       j in [1..i-1]
       n-1 паровоз всего;
       p-1 группа всего;
       т.е. новый паровоз образовал новую группу }
    for j:=1 to i-1 do begin
      Result := Result + F(j,n-1,p-1,x+1);
      if x = 0 then writeln( Format('  + F(i=%d,n=%d,p=%d)=%d',[j,n-1,p-1,F(j,n-1,p-1,x+1)] ) );
    end;
    {   i-ый не образует новую группу, т.е. j>i }
    for j:=i+1 to n do begin
      Result := Result + F(i,n-1,p,x+1);
      if x = 0 then writeln( Format('  + F(i=%d,n=%d,p=%d)=%d *',[i,n-1,p,F(i,n-1,p,x+1)] ) );
    end;
    Save[i,n,p] := Result;
  end;
  F:=Save[i,n,p];
  if (i>n) or (p>n) then
    assert( Result = 0 );
end;

var i,j,NN,PP,n,p:byte;
    s:Int64;
begin
  Assign(Input,'h.in'); Reset(Input);
  Assign(Output,'h.out'); Rewrite(Output);
  readln(NN,PP);
//  NN := Nmax;
  for i:=1 to NN do
    for n:=1 to NN do
      for p:=1 to NN do begin
        Save[i,n,p]:=-1;
        if (i>n) or (p>n) then Save[i,n,p]:=0;
        { Одна группа - и не первый впереди - не может быть :) }
        if (p=1) and (i<>1) then Save[i,n,p]:=0;
        { Кол-во групп = кол-ву паровозов и первый - самый быстрый }
        if (n=p) and (i=n) then Save[i,n,p]:=1;
      end;
  for i:=1 to NN do
    for n:=1 to NN do
      for p:=1 to NN do begin
        if (n=p) and (i<n) then assert( F(i,n,p,1) = 0 );
        if i>n then assert( F(i,n,p,1) = 0,
          Format('F(%d,%d,%d)=%d',[i,n,p,F(i,n,p,1)]) );
      end;
  s:=0;
  for i:=1 to NN do
    s:=s+F(i,NN,PP,1);
  writeln(s);
  assert( F(1,3,1,1) = 2 );
  assert( F(3,3,3,1) = 1 );
  assert( F(2,3,2,1) = 2 );
  assert( F(3,3,2,1) = 1 );
end.
