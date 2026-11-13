
{$Apptype console}
var
  N,K : longint;

Function G(n,k:int64):int64;
begin

 if (k=0) and (n<>0) then g:=0 else
  if (n=k) then g:=1 else
   if k=1 then g:=1 else
    if (k=n-1) then g:=n*(n-1) div 2 else
     g:=k*g(n-1,k)+g(n-1,k-1);

end;
begin
 assign(input,'groups.in');reset(input);
 assign(output,'groups.out');rewrite(output);

  read(N,K);
   if n<k then  write('0') else
  write(g(N,K));
end.