limpiar
band = 1;
while band
    limpiar
    band = 1;
    disp('----------------------------------------------------------------------')
    disp('-------------------- 2. An�lisis de estabilidad ----------------------')
    disp('----------------------------------------------------------------------')
    disp('--- 1. Criterio de estabilidad de Routh-Hurwitz                    ---')
    disp('--- 2. Criterio de estabilidad de Routh-Hurwitz simb�lico          ---')
    disp('--- 3. Salir a MEN� PRINCIPAL                                      ---')
    disp('----------------------------------------------------------------------')

    selection_routh = strrep(input('Ingrese el n�mero de la secci�n: ', 's'), ' ', '');

    switch selection_routh

        case '1'
            disp('(Ejemplo de Polinomio caracter�stico [1 3 4 6 15 21 10])');
            polinomio = input('Ingrese el polinomio caracter�stico= ');
            routh(polinomio, 1)
            input('Pulse tecla para continuar.')

        case '2'
            syms x y z;
            disp('Tenga en cuenta que x, y and z son las variables simb�licas.')
            disp('Ejemplo de Polinomio caracter�stico = [x^2 3*y 4+x 6-z]');
            polinomio = input('Ingrese el polinomio caracter�stico= ');
            routh2(polinomio, 1)
            input('Pulse tecla para continuar.')

        case '3'
            disp('Saliendo de la secci�n 2. An�lisis de estabilidad')
            band = 0;
    end
    
end 