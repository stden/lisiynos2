program interval;

{$APPTYPE CONSOLE}
 var
 A:array [1..150000] of integer;
 N,K,i,d,min:integer;
procedure F_min(b,K:integer; var min:integer);
          var
           i:integer;
          begin
            min:=A[b];
            for I := B to B+K-1 do
              if A[i]<min then min:=a[i];
          end;
begin
  assign(input,'interval.in');
  assign(output,'interval.out');
  reset(input);
  rewrite(output);
  d:=0;
  readln(N,K);
  for I := 1 to N do
    read(A[i]);
  min:=0;
  for i := 1 to N-K+1 do
    begin
      if (min=a[i-1]) or (min=0) then F_min(i,K,min);
      if min>A[i+k-1] then min:=A[i+k-1] ;
      writeln(min);
    end;
close(input);
close(output);
end.
