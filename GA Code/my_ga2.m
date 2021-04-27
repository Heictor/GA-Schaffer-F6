%#ok<*INUSD>
function [ best_fitness ,...
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
    number_of_variables , ...     % O número de parâmetros para resolver o problema
    fitness_function , ...        % Nome da função Fitness
    population_size , ...         % Tamanho daa população (número de indivíduos em cada geração)
    parent_number , ...           % Número de inivíduos mantidos em cada geração (exceto pelas mutações)
    mutation_rate , ...           % Probabilidade de mutação
    maximal_generation , ...      % maximum evolution algebra
    minimal_cost  ...             % Minímo valor de mudança (the smaller the function value, the higher the fitness)
) 

% format long
% rng default
%% Criação das Variáveis Iniciais

%População Inicial

%Para população começando de forma aleatória
%population = -10 + (10+10)*rand([population_size, number_of_variables]);
% Cria uma matriz NxM, sendo N = O tamanho da população, e M = Quantidade
% de variáveis. A matriz vai ser composta de valores aleatórios entre -10 e
% 10.

%Para população de ínicio definido
population = repelem([-5.777057566444397e+06, -2.316175794493771e+07],4,1);
% Cria uma matriz NxM, sendo N = O tamanho da população, e M = Quantidade
% de variáveis. A matriz vai ser composta da repetição dos valores
% iniciais, ou seja, valores dos pais.

% Melhores fitness
% Os melhores valores de Fitness de cada geração, valor inicial definido em 1
first_fitness = feval('my_fitness',[-5.777057566444397e+06 -2.316175794493771e+07]);

best_fitness = [];


%Elite
elite = 0;

generation = 0;
last_generation = 0;
cost = 0;
population_fitness = [];
index = 0;
costo = 0;

generation_fitness = [];
population_cost = [];
population_index = [];

%%
% Loop For da primeira geração até a última
for i = 1:1:maximal_generation
    %O próximo Loop For irá chegar cada indivíduo dentro a geração "i"
    %atual e salvar os valores de fitness eles
    for k = 1:1:population_size
        %population_size irá salvar os valores de fitness de cada indivíduo
        %dentro da geração atual. Portanto este variável vai armazenar o 
        population_fitness = [population_fitness; feval(fitness_function, [population(k,1) population(k,2)])]; 
        [population_cost, population_index] = sort(population_fitness);
        
        generation_fitness(k,:) = feval(fitness_function, [population(k,1) population(k,2)]);
        [cost, index] = sort(generation_fitness);
        
        
          
    end
    
    best_fitness = [best_fitness; cost(4)]
    
    %Atualização da População
    population = 0.5 + (1+1)*rand([population_size, number_of_variables]);
    
    
    
    
    
    
    
end
% generation_fitness = population_fitness(i-3:i,1);
% [cost, index] = sort(generation_fitness);
