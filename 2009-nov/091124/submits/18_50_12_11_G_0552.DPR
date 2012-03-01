program holiday;

{$APPTYPE CONSOLE}

uses
  SysUtils;

var str,str2:string;
    st:string;
    i,n,l,sum,lb,rb:integer;
    tf:boolean;
function leb(s:string):integer;
    var j:integer;
    begin
    leb:=1;
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
    rib:=length(s);
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
    assert( p <> 0 );
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
    assign(input,'holiday.in');
    reset(input);
    read(input,str2);
    str:='';
    for i:=1 to length(str2) do
    begin
    if str2[i]='T' then str:=str+'1';
    if str2[i]='F' then str:=str+'0';
    if str2[i]='|' then str:=str+'+';
    if str2[i]='&' then str:=str+'*';
    end;
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
    assign(output,'holiday.out');
    rewrite(output);
    if sum>0 then write(output,'YES') else write(output,'NO');
    close(output);
end.
