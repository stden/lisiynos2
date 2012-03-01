{$APPTYPE CONSOLE}
var
s : string;
i,n : integer;

begin
assign(INPUT,'d1.in');reset(INPUT);
assign(OUTPUT,'d1.out');rewrite(OUTPUT);
read(s);
n := 0;
s:='!!'+s;
for i:=3 to length(s) do
  if (s[i] in ['a'..'z','A'..'Z'])  {s[i] - буква     }
   and not (s[i-1] in ['a'..'z','A'..'Z']) {s[i-1] - не буква}
   and not ((s[i-1]='-') and  (s[i-2] in   ['a'..'z','A'..'Z']))  {s[i-1] - не дефис}
   then n := n + 1; 
write(n);
close(INPUT);
close(OUTPUT);
end.