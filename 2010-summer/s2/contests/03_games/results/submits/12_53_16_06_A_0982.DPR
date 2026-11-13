program AA;
var 
a:array[1..50] of  char;
b:array[1..50] of char;
N,M, e : integer;
begin
  assign(input,'knight.in');
  assign(output,'knight.out');
  reset(input);
  rewrite(output);
  read(N , M);
   e:= (n+m-2) div 3;
   if ((n + m -2) and 3 <> 0) or (m*2 <n) or (n*2<m) then writeln(0) else
   writeln(a);
 close(input);
 close(output);
end.
