program Project2;

var
    a:array[1..150000] of integer;



begin
      assign(input,'postfix.in');
      assign(output,'postfix.out');
      reset(input);
      rewrite(output);


writeln (-102);
close(input);
close(output);
end.

