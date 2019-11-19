num = [1 3];
den = conv([1 5 0], conv([1 6], [1 2 2]));
G = tf(num, den);
rlocus(G);