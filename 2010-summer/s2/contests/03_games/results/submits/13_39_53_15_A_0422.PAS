program AA;
var 
N,M, e : integer;
begin
  assign(input,'knight.in');
  assign(output,'knight.out');
  reset(input);
  rewrite(output);
  read(N , M);
   e:= (n+m-2) div 3;
   if ((n + m -2) mod 3 <> 0) or (m*2 <n) or (n*2<m) then writeln(0) else
     begin
         if m<>n then
         begin
             e:= (n+m-2) div 6;
         end;
     writeln(e);
     end;



   
 close(input);
 close(output);
end.
