program C;
var s:string; i:integer; a:boolean;
begin
  assign(input,'palin.in');
  assign(output,'palin.out');
  reset(input);
  rewrite(output);
  read(s);
      i:=1;
      while s[i]=' ' do
       begin
        delete(s,i,1);
        if s[i]<>' ' then inc(i);
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
