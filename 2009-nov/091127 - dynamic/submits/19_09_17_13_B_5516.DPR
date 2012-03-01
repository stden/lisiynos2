{$apptype console}
var i,n:integer;
    a,b,temp:int64;
begin
  assign(input,'b.in'); reset(input);
  assign(output,'b.out'); rewrite(output);
  read(n);
  if n>2 Then begin
    a:=1; b:=1;
    For i:=2 To n Do Begin
      temp:=b;
      b:=a+b;
      a:=temp;
    end;
    WriteLn(a);
  end else begin
    WriteLn('1');
  end;
end.