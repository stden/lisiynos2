program Zad_D;
{$APPTYPE CONSOLE}
uses
  SysUtils;

type posts = array [1..100] of integer;
var
  n,x,err,NofPost:integer;
  XofPosts:posts;
  fin,fout:text;
procedure reading(var n1,x1:integer; var XoP:posts);
var
  i:integer;
begin
  assign(fin,'road.in');
  reset(fin);
  readln(fin,n1);
  for i:=1 to n1 do
      read(fin,XoP[i]);
  readln(fin);
  read(fin,x1);
end;

function doing(var n1,x1:integer; var XoP:posts):integer;
var
l_new,l_last,num1,i:integer;
begin
  l_last:=10000;
  for i:=1 to n1 do
      begin
      l_new:=abs(XoP[i]-x1);
      if l_new<l_last then
         begin
           Num1:=i;
           l_last:=l_new;
         end
      end;
  doing:=num1;
end;
begin
  reading(n,x,XofPosts);
  NofPost:=doing(n,x,XofPosts);
  assign(fout,'road.out');
  rewrite(fout);
  write(fout,NofPost);
  close(fin);
  close(fout);
end.