disp('----------------------------------------------------------------------')
disp('--- 1. FDT discreta en lazo abierto, con DOS muestreador            ---')
disp('----------------------------------------------------------------------')
disp('                            num')
disp('        M(z) = G(z)H(z) =  ------')
disp('                            den')
disp('Ejemplo:')
disp('     T = 1;')
disp('     num = [1 0 0];')
disp('     den = conv([1 -exp(-2*T)], [1 -exp(-5*T)]);')
disp(' ')

T = input('Ingrese valor de T: ');
num = input('Ingrese el numerador: ');
den = input('Ingrese el denominador: ');

x = [1 zeros(1, 20)];
v = [0 20 0 1.2];  % ejeX de 0 a 20, eje y de 0 a 0.5
axis(v);
y = filter(num, den, x);
stem(y, '*')
title('FDT DISCRETIZADO con 2 muestreadores')
xlabel('k')
ylabel('X(k)')
grid