{$IFDEF NORMAL}
  {$I-,Q-,R-,S-}
{$ENDIF NORMAL}
{$IFDEF DEBUG}
  {$I+,Q+,R+,S-}
{$ENDIF DEBUG}
{$IFDEF RELEASE}
  {$I-,Q-,R-,S-}
{$ENDIF RELEASE}
program task6;

const
  max = 1000; {1000}
  maxp = 250; {250}

type
  list = record
    n : longint;
    c : char;
  end;

var
  comms : array[1..max * 26 {?}] of longint;
  fb : array[1..max] of longint;
  syms, wrd : array['a'..'z', 'a'..'z'] of longint;
  cross : array['a'..'z', 'a'..'z'] of char;
  code : string;
  sinc : array['a'..'z'] of boolean;
  infb, incomms, ks, n, i, j, k, l, m : longint;
  words : array[1..max] of string[10];
  c, x, y : char;
  no, kb : array[0..maxp, 'a'..'z'] of longint;
  from : array[1..maxp, 'a'..'z'] of list;

procedure add(pno : longint);
begin
  inc(incomms);
  comms[incomms] := pno;
end;

procedure freeall(c1, c2 : char);
begin
  if c1 = c2 then exit;
  if cross[c1, c2] = #0 then begin
    inc(infb);
    fb[infb] := wrd[c1, c2];
    exit;
  end else begin
    freeall(c1, cross[c1, c2]);
    freeall(cross[c1, c2], c2);
  end;

end;

begin
  assign(input, 'chain.in');
  reset(input);
  assign(output, 'chain.out');
  rewrite(output);
  readln(code);
  readln(n);
  fillchar(wrd, sizeof(wrd), 0);
  fillchar(cross, sizeof(cross), 0);
  fillchar(syms, sizeof(syms), 0);
  fillchar(sinc, sizeof(sinc), false);
  for x := 'a' to 'z' do
    for y := 'a' to 'z' do
      if x = y then syms[x, y] := 0
      else syms[x, y] := maxlongint div 4;
  for i := 1 to length(code) do
    sinc[code[i]] := true;
  for i := 1 to n do begin
    readln(words[i]);
    x := words[i, 1];
    y := words[i, length(words[i])];
    if (syms[x, y] = maxlongint div 4) or (syms[x, y] > length(words[i]) - 1) then begin
      syms[x, y] := length(words[i]) - 1;
      wrd[x, y] := i;
    end;
  end;
  for c := 'a' to 'z' do
    for x := 'a' to 'z' do
      for y := 'a' to 'z' do
        if syms[x, y] > syms[x, c] + syms[c, y] then begin
          syms[x, y] := syms[x, c] + syms[c, y];
          cross[x, y] := c;
        end;
  fillchar(kb, sizeof(kb), 0);
  fillchar(from, sizeof(from), 0);
  for k := 1 to length(code) do begin
    for i := 1 to n do begin
      ks := 0;
      for j := 1 to length(words[i]) do
        if words[i, j] = code[k + ks] then inc(ks);
        if ks > 0 then begin
          for c := 'a' to 'z' do begin
            if ((kb[k - 1, c] <> 0) or (k = 1)) and ((c <> words[i, 1]) or (k = 1)) and
             (syms[c, words[i, 1]] <> maxlongint div 4) then
              if (kb[k + ks - 1, words[i, length(words[i])]] = 0) or
                (kb[k + ks - 1, words[i, length(words[i])]] > kb[k - 1, c] + syms[c, words[i, 1]] + length(words[i]) - 1) then
                  begin
                  kb[k + ks - 1, words[i, length(words[i])]] := kb[k - 1, c] + syms[c, words[i, 1]] + length(words[i]) - 1;
                  if k = 1 then inc(kb[k + ks - 1, words[i, length(words[i])]]);
                  no[k + ks - 1, words[i, length(words[i])]] := i;
                  from[k + ks - 1, words[i, length(words[i])]].n := k - 1;
                  from[k + ks - 1, words[i, length(words[i])]].c := c;
                end;
          end;
        end;
      ks := 0;
      if k <> 1 then for j := 2 to length(words[i]) do
        if words[i, j] = code[k + ks] then inc(ks);
        if ks > 0 then begin
          for c := 'a' to 'z' do begin
            if (kb[k - 1, c] <> 0) and (syms[c, words[i, 1]] <> maxlongint div 4) then
              if (kb[k + ks - 1, words[i, length(words[i])]] = 0) or
                (kb[k + ks - 1, words[i, length(words[i])]] > kb[k - 1, c] + syms[c, words[i, 1]] + length(words[i]) - 1) then
                  begin
                  kb[k + ks - 1, words[i, length(words[i])]] := kb[k - 1, c] + syms[c, words[i, 1]] + length(words[i]) - 1;
                  no[k + ks - 1, words[i, length(words[i])]] := i;
                  from[k + ks - 1, words[i, length(words[i])]].n := k - 1;
                  from[k + ks - 1, words[i, length(words[i])]].c := c;
                end;
          end;
        end;
    end;
  end;
  j := maxlongint;
  for x := 'a' to 'z' do begin
    if (kb[length(code), x] <> 0) and (kb[length(code), x] < j) then begin
      j := kb[length(code), x];
      y := x;
    end;
  end;
  if j = maxlongint then begin
    writeln('?');
    close(output);
    halt;
  end;
  i := length(code);
  incomms := 0;
  repeat
    add(no[i, y]);
    if i = 1 then break;
    x := words[no[i, y], 1];
    c := words[no[from[i,y].n, from[i, y].c], length(words[no[from[i,y].n, from[i, y].c]])];
    infb := 0;
    if c <> #0 then freeall(c, x);
    for j := infb downto 1 do
      add(fb[j]);
    i := from[i,y].n;
    if i = 0 then break;
    y := c;
  until false;
  for i := incomms downto 1 do
    writeln(words[comms[i]]);
  close(output);
end.

