function F( i:integer ):Int64;
begin
  case i of
    1: F := 1;
    2: F := 1;
  else
    F := F(i-1) + F(i-2);
  end;
end;

Var N : Integer;
Begin
  Assign(Input,'b.in'); Reset(Input);
  Assign(Output,'b.out'); Rewrite(Output);
  Read(N);
  Writeln(F(N));
End.