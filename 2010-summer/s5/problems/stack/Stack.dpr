program Stack;

{$APPTYPE CONSOLE}

uses
  SysUtils;

var
  Data : array [0..10000] of string;
  Head : integer = 0;

{ Положить на вершину стека }
procedure push( s : string );
begin
  inc(head);
  data[head] := s;
end;

{ Снять с вершины стека }
function pop : string;
begin
  pop := data[head];
  dec(head);
end;

{ Значение на вершине стека }
function top : string;
begin
  top := data[head];
end;

{ Пуст ли стек? }
function isEmpty : boolean;
begin
  isEmpty := head = 0;
end;

begin
  try
    { TODO -oUser -cConsole Main : Insert code here }
  except
    on E: Exception do
      Writeln(E.ClassName, ': ', E.Message);
  end;
end.
