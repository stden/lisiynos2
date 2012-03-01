program komponent;
type tm=array[1..100,1..100] of integer;
var  mas:tm;
     n,i,j,m:byte;


begin
     assign(input,'tree.in');
     assign(output,'tree.out');
     reset(input);
     readln(n);
     m:=0;
     for i:=1 to n do
         for j:=1 to n do
         begin
            read (mas[i,j]);
            if mas[i,j]=1 then
               m:=m+1;
         end;
     rewrite(output);
     m:=m div 2;
        if m=n-1 then
           write('YES')
        else write('NO');
     close(input);
     close(output);
end.
