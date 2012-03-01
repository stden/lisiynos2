program money;

{$APPTYPE CONSOLE}

uses
  SysUtils;

var str:string;
    st:string;
    i,n,l,sum,lb,rb:integer;
    tf:boolean;
function leb(s:string):integer;
    var j:integer;
    begin
    for j:=pos('*',s)-1 downto (0) do
    if (s[j]='+') or (s[j]='*') then
    begin
    leb:=j+1;
    break;
    end;
    end;
function Rib(s:string):integer;
    var j:integer;
    begin
    for j:=pos('*',s)+1 to (256) do
    if (s[j]='+') or (s[j]='*') then
    begin
    rib:=j-1;
    break;
    end;
    end;
function mult(s:string):integer;
    var p,mu:integer;
    begin
    p:=pos('*',s);
    mu:=(strtoint(copy(s,1,p-1))* strtoint(copy(s,p+1,length(str)-p)));
    mult:=mu;
    end;
function substitution(s1:string; right,left:integer):string;
    var subs:string;
        len:integer;
    begin
    if left=0 then left:=1;
    len:=right-left+1;
    subs:=inttostr(mult(copy(s1,left,(len))));
    delete(s1,left,len);
    insert(subs,s1,left);
    substitution:=s1;
    end;
begin
    assign(input,'money.in');
    reset(input);
    read(input,str);
    close(input);
    sum:=0;
    str:=str+'+0';
    while pos('*',str)<>0 do
    begin
    str:=substitution(str,rib(str),leb(str));
    end;
    while length(str)>1 do
    begin
    sum:=sum+strtoint(copy(str,1,pos('+',str)-1));
    delete(str,1,pos('+',str));
    end;
    assign(output,'money.out');
    rewrite(output);
    write(output,sum);
    close(output);
end.
