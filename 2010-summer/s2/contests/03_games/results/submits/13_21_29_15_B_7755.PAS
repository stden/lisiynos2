program b1;
var f1,f2:text;
    n,m,x:integer;

BEGIN
 assign(f1, 'candy.in'); reset(f1);
 assign(f2, 'candy.out'); rewrite(f2);
 read(f1,x,n);
 if (x mod 2 = 1) and (x mod 2=1) then
  writeln(f2, n )
   else
    if((x mod 2)=1) and ((x mod 2) =0) then
     writeln(f2,'1')
      else
       if ((x mod 2)=0) and ((x mod 2)=1) then
        writeln(f2,'0')
         else
          if ((x mod 2)=0) and ((x mod 2) = 0) then
           writeln(f2, (n-1));
 close(f1);
 close(f2);
end.