
program minim;
type tm=array[1..150000]of integer;
var
mini,mas1:tm;
min,i,j,m,n,pos:integer;
begin
  assign(input,'interval.in');
  assign(output,'interval.out');
  reset(input);
  rewrite(output);
  readln(n,m);
  for i:=1 to n do
    read(mas1[i]);
  min:=mas1[1];
  pos:=1;
  for i:=1 to m do

    if mas1[i]<min then
    begin
    min:=mas1[i];
    pos:=i;
    end;
  mini[1]:=min;
  writeln(mini[1]);

  for j:=2 to n-m+1 do
  begin
    if (pos>=j) and (min<mas1[j+m])  then mini[j]:=mini[j-1] else
  begin
     min:=mas1[j];
     pos:=j;
  for i:=j to m+j-1 do
    if mas1[i]<min then
    begin
    min:=mas1[i];
    pos:=i;
    end;
  mini[j]:=min;
  end;
  writeln(mini[j]);
  end;
  close(input);
  close(output);
end.
