program Project2;

{$APPTYPE CONSOLE}

uses
  SysUtils;
const p=10000;
type vlong=record
a:array[1..1000] of integer;
l:integer;
end;

function vlSum(a,b:vlong):vlong;
var c:vlong;
i,maxl:integer;
begin
if a.l>b.l then maxl:=a.l else maxl:=b.l;
for i:=1 to maxl do
  c.a[i]:=a.a[i]+b.a[i];
c.l:=maxl;
for i:=1 to maxl do
  if c.a[i] div p >0 then begin
    c.a[i+1]:=c.a[i] div p;
    c.a[i]:=c.a[i] mod p;
    if i=maxl then c.l:=maxl+1;
    end;
vlSum:=c;
end;

procedure writevl(a:vlong);
var i:integer;
begin
write(a.a[a.l]);
  for i:=a.l-1 downto 1 do
   if a.a[i]>1000 then write(a.a[i]) else
    if a.a[i]>100 then write('0',a.a[i]) else
      if a.a[i]>10 then write('00',a.a[i]) else
        if a.a[i]>1 then write('000',a.a[i]) else
          write('0000');
end;

var n,k,i,j:integer;
d:array[0..801] of vlong;
begin
  reset(input,'marsian.in');
  rewrite(output,'marsian.out');
  read(n,k);
  for i:=1 to n+k+1 do begin
  for j:=1 to 1000 do d[i].a[j]:=0;
  d[i].l:=0;
  end;
  d[0].l:=1;
  d[0].a[1]:=1;
  for i:=0 to n+1 do
    for j:=1 to k do
      d[i+j]:=vlSum(d[i+j],d[i]);

  writevl(d[n+1]);
  writeln;
end.
