% ERROR EN ESTADO ESTACIONARIO 
clc
disp('---    ERROR EN ESTADO ESTACIONARIO    ---')
disp(' ');
disp('SELECCIONE PRESIONANDO :'); 
disp(' 1: PARA FUNCION DE LA PLANTA EN TF '); 
disp(' 2: PARA FUNCION DE LA PLANTA EN ZPK '); 
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
    disp('LA FUNCION DE TRANSFERENCIA DE LA PLANTA ES : Gp(s) = '); 
    Gp = zpk(Z,P,K) 
end 
numzc = input('ENTRE NUMERADOR DEL CONTROLADOR : numzc = '); 
denzc = input('ENTRE DENOMINADOR DEL CONTROLADOR : denzc = '); 
SIGA =1; 
while SIGA ==1 
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
    Gla = Gz * Gzc 
    disp(' '); 
    
    % (A) OBTENCION DE Kp 
    disp('PARA SEGUIR OPRIMA ENTER'); 
    pause 
    clc 
    disp(' '); 
    disp('(A) OBTENCION DE Kp'); 
    [numa,dena] = tfdata(Gla,'v'); 
    syms z
     Glasym = poly2sym(numa,'z') / poly2sym(dena,'z'); 
    Kp = limit(Glasym,z,1)
    if isnan(Kp) 
        disp('EL ess A LA ENTRADA DEL ESCALON ES : ess = '); 
        ess = 0; 
  %      numeric(ess) 
    else 
        disp('EL ess A LA ENTRADA DEL ESCALON ES : ess = '); 
        ess = 1/(1+Kp)
    %numeric(ess) 
    end
    figure(1) 
    Glc = feedback(Gla,1); 
    k = 0:10; 
    x = ones(1,11); 
    c1 = lsim(Glc,x); 
    plot(k,x,k,c1) 
    grid
     legend(' ESCALON :ESS')
     
    % (B) OBTENCION DE Kv 
    disp('PARA SEGUIR OPRIMA ENTER'); 
    pause 
    clc 
    disp(' '); 
    disp('(B) OBTENCION DE Kv'); 
    Kv = limit((1-z^(-1))*Glasym/T,z,1)
    if isnan(Kv) 
        disp('EL ess A LA ENTRADA DE LA RAMPA ES : ess = '); 
        ess = 0;
    else 
        disp('EL ess A LA ENTRADA DE LA RAMPA ES : ess = '); 
        ess = 1/Kv 
    end 
    figure(2)
    k = 0:10; 
    x = k*T; 
    c2 = lsim(Glc, x); 
    plot(k, x, k, c2) 
    grid 
    legend('RAMPA : ESS') 
    SIGA = input (' PRESIONE 1 PARA SEGUIR '); 
    
    
        % (B) OBTENCION DE Ka 
    disp('PARA SEGUIR OPRIMA ENTER'); 
    pause 
    clc 
    disp(' '); 
    disp('(C) OBTENCION DE Ka'); 
    Ka = limit(((z-1)^2/(T^2*(z+1)))*Glasym/T, z, 1)
    if isnan(Ka) 
        disp('EL ess A LA ENTRADA DE LA RAMPA ES : ess = '); 
        ess = 0;
    else 
        disp('EL ess A LA ENTRADA DE LA RAMPA ES : ess = '); 
        ess = 1/Ka
    end 
    figure(3)
    k = 0:10; 
    x = (k.^2)*T; 
    c3 = lsim(Glc, x); 
    plot(k, x, k, c3) 
    grid 
    legend('PARABOLA UNITARIA : ESS') 
    SIGA = input (' PRESIONE 1 PARA SEGUIR ');
    
    
    end % fin de while