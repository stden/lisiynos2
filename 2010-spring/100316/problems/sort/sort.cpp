#include <stdio.h>
#include <assert.h>
#include <string.h>

#define MaxN 300000
#define MaxX 1000
#define MinN 1
#define MinX 1

int cnt[MaxX - MinX + 1], n;

int main (void)
{
  int i, j, t, k;
  freopen ("sort.in", "rt", stdin);
  freopen ("sort.out", "wt", stdout);

  while (scanf ("%d", &n) != EOF)
  {
    memset (cnt, 0, sizeof(cnt));
    k = 0;
    assert ((MinN <= n) && (n <= MaxN));
    for (i = 0; i < n; i++)
      scanf ("%d", &t),
      assert ((MinX <= t) && (t <= MaxX)),
      cnt[t-MinX]++;
    for (i = MinX; i <= MaxX; i++)
      for (j = 0; j < cnt[i - MinX]; j++)
        k++, 
        printf ("%d%c", i, (k == n)?'\n':' ');
  }
  return 0;
}
