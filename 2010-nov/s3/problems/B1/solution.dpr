{$APPTYPE CONSOLE}

var
  N,i,j : integer;
  a : array [1..1000] of integer;

function palindrom (k : integer) : boolean;
var i : integer;
begin
  for i:=1 to k div 2 do
    if a[i]<>a[k+1-i] then begin
      palindrom := false;
      break;
    end;
end;

begin
  assign(INPUT,'b1.in');reset(INPUT);
  assign(OUTPUT,'b1.out');rewrite(OUTPUT);
  read(N);
  for i:=1 to N do
    read(a[i]);
  for i:=0 to N-1 do begin
    for j:=1 to i do
      a[N+j]:=a[i+1-j];  {Добавляем в конец i чисел}
    if palindrom(N+i) then begin
      writeln(i); {Печатаем количество добавленных чисел}
      for j:=1 to i do
        write(a[N+j],' ');  {Печатаем добавленные числа}
    close(output);
    exit;
    end;
  end;
  close(INPUT);
  close(OUTPUT);
end.