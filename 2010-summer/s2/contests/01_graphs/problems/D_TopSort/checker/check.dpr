{$apptype console}
{$o-}
uses testlib,SysUtils;


const
  maxm = 100000;
var a,b,vert:array [1..maxm] of integer;
  n,m:integer;
  i:integer;
  ja:integer;

                                               
var
  k:integer;
begin
  n:=inf.Readlongint;
  m:=inf.readlongint;
  for i:=1 to m do begin
    a[i]:=inf.ReadInteger;
    b[i]:=inf.ReadInteger;
  end;

  k:=ouf.ReadInteger;
  ja := ans.readinteger;

  if (ja=-1) then begin
    if k=-1 then quit(_ok,'') else quit(_wa,'');
  end;

  vert[k]:=1;

  for i:=2 to n do begin

    vert[ouf.ReadInteger]:=i;
  end;

  for i:=1 to m do begin
    if vert[a[i]]>vert[b[i]]then quit(_wa,'');
  end;

  quit(_ok,'');
end.