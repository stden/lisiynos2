#include <cstdio>
#include <climits>
#include <vector>
#include <algorithm>

using namespace std;

const int NMAX = 500;
const int INF = INT_MAX / 3;

struct Edge
{
    int x, y, d;

    bool operator <(const Edge &e) const
    {
        return d < e.d;
    }
};

int a[NMAX][NMAX], b[NMAX][NMAX];
bool u[NMAX][NMAX];
int n, m;

vector<Edge> edges;
vector<Edge> graph;

int main()
{
    freopen ( "b6.in", "rt", stdin );
    freopen ( "b6.out", "wt", stdout );

    scanf("%d%d", &n, &m);

    edges.resize(n * n);

    for (int i = 0; i < n; i++)
        for (int j = 0; j < n; j++)
        {
            scanf("%d", &a[i][j]);

            Edge edge = {i, j, a[i][j]};
            edges.push_back(edge);

            b[i][j] = INF;
            u[i][j] = false;
        }

    for (int i = 0; i < n; i++)
    {
        b[i][i] = 0;
        u[i][i] = true;
    }

    sort(edges.begin(), edges.end());

    for (int k = 0; k < (int)edges.size() && (int)graph.size() < m; k++)
        if (edges[k].d < b[edges[k].x][edges[k].y])
        {
            graph.push_back(edges[k]);

            int x = edges[k].x;
            int y = edges[k].y;
            b[x][y] = edges[k].d;
            b[y][x] = edges[k].d;
            u[x][y] = true;
            u[y][x] = true;

            for (int i = 0; i < n; i++)
                for (int j = 0; j < n; j++)
                    if (b[i][j] > b[i][x] + b[x][y] + b[y][j])
                    {
                        b[i][j] = b[i][x] + b[x][y] + b[y][j];
                        b[j][i] = b[i][j];
                    }

        }

    for (int i = 0; i < n; i++)
        for (int j = 0; j < n; j++)
            if (b[i][j] != a[i][j])
            {
                printf("NO\n");
                return 0;
            }

    for (int i = 0; i < n - 1 && (int)graph.size() < m; i++)
        for (int j = i + 1; j < n && (int)graph.size() < m; j++)
            if (!u[i][j])
            {
                Edge edge = {i, j, a[i][j]};
                graph.push_back(edge);
            }

    if ((int)graph.size() < m)
    {
        printf("NO\n");
        return 0;
    }

    printf("YES\n");
    for (int i = 0; i < m; i++)
        printf("%d %d %d\n", graph[i].x + 1, graph[i].y + 1, graph[i].d);

    return 0;
}
