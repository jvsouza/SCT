%% sobre
%
% * Autor: Jonas Vieira de Souza
% * Data: 11/09/2018
% * Objetivo: Comparar respostas ao degrau
%
 
%% configurações iniciais
% ... 
close all;
clear;
clc;
s = tf('s');

%% g(s)
% ... 
num = 13;
for i = 1:20
    den = ((s + i)*(s^2 + 4*s + 13));
    step(num*i/den);
    hold on;
end
text(0.7, 1.1, 'a = 20');
text(1.1, 0.71, 'a = 2');
text(1.25, 0.55, 'a = 1');
title('respostas ao degrau');
xlabel('t');
ylabel('amplitude');
grid on;
