program gg;
var a,b,c,x,y,h:real;
begin
assign(input,'dist.in');reset(input);
assign(output,'dist.out');rewrite(output);
while not eof do begin
  while not eoln do begin
  read(a,b,c);if (a=0)and(b=0)and (c=0)then halt;
  readln(x,y);

  h:=(a*x+b*y+c)/(sqrt(a*a+b*b));
  writeln(h:0:3);
end;
end;

close(input);
close(output);
end.