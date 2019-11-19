function r=reducir(k,num,den)
if(nargin<3)
    fprintf('\nError:Número insuficiente de argumentos.');
    return
end
num=k*num;
g=tf(num,den);

polos=roots(den);
ceros=roots(num);
primerPolo=polos(1);
poloDominante=0;
contarIguales=0;

ordenPolos=sort(real(polos),'descend');
%disp(ordenPolos);

    for i=2:size(polos)
       if(primerPolo>polos(i) && primerPolo<0)
            poloDominante=primerPolo;
         
        elseif(primerPolo<polos(i) && polos(i)<0)
           poloDominante=polos(i);
            primerPolo=polos(i);
           
        elseif(real(primerPolo)==real(polos(i)))   
                contarIguales=2;
                if(imag(primerPolo)==0)
                    poloDominante=polos(i);
                end
        end
    end
    
    t=1;
    disp(poloDominante)
    disp(contarIguales)
    [m,n]=size(ceros);
    if(m==0)
        for j=1:n+1
            if (ordenPolos(1)==ordenPolos(2))
                    o=3;
            else
                o=2;
            end
            for i=o:o+n
                k=num/abs(ordenPolos(o));
                display(k);
                t=i+1;
            end
        end
    else
        for j=1:size(ceros)
            if (ordenPolos(1)==ordenPolos(2))
                  disp('entra')
                if(imag(ordenPolos(1))==0)
                    o=2;
                else
                    o=3;
                end
                
            else
                o=2;
            end
            for i=o:o+size(ceros)-1
                k=k*abs(ceros(j))/abs(ordenPolos(o));
                t=i+1;
            end
        end
    end
    for m=t:size(ordenPolos)
        if(poloDominante*6<abs(ordenPolos(m)))
            k=k/abs(ordenPolos(m));
        end
    end
    num=k;
    if(contarIguales==2)
      disp(poloDominante);
      x= real(poloDominante);
      y=imag(poloDominante);
      %disp(complex(x,y));
      %disp(-real(poloDominante)+imag(poloDominante));
      den=conv([1 -(complex(x,y))],[1 -(complex(x,-y))]);
    else
       den=poly(poloDominante);
    end
   %disp(den);
   r=tf(num,den);
   t=0:0.001:50;
   step(g,t)
   hold on
   step(r,t)
   grid
   disp('Sistema reducido =')
   legend('Función original','Funcion Reducida')
    
end
