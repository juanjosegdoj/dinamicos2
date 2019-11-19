limpiar
disp('----------------------------------------------------------------------')
disp('------------------ 3. Reglas construcción del LGR. -------------------')
disp('----------------------------------------------------------------------')
disp('---                  Lugar Geométrico de la Raiz                   ---')
disp('----------------------------------------------------------------------')

num = input('Introduzca entre corchetes los coeficientes del numerador num= '); 
den = input('Introduzca entre corchetes los coeficientes del denominador den= ');
rlocus(num, den); % Muestra la gráfica del LGR
hold on % Este comando retiene la gráfica; si se desea, es posible
% empalmar gráficas adicionales: semicírculos asociados con wn y
% rectas a ciertos ángulos relacionadas con amortiguamientos
G = tf(num, den); % Conversión de (num,den ) a función racional
k = 0:0.01:40; % Rango e intervalo de variaciones de ganancia K
rlocus(G, k)
hold on

ponerPunto = input('Ingrese 1, si desea posicionar el cursor sobre un punto específico del LGR: ');

if ponerPunto
    M = input('Introduzca el valor del sobreimpulso M= ');
    ts = input('Introduzca el valor del tiempo de establecimiento ts= ');
    z = -log(M) / sqrt(pi^2 + (log(M)^2));
    Wn = 1.87 / ts;
    %Wn = input('Introduzca el valor de la frecuencia no amortiguada Wn=');

    axis([-4 0.1 -3 3]) % Personalización de ejes
    % Traza sobre el LG una recta con ángulo beta asociada a z
    plot([0 -3.5*z], [0 3.5*sqrt(1-z^2)], [0 -3.5*z], [0 -3.5*sqrt(1-z^2)],'linewidth', 4)
    sgrid(z, Wn)
    [k,poles] = rlocfind(num,den);

    % Posicionamiento del cursor sobre un punto especifico del LGR
    [numLC, denLC] = cloop(k*num, den, -1);
    printsys(numLC, denLC)
    hold off % Desactiva hold on, ya que se mostrará una gráfica en
    % referencia distinta al plano S, es decir, el dominio tiempo
    step(numLC, denLC) % respuesta al escalón
    grid
end
