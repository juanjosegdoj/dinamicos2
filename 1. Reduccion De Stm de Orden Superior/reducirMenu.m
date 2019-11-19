limpiar
disp('----------------------------------------------------------------------')
disp('---           Reducción de un sistema de orden superior            ---')
disp('----------------------------------------------------------------------')
disp('--- Ejemplo:                                                       ---')
disp('---    k = 0.05;  num = [1 2]; den = conv([1 0.4],[1 2] + 0.05)    ---')
disp('----------------------------------------------------------------------')
k = input('Entre la ganancia del sistema : k = ');
num = input('Entre coeficientes del numerador : num = ');
den = input('Entre coeficientes del denominador : den = ');
reduccion_sistemas(k,num,den)