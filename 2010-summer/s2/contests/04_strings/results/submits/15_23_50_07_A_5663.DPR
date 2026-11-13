program stroki;
var  f:text;
     t,k:string;
     q,o,x:int64;
     y,po:byte;
procedure l(v:string);
var z:integer;
begin

for z:= 1 to length(v) - 1 do
   begin
   if  po=1 then begin y:=1; exit; end;
    if k=copy(v,length(v)+1-z,z) then begin
    x:=x+1;
    o:=length(v)+1-z-length(k)-1;
     if length(v)=length(k+'#'+t) then po:=1;
   exit;
   end;
   if length(v)=length(k+'#'+t) then  begin
     y:=1;
     exit;
   end;

  end;
end;
begin
po:=0;
 assign(f,'substr.in');
 reset(f);
 readln(f,t);
 readln(f,k);
 close(f);
 assign(f,'substr.out');
 rewrite(f);
 while length(k)<=length(k+'#'+t) do
   begin
     o:=0;
      q:=q+1;
       l(k+'#'+copy(t,1,length(k)-1+q));
       if o>0 then write(f,o,' ');
       if y=1 then break;
   end;
   if x=0 then  write(f,'none');

     close(f);
end.
