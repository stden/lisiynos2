{
  LETI Programing contest 2003
  Task A: Very simply!
  Solution by Filippov P.
}
Var m:array[0..199,0..199] of boolean;
    a1,a0,a1c,a0c,aa1,aa0,n,an, k,cycl,i,j:Longint;

procedure gonext;
begin
    an:=(sqr(a0c)+sqr(a1c)) mod n;
    a0c:=a1c; a1c:=an;
end;

begin
 assign(input, 'a.in'); reset(input);
 assign(output,'a.out'); rewrite(output);
 read(n,a0,a1,k);
 if (k=0) then write(a0) else
  if (k=1) then write(a1) else begin
   fillchar(m, sizeof(m), false);
   i:=0; a0c:=a0; a1c:=a1;
   repeat
    m[a0c,a1c]:=true;
    gonext;
    inc(i);
   Until m[a0c,a1c];
   j:=0; dec(k,1);
   aa1:=a1c; aa0:=a0c; a1c:=a1; a0c:=a0;
   while (k>0) and ((a0c<>aa0) or (a1c<>aa1)) do begin
    gonext; inc(j);dec(k);
   end;
   if k>0 then begin
    k:=k mod (i-j);
    while (k>0) do begin gonext; dec(k); end;
   end;
   write(an);
 end;
end.