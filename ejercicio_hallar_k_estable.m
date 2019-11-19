k = 0.6; % punto de quiebre 0.707
num=[1 2 4];
den = [1 1 2 3];
G = tf(k*num,den);
Glc = feedback(G,1);
t = 0:0.001:300;
step(Glc,t);
grid