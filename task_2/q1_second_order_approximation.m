% autor: Jonas Vieira de Souza
% data: 11/09/2018
% objetivo: Comparar respostas ao degrau
close all;
clear;
clc;

% parametros comuns
% ---- ---- ---- ---- ---- ---- ---- ---- ---- ----
tf_size = 2;
from = 0;
step = 0.02
margem = 0.2
plotar = 1;
legendar = 1;

% g1(s) e g1aprox.(s)
% ---- ---- ---- ---- ---- ---- ---- ---- ---- ----
v_num = [700; 700/15];
v_den = [ conv([1 15],[1 4 100]) ; [0 1 4 100] ]
to = 3;

% execução ...
% ---- ---- ---- ---- ---- ---- ---- ---- ---- ----
v_legends = '';
figure;
for i=1 : tf_size
    v_num2 = v_num(i,:);
    v_den2 = v_den(i,:);
    [ yss, tp, ta, ts, leg ] = step_detail( v_num2, v_den2,   from, step, to,    margem, plotar, legendar, v_legends );
    v_legends = strcat( v_legends, leg );
end

% g2(s) e g2aprox.(s)
% ---- ---- ---- ---- ---- ---- ---- ---- ---- ----
tf_size = 2;
v_num = [360; 360/4];
v_den = [ conv([1 4],[1 2 90]) ; [0 1 2 90]    ];
to = 6;

% execução ...
% ---- ---- ---- ---- ---- ---- ---- ---- ---- ----
v_legends = '';
figure;
for i=1 : tf_size
    v_num2 = v_num(i,:);
    v_den2 = v_den(i,:);
    [ yss, tp, ta, ts, leg ] = step_detail( v_num2, v_den2,   from, step, to,    margem, plotar, legendar, v_legends );
    v_legends = strcat( v_legends, leg );
end