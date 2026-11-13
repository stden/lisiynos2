program A;
uses  SysUtils;
var head:Byte;
    s:char;
    st:array[1..100] of string;
procedure push(s:string);
begin
inc(head);
st[head]:=s;
end;

function pop:string;
begin
pop:=st[head];
dec(head);
end;

begin
 reset(input,'postfix.in');
 rewrite(output,'postfix.out');
while not EOF do
 begin
 read(s);
 if s<>' ' then
 begin
 if (s='+') or (s='-') or (s='*') then
    case s of
     '+' : push(intTostr(StrToInt(pop)+StrToInt(pop)));
     '-' : push(intTostr(-StrToInt(pop)+StrToInt(pop)));
     '*' : push(intTostr(StrToInt(pop)*StrToInt(pop)));
    end
 else
    push(s);
 end;
end;
write(pop);
end.
