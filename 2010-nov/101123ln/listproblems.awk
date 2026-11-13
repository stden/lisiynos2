#!/usr/bin/gawk
#1\begin{2problem}3{4fjklasf}5{6.in}
BEGIN {RS = "{|}|[.]in"; n = 1; ALPH = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";}
FNR == 1 {letter[n] = substr (ALPH, n, 1);}
FNR == 4 {name[n] = $0;}
FNR == 6 {id[n] = $0; n++;}
END {
 for (i = 1; i < n; i++)
  printf ("\tproblOTM   (\"%s\", \"%s\", \"%s\", 2, 262144)\n",
   letter[i], name[i], id[i]);
}
