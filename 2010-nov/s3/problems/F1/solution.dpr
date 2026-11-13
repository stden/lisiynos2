var a,b : Int64;
begin
  assign(input,'f1.in'); reset(input);
  assign(output,'f1.out'); rewrite(output);
  {}
  read(a,b);
  write(a+b);
end.