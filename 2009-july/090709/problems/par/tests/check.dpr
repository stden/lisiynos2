{$apptype console}
{$o-}
uses testlib,SysUtils;

{ Проверяющая программа к задаче "Параллельность" }

type integer = longint;


const
  maxm = 1000000;
var a,b:array [1..maxm] of integer;
  n,m,u,v:integer;
  i,first:integer;
  ca,ja:string;
procedure swap(var a,b:integer);
var
  t:integer;
begin
  t:=a;a:=b;b:=t;
end;

procedure qsort(l,r:integer);
var
  i,j,x,y:integer;
begin
  i:=l;j:=r;x:=a[(l+r) div 2];y:=b[(l+r) div 2];
  repeat
    while (a[i]<x) or ((a[i]=x)and(b[i]<y)) do inc(i);
    while (a[j]>x) or ((a[j]=x)and(b[j]>y)) do dec(j);
    if i<=j then begin
      swap(a[i],a[j]);
      swap(b[i],b[j]);
      inc(i);
      dec(j);
    end;
  until i>j;
  if i<r then qsort(i,r);
  if j>l then qsort(l,j);
end;

procedure test(var aa,bb:integer);
var
  l,r,mid:integer;
begin
  l:=1;
  r:=m;
  mid := r;
  while l <= r do Begin
      mid := (l + r) div 2;
      if a[mid] < aa then l := mid + 1;
      if a[mid] > aa then r := mid - 1;
      if (a[mid] = aa) then begin
        if b[mid] < bb then l := mid + 1;
        if b[mid] > bb then r := mid - 1;
        if b[mid] = bb then break;
      end;
    end;
    if (a[mid] <> aa) or (b[mid] <> bb) Then
      quit(_wa,'net rebra');
end;


var A1,B1,C1,A2,B2,C2 : longint;
begin
  
  while true do begin
    { Читаем две прямые из исходного файла }
    A1:=inf.readlongint; 
    B1:=inf.readlongint;
    C1:=inf.readlongint;
    { Если конец => выходим }
    if (A1=0) and (B1=0) and (C1=0) then 
      break;

    A2:=inf.readlongint; 
    B2:=inf.readlongint;
    C2:=inf.readlongint;

    ca := ouf.ReadString;
    ja := ans.ReadString;
    if UpperCase(ca)<>UpperCase(ja) then begin
      quit(_wa,'Yes-No');
    end;
  end;
  quit(_ok,'');
end.