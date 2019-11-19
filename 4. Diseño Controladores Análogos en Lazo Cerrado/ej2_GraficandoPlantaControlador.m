k = 5.49;
nump = 1;
denp = conv([1 1.5], [1 6]);
Gp = tf(nump, denp);

numc = conv([1 0.8], [1 0.135]);
denc = [1 0];

Gc = tf(k*numc, denc);
GpGc = series(Gp, Gc);  
t = 0:0.01:30;

GpLC = feedback(Gp, 1);
step(GpLC, t)
hold on

GPGcLC = feedback(GpGc, 1);
step(GPGcLC, t)
grid