program C;
var s:string; i:integer; a:boolean;
begin
  assign(input,'palin.in');
  assign(output,'palin.out');
  reset(input);
  rewrite(output);
  read(s);
      for i:=1 to length(s) do
       if s[i]=' ' then
        begin
         while s[i]=' ' do
          delete(s,i,1);
        end;
    for i:=1 to length(s) do
      if s[i]=s[length(s)-i+1]
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
