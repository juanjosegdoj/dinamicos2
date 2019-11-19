limpiar
band = 1;
while band
    limpiar
    band = 1;
    disp('----------------------------------------------------------------------')
    disp('--- 13. Análisis de respuesta transitoria en regiones permanentes  ---')
    disp('----------------------------------------------------------------------')
    disp('--- 1. Clasificación del tipo de sistema                           ---')
    disp('--- 2. Error en estado estacionario                                ---')
    disp('--- 3. Respuesta transitoria VS. #muestras/ciclo                   ---')
    disp('--- 4. Salir a MENÜ PRINCIPAL                                      ---')
    disp('----------------------------------------------------------------------')

    selection = strrep(input('Ingrese el número de la sección: ', 's'), ' ', '');

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
            disp('SALIENDO... de la sección')
            band = 0;
    end
end 