%% Tarefa 2
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

%% Plotagem do Gráfico 3D da função com pontos ótimos
figure(2)
hold on
x = -100:.1:100;
y = -100:.1:100;
[x,y] = meshgrid(x,y);

f = (0.5 - (((sin (sqrt (x.^2+y.^2) )).^2) - 0.5)./(1 + 0.001.*(x.^2+y.^2)).^2);

surfc(x,y,f,'EdgeColor','none');
colorbar;

scatter3(T(1),T(2),-1*fval,'d','k');
%contour(x,y,f,'--');
%scatter3(T(2),T(2),-fval,'o');
% text(-T(1),-fval, 'T(1) \rightarrow ', ...
%     'Color', 'blue', ...
%     'HorizontalAlignment', 'right', ...
%     'FontSize',14,'Units', 'data');
% text(T(2),fval, '\leftarrow T(2)', ...
%     'Color', 'red', ...
%     'HorizontalAlignment', 'left', ...
%     'FontSize',14,'Units', 'data');
legend('Função F6','Curvas de Nível','Ótimo Global')
grid on
hold off

figure(3)
hold on
fun = [];

t1 = (population(:,1));
t2 = (population(:,2));
for i = (1:1:100)
    tt1 = t1(i);
    tt2 = t2(i);
    f = (0.5 - (((sin (sqrt (t1(i).^2+t2(i).^2) )).^2) - 0.5)./(1 + 0.001.*(t1(i).^2+t2(i).^2)).^2);
    fun = [fun,f];
end

x = -100:.1:100;
y = -100:.1:100;
[x,y] = meshgrid(x,y);
f = (0.5 - (((sin (sqrt (x.^2+y.^2) )).^2) - 0.5)./(1 + 0.001.*(x.^2+y.^2)).^2);

surfc(x,y,f,'EdgeColor','none');
scatter3(t1,t2,fun,100,'*','r');
% colorbar;
% 
% scatter3(T(1),T(2),-1*fval,'d','k');
legend('Função F6','Curvas de Nível','Soluções Locais')
grid on
hold off
% figure(3)
% media = [];
% hold on
% t1 = abs(population(:,1));
% t2 = abs(population(:,2));
% for i=(1:1:100)
%     pop = (t1(i)+t2(i))/2;
%     media = [media, pop];
% end
% pop = 1:1:100;
% scatter(pop,flip(-scores))
% %scatter(pop,media(:))
% grid on
% hold off