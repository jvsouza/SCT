//  aluno:  Jonas Vieira de Souza
//  data:   05/09/2018
//  ação:   ...
// ----- ----- ----- ----- ----- -----

clc;
clear;
mode(0);
xdel(winsid());

s  = %s;
False = %f;

// ...
// ----- ----- ----- ----- ----- -----    
function [ mp, tp, tr, ts ] = ...
resp_deg( num, den, from, step, to, margem, plotar, legendas )
//xdel(winsid());

    if( argn(2) < 8 ) legendas = %t; end;
    if( argn(2) < 7 ) plotar = %t;   end;
    if( argn(2) < 6 ) margem = 0.02; end;
    if( argn(2) < 5 ) to = 10;       end;
    if( argn(2) < 4 ) step = 0.01;   end;
    if( argn(2) < 3 ) from = 0;      end;
    if( argn(2) < 2 ) den = s + 2;   end;
    if( argn(2) < 1 ) num = 1;       end;
    
    //disp('arg.s: [num, den, from, step, to, margem, plotar, legendas]');
    //disp('return.s: [y_so.si, t_pico, t_subida, t_acomodacao]');
    
    t = from:step:to;
    u = ones(1, length(t));

    tf = num/den;
    G = syslin('c', tf);
    y = csim(u, t, G);
    
    [m t1] = max(y);
    // tp | t_p - tempo_pico
    // ---- ---- ---- ---- ---- ---- ---- ----

    // mp | y_ss - maximo_sobressinal
    // ---- ---- ---- ---- ---- ---- ---- ----
    mp = m - 1;
    tp = (t1 - 1) * step;

    // tr | t_s - tempo_subida
    // ---- ---- ---- ---- ---- ---- ---- ----
    y_f = y(length(t));
    y_90p = y_f * 0.9
    y_10p = y_f * 0.1

    i = 1;
    if tp == to then 
        tr = %nan; 
    else  
        while(y(i) < y_10p) then
            i = i + 1;
        end
        r1 = i;
        while(y(i) < y_90p) then
            i = i + 1;
        end
        tr = (i-r1) * step;
    end

    // ts | t_a - tempo_acomodacao
    // ---- ---- ---- ---- ---- ---- ---- ----
    y_mfp = y_f * ( 1 + margem );
    y_mfn = y_f * ( 1 - margem );
    t_ay = 0;
    t_ax = 0;

    for i = length(t):-1:1
        if( y(i) < y_mfn | y(i) > y_mfp ) then
            t_ay = y(i);
            t_ax = t(i);
            break;
        end
    end
    ts = (i - 1) * step;

    // janela aberta na esqueda em cima!
    f = get("current_figure")
    f.figure_position = [0, 0]; 

    if plotar ~= %f then
        colordef("white");
        plot(t, y);
        xtitle('resposta ao degrau unitário');
        ylabel("saída");
        xlabel("t(s)");
        xgrid(color('gray'));

        if legendas ~= %f then
            n_string = ['', 'mp', 'tp', 'tr', 'ts','m+','m-'];
            
            // mp | y_ss - maximo_sobressinal
            plot([0 tp],  [m m],            '--r*');
            xstring(tp, m, 'y.ss');
            
            // tp | t_p - tempo_pico
            plot([tp tp], [0 m],            '--g*');
            xstring(tp, 0, 't.pico');

            // td, metade do yf
            plot([tr tr], [0 y_f*0.5],      '--k*'); 
            xstring(tr, 0, 'tr');

            // ts | t_a - tempo_acomodacao
            plot([t_ax t_ax], [0 t_ay],          '--c*');
            xstring(ts, 0, 't.acomodação');

            plot([0 to],  [y_mfp y_mfp],    '--m*');
            xstring(ts+2, y_mfp, 'margem (+)');

            plot([0 to],  [y_mfn y_mfn],    '--y*');
            xstring(ts+2, y_mfn, 'margem (-)');

            n_coef = [y_f, mp, tp, tr, ts,y_mfp,y_mfn];
            legend( string(n_string(:)) + ' = ' + string(n_coef(:)) );

        end // fim das legendas

    end // fim do gráfico

end // fim da função

// exemplo de chamda de função
// -----------------------------------------------------
//[y_ss, t_p, t_s, t_a] = resp_deg(30, s^2 + 30*s + 30, 0, 0.02, 20,  0.02 );

f1 = scf(1);
f2 = scf(2);

mat = zeros(3,5);
t = 0:0.01:3;

for i = 1:3
    if i == 1 then
        num = 24.542;
        den = (s^2 + 4*s + 24.542);
        c1 = roots(den)
        [y_ss, t_p, t_s, t_a] = resp_deg(num, den, 0, 0.02, 3,  0.02, False );
        mat(1,:) = [0, y_ss, t_p, t_s, t_a];
    elseif i == 2 then
        num = 245.24;
        den = (s + 10)*(s^2 + 4*s + 24.542);
        c2 = roots(den)
        [y_ss, t_p, t_s, t_a] = resp_deg(num, den, 0, 0.02, 3,  0.02, False );
        mat(2,:) = [10, y_ss, t_p, t_s, t_a];
    else
        num = 73.626;
        den = (s +  3)*(s^2 + 4*s + 24.542);
        c3 = roots(den)
        [y_ss, t_p, t_s, t_a] = resp_deg(num, den, 0, 0.02, 3,  0.02, False );
        mat(3,:) = [3, y_ss, t_p, t_s, t_a];
    end

    scf(1);
    ft  = syslin( 'c', num, den );
    g = csim('step',t, ft);
    plot2d(t, g);

    scf(2);
    evans(ft)
    xgrid;
end

e = gce();
e.legend_location = "in_upper_left";
e.text = ["direção assintótica"; "raízes"];
e.background = 34;
xlabel('Eixo Real');
ylabel('Eixo Imaginário');
title("Lugar da raízes");
sgrid([0.1:0.1:0.9], [1:1:6], 60);
mtlb_axis([-11 1 -6 6]);

scf(1);
xtitle('resposta ao degrau unitário');
ylabel("saída");
xlabel("t(s)");
legend('c1','c2','c3');
xgrid();
f1.background = 34;

disp(['3p', 'y_ss', 't_p', 't_s', 't_a']);
disp(mat);


