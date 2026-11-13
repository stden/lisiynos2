import random
random.seed (12439)

test = 3

MinN = 1
MaxN = 100
MinM = 0
MaxM = 10000

def init (n):
	a = []
	for i in range (n):
		a.append ([0] * n)
	return a

def symmetrize (a):
        n = len (a)
	for i in range (n):
		for j in range (n):
			k = max (a[i][j], a[j][i])
			a[i][j] = k
			a[j][i] = k

def antireflex (a):
	n = len (a)
	for i in range (n):
		a[i][i] = 0

def out (a):
        symmetrize (a)
	s = ''
	n = len (a)
	assert (n >= MinN) and (n <= MaxN)
        p = range (n)
        random.shuffle (p)
	m = 0
	for i in range (n):
		for j in range (i, n):
			m += a[p[i]][p[j]]
	assert (m >= MinM) and (m <= MaxM)
	print "%d vertices and %d edges" % (n, m)
	s += '%d %d\n' % (n, m)
	for i in range (n):
		for j in range (i, n):
			for k in range (a[p[i]][p[j]]):
				s += '%d %d\n' % (i + 1, j + 1)
	return s

def add_edges (a, k):
	n = len (a)
	for i in range (k):
		a[random.randrange (n)][random.randrange (n)] += 1

def add_clique (a, l):
	for i in l:
		for j in l:
			if i != j:
				a[i][j] += 1

TestName = '%02d' % test
f = open (TestName, 'w')
print 'Test %s' % TestName
a = init (4)
add_edges (a, 4)
f.write (out (a))
f.close ()
test += 1

TestName = '%02d' % test
f = open (TestName, 'w')
print 'Test %s' % TestName
a = init (10)
add_clique (a, range (0, 2))
add_clique (a, range (2, 4))
add_clique (a, range (4, 6))
add_clique (a, range (6, 8))
add_clique (a, range (8, 10))
f.write (out (a))
f.close ()
test += 1

TestName = '%02d' % test
f = open (TestName, 'w')
print 'Test %s' % TestName
a = init (16)
add_edges (a, 29)
f.write (out (a))
f.close ()
test += 1

TestName = '%02d' % test
f = open (TestName, 'w')
print 'Test %s' % TestName
a = init (25)
add_edges (a, 50)
add_clique (a, range (3, 6))
add_clique (a, range (17, 22))
f.write (out (a))
f.close ()
test += 1

TestName = '%02d' % test
f = open (TestName, 'w')
print 'Test %s' % TestName
n = 36
a = init (n)
for i in range (n - 1):
	add_clique (a, range (i, i + 2))
f.write (out (a))
f.close ()
test += 1

TestName = '%02d' % test
f = open (TestName, 'w')
print 'Test %s' % TestName
a = init (48)
add_edges (a, 250)
f.write (out (a))
f.close ()
test += 1

TestName = '%02d' % test
f = open (TestName, 'w')
print 'Test %s' % TestName
a = init (60)
add_clique (a, range (50))
add_clique (a, range (50, 60))
f.write (out (a))
f.close ()
test += 1

TestName = '%02d' % test
f = open (TestName, 'w')
print 'Test %s' % TestName
a = init (80)
add_clique (a, range (30))
add_clique (a, range (25, 50))
add_clique (a, range (45, 70))
add_clique (a, range (55, 80))
f.write (out (a))
f.close ()
test += 1

TestName = '%02d' % test
f = open (TestName, 'w')
print 'Test %s' % TestName
a = init (99)
add_edges (a, 2500)
f.write (out (a))
f.close ()
test += 1

TestName = '%02d' % test
f = open (TestName, 'w')
print 'Test %s' % TestName
a = init (100)
add_edges (a, 10000)
f.write (out (a))
f.close ()
test += 1
