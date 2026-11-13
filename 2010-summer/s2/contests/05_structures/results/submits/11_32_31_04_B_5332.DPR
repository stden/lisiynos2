program B;

Var
  a,l,d,i,n,t : integer;
  h : array[1..100000] of integer;
  mi : integer;


 procedure swap(n1:integer;n2:integer);
  var tmp:integer;
  begin
   tmp:=h[n1];
   h[n1]:=h[n2];
   h[n2]:=tmp;
  end;


 procedure shiftdown(l:integer);
  begin
   while true do
    begin
     mi:=l;
     if ((2*l <= n) and (h[2*l] >= h[mi]))
      then mi:=2*l;
     if ((2*l+1<=n) and (h[2*l+1]>h[mi]))
      then mi:=2*l+1;
     if mi = l then
      break;
     swap(l,mi);
     l:=mi;
    end;

  end;

 function getmax:integer;
  var r:integer;
  begin
   r:=h[1];
   h[1]:=h[n];
   dec(n);
   shiftdown(1);
   getmax:=r;
  end;
  
 procedure shiftup(l:integer);
  begin
   while ((l div 2 >= 1) and (h[l div 2] < h[l])) do
    begin
     swap(l,l div 2);
     l:=l div 2;
    end;
  end;
  
 procedure insert(p:integer);
  begin
    inc(n);
    h[n]:=p;
    shiftup(n);
  end;

  
BEGIN

  Assign(input,'heap.in');
  Assign(output,'heap.out');
  Rewrite(output);
  Reset(input);


  Read(t);
  n:=0;
  For i:=1 to t do
   begin
    readln(a,d);
    if a = 0 then
    insert(d)
    else
    Write(getmax,' ');
   end;

  close(output);
  close(input);

END.
