k = 1;
num = [1 4 14 25];
den = [1 4 14 20 0];
G = tf(k*num, den);

rlocus(G);



% 