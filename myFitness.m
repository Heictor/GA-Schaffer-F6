%% fitness function
function adaptation = myFitness(x)
format long
%adaptation = 100 * (x(1)^2-x(2))^2+(1-x(1))^2;

adaptation = 0.5-((((sin (sqrt (x(1).^2+x(2).^2) )).^2) - 0.5)/(1 + 0.001.*(x(1).^2+x(2).^2)).^2);
% fact1 = (((sin (sqrt (x.^2+y.^2) )).^2) - 0.5);
% fact2 = (1 + 0.001.*(x.^2+y.^2)).^2;
% adaptation = 0.5 - fact1./fact2;
end