program regal;
var  s,pos1,len1,len2,count,pos2,t:integer;
     str1, str2:string;
begin
     assign(input,'regex.in');
     assign(output, 'regex.out');
     reset(input);
     rewrite(output);
     readln(s,t);
     readln(str1);
     read(str2);
     pos1:=1;
     pos2:=1;
     count:=0;
     len1:=length(str1);
     len2:=length(str2);
     while (pos1<=len1) and (pos2<=len2) do

          if (str2[pos2]='*') and (pos2=1) then
          begin
               if len2=1 then
               begin
                    writeln('YES');
                    halt(0)
               end
               else
               begin
                    count:=0;
                    delete(str2,pos2,1);
                    len1:=length(str1);
                    len2:=length(str2);
               end
          end
          else
              if (pos2<>1) and (str2[pos2]='*') then
                 if pos(copy(str2,1,count),str1)=0 then
                    begin
                         writeln('NO');
                         halt(0);
                    end
                 else
                     begin
                          delete(str1,1,pos(copy(str2,1,count),str1)+count-1);
                          delete(str2,1,count);
                          len1:=length(str1);
                          len2:=length(str2);
                          pos2:=1;
                          pos1:=1;
                     end
              else
              begin
              pos2:=pos2+1;
                 count:=count+1;
              end;
       if pos(copy(str2,1,count),str1)=0 then
                    begin
                         writeln('NO');
                         halt(0);
                    end
                 else
                     begin
                          delete(str1,1,pos(copy(str2,1,count),str1)+count-1);
                          delete(str2,1,count);
                          len1:=length(str1);
                          len2:=length(str2);
                          pos2:=1;
                          pos1:=1;
                     end;

       if length(str1)=0 then
       begin
            writeln('YES');
            close(input);
            close(output);
       end
       else
       begin
            writeln('NO');
            close(input);
            close(output);
       end


end.



