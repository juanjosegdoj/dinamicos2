num = 100*[1 30];
den = conv([1 1], conv([1 10], conv([1 20], [1 25])));
G = tf(num, den);

rlocus(G);
a = rlocus(G);
a