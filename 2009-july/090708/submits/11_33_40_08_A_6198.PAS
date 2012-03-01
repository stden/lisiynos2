program dfdf;
 var
   a,b,c,x0,y0,i:integer;
   res:real;
begin
   assign(input,'dist.in');
	assign(output,'dist.out');
   reset(input);
   	rewrite(output);
for i:=1 to 1000 do begin
       read(a,b,c);
     if (a=0) and (b=0) and (c=0) then break else
   read(x0,y0);
     res:=(a*x0+b*y0+c)/(sqrt(a*a+b*b));
  writeln(res); end;
 close(input);
 close(output);
end.