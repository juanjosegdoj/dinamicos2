disp('----------------------------------------------------------------------')
disp('--- 2. Segundo método de Z-N; Oscilación Continua                  ---')
disp('----------------------------------------------------------------------')

num = input('Ingrese el numerador en un corchetes: ');
den = input('Ingrese el denominador en un corchetes: ');
t_i = input('Ingresa el valor de tiempo(t): ');

sys = tf(num, den);

kcr = margin(sys);

a = rlocus(sys);

frec = abs(imag(min(a(real(a)>0)))); % Tomamos el valor imaginario mas pequeño del semiplano derecho del rlocus que es la frecuencia
 
tcr = 2*pi/frec;

tabla = [0.5*kcr 0 0;0.45*kcr 1.2/tcr 0;0.6*kcr 2/tcr 0.125*tcr]

t = 0:t_i/1000:t_i;

Gp = tf(num, den); % Planta
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