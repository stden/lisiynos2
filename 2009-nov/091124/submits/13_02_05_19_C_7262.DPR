program Project2;

{$APPTYPE CONSOLE}

uses
  SysUtils;
var s,s1,s2:string;
i,j,k,c,a,b,pa,pb:integer;


begin
assign(input, 'money.in');
reset(input);
assign(output, 'money.out');
rewrite(output);

read(s);
c:=length(s);
while j=0 do begin
i:= pos('*',s);
if i>0 then begin
a:=0;
b:=0;
  for k:= 1 to 10 do begin
    if a=0 then    
    if k<i then
    if (s[i-k]='*')or(s[i-k]='+') then begin
    a:=strtoint(copy(s,i-k,k));
    pa:=i-k;
    end;  
    if b=0 then 
    if k+i<c then
    if (s[i+k]='*')or(s[i+k]='+') then begin
    b:=strtoint(copy(s,i+1,k-1));
    pb:=i+k;
    end;
  end;
    if a=0 then
a:=strtoint(copy(s,0,i-1));
if b=0 then begin
b:=strtoint(copy(s,i+1,3));
pb:=100;
end;

s:=copy(s,0,pa)+inttostr(a*b)+copy(s,pb,100);
//writeln(a,'*',b);
//writeln(s);
end else
j:=1;
end;

j:=0;

while j=0 do begin
i:= pos('+',s);
if i>0 then begin
a:=0;
b:=0;
pa:=0;
pb:=0;
  for k:= 1 to 10 do begin
    if a=0 then
    if k<i then
    if s[i-k]='+' then begin
    a:=strtoint(copy(s,i-k,k));
    pa:=i-k;
    end;
    if b=0 then 
    if k+i<c then
    if s[i+k]='+' then begin
    b:=strtoint(copy(s,i+1,k-1));
    pb:=i+k;
    end;
  end;
    if a=0 then begin
a:=strtoint(copy(s,0,i-1));
pa:=0;
end;
if b=0 then begin
b:=strtoint(copy(s,i+1,3));
pb:=100;
end;

s:=copy(s,0,pa)+inttostr(a+b)+copy(s,pb,100);
//writeln(a,'+',b);
//writeln(s);
end else
j:=1;
end;
writeln(s);

end.
