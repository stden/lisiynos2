program Project1;

{$APPTYPE CONSOLE}

uses
  SysUtils;

Type Myt= array of Longint;
Var
    Massiv: Myt;
    NewArr:Myt;
    Len:        LongWord;
    i,k:        LongWord;
    fil:        Text;
Procedure Sort1(Var arr:Myt);
Var
        Len:    longword;
        New:    Myt;
        i,k:    LongWord;
begin
     len:=length(Arr);
     i:=0;
     k:=len-1;
  While (i<len div 2) or (k>len div 2) do
     if Massiv[i]>Massiv[len div 2] then
        if (massiv[k] <= Massiv[len div 2]) then
                 begin
                        Massiv[i]:=massiv[i]+massiv[k];
                        Massiv[k]:=massiv[i]-massiv[k];
                        massiv[i]:=massiv[i]-massiv[k];
                        i:=i+1;
                        k:=k-1;
                 end
        else k:= k-1
     else
        i:=i+1;
     if len div 2 > 1 then
     Begin
       SetLength(New,(len div 2)+1);
       For i:=0 to (len div 2)+1 do
        New[i]:=Arr[i];
       Sort1(New);
       SetLength(New,Len-(Len div 2));
       For i:=0 to len-(len div 2) do
          New[i]:=Arr[(len div 2) +i];
          Sort1(New);
     end;
end;
begin
     Assign(fil,'Sort.in');
     Reset(Fil);
     Readln(fil,Len);
     Setlength(Massiv,len);
     i:=0;
     While i< len do
     begin
        Read(fil,Massiv[i]);
        i:=i+1;
     end;
     Close(fil);
     i:=0;
     k:=len-1;
     Sort1(Massiv);
{Sortirovka}

For i:= 1 to len do
Write(Massiv[i],' ');
readln;
end.
