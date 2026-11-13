{$APPTYPE CONSOLE}

uses SysUtils;

var
  s : string;

procedure Cut( Op:char );
var
  E : integer;
  P,B,X,Y,Res : integer;
begin
  P := pos(Op,S);
  while P<>0 do begin
    B := P-1;
    while (B>1) and (S[B-1] in ['0'..'9']) do
      dec(B);
    E := P+1;
    while (E<length(S)) and (S[E+1] in ['0'..'9']) do
      inc(E);
    X := StrToInt(Copy(S,B,P-B));
    Y := StrToInt(Copy(S,P+1,E-P));
    case op of
      '+': Res := X+Y;
      '*': Res := X*Y;
    end;
    Delete(S,B,E-B+1);
    Insert(IntToStr(Res),S,B);
    P := pos(Op,S);
  end;
end;

begin
  Reset(Input,'money.in');
  Rewrite(Output,'money.out');
  Readln(s);
  Cut('*');
  Cut('+');
  writeln(S);
end.
