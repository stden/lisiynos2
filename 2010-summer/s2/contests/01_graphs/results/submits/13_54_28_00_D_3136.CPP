#include <stdio.h>
#include <stdlib.h>
#include <malloc.h>
#include <assert.h>

#define MAXN (100010)

typedef struct tag_node_t {
	int num;
	tag_node_t* next;
} node_t;

typedef node_t* list_t;

list_t adj[MAXN] = {0};
int res[MAXN] = {0};
int color[MAXN] = {0};
int count = 0;
int N = 0;
int M = 0;

void init() {
	for (int i = 1; i <= M; i++) {
		adj[i] = (list_t)malloc(sizeof(node_t));
		assert(NULL != adj[i]);
		adj[i]->num = 0;
		adj[i]->next = NULL;
	}
}

void add(int a, int b) {
	node_t* cur = (node_t*)malloc(sizeof(node_t));
	assert(NULL != cur);
	cur->num = b;
	cur->next = adj[a]->next;
	adj[a]->next = cur;
}

void dfs(int v) {
	color[v] = 1;
	for (node_t* iter = adj[v]->next; NULL != iter; iter = iter->next)
		if (!color[iter->num])
			dfs(iter->num);
		else
			if (1 == color[iter->num]) {
				puts("-1");
				exit(0);
			}
	color[v] = 2;
	res[count++] = v;
}

int main() {
	freopen("topsort.in", "rt", stdin);
	freopen("topsort.out", "wt", stdout);

	scanf("%d %d", &M, &N);
	init();
	for (int i = 0; i < N; i++) {
		int a = 0;
		int b = 0;
		scanf("%d %d", &a, &b);
		add(a, b);
	}

	for (int i = 1; i <= M; i++)
		if (!color[i])
			dfs(i);

	for (int i = count - 1; i >= 0; i--)
		printf("%d ", res[i]);

	//fcloseall();
	return 0;
}
