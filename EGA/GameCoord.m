function[x1,x2,y1,y2]=GameCoord(fit_L,fit_R)
    [y1,y2]=IndepDiff([fit_R(2),fit_R(4)],[fit_L(2),fit_L(4)]);
    [L1,L2]=FitRightPoint(fit_L);
    [R1,R2]=FitRightPoint(fit_R);
    [x1,x2]=IndepDiff([L1,L2],[R1,R2]);
end