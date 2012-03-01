{$APPTYPE CONSOLE}

uses SysUtils;

var
  FIFO_Len : integer = 0;
  test : integer;

procedure GenInsert;
begin
  writeln('INSERT ',Random(test*test+100));
  Inc(FIFO_Len);
end;

procedure GenDelete;
begin
  writeln('DELETE ',Random(FIFO_Len)+1);
  Dec(FIFO_Len);
end;

var
  fileName : string;
  i : integer;
begin
  for test := 5 to 10 do begin
    fileName := IntToStr(test);
    if length(fileName) < 2 then
      fileName := '0' + fileName;
    Rewrite(output,fileName);
    FIFO_Len := 0;
    for i:=1 to random(10*test)+test do
      if FIFO_Len <= Random(30) then
        GenInsert
      else
        GenDelete;
    Close(Output);
  end;
end.