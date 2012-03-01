program C;
var k,s:string; l,i:integer; a:boolean;
begin
  assign(input,'palin.in');
  assign(output,'palin.out');
  reset(input);
  rewrite(output);
  read(s);
      l:=1;
      for i:=1 to length(s) do
       if s[i]<>' '
        then
         begin
          k[l]:=s[i];
          inc(l);
         end;
    for l:=1 to length(s) do
      if k[l]=k[length(k)-l+1]
       then a:=true
       else
        begin
        a:=false;
        break;
        end;
    if  a=true
     then write('YES');
    if a=false
     then write('N0');
  close(input);
  close(output);
end.
