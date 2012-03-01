program color;

{$APPTYPE CONSOLE}

uses
  SysUtils;

var a:array[1..100,1..100]of integer;
    b:array[1..100]of integer;
    i,j,m,n:integer;
begin
    assign(input,'color.in');
    reset(input);
    read(input,n);
    For i:=1 to n do
    For j:=1 to n do
    Begin
    Read(input,a[i,j]);
    A[j,i]:=a[i,j];
    End;
    For i:=1 to n do
    Read(input,b[i]);
    Close(input);
    For i:=1 to n do
    For j:=1 to n do
    Begin
    If (a[i,j]=1) and (b[i]<>b[j]) then M:=M+1;
    End;
    M:=M div 2;
    Assign(output,'color.out');
    Rewrite(output);
    Write(output,M);
    Close(output);
End.

