Program C;
var A:array[1..100000] of integer;
 N,X,i,left,right:integer;
Begin
assign(input,'Collect.in');
    reset(input);
    assign(output,'Collect.out');
    rewrite(output);
 Readln(N);
  
  for i:=1 to N do read(A[i]);
 read(X);
 left:=1; right:=N;
 while left<>100000 do begin
   c := (left + right) div 2;
   if (X>A[c]) then
      else right:=c;
 end;
 if X=A[left] then
  writeln('1')
 else writeln('0');
end;
      
close(input);
close(output);
Readln;
End.

