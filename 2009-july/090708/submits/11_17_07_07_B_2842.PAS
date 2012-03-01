{$N+}
program gg;
var max:real;
 i,j,n:longint;
 x,y:array[1..3000]of longint;
 m:array[1..3200]of real;
begin
assign(input,'diam.in');reset(input);
assign(output,'diam.out');rewrite(output);
readln(n);
for i:=1 to n do begin
readln(x[i],y[i]);
end;
for i:=1 to n do begin
 for j:=1 to n do begin
 m[i]:=sqrt((x[i]-x[j])*(x[i]-x[j])+(y[i]-y[j])*(y[i]-y[j]));
 end;
end;
for i:=1 to n do begin
 for j:=1 to n do begin
 if m[j]>max then max:=m[j];
 end;
 end;
write(max:0:2);




close(input);
close(output);
end.