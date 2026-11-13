program CC;
var n,m,s:array[1..100] of integer; k,i,nr,mr:integer;a:boolean;
begin
     assign(input,'collect.in');
     assign(output,'collect.out');
     reset(input);
     rewrite(output);
       readln(nr);
       for i:=1 to nr do
         read(n[i]);
         readln(mr);
       for i:=1 to mr do
         read(m[i]);
       for i:=1 to mr do
       s[i]:=0;
       for i:=1 to mr do
         begin
           for k:=1 to nr do
             if m[i]=n[k]
               then
                 begin
                   s[i]:=1;
                   break;
                 end;
         end;
         for i:=1 to mr do
         writeln(s[i]);
     close(input);
     close(output);
end.
