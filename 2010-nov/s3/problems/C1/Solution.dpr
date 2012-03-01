{$APPTYPE CONSOLE}
var 
  X,Y,k,i : integer;
begin
  assign(INPUT,'c1.in');reset(INPUT);
  assign(OUTPUT,'c1.out');rewrite(OUTPUT);
  read(X,Y);
  if (X>2*Y) or (Y>2*X) then
    write('NO SOLUTION')
  else if X>=Y then begin
       k:=X-Y;
       for i:=1 to k do
         write('BGB');
       for i:=1 to Y-k do
         write('BG');
     end
     else begin
       k:=Y-X;
       for i:=1 to k do
         write('GBG');
       for i:=1 to X-k do
         write('GB');
     end;
  close(INPUT);
  close(OUTPUT);
end.