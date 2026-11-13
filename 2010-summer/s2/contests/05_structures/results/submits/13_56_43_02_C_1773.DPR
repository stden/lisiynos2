program Collect;
var i, j, n, k, p,m:longint;
    a:array [1..100000] of longint;
    b:array [1..100000] of longint;
    begin
assign(input,'collect.in');
assign(output,'collect.out');
 reset(input);
 rewrite(output);
readln(n);
   for i:=1 to n do begin
       read(a[i]); end;
readln(m);
   for i:=1 to n do  begin
       read(b[i]); end;


     for j:=1 to n do  begin;
         for i:=1 to m do
           if b[i]=a[j] then k:=1 else k:=0; end;
           for i:=1 to m do
           write(k);
close(input);
close(output);
end.



