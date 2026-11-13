uses SysUtils;

var n,m,i,rn,rm:integer;
    q:array[1..100000] of integer;
    mark:array[1..20000000] of boolean;

function getnextnumber:integer;
begin
  repeat
    result:=random(rn)+1;
  until not mark[result];
  mark[result]:=true;
end;

procedure swap(var a,b:integer);
var c:integer;
begin
  c:=a;
  a:=b;
  b:=c;
end;

procedure qsort(l,r:integer);
var i,j,x:integer;
begin
  i:=l;
  j:=r;
  x:=Q[random(j-i+1)+i];
  while i<=j do begin
    while q[i]<x do inc(i);
    while q[j]>x do dec(j);
    if i<=j then begin
       swap(q[i],q[j]);
       inc(i);
       dec(j);
    end;
  end;
  if i<r then qsort(i,r);
  if l<j then qsort(l,j);
end;

begin
  fillchar(mark,sizeof(mark),0);
  n:=strtoint(paramstr(1));
  m:=strtoint(paramstr(2));
  randseed:=strtoint(paramstr(3));
  rn:=strtoint(paramstr(4));
  rm:=strtoint(paramstr(5));
  writeln(n);
  for i:=1 to n do 
    q[i]:=getnextnumber;
  qsort(1,n);
  for i:=1 to n do
    write(q[i],' ');
  writeln;
  writeln(m);
  for i:=1 to m do
    write(random(rm)+1,' ');
end.