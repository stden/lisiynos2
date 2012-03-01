var S : String; i : longint;
begin
  assign(input,'g1.in'); reset(input);
  assign(output,'g1.out'); rewrite(output);
  {}
  readln(S);
  for i:=length(S) downto 1 do 
    write(S[i]);
end.