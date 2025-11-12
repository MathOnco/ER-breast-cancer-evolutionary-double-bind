% called w/in plotFitness, but doesn't plot
function [a,b,c,d,point_x,point_y,fFit,sFit,rFit,fraction,fitnessS,fitnessR] = getLandscape(foldername,ti,Nf,Nr,fraction,TIME_INDEX)

    % Nr trials, Nf fractions
    fitnessS = zeros(Nr,Nf);
    fitnessR = zeros(Nr,Nf); 
    
    for fi=1:Nf
        % gS & gR are dim: [1,Nr]
        [gS,gR,~,~,~,~,~,~,~] = getFitness(foldername,ti,fi,Nr,TIME_INDEX);
        fitnessS(:,fi) = gS';
        fitnessR(:,fi) = gR';
    end


    % use actual fraction seeded, rather than predicted fR.
    fraction = getEffectiveFraction(foldername,ti,Nf,Nr)


    %% plot best fit of fitness:
    [a,b,c,d,fFit,sFit,rFit,point_x,point_y] = getGame(fraction(1:end-1),fraction(2:end),fitnessS(:,1:end-1),fitnessR(:,2:end)); 

end