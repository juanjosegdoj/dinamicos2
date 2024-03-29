limpiar
disp('--------------------------------------------------------------------------------------')
disp('--- 8. Sistemas de control Digital                                                 ---')
disp('--------------------------------------------------------------------------------------')
disp('---  Encontrar FDT en La LA y LC, dados los parámetros kp, ki, kdy la planta en Z  ---')
disp('--------------------------------------------------------------------------------------')
disp('---           k1 + k2*z^(-1) + k3*z^(-3)       donde k1 = kp + ki*T/2 + kd/T       ---')
disp('--- G(pid) = -----------------------------           k2 = -kp + ki/2 - 2*kd/T      ---')
disp('---                  1 - z^(-1)                      k3 = kd/T                     ---')
disp('---                                            y   Gp(z) = (1-z^(-1))*3{Gp}        ---')
disp('--------------------------------------------------------------------------------------')
disp('--- Ejemplo:                                                                       ---')
disp('---         T = 1; kp = 1; ki = 0.2; kd = 0.5;                                     ---')
disp('---         k = 0.25;                                                              ---')
disp('---         nump = [0 1+exp(-2) 1-3*exp(-2)];                                      ---')
disp('---         denp = [1 -(1+exp(-2)) exp(-2)];                                       ---')
disp('--------------------------------------------------------------------------------------')

T = input('Ingrese T: '); 
kp = input('Ingrese kp: '); 
ki = input('Ingrese ki: ');  
kd = input('Ingrese kd: '); 


k1 = kp + ki*T/2 + kd/T;
k2 = -kp + ki/2 - 2*kd/T;
k3 = kd/T;

%k = 0.25;
%nump = [0 1+exp(-2) 1-3*exp(-2)];
%denp = [1 -(1+exp(-2)) exp(-2)];

k = input('Ingresa la constante k de la FDTD, k= ');
nump = input('Ingresa el numerador de la planta en z numpz= ');
denp = input('Ingresa el denominador de la planta en z denpz= ');

Gz = tf(k*nump, denp, T);
Gc = tf([k1 k2 k3], [1 -1 0], T);

FLA = series(Gz, Gc);
FLA
FLC = feedback(FLA, 1);
FLC

%-------------------- Pintando la planta ------------------------------
x = [1 zeros(1, 20)];
v = [0 20 0 1.2];  % ejeX de 0 a 20, eje y de 0 a 0.5
axis(v);
y = filter(nump, denp, x);
stem(y, '*')
title('Planta')
xlabel('k')
ylabel('X(k)')
grid
figure()

%-------------------- Pintando FDT en Lazo cerrado --------------------
step(FLC);
title('Función de Transferencia en Lazo Cerrado')
xlabel('k')
ylabel('X(k)')
grid