% ANALISIS DE ESTABILIDAD MEDIANTE EL CRITERIO DE ROUT-HURWITZ

%NOTA: Recuerde que para que el stm sea estable, todas los elementos de la
% primer columna del arreglo de routh deben ser mayores a cero

function r=routh(poli,eps)
    if(nargin < 2)
        fprintf('\nError:Numero insuficiente de argumentos.');
        return
    end
    es_aplicable = 1;
    dim=size(poli);                             
    coef=dim(2);                                
    r=zeros(coef,ceil(coef/2));                
    for i=1:coef                                
        r(2-rem(i,2),ceil(i/2))=poli(i);       
    end
    filas=coef-2;                               
    indice=zeros(filas,1);                      
    for i=1:filas                           
        indice(filas-i+1)=ceil(i/2);            
    end 
    for i=3:coef
        if (all(r(i-1,:)==0))
            fprintf('\n   Se detecto una fila de ceros')
            fprintf('\n Cuando en el arreglo de routh se detecta un afila de ceros, ')
            fprintf('\n significa que el sistema posee 2 polos imaginarios puros que generan')
            fprintf('\n un stm vibratorio por lo cual el criterio de routh no es aplicable por cuanto no existe una establilidad absoluta')
            es_aplicable = 0;
            a=coef-i+2;                         
            b=ceil(a/2)-rem(a,2)+1;             
            temp1=r(i-2,1:b);                  
            temp2=a:-2:0;                       
            r(i-1,1:b)=temp1.*temp2;
        elseif(r(i-1,1)==0)
                r(i-1,1)=eps;              
        %end  % En caso de no trabajar, comente este "end"
    end
        for j=1:indice(i-2)                     
            r(i,j)=-det([r(i-2,1) r(i-2,j+1);r(i-1,1) r(i-1,j+1)])/r(i-1,1);
        end
    end

    hay_ceros = 0;
    cambios = 0;
    signo_actual = 0;
    n_polos = 0;

    for i = 1: coef

        if(r(i, 1) < 0)
            n_polos = n_polos + 1;
        end

        if i == 1
            if(r(i, 1) > 0)
                signo_actual = 1;
            end
            if(r(i, 1) < 0)
                signo_actual = 0;
            end

            if(r(i, 1) == 0)
                hay_ceros = 1;
            end
        end

        if i > 1
            if(r(i, 1) > 0)
                signo = 1;
            end

            if(r(i, 1) < 0)
                signo = 0;
            end

            if signo ~= signo_actual
                cambios = cambios + 1;
                signo_actual = signo;
            end
        end
    end
    if es_aplicable
        if cambios == 0 && hay_ceros == 0
            disp('El sistema es estable');
        end
        if cambios == 0 && hay_ceros == 1
            disp('El sistema es marginalmente estable');
        end
        if cambios >= 1
            disp('El sistema es in-estable');
        end
    end
    disp('El numero de  cambios de signo y el número de polos que se localizan');
    disp('\n en el semiplano derecho del pano complejo S son: ');

    disp(cambios);

    % Instrucciones de uso
    % routh([1 3 4 6 15 21 10], 1)
