cargarCarpetas
while 1
    limpiar
    imprimirMenu
    seccion_select = strrep(input('Ingrese el número de la sección: ', 's'), ' ', '');

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
            
        case 'SALIR'
            disp('Programa finalizado...')
            break;

        otherwise
            disp('La opción ingresada no existe, intentelo nuevamente')
    end
    input('Pulse ENTER para continuar.')
end