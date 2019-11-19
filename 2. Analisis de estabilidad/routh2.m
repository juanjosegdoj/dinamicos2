%ANÃ?LISIS DE ESTABILIDAD MEDIANTE EL CRITERIO DE ROUT-HURWITZ
% NOTA: Esta función admite variables
function r=routh2(poli,eps)
    if(nargin < 2)
        fprintf('\nError:NÃºmero insuficiente de argumentos.');
        return
    end
    dim=size(poli);                             
    coef=dim(2);                                
    r=sym(zeros(coef,ceil(coef/2)));                
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
            a=coef-i+2;                         
            b=ceil(a/2)-rem(a,2)+1;             
            temp1=r(i-2,1:b);                  
            temp2=a:-2:0;                       
            r(i-1,1:b)=temp1.*temp2;
        elseif(r(i-1,1)==0)                   
                fprintf('\n   Primer elemento es cero')
                r(i-1,1)=eps;              
        end
        for j=1:indice(i-2)                     
            r(i,j)=-det([r(i-2,1) r(i-2,j+1);r(i-1,1) r(i-1,j+1)])/r(i-1,1);
        end
    end
