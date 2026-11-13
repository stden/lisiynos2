{$apptype console}

var N,K :integer;

Function S(N,K:integer):int64;
begin
  If n<k Then s:=0
      else if n=k Then s:=1
           else if k=0 Then S:=0
               else if k=1 Then s:=1
                    else S:=S(n-1,k-1)+k*S(n-1,k);
end;

begin
  assign(input,'groups.in'); reset(input);
  assign(output,'groups.out'); rewrite(output);
  readln(N,K);
  WriteLn(S(N,K));
end.