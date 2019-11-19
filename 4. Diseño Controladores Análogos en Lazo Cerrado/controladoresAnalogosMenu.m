
seleccion = -1;
while seleccion ~= 4
    limpiar
    disp('-----------------------------------------------------------------------------')
    disp('------------------ 4. Dise�o Controladores An�logos -------------------------')
    disp('-----------------------------------------------------------------------------')
    disp('--- 1. Graficar planta y planta-controlador manualmente.                  ---')
    disp('--- 2. Dise�o de controladores analgos mediante la asignaci�n de polos.   ---')
    disp('--- 3. Dise�o de contoladores PID, con pesos ingresado manualmente.       ---')
    disp('--- 4. Salir a MEN� PRINCIPAL                                             ---')
    disp('-----------------------------------------------------------------------------')
    seleccion = input('Seleccione una opci�n: ');
    if seleccion == 1
        disp('-----------------------------------------------------------------------------')
        disp('--- 1. Graficar planta y planta-controlador manualmente.                  ---')
        disp('-----------------------------------------------------------------------------')
        nump = input('Ingrese numerado de la planta=');
        denp = input('Ingrese denominador de la planta=');
        Gp = tf(nump, denp);

        k = input('Ingrese constante del controlador=');
        numc = input('Ingrese numerador del controlador=');
        denc = input('Ingrese denominador del controlador=');
        Gc = tf(k*numc, denc);

        GpGc = series(Gp,Gc);

        t = 0:0.01:15;

        % Planta en Lazo Cerrado
        GpLc = feedback(Gp, 1)
        step(GpLc, t);
        hold on

        GpGcLc = feedback(GpGc, 1)
        step(GpGcLc, t);

        legend('Planta', 'Planta-controlador')
        
    elseif seleccion == 2
        disp('-----------------------------------------------------------------------------')
        disp('--- 2. Dise�o de controladores analgos mediante la asignaci�n de polos.   ---')
        disp('-----------------------------------------------------------------------------')
        Zd = 0.1;
        opcion = -1;
        while opcion ~= 1 || opcion ~= 2 
            opcion = input('Ingrese la medida deseada: \n(1) Zd \n(2) Mp \n -> ');
            if opcion == 1
                Zd = input('Ingresa el valor deseado para Zd: ');
                break
            elseif opcion == 2
                Mpd = input('Ingresa el valor deseado para Mp: ');
                Zd = sqrt((log(Mpd))^2/(((log(Mpd))^2) + pi^2));
                break
            else
                fprintf('No se ha ingresado una opci�n v�lida, intenta de nuevo\n')
            end
        end

        tsd = input('Ingresa el valor deseado para ts: ');

        grado = -1;
        while grado ~= 1 || opcion ~= 2
           grado = input('Ingrese el grado del controlador de la planta: ');
            if grado == 1
                disp('--- Control PID por asignaci�n de polos para un stm de 1er orden           ---');
                disp('             K                                    KpS + Ki ')
                disp('Planta = -------- ;             controlador  =   ----------')
                disp('          TS + 1                                      S    ')
                k = input('Ingresa k: ');
                T = input('Ingresa T: ');
                %nump = input('Ingresa el numerador de la planta en un corchete: ');
                %denp = input('Ingresa el denominador de la planta en un corchete, incluyendo T: ');
                denp = [T 1];
                Gp = tf(k, denp);

                Wnd = 4/(Zd * tsd);
                kp = (2 * T * Zd * Wnd -1) / k;
                ki = (T * Wnd^2)/k;
                numc = [kp ki];
                denc = [1 0];
                Gc = tf(numc, denc);
                break
            elseif grado == 2
                disp('--- Control PID por asignaci�n de polos para un stm de 2do orden           ---');
                disp('                a1                                kd*S^2 + KpS + Ki ')
                disp('Planta = ----------------- ;    controlador  =   --------------------')
                disp('          S^2 + a2*S + a3                                 S    ')

                a1 = input('Ingresa a1: ');
                a2 = input('Ingresa a2: ');
                a3 = input('Ingresa a3: ');
                nump = a1;
                denp = [1 a2 a3];
                Gp = tf(nump, denp);

                Wnd = 4/(Zd*tsd);
                Q = 5*Zd*Wnd+0.1;
                kd = (2*Zd*Wnd+Q-a2)/a1;
                kp = (Wnd^2+2*Q*Zd*Wnd-a3)/a1;
                ki = (Q*Wnd^2)/a1;

                numc = [kd kp ki];
                denc = [1 0];
                Gc = tf(numc, denc);
                break
            end
        end

        Gplc = feedback(Gp, 1);
        t = 0:0.001:tsd+15;

        step(Gplc, t)
        hold on 
        GpGc = series(Gp, Gc);
        GpGclc = feedback(GpGc, 1);
        step(GpGclc, t)
        grid

        legend('Planta', 'Controlador')

    elseif seleccion == 3
        disp('-----------------------------------------------------------------------------')
        disp('--- 3. Dise�o de contoladores PID, con pesos ingresado manualmente.       ---')
        disp('-----------------------------------------------------------------------------')
        kp = input('Ingresa kp: ');
        kd = input('Ingresa kd: ');
        ki = input('Ingresa ki: ');

        PIDnum = [kd kp ki];
        PIDden = [1 0];

        Gnum = input('Ingrese numerado de la planta=');
        Gden = input('Ingrese denominado de la planta=');
        Gt = tf(conv(PIDnum, Gnum), conv(PIDden, Gden));
        t = 0:0.01:10;
        F = feedback(Gt, 1);
        step(F, t)
        grid
    elseif seleccion == 4
        disp('Saliendo ...')
    else
        fprintf('No se soporta el grado ingresado, intenta de con 1 � 2\n')
    end
    input('Pulse tecla para continuar.')
end