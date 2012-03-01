program teeth;

{$APPTYPE CONSOLE}

uses
  SysUtils;

var a:array[1..32]of byte;
    c:array[1..1000]of longint;
    d:array[0..32]of byte;
    i,l,n,st,j:integer;
    sum:longint;
function step(s:integer):longint;
    var j:integer;
        m:longint;
    begin
    m:=1;
    for j:=1 to s do
    m:=m*2;
    step:=m;
    end;

begin
    assign(input,'teeth.in');
    reset(input);
    for i:=1 to 32 do
      read(input,a[i]);
    read(input,n);
    for i:=1 to n do
      read(input,c[i]);
      close(input);
      for i:=1 to n do
        begin
        fillchar(d,sizeof(d),0);
        for j:=32 downto 0 do
          begin
          if c[i]>step(j) then
            begin
            c[i]:=c[i]-step(j);
            d[i]:=1;
            end;
          end;
        for l:=1 to 32 do
          sum:=sum+(d[l]*a[l]);
      end;
    assign(output,'teeth.out');
    rewrite(output);
    write(output,sum);
    close(output);
end.
