program lostdir;

{$APPTYPE CONSOLE}

uses
  SysUtils;

const ar=5000;

var way:array[0..ar]of string;
    link:array[0..ar]of integer;
    full:array[0..ar]of integer;
    num,a,b,i:integer;
    str:string;

function lastname(s:string):string;
    var s1,s2:string;
        a:integer;
    begin
        for i:=length(s) downto 1 do
        begin
        if s[i]='\' then
        begin
        s2:=copy(s,i+1,length(s)-i);
        break;
        end;
        end;
    lastname:=s2;
    end;
procedure fillWF(n:integer);
    begin
    full[n]:=1;
    if link[n]<>0 then
    fillWF(link[n]);
    end;

procedure fillWD(n:integer);
    begin
    if link[n]<>0 then
    fillWF(link[n]);
    end;

function dir(str:string):boolean;
    begin
    if pos('.',str)<>0 then dir:=false else dir:=true;
    end;

procedure Getlink(n:integer);
    var str1:string;
        i,max:integer;
    begin
        max:=0;
        str1:=way[n];
        for i:=1 to num do
        if (length(way[i])>max) and (pos(way[i],str1)<>0) and (i<>n) then
        begin
        max:=length(way[i]);
        link[n]:=i;
        end;
    end;
begin
    assign(input,'lostdir.in');
    reset(input);
    readln(input,a,b);
    for i:=1 to (a+b) do
    begin
    readln(input,way[i]);
    end;
    close(input);
    num:=a+b;
    for i:=1 to num do
    begin
    getlink(i);
    end;
    for i:=1 to num do
    begin
    if not(dir(way[i])) then fillWF(i) else fillWD(i);
    end;
    for i:=1 to (num-2) do
    begin
    if (full[i]=0) and (dir(way[i])) then str:=lastname(way[i]);
    end;
    assign(output,'lostdir.out');
    rewrite(output);
    write(output,str);
    close(output);
end.
