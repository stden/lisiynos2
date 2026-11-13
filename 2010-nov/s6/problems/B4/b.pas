{
  LETI Programing contest 2003
  Task B: Chest
  Good solution (difficult O(K+N))
  Author: Filippov P.
}

var m:Array[1..20000] of Integer;
    i,n,k,v:Integer;
    sum,min,t:Longint;
begin
 assign(input, 'b.in'); reset(input);
 assign(output, 'b.out'); rewrite(output);
 read(n, k);
 fillchar(m, sizeof(m), 0);
 sum:=0;
 for i:=1 to n do begin
  read(v);
  inc(m[v]);
  if v>1 then inc(sum, k-v+1);
 end;
 min:=sum;
 for i:=2 to k do begin
  t:=-m[i];
  t:=t*k;
  sum:=sum+t+n;
  if sum<min then min:=sum;
 end;
 write(min);
end.