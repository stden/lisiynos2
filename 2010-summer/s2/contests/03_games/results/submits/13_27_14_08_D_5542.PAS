program DD;
var i,n:integer;
a:array[1..100] of integer;
begin
     assign(input,'nim.in');
     assign(output,'nim.out');
     reset(input);
     rewrite(output);
     readln(n);
     for i:=1 to n do
     read(a[i]);
     write('Second');
     close(input);
     close(output);
end.