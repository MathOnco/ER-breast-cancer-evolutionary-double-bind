function [p] = getLinearModel(X,Y)
    % linear model (on log-log):
    model = @(x,p) p(1)*x + p(2);
    p = polyfit(log10(X),log10(Y),1);

end
