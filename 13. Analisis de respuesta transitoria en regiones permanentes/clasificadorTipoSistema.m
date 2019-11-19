disp('----------------------------------------------------------------------')
disp('---                GRAFICA DE SISTEMAS AMORTIGUADOS                ---')
disp('----------------------------------------------------------------------')
Wn = input('Frecuencia natural amortiguada: Wn= ');
Z = input('Factor de amortiguamiento: Z= ');
num = Wn^2;
den = [1 2*Z*Wn Wn^2];
Gs = tf(num, den);
step(Gs, 10)
title('GRAFICA DE SISTEMAS AMORTIGUADOS')
grid
if Z == 0
    legend('Sistema Oscilatorio')
elseif Z > 0 && Z < 1
    legend('Sistema subamoritguado')
elseif Z == 1
    legend('Sistema amortiguado')
elseif Z == 1.5
    legend('Sistema sobreamortiguado')
else
    disp('El programa no pudo clasificar ')
end
hold on