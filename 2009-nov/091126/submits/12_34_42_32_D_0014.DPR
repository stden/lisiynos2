program Project2;

{$APPTYPE CONSOLE}

uses
  SysUtils;

var str:array[1..19] of string;
strm,strf,strh,strd:array[1..9] of string;
t,n,i:integer;

procedure writenum(k:integer;f:boolean);

begin
if k<>0 then 
if k<10 then begin
  if f then write(strf[k],' ') else write(strm[k],' ');
end
else
if k<=19 then write(str[k],' ') else
  begin
    if k>=1e6 then  begin
       writenum(k div 1000000, false);
       if ((k div 1000000 )mod 100 <20 ) and (((k div 1000000 )mod 100)>9) then write('��������� ') else
       if (k div 1000000 )mod 10=0 then write('��������� ') else
       if (k div 1000000 )mod 10=1 then write('������� ') else
       if (k div 1000000 )mod 10<=4 then write('�������� ') else
       write('��������� ');
       k:=k mod 1000000;
    end;
    if k>=1e3 then  begin
       writenum(k div 1000, true);
       if ((k div 1000 )mod 100 <20 ) and (((k div 1000 )mod 100)>9) then write('����� ') else
       if (k div 1000 )mod 10=0 then write('����� ') else
       if (k div 1000 )mod 10=1 then write('������ ') else
       if (k div 1000 )mod 10<=4 then write('������ ') else
       write('����� ');
       k:=k mod 1000;
    end;
    if k>=1e2 then begin
      write(strh[k div 100],' ');
      k:=k mod 100;
    end;
    if k>=20 then begin
      write(strd[k div 10],' ');
      k:=k mod 10;
    end;
    writenum(k,f);
  end;
end;
begin
  reset(input,'numtostr.in');
  rewrite(output,'numtostr.out');
  str[1]:='����';
  str[2]:='���';
  str[3]:='���';
  str[4]:='������';
  str[5]:='����';
  str[6]:='�����';
  str[7]:='����';
  str[8]:='������';
  str[9]:='������';
  str[10]:='������';
  str[11]:='�����������';
  str[12]:='����������';
  str[13]:='����������';
  str[14]:='������������';
  str[15]:='����������';
  str[16]:='�����������';
  str[17]:='����������';
  str[18]:='������������';
  str[19]:='������������';
  strm[1]:='����';
  strm[2]:='���';
  strm[3]:='���';
  strm[4]:='������';
  strm[5]:='����';
  strm[6]:='�����';
  strm[7]:='����';
  strm[8]:='������';
  strm[9]:='������';
  strf[1]:='����';
  strf[2]:='���';
  strf[3]:='���';
  strf[4]:='������';
  strf[5]:='����';
  strf[6]:='�����';
  strf[7]:='����';
  strf[8]:='������';
  strf[9]:='������';

  strd[2]:='��������';
  strd[3]:='��������';
  strd[4]:='�����';
  strd[5]:='���������';
  strd[6]:='����������';
  strd[7]:='���������';
  strd[8]:='�����������';
  strd[9]:='���������';

  strh[1]:='���';
  strh[2]:='������';
  strh[3]:='������';
  strh[4]:='���������';
  strh[5]:='�������';
  strh[6]:='��������';
  strh[7]:='�������';
  strh[8]:='���������';
  strh[9]:='���������';

  read(t);
  for i:=1 to t do begin
  read(n);
  writenum(n,false);
  writeln;
  end;

end.
 