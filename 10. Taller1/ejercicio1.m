limpiar
disp('------------------------------------------------------------------------------------')

disp('---                      10. Taller 1                                            ---')
disp('------------------------------------------------------------------------------------')

disp('--- En este caso, se pesentarán los resultados obtenidos en el                   ---')
disp('--- taller 1 de la materia.                                                      ---')
disp('------------------------------------------------------------------------------------')
disp('--- J = 0.01;      b = 0.01;        k = 0.016;       Ra = 0.05;               ------')
disp('---         b0 = 8.6066 * 10^(-3);     La = 0.01;                             ------')
disp('------------------------------------------------------------------------------------')
disp('--- num =                      [(KT*b0)/(J*La)]                                  ---')
disp('---                      -------------------------                               ---')
disp('--- den = [1 (b/J + Ra/La) (k/J + (Ra*b)/(J*La) + KT^2/(J*La)) (k*Ra/(J*La))];   ---')
disp('------------------------------------------------------------------------------------')

J = 0.01;
b = 0.01;
k = 0.016;
b0 = 8.6066 * 10^(-3);
La = 0.01;
Ra = 0.05;
KT = 0.0232379;

num = [(KT*b0)/(J*La)];
den = [1 (b/J + Ra/La) (k/J + (Ra*b)/(J*La) + KT^2/(J*La)) (k*Ra/(J*La))];

% ----------------------------------------

t_i = 120;  % Valor del tiempo en la gráfica

sys = tf(num, den)

kcr = margin(sys);   % Obtenemos la ganancia

a = rlocus(sys);

frec = abs(imag(min(a(real(a)>0)))); % Tomamos el valor imaginario mas pequeño del semiplano derecho del rlocus que es la frecuencia
 
tcr = 2*pi/frec;

tabla = [0.5*kcr 0 0;0.45*kcr 1.2/tcr 0;0.6*kcr 2/tcr 0.125*tcr]

t = 0:t_i/1000:t_i;  
t_planta = 0:0.01:6;  % Valor del tiempo de la planta
Gp = tf(num, den); % Planta
step(Gp, t_planta);
hold on
legend('Planta')
grid
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