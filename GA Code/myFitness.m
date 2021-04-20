%% Função Fitness
%myFitness([-5.777057566444397e+06 -2.316175794493771e+07])
function adapt = myFitness(x)
format long
adapt = -1.*(0.5+((((sin (sqrt (x(1).^2+x(2).^2) )).^2) - 0.5)/...
    (1 + 0.001.*(x(1).^2+x(2).^2)).^2));
end
