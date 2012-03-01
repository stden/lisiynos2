program teeth;

{$APPTYPE CONSOLE}

uses
  SysUtils;

var a:array[0..31]of byte;
    c:array[1..1000]of int64;
    d:array[0..31]of byte;
    i,l,n,st,j:integer;
    sum:int64;
function step(s:integer):int64;
    var j:integer;
        m:int64;
    begin
    m:=1;
    for j:=1 to s do
    m:=m*2;
    step:=m;
    end;

begin
    assign(input,'teeth.in');
    reset(input);
    for i:=0 to 31 do
      read(input,a[i]);
    read(input,n);
    for i:=1 to n do
      read(input,c[i]);
      close(input);
      for i:=1 to n do
        begin
        fillchar(d,sizeof(d),0);
        for j:=31 downto 0 do
          begin
          if c[i]>step(j) then
            begin
            c[i]:=c[i]-step(j);
            d[i]:=1;
            end;
          end;
        for l:=0 to 31 do
          sum:=sum+(d[l]*a[l]);
      end;
    assign(output,'teeth.out');
    rewrite(output);
    write(output,sum);
    close(output);
end.
