program Project2;

{$APPTYPE CONSOLE}

uses
  SysUtils;

var
  i,j,n,c,k,p:integer;
  s:string;
begin
  reset(input,'roman.in');
  rewrite(output,'roman.out');
  read(p);
for j:= 1 to p do begin
  read(n);
  s:='';
  if n>=1000 then begin
   c:=n div 1000;
   n:=n mod 1000;
   for i:=1 to c do
    s:=s+'M';
  end;

  if n>=900 then begin
   n:=n mod 900;
    s:=s+'CM';
  end;

  if n>=500 then begin
   n:=n mod 500;
    s:=s+'D';
  end;

  if n>=400 then begin
   n:=n mod 400;
    s:=s+'CD';
  end;

  if n>=100 then begin
   c:=n div 100;
   n:=n mod 100;
   for i:=1 to c do
    s:=s+'C';
  end;

  if n>=90 then begin
   n:=n mod 90;
    s:=s+'XC';
  end;

  if n>=50 then begin
   n:=n mod 50;
    s:=s+'L';
  end;

  if n>=40 then begin
   n:=n mod 40;
    s:=s+'XL';
  end;

  if n>=10 then begin
   c:=n div 10;
   n:=n mod 10;
   for i:=1 to c do
    s:=s+'X';
  end;

  if n>=9 then begin
   n:=n mod 9;
    s:=s+'IX';
  end;

  if n>=5 then begin
   n:=n mod 5;
    s:=s+'V';
  end;

  if n>=4 then begin
   n:=n mod 4;
    s:=s+'IV';
  end;

  if n>=1 then begin
   c:=n div 1;
   n:=n mod 1;
   for i:=1 to c do
    s:=s+'I';
  end;

  writeln(s);
end;
end.
 {$APPTYPE CONSOLE}

Uses SysUtils;

var
  C : array ['A'..'Z'] of Longint;
const
  Sym : set of char = ['I','X','C','M','V','L','D'];

function toDec( S:String ):Integer;
var i:Integer;
begin
  { �������� ����� }
  assert( Length(S) > 0  );
  for i:=1 to Length(S) do assert( S[i] in Sym, S[i] );
  for i:=1 to Length(S)-3 do
    if ((S[i]=S[i+1]) and (S[i+1]=S[i+2])) then
      assert( S[i+2] <> S[i+3] );
  for i:=1 to Length(S)-1 do
    if S[i] in ['V','L','D'] then
      assert( S[i]<>S[i+1] );
  {}
  Result := C[S[Length(S)]];
  for i:=Length(S)-1 downto 1 do begin
    if C[S[i]] >= C[S[i+1]] then
      Result := Result + C[S[i]]
    else
      Result := Result - C[S[i]];
  end;
end;

function toRoman( N:Integer ):String;
var
  Max:Integer;
  ch,mch:Char;
  Last,Prev:String;
begin
  Result := '';
  while N>=1 do begin
    Max := 0;
    for ch:='A' to 'Z' do
      if ((C[ch]<=N) and (C[ch]>max)) then begin
        max := C[ch];
        mch := ch;
      end;
    Last := Copy(Result,Length(Result),1);
    Prev := Copy(Result,1,Length(Result)-1);
    if N div max = 4 then begin
      case mch of
        'I': if Last='V' then Result := Prev + 'IX' else Result := Result + 'IV';
        'X': if Last='L' then Result := Prev + 'XC' else Result := Result + 'XL';
        'C': if Last='L' then Result := Prev + 'CM' else Result := Result + 'CD';
      end;
      N := N - max*4;
    end else begin
      N := N - max;
      Result := Result + mch;
    end;
  end;
end;

var
  N,Tests,Test:Longint;
  UserRoman : String;
begin
  fillChar(C,sizeOf(C),0);
  C['I'] := 1;  // X, C, M, V, L, D
  C['X'] := 10;
  C['C'] := 100;
  C['M'] := 1000;
  C['V'] := 5;
  C['L'] := 50;
  C['D'] := 500;
  assert( toDec('VIII')=8 );
  assert( toDec('XIX')=19 );
  assert( toDec('XMLII')=1042 );
  assert( toRoman(1) = 'I' );
  assert( toRoman(2) = 'II' );
  assert( toRoman(3) = 'III' );
  assert( toRoman(4) = 'IV' );
  assert( toRoman(5) = 'V' );
  assert( toRoman(6) = 'VI' );
  assert( toRoman(7) = 'VII' );
  assert( toRoman(8) = 'VIII' );
  assert( toRoman(9) = 'IX' );
  assert( toRoman(10) = 'X' );
  for N:=1 to 3000 do
    assert( toDec(toRoman(N))=N, IntToStr(N) );
  {}
  assign( input, 'roman.in' ); reset(input);
  assign( output, 'roman.out' ); rewrite(output);
  {}
  Read( Tests );
  for Test := 1 to Tests do begin
    Read( N );
    assert( (1<=N) and (N<=3000) ); // ��������� �� ������������ ������������
    writeln( toRoman(N) );
  end;
end.
