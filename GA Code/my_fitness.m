function  y = my_fitness ( population )
format long
% population is a matrix of random numbers [0,1], the following operation changes the range to [-1,1]
%population = 2  * (population -  0.5 )
y = (0.5+((((sin (sqrt (population(1).^2+population(2).^2) )).^2) - 0.5)/...
    (1 + 0.001*(population(1).^2+population(2).^2)).^2));
%y = sum(population.^2, 2 ) % sum of squares of rows
end
% % Função Fitness
% myFitness([-5.777057566444397e+06 -2.316175794493771e+07])
% function y = my_fitness(x)
% format long
% x = 2  * (x -  0.5 );
% y = (0.5+((((sin (sqrt (x(1).^2+x(2).^2) )).^2) - 0.5)/...
%     (1 + 0.001*(x(1).^2+x(2).^2)).^2));
% end