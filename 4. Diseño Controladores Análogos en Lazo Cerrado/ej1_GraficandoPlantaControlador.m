% Ejercicio controlador PID, 
nump = 1;
denp = conv([1 0], conv([1 0],[1 5]));
Gp = tf(nump, denp);

k = 3.19;
numc = [1 1.3];
denc = [1 3.8];
Gc = tf(k*numc, denc);

GpGc = series(Gp,Gc);

t = 0:0.01:15;

% Planta en Lazo Cerrado
GpLc = feedback(Gp, 1)
step(GpLc, t);
hold on

GpGcLc = feedback(GpGc, 1)
step(GpGcLc, t);

legend('Planta', 'Planta-controlador')