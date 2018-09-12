% autor: Jonas Vieira de Souza
% data: 11/09/2018
% objetivo: Comparar respostas ao degrau
close all;
clear;
clc;

% gza(s)
% ---- ---- ---- ---- ---- ---- ---- ---- ---- ----
num1 = 13;
den = [1 4 13];
figure;
for i = 1:8
    if (i-1) == 0
        num = num1;
    else
        num = conv([num1/(i-1)],[1 (i-1)]);
    end    
    step_detail(num, den, 0, 0.02, 3,  0.02, 1, 0);
end
text(0.6, 2.2, 'a = 1');
text(0.6, 1.5, 'a = 2');
text(0.6, 1.3, 'a = 3');
text(0.6, 0.6, 'sem zero');

% gzb(s)
% ---- ---- ---- ---- ---- ---- ---- ---- ---- ----
num1 = 9;
den = [1 2 9];
figure;
for i = 1:8
    if (i-1) == 0
        num = num1;
    else
        num = conv([num1/(i-1)],[1 (i-1)]);
    end
    step_detail(num, den, 0, 0.02, 6,  0.02, 1, 0);
end
text(0.6, 2.7, 'a = 1');
text(0.6, 1.8, 'a = 2');
text(0.6, 1.6, 'a = 3');
text(0.6, 0.8, 'sem zero');

