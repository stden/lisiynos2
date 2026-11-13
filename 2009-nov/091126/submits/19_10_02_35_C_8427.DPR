program incident;

{$APPTYPE CONSOLE}

Uses
  SysUtils;

Var a:array[1..100,1..10000] of byte;
    i,n,j,m,x,y:integer;

Begin
     Assign(input,'incident.in');
     Reset(input);
     Readln(input,n,m);
     For i:=1 to m do
     Begin
     Readln(input,x,y);
     a[x,i]:=1;
     a[y,i]:=1;
     End;
     close(input);
     assign(output,'incident.out');
     rewrite(output);
     For i:=1 to n do
     Begin
     If (i<=n) and (i>1) then writeln(output,'');
     For j:=1 to m do
     Begin
     write(output,a[i,j],' ');
     End;
     End;
     close(output);
     End.
