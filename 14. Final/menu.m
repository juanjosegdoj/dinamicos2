cargarCarpetas
while 1
    limpiar
    imprimirMenu
    seccion_select = strrep(input('Ingrese el n�mero de la secci�n: ', 's'), ' ', '');

    switch seccion_select
        case '1'
            reducirMenu
        case '2'
            routhMenu
        case '3'
            LGR_InterfazDeUsuario
        case '4'
            controladoresAnalogosMenu
        case '5'
            disp('El parcial fue desarrollado usando simulink, por ese motivo, no sera ejecutado en este programa.')
        case '6'
            zieglerNicholsMenu
        case '7'
            fdt_discreta
        case '8'
            sistemaControlDigital
        case '9'
            estabStmDiscreto
        case '10'
            ejercicio1
        case '11'
            METODO_DE_JURY
        case '12'
            ROUTH_HURWITZ_MODIFICADO
        case '13'
            respTransMenu
            
        case 'SALIR'
            disp('Programa finalizado...')
            break;

        otherwise
            disp('La opci�n ingresada no existe, intentelo nuevamente')
    end
    input('Pulse ENTER para continuar.')
end