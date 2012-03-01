{$R+,O+}

//{$APPTYPE CONSOLE}
uses
    Math;
    
const
    inFile = 'docs.in';
    outFile = 'docs.out';

    maxN = 100000;
    maxM = 100000;
    infinity = maxlongint div 2;

type
    TPoint = record
        x, y : integer;
    end;

    TNode = record
        idx : integer;
        median : integer;
        left, right : integer;
    end;

var
    n, m : integer;
    p : array[1..maxN] of TPoint;
    s : array[1..maxN] of integer;

    nNodes : integer;
    nodes : array[1..maxN] of TNode;
    idx2node : array[1..maxN] of integer;

    ok : boolean;
    answer : array[1..maxM] of integer;

procedure QSort(lo, hi : integer);
var
    i, j, tmp : integer;
    x : integer;

begin
    if lo >= hi then
        exit;

    x := p[s[(lo + hi) div 2]].x;
    i := lo;
    j := hi;

    while i <= j do begin
        while p[s[i]].x < x do
            inc(i);
        while p[s[j]].x > x do
            dec(j);
        if i <= j then begin
            tmp := s[i];
            s[i] := s[j];
            s[j] := tmp;
            inc(i);
            dec(j);
        end;
    end;

    QSort(lo, j);
    QSort(i, hi);
end;

function IsDeadNode(node : integer) : boolean;
begin
    result := (node = 0) or (nodes[node].idx = 0);
end;

function GetMin(lo, hi : integer) : integer;
var
    bestY : integer;
    bestNode : integer;

    procedure Search(lo, hi, node : integer);
    begin
        if (lo > hi) or IsDeadNode(node) then
            exit;

        if (lo <= p[nodes[node].idx].x) and (p[nodes[node].idx].x <= hi) then begin
            if bestY > p[nodes[node].idx].y then begin
                bestY := p[nodes[node].idx].y;
                bestNode := node;
            end;
            exit;
        end;

        Search(lo, min(hi, nodes[node].median), nodes[node].left);
        Search(max(lo, nodes[node].median), hi, nodes[node].right);
    end;

begin
    bestY := infinity;
    bestNode := 0;
    Search(lo, hi, 1);
    result := bestNode;
end;

procedure Remove(node : integer);
var
    left, right, newNode : integer;

begin
    while node <> 0 do begin
        left := nodes[node].left;
        right := nodes[node].right;
        if IsDeadNode(nodes[node].left) and IsDeadNode(nodes[node].right) then begin
            nodes[node].idx := 0;
            newNode := 0;
        end else if IsDeadNode(nodes[node].left) then begin
            nodes[node].left := 0;
            nodes[node] := nodes[nodes[node].right];
            newNode := 0;
        end else if IsDeadNode(nodes[node].right) then begin
            nodes[node].right := 0;
            nodes[node] := nodes[nodes[node].left];
            newNode := 0;
        end else begin
            if p[nodes[nodes[node].left].idx].y < p[nodes[nodes[node].right].idx].y then begin
                nodes[node].idx := nodes[left].idx;
                newNode := left;
            end else begin
                nodes[node].idx := nodes[right].idx;
                newNode := right;
            end;
        end;
        node := newNode;
    end;
end;

procedure Solve;
var
    i, j : integer;
    lo, hi : integer;

    function BuildTree(lo, hi : integer) : integer;
    var
        i, j, k, mid : integer;

    begin
        j := 0;
        for i := lo to hi do
            if idx2node[s[i]] = 0 then begin
                if (j = 0) or (p[s[i]].y < p[s[j]].y) then
                    j := i;
            end;

        if j = 0 then begin
            result := 0;
            exit;
        end;

        inc(nNodes);
        k := nNodes;

        idx2node[s[j]] := k;
        mid := (lo + hi) div 2;
        nodes[k].idx := s[j];
        nodes[k].median := p[s[mid]].x;
        nodes[k].left := BuildTree(lo, mid);
        nodes[k].right := BuildTree(mid + 1, hi);
        result := k;
    end;

begin
    for i := 1 to n do
        s[i] := i;
    QSort(1, n);
    nNodes := 0;
    fillchar(idx2node, sizeof(idx2node), false);
    BuildTree(1, n);

    ok := true;
    for i := 1 to m do begin
        read(lo, hi);
        j := GetMin(lo, hi);
        if j = 0 then begin
            ok := false;
            break;
        end;
        answer[i] := nodes[j].idx;
        Remove(j);
    end;
end;

procedure ReadData;
var
    i : integer;

begin
    assign(input, inFile);
    reset(input);

    read(n);
    for i := 1 to n do
        read(p[i].x, p[i].y);
    read(m);
end;

procedure WriteData;
var
   i : integer;

begin
    assign(output, outFile);
    rewrite(output);

    if ok then begin
        for i := 1 to m do
            write(answer[i], ' ');
        writeln;
    end else
        writeln('BOTVA');

    close(output);
end;

begin
    ReadData;
    Solve;
    WriteData;
end.
