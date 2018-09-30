%% sobre
%
% * Autor: Jonas Vieira de Souza
% * Data: 30/09/2018
% * Objetivo: Avaliar estabilidade de sistemas
%
 
%% configura��es iniciais
% ... 
close all;
clear;
clc;

%% verificar lugar da ra�zes
% * fecha a malha entre G1(s) e G2(s)
% * mostra a equa��o caracter�stica da FTMF
% * plota o lugar das ra�zes
s = tf('s');

K = 1;                      % Ganho K
G1 = (K*(s+1)) / (s*(s+2)); % G1(s)
G2 = 1 / (s+3);             % G2(s)

% fun��o transfer�ncia de malha fechada
FTMF = feedback(G1,G2)
[nums, dens] = tfdata(FTMF,'v');

% equa��o caracter�stica
EC_FTMF = tf(dens,1)

% lugar das ra�zes
rlocus(FTMF.num,FTMF.den);
axis([-5 1 -1  1]);
grid on;