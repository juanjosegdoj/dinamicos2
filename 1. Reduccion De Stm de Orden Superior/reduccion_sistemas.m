%En este script se analiza un sistema dado y se eliminan los polos o los ceros de acuerdo a
%unas condiciones dadas. Los datos de entrada los k, num y den donde k se trata de la ganancia
%estática, num el numerador y den el denominador del sistema que se esta analizando. El script
%se debe llamar como a una función, puesto que de esa forma se ha construído.

%Validamos que los parametros ingresados sean los suficientes
function r = reduccion_sistemas(k,num,den)
if(nargin<3)
    disp('Error: Faltaron argumentos por ingresar.');
    return
end

polosR = roots(den);
nro_p = length(polosR);

% Realizamo un análisis de inestabilidad
for i = 1:nro_p
    if (polosR(i)>0)
        disp('Hay al menos un polo en el semiplano derecho del plano complejo. El sistema no se puede reducir.')
        return
    end
end

num = k*num;
G = tf(num,den);

polos = roots(den);
ceros = roots(num);

primer_polo = polos(1);
polo_dominante = 0;
contar_iguales = 0;

orden_polos = sort(real(polos),'descend');

for i = 2:size(polos)
   if(primer_polo > polos(i) && primer_polo < 0)
        polo_dominante = primer_polo;

    elseif(primer_polo < polos(i) && polos(i)<0)
        polo_dominante = polos(i);
        primer_polo = polos(i);

    elseif(real(primer_polo) == real(polos(i)))   
        contar_iguales = 2;
        if(imag(primer_polo) == 0)
            polo_dominante = polos(i);
        end
    end
end
    
t = 1;
disp(polo_dominante)
disp(contar_iguales)
[m, n] = size(ceros);

if(m == 0)
    for j = 1:n+1
        if (orden_polos(1) == orden_polos(2))
            o = 3;
        else
            o = 2;
        end
        for i = o:o+n
            k = num/abs(orden_polos(o));
            display(k);
            t = i+1;
        end
    end
else
    for j = 1:size(ceros)
        if (orden_polos(1) == orden_polos(2))
                disp('entra')
            if(imag(orden_polos(1))==0)
                o = 2;
            else
                o = 3;
            end

        else
            o = 2;
        end
        for i = o:o+size(ceros)-1
            k = k*abs(ceros(j))/abs(orden_polos(o));
            t = i + 1;
        end
    end
end
    
for m = t:size(orden_polos)
    if(polo_dominante*6<abs(orden_polos(m)))
        k=k/abs(orden_polos(m));
    end
end
num = k;
if(contar_iguales == 2)
    disp(polo_dominante);
    x = real(polo_dominante);
    y = imag(polo_dominante);
    %disp(complex(x,y));
    %disp(-real(polo_dominante)+imag(polo_dominante));
    den = conv([1 -(complex(x,y))],[1 -(complex(x,-y))]);
else
    den = poly(polo_dominante);
end

%Funcion reducida obtenida
R = tf(num,den);

% Graficamos la función dada y la función reducida 
disp('------------------------------------------')
disp('---          FUNCION ORIGINAL          ---')
disp('------------------------------------------')
display(G)
disp('Presiona ENTER para continuar')
pause
disp('------------------------------------------')
disp('---          FUNCION REDUCIDA          ---')
disp('------------------------------------------')
display(R)
disp('Presiona ENTER para continuar')
pause

% Mostramos la comparativa de las gráficas resultantes

t = 0:0.001:50;
step(G,t)
hold on
step(R,t)
grid
legend('Funcion original','Funcion Reducida')
title('Comparativa del sistema original y el sistema reducido')
    
end
