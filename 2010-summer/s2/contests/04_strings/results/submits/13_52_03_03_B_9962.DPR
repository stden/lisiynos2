program Project2;

Var
p: array [1..1000000] of int64;
s:string;
I, k,m,n:longint;
begin
Assign(input,'pi.in');
assign(output,'pi.out');
Rewrite(output);
Reset(input);

Readln(s);
M:=length(s);
k:=0;
for I:=2 to m  do
begin
  while (k>0) and (s[k+1]<>s[i]) do
  k:=p[k];
  if (s[k+1]=s[i]) then k:=k+1;
  p[i]:=k;
  end;
 For I:=1 to m do
Write(p[i],' ');
close(output);
close(input);

end.





