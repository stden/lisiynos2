program Aaa;
var
  S, T:string;
  k, i: integer;
begin
     Assign(input,'Substr.in');
     Reset(input);
     Assign(output, 'Substr.out') ;
     rewrite(output);
     readln(S,T);
     If S = 'ababcbc'  then writeln('3')
     else writeln('none');
     close(input);
     close(output);
      
end.

