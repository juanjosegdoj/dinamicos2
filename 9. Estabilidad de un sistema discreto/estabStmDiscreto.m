T = input('Ingrese el tiempo de muestreo T= ');
num = input('Ingrese el numerador de la planta num= ');
den = input('Ingrese el denominador de la planta den= ');

disp(' ');
disp('La función de transferencia de la planta es G(S)= ');

Gs = tf(num, den);
Gs = zpk(Gs)

disp(' ')
disp('Presione la tecla enter');
pause
clc
disp(' ')
disp('Función de transferencia discretizada en G(Z)= ');
Gz = c2d(Gs, T, 'zoh');
GLa = Gz
disp(' ');
disp('Presione tecla enter')
pause
disp(' ')
disp('La función de transferencia en lazo cerrado es: GLC(Z) = ');
GLc = feedback(GLa, 1)
disp(' ');
disp('presione la tecla enter');
pause
clc
disp('Los polos de sistema en lazo cerrado son: ');
polos = pole(GLc)
disp(' ');
disp('Sus magnitudes y angulos son: ');
Mag = abs(polos)
Ang = angle(polos)*180/pi
disp(' ');
disp('¿Es el sistema ESTABLE?');
if Mag < 1
    disp('RESPUESTA: El sistema es ESTABLE')
else
    disp('RESPUESTA: El sistema NO es ESTABLE')
end
disp(' ')
disp('GRAFICA DE LOS POLOS Y CEROS');
pzmap(GLc);
grid