{$APPTYPE CONSOLE}
var
  ar:array[0..1001] of integer;
  n:longint;
  l,x,i,j:longint;
  maxh:longint;
{}
begin
  assign(input,'lego.in');reset(input);
  assign(output,'lego.out');rewrite(output);
  {}
  read(n);
  for i:=0 to 1001 do ar[i]:=0;
  for i:=1 to n do begin
    read(l,x);maxh:=0;
    for j:=x to x+l-1 do if ar[j]>maxh then maxh:=ar[j];
    for j:=x to x+l-1 do ar[j]:=maxh+1;
  end;
  {}
  maxh:=0;
  for i:=0 to 1001 do if ar[i]>maxh then maxh:=ar[i];
  {}
  writeln(maxh);
  close(input);close(output);
end.