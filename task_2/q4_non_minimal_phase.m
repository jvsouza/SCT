% autor: Jonas Vieira de Souza
% data: 11/09/2018
% objetivo: Comparar respostas ao degrau
close all;
clear;
clc;

% Gnm1(s)
% ---- ---- ---- ---- ---- ---- ---- ---- ---- ----
figure;
num = [2.6 -13];
den = [1 4 13];
step_detail(num, den, 0, 0.02, 4,  0.02, 1, 0);

% Gnm2(s)
% ---- ---- ---- ---- ---- ---- ---- ---- ---- ----
figure;
num = [0.1 - 1];
den = [1 3 2];
step_detail(num, den, 0, 0.02, 9,  0.02, 1, 0);