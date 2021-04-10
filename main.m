%%main
clc, clear, close all
format long;

%% Utilização da Função Fitness no GA
FitFcn = @myFitness; %Função chamada
nvars = 2; %Número de variáveis
lb=-100; %Limite Inferior (Lower Boundary)
ub=100; %Limite Superior  (Upper Boundary)
[T, fval] = ga(FitFcn,nvars,[],[],[],[],lb,ub)

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

%% Plotagem do Gráfico 3D da função com pontos ótimos
figure(2)
hold on
x = -100:.1:100;
y = -100:.1:100;
[x,y] = meshgrid(x,y);

f = 0.5 - (((sin (sqrt (x.^2+y.^2) )).^2) - 0.5)./(1 + 0.001.*(x.^2+y.^2)).^2;

mesh(x,y,f);
colorbar;

plot(T(1),fval,'o');
plot(T(2),fval,'o');
text(T(1),fval, 'T(1) \rightarrow ', ...
    'Color', 'blue', ...
    'HorizontalAlignment', 'right', ...
    'FontSize',14,'Units', 'data');
text(T(2),fval, '\leftarrow T(2)', ...
    'Color', 'red', ...
    'HorizontalAlignment', 'left', ...
    'FontSize',14,'Units', 'data');
grid on
hold off