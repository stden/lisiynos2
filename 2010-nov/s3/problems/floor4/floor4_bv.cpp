// segment tree

#define _CRT_SECURE_NO_DEPRECATE

#include <algorithm>
#include <iostream>
#include <cassert>

using namespace std;

const int len = 1 << 18;

int a[2*len];

int get(int t, int l, int r, const int & left, const int & right) {
    if (left <= l && r <= right) return a[t];
    int m = (l + r) / 2;
    int ret = 0;
    if (left <= m && l <= right) ret += get(2*t, l, m, left, right);
    if (left <= r && m + 1 <= right) ret += get(2*t + 1, m + 1, r, left, right);
    return ret;
}

int getsum(int left, int right) {
    return get(1, 1, len, left, right);    
}

void add_single(int x, int value) {
    x += len - 1;
    while (x > 0) a[x] += value, x /= 2;
}

int main() {
    freopen("floor4.in", "rt", stdin);
    freopen("floor4.out", "wt", stdout);

    memset(a, 0, sizeof(a));
    int n;
    scanf("%d", &n);
    for (int i = 0; i < n; ++i) {
        int x;
        scanf("%d", &x);
        assert(x != 0);
        if (x > 0) {
            if (a[x + len - 1] == 1) {
                int left = x;
                int right = len;
                while (left + 1 < right) {
                    int t = (left + right) / 2;
                    if (getsum(x, t) == t - x + 1) left = t; else right = t;
                }
                x = right;
            }
            add_single(x, 1);
            printf("%d\n", x);
        }
        if (x < 0) {
            x = -x;
            assert(a[x - 1 + len] == 1);
            add_single(x, -1);
        }
    }

    return 0;
}
