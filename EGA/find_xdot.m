function [xdot1,xdot2,phi] = find_xdot(x,A)   
    f1 = A(1,1).*(1-x) + A(1,2).*x;
    f2 = A(2,1).*(1-x) + A(2,2).*x;
    phi = f1.*(1-x) + f2.*x;
    
    xdot1 = (1-x).* ( f1 - phi ) ; 
    xdot2 = x.* ( f2 - phi ) ;    
end