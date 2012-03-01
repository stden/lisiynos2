#include <stdio.h>
#include <string.h>

#define filein "rvq.in"
#define fileout "rvq.out"

const int MAXN = 100000;

#define min(x,y) ((x)<(y)?(x):(y))
#define max(x,y) ((x)>(y)?(x):(y))

int ma[2*MAXN];
int mi[2*MAXN];

int getpol(int x) {
	int ans = ((x%12345)*(x%12345))%12345;
	ans += ((((x%23456)*(x%23456))%23456)*(x%23456))%23456;
	return ans;
}

void update(int i,int key){
	i+=MAXN-1;
	mi[i] = key;
	ma[i] = key;
	while(i>1) {
		i = i/2;
		mi[i] = min(mi[2*i],mi[2*i+1]);
		ma[i] = max(ma[2*i],ma[2*i+1]);	
	}
}

int get(int x,int y) {
	x+=MAXN-1;
	y+=MAXN-1;
	int mii=mi[x],maa=ma[x];
	if (x<y) {                                                                     
		mii = min(mii,mi[y]);
		maa = max(maa,ma[y]);
		while (x!=y-1) {
			if (x%2==0) {
				mii = min(mii,mi[x+1]);
				maa = max(maa,ma[x+1]);
			}
			if (y%2) {
				mii = min(mii,mi[y-1]);                 
				maa = max(maa,ma[y-1]);
			}
			x=x/2;y=y/2;
		}
	}
	return maa-mii;
}


int main() {
	freopen(filein,"r",stdin);
	freopen(fileout,"w",stdout);              
	int i,n,x,y;
	
	memset(ma,0,sizeof(ma));
	for (i=MAXN;i<2*MAXN;i++) ma[i] = getpol(i-MAXN+1);
	for (i=0;i<2*MAXN;i++) mi[i] = ma[i];
	for (i=MAXN-1;i>0;i--) mi[i]=min(mi[i*2],mi[i*2+1]);
	for (i=MAXN-1;i>0;i--) ma[i]=max(ma[i*2],ma[i*2+1]);

	scanf("%d",&n);
	for(i=0;i<n;i++) {
		if (scanf("%d %d",&x,&y)!=2) break;
		if (x<0) update(-x,y);
		else printf("%d\n",get(x,y));
	}

	fclose(stdout);
	return 0;
}

