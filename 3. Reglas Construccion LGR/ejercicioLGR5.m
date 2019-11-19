num = 1;
den = conv([1 4 0], [1 4 20]);
G = tf(num, den);

rlocus(G);