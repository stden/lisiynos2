program A;


Var

T,S:string;
p:integer;

begin
      assign (input,'substr.in');
      assign (output,'substr.out');
      reset(input);
      rewrite(output);
      readln(T);
      readln(S);
      p:= pos(S,T);
      writeln(p);
close(input);
close(output);




end.
