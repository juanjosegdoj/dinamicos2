k = 1; T = 1.2; L = 0.3692;
num = k;
den = [T 1];
Gp = tf(num, den, 'InputDelay', T);
t = 0:0.01:20;
step(Gp, t)
grid
hold on