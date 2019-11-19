disp('----------------------------------------------------------------------')
disp('--- 1. Primer método de Z-N; Curva de Reacción                     ---')
disp('----------------------------------------------------------------------')

% Ingresamos los parámetros.
disp('ejemplo k = 1.778;  T = 2888.804;  L = 5;')
k = input('Ingrese ganancia estática (K)');  %K = GANANCIA ESTÁTICA ;   %3.22;  %K = GANANCIA ESTÁTICA 
T = input('Ingrese constane de tiempo (T)');  %2293.98;     % T = CONSTANTE DE TIEMPO
L = input('Ingrese retardo (R)');  %180;     % RETAD0

% ------------- Creamos la planta -------------------------
num = k;
den = [T 1];
gp = tf(num,den,'InputDelay', L);
t=0:0.01:1000;
step(gp,t)
legend('Planta')
figure

% ------------- Creamos el control PI -------------------------
kp = 0.9 * T/(k*L);
ki = 0.3/L;
kd = 0;
matriz1 = [kd kp ki];
numc = [kp ki];
denc = [1 0];
gc = tf(numc,denc);
gpgc = series(gp,gc);
gpgclc = feedback(gpgc,1);
step(gpgclc,t)
legend('Controlado PI')
figure

% ------------- Creamos el control PID -------------------------
kp = 1.2 * T/(k*L);
ki = 1/(2*L);
kd = 0.5 * L;
numc = [kd kp ki];
denc = [1 0];
gc = tf(numc,denc); %control PID
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
gc = tf(numc, denc); %control P
gpgc = series(gp, gc);
gpgclc = feedback(gpgc, 1);
step(gpgclc,t)
grid
legend('Controlador P')

% ------------- Creamos la TABLA 1 -------------------------
mat = [T/(k*L) 0 0; (0.9*T)/(k*L) 0.3/L 0; (1.2*T)/(k*L) 1/(2*L) 0.5*L];

disp(mat);