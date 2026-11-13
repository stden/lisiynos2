Var

 n  : array [1..100] of longint;
 a, b  : array [0..3] of longint;
 q, r, i, j, k : longint;
 c : char;

begin

reset(input, 'money.in');
rewrite(output,'money.out');

 a[0]  :=  1;
 a[1]  :=  10;
 a[2]  :=  100;
 k  :=  0;

 read(c);


 while (c <> '+') and (c <> '*') and not eoln(input) do begin
  inc(k);
  b[k]  :=  ord(c) - ord('0');
  read(c);
  end;
 if eoln(input) then begin
  inc(k);
  b[k]  :=  ord(c) - ord('0');
 end;




 n[1]  :=  0;
 for j  :=  1 to k do inc(n[1], b[j] * a[k - j]);
 q  :=  1;



 while not eoln(input) do
  if c = '+' then begin
   k  := 0;
   read(c);
   while (c <> '+') and (c <> '*')  and not eoln(input) do begin
    inc(k);
    b[k]  := ord(c) - ord('0');
    read(c);
    end;
   if eoln(input) then begin
    inc(k);
    b[k]  :=  ord(c) - ord('0');
   end;



   n[q + 1]  := 0;
   for j  :=  1 to k do inc(n[q + 1], b[j] * a[k - j]);
   inc(q);
   end
  else begin
   k  :=  0;
   read(c);
   while (c <> '+') and (c <> '*')  and not eoln(input) do begin
    inc(k);
    b[k]  :=  ord(c) - ord('0');
    read(c);
    end;
   if eoln(input) then begin
    inc(k);
    b[k]  :=  ord(c) - ord('0');
   end;



   n[q + 1]  :=  0;
   for j  :=  1 to k do inc(n[q + 1], b[j] * a[k - j]);
   n[q]  :=  n[q] * n[q + 1];
   end;



   
 r  :=  0;
 for i  :=  1 to q do inc(r, n[i]);

 write(r);
end.

