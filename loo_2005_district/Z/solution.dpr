Uses SysUtils;

var
  a,b : Int64;
  i,j,k : integer;
begin
  assign(input,'z.in'); reset(input);
  assign(output,'z.out'); rewrite(output);
  {}
  read(a,b);
  write(a+b);
  {}
  for i:=1 to 500 do 
    for j:=1 to 500 do 
      for k:=1 to 500 do 
        a := b + 2;
end.