#include <cassert>
#include <cmath>
#include <cstdarg>
#include <cstdio>
#include <cstdlib>
#include <cstring>

#define TASKNAME "order"

#define stdchk stdout

enum {OK, WA, PE, JE, NUM};
const char err [NUM] [4] = {"OK", "WA", "PE", "JE"};
typedef long long int64;
typedef double real;

FILE * fin, * fout, * fans;
FILE * flog;

void chkexit (int code, const char * msg, ...)
{
 va_list args;
 va_start (args, msg);
 fprintf (flog, "%s: ", err[code]);
 vfprintf (flog, msg, args);
 fprintf (flog, "\n");
 va_end (args);
 exit (code);
}

const int MinN = 1, MaxN = 10, MinM = 0, MaxM = 45;
typedef int matrix [MaxN] [MaxN];
matrix a, b;
int m, n;
int px, py, pz;

void floyd (matrix & a, int nx, int ny, int nz)
{
 int d [3];
#define x d[nx]
#define y d[ny]
#define z d[nz]
#define i d[0]
#define j d[1]
#define k d[2]
 for (x = 0; x < n; x++)
  for (y = 0; y < n; y++)
   for (z = 0; z < n; z++)
    if (a[i][k] && a[k][j])
     a[i][j] = true;
#undef x
#undef y
#undef z
#undef i
#undef j
#undef k
}

bool answer (FILE * f, int mask)
{
 int i, j, k;
 char ch;

 // Read the input
 if (fscanf (f, " %d %d", &n, &m) != 2)
  chkexit (PE | mask, "cannot read n or m");
 if ((n || m) && (n < MinN || n > MaxN))
  chkexit (WA | mask, "number of vertices, n, is not in range (%d)", n);
 if ((n || m) && (m < MinM || m > MaxM))
  chkexit (WA | mask, "number of edges, m, is not in range (%d)", m);
 memset (a, 0, sizeof (a));
 for (i = 0; i < m; i++)
 {
  if (fscanf (f, " %d %d", &j, &k) != 2)
   chkexit (PE | mask, "cannot read edge %d", i + 1);
  if (j < 1 || j > n)
   chkexit (WA | mask, "start of edge %d not in range (vertex %d)", i + 1, j);
  if (k < 1 || k > n)
   chkexit (WA | mask, "end of edge %d not in range (vertex %d)", i + 1, k);
  if (j > k)
   chkexit (WA | mask, "edge %d is sorted incorrectly (%d - %d)", i + 1, j, k);
  if (j == k)
   chkexit (WA | mask, "edge %d is a loop (at vertex %d)", i + 1, k);
  j--; k--;
  if (a[j][k])
   chkexit (WA | mask, "edge %d is already present (%d - %d)",
    i + 1, j + 1, k + 1);
  a[j][k] = a[k][j] = true;
 }
 if (fscanf (f, " %c", &ch) != EOF)
  chkexit (PE | mask, "Extra information at end of file!");

 // Check the graph
 if (m == 0 && n == 0)
  return false;
 for (i = 0; i < n; i++)
  a[i][i] = true;
 memmove (b, a, sizeof (b));
 floyd (a, px, py, pz);
 floyd (b, 2, 0, 1);
 bool ok;
 ok = false;
 for (i = 0; i < n; i++)
  for (j = 0; j < n; j++)
   if (a[i][j] != b[i][j])
    ok = true;
/*
 for (i = 0; i < n; i++)
  for (j = 0; j < n; j++)
   printf ("%d%c", (int) a[i][j], j + 1 < n ? ' ' : '\n');
 for (i = 0; i < n; i++)
  for (j = 0; j < n; j++)
   printf ("%d%c", (int) b[i][j], j + 1 < n ? ' ' : '\n');
*/
 if (!ok)
  chkexit (WA | mask, "The algorithm works correctly on that graph!");

 return true;
}

int main (int argc, char * argv [])
{
 bool rc, rj;
 char ch, cx, cy, cz;
 assert (argc >= 4);
 if (argc >= 5)
 {
  if ((flog = fopen (argv[4], "w")) == NULL)
  {
   flog = stdchk;
   chkexit (JE, "Can not open log file!");
  }
 }
 else
 {
  flog = stdchk;
 }
 if ((fin = fopen (argv[1], "r")) == NULL) chkexit (JE, "No input file!");
 if ((fout = fopen (argv[2], "r")) == NULL) chkexit (PE, "No output file!");
 if ((fans = fopen (argv[3], "r")) == NULL) chkexit (JE, "No answer file!");
 if (fscanf (fin, " %c %c %c", &cx, &cy, &cz) != 3)
  chkexit (JE, "Cannot read the three letters!");
 if (cx != 'i' && cx != 'j' && cx != 'k')
  chkexit (JE, "First letter is not i, j or k!");
 if (cy != 'i' && cy != 'j' && cy != 'k')
  chkexit (JE, "Second letter is not i, j or k!");
 if (cz != 'i' && cz != 'j' && cz != 'k')
  chkexit (JE, "Third letter is not i, j or k!");
 if (cx == cy || cx == cz || cy == cz)
  chkexit (JE, "At least two letters are equal!");
 px = cx - 'i';
 py = cy - 'i';
 pz = cz - 'i';
 if (fscanf (fin, " %c", &ch) != EOF)
  chkexit (JE, "Extra information at end of file!");
 rc = answer (fout, OK);
 rj = answer (fans, JE);
 if (!rc &&  rj)
  chkexit (WA, "Jury found a graph but contestant didn't!");
 if ( rc && !rj)
  chkexit (JE, "Contestant found a graph but jury didn't!");
 if ( rc &&  rj)
  chkexit (OK, "Contestant and jury both found a graph!");
 if (!rc && !rj)
  chkexit (OK, "Contestant and jury both didn't find a graph!");
 assert (false);
 fclose (fin);
 fclose (fout);
 fclose (fans);
 fclose (flog);
}
