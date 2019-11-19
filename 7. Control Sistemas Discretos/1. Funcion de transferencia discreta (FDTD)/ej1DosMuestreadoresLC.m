disp('----------------------------------------------------------------------')
disp('--- 1. FDT discreta en lazo cerrado, con DOS muestreador           ---')
disp('----------------------------------------------------------------------')
disp('                G(z)        num')
disp('     M(z) = ----------- =  ------')
disp('             1+G(z)H(z)     den')
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