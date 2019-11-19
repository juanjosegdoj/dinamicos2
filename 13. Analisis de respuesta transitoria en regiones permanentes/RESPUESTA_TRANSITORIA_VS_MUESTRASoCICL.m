%RESPUESTA TRANSITORIA VS. #MUESTRAS/CICLO
limpiar
disp('----------------------------------------------------------------------')
disp('---        RESPUESTA TRANSITORIA VS. #MUESTRAS/CICLO               ---')
disp('----------------------------------------------------------------------')
disp('---  SELECCIONE PRESIONANDO :                                      ---')
disp('---        1: PARA FUNCION DE LA PLANTA EN TF                      ---'); 
disp('---        2: PARA FUNCION DE LA PLANTA EN ZPK                     ---');
disp('----------------------------------------------------------------------')
n=input('SELECCIONE LA OPCION : '); 
disp(' '); 
switch n 
    case 1 
        num = input('ENTRE NUMERADOR DE LA PLANTA : num = '); 
        den = input('ENTRE DENOMINADOR DE LA PLANTA : den = '); 
        disp('LA FUNCION DE TRANSFERENCIA DE LA PLANTA ES : Gp(s) = '); 
        Gp = tf(num,den) 
        disp(' '); 
    case 2 
        Z = input('Entre vector de ceros : Z = '); 
        P = input('Entre vector de polos : P = '); 
        K = input('Ganancia es igual a : K = '); 
        disp('A FUNCION DE TRANSFERENCIA DE LA PLANTA ES : Gp(s) = '); 
        Gp = zpk(Z,P,K) 
end 
numzc = input('ENTRE NUMERADOR DEL CONTROLADOR : numzc = '); 
denzc = input('ENTRE DENOMINADOR DEL CONTROLADOR : denzc = '); 
SIGA =1; 
while SIGA == 1
    clc 
    disp(' '); 
    T = input('ENTRE TIEMPO DE MUESTREO : T = ');
     Gz = c2d(Gp,T,'zoh'); 
    disp('LA FUNCION DE TRANSF. DEL CONTROLADOR ES : '); 
    Gzc = tf(numzc, denzc,T)
    disp('PARA SEGUIR OPRIMA ENTER'); 
    pause 
    clc
     disp(' '); 
    disp('LA FUNCION DE TRANSF. EN LAZO ABIERTO ES : '); 
    Gla = Gz*Gzc 
    disp(' '); 
    disp('LA FUNCION DE TRANSF. EN LAZO CERRADO ES : '); 
    Glc = feedback(Gla,1) 
    disp('PARA SEGUIR OPRIMA ENTER'); 
    pause
     clc
     disp(' ');
     disp('LOS POLOS DEL SISTEMA SON : '); 
    Polos = pole(Glc) 
    disp('QUE TIENEN MAGNITUDES Y ANGULOS DE :'); 
    Mag = abs(Polos) 
    Ang1 = angle(Polos); 
    Ang = Ang1*180/pi
    if (Mag(1)<1)&(Mag(2)<1) 
        disp('EL SISTEMA ES ESTABLE'); 
    else 
        disp('EL SISTEMA ES INESTABLE'); 
    end 
    disp(' '); 
    disp('PARA SEGUIR OPRIMA ENTER'); 
    pause 
    clc 
    disp(' '); 
    disp('EL # MUESTRAS/CICLO = '); 
    2*pi/Ang1(1) 
    disp('LA RESPUESTA TRANSITORIA TIENE '); 
    disp('LAS SIGUIENTES CARACTERISTICAS'); 
    [Wn,Zita] = damp(Glc); 
    Wd = Wn(1)*sqrt(1-Zita(1)^2); 
    tr = (pi-Ang1(1))/Wd 
    tp = pi/Wd 
    Mp = exp(-Zita(1)*Wn(1)*pi/Wd) 
    ts = 4/(Zita(1)*Wn(1)) 
    nums = Wn(1)^2; 
    dens = [1 2*Zita(1)*Wn(1) Wn(1)^2]; 
    Gs = tf(nums,dens); 
    SIGA = input (' PRESIONE 1 PARA SEGUIR '); 
    figure 
    step(Glc,Gs) 
    legend('RESP. TRANSITORIA') 
end % fin de while

% Ejemplo
% Opcion 1
% --- Planta ---
% num = [1]
% den = [1 2 0]
% --- Controlador ---
% numzc = [2 0]
% denzc = [1 -1]
% T = 0.5

