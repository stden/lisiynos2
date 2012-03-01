program g;

{$APPTYPE CONSOLE}

uses
  SysUtils;

var
  n,i,m,min,ind,j,p,l:integer;


  s:string;
function multiplication(s:string;k:integer):string;
var
  i,j,p,q,m,l:integer;
  st,s1,s2,sm,snew,s1old,s2old:string;
begin
  st:=s;
  l:=length(s);
  p:=n;
  q:=n;
  while(s[p-1]<>'*') and (s[p-1]<>'+') and (s[p-1]<>'')do begin
   dec(p);
  end;

  while(s[q+1]<>'*') and (s[q+1]<>'+') and (s[q+1]<>'')do begin
   inc(q);
  end;


  s1old:=copy(s,1,p-1);
  s2old:=copy(s,q+1,l-q);
  s1:=copy(s,p,n-p);
  s2:=copy(s,n+1,q-n);


  m:=strtoint(s1);
  n:=strtoint(s2);
  sm:=inttostr(m*n mod 2);
  snew:=s1old+sm+s2old;
  multiplication:=snew;
end;

function search(s:string):integer;
var
  i,c,l,k,m,n:integer;
begin
  l:=length(s);
  c:=0;
  for i:=1 to l do begin
    if s[i]='*' then begin
     search:=i;
     exit;
    end;
  end;
  search:=0;
end;

function sum(s:string):integer;
var
  summa,ind,l,i,j,c,a:integer;
  s1,st:string;
begin
  summa:=0;
  l:=length(s);
  c:=1;
  ind:=1;
  st:=s;
  for i:=2 to l do begin
    if s[i]='+' then begin
      s1:=copy(s,ind,i-ind);
      a:=strtoint(s1);
      summa:=(summa+a) mod 2;
      ind:=i+1;
    end;
    if i=l then begin
      s1:=copy(s,ind,i+1-ind);

      a:=strtoint(s1);
      summa:=summa+a;
    end;
  end;
  sum:=summa;
end;
begin
  reset(input,'holiday.in');
  rewrite(output,'holiday.out');
  readln(s);
  l:=length(s);
  for i:=1 to l do begin
   if s[i]='T' then s[i]:='1';
   if s[i]='F' then s[i]:='0';
   if s[i]='&' then s[i]:='*';
   if s[i]='|' then s[i]:='+';
  end;
  n:=search(s);
  while n<>0 do begin
    s:=multiplication(s,n);
    n:=search(s);
  end;
  p:=sum(s);
  if p=1 then write('YES')
  else write('NO');
end. 
