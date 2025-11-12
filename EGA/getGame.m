function [a,b,c,d,fFit,sFit,rFit,point_x,point_y,rav,rbv,gav,gbv] = getGame(fractionS,fractionR,fitnessS,fitnessR)

[n,m]=size(fitnessS);
errorS=0;
errorR=0;

if (n>1)
    errorS=sqrt(var(fitnessS));
    errorR=sqrt(var(fitnessR));
    fitnessS=mean(fitnessS);
    fitnessR=mean(fitnessR);
    
end



% see here for a nice reminder on the linear algebra prblm:
% https://medium.com/@andrew.chamberlain/the-linear-algebra-view-of-least-squares-regression-f67044b7f39b

%% Sensitive fitness: (linear algebra problem)
A=[fractionS',zeros(length(fractionS),1)+1];
B=fitnessS';
[p,stdx,mse,COV]=lscov(A,B,1./errorS);

% payoffs:
a = p(2);
b = p(1)+a;

% convert to Artem's naming convention:
rb=b;
ra=a-rb;
rav=COV(1,1); rabv=COV(1,2);rbv=COV(2,2);

% export variance of a, b:
av = rav; bv = rbv;

%% Resistant fitness: (linear algebra problem)
A=[fractionR',zeros(length(fractionR),1)+1];
B=fitnessR';
[p,stdx,mse,COV]=lscov(A,B,1./errorR);

% payoffs:
c = p(2);
d = p(1)+c;

% convert to Artem's naming convention:
gb=d;
ga=c-gb;
gav=COV(1,1); gabv=COV(1,2);gbv=COV(2,2);

fit_L=[ra, rb, rav, rbv, rabv];
fit_R=[ga, gb, gav, gbv, gabv];

[x1,x2,y1,y2]=GameCoord(fit_L,fit_R);
point_x=[-x1,sqrt(x2)]; % convert variance to error
point_y=[-y1,sqrt(y2)]; % convert variance to error


%% best fit line:
fFit = 0:0.01:1;
sFit = (b-a)*fFit + a;
rFit = (d-c)*fFit + c;

%% old method:
% p1 = polyfit(fractionS,fitnessS,1)
% p2 = polyfit(fractionR,fitnessR,1);
 
% plt.errorbar(game_x,game_y,xerr = game_xe, yerr = game_ye, fmt='k.')


end




 

 
