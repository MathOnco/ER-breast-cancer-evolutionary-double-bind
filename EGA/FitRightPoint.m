function [out, out_v]=FitRightPoint(fit)
    out = fit(1) + fit(2);
    out_v = fit(3) + fit(4) + 2*fit(5);  
end