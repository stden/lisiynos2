program palindrom;

{$APPTYPE CONSOLE}
var str1:string;
i:integer;
begin
  { TODO -oUser -cConsole Main : Insert code here }
  assign(input,'palin.in');
  assign(output,'palin.out');
  reset(input);
  rewrite(output);
  readln(str1);
  i:=1;
  while i<=length(str1) do
      if str1[i]=' ' then i:=i+1
      else delete(str1,i,1);
  for i:=1 to length(str1) div 2 do
    if str1[i]<>str1[length(str1)-i+1] then
      begin
        writeln('NO');
        halt(0);
      end;
  writeln('YES');
  close(input);
  close(output)
end.
                                                                                -