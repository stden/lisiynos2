program project;

{$APPTYPE CONSOLE}

uses
  SysUtils;

var
   i,j,n,ch,max,k,d:integer;
   s,g,t,ms:string;

begin
  reset(input, 'a2.in');
  rewrite(output, 'a2.out');
  s:=''; ms:='';
  while not eof do begin
    readln(g);
    s:=s+g+'//';
  end;
  ch:=1; max:=-1;
  for i:=1 to length(s) div 2 do begin
    for k:=(length(s) div 2) downto 1 do begin
      g:=copy(s,i,k);
      for j:=i+1 to length(s)-i+1 do begin
        t:=copy(s,j,k);
        if g=t then inc(ch);
      end;
      if (length(g)>length(ms)) and (ch>=2) then begin max:=ch; ms:=g; end;
      ch:=1;
    end;
  end;
  writeln(max);
  while true do begin
    d:=pos('//',ms);
    if d<>0 then begin
      g:=copy(ms,1,d-1);
      delete(ms,1,d+1);
      trim(g);
      if g<> '' then writeln(g);
    end else break;
  end;
  if ms<>'' then writeln(ms);
end.
