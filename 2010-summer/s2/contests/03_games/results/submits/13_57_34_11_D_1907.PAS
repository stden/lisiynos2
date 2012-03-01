program checkers;
type tm=array[1..100]of integer;
var n,i,k,j:longint;
    mas:tm;
    priznak:boolean;
    count:integer;
begin
     assign(input, 'nim.in');
     assign(output, 'nim.out');
     reset(input);
     rewrite(output);
     readln(n);
     for i:=1 to n do
         readln(mas[i]);
     if n=1 then
        begin
        writeln('First');
        halt(0)
        end;

     k:=1;
     j:=1024;
     count:=0;
     while k<=n do
     begin
           for i:=k+1 to n do
               if  (mas[k]=mas[i])  then
               begin
                   count:=count+1;
                   mas[i]:=j;
                   j:=j+1;
               end;

           k:=k+1;
     end;

     if count mod 2=0 then writeln('Second')
     else writeln('First');

     close(input);
     close(output)
end.