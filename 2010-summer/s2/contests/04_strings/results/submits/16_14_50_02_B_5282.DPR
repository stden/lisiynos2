program b;
var n,i,j,k:integer;
    P:array [1..1000000] of longint;
    s: string;
    f1:boolean;
begin
assign(input,'pi.in');
assign(output,'pi.out');
reset(input);
rewrite(output);
read(s);
p[1]:=0;
k:=0;
  for i:=2 to length(s) do begin
    while(k>0) and (s[k+1]<>s[i]) do
      k:=p[k];
    if s[k+1]=s[i] then k:=k+1;
      p[i]:=k;
  end;

  for i:=1 to length(s) do
write(p[i]);
close(input);
close(output);
end.
