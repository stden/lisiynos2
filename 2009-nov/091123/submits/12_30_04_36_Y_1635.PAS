program first;
  var a:string;
  var i,n:integer;
  var v:array[0..255] of char;
begin
assign(input, 'y.in');
reset(input);
assign(output, 'y.out');
rewrite(output);
i:=0;
readln(a);
n:=length(a);
for i:=0 to n do begin
v[n-i]:=a[i];
end;
for i:=0 to n-1 do begin
write(v[i]);
end;
end.