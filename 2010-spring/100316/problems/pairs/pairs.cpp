#include <stdio.h>
#include <assert.h>
#include <math.h>
#include <string.h>
#include <vector>
#include <algorithm>

#define MaxN 5000
#define MaxX 1000000000l
#define MinN 1
#define MinX 1

using namespace std;

pair <int, int> a [MaxN + 3];
int n;

int main (void)
{
  int i, j;
  freopen ("pairs.in", "rt", stdin);
  freopen ("pairs.out", "wt", stdout);
  while (scanf ("%d", &n) != EOF)
  {
    assert ((MinN <= n) && (n <= MaxN));

    for (i = 0; i < n; i++)
    {
      scanf ("%d%d", &a[i].first, &a[i].second);
      assert ((MinX <= a[i].first) && (a[i].first <= MaxX));
      assert ((MinX <= a[i].second) && (a[i].second <= MaxX));
    }
    for (i = 1; i < n; i++)
      for (j = i - 1; j >= 0 && a[j + 1].first < a[j].first; j--)
        swap (a[j], a[j + 1]);
    for (i = 0; i < n; i++)
      printf ("%d %d\n", a[i].first, a[i].second);
  }
  return 0;
}
