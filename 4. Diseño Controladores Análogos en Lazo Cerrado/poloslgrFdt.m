% clc
% disp('   ')
% disp('   ____________________________________________________________________________')
% disp('                                    LGR con P, PI,PD,PID                         ') 
% disp('   ____________________________________________________________________________')
% 
% num = input('Ingrese el numerador : num = ');
% den = input('Ingrese el denominador : den = ');
% mp = input('Entre el valor de MP : mp = ');
% ts = input('Entre el valor de TS : ts = ');
% poloslgrFdt2(num,den,mp,ts)

function r = poloslgrFdt(num, den, mp, ts)
    s = tf('s');
    
    g = tf(num,den)
    t = 0:0.01:100

    teta = round(abs(atan(pi/(log(mp)))) * 180 / pi);
    beta = pi / ts;
    wd = beta*tan(teta * pi / 180);
    pdpos = -beta + j*wd;
    pdneg = -beta - j*wd;

    %p
    disp('Comprobamos que los polos determinados pertenezcan al LGR rlocus');
    figure
    rlocus(g) % para comprobar si se puede seguir con p
    disp('Presione enter para continuar')
    pause
    
    polos=roots(den);
    numPolos=size(polos);
    k=1;
    for i=1:numPolos(1)
        polo = polos(i);
        x = abs(real(polo))-beta;
        y = abs(imag(polo))-wd;
        d = sqrt(x^2 + y^2);
        k=k*d;
    end
    gk = k*g;
    display(gk);
    disp('Resultado P')
    
    kp = dcgain(gk);
    essStep = 1 / (1 + kp)
    figure
    step(g, t)
    hold on
    step(feedback(gk, 1), t)
    
     disp('Presione enter para continuar')
    pause

    disp('Resultado PI')
    
    %pi
    a = (1/6)*beta;
    numc = [1 a];
    denc = [1 0];
    gc = tf(numc, denc);
    ggc = series(gc, g)

    kp = dcgain(ggc);
    display(kp);
    essStep = 1 / (1 + kp)
    
    ggclc = feedback(ggc, 1);

    step(ggclc, t)
    stepinfo(ggclc)

     disp('Presione enter para continuar')
    pause
    
    %pd
    disp('Resultado PD')
    
    angulosPolos = 0;
    for i=1:numPolos(1)
        angulosPolos = angulosPolos + 180-radtodeg(atan(abs(j*wd)/abs(beta-abs(real(polos(i))))));
    end
    
    b= (beta/tan(degtorad(angulosPolos+180)))+beta;
    numpd = [1 b];
    denpd = 1;
    k= k/sqrt((wd)^2+(b-beta)^2);
    gpd = tf(numpd * k, denpd);
    ggpd = series(g,gpd);
    
    display(ggpd);
    kp = dcgain(ggpd);
    display(kp);
    essSteppd = 1 / (1 + kp);
    essStepPorcentajedp = round(essSteppd * 100);
    display(essStepPorcentajedp);
    
    gpddlc = feedback(ggpd, 1);

    step(gpddlc, t)
    pd = stepinfo(gpddlc);
    
    disp('Presione enter para continuar')
    pause
    
    %pid
    disp('Resultado PID')
    
    numpid = conv([1 a], [1 b]);
    denpid = [1 0];
    display(k);
    gpid = tf(numpid * k, denpid);
    ggpid = series(g,gpid);
    
    kp = dcgain(ggpid);
    display(kp);
    essSteppid = 1 / (1 + kp);
    essStepPorcentajepid = round(essSteppid * 100);
    display(essStepPorcentajepid);
    
    gpidlc = feedback(ggpid, 1);

    step(gpidlc, t)
    pid = stepinfo(gpidlc)

    legend({'Sin Controlador','P','PI','PD','PID'})
    
    disp('Presione enter para continuar')
    pause
end
