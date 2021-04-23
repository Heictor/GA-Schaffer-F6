%% Código para a plotagem da Função F6 de Schaffer
clc, clear, close all

x = -100:.1:100;
y = -100:.1:100;
[x,y] = meshgrid(x,y);
Num = (((sin (sqrt (x.^2+y.^2) )).^2) - 0.5);
Den = (1 + 0.001.*(x.^2+y.^2)).^2;

f = 0.5 - (((sin (sqrt (x.^2+y.^2) )).^2) - 0.5)./(1 + 0.001.*(x.^2+y.^2)).^2;
%f = 0.5 - Num./Den;
m = islocalmin(f);
n = islocalmin(x);
k = islocalmin(y);

figure(1)
hold on
mesh(x,y,f)
% scatter3(x(0),y(0),f(m),'*r')
xlabel('Eixo das Abscissas')
ylabel('Eixo das Ordenadas')
legend('Schaffer')
grid on
hold off

figure(2)
hold on
x = -100:.1:100;

f = 0.5 - (((sin (sqrt (x.^2+y.^2) )).^2) - 0.5)./(1 + 0.001.*(x.^2+y.^2)).^2;
% plot(x,f,'-o','k')
%scatter3(x(0),y(0),f(m),'*r')
plot(x,f,'--gs',...
    'LineWidth',0.2,...
    'MarkerSize',0.01,...
    'MarkerEdgeColor','b',...
    'MarkerFaceColor',[0.5,0.5,0.5])
title('Função de Schaffer em 2D')
xlabel('Eixo das Abscissas')
ylabel('Eixo das Ordenadas')
legend('Schaffer')
grid on
hold off
