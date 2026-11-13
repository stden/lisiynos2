program D2ZADb;

{$APPTYPE CONSOLE}

 var a:array[1..5000] of extended;
       n,i,j:longint;
       t:extended;


begin
  reset(input,'median.in');
  rewrite(output,'median.out');
  read(n);
  for i:=1 to n do
    read(a[i]);

  for i:=1 to n do
    for j:=1 to n do
      if a[i]<a[j] then begin
                          t:=a[j];
                          a[j]:=a[i];
                          a[i]:=t;
                          end;


   {if n mod 2 = 0 then begin

   write(     (a[(n div 2) + 1]+a[n div 2]) / 2  :6:6     ); end;
   if n mod 2 <> 0 then write(a[(n div 2) +1] :6:6);}

//   if n mod 2<> 0 then
//   write(a[n div 2 +1] :6:6) else
   write(      (a[(n div 2) + 1]+a[((n-1) div 2) + 1])*0.5 :6:6);




end.
