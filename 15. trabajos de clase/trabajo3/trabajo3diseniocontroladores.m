
opcion = input('Marque 0 para ingresar Mp y marque 1 para ingresar Zd= ');
if opcion == 0
   Mp = input('Introduzca Mp= ');
   Zd = sqrt((log(Mp))^2/(((log(Mp))^2)+pi^2));
   % lleva ese Mp a Zd
end
if opcion == 1
    Zd = input('Introduzca Zd= ');
end 

grado =  input('grado: ');
if(grado == 1)
    K = input('Introduzca K= ');
    T = input('Introduzca T= ');
    tsd = input('Introduzca tsd= ');

    nump = K;
    denp = [T 1];


    GP = tf(nump, denp);
    Wnd = 4/(Zd * tsd);
    Kp = (2 * T * Zd * Wnd -1) / K;
    ki = (T * Wnd^2)/K;
    numc = [Kp ki];
    denc = [1 0];
    GC = tf(numc, denc);

    GPLC = feedback(GP, 1);
    t = 0:0.001:50;

    step(GPLC, t)
    hold on 
    GPGC = series(GP, GC);
    GPGCLC = feedback(GPGC, 1);
    step(GPGCLC, t)
    grid
end

if(grado == 2)
    a1 = input('Introduzca a1= ');
    a2 = input('Introduzca a2= '); 
    a3 = input('Introduzca a3 ');
    tsd = input('Introduzca tsd= ');
    %zd = 0.7;

    wnd = 4/(Zd * tsd);
    q = 5 * Zd * wnd + 0.1;
    kd = (2 * Zd * wnd + q - a2)/a1;
    kp = (wnd^2 + 2 * q * Zd * wnd -a3)/a1;
    ki = (q * wnd^2)/a1;

    nump = a1;
    denp = [1 a2 a3];
    Gp = tf(nump, denp);
    numc = [kd kp ki];
    denc = [1 0];
    Gc = tf(numc, denc);

    gplc = feedback(Gp, 1);
    t = 0:0.01:30;
    step(gplc, t)
    hold on

    GpGc = series(Gp, Gc);
    GpGcLc = feedback(GpGc, 1);
    step(GpGcLc, t)
    grid
end