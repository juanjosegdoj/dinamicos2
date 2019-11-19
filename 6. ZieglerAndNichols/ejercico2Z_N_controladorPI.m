k = 1;
T = 1.2;
L = 0.3692;

num = k;
den = [T 1];
Gp = tf(num, den, 'Inputdelay', T);
t = 0:0.01:20;
step(Gp, t);
hold on

kp = 0.9*T/L;
ki = 0.3/L;
numc = [kp ki];
denc = [1 0];

Gc = tf(numc, denc);   % Controlador PI

GpGc = series(Gp,Gc);
GpGcLc = feedback(GpGc,1);
step (GpGcLc, t)
legend('P','PI')
figure
%hold on

kp = 1.2*T/L;
ki = 0.5/L;
kd = 0.5*L;

numc = [kd kp ki];
denc = [1 0];
Gc = tf(numc,denc); % Controlador PID
GpGc = series(Gp,Gc);
GpGcLc= feedback(GpGc,1);
step(GpGcLc, t)
grid

legend('PID')