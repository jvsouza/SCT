% autor: Jonas Vieira de Souza
% data: 11/09/2018
% objetivo: Comparar respostas ao degrau
close all;
clear;
clc;

% polo -3.5
% ---- ---- ---- ---- ---- ---- ---- ---- ---- ----
num = [26.25  105];
den = [1 14.5 68.5 105];
step_detail(num, den,   0, 0.02, 3,   0.02, 1, 0, 0);

% polo -4.01
% ---- ---- ---- ---- ---- ---- ---- ---- ---- ----
den = [1 15.01 74.11 120.3];
step_detail(num, den,   0, 0.02, 3,   0.02, 1, 0, 0);

% polo -4.1
% ---- ---- ---- ---- ---- ---- ---- ---- ---- ----
den = [1 15.1 75.1 123];
step_detail(num, den,   0, 0.02, 3,   0.02, 1, 0, 0);

% polo -4
% ---- ---- ---- ---- ---- ---- ---- ---- ---- ----
num = [26.25];
den = [1 11 30];
step_detail(num, den,   0, 0.02, 3,   0.02, 1, 0, 0);
legend('Gpz1(s)','Gpz2(s)','Gpz3(s)','Gpz4(s)');
