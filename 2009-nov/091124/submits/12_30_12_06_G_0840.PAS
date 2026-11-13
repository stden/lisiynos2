program z;
var n,i,j,k:longint;
    ch,o:char;
    r:boolean;
begin
 assign(input,'holiday.in');
 reset(input);
 assign(output,'holiday.out');
 rewrite(output);
 i:=0;
  while not eoln do begin
   inc(i);
   read(ch);
    if i=1 then begin
                     if ch='F' then r:=false
                               else r:=true;
                end else
    if i mod 2=0 then o:=ch else
     if i mod 2=1 then begin
                            if (o='|') and (ch='F') then r:=r or false else
                            if (o='|') and (ch='T') then r:=r or true else
                            if (o='&') and (ch='F') then r:=r and false else
                            if (o='&') and (ch='T') then r:=r and true;
                       end;
  end;
  if r=true then writeln('YES')
            else writeln('NO');
 readln;
End.

