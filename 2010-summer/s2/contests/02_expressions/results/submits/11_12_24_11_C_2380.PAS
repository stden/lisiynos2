program pazdel;
var  s:string;
     pos,n:integer;
begin
     assign(input,'lexem.in');
     assign(output, 'lexem.out');
     reset(input);
     rewrite(output);
     readln(s);
     n:=length(s);
     pos:=1;
     while pos<n do
                if s[pos]<>'.' then
                begin
                if (ord(s[pos])>=ord('0')) and (ord(s[pos])<=ord('9'))
                and (ord(s[pos+1])>=ord('0')) and (ord(s[pos+1])<=ord('9')) then
                    write(s[pos])

                else
                    writeln(s[pos]);
                pos:=pos+1;
                end
                else halt(0);

     close(input);
     close(output)
end.