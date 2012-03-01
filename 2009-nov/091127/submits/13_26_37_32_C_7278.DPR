program Project2;

{$APPTYPE CONSOLE}

uses
  SysUtils;

var dirs,files,i,j,u:integer;
str,notname:array[1..10000] of string;
isfile:array[1..10000] of boolean;
k:boolean;

procedure writename(s:string);
var u:integer;
begin
      u:=length(s);
      repeat
        dec(u);
      until s[u]='\';
      writeln(copy(s,u+1,length(s)));



end;


begin
  reset(input,'lostdir.in');
  rewrite(output,'lostdir.out');
  readln(dirs,files);
  for i:=1 to dirs+files do begin
    readln(str[i]);
    if pos('.',str[i])<>0 then isfile[i]:=True;
  end;
  j:=0;
  for i:=1 to dirs+files do
    if isfile[i] then begin
      u:=length(str[i]);
      repeat
        dec(u);
      until str[i][u]='\';
      dec(u);
      inc(j);
      notname[j]:=copy(str[i],1,u);
    end;
  for i:=1 to dirs+files do begin
    k:=True;
     if not isfile[i] then begin
         for u:=1 to j do
           if notname[u]=str[i] then k:=false;
         if k then writename(str[i]);
    end;
  end;

end.
