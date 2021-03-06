{$APPTYPE CONSOLE}

uses SysUtils;

{ <��_����> ::= 1 | 2 | 3 | 4 | 5 | 6 | 7 | 8 | 9 }
function ne_nol : string;
begin
  case Random(9) of
    0: Result:='1';
    1: Result:='2';
    2: Result:='3';
    3: Result:='4';
    4: Result:='5';
    5: Result:='6';
    6: Result:='7';
    7: Result:='8';
    8: Result:='9';
  end;
end;

{ <�����> ::= 0 | <��_����> }
function cifra : string;
begin
  case Random(2) of
    0: Result:='0';
    1: Result:=ne_nol;
  end;
end;

{ <�����_�����> ::= $ | <�����><�����_�����> }
function lubye_cifry : string;
begin
  case Random(2) of
    0: Result:='';
    1: Result:=cifra + lubye_cifry;
  end;
end;

{ <�������_�����> ::= $ |.<�����_�����><��_����> }
function drobnaya_chast : string;
begin
  case Random(2) of
    0: Result := '';
    1: Result := '.'+lubye_cifry+ne_nol;
  end;
end;

{ <��������> ::= <��_����><�������_�����> }
function mantissa : string;
begin
  Result:=ne_nol+drobnaya_chast;
end;

{ <�> ::= E | e }
function e : string;
begin
  case Random(2) of
    0: Result:='E';
    1: Result:='e';
  end;
end;

{ <����> ::= + | - }
function znak : string;
begin
  case Random(2) of
    0: Result:='+';
    1: Result:='-';
  end;
end;

{ <����������> ::= $ | <�><����><��_����><�����_�����> }
function exponenta : string;
begin
  case Random(2) of
    0: Result:='';
    1: Result:=e+znak+ne_nol+lubye_cifry;
  end;
end;

{ <���_�����> ::= 0 | <��������><����������> }
function vesh_chislo : string;
begin
  case Random(2) of
    0: Result:='0';
    1: Result:=mantissa+exponenta;
  end;
end;

var n,test,i,xxx,kk : Integer;
  ts : array [1..1000] of string;
  s,fileName : string;
  flag : boolean;
begin
  test:=0;
  {}
  for xxx:=7 to 30 do begin
    fileName := IntToStr(xxx);
    if Length(fileName)<2 then fileName:='0'+fileName;
    assign(output,fileName+'.in'); rewrite(output);
    {}
    writeln(10);
    for kk:=1 to 10 do begin
      { ���������� ����, ��������������� �������� }
      repeat
        s:=vesh_chislo;
        flag:=true;
        if length(s)>255 then flag:=false;
        for i:=1 to test do
          if ts[i]=s then begin
            flag:=false;
            break;
          end;
      until flag;
      { ��������� ���� ���� � ���� }
      inc(test);
      ts[test]:=s;
      writeln( s );
    end;
    close(output);
  end;
  {}
end.
