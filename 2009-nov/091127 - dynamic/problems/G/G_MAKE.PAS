Program KNumbers;
var TZ,Z,NZ,
    OTZ,OZ,ONZ:longint;
    N,K,i:integer;
begin
  Assign(Input,ParamStr(1)); Reset(Input);
  Assign(Output,ParamStr(2)); Rewrite(Output);
 Readln(N,K);
 TZ:=0;Z:=0;NZ:=K-1;
 for i:=2 to N do
  begin
   OTZ:=TZ;OZ:=Z;ONZ:=NZ;
   TZ:=OTZ*K+Z;
   Z:=ONZ;
   NZ:=OZ*(K-1)+ONZ*(K-1);
  end;
 Writeln(Z+NZ);
end.