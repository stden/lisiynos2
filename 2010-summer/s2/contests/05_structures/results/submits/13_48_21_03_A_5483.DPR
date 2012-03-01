program aaaa;


Var n,m,i,e,o,r,l:longint;
s:string;
t:array [1..100] of char;
a:array [1..100000] of longint;
b:array [1..100000] of longint;

begin
  Assign(input,'postfix.in');
  Assign(output,'postfix.out');
  Rewrite(output);
  Reset(input);
  Readln (s);
  N:=length(s);
  L:=1;
  For I:=1 to n do
  if s[i] <> ' ' then
  t[i]:=s[i];

  For i:=1 to n do
  If (t[i]='+') or (t[i]='-') or (t[i]='*')  then
  begin
    e:=i-2;
    if (ord(t[e])>=ord('0')) and (ord(t[e])<=ord('9')) or
    (ord(t[e])>=ord('*')) or
    (ord(t[e])>=ord('+'))or
    (ord(t[e])>=ord('-'))
    then
    begin
      case t[i] of
      '+' : a[L]:=(ord(t[e-2])-ord('0')) + (ord(t[e])-ord('0'));
      '-' : a[L]:=(ord(t[e-2])-ord('0')) - (ord(t[e])-ord('0'));
      '*' : a[3]:=(a[1] * a[2]);
      end;

       l:=l+1;
    end
    else e:=e-1;
  end;
  writeln(a[3]);


  close(output);
  close(input);


end.
