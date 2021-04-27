clc; 
% close all;
% clear all;
% format long
% rng default
[best_fitness ,...
 elite , ...
 generation ,...
 last_generation,...
 cost,...
 population,...
 population_fitness,...
 index,...
 costo,...
 generation_fitness,...
 population_cost,...
 population_index] = my_ga2 ( ...
    2 ,... %Número de Variáveis
    'my_fitness' ,... %Função Fitness
    4 ,... %Tamanho da população
    1 ,... %Número de pais que permanecerão na próxima geração
    0.01 ,... %Taxa de Mutação
    10 ,... %Máximo de Gerações
    1.0e-6... %Custo minímo de evolução
);

for i = 1:4:length(population_fitness)
    [population_fitness(i,:);population_fitness(i+1,:);population_fitness(i+2,:);population_fitness(i+3,:)];
    
end

%% Gráfico para os valores e Fitness ao longo das gerações
% figure(1)
% hold on
% gera = 1:1:40;
% plot(gera, population_fitness)
% grid on
% hold off

%% Gráfico para os valores e Fitness ao longo das gerações
% figure(2)
% hold on
% gera = 1:1:10;
% scatter(gera, best_fitness)
% grid on
% hold off



