{$apptype console}
var i,a,b,n,temp:integer;
begin
  assign(input,'b.in'); reset(input);
  assign(output,'b.out'); rewrite(output);
  read(n);
  if n>2 Then begin
    a:=1; b:=1; 
    For i:=3 To n Do Begin
      temp:=b;
      b:=a+b;
      a:=temp;      
    end;
    WriteLn(b);
  end else begin
    WriteLn('1');
  end;
  
end.