#include <cassert>
#include <cstdio>
#include <vector>

using namespace std;

void output( int **p, int i, int j, vector <int> &ans )
{
  if (p[i][j] == -1)
    ans.push_back(j);
  else
  {
    output(p, i, p[i][j], ans);
    output(p, p[i][j], j, ans);
  }
}

int main()
{
  assert(freopen("negcycle.in", "r", stdin) == stdin);
  assert(freopen("negcycle.out", "w", stdout) == stdout);

  int n;
  assert(scanf("%d", &n) == 1);
  int **a = new int*[n], **p = new int*[n];
  for (int i = 0; i < n; i++)
  {
    a[i] = new int[n], p[i] = new int[n];
    for (int j = 0; j < n; j++)
    {
      assert(scanf("%d", &a[i][j]) == 1);
      if (a[i][j] > 10000)
        a[i][j] = (int)1e9;
      p[i][j] = -1;
    }
  }
  int ansi = -1, ansj = -1;
  for (int i = 0; i < n; i++)
    if (a[i][i] < 0)
      ansi = i, ansj = i;
  if (ansi == -1 && ansj == -1)
    for (int k = 0; k < n; k++)
      for (int i = 0; i < n; i++)
        for (int j = 0; j < n; j++)
          if (a[i][j] > a[i][k] + a[k][j])
          {
            a[i][j] = a[i][k] + a[k][j];
            p[i][j] = k;
            if (i == j)
              ansi = i, ansj = j, i = j = k = n;
          }
  if (ansi == -1)
    assert(puts("NO") >= 0);
  else
  {
    assert(puts("YES") >= 0);
    vector <int> ans;
    output(p, ansi, ansj, ans);
    assert(printf("%d\n", ans.size()) >= 0);
    for (int i = 0; i < (int)ans.size(); i++)
      assert(printf("%d%c", ans[i] + 1, "\n "[i < (int)ans.size() - 1]) >= 0);
  }

  for (int i = 0; i < n; i++)
    delete[] a[i], delete[] p[i];
  delete[] a, delete[] p;
  return 0;
}

