{$apptype console}

var N,K,i :integer;
    z:int64;

Function S(N,K:integer):int64;
begin
  If n<k Then s:=0
      else if n=k Then s:=1
           else if k=0 Then S:=0
               else if k=1 Then s:=1
                    else S:=S(n-1,k-1)+k*S(n-1,k);
end;

begin
  assign(input,'xgroups.in'); reset(input);
  assign(output,'xgroups.out'); rewrite(output);

  readln(N);
  z:=0;
  For i:=0 To N Do Begin
    z:=S(N,i)+z;
  end;
  WriteLn(z);
end.