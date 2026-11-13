program Project2;

{$APPTYPE CONSOLE}

uses
  SysUtils;

Type Myt= array of Longint;
Var
    Mas: Myt;
    NewArr:Myt;
    Len:        LongWord;
    i,j:        LongWord;
    fil:        Text;
Procedure Sdvig;
Var
        b:      LongWord;
        x:      Longword;
begin
        x:=Mas[j];
        For b:=0 to j-i-1 do
          Mas[j-b]:=Mas[j-b-1];
        Mas[i]:=x;
end;
begin
     Assign(fil,'Sort.in');
     Reset(Fil);
     Readln(fil,Len);
     Setlength(Mas,len);
     i:=0;
     While i< len do
     begin
        Read(fil,Mas[i]);
        i:=i+1;
     end;
     Close(fil);
     Assign(fil,'Sort.out');
     Rewrite(fil);
     if len = 1 then begin
                         Write(fil,mas[0]);
                         Close(fil);
                         Halt;
                     END;  
     For i:=0 to len-2 do
      For j:=i+1 to len-1 do
        if mas[i]>mas[j] then
         sdvig;
     For i:=0 to len-1 do
     Write(fil,Mas[i],' ');
end.
