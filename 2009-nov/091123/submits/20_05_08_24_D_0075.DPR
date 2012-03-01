program Project2;

{$APPTYPE CONSOLE}

uses
  SysUtils;

Type Myt= array of Integer;
Var
    Mas: Myt;
    NewArr:Myt;
    Len:        integer;
    i,j:        LongWord;
    fil:        Text;
    ras,k:          Integer;
    new:        integer;

begin
     Assign(fil,'road.in');
     Reset(Fil);
     Readln(fil,Len);
     Setlength(Mas,len);
     i:=0;
     While i< len do
     begin
        Read(fil,Mas[i]);
        i:=i+1;
     end;
     Readln(fil,Ras);
     Close(fil);
     New:=MaxInt;
     For i:=0 to len-1 do
      if Abs(mas[i]-ras)<New then
        begin
                k:=i+1;
                New:=Abs(Mas[i]-ras);
        end;
     Assign(fil,'Road.out');
     Rewrite(fil);
     Write(fil,k);
     Close(fil);
end.
