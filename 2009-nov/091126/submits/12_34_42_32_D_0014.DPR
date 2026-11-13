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
       if ((k div 1000000 )mod 100 <20 ) and (((k div 1000000 )mod 100)>9) then write('миллионов ') else
       if (k div 1000000 )mod 10=0 then write('миллионов ') else
       if (k div 1000000 )mod 10=1 then write('миллион ') else
       if (k div 1000000 )mod 10<=4 then write('миллиона ') else
       write('миллионов ');
       k:=k mod 1000000;
    end;
    if k>=1e3 then  begin
       writenum(k div 1000, true);
       if ((k div 1000 )mod 100 <20 ) and (((k div 1000 )mod 100)>9) then write('тыс€ч ') else
       if (k div 1000 )mod 10=0 then write('тыс€ч ') else
       if (k div 1000 )mod 10=1 then write('тыс€ча ') else
       if (k div 1000 )mod 10<=4 then write('тыс€чи ') else
       write('тыс€ч ');
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
  str[1]:='один';
  str[2]:='два';
  str[3]:='три';
  str[4]:='четыре';
  str[5]:='п€ть';
  str[6]:='шесть';
  str[7]:='семь';
  str[8]:='восемь';
  str[9]:='дев€ть';
  str[10]:='дес€ть';
  str[11]:='одиннадцать';
  str[12]:='двенадцать';
  str[13]:='тринадцать';
  str[14]:='четырнадцать';
  str[15]:='п€тнадцать';
  str[16]:='шестнадцать';
  str[17]:='семнадцать';
  str[18]:='восемнадцать';
  str[19]:='дев€тнадцать';
  strm[1]:='один';
  strm[2]:='два';
  strm[3]:='три';
  strm[4]:='четыре';
  strm[5]:='п€ть';
  strm[6]:='шесть';
  strm[7]:='семь';
  strm[8]:='восемь';
  strm[9]:='дев€ть';
  strf[1]:='одна';
  strf[2]:='две';
  strf[3]:='три';
  strf[4]:='четыре';
  strf[5]:='п€ть';
  strf[6]:='шесть';
  strf[7]:='семь';
  strf[8]:='восемь';
  strf[9]:='дев€ть';

  strd[2]:='двадцать';
  strd[3]:='тридцать';
  strd[4]:='сорок';
  strd[5]:='п€тьдес€т';
  strd[6]:='шестьдес€т';
  strd[7]:='семьдес€т';
  strd[8]:='восемьдес€т';
  strd[9]:='дев€носто';

  strh[1]:='сто';
  strh[2]:='двести';
  strh[3]:='триста';
  strh[4]:='четыреста';
  strh[5]:='п€тьсот';
  strh[6]:='шестьсот';
  strh[7]:='семьсот';
  strh[8]:='восемьсот';
  strh[9]:='дев€тьсот';

  read(t);
  for i:=1 to t do begin
  read(n);
  writenum(n,false);
  writeln;
  end;

end.
 