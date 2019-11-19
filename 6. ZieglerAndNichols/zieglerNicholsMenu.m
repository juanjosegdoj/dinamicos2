limpiar
band = 1;
while band
    limpiar
    band = 1;
    disp('----------------------------------------------------------------------')
    disp('--- 6. Reglas de Ziegler-Nichols para sintonizar controladores PID ---')
    disp('----------------------------------------------------------------------')
    disp('--- 1. Primer método de Z-N; Curva de Reacción                     ---')
    disp('--- 2. Segundo método de Z-N; Oscilación Continua                  ---')
    disp('--- 3. Salir a MENÜ PRINCIPAL                                      ---')
    disp('----------------------------------------------------------------------')

    selection = strrep(input('Ingrese el número de la sección: ', 's'), ' ', '');

    switch selection

        case '1'
            TABLA_1_METODO_z_n
            input('Pulse tecla para continuar.')
        case '2'
            TABLA_2_METODO_z_n
            input('Pulse tecla para continuar.')
        case '3'
            disp('Saliendo de la sección 2. Análisis de estabilidad')
            band = 0;
    end
end 