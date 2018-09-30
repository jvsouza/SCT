%% sobre
%
% * Autor: Jonas Vieira de Souza
% * Data: 27/09/2018
% * Objetivo: Comparar respostas ao degrau
%
 
%% configurações iniciais
% ... 
close all;
clear;
clc;
s = tf('s');

%% Questão 1
% ...  
num1 = ( s + 3 );
den1 = ( s * ( s + 1 ) * ( s^2 + 4*s + 16) );
%tf( den1 ) % [ 4 5 20 16 0 ]
roots_1 = roots( [ 1 5 20 16 0 ] )
G1 = num1 / den1
figure(1);
rlocus(num1,den1);
v = [-6 6 -6  6];
axis(v);
grid on;

%% Questão 2
% Determinar os pólos de MA e tracar o L.R.s
num2 = ( 1 );
den2 = ( s * ( s + 0.5 ) * ( s^2 + 0.6*s + 10) );
tf( den2 ) % [ 1 1.1 10.3 5 0 ]
roots_2 = roots( [ 1 1.1 10.3 5 0 ] )
G2 = num2 / den2
figure(2);
subplot(1,2,1);
rlocus(num2,den2);
axis([-6 6 -6  6]);
grid on;

% margin % para determinar o ganho

%% Questão 3
% Desenhar as curvas de auxilio no plano complexo para o lugar das raízes
subplot(1,2,2);
rlocus(num2,den2);
ae  = [ 0.1, 0.25, 0.5, 0.77, 0.9 ];
awn = [  0.6,   1.2,  1.8,   2.4, 3.0, 3.6  ];
sgrid( ae, awn );