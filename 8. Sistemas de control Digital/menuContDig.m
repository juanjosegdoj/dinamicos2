limpiar
band = 1;
while band
    limpiar
    band = 1;
    disp('----------------------------------------------------------------------')
    disp('--- 7. Sistemas de control Digital                                 ---')
    disp('----------------------------------------------------------------------')
    disp('--- 1. FDT discreta en lazo abierto, con UN muestreador            ---')
    disp('--- 2. FDT discreta en lazo abierto, con DOS muestreador           ---')
    disp('--- 3. FDT discreta en lazo cerrado, con UN muestreador            ---')
    disp('--- 4. FDT discreta en lazo cerrado, con DOS muestreador           ---')
    disp('--- 5. Salir a MENÜ PRINCIPAL                                      ---')
    disp('----------------------------------------------------------------------')

    selection = strrep(input('Ingrese el número de la sección: ', 's'), ' ', '');

    switch selection

        case '1'
            ej1UnMuestreadoresLA
            input('Pulse tecla para continuar.')
        case '2'
            ej1DosMuestreadoresLA
            input('Pulse tecla para continuar.')
        case '3'
            ej1UnMuestreadoresLC
            input('Pulse tecla para continuar.')
        case '4'
            disp('NOTA: Recuerde que para ')
            ej1DosMuestreadoresLC
            input('Pulse tecla para continuar.')
        case '5'
            disp('Saliendo de la sección 2. Análisis de estabilidad')
            band = 0;
    end
end 