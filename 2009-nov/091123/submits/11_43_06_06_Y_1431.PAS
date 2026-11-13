program z;
var s:string;
    i:integer;
begin
 assign(input,'y.in');
 reset(input);
 assign(output,'y.out');
 rewrite(output);
 readln(s);
  for i:=length(s) downto 1 do write(s[i]);
 readln;
End.