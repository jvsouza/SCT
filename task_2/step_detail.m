% autor: Jonas Vieira de Souza
% data: 06/09/2018
% referencia: ...
% objetivo: ...

function [ y_ss, t_p, t_a, t_s, leg_r ] = step_detail( num, den,    from, step, to,    margem, plotar, legendas, v_leg )

    % avaliar argumentos
    % ----- ----- ----- ----- ----- -----
    if( nargin < 8 ) legendas = 1;  end;
    if( nargin < 7 ) plotar = 1;    end;
    if( nargin < 6 ) margem = 0.02; end;
    if( nargin < 5 ) to = 10;       end;
    if( nargin < 4 ) step = 0.01;   end;
    if( nargin < 3 ) from = 0;      end;
    if( nargin < 2 ) den = [1 + 2]; end;
    if( nargin < 1 ) num = 1;       end;

    disp('arg.s: [num, den, from, step, to, margem, plotar, legendas]');
    disp('return.s: [y_so.si, t_pico, t_subida, t_acomodacao]');

    t = from:step:to;
    u = ones(1, length(t));

    sys = tf(num, den)
    y = lsim(sys, u, t);
    [m t1] = max(y);

    % mp | y_ss - maximo_sobressinal
    % ---- ---- ---- ---- ---- ---- ---- ----
    mp = m - 1;
    tp = (t1 - 1) * step;

    % tr | t_s - tempo_subida
    % ---- ---- ---- ---- ---- ---- ---- ----
    y_f = y(length(t));
    y_90p = y_f * 0.9;
    y_10p = y_f * 0.1;

    i = 1;
    if tp == to
        tr = 0;
    else  
        while(y(i) < y_10p)
            i = i + 1;
        end
        r1 = i;
        while(y(i) < y_90p)
            i = i + 1;
        end
        tr = (i-r1) * step;
    end

    % ts | t_a - tempo_acomodacao
    % ---- ---- ---- ---- ---- ---- ---- ----
    y_mfp = y_f * ( 1 + margem );
    y_mfn = y_f * ( 1 - margem );
    t_ay = 0;
    t_ax = 0;

    for i = length(t):-1:1
        if( y(i) < y_mfn | y(i) > y_mfp )
            t_ay = y(i);
            t_ax = t(i);
            break;
        end
    end
    ts = (i - 1) * step;
    
    % gráfico
    % ---- ---- ---- ---- ---- ---- ---- ----
    if plotar == 1
        hold on;
        p = plot(t, y, 'LineWidth', 1 );
        %set(gca,'color',[0 0 0]);
        set(gcf,'color','w');
        title('resposta ao degrau unitário');
        ylabel('saída');
        xlabel('t(s)');
        %grid on;
        %grid minor;
        hold on;

        if legendas == 1
            n_string = { '......y(\infty)', '......OS', '......tp', '......tr', '......tac', '......m+', '......m-'};
            %n_string = { sprintf('\t\t inf'), sprintf('\t\t tmp'), sprintf('\t\t tp'), sprintf('\t\t tr'), sprintf('\t\t ts'), sprintf('\t\t m+'), sprintf('\t\t m-')};

            % mp | y_ss - maximo_sobressinal
            plot([0 tp],  [m m],            '--r*', 'LineWidth',2);
            text(tp, m, 'OS');
            
            % tp | t_p - tempo_pico
            plot([tp tp], [0 m],            '--g*', 'LineWidth',2);
            text(tp, 0, 't.pk');
            
            % td, metade do yf
            plot([tr tr], [0 y_f*0.5],      '--k*', 'LineWidth',2);
            text(tr, 0, 'tr');

            % ts | t_a - tempo_acomodacao
            plot([t_ax t_ax], [0 t_ay],     '--c*', 'LineWidth',2);
            text(ts, 0, 't.ac');

            % margem superior
            plot([0 to],  [y_mfp y_mfp],    '--m*', 'LineWidth',2);
            text(ts+2, y_mfp, 'margem (+)');

            % margem inferior
            plot([0 to],  [y_mfn y_mfn],    '--y*', 'LineWidth',2);
            text(ts+2, y_mfn, 'margem (-)');

            n_coef = [y_f, mp, tp, tr, ts, y_mfp, y_mfn];
            s1 = strcat( n_string(:), ' = '     );
            s2 = strcat( s1(:)      , num2str(n_coef(:)) );
            leg_r = strcat( v_leg, s2 );
            legend( leg_r );
        end
        hold off
    end

    grid on;   
    y_ss = 0;
    t_p = 0;
    t_a = 0;
    t_s = 0; 
end

% [ y_ss, t_p, t_a, t_s ] = resp_deg(100, [1 15 100], 0,0.02, 2, 0.2, 1, 1)
