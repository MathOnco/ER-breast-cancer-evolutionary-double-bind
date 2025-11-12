% exponential growth w/ freq dep growth rate:
function xdot = EGA_ODE(t,x,a,b,c,d)
    S= x(1); R= x(2);
    
    fS = S / (S + R);
    fR = R / (S + R);

    xdot(1,1) =  S*(a*fS + b*fR);
    xdot(2,1) =  R*(c*fS + d*fR);
end