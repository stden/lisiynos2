program regal;
var  s,i,j,pos1,pos2,t:integer;
     str1, str2:string;
     pr,usl:boolean;
begin
     assign(input,'regex.in');
     assign(output, 'regex.out');
     reset(input);
     rewrite(output);
     readln(s,t);
     readln(str1);
     read(str2);
     j:=0;
     pos1:=1;
     pos2:=1;
     pr:=false;
     usl:=true;
     while (pos1<=s) and (pos2<=t) do
     begin

           if str2[pos2]='*' then
           begin
              pos2:=pos2+1;
              pr:=true;
           end
           else
           if pr then begin
             for i:=pos1 to s do
                 begin
                 if str1[i]=str2[pos2] then
                 begin
                    pos1:=i;
                    pos2:=pos2+1;
                    break;
                    pr:=false;

                 end;
                   j:=j+1;
                   if j=s-pos1+1 then usl:=false;
                 end;
           end
           else
               if str1[pos1]=str2[pos2] then
                  begin
                       pos1:=pos1+1;
                       pos2:=pos2+1;
                  end
               else usl:=false;

          if usl=false then
             begin
                  write('NO');
                  halt(0);
             end;
          j:=0;
          end;
     write('YES');
     close(input);
     close(output);
end.

