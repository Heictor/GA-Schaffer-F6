%% Rotina Principal
%Ajeitar orientação do gráfico
%Fazer progressão dos gráficos da dsitribuição da população 
clc, clear, close all
format long;
rng default % Aprimorar aleatoriedade

%% Chamada da Função Fitness no GA
FitFcn = @myFitness; %Chamada da função

nvars = 2; %Número de variáveis

lb=-100; %Limite Inferior (Lower Boundary)
ub=100; %Limite Superior  (Upper Boundary)

DPopInicial = 0.1; % Dispersão da população inicial
Muta = 0.01; % Taxa Mutação

%% Possibilidades de funções de mutação
% 'MutationFcn',{@mutationgaussian DPopInicial Muta},...
% 'MutationFcn',{@mutationadaptfeasible 1},...

%%
%@gaplotgenealogy
options = optimoptions('ga',...
    'MutationFcn',{@mutationgaussian DPopInicial Muta},...
    'PlotFcn',{@gaplotdistance,@gaplotrange,@gaplotscorediversity,@gaplotscores,@gaplotselection,@gaplotbestf},...
    'MaxStallGenerations',200,...
    'MaxGenerations',100,...
    'CrossoverFraction',0.75,... %Taxa de Cruzamento
    'PopulationSize',100,... % Quantidade de Indíviduos
    'FunctionTolerance',0); 

% FunçãoGa = ga(fun,nvars,A,b,Aeq,beq,lb,ub,nonlcon,options)
[T, fval,exitflag,output,population,scores] = ga(FitFcn,nvars,[],[],[],[],lb,ub,[],options);

%% Utilização da Expressão Simbólica

% syms x
% y = 0.5-((((sin (sqrt (x.^2+x.^2) )).^2) - 0.5)/(1 + 0.001.*(x.^2+x.^2)).^2);

% figure(1)
% hold on
% fplot(y,[-100 100])
% plot(T(1),fval,'->')
% plot(T(2),fval,'<-')
% grid on
% hold off

