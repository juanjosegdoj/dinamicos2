k = 3.22;
T = 2293.98;
L = 180;

num = k;
den = [T 1];
Gp = tf(num, den, 'Inputdelay', T);
t = 0:0.01:20;
step(Gp, t);
legend('P')
figure(1)

kp = 0.9*T/L;
ki = 0.3/L;
numc = [kp ki];
denc = [1 0];
Gc = tf(numc, denc);   % Controlador PI
GpGc = series(Gp,Gc);
GpGcLc = feedback(GpGc,1);
step (GpGcLc, t)

legend('PI')
figure(2)

kp = 1.2*T/L;
ki = 0.5/L;
kd = 0.5*L;

numc = [kd kp ki];
denc = [1 0];
Gc = tf(numc,denc); % Controlador PID
GpGc = series(Gp,Gc);
GpGcLc = feedback(GpGc,1);
step(GpGcLc, t)
grid

legend('PID')

mat = [T/L 0 0; 0.9*T/L 0.3/L 0; 1.2*T/L 1/(2*L) 0.5*L];

disp(mat);