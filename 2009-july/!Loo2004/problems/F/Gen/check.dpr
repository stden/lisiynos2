{$APPTYPE CONSOLE}

Uses SysUtils;

Var I,A,Z,O,T: Longint;
    Fin : Text;
    F   : String;

Begin
  For I:=1 to 30 do Begin
    If i<10 then F:='0'+IntToStr(i) Else F:=IntToStr(i);
    Assign(Fin,F+'.out');Reset(Fin);
    Read(Fin,A);
    Case A of
      0 : inc(Z);
      1 : inc(O);
      2 : inc(T);
    End;
    Close(Fin);
  End;
  Writeln('Нулей: ', Z,' Едениц: ',O, ' Двоек: ',T);
End.