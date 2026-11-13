program a4;
type tm=array[1..10000000] of integer;
{$APPTYPE CONSOLE}
var str1,str2:string;
  pi:tm;
  pr:boolean;
  i,k:integer;
begin
  { TODO -oUser -cConsole Main : Insert code here }
  assign(input,'substr.in');
  assign(output,'substr.out');
  reset(input);
  rewrite(output);
  readln(str1);
  readln(str2);
  str1:=str2+'8'+str1;
  pr:=false;
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
    if pi[i]>=length(str2) then
    begin
     write(i-2*length(str2));
     pr:=true;
     end;
  if pr=false then writeln('none');
  close(input);
  close(output)
end.

