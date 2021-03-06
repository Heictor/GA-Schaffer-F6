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
           population_index,...
           population_size,...
           pop] = my_ga2 ( ...
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

cumulative_probabilities = cumsum((parent_number:- 1 : 1 ) / sum(parent_number:- 1 : 1 ));
%População Inicial

%Para população começando de forma aleatória
%population = -10 + (10+10)*rand([population_size, number_of_variables]);
% Cria uma matriz NxM, sendo N = O tamanho da população, e M = Quantidade
% de variáveis. A matriz vai ser composta de valores aleatórios entre -10 e
% 10.

%Para população de ínicio definido
population = repelem([-5.777057566444397e+06, -2.316175794493771e+07],population_size,1);
% Cria uma matriz NxM, sendo N = O tamanho da população, e M = Quantidade
% de variáveis. A matriz vai ser composta da repetição dos valores
% iniciais, ou seja, valores dos pais.

% Melhores fitness
% Os melhores valores de Fitness de cada geração, valor inicial definido em 1
first_fitness = feval('my_fitness',[-5.777057566444397e+06 -2.316175794493771e+07]);

best_fitness = [];

% Número de Crianças
% População de pais de tamanho numerado (pais são indivíduos que não mudam a cada geração)
child_number = population_size - parent_number; % Número de crianças em cada geração



%Elite
elite = 0;

generation = 0;
last_generation = 0;
cost = 0;
population_fitness = [];
index = 0;
costo = 0;
pop = [];
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
        %dentro da geração atual. Portanto este variável vai armazenar os
        %valores de fitness de toda a população de todas as gerações ao
        %longo da execução
        population_fitness = [population_fitness; feval(fitness_function, [population(k,1) population(k,2)])]; 
        [population_cost, population_index] = sort(population_fitness);
        
        % FAZER UMA MATRIZ COM VALORES MÉDIOS E PIORES VALORES DE FITNESS
        
        %Matrix que armazena os valores de fitness de cada indivíduo na
        %geração "i" atual
        generation_fitness(k,:) = feval(fitness_function, [population(k,1) population(k,2)]);
        [cost, index] = sort(generation_fitness);
        
        
          
    end
    
    %Melhor valor de fitness em cada geração 
    best_fitness = [best_fitness; cost(length(cost))];
    
    %Cruzamento das Indivíduos
    for child=1:2:child_number
        %PEGAR MÃE E PAI DOS MELHORES VALORES OU MÉDIOS
        mother = population( ceil((length(population))/2),: );
        father = population( ceil((length(population)-1)/2),: );
       
        %mother = find(cumulative_probabilities > rand, 1 ) % choose a better mother
        %father = find(cumulative_probabilities > rand, 1 ) % choose a better father

        crossover_point = ceil(rand*number_of_variables);
        mask1 = [ones( 1 , crossover_point), zeros( 1 , number_of_variables - crossover_point)];
        mask2 = not(mask1) ;
        
        % Get 4 separate chromosomes
        % Attention is.*
        %mother_1 = mask1 .* population(mother, :); % The front part of the mother chromosome
        %mother_2 = mask2 .* population(mother, :); % The posterior part of the mother chromosome
        
        %father_1 = mask1 .* population(father, :); % The first part of the father's chromosome
        %father_2 = mask2 .* population(father, :); % The latter part of the father's chromosome
        %Minha implementação
        %mask1 = [1 0];
        %mask2 = [0 1]; 
        mother_1 = mask1 .* mother; % The front part of the mother chromosome
        mother_2 = mask2 .* mother; % The posterior part of the mother chromosome
         
        father_1 = mask1 .* father; % The front part of the mother chromosome
        father_2 = mask2 .* father; % The posterior part of the mother chromosome 
       
        population(parent_number + child, :) = mother_1 + father_2; % a child
        population(parent_number+child+ 1 , :) = mother_2 + father_1;
    end    
    
    % Chromosome variation starts
    % Variation population
    mutation_population = population( 2 :population_size, :); % elites do not participate in mutation, so start from 2
    
    number_of_elements = (population_size -  1 ) * number_of_variables; % number of all genes that may be muted
    number_of_mutations = ceil(number_of_elements * mutation_rate); % The number of mutated genes (total number of genes * mutation rate)
    
    % rand(1, number_of_mutations) Generate a matrix of number_of_mutations random numbers (range 0-1) (1*number_of_mutations)
    %After multiplication, each element of the matrix represents the position of the changed gene (the one-dimensional coordinate of the element in the matrix)
    mutation_points = ceil(number_of_elements * rand( 1 , number_of_mutations)); % determine the gene to be mutated
    
    % The selected genes are replaced by a random number to complete the mutation
    mutation_population(mutation_points) = rand( 1 , number_of_mutations);
    
    population( 2 :population_size, :) = mutation_population % population after mutation
    
%   % Variation population
%   mutation_population = population( 1 :population_size, :); % elites do not participate in mutation, so start from 2
%    
%   number_of_elements = (population_size ) * number_of_variables; % number of all genes
%   number_of_mutations = ceil(number_of_elements * mutation_rate); % The number of mutated genes (total number of genes * mutation rate)
%   
%   % rand(1, number_of_mutations) Generate a matrix of number_of_mutations random numbers (range 0-1) (1*number_of_mutations)
%   %After multiplication, each element of the matrix represents the position of the changed gene (the one-dimensional coordinate of the element in the matrix)
%   mutation_points = ceil(number_of_elements * rand( 1 , number_of_mutations)); % determine the gene to be mutated
%     
%   % The selected genes are replaced by a random number to complete the mutation
%   mutation_population(mutation_points) = rand( 1 , number_of_mutations); % Perform mutation operations on selected genes
%   population( 1 :population_size, :) = mutation_population
    %Atualização da População
    
    %population = 0.5 + (1+1)*rand([population_size, number_of_variables]);
    %population = population+(0.01+(0.01+0.01)*rand)
    
    
    
    
    
    
    
end
%disp("A tabela abaixo exibe informações sobre as variáveis utilizadas");
%whos;
% generation_fitness = population_fitness(i-3:i,1);
% [cost, index] = sort(generation_fitness);
