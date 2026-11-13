var a,b : Int64;
begin
  assign(input,'z.in'); reset(input);
  assign(output,'z.out'); rewrite(output);
  {}
  read(a,b);
  write(a+b);
end.