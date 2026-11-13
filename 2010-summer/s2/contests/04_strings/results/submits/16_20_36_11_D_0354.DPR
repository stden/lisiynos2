program b;
type tm=array[1..10000000] of integer;
{$APPTYPE CONSOLE}
var str1:string;
  z:tm;
  i,r,k,j,count,l:integer;
begin
  { TODO -oUser -cConsole Main : Insert code here }
  assign(input,'z.in');
  assign(output,'z.out');
  reset(input);
  rewrite(output);
  readln(str1);
  z[2]:=0;
  for i:=1 to length(str1)-1 do
    if str1[i]=str1[i+1] then
      z[2]:=z[2]+1
    else break;
  if z[2]=0 then
  begin
    r:=z[2]+1;
    l:=2
  end
  else
  begin
    r:=0;
    l:=0
  end;
  for k:=3 to length(str1) do
    if k>r then
    begin
    count:=0;
    j:=k;
    i:=1;
         while (j<=length(str1)) and (i<=length(str1)) do
          if str1[j]=str1[i] then
            begin
              j:=j+1;
              i:=i+1;
              count:=count+1;
            end
          else break;
    z[k]:=count;
    if z[k]>0 then
    begin
      r:=k+z[k]-1;
      l:=k
    end;
    end
    else
     begin
      j:=k-l+1;
      if z[j]<r-k+1 then
          z[k]:=z[j]
      else
        begin
          j:=r+1;
          i:=r-k+2;
          while (j<=length(str1)) and (i<=length(str1)) do
          if str1[j]=str1[l] then
            begin
              j:=j+1;
              i:=i+1;
            end
          else break;
          z[k]:=j-k;
          r:=j-l;
          l:=k
          end
     end;
    for i:=2 to length(str1) do
      write (z[i],' ');
  close(input);
  close(output)
end.

