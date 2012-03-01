program a5;
type tm=array[1..202]of longint;
var mas:tm;
  str1:string;
  i,j,f,k:integer;
begin
  assign(input,'postfix.in');
  assign(output,'postfix.out');
  reset(input);
  rewrite(output);
  readln(str1);
  i:=1;
  j:=1;
  while i<=length(str1) do
    begin
      if str1[i]='+' then mas[j]:=2147483645 else
      if str1[i]='-' then mas[j]:=2147483646 else
      if str1[i]='*' then mas[j]:=2147483647 else
      mas[j]:=ord(str1[i])-ord('0');
      j:=j+1;
      i:=i+2
    end;
    i:=1;
    while i<=j do
      begin
        if mas[i]=2147483645 then
          begin
          mas[i-2]:=mas[i-2]+mas[i-1];
          for f:=1 to 2 do
          for k:=i-1 to j do
          mas[k]:=mas[k+1];
          i:=1;
          j:=j-1;
          end
        else
        if mas[i]=2147483646 then  begin
          mas[i-2]:=mas[i-2]-mas[i-1];
          for f:=1 to 2 do
          for k:=i-1 to j do
          mas[k]:=mas[k+1];
          i:=1;
          j:=j-1;
          end else
        if mas[i]=2147483647 then  begin
          mas[i-2]:=mas[i-2]*mas[i-1];
          for f:=1 to 2 do
          for k:=i-1 to j do
          mas[k]:=mas[k+1];
          i:=1;
          j:=j-1;
          end else
           i:=i+1;

      end;
      writeln(mas[1]);
      close(input);
      close(output);
end.
