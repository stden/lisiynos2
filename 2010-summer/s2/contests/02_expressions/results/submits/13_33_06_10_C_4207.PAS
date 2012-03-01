var s:string;
i:integer;
begin
assign(input,'lexem.in'); reset(input);
assign(output,'lexem.out'); rewrite(output);
read(s);
for i:=1 to length(s)-1 do begin
write(s[i]); writeln; end;
end.