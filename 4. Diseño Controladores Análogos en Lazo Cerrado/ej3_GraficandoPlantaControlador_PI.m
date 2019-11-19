K = 0.8; T = 6; tsd = 18; Zd = 0.6;

nump = K;
denp = [T 1];
GP = tf(nump, denp);

Wnd = 4/(Zd * tsd);
Kp = (2 * T * Zd * Wnd -1) / K;
Ki = (T * Wnd^2)/K;

numc = [Kp Ki];
denc = [1 0];
GC = tf(numc, denc);

GPLC = feedback(GP, 1);
t = 0:0.001:50;

step(GPLC, t)
hold on 
GPGC = series(GP, GC);
GPGCLC = feedback(GPGC, 1);
step(GPGCLC, t)
grid

