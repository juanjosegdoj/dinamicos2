limpiar
band = 1;
while band
    limpiar
    band = 1;
    disp('----------------------------------------------------------------------')
    disp('--- 6. Reglas de Ziegler-Nichols para sintonizar controladores PID ---')
    disp('----------------------------------------------------------------------')
    disp('--- 1. Primer m�todo de Z-N; Curva de Reacci�n                     ---')
    disp('--- 2. Segundo m�todo de Z-N; Oscilaci�n Continua                  ---')
    disp('--- 3. Salir a MEN� PRINCIPAL                                      ---')
    disp('----------------------------------------------------------------------')

    selection = strrep(input('Ingrese el n�mero de la secci�n: ', 's'), ' ', '');

    switch selection

        case '1'
            TABLA_1_METODO_z_n
            input('Pulse tecla para continuar.')
        case '2'
            TABLA_2_METODO_z_n
            input('Pulse tecla para continuar.')
        case '3'
            disp('Saliendo de la secci�n 2. An�lisis de estabilidad')
            band = 0;
    end
end 