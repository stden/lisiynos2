uses crt;
var i:integer;
begin
for i:=1 to 3 do
begin
sound(220);
delay(32000);
sound(440);
delay(32000);
sound(660);
delay(32000);
nosound;
end;
end.