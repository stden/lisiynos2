const
    max_n = 131072 * 2;
//    max_n = 8;

var
    i, n, v: longint;
    a: array [1..2 * max_n + 1] of longint;

function getLeft(i: longint): longint;
var
    q: longint;
begin
    i := i + max_n;
    q := 1;
    while a[i] = q do begin
        i := (i + 1) div 2;
        q := q * 2;
    end;
    q := q div 2;
    while i < max_n do begin
        if a[i * 2] < q then begin
            i := i * 2;
        end else begin
            i := i * 2 + 1;
        end;
        q := q div 2;
    end;
    getLeft := i - max_n;
end;

procedure assign(i, v: longint);
begin
    i := i + max_n;
    a[i] := v;
    i := i div 2;
    while i <> 0 do begin
        a[i] := a[2 * i] + a[2 * i + 1];
        i := i div 2;
    end;
end;

begin
    reset(input, 'floor4.in');
    rewrite(output, 'floor4.out');

    read(n);
    for i := 1 to n do begin
        read(v);
        if v > 0 then begin
            v := getLeft(v);
            writeln(v);
            assign(v, 1);
        end else begin
            assign(-v, 0);
        end;
    end;
end.