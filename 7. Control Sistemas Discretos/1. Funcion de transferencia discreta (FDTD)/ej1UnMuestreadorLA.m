disp('----------------------------------------------------------------------')
disp('--- 1. FDT discreta en lazo abierto, con UN muestreador            ---')
disp('----------------------------------------------------------------------')
disp('                        num')
disp('       M(z) = GH(z) =  -----')
disp('                        den')
disp('Ejemplo:')
disp('     k = 1/3;')
disp('     num = [0 exp(-2)-exp(-5) 0];')
disp('     den = [1 -(exp(-2)+exp(-5)) exp(-7)];')
disp(' ')

k = input('Ingrese constante k del numerador: ');
num = input('Ingrese el numerador: ');
den = input('Ingrese el denominador: ');

x = [1 zeros(1, 20)];
v = [0 20 0  0.5];  % ejeX de 0 a 20, eje y de 0 a 0.5
axis(v);
y = filter(k*num, den, x);
stem(y, '*')
title('FDT DISCRETIZADO con 1 muestreador')
xlabel('k')
ylabel('X(k)')
grid