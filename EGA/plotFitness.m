function [a,b,c,d,point_x,point_y] = plotFitness(foldername,ti,Nf,Nr,fraction,TIME_INDEX)
    green = [0,133,66]/255; red = [214, 45, 36]/255;

    [a,b,c,d,point_x,point_y,fFit,sFit,rFit,fraction,fitnessS,fitnessR] = getLandscape(foldername,ti,Nf,Nr,fraction,TIME_INDEX);
    
    % ignore S=0
    fractionS = fraction(1:end-1);
    fitnessS=fitnessS(:,1:end-1);
    
    % ignore R=0
    fractionR = fraction(2:end);
    fitnessR=fitnessR(:,2:end); 
    
    figure(ti); hold on;
    plot(fFit,sFit,':','LineWidth',4,'Color',green);hold on;
    plot(fFit,rFit,':','LineWidth',4,'Color',red);hold on;
    
    
    %% plot error bars of growth rates
    ms = 40;
    
    [n,~]=size(fitnessS);
    
    if (n>1)
        errorbar(fractionS,mean(fitnessS),std(fitnessS),'.','MarkerSize',ms,'Color',green,'LineWidth',3);hold on;
        errorbar(fractionR,mean(fitnessR),std(fitnessR),'.','MarkerSize',ms,'Color',red,'LineWidth',3);
    else
        plot(fractionS,fitnessS,'.','MarkerSize',ms,'Color',green);hold on;
        plot(fractionR,fitnessR,'.','MarkerSize',ms,'Color',red);
    end
        
    clean();
    
    %% you can adjust the x-axis everytime, since we are on [0,1]:
    del=0.1;
    xlim([-del,1.0+del]);

end