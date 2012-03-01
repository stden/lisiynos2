program stroki;
var  f:text;
     s,t,k:string;
     q,o,x:longint;
     y:byte;
function l(v:string):boolean;
var z:integer;
    h:string;
begin
for z:= 1 to length(v) - 1 do
   begin
    if k=copy(v,length(v)+1-z,z) then begin
    x:=x+1;
    o:=length(v)+1-z-length(k)-1; exit;
   end;
   if length(v)=length(s) then   y:=1;

  end;
end;
begin
q:=0;
 assign(f,'substr.in');
 reset(f);
 readln(f,t);
 readln(f,s);
 k:=s;
 close(f);
 assign(f,'substr.out');
 rewrite(f);
 s:=k+'#'+t;
 while length(k)<=length(s) do
   begin
     o:=0;
      q:=q+1;
       l(k+'#'+copy(t,1,length(k)-1+q));
       if o>0 then writeln(f,o,' ');
       if y=1 then break;
   end;
   if x=0 then  write(f,'none');

     close(f);
end.
