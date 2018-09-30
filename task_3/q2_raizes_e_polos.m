%% sobre
%
% * Autor: Jonas Vieira de Souza
% * Data: 30/09/2018
% * Objetivo: Avaliar estabilidade de sistemas
%
 
%% configura��es iniciais
% limpar figuras, vari�veis e console
close all;
clear;
clc;

%% verificar ra�zes e polos
% * varia o ganho K
% * fecha a malha entre G1(s) e G2(s)
% * tabula as ra�zes
% * compara os polos no plano s
s = tf('s');
den1 = (s^3 + 2*s^2 + 4*s);
G1 = 1/den1;
G2 = 1;

% vetor de ganho k
k_start = 1;
k_step  = 1;
k_last  = 20;
k_size  = ((k_last-k_start)/k_step) + 1;
k_array = k_start:k_step:k_last;

% tabela de armazenamento das ra�zes
table_raizes =  cell2table(     ...
                    cell(k_size,4), ...
                    'VariableNames', {'k', 'raiz_real', 'raiz_compl_SPS', 'raiz_compl_SPI'} ...
                );

fprintf('processando');        
for i = 1:(k_size)
    fprintf('.');
    G1 = k_array(i)/den1;
    sys = feedback(G1,G2);
    [nums,dens] = tfdata(sys,'v');
    
    % ra�zes da equa��o caracter�stica
    raizes_ec = roots(dens);    
    table_raizes.k{i} =  k_array(i);
    
    % ajustar ordem dos resultados
    if imag( raizes_ec(3,1) ) == 0
        table_raizes.raiz_real{i} = raizes_ec(3,1);
        table_raizes.raiz_compl_SPS{i} = raizes_ec(1,1);    
        table_raizes.raiz_compl_SPI{i} = raizes_ec(2,1);
    else
        table_raizes.raiz_real{i} = raizes_ec(1,1);
        table_raizes.raiz_compl_SPS{i} = raizes_ec(2,1);
        table_raizes.raiz_compl_SPI{i} = raizes_ec(3,1);
    end
    
    % agregar polos no plano S
    rlocusplot(sys);
    hold on;    
end

% zoom na regi�o de an�lise no gr�fico
axis([-4 2 -4  4]);
grid on;

% apresentar ra�zes das equa��es caracter�sticas
table_raizes(1:k_size,:)