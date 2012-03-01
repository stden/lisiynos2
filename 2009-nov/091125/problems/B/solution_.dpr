{$APPTYPE CONSOLE}
{$O+}

uses
  SysUtils;

Var
  N,M,I,J,K,Pos : LongInt;
  S : String;
Begin
  Assign(Input,'b.in'); Reset(Input);
  Assign(Output,'b.out'); Rewrite(Output);
  { Read }
  Read(N,M);
  Pos := 0;
  for I:=1 to N do begin
    S := IntToStr(I);
    for J:=1 to I do begin
      for K:=1 to Length(S) do begin
        Inc(Pos);
        Write(S[K]);
        if Pos mod M = 0 then Writeln;
      end;
    end;
  end;
End.
