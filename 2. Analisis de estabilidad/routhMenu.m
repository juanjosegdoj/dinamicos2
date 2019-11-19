limpiar
band = 1;
while band
    limpiar
    band = 1;
    disp('----------------------------------------------------------------------')
    disp('-------------------- 2. Análisis de estabilidad ----------------------')
    disp('----------------------------------------------------------------------')
    disp('--- 1. Criterio de estabilidad de Routh-Hurwitz                    ---')
    disp('--- 2. Criterio de estabilidad de Routh-Hurwitz simbólico          ---')
    disp('--- 3. Salir a MENÜ PRINCIPAL                                      ---')
    disp('----------------------------------------------------------------------')

    selection_routh = strrep(input('Ingrese el número de la sección: ', 's'), ' ', '');

    switch selection_routh

        case '1'
            disp('(Ejemplo de Polinomio característico [1 3 4 6 15 21 10])');
            polinomio = input('Ingrese el polinomio característico= ');
            routh(polinomio, 1)
            input('Pulse tecla para continuar.')

        case '2'
            syms x y z;
            disp('Tenga en cuenta que x, y and z son las variables simbólicas.')
            disp('Ejemplo de Polinomio característico = [x^2 3*y 4+x 6-z]');
            polinomio = input('Ingrese el polinomio característico= ');
            routh2(polinomio, 1)
            input('Pulse tecla para continuar.')

        case '3'
            disp('Saliendo de la sección 2. Análisis de estabilidad')
            band = 0;
    end
    
end 