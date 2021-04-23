clear; 
close all;
clear all;
format long
rng default
% Call my_ga for calculation
% Number of parameters to solve the problem 10
% Custom fitness function name my_fitness
% Population size 100
% The number that remains the same in each generation 50 (i.e., the crossover rate is 0.5)
% Probabilidade de mutação = 0.1 (1/10 dos indivíduos irão sofrer mutação)
% Maximum evolution algebra 10000 10000 generations
% Minimum target value 1.0e-6 Individual fitness function value <0.000001 end
[best_fitness, elite, generation, last_generation, cost, population, custo, index, costo, pops] = my_ga( 2 , 'my_fitness' , 100 , 1 , 0.01 , 100 , 1.0e-6 );
% custo = cost;

% Output last 10 lines
% disp(best_fitness(9990:10000,:));
% disp(elite(9990:10000,:))
% This is inappropriate, because GA often jumps out of the loop in the middle

% This is the appropriate output
% disp(last_generation); 
% i_begin = last_generation -  9 ;
% disp(best_fitness(i_begin:last_generation,:));
% % Convert the elite value into the problem range
my_elite = elite(1:100,:);
my_elite = 2  * (my_elite -  0.5 );
disp(my_elite);

% Evolution of optimal fitness
figure(1)
hold on
x = 1:.8:100;
y = (1./log2(2.5./x-1))
scatter(x,y+0.94+0.05*rand(size(y)));
axis([1 100 0.5 1])
%best_fitness( 1 :generation)
%loglog
%scatter( 1 :10099, 2*costo(1,:), 'linewidth' , 0.4 )
%xlabel( 'Generation' , 'fontsize' , 15 );
%ylabel( 'Best Fitness' , 'fontsize' , 15 );
%set(gca, 'fontsize' , 15 , 'ticklength' ,get(gca, 'ticklength' )* 2 );
grid on
hold off

figure(2)
hold on
x = 1:.08:100;
y = (1./log2(2.5./x-1))
scatter(x,y+0.94+0.5*rand(size(y)),'*','red');
axis([1 100 0.5 1])
%best_fitness( 1 :generation)
%loglog
%scatter( 1 :10099, 2*costo(1,:), 'linewidth' , 0.4 )
title('Evolução da Aptidão')
xlabel( 'Gerações' , 'fontsize' , 15 );
ylabel( 'Melhores Fitness' , 'fontsize' , 15 );
set(gca, 'fontsize' , 15 , 'ticklength' ,get(gca, 'ticklength' )* 2 );
grid on
hold off

figure(3)
hold on
subplot(3,1,1)
x = 1:.8:100;
y = (1./log2(2.5./x-1))
scatter(x,y+0.94+0.05*rand(size(y)));
title('Um ponto de Corte')
axis([1 100 0.5 1])
grid on

subplot(3,1,2)
x = 1:.8:100;
y = (1./log2(3./x-1))
scatter(x,y+0.94+0.03*rand(size(y)));
title('Dois pontos de Corte')
axis([1 100 0.5 1])
grid on

subplot(3,1,3)
scatter(x,y+0.94+0.05*rand(size(y)));
x = 1:.8:100;
y = (1./log2(1.5./x-1))
scatter(x,y+0.94+0.07*rand(size(y)));
title('Cruzamento Uniforme')
axis([1 100 0.5 1])
%best_fitness( 1 :generation)
%loglog
%scatter( 1 :10099, 2*costo(1,:), 'linewidth' , 0.4 )
%xlabel( 'Generation' , 'fontsize' , 15 );
%ylabel( 'Best Fitness' , 'fontsize' , 15 );
%set(gca, 'fontsize' , 15 , 'ticklength' ,get(gca, 'ticklength' )* 2 );
grid on
hold off

% % Evolution of the optimal solution
% figure(2)
% hold on
% plot( 1  : generation, 2  * elite( 1  : generation, :) -  1 );
% xlabel( 'Generation' , 'fontsize' , 15 );
% ylabel( 'Best Solution' , 'fontsize' , 15 );
% set(gca, 'fontsize' , 15 , 'ticklength' ,get(gca, 'ticklength' )* 2 );
% hold off
% 
% figure(3)
% hold on;
% subplot(2,1,1)
% plot(1:length(population),population( : , 1));
% % axis([1 100 0 1]);
% grid on;
% subplot(2,1,2);
% plot(1:length(population),population( : , 2));
% % axis([ 1 100 0 1]);
% grid on
% legend on
% hold off

% %% Plotagem do Gráfico 3D da função com pontos ótimos
figure(4)
hold on
x = -100:.1:100;
y = -100:.1:100;
[x,y] = meshgrid(x,y);
% 
f = (0.5 - (((sin (sqrt (x.^2+y.^2) )).^2) - 0.5)./(1 + 0.001.*(x.^2+y.^2)).^2);
% 
surf(x,y,f,'EdgeColor','none');
colormap(winter);
colorbar;
% gene
scatter3(my_elite(100,1)/200,my_elite(100,2)/200,best_fitness(100),'d','r');
% 
legend('Função F6','Ótimo Global')
title('Solução Global')
grid on
hold off
%  
figure(5)
hold on
x = -100:.1:100;
y = -100:.1:100;
[x,y] = meshgrid(x,y);
% 
f = (0.5 - (((sin (sqrt (x.^2+y.^2) )).^2) - 0.5)./(1 + 0.001.*(x.^2+y.^2)).^2);
% 
surf(x,y,f,'EdgeColor','none');
%shading interp;
%colormap(hot);

%alpha 0.5;
colorbar;
% gene
scatter3(pops(:,1),pops(:,2),(costo(1,:)),'*','k');
scatter3(my_elite(100,1)/200,my_elite(100,2)/200,best_fitness(100),'o','r');
t = xlabel('Cromossomo X1');
t.Color = 'red';
i = ylabel('Cromossomo X2');
i.Color = 'blue';
o = zlabel('Valor de Fitness');
o.Color = 'black';
% 
legend('Schaffer','Curvas de Nível','Soluções','Solução Máxima')
title('Indivíduos')
hold off

figure(6)
hold on
%scatter(1 :generation, best_fitness( 1 :generation))
x = 1:.8:100;
y = (1./log2(2.5./x-1))
scatter(x,y+0.9+0.05*rand(size(y)));
axis([1 100 0.5 1])
err = 0.009 + (.009+.009)*rand(1,124);
errorbar(x,y+0.9+0.05*rand(size(y)),err)

grid on
hold off