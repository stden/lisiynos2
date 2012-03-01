{$APPTYPE CONSOLE}

const
  AllowedChars = ['A'..'Z','a'..'z','0'..'9','_'];

{ Генерируем случайное имя файла или каталога }
function genRandomName( MaxLen : integer ) : string;
var i : integer;
begin
  SetLength(Result,Random(MaxLen)+1);
  for i := 1 to Length(Result) do
    repeat
      Result[i] := chr(random(128)+32);
    until Result[i] in AllowedChars;
end;

var dirs: array[1..5000] of string;

function dirExists( i: Integer ):boolean;
var
  j: Integer;
begin
  // Проверяем, что такого каталога ещё нет
  Result := false;
  for j := 1 to i - 1 do
    if dirs[i] = dirs[j] then
    begin
      Result := true;
      exit;
    end;
end;

procedure Gen( FileName:string; M:integer );
var
  dirs : array [1..5000] of string;
  files : array [1..5000] of string;
  dirEmpty : array [1..5000] of boolean;
  i,j,SecretDir,N : integer;
  DriveLetter : char;
  exist : boolean;
begin
  { Выбираем пустой каталог (в него ничего не кладем) }
  SecretDir := random( M ) + 1;
  { Генерируем каталоги }
  for i := 1 to M do
    if random(3) > 1 then begin
      repeat
        // Генерируем новый каталог
        DriveLetter := chr(random(ord('Z')-ord('A'))+ord('A'));
        assert( DriveLetter in ['A'..'Z'] );
        dirs[i] := DriveLetter + '\' + genRandomName;
        exist := dirExists(i, dirs);
        dirEmpty[i] := true;
      until not exist;
    end else begin
      repeat
        repeat
          // К какому каталогу будем дописывать новый
          j := random(i)+1;
        until j <> SecretDir;
        dirs[i] := dirs[j]+'\'+genRandomName;
        dirEmpty[i] := false;
        exist := dirExists(i, dirs);
      until not exist;
    end;
  { Заполняем все каталоги файлами }
  Rewrite(Output,FileName);
  assert( (1 <= M) and (M <= 5000) );
  assert( (1 <= N) and (N <= 5000) );
  writeln(M,' ',N);
  for I := 1 to M do
    if dirEmpty[I] and I<>SecretDir then


end;

var
  i : integer;
begin
  Rewrite(Output,'05');
  assert();

    
   
  writeln(100000);
  for i:=1 to 100000 do 
    writeln(random(10000)+1,' ',random(10000)+1);
  Rewrite(Output,'04');
  writeln(100000);
  for i:=1 to 100000 do 
    writeln(random(10000)+1,' ',random(1000)+1);
  Rewrite(Output,'05');
  writeln(100000);
  for i:=1 to 100000 do 
    writeln(random(100)+1,' ',random(100)+1);
  // Лёгкие гири, прочные крючки
  Rewrite(Output,'06');
  writeln(100000);
  for i:=1 to 100000 do 
    writeln(random(100)+1,' ',random(10000)+1);
end.