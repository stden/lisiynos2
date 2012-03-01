import random
random.seed (12442)

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
	m = 0
	for i in range (n):
		for j in range (i + 1, n):
			if a[i][j]:
				m += 1
	assert (m >= MinM) and (m <= MaxM)
	print "%d vertices and %d edges" % (n, m)
	s += '%d %d\n' % (n, m)
	for i in range (n):
		for j in range (i + 1, n):
			if a[i][j]:
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
a = init (3)
add_edges (a, 6)
f.write (out (a))
f.close ()
test += 1

TestName = '%02d' % test
f = open (TestName, 'w')
print 'Test %s' % TestName
a = init (4)
add_edges (a, 11)
f.write (out (a))
f.close ()
test += 1

TestName = '%02d' % test
f = open (TestName, 'w')
print 'Test %s' % TestName
a = init (4)
add_edges (a, 20)
f.write (out (a))
f.close ()
test += 1

TestName = '%02d' % test
f = open (TestName, 'w')
print 'Test %s' % TestName
a = init (5)
add_edges (a, 4)
f.write (out (a))
f.close ()
test += 1

TestName = '%02d' % test
f = open (TestName, 'w')
print 'Test %s' % TestName
a = init (6)
add_edges (a, 12)
f.write (out (a))
f.close ()
test += 1

TestName = '%02d' % test
f = open (TestName, 'w')
print 'Test %s' % TestName
a = init (7)
add_clique (a, range (7))
f.write (out (a))
f.close ()
test += 1

TestName = '%02d' % test
f = open (TestName, 'w')
print 'Test %s' % TestName
a = init (8)
add_clique (a, range (0, 2))
add_clique (a, range (2, 4))
add_clique (a, range (4, 6))
add_clique (a, range (6, 8))
add_edges (a, 3)
f.write (out (a))
f.close ()
test += 1

TestName = '%02d' % test
f = open (TestName, 'w')
print 'Test %s' % TestName
a = init (9)
add_edges (a, 30)
f.write (out (a))
f.close ()
test += 1

TestName = '%02d' % test
f = open (TestName, 'w')
print 'Test %s' % TestName
a = init (10)
add_clique (a, range (10))
a[8][9] = 0
a[9][8] = 0
f.write (out (a))
f.close ()
test += 1

TestName = '%02d' % test
f = open (TestName, 'w')
print 'Test %s' % TestName
a = init (10)
add_clique (a, range (10))
f.write (out (a))
f.close ()
test += 1
