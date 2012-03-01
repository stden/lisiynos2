
program heap;
type tm=array[1..100000]of integer;
var h:tm;
  p,a,n,i,k:integer;

procedure swap(n1,n2:integer);
var tmp:integer;
  begin
    tmp:=h[n1];
    h[n1]:=h[n2];
    h[n2]:=tmp;
  end;
procedure shift_down(l:integer);
var mi:integer;
begin
  while true do
    begin
      mi:=l;
      if (2*l<=n) and (h[2*l]=h[mi]) then
      mi:=2*l;
      if (2*l+1<=n) and (h[2*l+1]>h[mi]) then mi:=2*l+1;
      if mi=l then break;
      swap(l,mi);
      l:=mi
    end;
end;
function getmax:integer;
var r:integer;
begin
  r:=h[1];
  h[1]:=h[n];
  dec(n);
  shift_down(1);
  getmax:=r;
end;
procedure shift_up(l:integer);
begin
  while (l div 2>=1) and (h[l div 2]<h[l])  do
  begin
  swap(l,l div 2);
  l:=l div 2
  end;
end;
procedure insert(p:integer);
begin
inc(n);
h[n]:=p ;
shift_up(n);
end;

begin
  assign(input,'heap.in');
  assign(output,'heap.out');
  reset(input);
  rewrite(output);
  read(k);
  for i:=1 to k do
  begin read(a);
    if a=0 then
    begin
      read(p);
      insert(p);
    end
    else
    writeln(getmax);
  end;
  close(input);
  close(output);
end.
