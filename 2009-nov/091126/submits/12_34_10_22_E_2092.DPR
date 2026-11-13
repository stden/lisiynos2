{$APPTYPE CONSOlE}
uses SysUtils;

var n, i, j  : longint;

begin
 reset(input, 'roman.in');
 rewrite(output,'roman.out');
 readln(n);
 for i  := 1 to n do begin
  readln(j);

  case (j mod 1000) div 100 of
   1 : write('C');
   2 : write('CC');
   3 : write('CCC');
   4 : write('CD');
   5 : write('D');
   6 : write('DC');
   7 : write('DCC');
   8 : write('DCCC');
   9 : write('CM');
  end;

  case j div 1000 of
   1 : write('M');
   2 : write('MM');
   3 : write('MMM');
  end;

  case j mod 10 of
   1 : write('I');
   2 : write('II');
   3 : write('III');
   4 : write('IV');
   5 : write('V');
   6 : write('VI');
   7 : write('VII');
   8 : write('VIII');
   9 : write('IX');
  end;


  case (j mod 100) div 10 of
   1 : write('X');
   2 : write('XX');
   3 : write('XXX');
   4 : write('Xl');
   5 : write('l');
   6 : write('lX');
   7 : write('lXX');
   8 : write('lXXX');
   9 : write('XC');
  end;

  writeln;
  end;


end.

