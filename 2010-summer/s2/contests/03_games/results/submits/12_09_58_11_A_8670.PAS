program checkers;
type tm=array[1..50,1..50]of integer;
var n,i,j,k,l,m:longint;
    mas:tm;
begin
     assign(input, 'knight.in');
     assign(output, 'knight.out');
     reset(input);
     rewrite(output);
     readln(n,m);
     k:=2;
     l:=2;
     for i:=1 to n do
         for j:=1 to m do
             mas[i,j]:=0;
     mas[1,1]:=1;
     while k<=n do
     begin
           while l<=n do
           begin
                if k-2>=1 then
                   mas[k,l]:=mas[k,l]+mas[k-2,l-1];
                if l-2>=1 then
                   mas[k,l]:=mas[k,l]+mas[k-1,l-2];
                l:=l+1;
           end;
           k:=k+1;
           l:=2;
     end;
     writeln(mas[n,m]);
     close(input);
     close(output)
end.