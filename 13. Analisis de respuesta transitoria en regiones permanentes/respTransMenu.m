limpiar
band = 1;
while band
    limpiar
    band = 1;
    disp('----------------------------------------------------------------------')
    disp('--- 13. An�lisis de respuesta transitoria en regiones permanentes  ---')
    disp('----------------------------------------------------------------------')
    disp('--- 1. Clasificaci�n del tipo de sistema                           ---')
    disp('--- 2. Error en estado estacionario                                ---')
    disp('--- 3. Respuesta transitoria VS. #muestras/ciclo                   ---')
    disp('--- 4. Salir a MEN� PRINCIPAL                                      ---')
    disp('----------------------------------------------------------------------')

    selection = strrep(input('Ingrese el n�mero de la secci�n: ', 's'), ' ', '');

    switch selection

        case '1'
            clasificadorTipoSistema
            input('Pulse tecla para continuar.')
            
        case '2'
            ERROR_EN_ESTADO_ESTACIONARIO
            input('Pulse tecla para continuar.')
            
        case '3'
            RESPUESTA_TRANSITORIA_VS_MUESTRASoCICL
            input('Pulse tecla para continuar.')
            
        case '4'
            disp('SALIENDO... de la secci�n')
            band = 0;
    end
end 