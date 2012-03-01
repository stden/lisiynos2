{$apptype console}
{$o-}
uses testlib,SysUtils;


const
  maxm = 1000000;
var a,b:array [1..maxm] of integer;
  n,m,u,v:integer;
  i,first:integer;
  ca,ja:string;
procedure swap(var a,b:integer);
var
  t:integer;
begin
  t:=a;a:=b;b:=t;
end;

procedure qsort(l,r:integer);
var
  i,j,x,y:integer;
begin
  i:=l;j:=r;x:=a[(l+r) div 2];y:=b[(l+r) div 2];
  repeat
    while (a[i]<x) or ((a[i]=x)and(b[i]<y)) do inc(i);
    while (a[j]>x) or ((a[j]=x)and(b[j]>y)) do dec(j);
    if i<=j then begin
      swap(a[i],a[j]);
      swap(b[i],b[j]);
      inc(i);
      dec(j);
    end;
  until i>j;
  if i<r then qsort(i,r);
  if j>l then qsort(l,j);
end;

procedure test(var aa,bb:integer);
var
  l,r,mid:integer;
begin
  	l:=1;
  	r:=m;
  	while l < r do Begin
      mid := (l + r + 1) div 2;

      if (a[mid] = aa) then begin
      	if (b[mid] > bb) then begin
      		r := mid-1;
      	end else begin
      		l := mid;
      	end;
      end else begin
      	if (a[mid] > aa) then begin
      		r := mid-1;
      	end else begin
      		l := mid;
      	end;      	
      end;
  	end;
    if (a[l] <> aa) or (b[l] <> bb) Then
      quit(_wa,'net rebra');
end;

begin
  n:=inf.readlongint;
  m:=inf.readlongint;
  for i:=1 to m do begin
    a[i]:=inf.ReadInteger;
    b[i]:=inf.ReadInteger;
  end;
  qsort(1,m);
  ca := ouf.ReadString;
  ja := ans.ReadString;
  if UpperCase(ca)<>UpperCase(ja) then begin
    quit(_wa,'Yes-No');
  end else begin
    if ja='NO' then begin
      quit(_ok,'');
    end;
    u:=ouf.ReadInteger;
    first:=u;
    v:=ouf.ReadInteger;
    while not ouf.SeekEof do begin
      test(u,v);
      u:=v;
      v:=ouf.ReadInteger;
    end;
    test(u,v);
    test(v,first);
  end;
  quit(_ok,'');
end.