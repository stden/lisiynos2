begin
assign(output,'regex.out'); rewrite(input);
if (random(1))=1 then write('YES') else write('NO')
end.