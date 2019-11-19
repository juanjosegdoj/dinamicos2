nump = 1;
denp = conv([1 0], conv([1 1], [1 5]));
Gp = tf(nump, denp);

k = 3.19;
numc = [1 1.3];
denc = [1 3.8];

Gc = tf(numc, denc);
GpGc = series(Gp, Gc);
t = 0:0.01:70;

GpLC = feedback(Gp, 1);
step(GpLC, t)
hold on
GPGcLC = feedback(GpGc, 1);
step(GPGcLC, t)
grid