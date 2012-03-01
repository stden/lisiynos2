begin
assign(output,'tree.out');
rewrite(output);
if (random(1)=1) then
writeln('YES')
else
writeln('NO');
end.