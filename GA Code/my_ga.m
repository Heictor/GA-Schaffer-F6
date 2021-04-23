function [ best_fitness , elite , generation , last_generation, cost, population, custo, index, costo, pops] = my_ga ( ...
    number_of_variables , ...     % O número de parâmetros para resolver o problema
    fitness_function , ...        % Nome da função Fitness
    population_size , ...         % Tamanho daa população (número de indivíduos em cada geração)
    parent_number , ...           % Número de inivíduos mantidos em cada geração (exceto pelas mutações)
    mutation_rate , ...           % Probabilidade de mutação
    maximal_generation , ...      % maximum evolution algebra
    minimal_cost  ...             % Minímo valor de mudança (the smaller the function value, the higher the fitness)
)
format long
rng default
% Probabilidade cumulativa
% Assuming parent_number = 10
% Numerator parent_number: -1:1 is used to generate a number sequence
% Denominator sum(parent_number:-1:1) is a summation result (a number)
%
% Numerator 10 9 8 7 6 5 4 3 2 1
% Denominator 55
% Divided by 0.1818 0.1636 0.1455 0.1273 0.1091 0.0909 0.0727 0.0545 0.0364 0.0182
% Cumulative 0.1818 0.3455 0.4909 0.6182 0.7273 0.8182 0.8909 0.9455 0.9818 1.0000
%
% The result of the operation can be seen
% Cumulative probability function is a function that grows slowly from 0 to 1
% Because the probability added later is getting smaller and smaller (the sequence is arranged in descending imaginary order)
cumulative_probabilities = cumsum((parent_number:- 1 : 1 ) / sum(parent_number:- 1 : 1 )); % 1 number sequence whose length is parent_number

% Melhores fitness
% Os melhores valores de Fitness de cada geração, valor inicial definido em 1
best_fitness = 0.5*(ones(maximal_generation, 1 ));

% Elite
% Os valors de parâmetros da Elite de cada geração são iniciadas em 0
elite = zeros(maximal_generation, number_of_variables);

% Número de Crianças
% População de pais de tamanho numerado (pais são indivíduos que não mudam a cada geração)
child_number = population_size - parent_number; % Número de crianças em cada geração

% População Inicial
% population_size corresponde às linhas da matrix, cada linha representa 1 indivíduo, o número de linhas = o número de indivíuos (Número da população)
% number_of_variables corresponde às colunas da matrix, o número de colunas = número de parâmetros (individual characteristics are represented by these parameters)
population = -100 + (100+100)*rand([population_size, number_of_variables]);
%0.5 + (1+1)*
last_generation = 0; % Grava o número e gerações ao terminar o loop
pops = [];
custo = [];
costo = [];
%A próxima etapa do código será repetida dentro do loop 
for generation = 1 : 1 : maximal_generation % Ciclo da evolução inicia
    % feval traz os dados para uma function handle definida para cálculo
    % Traz a matrix da População para o cálculo da função fitness_function 
    for po = 1:1:length(population)
        pops = [pops; [population(po,1),population(po,2)]];
        costo = [costo,(0.5+((((sin (sqrt (population(po,1).^2+population(po,2).^2) )).^2) - 0.5)/(1 + 0.001*(population(po,1).^2+population(po,2).^2)).^2))];
            %feval(fitness_function, [population(po,1),population(po,2) ] ) ];
    end
    cost = feval(fitness_function, population); % Calcula o fitness (média) de todos os indivíduos (population_size*1 matrix)
    custo = [custo, cost];
    % index grava os números originais das linha para cada valor após a ordenação
    [cost, index] = sort(cost) % Ordena os valores da função fitness dos menores aos maiores
    %index tá ficando só 1x1
    % index(1:parent_number)
    % The number of rows in the population of the first parent_number individuals with a smaller cost
    % Select this part (parent_number) individuals as parents, in fact, parent_number corresponds to the cross probability
    population = population(index( 1 :parent_number), :); % First keep some of the better individuals
    % It can be seen that the population matrix is ​​constantly changing

    % cost after the previous sort sorting, the matrix has been changed to ascending order
    % cost(1) is the best fitness for this generation
    best_fitness(generation) = (1/(cost))/2; % Record the best fitness of this generation

    %The first line of population matrix is ​​the elite individuals of this generation
    elite(generation, :) = population( 1 , :); % Grava as soluções ótimas para a geração atual(elite)

    % If the optimal solution of this generation is good enough, stop evolving
    if best_fitness(generation) < minimal_cost
        last_generation = generation;
        break ;
    end
    
    % Cross mutation produces a new population

    % Chromosome crossover starts
    for child = 1 : 2 : child_number % The step size is 2 because each crossover will produce 2 children
        
        % cumulative_probabilities length is parent_number
        % Randomly select 2 parents from it (child+parent_number)%parent_number
        mother = find(cumulative_probabilities > rand, 1 ); % choose a better mother
        father = find(cumulative_probabilities > rand, 1 ); % choose a better father
        
        % ceil (ceiling) rounded up
        % rand generates a random number
        % Means that a column is randomly selected, and the value of this column is exchanged
        crossover_point = ceil(rand*number_of_variables); % randomly determine a chromosome crossover point
        
        % If crossover_point=3, number_of_variables=5
        % mask1 = 1 1 1 0 0
        % mask2 = 0 0 0 1 1
        mask1 = [ones( 1 , crossover_point), zeros( 1 , number_of_variables - crossover_point)];
        mask2 = not(mask1);
        
        % Get 4 separate chromosomes
        % Attention is.*
        mother_1 = mask1 .* population(mother, :); % The front part of the mother chromosome
        mother_2 = mask2 .* population(mother, :); % The posterior part of the mother chromosome
        
        father_1 = mask1 .* population(father, :); % The first part of the father's chromosome
        father_2 = mask2 .* population(father, :); % The latter part of the father's chromosome
        
        % Get the next generation
        population(parent_number + child, :) = mother_1 + father_2; % a child
        population(parent_number+child+ 1 , :) = mother_2 + father_1; % another child
        
    end  % end of chromosome crossover
    
    
    % Chromosome variation starts
    
    % Variation population
    mutation_population = population( 1 :population_size, :); % elites do not participate in mutation, so start from 2
    
    number_of_elements = (population_size -  1 ) * number_of_variables; % number of all genes
    number_of_mutations = ceil(number_of_elements * mutation_rate); % The number of mutated genes (total number of genes * mutation rate)
    
    % rand(1, number_of_mutations) Generate a matrix of number_of_mutations random numbers (range 0-1) (1*number_of_mutations)
    %After multiplication, each element of the matrix represents the position of the changed gene (the one-dimensional coordinate of the element in the matrix)
    mutation_points = ceil(number_of_elements * rand( 1 , number_of_mutations)); % determine the gene to be mutated
    
    % The selected genes are replaced by a random number to complete the mutation
    mutation_population(mutation_points) = rand( 1 , number_of_mutations); % Perform mutation operations on selected genes
    disp("aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa")
    population( 1 :population_size, :) = mutation_population; % population after mutation
    
    % End of chromosome variation
   
end  %The end of the evolution cycle