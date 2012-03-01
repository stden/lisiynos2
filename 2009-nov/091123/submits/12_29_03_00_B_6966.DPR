var FF : array [1..100] of Int64;

function F( i:integer ):Int64;

begin
  if FF[i] <> -1 then 
    Result := FF[i];
  case i of
    1: Result := 1;
    2: Result := 1;
  else 
    Result := F(i-1) + F(i-2);
  end;
  FF[i] := Result;
end;

Var N,i : Integer;

Begin
  for i:=1 to 100 do
    FF[i] := -1;
  Assign(Input,'b.in'); Reset(Input);
  Assign(Output,'b.out'); Rewrite(Output);
  Read(N);
  Writeln(F(N));
End.