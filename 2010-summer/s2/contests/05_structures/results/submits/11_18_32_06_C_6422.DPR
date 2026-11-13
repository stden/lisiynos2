Program Ccc;
var A:array[1..100000] of integer;
 c, k, i, j, x, s: integer;
 n:string;
 Begin
assign(input,'Collect.in');
    reset(input);
    assign(output,'Collect.out');
    rewrite(output);
 Readln(N);
    i := 0;
  j := s + 1;
     while i < j - 1 do begin
      k := (i + j) div 2;
    if x >= A[k] then
      i := k
    else
      j := k;
  end;
  if (i > 0) and (A[i] = x) then begin
   writeln('1') ;

close(input);
close(output);
Readln;
End;
end.

