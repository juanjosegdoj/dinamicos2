function r = routhmodificadofunction(num, den, T)
    syms z w;
    plantatf = tf(num,den);
    plantatf
    plantadiscretizada = c2d (plantatf, T, 'zoh');
    [num,den]=tfdata(plantadiscretizada);
    plantadiscretizada
    p(z) = poly2sym(cell2mat(num),z)/poly2sym(cell2mat(den),z);
    Gw=p((w+1)/(w-1));
    Gw=simplify(Gw);
    [num,den]=numden(Gw);
    num=sym2poly(num);
    den=sym2poly(den);
    longitud_de_la_ecuacion=length (den);
    disp('Las raices de la ecuación son:')
    roots(den)
    if mod(longitud_de_la_ecuacion,2)==0 
        matrix=zeros(longitud_de_la_ecuacion,longitud_de_la_ecuacion/2);
        [filas,columnas]=size(matrix);
        for i=1:columnas
            matrix(1,i)=den(1,(2*i)-1);
            matrix(2,i)=den(1,(2*i));
        end
    else
        matrix=zeros(longitud_de_la_ecuacion,(longitud_de_la_ecuacion+1)/2);
        [filas,columnas]=size(matrix);
        for i=1:columnas
            matrix(1,i)=den(1,(2*i)-1);
        end
        for i=1:((longitud_de_la_ecuacion-1)/2)
            matrix(2,i)=den(1,(2*i));
        end
    end

    for j=3:filas
        if matrix(j-1,1)==0
            matrix(j-1,1)=0.001;
        end
        for i=1:columnas-1
            matrix(j,i)=(-1/matrix(j-1,1))*det([matrix(j-2,1) matrix(j-2,i+1);matrix(j-1,1) matrix(j-1,i+1)]);
        end
    end

    disp('El arreglo de Routh-Hurwitz es:')
    disp(matrix)
    Temp=sign(matrix);a=0;
    for j=1:filas
        a=a+Temp(j,1);
    end
    if a==filas
        disp('El sistema es estable')
    else
        disp('El sistema es inestable')
    end
 end