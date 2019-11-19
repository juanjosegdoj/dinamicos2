% Ingresamos los parámetros.
k = 1.778;   %3.22;
T = 2888.804;  %2293.98;
L = 5;  %180;

% ------------- Creamos la planta -------------------------
num = k;
den = [T 1];
gp = tf(num,den,'InputDelay', L);
t=0:0.01:1000;
step(gp,t)
legend('Controlado PI')
figure

% ------------- Creamos el control PI -------------------------
kp = 0.9 * T/(k*L);
ki = 0.3/L;
kd = 0;
matriz1 = [kp ki kd];
numc = [kp ki];
denc = [1 0];
gc= tf(numc,denc); %Control PI
gpgc = series(gp,gc);
gpgclc = feedback(gpgc,1);
step(gpgclc,t)
legend('Controlado PI')
figure

% ------------- Creamos el control PID -------------------------
kp= 1.2 * T/(k*L);
ki= 1/(2*L);
kd=0.5 * L;
numc=[kd kp ki];
denc=[1 0];
gc=tf(numc,denc); %control PID
gpgc = series(gp,gc);
gpgclc = feedback(gpgc,1);
step (gpgclc,t)
legend('Controlador PID')
figure

% ------------- Creamos el control P -------------------------
kp = T/(k*L);
ki = 0;
kd = 0;
numc = [kd kp];
denc = 1;
gc = tf(numc,denc); %control P
gpgc = series(gp,gc);
gpgclc = feedback(gpgc,1);
step(gpgclc,t)
grid
legend('Controlador P')

% ------------- Creamos la TABLA 1 -------------------------

mat = [T/(k*L) 0 0; (0.9*T)/(k*L) 0.3/L 0; (1.2*T)/(k*L) 1/(2*L) 0.5*L];

disp(mat);