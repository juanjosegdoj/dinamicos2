a1 = 0.8; a2 = 0.8; a3 = 1; tsd = 2; zd = 0.7;

wnd = 4/(zd * tsd);
q = 5 * zd * wnd + 0.1;
kd = (2 * zd * wnd + q - a2)/a1;
kp = (wnd^2 + 2 * q * zd * wnd -a3)/a1;
ki = (q * wnd^2)/a1;

nump = a1;
denp = [1 a2 a3];
Gp = tf(nump, denp);
numc = [kd kp ki];
denc = [1 0];
Gc = tf(numc, denc);

gplc = feedback(Gp, 1);
t = 0:0.01:30;
step(gplc, t)
hold on

GpGc = series(Gp, Gc);
GpGcLc = feedback(GpGc, 1);
step(GpGcLc, t)

grid