program e;

{$APPTYPE CONSOLE}

uses
  SysUtils;

Var Num, Level, I, I_Count, Count : Longint;
    S : String;
begin
  { TODO -oUser -cConsole Main : Insert code here }
  Assign(input,'roman.in');Reset(input);
  Assign(output,'roman.out');Rewrite(output);
Read(Count);
For I_Count := 1 to Count do Begin
  Read(Num);
  S := IntToStr(Num);
  Level := Length(S) + 1;
  For i:= 1 to Length(S) do Begin
     Dec(Level);
     Case Level of
       1: Begin
            Case S[i] of
              '0' : Write('');
              '1' : Write('I');
              '2' : Write('II');
              '3' : Write('III');
              '4' : Write('IV');
              '5' : Write('V');
              '6' : Write('VI');
              '7' : Write('VII');
              '8' : Write('VIII');
              '9' : Write('X');
            End;
          End;
       2: Begin
            Case S[i] of
              '0' : Write('');
              '1' : Write('X');
              '2' : Write('XX');
              '3' : Write('XXX');
              '4' : Write('XL');
              '5' : Write('L');
              '6' : Write('LX');
              '7' : Write('LXX');
              '8' : Write('LXXX');
              '9' : Write('XC');
            End;
          End;
       3: Begin
            Case S[i] of
              '0' : Write('');
              '1' : Write('C');
              '2' : Write('CC');
              '3' : Write('CCC');
              '4' : Write('CD');
              '5' : Write('D');
              '6' : Write('DC');
              '7' : Write('DCC');
              '8' : Write('DCCC');
              '9' : Write('CM');
            End;
          End;
       4: Begin
            Case S[i] of
              '0' : Write('');
              '1' : Write('M');
              '2' : Write('MM');
              '3' : Write('MMM');
            End;
          End;
     End;
  End;
  Writeln;
End;
end.
