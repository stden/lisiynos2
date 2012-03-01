program b;
type tm=array[1..10000000] of integer;
{$APPTYPE CONSOLE}
var str1:string;
  pi:tm;
  i,k:integer;
begin
  { TODO -oUser -cConsole Main : Insert code here }
  assign(input,'pi.in');
  assign(output,'pi.out');
  reset(input);
  rewrite(output);
  readln(str1);
  pi[1]:=0;
  k:=0;
  for i:=2 to length(str1) do
  begin
    while (k>0) and (str1[k+1]<>str1[i]) do
         k:=pi[k];
        if str1[k+1]=str1[i] then
        k:=k+1;
        pi[i]:=k;
  end;
  for i:=1 to length(str1) do
    write(pi[i],' ');
  close(input);
  close(output)
end.

