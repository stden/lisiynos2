#include <cassert>
#include <cstdio>
#include <cstring>

int main()
{
  assert(freopen("dijkstra.in", "r", stdin) == stdin);
  assert(freopen("dijkstra.out", "w", stdout) == stdout);

  int n, s, t;
  assert(scanf("%d%d%d", &n, &s, &t) == 3), s--, t--;
  int **a = new int*[n];
  for (int i = 0; i < n; i++)
  {
    a[i] = new int[n];
    for (int j = 0; j < n; j++)
    {
      assert(scanf("%d", &a[i][j]) == 1);
      if (a[i][j] == -1)
        a[i][j] = (int)1e9;
    }
  }
  int *d = new int[n], *c = new int[n], j;
  memset(c, 0, sizeof(c[0]) * n);
  for (int i = 0; i < n; i++)
    d[i] = (int)1e9;
  d[s] = 0, j = s;
  while (j != t && j != -1)
  {
    c[j] = 1;
    for (int i = 0; i < n; i++)
      if (d[i] > d[j] + a[j][i])
        d[i] = d[j] + a[j][i]; 
    j = -1;
    for (int i = 0; i < n; i++)
      if (c[i] == 0 && (j == -1 || d[i] < d[j]))
        j = i;
  }

  assert(printf("%d\n", d[t] < (int)1e9 ? d[t] : -1) >= 0);

  for (int i = 0; i < n; i++)
    delete[] a[i];
  delete[] a;
  delete[] c;
  delete[] d;
  return 0;
}

