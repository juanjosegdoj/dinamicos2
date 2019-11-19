T = 1;
kp = 1; ki = 0.2; kd = 0.5;

k1 = kp + ki*T/2 + kd/T;
k2 = -kp + ki/2 - 2*kd/T;
k3 = kd/T;

k = 0.25;
nump = [0 1+exp(-2) 1-3*exp(-2)];
denp = [1 -(1+exp(-2)) exp(-2)];

Gz = tf(k*nump, denp, T);
Gc = tf([k1 k2 k3], [1 -1 0], T);

FLA = series(Gz, Gc);
FLC = feedback(FLA, 1);
FLC

%-------------------- Pintando la planta --------------------
x = [1 zeros(1, 20)];
v = [0 20 0 1.2];  % ejeX de 0 a 20, eje y de 0 a 0.5
axis(v);
y = filter(nump, denp, x);
stem(y, '*')
title('Planta')
xlabel('k')
ylabel('X(k)')
grid

%-------------------- Pintando FDT en Lazo cerrado --------------------
step(FLC);
title('Función de Transferencia en Lazo Cerrado')
xlabel('k')
ylabel('X(k)')
grid