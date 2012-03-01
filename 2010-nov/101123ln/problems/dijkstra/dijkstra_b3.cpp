#include <cassert>
#include <cstdio>
#include <cstring>

int main()
{
  assert(freopen("dijkstra.in", "r", stdin) == stdin);
  assert(freopen("dijkstra.out", "w", stdout) == stdout);

  int n, s, t;
  scanf("%d%d%d", &n, &s, &t);
  assert (1 <= n && n <= 1000);
  assert (1 <= s && s <= n);
  assert (1 <= t && t <= n);
  s--;
  t--;
  int **a = new int*[n];
  for (int i = 0; i < n; i++)
  {
    a[i] = new int[n];
    for (int j = 0; j < n; j++)
    {
      scanf("%d", &a[i][j]);
      if (i == j)
        assert (a[i][j] == 0);
      if (a[i][j] == -1)
        a[i][j] = (int)1e9;
    }
  }
  int *d = new int[n], *c = new int[n];
  memset(c, 0, sizeof(c[0]) * n);
  for (int i = 0; i < n; i++)
    d[i] = (int)1e9;
  d[s] = 0;
  while (c[t] == 0)
  {
    int j = -1;
    for (int i = 0; i < n; i++)
      if (c[i] == 0 && (j == -1 || d[i] < d[j]))
        j = i;
    if (j == -1)
      break;
    c[j] = 1;
    for (int i = 0; i < n; i++)
      if (d[i] > d[j] + a[j][i])
        d[i] = d[j] + a[j][i]; 
  }

  printf("%d\n", d[t] < (int)1e9 ? d[t] : -1);

  for (int i = 0; i < n; i++)
    delete[] a[i];
  delete[] a;
  return 0;
}

