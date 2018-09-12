% autor: Jonas Vieira de Souza
% data: 11/09/2018
% objetivo: Comparar respostas ao degrau
close all;
clear;
clc;

% g(s)
% ---- ---- ---- ---- ---- ---- ---- ---- ---- ----
num = 13;

for i = 1:20
    den = conv([1 i],[1 4 13]);
    step_detail(num*i, den,   0, 0.02, 10,   0.02, 1, 0);
end

text(0.7, 1.1, 'a = 20');
text(1.1, 0.71, 'a = 2');
text(1.25, 0.55, 'a = 1');
