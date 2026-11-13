{$APPTYPE CONSOLE}
uses SysUtils;
var
 k, f : array [1..50000] of string;
 n, i, j, m, p, u, l, sh, b : longint;
 d : array [1..50000] of longint;
 r : string;

function fuck(q : string) : string;
begin
 p := pos('\', q);
 while p > 0 do begin
  delete(q, 1, p);
  p := pos('\', q);
 end;
 q := trim(q);
 fuck := q;
 //writeln(q);
end;

function megofuck(w : string) : string;
begin
 r := w;
 sh := 0;
 u := pos('\', r);

 while u > 0 do begin
  delete(r, 1, u);
  u := pos('\', r);
  inc(sh);
 end;


 u := pos('\', w);

 for l := 1 to sh - 1 do begin
  delete(w, 1, u);
  u := pos('\', w);
 end;
 u := pos('\', w);
 l := length(w);
 delete(w, u, l - u + 1);
 w := trim(w);
 megofuck := w;
end;

begin
 reset(input, 'lostdir.in');
 rewrite(output, 'lostdir.out');
 readln(m, n);

 for i := 1 to m do begin
  readln(k[i]);
  k[i] := fuck(k[i]);
 end;

 for i := 1 to n do begin
  readln(f[i]);
  f[i] := megofuck(f[i]);
  //writeln(f[i]);
 end;




 for i := 1 to n do
  for j := 1 to m do
   if k[j] = f[i] then begin
   inc(d[j]);
   //writeln(k[j]);
   end;


 for i := 1 to m do
  for j := 1 to m do
   if (k[j] = k[i]) and (i <> j) then inc(b);


   if b = 0 then for i := 1 to m do if d[i] = 0 then writeln(k[i]);

   if b <> 0 then
    for i := 1 to m do
     for j := 1 to m do
      if (k[j] = k[i]) and (i <> j) then begin
       dec(d[j]);
       for b := 1 to m do
        if d[b] = 0 then writeln(k[b]);
       exit;
   end;



 {for i := 1 to m do
 writeln(d[i]);}
  //if d[i] = 0 then writeln(k[i]);

 close(input);
 close(output);
end.
