{$A8,B-,C+,D+,E-,F-,G+,H+,I+,J-,K-,L+,M-,N+,O-,P+,Q-,R-,S-,T-,U-,V+,W-,X+,Y+,Z1}

program Project2;
var
a:array[1..150000] of longint;
b:array[1..10000] of longint;
q,w,e,i,min,s:longint;

begin
assign(input,'interval.in');
assign(output,'interval.out');
reset(input);
rewrite(output);
read(q);
readln(w);

for i:=1 to q do
    read(a[i]);
min:=a[1];
s:=1;
for e:=1 to q-w+1 do
begin
for i:=s to w do
       b[i]:=a[i];
for i:=s to w do
       if b[i]<min then
       begin
       min:=b[i];
       end;
writeln(min);
if s<=q-w+1 then inc(s);
min:=b[s];
if w<=q then inc(w);
end;
close(input);
close(output);
end.
