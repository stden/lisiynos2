program knight;
var
 k,n,m,n1,a,m1,m2,n2,k1,i,c:integer;
begin
 assign(input,'knight.in');
 assign(output,'knight.out');
 reset(input);
 rewrite(output);
 readln(n,m);
 k:=0;
 c:=0;
 i:=0;
 m2:=m;
 n2:=n;
 a:=0;
 k1:=1;
 if m>n then
         begin
          c:=n;
          n:=m;
          m:=c;
          k1:=0;
         end;
 while m>0 do
  begin
   if m>=n then begin
            i:=i+1;
            if (n=m) and (k1=0) then
                                 begin
                                  c:=n;
                                  n:=m;
                                  m:=c;
                                  k1:=1;
                                  k:=k+2;
                                  inc(a);
                                 end
                            else
                             begin
                              c:=n;
                              n:=m;
                              m:=c;
                              inc(k);
                             end;
                 end;


   m1:=m;
   n1:=n;
   n:=n-2;
   m:=m-1;

  end;
  if (n2=4) and (m2=4) then writeln(2)
                       else
                        if ((n2=2) and (m2=3)) or ((n2=3) and (m2=2)) then writeln(1)
                                                                      else
                                                                       if i=1 then  if (m1=1) and (n1=1) then writeln(k)
                                                                                                        else writeln(0)

                                                                              else
                                                                   if (m1=1) and (n1=1) then writeln(k+1)
                                                                                        else writeln(0);
close(input);
close(output);
end.
