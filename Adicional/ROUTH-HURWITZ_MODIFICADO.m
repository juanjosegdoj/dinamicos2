% MÉTODO DE ROUTH-HURWITZ MODIFICADO
clc
disp(' RANGO DE ESTABILIDAD SEGUN METODO DE ROUTH-HURWITZ ');
disp(' ');
disp('SELECCIONE PRESIONANDO :');
disp(' 1: PARA FUNCION DE LA PLANTA EN TF ');
disp(' 2: PARA FUNCION DE LA PLANTA EN ZPK ');
n=input('SELECCIONE LA OPCION : ');
disp(' ');
disp('1. ENCONTRAR LA FUNCION DE TRANSF. LAZO CERRADO');
switch n
case 1
num = input('Entre coeficientes del numerador : num = ');
den = input('Entre coeficientes del denominador : den = ');
disp('LA FUNCION DE TRANSFERENCIA DE LA PLANTA ES : Gp(s) = ');
Gp = tf(num,den)
clc
disp(' ');
T = input('Enter tiempo de muestreo : T = ');
disp(' ');
disp('LA FUNCION DE TRANSF. DISCRETA DE LA PLANTA : G(z) = ');
Gz = c2d(Gp,T,'zoh')
disp(' ');
disp('LA FUNCION DE TRANSF. LAZO CERRADO ES : Glc(z) = ');
Glc = feedback(Gz,1)
[numz,denz] = tfdata(Glc,'v');
case 2
Z = input('Entre vector de ceros : Z = ');
P = input('Entre vector de polos : P = ');
K = input('Ganancia es igual a : K = ');
disp('LA FUNCION DE TRANSFERENCIA DE LA PLANTA ES : Gp(s) = ');
Gp = zpk(Z,P,K)
clc
disp(' ');
T = input('Entre tiempo de muestreo : T = ');
disp(' ');
disp('LA FUNCION DE TRANSF. DISCRETA DE LA PLANTA : G(z) = ');
Gz = c2d(Gp,T,'zoh')
disp(' ');
disp('LA FUNCION DE TRANSF. LAZO CERRADO ES : Glc(z) = ');
Glc = feedback(Gz,1)
[numz,denz] = tfdata(Glc,'v');
end
pause
clc
disp(' ');
disp('2. ENCONTRAR G(w) CON TRANSF. BILINEAL');
disp(' ');
67
disp(' a) VECTOR DE CAMBIO DE SIGNO ES :');
i=1;
a1=[ ];
while i<= n+1
a(i)=1;
if i==n+1
a1=[a(i) a1];
else
a(i+1)=-1;
a1= [a(i+1) a(i) a1];
end
i=i+2;
end
display(a1)
% Fin de rutina
disp(' ');
disp(' b) LA ECUACION CARACTERISTICA DE G(w) ES: ');
num=numz.*a1;
den=denz.*a1;
num=numeric(num);
den=numeric(den);
[numv,denv]=bilinear(num,den,0.5);
v1=[ ];
% v = -(T/2)w
v2 = -T/2;
for i=1:(n+1)
v(i)= v2^(i-1);
v1= [ v(i) v1];
end
display(v1)
numw=numv.*v1;
denw=denv.*v1;
Gpw=tf(numw,denw);
denwsym = poly2sym(denw,'w');
pretty(denwsym)
pause
clc
disp(' ');
if denw(1)<0
denw = denw*(-1);
else
denw = denw;
end
disp('LOS COEFICIENTES DE LA ECUACION DE Q(w) SON :');
denw = denw/denw(1)
disp('3. OBTENCION DE LOS COEFICIENTES DE ROUTH = ')
clc
disp(' ');
n = length(denz)-1;
disp(' ');
x = n-1;
switch x
case 1
clc
disp('LA MATRIZ DE ROUTH ES : ');
disp(' W2 = a0 a2');
disp(' W1 = a1 0');
disp(' W0 = b1 0');
disp(' ');
W2 = [denw(1) denw(3)];
W1 = [denw(2) 0 ];
disp(' RENGLONES : W2 y W1');
[W2; W1]
pause
if W1 ==0
disp('COMO W1 = 0, SE DERIVA RENGLON ANTERIOR');
Az=poly2sym([denw(1) 0 den(3)],'w')
dAz=diff(Az)
den=sym2poly(dAz)
W1= [den(1) 0]
else
W1=W1
end
b1 = denw(3);
W0 = [b1 0 ];
disp(' ');
disp('EL ARREGLO DE ROUTH ES : ')
[W2; W1; W0]
disp(' ');
disp('PRUEBA DE ESTABILIDAD');
if (denw(1)>0)&(denw(2)<0)
disp('EL SISTEMA ES INESTABLE');
elseif (denw(2)>0)&(b1<0)
disp('EL SISTEMA ES INESTABLE');
else
disp('EL SISTEMA ES ESTABLE');
end
pause
disp(' ');
case 2
pause
clc
disp('LA MATRIZ DE ROUTH ES : ');
disp(' W3 = a0 a2');
disp(' W2 = a1 a3');
disp(' W1 = b1 0');
disp(' W0 = a3 0');
disp(' ');
disp(' LAS FILAS W3 y W2 SON :');
W3 = [denw(1) denw(3)];
W2 = [denw(2) denw(4)];
[W3; W2]
if W2==0
disp(' W2 = 0, SE DEBE DERIVAR W3');
Az=poly2sym([denw(1) 0 denw(3) 0],'w')
dAz=diff(Az)
den=sym2poly(dAz)
denw(2)=den(1)
denw(4)=den(3)
elseif denw(2)==0
disp(' SI a1 = 0, ENTONCES a1 = EPSILON');
denw(2)= 1.0e-6
else
denw(2)=denw(2);
end
W2 = [denw(2) denw(4)];
b1 = (denw(2)*denw(3) - denw(1)*denw(4))/ denw(2);
W1 = [b1 0];
disp('LAS FILAS W3, W2, W1 SON :');
[W3; W2; W1]
if b1 ==0
disp(' W1 = 0, SE DEBE DERIVAR W2');
Az=poly2sym([denw(2) 0 denw(4)],'w')
Az=diff(Az)
den=sym2poly(Az)
b1=den(1);
else
b1=b1;
end
W1 = [ b1 0 ];
W0 = [denw(4) 0 ];
disp('EL ARREGLO DE ROUTH ES :');
[W3; W2; W1; W0]
disp('PRUEBA DE ESTABILIDAD DE ROUTH-HURWITZ :');
disp(' ');
if (denw(1)>0)&(denw(2)<0)
disp('EL SISTEMA ES INESTABLE');
elseif (denw(2)>0)&(b1<0)
disp('EL SISTEMA ES INESTABLE');
elseif (b1>0)&(denw(3)<0)
disp('EL SISTEMA ES INESTABLE');
else
disp('EL SISTEMA ES ESTABLE');
end
end
