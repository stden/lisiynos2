{$APPTYPE CONSOLE}

var 
  K,N : integer;
begin
  assign(INPUT,'a1.in');reset(INPUT);
  assign(OUTPUT,'a1.out');rewrite(OUTPUT);
  read(K,N);
  if N mod K = 0 then write(N div K, ' ', K) 
  else write (N div K + 1, ' ', N mod K);
  close(INPUT);
  close(OUTPUT);
end.