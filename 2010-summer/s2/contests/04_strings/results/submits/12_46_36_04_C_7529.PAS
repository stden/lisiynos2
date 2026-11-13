program palin;

Var
  a,i,p,n : integer;
  s : string;
  c : array[0..256] of char;
  
BEGIN

  Assign(input,'palin.in');
  Assign(output,'palin.out');
  Rewrite(output);
  Reset(input);

  Read(s);
  n:= length(s);
  reset(input);
  p:=1;
  
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
    if c[i] <> c[p-i] then
     a:=1;
   end;
   
  If a=1 then write('NO')
  else write('YES');
  
  close(output);
  close(input);

END.