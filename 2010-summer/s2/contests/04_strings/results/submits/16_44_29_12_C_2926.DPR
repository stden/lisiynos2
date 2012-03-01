program palin;

Var
  input,output : file of longint;
  a,i,p,n : integer;
  s : string;
  c : array[1..256] of char;

BEGIN

  Assign(input,'palin.in');
  Assign(output,'palin.out');
  Rewrite(output);
  Reset(input);

  Readln(s);
  n:= length(s);
  p:=1;
  a:=0;    

  For i:=1 to n do
    begin
     if s[i] <> ' ' then
      begin
       c[p]:=s[i];
       p:= p + 1;
      end;
    end;

  For i:=1 to p do
   begin
    if c[i] <> c[n-i+1] then
     a:=1;
   end;
   
  If a=1 then write('NO')
  else write('YES');

  close(output);
  close(input);

END.
