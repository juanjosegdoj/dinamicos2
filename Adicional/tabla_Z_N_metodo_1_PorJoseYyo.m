k = input('Ingresa el valor de k: ');
T = input('Ingresa el valor de T: ');
L = input('Ingresa el valor de L: ');
t_i = input('Ingresa el valor de tiempo(t): ');

tabla = [T/(k*L) 0 0;0.9*T/(k*L) 0.3/L 0;1.2*T/(k*L) 1/(2*L) 0.5*L]

t = 0:t_i/1000:t_i;

Gp = tf(k, [T 1], 'Inputdelay', L); % Planta
step(Gp, t);
hold on
legend('Planta')
figure

Gc = tf([tabla(1,1) tabla(1,2)], [1 0]);   % Controlador P
GpGc = series(Gp,Gc);
GpGcLc = feedback(GpGc,1);
step (GpGcLc, t)
legend('P')
figure

Gc = tf([tabla(2,3) tabla(2,1) tabla(2,2)], [1 0]);   % Controlador PI
GpGc = series(Gp,Gc);
GpGcLc = feedback(GpGc,1);
step (GpGcLc, t)
legend('PI')
figure

Gc = tf([tabla(3,3) tabla(3,1) tabla(3,2)],[1 0]); % Controlador PID
GpGc = series(Gp,Gc);
GpGcLc= feedback(GpGc,1);
step(GpGcLc, t)
legend('PID')