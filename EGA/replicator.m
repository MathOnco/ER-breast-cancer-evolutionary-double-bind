function xdot = replicator(t,x,A)   
    f1 = A(1,1)*x(1) + A(1,2)*x(2);
    f2 = A(2,1)*x(1) + A(2,2)*x(2);
    phi = f1.*x(1) + f2.*x(2);
    
    xdot(1,1) = x(1)* ( f1 - phi ) ; 
    xdot(2,1) = x(2)* ( f2 - phi ) ;    
end