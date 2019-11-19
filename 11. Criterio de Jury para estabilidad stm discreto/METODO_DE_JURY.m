%METODO DE JURY

%Test de Jury para determinar la estabilidad de sistemas discretos:
clc
disp('ESTABILIDAD SEGUN METODO DE JURY ');
disp('SELECCIONE PRESIONANDO :');
disp(' 1: PARA FUNCION DE LA PLANTA EN TF ');
disp(' 2: PARA FUNCION DE LA PLANTA EN ZPK ');
disp(' 3: ECUACION CARACTERISTICA DEL SISTEMA');
n=input('SELECCIONE LA OPCION : ');
disp(' ');
switch n
    case 1
        num = input('Entre coeficientes del numerador : num = ');
        den = input('Entre coeficientes del denominador : den = ');
        disp('LA FUNCION DE TRANSFERENCIA DE LA PLANTA ES : Gp(s) = ');
        Gp = tf(num,den)
        T = input('Enter tiempo de muestreo : T = ');
        disp('LA FUNCION DE TRANSF. DISCRETA DE LA PLANTA : G(z) = ');
        Gz = c2d(Gp,T,'zoh')
        disp('LA FUNCION DE TRANSF. LAZO CERRADO ES : Glc(z) = ');
        Glc = feedback(Gz,1)
        [numz,denz] = tfdata(Glc,'v');
        
    case 2
        Z = input('Entre vector de ceros : Z = ');
        P = input('Entre vector de polos : P = ');
        K = input('Ganancia es igual a : K = ');
        disp('LA FUNCION DE TRANSFERENCIA DE LA PLANTA ES : Gp(s) = ');
        Gp = zpk(Z,P,K)
        T = input('Enter tiempo de muestreo : T = ');
        disp('LA FUNCION DE TRANSF. DISCRETA DE LA PLANTA : G(z) = ');
        Gz = c2d(Gp,T,'zoh')
        disp('LA FUNCION DE TRANSF. LAZO CERRADO ES : Glc(z) = ');
        Glc = feedback(Gz,1)
        [numz,denz] = tfdata(Glc,'v');
        
    case 3
        denz = input('COEFICIENTES DE LA ECUACION CARACTERISTICA : denz = ' );
        end
        disp('EL ORDEN DE LA ECUACION CARACTERISTICA ES : n = ')
        n = length(denz) - 1
        % OBTENCION DE MATRIZ DE JURY
        disp(' ');
        m = n + 1;
        for i=1:m
            a(i)=denz(i);
        end
        pz11 = polyval(denz,1);
        if abs(pz11) < 1.0e-5
            pz1=0;
        else
            pz1=pz11;
        end
        pz2 = polyval(denz,-1);
        x = n - 1;
switch x
    
    % SISTEMA DE ORDEN 2
    case 1
        disp('LA MATRIZ DE JURY ES : a2 a1 a0 = ');
        [a(3) a(2) a(1)]
        % PRUEBA DE ESTABILIDAD
        if (pz1 == 0)&(abs(a(m)) < abs(a(1)))
            disp('EL SISTEMA ES CRITICAMENTE ESTABLE')
        end
        if abs(a(m)) >= a(1)
            disp('EL SISTEMA ES INESTABLE ');
        elseif pz1 <= 0
            disp('EL SISTEMA ES INESTABLE');
        elseif pz2 >0
            disp('EL SISTEMA ES ESTABLE');
        else
            disp('EL SISTEMA ES INESTABLE');
        end
    % SISTEMA DE ORDEN 3
    case 2
        disp('LA MATRIZ DE JURY ES : ');
        disp(' ');
        disp('a3 a2 a1 a0');
        disp('a0 a1 a2 a3');
        disp('b2 b1 b0 ');
        for k=1:m-1
            b(k)=det([a(m) a(m-k); a(1) a(k+1)]);
        end
        A1 = [a(4) a(3) a(2) a(1)];
        A2 = [a(1) a(2) a(3) a(4)];
        B = [b(3) b(2) b(1) 0 ];
        [ A1; A2; B]
        pause
        clc
        disp(' ');
        disp('PRUEBA DE ESTABILIDAD : ');
        disp('a(n) = ');
        a(m)
        disp('a(0) = ');
        a(1)
        disp('Para z =1, P(z) = ');
        [pz1]
        if (pz1 == 0)&(abs(a(m)) < abs(a(1)))
            disp('EL SISTEMA ES CRITICAMENTE ESTABLE')
        end
        disp('Para z = -1, P(z) = ');
        [pz2]
        pause
        disp(' ');
        if abs(a(m)) >= a(1)
            disp('EL SISTEMA ES INESTABLE ');
        elseif pz1 < 0
            disp('EL SISTEMA ES INESTABLE');
        elseif pz2 >=0
            disp('EL SISTEMA ES INESTABLE');
        elseif (abs(b(m-1)) > abs(b(1)))
            disp(' b(n-1) = ');
            b(m-1)
            disp(' b(0) = ');
            b(1)
            disp('EL SISTEMA ES ESTABLE');
        else
            disp('EL SISTEMA ES INESTABLE');
        end
        
    % SISTEMA DE ORDEN 4
    case 3
        disp('LA MATRIZ DE JURY ES :');
        disp('a4 a3 a2 a1 a0 ');
        disp('a0 a1 a2 a3 a4 ');
        disp('b3 b2 b1 b0 ');
        disp('b0 b1 b2 b3 ');
        disp('c2 c1 c0 ');
        for k=1:m-1
            b(k)=det([a(m) a(m-k); a(1) a(k+1)]);
        end
        for k=1:m-2
            c(k)=det([b(m-1) b(m-1-k); b(1) b(k+1)]);
        end
        A1 = [a(5) a(4) a(3) a(2) a(1)];
        A2 = [a(1) a(2) a(3) a(4) a(5)];
        B1 = [b(4) b(3) b(2) b(1) 0 ];
        B2 = [b(1) b(2) b(3) b(4) 0 ];
        C = [c(3) c(2) c(1) 0 0 ];
        [A1; A2; B1; B2; C]
        %PRUEBA DE ESTABILIDAD
        if (pz1 == 0)&(abs(a(m)) < abs(a(1)))
            disp('EL SISTEMA ES CRITICAMENTE ESTABLE')
        end
        if abs(a(m)) >= a(1)
            disp('EL SISTEMA ES INESTABLE ');
        elseif pz1 < 0
            disp('EL SISTEMA ES INESTABLE');
        elseif pz2 <=0
            disp('EL SISTEMA ES INESTABLE');Nov
        elseif (abs(b(m-1)) <= abs(b(1)))
            disp('EL SISTEMA ES INESTABLE');
        elseif (abs(c(m-2)) > abs(c(1)))
            disp('EL SISTEMA ES ESTABLE');
        else
            disp('EL SISTEMA ES INESTABLE');
        end
    end
